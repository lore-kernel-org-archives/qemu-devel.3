Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44ACCD1297
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEa6-0000d2-Od; Tue, 09 Apr 2024 12:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEa0-0000ac-Jk
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZh-00082c-OV
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDRyAYQEO1VEJbNs8swUTPMQb7B504Kpjs1Z+adXy3k=;
 b=UPsWgdhvp6q7k/xky2UqiuzaUQEfz0NzfE8+djBNCDcvDDobnRSnzt+cb26UrjzQ/b7ERO
 pZJlInT7Lgmtu2Fhib195wJHnfexwMVqzBcOGii+tlxt+2f0Magacn2ZaRz6NlvWSCAIyG
 m8XdVRPjSMdCYCUikcosnv+dP59Eit8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-dn70Q0enP3C1VJbkrFHPng-1; Tue, 09 Apr 2024 12:43:48 -0400
X-MC-Unique: dn70Q0enP3C1VJbkrFHPng-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-416612274e7so9280935e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681026; x=1713285826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDRyAYQEO1VEJbNs8swUTPMQb7B504Kpjs1Z+adXy3k=;
 b=iW1HHvi0+k16qVNTAtdODaOtIfvr9mo/CUIIzxCds6fR5xt5a2Din0WPojxRrRHZLg
 9PQTw3LBh0AstxMjx8Yga6YZYA5yiM7GDpF/OtMj+/cvCOMaSM1PwTERaMplmuO6nzeo
 NzzIpCcOPYLZf+vKYMTunjFZL8Oy5rlEVKCjOG4DLl7cluaAtFuJuni91jeE7iUfRj1u
 JHETGvKVXRnJJJEKgj2tBSDvWYcQFVC3+qVFGNs2VLeXITdEIQfr0ji+tkzunaC0KhzY
 KaKRZ8xTj/EtYlDMHPNiNxPxjvdwg8AmSzhsmbtxtoSmXXcZBBRi+z/VQI6OEFe3KMG8
 VXDw==
X-Gm-Message-State: AOJu0YzagYv3srqtWzYrry15ikU5d7vCrs0vHHKMyAPLNEyF8095mcz+
 ypH1Xi5KzQ8B09iTC24oam+8k3vcDHArHLcIzZ/maDsIi+inugeIK+FzFrkDfh2d1YbB9ybtEUw
 UHk8JDqDpWJYjeQ+76M11va654dUq9O04W6C3yrM3Dy24yybszzTtP/1zAm8KvjMn10nFL3YzK0
 S7FLPLo1nrNeTsIApyx5+zRfQ+YDpUQIaUqKq6
X-Received: by 2002:a05:600c:444d:b0:416:9877:e1a2 with SMTP id
 v13-20020a05600c444d00b004169877e1a2mr206971wmn.3.1712681026188; 
 Tue, 09 Apr 2024 09:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjKqo/yrOqYAjO22SCtomCl9KEwkp/fpBxwgeFyShCnwGNGrI0u2OWDakWonirUftwb16YFQ==
X-Received: by 2002:a05:600c:444d:b0:416:9877:e1a2 with SMTP id
 v13-20020a05600c444d00b004169877e1a2mr206958wmn.3.1712681025761; 
 Tue, 09 Apr 2024 09:43:45 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 l35-20020a05600c1d2300b0041680911b0fsm6902271wms.30.2024.04.09.09.43.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:43:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 07/19] target/i386: extract gen_far_call/jmp,
 reordering temporaries
Date: Tue,  9 Apr 2024 18:43:11 +0200
Message-ID: <20240409164323.776660-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409164323.776660-1-pbonzini@redhat.com>
References: <20240409164323.776660-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extract the code into new functions, and swap T0/T1 so that T0 corresponds
to the first immediate in the instruction stream.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 93 +++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e501d4701b6..c251fa21e6d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2518,12 +2518,13 @@ static inline void gen_op_movl_T0_seg(DisasContext *s, X86Seg seg_reg)
                      offsetof(CPUX86State,segs[seg_reg].selector));
 }
 
-static inline void gen_op_movl_seg_T0_vm(DisasContext *s, X86Seg seg_reg)
+static void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
 {
-    tcg_gen_ext16u_tl(s->T0, s->T0);
-    tcg_gen_st32_tl(s->T0, tcg_env,
+    TCGv selector = tcg_temp_new();
+    tcg_gen_ext16u_tl(selector, seg);
+    tcg_gen_st32_tl(selector, tcg_env,
                     offsetof(CPUX86State,segs[seg_reg].selector));
-    tcg_gen_shli_tl(cpu_seg_base[seg_reg], s->T0, 4);
+    tcg_gen_shli_tl(cpu_seg_base[seg_reg], selector, 4);
 }
 
 /* move T0 to seg_reg and compute if the CPU state may change. Never
@@ -2543,13 +2544,45 @@ static void gen_movl_seg_T0(DisasContext *s, X86Seg seg_reg)
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
     } else {
-        gen_op_movl_seg_T0_vm(s, seg_reg);
+        gen_op_movl_seg_real(s, seg_reg, s->T0);
         if (seg_reg == R_SS) {
             s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
         }
     }
 }
 
+static void gen_far_call(DisasContext *s)
+{
+    TCGv_i32 new_cs = tcg_temp_new_i32();
+    tcg_gen_trunc_tl_i32(new_cs, s->T1);
+    if (PE(s) && !VM86(s)) {
+        gen_helper_lcall_protected(tcg_env, new_cs, s->T0,
+                                   tcg_constant_i32(s->dflag - 1),
+                                   eip_next_tl(s));
+    } else {
+        TCGv_i32 new_eip = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(new_eip, s->T0);
+        gen_helper_lcall_real(tcg_env, new_cs, new_eip,
+                              tcg_constant_i32(s->dflag - 1),
+                              eip_next_i32(s));
+    }
+    s->base.is_jmp = DISAS_JUMP;
+}
+
+static void gen_far_jmp(DisasContext *s)
+{
+    if (PE(s) && !VM86(s)) {
+        TCGv_i32 new_cs = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(new_cs, s->T1);
+        gen_helper_ljmp_protected(tcg_env, new_cs, s->T0,
+                                  eip_next_tl(s));
+    } else {
+        gen_op_movl_seg_real(s, R_CS, s->T1);
+        gen_op_jmp_v(s, s->T0);
+    }
+    s->base.is_jmp = DISAS_JUMP;
+}
+
 static void gen_svm_check_intercept(DisasContext *s, uint32_t type)
 {
     /* no SVM activated; fast case */
@@ -3656,23 +3689,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             if (mod == 3) {
                 goto illegal_op;
             }
-            gen_op_ld_v(s, ot, s->T1, s->A0);
+            gen_op_ld_v(s, ot, s->T0, s->A0);
             gen_add_A0_im(s, 1 << ot);
-            gen_op_ld_v(s, MO_16, s->T0, s->A0);
-        do_lcall:
-            if (PE(s) && !VM86(s)) {
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                gen_helper_lcall_protected(tcg_env, s->tmp2_i32, s->T1,
-                                           tcg_constant_i32(dflag - 1),
-                                           eip_next_tl(s));
-            } else {
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
-                gen_helper_lcall_real(tcg_env, s->tmp2_i32, s->tmp3_i32,
-                                      tcg_constant_i32(dflag - 1),
-                                      eip_next_i32(s));
-            }
-            s->base.is_jmp = DISAS_JUMP;
+            gen_op_ld_v(s, MO_16, s->T1, s->A0);
+            gen_far_call(s);
             break;
         case 4: /* jmp Ev */
             if (dflag == MO_16) {
@@ -3686,19 +3706,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             if (mod == 3) {
                 goto illegal_op;
             }
-            gen_op_ld_v(s, ot, s->T1, s->A0);
+            gen_op_ld_v(s, ot, s->T0, s->A0);
             gen_add_A0_im(s, 1 << ot);
-            gen_op_ld_v(s, MO_16, s->T0, s->A0);
-        do_ljmp:
-            if (PE(s) && !VM86(s)) {
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                gen_helper_ljmp_protected(tcg_env, s->tmp2_i32, s->T1,
-                                          eip_next_tl(s));
-            } else {
-                gen_op_movl_seg_T0_vm(s, R_CS);
-                gen_op_jmp_v(s, s->T1);
-            }
-            s->base.is_jmp = DISAS_JUMP;
+            gen_op_ld_v(s, MO_16, s->T1, s->A0);
+            gen_far_jmp(s);
             break;
         case 6: /* push Ev */
             gen_push_v(s, s->T0);
@@ -5138,7 +5149,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             /* pop selector */
             gen_add_A0_im(s, 1 << dflag);
             gen_op_ld_v(s, dflag, s->T0, s->A0);
-            gen_op_movl_seg_T0_vm(s, R_CS);
+            gen_op_movl_seg_real(s, R_CS, s->T0);
             /* add stack offset */
             gen_stack_update(s, val + (2 << dflag));
         }
@@ -5182,10 +5193,11 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             offset = insn_get(env, s, ot);
             selector = insn_get(env, s, MO_16);
 
-            tcg_gen_movi_tl(s->T0, selector);
-            tcg_gen_movi_tl(s->T1, offset);
+            tcg_gen_movi_tl(s->T0, offset);
+            tcg_gen_movi_tl(s->T1, selector);
         }
-        goto do_lcall;
+        gen_far_call(s);
+        break;
     case 0xe9: /* jmp im */
         {
             int diff = (dflag != MO_16
@@ -5205,10 +5217,11 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             offset = insn_get(env, s, ot);
             selector = insn_get(env, s, MO_16);
 
-            tcg_gen_movi_tl(s->T0, selector);
-            tcg_gen_movi_tl(s->T1, offset);
+            tcg_gen_movi_tl(s->T0, offset);
+            tcg_gen_movi_tl(s->T1, selector);
         }
-        goto do_ljmp;
+        gen_far_jmp(s);
+        break;
     case 0xeb: /* jmp Jb */
         {
             int diff = (int8_t)insn_get(env, s, MO_8);
-- 
2.44.0


