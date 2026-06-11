Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6229CD98CC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXpLt-0002B4-3E; Thu, 11 Jun 2026 20:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <30iQragcKCiEGOEFIHBDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--jrhilke.bounces.google.com>)
 id 1wXmhs-000106-9n
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:58 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <30iQragcKCiEGOEFIHBDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--jrhilke.bounces.google.com>)
 id 1wXmhq-0003vw-FS
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:55 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-8423770d72dso361269b3a.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781212371; x=1781817171; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=vT+G6PpVv3/b6AactbiPBfLDgfqkldAmvTCmGPSl+Vg=;
 b=Bjx/sjt9U/V6Yz3zR5ibk9XZ/3cZ6D2m7HEc+e6pFKdoXjDLWQ4ADvYwDORSpna2xt
 iaTizK6EGfr6ntXeK5brMCuMXClFXDKhQ8rQED0/P2j2vcIyKcxOp09squPxW/XrF17F
 zpWWTYj9Jj34z3oPDUjOTb2RrXYKTScy2SaQUeUFynDO7fm+J0LV92yTEytSKTuz5z79
 GeCOwua1eeVxz95zLfKpxy2jGnyg1IP4kzDuhFgQ1ZVMuQcMhpEHt2Bq/NJOrGi+XagV
 WbaRWjD41IjAEQMWHsO93FuFFR6fdM8Bd5gWx4bkrxExSCKzG2Y3/AD23f1KCVMbnZ/j
 3Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212371; x=1781817171;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vT+G6PpVv3/b6AactbiPBfLDgfqkldAmvTCmGPSl+Vg=;
 b=j75PGdYsrqDahwbsNRYw21tWnQd8iXKIYm/a+8+WYG0qQWb9inRMMaVFq7z/lwMa09
 3QXA8lPpS+8s8mKrvNso6fUuuh5GQ7rutTWGDLZ+NQxXbeUDHyFSTsuefcYySyBzdQ6h
 oBa3anDsbQDKYuaPuKCEnjcYnNBNgiBoysgoQB77Xx9WCN8SrOuiS/R0smL8REadIu8o
 hLQKeBwXW2WFtYLXa6A/LcuJta+9vqM3RFfMfbdhpOd8NQH7zvlWircOGSxQTKYzhmjH
 lxaBhCMD97J2VP8jTLQQHrb/g9OZXkUSSDBbNOQY3TvDmgZzQedenL/0MeLSgr3jPMnl
 K1eQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fij8z2rNAnV3P/ZeMnYmM36hzrHOwRwyjKQC8opw9d2YvFLbv25AbmpiuDjdAEZj86h6y9RKiSJFd@nongnu.org
X-Gm-Message-State: AOJu0Yzh4oiKEuKg6moeeka69W5PDp4++InxkIk5hS36zE3cW7bEXV+B
 s/JXLbTn70EocMc5mEj870pYBjgtU+k2t3+EjmPe9fSxsyBsNzQeMOu2q1UQD7JmkCYO74Q+gZs
 tHRtolxtE
X-Received: from pfbho5.prod.google.com ([2002:a05:6a00:8805:b0:835:2a09:221c])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4512:b0:82c:b808:4c59
 with SMTP id d2e1a72fcca58-84336bde6aamr5245505b3a.46.1781212370541; Thu, 11
 Jun 2026 14:12:50 -0700 (PDT)
Date: Thu, 11 Jun 2026 21:11:31 +0000
In-Reply-To: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
Mime-Version: 1.0
References: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260611-igb-trl-v2-6-bd58de9eb0fa@google.com>
Subject: [PATCH v2 6/7] igb: Add QTest for Transmit Rate Limiter register
 multiplexing
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=30iQragcKCiEGOEFIHBDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jun 2026 20:02:23 -0400
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

Add a unit test to verify register writes/reads to the rate limit
register (TRLC) return the correct value based on which queue is
currently selected in the queue selection register (TRLDQSEL).

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 tests/qtest/igb-test.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index 3d397ea..119be6a 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -45,6 +45,20 @@ static const struct eth_header packet = {
     .h_source = E1000E_ADDRESS,
 };
 
+/*
+ * Calculate TRL rate factor for a given target rate.
+ *
+ * Rate Factor = 1 Gbps / Target Rate.
+ *
+ * The hardware TRLRC register stores the rate factor as a fixed-point number
+ * with 14 fractional bits. Scale 1Gbps by 2^14 before dividing to preserve
+ * precision in integer arithmetic.
+ */
+static uint32_t igb_trl_get_rate_factor(uint64_t rate_bytes_s)
+{
+    return (E1000_LINK_RATE_1GBPS << 14) / rate_bytes_s;
+}
+
 static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *alloc)
 {
     union e1000_adv_tx_desc descr;
@@ -191,6 +205,41 @@ static void test_igb_multiple_transfers(void *obj, void *data,
 
 }
 
+/*
+ * Verify the rate limit value register (TRLC) returns the correct value based
+ * on which queue is selected (TRLDQSEL).
+ */
+static void test_igb_transmit_rate_limiter_regs(void *obj, void *data,
+                                                QGuestAllocator *alloc)
+{
+    QOSGraphObject *e_object = obj;
+    QE1000E_PCI *e1000e = obj;
+    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
+    QE1000E *d = &e1000e->e1000e;
+    const int qidx0 = 0, qidx1 = 1;
+    uint32_t val0, val1;
+
+    if (qpci_check_buggy_msi(dev)) {
+        return;
+    }
+
+    e1000e_macreg_write(d, E1000_TRLDQSEL, qidx0);
+    val0 = E1000_TRLRC_RS_ENA |
+           igb_trl_get_rate_factor(E1000_LINK_RATE_1GBPS / 1000);
+    e1000e_macreg_write(d, E1000_TRLRC, val0);
+
+    e1000e_macreg_write(d, E1000_TRLDQSEL, qidx1);
+    val1 = E1000_TRLRC_RS_ENA |
+           igb_trl_get_rate_factor(E1000_LINK_RATE_1GBPS / 500);
+    e1000e_macreg_write(d, E1000_TRLRC, val1);
+
+    e1000e_macreg_write(d, E1000_TRLDQSEL, qidx0);
+    g_assert_cmphex(e1000e_macreg_read(d, E1000_TRLRC), ==, val0);
+
+    e1000e_macreg_write(d, E1000_TRLDQSEL, qidx1);
+    g_assert_cmphex(e1000e_macreg_read(d, E1000_TRLRC), ==, val1);
+}
+
 static void data_test_clear(void *sockets)
 {
     int *test_sockets = sockets;
@@ -247,6 +296,8 @@ static void register_igb_test(void)
     qos_add_test("rx", "igb", test_igb_rx, &opts);
     qos_add_test("multiple_transfers", "igb",
                  test_igb_multiple_transfers, &opts);
+    qos_add_test("transmit_rate_limiter_regs", "igb",
+                 test_igb_transmit_rate_limiter_regs, &opts);
 #endif
 
     opts.before = data_test_init_no_socket;

-- 
2.54.0.1136.gdb2ca164c4-goog


