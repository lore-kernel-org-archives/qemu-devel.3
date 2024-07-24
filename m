Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6DBC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 19:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWhxY-0002Q7-BI; Wed, 24 Jul 2024 15:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWhxT-0002Ms-Em
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:47:32 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWhxP-0006Fv-Pd
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:47:31 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d1cbbeeaeso146255b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721850444; x=1722455244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jujw3dcwSHYk44u92QIn+K4fYEBnVKCK000Riefc95g=;
 b=jGst0dpygxwIhKSRkM8OYGImXkUvj/tWocM8eK67VNt21SoscV56FY+yt2JKQ2B6+F
 tJYh6kVX8+e8SYE/ugALGRekzI97MiRwl8ZwmGrgSLPsTrcgl9xPpIYqBnbgRK99oIso
 3OBlMyPH8pSmhfjZNFrjrUUul+FJIzTyQil2NBkNvbxNf0JVJzVMuW8t/4kOA6S3US+/
 0c9hC/I8TYjw03al4GXtBsa4T5AsD8WUTCFgWBvz0ZmySi6WDfNhTIdef6IVP9d7xYjX
 cpkAZzRYRo8mRUHZnGvrkcd6xuBSJ1L1NxjcnCYkybV2DurVeB7KdnUv6nNLcMsVHGgj
 MeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721850444; x=1722455244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jujw3dcwSHYk44u92QIn+K4fYEBnVKCK000Riefc95g=;
 b=EpgvcdHBc99FRqQP50sGt2EaqVthF0zOciA/Ok6DYvxBmk7uMwIjEi+8KrcPNdLw5P
 dqIpSH7Ywgb7Jlq8JHNQ7Q11H7KxSKQPlUOcovHf3hzH1EANMNa9Qhhys4O1KbpXBQmm
 /q1NoKjqZTvQaxaSHQ8pILXRxPdI0z3AL57K8aYZYjI2mWJmXSGlkyZmV+KYeWFGS5gq
 4dfHXEOQtsT/nFw7nHIudwiz+SsiaP3TM1/wBW89Rji5u45JFmosFWE74RL9R+KBiutg
 3iux9WgO5k1WJpkokO04ICNz4RrHgAnvnuoWsGXYt76lW1+5b6VFuLTJKRLtSD3T5Ibj
 WJ0A==
X-Gm-Message-State: AOJu0Yy7OAIJDBDq7UIKKWh3XZHQYlTcFld+FZxqAZfVtpxb9lltgLEP
 NbcaRnpSOXi43lfYyDB1zv6hvU6BKoNAUO6efT3t4Q/gHrUKDxJaLKWIhVjhFM3Npt1jkDfisyg
 eTig=
X-Google-Smtp-Source: AGHT+IH2DUsc1o6nDPsMqReVPg8x/hjacKsYfY50s55gcAcck6DzIqA614bdH0+y0u02t+wkzZJeCQ==
X-Received: by 2002:a05:6a00:18a2:b0:70b:20d9:3c2a with SMTP id
 d2e1a72fcca58-70eaa947c02mr626992b3a.28.1721850444310; 
 Wed, 24 Jul 2024 12:47:24 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d19c52a62sm6339116b3a.124.2024.07.24.12.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 12:47:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v7 6/6] tests/tcg/multiarch: add test for plugin memory access
Date: Wed, 24 Jul 2024 12:47:08 -0700
Message-Id: <20240724194708.1843704-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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
 tests/tcg/multiarch/test-plugin-mem-access.c  | 175 ++++++++++++++++++
 tests/tcg/multiarch/Makefile.target           |   7 +
 .../tcg/multiarch/check-plugin-mem-access.sh  |  30 +++
 3 files changed, 212 insertions(+)
 create mode 100644 tests/tcg/multiarch/test-plugin-mem-access.c
 create mode 100755 tests/tcg/multiarch/check-plugin-mem-access.sh

diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/multiarch/test-plugin-mem-access.c
new file mode 100644
index 00000000000..09d1fa22e35
--- /dev/null
+++ b/tests/tcg/multiarch/test-plugin-mem-access.c
@@ -0,0 +1,175 @@
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
+    type src = *((type *) data);                        \
+    type dest = src;                                    \
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
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 5e3391ec9d2..d90cbd3e521 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -170,5 +170,12 @@ run-plugin-semiconsole-with-%:
 TESTS += semihosting semiconsole
 endif
 
+# Test plugin memory access instrumentation
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+	PLUGIN_ARGS=$(COMMA)print-accesses=true
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+	CHECK_PLUGIN_OUTPUT_COMMAND= \
+	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-mem-access.sh
+
 # Update TESTS
 TESTS += $(MULTIARCH_TESTS)
diff --git a/tests/tcg/multiarch/check-plugin-mem-access.sh b/tests/tcg/multiarch/check-plugin-mem-access.sh
new file mode 100755
index 00000000000..909606943bb
--- /dev/null
+++ b/tests/tcg/multiarch/check-plugin-mem-access.sh
@@ -0,0 +1,30 @@
+#!/usr/bin/env bash
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
+[ $# -eq 1 ] || die "usage: plugin_out_file"
+
+plugin_out=$1
+
+expected()
+{
+    ./test-plugin-mem-access ||
+        die "running test-plugin-mem-access executable failed"
+}
+
+expected | while read line; do
+    check "$plugin_out" "$line"
+done
-- 
2.39.2


