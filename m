Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B718C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GYe-000097-QG; Sat, 18 May 2024 05:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s8GYb-00005o-89; Sat, 18 May 2024 05:40:49 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s8GYZ-0007Oz-OR; Sat, 18 May 2024 05:40:48 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4CC6E4E601D;
 Sat, 18 May 2024 11:40:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id QLP_sqgWoPM2; Sat, 18 May 2024 11:40:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 142E54E600F; Sat, 18 May 2024 11:40:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 129E9746E3B;
 Sat, 18 May 2024 11:40:41 +0200 (CEST)
Date: Sat, 18 May 2024 11:40:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v7 00/61] Misc PPC exception and BookE MMU clean ups
In-Reply-To: <D1CNM67REA8V.3KZRSYB198ERM@gmail.com>
Message-ID: <d00a78de-9ed1-3f5a-caa4-b55d37c98c90@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
 <D1CNM67REA8V.3KZRSYB198ERM@gmail.com>
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

On Sat, 18 May 2024, Nicholas Piggin wrote:
> On Mon May 13, 2024 at 9:27 AM AEST, BALATON Zoltan wrote:
>> This series does some further clean up mostly around BookE MMU to
>> untangle it from other MMU models. It also contains some other changes
>> that I've come up with while working on this. The Simplify
>> ppc_booke_xlate() part 1 and part 2 patches could be squashed together
>> but left them separate for easier review. This could still be continued
>> which I might do in the future but this is long enough now to be merged.
>
> FYI I put patch 35 (only taking half of 35) and minus patch 28
> here, will merge after some more testing. (Don't rebase your
> series on this because it's just a throwaway branch).
>
> https://gitlab.com/npiggin/qemu/-/commits/ppc-next-test

OK thanks, I'll wait for the pull and then rebase on that then.

Regards,
BALATON Zoltan

