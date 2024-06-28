Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F30C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFEw-0001Yp-9Y; Fri, 28 Jun 2024 13:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNFEt-0001Xi-5W
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:18:23 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNFEp-0001y2-Kf
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:18:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so6777475ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719595098; x=1720199898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B06FeOC/VxpOr7DtLjpCDl47O7wMugTmDtSiZ9we2i0=;
 b=nXI1P92FEdTIMfd2LlRbYBqkXdup25S2Tez4Uknz9fEnr7/laCOuKThbHF81wVPK3k
 Hj2QgzkEEUDqeDs55VDXxlHjrMHPxbjLJJ7wEoMYiOFYBcqO8jmXvrvPy8hijq3BVuGF
 KpUAnCZxLXGqfg9jVvl5Fk0fcSi28EeXx+wIyg0VItddR1frCQXB0otLinaD52L+iim1
 eSjy82rGWyC5ROPKIq39YxnMwSNG+YPF/NUwpQbz02J8UizxwKbR+qkkoYQsl2O16fHj
 Obrsfgc51+1/hlA/PHxXQNEZOFLXbP/pvHALM1+dfqB2G9nEKwcUGtp1LYwrjNVsGhx8
 tkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595098; x=1720199898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B06FeOC/VxpOr7DtLjpCDl47O7wMugTmDtSiZ9we2i0=;
 b=jFu4vL8BHzdzFnL+7gvdxExRQVxudzsaDBm7Qf7dZ2IacJ6g7PKqNVO/HCNZXtWkzI
 xtGgI0idbwTtAs+ZCAwHTqs8Kj8s8+eXaufRqkqhhNamYOe3vRWl4DYpISY90uy1Wl0w
 MN0UVRt0M6+T12LUWkWJdr9N3M5JPv8oPziqY4K/fEJn7Le4gHTymfw+UZ3nnZaKRL/c
 QdpuzJGoLkxRUCd6P4Kiqmkf4cdZV7Cp9iYbEGmliOtvSc/iTE+DHs2JL5Y8okJ+v6za
 2oeiuDS7+TvuErm5Mj1IFcBF0l3qf1sLh2W0KuBTV8pNeoFmDjUEo2nVhi5TWuXHZ8Fy
 wnBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5x9NNCj+dL8LLnS0n/ArVsIfC2Pq01M3xjS1Mn4xZVJinwX9czEJP4CyaBahxhxRMnmudPaY51/1wGpGrtiEASbgywe0=
X-Gm-Message-State: AOJu0YySbP8RmC9p+II8Yf+wQTakCfZvCCJvygUQZEUkFSEde0AZOiWy
 a/V44dePhP1Q46J5R+kmzkbpJHMNaTRGKEm9qpmvqRsqdVTlIxwJTELF7OOnFzo=
X-Google-Smtp-Source: AGHT+IHDXd6sAjQB6nmHBa7xZ/g0j0zzb9rxCrNRHrtdWBTY/ynYDmROpdSjKrIc7WbdMBl+icB0XA==
X-Received: by 2002:a17:902:ccca:b0:1f9:f6a7:9330 with SMTP id
 d9443c01a7336-1fac7e4c1c5mr36783135ad.9.1719595097822; 
 Fri, 28 Jun 2024 10:18:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faceb78d02sm10370765ad.136.2024.06.28.10.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 10:18:17 -0700 (PDT)
Message-ID: <993fe6b3-1823-4aff-8598-11ea69ac6213@linaro.org>
Date: Fri, 28 Jun 2024 10:18:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] tests/tcg/aarch64: Fix test architecture
 specification
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
 <20240627-tcg-v2-2-1690a813348e@daynix.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240627-tcg-v2-2-1690a813348e@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/27/24 06:58, Akihiko Odaki wrote:
> sme-smopa-2.c requires sme-i16i64 but the compiler option used not to
> specify it. Instead, the extension was specified with the inline
> assembly, resulting in mixing assembly code targeting sme-i1664 and C
> code that does not target sme-i1664.
> 
> clang version 18.1.6 does not support such mixing so properly specify
> the extension with the compiler option instead.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   tests/tcg/aarch64/sme-smopa-2.c   |  2 +-
>   tests/tcg/aarch64/Makefile.target | 11 +++++++++--
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/tcg/aarch64/sme-smopa-2.c b/tests/tcg/aarch64/sme-smopa-2.c
> index c9f48c3bfca2..2c9707065992 100644
> --- a/tests/tcg/aarch64/sme-smopa-2.c
> +++ b/tests/tcg/aarch64/sme-smopa-2.c
> @@ -14,7 +14,7 @@ int main()
>       long svl;
>   
>       /* Validate that we have a wide enough vector for 4 elements. */
> -    asm(".arch armv8-r+sme-i64\n\trdsvl %0, #1" : "=r"(svl));
> +    asm("rdsvl %0, #1" : "=r"(svl));
>       if (svl < 32) {
>           return 0;
>       }
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
> index 70d728ae9af7..ad99e0e3b198 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -27,7 +27,8 @@ config-cc.mak: Makefile
>   	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
>   	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
>   	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
> -	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
> +	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme, CROSS_AS_HAS_ARMV9_SME); \
> +	    $(call cc-option,-march=armv9-a+sme-i16i64,     CROSS_AS_HAS_ARMV9_SME_I1664)) 3> config-cc.mak
>   -include config-cc.mak
>   
>   ifneq ($(CROSS_CC_HAS_ARMV8_2),)
> @@ -68,7 +69,13 @@ endif
>   
>   # SME Tests
>   ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
> -AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
> +AARCH64_TESTS += sme-outprod1 sme-smopa-1
> +endif
> +
> +# SME I16I64 Tests
> +ifneq ($(CROSS_AS_HAS_ARMV9_SME_I1664),)
> +AARCH64_TESTS += sme-smopa-2
> +sme-smopa-2: CFLAGS += -march=armv9-a+sme-i16i64
>   endif

How interesting.  We were not actually passing -march=armv9-a+sme to the assembler 
previously.  Lack of this is what is causing sme-outprod1 to fail to build, as reported by 
Alex.

That said, if we use compiler directives we must have gcc-14 or newer to test this, 
whereas binutils supported sme (and extensions) much earlier.  Given that this is all 
inline assembly, we do not really need compiler support.

I think we should continue to pass assembler options (-Wa,...) and detect and use clang's 
-no-integrated-as option as well, at least for the SME tests.


r~

