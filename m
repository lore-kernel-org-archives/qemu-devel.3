Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7569EF06E4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 20:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpBG9-0005ep-61; Sun, 08 Feb 2026 15:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpBG7-0005eg-S4
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 15:19:56 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpBG6-00064L-4P
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 15:19:55 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 14CDD5969FD;
 Sun, 08 Feb 2026 21:19:52 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id xyks6nFBbvR0; Sun,  8 Feb 2026 21:19:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1A0905969F3; Sun, 08 Feb 2026 21:19:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 18B595969F2;
 Sun, 08 Feb 2026 21:19:50 +0100 (CET)
Date: Sun, 8 Feb 2026 21:19:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v8 11/18] ati-vga: Introduce ATI2DCtx struct for 2D blit
 context
In-Reply-To: <20260204164606.3425246-12-chad@jablonski.xyz>
Message-ID: <1eb38709-9c72-396c-063e-543cd837d541@eik.bme.hu>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
 <20260204164606.3425246-12-chad@jablonski.xyz>
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

On Wed, 4 Feb 2026, Chad Jablonski wrote:
> Previously all state derived from registers was moved to locals. Now we
> can mechanically replace those locals with fields on the new ATI2DCtx
> struct.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/display/ati_2d.c | 222 +++++++++++++++++++++++++-------------------
> 1 file changed, 126 insertions(+), 96 deletions(-)

