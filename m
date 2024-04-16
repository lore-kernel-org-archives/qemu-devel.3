Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAC2C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 04:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwa5J-0007sz-9u; Tue, 16 Apr 2024 00:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5H-0007ox-PY
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:15 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5G-00079c-6j
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:15 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e2178b2cf2so36553085ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 21:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713240372; x=1713845172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/kvkzaV0z5p/8QW/Fxpj7Ie/nTETi6lfyNRR9fnonw=;
 b=R87zjJKIxmKNxfeEW385F8KhXvlfNIrfrIX7Mb9PKRcEaXJOcvaRcwGhKdJBKKq8z5
 Lnz6L0iDt/mVRAbLBztcQfYMJRV0rEEvs7al4p2GTJLxxymZpON4ayQT0sPOkPlituuT
 KEE1Du5IPm0BdYfXNNgo+xUwn2PwX+SPVSZTO4X+hvp1OduKZ9TkzcYaM9g/Zdw90bRK
 B90ZwIMhX7/A8tt0rhPRCxkwCZwcTR+mX1+C9P6T4q4Djivmw8kdBn/zDZ/hWqAd1hJA
 ITR6yDLeCb+EOoA1tOEaJMomndusyogUL9tFZqr9pBuUTXRknKqpKf76qh3nPm70eu++
 I+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713240372; x=1713845172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q/kvkzaV0z5p/8QW/Fxpj7Ie/nTETi6lfyNRR9fnonw=;
 b=NQLMOFhArE3SU3BjMjhlzj8cFmaTzcnUFadfyPt0grqJOH3a7NyFf+AUd1a7ktmSIJ
 tLk9E74IB0sMuZ+2hPe+gw1hD+qo/NRf3nzYfeFCF/7jcKuvzjdQcgtxV/Qk7aWqh/fP
 xql+paNVNw+tu2K2ZKgPFyBcWJoFGkm/WW1FCfCCKBVzCSNmhKGUy5/hwh62wE0FJ9GZ
 ux+POXWAouNT3g6+Fok+Pky1biClEmlsv73bmFs8XUjgNV0rl3rp9T23N2lu+Wx+QPi3
 Oi2rAoh2I7ND6SPFglg3DfReED+hZU5mBcNLn/IlYdjcQTO75mMmouxrPS3+Hr8t9Npz
 lgRw==
X-Gm-Message-State: AOJu0YzJybsAojQFvBHRpxZw114aDwxlpAxc/oOkQlyYcKMksNkiNfxE
 ytQz9iIXMzvyvUTYbbwn6WLuKjcEC6IMAcmxJ+QJqwgPAPK4iSFuUtwrIzmHRVgvV510/2xHTvU
 J
X-Google-Smtp-Source: AGHT+IHxzHiV/wDymWLdsHG5GLpfZDk9LcrGLdoQXOobcc2g3cOPQ+pO/zvhGEF83dLU/Ayrae3QpQ==
X-Received: by 2002:a17:903:287:b0:1e5:5be8:15af with SMTP id
 j7-20020a170903028700b001e55be815afmr16035469plr.17.1713240371908; 
 Mon, 15 Apr 2024 21:06:11 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a170902f68100b001e3e244e5c0sm8694439plg.78.2024.04.15.21.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 21:06:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH 1/7] tcg: Introduce INDEX_op_plugin_pc
Date: Mon, 15 Apr 2024 21:06:03 -0700
Message-Id: <20240416040609.1313605-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416040609.1313605-1-richard.henderson@linaro.org>
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Add an opcode to find a code address within the current insn,
for later use with unwinding.  Generate the code generically
using tcg_reg_alloc_do_movi.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  1 +
 include/tcg/tcg-opc.h       |  1 +
 tcg/tcg-op.c                |  5 +++++
 tcg/tcg.c                   | 10 ++++++++++
 4 files changed, 17 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 009e2778c5..a32c88a182 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -76,6 +76,7 @@ void tcg_gen_lookup_and_goto_ptr(void);
 
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
+void tcg_gen_plugin_pc(TCGv_ptr);
 
 /* 32 bit ops */
 
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 546eb49c11..087d1b82da 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -199,6 +199,7 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
+DEF(plugin_pc, 1, 0, 0, TCG_OPF_NOT_PRESENT)
 
 /* Replicate ld/st ops for 32 and 64-bit guest addresses. */
 DEF(qemu_ld_a32_i32, 1, 1, 1,
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index eff3728622..b8ca78cbe4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -322,6 +322,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     tcg_gen_op2(INDEX_op_plugin_mem_cb, tcgv_i64_arg(addr), meminfo);
 }
 
+void tcg_gen_plugin_pc(TCGv_ptr arg)
+{
+    tcg_gen_op1(INDEX_op_plugin_pc, tcgv_ptr_arg(arg));
+}
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d248c52e96..42e2b53729 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -4701,6 +4701,13 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     }
 }
 
+static void tcg_reg_alloc_plugin_pc(TCGContext *s, const TCGOp *op)
+{
+    tcg_reg_alloc_do_movi(s, arg_temp(op->args[0]),
+                          (uintptr_t)tcg_splitwx_to_rx(s->code_ptr),
+                          op->life, output_pref(op, 0));
+}
+
 /*
  * Specialized code generation for INDEX_op_dup_vec.
  */
@@ -6208,6 +6215,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         case INDEX_op_mov_vec:
             tcg_reg_alloc_mov(s, op);
             break;
+        case INDEX_op_plugin_pc:
+            tcg_reg_alloc_plugin_pc(s, op);
+            break;
         case INDEX_op_dup_vec:
             tcg_reg_alloc_dup(s, op);
             break;
-- 
2.34.1


