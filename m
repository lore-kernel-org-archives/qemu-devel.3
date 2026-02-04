Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73475E9D410
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1N-00074D-51; Wed, 04 Feb 2026 11:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1E-00071p-14
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:22 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng19-0004Xp-DX
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:19 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9CC307A0075;
 Wed,  4 Feb 2026 11:46:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 04 Feb 2026 11:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223574; x=
 1770309974; bh=BGK+qrVIcAnLNRs4fCH6awA6ce+4NWjLrrbX14e0/JI=; b=m
 qB2F9DF9vRoEs7jtMsu4ZBDC6aQTU1i3+NGy59fSlyqM5Grr7GL2Wr5f3JDdvSct
 kSCJ5FpaKtq+URa+AMPQsIWkZHJGwmEbRL/i8UQDBphwF/Y02Ep9zusWwB8wyT/+
 Ng9aW6/MrCLCWYFq6k5IbhqYOuYuRpTd6IsYOsFEzmCdpqDKVvXgYwHd3+Mi9/eo
 DWaGYYkRFxyP1xyKif7sbGjqtrGpEtxljXzvy3iSKOvITpkcfPnxGIoEcA13Wdwd
 zp3J1X4shmq4s4fVKoATQdIY3b2A2XnJcYde2z+h1dkow4Kcmk2VptrgoXZezij9
 ldKviEpjBdlO0X6WaXpHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223574; x=1770309974; bh=B
 GK+qrVIcAnLNRs4fCH6awA6ce+4NWjLrrbX14e0/JI=; b=jpusHqDx6FtmfZHwt
 FSypEwp6tLtWIfStZPpG+3jpRBHT0/ZcjCpc4zsU7Nx1ob6sgMdOAZkQMcwm+iM6
 60lXct5E43lJNmjhgavHOdSj0/JIDbK6TKiGeuLNFCrWzX5+2em28oxZFIFUzmF+
 WVRtZYkOROwxmcLhplXNF4KIZ126rU053JDAQCOqwsKo2mElhrF30m3bxPSE3C12
 yzgCndcF3iw8j5XtMof7eQP2zUoqi1XftWtq8V94qleGjsPGH2VI/yCyHmyC9Rzs
 D/y9ry7SmX7y8oFE3NbbPM3bQr1/MqRxaw/QhomIsqPkGmUxcRmhNWEh9MMbIIB1
 RCUzQ==
X-ME-Sender: <xms:1neDaYdeW8LFZ_fIBbpuKOjEhbZozjHyYMLd56033l053nhN-VLbVw>
 <xme:1neDaRqBGsC0OUvwxi779B-pkH8zhgzSgKOzy4JIrxGUexbqtGlB8ng76CSpu0NBj
 lmIajNcc8CJUitzBq0B4Wo6tPNyOJG-cnBxi01j0n-VO0hwRun60hU>
X-ME-Received: <xmr:1neDaW5cvF9SjIetMt8Tb1Znk5xyN6xONNnqpK8vBi1F0eKtNUgFzePO-3sK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1neDaXqycIBT0ofJRiWBc7Oi7tjdaqwTQbKPA-lPVyh2hdrld5yzPQ>
 <xmx:1neDaYgVL6_5Eywl9Yy0Q_fDcu2BbiP5oKqXCFIQnpM7tUBHP7bvLA>
 <xmx:1neDaRLcVbibu7wp4DRRg9rx5TJObKFxAAwt3WDik6xmVTbQlGUsuA>
 <xmx:1neDaYDpsYpqB0qpeZpf9z6hA_E-v6VD90MYzGXJGcMGScNcZ780xw>
 <xmx:1neDaQXFCQ57r8T_ODCuYGAJkYDOklO77vRWk3olZjjCK1BdaUsTg5RC>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:14 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id d4629aea;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 14/18] ati-vga: Remove ATIVGAState param from ati_2d_do_blt
Date: Wed,  4 Feb 2026 11:46:02 -0500
Message-ID: <20260204164606.3425246-15-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204164606.3425246-1-chad@jablonski.xyz>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.156; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b5-smtp.messagingengine.com
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
 hw/display/ati_2d.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 063928c442..8a820bc91f 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -123,12 +123,12 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
-static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
+static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
-    bool use_pixman_fill = s->use_pixman & BIT(0);
-    bool use_pixman_blt = s->use_pixman & BIT(1);
+    bool use_pixman_fill = use_pixman & BIT(0);
+    bool use_pixman_blt = use_pixman & BIT(1);
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
@@ -267,6 +267,6 @@ void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
     setup_2d_blt_ctx(s, &ctx);
-    ati_2d_do_blt(s, &ctx);
+    ati_2d_do_blt(&ctx, s->use_pixman);
     ati_set_dirty(&s->vga, &ctx);
 }
-- 
2.52.0


