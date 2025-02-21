import streamlit as st
import pandas as pd
import requests
import random

def fetch_ncs():
    url = 'http://18.219.73.187:8080/api/non-compliances'
    try:
        response = requests.get(url, headers={'accept': 'application/json', 'Category': 'TODOS'})
        if response.status_code == 200:
            return response.json()
        else:
            st.error(f"Erro ao buscar NCs: {response.status_code}")
            return []
    except requests.exceptions.RequestException as e:
        st.error(f"Erro de conexão: {e}")
        return []

def fetch_sectors():
    url = 'http://18.219.73.187:8080/api/sectors'
    try:
        response = requests.get(url, headers={'accept': 'application/json'})
        if response.status_code == 200:
            return response.json()
        else:
            st.error(f"Erro ao buscar setores: {response.status_code}")
            return []
    except requests.exceptions.RequestException as e:
        st.error(f"Erro de conexão: {e}")
        return []

def run():
    st.title('NCS Inseridas')
    
    setores_data = fetch_sectors()
    setores_nomes = [setor['name'] for setor in setores_data] if setores_data else ['Setor Desconhecido']
    
    if 'ncs_data' not in st.session_state:
        ncs_api_data = fetch_ncs()
        if ncs_api_data:
            random.shuffle(ncs_api_data)  
            st.session_state.ncs_data = pd.DataFrame(ncs_api_data[:random.randint(0, 25)])  
        else:
            st.session_state.ncs_data = pd.DataFrame(columns=[
                'id', 'nc_title', 'nc_description', 'category', 'technical_base', 'legal_base', 'infraction', 'recommendation', 'sector'
            ])
        
        if 'sector' not in st.session_state.ncs_data.columns:
            st.session_state.ncs_data['sector'] = [random.choice(setores_nomes) for _ in range(len(st.session_state.ncs_data))]
    
    setor_selecionado = st.selectbox("Selecione o Setor", sorted(setores_nomes))
    ncs_filtradas = st.session_state.ncs_data[st.session_state.ncs_data['sector'] == setor_selecionado]
    
    with st.expander("Adicionar NC"):
        col1, col2 = st.columns(2)
        with col1:
            nc_title = st.text_input("Título NC")
            nc_description = st.text_area("Descrição NC")
            category = st.text_input("Categoria")
        with col2:
            technical_base = st.text_input("Base Técnica")
            legal_base = st.text_input("Base Legal")
            infraction = st.text_input("Infração")
            recommendation = st.text_area("Recomendação")
            sector = st.selectbox("Setor", setores_nomes)
            nc_id = random.randint(1000, 9999)
        
        if st.button("Adicionar NC"):
            new_nc = {
                'id': nc_id,
                'nc_title': nc_title,
                'nc_description': nc_description,
                'category': category,
                'technical_base': technical_base,
                'legal_base': legal_base,
                'infraction': infraction,
                'recommendation': recommendation,
                'sector': sector
            }
            st.session_state.ncs_data = pd.concat([st.session_state.ncs_data, pd.DataFrame([new_nc])], ignore_index=True)
            st.success("NC adicionada com sucesso!")
    
    # Editar e excluir NC
    if not ncs_filtradas.empty:
        st.subheader("Lista de NCs")
        for index, row in ncs_filtradas.iterrows():
            with st.expander(f"{row['nc_title']} (ID: {row['id']})"):
                col1, col2 = st.columns(2)
                with col1:
                    new_title = st.text_input("Título NC", row['nc_title'], key=f"titulo_{index}")
                    new_desc = st.text_area("Descrição NC", row['nc_description'], key=f"desc_nc_{index}")
                with col2:
                    new_base_legal = st.text_input("Base Legal", row['legal_base'], key=f"base_legal_{index}")
                    new_category = st.text_input("Categoria", row['category'], key=f"category_{index}")
                    new_sector = st.selectbox("Setor", setores_nomes, index=setores_nomes.index(row['sector']) if row['sector'] in setores_nomes else 0, key=f"sector_{index}")
                
                if st.button("Salvar Alterações", key=f"salvar_{index}"):
                    st.session_state.ncs_data.at[index, 'nc_title'] = new_title
                    st.session_state.ncs_data.at[index, 'nc_description'] = new_desc
                    st.session_state.ncs_data.at[index, 'legal_base'] = new_base_legal
                    st.session_state.ncs_data.at[index, 'category'] = new_category
                    st.session_state.ncs_data.at[index, 'sector'] = new_sector
                    st.success("NC editada com sucesso!")
                
                if st.button("Excluir NC", key=f"excluir_{index}"):
                    st.session_state.ncs_data = st.session_state.ncs_data.drop(index).reset_index(drop=True)
                    st.warning("NC excluída!")
                    st.experimental_rerun()