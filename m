Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47A4C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 07:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLeR2-00017x-1b; Mon, 24 Jun 2024 03:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLeR0-000144-0A
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 03:48:18 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLeQy-0004Yf-3s
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 03:48:17 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57d2fc03740so2437794a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719215293; x=1719820093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7/9wyfVQUVWSGoVw3YfySL9yJlK8XR+ird4GYE+gAOo=;
 b=hF8LyvFiMrQuGHHm712nMJXwe+OHI9A2GoJ+aC6pBGHoCpq/BrKBqhlbe6sSOA/pF7
 QolhwMt86v+QNuPCzHVU9EgZBQURjAqCa/PvKHUiFOyt+wijyRyGKjToDAz8LbbB2GeK
 Al0En2BR/BCb/fj51mxYS3GlErkdd4JO6WxNjNXYQa9iK3aoPBCVGblat2c1I2C7IRXa
 d6JSJb+z4Rlzp4EgY3fz3FdEw7LaJFEYjnk6mcdBAzVE5OXbdskApbjEkjTozXOvkIkb
 hZwF7y86LURiLmhA+Lo77nMxPAqlqQFZDruENDMAUkYQ5cix16x7ewVTxNg+gBRSrutZ
 IqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719215293; x=1719820093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7/9wyfVQUVWSGoVw3YfySL9yJlK8XR+ird4GYE+gAOo=;
 b=iZK+PegseQRtlDvvbFbGHnwvQWvgt+mbpET39MHA8tVYrthkFyk4I1Z3H55M9+gUVg
 31hvCGnQ71c/5mas+oEA5eeDyBslGCXZR1SjsUKwp0Pct4YhDIDQfRjYfMwFHgOwt3AP
 RdvhlJK/LdXfzif0L3w9wwyuBsKvlOxjeqEKFCFx35zUW8qiTIRIdbpDWee6Aph15y7p
 X8Xp4K2XYPeuWjQoKqA8ZXjjYlOF7ll5WSTVdbTUau8xNRzp8lEBdXzs+z/etVUTZooj
 /BL3x8h5DpsvApTL0LHtAoX7WGXaG1TYhwOBT+THGkrOoaMhxqrBMf1Hi0HSVmbX9ruJ
 HJYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSwOuZIJjMf5aVOCEgA5JnvhsCEf99TW7AjNV6SN4rgp+Id6JKhFO/NPFdLGUnNuEDZ1KNT1ILGTLaLKjGj19ZFKHWNWg=
X-Gm-Message-State: AOJu0Yzn0/owv5GAE2wUDhJmnjqcSkgFPdKADQ/6OM+AqOgWNqVgixpc
 u9/hjpGITA0oa1bUg7W+BxUEh+SJg9Pq6x0EqAI1GPHGFh9TZMdxCiiPM4S2GEs=
X-Google-Smtp-Source: AGHT+IG6bkbPXP9wSn/3mv3hlc/kY91V351ExsP6OtEP5CfR2KWmu0s2tN4GDR4yd8VCKJFdmZXxIw==
X-Received: by 2002:a05:6402:35d4:b0:57c:a7fe:d275 with SMTP id
 4fb4d7f45d1cf-57d4bdca699mr2743486a12.32.1719215292697; 
 Mon, 24 Jun 2024 00:48:12 -0700 (PDT)
Received: from [192.168.69.100] (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3048b93asm4502082a12.56.2024.06.24.00.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 00:48:12 -0700 (PDT)
Message-ID: <c82c83b4-21f0-40e0-8a7c-e38205ae838b@linaro.org>
Date: Mon, 24 Jun 2024 09:48:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] target/arm: Factor out code for setting MTE TCF0
 field
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240624053046.221802-1-gustavo.romero@linaro.org>
 <20240624053046.221802-7-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240624053046.221802-7-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 24/6/24 07:30, Gustavo Romero wrote:
> Factor out the code used for setting the MTE TCF0 field from the prctl
> code into a convenient function. Other subsystems, like gdbstub, need to
> set this field as well, so keep it as a separate function to avoid
> duplication and ensure consistency in how this field is set across the
> board.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   linux-user/aarch64/mte_user_helper.h | 38 ++++++++++++++++++++++++++++
>   linux-user/aarch64/target_prctl.h    | 22 ++--------------
>   2 files changed, 40 insertions(+), 20 deletions(-)
>   create mode 100644 linux-user/aarch64/mte_user_helper.h
> 
> diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
> new file mode 100644
> index 0000000000..fd92e71c00
> --- /dev/null
> +++ b/linux-user/aarch64/mte_user_helper.h
> @@ -0,0 +1,38 @@
> +/*
> + * ARM MemTag convenience functions.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef MTE_H
> +#define MTE_H
> +
> +#include "sys/prctl.h"
> +
> +static inline void arm_set_mte_tcf0(CPUArchState *env, abi_long value)
> +{
> +    /*
> +     * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
> +     *
> +     * The kernel has a per-cpu configuration for the sysadmin,
> +     * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
> +     * which qemu does not implement.
> +     *
> +     * Because there is no performance difference between the modes, and
> +     * because SYNC is most useful for debugging MTE errors, choose SYNC
> +     * as the preferred mode.  With this preference, and the way the API
> +     * uses only two bits, there is no way for the program to select
> +     * ASYMM mode.
> +     */
> +    unsigned tcf = 0;
> +    if (value & PR_MTE_TCF_SYNC) {
> +        tcf = 1;
> +    } else if (value & PR_MTE_TCF_ASYNC) {
> +        tcf = 2;
> +    }
> +    env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);

Missing "qemu/bitops.h" header.

> +}
> +
> +#endif /* MTE_H */
> diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
> index aa8e203c15..ed75b9e4b5 100644
> --- a/linux-user/aarch64/target_prctl.h
> +++ b/linux-user/aarch64/target_prctl.h
> @@ -7,6 +7,7 @@
>   #define AARCH64_TARGET_PRCTL_H
>   
>   #include "target/arm/cpu-features.h"
> +#include "mte_user_helper.h"
>   
>   static abi_long do_prctl_sve_get_vl(CPUArchState *env)
>   {
> @@ -173,26 +174,7 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
>       env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
>   
>       if (cpu_isar_feature(aa64_mte, cpu)) {
> -        /*
> -         * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
> -         *
> -         * The kernel has a per-cpu configuration for the sysadmin,
> -         * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
> -         * which qemu does not implement.
> -         *
> -         * Because there is no performance difference between the modes, and
> -         * because SYNC is most useful for debugging MTE errors, choose SYNC
> -         * as the preferred mode.  With this preference, and the way the API
> -         * uses only two bits, there is no way for the program to select
> -         * ASYMM mode.
> -         */
> -        unsigned tcf = 0;
> -        if (arg2 & PR_MTE_TCF_SYNC) {
> -            tcf = 1;
> -        } else if (arg2 & PR_MTE_TCF_ASYNC) {
> -            tcf = 2;
> -        }
> -        env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
> +        arm_set_mte_tcf0(env, arg2);
>   
>           /*
>            * Write PR_MTE_TAG to GCR_EL1[Exclude].


