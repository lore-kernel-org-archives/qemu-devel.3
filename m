Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4DBC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2A2-0003jw-N3; Tue, 27 Feb 2024 13:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rf2A0-0003jW-P4
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:26:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rf29w-0005lb-9u
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709058389;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AFnq+ayDVF2ZGOXBRpx8X1gsU71lsF50D6/L9Di0jOA=;
 b=I+ZNCvaY+DoxtPiHF0d8z72FTOW550qBzMOHmCBXwYFXJA2QneTKH0Rg4lU8fhBLln58RF
 oDyC2VE+BEdDla7uGi0roX7sc5tm+6UQeJNuoehUafzQ2pe+g4Z6wupiMtDGbHPWh1Eg3i
 XM2ikVek55myOB501r7/2buQv6B6xcE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-szjFG7C-Oo2UurTXuLu50g-1; Tue, 27 Feb 2024 13:26:27 -0500
X-MC-Unique: szjFG7C-Oo2UurTXuLu50g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41297aeece5so16630425e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709058386; x=1709663186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AFnq+ayDVF2ZGOXBRpx8X1gsU71lsF50D6/L9Di0jOA=;
 b=psClKY6SUPFJqTYOc5x7lvHsTqZmQjVo5uixauaAZg1awTvL8+QgJe5MwQiUOTGxD+
 vOp+GrLYGfo+vDAqud9hECkYduNY18vF+eqv9yCjGSMCIUjBUePYLQG34L6OuI4BvY/g
 L5yo/uQTKB6DCEGoD/K2tR6U3KXFjOGUUW7K+5rgkDKdnTeLkbXaY7NlqyQrKhQD5wxl
 XYDlaeJW4bNqMVrREia8w+w+MUlopEwAeoGjXd2czQEOr2jHz3n0XyZbVQjcV7NvGQke
 O1C8QVYtBEMysdVAc/r8IYlhUWQBAOd5kToR3KNMERMnH3hVfho2cIRwhsDM3SAudbvl
 0Quw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8zhrhTX0wVHmLFzCMz5fcc20qphGLht9pTMXR6waG3BDAst9EZ5nvWj2D9kL2GCTujTUWZBJD57WWOwm6LTt5C4BrN6k=
X-Gm-Message-State: AOJu0YwFYZVba+1vVnJfRNl6bsf2vyPaggOyqG1arzYPy2NaKISSxenX
 JMW9Trk1e4Xrt1cvMOVsKMcK/z1N1NW+kDwmY4ah5WoyCaUJ+inQ/Ky9DF1dRtALSDRjRjP0gcC
 mcOnmohHIqydbImtvUpwotJnz6dQOSVCGbKGmGNHqdxZvpkLdWHjS
X-Received: by 2002:a05:600c:458c:b0:411:a751:322b with SMTP id
 r12-20020a05600c458c00b00411a751322bmr8199474wmo.18.1709058386470; 
 Tue, 27 Feb 2024 10:26:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1egIoBdItQyfZm5QzSVqI8pudnhxN32VJaNBgM7GodzEMTAXCUR2bxSxWLIf+nZz3JrXroQ==
X-Received: by 2002:a05:600c:458c:b0:411:a751:322b with SMTP id
 r12-20020a05600c458c00b00411a751322bmr8199458wmo.18.1709058386146; 
 Tue, 27 Feb 2024 10:26:26 -0800 (PST)
Received: from [192.168.2.121] (lfbn-cor-1-12-50.w86-211.abo.wanadoo.fr.
 [86.211.108.50]) by smtp.gmail.com with ESMTPSA id
 m4-20020a05600c280400b0040ecdd672fasm11802372wmb.13.2024.02.27.10.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 10:26:25 -0800 (PST)
Message-ID: <e4038d1e-68e7-42ae-a488-9a35e6236704@redhat.com>
Date: Tue, 27 Feb 2024 19:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] hw: Set virtio-iommu aw-bits default value on
 pc_q35 and arm virt
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, mst@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, yanghliu@redhat.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com
References: <20240215084315.863897-1-eric.auger@redhat.com>
 <20240215084315.863897-4-eric.auger@redhat.com>
 <2259fba1-4c57-420b-bcab-ecf202d10819@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <2259fba1-4c57-420b-bcab-ecf202d10819@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On 2/27/24 18:17, Cédric Le Goater wrote:
> Hello Eric,
>
> On 2/15/24 09:42, Eric Auger wrote:
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
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Tested-by: Yanghang Liu<yanghliu@redhat.com>
>
> We need a property fixup for pseries also:
>
> $ build/ppc64-softmmu/qemu-system-ppc64 -M pseries  -device
> virtio-iommu-pci,addr=04.0
> qemu-system-ppc64: -device virtio-iommu-pci,addr=04.0: aw-bits must be
> within [32,64]
after offline discssion with Cédric, despite the virtio-iommu-pci device
is not supported on ppc64 the
tests/qtest/qos-test attempts to execute the
tests/qtest/virtio-iommu-test.c because the machine has a pci bus. Since
by default the aw-bits is 0 the test fails. I need to rework that.
Thanks! Eric
>
>
> Thanks,
>
> C.
>
>
>
>> ---
>>
>> v3 -> v4:
>> - update the qos test to relax the check on the max input IOVA
>>
>> v2 -> v3:
>> - collected Zhenzhong's R-b
>> - use &error_abort instead of NULL error handle
>>    on object_property_get_uint() call (Cédric)
>> - use VTD_HOST_AW_39BIT (Cédric)
>>
>> v1 -> v2:
>> - set aw-bits to 48b on ARM
>> - use hw_compat_8_2 to handle the compat for older machines
>>    which used 64b as a default
>> ---
>>   hw/arm/virt.c                   | 6 ++++++
>>   hw/core/machine.c               | 5 ++++-
>>   hw/i386/pc.c                    | 6 ++++++
>>   hw/virtio/virtio-iommu.c        | 2 +-
>>   tests/qtest/virtio-iommu-test.c | 2 +-
>>   5 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 368c2a415a..0994f2a560 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2716,10 +2716,16 @@ static void
>> virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>           virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev),
>> MACHINE(hotplug_dev), errp);
>>       } else if (object_dynamic_cast(OBJECT(dev),
>> TYPE_VIRTIO_IOMMU_PCI)) {
>> +        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
>> +                                                   "aw-bits",
>> &error_abort);
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
>> index 196827531a..ee2d379c90 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1456,6 +1456,8 @@ static void
>> pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>           virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev),
>> MACHINE(hotplug_dev), errp);
>>       } else if (object_dynamic_cast(OBJECT(dev),
>> TYPE_VIRTIO_IOMMU_PCI)) {
>> +        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
>> +                                                   "aw-bits",
>> &error_abort);
>>           /* Declare the APIC range as the reserved MSI region */
>>           char *resv_prop_str =
>> g_strdup_printf("0xfee00000:0xfeefffff:%d",
>>                                                
>> VIRTIO_IOMMU_RESV_MEM_T_MSI);
>> @@ -1464,6 +1466,10 @@ static void
>> pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>           qlist_append_str(reserved_regions, resv_prop_str);
>>           qdev_prop_set_array(dev, "reserved-regions",
>> reserved_regions);
>>   +        if (!aw_bits) {
>> +            qdev_prop_set_uint8(dev, "aw-bits", VTD_HOST_AW_39BIT);
>> +        }
>> +
>>           g_free(resv_prop_str);
>>       }
>>   diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 8b541de850..2ec5ef3cd1 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -1526,7 +1526,7 @@ static Property virtio_iommu_properties[] = {
>>       DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>>                        TYPE_PCI_BUS, PCIBus *),
>>       DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>> -    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   diff --git a/tests/qtest/virtio-iommu-test.c
>> b/tests/qtest/virtio-iommu-test.c
>> index 068e7a9e6c..0f36381acb 100644
>> --- a/tests/qtest/virtio-iommu-test.c
>> +++ b/tests/qtest/virtio-iommu-test.c
>> @@ -34,7 +34,7 @@ static void pci_config(void *obj, void *data,
>> QGuestAllocator *t_alloc)
>>       uint8_t bypass = qvirtio_config_readb(dev, 36);
>>         g_assert_cmpint(input_range_start, ==, 0);
>> -    g_assert_cmphex(input_range_end, ==, UINT64_MAX);
>> +    g_assert_cmphex(input_range_end, >=, 32);
>>       g_assert_cmpint(domain_range_start, ==, 0);
>>       g_assert_cmpint(domain_range_end, ==, UINT32_MAX);
>>       g_assert_cmpint(bypass, ==, 1);
>


