import React, { useState } from 'react';

const DynamicTable = () => {
  const [rows, setRows] = useState([{ id: 1, data: ['', '', '', '', ''] }]);

  // Function to add a new row
  const addRow = () => {
    const newRow = { id: rows.length + 1, data: ['', '', '', '', ''] };
    setRows([...rows, newRow]);
  };

  // Function to remove a row by ID
  const removeRow = (id) => {
    const updatedRows = rows.filter(row => row.id !== id);
    setRows(updatedRows);
  };

  return (
    <div>
      <div className='text-2xl font-bold'>bhootni ke</div>
      <table>
        <thead>
          <tr>
            <th>Column 1</th>
            <th>Column 2</th>
            <th>Column 3</th>
            <th>Column 4</th>
            <th>Column 5</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {rows.map((row, index) => (
            <tr key={row.id}>
              {row.data.map((cell, cellIndex) => (
                <td key={cellIndex}>
                  <input
                    type="text"
                    value={cell}
                    onChange={(e) => {
                      const newData = [...row.data];
                      newData[cellIndex] = e.target.value;
                      const updatedRows = [...rows];
                      updatedRows[index].data = newData;
                      setRows(updatedRows);
                    }}
                  />
                </td>
              ))}
              <td>
                <button onClick={() => removeRow(row.id)}>Remove</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <button onClick={addRow}>Add Row</button>
    </div>
  );
};

export default DynamicTable;
