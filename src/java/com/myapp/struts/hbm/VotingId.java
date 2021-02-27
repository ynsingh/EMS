package com.myapp.struts.hbm;
// Generated Jun 16, 2011 5:12:32 PM by Hibernate Tools 3.2.1.GA



/**
 * VotingId generated by hbm2java
 */
public class VotingId  implements java.io.Serializable {


     private String electionId;
     private String instituteId;
     private String voterBallotId;

    public VotingId() {
    }

    public VotingId(String electionId, String instituteId, String voterBallotId) {
       this.electionId = electionId;
       this.instituteId = instituteId;
       this.voterBallotId = voterBallotId;
    }
   
    public String getElectionId() {
        return this.electionId;
    }
    
    public void setElectionId(String electionId) {
        this.electionId = electionId;
    }
    public String getInstituteId() {
        return this.instituteId;
    }
    
    public void setInstituteId(String instituteId) {
        this.instituteId = instituteId;
    }
    public String getVoterBallotId() {
        return this.voterBallotId;
    }
    
    public void setVoterBallotId(String voterBallotId) {
        this.voterBallotId = voterBallotId;
    }


   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof VotingId) ) return false;
		 VotingId castOther = ( VotingId ) other; 
         
		 return ( (this.getElectionId()==castOther.getElectionId()) || ( this.getElectionId()!=null && castOther.getElectionId()!=null && this.getElectionId().equals(castOther.getElectionId()) ) )
 && ( (this.getInstituteId()==castOther.getInstituteId()) || ( this.getInstituteId()!=null && castOther.getInstituteId()!=null && this.getInstituteId().equals(castOther.getInstituteId()) ) )
 && ( (this.getVoterBallotId()==castOther.getVoterBallotId()) || ( this.getVoterBallotId()!=null && castOther.getVoterBallotId()!=null && this.getVoterBallotId().equals(castOther.getVoterBallotId()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getElectionId() == null ? 0 : this.getElectionId().hashCode() );
         result = 37 * result + ( getInstituteId() == null ? 0 : this.getInstituteId().hashCode() );
         result = 37 * result + ( getVoterBallotId() == null ? 0 : this.getVoterBallotId().hashCode() );
         return result;
   }   


}

