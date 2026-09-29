Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A2FCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfj-0000OV-Kk; Tue, 29 Sep 2026 06:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfV-0007nq-Km
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:39 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfT-0008IH-Mz
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:37 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6351831so2325234f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676154; x=1791280954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rqBojLbCAJdb8o0z6PQrao6Bfg5Y3dF1+yEO0sf017Q=;
 b=Ko4R7X+TA7RAp6HEt7bOG0ICBsXU/LRtA2iOCeDG6251hH8gw55sV33dX43iwuLDMh
 p/NShAltFjS/UZ9uVtGRnQMh+ERguqM9k8AC3DaNl8L8/i5WHjfU5c4hMxeMlpyNeB4R
 C0Tr5usnPE1anV8BGRDGzk1Hro0ELJQlrsrawDmNU7O/Zi5P+BE156or6QKKnZHBX4YX
 C91wm/TQtbNDrDmMywkmcjj64qxWj8yD0HM1v/b4NeuVaoIxe7Z9rjqTzGU8Rnu2zGHq
 rGPzw0xZp+K5xcNPZaI9tTQRvE5qZ2ty1lH+7yWG/DPkGmgna4gEFFgdn6JjL1dUBTSv
 cedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676154; x=1791280954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rqBojLbCAJdb8o0z6PQrao6Bfg5Y3dF1+yEO0sf017Q=;
 b=u9P6zdEujFHtxLvEbziJ8Ts0QuNkBWrv0AphYsv1Ni/MCytGGwdaQBRFdsor+yBn+v
 ZJYtR1QzE5f+0DQiBajZZtMZPgnAjGF/L3WsEMR3uY5p3CiATTm9uX4aCPSWgNExlW8r
 xKIlJKBvXQP0jadrb9xsNwIHjpo3Qoe7krlRB8m0FkMVWUoM1kITIy4WXDtdqxarSruU
 D38DgJg/ecbh5lImSPpWeP1C+AoUWC964AOGAGaqZ75tZzOmtApT7QaFaRqyg9JB1qkL
 xmI2fHe2Sul7SyUz+Fr/7PZ2/7MPaugQXR5GZ7H9a8e+9k2hW8d6Y8dJF1v4HSTO8WH6
 sDSA==
X-Gm-Message-State: AFq9FYJ+6KBgtX+zEz9CYpajb1i8wDgRB6g1fX2ch4shC3hufaqDfUq2
 a33rwxmvLXUUBR1X0qQp7u5rxoCDFviCDtotbpEJUUBu8ZxVb9TBcB3SQ+KKe16qdwh0gI9462T
 pvpHq
X-Gm-Gg: AYBFou2l106Pze/+xWlA+QSStJUsRMRQSgGDVBVsjI0umRj1o9lyojp3VX8h2TJLmrL
 MN+5vM62Yp75tyAKYTn+yjNd0oOe38VkMK1UkzBEeRJS28tYQxfTg+LTKT/iGL96s6pNRjXTlAC
 SMDZnU1rFUSnfMMz//0MblbUSRBZxXH5ZnxK9gm4JndGoKtBvpwVBRkHfMXLqscpzRHfjG/aUkl
 /nQlKta7knl7xSDAggS1EKhFAjGF4ds/6XBz51G7QzlsPrECScdlYr/O1JI8dSjVqZBTaJYSeD+
 qijy17a3caVcbQFJV1mfTVSzB6LmhRM2fbrjownFfKfQgPgJE9EfCh/1seHBKaTAjSImgakVTAW
 ymk4VgrVEvONGi2UqbEqKwUgnvDG6ryEtZutH73UmnTI/+b6UjHBPjDxqGsc8fEFOahAyxBrHjL
 TlgVvlWKP40zzwDL98BEY+h0STrPPPqirdOFn4dQ/FHzjb0QAGyABzLepKlOAEsSsiy5gHbzg1W
 QIYsq0fiU+8Dbg8ZQ8X3fhstjmZiW1xngE3seimltsBcN8D5Ue3mvk1uV6jC8IP0/DU4C4Y1VYm
 dt8=
X-Received: by 2002:a05:6000:22c2:b0:48a:fa0a:34d8 with SMTP id
 ffacd0b85a97d-48afa0a35a1mr567943f8f.38.1790676154013; 
 Tue, 29 Sep 2026 03:02:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/37] target/arm: Fix WFxT timeouts when the offset puts the
 count ahead
Date: Tue, 29 Sep 2026 11:01:32 +0100
Message-ID: <20260929100133.2598676-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Fuad Tabba <fuad.tabba@linux.dev>

The WFIT and WFET helpers arm the wakeup timer at count == timeout +
offset, treating an overflow of that sum as "beyond the counter's
wrap" and arming at INT64_MAX. As in gt_recalc_timer(), that reading
is valid only when offset <= count: with a CNTVOFF_EL2 that puts the
virtual count ahead of the physical count, the sum overflows for
every timeout still in the future and the wrapped value was the
correct wakeup. The CPU then waits until an interrupt or event
instead of waking at its timeout. A Linux guest uses WFIT and WFET in
__delay() when FEAT_WFxT is present, which -cpu max advertises.

Arm cntval + (timeout - cntvct) instead, so only a physical count past
2^64 is "never", and add a tcg system test that issues WFIT and WFET
with such an offset, with a timer interrupt 1s out so a broken WFxT
still returns: before this change both wake at the interrupt, after
it at their timeout.

Fixes: a96edb687e76 ("target/arm: Implement FEAT WFxT and enable for '-cpu max'")
Fixes: da9b86c35fa8 ("target/arm: implement WFET")
Cc: qemu-stable@nongnu.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Message-id: 20260921074451.3158645-3-fuad.tabba@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/op_helper.c           |   6 +-
 tests/tcg/aarch64/system/meson.build |   7 ++
 tests/tcg/aarch64/system/wfxt.c      | 118 +++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/wfxt.c

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 643b1482523..af56eff9f18 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -448,7 +448,8 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
         raise_exception(env, excp, syn_wfx(1, 0xe, rd, true, WFIT, false), target_el);
     }
 
-    if (uadd64_overflow(timeout, offset, &nexttick)) {
+    /* Physical count at the timeout. Only an overflow of it is "never". */
+    if (uadd64_overflow(cntval, timeout - cntvct, &nexttick)) {
         nexttick = UINT64_MAX;
     }
     if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
@@ -705,7 +706,8 @@ void HELPER(wfet)(CPUARMState *env, uint32_t rd)
      * The WFET should time out when CNTVCT_EL0 >= the specified value.
      */
     cpu = env_archcpu(env);
-    if (uadd64_overflow(timeout, offset, &nexttick)) {
+    /* Physical count at the timeout. Only an overflow of it is "never". */
+    if (uadd64_overflow(cntval, timeout - cntvct, &nexttick)) {
         nexttick = UINT64_MAX;
     }
     if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index f9c4448abaf..f51feb253f9 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -72,6 +72,13 @@ tests += {
                   '-semihosting-config', 'enable=on,arg=2',
                   qemu_base_args]
   },
+  'wfxt.c': {
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,virtualization=on,gic-version=2',
+                  '-cpu', 'max', '-smp', '1',
+                  '-semihosting-config', 'enable=on,arg=2',
+                  qemu_base_args]
+  },
 }
 
 tests += {
diff --git a/tests/tcg/aarch64/system/wfxt.c b/tests/tcg/aarch64/system/wfxt.c
new file mode 100644
index 00000000000..9d50590a684
--- /dev/null
+++ b/tests/tcg/aarch64/system/wfxt.c
@@ -0,0 +1,118 @@
+/*
+ * WFIT/WFET timeout test
+ *
+ * Copyright (c) 2026 Google LLC
+ * Author: Fuad Tabba <fuad.tabba@linux.dev>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <minilib.h>
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
+#define write_sysreg(r, v) do {                     \
+        uint64_t __val = (uint64_t)(v);             \
+        asm volatile("msr " __stringify(r) ", %x0"  \
+                 : : "rZ" (__val));                 \
+} while (0)
+
+/* .inst forms of WFIT x0 and WFET x0, for assemblers without FEAT_WFxT */
+static inline void wfit(uint64_t timeout)
+{
+    register uint64_t x0 asm("x0") = timeout;
+
+    asm volatile(".inst 0xd5031020" : : "r" (x0) : "memory");
+}
+
+static inline void wfet(uint64_t timeout)
+{
+    register uint64_t x0 asm("x0") = timeout;
+
+    asm volatile(".inst 0xd5031000" : : "r" (x0) : "memory");
+}
+
+/* virt machine, GICv2 */
+#define GICD_BASE 0x08000000UL
+#define GICC_BASE 0x08010000UL
+#define GICD_CTLR 0x000
+#define GICD_ISENABLER0 0x100
+#define GICC_CTLR 0x000
+#define GICC_PMR 0x004
+#define VTIMER_PPI 27
+
+static inline void mmio_write32(uintptr_t addr, uint32_t val)
+{
+    /* GIC registers: MMIO, MMU off at EL2 */
+    *(volatile uint32_t *)addr = val;
+}
+
+static int test_one(const char *name, void (*wait)(uint64_t), uint64_t freq)
+{
+    uint64_t now, timeout, elapsed;
+    int early = 0;
+
+    /*
+     * The virtual timer interrupt, 1s out, wakes the CPU even with
+     * interrupts masked. The timeout, 10ms out, must be what wakes it.
+     */
+    now = read_sysreg(cntvct_el0);
+    write_sysreg(cntv_cval_el0, now + freq);
+    write_sysreg(cntv_ctl_el0, 1);
+    timeout = now + freq / 100;
+
+    do {
+        wait(timeout);
+        early++;
+    } while (read_sysreg(cntvct_el0) < timeout && early < 1000);
+
+    elapsed = read_sysreg(cntvct_el0) - now;
+    write_sysreg(cntv_ctl_el0, 0);
+
+    ml_printf("%s: woke after %ld ticks (%d wakes)\n", name, elapsed, early);
+    if (early >= 1000) {
+        ml_printf("FAIL: %s kept waking before its timeout\n", name);
+        return 1;
+    }
+    if (elapsed > freq / 2) {
+        ml_printf("FAIL: %s woke on the timer interrupt, not its timeout\n",
+                  name);
+        return 1;
+    }
+    return 0;
+}
+
+int main(void)
+{
+    uint64_t freq;
+    int ret;
+
+    ml_printf("WFxT Test\n");
+
+    mmio_write32(GICD_BASE + GICD_ISENABLER0, 1u << VTIMER_PPI);
+    mmio_write32(GICD_BASE + GICD_CTLR, 1);
+    mmio_write32(GICC_BASE + GICC_PMR, 0xff);
+    mmio_write32(GICC_BASE + GICC_CTLR, 1);
+
+    /* Put the virtual count ahead of the physical count */
+    write_sysreg(cntvoff_el2, -(1ULL << 60));
+    asm volatile("isb");
+    freq = read_sysreg(cntfrq_el0);
+
+    ml_printf("cntvoff_el2=%lx cntfrq_el0=%ld\n",
+              read_sysreg(cntvoff_el2), freq);
+
+    ret = test_one("wfit", wfit, freq);
+    ret |= test_one("wfet", wfet, freq);
+
+    return ret;
+}
-- 
2.43.0


