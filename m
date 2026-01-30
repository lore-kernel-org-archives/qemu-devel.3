Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14665E6BF19
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppP-0004jJ-D5; Fri, 30 Jan 2026 09:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppN-0004iZ-Jq
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:29 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppK-00038B-Qr
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:29 -0500
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id ED78B7A0164;
 Fri, 30 Jan 2026 09:50:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Fri, 30 Jan 2026 09:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784625; x=
 1769871025; bh=/mQKU6rDb9DvS30Z6stlUynjg5U0SmB3/+0rEWKV0Ns=; b=Z
 BXS5XQJD/voBWN63KUSMgQ13QrYhroCzcMBWIwuxXOcgD9mLl+7CmE+VSa4LT5wW
 qjevy1KTbUsDhAjU7IeJHk+XzElOuyhDjEhVouBjttRm9HVRIaw+eK2wl8Yu9HVh
 iNA5/E2MqcHXiwWK7xy2hGnvQ2DCv1UYkYDuYUJnSmJ0HovB7oVyJBtlovjk1hMS
 sFILlMN3FZNbWoHr6klOboEUyCRh0XbocOkREqE3+CvknKsz7i0Kiccez7762KrZ
 FgXd2d37qANnsYVFaL/W4cxY5+RxRmyR4SH5eeut+HPWfdm2X0veREyW4ZfNgz5p
 RgKYxJzeK6R/4y3BZw6qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784625; x=1769871025; bh=/
 mQKU6rDb9DvS30Z6stlUynjg5U0SmB3/+0rEWKV0Ns=; b=GssFd+Xd7ArxFcXgZ
 ErSSljDA1JZeXcl/uj8Ytve10C1+JMT9ww8RQXa2zgNIB5cIaXnr4UJvewo1K8E7
 7RDpp18A6bMDkj9tRQ95Ytz33/m7cyqWzFJpysZu9E9yqB4SxxR9wx/9bkEeDYPw
 /40uVHaFY+qKXCEHkLQgR5Rj2z2uvSgTV9mj2Jyx+bNrtJ672PbkyhQPZ/Kh029A
 TSvyLAcmIP08CUxpUfjKeBxc0IvVRIQI1fpuXB6SHR9lIi5RrvRr4P73b+kE3TX0
 fo8Zp6kLhi0owEI8ksy8ShXVInspUgBXSKaJuENLethC2W86MuPZQrbzbTEq5Vh2
 pGihA==
X-ME-Sender: <xms:McV8aWfBBUqS3xpFXFAYxyBc6IDUxldh5bpS2wQvqdULq7MtkI9Vjg>
 <xme:McV8aXra-_40XwZKa38Hq9BWLKeh_SBMseg6i4jrtSgfSoWJLM_e11CBLgLKtG1Sr
 xxq8VLU7260Rrwp28RqPCRJuNiYb6-JzDkCIdD7HYlZLBVsjK30aA>
X-ME-Received: <xmr:McV8aU6qe0DrCkLO254BdHQnOAmxoO1VfR5wvcR5mpEGzJhFPb1WGBCXKdVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:McV8adoaXBzeS52TxyuV8A7Tf65aQULo_X4yIuQ0tXUFX9qut9AFGw>
 <xmx:McV8aWjGsAqwLJJ2rPGM81pMc4z2TQWvH5eyMYWFb-JvXbGzvmAxKA>
 <xmx:McV8aXJr94Gl0PXtjic60qoAzSMxeTaS_l-QOLjYBMApwzQkds19dQ>
 <xmx:McV8aWA1zPexA-R0BQLAWcCaFQWTjvomCtMXxgSVpCdVdNSRMV3OPQ>
 <xmx:McV8aWUDrqGTxB0Injmv7SloBfe2TfI4R20Gl_6eerHcBXFMXnrm7Z0W>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:25 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 994a6d89;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 14/20] ati-vga: Pass use_pixman to ati_2d_do_blt
Date: Fri, 30 Jan 2026 09:49:59 -0500
Message-ID: <20260130145005.731129-15-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130145005.731129-1-chad@jablonski.xyz>
References: <20260130145005.731129-1-chad@jablonski.xyz>
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

This is done in preparation for the removal of the ATIVGAState *s
parameter.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 5ea2df1126..39ea67aeb7 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -101,13 +101,13 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     }
 }
 
-static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
+static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
     DisplaySurface *ds = qemu_console_surface(s->vga.con);
-    bool use_pixman_fill = s->use_pixman & BIT(0);
-    bool use_pixman_blt = s->use_pixman & BIT(1);
+    bool use_pixman_fill = use_pixman & BIT(0);
+    bool use_pixman_blt = use_pixman & BIT(1);
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
@@ -275,5 +275,5 @@ void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
     setup_2d_blt_ctx(s, &ctx);
-    ati_2d_do_blt(s, &ctx);
+    ati_2d_do_blt(s, &ctx, s->use_pixman);
 }
-- 
2.52.0


