Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94EEC369A2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oAt-00023f-Qn; Mon, 07 Apr 2025 11:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nm6-0002Ew-Ao; Mon, 07 Apr 2025 10:48:34 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nlz-0001i5-WE; Mon, 07 Apr 2025 10:48:34 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736a72220edso4570284b3a.3; 
 Mon, 07 Apr 2025 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744037305; x=1744642105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhEGiwMMkGRM1yxW30sVtGE4HNpoTyxqGR7mPhKAnnY=;
 b=TfIaJ/bHJzq3FlgZzLENFlM9BZqh2l+pbY9hGlTxL1wk0YeohzUXEQBpQJw9RQPu5p
 byKhjHiDYgjxnIx7uwYXhm233ahmzCRg/EJdJa/B8Qv3rFoKPVY2F2y4OtF1HqYL0/5F
 pKRFB3m52hMrLRCDVGyYkEQvj3w5QEfPBve2gelFEZSmbfHVHe7aBnz3mtaEvjs332eA
 OWNnxLfjumrwus+RJLoYKseyvJ/cX7cjwQuE8wXYCVf9ptYL14bcp4KiLNQey98IFexU
 vDkaiwLoykbld8N1AoU+tEmilS/pha7RImLg2V2/2kxgIpuloUGz9rdhPjTV82NYYDYN
 D5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037305; x=1744642105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhEGiwMMkGRM1yxW30sVtGE4HNpoTyxqGR7mPhKAnnY=;
 b=DoZ1bZN77dCKTLMAciajFxS4urEugKTLOAu8en3cfAcOA1ZuFn/UqwrkVvj5koCfv+
 vi2i3OT5ntv4V6Yqr/9NFP8EAsv/BspqJSGSyUpgKXs9iADLVLd6knsjaXcoZwYLOxMj
 U/sHmH2mxzY0JCMOvhxXsT6kwtYYO53VflCPsIfFYijXJYmk/UcUQwb1Jhey9zo6eCDg
 RqUtzQ6mM8H3/aHP0p3NPMR3JSkO89uWjMNdEAK36qmmpJR2FZl1JdzwPMeZZUUijVe9
 4Qy5//KHxpXpJEvdfPfsOzqIRzb4EQbzmICSgezNAnq0Uus2seJAZolsT6guIhYwyKeS
 EdgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLKSD3usD8dJ8bes4tP6UMK3ZxJvOiMlOzgyM5qfrGJ/evYnvZrKdeojRyq76fcIn9bDGkZGSJGw==@nongnu.org,
 AJvYcCVcySsBHeyJiI58o8MKOP4rD/vceJJXyt0rjRMduw3W5thTtLM0SIjPh4k/VUmO/8phqVrpIaVFJjoT4A==@nongnu.org,
 AJvYcCW3HGu8luJaHAF4TlDeGkjosDnHr4vR4nhfKwPQOOVPPptWQEFbo8sZA9GFmo7uHFjqDQVnwYingVX8qg==@nongnu.org
X-Gm-Message-State: AOJu0Yw5S5RvzXn0iQYjSMyM5QkJMSJrg/+zTSDtRImXYdq3a5+wF4m2
 cllDknOSlygOKCT0rbqnFc3rMajcolmehWKSd9gjpKu/dCqcCHZtnK6BNKzQ
X-Gm-Gg: ASbGncvyG9a4dkO43DDPFGmbhXqBz5lGCUt1ZJg5eKu62Vz9NqKr+K4r9mIJjpoMkwK
 HDBXUyN/LVVX0Lm/w8HGqq5JE/3cuNkNXWI/2grFP6TxscR+DCxHmM3Zb7S/NZjSLqCcK0ugEvV
 fnz3HFyfXF7pc1RIXs6vEDfbarg3s3tFWf2Im8a/4ulgCCzaYWi2B96dK0iBq8bUDe5LYcwbqFl
 i7sf8MqCx82a1jM0uXJB1hQsbFER2tV4UvCd4B3zhpLu0Mqee39UXK5iVNREnoaUUfiocyMTqnA
 NH/lp7I9kfJDun7OMVONgv9XSuAX5fioB+VIVnr6hFoQujIOyC1GBCZ0+feCHg==
X-Google-Smtp-Source: AGHT+IFPx+2yTucZS0ZQ6c1k3C1H2SoHzBfrXKPfuRGWTNz8yeOYJto/W5ND61P2HNGPnG8sAjNmvA==
X-Received: by 2002:aa7:888c:0:b0:736:4644:86ee with SMTP id
 d2e1a72fcca58-73b6aa72dedmr10682456b3a.14.1744037303924; 
 Mon, 07 Apr 2025 07:48:23 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:8768:486:6a8e:e855])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ef3c2sm8856960b3a.59.2025.04.07.07.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:48:23 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 07/10] tcg: Add a TCG backend for WebAssembly
Date: Mon,  7 Apr 2025 23:45:58 +0900
Message-Id: <24b5ff124d70043aff97dc30aa45f8a502676989.1744032780.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744032780.git.ktokunaga.mail@gmail.com>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Apr 2025 11:14:07 -0400
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

A TB consists of a wasmTBHeader followed by the data listed below. The
wasmTBHeader contains pointers for each element:

- TCI code
- Wasm code
- Array of function indices imported into the Wasm instance
- Counter tracking the number of TB executions
- Pointer to the Wasm instance information

The Wasm backend (tcg/wasm32.c) and Wasm instances running on the same
thread share information, such as CPUArchState, through a wasmContext
structure. The Wasm backend defines tcg_qemu_tb_exec as a common entry point
for TBs, similar to the TCI backend. tcg_qemu_tb_exec runs TBs on a forked
TCI interpreter by default, while compiles and executes frequently executed
TBs as Wasm.

The code generator (tcg/wasm32) receives TCG IR and generates both Wasm and
TCI instructions. Since Wasm cannot directly jump to specific addresses,
labels are implemented using Wasm control flow instructions. As shown in the
pseudo-code below, a TB wraps instructions in a large loop, where codes are
placed within if blocks separated by labels. Branching is handled by
breaking from the current block and entering the target block.

loop
  if
    ... code after label1
  end
  if
    ... code after label2
  end
  ...
end

Additionally, the Wasm backend differs from other backends in several ways:

- goto_tb and goto_ptr return control to tcg_qemu_tb_exec which runs the
  target TB
- Helper function pointers are stored in an array in TB and imported into
  the Wasm instance on execution
- Wasm TBs lack prologue and epilogue. TBs are executed via tcg_qemu_tb_exec

Browsers cause out of memory error if too many Wasm instances are
created. To prevent this, the Wasm backend tracks active instances using an
array. When instantiating a new instance risks exceeding the limit, the
backend removes older instances to avoid browser errors. These removed
instances are re-instantiated when needed.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 include/accel/tcg/getpc.h        |    2 +-
 include/tcg/helper-info.h        |    4 +-
 include/tcg/tcg.h                |    2 +-
 meson.build                      |    2 +
 tcg/meson.build                  |    5 +
 tcg/tcg.c                        |   26 +-
 tcg/wasm32.c                     | 1260 +++++++++
 tcg/wasm32.h                     |   39 +
 tcg/wasm32/tcg-target-con-set.h  |   18 +
 tcg/wasm32/tcg-target-con-str.h  |    8 +
 tcg/wasm32/tcg-target-has.h      |  102 +
 tcg/wasm32/tcg-target-mo.h       |   12 +
 tcg/wasm32/tcg-target-opc.h.inc  |    4 +
 tcg/wasm32/tcg-target-reg-bits.h |   12 +
 tcg/wasm32/tcg-target.c.inc      | 4484 ++++++++++++++++++++++++++++++
 tcg/wasm32/tcg-target.h          |   65 +
 16 files changed, 6035 insertions(+), 10 deletions(-)
 create mode 100644 tcg/wasm32.c
 create mode 100644 tcg/wasm32.h
 create mode 100644 tcg/wasm32/tcg-target-con-set.h
 create mode 100644 tcg/wasm32/tcg-target-con-str.h
 create mode 100644 tcg/wasm32/tcg-target-has.h
 create mode 100644 tcg/wasm32/tcg-target-mo.h
 create mode 100644 tcg/wasm32/tcg-target-opc.h.inc
 create mode 100644 tcg/wasm32/tcg-target-reg-bits.h
 create mode 100644 tcg/wasm32/tcg-target.c.inc
 create mode 100644 tcg/wasm32/tcg-target.h

diff --git a/include/accel/tcg/getpc.h b/include/accel/tcg/getpc.h
index 8a97ce34e7..78acb4a3cf 100644
--- a/include/accel/tcg/getpc.h
+++ b/include/accel/tcg/getpc.h
@@ -13,7 +13,7 @@
 #endif
 
 /* GETPC is the true target of the return instruction that we'll execute.  */
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
 extern __thread uintptr_t tci_tb_ptr;
 # define GETPC() tci_tb_ptr
 #else
diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 909fe73afa..9b4e8832a8 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -9,7 +9,7 @@
 #ifndef TCG_HELPER_INFO_H
 #define TCG_HELPER_INFO_H
 
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
 #include <ffi.h>
 #endif
 #include "tcg-target-reg-bits.h"
@@ -48,7 +48,7 @@ struct TCGHelperInfo {
     const char *name;
 
     /* Used with g_once_init_enter. */
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
     ffi_cif *cif;
 #else
     uintptr_t init;
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 84d99508b6..c9ab6c838a 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -940,7 +940,7 @@ static inline size_t tcg_current_code_size(TCGContext *s)
 #define TB_EXIT_IDXMAX    1
 #define TB_EXIT_REQUESTED 3
 
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
 uintptr_t tcg_qemu_tb_exec(CPUArchState *env, const void *tb_ptr);
 #else
 typedef uintptr_t tcg_prologue_fn(CPUArchState *env, const void *tb_ptr);
diff --git a/meson.build b/meson.build
index 343408636b..ab84820bc5 100644
--- a/meson.build
+++ b/meson.build
@@ -920,6 +920,8 @@ if get_option('tcg').allowed()
     tcg_arch = 'i386'
   elif host_arch == 'ppc64'
     tcg_arch = 'ppc'
+  elif host_arch == 'wasm32'
+    tcg_arch = 'wasm32'
   endif
   add_project_arguments('-iquote', meson.current_source_dir() / 'tcg' / tcg_arch,
                         language: all_languages)
diff --git a/tcg/meson.build b/tcg/meson.build
index 69ebb4908a..f1a1f9485d 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -20,6 +20,11 @@ if get_option('tcg_interpreter')
                       method: 'pkg-config')
   tcg_ss.add(libffi)
   tcg_ss.add(files('tci.c'))
+elif host_os == 'emscripten'
+  libffi = dependency('libffi', version: '>=3.0', required: true,
+                      method: 'pkg-config')
+  specific_ss.add(libffi)
+  specific_ss.add(files('wasm32.c'))
 endif
 
 tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dfd48b8264..154a4dafa7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -136,6 +136,10 @@ static void tcg_out_goto_tb(TCGContext *s, int which);
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS]);
+#if defined(EMSCRIPTEN)
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l);
+static int tcg_out_tb_end(TCGContext *s);
+#endif
 #if TCG_TARGET_MAYBE_vec
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src);
@@ -251,7 +255,7 @@ TCGv_env tcg_env;
 const void *tcg_code_gen_epilogue;
 uintptr_t tcg_splitwx_diff;
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
 tcg_prologue_fn *tcg_qemu_tb_exec;
 #endif
 
@@ -358,6 +362,9 @@ static void tcg_out_label(TCGContext *s, TCGLabel *l)
     tcg_debug_assert(!l->has_value);
     l->has_value = 1;
     l->u.value_ptr = tcg_splitwx_to_rx(s->code_ptr);
+#if defined(EMSCRIPTEN)
+    tcg_out_label_cb(s, l);
+#endif
 }
 
 TCGLabel *gen_new_label(void)
@@ -1139,7 +1146,7 @@ static TCGHelperInfo info_helper_st128_mmu = {
               | dh_typemask(ptr, 5)  /* uintptr_t ra */
 };
 
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
 static ffi_type *typecode_to_ffi(int argmask)
 {
     /*
@@ -1593,7 +1600,7 @@ void tcg_prologue_init(void)
     s->code_buf = s->code_gen_ptr;
     s->data_gen_ptr = NULL;
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
     tcg_qemu_tb_exec = (tcg_prologue_fn *)tcg_splitwx_to_rx(s->code_ptr);
 #endif
 
@@ -1649,11 +1656,11 @@ void tcg_prologue_init(void)
         }
     }
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
     /*
      * Assert that goto_ptr is implemented completely, setting an epilogue.
-     * For tci, we use NULL as the signal to return from the interpreter,
-     * so skip this check.
+     * For tci and wasm backend, we use NULL as the signal to return from the
+     * interpreter, so skip this check.
      */
     tcg_debug_assert(tcg_code_gen_epilogue != NULL);
 #endif
@@ -6505,6 +6512,13 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
                         tcg_ptr_byte_diff(s->code_ptr, s->code_buf));
 #endif
 
+#if defined(EMSCRIPTEN)
+    i = tcg_out_tb_end(s);
+    if (i < 0) {
+        return i;
+    }
+#endif
+
     return tcg_current_code_size(s);
 }
 
diff --git a/tcg/wasm32.c b/tcg/wasm32.c
new file mode 100644
index 0000000000..3dfd98c570
--- /dev/null
+++ b/tcg/wasm32.c
@@ -0,0 +1,1260 @@
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Wasm integration + ported TCI interpreter from tci.c
+ *
+ * Copyright (c) 2009, 2011, 2016 Stefan Weil
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <string.h>
+#include <emscripten.h>
+#include <emscripten/threading.h>
+#include "exec/cpu_ldst.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg.h"
+#include "tcg/helper-info.h"
+#include "tcg/tcg-ldst.h"
+#include "disas/dis-asm.h"
+#include "tcg-has.h"
+#include "wasm32.h"
+
+/* TBs executed more than this value will be compiled to wasm */
+#define INSTANTIATE_NUM 1500
+
+__thread uintptr_t tci_tb_ptr;
+
+/* Disassemble TCI bytecode. */
+int print_insn_tci(bfd_vma addr, disassemble_info *info)
+{
+    return 0; /* nop */
+}
+
+EM_JS(int, instantiate_wasm, (int wasm_begin,
+                              int wasm_size,
+                              int import_vec_begin,
+                              int import_vec_size),
+{
+    const memory_v = new DataView(HEAP8.buffer);
+    const wasm = HEAP8.subarray(wasm_begin, wasm_begin + wasm_size);
+    var helper = {};
+    helper.u = () => {
+        return (Asyncify.state != Asyncify.State.Unwinding) ? 1 : 0;
+    };
+    for (var i = 0; i < import_vec_size / 4; i++) {
+        helper[i] = wasmTable.get(
+            memory_v.getInt32(import_vec_begin + i * 4, true));
+    }
+    const mod = new WebAssembly.Module(wasm);
+    const inst = new WebAssembly.Instance(mod, {
+            "env" : {
+                "buffer" : wasmMemory,
+            },
+            "helper" : helper,
+    });
+
+    Module.__wasm32_tb.inst_gc_registry.register(inst, "instance");
+
+    return addFunction(inst.exports.start, 'ii');
+});
+
+__thread int cur_core_num;
+
+static inline int32_t *get_counter_ptr(void *tb_ptr)
+{
+    return (int32_t *)(((struct wasmTBHeader *)tb_ptr)->counter_ptr
+                       + cur_core_num * 4);
+}
+
+static inline uint32_t *get_info_ptr(void *tb_ptr)
+{
+    return (uint32_t *)(((struct wasmTBHeader *)tb_ptr)->info_ptr
+                        + cur_core_num * 4);
+}
+
+static inline uint32_t *get_tci_ptr(void *tb_ptr)
+{
+    return (uint32_t *)(((struct wasmTBHeader *)tb_ptr)->tci_ptr);
+}
+
+__thread struct wasmContext ctx = {
+    .tb_ptr = 0,
+    .stack = NULL,
+    .do_init = 1,
+    .stack128 = NULL,
+};
+
+static void tci_write_reg64(tcg_target_ulong *regs, uint32_t high_index,
+                            uint32_t low_index, uint64_t value)
+{
+    regs[low_index] = (uint32_t)value;
+    regs[high_index] = value >> 32;
+}
+
+/* Create a 64 bit value from two 32 bit values. */
+static uint64_t tci_uint64(uint32_t high, uint32_t low)
+{
+    return ((uint64_t)high << 32) + low;
+}
+
+static void tci_args_ldst(uint32_t insn,
+                          TCGReg *r0,
+                          TCGReg *r1,
+                          MemOpIdx *m2,
+                          const void *tb_ptr,
+                          void **l0)
+{
+    int diff = sextract32(insn, 12, 20);
+    *l0 = diff ? (uint8_t *)tb_ptr + diff : NULL;
+
+    uint64_t *data64 = (uint64_t *)*l0;
+    *r0 = (TCGReg)data64[0];
+    *r1 = (TCGReg)data64[1];
+    *m2 = (MemOpIdx)data64[2];
+}
+
+/*
+ * Load sets of arguments all at once.  The naming convention is:
+ *   tci_args_<arguments>
+ * where arguments is a sequence of
+ *
+ *   b = immediate (bit position)
+ *   c = condition (TCGCond)
+ *   i = immediate (uint32_t)
+ *   I = immediate (tcg_target_ulong)
+ *   l = label or pointer
+ *   m = immediate (MemOpIdx)
+ *   n = immediate (call return length)
+ *   r = register
+ *   s = signed ldst offset
+ */
+
+static void tci_args_l(uint32_t insn, const void *tb_ptr, void **l0)
+{
+    int diff = sextract32(insn, 12, 20);
+    *l0 = diff ? (uint8_t *)tb_ptr + diff : NULL;
+}
+
+static void tci_args_r(uint32_t insn, TCGReg *r0)
+{
+    *r0 = extract32(insn, 8, 4);
+}
+
+static void tci_args_nl(uint32_t insn, const void *tb_ptr,
+                        uint8_t *n0, void **l1)
+{
+    *n0 = extract32(insn, 8, 4);
+    *l1 = sextract32(insn, 12, 20) + (void *)tb_ptr;
+}
+
+static void tci_args_rl(uint32_t insn, const void *tb_ptr,
+                        TCGReg *r0, void **l1)
+{
+    *r0 = extract32(insn, 8, 4);
+    *l1 = sextract32(insn, 12, 20) + (void *)tb_ptr;
+}
+
+static void tci_args_rr(uint32_t insn, TCGReg *r0, TCGReg *r1)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+}
+
+static void tci_args_ri(uint32_t insn, TCGReg *r0, tcg_target_ulong *i1)
+{
+    *r0 = extract32(insn, 8, 4);
+    *i1 = sextract32(insn, 12, 20);
+}
+
+static void tci_args_rrr(uint32_t insn, TCGReg *r0, TCGReg *r1, TCGReg *r2)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+}
+
+static void tci_args_rrs(uint32_t insn, TCGReg *r0, TCGReg *r1, int32_t *i2)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *i2 = sextract32(insn, 16, 16);
+}
+
+static void tci_args_rrbb(uint32_t insn, TCGReg *r0, TCGReg *r1,
+                          uint8_t *i2, uint8_t *i3)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *i2 = extract32(insn, 16, 6);
+    *i3 = extract32(insn, 22, 6);
+}
+
+static void tci_args_rrrc(uint32_t insn,
+                          TCGReg *r0, TCGReg *r1, TCGReg *r2, TCGCond *c3)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+    *c3 = extract32(insn, 20, 4);
+}
+
+static void tci_args_rrrbb(uint32_t insn, TCGReg *r0, TCGReg *r1,
+                           TCGReg *r2, uint8_t *i3, uint8_t *i4)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+    *i3 = extract32(insn, 20, 6);
+    *i4 = extract32(insn, 26, 6);
+}
+
+static void tci_args_rrrr(uint32_t insn,
+                          TCGReg *r0, TCGReg *r1, TCGReg *r2, TCGReg *r3)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+    *r3 = extract32(insn, 20, 4);
+}
+
+static void tci_args_rrrrrc(uint32_t insn, TCGReg *r0, TCGReg *r1,
+                            TCGReg *r2, TCGReg *r3, TCGReg *r4, TCGCond *c5)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+    *r3 = extract32(insn, 20, 4);
+    *r4 = extract32(insn, 24, 4);
+    *c5 = extract32(insn, 28, 4);
+}
+
+static void tci_args_rrrrrr(uint32_t insn, TCGReg *r0, TCGReg *r1,
+                            TCGReg *r2, TCGReg *r3, TCGReg *r4, TCGReg *r5)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+    *r3 = extract32(insn, 20, 4);
+    *r4 = extract32(insn, 24, 4);
+    *r5 = extract32(insn, 28, 4);
+}
+
+static bool tci_compare32(uint32_t u0, uint32_t u1, TCGCond condition)
+{
+    bool result = false;
+    int32_t i0 = u0;
+    int32_t i1 = u1;
+    switch (condition) {
+    case TCG_COND_EQ:
+        result = (u0 == u1);
+        break;
+    case TCG_COND_NE:
+        result = (u0 != u1);
+        break;
+    case TCG_COND_LT:
+        result = (i0 < i1);
+        break;
+    case TCG_COND_GE:
+        result = (i0 >= i1);
+        break;
+    case TCG_COND_LE:
+        result = (i0 <= i1);
+        break;
+    case TCG_COND_GT:
+        result = (i0 > i1);
+        break;
+    case TCG_COND_LTU:
+        result = (u0 < u1);
+        break;
+    case TCG_COND_GEU:
+        result = (u0 >= u1);
+        break;
+    case TCG_COND_LEU:
+        result = (u0 <= u1);
+        break;
+    case TCG_COND_GTU:
+        result = (u0 > u1);
+        break;
+    case TCG_COND_TSTEQ:
+        result = (u0 & u1) == 0;
+        break;
+    case TCG_COND_TSTNE:
+        result = (u0 & u1) != 0;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return result;
+}
+
+static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
+{
+    bool result = false;
+    int64_t i0 = u0;
+    int64_t i1 = u1;
+    switch (condition) {
+    case TCG_COND_EQ:
+        result = (u0 == u1);
+        break;
+    case TCG_COND_NE:
+        result = (u0 != u1);
+        break;
+    case TCG_COND_LT:
+        result = (i0 < i1);
+        break;
+    case TCG_COND_GE:
+        result = (i0 >= i1);
+        break;
+    case TCG_COND_LE:
+        result = (i0 <= i1);
+        break;
+    case TCG_COND_GT:
+        result = (i0 > i1);
+        break;
+    case TCG_COND_LTU:
+        result = (u0 < u1);
+        break;
+    case TCG_COND_GEU:
+        result = (u0 >= u1);
+        break;
+    case TCG_COND_LEU:
+        result = (u0 <= u1);
+        break;
+    case TCG_COND_GTU:
+        result = (u0 > u1);
+        break;
+    case TCG_COND_TSTEQ:
+        result = (u0 & u1) == 0;
+        break;
+    case TCG_COND_TSTNE:
+        result = (u0 & u1) != 0;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return result;
+}
+
+static uint32_t tlb_load(
+    CPUArchState *env, uint64_t taddr, MemOp mop, uint64_t *ptr, bool is_ld)
+{
+    unsigned a_mask = (unsigned)ptr[3];
+    int mask_ofs = (int)ptr[4];
+    int8_t page_bits = (int8_t)ptr[5];
+    uint64_t page_mask = ptr[6];
+    int table_ofs = (uint64_t)ptr[7];
+
+    unsigned s_mask = (1u << (mop & MO_SIZE)) - 1;
+    tcg_target_long compare_mask;
+
+    uintptr_t table = *(uintptr_t *)((int)env + table_ofs);
+    uintptr_t mask = *(uintptr_t *)((int)env + mask_ofs);
+    uintptr_t entry = table +
+        ((taddr >> (page_bits - CPU_TLB_ENTRY_BITS)) & mask);
+    int off = is_ld ? offsetof(CPUTLBEntry, addr_read)
+        : offsetof(CPUTLBEntry, addr_write);
+    uint64_t target = *(uint64_t *)(entry + off);
+    uint64_t c_addr = taddr;
+    if (a_mask < s_mask) {
+        c_addr += s_mask - a_mask;
+    }
+    compare_mask = page_mask | a_mask;
+    c_addr &= compare_mask;
+
+    if (c_addr == target) {
+        return taddr + *(uintptr_t *)(entry + offsetof(CPUTLBEntry, addend));
+    }
+    return 0;
+}
+
+static uint64_t tci_qemu_ld(CPUArchState *env, uint64_t taddr,
+                            MemOpIdx oi, const void *tb_ptr, uint64_t *ptr)
+{
+    MemOp mop = get_memop(oi);
+    uintptr_t ra = (uintptr_t)tb_ptr;
+
+    uint32_t target_addr = tlb_load(env, taddr, mop, ptr, true);
+    if (target_addr != 0) {
+        switch (mop & MO_SSIZE) {
+        case MO_UB:
+            return *(uint8_t *)target_addr;
+        case MO_SB:
+            return *(int8_t *)target_addr;
+        case MO_UW:
+            return *(uint16_t *)target_addr;
+        case MO_SW:
+            return *(int16_t *)target_addr;
+        case MO_UL:
+            return *(uint32_t *)target_addr;
+        case MO_SL:
+            return *(int32_t *)target_addr;
+        case MO_UQ:
+            return *(uint64_t *)target_addr;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    switch (mop & MO_SSIZE) {
+    case MO_UB:
+        return helper_ldub_mmu(env, taddr, oi, ra);
+    case MO_SB:
+        return helper_ldsb_mmu(env, taddr, oi, ra);
+    case MO_UW:
+        return helper_lduw_mmu(env, taddr, oi, ra);
+    case MO_SW:
+        return helper_ldsw_mmu(env, taddr, oi, ra);
+    case MO_UL:
+        return helper_ldul_mmu(env, taddr, oi, ra);
+    case MO_SL:
+        return helper_ldsl_mmu(env, taddr, oi, ra);
+    case MO_UQ:
+        return helper_ldq_mmu(env, taddr, oi, ra);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tci_qemu_st(CPUArchState *env, uint64_t taddr, uint64_t val,
+                        MemOpIdx oi, const void *tb_ptr, uint64_t *ptr)
+{
+    MemOp mop = get_memop(oi);
+    uintptr_t ra = (uintptr_t)tb_ptr;
+
+    uint32_t target_addr = tlb_load(env, taddr, mop, ptr, false);
+    if (target_addr != 0) {
+        switch (mop & MO_SIZE) {
+        case MO_UB:
+            *(uint8_t *)target_addr = (uint8_t)val;
+            break;
+        case MO_UW:
+            *(uint16_t *)target_addr = (uint16_t)val;
+            break;
+        case MO_UL:
+            *(uint32_t *)target_addr = (uint32_t)val;
+            break;
+        case MO_UQ:
+            *(uint64_t *)target_addr = (uint64_t)val;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        return;
+    }
+
+    switch (mop & MO_SIZE) {
+    case MO_UB:
+        helper_stb_mmu(env, taddr, val, oi, ra);
+        break;
+    case MO_UW:
+        helper_stw_mmu(env, taddr, val, oi, ra);
+        break;
+    case MO_UL:
+        helper_stl_mmu(env, taddr, val, oi, ra);
+        break;
+    case MO_UQ:
+        helper_stq_mmu(env, taddr, val, oi, ra);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+#define CASE_32_64(x)                           \
+    case glue(glue(INDEX_op_, x), _i64):        \
+    case glue(glue(INDEX_op_, x), _i32):
+# define CASE_64(x)                             \
+    case glue(glue(INDEX_op_, x), _i64):
+
+__thread tcg_target_ulong regs[TCG_TARGET_NB_REGS];
+
+static inline uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env)
+{
+    uint32_t *tb_ptr = get_tci_ptr(ctx.tb_ptr);
+    uint64_t *stack = ctx.stack;
+
+    regs[TCG_AREG0] = (tcg_target_ulong)env;
+    regs[TCG_REG_CALL_STACK] = (uintptr_t)stack;
+
+    for (;;) {
+        uint32_t insn;
+        TCGOpcode opc;
+        TCGReg r0, r1, r2, r3, r4, r5;
+        tcg_target_ulong t1;
+        TCGCond condition;
+        uint8_t pos, len;
+        uint32_t tmp32;
+        uint64_t tmp64, taddr;
+        uint64_t T1, T2;
+        MemOpIdx oi;
+        int32_t ofs;
+        void *ptr;
+        int32_t *counter_ptr;
+
+        insn = *tb_ptr++;
+        opc = extract32(insn, 0, 8);
+
+        switch (opc) {
+        case INDEX_op_call:
+            {
+                void *call_slots[MAX_CALL_IARGS];
+                ffi_cif *cif;
+                void *func;
+                unsigned i, s, n;
+
+                tci_args_nl(insn, tb_ptr, &len, &ptr);
+                uint64_t *data64 = (uint64_t *)ptr;
+                func = (void *)data64[0];
+                cif = (void *)data64[1];
+
+                int reg_iarg_base = 8;
+                int reg_idx = 0;
+                int reg_idx_end = 5; /* NUM_OF_IARG_REGS */
+                int stack_idx = 0;
+                n = cif->nargs;
+                for (i = s = 0; i < n; ++i) {
+                    ffi_type *t = cif->arg_types[i];
+                    if (reg_idx < reg_idx_end) {
+                        call_slots[i] = &regs[reg_iarg_base + reg_idx];
+                        reg_idx += DIV_ROUND_UP(t->size, 8);
+                    } else {
+                        call_slots[i] = &stack[stack_idx];
+                        stack_idx += DIV_ROUND_UP(t->size, 8);
+                    }
+                }
+
+                /* Helper functions may need to access the "return address" */
+                tci_tb_ptr = (uintptr_t)tb_ptr;
+                ffi_call(cif, func, stack, call_slots);
+            }
+
+            switch (len) {
+            case 0: /* void */
+                break;
+            case 1: /* uint32_t */
+                /*
+                 * The result winds up "left-aligned" in the stack[0] slot.
+                 * Note that libffi has an odd special case in that it will
+                 * always widen an integral result to ffi_arg.
+                 */
+                if (sizeof(ffi_arg) == 8) {
+                    regs[TCG_REG_R0] = (uint32_t)stack[0];
+                } else {
+                    regs[TCG_REG_R0] = *(uint32_t *)stack;
+                }
+                break;
+            case 2: /* uint64_t */
+                /*
+                 * For TCG_TARGET_REG_BITS == 32, the register pair
+                 * must stay in host memory order.
+                 */
+                memcpy(&regs[TCG_REG_R0], stack, 8);
+                break;
+            case 3: /* Int128 */
+                memcpy(&regs[TCG_REG_R0], stack, 16);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            break;
+
+        case INDEX_op_br:
+            tci_args_l(insn, tb_ptr, &ptr);
+            tb_ptr = ptr;
+            continue;
+        case INDEX_op_setcond_i32:
+            tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
+            regs[r0] = tci_compare32(regs[r1], regs[r2], condition);
+            break;
+        case INDEX_op_movcond_i32:
+            tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
+            tmp32 = tci_compare32(regs[r1], regs[r2], condition);
+            regs[r0] = regs[tmp32 ? r3 : r4];
+            break;
+        case INDEX_op_setcond2_i32:
+            tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
+            T1 = tci_uint64(regs[r2], regs[r1]);
+            T2 = tci_uint64(regs[r4], regs[r3]);
+            regs[r0] = tci_compare64(T1, T2, condition);
+            break;
+        case INDEX_op_setcond_i64:
+            tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
+            regs[r0] = tci_compare64(regs[r1], regs[r2], condition);
+            break;
+        case INDEX_op_movcond_i64:
+            tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
+            tmp32 = tci_compare64(regs[r1], regs[r2], condition);
+            regs[r0] = regs[tmp32 ? r3 : r4];
+            break;
+        CASE_32_64(mov)
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = regs[r1];
+            break;
+        case INDEX_op_tci_movi:
+            tci_args_ri(insn, &r0, &t1);
+            regs[r0] = t1;
+            break;
+        case INDEX_op_tci_movl:
+            tci_args_rl(insn, tb_ptr, &r0, &ptr);
+            regs[r0] = *(tcg_target_ulong *)ptr;
+            break;
+
+            /* Load/store operations (32 bit). */
+
+        CASE_32_64(ld8u)
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(uint8_t *)ptr;
+            break;
+        CASE_32_64(ld8s)
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(int8_t *)ptr;
+            break;
+        CASE_32_64(ld16u)
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(uint16_t *)ptr;
+            break;
+        CASE_32_64(ld16s)
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(int16_t *)ptr;
+            break;
+        case INDEX_op_ld_i32:
+        CASE_64(ld32u)
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(uint32_t *)ptr;
+            break;
+        CASE_32_64(st8)
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            *(uint8_t *)ptr = regs[r0];
+            break;
+        CASE_32_64(st16)
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            *(uint16_t *)ptr = regs[r0];
+            break;
+        case INDEX_op_st_i32:
+        CASE_64(st32)
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            *(uint32_t *)ptr = regs[r0];
+            break;
+
+            /* Arithmetic operations (mixed 32/64 bit). */
+
+        CASE_32_64(add)
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] + regs[r2];
+            break;
+        CASE_32_64(sub)
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] - regs[r2];
+            break;
+        CASE_32_64(mul)
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] * regs[r2];
+            break;
+        CASE_32_64(and)
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] & regs[r2];
+            break;
+        CASE_32_64(or)
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] | regs[r2];
+            break;
+        CASE_32_64(xor)
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] ^ regs[r2];
+            break;
+#if TCG_TARGET_HAS_andc_i32 || TCG_TARGET_HAS_andc_i64
+        CASE_32_64(andc)
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] & ~regs[r2];
+            break;
+#endif
+#if TCG_TARGET_HAS_orc_i32 || TCG_TARGET_HAS_orc_i64
+        CASE_32_64(orc)
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] | ~regs[r2];
+            break;
+#endif
+#if TCG_TARGET_HAS_eqv_i32 || TCG_TARGET_HAS_eqv_i64
+        CASE_32_64(eqv)
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ~(regs[r1] ^ regs[r2]);
+            break;
+#endif
+#if TCG_TARGET_HAS_nand_i32 || TCG_TARGET_HAS_nand_i64
+        CASE_32_64(nand)
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ~(regs[r1] & regs[r2]);
+            break;
+#endif
+#if TCG_TARGET_HAS_nor_i32 || TCG_TARGET_HAS_nor_i64
+        CASE_32_64(nor)
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ~(regs[r1] | regs[r2]);
+            break;
+#endif
+
+            /* Arithmetic operations (32 bit). */
+
+        case INDEX_op_div_i32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int32_t)regs[r1] / (int32_t)regs[r2];
+            break;
+        case INDEX_op_divu_i32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint32_t)regs[r1] / (uint32_t)regs[r2];
+            break;
+        case INDEX_op_rem_i32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int32_t)regs[r1] % (int32_t)regs[r2];
+            break;
+        case INDEX_op_remu_i32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint32_t)regs[r1] % (uint32_t)regs[r2];
+            break;
+#if TCG_TARGET_HAS_clz_i32
+        case INDEX_op_clz_i32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            tmp32 = regs[r1];
+            regs[r0] = tmp32 ? clz32(tmp32) : regs[r2];
+            break;
+#endif
+#if TCG_TARGET_HAS_ctz_i32
+        case INDEX_op_ctz_i32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            tmp32 = regs[r1];
+            regs[r0] = tmp32 ? ctz32(tmp32) : regs[r2];
+            break;
+#endif
+#if TCG_TARGET_HAS_ctpop_i32
+        case INDEX_op_ctpop_i32:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = ctpop32(regs[r1]);
+            break;
+#endif
+
+            /* Shift/rotate operations (32 bit). */
+
+        case INDEX_op_shl_i32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint32_t)regs[r1] << (regs[r2] & 31);
+            break;
+        case INDEX_op_shr_i32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint32_t)regs[r1] >> (regs[r2] & 31);
+            break;
+        case INDEX_op_sar_i32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int32_t)regs[r1] >> (regs[r2] & 31);
+            break;
+#if TCG_TARGET_HAS_rot_i32
+        case INDEX_op_rotl_i32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = rol32(regs[r1], regs[r2] & 31);
+            break;
+        case INDEX_op_rotr_i32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ror32(regs[r1], regs[r2] & 31);
+            break;
+#endif
+        case INDEX_op_deposit_i32:
+            tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
+            regs[r0] = deposit32(regs[r1], pos, len, regs[r2]);
+            break;
+        case INDEX_op_extract_i32:
+            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
+            regs[r0] = extract32(regs[r1], pos, len);
+            break;
+        case INDEX_op_sextract_i32:
+            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
+            regs[r0] = sextract32(regs[r1], pos, len);
+            break;
+        case INDEX_op_brcond_i32:
+            tci_args_rl(insn, tb_ptr, &r0, &ptr);
+            if ((uint32_t)regs[r0]) {
+                tb_ptr = ptr;
+            }
+            break;
+#if TCG_TARGET_HAS_add2_i32
+        case INDEX_op_add2_i32:
+            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
+            T1 = tci_uint64(regs[r3], regs[r2]);
+            T2 = tci_uint64(regs[r5], regs[r4]);
+            tci_write_reg64(regs, r1, r0, T1 + T2);
+            break;
+#endif
+#if TCG_TARGET_HAS_sub2_i32
+        case INDEX_op_sub2_i32:
+            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
+            T1 = tci_uint64(regs[r3], regs[r2]);
+            T2 = tci_uint64(regs[r5], regs[r4]);
+            tci_write_reg64(regs, r1, r0, T1 - T2);
+            break;
+#endif
+#if TCG_TARGET_HAS_mulu2_i32
+        case INDEX_op_mulu2_i32:
+            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+            tmp64 = (uint64_t)(uint32_t)regs[r2] * (uint32_t)regs[r3];
+            tci_write_reg64(regs, r1, r0, tmp64);
+            break;
+#endif
+#if TCG_TARGET_HAS_muls2_i32
+        case INDEX_op_muls2_i32:
+            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+            tmp64 = (int64_t)(int32_t)regs[r2] * (int32_t)regs[r3];
+            tci_write_reg64(regs, r1, r0, tmp64);
+            break;
+#endif
+#if TCG_TARGET_HAS_ext8s_i32 || TCG_TARGET_HAS_ext8s_i64
+        CASE_32_64(ext8s)
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = (int8_t)regs[r1];
+            break;
+#endif
+#if TCG_TARGET_HAS_ext16s_i32 || TCG_TARGET_HAS_ext16s_i64 || \
+    TCG_TARGET_HAS_bswap16_i32 || TCG_TARGET_HAS_bswap16_i64
+        CASE_32_64(ext16s)
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = (int16_t)regs[r1];
+            break;
+#endif
+#if TCG_TARGET_HAS_ext8u_i32 || TCG_TARGET_HAS_ext8u_i64
+        CASE_32_64(ext8u)
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = (uint8_t)regs[r1];
+            break;
+#endif
+#if TCG_TARGET_HAS_ext16u_i32 || TCG_TARGET_HAS_ext16u_i64
+        CASE_32_64(ext16u)
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = (uint16_t)regs[r1];
+            break;
+#endif
+#if TCG_TARGET_HAS_bswap16_i32 || TCG_TARGET_HAS_bswap16_i64
+        CASE_32_64(bswap16)
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = bswap16(regs[r1]);
+            break;
+#endif
+#if TCG_TARGET_HAS_bswap32_i32 || TCG_TARGET_HAS_bswap32_i64
+        CASE_32_64(bswap32)
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = bswap32(regs[r1]);
+            break;
+#endif
+#if TCG_TARGET_HAS_not_i32 || TCG_TARGET_HAS_not_i64
+        CASE_32_64(not)
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = ~regs[r1];
+            break;
+#endif
+        CASE_32_64(neg)
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = -regs[r1];
+            break;
+
+            /* Load/store operations (64 bit). */
+
+        case INDEX_op_ld32s_i64:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(int32_t *)ptr;
+            break;
+        case INDEX_op_ld_i64:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(uint64_t *)ptr;
+            break;
+        case INDEX_op_st_i64:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            *(uint64_t *)ptr = regs[r0];
+            break;
+
+            /* Arithmetic operations (64 bit). */
+
+        case INDEX_op_div_i64:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int64_t)regs[r1] / (int64_t)regs[r2];
+            break;
+        case INDEX_op_divu_i64:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint64_t)regs[r1] / (uint64_t)regs[r2];
+            break;
+        case INDEX_op_rem_i64:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int64_t)regs[r1] % (int64_t)regs[r2];
+            break;
+        case INDEX_op_remu_i64:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint64_t)regs[r1] % (uint64_t)regs[r2];
+            break;
+#if TCG_TARGET_HAS_clz_i64
+        case INDEX_op_clz_i64:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
+            break;
+#endif
+#if TCG_TARGET_HAS_ctz_i64
+        case INDEX_op_ctz_i64:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
+            break;
+#endif
+#if TCG_TARGET_HAS_ctpop_i64
+        case INDEX_op_ctpop_i64:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = ctpop64(regs[r1]);
+            break;
+#endif
+#if TCG_TARGET_HAS_mulu2_i64
+        case INDEX_op_mulu2_i64:
+            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+            mulu64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
+            break;
+#endif
+#if TCG_TARGET_HAS_muls2_i64
+        case INDEX_op_muls2_i64:
+            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+            muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
+            break;
+#endif
+#if TCG_TARGET_HAS_add2_i64
+        case INDEX_op_add2_i64:
+            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
+            T1 = regs[r2] + regs[r4];
+            T2 = regs[r3] + regs[r5] + (T1 < regs[r2]);
+            regs[r0] = T1;
+            regs[r1] = T2;
+            break;
+#endif
+#if TCG_TARGET_HAS_add2_i64
+        case INDEX_op_sub2_i64:
+            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
+            T1 = regs[r2] - regs[r4];
+            T2 = regs[r3] - regs[r5] - (regs[r2] < regs[r4]);
+            regs[r0] = T1;
+            regs[r1] = T2;
+            break;
+#endif
+
+            /* Shift/rotate operations (64 bit). */
+
+        case INDEX_op_shl_i64:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] << (regs[r2] & 63);
+            break;
+        case INDEX_op_shr_i64:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] >> (regs[r2] & 63);
+            break;
+        case INDEX_op_sar_i64:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int64_t)regs[r1] >> (regs[r2] & 63);
+            break;
+#if TCG_TARGET_HAS_rot_i64
+        case INDEX_op_rotl_i64:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = rol64(regs[r1], regs[r2] & 63);
+            break;
+        case INDEX_op_rotr_i64:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ror64(regs[r1], regs[r2] & 63);
+            break;
+#endif
+        case INDEX_op_deposit_i64:
+            tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
+            regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
+            break;
+        case INDEX_op_extract_i64:
+            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
+            regs[r0] = extract64(regs[r1], pos, len);
+            break;
+        case INDEX_op_sextract_i64:
+            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
+            regs[r0] = sextract64(regs[r1], pos, len);
+            break;
+        case INDEX_op_brcond_i64:
+            tci_args_rl(insn, tb_ptr, &r0, &ptr);
+            if (regs[r0]) {
+                tb_ptr = ptr;
+            }
+            break;
+        case INDEX_op_ext32s_i64:
+        case INDEX_op_ext_i32_i64:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = (int32_t)regs[r1];
+            break;
+        case INDEX_op_ext32u_i64:
+        case INDEX_op_extu_i32_i64:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = (uint32_t)regs[r1];
+            break;
+#if TCG_TARGET_HAS_bswap64_i64
+        case INDEX_op_bswap64_i64:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = bswap64(regs[r1]);
+            break;
+#endif
+
+            /* QEMU specific operations. */
+
+        case INDEX_op_exit_tb:
+            tci_args_l(insn, tb_ptr, &ptr);
+            ctx.tb_ptr = 0;
+            return (uintptr_t)ptr;
+
+        case INDEX_op_goto_tb:
+            tci_args_l(insn, tb_ptr, &ptr);
+            if (*(uint32_t **)ptr != tb_ptr) {
+                tb_ptr = *(uint32_t **)ptr;
+                ctx.tb_ptr = tb_ptr;
+                counter_ptr = get_counter_ptr(tb_ptr);
+                if ((*counter_ptr >= 0) && (*counter_ptr < INSTANTIATE_NUM)) {
+                    *counter_ptr += 1;
+                } else {
+                    return 0; /* enter to wasm TB */
+                }
+                tb_ptr = get_tci_ptr(tb_ptr);
+            }
+            break;
+
+        case INDEX_op_goto_ptr:
+            tci_args_r(insn, &r0);
+            ptr = (void *)regs[r0];
+            if (!ptr) {
+                ctx.tb_ptr = 0;
+                return 0;
+            }
+
+            tb_ptr = ptr;
+            ctx.tb_ptr = tb_ptr;
+            counter_ptr = get_counter_ptr(tb_ptr);
+            if ((*counter_ptr >= 0) && (*counter_ptr < INSTANTIATE_NUM)) {
+                *counter_ptr += 1;
+            } else {
+                return 0; /* enter to wasm TB */
+            }
+            tb_ptr = get_tci_ptr(tb_ptr);
+
+            break;
+
+        case INDEX_op_qemu_ld_i32:
+        case INDEX_op_qemu_ld_i64:
+            tci_args_ldst(insn, &r0, &r1, &oi, tb_ptr, &ptr);
+            taddr = regs[r1];
+            regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr, ptr);
+            break;
+
+        case INDEX_op_qemu_st_i32:
+        case INDEX_op_qemu_st_i64:
+            tci_args_ldst(insn, &r0, &r1, &oi, tb_ptr, &ptr);
+            taddr = regs[r1];
+            tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr, ptr);
+            break;
+
+        case INDEX_op_mb:
+            /* Ensure ordering for all kinds */
+            smp_mb();
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
+
+/*
+ * Max number of instances can exist simultaneously.
+ *
+ * If the number of instances reaches this and a new instance needs to be
+ * created, old instances are removed so that new instances can be created
+ * without hitting the browser's limit.
+ */
+#define MAX_INSTANCES 15000
+#define INSTANCES_BUF_MAX (MAX_INSTANCES + 1)
+
+int instances_global;
+
+/* Holds the relationship between TB and Wasm instance. */
+struct instance_info {
+    void *tb;
+    int func_idx;
+};
+__thread struct instance_info instances[INSTANCES_BUF_MAX];
+__thread int instances_begin;
+__thread int instances_end;
+
+static void add_instance(int fidx, void *tb_ptr)
+{
+    uint32_t *info_ptr = get_info_ptr(tb_ptr);
+
+    instances[instances_end].tb = tb_ptr;
+    instances[instances_end].func_idx = fidx;
+    *info_ptr = (uint32_t)(&(instances[instances_end]));
+    instances_end  = (instances_end + 1) % INSTANCES_BUF_MAX;
+
+    qatomic_inc(&instances_global);
+}
+
+static int get_instance(void *tb_ptr)
+{
+    uint32_t *info_ptr = get_info_ptr(tb_ptr);
+    struct instance_info *elm = (struct instance_info *)(*info_ptr);
+    if (elm == NULL) {
+        return 0;
+    }
+    if (elm->tb != tb_ptr) {
+        /* invalidated */
+        int32_t *counter_ptr = get_counter_ptr(tb_ptr);
+        *counter_ptr = INSTANTIATE_NUM; /* instanciated immediately */
+        *info_ptr = 0;
+        return 0;
+    }
+    return elm->func_idx;
+}
+
+__thread int instance_pending_gc;
+__thread int instance_done_gc;
+
+static void remove_instance(void)
+{
+    int num;
+    if (instance_pending_gc > 0) {
+        return;
+    }
+    if (instances_begin <= instances_end) {
+        num = instances_end - instances_begin;
+    } else {
+        num = instances_end + (INSTANCES_BUF_MAX - instances_begin);
+    }
+    num /= 2;
+    for (int i = 0; i < num; i++) {
+        EM_ASM({ removeFunction($0); }, instances[instances_begin].func_idx);
+        instances[instances_begin].tb = NULL;
+        instances_begin = (instances_begin + 1) % INSTANCES_BUF_MAX;
+    }
+    instance_pending_gc += num;
+}
+
+static bool can_add_instance(void)
+{
+    return qatomic_read(&instances_global) < MAX_INSTANCES;
+}
+
+static void check_instance_garbage_collected(void)
+{
+    if (instance_done_gc > 0) {
+        qatomic_sub(&instances_global, instance_done_gc);
+        instance_pending_gc -= instance_done_gc;
+        instance_done_gc = 0;
+    }
+}
+
+#define MAX_EXEC_NUM 50000
+__thread int exec_cnt = MAX_EXEC_NUM;
+static inline void trysleep(void)
+{
+    if (--exec_cnt == 0) {
+        if (!can_add_instance()) {
+            emscripten_sleep(0); /* return to the browser main loop */
+            check_instance_garbage_collected();
+        }
+        exec_cnt = MAX_EXEC_NUM;
+    }
+}
+
+EM_JS(void, init_wasm32_js, (int instance_done_gc_ptr),
+{
+    Module.__wasm32_tb = {
+        inst_gc_registry: new FinalizationRegistry((i) => {
+            if (i == "instance") {
+                const memory_v = new DataView(HEAP8.buffer);
+                let v = memory_v.getInt32(instance_done_gc_ptr, true);
+                memory_v.setInt32(instance_done_gc_ptr, v + 1, true);
+            }
+        })
+    };
+});
+
+int get_core_nums(void)
+{
+    return emscripten_num_logical_cores();
+}
+
+int cur_core_num_max;
+
+static void init_wasm32(void)
+{
+    cur_core_num = qatomic_fetch_inc(&cur_core_num_max);
+    ctx.stack = g_malloc(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE);
+    ctx.stack128 = g_malloc(TCG_STATIC_CALL_ARGS_SIZE);
+    ctx.tci_tb_ptr = (uint32_t *)&tci_tb_ptr;
+    init_wasm32_js((int)&instance_done_gc);
+}
+
+__thread bool initdone;
+
+typedef uint32_t (*wasm_func_ptr)(struct wasmContext *);
+
+uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
+                                            const void *v_tb_ptr)
+{
+    if (!initdone) {
+        init_wasm32();
+        initdone = true;
+    }
+    ctx.env = env;
+    ctx.tb_ptr = (void *)v_tb_ptr;
+    ctx.do_init = 1;
+    while (true) {
+        trysleep();
+        struct wasmTBHeader *header = (struct wasmTBHeader *)ctx.tb_ptr;
+        int32_t *counter_ptr = get_counter_ptr(header);
+        uint32_t res;
+        int fidx = get_instance(ctx.tb_ptr);
+        if (fidx > 0) {
+            res = ((wasm_func_ptr)(fidx))(&ctx);
+        } else if (*counter_ptr < INSTANTIATE_NUM) {
+            *counter_ptr += 1;
+            res = tcg_qemu_tb_exec_tci(env);
+        } else if (!can_add_instance()) {
+            remove_instance();
+            check_instance_garbage_collected();
+            res = tcg_qemu_tb_exec_tci(env);
+        } else {
+            int fidx = instantiate_wasm((int)header->wasm_ptr,
+                                        header->wasm_size,
+                                        (int)header->import_ptr,
+                                        header->import_size);
+            add_instance(fidx, ctx.tb_ptr);
+            res = ((wasm_func_ptr)(fidx))(&ctx);
+        }
+        if ((uint32_t)ctx.tb_ptr == 0) {
+            return res;
+        }
+    }
+}
diff --git a/tcg/wasm32.h b/tcg/wasm32.h
new file mode 100644
index 0000000000..cbeb281a7d
--- /dev/null
+++ b/tcg/wasm32.h
@@ -0,0 +1,39 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef TCG_WASM32_H
+#define TCG_WASM32_H
+
+struct wasmContext {
+    CPUArchState *env;
+    uint64_t *stack;
+    void *tb_ptr;
+    void *tci_tb_ptr;
+    uint32_t do_init;
+    void *stack128;
+};
+
+#define ENV_OFF 0
+#define STACK_OFF 4
+#define TB_PTR_OFF 8
+#define HELPER_RET_TB_PTR_OFF 12
+#define DO_INIT_OFF 16
+#define STACK128_OFF 20
+
+int get_core_nums(void);
+
+/*
+ * TB of wasm backend starts from a header which stores pointers for each data
+ * stored in the following region of the TB.
+ */
+struct wasmTBHeader {
+    void *tci_ptr;
+    void *wasm_ptr;
+    int wasm_size;
+    void *import_ptr;
+    int import_size;
+    void *counter_ptr;
+    void *info_ptr;
+};
+
+#endif
diff --git a/tcg/wasm32/tcg-target-con-set.h b/tcg/wasm32/tcg-target-con-set.h
new file mode 100644
index 0000000000..093c8e8c3b
--- /dev/null
+++ b/tcg/wasm32/tcg-target-con-set.h
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+/*
+ * C_On_Im(...) defines a constraint set with <n> outputs and <m> inputs.
+ * Each operand should be a sequence of constraint letters as defined by
+ * tcg-target-con-str.h; the constraint combination is inclusive or.
+ */
+C_O0_I1(r)
+C_O0_I2(r, r)
+C_O0_I3(r, r, r)
+C_O0_I4(r, r, r, r)
+C_O1_I1(r, r)
+C_O1_I2(r, r, r)
+C_O1_I4(r, r, r, r, r)
+C_O2_I1(r, r, r)
+C_O2_I2(r, r, r, r)
+C_O2_I4(r, r, r, r, r, r)
diff --git a/tcg/wasm32/tcg-target-con-str.h b/tcg/wasm32/tcg-target-con-str.h
new file mode 100644
index 0000000000..f17f2e850f
--- /dev/null
+++ b/tcg/wasm32/tcg-target-con-str.h
@@ -0,0 +1,8 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+/*
+ * Define constraint letters for register sets:
+ * REGS(letter, register_mask)
+ */
+REGS('r', MAKE_64BIT_MASK(0, TCG_TARGET_NB_REGS))
diff --git a/tcg/wasm32/tcg-target-has.h b/tcg/wasm32/tcg-target-has.h
new file mode 100644
index 0000000000..124d6bd54c
--- /dev/null
+++ b/tcg/wasm32/tcg-target-has.h
@@ -0,0 +1,102 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2009, 2011 Stefan Weil
+ *
+ * Based on tci/tcg-target.h
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+#define TCG_TARGET_HAS_bswap16_i32      1
+#define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_div_i32          1
+#define TCG_TARGET_HAS_rem_i32          1
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_ext8u_i32        1
+#define TCG_TARGET_HAS_ext16u_i32       1
+#define TCG_TARGET_HAS_andc_i32         1
+#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_eqv_i32          1
+#define TCG_TARGET_HAS_nand_i32         1
+#define TCG_TARGET_HAS_nor_i32          1
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          1
+#define TCG_TARGET_HAS_ctpop_i32        1
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_orc_i32          1
+#define TCG_TARGET_HAS_rot_i32          1
+#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_muls2_i32        1
+#define TCG_TARGET_HAS_muluh_i32        0
+#define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+
+#define TCG_TARGET_HAS_extr_i64_i32     0
+#define TCG_TARGET_HAS_extrl_i64_i32    1
+#define TCG_TARGET_HAS_extrh_i64_i32    0
+#define TCG_TARGET_HAS_bswap16_i64      1
+#define TCG_TARGET_HAS_bswap32_i64      1
+#define TCG_TARGET_HAS_bswap64_i64      1
+#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          1
+#define TCG_TARGET_HAS_ext8s_i64        1
+#define TCG_TARGET_HAS_ext16s_i64       1
+#define TCG_TARGET_HAS_ext32s_i64       1
+#define TCG_TARGET_HAS_ext8u_i64        1
+#define TCG_TARGET_HAS_ext16u_i64       1
+#define TCG_TARGET_HAS_ext32u_i64       1
+#define TCG_TARGET_HAS_andc_i64         1
+#define TCG_TARGET_HAS_eqv_i64          1
+#define TCG_TARGET_HAS_nand_i64         1
+#define TCG_TARGET_HAS_nor_i64          1
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          1
+#define TCG_TARGET_HAS_ctpop_i64        1
+#define TCG_TARGET_HAS_not_i64          1
+#define TCG_TARGET_HAS_orc_i64          1
+#define TCG_TARGET_HAS_rot_i64          1
+#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_mulu2_i32        1
+#define TCG_TARGET_HAS_add2_i64         1
+#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        0
+#define TCG_TARGET_HAS_mulsh_i64        0
+
+#define TCG_TARGET_HAS_qemu_ldst_i128 0
+
+#define TCG_TARGET_HAS_tst              0
+
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_sextract_valid(type, ofs, len)  1
+#define TCG_TARGET_deposit_valid(type, ofs, len)   1
+
+#endif /* TCG_TARGET_H */
diff --git a/tcg/wasm32/tcg-target-mo.h b/tcg/wasm32/tcg-target-mo.h
new file mode 100644
index 0000000000..0865185c9a
--- /dev/null
+++ b/tcg/wasm32/tcg-target-mo.h
@@ -0,0 +1,12 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+/*
+ * Define target-specific memory model
+ */
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+#define TCG_TARGET_DEFAULT_MO  0
+
+#endif
diff --git a/tcg/wasm32/tcg-target-opc.h.inc b/tcg/wasm32/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..ecc8c4e55e
--- /dev/null
+++ b/tcg/wasm32/tcg-target-opc.h.inc
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: MIT */
+/* These opcodes for use between the tci generator and interpreter. */
+DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/wasm32/tcg-target-reg-bits.h b/tcg/wasm32/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..4f60ae9166
--- /dev/null
+++ b/tcg/wasm32/tcg-target-reg-bits.h
@@ -0,0 +1,12 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+/*
+ * Define target-specific register size
+ */
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+#define TCG_TARGET_REG_BITS  64
+
+#endif
diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
new file mode 100644
index 0000000000..6a31d33f71
--- /dev/null
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -0,0 +1,4484 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2018 SiFive, Inc
+ * Copyright (c) 2008-2009 Arnaud Patard <arnaud.patard@rtp-net.org>
+ * Copyright (c) 2009 Aurelien Jarno <aurelien@aurel32.net>
+ * Copyright (c) 2008 Fabrice Bellard
+ * Copyright (c) 2009, 2011 Stefan Weil
+ *
+ * Based on riscv/tcg-target.c.inc and tci/tcg-target.c
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qapi/error.h"
+#include <emscripten.h>
+#include <ffi.h>
+#include "../wasm32.h"
+
+/* Used for function call generation. */
+#define TCG_TARGET_CALL_STACK_OFFSET    0
+#define TCG_TARGET_STACK_ALIGN          8
+#define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_RET_I128       TCG_CALL_RET_NORMAL
+
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
+{
+    switch (op) {
+    case INDEX_op_goto_ptr:
+        return C_O0_I1(r);
+
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld_i32:
+    case INDEX_op_ld8u_i64:
+    case INDEX_op_ld8s_i64:
+    case INDEX_op_ld16u_i64:
+    case INDEX_op_ld16s_i64:
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld32s_i64:
+    case INDEX_op_ld_i64:
+    case INDEX_op_not_i32:
+    case INDEX_op_not_i64:
+    case INDEX_op_neg_i32:
+    case INDEX_op_neg_i64:
+    case INDEX_op_ext8s_i32:
+    case INDEX_op_ext8s_i64:
+    case INDEX_op_ext16s_i32:
+    case INDEX_op_ext16s_i64:
+    case INDEX_op_ext8u_i32:
+    case INDEX_op_ext8u_i64:
+    case INDEX_op_ext16u_i32:
+    case INDEX_op_ext16u_i64:
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext32u_i64:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
+    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap32_i32:
+    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap64_i64:
+    case INDEX_op_extract_i32:
+    case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i32:
+    case INDEX_op_sextract_i64:
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
+    case INDEX_op_ctpop_i32:
+    case INDEX_op_ctpop_i64:
+        return C_O1_I1(r, r);
+
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i64:
+        return C_O0_I2(r, r);
+
+    case INDEX_op_div_i32:
+    case INDEX_op_div_i64:
+    case INDEX_op_divu_i32:
+    case INDEX_op_divu_i64:
+    case INDEX_op_rem_i32:
+    case INDEX_op_rem_i64:
+    case INDEX_op_remu_i32:
+    case INDEX_op_remu_i64:
+    case INDEX_op_add_i32:
+    case INDEX_op_add_i64:
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+    case INDEX_op_mul_i32:
+    case INDEX_op_mul_i64:
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
+    case INDEX_op_andc_i32:
+    case INDEX_op_andc_i64:
+    case INDEX_op_eqv_i32:
+    case INDEX_op_eqv_i64:
+    case INDEX_op_nand_i32:
+    case INDEX_op_nand_i64:
+    case INDEX_op_nor_i32:
+    case INDEX_op_nor_i64:
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
+    case INDEX_op_orc_i32:
+    case INDEX_op_orc_i64:
+    case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
+    case INDEX_op_shl_i32:
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i32:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i32:
+    case INDEX_op_sar_i64:
+    case INDEX_op_rotl_i32:
+    case INDEX_op_rotl_i64:
+    case INDEX_op_rotr_i32:
+    case INDEX_op_rotr_i64:
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+    case INDEX_op_deposit_i32:
+    case INDEX_op_deposit_i64:
+    case INDEX_op_clz_i32:
+    case INDEX_op_clz_i64:
+    case INDEX_op_ctz_i32:
+    case INDEX_op_ctz_i64:
+        return C_O1_I2(r, r, r);
+
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        return C_O0_I2(r, r);
+
+    case INDEX_op_add2_i32:
+    case INDEX_op_add2_i64:
+    case INDEX_op_sub2_i32:
+    case INDEX_op_sub2_i64:
+        return C_O2_I4(r, r, r, r, r, r);
+
+    case INDEX_op_mulu2_i32:
+    case INDEX_op_mulu2_i64:
+    case INDEX_op_muls2_i32:
+    case INDEX_op_muls2_i64:
+        return C_O2_I2(r, r, r, r);
+
+    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond_i64:
+        return C_O1_I4(r, r, r, r, r);
+
+    case INDEX_op_setcond2_i32:
+        return C_O1_I4(r, r, r, r, r);
+    case INDEX_op_brcond2_i32:
+        return C_O0_I4(r, r, r, r);
+
+    case INDEX_op_qemu_ld_i32:
+        return C_O1_I1(r, r);
+
+    case INDEX_op_qemu_ld_i64:
+        return C_O1_I1(r, r);
+    case INDEX_op_qemu_st_i32:
+        return C_O0_I2(r, r);
+    case INDEX_op_qemu_st_i64:
+        return C_O0_I2(r, r);
+
+    case INDEX_op_muluh_i32:
+    case INDEX_op_mulsh_i32:
+        return C_O1_I2(r, r, r);
+    case INDEX_op_extract2_i32:
+    case INDEX_op_extract2_i64:
+        return C_O1_I2(r, r, r);
+
+    default:
+        return C_NotImplemented;
+    }
+}
+
+static const int tcg_target_reg_alloc_order[TCG_TARGET_NB_REGS] = {
+    TCG_REG_R0,
+    TCG_REG_R1,
+    TCG_REG_R2,
+    TCG_REG_R3,
+    TCG_REG_R4,
+    TCG_REG_R5,
+    TCG_REG_R6,
+    TCG_REG_R7,
+    TCG_REG_R8,
+    TCG_REG_R9,
+    TCG_REG_R10,
+    TCG_REG_R11,
+    TCG_REG_R12,
+    TCG_REG_R13,
+    TCG_REG_R14,
+    TCG_REG_R15,
+};
+
+#define NUM_OF_IARG_REGS 5
+static const int tcg_target_call_iarg_regs[NUM_OF_IARG_REGS] = {
+   TCG_REG_R8,
+   TCG_REG_R9,
+   TCG_REG_R10,
+   TCG_REG_R11,
+   TCG_REG_R12,
+};
+
+static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
+{
+    tcg_debug_assert(kind == TCG_CALL_RET_NORMAL);
+    tcg_debug_assert(slot >= 0 && slot < 128 / TCG_TARGET_REG_BITS);
+    return TCG_REG_R0 + slot;
+}
+
+#ifdef CONFIG_DEBUG_TCG
+static const char *const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
+    "r00",
+    "r01",
+    "r02",
+    "r03",
+    "r04",
+    "r05",
+    "r06",
+    "r07",
+    "r08",
+    "r09",
+    "r10",
+    "r11",
+    "r12",
+    "r13",
+    "r14",
+    "r15",
+};
+#endif
+
+#define REG_INDEX_IARG_BASE 8
+static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
+    0,  /* TCG_REG_R0 */
+    1,  /* TCG_REG_R1 */
+    2,  /* TCG_REG_R2 */
+    3,  /* TCG_REG_R3 */
+    4,  /* TCG_REG_R4 */
+    5,  /* TCG_REG_R5 */
+    6,  /* TCG_REG_R6 */
+    7,  /* TCG_REG_R7 */
+    8,  /* TCG_REG_R8 */
+    9,  /* TCG_REG_R9 */
+    10, /* TCG_REG_R10 */
+    11, /* TCG_REG_R11 */
+    12, /* TCG_REG_R12 */
+    13, /* TCG_REG_R13 */
+    14, /* TCG_REG_R14 */
+    15, /* TCG_REG_R15 */
+};
+
+#define BLOCK_PTR_IDX 16
+
+#define CTX_IDX 0
+#define TMP32_LOCAL_0_IDX 1
+#define TMP32_LOCAL_1_IDX 2
+#define TMP64_LOCAL_0_IDX 3
+
+/* function index */
+#define CHECK_UNWINDING_IDX 0 /* a funtion of checking Asyncify status */
+#define HELPER_IDX_START    1 /* other helper funcitons */
+
+/* Test if a constant matches the constraint. */
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
+{
+    return ct & TCG_CT_CONST;
+}
+
+static void fill_uint32_leb128(uint8_t *b, uint32_t v)
+{
+    uint32_t low7 = 0x7f;
+    do {
+        *b |= v & low7;
+        v >>= 7;
+        b++;
+    } while (v != 0);
+}
+
+static int write_uint32_leb128(uint8_t *b, uint32_t v)
+{
+    uint8_t *base = b;
+    uint32_t low7 = 0x7f;
+    do {
+        *b = (uint8_t)(v & low7);
+        v >>= 7;
+        if (v != 0) {
+            *b |= 0x80;
+        }
+        b++;
+    } while (v != 0);
+
+    return (int)(b - base);
+}
+
+#define BUF_MAX 4096
+typedef struct LinkedBuf {
+    struct LinkedBuf *next;
+    uint8_t data[BUF_MAX];
+    uint32_t size;
+} LinkedBuf;
+
+static LinkedBuf *new_linked_buf(void)
+{
+    LinkedBuf *p = tcg_malloc(sizeof(LinkedBuf));
+    p->size = 0;
+    p->next = NULL;
+    return p;
+}
+
+static inline LinkedBuf *linked_buf_out8(LinkedBuf *buf, uint8_t v)
+{
+    if (buf->size == BUF_MAX) {
+        buf->next = new_linked_buf();
+        buf = buf->next;
+    }
+    *(buf->data + buf->size++) = v;
+    return buf;
+}
+
+static inline int linked_buf_len(LinkedBuf *buf)
+{
+    int total = 0;
+    for (LinkedBuf *p = buf; p; p = p->next) {
+        total += p->size;
+    }
+    return total;
+}
+
+static inline void linked_buf_write(LinkedBuf *buf, void *dst)
+{
+    for (LinkedBuf *p = buf; p; p = p->next) {
+        memcpy(dst, p->data, p->size);
+        dst += p->size;
+    }
+}
+
+/*
+ * wasm code is generataed in the dynamically allocated buffer which
+ * are managed as a linked list.
+ */
+__thread LinkedBuf *sub_buf_root;
+__thread LinkedBuf *sub_buf_cur;
+
+static void init_sub_buf(void)
+{
+    sub_buf_root = new_linked_buf();
+    sub_buf_cur = sub_buf_root;
+}
+
+static inline int sub_buf_len(void)
+{
+    return linked_buf_len(sub_buf_root);
+}
+
+static inline void tcg_wasm_out8(TCGContext *s, uint32_t v)
+{
+    sub_buf_cur = linked_buf_out8(sub_buf_cur, v);
+}
+
+static void tcg_wasm_out_leb128_sint32_t(TCGContext *s, int32_t v)
+{
+    bool more = true;
+    uint8_t b;
+    uint32_t low7 = 0x7f;
+    while (more) {
+        b = v & low7;
+        v >>= 7;
+        if (((v == 0) && ((b & 0x40) == 0)) ||
+            ((v == -1) && ((b & 0x40) != 0))) {
+            more = false;
+        } else {
+            b |= 0x80;
+        }
+        tcg_wasm_out8(s, b);
+    }
+}
+
+static void tcg_wasm_out_leb128_sint64_t(TCGContext *s, int64_t v)
+{
+    bool more = true;
+    uint8_t b;
+    uint64_t low7 = 0x7f;
+    while (more) {
+        b = v & low7;
+        v >>= 7;
+        if (((v == 0) && ((b & 0x40) == 0)) ||
+            ((v == -1) && ((b & 0x40) != 0))) {
+            more = false;
+        } else {
+            b |= 0x80;
+        }
+        tcg_wasm_out8(s, b);
+    }
+}
+
+static void tcg_wasm_out_leb128_uint32_t(TCGContext *s, uint32_t v)
+{
+    uint32_t low7 = 0x7f;
+    uint8_t b;
+    do {
+        b = v & low7;
+        v >>= 7;
+        if (v != 0) {
+            b |= 0x80;
+        }
+        tcg_wasm_out8(s, b);
+    } while (v != 0);
+}
+
+static void tcg_wasm_out_op_br(TCGContext *s, int i)
+{
+    tcg_wasm_out8(s, 0x0c);
+    tcg_wasm_out8(s, i);
+}
+
+static void tcg_wasm_out_op_loop_noret(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x03);
+    tcg_wasm_out8(s, 0x40);
+}
+
+static void tcg_wasm_out_op_if_noret(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x04);
+    tcg_wasm_out8(s, 0x40);
+}
+
+static void tcg_wasm_out_op_if_ret_i64(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x04);
+    tcg_wasm_out8(s, 0x7e);
+}
+
+static void tcg_wasm_out_op_if_ret_i32(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x04);
+    tcg_wasm_out8(s, 0x7f);
+}
+
+static void tcg_wasm_out_op_else(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x05);
+}
+
+static void tcg_wasm_out_op_end(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x0b);
+}
+
+
+static void tcg_wasm_out_op_i32_eqz(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x45);
+}
+static void tcg_wasm_out_op_i32_eq(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x46);
+}
+static void tcg_wasm_out_op_i32_and(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x71);
+}
+static void tcg_wasm_out_op_i32_or(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x72);
+}
+static void tcg_wasm_out_op_i32_shl(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x74);
+}
+static void tcg_wasm_out_op_i32_shr_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x75);
+}
+static void tcg_wasm_out_op_i32_shr_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x76);
+}
+static void tcg_wasm_out_op_i32_rotl(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x77);
+}
+static void tcg_wasm_out_op_i32_rotr(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x78);
+}
+static void tcg_wasm_out_op_i32_clz(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x67);
+}
+static void tcg_wasm_out_op_i32_ctz(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x68);
+}
+static void tcg_wasm_out_op_i32_popcnt(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x69);
+}
+static void tcg_wasm_out_op_i32_add(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x6a);
+}
+static void tcg_wasm_out_op_i32_ne(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x47);
+}
+static void tcg_wasm_out_op_i64_eqz(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x50);
+}
+static void tcg_wasm_out_op_i64_eq(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x51);
+}
+static void tcg_wasm_out_op_i64_and(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x83);
+}
+static void tcg_wasm_out_op_i64_or(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x84);
+}
+static void tcg_wasm_out_op_i64_xor(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x85);
+}
+static void tcg_wasm_out_op_i64_shl(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x86);
+}
+static void tcg_wasm_out_op_i64_shr_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x87);
+}
+static void tcg_wasm_out_op_i64_shr_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x88);
+}
+static void tcg_wasm_out_op_i64_rotl(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x89);
+}
+static void tcg_wasm_out_op_i64_rotr(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x8a);
+}
+static void tcg_wasm_out_op_i64_clz(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x79);
+}
+static void tcg_wasm_out_op_i64_ctz(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x7a);
+}
+static void tcg_wasm_out_op_i64_popcnt(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x7b);
+}
+static void tcg_wasm_out_op_i64_add(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x7c);
+}
+static void tcg_wasm_out_op_i64_sub(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x7d);
+}
+static void tcg_wasm_out_op_i64_mul(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x7e);
+}
+static void tcg_wasm_out_op_i64_div_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x7f);
+}
+static void tcg_wasm_out_op_i64_div_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x80);
+}
+static void tcg_wasm_out_op_i64_rem_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x81);
+}
+static void tcg_wasm_out_op_i64_rem_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x82);
+}
+static void tcg_wasm_out_op_i64_le_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x58);
+}
+static void tcg_wasm_out_op_i64_lt_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x54);
+}
+static void tcg_wasm_out_op_i64_gt_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x56);
+}
+
+static void tcg_wasm_out_op_i32_wrap_i64(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0xa7);
+}
+
+static void tcg_wasm_out_op_var(TCGContext *s, uint8_t instr, uint8_t i)
+{
+    tcg_wasm_out8(s, instr);
+    tcg_wasm_out8(s, i);
+}
+
+static void tcg_wasm_out_op_local_get(TCGContext *s, uint8_t i)
+{
+    tcg_wasm_out_op_var(s, 0x20, i);
+}
+
+static void tcg_wasm_out_op_local_set(TCGContext *s, uint8_t i)
+{
+    tcg_wasm_out_op_var(s, 0x21, i);
+}
+
+static void tcg_wasm_out_op_local_tee(TCGContext *s, uint8_t i)
+{
+    tcg_wasm_out_op_var(s, 0x22, i);
+}
+
+static void tcg_wasm_out_op_global_get(TCGContext *s, uint8_t i)
+{
+    tcg_wasm_out_op_var(s, 0x23, i);
+}
+
+static void tcg_wasm_out_op_global_set(TCGContext *s, uint8_t i)
+{
+    tcg_wasm_out_op_var(s, 0x24, i);
+}
+
+static void tcg_wasm_out_op_global_get_r_i32(TCGContext *s, TCGReg r0)
+{
+    tcg_wasm_out_op_global_get(s, tcg_target_reg_index[r0]);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+}
+
+static void tcg_wasm_out_op_global_get_r(TCGContext *s, TCGReg r0)
+{
+    tcg_wasm_out_op_global_get(s, tcg_target_reg_index[r0]);
+}
+
+static void tcg_wasm_out_op_global_set_r(TCGContext *s, TCGReg r0)
+{
+    tcg_wasm_out_op_global_set(s, tcg_target_reg_index[r0]);
+}
+
+static void tcg_wasm_out_op_i32_const(TCGContext *s, int32_t v)
+{
+    tcg_wasm_out8(s, 0x41);
+    tcg_wasm_out_leb128_sint32_t(s, v);
+}
+
+static void tcg_wasm_out_op_i64_const(TCGContext *s, int64_t v)
+{
+    tcg_wasm_out8(s, 0x42);
+    tcg_wasm_out_leb128_sint64_t(s, v);
+}
+
+static void tcg_wasm_out_op_loadstore(
+    TCGContext *s, uint8_t instr, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out8(s, instr);
+    tcg_wasm_out_leb128_uint32_t(s, a);
+    tcg_wasm_out_leb128_uint32_t(s, o);
+}
+
+static void tcg_wasm_out_op_i64_store(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x37, a, o);
+}
+
+static void tcg_wasm_out_op_i32_store(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x36, a, o);
+}
+
+static void tcg_wasm_out_op_i64_store8(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x3c, a, o);
+}
+
+static void tcg_wasm_out_op_i64_store16(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x3d, a, o);
+}
+
+static void tcg_wasm_out_op_i64_store32(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x3e, a, o);
+}
+
+static void tcg_wasm_out_op_i64_load(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x29, a, o);
+}
+
+static void tcg_wasm_out_op_i32_load(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x28, a, o);
+}
+
+ static void tcg_wasm_out_op_i64_load8_s(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x30, a, o);
+}
+
+static void tcg_wasm_out_op_i64_load8_u(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x31, a, o);
+}
+
+static void tcg_wasm_out_op_i64_load16_s(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x32, a, o);
+}
+
+static void tcg_wasm_out_op_i64_load16_u(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x33, a, o);
+}
+
+static void tcg_wasm_out_op_i64_load32_u(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x35, a, o);
+}
+
+static void tcg_wasm_out_op_i64_load32_s(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x34, a, o);
+}
+
+static void tcg_wasm_out_op_return(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x0f);
+}
+
+static void tcg_wasm_out_op_call(TCGContext *s, uint32_t func_idx)
+{
+    tcg_wasm_out8(s, 0x10);
+    tcg_wasm_out_leb128_uint32_t(s, func_idx);
+}
+
+static void tcg_wasm_out_op_i64_extend_i32_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0xad);
+}
+
+static void tcg_wasm_out_op_i64_extend_i32_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0xac);
+}
+
+static void tcg_wasm_out_op_i64_extend8_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0xc2);
+}
+
+static void tcg_wasm_out_op_i64_extend16_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0xc3);
+}
+
+static void tcg_wasm_out_op_not(TCGContext *s)
+{
+    tcg_wasm_out_op_i64_const(s, -1);
+    tcg_wasm_out_op_i64_xor(s);
+}
+
+static void tcg_wasm_out_op_set_r_as_i64(TCGContext *s, TCGReg al, TCGReg ah)
+{
+    tcg_wasm_out_op_local_set(s, TMP64_LOCAL_0_IDX);
+
+    /* set lower bits */
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 0xffffffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, al);
+
+    /* set higher bits */
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 32);
+    tcg_wasm_out_op_i64_shr_u(s);
+    tcg_wasm_out_op_i64_const(s, 0xffffffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, ah);
+}
+
+static const struct {
+    uint8_t i32;
+    uint8_t i64;
+} tcg_cond_to_inst[] = {
+    [TCG_COND_EQ] =  { 0x46 /* i32.eq */   , 0x51 /* i64.eq */},
+    [TCG_COND_NE] =  { 0x47 /* i32.ne */   , 0x52 /* i64.ne */},
+    [TCG_COND_LT] =  { 0x48 /* i32.lt_s */ , 0x53 /* i64.lt_s */},
+    [TCG_COND_GE] =  { 0x4e /* i32.ge_s */ , 0x59 /* i64.ge_s */},
+    [TCG_COND_LE] =  { 0x4c /* i32.le_s */ , 0x57 /* i64.le_s */},
+    [TCG_COND_GT] =  { 0x4a /* i32.gt_s */ , 0x55 /* i64.gt_s */},
+    [TCG_COND_LTU] = { 0x49 /* i32.lt_u */ , 0x54 /* i64.lt_u */},
+    [TCG_COND_GEU] = { 0x4f /* i32.ge_u */ , 0x5a /* i64.ge_u */},
+    [TCG_COND_LEU] = { 0x4d /* i32.le_u */ , 0x58 /* i64.le_u */},
+    [TCG_COND_GTU] = { 0x4b /* i32.gt_u */ , 0x56 /* i64.gt_u */}
+};
+
+static void tcg_wasm_out_op_cond_i64(
+    TCGContext *s, TCGCond cond, TCGReg arg1, TCGReg arg2)
+{
+    uint8_t op = tcg_cond_to_inst[cond].i64;
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out8(s, op);
+}
+
+static void tcg_wasm_out_op_cond_i32(
+    TCGContext *s, TCGCond cond, TCGReg arg1, TCGReg arg2)
+{
+    uint8_t op = tcg_cond_to_inst[cond].i32;
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out8(s, op);
+}
+
+#define tcg_wasm_out_i64_calc(op)                                       \
+    static void tcg_wasm_out_i64_calc_##op(                             \
+        TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)            \
+    {                                                                   \
+        tcg_wasm_out_op_global_get_r(s, arg1);                          \
+        tcg_wasm_out_op_global_get_r(s, arg2);                          \
+        tcg_wasm_out_op_i64_##op(s);                                    \
+        tcg_wasm_out_op_global_set_r(s, ret);                           \
+    }
+tcg_wasm_out_i64_calc(and);
+tcg_wasm_out_i64_calc(or);
+tcg_wasm_out_i64_calc(xor);
+tcg_wasm_out_i64_calc(rotl);
+tcg_wasm_out_i64_calc(rotr);
+tcg_wasm_out_i64_calc(add);
+tcg_wasm_out_i64_calc(sub);
+tcg_wasm_out_i64_calc(mul);
+
+static void tcg_wasm_out_rem_s(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_i64_rem_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_rem_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_rem_u(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i64_const(s, 0xffffffff);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_const(s, 0xffffffff);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_i64_rem_u(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_rem_u(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_div_s(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_i64_div_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_div_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_div_u(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i64_const(s, 0xffffffff);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_const(s, 0xffffffff);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_i64_div_u(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_div_u(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_shl(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i64_const(s, 0xffffffff);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_const(s, 31);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_i64_shl(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_shl(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_shr_u(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i64_const(s, 0xffffffff);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_const(s, 31);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_i64_shr_u(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_shr_u(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_shr_s(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_const(s, 31);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_i64_shr_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_shr_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+static void tcg_wasm_out_i32_rotl(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i32_rotl(s);
+    tcg_wasm_out_op_i64_extend_i32_s(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_i32_rotr(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i32_rotr(s);
+    tcg_wasm_out_op_i64_extend_i32_s(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_clz64(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i64_eqz(s);
+    tcg_wasm_out_op_if_ret_i64(s);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_else(s);
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i64_clz(s);
+    tcg_wasm_out_op_end(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_clz32(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i64_eqz(s);
+    tcg_wasm_out_op_if_ret_i32(s);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_else(s);
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i32_clz(s);
+    tcg_wasm_out_op_end(s);
+    tcg_wasm_out_op_i64_extend_i32_s(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_ctz64(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i64_eqz(s);
+    tcg_wasm_out_op_if_ret_i64(s);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_else(s);
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i64_ctz(s);
+    tcg_wasm_out_op_end(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_ctz32(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i64_eqz(s);
+    tcg_wasm_out_op_if_ret_i32(s);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_else(s);
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i32_ctz(s);
+    tcg_wasm_out_op_end(s);
+    tcg_wasm_out_op_i64_extend_i32_s(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_not(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_global_get_r(s, arg);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_andc(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_orc(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_i64_or(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_eqv(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i64_xor(s);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_nand(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_nor(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i64_or(s);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_neg(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_global_get_r(s, arg);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_i64_const(s, 1);
+    tcg_wasm_out_op_i64_add(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_ld(
+    TCGContext *s, TCGType type, TCGReg val, TCGReg base, intptr_t offset)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r_i32(s, base);
+        if ((int32_t)offset < 0) {
+            tcg_wasm_out_op_i32_const(s, (int32_t)offset);
+            tcg_wasm_out_op_i32_add(s);
+            offset = 0;
+        }
+        tcg_wasm_out_op_i64_load32_u(s, 0, (uint32_t)offset);
+        tcg_wasm_out_op_global_set_r(s, val);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r_i32(s, base);
+        if ((int32_t)offset < 0) {
+            tcg_wasm_out_op_i32_const(s, (int32_t)offset);
+            tcg_wasm_out_op_i32_add(s);
+            offset = 0;
+        }
+        tcg_wasm_out_op_i64_load(s, 0, (uint32_t)offset);
+        tcg_wasm_out_op_global_set_r(s, val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_ld8s(
+    TCGContext *s, TCGType type, TCGReg val, TCGReg base, intptr_t offset)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r_i32(s, base);
+        if ((int32_t)offset < 0) {
+            tcg_wasm_out_op_i32_const(s, (int32_t)offset);
+            tcg_wasm_out_op_i32_add(s);
+            offset = 0;
+        }
+        tcg_wasm_out_op_i64_load8_s(s, 0, (uint32_t)offset);
+        tcg_wasm_out_op_global_set_r(s, val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_ld8u(
+    TCGContext *s, TCGType type, TCGReg val, TCGReg base, intptr_t offset)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r_i32(s, base);
+        if ((int32_t)offset < 0) {
+            tcg_wasm_out_op_i32_const(s, (int32_t)offset);
+            tcg_wasm_out_op_i32_add(s);
+            offset = 0;
+        }
+        tcg_wasm_out_op_i64_load8_u(s, 0, (uint32_t)offset);
+        tcg_wasm_out_op_global_set_r(s, val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_ld16s(
+    TCGContext *s, TCGType type, TCGReg val, TCGReg base, intptr_t offset)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r_i32(s, base);
+        if ((int32_t)offset < 0) {
+            tcg_wasm_out_op_i32_const(s, (int32_t)offset);
+            tcg_wasm_out_op_i32_add(s);
+            offset = 0;
+        }
+        tcg_wasm_out_op_i64_load16_s(s, 0, (uint32_t)offset);
+        tcg_wasm_out_op_global_set_r(s, val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_ld16u(
+    TCGContext *s, TCGType type, TCGReg val, TCGReg base, intptr_t offset)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r_i32(s, base);
+        if ((int32_t)offset < 0) {
+            tcg_wasm_out_op_i32_const(s, (int32_t)offset);
+            tcg_wasm_out_op_i32_add(s);
+            offset = 0;
+        }
+        tcg_wasm_out_op_i64_load16_u(s, 0, (uint32_t)offset);
+        tcg_wasm_out_op_global_set_r(s, val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_ld32s(
+    TCGContext *s, TCGType type, TCGReg val, TCGReg base, intptr_t offset)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r_i32(s, base);
+        if ((int32_t)offset < 0) {
+            tcg_wasm_out_op_i32_const(s, (int32_t)offset);
+            tcg_wasm_out_op_i32_add(s);
+            offset = 0;
+        }
+        tcg_wasm_out_op_i64_load32_s(s, 0, (uint32_t)offset);
+        tcg_wasm_out_op_global_set_r(s, val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_ld32u(TCGContext *s, TCGType type, TCGReg val,
+                               TCGReg base, intptr_t offset)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r_i32(s, base);
+        if ((int32_t)offset < 0) {
+            tcg_wasm_out_op_i32_const(s, (int32_t)offset);
+            tcg_wasm_out_op_i32_add(s);
+            offset = 0;
+        }
+        tcg_wasm_out_op_i64_load32_u(s, 0, (uint32_t)offset);
+        tcg_wasm_out_op_global_set_r(s, val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_st(TCGContext *s, TCGType type, TCGReg val,
+                            TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_global_get_r_i32(s, base);
+    if ((int32_t)offset < 0) {
+        tcg_wasm_out_op_i32_const(s, (int32_t)offset);
+        tcg_wasm_out_op_i32_add(s);
+        offset = 0;
+    }
+    tcg_wasm_out_op_global_get_r(s, val);
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_i64_store32(s, 0, (uint32_t)offset);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_i64_store(s, 0, (uint32_t)offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_st8(TCGContext *s, TCGType type, TCGReg val,
+                             TCGReg base, intptr_t offset)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r_i32(s, base);
+        if ((int32_t)offset < 0) {
+            tcg_wasm_out_op_i32_const(s, (int32_t)offset);
+            tcg_wasm_out_op_i32_add(s);
+            offset = 0;
+        }
+        tcg_wasm_out_op_global_get_r(s, val);
+        tcg_wasm_out_op_i64_store8(s, 0, (uint32_t)offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_st16(TCGContext *s, TCGType type, TCGReg val,
+                              TCGReg base, intptr_t offset)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r_i32(s, base);
+        if ((int32_t)offset < 0) {
+            tcg_wasm_out_op_i32_const(s, (int32_t)offset);
+            tcg_wasm_out_op_i32_add(s);
+            offset = 0;
+        }
+        tcg_wasm_out_op_global_get_r(s, val);
+        tcg_wasm_out_op_i64_store16(s, 0, (uint32_t)offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_st32(TCGContext *s, TCGType type, TCGReg val,
+                              TCGReg base, intptr_t offset)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r_i32(s, base);
+        if ((int32_t)offset < 0) {
+            tcg_wasm_out_op_i32_const(s, (int32_t)offset);
+            tcg_wasm_out_op_i32_add(s);
+            offset = 0;
+        }
+        tcg_wasm_out_op_global_get_r(s, val);
+        tcg_wasm_out_op_i64_store32(s, 0, (uint32_t)offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static inline bool tcg_wasm_out_sti(TCGContext *s, TCGType type, TCGArg val,
+                               TCGReg base, intptr_t offset)
+{
+    return false;
+}
+
+static bool tcg_wasm_out_mov(TCGContext *s, TCGType type, TCGReg ret,
+                             TCGReg arg)
+{
+   switch (type) {
+   case TCG_TYPE_I32:
+       tcg_wasm_out_op_global_get_r(s, arg);
+       tcg_wasm_out_op_i32_wrap_i64(s);
+       tcg_wasm_out_op_i64_extend_i32_u(s);
+       tcg_wasm_out_op_global_set_r(s, ret);
+       break;
+   case TCG_TYPE_I64:
+       tcg_wasm_out_op_global_get_r(s, arg);
+       tcg_wasm_out_op_global_set_r(s, ret);
+       break;
+   default:
+       g_assert_not_reached();
+   }
+    return true;
+}
+
+static void tcg_wasm_out_movi(TCGContext *s, TCGType type,
+                              TCGReg ret, tcg_target_long arg)
+{
+   switch (type) {
+   case TCG_TYPE_I32:
+       tcg_wasm_out_op_i64_const(s, (int32_t)arg);
+       break;
+   case TCG_TYPE_I64:
+       tcg_wasm_out_op_i64_const(s, arg);
+       break;
+   default:
+       g_assert_not_reached();
+   }
+   tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_ext8s(TCGContext *s, TCGType type,
+                               TCGReg rd, TCGReg rs)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, rs);
+        tcg_wasm_out_op_i64_extend8_s(s);
+        tcg_wasm_out_op_global_set_r(s, rd);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_op_global_get_r(s, rs);
+    tcg_wasm_out_op_i64_const(s, 0xff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, rd);
+}
+
+static void tcg_wasm_out_ext16s(TCGContext *s, TCGType type,
+                                TCGReg rd, TCGReg rs)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, rs);
+        tcg_wasm_out_op_i64_extend16_s(s);
+        tcg_wasm_out_op_global_set_r(s, rd);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_op_global_get_r(s, rs);
+    tcg_wasm_out_op_i64_const(s, 0xffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, rd);
+}
+
+static void tcg_wasm_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_op_global_get_r(s, rs);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i64_extend_i32_s(s);
+    tcg_wasm_out_op_global_set_r(s, rd);
+}
+
+static void tcg_wasm_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_op_global_get_r(s, rs);
+    tcg_wasm_out_op_i64_const(s, 0xffffffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, rd);
+}
+
+static void tcg_wasm_out_exts_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_ext32s(s, rd, rs);
+}
+
+static void tcg_wasm_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_ext32u(s, rd, rs);
+}
+
+static void tcg_wasm_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_wasm_out_op_global_get_r(s, rs);
+    tcg_wasm_out_op_i64_const(s, 0xffffffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, rd);
+}
+
+static void tcg_wasm_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
+                            TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_cond_i32(s, cond, arg1, arg2);
+    tcg_wasm_out_op_i64_extend_i32_u(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
+                            TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_cond_i64(s, cond, arg1, arg2);
+    tcg_wasm_out_op_i64_extend_i32_u(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_movcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
+                            TCGReg c1, TCGReg c2, TCGReg v1, TCGReg v2)
+{
+    tcg_wasm_out_op_cond_i32(s, cond, c1, c2);
+    tcg_wasm_out_op_if_ret_i64(s);
+    tcg_wasm_out_op_global_get_r(s, v1);
+    tcg_wasm_out_op_else(s);
+    tcg_wasm_out_op_global_get_r(s, v2);
+    tcg_wasm_out_op_end(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
+                            TCGReg c1, TCGReg c2, TCGReg v1, TCGReg v2)
+{
+    tcg_wasm_out_op_cond_i64(s, cond, c1, c2);
+    tcg_wasm_out_op_if_ret_i64(s);
+    tcg_wasm_out_op_global_get_r(s, v1);
+    tcg_wasm_out_op_else(s);
+    tcg_wasm_out_op_global_get_r(s, v2);
+    tcg_wasm_out_op_end(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+
+static void tcg_wasm_out_add2_i32(TCGContext *s, TCGReg retl, TCGReg reth,
+                                  TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
+{
+    tcg_wasm_out_op_global_get_r(s, al);
+    tcg_wasm_out_op_i64_const(s, 0xffffffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_get_r(s, ah);
+    tcg_wasm_out_op_i64_const(s, 32);
+    tcg_wasm_out_op_i64_shl(s);
+    tcg_wasm_out_op_i64_add(s);
+
+    tcg_wasm_out_op_global_get_r(s, bl);
+    tcg_wasm_out_op_i64_const(s, 0xffffffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_get_r(s, bh);
+    tcg_wasm_out_op_i64_const(s, 32);
+    tcg_wasm_out_op_i64_shl(s);
+    tcg_wasm_out_op_i64_add(s);
+
+    tcg_wasm_out_op_i64_add(s);
+    tcg_wasm_out_op_local_set(s, TMP64_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 32);
+    tcg_wasm_out_op_i64_shr_u(s);
+    tcg_wasm_out_op_global_set_r(s, reth);
+
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 0xffffffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, retl);
+}
+
+static void tcg_wasm_out_add2_i64(TCGContext *s, TCGReg retl, TCGReg reth,
+                                  TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
+{
+    /* add higer */
+    tcg_wasm_out_op_global_get_r(s, ah);
+    tcg_wasm_out_op_global_get_r(s, bh);
+    tcg_wasm_out_op_i64_add(s);
+
+    /* add lower */
+    tcg_wasm_out_op_global_get_r(s, al);
+    tcg_wasm_out_op_global_get_r(s, bl);
+    tcg_wasm_out_op_i64_add(s);
+
+    /* get carry */
+    if ((al == retl) && (bl == retl)) {
+        tcg_wasm_out_op_local_set(s, TMP64_LOCAL_0_IDX);
+        tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+        tcg_wasm_out_op_global_get_r(s, al);
+        tcg_wasm_out_op_i64_lt_u(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+        tcg_wasm_out_op_global_set_r(s, retl);
+    } else {
+        tcg_wasm_out_op_global_set_r(s, retl);
+        tcg_wasm_out_op_global_get_r(s, retl);
+        if (al == retl) {
+            tcg_wasm_out_op_global_get_r(s, bl);
+        } else {
+            tcg_wasm_out_op_global_get_r(s, al);
+        }
+        tcg_wasm_out_op_i64_lt_u(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+    }
+
+    /* add carry to higher */
+    tcg_wasm_out_op_i64_add(s);
+    tcg_wasm_out_op_global_set_r(s, reth);
+}
+
+static void tcg_wasm_out_sub2_i32(TCGContext *s, TCGReg retl, TCGReg reth,
+                                  TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
+{
+    tcg_wasm_out_op_global_get_r(s, al);
+    tcg_wasm_out_op_i64_const(s, 0xffffffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_get_r(s, ah);
+    tcg_wasm_out_op_i64_const(s, 32);
+    tcg_wasm_out_op_i64_shl(s);
+    tcg_wasm_out_op_i64_add(s);
+
+    tcg_wasm_out_op_global_get_r(s, bl);
+    tcg_wasm_out_op_i64_const(s, 0xffffffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_get_r(s, bh);
+    tcg_wasm_out_op_i64_const(s, 32);
+    tcg_wasm_out_op_i64_shl(s);
+    tcg_wasm_out_op_i64_add(s);
+
+    tcg_wasm_out_op_i64_sub(s);
+    tcg_wasm_out_op_local_set(s, TMP64_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 32);
+    tcg_wasm_out_op_i64_shr_u(s);
+    tcg_wasm_out_op_global_set_r(s, reth);
+
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 0xffffffff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, retl);
+}
+
+
+static void tcg_wasm_out_sub2_i64(TCGContext *s, TCGReg retl, TCGReg reth,
+                                  TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
+{
+    /* sub higher */
+    tcg_wasm_out_op_global_get_r(s, ah);
+    tcg_wasm_out_op_global_get_r(s, bh);
+    tcg_wasm_out_op_i64_sub(s);
+
+    /* sub lower */
+    tcg_wasm_out_op_global_get_r(s, al);
+    tcg_wasm_out_op_global_get_r(s, bl);
+    tcg_wasm_out_op_i64_sub(s);
+
+    /* get underflow */
+    if (al == retl) {
+        tcg_wasm_out_op_local_set(s, TMP64_LOCAL_0_IDX);
+
+        tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+        tcg_wasm_out_op_global_get_r(s, al);
+        tcg_wasm_out_op_i64_gt_u(s);
+
+        tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+        tcg_wasm_out_op_global_set_r(s, retl);
+    } else {
+        tcg_wasm_out_op_global_set_r(s, retl);
+
+        tcg_wasm_out_op_global_get_r(s, retl);
+        tcg_wasm_out_op_global_get_r(s, al);
+        tcg_wasm_out_op_i64_gt_u(s);
+    }
+
+    tcg_wasm_out_op_i64_sub(s);
+    tcg_wasm_out_op_global_set_r(s, reth);
+}
+
+static void tcg_wasm_out_mulu2_i32(
+    TCGContext *s, TCGReg retl, TCGReg reth, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i64_mul(s);
+    tcg_wasm_out_op_set_r_as_i64(s, retl, reth);
+}
+
+static void tcg_wasm_out_muls2_i32(
+    TCGContext *s, TCGReg retl, TCGReg reth, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i64_mul(s);
+    tcg_wasm_out_op_set_r_as_i64(s, retl, reth);
+}
+
+static void tcg_wasm_out_ctpop_i32(TCGContext *s, TCGReg dest, TCGReg src)
+{
+    tcg_wasm_out_op_global_get_r(s, src);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i32_popcnt(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_ctpop_i64(TCGContext *s, TCGReg dest, TCGReg src)
+{
+    tcg_wasm_out_op_global_get_r(s, src);
+    tcg_wasm_out_op_i64_popcnt(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_deposit_i32(
+    TCGContext *s, TCGReg dest, TCGReg arg1, TCGReg arg2, int pos, int len)
+{
+    int32_t mask = ((1 << len) - 1) << pos;
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i32_const(s, ~mask);
+    tcg_wasm_out_op_i32_and(s);
+
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i32_const(s, pos);
+    tcg_wasm_out_op_i32_shl(s);
+    tcg_wasm_out_op_i32_const(s, mask);
+    tcg_wasm_out_op_i32_and(s);
+
+    tcg_wasm_out_op_i32_or(s);
+
+    tcg_wasm_out_op_i64_extend_i32_u(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_deposit_i64(
+    TCGContext *s, TCGReg dest, TCGReg arg1, TCGReg arg2, int pos, int len)
+{
+    int64_t mask = (((int64_t)1 << len) - 1) << pos;
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i64_const(s, ~mask);
+    tcg_wasm_out_op_i64_and(s);
+
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i64_const(s, pos);
+    tcg_wasm_out_op_i64_shl(s);
+    tcg_wasm_out_op_i64_const(s, mask);
+    tcg_wasm_out_op_i64_and(s);
+
+    tcg_wasm_out_op_i64_or(s);
+
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_extract(
+    TCGContext *s, TCGReg dest, TCGReg arg1,
+    int pos, int len, TCGType type)
+{
+    int64_t mask;
+    switch (type) {
+    case TCG_TYPE_I32:
+        mask = 0xffffffff >> (32 - len);
+        break;
+    case TCG_TYPE_I64:
+        mask = ~0ULL >> (64 - len);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_i64_const(s, pos);
+    tcg_wasm_out_op_i64_shr_u(s);
+    tcg_wasm_out_op_i64_const(s, mask);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_sextract(
+    TCGContext *s, TCGReg dest, TCGReg arg1,
+    int pos, int len, TCGType type)
+{
+    int rs, sl;
+    switch (type) {
+    case TCG_TYPE_I32:
+        rs = 32 - len;
+        break;
+    case TCG_TYPE_I64:
+        rs = 64 - len;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    sl = rs - pos;
+    if (sl > 0) {
+        tcg_wasm_out_op_i64_const(s, sl);
+        tcg_wasm_out_op_i64_shl(s);
+    }
+    tcg_wasm_out_op_i64_const(s, rs);
+    tcg_wasm_out_op_i64_shr_s(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_bswap64(
+    TCGContext *s, TCGReg dest, TCGReg src, int flags)
+{
+    tcg_wasm_out_op_global_get_r(s, src); /* ABCDEFGH */
+    tcg_wasm_out_op_i64_const(s, 32);
+    tcg_wasm_out_op_i64_rotr(s);
+    tcg_wasm_out_op_local_set(s, TMP64_LOCAL_0_IDX); /* EFGHABCD */
+
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 0xff000000ff000000);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_i64_const(s, 24);
+    tcg_wasm_out_op_i64_shr_u(s);  /* ___E___A */
+
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 0x00ff000000ff0000);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_i64_const(s, 8);
+    tcg_wasm_out_op_i64_shr_u(s); /* __F___B_ */
+
+    tcg_wasm_out_op_i64_or(s);
+
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 0x0000ff000000ff00);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_i64_const(s, 8);
+    tcg_wasm_out_op_i64_shl(s); /* _G___C__ */
+
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 0x000000ff000000ff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_i64_const(s, 24);
+    tcg_wasm_out_op_i64_shl(s); /* H___D___ */
+
+    tcg_wasm_out_op_i64_or(s);
+
+    tcg_wasm_out_op_i64_or(s); /* HGFEDCBA */
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_bswap32(
+    TCGContext *s, TCGReg dest, TCGReg src, int flags)
+{
+    tcg_wasm_out_op_global_get_r(s, src);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX); /* ABCD */
+    tcg_wasm_out_op_i32_const(s, 16);
+    tcg_wasm_out_op_i32_rotr(s);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_0_IDX); /* CDAB */
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, 0xff00ff00);
+    tcg_wasm_out_op_i32_and(s);
+    tcg_wasm_out_op_i32_const(s, 8);
+    tcg_wasm_out_op_i32_shr_u(s); /* _C_A */
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, 0x00ff00ff);
+    tcg_wasm_out_op_i32_and(s);
+    tcg_wasm_out_op_i32_const(s, 8);
+    tcg_wasm_out_op_i32_shl(s); /* D_B_ */
+
+    tcg_wasm_out_op_i32_or(s); /* DCBA */
+    tcg_wasm_out_op_i64_extend_i32_u(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_bswap16(
+    TCGContext *s, TCGReg dest, TCGReg src, int flags)
+{
+    tcg_wasm_out_op_global_get_r(s, src);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX); /* __AB */
+    tcg_wasm_out_op_i32_const(s, 8);
+    tcg_wasm_out_op_i32_rotr(s);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_0_IDX); /* B__A */
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, 0x000000ff);
+    tcg_wasm_out_op_i32_and(s); /* ___A */
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, 0xff000000);
+    tcg_wasm_out_op_i32_and(s);
+    tcg_wasm_out_op_i32_const(s, 16);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_wasm_out_op_i32_shr_s(s); /* SSB_ */
+    } else {
+        tcg_wasm_out_op_i32_shr_u(s); /* 00B_ */
+    }
+
+    tcg_wasm_out_op_i32_or(s); /* **BA */
+    tcg_wasm_out_op_i64_extend_i32_u(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_ctx_i32_store_const(TCGContext *s, int off, int32_t v)
+{
+    tcg_wasm_out_op_local_get(s, CTX_IDX);
+    tcg_wasm_out_op_i32_const(s, v);
+    tcg_wasm_out_op_i32_store(s, 0, off);
+}
+
+static void tcg_wasm_out_ctx_i32_store_r(TCGContext *s, int off, TCGReg r0)
+{
+    tcg_wasm_out_op_local_get(s, CTX_IDX);
+    tcg_wasm_out_op_global_get_r(s, r0);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i32_store(s, 0, off);
+}
+
+static void tcg_wasm_out_ctx_i32_load(TCGContext *s, int off)
+{
+    tcg_wasm_out_op_local_get(s, CTX_IDX);
+    tcg_wasm_out_op_i32_load(s, 0, off);
+}
+
+typedef struct LabelInfo {
+    struct LabelInfo *next;
+    int label;
+    int block;
+} LabelInfo;
+
+__thread LabelInfo *label_info;
+
+static void init_label_info(void)
+{
+    label_info = NULL;
+}
+
+static void add_label(int label, int block)
+{
+    LabelInfo *e = tcg_malloc(sizeof(LabelInfo));
+    e->label = label;
+    e->block = block;
+    e->next = NULL;
+    if (label_info == NULL) {
+        label_info = e;
+        return;
+    }
+    LabelInfo *last = label_info;
+    for (LabelInfo *p = last; p; p = p->next) {
+        last = p;
+    }
+    last->next = e;
+}
+
+typedef struct BlockPlaceholder {
+    struct BlockPlaceholder *next;
+    int label;
+    int pos;
+} BlockPlaceholder;
+
+__thread BlockPlaceholder *block_placeholder;
+
+__thread int block_idx;
+
+static void tcg_wasm_out_new_block(TCGContext *s)
+{
+    tcg_wasm_out_op_end(s); /* close this block */
+
+    /* next block */
+    tcg_wasm_out_op_global_get(s, BLOCK_PTR_IDX);
+    tcg_wasm_out_op_i64_const(s, ++block_idx);
+    tcg_wasm_out_op_i64_le_u(s);
+    tcg_wasm_out_op_if_noret(s);
+}
+
+static void init_blocks(void)
+{
+    block_placeholder = NULL;
+    block_idx = 0;
+}
+
+static void add_block_placeholder(int label, int pos)
+{
+    BlockPlaceholder *e = tcg_malloc(sizeof(BlockPlaceholder));
+    e->label = label;
+    e->pos = pos;
+    e->next = NULL;
+    if (block_placeholder == NULL) {
+        block_placeholder = e;
+        return;
+    }
+    BlockPlaceholder *last = block_placeholder;
+    for (BlockPlaceholder *p = last; p; p = p->next) {
+        last = p;
+    }
+    last->next = e;
+}
+
+static int get_block_of_label(int label)
+{
+    for (LabelInfo *p = label_info; p; p = p->next) {
+        if (p->label == label) {
+            return p->block;
+        }
+    }
+    return -1;
+}
+
+static void tcg_wasm_out_label_idx(TCGContext *s, int label)
+{
+    int blk = ++block_idx;
+    add_label(label, blk);
+    tcg_wasm_out_new_block(s);
+}
+
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l)
+{
+    tcg_wasm_out_label_idx(s, l->id);
+}
+
+static void tcg_wasm_out_op_br_to_label(TCGContext *s, TCGLabel *l, bool br_if)
+{
+    int toploop_depth = 1;
+    if (br_if) {
+        tcg_wasm_out_op_if_noret(s);
+        toploop_depth++;
+    }
+    tcg_wasm_out8(s, 0x42); /* i64.const */
+
+    add_block_placeholder(l->id, sub_buf_len());
+
+    tcg_wasm_out8(s, 0x80); /* filled before instantiation */
+    tcg_wasm_out8(s, 0x80);
+    tcg_wasm_out8(s, 0x80);
+    tcg_wasm_out8(s, 0x80);
+    tcg_wasm_out8(s, 0x00);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+    if (get_block_of_label(l->id) != -1) {
+        /* br to the top of loop */
+        tcg_wasm_out_op_br(s, toploop_depth);
+    } else {
+        /* br to the end of the current block */
+        tcg_wasm_out_op_br(s, toploop_depth - 1);
+    }
+    if (br_if) {
+        tcg_wasm_out_op_end(s);
+    }
+}
+
+static void tcg_wasm_out_br(TCGContext *s, TCGLabel *l)
+{
+    tcg_wasm_out_op_br_to_label(s, l, false);
+}
+
+static void tcg_wasm_out_brcond_i32(TCGContext *s, TCGCond cond, TCGReg arg1,
+                           TCGReg arg2, TCGLabel *l)
+{
+    tcg_wasm_out_op_cond_i32(s, cond, arg1, arg2);
+    tcg_wasm_out_op_br_to_label(s, l, true);
+}
+
+static void tcg_wasm_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
+                           TCGReg arg2, TCGLabel *l)
+{
+    tcg_wasm_out_op_cond_i64(s, cond, arg1, arg2);
+    tcg_wasm_out_op_br_to_label(s, l, true);
+}
+
+static void tcg_wasm_out_exit_tb(TCGContext *s, uintptr_t arg)
+{
+    tcg_wasm_out_ctx_i32_store_const(s, TB_PTR_OFF, 0);
+    tcg_wasm_out_op_i32_const(s, (int32_t)arg);
+    tcg_wasm_out_op_return(s);
+}
+
+static void tcg_wasm_out_goto_ptr(TCGContext *s, TCGReg arg)
+{
+    tcg_wasm_out_op_global_get_r(s, arg);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_ctx_i32_load(s, TB_PTR_OFF);
+    tcg_wasm_out_op_i32_eq(s);
+    tcg_wasm_out_op_if_noret(s);
+    tcg_wasm_out_op_i64_const(s, 0);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+    tcg_wasm_out_op_br(s, 2); /* br to the top of loop */
+    tcg_wasm_out_op_end(s);
+
+    tcg_wasm_out_ctx_i32_store_r(s, TB_PTR_OFF, arg);
+    tcg_wasm_out_ctx_i32_store_const(s, DO_INIT_OFF, 1);
+    tcg_wasm_out_op_i32_const(s, 0);
+    tcg_wasm_out_op_return(s);
+}
+
+static void tcg_wasm_out_goto_tb(
+    TCGContext *s, int which, uint32_t cur_reset_ptr)
+{
+    tcg_wasm_out_op_i32_const(s, (int32_t)get_jmp_target_addr(s, which));
+    tcg_wasm_out_op_i32_load(s, 0, 0);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, cur_reset_ptr);
+    tcg_wasm_out_op_i32_ne(s);
+    tcg_wasm_out_op_if_noret(s);
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_ctx_i32_load(s, TB_PTR_OFF);
+    tcg_wasm_out_op_i32_eq(s);
+    tcg_wasm_out_op_if_noret(s);
+    tcg_wasm_out_op_i64_const(s, 0);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+    tcg_wasm_out_op_br(s, 3); /* br to the top of loop */
+    tcg_wasm_out_op_end(s);
+
+    tcg_wasm_out_op_local_get(s, CTX_IDX);
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_store(s, 0, TB_PTR_OFF);
+    tcg_wasm_out_ctx_i32_store_const(s, DO_INIT_OFF, 1);
+
+    tcg_wasm_out_op_i32_const(s, 0);
+    tcg_wasm_out_op_return(s);
+    tcg_wasm_out_op_end(s);
+}
+
+static void push_arg_i64(TCGContext *s, int *reg_idx, int *stack_offset)
+{
+    if (*reg_idx < NUM_OF_IARG_REGS) {
+        tcg_wasm_out_op_global_get_r(s, REG_INDEX_IARG_BASE + *reg_idx);
+        int addend = 1;
+        *reg_idx = *reg_idx + addend;
+    } else {
+        tcg_wasm_out_op_global_get_r(s, TCG_REG_CALL_STACK);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i64_load(s, 0, *stack_offset);
+        int addend = 8;
+        *stack_offset = *stack_offset + addend;
+    }
+}
+
+static void gen_func_wrapper_code(
+    TCGContext *s, const tcg_insn_unit *func,
+    const TCGHelperInfo *info, int func_idx)
+{
+    int nargs;
+    unsigned typemask = info->typemask;
+    int rettype = typemask & 7;
+    int stack_offset = 0;
+    int reg_idx = 0;
+    int stack128_base = 0;
+    bool cached_128base = false;
+
+    if (rettype ==  dh_typecode_i128) {
+        /* receive 128bit return value via the stack buffer */
+        tcg_wasm_out_op_global_get_r(s, TCG_REG_CALL_STACK);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+    }
+
+    nargs = 32 - clz32(typemask >> 3);
+    nargs = DIV_ROUND_UP(nargs, 3);
+    for (int j = 0; j < nargs; ++j) {
+        int typecode = extract32(typemask, (j + 1) * 3, 3);
+        if (typecode == dh_typecode_void) {
+            continue;
+        }
+        switch (typecode) {
+        case dh_typecode_i32:
+        case dh_typecode_s32:
+        case dh_typecode_ptr:
+            push_arg_i64(s, &reg_idx, &stack_offset);
+            tcg_wasm_out_op_i32_wrap_i64(s);
+            break;
+        case dh_typecode_i64:
+        case dh_typecode_s64:
+            push_arg_i64(s, &reg_idx, &stack_offset);
+            break;
+        case dh_typecode_i128:
+            /* copy data to 128stack */
+            if (!cached_128base) {
+                tcg_wasm_out_ctx_i32_load(s, STACK128_OFF);
+                tcg_wasm_out_op_local_set(s, TMP32_LOCAL_0_IDX);
+                cached_128base = true;
+            }
+
+            /* push current stack128 pointer */
+            tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+            tcg_wasm_out_op_i32_const(s, stack128_base);
+            tcg_wasm_out_op_i32_add(s);
+
+            /* write the argument to the buffer */
+            tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+            push_arg_i64(s, &reg_idx, &stack_offset);
+            tcg_wasm_out_op_i64_store(s, 0, stack128_base);
+            stack128_base += 8;
+
+            tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+            push_arg_i64(s, &reg_idx, &stack_offset);
+            tcg_wasm_out_op_i64_store(s, 0, stack128_base);
+            stack128_base += 8;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    tcg_wasm_out_op_call(s, func_idx);
+
+    stack_offset = 0;
+    if (rettype != dh_typecode_void) {
+        switch (rettype) {
+        case dh_typecode_i32:
+        case dh_typecode_s32:
+        case dh_typecode_ptr:
+            tcg_wasm_out_op_i64_extend_i32_s(s);
+            tcg_wasm_out_op_global_set_r(s, TCG_REG_R0);
+            break;
+        case dh_typecode_i64:
+        case dh_typecode_s64:
+            tcg_wasm_out_op_global_set_r(s, TCG_REG_R0);
+            break;
+        case dh_typecode_i128:
+            tcg_wasm_out_op_global_get_r(s, TCG_REG_CALL_STACK);
+            tcg_wasm_out_op_i32_wrap_i64(s);
+            tcg_wasm_out_op_i64_load(s, 0, stack_offset);
+            tcg_wasm_out_op_global_set_r(s, TCG_REG_R0);
+            stack_offset += 8;
+
+            tcg_wasm_out_op_global_get_r(s, TCG_REG_CALL_STACK);
+            tcg_wasm_out_op_i32_wrap_i64(s);
+            tcg_wasm_out_op_i64_load(s, 0, stack_offset);
+            tcg_wasm_out_op_global_set_r(s, TCG_REG_R1);
+            stack_offset += 8;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    return;
+}
+
+__thread LinkedBuf *types_buf_root;
+__thread LinkedBuf *types_buf_cur;
+
+static void init_types_buf(void)
+{
+    types_buf_root = new_linked_buf();
+    types_buf_cur = types_buf_root;
+}
+
+static inline void types_buf_out8(uint8_t v)
+{
+    types_buf_cur = linked_buf_out8(types_buf_cur, v);
+}
+
+static inline int types_buf_len(void)
+{
+    return linked_buf_len(types_buf_root);
+}
+
+static void types_out_leb128_uint32(uint32_t v)
+{
+    uint32_t low7 = 0x7f;
+    uint8_t b;
+    do {
+        b = v & low7;
+        v >>= 7;
+        if (v != 0) {
+            b |= 0x80;
+        }
+        types_buf_out8(b);
+    } while (v != 0);
+}
+
+static void gen_func_type(TCGContext *s, const TCGHelperInfo *info)
+{
+    int nargs;
+    unsigned typemask = info->typemask;
+    int rettype = typemask & 7;
+    int vec_size = 0;
+
+    nargs = 32 - clz32(typemask >> 3);
+    nargs = DIV_ROUND_UP(nargs, 3);
+
+    if (rettype == dh_typecode_i128) {
+        vec_size++;
+    }
+    for (int j = 0; j < nargs; ++j) {
+        int typecode = extract32(typemask, (j + 1) * 3, 3);
+        if (typecode != dh_typecode_void) {
+            vec_size++;
+        }
+    }
+
+    types_buf_out8(0x60);
+    types_out_leb128_uint32(vec_size);
+
+    if (rettype == dh_typecode_i128) {
+        types_buf_out8(0x7f);
+    }
+
+    for (int j = 0; j < nargs; ++j) {
+        int typecode = extract32(typemask, (j + 1) * 3, 3);
+        if (typecode == dh_typecode_void) {
+            continue;
+        }
+        switch (typecode) {
+        case dh_typecode_i32:
+        case dh_typecode_s32:
+        case dh_typecode_ptr:
+            types_buf_out8(0x7f);
+            break;
+        case dh_typecode_i64:
+        case dh_typecode_s64:
+            types_buf_out8(0x7e);
+            break;
+        case dh_typecode_i128:
+            types_buf_out8(0x7f);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    if ((rettype == dh_typecode_void) || (rettype == dh_typecode_i128)) {
+        types_buf_out8(0x0);
+    } else {
+        types_buf_out8(0x1);
+        switch (rettype) {
+        case dh_typecode_i32:
+        case dh_typecode_s32:
+        case dh_typecode_ptr:
+            types_buf_out8(0x7f);
+            break;
+        case dh_typecode_i64:
+        case dh_typecode_s64:
+            types_buf_out8(0x7e);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    return;
+}
+
+static void gen_func_type_qemu_ld(TCGContext *s, uint32_t oi)
+{
+    types_buf_out8(0x60);
+    types_buf_out8(0x4);
+    types_buf_out8(0x7f);
+    types_buf_out8(0x7e);
+    types_buf_out8(0x7f);
+    types_buf_out8(0x7f);
+    types_buf_out8(0x1);
+    types_buf_out8(0x7e);
+}
+
+static void gen_func_type_qemu_st(TCGContext *s, uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+
+    types_buf_out8(0x60);
+    types_buf_out8(0x5);
+    types_buf_out8(0x7f);
+    types_buf_out8(0x7e);
+    switch (mop & MO_SSIZE) {
+    case MO_UQ:
+        types_buf_out8(0x7e);
+        break;
+    default:
+        types_buf_out8(0x7f);
+        break;
+    }
+    types_buf_out8(0x7f);
+    types_buf_out8(0x7f);
+    types_buf_out8(0x0);
+}
+
+typedef struct HelperInfo {
+    struct HelperInfo *next;
+    uint32_t idx_on_qemu;
+} HelperInfo;
+
+__thread HelperInfo *helpers;
+
+static void init_helpers(void)
+{
+    helpers = NULL;
+}
+
+static int register_helper(TCGContext *s, int helper_idx_on_qemu)
+{
+    int idx = HELPER_IDX_START;
+
+    tcg_debug_assert(helper_idx_on_qemu >= 0);
+
+    HelperInfo *e = tcg_malloc(sizeof(HelperInfo));
+    e->idx_on_qemu = helper_idx_on_qemu;
+    e->next = NULL;
+    if (helpers == NULL) {
+        helpers = e;
+        return idx;
+    }
+    HelperInfo *last = helpers;
+    for (HelperInfo *p = last; p; p = p->next) {
+        last = p;
+        idx++;
+    }
+    last->next = e;
+    return idx;
+}
+
+static int helpers_len(void)
+{
+    int n = 0;
+    for (HelperInfo *p = helpers; p; p = p->next) {
+        n++;
+    }
+    return n;
+}
+
+static inline int helpers_copy(uint32_t *dst)
+{
+    void *start = dst;
+    for (HelperInfo *p = helpers; p; p = p->next) {
+        *dst++ = p->idx_on_qemu;
+    }
+    return (int)dst - (int)start;
+}
+
+
+static int get_helper_idx(TCGContext *s, int helper_idx_on_qemu)
+{
+    int idx = HELPER_IDX_START;
+
+    for (HelperInfo *p = helpers; p; p = p->next) {
+        if (p->idx_on_qemu == helper_idx_on_qemu) {
+            return idx;
+        }
+        idx++;
+    }
+    return -1;
+}
+
+static void tcg_wasm_out_handle_unwinding(TCGContext *s)
+{
+    tcg_wasm_out_op_call(s, CHECK_UNWINDING_IDX);
+    tcg_wasm_out_op_i32_eqz(s);
+    tcg_wasm_out_op_if_noret(s);
+    tcg_wasm_out_op_i32_const(s, 0);
+    /* returns if unwinding */
+    tcg_wasm_out_op_return(s);
+    tcg_wasm_out_op_end(s);
+}
+
+static void tcg_wasm_out_call(TCGContext *s, const tcg_insn_unit *func,
+                         const TCGHelperInfo *info)
+{
+    int func_idx = get_helper_idx(s, (int)func);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, (int)func);
+        gen_func_type(s, info);
+    }
+
+    tcg_wasm_out_ctx_i32_load(s, HELPER_RET_TB_PTR_OFF);
+    tcg_wasm_out_op_i32_const(s, (int32_t)s->code_ptr);
+    tcg_wasm_out_op_i32_store(s, 0, 0);
+
+    /*
+     * update the block index so that the possible rewinding will
+     * skip this block
+     */
+    tcg_wasm_out_op_i64_const(s, block_idx + 1);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+
+    tcg_wasm_out_new_block(s);
+
+    gen_func_wrapper_code(s, func, info, func_idx);
+    tcg_wasm_out_handle_unwinding(s);
+}
+
+void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
+                              uintptr_t jmp_rx, uintptr_t jmp_rw)
+{
+    /* Always indirect, nothing to do */
+}
+
+
+static void tcg_wasm_out_i32_load_s(TCGContext *s, int off)
+{
+    if (off < 0) {
+        tcg_wasm_out_op_i32_const(s, off);
+        tcg_wasm_out_op_i32_add(s);
+        off = 0;
+    }
+    tcg_wasm_out_op_i32_load(s, 0, off);
+}
+
+static void tcg_wasm_out_i64_load_s(TCGContext *s, int off)
+{
+    if (off < 0) {
+        tcg_wasm_out_op_i32_const(s, off);
+        tcg_wasm_out_op_i32_add(s);
+        off = 0;
+    }
+    tcg_wasm_out_op_i64_load(s, 0, off);
+}
+
+#define MIN_TLB_MASK_TABLE_OFS INT_MIN
+
+static uint8_t tcg_wasm_out_tlb_load(
+    TCGContext *s, TCGReg addr, MemOpIdx oi, bool is_ld)
+{
+    MemOp opc = get_memop(oi);
+    TCGAtomAlign aa;
+    unsigned a_mask;
+    unsigned s_bits = opc & MO_SIZE;
+    unsigned s_mask = (1u << s_bits) - 1;
+    int mem_index = get_mmuidx(oi);
+    int fast_ofs = tlb_mask_table_ofs(s, mem_index);
+    int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
+    int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
+    int add_off = offsetof(CPUTLBEntry, addend);
+    tcg_target_long compare_mask;
+
+    aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
+    a_mask = (1u << aa.align) - 1;
+
+    tcg_wasm_out_op_global_get_r(s, addr);
+    tcg_wasm_out_op_i64_const(s, s->page_bits - CPU_TLB_ENTRY_BITS);
+    tcg_wasm_out_op_i64_shr_u(s);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+
+    tcg_wasm_out_op_global_get_r_i32(s, TCG_AREG0);
+    tcg_wasm_out_i32_load_s(s, mask_ofs);
+
+    tcg_wasm_out_op_i32_and(s);
+
+    tcg_wasm_out_op_global_get_r_i32(s, TCG_AREG0);
+    tcg_wasm_out_i32_load_s(s, table_ofs);
+    tcg_wasm_out_op_i32_add(s);
+
+    tcg_wasm_out_op_local_tee(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_i64_load_s(
+        s, is_ld ? offsetof(CPUTLBEntry, addr_read)
+        : offsetof(CPUTLBEntry, addr_write));
+
+    tcg_wasm_out_op_global_get_r(s, addr);
+    if (a_mask < s_mask) {
+        tcg_wasm_out_op_i64_const(s, s_mask - a_mask);
+        tcg_wasm_out_op_i64_add(s);
+    }
+    compare_mask = (uint64_t)s->page_mask | a_mask;
+    tcg_wasm_out_op_i64_const(s, compare_mask);
+    tcg_wasm_out_op_i64_and(s);
+
+    tcg_wasm_out_op_i64_eq(s);
+
+    tcg_wasm_out_op_i32_const(s, 0);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_1_IDX);
+
+    tcg_wasm_out_op_if_noret(s);
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_i32_load_s(s, add_off);
+    tcg_wasm_out_op_global_get_r(s, addr);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i32_add(s);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_1_IDX);
+
+    tcg_wasm_out_op_end(s);
+
+    return TMP32_LOCAL_1_IDX;
+}
+
+static void tcg_wasm_out_qemu_ld_direct(
+    TCGContext *s, TCGReg r, uint8_t base, MemOp opc)
+{
+    switch (opc & (MO_SSIZE)) {
+    case MO_UB:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load8_u(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    case MO_SB:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load8_s(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    case MO_UW:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load16_u(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    case MO_SW:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load16_s(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    case MO_UL:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load32_u(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    case MO_SL:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load32_s(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    case MO_UQ:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void *qemu_ld_helper_ptr(uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+    switch (mop & MO_SSIZE) {
+    case MO_UB:
+        return helper_ldub_mmu;
+    case MO_SB:
+        return helper_ldsb_mmu;
+    case MO_UW:
+        return helper_lduw_mmu;
+    case MO_SW:
+        return helper_ldsw_mmu;
+    case MO_UL:
+        return helper_ldul_mmu;
+    case MO_SL:
+        return helper_ldsl_mmu;
+    case MO_UQ:
+        return helper_ldq_mmu;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_qemu_ld(TCGContext *s, const TCGArg *args, bool addr64)
+{
+    TCGReg addr_reg;
+    TCGReg data_reg;
+    MemOpIdx oi;
+    MemOp mop;
+    uint8_t base;
+    int helper_idx;
+    int func_idx;
+
+    data_reg = *args++;
+    addr_reg = *args++;
+    oi = *args++;
+    mop = get_memop(oi);
+
+    helper_idx = (uint32_t)qemu_ld_helper_ptr(oi);
+    func_idx = get_helper_idx(s, helper_idx);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, helper_idx);
+        gen_func_type_qemu_ld(s, oi);
+    }
+
+    if (!addr64) {
+        tcg_wasm_out_ext32u(s, TCG_REG_TMP, addr_reg);
+        addr_reg = TCG_REG_TMP;
+    }
+
+    base = tcg_wasm_out_tlb_load(s, addr_reg, oi, true);
+
+    tcg_wasm_out_op_local_get(s, base);
+    tcg_wasm_out_op_i32_const(s, 0);
+    tcg_wasm_out_op_i32_ne(s);
+    tcg_wasm_out_op_if_noret(s);
+
+    /* fast path */
+    tcg_wasm_out_qemu_ld_direct(s, data_reg, base, mop);
+
+    tcg_wasm_out_op_end(s);
+
+    /*
+     * update the block index so that the possible rewinding will
+     * skip this block
+     */
+    tcg_wasm_out_op_i64_const(s, block_idx + 1);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+
+    tcg_wasm_out_new_block(s);
+
+    tcg_wasm_out_op_local_get(s, base);
+    tcg_wasm_out_op_i32_eqz(s);
+    tcg_wasm_out_op_if_noret(s);
+
+    /* call helper */
+    tcg_wasm_out_op_global_get_r(s, TCG_AREG0);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_global_get_r(s, addr_reg);
+    tcg_wasm_out_op_i32_const(s, oi);
+    tcg_wasm_out_op_i32_const(s, (int32_t)s->code_ptr);
+
+    tcg_wasm_out_op_call(s, func_idx);
+    tcg_wasm_out_op_global_set_r(s, data_reg);
+    tcg_wasm_out_handle_unwinding(s);
+
+    tcg_wasm_out_op_end(s);
+}
+
+static void tcg_wasm_out_qemu_st_direct(
+    TCGContext *s, TCGReg lo, uint8_t base, MemOp opc)
+{
+    switch (opc & (MO_SSIZE)) {
+    case MO_8:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_global_get_r(s, lo);
+        tcg_wasm_out_op_i64_store8(s, 0, 0);
+        break;
+    case MO_16:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_global_get_r(s, lo);
+        tcg_wasm_out_op_i64_store16(s, 0, 0);
+        break;
+    case MO_32:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_global_get_r(s, lo);
+        tcg_wasm_out_op_i64_store32(s, 0, 0);
+        break;
+    case MO_64:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_global_get_r(s, lo);
+        tcg_wasm_out_op_i64_store(s, 0, 0);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void *qemu_st_helper_ptr(uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+    switch (mop & MO_SIZE) {
+    case MO_8:
+        return helper_stb_mmu;
+    case MO_16:
+        return helper_stw_mmu;
+    case MO_32:
+        return helper_stl_mmu;
+    case MO_64:
+        return helper_stq_mmu;
+    case MO_128:
+        return helper_st16_mmu;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_qemu_st(TCGContext *s, const TCGArg *args, bool addr64)
+{
+    TCGReg addr_reg;
+    TCGReg data_reg;
+    MemOpIdx oi;
+    MemOp mop;
+    uint8_t base;
+    int helper_idx;
+    int func_idx;
+
+    data_reg = *args++;
+    addr_reg = *args++;
+    oi = *args++;
+    mop = get_memop(oi);
+
+    helper_idx = (uint32_t)qemu_st_helper_ptr(oi);
+    func_idx = get_helper_idx(s, helper_idx);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, helper_idx);
+        gen_func_type_qemu_st(s, oi);
+    }
+
+    if (!addr64) {
+        tcg_wasm_out_ext32u(s, TCG_REG_TMP, addr_reg);
+        addr_reg = TCG_REG_TMP;
+    }
+
+    base = tcg_wasm_out_tlb_load(s, addr_reg, oi, false);
+
+    tcg_wasm_out_op_local_get(s, base);
+    tcg_wasm_out_op_i32_const(s, 0);
+    tcg_wasm_out_op_i32_ne(s);
+    tcg_wasm_out_op_if_noret(s);
+
+    /* fast path */
+    tcg_wasm_out_qemu_st_direct(s, data_reg, base, mop);
+
+    tcg_wasm_out_op_end(s);
+
+    /*
+     * update the block index so that the possible rewinding will
+     * skip this block
+     */
+    tcg_wasm_out_op_i64_const(s, block_idx + 1);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+
+    tcg_wasm_out_new_block(s);
+
+    tcg_wasm_out_op_local_get(s, base);
+    tcg_wasm_out_op_i32_eqz(s);
+    tcg_wasm_out_op_if_noret(s);
+
+    /* call helper */
+    tcg_wasm_out_op_global_get_r(s, TCG_AREG0);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_global_get_r(s, addr_reg);
+    mop = get_memop(oi);
+    switch (mop & MO_SSIZE) {
+    case MO_UQ:
+        tcg_wasm_out_op_global_get_r(s, data_reg);
+        break;
+    default:
+        tcg_wasm_out_op_global_get_r(s, data_reg);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        break;
+    }
+    tcg_wasm_out_op_i32_const(s, oi);
+    tcg_wasm_out_op_i32_const(s, (int32_t)s->code_ptr);
+
+    tcg_wasm_out_op_call(s, func_idx);
+    tcg_wasm_out_handle_unwinding(s);
+
+    tcg_wasm_out_op_end(s);
+}
+
+static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
+                        intptr_t value, intptr_t addend)
+{
+    int32_t *code_ptr = (int32_t *)code_ptr_i;
+    intptr_t diff = value - (intptr_t)(code_ptr + 1);
+
+    tcg_debug_assert(addend == 0);
+    tcg_debug_assert(type == 20);
+
+    if (diff == sextract32(diff, 0, type)) {
+        tcg_patch32((tcg_insn_unit *)code_ptr,
+                    deposit32(*code_ptr, 32 - type, type, diff));
+        return true;
+    }
+    return false;
+}
+
+static void stack_bounds_check(TCGReg base, intptr_t offset)
+{
+    if (base == TCG_REG_CALL_STACK) {
+        tcg_debug_assert(offset >= 0);
+        tcg_debug_assert(offset < (TCG_STATIC_CALL_ARGS_SIZE +
+                                   TCG_STATIC_FRAME_SIZE));
+    }
+}
+
+static inline void tcg_tci_out32(TCGContext *s, uint32_t v)
+{
+    tcg_out32(s, v);
+}
+
+static void *cur_tci_ptr(TCGContext *s)
+{
+    return s->code_ptr;
+}
+
+static void tcg_tci_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
+{
+    uint32_t insn = 0;
+
+    tcg_out_reloc(s, cur_tci_ptr(s), 20, l0, 0);
+    insn = deposit32(insn, 0, 8, op);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_p(TCGContext *s, TCGOpcode op, void *p0)
+{
+    uint32_t insn = 0;
+    intptr_t diff;
+
+    /* Special case for exit_tb: map null -> 0. */
+    if (p0 == NULL) {
+        diff = 0;
+    } else {
+        diff = p0 - (cur_tci_ptr(s) + 4);
+        tcg_debug_assert(diff != 0);
+        if (diff != sextract32(diff, 0, 20)) {
+            tcg_raise_tb_overflow(s);
+        }
+    }
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 12, 20, diff);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_r(TCGContext *s, TCGOpcode op, TCGReg r0)
+{
+    uint32_t insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_v(TCGContext *s, TCGOpcode op)
+{
+    tcg_tci_out32(s, (uint8_t)op);
+}
+
+static void tcg_tci_out_op_ri(TCGContext *s, TCGOpcode op,
+                              TCGReg r0, int32_t i1)
+{
+    uint32_t insn = 0;
+
+    tcg_debug_assert(i1 == sextract32(i1, 0, 20));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 20, i1);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_rl(TCGContext *s, TCGOpcode op,
+                              TCGReg r0, TCGLabel *l1)
+{
+    uint32_t insn = 0;
+
+    tcg_out_reloc(s, cur_tci_ptr(s), 20, l1, 0);
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_rr(TCGContext *s, TCGOpcode op,
+                              TCGReg r0, TCGReg r1)
+{
+    uint32_t insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_rrr(TCGContext *s, TCGOpcode op,
+                           TCGReg r0, TCGReg r1, TCGReg r2)
+{
+    uint32_t insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_rrs(TCGContext *s, TCGOpcode op,
+                           TCGReg r0, TCGReg r1, intptr_t i2)
+{
+    uint32_t insn = 0;
+
+    tcg_debug_assert(i2 == sextract32(i2, 0, 16));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 16, i2);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_rrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
+                            TCGReg r1, uint8_t b2, uint8_t b3)
+{
+    uint32_t insn = 0;
+
+    tcg_debug_assert(b2 == extract32(b2, 0, 6));
+    tcg_debug_assert(b3 == extract32(b3, 0, 6));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 6, b2);
+    insn = deposit32(insn, 22, 6, b3);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_rrrc(TCGContext *s, TCGOpcode op,
+                            TCGReg r0, TCGReg r1, TCGReg r2, TCGCond c3)
+{
+    uint32_t insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    insn = deposit32(insn, 20, 4, c3);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_rrrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
+                             TCGReg r1, TCGReg r2, uint8_t b3, uint8_t b4)
+{
+    uint32_t insn = 0;
+
+    tcg_debug_assert(b3 == extract32(b3, 0, 6));
+    tcg_debug_assert(b4 == extract32(b4, 0, 6));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    insn = deposit32(insn, 20, 6, b3);
+    insn = deposit32(insn, 26, 6, b4);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_rrrr(TCGContext *s, TCGOpcode op,
+                            TCGReg r0, TCGReg r1, TCGReg r2, TCGReg r3)
+{
+    uint32_t insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    insn = deposit32(insn, 20, 4, r3);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
+                              TCGReg r0, TCGReg r1, TCGReg r2,
+                              TCGReg r3, TCGReg r4, TCGCond c5)
+{
+    uint32_t insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    insn = deposit32(insn, 20, 4, r3);
+    insn = deposit32(insn, 24, 4, r4);
+    insn = deposit32(insn, 28, 4, c5);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_op_rrrrrr(TCGContext *s, TCGOpcode op,
+                              TCGReg r0, TCGReg r1, TCGReg r2,
+                              TCGReg r3, TCGReg r4, TCGReg r5)
+{
+    uint32_t insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    insn = deposit32(insn, 20, 4, r3);
+    insn = deposit32(insn, 24, 4, r4);
+    insn = deposit32(insn, 28, 4, r5);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_movi(TCGContext *s, TCGType type,
+                         TCGReg ret, tcg_target_long arg)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        arg = (int32_t)arg;
+        /* fall through */
+    case TCG_TYPE_I64:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (arg == sextract32(arg, 0, 20)) {
+        tcg_tci_out_op_ri(s, INDEX_op_tci_movi, ret, arg);
+    } else {
+        uint32_t insn = 0;
+
+        new_pool_label(s, arg, 20, cur_tci_ptr(s), 0);
+        insn = deposit32(insn, 0, 8, INDEX_op_tci_movl);
+        insn = deposit32(insn, 8, 4, ret);
+        tcg_tci_out32(s, insn);
+    }
+}
+
+static void tcg_tci_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
+                         TCGReg base, intptr_t offset)
+{
+    stack_bounds_check(base, offset);
+    if (offset != sextract32(offset, 0, 16)) {
+        tcg_tci_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, offset);
+        tcg_tci_out_op_rrr(s, INDEX_op_add_i64,
+                       TCG_REG_TMP, TCG_REG_TMP, base);
+        base = TCG_REG_TMP;
+        offset = 0;
+    }
+    tcg_tci_out_op_rrs(s, op, val, base, offset);
+}
+
+static bool tcg_tci_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_tci_out_op_rr(s, INDEX_op_mov_i32, ret, arg);
+        break;
+    case TCG_TYPE_I64:
+        tcg_tci_out_op_rr(s, INDEX_op_mov_i64, ret, arg);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
+}
+
+static void tcg_tci_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_debug_assert(TCG_TARGET_HAS_ext8s_i32);
+        tcg_tci_out_op_rr(s, INDEX_op_ext8s_i32, rd, rs);
+        break;
+    case TCG_TYPE_I64:
+        tcg_debug_assert(TCG_TARGET_HAS_ext8s_i64);
+        tcg_tci_out_op_rr(s, INDEX_op_ext8s_i64, rd, rs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_tci_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_debug_assert(TCG_TARGET_HAS_ext8u_i64);
+    tcg_tci_out_op_rr(s, INDEX_op_ext8u_i64, rd, rs);
+}
+
+static void tcg_tci_out_ext16s(TCGContext *s, TCGType type,
+                               TCGReg rd, TCGReg rs)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_debug_assert(TCG_TARGET_HAS_ext16s_i32);
+        tcg_tci_out_op_rr(s, INDEX_op_ext16s_i32, rd, rs);
+        break;
+    case TCG_TYPE_I64:
+        tcg_debug_assert(TCG_TARGET_HAS_ext16s_i64);
+        tcg_tci_out_op_rr(s, INDEX_op_ext16s_i64, rd, rs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_tci_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_debug_assert(TCG_TARGET_HAS_ext16u_i64);
+    tcg_tci_out_op_rr(s, INDEX_op_ext16u_i64, rd, rs);
+}
+
+static void tcg_tci_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+    tcg_debug_assert(TCG_TARGET_HAS_ext32s_i64);
+    tcg_tci_out_op_rr(s, INDEX_op_ext32s_i64, rd, rs);
+}
+
+static void tcg_tci_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+    tcg_debug_assert(TCG_TARGET_HAS_ext32u_i64);
+    tcg_tci_out_op_rr(s, INDEX_op_ext32u_i64, rd, rs);
+}
+
+static void tcg_tci_out_exts_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_tci_out_ext32s(s, rd, rs);
+}
+
+static void tcg_tci_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_tci_out_ext32u(s, rd, rs);
+}
+
+static void tcg_tci_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+    tcg_tci_out_mov(s, TCG_TYPE_I32, rd, rs);
+}
+
+static void tcg_tci_out_call(TCGContext *s, const tcg_insn_unit *func,
+                         const TCGHelperInfo *info)
+{
+    ffi_cif *cif = info->cif;
+    uint32_t insn = 0;
+    uint8_t which;
+
+    if (cif->rtype == &ffi_type_void) {
+        which = 0;
+    } else {
+        tcg_debug_assert(cif->rtype->size == 4 ||
+                         cif->rtype->size == 8 ||
+                         cif->rtype->size == 16);
+        which = ctz32(cif->rtype->size) - 1;
+    }
+    new_pool_l2(s, 20, cur_tci_ptr(s),
+                0, (uintptr_t)func, (uintptr_t)cif);
+    insn = deposit32(insn, 0, 8, INDEX_op_call);
+    insn = deposit32(insn, 8, 4, which);
+    tcg_tci_out32(s, insn);
+}
+
+static void tcg_tci_out_exit_tb(TCGContext *s, uintptr_t arg)
+{
+    tcg_tci_out_op_p(s, INDEX_op_exit_tb, (void *)arg);
+}
+
+static void tcg_tci_out_goto_tb(TCGContext *s, int which)
+{
+    /* indirect jump method. */
+    tcg_tci_out_op_p(s, INDEX_op_goto_tb,
+                     (void *)get_jmp_target_addr(s, which));
+    set_jmp_reset_offset(s, which);
+}
+
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    int32_t *p2 = (int32_t *)p;
+    memset(p2, 0, sizeof(*p2) * count);
+}
+
+static void tcg_out_goto_ptr(TCGContext *s, TCGOpcode opc, TCGReg arg)
+{
+    tcg_tci_out_op_r(s, opc, arg);
+    tcg_wasm_out_goto_ptr(s, arg);
+}
+static void tcg_out_br(TCGContext *s, TCGOpcode opc, TCGLabel *l)
+{
+    tcg_tci_out_op_l(s, opc, l);
+    tcg_wasm_out_br(s, l);
+}
+static void tcg_out_setcond_i32(TCGContext *s, TCGOpcode opc, TCGCond cond,
+                                TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrrc(s, opc, ret, arg1, arg2, cond);
+    tcg_wasm_out_setcond_i32(s, cond, ret, arg1, arg2);
+}
+static void tcg_out_setcond_i64(TCGContext *s, TCGOpcode opc, TCGCond cond,
+                                TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrrc(s, opc, ret, arg1, arg2, cond);
+    tcg_wasm_out_setcond_i64(s, cond, ret, arg1, arg2);
+}
+static void tcg_out_movcond_i32(TCGContext *s, TCGOpcode opc, TCGCond cond,
+                                TCGReg ret, TCGReg c1, TCGReg c2,
+                                TCGReg v1, TCGReg v2)
+{
+    tcg_tci_out_op_rrrrrc(s, opc, ret, c1, c2, v1, v2, cond);
+    tcg_wasm_out_movcond_i32(s, cond, ret, c1, c2, v1, v2);
+}
+static void tcg_out_movcond_i64(TCGContext *s, TCGOpcode opc, TCGCond cond,
+                                TCGReg ret, TCGReg c1, TCGReg c2,
+                                TCGReg v1, TCGReg v2)
+{
+    tcg_tci_out_op_rrrrrc(s, opc, ret, c1, c2, v1, v2, cond);
+    tcg_wasm_out_movcond_i64(s, cond, ret, c1, c2, v1, v2);
+}
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
+                       intptr_t offset)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_tci_out_ldst(s, INDEX_op_ld_i32, val, base, offset);
+        break;
+    case TCG_TYPE_I64:
+        tcg_tci_out_ldst(s, INDEX_op_ld_i64, val, base, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_wasm_out_ld(s, type, val, base, offset);
+}
+static void tcg_out_ld8s(TCGContext *s, TCGOpcode opc, TCGType type,
+                         TCGReg val, TCGReg base, intptr_t offset)
+{
+    tcg_tci_out_ldst(s, opc, val, base, offset);
+    tcg_wasm_out_ld8s(s, type, val, base, offset);
+}
+static void tcg_out_ld8u(TCGContext *s, TCGOpcode opc, TCGType type,
+                         TCGReg val, TCGReg base, intptr_t offset)
+{
+    tcg_tci_out_ldst(s, opc, val, base, offset);
+    tcg_wasm_out_ld8u(s, type, val, base, offset);
+}
+static void tcg_out_ld16s(TCGContext *s, TCGOpcode opc, TCGType type,
+                          TCGReg val, TCGReg base, intptr_t offset)
+{
+    tcg_tci_out_ldst(s, opc, val, base, offset);
+    tcg_wasm_out_ld16s(s, type, val, base, offset);
+}
+static void tcg_out_ld16u(TCGContext *s, TCGOpcode opc, TCGType type,
+                          TCGReg val, TCGReg base, intptr_t offset)
+{
+    tcg_tci_out_ldst(s, opc, val, base, offset);
+    tcg_wasm_out_ld16u(s, type, val, base, offset);
+}
+static void tcg_out_ld32s(TCGContext *s, TCGOpcode opc, TCGType type,
+                          TCGReg val, TCGReg base, intptr_t offset)
+{
+    tcg_tci_out_ldst(s, opc, val, base, offset);
+    tcg_wasm_out_ld32s(s, type, val, base, offset);
+}
+static void tcg_out_ld32u(TCGContext *s, TCGOpcode opc, TCGType type,
+                          TCGReg val, TCGReg base, intptr_t offset)
+{
+    tcg_tci_out_ldst(s, opc, val, base, offset);
+    tcg_wasm_out_ld32u(s, type, val, base, offset);
+}
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
+                       intptr_t offset)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_tci_out_ldst(s, INDEX_op_st_i32, val, base, offset);
+        break;
+    case TCG_TYPE_I64:
+        tcg_tci_out_ldst(s, INDEX_op_st_i64, val, base, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_wasm_out_st(s, type, val, base, offset);
+}
+static void tcg_out_st8(TCGContext *s, TCGOpcode opc, TCGType type, TCGReg val,
+                        TCGReg base, intptr_t offset)
+{
+    tcg_tci_out_ldst(s, opc, val, base, offset);
+    tcg_wasm_out_st8(s, type, val, base, offset);
+}
+static void tcg_out_st16(TCGContext *s, TCGOpcode opc, TCGType type, TCGReg val,
+                         TCGReg base, intptr_t offset)
+{
+    tcg_tci_out_ldst(s, opc, val, base, offset);
+    tcg_wasm_out_st16(s, type, val, base, offset);
+}
+static void tcg_out_st32(TCGContext *s, TCGOpcode opc, TCGType type, TCGReg val,
+                         TCGReg base, intptr_t offset)
+{
+    tcg_tci_out_ldst(s, opc, val, base, offset);
+    tcg_wasm_out_st32(s, type, val, base, offset);
+}
+static void tcg_out_add(TCGContext *s, TCGOpcode opc,
+                        TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_i64_calc_add(s, ret, arg1, arg2);
+}
+static void tcg_out_sub(TCGContext *s, TCGOpcode opc,
+                        TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_i64_calc_sub(s, ret, arg1, arg2);
+}
+static void tcg_out_mul(TCGContext *s, TCGOpcode opc,
+                        TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_i64_calc_mul(s, ret, arg1, arg2);
+}
+static void tcg_out_and(TCGContext *s, TCGOpcode opc,
+                        TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_i64_calc_and(s, ret, arg1, arg2);
+}
+static void tcg_out_or(TCGContext *s, TCGOpcode opc,
+                       TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_i64_calc_or(s, ret, arg1, arg2);
+}
+static void tcg_out_xor(TCGContext *s, TCGOpcode opc,
+                        TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_i64_calc_xor(s, ret, arg1, arg2);
+}
+static void tcg_out_shl(TCGContext *s, TCGOpcode opc, TCGType type,
+                        TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_shl(s, type, ret, arg1, arg2);
+}
+static void tcg_out_shr_u(TCGContext *s, TCGOpcode opc, TCGType type,
+                          TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_shr_u(s, type, ret, arg1, arg2);
+}
+static void tcg_out_shr_s(TCGContext *s, TCGOpcode opc, TCGType type,
+                          TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_shr_s(s, type, ret, arg1, arg2);
+}
+static void tcg_out_i64_rotl(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                             TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_i64_calc_rotl(s, ret, arg1, arg2);
+}
+static void tcg_out_i32_rotl(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                             TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_i32_rotl(s, ret, arg1, arg2);
+}
+static void tcg_out_i32_rotr(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                             TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_i32_rotr(s, ret, arg1, arg2);
+}
+static void tcg_out_i64_rotr(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                             TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_i64_calc_rotr(s, ret, arg1, arg2);
+}
+static void tcg_out_div_s(TCGContext *s, TCGOpcode opc, TCGType type,
+                          TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_div_s(s, type, ret, arg1, arg2);
+}
+static void tcg_out_div_u(TCGContext *s, TCGOpcode opc, TCGType type,
+                          TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_div_u(s, type, ret, arg1, arg2);
+}
+static void tcg_out_rem_s(TCGContext *s, TCGOpcode opc, TCGType type,
+                          TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_rem_s(s, type, ret, arg1, arg2);
+}
+static void tcg_out_rem_u(TCGContext *s, TCGOpcode opc, TCGType type,
+                          TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_rem_u(s, type, ret, arg1, arg2);
+}
+static void tcg_out_andc(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                         TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_andc(s, ret, arg1, arg2);
+}
+static void tcg_out_orc(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                        TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_orc(s, ret, arg1, arg2);
+}
+static void tcg_out_eqv(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                        TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_eqv(s, ret, arg1, arg2);
+}
+static void tcg_out_nand(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                         TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_nand(s, ret, arg1, arg2);
+}
+static void tcg_out_nor(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                        TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_nor(s, ret, arg1, arg2);
+}
+static void tcg_out_clz32(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                          TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_clz32(s, ret, arg1, arg2);
+}
+static void tcg_out_clz64(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                          TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_clz64(s, ret, arg1, arg2);
+}
+static void tcg_out_ctz32(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                          TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_ctz32(s, ret, arg1, arg2);
+}
+static void tcg_out_ctz64(TCGContext *s, TCGOpcode opc, TCGReg ret,
+                          TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrr(s, opc, ret, arg1, arg2);
+    tcg_wasm_out_ctz64(s, ret, arg1, arg2);
+}
+static void tcg_out_brcond_i32(TCGContext *s, TCGOpcode opc, TCGCond cond,
+                               TCGReg arg1, TCGReg arg2, TCGLabel *l)
+{
+    tcg_tci_out_op_rrrc(s, (opc == INDEX_op_brcond_i32 ?
+                            INDEX_op_setcond_i32 : INDEX_op_setcond_i64),
+                        TCG_REG_TMP, arg1, arg2, cond);
+    tcg_tci_out_op_rl(s, opc, TCG_REG_TMP, l);
+    tcg_wasm_out_brcond_i32(s, cond, arg1, arg2, l);
+
+}
+static void tcg_out_brcond_i64(TCGContext *s, TCGOpcode opc, TCGCond cond,
+                               TCGReg arg1, TCGReg arg2, TCGLabel *l)
+{
+    tcg_tci_out_op_rrrc(s, (opc == INDEX_op_brcond_i32 ?
+                            INDEX_op_setcond_i32 : INDEX_op_setcond_i64),
+                        TCG_REG_TMP, arg1, arg2, cond);
+    tcg_tci_out_op_rl(s, opc, TCG_REG_TMP, l);
+    tcg_wasm_out_brcond_i64(s, cond, arg1, arg2, l);
+
+}
+static void tcg_out_neg(TCGContext *s, TCGOpcode opc, TCGReg ret, TCGReg arg)
+{
+    tcg_tci_out_op_rr(s, opc, ret, arg);
+    tcg_wasm_out_neg(s, ret, arg);
+}
+static void tcg_out_not(TCGContext *s, TCGOpcode opc, TCGReg ret, TCGReg arg)
+{
+    tcg_tci_out_op_rr(s, opc, ret, arg);
+    tcg_wasm_out_not(s, ret, arg);
+}
+static void tcg_out_ctpop_i32(TCGContext *s, TCGOpcode opc,
+                              TCGReg dest, TCGReg src)
+{
+    tcg_tci_out_op_rr(s, opc, dest, src);
+    tcg_wasm_out_ctpop_i32(s, dest, src);
+}
+static void tcg_out_ctpop_i64(TCGContext *s, TCGOpcode opc,
+                              TCGReg dest, TCGReg src)
+{
+    tcg_tci_out_op_rr(s, opc, dest, src);
+    tcg_wasm_out_ctpop_i64(s, dest, src);
+}
+static void tcg_out_add2_i32(TCGContext *s, TCGOpcode opc,
+                             TCGReg retl, TCGReg reth,
+                             TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
+{
+    tcg_tci_out_op_rrrrrr(s, opc, retl, reth, al, ah, bl, bh);
+    tcg_wasm_out_add2_i32(s, retl, reth, al, ah, bl, bh);
+}
+static void tcg_out_add2_i64(TCGContext *s, TCGOpcode opc,
+                             TCGReg retl, TCGReg reth,
+                             TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
+{
+    tcg_tci_out_op_rrrrrr(s, opc, retl, reth, al, ah, bl, bh);
+    tcg_wasm_out_add2_i64(s, retl, reth, al, ah, bl, bh);
+}
+static void tcg_out_sub2_i32(TCGContext *s, TCGOpcode opc,
+                             TCGReg retl, TCGReg reth,
+                             TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
+{
+    tcg_tci_out_op_rrrrrr(s, opc, retl, reth, al, ah, bl, bh);
+    tcg_wasm_out_sub2_i32(s, retl, reth, al, ah, bl, bh);
+}
+static void tcg_out_sub2_i64(TCGContext *s, TCGOpcode opc,
+                             TCGReg retl, TCGReg reth,
+                             TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
+{
+    tcg_tci_out_op_rrrrrr(s, opc, retl, reth, al, ah, bl, bh);
+    tcg_wasm_out_sub2_i64(s, retl, reth, al, ah, bl, bh);
+}
+static void tcg_out_mulu2_i32(TCGContext *s, TCGOpcode opc, TCGReg retl,
+                              TCGReg reth, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrrr(s, opc, retl, reth, arg1, arg2);
+    tcg_wasm_out_mulu2_i32(s, retl, reth, arg1, arg2);
+}
+static void tcg_out_muls2_i32(TCGContext *s, TCGOpcode opc, TCGReg retl,
+                              TCGReg reth, TCGReg arg1, TCGReg arg2)
+{
+    tcg_tci_out_op_rrrr(s, opc, retl, reth, arg1, arg2);
+    tcg_wasm_out_muls2_i32(s, retl, reth, arg1, arg2);
+}
+
+static void tcg_out_bswap16_i32(TCGContext *s, TCGOpcode opc,
+                                TCGReg dest, TCGReg src, int flags)
+{
+    tcg_tci_out_op_rr(s, opc, dest, src);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_tci_out_op_rr(s, INDEX_op_ext16s_i32, dest, dest);
+    }
+    tcg_wasm_out_bswap16(s, dest, src, flags);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_wasm_out_ext16s(s, TCG_TYPE_I32, dest, dest);
+    }
+}
+static void tcg_out_bswap16_i64(TCGContext *s, TCGOpcode opc,
+                                TCGReg dest, TCGReg src, int flags)
+{
+    tcg_tci_out_op_rr(s, opc, dest, src);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_tci_out_op_rr(s, INDEX_op_ext16s_i64, dest, dest);
+    }
+    tcg_wasm_out_bswap16(s, dest, src, flags);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_wasm_out_ext16s(s, TCG_TYPE_I64, dest, dest);
+    }
+}
+
+static void tcg_out_bswap32_i32(TCGContext *s, TCGOpcode opc, TCGReg dest,
+                                TCGReg src, int flags)
+{
+    tcg_tci_out_op_rr(s, opc, dest, src);
+    tcg_wasm_out_bswap32(s, dest, src, flags);
+}
+static void tcg_out_bswap32_i64(TCGContext *s, TCGOpcode opc, TCGReg dest,
+                                TCGReg src, int flags)
+{
+    tcg_tci_out_op_rr(s, opc, dest, src);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_tci_out_op_rr(s, INDEX_op_ext32s_i64, dest, dest);
+    }
+    tcg_wasm_out_bswap32(s, dest, src, flags);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_wasm_out_ext32s(s, dest, dest);
+    }
+}
+static void tcg_out_bswap64_i64(TCGContext *s, TCGOpcode opc, TCGReg dest,
+                                TCGReg src, int flags)
+{
+    tcg_tci_out_op_rr(s, opc, dest, src);
+    tcg_wasm_out_bswap64(s, dest, src, flags);
+}
+static void tcg_tci_out_qemu_ldst(TCGContext *s, TCGOpcode opc,
+                                  const TCGArg *args, bool addr64)
+{
+    TCGReg addr = args[1];
+    MemOpIdx oi = args[2];
+
+    MemOp mopc = get_memop(oi);
+    TCGAtomAlign aa = atom_and_align_for_opc(s, mopc, MO_ATOM_IFALIGN, false);
+    unsigned a_mask = (1u << aa.align) - 1;
+
+    int mem_index = get_mmuidx(oi);
+    int fast_ofs = tlb_mask_table_ofs(s, mem_index);
+    int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
+    int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
+    uint32_t insn = 0;
+
+    if (!addr64) {
+        tcg_tci_out_ext32u(s, TCG_REG_TMP, addr);
+        addr = TCG_REG_TMP;
+    }
+
+    new_pool_l8(s, 20, cur_tci_ptr(s), 0,
+                (TCGReg)args[0], addr, (TCGArg)args[2],
+                (int32_t)a_mask, (int32_t)mask_ofs,
+                (uint64_t)s->page_bits, s->page_mask, table_ofs);
+
+    insn = deposit32(insn, 0, 8, opc);
+    tcg_tci_out32(s, insn);
+}
+static void tcg_out_qemu_ld(TCGContext *s, TCGOpcode opc,
+                            const TCGArg *args, bool addr64)
+{
+    tcg_tci_out_qemu_ldst(s, opc, args, addr64);
+    tcg_wasm_out_qemu_ld(s, args, addr64);
+}
+static void tcg_out_qemu_st(TCGContext *s, TCGOpcode opc,
+                            const TCGArg *args, bool addr64)
+{
+    tcg_tci_out_qemu_ldst(s, opc, args, addr64);
+    tcg_wasm_out_qemu_st(s, args, addr64);
+}
+static void tcg_out_deposit_i32(TCGContext *s, TCGOpcode opc, TCGReg dest,
+                                TCGReg arg1, TCGReg arg2, int pos, int len)
+{
+    tcg_tci_out_op_rrrbb(s, opc, dest, arg1, arg2, pos, len);
+    tcg_wasm_out_deposit_i32(s, dest, arg1, arg2, pos, len);
+}
+static void tcg_out_deposit_i64(TCGContext *s, TCGOpcode opc, TCGReg dest,
+                                TCGReg arg1, TCGReg arg2, int pos, int len)
+{
+    tcg_tci_out_op_rrrbb(s, opc, dest, arg1, arg2, pos, len);
+    tcg_wasm_out_deposit_i64(s, dest, arg1, arg2, pos, len);
+}
+static void tcg_out_extract_i32(TCGContext *s, TCGOpcode opc, TCGReg dest,
+                                TCGReg arg1, int pos, int len)
+{
+    tcg_tci_out_op_rrbb(s, opc, dest, arg1, pos, len);
+    tcg_wasm_out_extract(s, dest, arg1, pos, len, TCG_TYPE_I32);
+}
+static void tcg_out_extract_i64(TCGContext *s, TCGOpcode opc, TCGReg dest,
+                                TCGReg arg1, int pos, int len)
+{
+    tcg_tci_out_op_rrbb(s, opc, dest, arg1, pos, len);
+    tcg_wasm_out_extract(s, dest, arg1, pos, len, TCG_TYPE_I64);
+}
+static void tcg_out_sextract_i32(TCGContext *s, TCGOpcode opc, TCGReg dest,
+                                 TCGReg arg1, int pos, int len)
+{
+    tcg_tci_out_op_rrbb(s, opc, dest, arg1, pos, len);
+    tcg_wasm_out_sextract(s, dest, arg1, pos, len, TCG_TYPE_I32);
+}
+static void tcg_out_sextract_i64(TCGContext *s, TCGOpcode opc, TCGReg dest,
+                                 TCGReg arg1, int pos, int len)
+{
+    tcg_tci_out_op_rrbb(s, opc, dest, arg1, pos, len);
+    tcg_wasm_out_sextract(s, dest, arg1, pos, len, TCG_TYPE_I64);
+}
+static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    tcg_tci_out_ext8s(s, type, ret, arg);
+    tcg_wasm_out_ext8s(s, type, ret, arg);
+}
+static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    tcg_tci_out_ext16s(s, type, ret, arg);
+    tcg_wasm_out_ext16s(s, type, ret, arg);
+}
+static void tcg_out_ext8u(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_tci_out_ext8u(s, ret, arg);
+    tcg_wasm_out_ext8u(s, ret, arg);
+}
+static void tcg_out_ext16u(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_tci_out_ext16u(s, ret, arg);
+    tcg_wasm_out_ext16u(s, ret, arg);
+}
+static void tcg_out_ext32s(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_tci_out_ext32s(s, ret, arg);
+    tcg_wasm_out_ext32s(s, ret, arg);
+}
+static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_tci_out_ext32u(s, ret, arg);
+    tcg_wasm_out_ext32u(s, ret, arg);
+}
+static void tcg_out_exts_i32_i64(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_tci_out_exts_i32_i64(s, ret, arg);
+    tcg_wasm_out_exts_i32_i64(s, ret, arg);
+}
+static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_tci_out_extu_i32_i64(s, ret, arg);
+    tcg_wasm_out_extu_i32_i64(s, ret, arg);
+}
+
+static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_tci_out_extrl_i64_i32(s, rd, rs);
+    tcg_wasm_out_extrl_i64_i32(s, rd, rs);
+}
+
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    tcg_tci_out_mov(s, type, ret, arg);
+    tcg_wasm_out_mov(s, type, ret, arg);
+    return true;
+}
+static void tcg_out_movi(TCGContext *s, TCGType type,
+                        TCGReg ret, tcg_target_long arg)
+{
+    tcg_tci_out_movi(s, type, ret, arg);
+    tcg_wasm_out_movi(s, type, ret, arg);
+}
+static void tcg_out_addi_ptr(TCGContext *s, TCGReg rd, TCGReg rs,
+                             tcg_target_long imm)
+{
+    g_assert_not_reached();
+}
+static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
+{
+    return false;
+}
+static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
+{
+    tcg_tci_out_exit_tb(s, arg);
+    tcg_wasm_out_exit_tb(s, arg);
+}
+static void tcg_out_goto_tb(TCGContext *s, int which)
+{
+    tcg_tci_out_goto_tb(s, which);
+    tcg_wasm_out_goto_tb(s, which, (uint32_t)s->code_ptr);
+}
+static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
+                        TCGReg base, intptr_t ofs)
+{
+    return false;
+}
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target,
+                         const TCGHelperInfo *info)
+{
+    tcg_tci_out_call(s, target, info);
+    tcg_wasm_out_call(s, target, info);
+}
+
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
+                       const TCGArg args[TCG_MAX_OP_ARGS],
+                       const int const_args[TCG_MAX_OP_ARGS])
+{
+    switch (opc) {
+    case INDEX_op_goto_ptr:
+        tcg_out_goto_ptr(s, opc, args[0]);
+        break;
+    case INDEX_op_br:
+        tcg_out_br(s, opc, arg_label(args[0]));
+        break;
+    case INDEX_op_setcond_i32:
+        tcg_out_setcond_i32(s, opc, args[3], args[0], args[1], args[2]);
+        break;
+    case INDEX_op_setcond_i64:
+        tcg_out_setcond_i64(s, opc, args[3], args[0], args[1], args[2]);
+        break;
+    case INDEX_op_movcond_i32:
+        tcg_out_movcond_i32(s, opc, args[5], args[0], args[1], args[2],
+                            args[3], args[4]);
+        break;
+    case INDEX_op_movcond_i64:
+        tcg_out_movcond_i64(s, opc, args[5], args[0], args[1], args[2],
+                            args[3], args[4]);
+        break;
+    case INDEX_op_ld_i64:
+        tcg_out_ld(s, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld8s_i64:
+        tcg_out_ld8s(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8u_i64:
+        tcg_out_ld8u(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld16s_i64:
+        tcg_out_ld16s(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16u_i64:
+        tcg_out_ld16u(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_ld32u_i64:
+        tcg_out_ld32u(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_ld_i32:
+    case INDEX_op_ld32s_i64:
+        tcg_out_ld32s(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_st_i64:
+        tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_st8_i32:
+    case INDEX_op_st8_i64:
+        tcg_out_st8(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_st16_i32:
+    case INDEX_op_st16_i64:
+        tcg_out_st16(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_st_i32:
+    case INDEX_op_st32_i64:
+        tcg_out_st32(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_add_i32:
+    case INDEX_op_add_i64:
+        tcg_out_add(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+        tcg_out_sub(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_mul_i32:
+    case INDEX_op_mul_i64:
+        tcg_out_mul(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
+        tcg_out_and(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
+        tcg_out_or(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
+        tcg_out_xor(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_shl_i32:
+        tcg_out_shl(s, opc, TCG_TYPE_I32, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_shl_i64:
+        tcg_out_shl(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_shr_i32:
+        tcg_out_shr_u(s, opc, TCG_TYPE_I32, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_shr_i64:
+        tcg_out_shr_u(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_sar_i32:
+        tcg_out_shr_s(s, opc, TCG_TYPE_I32, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_sar_i64:
+        tcg_out_shr_s(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_rotl_i32:
+        tcg_out_i32_rotl(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_rotl_i64:
+        tcg_out_i64_rotl(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_rotr_i32:
+        tcg_out_i32_rotr(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_rotr_i64:
+        tcg_out_i64_rotr(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_div_i32:
+        tcg_out_div_s(s, opc, TCG_TYPE_I32, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_div_i64:
+        tcg_out_div_s(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_divu_i32:
+        tcg_out_div_u(s, opc, TCG_TYPE_I32, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_divu_i64:
+        tcg_out_div_u(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_rem_i32:
+        tcg_out_rem_s(s, opc, TCG_TYPE_I32, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_rem_i64:
+        tcg_out_rem_s(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_remu_i32:
+        tcg_out_rem_u(s, opc, TCG_TYPE_I32, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_remu_i64:
+        tcg_out_rem_u(s, opc, TCG_TYPE_I64, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_andc_i32:
+    case INDEX_op_andc_i64:
+        tcg_out_andc(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_orc_i32:
+    case INDEX_op_orc_i64:
+        tcg_out_orc(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_eqv_i32:
+    case INDEX_op_eqv_i64:
+        tcg_out_eqv(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_nand_i32:
+    case INDEX_op_nand_i64:
+        tcg_out_nand(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_nor_i32:
+    case INDEX_op_nor_i64:
+        tcg_out_nor(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_clz_i32:
+        tcg_out_clz32(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_clz_i64:
+        tcg_out_clz64(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_ctz_i32:
+        tcg_out_ctz32(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_ctz_i64:
+        tcg_out_ctz64(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_brcond_i32:
+        tcg_out_brcond_i32(s, opc, args[2], args[0], args[1],
+                           arg_label(args[3]));
+        break;
+    case INDEX_op_brcond_i64:
+        tcg_out_brcond_i64(s, opc, args[2], args[0], args[1],
+                           arg_label(args[3]));
+        break;
+    case INDEX_op_neg_i32:
+    case INDEX_op_neg_i64:
+        tcg_out_neg(s, opc, args[0], args[1]);
+        break;
+    case INDEX_op_not_i32:
+    case INDEX_op_not_i64:
+        tcg_out_not(s, opc, args[0], args[1]);
+        break;
+    case INDEX_op_ctpop_i32:
+        tcg_out_ctpop_i32(s, opc, args[1], args[2]);
+        break;
+    case INDEX_op_ctpop_i64:
+        tcg_out_ctpop_i64(s, opc, args[1], args[2]);
+        break;
+    case INDEX_op_add2_i32:
+        tcg_out_add2_i32(s, opc, args[0], args[1], args[2], args[3],
+                         args[4], args[5]);
+        break;
+    case INDEX_op_add2_i64:
+        tcg_out_add2_i64(s, opc, args[0], args[1], args[2], args[3],
+                         args[4], args[5]);
+        break;
+    case INDEX_op_sub2_i32:
+        tcg_out_sub2_i32(s, opc, args[0], args[1], args[2], args[3],
+                         args[4], args[5]);
+        break;
+    case INDEX_op_sub2_i64:
+        tcg_out_sub2_i64(s, opc, args[0], args[1], args[2], args[3],
+                         args[4], args[5]);
+        break;
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld_i64:
+        tcg_out_qemu_ld(s, opc, args, s->addr_type == TCG_TYPE_I64);
+        break;
+    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st_i64:
+        tcg_out_qemu_st(s, opc, args, s->addr_type == TCG_TYPE_I64);
+        break;
+
+    case INDEX_op_extrl_i64_i32:
+        tcg_out_extrl_i64_i32(s, args[0], args[1]);
+        break;
+    case INDEX_op_mb:
+        tcg_tci_out_op_v(s, opc);
+        tcg_wasm_out8(s, 0x01); /* nop */
+        break;
+    case INDEX_op_extract_i32:
+        tcg_out_extract_i32(s, opc, args[0], args[1], args[2], args[3]);
+        break;
+    case INDEX_op_extract_i64:
+        tcg_out_extract_i64(s, opc, args[0], args[1], args[2], args[3]);
+        break;
+    case INDEX_op_sextract_i32:
+        tcg_out_sextract_i32(s, opc, args[0], args[1], args[2], args[3]);
+        break;
+    case INDEX_op_sextract_i64:
+        tcg_out_sextract_i64(s, opc, args[0], args[1], args[2], args[3]);
+        break;
+    case INDEX_op_deposit_i32:
+        tcg_out_deposit_i32(s, opc, args[0], args[1], args[2], args[3],
+                            args[4]);
+        break;
+    case INDEX_op_deposit_i64:
+        tcg_out_deposit_i64(s, opc, args[0], args[1], args[2], args[3],
+                            args[4]);
+        break;
+    case INDEX_op_bswap16_i32:
+        tcg_out_bswap16_i32(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_bswap16_i64:
+        tcg_out_bswap16_i64(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_bswap32_i32:
+        tcg_out_bswap32_i32(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_bswap32_i64:
+        tcg_out_bswap32_i64(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_bswap64_i64:
+        tcg_out_bswap64_i64(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_muls2_i32:
+        tcg_out_muls2_i32(s, opc, args[0], args[1], args[2], args[3]);
+        break;
+    case INDEX_op_mulu2_i32:
+        tcg_out_mulu2_i32(s, opc, args[0], args[1], args[2], args[3]);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+    return;
+}
+
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return false;
+}
+
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    g_assert_not_reached();
+}
+
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    g_assert_not_reached();
+}
+
+static void tcg_target_init(TCGContext *s)
+{
+    /* The current code uses uint8_t for tcg operations. */
+    tcg_debug_assert(tcg_op_defs_max <= UINT8_MAX);
+
+    /* Registers available for 32 bit operations. */
+    tcg_target_available_regs[TCG_TYPE_I32] = BIT(TCG_TARGET_NB_REGS) - 1;
+    /* Registers available for 64 bit operations. */
+    tcg_target_available_regs[TCG_TYPE_I64] = BIT(TCG_TARGET_NB_REGS) - 1;
+    /*
+     * The interpreter "registers" are in the local stack frame and
+     * cannot be clobbered by the called helper functions.  However,
+     * the interpreter assumes a 64-bit return value and assigns to
+     * the return value registers.
+     */
+    tcg_target_call_clobber_regs =
+        MAKE_64BIT_MASK(TCG_REG_R0, 128 / TCG_TARGET_REG_BITS);
+
+    s->reserved_regs = 0;
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
+
+    /* The call arguments come first, followed by the temp storage. */
+    tcg_set_frame(s, TCG_REG_CALL_STACK, TCG_STATIC_CALL_ARGS_SIZE,
+                  TCG_STATIC_FRAME_SIZE);
+}
+
+/* Generate global QEMU prologue and epilogue code. */
+static inline void tcg_target_qemu_prologue(TCGContext *s)
+{
+}
+
+static const uint8_t mod_1[] = {
+    0x0, 0x61, 0x73, 0x6d, /* magic */
+    0x01, 0x0, 0x0, 0x0,   /* version */
+    /* type section */
+    0x01, 0x80, 0x80, 0x80, 0x80, 0x00,
+    0x80, 0x80, 0x80, 0x80, 0x00,
+    /* "start" function */
+    0x60,
+    0x01, 0x7f,
+    0x01, 0x7f,
+    /* function to check asyncify state */
+    0x60,
+    0x0,
+    0x01, 0x7f,
+};
+
+static const uint8_t mod_2[] = {
+    /* import section */
+    0x02, 0x80, 0x80, 0x80, 0x80, 0x00,
+    0x80, 0x80, 0x80, 0x80, 0x00,
+    /* env.buffer */
+    0x03, 0x65, 0x6e, 0x76,
+    0x06, 0x62, 0x75, 0x66, 0x66, 0x65, 0x72,
+    0x02, 0x03, 0x00, 0x80, 0x80, 0x80, 0x80, 0x00,
+    /* helper.u */
+    0x06, 0x68, 0x65, 0x6c, 0x70, 0x65, 0x72,
+    0x01, 0x75,
+    0x00, 0x01,
+};
+
+static const uint8_t mod_3[] = {
+    /* function section */
+    0x03, 2, 1, 0x00,
+    /* global section */
+    0x06, 0x7e,
+    25,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    0x7e, 0x01, 0x42, 0x00, 0x0b,
+    /* export section */
+    0x07, 13,
+    1,
+    /* "start" function */
+    0x05, 0x73, 0x74, 0x61, 0x72, 0x74,
+    0x00, 0x80, 0x80, 0x80, 0x80, 0x00,
+};
+
+static const uint8_t mod_4[] = {
+    /* code section */
+    0x0a, 0x80, 0x80, 0x80, 0x80, 0x00,
+    1,
+    0x80, 0x80, 0x80, 0x80, 0x00,
+    /* variables */
+    0x2, 0x2, 0x7f, 0x1, 0x7e,
+};
+
+static int write_mod_1(TCGContext *s)
+{
+    void *base = s->code_ptr;
+    int helpers_num = helpers_len();
+
+    if (unlikely(((void *)s->code_ptr + sizeof(mod_1) + types_buf_len())
+                 > s->code_gen_highwater)) {
+        return -1;
+    }
+
+    memcpy(s->code_ptr, mod_1, sizeof(mod_1));
+    s->code_ptr += sizeof(mod_1);
+    linked_buf_write(types_buf_root, s->code_ptr);
+    s->code_ptr += types_buf_len();
+
+    uint32_t type_section_size = types_buf_len() + 14;
+    fill_uint32_leb128(base + 9, type_section_size);
+    fill_uint32_leb128(base + 14, HELPER_IDX_START + helpers_num + 1);
+
+    return 0;
+}
+
+static int write_mod_2(TCGContext *s)
+{
+    void *base = s->code_ptr;
+    int helpers_num = helpers_len();
+    void *section_base;
+
+    if (unlikely(((void *)s->code_ptr + sizeof(mod_2))
+                 > s->code_gen_highwater)) {
+        return -1;
+    }
+
+    memcpy(s->code_ptr, mod_2, sizeof(mod_2));
+    s->code_ptr += sizeof(mod_2);
+    section_base = s->code_ptr;
+    for (int i = 0; i < helpers_num; i++) {
+        int typeidx = HELPER_IDX_START + i + 1;
+        char buf[100];
+        int n;
+        *(uint8_t *)s->code_ptr++ = 6; /* helper */
+        *(uint8_t *)s->code_ptr++ = 0x68;
+        *(uint8_t *)s->code_ptr++ = 0x65;
+        *(uint8_t *)s->code_ptr++ = 0x6c;
+        *(uint8_t *)s->code_ptr++ = 0x70;
+        *(uint8_t *)s->code_ptr++ = 0x65;
+        *(uint8_t *)s->code_ptr++ = 0x72;
+        n = snprintf(buf, sizeof(buf), "%d", i);
+        s->code_ptr += write_uint32_leb128(s->code_ptr, n);
+        memcpy(s->code_ptr, buf, n);
+        s->code_ptr += n;
+        *(uint8_t *)s->code_ptr++ = 0x00; /* type(0) */
+        s->code_ptr += write_uint32_leb128(s->code_ptr, typeidx);
+    }
+
+    uint32_t import_section_size = 35 + (int)s->code_ptr - (int)section_base;
+    fill_uint32_leb128(base + 1, import_section_size);
+    fill_uint32_leb128(base + 6, HELPER_IDX_START + helpers_num + 1);
+    fill_uint32_leb128(base + 25, (uint32_t)(~0) / 65536);
+
+    return 0;
+}
+
+static int write_mod_3(TCGContext *s)
+{
+    void *base = s->code_ptr;
+
+    if (unlikely(((void *)s->code_ptr + sizeof(mod_3))
+                 > s->code_gen_highwater)) {
+        return -1;
+    }
+
+    memcpy(s->code_ptr, mod_3, sizeof(mod_3));
+    s->code_ptr += sizeof(mod_3);
+
+    int startidx = HELPER_IDX_START + helpers_len();
+    fill_uint32_leb128(base + 142, startidx);
+
+    return 0;
+}
+
+static int write_mod_4(TCGContext *s)
+{
+    void *base = s->code_ptr;
+
+    if (unlikely(((void *)s->code_ptr + sizeof(mod_4))
+                 > s->code_gen_highwater)) {
+        return -1;
+    }
+
+    memcpy(s->code_ptr, mod_4, sizeof(mod_4));
+    s->code_ptr += sizeof(mod_4);
+
+    int code_size = sub_buf_len() + 5;
+    fill_uint32_leb128(base + 1, code_size + 6);
+    fill_uint32_leb128(base + 7, code_size);
+
+    return 0;
+}
+
+static int write_mod_code(TCGContext *s)
+{
+    void *base = s->code_ptr;
+    int code_size = sub_buf_len();
+
+    if (unlikely(((void *)s->code_ptr + code_size) > s->code_gen_highwater)) {
+        return -1;
+    }
+    linked_buf_write(sub_buf_root, s->code_ptr);
+    s->code_ptr += code_size;
+    for (BlockPlaceholder *p = block_placeholder; p; p = p->next) {
+        uint8_t *ph = p->pos + base;
+        int blk = get_block_of_label(p->label);
+        tcg_debug_assert(blk >= 0);
+        *ph = 0x80;
+        fill_uint32_leb128(ph, blk);
+    }
+
+    return 0;
+}
+
+static void tcg_out_tb_start(TCGContext *s)
+{
+    int size;
+
+    init_sub_buf();
+    init_types_buf();
+    init_blocks();
+    init_label_info();
+    init_helpers();
+
+    /* TB starts from a header */
+    struct wasmTBHeader *h = (struct wasmTBHeader *)(s->code_buf);
+    s->code_ptr += sizeof(struct wasmTBHeader);
+
+    /* region to record the instance information */
+    h->info_ptr = s->code_ptr;
+    size = get_core_nums() * 4;
+    memset(s->code_ptr, 0, size);
+    s->code_ptr += size;
+
+    /* region to store counters */
+    h->counter_ptr = s->code_ptr;
+    size = get_core_nums() * 4;
+    memset(s->code_ptr, 0, size);
+    s->code_ptr += size;
+
+    /* TCI code starts here */
+    h->tci_ptr = s->code_ptr;
+
+    /* generate wasm code to initialize fundamental registers */
+    tcg_wasm_out_ctx_i32_load(s, DO_INIT_OFF);
+    tcg_wasm_out_op_i32_const(s, 0);
+    tcg_wasm_out_op_i32_ne(s);
+    tcg_wasm_out_op_if_noret(s);
+
+    tcg_wasm_out_op_global_get_r(s, TCG_AREG0);
+    tcg_wasm_out_op_i64_eqz(s);
+    tcg_wasm_out_op_if_noret(s);
+
+    tcg_wasm_out_ctx_i32_load(s, ENV_OFF);
+    tcg_wasm_out_op_i64_extend_i32_u(s);
+    tcg_wasm_out_op_global_set_r(s, TCG_AREG0);
+
+    tcg_wasm_out_ctx_i32_load(s, STACK_OFF);
+    tcg_wasm_out_op_i64_extend_i32_u(s);
+    tcg_wasm_out_op_global_set_r(s, TCG_REG_CALL_STACK);
+    tcg_wasm_out_op_end(s);
+
+    tcg_wasm_out_ctx_i32_store_const(s, DO_INIT_OFF, 0);
+    tcg_wasm_out_op_i64_const(s, 0);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+    tcg_wasm_out_op_end(s);
+
+    tcg_wasm_out_op_loop_noret(s);
+    tcg_wasm_out_op_global_get(s, BLOCK_PTR_IDX);
+    tcg_wasm_out_op_i64_eqz(s);
+    tcg_wasm_out_op_if_noret(s);
+}
+
+static int tcg_out_tb_end(TCGContext *s)
+{
+    int res;
+    struct wasmTBHeader *h = (struct wasmTBHeader *)(s->code_buf);
+
+    tcg_wasm_out_op_end(s); /* end if */
+    tcg_wasm_out_op_end(s); /* end loop */
+    tcg_wasm_out8(s, 0x0);  /* unreachable */
+    tcg_wasm_out_op_end(s); /* end func */
+
+    /* write wasm blob */
+    h->wasm_ptr = s->code_ptr;
+    res = write_mod_1(s);
+    if (res < 0) {
+        return res;
+    }
+    res = write_mod_2(s);
+    if (res < 0) {
+        return res;
+    }
+    res = write_mod_3(s);
+    if (res < 0) {
+        return res;
+    }
+    res = write_mod_4(s);
+    if (res < 0) {
+        return res;
+    }
+    res = write_mod_code(s);
+    if (res < 0) {
+        return res;
+    }
+    h->wasm_size = (int)s->code_ptr - (int)h->wasm_ptr;
+
+    /* record imported helper functions */
+    if (unlikely(((void *)s->code_ptr + 4 + helpers_len() * 4)
+                 > s->code_gen_highwater)) {
+        return -1;
+    }
+    h->import_ptr = s->code_ptr;
+    s->code_ptr += helpers_copy((uint32_t *)s->code_ptr);
+    h->import_size = (int)s->code_ptr - (int)h->import_ptr;
+
+    return 0;
+}
diff --git a/tcg/wasm32/tcg-target.h b/tcg/wasm32/tcg-target.h
new file mode 100644
index 0000000000..5690eec663
--- /dev/null
+++ b/tcg/wasm32/tcg-target.h
@@ -0,0 +1,65 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2009, 2011 Stefan Weil
+ *
+ * Based on tci/tcg-target.h
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef TCG_TARGET_H
+#define TCG_TARGET_H
+
+#define TCG_TARGET_INSN_UNIT_SIZE 1
+#define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
+
+/* Number of registers available. */
+#define TCG_TARGET_NB_REGS 16
+
+/* List of registers which are used by TCG. */
+typedef enum {
+    TCG_REG_R0 = 0,
+    TCG_REG_R1,
+    TCG_REG_R2,
+    TCG_REG_R3,
+    TCG_REG_R4,
+    TCG_REG_R5,
+    TCG_REG_R6,
+    TCG_REG_R7,
+    TCG_REG_R8,
+    TCG_REG_R9,
+    TCG_REG_R10,
+    TCG_REG_R11,
+    TCG_REG_R12,
+    TCG_REG_R13,
+    TCG_REG_R14,
+    TCG_REG_R15,
+
+    TCG_REG_TMP = TCG_REG_R13,
+    TCG_AREG0 = TCG_REG_R14,
+    TCG_REG_CALL_STACK = TCG_REG_R15,
+} TCGReg;
+
+#define HAVE_TCG_QEMU_TB_EXEC
+
+#endif /* TCG_TARGET_H */
-- 
2.25.1


