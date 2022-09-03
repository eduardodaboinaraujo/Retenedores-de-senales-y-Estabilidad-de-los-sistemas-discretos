clear 
clc 
close all

Fts = input('Ingrese el grado de su F.T a estudiar:');

if Fts == 1
    disp('ESTRUCTURA DE SISTEMAS DE ORDEN 1')
    disp('    kp   ')
    disp('---------')
    disp('tau*s + c')
    kp= input('Ingrese la variable kp: ');
    tau= input('Ingrese la variable tau: ');
    c= input('Ingrese la variable c: ');
    k= input('Igrese el valor de k que este en el rango de estabilidad: ');
    
    syms z
    
    num=[kp];
    den=[tau c];
    G=tf(num,den);

    Frmx=bandwidth(G);
    T=5*Frmx;
    To=1/T;

    Gz=c2d(G,To,'zoh');
    Gzc=feedback(k*Gz,1);
    [numz,denz]=tfdata(Gzc,'v');
    
% ----- Calculo apartado 1 test de jury ----- % 
    a0=denz(1,1);
    a1=denz(1,2);
%---------------------------------------------%
% ----- Calculo apartado 1 test de jury ----- % 
    Pc=denz(1,1)*z+denz(1,2);
    Pz=subs(Pc,z,1);
%---------------------------------------------%

    [p,z]=pzmap(numz,denz);
    pzmap(numz,denz);

    figure(1)
    axis([-1 1 -1 1]);
    zplane(z,p);
    title('Ubicacion de Ceros-Polos');
    grid on

    figure(2)
    step(G)
    hold on 
    step(Gz)
    hold on
    step(Gzc,'k')
    title('Sistema de Primer Orden');
    legend('Continuo','Discreto','Discreto L.C');
    grid on

    % ----- test de jury ----- %
    NdA=Fts+1;
    disp('PARA REALIZAR EL TEST DE JURY Y SABER LA CANTIDAD DE RESTRICCIONES ES DECIR PARA EL ESTUDIO');
    disp('DE SISTEMA DE ORDEN N EL TOTAL DE RESTRICCIONES SE CALCULA N+1 DONDE SU VALOR EL NUMERO DE');
    disp('APARTADOS A ANALIZAR');
    NdA
    
    if a1 < a0
        leer=[num2str(a1),' < ',num2str(a0)];
        disp('Apartado 1 se cumple: ');
        disp(leer)
    else
        leer=[num2str(a1),' < ',num2str(a0)];
        disp('No se cumple el apartado 1');
        disp(leer)
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
    return
    end

    if Pz > 0
        leer=[num2str(double(Pz)),' > ',num2str(0)];
        disp('Apartado 2 se cumple: ');
        disp(leer)
    else
        leer=[num2str(double(Pz)),' > ',num2str(0)];
        disp('No se cumple el apartado 2');
        disp(leer)
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
    return
    end
    
else
end

if Fts == 2
    disp('ESTRUCTURA DE SISTEMAS DE ORDEN 2')
    disp('         Wn^2         ')
    disp('----------------------')
    disp('s^2 + 2*sita*Wn + Wn^2')
    wn= input('valor de la frecuencia: ');
    sita= input('valor de sita: ');
    k= input('Igrese el valor de k que este en el rango de estabilidad: ');
    
    syms z
    
    num=[wn^2];
    den=[1 2*sita*wn wn^2];
    G=tf(num,den);
    
    Frmx=bandwidth(G);
    T=5*Frmx;
    To=1/T;
    
    Gz=c2d(G,To,'zoh');
    Gzc=feedback(k*Gz,1);
    [numz,denz]=tfdata(Gzc,'v');
  
% ----- Calculo apartado 1 test de jury ----- % 
    a0=denz(1,1);
    a1=denz(1,2);
    a2=denz(1,3);
%---------------------------------------------%
% ----- Calculo apartado 2 test de jury ----- %    
    Pc=denz(1,1)*z^2+denz(1,2)*z+denz(1,3);
    Pz=subs(Pc,z,1);
%---------------------------------------------% 
% ----- Calculo apartado 3 test de jury ----- %  
    Pcn=denz(1,1)*z^2+denz(1,2)*z+denz(1,3);
    Pzn=subs(Pcn,z,-1);
%---------------------------------------------%
    
    [p,z]=pzmap(numz,denz);
    pzmap(numz,denz);

    figure(1)
    axis([-1 1 -1 1]);
    zplane(z,p);
    title('Ubicacion de Ceros-Polos');
    grid on

    figure(2)
    step(G)
    hold on 
    step(Gz)
    hold on
    step(Gzc,'k')
    title('Sistema de Segundo Orden');
    legend('Continuo','Discreto','Discreto L.C');
    grid on
    
 % ----- test de jury ----- %
    NdA=Fts+1;
    disp('PARA REALIZAR EL TEST DE JURY Y SABER LA CANTIDAD DE RESTRICCIONES ES DECIR PARA EL ESTUDIO');
    disp('DE SISTEMA DE ORDEN N EL TOTAL DE RESTRICCIONES SE CALCULA N+1 DONDE SU VALOR EL NUMERO DE');
    disp('APARTADOS A ANALIZAR');
    NdA
    
    if a2 < a0
        leer=[num2str(a2),' < ',num2str(a0)];
        disp('Apartado 1 se cumple: ');
        disp(leer)
    else
        leer=[num2str(a2),' < ',num2str(a0)];
        disp('No se cumple el apartado 1');
        disp(leer)
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
    return 
    end 

    if Pz > 0
        leer=[num2str(double(Pz)),' > ',num2str(0)];
        disp('Apartado 2 se cumple: ');
        disp(leer)
    else
        leer=[num2str(double(Pz)),' > ',num2str(0)];
        disp('No se cumple el apartado 2');
        disp(leer)
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
    return
    end
        
    if Pzn > 0
        leer=[num2str(double(Pzn)),' > ',num2str(0)];
        disp('Apartado 3 se cumple: ');
        disp(leer)
    else
        leer=[num2str(double(Pzn)),' > ',num2str(0)];
        disp('No se cumple el apartado 3');
        disp(leer)
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
        return
    end
    
else
end

if Fts == 3
    disp('ESTRUCTURA DE SISTEMAS DE ORDEN 3')
    disp('             Wn^2*pu             ')
    disp('---------------------------------')
    disp('(s^2 + 2*sita*Wn + Wn^2)*(s + pu)')
    wn= input('valor de la frecuencia: ');
    sita= input('valor de sita: ');
    pu= input('valor de polo: ');
    k= input('Igrese el valor de k que este en el rango de estabilidad: ');
    
    syms z
    
    num=[wn^2*pu];
    den=conv([1 2*sita*wn wn^2],[1 pu]);;
    G=tf(num,den);
    
    Frmx=bandwidth(G);
    T=5*Frmx;
    To=1/T;
    
    Gz=c2d(G,To,'zoh');
    Gzc=feedback(k*Gz,1);
    [numz,denz]=tfdata(Gzc,'v');
  
% ----- Calculo apartado 1 test de jury ----- % 
    a0=denz(1,1);
    a1=denz(1,2);
    a2=denz(1,3);
    a3=denz(1,4);
%---------------------------------------------%
% ----- Calculo apartado 2 test de jury ----- %    
    Pc=denz(1,1)*z^3+denz(1,2)*z^2+denz(1,3)*z+denz(1,4);
    Pz=subs(Pc,z,1);
%---------------------------------------------% 
% ----- Calculo apartado 3 test de jury ----- %  
    Pcn=denz(1,1)*z^3+denz(1,2)*z^2+denz(1,3)*z+denz(1,4);
    Pzn=subs(Pcn,z,-1);
%---------------------------------------------%
% ----- Calculo apartado 4 test de jury ----- %
    b0=((denz(1,4))*(denz(1,2)))-((denz(1,1))*(denz(1,3)));
    b1=((denz(1,4))*(denz(1,3)))-((denz(1,1))*(denz(1,2)));
    b2=((denz(1,4))*(denz(1,4)))-((denz(1,1))*(denz(1,1)));
    Mj=([denz(1,4) denz(1,3) denz(1,2) denz(1,1);denz(1,1) denz(1,2) denz(1,3) denz(1,4);b0 b1 b2 0]);
%---------------------------------------------%
    
    [p,z]=pzmap(numz,denz);
    pzmap(numz,denz);

    figure(1)
    axis([-1 1 -1 1]);
    zplane(z,p);
    title('Ubicacion de Ceros-Polos');
    grid on

    figure(2)
    step(G)
    hold on 
    step(Gz)
    hold on
    step(Gzc,'k')
    title('Sistema de Segundo Orden');
    legend('Continuo','Discreto','Discreto L.C');
    grid on
    
 % ----- test de jury ----- %
    NdA=Fts+1;
    disp('PARA REALIZAR EL TEST DE JURY Y SABER LA CANTIDAD DE RESTRICCIONES ES DECIR PARA EL ESTUDIO');
    disp('DE SISTEMA DE ORDEN N EL TOTAL DE RESTRICCIONES SE CALCULA N+1 DONDE SU VALOR EL NUMERO DE');
    disp('APARTADOS A ANALIZAR');
    NdA
    
    if a3 < a0
        leer=[num2str(a2),' < ',num2str(a0)];
        disp('Apartado 1 se cumple: ');
        disp(leer)
    else
        leer=[num2str(a2),' < ',num2str(a0)];
        disp('No se cumple el apartado 1');
        disp(leer)
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
    return 
    end 

    if Pz > 0
        leer=[num2str(double(Pz)),' > ',num2str(0)];
        disp('Apartado 2 se cumple: ');
        disp(leer)
    else
        leer=[num2str(double(Pz)),' > ',num2str(0)];
        disp('No se cumple el apartado 2');
        disp(leer)
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
    return
    end
        
    if Pzn < 0
        leer=[num2str(double(Pzn)),' < ',num2str(0)];
        disp('Apartado 3 se cumple: ');
        disp(leer)
    else
        leer=[num2str(double(Pzn)),' < ',num2str(0)];
        disp('No se cumple el apartado 3');
        disp(leer)
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
        return
    end
    
    if abs(b2) > abs(b0)
        leer=[num2str(abs(b2)),' > ',num2str(abs(b0))];
        disp('Apartado 4 se cumple: ');
        disp(leer)
        disp('Matrix de Jury: ');
        Mj
    else
        leer=[num2str(abs(b2)),' > ',num2str(abs(b0))];
        disp('No se cumple el apartado 4');
        disp(leer)
        disp('Matrix de Jury: ');
        Mj
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
        return
    end
else
end

if Fts == 4
    disp('ESTRUCTURA DE SISTEMAS DE ORDEN 4')
    disp('    A1*s^3 + A2*s^2 + A3*s + A4     ')
    disp('------------------------------------')
    disp('B1*s^4 + B2*s^3 + B3*s^2 + B4*s + B5')
    A1= input('Ingrese el valor de A1: ');
    A2= input('Ingrese el valor de A2: ');
    A3= input('Ingrese el valor de A3: ');
    A4= input('Ingrese el valor de A4: ');
    B1= input('Ingrese el valor de B1: ');
    B2= input('Ingrese el valor de B2: ');
    B3= input('Ingrese el valor de B3: ');
    B4= input('Ingrese el valor de B4: ');
    B5= input('Ingrese el valor de B5: ');
    k= input('Igrese el valor de k que este en el rango de estabilidad: ');
    
    syms z
    
    num=[A1 A2 A3 A4];
    den=[B1 B2 B3 B4 B5];
    G=tf(num,den);
    
    Frmx=bandwidth(G);
    T=5*Frmx;
    To=1/T;
    
    Gz=c2d(G,To,'zoh');
    Gzc=feedback(k*Gz,1);
    [numz,denz]=tfdata(Gzc,'v');
  
% ----- Calculo apartado 1 test de jury ----- % 
    a0=denz(1,1);
    a1=denz(1,2);
    a2=denz(1,3);
    a3=denz(1,4);
    a4=denz(1,5);
%---------------------------------------------%
% ----- Calculo apartado 2 test de jury ----- %    
    Pc=denz(1,1)*z^4+denz(1,2)*z^3+denz(1,3)*z^2+denz(1,4)*z+denz(1,5);
    Pz=subs(Pc,z,1);
%---------------------------------------------% 
% ----- Calculo apartado 3 test de jury ----- %  
    Pcn=denz(1,1)*z^4+denz(1,2)*z^3+denz(1,3)*z^2+denz(1,4)*z+denz(1,5);
    Pzn=subs(Pcn,z,-1);
%---------------------------------------------%
% ----- Calculo apartado 4 test de jury ----- %
    b0=((denz(1,5))*(denz(1,2)))-((denz(1,1))*(denz(1,4)));
    b1=((denz(1,5))*(denz(1,3)))-((denz(1,1))*(denz(1,3)));
    b2=((denz(1,5))*(denz(1,4)))-((denz(1,1))*(denz(1,2)));
    b3=((denz(1,5))*(denz(1,5)))-((denz(1,1))*(denz(1,1)));
    c0=((b3)*(b1))-((b0)*(b2));
    c1=((b3)*(b2))-((b0)*(b1));
    c2=((b3)*(b3))-((b0)*(b0));
    Mj=([denz(1,5) denz(1,4) denz(1,3) denz(1,2) denz(1,1);denz(1,1) denz(1,2) denz(1,3) denz(1,4) denz(1,5);b3 b2 b1 b0 0;b0 b1 b2 b3 0;c2 c1 c0 0 0;c0 c1 c2 0 0]);
%---------------------------------------------%
    
    [p,z]=pzmap(numz,denz);
    pzmap(numz,denz);

    figure(1)
    axis([-1 1 -1 1]);
    zplane(z,p);
    title('Ubicacion de Ceros-Polos');
    grid on

    figure(2)
    step(G)
    hold on 
    step(Gz)
    hold on
    step(Gzc,'k')
    title('Sistema de Segundo Orden');
    legend('Continuo','Discreto','Discreto L.C');
    grid on
    
 % ----- test de jury ----- %
    NdA=Fts+1;
    disp('PARA REALIZAR EL TEST DE JURY Y SABER LA CANTIDAD DE RESTRICCIONES ES DECIR PARA EL ESTUDIO');
    disp('DE SISTEMA DE ORDEN N EL TOTAL DE RESTRICCIONES SE CALCULA N+1 DONDE SU VALOR EL NUMERO DE');
    disp('APARTADOS A ANALIZAR');
    NdA
    
    if a3 < a0
        leer=[num2str(a3),' < ',num2str(a0)];
        disp('Apartado 1 se cumple: ');
        disp(leer)
    else
        leer=[num2str(a3),' < ',num2str(a0)];
        disp('No se cumple el apartado 1');
        disp(leer)
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
    return 
    end 

    if Pz > 0
        leer=[num2str(double(Pz)),' > ',num2str(0)];
        disp('Apartado 2 se cumple: ');
        disp(leer)
    else
        leer=[num2str(double(Pz)),' > ',num2str(0)];
        disp('No se cumple el apartado 2');
        disp(leer)
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
    return
    end
        
    if Pzn > 0
        leer=[num2str(double(Pzn)),' > ',num2str(0)];
        disp('Apartado 3 se cumple: ');
        disp(leer)
    else
        leer=[num2str(double(Pzn)),' > ',num2str(0)];
        disp('No se cumple el apartado 3');
        disp(leer)
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
        return
    end
    
    if abs(b3) > abs(b0)
        leer=[num2str(abs(b3)),' > ',num2str(abs(b0))];
        disp('Apartado 4 se cumple: ');
        disp(leer)
    else
        leer=[num2str(abs(b3)),' > ',num2str(abs(b0))];
        disp('No se cumple el apartado 4');
        disp(leer)
        return
    end
    
    if abs(c2) > abs(c0)
        leer=[num2str(abs(c2)),' > ',num2str(abs(c0))];
        disp('Apartado 4 se cumple: ');
        disp(leer)
        disp('Matrix de Jury: ');
        Mj
    else
        leer=[num2str(abs(c2)),' > ',num2str(abs(c0))];
        disp('No se cumple el apartado 4');
        disp(leer)
        disp('Matrix de Jury: ');
        Mj
        disp('EL SISTEMA ES INESTABLE SUS POLOS ESTÁN AFUERA DE LA CIRCUNFERENCIA UNITARIA')
        return
    end
else
end