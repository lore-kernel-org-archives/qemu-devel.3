Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7585FE7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXK9J-0003NC-T1; Mon, 13 Jan 2025 08:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tXK9F-0003MT-Nt
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:06:30 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tXK9D-0008OE-He
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:06:29 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4A0444E600E;
 Mon, 13 Jan 2025 14:06:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id UMztxQ3IBRzE; Mon, 13 Jan 2025 14:06:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5AEDC4E6000; Mon, 13 Jan 2025 14:06:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5914F746F60;
 Mon, 13 Jan 2025 14:06:20 +0100 (CET)
Date: Mon, 13 Jan 2025 14:06:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: A few patches for u-boot-sam460ex
In-Reply-To: <9b64bbe0-473d-4f6b-a673-356e74517fb4@tls.msk.ru>
Message-ID: <faf9e3d8-5ccd-2a06-aeda-bacf96b81fe1@eik.bme.hu>
References: <9b64bbe0-473d-4f6b-a673-356e74517fb4@tls.msk.ru>
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

Hello,

On Tue, 7 Jan 2025, Michael Tokarev wrote:
> Hi!
>
> For some time, qemu package in debian carries several patches for 
> roms/u-boot-sam460ex,
> fixing a number of issues.  It'd be nice to have them in the official 
> repository.

I didn't applied these yet because I still intend to update to the latest 
firmware for this machine (that's still based on an old U-Boot but newer 
than the currently used) but I haven't got to it yet. I'll try to do that 
update in this cycle or take these patches instead for the meantime.

Regards,
BALATON Zoltan

> Thanks,
>
> /mjt

