Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDADCEFCF1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdCFA-0004Ky-Rd; Tue, 06 Jan 2026 13:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCF3-0004Gn-6W
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:17 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCEz-0001x8-DH
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:16 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 933AD1D00116;
 Tue,  6 Jan 2026 13:57:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 06 Jan 2026 13:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767725831; x=
 1767812231; bh=BxaJkYhgh207OArWtNndNKgUsnlIvaf++xg1KFPjljQ=; b=o
 Elo7uLfdfEzxdDJf8kz0EGUb6uzZ+RVxUi8DbDY708Nc5GnwC6sIC68v3DQn0rl7
 0eYysX+l640UT+mcFuOhQOTUrqT2O6NA2VfPcuIV1wNqlCh09qTpmy//th0OsRVW
 WS7JtCij//MbqA/Frj61igunYtNi22NdXKDTohsgSJ/hE/OjmF5X0lL2DXXQX+67
 RzdcBEzlUqUyo7AW8UnZE5J9h/xzwyolRwzCMSQnbojGSWVp54fDBWzrPqF+BIOC
 PwqNhiGavTUMo0FGuCfIjf/JOL3inYHk2Uukp/kfluZSQn4R7XhR52mcG8OOFmzy
 vgy1DHkP4UiJ1/uphixTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767725831; x=1767812231; bh=B
 xaJkYhgh207OArWtNndNKgUsnlIvaf++xg1KFPjljQ=; b=Dkbwi8auiCcKl+Aj4
 77IBy9AN07N2vw/U4CNkST+96kGxRjXK4cIHcMnTgYLGFn28Ni/SFf/LHvtKTpeM
 zTx08LfNt68fsuk64sDV6mstpTEHX66cmb+kadM2ypHiuNewKYya4Uu8kcUjA+QJ
 CwXL8j2vB5cEX8sMsrQEAm7OneRwo8/D+caV7Fnkgb9lrSAMxZIROJf1oPbKovtg
 oXw4Hbga5USnGcNag60xmN7wcRqwLd7mSNhuyGw9C9ZQ27ydVB8BUoC3hGzyEKEN
 YsRCdzkKc8Ip85QP9zgdWI55EojlBgeJEKPj/vd6OOFYIrCx1sGJ0bwFXjK+K9Y3
 1EqwA==
X-ME-Sender: <xms:B1tdaUU4aDiDkIrNhZIYC4LoP0cKv6nhuD5tq7E1uLnE3SaATG5z0g>
 <xme:B1tdaQDrWw4vjXkTbsnUDjxfmZ31Oe2Zt_qdLsaCzELEf2hOAE75z7UPdbQ1B5NeC
 U83UFYLQocKMOowP6Tbo0lt-LR7ZAVj4UcNZphfDY3hI3neCbevBR0>
X-ME-Received: <xmr:B1tdaVwXw4rulYSB_hDEkTrHnzZSb83vl1AyEGKCRePY2kqGhoI0isZc39ge>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtleejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:B1tdadAdqJXzszu9idrHdzggMuB6wKxNuQizAymu-6UoAojlk7kFHg>
 <xmx:B1tdaSYNfwmwoB6dbhKKd6skkB-u4O0tjmuPCoMPn0F8x1wZqHyS1g>
 <xmx:B1tdaVg-gk6gmePgVCDtQ01rkmTfXsJfQtt8PUFVbaVZsYmKCjEyGw>
 <xmx:B1tdaU6laqgArfz8KcTV3yCWrzy9xBtFfHyIknNUrui-NrfD0CYrqQ>
 <xmx:B1tdabtiLv0mo5PtRm5ikMEM30uPX1Nh2vBt4EEqYMV7Ah1sKqhQnjBl>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 13:57:11 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 9812ccb6;
 Tue, 6 Jan 2026 18:57:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v4 5/9] ati-vga: Latch src and dst pitch and offset on
 master_cntl default
Date: Tue,  6 Jan 2026 13:56:56 -0500
Message-ID: <20260106185700.2102742-6-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260106185700.2102742-1-chad@jablonski.xyz>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=chad@jablonski.xyz;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
 hw/display/ati.c    |  8 ++++++++
 hw/display/ati_2d.c | 13 ++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 9a2c1260f7..04f1c3c790 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -907,6 +907,14 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dp_rop3 = (data & GMC_ROP3_MASK) >> 16;
         s->regs.dp_src_source = (data & GMC_SRC_SOURCE_MASK) >> 24;
 
+        if (!(data & GMC_SRC_PITCH_OFFSET_CNTL)) {
+            s->regs.src_offset = s->regs.default_offset;
+            s->regs.src_pitch = s->regs.default_pitch;
+        }
+        if (!(data & GMC_DST_PITCH_OFFSET_CNTL)) {
+            s->regs.dst_offset = s->regs.default_offset;
+            s->regs.dst_pitch = s->regs.default_pitch;
+        }
         if (!(data & GMC_SRC_CLIPPING)) {
             s->regs.src_sc_right = s->regs.default_sc_right;
             s->regs.src_sc_bottom = s->regs.default_sc_bottom;
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 0531d1a526..b8df549474 100644
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
2.51.2


