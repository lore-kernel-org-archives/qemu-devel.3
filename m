Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53903606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 07:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSUwh-0008WM-05; Sun, 15 Nov 2026 02:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSUwT-0008Tw-Mb; Sun, 15 Nov 2026 02:46:26 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSUwP-0004op-Ah; Sun, 15 Nov 2026 02:46:25 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwCnr1tKY_lq5EEHAg--.41914S2; 
 Sun, 15 Nov 2026 15:46:18 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwFnQ_Y_lqF+j6AA--.34770S8;
 Sun, 15 Nov 2026 15:46:17 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Chao Liu <chao.liu@processmission.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 5/5] [NOT-MERGE] tests/qtest: add q35 SMM-only x86 attrs
 coverage
Date: Sun, 15 Nov 2026 15:46:07 +0800
Message-Id: <20261115074607.456045-6-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261115074607.456045-1-tangtao1634@phytium.com.cn>
References: <20261115074607.456045-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwFnQ_Y_lqF+j6AA--.34770S8
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWr4tsgAeAAAsQ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Ar43Gw43WrWDKF48tF1DKFg_yoWDGFyrpF
 y5CFnIkF4av3WxZan8Ja17G3WF9Fs3Cay8WrW5Jwn5Ca18CF9FyryqkFyvqrnrJrW0vw1r
 u3WDJFZrGas8taDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 include/hw/pci-host/q35.h          |   8 ++
 hw/pci-host/q35.c                  |  27 +++++
 tests/qtest/qtest-x86-attrs-test.c | 175 +++++++++++++++++++++++++++++
 tests/qtest/meson.build            |   1 +
 4 files changed, 211 insertions(+)
 create mode 100644 tests/qtest/qtest-x86-attrs-test.c

diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index f31a71010b6..5ba7541d321 100644
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
 #define MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK      ((uint64_t)(1 << 27))
 #define MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK       ((uint64_t)(1 << 26))
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index d53441561f5..11671e15c74 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -640,12 +640,19 @@ static void mch_realize(PCIDevice *d, Error **errp)
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
 
@@ -676,6 +683,24 @@ static void mch_realize(PCIDevice *d, Error **errp)
 
     if (mch->has_smm_ranges) {
         mch_init_smram_regions(mch);
+
+        if (mch->enable_smm_test_ram) {
+            /*
+             * This is a QEMU-specific, test-only region. It is mapped only
+             * into mch->smram so qtest can verify that x86 secure attrs
+             * select the SMM address space rather than the default one.
+             */
+            memory_region_init_ram(&mch->smm_test_ram, OBJECT(mch),
+                                   "smm-test-ram",
+                                   MCH_HOST_BRIDGE_SMM_TEST_RAM_SIZE, errp);
+            if (*errp) {
+                return;
+            }
+            memory_region_add_subregion(&mch->smram,
+                                        MCH_HOST_BRIDGE_SMM_TEST_RAM_BASE,
+                                        &mch->smm_test_ram);
+        }
+
         object_property_add_const_link(qdev_get_machine(), "smram",
                                        OBJECT(&mch->smram));
     }
@@ -685,6 +710,8 @@ static const Property mch_props[] = {
     DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
                        64),
     DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
+    DEFINE_PROP_BOOL("x-smm-test-ram", MCHPCIState, enable_smm_test_ram,
+                     false),
 };
 
 static void mch_class_init(ObjectClass *klass, const void *data)
diff --git a/tests/qtest/qtest-x86-attrs-test.c b/tests/qtest/qtest-x86-attrs-test.c
new file mode 100644
index 00000000000..0d39b2ef8ca
--- /dev/null
+++ b/tests/qtest/qtest-x86-attrs-test.c
@@ -0,0 +1,175 @@
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
+    if (!qtest_has_accel("tcg")) {
+        g_test_skip("TCG accelerator not available");
+        return 0;
+    }
+
+    qtest_add_func("/qtest/x86/attrs/scalar", test_x86_scalar_attrs);
+    qtest_add_func("/qtest/x86/attrs/bulk", test_x86_bulk_attrs);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 9b08369d3bb..94479b4757d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -129,6 +129,7 @@ qtests_i386 = \
    'cpu-plug-test',
    'migration-test',
    'qtest-attrs-test',
+   'qtest-x86-attrs-test',
   ]
 
 if dbus_display and config_all_devices.has_key('CONFIG_VGA')
-- 
2.34.1


