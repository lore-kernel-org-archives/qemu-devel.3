Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B760D6ACCD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 13:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGHjP-0006iI-KG; Wed, 27 Nov 2024 08:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tGHjN-0006hs-HP; Wed, 27 Nov 2024 08:05:21 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tGHjK-0003w6-NL; Wed, 27 Nov 2024 08:05:20 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D2E664E6036;
 Wed, 27 Nov 2024 14:05:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id VllCZwRt_Q0t; Wed, 27 Nov 2024 14:05:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 024294E6027; Wed, 27 Nov 2024 14:05:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0079D746F60;
 Wed, 27 Nov 2024 14:05:11 +0100 (CET)
Date: Wed, 27 Nov 2024 14:05:11 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Subject: Re: [PULL 0/6] ppc-for-9.2-2 queue
In-Reply-To: <e18a1d0a-7970-4985-80d7-99d0801d22b0@tls.msk.ru>
Message-ID: <2a833939-b7c6-e075-c6e7-30c60e146fac@eik.bme.hu>
References: <20241126171235.362916-1-npiggin@gmail.com>
 <e18a1d0a-7970-4985-80d7-99d0801d22b0@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 27 Nov 2024, Michael Tokarev wrote:
> 26.11.2024 20:12, Nicholas Piggin:
>
>> * Assorted small ppc fixes
>> 
>> ----------------------------------------------------------------
>> BALATON Zoltan (1):
>>        hw/ppc/pegasos2: Fix IRQ routing from pci.0

This depends on a change (exporting IRQState) that was merged during this 
cycle so probably would not apply for earlier versions. The issue fixed is 
also rarely needed (mainly for GPU passthrough) so I think this one is not 
needed for stable. I can't judge the others.

Regards,
BALATON Zoltan

>> 
>> Glenn Miles (1):
>>        target/ppc: Fix THREAD_SIBLING_FOREACH for multi-socket
>> 
>> Harsh Prateek Bora (1):
>>        ppc/spapr: fix drc index mismatch for partially enabled vcpus
>> 
>> Nicholas Piggin (3):
>>        target/ppc: Fix non-maskable interrupt while halted
>>        ppc/pnv: Fix direct controls quiesce
>>        ppc/pnv: Add xscom- prefix to pervasive-control region name
> anything here worth to pick for qemu-stable, or is
> all this "small enough" for this?
>
> Thanks,
>
> /mjt
>
>

