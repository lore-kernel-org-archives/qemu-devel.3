Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F73D5B845
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 22:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Y9a-0000eD-1k; Mon, 28 Oct 2024 18:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5Y9Y-0000dy-Dz
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 18:24:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5Y9W-0003PE-4C
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 18:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=D3XEZ/zrR9hAA7o+N0+QdCKWn/p0B8ZG/pvdbjoH8Ek=; b=kE5t393289VRcochhwHwbEQRFD
 0bUQhuHvgOMtPidyfnUG4xpMKMgRs8wz57k9wWcSOd9GVqWeuWx5WkI53t30Z9X6fnYujwWd5kInr
 0zK0jMEYQwL49vhAT+u+gmCfRswGUQb9zLyKnCJsN52DYDRbpLFH8JHtJWjCJOlcLzVq0r5PA/aCO
 J5/RFw1GG8Alk/teCdIQnzHs65WfNBVNnX8d8xlA7yT1KsqnETkp0KqRDy/tBhMFaQSip+gly+/Ud
 JSlciYndw+72t/kUGlA9r1g0i2+fHPirTF9GYCqKi96ZFMRQY8lLJcve0U9tLjRmfyxSZAZZBJbNK
 K8rXFq7S7/sWggh+lZm9Xdh7iTGzwk5/drxwrSnDOmCoOlig2h6VPmRnDeCfJ3u8fRMogc9TqKUmM
 ZXL+gqjLYBcRUK3OdGmdwKqKDtiomMMfQBgZ+UK6hdZBAGLDPV3XpcZ4LF4Fhlyhl04PNrBd0XgjL
 bWpJ3WjoxN3ThOiGZqGTSI4RQVMqd0K8ZXpASImZgrInA8nKwfq0T+okC5GaYGJLMYCbnKXTumNAh
 U9DYxSdD+0DwFm9CVBRITN2HHcE8XtFtbW3pl2ubu2+AHoxkILSHvAPvD2TMcyPDNZLQD0NNjrS53
 C5OtdvXLbW92yFDDPT8N3R0DqnECAXQA5YNbdyeos=;
Received: from [2a00:23c4:8bb8:f600:b5e6:5818:bcfd:7571]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5Y9A-0006Wg-1x; Mon, 28 Oct 2024 22:23:40 +0000
Message-ID: <3ba91ec4-b0a9-4985-98f9-70c59b87c49a@ilande.co.uk>
Date: Mon, 28 Oct 2024 22:23:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-11-mark.cave-ayland@ilande.co.uk>
 <20241028172237.21e83c92@tpx1>
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
In-Reply-To: <20241028172237.21e83c92@tpx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:b5e6:5818:bcfd:7571
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 10/36] next-cube: move SCSI 4020 logic from next-pc device
 to next-scsi device
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

On 28/10/2024 16:22, Thomas Huth wrote:

> Am Wed, 23 Oct 2024 09:58:26 +0100
> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> 
>> The SCSI 4020 logic refers to the offset of the SCSI CSRs within the NeXTCube
>> address space. Due to the previously overlapping memory regions, there were
>> duplicate MMIO accessors in the next.scr memory region for these registers but
>> now this has been resolved. This allows us to move the more complex prototype
>> logic into the next-scsi MMIO accessors.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/next-cube.c | 139 ++++++++++++++++++++------------------------
>>   1 file changed, 62 insertions(+), 77 deletions(-)
>>
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> index 32466a425f..22da777006 100644
>> --- a/hw/m68k/next-cube.c
>> +++ b/hw/m68k/next-cube.c
>> @@ -365,8 +365,6 @@ static const MemoryRegionOps next_mmio_ops = {
>>   
>>   static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
>>   {
>> -    NeXTPC *s = NEXT_PC(opaque);
>> -    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
>>       uint64_t val;
>>   
>>       switch (addr) {
>> @@ -375,16 +373,6 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
>>           val = 0x40 | 0x04 | 0x2 | 0x1;
>>           break;
>>   
>> -    case 0x14020:
>> -        DPRINTF("SCSI 4020  STATUS READ %X\n", ns->scsi_csr_1);
>> -        val = ns->scsi_csr_1;
>> -        break;
>> -
>> -    case 0x14021:
>> -        DPRINTF("SCSI 4021 STATUS READ %X\n", ns->scsi_csr_2);
>> -        val = 0x40;
> 
> Where is that hard-coded 0x40 gone now? Please mention this in the commit
> description, otherwise this looks like a mistake?

Heh I guess the part about the duplicate MMIO accessors was a little bit too cryptic? 
I'll have a think as to how to improve the commit message for v2.


ATB,

Mark.

>> -        break;
>> -
>>       /*
>>        * These 4 registers are the hardware timer, not sure which register
>>        * is the latch instead of data, but no problems so far.
>> @@ -413,9 +401,6 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
>>   static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
>>                                unsigned size)
>>   {
>> -    NeXTPC *s = NEXT_PC(opaque);
>> -    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
>> -
>>       switch (addr) {
>>       case 0x14108:
>>           DPRINTF("FDCSR Write: %"PRIx64 "\n", val);
>> @@ -424,68 +409,6 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
>>           }
>>           break;
>>   
>> -    case 0x14020: /* SCSI Control Register */
>> -        if (val & SCSICSR_FIFOFL) {
>> -            DPRINTF("SCSICSR FIFO Flush\n");
>> -            /* will have to add another irq to the esp if this is needed */
>> -            /* esp_puflush_fifo(esp_g); */
>> -        }
>> -
>> -        if (val & SCSICSR_ENABLE) {
>> -            DPRINTF("SCSICSR Enable\n");
>> -            /*
>> -             * qemu_irq_raise(s->scsi_dma);
>> -             * s->scsi_csr_1 = 0xc0;
>> -             * s->scsi_csr_1 |= 0x1;
>> -             * qemu_irq_pulse(s->scsi_dma);
>> -             */
>> -        }
>> -        /*
>> -         * else
>> -         *     s->scsi_csr_1 &= ~SCSICSR_ENABLE;
>> -         */
>> -
>> -        if (val & SCSICSR_RESET) {
>> -            DPRINTF("SCSICSR Reset\n");
>> -            /* I think this should set DMADIR. CPUDMA and INTMASK to 0 */
>> -            qemu_irq_raise(s->scsi_reset);
>> -            ns->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
>> -            qemu_irq_lower(s->scsi_reset);
>> -        }
>> -        if (val & SCSICSR_DMADIR) {
>> -            DPRINTF("SCSICSR DMAdir\n");
>> -        }
>> -        if (val & SCSICSR_CPUDMA) {
>> -            DPRINTF("SCSICSR CPUDMA\n");
>> -            /* qemu_irq_raise(s->scsi_dma); */
>> -            s->int_status |= 0x4000000;
>> -        } else {
>> -            /* fprintf(stderr,"SCSICSR CPUDMA disabled\n"); */
>> -            s->int_status &= ~(0x4000000);
>> -            /* qemu_irq_lower(s->scsi_dma); */
>> -        }
>> -        if (val & SCSICSR_INTMASK) {
>> -            DPRINTF("SCSICSR INTMASK\n");
>> -            /*
>> -             * int_mask &= ~0x1000;
>> -             * s->scsi_csr_1 |= val;
>> -             * s->scsi_csr_1 &= ~SCSICSR_INTMASK;
>> -             * if (s->scsi_queued) {
>> -             *     s->scsi_queued = 0;
>> -             *     next_irq(s, NEXT_SCSI_I, level);
>> -             * }
>> -             */
>> -        } else {
>> -            /* int_mask |= 0x1000; */
>> -        }
>> -        if (val & 0x80) {
>> -            /* int_mask |= 0x1000; */
>> -            /* s->scsi_csr_1 |= 0x80; */
>> -        }
>> -        DPRINTF("SCSICSR Write: %"PRIx64 "\n", val);
>> -        /* s->scsi_csr_1 = val; */
>> -        break;
>> -
>>       /* Hardware timer latch - not implemented yet */
>>       case 0x1a000:
>>       default:
>> @@ -846,13 +769,73 @@ static void next_scsi_csr_write(void *opaque, hwaddr addr, uint64_t val,
>>                                   unsigned size)
>>   {
>>       NeXTSCSI *s = NEXT_SCSI(opaque);
>> +    NeXTPC *pc = NEXT_PC(container_of(s, NeXTPC, next_scsi));
>>   
>>       switch (addr) {
>>       case 0:
>> +        if (val & SCSICSR_FIFOFL) {
>> +            DPRINTF("SCSICSR FIFO Flush\n");
>> +            /* will have to add another irq to the esp if this is needed */
>> +            /* esp_puflush_fifo(esp_g); */
>> +        }
>> +
>> +        if (val & SCSICSR_ENABLE) {
>> +            DPRINTF("SCSICSR Enable\n");
>> +            /*
>> +             * qemu_irq_raise(s->scsi_dma);
>> +             * s->scsi_csr_1 = 0xc0;
>> +             * s->scsi_csr_1 |= 0x1;
>> +             * qemu_irq_pulse(s->scsi_dma);
>> +             */
>> +        }
>> +        /*
>> +         * else
>> +         *     s->scsi_csr_1 &= ~SCSICSR_ENABLE;
>> +         */
>> +
>> +        if (val & SCSICSR_RESET) {
>> +            DPRINTF("SCSICSR Reset\n");
>> +            /* I think this should set DMADIR. CPUDMA and INTMASK to 0 */
>> +            qemu_irq_raise(pc->scsi_reset);
>> +            s->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
>> +            qemu_irq_lower(pc->scsi_reset);
>> +        }
>> +        if (val & SCSICSR_DMADIR) {
>> +            DPRINTF("SCSICSR DMAdir\n");
>> +        }
>> +        if (val & SCSICSR_CPUDMA) {
>> +            DPRINTF("SCSICSR CPUDMA\n");
>> +            /* qemu_irq_raise(s->scsi_dma); */
>> +            pc->int_status |= 0x4000000;
>> +        } else {
>> +            /* fprintf(stderr,"SCSICSR CPUDMA disabled\n"); */
>> +            pc->int_status &= ~(0x4000000);
>> +            /* qemu_irq_lower(s->scsi_dma); */
>> +        }
>> +        if (val & SCSICSR_INTMASK) {
>> +            DPRINTF("SCSICSR INTMASK\n");
>> +            /*
>> +             * int_mask &= ~0x1000;
>> +             * s->scsi_csr_1 |= val;
>> +             * s->scsi_csr_1 &= ~SCSICSR_INTMASK;
>> +             * if (s->scsi_queued) {
>> +             *     s->scsi_queued = 0;
>> +             *     next_irq(s, NEXT_SCSI_I, level);
>> +             * }
>> +             */
>> +        } else {
>> +            /* int_mask |= 0x1000; */
>> +        }
>> +        if (val & 0x80) {
>> +            /* int_mask |= 0x1000; */
>> +            /* s->scsi_csr_1 |= 0x80; */
>> +        }
>> +        DPRINTF("SCSICSR1 Write: %"PRIx64 "\n", val);
>>           s->scsi_csr_1 = val;
>>           break;
>>   
>>       case 1:
>> +        DPRINTF("SCSICSR2 Write: %"PRIx64 "\n", val);
>>           s->scsi_csr_2 = val;
>>           break;
>>   
>> @@ -868,10 +851,12 @@ static uint64_t next_scsi_csr_read(void *opaque, hwaddr addr, unsigned size)
>>   
>>       switch (addr) {
>>       case 0:
>> +        DPRINTF("SCSI 4020  STATUS READ %X\n", s->scsi_csr_1);
>>           val = s->scsi_csr_1;
>>           break;
>>   
>>       case 1:
>> +        DPRINTF("SCSI 4021 STATUS READ %X\n", s->scsi_csr_2);
>>           val = s->scsi_csr_2;
>>           break;
>>   


