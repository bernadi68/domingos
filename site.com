<!DOCTYPE html>
<html lang="pt">

<head>
    <meta charset="UTF-8">
    <title>ANAMOLA - Moçambique | Cadastro de Membros</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
    <link
        href="https://fonts.googleapis.com/css2?family=Dancing+Script&family=Pacifico&family=Great+Vibes&family=Satisfy&family=Poppins&display=swap"
        rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #e8f5e9;
            margin: 0;
            padding: 0;
        }

        header {
            background: #006400;
            color: yellow;
            text-align: center;
            padding: 15px;
            font-size: 24px;
            font-weight: bold;
        }

        h2 {
            text-align: center;
            color: #006400;
            margin-top: 5px;
        }

        .container {
            display: flex;
            justify-content: space-between;
            margin: 20px;
            gap: 30px;
            flex-wrap: wrap;
        }

        form {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 45%;
            min-width: 350px;
        }

        form div {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        label {
            width: 48%;
            font-size: 14px;
        }

        input,
        select {
            width: 100%;
            padding: 6px;
            margin-top: 4px;
        }

        .card-container {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .card {
            position: relative;
            width: 85mm;
            height: 54mm;
            background: #006400;
            color: yellow;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
            overflow: hidden;
            padding: 10px;
        }

        .card-front,
        .card-back {
            position: relative;
            width: 85mm;
            height: 54mm;
        }

        .logo {
            position: absolute;
            top: 8px;
            right: 10px;
            width: 18mm;
            height: 18mm;
            object-fit: contain;
            background: #fff;
            border-radius: 3px;
        }

        .photo {
            width: 25mm;
            height: 30mm;
            border: 1px solid #fff;
            object-fit: cover;
            background: #fff;
            position: absolute;
            left: 8px;
            top: 12mm;
        }

        .card-info {
            position: absolute;
            top: 12mm;
            left: 40mm;
            font-size: 11px;
            line-height: 1.3;
        }

        .footer {
            position: absolute;
            bottom: 5px;
            left: 0;
            width: 100%;
            text-align: center;
            font-weight: bold;
            font-size: 13px;
        }

        #qrcode {
            position: absolute;
            bottom: 5px;
            right: 5px;
            width: 20mm;
            height: 20mm;
            background: #fff;
            padding: 3px;
        }

        .buttons {
            margin-top: 15px;
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        button {
            background: #006400;
            color: yellow;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
        }

        button:hover {
            background: #004d00;
        }

        #lista {
            margin: 20px;
            background: #fff;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        .cartao-item {
            background: #c8e6c9;
            padding: 8px;
            margin: 5px 0;
            border-radius: 5px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .assinatura-img {
            display: block;
            margin: 6px auto 2px;
            width: 45mm;
            max-height: 18mm;
            object-fit: contain;
            background: #fff;
            padding: 2px;
            border-radius: 4px;
        }

        .assinatura {
            border-top: 1px solid yellow;
            width: 60%;
            margin: 8px auto 6px;
            padding-top: 6px;
            color: yellow;
            font-size: 12px;
            text-align: center;
        }

        #assinaturaCanvas {
            border: 1px solid #fff;
            background: #006400;
            display: block;
            margin: 5px auto;
        }

        .font-select {
            margin-top: 5px;
        }

        .watermark {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            opacity: 0.1;
            width: 40mm;
            height: 40mm;
            object-fit: contain;
            pointer-events: none;
        }
    </style>
</head>

<body>
    <header>ANAMOLA - MOÇAMBIQUE</header>
    <h2>Bem-vindo ao Partido ANAMOLA — Cadastro dos Membros do Partido ANAMOLA</h2>

    <div class="container">
        <form id="form">
            <div>
                <label>Nome Completo:<br><input type="text" id="nome"></label>
                <label>Data de Nascimento:<br><input type="date" id="data"></label>
            </div>
            <div>
                <label>Província:<br><input type="text" id="provincia"></label>
                <label>Distrito:<br><input type="text" id="distrito"></label>
            </div>
            <div>
                <label>Bairro:<br><input type="text" id="bairro"></label>
                <label>Contacto:<br><input type="text" id="contacto"></label>
            </div>
            <div>
                <label>Foto tipo passe:<br><input type="file" id="foto" accept="image/*"></label>
                <label>Logo do partido:<br><input type="file" id="logo" accept="image/*"></label>
            </div>
            <div>
                <label>Assinatura digital:<br><input type="file" id="assinatura" accept="image/*"></label>
                <div style="width:48%"></div>
            </div>
            <div>
                <label>Assinatura digitada:<br><input type="text" id="assinaturaText"></label>
                <label>Fonte:<br>
                    <select id="fontSelect" class="font-select">
                        <option value="'Dancing Script', cursive">Dancing Script</option>
                        <option value="'Pacifico', cursive">Pacifico</option>
                        <option value="'Great Vibes', cursive">Great Vibes</option>
                        <option value="'Satisfy', cursive">Satisfy</option>
                        <option value="'Poppins', sans-serif">Poppins</option>
                    </select>
                </label>
            </div>
            <div class="buttons">
                <button type="button" onclick="gerarNumero()">Gerar Nº Cartão</button>
                <button type="button" onclick="gerarQRCode()">Gerar Código</button>
                <button type="button" onclick="guardarCartao()">Guardar</button>
                <button type="button" onclick="listarCartoes()">Listar</button>
                <button type="button" onclick="exportarPDF()">Exportar PDF</button>
                <button type="button" onclick="imprimirCartao()">Imprimir</button>
            </div>
        </form>

        <div class="card-container">
            <!-- Frente -->
            <div class="card card-front">
                <img src="" class="watermark" id="watermark" alt="Marca d'água">
                <img src="" class="logo" id="logoView" alt="Logo">
                <img src="" class="photo" id="fotoView" alt="Foto tipo passe">
                <h3 style="text-align:center;margin-top:3mm;">CARTÃO DE MEMBRO</h3>
                <div class="card-info">
                    <p><strong>Nº:</strong> <span id="num"></span></p>
                    <p><strong>Nome:</strong> <span id="vNome"></span></p>
                    <p><strong>Nasc.:</strong> <span id="vData"></span></p>
                    <p><strong>Prov.:</strong> <span id="vProv"></span></p>
                    <p><strong>Dist.:</strong> <span id="vDist"></span></p>
                    <p><strong>Bairro:</strong> <span id="vBairro"></span></p>
                    <p><strong>Contacto:</strong> <span id="vContato"></span></p>
                </div>
                <div id="qrcode"></div>
                <div class="footer">PARTIDO ANAMOLA</div>
            </div>

            <!-- Verso -->
            <div class="card card-back">
                <h3 style="text-align:center;">PARTIDO ANAMOLA</h3>
                <p style="text-align:center;font-style:italic;">"Unidos pelo desenvolvimento de Moçambique"</p>
                <p style="font-size:11px;padding:0 6px;text-align:center;">O portador deste cartão é membro oficial do
                    Partido ANAMOLA, comprometido com os ideais de justiça, progresso e unidade nacional.</p>

                <img id="assinaturaView" class="assinatura-img" src="" alt="Assinatura">
                <div id="assinaturaDigitada" class="assinatura"></div>
                <p style="font-size:10px;margin-top:4px;text-align:center;">Contactos do Partido: +258 XXXXXX •
                    email@anamola.org</p>
            </div>
        </div>
    </div>

    <div id="lista"></div>

    <script>
        const $ = id => document.getElementById(id);
        function gen12() { let s = ''; for (let i = 0; i < 12; i++)s += Math.floor(Math.random() * 10); return s; }
        const nome = $('nome'), data = $('data'), provincia = $('provincia'), distrito = $('distrito'),
            bairro = $('bairro'), contacto = $('contacto');
        const foto = $('foto'), logo = $('logo'), assinatura = $('assinatura'), assinaturaText = $('assinaturaText'), fontSelect = $('fontSelect');
        const fotoView = $('fotoView'), logoView = $('logoView'), watermark = $('watermark'), assinaturaView = $('assinaturaView'), assinaturaDigitada = $('assinaturaDigitada');
        const num = $('num'), vNome = $('vNome'), vData = $('vData'), vProv = $('vProv'), vDist = $('vDist'), vBairro = $('vBairro'), vContato = $('vContato');

        function atualizarCartao() {
            vNome.innerText = nome.value; vData.innerText = data.value; vProv.innerText = provincia.value;
            vDist.innerText = distrito.value; vBairro.innerText = bairro.value; vContato.innerText = contacto.value;
            assinaturaDigitada.innerText = assinaturaText.value;
            assinaturaDigitada.style.fontFamily = fontSelect.value;
        }

        ['nome', 'data', 'provincia', 'distrito', 'bairro', 'contacto', 'assinaturaText', 'fontSelect'].forEach(id => $(id).addEventListener('input', atualizarCartao));

        function readFileToImg(file, imgEl) { if (!file) { imgEl.src = ''; return; } const reader = new FileReader(); reader.onload = e => imgEl.src = e.target.result; reader.readAsDataURL(file); }
        foto.addEventListener('change', () => readFileToImg(foto.files[0], fotoView));
        logo.addEventListener('change', () => { readFileToImg(logo.files[0], logoView); readFileToImg(logo.files[0], watermark); });
        assinatura.addEventListener('change', () => readFileToImg(assinatura.files[0], assinaturaView));

        function gerarNumero() { num.innerText = gen12(); }
        function gerarQRCode() { document.getElementById('qrcode').innerHTML = ''; new QRCode(document.getElementById("qrcode"), { text: `Nº:${num.innerText}\nNome:${nome.value}\nNasc:${data.value}\nProv:${provincia.value}\nDist:${distrito.value}\nBairro:${bairro.value}\nContacto:${contacto.value}`, width: 60, height: 60 }); }

        function loadSaved() { return JSON.parse(localStorage.getItem('cartoes')) || []; }
        function saveAll(arr) { localStorage.setItem('cartoes', JSON.stringify(arr)); }

        function guardarCartao() {
            if (!num.innerText) gerarNumero();
            const c = { numero: num.innerText, nome: nome.value, data: data.value, provincia: provincia.value, distrito: distrito.value, bairro: bairro.value,
