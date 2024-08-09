move
// Voting.move

address 0x1 {
module Voting {
    struct Voter {
        has_voted: bool,
    }

    struct Proposal {
        votes: u64,
    } 

    struct VotingContract {
        // Mapping of voters to their voting status
        voters: map(address, Voter),

        // Mapping of proposal IDs to proposals
        proposals: map(u64, Proposal),

        // The current winner of the vote
        winner: u64,
    }

    public fun init_voting_contract(): VotingContract {
        let voters = {};
        let proposals = {};
        let winner = 0;
        VotingContract { voters, proposals, winner }
    }
// Add a voter to the contract
    public fun add_voter(contract: &mut VotingContract, voter: address) {
        if (!contract.voters.contains(&voter)) {
            contract.voters.insert(voter, Voter { has_voted: false });
        }
    }

    // Add a proposal to the contract
    public fun add_proposal(contract: &mut VotingContract, proposal_id: u64) {
        if (!contract.proposals.contains(&proposal_id)) {
            contract.proposals.insert(proposal_id, Proposal { votes: 0 });
        }
    }

    // Cast a vote for a proposal
    public fun cast_vote(contract: &mut VotingContract, voter: address, proposal_id: u64) {
        if (contract.voters.contains(&voter) && !contract.voters[voter].has_voted) {
            contract.voters[voter].has_voted = true;
            contract.proposals[proposal_id].votes += 1;

            // Update the winner if necessary
            if (contract.proposals[proposal_id].votes > contract.proposals[contract.winner].votes) {
                contract.winner = proposal_id;
            }
}
        }
    }

    // Get the number of votes for a proposal
    public fun get_votes(contract: &VotingContract, proposal_id: u64): u64 {
        if (contract.proposals.contains(&proposal_id)) {
            contract.proposals[proposal_id].votes
        } else {
            0
        }
    }
}
}



