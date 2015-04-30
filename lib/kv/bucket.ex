defmodule KV.Bucket do
  @doc """
  Starts a new bucket.
  """
  def start_link do
    Agent.start_link(fn -> HashDict.new end)
  end

  @doc """
  Get a value from the `bucket` by `key`.
  I deviate from the tutorial here by not using the & syntax.
  """
  def get(bucket, key) do
    Agent.get(bucket, (fn x -> HashDict.get(x, key) end))
  end

  @doc """
  Puts the `value` for the given `key` in the `bucket`
  """
  def put(bucket, key, value) do
    Agent.update(bucket,&HashDict.put(&1, key, value))
  end


  def delete(bucket, key) do
    Agent.get_and_update(bucket, &HashDict.pop(&1, key))
  end
end
