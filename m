Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E19D13C1E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 14:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkNU6-0006Su-6F; Mon, 26 Jan 2026 09:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkNU4-0006SQ-NF
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 09:22:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkNU2-0001tX-Qg
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 09:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769437346;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIkIkND7nXtmP985ZLRpf8Pb0vr4Yzt3Rx5LaEJ+hXM=;
 b=YMMOlT21ZjSiZ5vtPQhxNReh+Ntw8fDmolTPRfN9+fH05bW4Yc04OGCbD1tFFs6b3+mqCD
 A8bRBSBsydaC7ReUv/spplvUSr0UlNQk0vpSGoTSCe7MubmVlAdKBXSFwnWw657pq85eJu
 fT1Ga3Im2/hUdRTSg/ffCBKW/An3L3o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-G0vQn6R3O0y5puQf3RLisQ-1; Mon, 26 Jan 2026 09:22:24 -0500
X-MC-Unique: G0vQn6R3O0y5puQf3RLisQ-1
X-Mimecast-MFC-AGG-ID: G0vQn6R3O0y5puQf3RLisQ_1769437343
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4804c01a95fso35747705e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 06:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769437343; x=1770042143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIkIkND7nXtmP985ZLRpf8Pb0vr4Yzt3Rx5LaEJ+hXM=;
 b=Zt6px2C0L8nRiS/ouzddtjEchT6t9cRsOgEb+pXttq0lmO+YrzkdYMKOEjL5HfGYIk
 lwQzEstwaAOX4ZcZzpB2LaGItAHhv1iCmxOLNPZ7qr2PXVOLIeW5j4BP7sGH5TuZ1XMW
 neVglouaicrL4fm9QPEx6ScBQT7x++0k9nmAOhaoH2x2Op+WdHB2gVSB34GJOCiZSKLw
 pvm/4Jojhad0ESSRcvtp1h89avOYXfX9+XyLpjlH1q/CbMJ1Hpd+7BBZ8aDAEGtsmYIl
 C9lPAe+PQDzp6ikzGTOrM8zlnKbUyLR8qXjWFlc9O/ADF14qdb93nmZ3ETe7ayVXOd1H
 QUcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULXqwN8FfkZB+OHXW75wCqpzsrps2XgbfPP8UVAsvYRKO2YKf/VTU2XEaiXOwgzRsLl9qekr8fnrva@nongnu.org
X-Gm-Message-State: AOJu0Yw0G2NcLD+eRUyTEi/xtkAJDD1GiuZicb7Y301dnhg7r/Q4s3eo
 RjpL2Ws679MevQ1PUxLVAKgKjb3OHryU9R+les778Yk0B3ab3Kl0k4RlIdI/JLKuStxRbbz3glL
 uJ/MJw4vdn5f6stojB0B2KQXd3IlmpQszc0Lupi1penOjS1HNShyZiU47
X-Gm-Gg: AZuq6aKFUq0p3u+yzPUw+ZzxARCEihY5weqyuYERQNkxfpgp1k1TV5Cx5kxd70Uzdcq
 ywPQkk1msOWi8dNxp0NsyR5bqbcEb0Nfbks85izrW0R9gprSPK1KA8kHDlSC9w7rrlTc6QcyLaE
 rVDUshtNckRJTadmCPJceU5uxeHGuns8tgRewYLnOqc44yVvxdWXd2Xx5Q4Exk87zRYpkXjgpN0
 ueTvYePZ6T+T+KeFb4KbILusumdUDcPIGft59CWhKoei1nuA4zYXeT9BGqTOLxQti/uVStuD3AU
 vn4nrOpV9rkmyUn1J1cFMsMnu4wc3T9zCKyatzipc1qErwxohwKZ/HLVVgD+1awS8BV8tfCOs5N
 ZjgUo62S+ZRVJEMB01rIPJ22YX4yWVBF/meodWJWyIcDOHeJJO1u8CL1VwA==
X-Received: by 2002:a05:600c:1f8f:b0:477:5ad9:6df1 with SMTP id
 5b1f17b1804b1-4805ce4050fmr74702995e9.3.1769437342693; 
 Mon, 26 Jan 2026 06:22:22 -0800 (PST)
X-Received: by 2002:a05:600c:1f8f:b0:477:5ad9:6df1 with SMTP id
 5b1f17b1804b1-4805ce4050fmr74702635e9.3.1769437342175; 
 Mon, 26 Jan 2026 06:22:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cc278sm331798395e9.12.2026.01.26.06.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 06:22:21 -0800 (PST)
Message-ID: <a35b8f4f-9ebb-48aa-8331-dfaf82d04400@redhat.com>
Date: Mon, 26 Jan 2026 15:22:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/16] hw/arm/tegra241-cmdqv: Add initial Tegra241
 CMDQ-Virtualisation support
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-6-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251210133737.78257-6-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Introduce initial support for NVIDIA Tegra241 CMDQ-Virtualisation (CMDQV),
well this is rather a skeleton and at this stage it does not introduce
any support
> an extension to SMMUv3 providing virtualizable hardware command queues.
> This adds the basic MMIO handling, and integration hooks in the SMMUv3
> accelerated path. When enabled, the SMMUv3 backend allocates a Tegra241
> specific vIOMMU object via IOMMUFD and exposes a CMDQV MMIO region and
> IRQ to the guest.
I would elaborate on the nature of region and interrupt here.
>
> The "tegra241-cmdqv" property isn't user visible yet and it will be
> introduced in a later patch once all the supporting pieces are ready.

I would suggest "tegra241_cmdqv will be set by an SMMU property that does not exist yet. As such it is currently unset."

>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/Kconfig          |  5 ++++
>  hw/arm/meson.build      |  1 +
>  hw/arm/smmuv3-accel.c   | 10 +++++--
>  hw/arm/smmuv3.c         |  4 +++
>  hw/arm/tegra241-cmdqv.c | 65 +++++++++++++++++++++++++++++++++++++++++
>  hw/arm/tegra241-cmdqv.h | 40 +++++++++++++++++++++++++
>  include/hw/arm/smmuv3.h |  3 ++
>  7 files changed, 126 insertions(+), 2 deletions(-)
>  create mode 100644 hw/arm/tegra241-cmdqv.c
>  create mode 100644 hw/arm/tegra241-cmdqv.h
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 702b79a02b..42b6b95285 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -37,6 +37,7 @@ config ARM_VIRT
>      select VIRTIO_MEM_SUPPORTED
>      select ACPI_CXL
>      select ACPI_HMAT
> +    select TEGRA241_CMDQV
>  
>  config CUBIEBOARD
>      bool
> @@ -634,6 +635,10 @@ config ARM_SMMUV3_ACCEL
>      bool
>      depends on ARM_SMMUV3 && IOMMUFD
>  
> +config TEGRA241_CMDQV
> +    bool
> +    depends on ARM_SMMUV3_ACCEL
> +
>  config FSL_IMX6UL
>      bool
>      default y
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index c250487e64..4ec91db50a 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -86,6 +86,7 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
>  arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>  arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
> +arm_ss.add(when: 'CONFIG_TEGRA241_CMDQV', if_true: files('tegra241-cmdqv.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>  arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
>  arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 939898c9b0..e50c4b3bb7 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -18,6 +18,7 @@
>  
>  #include "smmuv3-internal.h"
>  #include "smmuv3-accel.h"
> +#include "tegra241-cmdqv.h"
>  
>  /*
>   * The root region aliases the global system memory, and shared_as_sysmem
> @@ -499,10 +500,15 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>          .ste = { SMMU_STE_VALID, 0x0ULL },
>      };
>      uint32_t s2_hwpt_id = idev->hwpt_id;
> -    uint32_t viommu_id, hwpt_id;
> +    uint32_t viommu_id = 0, hwpt_id;
>      SMMUv3AccelState *accel;
>  
> -    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> +    if (s->tegra241_cmdqv && !tegra241_cmdqv_alloc_viommu(s, idev, &viommu_id,
> +                                                          errp)) {
> +        return false;
> +    }
> +
> +    if (!viommu_id && !iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
>                                        IOMMU_VIOMMU_TYPE_ARM_SMMUV3, s2_hwpt_id,
>                                        NULL, 0, &viommu_id, errp)) {
>          return false;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 9b7b85fb49..02e1a925a4 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -36,6 +36,7 @@
>  #include "smmuv3-accel.h"
>  #include "smmuv3-internal.h"
>  #include "smmu-internal.h"
> +#include "tegra241-cmdqv.h"
>  
>  #define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
>                                          (cfg)->record_faults) || \
> @@ -2017,6 +2018,9 @@ static void smmu_realize(DeviceState *d, Error **errp)
>  
>      smmu_init_irq(s, dev);
>      smmuv3_init_id_regs(s);
> +    if (s->tegra241_cmdqv) {
> +        tegra241_cmdqv_init(s);
> +    }
>  }
>  
>  static const VMStateDescription vmstate_smmuv3_queue = {
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> new file mode 100644
> index 0000000000..899325877e
> --- /dev/null
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -0,0 +1,65 @@
> +/*
> + * Copyright (C) 2025, NVIDIA CORPORATION
nit: s/2025/2026
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
> +static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
> +                                 unsigned size)
> +{
> +}
> +
> +static const MemoryRegionOps mmio_cmdqv_ops = {
> +    .read = tegra241_cmdqv_read,
> +    .write = tegra241_cmdqv_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                                 uint32_t *out_viommu_id, Error **errp)
> +{
> +    Tegra241CMDQV *cmdqv = s->cmdqv;
> +
> +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> +                                      IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> +                                      idev->hwpt_id, &cmdqv->cmdqv_data,
> +                                      sizeof(cmdqv->cmdqv_data), out_viommu_id,
> +                                      errp)) {
> +        error_append_hint(errp, "NVIDIA Tegra241 CMDQV is unsupported");
are we sure this is the case here and not a radom failure of other source?
> +        s->tegra241_cmdqv = false;
> +        return false;
> +    }
> +    return true;
> +}
> +
> +void tegra241_cmdqv_init(SMMUv3State *s)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(OBJECT(s));
> +    Tegra241CMDQV *cmdqv;
> +
> +    if (!s->tegra241_cmdqv) {
> +        return;
> +    }
> +
> +    cmdqv = g_new0(Tegra241CMDQV, 1);
> +    memory_region_init_io(&cmdqv->mmio_cmdqv, OBJECT(s), &mmio_cmdqv_ops, cmdqv,
> +                          "tegra241-cmdqv", TEGRA241_CMDQV_IO_LEN);
> +    sysbus_init_mmio(sbd, &cmdqv->mmio_cmdqv);
> +    sysbus_init_irq(sbd, &cmdqv->irq);
> +    cmdqv->smmu = s;
> +    s->cmdqv = cmdqv;
> +}
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> new file mode 100644
> index 0000000000..9bc72b24d9
> --- /dev/null
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (C) 2025, NVIDIA CORPORATION
> + * NVIDIA Tegra241 CMDQ-Virtualiisation extension for SMMUv3
virtualization
> + *
> + * Written by Nicolin Chen, Shameer Kolothum
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_TEGRA241_CMDQV_H
> +#define HW_TEGRA241_CMDQV_H
> +
> +#include CONFIG_DEVICES
> +
> +#define TEGRA241_CMDQV_IO_LEN 0x50000
can you explain the size
> +
> +typedef struct Tegra241CMDQV {
> +    struct iommu_viommu_tegra241_cmdqv cmdqv_data;
> +    SMMUv3State *smmu;
> +    MemoryRegion mmio_cmdqv;
> +    qemu_irq irq;
> +} Tegra241CMDQV;
> +
> +#ifdef CONFIG_TEGRA241_CMDQV
> +bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                                 uint32_t *out_viommu_id, Error **errp);
> +void tegra241_cmdqv_init(SMMUv3State *s);
> +#else
> +static inline void tegra241_cmdqv_init(SMMUv3State *s)
> +{
> +}
> +static inline bool
> +tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                            uint32_t *out_viommu_id, Error **errp)
> +{
> +    return true;
> +}
> +#endif
> +
> +#endif /* HW_TEGRA241_CMDQV_H */
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 2d4970fe19..8e56e480a0 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -73,6 +73,9 @@ struct SMMUv3State {
>      bool ats;
>      uint8_t oas;
>      bool pasid;
> +    /* Support for NVIDIA Tegra241 SMMU CMDQV extension */
> +    struct Tegra241CMDQV *cmdqv;
> +    bool tegra241_cmdqv;
>  };
>  
>  typedef enum {


