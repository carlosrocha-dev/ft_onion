function generateCPF() {
    const n = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;

    const mod = (base, div) => Math.round(base - Math.floor(base / div) * div);

    const genDigit = (cpf, factor) => {
        let total = 0;
        for (let i = 0; i < cpf.length; i++) {
            total += cpf[i] * factor--;
        }
        let modResult = mod(total * 10, 11);
        return modResult === 10 ? 0 : modResult;
    };

    const cpfBase = Array.from({length: 9}, () => n(0, 9));
    const d1 = genDigit(cpfBase, 10);
    const d2 = genDigit([...cpfBase, d1], 11);
    const cpf = [...cpfBase, d1, d2].join('');
    const formattedCpf = cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, "$1.$2.$3-$4");

    document.getElementById('cpfDisplay').innerText = formattedCpf;
}
