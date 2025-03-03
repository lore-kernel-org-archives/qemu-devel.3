Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267B4C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3Tn-0002rF-0B; Mon, 03 Mar 2025 05:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tp3Te-0002qN-Ue; Mon, 03 Mar 2025 05:56:54 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tp3Tc-0002e5-58; Mon, 03 Mar 2025 05:56:50 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DA7AA4E6014;
 Mon, 03 Mar 2025 11:56:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id tCAa0piixh2o; Mon,  3 Mar 2025 11:56:42 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A8B214E6010; Mon, 03 Mar 2025 11:56:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A70FC74577C;
 Mon, 03 Mar 2025 11:56:42 +0100 (CET)
Date: Mon, 3 Mar 2025 11:56:42 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Hab Gallagher <hab.gallagher@gmail.com>
cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: Re: Adding gamma support to QemuMacDrivers
In-Reply-To: <CANDMsCp3wH3xhEvHz_DvnPbv7NLCdGb2LDaECOG=yJqfKObLkA@mail.gmail.com>
Message-ID: <0f927835-62e6-a2a8-7de0-262657edb638@eik.bme.hu>
References: <CANDMsCp3wH3xhEvHz_DvnPbv7NLCdGb2LDaECOG=yJqfKObLkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello,

On Sun, 2 Mar 2025, Hab Gallagher wrote:
> I have interest in contributing patches to extend qemu's powerpc graphics
> card emulation to include more comprehensive support for gamma. Some
> classic mac applications will balk at launch if the graphics card doesn't
> claim enough support for gamma tricks. Native parity should be possible,
> allowing applications to ramp the apparent screen brightness using gamma
> tricks.
>
> As far as I can tell, both https://github.com/ozbenh/QemuMacDrivers and
> qemu itself need to be updated for this endeavor. It is unclear to me how
> much of the code "should" live in one repository or the other. I assume
> that it would be preferable to put as little code as possible into the
> driver that runs emulated, and move the bulk of the work to the driver
> side, in the qemu host.

That driver is for a VGA device which I think does not support gamma in 
hardware. QEMU emulates the hardware so if it does not support gamma then 
there's no place to add it in QEMU. Therefore if you want to emulate gamma 
on VGA this should be done within the guest driver but that may be slower. 
How does this work on real hardware? What graphics device is used there 
and does that support gamma in hardware? Maybe that graphics device needs 
to be emulated instead?

> I could not find any existing work on this, nor anyone asking about the
> feature. I don't have experience hacking on qemu, but I have extensively
> patched SheepShaver before. I hope to contribute more to qemu-ppc instead.

I have an article on AmigaOS gfx here:
https://codeberg.org/qmiga/pages/wiki/AmigaOSGfx
that discusses similar issue and most of it may be applicable to MacOS 
too. There's also a DeveloperTips link with some QEMU getting started 
links that may help you. I have started an ati-vga emulation that could do 
all this and more but it's quite complex and I could take some help with 
it. Maybe that could be interesting to you as well as these ATI chips were 
used on real Macs so MacOS has support for it. I also have an article 
linked from the above about that.

Regards,
BALATON Zoltan

