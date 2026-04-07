Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ABE10F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYPL-00019N-U5; Wed, 08 Apr 2026 15:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAYN2-0007F5-Pt
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:15:25 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAErR-0001PS-4s
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:25:32 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35c1a131946so188396a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600727; x=1776205527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y+yaQerDcJOL/yX8rMeZasSKndOjsZs1rKuP36Dpvn0=;
 b=ESSy5rs3zSDy6SKGW1Mx4RYLi1NZ2D0o8KZ7qRSq5mZxiNijbYOJWQCXi0bFoM30LR
 OveNU8nJL6RCJS1/ExEVBf1/bU0jlshzTo2WDUwmFUogX/mg84K0lCrlGU1/0glBvi2x
 lQ5wBZXJlUf1kFu9B7HL5Pvv6SaQOiD0rujwfL1wIYLb+juo0afr9uwqD9T79DvtSwsy
 Bwxez+ZEIcZvXRvbEK5HUMAnaOpOf6WPEatN+f79B0srdZwK2JkDX0V44vzrtjY7SEL3
 b/icn5sWcB8DndCOCvFiI7MUY77cGC6Pp+rhfjnSZbf6zxd09Sl/MZPuN05eUni2I3vR
 zu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600727; x=1776205527;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y+yaQerDcJOL/yX8rMeZasSKndOjsZs1rKuP36Dpvn0=;
 b=XtcF/IhoZ76a5R5Hs7rqt2DRKNwI3E9SBnWp3xngNq2tSqjELVBr3etkISno0j495H
 o23iVa7RNY/3QM91hIP9R5ye2hLChPuYSpARKnsxHzN8DwTCwkbJVkNmi2Gg3t1YfYND
 /e+GVl8t8ISHwamRvfq2W7pMUxSQYARGtZ9fOr1BSvivBzQ9TDSvNMkajiDL3hGUR50B
 2JGa6zy3JvBUOfEthCySyA45cr83KdpSo73ijFmtYV/CylgTDAMqBISMFCA933+wSV6U
 K0xdMaPi9lAgBJ0O+vXcFxLW7qBTg0U27KEyaJiEAQy7lXTWtTRNDY7ZIEYYF+Sl2w6m
 fwcQ==
X-Gm-Message-State: AOJu0YxM321g2zFGJtIDR7WwBbWRMjx8UdQZDsPY7/ko9u44r41pfeLF
 8NxJq7j/HgcVvADqJT2ups2+eRBF0La3jok54HqwdaB/E169E4d9X6k2PuK+bEPr+6ceoNvDotj
 y5aBpByo=
X-Gm-Gg: AeBDietEOCHZTvc35POKkdnhVEVg6OvHK1Adoau92P5zjL8OxGfb+wml8lcOAOgkshO
 kXCnrZXCFi9/aIONusfe0TwF0Suq8mqMUdY/tPju/h4NJ8tdKJ3jl4bjyjpLmDJKDiX5agNNuFM
 0T840WM92hysv5TA0oQx2Tku8IMsNDyEwHWTt4F3azwTJD3GytdSmOwhEVjxmDNhht7AAfPmQ9q
 724g7u+K3YTB8tRZDK34g9qyopwbBaEvPIly9FJRdd3DWs1vimcmXXagbsjyFm4uYkcp94/O4wt
 pEO498pX/OBRppzYmrO8gEGyCWC/THVzXA/MBOsRMGafNgOSqm8NlN6SuWeIZXjMzu0i/XSUKr9
 A+hXxk3e/0WvfKD9aQMEZosMMjBJtjcZv5HtARvH0qNyi972DzFbhkULQ9kvnFwXi2MGzwXIQ2h
 wL5l//lhhC5eqUmrA1tog/8lwh8H4aBLank459JdF89Qg4GXAY6BBlp5CsMrvOz17Ih2La4g==
X-Received: by 2002:a17:90b:1e49:b0:35d:9d5d:10bb with SMTP id
 98e67ed59e1d1-35de57b10a3mr14191200a91.0.1775600727278; 
 Tue, 07 Apr 2026 15:25:27 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35df82368f6sm11184253a91.12.2026.04.07.15.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 15:25:26 -0700 (PDT)
Message-ID: <eeb4e2bd-8765-41a5-a8f3-9c2bc48c9e43@linaro.org>
Date: Tue, 7 Apr 2026 15:25:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/21] target/arm: single-binary
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
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
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 4/7/26 12:59 PM, Pierrick Bouvier wrote:
> This series tackles (most of) the rest of target/arm, especially tcg folder.
> 
> We extract tcg memory operation in a new header, with a new type representing
> virtual addresses.
> 
> Initially, I went down the way to have a dynamic definition of TCGv, which
> required much more boilerplate and runtime checks. After discussing with
> Richard, I realized it was not needed, and that could simply split 32 and 64 bit
> properly in different files instead. This approach will not work with other
> architectures, requiring something else, but it's enough for target/arm.
> 
> Files left are:
> - target/arm/tcg/mve_helper.c
> - target/arm/tcg/m_helper.c
> - target/arm/tcg/cpu32.c
> 
> v10
> ---
> 
> - extract patch for endianness handling in arm_disas_set_info
> - added some comments
> 
> v9
> --
> 
> - introduce aarch64_translate_code *before* adding parameter to translator_loop
> - use TCG_TYPE_VA as address type for translator_loop
> - remove inline marker on functions merged from arm_ldst.h to translate.c
> - refactor arm_ldl_code/arm_lduw_code
> 
> v8
> --
> 
> - make translate.c compilation unit common.
> 
> v7
> --
> 
> - add parameter to translator_loop to indicate address type for current tb.
> - remove TCGv from target/arm/tcg/translate.c
> 
> v6
> --
> 
> - meson.build: extract decode files in separate variables and explicitly include
>    them in user and system code. The duplication is now minimized: one instance
>    for all system binaries, and one per user binary.
> 
> v5
> --
> 
> - reimplemented what v0 did with new approach defining new tcg-op-mem header
> - reapply all straightforward patches from v0
> - only translate.c is left, but first want to validate that changes here are ok
>    for maintainers before doing more.
> 
> v0
> --
> 
> See original thread:
> https://lore.kernel.org/qemu-devel/20260109053158.2800705-1-pierrick.bouvier@linaro.org/#t
> 
> Note about v1 -> v4
> -------------------
> 
> - After v0 which was trying to do too many changes, v1 to v4 focused on smaller
>    things, and all patches have been merged already.
>    https://patchew.org/QEMU/20260219040150.2098396-1-pierrick.bouvier@linaro.org/
> 
> Pierrick Bouvier (21):
>    include/tcg/tcg-op: extract memory operations to tcg-op-mem.h
>    target/arm/translate.h: remove tcg-op.h include
>    target/arm/tcg/translate.h: remove tcg-op-gvec.h include
>    target/arm/tcg/translate.h: remove TARGET_AARCH64
>    target/arm/tcg/translate-vfp.c: make compilation unit common
>    target/arm/tcg/translate-neon.c: make compilation unit common
>    target/arm/tcg/translate-mve.c: make compilation unit common
>    target/arm/tcg/translate-m-nocp.c: make compilation unit common
>    target/arm/tcg/op_helper.c: make compilation unit common
>    target/arm/tcg/gengvec.c: make compilation unit common
>    target/arm/tcg/translate.c: remove MO_TE usage
>    target/arm/tcg/translate.c: replace target_ulong with uint32_t
>    target/arm/tcg/translate.c: extract aarch64_translate_code()
>    tcg/translator: add parameter to translator_loop for current addr type
>    target/arm/tcg/translate.c: replace TCGv with TCGv_va
>    target/arm/tcg/translate-a64.c: use translator_ldl_end instead of
>      arm_ldl_code
>    target/arm/tcg/arm_ldst.h: merge in translate.c
>    target/arm/tcg/translate.c: replace translator_ldl_swap with
>      translator_ldl_end
>    target/arm/cpu.c: simplify endianness handling in arm_disas_set_info
>    target/arm/tcg/translate.c: remove target_ulong
>    target/arm/tcg/translate.c: make compilation unit common
> 
>   include/exec/translator.h        |   4 +-
>   include/tcg/tcg-op-mem.h         | 126 +++++++++++++++++++++++++++++++
>   include/tcg/tcg-op.h             | 100 +-----------------------
>   target/arm/internals.h           |   2 +
>   target/arm/tcg/arm_ldst.h        |  47 ------------
>   target/arm/tcg/translate.h       |  14 +---
>   accel/tcg/translate-all.c        |   1 -
>   accel/tcg/translator.c           |   4 +-
>   target/alpha/translate.c         |   3 +-
>   target/arm/cpu.c                 |   6 +-
>   target/arm/tcg/op_helper.c       |   1 -
>   target/arm/tcg/stubs32.c         |  24 ++++++
>   target/arm/tcg/translate-a64.c   |  17 ++++-
>   target/arm/tcg/translate-sme.c   |   1 +
>   target/arm/tcg/translate-sve.c   |   1 +
>   target/arm/tcg/translate.c       |  73 +++++++++++-------
>   target/avr/translate.c           |   3 +-
>   target/hexagon/translate.c       |   3 +-
>   target/hppa/translate.c          |   3 +-
>   target/i386/tcg/translate.c      |   3 +-
>   target/loongarch/tcg/translate.c |   3 +-
>   target/m68k/translate.c          |   3 +-
>   target/microblaze/translate.c    |   3 +-
>   target/mips/tcg/translate.c      |   3 +-
>   target/or1k/translate.c          |   3 +-
>   target/ppc/translate.c           |   3 +-
>   target/riscv/translate.c         |   3 +-
>   target/rx/translate.c            |   3 +-
>   target/s390x/tcg/translate.c     |   3 +-
>   target/sh4/translate.c           |   3 +-
>   target/sparc/translate.c         |   3 +-
>   target/tricore/translate.c       |   3 +-
>   target/xtensa/translate.c        |   3 +-
>   target/arm/tcg/meson.build       |  57 ++++++++++----
>   34 files changed, 304 insertions(+), 228 deletions(-)
>   create mode 100644 include/tcg/tcg-op-mem.h
>   create mode 100644 target/arm/tcg/stubs32.c
> 

v11 sent:
https://lore.kernel.org/qemu-devel/20260407222208.271838-1-pierrick.bouvier@linaro.org/

Regards,
Pierrick

