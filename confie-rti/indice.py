from reportlab.lib import colors
from reportlab.platypus import Paragraph, Table, TableStyle
from reportlab.lib.units import mm

def generate_indice(elements, styles):
    data = [
        [Paragraph('1. OBJETIVO', styles['Normal']), '3'],
        [Paragraph('2. INTRODUÇÃO', styles['Normal']), '4'],
        [Paragraph('3. METODOLOGIA', styles['Normal']), '5'],
        [Paragraph('4. NORMAS', styles['Normal']), '6'],
        [Paragraph('5. DOCUMENTAÇÃO DAS INSTALAÇÕES ELÉTRICAS', styles['Normal']), '7']
    ]

    table = Table(data, colWidths=[400, 40])
    table.setStyle(TableStyle([
        ('TEXTCOLOR', (0, 0), (-1, -1), colors.black),
        ('ALIGN', (1, 0), (-1, -1), 'RIGHT'),
        ('FONT', (0, 0), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 12),
    ]))

    elements.append(Paragraph('<b>ÍNDICE</b>', styles['Title']))
    elements.append(table)

def add_bookmarks(canvas, doc):
    bookmarks = {
        3: "objetivo",
        4: "introducao",
        5: "metodologia",
        6: "normas",
        7: "documentacao"
    }

    if doc.page in bookmarks:
        canvas.bookmarkPage(bookmarks[doc.page])

    canvas.setFont("Helvetica", 10)
    canvas.drawString(20 * mm, 287 * mm, "CONF0323498 – PROJETO TESLA")  # Cabeçalho à esquerda
    canvas.drawString(190 * mm, 287 * mm, str(doc.page))  # Número da página à direita

    canvas.setFont("Helvetica", 8)
    footer_text = "Conformetec Assessoria Técnica para a Conformidade Elétrica\nRua Coronel Francisco Schmidt 1400, Sala 33 – Sertãozinho/SP CEP: 14160-710\nTelefone (16) 3524-8327"
    text_object = canvas.beginText(20 * mm, 10 * mm)
    for line in footer_text.split("\n"):
        text_object.textLine(line)
    canvas.drawText(text_object)
