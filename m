Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4BBCCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFtrX-0002VW-IX; Mon, 03 Nov 2025 07:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFtrT-0002Uw-LT; Mon, 03 Nov 2025 07:40:39 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFtrN-000154-EH; Mon, 03 Nov 2025 07:40:39 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AA907597300;
 Mon, 03 Nov 2025 13:40:22 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id UOAvNGYmrDfn; Mon,  3 Nov 2025 13:40:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AD9B459730B; Mon, 03 Nov 2025 13:40:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AC3FC597307;
 Mon, 03 Nov 2025 13:40:19 +0100 (CET)
Date: Mon, 3 Nov 2025 13:40:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com, 
 qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [PATCH] ati-vga: Separate default control bit for source
In-Reply-To: <DDYPYWJR1NYS.IV5FU7V1GR5B@jablonski.xyz>
Message-ID: <9830b63d-4a83-0c58-3ce4-c2a19fd47efa@eik.bme.hu>
References: <20251007195435.8ACAC56F2A3@zero.eik.bme.hu>
 <DDYPYWJR1NYS.IV5FU7V1GR5B@jablonski.xyz>
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
> Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
> Tested-by: Chad Jablonski <chad@jablonski.xyz>
>
> Hey Balaton!
>
> This fix looks correct to me. Source and destination should use
> their respective bits. I applied my latest HOST_DATA changes on
> top of this and saw no problems when rendering text in xterm
> with rage 128.
>
> There is one thing I _did_ notice. I implemented similar behavior with the
> GMC_SRC_CLIPPING and GMC_DST_CLIPPING fields (default and leave alone).
> But I implemented them as a copy of the default values during the write
> when the bits are set to default. Both approaches seem to work. If you want
> to keep them consistent I can test the actual hardware to see which approach
> it uses or I can just update my patch to match this style.

Matching hardware is more important than matching style, after all this is 
supposed to emulate hardware and we already found places where the docs 
were wrong. So if you can test and match what hardware does that would be 
best.

Regards,
BALATON Zoltan

