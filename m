Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D6BEDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4Y1-0003jn-Si; Tue, 10 Sep 2024 13:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4Xy-0003WV-KP
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:20:59 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4Xv-0002oM-4B
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:20:58 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2da4ea59658so4245383a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725988853; x=1726593653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWmLCLoNciq5fxHCng9pTolj63fwpRl66Nb/LCsfMPA=;
 b=gaT3pSGYOUt8qhHZC8RIWkMe9xuasHH3JLL5T7qW78/JxRZdFOVN2xTv8KQULMeOH6
 JionMOwySvlBjJfIRioLrfF2w4wfvdKMEpD9DF/YDugy9cLEcRFtzmLSnvywJVn2nLxF
 f/7XygzSqverfofVTO4zSz+ALZrh8U8ycR3yqOar9DpWA0mLIZL/Hn6f0SbAThl4r7nI
 JaF3b9FVXqAR3T5UCB4wgjRlF0M1V+og9EDXI5HuyW/CkxNXbBf1kuovemDcYEYphUkN
 NGXBxmrV1d/1w/HyVrSDYorhnZKCCIExyYutpn+KPyz5UY6ASMIcFwuoScwUgE0+lRKF
 R5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988853; x=1726593653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JWmLCLoNciq5fxHCng9pTolj63fwpRl66Nb/LCsfMPA=;
 b=sz3FLZL15wPgI29NjA6jXtKhxjbuohLLIM4tBbJAWkVgvJVtv0P0dAPsH8zx1wLx/H
 DVuvDxXQbLNA+73tgY/MP7xONlviBbYwLG+4ub4eIrQrcfv4p0PGOvKNhMpXJf3yggk7
 R0sGtqyqS/u5EpFUVNMEVUTlZcXGR3YBHSiz3FmcecTDexU7L0iuLnoZmsQaJF2RHor4
 3yahpwRTvYtXZsfJ2AOfVSk5n5A0qWR3Hp78nF8QEjWGVTBMfL0lkLD/Bb18uvSEwkIh
 xNLRjJH60EPabUrTZ09fVZxCZQ8HY7FhBbpsa2o4uKZAw5XYazoH6z8+ZAt+xv3vThuK
 PDNA==
X-Gm-Message-State: AOJu0YypkQmmgmLy+kzZy9XecmiBz4DTWX7yVeUAd7w5wzpmAj9oyLVG
 7bbKNPJrWwA33ZOJFYONSrDlwZ3eO4riDnpiU54jVOqtou/MT4ggKb9KqKX6S7JDmKUqp0iVQB+
 CGRWzTA==
X-Google-Smtp-Source: AGHT+IHXW/rlaNReduIzS0jvKLOhqstXU170ueqIMTsd1J/OsyPqeGAkdNaX4FgweVoPHtPdN8b+FA==
X-Received: by 2002:a17:90b:fcb:b0:2c9:81fd:4c27 with SMTP id
 98e67ed59e1d1-2dad4ef0cfcmr15874868a91.14.1725988853260; 
 Tue, 10 Sep 2024 10:20:53 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db049883e5sm6685310a91.50.2024.09.10.10.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:20:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v8 6/6] tests/tcg/multiarch: add test for plugin memory access
Date: Tue, 10 Sep 2024 10:20:33 -0700
Message-Id: <20240910172033.1427812-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910172033.1427812-1-pierrick.bouvier@linaro.org>
References: <20240910172033.1427812-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

Add an explicit test to check expected memory values are read/written.
8,16,32 load/store are tested for all arch.
64,128 load/store are tested for aarch64/x64.
atomic operations (8,16,32,64) are tested for x64 only.

By default, atomic accesses are non atomic if a single cpu is running,
so we force creation of a second one by creating a new thread first.

load/store helpers code path can't be triggered easily in user mode (no
softmmu), so we can't test it here.

Output of test-plugin-mem-access.c is the list of expected patterns in
plugin output. By reading stdout, we can compare to plugins output and
have a multiarch test.

Can be run with:
make -C build/tests/tcg/$ARCH-linux-user run-plugin-test-plugin-mem-access-with-libmem.so

Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/multiarch/test-plugin-mem-access.c | 177 +++++++++++++++++++
 tests/tcg/alpha/Makefile.target              |   3 +
 tests/tcg/multiarch/Makefile.target          |  11 ++
 tests/tcg/multiarch/check-plugin-output.sh   |  36 ++++
 tests/tcg/ppc64/Makefile.target              |   5 +
 5 files changed, 232 insertions(+)
 create mode 100644 tests/tcg/multiarch/test-plugin-mem-access.c
 create mode 100755 tests/tcg/multiarch/check-plugin-output.sh

diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/multiarch/test-plugin-mem-access.c
new file mode 100644
index 00000000000..057b9aac9f6
--- /dev/null
+++ b/tests/tcg/multiarch/test-plugin-mem-access.c
@@ -0,0 +1,177 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Check if we detect all memory accesses expected using plugin API.
+ * Used in conjunction with ./check-plugin-mem-access.sh check script.
+ * Output of this program is the list of patterns expected in plugin output.
+ *
+ * 8,16,32 load/store are tested for all arch.
+ * 64,128 load/store are tested for aarch64/x64.
+ * atomic operations (8,16,32,64) are tested for x64 only.
+ */
+
+#include <pthread.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#if defined(__x86_64__)
+#include <emmintrin.h>
+#elif defined(__aarch64__)
+#include <arm_neon.h>
+#endif /* __x86_64__ */
+
+static void *data;
+
+/* ,store_u8,.*,8,store,0xf1 */
+#define PRINT_EXPECTED(function, type, value, action)                 \
+do {                                                                  \
+    printf(",%s,.*,%d,%s,%s\n",                                       \
+           #function, (int) sizeof(type) * 8, action, value);         \
+}                                                                     \
+while (0)
+
+#define DEFINE_STORE(name, type, value)                  \
+                                                         \
+static void print_expected_store_##name(void)            \
+{                                                        \
+    PRINT_EXPECTED(store_##name, type, #value, "store"); \
+}                                                        \
+                                                         \
+static void store_##name(void)                           \
+{                                                        \
+    *((type *)data) = value;                             \
+    print_expected_store_##name();                       \
+}
+
+#define DEFINE_ATOMIC_OP(name, type, value)                    \
+                                                               \
+static void print_expected_atomic_op_##name(void)              \
+{                                                              \
+    PRINT_EXPECTED(atomic_op_##name, type, "0x0*42", "load");  \
+    PRINT_EXPECTED(atomic_op_##name, type, #value, "store");   \
+}                                                              \
+                                                               \
+static void atomic_op_##name(void)                             \
+{                                                              \
+    *((type *)data) = 0x42;                                    \
+    __sync_val_compare_and_swap((type *)data, 0x42, value);    \
+    print_expected_atomic_op_##name();                         \
+}
+
+#define DEFINE_LOAD(name, type, value)                  \
+                                                        \
+static void print_expected_load_##name(void)            \
+{                                                       \
+    PRINT_EXPECTED(load_##name, type, #value, "load");  \
+}                                                       \
+                                                        \
+static void load_##name(void)                           \
+{                                                       \
+                                                        \
+    /* volatile forces load to be generated. */         \
+    volatile type src = *((type *) data);               \
+    volatile type dest = src;                           \
+    (void)src, (void)dest;                              \
+    print_expected_load_##name();                       \
+}
+
+DEFINE_STORE(u8, uint8_t, 0xf1)
+DEFINE_LOAD(u8, uint8_t, 0xf1)
+DEFINE_STORE(u16, uint16_t, 0xf123)
+DEFINE_LOAD(u16, uint16_t, 0xf123)
+DEFINE_STORE(u32, uint32_t, 0xff112233)
+DEFINE_LOAD(u32, uint32_t, 0xff112233)
+
+#if defined(__x86_64__) || defined(__aarch64__)
+DEFINE_STORE(u64, uint64_t, 0xf123456789abcdef)
+DEFINE_LOAD(u64, uint64_t, 0xf123456789abcdef)
+
+static void print_expected_store_u128(void)
+{
+    PRINT_EXPECTED(store_u128, __int128,
+                   "0xf122334455667788f123456789abcdef", "store");
+}
+
+static void store_u128(void)
+{
+#ifdef __x86_64__
+    _mm_store_si128(data, _mm_set_epi32(0xf1223344, 0x55667788,
+                                        0xf1234567, 0x89abcdef));
+#else
+    const uint32_t init[4] = {0x89abcdef, 0xf1234567, 0x55667788, 0xf1223344};
+    uint32x4_t vec = vld1q_u32(init);
+    vst1q_u32(data, vec);
+#endif /* __x86_64__ */
+    print_expected_store_u128();
+}
+
+static void print_expected_load_u128(void)
+{
+    PRINT_EXPECTED(load_u128, __int128,
+                   "0xf122334455667788f123456789abcdef", "load");
+}
+
+static void load_u128(void)
+{
+#ifdef __x86_64__
+    __m128i var = _mm_load_si128(data);
+#else
+    uint32x4_t var = vld1q_u32(data);
+#endif
+    (void) var;
+    print_expected_load_u128();
+}
+#endif /* __x86_64__ || __aarch64__ */
+
+#if defined(__x86_64__)
+DEFINE_ATOMIC_OP(u8, uint8_t, 0xf1)
+DEFINE_ATOMIC_OP(u16, uint16_t, 0xf123)
+DEFINE_ATOMIC_OP(u32, uint32_t, 0xff112233)
+DEFINE_ATOMIC_OP(u64, uint64_t, 0xf123456789abcdef)
+#endif /* __x86_64__ */
+
+static void *f(void *p)
+{
+    return NULL;
+}
+
+int main(void)
+{
+    /*
+     * We force creation of a second thread to enable cpu flag CF_PARALLEL.
+     * This will generate atomic operations when needed.
+     */
+    pthread_t thread;
+    pthread_create(&thread, NULL, &f, NULL);
+    pthread_join(thread, NULL);
+
+    /* allocate storage up to 128 bits */
+    data = malloc(16);
+
+    store_u8();
+    load_u8();
+
+    store_u16();
+    load_u16();
+
+    store_u32();
+    load_u32();
+
+#if defined(__x86_64__) || defined(__aarch64__)
+    store_u64();
+    load_u64();
+
+    store_u128();
+    load_u128();
+#endif /* __x86_64__ || __aarch64__ */
+
+#if defined(__x86_64__)
+    atomic_op_u8();
+    atomic_op_u16();
+    atomic_op_u32();
+    atomic_op_u64();
+#endif /* __x86_64__ */
+
+    free(data);
+}
diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
index fdd7ddf64ec..36d8ed1eaea 100644
--- a/tests/tcg/alpha/Makefile.target
+++ b/tests/tcg/alpha/Makefile.target
@@ -12,4 +12,7 @@ test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
 test-cmov: test-cond.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
+# Force generation of byte read/write
+test-plugin-mem-access: CFLAGS+=-mbwx
+
 run-test-cmov: test-cmov
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 5e3391ec9d2..78b83d5575a 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -170,5 +170,16 @@ run-plugin-semiconsole-with-%:
 TESTS += semihosting semiconsole
 endif
 
+# Test plugin memory access instrumentation
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+	PLUGIN_ARGS=$(COMMA)print-accesses=true
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+	CHECK_PLUGIN_OUTPUT_COMMAND= \
+	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
+	$(QEMU) $<
+
+test-plugin-mem-access: CFLAGS+=-pthread -O0
+test-plugin-mem-access: LDFLAGS+=-pthread -O0
+
 # Update TESTS
 TESTS += $(MULTIARCH_TESTS)
diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/multiarch/check-plugin-output.sh
new file mode 100755
index 00000000000..80607f04b5d
--- /dev/null
+++ b/tests/tcg/multiarch/check-plugin-output.sh
@@ -0,0 +1,36 @@
+#!/usr/bin/env bash
+
+# This script runs a given executable using qemu, and compare its standard
+# output with an expected plugin output.
+# Each line of output is searched (as a regexp) in the expected plugin output.
+
+set -euo pipefail
+
+die()
+{
+    echo "$@" 1>&2
+    exit 1
+}
+
+check()
+{
+    file=$1
+    pattern=$2
+    grep "$pattern" "$file" > /dev/null || die "\"$pattern\" not found in $file"
+}
+
+[ $# -eq 3 ] || die "usage: qemu_bin exe plugin_out_file"
+
+qemu_bin=$1; shift
+exe=$1;shift
+plugin_out=$1; shift
+
+expected()
+{
+    $qemu_bin $exe ||
+        die "running $exe failed"
+}
+
+expected | while read line; do
+    check "$plugin_out" "$line"
+done
diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
index 509a20be2b0..1940886c737 100644
--- a/tests/tcg/ppc64/Makefile.target
+++ b/tests/tcg/ppc64/Makefile.target
@@ -55,4 +55,9 @@ PPC64_TESTS += signal_save_restore_xer
 PPC64_TESTS += xxspltw
 PPC64_TESTS += test-aes
 
+# ppc64 ABI uses function descriptors, and thus, QEMU can't find symbol for a
+# given instruction. Thus, we don't check output of mem-access plugin.
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+ CHECK_PLUGIN_OUTPUT_COMMAND=
+
 TESTS += $(PPC64_TESTS)
-- 
2.39.2


