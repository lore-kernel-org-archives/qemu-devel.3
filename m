Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B830C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 09:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWvM4-0000nJ-Hh; Mon, 05 Feb 2024 04:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rWvM3-0000mN-5t
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rWvM1-0003AL-91
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707125608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Kej3aUtVc5CRwaWUishz6Is/8cmnAUBsCJhmP6/MZI=;
 b=JxYXlT+MCxYIgPTulEavm6hDy19mAVwI1nWDzSTfsFPJO9jC5c7KAH4JE8clFjmw6hNkgy
 FvtPftrkVSMMPfMwQ1J5sZq9u4J3sSDMiLk+mVW7kqMrzDZ3UQZ9GZBfVH4qUAreRuc98u
 PgrFOTmbvdNUVW8RJuZMxFLqRN31opk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-nY-_fDCIOAma56w9Ab2I9g-1; Mon, 05 Feb 2024 04:33:25 -0500
X-MC-Unique: nY-_fDCIOAma56w9Ab2I9g-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dc6ba69e803so7130453276.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 01:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707125605; x=1707730405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Kej3aUtVc5CRwaWUishz6Is/8cmnAUBsCJhmP6/MZI=;
 b=n2ZN677YDVF0C5zPkxiFhqcl83kYuubGQTQSOV5GW3w87f45sYpDmAG9I2nkW1n+XF
 /RKSdpFG0YAGdDVpNQTXeXNQo1dLoeFVCiymM3yuuKFpm70b1DCvrC6PBUQ0VLi/tqwC
 EYsLvp6mKH0YrmFxfSCZo0IXmluDSHhOXovYySG3q3SdNlbHVDiXy18XHKdiXh/D7Inn
 w6/MikLGdCYyjzA1FfFJq1NoTCcUxlp39RtpuvSjhGex9M/oUqEFSmEKzrPZyEU/Y8CF
 KDtYXWpMNOsgIpzIpg26fRMODmIZ3l63uT/TLSNWb7MnuIMKmiJGtBmoi3v+Abt90Ss8
 aYVA==
X-Gm-Message-State: AOJu0Yz69VThrzRmDbRJysz1Kud8AFu9Ijra1OygRBY+SwRY/5djg/NG
 vgyCYA3Q89GzHZCzX2TewfJ8neHCTjFjZMLle/Bu+kDGfyvIZ2D+3pmR14X2U59SH3oDWF2x8zg
 z8CEw+tbEFEiPj0+iH78JNr4B1Z5wyQ0Nv1taVA/QXl1dvD+kvBMm
X-Received: by 2002:a25:ae46:0:b0:dc6:528c:b3f8 with SMTP id
 g6-20020a25ae46000000b00dc6528cb3f8mr7693583ybe.3.1707125605166; 
 Mon, 05 Feb 2024 01:33:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3BpdomOWCY7IHS0I2Siw1yW9BRAgQ6A85PqgR0b7A/DMNcoM8GUUHyPJzYezTu1iFGcK3Ow==
X-Received: by 2002:a25:ae46:0:b0:dc6:528c:b3f8 with SMTP id
 g6-20020a25ae46000000b00dc6528cb3f8mr7693570ybe.3.1707125604884; 
 Mon, 05 Feb 2024 01:33:24 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUYRS1RVBDq8KFcDw/Qd5MQh52i3KfQZayfg2UNxDehDl1VHJfZarc/jIGF5nFy7P4x9P09NsVb7P8mM055Lu8uPdAKoKg8g6vla/EoAzCqaisSjXRz+QV07ZV4Zy8t6Ne49UEaD0kUCSqPSphe1dWyVEKbTHpAop9977fRvDWGSDdM2wDHYSkzX/Sqa91Qbc5s1pLLv5kcQVdusfYSctHW8Dj4zPWlnKgQMj70aeAU/rPG7CGXkYFV1PfqFXERCD9ilX/RfXGJLo4HsZuA4tkUzYwnjAg1v/i7RKYPpHQt+daE4N0KofSfH6RGcy+fvtZNbN29tYM2sasEvpaA5Fo2MwMFMap0Ejk=
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ay14-20020a05620a178e00b00783df78821dsm2810809qkb.25.2024.02.05.01.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 01:33:24 -0800 (PST)
Message-ID: <d4571370-0fcc-4065-8571-60ccc18f4982@redhat.com>
Date: Mon, 5 Feb 2024 10:33:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw: Set virtio-iommu aw-bits default value on
 pc_q35_9.0 and arm virt
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jean-philippe@linaro.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, yanghliu@redhat.com
Cc: mst@redhat.com, jasowang@redhat.com
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-4-eric.auger@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240201163324.564525-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/1/24 17:32, Eric Auger wrote:
> Currently the default input range can extend to 64 bits. On x86,
> when the virtio-iommu protects vfio devices, the physical iommu
> may support only 39 bits. Let's set the default to 39, as done
> for the intel-iommu. On ARM we set 48b as a default (matching
> SMMUv3 SMMU_IDR5.VAX == 0).
> 
> We use hw_compat_8_2 to handle the compatibility for machines
> before 9.0 which used to have a virtio-iommu default input range
> of 64 bits.
> 
> Of course if aw-bits is set from the command line, the default
> is overriden.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - set aw-bits to 48b on ARM
> - use hw_compat_8_2 to handle the compat for older machines
>    which used 64b as a default
> ---
>   hw/arm/virt.c            | 6 ++++++
>   hw/core/machine.c        | 5 ++++-
>   hw/i386/pc.c             | 6 ++++++
>   hw/virtio/virtio-iommu.c | 2 +-
>   4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index e6ead2c5c8..56539f2fc5 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2718,10 +2718,16 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
> +                                                   "aw-bits", NULL);

object_property_get_uint() should not fail. Please use &error_abort.

>           hwaddr db_start = 0, db_end = 0;
>           QList *reserved_regions;
>           char *resv_prop_str;
>   
> +        if (!aw_bits) {
> +            qdev_prop_set_uint8(dev, "aw-bits", 48);
> +        }
> +
>           if (vms->iommu != VIRT_IOMMU_NONE) {
>               error_setg(errp, "virt machine does not support multiple IOMMUs");
>               return;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index fb5afdcae4..70ac96954c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -30,9 +30,12 @@
>   #include "exec/confidential-guest-support.h"
>   #include "hw/virtio/virtio-pci.h"
>   #include "hw/virtio/virtio-net.h"
> +#include "hw/virtio/virtio-iommu.h"
>   #include "audio/audio.h"
>   
> -GlobalProperty hw_compat_8_2[] = {};
> +GlobalProperty hw_compat_8_2[] = {
> +    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
> +};
>   const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
>   
>   GlobalProperty hw_compat_8_1[] = {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 803244e5cc..0e2bcb4840 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1458,6 +1458,8 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
> +                                                   "aw-bits", NULL);
>           /* Declare the APIC range as the reserved MSI region */
>           char *resv_prop_str = g_strdup_printf("0xfee00000:0xfeefffff:%d",
>                                                 VIRTIO_IOMMU_RESV_MEM_T_MSI);
> @@ -1466,6 +1468,10 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>           qlist_append_str(reserved_regions, resv_prop_str);
>           qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>   
> +        if (!aw_bits) {
> +            qdev_prop_set_uint8(dev, "aw-bits", 39);

May be use VTD_HOST_AW_39BIT instead of 39 ? This would make it
easier to find uses of certain defaults values and would clarify
that the default AW of virtio-iommu is set as intel-iommu.

Thanks,

C.



> +        }
> +
>           g_free(resv_prop_str);
>       }
>   
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 7870bdbeee..c468e9b13b 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -1529,7 +1529,7 @@ static Property virtio_iommu_properties[] = {
>       DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>                        TYPE_PCI_BUS, PCIBus *),
>       DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
> -    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   


