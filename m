Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1ECC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 03:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWo94-0000Mk-Bg; Tue, 01 Jul 2025 23:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uWo93-0000MT-86
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 23:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uWo90-0008JF-Ue
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 23:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751426899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=853N4R697eBZZO041eDR7e7K85dVK+M5yMIc00G80mY=;
 b=BvdYh0R2bzsXv5BMv+MW1HPrP1yxRdSJOJGog3DX1XOfvTeouh1IsScdyA1uhzHPRy+ntB
 czMA5qekm78dWviT8JXkGWIbO2KWs6i3w3p0OFzOzNS32vHuWYww1U8zjrPg9fzNrNmywZ
 ltt5va9lSXtYRu9PruovtHUbjvrZdW8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-bo4KJRrqN4WGCyKFxKi70g-1; Tue, 01 Jul 2025 23:28:17 -0400
X-MC-Unique: bo4KJRrqN4WGCyKFxKi70g-1
X-Mimecast-MFC-AGG-ID: bo4KJRrqN4WGCyKFxKi70g_1751426897
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23507382e64so35488425ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 20:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751426897; x=1752031697;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=853N4R697eBZZO041eDR7e7K85dVK+M5yMIc00G80mY=;
 b=Pokynv0UIJMM6qU/6k5bxX3GvWw4GfHqHPgvx0SEZ+k/WixlRgoZzOXmWqV+eW9IYp
 UvwSajmmN6KvDrO8t8jCPOVjHBJaPlkJRIQANEXpXnuO3ZqugNcE05lkrTVTNaJpzh4K
 GyTwgqExG0jddKlgKzIHSg7QXOOMbPj+svIdtk+vsQXzu3rSxZJfgeX/yMaF18KK04oX
 DL+RDKC7CTasKX/RX1qUijm+3LCKOEx7Lq1n1HimJlv+FnFP2I1KAwhIMTFD75j30Wwo
 t85iwPZKSciuYf53bnKbq1ZHcoyLOUFo/P/H0q4sYGTG0WyHNP9QoOrA1pFDul+WJyda
 +ECg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoBtgRmAbn+gRbQ0wQaZNNV8QGVMOSZQHFD9BS0RIkOcT+eAM1EKCb2kng+wx8Bj3/oAyGClXGZXP/@nongnu.org
X-Gm-Message-State: AOJu0YzGwpblVtzXj7gRLmC8mQdwvhFS1mWfpKtw564udsNep5wkk58v
 6DcWd2ptAL6Jbhp/LS1hH/zKfF9j1IeTLCYeARc0TMrFQ2n6IglHBCjiJnD4LyFOqKkUQ4tV31q
 km9HdTQTxGQQ0tUKyUXtWp8BZWpl+lHBJKb8e2ipoQNbj0mlwPVMsJSgn
X-Gm-Gg: ASbGncuXuo0TEoYafNfjA2Ck47Vqk173qgzmH72k+n7pojweoPHJ17fUzUNL5bGnMNY
 MTnZ4SrEIXi8ZQElql9tjUU8DKt0yR9sp0yBhz1Y1MdJ9BADCp3dy26HIjTQkd5cCIxwEcmIJVl
 lQvGiK0mye4TxTXOeSQjUkSu1mqJnNjPxU2Iz+F87gNZKErDrnYcxKaGZodmF0S0TdySIyUjwJ8
 sE8Z0mO7xboVjWE3xjYSa32B5bt7F2mvTJoKza104053iqa2hcZ89Z6x8HqtFUzOGevn3hLKlIK
 TQ41saYURA8nF8Q++aJeJhxhSlc=
X-Received: by 2002:a17:902:eb8a:b0:235:be0:db4c with SMTP id
 d9443c01a7336-23c6e5c5103mr17570365ad.41.1751426896679; 
 Tue, 01 Jul 2025 20:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs2FZpsKkcnFcM+pWt03xaaOwC+cS7zIlthH6vxzy6hJFUov64SgPgpl/fT4a8Ap9y8v6BIw==
X-Received: by 2002:a17:902:eb8a:b0:235:be0:db4c with SMTP id
 d9443c01a7336-23c6e5c5103mr17569935ad.41.1751426896279; 
 Tue, 01 Jul 2025 20:28:16 -0700 (PDT)
Received: from [10.72.116.105] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c5a8csm119762655ad.223.2025.07.01.20.28.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 20:28:15 -0700 (PDT)
Message-ID: <e7f5a70d-a052-4d37-9cec-5c9595559de7@redhat.com>
Date: Wed, 2 Jul 2025 11:28:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] hw/i386: Add the ramfb romfile compatibility
From: Shaoqin Huang <shahuang@redhat.com>
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
 <6347e3a2-23f5-43a3-8b74-503148f3bacf@redhat.com>
Content-Language: en-US
In-Reply-To: <6347e3a2-23f5-43a3-8b74-503148f3bacf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/2/25 10:24 AM, Shaoqin Huang wrote:
> Hi Eric,
> 
> Thanks for your review.
> 
> On 7/1/25 1:17 PM, Eric Auger wrote:
>> Hi,
>>
>> On 7/1/25 5:05 AM, Shaoqin Huang wrote:
>>> Set the "use-legacy-x86-rom" property to false by default, and only set
>>> it to true on x86 since only x86 will need it.
>>>
>>> At the same time, set the "use-legacy-x86-rom" property to true on those
>>> historical versioned machine types in order to avoid the memory layout
>>> being changed.
>>>
>>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>>> ---
>>>   hw/core/machine.c             |  2 ++
>>>   hw/display/ramfb-standalone.c |  2 +-
>>>   hw/i386/pc_piix.c             | 10 ++++++++++
>>>   hw/i386/pc_q35.c              |  3 +++
>>>   hw/vfio/pci.c                 |  2 +-
>>>   5 files changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>> index 63c6ef93d2..349aec1e0d 100644
>>> --- a/hw/core/machine.c
>>> +++ b/hw/core/machine.c
>>> @@ -46,6 +46,8 @@ GlobalProperty hw_compat_9_2[] = {
>>>       { "migration", "multifd-clean-tls-termination", "false" },
>>>       { "migration", "send-switchover-start", "off"},
>>>       { "vfio-pci", "x-migration-multifd-transfer", "off" },
>>> +    { "ramfb", "use-legacy-x86-rom", "true"},
>>> +    { "vfio-pci", "use-legacy-x86-rom", "true" },
>> why 9.2? The 10.0 machine type should also apply the previous "true"
>> default setting. To me the new default shall only affect the latest 10.1
>> machine type.
> 
> It seems what I understand is wrong, I thought the 9.2 is the historical 
> machine type.
> 
> 10.0 machine type is the current machine type, it also should be 
> included into the historical machine type when we add the property.
> 
> ok I will update it again with add those property into 10.0 machine type.
> 
> Thanks

One more question, now the qemu doesn't have the hw_compat_10_1, should 
I first add another patch to add it just like the commit:
0a7c438a42 hw: add compat machines for 10.0

I think it should have the hw_compat_10_1 first, then I can add the 
property into it.

Thanks,
Shaoqin

> 
>>>   };
>>>   const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>>> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb- 
>>> standalone.c
>>> index af1175bf96..ddbf42f181 100644
>>> --- a/hw/display/ramfb-standalone.c
>>> +++ b/hw/display/ramfb-standalone.c
>>> @@ -63,7 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>>>   static const Property ramfb_properties[] = {
>>>       DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  
>>> true),
>>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, 
>>> use_legacy_x86_rom, true),
>>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, 
>>> use_legacy_x86_rom, false),
>>>   };
>>>   static void ramfb_class_initfn(ObjectClass *klass, void *data)
>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>> index 6c91e2d292..4a8bbc0e28 100644
>>> --- a/hw/i386/pc_piix.c
>>> +++ b/hw/i386/pc_piix.c
>>> @@ -49,6 +49,7 @@
>>>   #include "hw/i2c/smbus_eeprom.h"
>>>   #include "exec/memory.h"
>>>   #include "hw/acpi/acpi.h"
>>> +#include "hw/vfio/pci.h"
>>>   #include "qapi/error.h"
>>>   #include "qemu/error-report.h"
>>>   #include "system/xen.h"
>>> @@ -77,6 +78,13 @@ static const int ide_iobase2[MAX_IDE_BUS] = 
>>> { 0x3f6, 0x376 };
>>>   static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>>>   #endif
>>> +static GlobalProperty pc_piix_compat_defaults[] = {
>>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>>> +};
>>> +static const size_t pc_piix_compat_defaults_len =
>>> +    G_N_ELEMENTS(pc_piix_compat_defaults);
>>> +
>>>   /*
>>>    * Return the global irq number corresponding to a given device irq
>>>    * pin. We could also use the bus number to have a more precise 
>>> mapping.
>>> @@ -477,6 +485,8 @@ static void 
>>> pc_i440fx_machine_options(MachineClass *m)
>>>                                      pc_set_south_bridge);
>>>       object_class_property_set_description(oc, "x-south-bridge",
>>>                                        "Use a different south bridge 
>>> than PIIX3");
>>> +    compat_props_add(m->compat_props,
>>> +                     pc_piix_compat_defaults, 
>>> pc_piix_compat_defaults_len);
>>>   }
>>>   static void pc_i440fx_machine_10_0_options(MachineClass *m)
>>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>>> index fd96d0345c..f6d89578d0 100644
>>> --- a/hw/i386/pc_q35.c
>>> +++ b/hw/i386/pc_q35.c
>>> @@ -45,6 +45,7 @@
>>>   #include "hw/i386/pc.h"
>>>   #include "hw/i386/amd_iommu.h"
>>>   #include "hw/i386/intel_iommu.h"
>>> +#include "hw/vfio/pci.h"
>>>   #include "hw/virtio/virtio-iommu.h"
>>>   #include "hw/display/ramfb.h"
>>>   #include "hw/ide/pci.h"
>>> @@ -67,6 +68,8 @@
>>>   static GlobalProperty pc_q35_compat_defaults[] = {
>>>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
>>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>> I hope we do not omit any other machine that would actually need ramfb
>> rom. At the moment we take care of q35 and  piix. Anyone aware of any
>> other user?
>>
>> Thanks
>>
>> Eric
>>>   };
>>>   static const size_t pc_q35_compat_defaults_len =
>>>       G_N_ELEMENTS(pc_q35_compat_defaults);
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index ff0d93fae0..a529500b70 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3564,7 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>>   static const Property vfio_pci_dev_nohotplug_properties[] = {
>>>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, 
>>> use_legacy_x86_rom, true),
>>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, 
>>> use_legacy_x86_rom, false),
>>>       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, 
>>> ramfb_migrate,
>>>                               ON_OFF_AUTO_AUTO),
>>>   };
>>
> 

-- 
Shaoqin


