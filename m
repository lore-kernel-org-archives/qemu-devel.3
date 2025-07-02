Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC58C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 09:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWtlW-0002yy-TK; Wed, 02 Jul 2025 05:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uWtlS-0002yT-4M
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uWtlP-0002Qv-Cz
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751448493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rGpk6T8lyk4D+P0XfIiDMc290P78ET6QvK2l42ojvc=;
 b=Tbc+1V+G5DEhDRxayfZB3x96OFGI1eBR4CCXJ5uNQVIGOfdmWTrv0HFaR0mQSQR+836sp2
 6aeIVezG2JnB5mu5aT4jyw52WbaIG7STJXSeOC4UrCQNEKmWgkjtdZRQHWhC7PQvLI3AWS
 OyamwMOjlxJLjKOwguE5jrx1oSHttpA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-sQ5z6PTmN5-0Q9JjoDIayg-1; Wed, 02 Jul 2025 05:28:10 -0400
X-MC-Unique: sQ5z6PTmN5-0Q9JjoDIayg-1
X-Mimecast-MFC-AGG-ID: sQ5z6PTmN5-0Q9JjoDIayg_1751448489
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b362d101243so1136487a12.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 02:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751448489; x=1752053289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4rGpk6T8lyk4D+P0XfIiDMc290P78ET6QvK2l42ojvc=;
 b=sya5opQhA5zRpquT64MzzeJUGRCw8NZZXCJy4rlZtbaUEbE2XI31kxfwTkQ6Le0e0N
 kmwDPHA/MQH+9gdFNb6EJL/C5zON2mH9J7cwtq8tYk49m5N3KkCpunr6p3dlH/HZcMVb
 IRppoelB1nzJS6XkV4qs3Z3a4lUHafivfZ3NfTvdC5WIGT0yuC0fShYXrZ0EYwkf8nWw
 or/b+ckYZdRmZl72aQP2DgPYVU9VfSr7ml/88WwZPx1tNRMwjZfNn7xPZMVjM84a90w7
 1wkQCm+GxmVuBmcgRQp316p5c4n90LuZLDeraTR1WYZ+2jzdlAHOnrqZhDgb9Jodj3lh
 PHAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS2Oi+IgybaBvH0kfrpDcwSkmE2RIcbQBpZfBi9L6j6KXA+B8J/4AxnwBfep/U7ZC3U6HDUU2tdnBG@nongnu.org
X-Gm-Message-State: AOJu0YzSLbY8er2s7cUnTrMSPeXybfbXFjB3iG6UcApLYnmnmCATmo1H
 NT20A+EKAI15VyiEKdc6ynHV5LO/qGvVl9I8npSp5bLP4V2lOHruQ36byhrBxOkvWpeeh5X/ynW
 GOCg3MvfoF6qsY1CWw3PaQCCvzA+rN2guN0u40m6cTYva0K9qNRVYnpv/
X-Gm-Gg: ASbGncv2Ti29Wpr31ZUj06xIf/EC87dYR2CNLt02wWdUh7gF02TB8E9qAhsOKpPwpmX
 afTB+r/RZfZ5+WGiTJIOlq6aujagYGZkGOBdF4YrhljFM2L6UDV1du6o1BH0m+rSjmfzj9VF83k
 CYU0MRyau2CFLZcJ3b/cA5mUrxYJSFkIyVTowvnQIIMg1BbIphFDhhVMT8Qy8Vg4ztmJdkNc0TC
 1P/1jbf2+CaXF7lJcjGj/GFrGz3tEBXg4oSDCpRvV8U5N/uYw3GB6oPXWSsSdr63hxgmJmNoJ69
 GAza1+53xaBdAdHsCVPeJATl1g==
X-Received: by 2002:a05:6300:6c1a:b0:222:2a34:6249 with SMTP id
 adf61e73a8af0-222d7e9a85dmr2738003637.27.1751448489217; 
 Wed, 02 Jul 2025 02:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlOe3n5x8yzpKLAT+0u2pUNspJc6oc1hAeHHM40SpdP+cJooK7B563o/5/C5FicNSuuPnG0w==
X-Received: by 2002:a05:6300:6c1a:b0:222:2a34:6249 with SMTP id
 adf61e73a8af0-222d7e9a85dmr2737980637.27.1751448488806; 
 Wed, 02 Jul 2025 02:28:08 -0700 (PDT)
Received: from [10.72.116.77] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34e32000fbsm12261420a12.68.2025.07.02.02.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 02:28:08 -0700 (PDT)
Message-ID: <36d469be-d9fd-48c9-8106-2db885e6fe39@redhat.com>
Date: Wed, 2 Jul 2025 17:28:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] hw/i386: Add the ramfb romfile compatibility
To: Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250702085616.2172722-1-shahuang@redhat.com>
 <20250702085616.2172722-3-shahuang@redhat.com>
 <dec256c0-d0a5-49d7-b5ce-a025eaf27f8c@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <dec256c0-d0a5-49d7-b5ce-a025eaf27f8c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
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

On 7/2/25 5:08 PM, Eric Auger wrote:
> 
> 
> On 7/2/25 10:56 AM, Shaoqin Huang wrote:
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
> If I understood correctly, Gerd said we needed to set the prop to "true"
> on microvm too? I don't see that change.

Yes, I try to do that. But I didn't see there are any machine type in 
the microvm like q35. I'm confuse about it, How should I do that?

Thanks,
Shaoqin

> 
> Eric
>>   hw/vfio/pci.c                 |  2 +-
>>   5 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index e869821b22..a7043e2a34 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -39,6 +39,8 @@
>>   
>>   GlobalProperty hw_compat_10_0[] = {
>>       { "scsi-hd", "dpofua", "off" },
>> +    { "ramfb", "use-legacy-x86-rom", "true"},
>> +    { "vfio-pci", "use-legacy-x86-rom", "true" },
>>   };
>>   const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
>>   
>> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
>> index 725aef9896..b20a7c57b3 100644
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
>>   static void ramfb_class_initfn(ObjectClass *klass, const void *data)
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index ea7572e783..8ec8d8ae6d 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -49,6 +49,7 @@
>>   #include "hw/i2c/smbus_eeprom.h"
>>   #include "system/memory.h"
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
>> @@ -482,6 +490,8 @@ static void pc_i440fx_machine_options(MachineClass *m)
>>                                      pc_set_south_bridge);
>>       object_class_property_set_description(oc, "x-south-bridge",
>>                                        "Use a different south bridge than PIIX3");
>> +    compat_props_add(m->compat_props,
>> +                     pc_piix_compat_defaults, pc_piix_compat_defaults_len);
>>   }
>>   
>>   static void pc_i440fx_machine_10_1_options(MachineClass *m)
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 33211b1876..0096eef6f4 100644
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
>>   };
>>   static const size_t pc_q35_compat_defaults_len =
>>       G_N_ELEMENTS(pc_q35_compat_defaults);
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index f4fa8a5610..604b337389 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3710,7 +3710,7 @@ static const TypeInfo vfio_pci_dev_info = {
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


