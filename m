Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED75C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 00:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRKdH-0003MG-L9; Mon, 16 Jun 2025 20:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uRKd8-0003LN-LL
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 20:56:51 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uRKd6-0006mc-5l
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 20:56:49 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-234d3261631so34323855ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 17:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750121806; x=1750726606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWEwGhFdqGiyQLz0MN3j7qrDPtKzwCGWr+cRBapj6Gw=;
 b=mugMRS8BapLQbsOYAQ70LxcIq69KNEcOSqec9xR7+XNTmojj79sMtrRhubtf11q0Av
 vy+vpnmooD4E1hSgOpqHUbsxdt99h8giCX1JNQbZpgXB8Qnvebk2Mj8UbQBRHZ4Uw9aE
 TGZXqSklvkXszzgH6+oAydFxvt/HN12QJu3RpmwoH+D1jswedQD6bZuPifZkr8ADyPvL
 0DJ1ReD4H4tUN0LhtfQ9cteuyrSGQp/7E/jJ3FQ/YIoWv247Y64oJ/NDfRyZOWLhbPkc
 IPCSx/JCbIGL/37p+1w41fmmGuOXg5M3adjov0E56nvIIDr/pLlPBsN3gcT5HVZuvoCf
 UIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750121806; x=1750726606;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NWEwGhFdqGiyQLz0MN3j7qrDPtKzwCGWr+cRBapj6Gw=;
 b=sq1eLRFiow6Obc8u+OZpQhjk9S3WcB2PK+Vu3JFWcRlXze/R1yAxxEETvKBPWalc5D
 OupmWe+Q+tXDF3CJ4Hc/gmRIT4OSCxP6/CMRnqWxch2uEfIfY0X/9mv/H8uYOk8enHK2
 bHVxhFqfQ0uT6xB2HsAsTLP9slFYXNGhdO5/cYkkYbpOUtw5g5w5JFjd3ZazTGIWEQu0
 vdpgdVdqPWawiVCuPGRSlAgtdTETKDqCXovDF77AlhDL9F80DDGNygocfGW/K4Aeul2Z
 p3mkgk6TvEMzoLOHO7Gm4Zw61RBF3HwzNt2bEiM0izojNOsKUSzFnfASFGYMIBG1XXek
 n+TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf6VRkbaSwAvAHOOKPllfCc43gl06WYRsHjInG6a7v6YHN+Kw53qBKTQwzbsj9YbkXu/4hp+yjtyR9@nongnu.org
X-Gm-Message-State: AOJu0YwZHLcfesEYkjgMRa/Vu+oVzhh5g1dtKfACBMCt9fGa829eIRHu
 oCAeHm9tU7bUfscud8/h8LSDuHGAWwZ9XJC45N7V0mLfwKbgZ398RNc=
X-Gm-Gg: ASbGncthKhhiOdSEowe3YJTp772CnW9PcO2386EPMLSKWldTMnXxIyrryRobLQCGUlk
 K8FWYFOOw8r0dQrbJVgskKizbikMrhcS4ymoS+NRyKYKqlDL90YziidtLxk2JjvbDNXkPmX2JN3
 wz5td8C+XU0yBQIir5+oDKoNBhJo5c8ALMtP1F7+I3BRSMRjBaXQ/a3Jwali4XnFCpck6rI4UHd
 Ex13winVPSMhHALpMWEL52Ksh+wM6K2DFQ3Vuzz4HEHZr6PfCoJ0v8DH162fhQlIzH4c700xcV+
 FjHNwsCEHrAgP7L8AG9bjWyjCELzSKGQhUepUPxPAPK/E0AYpurKjsiiYYNc4x1ybeEQmqnvOQ/
 5uqGu
X-Google-Smtp-Source: AGHT+IHT9wj5iV372Nys0MJmSbZgChyGcmo2WBeQV8/AbipPUIw2pqscnHfutZuS4YhQlOKxHcr2Nw==
X-Received: by 2002:a17:903:46c8:b0:234:c22:c612 with SMTP id
 d9443c01a7336-2366b17b6d8mr176715865ad.43.1750121806045; 
 Mon, 16 Jun 2025 17:56:46 -0700 (PDT)
Received: from [172.20.10.3] ([58.246.155.248])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365decb864sm67926375ad.213.2025.06.16.17.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 17:56:45 -0700 (PDT)
Message-ID: <92845463-8315-4ad8-9eab-eb2f4972cbaa@gmail.com>
Date: Tue, 17 Jun 2025 08:56:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/pci: Introduce x-pci-class-code option
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250528155548.29344-1-tomitamoeko@gmail.com>
 <20250528123019.5ff938ed.alex.williamson@redhat.com>
 <d6c3adba-40a0-42ce-9578-2e0a4a68fe2b@gmail.com>
In-Reply-To: <d6c3adba-40a0-42ce-9578-2e0a4a68fe2b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 2025/5/29 18:41, Tomita Moeko wrote:
> On 2025/5/29 2:30, Alex Williamson wrote:
>> On Wed, 28 May 2025 23:55:48 +0800
>> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>
>>> Introduce x-pci-class-code option to allow users to override PCI class
>>> code of a device, similar to the existing x-pci-vendor-id option. Only
>>> the lower 24 bits of this option are used, though a uint32 is used here
>>> for determining whether the value is valid and set by user.
>>>
>>> Additionally, to prevent exposing VGA ranges on non-VGA devices, the
>>> x-vga=on option requires x-pci-class-code is either unset or set to
>>> VGA controller class.
>>>
>>> This is mainly intended for IGD devices that expose themselves either
>>> as VGA controller (primary display) or Display controller (non-primary
>>> display). The UEFI GOP driver depends on the device reporting a VGA
>>> controller class code (0x030000).
>>>
>>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>>> ---
>>> v2:
>>> * Add vdev class code check in vfio_populate_vga().
>>> * Fix type in trace-events.
>>> Link: https://lore.kernel.org/all/20250524153102.19747-1-tomitamoeko@gmail.com/
>>>
>>>  hw/vfio/pci.c        | 25 +++++++++++++++++++++++++
>>>  hw/vfio/pci.h        |  1 +
>>>  hw/vfio/trace-events |  1 +
>>>  3 files changed, 27 insertions(+)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index b1250d85bf..d57cb7356e 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -2726,6 +2726,14 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>>>          return false;
>>>      }
>>>  
>>> +    /* vdev class should be either unmodified (PCI_ANY_ID), or VGA controller */
>>> +    if ((vdev->class_code != PCI_ANY_ID) &&
>>> +        (vdev->class_code != (PCI_CLASS_DISPLAY_VGA << 8)) &&
>>> +        (vdev->class_code != (PCI_CLASS_NOT_DEFINED_VGA << 8))) {
>>> +        error_setg(errp, "vdev is not a VGA device");
>>> +        return false;
>>> +    }
>>
>> I think we should follow the scheme used for vendor_id and device_id to
>> populate the struct field when not specified.  That let's us use it
>> more easily and consistently for things like this.
> 
> Hi, Alex
> 
> The class code override takes place in vfio_pci_config_setup(), where
> is after vfio_populate_vga() is called in vfio_populate_device(). So
> I have to check if it equals to default or VGA class code here, and
> not initializing the sturct field with device value. If we decide to
> initialize it for other purpose, I personally think we should also
> save the subvendor/subdevice value as well.

It have been several weeks, wondering if there is further comments.

Thanks,
Moeko

>> I think we can ignore PCI_CLASS_NOT_DEFINED_VGA.  The PCI Local Bus
>> Specification 2.1, dated June 1, 1995 (earliest I can find on the SIG)
>> includes the VGA class code and specifies base class 0x00 is reserved
>> for compatibility with devices built before the base class field was
>> defined, so at least before 1995.  Also, neither the kernel or QEMU
>> is_vga helpers account for this, so they'd not have a VGA region or be
>> properly detected elsewhere.  Thanks,
>>
>> Alex
> 
> Got it, will remove this in v3.
> 
> Thanks,
> Moeko
>  
>>> +
>>>      if (!(reg_info->flags & VFIO_REGION_INFO_FLAG_READ) ||
>>>          !(reg_info->flags & VFIO_REGION_INFO_FLAG_WRITE) ||
>>>          reg_info->size < 0xbffff + 1) {
>>> @@ -3092,6 +3100,21 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>>>                                                vdev->sub_device_id);
>>>      }
>>>  
>>> +    /*
>>> +     * Class code is a 24-bit value at config space 0x09. Allow overriding it
>>> +     * with any 24-bit value.
>>> +     */
>>> +    if (vdev->class_code != PCI_ANY_ID) {
>>> +        if (vdev->class_code > 0xffffff) {
>>> +            error_setg(errp, "invalid PCI class code provided");
>>> +            return false;
>>> +        }
>>> +        /* Higher 24 bits of PCI_CLASS_REVISION are class code */
>>> +        vfio_add_emulated_long(vdev, PCI_CLASS_REVISION,
>>> +                               vdev->class_code << 8, ~0xff);
>>> +        trace_vfio_pci_emulated_class_code(vbasedev->name, vdev->class_code);
>>> +    }
>>> +
>>>      /* QEMU can change multi-function devices to single function, or reverse */
>>>      vdev->emulated_config_bits[PCI_HEADER_TYPE] =
>>>                                                PCI_HEADER_TYPE_MULTI_FUNCTION;
>>> @@ -3489,6 +3512,8 @@ static const Property vfio_pci_dev_properties[] = {
>>>                         sub_vendor_id, PCI_ANY_ID),
>>>      DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>>>                         sub_device_id, PCI_ANY_ID),
>>> +    DEFINE_PROP_UINT32("x-pci-class-code", VFIOPCIDevice,
>>> +                       class_code, PCI_ANY_ID),
>>>      DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
>>>      DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
>>>                                     nv_gpudirect_clique,
>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>> index 5ce0fb916f..587eb8cc9a 100644
>>> --- a/hw/vfio/pci.h
>>> +++ b/hw/vfio/pci.h
>>> @@ -156,6 +156,7 @@ struct VFIOPCIDevice {
>>>      uint32_t device_id;
>>>      uint32_t sub_vendor_id;
>>>      uint32_t sub_device_id;
>>> +    uint32_t class_code;
>>>      uint32_t features;
>>>  #define VFIO_FEATURE_ENABLE_VGA_BIT 0
>>>  #define VFIO_FEATURE_ENABLE_VGA (1 << VFIO_FEATURE_ENABLE_VGA_BIT)
>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>> index e90ec9bff8..e8d585b49a 100644
>>> --- a/hw/vfio/trace-events
>>> +++ b/hw/vfio/trace-events
>>> @@ -46,6 +46,7 @@ vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
>>>  vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s 0x%04x"
>>>  vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
>>>  vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s 0x%04x"
>>> +vfio_pci_emulated_class_code(const char *name, uint32_t val) "%s 0x%06x"
>>>  
>>>  # pci-quirks.c
>>>  vfio_quirk_rom_in_denylist(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"
>>
> 


