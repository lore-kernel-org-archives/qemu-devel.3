Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CABC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMVs-0000Eb-KA; Thu, 19 Jun 2025 17:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMVn-0000EQ-VP
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:09:32 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMVm-0007qK-6M
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:09:31 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso855237b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750367368; x=1750972168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vUJmFi2KdkteVmHqJ3QOC7UbP5grZZvRjaW2acevtww=;
 b=yZeFFmexaj4meGcKbt20Y7haxkquIlRqmdWi0QM01NnNLoBtaCUGMlI5a6w4RC+iXe
 t3ky6KD5fyoS5x8q7+FKhmZZnO9X86TsGFpI2vazJy/d60eTHODkikwjXHT1dQ4sy49b
 UbOSoIVoHD8LbvYR5aZnP+ydd4/i9TM5x8L2rVsFq2n5qBvFJkvwgr9ydRMaphaeX88D
 RwZU2kxFPvKBT/Ymu4xqynE8VGbytHIxEepLtBZ16/6wcszEh1m7vkiWLTTkMEO0RJwc
 xnt5JU/tp3QKigLIm8cpo7gP17TSlhId8iQI7NuqnMMdDqOfMzt4WQwL/c/zBAEQyzRi
 /RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750367368; x=1750972168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vUJmFi2KdkteVmHqJ3QOC7UbP5grZZvRjaW2acevtww=;
 b=XJP7fiZujhqHAtl/S4Uak7btuox4sne3qdZlwe/mS36HPf08PHmUuV9stbFQ7Av7Z0
 3z9GbG0FmDroku1rZpVjAoG+V+sBQAHaMT5i33REFGSGOFnFEbsNKq7Zg/I/EUszVCmL
 2y4Y+RpOF9DmX1WMroMXtBD6/j3hEQKcnFurGpijTxqzOyIFqlVcRsrpRALyJ5QCwn/l
 vi60WF5KjP0y8yDMUxdAJZi+3ZTymu5cg7VLDtAw17k/C1a9sQRDUzV/hthzbYqgv3Y6
 z7Ed63EFpATjorSRcWNES4ZUryHoIK7XFBVuQqBj9iGWwLyYxtHCIQ30rPz0TIE3uaKg
 6uzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV5qrX7dqu3bELIrVNebvClUGeEsqJrvJL8g2Gv2kXFY4HYNbpYse6julh1jW8tTtJwkT7YPe8yXcw@nongnu.org
X-Gm-Message-State: AOJu0YxVU2lDpBINZcqu64ZyUfgLiwTqxUKN8KXpPvWHtEwpiWb9iM+z
 1QQE7l36aPQ9nLfOOGumaPFTpi6reYyf3Q6w34zL50+wdGtm38sdBSHltekgD+0uqVw=
X-Gm-Gg: ASbGnctv9VlcEAJlPGtOx5/FXgba3TMylsSzKRhWXoid2bYg+3YZscPfz1OqstbggsJ
 N5Z45I6ox7dzxyKakq9SuOJiFWdfBhaMd9fR9ZyFVN1iqubcMer1oml1Omc6nakpTvG4JTjywWK
 uVw3+SD0rE3lPHbSUA8/6v4wdMioKgObCyPVUR+R49kC5tWs6Gbsib+PvLgv/YqMY5oNjTtt8Im
 KGCgWsh+XQtvuTQR1Vm5VBWu8I+TG1IN2bzBErHL541DGloRw6cvZmVjdG2mDkFZsiGa4/9Jp//
 4R/uis5beR8VhbkvThtKvF7l+f3tmiLyUzFgzbdUhQuILkkKWqoD1vhk6UPxlSo+x4lWe47R2J1
 WDr/BfCiQ85l5J/MTMbKQ3fjtPrB1DNwlrieiA0c=
X-Google-Smtp-Source: AGHT+IEwjWFJwsonXVuy7u+xkc+qsqDRA0Y+9hsxovCq1M16IFAmvfiV6sWrCWc2D7kwK9xnZC5bfA==
X-Received: by 2002:a05:6a21:6004:b0:218:bcd3:6d2e with SMTP id
 adf61e73a8af0-22026e87ab6mr646001637.36.1750367368130; 
 Thu, 19 Jun 2025 14:09:28 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b82asm534610b3a.23.2025.06.19.14.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:09:27 -0700 (PDT)
Message-ID: <1e7d58dc-b348-4c6f-b7bd-e8da047e21c8@linaro.org>
Date: Thu, 19 Jun 2025 14:09:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB
 definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250619131319.47301-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 6/19/25 06:13, Philippe Mathieu-Daudé wrote:
> Define RAMLIMIT_BYTES using the TiB definition and display
> the error parsed with size_to_str():
> 
>    $ qemu-system-aarch64-unsigned -M sbsa-ref -m 9T
>    qemu-system-aarch64-unsigned: sbsa-ref: cannot model more than 8 TiB of RAM
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index deae5cf9861..3b7d4e7bf1d 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -19,6 +19,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>   #include "qemu/datadir.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> @@ -53,8 +54,7 @@
>   #include "target/arm/cpu-qom.h"
>   #include "target/arm/gtimer.h"
>   
> -#define RAMLIMIT_GB 8192
> -#define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
> +#define RAMLIMIT_BYTES (8 * TiB)
>   
>   #define NUM_IRQS        256
>   #define NUM_SMMU_IRQS   4
> @@ -756,7 +756,9 @@ static void sbsa_ref_init(MachineState *machine)
>       sms->smp_cpus = smp_cpus;
>   
>       if (machine->ram_size > sbsa_ref_memmap[SBSA_MEM].size) {
> -        error_report("sbsa-ref: cannot model more than %dGB RAM", RAMLIMIT_GB);
> +        g_autofree char *size_str = size_to_str(RAMLIMIT_BYTES);
> +
> +        error_report("sbsa-ref: cannot model more than %s of RAM", size_str);
>           exit(1);

Not a bug bug, but autofree has no effect because the block doesn't end before the call to 
exit.


r~


