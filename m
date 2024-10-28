Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4485DD5B154
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 22:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5XsV-0005Mp-Da; Mon, 28 Oct 2024 18:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5XsP-0005LE-H4
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 18:06:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5XsN-0001aX-5R
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 18:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=kjTMBbbWoL5xR3Z8ZC0qqp2QHBPA/EQ2n9rX1UmXlq8=; b=PvuqQRE7TCbdVw32PvoiXbXqWG
 TLEn7Z8QFZ4v5QctqlEtWYItxgraIKGnWGv+xBJsbik3QIrzbEMoQ0O20Uus6Gx9DE8KX9DrEW7HC
 0ZX89bOhF6Done2RS+BLoWkp+7OJsqPngLZn1B+W1OYqqsxSoWMWKERfSto6PaZrswxL7RgI4grQB
 UShs0sx1Iex/TJhsSgn4nPj8d00lX2UszBX0P5LJj5/p6BRjJTorSrweJxVeBqCYvPZTdq8QHdWdA
 uY9WnVytZsJeowCpmgtOtb4yzTr4vosrqlo3+0N05cUWqutb7uYs1t/DkEICwly+54AzdFHPaHaoN
 8tjEiXTyVzMmd1ox6sk5vXxDoy4aDRk5PJfBpqm/GMamNyjUwZRxxYchBLl1M388ktYpH5ls7McEB
 AHDHgmU8KJodIQDFqEVn+Kdv13b4jPSjHHwgousxU2J0wN/2zAkiIpFjW00cCGqlUD3WT7fmpHAH4
 s0KhvocGgIq/olRNsSuTBzrFfya/15iiGONF8ZnXHHO9mUP8Gldaj1ERM0Gh8xtbYGYYLogppio1e
 /Yb96himc/lCcbuVHF+z4kaSARhq26I39gUnsfdmmQ0NObIMzVUxc6O1V7jiafpJC5Y9MQMeleJho
 4EQoArH7rGCa7HZjHWWdqSnLyL9qi3LfGE52o/RJI=;
Received: from [2a00:23c4:8bb8:f600:b5e6:5818:bcfd:7571]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5Xs0-0006KM-2G; Mon, 28 Oct 2024 22:05:56 +0000
Message-ID: <8293abfc-08d5-4b5e-a46e-2052fa4db2b0@ilande.co.uk>
Date: Mon, 28 Oct 2024 22:06:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-4-mark.cave-ayland@ilande.co.uk>
 <20241026095648.15865fbb@tpx1>
 <80f404f7-a8e7-4fcc-8e7d-d82d285113e5@ilande.co.uk>
 <20241027122429.50163254@tpx1>
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
In-Reply-To: <20241027122429.50163254@tpx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:b5e6:5818:bcfd:7571
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 03/36] next-cube: remove overlap between next.dma and
 next.mmio memory regions
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

On 27/10/2024 11:24, Thomas Huth wrote:

> Am Sat, 26 Oct 2024 22:13:25 +0100
> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> 
>> On 26/10/2024 08:56, Thomas Huth wrote:
>>
>>> Am Wed, 23 Oct 2024 09:58:19 +0100
>>> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
>>>    
>>>> Change the start of the next.mmio memory region so that it follows on directly
>>>> after the next.dma memory region, adjusting the address offsets in
>>>> next_mmio_read() and next_mmio_write() accordingly.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> ---
>>>>    hw/m68k/next-cube.c | 28 ++++++++++++++--------------
>>>>    1 file changed, 14 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>>>> index 4e8e55a8bd..e1d94c1ce0 100644
>>>> --- a/hw/m68k/next-cube.c
>>>> +++ b/hw/m68k/next-cube.c
>>>> @@ -266,23 +266,23 @@ static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
>>>>        uint64_t val;
>>>>    
>>>>        switch (addr) {
>>>> -    case 0x7000:
>>>> +    case 0x2000:
>>>>            /* DPRINTF("Read INT status: %x\n", s->int_status); */
>>>>            val = s->int_status;
>>>>            break;
>>>>    
>>>> -    case 0x7800:
>>>> +    case 0x2800:
>>>>            DPRINTF("MMIO Read INT mask: %x\n", s->int_mask);
>>>>            val = s->int_mask;
>>>>            break;
>>>>    
>>>> -    case 0xc000 ... 0xc003:
>>>> -        val = extract32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
>>>> +    case 0x7000 ... 0x7003:
>>>> +        val = extract32(s->scr1, (4 - (addr - 0x7000) - size) << 3,
>>>>                            size << 3);
>>>>            break;
>>>>    
>>>> -    case 0xd000 ... 0xd003:
>>>> -        val = extract32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
>>>> +    case 0x8000 ... 0x8003:
>>>> +        val = extract32(s->scr2, (4 - (addr - 0x8000) - size) << 3,
>>>>                            size << 3);
>>>>            break;
>>>>    
>>>> @@ -301,25 +301,25 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>>>>        NeXTPC *s = NEXT_PC(opaque);
>>>>    
>>>>        switch (addr) {
>>>> -    case 0x7000:
>>>> +    case 0x2000:
>>>>            DPRINTF("INT Status old: %x new: %x\n", s->int_status,
>>>>                    (unsigned int)val);
>>>>            s->int_status = val;
>>>>            break;
>>>>    
>>>> -    case 0x7800:
>>>> +    case 0x2800:
>>>>            DPRINTF("INT Mask old: %x new: %x\n", s->int_mask, (unsigned int)val);
>>>>            s->int_mask  = val;
>>>>            break;
>>>
>>> Could you please add comments at the end of the "case" lines, stating which
>>> mmio addresses are handled in each case? Otherwise, it's harder to grep for
>>> certain addresses later. E.g:
>>>
>>>       case 0x2800:     /* 0x2007800 */
>>
>> If you think it will help? Presumably this is to aid with comparing with other source
>> code/documentation?
> 
> Yes, it will help with 1) debugging code that is running in the guest (so
> you can find IO addresses that it is accessing more easily) and 2) help
> when comparing the code with "Previous":
> 
>   https://sourceforge.net/p/previous/code/HEAD/tree/trunk/src/ioMemTabNEXT.c#l36
> 
>>>> @@ -1000,7 +1000,7 @@ static void next_cube_init(MachineState *machine)
>>>>        sysbus_create_simple(TYPE_NEXTFB, 0x0B000000, NULL);
>>>>    
>>>>        /* MMIO */
>>>> -    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02000000);
>>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02005000);
>>>
>>> Why 0x02005000 and not directly 0x02007000 ?
>>
>> Before this patch the output of "info mtree" shows as follows:
>>
>> (qemu) info mtree
>> address-space: cpu-memory-0
>> address-space: memory
>>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>       0000000000000000-000000000001ffff (prio 0, rom): alias next.rom2 @next.rom
>> 0000000000000000-000000000001ffff
>>       0000000001000000-000000000101ffff (prio 0, rom): next.rom
>>       0000000002000000-0000000002004fff (prio 0, i/o): next.dma
>>       0000000002000000-00000000020cffff (prio 0, i/o): next.mmio
>>       000000000200e000-000000000200efff (prio 0, i/o): next.kbd
>>       00000000020c0000-00000000020c003f (prio 0, ram): next.bmapmem
>>       0000000002100000-000000000211ffff (prio 0, i/o): next.scr
>>       0000000002114000-000000000211400f (prio 0, i/o): esp-regs
>>       0000000002118000-0000000002118003 (prio 0, i/o): escc
>>       0000000004000000-0000000007ffffff (prio 0, ram): next.ram
>>       000000000b000000-000000000b1cb0ff (prio 0, ram): next-video
>>       00000000820c0000-00000000820c003f (prio 0, ram): alias next.bmapmem2
>> @next.bmapmem 0000000000000000-000000000000003f
>>
>> All this patch does is move the start of next.mmio to 0x2005000 to avoid the overlap.
>>
>>> I think there is another range at 0x02006000 related to the ethernet
>>> controller, so directly going with 0x02007000 might cause less friction
>>> later when we add the NIC?
>>
>> By the end of the series, everything except the "global" registers in next.mmio have
>> their own memory region (or empty-slot if the target is unknown) so that "info mtree"
>> output looks like this:
>>
>> (qemu) info mtree
>> address-space: cpu-memory-0
>> address-space: memory
>>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>       0000000000000000-000000000001ffff (prio 0, rom): alias next.rom2 @next.rom
>> 0000000000000000-000000000001ffff
>>       0000000001000000-000000000101ffff (prio 0, rom): next.rom
>>       0000000002000000-0000000002004fff (prio 0, i/o): next.dma
>>       0000000002005000-000000000200dfff (prio 0, i/o): next.mmio
>>       000000000200e000-000000000200efff (prio 0, i/o): next.kbd
>>       00000000020c0000-00000000020c003f (prio 0, ram): next.bmapmem
>>       0000000002106000-000000000210601f (prio 0, i/o): next.en
>>       0000000002110000-000000000211000f (prio -10000, i/o): empty-slot
>>       0000000002112000-000000000211200f (prio -10000, i/o): empty-slot
>>       0000000002114000-000000000211403f (prio 0, i/o): next.scsi
>>         0000000002114000-000000000211400f (prio 0, i/o): esp-regs
>>         0000000002114020-0000000002114021 (prio 0, i/o): csrs
>>       0000000002114108-000000000211410b (prio 0, i/o): next.floppy
>>       0000000002118000-0000000002118003 (prio 0, i/o): escc
>>       0000000002118004-0000000002118013 (prio -10000, i/o): empty-slot
>>       000000000211a000-000000000211a003 (prio 0, i/o): next.timer
>>       0000000004000000-0000000007ffffff (prio 0, ram): next.ram
>>       000000000b000000-000000000b1cb0ff (prio 0, ram): next-video
>>       00000000820c0000-00000000820c003f (prio 0, ram): alias next.bmapmem2
>> @next.bmapmem 0000000000000000-000000000000003f
>>
>> In this case next.en is a dummy memory region which can easily be replaced with a
>> proper device implementation: see the final version of next-cube.c after the series
>> at https://gitlab.com/mcayland/qemu/-/blob/next-cube-improvements/hw/m68k/next-cube.c.
> 
> If I get it right, the IO memory is mirrored at 0x2000000 and 0x2100000,
> so the ethernet region should show up in both, 0x2006000 and 0x2106000 in
> the end? ... those memory regions on the NeXT are very confusing, but at
> least this is what I get from
>   https://sourceforge.net/p/previous/code/HEAD/tree/trunk/src/cpu/memory.c#l1167
> (IO_bank is mapped twice, unless it's the 030 Cube)

That's definitely not something I've seen before, but that certainly looks like the 
case in Previous. I wonder whether this is something that has been measured on real 
hardware?

> So I think we should make sure that we can mirror the ethernet registers at
> 0x2006000, too?

Yes, that's possible. I haven't really given a great deal of thought to how the 
series reflects real hardware, but I can confirm that each commit is structured such 
that it always boots the kernel to the same point as current master.

The address decoding looks odd, but if we were to decide to do this then I'd be 
inclined to create a memory subregion for the next-pc device, move everything from 
0x2000000-0x20fffff into it, and then create an alias from the 0x2100000-0x21fffff 
region back onto it.

Would it be okay to leave such a change to a follow-up series? There is already a 
huge amount of value in this series in terms of detangling the memory regions and 
sorting out the IRQ wiring, and I think the final decision as to how to implement it 
would depend a lot upon what happens once the DMA controller has been reworked.


ATB,

Mark.


