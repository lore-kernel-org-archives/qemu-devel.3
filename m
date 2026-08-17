Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DD0C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtI3-0003Ix-W6; Mon, 17 Aug 2026 05:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHy-0003GR-7h; Mon, 17 Aug 2026 05:05:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHv-0001e3-Bo; Mon, 17 Aug 2026 05:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=utiKwMr7tt4Lc3FTekCTFVUme/jpKc1Y5tzV4yb+5+Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Bh8S5DRRfldacJmUH+muolsV6LlM5lK7ZdQTZjyMzo6OvaiX5i7j4FDUUhJ19+3zv
 8Ek60q6CiZJrmQmL7hKFcwXSYB/eN9GzFF25vr4IB5z78yufscmd3tVtW75EzlgD+C
 d3q+KZO3CoOeDVGsotLhjeDy9vVHCXnzppJLLxuwakWUWiz/LRVHfIjXED6ujh7oyr
 F13vMK/7oGNvneIyjaTfmx1j+c1GKkdD7+Oy+pdWs1EM9jV9bueS8VzZrldmCImbTz
 hgjzECT6io7CqJfyGu4SXMGjkiCIhpEIrDdFOO6pmZJotiHzSpVi/HB7A06UC52ElG
 4fyexinFgGftA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1B0FD1CBA3A;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EB93140D01C;
 Mon, 17 Aug 2026 12:05:26 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AFC9830CEC; Mon, 17 Aug 2026 12:05:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 06/42] tests/tcg/hexagon: add slot-assignment tests
Date: Mon, 17 Aug 2026 12:04:11 +0300
Message-ID: <20260817090453.2034156-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

valid-slots: packets that legally share a slot and were wrongly
rejected before the fix (load and transfer, load encoded first;
dczeroa packed last with three transfers).

invalid-slots: unassignable packets that must still be rejected:
store + duplex, load + indirect jump, three logical ops competing for
slots 2 and 3, and five ops for four slots.

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
(cherry picked from commit d2504d4cea329dcec69af4d590cbaa490c409724)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index a2a0ffc69b2..80e56f7d055 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -51,6 +51,7 @@ HEX_TESTS += scatter_gather
 HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
 HEX_TESTS += invalid-slots
+HEX_TESTS += valid-slots
 HEX_TESTS += invalid-encoding
 HEX_TESTS += multiple-writes
 HEX_TESTS += unaligned_pc
diff --git a/tests/tcg/hexagon/invalid-slots.c b/tests/tcg/hexagon/invalid-slots.c
index 607027f314d..f2dace2e541 100644
--- a/tests/tcg/hexagon/invalid-slots.c
+++ b/tests/tcg/hexagon/invalid-slots.c
@@ -55,6 +55,75 @@ static int test_invalid_slots(void)
     return sig;
 }
 
+/* Load then indirect jump, load encoded first: no high slot left for jump. */
+static int test_invalid_slots_highslot(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        "r3 = #mem\n"
+        ".word 0x91834006\n" /* { r6 = memw(r3+#0); */
+        ".word 0x529fc000\n" /*   jumpr r31 }        */
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "r3", "r6", "memory");
+
+    return sig;
+}
+
+/*
+ * Three predicate-logical ops: each is restricted to slots 2 and 3, so the
+ * fourth-and-fifth-slot-free packet still has only two slots for three ops.
+ * No change-of-flow is involved, so the only reason to reject it is the slot
+ * conflict.
+ */
+static int test_invalid_slots_crslot23(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x6b024100\n" /* { p0 = and(p1, p2); */
+        ".word 0x6b224103\n" /*   p3 = or(p1, p2);   */
+        ".word 0x6b42c301\n" /*   p1 = xor(p2, p3) } */
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "p0", "p1", "p3", "memory");
+
+    return sig;
+}
+
+/* Three transfers plus a duplex: five ops for four slots. */
+static int test_invalid_slots_five(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x78004020\n" /* { r0 = #1;           */
+        ".word 0x78004041\n" /*   r1 = #2;            */
+        ".word 0x78004062\n" /*   r2 = #3;            */
+        ".word 0x28452856\n" /*   r5 = #4; r6 = #5 }  */
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "r2", "r5", "r6", "memory");
+
+    return sig;
+}
+
 int main()
 {
     struct sigaction act;
@@ -65,6 +134,9 @@ int main()
     assert(sigaction(SIGILL, &act, NULL) == 0);
 
     assert(test_invalid_slots() == SIGILL);
+    assert(test_invalid_slots_highslot() == SIGILL);
+    assert(test_invalid_slots_crslot23() == SIGILL);
+    assert(test_invalid_slots_five() == SIGILL);
 
     puts("PASS");
     return EXIT_SUCCESS;
diff --git a/tests/tcg/hexagon/valid-slots.c b/tests/tcg/hexagon/valid-slots.c
new file mode 100644
index 00000000000..70d9b0b6acf
--- /dev/null
+++ b/tests/tcg/hexagon/valid-slots.c
@@ -0,0 +1,62 @@
+/*
+ * Regression tests for valid packets that qemu incorrectly rejected as
+ * invalid.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+
+int err;
+
+#include "hex_test.h"
+
+/* volatile to keep the load from being optimized away */
+static volatile int buf[2] = { 0x1234, 0 };
+
+/* Load and register transfer in one packet, load encoded first. */
+static int32_t load_imm_pair(void)
+{
+    int32_t out;
+    /* { r6 = memw(r3+#-4); r7 = #0x4ae6 } */
+    asm volatile(
+        "{ r3 = %1 }\n\t"
+        ".word 0x97837fe6\n\t"
+        ".word 0x7845dcc7\n\t"
+        "{ %0 = r6 }\n\t"
+        : "=r"(out) : "r"(&buf[1]) : "r3", "r6", "r7");
+    return out;
+}
+
+static int32_t dcbuf[8] __attribute__((aligned(32)));
+
+/* Slot-0-only op (dczeroa) packed last with three transfers. */
+static void slot0_restricted(int32_t *out)
+{
+    asm volatile(
+        "{ %0 = #0x11\n\t"
+        "  %1 = #0x22\n\t"
+        "  %2 = #0x33\n\t"
+        "  dczeroa(%3) }\n\t"
+        : "=r"(out[0]), "=r"(out[1]), "=r"(out[2])
+        : "r"(dcbuf) : "memory");
+}
+
+int main()
+{
+    int32_t r[3];
+
+    check32(load_imm_pair(), 0x1234);
+
+    dcbuf[0] = 0x5a5a5a5a;
+    slot0_restricted(r);
+    check32(r[0], 0x11);
+    check32(r[1], 0x22);
+    check32(r[2], 0x33);
+    check32(dcbuf[0], 0);       /* dczeroa cleared the line */
+
+    puts(err ? "FAIL" : "PASS");
+    return err;
+}
-- 
2.47.3


