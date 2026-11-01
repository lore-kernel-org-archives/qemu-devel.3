Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266E606A326
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=xADoIP5e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWMN-0002Z4-Hr; Sun, 01 Nov 2026 09:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <holypumpkin@foxmail.com>)
 id 1xNWMK-0002YV-Qz
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:16:32 -0500
Received: from out203-205-221-240.mail.qq.com ([203.205.221.240])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <holypumpkin@foxmail.com>)
 id 1xNWMH-0006zz-7l
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1793542583;
 bh=e1ysYkcJNsBjJKvoc4AwVmFE0AnFxAHCf8/jKHt+n1w=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=xADoIP5eQpLHa4DGysCEg4YXyH8c9aL+Fg79ft0jC038dZbQYa5n1OhxfMIufzHvo
 X0QMNIt4aQjgakVumax87g0CgD55+AS8gkQuN1OCZNhQBdswjqyJneZVZ7KhL9QZdZ
 zMWglk19O819t/nemhGBTT+Fs+Z310W/xFFVHC0A=
Received: from localhost.localdomain ([113.200.174.63])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 3F3BBA98; Sun, 01 Nov 2026 22:15:51 +0800
X-QQ-mid: xmsmtpt1793542579t3ehyzgkk
Message-ID: <tencent_9943453AD72E45ED5AD06D76CD8AC30BC706@qq.com>
X-QQ-XMAILINFO: NnIX2CK8LSsJ30OempvuAafcZW6Kh5cV+a/uDA6hB6fO1jIqX4X9S92WEGLEnw
 ss5hzb68oD3cObqfBisW4Ez2nC9YAFkwPQfq+KIOzIruNl+ZWQ82e94TtBYzyFH7WHH5gG84L4XV
 PUAS7c86E5LhuVBwIMdarjxbJ8eHP2j6+WeWXL1C6/p/mKo3C0uJDCtfT7PIeXY6FjXGWgsapGEy
 ICPwabHwcHVTupTiAj11ybkfBvRUT/rjDsYeI6A+5p6YmwkSmHVXDv0auKvERmjfxvAOcm+Ov9i0
 YwVdgIHUw8/3Gkzw54+60rklWjZgLxcC+ZmsXojnuAYjQc58Z2b3uKkXjztM1e+9SgVY46Q5XElu
 yQTFfUVrS6x+UZnK0SP9m733/HsoX+jlyXTFl1fNqsxmaTtm5brVjboGQJSz9Ld2GlR6VRzH8Oph
 KudKSywAKv2hs0HNDFcmHJGg+EoAX/6Dks/PDD/o4P55/zrpjNu6wo/JGwZKMCXq6ohHwCDtCLr8
 ErQAYZIc6uT8wH+EsknqCYq8figwGa50eyoDtdliCwRzABmBs5Tw/adfxc3ngcY/WPHObUPUxIaY
 i6Xwo4hCQunr9frWMty2AHRsJN9CJmXecF+vm24oUU2FDFWjWvOyUU5pcXPrIutiBcapDM1Adgvc
 p2F9940MEMMTfeWpX+lU9NG3twuGY9QyD5M74ivZ3wwKonctO/9/QX4xyCzMdO1eN4OrpmURD1Es
 UXOQbVN78tKjXzWCwGEuEDDpbrn8OXIrrD7elv8DmrGXoPQ9/BkfbJM3S4qs9UKTAFK/r6sQcyIm
 rleKV4/jrykKM1tBuzQlPFMJICEFAOc0NEfATkCrLwIpSQ+rItKeYmfOq7bSXA3cBIIk6Rj8y6sN
 BmHmeTYIFebVqJB2ZhfbrW14SAu5QrOjIyWUa1M6OwHo2DreL5dx/+u4a/5cURwWIPWaIiE4rr4I
 aGxCQ/YW0RUNccKrb+CJwOBNHVWrNm8Bry1tP1pQd6MoRpbsaDEuunqwD2SgBRNHDNQZzhrUgPyF
 pqcVGWojPoqavq5fH9KpvQgI29+6zU3AiViE2YiSWG6sH5Agy1Dtbdfd/ab3U5yQrW4QGpjBi2Gb
 AXpa28ZflSr6/b7GQfHxo6SOAI4Ck+YhDA8CkcSx2+x6HMxcRlVKylquVDxIiBYGOp9u/d
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Haoyu Nan <Holypumpkin@foxmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/2] hw/riscv/virt: batch VirtIO MMIO mapping updates
Date: Sun,  1 Nov 2026 22:15:40 +0800
X-OQ-MSGID: <20261101141540.2021-3-Holypumpkin@foxmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <20261101141540.2021-1-Holypumpkin@foxmail.com>
References: <20261101141540.2021-1-Holypumpkin@foxmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.240;
 envelope-from=holypumpkin@foxmail.com; helo=out203-205-221-240.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The virt machine creates its VirtIO MMIO transports one at a time.
Each transport maps its register region while the board is still
being initialized, publishing intermediate memory topology updates.

Enclose the transport creation loop in a memory region transaction
so that its mappings are published together at commit. Keep each
transport's creation, address and interrupt connection unchanged.
The transaction is committed before initializing the following board
devices and before any guest execution.

Add a QTest case that checks all eight transport register windows,
the attached RNG device and guest RAM access. Verify the transport
registers again after system reset. Exercise both legacy and modern
transports with one, two and four vCPUs.
---
 MAINTAINERS                        |  2 +
 hw/riscv/virt.c                    |  3 ++
 tests/qtest/meson.build            |  3 ++
 tests/qtest/riscv-virt-mmio-test.c | 65 ++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+)
 create mode 100644 tests/qtest/riscv-virt-mmio-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 70e9fed776..a6a2c027eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -387,6 +387,7 @@ F: tests/functional/riscv64
 F: tests/tcg/riscv32/
 F: tests/tcg/riscv64/
 F: tests/qtest/iommu-riscv-test.c
+F: tests/qtest/riscv-virt-mmio-test.c
 
 RISC-V XThead* extensions
 M: Christoph Muellner <christoph.muellner@vrull.eu>
@@ -3755,6 +3756,7 @@ F: scripts/qom-cast-macro-clean-cocci-gen.py
 F: qom/
 F: stubs/qom-compat-properties.c
 F: tests/unit/check-qom-interface.c
+F: tests/unit/check-qom-enumeration.c
 F: tests/unit/check-qom-proplist.c
 F: tests/qtest/qom-test.c
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index de1c92463a..c4f06bcdcf 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -898,11 +898,14 @@ static void virt_machine_init(MachineState *machine)
     sifive_test_create(s->memmap[VIRT_TEST].base);
 
     /* VirtIO MMIO devices */
+    /* Publish the transport mappings together before any guest execution. */
+    memory_region_transaction_begin();
     for (i = 0; i < VIRTIO_COUNT; i++) {
         sysbus_create_simple("virtio-mmio",
             s->memmap[VIRT_VIRTIO].base + i * s->memmap[VIRT_VIRTIO].size,
             qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
     }
+    memory_region_transaction_commit();
 
     riscv_gpex_pcie_init(system_memory, pcie_irqchip,
                    &s->memmap[VIRT_PCIE_ECAM], &s->memmap[VIRT_PCIE_MMIO],
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 46d4fc1d2b..2cc4fe71cd 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -313,6 +313,9 @@ qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
 qtests_riscv64 = ['riscv-csr-test'] + \
+  (config_all_devices.has_key('CONFIG_RISCV_VIRT') and
+   config_all_devices.has_key('CONFIG_VIRTIO_RNG') ?
+   ['riscv-virt-mmio-test'] : []) + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
diff --git a/tests/qtest/riscv-virt-mmio-test.c b/tests/qtest/riscv-virt-mmio-test.c
new file mode 100644
index 0000000000..3c55b37f51
--- /dev/null
+++ b/tests/qtest/riscv-virt-mmio-test.c
@@ -0,0 +1,65 @@
+/*
+ * Check RISC-V virt MMIO transports before and after reset.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define VIRTIO_BASE 0x10001000
+#define VIRTIO_STRIDE 0x1000
+#define VIRTIO_TRANSPORTS 8
+
+static void check_transports(QTestState *qts, bool modern)
+{
+    unsigned attached = 0;
+
+    for (unsigned i = 0; i < VIRTIO_TRANSPORTS; i++) {
+        uint64_t base = VIRTIO_BASE + i * VIRTIO_STRIDE;
+        uint32_t device = qtest_readl(qts, base + 8);
+
+        g_assert_cmphex(qtest_readl(qts, base), ==, 0x74726976);
+        g_assert_cmpuint(qtest_readl(qts, base + 4), ==, modern ? 2 : 1);
+        g_assert_cmpuint(qtest_readl(qts, base + 0x70), ==, 0);
+        if (device) {
+            g_assert_cmpuint(device, ==, 4);
+            attached++;
+        }
+    }
+    g_assert_cmpuint(attached, ==, 1);
+}
+
+static void test_transports(gconstpointer opaque)
+{
+    unsigned setting = GPOINTER_TO_UINT(opaque);
+    unsigned cpus = 1U << (setting / 2);
+    bool modern = setting % 2;
+    QTestState *qts = qtest_initf(
+        "-machine virt -bios none -m 64M -smp %u -nodefaults "
+        "-global virtio-mmio.force-legacy=%s -device virtio-rng-device",
+        cpus, modern ? "false" : "true");
+
+    check_transports(qts, modern);
+    qtest_writel(qts, 0x80001000, 0x12345678);
+    g_assert_cmphex(qtest_readl(qts, 0x80001000), ==, 0x12345678);
+    qtest_system_reset(qts);
+    check_transports(qts, modern);
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (qtest_has_machine("virt")) {
+        for (unsigned setting = 0; setting < 6; setting++) {
+            g_autofree char *name = g_strdup_printf(
+                "/riscv/virt/mmio/%u-cpus/%s", 1U << (setting / 2),
+                setting % 2 ? "modern" : "legacy");
+
+            qtest_add_data_func(name, GUINT_TO_POINTER(setting),
+                                test_transports);
+        }
+    }
+    return g_test_run();
+}
-- 
2.47.0.windows.1


