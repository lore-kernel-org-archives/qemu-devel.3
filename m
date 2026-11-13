Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07F606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=hXaIlCEf;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=rdQVIy8w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRzAY-0001qB-CT; Fri, 13 Nov 2026 16:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9o-0008Hv-Gn
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:50:08 -0500
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9l-00060R-01
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:50:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=ixdTcbk
 1OdEDTvH8HCzpMkZ8gW7N3OZTBNqc6MgktLOYdo91TKZu/I1lk0OnsjB/QNJfhc69CSo9P
 agyMhZJsnB4bmGDJ0dUuLBl7PMkicsbB4qLzjfvpocbrVbu4bDnhLG/fs/3k5DSLh0iXRT
 k6sJoscF6VbWcFd1EzbKN4pp9WLgqxXFfffCJJW3YmktHH5HTmFPU2S/s0W8F+sP52EU16
 7gdcEdTf4X1kfoHmmp4UknXTiISzVSEEqW8ZlEdMPNf3evT7CMBm5EQ6aHaRGvAnSsVy4V
 1CmBsdl5ZMkipnQ6YVLTMMwjFqKcO1FCLscwI1j2ioDj1sE3dYaiIag==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=j
 6ZZJJfLaOg9cWOkm3NtH8bN0yKV28RH23d/Fho/U20=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=nRqZS37Myctbm4EMNi73SyQ6dAB1t2JLKTnoifm9RVJEZxtLyL2aeeTNelG+vDBCk1Pn
 MEup5G6+/48v6/i2QEaaNnMHVZNNyvfsXeoh25SKhbmijn3bepQfXMG8QhcMCH7+nYXcLR
 x34vLpvnH0lu3dc/o1U/MUHouajkU4T26kwu81ofh7uVw7XWSa2Xlv5niL6fxms7JrVY9m
 dj695fWCEO77R1CX13pB35Tpd/4w92TiT7nuCSyC0DWBAprbiCwAsNHrmcV3VuzQ7DAdH+
 1sM58d/8mEY9HpluyZsrtXjZ8cxdicuOnXhG8UyWFihRcj7UKRcwRUP7KVB0bibA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=hXaIlCEf; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=rdQVIy8w;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=j6ZZJJfL
 aOg9cWOkm3NtH8bN0yKV28RH23d/Fho/U20=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=hXaIlCEfgM9Vf9wKuVQBiSjjDjDYKkGCnXk
 DyKoup1mciPmYf5Ex5vwXmZJFNwJ8fw9YJu9sSLE2U6wQhvj98V69JE5fKiKCOQUOIghvK
 iiFE0AQPvr3NW8XRvNPmdjTwlYLtnTVrQTN6H7NG3gD1OPox1pBE7Dw3aKRgRcttik/XZy
 dZSMl91LZ4TFAvCHb97qjOn5F99+wuyqiQrMnz9vTFZ0LUUzawp3wPuZ+5Sx02JliwiiYp
 HhO7b6tE6CiHVDY/Wv9EdiV1VYcx57VGe6XspXh9tDE4wtvQQLtRHMRwRS0m0+1IRw3MRR
 J7spnIetaaRIeq07wnb0dnq8f2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=j6ZZJJfLaOg9cWOkm3NtH8bN0yKV28RH23d/Fho/U20=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=rdQVIy8wew1tk3x5Fs
 iiqWGtg2iVpKLPhIuS5lttwzZuK7NgHBqsDHod78TfpitUS3oM3JNbzAUwXKQKyPRMCA==
Received: by mx2.catap.net (OpenSMTPD) id d2973b70;
 Fri, 13 Nov 2026 22:49:51 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id ec414d92;
 Fri, 13 Nov 2026 22:49:33 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v8 19/26] hw/i2c: add Octeon TWSI controller
Date: Fri, 13 Nov 2026 22:45:33 +0100
Message-ID: <20261113214926.98536-20-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113214926.98536-1-kirill@korins.ky>
References: <20261113214926.98536-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:3b:5410::2;
 envelope-from=kirill@korins.ky; helo=mx2.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Kirill A. Korinsky" <kirill@korins.ky>

Add the two Octeon TWSI controllers and a synthesized DDR4 SPD
EEPROM. Derive the SPD geometry and timing from the configured RAM size
and DDR clock, then wire both controller windows into the machine.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/i2c/meson.build        |   5 +
 hw/i2c/octeon_twsi.c      | 553 ++++++++++++++++++++++++++++++++++++++
 hw/mips/octeon.c          |   8 +-
 hw/mips/octeon_internal.h |  11 +
 4 files changed, 576 insertions(+), 1 deletion(-)
 create mode 100644 hw/i2c/octeon_twsi.c

diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index 88aea35662..1c744768e4 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -20,3 +20,8 @@ i2c_ss.add(when: 'CONFIG_PCA954X', if_true: files('i2c_mux_pca954x.c'))
 i2c_ss.add(when: 'CONFIG_PMBUS', if_true: files('pmbus_device.c'))
 i2c_ss.add(when: 'CONFIG_BCM2835_I2C', if_true: files('bcm2835_i2c.c'))
 system_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
+
+if 'CONFIG_TCG' in config_all_accel
+  mips_ss.add(when: 'CONFIG_MIPS_OCTEON',
+              if_true: files('octeon_twsi.c'))
+endif
diff --git a/hw/i2c/octeon_twsi.c b/hw/i2c/octeon_twsi.c
new file mode 100644
index 0000000000..3bc8bf7bcd
--- /dev/null
+++ b/hw/i2c/octeon_twsi.c
@@ -0,0 +1,553 @@
+/*
+ * QEMU Cavium Octeon TWSI controller model.
+ *
+ * Copyright (c) 2026 Kirill A. Korinsky
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/host-utils.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/core/boards.h"
+#include "hw/core/resettable.h"
+#include "hw/core/sysbus.h"
+#include "hw/mips/octeon_internal.h"
+#include "qemu/module.h"
+
+#define OCTEON_TWSI_SIZE            0x200
+#define OCTEON_TWSI0_BASE           0x1180000001000ULL
+#define OCTEON_TWSI1_BASE           0x1180000001200ULL
+#define OCTEON_TWSI_SW_TWSI         0x00
+#define OCTEON_TWSI_INT             0x10
+#define OCTEON_TWSI_SW_DATA_MASK    0xffffffffULL
+#define OCTEON_TWSI_SW_EOP_IA_SHIFT 32
+#define OCTEON_TWSI_SW_R            (1ULL << 56)
+#define OCTEON_TWSI_SW_OP_SHIFT     57
+#define OCTEON_TWSI_SW_V            (1ULL << 63)
+#define OCTEON_TWSI_OP_EOP_IA       6
+#define OCTEON_TWSI_EOP_DATA        1
+#define OCTEON_TWSI_EOP_CTL         2
+#define OCTEON_TWSI_EOP_STAT        3
+#define OCTEON_TWSI_CTL_AAK         0x04
+#define OCTEON_TWSI_CTL_IFLG        0x08
+#define OCTEON_TWSI_CTL_STP         0x10
+#define OCTEON_TWSI_CTL_STA         0x20
+#define OCTEON_TWSI_STAT_START      0x08
+#define OCTEON_TWSI_STAT_TXADDR_ACK 0x18
+#define OCTEON_TWSI_STAT_TXADDR_NAK 0x20
+#define OCTEON_TWSI_STAT_TXDATA_ACK 0x28
+#define OCTEON_TWSI_STAT_TXDATA_NAK 0x30
+#define OCTEON_TWSI_STAT_RXADDR_ACK 0x40
+#define OCTEON_TWSI_STAT_RXADDR_NAK 0x48
+#define OCTEON_TWSI_STAT_RXDATA_ACK 0x50
+#define OCTEON_TWSI_STAT_RXDATA_NAK 0x58
+#define OCTEON_SPD_BUS              1
+#define OCTEON_SPD_ADDR             0x50
+#define OCTEON_SPD_MIN_ROW_BITS     12
+#define OCTEON_SPD_MAX_ROW_BITS     18
+#define OCTEON_SPD_MIN_COL_BITS     9
+#define OCTEON_SPD_MAX_COL_BITS     10
+#define OCTEON_SPD_BANK_BITS        4
+#define OCTEON_SPD_MIN_RAM_SIZE     \
+    (1ULL << (OCTEON_SPD_MIN_ROW_BITS + OCTEON_SPD_MIN_COL_BITS + \
+              OCTEON_SPD_BANK_BITS + 3))
+#define OCTEON_SPD_MAX_RAM_SIZE     \
+    (1ULL << (OCTEON_SPD_MAX_ROW_BITS + OCTEON_SPD_MAX_COL_BITS + \
+              OCTEON_SPD_BANK_BITS + 3))
+#define OCTEON_SPD_DDR4_TCKMIN      18
+#define OCTEON_SPD_DDR4_FINE_TCKMIN 125
+#define OCTEON_SPD_DDR4_MTB_PS      125
+#define OCTEON_SPD_DDR4_FTB_PS      1
+
+#define TYPE_OCTEON_TWSI "octeon-twsi"
+OBJECT_DECLARE_TYPE(OcteonTWSIState, OcteonTWSIClass, OCTEON_TWSI)
+
+#define TYPE_OCTEON_SPD_EEPROM "octeon-spd-eeprom"
+OBJECT_DECLARE_TYPE(OcteonSpdEepromState, OcteonSpdEepromClass,
+                    OCTEON_SPD_EEPROM)
+
+struct OcteonTWSIState {
+    SysBusDevice parent_obj;
+    OcteonState *board;
+    MemoryRegion mmio;
+    unsigned int bus;
+    uint64_t sw_twsi;
+    uint64_t int_reg;
+    uint8_t ctl;
+    uint8_t stat;
+    uint8_t data;
+    uint8_t slave_addr;
+    uint8_t write_buf[2];
+    unsigned int write_len;
+    bool have_slave;
+    bool read_transfer;
+    bool addr_phase;
+};
+
+struct OcteonTWSIClass {
+    SysBusDeviceClass parent_class;
+    ResettablePhases parent_phases;
+};
+
+struct OcteonSpdEepromState {
+    SysBusDevice parent_obj;
+    unsigned int bus;
+    uint8_t addr;
+    uint16_t offset;
+    uint8_t data[OCTEON_SPD_EEPROM_SIZE];
+};
+
+struct OcteonSpdEepromClass {
+    SysBusDeviceClass parent_class;
+    ResettablePhases parent_phases;
+};
+
+static const uint8_t octeon_spd_eeprom_template[OCTEON_SPD_EEPROM_SIZE] = {
+    [0] = 0x23, [1] = 0x11, [2] = 0x0c, [3] = 0x02,
+    [4] = 0x82, [5] = 0x19, [11] = 0x03, [12] = 0x01,
+    [13] = 0x03, [18] = 0x0a, [19] = 0x20, [20] = 0x78,
+    [24] = 0x6e, [25] = 0x6e, [26] = 0x6e, [27] = 0x11,
+    [29] = 0x6e, [31] = 0x05, [32] = 0x70, [33] = 0x03,
+    [34] = 0xd0, [35] = 0x02, [37] = 0xa8, [38] = 0x20,
+    [39] = 0x27, [40] = 0x28, [126] = 0x16, [127] = 0x2f,
+};
+
+static uint16_t octeon_spd_crc16(const uint8_t *ptr, int count)
+{
+    int crc = 0;
+    int i;
+
+    while (--count >= 0) {
+        crc ^= *ptr++ << 8;
+        for (i = 0; i < 8; i++) {
+            if (crc & 0x8000) {
+                crc = (crc << 1) ^ 0x1021;
+            } else {
+                crc <<= 1;
+            }
+        }
+    }
+
+    return crc & 0xffff;
+}
+
+static bool octeon_spd_geometry(uint64_t ram_size, int *row_bits,
+                                int *col_bits, int *density_code)
+{
+    uint64_t ram_mb;
+    int pbank_lsb;
+    int row_col_bits;
+    int col;
+    int row;
+    int density;
+
+    if (ram_size < OCTEON_SPD_MIN_RAM_SIZE ||
+        ram_size > OCTEON_SPD_MAX_RAM_SIZE ||
+        !is_power_of_2(ram_size)) {
+        return false;
+    }
+
+    ram_mb = ram_size / MiB;
+    pbank_lsb = ctz64(ram_size);
+    row_col_bits = pbank_lsb - 3 - OCTEON_SPD_BANK_BITS;
+
+    col = MIN(OCTEON_SPD_MAX_COL_BITS,
+              row_col_bits - OCTEON_SPD_MIN_ROW_BITS);
+    col = MAX(OCTEON_SPD_MIN_COL_BITS, col);
+    row = row_col_bits - col;
+    density = ctz64(ram_mb) - 8;
+
+    if (row < OCTEON_SPD_MIN_ROW_BITS ||
+        row > OCTEON_SPD_MAX_ROW_BITS ||
+        density < 0 || density > 7) {
+        return false;
+    }
+
+    if (row_bits) {
+        *row_bits = row;
+    }
+    if (col_bits) {
+        *col_bits = col;
+    }
+    if (density_code) {
+        *density_code = density;
+    }
+    return true;
+}
+
+void octeon_validate_ram_size(uint64_t ram_size)
+{
+    if (!octeon_spd_geometry(ram_size, NULL, NULL, NULL)) {
+        error_report("octeon3 RAM size must be a power of two from "
+                     "%" PRIu64 " MB to %" PRIu64 " GB",
+                     (uint64_t)OCTEON_SPD_MIN_RAM_SIZE / MiB,
+                     (uint64_t)OCTEON_SPD_MAX_RAM_SIZE / GiB);
+        exit(1);
+    }
+}
+
+static void octeon_spd_set_tckmin(OcteonState *s, uint8_t *spd)
+{
+    uint64_t tck_ps = (1000000000000ULL + s->ddr_hz - 1) / s->ddr_hz;
+    uint64_t mtb = tck_ps / OCTEON_SPD_DDR4_MTB_PS;
+    uint64_t fine = tck_ps % OCTEON_SPD_DDR4_MTB_PS;
+
+    if (mtb == 0 || mtb > UINT8_MAX || fine > INT8_MAX) {
+        error_report("octeon3 DDR clock cannot be represented in DDR4 SPD");
+        exit(1);
+    }
+
+    spd[OCTEON_SPD_DDR4_TCKMIN] = mtb;
+    spd[OCTEON_SPD_DDR4_FINE_TCKMIN] = fine / OCTEON_SPD_DDR4_FTB_PS;
+}
+
+void octeon_init_spd(OcteonState *s)
+{
+    DeviceState *dev = qdev_new(TYPE_OCTEON_SPD_EEPROM);
+    OcteonSpdEepromState *eeprom = OCTEON_SPD_EEPROM(dev);
+    uint64_t ram_size = s->machine->ram_size;
+    int col_bits;
+    int row_bits;
+    int density_code;
+    uint16_t crc;
+
+    s->spd[0] = eeprom;
+    eeprom->bus = OCTEON_SPD_BUS;
+    eeprom->addr = OCTEON_SPD_ADDR;
+    memcpy(eeprom->data, octeon_spd_eeprom_template,
+           sizeof(eeprom->data));
+
+    g_assert(octeon_spd_geometry(ram_size, &row_bits, &col_bits,
+                                 &density_code));
+
+    eeprom->data[4] = 0x80 | density_code;
+    eeprom->data[5] = ((row_bits - OCTEON_SPD_MIN_ROW_BITS) << 3) |
+                      (col_bits - OCTEON_SPD_MIN_COL_BITS);
+    octeon_spd_set_tckmin(s, eeprom->data);
+
+    crc = octeon_spd_crc16(eeprom->data,
+                           (eeprom->data[0] & 0x80) ? 117 : 126);
+    eeprom->data[126] = crc & 0xff;
+    eeprom->data[127] = crc >> 8;
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+}
+
+static OcteonSpdEepromState *octeon_twsi_find_spd(OcteonTWSIState *t)
+{
+    OcteonState *s = t->board;
+    unsigned int i;
+
+    for (i = 0; i < OCTEON_SPD_EEPROM_COUNT; i++) {
+        if (s->spd[i]->bus == t->bus &&
+            s->spd[i]->addr == t->slave_addr) {
+            return s->spd[i];
+        }
+    }
+
+    return NULL;
+}
+
+static uint8_t octeon_spd_eeprom_read(OcteonSpdEepromState *eeprom)
+{
+    uint8_t value = 0xff;
+
+    if (eeprom->offset < sizeof(eeprom->data)) {
+        value = eeprom->data[eeprom->offset];
+    }
+    eeprom->offset++;
+    return value;
+}
+
+static void octeon_twsi_write_ctl(OcteonTWSIState *t, uint8_t value)
+{
+    OcteonSpdEepromState *eeprom;
+
+    t->ctl = value | OCTEON_TWSI_CTL_IFLG;
+
+    if (value & OCTEON_TWSI_CTL_STA) {
+        t->have_slave = false;
+        t->addr_phase = false;
+        t->write_len = 0;
+        t->stat = OCTEON_TWSI_STAT_START;
+    } else if (value & OCTEON_TWSI_CTL_STP) {
+        t->have_slave = false;
+        t->addr_phase = false;
+        t->stat = OCTEON_TWSI_STAT_IDLE;
+    } else if (t->addr_phase) {
+        eeprom = octeon_twsi_find_spd(t);
+        t->addr_phase = false;
+        if (eeprom) {
+            t->stat = t->read_transfer ? OCTEON_TWSI_STAT_RXADDR_ACK :
+                                         OCTEON_TWSI_STAT_TXADDR_ACK;
+        } else {
+            t->stat = t->read_transfer ? OCTEON_TWSI_STAT_RXADDR_NAK :
+                                         OCTEON_TWSI_STAT_TXADDR_NAK;
+        }
+    } else if (t->read_transfer) {
+        t->stat = (value & OCTEON_TWSI_CTL_AAK) ?
+                  OCTEON_TWSI_STAT_RXDATA_ACK : OCTEON_TWSI_STAT_RXDATA_NAK;
+    } else {
+        t->stat = octeon_twsi_find_spd(t) ? OCTEON_TWSI_STAT_TXDATA_ACK :
+                                            OCTEON_TWSI_STAT_TXDATA_NAK;
+    }
+}
+
+static void octeon_twsi_write_data(OcteonTWSIState *t, uint8_t value)
+{
+    OcteonSpdEepromState *eeprom;
+
+    t->data = value;
+
+    if (!t->have_slave) {
+        t->slave_addr = value >> 1;
+        t->read_transfer = value & 1;
+        t->have_slave = true;
+        t->addr_phase = true;
+        t->write_len = 0;
+        return;
+    }
+
+    if (!t->read_transfer && t->write_len < ARRAY_SIZE(t->write_buf)) {
+        t->write_buf[t->write_len++] = value;
+        eeprom = octeon_twsi_find_spd(t);
+        if (eeprom) {
+            if (t->write_len == 1) {
+                eeprom->offset = value;
+            } else if (t->write_len == ARRAY_SIZE(t->write_buf)) {
+                eeprom->offset = (t->write_buf[0] << 8) | t->write_buf[1];
+            }
+        }
+    }
+}
+
+static uint8_t octeon_twsi_read_reg(OcteonTWSIState *t, unsigned int reg)
+{
+    switch (reg) {
+    case OCTEON_TWSI_EOP_DATA:
+        if (t->read_transfer) {
+            OcteonSpdEepromState *eeprom = octeon_twsi_find_spd(t);
+
+            t->data = eeprom ? octeon_spd_eeprom_read(eeprom) : 0xff;
+        }
+        return t->data;
+    case OCTEON_TWSI_EOP_CTL:
+        return t->ctl;
+    case OCTEON_TWSI_EOP_STAT:
+        return t->stat;
+    default:
+        return 0;
+    }
+}
+
+static void octeon_twsi_write_reg(OcteonTWSIState *t, unsigned int reg,
+                                  uint8_t value)
+{
+    switch (reg) {
+    case OCTEON_TWSI_EOP_DATA:
+        octeon_twsi_write_data(t, value);
+        break;
+    case OCTEON_TWSI_EOP_CTL:
+        octeon_twsi_write_ctl(t, value);
+        break;
+    default:
+        break;
+    }
+}
+
+static uint64_t octeon_twsi_exec(OcteonTWSIState *t, uint64_t value)
+{
+    unsigned int op = (value >> OCTEON_TWSI_SW_OP_SHIFT) & 0xf;
+    unsigned int reg = (value >> OCTEON_TWSI_SW_EOP_IA_SHIFT) & 0x7;
+
+    if (!(value & OCTEON_TWSI_SW_V)) {
+        return value;
+    }
+
+    if (op == OCTEON_TWSI_OP_EOP_IA) {
+        if (value & OCTEON_TWSI_SW_R) {
+            value &= ~OCTEON_TWSI_SW_DATA_MASK;
+            value |= octeon_twsi_read_reg(t, reg);
+        } else {
+            octeon_twsi_write_reg(t, reg, value & 0xff);
+        }
+    }
+
+    return value & ~OCTEON_TWSI_SW_V;
+}
+
+static uint64_t octeon_twsi_read(void *opaque, hwaddr addr, unsigned size)
+{
+    OcteonTWSIState *t = opaque;
+    hwaddr reg = addr & ~7ULL;
+
+    switch (reg) {
+    case OCTEON_TWSI_SW_TWSI:
+        return octeon_read64(t->sw_twsi, addr, size);
+    case OCTEON_TWSI_INT:
+        return octeon_read64(t->int_reg, addr, size);
+    default:
+        return 0;
+    }
+}
+
+static void octeon_twsi_write(void *opaque, hwaddr addr,
+                              uint64_t value, unsigned size)
+{
+    OcteonTWSIState *t = opaque;
+    hwaddr reg = addr & ~7ULL;
+    uint64_t old = 0;
+
+    switch (reg) {
+    case OCTEON_TWSI_SW_TWSI:
+        old = t->sw_twsi;
+        value = octeon_write64(old, addr, value, size);
+        if (size == 4 && !(addr & 4)) {
+            t->sw_twsi = value;
+        } else {
+            t->sw_twsi = octeon_twsi_exec(t, value);
+        }
+        break;
+    case OCTEON_TWSI_INT:
+        old = t->int_reg;
+        t->int_reg = octeon_write64(old, addr, value, size);
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps octeon_twsi_ops = {
+    .read = octeon_twsi_read,
+    .write = octeon_twsi_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static void octeon_twsi_reset_hold(Object *obj, ResetType type)
+{
+    OcteonTWSIState *t = OCTEON_TWSI(obj);
+    OcteonTWSIClass *otc = OCTEON_TWSI_GET_CLASS(obj);
+
+    if (otc->parent_phases.hold) {
+        otc->parent_phases.hold(obj, type);
+    }
+
+    t->sw_twsi = 0;
+    t->int_reg = 0;
+    t->ctl = 0;
+    t->stat = OCTEON_TWSI_STAT_IDLE;
+    t->data = 0;
+    t->slave_addr = 0;
+    t->write_len = 0;
+    t->have_slave = false;
+    t->read_transfer = false;
+    t->addr_phase = false;
+    memset(t->write_buf, 0, sizeof(t->write_buf));
+}
+
+static void octeon_spd_eeprom_reset_hold(Object *obj, ResetType type)
+{
+    OcteonSpdEepromState *eeprom = OCTEON_SPD_EEPROM(obj);
+    OcteonSpdEepromClass *osec = OCTEON_SPD_EEPROM_GET_CLASS(obj);
+
+    if (osec->parent_phases.hold) {
+        osec->parent_phases.hold(obj, type);
+    }
+
+    eeprom->offset = 0;
+}
+
+static void octeon_twsi_realize(DeviceState *dev, Error **errp)
+{
+    static const char *const name[OCTEON_TWSI_COUNT] = {
+        "octeon.twsi0",
+        "octeon.twsi1",
+    };
+    OcteonTWSIState *t = OCTEON_TWSI(dev);
+
+    memory_region_init_io(&t->mmio, OBJECT(dev), &octeon_twsi_ops, t,
+                          name[t->bus], OCTEON_TWSI_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &t->mmio);
+}
+
+static void octeon_twsi_init(Object *obj)
+{
+    OcteonTWSIState *t = OCTEON_TWSI(obj);
+
+    t->stat = OCTEON_TWSI_STAT_IDLE;
+}
+
+static void octeon_twsi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    OcteonTWSIClass *otc = OCTEON_TWSI_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = octeon_twsi_realize;
+    dc->user_creatable = false;
+    resettable_class_set_parent_phases(rc, NULL, octeon_twsi_reset_hold, NULL,
+                                       &otc->parent_phases);
+}
+
+static void octeon_spd_eeprom_class_init(ObjectClass *klass,
+                                          const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    OcteonSpdEepromClass *osec = OCTEON_SPD_EEPROM_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->user_creatable = false;
+    resettable_class_set_parent_phases(rc, NULL,
+                                       octeon_spd_eeprom_reset_hold, NULL,
+                                       &osec->parent_phases);
+}
+
+static const TypeInfo octeon_twsi_type_info = {
+    .name = TYPE_OCTEON_TWSI,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(OcteonTWSIState),
+    .instance_init = octeon_twsi_init,
+    .class_size = sizeof(OcteonTWSIClass),
+    .class_init = octeon_twsi_class_init,
+};
+
+static const TypeInfo octeon_spd_eeprom_type_info = {
+    .name = TYPE_OCTEON_SPD_EEPROM,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(OcteonSpdEepromState),
+    .class_size = sizeof(OcteonSpdEepromClass),
+    .class_init = octeon_spd_eeprom_class_init,
+};
+
+static void octeon_twsi_register_types(void)
+{
+    type_register_static(&octeon_twsi_type_info);
+    type_register_static(&octeon_spd_eeprom_type_info);
+}
+
+type_init(octeon_twsi_register_types)
+
+void octeon_init_twsi(OcteonState *s)
+{
+    static const uint64_t base[OCTEON_TWSI_COUNT] = {
+        OCTEON_TWSI0_BASE,
+        OCTEON_TWSI1_BASE,
+    };
+    unsigned int i;
+
+    for (i = 0; i < OCTEON_TWSI_COUNT; i++) {
+        DeviceState *dev = qdev_new(TYPE_OCTEON_TWSI);
+        OcteonTWSIState *t = OCTEON_TWSI(dev);
+
+        t->board = s;
+        t->bus = i;
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base[i]);
+    }
+}
diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 133b3636a0..9388bc005b 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -64,7 +64,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 
 /*
  * The physical layout follows U-Boot's generic Octeon III
- * OCTEON_MAX_PHY_MEM_SIZE value. Keep 1 GiB as the tested default.
+ * OCTEON_MAX_PHY_MEM_SIZE value. The synthesized DDR4 SPD below accepts
+ * power-of-two RAM sizes from 256 MiB through 32 GiB. Keep 1 GiB as the
+ * tested default.
  */
 #define OCTEON_DEFAULT_RAM_SIZE     (1 * GiB)
 #define OCTEON_MAX_PHY_MEM_SIZE     (512 * GiB)
@@ -1884,6 +1886,8 @@ static void mips_octeon_init(MachineState *machine)
         exit(1);
     }
 
+    octeon_validate_ram_size(machine->ram_size);
+    octeon_init_spd(s);
     octeon_map_ram(s);
     octeon_init_flash(s);
     octeon_init_mio_boot_loc(s);
@@ -1902,6 +1906,8 @@ static void mips_octeon_init(MachineState *machine)
                                 &s->intc->ciu3);
 
     octeon_init_uart(s);
+    octeon_init_twsi(s);
+
     memory_region_init_io(&s->csr_bank->csr, OBJECT(s->csr_bank),
                           &octeon_csr_ops, s,
                           "octeon.csr", OCTEON_CSR_SIZE);
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index fbe4875d66..e9826f1713 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -20,6 +20,10 @@
 #define OCTEON_CIU3_IDT_COUNT       (OCTEON_MAX_CPUS * 4)
 #define OCTEON_MIO_BOOT_REG_CFG_COUNT 8
 #define OCTEON_MIO_BOOT_LOC_SIZE    0x100
+#define OCTEON_TWSI_COUNT           2
+#define OCTEON_TWSI_STAT_IDLE       0xf8
+#define OCTEON_SPD_EEPROM_SIZE      139
+#define OCTEON_SPD_EEPROM_COUNT     1
 
 typedef enum OcteonIRQ {
     OCTEON_IRQ_UART,
@@ -44,6 +48,8 @@ typedef struct OcteonCPUState {
     bool boot_cpu;
 } OcteonCPUState;
 
+typedef struct OcteonSpdEepromState OcteonSpdEepromState;
+
 struct OcteonState {
     MachineState *machine;
     Clock *cpuclk;
@@ -65,6 +71,7 @@ struct OcteonState {
     OcteonRstState *rst;
     OcteonIntcState *intc;
     OcteonCsrBankState *csr_bank;
+    OcteonSpdEepromState *spd[OCTEON_SPD_EEPROM_COUNT];
     SerialMM *uart;
     MemoryRegion uart_alias;
     MemoryRegion uart_tx;
@@ -81,4 +88,8 @@ void octeon_reg_store(GHashTable *regs, uint64_t reg, uint64_t value);
 bool octeon_csr_lookup(OcteonState *s, uint64_t reg, uint64_t *value);
 void octeon_irq_set(void *opaque, int irq, int level);
 
+void octeon_validate_ram_size(uint64_t ram_size);
+void octeon_init_spd(OcteonState *s);
+void octeon_init_twsi(OcteonState *s);
+
 #endif
-- 
2.56.0


