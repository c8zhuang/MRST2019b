function [] = plotHAPhull(G,interpFace,mycell)
%plot harmonic averaging points and its convex hull associated with a given
%cell 'mycell'
%   Detailed explanation goes here
if(G.griddim==2)
    x=G.cells.centroids(mycell,1);
    y=G.cells.centroids(mycell,2);
    myFaces=G.cells.faces(G.cells.facePos(mycell):G.cells.facePos(mycell+1)-1);
    hap=interpFace.coords(myFaces,:);
    ind=convhull(hap);
    plotGrid(G,mycell,'facecolor','none');hold on
    plot(x,y,'r.','markersize',30);
    plot(hap(:,1),hap(:,2),'b.','markersize',30);
    plot(hap(ind,1),hap(ind,2),'m-');axis equal tight
else
    x=G.cells.centroids(mycell,1);
    y=G.cells.centroids(mycell,2);
    z=G.cells.centroids(mycell,3);
    myFaces=G.cells.faces(G.cells.facePos(mycell):G.cells.facePos(mycell+1)-1);
    hap=interpFace.coords(myFaces,:);
    ind=convhull(hap);
    
    plotGrid(G,mycell,'facealpha',0.3);hold on;view(3);
    plot3(x,y,z,'r.','markersize',30);
    plot3(hap(:,1),hap(:,2),hap(:,3),'b.','markersize',30);
    trisurf(ind,hap(:,1),hap(:,2),hap(:,3),'facecolor','g','facealpha',0.5);
end
end
