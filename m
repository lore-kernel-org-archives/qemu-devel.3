Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8A5C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpHr-0001Nk-Dw; Tue, 13 Feb 2024 04:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHp-0001NC-PB
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:09 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHn-0000G6-Pi
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:09 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33b728b6981so1527650f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817266; x=1708422066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WWaJPsclEFPyc9s7y8yPMs7GjvBirSud+8vEqilY/w=;
 b=KOogdEeUZOJIwP+bYB+vV47xy2h4msVqLG6TT84jJKBt9v3JSVD0dxHTVr+i+hZePU
 1n/AzZ4m+QaK4FNpyKADnU7JzrMOUtEAAihg1dVL7K5aldyQHVLHffhRrciS5n4OQH85
 GS2HIVTLs2kOycUpymZJwCC+5J1TMlOm89n0BwhEWj4SHFgBTYxXLm6c7RsR92hplcYA
 lDw2gqdUhXAUdfHnWpiS3qEOe83iEtKKzgm8NIv7N5kZZkHlT6c9egRny6+1YkmxuIvU
 qpBnCRMwoDRs/X7f4+CD3tecX564HiN6b99uDnaRZ/Uw2h9o9z57dzKJVjndXI5XGTza
 APbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817266; x=1708422066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WWaJPsclEFPyc9s7y8yPMs7GjvBirSud+8vEqilY/w=;
 b=X4Ob64SAjbsJRJD674N6NxIfeW7blMTJp6fPKIaIBrYLr+lerUVvuSO0Mayg+84Ia4
 9EfzQoYneGpQ+gef4rL85PHxsZBG/CjxvHRwAatfEkn5TauMHqyktfc4cgNdsOjwTdAP
 Mv1s78I33eny1j1yi/GKp7lncYu28coQjufn//VUDd/GShLA66Baapu+4YVBzch2ziXQ
 3y7v/+vB0MNtkmZXoI+ItLUmP6eIoE8gFAdzrkcvWTG4exkSQYYDBg57sdWFx2wCTTTD
 6mksC+s8d8qc+lfx7Uts35EtG0bk7BOLsKElKQni4WhGoCmmI0EDK2KOpvXaXYq8A/SR
 QUVQ==
X-Gm-Message-State: AOJu0Ywbu1l7Ov1A5nNhH63Wq9nfdlPwpqRwhT1Y8NcJFQbRzUADJYJW
 9igTUrSHcwJ2HTVU/m9YFlmiPk5v3up67u9JD/iMsTpqzHUsTNSrkI5tQXhqdg4Ol/bUk/hMGwh
 D
X-Google-Smtp-Source: AGHT+IHZwt1b03aOzst77/sSb5iFc/YVDJomLcMu3xhXIdiVJGiFEPTlivg8oN7r8Dv5LMuAytOMCw==
X-Received: by 2002:adf:fccc:0:b0:33a:e51e:ddaf with SMTP id
 f12-20020adffccc000000b0033ae51eddafmr7467153wrs.27.1707817266248; 
 Tue, 13 Feb 2024 01:41:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW5F9RAHwFks1TNLUu2O1DvHEh+dKW816kvdwSg612CexAPgGV4FX5mgBFahrUQI1d/fezR4cMj1Fnd03WZdp+zAzKfvFQztW7VT16o8iWZKnoV8Ap497UeQ18TpVMhZ1cnxv1lN66LTooTS9ADbonCt+8rbYM3oDYueBEHdxtzHvlq9Czid8sVZmK7X4xB06boITF7qzIntHogBurTpuez9xID2Ylfpf9Oe281p+bcrpQ/UbOvIDF3JFCVuhUayEj0q6rpSjLzZT/d585lk0Z+5lKop1w/HvSVuDRil0CyP4WlqTvGiINKEWILP856NlEJaIf/Suk9upUuTZnHZcS6gRrZaA==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:41:06 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 10/18] tests/plugin: add test plugin for inline operations
Date: Tue, 13 Feb 2024 13:40:00 +0400
Message-ID: <20240213094009.150349-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For now, it simply performs instruction, bb and mem count, and ensure
that inline vs callback versions have the same result. Later, we'll
extend it when new inline operations are added.

Use existing plugins to test everything works is a bit cumbersome, as
different events are treated in different plugins. Thus, this new one.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/inline.c    | 186 +++++++++++++++++++++++++++++++++++++++
 tests/plugin/meson.build |   2 +-
 2 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 tests/plugin/inline.c

diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
new file mode 100644
index 00000000000..0163e9b51c5
--- /dev/null
+++ b/tests/plugin/inline.c
@@ -0,0 +1,186 @@
+/*
+ * Copyright (C) 2023, Pierrick Bouvier <pierrick.bouvier@linaro.org>
+ *
+ * Demonstrates and tests usage of inline ops.
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
+#include <glib.h>
+#include <stdint.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+typedef struct {
+    uint64_t count_tb;
+    uint64_t count_tb_inline;
+    uint64_t count_insn;
+    uint64_t count_insn_inline;
+    uint64_t count_mem;
+    uint64_t count_mem_inline;
+} CPUCount;
+
+static struct qemu_plugin_scoreboard *counts;
+static qemu_plugin_u64 count_tb;
+static qemu_plugin_u64 count_tb_inline;
+static qemu_plugin_u64 count_insn;
+static qemu_plugin_u64 count_insn_inline;
+static qemu_plugin_u64 count_mem;
+static qemu_plugin_u64 count_mem_inline;
+
+static uint64_t global_count_tb;
+static uint64_t global_count_insn;
+static uint64_t global_count_mem;
+static unsigned int max_cpu_index;
+static GMutex tb_lock;
+static GMutex insn_lock;
+static GMutex mem_lock;
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static void stats_insn(void)
+{
+    const uint64_t expected = global_count_insn;
+    const uint64_t per_vcpu = qemu_plugin_u64_sum(count_insn);
+    const uint64_t inl_per_vcpu =
+        qemu_plugin_u64_sum(count_insn_inline);
+    printf("insn: %" PRIu64 "\n", expected);
+    printf("insn: %" PRIu64 " (per vcpu)\n", per_vcpu);
+    printf("insn: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    g_assert(expected > 0);
+    g_assert(per_vcpu == expected);
+    g_assert(inl_per_vcpu == expected);
+}
+
+static void stats_tb(void)
+{
+    const uint64_t expected = global_count_tb;
+    const uint64_t per_vcpu = qemu_plugin_u64_sum(count_tb);
+    const uint64_t inl_per_vcpu =
+        qemu_plugin_u64_sum(count_tb_inline);
+    printf("tb: %" PRIu64 "\n", expected);
+    printf("tb: %" PRIu64 " (per vcpu)\n", per_vcpu);
+    printf("tb: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    g_assert(expected > 0);
+    g_assert(per_vcpu == expected);
+    g_assert(inl_per_vcpu == expected);
+}
+
+static void stats_mem(void)
+{
+    const uint64_t expected = global_count_mem;
+    const uint64_t per_vcpu = qemu_plugin_u64_sum(count_mem);
+    const uint64_t inl_per_vcpu =
+        qemu_plugin_u64_sum(count_mem_inline);
+    printf("mem: %" PRIu64 "\n", expected);
+    printf("mem: %" PRIu64 " (per vcpu)\n", per_vcpu);
+    printf("mem: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    g_assert(expected > 0);
+    g_assert(per_vcpu == expected);
+    g_assert(inl_per_vcpu == expected);
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *udata)
+{
+    const unsigned int num_cpus = qemu_plugin_num_vcpus();
+    g_assert(num_cpus == max_cpu_index + 1);
+
+    for (int i = 0; i < num_cpus ; ++i) {
+        const uint64_t tb = qemu_plugin_u64_get(count_tb, i);
+        const uint64_t tb_inline = qemu_plugin_u64_get(count_tb_inline, i);
+        const uint64_t insn = qemu_plugin_u64_get(count_insn, i);
+        const uint64_t insn_inline = qemu_plugin_u64_get(count_insn_inline, i);
+        const uint64_t mem = qemu_plugin_u64_get(count_mem, i);
+        const uint64_t mem_inline = qemu_plugin_u64_get(count_mem_inline, i);
+        printf("cpu %d: tb (%" PRIu64 ", %" PRIu64 ") | "
+               "insn (%" PRIu64 ", %" PRIu64 ") | "
+               "mem (%" PRIu64 ", %" PRIu64 ")"
+               "\n",
+               i, tb, tb_inline, insn, insn_inline, mem, mem_inline);
+        g_assert(tb == tb_inline);
+        g_assert(insn == insn_inline);
+        g_assert(mem == mem_inline);
+    }
+
+    stats_tb();
+    stats_insn();
+    stats_mem();
+
+    qemu_plugin_scoreboard_free(counts);
+}
+
+static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
+{
+    qemu_plugin_u64_add(count_tb, cpu_index, 1);
+    g_mutex_lock(&tb_lock);
+    max_cpu_index = MAX(max_cpu_index, cpu_index);
+    global_count_tb++;
+    g_mutex_unlock(&tb_lock);
+}
+
+static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
+{
+    qemu_plugin_u64_add(count_insn, cpu_index, 1);
+    g_mutex_lock(&insn_lock);
+    global_count_insn++;
+    g_mutex_unlock(&insn_lock);
+}
+
+static void vcpu_mem_access(unsigned int cpu_index,
+                            qemu_plugin_meminfo_t info,
+                            uint64_t vaddr,
+                            void *userdata)
+{
+    qemu_plugin_u64_add(count_mem, cpu_index, 1);
+    g_mutex_lock(&mem_lock);
+    global_count_mem++;
+    g_mutex_unlock(&mem_lock);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    qemu_plugin_register_vcpu_tb_exec_cb(
+        tb, vcpu_tb_exec, QEMU_PLUGIN_CB_NO_REGS, 0);
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_ADD_U64, count_tb_inline, 1);
+
+    for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
+        qemu_plugin_register_vcpu_insn_exec_cb(
+            insn, vcpu_insn_exec, QEMU_PLUGIN_CB_NO_REGS, 0);
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+            insn, QEMU_PLUGIN_INLINE_ADD_U64, count_insn_inline, 1);
+        qemu_plugin_register_vcpu_mem_cb(insn, &vcpu_mem_access,
+                                         QEMU_PLUGIN_CB_NO_REGS,
+                                         QEMU_PLUGIN_MEM_RW, 0);
+        qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+            insn, QEMU_PLUGIN_MEM_RW,
+            QEMU_PLUGIN_INLINE_ADD_U64,
+            count_mem_inline, 1);
+    }
+}
+
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
+    count_tb = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, count_tb);
+    count_insn = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, count_insn);
+    count_mem = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, count_mem);
+    count_tb_inline = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, count_tb_inline);
+    count_insn_inline = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, count_insn_inline);
+    count_mem_inline = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, count_mem_inline);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
index e18183aaeda..9eece5bab51 100644
--- a/tests/plugin/meson.build
+++ b/tests/plugin/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'insn', 'mem', 'syscall']
+  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'syscall']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../contrib/plugins/win32_linker.c',
                         include_directories: '../../include/qemu',
-- 
2.43.0


