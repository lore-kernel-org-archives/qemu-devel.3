Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863E9C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QR2-0004sf-8n; Mon, 13 May 2024 03:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPU-0002vj-1i
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPO-0001PW-LT
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41f9ce16ed8so40523375e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586460; x=1716191260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWVLc39b8wIMsAc1+ocgu4+wlVtjWoOjilzL1JEXEXE=;
 b=Kz15b5vpiZSsTCdQCR5u9rBtGOy21eyjt7wB/lzkqm3vLI3W05sAy+cL0I7Urmap2P
 k3eruzTXNgk0emg4EeaGrINmwtaOjcl34D4/9zVWBpn/+vYOZJhgsuKVUnsqYN5xUt2n
 UJCfMtIMv3N+wmmyUHdOTnzqFJwP7M6xM1vSXuGb1jdbTJqeLyJbFeVtRJzZZn85nAvb
 UOJaugitj/Fxtrn2NKHFebECeduYrAOgiI7GlfxoESxqnBUovRNKIwq+LhNgRgaBKeEy
 1scGX2oA5DMjZnC4AZjF9IlslvMadSEQwbk8F34vRRpqhZtPsm1ZmB4QUBPgf598920C
 Hhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586460; x=1716191260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWVLc39b8wIMsAc1+ocgu4+wlVtjWoOjilzL1JEXEXE=;
 b=gJmgDFSTJDBFFyld+XRDPtcGBPjfR+PHDUpw/O8pof85ZgStUutNVt++zOxoDX7GRz
 eJbntTB5aJjqaSgCxjeDP9hrQ2VuwAR2IpK6yzA1CU9jmn7pRcLxev95alcJr+QhTulX
 Mx0vZrMmrSTgTRXTZlO/UVAa3vbqJy7o8WZ4B0F6u1aKM+pKwNR3GCjNUnm+9z8XJM5W
 yQMgJ4YuCMq/aMdDcMDfrE+O8nhf03YBYnsf7VtDmdB3Mb2AkMQi3qBb8iQW0XwjCLxn
 bR2pzwXo85ytlgsNlJAD+W/tzxtZnmws9k9bYjmHo3uqUkY9nFzCXgDCqyKmYzSe/Lsz
 WMOQ==
X-Gm-Message-State: AOJu0YxVJtqNcOHkXv60uUI4UhWb9NF2gIYouCzQcWHPP1uZEnkLX9fj
 J44wXGYKbsoVi5vaCXvGuWQWE7qD8tiO36DgIJuA0qnhf71zVAAKG1QME95og4e06RBHNF4kRpM
 BU3s=
X-Google-Smtp-Source: AGHT+IHJjLiQmsvXTSlWJhfiQzRxfPQ17XqU0KhdlxHJxFK0ByaWqSrf86//e3RL2MXisHCF3590Vw==
X-Received: by 2002:a05:600c:3548:b0:41a:6edd:6c1d with SMTP id
 5b1f17b1804b1-41feac55e10mr78362825e9.32.1715586460562; 
 Mon, 13 May 2024 00:47:40 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 30/45] target/hppa: Use delay_excp for conditional trap on
 overflow
Date: Mon, 13 May 2024 09:47:02 +0200
Message-Id: <20240513074717.130949-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  1 -
 target/hppa/int_helper.c |  2 +-
 target/hppa/op_helper.c  |  7 -------
 target/hppa/translate.c  | 21 +++++++++++++--------
 4 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 3d0d143aed..c12b48a04a 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,5 +1,4 @@
 DEF_HELPER_2(excp, noreturn, env, int)
-DEF_HELPER_FLAGS_2(tsv, TCG_CALL_NO_WG, void, env, tl)
 
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 1aa3e88ef1..97e5f0b9a7 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -134,13 +134,13 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         switch (i) {
         case EXCP_ILL:
         case EXCP_BREAK:
+        case EXCP_OVERFLOW:
         case EXCP_COND:
         case EXCP_PRIV_REG:
         case EXCP_PRIV_OPR:
             /* IIR set via translate.c.  */
             break;
 
-        case EXCP_OVERFLOW:
         case EXCP_ASSIST:
         case EXCP_DTLB_MISS:
         case EXCP_NA_ITLB_MISS:
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index a8b69fd481..66cad78a57 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -42,13 +42,6 @@ G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra)
     cpu_loop_exit_restore(cs, ra);
 }
 
-void HELPER(tsv)(CPUHPPAState *env, target_ulong cond)
-{
-    if (unlikely((target_long)cond < 0)) {
-        hppa_dynamic_excp(env, EXCP_OVERFLOW, GETPC());
-    }
-}
-
 static void atomic_store_mask32(CPUHPPAState *env, target_ulong addr,
                                 uint32_t val, uint32_t mask, uintptr_t ra)
 {
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7fa0c86a8f..d061b30191 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1135,6 +1135,17 @@ static void gen_tc(DisasContext *ctx, DisasCond *cond)
     }
 }
 
+static void gen_tsv(DisasContext *ctx, TCGv_i64 *sv, bool d)
+{
+    DisasCond cond = do_cond(ctx, /* SV */ 12, d, NULL, NULL, *sv);
+    DisasDelayException *e = delay_excp(ctx, EXCP_OVERFLOW);
+
+    tcg_gen_brcond_i64(cond.c, cond.a0, cond.a1, e->lab);
+
+    /* In the non-trap path, V is known zero. */
+    *sv = tcg_constant_i64(0);
+}
+
 static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
                    TCGv_i64 in2, unsigned shift, bool is_l,
                    bool is_tsv, bool is_tc, bool is_c, unsigned cf, bool d)
@@ -1177,10 +1188,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
     if (is_tsv || cond_need_sv(c)) {
         sv = do_add_sv(ctx, dest, in1, in2, orig_in1, shift, d);
         if (is_tsv) {
-            if (!d) {
-                tcg_gen_ext32s_i64(sv, sv);
-            }
-            gen_helper_tsv(tcg_env, sv);
+            gen_tsv(ctx, &sv, d);
         }
     }
 
@@ -1281,10 +1289,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     if (is_tsv || cond_need_sv(c)) {
         sv = do_sub_sv(ctx, dest, in1, in2);
         if (is_tsv) {
-            if (!d) {
-                tcg_gen_ext32s_i64(sv, sv);
-            }
-            gen_helper_tsv(tcg_env, sv);
+            gen_tsv(ctx, &sv, d);
         }
     }
 
-- 
2.34.1


