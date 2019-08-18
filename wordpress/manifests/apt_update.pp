class wordpress::apt_update inherits wordpress {                                  
exec {"apt update":               
command => "/usr/bin/apt update", 
}                               
}  
