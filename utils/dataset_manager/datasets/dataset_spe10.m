function [info, present] = dataset_spe10()
% Info function for SPE10 dataset. Use getDatasetInfo or getAvailableDatasets for practical purposes.

%{
Copyright 2009-2019 SINTEF Digital, Mathematics & Cybernetics.

This file is part of The MATLAB Reservoir Simulation Toolbox (MRST).

MRST is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MRST is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with MRST.  If not, see <http://www.gnu.org/licenses/>.
%}
    [info, present] = datasetInfoStruct(...
        'name', 'SPE10', ...
        'website', 'http://www.spe.org/web/csp/', ...
        'fileurl', 'https://www.sintef.no/contentassets/124f261f170947a6bc51dd76aea66129/SPE10.zip', ...
        'hasGrid', true, ...
        'hasRock', true, ...
        'hasFluid', true, ...
        'filesize', 48.1, ...
        'cells',   1122000, ...
        'examples', {'showSPE10', ...
                     'book:showSPE10', ...
                     'book:computeLorenzSPE10', ...
                     'book:presDepViscosity', ...
                     'book:quarterFiveSpot', ...
                     'book:showWellPairsSPE10', ...
                     'book:singlePhaseMuP', ...
                     'book:viscousFingeringQ5', ...
                     'book:splittingErrorQ5het', ...
                     'spe10:SPE10_rock', ...
                     'spe10:SPE10_setup', ...
                     'spe10:simulate_spe10', ...
                     'blackoil-sequential:sequentialSPE10', ...
                     'ad-eor:spe10SurfanctantExample', ...
                     'diagnostics:diagnostFlowPatterns', ...
                     'diagnostics:diagnostUpscaleSPE10', ...
                     'diagnostics:diagnostOptimWellPlacement', ...
                     'diagnostics:diagnostWellPairs', ...
                     'upscaling:averagingExample1', ...
                     'upscaling:upscalingExample2', ...
                     'upscaling:periodicUpscaleExample', ...
                     'agglom:agglomExample3', ...
                     'agglom:agglomExample4', ...
                     'agglom:agglomExample5', ...
                     'agglom:agglomExample6', ...
                     'steady-state:BlockOnePhaseExample', ...
                     'steady-state:BlockTwoPhaseExample', ...
                     'steady-state:BlockPolymerExample', ...
                     'msrsb:exampleMs', ...
                     'msrsb:SPE10Layer2phMS', ...
                     'msfv:PEBImsfvExample', ...
                     'impes:fivespotSPE10', ...
                     }, ...
        'description', [ ...
            'The tenth SPE benchmark was initially designed as ',...
            'a difficult upscaling test. Today, this highly heterogeneous ', ...
            'model is used a standard benchmark in a large number ',...
            'of publications. MRST has a dedicated module, "spe10", ', ...
            'that simplifies working with the dataset'], ...
        'modelType', 'Two-phase fluid, Cartesian grid' ...
         );
end
