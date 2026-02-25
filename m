Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C124F5543F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4nz-0001yK-GO; Tue, 24 Feb 2026 21:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv4ny-0001y8-Tg
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 21:39:14 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv4nx-0005lA-8D
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 21:39:14 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso52433115e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 18:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771987151; x=1772591951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZqJccJQO5pM22mj3NZ5DbAXLHW9QRA16yOh1Ivzasto=;
 b=mGry6YHwALJkD8/1vNI6vo/2k0c+wFxsVO8hx2le5pi9ikw+FyAemZO9VtvXeEK8va
 sn76RfBNi73zfWtECo8pcfV+fgKheSQxHeQTbZ2tPLMwvetNTPum3c00v1gaAIVPHa0t
 eKPc9xTwBiDkCPVv2uYc6iRyP8v2X/4IObqV2DdRR1IRUUAlxdew7yCF6GK7UNVi9M/o
 hw+5DuSGAk8YtBAjo25ziSyqyEZtCh23nbsI/c+1BqDs1K9GrDJkFn3YJ8zInh0nyGKg
 fQ/pSgUZAbrW9CaisRJhDYpIw3EW0cOYGLOw+iC7j8drU26ywWgrgFS/XVRQUwGfJEcc
 xDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771987151; x=1772591951;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZqJccJQO5pM22mj3NZ5DbAXLHW9QRA16yOh1Ivzasto=;
 b=GZsE5xhoGeMzWj0OBenfCf6PcgVp30L4UceAHOlREIU/uWS7ovNLrsLvToQ3cdAq2T
 s+5+uBXWcgieOSAKsJhMntrjQd6Sluoji4wGOGlPY30t0PC37OGIajLkJXpCaqW7VStq
 SbH+TICy6ImhEr2izGX1vLfaALELOYwDwOom3nqucgm/PEeLds1M1FmuyYtAsCd/FGDY
 g1rSW4yGXkUSaTr7eKNs3mMlMEox2MyMOGwWFNj3JsCJf1xX5YtuNEJtD/kEWNWlqnlj
 j3Qt+YnkwU+9lohQEsaG8WL9xHvp0fpzTG2daz8Lkegw1qwoJhXqXVZyhkBGsBnK1k/H
 H0Uw==
X-Gm-Message-State: AOJu0YymVQ5xlU1Or7F7GSAWfqc/vGSpzii1CYmwfenAQSmG5SL6lGpO
 tZWQN89pytTmX9v2xf49hESltjV8Z/92CetDhDZZ1XvyrRWTNM1dl39SRdPWQK3o5vz+JWOSKuz
 Cdlrcdgk=
X-Gm-Gg: ATEYQzxNZwCWLeQJO4Cfz3lSy24fGxwYOn63FWd9ii2jJileoumD5EF4BLFmT81VseP
 0HqOKtPxuPFpYku4aHSHQiLir6gk6luuge6+QZQnhcBRpDBlpbMPdy1BX24Vm2ZUa1KEu6JBmk7
 pEHZU93JpK5mvtXDP6wPzDKKvH9LePjU8gbvyfH7RB6loennQkXTD+KnHUGkK6L8xEcRr3LvEUR
 P9B4jxTFu4lCLCDhYmu1zkg5jt8HQxhudgOHJvGObtkP8VcYRZ8iVljj7rDnXs2L2RQbyNk//4r
 9mA989EXiczF94H1TS6bY4hqRNO24e5h06+tmVq7/hcZEwUOo33HiSpCRRW6F76LZuPZONPCq/E
 hf3UL1HAWbSLNmt/Ti8HCUrksuQyau12tO/elCjJe0NUPU+bwi4q/pwHM+tojq2BdLqODxWK10K
 8/QDVcfwHpyA9WcT04XtNskA/75nclBIOoujKVQexVTdHVK464bgZwivRPXvvpvfyivg==
X-Received: by 2002:a05:600c:154b:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-483a962e38bmr221901705e9.21.1771987150627; 
 Tue, 24 Feb 2026 18:39:10 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd72bd66sm34892535e9.11.2026.02.24.18.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 18:39:09 -0800 (PST)
Message-ID: <c8143c85-4338-44f9-955a-e4474c6dfc61@linaro.org>
Date: Wed, 25 Feb 2026 03:39:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/43] hw/arm/smmuv3-accel: Introduce smmuv3 accel device
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
 <20260129160917.1415092-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>
In-Reply-To: <20260129160917.1415092-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 29/1/26 17:08, Peter Maydell wrote:
> From: Shameer Kolothum <skolothumtho@nvidia.com>
> 
> Set up dedicated PCIIOMMUOps for the accel SMMUv3, since it will need
> different callback handling in upcoming patches. This also adds a
> CONFIG_ARM_SMMUV3_ACCEL build option so the feature can be disabled
> at compile time. Because we now include CONFIG_DEVICES in the header to
> check for ARM_SMMUV3_ACCEL, the meson file entry for smmuv3.c needs to
> be changed to arm_ss.add.
> 
> The “accel” property isn’t user visible yet and it will be introduced in
> a later patch once all the supporting pieces are ready.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Message-id: 20260126104342.253965-6-skolothumtho@nvidia.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/Kconfig          |  5 ++++
>   hw/arm/meson.build      |  3 ++-
>   hw/arm/smmuv3-accel.c   | 59 +++++++++++++++++++++++++++++++++++++++++
>   hw/arm/smmuv3-accel.h   | 27 +++++++++++++++++++
>   hw/arm/smmuv3.c         |  5 ++++
>   include/hw/arm/smmuv3.h |  3 +++
>   6 files changed, 101 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/smmuv3-accel.c
>   create mode 100644 hw/arm/smmuv3-accel.h


> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> new file mode 100644
> index 0000000000..0dc6b00d35
> --- /dev/null
> +++ b/hw/arm/smmuv3-accel.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
> + * Copyright (C) 2025 NVIDIA
> + * Written by Nicolin Chen, Shameer Kolothum
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_ARM_SMMUV3_ACCEL_H
> +#define HW_ARM_SMMUV3_ACCEL_H
> +
> +#include "hw/arm/smmu-common.h"
> +#include CONFIG_DEVICES

We shouldn't use CONFIG_DEVICES in a header as the files including
it become target-specific. I suppose this comes from a copy/paste
pattern of intel_iommu_accel.h :(

$ git grep -w CONFIG_DEVICES
hw/arm/smmuv3-accel.h:17:#include CONFIG_DEVICES
hw/i386/intel_iommu_accel.h:13:#include CONFIG_DEVICES
include/hw/s390x/s390-pci-vfio.h:16:#include CONFIG_DEVICES
target/i386/kvm/tdx.h:7:#include CONFIG_DEVICES /* CONFIG_TDX */
target/i386/sev.h:20:#include CONFIG_DEVICES /* CONFIG_SEV */

> +
> +typedef struct SMMUv3AccelDevice {
> +    SMMUDevice sdev;
> +} SMMUv3AccelDevice;
> +
> +#ifdef CONFIG_ARM_SMMUV3_ACCEL
> +void smmuv3_accel_init(SMMUv3State *s);
> +#else
> +static inline void smmuv3_accel_init(SMMUv3State *s)
> +{
> +}
> +#endif
> +
> +#endif /* HW_ARM_SMMUV3_ACCEL_H */


