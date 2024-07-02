Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F165C31D97
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOiVE-0005OR-Jf; Tue, 02 Jul 2024 14:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiVC-0005Nr-ED
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:18 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiV8-0008Jp-MR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:16 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7182a634815so2779140a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945913; x=1720550713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niG05aeHHNe9KFZ6CFq0rHqwgfpKzMy35BwCLWmdTuk=;
 b=jXuZzt2nfs4Q+zsJ4JF7jTo4szSfo1/ceH+LA3rHRnfCMBYJik251Ceh6egVfntjkR
 5JtfnkwjAIh+d7+YBUR97vgaE+DqchanAWrGf5ZQDtHCe5RI/Wzn42ZRUltf/4GrWOE6
 oCWqNaYpuac6gMOWpBAqwn7Tv9guaqiBHeTr4MB4SSHBtTzMGYfb5QGmI2CcMA4aHoNA
 HDvWMzW4OLlH3UvqHDkNgpRGEKhVK2hKj9s/Ma7Fonzg+4x1IzhE1j6DPbTkdRr5jmHv
 9lNcazTtcKGYwWklSE1w7pWOE9aKjJBv0ixBzUeNnsQiqk7RC8POn7FVEzuUDqJpu0iD
 5+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945913; x=1720550713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=niG05aeHHNe9KFZ6CFq0rHqwgfpKzMy35BwCLWmdTuk=;
 b=Ut9f+67m1vBr9xcZD1wBYFJdsbsPGGPaqJw4NEPf+bzcHtXo5cMFfce8vQmsa4DYOy
 E6iyb0Wv+q9BUZIgGauZYSykJ8DcXclDl/TROyTTPS5GzZBkela49nZqOOjoVfhmrULB
 EDWDGYAILjyskntsWEn3fT1anmMf/K4H5jkLreAd3Y0le0JXeYJycPjFLDG8++4PvCLX
 OxifKiQBP+ogyQxtoMC8TgrxFfxKb6TVmt3kGzLoeSrDqz7Cb8GgAvqvsg0cHxmj8z5x
 c/LOYUKGyolwcUHX10JGqawnCFS7TXueV8hxfIr2iPz0U0hUebD2iSvQYuOYb2h6zMqu
 FQJg==
X-Gm-Message-State: AOJu0YyoFlz1FhWDTlBJoTGOTQOQhMjTRiCNaWDRF7RL3LBBgWXNEI+b
 9oQy53avediydFl3wfmMj8HNrlZ1ZiCJe+/gv1MuRoFFJv4d7f98C+BmdiyoqC+TJm8+ktoRTRn
 q
X-Google-Smtp-Source: AGHT+IHoww3DfwrgWxowo2PMFDH642Wsrg2WBJcNAprtRj93FStxEG5a3RHDgukaMZphLJbj2bV/fQ==
X-Received: by 2002:a05:6a20:9145:b0:1bd:2520:1fa5 with SMTP id
 adf61e73a8af0-1bef60e3effmr9701242637.4.1719945912858; 
 Tue, 02 Jul 2024 11:45:12 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e8196sm9257394a91.49.2024.07.02.11.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:45:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 7/7] tests/tcg/x86_64: add test for plugin memory access
Date: Tue,  2 Jul 2024 11:44:48 -0700
Message-Id: <20240702184448.551705-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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
index 00000000000..92008e25a93
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
+,store_u8,.*,8,store,0xf1
+,atomic_op_u8,.*,8,load,0x42
+,atomic_op_u8,.*,8,store,0xf1
+,load_u8,.*,8,load,0xf1
+,store_u16,.*,16,store,0xf123
+,atomic_op_u16,.*,16,load,0x42
+,atomic_op_u16,.*,16,store,0xf123
+,load_u16,.*,16,load,0xf123
+,store_u32,.*,32,store,0xff112233
+,atomic_op_u32,.*,32,load,0x42
+,atomic_op_u32,.*,32,store,0xff112233
+,load_u32,.*,32,load,0xff112233
+,store_u64,.*,64,store,0xf123456789abcdef
+,atomic_op_u64,.*,64,load,0x42
+,atomic_op_u64,.*,64,store,0xf123456789abcdef
+,load_u64,.*,64,load,0xf123456789abcdef
+,store_u128,.*,128,store,0xf122334455667788f123456789abcdef
+,load_u128,.*,128,load,0xf122334455667788f123456789abcdef
+EOF
+}
+
+expected | while read line; do
+    check "$plugin_out" "$line"
+done
-- 
2.39.2


