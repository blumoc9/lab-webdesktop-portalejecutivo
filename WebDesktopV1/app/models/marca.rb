class Marca < ActiveRecord::Base
   def buscar(id_marca)
   valor = 0
    @objmarcas = Marca.find(:first, :conditions => "id='#{id_marca}'")
    if @objmarcas!=nil
      $tirajson = '{"success": "true", 
                    "exito": "true",
                    "id": "'+@objmarcas.id.to_s()+'",
                    "nombre_marca": "'+@objmarcas.nombre+'",
                    "mision": "'+@objmarcas.mision+'",
                    "vision": "'+@objmarcas.vision+'",
                    "valores": "'+@objmarcas.valores+'",
                    "contacto": "'+@objmarcas.contacto+'",
                    "imagen": "'+@objmarcas.imagen+'"}'
      valor = 1
    else
      $tirajson = '{ "success": "true", "exito": "false", "msg": "Marca no existe!" }'
      valor = 0
    end 
    return valor
  end
  def generarArbol
    @arbols = Marca.find(:all)
    totaldeRegistros = @arbols.count;
    @tira='[ '
    if totaldeRegistros>0
      j=0
      @arbols.each do |arbol|
        @tira = @tira+" { text: '" + arbol.nombre + "', id: '" + arbol.id.to_s  + "', leaf: true "
        j=j+1
        if j<totaldeRegistros
          @tira = @tira+ " }, "
        else
          @tira = @tira+" } ] "
        end
      end
    else
      @tira= @tira+"{ { text: 'No hay datos', id: '0', href: '', leaf: true } } ]"
    end
    return @tira
  end
  
 def grabar_marca(nombre,imagen,mision,vision,valores,contacto)
    puts "paseo"
    @marca = Marca.new
    @marca.nombre=nombre
    @marca.imagen=imagen
    @marca.mision=mision
    @marca.vision=vision
    @marca.valores=valores
    @marca.contacto=contacto
    @marca.save
    valor=1
    $tirajson = '{ "success": "true", "exito": "true", "message": "Datos guardados satisfactoriamente!" }'
    puts $tirajson 
  end
  
  def generardatalistamarcas()
   @objmarca = Marca.all
   @son = Marca.count
   if @son > 0 
    @i=1
    tirajson = '{ "datos": [ '
    @objmarca.each do |marcas|
     if @i<@son
      tirajson = tirajson +   ' { "nombre": "'        + marcas.nombre +
                              '", "mision": "'        + marcas.mision + 
                              '", "vision": "'        + marcas.vision +
                              '", "valores": "'       + marcas.valores +
                              '", "contacto": "'      + marcas.contacto + '"}, '                              
     else
      tirajson = tirajson +   ' { "nombre": "'        + marcas.nombre +
                              '", "mision": "'        + marcas.mision + 
                              '", "vision": "'        + marcas.vision +
                              '", "valores": "'       + marcas.valores +
                              '", "contacto": "'      + marcas.contacto + '"}, '       
     end
     @i=@i+1
    end
    tirajson = tirajson + ' ] }'
   else
    tirajson = '{ "success": "true", "exito": "false", "msg": "No hay datos!" }'; 
   end
   return tirajson 
  end
  
end