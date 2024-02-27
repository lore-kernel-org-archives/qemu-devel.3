Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118BFC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf1QO-00082R-Rd; Tue, 27 Feb 2024 12:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rf1QM-00080k-7u
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rf1QK-0004Za-CL
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709055563;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqB5Q3vNJeH/DB+uAKbvKtqjIFJycTqicyqQkGLDxgQ=;
 b=Bq1tRNyaPoYCGBuOE6cqr+eeVvGxxPidDOUcwmBvlqMU3M7axpCWepncxoKAAOzrcJeb+d
 lly/lz5xBU+577MXBp6cc/scFBtmUm1vgcMZWp4muk6UNnfsWmaLTv17vhGKyVCjTp8fTa
 RFMCLyDUp6H0/PusBbaRLf9zN/DcxB4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-m7YIPyOmNxuell4GX4eRrg-1; Tue, 27 Feb 2024 12:39:22 -0500
X-MC-Unique: m7YIPyOmNxuell4GX4eRrg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-42e2506ac53so75513891cf.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 09:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709055562; x=1709660362;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iqB5Q3vNJeH/DB+uAKbvKtqjIFJycTqicyqQkGLDxgQ=;
 b=M5sKASQDHoda7sbTr+G8Lutrjz6rlZ28jAKr0SBJgH/BZ84GrsDtVRYYAUpA0MOMbk
 wNHCpcNZQ7mAExYAWv2dvPYjaV/38CbJ/Ed+PcoW9EIwDzSSmtmhZsje7uWn92kRF64F
 pRs5oVlf8cg4z6H+Msu604sKnM38Tl200SqsapXJkKU2UmMn2r9OtcT3F2cHHLmD5Eou
 YamRuGrXgnxVzf6n/w/yR7IMgj94T0u2APyaOrq9RDy1jqtcH3pXKOi7QxRR64NdkjyK
 sNE4K1OzYr+fWL1tzc2yhK4fliasF7jG30aqKLNKNfeXtgXRCT867jxGbGhgZa9MRCSm
 SCSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeHAjkd89E7kNI0MMv9NXD+h/2qCun2UaI7fUoKusZEVAIJjz2UJTlCqXamh5Oo4tDvcUlIVMrS4auqs8gH0UtSUjvAGs=
X-Gm-Message-State: AOJu0YyOmyeqpvfjoq0S4ZF8K4zoerkAdpwbtv4OnCS0MhaAfz5XSzgK
 CcxehuqGSDgrG1H3Ijj2+07IOoSqyAIsEmz1r7SSBF4cSUXWQfseKQPPm+hfYyXQ+eseUTY9UTd
 b1br7VOJacpPPPU+P4xLLQ9TNIkeJEC1CMzxzwB/kNBObN/xVVzme
X-Received: by 2002:a05:622a:393:b0:42e:8f35:cd6e with SMTP id
 j19-20020a05622a039300b0042e8f35cd6emr5320662qtx.9.1709055561796; 
 Tue, 27 Feb 2024 09:39:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHZ3RjmHgE6yQdIlgMkcjttHIBTYJaRzAjen+dYPvDBEb/jz4jMcqok6o70x8r/t4FSj4foQ==
X-Received: by 2002:a05:622a:393:b0:42e:8f35:cd6e with SMTP id
 j19-20020a05622a039300b0042e8f35cd6emr5320630qtx.9.1709055561389; 
 Tue, 27 Feb 2024 09:39:21 -0800 (PST)
Received: from [192.168.2.121] (lfbn-cor-1-12-50.w86-211.abo.wanadoo.fr.
 [86.211.108.50]) by smtp.gmail.com with ESMTPSA id
 q17-20020ac87351000000b0042e851b63e1sm2317290qtp.43.2024.02.27.09.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 09:39:20 -0800 (PST)
Message-ID: <7797a7a8-1754-40e1-a580-895bbb4546ed@redhat.com>
Date: Tue, 27 Feb 2024 18:39:15 +0100
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
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Cédric,

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

as stated in the doc (now! see [PATCH v5 4/4] qemu-options.hx: Add an
entry for virtio-iommu-pci and document aw-bits) , the virtio-iommu-pci
device only is supported in q35 and arm virt.

If you want to support virtio-iommu on other machines, you need to take
care of this aw-bits settings and also of the exposed reserved regions.

Thanks

Eric
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


