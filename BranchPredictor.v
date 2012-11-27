module BranchPredictor(PCNow_ID,PCNow_EX,BranchExists_ID,BranchExists_EX,BranchDecision_EX,BranchTarget_EX);
	parameter n = 4;
	
	always @ (BranchExists_EX) begin
		if (BranchExists_EX) begin
			BranchHistory <= {BranchHistory[n-2,0],BranchDecision_EX};
			if (BranchDecision_EX) begin
				if (BranchPattern[BranchHistory] != 3)
					BranchPattern[BranchHistory] <= BranchPattern[BranchHistory] + 1;
			end else begin
				if (BranchPattern[BranchHistory] != 0)
					BranchPattern[BranchHistory] <= BranchPattern[BranchHistory] - 1;
			end
			BranchOrigin[BranchHistory] <= PCNow_EX;
			BranchTarget[BranchHistory] <= BranchTarget_EX;
		end
	end
	
	always @(BranchExists_ID) begin
		if (BranchExists_ID) begin
			if (BranchPattern[BranchHistory][1] == 1) begin
				Prediction <= 1;
			end else begin
				Prediction <= 0;
			end
		end
	end
endmodule