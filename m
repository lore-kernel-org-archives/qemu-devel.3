Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23CEC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7tW1-0006ja-2A; Fri, 17 May 2024 05:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s7tVz-0006j3-72; Fri, 17 May 2024 05:04:35 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s7tVv-0004Wq-Lf; Fri, 17 May 2024 05:04:34 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 721FC4E603E;
 Fri, 17 May 2024 11:04:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id L8GiDKpfGx4a; Fri, 17 May 2024 11:04:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7DA334E6036; Fri, 17 May 2024 11:04:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7BE7D746E3B;
 Fri, 17 May 2024 11:04:22 +0200 (CEST)
Date: Fri, 17 May 2024 11:04:22 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v7 36/61] target/ppc/mmu_common.c: Remove local name for
 a constant
In-Reply-To: <D1BPBI452YKP.HT0RH2UYZGHW@gmail.com>
Message-ID: <0eee5751-f001-e090-7c76-eba4572de55c@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
 <b9605839090fd145b067db34b2bdce45548c0631.1715555763.git.balaton@eik.bme.hu>
 <D1BPBI452YKP.HT0RH2UYZGHW@gmail.com>
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

On Fri, 17 May 2024, Nicholas Piggin wrote:
> On Mon May 13, 2024 at 9:28 AM AEST, BALATON Zoltan wrote:
>> The mmask local variable is a less descriptive local name for a
>> constant. Drop it and use the constant directly in the two places it
>> is needed.
>
> Wow, lots more. I might take up to patch 34ish for first PR.

Yes I think that might be a good idea, just what I said in previous reply, 
as I have some more already even compared to this version. There's a lot 
to clean up in this series and I did not even attempt to fix the 6xx cases 
that I won't do because I don't know it so just tried to separate these 
and do some trivial clean up/improvement.

Regards,
BALATON Zoltan

> Thanks,
> Nick
>
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  target/ppc/mmu_common.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
>> index 9e0bfbda67..5d0090014a 100644
>> --- a/target/ppc/mmu_common.c
>> +++ b/target/ppc/mmu_common.c
>> @@ -98,7 +98,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
>>                                  target_ulong pte1, int h,
>>                                  MMUAccessType access_type)
>>  {
>> -    target_ulong ptem, mmask;
>> +    target_ulong ptem;
>>      int ret, pteh, ptev, pp;
>>
>>      ret = -1;
>> @@ -108,12 +108,11 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
>>      if (ptev && h == pteh) {
>>          /* Check vsid & api */
>>          ptem = pte0 & PTE_PTEM_MASK;
>> -        mmask = PTE_CHECK_MASK;
>>          pp = pte1 & 0x00000003;
>>          if (ptem == ctx->ptem) {
>>              if (ctx->raddr != (hwaddr)-1ULL) {
>>                  /* all matches should have equal RPN, WIMG & PP */
>> -                if ((ctx->raddr & mmask) != (pte1 & mmask)) {
>> +                if ((ctx->raddr & PTE_CHECK_MASK) != (pte1 & PTE_CHECK_MASK)) {
>>                      qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
>>                      return -3;
>>                  }
>
>
>

