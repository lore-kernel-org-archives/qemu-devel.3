Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7600C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUiEJ-0001Vy-Cc; Thu, 26 Jun 2025 04:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uUiEI-0001VN-Cz
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uUiEE-0004jK-7s
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750927504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKLpQInaFASwAceYYn1afmSoRMGL6bQ/K3rN9lhTxKo=;
 b=NEYuMlDTpvu2qwYA26bG698NaOC9vyJ1UqxWLOU70PiVD6juUXO9PxOcPnM62m2Scy/SMi
 OJjxj8o0OaEp8R4THLWz/0kiX5vDIOd7nK7Ws7wH4ZyTHDOlIDk3i544TstkcDfCXqsK02
 +N3GJgFiv2wepPmOGxRbpVOdL/NfKV0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-vXxhZ8iJN6aPc0b27Jokrg-1; Thu, 26 Jun 2025 04:45:02 -0400
X-MC-Unique: vXxhZ8iJN6aPc0b27Jokrg-1
X-Mimecast-MFC-AGG-ID: vXxhZ8iJN6aPc0b27Jokrg_1750927501
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so362949f8f.1
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 01:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750927501; x=1751532301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hKLpQInaFASwAceYYn1afmSoRMGL6bQ/K3rN9lhTxKo=;
 b=oaaiHuTpTUoMRKyojYypwIgWFWS8S0O6jiMtpNuSxXBAi/vZ4GOlzxPxEYuwgue5RA
 MEBzImh8IdiUcGgyJojBdCQxggriMgy6ez7SA2Or9sDDIogMxDDnVWbf38ncoQCSdEmj
 OKtQBP7aLgcI+wt/3pNxKtYjCdsEwMGQr00p15kluh8Q7uMmVmcisfsW+VwoUTSrfCdm
 Oxxz4SelFR7+gyGT6GC6O2vKpsyyDNynvK3hOe4etYDLkedtWx3ch2TXOl7lljAp1TCn
 pcmqi4VLyWOWjJ6fcFZNFAxs9aUCjFv/CB1yvNBOH5OcH5T6U/ED6R7/i8qybV2VBhqC
 M5zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy6aZfhCuwQC4zduSWgY7r7e+mDSsETCrcx0IY/50sdmi4fTNJvQ5p2/0bFK07NVfKqIjYgDnXnQgo@nongnu.org
X-Gm-Message-State: AOJu0Yza1eghemHS+NjtBoFx4oVilpVpfYfb0G1UMEk/r2o4tGtHV7mc
 FVdT/FaULZw9hymyLlI1OtXvjQNZya/eP6gN0bQjvdTxPJOdFfkWfW7iVDVqw7gpGqninISSb7p
 Y0q65L4vLh/PHmqrzBK5j+PuUpVfCA3fcmDqxCg+S6O/elvTwIgaBWHCH
X-Gm-Gg: ASbGnctSLOQZc2YZz7u6kN+OxQxJfSntecrIFWcUdy8rWwZwpRhf10hBmT7QZ4+k9qg
 odFDaCm9WaaupN8mpflE4sETl91+gQMefx+xi/X8o52AZs4mCJxhe9h2lyzuFiWBt1VilehCFDF
 bqnrCMPE2bJblbgo1DqG1w99inz8ajSP+S2ldZLAYSbjQhnW318dvT+T5PlIsXZkrb5XS54VZbb
 /HlIkxrils8k//iaPtnN9vjOyKpB+Pzr3DlgPgcsT31XHm9+94uDDxmCSg7YwIpoikJXtJ7uhQB
 giJAETwz8Y7csR6Gf3jFKVWTx6J2PpwgqWyijuvpvyj6RKcU0Kptf4K8iutUpJEE
X-Received: by 2002:a05:6000:2407:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3a6f311abd1mr2080309f8f.19.1750927501076; 
 Thu, 26 Jun 2025 01:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTMnl84ZQ1tJjJxOqpmwT6zLXsxgACUj7/EjcBel4Ml1XTh5lcP8PR4afgDnzYxk3fv9RUuQ==
X-Received: by 2002:a05:6000:2407:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3a6f311abd1mr2080288f8f.19.1750927500595; 
 Thu, 26 Jun 2025 01:45:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e805d21fsm6578031f8f.23.2025.06.26.01.44.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Jun 2025 01:44:59 -0700 (PDT)
Message-ID: <133b5108-85ab-4a32-9e20-7eb1b4492d9b@redhat.com>
Date: Thu, 26 Jun 2025 10:44:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/29] hw/arm/virt-acpi-build: Modify the DSDT ACPI
 table to enable ACPI PCI hotplug
Content-Language: en-US
To: eric.auger@redhat.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-18-eric.auger@redhat.com>
 <20250620103538.000021c1@huawei.com> <20250620143822.7ab69038@fedora>
 <20250620171351.00004cb0@huawei.com>
 <13edf868-707a-4caa-9b83-8b7ac103ff0a@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <13edf868-707a-4caa-9b83-8b7ac103ff0a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
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

Hi Igor,

On 6/25/25 5:23 PM, Eric Auger wrote:
> Hi Igor, Jonathan,
> 
> On 6/20/25 6:13 PM, Jonathan Cameron wrote:
>> On Fri, 20 Jun 2025 14:38:22 +0200
>> Igor Mammedov <imammedo@redhat.com> wrote:
>>
>>> On Fri, 20 Jun 2025 10:35:38 +0100
>>> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>>>
>>>> On Mon, 16 Jun 2025 11:46:46 +0200
>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>   
>>>>> Modify the DSDT ACPI table to enable ACPI PCI hotplug.
>>>>>
>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>
>>>>> ---
>>>>> v2 -> v3:
>>>>> - use ACPI_PCIHP_SIZE instead of 0x1000 (Igor)
>>>>> - use cihp_state->use_acpi_hotplug_bridge    
>>>> pcihp_state
>>>>
>>>> Takes a bit of searching to find the various bits of the
>>>> same support on x86 but this seems to match up.
>>>> Exactly when things are built does vary but not I think
>>>> in a way that matters.  e.g. I think on x86 the
>>>> EDSM stuff is built whether or not we have pcihp enabled
>>>> whereas here you've made it conditional on using acpi
>>>> hp.  Perhaps a tiny bit more description on that would be
>>>> useful if you do a v4?  
>>> edsm should be built regardless of pcihp
>>> (well intention was there, whether I messed it up or not I don't know)
>>>
>>> idea is that non hotplug ports can have a static acpi-index,
>>> so it doesn't depend on pcihp.
>> That makes sense - so here should that edsm feature be enabled whether
>> or not we have pcihp_state->use_acpi_hotplug_bridge == true
>>
>> i.e. is it really a separate thing from the rest of this series?
> 
> Further studying this comment,
> 
> EDSM is invoked by code generated in aml_pci_static_endpoint_dsm() whcih
> itself is invoked by build_append_pci_bus_devices()
> 
> So to me it means that if we generate edsm unconditionally we also need
> to call the following block unconditionnally
> 
> +    aml_append(pci0_scope, build_pci_bridge_edsm());
> +    build_append_pci_bus_devices(pci0_scope, vms->bus);
> +    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
> +        build_append_pcihp_slots(pci0_scope, vms->bus);
> +    }
> 
> which seems to be done that way in hw/i386/acpi-build.c/build_dsdt()
> 
> Igor, if I recall correctly you said that addition changes related to
> "S%.02X" could change the guest ABI. And in that case this wouldn't be
> guarded by any new option/compat. So that's annoying.
> 
> By the way I tested static acpi-index on ARM with resulting code and it
> does not not seem to work - maybe I try with a wrong topology though
> (pcie root port + virtio-net acpi-index)-. I have not checked on x86 yet.
I tested on x86 and if you turn off acpi pci hotplug by setting
-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off
and you statically instantiate a virtio-net-pci device on a pcie root
port with ,acpi-index=3, acpi-index does not work either.
guest exposes enp5s0.

if you remove the global prop setting (acpi pcihp enabled by default),
guest exposes eno3.

so static acpi-index also seems to be dependent on acpi-pcihp on x86.

So I intend to leave the code as is with edsm added within the
acpi_pcihp conditional block. It is also simpler in terms of ref blob
and most importantly with regards to compat handling.

Thanks

Eric



> 
> So I wonder if it makes sense to do that refinement now. Maybe we can
> check try to improve that afterwards?
> 
> What do you think?
> 
> Eric
> 
> 
> 
>>
>> Thanks,
>>
>> J
>>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>>
>>>>   
>>>>> ---
>>>>>  include/hw/acpi/pcihp.h  |  2 ++
>>>>>  include/hw/arm/virt.h    |  1 +
>>>>>  hw/arm/virt-acpi-build.c | 22 ++++++++++++++++++++++
>>>>>  hw/arm/virt.c            |  2 ++
>>>>>  hw/arm/Kconfig           |  2 ++
>>>>>  5 files changed, 29 insertions(+)
>>>>>
>>>>> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>>>>> index 5506a58862..9ff548650b 100644
>>>>> --- a/include/hw/acpi/pcihp.h
>>>>> +++ b/include/hw/acpi/pcihp.h
>>>>> @@ -38,6 +38,8 @@
>>>>>  #define ACPI_PCIHP_SEJ_BASE 0x8
>>>>>  #define ACPI_PCIHP_BNMR_BASE 0x10
>>>>>  
>>>>> +#define ACPI_PCIHP_SIZE 0x0018
>>>>> +
>>>>>  typedef struct AcpiPciHpPciStatus {
>>>>>      uint32_t up;
>>>>>      uint32_t down;
>>>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>>>>> index 9a1b0f53d2..0ed2e6b732 100644
>>>>> --- a/include/hw/arm/virt.h
>>>>> +++ b/include/hw/arm/virt.h
>>>>> @@ -79,6 +79,7 @@ enum {
>>>>>      VIRT_ACPI_GED,
>>>>>      VIRT_NVDIMM_ACPI,
>>>>>      VIRT_PVTIME,
>>>>> +    VIRT_ACPI_PCIHP,
>>>>>      VIRT_LOWMEMMAP_LAST,
>>>>>  };
>>>>>  
>>>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>>>> index d7547c8d3b..a2e58288f8 100644
>>>>> --- a/hw/arm/virt-acpi-build.c
>>>>> +++ b/hw/arm/virt-acpi-build.c
>>>>> @@ -34,6 +34,7 @@
>>>>>  #include "hw/core/cpu.h"
>>>>>  #include "hw/acpi/acpi-defs.h"
>>>>>  #include "hw/acpi/acpi.h"
>>>>> +#include "hw/acpi/pcihp.h"
>>>>>  #include "hw/nvram/fw_cfg_acpi.h"
>>>>>  #include "hw/acpi/bios-linker-loader.h"
>>>>>  #include "hw/acpi/aml-build.h"
>>>>> @@ -809,6 +810,8 @@ static void
>>>>>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>>>>  {
>>>>>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>>>>> +    AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
>>>>> +    AcpiPciHpState *pcihp_state = &acpi_ged_state->pcihp_state;
>>>>>      Aml *scope, *dsdt;
>>>>>      MachineState *ms = MACHINE(vms);
>>>>>      const MemMapEntry *memmap = vms->memmap;
>>>>> @@ -868,6 +871,25 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>>>>  
>>>>>      aml_append(dsdt, scope);
>>>>>  
>>>>> +    if (pcihp_state->use_acpi_hotplug_bridge) {
>>>>> +        Aml *pci0_scope = aml_scope("\\_SB.PCI0");
>>>>> +
>>>>> +        aml_append(pci0_scope, aml_pci_edsm());
>>>>> +        build_acpi_pci_hotplug(dsdt, AML_SYSTEM_MEMORY,
>>>>> +                               memmap[VIRT_ACPI_PCIHP].base);
>>>>> +        build_append_pcihp_resources(pci0_scope,
>>>>> +                                     memmap[VIRT_ACPI_PCIHP].base,
>>>>> +                                     memmap[VIRT_ACPI_PCIHP].size);
>>>>> +
>>>>> +        /* Scan all PCI buses. Generate tables to support hotplug. */
>>>>> +        build_append_pci_bus_devices(pci0_scope, vms->bus);
>>>>> +        if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
>>>>> +            build_append_pcihp_slots(pci0_scope, vms->bus);
>>>>> +        }
>>>>> +        build_append_notification_callback(pci0_scope, vms->bus);
>>>>> +        aml_append(dsdt, pci0_scope);
>>>>> +    }
>>>>> +
>>>>>      /* copy AML table into ACPI tables blob */
>>>>>      g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
>>>>>      
>>>>   
>>>
> 


