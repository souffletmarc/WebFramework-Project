module CoursesHelper  
  
def isPassed?
  modules_passed = 0
  @first_grade = 0
  @second_grade = 0
  @third_grade = 0
  for g in current_user.grades
    if (g.grade.to_i >= 40)
      modules_passed = modules_passed + 1
    end
    if (@first_grade <= g.grade.to_i)
      @third_grade = @second_grade
      @second_grade = @first_grade
      @first_grade = g.grade.to_i
    else
      if (@second_grade <= g.grade.to_i)
        @third_grade = @second_grade
        @second_grade = g.grade.to_i
      else
        if (@third_grade <= g.grade.to_i)
          @third_grade = g.grade.to_i
        end
      end
    end
  end
  if (modules_passed >= 3)
    return true
  else
    if (modules_passed == 2)
      if (((@first_grade - 40) + (@second_grade - 40)) > ((40 - @third_grade) * 2))
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
  
def getOverallMark
  (@first_grade + @second_grade + @third_grade) / 3
end

def getObservation
  result = getOverallMark
  if (result >= 70)
    "Distinction"
  else
    if (result >= 60)
      "Merit upper division"
    else
      if (result >= 50)
        "Merit lower division"
      else
        if (result >= 40)
          "Pass"
        else
          "Fail"
        end
      end
    end
  end
end

end
