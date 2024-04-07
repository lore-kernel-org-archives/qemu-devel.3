Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4A4CD11C2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 15:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtU6y-0004ZG-Fh; Sun, 07 Apr 2024 11:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rtU6t-0004Z1-Un
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 11:07:08 -0400
Received: from wfout5-smtp.messagingengine.com ([64.147.123.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rtU6r-0008J2-Fb
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 11:07:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id E2AC71C0005B;
 Sun,  7 Apr 2024 11:06:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 07 Apr 2024 11:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buhman.org; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1712502419; x=1712588819; bh=8CNDeXK0ztr9iRDTlFVH2
 zaWo90cTw52EAQSayqfQRg=; b=GB96m/CiQ2yr8aMS0+yEVhIXCi5GSnIIbQgol
 unz8yAZMf052+nsrbU3g+nitu6ODqm/9K2fRZM7hAO5doT+aWNa+5zZ4FzZDBl4U
 cREjy9RAbXJKHHH+5QSaoungZVoq9E6iIM0x1gEZOH8IuULNVNQbUWfQoKNCXeUP
 HlGt0XDqhBBGCXsMIS4X9EEh+DVBcxlvAjDvLrDHcuX3SOMFRO/SAjVdRJZT8xJr
 jhDM+Zwtv9NS5kxuzToFzt4RoD32+Wa0HIk3o5FH5+/YIgTni2C1mnjN3kHDN1mz
 FnreaDBzDxMNEewI7WMPavt2jgWYYVS9olRseWqB1Ycq7UK8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1712502419; x=1712588819; bh=8CNDeXK0ztr9iRDTlFVH2zaWo90c
 Tw52EAQSayqfQRg=; b=GwJMTwenuq01Qjsi8LVALyk2e40ggQ4rJNi0Y/iBsP2s
 P3EDXNkdfUSz3PAtcvKTPdBjmaEhx0V+05DZs/ChYgvzXHShTWbicQcnpSH4qv5l
 OU6n75Rae/Wg2RCWXIDEmGALUjVBB5gRH3/qxhQulfImy1uOhUpcKXN0QsuAtWLr
 wxHJ3k5IeV0kCCUOxRkeRLa4z/n0ByMWZ4GeA3Dpboj0H0BeDZX0/FeBrJRtp6MN
 2fd23HUhqfGfMqQLtU/aKOGcbyKmDq8dtpcucdL1nAJa10baTaq/+42JAupOmV4T
 lg1WFueTSzIb4ku6bFGfRT3iXkQlIIWnZzphEe79ew==
X-ME-Sender: <xms:krYSZn1vwwNSpgdUC_q3GKXJ4KIMqG6J5NyCRimjRfYgP9_91v99eQ>
 <xme:krYSZmHikqUNBHc6K0k2LNF4Jariuizz_F6bzaQh9oZC95iJLBgC0QHYxXSaDra0x
 w4P--HQYwvcB_0yKBo>
X-ME-Received: <xmr:krYSZn7huT1OaoHCHqd-_Msj11-iylLKSfKzpeqwtpZZ1Pp1kxa0Wxa_cv5lIOG8SVPzC8Lz2ClS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeggedgkeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
 ertddtnecuhfhrohhmpegkrggtkhcuuehuhhhmrghnuceoiigrtghksegsuhhhmhgrnhdr
 ohhrgheqnecuggftrfgrthhtvghrnhepudetueelleefudffjeellefgffeihfeuheeutd
 efieefueeghfeltddvheduieeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
 pehmrghilhhfrhhomhepiigrtghksegsuhhhmhgrnhdrohhrgh
X-ME-Proxy: <xmx:krYSZs2ix7HieIwQI_nyIY6AXBB7AjXFoWjxh5EN808opr9vABk8-w>
 <xmx:krYSZqFDhCVkvarU4Yln73_h0Y-SLgAa7apS9jirCqkBSLNURJnifg>
 <xmx:krYSZt8NZkV-RE9SaiOQ4rmq8sTglnrvQm1QjckpaXRrTZpFSg_C1Q>
 <xmx:krYSZnnTG9s583kqHIKc1i7HHQNK-GvGMLgZrU3zjxrP2oQd4lRkxQ>
 <xmx:k7YSZmj4XJOPdwrXbenBqOqwFp0UG-Cvb59ccziT8T8cb8Rg-lREbigv>
Feedback-ID: i1541475f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Apr 2024 11:06:55 -0400 (EDT)
From: Zack Buhman <zack@buhman.org>
To: qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp,
	Zack Buhman <zack@buhman.org>
Subject: [PATCH] target/sh4: add missing CHECK_NOT_DELAY_SLOT
Date: Sun,  7 Apr 2024 23:07:05 +0800
Message-ID: <20240407150705.5965-1-zack@buhman.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.148; envelope-from=zack@buhman.org;
 helo=wfout5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

CHECK_NOT_DELAY_SLOT is correctly applied to the branch-related
instructions, but not to the PC-relative mov* instructions.

I verified the existence of an illegal slot exception on a SH7091 when
any of these instructions are attempted inside a delay slot.

This also matches the behavior described in the SH-4 ISA manual.

Signed-off-by: Zack Buhman <zack@buhman.org>
---
 target/sh4/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 6643c14dde..ebb6c901bf 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -523,6 +523,7 @@ static void _decode_opc(DisasContext * ctx)
         tcg_gen_movi_i32(REG(B11_8), B7_0s);
         return;
     case 0x9000: /* mov.w @(disp,PC),Rn */
+        CHECK_NOT_DELAY_SLOT
         {
             TCGv addr = tcg_constant_i32(ctx->base.pc_next + 4 + B7_0 * 2);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
@@ -530,6 +531,7 @@ static void _decode_opc(DisasContext * ctx)
         }
         return;
     case 0xd000: /* mov.l @(disp,PC),Rn */
+        CHECK_NOT_DELAY_SLOT
         {
             TCGv addr = tcg_constant_i32((ctx->base.pc_next + 4 + B7_0 * 4) & ~3);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
@@ -1236,6 +1238,7 @@ static void _decode_opc(DisasContext * ctx)
         }
         return;
     case 0xc700: /* mova @(disp,PC),R0 */
+        CHECK_NOT_DELAY_SLOT
         tcg_gen_movi_i32(REG(0), ((ctx->base.pc_next & 0xfffffffc) +
                                   4 + B7_0 * 4) & ~3);
         return;
-- 
2.41.0


