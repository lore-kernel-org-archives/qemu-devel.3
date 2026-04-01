Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AD510F6FC2
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7x3z-0002Ht-SZ; Wed, 01 Apr 2026 11:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7x3s-0002DB-VM
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:00:54 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7x3q-0003mf-7C
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:00:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b0ba3bfe16so7973205ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775055644; x=1775660444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q5fTdhUJ4bi35kjSnsz8ISFDP8khu5ZOGtPMq6dHRXo=;
 b=mXxU7lzouQC+joPvzTTEw11f2EalLw5f0zVA4wQu20jR/wslCiHTipnqE/uvodfOhp
 q/NXTkmos89i2XrzIAyzec/yXrD7F96aWKUzDvUGGipHf8oy5bW+6u1b0xReOAERwZkw
 WN+g/Eko23gQjrocj35yfzq9nPFWB00YngtRwD+1nq9VTAe/omRsUFUfAVzliy6zC7ue
 50gnNI8Xg8qFNLewI3g97IhUjJL6+NmRoC8SD1Zj9ho4uTf4Srqg5kaalDmdFUPS/MvF
 df0oi25JQjga8LncpvA1G+0yzJfTr5+NGvHkQtMDfNpSsNEZzoxsHs1SsrSdCDX+zzSi
 fxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775055644; x=1775660444;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q5fTdhUJ4bi35kjSnsz8ISFDP8khu5ZOGtPMq6dHRXo=;
 b=dzuDGU9MfVfBtBAIFBlp6NS0a2awoOifJPl68uVyzDwC4wK86n4GxvJAbWOMHZDdc8
 3a2NgE7687RpQT71GbNGs6XxcdVHYbK3m7BLS+vN5qYcREKSuohs58oe/cCw1LgC9nKo
 yKPIMW3q6dug5OSGtpcBU789++1pPt8LRGqylF1rpokdXNO7DMHmZyfYtrTcHKa010n3
 CxUqMdzOZ8Oc+DTvPffVLEWD9LLCRtfSZcLVJNsdI9mPlqFNZmamnxX4KtM7CZX0Rssw
 6ka7QdXZIUtVNLpvlVqMiFK5hlwj+MyupIRuYKJ2LQ8zWbJ4E0ATOmq7LWkPTvOzzxrO
 U+gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTSB5a3SOJw9NfWXlXp/J0ppPmCLe8L7cQ9F2IUmh7BvvLxBmbMinwe/ZH/kq5b9JCatHqQQc9nOwT@nongnu.org
X-Gm-Message-State: AOJu0Ywat/mHgj+4fS+on2mdo/1RISk2WPvfGb2KdgeApD1fhFWcoONc
 S8O5YA29XBtzhaMMcj2yAnNtuVqBWGkAHs7BGSylSdn3RVtoiyGxTjCYbygM7le2Ioo=
X-Gm-Gg: ATEYQzzuNNjMPVKafNwo8mZkZ5pz0j/erVkDrZhlta4fgGT0B70y0itG/RRIJcCUbWj
 d2FaFNxz7omqV5b5Au/eNCuHBvWtBIiSLI/giUryL5hKNSj7HeT33+huIALEVtCrBFx+KaS84nq
 doFUMuBzAHWvmPI4U1uI1s5Mcs+tueifY7YiN1SwHC0foK8ahRbH3As2Jzhu3SsUbKYmIIKQdAR
 KqtNmbM1lUxOrfDitvIviYExsk+mNqIhQ4GS3S3fnppsfKLoyI0HaUZo4ZenVrCVda0CR1MGz2y
 sxcwE8Dyu1n63TwSuJuXqttDaYlrNnx21CH38+QcJRX9IzS9XRLGnMVunl0vw58ohCXMkAFm4Gz
 t/69x+XVixlYiWf4mX5DSufyQ14fXPw/ulwP0J8APhTJ5VJsWpZ6U5FcxwlXpvzylhD15sixB3f
 Ld6C0tEGGNfdo9DeAk3pgRYOVVoJY2uhTq7/V0jYjLT/KAtUjoFzoKegmK6R8DphQYegC5
X-Received: by 2002:a17:903:1a67:b0:2ae:5a38:96bb with SMTP id
 d9443c01a7336-2b25ee79daemr74873145ad.2.1775055644239; 
 Wed, 01 Apr 2026 08:00:44 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749b66aasm300555ad.68.2026.04.01.08.00.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 08:00:43 -0700 (PDT)
Message-ID: <03df34f1-674a-4e52-bd22-ad77e7884b6b@linaro.org>
Date: Wed, 1 Apr 2026 08:00:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 1/2] target/mips: Expand TCGv type as 32-bit for
 XBurst MXU
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Siarhei Volkau <lis8215@gmail.com>
References: <20260401144503.80510-1-philmd@linaro.org>
 <20260401144503.80510-2-philmd@linaro.org>
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
In-Reply-To: <20260401144503.80510-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/1/26 7:45 AM, Philippe Mathieu-Daudé wrote:
> The MXU extension is only built as 32-bit, so TCGv expands
> to TCGv_i32. Use the latter which is more explicit.
> 
> In gen_mxu_s32madd_sub() directly expand:
> 
>   - tcg_gen_ext[u]_tl_i64 -> tcg_gen_ext[u]_i32_i64
>   - tcg_gen_concat_tl_i64 -> tcg_gen_concat_i32_i64
> 
> the rest being mechanical changes.
> 
> Cc: Siarhei Volkau <lis8215@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/mxu_translate.c | 1954 +++++++++++++++----------------
>   1 file changed, 977 insertions(+), 977 deletions(-)
> 

Yes, it's the kind of changes we should do, but as you see, it's quite 
invasive and produce massive patches that can be hard to review.
That's why I'm more in favor to keep TCGv and all tcg_gen.*tl as it is, 
and add magic in header to compile it as expected.

That said, there is nothing wrong with this patch, I'm just questioning 
the approach for all other targets.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Regards,
Pierrick

