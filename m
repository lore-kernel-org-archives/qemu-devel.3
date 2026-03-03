Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A742EEB365B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFnY-0007qg-2V; Mon, 02 Mar 2026 21:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnR-0007o1-7O
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:41 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnO-0002px-4Y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:40 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id AACA8EC055F;
 Mon,  2 Mar 2026 21:47:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 21:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772506057; x=
 1772592457; bh=iZFopa7BN2v/Wniu8RWnxAcgO5JG4vm8jdapubVGmHM=; b=R
 CgtTSbqhM2uTBOwV7IstjSmFbQ6F2DXvBYuRQQxywH0D1mIGmVfu9qnNQ0hQUdR6
 AGCZ6jixB0kwhYp2E8ACtiPuZCAWmJFkztL2fupq8ZByBDg+QpZeOuJ5rZlxESnN
 r7exvyLKQxeINSK6N1s6AOhY55oFjSrQtyj0Xux0MhEIYJQfFc/jshYcN+eyuOyx
 xWutrEmAAsEbouVlsCC1WnaR8oBPCJLsfsAb3lMT3rZRnkgwUCstU9mp3uOAIbKf
 P9dH99v/AGAUGyTmcN4pJ6GI1ALK6XSCcPvJrqEfPSGZnF/qVu8nLKMmcvqi2Lnn
 ayjqnnlXC7KWNRTexJmtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772506057; x=1772592457; bh=i
 ZFopa7BN2v/Wniu8RWnxAcgO5JG4vm8jdapubVGmHM=; b=Aj9ZKu7dP/lzARonV
 d6/S/zRnKEaNKPkhFkLPJbPpQU/Lx4k4Y+WHDBb3+qv5E7EBXmFZmHw5FeTP1Py9
 kKwM4arggPyKRFNoB4OxfRQJIJHtolxnTOyKG4CgF2kYNSj4cYabpT13yqQgmD3C
 uI87yEtD+/x/n9z3oZmiP+KZDl/XjApIRk2NOFs/ZZQDel0fLGFxxOuOarr4WXTr
 xcRjiiig/mT2Swlj7/Mt6iTq8/6QIRcSXFSiy6bu3U/KlSSWFKUHAl+38VusjcDa
 tfqL+MNo9/2+0IpgpCLiLvHfCuUfzjbLTMTkKxZAqNN0Cf+6lZ8DKplMfc+yVYHo
 wAgfw==
X-ME-Sender: <xms:yUumachMeRUqNXazpmrP5e9F8rnf1YUyWU0dshpgDBE8a7nOTRr6xA>
 <xme:yUumab5HLnMc-2b07MKUvRVQwdtua38bjzfSHvBsE-C5yQ7fZ6-uGyGi6vaq_dTsB
 X3qu-2Dd8_urgPWvu9xfyUAfl5hQbh5hI2QgjcByN9dfQRNBnuwQSMN>
X-ME-Received: <xmr:yUumacbSYynbxOBeJThJr07KzjL-AddJJuEtkb8c3qErpLLCW5QmGplBKaRL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtggrnh
 gurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdgu
 vghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiidprhgtphhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhmpdhrtghp
 thhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:yUumaY7MB9fF3YAixDXEaRq_pmlj5qQDx2f2sV24fkNa3919JXXWXA>
 <xmx:yUumaXBpF3xZYBKEL9efCgkPb390GV5bRTRQ849JtdoKLR1Sn_NS0A>
 <xmx:yUumaWfe7jVQjhcrVYwcEJ_O9Y6_MxMtWbn1SLGZ-uwJGiOFqO6YhA>
 <xmx:yUumaeKDskEBL-1y0hK-7KBMpR0UPyOHhSbVCGl_xm4S5eYbYYJXqQ>
 <xmx:yUumafW2kS8PYqCn1wjA_l3q3J3ha8ALaq1L4jF38nheTygdSUjLyAmv>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 21:47:37 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 233b9871;
 Tue, 3 Mar 2026 02:47:34 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v11 04/17] ati-vga: Latch src and dst pitch and offset on
 master_cntl default
Date: Mon,  2 Mar 2026 21:47:17 -0500
Message-ID: <20260303024730.1489136-5-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303024730.1489136-1-chad@jablonski.xyz>
References: <20260303024730.1489136-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=chad@jablonski.xyz;
 helo=fout-a1-smtp.messagingengine.com
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


