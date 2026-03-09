Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05649EFCD6C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWkh-0003KY-Dr; Mon, 09 Mar 2026 05:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzWkd-0003Jy-Mi
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzWkb-000479-Jd
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773047888;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfx3EK7MACARCzTSjNItTuf797kpj/G+oEG2icoTA94=;
 b=KeSHIihb1H5Qq+HbDfLQ1bX71NQS9ZW36KgdVHqsxdXFkcKd2BsFDt7kURCLKnIl/6Qcbb
 dYEM0pNb3sEYl8ohHs8sGTZpg5bywmZ2g4La6WSGGbov4HE3gNq3fUERIWPA7iY16lOEH+
 uLolMJk4ELuLZnDyNr4zmAQG+KC3Iw8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-VzV3CeA1OOGnY701vYX3jQ-1; Mon, 09 Mar 2026 05:18:06 -0400
X-MC-Unique: VzV3CeA1OOGnY701vYX3jQ-1
X-Mimecast-MFC-AGG-ID: VzV3CeA1OOGnY701vYX3jQ_1773047885
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439c4bde453so3989987f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 02:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773047885; x=1773652685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfx3EK7MACARCzTSjNItTuf797kpj/G+oEG2icoTA94=;
 b=aHeP07VMzciTmLfX5aaKdt+XinzHCd8/NA8l8pt0qU09DNl2WIrZXbTkjoM484VhuA
 5WHf3kP4Z+znc9eOyRC9SrxoGhZEL0eCn7WEpNTd3uK8VmSWqWwX7ilBjMcVmV2PnhQU
 jGgXMf4K0s8w50YMtiGs4WxhcnfiMEME0m8sEWTj/T9sCdOQJ+GGu41je96wdlaWhY7h
 BSmys851kK59VnBmYXYvzn4nwetxA4ja+LCmxNG4+KVESM/dnTfyXb1I6vrcVokR30z6
 kDk8AoPZeTxarFR9mnvuolpbZoFihavv68zq1vCZEXsq7QSvcB/rEL/dc8DqVP/oEMcq
 O1Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3r7Mv8HVtR2trutlcxO60G+/Ya0zGkDDl+nxqibQvnof5JgLa9RR+dzV/WCKHabbtattAnMe6pF7p@nongnu.org
X-Gm-Message-State: AOJu0YwLDv/0k3810RBaJdgtd1nbqDX2SvRXR+SCnKbYOqvAzPFBq8Le
 UmDOFq+AsalodcZT8XFNdyHBD4IC2Fk3h0LuZt+NYCqI/U9QCfjUrwg6bipvgGk9qjM623DjvF0
 KIN4f2tC63ej8CK1r2NO1N8+74hieobOMDM1HDvXGesnTx7OZSEqDqjIv
X-Gm-Gg: ATEYQzzg4TdI39uGMTTBsM5XAELJpJAc/UBhxKZ51k7za9zOu26COjAFaMdmTa9sCrW
 xGvEsYM18c9VssPP44UhfU3bDsZHrgrW9tcVvgzP8QOca8PSs/HRWuhfV5FzfbzJ98XOBGqmi7o
 jMnqqe80nsRdk+ABy8zqoXbN7+TerfGaA1wNzcur2Bi1dGZeo9BzkVr0kJBUJGlCFc3tACEHukC
 uEmPEOroyCOZBnoxXKex3jgqR8sb+lfKhRwSiAtTeHxvaNRmpJPiQQB8jjQniIXVtu6pqd3+p1N
 sBRe1um7aKk9VIogf6SLzYXTf9cZlEMF2KN4D0d3LYlQyZOmKuSAZ/tEoqvjNK2ef+aX4sE75It
 fBQLKLphHDn3yvb8pLQwtxWOh8IoXVh18ilfC+b9kMexvTfFOgralTSMgG6TH4nx9KiXUkQ==
X-Received: by 2002:a05:600c:1e88:b0:47e:e952:86c9 with SMTP id
 5b1f17b1804b1-485268bd528mr200986195e9.0.1773047885139; 
 Mon, 09 Mar 2026 02:18:05 -0700 (PDT)
X-Received: by 2002:a05:600c:1e88:b0:47e:e952:86c9 with SMTP id
 5b1f17b1804b1-485268bd528mr200985655e9.0.1773047884598; 
 Mon, 09 Mar 2026 02:18:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48535863e40sm129894085e9.14.2026.03.09.02.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 02:18:03 -0700 (PDT)
Message-ID: <1d42eed4-d9cd-46a3-9613-00c1b347fa4d@redhat.com>
Date: Mon, 9 Mar 2026 10:18:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/32] hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops
 backend stub
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-7-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-7-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> Introduce a Tegra241 CMDQV backend that plugs into the SMMUv3 accelerated
> CMDQV ops interface.
>
> This patch wires up the Tegra241 CMDQV backend and provides a stub
> implementation for CMDQV probe, initialization, vIOMMU allocation
> and reset handling.
>
> Functional CMDQV support is added in follow-up patches.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.h       | 15 ++++++++++
>  hw/arm/tegra241-cmdqv-stubs.c | 18 +++++++++++
>  hw/arm/tegra241-cmdqv.c       | 56 +++++++++++++++++++++++++++++++++++
>  hw/arm/Kconfig                |  5 ++++
>  hw/arm/meson.build            |  2 ++
>  5 files changed, 96 insertions(+)
>  create mode 100644 hw/arm/tegra241-cmdqv.h
>  create mode 100644 hw/arm/tegra241-cmdqv-stubs.c
>  create mode 100644 hw/arm/tegra241-cmdqv.c
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> new file mode 100644
> index 0000000000..07e10e86ee
> --- /dev/null
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -0,0 +1,15 @@
> +/*
> + * Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + * NVIDIA Tegra241 CMDQ-Virtualiisation extension for SMMUv3
> + *
> + * Written by Nicolin Chen, Shameer Kolothum
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_ARM_TEGRA241_CMDQV_H
> +#define HW_ARM_TEGRA241_CMDQV_H
> +
> +const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
> +
> +#endif /* HW_ARM_TEGRA241_CMDQV_H */
> diff --git a/hw/arm/tegra241-cmdqv-stubs.c b/hw/arm/tegra241-cmdqv-stubs.c
> new file mode 100644
> index 0000000000..eedc7bfdcd
> --- /dev/null
> +++ b/hw/arm/tegra241-cmdqv-stubs.c
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + *
> + * Stubs for Tegra241 CMDQ-Virtualiisation extension for SMMUv3
^typo
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/arm/smmuv3.h"
> +#include "smmuv3-accel.h"
> +#include "hw/arm/tegra241-cmdqv.h"
> +
> +const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void)
> +{
> +    return NULL;
> +}
> +
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> new file mode 100644
> index 0000000000..ad5a0d4611
> --- /dev/null
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -0,0 +1,56 @@
> +/*
> + * Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + * NVIDIA Tegra241 CMDQ-Virtualization extension for SMMUv3
> + *
> + * Written by Nicolin Chen, Shameer Kolothum
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/arm/smmuv3.h"
> +#include "smmuv3-accel.h"
> +#include "tegra241-cmdqv.h"
> +
> +static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
> +{
> +}
> +
> +static bool
> +tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                            uint32_t *out_viommu_id, Error **errp)
> +{
> +    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> +    return false;
> +}
> +
> +static void tegra241_cmdqv_reset(SMMUv3State *s)
> +{
> +}
> +
> +static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
> +{
> +    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> +    return false;
> +}
> +
> +static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                                 Error **errp)
> +{
> +    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> +    return false;
> +}
> +
> +static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
> +    .probe = tegra241_cmdqv_probe,
> +    .init = tegra241_cmdqv_init,
> +    .alloc_viommu = tegra241_cmdqv_alloc_viommu,
> +    .free_viommu = tegra241_cmdqv_free_viommu,
> +    .reset = tegra241_cmdqv_reset,

I think I would create a no_cmdqv_ops to convert the existing code
without any cmdqv support to the same api. This would avoid
the repeating: 

if (cmdqv_ops && cmdqv_ops-><func>) check in subsequent patches.

Also this looks a bit strange to have different signatures for the
functions used with both vcmdq on and off

Eric


> +};
> +
> +const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void)
> +{
> +    return &tegra241_cmdqv_ops;
> +}
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index c66c452737..3305c6e76e 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -626,6 +626,10 @@ config FSL_IMX8MP_EVK
>      depends on TCG
>      select FSL_IMX8MP
>  
> +config TEGRA241_CMDQV
> +    bool
> +    depends on ARM_SMMUV3_ACCEL
> +
>  config ARM_SMMUV3_ACCEL
>      bool
>      depends on ARM_SMMUV3
> @@ -633,6 +637,7 @@ config ARM_SMMUV3_ACCEL
>  config ARM_SMMUV3
>      bool
>      select ARM_SMMUV3_ACCEL if IOMMUFD
> +    imply TEGRA241_CMDQV
>  
>  config FSL_IMX6UL
>      bool
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 8f834c32b1..fc83b635e7 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -88,6 +88,8 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
>  arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>  arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
>  stub_ss.add(files('smmuv3-accel-stubs.c'))
> +arm_common_ss.add(when: 'CONFIG_TEGRA241_CMDQV', if_true: files('tegra241-cmdqv.c'))
> +stub_ss.add(files('tegra241-cmdqv-stubs.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>  arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
>  arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(


