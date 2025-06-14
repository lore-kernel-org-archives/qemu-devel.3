Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA20C71141
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Jun 2025 08:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQLsc-000102-Lc; Sat, 14 Jun 2025 04:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uQLsb-0000zj-LF
 for qemu-devel@nongnu.org; Sat, 14 Jun 2025 04:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uQLsY-0002xi-DV
 for qemu-devel@nongnu.org; Sat, 14 Jun 2025 04:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749888279;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quBHQzsQem/XF62Zr/4dmc1YVeS0Mg9dFNrFk05N+ds=;
 b=AadXL+OjFqsZlQAA/Jb9kmDo0a70najVNiewOJGIWju+ALPOnQi1xl/pNawL+tDltMYQlp
 0/Ws/jNNC/2Cv77G7m6H4pW67Dl6Z8FqGG9hpVTBRfJoCRLNaaHUAc2g7U74Hxf7CpLoKE
 O28HhlK0+BItYq0zSBQhq/2wnAt7HBA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-HPbMKXsZM-qOPcbzs5nSbA-1; Sat, 14 Jun 2025 04:04:38 -0400
X-MC-Unique: HPbMKXsZM-qOPcbzs5nSbA-1
X-Mimecast-MFC-AGG-ID: HPbMKXsZM-qOPcbzs5nSbA_1749888277
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eeed54c2so1833974f8f.3
 for <qemu-devel@nongnu.org>; Sat, 14 Jun 2025 01:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749888277; x=1750493077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=quBHQzsQem/XF62Zr/4dmc1YVeS0Mg9dFNrFk05N+ds=;
 b=NJwveHHh1Dsw9XyjzN4QpCaoj4k5o4Xp9F+4zPiL5iA+sAm1pu7Gr4ZEy8gNYoq0tY
 e4zm1PLmElNRYAX0+98JNooSDOaBlWOsLidpGhfnVC3Rtrg1VZBTOapPHt5h158gQWSm
 fOd/qax1901Wx8QpyEXtmt09kMAknlWHf3doPfYT2bNYIcYLt/DwMF/1n6NvjBgkgIO4
 JYv+n4JOnkExhki7x1vlu/TgyUNMTzZhD87ENUV9UwnIa7Op/jrluxJpYzE80rqDlnSc
 t9aJ1GpQX4ejHtBR8Re3lTCBnZbwvNryJKj8sZFw5oc5/dufe2hqxod1Rp/vJBMxAaWI
 wuCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0jHkVb4SptBUAo71vHA4IPeKL080gAZ+prE1xA15UwRsccqXCHbgs5D0bepomESbnZlhtiKklEaC0@nongnu.org
X-Gm-Message-State: AOJu0Yx5vQS0gMUZUn0TZLEtFsXtrinPm1KOj7Y77HFYELsPUoLdlyMW
 Jwh53XKa4Lp+34YZlTcViYx54yVq5ueviiDiqDLBXLqDje7O+qTWp59KHRqkIPEIR/H8Ih0FrJZ
 HysZzvt6lCLzb6XSxvbXPFdar+P7opEmh4yC+un3IRPPIZGCGTmOToS2f
X-Gm-Gg: ASbGnctMR+CsuajIeshZ4XIZYJppr/ys9pX93ZiJJLROGIqSngTMw3Uu3lYEp0RePy2
 cBiOz0r/q4Ssfgm9F3wWMKgxG1JemC8IMFMhyPkZPSB3rF8ZG40NNsnhr/mupG4uvfBGdiNkP4g
 tbqMXAl1nDammt7tb9qI5fpwuCqejDLMWuJ3hOfYsHFNHwJTEXNXRfUWkpiac0w8fBGgAsDnsK3
 +vEe1z+XcbhDghjTArU1RfekZ5z15QpdZt1xZJ2ErN3MZ2Qx78OfF7dwQUDrCDR6jeU3FsaPqjL
 b/DidMZBOh6bBy6+CcXka/9jhlu9H+A00V1Fvp/+UPiS5vnRPMnSIr0pMroZGyt9xGPogQ==
X-Received: by 2002:a05:6000:250c:b0:399:6dd9:9f40 with SMTP id
 ffacd0b85a97d-3a5723678b8mr2795422f8f.9.1749888276712; 
 Sat, 14 Jun 2025 01:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsU68J+njZkqyQ3KObBwwchYAwvpvS7GY8PxAm6JKeF5w0O3GDnRzq+X0kPnp/FcO1DLGNzg==
X-Received: by 2002:a05:6000:250c:b0:399:6dd9:9f40 with SMTP id
 ffacd0b85a97d-3a5723678b8mr2795383f8f.9.1749888275859; 
 Sat, 14 Jun 2025 01:04:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e14f283sm76210245e9.27.2025.06.14.01.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Jun 2025 01:04:34 -0700 (PDT)
Message-ID: <3b01fa8d-7070-4aa6-9295-7ef2b6c1119c@redhat.com>
Date: Sat, 14 Jun 2025 10:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/25] hw/arm/virt: Introduce machine state acpi pcihp
 flags and props
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
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
 <61599d8b-d83d-44ff-8c4d-86bf90ebbb4c@linaro.org>
 <46cb9903-7a00-4e43-9b0e-03707e4952d3@redhat.com>
 <6ab0ae5e-5763-46a8-9f73-ee81a18bd8de@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6ab0ae5e-5763-46a8-9f73-ee81a18bd8de@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Gustavo,

On 6/13/25 3:39 PM, Gustavo Romero wrote:
> Hi Eric,
>
> On 6/13/25 02:05, Eric Auger wrote:
>> Hi Gustavo,
>>
>> On 6/13/25 5:01 AM, Gustavo Romero wrote:
>>> Hi Eric,
>>>
>>> On 6/12/25 09:55, Igor Mammedov wrote:
>>>> On Wed, 11 Jun 2025 10:50:04 +0200
>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>
>>>>> Hi Igor,
>>>>> On 6/11/25 10:45 AM, Igor Mammedov wrote:
>>>>>> On Wed, 11 Jun 2025 08:53:28 +0200
>>>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>>>  
>>>>>>> Hi Gustavo, Alex,
>>>>>>>
>>>>>>> On 5/28/25 12:33 PM, Igor Mammedov wrote:
>>>>>>>> On Tue, 27 May 2025 15:54:15 +0200
>>>>>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>>>>>    
>>>>>>>>> Hi Igor,
>>>>>>>>>
>>>>>>>>> On 5/27/25 1:58 PM, Igor Mammedov wrote:
>>>>>>>>>> On Tue, 27 May 2025 09:40:04 +0200
>>>>>>>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>>>>>>>      
>>>>>>>>>>> acpi_pcihp VirtMachineClass state flag will allow
>>>>>>>>>>> to opt in for acpi pci hotplug. This is guarded by a
>>>>>>>>>>> class no_acpi_pcihp flag to manage compats (<= 10.0
>>>>>>>>>>> machine types will not support ACPI PCI hotplug).
>>>>>>>>>> there is no reason to put an effort in force disabling it
>>>>>>>>>> on old machines, as long as code works when explicitly
>>>>>>>>>> enabled property on CLI.
>>>>>>>>>>
>>>>>>>>>> See comment below on how to deal with it
>>>>>>>>>>      
>>>>>>>>>>> Machine state acpi_pcihp flag must be set before the creation
>>>>>>>>>>> of the GED device which will use it.
>>>>>>>>>>>
>>>>>>>>>>> Currently the ACPI PCI HP is turned off by default. This will
>>>>>>>>>>> change later on for 10.1 machine type.
>>>>>>>>>> one thing to note, is that turning it on by default might
>>>>>>>>>> cause change of NIC naming in guest as this brings in
>>>>>>>>>> new "_Sxx" slot naming. /so configs tied to nic  go down the
>>>>>>>>>> drain/
>>>>>>>>>>
>>>>>>>>>> Naming, we have, also happens to be broken wrt spec
>>>>>>>>>> (it should be unique system wide, there was a gitlab issue for
>>>>>>>>>> that,
>>>>>>>>>> there is no easy fix that though)
>>>>>>>>>>
>>>>>>>>>> So I'd leave it disabled by default and let users to turn
>>>>>>>>>> it on explicitly when needed.
>>>>>>>>> what is the status on q35, isn't it enabled by default? If so why
>>>>>>>>> wouldn't we want the same setting on ARM? Is that because of the
>>>>>>>>> known
>>>>>>>>> issue you report above?
>>>>>>>> Above issue is not a blocker (for thae lack of a good way to
>>>>>>>> fix it)
>>>>>>>>
>>>>>>>> on q35 we have had a few complains and fixes, after pcihp was
>>>>>>>> promoted
>>>>>>>> to default (so hopefully that won't happen on with ARM). Also
>>>>>>>> given
>>>>>>>> that ARM VM is less popular like hood breaking someone setup is
>>>>>>>> even less.
>>>>>>>>
>>>>>>>> That said I'd be cautions keep native hotplug as default,
>>>>>>>> and only ones who need ACPI one, could turn it on explicitly.
>>>>>>>>
>>>>>>>> But well it's policies, so it's up to you ARM folks to decide what
>>>>>>>> virt board should look like.
>>>>>>> What is your preference? Do you prefer enabling ACPI PCI HP by
>>>>>>> default
>>>>>>> or the opposite.
>>>>>> I'd prefer native PCIe hotplug being default,
>>>>>> that way we have less chance of causing regressions not to mention
>>>>>> less complexity (as acpi pcihp adds up quite a bit of it).
>>>>>>
>>>>>> And ones who want/need acpi-pcihp/acpi-index can enable it
>>>>>> explicitly,
>>>>>> to play with.
>>>>>
>>>>> OK I will follow your suggestion. You have definitively more
>>>>> expertise
>>>>> than me here ! ;-)
>>>>
>>>> So far what I suggest looks like better option compared to multiple
>>>> machine knobs
>>>> fiddling. But I can easily change my mind once I see respin, if
>>>> experiment
>>>> with compat props is not coming well together.
>>>
>>> For now, I think it's okay to let ACPI PCI hotplug stabilize (while
>>> not being the
>>> default) for at least one release cycle. So I'm fine with keeping
>>> acpi-pcihp=off as
>>> the default.
>>>
>>> As I mentioned elsewhere, I don't consider native PCIe hotplug to be
>>> legacy.
>>>
>>> We can make acpi-pcihp=on the default in a future release once it's
>>> been more
>>> widely exercised.
>>>
>>> I'll update the bios-tables-test.c test accordingly, then you can
>>> either put them
>>> in the v3 (if you happen to send v3 next week) or add them to a v4.
>>
>> OK thank you for the confirmation. So following Igor's suggestion I
>> indeed kept the current default value (legacy PCIe hotplug) and I don't
>
> _native_ PCIe hotplug? :)
yes!
>
>
>> use a machine option anymore. Instead I use the x86 trick, ie.
>>
>> -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
>
> hm but why you don't keep the machine option "acpi-pcihp" and just don't
> set it as "on" by default? I find global options like that a tad
> difficult
> to follow, feels indeed like a trick. Also, I don't like much not
> mentioning GPEX in the option name (and only the event notification
> device, "ged).
>
> Am I missing something why a global would work better than a machine
> option
> when the default is the native PCIe hotplug?
I am just following Igor's suggestion at the moment. According to Igor
the benefit is that it looks exactly the same as x86 integration (which
would ease libvirt integration) and it is also reusable with microvm.

Anyway if reviewers are not happy with the end result I will revert ;-)

Thanks

Eric
>
>
>> I can easily update your tests with that option, don't bother
>> respinning. I should be able to send the v3 by beginning of next week.
>
> Got it! Thanks.
>
>
> Cheers,
> Gustavo
>
>> Thanks!
>>
>> Eric
>>
>>>
>>>
>>> Cheers,
>>> Gustavo
>>>
>>>>> Thanks!
>>>>>
>>>>> Eric
>>>>>>  
>>>>>>> Anybody else?
>>>>>>>
>>>>>>> On my end I think I would prefer to have the same default setting
>>>>>>> than
>>>>>>> on x86 (ie. ACPI PCI hotplug set by default) but I have no strong
>>>>>>> opinion either.
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> Eric
>>>>>>>>    
>>>>>>>>> The no_foo compat stuff was especially introduced to avoid
>>>>>>>>> breaking the
>>>>>>>>> guest ABI for old machine types (like the NIC naming alternation
>>>>>>>>> you evoke).
>>>>>>>> no_foo is just another way to handle compat stuff,
>>>>>>>> and when it's more than one knob per feature it gets ugly really
>>>>>>>> fast.
>>>>>>>> Hence, I'd prefer pcihp done in x86 way aka:
>>>>>>>>      hw_compat_OLD(ged.use_acpi_hotplug_bridge, false|true)
>>>>>>>> to manage presence of ACPI hotplug on desired machine version.
>>>>>>>> Side benefit it's consistent with how pcihp works on x86
>>>>>>>>    
>>>>>>>>>>      
>>>>>>>>>>> We also introduce properties to allow disabling it.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>>>>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>>>>>>>> ---
>>>>>>>>>>>    include/hw/arm/virt.h |  2 ++
>>>>>>>>>>>    hw/arm/virt.c         | 27 +++++++++++++++++++++++++++
>>>>>>>>>>>    2 files changed, 29 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>>>>>>>>>>> index 9a1b0f53d2..10ea581f06 100644
>>>>>>>>>>> --- a/include/hw/arm/virt.h
>>>>>>>>>>> +++ b/include/hw/arm/virt.h
>>>>>>>>>>> @@ -129,6 +129,7 @@ struct VirtMachineClass {
>>>>>>>>>>>        bool no_tcg_lpa2;
>>>>>>>>>>>        bool no_ns_el2_virt_timer_irq;
>>>>>>>>>>>        bool no_nested_smmu;
>>>>>>>>>>> +    bool no_acpi_pcihp;
>>>>>>>>>>>    };
>>>>>>>>>>>      struct VirtMachineState {
>>>>>>>>>>> @@ -150,6 +151,7 @@ struct VirtMachineState {
>>>>>>>>>>>        bool mte;
>>>>>>>>>>>        bool dtb_randomness;
>>>>>>>>>>>        bool second_ns_uart_present;
>>>>>>>>>>> +    bool acpi_pcihp;
>>>>>>>>>>>        OnOffAuto acpi;
>>>>>>>>>>>        VirtGICType gic_version;
>>>>>>>>>>>        VirtIOMMUType iommu;
>>>>>>>>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>>>>>>>>> index 9a6cd085a3..a0deeaf2b3 100644
>>>>>>>>>>> --- a/hw/arm/virt.c
>>>>>>>>>>> +++ b/hw/arm/virt.c
>>>>>>>>>>> @@ -2397,8 +2397,10 @@ static void machvirt_init(MachineState
>>>>>>>>>>> *machine)
>>>>>>>>>>>        create_pcie(vms);
>>>>>>>>>>>          if (has_ged && aarch64 && firmware_loaded &&
>>>>>>>>>>> virt_is_acpi_enabled(vms)) {
>>>>>>>>>>> +        vms->acpi_pcihp &= !vmc->no_acpi_pcihp;
>>>>>>>>>> I don't particularly like no_foo naming as it makes code harder
>>>>>>>>>> to read
>>>>>>>>>> and combined with 'duplicated' field in machine state it make
>>>>>>>>>> even things worse.
>>>>>>>>>> (if I recall right Philippe was cleaning mess similar flags
>>>>>>>>>> usage
>>>>>>>>>> have introduced with ITS)
>>>>>>>>>>
>>>>>>>>>> instead of adding machine property (both class and state),
>>>>>>>>>> I'd suggest adding the only property to GPE device (akin to
>>>>>>>>>> what we have in x86 world)
>>>>>>>>>> And then one can meddle with defaults using hw_compat_xxx
>>>>>>>>> no_foo still is a largely used pattern in arm virt: no_ged,
>>>>>>>>> kvm_no_adjvtime, no_kvm_steal_time, no_tcg_lpa2, ../.. There are
>>>>>>>>> plenty
>>>>>>>>> of them and I am not under the impression this is going to be
>>>>>>>>> changed.
>>>>>>>>>
>>>>>>>>> If you refer to 8d23b1df7212 ("hw/arm/virt: Remove
>>>>>>>>> VirtMachineClass::no_its field") I think the no_its was removed
>>>>>>>>> because
>>>>>>>>> the machine it applied was removed.
>>>>>>>>>
>>>>>>>>> If I understand correctly you would like the prop to be attached
>>>>>>>>> to the
>>>>>>>>> GED device. However the GED device is internally created by the
>>>>>>>>> virt
>>>>>>>>> machine code and not passed through a "-device" CLI option. So
>>>>>>>>> how would
>>>>>>>>> you pass the option on the cmd line if you don't want it to be
>>>>>>>>> set by
>>>>>>>>> default per machine type?
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>> Eric
>>>>>>>>>>      
>>>>>>>>>>>            vms->acpi_dev = create_acpi_ged(vms);
>>>>>>>>>>>        } else {
>>>>>>>>>>> +        vms->acpi_pcihp = false;
>>>>>>>>>>>            create_gpio_devices(vms, VIRT_GPIO, sysmem);
>>>>>>>>>>>        }
>>>>>>>>>>>    @@ -2593,6 +2595,20 @@ static void virt_set_its(Object *obj,
>>>>>>>>>>> bool value, Error **errp)
>>>>>>>>>>>        vms->its = value;
>>>>>>>>>>>    }
>>>>>>>>>>>    +static bool virt_get_acpi_pcihp(Object *obj, Error **errp)
>>>>>>>>>>> +{
>>>>>>>>>>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>>>>>>>>>>> +
>>>>>>>>>>> +    return vms->acpi_pcihp;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +static void virt_set_acpi_pcihp(Object *obj, bool value,
>>>>>>>>>>> Error **errp)
>>>>>>>>>>> +{
>>>>>>>>>>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>>>>>>>>>>> +
>>>>>>>>>>> +    vms->acpi_pcihp = value;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>    static bool virt_get_dtb_randomness(Object *obj, Error
>>>>>>>>>>> **errp)
>>>>>>>>>>>    {
>>>>>>>>>>>        VirtMachineState *vms = VIRT_MACHINE(obj);
>>>>>>>>>>> @@ -3310,6 +3326,10 @@ static void
>>>>>>>>>>> virt_machine_class_init(ObjectClass *oc, const void *data)
>>>>>>>>>>>                                              "in ACPI table
>>>>>>>>>>> header."
>>>>>>>>>>>                                              "The string may be
>>>>>>>>>>> up to 8 bytes in size");
>>>>>>>>>>>    +    object_class_property_add_bool(oc, "acpi-pcihp",
>>>>>>>>>>> +                                   virt_get_acpi_pcihp,
>>>>>>>>>>> virt_set_acpi_pcihp);
>>>>>>>>>>> +    object_class_property_set_description(oc, "acpi-pcihp",
>>>>>>>>>>> +                                          "Force ACPI PCI
>>>>>>>>>>> hotplug");
>>>>>>>>>>>    }
>>>>>>>>>>>      static void virt_instance_init(Object *obj)
>>>>>>>>>>> @@ -3344,6 +3364,9 @@ static void virt_instance_init(Object
>>>>>>>>>>> *obj)
>>>>>>>>>>>            vms->tcg_its = true;
>>>>>>>>>>>        }
>>>>>>>>>>>    +    /* default disallows ACPI PCI hotplug */
>>>>>>>>>>> +    vms->acpi_pcihp = false;
>>>>>>>>>>> +
>>>>>>>>>>>        /* Default disallows iommu instantiation */
>>>>>>>>>>>        vms->iommu = VIRT_IOMMU_NONE;
>>>>>>>>>>>    @@ -3394,8 +3417,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
>>>>>>>>>>>      static void virt_machine_10_0_options(MachineClass *mc)
>>>>>>>>>>>    {
>>>>>>>>>>> +    VirtMachineClass *vmc =
>>>>>>>>>>> VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>>>>>>>>>>> +
>>>>>>>>>>>        virt_machine_10_1_options(mc);
>>>>>>>>>>>        compat_props_add(mc->compat_props, hw_compat_10_0,
>>>>>>>>>>> hw_compat_10_0_len);
>>>>>>>>>>> +    /* 10.0 and earlier do not support ACPI PCI hotplug */
>>>>>>>>>>> +    vmc->no_acpi_pcihp = true;
>>>>>>>>>>>    }
>>>>>>>>>>>    DEFINE_VIRT_MACHINE(10, 0)
>>>>>>>>>>>          
>>>>>
>>>>
>>>
>>
>


