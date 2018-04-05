String toChange;

void keyPressed() {
  if (key == ENTER) {
      for (Task t : tasks) {
        if(t.editingText){
          t.modifyText(toChange);
          break;
        }
      }
  } else if (keyCode == SHIFT||keyCode == CONTROL||keyCode == ALT) {
  } else if (key == BACKSPACE) {
    if (toChange.length()>1) {
      if (toChange == "Name...") {
      } else {
        toChange = toChange.substring(0, toChange.length()-1);
      }
    } else if (toChange.length()==1) {
      toChange = "Name...";
    } else {
    }
  } else {
    if (toChange == "Name...") {
      toChange="";
    }
    toChange = toChange+key;
  }
}
