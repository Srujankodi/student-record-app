const mongoose = require("mongoose");

const studentSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true
    },
    rollNo: {
      type: String,
      required: true,
      unique: true
    },
    branch: {
      type: String,
      required: true
    },
    company: {
      type: String
    },
    duration: {
      type: String
    },
    stipend: {
      type: Number
    }
  },
  { timestamps: true }
);

module.exports = mongoose.model("Student", studentSchema);