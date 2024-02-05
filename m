Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B67C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 16:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX1lV-0005cF-81; Mon, 05 Feb 2024 11:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rX1lT-0005bc-Hh
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:24:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rX1lR-0000Yo-M6
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707150248;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0YpVOHMpyvEliTGejhp9W9X/tl+XrN5ezSE0h6zBoU=;
 b=ePWux3l4znzq2YilIh1cSFIOPVDnhrYZHBJUcmwKXcscdD/iQI/ZZRaOBvgXketT4TN6eW
 GnKR8LjlMcbF6+hoo647Ey7eSbQGNWUGiwi6JvwO0agcNZXiQh07NF2hIf6uJM1V0S8z1c
 H8gJP+q5UDyyc+wcGrENOifAZglQzyY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-HyKOHdiiMXSovU2LPXWRpg-1; Mon, 05 Feb 2024 11:24:07 -0500
X-MC-Unique: HyKOHdiiMXSovU2LPXWRpg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-680c651928eso65903306d6.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 08:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707150246; x=1707755046;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v0YpVOHMpyvEliTGejhp9W9X/tl+XrN5ezSE0h6zBoU=;
 b=FyQf8lds7KdDk61fUSXKTbDFw0ahctvnEoh3xdGdddxQH2MWVw97QSzqepJcykxmu8
 C/z8TZ1FAw7oY8wQt9pzwbREHFwfuL/9OX3Et6Bz4DqLIuehAdRFEB4OgpHV298SSBki
 wI+VjOEzEzJHeMacxxgb/LMmi0Wc42wCxeFHxlNrDCScxA7DmjF70eemFGNQLvSTkIJT
 UXZhp0bphIAxAhHpZPLEgVx1Ox0FkExCS2ssZ2uxUXB4S3GVTL8iYVNxZ9tZN37nPYtX
 ONCndaw/5XSsuC53da7Nv2rQL4nUqio6ejgE/VjnXwBwt4bPZBHPaoj2S4zQt/3MVhNi
 UjUw==
X-Gm-Message-State: AOJu0Yyf7XaXdCT4jpp/+qZd52rfeLZfEgQMp8l5fEcwMq1mkx6MFQq2
 D99/ZZf60lteguS9/0LIvoDHRKQBjHrT9DGcRVdbWCIu6AehJJpOCe9ChYxraactmAhB2A4hAbK
 VX2ojFhaIpI0HliVMlbZOlJwXTLu7/4JaaG7So45eu6QvWcxeqQvV
X-Received: by 2002:a05:6214:260e:b0:68c:9db6:e178 with SMTP id
 gu14-20020a056214260e00b0068c9db6e178mr6455867qvb.39.1707150246592; 
 Mon, 05 Feb 2024 08:24:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9ULTDhpIsrcNe8XFfopfVt+R8oGXfDdTjR0deFK8kWEJthP4AVRD5CwF0VtUJ091dI/Guaw==
X-Received: by 2002:a05:6214:260e:b0:68c:9db6:e178 with SMTP id
 gu14-20020a056214260e00b0068c9db6e178mr6455836qvb.39.1707150246257; 
 Mon, 05 Feb 2024 08:24:06 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU39dEf55hNYsaJNqi+pDLPQRrpjHLG4nu+Ci7MXXtg4eaILEo4bw9MofJPFz/1x1wOKYIBCw2AF8Nkkkg/GPHP4N//INGx1P5c1o/WWl5IxbbYb+DVio07FSOyWmjDWuwcLf6m9Jwgxxt6jL8G9DAIKYScrV094bMvSghm9b2jUSQYGmN4KqmQawodh6mp8sdaqrKHy788eOESPFl+dkj/RQ5T/Yiz7ZXFG1nHisIKB1Sl7cdfNbMbZWFPPG6/G61I1TRT2BKlHt4j6n0xJ88X69uFbdIv54J8iDdHcYrg0R5emDsfnwrT2hQQf2HRID0EQrPCZ/cmsJa/AFhCK2Z5wxPMy7f/cVk=
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a0cf514000000b0068c440bc7d0sm109511qvm.105.2024.02.05.08.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 08:24:05 -0800 (PST)
Message-ID: <716f974a-48b3-4b30-bebc-242f4c3e7430@redhat.com>
Date: Mon, 5 Feb 2024 17:24:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw: Set virtio-iommu aw-bits default value on
 pc_q35_9.0 and arm virt
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, alex.williamson@redhat.com,
 peter.maydell@linaro.org, zhenzhong.duan@intel.com, yanghliu@redhat.com
Cc: mst@redhat.com, jasowang@redhat.com
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-4-eric.auger@redhat.com>
 <d4571370-0fcc-4065-8571-60ccc18f4982@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <d4571370-0fcc-4065-8571-60ccc18f4982@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2/5/24 10:33, Cédric Le Goater wrote:
> On 2/1/24 17:32, Eric Auger wrote:
>> Currently the default input range can extend to 64 bits. On x86,
>> when the virtio-iommu protects vfio devices, the physical iommu
>> may support only 39 bits. Let's set the default to 39, as done
>> for the intel-iommu. On ARM we set 48b as a default (matching
>> SMMUv3 SMMU_IDR5.VAX == 0).
>>
>> We use hw_compat_8_2 to handle the compatibility for machines
>> before 9.0 which used to have a virtio-iommu default input range
>> of 64 bits.
>>
>> Of course if aw-bits is set from the command line, the default
>> is overriden.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>> - set aw-bits to 48b on ARM
>> - use hw_compat_8_2 to handle the compat for older machines
>>    which used 64b as a default
>> ---
>>   hw/arm/virt.c            | 6 ++++++
>>   hw/core/machine.c        | 5 ++++-
>>   hw/i386/pc.c             | 6 ++++++
>>   hw/virtio/virtio-iommu.c | 2 +-
>>   4 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index e6ead2c5c8..56539f2fc5 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2718,10 +2718,16 @@ static void
>> virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>           virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev),
>> MACHINE(hotplug_dev), errp);
>>       } else if (object_dynamic_cast(OBJECT(dev),
>> TYPE_VIRTIO_IOMMU_PCI)) {
>> +        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
>> +                                                   "aw-bits", NULL);
>
> object_property_get_uint() should not fail. Please use &error_abort.
sure
>
>>           hwaddr db_start = 0, db_end = 0;
>>           QList *reserved_regions;
>>           char *resv_prop_str;
>>   +        if (!aw_bits) {
>> +            qdev_prop_set_uint8(dev, "aw-bits", 48);
>> +        }
>> +
>>           if (vms->iommu != VIRT_IOMMU_NONE) {
>>               error_setg(errp, "virt machine does not support
>> multiple IOMMUs");
>>               return;
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index fb5afdcae4..70ac96954c 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -30,9 +30,12 @@
>>   #include "exec/confidential-guest-support.h"
>>   #include "hw/virtio/virtio-pci.h"
>>   #include "hw/virtio/virtio-net.h"
>> +#include "hw/virtio/virtio-iommu.h"
>>   #include "audio/audio.h"
>>   -GlobalProperty hw_compat_8_2[] = {};
>> +GlobalProperty hw_compat_8_2[] = {
>> +    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
>> +};
>>   const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
>>     GlobalProperty hw_compat_8_1[] = {
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 803244e5cc..0e2bcb4840 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1458,6 +1458,8 @@ static void
>> pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>           virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev),
>> MACHINE(hotplug_dev), errp);
>>       } else if (object_dynamic_cast(OBJECT(dev),
>> TYPE_VIRTIO_IOMMU_PCI)) {
>> +        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
>> +                                                   "aw-bits", NULL);
>>           /* Declare the APIC range as the reserved MSI region */
>>           char *resv_prop_str =
>> g_strdup_printf("0xfee00000:0xfeefffff:%d",
>>                                                
>> VIRTIO_IOMMU_RESV_MEM_T_MSI);
>> @@ -1466,6 +1468,10 @@ static void
>> pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>           qlist_append_str(reserved_regions, resv_prop_str);
>>           qdev_prop_set_array(dev, "reserved-regions",
>> reserved_regions);
>>   +        if (!aw_bits) {
>> +            qdev_prop_set_uint8(dev, "aw-bits", 39);
>
> May be use VTD_HOST_AW_39BIT instead of 39 ? This would make it
> easier to find uses of certain defaults values and would clarify
> that the default AW of virtio-iommu is set as intel-iommu.

OK

Thanks!

Eric
>
> Thanks,
>
> C.
>
>
>
>> +        }
>> +
>>           g_free(resv_prop_str);
>>       }
>>   diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 7870bdbeee..c468e9b13b 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -1529,7 +1529,7 @@ static Property virtio_iommu_properties[] = {
>>       DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>>                        TYPE_PCI_BUS, PCIBus *),
>>       DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>> -    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>


