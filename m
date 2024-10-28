Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6940ED5B845
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 22:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Y79-0008N6-N2; Mon, 28 Oct 2024 18:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5Y78-0008Lp-5J
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 18:21:30 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5Y76-0003Iw-78
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 18:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=FCDDP2ztBT60fQlMy88L38XWdWYWs0Eoyc2hxnH1Rig=; b=O7GMir7u0KTVKhzuiYXVvRJH2Y
 S5Rf9hkHPbaagkbBFseCNB7h1DNqzENXdMcFbOxvroV3BkEVuVCyiEp4Kf528XhDxl14AAhMCyxkz
 nPpVAXq/dFKf+DvVYtSbW9A4AFCCAZQtLbikarVzfJGxjBD55r5IluKGZD8OkzhtMUmlTcqLgDQ0j
 4VgT2k/almrdriuSZZxRHaQnuVWcnU4c58En84QPlrQG910IgFgTT+X5q3rgLYhiQKcAWNzCwxHF/
 vowjuVvhP9ob0mxBEIW3EchpUYb9uE/pFZRmF6GRklMR22ZU3pvnK6KFML0WkpbKHdgD+8q4WVj0d
 AGSd0rzHxsedXyVpA19+XVK9E4b0Jt0fTzjD1iszDcE/TbGHB0wyTDadOqTdDoYs5GebtgYFq5mG2
 vtZzxeK7MXi9uui6xSzfSU701OhE8btLqbDJN+rcU3AAyWqYzR1z0UUNvBEtY9ZeuYGhgNLV0IFeu
 NsDx+Thl/CxPqOmGW+OBQD4bpHa9b4hXs+PR/w1quP1qNlfp79oXr0b+YaQmL+rAj42a0kAN7sj2U
 ZkmbVLn0CERLq3KU940GD4s08Wc+dDHjAMPqXP7J00yGnKbndfSd4ZDLWheweGs0K/KuyMCyw9Imd
 zEI7qwzF28UwIXWdZF47qsfUs0vjwl9NVxbFIPCd4=;
Received: from [2a00:23c4:8bb8:f600:b5e6:5818:bcfd:7571]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5Y6j-0006V5-AZ; Mon, 28 Oct 2024 22:21:09 +0000
Message-ID: <a6df2717-e3b3-464e-87ca-d2c776d24900@ilande.co.uk>
Date: Mon, 28 Oct 2024 22:21:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-10-mark.cave-ayland@ilande.co.uk>
 <20241028172122.23bcb98c@tpx1>
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
In-Reply-To: <20241028172122.23bcb98c@tpx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:b5e6:5818:bcfd:7571
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 09/36] next-cube: move SCSI CSRs from next-pc to the
 next-scsi device
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

On 28/10/2024 16:21, Thomas Huth wrote:

> Am Wed, 23 Oct 2024 09:58:25 +0100
> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> 
>> The SCSI CSRs are located within the SCSI subsystem of the NeXT PC (Peripheral
>> Contoller) which is now modelled as a separate QEMU device.
>>
>> Add a new VMStateDescription for the next-scsi device to enable the SCSI CSRs
>> to be migrated.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/next-cube.c | 88 +++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 78 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> index 266f57ac63..32466a425f 100644
>> --- a/hw/m68k/next-cube.c
>> +++ b/hw/m68k/next-cube.c
>> @@ -93,6 +93,10 @@ struct NeXTSCSI {
>>       MemoryRegion scsi_mem;
>>   
>>       SysBusESPState sysbus_esp;
>> +
>> +    MemoryRegion scsi_csr_mem;
>> +    uint8_t scsi_csr_1;
>> +    uint8_t scsi_csr_2;
>>   };
>>   
>>   #define TYPE_NEXT_PC "next-pc"
>> @@ -115,8 +119,6 @@ struct NeXTPC {
>>       uint32_t led;
>>   
>>       NeXTSCSI next_scsi;
>> -    uint8_t scsi_csr_1;
>> -    uint8_t scsi_csr_2;
>>   
>>       qemu_irq scsi_reset;
>>       qemu_irq scsi_dma;
>> @@ -364,6 +366,7 @@ static const MemoryRegionOps next_mmio_ops = {
>>   static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
>>   {
>>       NeXTPC *s = NEXT_PC(opaque);
>> +    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
>>       uint64_t val;
>>   
>>       switch (addr) {
>> @@ -373,12 +376,12 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
>>           break;
>>   
>>       case 0x14020:
>> -        DPRINTF("SCSI 4020  STATUS READ %X\n", s->scsi_csr_1);
>> -        val = s->scsi_csr_1;
>> +        DPRINTF("SCSI 4020  STATUS READ %X\n", ns->scsi_csr_1);
>> +        val = ns->scsi_csr_1;
>>           break;
>>   
>>       case 0x14021:
>> -        DPRINTF("SCSI 4021 STATUS READ %X\n", s->scsi_csr_2);
>> +        DPRINTF("SCSI 4021 STATUS READ %X\n", ns->scsi_csr_2);
>>           val = 0x40;
>>           break;
>>   
>> @@ -411,6 +414,7 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
>>                                unsigned size)
>>   {
>>       NeXTPC *s = NEXT_PC(opaque);
>> +    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
>>   
>>       switch (addr) {
>>       case 0x14108:
>> @@ -445,7 +449,7 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
>>               DPRINTF("SCSICSR Reset\n");
>>               /* I think this should set DMADIR. CPUDMA and INTMASK to 0 */
>>               qemu_irq_raise(s->scsi_reset);
>> -            s->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
>> +            ns->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
>>               qemu_irq_lower(s->scsi_reset);
>>           }
>>           if (val & SCSICSR_DMADIR) {
>> @@ -838,6 +842,54 @@ static void nextscsi_write(void *opaque, uint8_t *buf, int size)
>>       nextdma_write(opaque, buf, size, NEXTDMA_SCSI);
>>   }
>>   
>> +static void next_scsi_csr_write(void *opaque, hwaddr addr, uint64_t val,
>> +                                unsigned size)
>> +{
>> +    NeXTSCSI *s = NEXT_SCSI(opaque);
>> +
>> +    switch (addr) {
>> +    case 0:
>> +        s->scsi_csr_1 = val;
>> +        break;
>> +
>> +    case 1:
>> +        s->scsi_csr_2 = val;
>> +        break;
> 
> The old code never set the scsi_csr_x directly like this, so I'm not sure
> whether this is right?

Well I initially did this on a hunch that something had gone wrong with an earlier 
refactoring, but I just did a quick check with Previous and it also treats them as 
normal registers (see 
https://sourceforge.net/p/previous/code/HEAD/tree/trunk/src/esp.c#l160). So I think 
this should be fine for now?

> Also, maybe best squash this patch together with the next patch, otherwise
> this is temporary change in behaviour, isn't it?

If possible could I keep it as-is? It just means there is separation between the 
change of the memory region topology and then consolidating the SCSI CSR access 
routines in the following patch.

>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +static uint64_t next_scsi_csr_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    NeXTSCSI *s = NEXT_SCSI(opaque);
>> +    uint64_t val;
>> +
>> +    switch (addr) {
>> +    case 0:
>> +        val = s->scsi_csr_1;
>> +        break;
>> +
>> +    case 1:
>> +        val = s->scsi_csr_2;
>> +        break;
>> +
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static const MemoryRegionOps next_scsi_csr_ops = {
>> +    .read = next_scsi_csr_read,
>> +    .write = next_scsi_csr_write,
>> +    .valid.min_access_size = 1,
>> +    .valid.max_access_size = 1,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>> +
>>   static void next_scsi_init(Object *obj)
>>   {
>>       NeXTSCSI *s = NEXT_SCSI(obj);
>> @@ -845,6 +897,9 @@ static void next_scsi_init(Object *obj)
>>   
>>       object_initialize_child(obj, "esp", &s->sysbus_esp, TYPE_SYSBUS_ESP);
>>   
>> +    memory_region_init_io(&s->scsi_csr_mem, obj, &next_scsi_csr_ops,
>> +                          s, "csrs", 2);
>> +
>>       memory_region_init(&s->scsi_mem, obj, "next.scsi", 0x40);
>>       sysbus_init_mmio(sbd, &s->scsi_mem);
>>   }
>> @@ -874,15 +929,30 @@ static void next_scsi_realize(DeviceState *dev, Error **errp)
>>       memory_region_add_subregion(&s->scsi_mem, 0x0,
>>                                   sysbus_mmio_get_region(sbd, 0));
>>   
>> +    /* SCSI CSRs */
>> +    memory_region_add_subregion(&s->scsi_mem, 0x20, &s->scsi_csr_mem);
>> +
>>       scsi_bus_legacy_handle_cmdline(&s->sysbus_esp.esp.bus);
>>   }
>>   
>> +static const VMStateDescription next_scsi_vmstate = {
>> +    .name = "next-scsi",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT8(scsi_csr_1, NeXTSCSI),
>> +        VMSTATE_UINT8(scsi_csr_2, NeXTSCSI),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>   static void next_scsi_class_init(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>   
>>       dc->desc = "NeXT SCSI Controller";
>>       dc->realize = next_scsi_realize;
>> +    dc->vmsd = &next_scsi_vmstate;
>>   }
>>   
>>   static const TypeInfo next_scsi_info = {
>> @@ -1000,8 +1070,8 @@ static const VMStateDescription next_rtc_vmstate = {
>>   
>>   static const VMStateDescription next_pc_vmstate = {
>>       .name = "next-pc",
>> -    .version_id = 2,
>> -    .minimum_version_id = 2,
>> +    .version_id = 3,
>> +    .minimum_version_id = 3,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINT32(scr1, NeXTPC),
>>           VMSTATE_UINT32(scr2, NeXTPC),
>> @@ -1009,8 +1079,6 @@ static const VMStateDescription next_pc_vmstate = {
>>           VMSTATE_UINT32(int_mask, NeXTPC),
>>           VMSTATE_UINT32(int_status, NeXTPC),
>>           VMSTATE_UINT32(led, NeXTPC),
>> -        VMSTATE_UINT8(scsi_csr_1, NeXTPC),
>> -        VMSTATE_UINT8(scsi_csr_2, NeXTPC),
>>           VMSTATE_STRUCT(rtc, NeXTPC, 0, next_rtc_vmstate, NextRtc),
>>           VMSTATE_END_OF_LIST()
>>       },


ATB,

Mark.


