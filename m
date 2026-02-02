Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045C7E7FDCD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 20:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn0qM-0007fQ-1i; Mon, 02 Feb 2026 15:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q5-0007Kv-Gb
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:07 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q2-0001p1-8z
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:04 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 76C4B1D0011E;
 Mon,  2 Feb 2026 15:48:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 15:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770065280; x=
 1770151680; bh=+MP/dkofv5no1P8Lu6mjU1EdbIDlKQHToIFYTTv9/lc=; b=b
 xOQOUVPXb3hQPPROfnX59zZskP5ke4RYtXv0kalmRLL6GmSLrpqUNbSxTqaWHsC5
 ecqsUXrPIBFmaoPIdEdmPcZRMT8SgPUFbidJdNKcQuPCW/mayc7fXKXQ69aFy0v3
 J/TjbvnNxyod5HEGFWptUeFUpuLdi0ISepR+gpnlC4RaoZ1awkJK1rF6B+adhbFO
 EKlCYn1GbR+oM1K3KVfuW/bsP9LQQurwxobs9BFiSQmsrwiKB1lZFcSMzlrzNwKn
 nGno8XM8G663RKAWNMH71yt+NJRq3v0kBR1egMjIGT9ZOFROmCZUvBZ3iFcOuqRK
 fq0PSnbvmpCsgtJOiDPxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770065280; x=1770151680; bh=+
 MP/dkofv5no1P8Lu6mjU1EdbIDlKQHToIFYTTv9/lc=; b=DTmn6I975LAqfaYo2
 BdzsjjbTlEYKIcxq/i6iq0Jk0nfMEke2ibvGgwfSNN3CANa4pvl5e+tFgvglcMfe
 l0SvGOqgrXGNvbxSoiaDfNIYZSEAiKbOY1AzcZ7RfsHE67PC2w9/+Re3gtqDcHiq
 1KbT+0ichdXhCjxP5IA548bVt9/8bKLqe3AwHhrz4OJNeCKH4slt+XwK3WdYo8dr
 S2DvWDhAeYdG1rgvc1CpEsCk68kifAQNrU0eNaiGw2yWED/1X9xzMOyePBKxKvfI
 8ks9heIxbzk9QKb3F/54tK/ntsyTvOXmWsVW+qDPDc6e6sDB095UeXa1PHEuw/m4
 rM9CQ==
X-ME-Sender: <xms:gA2BaTrkdjkYXN6pIklJOz_6yRXQtWNnkYTcnLo2T_JhP4xbMKbTHg>
 <xme:gA2BaVFA9atF2p3LtVvDxvtzd_pzOHU5NwG3ltq4eGTncqWJonEvnbJHdY3Jf8uiw
 4vaTS0pSL_UfiSkbYzxG3ybk1fhiv3y-EunwwQW8HXmsByPPHoL_To>
X-ME-Received: <xmr:gA2BadkwX0zUhrcSNkawoHLw2mWjyO0W0k4Nk1JHoMex7nX7yYQrpCFXRwqN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:gA2BaQlGQSm-Ac_kH4cqGl3O3QV3Gj4RRgSl7eB2O6PllZM0EnpKhg>
 <xmx:gA2BaWtjZP6W_7XTobOFSTFOCHy577752Drq5_0AtZnuwr5Ax2GUBA>
 <xmx:gA2Babn3Rf149qcJMLqxagBplCqPA9ZZvUIKUjb02ZWjROyMSZtNCQ>
 <xmx:gA2BaZu5ue2UtO37fEdWdTuKPbDNB_GnP1TBBFZdnMmA4leQpaG9yQ>
 <xmx:gA2BaQROCZp7ZztGESacn7I3u5MrsXiAfURQta3Eg5v_eJqubG2-vVDg>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 15:47:59 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id f503aa7e;
 Mon, 2 Feb 2026 20:47:53 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v7 15/19] ati-vga: Remove ATIVGAState param from ati_2d_do_blt
Date: Mon,  2 Feb 2026 15:47:33 -0500
Message-ID: <20260202204738.3080092-16-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202204738.3080092-1-chad@jablonski.xyz>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=chad@jablonski.xyz;
 helo=fout-b4-smtp.messagingengine.com
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

This completes the decoupling from the ATIVGAState struct.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 8397a4d1bb..e1e48ac81f 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -121,7 +121,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
-static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
+static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
@@ -269,13 +269,12 @@ static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
                       ctx->rop3 >> 16);
         return;
     }
-
-    ati_set_dirty(&s->vga, ctx);
 }
 
 void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
     setup_2d_blt_ctx(s, &ctx);
-    ati_2d_do_blt(s, &ctx, s->use_pixman);
+    ati_2d_do_blt(&ctx, s->use_pixman);
+    ati_set_dirty(&s->vga, &ctx);
 }
-- 
2.52.0


