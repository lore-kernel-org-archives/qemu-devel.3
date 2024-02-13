Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C72C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpIM-0001zU-6c; Tue, 13 Feb 2024 04:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpIF-0001fy-Np
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:35 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpI9-0000Is-6M
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:35 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33adec41b55so438904f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817287; x=1708422087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FX8AG3Ps8xAkefZTvhN1LBKlwzFSEA66N1+pg+4IJGo=;
 b=g/wV5ndgySjR2tSIni1y6cSk7bje1gpINb9n6eCoxsqSm9Z7RZFpe0RzMOdNX9XmOp
 VVZmP0c0f0QJywaX58oLQ57LjC8HVTX9ec/CwvxeaRUHv3ZClEamkMsYzgxRh4gGHosk
 bdeqOSSKNRUmLMIe/lwYO+P9bI8odyskqOoChaTkWy1PEB/0w1c45JMsOE8hwzaJl3fI
 ekTynjG6qHvzDk/WN1ECOsylLIPLLmdjLgiOAb9b+TXP2GCGukUJy35h315GODIiPLL/
 7/tURaycVya4zf7dlOKECNlbH8onCzLt9R4Yyv/t6CdYKwYyBuxuM1yE16r5eVo4HxjJ
 uOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817287; x=1708422087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FX8AG3Ps8xAkefZTvhN1LBKlwzFSEA66N1+pg+4IJGo=;
 b=URm0bkNbyvC3aOFdf3inzkgyH4mEevI5GJgFES+LjfxiqE9BF2jFzZ9Y8ZfGSqJhtS
 ZNrjTP4ZtI3Gm8emSHooE+6UPAjN1AxcoCTPHDPcKPu+mhx/eujx83GR62OT5+FV9aKi
 PpaN1yh9kGSf2SxOFiUyF8vJ8Nq+F9ovbIJo6BJbtJqUA5iSNsC9BYmLjKl9xEI2mhF2
 XhRUoyLpfCxv35VLTccc/+suh3PUFlIT7LtNHjbhz3z5J6lFFlfADZ1liLXGus2CjWiY
 WKkdH0v3oCzEKxGtJ6aIYh9cqa4CpbIefRZDEBCWvHD45bPXtL1IFcyR5YNKQTZzoY1K
 1udg==
X-Gm-Message-State: AOJu0Yy6LDP+/EBRvK9VLsmccSgZWJleSglzDZA1scSqYsPCCKweT4U5
 er7v+91GJhTobjRGbxRqWmkSu7gAQrLoN04VIAyp/ra+4HDzxAserRbUF3QDbkOzn3726/2l6SI
 A
X-Google-Smtp-Source: AGHT+IFSnFcW83k1g9OCiJPiSUNTqOheuSlGwIhQzlAkT264x26dqmG6VJUmVs1Jpz8mNhyg1FpJ1w==
X-Received: by 2002:a5d:6e55:0:b0:33b:3c79:9182 with SMTP id
 j21-20020a5d6e55000000b0033b3c799182mr6702834wrz.3.1707817287288; 
 Tue, 13 Feb 2024 01:41:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ/nrcdm5oX93vAwJGHq2W8VMFzg+QICcT6RyDCKIxECNIWfr8m+DpIWFWh7NsxhjkUF9xGq5BmKRAj3oJy+NHy9P0Rvl0Sq+hIESzjBZ1lprLytWb+4iQLlVtwdvNu1idod9ZeFbnyzxmltTrGZdaGDWI88CJQ4NxEqKfw+jChkKeUtf9HZ3vNFaSS4lwwC8tIMEzHC45PjwOee/UR8AQtpKFyxWvgkHtiYv9mN7gQ2WROwcc30dZfkTY9j5nP1pA9NqjO7rT9E7rmyGNCNsLs4aaXX/0O3a/HovukGuIh0VUjgTlb7Cp2dAih+hty3PElMM3VJLdAZElXksmo4sGGlZWtA==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:41:27 -0800 (PST)
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
Subject: [PATCH v4 16/18] plugins: remove non per_vcpu inline operation from
 API
Date: Tue, 13 Feb 2024 13:40:06 +0400
Message-ID: <20240213094009.150349-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42f.google.com
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

Bump API version as it's a breaking change for existing plugins.
Bump min API version too, as we removed some functions.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 58 ++++--------------------------------
 plugins/plugin.h             |  2 +-
 plugins/api.c                | 29 ------------------
 plugins/qemu-plugins.symbols |  3 --
 4 files changed, 6 insertions(+), 86 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index cdf1266d724..9b11098ff82 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -53,11 +53,15 @@ typedef uint64_t qemu_plugin_id_t;
  * symbol qemu_plugin_version which can be checked.
  *
  * version 2: removed qemu_plugin_n_vcpus and qemu_plugin_n_max_vcpus
+ * version 3:
+ * Remove qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline.
+ * Those functions are replaced by *_per_vcpu variants, which guarantees
+ * thread-safety for operations.
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 2
+#define QEMU_PLUGIN_VERSION 3
 
 /**
  * struct qemu_info_t - system information for plugins
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
diff --git a/plugins/plugin.h b/plugins/plugin.h
index f6fa10a0f56..c547c5c83ea 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -15,7 +15,7 @@
 #include <gmodule.h>
 #include "qemu/qht.h"
 
-#define QEMU_PLUGIN_MIN_VERSION 2
+#define QEMU_PLUGIN_MIN_VERSION 3
 
 /* global state */
 struct qemu_plugin_state {
diff --git a/plugins/api.c b/plugins/api.c
index be2badda9fa..45eabab8686 100644
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


