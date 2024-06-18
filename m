Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A08EC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbNN-0006Sr-0n; Tue, 18 Jun 2024 12:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbNK-00063a-RU
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:08:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbNI-00083J-Nk
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:08:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4230366ad7bso51141675e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726878; x=1719331678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BqjFfkPLwT0VSYgNamjDwX1J5syzJFrA1eN6oC3z1MQ=;
 b=ZL/p4Oudt8JpziXSt4wKpOKHhCkuP39SXxtSp0kNd+k7Nu20VYMUnvran1/wJnArTQ
 Vvzah2c3mkGO7lHffdqOwLQ3Y/snpt+2fQW48skUcufGdUnhUwF2InRY6iltjhHILRrw
 XeBg+rD9i7qrhgDMCcJGn6+4N/PcG/Rka/FWronO7zt3i1D2G8ek3fmN+3oMzAVzChGz
 WkS1KDtJ8lTv5PcW7KX8Hs1LTRNfA9Gwu7xN8Dm7sbSQzdl5dqQk4AhEFnKPzht70Owi
 ixTeFUyFXX1DWn8cZsCt3AQDmR5RNrJozzLs+4njJZSqJCvufkx1z1CY5AwUNEmbl6Vi
 QeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726878; x=1719331678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BqjFfkPLwT0VSYgNamjDwX1J5syzJFrA1eN6oC3z1MQ=;
 b=Eq8JZ1dCMX4wMDWZ7E+JTYPHUyZGPfS7+0Jpsl06awWpcQ6qdiEX4TuhuycPJjRDcx
 ghAmQOKLnFSYQihFiulZIMT9WhKdMG+26P+p8VUUSDe6plOMIGK7p3XU8Uo7vrIUkMWm
 T+G3QMr64e2LWd2Hj3GTzv5+MIPVhnts+8JiDITwSFfRB1TMHFImiZNTC7ETy08jU5Cv
 NhwtbEwTWH5zhXPd/u32w7YkAyHN8kxAR7J0nJCqEVlB0udhU9AO9s6t9HWMw2VQBP4m
 WwCBkk4uAFoK/tAL8fDxwFZJg4bI24Om6S9FjGYGQvGkDVaTBGbz5pwJYIaS1HR+T800
 1KYQ==
X-Gm-Message-State: AOJu0Yx0zldmL+uowz7p6Iiwz7vYI0TgJFJwDLuDKPKJQ+zvndC24J7G
 vUZKHvacAJMgbsQ6nlyd54cCiIxjeJLEBVsrlvOqOiDNWE72Y7Hv673ifhiReTdKEl8P/JUiI5a
 4
X-Google-Smtp-Source: AGHT+IEEu2CnKAB6wifbXkU/Nss8U1kry7lwTm8LyLcOIfbLGSYSKsaqeo5GqhCvhrQJb3NM3yZ/+Q==
X-Received: by 2002:a05:600c:468e:b0:422:469a:f0ec with SMTP id
 5b1f17b1804b1-42304820c6emr130483585e9.12.1718726878516; 
 Tue, 18 Jun 2024 09:07:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602ee95sm196723925e9.13.2024.06.18.09.07.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:07:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 76/76] ui+display: rename is_buffer_shared() ->
 surface_is_allocated()
Date: Tue, 18 Jun 2024 18:00:38 +0200
Message-ID: <20240618160039.36108-77-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gerd Hoffmann <kraxel@redhat.com>

Boolean return value is reversed, to align with QEMU_ALLOCATED_FLAG, so
all callers must be adapted.  Also rename share_surface variable in
vga_draw_graphic() to reduce confusion.

No functional change.

Suggested-by: Marc-André Lureau <marcandre.lureau@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240605131444.797896-4-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/ui/surface.h    |  4 ++--
 hw/display/qxl-render.c |  2 +-
 hw/display/vga.c        | 20 ++++++++++----------
 hw/display/xenfb.c      |  5 +++--
 ui/console.c            |  3 ++-
 5 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/ui/surface.h b/include/ui/surface.h
index 273bb4769a..345b19169d 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -45,9 +45,9 @@ void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
 DisplaySurface *qemu_create_displaysurface(int width, int height);
 void qemu_free_displaysurface(DisplaySurface *surface);
 
-static inline int is_buffer_shared(DisplaySurface *surface)
+static inline int surface_is_allocated(DisplaySurface *surface)
 {
-    return !(surface->flags & QEMU_ALLOCATED_FLAG);
+    return surface->flags & QEMU_ALLOCATED_FLAG;
 }
 
 static inline int surface_is_placeholder(DisplaySurface *surface)
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index ec99ec887a..8daae72c8d 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -31,7 +31,7 @@ static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
     uint8_t *src;
     int len, i;
 
-    if (is_buffer_shared(surface)) {
+    if (!surface_is_allocated(surface)) {
         return;
     }
     trace_qxl_render_blit(qxl->guest_primary.qxl_stride,
diff --git a/hw/display/vga.c b/hw/display/vga.c
index be2b19b839..892fedc8dc 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1487,7 +1487,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     uint8_t *d;
     uint32_t v, addr1, addr;
     vga_draw_line_func *vga_draw_line = NULL;
-    bool share_surface, force_shadow = false;
+    bool allocate_surface, force_shadow = false;
     pixman_format_code_t format;
 #if HOST_BIG_ENDIAN
     bool byteswap = !s->big_endian_fb;
@@ -1609,10 +1609,10 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
      */
     format = qemu_default_pixman_format(depth, !byteswap);
     if (format) {
-        share_surface = dpy_gfx_check_format(s->con, format)
-            && !s->force_shadow && !force_shadow;
+        allocate_surface = !dpy_gfx_check_format(s->con, format)
+            || s->force_shadow || force_shadow;
     } else {
-        share_surface = false;
+        allocate_surface = true;
     }
 
     if (s->params.line_offset != s->last_line_offset ||
@@ -1620,7 +1620,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         height != s->last_height ||
         s->last_depth != depth ||
         s->last_byteswap != byteswap ||
-        share_surface != is_buffer_shared(surface)) {
+        allocate_surface != surface_is_allocated(surface)) {
         /* display parameters changed -> need new display surface */
         s->last_scr_width = disp_width;
         s->last_scr_height = height;
@@ -1635,14 +1635,14 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         full_update = 1;
     }
     if (surface_data(surface) != s->vram_ptr + (s->params.start_addr * 4)
-        && is_buffer_shared(surface)) {
+        && !surface_is_allocated(surface)) {
         /* base address changed (page flip) -> shared display surfaces
          * must be updated with the new base address */
         full_update = 1;
     }
 
     if (full_update) {
-        if (share_surface) {
+        if (!allocate_surface) {
             surface = qemu_create_displaysurface_from(disp_width,
                     height, format, s->params.line_offset,
                     s->vram_ptr + (s->params.start_addr * 4));
@@ -1655,7 +1655,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 
     vga_draw_line = vga_draw_line_table[v];
 
-    if (!is_buffer_shared(surface) && s->cursor_invalidate) {
+    if (surface_is_allocated(surface) && s->cursor_invalidate) {
         s->cursor_invalidate(s);
     }
 
@@ -1707,7 +1707,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         if (update) {
             if (y_start < 0)
                 y_start = y;
-            if (!(is_buffer_shared(surface))) {
+            if (surface_is_allocated(surface)) {
                 uint8_t *p;
                 p = vga_draw_line(s, d, addr, width, hpel);
                 if (p) {
@@ -1762,7 +1762,7 @@ static void vga_draw_blank(VGACommonState *s, int full_update)
     if (s->last_scr_width <= 0 || s->last_scr_height <= 0)
         return;
 
-    if (is_buffer_shared(surface)) {
+    if (!surface_is_allocated(surface)) {
         /* unshare buffer, otherwise the blanking corrupts vga vram */
         surface = qemu_create_displaysurface(s->last_scr_width,
                                              s->last_scr_height);
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index ff442ced1a..314d378a1b 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -638,7 +638,7 @@ static void xenfb_guest_copy(struct XenFB *xenfb, int x, int y, int w, int h)
     int linesize = surface_stride(surface);
     uint8_t *data = surface_data(surface);
 
-    if (!is_buffer_shared(surface)) {
+    if (surface_is_allocated(surface)) {
         switch (xenfb->depth) {
         case 8:
             if (bpp == 16) {
@@ -756,7 +756,8 @@ static void xenfb_update(void *opaque)
         xen_pv_printf(&xenfb->c.xendev, 1,
                       "update: resizing: %dx%d @ %d bpp%s\n",
                       xenfb->width, xenfb->height, xenfb->depth,
-                      is_buffer_shared(surface) ? " (shared)" : "");
+                      surface_is_allocated(surface)
+                      ? " (allocated)" : " (borrowed)");
         xenfb->up_fullscreen = 1;
     }
 
diff --git a/ui/console.c b/ui/console.c
index c2173fc0b1..e67c5dae2b 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1510,7 +1510,8 @@ void qemu_console_resize(QemuConsole *s, int width, int height)
     assert(QEMU_IS_GRAPHIC_CONSOLE(s));
 
     if ((s->scanout.kind != SCANOUT_SURFACE ||
-         (surface && !is_buffer_shared(surface) && !surface_is_placeholder(surface))) &&
+         (surface && surface_is_allocated(surface) &&
+                     !surface_is_placeholder(surface))) &&
         qemu_console_get_width(s, -1) == width &&
         qemu_console_get_height(s, -1) == height) {
         return;
-- 
2.41.0


