Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503F6C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 20:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQBt2-00017h-QA; Sat, 06 Jul 2024 16:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sQBt1-00017A-48; Sat, 06 Jul 2024 16:19:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sQBsz-0000P3-EU; Sat, 06 Jul 2024 16:19:58 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 111324E6005;
 Sat, 06 Jul 2024 22:19:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id cr614txIJD20; Sat,  6 Jul 2024 22:19:53 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D121E4E6013; Sat, 06 Jul 2024 22:19:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CF7387470B7;
 Sat, 06 Jul 2024 22:19:53 +0200 (CEST)
Date: Sat, 6 Jul 2024 22:19:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 41/43] target/ppc: Change MMU xlate functions to take
 CPUState
In-Reply-To: <D2GKS3DJEU2F.164AFPRMIA8T5@gmail.com>
Message-ID: <4c3408f2-98d3-8208-2f17-d96e03e897c7@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <3e26fb6adddef0804adfbfb2fdc0fe664555ef0a.1716763435.git.balaton@eik.bme.hu>
 <D2GKS3DJEU2F.164AFPRMIA8T5@gmail.com>
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

On Thu, 4 Jul 2024, Nicholas Piggin wrote:
> On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
>> The callers of xlate functions get CPUState which is then cast to
>> PowerPCCPU that is then cast back to CPUState by most xlate functions.
>> Avoid this back and forth casting by passing the existing CPUState to
>> xlate functions and let them convert it as needed.
>
> I guess. Is this faster?

I've sent some measurements as a reply to the cover letter. It can be 
found in the list archives or in patchew:
https://patchew.org/QEMU/cover.1716763435.git.balaton@eik.bme.hu/

Regards,
BALATON Zoltan

