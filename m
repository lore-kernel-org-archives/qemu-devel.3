Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E003CEE327
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNyS-0006z0-AO; Tue, 18 Nov 2025 10:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwu-0004zx-6i
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:58 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwr-0001wX-LR
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:55 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A85107A01E6;
 Tue, 18 Nov 2025 10:48:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 18 Nov 2025 10:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1763480914; x=
 1763567314; bh=KPW1eE5VKiaV9U5BtLCLN5I12ig9ECccHWbCaBG8Hfk=; b=N
 jmqw3bRGKK1B3kpWJWpGmdaQ1xJOspXefOw9Hi8tEOCrylLiYwpnR52nb5IKeVw8
 HArX8mfh+THOI4931jO3D89bktTT3cGKmi1V6sNknKGn1Q7fix1eNxjaSyEAaxA3
 tqSOYtNbKgZ5XhlT20UMHF95WhuMOHdNWwhOUHYNVHrhUoTxPHwY5WCn60xt1gfA
 LccxBWnKlHhnjl49VFGTAgoXj42iVK00YZLk+dBf+QaDSNJgYHiANphtmbBhlHnA
 rOCj1M18gzO2LdIFR+tLF2rPQoXwFfah2Ts1XTyjd2tH6jPGrwepty5EzZPYaezp
 4AhftRbk8GrSib+N682qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1763480914; x=1763567314; bh=K
 PW1eE5VKiaV9U5BtLCLN5I12ig9ECccHWbCaBG8Hfk=; b=s0IcwyJ/gW+MlGIhH
 OGCIDIEknoGc2/FfoyIsKP/qgGjTMIKBEsWtvOnA6rNgxEKljWzGEKPnr4Zx8WwR
 MRQ9LwUDF5hY7vIprFBrOWxVXiaq2VqMwIde4IB+RPgvBab0vG0IfUihHA4pLm8D
 A0m0mBmth1tlWubpDYWcPbeg5Szdbr45Y/uP1jEfNMNErI6yWiqw537Rjd+siUEV
 rF5AbFoDU386rkNamlqso1FHyk/4AzjMdbadZtXoXD9cAKyfiWBmQMrVAwOE52Gq
 42Ojnooa4tH92F/ldVOr8xPTH90R6rjefBJlsXJBoVgvCK6W7S21kzLaAx4J2Z34
 QP02Q==
X-ME-Sender: <xms:UpUcaXwhzZQgDQWqSlTwH5nM2NU_rjaBJPodreR0YpoCm4vVzLuLwQ>
 <xme:UpUcaWuhjr_VkDRrpxMhP_EoBgyuKsxLsOz3Us05GcW5DrheDtab6kB0w03V4pRhc
 WyrJyhe5IOYxYfZibG17XM1GDnYZge2Gm78IHwXUj1007ZtcykktVI>
X-ME-Received: <xmr:UpUcaevk4oFaxSdadgOtycjCkx9Pj8AkpCtDaPL3umiYphwpTyVLkPeoD-8p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddujedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 gsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:UpUcabMdteKGhCanmChpgCkN_LauFO5Xo63DRMQam-ICJoeJvGEVyA>
 <xmx:UpUcac3yMUX9RfTQsL0pbcgMC6qciG1o5UZ5RXbEeqb7yiVt7RZ-vg>
 <xmx:UpUcaXMQ9vv4fqm9LCS9EzCfpJuEBzTUaKQ1y3kaz4lnya5l_634_A>
 <xmx:UpUcac1cY6zcwN2HmIxaryPn2z3b1_td3mvU1NlM9qAlOHwX1YQXXA>
 <xmx:UpUcaU6jVkRwCaWmbiZ-bFRN4-2bDAK6gf2CtaofNY1wcCGjfvo_bT0u>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 10:48:33 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8a0226a9;
 Tue, 18 Nov 2025 15:48:31 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 04/11] ati-vga: Latch src and dst pitch and offset on
 master_cntl default
Date: Tue, 18 Nov 2025 10:48:05 -0500
Message-ID: <20251118154812.57861-5-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118154812.57861-1-chad@jablonski.xyz>
References: <20251118154812.57861-1-chad@jablonski.xyz>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Hardware testing on the Rage 128 confirms that (SRC/DST)_OFFSET,
and (SRC/DST)_PITCH are latched when (SRC/DST)_PITCH_OFFSET_CNTL bits
in DP_GUI_MASTER_CNTL are set to "default".

The earlier approach looked at the state of the (SRC/DST)_PITCH_OFFSET_CNTL
bits when offset and pitch registers were used. This meant that when
(SRC/DST)_PITCH_OFFSET_CNTL was reset to "leave alone" the old values
stored in the registers would return. This is not how the real hardware
works.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      |  8 ++++++++
 hw/display/ati_2d.c   | 13 ++++---------
 hw/display/ati_regs.h | 10 ++++++++++
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index a2c0302e42..d0fa51f773 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -888,6 +888,14 @@ static void ati_mm_write(void *opaque, hwaddr addr,
                               (data & 0x4000) << 16;
         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
 
+        if ((data & GMC_SRC_PITCH_OFFSET_CNTL_MASK) == GMC_SRC_PITCH_OFFSET_DEFAULT) {
+            s->regs.src_offset = s->regs.default_offset;
+            s->regs.src_pitch = s->regs.default_pitch;
+        }
+        if ((data & GMC_DST_PITCH_OFFSET_CNTL_MASK) == GMC_DST_PITCH_OFFSET_DEFAULT) {
+            s->regs.dst_offset = s->regs.default_offset;
+            s->regs.dst_pitch = s->regs.default_pitch;
+        }
         if ((data & GMC_SRC_CLIPPING_MASK) == GMC_SRC_CLIP_DEFAULT) {
             s->regs.src_sc_right = s->regs.default_sc_right;
             s->regs.src_sc_bottom = s->regs.default_sc_bottom;
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
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 2b56b9fb66..02025eef36 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -402,6 +402,16 @@
 #define GMC_WRITE_MASK_SET                      0x40000000
 #define GMC_DP_CONVERSION_TEMP_6500             0x00000000
 
+/* DP_GUI_MASTER_CNTL DP_SRC_PITCH_OFFSET named constants */
+#define GMC_SRC_PITCH_OFFSET_CNTL_MASK          0x00000001
+#define GMC_SRC_PITCH_OFFSET_DEFAULT            0x00000000
+#define GMC_SRC_PITCH_OFFSET_LEAVE_ALONE        0x00000001
+
+/* DP_GUI_MASTER_CNTL DP_DST_PITCH_OFFSET named constants */
+#define GMC_DST_PITCH_OFFSET_CNTL_MASK          0x00000002
+#define GMC_DST_PITCH_OFFSET_DEFAULT            0x00000000
+#define GMC_DST_PITCH_OFFSET_LEAVE_ALONE        0x00000002
+
 /* DP_GUI_MASTER_CNTL DP_SRC_CLIPPING named constants */
 #define GMC_SRC_CLIPPING_MASK                   0x00000004
 #define GMC_SRC_CLIP_DEFAULT                    0x00000000
-- 
2.51.0


