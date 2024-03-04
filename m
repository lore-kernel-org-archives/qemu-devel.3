Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530CFC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCFe-00063D-Hr; Mon, 04 Mar 2024 12:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rhCFb-00060v-6z
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:37:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rhCFY-0001mJ-I1
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709573835;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wyjz8u7HbCmwkkAMVB4v7e6D2/ijI/Pv8npHV6wSSOY=;
 b=QNNE9amatoc/BztAfArHhoiVHW4FtJNqAwxhcvD6pZ1dF/bclgXtdnwgZtZR8UK8U8WXLb
 zwrqEccz2GPejypTm5OjZ31GcC47JQKLrUH1hSKNvwVMenZUkeWSPPM/VuiL5shboiok2J
 qTz44O5qnMskiJgntg289BcnIo7fgs8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-_XRTrVk8Mv2FW5TfAEahxw-1; Mon, 04 Mar 2024 12:37:13 -0500
X-MC-Unique: _XRTrVk8Mv2FW5TfAEahxw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-69078fb1cd9so9937986d6.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709573833; x=1710178633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wyjz8u7HbCmwkkAMVB4v7e6D2/ijI/Pv8npHV6wSSOY=;
 b=SO4mLd8NDehG6AQ8SPKVie4fRx3jGL2cvCF7QVYj6rxYHe3brKxlJU2dTMppgiro4g
 Hh6MZ5qGraAoTloApPZOhuYNszAMfIBPSSobbFhtrXA4RcqCoSMATSXdbBrLzFKSvyDu
 JjziTkGkASSLZVe/mKpzGN5auY9Hp2SglymiMic09adA+GqDMRWm7cSYITPI24v7gefO
 TVJe+Q2eJgHvbVXpU2b8lE6zounOBc6gcay+STUA/HLycBdnTxMn7IA45J9hwQxG3A1A
 CPuyFzW4bummau9b9a2xNN0RBcWHHo2EampHWUEdhjuJC3X9Eez6TcJefGTb8VLSoocZ
 TqsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYjn1vwZljLdwaucFIV+FTYn9yLeCzx+77ENMxkA88nMMplbB6vvEhuHVkf4Bt5xH4hYKas/S7ZBs2z9HUcT8DTh8dblA=
X-Gm-Message-State: AOJu0YxWKh1oePKFEbj1k/02ue3nvshACjwab2G1gFEw4yzcfijXaISw
 CVgSR6+FPzOyp9ChyKBSA2jIyrqLn5uFAZDJzLaNHEx+61pMuY4kEYawqk9Gr309fOPIQ4W57df
 A/XOSdufo71Xd2K48y5Vj+rE410QZnNU6Vi6gVi7d23fHkoA8I3MO
X-Received: by 2002:ad4:4f14:0:b0:690:57bc:643b with SMTP id
 fb20-20020ad44f14000000b0069057bc643bmr8940228qvb.13.1709573833164; 
 Mon, 04 Mar 2024 09:37:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbzi9s9GoH6qsqYGKiZCfagQHG17YjZ9ZrTPKXH8gzd/hLWWLB5OxQ0IGDlyc5gM/PjFznng==
X-Received: by 2002:ad4:4f14:0:b0:690:57bc:643b with SMTP id
 fb20-20020ad44f14000000b0069057bc643bmr8940193qvb.13.1709573832751; 
 Mon, 04 Mar 2024 09:37:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ld8-20020a056214418800b0068fef1264f6sm5253965qvb.101.2024.03.04.09.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 09:37:12 -0800 (PST)
Message-ID: <d7883713-0695-4346-b7d1-8beac6525def@redhat.com>
Date: Mon, 4 Mar 2024 18:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] hw: Set virtio-iommu aw-bits default value on
 pc_q35 and arm virt
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, mst@redhat.com, peter.maydell@linaro.org,
 clg@redhat.com, zhenzhong.duan@intel.com, yanghliu@redhat.com,
 alex.williamson@redhat.com, jasowang@redhat.com
References: <20240215084315.863897-1-eric.auger@redhat.com>
 <20240215084315.863897-4-eric.auger@redhat.com>
 <20240229102014.6c5e9f74@imammedo.users.ipa.redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240229102014.6c5e9f74@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

Hi Igor,

On 2/29/24 10:20, Igor Mammedov wrote:
> On Thu, 15 Feb 2024 09:42:13 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Currently the default input range can extend to 64 bits. On x86,
>> when the virtio-iommu protects vfio devices, the physical iommu
>> may support only 39 bits. Let's set the default to 39, as done
>> for the intel-iommu. On ARM we set 48b as a default (matching
>> SMMUv3 SMMU_IDR5.VAX == 0).
>>
>> We use hw_compat_8_2 to handle the compatibility for machines
>> before 9.0 which used to have a virtio-iommu default input range
>> of 64 bits.
> so we have different defaults per target/machine
> while open codding fixup in _pre_plug_ works it's
> a bit unexpected place to manage defaults and
> avoid adding 0 magic.
>
> How about using compat machinery instead to set
> machine dependent defaults:
> For example:
>
> pc_i440fx_machine_options(MachineClass *m)
> {
> ...
> +    compat_props_add(m->compat_props, pc_compat_defaults,pc_compat_defaults_len);
>  }
Yes I can go this way.
>
>> Of course if aw-bits is set from the command line, the default
>> is overriden.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Tested-by: Yanghang Liu<yanghliu@redhat.com>
>>
>> ---
>>
>> v3 -> v4:
>> - update the qos test to relax the check on the max input IOVA
>>
>> v2 -> v3:
>> - collected Zhenzhong's R-b
>> - use &error_abort instead of NULL error handle
>>   on object_property_get_uint() call (Cédric)
>> - use VTD_HOST_AW_39BIT (Cédric)
>>
>> v1 -> v2:
>> - set aw-bits to 48b on ARM
>> - use hw_compat_8_2 to handle the compat for older machines
>>   which used 64b as a default
>> ---
>>  hw/arm/virt.c                   | 6 ++++++
>>  hw/core/machine.c               | 5 ++++-
>>  hw/i386/pc.c                    | 6 ++++++
>>  hw/virtio/virtio-iommu.c        | 2 +-
>>  tests/qtest/virtio-iommu-test.c | 2 +-
>>  5 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 368c2a415a..0994f2a560 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2716,10 +2716,16 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>          virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>> +        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
>> +                                                   "aw-bits", &error_abort);
>>          hwaddr db_start = 0, db_end = 0;
>>          QList *reserved_regions;
>>          char *resv_prop_str;
>>  
>> +        if (!aw_bits) {
>> +            qdev_prop_set_uint8(dev, "aw-bits", 48);
> s/48/macro name/?
with compats it becomes a string.  So I cannot directly reuse X86_64 VTD
or ARM SMMU macros. I would introduce a dummy VIRTIO_IOMMU string which
does not sound really helpful.
>
>> +        }
>>
>>
>>          if (vms->iommu != VIRT_IOMMU_NONE) {
>>              error_setg(errp, "virt machine does not support multiple IOMMUs");
>>              return;
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index fb5afdcae4..70ac96954c 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -30,9 +30,12 @@
>>  #include "exec/confidential-guest-support.h"
>>  #include "hw/virtio/virtio-pci.h"
>>  #include "hw/virtio/virtio-net.h"
>> +#include "hw/virtio/virtio-iommu.h"
>>  #include "audio/audio.h"
>>  
>> -GlobalProperty hw_compat_8_2[] = {};
>> +GlobalProperty hw_compat_8_2[] = {
>> +    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
>> +};
>>  const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
>>  
>>  GlobalProperty hw_compat_8_1[] = {
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 196827531a..ee2d379c90 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1456,6 +1456,8 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>          virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>> +        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
>> +                                                   "aw-bits", &error_abort);
>>          /* Declare the APIC range as the reserved MSI region */
>>          char *resv_prop_str = g_strdup_printf("0xfee00000:0xfeefffff:%d",
>>                                                VIRTIO_IOMMU_RESV_MEM_T_MSI);
>> @@ -1464,6 +1466,10 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>          qlist_append_str(reserved_regions, resv_prop_str);
>>          qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>>  
>> +        if (!aw_bits) {
>> +            qdev_prop_set_uint8(dev, "aw-bits", VTD_HOST_AW_39BIT);
>> +        }
>> +
>>          g_free(resv_prop_str);
>>      }
>>  
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 8b541de850..2ec5ef3cd1 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -1526,7 +1526,7 @@ static Property virtio_iommu_properties[] = {
>>      DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>>                       TYPE_PCI_BUS, PCIBus *),
>>      DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>> -    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
> I'd set some valid value here (obviously not universal) and skip
> default property setting for that machine/target
> For example pick x86 one.
Yes the purpose is to have a non null aw_bits value which makes the
virtio-iommu unusable without proper machine integration and puts the
mess on the libqos tests. 
>
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>  
>> diff --git a/tests/qtest/virtio-iommu-test.c b/tests/qtest/virtio-iommu-test.c
>> index 068e7a9e6c..0f36381acb 100644
>> --- a/tests/qtest/virtio-iommu-test.c
>> +++ b/tests/qtest/virtio-iommu-test.c
>> @@ -34,7 +34,7 @@ static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
>>      uint8_t bypass = qvirtio_config_readb(dev, 36);
>>  
>>      g_assert_cmpint(input_range_start, ==, 0);
>> -    g_assert_cmphex(input_range_end, ==, UINT64_MAX);
>> +    g_assert_cmphex(input_range_end, >=, 32);
>>      g_assert_cmpint(domain_range_start, ==, 0);
>>      g_assert_cmpint(domain_range_end, ==, UINT32_MAX);
>>      g_assert_cmpint(bypass, ==, 1);
Thank you for the suggestions

Eric


