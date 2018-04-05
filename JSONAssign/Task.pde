// A Bubble class

class Task {
  float y;
  int taskHeight;
  String name;
  String due;
  String status;
  int id;

  // NOT STORED IN JSON
  boolean over = false;
  boolean deleteMode = false;
  boolean editMode = false;
  boolean editingText = false;
  String thingToModify = "";

  // Create  the Bubble
  Task(float y_, String name_, String due_, String status_, int id_) {
    y = y_;
    name = name_;
    due = due_;
    status = status_;
    id = id_;

    taskHeight = 100; // Change later?
  }

  // Checking if mouse is over the Bubble
  void hover(float px, float py) {
    if (py >= y && py <= this.getEndY()) {
      over = true;
    } else {
      over = false;
    }
  }

  boolean checkClick(float px, float py) {
    if (buttonPressed(width-100, y+2, 100, taskHeight/2-2, px, py) && deleteMode == false) { // DELETE 1
      editMode = false;
      deleteMode = true;
      return true;
    } else if (buttonPressed(width-200, y+2, 100, taskHeight/2-2, px, py) && deleteMode == true) { // DELETE 2
      deleteItem(id);
      deleteMode = false;
      return true;
    } else if (buttonPressed(width-100, y+2, 100, taskHeight/2-2, px, py) && deleteMode == true) { // CANCEL DELETE
      deleteMode = false;
      return true;
    } else if (buttonPressed(width-100, y+taskHeight/2+2, 100, taskHeight/2-2, px, py) && editMode == false) { // EDIT
      deleteMode = false;
      editMode = true;
      return true;
    } else if (buttonPressed(20, y+5, width-300, taskHeight/2-10, px, py) && editMode == true) { // EDIT NAME
      toChange = name;
      thingToModify = "name";
      editingText = true;
      return true;
    } else if (buttonPressed(20, y+taskHeight/2+5, width-300, taskHeight/2-10, px, py) && editMode == true) { // EDIT DUE
      toChange = due;
      thingToModify = "due";
      editingText = true;
      return true;
    } else if (buttonPressed(width-100, y+taskHeight/2+2, 100, taskHeight/2-2, px, py) && editMode == true) { // CANCEL EDIT
      editMode = false;
      return true;
    } else if (buttonPressed(0, y, width, 100, px, py)) { // CLEAR
      deleteMode = false;
      editMode = false;
      return true;
    } else {
      return false;
    }
  }

  int getStartY() {
    return int(y);
  }

  int getEndY() {
    return int(y)+taskHeight;
  }

  void modifyText(String str) {
    if (thingToModify.equals("name")) {
      name = str;
      thingToModify = "";
      toChange = "";
      editingText = false;
    } else if (thingToModify.equals("due")) {
      due = str;
      thingToModify = "";
      toChange = "";
      editingText = false;
    }
    saveItem(id);
  }

  // Display the Bubble
  void display() {

    if (over) {
      fill(240, 0, 0);
    } else {
      fill(255, 0, 0);
    }
    stroke(255);
    rect(0, y, width, 100);

    fill(255);
    textAlign(LEFT, CENTER);
    textSize(20);
    text("Assignment: "+name+"\nDue Date: "+due+"\nStatus: "+status, 10, y, width, 100);

    noStroke();
    fill(200, 0, 0);
    if (deleteMode == false) {
      rect(width-100, y+2, 100, taskHeight/2-2); // Remove

      textAlign(CENTER, CENTER);
      fill(255);
      text("Delete", width-100, y+2, 100, taskHeight/2-2);
    } else { // DELETE MODE ACTIVATED
      rect(width-100, y+2, 100, taskHeight/2-2);
      rect(width-200, y+2, 100, taskHeight/2-2);

      textAlign(CENTER, CENTER);
      fill(255);
      text("Cancel", width-100, y+2, 100, taskHeight/2-2);
      text("Delete", width-200, y+2, 100, taskHeight/2-2);
    }



    fill(200, 0, 0);
    if (editMode == false) {
      rect(width-100, y+taskHeight/2+2, 100, taskHeight/2-2); // Edit

      textAlign(CENTER, CENTER);
      fill(255);
      text("Edit", width-100, y+taskHeight/2+2, 100, taskHeight/2-2);
    } else {
      rect(width-100, y+taskHeight/2+2, 100, taskHeight/2-2);

      textAlign(CENTER, CENTER);
      fill(255);
      text("Cancel", width-100, y+taskHeight/2+2, 100, taskHeight/2-2);

      fill(255);
      rect(10, y+5, width-300, taskHeight/2-10);
      textAlign(LEFT, CENTER);
      fill(0);
      if (editingText == true && thingToModify == "name") {
        text("[Name] "+toChange, 20, y+5, width-300, taskHeight/2-10);
      } else {
        text("Name: "+name, 20, y+5, width-300, taskHeight/2-10);
      }

      fill(255);
      rect(10, y+taskHeight/2+5, width-300, taskHeight/2-10);
      textAlign(LEFT, CENTER);
      fill(0);
      if (editingText == true && thingToModify == "due") {
        text("[Due Date] "+toChange, 20, y+taskHeight/2+5, width-300, taskHeight/2-10);
      } else {
        text("Due Date: "+due, 20, y+taskHeight/2+5, width-300, taskHeight/2-10);
      }
    }
  }
}

// Checked range (x,y,w,h) & coordinates of press (x,y)
boolean buttonPressed(float cx, float cy, float cw, float ch, float lx, float ly) {
  if (lx>cx && lx<cx+cw && ly>cy && ly<cy+ch) {
    return true;
  } else {
    return false;
  }
}
