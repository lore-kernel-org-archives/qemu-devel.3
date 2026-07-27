Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EE2C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 23:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woUXB-00076I-Gc; Mon, 27 Jul 2026 19:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathan@kernel.org>) id 1woUX9-00075u-Tc
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 19:14:55 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathan@kernel.org>) id 1woUX8-0006wB-FS
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 19:14:55 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF04643A06;
 Mon, 27 Jul 2026 23:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E581F000E9;
 Mon, 27 Jul 2026 23:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785194084;
 bh=OklVZrciuw4TnN36h8m234FTBs8TSPYwN6TKiruLDbc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SPfGnYKLa5cOrvjOuOZ7liePYOVXlLv3fj+7JZeVDVR8iIY7bhV+gPuPeibDRdKo8
 KsuxP58+n5Lmze7iWFmWJOEph7qi97b2xL0nzovWrxaO6pIM5aKVp0kh/7T6YykDnl
 JTfkLYprVriaLUD6oUwjVjkD0fPwo3nP+9In6CHTHZWo0HPEWtAiCvSvOdGrp2Ga2v
 Z2LcXfFbaJp3K/Axen+gfmcYALjkevSNfIEitUgEWEs18IxV1LfPIMufc5OA21d5lW
 BhF/BRgnjoZl977mXD+2lwKu/oWjIhVpu1cJ4TFwp82Q+SspCvoPpdTTM2K4NC7Bw3
 whwsK3sy+J6IA==
Date: Mon, 27 Jul 2026 16:14:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] qemu-openbios queue 20260707
Message-ID: <20260727231441.GB3783405@ax162>
References: <20260707213237.494636-1-mark.cave-ayland@ilande.co.uk>
 <20260722011530.GA2116566@ax162>
 <f4be0cc9-68ae-4f83-a40b-9af84109c54f@ilande.co.uk>
 <4b6f6450-74ce-497f-b487-71fadf97dc3c@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b6f6450-74ce-497f-b487-71fadf97dc3c@ilande.co.uk>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=nathan@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Jul 26, 2026 at 09:53:13PM +0100, Mark Cave-Ayland wrote:
> I've tried to reproduce this, however I cannot get your vmlinux above to
> work here with either the old or new OpenBIOS. Is there anything else about
> your environment needed to reproduce this?

Are you giving it enough time to boot with the old OpenBIOS? I have
tested it on two different machines running Arch Linux and Fedora (each
running mainline or -next Linux) so it seems unlikely to be environment
related? On both of those machines, it takes two minutes or more to
finish booting and shutdown.

-- 
Cheers,
Nathan

