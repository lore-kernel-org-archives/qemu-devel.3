Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF64CDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbjyN-0000a7-8u; Mon, 22 Jun 2026 15:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3o4c5agcKCvAbjZadcWYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--jrhilke.bounces.google.com>)
 id 1wbjyK-0000ZV-3K
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:06:16 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3o4c5agcKCvAbjZadcWYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--jrhilke.bounces.google.com>)
 id 1wbjyH-0002oN-UO
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:06:15 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-8423970cb30so3529437b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782155171; x=1782759971; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=GOpYLqYb0m0OlIH0rl7mRp0VlvhMTNSJwAYjKLT4+U0=;
 b=QBXXyekRDxdvRGh26dCJTLc1kSVSfWtzprAzolh6t31AD68XGURjJkMgRizNGLkF0u
 pJCwnccPbbI3h3UB7sfI1Z9ouE5wcrcRBJNAPVb/3cKK6pldrb7T8faksInumvNkvgcn
 RY50PnBu9bMbXk/IbmzZDDRk2bqcPd2f8Jo5EgmWiv6bHhJs3v6/iZ6UERoyqeIDqBSZ
 il06JQBBkkWaigZBFJrrJ7giqUPsxiC/6UnP1fmkGhK4KdRIc9erJF8eH9ZoOoq4wfL2
 mgtgRS6grh9oxFakXlWFYW09ZVkl/zl4zEt/fHCFKRgxpv2hQPa+dkzdDZKRYtlppoyu
 j6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782155171; x=1782759971;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GOpYLqYb0m0OlIH0rl7mRp0VlvhMTNSJwAYjKLT4+U0=;
 b=GcdeMgCGctp3UoM+SfgWA46vXYWkLiFlOC7y9W4ScRv2TnWqH2Rj3eMAvmSaYt+sbm
 LsVepDEnBMWa11g1OwX+OnAe5jj1XtH3O91IllZbsWv7WdxKiUoxjhjsdKzugYauCQ/O
 8j83mRMC7ohSAaTo/nDndo33MZiL4+GkezM7Orf8cv/h38tg07x34CLN32sZTCmqE9tK
 uGFRvvgvK423Gd94R3EKx0X3iziuaMLG8C0vDmQOIJVJ/WJWW+GFgEzTlxfuYfyp62ju
 0dgl8D7VjEZFhX7GLFYUksoh1YikuSjPnEGw8eGKJLtXEQ2MAwlLlvU/v+rKyly5yJ7w
 V0MA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XStYXMrkhL/HLkwv1g4MjZFbuDBP616MH8uiVDZK2s7ypedx0TfGzLMZ5cdv62lxT2NmJJxp5mlD6@nongnu.org
X-Gm-Message-State: AOJu0YzJLhhGIlTe++/crdPhDKZZ2L6nKCYzaqEjk8EL84rGCX5r09Dw
 UoceiNbj7pWwiR8hfg2s+pc1JBrIeol7gw6mBctphGcu7WuiMmtK3Jv3DmZzQJCb5pN5gPyuaDF
 Jbolyf32X
X-Received: from pfbiv3.prod.google.com ([2002:a05:6a00:66c3:b0:845:4ca2:60a5])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e07:b0:842:7476:236e
 with SMTP id d2e1a72fcca58-845508f2bcamr16003144b3a.41.1782155171130; Mon, 22
 Jun 2026 12:06:11 -0700 (PDT)
Date: Mon, 22 Jun 2026 19:05:44 +0000
In-Reply-To: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
Mime-Version: 1.0
References: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260622-igb-trl-v7-7-abb960e767ac@google.com>
Subject: [PATCH v7 7/7] igb: Add QTest for Transmit Rate Limiter traffic
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3o4c5agcKCvAbjZadcWYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x449.google.com
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
 tests/qtest/igb-test.c | 155 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index 0a4d0b1..31f2bbe 100644
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
     return ((1000000000ULL / BITS_PER_BYTE) << 14) / rate_bytes_s;
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
+                   vector_offset + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                   val & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
+
+    /* Mask again */
+    qpci_io_writel(dev, dev->msix_table_bar,
+                   vector_offset + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                   val);
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
@@ -240,6 +325,74 @@ static void test_igb_transmit_rate_limiter_regs(void *obj, void *data,
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
+    /* Enable TRL and set the target rate to 125 KB/s */
+    igb_trl_enable(d, 125000);
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
@@ -298,6 +451,8 @@ static void register_igb_test(void)
                  test_igb_multiple_transfers, &opts);
     qos_add_test("transmit_rate_limiter_regs", "igb",
                  test_igb_transmit_rate_limiter_regs, &opts);
+    qos_add_test("transmit_rate_limiter", "igb",
+                 test_igb_transmit_rate_limiter, &opts);
 #endif
 
     opts.before = data_test_init_no_socket;

-- 
2.55.0.rc0.786.g65d90a0328-goog


