from reportlab.lib.units import cm
import streamlit as st
import json
from io import BytesIO
import requests
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, PageBreak, Image as ReportLabImage, Spacer
from reportlab.lib import colors

from capa import generate_capa
from indice import generate_indice
from instalacao_eletrica import generate_documentacao
from introducao import generate_introducao
from metodologia import generate_metodologia
from normas import generate_normas
from objetivo import generate_objetivo


def load_mock_data():
    try:
        with open("data.json", "r", encoding="utf-8") as file:
            return json.load(file)
    except FileNotFoundError:
        st.error("Arquivo 'data.json' não encontrado.")
        return None
    except UnicodeDecodeError as e:
        st.error(f"Erro de codificação ao ler o arquivo 'data.json': {e}")
        return None


def download_image(image_url):
    try:
        response = requests.get(image_url)
        if response.status_code == 200:
            img_data = BytesIO(response.content)
            return ReportLabImage(img_data)
        else:
            return None
    except Exception as e:
        st.error(f"Erro ao baixar a imagem: {e}")
        return None


def add_header_and_footer(canvas, doc):
    canvas.setFont("Helvetica-Bold", 10)
    canvas.setFillColor(colors.green)
    canvas.drawString(20, 800, "CONF0323498 – PROJETO TESLA")
    canvas.drawRightString(550, 800, f"{doc.page}")
    footer_text = (
        "Conformetec Assessoria Técnica para a Conformidade Elétrica\n"
        "Rua Coronel Francisco Schmidt 1400, Sala 33 – Sertãozinho/SP  CEP: 14160-710\n"
        "Telefone (16) 3524-8327"
    )
    text_object = canvas.beginText(105, 15)
    for line in footer_text.split("\n"):
        text_width = canvas.stringWidth(line, "Helvetica", 9)
        text_object.setTextOrigin((A4[0] - text_width) / 2, text_object.getY())
        text_object.textLine(line)
    canvas.drawText(text_object)

def generate_pdf(project_data):
    buffer = BytesIO()
    doc = SimpleDocTemplate(buffer, pagesize=A4)
    styles = getSampleStyleSheet()

    styles.add(ParagraphStyle(name='BlueTitle', fontSize=14, textColor=colors.blue, spaceAfter=12))
    styles.add(ParagraphStyle(name='NCHeading', fontSize=12, textColor=colors.black, spaceAfter=10, alignment=1))  # Centro

    elements = []

    try:
        generate_capa(elements, styles)
        elements.append(PageBreak())  

        generate_indice(elements, styles)
        elements.append(PageBreak()) 

        generate_objetivo(elements, styles)
        elements.append(PageBreak())  

        generate_introducao(elements, styles)
        elements.append(PageBreak()) 

        generate_metodologia(elements, styles)
        elements.append(PageBreak())  
        
        generate_normas(elements, styles)
        elements.append(PageBreak())  

        generate_documentacao(elements, styles)
        elements.append(PageBreak())  

        for sector in project_data.get("sectors", []):
            for equipment in sector.get("equipments", []):
                equipment_title = f"Equipamento: {equipment['equipment_tag']}"
                equipment_location = f"Local: {equipment.get('location', 'N/A')}"
                elements.append(Paragraph(equipment_title, styles['BlueTitle']))
                elements.append(Paragraph(equipment_location, styles['BlueTitle']))

                if "image" in equipment and equipment["image"]:
                    image_url = equipment["image"][0]
                    img = download_image(image_url)
                    if img:
                        max_width, max_height = 14 * cm, 7 * cm
                        img_width, img_height = img.drawWidth, img.drawHeight
                        scale = min(max_width / img_width, max_height / img_height, 1.0)
                        img.drawWidth = img_width * scale
                        img.drawHeight = img_height * scale
                        elements.append(img)
                    else:
                        elements.append(Paragraph("Imagem não disponível", styles['Normal']))

                for nc in equipment.get("ncs", []):
                    elements.append(PageBreak())
                    elements.append(Paragraph(f"NC: {nc['nc_title']}", styles['NCHeading']))

                    elements.append(Paragraph(f"Descrição: {nc['nc_description']}", styles['Normal']))
                    elements.append(Paragraph(f"Base Técnica: {nc['technical_base']}", styles['Normal']))
                    elements.append(Paragraph(f"Base Legal: {nc['legal_base']}", styles['Normal']))
                    elements.append(Paragraph(f"Recomendação: {nc['recommendation']}", styles['Normal']))

        doc.build(elements, onFirstPage=add_header_and_footer, onLaterPages=add_header_and_footer)
        buffer.seek(0)
        return buffer

    except Exception as e:
        st.error(f"Erro: {e}")
        return None 


def run():
    st.title("Gerar Relatório PDF dos Equipamentos")

    if st.button("Gerar PDF"):
        project_data = load_mock_data()
        if project_data:
            pdf_buffer = generate_pdf(project_data)
            if pdf_buffer:
                st.download_button(
                    label="Baixar PDF",
                    data=pdf_buffer,
                    file_name="relatorio.pdf",
                    mime="application/pdf"
                )
                st.success("PDF gerado com sucesso!")
            else:
                st.error("Falha ao gerar o PDF.")
        else:
            st.error("Erro ao carregar os dados do arquivo.")

if __name__ == "__main__":
    run()
