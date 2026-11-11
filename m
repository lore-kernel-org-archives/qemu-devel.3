Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF7C60A2612
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xNj+NC3G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR8QS-00055X-FS; Wed, 11 Nov 2026 08:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xR8QN-000532-Is
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:31:39 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xR8QL-00033P-LV
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:31:39 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-3ac97e45a79so25616771fa.3
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 05:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794403895; x=1795008695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0u9U32X3vHTczU7kMoheGmy0ykNTcqwgVB3MjLO8cGo=;
 b=xNj+NC3GTf5j9FCmzWr2qmvm1KMqh2KnU0mdqyIjZODD6NDLxK/3PkxJpp4n9Nh0GH
 S6J3ptcMKkpCGD/T77Ift1MaGJynnDBx5fqz2AsQICsCo1PQKxd1Jr1yEgrdhzp9IeMT
 rJOpsXvTy2aPLAnG0GtQYa2NYuDKPLJH4Pn8Ofj8HtJoddC6FnnKGAQtzdANldv+ugxA
 uhMIbRHS/5/x+haNk1CUpgIPIAq7AePg6UTIYye2FKhBpl3R5OowP9h3DpYgyy+is6Ua
 6J/EihNOnGMw1P7PbcJM4Tq7sYHZZmEhc4CnV+R5cXylNYmon0QC6r7dlZwFf8nVl4cQ
 IU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794403895; x=1795008695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0u9U32X3vHTczU7kMoheGmy0ykNTcqwgVB3MjLO8cGo=;
 b=ICScweOl1crKCtILExnhGyYldIIiufmEUTQsar5yRpe+quK+mlZqUA9O8+cQdKUzjB
 w5XZkQioTimGFS9W63sZGKkUY0BMjwWXvcF5MC86zYg8xORgkUXE6lyr2RVaw6gYjy8Q
 0vTbLUXhkJcuMazGhTfw+hwcHH55fBCMgqWKDt1wNp/lCNdVGnXy6W+WcEUM/bcoQ4Nd
 uOJUkGSEUgWt0lRuCLoi/qbcvEWzcpaNx5nonUhoZCUj+EbBe6hAxpDqHB4WMSDfc3gm
 PAJgd2AjbymrDPB/v6ysZTP52l5ocL2mNMg3pkupExi32725fqcw+EqxhCm+QTacqe8Y
 OvUg==
X-Gm-Message-State: APuU4Z/2YAWCzX7UZqOX2w0IkfCbnR9C3NMDCRSamr/wUOIa12t+lkdP
 rAfj0BHWkwxYWHIyzCY1zsNJezKElYRXWwl/N0ZMG57RRsR5Aewqpl7v7yL8bQ==
X-Gm-Gg: AYBFou3323MWxTQZ7w5NtTpgzV5SpWUHZpOxioZy3JiOUZX5XOKeU2bQjVsHORiZCp2
 JISQZx0frWgM65+63u8Tc504aba3toiN6zBm6BlqF4RA6T7vPAfC26cDMRBAhKR9HZOxRcj0cEX
 dxD/chK7DRH3PSHpkerLbvsJSDPoo3VN9WrZajxgvp0utoF46JwW55IY7is2Vcq/B66YD17ST3c
 ncTGUKtFpn9zNc2uUWTPL4UOn79T9xpXMjZZeJeWIrvkhZitKveuRvpWLBuCBJUk/QL/kCOTBFN
 dRRJ+geamogUbz6rOzx7yIs9uMoK7Cxxtrw5Ccn7NrtJOwTPVP4XbiyRK95Dma4caqRriGSKY0O
 LvdtPEk6OwFaOmXQEWYpY+mGyY3/nYX9Mco/LJAoZ9pUrRzACFMQC57avMGlqHnFJKb0UJ62nES
 G/mlq7REBk/WRhJbkjdveHbPZu7Yw6nH0/PI9cQY2HkoMJwZpWx0n18sGiAVc10T2Hm37ENKWgV
 0igtcODdGK/F43vj/zsN5ylJDcghsu3QIn67/U4a3uCHyUVqZC6pHfVB4IgiCSl+SsFyleH/Ssm
 5ImBpx9X/UWCPt19IpJBJ8G+ZLoNWPo7XyYX8l3FdTi6wcvcQoa9nQZyFxf4zsYjGAMLpL6ACsh
 SQJSnOwS4a1D/Et5qdEyeqjt2pZ9z55ibpLyPIyWi9rLeM1SPQZQmr1gfQ+w=
X-Received: by 2002:a05:651c:a168:b0:3a6:5ec0:7977 with SMTP id
 38308e7fff4ca-3ae126b7f74mr4814821fa.22.1794403894691; 
 Wed, 11 Nov 2026 05:31:34 -0800 (PST)
Received: from qblck ([188.130.155.185]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae177150c8sm2900641fa.40.2026.11.11.05.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:31:33 -0800 (PST)
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
To: qemu-devel@nongnu.org
Cc: Artemii Mashanov <ralerrdirsardx@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/i386: avoid signed overflow in IDIV helpers
Date: Wed, 11 Nov 2026 16:31:11 +0300
Message-ID: <20261111133111.23379-1-ralerrdirsardx@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=ralerrdirsardx@gmail.com; helo=mail-lj1-x22d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For 16/32 bit IDIV, dividing the minimum double-width signed
dividend by -1 overflows host division before the quotient check.
On x86 hosts this terminates QEMU with SIGFPE.

Detect these cases before dividing and raise the guest divide-error
exception. Add a shared i386/x86_64 regression test checking SIGFPE
with FPE_INTDIV.

Based on the diagnosis by naehrwert in issue #4687.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4687
Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
---
 target/i386/tcg/int_helper.c   |  4 ++--
 tests/tcg/i386/idiv-overflow.c | 42 ++++++++++++++++++++++++++++++++++
 tests/tcg/i386/meson.build     |  1 +
 tests/tcg/x86_64/meson.build   |  1 +
 4 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/i386/idiv-overflow.c

diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index 772e6ad..d4fa891 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -91,7 +91,7 @@ void HELPER(idivw_AX)(CPUX86State *env, target_ulong t0)
 
     num = (env->regs[R_EAX] & 0xffff) | ((env->regs[R_EDX] & 0xffff) << 16);
     den = (int16_t)t0;
-    if (den == 0) {
+    if (den == 0 || (num == INT32_MIN && den == -1)) {
         raise_exception_ra(env, EXCP00_DIVZ, GETPC());
     }
     q = (num / den);
@@ -130,7 +130,7 @@ void HELPER(idivl_EAX)(CPUX86State *env, target_ulong t0)
 
     num = ((uint32_t)env->regs[R_EAX]) | ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
     den = t0;
-    if (den == 0) {
+    if (den == 0 || (num == INT64_MIN && den == -1)) {
         raise_exception_ra(env, EXCP00_DIVZ, GETPC());
     }
     q = (num / den);
diff --git a/tests/tcg/i386/idiv-overflow.c b/tests/tcg/i386/idiv-overflow.c
new file mode 100644
index 0000000..09650a6
--- /dev/null
+++ b/tests/tcg/i386/idiv-overflow.c
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#define _GNU_SOURCE
+#include <assert.h>
+#include <signal.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+static void on_fpe(int sig, siginfo_t *info, void *context)
+{
+    (void)context;
+    _exit(sig != SIGFPE || info->si_code != FPE_INTDIV);
+}
+
+int main(void)
+{
+    struct sigaction act = { .sa_sigaction = on_fpe, .sa_flags = SA_SIGINFO };
+
+    assert(sigemptyset(&act.sa_mask) == 0);
+    assert(sigaction(SIGFPE, &act, NULL) == 0);
+    for (int bits = 16; bits <= 32; bits += 16) {
+        pid_t child = fork();
+        int status;
+
+        assert(child >= 0);
+        if (child == 0) {
+            unsigned int low = 0;
+            unsigned int high = bits == 16 ? 0x8000 : 0x80000000;
+
+            if (bits == 16) {
+                asm volatile("idivw %%cx" : "+a"(low), "+d"(high)
+                             : "c"(-1) : "cc");
+            } else {
+                asm volatile("idivl %%ecx" : "+a"(low), "+d"(high)
+                             : "c"(-1) : "cc");
+            }
+            _exit(1);
+        }
+        assert(waitpid(child, &status, 0) == child);
+        assert(WIFEXITED(status) && WEXITSTATUS(status) == 0);
+    }
+    return 0;
+}
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index e7c3095..f1b3ac5 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -8,6 +8,7 @@ tests += {
   'hello-i386.c': {
     'cflags': ['-ffreestanding', '-fno-stack-protector', '-nostdlib'],
   },
+  'idiv-overflow.c': {},
   'test-aes.c': {'cflags': ['-O1', '-msse2', '-maes']},
   'test-i386-adcox.c': {'cflags': ['-O2']},
   'test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index ad4d1f5..713dde6 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -25,6 +25,7 @@ test_mmx_h = custom_target('test_mmx_h',
                            output: 'test-mmx.h')
 
 tests += {
+  '../i386/idiv-overflow.c': {},
   '../i386/test-i386-ssse3.c': {},
   '../i386/test-3dnow.c': {
     'cflags': ['-I', meson.current_build_dir(),
-- 
2.56.0


