Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DC7C83F05
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Jul 2025 16:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYSGn-0005hJ-12; Sun, 06 Jul 2025 12:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uYSGY-0005aq-Fn
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 12:31:02 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uYSGW-0006mh-5f
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 12:30:58 -0400
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-3138b2f0249so1827590a91.2
 for <qemu-devel@nongnu.org>; Sun, 06 Jul 2025 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751819453; x=1752424253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pUyAoq8spR7bMR2tTig6cVvGC9bl8FbzIcdfTxLhUWo=;
 b=XEpJmul0E/XS1/RQ/LYIbGWM0u81YXYmNNQwpyIjA7NSAP9qdgwXqnmaUN9oBMYId5
 xemnS5e//DW0oy1tn60g6hToSnOziD8Q6pUoWWvhQ5p2P2rOoFCJY4AwtJpxbcq/6N4i
 Hb0MeeRBuIIwFTSl8cmysCXCfCETwewrYNlztRK43l7m/eU2D+JVP7eIHW2msM5Bixr9
 7g0KcPLiwneDcrErxZf/zgCBY6DlxIXg5BU5/LdkvutXE3KXJgdYsOUNoIDHSQGvjOAU
 tlCPmOGQ2l4isk5Aw/F5ObFUOMPoZ9CJIosHvD77UX4d5+XcbvfODp654T+GzgWJ25px
 oGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751819453; x=1752424253;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pUyAoq8spR7bMR2tTig6cVvGC9bl8FbzIcdfTxLhUWo=;
 b=QN86qQ0/A65wlRsp6RbuMSEqoGry+kOQmZaeUSQWm+fOpLLJlwGR8NhGf8eYJcb5Lf
 6nvi6U2hdtZhDyxmMCBZZrVYoio3YGab7/kS49FcMNbEQoG3tUTBGnyyG9ENt1PCFMxq
 0G8ZBJ1dMN3R1SEu4wbGnWlLoJy+QQe6STotRUfAYqgF+VmoGDOPaMowkNEbSSji5ofo
 zdT2bQgDDCQ/CweCDbqINst3Yvkvs4OaJcNjVcNXB/J1xXZguEgrOpwUOSi6AbKwhKxK
 f/+IhETCiLpnND8GFnmTy4cndRfQ7Gw+UlX4ss03+NyQOMDC+G9LlrYW0JcbQxiZVfju
 ug4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaiIzfOuZRWZzwnPZdM91VQYl7IJxeJFMCZk3o7iyBvY8wNa58nuemflpUSmhmBtIx054s5M35JONP@nongnu.org
X-Gm-Message-State: AOJu0YxnqRuKcmiox3dO4UxfeE/VWrdr2tM0QFCoLdCX1oWe/PDi9u5x
 VnooVIibxahIkP6eBsWi0BM7eW685njYZMvvAtrUKyDQMtwT5te32r4=
X-Gm-Gg: ASbGncuTwpod8Q0tPX7c07yl7wIEuyYkXvkqgiZYR6GzbRFlFc/7JUTCZUmJ6c7+UaX
 Oy+EiT5URtE+iYT64kqTG7XdD2GRA+mP8SxYaoBEmbtXQaus7vhmtTNAOOQsO7TRKd4GFS/qurI
 isMmeaLfHFi1xDrq42lnrjPnpPLmXvgHvd0eoNStvaVl95Owp/LoItVYrqHWFz7h1Pl9FWoUo0w
 J7k8ifx72TL4fRxYu8a5i6EVOC/MXT7GeSdKuFBOG1eVv9pZDcF9ILwkUdN2dSw9G9cYt0fpP88
 bkOnLL9y2HvwOlcR0JGtVoBVmq9sgKRwfbA4CMHHqSdtcMr4J2hgyi/K/vRRbltzh7s=
X-Google-Smtp-Source: AGHT+IHdKF26+OPggHGooqSLA9p9UUksV72AiU3+O39o8Tkk8rGrl+KbZpiKKA/LlzbBqi/XX+4IbA==
X-Received: by 2002:a17:90b:390c:b0:311:b3e7:fb3c with SMTP id
 98e67ed59e1d1-31aba8e1fe5mr7765407a91.31.1751819453225; 
 Sun, 06 Jul 2025 09:30:53 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.10])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31a4904a05dsm9163082a91.0.2025.07.06.09.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Jul 2025 09:30:52 -0700 (PDT)
Message-ID: <d7ca592e-2359-4214-9fc3-680c7a1d377c@gmail.com>
Date: Mon, 7 Jul 2025 00:30:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tomita Moeko <tomitamoeko@gmail.com>
Subject: Re: [PATCH v2] vfio/pci: Introduce x-pci-class-code option
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250528155548.29344-1-tomitamoeko@gmail.com>
 <20250528123019.5ff938ed.alex.williamson@redhat.com>
 <d6c3adba-40a0-42ce-9578-2e0a4a68fe2b@gmail.com>
 <92845463-8315-4ad8-9eab-eb2f4972cbaa@gmail.com>
 <20250626122654.1d62f8c8.alex.williamson@redhat.com>
Content-Language: en-US
Autocrypt: addr=tomitamoeko@gmail.com; keydata=
 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
In-Reply-To: <20250626122654.1d62f8c8.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1044.google.com
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

On 6/27/25 02:26, Alex Williamson wrote:
> On Tue, 17 Jun 2025 08:56:41 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> On 2025/5/29 18:41, Tomita Moeko wrote:
>>> On 2025/5/29 2:30, Alex Williamson wrote:  
>>>> On Wed, 28 May 2025 23:55:48 +0800
>>>> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>>>  
>>>>> Introduce x-pci-class-code option to allow users to override PCI class
>>>>> code of a device, similar to the existing x-pci-vendor-id option. Only
>>>>> the lower 24 bits of this option are used, though a uint32 is used here
>>>>> for determining whether the value is valid and set by user.
>>>>>
>>>>> Additionally, to prevent exposing VGA ranges on non-VGA devices, the
>>>>> x-vga=on option requires x-pci-class-code is either unset or set to
>>>>> VGA controller class.
>>>>>
>>>>> This is mainly intended for IGD devices that expose themselves either
>>>>> as VGA controller (primary display) or Display controller (non-primary
>>>>> display). The UEFI GOP driver depends on the device reporting a VGA
>>>>> controller class code (0x030000).
>>>>>
>>>>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>>>>> ---
>>>>> v2:
>>>>> * Add vdev class code check in vfio_populate_vga().
>>>>> * Fix type in trace-events.
>>>>> Link: https://lore.kernel.org/all/20250524153102.19747-1-tomitamoeko@gmail.com/
>>>>>
>>>>>  hw/vfio/pci.c        | 25 +++++++++++++++++++++++++
>>>>>  hw/vfio/pci.h        |  1 +
>>>>>  hw/vfio/trace-events |  1 +
>>>>>  3 files changed, 27 insertions(+)
>>>>>
>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>>> index b1250d85bf..d57cb7356e 100644
>>>>> --- a/hw/vfio/pci.c
>>>>> +++ b/hw/vfio/pci.c
>>>>> @@ -2726,6 +2726,14 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>>>>>          return false;
>>>>>      }
>>>>>  
>>>>> +    /* vdev class should be either unmodified (PCI_ANY_ID), or VGA controller */
>>>>> +    if ((vdev->class_code != PCI_ANY_ID) &&
>>>>> +        (vdev->class_code != (PCI_CLASS_DISPLAY_VGA << 8)) &&
>>>>> +        (vdev->class_code != (PCI_CLASS_NOT_DEFINED_VGA << 8))) {
>>>>> +        error_setg(errp, "vdev is not a VGA device");
>>>>> +        return false;
>>>>> +    }  
>>>>
>>>> I think we should follow the scheme used for vendor_id and device_id to
>>>> populate the struct field when not specified.  That let's us use it
>>>> more easily and consistently for things like this.  
>>>
>>> Hi, Alex
>>>
>>> The class code override takes place in vfio_pci_config_setup(), where
>>> is after vfio_populate_vga() is called in vfio_populate_device(). So
>>> I have to check if it equals to default or VGA class code here, and
>>> not initializing the sturct field with device value. If we decide to
>>> initialize it for other purpose, I personally think we should also
>>> save the subvendor/subdevice value as well.  
>>
>> It have been several weeks, wondering if there is further comments.
> 
> Hi Moeko,
> 
> Thank you for your patience.  I'm still a little confused how this
> works.  AIUI you have an GPU reported as a display controller, but you
> want to change the class code to VGA, despite there being no VGA region
> provided by vfio, right?  So the GOP driver only depends on the legacy
> VGA class code and not the VGA regions.

Hi, Alex

Sorry for my late reply, I was been on a travel on past 2 weeks.

Yes, the GOP driver only depends on VGA class code. Though I doesn't
have access to its source code, I tried with not exposing VGA regions,
the GOP driver works as expected. It seems Intel uses class code to tell
if IGD is set to primary (VGA controller) or secondary (display cntl)
and only enable GOP output when it is primary.

> vfio_populate_vga() initializes the vfio VGA region and calls
> pci_register_vga().  Therefore with the ability to modify the class
> code we only want to register the device as VGA if the class code is
> unmodified, where the VGA vfio regions will only exist if the device is
> VGA, or if the class override is VGA, where the VGA vfio regions again
> only exist if the device is actually VGA and therefore the override is
> a no-op.  But we only get to vfio_populate_vga() if the user specifies
> x-vga=on.  So I think we're really just trying to prevent a physical VGA
> device overridden as a non-VGA class code, but still specified with
> x-vga=on, from calling pci_register_vga(), right?
>
> What if we just separate pci_register_vga() out of vfio_populate_vga()?
> Then we can continue the semantics of making class_code valid
> regardless of whether it's been specified and around the point where we
> call vfio_bars_register() we can also call pci_register_vga() if and
> only if the class code is VGA and vdev->vga is configured.  Does that
> make sense?  Thanks,
> 
> Alex

Thanks for pointing that out. I hadn't considered the case that x-vga=on
when class code is overridden to non-VGA should be forbidden. Moving the
pci_register_vga() call into vfio_bars_register() after overriding the
class code absolutely makes sense. I'll proceed with this option in v3.

Thanks,
Moeko


