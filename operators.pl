% Taken from HeaRT project
% http://ai.ia.agh.edu.pl/wiki/hekate:heart

:-dynamic(xstat/1).
:-dynamic(xrule/1).
:-dynamic(xtype/1).
:-dynamic(xattr/1).
:-dynamic(xschm/1).
:-dynamic(xtpgr/1).
:-dynamic(xatgr/1).
:-dynamic(xcall/1).
:-dynamic(xactn/1).
:-dynamic(xtraj/1).

% Operators
%
% structural operators
:-op(830,fx,xrule).         % used to define rule
:-op(830,fx,xtype).         % used to define type
:-op(830,fx,xattr).         % used to define attribute
:-op(830,fx,xschm).         % used to define scheme
:-op(830,fx,xstat).         % used to define state
:-op(830,fx,xtpgr).         % used to define group of attributes
:-op(830,fx,xatgr).         % used to define group of attributes
:-op(830,fx,xcall).         % used to define callbacks
:-op(830,fx,xactn).	        % used to define actions
:-op(830,fx,xtraj).         % used to define trajectory
%

:-op(800,xfx,>>>).
:-op(800,xfx,==>).		% used to separate LHS and RHS of rule
:-op(500,xfx,**>).		% used to indicate the actions in the decision part


% alvs operators
% table 1
:-op(300,xfy,eq).
:-op(300,xfy,neq).
:-op(300,xfy,in).
:-op(300,xfy,notin).
:-op(300,xfy,subseteq).
:-op(300,xfy,supseteq).
:-op(300,xfy,sim).
:-op(300,xfy,notsim).

:-op(816,xfx,to).  % used to specify ranges for general ordered atts, as <mon,fri> [mon to fri]
:-op(300,xfy,set). % setting val in decision

:-op(301,xfy,gt).
:-op(301,xfy,lt).
:-op(301,xfy,gte).
:-op(301,xfy,lte).
