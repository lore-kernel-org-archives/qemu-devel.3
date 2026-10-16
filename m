Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE27BCC6B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 04:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHZNx-0005Lj-8l; Fri, 16 Oct 2026 00:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHZNr-0005Kg-HU; Fri, 16 Oct 2026 00:17:32 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHZNn-00041F-SM; Fri, 16 Oct 2026 00:17:30 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowABXLfFMpdFqv24BCw--.1154S3;
 Fri, 16 Oct 2026 12:17:17 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
Subject: [PATCH 1/1] tests/tcg/riscv: test jvt.mode WARL normalization
Date: Fri, 16 Oct 2026 12:17:15 +0800
Message-ID: <20261016041715.749-2-wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261016041715.749-1-wangyang25@otcaix.iscas.ac.cn>
References: <20261016034759.54-1-wangyang25@otcaix.iscas.ac.cn>
 <20261016041715.749-1-wangyang25@otcaix.iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABXLfFMpdFqv24BCw--.1154S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1kKFWxZw1fGrW5Aw4xWFg_yoW5KFy5pr
 1UGwn0kFWSv3W3Jw43Gr17GF1rGw4F93W8W34xAw1rZrW7GryUuFn3K3y3tw4fGrW8uryS
 v3Za9r1rCr4DJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY
 1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
 xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2
 jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
 kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
 z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
 AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
 IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
 CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
 WIevJa73UjIFyTuYvjxUkrMaDUUUU
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Check that RV32 and RV64 read back the implemented mode after

writing reserved mode bits, then execute cm.jt through the table.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4408
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
---
 tests/tcg/riscv32/system/meson.build |  9 +++++
 tests/tcg/riscv32/test-jvt-warl.S    | 49 ++++++++++++++++++++++++++++
 tests/tcg/riscv64/system/meson.build |  7 ++++
 tests/tcg/riscv64/test-jvt-warl.S    | 49 ++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+)
 create mode 100644 tests/tcg/riscv32/test-jvt-warl.S
 create mode 100644 tests/tcg/riscv64/test-jvt-warl.S

diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
index f8e55ad3d4..31c285c6f6 100644
--- a/tests/tcg/riscv32/system/meson.build
+++ b/tests/tcg/riscv32/system/meson.build
@@ -22,6 +22,15 @@ tests += {
   },
 }
 
+tests += {
+  'test-jvt-warl.S': {
+    'cflags': cflags,
+    'qemu_args': [
+      '-cpu', 'rv32i,h=false,zcd=false,zca=true,zcmt=true,zicsr=true', qemu_args,
+    ],
+  },
+}
+
 if 'qemu-system-riscv32' in emulators
   tcg_tests += {
     'riscv32-softmmu': {
diff --git a/tests/tcg/riscv32/test-jvt-warl.S b/tests/tcg/riscv32/test-jvt-warl.S
new file mode 100644
index 0000000000..b9e42bc7a0
--- /dev/null
+++ b/tests/tcg/riscv32/test-jvt-warl.S
@@ -0,0 +1,49 @@
+/*
+ * Verify jvt.mode WARL normalization and cm.jt dispatch.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option norvc
+	.text
+	.global _start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+	lla	t0, jvt_table
+	ori	t1, t0, 0x3f
+	csrw	0x017, t1
+	csrr	t2, 0x017
+	bne	t0, t2, fail
+	.2byte	0xa002		/* cm.jt index 0 */
+
+fail:
+	li	a0, 1
+	j	_exit
+
+target:
+	li	a0, 0
+
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sw	t0, 0(a1)
+	sw	a0, 4(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+trap:
+	li	a0, 1
+	j	_exit
+
+	.balign	64
+jvt_table:
+	.word	target
+
+	.data
+	.balign	8
+semiargs:
+	.space	8
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3e1c970382..ce5e710288 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -77,6 +77,13 @@ tests += {
   }
 }
 
+tests += {
+  'test-jvt-warl.S': {
+    'cflags': cflags + ['-march=rv64gc_zicsr'],
+    'qemu_args': ['-cpu', 'rv64,zcmt=true,zcd=false', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-jvt-warl.S b/tests/tcg/riscv64/test-jvt-warl.S
new file mode 100644
index 0000000000..2ac28e6951
--- /dev/null
+++ b/tests/tcg/riscv64/test-jvt-warl.S
@@ -0,0 +1,49 @@
+/*
+ * Verify jvt.mode WARL normalization and cm.jt dispatch.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option norvc
+	.text
+	.global _start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+	lla	t0, jvt_table
+	ori	t1, t0, 0x3f
+	csrw	0x017, t1
+	csrr	t2, 0x017
+	bne	t0, t2, fail
+	.2byte	0xa002		/* cm.jt index 0 */
+
+fail:
+	li	a0, 1
+	j	_exit
+
+target:
+	li	a0, 0
+
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+trap:
+	li	a0, 1
+	j	_exit
+
+	.balign	64
+jvt_table:
+	.dword	target
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.55.0.windows.2


