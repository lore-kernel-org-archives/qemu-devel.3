Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916BFE9D410
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1S-0007BC-JT; Wed, 04 Feb 2026 11:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1D-00071m-Uq
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:22 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1A-0004Y6-1l
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:19 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 650CF1D00159;
 Wed,  4 Feb 2026 11:46:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 04 Feb 2026 11:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223574; x=
 1770309974; bh=8KLDTX8XBd2F/OTfKN2mr45UqgSUUoPBem6fdHsn5mg=; b=D
 FZ14ItKpbKg81UDnT+dHnKsWWX/rtFrvl0wzJR1T5G1GeV81vHWkGqWiN90FK1A4
 f9cDFyFEflfna3P2W4WckJ/mTk3NRCutz816f+XAcLs0oOMY/djrWRjpGy6o8aBr
 WAr+pNBV69VPTbnk3iXt0WP16q2r6aUh6cd0BKo23YsyAVYyzOI50OjGMJCjqaTj
 TlIaGFdxHxAF+AapSP10S0HaKxOtP455QjqJobnYEghmzkErtQZfZRtxjz5g0ti0
 qSGVOqujvkSQdBkKNbVSORCYqoI4yQSE9a+mytnb3jTrlLLto30ZGtWBiopKdUuK
 sMeGvZFPlpPjRTZf43/4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223574; x=1770309974; bh=8
 KLDTX8XBd2F/OTfKN2mr45UqgSUUoPBem6fdHsn5mg=; b=rD8DNZszl97ZCoLuH
 OuUOf8vbhE9/XLZsg6Ks37ImfkB116QrBvYMj86yVEl5z7HRl2mUdCH8mvVKkfHZ
 FCK3Q1hXIuqOsLk9ZDyVvUD9J440lX8VPh27YZn0gSUYfkrIaDUnwln6xV6FEVw8
 ZBURHeSGrAOAKnPgFarqz1N7FABombOe9ZJd8+rk10HMFt0sEbK9kv4wDS5dQgWs
 C3mGu/F4P6ng6t8AcyT0LgjzZW//7JzJ1u1+Nb/DvIownCZHlFyoQMxR8tdULm8P
 pyAelgirQvcNui/4U+BWvsAi3Z7uFglm3bWNFb3x1Y80zd5u8A02L0EyhZCHtDTF
 cWIFw==
X-ME-Sender: <xms:1neDaUmQDSHs4ewTKMC72_Z-m13CimGn8FPCvVq4CuT6KRQgLLgQdQ>
 <xme:1neDabT8hUV4Ux7BYYUIVFlOOmh9_1Enm9NmBjAbusJ7srsZvaTaJjZq_oxp6psXz
 hSgTOoSWZxVh29LIn3K-eWDNtR8OBrs0nQP-g8jlZJsQfdxNP8o1g0>
X-ME-Received: <xmr:1neDaQBZhD2b08ESPozB8opv7yQkW7DwqGaSqcFdyQq2h6quvO1CljrVjp3f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 gsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:1neDaaRoGg6N6hlahQW85ITaISApxww4hPwzQfbXELiJVTH54GDdTA>
 <xmx:1neDaWph09Q3M7eZNRF9AQKCTKz-UJdGmP91_Fpu6QV0q7ax3S4m8Q>
 <xmx:1neDaUw3z0u_TFEvdHNaozi62eDWWEVolu8HeSTlOuIbaBPGJMxQ_g>
 <xmx:1neDaTLdy8L3TZmroxIi8R8XvXQD5k80Ip2OGRBvfX8hdxO7GApp8Q>
 <xmx:1neDac-gIUzlbAcCv5brR0HbsJ8Pu-I8soMcU46jRZBz--XnwX94G3tm>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:13 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id c38fbacc;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 13/18] ati-vga: Split ati_2d_do_blt from ati_2d_blt
Date: Wed,  4 Feb 2026 11:46:01 -0500
Message-ID: <20260204164606.3425246-14-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204164606.3425246-1-chad@jablonski.xyz>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=chad@jablonski.xyz;
 helo=fout-b7-smtp.messagingengine.com
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
 hw/display/ati_2d.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index cf80296a25..063928c442 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -123,15 +123,12 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
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
@@ -263,8 +260,13 @@ void ati_2d_blt(ATIVGAState *s)
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
                       ctx->rop3 >> 16);
-        return;
     }
+}
 
-    ati_set_dirty(&s->vga, ctx);
+void ati_2d_blt(ATIVGAState *s)
+{
+    ATI2DCtx ctx;
+    setup_2d_blt_ctx(s, &ctx);
+    ati_2d_do_blt(s, &ctx);
+    ati_set_dirty(&s->vga, &ctx);
 }
-- 
2.52.0


