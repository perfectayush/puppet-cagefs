Puppet::Type.newtype(:cagefs_rpm, :parent => Puppet::Type) do
  @doc = "Manage rpms in the cagefs template"
  ensurable

  newparam(:name, :namevar => true) do
  end
end
