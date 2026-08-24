Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179A1C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXpi-0000Ez-PO; Mon, 24 Aug 2026 12:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wyXpe-0000EB-5Y
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:47:34 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wyXpb-00016A-TD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:47:33 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so48378865ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787590050; x=1788194850; darn=nongnu.org;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jLYHayblO98DosR6rr/G0R7/3PqhDPIOsy5xCqupFyQ=;
 b=c2iDJ1IY1wgnCm7T9D2ggeFJI6zeiEjzdM5WgNDBRPdF0Xc50Mqrnj7sJLYTllRfmE
 DhYIuLZPgygwQa7NHtUzntj8EbrOvVWxHhPev/LTBADwDlfrpYb8S72iopnxO/JeBoBu
 /y89afabR4dI2eT/Y5suVCRyw7M7BYpB+zzwk1YcNd6Lyn/w+uxnuF+TXxPvNPLajTTv
 cuId2piIM58uqY9xCYiJWkyE8gR/VEd+EFD0XukebE+j+NCcM1EmkQZCS58Yb+9Bicc3
 qKxbqq6V8j1DwkyvrspqBhZclH21e943ndO/7jVsmYSAk2Ah1sHto9uCE2OU/TBpTw7V
 +5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787590050; x=1788194850;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jLYHayblO98DosR6rr/G0R7/3PqhDPIOsy5xCqupFyQ=;
 b=QiipqK8/WW+OIIWPjYpvtsZcrX7g/oenAduEEspLIMj01xJMr8+jhitqGEgfmmXH4F
 QCVB6Qimg6s0AuOoJreioktrzvgjip2Yicv37aYRnX9qYUZFc4A73eWWb6NtdBJKPXS+
 SsB0RTbvZFKWTizfSvfj+EztXZouJ3wRGMs/lYka6UJiUrda6Ixx0jU0PKyhUFlcW3NP
 QaaDXqAX91+cksJOmHzbe6gB4vcRfYW3I9OJHBRDuKfN9/p1bMLb/AJb+Y23GuF3rtIo
 xfUTIms/oUpyuNDuJO4ufyKQfK7anfMhR2BUpRbncniD7ilfHM8xD4WvhODWtZyLHqnh
 szgA==
X-Gm-Message-State: AFuF++la7mvmz2o02ObsR9T/LjwDIpt1h9vP2ECYnkeLXT76e6UeBVfr
 TM5pO1y7omqB+O/iTXxOvvpESMcZptszgA5tJC7o9gJtjyqhBz9SPZMl4uaLgo4rico=
X-Gm-Gg: AR+sD11K2sSbO+RTpDmj2K1obZjisswO7Sy6oDFWp8cFsp0usJkG2nFkmIcGguTsmIY
 VYPYzvtuHiY3oVjbMfxF3GhPnQSrrDf+/GmMofyIdWheoJTpvMSEsh2Mx/chFkze6xE1InvRH5O
 rLilPmJt7NPDjKpD/fof9QC8P7J4EQAqLdEV080n6++YPopHIMCRZfZA5lDNsgNeDUtecXsC3Ba
 NrGEiGDhRNwAnytYwci2vUb69OMVLlxaXi7Eu6sSB/VNsWMsaVeVuVnUwqaC7wTClin5lzfU3DU
 Ada4nW5/b2FFZl7RQHfOoARnKDLB41ISIiJunN0hP3TQ5Rk16dLQR2dUHQyvylYKeTyWcPrvko7
 /ijgewcrfZMOpnZ4u0Ge3pka3pOwor5ZSHOoxX0RFL8mC5OvG7AskRTmZlUERsE+7bxv9q9kbP1
 On5OjhsXSjEe7DGQ4yNxWrExqCJrjyxRekU/WUBUg+ISmFQq7Xd3F++3+aTw==
X-Received: by 2002:a17:902:f546:b0:2bf:dd0:c8b1 with SMTP id
 d9443c01a7336-2d6dc655395mr10624265ad.0.1787590049856; 
 Mon, 24 Aug 2026 09:47:29 -0700 (PDT)
Received: from kali.sinner ([38.240.225.76]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d6768dad15sm19664295ad.72.2026.08.24.09.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:47:29 -0700 (PDT)
From: Warisjeet Singh (sin99xx) <sinxx198@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH v3] hw/display/vga: fix text-mode OOB write after a graphics
 surface switch
Date: Mon, 24 Aug 2026 12:47:26 -0400
Message-ID: <vga-v3-20260824.sinxx198@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=sinxx198@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

vga_draw_text() decides whether the console surface needs a resize from
its geometry cache, but none of the cache terms observe the graphics
renderer having replaced the console surface in between:

- last_width/last_height are shared with vga_draw_graphic(), which
  stores them in pixels while the text path stores characters;
- last_depth stays 0 for legacy (non-VBE) graphics modes, because
  vga_get_bpp() only reports a depth when VBE is enabled, so the
  "s->last_depth" term that normally forces a resize after a graphics
  frame does not fire.

So a graphics frame that shrinks the console surface (e.g. 80x25
pixels) followed by a text frame with matching character geometry
(80x25 chars) skips the resize, and the glyph loop then paints
width*cw x height*cheight pixels into the smaller surface, out of
bounds, with guest-controlled (DAC palette) values, on every display
refresh.

Separate the geometry cache per renderer: text paths (vga_draw_text,
vga_update_text, and the text handling in vga_invalidate_display /
vga_common_reset) now only manipulate last_text_{width,height}, in
characters; last_{width,height} become graphics-only, in pixels.
Additionally, make the text path compare the pixel size it is about
to paint against the console surface's actual dimensions.  The
surface check is the load-bearing term: caches in either unit cannot
see the other renderer swapping the surface, the surface can.

Fixes: CVE-2026-77913
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4215
Cc: qemu-stable@nongnu.org
Signed-off-by: Warisjeet Singh (sin99xx) <sinxx198@gmail.com>
---
Changes v2 -> v3:
- Finish the gfx/text state separation, as requested: vga_update_text()
  (predicate, cache stores, and the mode-message box) and the
  last_width == -1 invalidate handshake now use last_text_{width,height}
  too, so the text paths never touch the graphics cache fields.

Changes v1 -> v2:
- v1 (split caches only) did not fix the reported reproducer: after a
  legacy graphics frame (depth 0) the text predicate still compared
  equal, because nothing in it noticed the console surface had been
  replaced.  Keep the split for clarity, and add the surface-size
  check which actually catches it (verified with the qtest PoC and an
  ASAN build; without this patch ASAN reports a heap-buffer-overflow
  in vga_draw_glyph9(), with it the run is clean).
---
 hw/display/vga.c     | 37 ++++++++++++++++++++++---------------
 hw/display/vga_int.h |  3 ++-
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index da0c331486..cb0e28b79b 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1241,7 +1241,10 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         return;
     }
 
-    if (width != s->last_width || height != s->last_height ||
+    if (surface == NULL ||
+        surface_width(surface) != width * cw ||
+        surface_height(surface) != height * cheight ||
+        width != s->last_text_width || height != s->last_text_height ||
         cw != s->last_cw || cheight != s->last_ch || s->last_depth) {
         s->last_scr_width = width * cw;
         s->last_scr_height = height * cheight;
@@ -1249,8 +1252,8 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         surface = qemu_console_surface(s->con);
         qemu_console_text_resize(s->con, width, height);
         s->last_depth = 0;
-        s->last_width = width;
-        s->last_height = height;
+        s->last_text_width = width;
+        s->last_text_height = height;
         s->last_ch = cheight;
         s->last_cw = cw;
         full_update = 1;
@@ -1845,6 +1848,8 @@ static void vga_invalidate_display(void *opaque)
 
     s->last_width = -1;
     s->last_height = -1;
+    s->last_text_width = -1;
+    s->last_text_height = -1;
 }
 
 void vga_common_reset(VGACommonState *s)
@@ -1887,6 +1892,8 @@ void vga_common_reset(VGACommonState *s)
     s->last_ch = 0;
     s->last_width = 0;
     s->last_height = 0;
+    s->last_text_width = 0;
+    s->last_text_height = 0;
     s->last_scr_width = 0;
     s->last_scr_height = 0;
     s->cursor_start = 0;
@@ -1938,8 +1945,8 @@ static void vga_update_text(void *opaque, uint32_t *chardata)
         s->graphic_mode = graphic_mode;
         full_update = 1;
     }
-    if (s->last_width == -1) {
-        s->last_width = 0;
+    if (s->last_text_width == -1) {
+        s->last_text_width = 0;
         full_update = 1;
     }
 
@@ -1978,15 +1985,15 @@ static void vga_update_text(void *opaque, uint32_t *chardata)
             break;
         }
 
-        if (width != s->last_width || height != s->last_height ||
+        if (width != s->last_text_width || height != s->last_text_height ||
             cw != s->last_cw || cheight != s->last_ch) {
             s->last_scr_width = width * cw;
             s->last_scr_height = height * cheight;
             qemu_console_resize(s->con, s->last_scr_width, s->last_scr_height);
             qemu_console_text_resize(s->con, width, height);
             s->last_depth = 0;
-            s->last_width = width;
-            s->last_height = height;
+            s->last_text_width = width;
+            s->last_text_height = height;
             s->last_ch = cheight;
             s->last_cw = cw;
             full_update = 1;
@@ -2071,22 +2078,22 @@ static void vga_update_text(void *opaque, uint32_t *chardata)
     }
 
     /* Display a message */
-    s->last_width = 60;
-    s->last_height = height = 3;
+    s->last_text_width = 60;
+    s->last_text_height = height = 3;
     qemu_console_text_set_cursor(s->con, -1, -1);
-    qemu_console_text_resize(s->con, s->last_width, height);
+    qemu_console_text_resize(s->con, s->last_text_width, height);
 
-    for (dst = chardata, i = 0; i < s->last_width * height; i ++)
+    for (dst = chardata, i = 0; i < s->last_text_width * height; i ++)
         *dst++ = ' ';
 
     size = strlen(msg_buffer);
-    width = (s->last_width - size) / 2;
-    dst = chardata + s->last_width + width;
+    width = (s->last_text_width - size) / 2;
+    dst = chardata + s->last_text_width + width;
     for (i = 0; i < size; i ++)
         *dst++ = ATTR2CHTYPE(msg_buffer[i], QEMU_COLOR_BLUE,
                              QEMU_COLOR_BLACK, 1);
 
-    qemu_console_text_update(s->con, 0, 0, s->last_width, height);
+    qemu_console_text_update(s->con, 0, 0, s->last_text_width, height);
 }
 
 static uint64_t vga_mem_read(void *opaque, hwaddr addr,
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 5664317ecd..ca69ae9815 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -122,7 +122,8 @@ typedef struct VGACommonState {
     uint32_t plane_updated;
     uint32_t last_line_offset;
     uint8_t last_cw, last_ch;
-    uint32_t last_width, last_height; /* in chars or pixels */
+    uint32_t last_width, last_height; /* in pixels (graphics renderer) */
+    uint32_t last_text_width, last_text_height; /* in chars (text renderer) */
     uint32_t last_scr_width, last_scr_height; /* in pixels */
     uint32_t last_depth; /* in bits */
     bool last_byteswap;
-- 
2.47.3

