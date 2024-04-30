Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20814C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfX-0003jK-IS; Tue, 30 Apr 2024 12:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf8-0002Ro-44
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:03 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf2-0005dr-9d
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:01 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d8a24f8a3cso73865941fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495734; x=1715100534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/UJg/HxLsW5auAfzXeiLmjSCbsQPM6BkMOVvD5diRo0=;
 b=Cdq4EzczaNLRHKk688xMFd3NxcgXPyG0Jlu1G10d6nTkmB8+3vGxVwd6vv5GQMbyE7
 4d4QKDr7u1KphoGp+S7E5A6UXCLthWJntBkEnI0v8TqFL71pgUteY6MjYWd8AXOkVosr
 KJInn22v8YnKLur5LbhzkPYhEe6O3Njj1jby9gvYTaC0k9JnWpe2LT1yV3l8aw5kkbMG
 /evv16uqfahbLgJ9LTw3afplHh653bik7Fv56Uzk9N0CkdNiDVKRDMNPW+Pxl/CCqde9
 jrtPDAPuk1B7SXBKOteRpgodP5P9K0lpnquwmev182STcQnu6yXg0ue3wbgurbgsPJsV
 S0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495734; x=1715100534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/UJg/HxLsW5auAfzXeiLmjSCbsQPM6BkMOVvD5diRo0=;
 b=oLKRRgLJtxMYS7PCeO5BmMec6aEd1Gz4JQeqg5dAbZmIQJAqPbzhaukLq9ZAhkJL6B
 e7gaLEu99pSMLEdOTWakhVdCmLiP0/XNtUclOPYdmc9I/o2fPTqFVQUxh7g4n4p07qfD
 t41zH4Npgzkz20kYQMpV4c9JpmrsBVG2FLL+9Spoy9vrH8+AUAsUGkyEk7/+oLDwfUI7
 jOW8t/kTypNnUwTJs9a8BsLGFX82OSEGaWXQUZKWUmsICFGL4cE1WVTZNxHsLhbEfoys
 boZ4upNMqVPIETyOCyVlN9A2N7Zsy0AHZgIGfyTHKEcAsDPOP2zEFUB2U/6xcgFsrPcs
 qWog==
X-Gm-Message-State: AOJu0YxV9jm/eOGAYz8lRILmnolleG9f0Rlj6UBsPQG5FExa566j0XNz
 I8cBnW6hWg3w3LqUuqV6PDj/Z0ZDYU0Ix9ud819dzJlQs9uQnyt0RWJLiHgeBHM09yt4Te80n3r
 t
X-Google-Smtp-Source: AGHT+IH8AL/3mDP6CKJifgAZefX1gfHX6WktGEDRuBKw3GpcTMYRWEBaVTfUvSaIXwyWWFcUSHv/JQ==
X-Received: by 2002:a2e:8713:0:b0:2d2:869a:55af with SMTP id
 m19-20020a2e8713000000b002d2869a55afmr186024lji.17.1714495734454; 
 Tue, 30 Apr 2024 09:48:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/21] hw/display : Add device DM163
Date: Tue, 30 Apr 2024 17:48:38 +0100
Message-Id: <20240430164842.4074734-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

This device implements the IM120417002 colors shield v1.1 for Arduino
(which relies on the DM163 8x3-channel led driving logic) and features
a simple display of an 8x8 RGB matrix. The columns of the matrix are
driven by the DM163 and the rows are driven externally.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240424200929.240921-2-ines.varhol@telecom-paris.fr
[PMM: updated to new reset hold method prototype]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/b-l475e-iot01a.rst |   3 +-
 include/hw/display/dm163.h         |  59 +++++
 hw/display/dm163.c                 | 349 +++++++++++++++++++++++++++++
 hw/display/Kconfig                 |   3 +
 hw/display/meson.build             |   1 +
 hw/display/trace-events            |  14 ++
 6 files changed, 428 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/display/dm163.h
 create mode 100644 hw/display/dm163.c

diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e-iot01a.rst
index a76c9976c50..2adcc4b4c16 100644
--- a/docs/system/arm/b-l475e-iot01a.rst
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -12,7 +12,7 @@ USART, I2C, SPI, CAN and USB OTG, as well as a variety of sensors.
 Supported devices
 """""""""""""""""
 
-Currently B-L475E-IOT01A machine's only supports the following devices:
+Currently B-L475E-IOT01A machines support the following devices:
 
 - Cortex-M4F based STM32L4x5 SoC
 - STM32L4x5 EXTI (Extended interrupts and events controller)
@@ -20,6 +20,7 @@ Currently B-L475E-IOT01A machine's only supports the following devices:
 - STM32L4x5 RCC (Reset and clock control)
 - STM32L4x5 GPIOs (General-purpose I/Os)
 - STM32L4x5 USARTs, UARTs and LPUART (Serial ports)
+- optional 8x8 led display (based on DM163 driver)
 
 Missing devices
 """""""""""""""
diff --git a/include/hw/display/dm163.h b/include/hw/display/dm163.h
new file mode 100644
index 00000000000..4377f77bb75
--- /dev/null
+++ b/include/hw/display/dm163.h
@@ -0,0 +1,59 @@
+/*
+ * QEMU DM163 8x3-channel constant current led driver
+ * driving columns of associated 8x8 RGB matrix.
+ *
+ * Copyright (C) 2024 Samuel Tardieu <sam@rfc1149.net>
+ * Copyright (C) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (C) 2024 Inès Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_DISPLAY_DM163_H
+#define HW_DISPLAY_DM163_H
+
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_DM163 "dm163"
+OBJECT_DECLARE_SIMPLE_TYPE(DM163State, DM163);
+
+#define RGB_MATRIX_NUM_ROWS 8
+#define RGB_MATRIX_NUM_COLS 8
+#define DM163_NUM_LEDS (RGB_MATRIX_NUM_COLS * 3)
+/* The last row is filled with 0 (turned off row) */
+#define COLOR_BUFFER_SIZE (RGB_MATRIX_NUM_ROWS + 1)
+
+typedef struct DM163State {
+    DeviceState parent_obj;
+
+    /* DM163 driver */
+    uint64_t bank0_shift_register[3];
+    uint64_t bank1_shift_register[3];
+    uint16_t latched_outputs[DM163_NUM_LEDS];
+    uint16_t outputs[DM163_NUM_LEDS];
+    qemu_irq sout;
+
+    uint8_t sin;
+    uint8_t dck;
+    uint8_t rst_b;
+    uint8_t lat_b;
+    uint8_t selbk;
+    uint8_t en_b;
+
+    /* IM120417002 colors shield */
+    uint8_t activated_rows;
+
+    /* 8x8 RGB matrix */
+    QemuConsole *console;
+    uint8_t redraw;
+    /* Rows currently being displayed on the matrix. */
+    /* The last row is filled with 0 (turned off row) */
+    uint32_t buffer[COLOR_BUFFER_SIZE][RGB_MATRIX_NUM_COLS];
+    uint8_t last_buffer_idx;
+    uint8_t buffer_idx_of_row[RGB_MATRIX_NUM_ROWS];
+    /* Used to simulate retinal persistence of rows */
+    uint8_t row_persistence_delay[RGB_MATRIX_NUM_ROWS];
+} DM163State;
+
+#endif /* HW_DISPLAY_DM163_H */
diff --git a/hw/display/dm163.c b/hw/display/dm163.c
new file mode 100644
index 00000000000..f92aee371d9
--- /dev/null
+++ b/hw/display/dm163.c
@@ -0,0 +1,349 @@
+/*
+ * QEMU DM163 8x3-channel constant current led driver
+ * driving columns of associated 8x8 RGB matrix.
+ *
+ * Copyright (C) 2024 Samuel Tardieu <sam@rfc1149.net>
+ * Copyright (C) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (C) 2024 Inès Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * The reference used for the DM163 is the following :
+ * http://www.siti.com.tw/product/spec/LED/DM163.pdf
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/display/dm163.h"
+#include "ui/console.h"
+#include "trace.h"
+
+#define LED_SQUARE_SIZE 100
+/* Number of frames a row stays visible after being turned off. */
+#define ROW_PERSISTENCE 3
+#define TURNED_OFF_ROW (COLOR_BUFFER_SIZE - 1)
+
+static const VMStateDescription vmstate_dm163 = {
+    .name = TYPE_DM163,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(bank0_shift_register, DM163State, 3),
+        VMSTATE_UINT64_ARRAY(bank1_shift_register, DM163State, 3),
+        VMSTATE_UINT16_ARRAY(latched_outputs, DM163State, DM163_NUM_LEDS),
+        VMSTATE_UINT16_ARRAY(outputs, DM163State, DM163_NUM_LEDS),
+        VMSTATE_UINT8(dck, DM163State),
+        VMSTATE_UINT8(en_b, DM163State),
+        VMSTATE_UINT8(lat_b, DM163State),
+        VMSTATE_UINT8(rst_b, DM163State),
+        VMSTATE_UINT8(selbk, DM163State),
+        VMSTATE_UINT8(sin, DM163State),
+        VMSTATE_UINT8(activated_rows, DM163State),
+        VMSTATE_UINT32_2DARRAY(buffer, DM163State, COLOR_BUFFER_SIZE,
+                               RGB_MATRIX_NUM_COLS),
+        VMSTATE_UINT8(last_buffer_idx, DM163State),
+        VMSTATE_UINT8_ARRAY(buffer_idx_of_row, DM163State, RGB_MATRIX_NUM_ROWS),
+        VMSTATE_UINT8_ARRAY(row_persistence_delay, DM163State,
+                            RGB_MATRIX_NUM_ROWS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void dm163_reset_hold(Object *obj, ResetType type)
+{
+    DM163State *s = DM163(obj);
+
+    s->sin = 0;
+    s->dck = 0;
+    s->rst_b = 0;
+    /* Ensuring the first falling edge of lat_b isn't missed */
+    s->lat_b = 1;
+    s->selbk = 0;
+    s->en_b = 0;
+    /* Reset stops the PWM, not the shift and latched registers. */
+    memset(s->outputs, 0, sizeof(s->outputs));
+
+    s->activated_rows = 0;
+    s->redraw = 0;
+    trace_dm163_redraw(s->redraw);
+    for (unsigned i = 0; i < COLOR_BUFFER_SIZE; i++) {
+        memset(s->buffer[i], 0, sizeof(s->buffer[0]));
+    }
+    s->last_buffer_idx = 0;
+    memset(s->buffer_idx_of_row, TURNED_OFF_ROW, sizeof(s->buffer_idx_of_row));
+    memset(s->row_persistence_delay, 0, sizeof(s->row_persistence_delay));
+}
+
+static void dm163_dck_gpio_handler(void *opaque, int line, int new_state)
+{
+    DM163State *s = opaque;
+
+    if (new_state && !s->dck) {
+        /*
+         * On raising dck, sample selbk to get the bank to use, and
+         * sample sin for the bit to enter into the bank shift buffer.
+         */
+        uint64_t *sb =
+            s->selbk ? s->bank1_shift_register : s->bank0_shift_register;
+        /* Output the outgoing bit on sout */
+        const bool sout = (s->selbk ? sb[2] & MAKE_64BIT_MASK(63, 1) :
+                           sb[2] & MAKE_64BIT_MASK(15, 1)) != 0;
+        qemu_set_irq(s->sout, sout);
+        /* Enter sin into the shift buffer */
+        sb[2] = (sb[2] << 1) | ((sb[1] >> 63) & 1);
+        sb[1] = (sb[1] << 1) | ((sb[0] >> 63) & 1);
+        sb[0] = (sb[0] << 1) | s->sin;
+    }
+
+    s->dck = new_state;
+    trace_dm163_dck(new_state);
+}
+
+static void dm163_propagate_outputs(DM163State *s)
+{
+    s->last_buffer_idx = (s->last_buffer_idx + 1) % RGB_MATRIX_NUM_ROWS;
+    /* Values are output when reset is high and enable is low. */
+    if (s->rst_b && !s->en_b) {
+        memcpy(s->outputs, s->latched_outputs, sizeof(s->outputs));
+    } else {
+        memset(s->outputs, 0, sizeof(s->outputs));
+    }
+    for (unsigned x = 0; x < RGB_MATRIX_NUM_COLS; x++) {
+        /* Grouping the 3 RGB channels in a pixel value */
+        const uint16_t b = extract16(s->outputs[3 * x + 0], 6, 8);
+        const uint16_t g = extract16(s->outputs[3 * x + 1], 6, 8);
+        const uint16_t r = extract16(s->outputs[3 * x + 2], 6, 8);
+        uint32_t rgba = 0;
+
+        trace_dm163_channels(3 * x + 2, r);
+        trace_dm163_channels(3 * x + 1, g);
+        trace_dm163_channels(3 * x + 0, b);
+
+        rgba = deposit32(rgba,  0, 8, r);
+        rgba = deposit32(rgba,  8, 8, g);
+        rgba = deposit32(rgba, 16, 8, b);
+
+        /* Led values are sent from the last one to the first one */
+        s->buffer[s->last_buffer_idx][RGB_MATRIX_NUM_COLS - x - 1] = rgba;
+    }
+    for (unsigned row = 0; row < RGB_MATRIX_NUM_ROWS; row++) {
+        if (s->activated_rows & (1 << row)) {
+            s->buffer_idx_of_row[row] = s->last_buffer_idx;
+            s->redraw |= (1 << row);
+            trace_dm163_redraw(s->redraw);
+        }
+    }
+}
+
+static void dm163_en_b_gpio_handler(void *opaque, int line, int new_state)
+{
+    DM163State *s = opaque;
+
+    s->en_b = new_state;
+    dm163_propagate_outputs(s);
+    trace_dm163_en_b(new_state);
+}
+
+static uint8_t dm163_bank0(const DM163State *s, uint8_t led)
+{
+    /*
+     * Bank 0 uses 6 bits per led, so a value may be stored accross
+     * two uint64_t entries.
+     */
+    const uint8_t low_bit = 6 * led;
+    const uint8_t low_word = low_bit / 64;
+    const uint8_t high_word = (low_bit + 5) / 64;
+    const uint8_t low_shift = low_bit % 64;
+
+    if (low_word == high_word) {
+        /* Simple case: the value belongs to one entry. */
+        return extract64(s->bank0_shift_register[low_word], low_shift, 6);
+    }
+
+    const uint8_t nb_bits_in_low_word = 64 - low_shift;
+    const uint8_t nb_bits_in_high_word = 6 - nb_bits_in_low_word;
+
+    const uint64_t bits_in_low_word = \
+        extract64(s->bank0_shift_register[low_word], low_shift,
+                  nb_bits_in_low_word);
+    const uint64_t bits_in_high_word = \
+        extract64(s->bank0_shift_register[high_word], 0,
+                  nb_bits_in_high_word);
+    uint8_t val = 0;
+
+    val = deposit32(val, 0, nb_bits_in_low_word, bits_in_low_word);
+    val = deposit32(val, nb_bits_in_low_word, nb_bits_in_high_word,
+                    bits_in_high_word);
+
+    return val;
+}
+
+static uint8_t dm163_bank1(const DM163State *s, uint8_t led)
+{
+    const uint64_t entry = s->bank1_shift_register[led / RGB_MATRIX_NUM_COLS];
+    return extract64(entry, 8 * (led % RGB_MATRIX_NUM_COLS), 8);
+}
+
+static void dm163_lat_b_gpio_handler(void *opaque, int line, int new_state)
+{
+    DM163State *s = opaque;
+
+    if (s->lat_b && !new_state) {
+        for (int led = 0; led < DM163_NUM_LEDS; led++) {
+            s->latched_outputs[led] = dm163_bank0(s, led) * dm163_bank1(s, led);
+        }
+        dm163_propagate_outputs(s);
+    }
+
+    s->lat_b = new_state;
+    trace_dm163_lat_b(new_state);
+}
+
+static void dm163_rst_b_gpio_handler(void *opaque, int line, int new_state)
+{
+    DM163State *s = opaque;
+
+    s->rst_b = new_state;
+    dm163_propagate_outputs(s);
+    trace_dm163_rst_b(new_state);
+}
+
+static void dm163_selbk_gpio_handler(void *opaque, int line, int new_state)
+{
+    DM163State *s = opaque;
+
+    s->selbk = new_state;
+    trace_dm163_selbk(new_state);
+}
+
+static void dm163_sin_gpio_handler(void *opaque, int line, int new_state)
+{
+    DM163State *s = opaque;
+
+    s->sin = new_state;
+    trace_dm163_sin(new_state);
+}
+
+static void dm163_rows_gpio_handler(void *opaque, int line, int new_state)
+{
+    DM163State *s = opaque;
+
+    if (new_state) {
+        s->activated_rows |= (1 << line);
+        s->buffer_idx_of_row[line] = s->last_buffer_idx;
+        s->redraw |= (1 << line);
+        trace_dm163_redraw(s->redraw);
+    } else {
+        s->activated_rows &= ~(1 << line);
+        s->row_persistence_delay[line] = ROW_PERSISTENCE;
+    }
+    trace_dm163_activated_rows(s->activated_rows);
+}
+
+static void dm163_invalidate_display(void *opaque)
+{
+    DM163State *s = (DM163State *)opaque;
+    s->redraw = 0xFF;
+    trace_dm163_redraw(s->redraw);
+}
+
+static void update_row_persistence_delay(DM163State *s, unsigned row)
+{
+    if (s->row_persistence_delay[row]) {
+        s->row_persistence_delay[row]--;
+    } else {
+        /*
+         * If the ROW_PERSISTENCE delay is up,
+         * the row is turned off.
+         */
+        s->buffer_idx_of_row[row] = TURNED_OFF_ROW;
+        s->redraw |= (1 << row);
+        trace_dm163_redraw(s->redraw);
+    }
+}
+
+static uint32_t *update_display_of_row(DM163State *s, uint32_t *dest,
+                                       unsigned row)
+{
+    for (unsigned _ = 0; _ < LED_SQUARE_SIZE; _++) {
+        for (int x = 0; x < RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZE; x++) {
+            /* UI layer guarantees that there's 32 bits per pixel (Mar 2024) */
+            *dest++ = s->buffer[s->buffer_idx_of_row[row]][x / LED_SQUARE_SIZE];
+        }
+    }
+
+    dpy_gfx_update(s->console, 0, LED_SQUARE_SIZE * row,
+                    RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZE, LED_SQUARE_SIZE);
+    s->redraw &= ~(1 << row);
+    trace_dm163_redraw(s->redraw);
+
+    return dest;
+}
+
+static void dm163_update_display(void *opaque)
+{
+    DM163State *s = (DM163State *)opaque;
+    DisplaySurface *surface = qemu_console_surface(s->console);
+    uint32_t *dest;
+
+    dest = surface_data(surface);
+    for (unsigned row = 0; row < RGB_MATRIX_NUM_ROWS; row++) {
+        update_row_persistence_delay(s, row);
+        if (!extract8(s->redraw, row, 1)) {
+            dest += LED_SQUARE_SIZE * LED_SQUARE_SIZE * RGB_MATRIX_NUM_COLS;
+            continue;
+        }
+        dest = update_display_of_row(s, dest, row);
+    }
+}
+
+static const GraphicHwOps dm163_ops = {
+    .invalidate  = dm163_invalidate_display,
+    .gfx_update  = dm163_update_display,
+};
+
+static void dm163_realize(DeviceState *dev, Error **errp)
+{
+    DM163State *s = DM163(dev);
+
+    qdev_init_gpio_in(dev, dm163_rows_gpio_handler, RGB_MATRIX_NUM_ROWS);
+    qdev_init_gpio_in(dev, dm163_sin_gpio_handler, 1);
+    qdev_init_gpio_in(dev, dm163_dck_gpio_handler, 1);
+    qdev_init_gpio_in(dev, dm163_rst_b_gpio_handler, 1);
+    qdev_init_gpio_in(dev, dm163_lat_b_gpio_handler, 1);
+    qdev_init_gpio_in(dev, dm163_selbk_gpio_handler, 1);
+    qdev_init_gpio_in(dev, dm163_en_b_gpio_handler, 1);
+    qdev_init_gpio_out_named(dev, &s->sout, "sout", 1);
+
+    s->console = graphic_console_init(dev, 0, &dm163_ops, s);
+    qemu_console_resize(s->console, RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZE,
+                        RGB_MATRIX_NUM_ROWS * LED_SQUARE_SIZE);
+}
+
+static void dm163_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->desc = "DM163";
+    dc->vmsd = &vmstate_dm163;
+    dc->realize = dm163_realize;
+    rc->phases.hold = dm163_reset_hold;
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+}
+
+static const TypeInfo dm163_types[] = {
+    {
+        .name = TYPE_DM163,
+        .parent = TYPE_DEVICE,
+        .instance_size = sizeof(DM163State),
+        .class_init = dm163_class_init
+    }
+};
+
+DEFINE_TYPES(dm163_types)
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 234c7de027c..a4552c8ed78 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -140,3 +140,6 @@ config XLNX_DISPLAYPORT
     bool
     # defaults to "N", enabled by specific boards
     depends on PIXMAN
+
+config DM163
+    bool
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 4751aab3ba9..7893b94c8ee 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -38,6 +38,7 @@ system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
 
 system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
+system_ss.add(when: 'CONFIG_DM163', if_true: files('dm163.c'))
 
 if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
     config_all_devices.has_key('CONFIG_VGA_PCI') or
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 2336a0ca157..781f8a33203 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -177,3 +177,17 @@ macfb_ctrl_write(uint64_t addr, uint64_t value, unsigned int size) "addr 0x%"PRI
 macfb_sense_read(uint32_t value) "video sense: 0x%"PRIx32
 macfb_sense_write(uint32_t value) "video sense: 0x%"PRIx32
 macfb_update_mode(uint32_t width, uint32_t height, uint8_t depth) "setting mode to width %"PRId32 " height %"PRId32 " size %d"
+
+# dm163.c
+dm163_redraw(uint8_t redraw) "0x%02x"
+dm163_dck(unsigned new_state) "dck : %u"
+dm163_en_b(unsigned new_state) "en_b : %u"
+dm163_rst_b(unsigned new_state) "rst_b : %u"
+dm163_lat_b(unsigned new_state) "lat_b : %u"
+dm163_sin(unsigned new_state) "sin : %u"
+dm163_selbk(unsigned new_state) "selbk : %u"
+dm163_activated_rows(int new_state) "Activated rows : 0x%" PRIx32 ""
+dm163_bits_ppi(unsigned dest_width) "dest_width : %u"
+dm163_leds(int led, uint32_t value) "led %d: 0x%x"
+dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
+dm163_refresh_rate(uint32_t rr) "refresh rate %d"
-- 
2.34.1


