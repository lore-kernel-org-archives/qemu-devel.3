Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6572DCEFCF2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdCFU-0004ab-IT; Tue, 06 Jan 2026 13:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCF3-0004H5-BE
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:19 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCEz-0001xJ-Dx
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:17 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 411857A0123;
 Tue,  6 Jan 2026 13:57:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 13:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767725832; x=
 1767812232; bh=SxYnyBmRVWJiTfU+u62Vs8IuJAuNMF49dJtVKLMkVWA=; b=s
 7xniIeoVx53EMHCn1oviekXB7GVQBLXZaliSD0L8ZBq0DLA1Bc0ny/S7J0+osh3c
 v049UkpEitTk9HeDKw1nXXYv9Hz6udpzJaIk5x5LajhXH6qrigp61C3grcCG3roI
 epylppDWeWH/NO8xvZAPgVApLEfmlt+HO2kn4tUG1m5oozHTDfNSYlaQAVbzhJ3B
 ZO9HF9LuGZhnAM/GmFRMDIX74CRafhKiUq8P3vqUTU1l7j2uvJ1+maKadhC6pST2
 EIjeUZkgQxp0rTnYjvQAv0oNYepP5UXZLKKWlmM0+t2meD06qy+Sf7Wt9rblcwXV
 CDyfuRx0yL8AMnmjFe2cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767725832; x=1767812232; bh=S
 xYnyBmRVWJiTfU+u62Vs8IuJAuNMF49dJtVKLMkVWA=; b=Dejmjn9VbVxWkuicX
 /wcW7dgkp9sGxw0rcd0NtOdyvEBhiiFCsp4/1/6nclu4+g+Gpy7gr21lhNZ1coKx
 j2exBBiW9ewumV5GsVBZyUWgvVpXk4Cxxnf3sK68wlaZtI48wUXztQs0I7At9Uzp
 2MIAnliHuxDJ/AdK9dENyXxjdFocdTD7hEfMm2BCNCv6z1A6Yp+I1GqV6u8Sp7EE
 RRxC0gGkmFF9oPZ/ZE82yqEpnLC4fODp6jSjwqbSS3cuWB4gVIINMUJ1gyK0u4Xl
 sK2eibpU8naYWPIT0+z7cFCxHPT9YZwbBJONOGhAUkbT0JOJ5thJacTSmjAiNCxJ
 psnnA==
X-ME-Sender: <xms:CFtdaa83Q7gpUZjQAPQ6VARhCkLnZ9IwFCFaJD1KyiYrNMs5KRM35Q>
 <xme:CFtdaSLny6GRnLnnl2b119TGidc-hYIIlGXYD12oHR8B09IaCQcFaTMhqsn9ASu5X
 9oh-qffLwTq3TqZ7Epn1ScbScJ81owHuE6AKr_jh9PN7SywHVQxvaA>
X-ME-Received: <xmr:CFtdadb9T9nXdFhCu-f0yzzmfBESRluYWvZum5CFoLfTq5bWBMZomxb8Ajyu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtleeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:CFtdacLbL-N3LxjVYpAxMdW1QDx033c40fz1GBavyGyI09J_OaaqDg>
 <xmx:CFtdaTBZCvj88k4K9O9Aa2ZYN5ryZ3hhkPIAwwl8q9s0gLBgrU-v9w>
 <xmx:CFtdaZqaWstzntBuwy4Shh6m_IsNe-vN1NWoV0AhdaiYjRHXs38Mxw>
 <xmx:CFtdaWg5RXwIP9t2_2F38FG3dWz9m5-_SBZdsCK-oEQeMIkiCEpCQg>
 <xmx:CFtdac2-g24TJ2D2rf9IQBXawYFrm6yas2qidMFgOQuYNsTmhfA3vmAC>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 13:57:11 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 38f3e12a;
 Tue, 6 Jan 2026 18:57:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v4 7/9] ati-vga: Create 2d_blt destination setup helper
Date: Tue,  6 Jan 2026 13:56:58 -0500
Message-ID: <20260106185700.2102742-8-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260106185700.2102742-1-chad@jablonski.xyz>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.157; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b6-smtp.messagingengine.com
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

A large amount of the common setup involved in a blit deals with the
destination. This moves that setup to a helper function returning a
struct (ATIBlitDest) holding all of that state. The idea here is that
this setup will be shared between blits from memory as well as from
HOST_DATA and maybe others in the future.

Otherwise this is a pure refactor of the ati_2d_blt function to make use
of the setup_2d_blt_dst helper and the struct it returns. There should be no
changes in behavior in this patch.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 218 +++++++++++++++++++++++++-------------------
 1 file changed, 124 insertions(+), 94 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 145eb487c4..6c36e55412 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -57,68 +57,96 @@ static QemuRect dst_rect(ATIVGAState *s)
     return dst;
 }
 
-void ati_2d_blt(ATIVGAState *s)
-{
-    /* FIXME it is probably more complex than this and may need to be */
-    /* rewritten but for now as a start just to get some output: */
-    DisplaySurface *ds = qemu_console_surface(s->vga.con);
-    DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
-            s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
-            surface_bits_per_pixel(ds),
-            s->regs.dp_rop3);
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
 
-    QemuRect dst = dst_rect(s);
+static ATIBlitDest setup_2d_blt_dst(ATIVGAState *s)
+{
+    ATIBlitDest dst = { .valid = false };
+    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
     QemuRect scissor;
     qemu_rect_init(&scissor,
                    s->regs.sc_left, s->regs.sc_top,
                    s->regs.sc_right - s->regs.sc_left + 1,
                    s->regs.sc_bottom - s->regs.sc_top + 1);
-    QemuRect visible;
-    if (!qemu_rect_intersect(&dst, &scissor, &visible)) {
-        return;
-    }
-    uint32_t src_left_offset = visible.x - dst.x;
-    uint32_t src_top_offset = visible.y - dst.y;
 
-    int bpp = ati_bpp_from_datatype(s);
-    if (!bpp) {
+    dst.rect = dst_rect(s);
+    if (!qemu_rect_intersect(&dst.rect, &scissor, &dst.visible)) {
+        /* Destination is completely clipped, nothing to draw */
+        return dst;
+    }
+    dst.bpp = ati_bpp_from_datatype(s);
+    if (!dst.bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
-        return;
+        return dst;
     }
-    int dst_stride = s->regs.dst_pitch;
-    if (!dst_stride) {
+    dst.stride = s->regs.dst_pitch;
+    if (!dst.stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
-        return;
+        return dst;
     }
-    uint8_t *dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
-
+    dst.bits = s->vga.vram_ptr + s->regs.dst_offset;
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        dst_bits += s->regs.crtc_offset & 0x07ffffff;
-        dst_stride *= bpp;
+        dst.bits += s->regs.crtc_offset & 0x07ffffff;
+        dst.stride *= dst.bpp;
     }
-    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
-    if (visible.x > 0x3fff || visible.y > 0x3fff || dst_bits >= end
-        || dst_bits + visible.x
-         + (visible.y + visible.height) * dst_stride >= end) {
+    if (dst.visible.x > 0x3fff || dst.visible.y > 0x3fff || dst.bits >= end
+        || dst.bits + dst.visible.x
+         + (dst.visible.y + dst.visible.height) * dst.stride >= end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-        return;
+        return dst;
     }
+    dst.src_left_offset = dst.visible.x - dst.rect.x;
+    dst.src_top_offset = dst.visible.y - dst.rect.y;
+    dst.left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
+    dst.top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
+    dst.valid = true;
+
+    return dst;
+}
+
+void ati_2d_blt(ATIVGAState *s)
+{
+    /* FIXME it is probably more complex than this and may need to be */
+    /* rewritten but for now as a start just to get some output: */
+    DisplaySurface *ds = qemu_console_surface(s->vga.con);
+    DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
+            s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
+            surface_bits_per_pixel(ds),
+            s->regs.dp_rop3);
+    ATIBlitDest dst = setup_2d_blt_dst(s);
+    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
+
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
             s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
-            s->regs.src_x, s->regs.src_y, dst.x, dst.y, dst.width, dst.height,
-            (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
-            (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
+            s->regs.src_x, s->regs.src_y,
+            dst.rect.x, dst.rect.y, dst.rect.width, dst.rect.height,
+            (dst.left_to_right ? '>' : '<'),
+            (dst.top_to_bottom ? 'v' : '^'));
+
     switch (s->regs.dp_rop3) {
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
-        unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                         s->regs.src_x + src_left_offset :
-                         s->regs.src_x + 1 - dst.width + src_left_offset);
-        unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         s->regs.src_y + src_top_offset :
-                         s->regs.src_y + 1 - dst.height + src_top_offset);
+        unsigned src_x = (dst.left_to_right ?
+                         s->regs.src_x + dst.src_left_offset :
+                         s->regs.src_x + 1 -
+                         dst.rect.width + dst.src_left_offset);
+        unsigned src_y = (dst.top_to_bottom ?
+                         s->regs.src_y + dst.src_top_offset :
+                         s->regs.src_y + 1 -
+                         dst.rect.height + dst.src_top_offset);
         int src_stride = s->regs.src_pitch;
         if (!src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
@@ -128,44 +156,44 @@ void ati_2d_blt(ATIVGAState *s)
 
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             src_bits += s->regs.crtc_offset & 0x07ffffff;
-            src_stride *= bpp;
+            src_stride *= dst.bpp;
         }
         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
             || src_bits + src_x
-             + (src_y + visible.height) * src_stride >= end) {
+             + (src_y + dst.visible.height) * src_stride >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
 
         src_stride /= sizeof(uint32_t);
-        dst_stride /= sizeof(uint32_t);
+        dst.stride /= sizeof(uint32_t);
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
-                src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
-                src_x, src_y, visible.x, visible.y,
-                visible.width, visible.height);
+                src_bits, dst.bits, src_stride, dst.stride, dst.bpp, dst.bpp,
+                src_x, src_y, dst.visible.x, dst.visible.y,
+                dst.visible.width, dst.visible.height);
 #ifdef CONFIG_PIXMAN
         if ((s->use_pixman & BIT(1)) &&
-            s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
-            s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
-            fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
-                                   src_stride, dst_stride, bpp, bpp,
-                                   src_x, src_y, visible.x, visible.y,
-                                   visible.width, visible.height);
+            dst.left_to_right &&
+            dst.top_to_bottom) {
+            fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst.bits,
+                                   src_stride, dst.stride, dst.bpp, dst.bpp,
+                                   src_x, src_y, dst.visible.x, dst.visible.y,
+                                   dst.visible.width, dst.visible.height);
         } else if (s->use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = visible.width * (bpp / 8);
+            int llb = dst.visible.width * (dst.bpp / 8);
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                     visible.height);
+                                     dst.visible.height);
             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
-                                   src_stride, tmp_stride, bpp, bpp,
+                                   src_stride, tmp_stride, dst.bpp, dst.bpp,
                                    src_x, src_y, 0, 0,
-                                   visible.width, visible.height);
+                                   dst.visible.width, dst.visible.height);
             if (!fallback) {
-                fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
-                                       tmp_stride, dst_stride, bpp, bpp,
-                                       0, 0, visible.x, visible.y,
-                                       visible.width, visible.height);
+                fallback = !pixman_blt(tmp, (uint32_t *)dst.bits,
+                                       tmp_stride, dst.stride, dst.bpp, dst.bpp,
+                                       0, 0, dst.visible.x, dst.visible.y,
+                                       dst.visible.width, dst.visible.height);
             }
             g_free(tmp);
         } else
@@ -174,35 +202,36 @@ void ati_2d_blt(ATIVGAState *s)
             fallback = true;
         }
         if (fallback) {
-            unsigned int y, i, j, bypp = bpp / 8;
+            unsigned int y, i, j, bypp = dst.bpp / 8;
             unsigned int src_pitch = src_stride * sizeof(uint32_t);
-            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
+            unsigned int dst_pitch = dst.stride * sizeof(uint32_t);
 
-            for (y = 0; y < visible.height; y++) {
-                i = visible.x * bypp;
+            for (y = 0; y < dst.visible.height; y++) {
+                i = dst.visible.x * bypp;
                 j = src_x * bypp;
-                if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
-                    i += (visible.y + y) * dst_pitch;
+                if (dst.top_to_bottom) {
+                    i += (dst.visible.y + y) * dst_pitch;
                     j += (src_y + y) * src_pitch;
                 } else {
-                    i += (visible.y + visible.height - 1 - y) * dst_pitch;
-                    j += (src_y + visible.height - 1 - y) * src_pitch;
+                    i += (dst.visible.y + dst.visible.height - 1 - y) *
+                         dst_pitch;
+                    j += (src_y + dst.visible.height - 1 - y) * src_pitch;
                 }
-                memmove(&dst_bits[i], &src_bits[j], visible.width * bypp);
+                memmove(&dst.bits[i], &src_bits[j], dst.visible.width * bypp);
             }
         }
-        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+        if (dst.bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+            dst.bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                     s->regs.dst_offset +
-                                    visible.y * surface_stride(ds),
-                                    visible.height * surface_stride(ds));
+                                    dst.visible.y * surface_stride(ds),
+                                    dst.visible.height * surface_stride(ds));
         }
-        s->regs.dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                         visible.x + visible.width : visible.x);
-        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         visible.y + visible.height : visible.y);
+        s->regs.dst_x = (dst.left_to_right ?
+                         dst.visible.x + dst.visible.width : dst.visible.x);
+        s->regs.dst_y = (dst.top_to_bottom ?
+                         dst.visible.y + dst.visible.height : dst.visible.y);
         break;
     }
     case ROP3_PATCOPY:
@@ -225,37 +254,38 @@ void ati_2d_blt(ATIVGAState *s)
             break;
         }
 
-        dst_stride /= sizeof(uint32_t);
+        dst.stride /= sizeof(uint32_t);
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                dst_bits, dst_stride, bpp, visible.x, visible.y,
-                visible.width, visible.height, filler);
+                dst.bits, dst.stride, dst.bpp, dst.visible.x, dst.visible.y,
+                dst.visible.width, dst.visible.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!(s->use_pixman & BIT(0)) ||
-            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp,
-                         visible.x, visible.y, visible.width, visible.height,
+            !pixman_fill((uint32_t *)dst.bits, dst.stride, dst.bpp,
+                         dst.visible.x, dst.visible.y,
+                         dst.visible.width, dst.visible.height,
                          filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
-            unsigned int x, y, i, bypp = bpp / 8;
-            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
-            for (y = 0; y < visible.height; y++) {
-                i = visible.x * bypp + (visible.y + y) * dst_pitch;
-                for (x = 0; x < visible.width; x++, i += bypp) {
-                    stn_he_p(&dst_bits[i], bypp, filler);
+            unsigned int x, y, i, bypp = dst.bpp / 8;
+            unsigned int dst_pitch = dst.stride * sizeof(uint32_t);
+            for (y = 0; y < dst.visible.height; y++) {
+                i = dst.visible.x * bypp + (dst.visible.y + y) * dst_pitch;
+                for (x = 0; x < dst.visible.width; x++, i += bypp) {
+                    stn_he_p(&dst.bits[i], bypp, filler);
                 }
             }
         }
-        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+        if (dst.bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+            dst.bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                     s->regs.dst_offset +
-                                    visible.y * surface_stride(ds),
-                                    visible.height * surface_stride(ds));
+                                    dst.visible.y * surface_stride(ds),
+                                    dst.visible.height * surface_stride(ds));
         }
-        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         visible.y + visible.height : visible.y);
+        s->regs.dst_y = (dst.top_to_bottom ?
+                         dst.visible.y + dst.visible.height : dst.visible.y);
         break;
     }
     default:
-- 
2.51.2


