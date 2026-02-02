Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B8BE7FDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 20:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn0qE-0007Yu-NH; Mon, 02 Feb 2026 15:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q3-0007Jv-IR
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:05 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q0-0001oh-RX
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:03 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0CB0A7A016C;
 Mon,  2 Feb 2026 15:48:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 02 Feb 2026 15:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770065279; x=
 1770151679; bh=UqNwsCiSrH71LGk/v8LfcK0YBEsMqDLImOdauk74CLE=; b=T
 z22I9Hn9pYxS583la0/gaZD52GCLXVqdxBciLtFcG4BrpJozD0Bmuo7QMHzRJJAZ
 sZqv++W3phrw1+e3gfAZxB2Dq+Oh5wZpWzXAESs2IXOUJw76N058C7GIdZaTpnJU
 9zcTzk6d+/8dEM1/ZeB/K3/Jc88sJvnN05j+cTFOZgkSTHbtqJJiCZm2W9otL/Jx
 1vL72XI3YBT80Nv9kZjM1PbuSlIWHylGR4Wkb5kX6YP3OSBNZixnzfhkhvZqueSn
 IFQncFNXgNv4A+yf/07uToSD+stMc2+iX3ZzERUBbrEFzfxwW8guHz+QL5VW69rT
 ghCALts54Pb1xptc0q8fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770065279; x=1770151679; bh=U
 qNwsCiSrH71LGk/v8LfcK0YBEsMqDLImOdauk74CLE=; b=HU3n5kfQi+egH1RXP
 GWHKTcVOZVZUTm0cAw9o6KPfqCLaMRK6vGbMZZtVB7s5sZjkIPZTLd2lcvEekNQf
 4y200v1rFZUNKL3o1pjkELqNmljGxrURHZSyZzZIsGL+zMcjT2kFxDe+iR8x69b3
 19ZDDJHXvmtugQPFrDuYPqdXw9nGnGEYtxWSUzTe/9f+/mbqKtxCHwzN/Lv2fDd7
 8iVFl3iILJvOVWEV0i3mM1lJIyLNc4N6XG4bftOxgAQIcDGGiE/4JXKobN9gk2p2
 Ta6JfY91/zi+jMzLJqn/C18rffNEWOcGZKPkOLLq6Gk7j+WJLEiuhmwX7smTitgE
 qrRBQ==
X-ME-Sender: <xms:fw2BaWhDTrjjC80kyQeXvSd_-xfv36Vf7pfTiThvdUltshIKR_RZNQ>
 <xme:fw2BaecalM_MB2zuzkkec9Pu_ZRW5RR6Ec10HRaG4--V5n3kaOA7FHm6LcbTwBivj
 SRLFBfP7kv9FCfCm_OADZyXTVPvACgWBJHOw7O35i_tA7_TBbIYSnw>
X-ME-Received: <xmr:fw2BabcGrcUn-AI0m10wsGgTa40iTaPo_2AiphFY2YIDY0BKbmov4rXL8RTI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:fw2BaY_JMmqdOIP0BTm0CE_DjzwYLNDwTBq3-0aVxbUiBUPTMKnhJA>
 <xmx:fw2BaXnH6xRTBpFr5qIsWiPd4-XaeM0jwwBlmfSeGD8dCoPhGaWl-w>
 <xmx:fw2Baa8luJmuoCpYreG68DXT1G0iP_zP50_OU3_VQP7vzeuazIu2Vw>
 <xmx:fw2BaVlPatJhrccSiPPsbbgwNvZgbs452F79q8lGexFfkl0EloKlbA>
 <xmx:fw2BaequSAqO5etmwLZjOX8zPs0V5zfOvlbMcmMu_eBocrLIJJpVVCFN>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 15:47:59 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 455ec311;
 Mon, 2 Feb 2026 20:47:53 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v7 13/19] ati-vga: Split ati_2d_do_blt from ati_2d_blt
Date: Mon,  2 Feb 2026 15:47:31 -0500
Message-ID: <20260202204738.3080092-14-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202204738.3080092-1-chad@jablonski.xyz>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

ati_2d_blt remains the public interface to the blitter but the bulk of
the implementation is moved down into ati_2d_do_blt which is passed an
ATI2DCtx.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 525f20d83f..4216986b6a 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -121,15 +121,12 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
-void ati_2d_blt(ATIVGAState *s)
+static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
     bool use_pixman_fill = s->use_pixman & BIT(0);
     bool use_pixman_blt = s->use_pixman & BIT(1);
-    ATI2DCtx ctx_;
-    ATI2DCtx *ctx = &ctx_;
-    setup_2d_blt_ctx(s, ctx);
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
@@ -275,3 +272,10 @@ void ati_2d_blt(ATIVGAState *s)
 
     ati_set_dirty(&s->vga, ctx);
 }
+
+void ati_2d_blt(ATIVGAState *s)
+{
+    ATI2DCtx ctx;
+    setup_2d_blt_ctx(s, &ctx);
+    ati_2d_do_blt(s, &ctx);
+}
-- 
2.52.0


