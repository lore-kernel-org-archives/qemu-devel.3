Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB1FC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 08:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhmNM-0005Wi-VX; Wed, 06 Mar 2024 03:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rhmNM-0005Wa-4C
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 03:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rhmNJ-0007tL-CT
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 03:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709712699;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbrxjbmwzxOLAsI68/9/0zanrrJV5hOKAirB2YP4Sog=;
 b=MFOmAu+9K80SVI5h3CrQzseUGTc2+SsfaEG3NU1MAqaDLm0TJr9SE0bjjadotFJ70ASEx5
 C/JnVLtHxKamRCdQ2Eo65Mkn3+HPQSeawoVZ6PV01hHczdrUJE/BQxep3CJ0jxGbuTbCS0
 /KHUDrjkS3iK6wasxRFQHfD5AKIFubg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-Az59hSAoOvWM25jmRdQ6Vg-1; Wed, 06 Mar 2024 03:11:38 -0500
X-MC-Unique: Az59hSAoOvWM25jmRdQ6Vg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-787d3b9ad5dso751768685a.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 00:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709712696; x=1710317496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HbrxjbmwzxOLAsI68/9/0zanrrJV5hOKAirB2YP4Sog=;
 b=p0Mbw7kLGK1BGmdXc26z0sJqXlSa9NBwi/qsP6Ci1cwBVHwsFTvXOQzf/nrURScJhm
 ObIjZwUVrFl3SDs7X7WSJvi+5roMHRcwcW+wkz0NM07ODW7QYUALZ0xaXwAMHMMCUBrw
 Jorbe5/CEYEJcL04uIXVsF96NnU+e0+rtaRL6pm/6cmeNxAwpuc5qnGp2Xda4kGwT/qG
 e3JE4fufunjsMlRw63PiyPTAwKE43CKMjKpXxKyiwheCFQTTAvyhC1N6inc3ROlZc9ji
 VSQtAA8QJBseoi5LTZObJ/Yjv9Yh6WmKl7Hharn4ikOkFDufy+CECcOHIkq/6+ocZatW
 i6bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/cxWLHqoxNlhMQkLFvlNLFLTOAgwTE7Jkzs0l/vewGoTepRJKQzeaMpqm6KkYqqr+eIIKiPV6g6E/FIwjHCGMk1EETUQ=
X-Gm-Message-State: AOJu0YxAMTeA4GoTIgOEuxXfuEsaNadrZpIVO8z7Vjz/D2nTtddgO2R2
 dM37eF7pOvlKBXHSi9hrV2MibaAuTKfgiwSFa+nzyEkN5rG+zwg3z1oFf+/w+ds8ScwYRG3sEM+
 86T9STWZJCp9a+0s9+4IyvXddMjfTwX5bPEzpA0ctFMoE3lrhwbA+
X-Received: by 2002:a05:620a:8309:b0:788:31c7:ceb5 with SMTP id
 pa9-20020a05620a830900b0078831c7ceb5mr3757706qkn.30.1709712695929; 
 Wed, 06 Mar 2024 00:11:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7luoGci5+nspDLz/M5mc5L2Mwbv93T1f1q2bfThr7b+27WoLeSU6cYYVgH+CwSgLG0sWgsw==
X-Received: by 2002:a05:620a:8309:b0:788:31c7:ceb5 with SMTP id
 pa9-20020a05620a830900b0078831c7ceb5mr3757693qkn.30.1709712695622; 
 Wed, 06 Mar 2024 00:11:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a05620a400100b007881fbfea7bsm3867890qko.24.2024.03.06.00.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 00:11:35 -0800 (PST)
Message-ID: <83d37a18-ed8d-42d2-8272-6f95a637a0e9@redhat.com>
Date: Wed, 6 Mar 2024 09:11:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] hw/i386/q35: Set virtio-iommu aw-bits default
 value to 39
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20240305180734.48515-1-eric.auger@redhat.com>
 <20240305180734.48515-8-eric.auger@redhat.com>
 <SJ0PR11MB67443EC0B600D02A773AD20792212@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67443EC0B600D02A773AD20792212@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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

Hi Zhenzhong,

On 3/6/24 04:15, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [PATCH v6 7/9] hw/i386/q35: Set virtio-iommu aw-bits default
>> value to 39
>>
>> Currently the default input range can extend to 64 bits. On x86,
>> when the virtio-iommu protects vfio devices, the physical iommu
>> may support only 39 bits. Let's set the default to 39, as done
>> for the intel-iommu.
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
>> v5 -> v6:
>> - split pc/arm settings
>>
>> v3 -> v4:
>> - update the qos test to relax the check on the max input IOVA
>>
>> v2 -> v3:
>> - collected Zhenzhong's R-b
>> - use &error_abort instead of NULL error handle
>>  on object_property_get_uint() call (Cédric)
>> - use VTD_HOST_AW_39BIT (Cédric)
>>
>> v1 -> v2:
>> - set aw-bits to 48b on ARM
>> - use hw_compat_8_2 to handle the compat for older machines
>>  which used 64b as a default
>> ---
>> include/hw/i386/pc.h            | 3 +++
>> hw/core/machine.c               | 1 +
>> hw/i386/pc.c                    | 6 ++++++
>> hw/i386/pc_q35.c                | 2 ++
>> tests/qtest/virtio-iommu-test.c | 2 +-
>> 5 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 5065590281..b3229f98de 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -198,6 +198,9 @@ void pc_system_parse_ovmf_flash(uint8_t
>> *flash_ptr, size_t flash_size);
>> /* sgx.c */
>> void pc_machine_init_sgx_epc(PCMachineState *pcms);
>>
>> +extern GlobalProperty pc_compat_defaults[];
>> +extern const size_t pc_compat_defaults_len;
> If we only want to support q35 and not i440fx, better to add _q35 suffix and move into pc_q35.c and made static?
Sure. I was initially following Igor's suggestion but it makes sense to
restrict to q35 and turn in static I think.
>
>> +
>> extern GlobalProperty pc_compat_8_2[];
>> extern const size_t pc_compat_8_2_len;
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 6bd09d4592..4b89172d1c 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -35,6 +35,7 @@
>>
>> GlobalProperty hw_compat_8_2[] = {
>>     { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
>> +    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
>> };
>> const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index f5ff970acf..9024483356 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -59,6 +59,7 @@
>> #include "hw/i386/kvm/xen_evtchn.h"
>> #include "hw/i386/kvm/xen_gnttab.h"
>> #include "hw/i386/kvm/xen_xenstore.h"
>> +#include "hw/i386/intel_iommu.h"
> This can be removed?
yes
>
>> #include "hw/mem/memory-device.h"
>> #include "e820_memory_layout.h"
>> #include "trace.h"
>> @@ -78,6 +79,11 @@
>>     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version "
>> v, },\
>>     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
>>
>> +GlobalProperty pc_compat_defaults[] =  {
>> +    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
>> +};
>> +const size_t pc_compat_defaults_len =
>> G_N_ELEMENTS(pc_compat_defaults);
>> +
>> GlobalProperty pc_compat_8_2[] = {};
>> const size_t pc_compat_8_2_len = G_N_ELEMENTS(pc_compat_8_2);
>>
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 45a4102e75..32421a0a5f 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -356,6 +356,8 @@ static void pc_q35_machine_options(MachineClass
>> *m)
>>     machine_class_allow_dynamic_sysbus_dev(m,
>> TYPE_INTEL_IOMMU_DEVICE);
>>     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>>     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
>> +    compat_props_add(m->compat_props,
>> +                     pc_compat_defaults, pc_compat_defaults_len);
>> }
>>
>> static void pc_q35_9_0_machine_options(MachineClass *m)
>> diff --git a/tests/qtest/virtio-iommu-test.c b/tests/qtest/virtio-iommu-test.c
>> index 068e7a9e6c..0f36381acb 100644
>> --- a/tests/qtest/virtio-iommu-test.c
>> +++ b/tests/qtest/virtio-iommu-test.c
>> @@ -34,7 +34,7 @@ static void pci_config(void *obj, void *data,
>> QGuestAllocator *t_alloc)
>>     uint8_t bypass = qvirtio_config_readb(dev, 36);
>>
>>     g_assert_cmpint(input_range_start, ==, 0);
>> -    g_assert_cmphex(input_range_end, ==, UINT64_MAX);
>> +    g_assert_cmphex(input_range_end, >=, 32);
> UINT32_MAX?
sure!

Thank you for the review!

Eric
>
> Thanks
> Zhenzhong
>
>>     g_assert_cmpint(domain_range_start, ==, 0);
>>     g_assert_cmpint(domain_range_end, ==, UINT32_MAX);
>>     g_assert_cmpint(bypass, ==, 1);
>> --
>> 2.41.0


