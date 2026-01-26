Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863F6D13C0E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 13:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkMgS-0003RA-H7; Mon, 26 Jan 2026 08:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkMgI-0003Ic-NQ
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 08:31:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkMgG-000780-VB
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 08:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769434252;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPSILxB8EDVeg8k9wLi2qmhygNFjmwwdRYkJImNt7F0=;
 b=A/rrpdUbmiyrzHFcilVm6hm9rMrDVDYj/dI5588Oj1KLzC2NdijlnI0i7AfX+ke+TaXkTP
 qQ4bHHxv381j+7+4jcbkP7l068JKoDFFyq7reReuPwVlmXBb8AJRwR4EKZfJDX4k+9sIDJ
 1H38shgg5lWX3hzRPZd2OKrOcvG1fkE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-EvdvmdxFMO-FjDNwa8V0Ew-1; Mon, 26 Jan 2026 08:30:51 -0500
X-MC-Unique: EvdvmdxFMO-FjDNwa8V0Ew-1
X-Mimecast-MFC-AGG-ID: EvdvmdxFMO-FjDNwa8V0Ew_1769434250
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso58522455e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 05:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769434250; x=1770039050;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPSILxB8EDVeg8k9wLi2qmhygNFjmwwdRYkJImNt7F0=;
 b=rACmMj54UPkx7nW/ZxI7Lm4oiIuAYjyDfYD25UxcJVXlY1RfWbPuj+lv4UqWP2fg1G
 y+enX38US9mMw7yRoJeJGC2/Z5vEkTTczWcpfT0v9DdPFaazgXqWRSC2NQaT0VCugoXK
 9iEKOw6X3+Din+Tj6RzzhB43wc1Wt7MN13VSSFYtB+G6SnOe5hZt5+MGos65pG7aQh1y
 uLVJH9Gk0t/VvRZbqOQ1vU+w6oxAMh3deErSJGmrfnNCD4DElqZzHbaJFqit9djny0R1
 pB6xCClI2FuwkCRl6/yl2RZXJRh9yDrYiFD2fqHIefnSMoRf0rnnWAUTD98xRoSCT6lb
 y/Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjjijcV9vne4RAaduvR2HQ53B7htFZ2CeASpog2jCrsqJVOXJOZqezIlpQOyEr9mMgsOMGGGqjRa5m@nongnu.org
X-Gm-Message-State: AOJu0YwWuy4FPuH3Haexe/jr6ykGli0Vgy3/AO71MciY4qveriZgMLqf
 snSpGLYSY9gJRjI8rup4CKNsLSZ1Z19kigz7+6zijI4xo5mgXNz1Mo36PQR9vAXAo2Qr5QHvpHs
 nqCfEyzeSNPblD8p2ctpNT+LKUW277iVXem2SNIzSxApopWLvld5v21ut
X-Gm-Gg: AZuq6aInV/N6+VhZ7QXshFk5T3ffa0tR6ut+PIjTCHra21rLQ3LBNcxUcnqWAA+3n+R
 SgDjSGVyD3ALriG8wZ8OrMcNVUMZVtTT1e1uVfQt7QgVH5tvgLDMSblVKj69xAlV+T8WKMzffy0
 wlI1VdO2zNHRX1ZQwCgmn15AKz/L4EcEkoMAZIQbSua2zHX1aR4MT2M9mIh+DaRYSxhGxTPG22h
 JGYudM4qEYW1WjopdkUk1UqWWCpWqitMUdBpjxSn6+v8c/UvblY1+3srahYnHG2FjwmUWdZAWai
 1w4pC99+UYkKCYhePMIlgJ67MBVBh8/hiuM/e1elCc9ZWtOs4Soov9v36Cbhc2aExFyrRkYELt5
 YuDZ9YnTYlWc4vpxJ08Jo3y6GX8mGu8nOeuy3ZFDk+bp7i5r1hWKy1/D9SQ==
X-Received: by 2002:a05:600c:6812:b0:480:3ad0:6509 with SMTP id
 5b1f17b1804b1-4805ce4e63cmr71376465e9.12.1769434250028; 
 Mon, 26 Jan 2026 05:30:50 -0800 (PST)
X-Received: by 2002:a05:600c:6812:b0:480:3ad0:6509 with SMTP id
 5b1f17b1804b1-4805ce4e63cmr71375985e9.12.1769434249528; 
 Mon, 26 Jan 2026 05:30:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8bebfasm324314245e9.14.2026.01.26.05.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 05:30:48 -0800 (PST)
Message-ID: <db0b8cc2-dc68-4945-90c1-485df24760bd@redhat.com>
Date: Mon, 26 Jan 2026 14:30:47 +0100
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
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Shameer,

On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Introduce initial support for NVIDIA Tegra241 CMDQ-Virtualisation (CMDQV),
> an extension to SMMUv3 providing virtualizable hardware command queues.
> This adds the basic MMIO handling, and integration hooks in the SMMUv3
> accelerated path. When enabled, the SMMUv3 backend allocates a Tegra241
> specific vIOMMU object via IOMMUFD and exposes a CMDQV MMIO region and
> IRQ to the guest.
>
> The "tegra241-cmdqv" property isn't user visible yet and it will be
> introduced in a later patch once all the supporting pieces are ready.
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
> +
> +typedef struct Tegra241CMDQV {
> +    struct iommu_viommu_tegra241_cmdqv cmdqv_data;
> +    SMMUv3State *smmu;
> +    MemoryRegion mmio_cmdqv;
please use a _mr suffix. It eases the review of subsequent patches

Eric
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


