Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF17FC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd9I-0002IE-LW; Fri, 07 Mar 2025 14:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd9B-00023A-MS
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:14:17 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd99-0007hY-FE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:14:12 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223a7065ff8so16704795ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374849; x=1741979649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ihrifSouUpbqUQXAN/h4JcembgwatUGO+wfPaCDTAA=;
 b=k2XM4SH65Ubzv+RkPwPoEamUwvgP3rjQNdXfhMZRjIrAblE4XR5xgidOhXSy1+VDG7
 gECVYyXgI4lWlmydyAQ6gKA//HFWUdx1BDA2qGL5NufoXJaqWgIdiwjR9SM5XKZTO0uG
 SMhJ6KISFS07mTsmr2Xo/S8h1U0FSDFTXx50une0a41cb33vInDzuFcDYNG/yjsRQYj5
 0QZpp0m2WvZTM1UisAeTWAzsezlnHke+yk73m+Czley3gLzopZqGfsvs26IOs4EymLJk
 bL13vgC3cntbtN60yR0PCTFExu8TocfgT8zCMU2ng6jHM1k0WXFMD7qUHlua2Qp4RWlQ
 cU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374849; x=1741979649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ihrifSouUpbqUQXAN/h4JcembgwatUGO+wfPaCDTAA=;
 b=p1gn8n+wuiysGmCrbtQ4VksNQbK39bpvZSfPffLLpuhl46VZcRrJVP7kVNbrhYwntu
 gh4X1jHyS2Lp4nGGbYitD9SXGlIftkLNciCoyh/mYR7WNdtbksJVydacDGryiOD1TuwB
 jktBwnQHviH+6+BYC1fhbL06nMGVw2pNqTUrMaDQ29lbDMEP4lGTdq2P3u0cVnu73ZQ8
 OJnDbGDzdA+koHRJvFIzEUyN6tBLAM5aWnZzC4wW2ElNIKCKPJD2UFKIAkjC3pOu70Ac
 bK0LiEbN4mx9xifM7eFPcdei1Iq+ibDuA2ek0FbBGuZ4adY9tdwnHxKEiJjluhnXftcD
 MH4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXTkc8Mxx8CYYsoc7ZdjhCO3peQln8hPADMDwN1eAVnBw4gA7ePxbrOTj0/LnmQFgPIuAfHwj7/sZ6@nongnu.org
X-Gm-Message-State: AOJu0YzQEeZYhxmnzpeZmRcHPuqbhv0yiL4IAX8MEvz8B5tG6lakDwRv
 JS/hsMlDwa4zLiS2okSNMOzW11tVAZZui21caBx5ku5rGrcUdSTKQ7Wz+qLppPXVtU02yd5/xPH
 v
X-Gm-Gg: ASbGnct48zmeoeOMlvjSjz18+ByH2ZxqrXbMTens4lhCDCmZf1Fj37U/o6UCyhNkrIm
 kGUZl3kgp48gnP2Gx7FbfBrwVwhP5GYd1fiilNVoyCc+kI/1Xuvc3v27VqU6UttKxJvzP/FJJnx
 r/YPfiCFKsAVkdVs2hCwunNuLMqPTo+vsfmJEsyFzdVDV/hbPt9FAOuIXL1IJ7iJ5mJ+HvMQJqd
 GmLIn7u5DE3sK8Vpz4tOGz4nfQhkB/1idchwe5tNGF++Vs9KtBl3Gs9wEM5xIMw0B9zEVKjuFpx
 voDPJOfWiAGeGxpoTggxYP6FRN0QtFN+d6LIt0C0ySLQA+UaWc8/ya6EYg==
X-Google-Smtp-Source: AGHT+IExGzYFrldix4Wj2zZAUOfcFAlhSxuOJMyHtc7/rmu3YM/9c7ozBiFGW9x75Iu/weMX3RVUAg==
X-Received: by 2002:a17:902:ea07:b0:21f:f3d:d533 with SMTP id
 d9443c01a7336-2242887b2a3mr66592415ad.2.1741374849498; 
 Fri, 07 Mar 2025 11:14:09 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aa5eedsm33868395ad.236.2025.03.07.11.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:14:09 -0800 (PST)
Message-ID: <e353dce0-3270-4005-b6ff-e0749564e28a@linaro.org>
Date: Fri, 7 Mar 2025 11:14:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] accel/tcg: Build tcg-runtime-gvec.c once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-18-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307185645.970034-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-runtime-gvec.c | 1 -
>   accel/tcg/meson.build        | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> index afca89baa1..ff927c5dd8 100644
> --- a/accel/tcg/tcg-runtime-gvec.c
> +++ b/accel/tcg/tcg-runtime-gvec.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/host-utils.h"
> -#include "cpu.h"
>   #include "exec/helper-proto-common.h"
>   #include "tcg/tcg-gvec-desc.h"
>   
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 411fe28dea..38ff227eb0 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -1,13 +1,13 @@
>   common_ss.add(when: 'CONFIG_TCG', if_true: files(
>     'cpu-exec-common.c',
>     'tcg-runtime.c',
> +  'tcg-runtime-gvec.c',
>   ))
>   tcg_specific_ss = ss.source_set()
>   tcg_specific_ss.add(files(
>     'tcg-all.c',
>     'cpu-exec.c',
>     'tb-maint.c',
> -  'tcg-runtime-gvec.c',
>     'translate-all.c',
>     'translator.c',
>   ))

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


