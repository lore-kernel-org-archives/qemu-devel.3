Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B63CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWTwQ-0003jR-7O; Mon, 08 Jun 2026 02:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wWTwN-0003jD-6U
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 02:58:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wWTwK-0008T2-6n
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 02:58:30 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxzsAFaCZq6q8RAA--.23962S3;
 Mon, 08 Jun 2026 14:58:13 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJBxpsAAaCZq13WfAA--.5820S2;
 Mon, 08 Jun 2026 14:58:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/migration: Add migration test on loongarch
Date: Mon,  8 Jun 2026 14:59:47 +0800
Message-ID: <20260608065947.428141-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpsAAaCZq13WfAA--.5820S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtF1fZw15Ar45AF47GF45urX_yoW3Gr15pw
 1rC3yxKa1xGF17t3WxWFy5ur1rGw1xKFnI9a9rGr10krsxJF10yw1agrW2qFnxX3y0vF40
 9wn5tr1ay3WqyrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=
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

Add migration qtest on loongarch64 system, the test passes to run with
the following result:
  qemu:qtest+qtest-loongarch64/qtest-loongarch64/migration-test OK 15.94s 9 subtests passed

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 MAINTAINERS                                   |  1 +
 tests/qtest/meson.build                       |  3 +-
 tests/qtest/migration/Makefile                |  2 +-
 tests/qtest/migration/bootfile.c              |  4 ++
 tests/qtest/migration/bootfile.h              |  4 ++
 tests/qtest/migration/framework.c             |  6 +++
 tests/qtest/migration/loongarch64/Makefile    | 20 ++++++++
 .../qtest/migration/loongarch64/a-b-kernel.S  | 46 +++++++++++++++++++
 .../qtest/migration/loongarch64/a-b-kernel.h  | 13 ++++++
 9 files changed, 97 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/migration/loongarch64/Makefile
 create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.S
 create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 79ecac16fe..2105db7155 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1368,6 +1368,7 @@ F: hw/intc/loongarch_*.c
 F: hw/intc/loongson_ipi_common.c
 F: hw/rtc/ls7a_rtc.c
 F: gdbstub/gdb-xml/loongarch*.xml
+F: tests/qtest/migration/loongarch64/
 
 M68K Machines
 -------------
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 45ea497fa5..1636b8616e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -154,7 +154,8 @@ qtests_loongarch64 = qtests_filter + \
   (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   ['boot-serial-test',
-   'cpu-plug-test']
+   'cpu-plug-test',
+   'migration-test']
 
 qtests_m68k = ['boot-serial-test'] + \
   qtests_filter
diff --git a/tests/qtest/migration/Makefile b/tests/qtest/migration/Makefile
index c183b69941..b94836eb0f 100644
--- a/tests/qtest/migration/Makefile
+++ b/tests/qtest/migration/Makefile
@@ -5,7 +5,7 @@
 # See the COPYING file in the top-level directory.
 #
 
-TARGET_LIST = i386 aarch64 s390x ppc64
+TARGET_LIST = i386 aarch64 s390x ppc64 loongarch64
 
 SRC_PATH = ../../../..
 
diff --git a/tests/qtest/migration/bootfile.c b/tests/qtest/migration/bootfile.c
index 479c43231d..e46ad09de7 100644
--- a/tests/qtest/migration/bootfile.c
+++ b/tests/qtest/migration/bootfile.c
@@ -19,6 +19,7 @@
 #include "bootfile.h"
 #include "i386/a-b-bootblock.h"
 #include "aarch64/a-b-kernel.h"
+#include "loongarch64/a-b-kernel.h"
 #include "ppc64/a-b-kernel.h"
 #include "s390x/a-b-bios.h"
 
@@ -57,6 +58,9 @@ char *bootfile_create(const char *arch, const char *dir, bool suspend_me)
         content = aarch64_kernel;
         len = sizeof(aarch64_kernel);
         g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
+    } else if (strcmp(arch, "loongarch64") == 0) {
+        content = loongarch64_kernel;
+        len = sizeof(loongarch64_kernel);
     } else {
         g_assert_not_reached();
     }
diff --git a/tests/qtest/migration/bootfile.h b/tests/qtest/migration/bootfile.h
index 0ce5b34433..a4060ea4f7 100644
--- a/tests/qtest/migration/bootfile.h
+++ b/tests/qtest/migration/bootfile.h
@@ -42,6 +42,10 @@
  */
 #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
 
+/* LoongArch64 */
+#define LOONGARCH_TEST_MEM_START (32 * 1024 * 1024)
+#define LOONGARCH_TEST_MEM_END   (100 * 1024 * 1024)
+
 #ifndef MIGRATION_GUEST_CODE
 void bootfile_delete(void);
 char *bootfile_create(const char *arch, const char *dir, bool suspend_me);
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a9b58d03aa..a830b96f41 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -360,6 +360,12 @@ int migrate_args(char **from, char **to, MigrateStart *args)
         arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
+    } else if (strcmp(arch, "loongarch64") == 0) {
+        memory_size = "256M";
+        machine_alias = "virt";
+        arch_opts = g_strdup_printf("-bios %s", bootpath);
+        start_address = LOONGARCH_TEST_MEM_START;
+        end_address = LOONGARCH_TEST_MEM_END;
     } else {
         g_assert_not_reached();
     }
diff --git a/tests/qtest/migration/loongarch64/Makefile b/tests/qtest/migration/loongarch64/Makefile
new file mode 100644
index 0000000000..3c8cfeee86
--- /dev/null
+++ b/tests/qtest/migration/loongarch64/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
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
diff --git a/tests/qtest/migration/loongarch64/a-b-kernel.S b/tests/qtest/migration/loongarch64/a-b-kernel.S
new file mode 100644
index 0000000000..577d4b238c
--- /dev/null
+++ b/tests/qtest/migration/loongarch64/a-b-kernel.S
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "../bootfile.h"
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
diff --git a/tests/qtest/migration/loongarch64/a-b-kernel.h b/tests/qtest/migration/loongarch64/a-b-kernel.h
new file mode 100644
index 0000000000..132db292b9
--- /dev/null
+++ b/tests/qtest/migration/loongarch64/a-b-kernel.h
@@ -0,0 +1,13 @@
+
+unsigned char loongarch64_kernel[] = {
+  0x0c, 0xc0, 0x3f, 0x14, 0x8c, 0x81, 0x87, 0x03, 0x0d, 0x04, 0x81, 0x03,
+  0x8d, 0x01, 0x00, 0x29, 0x0c, 0x00, 0x04, 0x14, 0x0d, 0x80, 0x0c, 0x14,
+  0x2e, 0x00, 0x00, 0x14, 0x10, 0xc0, 0x3f, 0x14, 0x10, 0x82, 0x87, 0x03,
+  0x11, 0x08, 0x81, 0x03, 0x80, 0x01, 0x00, 0x29, 0x8c, 0xb9, 0x10, 0x00,
+  0x8d, 0xf9, 0xff, 0x5f, 0x12, 0x00, 0xc0, 0x02, 0x0c, 0x00, 0x04, 0x14,
+  0x8f, 0x01, 0x00, 0x2a, 0xef, 0x05, 0x80, 0x02, 0xef, 0x5d, 0x00, 0x00,
+  0x8f, 0x01, 0x00, 0x29, 0x8c, 0xb9, 0x10, 0x00, 0x8d, 0xed, 0xff, 0x5f,
+  0x52, 0x06, 0xc0, 0x02, 0x52, 0x7e, 0x40, 0x03, 0x5f, 0xde, 0xff, 0x47,
+  0x11, 0x02, 0x00, 0x29, 0xff, 0xd7, 0xff, 0x53
+};
+

base-commit: 3390aba56c354637eccd2d5ab5fd6efc2f026f06
-- 
2.54.0


