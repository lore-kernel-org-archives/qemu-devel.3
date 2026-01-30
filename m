Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B357BE6BF17
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppM-0004hJ-5M; Fri, 30 Jan 2026 09:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppL-0004gQ-1Q
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:27 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppH-00036b-Hx
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:26 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C3D9C7A0136;
 Fri, 30 Jan 2026 09:50:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 30 Jan 2026 09:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784622; x=
 1769871022; bh=iZFopa7BN2v/Wniu8RWnxAcgO5JG4vm8jdapubVGmHM=; b=m
 kxkU/8/P5NDkTcmPYzF4FfqzvHUABdeHqbtWalqUG5ryDwEsRxEKoR9pJ+VFBRMW
 Gaq3VjoIeaILroP86LTIxmdPI0NOxBNUwtQGqCdMFCDT6UU3FKnHWeD4Nfr2Dc2D
 NzJ/5mlb3SRpQ/O1fwT6rf7mcPOF63DCKPozqgZsYhRmnr2iMowNB5DcqDWvA9YL
 vPffdFdQ7q1r/pbH1UysVpC8VuGwBwu0WOb/VrlHcdq0A15dYGlgAY+vGsjQMEcF
 XonwGAS13GS8BkLcPTOcG/gWFklIl/JUrJxA4LfgdIGXKMnH4PKzEZSa5ZPF65ij
 SCM9qo4+9+fLeCbxIQ4uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784622; x=1769871022; bh=i
 ZFopa7BN2v/Wniu8RWnxAcgO5JG4vm8jdapubVGmHM=; b=vtIHAUkD3KcdLYF4r
 621K/R0a4tTW4i00d0T7Jvpy/J04dAiIswb5cf3TtqsSlz0GIrRA5RlI310Ayni9
 vNbwna5j+JRlIWuvcnlN5sQo2WSfMHsfR0mfy2e6p+3MUY/EQzwkeJP06H6vxuIE
 GcUQbyUGB5X+Pjc8BGU2Hlz8j/vMuXP0QtQSeit+7QVxBIf0iKpM/rHeERH1+9dZ
 1Zc1CUmceoXSFxHtg9vhqsQZcuUDl217kVo284FiZbuzFuEFtlQB3SNU5UXxOmJb
 13viJmH7QoV6CY03Jb9Xzv5nXcF2k4RO31sks7nVcaLWlanCDfDwz+3wXiayofH0
 JSUjQ==
X-ME-Sender: <xms:LsV8aSyR_WdUtJFfn5OghgUm9A99WdB55ajiekhI4BnPulo8FmJsfA>
 <xme:LsV8aVtPxsWll5z3zVPJlWrP8JxOQtk949iDB83ucenA45ewBmhgMzAcLRJ0XKbU-
 WpoLx-3jOaf2XvnV-HEb1jhUOyrUiCw-ls4qvOw9XHZHqNNjCikBw8>
X-ME-Received: <xmr:LsV8aRuUHadenLfY1yhCmZl9ryJs9qhq3LZYN0IeTjrRnm9AloZa8oLYwAa8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:LsV8aSPVVpb06eRYouBDh9b1UO7W5tlsvijgjjF99ef-aGZnkgE_ig>
 <xmx:LsV8aX2tG0dD3SvN5tidbTw94xstHh6XSzhEB7p0a82TPR1bbe-bWQ>
 <xmx:LsV8aWOtdISRLEL-PQFh91-7fY5eBa-lAj7BVWyEruMclnNlTPo0Sw>
 <xmx:LsV8af3Oi1iLYODSnjpEjqZ3lgew8CBopD_qQAdiE_K8ezkG9DUxIQ>
 <xmx:LsV8ab5Z1rzBj1eGxmoG5tiNgAug-_QeZSRj0yq-uDzDxLkaIw2hRlpY>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:22 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 51a71665;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 04/20] ati-vga: Latch src and dst pitch and offset on
 master_cntl default
Date: Fri, 30 Jan 2026 09:49:49 -0500
Message-ID: <20260130145005.731129-5-chad@jablonski.xyz>
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


