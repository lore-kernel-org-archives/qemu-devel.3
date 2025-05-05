Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBACC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 14:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBwfE-0001eR-T6; Mon, 05 May 2025 10:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBwfC-0001eC-0N
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBwf4-0000nF-Ta
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746454749;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4uu0qpdVjEJLYHkdpL6Cd88hqPozAxAQGV8BMWT+hIg=;
 b=FBj7jsKWJimL6uw3ri8Bfazddz8NxWhzv6l2c20F637M4c/mrNFBZIxD4W5Qa3F/MfybSu
 BzyCJHk06uBd5Yy9bX1V95wWIntMj0RcQCI7MYRBTt4tokdoLkYXiMGCHjR3ecyUVJXqav
 pOvzqjRGRcnX9pTnGZfMt5n231Y3h5Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-S1_GXhPDNtiT3Cnowk34ug-1; Mon, 05 May 2025 10:19:08 -0400
X-MC-Unique: S1_GXhPDNtiT3Cnowk34ug-1
X-Mimecast-MFC-AGG-ID: S1_GXhPDNtiT3Cnowk34ug_1746454747
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so28537255e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 07:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746454747; x=1747059547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4uu0qpdVjEJLYHkdpL6Cd88hqPozAxAQGV8BMWT+hIg=;
 b=FH6Dncx/fUX8U5/QxhlA1huUq36uE3UfDbBIhsPw/GmN5sHCZtvmFTtVPZ7zhc7Iw1
 pAqnzToyxAj5Digxh8peDRFbT/FcpG9Jc1r2xLt5bYZAzHmixtkiEVI84e352e8X9QKC
 p0Q/gkQx3eO4NGHpuLI35rejdeOgJ28DbNEK3Sv9u8fK/ScLfhTtLety8nGDs5C4NmWS
 +SLeqpbaXajP/X26KJkio6vk+vgVu6fviwSWBSHqD7ZrTFOtJKO4q2Wc+UROrA76vx72
 2YH1cBfgJsidZMhKKnHQTI2leebi2mnEA7+IIRBUqyVhf1IG10Cl4jyz53Fy/DUX1H1f
 id6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl0A+dnb7SMHhea+BBvvJENz1zLDntmfLRWVRfpE+4T8MC3qeRaDt1fGmiIld59xB2Z5C6SISsac74@nongnu.org
X-Gm-Message-State: AOJu0Yw71L1NWGuetAzF+ggeJLEr1xRo8J2LuEQPmlKLwSiIQTrLbzyl
 M+ndUVqeGocZC097fKrbBUfiJt5Q7RGScXMoxZYRRcaevY3GwBE4TjESOrwrgLn9icenpHQspJZ
 zOGKWoqxWu+FXA+QQtHIcXnP43FXgXI4Cc54rMFXJ04Vns1XxhY1G
X-Gm-Gg: ASbGncu9Jn4uo6ybL/IR9cgF1tI7cYMcjFAIwi7QD3503Xi3Hbf4ONRAK2GEQdrJWD4
 FouY1EZgbS1/+nVObZo6wa5cknibbGGh0E8igoIPFchfRXcgiLszFElyPoKEGtIo840cfkWxc7L
 IDiWhv2q2Mw9SaooxAR28kCugV7mC64CXdGMBClt72RlIJjKLgm2uPsUiFlwxbhOA6JDp3rOKFr
 GYFPUBJkzj7fwUKrNOYj0r6Aguaug9h+jrOogEJhDg1uPps/mPzteg1wBqMjHosS9GPBxPxhYzH
 EMpX9uc9CKCrrynXmhB81lvojLDOHD24FolPqncJguY0CtEAokUeu8P6o3Q=
X-Received: by 2002:a05:600c:1ca3:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-441cf5f650dmr1854775e9.29.1746454747263; 
 Mon, 05 May 2025 07:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4mjKibs+CFD2oZDhP1XAqbJIN77EpNUrrM/5e55fEdldptj+2OZW+0FyJaTS3WNTJC3nzVg==
X-Received: by 2002:a05:600c:1ca3:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-441cf5f650dmr1854585e9.29.1746454746842; 
 Mon, 05 May 2025 07:19:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89ee39esm134307495e9.21.2025.05.05.07.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 07:19:05 -0700 (PDT)
Message-ID: <c66f47ae-ccb9-47b2-9bbe-fb1386958e6f@redhat.com>
Date: Mon, 5 May 2025 16:19:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/acpi/pcihp: Fix typo in function name
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-trivial@nongnu.org, philmd@linaro.org
References: <20250504215639.54860-10-gustavo.romero@linaro.org>
 <b0faa0cf-8c68-4385-923c-e761b6582cc0@redhat.com>
 <6523849b-b44c-4176-ba5f-78a606621eb6@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6523849b-b44c-4176-ba5f-78a606621eb6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 5/5/25 2:29 PM, Gustavo Romero wrote:
> Hi Eric,
>
> On 5/5/25 04:13, Eric Auger wrote:
>>
>>
>> On 5/4/25 11:56 PM, Gustavo Romero wrote:
>>> Fix typo in QEMU's ACPI PCI hotplug API function name that checks
>>> whether a given bus is hotplug-capable.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>
>> For awareness, there is a similar typo in pci-port.
>> see
>> https://lore.kernel.org/all/20250428102628.378046-2-eric.auger@redhat.com/
>>
>
> hmm it's unfortunate that I was about to publish a series to exactly
> enable the APCI PCI hotplug on ARM. Next time I should try to sync better
> with Red Hat folks on the work fronts...
Sorry to hear that. That's always a frustrating situation :-(
>
> I've skimmed through your RFC and it seems to be doing mostly of what I
> was doing for my series, so I'll reviewed it formally today, it should
> be quick.
I guess we may need to add some additional qtests for hotplug (just as
they have on x86). Maybe we can collaborate on this or you already have
some stuff under work.

Thanks

Eric
>
> Anyways, thanks for the heads up.
>
>
> Cheers,
> Gustavo
>
>> another trivial indentation fix in generic_event_device.c
>> https://lore.kernel.org/all/20250428102628.378046-3-eric.auger@redhat.com/
>>
>>
>> Eric
>>
>>
>>
>>
>>> ---
>>>   hw/acpi/acpi-pci-hotplug-stub.c | 2 +-
>>>   hw/acpi/ich9.c                  | 2 +-
>>>   hw/acpi/pcihp.c                 | 2 +-
>>>   hw/acpi/piix4.c                 | 2 +-
>>>   include/hw/acpi/pcihp.h         | 2 +-
>>>   5 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/acpi/acpi-pci-hotplug-stub.c
>>> b/hw/acpi/acpi-pci-hotplug-stub.c
>>> index b67b4a92da..b7bc6e40a1 100644
>>> --- a/hw/acpi/acpi-pci-hotplug-stub.c
>>> +++ b/hw/acpi/acpi-pci-hotplug-stub.c
>>> @@ -34,7 +34,7 @@ void acpi_pcihp_reset(AcpiPciHpState *s)
>>>   {
>>>   }
>>>   -bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState
>>> *bus)
>>> +bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus)
>>>   {
>>>       return true;
>>>   }
>>> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
>>> index c7a735bf64..a07c9d115b 100644
>>> --- a/hw/acpi/ich9.c
>>> +++ b/hw/acpi/ich9.c
>>> @@ -570,7 +570,7 @@ void ich9_pm_device_unplug_cb(HotplugHandler
>>> *hotplug_dev, DeviceState *dev,
>>>   bool ich9_pm_is_hotpluggable_bus(HotplugHandler *hotplug_dev,
>>> BusState *bus)
>>>   {
>>>       ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
>>> -    return
>>> acpi_pcihp_is_hotpluggbale_bus(&lpc->pm.acpi_pci_hotplug, bus);
>>> +    return
>>> acpi_pcihp_is_hotpluggable_bus(&lpc->pm.acpi_pci_hotplug, bus);
>>>   }
>>>     void ich9_pm_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList
>>> ***list)
>>> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>>> index 5f79c9016b..aac90013d4 100644
>>> --- a/hw/acpi/pcihp.c
>>> +++ b/hw/acpi/pcihp.c
>>> @@ -371,7 +371,7 @@ void
>>> acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>>>       acpi_send_event(DEVICE(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
>>>   }
>>>   -bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState
>>> *bus)
>>> +bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus)
>>>   {
>>>       Object *o = OBJECT(bus->parent);
>>>   diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>>> index b16d45f03e..d98b80df6d 100644
>>> --- a/hw/acpi/piix4.c
>>> +++ b/hw/acpi/piix4.c
>>> @@ -406,7 +406,7 @@ static bool
>>> piix4_is_hotpluggable_bus(HotplugHandler *hotplug_dev,
>>>                                         BusState *bus)
>>>   {
>>>       PIIX4PMState *s = PIIX4_PM(hotplug_dev);
>>> -    return acpi_pcihp_is_hotpluggbale_bus(&s->acpi_pci_hotplug, bus);
>>> +    return acpi_pcihp_is_hotpluggable_bus(&s->acpi_pci_hotplug, bus);
>>>   }
>>>     static void piix4_pm_machine_ready(Notifier *n, void *opaque)
>>> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>>> index ac21a95913..a97904bada 100644
>>> --- a/include/hw/acpi/pcihp.h
>>> +++ b/include/hw/acpi/pcihp.h
>>> @@ -58,7 +58,7 @@ typedef struct AcpiPciHpState {
>>>   void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
>>>                        MemoryRegion *io, uint16_t io_base);
>>>   -bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState
>>> *bus);
>>> +bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus);
>>>   void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>>                                      DeviceState *dev, Error **errp);
>>>   void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev,
>>> AcpiPciHpState *s,
>>
>


