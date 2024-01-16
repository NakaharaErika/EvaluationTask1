document.addEventListener('DOMContentLoaded', function () {
    const showModal = document.getElementById('modalTrigger').getAttribute('data-show-modal') === 'true';
    if (showModal) {
        const myModal = new bootstrap.Modal(document.getElementById('modalOptionAdd'));
        myModal.show();
    }
});


let selectedRow = null;
function changeColor(row) {
    // 以前に選択された行があれば、クラスを削除
    if (selectedRow) {
        selectedRow.classList.remove('selected-row');
    }
    // 新しい行にクラスを追加し、選択された行を記録
    row.classList.add('selected-row');
    selectedRow = row;
}

const priceInput = document.getElementById('price');
if (priceInput) {
    priceInput.addEventListener('input', function (event) {
        let value = event.target.value;

        // 最初の0を削除
        value = value.replace(/^0+/, '');
        // 全ての非数字を削除
        value = value.replace(/[^\d]/g, '');
        // 3桁ごとにカンマ区切りにする
        value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        event.target.value = value;
    });
}

document.getElementById('selectAll').addEventListener('click', function() {
    const checkboxes = document.querySelectorAll('input[type="checkbox"][name="bookStatus"]');
    checkboxes.forEach(function(checkbox) {
        checkbox.checked = true;
    });
});