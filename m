Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB8EC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5iu-0005Rk-M3; Fri, 28 Jun 2024 03:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ia-0004rb-H6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:25 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iY-0004Ov-44
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:24 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ec52fbb50cso2291951fa.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558500; x=1720163300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+rsesIuhtBSUnVsKBhHCEih6zsr/jqTHDocjiLfN9Uk=;
 b=KtbZr7Ic/VrENL0t8JNga1G3/kJXa8g4zxNoj35jAl+JVk51gRXuMzlu59oiJv/DRS
 1mBlUKUs9hUZwRskQYr7o8L8/g8Zxx7KI8rnwIWO+O3O2/zJf+feSkjS2HnxsF2qT9YH
 VIFHjL5HjOCYfKZj28tLjKoyiEdpndFFjQ+vil1b69rFF9yao7eAmlauROiVSvEausrF
 upkfvRCNhSLsmjBVIwiDAIyRRkyfbfcFFv1agjznS7OLgGNa2Jlx85j56+I2QFL0J9zx
 bAkGNdb/TmLgbq1LJCK51h9tFBS1uZnkq7q3uttGlfWPaepcDKjwzhfcmwUOfIWidYLH
 iISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558500; x=1720163300;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+rsesIuhtBSUnVsKBhHCEih6zsr/jqTHDocjiLfN9Uk=;
 b=rD3HDCX+cMcKOl6TeU3RRSdtIHBTZ5rCJAxQO0OPXeuPY4ChFfgSipsVJozkfzBNXr
 +tY9QFwEryTSquRQiJI/PJ0Y/Pj6J9FXpRhQvRLNkOTSAYc+I+G+EzE8cQfKQc/58K+8
 uLO4vl99+xwNlbXWbvqfGHJzTB6vUMc1RHv93dVmabALdM9IXSg84Yg6mqdAQIdOzhFN
 l6D/QP0jBJV8l2LiO1KCxx9hy3lbbbrFNNYTzi0UMiGRGXkQjf7ZhzguhvYMTQ3iwu3D
 ZSo6eKe2xKSHKalg9xl2C9w5eVtB5VLtCnYDW1lZBYlaq5e7kfgCo4/np0L+jHcZK7OF
 bdVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN0q+O06Yc+sCMlREq2IF1cab4gvRSVF0AqPC+fdLmWgWRgWxYxZ++BT9h2+vJuzD2vvKrF/nFzUeALTfdfL6YmdpjvwU=
X-Gm-Message-State: AOJu0YxdiDeclDsRRD/cYu4S+3N+abBZrShQz3BCFZ07Hs2ANMvQWVwA
 I+muF+5CS9nKSGhRzvBSbUnKHUvcQ/cvJ2Nn2AMKtaAup6TINp4lL0rKtEqt1WA=
X-Google-Smtp-Source: AGHT+IH5x9/wDPHsFJ2zKyxqnaONq5wPgF+OReZxl0StuSIxW1nO4VStu4UfBp9BBRmaaJfhSNviuA==
X-Received: by 2002:a05:651c:154b:b0:2ec:61b5:2162 with SMTP id
 38308e7fff4ca-2ec61b521d6mr104658061fa.25.1719558499924; 
 Fri, 28 Jun 2024 00:08:19 -0700 (PDT)
Received: from [192.168.69.100] (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256aed2263sm22874775e9.0.2024.06.28.00.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 00:08:19 -0700 (PDT)
Message-ID: <18343152-c677-4075-8c55-9a2802742a79@linaro.org>
Date: Fri, 28 Jun 2024 09:08:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] target/arm: Factor out code for setting MTE TCF0
 field
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
 <20240628050850.536447-7-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240628050850.536447-7-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

On 28/6/24 07:08, Gustavo Romero wrote:
> Factor out the code used for setting the MTE TCF0 field from the prctl
> code into a convenient function. Other subsystems, like gdbstub, need to
> set this field as well, so keep it as a separate function to avoid
> duplication and ensure consistency in how this field is set across the
> board.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   linux-user/aarch64/meson.build       |  2 ++
>   linux-user/aarch64/mte_user_helper.c | 34 ++++++++++++++++++++++++++++
>   linux-user/aarch64/mte_user_helper.h | 25 ++++++++++++++++++++
>   linux-user/aarch64/target_prctl.h    | 22 ++----------------
>   4 files changed, 63 insertions(+), 20 deletions(-)
>   create mode 100644 linux-user/aarch64/mte_user_helper.c
>   create mode 100644 linux-user/aarch64/mte_user_helper.h
> 
> diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.build
> index 248c578d15..f75bb3cd75 100644
> --- a/linux-user/aarch64/meson.build
> +++ b/linux-user/aarch64/meson.build
> @@ -9,3 +9,5 @@ vdso_le_inc = gen_vdso.process('vdso-le.so',
>                                  extra_args: ['-r', '__kernel_rt_sigreturn'])
>   
>   linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [vdso_be_inc, vdso_le_inc])
> +
> +linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [files('mte_user_helper.c')])
> diff --git a/linux-user/aarch64/mte_user_helper.c b/linux-user/aarch64/mte_user_helper.c
> new file mode 100644
> index 0000000000..8be6deaf03
> --- /dev/null
> +++ b/linux-user/aarch64/mte_user_helper.c
> @@ -0,0 +1,34 @@
> +/*
> + * ARM MemTag convenience functions.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +

   #include "qemu/osdep.h"
   #include "qemu.h"

> +#include <sys/prctl.h>
> +#include "mte_user_helper.h"
> +
> +void arm_set_mte_tcf0(CPUArchState *env, abi_long value)
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
> +}
> diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
> new file mode 100644
> index 0000000000..ee3f6b190a
> --- /dev/null
> +++ b/linux-user/aarch64/mte_user_helper.h
> @@ -0,0 +1,25 @@
> +/*
> + * ARM MemTag convenience functions.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef AARCH64_MTE_USER_HELPER_H
> +#define AARCH64_MTE USER_HELPER_H
> +
> +#include "qemu/osdep.h"
> +#include "qemu.h"

NACK. See my comment on v5.


