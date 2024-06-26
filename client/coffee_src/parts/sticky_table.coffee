import _ from 'lodash'
import h from 'react-hyperscript'
import '../../src/css/sticky_table.css'

export Table = ({header, data})->
  # h 'div', [
  h '.sticky-table', [
    h 'table.zebra-table.border-table', [
    # h 'table.zebra-table.round-table', [
      h 'thead', [
        h 'tr', header.map (head)->
          h 'th', head
      ]
      h 'tbody', data.map (row, row_i)->
        h 'tr', row.map (col, col_i)->
          h 'td', col
    ]
  ]
  
export DivTable = ({header, data})->
  h 'div', [
    h '.div-table', [header].concat(data).map (row, row_i)->
      h '.div-tr', row.map (col, col_i)->
        h '.div-td', col
  ]
  
get_table_data = ()->
  row_len = 100
  col_len = 25
  data = _.range(row_len).map (row_i)-> _.range(col_len).map (col_i)-> "r#{row_i}_c#{col_i}"
  header = _.range(data[0].length).map (head)-> "h#{head}"
  {
    header
    data
  }

export TestTable = ()->
  {
    header
    data
  } = get_table_data()
  h Table, {header, data}

export TestDivTable = ()->
  {
    header
    data
  } = get_table_data()
  h DivTable, {header, data}

