Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A0CC54E58
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJIx-0002q4-U7; Fri, 15 Mar 2024 21:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIw-0002o5-F9
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIu-0000jN-Re
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:46 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso20597895ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554263; x=1711159063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nfW9NMKBYgHEbFge3X4GcZHuOXPsIrrYwIsT1Iscy8=;
 b=wH9mQHDC+n/2lF/qyOb2bDJsJAT9iKUQqg8xbVnOYYozynBEGMBT/V4CbQqirt9wqv
 mEommrnEYan0yHt9tX3GNy4c4mGmGJxW5Rr/SRr+bI8gK11O2rp6sR5izHHgGL8PRPDQ
 lj6EnkJbO8ymSpZf/X2PdIol/7Mvw+CASRAdW0604EWUmN9IQxH4DRRrYNzwh8nXT8X3
 GyivU8oP/v/Yli2IFTt0iVfyg62Aiwg7dKro4VgbMiio3axl4cxL6n6XTHuneZqq7CxT
 w9SOy72IN2lDoEoFEqU9nmW2voDeAQ83lPoEHANGNjCVgx8gf5fyq2aSBHNUes1LqwEx
 46+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554263; x=1711159063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nfW9NMKBYgHEbFge3X4GcZHuOXPsIrrYwIsT1Iscy8=;
 b=I8erLO32o1f2LDxAimvttIR7Zh2c/IMVtEgkfEu/SOYCMfCZE0tiEYRNLjFu9FRq3s
 7rP5BTaoILYfFlacUPISLHk2ATPj2t6if3oxaKzoB8xnOmyOb735AIaBrWZLvuuC1b84
 ARBnTV4bEYtYGedo3zEpCpb1IfOp/7RSVAx7QPOcD3cFJ5MYVH5Pubkv3Su/eGrggrKM
 nekDmngNx3j9j7Hevhdo3LAUrgJ9RNlTEJ3Y8Gdv7kXiI3ilBRueeoUNLIfZWsnH/Ja8
 BZ7tQ0Qw23saKPerpGgWCzVGhfs2oZfV2ECnFYUgB/+jQ2xlrKGYsqsyk960NkvUS6zR
 bEMg==
X-Gm-Message-State: AOJu0YwGNv/YiwgH1xjvaoh5K7FsaZHq6aCsNm8yjhv008TE6m+5ZePj
 UcVcxD1lfGEpM+nYagb4svDNJG5JtQP3JPZ+J5u8NLH/7VfWn2Ga+85FLOzhtdePqG0hM7QHztL
 H
X-Google-Smtp-Source: AGHT+IEZjLrftSXGjhrEbOh9DDLf6V9GHnvLyv+Hmf5WZLlvNn2g8xNLGb/YCksvb8M1iXA0zix/IA==
X-Received: by 2002:a17:902:f68c:b0:1df:fd30:8b2d with SMTP id
 l12-20020a170902f68c00b001dffd308b2dmr72873plg.50.1710554263625; 
 Fri, 15 Mar 2024 18:57:43 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 09/22] plugins: Add PLUGIN_GEN_AFTER_TB
Date: Fri, 15 Mar 2024 15:57:07 -1000
Message-Id: <20240316015720.3661236-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Delay test of plugin_tb->mem_helper until the inject pass.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index f92aa80510..aa74e580bd 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -75,6 +75,7 @@ enum plugin_gen_from {
     PLUGIN_GEN_FROM_INSN,
     PLUGIN_GEN_FROM_MEM,
     PLUGIN_GEN_AFTER_INSN,
+    PLUGIN_GEN_AFTER_TB,
     PLUGIN_GEN_N_FROMS,
 };
 
@@ -615,20 +616,9 @@ static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
 /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
 void plugin_gen_disable_mem_helpers(void)
 {
-    /*
-     * We could emit the clearing unconditionally and be done. However, this can
-     * be wasteful if for instance plugins don't track memory accesses, or if
-     * most TBs don't use helpers. Instead, emit the clearing iff the TB calls
-     * helpers that might access guest memory.
-     *
-     * Note: we do not reset plugin_tb->mem_helper here; a TB might have several
-     * exit points, and we want to emit the clearing from all of them.
-     */
-    if (!tcg_ctx->plugin_tb->mem_helper) {
-        return;
+    if (tcg_ctx->plugin_insn) {
+        tcg_gen_plugin_cb(PLUGIN_GEN_AFTER_TB);
     }
-    tcg_gen_st_ptr(tcg_constant_ptr(NULL), tcg_env,
-                   offsetof(CPUState, plugin_mem_cbs) - offsetof(ArchCPU, env));
 }
 
 static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
@@ -679,14 +669,11 @@ static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
     inject_mem_enable_helper(ptb, insn, begin_op);
 }
 
-static void gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
-                                   struct qemu_plugin_insn *insn)
+static void gen_disable_mem_helper(void)
 {
-    if (insn->mem_helper) {
-        tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
-                       offsetof(CPUState, plugin_mem_cbs) -
-                       offsetof(ArchCPU, env));
-    }
+    tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
+                   offsetof(CPUState, plugin_mem_cbs) -
+                   offsetof(ArchCPU, env));
 }
 
 static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
@@ -812,9 +799,17 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
             tcg_ctx->emit_before_op = op;
 
             switch (from) {
+            case PLUGIN_GEN_AFTER_TB:
+                if (plugin_tb->mem_helper) {
+                    gen_disable_mem_helper();
+                }
+                break;
+
             case PLUGIN_GEN_AFTER_INSN:
                 assert(insn != NULL);
-                gen_disable_mem_helper(plugin_tb, insn);
+                if (insn->mem_helper) {
+                    gen_disable_mem_helper();
+                }
                 break;
 
             case PLUGIN_GEN_FROM_TB:
-- 
2.34.1


