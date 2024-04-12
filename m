Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD3BC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 11:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvEo4-0001Qt-FQ; Fri, 12 Apr 2024 07:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvEo2-0001Pe-CD
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:10:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvEo0-00069e-8w
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:10:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-343d7ff2350so503721f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 04:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712920250; x=1713525050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+zUgwDxL6Jh9gS602LQ1TWUHMO/rEs6zICIYwLbAqg8=;
 b=Ip84Lzd/CnljmSD+28oECUk0P6YtEwG8M4aJ54TkLX1FpJINjhjLsV3/f1laUaA6Zg
 Q9DpujKir3mWdNI/1ls6DuGyYfwvI7Ch2FZOHUDqBLK7afTkVjS927Yx0IKiNSFbnMyU
 5brO/3MfC6DUCXHEHvoq8/TXuguPoF5TheQjf4+Avpbr3dpCI5G30nPlJP+rOHC3xVBD
 wT/hZKyuONq0SAV+lJ0X6vtYRZo695RO5QnhbvNKmuOpLazdJabz7yrmp7HKyGBQuaYc
 HrvWeBu8j9PjC7KnTvzqfZktYe/OQl0m4YiwJSbtV9hFC6S+VrJ+pcxYsBHapKPwwJZZ
 s47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712920250; x=1713525050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+zUgwDxL6Jh9gS602LQ1TWUHMO/rEs6zICIYwLbAqg8=;
 b=jtzYivANkFivYgsNfaJJ37QK5Atbu+boCDEysyeFZs+0v0UgtbO2+jBvIlpHNR1yhd
 8eroArwsXGr+1MKTge6mQMftP0GEeUdoafv9Pd3FnH4rbUrmu5NEHCQ1IzCWNSoCb6eL
 QX+MH86GFkLfYqZekwL9Jmi+TmFTxlhOeIjBTVCZlsZrnUfZWlr9JsiBViD/kNhyFW45
 Zhn/+NJ9iV2vliueLHN5ZOA5oMbL3X4qjppa/CqoJ3Nph9kCQ9/Jbgb6sl+ypKWyZDjS
 m6ALKUUhScRbmkUY2tMEI4l5AtX1EXpU//0v+/YUlBBmy+lQSFFNxZ4hTJbsDXJTFW3B
 +7tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUckHbQyVSPdMiJUnO3kCSHZQHINqCmWvTT9/SE4okGs/HfIAP4cCBy1kv7CteLtZvvaANLVcoO3PR/ihP2yuOgfGthssU=
X-Gm-Message-State: AOJu0YxVdEk+PxJ7oJV+3i10DmsK22wXS2zT2XRfPT++O74q7pSD65Jg
 MYYctHcpxJREqT5W4TT1WpTXsTVjOny3S3Ok6X1cvw/gtotCUW6nI4GbBA0m8N4=
X-Google-Smtp-Source: AGHT+IG78dfHB12b6CMwY2i/goX5zCao2yM1jsUJh1bso0Bj9FMgjPuTRdWG4kKUr2W2k1YZvPQvwQ==
X-Received: by 2002:adf:ec42:0:b0:343:ebd4:b9f0 with SMTP id
 w2-20020adfec42000000b00343ebd4b9f0mr1452496wrn.32.1712920250538; 
 Fri, 12 Apr 2024 04:10:50 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 cs5-20020a056000088500b00343a0e2375esm4036374wrb.27.2024.04.12.04.10.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 04:10:50 -0700 (PDT)
Message-ID: <35ea1f53-5c7a-45e8-9fa1-0df8fc7a0cba@linaro.org>
Date: Fri, 12 Apr 2024 13:10:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw: Fix problem with the A*MPCORE switches in the
 Kconfig files
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20240412062042.105174-1-thuth@redhat.com>
 <20240412062042.105174-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412062042.105174-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 12/4/24 08:20, Thomas Huth wrote:
> A9MPCORE, ARM11MPCORE and A15MPCORE are defined twice, once in
> hw/cpu/Kconfig and once in hw/arm/Kconfig. This is only possible
> by accident, since hw/cpu/Kconfig is never included from hw/Kconfig.
> Fix it by declaring the switches only in hw/cpu/Kconfig (since the
> related files reside in the hw/cpu/ folder) and by making sure that
> the file hw/cpu/Kconfig is now properly included from hw/Kconfig.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/Kconfig     |  1 +
>   hw/arm/Kconfig | 15 ---------------
>   hw/cpu/Kconfig | 12 +++++++++---
>   3 files changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/Kconfig b/hw/Kconfig
> index 2c00936c28..9567cc475d 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -48,6 +48,7 @@ source watchdog/Kconfig
>   
>   # arch Kconfig
>   source arm/Kconfig
> +source cpu/Kconfig
>   source alpha/Kconfig
>   source avr/Kconfig
>   source cris/Kconfig
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 893a7bff66..d97015c45c 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -678,21 +678,6 @@ config ZAURUS
>       select NAND
>       select ECC
>   
> -config A9MPCORE
> -    bool
> -    select A9_GTIMER
> -    select A9SCU       # snoop control unit
> -    select ARM_GIC
> -    select ARM_MPTIMER
> -
> -config A15MPCORE
> -    bool
> -    select ARM_GIC
> -
> -config ARM11MPCORE
> -    bool
> -    select ARM11SCU
> -
>   config ARMSSE
>       bool
>       select ARM_V7M
> diff --git a/hw/cpu/Kconfig b/hw/cpu/Kconfig
> index 1767d028ac..f776e884cd 100644
> --- a/hw/cpu/Kconfig
> +++ b/hw/cpu/Kconfig
> @@ -1,8 +1,14 @@
> -config ARM11MPCORE
> -    bool
> -
>   config A9MPCORE
>       bool
> +    select A9_GTIMER
> +    select A9SCU       # snoop control unit
> +    select ARM_GIC
> +    select ARM_MPTIMER
>   
>   config A15MPCORE
>       bool
> +    select ARM_GIC
> +
> +config ARM11MPCORE
> +    bool
> +    select ARM11SCU

I thought 
https://lore.kernel.org/qemu-devel/20231212162935.42910-6-philmd@linaro.org/
  was already merged :/ I'll look at what is missing and respin.

