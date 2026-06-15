Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE18DCD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZFeX-00058I-De; Mon, 15 Jun 2026 18:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Y3owagcKCnIZhXYbaUWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--jrhilke.bounces.google.com>)
 id 1wZFeM-0004vy-6t
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:22 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Y3owagcKCnIZhXYbaUWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--jrhilke.bounces.google.com>)
 id 1wZFeK-0008O0-6b
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:21 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2bfdd99f6b7so61349585ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781561956; x=1782166756; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+O1dHWDOSJ55QHlZapXvR2r6qYGjNQa+WWJ3hC2i0oc=;
 b=DAKE+WH/3nGuK5ImvCCMohy+LaYk0UnaTZEOq6wR2yHiNAd0I51udb9BrQna/ZhwNl
 EaneaOVSjJZu524c3kbgqFOiH847xS+6mmEUKC2502EFpoFAuxbxpc8+/nOHe0QWWXKK
 s59WXQUvmkFS6T+sqgU1ttSmM8tM/R7Zxc6i/o1guXfagoI3C6f4jBwc1eN7ASWFxF9K
 jN1POeqP2DbELsLMTAjfN9C0R1L/99wp22oBegJBveYSv9kSDJC6Y0zVSH2Xr0BJCVq1
 yhmUcCw8mLAdgi2nP1DFmGD+RpI+Hc/egZ5BDSwtpm7zpi2vZ72Bl3POTyEcwUi3+93f
 uwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781561956; x=1782166756;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+O1dHWDOSJ55QHlZapXvR2r6qYGjNQa+WWJ3hC2i0oc=;
 b=Qn/+nUPe5gbQ+/X7joDBuvG+FBk1Qbw0sjrjx6CKsMN4G0hg7VBG9Pj0hj/3ueUnZ3
 R+EAEsJByycQd3UC7rIBezR+pf5c7uUKEJp8NcGVIbL4XW0TRaTNO7UB+299t0UTF3nJ
 Th8BTPm7MjET8fjSZIwbrNLEvFnOphlWxwLetCafPlKjFFqoKjyKRzF3I0VaQ7rHty8K
 Yw2mYgeWTiKockiWyPUjS83+7N/X57Y2AlV0EwjA20ZCj6tdXZUkYzHD+snGCv7MoXfS
 tcCpTTCx7D4GkfEMYQqSadn0Oe09A67FRWAghZXA8gxnUwowFtZ1zQZxz8uviTPjxsFh
 v+Tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7eOEPEC7116RL+4U2yE25icmZrHpAQxOD5NCZSqKUBB1f10c2UijNpDhClMFMvWGg7dM2oKk2r3E3@nongnu.org
X-Gm-Message-State: AOJu0Yw0clYvPMS0Vsny93mmj8g7PvxWn4SbGIiFVCpqM8v+r1xCcWj+
 UQh5yJxfOFb0eXhqXLrsGeGUAq+DeZ4pYxyLW7uyHyTz/qKvLID671Xl2n0RYduJc0vXxH6qVnh
 D79D1B7/F
X-Received: from plbkp11.prod.google.com ([2002:a17:903:280b:b0:2bd:2c14:7974])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41c2:b0:2c3:5683:9acb
 with SMTP id d9443c01a7336-2c69a1c6ea9mr9736345ad.32.1781561955585; Mon, 15
 Jun 2026 15:19:15 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:18:09 +0000
In-Reply-To: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
Mime-Version: 1.0
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260615-igb-trl-v4-7-cf5739bf529f@google.com>
Subject: [PATCH v4 7/7] igb: Add QTest for Transmit Rate Limiter traffic
 throttling
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3Y3owagcKCnIZhXYbaUWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--jrhilke.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add a test for the IGB transmit rate limiting functionality. The test
verifies that TRL is enabled by setting the appropriate registers and
that data is transmitted at the appropriate rate based on chosen
target rate.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 tests/qtest/igb-test.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index 119be6a..153f5fb 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -34,9 +34,11 @@
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "qemu/bitops.h"
+#include "qemu/timer.h"
 #include "libqos/libqos-malloc.h"
 #include "libqos/e1000e.h"
 #include "hw/net/igb_regs.h"
+#include "hw/pci/pci_regs.h"
 
 #ifndef _WIN32
 
@@ -59,6 +61,58 @@ static uint32_t igb_trl_get_rate_factor(uint64_t rate_bytes_s)
     return (E1000_LINK_RATE_1GBPS << 14) / rate_bytes_s;
 }
 
+static void igb_trl_enable(QE1000E *d, uint64_t rate_bytes_s)
+{
+    /* Select Queue 0 */
+    e1000e_macreg_write(d, E1000_TRLDQSEL, 0);
+    /* Enable TRL with target rate */
+    e1000e_macreg_write(d, E1000_TRLRC,
+                        E1000_TRLRC_RS_ENA |
+                        igb_trl_get_rate_factor(rate_bytes_s));
+}
+
+static void igb_trl_disable(QE1000E *d)
+{
+    /* Select Queue 0 */
+    e1000e_macreg_write(d, E1000_TRLDQSEL, 0);
+    /* Disable TRL */
+    e1000e_macreg_write(d, E1000_TRLRC, 0);
+}
+
+static void igb_msix_clear_pending(QPCIDevice *dev, uint16_t entry)
+{
+    uint64_t vector_offset =
+        dev->msix_table_off + (entry * PCI_MSIX_ENTRY_SIZE);
+    uint32_t val = qpci_io_readl(dev, dev->msix_table_bar,
+                                 vector_offset + PCI_MSIX_ENTRY_VECTOR_CTRL);
+
+    /* Unmask (clears pending bit in QEMU) */
+    qpci_io_writel(dev, dev->msix_table_bar,
+                    vector_offset + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                    val & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
+
+    /* Mask again */
+    qpci_io_writel(dev, dev->msix_table_bar,
+                    vector_offset + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                    val | PCI_MSIX_ENTRY_CTRL_MASKBIT);
+}
+
+static void igb_read_tx_tail(QE1000E *d, void *descr)
+{
+    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
+    uint32_t last_entry;
+    uint32_t tail;
+    uint32_t len;
+
+    tail = e1000e_macreg_read(d, E1000_TDT_A(0));
+    len = e1000e_macreg_read(d, E1000_TDLEN_A(0)) / E1000_RING_DESC_LEN;
+    last_entry = (tail + len - 1) % len;
+
+    qtest_memread(d_pci->pci_dev.bus->qts,
+                  d->tx_ring + last_entry * E1000_RING_DESC_LEN, descr,
+                  E1000_RING_DESC_LEN);
+}
+
 static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *alloc)
 {
     union e1000_adv_tx_desc descr;
@@ -84,6 +138,14 @@ static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *allo
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
 
+    /*
+     * Read the descriptor back from guest memory again, now that WB has
+     * occurred. This is required because if the packet was delayed by the
+     * trasmit rate limiter, e1000e_tx_ring_push read it back before QEMU
+     * actually processed it.
+     */
+    igb_read_tx_tail(d, &descr);
+
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.status) & E1000_TXD_STAT_DD, ==,
                     E1000_TXD_STAT_DD);
@@ -147,6 +209,29 @@ static void igb_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
     guest_free(alloc, data);
 }
 
+/* Returns the amount of microseconds it takes to transmit a 64-byte packet.*/
+static uint64_t igb_send_and_measure(QE1000E *d, int *test_sockets,
+                                     QGuestAllocator *alloc)
+{
+    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
+    QPCIDevice *pdev = &d_pci->pci_dev;
+    QTestState *qts = global_qtest;
+    uint64_t start_time, end_time;
+
+    /* Clear any stale pending interrupt for this vector before we start */
+    igb_msix_clear_pending(pdev, E1000E_TX0_MSG_ID);
+
+    /* Clear EICR to allow new interrupts to be raised in MSI-X mode */
+    e1000e_macreg_write(d, E1000_EICR, 0xFFFFFFFF);
+
+    /* Send a test packet and measure the time it takes. */
+    start_time = qtest_clock_step(qts, 1);
+    igb_send_verify(d, test_sockets, alloc);
+    end_time = qtest_clock_step(qts, 1);
+
+    return end_time - start_time;
+}
+
 static void test_e1000e_init(void *obj, void *data, QGuestAllocator * alloc)
 {
     /* init does nothing */
@@ -240,6 +325,77 @@ static void test_igb_transmit_rate_limiter_regs(void *obj, void *data,
     g_assert_cmphex(e1000e_macreg_read(d, E1000_TRLRC), ==, val1);
 }
 
+/*
+ * Test for Transmit Rate Limiter (TRL) traffic throttling.
+ *
+ * Verifies that:
+ * 1. Packets are transmitted without delay when TRL is disabled.
+ * 2. Enabling TRL on a queue throttles subsequent transmissions.
+ * 3. The delay matches the expected transmission time calculated from the
+ *    packet size and the configured target rate.
+ * 4. Disabling TRL restores normal (unthrottled) transmission behavior.
+ */
+static void test_igb_transmit_rate_limiter(void *obj, void *data,
+                                           QGuestAllocator *alloc)
+{
+    QOSGraphObject *e_object = obj;
+    QE1000E_PCI *e1000e = obj;
+    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
+    QE1000E *d = &e1000e->e1000e;
+    const uint64_t expected_baseline_elapsed = 10 * SCALE_US;
+    const uint64_t expected_max_elapsed = 530 * SCALE_US;
+    const uint64_t expected_min_elapsed = 500 * SCALE_US;
+    uint64_t elapsed;
+
+    if (qpci_check_buggy_msi(dev)) {
+        return;
+    }
+
+    /* Send a test packet to verify there's no rate limit. */
+    elapsed = igb_send_and_measure(d, data, alloc);
+
+    /*
+     * QEMU doesn't emulate the hardware line rate of the device, so the packet
+     * is processed instantly (requiring 0 clock steps in wait_isr, which steps
+     * by 10us). Give a 10us margin for error.
+     */
+    g_assert_cmpint(elapsed, <, expected_baseline_elapsed);
+
+    /*
+     * Enable TRL and set the target rate to:
+     * (E1000_LINK_RATE_1GBPS / 1000) = 125 KB/s.
+     */
+    igb_trl_enable(d, E1000_LINK_RATE_1GBPS / 1000);
+
+    /*
+     * Send Packet 1 (no delay)
+     * The first packet triggers rate limiting for subsequent transmissions.
+     */
+    elapsed = igb_send_and_measure(d, data, alloc);
+    g_assert_cmpint(elapsed, <, expected_baseline_elapsed);
+
+    /* Send Packet 2 (should be delayed) */
+    elapsed = igb_send_and_measure(d, data, alloc);
+    /*
+     * Expected delay: 64 byte packet / 125 KB/s = 512 us.
+     * Since QEMU steps the clock by 10 us on each wait_isr iteration,
+     * the delay is rounded up to the next 10 us step, which is 520 us.
+     */
+    g_assert_cmpint(elapsed, >=, expected_min_elapsed);
+    g_assert_cmpint(elapsed, <=, expected_max_elapsed);
+
+    /* Send Packet 3 (should also be delayed) */
+    elapsed = igb_send_and_measure(d, data, alloc);
+    g_assert_cmpint(elapsed, >=, expected_min_elapsed);
+    g_assert_cmpint(elapsed, <=, expected_max_elapsed);
+
+    igb_trl_disable(d);
+
+    /* Send Packet 4 (no delay since TRL is disabled) */
+    elapsed = igb_send_and_measure(d, data, alloc);
+    g_assert_cmpint(elapsed, <, expected_baseline_elapsed);
+}
+
 static void data_test_clear(void *sockets)
 {
     int *test_sockets = sockets;
@@ -298,6 +454,8 @@ static void register_igb_test(void)
                  test_igb_multiple_transfers, &opts);
     qos_add_test("transmit_rate_limiter_regs", "igb",
                  test_igb_transmit_rate_limiter_regs, &opts);
+    qos_add_test("transmit_rate_limiter", "igb",
+                 test_igb_transmit_rate_limiter, &opts);
 #endif
 
     opts.before = data_test_init_no_socket;

-- 
2.54.0.1136.gdb2ca164c4-goog


