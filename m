Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34AFCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFtyR-0005Os-CL; Mon, 03 Nov 2025 07:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFtyP-0005Oa-CO
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:47:49 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFtyG-0002q3-Ph
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:47:47 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0565C5972E8;
 Mon, 03 Nov 2025 13:47:33 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id n7U9OgnRvN-g; Mon,  3 Nov 2025 13:47:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B287C5972E3; Mon, 03 Nov 2025 13:47:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B14EB5972E2;
 Mon, 03 Nov 2025 13:47:30 +0100 (CET)
Date: Mon, 3 Nov 2025 13:47:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] ati-vga: Implement HOST_DATA transfers to enable X.org
 text rendering
In-Reply-To: <DDYQHOPQ02RD.2DZ3N1Y4X4HEB@jablonski.xyz>
Message-ID: <a78eb569-3054-3dae-4ed6-252ea651b44d@eik.bme.hu>
References: <20251029140112.275456-1-chad@jablonski.xyz>
 <e3e36622-94fc-b892-6283-280b3ec5292d@eik.bme.hu>
 <fabdf0f2-4dbf-488e-9bf9-1249c3154678@eik.bme.hu>
 <DDYQHOPQ02RD.2DZ3N1Y4X4HEB@jablonski.xyz>
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

On Sun, 2 Nov 2025, Chad Jablonski wrote:
> Thanks for the feedback! And wise treating this as an RFC.
> I found a lot to improve in the process of splitting things up.
>
> I've taken all of your suggestions and sending a v2 here shortly:
>
> - Split into multiple patches
> - Integrated the host data blit into ati_2d_blt
> - Now works with the fallback (non-pixman) implementation
> - Implemented scissor clipping
> - Various other fixes/improvements
>
> I did test this with x86_64 Solaris 10. There appear to be a lot of issues
> there but text in xterm does draw correctly now where it didn't before this
> patch series. I haven't gotten around to setting up MorphOS yet. It's
> completely new to me but I'm excited to give it a try here soon.

For testing MorphOS see https://qmiga.codeberg.page/#morphos (there's a 
link at the top of the page to the MorphOS page where a demo iso is 
available from). (I think I've already sent 
https://codeberg.org/qmiga/pages/wiki/SubprojectAti but if not you may 
also want to have a look there.) I also had a bug ticket about CCE but I 
did not move that when moving to codeberg but I still have it saved so 
I'll try to extract info from it and post it but it does not have any 
break trhough just a summary on what may be needed for CCE. It might still 
give some hints if you consider fixing that so I'll dig that up.

Regards,
BALATON Zoltan

