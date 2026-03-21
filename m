Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539A11094480
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3xb9-000712-1X; Sat, 21 Mar 2026 10:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3xav-00070J-VD
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:46:30 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3xas-000147-Cg
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:46:28 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35b97ed057cso900592a91.1
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774104385; x=1774709185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNzWLO6D7NdGE2f+sWqVLcKxyJ48nyjmrOFUgZ82abo=;
 b=Mis7wZEY/3ZiRTY0ppYaDROZVBkKrrCeJkUINz7/mhnC5aZVzrp6RNTWGfhwy+JJud
 tOox7CIykJee8oPxQsdl64934pw4eoPiIHlONuYoNN3EQ10Z0UBpMoCPTyJsrWq2yQg9
 1QCv5bTJGAvEmPVaPWG4v+aqTPszXhUtaRKFyqjriQ7a4LAlDjdChOE0209dYS2BkeK+
 FBgzZnK2g3dNiIieQzxfnroNGkRFeAT6vOqaeiJMW18VL2UTPRlp51z7HZlOJ8ebI8Uu
 Ii83/DXoroKOdO9j7SMlkt6+0no4euz5dP/v76K0N56gD6wy5Vv7OetXSNmqKxZvz6w/
 KhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774104385; x=1774709185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pNzWLO6D7NdGE2f+sWqVLcKxyJ48nyjmrOFUgZ82abo=;
 b=k8cKQztVFYDq+F0gNhm/7Z9S+bwAmHMk8gIsb91NT/N32bmWA/fJzu10wUBFDEZf6g
 atuav56+KfjVC3cQldEWhqIKZK/vuQ4RFL6cQd1rKQTEr6a6ImDnLOcLT7YL54pv6t/T
 tmu3Ha4yBdXPbLb/0Tu+QdO7JbyGumjeZHiaFlsnqJ+KQUYlVL+Xg7R1HhXyn5S4gKb9
 p3fCnOznZRQW3BfPpAm40dV952p7CwMNjQgmfLyKikBRvCw8Hhv+YQCwtgij7M74rTKM
 ec7VR7A62pEig91Bsh74T/oPFyFm1Twat6xEUQy8OZLJfcBFTz01LLgcx6tOE9tUrYbL
 9rFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwDjAjNPxiSoIuHUzFQq0U8gu51UiHaiFsb7y4Pj99wKKR5ZVa1XaU8AmssQCPVK3r0DKaY4w80dbo@nongnu.org
X-Gm-Message-State: AOJu0Yy2XTD6wcNyYjRPc9CjpqPLjRk2r7qzUh77Mbi6yZzgAxcg82fD
 Woz8jPpLS+Pi3ShUMDiu7gAzpkRlrWPzCGD6qVoeWtoyN9LtbjNsp3rK
X-Gm-Gg: ATEYQzw4NUyqK2Xh2akSif7BLOzSQHqkChc5ulyk2Ke3vv7e3ZjktAD7/QGA6qgOosC
 E7mq3DUuae02vIzV1yjIf/I9VlrzkpaGAWFJEfrq4HvcTOJrwlRLWycFESSkFUgWj4VGhPthRp7
 IhXA6x93u0f5KY9aI7yAbPQwL4pog9YqRWRMiJxJvvla5XjkUNGJ/yUEo1ZWGL8OnZg4ywt/4fa
 2RvEer68ob8xGY7vJVbr8TzXA6YicOUfisqn4XT4b0Xd6IPo1EH9sU7OmRMflIwSjeErFNWTlQD
 kiwPleDhtyhtjRIRa5GgZqorHVHuhmOE19NliyzrMtcedLwFICxymziO6nsPz89CwyJLUhGrBwj
 J2YK/PUUO9kZPueE43FCqMljuH9gwGjM2Z4Y/YhOqy+xG9hevfrpGepOuPDS6YM3xdgZOXVBlJy
 y9Wn3IDpOn7ch+COXBJDu9pVFXbsxs9A1JB/BvVVyq47vGz+q5KWlDTiXl2Qdk+yrOaUC0
X-Received: by 2002:a17:90a:1648:b0:35b:e4d7:53f0 with SMTP id
 98e67ed59e1d1-35be4d7960fmr453499a91.32.1774104384973; 
 Sat, 21 Mar 2026 07:46:24 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd24f1b9csm2283060a91.0.2026.03.21.07.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 07:46:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Subject: [PATCH v3 2/3] target/riscv: Fix vector whole ldst vstart check
Date: Sun, 22 Mar 2026 00:45:53 +1000
Message-ID: <20260321144554.606417-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321144554.606417-1-npiggin@gmail.com>
References: <20260321144554.606417-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

The whole vector ldst instructions do not include a vstart check, so an
overflowed vstart can result in an underflowed memory address offset and
crash:

    accel/tcg/cputlb.c:1465:probe_access_flags:
      assertion failed: (-(addr | TARGET_PAGE_MASK) >= size)

Add the VSTART_CHECK_EARLY_EXIT() check for these helpers.

This was found with a verification test generator based on RiESCUE.

Reported-by: Nicholas Joaquin <njoaquin@tenstorrent.com>
Reported-by: Ganesh Valliappan <gvalliappan@tenstorrent.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/vector_helper.c             |  2 +
 tests/tcg/riscv64/Makefile.target        |  5 ++
 tests/tcg/riscv64/test-vstart-overflow.c | 78 ++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-vstart-overflow.c

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index caa8dd9c12..4126447d11 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -825,6 +825,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t esz = 1 << log2_esz;
     int mmu_index = riscv_env_mmu_index(env, false);
 
+    VSTART_CHECK_EARLY_EXIT(env, evl);
+
     /* Calculate the page range of first page */
     addr = base + (env->vstart << log2_esz);
     page_split = -(addr | TARGET_PAGE_MASK);
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 4da5b9a3b3..19a49b6467 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -18,3 +18,8 @@ TESTS += test-fcvtmod
 test-fcvtmod: CFLAGS += -march=rv64imafdc
 test-fcvtmod: LDFLAGS += -static
 run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
+
+# Test for vstart >= vl
+TESTS += test-vstart-overflow
+test-vstart-overflow: CFLAGS += -march=rv64gcv
+run-test-vstart-overflow: QEMU_OPTS += -cpu rv64,v=on
diff --git a/tests/tcg/riscv64/test-vstart-overflow.c b/tests/tcg/riscv64/test-vstart-overflow.c
new file mode 100644
index 0000000000..6c904ab309
--- /dev/null
+++ b/tests/tcg/riscv64/test-vstart-overflow.c
@@ -0,0 +1,78 @@
+/*
+ * Test for VSTART set to overflow VL
+ *
+ * TCG vector instructions should call VSTART_CHECK_EARLY_EXIT() to check
+ * this case, otherwise memory addresses can underflow and misbehave or
+ * crash QEMU.
+ *
+ * TODO: Add stores and other instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <stdint.h>
+
+#define VSTART_OVERFLOW_TEST(insn)                \
+({                                                \
+    uint8_t vmem[64] = { 0 };                     \
+    uint64_t vstart;                              \
+    asm volatile("                           \r\n \
+    # Set VL=52 and VSTART=56                \r\n \
+    li          t0, 52                       \r\n \
+    vsetvli     x0, t0, e8, m4, ta, ma       \r\n \
+    li          t0, 56                       \r\n \
+    csrrw       x0, vstart, t0               \r\n \
+    li          t1, 64                       \r\n \
+    " insn "                                 \r\n \
+    csrr        %0, vstart                   \r\n \
+    " : "=r"(vstart), "+A"(vmem) :: "t0", "t1", "v24", "memory"); \
+    vstart;                                       \
+})
+
+int run_vstart_overflow_tests()
+{
+    /*
+     * An implementation is permitted to raise an illegal instruction
+     * exception when executing a vector instruction if vstart is set to a
+     * value that could not be produced by the execution of that instruction
+     * with the same vtype. If TCG is changed to do this, then this test
+     * could be updated to handle the SIGILL.
+     */
+    if (VSTART_OVERFLOW_TEST("vl1re16.v    v24, %1")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vs1r.v       v24, %1")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vle16.v      v24, %1")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vse16.v      v24, %1")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vluxei8.v    v24, %1, v20")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vloxei8.v    v24, %1, v20")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vlse16.v     v24, %1, t1")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vlseg2e8.v  v24, %1")) {
+        return 1;
+    }
+
+    return 0;
+}
+
+int main()
+{
+    return run_vstart_overflow_tests();
+}
-- 
2.51.0


