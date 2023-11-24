function [m,result] = gpt_petal_folding_20231124( m, varargin )
%[m,result] = gpt_petal_folding_20231124( m, varargin )
%   Morphogen interaction function.
%   Written at 2023-11-24 10:48:15.
%   GFtbox revision 20211011, 2020-10-11 11:00.

% The user may edit any part of this function lying between lines that
% begin "%%% USER CODE" and "%%% END OF USER CODE".  Those lines themselves
% delimiters themselves must not be moved, edited, deleted, or added.

    result = [];
    if isempty(m), return; end

    setGlobals();
    
    % Handle new-style callbacks.
    if nargin > 1
        if exist('ifCallbackHandler','file')==2
            [m,result] = ifCallbackHandler( m, varargin{:} );
        end
        return;
    end

    fprintf( 1, '%s found in %s\n', mfilename(), which(mfilename()) );

    realtime = m.globalDynamicProps.currenttime;
    dt = m.globalProps.timestep;

%%% USER CODE: INITIALISATION
    if (Steps(m)==0) && m.globalDynamicProps.doinit
        % Put any code here that should only be performed at the start of
        % the simulation.

        if m.globalProps.IFsetsoptions
            m = setUpModelOptions( m, ...
                'modelname', {'MODEL1',...  % Default petal model, Figure 4C-E
                              'MODEL2',...  % Areal conflict, Figure 4F-H
                              'MODEL3'...   % Areal plus Surface conflict, Figure 4I-K
                             }, 'MODEL3' ... % Model version name
                ... % Add further lines for all the options that you want.
            );
        end

        % Any further initialisation here.
    end
    
    OPTIONS = getModelOptions( m );
    printModelOptions( m );
%%% END OF USER CODE: INITIALISATION

%%% SECTION 1: ACCESSING MORPHOGENS AND TIME.
%%% AUTOMATICALLY GENERATED CODE: DO NOT EDIT.

% Each call of getMgenLevels below returns four results:
% XXX_i is the index of the morphogen called XXX.
% XXX_p is the vector of all of its values.
% XXX_a is its mutation level.
% XXX_l is the "effective" level of the morphogen, i.e. XXX_p*XXX_a.
% In SECTION 3 of the automatically generated code, all of the XXX_p values
% will be copied back into the mesh.

    polariser_i = FindMorphogenRole( m, 'POLARISER' );
    P = m.morphogens(:,polariser_i);
    [kapar_i,kapar_p,kapar_a,kapar_l] = getMgenLevels( m, 'KAPAR' );  %#ok<ASGLU>
    [kaper_i,kaper_p,kaper_a,kaper_l] = getMgenLevels( m, 'KAPER' );  %#ok<ASGLU>
    [kbpar_i,kbpar_p,kbpar_a,kbpar_l] = getMgenLevels( m, 'KBPAR' );  %#ok<ASGLU>
    [kbper_i,kbper_p,kbper_a,kbper_l] = getMgenLevels( m, 'KBPER' );  %#ok<ASGLU>
    [knor_i,knor_p,knor_a,knor_l] = getMgenLevels( m, 'KNOR' );  %#ok<ASGLU>
    [strainret_i,strainret_p,strainret_a,strainret_l] = getMgenLevels( m, 'STRAINRET' );  %#ok<ASGLU>
    [arrest_i,arrest_p,arrest_a,arrest_l] = getMgenLevels( m, 'ARREST' );  %#ok<ASGLU>
    [id_tip_i,id_tip_p,id_tip_a,id_tip_l] = getMgenLevels( m, 'ID_TIP' );  %#ok<ASGLU>
    [id_mid_i,id_mid_p,id_mid_a,id_mid_l] = getMgenLevels( m, 'ID_MID' );  %#ok<ASGLU>
    [s_mid_i,s_mid_p,s_mid_a,s_mid_l] = getMgenLevels( m, 'S_MID' );  %#ok<ASGLU>
    [id_bla_i,id_bla_p,id_bla_a,id_bla_l] = getMgenLevels( m, 'ID_BLA' );  %#ok<ASGLU>
    [s_bla_i,s_bla_p,s_bla_a,s_bla_l] = getMgenLevels( m, 'S_BLA' );  %#ok<ASGLU>
    [id_base_i,id_base_p,id_base_a,id_base_l] = getMgenLevels( m, 'ID_BASE' );  %#ok<ASGLU>
    [id_stk_i,id_stk_p,id_stk_a,id_stk_l] = getMgenLevels( m, 'ID_STK' );  %#ok<ASGLU>
    [id_sinus_i,id_sinus_p,id_sinus_a,id_sinus_l] = getMgenLevels( m, 'ID_SINUS' );  %#ok<ASGLU>
    [id_fold_i,id_fold_p,id_fold_a,id_fold_l] = getMgenLevels( m, 'ID_FOLD' );  %#ok<ASGLU>
    [s_asym_i,s_asym_p,s_asym_a,s_asym_l] = getMgenLevels( m, 'S_ASYM' );  %#ok<ASGLU>
    [v_kaniso_a_i,v_kaniso_a_p,v_kaniso_a_a,v_kaniso_a_l] = getMgenLevels( m, 'V_KANISO_A' );  %#ok<ASGLU>
    [v_kaniso_b_i,v_kaniso_b_p,v_kaniso_b_a,v_kaniso_b_l] = getMgenLevels( m, 'V_KANISO_B' );  %#ok<ASGLU>
    [v_karea_a_i,v_karea_a_p,v_karea_a_a,v_karea_a_l] = getMgenLevels( m, 'V_KAREA_A' );  %#ok<ASGLU>
    [v_karea_b_i,v_karea_b_p,v_karea_b_a,v_karea_b_l] = getMgenLevels( m, 'V_KAREA_B' );  %#ok<ASGLU>
    [s_fold_i,s_fold_p,s_fold_a,s_fold_l] = getMgenLevels( m, 'S_FOLD' );  %#ok<ASGLU>
    [c_area_i,c_area] = getCellFactorLevels( m, 'c_area' );
    [c_aniso_i,c_aniso] = getCellFactorLevels( m, 'c_aniso' );

% Mesh type: lobes
%            base: 0
%        cylinder: 0
%          height: 1
%          layers: 0
%           lobes: 1
%             new: 1
%          radius: 1
%      randomness: 0
%           rings: 15
%          strips: 15
%       thickness: 0

%            Morphogen    Diffusion   Decay   Dilution   Mutant
%            --------------------------------------------------
%                KAPAR         ----    ----       ----     ----
%                KAPER         ----    ----       ----     ----
%                KBPAR         ----    ----       ----     ----
%                KBPER         ----    ----       ----     ----
%                 KNOR         ----    ----       ----     ----
%            POLARISER         0.05  0.0001       ----     ----
%            STRAINRET         ----    ----       ----     ----
%               ARREST         ----    ----       ----     ----
%               ID_TIP         ----    ----       ----     ----
%               ID_MID         ----    ----       ----     ----
%                S_MID        0.001    ----       ----     ----
%               ID_BLA         ----    ----       ----     ----
%                S_BLA         0.01    ----       ----     ----
%              ID_BASE         ----    ----       ----     ----
%               ID_STK         ----    ----       ----     ----
%             ID_SINUS         ----    ----       ----     ----
%              ID_FOLD         ----    ----       ----     ----
%               S_ASYM         ----    ----       ----     ----
%           V_KANISO_A         ----    ----       ----     ----
%           V_KANISO_B         ----    ----       ----     ----
%            V_KAREA_A         ----    ----       ----     ----
%            V_KAREA_B         ----    ----       ----     ----
%               S_FOLD        0.001    ----       ----     ----


%%% USER CODE: MORPHOGEN INTERACTIONS

% In this section you may modify the mesh in any way that does not
% alter the set of nodes.

    if (Steps(m)==0) && m.globalDynamicProps.doinit
        % Put any code here that should only be performed at the start of
        % the simulation.
        
        center = [0, 0];
        radii_center = sqrt((m.nodes(:,1)-center(1)).^2 + (m.nodes(:,2)-center(2)).^2);

        % Define the +organiser/source of P
        id_base_p(m.nodes(:,2)==min(m.nodes(:,2)))=1;

        % Define the -organiser/sink of P
        id_tip_p((radii_center>0.95)&(m.nodes(:,2)>0))=1;

        % Define the sinus factor 
        tip = [0, 1];
        radii_tip = sqrt((m.nodes(:,1)-tip(1)).^2 + (m.nodes(:,2)-tip(2)).^2);
        id_sinus_p(radii_tip < 0.3)=1;

        % Define the lobe factor 
        id_bla_p(m.nodes(:,2)>-0.3)=1;
        s_bla_p = id_bla_p;
        m.morphogenclamp(id_bla_p==1, s_bla_i)=1;
        m = leaf_mgen_conductivity( m, 'S_BLA', 0.01 );
        m = leaf_mgen_absorption( m, 'S_BLA', 0.0001 );   
        
        % Define the mid_vein factor 
        id_mid_p((abs(m.nodes(:,1)-0.5)<=0.05)|(abs(m.nodes(:,1)+0.5)<=0.05))=1;
        s_mid_p = id_mid_p;
        m.morphogenclamp(id_mid_p==1, s_mid_i)=1;
        m = leaf_mgen_conductivity( m, 'S_MID', 0.001 );

        % Define the stalk/claw domain
        id_stk_p(m.nodes(:,2)<-0.3)=1;
        
        % Define the folding factor
        id_fold_p((m.nodes(:,2)<=-0.2)&(m.nodes(:,2)>=-0.55)&... 
                  (m.nodes(:,1)>0.5)&(m.nodes(:,1)<0.75))=1;      
        s_fold_p = id_fold_p;
        m.morphogenclamp(id_fold_p==1, s_fold_i)=1;
        m = leaf_mgen_conductivity( m, 'S_FOLD', 0.001 );   % diffusion rate of S_FOLD
        m = leaf_mgen_absorption( m, 'S_FOLD', 0.001 );     % decay rate of S_FOLD

        % Define the asymmetric signal, corresponding to the dorsoventral symmetry of the whole flower 
        s_asym_p = (m.nodes(:,1)-min(m.nodes(:,1)))/...
                   (max(m.nodes(:,1))-min(m.nodes(:,1)));

        % Mesh is fixed on the base 
        m = leaf_fix_vertex( m, 'vertex', find(id_base_p==1), 'dfs', 'y'); 
        
    end

    % PRN Polarity regulatory network
    % Setup the planar(proximo-distal) polarity field
    P(id_base_p==1)=1;  % source
    P(id_tip_p==1)=0;   % sink
    m.morphogenclamp((id_base_p==1)|(id_tip_p==1), polariser_i) = 1;
    m = leaf_mgen_conductivity( m, 'POLARISER', 0.05 );    % diffusion rate of P
    m = leaf_mgen_absorption( m, 'POLARISER', 0.0001 );    % decay rate of P
    

    % KRN Growth rate regulatory network
    % kapar/kbpar: growth rate parallel to the polarity on a/b surface
    % kaper/kbper: growth rate perpendicular to the polarity on a/b surface
    % Run Time = 24

    % Growth Phase I
    if (realtime > 4-0.001 ) && (realtime < 14)
        
       kapar_p(:) = 0.12 * pro(1.2, id_mid_p)...
                        .* inh(5, id_sinus_p); 
                    
       kaper_p(:) = 0.08  * inh(10, id_stk_p)...
                        .* inh(5, id_sinus_p);  
                    
       kbpar_p = kapar_p;
       
       kbper_p = kaper_p;
       
       knor_p  = 0;
       
    end

    % Growth Phase II: Folding 
    if ( realtime > 14-0.001 ) && ( realtime < 24 )

        switch OPTIONS.modelname

            case 'MODEL1'  % Default petal model

                kapar_p(:) = 0.12 * pro(0.2, id_mid_p)...  
                        .* inh(0.5, s_asym_p)... 
                        .* pro(0, s_fold_p)... 
                        .* inh(5, id_sinus_p); 
                    
                kaper_p(:) = 0.08 * inh(10, id_stk_p)...  
                        .* pro(0.8, s_asym_p)...  
                        .* pro(0, s_fold_p)...
                        .* inh(5, id_sinus_p);  
      
                kbpar_p(:) = 0.12 * pro(0.2, id_mid_p)... 
                        .* inh(0.5, s_asym_p)...  
                        .* pro(0, s_fold_p)...
                        .* inh(5, id_sinus_p); 
                    
                kbper_p(:) = 0.08 * inh(10, id_stk_p)...  
                        .* pro(0.8, s_asym_p)...  
                        .* pro(0, s_fold_p)...
                        .* inh(5, id_sinus_p); 

                knor_p  = 0;


            case 'MODEL2'  % Areal conflict

                kapar_p(:) = 0.12 * pro(0.2, id_mid_p)...
                        .* inh(0.5, s_asym_p)...
                        .* pro(0, s_fold_p)... 
                        .* inh(5, id_sinus_p); 
                    
                kaper_p(:) = 0.08 * inh(10, id_stk_p)...
                        .* pro(0.8, s_asym_p)...
                        .* pro(0.3, s_fold_p)...  
                        .* inh(5, id_sinus_p);  
      
                kbpar_p(:) = 0.12 * pro(0.2, id_mid_p)...
                        .* inh(0.5, s_asym_p)...
                        .* pro(0, s_fold_p)...
                        .* inh(5, id_sinus_p); 
                    
                kbper_p(:) = 0.08 * inh(10, id_stk_p)...
                        .* pro(0.8, s_asym_p)...
                        .* pro(0.3, s_fold_p)...   
                        .* inh(5, id_sinus_p); 

                knor_p  = 0;


            case 'MODEL3'  % Areal plus Surface conflict

                kapar_p(:) = 0.12 * pro(0.2, id_mid_p)...
                        .* inh(0.5, s_asym_p)...
                        .* pro(0, s_fold_p)... 
                        .* inh(5, id_sinus_p); 
                    
                kaper_p(:) = 0.08 * inh(10, id_stk_p)...
                        .* pro(0.8, s_asym_p)...
                        .* pro(0.0, s_fold_p)...
                        .* inh(5, id_sinus_p);  
      
                kbpar_p(:) = 0.12 * pro(0.2, id_mid_p)...
                        .* inh(0.5, s_asym_p)...
                        .* pro(0, s_fold_p)...
                        .* inh(5, id_sinus_p); 
                    
                kbper_p(:) = 0.08 * inh(10, id_stk_p)...
                        .* pro(0.8, s_asym_p)...
                        .* pro(0.3, s_fold_p)...  
                        .* inh(5, id_sinus_p); 

                knor_p  = 0;
    
        end

    end
    
        v_kaniso_a_p = log(kapar_p./kaper_p);  % visualise growth anisotropy in ln scale of A/abaxial surface
        v_karea_a_p = kaper_p + kapar_p;       % visualise areal growth rate of A/abaxial surface
        
        v_kaniso_b_p = log(kbpar_p./kbper_p);  % visualise growth anisotropy in ln scale of B/adaxial surface
        v_karea_b_p = kbper_p + kbpar_p;       % visualise areal growth rate of B/adaxial surface
%%% END OF USER CODE: MORPHOGEN INTERACTIONS

%%% SECTION 3: INSTALLING MODIFIED VALUES BACK INTO MESH STRUCTURE
%%% AUTOMATICALLY GENERATED CODE: DO NOT EDIT.
    m.morphogens(:,polariser_i) = P;
    m.morphogens(:,kapar_i) = kapar_p;
    m.morphogens(:,kaper_i) = kaper_p;
    m.morphogens(:,kbpar_i) = kbpar_p;
    m.morphogens(:,kbper_i) = kbper_p;
    m.morphogens(:,knor_i) = knor_p;
    m.morphogens(:,strainret_i) = strainret_p;
    m.morphogens(:,arrest_i) = arrest_p;
    m.morphogens(:,id_tip_i) = id_tip_p;
    m.morphogens(:,id_mid_i) = id_mid_p;
    m.morphogens(:,s_mid_i) = s_mid_p;
    m.morphogens(:,id_bla_i) = id_bla_p;
    m.morphogens(:,s_bla_i) = s_bla_p;
    m.morphogens(:,id_base_i) = id_base_p;
    m.morphogens(:,id_stk_i) = id_stk_p;
    m.morphogens(:,id_sinus_i) = id_sinus_p;
    m.morphogens(:,id_fold_i) = id_fold_p;
    m.morphogens(:,s_asym_i) = s_asym_p;
    m.morphogens(:,v_kaniso_a_i) = v_kaniso_a_p;
    m.morphogens(:,v_kaniso_b_i) = v_kaniso_b_p;
    m.morphogens(:,v_karea_a_i) = v_karea_a_p;
    m.morphogens(:,v_karea_b_i) = v_karea_b_p;
    m.morphogens(:,s_fold_i) = s_fold_p;
    m.secondlayer.cellvalues(:,c_area_i) = c_area(:);
    m.secondlayer.cellvalues(:,c_aniso_i) = c_aniso(:);

%%% USER CODE: FINALISATION
 if (realtime > 14) && (realtime <= 14+dt)
     
     m = leaf_subdivide( m, 'morphogen', 'id_fold',...
                              'min', 0.5, 'max', 1,...
                              'mode', 'mid', 'levels', 'all');
 end
    

% In this section you may modify the mesh in any way whatsoever.
%%% END OF USER CODE: FINALISATION

end

function [m,result] = ifCallbackHandler( m, fn, varargin )
    result = [];
    if exist(fn,'file') ~= 2
        return;
    end
    [m,result] = feval( fn, m, varargin{:} );
end


%%% USER CODE: SUBFUNCTIONS

% Here you may write any functions of your own, that you want to call from
% the interaction function, but never need to call from outside it.
% Remember that they do not have access to any variables except those
% that you pass as parameters, and cannot change anything except by
% returning new values as results.
% Whichever section they are called from, they must respect the same
% restrictions on what modifications they are allowed to make to the mesh.

% The GFtbox_..._Callback routines can be deleted if you do not use them.
% Those that you retain will be automatically called by GFtbox at certain
% points in the simulation cycle.
% If you retain them, their headers specifying their arguments and results
% must not be altered.

function [m,result] = GFtbox_Precelldivision_Callback( m, ci ) %#ok<DEFNU>
    result = [];
    % Your code here.
end

function [m,result] = GFtbox_Preplot_Callback( m, theaxes )
    result =[];
    % Your code here.
end

function [m,result] = GFtbox_Postcelldivision_Callback( m, ci, cei, newci, newcei, oe1, oe2, ne1, ne2, ne3 ) %#ok<DEFNU>
    result = [];
    % Your code here.
end

function [m,result] = GFtbox_Postiterate_Callback( m ) %#ok<DEFNU>
    result = [];
    % Your code here.
end

function [m,result] = GFtbox_Postplot_Callback( m, theaxes ) %#ok<DEFNU>
    result = [];
    % Your code here.
end


