Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC57C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 08:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVpEr-00014f-QK; Fri, 02 Feb 2024 03:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rVpEq-00014X-Kr
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 03:49:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rVpEo-00035F-Sk
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 03:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706863769;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lomaNRfIeKNH8mTcILDlIKpT2UG2+kWf+qWtwQ53gAk=;
 b=YyXoPAF3K3+JwYX+WR1OrntMZAS60gRjtPh/R4z+1OW7XHeEmFtwLYo8i40GZIiwKZNmTD
 meupRqWs6hIfAEgAkGMlgfthbh9ZydiI0/dab0tEw47M8XXltlWP892YUoZH5XoxeOhWIJ
 SvfCJwqN8oN4asbfRsOrHv/LkofTFDk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-R5Djjr58Oh6W-A8M-jXSRQ-1; Fri, 02 Feb 2024 03:49:27 -0500
X-MC-Unique: R5Djjr58Oh6W-A8M-jXSRQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50e91f9d422so2077780e87.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 00:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706863766; x=1707468566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lomaNRfIeKNH8mTcILDlIKpT2UG2+kWf+qWtwQ53gAk=;
 b=KNOQ5BYBqHfHq79OVrf07WNASGgJjNBEy98dfeIXfiqKkZVBvDISz5VLUaaijm9Qeu
 TB7x0qK+PJtkmdGFXuLeiEfc9Qan0YedSzodTwM8HYThUkqWENK/6FmWGlpL6paXhN6d
 zw0t0/9Z1vih/46rad95Ome0O9SxzLVmQZjsriE0sZCsCXE/Qt2jvHfwHHNI1td/aMFh
 HxQbho848CWI9V/eMK88xdfa8fCkzcu9cSVKoHNI1Yx9KGLA3VPSAuoPm3fofp6mb9Qy
 wAcKp2ts0SxakzrMuUNcxFUlaPslVcuWxpvCsg0JFpAF1yctR9sYcoV13w7iTGM5Xrwq
 kmDA==
X-Gm-Message-State: AOJu0YwWcZabMu82VVrWJ2qs3haeZC5Xdp+lFTSZ2tMWEyRhSO+tg5ti
 vtrGIZj+K0KeB+hKzw3EcC3ZjNsdTykf5f1MEyjcAB7SfPtP34HQn6HA6HcDb7MIIsl9pMfB/qV
 ni624hxc3xS5SWbRFjspwo7RhMv/RYXFf0OixUMJTMzp8oHD85YHr
X-Received: by 2002:a19:6912:0:b0:510:f55:fbf8 with SMTP id
 e18-20020a196912000000b005100f55fbf8mr839675lfc.68.1706863766323; 
 Fri, 02 Feb 2024 00:49:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqDohpv3YDiegto1FbVtlMj+mz8A1R0ZTLwNdv41xsC4maTfWOEwZMK4n74pwD8tAGgp2Fhw==
X-Received: by 2002:a19:6912:0:b0:510:f55:fbf8 with SMTP id
 e18-20020a196912000000b005100f55fbf8mr839664lfc.68.1706863765991; 
 Fri, 02 Feb 2024 00:49:25 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXLjZiBG2E4wF/5dqDnlrgYu0lAQhR35MNKPK6JXtabl3vhVxyIFxhoLooNCO2vwhJBSrII6nMxgt2VOdJPGi0RL4TLKhEHYvPfSbPK9r08oMwnx+GayXQWUG/Awu/XQvtFxpYV1HrH4YbSwA50hq2JZQaTtwYkAMOyfaljCqlYZfU75wYkqHUz5wx9ch0m2uUiIMa1lKdcLdszk4p//yzX3gkJlbh/W2kqtYUTysVfVzHaQpjjDWGK+a/sL4TIaP/ffDed76Twke9uOlaWW8g74uYtt8Nwmc8h3Cy/Z5zt+yOKmGsv9NYSsPM5CJVBU/apP6+bQpmNVRsXnmAV1w==
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a29-20020a056512021d00b005100ec1e3d2sm241586lfo.215.2024.02.02.00.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Feb 2024 00:49:25 -0800 (PST)
Message-ID: <7ecef9bc-e263-447a-9883-49e17a7f3115@redhat.com>
Date: Fri, 2 Feb 2024 09:49:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw: Set virtio-iommu aw-bits default value on
 pc_q35_9.0 and arm virt
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-4-eric.auger@redhat.com>
 <SJ0PR11MB67443F341958AD061E9A144D92422@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67443F341958AD061E9A144D92422@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 2/2/24 07:51, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> pc_q35_9.0 and arm virt
>>
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
>>  which used 64b as a default
>> ---
>> hw/arm/virt.c            | 6 ++++++
>> hw/core/machine.c        | 5 ++++-
>> hw/i386/pc.c             | 6 ++++++
>> hw/virtio/virtio-iommu.c | 2 +-
>> 4 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index e6ead2c5c8..56539f2fc5 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2718,10 +2718,16 @@ static void
>> virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>         virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
>> errp);
>>     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>> +        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
>> +                                                   "aw-bits", NULL);
>>         hwaddr db_start = 0, db_end = 0;
>>         QList *reserved_regions;
>>         char *resv_prop_str;
>>
>> +        if (!aw_bits) {
>> +            qdev_prop_set_uint8(dev, "aw-bits", 48);
>> +        }
>> +
>>         if (vms->iommu != VIRT_IOMMU_NONE) {
>>             error_setg(errp, "virt machine does not support multiple IOMMUs");
>>             return;
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index fb5afdcae4..70ac96954c 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -30,9 +30,12 @@
>> #include "exec/confidential-guest-support.h"
>> #include "hw/virtio/virtio-pci.h"
>> #include "hw/virtio/virtio-net.h"
>> +#include "hw/virtio/virtio-iommu.h"
>> #include "audio/audio.h"
>>
>> -GlobalProperty hw_compat_8_2[] = {};
>> +GlobalProperty hw_compat_8_2[] = {
>> +    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
>> +};
>> const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
>>
>> GlobalProperty hw_compat_8_1[] = {
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 803244e5cc..0e2bcb4840 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1458,6 +1458,8 @@ static void
>> pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>         virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
>> errp);
>>     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>> +        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
>> +                                                   "aw-bits", NULL);
>>         /* Declare the APIC range as the reserved MSI region */
>>         char *resv_prop_str = g_strdup_printf("0xfee00000:0xfeefffff:%d",
>>                                               VIRTIO_IOMMU_RESV_MEM_T_MSI);
>> @@ -1466,6 +1468,10 @@ static void
>> pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>         qlist_append_str(reserved_regions, resv_prop_str);
>>         qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>>
>> +        if (!aw_bits) {
>> +            qdev_prop_set_uint8(dev, "aw-bits", 39);
>> +        }
>> +
>>         g_free(resv_prop_str);
>>     }
>>
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 7870bdbeee..c468e9b13b 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -1529,7 +1529,7 @@ static Property virtio_iommu_properties[] = {
>>     DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>>                      TYPE_PCI_BUS, PCIBus *),
>>     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>> -    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
> Not clear if virtio-iommu support other archs besides x86 and arm.
> It looks on those archs, aw_bits is default 0 on machine 9.0 above
> and will fails the check in realize?

At the moment the virtio-iommu only is supported along with q35 and
arm-virt.
Only those machines set the reserved-regions prop and the aw-bits, which
are both requested for a correct behavior.

Thank you for the review!

Eric

>
> Thanks
> Zhenzhong
>
>>     DEFINE_PROP_END_OF_LIST(),
>> };
>>
>> --
>> 2.41.0


