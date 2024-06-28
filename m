Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0850C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNE0C-00041U-4E; Fri, 28 Jun 2024 11:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sNE0B-00040v-3w; Fri, 28 Jun 2024 11:59:07 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sNE09-00008Y-EF; Fri, 28 Jun 2024 11:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=88q6QsvzK8snkGC9N98GoCO3COc/YBXSMlIIp23Hx0E=; b=HRCqdCu7JXq+PScTcyTNOfCh2k
 nvs89eWF9sKLv+GuzYgFKvQvRaHEk6Itrz6HoRGfU+/ySFL8MVoRIRM8Uq7OHI1Dxr66S3Uuo9aji
 ZfjXj3jgCUJdgmcajnsQjwLdsEO7IoBFb5MPe+PoP4P7vn+nCHDLuhyvgDA36acTHL6OAYJsegrkq
 i/4Q9ZGE/8bs4MmrUQ+2p9AISmuoc0dXhzisIcB1kF4TGFPcJlX2CAsP8JDGAy7Kh3AE+xXgiiMTK
 JlXHJ/eRp546Yg2JYzAsP0oUEjveydCt4Qk1K+swZ3oZ9UxlulS1ItRooARQc/L6CXINdMwIkDpQv
 P9/oH8RGgJYVw1NHke8z1WDwCaZDyl1QGNaeeyfITlfgj79R+Gfptl6VF82kelIXmWr3mC/zzdudF
 JVBJFPSx8hY0pWDcSFkoOYGqz2/KLny7s6LsSe+52ppXUWKuLHkoLPJ+1aq0eOoSPncVIUtPhj76+
 8onWa99hRWE+WmFIjp8e6Lr92GBDU9TBes4wz79eC9/kyt3R7AjfMtCPdt7+BdsFAVKran8pM1bMO
 uboKyhMSZyT5HDdr2QIJLrbp3aIyoRiUseMlHg9QSf7Au7Lh4GyTn03DLLSPVXsOvZBW36yx33ebk
 7xX0DQwzslgezT3vnf/eUJcU6wVcdxe7aF4u4QHOY=;
Received: from [2a00:23c4:8bb4:4000:71e:fc91:de8e:dcdf]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sNDyh-000Cj2-AS; Fri, 28 Jun 2024 16:57:39 +0100
Message-ID: <afa03da5-d02d-4a90-839c-b03d41b7b74d@ilande.co.uk>
Date: Fri, 28 Jun 2024 16:58:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 akihiko.odaki@daynix.com
References: <20240628105437.635079-1-mark.cave-ayland@ilande.co.uk>
 <CAFEAcA9A67=qkLfwZgg1DgzQA9+fW34Uv7+pYcmGY4Yz=3xzPw@mail.gmail.com>
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
In-Reply-To: <CAFEAcA9A67=qkLfwZgg1DgzQA9+fW34Uv7+pYcmGY4Yz=3xzPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:71e:fc91:de8e:dcdf
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/ide/macio.c: switch from using qemu_allocate_irq() to
 qdev input GPIOs
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

On 28/06/2024 16:28, Peter Maydell wrote:

> On Fri, 28 Jun 2024 at 11:55, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> This prevents the IRQs from being leaked when the macio IDE device is used.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/ide/macio.c                | 10 ++++++----
>>   include/hw/misc/macio/macio.h |  5 +++++
>>   2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
>> index aca90d04f0..e84bf2c9f6 100644
>> --- a/hw/ide/macio.c
>> +++ b/hw/ide/macio.c
>> @@ -420,7 +420,8 @@ static void macio_ide_realizefn(DeviceState *dev, Error **errp)
>>   {
>>       MACIOIDEState *s = MACIO_IDE(dev);
>>
>> -    ide_bus_init_output_irq(&s->bus, s->ide_irq);
>> +    ide_bus_init_output_irq(&s->bus,
>> +                            qdev_get_gpio_in(dev, MACIO_IDE_PMAC_IDE_IRQ));
>>
>>       /* Register DMA callbacks */
>>       s->dma.ops = &dbdma_ops;
>> @@ -456,8 +457,8 @@ static void macio_ide_initfn(Object *obj)
>>       sysbus_init_mmio(d, &s->mem);
>>       sysbus_init_irq(d, &s->real_ide_irq);
>>       sysbus_init_irq(d, &s->real_dma_irq);
>> -    s->dma_irq = qemu_allocate_irq(pmac_ide_irq, s, 0);
>> -    s->ide_irq = qemu_allocate_irq(pmac_ide_irq, s, 1);
>> +
>> +    qdev_init_gpio_in(DEVICE(obj), pmac_ide_irq, MACIO_IDE_PMAC_NIRQS);
>>
>>       object_property_add_link(obj, "dbdma", TYPE_MAC_DBDMA,
>>                                (Object **) &s->dbdma,
>> @@ -508,7 +509,8 @@ void macio_ide_init_drives(MACIOIDEState *s, DriveInfo **hd_table)
>>
>>   void macio_ide_register_dma(MACIOIDEState *s)
>>   {
>> -    DBDMA_register_channel(s->dbdma, s->channel, s->dma_irq,
>> +    DBDMA_register_channel(s->dbdma, s->channel,
>> +                           qdev_get_gpio_in(DEVICE(s), MACIO_IDE_PMAC_DMA_IRQ),
>>                              pmac_ide_transfer, pmac_ide_flush, s);
>>   }
>>
>> diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
>> index 2b54da6b31..869b66055b 100644
>> --- a/include/hw/misc/macio/macio.h
>> +++ b/include/hw/misc/macio/macio.h
>> @@ -92,6 +92,11 @@ struct MACIOIDEState {
>>       uint32_t irq_reg;
>>   };
>>
>> +#define MACIO_IDE_PMAC_NIRQS 2
>> +
>> +#define MACIO_IDE_PMAC_DMA_IRQ 0
>> +#define MACIO_IDE_PMAC_IDE_IRQ 1
>> +
>>   void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
>>   void macio_ide_register_dma(MACIOIDEState *ide);
> 
> Can we also now delete the dma_irq and ide_irq fields from the
> MACIOIDEState struct?
> 
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Ooops, yes. I'll update and send a v2 including your Reviewed-by tag.


ATB,

Mark.


