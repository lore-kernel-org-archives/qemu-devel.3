Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B91C47BDF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 10:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd4DM-00026z-8e; Tue, 06 Jan 2026 05:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vd4DK-00020d-Me
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 05:22:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vd4DH-0000kr-N1
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 05:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767694973;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=llg43gDynVGCw++CHowB2UFCSpaRan5HDgehlUilQ8U=;
 b=WjJN3MEe6HUn/GaPBZGcIEXRKX777hSq7k+mB770Y7Vw8I49oOlm/YD08aSyGCSm4IsuhU
 8tOs/Mbu0eCdiUGLKH9MunHTgl7yUQeE2gI5Gw9XujNw+A3VbcjjhdESieiF48HNRmlHPi
 o/o9CawNeoRtP9CzvxIVE0v2RTT8ygM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-k728xBZjMZCUy_2exhcbGg-1; Tue, 06 Jan 2026 05:22:52 -0500
X-MC-Unique: k728xBZjMZCUy_2exhcbGg-1
X-Mimecast-MFC-AGG-ID: k728xBZjMZCUy_2exhcbGg_1767694971
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d1622509eso4946875e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 02:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767694971; x=1768299771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llg43gDynVGCw++CHowB2UFCSpaRan5HDgehlUilQ8U=;
 b=HJSuUOMEuhgU0sWbPZwtuh04Q42W7mp8gaRLee2G8wiaiitTKQk0HtREDuzEyn75Jw
 10MFUcFPWBzyoI7J32gKIzcB+Y0MV0VyUJ2lZusmezSgh9oQMUPSsPptlFrjiod53hoo
 /zHD/BNmn+32uTvrhneUmbi1x0jvtojqwTY+anI6MGOYqR+NJZtTsXWTqSPOAlBCVXht
 Scgqz66MkrmOdfSj/3BqY+V+tmKxLAK60tEmpK0o8IRe0k1OerKCeCjx7RlfDWt/Oyt3
 q4bgG/vSob/Kw7LvodU47j+3dCfvt9vdR+w7mCME3w931F4FDjUxj3/PMuuMXDL1rAUT
 0uGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXihWoEoAhpwUgHnrByNUMrPeDJlxANpkqPXReS2S22ueAlSeozBE+pIBxcbhPI9XgObaH1FW2IEqrm@nongnu.org
X-Gm-Message-State: AOJu0Yy1/e6gtw7TxNUR4d5ku/2iErqybASLr9bWitX8jh+Dd2XpUf6f
 q7YjZ1eSXXKMBCw4Zi2fP5M35Uk9aezx4rZ3xCw1tNPyXui+mUctqTateFZDtzIYdTFr0n2piLO
 po9ZdiCg5CIZ3FNh4ScTA8uiRp4Ex6p7zhH+KsKLqKZET/+xLlllt6rWH
X-Gm-Gg: AY/fxX7U2Y8H6lQwNlDDjvmK4swi5J+cmGSZNTByoN25jB1zAgmVExlSXDhNxzvlKSu
 E7jrP7uRAlO8aComkNp7La3ac6D4K4n7avGPpp842VfAE+Ku7Q8PdPXoZ1fX4o0B6Nv4RRwjSBf
 nNNOZfJ2/zH2YJxKLcE3vHgfezByMYdHya42zqPfOqzKM5tn6PKkGdq5tg1ee4Z4zY7H2L0Fl9Q
 q3VeB/xM3cK0A3zeo3kZpT8u/tLnfSHUNC0i8jCkeuH+KP8O4Fu6HIZXHTdMwNuWI0cLEFbqtKI
 Vdn09HejxmV0MbauE6NLFF6OiNvjtF56LrE2NDL4jc2DV/oaxGX9iQ5sQBhN1B7hOnGt68saPPr
 DKGYiETbXivGlWr4RmeWYvTJAxIcJZkUFtcYwyD3hhJ7znIlU7ph4dBvDfA==
X-Received: by 2002:a05:600c:154e:b0:47b:df60:8a14 with SMTP id
 5b1f17b1804b1-47d7f07064amr26724135e9.9.1767694970864; 
 Tue, 06 Jan 2026 02:22:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVwAY5cBoM5rzt4u4+HMxvSpiNl5QALB9/P0mStGAWzwW3fFA0iOsLT/WkULv05GozvgDqVQ==
X-Received: by 2002:a05:600c:154e:b0:47b:df60:8a14 with SMTP id
 5b1f17b1804b1-47d7f07064amr26723815e9.9.1767694970389; 
 Tue, 06 Jan 2026 02:22:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm3681643f8f.8.2026.01.06.02.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 02:22:49 -0800 (PST)
Message-ID: <1b7a3d29-8660-47ca-b98d-b59103baf600@redhat.com>
Date: Tue, 6 Jan 2026 11:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/33] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-6-skolothumtho@nvidia.com>
 <6a062129-2b8f-420a-a4b9-87dde7574481@redhat.com>
 <CH3PR12MB7548E01E6CC271356D4D4208ABAEA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <5b17d7e8-e4d0-4087-b104-c50a418ff24c@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <5b17d7e8-e4d0-4087-b104-c50a418ff24c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cédric, Shameer,

On 12/17/25 6:38 PM, Cédric Le Goater wrote:
> Hello Shameer,
>
> On 12/12/25 06:48, Shameer Kolothum wrote:
>> Hi Cédric,
>>
>>> -----Original Message-----
>>> From: Cédric Le Goater <clg@redhat.com>
>>> Sent: 11 December 2025 12:55
>>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>>> arm@nongnu.org; qemu-devel@nongnu.org
>>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
>>> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
>>> ddutile@redhat.com; berrange@redhat.com; Nathan Chen
>>> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>>> smostafa@google.com; wangzhou1@hisilicon.com;
>>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>>> Krishnakant Jaju <kjaju@nvidia.com>
>>> Subject: Re: [PATCH v6 05/33] hw/arm/smmuv3-accel: Introduce smmuv3
>>> accel device
>>>
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 11/20/25 14:21, Shameer Kolothum wrote:
>>>> Set up dedicated PCIIOMMUOps for the accel SMMUv3, since it will need
>>>> different callback handling in upcoming patches. This also adds a
>>>> CONFIG_ARM_SMMUV3_ACCEL build option so the feature can be disabled
>>>> at compile time. Because we now include CONFIG_DEVICES in the
>>>> header to
>>>> check for ARM_SMMUV3_ACCEL, the meson file entry for smmuv3.c needs
>>> to
>>>> be changed to arm_ss.add.
>>>>
>>>> The “accel” property isn’t user visible yet and it will be
>>>> introduced in
>>>> a later patch once all the supporting pieces are ready.
>>>>
>>>> Signed-off-by: Shameer Kolothum
>>> <shameerali.kolothum.thodi@huawei.com>
>>>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>>> ---
>>>>    hw/arm/Kconfig          |  5 ++++
>>>>    hw/arm/meson.build      |  3 ++-
>>>>    hw/arm/smmuv3-accel.c   | 59
>>> +++++++++++++++++++++++++++++++++++++++++
>>>>    hw/arm/smmuv3-accel.h   | 27 +++++++++++++++++++
>>>>    hw/arm/smmuv3.c         |  5 ++++
>>>>    include/hw/arm/smmuv3.h |  3 +++
>>>>    6 files changed, 101 insertions(+), 1 deletion(-)
>>>>    create mode 100644 hw/arm/smmuv3-accel.c
>>>>    create mode 100644 hw/arm/smmuv3-accel.h
>>>>
>>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>>>> index 0cdeb60f1f..702b79a02b 100644
>>>> --- a/hw/arm/Kconfig
>>>> +++ b/hw/arm/Kconfig
>>>> @@ -12,6 +12,7 @@ config ARM_VIRT
>>>>        select ARM_GIC
>>>>        select ACPI
>>>>        select ARM_SMMUV3
>>>> +    select ARM_SMMUV3_ACCEL
>>>>        select GPIO_KEY
>>>>        select DEVICE_TREE
>>>>        select FW_CFG_DMA
>>>> @@ -629,6 +630,10 @@ config FSL_IMX8MP_EVK
>>>>    config ARM_SMMUV3
>>>>        bool
>>>>
>>>> +config ARM_SMMUV3_ACCEL
>>>> +    bool
>>>> +    depends on ARM_SMMUV3 && IOMMUFD
>>>> +
>>>>    config FSL_IMX6UL
>>>>        bool
>>>>        default y
>>>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>>>> index aeaf654790..c250487e64 100644
>>>> --- a/hw/arm/meson.build
>>>> +++ b/hw/arm/meson.build
>>>> @@ -84,7 +84,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE',
>>> if_true: files('armsse.c'))
>>>>    arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true:
>>>> files('fsl-imx7.c',
>>> 'mcimx7d-sabre.c'))
>>>>    arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-
>>> imx8mp.c'))
>>>>    arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true:
>>> files('imx8mp-evk.c'))
>>>> -arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true:
>>> files('smmuv3.c'))
>>>> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>>>> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true:
>>> files('smmuv3-accel.c'))
>>>>    arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-
>>> imx6ul.c', 'mcimx6ul-evk.c'))
>>>>    arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true:
>>> files('nrf51_soc.c'))
>>>>    arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
>>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>>> new file mode 100644
>>>> index 0000000000..99ef0db8c4
>>>> --- /dev/null
>>>> +++ b/hw/arm/smmuv3-accel.c
>>>> @@ -0,0 +1,59 @@
>>>> +/*
>>>> + * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
>>>> + * Copyright (C) 2025 NVIDIA
>>>> + * Written by Nicolin Chen, Shameer Kolothum
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +
>>>> +#include "hw/arm/smmuv3.h"
>>>> +#include "smmuv3-accel.h"
>>>> +
>>>> +static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs,
>>> SMMUPciBus *sbus,
>>>> +                                               PCIBus *bus, int
>>>> devfn)
>>>> +{
>>>> +    SMMUDevice *sdev = sbus->pbdev[devfn];
>>>> +    SMMUv3AccelDevice *accel_dev;
>>>> +
>>>> +    if (sdev) {
>>>> +        return container_of(sdev, SMMUv3AccelDevice, sdev);
>>>> +    }
>>>> +
>>>> +    accel_dev = g_new0(SMMUv3AccelDevice, 1);
>>>
>>> oh. This is not a QOM object :/
>>
>> Right.
>>
>>>
>>>> +    sdev = &accel_dev->sdev;
>>>> +
>>>> +    sbus->pbdev[devfn] = sdev;
>>>> +    smmu_init_sdev(bs, sdev, bus, devfn);
>>>> +    return accel_dev;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Find or add an address space for the given PCI device.
>>>> + *
>>>> + * If a device matching @bus and @devfn already exists, return its
>>>> + * corresponding address space. Otherwise, create a new device entry
>>>> + * and initialize address space for it.
>>>> + */
>>>> +static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void
>>> *opaque,
>>>> +                                              int devfn)
>>>> +{
>>>> +    SMMUState *bs = opaque;
>>>> +    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
>>>> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus,
>>> bus, devfn);
>>>> +    SMMUDevice *sdev = &accel_dev->sdev;
>>>> +
>>>> +    return &sdev->as;
>>>> +}
>>>> +
>>>> +static const PCIIOMMUOps smmuv3_accel_ops = {
>>>> +    .get_address_space = smmuv3_accel_find_add_as,
>>>> +};
>>>> +
>>>> +void smmuv3_accel_init(SMMUv3State *s)
>>>> +{
>>>> +    SMMUState *bs = ARM_SMMU(s);
>>>> +
>>>> +    bs->iommu_ops = &smmuv3_accel_ops;
>>>
>>> again, I think this should be a sSMMUv3Class attribute.
>>
>> See below.
>>>
>>>> +}
>>>> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
>>>> new file mode 100644
>>>> index 0000000000..0dc6b00d35
>>>> --- /dev/null
>>>> +++ b/hw/arm/smmuv3-accel.h
>>>> @@ -0,0 +1,27 @@
>>>> +/*
>>>> + * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
>>>> + * Copyright (C) 2025 NVIDIA
>>>> + * Written by Nicolin Chen, Shameer Kolothum
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +#ifndef HW_ARM_SMMUV3_ACCEL_H
>>>> +#define HW_ARM_SMMUV3_ACCEL_H
>>>> +
>>>> +#include "hw/arm/smmu-common.h"
>>>> +#include CONFIG_DEVICES
>>>> +
>>>> +typedef struct SMMUv3AccelDevice {
>>>> +    SMMUDevice sdev;
>>>> +} SMMUv3AccelDevice;
>>>> +
>>>> +#ifdef CONFIG_ARM_SMMUV3_ACCEL
>>>> +void smmuv3_accel_init(SMMUv3State *s);
>>>> +#else
>>>> +static inline void smmuv3_accel_init(SMMUv3State *s)
>>>> +{
>>>> +}
>>>> +#endif
>>>> +
>>>> +#endif /* HW_ARM_SMMUV3_ACCEL_H */
>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>> index bcf8af8dc7..ef991cb7d8 100644
>>>> --- a/hw/arm/smmuv3.c
>>>> +++ b/hw/arm/smmuv3.c
>>>> @@ -32,6 +32,7 @@
>>>>    #include "qapi/error.h"
>>>>
>>>>    #include "hw/arm/smmuv3.h"
>>>> +#include "smmuv3-accel.h"
>>>>    #include "smmuv3-internal.h"
>>>>    #include "smmu-internal.h"
>>>>
>>>> @@ -1882,6 +1883,10 @@ static void smmu_realize(DeviceState *d, Error
>>> **errp)
>>>>        SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>>>        Error *local_err = NULL;
>>>>
>>>> +    if (s->accel) {
>>>> +        smmuv3_accel_init(s);
>>>> +    }
>>>> +
>>>>        c->parent_realize(d, &local_err);
>>>>        if (local_err) {
>>>>            error_propagate(errp, local_err);
>>>> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
>>>> index d183a62766..bb7076286b 100644
>>>> --- a/include/hw/arm/smmuv3.h
>>>> +++ b/include/hw/arm/smmuv3.h
>>>> @@ -63,6 +63,9 @@ struct SMMUv3State {
>>>>        qemu_irq     irq[4];
>>>>        QemuMutex mutex;
>>>>        char *stage;
>>>> +
>>>> +    /* SMMU has HW accelerator support for nested S1 + s2 */
>>>> +    bool accel;
>>>
>>> Have you considered modeling with a QOM object instead ?
>>
>> A bit of history on this:
>>
>> The SMMUv3 accel support was introduced first as a separate device,
>> -device arm-smmuv3-accel
>>
>> https://lore.kernel.org/qemu-devel/20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com/
>>
>>
>> However, the general consensus at that time was that we should instead
>> model it on the -device arm-smmuv3 itself, with an added "accel"
>> property.
>>
>> Eric had also suggested making use of something similar to the
>> TYPE_VFIO_IOMMU_IOMMUFD / LEGACY classes for selecting the iommu_ops.
>> https://lore.kernel.org/qemu-devel/1105d100-dd1e-4aca-b518-50f903967416@redhat.com/
>>
>>
>> In RFCv3, I did introduce a TYPE_ARM_SMMUV3_ACCEL object class, but we
>> later found that it wasn’t doing much beyond helping to retrieve the
>> iommu_ops
>> based on the object type, so decided to drop it.
>> https://lore.kernel.org/qemu-devel/71ca9132-8deb-4f57-abb0-2bcc0fe93ae9@redhat.com/
>>
>>
>>  From your feedback, I understand that you would like to revisit that
>> approach
>> again. Just to make sure I get this right, is the SMMUv3AccelClass
>> you have in
>> mind meant to be an abstract object, like HOST_IOMMU_DEVICE, or are
>> you suggesting another child device object?
>
> HOST_IOMMU_DEVICE are for host IOMMU backends (VFIO IOMMU Type1
> legacy and IOMMUFD). I was imagining an "arm-smmuv3" children class
> for acceleration. 
We were trying to find similar examples of inheritance in the qemu tree.
I also inspected hw/intc, for instance the GICv3 but it is not really
similar as the choice between the kvm and tcg one is not made by an option.

As Shameer explained, we attempted to use a class and eventually we
noticed it did not bring any real benefit besides complexifying the code.

Note that on intel_iommu, the "vfio" integration is opted-in with the
caching-mode option. so using an accel option sounds a similar knob.


>
> I understand I am jumping a bit late in the discussion. Sorry about
> that and the late reply also.
>
> I have been experimenting with your series on other systems and on
> an ARM system with MLX5 VFs and an L4 GPU. I had to fake CANWBS
> support in the host kernel to make progress. On a side note, I also 
I also encountered this issue but as my HW does support CANWBS, this is
a FW issue. So this does not relate to that series.
> pulled in a patch from Nicolin to add dmabuf support and it seemed
> to behave ok. This would require more in-depth P2P testing. That's
> another topic we should discuss in the QEMU 11.0 cycle. 
I tested the functionality with P2P. I am waiting for the respin before
sending my T-b.
>
>
>> Please let me know if there is an example/precedent, I can look at
>> for a similar
>> object model in QEMU.
>
> Now regarding modeling, it is more or less a design choice. But while
> I scanned through the code, I felt there was some problems that could
> be solved in a cleaner way with a sub class. The changes are mostly
> about moving code in different places and changing/removing the
> "if (s->accel) parts". Don't change everything now, I will check RFCv3.
>
> Nevertheless, they are several more issues, build breakages and also
> runtime breakage that should be addressed. Let's do that first. 

I don't know where we stand with that respect. Shameer, were you able to
address those breakages?
>
> Furthermore, an (idealistic) design principle of QEMU that we tend to
> forget is to offer acceleration when possible and else fallback to
> emulation, in order to guarantee parity of features between different
> hardware. I expected the "arm-smmuv3" device to decide to operate in
> accelerated mode when ever possible, i.e when the IOMMUFD backend
> (the SMMUV3 + the FW) offers the right level of functionality. This
> would allow the machine to maintain a constant view of the sMMUv3
> device and facilitate its integration with management layers and
> ease migration too. 

I don't think it makes sense to fall back to a non accel mode anyway
because the protected end point device wouldn't work. SMMU has no
cachine mode as Intel. So either it works in accelerated mode along with
VFIO devices or it is not able to protected host assigned devices.

Thanks

Eric
>
> I understand this is complex, it has been done for some interrupt
> controllers, and this is not the approach of the series.
>
> That said, what about integration with libvirt ?
>
>
> Thanks,
>
> C.
>


