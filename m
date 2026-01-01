Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8D0EEEC1C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 21:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbQNV-0007m2-0o; Thu, 01 Jan 2026 16:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbQNT-0007lc-3X
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 16:38:39 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbQNP-0000JY-Vv
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 16:38:38 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 81BDB5969FF;
 Thu, 01 Jan 2026 22:38:33 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id DHyJlwMopFJM; Thu,  1 Jan 2026 22:38:31 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3E7265969FA; Thu, 01 Jan 2026 22:38:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3D4015969F6;
 Thu, 01 Jan 2026 22:38:31 +0100 (CET)
Date: Thu, 1 Jan 2026 22:38:31 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 02/11] ati-vga: Add scissor clipping register
 support
In-Reply-To: <20251118154812.57861-3-chad@jablonski.xyz>
Message-ID: <b69b2767-6ae5-9be1-c350-0cd26f96bc48@eik.bme.hu>
References: <20251118154812.57861-1-chad@jablonski.xyz>
 <20251118154812.57861-3-chad@jablonski.xyz>
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

On Tue, 18 Nov 2025, Chad Jablonski wrote:
> Implement read and write operations on SC_TOP_LEFT, SC_BOTTOM_RIGHT,
> and SRC_SC_BOTTOM_RIGHT registers. These registers are also updated
> when the src and/or dst clipping fields on DP_GUI_MASTER_CNTL are set
> to default clipping.
>
> Scissor clipping is used when rendering text in X.org. The r128 driver
> sends host data much wider than is necessary to draw a glyph and cuts it
> down to size using clipping before rendering. The actual clipping
> implementation follows in a future patch.
>
> This also includes a very minor refactor of the combined
> default_sc_bottom_right field in the registers struct to
> default_sc_bottom and default_sc_right. This was done to
> stay consistent with the other scissor registers and prevent repeated
> masking and extraction.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

