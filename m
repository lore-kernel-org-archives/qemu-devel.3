Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D2FC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 19:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT5cp-00025y-1a; Thu, 25 Jan 2024 14:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vLmyZQwKCi8YLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1rT5cn-00024j-K8
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:42:57 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vLmyZQwKCi8YLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1rT5cj-0005An-HM
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:42:56 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5efe82b835fso123272747b3.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 11:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706211772; x=1706816572; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=v41Sb6SJz/bKHIxAFv4GMyTkmF8mwGxzXgIN4wdQ8Cs=;
 b=qJq6UVwabEpjKdBs14JlYHU1vFMVTRmquTDb7UBnb1ayyIpxPWjOwIt2zoeiY3EUbV
 JzWINT7KejaRz3FRhRLK40nqaQJcUPn8+QwbCtA5N/GIH6TLzWcT3hqs49qKnHMahTwW
 QbXtuZC85yf/NECd66+2w3yvy7lQio1Opnt7tBCdkLaCPggBs8alTFrtJMWWccDPiLTF
 aXID/bPwgCRQpdRHJw8EM/lHz+n9rK3YEolIfX4leaAOl8EN1GQgEs/fErnLGO1g/lGH
 I2KE4xdnHqq50kzsVonNSBnWW2jwYy8mCctVYq5ZI1MoKxy3hNte7HRydN29V6x3hSaI
 nPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706211772; x=1706816572;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v41Sb6SJz/bKHIxAFv4GMyTkmF8mwGxzXgIN4wdQ8Cs=;
 b=vSyTmcRWCSNQzvc8jRuxo2fPptptHj3Nc9xoRLfgrqN8wecUT9AeparrZKTOZHFs9U
 /67TdIcfyPp41kJFb9ivj+bInHJhii/R1QLxQaygIv7DYlTYcQvD8ps00xjKdKWTFWzZ
 Kwta4P0/ZjgfLXIq8kVCCjqB1fnL+LZUzNXE8tTDKE67BaInpll6diFHO5M+YEER/iA+
 WV053J88c0ihC3tqvKiv6WqcmJ54GZVct9bzDyMp66IbGHBIuJtPyZHiZKQR79DNaB4+
 pqzwHRyHjQVQ4gQPRyqlGsHbDIcmX/GBpfhr2UWPdr9+VaIendp2Ny0IDws6yrSrShZF
 xxGQ==
X-Gm-Message-State: AOJu0YwlZATTthxdxlJ5HtScLYTfzYJSyqfbiRWInc+eJ/HIhelf5Wp8
 hlwVRHZZl3zoalHwNwmli0A+rNovYz/eVO5zeVpJHx03g5UU2yiHzja57aHCtSABKn3oAUEQZbz
 jOogq101ertXt3Ptt73FEP+mPbA==
X-Google-Smtp-Source: AGHT+IGaqaVImSHyvnseihW9Hiw1zbx/ccqr6UgH0BhrudRuPpXLBS6K3FuuKxkYkSTh2NArJ3a9AMvX3BKJZJzxp14=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a81:99cd:0:b0:5ff:a9fa:2722 with SMTP
 id q196-20020a8199cd000000b005ffa9fa2722mr130382ywg.3.1706211772037; Thu, 25
 Jan 2024 11:42:52 -0800 (PST)
Date: Thu, 25 Jan 2024 19:42:39 +0000
In-Reply-To: <20240125194247.1589037-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240125194247.1589037-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125194247.1589037-2-nabihestefan@google.com>
Subject: [PATCH v15 1/9] hw/misc: Add Nuvoton's PCI Mailbox Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3vLmyZQwKCi8YLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Hao Wu <wuhaotsh@google.com>

The PCI Mailbox Module is a high-bandwidth communcation module
between a Nuvoton BMC and CPU. It features 16KB RAM that are both
accessible by the BMC and core CPU. and supports interrupt for
both sides.

This patch implements the BMC side of the PCI mailbox module.
Communication with the core CPU is emulated via a chardev and
will be in a follow-up patch.

This patch also adds documentation on the PCIe Protocol used
by the chardev device.

Change-Id: Iaca22f81c4526927d437aa367079ed038faf43f2
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 docs/specs/pci_mbox_chardev.rst    | 159 ++++++++++++++
 hw/misc/meson.build                |   1 +
 hw/misc/npcm7xx_pci_mbox.c         | 335 +++++++++++++++++++++++++++++
 hw/misc/trace-events               |   5 +
 include/hw/misc/npcm7xx_pci_mbox.h |  81 +++++++
 5 files changed, 581 insertions(+)
 create mode 100644 docs/specs/pci_mbox_chardev.rst
 create mode 100644 hw/misc/npcm7xx_pci_mbox.c
 create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h

diff --git a/docs/specs/pci_mbox_chardev.rst b/docs/specs/pci_mbox_chardev.rst
new file mode 100644
index 0000000000..2a26e6bb8f
--- /dev/null
+++ b/docs/specs/pci_mbox_chardev.rst
@@ -0,0 +1,159 @@
+Remote PCIe Protocol
+====================
+
+Design
+------
+The communication or this device is done via a chardev. It is bidirectional:
+QEMU can send requests to devices and the device can send MSI/DMA requests
+to QEMU. All registers are encoded in Little Endian.
+
+To distinguish between the two types of messages, any message with an error
+code described below is a response, otherwise it is a request. The remote
+PCIe device is responsible for guaranteeing the messages sent out are
+integrated.
+
+The highest bit for the first byte reflects whether a message is a request
+or response - 0 for request and 1 for response.
+
+For responses, the rest of the bits reflect the error code.
+For requests, the rest of the bit is the command code specified below.
+
+
+Initialization
+--------------
+During initialization of the remote PCIe device in QEMU, it needs to specify
+a few configuration parameters. The PCIe connector is responsible for
+getting these configuration parameters and passing them in as QDev
+properties
+The fields include:
+ 1. PCI endpoint device identifiers (google3/platforms/asic_sw/proto/device_identifiers.proto).
+     a. Vendor ID
+     b. Device ID
+     c. Subsystem Vendor ID
+     d. Subsystem Device ID
+     e. Class Code
+     f. Subclass
+     g. Programming Interface
+     h. Revision ID
+ 2. Number of BARs and the size of each BAR
+ 3. Whether DMA is supported.
+ 4. Number of MSI vectors supported (must be power of 2, up to 32)
+
+Request and Reponse Breakdowns
+------------------------------
+PCI Endpoint R/W Request
+~~~~~~~~~~~~~~~~~~~~~~~~
+QEMU can send this request to endpoint.
+ReadData
+Request:
++------+------+--------+-----------+-----------+
+| Byte | 0    | 0x1    | 0x2 ~ 0x9 | 0xa       |
+| Data | 0x01 | bar_no | offset    | read_size |
++------+------+--------+-----------+-----------+
+(read_size in number of bytes, must be between 1 and 8)
+Response:
+Success:
++------+------+-------------------+
+| Byte | 0    | 0x1 ~ read_size+1 |
+| Data | 0x80 | data              |
++------+------+-------------------+
+Failure:
++------+-------------------+
+| Byte | 0                 |
+| Data | 0x80 | error_code |
++------+-------------------+
+
+WriteData
+Request:
++------+------+--------+-----------+------------+------+
+| Byte | 0    | 0x1    | 0x2 ~ 0x9 | 0xa        | 0xb~ |
+| Data | 0x02 | bar_no | offset    | write_size | data |
++------+------+--------+-----------+------------+------+
+(write_size in number of bytes, must be between 1 and 8)
+Response:
++------+-------------------+
+| Byte | 0                 |
+| Data | 0x80 | error_code |
++------+-------------------+
+
+PCIe DMA Request
+~~~~~~~~~~~~~~~~
+The endpoint can send this request to QEMU.
+ReadData
+Request:
++------+------+-----------+------------+
+| Byte | 0    | 0x1 ~ 0x8 | 0x9 ~ 0x10 |
+| Data | 0x03 | address   | read_size  |
++------+------+-----------+------------+
+Response:
+Success:
++------+------+-------------------+
+| Byte | 0    | 0x1 ~ read_size+1 |
+| Data | 0x80 | data              |
++------+------+-------------------+
+Failure:
++------+-------------------+
+| Byte | 0                 |
+| Data | 0x80 | error_code |
++------+-------------------+
+
+WriteData
+Request:
++------+------+-----------+-------------+-------+
+| Byte | 0    | 0x1 ~ 0x8 | 0x9 ~ 0x10  | 0x11~ |
+| Data | 0x04 | address   | write_size  | data  |
++------+------+-----------+-------------+-------+
+Response:
++------+-------------------+
+| Byte | 0                 |
+| Data | 0x80 | error_code |
++------+-------------------+
+
+PCIe MSI/MSIx request
+~~~~~~~~~~~~~~~~~~~~~
+The endpoint can send this request to QEMU.
+Request:
++------+------+-----------+
+| Byte | 0    | 0x1 ~ 0x4 |
+| Data | 0x05 | VectorNo  |
++------+------+-----------+
+Response:
++------+-------------------+
+| Byte | 0                 |
+| Data | 0x80 | error_code |
++------+-------------------+
+
+PCIe Config Space Read/Write
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+QEMU can send this request to endpoint.
+ReadConfigData
+Request:
++------+------+-----------+------------+
+| Byte | 0    | 0x1 ~ 0x8 | 0x9        |
+| Data | 0x06 | address   | read_size  |
++------+------+-----------+------------+
+(read_size in number of bytes, must be between 1 and 8)
+Response:
+Success:
++------+------+-------------------+
+| Byte | 0    | 0x1 ~ read_size+1 |
+| Data | 0x80 | data              |
++------+------+-------------------+
+Failure:
++------+-------------------+
+| Byte | 0                 |
+| Data | 0x80 | error_code |
++------+-------------------+
+
+WriteConfigData
+Request:
++------+------+-----------+------------+-------+
+| Byte | 0    | 0x1 ~ 0x8 | 0x9        | 0xa~ |
+| Data | 0x07 | address   | write_size | data  |
++------+------+-----------+------------+-------+
+Response:
++------+-------------------+
+| Byte | 0                 |
+| Data | 0x80 | error_code |
++------+-------------------+
+ */
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 2ca2ce4b62..4e7a8f8f1b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -73,6 +73,7 @@ system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm7xx_clk.c',
   'npcm7xx_gcr.c',
   'npcm7xx_mft.c',
+  'npcm7xx_pci_mbox.c',
   'npcm7xx_pwm.c',
   'npcm7xx_rng.c',
 ))
diff --git a/hw/misc/npcm7xx_pci_mbox.c b/hw/misc/npcm7xx_pci_mbox.c
new file mode 100644
index 0000000000..1766166c66
--- /dev/null
+++ b/hw/misc/npcm7xx_pci_mbox.c
@@ -0,0 +1,335 @@
+/*
+ * Nuvoton NPCM7xx PCI Mailbox Module
+ *
+ * Copyright 2024 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "chardev/char-fe.h"
+#include "hw/irq.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/misc/npcm7xx_pci_mbox.h"
+#include "hw/registerfields.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qemu/bitops.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/units.h"
+#include "trace.h"
+
+REG32(NPCM7XX_PCI_MBOX_BMBXSTAT, 0x00);
+REG32(NPCM7XX_PCI_MBOX_BMBXCTL, 0x04);
+REG32(NPCM7XX_PCI_MBOX_BMBXCMD, 0x08);
+
+enum NPCM7xxPCIMBoxOperation {
+    NPCM7XX_PCI_MBOX_OP_READ = 1,
+    NPCM7XX_PCI_MBOX_OP_WRITE,
+};
+
+#define NPCM7XX_PCI_MBOX_OFFSET_BYTES 8
+
+/* Response code */
+#define NPCM7XX_PCI_MBOX_OK 0
+#define NPCM7XX_PCI_MBOX_INVALID_OP 0xa0
+#define NPCM7XX_PCI_MBOX_INVALID_SIZE 0xa1
+#define NPCM7XX_PCI_MBOX_UNSPECIFIED_ERROR 0xff
+
+#define NPCM7XX_PCI_MBOX_NR_CI 8
+#define NPCM7XX_PCI_MBOX_CI_MASK MAKE_64BIT_MASK(0, NPCM7XX_PCI_MBOX_NR_CI)
+
+static void npcm7xx_pci_mbox_update_irq(NPCM7xxPCIMBoxState *s)
+{
+    /* We should send an interrupt when one of the CIE and CIF are both 1. */
+    if (s->regs[R_NPCM7XX_PCI_MBOX_BMBXSTAT] &
+        s->regs[R_NPCM7XX_PCI_MBOX_BMBXCTL] &
+        NPCM7XX_PCI_MBOX_CI_MASK) {
+        qemu_irq_raise(s->irq);
+        trace_npcm7xx_pci_mbox_irq(1);
+    } else {
+        qemu_irq_lower(s->irq);
+        trace_npcm7xx_pci_mbox_irq(0);
+    }
+}
+
+static void npcm7xx_pci_mbox_send_response(NPCM7xxPCIMBoxState *s, uint8_t code)
+{
+    qemu_chr_fe_write(&s->chr, &code, 1);
+    if (code == NPCM7XX_PCI_MBOX_OK && s->op == NPCM7XX_PCI_MBOX_OP_READ) {
+        qemu_chr_fe_write(&s->chr, (uint8_t *)(&s->data), s->size);
+    }
+}
+
+static void npcm7xx_pci_mbox_handle_read(NPCM7xxPCIMBoxState *s)
+{
+    uint8_t offset_bytes[4];
+    MemTxResult r = memory_region_dispatch_read(
+        &s->ram, s->offset, &s->data, MO_LE | size_memop(s->size),
+        MEMTXATTRS_UNSPECIFIED);
+
+    stl_le_p(offset_bytes, r);
+    npcm7xx_pci_mbox_send_response(s, offset_bytes[0]);
+}
+
+static void npcm7xx_pci_mbox_handle_write(NPCM7xxPCIMBoxState *s)
+{
+    uint8_t offset_bytes[4];
+    MemTxResult r = memory_region_dispatch_write(
+        &s->ram, s->offset, s->data, MO_LE | size_memop(s->size),
+        MEMTXATTRS_UNSPECIFIED);
+
+    stl_le_p(offset_bytes, r);
+    npcm7xx_pci_mbox_send_response(s, offset_bytes[0]);
+}
+
+/* 
+ * This device uses Little Endian protocol
+ * For more information about the details of it, look at pci_mbox_chardev.rst
+ */
+static void npcm7xx_pci_mbox_receive_char(NPCM7xxPCIMBoxState *s, uint8_t byte)
+{
+    switch (s->state) {
+    case NPCM7XX_PCI_MBOX_STATE_IDLE:
+        switch (byte) {
+        case NPCM7XX_PCI_MBOX_OP_READ:
+        case NPCM7XX_PCI_MBOX_OP_WRITE:
+            s->op = byte;
+            s->state = NPCM7XX_PCI_MBOX_STATE_OFFSET;
+            s->offset = 0;
+            s->receive_count = 0;
+            break;
+
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "received invalid op type: 0x%" PRIx8, byte);
+            npcm7xx_pci_mbox_send_response(s, NPCM7XX_PCI_MBOX_INVALID_OP);
+            break;
+        }
+        break;
+
+    case NPCM7XX_PCI_MBOX_STATE_OFFSET:
+        s->offset += (uint64_t)byte << (s->receive_count * BITS_PER_BYTE);
+        if (++s->receive_count >= NPCM7XX_PCI_MBOX_OFFSET_BYTES) {
+            s->state = NPCM7XX_PCI_MBOX_STATE_SIZE;
+        }
+        break;
+
+    case NPCM7XX_PCI_MBOX_STATE_SIZE:
+        s->size = byte;
+        if (s->size < 1 || s->size > sizeof(uint64_t)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "received invalid size: %u", byte);
+            npcm7xx_pci_mbox_send_response(s, NPCM7XX_PCI_MBOX_INVALID_SIZE);
+            s->state = NPCM7XX_PCI_MBOX_STATE_IDLE;
+            break;
+        }
+        if (s->op == NPCM7XX_PCI_MBOX_OP_READ) {
+            npcm7xx_pci_mbox_handle_read(s);
+            s->state = NPCM7XX_PCI_MBOX_STATE_IDLE;
+        } else {
+            s->receive_count = 0;
+            s->data = 0;
+            s->state = NPCM7XX_PCI_MBOX_STATE_DATA;
+        }
+        break;
+
+    case NPCM7XX_PCI_MBOX_STATE_DATA:
+        g_assert(s->op == NPCM7XX_PCI_MBOX_OP_WRITE);
+        s->data += (uint64_t)byte << (s->receive_count * BITS_PER_BYTE);
+        if (++s->receive_count >= s->size) {
+            npcm7xx_pci_mbox_handle_write(s);
+            s->state = NPCM7XX_PCI_MBOX_STATE_IDLE;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t npcm7xx_pci_mbox_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    NPCM7xxPCIMBoxState *s = NPCM7XX_PCI_MBOX(opaque);
+    uint16_t value = 0;
+
+    if (offset / sizeof(uint32_t) >= NPCM7XX_PCI_MBOX_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
+                      __func__, offset);
+        return 0;
+    }
+
+    value = s->regs[offset / sizeof(uint32_t)];
+    trace_npcm7xx_pci_mbox_read(DEVICE(s)->canonical_path, offset, value, size);
+    return value;
+}
+
+static void npcm7xx_pci_mbox_write(void *opaque, hwaddr offset,
+                              uint64_t v, unsigned size)
+{
+    NPCM7xxPCIMBoxState *s = NPCM7XX_PCI_MBOX(opaque);
+
+    trace_npcm7xx_pci_mbox_write(DEVICE(s)->canonical_path, offset, v, size);
+    switch (offset) {
+    case A_NPCM7XX_PCI_MBOX_BMBXSTAT:
+        /* Clear bits that are 1. */
+        s->regs[R_NPCM7XX_PCI_MBOX_BMBXSTAT] &= ~v;
+        break;
+
+    case A_NPCM7XX_PCI_MBOX_BMBXCTL:
+        s->regs[R_NPCM7XX_PCI_MBOX_BMBXCTL] = v;
+        break;
+
+    case A_NPCM7XX_PCI_MBOX_BMBXCMD:
+        /* Set the bits that are 1. */
+        s->regs[R_NPCM7XX_PCI_MBOX_BMBXCMD] |= v;
+        /* TODO: Set interrupt to host. */
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
+                      __func__, offset);
+    }
+    npcm7xx_pci_mbox_update_irq(s);
+}
+
+static const struct MemoryRegionOps npcm7xx_pci_mbox_ops = {
+    .read       = npcm7xx_pci_mbox_read,
+    .write      = npcm7xx_pci_mbox_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid      = {
+        .min_access_size        = 4,
+        .max_access_size        = 4,
+        .unaligned              = false,
+    },
+};
+
+static void npcm7xx_pci_mbox_enter_reset(Object *obj, ResetType type)
+{
+    NPCM7xxPCIMBoxState *s = NPCM7XX_PCI_MBOX(obj);
+
+    memset(s->regs, 0, 4 * NPCM7XX_PCI_MBOX_NR_REGS);
+    s->state = NPCM7XX_PCI_MBOX_STATE_IDLE;
+    s->receive_count = 0;
+}
+
+static void npcm7xx_pci_mbox_hold_reset(Object *obj)
+{
+    NPCM7xxPCIMBoxState *s = NPCM7XX_PCI_MBOX(obj);
+
+    qemu_irq_lower(s->irq);
+}
+
+static int can_receive(void *opaque)
+{
+    return 1;
+}
+
+static void receive(void *opaque, const uint8_t *buf, int size)
+{
+    NPCM7xxPCIMBoxState *s = NPCM7XX_PCI_MBOX(opaque);
+    int i;
+
+    for (i = 0; i < size; ++i) {
+        npcm7xx_pci_mbox_receive_char(s, buf[i]);
+    }
+}
+
+static void chr_event(void *opaque, QEMUChrEvent event)
+{
+    switch (event) {
+    case CHR_EVENT_OPENED:
+    case CHR_EVENT_CLOSED:
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void npcm7xx_pci_mbox_init(Object *obj)
+{
+    NPCM7xxPCIMBoxState *s = NPCM7XX_PCI_MBOX(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_ram_device_ptr(&s->ram, obj, "pci-mbox-ram",
+                                      NPCM7XX_PCI_MBOX_RAM_SIZE, s->content);
+    memory_region_init_io(&s->iomem, obj, &npcm7xx_pci_mbox_ops, s,
+                          "pci-mbox-iomem", 4 * KiB);
+    sysbus_init_mmio(sbd, &s->ram);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void npcm7xx_pci_mbox_realize(DeviceState *dev, Error **errp)
+{
+    NPCM7xxPCIMBoxState *s = NPCM7XX_PCI_MBOX(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, can_receive, receive,
+                             chr_event, NULL, OBJECT(dev), NULL, true);
+}
+
+static const VMStateDescription vmstate_npcm7xx_pci_mbox = {
+    .name = "npcm7xx-pci-mbox-module",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, NPCM7xxPCIMBoxState,
+                             NPCM7XX_PCI_MBOX_NR_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+// The chardev device is expected to run using Little Endian protocol
+// All requests and responses should be expected to be in LE, and if
+// not should be translated into LE to assure proper working of the device.
+static Property npcm7xx_pci_mbox_properties[] = {
+    DEFINE_PROP_CHR("chardev", NPCM7xxPCIMBoxState, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void npcm7xx_pci_mbox_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "NPCM7xx PCI Mailbox Controller";
+    dc->vmsd = &vmstate_npcm7xx_pci_mbox;
+    dc->realize = npcm7xx_pci_mbox_realize;
+    rc->phases.enter = npcm7xx_pci_mbox_enter_reset;
+    rc->phases.hold = npcm7xx_pci_mbox_hold_reset;
+    device_class_set_props(dc, npcm7xx_pci_mbox_properties);
+}
+
+static const TypeInfo npcm7xx_pci_mbox_info = {
+    .name               = TYPE_NPCM7XX_PCI_MBOX,
+    .parent             = TYPE_SYS_BUS_DEVICE,
+    .instance_size      = sizeof(NPCM7xxPCIMBoxState),
+    .class_init         = npcm7xx_pci_mbox_class_init,
+    .instance_init      = npcm7xx_pci_mbox_init,
+};
+
+static void npcm7xx_pci_mbox_register_type(void)
+{
+    type_register_static(&npcm7xx_pci_mbox_info);
+}
+type_init(npcm7xx_pci_mbox_register_type);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 5f5bc92222..d9fd316602 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -152,6 +152,11 @@ npcm7xx_pwm_write(const char *id, uint64_t offset, uint32_t value) "%s offset: 0
 npcm7xx_pwm_update_freq(const char *id, uint8_t index, uint32_t old_value, uint32_t new_value) "%s pwm[%u] Update Freq: old_freq: %u, new_freq: %u"
 npcm7xx_pwm_update_duty(const char *id, uint8_t index, uint32_t old_value, uint32_t new_value) "%s pwm[%u] Update Duty: old_duty: %u, new_duty: %u"
 
+# npcm7xx_pci_mbox.c
+npcm7xx_pci_mbox_read(const char *id, uint64_t offset, uint64_t value, unsigned size) "%s offset: 0x%04" PRIx64 " value: 0x%02" PRIx64 " size: %u"
+npcm7xx_pci_mbox_write(const char *id, uint64_t offset, uint64_t value, unsigned size) "%s offset: 0x%04" PRIx64 " value: 0x%02" PRIx64 " size: %u"
+npcm7xx_pci_mbox_irq(int irq_level) "irq level: %d"
+
 # stm32f4xx_syscfg.c
 stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interrupt: GPIO: %d, Line: %d; Level: %d"
 stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
diff --git a/include/hw/misc/npcm7xx_pci_mbox.h b/include/hw/misc/npcm7xx_pci_mbox.h
new file mode 100644
index 0000000000..e595fbcc70
--- /dev/null
+++ b/include/hw/misc/npcm7xx_pci_mbox.h
@@ -0,0 +1,81 @@
+/*
+ * Nuvoton NPCM7xx PCI Mailbox Module
+ *
+ * Copyright 2021 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+#ifndef NPCM7XX_PCI_MBOX_H
+#define NPCM7XX_PCI_MBOX_H
+
+#include "chardev/char-fe.h"
+#include "exec/memory.h"
+#include "hw/clock.h"
+#include "hw/irq.h"
+#include "hw/pci/pci.h"
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define NPCM7XX_PCI_MBOX_RAM_SIZE 0x4000
+
+#define NPCM7XX_PCI_VENDOR_ID   0x1050
+#define NPCM7XX_PCI_DEVICE_ID   0x0750
+#define NPCM7XX_PCI_REVISION    0
+#define NPCM7XX_PCI_CLASS_CODE  0xff
+
+typedef enum NPCM7xxPCIMBoxHostState {
+    NPCM7XX_PCI_MBOX_STATE_IDLE,
+    NPCM7XX_PCI_MBOX_STATE_OFFSET,
+    NPCM7XX_PCI_MBOX_STATE_SIZE,
+    NPCM7XX_PCI_MBOX_STATE_DATA,
+} NPCM7xxPCIMBoxHostState ;
+
+/*
+ * Maximum amount of control registers in PCI Mailbox module. Do not increase
+ * this value without bumping vm version.
+ */
+#define NPCM7XX_PCI_MBOX_NR_REGS 3
+
+/**
+ * struct NPCM7xxPciMboxState - PCI Mailbox Device
+ * @parent: System bus device.
+ * @ram: the mailbox RAM memory space
+ * @iomem: Memory region through which registers are accessed.
+ * @content: The content of the PCI mailbox, initialized to 0.
+ * @regs: The MMIO registers.
+ * @chr: The chardev backend used to communicate with core CPU.
+ * @offset: The offset to start transfer.
+ */
+typedef struct NPCM7xxPCIMBoxState {
+    SysBusDevice parent;
+
+    MemoryRegion ram;
+    MemoryRegion iomem;
+
+    qemu_irq irq;
+    uint8_t content[NPCM7XX_PCI_MBOX_RAM_SIZE];
+    uint32_t regs[NPCM7XX_PCI_MBOX_NR_REGS];
+    CharBackend chr;
+
+    /* aux data for receiving host commands. */
+    NPCM7xxPCIMBoxHostState state;
+    uint8_t op;
+    hwaddr offset;
+    uint8_t size;
+    uint64_t data;
+    int receive_count;
+} NPCM7xxPCIMBoxState;
+
+#define TYPE_NPCM7XX_PCI_MBOX "npcm7xx-pci-mbox"
+#define NPCM7XX_PCI_MBOX(obj) \
+    OBJECT_CHECK(NPCM7xxPCIMBoxState, (obj), TYPE_NPCM7XX_PCI_MBOX)
+
+#endif /* NPCM7XX_PCI_MBOX_H */
-- 
2.43.0.429.g432eaa2c6b-goog


