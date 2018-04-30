pragma solidity ^0.4.2;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;
    // Checking boolean that you still can vote
    bool endVote;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );
    
    event ElectionResult(string name, uint voteCount);

    function Election () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
         // reuire that the vote is still on time
        require(endVote == false);
        
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        votedEvent(_candidateId);
    }
    
  function end() public{
       for(uint i = 1; i <= candidatesCount; i++){
            ElectionResult(candidates[i].name, candidates[i].voteCount);
        }
        //Set endVote from "False" to "True" so no one can vote anymore.
        endVote = true;
    }
}
