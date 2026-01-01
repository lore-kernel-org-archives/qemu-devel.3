Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652E4EEEC1C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 22:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbQw8-0007C6-Ka; Thu, 01 Jan 2026 17:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbQvi-00078o-03
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 17:14:09 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbQvf-0003AQ-1v
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 17:14:01 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6D4C15969FF;
 Thu, 01 Jan 2026 23:13:57 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id rfW3m2vI2bRD; Thu,  1 Jan 2026 23:13:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 74B575969FA; Thu, 01 Jan 2026 23:13:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 734825969F6;
 Thu, 01 Jan 2026 23:13:55 +0100 (CET)
Date: Thu, 1 Jan 2026 23:13:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 05/11] ati-vga: Fix DP_GUI_MASTER_CNTL register mask
In-Reply-To: <20251118154812.57861-6-chad@jablonski.xyz>
Message-ID: <c8b75ff9-1d40-6113-51b6-34b95fec5ef9@eik.bme.hu>
References: <20251118154812.57861-1-chad@jablonski.xyz>
 <20251118154812.57861-6-chad@jablonski.xyz>
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

On Tue, 18 Nov 2025, Chad Jablonski wrote:
> Remove the register mask on DP_GUI_MASTER_CNTL writes. Masking on writes
> is usually used to exclude reserved fields. This register contains no
> reserved fields. All of the fields are important, even if not yet fully
> implemented.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/display/ati.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index d0fa51f773..cfb5dc2fb8 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -883,7 +883,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         ati_2d_blt(s);
>         break;
>     case DP_GUI_MASTER_CNTL:
> -        s->regs.dp_gui_master_cntl = data & 0xf800000f;
> +        s->regs.dp_gui_master_cntl = data;
>         s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
>                               (data & 0x4000) << 16;
>         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
>

