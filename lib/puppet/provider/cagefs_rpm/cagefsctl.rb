Puppet::Type.type(:cagefs_rpm).provide(:cagefsctl) do

  commands :cagefsctl => 'cagefsctl'

  def self.instances
    packages = cagefsctl("--list-rpm")
    packages.split("\n").collect do |package|
      new(:name => package,
          :ensure => :present)
    end
  end

  def self.prefetch(resources)
    packages = instances
    resources.keys.each do |name|
      if provider = packages.find{ |pkg| pkg.name == name}
        resources[name].provider= provider
      end
    end
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def create
    cagefsctl("--addrpm",resource[:name])
    @property_hash[:ensure] = :present
  end

  def destroy
    cagefsctl("--delrpm",resource[:name])
    @property_hash.clear
  end
end
