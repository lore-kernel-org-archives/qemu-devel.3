Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F9BCD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 22:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZcOG-0007Om-G7; Tue, 16 Jun 2026 18:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3188xagcKCpY9H78BA46EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--jrhilke.bounces.google.com>)
 id 1wZcOE-0007Ob-76
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 18:36:14 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3188xagcKCpY9H78BA46EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--jrhilke.bounces.google.com>)
 id 1wZcOA-0001dF-Ql
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 18:36:13 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-c858e0cbca3so2761508a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781649367; x=1782254167; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=vT+G6PpVv3/b6AactbiPBfLDgfqkldAmvTCmGPSl+Vg=;
 b=G/G6/2JZ05T0djuorAbxIwo8R+thkMIVQR/vkPny8lCZhw8rKWq214WcNQ+6FbGfxr
 zlctb6y2tAwy2QmIDhdbxDRPeOZT7TEUcEHCWx5RKCDjEYdKSJWeui6EHpi2nSNEPn7T
 d0ZD2F8OiKqjn+5YcVK6lRIvn3GRPdbH9/bYDeMbGn5mI5sHRSg339oiJXyH3eKqYlu2
 JjaI+w/VN/nRpI27kdeayY9L3C/IVqAeQ792GtaBDQyCTvYDAZ3HRVC6QvGenl7HriUI
 RDIYuuEB7EU3n60ZGuqmY1ckK8XfZkeqzBgY8/MdNwRQIX2l/xL+KifW0LpmSTcd+k53
 mh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781649367; x=1782254167;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vT+G6PpVv3/b6AactbiPBfLDgfqkldAmvTCmGPSl+Vg=;
 b=HXPn37epA0dBC5qfNUcoEMMoV1MQcJdVUgiByAf0OCsZdnWkLgzWzTBZwEyzb4PayF
 W0doJHQKsnKHjyf8LnIEbfzl0XtynwWJBF3GI+VxQp4Hqur1KjOpZbcmS3d/xfZ4HQo/
 z/xTf1LjknVAMeXWKVxqVVZL81dFE7QAAly7mikgeJGDEMxu01hOY2vD73neRhqzeyQX
 Y50fvP4oxqeM8ZyGUr2LXno069EwZwoBNoQBt7ee9SE4WFwRxrHpSlXP5AQGbrGPWao0
 jW4R4NAXFK/TM24b1ZpijyHF6l7fAC0AV+XUwC6iF5aEsQ8fWtrx7/chFzE8X4ZF1YTm
 GfOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fC1FSwb0tcAHbMa3B4y/cteFr1E/HABY6E3KclnWJnnBswT2r+ngjNS0hEg8kmZFhIaF9rjhFzPSU@nongnu.org
X-Gm-Message-State: AOJu0YxP1jfpmAzyhhsB447G6sQpaiS5x8nG2W8QWOUWM5iyQcor7inD
 3zQJG1MwoVoGT4Sqo6L2ixjenAEgaBA6YY1KG2c2YfgrBUtiJcjaBdgcUgz7UzgOI//p957hQQy
 5g+pt5toP
X-Received: from pgve17.prod.google.com ([2002:a65:6491:0:b0:c09:15e9:db4e])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:734e:b0:398:6ea8:21f7
 with SMTP id adf61e73a8af0-3b8b624bb73mr1436313637.15.1781649367228; Tue, 16
 Jun 2026 15:36:07 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:35:33 +0000
In-Reply-To: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
Mime-Version: 1.0
References: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260616-igb-trl-v5-6-1183e3635e06@google.com>
Subject: [PATCH v5 6/7] igb: Add QTest for Transmit Rate Limiter register
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3188xagcKCpY9H78BA46EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--jrhilke.bounces.google.com;
 helo=mail-pg1-x549.google.com
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


