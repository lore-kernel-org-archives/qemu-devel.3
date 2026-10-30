Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE1606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Aw5KofhM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrlr-0006s5-DT; Fri, 30 Oct 2026 14:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrli-0006rO-Lh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:03 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlg-0004nM-18
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:01 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b0e21048f8so10201097b3.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386558; x=1793991358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EyjEAsI6aq4Z4MAsWw4dQNTOpngWoSWPLuZe2/6GC+E=;
 b=Aw5KofhM6oI/K7bOzsDpeP9sWEXIbRTxGYteE0YZLojD2xD/t7Qeqm+yt6IN/pt7TG
 PaGz5YE0NFeGs7CY3gqHh69gcaUv0+LGPCEuZfNxiR3n+S5HH3XCa63kIiP3MKOLz5ic
 Z5qDkwJnOThbew2cyrRzIseDfuLzTHtLdAF6Lli2EtZEgov02OzZBCwjWu/mfmirs28o
 JOhdhhmcA1uoyWZzMitRulnJ+U09sX02wPwoqH9/2+mWI4FpnZiHZMlHV9O2FUlimU0v
 G/8JYNbsZYuJlV3UbseTWxMh22r70ZGiucScbT0M8TQ5qo4IKqanrpgEUmo+iVyToetq
 dFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386558; x=1793991358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EyjEAsI6aq4Z4MAsWw4dQNTOpngWoSWPLuZe2/6GC+E=;
 b=yqFfpaqUkjoPl+qXL/1eyLqN54ulKBl41mhlsGO7X75LsbmXt890bGKTp97yRl9Jic
 L3xaMD7KK5oZZ45hbzL+c0lc2KKN+msEtlbkmbNnQv3RzKGG/rRRukQ0fe+/2uS3PbsR
 8CLNxyr26QeWbVV0blI5QvPnzo0wDFWrLN6o/vLnoG/NSnGdAVr+I+i/AcE9vz+rlCqx
 PoIaOmQ3qK+HOsb/KpULdPdq8tVkbcIJc2BwWylH9JAhI/Z6d3XmigEc+D18rIiF4ECy
 tPVf0lIXPMYAbVvlvy5KNXOJNlMRjx6inShHSIOVSYNJ/r0b9dRRsby8UrxlpqoNKoea
 s12Q==
X-Gm-Message-State: AFq9FYJaPAXha8LaBiCBv7mA5Fh0o6h8Wt8m5LiwgAxGgij5wT+/e2NV
 sP+U1n8WCoc62n9ybU8DP0qZX3zf/ibXAjNGne0AI88SDWBuJmviIihtXN4iZXIEqBqPl1DwR6w
 YlpTK
X-Gm-Gg: AYBFou2Qe7EUCy0JSnRI+hIjfrv6b2efKx6t12GAQFHQZNlPlNLSs4SReHHB3czFaJg
 sy1hTvIEyFxg1e6T24NaPqiN7oPZwqxbegljVHOmgaIBKRMuO6PXHhy/2kTGvnfXflfuD5I34/+
 wnUIcjs9gz+TCIdC5hsJQE1zieJd4ugHvb9HtClmWyTigawKztTWqPUnRVioWIpyvdh5d36Qw6j
 Yt+p7Rw4wPGBVXhRqdUmlf1zEjBb39dM+E46H0Nze8M0acNPEbYrluCS/aqKip1dv/dV2BDjpbj
 2nagsro6gFHQApN7Mft3LfUOSAwlRhdsH2TkIZC72/n0Wn2zdrx93FRJzihgttDXugMIAgOB79w
 cLPGxBGaJn/dSIecBL9dv/pu+HHldD3q+XsRcwdIFOzpQ+KnbcZjwmkURPttkzi2Xnn2WiYwleo
 3+5coo8dTxeDKyaMdnRRPlcxyiJ93O4KX/+8Eojd9NCn2SPbosbDVzFHzhTf9Mv0l6iDiZXak5h
 J/RiReB7b+xyaBzMu1VKF3lX89hF91x9a+PsvgSjIl/cjXTcKu4U5X0Clui2Q2V5I+nitZuOFMc
 zkO6HBkt7nR7+YjNi4P9ZcCf9VYXN9YsnBZc
X-Received: by 2002:a05:690c:e64c:20b0:8b0:7e6e:3dab with SMTP id
 00721157ae682-8b2b6710f0amr16171397b3.14.1793386558289; 
 Fri, 30 Oct 2026 11:55:58 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:55:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 02/14] target/alpha: Use tcg_gen_goto_jc{3}_i64
Date: Fri, 30 Oct 2026 13:55:39 -0500
Message-ID: <20261030185551.193092-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We can use tcg_gen_goto_jc_i64 for direct or indirect branches, where
flags are known to not change.  We can use tcg_gen_goto_jc3_i64 in
gen_call_pal where flags are known to change in a very specific way.

Introduce DISAS_PC_STALE_NOJC as a case where flags are changing
in an unpredictable way and must therefore use the runtime lookup.

Introduce DISAS_PC_STALE_NOCHAIN as a case where we must return
to the main loop.

Remove DISAS_PC_STALE and use DISAS_TOO_MANY instead, as they
wind up having the same semantics.

End the translation block when setting PS or FEN, as they represent
changes in tbflags.  This avoids a subsequent insn incorrectly chaining
via the jump cache and failing the assert.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 60 ++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 6f18b8d1af..ecb4ac4b02 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -80,9 +80,10 @@ struct DisasContext {
 /* Target-specific return values from translate_one, indicating the
    state of the TB.  Note that DISAS_NEXT indicates that we are not
    exiting the TB.  */
-#define DISAS_PC_UPDATED_NOCHAIN  DISAS_TARGET_0
-#define DISAS_PC_UPDATED          DISAS_TARGET_1
-#define DISAS_PC_STALE            DISAS_TARGET_2
+#define DISAS_PC_UPDATED          DISAS_TARGET_0
+#define DISAS_PC_STALE_NOJC       DISAS_TARGET_1
+#define DISAS_PC_STALE_NOCHAIN    DISAS_TARGET_2
+#define DISAS_PC_UPDATED_NOCHAIN  DISAS_TARGET_3
 
 /* global register indexes */
 static TCGv_i64 cpu_std_ir[31];
@@ -449,7 +450,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, int32_t disp)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         gen_pc_disp(ctx, cpu_pc, disp);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_i64(cpu_pc);
     }
 }
 
@@ -1096,8 +1097,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             }
 
             /* Allow interrupts to be recognized right away.  */
-            gen_pc_disp(ctx, cpu_pc, 0);
-            return DISAS_PC_UPDATED_NOCHAIN;
+            return DISAS_PC_STALE_NOCHAIN;
 
         case 0x36:
             /* RDPS */
@@ -1148,6 +1148,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             tcg_gen_ori_i64(tmp, tmp, 1);
         } else {
             st_flag_byte(tcg_constant_i64(1), ENV_FLAG_PAL_SHIFT);
+            ctx->tbflags = deposit32(ctx->tbflags, ENV_FLAG_PAL_SHIFT, 8, 1);
         }
         tcg_gen_st_i64(tmp, tcg_env, offsetof(CPUAlphaState, exc_addr));
 
@@ -1156,7 +1157,9 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
                          palcode & 0x80
                          ? 0x2000 + (palcode - 0x80) * 64
                          : 0x1000 + palcode * 64);
-        return DISAS_PC_UPDATED;
+
+        tcg_gen_goto_jc3_i64(cpu_pc, load_zero(ctx), ctx->tbflags);
+        return DISAS_NORETURN;
     }
 #endif
 }
@@ -1191,8 +1194,7 @@ static int cpu_pr_data(int pr)
 
 static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv_i64 va, int regno)
 {
-    void (*helper)(TCGv_i64);
-    int data;
+    int data, ret = DISAS_NEXT;
 
     switch (regno) {
     case 32 ... 39:
@@ -1202,17 +1204,16 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv_i64 va, int regno)
         break;
 
     case 250: /* WALLTIME */
-        helper = gen_helper_get_walltime;
-        goto do_helper;
-    case 249: /* VMTIME */
-        helper = gen_helper_get_vmtime;
-    do_helper:
         if (translator_io_start(&ctx->base)) {
-            helper(va);
-            return DISAS_PC_STALE;
-        } else {
-            helper(va);
+            ret = DISAS_TOO_MANY; /* i/o insns must be last in tb */
         }
+        gen_helper_get_walltime(va);
+        break;
+    case 249: /* VMTIME */
+        if (translator_io_start(&ctx->base)) {
+            ret = DISAS_TOO_MANY; /* i/o insns must be last in tb */
+        }
+        gen_helper_get_vmtime(va);
         break;
 
     case 0: /* PS */
@@ -1236,7 +1237,7 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv_i64 va, int regno)
         break;
     }
 
-    return DISAS_NEXT;
+    return ret;
 }
 
 static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv_i64 vb, int regno)
@@ -1264,12 +1265,12 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv_i64 vb, int regno)
     case 252:
         /* HALT */
         gen_helper_halt(vb);
-        return DISAS_PC_STALE;
+        return DISAS_PC_STALE_NOCHAIN;
 
     case 251:
         /* ALARM */
         if (translator_io_start(&ctx->base)) {
-            ret = DISAS_PC_STALE;
+            ret = DISAS_TOO_MANY; /* i/o insns must be last in tb */
         }
         gen_helper_set_alarm(tcg_env, vb);
         break;
@@ -1287,10 +1288,11 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv_i64 vb, int regno)
 
     case 0: /* PS */
         st_flag_byte(vb, ENV_FLAG_PS_SHIFT);
-        break;
+        return DISAS_PC_STALE_NOJC; /* flags updated */
+
     case 1: /* FEN */
         st_flag_byte(vb, ENV_FLAG_FEN_SHIFT);
-        break;
+        return DISAS_PC_STALE_NOJC; /* flags updated */
 
     default:
         /* The basic registers are data only, and unknown registers
@@ -2289,7 +2291,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             /* RPCC */
             va = dest_gpr(ctx, ra);
             if (translator_io_start(&ctx->base)) {
-                ret = DISAS_PC_STALE;
+                ret = DISAS_TOO_MANY; /* i/o insns must be last in tb */
             }
             gen_helper_load_pcc(va, tcg_env);
             break;
@@ -2905,12 +2907,16 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     case DISAS_TOO_MANY:
         gen_goto_tb(ctx, 0, 0);
         break;
-    case DISAS_PC_STALE:
-        gen_pc_disp(ctx, cpu_pc, 0);
-        /* FALLTHRU */
     case DISAS_PC_UPDATED:
+        tcg_gen_goto_jc_i64(cpu_pc);
+        break;
+    case DISAS_PC_STALE_NOJC:
+        gen_pc_disp(ctx, cpu_pc, 0);
         tcg_gen_lookup_and_goto_ptr();
         break;
+    case DISAS_PC_STALE_NOCHAIN:
+        gen_pc_disp(ctx, cpu_pc, 0);
+        /* fallthru */
     case DISAS_PC_UPDATED_NOCHAIN:
         tcg_gen_exit_tb(NULL, 0);
         break;
-- 
2.53.0


