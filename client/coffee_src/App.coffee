import { useState } from 'react'
import h from 'react-hyperscript'
import reactLogo from '../assets/react.svg'
import viteLogo from '/vite.svg'
import '../css/App.css'

App = ()->
  [count, setCount] = useState(0)
  h 'div', [
    h 'a',
      href: "https://vitejs.dev"
      target: "_blank"
    , [
        h 'img',
          src: viteLogo 
          className: "logo"
          alt: "Vite logo"
    ]
    h 'a',
      href: "https://react.dev"
      target: "_blank"
    , [
        h 'img',
          src: reactLogo
          className: "logo react"
          alt: "React logo"
    ]
    h 'h1', "Vite + React"
    h '.card', [
      h 'button',
        onClick: ()-> setCount count+1
      , "count is #{count}"
      h 'p', 'Edit client/coffee_src/App.coffee</code> and npm run dev to test HMR'
      h 'p', 'Click on the Vite and React logos to learn more'

    ]
  ]

export default App
