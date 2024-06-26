Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6F5C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcE1-0007a3-Bt; Wed, 26 Jun 2024 19:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcDQ-0007Si-G5
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:38:17 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcDO-0007Mb-Ix
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:38:16 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7066463c841so3687453b3a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719445091; x=1720049891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uC1drunn1nWD7FST8lIEBPaAEySNItr5VUia6HG7tQ0=;
 b=dUJABsfFOe4Lzd0MvfhrM1foZAI/KK1sa+yL6BOY0pFDrpV4072il+fva3MIfgizKb
 iqBIrx+lbMXV0nCr2flbfv95uoHY9JO31A5glo1vNzcC+PW5PzGipjjz8xT3f1SbXuLA
 t8Jrap5ihwKDOSLCFvHbVxl52o5Wtf8qhsMJWOcMQB4F2XxZQa2P3f1RDQNJY1hisNd3
 S77Gko0vXJeH8EFa7t27xnDzffBY+yyet+gIUjEUqqhWw3Y/iWaAr3DnlKJhO6OWvweu
 S9E0hUjbFQS5nRMOfg1x+lvNrqWm6wcZsdroowMa8J4OHd+IdeLce2vTzk8XwKXebI9I
 oytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719445091; x=1720049891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uC1drunn1nWD7FST8lIEBPaAEySNItr5VUia6HG7tQ0=;
 b=tNtr6V/CcWf1GGT3NYztcZ/6V3RHD8zDLJJnrSQXXgwxL/nZBujEbZiqIuX9n2lvJb
 G20cvlAO6Jd6lcCAskY3Oh5UPTHeBk0XVB5ViUqeljgYfk/BqbqJsWOV/JXg86MguuIL
 /CAgVLtW7OUpig3eAgpTGoaaaOHWsDeexCGwT99gY4Y11oEAFebLm9yhflvwDZcNnmLZ
 CZFUwvAD5BlKwZ84CTzrkKMQLG70bhV9JJnOMAJlzhbPIYCC5k3WMTYs3z2RPB0uWfQb
 AXYzEzqiRYD3KD1JbGp16bMoXfgtVNKln3JWIdZyY9L5sXaz2CaJq1rZWrOUQqNY1st6
 b5qw==
X-Gm-Message-State: AOJu0Yy8ON+0s/fP/S6B2cGoF5uOJmTHnr5sld0BOOLLDkSL+J6Sv7Xk
 hhpE2Hs/F/5JrHhacZxMn8lINkRH9kI1jo4HZlXMKG6pcC/ngTm1Xtl7vNb77Zi9QGuDuUS1Aot
 n3B8=
X-Google-Smtp-Source: AGHT+IFuZVx4vYRpi3VH5x3kqpaG68tP7p0qMpBgspeRU5hdrL4mGfnuHycoP2HXvXNypSftctU7Vg==
X-Received: by 2002:a05:6a20:a921:b0:1bd:27c6:ee5d with SMTP id
 adf61e73a8af0-1bd27c6ee8fmr4575553637.31.1719445091555; 
 Wed, 26 Jun 2024 16:38:11 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac8df624sm563055ad.29.2024.06.26.16.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:38:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 7/7] tests/tcg/x86_64: add test for plugin memory access
Date: Wed, 26 Jun 2024 16:37:57 -0700
Message-Id: <20240626233757.375083-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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
For sizes 8, 16, 32, 64 and 128, we generate a load/store operation.
For size 8 -> 64, we generate an atomic __sync_val_compare_and_swap too.
For 128bits memory access, we rely on SSE2 instructions.

By default, atomic accesses are non atomic if a single cpu is running,
so we force creation of a second one by creating a new thread first.

load/store helpers code path can't be triggered easily in user mode (no
softmmu), so we can't test it here.

Can be run with:
make -C build/tests/tcg/x86_64-linux-user run-plugin-test-plugin-mem-access-with-libmem.so

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/x86_64/test-plugin-mem-access.c   | 89 +++++++++++++++++++++
 tests/tcg/x86_64/Makefile.target            |  7 ++
 tests/tcg/x86_64/check-plugin-mem-access.sh | 48 +++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 tests/tcg/x86_64/test-plugin-mem-access.c
 create mode 100755 tests/tcg/x86_64/check-plugin-mem-access.sh

diff --git a/tests/tcg/x86_64/test-plugin-mem-access.c b/tests/tcg/x86_64/test-plugin-mem-access.c
new file mode 100644
index 00000000000..7fdd6a55829
--- /dev/null
+++ b/tests/tcg/x86_64/test-plugin-mem-access.c
@@ -0,0 +1,89 @@
+#include <emmintrin.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+static void *data;
+
+#define DEFINE_STORE(name, type, value) \
+static void store_##name(void)          \
+{                                       \
+    *((type *)data) = value;            \
+}
+
+#define DEFINE_ATOMIC_OP(name, type, value)                 \
+static void atomic_op_##name(void)                          \
+{                                                           \
+    *((type *)data) = 0x42;                                 \
+    __sync_val_compare_and_swap((type *)data, 0x42, value); \
+}
+
+#define DEFINE_LOAD(name, type)                         \
+static void load_##name(void)                           \
+{                                                       \
+    register type var asm("eax") = *((type *) data);    \
+    (void)var;                                          \
+}
+
+DEFINE_STORE(u8, uint8_t, 0xf1)
+DEFINE_ATOMIC_OP(u8, uint8_t, 0xf1)
+DEFINE_LOAD(u8, uint8_t)
+DEFINE_STORE(u16, uint16_t, 0xf123)
+DEFINE_ATOMIC_OP(u16, uint16_t, 0xf123)
+DEFINE_LOAD(u16, uint16_t)
+DEFINE_STORE(u32, uint32_t, 0xff112233)
+DEFINE_ATOMIC_OP(u32, uint32_t, 0xff112233)
+DEFINE_LOAD(u32, uint32_t)
+DEFINE_STORE(u64, uint64_t, 0xf123456789abcdef)
+DEFINE_ATOMIC_OP(u64, uint64_t, 0xf123456789abcdef)
+DEFINE_LOAD(u64, uint64_t)
+
+static void store_u128(void)
+{
+    _mm_store_si128(data, _mm_set_epi32(0xf1223344, 0x55667788,
+                                        0xf1234567, 0x89abcdef));
+}
+
+static void load_u128(void)
+{
+    __m128i var = _mm_load_si128(data);
+    (void)var;
+}
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
+    data = malloc(sizeof(__m128i));
+    atomic_op_u8();
+    store_u8();
+    load_u8();
+
+    atomic_op_u16();
+    store_u16();
+    load_u16();
+
+    atomic_op_u32();
+    store_u32();
+    load_u32();
+
+    atomic_op_u64();
+    store_u64();
+    load_u64();
+
+    store_u128();
+    load_u128();
+
+    free(data);
+}
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index 5fedf221174..5f7015fd8b4 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -14,6 +14,7 @@ X86_64_TESTS += noexec
 X86_64_TESTS += cmpxchg
 X86_64_TESTS += adox
 X86_64_TESTS += test-1648
+PLUGINS_TESTS += test-plugin-mem-access
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
@@ -24,6 +25,12 @@ adox: CFLAGS=-O2
 run-test-i386-ssse3: QEMU_OPTS += -cpu max
 run-plugin-test-i386-ssse3-%: QEMU_OPTS += -cpu max
 
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+	PLUGIN_ARGS=$(COMMA)print-accesses=true
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+	CHECK_PLUGIN_OUTPUT_COMMAND= \
+	$(SRC_PATH)/tests/tcg/x86_64/check-plugin-mem-access.sh
+
 test-x86_64: LDFLAGS+=-lm -lc
 test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/x86_64/check-plugin-mem-access.sh b/tests/tcg/x86_64/check-plugin-mem-access.sh
new file mode 100755
index 00000000000..3884976af2d
--- /dev/null
+++ b/tests/tcg/x86_64/check-plugin-mem-access.sh
@@ -0,0 +1,48 @@
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
+    cat << EOF
+access: 0xf1,8,store,store_u8
+access: 0x42,8,load,atomic_op_u8
+access: 0xf1,8,store,atomic_op_u8
+access: 0xf1,8,load,load_u8
+access: 0xf123,16,store,store_u16
+access: 0x42,16,load,atomic_op_u16
+access: 0xf123,16,store,atomic_op_u16
+access: 0xf123,16,load,load_u16
+access: 0xff112233,32,store,store_u32
+access: 0x42,32,load,atomic_op_u32
+access: 0xff112233,32,store,atomic_op_u32
+access: 0xff112233,32,load,load_u32
+access: 0xf123456789abcdef,64,store,store_u64
+access: 0x42,64,load,atomic_op_u64
+access: 0xf123456789abcdef,64,store,atomic_op_u64
+access: 0xf123456789abcdef,64,load,load_u64
+access: 0xf122334455667788f123456789abcdef,128,store,store_u128
+access: 0xf122334455667788f123456789abcdef,128,load,load_u128
+EOF
+}
+
+expected | while read line; do
+    check "$plugin_out" "$line"
+done
-- 
2.39.2


