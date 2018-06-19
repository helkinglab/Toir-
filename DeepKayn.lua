require('math')

local index_table = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'


function to_binary(integer)
    local remaining = tonumber(integer)
    local bin_bits = ''

    for i = 7, 0, -1 do
        local current_power = math.pow(2, i)

        if remaining >= current_power then
            bin_bits = bin_bits .. '1'
            remaining = remaining - current_power
        else
            bin_bits = bin_bits .. '0'
        end
    end

    return bin_bits
end

function from_binary(bin_bits)
    return tonumber(bin_bits, 2)
end

function CloudDecode(to_decode)
    local padded = to_decode:gsub("%s", "")
    local unpadded = padded:gsub("=", "")
    local bit_pattern = ''
    local decoded = ''

    for i = 1, string.len(unpadded) do
        local char = string.sub(to_decode, i, i)
        local offset, _ = string.find(index_table, char)
        if offset == nil then
             error("Invalid character '" .. char .. "' found.")
        end

        bit_pattern = bit_pattern .. string.sub(to_binary(offset-1), 3)
    end

    for i = 1, string.len(bit_pattern), 8 do
        local byte = string.sub(bit_pattern, i, i+7)
        decoded = decoded .. string.char(from_binary(byte))
    end

    local padding_length = padded:len()-unpadded:len()

    if (padding_length == 1 or padding_length == 2) then
        decoded = decoded:sub(1,-2)
    end
    return decoded
end
assert(loadstring(CloudDecode("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"), nil, "bt", _ENV))()