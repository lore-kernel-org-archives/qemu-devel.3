Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1137C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 18:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twQBK-0002T5-4v; Sun, 23 Mar 2025 14:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQBH-0002Ry-FH
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 14:36:19 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQBF-0002MI-KQ
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 14:36:19 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-227a8cdd241so13571435ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742754975; x=1743359775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G2qrNbJRAZbpMl4Sn6+sWDBz6wTnV27zw+SxxTWiOV8=;
 b=HbOnPdRqHQiaHjLvq3mmVLg1jdq/nMrwL+rL3XTbzQ2aB1B8oJ+LjtxaBDGNNFZWNP
 xb0M0JcvZHZWYKzAfoZ99EuCic/p5OLWN6dzxWMKxCUmO0iDiCq4JmTxttSk7xHpOcH/
 FHra2FQNa042z6UUDAg/DOqzpZLMy5AZ8kcD/YntbJ8K46BPqCRrUIkxCqIdcCzwsSxI
 jK98YksHrNGMnArH6qB4O7ejT87cx5aOEa1F1v66fwtgn2AJushU6/HvORZxFUZZzw+S
 KgMSFvN+epoxd+K6yBAobZ438AQSUN7gm/LTrIyve2IneEqrgs8KJEr98XRG8Uka9e4w
 78pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742754975; x=1743359775;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G2qrNbJRAZbpMl4Sn6+sWDBz6wTnV27zw+SxxTWiOV8=;
 b=ofHnejGxVSyw+5/wJvd946oOCpVOpcFShEkOmW/yfOuFxw5EsrFTCDfz+pvPixJndQ
 rbVxHTrYT380uiYeV+kqkmnAgqejUNvuz34i7cP6o5hku2xN2BTALoHULLGwDxGSAtEE
 wGJuhlfaVGUSpPaMLIGS0fwbabrTbD0FgoYr+KOHFgW8ro/mFo7pK1gWToJYQwJ+wkxz
 SF5TF1oxsIt/+e38378moAuQJiypQnWUEUBewbyeuyjj0x+pevFrqS8/gYpLh+SSAr2o
 pR5DgoI58wy1+ROqfLvvUxxLWnuGCoFHpdNvo5RT4UEsLBl1FLdj/Te6li3gE+wxFAyQ
 zceg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlrqeScfa32FxJgR7Th4HL5x2Uv2QxEZjSIKYQF8xdXQv2OEMh0/qWAxtePan7RYmRm4xcX/iNutuN@nongnu.org
X-Gm-Message-State: AOJu0Yw8TaCt+q5moWuGMsnbUk3O//q8dF5nGwK0E4h8NR2ZGTFM1bKx
 tJpkHhy4ig87jHbWIUA3lCNoX/lVqijQVLKlnW3sAAOvEG7mGPaYiMUokNnb7GQ=
X-Gm-Gg: ASbGncuTXKmdqon/bNzpTUPNO26T8a2WNZcQgIXl3zfOx6dYTM30kGaS72BThWZg25W
 IeVIejMTVd/x+rRmrLU2yoBUaSy0juZQpOaca4CeTX/nJDSQcu771HifW/DBggxMi1ieeocSVCy
 wKjwuiexwZOp1xujZNB7/suAjVu2Rvk8ztN/rKiCFJhDGEM++SxSW7c/oEyGvFuz4Sj7ER7SP5X
 +U0jkJzvW4evAW98SBfPDDRIchRHr5pH3dQQ53vi9NughgUgbEFAFgQzJEcSDu/9oQGjqP8Y9Co
 z0npUdiSeUfSL1ZRCXj2khhAzot0oWT5YBLnAsjjQnW4odkK3vtyruhtvIxZ47kQ/jAR0YmLjH7
 /ZM4WJv7mxBxREyzxw3s=
X-Google-Smtp-Source: AGHT+IGZCix34SJ5t5o+/qKB79zQzlSgSdVLuaDjingzP/d+oQl5caa/q/K45jeqyipJyCJdbX/xmg==
X-Received: by 2002:a17:903:8cd:b0:21f:35fd:1b7b with SMTP id
 d9443c01a7336-22780e1a303mr179076525ad.50.1742754975064; 
 Sun, 23 Mar 2025 11:36:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811c156dsm54528625ad.117.2025.03.23.11.36.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 11:36:14 -0700 (PDT)
Message-ID: <9e31c172-0474-4254-8fe7-96eaa517ddac@linaro.org>
Date: Sun, 23 Mar 2025 11:36:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/4] tcg: Move qemu_tcg_mttcg_enabled() to
 'system/tcg.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321155925.96626-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/21/25 08:59, Philippe Mathieu-Daudé wrote:
> qemu_tcg_mttcg_enabled() is specific to 1/ TCG and
> 2/ system emulation. Move the prototype declaration
> to "system/tcg.h", reducing 'mttcg_enabled' variable
> scope.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h      |  9 ---------
>   include/system/tcg.h       |  8 ++++++++
>   accel/tcg/tcg-all.c        | 11 ++++++++++-
>   target/riscv/tcg/tcg-cpu.c |  1 +
>   tcg/region.c               |  4 +++-
>   5 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5d11d26556a..54570d21aea 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -597,15 +597,6 @@ extern CPUTailQ cpus_queue;
>   
>   extern __thread CPUState *current_cpu;
>   
> -/**
> - * qemu_tcg_mttcg_enabled:
> - * Check whether we are running MultiThread TCG or not.
> - *
> - * Returns: %true if we are in MTTCG mode %false otherwise.
> - */
> -extern bool mttcg_enabled;
> -#define qemu_tcg_mttcg_enabled() (mttcg_enabled)
> -
>   /**
>    * cpu_paging_enabled:
>    * @cpu: The CPU whose state is to be inspected.
> diff --git a/include/system/tcg.h b/include/system/tcg.h
> index 73229648c63..7622dcea302 100644
> --- a/include/system/tcg.h
> +++ b/include/system/tcg.h
> @@ -17,4 +17,12 @@ extern bool tcg_allowed;
>   #define tcg_enabled() 0
>   #endif
>   
> +/**
> + * qemu_tcg_mttcg_enabled:
> + * Check whether we are running MultiThread TCG or not.
> + *
> + * Returns: %true if we are in MTTCG mode %false otherwise.
> + */
> +bool qemu_tcg_mttcg_enabled(void);
> +
>   #endif
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index cb632cc8cc7..d75ecf531b6 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -38,6 +38,7 @@
>   #include "hw/qdev-core.h"
>   #else
>   #include "hw/boards.h"
> +#include "system/tcg.h"
>   #endif
>   #include "internal-common.h"
>   #include "cpu-param.h"
> @@ -58,6 +59,15 @@ typedef struct TCGState TCGState;
>   DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
>                            TYPE_TCG_ACCEL)
>   
> +static bool mttcg_enabled;
> +
> +#ifndef CONFIG_USER_ONLY
> +bool qemu_tcg_mttcg_enabled(void)
> +{
> +    return mttcg_enabled;
> +}
> +#endif

It would appear (and it makes sense) that mttcg_enabled is only set for user-mode.  I 
think you should be conditionalizing the variable for system mode as well.


r~

