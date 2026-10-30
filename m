Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5980606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lnu9uFQZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsW9-0006AA-62; Fri, 30 Oct 2026 15:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVg-00063V-BJ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:34 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVe-00008x-5E
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:32 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6ddef424972so853119eaf.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793389408; x=1793994208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4TPiWxPcL0oaR5SpRTfp9lcMqH99uPLgLl4P4JCSLM0=;
 b=lnu9uFQZMkUXO7ReE2xAKlcy8MdRJ3tW9nDf4dEzFv3HuaKZrPQIGyMOtO9aRYn4wN
 VNPMEEioMlDMt/7oC8jBZFIGU2gKkeQ+M3Upxtob+TevzWG/wLU4EC1H0Vt0D5RAwBah
 oslUISdu39zNW7IS2o4GoweFrKNwM5YKZosVtdZu5haeR1n/Ag9fXDtzKGo3L4X66/G/
 trtq2k9BOrGbMAke3XHLpEUGEUqlo3bfRBBnva14y3f2H9d2hjlvCyuryqO51HTD+llL
 i8fLy5+erJmxDQaEyJyvtjNAvJZulm4blfiaWRNuMdwaofBgUcrlAB0nlVysBPmoZBUZ
 /GiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389408; x=1793994208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4TPiWxPcL0oaR5SpRTfp9lcMqH99uPLgLl4P4JCSLM0=;
 b=VnzDUMQd/TJGv7nidoylnkUzN2ZFQvuvbbHgwb5VS1jaj/fGBTphSn/m3yAAWmRXUa
 drcWH8cpvW0h7nFuDahPaONsIHpIWbGmqbF9S9FzhOU8FJEOKfnG+Lwy0QxYyIHeBoU4
 euSBa1YNXME66374dKmyCqcJR7/QeWwSHZlCQIe5vlVaXnfizAuNxnq31xWGsxbdbxOA
 1403n8sxt4KMA8OtcViV07q2hsurU5Z7rD/L7GKCVBtqxqBwxIMp/26fMFKecSaIzH+b
 gq0dAukTteHRUv8fc5p20PPRdpgEbXmgMyYa3myrNjdRr35hC/mbh9oWiARp5/g5M9pA
 /tVQ==
X-Gm-Message-State: AFq9FYLQqq+4fv+3xWJhAK0N4FIs235gI5OoinIXC6EHS/dzpEdG2zKb
 g/jcPveSCaSXu+m4oGZ12o1FGFlNN8fuuFgosb7/RXBLgTANHOCTO/mwtASdnLPclmkKV4zuDG/
 Flx/M
X-Gm-Gg: AYBFou1axbBup9avzy6XNMH4ZXP6nyUMgdmm36xEqTMENzcQNDR6gUfIvABFttYU/ga
 ShhiuwcbH1W+lEwm3YHnF44FJq/wFK72kKfH/DsgMitl9zad8POW1vWO9qBGm5qrN++meA4Lquo
 l4JRT4RyfgMQm/OlDN7GyBIUuE09jUEKSoaumGl2usXrmmWqhYea5XD37kjIsRMTYZy8rvORION
 D+jFcrGjgoOz0wFUR7D8A9RmzykPlhxZ0HFAjbCoHyzCWl2tMj5/C1kOQgh6/19Lpd6z7hhuP3q
 qKZ1CMvhC076gTZdEkvhfKDaMtW76plw5gbwAkzq+8PfVBxyxogNskPqzkM3fKG3i8u9kPIfX8f
 IoXtE5GIFz6b+YAfIwyDx09UUPj0xWPS6rqxfjQjq4cTzRwaUt+DiUhlI7NVepaftSpoAFbcBLg
 +wEIcCqvynpwvf0jqtf8mLmlZooUIDkRAn/idEPQt4TWIMT7WYT3m5gS/5BLKk8IZgOD9amcZNn
 442a19r19IInr193xxF37WQt6NTdZOnHAFuAPxu2VztCjZtX8V1h91Ed1ScT7PvJdzC1+sxzh33
 DNL04+fusenVwQqaTSAISktRz10epdH3llI=
X-Received: by 2002:a05:6820:814:b0:6c1:f38e:7053 with SMTP id
 006d021491bc7-714f24f8d11mr2469476eaf.3.1793389407600; 
 Fri, 30 Oct 2026 12:43:27 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e77c8sm2654768a34.2.2026.10.30.12.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:43:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 5/9] target/arm: Split out gen_indirect_branch
Date: Fri, 30 Oct 2026 14:43:14 -0500
Message-ID: <20261030194318.319310-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030194318.319310-1-richard.henderson@linaro.org>
References: <20261030194318.319310-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

Use this instead of DISAS_JUMP.  Existing indirect branches
now end the TB with DISAS_NORETURN.  Share the code with
gen_goto_tb when use_goto_tb is false.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 51 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4289b65fdd..c8d1251f13 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -562,6 +562,17 @@ static void gen_goto_tb_int(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
     tcg_gen_exit_tb(s->base.tb, tb_slot_idx);
 }
 
+static bool gen_indirect_branch(DisasContext *s)
+{
+    if (s->ss_active) {
+        gen_step_complete_exception(s);
+    } else {
+        tcg_gen_lookup_and_goto_ptr();
+    }
+    s->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
 static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
 {
     if (use_goto_tb(s, s->pc_curr + diff)) {
@@ -569,12 +580,7 @@ static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
         s->base.is_jmp = DISAS_NORETURN;
     } else {
         gen_a64_update_pc(s, diff);
-        if (s->ss_active) {
-            gen_step_complete_exception(s);
-        } else {
-            tcg_gen_lookup_and_goto_ptr();
-            s->base.is_jmp = DISAS_NORETURN;
-        }
+        gen_indirect_branch(s);
     }
 }
 
@@ -1921,8 +1927,7 @@ static bool trans_BR(DisasContext *s, arg_r *a)
 {
     set_btype_for_br(s, a->rn);
     gen_a64_set_pc(s, cpu_reg(s, a->rn));
-    s->base.is_jmp = DISAS_JUMP;
-    return true;
+    return gen_indirect_branch(s);
 }
 
 static bool trans_BLR(DisasContext *s, arg_r *a)
@@ -1937,8 +1942,7 @@ static bool trans_BLR(DisasContext *s, arg_r *a)
     tcg_gen_mov_i64(cpu_reg(s, 30), link);
 
     set_btype_for_blr(s);
-    s->base.is_jmp = DISAS_JUMP;
-    return true;
+    return gen_indirect_branch(s);
 }
 
 static bool trans_RET(DisasContext *s, arg_r *a)
@@ -1950,8 +1954,7 @@ static bool trans_RET(DisasContext *s, arg_r *a)
     } else {
         gen_a64_set_pc(s, target);
     }
-    s->base.is_jmp = DISAS_JUMP;
-    return true;
+    return gen_indirect_branch(s);
 }
 
 static TCGv_i64 auth_branch_target(DisasContext *s, TCGv_i64 dst,
@@ -1987,8 +1990,7 @@ static bool trans_BRAZ(DisasContext *s, arg_braz *a)
     dst = auth_branch_target(s, cpu_reg(s, a->rn), tcg_constant_i64(0), !a->m);
     set_btype_for_br(s, a->rn);
     gen_a64_set_pc(s, dst);
-    s->base.is_jmp = DISAS_JUMP;
-    return true;
+    return gen_indirect_branch(s);
 }
 
 static bool trans_BLRAZ(DisasContext *s, arg_braz *a)
@@ -2009,8 +2011,7 @@ static bool trans_BLRAZ(DisasContext *s, arg_braz *a)
     tcg_gen_mov_i64(cpu_reg(s, 30), link);
 
     set_btype_for_blr(s);
-    s->base.is_jmp = DISAS_JUMP;
-    return true;
+    return gen_indirect_branch(s);
 }
 
 static bool trans_RETA(DisasContext *s, arg_reta *a)
@@ -2028,8 +2029,7 @@ static bool trans_RETA(DisasContext *s, arg_reta *a)
     } else {
         gen_a64_set_pc(s, dst);
     }
-    s->base.is_jmp = DISAS_JUMP;
-    return true;
+    return gen_indirect_branch(s);
 }
 
 static bool trans_BRA(DisasContext *s, arg_bra *a)
@@ -2042,8 +2042,7 @@ static bool trans_BRA(DisasContext *s, arg_bra *a)
     dst = auth_branch_target(s, cpu_reg(s,a->rn), cpu_reg_sp(s, a->rm), !a->m);
     set_btype_for_br(s, a->rn);
     gen_a64_set_pc(s, dst);
-    s->base.is_jmp = DISAS_JUMP;
-    return true;
+    return gen_indirect_branch(s);
 }
 
 static bool trans_BLRA(DisasContext *s, arg_bra *a)
@@ -2064,8 +2063,7 @@ static bool trans_BLRA(DisasContext *s, arg_bra *a)
     tcg_gen_mov_i64(cpu_reg(s, 30), link);
 
     set_btype_for_blr(s);
-    s->base.is_jmp = DISAS_JUMP;
-    return true;
+    return gen_indirect_branch(s);
 }
 
 static bool trans_ERET(DisasContext *s, arg_ERET *a)
@@ -11240,11 +11238,13 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_a64_update_pc(dc, 4);
             /* fall through */
         case DISAS_EXIT:
-        case DISAS_JUMP:
             gen_step_complete_exception(dc);
             break;
         case DISAS_NORETURN:
             break;
+        case DISAS_JUMP:
+            /* Use gen_indirect_branch instead. */
+            g_assert_not_reached();
         }
     } else {
         switch (dc->base.is_jmp) {
@@ -11261,10 +11261,11 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             break;
         case DISAS_UPDATE_NOCHAIN:
             gen_a64_update_pc(dc, 4);
-            /* fall through */
-        case DISAS_JUMP:
             tcg_gen_lookup_and_goto_ptr();
             break;
+        case DISAS_JUMP:
+            /* Use gen_indirect_branch instead. */
+            g_assert_not_reached();
         case DISAS_NORETURN:
         case DISAS_SWI:
             break;
-- 
2.53.0


