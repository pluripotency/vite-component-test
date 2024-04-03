import h from 'react-hyperscript'
import {EditForm} from '../parts/hook_form_group'

regex_test = ///
^                         #Start anchor
(?=.*[A-Z].*[A-Z])        #Ensure string has two uppercase letters.
(?=.*[!@#$&*])            #Ensure string has one special case letter.
(?=.*[0-9].*[0-9])        #Ensure string has two digits.
(?=.*[a-z].*[a-z].*[a-z]) #Ensure string has three lowercase letters.
.{8,}                     #Ensure string length has more than 8.
$                         #End anchor.
///
regex_test1 = ///
///

form_items = [
  name: 'test1'
  label: 'RegexTest [A-Z] twice and 8 cahrs'
  type: 'text'
  condition:
    required:
      value: true
      message: '必要'
    pattern:
      value: ///
      ^                         #Start anchor
      (?=.*[A-Z].*[A-Z])        #Ensure string has two uppercase letters.
      .{8}                      #Ensure string is of length 8.
      $                         #End anchor.
      ///
      message: '[A-Z] twice and 8 cahrs'
,
  name: 'test2'
  label: 'RegexTest two [A-Z], one [!@#$&*], two digits, three [a-z] and 8 cahrs'
  type: 'text'
  condition:
    required:
      value: true
      message: '必要'
    pattern:
      value: ///
      ^                         #Start anchor
      (?=.*[A-Z].*[A-Z])        #Ensure string has two uppercase letters.
      (?=.*[!@#$&*])            #Ensure string has one special case letter.
      (?=.*[0-9].*[0-9])        #Ensure string has two digits.
      (?=.*[a-z].*[a-z].*[a-z]) #Ensure string has three lowercase letters.
      .{8}                      #Ensure string is of length 8.
      $                         #End anchor.
      ///
      message: '[A-Z] twice and 8 cahrs'
]

export default App = ()->
  h EditForm, {
    form_items
    default_values: {}
    onSubmit: (params)-> console.log params
    close_func: ()->
  }
