Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA41D3ABF7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 21:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAbzO-0007tf-0u; Mon, 11 Nov 2024 16:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tAbzM-0007tW-LX
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 16:30:24 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tAbzI-00012u-IL
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 16:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ntvK64JGABWZBzPpef3DCvHRD9R+NEFfYKfM5llVyNk=; b=rRrptUcQbzvU9uCGtVSZW986ah
 F8rGMnl6vu5LCk2tOj/vG7XI2xnr5WfvuUFXTDQh1uvzytqDukb3znGSHBHmY5pAEQycCB0Gsb4Td
 pHxDkGK8tApuk8sAm9b2cs+fxIQrm3VYwr7+4MJiT0xkoqXJdL/4o84HaFfsVC00v4gvbXO5Np6Sq
 6Y49BiWMbjOIi9BhSdpybi4C4ojg91YOu5AQ7C/ge0/DxnOuiYmg3BPYQKdD9AXJVFTDXAK5b9agU
 qpEx6gW0klw/TVDlk8nxurIPl/N8udeNczYKntt/pE2f8RiRXmsPyuoImm5DDOkHYrk8ELQHJKsW0
 g8kINLxrg/1zvG/uvLqHV9Qmc4tLieH036BcHyGVDHKLg3exC4fETySjxYjedqNUJLHZT/rH2mWY+
 0jgwPP7dIV+s7Tk0lFfQ138THKLNeQHWASJn+h9eJ2wV5PIT5yaFmmJ2o1N8SzZ/dsHcfVf/V4V0p
 uSimrAnq6NkKuMUJCsTHhrBvz9Mnih7U8yTlEmKM9OyAuM4Bh7jpAzwMYtW6W/0kwJc6zW4Q12QzO
 KaAZ7vFAtMeZVTGacDFM7AyJ7xVK+3+zpBxM5ex2mDeAVa/h8ClLjr2PIHPnuAWCWzTnTkESxSCtA
 /dEjq37f2stUoCsm3fKtr7LP7cRqrjz/ov0+Y3jZ8=;
Received: from [2a00:23c4:8bb8:f600:4d41:7cfb:3f13:ce94]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tAbyn-0004tq-4v; Mon, 11 Nov 2024 21:29:53 +0000
Message-ID: <d24f1068-b75a-4184-a26f-0bc4a4631048@ilande.co.uk>
Date: Mon, 11 Nov 2024 21:30:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-28-mark.cave-ayland@ilande.co.uk>
 <20241109091426.0f636645@tpx1>
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
In-Reply-To: <20241109091426.0f636645@tpx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:4d41:7cfb:3f13:ce94
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 27/36] next-cube: QOMify NeXTRTC
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

On 09/11/2024 08:14, Thomas Huth wrote:

> Am Wed, 23 Oct 2024 09:58:43 +0100
> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> 
>> This is to allow the RTC functionality to be maintained within its own separate
>> device.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/next-cube.c | 66 ++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 48 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> index e4d0083eb0..6b574d39cf 100644
>> --- a/hw/m68k/next-cube.c
>> +++ b/hw/m68k/next-cube.c
>> @@ -42,7 +42,13 @@
>>   #define RAM_SIZE    0x4000000
>>   #define ROM_FILE    "Rev_2.5_v66.bin"
>>   
>> -typedef struct NeXTRTC {
>> +
>> +#define TYPE_NEXT_RTC "next-rtc"
>> +OBJECT_DECLARE_SIMPLE_TYPE(NeXTRTC, NEXT_RTC)
>> +
>> +struct NeXTRTC {
>> +    SysBusDevice parent_obj;
>> +
>>       int8_t phase;
>>       uint8_t ram[32];
>>       uint8_t command;
>> @@ -50,7 +56,7 @@ typedef struct NeXTRTC {
>>       uint8_t status;
>>       uint8_t control;
>>       uint8_t retval;
>> -} NeXTRTC;
>> +};
>>   
>>   #define TYPE_NEXT_SCSI "next-scsi"
>>   OBJECT_DECLARE_SIMPLE_TYPE(NeXTSCSI, NEXT_SCSI)
>> @@ -1012,6 +1018,37 @@ static const MemoryRegionOps next_dummy_en_ops = {
>>       .endianness = DEVICE_BIG_ENDIAN,
>>   };
>>   
>> +static const VMStateDescription next_rtc_vmstate = {
>> +    .name = "next-rtc",
>> +    .version_id = 3,
>> +    .minimum_version_id = 3,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_INT8(phase, NeXTRTC),
>> +        VMSTATE_UINT8_ARRAY(ram, NeXTRTC, 32),
>> +        VMSTATE_UINT8(command, NeXTRTC),
>> +        VMSTATE_UINT8(value, NeXTRTC),
>> +        VMSTATE_UINT8(status, NeXTRTC),
>> +        VMSTATE_UINT8(control, NeXTRTC),
>> +        VMSTATE_UINT8(retval, NeXTRTC),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>> +static void next_rtc_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->desc = "NeXT RTC";
>> +    dc->vmsd = &next_rtc_vmstate;
>> +}
>> +
>> +static const TypeInfo next_rtc_info = {
>> +    .name = TYPE_NEXT_RTC,
>> +    .parent = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(NeXTRTC),
>> +    .class_init = next_rtc_class_init,
>> +};
>> +
>>   static void next_pc_rtc_data_in_irq(void *opaque, int n, int level)
>>   {
>>       NeXTPC *s = NEXT_PC(opaque);
>> @@ -1078,6 +1115,12 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
>>       }
>>       sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(dev, NEXT_SCC_I));
>>       sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(dev, NEXT_SCC_DMA_I));
>> +
>> +    /* RTC */
>> +    d = DEVICE(object_resolve_path_component(OBJECT(dev), "rtc"));
>> +    if (!sysbus_realize(SYS_BUS_DEVICE(d), errp)) {
>> +        return;
>> +    }
>>   }
>>   
>>   static void next_pc_init(Object *obj)
>> @@ -1111,6 +1154,8 @@ static void next_pc_init(Object *obj)
>>                             "next.timer", 4);
>>       sysbus_init_mmio(sbd, &s->timer_mem);
>>   
>> +    object_initialize_child(obj, "rtc", &s->rtc, TYPE_NEXT_RTC);
>> +
>>       s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
>>       qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
>>                               "pc-rtc-data-in", 1);
>> @@ -1129,22 +1174,6 @@ static Property next_pc_properties[] = {
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> -static const VMStateDescription next_rtc_vmstate = {
>> -    .name = "next-rtc",
>> -    .version_id = 2,
>> -    .minimum_version_id = 2,
>> -    .fields = (const VMStateField[]) {
>> -        VMSTATE_INT8(phase, NeXTRTC),
>> -        VMSTATE_UINT8_ARRAY(ram, NeXTRTC, 32),
>> -        VMSTATE_UINT8(command, NeXTRTC),
>> -        VMSTATE_UINT8(value, NeXTRTC),
>> -        VMSTATE_UINT8(status, NeXTRTC),
>> -        VMSTATE_UINT8(control, NeXTRTC),
>> -        VMSTATE_UINT8(retval, NeXTRTC),
>> -        VMSTATE_END_OF_LIST()
>> -    },
>> -};
>> -
>>   static const VMStateDescription next_pc_vmstate = {
>>       .name = "next-pc",
>>       .version_id = 3,
>> @@ -1297,6 +1326,7 @@ static void next_register_type(void)
>>       type_register_static(&next_typeinfo);
>>       type_register_static(&next_pc_info);
>>       type_register_static(&next_scsi_info);
>> +    type_register_static(&next_rtc_info);
>>   }
>>   
>>   type_init(next_register_type)
> 
> Shouldn't the next_rtc_vmstate get removed from next_pc_vmstate now?

Indeed, yes it should. I'll fix that up for v2.

> Also, should we finally move the RTC code to a separate file?

I was thinking about whether it was worth splitting up next-cube.c whilst writing 
this series, but I didn't come up with a solution I was completely happy with. It is 
certainly something to reconsider in future though.


ATB,

Mark.


