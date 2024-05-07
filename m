Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D91C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4NHI-0006jk-5j; Tue, 07 May 2024 12:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4NH5-0006UQ-T9; Tue, 07 May 2024 12:02:43 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4NH3-0001hG-KT; Tue, 07 May 2024 12:02:39 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4BA6B4E603D;
 Tue, 07 May 2024 18:02:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id WX68ZXBPpovU; Tue,  7 May 2024 18:02:30 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 50D2E4E602F; Tue, 07 May 2024 18:02:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4EF53746E3B;
 Tue, 07 May 2024 18:02:30 +0200 (CEST)
Date: Tue, 7 May 2024 18:02:30 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 27/28] target/ppc: Remove id_tlbs flag from CPU env
In-Reply-To: <D13EWAGCZ9F6.1LCJ4K7W21C3L@gmail.com>
Message-ID: <11d79524-f9d1-6200-0889-515c9d0dbf9c@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <5a24db3d48babe4e855707a01954b1827712772f.1714606359.git.balaton@eik.bme.hu>
 <D13EWAGCZ9F6.1LCJ4K7W21C3L@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 7 May 2024, Nicholas Piggin wrote:
> On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
>> This flag for split instruction/data TLBs is only set for 6xx soft TLB
>> MMU model and not used otherwise so no need to have a separate flag
>> for that.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/ppc/pegasos2.c        |  2 +-
>>  target/ppc/cpu.h         |  1 -
>>  target/ppc/cpu_init.c    | 19 +++++--------------
>>  target/ppc/helper_regs.c |  1 -
>>  target/ppc/mmu_common.c  | 10 ++--------
>>  target/ppc/mmu_helper.c  | 12 ++----------
>>  6 files changed, 10 insertions(+), 35 deletions(-)
>>
>> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
>> index 04d6decb2b..dfc6fab180 100644
>> --- a/hw/ppc/pegasos2.c
>> +++ b/hw/ppc/pegasos2.c
>> @@ -984,7 +984,7 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
>>                            cpu->env.icache_line_size);
>>      qemu_fdt_setprop_cell(fdt, cp, "i-cache-line-size",
>>                            cpu->env.icache_line_size);
>> -    if (cpu->env.id_tlbs) {
>> +    if (cpu->env.tlb_type == TLB_6XX) {
>
> Want to just add the standard comment here?
>
>    /* 6xx has separate TLBs for instructions and data */

I think that comment would be redundant here because it's clear from the 
i-tlb, d-tlb this adds so I can do without a comment in this machine if 
you don't mind. (If this was not in my machine I would not mind adding a 
comment but I'd keep this one simple.) I think comments should only be 
added for things that are not clear from code.

Regards,
BALATON Zoltan

> Otherwise looks good
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
>>          qemu_fdt_setprop_cell(fdt, cp, "i-tlb-sets", cpu->env.nb_ways);
>>          qemu_fdt_setprop_cell(fdt, cp, "i-tlb-size", cpu->env.tlb_per_way);
>>          qemu_fdt_setprop_cell(fdt, cp, "d-tlb-sets", cpu->env.nb_ways);

