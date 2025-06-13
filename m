Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26D2C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 03:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPugV-0006Zk-2c; Thu, 12 Jun 2025 23:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uPugT-0006Z7-40
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 23:02:25 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uPugN-00008x-RF
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 23:02:23 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-afc857702d1so1327438a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 20:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749783719; x=1750388519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n/GptnQflBaFVz42wx2o3AUWBDJwcTdztdJYMtLW1p8=;
 b=aNa9ObL0v76yyivyPqpOMfuKnmFm4i/BKaHwZqAawX6E/uJzQSnbNK/aJaxE8934q4
 n3tozZG43Kf9UANDQzOr3VMeZF/hokmmbemZmwF8qUZM5U/+zDGXerie6sZc1LSNvviX
 BcR0nZHW1AdbgvHGBBeuKB/W6f8d1xsi4oYvRmoZ8aB14jaaw7uPnFPNr236uS1HIjyJ
 tBhk1wOi9cgpWTZPAnLbJJnkPHHvPGE9TMabMUk0qqEBu4ZWdN4QfHFCv67BJ5KvVWA6
 YfHLVAZvmNIJ+qIfDjKK/0+3MYu9b1n4vjpBfjaFSpowqufIMXVvEjsuwtyJOUfyTGY9
 3ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749783719; x=1750388519;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n/GptnQflBaFVz42wx2o3AUWBDJwcTdztdJYMtLW1p8=;
 b=AKjQrCpWA8u18opSW81M3/Hc/tvcUfcjoWagdV6cSlSdTOz+x8We9bb9B/RBdrC2zY
 cJn2QFVEFB/Yokk0AasYhYOSqtUFoI4VJby4MOSpNe9OhuguFq3jfYUsfm25tDsKXvmR
 vuIU8R92WztwWkRGnovGuqrMef3htV72cm0ic8D5QURs5JcJisdxa0NhFcUi8GEUiulN
 7qwMsCKejdSjQDPPPoy14ZoMLLiQ/jsPjiLMAJxdNhbxSHsE3v6+61rYkqFBXViIp9by
 X09LMHvZjWwvGGNfNEruDrwmAkQGUTIESAvL4vZkOxAIoWZDL2YwGQxQ2MNvL9OWeCaY
 99aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6wucIbTggMWsG58ZxvLOhj813aGNf5y7r3SdNo/D3CcvfqDCugrh6k0rm/SAdzIlXfw6OEzXc2CqA@nongnu.org
X-Gm-Message-State: AOJu0Ywgd00bzMwrXpVg7hU34RlaxQMr4lv1/p9Wjs9eAse3iXG80Uaq
 hKWxu4XshsKD/gC0g9oYijD1TgVbp0nsDfGBYIbZFpeHCPf578txdmep82GwQMNhPJA=
X-Gm-Gg: ASbGncsV4jdkHtsuPNNWLxiaQgdu4g9W36jHFugGVxdIVKtBLI4ILd+ii3NpNcZ6Cqo
 sJX34xXhmQfkIx+Mx77kFFbKpUkinhiKJFx1EBRgMMwPAt77m7E/yKHT1S+Y9emBvg755Tm9NoC
 90+sDk3F9ehRpjLwPJY4kQs5u9VnnyabG9fGA3wNdQuwsikEImdDBFBAuOAPgx4JiZtFLPo4fgy
 83xRSVG3ksciIpRh8edlrPLqXT237ZtNboPTWH2XUbCzQR3nDUBWu7Wo7Uba0fBb/jis5lpyj1H
 ujnJm2OUjFEKT6Rbxmq5F53IquOaWOLdkAzSQvYGXXFrusGmLq8WLULDeJUOiVFLCgLiubUsthX
 +/C6cYQ8DxriOrSXrq2xzmYtC2fp4qNiaEaaiGcbrqqkSEQ==
X-Google-Smtp-Source: AGHT+IFG3zzNsopLHddsMJbny5PwduMm6X6AIA8AK2/yU+7C09b4Ol27czDZQ9FQeKodW6w+Jsvfgg==
X-Received: by 2002:a05:6a20:a109:b0:21f:7430:148a with SMTP id
 adf61e73a8af0-21facf11c28mr1954803637.28.1749783718533; 
 Thu, 12 Jun 2025 20:01:58 -0700 (PDT)
Received: from [192.168.0.102] (200-162-224-156.static-corp.ajato.com.br.
 [200.162.224.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe16899b0sm437204a12.52.2025.06.12.20.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 20:01:57 -0700 (PDT)
Message-ID: <61599d8b-d83d-44ff-8c4d-86bf90ebbb4c@linaro.org>
Date: Fri, 13 Jun 2025 00:01:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/25] hw/arm/virt: Introduce machine state acpi pcihp
 flags and props
To: Igor Mammedov <imammedo@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, Jonathan.Cameron@huawei.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-3-eric.auger@redhat.com>
 <20250527135813.2d6cde91@imammedo.users.ipa.redhat.com>
 <d6bd4794-bcee-4701-8e63-4adee91120d9@redhat.com>
 <20250528123325.750529a4@imammedo.users.ipa.redhat.com>
 <13792b72-d336-41b8-8ac7-8790e10f833c@redhat.com>
 <20250611104511.55152616@imammedo.users.ipa.redhat.com>
 <05680827-85d9-4ebd-91a7-93e262da52f5@redhat.com>
 <20250612145537.7dff93a8@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250612145537.7dff93a8@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/12/25 09:55, Igor Mammedov wrote:
> On Wed, 11 Jun 2025 10:50:04 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> Hi Igor,
>> On 6/11/25 10:45 AM, Igor Mammedov wrote:
>>> On Wed, 11 Jun 2025 08:53:28 +0200
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>   
>>>> Hi Gustavo, Alex,
>>>>
>>>> On 5/28/25 12:33 PM, Igor Mammedov wrote:
>>>>> On Tue, 27 May 2025 15:54:15 +0200
>>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>>     
>>>>>> Hi Igor,
>>>>>>
>>>>>> On 5/27/25 1:58 PM, Igor Mammedov wrote:
>>>>>>> On Tue, 27 May 2025 09:40:04 +0200
>>>>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>>>>       
>>>>>>>> acpi_pcihp VirtMachineClass state flag will allow
>>>>>>>> to opt in for acpi pci hotplug. This is guarded by a
>>>>>>>> class no_acpi_pcihp flag to manage compats (<= 10.0
>>>>>>>> machine types will not support ACPI PCI hotplug).
>>>>>>> there is no reason to put an effort in force disabling it
>>>>>>> on old machines, as long as code works when explicitly
>>>>>>> enabled property on CLI.
>>>>>>>
>>>>>>> See comment below on how to deal with it
>>>>>>>       
>>>>>>>> Machine state acpi_pcihp flag must be set before the creation
>>>>>>>> of the GED device which will use it.
>>>>>>>>
>>>>>>>> Currently the ACPI PCI HP is turned off by default. This will
>>>>>>>> change later on for 10.1 machine type.
>>>>>>> one thing to note, is that turning it on by default might
>>>>>>> cause change of NIC naming in guest as this brings in
>>>>>>> new "_Sxx" slot naming. /so configs tied to nic  go down the drain/
>>>>>>>
>>>>>>> Naming, we have, also happens to be broken wrt spec
>>>>>>> (it should be unique system wide, there was a gitlab issue for that,
>>>>>>> there is no easy fix that though)
>>>>>>>
>>>>>>> So I'd leave it disabled by default and let users to turn
>>>>>>> it on explicitly when needed.
>>>>>> what is the status on q35, isn't it enabled by default? If so why
>>>>>> wouldn't we want the same setting on ARM? Is that because of the known
>>>>>> issue you report above?
>>>>> Above issue is not a blocker (for thae lack of a good way to fix it)
>>>>>
>>>>> on q35 we have had a few complains and fixes, after pcihp was promoted
>>>>> to default (so hopefully that won't happen on with ARM). Also given
>>>>> that ARM VM is less popular like hood breaking someone setup is even less.
>>>>>
>>>>> That said I'd be cautions keep native hotplug as default,
>>>>> and only ones who need ACPI one, could turn it on explicitly.
>>>>>
>>>>> But well it's policies, so it's up to you ARM folks to decide what
>>>>> virt board should look like.
>>>> What is your preference? Do you prefer enabling ACPI PCI HP by default
>>>> or the opposite.
>>> I'd prefer native PCIe hotplug being default,
>>> that way we have less chance of causing regressions not to mention
>>> less complexity (as acpi pcihp adds up quite a bit of it).
>>>
>>> And ones who want/need acpi-pcihp/acpi-index can enable it explicitly,
>>> to play with.
>>
>> OK I will follow your suggestion. You have definitively more expertise
>> than me here ! ;-)
> 
> So far what I suggest looks like better option compared to multiple machine knobs
> fiddling. But I can easily change my mind once I see respin, if experiment
> with compat props is not coming well together.

For now, I think it's okay to let ACPI PCI hotplug stabilize (while not being the
default) for at least one release cycle. So I'm fine with keeping acpi-pcihp=off as
the default.

As I mentioned elsewhere, I don't consider native PCIe hotplug to be legacy.

We can make acpi-pcihp=on the default in a future release once it's been more
widely exercised.

I'll update the bios-tables-test.c test accordingly, then you can either put them
in the v3 (if you happen to send v3 next week) or add them to a v4.


Cheers,
Gustavo

>> Thanks!
>>
>> Eric
>>>   
>>>> Anybody else?
>>>>
>>>> On my end I think I would prefer to have the same default setting than
>>>> on x86 (ie. ACPI PCI hotplug set by default) but I have no strong
>>>> opinion either.
>>>>
>>>> Thanks
>>>>
>>>> Eric
>>>>>     
>>>>>> The no_foo compat stuff was especially introduced to avoid breaking the
>>>>>> guest ABI for old machine types (like the NIC naming alternation you evoke).
>>>>> no_foo is just another way to handle compat stuff,
>>>>> and when it's more than one knob per feature it gets ugly really fast.
>>>>> Hence, I'd prefer pcihp done in x86 way aka:
>>>>>     hw_compat_OLD(ged.use_acpi_hotplug_bridge, false|true)
>>>>> to manage presence of ACPI hotplug on desired machine version.
>>>>> Side benefit it's consistent with how pcihp works on x86
>>>>>     
>>>>>>>       
>>>>>>>> We also introduce properties to allow disabling it.
>>>>>>>>
>>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>>>>> ---
>>>>>>>>   include/hw/arm/virt.h |  2 ++
>>>>>>>>   hw/arm/virt.c         | 27 +++++++++++++++++++++++++++
>>>>>>>>   2 files changed, 29 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>>>>>>>> index 9a1b0f53d2..10ea581f06 100644
>>>>>>>> --- a/include/hw/arm/virt.h
>>>>>>>> +++ b/include/hw/arm/virt.h
>>>>>>>> @@ -129,6 +129,7 @@ struct VirtMachineClass {
>>>>>>>>       bool no_tcg_lpa2;
>>>>>>>>       bool no_ns_el2_virt_timer_irq;
>>>>>>>>       bool no_nested_smmu;
>>>>>>>> +    bool no_acpi_pcihp;
>>>>>>>>   };
>>>>>>>>   
>>>>>>>>   struct VirtMachineState {
>>>>>>>> @@ -150,6 +151,7 @@ struct VirtMachineState {
>>>>>>>>       bool mte;
>>>>>>>>       bool dtb_randomness;
>>>>>>>>       bool second_ns_uart_present;
>>>>>>>> +    bool acpi_pcihp;
>>>>>>>>       OnOffAuto acpi;
>>>>>>>>       VirtGICType gic_version;
>>>>>>>>       VirtIOMMUType iommu;
>>>>>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>>>>>> index 9a6cd085a3..a0deeaf2b3 100644
>>>>>>>> --- a/hw/arm/virt.c
>>>>>>>> +++ b/hw/arm/virt.c
>>>>>>>> @@ -2397,8 +2397,10 @@ static void machvirt_init(MachineState *machine)
>>>>>>>>       create_pcie(vms);
>>>>>>>>   
>>>>>>>>       if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>>>>>>>> +        vms->acpi_pcihp &= !vmc->no_acpi_pcihp;
>>>>>>> I don't particularly like no_foo naming as it makes code harder to read
>>>>>>> and combined with 'duplicated' field in machine state it make even things worse.
>>>>>>> (if I recall right Philippe was cleaning mess similar flags usage
>>>>>>> have introduced with ITS)
>>>>>>>
>>>>>>> instead of adding machine property (both class and state),
>>>>>>> I'd suggest adding the only property to GPE device (akin to what we have in x86 world)
>>>>>>> And then one can meddle with defaults using hw_compat_xxx
>>>>>> no_foo still is a largely used pattern in arm virt: no_ged,
>>>>>> kvm_no_adjvtime, no_kvm_steal_time, no_tcg_lpa2, ../.. There are plenty
>>>>>> of them and I am not under the impression this is going to be changed.
>>>>>>
>>>>>> If you refer to 8d23b1df7212 ("hw/arm/virt: Remove
>>>>>> VirtMachineClass::no_its field") I think the no_its was removed because
>>>>>> the machine it applied was removed.
>>>>>>
>>>>>> If I understand correctly you would like the prop to be attached to the
>>>>>> GED device. However the GED device is internally created by the virt
>>>>>> machine code and not passed through a "-device" CLI option. So how would
>>>>>> you pass the option on the cmd line if you don't want it to be set by
>>>>>> default per machine type?
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Eric
>>>>>>>       
>>>>>>>>           vms->acpi_dev = create_acpi_ged(vms);
>>>>>>>>       } else {
>>>>>>>> +        vms->acpi_pcihp = false;
>>>>>>>>           create_gpio_devices(vms, VIRT_GPIO, sysmem);
>>>>>>>>       }
>>>>>>>>   
>>>>>>>> @@ -2593,6 +2595,20 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
>>>>>>>>       vms->its = value;
>>>>>>>>   }
>>>>>>>>   
>>>>>>>> +static bool virt_get_acpi_pcihp(Object *obj, Error **errp)
>>>>>>>> +{
>>>>>>>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>>>>>>>> +
>>>>>>>> +    return vms->acpi_pcihp;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void virt_set_acpi_pcihp(Object *obj, bool value, Error **errp)
>>>>>>>> +{
>>>>>>>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>>>>>>>> +
>>>>>>>> +    vms->acpi_pcihp = value;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>   static bool virt_get_dtb_randomness(Object *obj, Error **errp)
>>>>>>>>   {
>>>>>>>>       VirtMachineState *vms = VIRT_MACHINE(obj);
>>>>>>>> @@ -3310,6 +3326,10 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>>>>>>>>                                             "in ACPI table header."
>>>>>>>>                                             "The string may be up to 8 bytes in size");
>>>>>>>>   
>>>>>>>> +    object_class_property_add_bool(oc, "acpi-pcihp",
>>>>>>>> +                                   virt_get_acpi_pcihp, virt_set_acpi_pcihp);
>>>>>>>> +    object_class_property_set_description(oc, "acpi-pcihp",
>>>>>>>> +                                          "Force ACPI PCI hotplug");
>>>>>>>>   }
>>>>>>>>   
>>>>>>>>   static void virt_instance_init(Object *obj)
>>>>>>>> @@ -3344,6 +3364,9 @@ static void virt_instance_init(Object *obj)
>>>>>>>>           vms->tcg_its = true;
>>>>>>>>       }
>>>>>>>>   
>>>>>>>> +    /* default disallows ACPI PCI hotplug */
>>>>>>>> +    vms->acpi_pcihp = false;
>>>>>>>> +
>>>>>>>>       /* Default disallows iommu instantiation */
>>>>>>>>       vms->iommu = VIRT_IOMMU_NONE;
>>>>>>>>   
>>>>>>>> @@ -3394,8 +3417,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
>>>>>>>>   
>>>>>>>>   static void virt_machine_10_0_options(MachineClass *mc)
>>>>>>>>   {
>>>>>>>> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>>>>>>>> +
>>>>>>>>       virt_machine_10_1_options(mc);
>>>>>>>>       compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
>>>>>>>> +    /* 10.0 and earlier do not support ACPI PCI hotplug */
>>>>>>>> +    vmc->no_acpi_pcihp = true;
>>>>>>>>   }
>>>>>>>>   DEFINE_VIRT_MACHINE(10, 0)
>>>>>>>>         
>>
> 


