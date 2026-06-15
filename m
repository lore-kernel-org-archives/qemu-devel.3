Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47653CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZFeS-00050A-29; Mon, 15 Jun 2026 18:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YXowagcKCnAXfVWZYSUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jrhilke.bounces.google.com>)
 id 1wZFeL-0004vv-S7
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:22 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YXowagcKCnAXfVWZYSUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jrhilke.bounces.google.com>)
 id 1wZFeK-0008NQ-6m
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:21 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-8422ca754d8so2879810b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781561954; x=1782166754; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=vT+G6PpVv3/b6AactbiPBfLDgfqkldAmvTCmGPSl+Vg=;
 b=Q6f0d98xfnbeVQqRkZV87X0yv6efrDu5jKQjo1X1yafVq9Sjqbaur8/3+x7K1IIjKG
 iMcqTna7RzQJLYkYcnDiaZWD1+K0NWuHQJ1jWW8Gxue0N2aX9tdR47IR2LprrUGFJaEr
 Jyx/op7GCJ3bbXx+GNzYlFYJx/tXbRDiGkuVb4iboVEzEVYp/yg13r2UNdORvv3Hvc+o
 EhK82StKHpeNZQG+RQBpa58P8xtft725ts7L0t0M0CLttoNh6G7rHnwX/zRrOJz5yMbQ
 yhJapDsv1262pF0yQ4Ese7DroOSKdc4gEc9BTP0XkwyeQPQyfLPdB8pTH/c5ME/dTR/I
 QpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781561954; x=1782166754;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vT+G6PpVv3/b6AactbiPBfLDgfqkldAmvTCmGPSl+Vg=;
 b=IJkje1yqUL8Udvy+4ukCchXmJwk9RF3mS150GXEqCczCz3CfKVUbWnWTpZYR7eU7Lz
 j5R5P8QkxmoJsgbLR6eHsHKtcEbV9wGsHEK1BaUh0SHGm+HpBu27LnHXGTEnOHqq7MsO
 W6XLaHQCsHMJ9BLJh7inNAQRUytRlqp4+Wzz2spiRVp+keCl8sUZ/8z6eqzddMQ78xw0
 tcWM5Xv6eAsTNY+3dKFBsh35lnMn+xiK/9PlMxkskpn/hCeaqonxXRYFeu7kiwdd0n7M
 fcmrhR/7honYYqV3uKqAaCQGQn7QfXMujLg6YT2UHuxn6rPXuVBC3TCjSysm89AonS0K
 Jf5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+J+zfMQXzLT78NA8mW3qvMp7LQO38hbzpoMStcm+8SIPn5ZwYidMi3oDCGK8IzYxsHdUkJzBuNCImB@nongnu.org
X-Gm-Message-State: AOJu0YyCe3xRNzBi443eUd5RjoO1nqbg444fhw7lhcJDyV593AlEYlmn
 klB+6ZeCVUoTjosFbKSsmvJfWKocFHaXxyUIFDzqdJ2CiBqblv6uJnU5CmYn6D8IYdAql5JQrzV
 O8dKMOruW
X-Received: from pfbk13.prod.google.com ([2002:a05:6a00:b00d:b0:842:5f66:324])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88d2:0:b0:835:4291:6975
 with SMTP id d2e1a72fcca58-845155ca464mr666050b3a.39.1781561953580; Mon, 15
 Jun 2026 15:19:13 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:18:08 +0000
In-Reply-To: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
Mime-Version: 1.0
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260615-igb-trl-v4-6-cf5739bf529f@google.com>
Subject: [PATCH v4 6/7] igb: Add QTest for Transmit Rate Limiter register
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
 envelope-from=3YXowagcKCnAXfVWZYSUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x44a.google.com
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


