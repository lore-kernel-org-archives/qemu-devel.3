Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C9DC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 15:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsO8O-0002Xu-Oh; Wed, 12 Mar 2025 11:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsO8L-0002SX-AH
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsO8J-0002xp-2H
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741793792;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nrl5hdPrHKRG86mu1gtfivNP4aYY6RWf6n/HBWLbb/E=;
 b=EjuRrl66rRdLyUBy+ID0aJCx2QeKFEKmmPm5ks01tdciWWNGBNC50kbKzV1qKGtY4Im9Lv
 +lPobgqRgeu47ZOhU4El/5TX+EGc9gKbToDcKrI5U0ii22NzC0AnAjX3UVQnr/B1DZJ3qW
 2Mhfu5FKFebtDvfKA/8FiydtY/qQagA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-eJkuWpVJMwus2PPpcH8tBg-1; Wed, 12 Mar 2025 11:36:31 -0400
X-MC-Unique: eJkuWpVJMwus2PPpcH8tBg-1
X-Mimecast-MFC-AGG-ID: eJkuWpVJMwus2PPpcH8tBg_1741793791
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e8f9450b19so234306d6.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 08:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741793791; x=1742398591;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nrl5hdPrHKRG86mu1gtfivNP4aYY6RWf6n/HBWLbb/E=;
 b=efU3wi4H09LxstKUH9valQyJM4DfevYEMDzSlhWVRs+yBba2HvSHdYfGq8l6UJkHXv
 ZRIp9BAgMkZfX9icDvmpxx/8Y0fTpn40h17hwrQ6ZMmraW6ODkmo5GdPOqZnZ5lP/SRn
 US9d0S9QvFPcRhhYmp/8LQm4xIDKzcbecl4U882xskhGC4lk1sHH54fNVk880Y7BdW8X
 bQkNEk7jzQPhvfGjd6QpQJ3JzezGebOEMkhHUaDcigNc49C1zTGn65F4v/JXtfKCZIbH
 NW3gRvHZ+6k4X333viq6Mtk9nUPoRddvqDop9o/HNytTqzAIlio2RwDe3leD1VBjWYPU
 0Emg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqm3SP+LCR2Rp51RB6/mxpwd4qgajk6UxlMqqKThV+rLqmpP5YvSsHk7uMVPS9JCOgBpOJjDFVETwn@nongnu.org
X-Gm-Message-State: AOJu0YygYs6TPL9AuvNBUOV2aJtcdbDsN0Sp+G4k+RPjSqFCF+M2b6md
 djeImxzoOyuRjoYRYjEDD9Hro92KADWgJAhpOJiT5kOA4nh3HWhn0uGCpNuhq/VeqzEKxLEttP8
 jAS9WvlTSaGm4JUXLewUQxw+JNgbb+5Jr4KJzgqkgJGa978AHeG0Y
X-Gm-Gg: ASbGncsJyAiofGEhevrZ25a8FGfShheJMqGZEBjmjeZl1OF5mBb6Fvbv9cmyB5ufAEA
 wxIXnG5LrPJ2oq2JuV+SwiRcLC0Tvp+RCyIRnnROVRmgnNlQEBTbgLWynhlEC31uc2o01rHmj31
 oI9jjnRRXMkAQCfFQToR0xNvvCmeUp+UoiD3SUrd76zxFUHQpFp41ZEz6+Q79Hf26TaR5TUVrPB
 X8q/xMZScmnQlaAwjnTmkA1hAYBsWUG5wy7PaQ5vODbIHA0shtdjYhj713hoh6b2MxU2hrV3RLU
 yiQ7e5ZqnIOFGowz3beWcdP6grc+CjhHIdoDqUAGt6D6IYe1MChM3OdyOcrGaUQ=
X-Received: by 2002:a05:6214:2a88:b0:6e4:3478:8ea7 with SMTP id
 6a1803df08f44-6eadb7b2086mr273396d6.4.1741793790772; 
 Wed, 12 Mar 2025 08:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8DksWasn/BaWZQvien0HD1VYGsxRPQdjVzoHqrSffE9u6Jzjcb8vPIPQ/JDCAgmU1XuhQng==
X-Received: by 2002:a05:6214:2a88:b0:6e4:3478:8ea7 with SMTP id
 6a1803df08f44-6eadb7b2086mr272876d6.4.1741793790410; 
 Wed, 12 Mar 2025 08:36:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f71709aesm85440226d6.116.2025.03.12.08.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 08:36:29 -0700 (PDT)
Message-ID: <547f961e-380c-4ffe-8b8b-3e9d543aa702@redhat.com>
Date: Wed, 12 Mar 2025 16:36:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/20] hw/arm/virt: Add support for smmuv3-accel
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-5-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Shameer,


On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> Allow cold-plug smmuv3-accel to virt If the machine wide smmuv3
> is not specified.
>
> No FDT support is added for now.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt.c         | 12 ++++++++++++
>  hw/core/sysbus-fdt.c  |  1 +
>  include/hw/arm/virt.h |  1 +
>  3 files changed, 14 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4a5a9666e9..84a323da55 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -73,6 +73,7 @@
>  #include "qobject/qlist.h"
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
> +#include "hw/arm/smmuv3-accel.h"
>  #include "hw/acpi/acpi.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/internals.h"
> @@ -2911,6 +2912,16 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>              platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
>                                       SYS_BUS_DEVICE(dev));
>          }
> +        if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3_ACCEL)) {
> +            if (vms->iommu == VIRT_IOMMU_SMMUV3) {
maybe just check whether it is != VIRT_IOMMU_NONE?
> +                error_setg(errp,
> +                           "iommu=smmuv3 is already specified. can't create smmuv3-accel dev");
I would clearly state "iommu=smmuv3 virt machine option is alreadt set"
and use an error hint to say both are not compatible.
> +                return;
> +            }
> +            if (vms->iommu != VIRT_IOMMU_SMMUV3_ACCEL) {
> +                vms->iommu = VIRT_IOMMU_SMMUV3_ACCEL;

I know there were quite a lot of dicussions on the 1st multi
instantiation series related to the way we instanatiate that device and
maybe I missed some blockers but why wouldn't we allow the instantiation
of the legacy smmu device with -device too. I think this would be
simpler for libvirt and we would somehow deprecate the machine option
method? would that make a problem if you were to use -device smmu,accel
or something alike?
> +            }
> +        }
>      }
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> @@ -3120,6 +3131,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3_ACCEL);
>  #ifdef CONFIG_TPM
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>  #endif
> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> index 774c0aed41..c8502ad830 100644
> --- a/hw/core/sysbus-fdt.c
> +++ b/hw/core/sysbus-fdt.c
> @@ -489,6 +489,7 @@ static const BindingEntry bindings[] = {
>  #ifdef CONFIG_LINUX
>      TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
>      TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
> +    TYPE_BINDING("arm-smmuv3-accel", no_fdt_node),
use the define instead.

to me this patch should be moved at the end of the series when the
device is fully functional.
>      VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
>  #endif
>  #ifdef CONFIG_TPM
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index c8e94e6aed..849d1cd5b5 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -92,6 +92,7 @@ enum {
>  typedef enum VirtIOMMUType {
>      VIRT_IOMMU_NONE,
>      VIRT_IOMMU_SMMUV3,
> +    VIRT_IOMMU_SMMUV3_ACCEL,
>      VIRT_IOMMU_VIRTIO,
>  } VirtIOMMUType;
>  
Thanks

Eric


