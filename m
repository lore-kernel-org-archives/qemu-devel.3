Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CABE67A62
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQug-0001WC-OS; Tue, 03 Mar 2026 09:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1486344514@qq.com>)
 id 1vxQuX-0001Rl-Fz; Tue, 03 Mar 2026 09:39:46 -0500
Received: from xmbghk7.mail.qq.com ([43.163.128.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1486344514@qq.com>)
 id 1vxQuP-00025p-01; Tue, 03 Mar 2026 09:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1772548766; bh=TujDtHVsrobrI9YDNxITq2j5LwSnR2EXXZDUsFyFw3w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CqjZwy5PKU1rxcrD+R7dxCBhHDf9h7btqtTfR+ro5FVRXcXtGuUtpTY28UIVVvlMY
 VGiauNdk50NxfWY06+fMRw3Ona/+jkSvjDscsaTnkKbotreymtI7SZzCL4blti2fv2
 qFsAmkS3TR46oMrZkWHZxqctj1gZFIDlvsMMCFng=
Received: from archlinux ([180.154.0.12])
 by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
 id 7F901C7D; Tue, 03 Mar 2026 22:31:57 +0800
X-QQ-mid: xmsmtpt1772548318tg5wlovns
Message-ID: <tencent_541F0EB26A5B5A6BDF2823380282EDEBEC07@qq.com>
X-QQ-XMAILINFO: MBbh9ZpQ5zEXwe9kklYlLzl/ieMn6uFRu5PxLruJqCDCZ9TvcgTd1kxkc61jfm
 Bts1c6HaqSacqHN/VH8pe4Cg5Cm1Uwftp76lgJl7GaTu7SDXCUz3bO3K/MduUkIjp+aNQE3FlvQ/
 zsfBYLjQD8nXKjmXa3VAL0Ih1vZIZXofNAkgBeXcsbNtkT+doGtdJnn8N02x3D7qG3XIT2j3IZL3
 MiaQnMJMymkgL6ApvX1r97smfZhyJECrBWSGcBeYGWqdb02E+EI28ZiQFXI6p+G24ADXNgJekcRh
 DEuPX1awbqkHmGH5wrdRm6BsBnHy4g8+NujHoGEDUC3L3ayEwhHAMIaKoYppBGNk2LOPzL9UaD2x
 lykxR/uUluCPXJgn6BvpRImDWQ/PZaOZZ5xXuCE4Q/XQOWj6U4LWJ5ytR5mtcH3TNZj7+vcsxtHM
 NPbAPe9m/vOmTnxyrboedFTyIAuJi2F2EqT9Ctt4IpcIzK0qkO8dXG1iqDmW5D2flPhusbJC5SfG
 3F45TB+sOu2rxw7r7JCABhk77x/NnCo+jGTd03Rc667fztIjQ9KHNPMAbA9lBIUSCrZjg0jHyIsJ
 ArWl/QinDRSsrZfwPcrQM7TYo19i/4L2Vy6xdW9DOmE0O+GJU51JW/GfLfRS/YkZX9f1V7Fh713d
 gNpJcw07JvwauHuIQ99aCYTFEwA9+taMdK9vrrfdwrMHs60K8n1FHQi7Gl5LTYL+Fzg7vcJKfniw
 JdnbB39SrLqsSNhlR5PHnJ8ISFqfT6Mm6wImQYVVF7ljfzOkPbelUF/fKENxUJ3QTedEpThYhwle
 hd2U+/xfvZxRe6Cl6y7XEovuE+hX3EsyDi7lIZoAX5lN/dTbsNcOFSD8gfCK2dXz/0HxoVEOEb4u
 kO6qVKe6qqyJYFGAgetV75Bh+GROlT03uPR481xX7xBH7D6W7zjJXZ20InttS3Q4FYkl7OY4D8Yg
 QFzsPx8Kz/nhg7gevaT+m7FjAtkfD0CCmRtnZBqu4bZ29ropcYk7mhfze6GBWrpfrECpo8XvAwd9
 s0cAqo0XuAstX01YnE7JUv5mVSO0w=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Yucai Liu <1486344514@qq.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, jcd@tribudubois.net,
 pbonzini@redhat.com
Subject: [PATCH v2 1/3] hw/display: Add i.MX6UL LCDIF device model
Date: Tue,  3 Mar 2026 22:31:54 +0800
X-OQ-MSGID: <20260303143157.80437-2-1486344514@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303143157.80437-1-1486344514@qq.com>
References: <20260303143157.80437-1-1486344514@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.52; envelope-from=1486344514@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Implement a basic i.MX6UL LCDIF controller model with MMIO\nregisters, frame-done interrupt behavior, and framebuffer-backed\ndisplay updates for RGB565 and XRGB8888 inputs.\n\nModel the register fields using registerfields.h helpers, provide\nmigration support via vmstate, and place the device under hw/display/\nas a standalone display device.

Signed-off-by: Yucai Liu <1486344514@qq.com>
---
 MAINTAINERS                       |   2 +
 hw/display/imx6ul_lcdif.c         | 435 ++++++++++++++++++++++++++++++
 include/hw/display/imx6ul_lcdif.h |  36 +++
 3 files changed, 473 insertions(+)
 create mode 100644 hw/display/imx6ul_lcdif.c
 create mode 100644 include/hw/display/imx6ul_lcdif.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4918f41ec4..b58022eb28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -895,8 +895,10 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/mcimx6ul-evk.c
 F: hw/arm/fsl-imx6ul.c
+F: hw/display/imx6ul_lcdif.c
 F: hw/misc/imx6ul_ccm.c
 F: include/hw/arm/fsl-imx6ul.h
+F: include/hw/display/imx6ul_lcdif.h
 F: include/hw/misc/imx6ul_ccm.h
 F: docs/system/arm/mcimx6ul-evk.rst
 
diff --git a/hw/display/imx6ul_lcdif.c b/hw/display/imx6ul_lcdif.c
new file mode 100644
index 0000000000..b84084a33e
--- /dev/null
+++ b/hw/display/imx6ul_lcdif.c
@@ -0,0 +1,435 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * i.MX6UL LCDIF controller
+ *
+ * Copyright (c) 2026 Yucai Liu <1486344514@qq.com>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/display/imx6ul_lcdif.h"
+#include "hw/core/irq.h"
+#include "hw/core/registerfields.h"
+#include "hw/display/framebuffer.h"
+#include "migration/vmstate.h"
+#include "system/address-spaces.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "ui/pixel_ops.h"
+
+#define LCDIF_MMIO_SIZE             0x1000
+
+REG32(CTRL, 0x00)
+    FIELD(CTRL, RUN, 0, 1)
+    FIELD(CTRL, WORD_LENGTH, 8, 2)
+REG32(CTRL1, 0x10)
+    FIELD(CTRL1, CUR_FRAME_DONE_IRQ, 9, 1)
+    FIELD(CTRL1, CUR_FRAME_DONE_IRQ_EN, 13, 1)
+REG32(V4_TRANSFER_COUNT, 0x30)
+    FIELD(V4_TRANSFER_COUNT, H_COUNT, 0, 16)
+    FIELD(V4_TRANSFER_COUNT, V_COUNT, 16, 16)
+REG32(V4_CUR_BUF, 0x40)
+REG32(V4_NEXT_BUF, 0x50)
+REG32(AS_NEXT_BUF, 0x230)
+
+#define REG_SET                     0x4
+#define REG_CLR                     0x8
+#define REG_TOG                     0xc
+
+#define CTRL_WORD_LENGTH_16         0
+#define CTRL_WORD_LENGTH_24         3
+
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
+    uint32_t ctrl = imx6ul_lcdif_reg_read(s, A_CTRL);
+
+    return FIELD_EX32(ctrl, CTRL, RUN);
+}
+
+static inline bool imx6ul_lcdif_frame_done_pending(IMX6ULLCDIFState *s)
+{
+    uint32_t ctrl1 = imx6ul_lcdif_reg_read(s, A_CTRL1);
+
+    return FIELD_EX32(ctrl1, CTRL1, CUR_FRAME_DONE_IRQ);
+}
+
+static void imx6ul_lcdif_schedule_frame(IMX6ULLCDIFState *s)
+{
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    timer_mod(s->frame_timer, now + FRAME_PERIOD_NS);
+}
+
+static void imx6ul_lcdif_maybe_schedule_frame(IMX6ULLCDIFState *s)
+{
+    if (imx6ul_lcdif_is_running(s) && !imx6ul_lcdif_frame_done_pending(s)) {
+        imx6ul_lcdif_schedule_frame(s);
+    } else {
+        timer_del(s->frame_timer);
+    }
+}
+
+static void imx6ul_lcdif_update_irq(IMX6ULLCDIFState *s)
+{
+    uint32_t ctrl1 = imx6ul_lcdif_reg_read(s, A_CTRL1);
+    bool level = FIELD_EX32(ctrl1, CTRL1, CUR_FRAME_DONE_IRQ_EN) &&
+                 FIELD_EX32(ctrl1, CTRL1, CUR_FRAME_DONE_IRQ);
+
+    qemu_set_irq(s->irq, level);
+}
+
+static void imx6ul_lcdif_frame_done(IMX6ULLCDIFState *s)
+{
+    uint32_t ctrl1 = imx6ul_lcdif_reg_read(s, A_CTRL1);
+
+    ctrl1 = FIELD_DP32(ctrl1, CTRL1, CUR_FRAME_DONE_IRQ, 1);
+    imx6ul_lcdif_reg_write(s, A_CTRL1, ctrl1);
+    imx6ul_lcdif_update_irq(s);
+}
+
+static void imx6ul_lcdif_draw_line_rgb565(void *opaque, uint8_t *dst,
+                                          const uint8_t *src, int width,
+                                          int dststep)
+{
+    uint32_t *dst32 = (uint32_t *)dst;
+    int i;
+
+    (void)opaque;
+    (void)dststep;
+
+    for (i = 0; i < width; i++) {
+        uint16_t pixel = lduw_le_p(src);
+        uint8_t r = ((pixel >> 11) & 0x1f) << 3;
+        uint8_t g = ((pixel >> 5) & 0x3f) << 2;
+        uint8_t b = (pixel & 0x1f) << 3;
+
+        *dst32++ = rgb_to_pixel32(r, g, b);
+        src += 2;
+    }
+}
+
+static void imx6ul_lcdif_draw_line_xrgb8888(void *opaque, uint8_t *dst,
+                                            const uint8_t *src, int width,
+                                            int dststep)
+{
+    uint32_t *dst32 = (uint32_t *)dst;
+    int i;
+
+    (void)opaque;
+    (void)dststep;
+
+    for (i = 0; i < width; i++) {
+        uint32_t pixel = ldl_le_p(src);
+        uint8_t r = (pixel >> 16) & 0xff;
+        uint8_t g = (pixel >> 8) & 0xff;
+        uint8_t b = pixel & 0xff;
+
+        *dst32++ = rgb_to_pixel32(r, g, b);
+        src += 4;
+    }
+}
+
+static void imx6ul_lcdif_update_display(void *opaque)
+{
+    IMX6ULLCDIFState *s = opaque;
+    DisplaySurface *surface = qemu_console_surface(s->con);
+    uint32_t transfer_count = imx6ul_lcdif_reg_read(s, A_V4_TRANSFER_COUNT);
+    uint32_t width = FIELD_EX32(transfer_count, V4_TRANSFER_COUNT, H_COUNT);
+    uint32_t height = FIELD_EX32(transfer_count, V4_TRANSFER_COUNT, V_COUNT);
+    uint32_t ctrl = imx6ul_lcdif_reg_read(s, A_CTRL);
+    uint32_t frame_base = imx6ul_lcdif_reg_read(s, A_V4_CUR_BUF);
+    drawfn fn;
+    int first = 0;
+    int last = 0;
+    int src_width;
+
+    if (!imx6ul_lcdif_is_running(s) || width == 0 || height == 0) {
+        return;
+    }
+
+    if (surface_bits_per_pixel(surface) != 32) {
+        return;
+    }
+
+    switch (FIELD_EX32(ctrl, CTRL, WORD_LENGTH)) {
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
+    if (!imx6ul_lcdif_is_running(s) || imx6ul_lcdif_frame_done_pending(s)) {
+        return;
+    }
+
+    imx6ul_lcdif_frame_done(s);
+}
+
+static uint64_t imx6ul_lcdif_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX6ULLCDIFState *s = opaque;
+
+    assert(size == 4);
+    assert(!(offset & 0x3));
+    assert(offset < LCDIF_MMIO_SIZE);
+
+    return s->regs[imx6ul_lcdif_reg_idx(offset)];
+}
+
+static void imx6ul_lcdif_write(void *opaque, hwaddr offset,
+                               uint64_t value, unsigned size)
+{
+    IMX6ULLCDIFState *s = opaque;
+    hwaddr reg = offset & ~0xf;
+    uint32_t idx;
+    uint32_t oldv;
+
+    assert(size == 4);
+    assert(!(offset & 0x3));
+    assert(offset < LCDIF_MMIO_SIZE);
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
+    case A_CTRL:
+        if (!FIELD_EX32(oldv, CTRL, RUN) &&
+            FIELD_EX32(s->regs[idx], CTRL, RUN)) {
+            s->invalidate = true;
+            graphic_hw_invalidate(s->con);
+            imx6ul_lcdif_maybe_schedule_frame(s);
+            break;
+        }
+        if (FIELD_EX32(oldv, CTRL, RUN) &&
+            !FIELD_EX32(s->regs[idx], CTRL, RUN)) {
+            timer_del(s->frame_timer);
+        }
+        break;
+    case A_CTRL1:
+        if (FIELD_EX32(oldv, CTRL1, CUR_FRAME_DONE_IRQ) &&
+            !FIELD_EX32(s->regs[idx], CTRL1, CUR_FRAME_DONE_IRQ)) {
+            imx6ul_lcdif_maybe_schedule_frame(s);
+        }
+        break;
+    case A_V4_TRANSFER_COUNT:
+        s->invalidate = true;
+        graphic_hw_invalidate(s->con);
+        break;
+    case A_V4_CUR_BUF:
+        s->invalidate = true;
+        graphic_hw_invalidate(s->con);
+        break;
+    case A_V4_NEXT_BUF:
+        imx6ul_lcdif_reg_write(s, A_V4_CUR_BUF, s->regs[idx]);
+        imx6ul_lcdif_frame_done(s);
+        s->invalidate = true;
+        graphic_hw_invalidate(s->con);
+        imx6ul_lcdif_maybe_schedule_frame(s);
+        return;
+    case A_AS_NEXT_BUF:
+        imx6ul_lcdif_frame_done(s);
+        imx6ul_lcdif_maybe_schedule_frame(s);
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
+static int imx6ul_lcdif_post_load(void *opaque, int version_id)
+{
+    IMX6ULLCDIFState *s = opaque;
+
+    s->fb_base = 0;
+    s->src_width = 0;
+    s->rows = 0;
+    s->src_bpp = 0;
+    s->invalidate = true;
+
+    imx6ul_lcdif_update_irq(s);
+    if (imx6ul_lcdif_is_running(s) &&
+        !imx6ul_lcdif_frame_done_pending(s) &&
+        !timer_pending(s->frame_timer)) {
+        imx6ul_lcdif_schedule_frame(s);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_imx6ul_lcdif = {
+    .name = TYPE_IMX6UL_LCDIF,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = imx6ul_lcdif_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMX6ULLCDIFState,
+                             LCDIF_MMIO_SIZE / sizeof(uint32_t)),
+        VMSTATE_TIMER_PTR(frame_timer, IMX6ULLCDIFState),
+        VMSTATE_END_OF_LIST()
+    },
+};
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
+
+    if (surface_bits_per_pixel(qemu_console_surface(s->con)) != 32) {
+        error_setg(errp, "%s requires a 32bpp host surface", TYPE_IMX6UL_LCDIF);
+    }
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
+    dc->vmsd = &vmstate_imx6ul_lcdif;
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
diff --git a/include/hw/display/imx6ul_lcdif.h b/include/hw/display/imx6ul_lcdif.h
new file mode 100644
index 0000000000..0b24b64e68
--- /dev/null
+++ b/include/hw/display/imx6ul_lcdif.h
@@ -0,0 +1,36 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * i.MX6UL LCDIF controller
+ *
+ * Copyright (c) 2026 Yucai Liu <1486344514@qq.com>
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
+    bool invalidate;
+    uint32_t regs[0x1000 / sizeof(uint32_t)];
+};
+
+#endif /* IMX6UL_LCDIF_H */
-- 
2.53.0


