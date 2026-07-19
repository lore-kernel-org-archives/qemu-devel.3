Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79723C4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlUBA-0007ia-CD; Sun, 19 Jul 2026 12:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB8-0007hl-38
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:46 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB6-0002Oy-4H
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:45 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id C731F1D00077;
 Sun, 19 Jul 2026 12:15:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 19 Jul 2026 12:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784477741; x=
 1784564141; bh=/a5H+DzHLCwmJeKTjrfie6KlbRxqPnhrnXfZ6kYU3OM=; b=K
 AFkSPlC2ryqymvjBSfPO591xaBHHj5prcBY6mkcdlYXLw8l5UW5dCSqm0I/T4M56
 QYCExaCJBI3INht+hqRY0hpUxr2D2YUPbuqQhFyLn5bxgECsKXB2frX3xQtNLE1c
 u6rpeTOzDyP4IW8aAtAOmmrbDJ63G7hihfuSlXa/GQzl4HKQqd0k7f7VmzXa5zF0
 k8Gcmvpgum5okYNrzeq7lcki9OEomkj/5cgphzC5lj5X7dUaB1jY6sKWm8JQLvQH
 DnSWGZEeT+HGQHRifeuwvKpOTAYKJKDg6CvVyBeyqUiK9ZsiLOB5OfFGT5z3yNaL
 LiSu0wt5v1ShPh+CTfCQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784477741; x=1784564141; bh=/
 a5H+DzHLCwmJeKTjrfie6KlbRxqPnhrnXfZ6kYU3OM=; b=pCZ1Pd0v27+bkFqpT
 geIyPqiXMjQq3He73d43NnGZrZt7K42+VJHOihXAq7Y+Rfjtz4i95Yqkai0x0+lK
 PhgkS4pUlRfhD9+7lkdCGmGXeOSwQ90o5gHbj5RffNmqPrhDqbaWkgYi+uxyNR6g
 bG7RtUkBkn7Q08efl3pBhYjNZAAdqXzROAgj+BTkCBywXn+LgDmJ/dG/LvCyZzUD
 tHeji6aHrSaLENpv3qbZedSKvzas/btuOp7HJuwXa8ZmwEh/DKfH6MQRmIXLzwx0
 UBObHAaLaS/Dnv9aV/G3u4kJLap//k5hXLfRBPB8mXQLma1C8jgzImWssfD7L48b
 IZteQ==
X-ME-Sender: <xms:LfhcargpvqwfLBVgYdpOVVvgHYpYd8SVuP9PRimD-sy84lM9YuQEfg>
 <xme:LfhcavcK5R3qMX2JDKNmVghq5XkJAKoy_Y8kIgx_0GuHJmiYq2TnTFO8eqolgF7TH
 CweRMhpYM1i0oQtSz-q8_x9gIW7IuJvPixGYp5K5qLjyBiCRJJrrGE>
X-ME-Received: <xmr:LfhcaoedkQSyfswHGlMXl-iRKv-5YOA9QmOtu9lfzQSmZ38pYb47oKEDT3c>
X-ME-Proxy-Cause: dmFkZTFX22WwMbS2sW99eCB50G1QKT6MSqCpx6iK5itrq8JxZaP0521f6QSaZn8xZ08MPO
 fOwSNa6WDSeLTJNQVc/fxMSGvDLkf+yg/0G9Q09ZIOYGIXIBd2hVswgLVRGFoWlNQkKsDF
 GdNkKsfijsKMESGF+IJc7XNHY6Tof4qnJ8h5MKF7zpjgYI3Er1oT6Sc3p82wEBVA4tVY6K
 sm0munSEzPQOSr/py3N0SGFxIhaHx4yY0PMKs1GFt63biT3SGPXDCwnyEFOs/p40onWKAs
 7IByVaX4T1Xvhqors54F3a+bmhyr13Lneen+jWeanFhb1s0umv08sceX1eK90gcHhjDIXU
 xYYNKlv01EdCAdHWvDf+OP7N1yMF/2bQruidrRtJyHM6Y7uuTUZkKVNJTgkYRsBvVbq/MH
 kV4c1CX5CpNu1bO+B77gZQSo/Pon+WKByJiY7d6WcScmj1l81rPtkNX55L6eYKInZT+5lf
 56z/FWyEeqzYpelLVS6Iq83WG7gg6Z6dS6bIamHKGU5QrIpmnWABtlZMUpgcZ6CFVhI2w4
 b7E22wIcE36bBHnvjXBxuUv2Or85YoUB9NF/OREGJQOP+gSwyjaIBLz0zNokqfd9yyEq2X
 d+c/QZhLs/emBJ5JiV4bL6nTJByOMG97E7zOkOt6pHz4ulwEeEgvsKpNs8/g
X-ME-Proxy: <xmx:Lfhcah_gxfhVxKoqyK3g0FOV2d4l4aNDh9WzaJPkUccKhIfaZRyWkQ>
 <xmx:LfhcasnCkZwuetp1WOLv9eTPoMUI2buj9PPnMT3Ua7PoCZuoA_UQTA>
 <xmx:Lfhcar8G7ohcP82i6PbwOezJmndmqmyOFPsFXqLvQOn_G4KdhsZ9_w>
 <xmx:LfhcaimDT2-znZt052kmL9cTI382VPMsVcXkg1ndzR2-vM9LqZ88GA>
 <xmx:LfhcanqmKxEBdsvPob7F-NE0r6yZiJOWKXKHrUWQiBMCk0CqD2zOf3UM>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 12:15:41 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 7f044711;
 Sun, 19 Jul 2026 16:15:40 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 1/9] ati-vga: r100 scissor dimensions are exclusive
Date: Sun, 19 Jul 2026 12:15:28 -0400
Message-ID: <20260719161536.774061-2-chad@jablonski.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260719161536.774061-1-chad@jablonski.xyz>
References: <20260719161536.774061-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.146; envelope-from=chad@jablonski.xyz;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
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

The sc_right and sc_bottom registers are inclusive for the r128 but
exclusive for the r100.

Tested and validated against a Rage 128 Pro Ultra (PCI 1002:5446) and
Radeon QY (RV100) (PCI 1002:5159).

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 7a4a115aee..3b27917bf4 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -106,8 +106,14 @@ static void setup_2d_blt_ctx(ATIVGAState *s, ATI2DCtx *ctx)
     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
     ctx->dst_offset = s->regs.dst_offset;
 
-    ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
-    ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        /* r128 scissor values are inclusive */
+        ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
+        ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
+    } else {
+        ctx->scissor.width = s->regs.sc_right - s->regs.sc_left;
+        ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top;
+    }
     ctx->scissor.x = s->regs.sc_left;
     ctx->scissor.y = s->regs.sc_top;
 
-- 
2.54.0


