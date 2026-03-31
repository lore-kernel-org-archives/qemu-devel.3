Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E632FF60C3
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 04:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7QOT-000133-9m; Tue, 31 Mar 2026 00:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w7QOL-0000zZ-Qa; Tue, 31 Mar 2026 00:07:50 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w7QOI-0002Gy-EZ; Tue, 31 Mar 2026 00:07:49 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3fpqNSMtp8YjBCA--.55S2;
 Tue, 31 Mar 2026 12:07:41 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwSJR6SMtpYqQHAA--.18366S7;
 Tue, 31 Mar 2026 12:07:39 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH 4/4] [NOT-MERGE] tests/qtest: add q35 SMM-only x86 attrs
 coverage
Date: Tue, 31 Mar 2026 12:06:59 +0800
Message-Id: <20260331040659.401397-5-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331040659.401397-1-tangtao1634@phytium.com.cn>
References: <20260331040659.401397-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwSJR6SMtpYqQHAA--.18366S7
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQALBWnKzfEBswABsj
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Ar43Gw43WF4rCF1DCryUKFg_yoWDGr1fpF
 y5CFnIkF4ay3WxZa1DJa17G3WF9Fs3Ca4UurWUGwnYka18CF9FyryqkFyvqrnrJrW0vw1r
 Z3WDJFsrG3Z8taDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a q35-only test path for x86 secure attrs by introducing an optional
test-only RAM region that is mapped only into the SMM address space.

The new qtest-x86-attrs-test enables this region with
`-global mch.x-smm-test-ram=on` and verifies that accesses with the
`secure` attribute reach the SMM-only region, while default accesses do
not. This provides the x86 cross-verification that qtest-attrs-test does
not cover, where normal RAM is visible from both the default and SMM
address spaces.

This is a NOT-MERGE commit.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/pci-host/q35.c                  |  26 +++++
 include/hw/pci-host/q35.h          |   8 ++
 tests/qtest/meson.build            |   1 +
 tests/qtest/qtest-x86-attrs-test.c | 170 +++++++++++++++++++++++++++++
 4 files changed, 205 insertions(+)
 create mode 100644 tests/qtest/qtest-x86-attrs-test.c

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e85e4227b3..5b222847b3 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -566,12 +566,19 @@ static void mch_realize(PCIDevice *d, Error **errp)
     int i;
     MCHPCIState *mch = MCH_PCI_DEVICE(d);
 
+    ERRP_GUARD();
+
     if (mch->ext_tseg_mbytes > MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX) {
         error_setg(errp, "invalid extended-tseg-mbytes value: %" PRIu16,
                    mch->ext_tseg_mbytes);
         return;
     }
 
+    if (mch->enable_smm_test_ram && !mch->has_smm_ranges) {
+        error_setg(errp, "x-smm-test-ram requires SMM support");
+        return;
+    }
+
     /* setup pci memory mapping */
     pc_pci_as_mapping_init(mch->system_memory, mch->pci_address_space);
 
@@ -653,6 +660,23 @@ static void mch_realize(PCIDevice *d, Error **errp)
     memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMBASE_ADDR,
                                 &mch->smbase_window);
 
+    if (mch->enable_smm_test_ram) {
+        /*
+         * This is a QEMU-specific, test-only region. It is mapped only into
+         * mch->smram so qtest can verify that x86 secure attrs select the SMM
+         * address space rather than the default one.
+         */
+        memory_region_init_ram(&mch->smm_test_ram, OBJECT(mch),
+                               "smm-test-ram",
+                               MCH_HOST_BRIDGE_SMM_TEST_RAM_SIZE, errp);
+        if (*errp) {
+            return;
+        }
+        memory_region_add_subregion(&mch->smram,
+                                    MCH_HOST_BRIDGE_SMM_TEST_RAM_BASE,
+                                    &mch->smm_test_ram);
+    }
+
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&mch->smram));
 }
@@ -661,6 +685,8 @@ static const Property mch_props[] = {
     DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
                        64),
     DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
+    DEFINE_PROP_BOOL("x-smm-test-ram", MCHPCIState, enable_smm_test_ram,
+                     false),
 };
 
 static void mch_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index ddafc3f2e3..1ca26f0e63 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -49,8 +49,10 @@ struct MCHPCIState {
     MemoryRegion smram, low_smram, high_smram;
     MemoryRegion tseg_blackhole, tseg_window;
     MemoryRegion smbase_blackhole, smbase_window;
+    MemoryRegion smm_test_ram;
     bool has_smram_at_smbase;
     bool has_smm_ranges;
+    bool enable_smm_test_ram;
     Range pci_hole;
     uint64_t below_4g_mem_size;
     uint64_t above_4g_mem_size;
@@ -99,6 +101,12 @@ struct Q35PCIHost {
 #define MCH_HOST_BRIDGE_PCIEXBAR_SIZE          8       /* 64bit register */
 #define MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT       0xb0000000
 #define MCH_HOST_BRIDGE_PCIEXBAR_MAX           (0x10000000) /* 256M */
+/*
+ * Optional qtest-only RAM window used to expose an address that exists only
+ * in the SMM address space, so x86 secure attrs can be cross-checked.
+ */
+#define MCH_HOST_BRIDGE_SMM_TEST_RAM_BASE      0xfef00000
+#define MCH_HOST_BRIDGE_SMM_TEST_RAM_SIZE      (64 * KiB)
 #define MCH_HOST_BRIDGE_PCIEXBAR_ADMSK         Q35_MASK(64, 35, 28)
 #define MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK      ((uint64_t)(1 << 26))
 #define MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK       ((uint64_t)(1 << 25))
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 87aa104d23..fcdd95bf7f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -116,6 +116,7 @@ qtests_i386 = \
    'cpu-plug-test',
    'migration-test',
    'qtest-attrs-test',
+   'qtest-x86-attrs-test',
   ]
 
 if dbus_display and config_all_devices.has_key('CONFIG_VGA')
diff --git a/tests/qtest/qtest-x86-attrs-test.c b/tests/qtest/qtest-x86-attrs-test.c
new file mode 100644
index 0000000000..068ee8b7d3
--- /dev/null
+++ b/tests/qtest/qtest-x86-attrs-test.c
@@ -0,0 +1,170 @@
+/*
+ * QTest for x86 memory access with transaction attributes
+ *
+ * Verify q35 SMM address-space access with the secure attribute.
+ *
+ * Copyright (c) 2026 Phytium Technology
+ *
+ * Author:
+ *  Tao Tang <tangtao1634@phytium.com.cn>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "libqtest.h"
+
+#define TEST_ADDR_OFFSET_NS     0x1000ULL
+#define TEST_X86_BASE           0x0ULL
+#define TEST_X86_SMM_BASE       0xfef00000ULL
+
+#define TEST_ADDR_X86           (TEST_X86_BASE + TEST_ADDR_OFFSET_NS)
+
+#define X86_MACHINE_ARGS        "-machine q35,smm=on -m 1G -accel tcg " \
+                                "-global mch.x-smm-test-ram=on"
+
+static void assert_default_scalar_read_isolated(QTestState *qts, uint64_t addr,
+                                                char **before,
+                                                uint8_t secure_value)
+{
+    g_auto(GStrv) after = NULL;
+    uint64_t value;
+    int ret;
+
+    after = qtest_raw_cmd(qts, "readb 0x%" PRIx64 "\n", addr);
+
+    if (g_strcmp0(before[0], "ERR") == 0) {
+        g_assert_cmpstr(after[0], ==, "ERR");
+        return;
+    }
+
+    g_assert_cmpstr(before[0], ==, "OK");
+    g_assert_nonnull(before[1]);
+    g_assert_cmpstr(after[0], ==, "OK");
+    g_assert_nonnull(after[1]);
+    g_assert_cmpstr(after[1], ==, before[1]);
+
+    ret = qemu_strtou64(after[1], NULL, 0, &value);
+    g_assert_cmpint(ret, ==, 0);
+    g_assert_cmpuint(value, !=, secure_value);
+}
+
+static void assert_default_bulk_read_isolated(QTestState *qts, uint64_t addr,
+                                              char **before,
+                                              const uint8_t *expected,
+                                              size_t len)
+{
+    g_auto(GStrv) after = NULL;
+    g_autofree gchar *expected_b64 = NULL;
+
+    expected_b64 = g_base64_encode(expected, len);
+    after = qtest_raw_cmd(qts, "b64read 0x%" PRIx64 " 0x%zx\n", addr, len);
+
+    if (g_strcmp0(before[0], "ERR") == 0) {
+        g_assert_cmpstr(after[0], ==, "ERR");
+        return;
+    }
+
+    g_assert_cmpstr(before[0], ==, "OK");
+    g_assert_nonnull(before[1]);
+    g_assert_cmpstr(after[0], ==, "OK");
+    g_assert_nonnull(after[1]);
+    g_assert_cmpstr(after[1], ==, before[1]);
+    g_assert_cmpstr(after[1], !=, expected_b64);
+}
+
+static void test_x86_scalar_attrs(void)
+{
+    QTestState *qts;
+    g_auto(GStrv) before = NULL;
+    uint8_t val;
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    qts = qtest_init(X86_MACHINE_ARGS);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_X86, 0x11, NULL);
+    val = qtest_readb_attrs(qts, TEST_ADDR_X86, NULL);
+    g_assert_cmpuint(val, ==, 0x11);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_X86 + 0x1, 0x22, "secure");
+    val = qtest_readb_attrs(qts, TEST_ADDR_X86 + 0x1, "secure");
+    g_assert_cmpuint(val, ==, 0x22);
+
+    before = qtest_raw_cmd(qts, "readb 0x%" PRIx64 "\n",
+                           (uint64_t)(TEST_X86_SMM_BASE + 0x2));
+    qtest_writeb_attrs(qts, TEST_X86_SMM_BASE + 0x2, 0x33, "secure");
+    val = qtest_readb_attrs(qts, TEST_X86_SMM_BASE + 0x2, "secure");
+    g_assert_cmpuint(val, ==, 0x33);
+    assert_default_scalar_read_isolated(qts, TEST_X86_SMM_BASE + 0x2,
+                                        before, 0x33);
+
+    qtest_quit(qts);
+}
+
+static void test_x86_bulk_attrs(void)
+{
+    QTestState *qts;
+    g_auto(GStrv) before = NULL;
+    uint8_t wbuf[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };
+    uint8_t rbuf[8];
+    size_t i;
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    qts = qtest_init(X86_MACHINE_ARGS);
+
+    qtest_memwrite_attrs(qts, TEST_ADDR_X86 + 0x100, wbuf, sizeof(wbuf), NULL);
+    qtest_memread_attrs(qts, TEST_ADDR_X86 + 0x100, rbuf, sizeof(rbuf), NULL);
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_memwrite_attrs(qts, TEST_ADDR_X86 + 0x180,
+                         wbuf, sizeof(wbuf), "secure");
+    qtest_memread_attrs(qts, TEST_ADDR_X86 + 0x180,
+                        rbuf, sizeof(rbuf), "secure");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    before = qtest_raw_cmd(qts, "b64read 0x%" PRIx64 " 0x%zx\n",
+                           (uint64_t)(TEST_X86_SMM_BASE + 0x100),
+                           sizeof(wbuf));
+    qtest_memwrite_attrs(qts, TEST_X86_SMM_BASE + 0x100,
+                         wbuf, sizeof(wbuf), "secure");
+    qtest_memread_attrs(qts, TEST_X86_SMM_BASE + 0x100,
+                        rbuf, sizeof(rbuf), "secure");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+    assert_default_bulk_read_isolated(qts, TEST_X86_SMM_BASE + 0x100, before,
+                                      wbuf, sizeof(wbuf));
+
+    qtest_memset_attrs(qts, TEST_X86_SMM_BASE + 0x120,
+                       0x5a, sizeof(rbuf), "secure");
+    qtest_memread_attrs(qts, TEST_X86_SMM_BASE + 0x120,
+                        rbuf, sizeof(rbuf), "secure");
+    for (i = 0; i < sizeof(rbuf); i++) {
+        g_assert_cmpuint(rbuf[i], ==, 0x5a);
+    }
+
+    qtest_bufwrite_attrs(qts, TEST_X86_SMM_BASE + 0x200,
+                         wbuf, sizeof(wbuf), "secure");
+    qtest_bufread_attrs(qts, TEST_X86_SMM_BASE + 0x200,
+                        rbuf, sizeof(rbuf), "secure");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/qtest/x86/attrs/scalar", test_x86_scalar_attrs);
+    qtest_add_func("/qtest/x86/attrs/bulk", test_x86_bulk_attrs);
+
+    return g_test_run();
+}
-- 
2.34.1


