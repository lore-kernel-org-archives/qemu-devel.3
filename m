Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B062DC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ke-0000cE-Gc; Thu, 25 Jul 2024 19:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8KO-0008Ct-DX; Thu, 25 Jul 2024 19:57:03 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8KM-0001CZ-FL; Thu, 25 Jul 2024 19:56:56 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7a115c427f1so299908a12.0; 
 Thu, 25 Jul 2024 16:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951811; x=1722556611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTb81NkoqWLUfM1nShIqv0fnTAhPsvAPyKZVE3fkf8M=;
 b=C/7TaYYnKueIugAPtytxfAdsEwe/7L7jjlnCnmoAWkaqxLxAWmhjtHEdfmZMHx9coN
 Nnv6j6bDtx+Op1EW0OtxTNGP4CYxedTzBK7FOU+SB6W0yr06TSynEVTqR4dXTQx9LYN6
 A8aCBTZHt1MQScHcrl6w4tRONrzi8B8ehrtk/M4jzed2yMTAW4sG/j1PmEPnzEsaDzz1
 jrEcfiiT2HiB55QUT/0qqkpRJMf6nXmtP28CTxkGyRIJlD1l3cofciLd51kyuf72mP+V
 /bXmf33FNtnNoXXWfHtafKfXyF4OvJCV43F694lsHd/Y+7HvhI36Z9JJ8otUsJZdVvJ6
 jCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951811; x=1722556611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTb81NkoqWLUfM1nShIqv0fnTAhPsvAPyKZVE3fkf8M=;
 b=f02c6y6dX8Xvf30kRMlTvu+vnIwLv1QSqxHjpxTIBCx7JthpvQT2Jsh1f8LiN1t/oO
 JYM1rqiKSghoBzHmGGLlW/jv+6+tO+w3d3VI9NNdYMNG5iCLPHnn9V0R1PtwSVrJsS9+
 ARwsYtzS2RQ6kw2y7GTIX/x6e0YCig9I/FHHSEw0XrL9epXXryRUs3tVwIOJ3NSkMohn
 F6PY+KhOWrxoOuGVuIGCNv8iU7bRS6yxXOZwB4bJ7khglOV2Y2uvN67mVQUJA9Fn0swb
 E8aPk+u3qv/SdtvXa9poX3dBsrzfI0cLeKznXjPMAXN+9KHhPCv50Q6FJfh09zPMniRu
 ZzcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULOnXyHwroIRHg0tLQBPdUW04hhIJLxTCYyTvhPFvPm2gTpPmfdf4B7m1+5Gct3d6Hk22lmAgroJ+P8ST9t4XMBN8C
X-Gm-Message-State: AOJu0YzJEme67S+bQwOGq1KiMYPxijbLZ98OWj7D0RDfh0Zh1Zr30/95
 HJElVZmd8+2uCynpm1vkxV7L4RGUfq7U+qsigSizshaK07OUOf0T5MA5uA==
X-Google-Smtp-Source: AGHT+IFIXkS5lEuUkbatPdVhfAqAPzDbfjcGJlw5F45Xpn2l8xNlu4JGcKd1AjlSoKf2xXg2LxYZ8w==
X-Received: by 2002:a17:90a:9e2:b0:2ca:7f1f:9ae5 with SMTP id
 98e67ed59e1d1-2cf2ea0d384mr3679678a91.19.1721951810930; 
 Thu, 25 Jul 2024 16:56:50 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PULL 41/96] tests/qtest: Add pnv-spi-seeprom qtest
Date: Fri, 26 Jul 2024 09:53:14 +1000
Message-ID: <20240725235410.451624-42-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

In this commit Write a qtest pnv-spi-seeprom-test to check the
SPI transactions between spi controller and seeprom device.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Acked-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/meson.build            |   1 +
 tests/qtest/pnv-spi-seeprom-test.c | 110 +++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 tests/qtest/pnv-spi-seeprom-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index e7ab2a4312..2f0d3ef080 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -171,6 +171,7 @@ qtests_ppc64 = \
   qtests_ppc + \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-test'] : []) +               \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test'] : []) +           \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
   (slirp.found() ? ['pxe-test'] : []) +              \
diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
new file mode 100644
index 0000000000..57f20af76e
--- /dev/null
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -0,0 +1,110 @@
+/*
+ * QTest testcase for PowerNV 10 Seeprom Communications
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <unistd.h>
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bswap.h"
+#include "hw/ssi/pnv_spi_regs.h"
+#include "pnv-xscom.h"
+
+#define FLASH_SIZE              (512 * 1024)
+#define SPIC2_XSCOM_BASE        0xc0040
+
+/* To transmit READ opcode and address */
+#define READ_OP_TDR_DATA        0x0300010000000000
+/*
+ * N1 shift - tx 4 bytes (transmit opcode and address)
+ * N2 shift - tx and rx 8 bytes.
+ */
+#define READ_OP_COUNTER_CONFIG  0x2040000000002b00
+/* SEQ_OP_SELECT_RESPONDER - N1 Shift - N2 Shift * 5 - SEQ_OP_STOP */
+#define READ_OP_SEQUENCER       0x1130404040404010
+
+/* To transmit WREN(Set Write Enable Latch in status0 register) opcode */
+#define WRITE_OP_WREN           0x0600000000000000
+/* To transmit WRITE opcode, address and data */
+#define WRITE_OP_TDR_DATA       0x0300010012345678
+/* N1 shift - tx 8 bytes (transmit opcode, address and data) */
+#define WRITE_OP_COUNTER_CONFIG 0x4000000000002000
+/* SEQ_OP_SELECT_RESPONDER - N1 Shift - SEQ_OP_STOP */
+#define WRITE_OP_SEQUENCER      0x1130100000000000
+
+static void pnv_spi_xscom_write(QTestState *qts, const PnvChip *chip,
+        uint32_t reg, uint64_t val)
+{
+    uint32_t pcba = SPIC2_XSCOM_BASE + reg;
+    qtest_writeq(qts, pnv_xscom_addr(chip, pcba), val);
+}
+
+static uint64_t pnv_spi_xscom_read(QTestState *qts, const PnvChip *chip,
+        uint32_t reg)
+{
+    uint32_t pcba = SPIC2_XSCOM_BASE + reg;
+    return qtest_readq(qts, pnv_xscom_addr(chip, pcba));
+}
+
+static void spi_seeprom_transaction(QTestState *qts, const PnvChip *chip)
+{
+    /* SPI transactions to SEEPROM to read from SEEPROM image */
+    pnv_spi_xscom_write(qts, chip, SPI_CTR_CFG_REG, READ_OP_COUNTER_CONFIG);
+    pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, READ_OP_SEQUENCER);
+    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, READ_OP_TDR_DATA);
+    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, 0);
+    /* Read 5*8 bytes from SEEPROM at 0x100 */
+    uint64_t rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    g_test_message("RDR READ = 0x%" PRIx64, rdr_val);
+    rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    g_test_message("RDR READ = 0x%" PRIx64, rdr_val);
+
+    /* SPI transactions to SEEPROM to write to SEEPROM image */
+    pnv_spi_xscom_write(qts, chip, SPI_CTR_CFG_REG, WRITE_OP_COUNTER_CONFIG);
+    /* Set Write Enable Latch bit of status0 register */
+    pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, WRITE_OP_SEQUENCER);
+    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, WRITE_OP_WREN);
+    /* write 8 bytes to SEEPROM at 0x100 */
+    pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, WRITE_OP_SEQUENCER);
+    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, WRITE_OP_TDR_DATA);
+}
+
+static void test_spi_seeprom(const void *data)
+{
+    const PnvChip *chip = data;
+    QTestState *qts = NULL;
+    g_autofree char *tmp_path = NULL;
+    int ret;
+    int fd;
+
+    /* Create a temporary raw image */
+    fd = g_file_open_tmp("qtest-seeprom-XXXXXX", &tmp_path, NULL);
+    g_assert(fd >= 0);
+    ret = ftruncate(fd, FLASH_SIZE);
+    g_assert(ret == 0);
+    close(fd);
+
+    qts = qtest_initf("-machine powernv10 -smp 2,cores=2,"
+                      "threads=1 -accel tcg,thread=single -nographic "
+                      "-blockdev node-name=pib_spic2,driver=file,"
+                      "filename=%s -device 25csm04,bus=pnv-spi-bus.2,cs=0,"
+                      "drive=pib_spic2", tmp_path);
+    spi_seeprom_transaction(qts, chip);
+    qtest_quit(qts);
+    unlink(tmp_path);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
+            pnv_chips[3].cpu_model);
+    qtest_add_data_func(tname, &pnv_chips[3], test_spi_seeprom);
+    g_free(tname);
+    return g_test_run();
+}
-- 
2.45.2


