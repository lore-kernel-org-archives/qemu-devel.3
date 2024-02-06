Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88C4C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXNDK-0006aV-6B; Tue, 06 Feb 2024 10:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rXNDI-0006aI-VG
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:18:20 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rXNDD-0005EE-LS
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:18:20 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d9b2400910so5045255ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707232689; x=1707837489; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QN2U0/xe2V5YybyMZ5BRv2+udsbTD5c/528s2o98koA=;
 b=MORe7zRMqJDjk1xG7IpdPOeVCK3QwZ4ZcXBJbCDWdOIJFsoilwkgREvm9cRVOfhAu1
 auzYRqe9Ybw44NyvjfvuUEUiFgneXPQN6MbRGa0j92yqBCq9UjzRIkHYyh/qB9ZBkYhh
 AnV3Amq20PCXP+y39kun99PsPUBi9Q4z2BBVnlg81mvp8iRJSsRA8aCrqKis5BCM+HCs
 iCn5URMNoWahIXxPjVhka7stsQhdkEbp425cexG3LmyykUhLxHSns8IJGOP2MKy93Giy
 hjsUqcVKGGgfG7/nZws9Oqw+ciLZjXRTCuo7t3w8xFaOipReqUGFdG5RiAcFiznRaA6D
 VnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707232689; x=1707837489;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QN2U0/xe2V5YybyMZ5BRv2+udsbTD5c/528s2o98koA=;
 b=OPMkWBnwXcX9r/t9itVPrRm3QcBuULoSeQ2ubLyw3cmyHCA4qAwRhMUv4rePTcger4
 4CYPQkHfUfe7vIhpKf6Lkac0QusDKST6sRZLdTDgQPYv9I1TkBvcXvJHp9RA9Gpn99BN
 e38yZ+bquAk+8NdCvXzvXBfTFu2ioXEaPYJ9/yv2H56cjAZ3o2fj8aTUZtPhNwQSbJQg
 MFHea609jOQizQBCOADi3ZpDtjxYizhNzLT4f647Oolc+hqNdC7LTUkUMq5t13FpfSaz
 c4UEx0aK3wWOgn2qyDoGH02NvyEjYduuQh3wsVV0tIe3X8PlDIxioCbyq817Cnc8vCRi
 4ckQ==
X-Gm-Message-State: AOJu0YyO8QhEz1IdhfQAM3Amk3T0zTTHrqT1f4+Pav/AdPp5fcnzlR1K
 VFN1Hb27KdGtqKPOV+9drAbcHnVwaJDVp3sZxLR1rDvSJwlFYnDFzvTBLBuBgns=
X-Google-Smtp-Source: AGHT+IHTWpPx5LxkT2cvHaFz6hkxukjXWJMsWaA3f0UEacsmvJxUhQQSJrkk0/cbrbper+XP8K021w==
X-Received: by 2002:a17:902:d2c9:b0:1d7:5c60:f4f5 with SMTP id
 n9-20020a170902d2c900b001d75c60f4f5mr2995595plc.16.1707232689509; 
 Tue, 06 Feb 2024 07:18:09 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUaTTvhw+5rlRgSZndQxld5wqH4Y5qZ1NSxwdVE/iW+NgeRDeepl4WHPcVqc0HnuNWRFeYQPqHYXzqrt4tGcAe592SxErI=
Received: from ?IPv6:2804:7f0:b402:df90:2add:f1b6:5717:16e1?
 ([2804:7f0:b402:df90:2add:f1b6:5717:16e1])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a170902eb4600b001d8ffc059e3sm1983907pli.119.2024.02.06.07.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:18:09 -0800 (PST)
Subject: Re: [PATCH v2 1/6] linux-user/aarch64: Extend PR_SET_TAGGED_ADDR_CTRL
 for FEAT_MTE3
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240206030527.169147-1-richard.henderson@linaro.org>
 <20240206030527.169147-2-richard.henderson@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <c9b3e48e-1bcd-f3f7-0900-3148ef7a1d52@linaro.org>
Date: Tue, 6 Feb 2024 12:18:07 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20240206030527.169147-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-4.371, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/6/24 12:05 AM, Richard Henderson wrote:
> When MTE3 is supported, the kernel maps
>    PR_MTE_TCF_ASYNC | PR_MTE_TCF_SYNC
> to
>    MTE_CTRL_TCF_ASYMM
> and from there to
>    SCTLR_EL1.TCF0 = 3
> 
> There is no error reported for setting ASYNC | SYNC when MTE3 is not
> supported; the kernel simply selects the ASYNC behavior of TCF0=2.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/target_prctl.h | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
> index 5067e7d731..49bd16aa95 100644
> --- a/linux-user/aarch64/target_prctl.h
> +++ b/linux-user/aarch64/target_prctl.h
> @@ -173,21 +173,22 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
>       env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
>   
>       if (cpu_isar_feature(aa64_mte, cpu)) {
> -        switch (arg2 & PR_MTE_TCF_MASK) {
> -        case PR_MTE_TCF_NONE:
> -        case PR_MTE_TCF_SYNC:
> -        case PR_MTE_TCF_ASYNC:
> -            break;
> -        default:
> -            return -EINVAL;
> -        }
> -
>           /*
>            * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
> -         * Note that the syscall values are consistent with hw.
> +         * Note that SYNC | ASYNC -> ASYMM with FEAT_MTE3,
> +         * otherwise mte_update_sctlr_user chooses ASYNC.
>            */
> -        env->cp15.sctlr_el[1] =
> -            deposit64(env->cp15.sctlr_el[1], 38, 2, arg2 >> PR_MTE_TCF_SHIFT);
> +        unsigned tcf = 0;
> +        if (arg2 & PR_MTE_TCF_ASYNC) {
> +            if ((arg2 & PR_MTE_TCF_SYNC) && cpu_isar_feature(aa64_mte3, cpu)) {
> +                tcf = 3;
> +            } else {
> +                tcf = 2;
> +            }
> +        } else if (arg2 & PR_MTE_TCF_SYNC) {
> +            tcf = 1;
> +        }
> +        env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
>   
>           /*
>            * Write PR_MTE_TAG to GCR_EL1[Exclude].
> 

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

