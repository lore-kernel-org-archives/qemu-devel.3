Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D353CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRit-0000Qa-VC; Mon, 11 May 2026 10:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMRir-0000Iy-Ra
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:35:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMRip-0006pz-OC
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:35:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so43639705e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778510102; x=1779114902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0xj5n44U/DrYYOQrrqpvGFk+jc+f46gPTtsV5yR8ka0=;
 b=UeVS44mWPzuaGjg1paov/9DZQV4JffPqTf6xsQk13Zr8r0OMNFMejPbHwtMxGJyxvI
 IIHA7E/TG91K+v5eORo2SCkh+6ObWROFFDQOFRyKVZEMgVWQYJw2R022qukh7X3Im4NE
 CZ6oEJpcJ3/yFOXKd71RIKSiiy2mx3jZgToFJNvZ0sul4fGurS9INCInaJK8PMZK9YYr
 iqj9t4Npse1vYZ9D2eWSyGibamggBY65XiwWtXUjlQKn02IN7jNm60BRSX/bAyxA0TWf
 O0Os+5uSUi4w7v1pQTQB9QOKEKzZn7GEhETjh8e/BS+InrItJdm7KvKo7MXfCbsqM+M2
 tUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778510102; x=1779114902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0xj5n44U/DrYYOQrrqpvGFk+jc+f46gPTtsV5yR8ka0=;
 b=J1VhZsqJszhs1GtQVXKaMSLX4C9e0nDPOaDcH/v/2RwLLPG9HYKOTOB9cdG9SVdjQH
 4M0uFOnvvRuqfDUscEZd5P7KQBYjyYDU+mIY3x4W8w2kKRRWqEI1hGjDmUFVDYhuvFrL
 dvy3vISubmXT1nyC0JaA94XbnikhfayXlRlnwqlmnAR4PcPMcgrlqP4BT1fRsfcby329
 Yg44MN9E/H0/XT1BErMkLI8WX7geICqq0QkOc3K4FPz4M96ZTD/XejDJedfJMBAF+bG/
 tivhrHphARX9VdYSMdGA2tBqpR2hqDRIEaNtpxWnDRusMUOKFOmpo9eJm16pqK0PEpwg
 iMUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hQt2mnyQ5YbZWOjsSmQ0K4qEsYAFgaZK2QaZS+MB492GnJ8/8gOClOs+5O0iNxm4/gZnHg8hSdyN3@nongnu.org
X-Gm-Message-State: AOJu0YxsWzzeJuqLzUis7PV3dqxPvaCq8iNdjyBTX38uLn/FJQSDgz8q
 E+9UM59H7//RokoU7i8Tk1MzyHMpQxDKyUws+U71VlZD7SzPDBQE3p0tB95cjwEBlrc=
X-Gm-Gg: Acq92OG4GbMWvnQ4/KN5Gp2unM8zKd1l62UKxdZV5vScPsAmxlpfgkdzsOS8oWRON29
 iV53RPVYKHlb1i1bC5dv6VZQ7kxdpQ+B+iQUIgoGUaAxOf4nNRS+kYjfd2p6belnb1XKgoRuTvz
 qr1vbp6/2ZF5HPM+v4yjGH560RA2cFg6u8w9m7s+IorNX0q5FKtDb38YOCIthOwA62d+XbLnuLR
 HXwlzrlDu21rpQlWpczBjk4m4JWjs7/n2O8RS1hasYvPnwoSRx4W8X9JnVPu6UnyGxHNqXQGZi4
 LJ4BEtImFbjZQlgSIkFgPdT82/53Caf2nd/TCIEqVSCZR7VyMob+dQXc8NQcegl2JKgwkCdi8GS
 BOCyVqIiHJdU8GMk8UoIKR8NE4KrWpLJnl3JuvoKlK333vgR8mlN/mYML4k8km1/WRdicPOoxy2
 uQUehHEjANGO2b8lMsN3Ei2KXuHyG73yWdcihBms+fGM1Gq1EemzwzSe2Rn5/EILTcsw==
X-Received: by 2002:a05:600c:8908:b0:48a:7a10:4f17 with SMTP id
 5b1f17b1804b1-48e51f21e0cmr269612975e9.6.1778510101780; 
 Mon, 11 May 2026 07:35:01 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6d8f6fa0sm65090725e9.16.2026.05.11.07.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 07:35:01 -0700 (PDT)
Message-ID: <7ffd40d0-704d-4082-85b8-8054ded0f428@linaro.org>
Date: Mon, 11 May 2026 16:35:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Replace abort() with g_assert_not_reached()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260506152353.1657838-1-clg@redhat.com>
 <7bfd11f9-66be-4e4f-8e9e-a031d848f890@linaro.org>
 <62e9d0a9-e787-47dd-9a6c-da520a587e09@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <62e9d0a9-e787-47dd-9a6c-da520a587e09@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/5/26 18:12, Cédric Le Goater wrote:
> On 5/7/26 15:16, Philippe Mathieu-Daudé wrote:
>> On 6/5/26 17:23, Cédric Le Goater wrote:
>>> This check was originally introduced in commit b3ebc10c373e
>>> ("vfio-pci: Add debug config options to disable MSI/X KVM support") as
>>> part of a debug block to retrieve the MSI/MSIX message, and was later
>>> moved by commit 0de70dc7bab1 ("vfio/pci: Rename MSI/X functions for
>>> easier tracing") into the main interrupt handling path, becoming
>>> production code.
>>>
>>> Under normal conditions, this code path cannot be reached because the
>>> BQL serializes all handler registration, vdev->interrupt updates, and
>>> handler removal. Replace abort() with g_assert_not_reached(), which is
>>> preferred nowdays, and add a comment clarifying the purpose.
>>>
>>> Cc: Alex Williamson <alex@shazbot.org>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   hw/vfio/pci.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 
>>> 09acd3f6082b0a9c5223780bf7e9847b57424cf7..7ca2ff4e7c1cb570cd60d35454b33b5506dae36e 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -453,7 +453,12 @@ static void vfio_msi_interrupt(void *opaque)
>>>           get_msg = msi_get_message;
>>>           notify = msi_notify;
>>>       } else {
>>> -        abort();
>>> +        /*
>>> +         * Interrupt state transitions (MSI/MSI-X -> NONE/INTx) are
>>> +         * protected by the BQL, and eventfd handlers are strictly
>>> +         * unregistered before vdev->interrupt is modified.
>>> +         */
>>> +        g_assert_not_reached();
>>>       }
>>
>> Could be more readable using switch(vdev->interrupt).
>>
> 
> I agree. But let's have another patch for it if you don't mind.
> This change is about the rational for the abort() and it was
> reported to the security list.

Sure, just suggesting, not aiming to block!

