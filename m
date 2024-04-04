Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32210CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWAD-00022o-14; Thu, 04 Apr 2024 19:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA8-00022D-NF
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:28 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA6-0007jp-UV
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:28 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2a07b092c4fso1232885a91.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271985; x=1712876785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NiZ3HGz3Hc6pId3zVyG1cXL7lbYUMaIMlfQHI2GKrk=;
 b=rCCTP2zwJvm18oRXgEFscdvyGX57x5QUf+fhHUK7aHK87NFXdLCtYa215hquSP6Zwc
 I/W1mHDsmyXk9+Lsx8NzzDhK2kH3TLdOPyn1NLRjTHHCIwY3Af4wK5dI7jX4/2yYVzHF
 rccri7misYY0GOdPwhOgzpZ1EqvJZ3yf3rSSgtyvuZP8a+RFMijAq8bKu+tZdO1I5Ax9
 /yIVtF2WP5QHzc8C3iyesn+gtAPXVd7eIf2rfwKrqhzduvE6iahThiqSmHNJeGDzjdAh
 k6kLZCVFszdle5Wu70Vf1u6Nc2Y9ExcJsP6y2wWfgi2fOcFtFbRKMZ2LUi042N1OjnLK
 sePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271985; x=1712876785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6NiZ3HGz3Hc6pId3zVyG1cXL7lbYUMaIMlfQHI2GKrk=;
 b=KEM9daKXV5mq9qmNp56udsylDuPbUzVxMvoy2GCKvu9HYNuVV+vfIfWhY5kFavGJB5
 0euoEea6gl/BpPejnbUN2JJIJQU2NdlO3Knt9aSUakyJ6FH/e4U1AeYRwfAekJU6Z51t
 7e0QZEIitgcQWBx3Fn1D5y2ks60O90HmAVRGrCn4MyXMVbIJfWi/47vAY2RjXEfd3dvZ
 i4XiUW9MbbMOKeu6Yuc3NrR+Ve8lHRG8xMxMhSrlxRZz88J7ogvXqTdNIYykh+Q3+oQ9
 Uo1F6M337tHRoLsAC9lwMWo8IvksJBjqX4rlXCn1I83l6tYvMu0d2R2CGZyLetS0ed5w
 NHdw==
X-Gm-Message-State: AOJu0YzkXfIhkUjKOYgrHW73EAhzyPcMVasvCyRlXKQIk4paK7bKygBn
 CPQbOEZ19mVdlxmUsK1+eReP9l/zU2rFI59q7WdR9zt9HSO0qbXPQAprpqfrMEQ98sC70Mclb5+
 k
X-Google-Smtp-Source: AGHT+IEO9IQHigbKD0Z9Q3vxRREEefdFk2/mdTRg8ejIASFtKEhTb7GBp6rT9hik6cubo4FC4T+eFw==
X-Received: by 2002:a17:90a:15c9:b0:29f:67ad:7db0 with SMTP id
 w9-20020a17090a15c900b0029f67ad7db0mr1124772pjd.11.1712271985670; 
 Thu, 04 Apr 2024 16:06:25 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 09/21] plugins: Add PLUGIN_GEN_AFTER_TB
Date: Thu,  4 Apr 2024 13:05:59 -1000
Message-Id: <20240404230611.21231-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Delay test of plugin_tb->mem_helper until the inject pass.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c803fe8e96..1faa49cb8f 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -69,6 +69,7 @@ enum plugin_gen_from {
     PLUGIN_GEN_FROM_INSN,
     PLUGIN_GEN_FROM_MEM,
     PLUGIN_GEN_AFTER_INSN,
+    PLUGIN_GEN_AFTER_TB,
     PLUGIN_GEN_N_FROMS,
 };
 
@@ -609,20 +610,9 @@ static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
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
@@ -673,14 +663,11 @@ static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
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
@@ -806,9 +793,17 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
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


