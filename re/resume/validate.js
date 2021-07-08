/**
 * 
 */
function validate() {
		var re = /^[0-9]{10,11}$/;
		//mobile 검사 정규식
		var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
        // 이메일이 적합한지 검사할 정규식
        
        var rsTitle = document.getElementById("rsTitle");
        var email = document.getElementById("email");
        var mobile = document.getElementById("mobile");
        
        
        
        
        if(write.rsTitle.value=="") {
            alert("제목 적어주세요.");
            write.rsTitle.focus();
            return false;
        }
        
        if(!check(re, mobile, "적합하지 않은 전화번호 형식입니다.")) {
            return false;
        }
        if(write.address1.value=="") {
            alert("주소 적어주세요.");
            write.address1.focus();
            return false;
        }
        if(!check(re2, email, "적합하지 않은 이메일 형식입니다.")) {
                 return false;
                }
         //----------
         if(write.education[0].checked==false &&
        		 write.education[1].checked==false &&
        		 write.education[2].checked==false &&
        		 write.education[3].checked==false ) {
                    alert("최종 학력을 입력해주세요.");
                    return false;
                }
         if(write.career[0].checked==false &&
        		 write.career[1].checked==false &&
        		 write.career[2].checked==false &&
        		 write.career[3].checked==false &&
        		 write.career[4].checked==false &&
        		 write.career[5].checked==false ) {
                    alert("경력을 입력해주세요.");
                    return false;
                }
         if(write.salary[0].checked==false &&
        		 write.salary[1].checked==false &&
        		 write.salary[2].checked==false &&
        		 write.salary[3].checked==false &&
        		 write.salary[4].checked==false &&
        		 write.salary[5].checked==false &&
        		 write.salary[6].checked==false &&
        		 write.salary[7].checked==false ) {
                    alert("희망 연봉을 입력해주세요.");
                    return false;
         }
         if(write.occupation.value==""){
        	 alert("희망직종을 입력해주세요.");
             return false;
         }
         
         if(confirm("등록하시겠습니까?")==true){
     		return true;
     	}
        
        return false;
        
	}
	function check(re, what, message) {
        if(re.test(what.value)) {
            return true;
        }
        alert(message);
        //what.value = "";
        what.focus();
        //return false;
    }