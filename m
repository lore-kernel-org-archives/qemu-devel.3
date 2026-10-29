Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E937606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NakeKZIw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSl6-0005ml-OV; Thu, 29 Oct 2026 12:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMSkr-0005gZ-BP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:13:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMSkk-0000YG-1d
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:13:29 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1274188f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793290398; x=1793895198; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gXiCXUT++0dTLWjnClsOYS8vNY2gIWmzM7lQzpTeODc=;
 b=NakeKZIwjwMvHa1bIbf46F3+ZOSKtuoGCT6OpVD01d2KJQMye5SNlZtE6sLA/OqOv0
 iKAIr41V3ux7DSFORcbqLxtiILnz5SBZ7r0/WjKpwTsCt91uxsJ0RgbhXLuAifa2d0Ji
 rBLHI9XpKJBaUdGlMoFwfLz+A8U5YYB9XP8xjBMe/6ujfuV7QMd8eRBxuqU87/hGZ/AJ
 vtbCmN1BgJu7LAZSyhH2AN07l+r1DWmvkAPgXz3vZeuctF+bnQJpFDjfaJjxV1c5FPh9
 LbQ58nILSeRVUFvB48sUsJQhD78rLF9D7vbmmXA8j5zAw/jbNMa2wpJabGCUX+sOKJho
 UM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793290398; x=1793895198;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gXiCXUT++0dTLWjnClsOYS8vNY2gIWmzM7lQzpTeODc=;
 b=fKj6NkoPpH3G6ItRxWZOVfuNo2XOKckyN3yUHWEWAOUTPwriCC6kuqFPy7H1JzDwJc
 fML+gh8YUR0A0SVO6L+NJ48h7QJnoXuYz03wybeAEyyblyFWi+uR+QDC8rTBjCn0emEv
 4CHgBfOrgKTaELnthQrcfOLCixommyfS0iq6DAHWgTosj2VngOhmbzy1JYy8qX5RD8s1
 X+MidFwX42mj1xVlzkQtOSvdgPYV/CUj9msgXF5Bdr6HTve7a/d2QQ2yNVjaegS01TSX
 xoyKy2NJEthOATmIozm2qAIsiLDphZeJIEEWpcBYY1NDEUqbJNlwe8CFImt/imUaIZOQ
 6aGA==
X-Gm-Message-State: AFq9FYKq0cQIqqNwMSkBLlqbLFluPL0lpJzJIcroos8sxr5oX6zZGYvX
 1tNX9XJIqrDjv4/niXTnfP0qIye77ogLgepxrtW6aCgj7QTlYGkKUfm6NLf6MdKxpsVMj0Hqgrh
 PgOFzgKw=
X-Gm-Gg: AYBFou0zgmZnspFC9y7SutSIivOG6Ob//dn3qThkJ4/RjbyIEcHTlfAmlslmRMczhkW
 Z81DXzlENLPeVFO5eamoT2IXOeNNXa7RyF7X8gQj8bPEF7L6CIgKyd8PHHxax2FcrYlr9jguUDZ
 9TQUYWnbXSU3o9rxaJAZ8yqMBDSBwBykpm7ThWJUn5I185qb8dD8/c+Qz3IMO5RX75W8s9+9U0m
 4ykwv/qilVky3IEGJKZwYnS53UFhey2TpFpR13wLTipxnuFtLtmstMyi27rKzjC0dWCQfYev8Ot
 cWtuBM9RRce3C+16miiJYVQWvOLTcF4sK1YYxvgYuxGwxJV8PK20TD96GRijxcEsCGaCniW5mC4
 jH1WgH/WL0zwkgDscXJifFex9MOHP7MoYgzZm4Wv4wWZLbd6KPPzvGnJHPJM17jOFKR6piABE/t
 cVJsuoLO2yI/d6e/NlWg+vr3niBI9ix8Ettyu9jYd+JpNuTg0CLz1ftZi5KCzghFtlbMmRRP7MB
 twotcv42r7w1wTBH6Jf0lD3hU5u9BNQ3nEw6qQoLuI8dS13G2N5L97cJRkTVPUTH2/67aEzBNHI
 vyscqTos0fkOZQnNkgMAE+GJJVpeXirZeOKrlYxzR/5we8lLmw==
X-Received: by 2002:a5d:494e:0:b0:48a:f8fb:cd49 with SMTP id
 ffacd0b85a97d-48e5d5bd991mr10762288f8f.22.1793290397634; 
 Thu, 29 Oct 2026 09:13:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df87f26sm91577f8f.17.2026.10.29.09.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:13:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C9F6B5FAEF;
 Thu, 29 Oct 2026 16:13:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6/8] tests/tcg: import arm wfe test cases for #4670
Date: Thu, 29 Oct 2026 16:13:08 +0000
Message-ID: <20261029161310.2065290-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029161310.2065290-1-alex.bennee@linaro.org>
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The report for #4670 is a duplicate of #4660 (fixed in a previous
commit) but it came with some test cases that could trigger the issue.
It's more extensive than the basic test as it's trying to hit a race.

It's also a bit more complex as it needs to wake up the additional
vCPUs so they can take part.

As it doesn't take long to run it's probably worth adding.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
AI-used-for: writing the test case
---
 .../tcg/aarch64/system/wfe-sev-lock-aarch64.c | 259 ++++++++++++++++++
 tests/tcg/arm/system/wfe-sev-lock-arm.c       | 240 ++++++++++++++++
 tests/tcg/aarch64/system/meson.build          |   7 +
 tests/tcg/arm/system/meson.build              |   7 +
 4 files changed, 513 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/wfe-sev-lock-aarch64.c
 create mode 100644 tests/tcg/arm/system/wfe-sev-lock-arm.c

diff --git a/tests/tcg/aarch64/system/wfe-sev-lock-aarch64.c b/tests/tcg/aarch64/system/wfe-sev-lock-aarch64.c
new file mode 100644
index 00000000000..6a767e7476c
--- /dev/null
+++ b/tests/tcg/aarch64/system/wfe-sev-lock-aarch64.c
@@ -0,0 +1,259 @@
+/*
+ * SMP ticket lock whose waiters sleep in WFE and whose releaser wakes
+ * them with SEV (the waiters re-read the owner with a plain load-acquire,
+ * so no exclusive monitor is armed while they wait).
+ *
+ * CPU0 starts the other CPUs with PSCI CPU_ON and then only watches.
+ * The other CPUs take and release one ticket lock with interrupts masked
+ * and no timer or event stream running, so a waiter halted in WFE can
+ * only be woken by the SEV that the releasing CPU executes.  If that
+ * wake-up is lost, the waiter whose ticket is now being served sleeps
+ * forever with the lock free.  CPU0 notices that no CPU has made
+ * progress for STALL_MS, reports the lock state, issues its own SEV to
+ * recover and fails the test at the end.
+ *
+ * Run with -smp 3 or more; up to MAX_CPUS are used.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <minilib.h>
+
+#define MAX_CPUS        8
+#define ITERATIONS      20000   /* lock acquisitions per worker CPU */
+#define HOLD_LOOPS      200     /* work done while holding the lock */
+#define STALL_MS        500     /* no progress for this long = stall */
+#define MAX_STALLS      20      /* give up after this many */
+
+#define PSCI_CPU_ON_64  0xc4000003ul
+#define NO_TICKET       0xffffffffu
+
+#define READ_ONCE(x)        __atomic_load_n(&(x), __ATOMIC_RELAXED)
+#define WRITE_ONCE(x, v)    __atomic_store_n(&(x), (v), __ATOMIC_RELAXED)
+
+/* from Linux's include/linux/stringify.h */
+#define __stringify_1(x...) #x
+#define __stringify(x...)   __stringify_1(x)
+
+#define read_sysreg(r) ({                                           \
+            uint64_t __val;                                         \
+            asm volatile("mrs %0, " __stringify(r) : "=r" (__val)); \
+            __val;                                                  \
+})
+
+typedef union {
+    uint32_t slock;
+    struct {
+        uint16_t owner;
+        uint16_t next;
+    } tickets;
+} ticket_lock_t;
+
+static ticket_lock_t lock;
+static uint32_t shared_count;
+static uint32_t progress[MAX_CPUS];
+static uint32_t waiting_for[MAX_CPUS];
+static uint32_t finished[MAX_CPUS];
+
+/* CPU0's EL1 MMU configuration, copied by the secondaries */
+struct boot_regs {
+    uint64_t vbar, mair, tcr, ttbr0, sctlr, cpacr;
+};
+static struct boot_regs __attribute__((used)) boot_regs;
+
+#define STACK_SIZE 4096
+static uint8_t stacks[MAX_CPUS][STACK_SIZE] __attribute__((aligned(16)));
+
+static uint32_t this_cpu(void)
+{
+    return read_sysreg(mpidr_el1) & 0xff;
+}
+
+static void ticket_lock(uint32_t cpu)
+{
+    uint32_t old, newval, fail;
+    uint16_t ticket, owner;
+
+    asm volatile("1: ldaxr   %w0, [%3]\n"
+                 "   add     %w1, %w0, %w4\n"
+                 "   stxr    %w2, %w1, [%3]\n"
+                 "   cbnz    %w2, 1b"
+                 : "=&r" (old), "=&r" (newval), "=&r" (fail)
+                 : "r" (&lock.slock), "r" (1 << 16)
+                 : "memory");
+
+    ticket = old >> 16;
+    owner = old & 0xffff;
+    WRITE_ONCE(waiting_for[cpu], ticket);
+    while (ticket != owner) {
+        asm volatile("wfe\n"
+                     "ldarh %w0, [%1]"
+                     : "=r" (owner) : "r" (&lock.tickets.owner) : "memory");
+    }
+    WRITE_ONCE(waiting_for[cpu], NO_TICKET);
+}
+
+static void ticket_unlock(void)
+{
+    uint16_t owner = lock.tickets.owner + 1;
+
+    asm volatile("stlrh %w0, [%1]\n"
+                 "dsb ishst\n"
+                 "sev"
+                 : : "r" (owner), "r" (&lock.tickets.owner) : "memory");
+}
+
+static void __attribute__((used)) secondary_main(void)
+{
+    uint32_t cpu = this_cpu();
+
+    for (uint32_t i = 0; i < ITERATIONS; i++) {
+        ticket_lock(cpu);
+        shared_count++;
+        /* hold the lock long enough for the others to go to sleep */
+        for (uint32_t spin = 0; spin < HOLD_LOOPS; spin++) {
+            asm volatile("" : : : "memory");
+        }
+        ticket_unlock();
+        WRITE_ONCE(progress[cpu], i + 1);
+    }
+    WRITE_ONCE(finished[cpu], 1);
+}
+
+/*
+ * Entered by PSCI CPU_ON at EL1 with the MMU off; x0 holds the context
+ * ID, which is the top of this CPU's stack.
+ */
+asm(".text\n"
+    ".type secondary_entry, %function\n"
+    "secondary_entry:\n"
+    "    mov sp, x0\n"
+    "    adrp x1, boot_regs\n"
+    "    add x1, x1, :lo12:boot_regs\n"
+    "    ldp x2, x3, [x1, #0]\n"
+    "    msr vbar_el1, x2\n"
+    "    msr mair_el1, x3\n"
+    "    ldp x2, x3, [x1, #16]\n"
+    "    msr tcr_el1, x2\n"
+    "    msr ttbr0_el1, x3\n"
+    "    ldp x2, x3, [x1, #32]\n"
+    "    msr cpacr_el1, x3\n"
+    "    isb\n"
+    "    dsb sy\n"
+    "    msr sctlr_el1, x2\n"
+    "    isb\n"
+    "    bl secondary_main\n"
+    "1:  wfi\n"
+    "    b 1b\n");
+
+static int64_t psci_cpu_on(uint64_t mpidr, uint64_t entry, uint64_t ctx)
+{
+    register uint64_t x0 asm("x0") = PSCI_CPU_ON_64;
+    register uint64_t x1 asm("x1") = mpidr;
+    register uint64_t x2 asm("x2") = entry;
+    register uint64_t x3 asm("x3") = ctx;
+
+    asm volatile("hvc #0"
+                 : "+r" (x0), "+r" (x1), "+r" (x2), "+r" (x3)
+                 :
+                 : "memory");
+    return x0;
+}
+
+static uint64_t read_cntvct(void)
+{
+    asm volatile("isb" : : : "memory");
+    return read_sysreg(cntvct_el0);
+}
+
+int main(void)
+{
+    uint32_t ncpus = 1, workers, stalls = 0, last_sum = 0;
+    uint64_t freq = read_sysreg(cntfrq_el0);
+    uint64_t start, now, last_change, stall_ticks, entry;
+
+    boot_regs.vbar = read_sysreg(vbar_el1);
+    boot_regs.mair = read_sysreg(mair_el1);
+    boot_regs.tcr = read_sysreg(tcr_el1);
+    boot_regs.ttbr0 = read_sysreg(ttbr0_el1);
+    boot_regs.sctlr = read_sysreg(sctlr_el1);
+    boot_regs.cpacr = read_sysreg(cpacr_el1);
+    asm volatile("dsb sy" : : : "memory");
+
+    asm("adrp %0, secondary_entry\n"
+        "add %0, %0, :lo12:secondary_entry" : "=r" (entry));
+
+    for (uint32_t cpu = 1; cpu < MAX_CPUS; cpu++) {
+        if (psci_cpu_on(cpu, entry,
+                        (uint64_t)&stacks[cpu][STACK_SIZE]) != 0) {
+            break;
+        }
+        ncpus++;
+    }
+    workers = ncpus - 1;
+    if (workers < 2) {
+        ml_printf("SKIP: need -smp 3 or more (found %d CPUs)\n", ncpus);
+        return 0;
+    }
+    ml_printf("%d CPUs, %d contending workers, %d iterations each\n",
+              ncpus, workers, ITERATIONS);
+
+    stall_ticks = freq / 1000 * STALL_MS;
+    start = last_change = read_cntvct();
+    for (;;) {
+        uint32_t sum = 0, done = 0, owner;
+
+        for (uint32_t cpu = 1; cpu < ncpus; cpu++) {
+            sum += READ_ONCE(progress[cpu]);
+            done += READ_ONCE(finished[cpu]);
+        }
+        if (done == workers) {
+            break;
+        }
+        now = read_cntvct();
+        if (sum != last_sum) {
+            last_sum = sum;
+            last_change = now;
+            continue;
+        }
+        if (now - last_change < stall_ticks) {
+            continue;
+        }
+
+        stalls++;
+        owner = READ_ONCE(lock.tickets.owner);
+        ml_printf("STALL %d: no progress for %d ms; lock owner %d next %d\n",
+                  stalls, STALL_MS, owner, READ_ONCE(lock.tickets.next));
+        for (uint32_t cpu = 1; cpu < ncpus; cpu++) {
+            if (READ_ONCE(waiting_for[cpu]) == owner) {
+                ml_printf("  cpu%d holds the next ticket %d and is still "
+                          "waiting: lost wake-up\n", cpu, owner);
+            }
+        }
+        if (stalls >= MAX_STALLS) {
+            ml_printf("FAIL: giving up after %d stalls\n", stalls);
+            return 1;
+        }
+        /* Recover so the rest of the run can be measured. */
+        asm volatile("dsb ishst\n"
+                     "sev" : : : "memory");
+        last_change = read_cntvct();
+    }
+
+    now = read_cntvct();
+    ml_printf("%d acquisitions in %d ms, %d stalls\n", shared_count,
+              (uint32_t)((now - start) / (freq / 1000)), stalls);
+    if (shared_count != workers * ITERATIONS) {
+        ml_printf("FAIL: count %d, expected %d\n", shared_count,
+                  workers * ITERATIONS);
+        return 1;
+    }
+    if (stalls) {
+        ml_printf("FAIL: %d lost wake-ups\n", stalls);
+        return 1;
+    }
+    ml_printf("PASS\n");
+    return 0;
+}
diff --git a/tests/tcg/arm/system/wfe-sev-lock-arm.c b/tests/tcg/arm/system/wfe-sev-lock-arm.c
new file mode 100644
index 00000000000..1e87744a695
--- /dev/null
+++ b/tests/tcg/arm/system/wfe-sev-lock-arm.c
@@ -0,0 +1,240 @@
+/*
+ * SMP ticket lock using WFE/SEV, in the style of the 32-bit Arm Linux
+ * arch_spin_lock()/arch_spin_unlock().
+ *
+ * CPU0 starts the other CPUs with PSCI CPU_ON and then only watches.
+ * The other CPUs take and release one ticket lock with IRQs masked and
+ * no timer running, so a waiter halted in WFE can only be woken by the
+ * SEV that the releasing CPU executes.  If that wake-up is lost, the
+ * waiter whose ticket is now being served sleeps forever with the lock
+ * free.  CPU0 notices that no CPU has made progress for STALL_MS,
+ * reports the lock state, issues its own SEV to recover and fails the
+ * test at the end.
+ *
+ * Run with -smp 3 or more; up to MAX_CPUS are used.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <minilib.h>
+
+#define MAX_CPUS        8
+#define ITERATIONS      20000   /* lock acquisitions per worker CPU */
+#define HOLD_LOOPS      200     /* work done while holding the lock */
+#define STALL_MS        500     /* no progress for this long = stall */
+#define MAX_STALLS      20      /* give up after this many */
+
+#define PSCI_CPU_ON     0x84000003u
+#define NO_TICKET       0xffffffffu
+
+#define READ_ONCE(x)        __atomic_load_n(&(x), __ATOMIC_RELAXED)
+#define WRITE_ONCE(x, v)    __atomic_store_n(&(x), (v), __ATOMIC_RELAXED)
+
+/* Same layout as Linux's arch_spinlock_t on a little-endian CPU */
+typedef union {
+    uint32_t slock;
+    struct {
+        uint16_t owner;
+        uint16_t next;
+    } tickets;
+} ticket_lock_t;
+
+static ticket_lock_t lock;
+static uint32_t shared_count;
+static uint32_t progress[MAX_CPUS];
+static uint32_t waiting_for[MAX_CPUS];
+static uint32_t finished[MAX_CPUS];
+
+#define STACK_SIZE 4096
+static uint8_t stacks[MAX_CPUS][STACK_SIZE] __attribute__((aligned(16)));
+
+static uint32_t this_cpu(void)
+{
+    uint32_t mpidr;
+
+    asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
+    return mpidr & 0xff;
+}
+
+static void ticket_lock(uint32_t cpu)
+{
+    uint32_t old, newval, fail;
+    uint16_t ticket, owner;
+
+    asm volatile("1: ldrex   %0, [%3]\n"
+                 "   add     %1, %0, %4\n"
+                 "   strex   %2, %1, [%3]\n"
+                 "   teq     %2, #0\n"
+                 "   bne     1b"
+                 : "=&r" (old), "=&r" (newval), "=&r" (fail)
+                 : "r" (&lock.slock), "I" (1 << 16)
+                 : "cc", "memory");
+
+    ticket = old >> 16;
+    owner = old & 0xffff;
+    WRITE_ONCE(waiting_for[cpu], ticket);
+    while (ticket != owner) {
+        asm volatile("wfe" : : : "memory");
+        owner = READ_ONCE(lock.tickets.owner);
+    }
+    WRITE_ONCE(waiting_for[cpu], NO_TICKET);
+    asm volatile("dmb ish" : : : "memory");
+}
+
+static void ticket_unlock(void)
+{
+    asm volatile("dmb ish" : : : "memory");
+    WRITE_ONCE(lock.tickets.owner, lock.tickets.owner + 1);
+    asm volatile("dsb ishst\n"
+                 "sev" : : : "memory");
+}
+
+static void __attribute__((used)) secondary_main(void)
+{
+    uint32_t cpu = this_cpu();
+
+    for (uint32_t i = 0; i < ITERATIONS; i++) {
+        ticket_lock(cpu);
+        shared_count++;
+        /* hold the lock long enough for the others to go to sleep */
+        for (uint32_t spin = 0; spin < HOLD_LOOPS; spin++) {
+            asm volatile("" : : : "memory");
+        }
+        ticket_unlock();
+        WRITE_ONCE(progress[cpu], i + 1);
+    }
+    WRITE_ONCE(finished[cpu], 1);
+}
+
+/*
+ * Entered by PSCI CPU_ON in SVC mode with the MMU off; r0 holds the
+ * context ID, which is the top of this CPU's stack.  Use the same
+ * vectors and translation table as CPU0 (mmu_setup is in boot.S).
+ */
+asm(".text\n"
+    ".type secondary_entry, %function\n"
+    "secondary_entry:\n"
+    "    ldr r1, =vector_table\n"
+    "    mcr p15, 0, r1, c12, c0, 0\n"
+    "    mov sp, r0\n"
+    "    bl mmu_setup\n"
+    "    bl secondary_main\n"
+    "1:  wfi\n"
+    "    b 1b\n"
+    "    .ltorg\n");
+
+static int32_t psci_cpu_on(uint32_t mpidr, uint32_t entry, uint32_t ctx)
+{
+    register uint32_t r0 asm("r0") = PSCI_CPU_ON;
+    register uint32_t r1 asm("r1") = mpidr;
+    register uint32_t r2 asm("r2") = entry;
+    register uint32_t r3 asm("r3") = ctx;
+
+    asm volatile(".arch_extension virt\n"
+                 "hvc #0"
+                 : "+r" (r0)
+                 : "r" (r1), "r" (r2), "r" (r3)
+                 : "memory");
+    return r0;
+}
+
+static uint64_t read_cntvct(void)
+{
+    uint32_t lo, hi;
+
+    asm volatile("isb\n"
+                 "mrrc p15, 1, %0, %1, c14" : "=r" (lo), "=r" (hi));
+    return ((uint64_t)hi << 32) | lo;
+}
+
+static uint32_t read_cntfrq(void)
+{
+    uint32_t frq;
+
+    asm volatile("mrc p15, 0, %0, c14, c0, 0" : "=r" (frq));
+    return frq;
+}
+
+int main(void)
+{
+    uint32_t ncpus = 1, workers, stalls = 0, last_sum = 0, entry;
+    uint32_t freq = read_cntfrq();
+    uint64_t start, now, last_change, stall_ticks;
+
+    asm("movw %0, #:lower16:secondary_entry\n"
+        "movt %0, #:upper16:secondary_entry" : "=r" (entry));
+
+    for (uint32_t cpu = 1; cpu < MAX_CPUS; cpu++) {
+        if (psci_cpu_on(cpu, entry,
+                        (uint32_t)&stacks[cpu][STACK_SIZE]) != 0) {
+            break;
+        }
+        ncpus++;
+    }
+    workers = ncpus - 1;
+    if (workers < 2) {
+        ml_printf("SKIP: need -smp 3 or more (found %d CPUs)\n", ncpus);
+        return 0;
+    }
+    ml_printf("%d CPUs, %d contending workers, %d iterations each\n",
+              ncpus, workers, ITERATIONS);
+
+    stall_ticks = (uint64_t)freq / 1000 * STALL_MS;
+    start = last_change = read_cntvct();
+    for (;;) {
+        uint32_t sum = 0, done = 0, owner;
+
+        for (uint32_t cpu = 1; cpu < ncpus; cpu++) {
+            sum += READ_ONCE(progress[cpu]);
+            done += READ_ONCE(finished[cpu]);
+        }
+        if (done == workers) {
+            break;
+        }
+        now = read_cntvct();
+        if (sum != last_sum) {
+            last_sum = sum;
+            last_change = now;
+            continue;
+        }
+        if (now - last_change < stall_ticks) {
+            continue;
+        }
+
+        stalls++;
+        owner = READ_ONCE(lock.tickets.owner);
+        ml_printf("STALL %d: no progress for %d ms; lock owner %d next %d\n",
+                  stalls, STALL_MS, owner, READ_ONCE(lock.tickets.next));
+        for (uint32_t cpu = 1; cpu < ncpus; cpu++) {
+            if (READ_ONCE(waiting_for[cpu]) == owner) {
+                ml_printf("  cpu%d holds the next ticket %d and is still "
+                          "waiting: lost wake-up\n", cpu, owner);
+            }
+        }
+        if (stalls >= MAX_STALLS) {
+            ml_printf("FAIL: giving up after %d stalls\n", stalls);
+            return 1;
+        }
+        /* Recover so the rest of the run can be measured. */
+        asm volatile("dsb ishst\n"
+                     "sev" : : : "memory");
+        last_change = read_cntvct();
+    }
+
+    now = read_cntvct();
+    ml_printf("%d acquisitions in %d ms, %d stalls\n", shared_count,
+              (uint32_t)((now - start) / (freq / 1000)), stalls);
+    if (shared_count != workers * ITERATIONS) {
+        ml_printf("FAIL: count %d, expected %d\n", shared_count,
+                  workers * ITERATIONS);
+        return 1;
+    }
+    if (stalls) {
+        ml_printf("FAIL: %d lost wake-ups\n", stalls);
+        return 1;
+    }
+    ml_printf("PASS\n");
+    return 0;
+}
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index 8710ebfdad3..18f2d0a3ff4 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -79,6 +79,13 @@ tests += {
                   '-semihosting-config', 'enable=on,arg=2',
                   qemu_base_args]
   },
+  'wfe-sev-lock-aarch64.c': {
+    'cflags': cflags,
+    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
+                  '-semihosting-config', 'enable=on,chardev=stdio0',
+                  '-mon', 'chardev=stdio0,mode=readline', '-smp', '4',
+                  qemu_def_args],
+  },
   'ttbr-baddr.c': {
     'cflags': cflags,
     'qemu_args': ['-M', 'virt,virtualization=on', '-cpu', 'max',
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index c20818f0893..cf6e71fee43 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -59,6 +59,13 @@ tests += {
                   qemu_def_args],
     'wrapper': [prog_run_with_input, 'X']
   },
+  'wfe-sev-lock-arm.c': {
+    'cflags': cflags,
+    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
+                  '-semihosting-config', 'enable=on,chardev=stdio0',
+                  '-mon', 'chardev=stdio0,mode=readline', '-smp', '4',
+                  qemu_def_args],
+  },
   '../../multiarch/system/memory.c': {
     'test_name': 'memory-record-replay',
     'qemu_args': qemu_def_args,
-- 
2.47.3


