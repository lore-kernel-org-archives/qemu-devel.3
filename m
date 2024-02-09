Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC1AC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 20:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYXhx-0004zD-Al; Fri, 09 Feb 2024 15:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYXhv-0004yF-PM
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 15:42:47 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYXhg-0000Zr-BP
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 15:42:47 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4101eb5a115so12467615e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 12:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707511350; x=1708116150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ItMis1CaqxmZp54x6Pd4rzKoT4YnPaqMBT6RmV6U6NE=;
 b=EANBwJeE1TnQdK+cWc7xaDGmwMLykP/LGS03tLFMIiRc/rzWfztSNLeULz97eL65bt
 lrXYQ/tUYM37Moviwr9Np0zBoV8/zBFEzViH90EiZOAZxGRIRXv9QawBFAI/wU/iwZV8
 JLZa3i4HrbDg78+hUBuP6x9JENSl/v9A51GsMpQ8gxe/8E3/yumAs5UuboQGJaHiq6Eh
 CJadmOpkm9P5J5Ejw2E0hj7geGBejGV28h4RIOIu03PJMcDRdul33pE+2pDhT1UgewcC
 yhy38IQxn1S31gczmZBmgM434Mh+V/8BsSdn3D6NcUcrYBZYv6QxGyIfbyJ4JjIUh2PJ
 0SLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707511350; x=1708116150;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ItMis1CaqxmZp54x6Pd4rzKoT4YnPaqMBT6RmV6U6NE=;
 b=t/HbD6h9qhTI9SDTSl7+qyCeE0MIwSqKM2tAbmgA91d7poZEUrmqAzbGTUJdtvv0s9
 5wJQqdZeyVCypry5HgTLDIT1+FBwQD4ZllSiQkCLA/pvnPCcKhRIY/Ll1HDlKA6WhWN/
 YbBk8loYnS3MMgvPn5G+kwbpU8WibBMV4HFeQm/pI9Jn5G0YDZX8pPVfFOgUzUv2SFXq
 mVkLytagTyLvxnl0aceYZ47fZercq8PydCVmLmL7IwxCxa9x6WXiOP/LsusVag/MwrXp
 ti7a9ShjtkiZKBnVASVAW/21rdJOUoWoWqvte4uJ+O5Wtee9elwRgsBwOsnPkGm/oKDS
 lwcQ==
X-Gm-Message-State: AOJu0YxmUnPN5Q1VmGCsFxSbfrUacUSwy39FEnn3RsASBgawQ0CGaw+E
 qzZZCfhgfjYBu45DkpA3gXlVNIb7hh2ScE36XTqjXIW07ftHNhvNOCbk1Qn23NM=
X-Google-Smtp-Source: AGHT+IGhjtiVFCkBQ3Og4tdSfg9v8Eyt0Gxs4kEJAE7co6Bb0FA+3PAVtJve2wDNoeraW588drLnvA==
X-Received: by 2002:a05:600c:1c24:b0:410:5a48:c3ac with SMTP id
 j36-20020a05600c1c2400b004105a48c3acmr273752wms.0.1707511349676; 
 Fri, 09 Feb 2024 12:42:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWGlbN4iWX+HbjhlHdo5zvJn7inig99qoTBruVaKLcePm2tWCTol3IWE64D/UTGy2q79LToaVQRZRCZPek/GgmxlgMp8eA4KwkU+N0botgy1ev07PP3G3Niz3L0DAs+lLWEToxaSy63Vq+kQFhu69DPh7F7rlIBlGY7ShmCOeXDqoERm6DLppJZqbsAXoMvGuYG0L9YsyjVnsdMWlpS6BXE7ZAv0JogDoKdO2zfUPgl1HAcMaFYJ/SW
Received: from [192.168.69.100] ([176.176.147.207])
 by smtp.gmail.com with ESMTPSA id
 e26-20020a05600c219a00b004107ab91f96sm1627256wme.8.2024.02.09.12.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 12:42:29 -0800 (PST)
Message-ID: <65fd4e10-c973-4f5a-b8dc-fb92a658732c@linaro.org>
Date: Fri, 9 Feb 2024 21:42:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hppa/Kconfig: Fix building with "configure
 --without-default-devices"
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@gmx.de>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 qemu-trivial@nongnu.org
References: <20240209185506.248001-1-thuth@redhat.com>
 <41399ad8-006d-4480-919e-d64395c5cfe9@gmx.de>
 <e92171bc-1677-6132-abcb-d0699e6267b6@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e92171bc-1677-6132-abcb-d0699e6267b6@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 9/2/24 20:46, BALATON Zoltan wrote:
> On Fri, 9 Feb 2024, Helge Deller wrote:
>> On 2/9/24 19:55, Thomas Huth wrote:
>>> When running "configure" with "--without-default-devices", building
>>> of qemu-system-hppa currently fails with:
>>>
>>>   /usr/bin/ld: libqemu-hppa-softmmu.fa.p/hw_hppa_machine.c.o: in 
>>> function `machine_HP_common_init_tail':
>>>   hw/hppa/machine.c:399: undefined reference to `usb_bus_find'
>>>   /usr/bin/ld: hw/hppa/machine.c:399: undefined reference to 
>>> `usb_create_simple'
>>>   /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to 
>>> `usb_bus_find'
>>>   /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to 
>>> `usb_create_simple'
>>>   collect2: error: ld returned 1 exit status
>>>   ninja: build stopped: subcommand failed.
>>>   make: *** [Makefile:162: run-ninja] Error 1
>>>
>>> And after fixing this, the qemu-system-hppa binary refuses to run
>>> due to the missing 'pci-ohci' and 'pci-serial' devices. Let's add
>>> the right config switches to fix these problems.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   hw/hppa/Kconfig | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
>>> index ff8528aaa8..124d5e9e47 100644
>>> --- a/hw/hppa/Kconfig
>>> +++ b/hw/hppa/Kconfig
>>> @@ -6,7 +6,7 @@ config HPPA_B160L
>>>       select ASTRO
>>>       select DINO
>>>       select LASI
>>> -    select SERIAL
>>> +    select SERIAL_PCI
>>
>> I think the "SERIAL" is needed too for the B160L machine.
> 
> SERIAL_PCI selects SERIAL so I think it should be pulled in without 
> listing it separately but not sure what's the policy for these configs.

We prefer explicit dependencies.

SERIAL is for Lasi/Dino serial_mm_init().

Although pulling in SERIAL, SERIAL_PCI is for pci-serial*.

> Regards,
> BALATON Zoltan
> 
>> Other than that,
>>
>> Acked-by: Helge Deller <deller@gmx.de>
>>
>> Thank you!
>> Helge
>>
>>>       select ISA_BUS
>>>       select I8259
>>>       select IDE_CMD646
>>> @@ -16,3 +16,4 @@ config HPPA_B160L
>>>       select LASIPS2
>>>       select PARALLEL
>>>       select ARTIST
>>> +    select USB_OHCI_PCI
>>
>>
>>
> 


