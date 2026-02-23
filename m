Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BED3EC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZTf-0007E2-44; Mon, 23 Feb 2026 12:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1486344514@qq.com>)
 id 1vuZK7-00017q-0a; Mon, 23 Feb 2026 12:02:19 -0500
Received: from xmbghk7.mail.qq.com ([43.163.128.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1486344514@qq.com>)
 id 1vuZK3-0008TT-Tv; Mon, 23 Feb 2026 12:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1771866131; bh=a8Wf9hApdHaRm2BqY2IdxiTuw+MQlO3T9VjXVZ3Gf+M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KbcR5m7deWYaTib1azkSlQmd69K3kLTptpmyQtoMZvjIo6L3ISIFHDMMurHKvU/Zx
 RrBquNonSkB3rH4PeSo56WGYn4dJYeN9/0ec8ifid7m00b6qIB5KuH7OC2LkOn00+e
 EH+te2QdM+h8FvDPrtaMV3+HTHHl+q/ilpMqVpV0=
Received: from archlinux ([111.52.70.122])
 by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
 id DAD8BE84; Tue, 24 Feb 2026 00:54:45 +0800
X-QQ-mid: xmsmtpt1771865688t6p4ps7sy
Message-ID: <tencent_9903EBF42878B83D82A1EBAC1F4BB2755B07@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNzntez+LkwpwR/tGSchyKPMsH+KY2sblyoELUSsYgwpDVP1ql6SYN
 Xke7xlJ1O1T3QER7FcDymQbGDvu2feFQEhw7gVqHcSbLo1B/3mW4tX59dgTghyiwA3EjR6+CIewR
 0JSSldTwUkqOLUKHevgHhlvvrYUTcSNmSdjZFvee1mTA9FeCEGV0eS88EFiIW00OCc56MooS3lN2
 0NsvrR7w2T5fYK0w8E6/AjuShNsC0YIcMC3wD4xvZnOHDWQ0BgbavYQSxsVlr3dV0n6Cvu7pZZaV
 Mf6uQ5tJiMoEUZswfoJWfystniFnePhIBjUe2QflTqVd0s0oLAdneH3kIq75QjJ+LyT1XpccIk4w
 qc42cXacGXCENgfOJHlI34O+BUbz//5cHTzlFehP6yUyH1U9lh183vgpx7WO34yAr511V9oE5c9r
 +3ghPSaL9p9ZMWkY7QO9F54UQw+ZmTGz509Kw0ndqT90HNuszLPxqV1nvORHm4zeJAwIH9HvI9D/
 p6CbBujWQKdXlB7RdrPXC9EsZIhMifJCSgxhqNXs/NO71l/eZmvAzZvFLlnqmqS8kiJBsLQ+qH4F
 nFdfl0q6PHa3V6Twgf4tS0qS+o3eMuT8w2hUoN7rA6jwkBxVNrzMLS4FJF+vVF360U0rCFrPk5x9
 V2rbkknOZwnq7fhS51BKAEt5tckwgoD9GLFnmq+JZxvIcDQp49OTkMIVCi0mqC4UBdaNJGbJoq80
 2IjMVc6hxR2neGbzDDsNovXSWkhnfO13MBJg2RpW9hg+q9IwkIoCNxXjKDjy7I1pPE/E7MIoMN/F
 5iczLiQqqUZtB8PNRqUEeweyMb3BbrHoJz6FEkTKkbXnWhUIlAg+u7X2hlscSfUHtY7v56uAFS7r
 tuNzrf/huvu8qcyBrAyQlictXdRGIEuaXmFOyv0PyKTR6U+8yMVE3DtzerzBhMQq+hgrFVWUcoTk
 CYgu5v1OTyCS8LXP8qikaaUt68bnO3ZLFipk90AGypBo+ePAlkaUMfOAVidQgOLM1anN8jZ1t3IY
 ie64zvf5tdyi2yzLB4DRLUuTwXGSPJ8OlJzBbv8g==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Yucai Liu <1486344514@qq.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org,
	jcd@tribudubois.net
Subject: [PATCH 1/1] hw/arm: Implement i.MX6UL LCDIF model
Date: Tue, 24 Feb 2026 00:54:45 +0800
X-OQ-MSGID: <20260223165445.318433-2-1486344514@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223165445.318433-1-1486344514@qq.com>
References: <20260223165445.318433-1-1486344514@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.54; envelope-from=1486344514@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Feb 2026 12:11:34 -0500
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

Add a basic i.MX6UL LCDIF device model, hook it into the i.MX6UL SoC, and replace the previous unimplemented LCDIF stub. The model exposes MMIO registers, frame-done IRQ behavior, and framebuffer-backed display updates for RGB565/XRGB8888 formats.

Signed-off-by: Yucai Liu <1486344514@qq.com>
---
 MAINTAINERS                   |   2 +
 hw/arm/fsl-imx6ul.c           |   9 +-
 hw/arm/imx6ul_lcdif.c         | 409 ++++++++++++++++++++++++++++++++++
 hw/arm/meson.build            |   5 +-
 include/hw/arm/fsl-imx6ul.h   |   2 +-
 include/hw/arm/imx6ul_lcdif.h |  37 +++
 6 files changed, 460 insertions(+), 4 deletions(-)
 create mode 100644 hw/arm/imx6ul_lcdif.c
 create mode 100644 include/hw/arm/imx6ul_lcdif.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4918f41ec4..11c16ff387 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -895,8 +895,10 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/mcimx6ul-evk.c
 F: hw/arm/fsl-imx6ul.c
+F: hw/arm/imx6ul_lcdif.c
 F: hw/misc/imx6ul_ccm.c
 F: include/hw/arm/fsl-imx6ul.h
+F: include/hw/arm/imx6ul_lcdif.h
 F: include/hw/misc/imx6ul_ccm.h
 F: docs/system/arm/mcimx6ul-evk.rst
 
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 225e179126..419dba5b56 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
+#include "hw/arm/imx6ul_lcdif.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/core/boards.h"
@@ -163,6 +164,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     DeviceState *gic;
     SysBusDevice *gicsbd;
     DeviceState *cpu;
+    DeviceState *lcdif;
 
     if (ms->smp.cpus > 1) {
         error_setg(errp, "%s: Only a single CPU is supported (%d requested)",
@@ -656,8 +658,11 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * LCD
      */
-    create_unimplemented_device("lcdif", FSL_IMX6UL_LCDIF_ADDR,
-                                FSL_IMX6UL_LCDIF_SIZE);
+    lcdif = qdev_new(TYPE_IMX6UL_LCDIF);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(lcdif), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(lcdif), 0, FSL_IMX6UL_LCDIF_ADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(lcdif), 0,
+                       qdev_get_gpio_in(gic, FSL_IMX6UL_LCDIF_IRQ));
 
     /*
      * CSU
diff --git a/hw/arm/imx6ul_lcdif.c b/hw/arm/imx6ul_lcdif.c
new file mode 100644
index 0000000000..e2e42fbc26
--- /dev/null
+++ b/hw/arm/imx6ul_lcdif.c
@@ -0,0 +1,409 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * i.MX6UL LCDIF controller
+ *
+ * Copyright (c) 2026
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/imx6ul_lcdif.h"
+#include "hw/core/irq.h"
+#include "hw/display/framebuffer.h"
+#include "system/address-spaces.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "ui/pixel_ops.h"
+
+#define LCDIF_MMIO_SIZE             0x1000
+
+#define LCDC_CTRL                   0x00
+#define LCDC_CTRL1                  0x10
+#define LCDC_V4_TRANSFER_COUNT      0x30
+#define LCDC_V4_CUR_BUF             0x40
+#define LCDC_V4_NEXT_BUF            0x50
+#define LCDC_AS_NEXT_BUF            0x230
+
+#define REG_SET                     0x4
+#define REG_CLR                     0x8
+#define REG_TOG                     0xc
+
+#define CTRL_RUN                    BIT(0)
+#define CTRL_WORD_LENGTH_MASK       (0x3 << 8)
+#define CTRL_WORD_LENGTH_16         (0x0 << 8)
+#define CTRL_WORD_LENGTH_24         (0x3 << 8)
+#define CTRL1_CUR_FRAME_DONE_IRQ_EN BIT(13)
+#define CTRL1_CUR_FRAME_DONE_IRQ    BIT(9)
+#define FRAME_PERIOD_NS             (16 * 1000 * 1000ULL)
+
+static inline uint32_t imx6ul_lcdif_reg_idx(hwaddr offset)
+{
+    return (offset & ~0xf) >> 2;
+}
+
+static inline uint32_t imx6ul_lcdif_reg_read(IMX6ULLCDIFState *s, hwaddr offset)
+{
+    return s->regs[imx6ul_lcdif_reg_idx(offset)];
+}
+
+static inline void imx6ul_lcdif_reg_write(IMX6ULLCDIFState *s, hwaddr offset,
+                                          uint32_t value)
+{
+    s->regs[imx6ul_lcdif_reg_idx(offset)] = value;
+}
+
+static inline bool imx6ul_lcdif_is_running(IMX6ULLCDIFState *s)
+{
+    return imx6ul_lcdif_reg_read(s, LCDC_CTRL) & CTRL_RUN;
+}
+
+static void imx6ul_lcdif_schedule_frame(IMX6ULLCDIFState *s)
+{
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    timer_mod(s->frame_timer, now + FRAME_PERIOD_NS);
+}
+
+static void imx6ul_lcdif_update_irq(IMX6ULLCDIFState *s)
+{
+    uint32_t ctrl1 = imx6ul_lcdif_reg_read(s, LCDC_CTRL1);
+    bool level = (ctrl1 & CTRL1_CUR_FRAME_DONE_IRQ_EN) &&
+                 (ctrl1 & CTRL1_CUR_FRAME_DONE_IRQ);
+
+    qemu_set_irq(s->irq, level);
+}
+
+static void imx6ul_lcdif_frame_done(IMX6ULLCDIFState *s)
+{
+    uint32_t ctrl1 = imx6ul_lcdif_reg_read(s, LCDC_CTRL1);
+
+    imx6ul_lcdif_reg_write(s, LCDC_CTRL1, ctrl1 | CTRL1_CUR_FRAME_DONE_IRQ);
+    imx6ul_lcdif_update_irq(s);
+}
+
+static void imx6ul_lcdif_write_pixel(uint8_t **dst, uint8_t r,
+                                     uint8_t g, uint8_t b, int dst_bpp)
+{
+    uint32_t rgb888;
+
+    switch (dst_bpp) {
+    case 8:
+        **dst = rgb_to_pixel8(r, g, b);
+        *dst += 1;
+        break;
+    case 15:
+        *(uint16_t *)*dst = rgb_to_pixel15(r, g, b);
+        *dst += 2;
+        break;
+    case 16:
+        *(uint16_t *)*dst = rgb_to_pixel16(r, g, b);
+        *dst += 2;
+        break;
+    case 24:
+        rgb888 = rgb_to_pixel24(r, g, b);
+        (*dst)[0] = rgb888 & 0xff;
+        (*dst)[1] = (rgb888 >> 8) & 0xff;
+        (*dst)[2] = (rgb888 >> 16) & 0xff;
+        *dst += 3;
+        break;
+    case 32:
+        *(uint32_t *)*dst = rgb_to_pixel32(r, g, b);
+        *dst += 4;
+        break;
+    default:
+        break;
+    }
+}
+
+static void imx6ul_lcdif_draw_line_rgb565(void *opaque, uint8_t *dst,
+                                          const uint8_t *src, int width,
+                                          int dststep)
+{
+    IMX6ULLCDIFState *s = opaque;
+    uint16_t pixel;
+    uint8_t r, g, b;
+    int i;
+
+    for (i = 0; i < width; i++) {
+        pixel = lduw_le_p((void *)src);
+        r = ((pixel >> 11) & 0x1f) << 3;
+        g = ((pixel >> 5) & 0x3f) << 2;
+        b = (pixel & 0x1f) << 3;
+        imx6ul_lcdif_write_pixel(&dst, r, g, b, s->dst_bpp);
+        src += 2;
+    }
+}
+
+static void imx6ul_lcdif_draw_line_xrgb8888(void *opaque, uint8_t *dst,
+                                            const uint8_t *src, int width,
+                                            int dststep)
+{
+    IMX6ULLCDIFState *s = opaque;
+    uint32_t pixel;
+    uint8_t r, g, b;
+    int i;
+
+    for (i = 0; i < width; i++) {
+        pixel = ldl_le_p((void *)src);
+        r = (pixel >> 16) & 0xff;
+        g = (pixel >> 8) & 0xff;
+        b = pixel & 0xff;
+        imx6ul_lcdif_write_pixel(&dst, r, g, b, s->dst_bpp);
+        src += 4;
+    }
+}
+
+static void imx6ul_lcdif_update_display(void *opaque)
+{
+    IMX6ULLCDIFState *s = opaque;
+    DisplaySurface *surface = qemu_console_surface(s->con);
+    uint32_t transfer_count = imx6ul_lcdif_reg_read(s, LCDC_V4_TRANSFER_COUNT);
+    uint32_t width = transfer_count & 0xffff;
+    uint32_t height = (transfer_count >> 16) & 0xffff;
+    uint32_t ctrl = imx6ul_lcdif_reg_read(s, LCDC_CTRL);
+    uint32_t frame_base = imx6ul_lcdif_reg_read(s, LCDC_V4_CUR_BUF);
+    drawfn fn;
+    int first = 0, last = 0;
+    int src_width;
+
+    if (!imx6ul_lcdif_is_running(s) || width == 0 || height == 0) {
+        return;
+    }
+
+    s->dst_bpp = surface_bits_per_pixel(surface);
+    if (s->dst_bpp == 0) {
+        return;
+    }
+
+    switch (ctrl & CTRL_WORD_LENGTH_MASK) {
+    case CTRL_WORD_LENGTH_16:
+        s->src_bpp = 2;
+        fn = imx6ul_lcdif_draw_line_rgb565;
+        break;
+    case CTRL_WORD_LENGTH_24:
+        s->src_bpp = 4;
+        fn = imx6ul_lcdif_draw_line_xrgb8888;
+        break;
+    default:
+        return;
+    }
+
+    if (surface_width(surface) != width || surface_height(surface) != height) {
+        qemu_console_resize(s->con, width, height);
+        surface = qemu_console_surface(s->con);
+        s->invalidate = true;
+    }
+
+    src_width = width * s->src_bpp;
+    if (s->invalidate || s->fb_base != frame_base ||
+        s->src_width != src_width || s->rows != height) {
+        framebuffer_update_memory_section(&s->fbsection, get_system_memory(),
+                                          frame_base, height, src_width);
+        s->fb_base = frame_base;
+        s->src_width = src_width;
+        s->rows = height;
+    }
+
+    framebuffer_update_display(surface, &s->fbsection, width, height,
+                               src_width, surface_stride(surface), 0,
+                               s->invalidate, fn, s, &first, &last);
+    if (first >= 0) {
+        dpy_gfx_update(s->con, 0, first, width, last - first + 1);
+    }
+
+    s->invalidate = false;
+}
+
+static void imx6ul_lcdif_invalidate_display(void *opaque)
+{
+    IMX6ULLCDIFState *s = opaque;
+
+    s->invalidate = true;
+}
+
+static const GraphicHwOps imx6ul_lcdif_graphic_ops = {
+    .invalidate = imx6ul_lcdif_invalidate_display,
+    .gfx_update = imx6ul_lcdif_update_display,
+};
+
+static void imx6ul_lcdif_frame_timer_cb(void *opaque)
+{
+    IMX6ULLCDIFState *s = opaque;
+
+    if (!imx6ul_lcdif_is_running(s)) {
+        return;
+    }
+
+    imx6ul_lcdif_frame_done(s);
+    imx6ul_lcdif_schedule_frame(s);
+}
+
+static uint64_t imx6ul_lcdif_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX6ULLCDIFState *s = opaque;
+    uint32_t idx;
+
+    if (size != 4 || (offset & 0x3) || offset >= LCDIF_MMIO_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad read offset=0x%" HWADDR_PRIx " size=%u\n",
+                      TYPE_IMX6UL_LCDIF, offset, size);
+        return 0;
+    }
+
+    idx = imx6ul_lcdif_reg_idx(offset);
+    return s->regs[idx];
+}
+
+static void imx6ul_lcdif_write(void *opaque, hwaddr offset,
+                               uint64_t value, unsigned size)
+{
+    IMX6ULLCDIFState *s = opaque;
+    hwaddr reg = offset & ~0xf;
+    uint32_t idx, oldv;
+
+    if (size != 4 || (offset & 0x3) || offset >= LCDIF_MMIO_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset=0x%" HWADDR_PRIx " size=%u\n",
+                      TYPE_IMX6UL_LCDIF, offset, size);
+        return;
+    }
+
+    idx = imx6ul_lcdif_reg_idx(reg);
+    oldv = s->regs[idx];
+
+    switch (offset & 0xf) {
+    case REG_SET:
+        s->regs[idx] |= (uint32_t)value;
+        break;
+    case REG_CLR:
+        s->regs[idx] &= ~(uint32_t)value;
+        break;
+    case REG_TOG:
+        s->regs[idx] ^= (uint32_t)value;
+        break;
+    default:
+        s->regs[idx] = (uint32_t)value;
+        break;
+    }
+
+    switch (reg) {
+    case LCDC_CTRL:
+        if (!(oldv & CTRL_RUN) && (s->regs[idx] & CTRL_RUN)) {
+            imx6ul_lcdif_frame_done(s);
+            imx6ul_lcdif_schedule_frame(s);
+            s->invalidate = true;
+            graphic_hw_invalidate(s->con);
+            return;
+        }
+        if ((oldv & CTRL_RUN) && !(s->regs[idx] & CTRL_RUN)) {
+            timer_del(s->frame_timer);
+        }
+        break;
+    case LCDC_V4_TRANSFER_COUNT:
+        s->invalidate = true;
+        graphic_hw_invalidate(s->con);
+        break;
+    case LCDC_V4_CUR_BUF:
+        s->invalidate = true;
+        graphic_hw_invalidate(s->con);
+        break;
+    case LCDC_V4_NEXT_BUF:
+        imx6ul_lcdif_reg_write(s, LCDC_V4_CUR_BUF, s->regs[idx]);
+        imx6ul_lcdif_frame_done(s);
+        if (imx6ul_lcdif_is_running(s)) {
+            imx6ul_lcdif_schedule_frame(s);
+        }
+        s->invalidate = true;
+        graphic_hw_invalidate(s->con);
+        return;
+    case LCDC_AS_NEXT_BUF:
+        imx6ul_lcdif_frame_done(s);
+        if (imx6ul_lcdif_is_running(s)) {
+            imx6ul_lcdif_schedule_frame(s);
+        }
+        return;
+    default:
+        break;
+    }
+
+    imx6ul_lcdif_update_irq(s);
+}
+
+static const MemoryRegionOps imx6ul_lcdif_ops = {
+    .read = imx6ul_lcdif_read,
+    .write = imx6ul_lcdif_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void imx6ul_lcdif_reset(DeviceState *dev)
+{
+    IMX6ULLCDIFState *s = IMX6UL_LCDIF(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->fb_base = 0;
+    s->src_width = 0;
+    s->rows = 0;
+    s->src_bpp = 0;
+    s->invalidate = true;
+    timer_del(s->frame_timer);
+    qemu_set_irq(s->irq, 0);
+}
+
+static void imx6ul_lcdif_realize(DeviceState *dev, Error **errp)
+{
+    IMX6ULLCDIFState *s = IMX6UL_LCDIF(dev);
+
+    s->frame_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                  imx6ul_lcdif_frame_timer_cb, s);
+    s->invalidate = true;
+    memory_region_init_io(&s->iomem, OBJECT(dev), &imx6ul_lcdif_ops, s,
+                          TYPE_IMX6UL_LCDIF, LCDIF_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+    s->con = graphic_console_init(dev, 0, &imx6ul_lcdif_graphic_ops, s);
+}
+
+static void imx6ul_lcdif_finalize(Object *obj)
+{
+    IMX6ULLCDIFState *s = IMX6UL_LCDIF(obj);
+
+    if (s->fbsection.mr) {
+        memory_region_set_log(s->fbsection.mr, false, DIRTY_MEMORY_VGA);
+        memory_region_unref(s->fbsection.mr);
+        s->fbsection.mr = NULL;
+    }
+    if (s->con) {
+        graphic_console_close(s->con);
+    }
+    timer_free(s->frame_timer);
+}
+
+static void imx6ul_lcdif_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = imx6ul_lcdif_realize;
+    device_class_set_legacy_reset(dc, imx6ul_lcdif_reset);
+    dc->desc = "i.MX6UL LCDIF";
+}
+
+static const TypeInfo imx6ul_lcdif_info = {
+    .name = TYPE_IMX6UL_LCDIF,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMX6ULLCDIFState),
+    .instance_finalize = imx6ul_lcdif_finalize,
+    .class_init = imx6ul_lcdif_class_init,
+};
+
+static void imx6ul_lcdif_register_types(void)
+{
+    type_register_static(&imx6ul_lcdif_info);
+}
+
+type_init(imx6ul_lcdif_register_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 47cdc51d13..afcaca55ba 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -87,7 +87,10 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
-arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL',
+                  if_true: files('fsl-imx6ul.c',
+                                 'imx6ul_lcdif.c',
+                                 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen-stubs.c',
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 4e3209b25b..cc41c2dbab 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -143,7 +143,7 @@ enum FslIMX6ULMemoryMap {
     FSL_IMX6UL_PXP_SIZE             = (16 * KiB),
 
     FSL_IMX6UL_LCDIF_ADDR           = 0x021C8000,
-    FSL_IMX6UL_LCDIF_SIZE           = 0x100,
+    FSL_IMX6UL_LCDIF_SIZE           = 0x1000,
 
     FSL_IMX6UL_CSI_ADDR             = 0x021C4000,
     FSL_IMX6UL_CSI_SIZE             = 0x100,
diff --git a/include/hw/arm/imx6ul_lcdif.h b/include/hw/arm/imx6ul_lcdif.h
new file mode 100644
index 0000000000..86da972d06
--- /dev/null
+++ b/include/hw/arm/imx6ul_lcdif.h
@@ -0,0 +1,37 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * i.MX6UL LCDIF controller
+ *
+ * Copyright (c) 2026
+ */
+
+#ifndef IMX6UL_LCDIF_H
+#define IMX6UL_LCDIF_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "qemu/timer.h"
+#include "ui/console.h"
+
+#define TYPE_IMX6UL_LCDIF "imx6ul-lcdif"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX6ULLCDIFState, IMX6UL_LCDIF)
+
+struct IMX6ULLCDIFState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    MemoryRegionSection fbsection;
+    qemu_irq irq;
+    QemuConsole *con;
+    QEMUTimer *frame_timer;
+    uint32_t fb_base;
+    uint32_t src_width;
+    uint32_t rows;
+    uint8_t src_bpp;
+    uint8_t dst_bpp;
+    bool invalidate;
+    uint32_t regs[0x1000 / sizeof(uint32_t)];
+};
+
+#endif /* IMX6UL_LCDIF_H */
-- 
2.53.0


