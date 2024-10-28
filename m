Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EECED5B846
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 22:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5YEW-00028Q-TX; Mon, 28 Oct 2024 18:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5YEU-000285-UC
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 18:29:07 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5YET-0003zS-7U
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 18:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=/wXX8Y+cP1zNs8PZmc0ODTnEVpgArysQj+1HbjJ7Mwg=; b=MKVK0z83+WH+vY7U0od7/JmmjQ
 EH++spqMYN+jenC6kXyZa5XcBM3FUd3K7oOIpXiSYEa244FG7WQpV/OXvbIbUOhFpegft649l3Wxp
 MnXdwskgnkKWGN3MadvdRTDvfqknCV62KWAqFxY9hkxyI+dfPdSSZO4ljUoWl//s/2Dp8VPPOR4D2
 XMEEtX0KIMwjK/GcStHybylHl89qyQkOT7A7fQAnXq2mZgOmlRE/LWooSvIJRhNaUe7m+fP0+GX8v
 Z4hJ7OXJGC7gCg3hSZNxYouNqEA5Zvyeiy91RXEeA9pmhLUYDNShvy0qVDFPP4kO4m3r5521qo/Fh
 OKjVxV1wxQlKYnOB4b0S7suombCHMay7Xfv5bKWMndPJW6j1lQBI7uFc4gv6AnPdzq/9cAw+oFXN1
 iLlLiTCnr9z9tGF5jczYxxc+azxzCwMvUygKf7GZpebYl0HlZqyqg8eirhAA4KfwdrL35mLKZzMiA
 gXMtOa7hEMZlaLU5f4xnJLF/SHlMNrADNC/hk6Iv6pmNIb9vVKC++TKN6SACCxz4ilnD3I/Iz376+
 CZz80Frss6471gXxwesYfTNkTTlpSn/FiVfsb8NdIb1IsVc0gyZWQcwTOqHLEMrKZnLfDZaDaq36N
 spX7QLMbuNvj4cAWK+Jpij/xmBvTekyA7Z+B0A58c=;
Received: from [2a00:23c4:8bb8:f600:b5e6:5818:bcfd:7571]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5YE6-0006Zb-16; Mon, 28 Oct 2024 22:28:46 +0000
Message-ID: <0e056742-396c-4bc8-91a8-e0a9a4dfb805@ilande.co.uk>
Date: Mon, 28 Oct 2024 22:28:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-14-mark.cave-ayland@ilande.co.uk>
 <20241028173939.6fada306@tpx1>
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
In-Reply-To: <20241028173939.6fada306@tpx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:b5e6:5818:bcfd:7571
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 13/36] next-cube: move ESCC to be QOM child of next-pc
 device
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

On 28/10/2024 16:39, Thomas Huth wrote:
> Am Wed, 23 Oct 2024 09:58:29 +0100
> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> 
>> Since the ESCC is part of the next-pc device, move the ESCC to be a QOM child
>> of the next-pc device.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/next-cube.c | 54 ++++++++++++++++++++++-----------------------
>>   1 file changed, 26 insertions(+), 28 deletions(-)
>>
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> index 7f714640da..915dd80f6f 100644
>> --- a/hw/m68k/next-cube.c
>> +++ b/hw/m68k/next-cube.c
>> @@ -124,6 +124,8 @@ struct NeXTPC {
>>       qemu_irq scsi_reset;
>>       qemu_irq scsi_dma;
>>   
>> +    ESCCState escc;
>> +
>>       NextRtc rtc;
>>   };
>>   
>> @@ -978,31 +980,6 @@ static const MemoryRegionOps next_floppy_ops = {
>>       .endianness = DEVICE_BIG_ENDIAN,
>>   };
>>   
>> -static void next_escc_init(DeviceState *pcdev)
>> -{
>> -    NeXTPC *next_pc = NEXT_PC(pcdev);
>> -    DeviceState *dev;
>> -    SysBusDevice *s;
>> -
>> -    dev = qdev_new(TYPE_ESCC);
>> -    qdev_prop_set_uint32(dev, "disabled", 0);
>> -    qdev_prop_set_uint32(dev, "frequency", 9600 * 384);
>> -    qdev_prop_set_uint32(dev, "it_shift", 0);
>> -    qdev_prop_set_bit(dev, "bit_swap", true);
>> -    qdev_prop_set_chr(dev, "chrB", serial_hd(1));
>> -    qdev_prop_set_chr(dev, "chrA", serial_hd(0));
>> -    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
>> -    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
>> -
>> -    s = SYS_BUS_DEVICE(dev);
>> -    sysbus_realize_and_unref(s, &error_fatal);
>> -    sysbus_connect_irq(s, 0, qdev_get_gpio_in(pcdev, NEXT_SCC_I));
>> -    sysbus_connect_irq(s, 1, qdev_get_gpio_in(pcdev, NEXT_SCC_DMA_I));
>> -
>> -    memory_region_add_subregion(&next_pc->scrmem, 0x18000,
>> -                                sysbus_mmio_get_region(s, 0));
>> -}
>> -
>>   static void next_pc_reset(DeviceState *dev)
>>   {
>>       NeXTPC *s = NEXT_PC(dev);
>> @@ -1043,6 +1020,28 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
>>       /* Floppy */
>>       memory_region_add_subregion(&s->scrmem, 0x14108,
>>                                   &s->floppy_mem);
>> +
>> +    /* ESCC */
>> +    d = DEVICE(object_resolve_path_component(OBJECT(dev), "escc"));
>> +    qdev_prop_set_uint32(d, "disabled", 0);
>> +    qdev_prop_set_uint32(d, "frequency", 9600 * 384);
>> +    qdev_prop_set_uint32(d, "it_shift", 0);
>> +    qdev_prop_set_bit(d, "bit_swap", true);
>> +    qdev_prop_set_chr(d, "chrB", serial_hd(1));
>> +    qdev_prop_set_chr(d, "chrA", serial_hd(0));
>> +    qdev_prop_set_uint32(d, "chnBtype", escc_serial);
>> +    qdev_prop_set_uint32(d, "chnAtype", escc_serial);
>> +
>> +    sbd = SYS_BUS_DEVICE(d);
>> +    if (!sysbus_realize(sbd, errp)) {
>> +        return;
>> +    }
>> +    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(dev, NEXT_SCC_I));
>> +    sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(dev, NEXT_SCC_DMA_I));
>> +
>> +    memory_region_add_subregion(&s->scrmem, 0x18000,
>> +                                sysbus_mmio_get_region(sbd, 0));
> 
> You could also keep the next_escc_init() function, and call next_escc_init()
> here?

Normally a non-QOM _init() function suffix is used to both init() and realize() a 
device, whereas here since the ESCC device is a child of the next-pc device these 
operations must be separate. I think I can see why this convention is used elsewhere 
in the codebase, as otherwise you end up calling a function with a _init() prefix 
from _realize() which can get confusing with respect to the QOM model...


ATB,

Mark.

>>   }
>>   
>>   static void next_pc_init(Object *obj)
>> @@ -1064,6 +1063,8 @@ static void next_pc_init(Object *obj)
>>   
>>       memory_region_init_io(&s->floppy_mem, OBJECT(s), &next_floppy_ops, s,
>>                             "next.floppy", 4);
>> +
>> +    object_initialize_child(obj, "escc", &s->escc, TYPE_ESCC);
>>   }
>>   
>>   /*
>> @@ -1201,9 +1202,6 @@ static void next_cube_init(MachineState *machine)
>>           }
>>       }
>>   
>> -    /* Serial */
>> -    next_escc_init(pcdev);
>> -
>>       /* TODO: */
>>       /* Network */
>>   
> 


