Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919B4CDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbjyI-0000ZA-Rt; Mon, 22 Jun 2026 15:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3oYc5agcKCu4ZhXYbaUWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--jrhilke.bounces.google.com>)
 id 1wbjyH-0000Yo-DD
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:06:13 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3oYc5agcKCu4ZhXYbaUWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--jrhilke.bounces.google.com>)
 id 1wbjyF-0002m2-QL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:06:13 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-36d97a4e08fso3438833a91.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782155170; x=1782759970; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=F2v9cyEeXLMRxY4RJyY8ilPvdLI29m6QducxNaUF4Io=;
 b=a/tTUDZzuJQs1LyniwMSe1AcFoA9mQ+yKYr8erdGdeyH6Xo+UnM1auPsiaCvv7XNGS
 DoAqW16UHfXCC1eKx9rGPYD9+zFGGy+qqCQZVSzi2orKGao6tTK6GOUAGi4NxvS5KaU0
 ZBWtuLSoh97o+Mjg7fMqqBFEpM8UahL64ZZWJii1mvvGTD3tr03i5BmgNSTD0uMeJ9Vk
 l/s5XW93ugYkz29N+bssEBJq4MovwkPrbRcfQV6r8ncZroyPPP162C70cwp4/O9v17Gg
 qnci3IXWlY0G08atsr7e+/qKZwoPK3uyXSqaqLN+88vJlM0ZjC1pbQzoTCK466jJx9Gb
 duHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782155170; x=1782759970;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F2v9cyEeXLMRxY4RJyY8ilPvdLI29m6QducxNaUF4Io=;
 b=TaHOhKHPJMXA4bHF04D9f7qPBEVLxVIaZczFyh0savyH4+SX6b60IuQmlE/82JwXIz
 5Mnn03mYd1i3OPRaMzTjRrlfC3wkkVdbjo9JhmZoQAMVIl2XkZCckmLMjEwzEVw9fky6
 F5UUYMK4YfryBDLq2nNiqJMYil90p0eUnt6/kR/J8ih4YfxUH3H6WUVyxNZ4tzkMvkEn
 5juMk3OB8Hnl/1bWwiz+mNxxIbS8zCiaJdBhGVV5sse1wMV/y8VMLKQJ6i9WaBfBOdFQ
 eMay4UDPuQmy7b4/r5n/6UVUKIL+SRwq2QHedmWEpQUhiwRDYzw9D0d1sDqMFo8uXzvV
 VjGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwTueVXvdUzNYIOeOHKxdinnqTvABx6weupEqCtNIxkBeIYYUKAbisYbdN9ShupVYvCZbbLzF0cICh@nongnu.org
X-Gm-Message-State: AOJu0YyGhPWrRem24WkeirABrijE9PgTY/H4xzrXSTzPPEeX781txiUG
 meNili0iK1ZZy4s9ouZrazfIoirkfbmIpmA5hXU45LCeczDCDhue8p3h1iAp2OL5Egrd1Qa83rW
 lKsf4SojT
X-Received: from pjboj13.prod.google.com ([2002:a17:90b:4d8d:b0:37d:cda8:9a1])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a51:b0:377:424b:59e3
 with SMTP id 98e67ed59e1d1-37d15ed439cmr16875442a91.24.1782155169009; Mon, 22
 Jun 2026 12:06:09 -0700 (PDT)
Date: Mon, 22 Jun 2026 19:05:43 +0000
In-Reply-To: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
Mime-Version: 1.0
References: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260622-igb-trl-v7-6-abb960e767ac@google.com>
Subject: [PATCH v7 6/7] igb: Add QTest for Transmit Rate Limiter register
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3oYc5agcKCu4ZhXYbaUWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--jrhilke.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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
index 3d397ea..0a4d0b1 100644
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
+    return ((1000000000ULL / BITS_PER_BYTE) << 14) / rate_bytes_s;
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
+           igb_trl_get_rate_factor(125000);
+    e1000e_macreg_write(d, E1000_TRLRC, val0);
+
+    e1000e_macreg_write(d, E1000_TRLDQSEL, qidx1);
+    val1 = E1000_TRLRC_RS_ENA |
+           igb_trl_get_rate_factor(250000);
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
2.55.0.rc0.786.g65d90a0328-goog


