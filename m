Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D4EC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reX5N-0004XB-17; Mon, 26 Feb 2024 04:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1reX5K-0004WU-OI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:15:42 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1reX5I-0005DX-EI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:15:42 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d204e102a9so33230521fa.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708938936; x=1709543736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSRYlMn2hSsf+I7l6Q4HwB+KtyzCuf3ojUzmxEiGWTA=;
 b=g9Utxd1lUFyfiIhCpMtPezXa2u7fmMyiNaKtd/Xwern8V8WJepDid8wFT1uya8/bVJ
 VTd+qzGQttML9Ahfcb3hBhi43ZL4RbTW885ZEDSEwRLHQkCj6oahwhPiIVXX/NiZOKBe
 28ukjmkVmai5Mx9Zv+NmBxJUuThHum45kvkktlxfd3O4XU4CStisDzeRFJIadrFPK8x2
 JhwWEzHU61rhRr/JCtBIQ6IoalfVC4U7QSGU6pIRBQVTGtCX4TQT6/irgZKU0PzNtqQQ
 RteIdpWUUxp6ChyadrzXk1Iq2YebPAymss/182qi1639I7dUmi3E8lYwmSflqXhlFQwi
 00JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708938936; x=1709543736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSRYlMn2hSsf+I7l6Q4HwB+KtyzCuf3ojUzmxEiGWTA=;
 b=CQlj68ASqgGqfcTVtWiK2OYIn0e0Wwo63fbMLrRcvvuAtKrbxI2e86FRX95jJ70Br8
 5CjbPhBGaaKP4CEIyQgRm1BSN7LMqBSKgLFpSRCXGrl0X9p4yP0GPpETLeJZt+W2oFgb
 Z7PfG/BE+1kPH0+NqLsyG4/evRtvkvZbHWMJ5m/d8hq3UmeQ1dgEz928FvOFFfkqEf0x
 x9ibQqjiN9/DxZRVcsEO78fgVyH0V2c8whWJaPPTEMldDFj41bBXVyCARTbE2ykVQN92
 238U57n0nCMsTXq9S33uk9XaLHiRMvgZR1UO3j5V31GO7oBe31lCnL+avovSlQYg6aW/
 6ilA==
X-Gm-Message-State: AOJu0YzwA2xLngxF6ljFLUaLApVYJkk5xkAh/Z55wenRoxs/CnAQ0kwt
 1orefDtEEbnbHYUl4PvrVyzhYq/1EDsZw3PoRcw2kb3PPRuffUOk8TryzKjBW1i4aCEMzstIpOb
 YOkGMUw==
X-Google-Smtp-Source: AGHT+IFf/X1FmtFq6WRKWkmp6Fci4+m/pUViUz5ip3QOyZS1xv/v1PeJz4M7SubD+Mbe1Qc3xwS8sg==
X-Received: by 2002:a05:651c:11cf:b0:2d2:2bd2:78e8 with SMTP id
 z15-20020a05651c11cf00b002d22bd278e8mr3125899ljo.47.1708938935937; 
 Mon, 26 Feb 2024 01:15:35 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 g7-20020adfe407000000b0033d2ae84fafsm7578814wrm.52.2024.02.26.01.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 01:15:35 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 11/12] plugins: remove non per_vcpu inline operation from
 API
Date: Mon, 26 Feb 2024 13:14:43 +0400
Message-ID: <20240226091446.479436-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lj1-x22b.google.com
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

Now we have a thread-safe equivalent of inline operation, and that all
plugins were changed to use it, there is no point to keep the old API.

In more, it will help when we implement more functionality (conditional
callbacks), as we can assume that we operate on a scoreboard.

API version bump was already done as part of this series.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 58 ++++--------------------------------
 plugins/api.c                | 29 ------------------
 plugins/qemu-plugins.symbols |  3 --
 3 files changed, 5 insertions(+), 85 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 7c33e2a5887..1044fa7b14f 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -52,7 +52,11 @@ typedef uint64_t qemu_plugin_id_t;
  * The plugins export the API they were built against by exposing the
  * symbol qemu_plugin_version which can be checked.
  *
- * version 2: removed qemu_plugin_n_vcpus and qemu_plugin_n_max_vcpus
+ * version 2:
+ * - removed qemu_plugin_n_vcpus and qemu_plugin_n_max_vcpus
+ * - Remove qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline.
+ *   Those functions are replaced by *_per_vcpu variants, which guarantee
+ *   thread-safety for operations.
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
@@ -309,25 +313,6 @@ enum qemu_plugin_op {
     QEMU_PLUGIN_INLINE_ADD_U64,
 };
 
-/**
- * qemu_plugin_register_vcpu_tb_exec_inline() - execution inline op
- * @tb: the opaque qemu_plugin_tb handle for the translation
- * @op: the type of qemu_plugin_op (e.g. ADD_U64)
- * @ptr: the target memory location for the op
- * @imm: the op data (e.g. 1)
- *
- * Insert an inline op to every time a translated unit executes.
- * Useful if you just want to increment a single counter somewhere in
- * memory.
- *
- * Note: ops are not atomic so in multi-threaded/multi-smp situations
- * you will get inexact results.
- */
-QEMU_PLUGIN_API
-void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
-                                              enum qemu_plugin_op op,
-                                              void *ptr, uint64_t imm);
-
 /**
  * qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu() - execution inline op
  * @tb: the opaque qemu_plugin_tb handle for the translation
@@ -359,21 +344,6 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             enum qemu_plugin_cb_flags flags,
                                             void *userdata);
 
-/**
- * qemu_plugin_register_vcpu_insn_exec_inline() - insn execution inline op
- * @insn: the opaque qemu_plugin_insn handle for an instruction
- * @op: the type of qemu_plugin_op (e.g. ADD_U64)
- * @ptr: the target memory location for the op
- * @imm: the op data (e.g. 1)
- *
- * Insert an inline op to every time an instruction executes. Useful
- * if you just want to increment a single counter somewhere in memory.
- */
-QEMU_PLUGIN_API
-void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
-                                                enum qemu_plugin_op op,
-                                                void *ptr, uint64_t imm);
-
 /**
  * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec inline op
  * @insn: the opaque qemu_plugin_insn handle for an instruction
@@ -597,24 +567,6 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       enum qemu_plugin_mem_rw rw,
                                       void *userdata);
 
-/**
- * qemu_plugin_register_vcpu_mem_inline() - register an inline op to any memory access
- * @insn: handle for instruction to instrument
- * @rw: apply to reads, writes or both
- * @op: the op, of type qemu_plugin_op
- * @ptr: pointer memory for the op
- * @imm: immediate data for @op
- *
- * This registers a inline op every memory access generated by the
- * instruction. This provides for a lightweight but not thread-safe
- * way of counting the number of operations done.
- */
-QEMU_PLUGIN_API
-void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
-                                          enum qemu_plugin_mem_rw rw,
-                                          enum qemu_plugin_op op, void *ptr,
-                                          uint64_t imm);
-
 /**
  * qemu_plugin_register_vcpu_mem_inline_per_vcpu() - inline op for mem access
  * @insn: handle for instruction to instrument
diff --git a/plugins/api.c b/plugins/api.c
index 5fed50d9b09..e0af3c4a9e3 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -101,16 +101,6 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
     }
 }
 
-void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
-                                              enum qemu_plugin_op op,
-                                              void *ptr, uint64_t imm)
-{
-    if (!tb->mem_only) {
-        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
-                                  0, op, ptr, imm);
-    }
-}
-
 void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
     struct qemu_plugin_tb *tb,
     enum qemu_plugin_op op,
@@ -138,16 +128,6 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
     }
 }
 
-void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
-                                                enum qemu_plugin_op op,
-                                                void *ptr, uint64_t imm)
-{
-    if (!insn->mem_only) {
-        plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
-                                  0, op, ptr, imm);
-    }
-}
-
 void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
     struct qemu_plugin_insn *insn,
     enum qemu_plugin_op op,
@@ -175,15 +155,6 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                 cb, flags, rw, udata);
 }
 
-void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
-                                          enum qemu_plugin_mem_rw rw,
-                                          enum qemu_plugin_op op, void *ptr,
-                                          uint64_t imm)
-{
-    plugin_register_inline_op(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE],
-                              rw, op, ptr, imm);
-}
-
 void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
     struct qemu_plugin_insn *insn,
     enum qemu_plugin_mem_rw rw,
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 0d8141b85f1..a9fac056c7f 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -27,16 +27,13 @@
   qemu_plugin_register_vcpu_idle_cb;
   qemu_plugin_register_vcpu_init_cb;
   qemu_plugin_register_vcpu_insn_exec_cb;
-  qemu_plugin_register_vcpu_insn_exec_inline;
   qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_mem_cb;
-  qemu_plugin_register_vcpu_mem_inline;
   qemu_plugin_register_vcpu_mem_inline_per_vcpu;
   qemu_plugin_register_vcpu_resume_cb;
   qemu_plugin_register_vcpu_syscall_cb;
   qemu_plugin_register_vcpu_syscall_ret_cb;
   qemu_plugin_register_vcpu_tb_exec_cb;
-  qemu_plugin_register_vcpu_tb_exec_inline;
   qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_tb_trans_cb;
   qemu_plugin_reset;
-- 
2.43.0


