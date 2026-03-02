Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4968BEB3622
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7dy-0006Ny-Rt; Mon, 02 Mar 2026 13:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7df-0006Cc-L3
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:04 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dd-0006Le-A4
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:03 -0500
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CFB6A140020B;
 Mon,  2 Mar 2026 13:05:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Mon, 02 Mar 2026 13:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772474700; x=
 1772561100; bh=iZFopa7BN2v/Wniu8RWnxAcgO5JG4vm8jdapubVGmHM=; b=I
 01XVaxcev2iWd0hEDPZjTMg8bb0IbNZ6+KqLJWWDBfBFM1s5v978tDmMfnO5fodi
 fecBFOno/TKXZl24cEUtCwAZs+ZZvpRslF4XWG7Rri/RXkwdWdqFHwiyWjALMI/O
 J+I0JZ6Vj0Ieajb884ijvUy/piEep39biA2WUo99XEVD6JxyaJ6GpkPP4vH5YDOi
 yrrcGrd6r6zyNC5cZ113QSU9mEBtuGG6OumFwSpiny8qxG5KHTh45yR15VtQgE6N
 JXQHmKygNNxgNjs9/DNsUfnQaOIG0c4ISzINvIF21d6asovzQLzCvsNO4VEi4Xxn
 0c4jxHue3998Cj+uoY7Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772474700; x=1772561100; bh=i
 ZFopa7BN2v/Wniu8RWnxAcgO5JG4vm8jdapubVGmHM=; b=Id6YFM2XTUfysTI3N
 ZhvOGRSclrjE0ClvQodtZRNoaMM30DDqI6cDcliwrXnNXQOk7dOLUCFtm/7AXcBE
 iIVZ+ILRNvcw99uNHUqTIWLFGtAphHisweXVG3V7vQYsqyVeyjTWYwVJRFDePK1A
 Bg6jhX+QZQAkIUv53eGo9m5G36jZD2iIPaR6NekQLat1gKdVvqCzeoF3Yeaa/yT/
 a1ZtyjbobdOBevxAkYu5mr7nyERroIIqVbxdl2TaXSI9rIBti8Do2DXGcdtz04RH
 jp1LR52WG1ZJQWpzCe9w0k/zIU+etnHQpWJFMrXi/tWdABuhkas9N8lmDTHgzHz5
 wXY3Q==
X-ME-Sender: <xms:TNGlaaVfJpEbuKfMhTp0VIgROXvChPP2HBZtagsr-GafosRNHvqUiQ>
 <xme:TNGladfdjaQ96Mtci_HmDdCJV9FMjrFqPuq5n3PdibmfsGDfKKV2e7exNYF_YsncL
 csFAmDAqGez-SegMHnQ3dM2jzj24fJ7LAN2AIb2AlhmEw2jkJ9D_w>
X-ME-Received: <xmr:TNGlaWsx_RxHbsmpu_9mkGUvqsWVumXOIf4Ch92sofdYotoUx3LC3ATg4q9D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheptghhrggusehjrggslhhonhhs
 khhirdighiiipdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhh
 grthdrtghomhdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgt
 phhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:TNGlac9WebDhL0acy9kgh_l4lJgBeINxSKGTMBJicjgcSWs1oDa8Rg>
 <xmx:TNGlaR2tkeW7a8SVCPzLxDlaGjR91-k1H4GYLBh0ltPISaKCBNBSTQ>
 <xmx:TNGlaRAdR2FsjoT0SG7yXWkrnXwvOoQFuNVut5Aerl3xeC1IAPfgEw>
 <xmx:TNGladcHXVCYWGfaUd76hQRRgggoDYPm0frvhOtORMyueNDNCMCGvg>
 <xmx:TNGlaQYRsxBtc1GKj2Bq2khk1Qd_V22bjt5nUlU35lvfIQuH2ZqSE_g5>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:05:00 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 0987ea31;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 04/17] ati-vga: Latch src and dst pitch and offset on
 master_cntl default
Date: Mon,  2 Mar 2026 13:04:34 -0500
Message-ID: <20260302180447.1078098-5-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302180447.1078098-1-chad@jablonski.xyz>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.152; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

Hardware testing on the Rage 128 confirms that (SRC/DST)_OFFSET,
and (SRC/DST)_PITCH are latched when (SRC/DST)_PITCH_OFFSET_CNTL bits
in DP_GUI_MASTER_CNTL are set to "default".

The earlier approach looked at the state of the (SRC/DST)_PITCH_OFFSET_CNTL
bits when offset and pitch registers were used. This meant that when
(SRC/DST)_PITCH_OFFSET_CNTL was reset to "leave alone" the old values
stored in the registers would return. This is not how the real hardware
works.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c    |  9 +++++++++
 hw/display/ati_2d.c | 13 ++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 028efd13e1..ce23e5e48b 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -868,6 +868,15 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
                               (data & 0x4000) << 16;
         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
+
+        if (!(data & GMC_SRC_PITCH_OFFSET_CNTL)) {
+            s->regs.src_offset = s->regs.default_offset;
+            s->regs.src_pitch = s->regs.default_pitch;
+        }
+        if (!(data & GMC_DST_PITCH_OFFSET_CNTL)) {
+            s->regs.dst_offset = s->regs.default_offset;
+            s->regs.dst_pitch = s->regs.default_pitch;
+        }
         break;
     case DST_WIDTH_X:
         s->regs.dst_x = data & 0x3fff;
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 309bb5ccb6..a8c4c534b9 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -43,8 +43,6 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
-#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)
-
 void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
@@ -63,13 +61,12 @@ void ati_2d_blt(ATIVGAState *s)
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
     }
-    int dst_stride = DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_pitch;
+    int dst_stride = s->regs.dst_pitch;
     if (!dst_stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    uint8_t *dst_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
-                        s->regs.dst_offset : s->regs.default_offset);
+    uint8_t *dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
 
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
         dst_bits += s->regs.crtc_offset & 0x07ffffff;
@@ -97,14 +94,12 @@ void ati_2d_blt(ATIVGAState *s)
                        s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
         unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
                        s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
-        int src_stride = DEFAULT_CNTL ?
-                         s->regs.src_pitch : s->regs.default_pitch;
+        int src_stride = s->regs.src_pitch;
         if (!src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return;
         }
-        uint8_t *src_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
-                            s->regs.src_offset : s->regs.default_offset);
+        uint8_t *src_bits = s->vga.vram_ptr + s->regs.src_offset;
 
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             src_bits += s->regs.crtc_offset & 0x07ffffff;
-- 
2.52.0


