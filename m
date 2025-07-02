Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFEEC8303D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 02:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWn9Y-0002C4-3I; Tue, 01 Jul 2025 22:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uWn9W-0002Bs-Gq
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uWn9P-0001H5-2T
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751423079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Tsp9dzizK+AtKctxeLQzqRqxNRLoIZa766o0sMJY24=;
 b=f5nILZIhm8By4yvZHVTbbrRdT382UgIegooXbldT2xwq2SypXhGVoYMTDVW2LFs/pnI5Su
 c5lmrlbA3s/lwTGI5n2E85wxgD1j5xUXJOjJkY3X+348JYogh+KUYXklGCiH1BGMXRUtN4
 M5ZevaoRxrQldt2XE1ShRBy15a8fViE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-Qmguk4PnNyOaKWVjZPRQQA-1; Tue, 01 Jul 2025 22:24:38 -0400
X-MC-Unique: Qmguk4PnNyOaKWVjZPRQQA-1
X-Mimecast-MFC-AGG-ID: Qmguk4PnNyOaKWVjZPRQQA_1751423077
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7489ac848f3so6399374b3a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 19:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751423077; x=1752027877;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Tsp9dzizK+AtKctxeLQzqRqxNRLoIZa766o0sMJY24=;
 b=lcOr+fqlg/m5gRC7hbCvoKghDNLM/iCcGvXGBkk+R+K65Grb+NJv/uJIy2CsHZ63il
 spHT0RvoH83Q6LY9MlkkFF8fJPIwvMKGSfrk2e2K5J/Nr1P9Z4Dfqit0acW2g3GAwz6M
 ZTnTrMqdwwgWfZQ1WCfCHedlRdBvSWISXAar2BBW1zi5Kz2GnBzIrGZyBQGWlVlaYbYE
 mNhhFX4e3tVo4Fx6nQG/vY7wc9UDoo49ND2XbSfLxwbaWSHt4BPZx9NACWlB4X53I26l
 NuvCHN30N3dONM8Gtu0dm3jtYBYScS8kiJ9isUCxgFdGzWV+0tMbkBkvPZRtfb80RPgf
 BD1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5FPar32Yz/tsR/wBxCw/Dl7LuN4T3fx9z46xxppMiEOJ65Uye+oF0uHwRM/dAbdHQQ8wM8mrPRps9@nongnu.org
X-Gm-Message-State: AOJu0Yy/GIdRbePcCBGCea0LcHomFIkb46o0gUlRxJW9WaYG7/HPfFwa
 2i7ukNocrNmuJQ+Vdf5BXaFDKPdaGVpO/I1B4tByGW4u9nTOfLBZIOkfMfAISFTAXLajQvnpRBN
 znKapIseV+e3HjodX3+OSc7larxU9c/XuJtdmpEfO2XjkjrAw3oG/QIX3
X-Gm-Gg: ASbGncvYCQXF/SoeTyC22PqShiuskG2zrbeE2C8BLeBnJ6FAoSiiqXWrGXWuY0IrHR9
 hsPRJ+BVh42Zt74riJUBx6MEANUtMqrfW2HT0az8pVMHB31StPeQhrDJUbG5YOyeCtza+pFhrqE
 ZfQLMx9U4k1xMW2kpYtHm0L/2laSKAk3CadFu6hpgiuASNdbHrYyjS7buwOqm6ha3LlXFcrL/wi
 u5L8PDpo/ZenW//leB+UEypG28+Tljtbym+ZxKc03nN4i9m7WmONIpQDq/Gww+9B0WtBv0usR1b
 PQHyB84SlVFzIBk6uKTTfCujPbI=
X-Received: by 2002:a05:6a00:1910:b0:748:4652:bff4 with SMTP id
 d2e1a72fcca58-74b5149c0f6mr1573727b3a.13.1751423077438; 
 Tue, 01 Jul 2025 19:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJRdSTMgF7TAQ4v2+z8A07Dixc8z9orv1KsD4yhCe8qGhY5ZqZ7Ymcfx2Egzupj2vvQePd0A==
X-Received: by 2002:a05:6a00:1910:b0:748:4652:bff4 with SMTP id
 d2e1a72fcca58-74b5149c0f6mr1573683b3a.13.1751423077060; 
 Tue, 01 Jul 2025 19:24:37 -0700 (PDT)
Received: from [10.72.116.105] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af541c399sm13288493b3a.52.2025.07.01.19.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 19:24:36 -0700 (PDT)
Message-ID: <6347e3a2-23f5-43a3-8b74-503148f3bacf@redhat.com>
Date: Wed, 2 Jul 2025 10:24:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] hw/i386: Add the ramfb romfile compatibility
To: Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250701030549.2153331-1-shahuang@redhat.com>
 <20250701030549.2153331-3-shahuang@redhat.com>
 <9bbaa0bb-cf32-48f2-aff6-6484285496f0@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <9bbaa0bb-cf32-48f2-aff6-6484285496f0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Eric,

Thanks for your review.

On 7/1/25 1:17 PM, Eric Auger wrote:
> Hi,
> 
> On 7/1/25 5:05 AM, Shaoqin Huang wrote:
>> Set the "use-legacy-x86-rom" property to false by default, and only set
>> it to true on x86 since only x86 will need it.
>>
>> At the same time, set the "use-legacy-x86-rom" property to true on those
>> historical versioned machine types in order to avoid the memory layout
>> being changed.
>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>>   hw/core/machine.c             |  2 ++
>>   hw/display/ramfb-standalone.c |  2 +-
>>   hw/i386/pc_piix.c             | 10 ++++++++++
>>   hw/i386/pc_q35.c              |  3 +++
>>   hw/vfio/pci.c                 |  2 +-
>>   5 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 63c6ef93d2..349aec1e0d 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -46,6 +46,8 @@ GlobalProperty hw_compat_9_2[] = {
>>       { "migration", "multifd-clean-tls-termination", "false" },
>>       { "migration", "send-switchover-start", "off"},
>>       { "vfio-pci", "x-migration-multifd-transfer", "off" },
>> +    { "ramfb", "use-legacy-x86-rom", "true"},
>> +    { "vfio-pci", "use-legacy-x86-rom", "true" },
> why 9.2? The 10.0 machine type should also apply the previous "true"
> default setting. To me the new default shall only affect the latest 10.1
> machine type.

It seems what I understand is wrong, I thought the 9.2 is the historical 
machine type.

10.0 machine type is the current machine type, it also should be 
included into the historical machine type when we add the property.

ok I will update it again with add those property into 10.0 machine type.

Thanks

>>   };
>>   const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>>   
>> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
>> index af1175bf96..ddbf42f181 100644
>> --- a/hw/display/ramfb-standalone.c
>> +++ b/hw/display/ramfb-standalone.c
>> @@ -63,7 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>>   
>>   static const Property ramfb_properties[] = {
>>       DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, true),
>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, false),
>>   };
>>   
>>   static void ramfb_class_initfn(ObjectClass *klass, void *data)
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 6c91e2d292..4a8bbc0e28 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -49,6 +49,7 @@
>>   #include "hw/i2c/smbus_eeprom.h"
>>   #include "exec/memory.h"
>>   #include "hw/acpi/acpi.h"
>> +#include "hw/vfio/pci.h"
>>   #include "qapi/error.h"
>>   #include "qemu/error-report.h"
>>   #include "system/xen.h"
>> @@ -77,6 +78,13 @@ static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
>>   static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>>   #endif
>>   
>> +static GlobalProperty pc_piix_compat_defaults[] = {
>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>> +};
>> +static const size_t pc_piix_compat_defaults_len =
>> +    G_N_ELEMENTS(pc_piix_compat_defaults);
>> +
>>   /*
>>    * Return the global irq number corresponding to a given device irq
>>    * pin. We could also use the bus number to have a more precise mapping.
>> @@ -477,6 +485,8 @@ static void pc_i440fx_machine_options(MachineClass *m)
>>                                      pc_set_south_bridge);
>>       object_class_property_set_description(oc, "x-south-bridge",
>>                                        "Use a different south bridge than PIIX3");
>> +    compat_props_add(m->compat_props,
>> +                     pc_piix_compat_defaults, pc_piix_compat_defaults_len);
>>   }
>>   
>>   static void pc_i440fx_machine_10_0_options(MachineClass *m)
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index fd96d0345c..f6d89578d0 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -45,6 +45,7 @@
>>   #include "hw/i386/pc.h"
>>   #include "hw/i386/amd_iommu.h"
>>   #include "hw/i386/intel_iommu.h"
>> +#include "hw/vfio/pci.h"
>>   #include "hw/virtio/virtio-iommu.h"
>>   #include "hw/display/ramfb.h"
>>   #include "hw/ide/pci.h"
>> @@ -67,6 +68,8 @@
>>   
>>   static GlobalProperty pc_q35_compat_defaults[] = {
>>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
> I hope we do not omit any other machine that would actually need ramfb
> rom. At the moment we take care of q35 and  piix. Anyone aware of any
> other user?
> 
> Thanks
> 
> Eric
>>   };
>>   static const size_t pc_q35_compat_defaults_len =
>>       G_N_ELEMENTS(pc_q35_compat_defaults);
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index ff0d93fae0..a529500b70 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3564,7 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>   
>>   static const Property vfio_pci_dev_nohotplug_properties[] = {
>>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, true),
>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, false),
>>       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>>                               ON_OFF_AUTO_AUTO),
>>   };
> 

-- 
Shaoqin


