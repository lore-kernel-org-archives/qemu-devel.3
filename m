Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E89606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jhFTyTRJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNpdE-00028N-H2; Mon, 02 Nov 2026 05:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lorandmarton.dev@gmail.com>)
 id 1xNpd7-00027P-UY
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:51:12 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lorandmarton.dev@gmail.com>)
 id 1xNpd5-0000PC-Op
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:51:09 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so21501015e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793616665; x=1794221465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P3nMtMvTIbYertBU7fHJRLXjNyWA8Nhe/STcrAr+oA4=;
 b=jhFTyTRJ35xcMmYibVcWH4KrgQcJjpDwf9+ImfHi4kAyg9zobJuEo8ujyscANcrBOj
 +bkNFIQUwOubLRpxk9/WMReB73ovi0+xcwsZcEOw/XhZ9W0p2VYKIh2E3+saGomboVwL
 mZUtY8GlirIdqVjH6NqxCZFqMMN2J13/Fcn6ZKEyNQwrdWopeF/fwMHPo3DOn12d5qKH
 33ocnk3STyMejRzHHQ8yZggjStDwIrL9Sd+4QAorAK6e7ohAlC/J1lLtFviAucj68mFG
 fR8tDJmzwwlD7QReEOl0aZKO2j0lYTGCmUSWXD2mIkg6O5AwlIgvlaH8eBddouDshqMm
 oJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793616665; x=1794221465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P3nMtMvTIbYertBU7fHJRLXjNyWA8Nhe/STcrAr+oA4=;
 b=MY4mSkjDws1NTqzjAX6zuro3cGe6ooFBbRQH7mQ2UXQvDJGHNTEElNcjsFMb6OXg6t
 S1ftWZAJ1xm1mPb4VRWOdJdi2IKDzN12scnaoMpsehspdkXN3lQpevQS9hELFSfnjmlo
 RIvsh2KJpuUDiYViXKH1OogoQn6EUqVg+jN5Lc3SR9g8AKLLhimpu6YmMUjYiQGSgNaQ
 1b0WhG1w04mG+QJp447/LSXOirnkteGjRCAfQvVB/hDNbhK0JSqlUq4ECDVTbr7orVf6
 LynEmnXG4URM9Gt+vQ/hL88munQBsFGFQV0SKABIQ/5VRHmPMN0nnZrzgcIOw9PYNwqb
 2yyQ==
X-Gm-Message-State: AFq9FYL9pq2QdfmWelFUS9lpMGRzNRpSQNJkQt+tUwCIScDtrXuuejHE
 884qG7UBbveDxgYaY/TcemFIRFI9ikkXw85SSvyTs+iNmaE7TqHeJn2XEOa182PpSbA=
X-Gm-Gg: AYBFou0hkzp2VJ/2jg0145dY/nZGy3QiMcYVaXVfN7GD/dJbRSi8grKC9AZ8ABqew+H
 7hXOSsoHojsvTpV41M+CHfROEIhKxp5yE5BiaDfaSmC0OIVPUgbjZjTI9vq5uUrV7+eEoL3FmVG
 Xapv+CwkyDiwXFowuJO7VN1ccxqkhhGlxhxb29VJDoVYQOZ/nVrVgNiuXemturqbGFqbGKssLUY
 0RtcoHnB+Fi8HmTu4Tc00L30KWyfT2w/xqIS7jVthR+q2cdULFzrzMCl7sUHUoV9bJK6hWq6CSj
 w/PYDxwkJUCfn/moTqPxi5fhFB1G/B93w/txLRhzarY3zA7QGUEcp4VuNFlJetHxNhXBNNHLFQU
 znn36FHfFZgWtCrCDYV94vQZlMbfocKzpiIO40HvZ3uEFmlu6cF6qa77E5PtOQA8Xqu150fRWs5
 F2VJpC7vh2Ax6eZqMbukOU49D1kftn9MrBJ+U5Oo7i1cxRE8hrkP2bNAC2IiHCK8zRDmoGVvcDR
 LtRTr33NJTT4O5lY2IfDJCLyB8WGdc5RNQmmMBnAkTlVl0dxwF8JutFEFpqvoqHS5o2s24r4Kw+
 eMxDaJhiFKc9MfKxH4TmF01ySbryghdO0bBjxrmOT1fmD+um7eyo0S09SM8Z7rZv5o9WUOZZGIV
 hufkNNQFAd+binMOtUsN78Z4=
X-Received: by 2002:a05:600c:8b61:b0:4a2:1398:dd05 with SMTP id
 5b1f17b1804b1-4ac17752ee4mr206266965e9.16.1793616664691; 
 Mon, 02 Nov 2026 02:51:04 -0800 (PST)
Received: from localhost.localdomain (email.telematik-zentrum.de.
 [87.138.218.176]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf67aa704sm250646545e9.8.2026.11.02.02.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:51:04 -0800 (PST)
From: Lorand Marton <lorandmarton.dev@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jasowangio@gmail.com, marcelomanzo@gmail.com, serg.oker@gmail.com
Subject: [PATCH 2/2] hw/net/bcm2838_genet: hold RX frames while the ring is
 full
Date: Mon,  2 Nov 2026 11:51:03 +0100
Message-ID: <fdaf96319d81b2b6602822fd5881a5b5a72e5daa.1793613972.git.lorandmarton.dev@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793613972.genet-ring-fixes-v1.git.lorandmarton.dev@gmail.com>
References: <cover.1793613972.genet-ring-fixes-v1.git.lorandmarton.dev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=lorandmarton.dev@gmail.com; helo=mail-wm1-x332.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

bcm2838_genet_rdma() never looked at the consumer index of the RX
ring: it wrote each frame to the next descriptor whatever the guest
had read, so a burst longer than the ring (Linux bcmgenet gives the
default ring 256 descriptors) overwrote frames the guest had not taken
yet, and the producer index ran more than a ring ahead of the consumer
index, which bcmgenet_desc_rx() does not expect.

Count the free descriptors of the ring from its start and end
addresses and the two indexes. When there are none, return 0 so that
the net layer keeps the frame queued, and flush the queue when the
guest writes the consumer index of an RX ring, as e1000 does on a
write of RDT. If the ring fills inside a frame that takes several
descriptors, stop there instead of writing past the consumer index.

Real GENET drops such frames and counts them in the DISCARD_CNT field
of the producer index; holding them costs no frame on a slow host and
matches the other QEMU NICs.

Test that a ring of 4 descriptors keeps 6 frames apart until the
guest moves its consumer index.

Signed-off-by: Lorand Marton <lorandmarton.dev@gmail.com>
---
 hw/net/bcm2838_genet.c           |  38 +++++++++++
 tests/qtest/bcm2838-genet-test.c | 107 ++++++++++++++++++++++++++++++-
 2 files changed, 143 insertions(+), 2 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 557a8a9636..92d550cb63 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -779,6 +779,13 @@ static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
         FIELD_EX32(value, GENET_DMA_CTRL, EN)) {
         qemu_flush_queued_packets(ncs);
     }
+    /* The guest gave descriptors back to an RX ring */
+    if (offset >= BCM2838_GENET_RDMA_RINGS &&
+        offset < BCM2838_GENET_RDMA_RINGS + sizeof(s->regs.rdma.rings) &&
+        (offset - BCM2838_GENET_RDMA_RINGS) % sizeof(BCM2838GenetRdmaRing)
+        == BCM2838_GENET_RRING_CONS_INDEX) {
+        qemu_flush_queued_packets(ncs);
+    }
     bcm2838_genet_set_irq_default(s);
     bcm2838_genet_set_irq_prio(s);
 }
@@ -823,6 +830,23 @@ static bool is_packet_multicast(const uint8_t *buf, size_t size)
     return !!(buf[0] & 0x01);
 }
 
+/*
+ * Descriptors of an RX ring that the guest has handed back: the ring
+ * holds END - START + 1 of them, and PROD - CONS (modulo 2^16) are full.
+ */
+static unsigned bcm2838_genet_rdma_free_descs(BCM2838GenetRdmaRing *ring,
+                                              hwaddr start_index,
+                                              hwaddr end_index)
+{
+    uint16_t used = FIELD_EX32(ring->prod_index, GENET_DMA_PROD_INDEX, INDEX)
+                    - FIELD_EX32(ring->cons_index, GENET_DMA_CONS_INDEX, INDEX);
+
+    if (end_index < start_index || used > end_index - start_index) {
+        return 0;
+    }
+    return end_index - start_index + 1 - used;
+}
+
 static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
                                   const void *buf, size_t size)
 {
@@ -855,6 +879,12 @@ static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
                       BCM2838_GENET_DMA_DESC_CNT - 1);
         return -1;
     }
+
+    /* A full ring: keep the frame queued until the guest frees some */
+    if (!bcm2838_genet_rdma_free_descs(ring, start_index, end_index)) {
+        return 0;
+    }
+
     desc = &rdma->descs[write_index];
 
     desc->length_status = FIELD_DP32(desc->length_status,
@@ -948,6 +978,14 @@ static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
         desc = &rdma->descs[write_index];
         ring->write_ptr = write_index * desc_word_size;
         ring->write_ptr_hi = ((hwaddr)write_index * desc_word_size) >> 32;
+
+        if (len < size &&
+            !bcm2838_genet_rdma_free_descs(ring, start_index, end_index)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: RX ring %u full inside a frame\n",
+                          __func__, ring_idx);
+            break;
+        }
     }
 
     if (ring_idx == BCM2838_GENET_DMA_RING_DEFAULT) {
diff --git a/tests/qtest/bcm2838-genet-test.c b/tests/qtest/bcm2838-genet-test.c
index 393abd7da2..35653773d1 100644
--- a/tests/qtest/bcm2838-genet-test.c
+++ b/tests/qtest/bcm2838-genet-test.c
@@ -1,8 +1,8 @@
 /*
  * QTest testcase for the BCM2838 GENET DMA rings
  *
- * Frames go out over a socket netdev. The producer and consumer indexes
- * of a ring count modulo 2^16.
+ * Frames come in and go out over a socket netdev. The producer and
+ * consumer indexes of a ring count modulo 2^16.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
@@ -14,8 +14,16 @@
 
 #define GENET_BASE          0xfd580000
 
+#define RDMA_DESC(i)        (0x2000 + (i) * 12)
+#define RDMA_RING(r)        (0x2c00 + (r) * 0x40)
+#define RING_WRITE_PTR      0x00
+#define RING_PROD_INDEX     0x08
+#define RING_CONS_INDEX     0x0c
+#define RING_BUF_SIZE       0x10
 #define RING_START_ADDR     0x14
 #define RING_END_ADDR       0x1c
+#define RDMA_RING_CFG       0x3040
+#define RDMA_CTRL           0x3044
 
 #define TDMA_DESC(i)        (0x4000 + (i) * 12)
 #define TDMA_RING(r)        (0x4c00 + (r) * 0x40)
@@ -26,9 +34,11 @@
 #define TDMA_CTRL           0x5044
 #define TSB_LEN             64      /* transmit status block */
 
+#define DEFAULT_RING        16
 #define DESCS_PER_RING      4
 #define BUF_SIZE            2048
 #define BUF_BASE            0x100000
+#define STATUS_LEN          64      /* receive status block, then 2 bytes */
 #define FRAME_LEN           60
 
 static void genet_writel(QTestState *qts, uint32_t off, uint32_t val)
@@ -41,6 +51,98 @@ static uint32_t genet_readl(QTestState *qts, uint32_t off)
     return qtest_readl(qts, GENET_BASE + off);
 }
 
+/* The default ring uses the first DESCS_PER_RING descriptors */
+static QTestState *genet_rx_init(int *fd)
+{
+    const unsigned r = DEFAULT_RING;
+    int sv[2];
+    QTestState *qts;
+
+    g_assert_cmpint(socketpair(PF_UNIX, SOCK_STREAM, 0, sv), ==, 0);
+    qts = qtest_initf("-M raspi4b -nic socket,fd=%d,model=bcm2838-genet",
+                      sv[1]);
+    close(sv[1]);
+    *fd = sv[0];
+
+    for (unsigned i = 0; i < DESCS_PER_RING; i++) {
+        genet_writel(qts, RDMA_DESC(i) + 4, BUF_BASE + i * BUF_SIZE);
+        genet_writel(qts, RDMA_DESC(i) + 8, 0);
+    }
+    genet_writel(qts, RDMA_RING(r) + RING_START_ADDR, 0);
+    genet_writel(qts, RDMA_RING(r) + RING_END_ADDR, (DESCS_PER_RING - 1) * 3);
+    genet_writel(qts, RDMA_RING(r) + RING_WRITE_PTR, 0);
+    genet_writel(qts, RDMA_RING(r) + RING_BUF_SIZE, BUF_SIZE);
+    genet_writel(qts, RDMA_RING_CFG, BIT(r));
+    genet_writel(qts, RDMA_CTRL, 1 | BIT(1 + r));
+    return qts;
+}
+
+static uint32_t prod_index(QTestState *qts, unsigned r)
+{
+    return genet_readl(qts, RDMA_RING(r) + RING_PROD_INDEX) & 0xffff;
+}
+
+/* Send a broadcast frame into the socket netdev */
+static void send_frame(int fd, uint16_t ethertype, uint8_t byte14)
+{
+    uint8_t pkt[4 + FRAME_LEN] = { 0 };
+
+    stl_be_p(pkt, FRAME_LEN);
+    memset(pkt + 4, 0xff, 6);
+    stw_be_p(pkt + 4 + 12, ethertype);
+    pkt[4 + 14] = byte14;
+    g_assert_cmpint(send(fd, pkt, sizeof(pkt), 0), ==, sizeof(pkt));
+}
+
+/* The byte at 14 of the frame that descriptor I holds */
+static uint8_t rx_byte14(QTestState *qts, unsigned i)
+{
+    return qtest_readb(qts, BUF_BASE + i * BUF_SIZE + STATUS_LEN + 2 + 14);
+}
+
+/* Wait up to MS milliseconds for the producer index of ring R to be N */
+static bool wait_prod_index(QTestState *qts, unsigned r, uint32_t n,
+                            unsigned ms)
+{
+    gint64 end = g_get_monotonic_time() + ms * G_TIME_SPAN_MILLISECOND;
+
+    do {
+        qtest_clock_step(qts, 100);
+        if (prod_index(qts, r) == n) {
+            return true;
+        }
+    } while (g_get_monotonic_time() < end);
+    return false;
+}
+
+/* A full RX ring keeps the next frames until the guest frees descriptors */
+static void test_rx_ring_full(void)
+{
+    const unsigned n = DESCS_PER_RING + 2;
+    int fd;
+    QTestState *qts = genet_rx_init(&fd);
+
+    for (unsigned i = 0; i < n; i++) {
+        send_frame(fd, 0x0800, i);
+    }
+    g_assert(wait_prod_index(qts, DEFAULT_RING, DESCS_PER_RING, 5000));
+    /* the rest must not overwrite descriptors the guest has not read */
+    g_assert(!wait_prod_index(qts, DEFAULT_RING, DESCS_PER_RING + 1, 500));
+    for (unsigned i = 0; i < DESCS_PER_RING; i++) {
+        g_assert_cmpuint(rx_byte14(qts, i), ==, i);
+    }
+
+    genet_writel(qts, RDMA_RING(DEFAULT_RING) + RING_CONS_INDEX, 2);
+    g_assert(wait_prod_index(qts, DEFAULT_RING, n, 5000));
+    for (unsigned i = 0; i < n; i++) {
+        g_assert_cmpuint(rx_byte14(qts, i % DESCS_PER_RING), ==,
+                         i < 2 ? i + DESCS_PER_RING : i);
+    }
+
+    qtest_quit(qts);
+    close(fd);
+}
+
 /* Transmit across the wrap of the 16-bit consumer index */
 static void test_tx_index_wrap(void)
 {
@@ -96,6 +198,7 @@ static void test_tx_index_wrap(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/bcm2838-genet/rx-ring-full", test_rx_ring_full);
     qtest_add_func("/bcm2838-genet/tx-index-wrap", test_tx_index_wrap);
     return g_test_run();
 }
-- 
2.56.0


