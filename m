Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7ABC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPei-0001Wk-IA; Tue, 20 Feb 2024 07:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcPed-0001WI-17
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:55:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcPeb-0002jF-2X
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708433718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a4iwzyMUSIjvICHOxM7FL/YuAsbTFih25Ki02rewAVM=;
 b=H/hNP91m922qpGi9PrqZd6PFTlffObqUOUxtZH44R6sKKl196YsK12JdZi5kDrm1q1HGsN
 ImSL815ZbM9qNLtFG2d9eKQ6Xwk+bbeDeuaUJRtpAfke9MwUr77pNdIpoypBPt4mBsg98f
 jvvcH58I7P74hL7/UTzsCXDEf6llHYU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-JvS8XBoUO86qCkYYVEpv8A-1; Tue, 20 Feb 2024 07:55:16 -0500
X-MC-Unique: JvS8XBoUO86qCkYYVEpv8A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-68f7b1d981bso18324846d6.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708433716; x=1709038516;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a4iwzyMUSIjvICHOxM7FL/YuAsbTFih25Ki02rewAVM=;
 b=loswamDfEo20NPwz61ydDg71qsLk96Bl5ov8rha5SqN9bLQuij0EKD82kFp3XQOGuU
 IzFGPtgQQ6sehVTCX8sxNx+2h7bby+0tL/Gpnm51EazgMDARRYei9kLpQgTeO3/d5hEb
 ot5cdiobFUy4uDi7d15scJ03qTUE1d5k4/BxYyBUoGk0g5sXj2LUDfwGQYaESAluF8D6
 PnaggwfbHP/GesdISomJvDXTmJqY+SOE3OKNb1mfeQe9PhPu0ZznAHum9h0/8iCzGHnB
 xdtqqspUihkTpt8g1b0QaPYP1+U9ObWvIWU2wu1K2VKK45CK/PMppWGAgnC30D4LW3Gh
 HaBA==
X-Gm-Message-State: AOJu0YwOvlpI7NCZDH7a3IjpI+0CywZ28+RxYCo20P6Af6zhGjeGcSaW
 1vBM8oCcjqjMdW3CC0+KtU9MvmD59BfLkFEJAFVV+e236IKQ6mucF9T1P+5kaGMr9Edda09gAy3
 U5Z0L8pncTEFZ+JQx/8iAY8lELaaD7DCA/5fZDB1T1HxtsfiuUcI7
X-Received: by 2002:a0c:e38d:0:b0:68f:7891:ef39 with SMTP id
 a13-20020a0ce38d000000b0068f7891ef39mr3440151qvl.51.1708433715964; 
 Tue, 20 Feb 2024 04:55:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5sPzKS6kv+zcL4RoKtq1myJx5o8f0xH9Z6yVzujKN9cLIb/kq58yrNxHymUIb5WtcM/HzOw==
X-Received: by 2002:a0c:e38d:0:b0:68f:7891:ef39 with SMTP id
 a13-20020a0ce38d000000b0068f7891ef39mr3440144qvl.51.1708433715693; 
 Tue, 20 Feb 2024 04:55:15 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-100.web.vodafone.de.
 [109.43.178.100]) by smtp.gmail.com with ESMTPSA id
 lr10-20020a0562145bca00b0068c968c3b33sm4299448qvb.20.2024.02.20.04.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:55:15 -0800 (PST)
Message-ID: <5726ea2c-425b-40a3-80a2-9fa3503a7f4c@redhat.com>
Date: Tue, 20 Feb 2024 13:55:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] hw/pci-bridge: Extract QOM ICH definitions to
 'ich_dmi_pci.h'
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
 <20240219163855.87326-7-philmd@linaro.org>
 <0841e333-3d7d-0440-a8bf-8a7fd2f0011f@eik.bme.hu>
 <19500c79-8e4a-2160-3622-dbf145655046@eik.bme.hu>
 <cee6951f-234e-4806-b6a1-147c39455f07@linaro.org>
 <055d34b8-64c6-fcc4-9bf9-b8491a50ce5f@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <055d34b8-64c6-fcc4-9bf9-b8491a50ce5f@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/02/2024 13.20, BALATON Zoltan wrote:
> On Tue, 20 Feb 2024, Philippe Mathieu-Daudé wrote:
>> On 19/2/24 19:24, BALATON Zoltan wrote:
>>> On Mon, 19 Feb 2024, BALATON Zoltan wrote:
>>>> On Mon, 19 Feb 2024, Philippe Mathieu-Daudé wrote:
>>>>> Expose TYPE_ICH_DMI_PCI_BRIDGE to the new
>>>>> "hw/pci-bridge/ich_dmi_pci.h" header.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>> MAINTAINERS                         |  1 +
>>>>> include/hw/pci-bridge/ich_dmi_pci.h | 20 ++++++++++++++++++++
>>>>> include/hw/southbridge/ich9.h       |  2 --
>>>>> hw/pci-bridge/i82801b11.c           | 11 ++++-------
>>>>> 4 files changed, 25 insertions(+), 9 deletions(-)
>>>>> create mode 100644 include/hw/pci-bridge/ich_dmi_pci.h
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 1b210c5cc1..50507c3dd6 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -2609,6 +2609,7 @@ F: hw/acpi/ich9*.c
>>>>> F: hw/i2c/smbus_ich9.c
>>>>> F: hw/isa/lpc_ich9.c
>>>>> F: include/hw/acpi/ich9*.h
>>>>> +F: include/hw/pci-bridge/ich_dmi_pci.h
>>>>> F: include/hw/southbridge/ich9.h
>>>>>
>>>>> PIIX4 South Bridge (i82371AB)
>>>>> diff --git a/include/hw/pci-bridge/ich_dmi_pci.h 
>>>>> b/include/hw/pci-bridge/ich_dmi_pci.h
>>>>> new file mode 100644
>>>>> index 0000000000..7623b32b8e
>>>>> --- /dev/null
>>>>> +++ b/include/hw/pci-bridge/ich_dmi_pci.h
>>>>> @@ -0,0 +1,20 @@
>>>>> +/*
>>>>> + * QEMU ICH4 i82801b11 dmi-to-pci Bridge Emulation
>>>>> + *
>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>> + */
>>>>> +
>>>>> +#ifndef HW_PCI_BRIDGE_ICH_D2P_H
>>>>> +#define HW_PCI_BRIDGE_ICH_D2P_H
>>>>> +
>>>>> +#include "qom/object.h"
>>>>> +#include "hw/pci/pci_bridge.h"
>>>>> +
>>>>> +#define TYPE_ICH_DMI_PCI_BRIDGE "i82801b11-bridge"
>>>>> +OBJECT_DECLARE_SIMPLE_TYPE(I82801b11Bridge, ICH_DMI_PCI_BRIDGE)
>>>>> +
>>>>> +struct I82801b11Bridge {
>>>>> +    PCIBridge parent_obj;
>>>>> +};
>>>>
>>>> If this class has no fields of its own why does it need its own state 
>>>> struct defined? You could just set .instance_size = sizeof(PCIBridge) in 
>>>> the TypeInfo i82801b11_bridge_info below and delete this struct 
>>>> completely as it's not even used anywhere. One less needless QOM 
>>>> complication :-) For an example see the empty via-mc97 device in 
>>>> hw/audio/via-ac97.c.
>>>>
>>>> Then you can put the OBJECT_DECLARE_SIMPLE_TYPE in 
>>>> hw/pci-bridge/i82801b11.c where this object is defined and the #define 
>>>> TYPE_ICH_DMI_PCI_BRIDGE in
>>>
>>> You don't even need OBJECT_DECLARE_SIMPLE_TYPE if there's no state 
>>> struct. But on second look what is this object at all? It's never 
>>> instantiated anywhere. Is it used somewhere?
>>
>> Here my view is we should always define QOM type names in headers
>> and use them, in particular in the TypeInfo registration. To unify
>> style and copy/pasting, better use the QOM DECLARE_TYPE macros.
>> I envision that might help moving toward DSL and have HW modelling
>> checks done externally, before starting QEMU. But then this is my
>> view and I dunno about when we'll get that DSL in so I'm OK to
>> revisit this patch.
> 
> The question here is more if we need this object at all because it wasn't 
> enstantiated before, and after your series it could be instantiated by a 
> property that's never set. So unless I misunderstood somthing this whole 
> thing could just be removed as dead code and let it be re-added later when 
> it's actually implemented following whatever conventions we'll have then. No 
> need to keep around empty placeholders that aren't used. Or does it serve 
> any purpose?

It's apparently used by some q35 configs:

$ grep -r i82801b11 docs/
docs/config/q35-emulated.cfg:  driver = "i82801b11-bridge"

  Thomas



