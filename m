Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1B606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wZ7stuPZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQ0J-0007Ea-5N; Mon, 09 Nov 2026 09:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ03-000797-D5
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:31 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ01-00088v-73
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:31 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso753556f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794233127; x=1794837927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fvqo4j1st1siqJM53V2sV9pY5mo1jyQ0U3Yna1N4QZg=;
 b=wZ7stuPZR72+56e/qBmwuMDsPz/UMoTm4x38/6QuJJ6M8TwQ9PvPDi1aRUjo2ZI/Ue
 ejQ8hy14tGgl6UYwyGKGJe3M2s5r98MmQFCBCmt99HHVK5DRbeHgvj0vJw3IoIFvnbzb
 EWHb5cUDNJQpplN9kjWFOt8DGb+vEMvZ2tnMEUe4fXvx6m8w+AZlVnAPWwNjPo4mN8Fo
 BKXuTXqfaH36Qk5QrN9vXBwQKfH4H3KwSiOBDkq90ZcJvx/OiFvJNO6q/o3XZF8IlIqg
 23gflQscWutL906uy3cWGxj4KnGVJQUW3lmwJF99+vPfI2X8isni68hpRJdcEaWUqjqG
 yUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233127; x=1794837927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fvqo4j1st1siqJM53V2sV9pY5mo1jyQ0U3Yna1N4QZg=;
 b=u2dCOoxa6wzTlnTi64uynJbF9l/6OybscdpZheZ37Y9+G5qZL0G1E20pyNbCU9/TP/
 piIFtMxQRCr/ycF6NjfYYRLeWo5geo8btihUHKD6zrX0zCD3gTa+DBBUDhkv5q7xPo90
 B8G98FhBos3Wb81oJXOdnrDxNlOjbAsImG7zLCbCto22x1vTn1HK84pxJYvupWgE3ADA
 GQFvxozolpTdF5M5/MjscxspphjS0RUAmq9vJyOBzECJ2t4ERUdrwQL3xGuzXyiI73Bc
 I/kSe3Q9qj7Om+S15dFVYgvUm09hLZcod2NYqIJiRs0usg3J/ZByj1r8O5kHWHtKS9Ro
 brlQ==
X-Gm-Message-State: APuU4Z8yS+fwFDGUbHucvBSoBVi9ToAQZvmXhfGgMdgzBvh8X2JoPCr2
 8U0WBRlGDd6PCnigWzU2v95yuZcj8Z2p0qtoOZx0SfJUe2DNdCqvlFKFCkrh02uINr1ZQKTtRnP
 l/qanCdk=
X-Gm-Gg: AYBFou1RNPOGsEYhUsbevLKhlUxrxbxlvgHMeVrDZwra/yf6FAdho8Qrpfr7H8jcFGA
 GJ8zweDUEssyfWc5mWzrCeVbT7Y1TndcIaslA7hT94WHstTOMjM6C5fbc3XseDbpdnBexecMbeg
 OLwYfVu0lCK8BR97cwfoXU1kfMo8r597gJeBhNfcO560u3ImWuVK+Af4EDL23xmQjJmie4kiLlS
 Oe3qDjbuDCleakeO80zd0C86k89MYbkbyM+h1V0qybJDcSHiaSzOidAKxG06rzEjx1BP7T0C5dG
 b+JuOkqIP2mb+PnlvQJEuhfIZ+vUbIstPl3kpJ5Onxn5pt+ZrN3Iu+z3kBVRbO8SZ66XcnhdKe8
 C31RM/IqdyI67I8sfUxu2J18gSLWWhcRbgsyzV/bl0omjs9PkC1T1t/rDkYbOmjej3rtR2PrR+X
 sSpP38aFCZfqnjrAX4HZlmbmssZ12QbkKrMgormO/PhgNs985KyqLsAX5PL+Hi0NeDfFfsd4+bY
 ClJ8/2GIpiwVjtDTuLy+V5oeYasPp6r4ilpqIKbv0pNimJZ5xkOptbzDa9rrZ8xVVtXS3WAzTWC
 3JD+9ioOINqvK9J9Ei9/V3SlpF3du0x05G2dMTe0XxKNvRmkuUNtMwzQKWNqmBsRHtlZXAyxI2E
 t/QoBKXQBgvIk7VUUjC69lBkkW+7BwzTnlA==
X-Received: by 2002:a5d:5d06:0:b0:48e:d88:55e2 with SMTP id
 ffacd0b85a97d-4958c779a6dmr7686452f8f.42.1794233127447; 
 Mon, 09 Nov 2026 06:05:27 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea51cbsm11184750f8f.27.2026.11.09.06.05.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:05:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] hw/net/bcm2838_genet: wrap the TX consumer index at 16 bits
Date: Mon,  9 Nov 2026 14:05:16 +0000
Message-ID: <20261109140523.240161-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109140523.240161-1-peter.maydell@linaro.org>
References: <20261109140523.240161-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lorand Marton <lorandmarton.dev@gmail.com>

The producer and consumer indexes of a GENET DMA ring are 16-bit
counters (Linux bcmgenet masks them with DMA_P_INDEX_MASK and
DMA_C_INDEX_MASK). bcm2838_genet_tx() counted the consumer index up in
a uint32_t and compared it with the 16-bit producer index, so the first
transmit that crossed the wrap (consumer 0xfffe, producer 0x0001) never
ended the loop: the device sent the ring's descriptors forever with the
BQL held, and the guest and the monitor hung. A guest sending a
sustained stream hung after about 65k descriptors on one ring.

Wrap the index, and test a transmit across the wrap.

Signed-off-by: Lorand Marton <lorandmarton.dev@gmail.com>
Reviewed-by: Marcelo Manzo <marcelomanzo@gmail.com>
Tested-by: Marcelo Manzo <marcelomanzo@gmail.com>
Message-id: 0bd9bd85fd70c12f7e9ad77ad92a0ac1a778a29e.1793613972.git.lorandmarton.dev@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/bcm2838_genet.c           |   4 +-
 tests/qtest/bcm2838-genet-test.c | 101 +++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   2 +
 3 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/bcm2838-genet-test.c

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 53bba99b38a..557a8a96365 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -521,7 +521,9 @@ static uint64_t bcm2838_genet_tx(BCM2838GenetState *s, unsigned int ring_index,
         }
 
         num_descs++;
-        cons_index_fld++;
+        /* The indexes count modulo 2^16 */
+        cons_index_fld = (cons_index_fld + 1)
+                         & R_GENET_DMA_CONS_INDEX_INDEX_MASK;
         s->regs.tdma.descs[desc_index].length_status =
             FIELD_DP32(s->regs.tdma.descs[desc_index].length_status,
                        GENET_RDMA_LENGTH_STATUS, OWN, 1);
diff --git a/tests/qtest/bcm2838-genet-test.c b/tests/qtest/bcm2838-genet-test.c
new file mode 100644
index 00000000000..393abd7da28
--- /dev/null
+++ b/tests/qtest/bcm2838-genet-test.c
@@ -0,0 +1,101 @@
+/*
+ * QTest testcase for the BCM2838 GENET DMA rings
+ *
+ * Frames go out over a socket netdev. The producer and consumer indexes
+ * of a ring count modulo 2^16.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/bswap.h"
+#include "libqtest.h"
+
+#define GENET_BASE          0xfd580000
+
+#define RING_START_ADDR     0x14
+#define RING_END_ADDR       0x1c
+
+#define TDMA_DESC(i)        (0x4000 + (i) * 12)
+#define TDMA_RING(r)        (0x4c00 + (r) * 0x40)
+#define TRING_READ_PTR      0x00
+#define TRING_CONS_INDEX    0x08
+#define TRING_PROD_INDEX    0x0c
+#define TDMA_RING_CFG       0x5040
+#define TDMA_CTRL           0x5044
+#define TSB_LEN             64      /* transmit status block */
+
+#define DESCS_PER_RING      4
+#define BUF_SIZE            2048
+#define BUF_BASE            0x100000
+#define FRAME_LEN           60
+
+static void genet_writel(QTestState *qts, uint32_t off, uint32_t val)
+{
+    qtest_writel(qts, GENET_BASE + off, val);
+}
+
+static uint32_t genet_readl(QTestState *qts, uint32_t off)
+{
+    return qtest_readl(qts, GENET_BASE + off);
+}
+
+/* Transmit across the wrap of the 16-bit consumer index */
+static void test_tx_index_wrap(void)
+{
+    const unsigned r = 0, n = 3;
+    const uint16_t first = 0xfffe;
+    uint8_t frame[FRAME_LEN] = { 0 };
+    uint8_t pkt[4 + FRAME_LEN];
+    int sv[2];
+    QTestState *qts;
+
+    g_assert_cmpint(socketpair(PF_UNIX, SOCK_STREAM, 0, sv), ==, 0);
+    qts = qtest_initf("-M raspi4b -nic socket,fd=%d,model=bcm2838-genet",
+                      sv[1]);
+    close(sv[1]);
+
+    memset(frame, 0xff, 6);
+    stw_be_p(frame + 12, 0x88b5);
+    for (unsigned i = 0; i < n; i++) {
+        frame[14] = i;
+        qtest_memset(qts, BUF_BASE + i * BUF_SIZE, 0, TSB_LEN);
+        qtest_memwrite(qts, BUF_BASE + i * BUF_SIZE + TSB_LEN, frame,
+                       sizeof(frame));
+        /* SOP, EOP, buffer length */
+        genet_writel(qts, TDMA_DESC(i), BIT(13) | BIT(14) |
+                     (TSB_LEN + FRAME_LEN) << 16);
+        genet_writel(qts, TDMA_DESC(i) + 4, BUF_BASE + i * BUF_SIZE);
+        genet_writel(qts, TDMA_DESC(i) + 8, 0);
+    }
+    genet_writel(qts, TDMA_RING(r) + RING_START_ADDR, 0);
+    genet_writel(qts, TDMA_RING(r) + RING_END_ADDR, DESCS_PER_RING * 3 - 1);
+    genet_writel(qts, TDMA_RING(r) + TRING_READ_PTR, 0);
+    genet_writel(qts, TDMA_RING(r) + TRING_CONS_INDEX, first);
+    genet_writel(qts, TDMA_RING(r) + TRING_PROD_INDEX, first);
+    genet_writel(qts, TDMA_RING_CFG, BIT(r));
+    genet_writel(qts, TDMA_CTRL, 1 | BIT(1 + r));
+
+    genet_writel(qts, TDMA_RING(r) + TRING_PROD_INDEX,
+                 (uint16_t)(first + n));
+    g_assert_cmphex(genet_readl(qts, TDMA_RING(r) + TRING_CONS_INDEX) &
+                    0xffff, ==, (uint16_t)(first + n));
+
+    for (unsigned i = 0; i < n; i++) {
+        g_assert_cmpint(recv(sv[0], pkt, sizeof(pkt), MSG_WAITALL), ==,
+                        sizeof(pkt));
+        g_assert_cmpuint(ldl_be_p(pkt), ==, FRAME_LEN);
+        g_assert_cmpuint(pkt[4 + 14], ==, i);
+    }
+
+    qtest_quit(qts);
+    close(sv[0]);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/bcm2838-genet/tx-index-wrap", test_tx_index_wrap);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ff4bf9528a7..79946960869 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -287,6 +287,8 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test', 'bcm2835-ic-test'] : []) +  \
+  (config_all_devices.has_key('CONFIG_RASPI') and host_os != 'windows' ?
+    ['bcm2838-genet-test'] : []) + \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
-- 
2.43.0


