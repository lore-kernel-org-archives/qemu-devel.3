Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C52C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufl6-0008Kj-OR; Tue, 18 Mar 2025 18:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tufl3-0008JN-5q
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tufl0-00039C-IS
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742338194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AF4rmIYLEyBVPVsLZ3qMtdPqeFbNY2HOyi12QD0TGEM=;
 b=OAh2jO8toUPCb1DxB6DhSUqs8nNewArEoJ3iyAuDUTkLccn4/+DFWFZ2JXQkk4A1rv0Im4
 a/ME2Fa9Gcr376hoR/qZ6hFb/ntX4lRD9gWo4k6xqrpJDvhUKTjbEblY/bq//vOjlQ9gsa
 67Yo8Fey455Q/bjIu70x77QuY61oOZ8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-VqcfTiNPON-zHf1X3a0zgg-1; Tue, 18 Mar 2025 18:49:51 -0400
X-MC-Unique: VqcfTiNPON-zHf1X3a0zgg-1
X-Mimecast-MFC-AGG-ID: VqcfTiNPON-zHf1X3a0zgg_1742338190
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-85b5a7981ccso583244039f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742338190; x=1742942990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AF4rmIYLEyBVPVsLZ3qMtdPqeFbNY2HOyi12QD0TGEM=;
 b=dp2NR5VStIZvvJGp3JxOJAV85xIvQFOKZRMvRm5vFrTWIto62/Dyq8LfKRBHyYbnrK
 Hhmfz6Y4z4ibyqp8HqPTiR9qusOLSKPPYU55KEObNA7snfFcyB4OcxPYrzmkjnkxgffx
 ZeOY+5rD0a+k26ylTvVw2beLyt6k3E94Nq4lKP0vNo21RFEabF8/Ew92htRFxkLtNGju
 JNrfeh/hqoXGRo2h7WUsruwjITlQYn5PoURlze+yVxYs2AUw33K7TFK0Z876ToXNuO0z
 q50H51vIgAbHyX2IkS6yDSjiDtXrI5+g2po6ji8Irne7bSGPkFxD8Vr+nwpLI+0bCQ+I
 f5xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo2LtovM+X5q4mogvQZnXRmnwdf6kRVSnKV8fD1aWR23GBZNscckq0Ll6HI63otHppx6oBF9+x4p0y@nongnu.org
X-Gm-Message-State: AOJu0YwVttUY8C32WyBbrLsGGSH9rtTDiCNX0mvOLeCJ0s/c5b9/WCIW
 duyA5wPl1AOkKTJ5KOjYYxXMG2QxaRMNBbxo6iLObg4kmg4m7E2GPGBf8RsVIRL1umz4T3TnLxA
 sRPNWq7vej2szQF2nrju2liJHr0bvh78u18qs8IWb03nRJ/f/BTsH
X-Gm-Gg: ASbGncsbMtVzflfCdlapKTwHURxvq4Gu4mlNX04DLsqgfFvQu9anBxUeIgqy0OXZALW
 PTsFstwGSWIkUzw2HCnEazrdZDn9V50I+oQZT2cM4CxYxPgwqjp8Svj/M9hFKmlPIAWOL7MFgIy
 /M5JHQ6l0r5GKFVO3/YVkzunvvItKeE9NtTN4PcORfE/BVe9V/5z5jq4XBa/wC0trATQ054ugje
 qplZo2l4FwWgUmq3z45gETEzNKVABgPPhkFsn+NajuubWP+4JLTAB3/eE5bWaGGXPW5aL1riX1k
 3kwbfr7pojoOnot2
X-Received: by 2002:a05:6602:378d:b0:85b:601d:dfb3 with SMTP id
 ca18e2360f4ac-85e137c0ce7mr77479639f.5.1742338190249; 
 Tue, 18 Mar 2025 15:49:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW1T5ZMxD9VXZFPFR5ZQYih7H157mVo+2tYsvoS9rn0CBUqEwfnLzcX0kegA8owJeTR4nFXA==
X-Received: by 2002:a05:6602:378d:b0:85b:601d:dfb3 with SMTP id
 ca18e2360f4ac-85e137c0ce7mr77476339f.5.1742338189949; 
 Tue, 18 Mar 2025 15:49:49 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f263719a69sm2936084173.52.2025.03.18.15.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:49:49 -0700 (PDT)
Message-ID: <82e44777-8f14-428c-9614-c521e4836fce@redhat.com>
Date: Tue, 18 Mar 2025 18:49:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/20] hw/arm/virt: Add support for smmuv3-accel
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-5-shameerali.kolothum.thodi@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250311141045.66620-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Doesn't this commit become moot, if accel becomes an smmuv3 option vs separate device object altogether,
dynamically added if a pdev is attached to a host SMMUv3 that has accel feature(s)?

Blocking w/virtio-iommu falls under the same situation mentioned in 03/20 wrt mixing emulated & physical devices on the same smmuv3.

- Don

On 3/11/25 10:10 AM, Shameer Kolothum wrote:
> Allow cold-plug smmuv3-accel to virt If the machine wide smmuv3
> is not specified.
> 
> No FDT support is added for now.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   hw/arm/virt.c         | 12 ++++++++++++
>   hw/core/sysbus-fdt.c  |  1 +
>   include/hw/arm/virt.h |  1 +
>   3 files changed, 14 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4a5a9666e9..84a323da55 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -73,6 +73,7 @@
>   #include "qobject/qlist.h"
>   #include "standard-headers/linux/input.h"
>   #include "hw/arm/smmuv3.h"
> +#include "hw/arm/smmuv3-accel.h"
>   #include "hw/acpi/acpi.h"
>   #include "target/arm/cpu-qom.h"
>   #include "target/arm/internals.h"
> @@ -2911,6 +2912,16 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>               platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
>                                        SYS_BUS_DEVICE(dev));
>           }
> +        if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3_ACCEL)) {
> +            if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> +                error_setg(errp,
> +                           "iommu=smmuv3 is already specified. can't create smmuv3-accel dev");
> +                return;
> +            }
> +            if (vms->iommu != VIRT_IOMMU_SMMUV3_ACCEL) {
> +                vms->iommu = VIRT_IOMMU_SMMUV3_ACCEL;
> +            }
> +        }
>       }
>   
>       if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> @@ -3120,6 +3131,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3_ACCEL);
>   #ifdef CONFIG_TPM
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>   #endif
> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> index 774c0aed41..c8502ad830 100644
> --- a/hw/core/sysbus-fdt.c
> +++ b/hw/core/sysbus-fdt.c
> @@ -489,6 +489,7 @@ static const BindingEntry bindings[] = {
>   #ifdef CONFIG_LINUX
>       TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
>       TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
> +    TYPE_BINDING("arm-smmuv3-accel", no_fdt_node),
>       VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
>   #endif
>   #ifdef CONFIG_TPM
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index c8e94e6aed..849d1cd5b5 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -92,6 +92,7 @@ enum {
>   typedef enum VirtIOMMUType {
>       VIRT_IOMMU_NONE,
>       VIRT_IOMMU_SMMUV3,
> +    VIRT_IOMMU_SMMUV3_ACCEL,
>       VIRT_IOMMU_VIRTIO,
>   } VirtIOMMUType;
>   


