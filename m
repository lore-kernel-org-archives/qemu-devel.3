Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA618C4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlUBD-0007kh-C2; Sun, 19 Jul 2026 12:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB9-0007i2-E0
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:47 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB7-0002P8-8L
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:47 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5C8177A0064;
 Sun, 19 Jul 2026 12:15:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sun, 19 Jul 2026 12:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784477743; x=
 1784564143; bh=fTK4GZLiirmSWWlOsqcGVSRDF7vmk2Ye0ljQ9MSTLhE=; b=u
 ZfQ5GFCTLcSDjLJBm0dlp2mZFYLdiPkWQVihGYFTADNWtuVZ+O7aI7pZH7IjzuWm
 p7JeESZjGsDrv7E6jXdHsm4eBV5x2H3W9ZSNZAgmb2gsQmrQEzj5IgJ2ws5yDNdZ
 Wm3Aq4+kc5N8W2ZuPGXnwncrLtjFkJEcva6gdiaPk9ht6r/NYoazFYE8U5EJ0LeN
 eYAN69SsMHmfGVLuT7zQykqadRL/I518BOEkDgn+KFXx3FWuQMaQL9XkFMeU9w58
 cK9tyErKMwjXmgEhJdEV4qgRqnglmh6xyWFN7dnDh5ttoRX13Bt7jojrVIilaHSF
 9AK2VrwANtYMdJGLWAyZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784477743; x=1784564143; bh=f
 TK4GZLiirmSWWlOsqcGVSRDF7vmk2Ye0ljQ9MSTLhE=; b=qr+WfO1rQksw5iwC7
 IS64KJFrLO83gai5Sq4fBD/FiJMYadwjmb+wJuvqD7XwYVXJPTgDn6XypSWyrC5q
 N22DM9aGu50uRopjC2sUuYwigk4Vy5L9Gy8pqutAAD1txijheoGkOjlvAJH/gdGN
 hGP17mT6awWJdRDlipT7EjrBg42WbxB8E9Xuz4kvfNTe5b/QaW0BpMx+IntjpxoK
 Ag0k8emY1/6bAugcQv7R+wVG4VK5YJJSxD1DfgvF8Jpl3WMjrTs0MqZMwC0whBjm
 gb6+VkXnd2yjYZK6AW7QHdxAlGn9EmzjbWf2J223EXTmUR+bnpml9lI85vvn18b9
 Ma+ng==
X-ME-Sender: <xms:L_hcatMDKR_4uhLwmh47mVSaGEwoUFhWqXb0e5fQHw5mY6rgyvbihw>
 <xme:L_hcanYqPFDzGQXgBqQDBYblnChf0XimJAnpOG5RFfr-BiPs76IpnZPw7FvKeCCr6
 d7G_FVqEEv1XWAasIqa8NBG4SsYjzyvPwqgXomxMAq7aa9grbUA0uFp>
X-ME-Received: <xmr:L_hcapogCuW5RdolsuioyhorYzhXWi_-mlVhf0j3uMwKa4Nne3NQtAtEezA>
X-ME-Proxy-Cause: dmFkZTFX22WwMbS2sW99eCB50G1QKT6MSqCpx6iK5itrq8JxZaP0521f6QSaZn8xZ08MPO
 fOwSNa6WDSeLTJNQVc/fxMSGvDLkf+yg/0G9Q09ZIOYGIXIBd2hVswgLVRGFoWlNQkKsDF
 GdNkKsfijsKMESGF+IJc7XNHY6Tof4qnJ8h5MKF7zpjgYI3Er1oT6Sc3p82wEBVA4tVY6K
 sm0munSEzPQOSr/py3N0SGFxIhaHx4yY0PMKs1GFt63biT3SGPXDCwnyEFOs/p40onWKAs
 7IByVaX4T1Xvhqors54F3a+bmhyr13Lneen+jWeanFhb1s0umv08sceX1eK90gcHhjDIaK
 mVbEM6a68yD/dqXMPiTRh1fv6xudCC1VCXPG+uUcU5bLeBINxA/l89MO9gXVRrATdYMrS3
 nmR5jcHVCeSKlBMG1bpQeI0E6jp4qHNypNQKz1yquvU18YFedyiV3yecRqX7by15CsQpjR
 wn4Ftg7IOdfJQNuFDMXYWveaEQ+eh7Xmpj8VijSicouFTQIlt9rVgOGCAMBjJ3v2/STIG5
 rRG79ROBsEdehR7/t+vDm5uymrYCY//I0rImjylA/8PuqVQ3zNw/EfC6TmUZImRPawTEGs
 tnmxQ1Ns04bBPd0T/apcyqntPwGOIcSWT+blRXSBi2x2nWSAQc2kHx4oWluw
X-ME-Proxy: <xmx:L_hcajbBXCH7_CalK78JwNL6L7teCROADhC-2E2SvX7mpB_N6PiliQ>
 <xmx:L_hcapRDPubsQL4aXaLJ-L5cu2sWQtJV4j2cgsreIVeO3VQhBBEfow>
 <xmx:L_hcai4_O6j2LLkk10rqqRohN4WRcSEQIejr2nnL0gGxUJ3VvrB1mg>
 <xmx:L_hcamxEOGw65-sYBjhUhEkYx66kLJnX8SQtCMppRpeGH1C-YW_oPQ>
 <xmx:L_hcaoFxi02J_AYGYMvfY0A3hpQ9H_Op7Aioo0cH6zjJNUQqXyvoYQUN>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 12:15:42 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 762d744b;
 Sun, 19 Jul 2026 16:15:40 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 3/9] ati-vga: r100 pitch registers differ from r128
Date: Sun, 19 Jul 2026 12:15:30 -0400
Message-ID: <20260719161536.774061-4-chad@jablonski.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260719161536.774061-1-chad@jablonski.xyz>
References: <20260719161536.774061-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.155; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b4-smtp.messagingengine.com
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

The r100 src/dst_pitch registers hardwire the bottom four bits to 0.
This is noted in the M6 register guide.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 76070d76a7..5c1232a31f 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -825,9 +825,11 @@ static void ati_mm_write(void *opaque, hwaddr addr,
             s->regs.dst_offset = data & 0xfffffff0;
         break;
     case DST_PITCH:
-            s->regs.dst_pitch = data & 0x3fff;
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            s->regs.dst_pitch = data & 0x3fff;
             s->regs.dst_tile = (data >> 16) & 1;
+        } else {
+            s->regs.dst_pitch = data & 0x3ff0;
         }
         break;
     case DST_TILE:
@@ -942,9 +944,11 @@ static void ati_mm_write(void *opaque, hwaddr addr,
             s->regs.src_offset = data & 0xfffffff0;
         break;
     case SRC_PITCH:
-            s->regs.src_pitch = data & 0x3fff;
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            s->regs.src_pitch = data & 0x3fff;
             s->regs.src_tile = (data >> 16) & 1;
+        } else {
+            s->regs.src_pitch = data & 0x3ff0;
         }
         break;
     case DP_BRUSH_BKGD_CLR:
-- 
2.54.0


