Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED290C48260
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 16:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYpvU-0006dQ-2g; Sat, 10 Feb 2024 11:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rYpvS-0006d7-G9
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 11:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rYpvR-0008Lx-0z
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 11:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707581395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/+S1kXbhP3jg4RlPaLzanW5bFCzpiWVAgBo6WUduKwQ=;
 b=gCY4ZD9okQ3dS3fOT8AgvVKP3oOcNeeUhMBNPv0z/nQIpPgmrextvjy7pqXFA6I4VIGZ+9
 sX3QPtLYaJNOavB3TjCVlLS2Cf8hs4dTKbinmbKyLvz7V3CHhjIyDhKlyqeDXoJuGubOwE
 SYEVZcvX9HWcheifKG1puf9cZllDOtk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-67q6j9HJOauWLStncItxmw-1; Sat, 10 Feb 2024 11:09:51 -0500
X-MC-Unique: 67q6j9HJOauWLStncItxmw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2b068401b4so231129266b.1
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 08:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707581390; x=1708186190;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+S1kXbhP3jg4RlPaLzanW5bFCzpiWVAgBo6WUduKwQ=;
 b=N0WNJvTce8DXbU+OFBjMyOG97QDFqIkVRw8F2thubkrI00GSWONBkdoJV7n3lJTuWi
 lfH+TxIxeeZMRGK3MZzJPFyX6svv2sCoA8ca6ehfsLrErgKSXAQjTbxTAnnhYawg6Qws
 Chf28s+YLa3bRb5QNZpGe8PA1P/82T5v52QKYtq6x6EsH/giByaWGYOYCn48d906TPUP
 Nyt2f9a6XAc0rDWESovCYGijadyVOTPDWfhngeHZddrVIhHlnrjGCMkKoNxwDfZQ4UCn
 pZZ+mC4W787mPNtZFd1EgbRldxhicBpVF0cAPA6xNZhv/3hTJEby4em5eGAk2jouO05V
 V3/w==
X-Gm-Message-State: AOJu0Yxk/v516CznpX8n5lp8OhuULTrDky6+ew1ZOeVHlUgKWoFLHyXk
 42I1ES7IP564KSmtzvMHdsP166IYpkIOT2HvzUR3VcPEHvuvR0MnUjA0kHoc2K4wR1Mbe/HFs6a
 E6oMopOtsntEXmwfOzdTDcuFTJK1Bok7UKkSI5scj2D/Xp5u3k4D/
X-Received: by 2002:a17:906:1689:b0:a3b:fe65:741f with SMTP id
 s9-20020a170906168900b00a3bfe65741fmr2009731ejd.31.1707581390435; 
 Sat, 10 Feb 2024 08:09:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkqFWoGNkL/PsE4Eci03116Vinr9QJpWYFoVNZLSuDUKPJjJqrzsXl4onJPwwnkWdva+FHEA==
X-Received: by 2002:a17:906:1689:b0:a3b:fe65:741f with SMTP id
 s9-20020a170906168900b00a3bfe65741fmr2009717ejd.31.1707581390045; 
 Sat, 10 Feb 2024 08:09:50 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWDFruK2uU9iOTuWoXU5tnwA4DeVtysDTpAa69urE4XzdBUmzs5LlTT81UsvkQ+t7Zy5yhGavEKDP3u+0mdH3gSlXDapkXbXPJuRaV/Y+waVPEchjkkijPtk/dwP/p4CuMKaVHNboOA5UuSdtHPrAdNBVi9A3C4+O1DxH0lXsx85K0h68c8d2fYbRqpGu1AYd3LbF9Zo4UtR0/WIwTlBoI/yTRmMMfK6Xkg7yq3TJcwAtHqODHO
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de.
 [109.43.177.145]) by smtp.gmail.com with ESMTPSA id
 e17-20020a170906081100b00a3c465661ecsm426460ejd.27.2024.02.10.08.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 08:09:49 -0800 (PST)
Message-ID: <3f12377d-31ed-48cb-9a8d-c0625057cf63@redhat.com>
Date: Sat, 10 Feb 2024 17:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hppa/Kconfig: Fix building with "configure
 --without-default-devices"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 qemu-trivial@nongnu.org
References: <20240209185506.248001-1-thuth@redhat.com>
 <41399ad8-006d-4480-919e-d64395c5cfe9@gmx.de>
 <e92171bc-1677-6132-abcb-d0699e6267b6@eik.bme.hu>
 <65fd4e10-c973-4f5a-b8dc-fb92a658732c@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <65fd4e10-c973-4f5a-b8dc-fb92a658732c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 09/02/2024 21.42, Philippe Mathieu-Daudé wrote:
> On 9/2/24 20:46, BALATON Zoltan wrote:
>> On Fri, 9 Feb 2024, Helge Deller wrote:
>>> On 2/9/24 19:55, Thomas Huth wrote:
>>>> When running "configure" with "--without-default-devices", building
>>>> of qemu-system-hppa currently fails with:
>>>>
>>>>   /usr/bin/ld: libqemu-hppa-softmmu.fa.p/hw_hppa_machine.c.o: in 
>>>> function `machine_HP_common_init_tail':
>>>>   hw/hppa/machine.c:399: undefined reference to `usb_bus_find'
>>>>   /usr/bin/ld: hw/hppa/machine.c:399: undefined reference to 
>>>> `usb_create_simple'
>>>>   /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to `usb_bus_find'
>>>>   /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to 
>>>> `usb_create_simple'
>>>>   collect2: error: ld returned 1 exit status
>>>>   ninja: build stopped: subcommand failed.
>>>>   make: *** [Makefile:162: run-ninja] Error 1
>>>>
>>>> And after fixing this, the qemu-system-hppa binary refuses to run
>>>> due to the missing 'pci-ohci' and 'pci-serial' devices. Let's add
>>>> the right config switches to fix these problems.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   hw/hppa/Kconfig | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
>>>> index ff8528aaa8..124d5e9e47 100644
>>>> --- a/hw/hppa/Kconfig
>>>> +++ b/hw/hppa/Kconfig
>>>> @@ -6,7 +6,7 @@ config HPPA_B160L
>>>>       select ASTRO
>>>>       select DINO
>>>>       select LASI
>>>> -    select SERIAL
>>>> +    select SERIAL_PCI
>>>
>>> I think the "SERIAL" is needed too for the B160L machine.
>>
>> SERIAL_PCI selects SERIAL so I think it should be pulled in without 
>> listing it separately 

Yes, that was my thinking when I replaced it.

> We prefer explicit dependencies.
> 
> SERIAL is for Lasi/Dino serial_mm_init().
> 
> Although pulling in SERIAL, SERIAL_PCI is for pci-serial*.

Ok, I can respin the patch to add SERIAL_PCI in addition instead of 
replacing SERIAL.

  Thomas


>> Regards,
>> BALATON Zoltan
>>
>>> Other than that,
>>>
>>> Acked-by: Helge Deller <deller@gmx.de>
>>>
>>> Thank you!
>>> Helge
>>>
>>>>       select ISA_BUS
>>>>       select I8259
>>>>       select IDE_CMD646
>>>> @@ -16,3 +16,4 @@ config HPPA_B160L
>>>>       select LASIPS2
>>>>       select PARALLEL
>>>>       select ARTIST
>>>> +    select USB_OHCI_PCI
>>>
>>>
>>>
>>
> 


