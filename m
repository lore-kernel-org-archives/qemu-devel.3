Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDCDCD3440
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 21:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slbD3-0007Mg-0q; Tue, 03 Sep 2024 17:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slbD1-0007Lb-P0
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 17:37:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slbCz-0000zv-OD
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 17:37:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42c7b5b2d01so38223965e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725399424; x=1726004224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gfmATu2m6mkKKzzZLVURnXGkZjjrSE3sIDhUZFfLpK0=;
 b=xdNbPWuNNsE7A5dduEbhrtyS4/BhTeQMRNvuDdQa/P8bjJC84QYMWc1yyxCqJ+eq5W
 q85bnjr8nd8aMpFIl/vgfgjeSepa8qNg2s77yRkMMEsmEPs2JsYeLkFmnxN0GcAXdd76
 5+S3wD4A3xVGf5nBpVAeOeMnQ9cW3wDiikHSiXaMSR3GXJRrAiMNNYqCXSSBmbfojAAC
 71nbznC+d7NWnjiiCulJvTXqTUqDccEnSzWSWdl+Uk/ghILZ3VTV+PJklIX4crNdoJnO
 Qs4wl0I/flyhOwpGZyR7NSL32jXs4iWwNGRbOunoxqnCZMNaFIUHYGZAMoXQWyAMp/ZL
 JcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725399424; x=1726004224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gfmATu2m6mkKKzzZLVURnXGkZjjrSE3sIDhUZFfLpK0=;
 b=MHUHg8lOuiGLgYzdbdgNQuJJ351CptwI8PzcO120fVC//giEDa8oVtZ+DKQOuphCY7
 Y4Rf6JcWv1KxcuaRjVe3KjDRjsdXtRhXVpVjz1HJXReZDchVi2uJqsaUNDsXHjPQFvGN
 j/QzkCPH72lX0cl7UyJ/7lbn5GndyTacmNIvcotqZrUsAwnreLRzlRI/bWtKpBedgshJ
 VtpGxmhesncbPr3WtZugiBAlmju3UpFAZJG7DY9MlWjp5i/TLo9EeqbYCAU7AI3m9aGN
 2K1Gtcrt60N2gMCnaU1KQjNP/kil3cMI0xK2tGomk/PRFJeLnzQameOfDDywKMtnz1rP
 dYfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9G2gLukWAouLcOvThNNZrlFgSbv6oY//4ecX1hflDymziMtaMUVaU0+3J3ksGVuE7wmMc8bBrjVuz@nongnu.org
X-Gm-Message-State: AOJu0Ywb95jd++df/3pxV5EPNcHRTbgMMY+1E5H1oOjzn0Ol1Ig70jiP
 LMyBalqgL6hpEODPIwAav47Erq4My2zaHaHfqgY+1vJBj1usJBACFP+dvEy3C78=
X-Google-Smtp-Source: AGHT+IEfMn+Q+QJ1pEqtlG5yKsinkXbXUPfTXChRiylHdpWLeLF6Y5kobkvL5R7fVjq1fuKYwraZQQ==
X-Received: by 2002:a05:600c:310b:b0:426:5269:982c with SMTP id
 5b1f17b1804b1-42bb01edcbdmr174913665e9.28.1725399423879; 
 Tue, 03 Sep 2024 14:37:03 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbe79f545sm150783965e9.2.2024.09.03.14.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 14:37:03 -0700 (PDT)
Message-ID: <f65053b7-f909-4ff3-b938-05cff490548c@linaro.org>
Date: Tue, 3 Sep 2024 23:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 26/53] hw/misc: Remove cbus
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-27-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-27-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/9/24 18:07, Peter Maydell wrote:
> The devices in hw/misc/cbus.c were used only by the
> now-removed nseries machine types, so they can be removed.
> 
> As this is the last use of the CONFIG_NSERIES define we
> can remove that from KConfig now.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS            |   2 -
>   include/hw/misc/cbus.h |  31 ---
>   hw/misc/cbus.c         | 619 -----------------------------------------
>   hw/arm/Kconfig         |  14 -
>   hw/misc/meson.build    |   1 -
>   5 files changed, 667 deletions(-)
>   delete mode 100644 include/hw/misc/cbus.h
>   delete mode 100644 hw/misc/cbus.c


> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index d33d59bee90..a70ceff504b 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -142,20 +142,6 @@ config OLIMEX_STM32_H405
>       depends on TCG && ARM
>       select STM32F405_SOC
>   
> -config NSERIES
> -    bool
> -    default y
> -    depends on TCG && ARM

Maybe squash this ...

> -    select OMAP
> -    select TMP105   # temperature sensor
> -    select BLIZZARD # LCD/TV controller
> -    select ONENAND
> -    select TSC210X  # touchscreen/sensors/audio
> -    select TSC2005  # touchscreen/sensors/keypad
> -    select LM832X   # GPIO keyboard chip
> -    select TWL92230 # energy-management
> -    select TUSB6010

... in the previous patch?

> -
>   config OMAP
>       bool
>       select FRAMEBUFFER


