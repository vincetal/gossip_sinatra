require 'csv'
require 'pry'

class Gossip

  attr_reader :author, :content

  def initialize(author, content)
    @content = content
    @author = author
  end

  #Sauvegarder un gossip dans notre data base, à la suite
  def save

    f = CSV.open("db/gossip.csv", "a") do |csv|
      csv << ["#{@author}", "#{@content}"]
    end

    #On n'oublie pas de fermer le fichier sinon il y'a des interférences avec shotgun
    f.close

  end

  def self.all
    # 1)création d'un array vide qui s'appelle all_gossips
    all_gossips = []

    table = CSV.read("db/gossip.csv")

    table.each_with_index do |csv_line, index|
      #On lit toutes les entrées hors mis les titres (qui ont pour index 0)
      if index > 0
        all_gossips << Gossip.new(csv_line[0],csv_line[1])
      end
    end

    # 3)return all_gossips - on renvoie le résultat
    return  all_gossips
  end

  def self.find(index_of_gossip_to_find)

    #On sélectionne à l'index qui nous intéresse (les index commencent à 0 donc on doit faire -1 )
    return CSV.table('db/gossip.csv')[index_of_gossip_to_find-1]

  end

  def self.update(index_of_gossip_to_edit,new_author,new_content)

    all_gossips = []

    table = CSV.read("db/gossip.csv")

    #On lit tout le csv et le stocke dans un tableau, lorsque l'index correspond, on modifie la valeur existante
    table.each_with_index do |csv_line, index|
      index == index_of_gossip_to_edit ? all_gossips << [new_author,new_content] : all_gossips << [csv_line[0],csv_line[1]]
    end

    #Mise à jour d'un csv à partir d'un tableau de tablaux (copiée sur internet)
    File.open("db/gossip.csv", "w") {|f| f.write(all_gossips.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join(""))}


  end


end
