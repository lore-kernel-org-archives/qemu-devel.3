Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF49DCEACEA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuv-0005zu-Tt; Tue, 01 Oct 2024 12:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfua-0005a3-No
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuT-00065L-Oc
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so45249645e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800776; x=1728405576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RQ52G5tFfaWMKqM28rr6fuVqFB7IDMFXN+FuFRrCer8=;
 b=ohWyBRQHeRw4iL2OdkYoOS3POuwKXTgPEz/sex+CFFaOHhO44wBVuj7Dp6sGZqgl64
 eiFkzDsti77DtZ6TB7S3wK9e6EqhFLlfyk0Gz9lNZI6nr/XddnZki/Mq4vKgRppqSK6r
 6j6iylGhkTAfmCnGqyBfXpIvc/sTIdOK/vpLqu8gYqcXMEjJlaYQKMPqTDuotBX/s08I
 wwH0ase/pITxichH6d0VERPF9G4clg6KgO0aMxyPSPrp8TDCt9F+JPhJCH6z7FczFvo0
 kjuRX+9eEu2FNOyXGVblve5xwYZZVswQH5p4ZE1K+tRcFwCIcTtott/EBx9dL8UKolcM
 PJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800776; x=1728405576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQ52G5tFfaWMKqM28rr6fuVqFB7IDMFXN+FuFRrCer8=;
 b=xFDAA55hK5PbF5lbPlBH07+qrFSfwqfvfR5yhyuUcEqokkZjPtuP5W6ZP5corRkEA6
 twhmKU9APOv3wRt2Riu6licixWBskGIgjN171faPbJIrWzPcq84cTO47UAkyfxnWBBUI
 72LE9VGkGmIZTe99eLa18Y98IlF8RhL5USN8ITXU1UH7X2pePSFIAsI2eCB1Q6Oktc5X
 8L0nBigN/rBN16oYMI9speWlR4+5ob6eRZ+6nxzlvmr7lbJqz78n3BVBobCqQN5VD9HN
 TgQWSaYSUvc3UyNsFfs6F8lbS7Y3K5kjULqamkQhA11Wddt+ssw3cYiw+XVF1iVqAJLi
 qBYg==
X-Gm-Message-State: AOJu0Yx0I353LywLdHXg0/SQ6JjpxkTKTeA3/KZRR8stKlQira/HX0uJ
 4oMQCrzv8r+JWEGPK6PfXSXjHg2toEisM3kHF/3szaJRfDMQYy3UdaGM7dLlhjd2YGh6fZKhiLe
 p
X-Google-Smtp-Source: AGHT+IF7T7nNF2Dl2mgZknI6xhXk6jSwB3lG13KvBTS4g1o8qpFE+1vpENW3PGJrtAWxh7MiD/bEnA==
X-Received: by 2002:adf:9589:0:b0:37c:cc54:ea72 with SMTP id
 ffacd0b85a97d-37cfb8a1dd0mr157353f8f.4.1727800775863; 
 Tue, 01 Oct 2024 09:39:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/54] hw/display: Remove Blizzard display device
Date: Tue,  1 Oct 2024 17:38:54 +0100
Message-Id: <20241001163918.1275441-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Remove the blizzard display device, which was only used with the
n800 and n810 machines.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240903160751.4100218-28-peter.maydell@linaro.org
---
 MAINTAINERS                   |    2 -
 include/hw/display/blizzard.h |   21 -
 hw/display/blizzard.c         | 1026 ---------------------------------
 hw/display/Kconfig            |    3 -
 hw/display/meson.build        |    1 -
 5 files changed, 1053 deletions(-)
 delete mode 100644 include/hw/display/blizzard.h
 delete mode 100644 hw/display/blizzard.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bae31e1725f..0ca95c895cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -874,12 +874,10 @@ nSeries
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
-F: hw/display/blizzard.c
 F: hw/input/lm832x.c
 F: hw/input/tsc2005.c
 F: hw/input/tsc210x.c
 F: hw/rtc/twl92230.c
-F: include/hw/display/blizzard.h
 F: include/hw/input/lm832x.h
 F: include/hw/input/tsc2xxx.h
 
diff --git a/include/hw/display/blizzard.h b/include/hw/display/blizzard.h
deleted file mode 100644
index 5b330188354..00000000000
--- a/include/hw/display/blizzard.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Epson S1D13744/S1D13745 (Blizzard/Hailstorm/Tornado) LCD/TV controller.
- *
- * Copyright (C) 2008 Nokia Corporation
- * Written by Andrzej Zaborowski
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef HW_DISPLAY_BLIZZARD_H
-#define HW_DISPLAY_BLIZZARD_H
-
-
-void *s1d13745_init(qemu_irq gpio_int);
-void s1d13745_write(void *opaque, int dc, uint16_t value);
-void s1d13745_write_block(void *opaque, int dc,
-                          void *buf, size_t len, int pitch);
-uint16_t s1d13745_read(void *opaque, int dc);
-
-#endif
diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
deleted file mode 100644
index 030abbe7d4d..00000000000
--- a/hw/display/blizzard.c
+++ /dev/null
@@ -1,1026 +0,0 @@
-/*
- * Epson S1D13744/S1D13745 (Blizzard/Hailstorm/Tornado) LCD/TV controller.
- *
- * Copyright (C) 2008 Nokia Corporation
- * Written by Andrzej Zaborowski <andrew@openedhand.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) version 3 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/bitops.h"
-#include "ui/console.h"
-#include "hw/display/blizzard.h"
-#include "ui/pixel_ops.h"
-
-typedef void (*blizzard_fn_t)(uint8_t *, const uint8_t *, unsigned int);
-
-typedef struct {
-    uint8_t reg;
-    uint32_t addr;
-    int swallow;
-
-    int pll;
-    int pll_range;
-    int pll_ctrl;
-    uint8_t pll_mode;
-    uint8_t clksel;
-    int memenable;
-    int memrefresh;
-    uint8_t timing[3];
-    int priority;
-
-    uint8_t lcd_config;
-    int x;
-    int y;
-    int skipx;
-    int skipy;
-    uint8_t hndp;
-    uint8_t vndp;
-    uint8_t hsync;
-    uint8_t vsync;
-    uint8_t pclk;
-    uint8_t u;
-    uint8_t v;
-    uint8_t yrc[2];
-    int ix[2];
-    int iy[2];
-    int ox[2];
-    int oy[2];
-
-    int enable;
-    int blank;
-    int bpp;
-    int invalidate;
-    int mx[2];
-    int my[2];
-    uint8_t mode;
-    uint8_t effect;
-    uint8_t iformat;
-    uint8_t source;
-    QemuConsole *con;
-    blizzard_fn_t *line_fn_tab[2];
-    void *fb;
-
-    uint8_t hssi_config[3];
-    uint8_t tv_config;
-    uint8_t tv_timing[4];
-    uint8_t vbi;
-    uint8_t tv_x;
-    uint8_t tv_y;
-    uint8_t tv_test;
-    uint8_t tv_filter_config;
-    uint8_t tv_filter_idx;
-    uint8_t tv_filter_coeff[0x20];
-    uint8_t border_r;
-    uint8_t border_g;
-    uint8_t border_b;
-    uint8_t gamma_config;
-    uint8_t gamma_idx;
-    uint8_t gamma_lut[0x100];
-    uint8_t matrix_ena;
-    uint8_t matrix_coeff[0x12];
-    uint8_t matrix_r;
-    uint8_t matrix_g;
-    uint8_t matrix_b;
-    uint8_t pm;
-    uint8_t status;
-    uint8_t rgbgpio_dir;
-    uint8_t rgbgpio;
-    uint8_t gpio_dir;
-    uint8_t gpio;
-    uint8_t gpio_edge[2];
-    uint8_t gpio_irq;
-    uint8_t gpio_pdown;
-
-    struct {
-        int x;
-        int y;
-        int dx;
-        int dy;
-        int len;
-        int buflen;
-        void *buf;
-        void *data;
-        uint16_t *ptr;
-        int angle;
-        int pitch;
-        blizzard_fn_t line_fn;
-    } data;
-} BlizzardState;
-
-/* Bytes(!) per pixel */
-static const int blizzard_iformat_bpp[0x10] = {
-    0,
-    2,  /* RGB 5:6:5*/
-    3,  /* RGB 6:6:6 mode 1 */
-    3,  /* RGB 8:8:8 mode 1 */
-    0, 0,
-    4,  /* RGB 6:6:6 mode 2 */
-    4,  /* RGB 8:8:8 mode 2 */
-    0,  /* YUV 4:2:2 */
-    0,  /* YUV 4:2:0 */
-    0, 0, 0, 0, 0, 0,
-};
-
-static void blizzard_window(BlizzardState *s)
-{
-    DisplaySurface *surface = qemu_console_surface(s->con);
-    uint8_t *src, *dst;
-    int bypp[2];
-    int bypl[3];
-    int y;
-    blizzard_fn_t fn = s->data.line_fn;
-
-    if (!fn)
-        return;
-    if (s->mx[0] > s->data.x)
-        s->mx[0] = s->data.x;
-    if (s->my[0] > s->data.y)
-        s->my[0] = s->data.y;
-    if (s->mx[1] < s->data.x + s->data.dx)
-        s->mx[1] = s->data.x + s->data.dx;
-    if (s->my[1] < s->data.y + s->data.dy)
-        s->my[1] = s->data.y + s->data.dy;
-
-    bypp[0] = s->bpp;
-    bypp[1] = surface_bytes_per_pixel(surface);
-    bypl[0] = bypp[0] * s->data.pitch;
-    bypl[1] = bypp[1] * s->x;
-    bypl[2] = bypp[0] * s->data.dx;
-
-    src = s->data.data;
-    dst = s->fb + bypl[1] * s->data.y + bypp[1] * s->data.x;
-    for (y = s->data.dy; y > 0; y --, src += bypl[0], dst += bypl[1])
-        fn(dst, src, bypl[2]);
-}
-
-static int blizzard_transfer_setup(BlizzardState *s)
-{
-    if (s->source > 3 || !s->bpp ||
-                    s->ix[1] < s->ix[0] || s->iy[1] < s->iy[0])
-        return 0;
-
-    s->data.angle = s->effect & 3;
-    s->data.line_fn = s->line_fn_tab[!!s->data.angle][s->iformat];
-    s->data.x = s->ix[0];
-    s->data.y = s->iy[0];
-    s->data.dx = s->ix[1] - s->ix[0] + 1;
-    s->data.dy = s->iy[1] - s->iy[0] + 1;
-    s->data.len = s->bpp * s->data.dx * s->data.dy;
-    s->data.pitch = s->data.dx;
-    if (s->data.len > s->data.buflen) {
-        s->data.buf = g_realloc(s->data.buf, s->data.len);
-        s->data.buflen = s->data.len;
-    }
-    s->data.ptr = s->data.buf;
-    s->data.data = s->data.buf;
-    s->data.len /= 2;
-    return 1;
-}
-
-static void blizzard_reset(BlizzardState *s)
-{
-    s->reg = 0;
-    s->swallow = 0;
-
-    s->pll = 9;
-    s->pll_range = 1;
-    s->pll_ctrl = 0x14;
-    s->pll_mode = 0x32;
-    s->clksel = 0x00;
-    s->memenable = 0;
-    s->memrefresh = 0x25c;
-    s->timing[0] = 0x3f;
-    s->timing[1] = 0x13;
-    s->timing[2] = 0x21;
-    s->priority = 0;
-
-    s->lcd_config = 0x74;
-    s->x = 8;
-    s->y = 1;
-    s->skipx = 0;
-    s->skipy = 0;
-    s->hndp = 3;
-    s->vndp = 2;
-    s->hsync = 1;
-    s->vsync = 1;
-    s->pclk = 0x80;
-
-    s->ix[0] = 0;
-    s->ix[1] = 0;
-    s->iy[0] = 0;
-    s->iy[1] = 0;
-    s->ox[0] = 0;
-    s->ox[1] = 0;
-    s->oy[0] = 0;
-    s->oy[1] = 0;
-
-    s->yrc[0] = 0x00;
-    s->yrc[1] = 0x30;
-    s->u = 0;
-    s->v = 0;
-
-    s->iformat = 3;
-    s->source = 0;
-    s->bpp = blizzard_iformat_bpp[s->iformat];
-
-    s->hssi_config[0] = 0x00;
-    s->hssi_config[1] = 0x00;
-    s->hssi_config[2] = 0x01;
-    s->tv_config = 0x00;
-    s->tv_timing[0] = 0x00;
-    s->tv_timing[1] = 0x00;
-    s->tv_timing[2] = 0x00;
-    s->tv_timing[3] = 0x00;
-    s->vbi = 0x10;
-    s->tv_x = 0x14;
-    s->tv_y = 0x03;
-    s->tv_test = 0x00;
-    s->tv_filter_config = 0x80;
-    s->tv_filter_idx = 0x00;
-    s->border_r = 0x10;
-    s->border_g = 0x80;
-    s->border_b = 0x80;
-    s->gamma_config = 0x00;
-    s->gamma_idx = 0x00;
-    s->matrix_ena = 0x00;
-    memset(&s->matrix_coeff, 0, sizeof(s->matrix_coeff));
-    s->matrix_r = 0x00;
-    s->matrix_g = 0x00;
-    s->matrix_b = 0x00;
-    s->pm = 0x02;
-    s->status = 0x00;
-    s->rgbgpio_dir = 0x00;
-    s->gpio_dir = 0x00;
-    s->gpio_edge[0] = 0x00;
-    s->gpio_edge[1] = 0x00;
-    s->gpio_irq = 0x00;
-    s->gpio_pdown = 0xff;
-}
-
-static inline void blizzard_invalidate_display(void *opaque) {
-    BlizzardState *s = (BlizzardState *) opaque;
-
-    s->invalidate = 1;
-}
-
-static uint16_t blizzard_reg_read(void *opaque, uint8_t reg)
-{
-    BlizzardState *s = (BlizzardState *) opaque;
-
-    switch (reg) {
-    case 0x00:  /* Revision Code */
-        return 0xa5;
-
-    case 0x02:  /* Configuration Readback */
-        return 0x83;    /* Macrovision OK, CNF[2:0] = 3 */
-
-    case 0x04:  /* PLL M-Divider */
-        return (s->pll - 1) | (1 << 7);
-    case 0x06:  /* PLL Lock Range Control */
-        return s->pll_range;
-    case 0x08:  /* PLL Lock Synthesis Control 0 */
-        return s->pll_ctrl & 0xff;
-    case 0x0a:  /* PLL Lock Synthesis Control 1 */
-        return s->pll_ctrl >> 8;
-    case 0x0c:  /* PLL Mode Control 0 */
-        return s->pll_mode;
-
-    case 0x0e:  /* Clock-Source Select */
-        return s->clksel;
-
-    case 0x10:  /* Memory Controller Activate */
-    case 0x14:  /* Memory Controller Bank 0 Status Flag */
-        return s->memenable;
-
-    case 0x18:  /* Auto-Refresh Interval Setting 0 */
-        return s->memrefresh & 0xff;
-    case 0x1a:  /* Auto-Refresh Interval Setting 1 */
-        return s->memrefresh >> 8;
-
-    case 0x1c:  /* Power-On Sequence Timing Control */
-        return s->timing[0];
-    case 0x1e:  /* Timing Control 0 */
-        return s->timing[1];
-    case 0x20:  /* Timing Control 1 */
-        return s->timing[2];
-
-    case 0x24:  /* Arbitration Priority Control */
-        return s->priority;
-
-    case 0x28:  /* LCD Panel Configuration */
-        return s->lcd_config;
-
-    case 0x2a:  /* LCD Horizontal Display Width */
-        return s->x >> 3;
-    case 0x2c:  /* LCD Horizontal Non-display Period */
-        return s->hndp;
-    case 0x2e:  /* LCD Vertical Display Height 0 */
-        return s->y & 0xff;
-    case 0x30:  /* LCD Vertical Display Height 1 */
-        return s->y >> 8;
-    case 0x32:  /* LCD Vertical Non-display Period */
-        return s->vndp;
-    case 0x34:  /* LCD HS Pulse-width */
-        return s->hsync;
-    case 0x36:  /* LCd HS Pulse Start Position */
-        return s->skipx >> 3;
-    case 0x38:  /* LCD VS Pulse-width */
-        return s->vsync;
-    case 0x3a:  /* LCD VS Pulse Start Position */
-        return s->skipy;
-
-    case 0x3c:  /* PCLK Polarity */
-        return s->pclk;
-
-    case 0x3e:  /* High-speed Serial Interface Tx Configuration Port 0 */
-        return s->hssi_config[0];
-    case 0x40:  /* High-speed Serial Interface Tx Configuration Port 1 */
-        return s->hssi_config[1];
-    case 0x42:  /* High-speed Serial Interface Tx Mode */
-        return s->hssi_config[2];
-    case 0x44:  /* TV Display Configuration */
-        return s->tv_config;
-    case 0x46 ... 0x4c: /* TV Vertical Blanking Interval Data bits */
-        return s->tv_timing[(reg - 0x46) >> 1];
-    case 0x4e:  /* VBI: Closed Caption / XDS Control / Status */
-        return s->vbi;
-    case 0x50:  /* TV Horizontal Start Position */
-        return s->tv_x;
-    case 0x52:  /* TV Vertical Start Position */
-        return s->tv_y;
-    case 0x54:  /* TV Test Pattern Setting */
-        return s->tv_test;
-    case 0x56:  /* TV Filter Setting */
-        return s->tv_filter_config;
-    case 0x58:  /* TV Filter Coefficient Index */
-        return s->tv_filter_idx;
-    case 0x5a:  /* TV Filter Coefficient Data */
-        if (s->tv_filter_idx < 0x20)
-            return s->tv_filter_coeff[s->tv_filter_idx ++];
-        return 0;
-
-    case 0x60:  /* Input YUV/RGB Translate Mode 0 */
-        return s->yrc[0];
-    case 0x62:  /* Input YUV/RGB Translate Mode 1 */
-        return s->yrc[1];
-    case 0x64:  /* U Data Fix */
-        return s->u;
-    case 0x66:  /* V Data Fix */
-        return s->v;
-
-    case 0x68:  /* Display Mode */
-        return s->mode;
-
-    case 0x6a:  /* Special Effects */
-        return s->effect;
-
-    case 0x6c:  /* Input Window X Start Position 0 */
-        return s->ix[0] & 0xff;
-    case 0x6e:  /* Input Window X Start Position 1 */
-        return s->ix[0] >> 3;
-    case 0x70:  /* Input Window Y Start Position 0 */
-        return s->ix[0] & 0xff;
-    case 0x72:  /* Input Window Y Start Position 1 */
-        return s->ix[0] >> 3;
-    case 0x74:  /* Input Window X End Position 0 */
-        return s->ix[1] & 0xff;
-    case 0x76:  /* Input Window X End Position 1 */
-        return s->ix[1] >> 3;
-    case 0x78:  /* Input Window Y End Position 0 */
-        return s->ix[1] & 0xff;
-    case 0x7a:  /* Input Window Y End Position 1 */
-        return s->ix[1] >> 3;
-    case 0x7c:  /* Output Window X Start Position 0 */
-        return s->ox[0] & 0xff;
-    case 0x7e:  /* Output Window X Start Position 1 */
-        return s->ox[0] >> 3;
-    case 0x80:  /* Output Window Y Start Position 0 */
-        return s->oy[0] & 0xff;
-    case 0x82:  /* Output Window Y Start Position 1 */
-        return s->oy[0] >> 3;
-    case 0x84:  /* Output Window X End Position 0 */
-        return s->ox[1] & 0xff;
-    case 0x86:  /* Output Window X End Position 1 */
-        return s->ox[1] >> 3;
-    case 0x88:  /* Output Window Y End Position 0 */
-        return s->oy[1] & 0xff;
-    case 0x8a:  /* Output Window Y End Position 1 */
-        return s->oy[1] >> 3;
-
-    case 0x8c:  /* Input Data Format */
-        return s->iformat;
-    case 0x8e:  /* Data Source Select */
-        return s->source;
-    case 0x90:  /* Display Memory Data Port */
-        return 0;
-
-    case 0xa8:  /* Border Color 0 */
-        return s->border_r;
-    case 0xaa:  /* Border Color 1 */
-        return s->border_g;
-    case 0xac:  /* Border Color 2 */
-        return s->border_b;
-
-    case 0xb4:  /* Gamma Correction Enable */
-        return s->gamma_config;
-    case 0xb6:  /* Gamma Correction Table Index */
-        return s->gamma_idx;
-    case 0xb8:  /* Gamma Correction Table Data */
-        return s->gamma_lut[s->gamma_idx ++];
-
-    case 0xba:  /* 3x3 Matrix Enable */
-        return s->matrix_ena;
-    case 0xbc ... 0xde: /* Coefficient Registers */
-        return s->matrix_coeff[(reg - 0xbc) >> 1];
-    case 0xe0:  /* 3x3 Matrix Red Offset */
-        return s->matrix_r;
-    case 0xe2:  /* 3x3 Matrix Green Offset */
-        return s->matrix_g;
-    case 0xe4:  /* 3x3 Matrix Blue Offset */
-        return s->matrix_b;
-
-    case 0xe6:  /* Power-save */
-        return s->pm;
-    case 0xe8:  /* Non-display Period Control / Status */
-        return s->status | (1 << 5);
-    case 0xea:  /* RGB Interface Control */
-        return s->rgbgpio_dir;
-    case 0xec:  /* RGB Interface Status */
-        return s->rgbgpio;
-    case 0xee:  /* General-purpose IO Pins Configuration */
-        return s->gpio_dir;
-    case 0xf0:  /* General-purpose IO Pins Status / Control */
-        return s->gpio;
-    case 0xf2:  /* GPIO Positive Edge Interrupt Trigger */
-        return s->gpio_edge[0];
-    case 0xf4:  /* GPIO Negative Edge Interrupt Trigger */
-        return s->gpio_edge[1];
-    case 0xf6:  /* GPIO Interrupt Status */
-        return s->gpio_irq;
-    case 0xf8:  /* GPIO Pull-down Control */
-        return s->gpio_pdown;
-
-    default:
-        fprintf(stderr, "%s: unknown register %02x\n", __func__, reg);
-        return 0;
-    }
-}
-
-static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
-{
-    BlizzardState *s = (BlizzardState *) opaque;
-
-    switch (reg) {
-    case 0x04:  /* PLL M-Divider */
-        s->pll = (value & 0x3f) + 1;
-        break;
-    case 0x06:  /* PLL Lock Range Control */
-        s->pll_range = value & 3;
-        break;
-    case 0x08:  /* PLL Lock Synthesis Control 0 */
-        s->pll_ctrl &= 0xf00;
-        s->pll_ctrl |= (value << 0) & 0x0ff;
-        break;
-    case 0x0a:  /* PLL Lock Synthesis Control 1 */
-        s->pll_ctrl &= 0x0ff;
-        s->pll_ctrl |= (value << 8) & 0xf00;
-        break;
-    case 0x0c:  /* PLL Mode Control 0 */
-        s->pll_mode = value & 0x77;
-        if ((value & 3) == 0 || (value & 3) == 3)
-            fprintf(stderr, "%s: wrong PLL Control bits (%i)\n",
-                    __func__, value & 3);
-        break;
-
-    case 0x0e:  /* Clock-Source Select */
-        s->clksel = value & 0xff;
-        break;
-
-    case 0x10:  /* Memory Controller Activate */
-        s->memenable = value & 1;
-        break;
-    case 0x14:  /* Memory Controller Bank 0 Status Flag */
-        break;
-
-    case 0x18:  /* Auto-Refresh Interval Setting 0 */
-        s->memrefresh &= 0xf00;
-        s->memrefresh |= (value << 0) & 0x0ff;
-        break;
-    case 0x1a:  /* Auto-Refresh Interval Setting 1 */
-        s->memrefresh &= 0x0ff;
-        s->memrefresh |= (value << 8) & 0xf00;
-        break;
-
-    case 0x1c:  /* Power-On Sequence Timing Control */
-        s->timing[0] = value & 0x7f;
-        break;
-    case 0x1e:  /* Timing Control 0 */
-        s->timing[1] = value & 0x17;
-        break;
-    case 0x20:  /* Timing Control 1 */
-        s->timing[2] = value & 0x35;
-        break;
-
-    case 0x24:  /* Arbitration Priority Control */
-        s->priority = value & 1;
-        break;
-
-    case 0x28:  /* LCD Panel Configuration */
-        s->lcd_config = value & 0xff;
-        if (value & (1 << 7))
-            fprintf(stderr, "%s: data swap not supported!\n", __func__);
-        break;
-
-    case 0x2a:  /* LCD Horizontal Display Width */
-        s->x = value << 3;
-        break;
-    case 0x2c:  /* LCD Horizontal Non-display Period */
-        s->hndp = value & 0xff;
-        break;
-    case 0x2e:  /* LCD Vertical Display Height 0 */
-        s->y &= 0x300;
-        s->y |= (value << 0) & 0x0ff;
-        break;
-    case 0x30:  /* LCD Vertical Display Height 1 */
-        s->y &= 0x0ff;
-        s->y |= (value << 8) & 0x300;
-        break;
-    case 0x32:  /* LCD Vertical Non-display Period */
-        s->vndp = value & 0xff;
-        break;
-    case 0x34:  /* LCD HS Pulse-width */
-        s->hsync = value & 0xff;
-        break;
-    case 0x36:  /* LCD HS Pulse Start Position */
-        s->skipx = value & 0xff;
-        break;
-    case 0x38:  /* LCD VS Pulse-width */
-        s->vsync = value & 0xbf;
-        break;
-    case 0x3a:  /* LCD VS Pulse Start Position */
-        s->skipy = value & 0xff;
-        break;
-
-    case 0x3c:  /* PCLK Polarity */
-        s->pclk = value & 0x82;
-        /* Affects calculation of s->hndp, s->hsync and s->skipx.  */
-        break;
-
-    case 0x3e:  /* High-speed Serial Interface Tx Configuration Port 0 */
-        s->hssi_config[0] = value;
-        break;
-    case 0x40:  /* High-speed Serial Interface Tx Configuration Port 1 */
-        s->hssi_config[1] = value;
-        if (((value >> 4) & 3) == 3)
-            fprintf(stderr, "%s: Illegal active-data-links value\n",
-                            __func__);
-        break;
-    case 0x42:  /* High-speed Serial Interface Tx Mode */
-        s->hssi_config[2] = value & 0xbd;
-        break;
-
-    case 0x44:  /* TV Display Configuration */
-        s->tv_config = value & 0xfe;
-        break;
-    case 0x46 ... 0x4c: /* TV Vertical Blanking Interval Data bits 0 */
-        s->tv_timing[(reg - 0x46) >> 1] = value;
-        break;
-    case 0x4e:  /* VBI: Closed Caption / XDS Control / Status */
-        s->vbi = value;
-        break;
-    case 0x50:  /* TV Horizontal Start Position */
-        s->tv_x = value;
-        break;
-    case 0x52:  /* TV Vertical Start Position */
-        s->tv_y = value & 0x7f;
-        break;
-    case 0x54:  /* TV Test Pattern Setting */
-        s->tv_test = value;
-        break;
-    case 0x56:  /* TV Filter Setting */
-        s->tv_filter_config = value & 0xbf;
-        break;
-    case 0x58:  /* TV Filter Coefficient Index */
-        s->tv_filter_idx = value & 0x1f;
-        break;
-    case 0x5a:  /* TV Filter Coefficient Data */
-        if (s->tv_filter_idx < 0x20)
-            s->tv_filter_coeff[s->tv_filter_idx ++] = value;
-        break;
-
-    case 0x60:  /* Input YUV/RGB Translate Mode 0 */
-        s->yrc[0] = value & 0xb0;
-        break;
-    case 0x62:  /* Input YUV/RGB Translate Mode 1 */
-        s->yrc[1] = value & 0x30;
-        break;
-    case 0x64:  /* U Data Fix */
-        s->u = value & 0xff;
-        break;
-    case 0x66:  /* V Data Fix */
-        s->v = value & 0xff;
-        break;
-
-    case 0x68:  /* Display Mode */
-        if ((s->mode ^ value) & 3)
-            s->invalidate = 1;
-        s->mode = value & 0xb7;
-        s->enable = value & 1;
-        s->blank = (value >> 1) & 1;
-        if (value & (1 << 4))
-            fprintf(stderr, "%s: Macrovision enable attempt!\n", __func__);
-        break;
-
-    case 0x6a:  /* Special Effects */
-        s->effect = value & 0xfb;
-        break;
-
-    case 0x6c:  /* Input Window X Start Position 0 */
-        s->ix[0] &= 0x300;
-        s->ix[0] |= (value << 0) & 0x0ff;
-        break;
-    case 0x6e:  /* Input Window X Start Position 1 */
-        s->ix[0] &= 0x0ff;
-        s->ix[0] |= (value << 8) & 0x300;
-        break;
-    case 0x70:  /* Input Window Y Start Position 0 */
-        s->iy[0] &= 0x300;
-        s->iy[0] |= (value << 0) & 0x0ff;
-        break;
-    case 0x72:  /* Input Window Y Start Position 1 */
-        s->iy[0] &= 0x0ff;
-        s->iy[0] |= (value << 8) & 0x300;
-        break;
-    case 0x74:  /* Input Window X End Position 0 */
-        s->ix[1] &= 0x300;
-        s->ix[1] |= (value << 0) & 0x0ff;
-        break;
-    case 0x76:  /* Input Window X End Position 1 */
-        s->ix[1] &= 0x0ff;
-        s->ix[1] |= (value << 8) & 0x300;
-        break;
-    case 0x78:  /* Input Window Y End Position 0 */
-        s->iy[1] &= 0x300;
-        s->iy[1] |= (value << 0) & 0x0ff;
-        break;
-    case 0x7a:  /* Input Window Y End Position 1 */
-        s->iy[1] &= 0x0ff;
-        s->iy[1] |= (value << 8) & 0x300;
-        break;
-    case 0x7c:  /* Output Window X Start Position 0 */
-        s->ox[0] &= 0x300;
-        s->ox[0] |= (value << 0) & 0x0ff;
-        break;
-    case 0x7e:  /* Output Window X Start Position 1 */
-        s->ox[0] &= 0x0ff;
-        s->ox[0] |= (value << 8) & 0x300;
-        break;
-    case 0x80:  /* Output Window Y Start Position 0 */
-        s->oy[0] &= 0x300;
-        s->oy[0] |= (value << 0) & 0x0ff;
-        break;
-    case 0x82:  /* Output Window Y Start Position 1 */
-        s->oy[0] &= 0x0ff;
-        s->oy[0] |= (value << 8) & 0x300;
-        break;
-    case 0x84:  /* Output Window X End Position 0 */
-        s->ox[1] &= 0x300;
-        s->ox[1] |= (value << 0) & 0x0ff;
-        break;
-    case 0x86:  /* Output Window X End Position 1 */
-        s->ox[1] &= 0x0ff;
-        s->ox[1] |= (value << 8) & 0x300;
-        break;
-    case 0x88:  /* Output Window Y End Position 0 */
-        s->oy[1] &= 0x300;
-        s->oy[1] |= (value << 0) & 0x0ff;
-        break;
-    case 0x8a:  /* Output Window Y End Position 1 */
-        s->oy[1] &= 0x0ff;
-        s->oy[1] |= (value << 8) & 0x300;
-        break;
-
-    case 0x8c:  /* Input Data Format */
-        s->iformat = value & 0xf;
-        s->bpp = blizzard_iformat_bpp[s->iformat];
-        if (!s->bpp)
-            fprintf(stderr, "%s: Illegal or unsupported input format %x\n",
-                            __func__, s->iformat);
-        break;
-    case 0x8e:  /* Data Source Select */
-        s->source = value & 7;
-        /* Currently all windows will be "destructive overlays".  */
-        if ((!(s->effect & (1 << 3)) && (s->ix[0] != s->ox[0] ||
-                                        s->iy[0] != s->oy[0] ||
-                                        s->ix[1] != s->ox[1] ||
-                                        s->iy[1] != s->oy[1])) ||
-                        !((s->ix[1] - s->ix[0]) & (s->iy[1] - s->iy[0]) &
-                          (s->ox[1] - s->ox[0]) & (s->oy[1] - s->oy[0]) & 1))
-            fprintf(stderr, "%s: Illegal input/output window positions\n",
-                            __func__);
-
-        blizzard_transfer_setup(s);
-        break;
-
-    case 0x90:  /* Display Memory Data Port */
-        if (!s->data.len && !blizzard_transfer_setup(s))
-            break;
-
-        *s->data.ptr ++ = value;
-        if (-- s->data.len == 0)
-            blizzard_window(s);
-        break;
-
-    case 0xa8:  /* Border Color 0 */
-        s->border_r = value;
-        break;
-    case 0xaa:  /* Border Color 1 */
-        s->border_g = value;
-        break;
-    case 0xac:  /* Border Color 2 */
-        s->border_b = value;
-        break;
-
-    case 0xb4:  /* Gamma Correction Enable */
-        s->gamma_config = value & 0x87;
-        break;
-    case 0xb6:  /* Gamma Correction Table Index */
-        s->gamma_idx = value;
-        break;
-    case 0xb8:  /* Gamma Correction Table Data */
-        s->gamma_lut[s->gamma_idx ++] = value;
-        break;
-
-    case 0xba:  /* 3x3 Matrix Enable */
-        s->matrix_ena = value & 1;
-        break;
-    case 0xbc ... 0xde: /* Coefficient Registers */
-        s->matrix_coeff[(reg - 0xbc) >> 1] = value & ((reg & 2) ? 0x80 : 0xff);
-        break;
-    case 0xe0:  /* 3x3 Matrix Red Offset */
-        s->matrix_r = value;
-        break;
-    case 0xe2:  /* 3x3 Matrix Green Offset */
-        s->matrix_g = value;
-        break;
-    case 0xe4:  /* 3x3 Matrix Blue Offset */
-        s->matrix_b = value;
-        break;
-
-    case 0xe6:  /* Power-save */
-        s->pm = value & 0x83;
-        if (value & s->mode & 1)
-            fprintf(stderr, "%s: The display must be disabled before entering "
-                            "Standby Mode\n", __func__);
-        break;
-    case 0xe8:  /* Non-display Period Control / Status */
-        s->status = value & 0x1b;
-        break;
-    case 0xea:  /* RGB Interface Control */
-        s->rgbgpio_dir = value & 0x8f;
-        break;
-    case 0xec:  /* RGB Interface Status */
-        s->rgbgpio = value & 0xcf;
-        break;
-    case 0xee:  /* General-purpose IO Pins Configuration */
-        s->gpio_dir = value;
-        break;
-    case 0xf0:  /* General-purpose IO Pins Status / Control */
-        s->gpio = value;
-        break;
-    case 0xf2:  /* GPIO Positive Edge Interrupt Trigger */
-        s->gpio_edge[0] = value;
-        break;
-    case 0xf4:  /* GPIO Negative Edge Interrupt Trigger */
-        s->gpio_edge[1] = value;
-        break;
-    case 0xf6:  /* GPIO Interrupt Status */
-        s->gpio_irq &= value;
-        break;
-    case 0xf8:  /* GPIO Pull-down Control */
-        s->gpio_pdown = value;
-        break;
-
-    default:
-        fprintf(stderr, "%s: unknown register %02x\n", __func__, reg);
-        break;
-    }
-}
-
-uint16_t s1d13745_read(void *opaque, int dc)
-{
-    BlizzardState *s = (BlizzardState *) opaque;
-    uint16_t value = blizzard_reg_read(s, s->reg);
-
-    if (s->swallow -- > 0)
-        return 0;
-    if (dc)
-        s->reg ++;
-
-    return value;
-}
-
-void s1d13745_write(void *opaque, int dc, uint16_t value)
-{
-    BlizzardState *s = (BlizzardState *) opaque;
-
-    if (s->swallow -- > 0)
-        return;
-    if (dc) {
-        blizzard_reg_write(s, s->reg, value);
-
-        if (s->reg != 0x90 && s->reg != 0x5a && s->reg != 0xb8)
-            s->reg += 2;
-    } else
-        s->reg = value & 0xff;
-}
-
-void s1d13745_write_block(void *opaque, int dc,
-                void *buf, size_t len, int pitch)
-{
-    BlizzardState *s = (BlizzardState *) opaque;
-
-    while (len > 0) {
-        if (s->reg == 0x90 && dc &&
-                        (s->data.len || blizzard_transfer_setup(s)) &&
-                        len >= (s->data.len << 1)) {
-            len -= s->data.len << 1;
-            s->data.len = 0;
-            s->data.data = buf;
-            if (pitch)
-                s->data.pitch = pitch;
-            blizzard_window(s);
-            s->data.data = s->data.buf;
-            continue;
-        }
-
-        s1d13745_write(opaque, dc, *(uint16_t *) buf);
-        len -= 2;
-        buf += 2;
-    }
-}
-
-static void blizzard_update_display(void *opaque)
-{
-    BlizzardState *s = (BlizzardState *) opaque;
-    DisplaySurface *surface = qemu_console_surface(s->con);
-    int y, bypp, bypl, bwidth;
-    uint8_t *src, *dst;
-
-    if (!s->enable)
-        return;
-
-    if (s->x != surface_width(surface) || s->y != surface_height(surface)) {
-        s->invalidate = 1;
-        qemu_console_resize(s->con, s->x, s->y);
-        surface = qemu_console_surface(s->con);
-    }
-
-    if (s->invalidate) {
-        s->invalidate = 0;
-
-        if (s->blank) {
-            bypp = surface_bytes_per_pixel(surface);
-            memset(surface_data(surface), 0, bypp * s->x * s->y);
-            return;
-        }
-
-        s->mx[0] = 0;
-        s->mx[1] = s->x;
-        s->my[0] = 0;
-        s->my[1] = s->y;
-    }
-
-    if (s->mx[1] <= s->mx[0])
-        return;
-
-    bypp = surface_bytes_per_pixel(surface);
-    bypl = bypp * s->x;
-    bwidth = bypp * (s->mx[1] - s->mx[0]);
-    y = s->my[0];
-    src = s->fb + bypl * y + bypp * s->mx[0];
-    dst = surface_data(surface) + bypl * y + bypp * s->mx[0];
-    for (; y < s->my[1]; y ++, src += bypl, dst += bypl)
-        memcpy(dst, src, bwidth);
-
-    dpy_gfx_update(s->con, s->mx[0], s->my[0],
-                   s->mx[1] - s->mx[0], y - s->my[0]);
-
-    s->mx[0] = s->x;
-    s->mx[1] = 0;
-    s->my[0] = s->y;
-    s->my[1] = 0;
-}
-
-static void blizzard_draw_line16_32(uint32_t *dest,
-                                    const uint16_t *src, unsigned int width)
-{
-    uint16_t data;
-    unsigned int r, g, b;
-    const uint16_t *end = (const void *) src + width;
-    while (src < end) {
-        data = *src ++;
-        b = extract16(data, 0, 5) << 3;
-        g = extract16(data, 5, 6) << 2;
-        r = extract16(data, 11, 5) << 3;
-        *dest++ = rgb_to_pixel32(r, g, b);
-    }
-}
-
-static void blizzard_draw_line24mode1_32(uint32_t *dest,
-                                         const uint8_t *src, unsigned int width)
-{
-    /* TODO: check if SDL 24-bit planes are not in the same format and
-     * if so, use memcpy */
-    unsigned int r[2], g[2], b[2];
-    const uint8_t *end = src + width;
-    while (src < end) {
-        g[0] = *src ++;
-        r[0] = *src ++;
-        r[1] = *src ++;
-        b[0] = *src ++;
-        *dest++ = rgb_to_pixel32(r[0], g[0], b[0]);
-        b[1] = *src ++;
-        g[1] = *src ++;
-        *dest++ = rgb_to_pixel32(r[1], g[1], b[1]);
-    }
-}
-
-static void blizzard_draw_line24mode2_32(uint32_t *dest,
-                                         const uint8_t *src, unsigned int width)
-{
-    unsigned int r, g, b;
-    const uint8_t *end = src + width;
-    while (src < end) {
-        r = *src ++;
-        src ++;
-        b = *src ++;
-        g = *src ++;
-        *dest++ = rgb_to_pixel32(r, g, b);
-    }
-}
-
-/* No rotation */
-static blizzard_fn_t blizzard_draw_fn_32[0x10] = {
-    NULL,
-    /* RGB 5:6:5*/
-    (blizzard_fn_t) blizzard_draw_line16_32,
-    /* RGB 6:6:6 mode 1 */
-    (blizzard_fn_t) blizzard_draw_line24mode1_32,
-    /* RGB 8:8:8 mode 1 */
-    (blizzard_fn_t) blizzard_draw_line24mode1_32,
-    NULL, NULL,
-    /* RGB 6:6:6 mode 2 */
-    (blizzard_fn_t) blizzard_draw_line24mode2_32,
-    /* RGB 8:8:8 mode 2 */
-    (blizzard_fn_t) blizzard_draw_line24mode2_32,
-    /* YUV 4:2:2 */
-    NULL,
-    /* YUV 4:2:0 */
-    NULL,
-    NULL, NULL, NULL, NULL, NULL, NULL,
-};
-
-/* 90deg, 180deg and 270deg rotation */
-static blizzard_fn_t blizzard_draw_fn_r_32[0x10] = {
-    /* TODO */
-    [0 ... 0xf] = NULL,
-};
-
-static const GraphicHwOps blizzard_ops = {
-    .invalidate  = blizzard_invalidate_display,
-    .gfx_update  = blizzard_update_display,
-};
-
-void *s1d13745_init(qemu_irq gpio_int)
-{
-    BlizzardState *s = g_malloc0(sizeof(*s));
-    DisplaySurface *surface;
-
-    s->fb = g_malloc(0x180000);
-
-    s->con = graphic_console_init(NULL, 0, &blizzard_ops, s);
-    surface = qemu_console_surface(s->con);
-
-    assert(surface_bits_per_pixel(surface) == 32);
-
-    s->line_fn_tab[0] = blizzard_draw_fn_32;
-    s->line_fn_tab[1] = blizzard_draw_fn_r_32;
-
-    blizzard_reset(s);
-
-    return s;
-}
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index a4552c8ed78..2c72a61987a 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -66,9 +66,6 @@ config BOCHS_DISPLAY
     select VGA
     select EDID
 
-config BLIZZARD
-    bool
-
 config FRAMEBUFFER
     bool
 
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 1f965a1be84..2b1693ad728 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -22,7 +22,6 @@ system_ss.add(when: 'CONFIG_VGA_MMIO', if_true: files('vga-mmio.c'))
 system_ss.add(when: 'CONFIG_VMWARE_VGA', if_true: files('vmware_vga.c'))
 system_ss.add(when: 'CONFIG_BOCHS_DISPLAY', if_true: files('bochs-display.c'))
 
-system_ss.add(when: 'CONFIG_BLIZZARD', if_true: files('blizzard.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_fimd.c'))
 system_ss.add(when: 'CONFIG_FRAMEBUFFER', if_true: files('framebuffer.c'))
 
-- 
2.34.1


