Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE23C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 21:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0S8C-0002Kt-16; Thu, 03 Apr 2025 17:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0S8A-0002Ki-CM
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 17:29:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0S88-00064j-Ly
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 17:29:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so8627415e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743715782; x=1744320582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l59CEhJjlxttIe0DcZTj29ufVf6X0Qo02KjrxnfaGes=;
 b=hW6ReQengJCDMnt7ahpExl4UsyIdEp26rKImhOMsYAXk9v2lKVXnP1imWHh+l8V7vR
 K1nFjwAEvxMW/4g8tiipmLnpjU6ZSMYpt53l3CpadvwxYAEHdp9tl5W6V70R4yYjqot7
 O0aKNh2Su0E6zjPPKXFrvzyIaYvVaqCTrpmLve3+AzA1lt46smtf9qHUhOwZFIPwFJi6
 i1W+ebqBla+tUcNGOFdKdTrlaE5xv5EDhq6w7meYMIOyHcFuSPTdxcCbWRR9rVyjO9bz
 MN8HJybLb3AUyvr+lSfJCGuYKMpEzsU+Cm961rHInjM3cXiGdjoDAfXrOKXI7VliG/Vc
 uNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743715782; x=1744320582;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l59CEhJjlxttIe0DcZTj29ufVf6X0Qo02KjrxnfaGes=;
 b=t283HOEjMp26QNpiywMs+Sh1D+ivseaM1mQMCP2td6ocDroRarD70KAcjSlhD/e9V+
 9eDqzIDqoI7TeI0cFhq4WTQ8TfXIHm5lFHEZ6ZtI4ZnSIv7DJym3oHGos9/pgqXLyUNP
 QNTiJGjaLd7nasdRxdWXXRnMM/XOPR4BT4uyo0HUgmZJidm0T+NLHuf+bXd/OttRyPEP
 VCRkHQZztQtE9b1IPy+X6SIVTiQq6LGhnPiC/HRbnN5X7CDugsY+lGeCpGeLt34j9Tkt
 4B84HDqOxpuJVcSum5twuQElz7HVQpt11JhSVqTi9DZdSHsn2TCdjDGqm45LAvD2XQ60
 XzuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkYQIGf8MwY5Ds4eW6E8Gb8RGNIaqRswiA0BsTrShoazbcOIU7yjCySZkfLDdTCU2mpaRyiW8CexpQ@nongnu.org
X-Gm-Message-State: AOJu0YwWm2koEEBAwxx1uI4IUcFpAn9fZff/UIWvQR+QMqrqED7jlmK3
 d5KY9nM9FxNMef2VN3VNeL1q/fPykamFIuizfUK5Qx7s0ZPbdd6fdf1kOslX+S8VwNocJYT2628
 z
X-Gm-Gg: ASbGncul1fKEXcacOa5Nd9Y8EHqOHyD+juXs2OOgv56asjt068Qd1jZgaGVo2JigYFz
 Z/WA2+69z/DMjuQLdIOiumSEmViFnP31PAYsqzwgfeQAi5TXrjPXLNOk/fxTTUFQKxrmac68D3n
 cqQXrfmqfV9ad0L/qaJWcZXiXzhKonvkI81mC3n7KvM9ugJ8QJOtcNJG8O9Lbexb766uBuWiRQT
 xG6bvzcmgruTalAjyFV6pO+l7y9buA1o570C/haGvHkR2Fi4s3y1tVFqa6rJsG0pAlRwSP367xJ
 uf5gDgznN6VCbjgwfwY4AFrxmuQ+9fLl8btunzoMkaZ8nozcD1/WA29SLXWRxqQuSD9yqoQUqGe
 cRNHuCmIUjB0HRN3pEBebG12sbNjb
X-Google-Smtp-Source: AGHT+IFPTiTPA3ACKsD4gFLZ6KmKC601HuXRTD3jHmbOKO1gCVT7N0Rpivp0DHc7Bo1OjAvw0VGf4g==
X-Received: by 2002:a05:600c:4454:b0:43b:c857:e9d7 with SMTP id
 5b1f17b1804b1-43eced9a665mr5916935e9.5.1743715782434; 
 Thu, 03 Apr 2025 14:29:42 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1663060sm32408305e9.14.2025.04.03.14.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 14:29:41 -0700 (PDT)
Message-ID: <74e250b5-3fb2-4688-ac20-18be6b6173f1@linaro.org>
Date: Thu, 3 Apr 2025 23:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 01/43] tcg: Declare TARGET_INSN_START_EXTRA_WORDS
 in 'cpu-param.h'
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250402210328.52897-1-philmd@linaro.org>
 <20250402210328.52897-2-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20250402210328.52897-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 2/4/25 23:02, Philippe Mathieu-Daudé wrote:
> To avoid including the huge "cpu.h" for a simple definition,
> move TARGET_INSN_START_EXTRA_WORDS to "cpu-param.h".
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu-param.h        | 7 +++++++
>   target/arm/cpu.h              | 6 ------
>   target/hppa/cpu-param.h       | 2 ++
>   target/hppa/cpu.h             | 2 --
>   target/i386/cpu-param.h       | 2 ++
>   target/i386/cpu.h             | 2 --
>   target/m68k/cpu-param.h       | 2 ++
>   target/m68k/cpu.h             | 2 --
>   target/microblaze/cpu-param.h | 2 ++
>   target/microblaze/cpu.h       | 2 --
>   target/mips/cpu-param.h       | 2 ++
>   target/mips/cpu.h             | 2 --
>   target/openrisc/cpu-param.h   | 2 ++
>   target/openrisc/cpu.h         | 2 --
>   target/riscv/cpu-param.h      | 8 ++++++++
>   target/riscv/cpu.h            | 6 ------
>   target/s390x/cpu-param.h      | 2 ++
>   target/s390x/cpu.h            | 2 --
>   target/sh4/cpu-param.h        | 2 ++
>   target/sh4/cpu.h              | 2 --
>   target/sparc/cpu-param.h      | 2 ++
>   target/sparc/cpu.h            | 1 -
>   22 files changed, 33 insertions(+), 29 deletions(-)

Missing:

-- >8 --
diff --git a/include/tcg/insn-start-words.h b/include/tcg/insn-start-words.h
index 394c191da8d..d416d19bcf9 100644
--- a/include/tcg/insn-start-words.h
+++ b/include/tcg/insn-start-words.h
@@ -8,3 +8,3 @@

-#include "cpu.h"
+#include "cpu-param.h"

---

> 
> diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
> index a7ae42d17dc..2cee4be6938 100644
> --- a/target/arm/cpu-param.h
> +++ b/target/arm/cpu-param.h
> @@ -37,6 +37,13 @@
>   # define TARGET_PAGE_BITS_LEGACY 10
>   #endif /* !CONFIG_USER_ONLY */
>   
> +/*
> + * ARM-specific extra insn start words:
> + * 1: Conditional execution bits
> + * 2: Partial exception syndrome for data aborts
> + */
> +#define TARGET_INSN_START_EXTRA_WORDS 2
> +
>   /* ARM processors have a weak memory model */
>   #define TCG_GUEST_DEFAULT_MO      (0)
>   
...

