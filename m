Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABE6106FD7D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 05:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vRs-0001yV-U6; Fri, 13 Mar 2026 01:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0vRg-0001wo-Ry
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:52:24 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0vRe-0008Vx-TR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:52:24 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a871daa98fso14146885ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 22:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773381141; x=1773985941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GFxExgIj4U1IdgE2+Y7MdGEwnNflsYmW3fpFNaKPqXc=;
 b=JiOc1LCC3FcXiiYb1er5LOO36OVxxqWgkGtk9gWx/DrEhKnK1fEKun9mAB17wM8riq
 /ClxlJhrM43z8ZKOz194N87/OqdA++nZgtob7zIudDUAFCaW0fDZ3BS0oXa2g95DYd1W
 EPblTy+cuzycal/GPnd+PRupRssDdq9BN2mUhJ2iMaKGy1g7EevNcgZTchdMgn63meBt
 o/TOk4RQvAz2Y4WdfEAZ8ibrxIH+HwUtQJCFk6ETQhxZ6sSi1VeRuQ3A68avLSamJ7td
 fGjH9nEPjfx6JAiP1JIjq6mLX+wchmU2263da+1yKRHinY6e2B7r8oNgB0BOWIB/UpgP
 AjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773381141; x=1773985941;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GFxExgIj4U1IdgE2+Y7MdGEwnNflsYmW3fpFNaKPqXc=;
 b=sTPAGrXwSk8mX5+kMGdZTQqgKdZpZUWJ+gyOyO2peMiChB5/7yzBV5mzTNo+E939s6
 LmrXGpBqCzkaTGRe8FCysx4VCu8AhSeRfxbZJFDOJAwTiBLNnvUvfQ7vwUjY2gveClaC
 9rTT2R0Qcx9pz1xy3Fa2u4y5OXe5WZ6I79xhTykYtLJ8oAa0BDn1kJVouwF6fjd9GWsv
 FZ9wwksW8G82om0FH0rC6uOnS37pRGLHxcGucMg+p2oiJuLZPE48jKa53/uZLY6Oyxr6
 SbmawRGFFwhRpnZJmstlzUyIHn3qXzzjeSJIeAJck7JFq8qpjideSHJC764VJHFfsyb/
 9qRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd4+hyeML4zcNngF5DgYM19XCiLf0d8q8hfVDS/itoTGXruvBFBdoJjZnh83tod4gzxVxyln5VFdid@nongnu.org
X-Gm-Message-State: AOJu0YyAxau2dRi9eVEWDGRTXTbxSpO4oh6B9ynNjX5WqcDSEvaF+uRY
 PLVK+unFfiJJfa4FD/UyBJhGgVCaGl2kA4v68TdeVszYCjkmQ5nmcfWE15X1VrdLaJUh5fQoH24
 1damHOyM=
X-Gm-Gg: ATEYQzwS1w5rlssvGt0TB2g4C5haMWZo6CJ/MAhZy+UmbrHBL4epGcQSWTNWGN3wD4D
 Wy0hflwR91GVEXNKXeEdiv9xPySku2mAuUiFWCyVcIhVQbo7iI3YzcYccGqwSrFaFOmIIJi4IHQ
 uGpFnjAmtJP4Tf9DQRFjyRy/ddbBCdCT5+7QeUaSl3g9f67y/2ush0tV1B1izVjHqCwRN4YuqP/
 yONPGYzJ+wvsiKLYEhb+HNyqxAQ5oY+adql6KQ8j0xp+Jp2EiLWQSVhoGZo+PMX7xcBrTZI/9VL
 jT/zD9ZjzS2+IH54Ah6SY42W2C/DueRUMV9FRFkZ5WmQIrjJjepJQdBj6vCChSlhHKUKOUXwjmW
 xiIi1VfGxCuz3SUKHbTouT7ZO4+f2Jk2bUTOHjsn3g7KA5M3mcBHQrVSvv3zBm5ERJzlQ12tqzw
 tN0BweKb3EpeUEiGSirpfceicK/Xq2YgVL7blla/YMPicGJl8O/9fQOV8gL1hzz77YgLFO
X-Received: by 2002:a17:903:18b:b0:2ae:804f:5640 with SMTP id
 d9443c01a7336-2aecac9c348mr19579655ad.51.1773381141034; 
 Thu, 12 Mar 2026 22:52:21 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece416212sm10011725ad.0.2026.03.12.22.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 22:52:20 -0700 (PDT)
Message-ID: <cb7cf2e5-8fd6-4e59-996a-dbe937be6fcb@linaro.org>
Date: Thu, 12 Mar 2026 22:52:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm/cpu.h: restrict cpu-defs.h to target
 specific code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260312224702.1608408-1-pierrick.bouvier@linaro.org>
 <20260312224702.1608408-2-pierrick.bouvier@linaro.org>
 <719ac842-22be-4617-8b87-02424f2b9ea5@linaro.org>
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
In-Reply-To: <719ac842-22be-4617-8b87-02424f2b9ea5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/12/26 8:48 PM, Philippe Mathieu-Daudé wrote:
> On 12/3/26 23:47, Pierrick Bouvier wrote:
>> Allow to use this header from common code, which we do in next commit.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/cpu.h | 2 ++
>>    1 file changed, 2 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 657ff4ab20b..b8042f65bb4 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -25,7 +25,9 @@
>>    #include "hw/core/registerfields.h"
>>    #include "cpu-qom.h"
>>    #include "exec/cpu-common.h"
>> +#ifdef COMPILING_PER_TARGET
>>    #include "exec/cpu-defs.h"
>> +#endif
> 
> Since there are no other uses of COMPILING_PER_TARGET in this
> header, this clearly mean "exec/cpu-defs.h" isn't required here
> at all but elsewhere:
> 
> -- >8 --
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 657ff4ab20b..445d5a8a31d 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -25,7 +25,6 @@
>    #include "hw/core/registerfields.h"
>    #include "cpu-qom.h"
>    #include "exec/cpu-common.h"
> -#include "exec/cpu-defs.h"
>    #include "exec/cpu-interrupt.h"
>    #include "exec/gdbstub.h"
>    #include "exec/page-protection.h"
> diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
> index 5b248fd7138..5603c9941a7 100644
> --- a/include/exec/helper-head.h.inc
> +++ b/include/exec/helper-head.h.inc
> @@ -46,6 +46,7 @@
>    #define dh_ctype(t) dh_ctype_##t
> 
>    #ifdef COMPILING_PER_TARGET
> +# include "exec/cpu-defs.h"
>    # ifdef TARGET_LONG_BITS
>    #  if TARGET_LONG_BITS == 32
>    #   define dh_alias_tl i32
> ---

Yes, that's the right place.
I was tempted to moved it there, but decided to stick to target/arm/cpu 
header instead. Your idea is probably better though, feel free to send 
patches for it!

