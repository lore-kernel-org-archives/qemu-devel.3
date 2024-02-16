Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54991C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayCQ-0005gh-Cl; Fri, 16 Feb 2024 08:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rayCP-0005gS-3B; Fri, 16 Feb 2024 08:24:17 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rayCL-0004c6-Jm; Fri, 16 Feb 2024 08:24:15 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1BF2E4E602C;
 Fri, 16 Feb 2024 14:24:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id nBcButkd3Us7; Fri, 16 Feb 2024 14:24:09 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 26FAB4E601F; Fri, 16 Feb 2024 14:24:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 255897456B4;
 Fri, 16 Feb 2024 14:24:09 +0100 (CET)
Date: Fri, 16 Feb 2024 14:24:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Subject: Re: [PATCH v5 0/9] Misc clean ups to target/ppc exception handling
In-Reply-To: <821d7bc0-f3c7-6809-cd0f-8280da924250@eik.bme.hu>
Message-ID: <bf3a7ed6-7a28-f640-9505-486f8def8556@eik.bme.hu>
References: <cover.1705614747.git.balaton@eik.bme.hu>
 <821d7bc0-f3c7-6809-cd0f-8280da924250@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 30 Jan 2024, BALATON Zoltan wrote:
> On Thu, 18 Jan 2024, BALATON Zoltan wrote:
>> These are some small clean ups for target/ppc/excp_helper.c trying to
>> make this code a bit simpler. No functional change is intended. This
>> series was submitted before but only partially merged due to freeze
>> and conflicting series os thia was postponed then to avoid conflicts.
>
> Ping?

Ping^2?

Regards,
BALATON Zoltan

>> v5:
>> - rebase on master
>> - keep logging nip pointing to the sc instruction
>> - add another patch
>> 
>> v4: Rebased on master dropping what was merged
>> 
>> BALATON Zoltan (9):
>>  target/ppc: Use env_cpu for cpu_abort in excp_helper
>>  target/ppc: Readability improvements in exception handlers
>>  target/ppc: Fix gen_sc to use correct nip
>>  target/ppc: Move patching nip from exception handler to helper_scv
>>  target/ppc: Simplify syscall exception handlers
>>  target/ppc: Clean up ifdefs in excp_helper.c, part 1
>>  target/ppc: Clean up ifdefs in excp_helper.c, part 2
>>  target/ppc: Clean up ifdefs in excp_helper.c, part 3
>>  target/ppc: Remove interrupt handler wrapper functions
>> 
>> target/ppc/cpu.h         |   1 +
>> target/ppc/excp_helper.c | 490 +++++++++++++--------------------------
>> target/ppc/translate.c   |  16 +-
>> 3 files changed, 170 insertions(+), 337 deletions(-)
>> 
>> 
>
>

