import _ from 'lodash'
import { useState, useEffect } from 'react'
import h from 'react-hyperscript'
# import '../src/css/index.css'
import '../src/css/bootstrap.min.css'
import { NavBar, NavList } from './parts/navbar'
import {TestTable} from './parts/sticky_table'
import ViteApp from './parts/vite'

nav_list = [
  {name: 'StickyTable', component: TestTable}
  {name: 'Vite', component: ViteApp}
]

NavApp = ()->

App = ()->
  [selected_nav, setNav] = useState nav_list[0]
  useEffect ()->
    console.log selected_nav
    return
  , []

  h '.container-fluid',
    style:
      padding: 0
  , [
    h NavBar, {
      title: 'Vite'
      collapse_items: [
        h NavList, {
          nav_list
          default_index: 0
          select_nav: setNav
        }
      ]
    }
    if selected_nav?.component
      h selected_nav.component, {}
  ]

export default App
