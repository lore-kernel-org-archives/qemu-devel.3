Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D5BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 21:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOOKy-0006ZQ-T5; Mon, 01 Jul 2024 17:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sOOKw-0006ZC-GJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:13:22 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sOOKu-0005Rs-Rr
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=luwaS2VJ74gp1JKBj2IYkay/2cvM1hmmKr5TTgN7A7U=; b=OXEkAVxZXTmT73WAgakeThVCy9
 wKKLlD8+mZF2E7WDO2T/TAG64WpliyAv5XG5oUHJr+sJSIJHyH28j1fmQpclCWtOQ8fwLu/iV/Vcd
 FODcq1DBy0QD7S7kD/tJKnsI7IJ1dPtC/cNxMKsdYmw9Houn89mEgXcKjuk4rP5gxEvwHB6J7DVjp
 XihfxQs6rD7tajE5kWMeBq2w1JJsIXGNeV26m6kNY/rx3EigYp1GXtHk1y/nCnlMcXeA8yHEWEWNe
 +XFJL08zlQ0V0gt50j+rxOU11Ozr1IslkiK0soEcTYCc2zGipdCX0RzZ7Qo14oBXtWu5n6KDzGZnS
 XnYxdpB4WSx3MIaBSovfzzKDQ/6wtaM0vn6smEb/LPqCQfy0nOP8TjAUZnsEzbETmP8eINdx0BKtt
 lzEHedhLKBkpYSurcNz4tfwYgwkaHUsdbEHboIpvgPEBbAKB19n1IDZ7v6amoZjeuRKUG2iX6eAiL
 oaVhyPf1wkt9gbW6heRZVOwOpDzAbd2/qeQuOb/WbpvmrkzZLjak/35TDaFRP0SHxjZcqzBGKDLMA
 dscsC2/PSyNkWDGQk01n3hGHTA2j4pQHg7OMNPQZY7uqGbsb5/NuW09cmXubh96fSU+zd/0aWjxPo
 hZRmkvjtdEXQue2Zqv+hMHHAHXSuIAmR7ASlLIono=;
Received: from [2a00:23c4:8bb4:4000:a4da:be8a:f5f6:663]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sOOJR-0006Nv-Lr; Mon, 01 Jul 2024 22:11:53 +0100
Message-ID: <1981f4ab-ea0b-4e14-bd57-fd95f5fb9a67@ilande.co.uk>
Date: Mon, 1 Jul 2024 22:13:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1719690591.git.balaton@eik.bme.hu>
 <b70b9e72063b4dd4005bf4bc040b84f2bb617bf4.1719690591.git.balaton@eik.bme.hu>
 <CAFEAcA_tBjQrJMpjbzVUVcrTWghr4v=MHB0qpWx=xjML6ek9mg@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <CAFEAcA_tBjQrJMpjbzVUVcrTWghr4v=MHB0qpWx=xjML6ek9mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:a4da:be8a:f5f6:663
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/2] hw/isa/vt82c686.c: Embed i8259 irq in device state
 instead of allocating
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 01/07/2024 13:58, Peter Maydell wrote:

> On Sat, 29 Jun 2024 at 21:01, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> To avoid a warning about unfreed qemu_irq embed the i8259 irq in the
>> device state instead of allocating it.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/isa/vt82c686.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>> index 8582ac0322..834051abeb 100644
>> --- a/hw/isa/vt82c686.c
>> +++ b/hw/isa/vt82c686.c
>> @@ -592,6 +592,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaISAState, VIA_ISA)
>>
>>   struct ViaISAState {
>>       PCIDevice dev;
>> +
>> +    IRQState i8259_irq;
>>       qemu_irq cpu_intr;
>>       qemu_irq *isa_irqs_in;
>>       uint16_t irq_state[ISA_NUM_IRQS];
>> @@ -715,13 +717,12 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>>       ViaISAState *s = VIA_ISA(d);
>>       DeviceState *dev = DEVICE(d);
>>       PCIBus *pci_bus = pci_get_bus(d);
>> -    qemu_irq *isa_irq;
>>       ISABus *isa_bus;
>>       int i;
>>
>>       qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>>       qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
>> -    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
>> +    qemu_init_irq(&s->i8259_irq, via_isa_request_i8259_irq, s, 0);
>>       isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
>>                             errp);
> 
> So if I understand correctly, this IRQ line isn't visible
> from outside this chip, we're just trying to wire together
> two internal components of the chip? If so, I agree that
> this seems a better way than creating a named GPIO that
> we then have to document as a "not really an external
> connection, don't try to use this" line. (We've done that
> before I think in other devices, and it works but it's
> a bit odd-looking.)

It's basically wiring up the 8259 PIC (ISA) IRQs which aren't implemented using qdev 
gpios to an internal IRQ handler.

If the 8259 PIC (ISA) IRQs were already converted to qdev gpios, then presumably 
using a qdev gpio would be the correct solution for this? I'm conscious that if we do 
decide to introduce another method for wiring IRQs then there should be clear 
criteria for developers and reviewers as to which method is appropriate for each use 
case.


ATB,

Mark.


