Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCB8C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyf-0005a8-QW; Tue, 28 Jul 2026 08:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyO-0005U8-Oi
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyM-00038l-Ci
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:51 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso3334243f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241909; x=1785846709; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LUBtF/3zAsFBxpL4HyG/3C6ZuZFSS7kCbYd9+lA6ZKU=;
 b=zJU0sfXXlrBcaH22l57Qx0uOzyBKbd77CXgM8dLOhlQ4GeqpYy5uM13wPL9LSLOoZy
 AJaAes/KCF+y5e+KO7E1HZbMKKVXKJygmI5kyYRqxjIdfPZoc7N40SDKFfoxckv0cinG
 XKNhp8tDKQlHRTbbZOffR5J1Tz2ajPDTgk3D4vDbJCG6svUo9cURRIQRRtx+/CyFmE6Z
 iI6j1XN7R9r3dAtFyrBmPehBnpsqv5lGOISweVTRdUsbK6VvSae/wFgvnoX5FVcB9FWX
 VyZ344NrfSa3NGjtp6HQbaGQp6n8QdbJfesi0eFLfypODO4V528W9jLemD33pqFo8JAC
 SpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241909; x=1785846709;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LUBtF/3zAsFBxpL4HyG/3C6ZuZFSS7kCbYd9+lA6ZKU=;
 b=CyVa+9NEEpusjljJqaCNMCpikxFu+DAOcfwje3SYs3k+q52sbCRA2K4tPCjXt4dxJK
 kYL5IwOSdnzuPTpSYTX3hrwJhJ8xipq+G4Sm3GHBpDm0PmNHCfzBikl8dmM8NixDCgjo
 G18kM3tOU6il7DPQqN0pduA13PpVA/9/ekt3m4Vce+kO3247Ox0Vm9MhJLbjuwWEitwd
 sdjTjq0YSSDsKU2IOLEturQ/O8Rrholc1YM4LgXQQRhSkawd4YOBcA8RrwoTIeu7LYlv
 i0VCPcAsP7kP+oWBP6wveGAMYsattuiuAyQSt6n6lhoBnT/Z+ezdTOuSfbADRFakR1T5
 IrQw==
X-Gm-Message-State: AOJu0YzE+WwwHRqeYps4UkJuKkoloO+LiIoR3uHIoalJE1DF+JXdI2eq
 SDdUThSCgPrkSarAd6JFQHWOzPwknPxhainQtCdi31Ler2wrvxdAUozATtnwWPIi/5Xh+jfxdTw
 JfUxc
X-Gm-Gg: AR+sD13Sof9pboxUXiNkxhvb67E2CZsFa4/OZZ8kxUs2QsJW9j4DkmkLPEAw37EIYtJ
 LSTCOJKNRUfarDyu1fRvIz8wwMKYy83vU4MHyaFbFGfg8lM6Y+VQSs4MuIEgrOuYMbqmSlyOR7b
 CvLiA3+i7J24d0dtFO7xXf9jL3v3CH+vKgob3QyvWyOL9dJtQ5ixe7KkIMFXmHFjNNdV0IQRnoU
 TrRcOd37BGDTW1tCjC6s5IXSXOJrszYCj2IdHda/wr5PRXtD/MSFMBRpO8seGvVhj+u/DxprV5J
 0nbMNi4eMWPa3uFGfgaFm7j73Mq3DoI896bzRYNkjJgKwqWR4gIeLoJUnvGT5n3ijuWcDbKJRMQ
 Rti/TA1br/g9AB1X/pcFMRTZyRgNZiVj44nPw1qoO0u3R2uCzbC5AHJxbMVL+MqdPmKqHJmPNis
 AQHnT2gAHKrVmZFnRShwsSbrrm7DMqSzSjnI6uSFnIMQlt+Bl0hfcSjwpM7i2iF7xAiFXpckYIC
 nco2OwmE+w=
X-Received: by 2002:a05:6000:2502:b0:461:e27d:5690 with SMTP id
 ffacd0b85a97d-47fb1ee0dedmr2779632f8f.26.1785241908696; 
 Tue, 28 Jul 2026 05:31:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/20] hw/display/exynos4210_fimd: Pass width to draw_line
 functions
Date: Tue, 28 Jul 2026 13:31:26 +0100
Message-ID: <20260728123127.1711653-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The draw_line functions currently assume the width of the line they
need to draw is w->rightbot_x - w->lefttop_x + 1, i.e.  the full
width of the guest-programmed window.  We want to be able to clamp
this to the overall screen size, which we can calculate in the
calling function.

Refactor to do this calculation in the caller and pass the
width as an argument to the draw_line functions.

Stable CC because this is a prerequisite for an upcoming bugfix
commit.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20260706173324.804340-3-peter.maydell@linaro.org
---
 hw/display/exynos4210_fimd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 43ad5fa0b46..52f2285cf51 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -282,7 +282,7 @@ struct Exynos4210fimdWindow {
 
     pixel_to_rgb_func *pixel_to_rgb;
     void (*draw_line)(Exynos4210fimdWindow *w, uint8_t *src, uint8_t *dst,
-            bool blend);
+                      uint32_t width, bool blend);
     uint32_t (*get_alpha)(Exynos4210fimdWindow *w, uint32_t pix_a);
     uint16_t lefttop_x, lefttop_y;   /* VIDOSD0 register */
     uint16_t rightbot_x, rightbot_y; /* VIDOSD1 register */
@@ -784,9 +784,9 @@ exynos4210_fimd_blend_pixel(Exynos4210fimdWindow *w, rgba p_bg, rgba *ret)
 /* Draw line with index in palette table in RAM frame buffer data */
 #define DEF_DRAW_LINE_PALETTE(N) \
 static void glue(draw_line_palette_, N)(Exynos4210fimdWindow *w, uint8_t *src, \
-               uint8_t *dst, bool blend) \
+                                        uint8_t *dst, uint32_t width, \
+                                        bool blend)                   \
 { \
-    int width = w->rightbot_x - w->lefttop_x + 1; \
     uint8_t *ifb = dst; \
     uint8_t swap = (w->wincon & FIMD_WINCON_SWAP) >> FIMD_WINCON_SWAP_SHIFT; \
     uint64_t data; \
@@ -813,9 +813,8 @@ static void glue(draw_line_palette_, N)(Exynos4210fimdWindow *w, uint8_t *src, \
 /* Draw line with direct color value in RAM frame buffer data */
 #define DEF_DRAW_LINE_NOPALETTE(N) \
 static void glue(draw_line_, N)(Exynos4210fimdWindow *w, uint8_t *src, \
-                    uint8_t *dst, bool blend) \
+                                uint8_t *dst, uint32_t width, bool blend) \
 { \
-    int width = w->rightbot_x - w->lefttop_x + 1; \
     uint8_t *ifb = dst; \
     uint8_t swap = (w->wincon & FIMD_WINCON_SWAP) >> FIMD_WINCON_SWAP_SHIFT; \
     uint64_t data; \
@@ -848,11 +847,10 @@ DEF_DRAW_LINE_NOPALETTE(32)
 
 /* Special draw line routine for window color map case */
 static void draw_line_mapcolor(Exynos4210fimdWindow *w, uint8_t *src,
-                       uint8_t *dst, bool blend)
+                               uint8_t *dst, uint32_t width, bool blend)
 {
     rgba p, p_old;
     uint8_t *ifb = dst;
-    int width = w->rightbot_x - w->lefttop_x + 1;
     uint32_t map_color = w->winmap & FIMD_WINMAP_COLOR_MASK;
 
     do {
@@ -1240,6 +1238,7 @@ static bool exynos4210_fimd_update(void *opaque)
     uint8_t *host_fb_addr;
     bool is_dirty = false;
     uint32_t global_width;
+    uint32_t window_width;
 
     if (!s || !s->console || !s->enabled ||
         surface_bits_per_pixel(qemu_console_surface(s->console)) == 0) {
@@ -1255,6 +1254,8 @@ static bool exynos4210_fimd_update(void *opaque)
         if ((w->wincon & FIMD_WINCON_ENWIN) && w->host_fb_addr) {
             scrn_height = w->rightbot_y - w->lefttop_y + 1;
             scrn_width = w->virtpage_width;
+            /* Number of bytes to actually draw */
+            window_width = w->rightbot_x - w->lefttop_x + 1;
             /* Total width of virtual screen page in bytes */
             inc_size = scrn_width + w->virtpage_offsize;
             host_fb_addr = w->host_fb_addr;
@@ -1273,7 +1274,8 @@ static bool exynos4210_fimd_update(void *opaque)
                     last_line = line;
                     w->draw_line(w, host_fb_addr, s->ifb +
                         w->lefttop_x * RGBA_SIZE + (w->lefttop_y + line) *
-                        global_width * RGBA_SIZE, blend);
+                                 global_width * RGBA_SIZE,
+                                 window_width, blend);
                 }
                 host_fb_addr += inc_size;
                 fb_line_addr += inc_size;
-- 
2.43.0


