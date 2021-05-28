document.addEventListener("DOMContentLoaded", () => {  

  const clickableRows = () => {
    const rows = document.querySelectorAll("table.clickable-table tr[data-href]");
    
    Array.prototype.forEach.call(rows, function(row, index, array){
      row.addEventListener('click', (e) => {
        console.log(e.currentTarget.dataset.href)
        window.location.href = e.currentTarget.dataset.href
      });
    });
  }
  
  clickableRows();

});
