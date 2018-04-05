// Made By Stephen Kaplan using an example by Daniel Shiffman

Task[] tasks;
// A JSON object
JSONObject json;

void setup() {
  size(600,displayHeight);
  loadData();
}

void draw() {
  background(255);
  // Display all bubbles
  for (Task t : tasks) {
    t.display();
    t.hover(mouseX, mouseY);
  }
  
  //
  textAlign(CENTER, CENTER);
  fill(0);
  text("Click here to add new assignment", 0, height/2, width, height/2);
}



 void loadData() {
  // Load JSON file
  // Temporary full path until path problem resolved.
  json = loadJSONObject("data.json");

  JSONArray taskData = json.getJSONArray("tasks");

  // The size of the array of Bubble objects is determined by the total XML elements named "bubble"
  tasks = new Task[taskData.size()]; 

  for (int i = 0; i < taskData.size(); i++) {
    // Get each object in the array
    JSONObject task = taskData.getJSONObject(i); 
    // Get a position object
    JSONObject position = task.getJSONObject("position");
    // Get x,y from position
    int y = position.getInt("y");
    
    // Get diamter and label
    String name = task.getString("name");
    String due = task.getString("due");
    String status = task.getString("status");
    int id = task.getInt("id");

    // Put object in array
    tasks[i] = new Task(y,name,due,status, id);
  }
}

 void mousePressed() {
  boolean addNew = true;
  
  for (Task t : tasks) {
    if(t.checkClick(mouseX, mouseY)){
      addNew = false;
      break;
    }else{
      addNew = true;
    }
  }
  
  if (addNew == true){
    // Create a new JSON task object
    JSONObject newTask = new JSONObject();
  
    // Create a new JSON position object
    JSONObject position = new JSONObject();
    
    int lastPos;
    if (tasks.length > 0){
      lastPos = tasks[tasks.length-1].getEndY();
    }else{
      lastPos = 4;
    }
    
    position.setInt("y", lastPos+1);
  
    // Add position to bubble
    newTask.setJSONObject("position", position);
  
    // Add diamater and label to bubble
    newTask.setString("name", "New Task");
    newTask.setString("due", "April 5th, 2018");
    newTask.setString("status", "Not yet started");
    
    int idNum = tasks.length;
    newTask.setInt("id", idNum);
  
    // Append the new JSON bubble object to the array
    JSONArray taskData = json.getJSONArray("tasks");
    taskData.append(newTask);
  
    // Save new data
    saveJSONObject(json,"data/data.json");
    loadData();
  }
}

void deleteItem(int id){
  JSONArray taskData = json.getJSONArray("tasks");
  taskData.remove(id);
  
  for (int i = id; i < taskData.size(); i++) {
    JSONObject tempTask = taskData.getJSONObject(i);
    
    JSONObject position = tempTask.getJSONObject("position");
    int y = position.getInt("y");
    
    int yPosAdjust = y-100;
    tempTask.setInt("id",i);
    position.setInt("y",yPosAdjust);
  }
  saveJSONObject(json,"data/data.json");
  loadData();
}

void saveItem(int id){
  JSONArray taskData = json.getJSONArray("tasks");
  
  for (int i = id; i < taskData.size(); i++) {
    JSONObject tempTask = taskData.getJSONObject(i);

    String name = tasks[i].name;
    String due = tasks[i].due;
    
    tempTask.setString("name",name);
    tempTask.setString("due",due);
  }
  saveJSONObject(json,"data/data.json");
  loadData();
}
