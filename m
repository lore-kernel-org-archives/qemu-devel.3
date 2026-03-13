Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C38107BCCA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15YU-0004VB-H1; Fri, 13 Mar 2026 12:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15YS-0004N0-VB
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:40:05 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15YR-0002Jo-4m
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:40:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ad9a9be502so14980265ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773420001; x=1774024801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s1nPyqwRv+2eNeYWC3mejRxnuVPc13F88Zlj0xpHMo4=;
 b=e5z6/0cF+htLFR/Zs7RRe3ECvOgoSS2qYk6nPk5qTBC5/MMKbi14IEHj0i+JZzZyVZ
 mxuWZ2yRWfR2K4grIAbfqKkOeUQl0rqJUeBCLq8s+9UXA0VxmTv+XGqDT+SKZVYFVB70
 OrIQC2la7trfQK42D2C8WTBc/D1Nxgxt2780vM9Q2Qg6nMyUNYmuRhY9eQlShT5MwD6w
 ajXn2s+qKgRolw8Q83ByQSBysOvjO/XMNBa8Tfpsr9kZD++rMCdPUJ8Wy37R0WrsMnKd
 NezRd2Fqx5fq7MeIdwLWdvYX8hb3XDt1ChUgtoo/SdewZ725F1WTxhnd7j08NR+S7Bi6
 BGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773420001; x=1774024801;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1nPyqwRv+2eNeYWC3mejRxnuVPc13F88Zlj0xpHMo4=;
 b=bsjhFRJBMV/LNggiwQN6xfK7kH4C1PmAUYeuAOCcfrfpRsI8TmT1EQ05bVPCIopwuf
 y2/3jEXfC1Xkv8enlYOFUl5oCeXj15WgHq5DQP3Xxb+FpksQ9xcC10roNo5Z+JZexj+i
 vmS2asbCFnSnnAaGCRWUz2nR/gYU8K1/w1ZtSHqB2+dT2xNRBsJ7xOwre376h5MIeZuX
 8VbASxdhl0aQJzp2WHCeiFPO6Q0ZA4oNL+9fgjGzeyycHovawV28eMiyAdYXyamWIQx7
 ai0j6rdbd24TUnVOrzab14awV7/0KpKPaMh7dGPIAqUGwBUe1ZxF1VYA1nShOA+q/FI1
 Gi3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPw8QiyZh8m0/XdkMNIYqXVPu7jDnXqih32Ujv15RH10x0+HhvPxZM5nNwQWZT8N4+4EDFRNvAxpUo@nongnu.org
X-Gm-Message-State: AOJu0Yz1V74kXJjSICybMlwBcS68te9EQwC3KaQ61SDl1Ev/VzfggP8/
 B0gnrtzgwpzjAMvqfXCxYevMqBwYPRcmieDdVYbZr9r2gfhyuvECdPJNPVJCel3xqkY=
X-Gm-Gg: ATEYQzyPkPMm+429x+hIni5u3UGuPKHeOKsHfKSLhLXNRlU940zEPL7C7jFJlm2N2lw
 CaArhM5o8UzMXNi+URxjlotMfI7AagPXewcG8HtRjpQWK+XwHvpJZaXeLu/KcoV1Y2qC4N+Z1dg
 S/qhknazXDassxj2jSDHyLlWf17zAQ97yNB055VwqyOVJdWg1Ty0rNIL6hls1n/MUkTRiYzhvnC
 BVC0O07tRuUx+O8vrekKCsiqyOBCmJN0/xVh01jQznvSwjX0knxpjR/CIh9IQnMZ0PX1mW0h3nu
 M33fgB8W9JNnsu1UVwQGfSuZ/Xw/fjnQ4YzJhv8YSpS75YCD6hWghjnRaObmUsWGMQGoZPk0bsk
 nSn1G76ROtptCpdbCdif/ap4O8D6Sh0KZhdk9uG6Mro0fT89NeqqP4KoMAp3otQde/lOfEA8vUl
 vekHW5vTg6LZpHD/Kjz0moNmKqmuhol9n86FpntDXUHpL/M6piZRSuAmIbDIITgQ9SxBaD
X-Received: by 2002:a17:902:dad0:b0:2ae:57e2:9b32 with SMTP id
 d9443c01a7336-2aeca9b8bcbmr40044595ad.8.1773420001453; 
 Fri, 13 Mar 2026 09:40:01 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece627683sm25163655ad.32.2026.03.13.09.40.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:40:01 -0700 (PDT)
Message-ID: <dcb2fb99-8a26-41fc-9552-aeec575d2e88@linaro.org>
Date: Fri, 13 Mar 2026 09:40:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/38] hw/riscv: Include full path to target 'cpu.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-31-philmd@linaro.org>
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
In-Reply-To: <20260313062055.2188-31-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/misc/riscv_cmgcr.c           | 2 +-
>   hw/misc/riscv_cpc.c             | 2 +-
>   hw/riscv/microblaze-v-generic.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

