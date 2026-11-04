Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F53606A33F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cz8g6Qhe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOaDw-00052p-1Y; Wed, 04 Nov 2026 07:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conti.manuele@gmail.com>)
 id 1xOaDu-00052H-GC
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 07:36:14 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conti.manuele@gmail.com>)
 id 1xOaDs-0004mv-H3
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 07:36:14 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so4743555e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 04:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793795771; x=1794400571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OyObsbaRoinsyaD298+5GRQ7fKlPM3BANbHWI67fVUw=;
 b=cz8g6Qhe9i+iymaonLabMKXpNMbQJaUyfVgkohIPkzXfR6JcyNaRlCYNUL+buANyPf
 7kLC/eB5h6b9bkRPto9g7glqbeCHfJ4uKNphNbZ7prjN7xpE/17QV74Kmvy9Ak5YRYL/
 sfA0o+u1Boe+au6ILUSwVL8HmJB6bBwXNFWCC7/NQXYKX0xUB2gv44RhAC9zlmk0rVm/
 X1qlBvxoFTWFoq3uZoBgvIEwg0Udu6MquoyP6GPkIWktL/6PA0wa4OGcf846ixmGeQkI
 8Ea1KMq0LF2vajsoq4DCLZC7SUY8PtPCRX36ec9rO3qq5OBml36I5jgAOheBvYDmyxnI
 Ih6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795771; x=1794400571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OyObsbaRoinsyaD298+5GRQ7fKlPM3BANbHWI67fVUw=;
 b=a2eMvEWgi51u4Jtx9G7OWzuXLS+dAwERAAGb/z9q141eu6oQVsPuYXHgtVA5YUxC3u
 w9s9V+/aYSqYMA9WtDAxjCpjUOivBklSW6zska1C/FrhqkGkIZLD5K/FS5CBbwkJl7KU
 wYEv9+NGdztEPl4mhHN2EeBYHZYS45YuTlOGqdrGaGU/PVSyF7a1KRrpBHSJFDAwJsZM
 ZbxCUugPQhjoQPJrbaz+83M1QQLTPX9AvORA7lvsoCnzF5vLQAXG3izkIMXimHCSYb8f
 Fj5AQjUdIqSLnGX5BgUWFtCRigsbH7zhGY474GMH9f5g/P7iYLehxpHxU/Xd2PPMlOEw
 84ug==
X-Gm-Message-State: APuU4Z+/y0ayI22ZD/7BLbJjtLkWEMDNpakPHGpX+bGzUojvtW7PFe0n
 fc2qB9YekQLzoDBp9elhkglu4+SfVu+537kdaf508XoLveEEpN+vOVUHej0TGw==
X-Gm-Gg: AYBFou33/g8hs7YJ9XIqzH15oh4rGR/FngoumhSGOH9v3BgC4zYGo4FYOZS4Zbgcm4S
 0Wag0OTY3x9P2LCdAZ0yvuQGKamtjR4uANOLtCutMg/g17rPqDXeP+59WgSJX+ktICfk61tqs2j
 zU1xxJd1b+yEeFIc0RLOBQVpgLsbUJuhsswTI9OPGOteq/Vd6ZnW7anJHLotxPxxi+cx1de+SYj
 xEwuElLitYnyV9P3JoxiKuOOK+I8xeMtWOGZyOdsGTw/wQq6wnpV0R+I122MouWS8CoIxHLsS+D
 OkF/a7ORohj2kKqlYCXqJfVhvFsK15wotq1bG6vqIcgUeg9smnnwfmy2k6Hrq8nBPejpoEwgFMc
 p0wM++iUPu60hjxqt07yf4p4MWm/xEpv57ysD+UmsDcfofvhTqFSE2SnurbBoapB4GfsL/2AMXb
 AbrjlgYCRcEDZwy7nAX0YAuo47Oi3Lksn1wWXxHaVp5u/DA5OdFNMQpomjGPmEzXeAqR9wn3php
 hByot/8+QlLyBxPWd7dzMTJ5J/BNGIiWuvPZ8sYXEKkIu2fp4JjvGiWBS7KesRbBGuwbSAA+MCF
 oxIPNcDmrUm+0Wglnon/sMsBO0HQnFcaglpo3VhUK2cWaR/0P4b7+CnU/Igp/9Dhs9MYKsQ=
X-Received: by 2002:a05:600c:46d1:b0:4a3:59c9:a754 with SMTP id
 5b1f17b1804b1-4ac187a72f4mr360555325e9.22.1793795770615; 
 Wed, 04 Nov 2026 04:36:10 -0800 (PST)
Received: from localhost.localdomain ([2a01:7d0:d208:aa00:9908:ec2a:cbac:ad71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9faff90sm155844625e9.5.2026.11.04.04.36.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 04:36:10 -0800 (PST)
From: Manuele Conti <conti.manuele@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manuele Conti <conti.manuele@gmail.com>
Subject: [PATCH v2] hw/sd/ssi-sd: Handle immediate write start token after R1
Date: Wed,  4 Nov 2026 13:31:56 +0100
Message-ID: <20261104123605.37729-1-conti.manuele@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20261104111619.24479-1-conti.manuele@gmail.com>
References: <20261104111619.24479-1-conti.manuele@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=conti.manuele@gmail.com; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a write start token immediately follows the R1 response,
the SPI SD controller may still be in SSI_SD_RESPONSE state
and discard the token.

Recognize single-block and multi-block write start tokens
when the SD card is ready to receive data, allowing the
write operation to proceed without an additional dummy byte.

Signed-off-by: Manuele Conti <conti.manuele@gmail.com>
---
Hi Philippe,

Thanks for your feedback.

I encountered this issue while running a bare-metal STM32F4 firmware under QEMU, using SPI mode to communicate with an SD card.

The firmware performs a block write (CMD24) and sends the data start token (0xFE) immediately after receiving the R1 response, without an additional dummy byte.

In this case, the SSI SD controller is still in SSI_SD_RESPONSE state and discards the token, causing the subsequent write operation to fail.

I've now added a regression test to reproduce this behavior without requiring the original firmware.

The test exercises the immediate write-token sequence and verifies that the controller correctly transitions to the data-write state.

I'll submit an updated patch including the regression test so the issue can be reproduced and verified independently.

Best regards,
Manuele

 hw/sd/ssi-sd.c                        |   6 +
 tests/qtest/ssi-sd-token-local-test.c | 165 ++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 tests/qtest/ssi-sd-token-local-test.c

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index a3a9f0c7efd..13c87c49cfb 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -185,6 +185,12 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
             s->mode = SSI_SD_CMD;
             return SSI_DUMMY;
         }
+        /* The next byte after R1 may already be the write start token. */
+        if (sdbus_receive_ready(&s->sdbus) &&
+            (val == SSI_TOKEN_SINGLE || val == SSI_TOKEN_MULTI_WRITE)) {
+            s->mode = SSI_SD_DATA_WRITE;
+            return SSI_DUMMY;
+        }
         if (sdbus_data_ready(&s->sdbus)) {
             DPRINTF("Data read\n");
             s->mode = SSI_SD_DATA_START;
diff --git a/tests/qtest/ssi-sd-token-local-test.c b/tests/qtest/ssi-sd-token-local-test.c
new file mode 100644
index 00000000000..55ac5fec643
--- /dev/null
+++ b/tests/qtest/ssi-sd-token-local-test.c
@@ -0,0 +1,165 @@
+/*
+ * SD/SPI transfert tests
+ *
+ * Copyright (c) 2026 Manuele Conti <manuele.conti@archimede-energia.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define SSP_BASE 0x40008000
+#define GPIO_D_DATA0 0x40007004
+#define GPIO_D_DIR 0x40007400
+#define BLOCK_SIZE 512
+
+typedef struct WriteCase {
+    const char *name;
+    bool multi;
+    unsigned dummy_bytes;
+} WriteCase;
+
+static uint8_t transfer(uint8_t value)
+{
+    writel(SSP_BASE + 8, value);
+    return readl(SSP_BASE + 8) & 0xff;
+}
+
+static uint8_t command(unsigned cmd, uint32_t argument)
+{
+    transfer(0xff);
+    transfer(0x40 | cmd);
+    transfer(argument >> 24);
+    transfer(argument >> 16);
+    transfer(argument >> 8);
+    transfer(argument);
+    transfer(cmd == 0 ? 0x95 : cmd == 8 ? 0x87 : 0xff);
+    for (unsigned i = 0; i < 32; i++) {
+        uint8_t response = transfer(0xff);
+        if (!(response & 0x80)) {
+            return response;
+        }
+    }
+    g_assert_not_reached();
+}
+
+static void initialize_card(void)
+{
+    bool ready = false;
+    bool token = false;
+
+    /* Drive D0 high and then low to select SD and deselect the OLED. */
+    writel(GPIO_D_DIR, 1);
+    writel(GPIO_D_DATA0, 1);
+    writel(GPIO_D_DATA0, 0);
+    writel(SSP_BASE, 7);       /* Eight-bit SPI frames. */
+    writel(SSP_BASE + 4, 2);   /* Enable PL022. */
+    for (unsigned i = 0; i < 10; i++) {
+        transfer(0xff);
+    }
+    g_assert_cmphex(command(0, 0), ==, 1);
+    g_assert_cmphex(command(8, 0x1aa), ==, 1);
+    for (unsigned i = 0; i < 4; i++) {
+        transfer(0xff);
+    }
+    for (unsigned i = 0; i < 100; i++) {
+        g_assert_cmphex(command(55, 0), ==, 1);
+        if (command(41, 0x40000000) == 0) {
+            ready = true;
+            break;
+        }
+        clock_step(1000000);
+    }
+    g_assert_true(ready);
+
+    /* Upstream's SPI CMD9 handler switches the card to transfer state. */
+    g_assert_cmphex(command(9, 0), ==, 0);
+    for (unsigned i = 0; i < 32; i++) {
+        if (transfer(0xff) == 0xfe) {
+            token = true;
+            break;
+        }
+    }
+    g_assert_true(token);
+    for (unsigned i = 0; i < 18; i++) {
+        transfer(0xff);       /* Sixteen CSD bytes and two CRC bytes. */
+    }
+    g_assert_cmphex(command(16, BLOCK_SIZE), ==, 0);
+}
+
+static void test_write(const void *opaque)
+{
+    const WriteCase *tc = opaque;
+    unsigned blocks = tc->multi ? 2 : 1;
+    uint8_t expected[2 * BLOCK_SIZE], actual[2 * BLOCK_SIZE];
+    uint8_t response[2] = { 0xff, 0xff };
+    bool accepted = true;
+    g_autofree char *path = NULL;
+    g_autofree char *args = NULL;
+    int fd = g_file_open_tmp("ssi-sd-token-local-XXXXXX", &path, NULL);
+    ssize_t bytes;
+
+    g_assert_cmpint(fd, >=, 0);
+    g_assert_cmpint(ftruncate(fd, 64 * 1024 * 1024), ==, 0);
+    args = g_strdup_printf("-M lm3s6965evb -serial none "
+                           "-drive file=%s,if=sd,format=raw", path);
+    qtest_start(args);
+    initialize_card();
+    g_assert_cmphex(command(tc->multi ? 25 : 24, 0), ==, 0);
+    for (unsigned i = 0; i < tc->dummy_bytes; i++) {
+        transfer(0xff);
+    }
+    for (unsigned block = 0; block < blocks; block++) {
+        /* Constant data avoids accidentally supplying a second start token. */
+        memset(expected + block * BLOCK_SIZE, 0xa5 + block, BLOCK_SIZE);
+        transfer(tc->multi ? 0xfc : 0xfe);
+        for (unsigned i = 0; i < BLOCK_SIZE; i++) {
+            transfer(expected[block * BLOCK_SIZE + i]);
+        }
+        transfer(0xff);
+        transfer(0xff);
+        response[block] = transfer(0xff);
+        if ((response[block] & 0x1f) != 0x05) {
+            accepted = false;
+            break;
+        }
+        /* This experiment isolates the first token after command R1. */
+        if (tc->multi && block + 1 < blocks) {
+            transfer(0xff);
+        }
+    }
+    if (tc->multi && accepted) {
+        transfer(0xff);
+        transfer(0xfd);
+        transfer(0xff);
+    }
+    qtest_end();
+    bytes = pread(fd, actual, blocks * BLOCK_SIZE, 0);
+    close(fd);
+    unlink(path);
+
+    g_test_message("CMD%u dummy=%u response[0]=0x%02x response[1]=0x%02x",
+                   tc->multi ? 25 : 24, tc->dummy_bytes,
+                   response[0], response[1]);
+    g_assert_true(accepted);
+    g_assert_cmpint(bytes, ==, blocks * BLOCK_SIZE);
+    g_assert_cmpmem(actual, blocks * BLOCK_SIZE,
+                   expected, blocks * BLOCK_SIZE);
+}
+
+int main(int argc, char **argv)
+{
+    static const WriteCase cases[] = {
+        { "/ssi-sd-local/single/immediate", false, 0 },
+        { "/ssi-sd-local/single/dummy", false, 1 },
+        { "/ssi-sd-local/multi/immediate", true, 0 },
+        { "/ssi-sd-local/multi/dummy", true, 1 },
+    };
+
+    g_test_init(&argc, &argv, NULL);
+    for (unsigned i = 0; i < G_N_ELEMENTS(cases); i++) {
+        qtest_add_data_func(cases[i].name, &cases[i], test_write);
+    }
+    return g_test_run();
+}
-- 
2.41.0


