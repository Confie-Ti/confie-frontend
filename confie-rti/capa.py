from reportlab.lib.styles import ParagraphStyle
from reportlab.platypus import Paragraph, Spacer, Image, Table, TableStyle
from reportlab.lib import colors

def add_background(canvas, doc):
    bg_logo_path = "assets/background-pdf.png"  
    canvas.drawImage(bg_logo_path, 70, 250, width=400, height=400, mask='auto') 

def generate_capa(elements, styles):
    title_style = ParagraphStyle(name="title", alignment=1, fontSize=14, fontName="Helvetica-Bold")
    centered_style = ParagraphStyle(name="centered", alignment=1, fontSize=12)

    logo_conformetec_path = "assets/logo.png"  
    img_conformetec = Image(logo_conformetec_path, width=100, height=40) 
    img_conformetec.hAlign = 'RIGHT'
    elements.append(img_conformetec)

    elements.append(Spacer(1, 240)) 

    title = Paragraph("CONF10236261-RTIPIE USINA_R0", title_style)
    elements.append(title)

    elements.append(Spacer(1, 15))

    subtitle = Paragraph("RELATÓRIO TÉCNICO DE INSPEÇÃO NAS INSTALAÇÕES\nELÉTRICAS", centered_style)
    elements.append(subtitle)

    elements.append(Spacer(1, 15))

    date = Paragraph("AGOSTO DE 2024", centered_style)
    elements.append(date)

    elements.append(Spacer(1, 200))

    logo_cliente_path = "assets/logo.png"  
    img_cliente = Image(logo_cliente_path, width=50, height=50)

    table_data = [
        ["Cliente:", img_cliente, "", "BIOENERGÉTICA AROEIRA S.A.", "", ""],
        ["", "", "", "", "", ""],
        ["Pro.", "15/ago", "Nome", "L.R", "Local:", "TUPACIGUARA-MG"],
        ["Ver.", "15/ago", "", "", "Nº Doc.", "CONF10236261"],
        ["Apr.", "15/ago", "", "", "", ""],
        ["Rev.", "R0", "", "", "", ""]
    ]

    table = Table(table_data, colWidths=[50, 50, 50, 140, 50, 140])
    table.setStyle(TableStyle([
        ('GRID', (0, 0), (-1, -1), 1, colors.black),
        ('SPAN', (3, 0), (-1, 0)),  
        ('SPAN', (1, 0), (1, 1)),  
        ('SPAN', (2, 2), (2, 3)),  
        ('SPAN', (4, 2), (-1, 2)), 
        ('SPAN', (4, 3), (-1, 3)),  
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
    ]))
    elements.append(table)
