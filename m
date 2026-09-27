Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F106DCA5FA2
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmST-00087B-5C; Sun, 27 Sep 2026 06:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmSQ-0007xb-MH; Sun, 27 Sep 2026 06:50:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmSO-00014m-Q5; Sun, 27 Sep 2026 06:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506136; bh=knZhph2XZ8QOEruRqI+5dyMIHI0zD0BZACq40LF4KE4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VXo97EmS4Ha45Yd0uGRelQAhgK2FIsgrjJ4qR7/fMlfcIr2tb+JFlx/PEZwtki06i
 WbO1X9kh76XXplOl5hw+309WJTd16AdQSgbrqxeEeHyDy0qGzMgOb54Kdk/uaub8My
 QhTBERKyuNSVLvEm/B2QgLi1G5d5eowYiK144A9VJwSV13WmJi6CHrweGBnhGUJHax
 8Z2pi0RkIgRXh4Ugv0H/p0tWMWefaBVP1CmSggjcz3DXLkRy5YYmwcUmId1XLxW6bO
 zeGGxVQXWLIpCX4msNYyde//TgkXkCTCcVJnl07UK1N+tq43H3emnDLR41lS1HZr5y
 TWwb7sysKFnhg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 056951D8B68;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 02DAE43216F;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D760F5E788; Sun, 27 Sep 2026 13:48:55 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 73/92] tests/tcg/arm: Add regression test for #4448
Date: Sun, 27 Sep 2026 13:47:49 +0300
Message-ID: <20260927104821.196183-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 4278a7ba36c2f7f5297c8ed886646a4a453f555c)
(Mjt: adjust across make=>meson conversion in tcg tests)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 613bbf0939a..51a3ed76a87 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -32,6 +32,8 @@ run-fcvt: fcvt
 ARM_TESTS += pcalign-a32
 pcalign-a32: CFLAGS+=-marm
 
+ARM_TESTS += issue4448
+
 ifeq ($(CONFIG_ARM_COMPATIBLE_SEMIHOSTING),y)
 
 # Semihosting smoke test for linux-user
diff --git a/tests/tcg/arm/issue4448.c b/tests/tcg/arm/issue4448.c
new file mode 100644
index 00000000000..0a498373a89
--- /dev/null
+++ b/tests/tcg/arm/issue4448.c
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <assert.h>
+#include <stdint.h>
+
+/* Signed 64-bit product, constant operand first then second. */
+#define SMULL_CONST_LHS(k, x, lo, hi) \
+    __asm__("mov r0, #" #k "\n\tsmull %0, %1, r0, %2" \
+            : "=&r"(lo), "=&r"(hi) : "r"(x) : "r0", "cc")
+
+#define SMULL_CONST_RHS(k, x, lo, hi) \
+    __asm__("mov r0, #" #k "\n\tsmull %0, %1, %2, r0" \
+            : "=&r"(lo), "=&r"(hi) : "r"(x) : "r0", "cc")
+
+/* Unsigned 64-bit product, for contrast: this one is folded correctly. */
+#define UMULL_CONST_LHS(k, x, lo, hi) \
+    __asm__("mov r0, #" #k "\n\tumull %0, %1, r0, %2" \
+            : "=&r"(lo), "=&r"(hi) : "r"(x) : "r0", "cc")
+
+static int64_t s64(int32_t hi, int32_t lo)
+{
+    return ((int64_t)hi << 32) | (uint32_t)lo;
+}
+
+static uint64_t u64(int32_t hi, int32_t lo)
+{
+    return ((uint64_t)(uint32_t)hi << 32) | (uint32_t)lo;
+}
+
+int main(void)
+{
+    static const int32_t values[] = { 1961612, -1479053948, -7, 0 };
+
+    for (unsigned i = 0; i < sizeof(values) / sizeof(values[0]); i++) {
+        int32_t x = values[i];
+        int32_t lo, hi;
+
+        SMULL_CONST_LHS(1, x, lo, hi);
+        assert(x == s64(hi, lo));
+
+        SMULL_CONST_RHS(1, x, lo, hi);
+        assert(x == s64(hi, lo));
+
+        UMULL_CONST_LHS(1, x, lo, hi);
+        assert((uint32_t)x == u64(hi, lo));
+
+        SMULL_CONST_LHS(0, x, lo, hi);
+        assert(0 == u64(hi, lo));
+    }
+    return 0;
+}
-- 
2.47.3


