Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448F4EF06E4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 20:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpBO6-00083v-UF; Sun, 08 Feb 2026 15:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpBO1-00083e-93
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 15:28:05 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpBNz-00088X-4N
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 15:28:04 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C7BEB5969F6;
 Sun, 08 Feb 2026 21:28:00 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id MvRn1x90LQoR; Sun,  8 Feb 2026 21:27:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BA11A5969F1; Sun, 08 Feb 2026 21:27:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B88A95969F3;
 Sun, 08 Feb 2026 21:27:58 +0100 (CET)
Date: Sun, 8 Feb 2026 21:27:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v8 12/18] ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
In-Reply-To: <20260204164606.3425246-13-chad@jablonski.xyz>
Message-ID: <5606442b-4789-3022-1f7e-f76d3b0e7371@eik.bme.hu>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
 <20260204164606.3425246-13-chad@jablonski.xyz>
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
> setup_2d_blt_ctx is responsible for knowing how to retrieve the state
> needed by ati_2d_blt from the registers and assigning it to the ATI2DCtx.
> This will be useful in a future patch when HOST_DATA needs to make small
> modifications to the ctx.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/display/ati_2d.c | 75 ++++++++++++++++++++++++---------------------
> 1 file changed, 40 insertions(+), 35 deletions(-)

