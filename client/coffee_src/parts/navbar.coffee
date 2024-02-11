import h from 'react-hyperscript'
import React, {useState, useEffect} from 'react'

NavItemDropDown = ({name, dropdown_list, active, select_index, select_nav})->
  [open_drop, setOpenDrop] = useState(true)

  h 'li.nav-item.dropdown',
    key: 'nav_item_dropdown'
    className: if active then 'active'
  , [
    h 'a.nav-link.dropdown-toggle',
      onClick: (e)->
        e.preventDefault()
        select_index()
        setOpenDrop(true)
    , name
    if active and open_drop
      h '.dropdown-menu.show', dropdown_list.map (item)->
        h 'a.dropdown-item',
          href: '#'
          onClick: (e)->
            e.preventDefault()
            select_nav(item)
            setOpenDrop(false)
        , item.name
  ]

export NavList = ({nav_list, default_index, select_nav})->
  [selected_index, setIndex] = useState(default_index)
  [openDrop, setOpenDrop] = useState(false)

  h 'ul.navbar-nav.mr-auto',
    key: 'nav_list'
  , nav_list.map (item, i)->
    if item.dropdown_list?
      h NavItemDropDown, {
        name: item.name
        dropdown_list: item.dropdown_list
        active: if selected_index == i then true
        select_index: ()-> setIndex(i)
        select_nav: select_nav
      }
    else
      h 'li.nav-item',
        className: if selected_index == i then 'active'
      , [
          h 'a.nav-link',
            onClick: (e)->
              e.preventDefault()
              setIndex(i)
              select_nav(item)
          , item.name
        ]

export NavBar =({title, bar_left, collapse_items})->
  [collapse, setCollapse] = useState(true)

  useEffect ()->
    document.title = title
    return
  , []

  h "nav.navbar.navbar-expand-md.bg-dark.navbar-dark", [
      h 'a.navbar-brand.text-light', title
      h 'button.navbar-toggler',
        onClick: (e)->
          e.preventDefault()
          setCollapse !collapse
      , [h 'span.navbar-toggler-icon']
      if bar_left
        bar_left
      h '.navbar-collapse',
        className: if collapse then 'collapse' else 'in'
      , collapse_items
    ]


