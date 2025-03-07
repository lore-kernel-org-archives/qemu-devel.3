Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4426EC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd8t-0001Yi-3C; Fri, 07 Mar 2025 14:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd8U-0001IA-LN
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:13:31 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd8Q-0006Wg-Tx
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:13:29 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso3623409a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374805; x=1741979605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tPmO265dmNwDHd2jcXewxTBYqmUSEOVNf+Dyo3Q/owM=;
 b=AQjYMFU/f6eZfTOaWakMeSCg5lHnaP7taErwzA6kU6ZWgc0GPRaEgGVyABSEEGIon5
 Z/nmMu+apUPOHd7Soz8IbwIDK4R/BSOl+NU87FsGXkFceiEhGrB4Pv2ZBkx79UF8pJnt
 +V/vEyqnGLTAtuBMc6JB2NB/suIUeHceCtqu8JxDck2n6r7bCUlFZS74c+LBprKDwwkg
 u4nOTys0kRf31lzCTqYkUvg0Q4CGrzGp2lP3Irrc7rp05CQnUGPpq1IgsTzrKLkqZe/G
 0jqMXUAHdfOVi1xRnU5/NLui/GS0nxovKxEOUv2K25/Nvc/lvmjmLDSzXuqnzLlP5Yyp
 X/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374805; x=1741979605;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tPmO265dmNwDHd2jcXewxTBYqmUSEOVNf+Dyo3Q/owM=;
 b=VYtj8CYRt1blvJH8OPJ8kC9hRiubANGRzCrdX+9Phvq7UXI4oxE5yds1KI3RF4Eqjy
 fLp1Zw1gy6RCymABl6T/TluwrHq04zW2InEywkB1obit6KLanZ3gMvwVrJw5ijJ0gbYk
 e50qio1DNeAMV0soI5aWrE6J+L6ITlxCvMhZ1bkSh23pd7yHB+yqevvebJCBZFIHjxSr
 LtXhRPjMrAZuXmPQox70VGJP5fBcbpfmupfFN/MD+ZtvgBl0ajCdLMZDUiougSVFR24l
 MUjwWPxDpiFrF/cevJYFV9ovnQpg9TOLqCtNaBiC/5MsV3kzrOHNfD2Gi75tikCXv2ST
 SsLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ9uKPf3bG0Hmd1z/AcYADA5RKK6dasl27Q9NcihKJsDkgP3JSwjA4V1TuItWNlTk5WgNu4BBgzyhC@nongnu.org
X-Gm-Message-State: AOJu0YxCv2t4/B1sQgrUYiWP5Kuv5vgwmuo23meYS7ZXtB8kuQIRjZuO
 bAyHdXVsAM7QqOUy7uaJ3ojnHnxKnlGYwiDDhV5nFJF/ny4HJSU62CTvie5ytrI=
X-Gm-Gg: ASbGnctIUJFe44ArOAkaymIloNzPmmhACH/dFa8voWXEANX4f707nw0F3B9IkQX+Og2
 bHoKJWGsTDY3aNWL9Rly+5/MSMhMev+l1085a2rir5W+5aiIzsa6qtOe/CgGsdHcznEA3CkXNaV
 8OuWpaqYYWYEPQd6EYP2qrhTdR0Ltk0ZURri8SjIc1qQZrycXh+TU49yDhS6sSGcKNmCR9Nt84z
 nXaoZwmHc5QiXQ5Yuh9StvbqJmaz1pw2c4kcMfioZ2ZsjBdA6P2qeSRlZLLs30Z64vJ9hwJFcJ3
 MRfh7afAJ+I9lP896HABSvf7ZrYS5QX5cQW2UZURuzCjGwNCpg67zTeXWw==
X-Google-Smtp-Source: AGHT+IFeaWxJ8HkRyAVjPzSWcNpFPUqvWD91Q5/HHGWzrAkxAOGpxDCkoMnLl3l7nlyminOTI1PfBA==
X-Received: by 2002:a17:90a:d40f:b0:2ff:618c:a1e0 with SMTP id
 98e67ed59e1d1-2ff7cf37945mr7024809a91.29.1741374805071; 
 Fri, 07 Mar 2025 11:13:25 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e7ffa1bsm5346439a91.38.2025.03.07.11.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:13:24 -0800 (PST)
Message-ID: <a7d794d2-ee7a-4581-871e-7b1f863ceeba@linaro.org>
Date: Fri, 7 Mar 2025 11:13:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] accel/tcg: Build tcg-accel-ops-mttcg.c once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307185645.970034-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 3/7/25 10:56, Richard Henderson wrote:
> All that is required is to avoid including exec-all.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-mttcg.c | 1 -
>   accel/tcg/meson.build           | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index ba7cf6819d..bdcc385ae9 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -30,7 +30,6 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/notify.h"
>   #include "qemu/guest-random.h"
> -#include "exec/exec-all.h"
>   #include "hw/boards.h"
>   #include "tcg/startup.h"
>   #include "tcg-accel-ops.h"
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 87c1394b62..81fb25da5c 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -20,7 +20,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
>   
>   specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
>     'cputlb.c',
> -  'tcg-accel-ops-mttcg.c',
>   ))
>   
>   system_ss.add(when: ['CONFIG_TCG'], if_true: files(
> @@ -28,6 +27,7 @@ system_ss.add(when: ['CONFIG_TCG'], if_true: files(
>     'monitor.c',
>     'tcg-accel-ops.c',
>     'tcg-accel-ops-icount.c',
> +  'tcg-accel-ops-mttcg.c',
>     'tcg-accel-ops-rr.c',
>     'watchpoint.c',
>   ))

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


