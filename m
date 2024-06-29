Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631D7C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 07:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNSfq-000261-83; Sat, 29 Jun 2024 03:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNSfo-00025R-QG
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 03:39:04 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNSfm-0000Z7-US
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 03:39:04 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d5611cdcb7so556200b6e.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 00:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719646741; x=1720251541;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jnu1gpcS7c3CsP6qDOLvRj3hvHDyAB96I1VjhV40Y1U=;
 b=j9MLYyzbL7zQonNfDNbZI738OI9Rz7Uv6yetIYDaM7Iu4capB54bcPpQ2/y+chbBam
 7iPa5QP5GQ03UR0cxY8rgB0XwlfOf7ZP/F/0EdUoX6wzhQNGkYxDK7xxpLcALenzaOLs
 q/JFFFFgVSW9To3rbCqG0SCrjdAV/AezvpGeUkQycoY4P7gCNczK7MUYZilQmya/v5y6
 /B1qIgKj8awMxjHtL/ffKxsTVupAtD1Dsqlz1lfbz1MVVbWIxd/hMvSfaVnbcWczcfI0
 fBJUabCqxKLsfIpXtdxysqr38pTZOOAXjzyILop9Jbi/0tc6Xlw8YZzzFMTwUenunXzF
 IPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719646741; x=1720251541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jnu1gpcS7c3CsP6qDOLvRj3hvHDyAB96I1VjhV40Y1U=;
 b=R27xIiOE7slT8JAJD0tYE5cf/DUnPaK90gGEsV5KO6N0FMMyr8LdpQGUp/EdQCPlH/
 lcZ162Ylu18Wr3ND1sTB4UIO0hf73F/iCcHaIBxUozg52O/ui84O9GZSneznZZdCpCsB
 Q8m1iDcUJmAZhC0Tx+Y9miStXTQaW8mvHO4iMMBLseKR/PhBtX/KNegKoA1x4AodJL1e
 gEQ5TOdAdUo2/eKm3dqaxTaUI0WOPkjnU7A4Th2qet0bGP0Yl0jg6qYkxdKQ6zKDnaOB
 pf10cntFDXKbClhzgzdAsQgfjWCnsEgLJ9K7dHAM/gkvdGbQ61h6CNZc0dbrKWDp+Ef2
 fZNw==
X-Gm-Message-State: AOJu0YzAFZeAk8WpBja6uqhYD2Vku70UOyIcrM4kysBsWlDqCTC0hDmQ
 PHyNqrYoPqTGtd4CLzSGleZ3PHVC8UxXCdYqJJcuJi5TyV+Dziu0UY4h+1kchfQ=
X-Google-Smtp-Source: AGHT+IGq37kKH5+69LZfqlxIOQHNAXIDcQAH1fxARWPEAqsAwsgq8E7lX2pAi+WpBwT/HbixVSWxrQ==
X-Received: by 2002:a05:6808:10c8:b0:3d6:ac96:72c9 with SMTP id
 5614622812f47-3d6b37b5647mr431634b6e.34.1719646740667; 
 Sat, 29 Jun 2024 00:39:00 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803fc8b67sm2727107b3a.128.2024.06.29.00.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 00:39:00 -0700 (PDT)
Message-ID: <9aaf73e3-3080-44c9-9e29-b0e4b4398c3d@daynix.com>
Date: Sat, 29 Jun 2024 16:38:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] hw/isa/vt82c686: Define a GPIO line between
 vt82c686 and i8259
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-4-750bb0946dbd@daynix.com>
 <075008cd-be83-4695-a60a-9bd5f6c9a4d2@ilande.co.uk>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <075008cd-be83-4695-a60a-9bd5f6c9a4d2@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::232;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/06/28 16:27, Mark Cave-Ayland wrote:
> On 27/06/2024 14:37, Akihiko Odaki wrote:
> 
>> This fixes qemu_irq array leak.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/isa/vt82c686.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>> index 8582ac0322eb..629d2d568137 100644
>> --- a/hw/isa/vt82c686.c
>> +++ b/hw/isa/vt82c686.c
>> @@ -715,13 +715,14 @@ static void via_isa_realize(PCIDevice *d, Error 
>> **errp)
>>       ViaISAState *s = VIA_ISA(d);
>>       DeviceState *dev = DEVICE(d);
>>       PCIBus *pci_bus = pci_get_bus(d);
>> -    qemu_irq *isa_irq;
>> +    qemu_irq isa_irq;
>>       ISABus *isa_bus;
>>       int i;
>>       qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>>       qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
>> -    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
>> +    qdev_init_gpio_in_named(dev, via_isa_request_i8259_irq, "i8259", 1);
>> +    isa_irq = qdev_get_gpio_in_named(dev, "i8259", 0);
>>       isa_bus = isa_bus_new(dev, pci_address_space(d), 
>> pci_address_space_io(d),
>>                             errp);
>> @@ -729,7 +730,7 @@ static void via_isa_realize(PCIDevice *d, Error 
>> **errp)
>>           return;
>>       }
>> -    s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
>> +    s->isa_irqs_in = i8259_init(isa_bus, isa_irq);
>>       isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
>>       i8254_pit_init(isa_bus, 0x40, 0, NULL);
>>       i8257_dma_init(OBJECT(d), isa_bus, 0);
> 
> Have you confirmed that the machines using the VIA can still boot 
> correctly with this change? I have a vague memory that Phil tried 
> something like this, but due to legacy code poking around directly in 
> the ISA IRQ array after realize it caused some things to break.

I tried to boot MorphOS on pegasos2 but it didn't boot even with QEMU 
9.0.1. The command line I used is:

qemu-system-ppc -M pegasos2 -rtc base=localtime -device 
ati-vga,guest_hwcursor=true,romfile= -cdrom morphos-3.18.iso -kernel 
boot.img -serial stdio

That said, I believe no such code remain now. The IRQ array is held in a 
variable local in this function and nobody else can refer to it.

Regards,
Akihiko Odaki

