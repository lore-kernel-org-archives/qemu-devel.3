Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE883C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 05:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZNI-0004lc-8t; Thu, 29 Feb 2024 00:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfZNF-0004ka-SJ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:54:29 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfZNC-00079l-NU
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:54:28 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412b5a99204so3751465e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 21:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709186065; x=1709790865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l559uHp/UBP4UYf3madGaU0rRN2G+GA/+DLgPhhC4CI=;
 b=sK7UVLd+fu/bmTHf6GvO+ypdJ36lJwY7UwA3KK6tzrN6Qc5ykr+8iejbz2CBtdvkXP
 iEnf6p+tcQHwF9q120KnLmm5ycE8pS89gZTSdC+EoqCwhioS4iuKvK2SoYY6fK1grb5D
 UmDpDvJNETF8biusYgH+mSieByZCkOTFG/p7EqrZd6ux+gqDC8oAMSmtS9NQK6qMPNjK
 9lwR+/SH5U+FiTt6qz8wneYFlD3snseoIHf5Y/KxwLxcJZrSNgV2OR5xYRwEryUa9fOP
 J9o+e2u+GH60LcS28uASvfGz8OlqVsdrJEq3myqohro3msaBfryY33bi56PW8rE5oxXj
 RQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709186065; x=1709790865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l559uHp/UBP4UYf3madGaU0rRN2G+GA/+DLgPhhC4CI=;
 b=DYXBuorxnMTSE/5TG62yrzZv5v5ozoH+P2U5MJeX0BI6Y++yMAyz35ZrQpmp7fGiq9
 1BEHyEQf8C1pjdU/HQ/X+lzprP8Ok6ySIZmBM60mms6icl+OazuthMus+Vx6PfJqfaqD
 OTcbwfkCqTluwYLpQAK/BgDC5iICTUyszYbY3AOFLzDdoRBUrLY8mBlvMU/BM2FVMchx
 OXhNHMmSb30sgXhs3+cJSEbfQlfG60aWwgTPrwHfqrmBaG2H4aehPsQZkjQLG2XbYVL6
 GMDX+lbqSktD3XreQF3BExLlBTx/tr7mTm7AUI2pACw0l3O223z88Vg7TNHsFIzmAIPl
 +TFg==
X-Gm-Message-State: AOJu0Yze3WLmJS3j6PeyUXQ1NfjbGnepESchfVJNH2RQku7uy6ny8YyQ
 UYR6Q3z4iJtE3BVsYINDzNA0x85KoU24ZOYJ36/ho19334YhDp0jC6MuYo6oewpGN3qOKds/QeQ
 UJmY=
X-Google-Smtp-Source: AGHT+IFN8sW7KdhLUn/SVM5y+xOk2cQNg+QOVbYfTMKnQMb/SybRa7ndUAlTk0Cknv+mNLmo5gIw+w==
X-Received: by 2002:adf:ef4a:0:b0:33d:87ed:626 with SMTP id
 c10-20020adfef4a000000b0033d87ed0626mr595073wrp.58.1709186064876; 
 Wed, 28 Feb 2024 21:54:24 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 ck12-20020a5d5e8c000000b0033d2541b3e1sm721589wrb.72.2024.02.28.21.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 21:54:24 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 5/5] tests/plugin/inline: add test for condition callback
Date: Thu, 29 Feb 2024 09:53:59 +0400
Message-ID: <20240229055359.972151-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
References: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32b.google.com
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

Count number of tb and insn executed using a conditional callback. We
ensure the callback has been called expected number of time (per vcpu).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/inline.c | 87 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
index 30acc7a1838..8720ecc358a 100644
--- a/tests/plugin/inline.c
+++ b/tests/plugin/inline.c
@@ -20,8 +20,14 @@ typedef struct {
     uint64_t count_insn_inline;
     uint64_t count_mem;
     uint64_t count_mem_inline;
+    uint64_t tb_cond_num_trigger;
+    uint64_t tb_cond_track_count;
+    uint64_t insn_cond_num_trigger;
+    uint64_t insn_cond_track_count;
 } CPUCount;
 
+static const uint64_t cond_trigger_limit = 100;
+
 typedef struct {
     uint64_t data_insn;
     uint64_t data_tb;
@@ -35,6 +41,10 @@ static qemu_plugin_u64 count_insn;
 static qemu_plugin_u64 count_insn_inline;
 static qemu_plugin_u64 count_mem;
 static qemu_plugin_u64 count_mem_inline;
+static qemu_plugin_u64 tb_cond_num_trigger;
+static qemu_plugin_u64 tb_cond_track_count;
+static qemu_plugin_u64 insn_cond_num_trigger;
+static qemu_plugin_u64 insn_cond_track_count;
 static struct qemu_plugin_scoreboard *data;
 static qemu_plugin_u64 data_insn;
 static qemu_plugin_u64 data_tb;
@@ -56,12 +66,19 @@ static void stats_insn(void)
     const uint64_t per_vcpu = qemu_plugin_u64_sum(count_insn);
     const uint64_t inl_per_vcpu =
         qemu_plugin_u64_sum(count_insn_inline);
+    const uint64_t cond_num_trigger =
+        qemu_plugin_u64_sum(insn_cond_num_trigger);
+    const uint64_t cond_track_left = qemu_plugin_u64_sum(insn_cond_track_count);
+    const uint64_t conditional =
+        cond_num_trigger * cond_trigger_limit + cond_track_left;
     printf("insn: %" PRIu64 "\n", expected);
     printf("insn: %" PRIu64 " (per vcpu)\n", per_vcpu);
     printf("insn: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    printf("insn: %" PRIu64 " (cond cb)\n", conditional);
     g_assert(expected > 0);
     g_assert(per_vcpu == expected);
     g_assert(inl_per_vcpu == expected);
+    g_assert(conditional == expected);
 }
 
 static void stats_tb(void)
@@ -70,12 +87,18 @@ static void stats_tb(void)
     const uint64_t per_vcpu = qemu_plugin_u64_sum(count_tb);
     const uint64_t inl_per_vcpu =
         qemu_plugin_u64_sum(count_tb_inline);
+    const uint64_t cond_num_trigger = qemu_plugin_u64_sum(tb_cond_num_trigger);
+    const uint64_t cond_track_left = qemu_plugin_u64_sum(tb_cond_track_count);
+    const uint64_t conditional =
+        cond_num_trigger * cond_trigger_limit + cond_track_left;
     printf("tb: %" PRIu64 "\n", expected);
     printf("tb: %" PRIu64 " (per vcpu)\n", per_vcpu);
     printf("tb: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    printf("tb: %" PRIu64 " (conditional cb)\n", conditional);
     g_assert(expected > 0);
     g_assert(per_vcpu == expected);
     g_assert(inl_per_vcpu == expected);
+    g_assert(conditional == expected);
 }
 
 static void stats_mem(void)
@@ -104,14 +127,35 @@ static void plugin_exit(qemu_plugin_id_t id, void *udata)
         const uint64_t insn_inline = qemu_plugin_u64_get(count_insn_inline, i);
         const uint64_t mem = qemu_plugin_u64_get(count_mem, i);
         const uint64_t mem_inline = qemu_plugin_u64_get(count_mem_inline, i);
-        printf("cpu %d: tb (%" PRIu64 ", %" PRIu64 ") | "
-               "insn (%" PRIu64 ", %" PRIu64 ") | "
+        const uint64_t tb_cond_trigger =
+            qemu_plugin_u64_get(tb_cond_num_trigger, i);
+        const uint64_t tb_cond_left =
+            qemu_plugin_u64_get(tb_cond_track_count, i);
+        const uint64_t insn_cond_trigger =
+            qemu_plugin_u64_get(insn_cond_num_trigger, i);
+        const uint64_t insn_cond_left =
+            qemu_plugin_u64_get(insn_cond_track_count, i);
+        printf("cpu %d: tb (%" PRIu64 ", %" PRIu64
+               ", %" PRIu64 " * %" PRIu64 " + %" PRIu64
+               ") | "
+               "insn (%" PRIu64 ", %" PRIu64
+               ", %" PRIu64 " * %" PRIu64 " + %" PRIu64
+               ") | "
                "mem (%" PRIu64 ", %" PRIu64 ")"
                "\n",
-               i, tb, tb_inline, insn, insn_inline, mem, mem_inline);
+               i,
+               tb, tb_inline,
+               tb_cond_trigger, cond_trigger_limit, tb_cond_left,
+               insn, insn_inline,
+               insn_cond_trigger, cond_trigger_limit, insn_cond_left,
+               mem, mem_inline);
         g_assert(tb == tb_inline);
         g_assert(insn == insn_inline);
         g_assert(mem == mem_inline);
+        g_assert(tb_cond_trigger == tb / cond_trigger_limit);
+        g_assert(tb_cond_left == tb % cond_trigger_limit);
+        g_assert(insn_cond_trigger == insn / cond_trigger_limit);
+        g_assert(insn_cond_left == insn % cond_trigger_limit);
     }
 
     stats_tb();
@@ -132,6 +176,22 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
     g_mutex_unlock(&tb_lock);
 }
 
+static void vcpu_tb_cond_exec(unsigned int cpu_index, void *udata)
+{
+    g_assert(qemu_plugin_u64_get(tb_cond_track_count, cpu_index) ==
+             cond_trigger_limit);
+    qemu_plugin_u64_set(tb_cond_track_count, cpu_index, 0);
+    qemu_plugin_u64_add(tb_cond_num_trigger, cpu_index, 1);
+}
+
+static void vcpu_insn_cond_exec(unsigned int cpu_index, void *udata)
+{
+    g_assert(qemu_plugin_u64_get(insn_cond_track_count, cpu_index) ==
+             cond_trigger_limit);
+    qemu_plugin_u64_set(insn_cond_track_count, cpu_index, 0);
+    qemu_plugin_u64_add(insn_cond_num_trigger, cpu_index, 1);
+}
+
 static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 {
     qemu_plugin_u64_add(count_insn, cpu_index, 1);
@@ -163,6 +223,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
         tb, QEMU_PLUGIN_INLINE_STORE_U64, data_tb, (uintptr_t) tb_store);
 
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_ADD_U64, tb_cond_track_count, 1);
+    qemu_plugin_register_vcpu_tb_exec_cond_cb(
+        tb, vcpu_tb_cond_exec, QEMU_PLUGIN_CB_NO_REGS,
+        QEMU_PLUGIN_COND_EQ, tb_cond_track_count, cond_trigger_limit, NULL);
+
     for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
         void *insn_store = insn;
@@ -176,6 +242,13 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
             insn, QEMU_PLUGIN_INLINE_ADD_U64, count_insn_inline, 1);
 
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+            insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_cond_track_count, 1);
+        qemu_plugin_register_vcpu_insn_exec_cond_cb(
+            insn, vcpu_insn_cond_exec, QEMU_PLUGIN_CB_NO_REGS,
+            QEMU_PLUGIN_COND_EQ, insn_cond_track_count, cond_trigger_limit,
+            NULL);
+
         qemu_plugin_register_vcpu_mem_cb(insn, &vcpu_mem_access,
                                          QEMU_PLUGIN_CB_NO_REGS,
                                          QEMU_PLUGIN_MEM_RW, mem_store);
@@ -207,6 +280,14 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         counts, CPUCount, count_insn_inline);
     count_mem_inline = qemu_plugin_scoreboard_u64_in_struct(
         counts, CPUCount, count_mem_inline);
+    tb_cond_num_trigger = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, tb_cond_num_trigger);
+    tb_cond_track_count = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, tb_cond_track_count);
+    insn_cond_num_trigger = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, insn_cond_num_trigger);
+    insn_cond_track_count = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, insn_cond_track_count);
     data = qemu_plugin_scoreboard_new(sizeof(CPUData));
     data_insn = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_insn);
     data_tb = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_tb);
-- 
2.43.0


