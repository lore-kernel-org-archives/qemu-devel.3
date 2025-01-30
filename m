Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB57C0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 22:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdcf4-0006zW-Km; Thu, 30 Jan 2025 17:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcf3-0006ys-71
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:05:21 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcf0-0005mh-FY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:05:20 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso16167755e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 14:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738274716; x=1738879516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nqp604v9ga8iHYkwtDxqtMWMeqQl0AndasmsmNIJX9I=;
 b=cVIj33Oh9NGGXx1rzCgmGR5jch47v5rFqUiY//A+2ZhHPtp7BJP5Mlk1SfSTG+X2RA
 o08jJnO4utwVUUgfGiUJH4Dc0duhi8cqJHX7grYlff51e6mMX5d+HbSjJNX51QVPEqi7
 o4Seje5pVKaj0JDnH8HP0E46FNikC2+HM1dy7VBvPlxtBHgmAeissuciVELmaK0h+dVB
 8FjyKqkMxZNXDD7vi6oAZZSVryMcA7RiswMCZAyxEMA+FxfU25vkH1V0l7kaV6AXrBT6
 TuaXm9xo4WlKyoEWMdRo+0Dgs0Mf/Q2iK/CYHUkvacc8ddPfD27rEPpvTZ28zGMdhkPt
 Fr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738274716; x=1738879516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nqp604v9ga8iHYkwtDxqtMWMeqQl0AndasmsmNIJX9I=;
 b=FD1e+ViavK6hi/E8QoQFp/JwrJDv7LuLVzEE1yQJThN1ImQpkjumoemN3fcMsnX3E/
 d5SGqo7FMOlRDztJLjtfQ8IyqHNLuhBOoOYrhVvbT8BB1Q3FnEbIRtKiUxih6URtH3WP
 stX77HsdqCUSw/dUZBcsFk4cWaymvc1AWPS0Zaex2BsARVCuMe1I9cd0+5FZMqRHYjXx
 VPlo64Nn/SAKIMEeBjlfZFm68ngyV5Vm98djTsbVVMWWvIbSLfCKn8jzXtRcF8AsOzQE
 qwnTJBoIgN9nHc2mVVS316/wu8Q5dMnPUfng0W/YFg8xb3IFjhgBjYWS0j2A6VjcXywg
 2YRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlKpY8M2hwa93myKpDlMP/3t7PCl7yKDXUPYHrqAC94vfZ5nE1yY9Ar1UE3mk8XK2RwX5jmm3DHpRv@nongnu.org
X-Gm-Message-State: AOJu0Yzob8zdzr+9ouNZmEcLyPdvhjuQXheCiOVqDvxs0JiZtD46NQEu
 uUjMeQCnfelnz1syKdZ3410JhzTXdOI0V6z/rqHDkitKfW3uIJ7u9JbX4aoqQak=
X-Gm-Gg: ASbGnctRRb4SAenkJTIObGU9tEsco7mnFa8NB7SCQ1xghTE6ecHizuIm2dLrtm81NTY
 DS7G4cf/LJvszylLsE3IKJTOvhyU8XwZZOcnCIeT/igK3yp0c/SA7nq3q5Wmm1jDPEk5ShDRmxf
 Ols+YatMUpM2XBqxrUD18CUUrl7dybKAWT8nZ9/+zh5MRmJndLPgdr/1o7rvYLTiem0rmS/5y7/
 BkYBzuugvA65uVaJTOnj5uzrBoImqtRLsIiwc2t3ksGgnSROZw9mg4ENeEr85I+5NPCtSVv9iZm
 VBMHCoGOe9plO0w0dNbDydLhEamAeVgIx/81v4XsL02gfy4k2ibWAyoxpiQ=
X-Google-Smtp-Source: AGHT+IHveqRosO91Do02M+kDhD8ImfhFjFGEHIy/RO1DfLNLjqTyTHv44rKQG7XCnbi2xO52POfXiA==
X-Received: by 2002:a05:600c:1da8:b0:434:f3d8:62db with SMTP id
 5b1f17b1804b1-438e1e18200mr38464015e9.2.1738274716594; 
 Thu, 30 Jan 2025 14:05:16 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244f087sm35243535e9.29.2025.01.30.14.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 14:05:15 -0800 (PST)
Message-ID: <b9d7391a-3091-42cb-93b0-b6e7e049f144@linaro.org>
Date: Thu, 30 Jan 2025 23:05:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] hw/sd/omap_mmc: Convert remaining 'struct
 omap_mmc_s' uses to OMAPMMCState
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128104519.3981448-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/1/25 11:45, Peter Maydell wrote:
> Mechanically convert the remaining uses of 'struct omap_mmc_s' to
> 'OMAPMMCState'.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |  2 +-
>   hw/sd/omap_mmc.c      | 20 ++++++++++----------
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
> index 6339c5a581e..7d1a1afc4f8 100644
> --- a/include/hw/arm/omap.h
> +++ b/include/hw/arm/omap.h
> @@ -530,7 +530,7 @@ struct omap_lcd_panel_s *omap_lcdc_init(MemoryRegion *sysmem,
>   
>   /* omap_mmc.c */
>   #define TYPE_OMAP_MMC "omap-mmc"
> -OBJECT_DECLARE_SIMPLE_TYPE(omap_mmc_s, OMAP_MMC)
> +OBJECT_DECLARE_SIMPLE_TYPE(OMAPMMCState, OMAP_MMC)

I was expecting this in CamelCase to be OmapMmcState but then
looking in history I figured both OMAP and MMC are acronyms
(Open Multimedia Applications Platform and MultiMediaCard).

commit b56d351e25065d46fb959081fe13e8d031df35f3
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Thu Jan 28 11:41:26 2021 +0000

     hw/timer/cmsdk-apb-timer: Rename CMSDKAPBTIMER struct to CMSDKAPBTimer

     The state struct for the CMSDK APB timer device doesn't follow our
     usual naming convention of camelcase -- "CMSDK" and "APB" are both
     acronyms, but "TIMER" is not so should not be all-uppercase.
     Globally rename the struct to "CMSDKAPBTimer" (bringing it into line
     with CMSDKAPBWatchdog and CMSDKAPBDualTimer; CMSDKAPBUART remains
     as-is because "UART" is an acronym).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



