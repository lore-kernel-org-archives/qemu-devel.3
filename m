Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70A4D4A5EB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 02:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgZoU-0005zs-3z; Thu, 15 Jan 2026 21:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZo2-0005qZ-7c
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:23 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZo0-0002SA-F1
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:21 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 455D81D00094;
 Thu, 15 Jan 2026 21:43:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 15 Jan 2026 21:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1768531393; x=
 1768617793; bh=6SW+LMri3vFEXJCJjGvFcKszWaLzdvchvSDF9eawbwE=; b=n
 N2a9bsqJA+8YXvRHW4/RA1FZDFY+3uqz+UT23Ed+IJa4gBeZLVhxCVrL88vNMs6v
 StjoEXrUZ+o/BFEqWHCPV4O7QLVlQhN+K8Y138F9+zyIqrmNhbvnznPcdmXnCH3I
 VFxenoFRFul0ffOmrrgyfwIoZ23o5l5kw4mGgE3yYnNz+ljE+qmpPcvA6qBiuPGu
 pAlmSbVIY+tBYKjaPVXSiaXHlSc5m1qoUODZn5vFATlHJep3fXdj9/41O0XAOUXr
 UKQAXPuEDKI7ZGmRPh5lD/1kRtUjWPgTueW0XYzjIJMxN356GytcLTbJZN1M66ru
 IfK0Jl89B8yc2zB5xeAww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1768531393; x=1768617793; bh=6
 SW+LMri3vFEXJCJjGvFcKszWaLzdvchvSDF9eawbwE=; b=mdzuat9qESGuEa0hy
 sldhWgXqfLBNYDUjm+wlWBnsXa+7khphHLRM5EzZ66gu3nXyfNni2QP0l1I1XsH9
 4Zk/DUuokh44KPFaRz/ABeagtf8jLEddcFG2V4JkDJ+kCgxtu1xbgVUnegRPpHk+
 njKgeBR1bipr8UpugExfWpZdK+QbqU0BWd1SXOEV9M5PMcN7szn3EKr33Q9uluKr
 tZPEgrp0eFc4T7Um6LP6KmCguiYOmQkzv98neSIcayze6rDxrzASNkG4FEhOWENM
 0e4Y92PfzrlfCwdyjfoRAATtc7RCDERPdIdH/6t95HrSjH2+XYg7mtnif4GfbNfE
 zLPeA==
X-ME-Sender: <xms:waVpaUJlig0y9tO8PPTyBvCqkuDv2tG5qVNXYpAVwzZvSqoj_37_Bw>
 <xme:waVpaXZxPOT7HzIdCb700ftac8DtjOxTBJBVal9ORd5LQs7k54nPZ4ysDBwoARBp6
 l2z5QA2TA8EUMJJfWdfoUjRj_enZEChs0aLM39I65W3eR5PaODP5u-u>
X-ME-Received: <xmr:waVpaeLWPlEvy3doDlCJPlpafT3COVvFD_0OZ1Jh1miKj70IOlORWW4UPnFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejjeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:waVpadAFioufv0AWXvZ4Xkub4g0Nm4cJharBntXaXUR3ZeG5hIf6zw>
 <xmx:waVpabraTjES0dIpc8_dTGdlgF3RIabGoBrHuCKMg6Z8FdAOA_QAoA>
 <xmx:waVpaQhHYTRqu02zYCBisrnNKhNdrRmQ9jqHwodtblHBVMEPVUonVQ>
 <xmx:waVpaQAvy4GdkoOMRDS9eqihZbZLrMbsIS5ynwf17Z6S0mqQgd6EIA>
 <xmx:waVpabtB2osu8-HTw3ddIgdZOsL0XnLLUeiGo5xtk9nNXdIwtY_Tt-hi>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 21:43:12 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id bf9e8395;
 Fri, 16 Jan 2026 02:43:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v5 09/12] ati-vga: Add internal ati_2d_do_blt accepting src
 and dst
Date: Thu, 15 Jan 2026 21:42:55 -0500
Message-ID: <20260116024258.1487173-10-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260116024258.1487173-1-chad@jablonski.xyz>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.151; envelope-from=chad@jablonski.xyz;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Separate the implementation of the blit and the src and dst setup.
This maintains the public interface of ati_2d_blt while allowing for
flexibility in how the blit is performed.

The ati_2d_blt function becomes the function that sets up the src and
dst for a VRAM blit and then calls ati_2d_do_blt. A later patch will set
up the src and dst for a HOST_DATA blit before calling ati_2d_do_blt.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 59 +++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 38390f2da8..691e0f0702 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -80,38 +80,19 @@ static void setup_2d_blt_dst(const ATIVGAState *s, ATIBltDst *dst)
     }
 }
 
-void ati_2d_blt(ATIVGAState *s)
+static void ati_2d_do_blt(ATIVGAState *s, const ATIBltSrc *src, ATIBltDst *dst)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
     DisplaySurface *ds = qemu_console_surface(s->vga.con);
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
     int dst_stride_words, src_stride_words;
-    ATIBltDst _dst; /* TEMP: avoid churn in future patches */
-    ATIBltDst *dst = &_dst;
-    ATIBltSrc _src; /* TEMP: avoid churn in future patches */
-    ATIBltSrc *src = &_src;
 
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
 
-    setup_2d_blt_dst(s, dst);
-
-    src->x = (dst->left_to_right ?
-             s->regs.src_x :
-             s->regs.src_x + 1 - dst->rect.width);
-    src->y = (dst->top_to_bottom ?
-             s->regs.src_y :
-             s->regs.src_y + 1 - dst->rect.height);
-    src->stride = s->regs.src_pitch;
-    src->bits = s->vga.vram_ptr + s->regs.src_offset;
-    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        src->bits += s->regs.crtc_offset & 0x07ffffff;
-        src->stride *= dst->bpp;
-    }
-
     if (!dst->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
@@ -147,12 +128,6 @@ void ati_2d_blt(ATIVGAState *s)
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return;
         }
-        if (src->x > 0x3fff || src->y > 0x3fff || src->bits >= end
-            || src->bits + src->x
-             + (src->y + dst->rect.height) * src->stride >= end) {
-            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-            return;
-        }
 
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
                 src->bits, dst->bits,
@@ -274,3 +249,35 @@ void ati_2d_blt(ATIVGAState *s)
                                 dst->rect.height * surface_stride(ds));
     }
 }
+
+void ati_2d_blt(ATIVGAState *s)
+{
+    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
+    ATIBltDst dst;
+    ATIBltSrc src;
+
+    setup_2d_blt_dst(s, &dst);
+
+    /* Setup src to point at VRAM */
+    src.x = (dst.left_to_right ?
+             s->regs.src_x :
+             s->regs.src_x + 1 - dst.rect.width);
+    src.y = (dst.top_to_bottom ?
+             s->regs.src_y :
+             s->regs.src_y + 1 - dst.rect.height);
+    src.stride = s->regs.src_pitch;
+    src.bits = s->vga.vram_ptr + s->regs.src_offset;
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        src.bits += s->regs.crtc_offset & 0x07ffffff;
+        src.stride *= dst.bpp;
+    }
+
+    if (src.x > 0x3fff || src.y > 0x3fff || src.bits >= end
+        || src.bits + src.x
+         + (src.y + dst.rect.height) * src.stride >= end) {
+        qemu_log_mask(LOG_UNIMP, "blt src outside vram not implemented\n");
+        return;
+    }
+
+    ati_2d_do_blt(s, &src, &dst);
+}
-- 
2.51.2


