Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263C0107BCCB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Wg-00081i-UZ; Fri, 13 Mar 2026 12:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15WU-0007dq-7Z
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:03 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15WR-0001ku-OC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:01 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2adff872068so11598575ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419866; x=1774024666; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JGLutQXrBwXvmqxqYC9P00T7Z/rDIAIAlLQMTjMH/uE=;
 b=h37sG/cReBVOW2GhFQ4Hpcg3FK7WpG7vf1xzfQpNQmENy+jyE9upzsu/dIMjsuGSkF
 uaDPin4rdVYJEIh5Zpy1Fn4TwoP+T3Va4kb1XdFq1a84lkJzOIvsoqJ3jt+/lsTn7zcZ
 6iaGVhySuaIWAArvYWAoXRyUAXf3b9CiQ7VeHqJ0d1dt1EYMd6SIG63np8RNmJpZ1fEn
 6Alkz2hi3ciVuvRNnIxxvjZ0nTDFl/dmKr6uxd3r+PyAc5XDPvsjr/v/HR7hTAFHwb0e
 8f3NofIwFhby9ehskiIfU3Tf+5nlP3+ioaq/G5i9TLIHFIK6BiM53ZBsPfg2GOjHsQKk
 I9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419866; x=1774024666;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JGLutQXrBwXvmqxqYC9P00T7Z/rDIAIAlLQMTjMH/uE=;
 b=dkFeYCnZWQvW2NTr4FT+zz2e2qoTVSNuGtOSYQ4pN8nMcczWXg/Mqwm1cHLD2L7WBq
 fpeXrYveTD7AMGE11Pa6N69yHmy+rx0IenWaBVj4TjKW2RN1e2zxEu8E2wdfY4YGBV9k
 SUFLQ1w1epDt7/5lr6MZ+CmZDV6w1AVNNtGrGWEwwVRkW9F9MGLqn0JSKKpkBjKpHSn9
 SxdC5Fi3ZklHi4wQ3ydjyS69qFT1mod3XlKAJFZwip2cDpIkphIZ2MIYeKi95nAD8ciq
 D4zIAFTbssBUJ+8vv0WvD0Z7E1wklgRHAqTEdzTtlDk6/HcGlyJGyo+ytrMELFoZvZiG
 oyHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJb8eqzCAVTXDpjvdJYgSRIQ9DAP6jEisLUdeL4eRejq2AZIR6pS1MtyL56tg2EL5EE09xZhl/B17i@nongnu.org
X-Gm-Message-State: AOJu0YwmDeflX/JVvHj87i+9Jl0E3JsLRBw+LUhkcur+bZ7LeWmswl+m
 TZq0wP/Y6Z0VjpCT84VxbxlH3mWgJNmcPN5MP54d8vhW0zIjbAcnTyBe6CjadbirtTQ=
X-Gm-Gg: ATEYQzxtqyu6Qz8GLbEWxGjOl7aNO9JeHNNs8RlwxV5/lZgBvTqNZfGl+t2mv8wtMHt
 j1KzG84CsWMz/K9TKCEEA7IpGHNx0RqrmQD75A+bSEKhRSlWdlPrpE96iq59H0vWPMsLq7EQbEo
 NyONgvztVgiPr5fMCSvT3I48Sj7P5grtGc2YtPUSetYXe4ECMdKh8kk4RrU3UYLJTCVY33ph75B
 K8BnAZu5/kb8e3wxkfZbOyVZse+zEGX4+e0aHQTTN3g8xVzlJhaOiBPchVu4dlJPI0h6FLke4xK
 /+bzhKLgzuUqeMCD+9K7V4FB//SbwkEZ8XBTMuGgjoLiaxfeuQcEwl37eAS7T0YuojCdosoqJHa
 Y7KH/+Lm4KZmbi8zOT4qrX2e2EweI2JmLihYoSDnnMvCOiS/tipF+wN0c3yIKGR+XVrg3Dy5MzT
 W3UT05I4y+PX4+zbZugXzo6/BelvWKmNWv8ok619SFhV2e3W3Zp0sRFJIkuWzyuZmaxpk2
X-Received: by 2002:a17:903:2352:b0:2ae:b91c:1ac with SMTP id
 d9443c01a7336-2aecab19171mr35423355ad.52.1773419866450; 
 Fri, 13 Mar 2026 09:37:46 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece83b35fsm29990225ad.80.2026.03.13.09.37.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:37:46 -0700 (PDT)
Message-ID: <14bde94a-1096-465a-8665-2c06f3a4ed75@linaro.org>
Date: Fri, 13 Mar 2026 09:37:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/38] target/riscv: Include missing
 'exec/target_long.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-14-philmd@linaro.org>
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
In-Reply-To: <20260313062055.2188-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
> The "exec/target_long.h" header is indirectly included, pulled
> via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
> when removing the latter:
> 
>    ../target/riscv/cpu.h:605:1: error: unknown type name ‘target_ulong’
>      605 | target_ulong riscv_cpu_get_geilen(CPURISCVState *env);
>          | ^~~~~~~~~~~~
>    ../target/riscv/pmp.h:73:1: error: unknown type name 'target_ulong'
>       73 | target_ulong mseccfg_csr_read(CPURISCVState *env);
>          | ^
>    ../target/riscv/debug.h:139:1: error: unknown type name 'target_ulong'
>      139 | target_ulong tselect_csr_read(CPURISCVState *env);
>          | ^
>    ../hw/misc/riscv_cmgcr.c:112:15: error: unknown type name 'target_ulong'
>      112 | static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
>          |               ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/cpu.h    | 1 +
>   target/riscv/debug.h  | 1 +
>   target/riscv/pmp.h    | 1 +
>   hw/misc/riscv_cmgcr.c | 1 +
>   4 files changed, 4 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

