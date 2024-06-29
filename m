Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2503C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 08:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNT4p-0005YY-5H; Sat, 29 Jun 2024 04:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNT4n-0005Y5-Id
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:04:53 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNT4l-0003Wt-PP
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:04:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f9cd92b146so8631045ad.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 01:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719648290; x=1720253090;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TVhC+K0GrV/QZrkGMygXHBZIypadX6zpRFRDsXbMhj0=;
 b=FpjRILsJ/qFQxfuhwEugC6s3AdD6GEcprfeGBiZakrtCcrUNYgVPjjZRfcxPSRDCVw
 TeHPnrbbqzMPEihZvIPLph17t78DMexqTM6E6GIabQF/5/IymkDzjklj99yaLRip7TMe
 o5cIDVw7uvIk+1DOwT+mJ7duBWEzrMxyACdydhhhHFkS8tyq8Os5FLz0mmrF3YU7PZVL
 HSNopOGt7C3+dY/qIz9FZl7ZG2ho7R9GUSr6uHvVRYxi1mwHB3TVY1ZQ8fi1/N9sSFaK
 zZp9Uoou8o4VekCly6sAp9k3eD4KngRcm5T3vKO6GmR2B5UMhArIJ8MYCMiXcjR6/a0J
 r6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719648290; x=1720253090;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TVhC+K0GrV/QZrkGMygXHBZIypadX6zpRFRDsXbMhj0=;
 b=OC4aR5WoSGo5xHHXIApjj6/CTTq62qidTvn8bkdAjoWMw2usoV6uW57+4vd8auPCXC
 +gMiqzTyMwI7cS0nl4I9evbWatA94BnOeS+JuT2161ayBkQHYpNj4xGW8g3toHQJhX9p
 mI9Za5GRa21YDRcVXJAvOC/PD8II3R4aPsknZJzDWFuAvBb63c9VkxigMqB9K9mCMc91
 uIUP7IQI00C5ReaO/ZKzSg169F0/aguHJqYHMykyRUQBdM3KS9wdG0u96WbqP+kui/gb
 VBNwe29ubWiJJJioWL8DtoiNibOXzAirEpnEweTh52V5TRhKqjyQilbG1KMb/VVmOjew
 nN2g==
X-Gm-Message-State: AOJu0YygLbwy/3pyasPgOiFeZJZwmVCQ7aN5CeujPQkIjrUaQzvJ8zjA
 MRl88cjp83NCKVIcqhGrKqReJR43K2nc+65zg9B6uqCDMFWi2lIJkU8ofSPvYZ0XLPU5ItRmrAi
 DoHk=
X-Google-Smtp-Source: AGHT+IGDvxjMCaHjAaMj0pjczI99Qcp9qA8BaN79HyeP1OlOLB8tVgB7Wm0J4vN/i6RxsBb1uK/MwQ==
X-Received: by 2002:a17:90a:bb85:b0:2c8:6360:7d44 with SMTP id
 98e67ed59e1d1-2c93d775fa9mr322095a91.42.1719648290153; 
 Sat, 29 Jun 2024 01:04:50 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce42667sm2815468a91.16.2024.06.29.01.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 01:04:49 -0700 (PDT)
Message-ID: <155767a3-58e8-4b64-be3d-c5f89db82606@daynix.com>
Date: Sat, 29 Jun 2024 17:04:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] hw/isa/vt82c686: Define a GPIO line between
 vt82c686 and i8259
From: Akihiko Odaki <akihiko.odaki@daynix.com>
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
 <9aaf73e3-3080-44c9-9e29-b0e4b4398c3d@daynix.com>
Content-Language: en-US
In-Reply-To: <9aaf73e3-3080-44c9-9e29-b0e4b4398c3d@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/06/29 16:38, Akihiko Odaki wrote:
> On 2024/06/28 16:27, Mark Cave-Ayland wrote:
>> On 27/06/2024 14:37, Akihiko Odaki wrote:
>>
>>> This fixes qemu_irq array leak.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   hw/isa/vt82c686.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>>> index 8582ac0322eb..629d2d568137 100644
>>> --- a/hw/isa/vt82c686.c
>>> +++ b/hw/isa/vt82c686.c
>>> @@ -715,13 +715,14 @@ static void via_isa_realize(PCIDevice *d, Error 
>>> **errp)
>>>       ViaISAState *s = VIA_ISA(d);
>>>       DeviceState *dev = DEVICE(d);
>>>       PCIBus *pci_bus = pci_get_bus(d);
>>> -    qemu_irq *isa_irq;
>>> +    qemu_irq isa_irq;
>>>       ISABus *isa_bus;
>>>       int i;
>>>       qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>>>       qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
>>> -    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
>>> +    qdev_init_gpio_in_named(dev, via_isa_request_i8259_irq, "i8259", 
>>> 1);
>>> +    isa_irq = qdev_get_gpio_in_named(dev, "i8259", 0);
>>>       isa_bus = isa_bus_new(dev, pci_address_space(d), 
>>> pci_address_space_io(d),
>>>                             errp);
>>> @@ -729,7 +730,7 @@ static void via_isa_realize(PCIDevice *d, Error 
>>> **errp)
>>>           return;
>>>       }
>>> -    s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
>>> +    s->isa_irqs_in = i8259_init(isa_bus, isa_irq);
>>>       isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
>>>       i8254_pit_init(isa_bus, 0x40, 0, NULL);
>>>       i8257_dma_init(OBJECT(d), isa_bus, 0);
>>
>> Have you confirmed that the machines using the VIA can still boot 
>> correctly with this change? I have a vague memory that Phil tried 
>> something like this, but due to legacy code poking around directly in 
>> the ISA IRQ array after realize it caused some things to break.
> 
> I tried to boot MorphOS on pegasos2 but it didn't boot even with QEMU 
> 9.0.1. The command line I used is:
> 
> qemu-system-ppc -M pegasos2 -rtc base=localtime -device 
> ati-vga,guest_hwcursor=true,romfile= -cdrom morphos-3.18.iso -kernel 
> boot.img -serial stdio

Apparently I failed to run it properly. I tried again now and it booted 
with this change.

Regards,
Akihiko Odaki

> 
> That said, I believe no such code remain now. The IRQ array is held in a 
> variable local in this function and nobody else can refer to it.

