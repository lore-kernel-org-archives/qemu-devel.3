Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052DBCA5FFD
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEfBP-0003pK-O6; Wed, 07 Oct 2026 23:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xEfBF-0003ns-1F
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 23:52:31 -0400
Received: from mail-dy2-x00.google.com ([2607:f8b0:4864:36::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xEfBC-0006PF-NU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 23:52:28 -0400
Received: by mail-dy2-x00.google.com with SMTP id
 5a478bee46e88-327b1d5824fso3631321eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 20:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791431536; x=1792036336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P2ePt/c2XTKPInZ3QaHWee/st5PUB8lUYnxB2zsgIxk=;
 b=aJzb1SOyFaaIv6x2xa2C4I85/4suEBtcxjR6Qrl78khc1nW4UvawoeW+yAloH81KXr
 HUm2Zt8QBcRmk/k74pskBWbr6CiDKfe9Jtm/Rt9hBDGPai46nlfr6prVIVWtiUUy1GPY
 hp8imab4CcgOfgETw+GvJ9RDc/yo1NrqKs1eH0ykCW986L0Kqz+pHXho8PCh1yt7yq1Q
 tF+eg94XHFfdqhyP8BrMsNalvyMZ1LIGeFLtP3KvI/uGwVyquwAwVgrRSigMdLHp58R3
 8dg4wOS67Psf6bog1gPahfJEbuPsMooaSvhuFlvBqtoDXF0OPUF1+QEHIttTt94j/Vh9
 YSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791431536; x=1792036336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P2ePt/c2XTKPInZ3QaHWee/st5PUB8lUYnxB2zsgIxk=;
 b=gtc4wZnzCeiF8pl3IzmpP4yBAlpYj1+2Q435N7l7e0CMhpNMAtTwgl81DBFVsC/J4d
 oRE8LdT1xjWgxTpevSSaKAVAKGAfg9Xn8GV2w68RVHG/Io/aXN46Zd0t9wVoncAtiAwa
 TOjQtmjP6qwrqXXuiuKGt0sMoDJkJopHjZvtc3nXGXZUNzNut+xL5p3B5PjS1/WuuORl
 WPeijce5z49m4Vt4bz4hsiZSvkq9Kg/D/RkOhPr21SsQVuAooe5c5A0bHJdWV9+YpBrL
 SS/S5NaBhd/LbB8TwwRJagxoafJ1jwR4V+4z4aky+neU7SAYJ9lnN0hdn5Gwohhln1i+
 2FrQ==
X-Gm-Message-State: AFuF++lRMuv2AFKJZxxnidWhM+dyoFvV7fVHli+PdQQ09Ml0tI3sv0Ef
 XAe757n3GqkWZppRH2DTQLWLB/sMKpF9Lt2f5QkjZpvRzGSkM9MHxOtVkEVuCu3SIQ4=
X-Gm-Gg: AYBFou3O8wK381+CTUQRD7FsB1YY0rdU6ZtleaVW7OFvvjjMkeJ9XG7sor+OX+IGdia
 GUGMy+83tKjJRn7jruvjE5shvytO9fVO9C8M0ulHk4DgHGBSAnq/AGQ+6HxZ+ykIkK09EdYA9dy
 mBqAL3MLO4iyPxpC8ZPvmW8OuXBuucSvNQYjCmtY3I+Z7vhlmrACVKgWVgZ6ZPqtekXSrBp+y8J
 yOOFwPY7Xnvs94FL6MfPYUcM3IQmsj/8JNoZFyGP/TORjOV0Upni7Csldg5rVYrc1NAj4Hf5riR
 7zZZ74XWH2uMUhfRvOlpFzQfAOMERLOwOLn5UT3FiJGLf+jmVAFc7WfO+rYiqphoVtzN/+aIenk
 c+gcRwwgI2hFRM2SjNRqU69920eYG/KyKHDzsAWza3M8VD5PqqJe2P8G4++7WdftYF78j8QWCvn
 RXvDHiQ3DSjPAuTAOHcyuIrOx/g2p8w3b0iRbW9ok89WKUkSs/Zti+joAc/YWxzZDHenBKbbe6P
 Nl88sl2OmY+3HgRBa26eCVLiL2NyYtBjMcEzw==
X-Received: by 2002:a05:7301:488e:b0:34b:529d:6263 with SMTP id
 5a478bee46e88-3515de84167mr4958389eec.33.1791431535318; 
 Wed, 07 Oct 2026 20:52:15 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([103.190.179.27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515afa61e8sm13132213eec.22.2026.10.07.20.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 20:52:14 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-stable@nongnu.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, alex.bennee@linaro.org,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH v3] target/riscv: fix RV32 fixed counter accesses
Date: Thu,  8 Oct 2026 11:51:50 +0800
Message-ID: <20261008035150.2223-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dy2-x00.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Since commit cfc96df65e01, riscv_pmu_ctr_get_fixed_counters_val()
returns the complete 64-bit fixed-counter value. The RV32 counter
access paths, however, still perform parts of the offset calculation
on separately extracted 32-bit halves.

In particular, riscv_pmu_write_ctrh() deposits the low 32 bits of the
complete fixed-counter value into the high half of mhpmcounter_prev.
riscv_pmu_read_ctr() also subtracts a 32-bit half of the previous value
from the complete 64-bit fixed-counter value. Consequently, writes to
mcycleh can be lost and carries between the low and high halves are not
handled correctly.

Keep the fixed-counter offset calculation entirely in 64 bits. Before
a running counter is partially written, materialize its current
architectural value and reset the fixed-counter baseline. On reads,
calculate the complete 64-bit counter value before extracting the half
requested by RV32.

Register RV32 system TCG tests with the Meson build. Add a test for
high-half writes, low-to-high carry, and preserving the carried high
half across a subsequent low-half write.

Fixes: cfc96df65e01 ("target/riscv: Remove upper_half from riscv_pmu_ctr_get_fixed_counters_val")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4219
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---

Changes in v3:
- Drop obsolete cc_docker_host_arch settings from RV32 TCG tests to
  match the updated TCG container framework.
- Rebase onto QEMU master f9587d4045c6.
- Carry Reviewed-by tags from Daniel Henrique Barboza and Chao Liu.

Changes in v2:
- Move the test to a new tests/tcg/riscv32 directory.
- Convert the test registration to the Meson TCG test framework.
- Add RV32 TCG cross-compiler options and cover the test directory in
  MAINTAINERS.
- Add a riscv32-local semihosting linker script.

 MAINTAINERS                          |  1 +
 meson_options.txt                    |  4 +++
 target/riscv/tcg/csr.c               | 32 ++++++++++----------
 tests/tcg/meson.build                |  1 +
 tests/tcg/riscv32/meson.build        |  6 ++++
 tests/tcg/riscv32/semihost.ld        | 23 ++++++++++++++
 tests/tcg/riscv32/system/meson.build | 36 ++++++++++++++++++++++
 tests/tcg/riscv32/test-mcycle.S      | 45 ++++++++++++++++++++++++++++
 8 files changed, 133 insertions(+), 15 deletions(-)
 create mode 100644 tests/tcg/riscv32/meson.build
 create mode 100644 tests/tcg/riscv32/semihost.ld
 create mode 100644 tests/tcg/riscv32/system/meson.build
 create mode 100644 tests/tcg/riscv32/test-mcycle.S

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd..4c5d076 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -377,6 +377,7 @@ F: include/hw/riscv/
 F: common-user/host/riscv*
 F: tests/functional/riscv32
 F: tests/functional/riscv64
+F: tests/tcg/riscv32/
 F: tests/tcg/riscv64/
 F: tests/qtest/iommu-riscv-test.c
 
diff --git a/meson_options.txt b/meson_options.txt
index c9247e9..895c6e6 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -473,6 +473,10 @@ option('tcg_tests_cross_cc_ppc64le', type: 'string',
        description: 'cc for ppc64le tcg tests')
 option('tcg_tests_cross_cflags_ppc64le', type: 'string',
        description: 'cflags for ppc64le tcg tests')
+option('tcg_tests_cross_cc_riscv32', type: 'string',
+       description: 'cc for riscv32 tcg tests')
+option('tcg_tests_cross_cflags_riscv32', type: 'string',
+       description: 'cflags for riscv32 tcg tests')
 option('tcg_tests_cross_cc_riscv64', type: 'string',
        description: 'cc for riscv64 tcg tests')
 option('tcg_tests_cross_cflags_riscv64', type: 'string',
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 061bc9d..cab5647 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1340,23 +1340,23 @@ static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
     int deposit_size = rv32 ? 32 : 64;
     uint64_t ctr;
 
-    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
-                                         0, deposit_size, val);
-
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
         ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
-        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
-                                              0, deposit_size, ctr);
+        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
+        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                             0, deposit_size, val);
+        counter->mhpmcounter_prev = ctr;
         if (ctr_idx > 2) {
             riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
         }
      } else {
+        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                             0, deposit_size, val);
         /* Other counters can keep incrementing from the given value */
         counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
                                               0, deposit_size, val);
-
     }
 
     return RISCV_EXCP_NONE;
@@ -1366,20 +1366,22 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
                                           uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t ctrh;
+    uint64_t ctr;
 
-    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
-                                         32, 32, val);
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
-        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
-                                              32, 32, ctrh);
+        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
+        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
+        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                             32, 32, val);
+        counter->mhpmcounter_prev = ctr;
         if (ctr_idx > 2) {
             riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
         }
     } else {
+        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                             32, 32, val);
         counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
                                               32, 32, val);
     }
@@ -1410,12 +1412,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
     bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
     int start = upper_half ? 32 : 0;
     int length = rv32 ? 32 : 64;
-    uint64_t ctr_prev, ctr_val;
+    uint64_t ctr_val;
 
     /* Ensure upper_half is only set for XLEN == 32 */
     g_assert(rv32 || !upper_half);
 
-    ctr_prev = extract64(counter->mhpmcounter_prev, start, length);
     ctr_val  = extract64(counter->mhpmcounter_val, start, length);
 
     if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
@@ -1434,7 +1435,8 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
         uint64_t cntr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
-                                                             ctr_prev + ctr_val;
+                        counter->mhpmcounter_prev +
+                        counter->mhpmcounter_val;
         *val = extract64(cntr, start, length);
     } else {
         *val = ctr_val;
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4c0e307..184edcd 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -186,6 +186,7 @@ subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
+subdir('riscv32')
 subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
diff --git a/tests/tcg/riscv32/meson.build b/tests/tcg/riscv32/meson.build
new file mode 100644
index 0000000..862f134
--- /dev/null
+++ b/tests/tcg/riscv32/meson.build
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+cc = 'riscv64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+
+subdir('system')
diff --git a/tests/tcg/riscv32/semihost.ld b/tests/tcg/riscv32/semihost.ld
new file mode 100644
index 0000000..874838a
--- /dev/null
+++ b/tests/tcg/riscv32/semihost.ld
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+ENTRY(_start)
+
+SECTIONS
+{
+    /* virt machine, RAM starts at 2gb */
+    . = 0x80000000;
+    .text : {
+        *(.text)
+    }
+    .rodata : {
+        *(.rodata)
+    }
+    /* align r/w section to next 2mb */
+    . = ALIGN(1 << 21);
+    .data : {
+        *(.data)
+    }
+    .bss : {
+        *(.bss)
+    }
+}
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
new file mode 100644
index 0000000..f8e55ad
--- /dev/null
+++ b/tests/tcg/riscv32/system/meson.build
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests = []
+
+link_script = files('../semihost.ld')[0]
+cflags = ['-march=rv32im_zicsr',
+          '-mabi=ilp32',
+          '-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-Wl,-T', link_script]
+qemu_args = ['-M', 'virt',
+             '-display', 'none',
+             '-serial', 'stdio',
+             '-semihosting',
+             '-bios']
+
+tests += {
+  'test-mcycle.S': {
+    'cflags': cflags,
+    'qemu_args': ['-icount', 'shift=1', qemu_args],
+  },
+}
+
+if 'qemu-system-riscv32' in emulators
+  tcg_tests += {
+    'riscv32-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'folder': 'riscv32',
+      'gdb_arch': 'riscv32',
+      'qemu': emulators['qemu-system-riscv32'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/riscv32/test-mcycle.S b/tests/tcg/riscv32/test-mcycle.S
new file mode 100644
index 0000000..189d1e1
--- /dev/null
+++ b/tests/tcg/riscv32/test-mcycle.S
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+	.option	norvc
+
+	.text
+	.global	_start
+_start:
+	/* Exercise writes while mcycle is running. */
+	csrw	mcountinhibit, zero
+	csrw	mcycle, zero
+
+	/* A write to the high half must be immediately observable. */
+	li	s0, 0x1234ffff
+	csrw	mcycleh, s0
+	csrr	t0, mcycleh
+	bne	t0, s0, fail
+
+	/* Check carry from the low half into the high half. */
+	li	s0, 0x12345678
+	csrw	mcycleh, s0
+	li	t0, 0xfffffff0
+	csrw	mcycle, t0
+	.rept	32
+	nop
+	.endr
+	csrr	t0, mcycleh
+	addi	s0, s0, 1
+	bne	t0, s0, fail
+
+	/* A low-half write must preserve the carried high half. */
+	li	t0, 0x22222222
+	csrw	mcycle, t0
+	csrr	t0, mcycleh
+	bne	t0, s0, fail
+
+	li	t0, 0x100000
+	li	t1, 0x5555	/* FINISHER_PASS */
+	sw	t1, 0(t0)
+	j	.
+
+fail:
+	li	t0, 0x100000
+	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
+	sw	t1, 0(t0)
+	j	.

base-commit: f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c
-- 
2.43.0


