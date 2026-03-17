Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C62FEDA0E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Zk4-00085z-UZ; Tue, 17 Mar 2026 15:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2Zjz-00085I-62
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:06:07 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2Zjx-0001MM-AF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:06:06 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-829781b2b01so3835575b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773774363; x=1774379163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=44pufdjllse/q9zPFVcjE5oX+AdIjw5rKqUKleVgZeM=;
 b=rX2K3XaPW9qICUf7LPHsAtc4cBB/ymQZnDvQDfLZZJtxxBygNuU9+QJJkzlw+nBauC
 dT+S4rMrcr2uqkJSNVcRkgofLm6rzlqBNXlY0Jzsfh42O3RFI7LZEJUcN08SNxZKmqCw
 /RIcUywQ1kpVXr5bH1ar8VbLRng8aH3XXwquGT0QDCistuuE3Xu+gbU+8VLLrGj9BgEl
 LrdOM25gPSYD7l24rcZ+GDYPK6s2CytApu6B+/MHZY0TuFqQBahXgIqCr+COIXmkhgKm
 s7Bgt4st36eQJa1DGYMu18ptG/lAbQi3W2uwlSCGdANfVIQwxhEeE3o6dSXgq7vl9ks2
 yzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774363; x=1774379163;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=44pufdjllse/q9zPFVcjE5oX+AdIjw5rKqUKleVgZeM=;
 b=ey0AXRmCxFCSqeZa7oSpI6vixF5eu5lKOcc0Rz4jgotRbnMnn9qo3xxDBEIf7ATE0T
 kTMc38wp6GCWGa4x+l2ppLXmyLjSpMcC53qLGZQLJ80Eud8ed1FJwwMRj/L/9E0RttF6
 D69Tb7K85aB2fJI1e2GJ+QshodIDMRUOhG3pnG0O24SnQkIzykfFGWruTNnWZER/vzOB
 CDFBSe4e3m+iiqP9GXO8bvZ/ZlRuSobQ92jL0DvTeSiYmBXlnnTGevPHcaZNW4Qm5Q62
 Y9nWBvKyuTnft3CFxP497bZnz7StpL74kI1ecxvIIXIpy4nrF8z+nWevVdy/hENigr/1
 Z8YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhxyPfy71hJQwlJwa16r+TCSy8CcFTsWDCPonOh8xrAvwkxQ2LPMn+fNFQJ5d+ksj+w60JAPvxR82k@nongnu.org
X-Gm-Message-State: AOJu0YyXyWG05Tdge8ZsQcA9cKG7/nbDlxkcQL6JlBO+SLSiY8nf7Od0
 CZZMreEc4duJ/+HcOPw/UEqcc2yY6vHci0b9TBovMkhlV4dPuSPoVti+9dKmpaRKlcGBw9DwxSR
 TrDLmZPY=
X-Gm-Gg: ATEYQzwO0piCPm1dEZXj7alRNAU8oKr3WBXH55cmS03gIbdTb9zZDUPw53eu4t20fyh
 u4agH705TvSwxUVpp1Jm2WrLrQPpiBvAuAQD3veYTUh72j9b/jQV+cbhtyQsoCBAeXh7FT9tgW0
 wUYXb3w7sMahFfEuxTU+8HR5ae4dC5eO3/RB/8tbMdXj91fVVqT/HZ8d3BXQStygw08ZQEf4L8x
 guSBqluo1e1UDfuoF51RAgkZ3Otnr7U8zDHXQU9HhDFlqtkUh1zDyO6kWAPzlTamYmjC3/idjr0
 /puPGXHf+zmwfs5cIXtB/FUxIylacZ6BBSOwa+o5qPD+tWyARgp34KsjXl06jRBlR3VaN8ke1zj
 PS9r/jIdznHQjvSdepbme3v6fpPTX+I8ucr53+/+twzpX5AxMm/hH2Hp8nsdp0FgnjQSXcii+Ip
 sPN7OeHceqngW5eZLDlG9JyRqDV+OPf4J218XA0Hfb1/Y/LAhVkOBVCpVQ9eMgrA1wSEGd
X-Received: by 2002:a05:6a00:1a87:b0:82a:6125:728f with SMTP id
 d2e1a72fcca58-82a6ac9289dmr396046b3a.10.1773774363331; 
 Tue, 17 Mar 2026 12:06:03 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6bef9a32sm185304b3a.58.2026.03.17.12.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 12:06:02 -0700 (PDT)
Message-ID: <f36ee2a5-faeb-443e-bd08-161a2494d15f@linaro.org>
Date: Tue, 17 Mar 2026 12:06:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 v2] plugins/api-system: Handle migrate_add_blocker()
 failure
Content-Language: en-US
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, erdnaxe@crans.org,
 ma.mandourr@gmail.com
References: <20260312121617.228654-1-vikingtc4@gmail.com>
 <20260317134733.126584-1-vikingtc4@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260317134733.126584-1-vikingtc4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/17/26 6:47 AM, Trieu Huynh wrote:
> migrate_add_blocker() can fail (e.g. if migration is already in
> progress), in which case it returns a negative value and populates
> its errp argument with the reason.
> 
> The previous code ignored the return value. Pass &error_fatal so
> that on failure QEMU exits cleanly with an informative error message
> rather than continuing in an inconsistent state.
> 
> Resolves: CID 1645470
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
> v2:
> - Pass &error_fatal instead of returning NULL: the plugin has no
>    recovery path, QEMU should exit cleanly with an error message.
>    (Peter Maydell, Pierrick Bouvier)
> - Remove manual error_free(migration_blocker) + migration_blocker = NULL:
>    migrate_add_blocker() already does this on failure. (Peter Maydell)
> ---
>   plugins/api-system.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/plugins/api-system.c b/plugins/api-system.c
> index 9a70b9caa6..fbf905cd63 100644
> --- a/plugins/api-system.c
> +++ b/plugins/api-system.c
> @@ -108,7 +108,7 @@ const void *qemu_plugin_request_time_control(void)
>           has_control = true;
>           error_setg(&migration_blocker,
>                      "TCG plugin time control does not support migration");
> -        migrate_add_blocker(&migration_blocker, NULL);
> +        migrate_add_blocker(&migration_blocker, &error_fatal);
>           return &has_control;
>       }
>       return NULL;

This looks better.
Just a small process nit, new versions should be posted as a new thread, 
and not as a reply to your previous version. No need to repost though.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

On error, correctly prints:
qemu-system-aarch64: disallowing migration blocker (--only-migratable) 
for: TCG plugin time control does not support migration

Regards,
Pierrick

