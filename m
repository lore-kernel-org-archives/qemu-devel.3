Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9ADC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Jyu-0006Ig-8n; Tue, 07 May 2024 08:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4Jyp-00064u-1I; Tue, 07 May 2024 08:31:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4Jyj-0007BZ-87; Tue, 07 May 2024 08:31:32 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 45A374E65BB;
 Tue, 07 May 2024 14:31:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id w29gSN58u85Q; Tue,  7 May 2024 14:31:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5911D4E65C6; Tue, 07 May 2024 14:31:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 579A9746E3B;
 Tue, 07 May 2024 14:31:20 +0200 (CEST)
Date: Tue, 7 May 2024 14:31:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 26/28] target/ppc/mmu_common.c: Move BookE MMU functions
 together
In-Reply-To: <D13EMTIRPDQJ.2LCAHIOTN0W5N@gmail.com>
Message-ID: <090308e7-e3c0-8129-bdae-c2e3a41a2aa5@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <d5d70791bdf598cd28ee70fd058f51c257a2b969.1714606359.git.balaton@eik.bme.hu>
 <D13EMTIRPDQJ.2LCAHIOTN0W5N@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
> What do you think about adding mmu-book3e.c instead?

I have considered that but found that some functions have to be in the 
same file and declared static for the compiler to inline them otherwise I 
get worse performance. Maybe after these rearrangments it's now possible 
to move these out but as this series got a bit long already I dod not go 
through with that and left it for a follow up but I can give it a try.

Thanks for the review so far, I'll try to make the changes that I 
understood and submit and updated version. I'm not sure I got some of your 
requests so that may need another round.

Regards,
BALATON Zoltan

