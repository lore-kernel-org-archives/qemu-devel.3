Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C7BCEE327
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNx5-0005Ab-SB; Tue, 18 Nov 2025 10:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwr-0004xL-Sn
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:57 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwk-0001ww-N3
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:50 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 50B3C1D00241;
 Tue, 18 Nov 2025 10:48:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 18 Nov 2025 10:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1763480917; x=
 1763567317; bh=2NcigUb2gaGAkcsjF1IsuMuW4EDf36gYH/Kep9bf/6E=; b=X
 r/AEWBG7KZh0NB/6UH4cyBGJhQdpv+xKjcLNjd4oxKen+8ZFgQGRmp+UdsdhxlQc
 uA3GWhf3NmJ9i0Wy58d68Fu8TYzFiqfVTKq4gVPcVk+SPkyLxNQllwKb8h3Kz+nt
 d+TM4CulY0y9KKcC68P0imNL3dLMIeXCWj/TKtpoOmiDABoRWfS32CzszhKbY1v+
 HcYrE+x1p3e6wnsxNVb52tPVg2jzDJvPifgCBgN2by96MxDX45wLpo/LmEKzk7d+
 JtGSasxRdkKDU2hQ8J1Z9lrN94saOMy0XTkhYMhWNgd/XpnRQdP4WxdwPVBPzgHs
 fygZmph11RIBLU1LuYnUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1763480917; x=1763567317; bh=2
 NcigUb2gaGAkcsjF1IsuMuW4EDf36gYH/Kep9bf/6E=; b=Oxc/LqzugVFNEuFQj
 RWlkYMd7T42QSnQqx6vnnbfQuQYYCG4ZsiM8ZDB+SP0YbdlIQD8lIYVHLIb0VQ4b
 KRGNI+bo1m2t3fMqmcgVFHK0zH7Co70ZwI6xnyr8ET+aTOa6yYHXahfNjuk6Nj87
 m6diBsnV2yt3xCioQY92dIZkM19Yy9bexgzCjkWJdlZkjyM6uCPLiuPSKGrnNMan
 6lcE7nXwK1aAxJCiHlHiWsgfveQRNCKW5VZ/FKY05YdrYb2lkgh/z6NS/RUVC5NE
 7TzXFKqh2669lydqz+olpwpzNas3ZD2z4MFdAmWk9H31aUQNe6/DrwlfmRv3crbz
 Cd74A==
X-ME-Sender: <xms:VJUcaecJLaqXL9WvWqPqDZqiAUfMAWBIS6oi26FX_UD-e6GG_EogLQ>
 <xme:VJUcafq42BDbSi-NLg1gdt9ej3eoKp_Pko9eSMGQdhMCpV9bA0ky3rwueYAnedd5r
 CLnKlqIdalRc_PWF468ULltYeWPmDweC6uR9dYeA8Lp9HVLcvB8DaO6>
X-ME-Received: <xmr:VJUcac5mbWn1LBAPsnYV6aUFJ5apkcuUzydXufUVsOLK7RZISiX6PwhO6Ce7>
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
X-ME-Proxy: <xmx:VJUcaVpdpIDkx6g10XWGvDQn3HAjlGbubhKNbvLLtseL4MDSqWxWlA>
 <xmx:VJUcaegWNPdzDrYcFkmK26AEgqjRpipzDYOMAAqv_fIB4B4r_rEUFA>
 <xmx:VJUcafKxM2bVyHa7w6ZHINcDKIVqzuve118rTx-dk_VdbuNsQPUOYg>
 <xmx:VJUcaeA5zUoXBS4-Ec5gD24Fai-KG3FVOniUX7mZs5LxQFMNyCnRTA>
 <xmx:VZUcaeUt72R5i0AN8uLWDu0Cfg0jwBIBH5rQPBe2IM4P9nq1U5FwAmgc>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 10:48:36 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 4fe276b5;
 Tue, 18 Nov 2025 15:48:31 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 08/11] ati-vga: Create 2d_blt destination setup helper
Date: Tue, 18 Nov 2025 10:48:09 -0500
Message-ID: <20251118154812.57861-9-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118154812.57861-1-chad@jablonski.xyz>
References: <20251118154812.57861-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=chad@jablonski.xyz;
 helo=fout-b2-smtp.messagingengine.com
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

A large amount of the common setup involved in a blit deals with the
destination. This moves that setup to a helper function returning a
struct (ATIBlitDest) holding all of that state. The idea here is that
this setup will be shared between blits from memory as well as from
HOST_DATA and maybe others in the future.

The next patch refactors ati_2d_blt to use this new helper.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 9c96ee155f..f2e01e28e9 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -67,6 +67,60 @@ static QemuRect sc_rect(ATIVGAState *s)
     return sc;
 }
 
+typedef struct {
+    QemuRect rect;
+    QemuRect visible;
+    uint32_t src_left_offset;
+    uint32_t src_top_offset;
+    int bpp;
+    int stride;
+    bool top_to_bottom;
+    bool left_to_right;
+    bool valid;
+    uint8_t *bits;
+} ATIBlitDest;
+
+static ATIBlitDest setup_2d_blt_dst(ATIVGAState *s)
+{
+    ATIBlitDest dst = { .valid = false };
+    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
+    QemuRect scissor = sc_rect(s);
+
+    dst.rect = dst_rect(s);
+    if (!qemu_rect_intersect(&dst.rect, &scissor, &dst.visible)) {
+        /* Destination is completely clipped, nothing to draw */
+        return dst;
+    }
+    dst.bpp = ati_bpp_from_datatype(s);
+    if (!dst.bpp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
+        return dst;
+    }
+    dst.stride = s->regs.dst_pitch;
+    if (!dst.stride) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
+        return dst;
+    }
+    dst.bits = s->vga.vram_ptr + s->regs.dst_offset;
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        dst.bits += s->regs.crtc_offset & 0x07ffffff;
+        dst.stride *= dst.bpp;
+    }
+    if (dst.visible.x > 0x3fff || dst.visible.y > 0x3fff || dst.bits >= end
+        || dst.bits + dst.visible.x
+         + (dst.visible.y + dst.visible.height) * dst.stride >= end) {
+        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+        return dst;
+    }
+    dst.src_left_offset = dst.visible.x - dst.rect.x;
+    dst.src_top_offset = dst.visible.y - dst.rect.y;
+    dst.left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
+    dst.top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
+    dst.valid = true;
+
+    return dst;
+}
+
 void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
-- 
2.51.0


