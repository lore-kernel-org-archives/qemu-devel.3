Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D172CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKtmX-0005AX-Cx; Thu, 07 May 2026 04:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKtmQ-00054a-J9
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:08:22 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKtmO-0005rz-K2
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:08:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso4269935e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778141298; x=1778746098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EzotbZ7TAydxGWndEY30q/XZZ4LfI6YScTYGtlOu7KQ=;
 b=Uoko03Fc6atYJ+HAYqJ/Dj5/cv39SDtZwHGNl0slKm1tfJ6F1p5zpKiEegdDn0Ol2V
 txzhs4WB09wUXWlBY7ySuRPhr5kf4EraT+HZEHEMimkJO1+lf/voLs9EH0rKughlPU1Q
 0+0fnVi2uK7agygjv4h3GY/78d4ad9Xs1WdJv4qrMzsamgN5BdECwG/5WOb8rBlQqoU5
 nj3upWAR1oN69WFGl66eJCIEANzfQKBSlUHa9f6m6OwfbXcCcLD0D1MEPOqYWtvw/402
 +N7C3ZxDP5mlm7hcDNYxBLEDZH65NaKFxYIACBmwF66Cpx7dVqQPHM621T1GMspU3ijE
 qe3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778141298; x=1778746098;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzotbZ7TAydxGWndEY30q/XZZ4LfI6YScTYGtlOu7KQ=;
 b=S8evQWYLWzIXlkhORoaYZ8TWl+YT1p/DXmzd9UaKJFN0J9/rdZ06FmFqRdeJAbdap4
 b9vMQ1cXX8SeUYc30CTUEswxqR1IbyzJBU1RvP+PSQGGBTlrhCp3S+bsnpBDI+RA3cyv
 leRFYhXAUp/l996fsRsHQw8fzl+4ejrg+WwKyB80ihAnFCUcYpwZkKxBCJKBWT/tSRGN
 XvrzeUY/aLBP0yuRk6toQ73pUSEkefSdzK6l373gJCDxoFMtNFqdPSRLv/R0koWj8fP7
 bWEHK7G69BGoNwY8ZFjqvGcuelEqUrgtwcy0qq0851w+JigGoT+7pGBomdTfrAzKV3d0
 Ks4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Q4dS2zgJTCF3ciWdgG7lb51gknrIQm+GaFiw14SqDYPMuNm/ZSh3qUYhsW9F4/IOWjL+OeaGXRVJO@nongnu.org
X-Gm-Message-State: AOJu0YyyY5RyKeSDt2U8QQB6RNaBecgbXUhGwcWqtmIvRwSNwhgAdHzH
 OiR2fG2Y30Up6cPJOnI6Q53jhjqlfvIKHzxQOJHAG4y+U1+ACoNG/+HHN1OF5/1qojU=
X-Gm-Gg: AeBDievoFCd2ULb5L8afdP5PyJs2mmUWH0UaRDipAtwPys7OLIDB0hMPSxMBusPhADi
 zDpLu/X+iJH34eHAc2Q65+5K/X2x4pwLj6gLqWrhBo/kKbtPen4GWz4ptDmS7sSc1NAEKoGAnhr
 dsMxsluvmr4Ik3pYESkD2P0zBEJSO5a/IyoO6Sl69eIbJ7dnP/1H/GbSwmCo+aChieUpc7YvZo7
 tnWBWU1P0WgbNs19m6joWDYN+zVha9vMyPTTKnWCNj89UNLOzVnYctfjRuSC1WAQjXCUTIoyeMC
 N8H6gsjiL0u5svE0PyNWRNq8HJha7O+XCZVzJItbWTKQ81g2yCV5M5RlqeYiWgsyFYquXjnBjgO
 wfJTftiUtOYV6LRG9UYVZGUtDy33idMisDcCD/ze7m7NNXQRDrU7QWkC9H+QextvrsT2Wz4fcl+
 nO50adkv5iwJWuKfq8BW9/eNS2+hI/4zZFSarfn6NIGiI/yh8+9kRQ8HyFlRB27XIiZl1E8dTj1
 Szm
X-Received: by 2002:a05:600c:1d18:b0:489:149a:f9e6 with SMTP id
 5b1f17b1804b1-48e51f46dcfmr104688065e9.28.1778141298452; 
 Thu, 07 May 2026 01:08:18 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530b293bsm33507365e9.1.2026.05.07.01.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 01:08:17 -0700 (PDT)
Message-ID: <52c737ae-0d10-48e2-9f7e-1bfb374831c9@linaro.org>
Date: Thu, 7 May 2026 10:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/28] hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
 <20260501101505.3485916-16-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
In-Reply-To: <20260501101505.3485916-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 1/5/26 12:14, Peter Maydell wrote:
> From: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> On HVF, some of the GIC state is in an opaque Apple-provided structure.
> 
> Save/restore that state to be able to save/restore VMs that use the hardware GIC.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Revisiting this patch ;)

> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Message-id: 20260429190532.26538-3-mohamed@unpredictable.fr
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv3_common.c         |  1 +
>   hw/intc/arm_gicv3_hvf.c            | 94 ++++++++++++++++++++++++++++--
>   hw/intc/arm_gicv3_hvf_stub.c       | 25 ++++++++
>   hw/intc/meson.build                |  1 +
>   include/hw/intc/arm_gicv3_common.h |  3 +
>   5 files changed, 120 insertions(+), 4 deletions(-)
>   create mode 100644 hw/intc/arm_gicv3_hvf_stub.c
> 
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 9200671c7a..9c3fb2f4bf 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -305,6 +305,7 @@ static const VMStateDescription vmstate_gicv3 = {
>       .subsections = (const VMStateDescription * const []) {
>           &vmstate_gicv3_gicd_no_migration_shift_bug,
>           &vmstate_gicv3_gicd_nmi,
> +        &vmstate_gicv3_hvf,

Since HVF is a *host* feature, I wondered why not wrap with CONFIG_HVF
#ifdef'ry but that triggers the "attempt to use a poisoned identifier"
error.

So we really need a stub, right?

>           NULL
>       }
>   };


> diff --git a/hw/intc/arm_gicv3_hvf_stub.c b/hw/intc/arm_gicv3_hvf_stub.c
> new file mode 100644
> index 0000000000..a587332c7c
> --- /dev/null
> +++ b/hw/intc/arm_gicv3_hvf_stub.c
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * ARM Generic Interrupt Controller using HVF platform support stub
> + *
> + * Copyright (c) 2026 Mohamed Mediouni
> + *
> + */
> +#include "qemu/osdep.h"
> +#include "hw/intc/arm_gicv3_common.h"
> +#include "migration/vmstate.h"
> +#include "qemu/typedefs.h"
> +
> +static bool needed_never(void *opaque)
> +{
> +    return false;
> +}
> +
> +const VMStateDescription vmstate_gicv3_hvf = {
> +    .name = "arm_gicv3/hvf_gic_state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = needed_never,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +};
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index b7baf8a0f6..c6de2d9d00 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -43,6 +43,7 @@ arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
>   specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
>   specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files('arm_gicv3_whpx.c'))
>   specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
> +specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_false: files('arm_gicv3_hvf_stub.c'))

IIRC if_false does not work as expected with multiple conditions.

Simpler is to directly use the stub_ss[] source set:

-- >8 --
-specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_false: 
files('arm_gicv3_hvf_stub.c'))
+stub_ss.add(files('arm_gicv3_hvf_stub.c'))
---

(I'll post that patch)

>   specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
>   arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
>   specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index 9adcab0a0c..03ab3e8f2f 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -339,4 +339,7 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
>    */
>   const char *gicv3_class_name(void);
>   
> +/* HVF vGIC-specific state: stubbed out on a build with HVF disabled */
> +extern const VMStateDescription vmstate_gicv3_hvf;
> +
>   #endif


