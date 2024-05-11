Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98364C25B4F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 03:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5dd6-0006RB-6t; Fri, 10 May 2024 23:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s5dd3-0006QG-Cp
 for qemu-devel@nongnu.org; Fri, 10 May 2024 23:42:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s5dd0-0003UZ-DJ
 for qemu-devel@nongnu.org; Fri, 10 May 2024 23:42:33 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxFvAg6T5mk_MKAA--.27907S3;
 Sat, 11 May 2024 11:42:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx4VUc6T5m2MkZAA--.30926S5; 
 Sat, 11 May 2024 11:42:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 3/3] tests: Add migration test for loongarch64
Date: Sat, 11 May 2024 11:42:20 +0800
Message-Id: <20240511034220.3030560-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240511034220.3030560-1-maobibo@loongson.cn>
References: <20240511034220.3030560-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx4VUc6T5m2MkZAA--.30926S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds migration test support for loongarch64. The test code
comes from aarch64 mostly, only that it booted as bios in qemu since
kernel requires elf format and bios uses binary format.

In addition to providing the binary, this patch also includes the source
code and the build script in tests/migration/loongarch64. So users can
change the source and/or re-compile the binary as they wish.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Thomas Huth <thuth@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/migration/Makefile                 |  2 +-
 tests/migration/loongarch64/Makefile     | 18 +++++++++
 tests/migration/loongarch64/a-b-kernel.S | 49 ++++++++++++++++++++++++
 tests/migration/loongarch64/a-b-kernel.h | 16 ++++++++
 tests/migration/migration-test.h         |  3 ++
 tests/qtest/meson.build                  |  2 +-
 tests/qtest/migration-test.c             | 10 +++++
 7 files changed, 98 insertions(+), 2 deletions(-)
 create mode 100644 tests/migration/loongarch64/Makefile
 create mode 100644 tests/migration/loongarch64/a-b-kernel.S
 create mode 100644 tests/migration/loongarch64/a-b-kernel.h

diff --git a/tests/migration/Makefile b/tests/migration/Makefile
index 13e99b1692..cfebfe23f8 100644
--- a/tests/migration/Makefile
+++ b/tests/migration/Makefile
@@ -5,7 +5,7 @@
 # See the COPYING file in the top-level directory.
 #
 
-TARGET_LIST = i386 aarch64 s390x
+TARGET_LIST = i386 aarch64 s390x loongarch64
 
 SRC_PATH = ../..
 
diff --git a/tests/migration/loongarch64/Makefile b/tests/migration/loongarch64/Makefile
new file mode 100644
index 0000000000..5d8719205f
--- /dev/null
+++ b/tests/migration/loongarch64/Makefile
@@ -0,0 +1,18 @@
+# To specify cross compiler prefix, use CROSS_PREFIX=
+#   $ make CROSS_PREFIX=loongarch64-linux-gnu-
+
+.PHONY: all clean
+all: a-b-kernel.h
+
+a-b-kernel.h: loongarch64.kernel
+	echo "$$__note" > $@
+	xxd -i $< | sed -e 's/.*int.*//' >> $@
+
+loongarch64.kernel: loongarch64.elf
+	$(CROSS_PREFIX)objcopy -j .text -O binary $< $@
+
+loongarch64.elf: a-b-kernel.S
+	$(CROSS_PREFIX)gcc -o $@ -nostdlib -Wl,--build-id=none $<
+
+clean:
+	$(RM) *.kernel *.elf
diff --git a/tests/migration/loongarch64/a-b-kernel.S b/tests/migration/loongarch64/a-b-kernel.S
new file mode 100644
index 0000000000..cd543345fe
--- /dev/null
+++ b/tests/migration/loongarch64/a-b-kernel.S
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2024 Loongson Technology Corporation Limited
+ */
+#include "../migration-test.h"
+
+#define LOONGARCH_CSR_CRMD          0
+#define LOONGARCH_VIRT_UART         0x1FE001E0
+.section .text
+
+    .globl  _start
+_start:
+    /* output char 'A' to UART16550 */
+    li.d    $t0, LOONGARCH_VIRT_UART
+    li.w    $t1, 'A'
+    st.b    $t1, $t0, 0
+
+    /* traverse test memory region */
+    li.d    $t0, LOONGARCH_TEST_MEM_START
+    li.d    $t1, LOONGARCH_TEST_MEM_END
+    li.d    $t2, TEST_MEM_PAGE_SIZE
+    li.d    $t4, LOONGARCH_VIRT_UART
+    li.w    $t5, 'B'
+
+clean:
+    st.b    $zero, $t0, 0
+    add.d   $t0,   $t0, $t2
+    bne     $t0,   $t1, clean
+    /* keeps a counter so we can limit the output speed */
+    addi.d  $t6,   $zero, 0
+
+mainloop:
+    li.d    $t0, LOONGARCH_TEST_MEM_START
+
+innerloop:
+    ld.bu   $t3, $t0, 0
+    addi.w  $t3, $t3, 1
+    ext.w.b $t3, $t3
+    st.b    $t3, $t0, 0
+    add.d   $t0, $t0, $t2
+    bne     $t0, $t1, innerloop
+
+    addi.d  $t6, $t6, 1
+    andi    $t6, $t6, 31
+    bnez    $t6, mainloop
+
+    st.b    $t5, $t4, 0
+    b       mainloop
+    nop
diff --git a/tests/migration/loongarch64/a-b-kernel.h b/tests/migration/loongarch64/a-b-kernel.h
new file mode 100644
index 0000000000..b3fe466754
--- /dev/null
+++ b/tests/migration/loongarch64/a-b-kernel.h
@@ -0,0 +1,16 @@
+/* This file is automatically generated from the assembly file in
+* tests/migration/loongarch64. Edit that file and then run "make all"
+* inside tests/migration to update, and then remember to send both
+* the header and the assembler differences in your patch submission.
+*/
+unsigned char loongarch64_kernel[] = {
+  0x0c, 0xc0, 0x3f, 0x14, 0x8c, 0x81, 0x87, 0x03, 0x0d, 0x04, 0x81, 0x03,
+  0x8d, 0x01, 0x00, 0x29, 0x0c, 0x00, 0x04, 0x14, 0x0d, 0x80, 0x0c, 0x14,
+  0x2e, 0x00, 0x00, 0x14, 0x10, 0xc0, 0x3f, 0x14, 0x10, 0x82, 0x87, 0x03,
+  0x11, 0x08, 0x81, 0x03, 0x80, 0x01, 0x00, 0x29, 0x8c, 0xb9, 0x10, 0x00,
+  0x8d, 0xf9, 0xff, 0x5f, 0x12, 0x00, 0xc0, 0x02, 0x0c, 0x00, 0x04, 0x14,
+  0x8f, 0x01, 0x00, 0x2a, 0xef, 0x05, 0x80, 0x02, 0xef, 0x5d, 0x00, 0x00,
+  0x8f, 0x01, 0x00, 0x29, 0x8c, 0xb9, 0x10, 0x00, 0x8d, 0xed, 0xff, 0x5f,
+  0x52, 0x06, 0xc0, 0x02, 0x52, 0x7e, 0x40, 0x03, 0x5f, 0xde, 0xff, 0x47,
+  0x11, 0x02, 0x00, 0x29, 0xff, 0xd7, 0xff, 0x53, 0x00, 0x00, 0x40, 0x03
+};
diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
index 68512c0b1b..f402e48349 100644
--- a/tests/migration/migration-test.h
+++ b/tests/migration/migration-test.h
@@ -32,4 +32,7 @@
  */
 #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
 
+/* LoongArch64 */
+#define LOONGARCH_TEST_MEM_START (32 * 1024 * 1024)
+#define LOONGARCH_TEST_MEM_END   (100 * 1024 * 1024)
 #endif /* MIGRATION_TEST_H */
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 86293051dc..8d5d8a05d7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -140,7 +140,7 @@ qtests_hppa = ['boot-serial-test'] + \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
 
 qtests_loongarch64 = qtests_filter + \
-  ['boot-serial-test']
+  ['boot-serial-test', 'migration-test']
 
 qtests_m68k = ['boot-serial-test'] + \
   qtests_filter
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 7a1345f80f..95bd4e9756 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -128,6 +128,7 @@ static char *bootpath;
 #include "tests/migration/i386/a-b-bootblock.h"
 #include "tests/migration/aarch64/a-b-kernel.h"
 #include "tests/migration/s390x/a-b-bios.h"
+#include "tests/migration/loongarch64/a-b-kernel.h"
 
 static void bootfile_create(char *dir, bool suspend_me)
 {
@@ -154,6 +155,9 @@ static void bootfile_create(char *dir, bool suspend_me)
         content = aarch64_kernel;
         len = sizeof(aarch64_kernel);
         g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
+    } else if (strcmp(arch, "loongarch64") == 0) {
+        content = loongarch64_kernel;
+        len = sizeof(loongarch64_kernel);
     } else {
         g_assert_not_reached();
     }
@@ -750,6 +754,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
+    } else if (strcmp(arch, "loongarch64") == 0) {
+        memory_size = "256M";
+        machine_alias = "virt";
+        arch_opts = g_strdup_printf("-cpu la464 -bios %s", bootpath);
+        start_address = LOONGARCH_TEST_MEM_START;
+        end_address = LOONGARCH_TEST_MEM_END;
     } else {
         g_assert_not_reached();
     }
-- 
2.39.3


