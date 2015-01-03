function [flag] = SimulationDataGenerationPipe(OutDir,MarginalType)
%dump with predefined parameters
%OutDir/W, Phi, Z

m = 1000;
k = 100;
V = 10000;
beta = 0.1;
mu = rand(k,1);

A = rand(k,k);
A = A + A';
Sigma = A + k*eye(k);


[W,Z,Phi] = SimulationDataGeneration(m,k,V,beta,mu,Sigma,MarginalType);
fprintf('simulation data generated\n');
csvwrite(strcat(OutDir + '/W'),W);
csvwrite(strcat(OutDir + '/Z'),Z);
csvwrite(strcat(OutDir + '/Phi'),Phi);
fprintf('dumped to dir [%s]\n',OutDir);

end

