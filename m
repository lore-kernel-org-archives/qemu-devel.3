Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65391C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IV1-0005Eq-6w; Tue, 07 May 2024 06:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUl-0004tF-Uz
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUh-0002nu-OL
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZskpahCL8fMZ3dnYfpNiV+O41Ks34W1d8N4wIdihHY=;
 b=UircwwWAbpbDGU/NqOWQUm2EyoHVQDqWFbZgXo2UvV8aKFg/ZSN0y5J7L0vyktRa+0mVtK
 MNFYukX1X+DqmBQHm7atXqGLQmfdNdgsLefUn9td4KeKnq6Mz5EdVuZBnAKoPlXhKscxTi
 wdOBsZQaoAxXW3ZJPYBwBtVhYekArAQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-UYa4qWZfPEycikP14oyf_g-1; Tue, 07 May 2024 06:56:19 -0400
X-MC-Unique: UYa4qWZfPEycikP14oyf_g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59e9ac4c74so45500266b.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079378; x=1715684178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZskpahCL8fMZ3dnYfpNiV+O41Ks34W1d8N4wIdihHY=;
 b=nbfj/U4Vcp2Z8tcFSri0xgxU3i7fy7s+Leg05SAMDVqkK07n6ig1kPI7ZcaG3M9xPp
 QaEe5I6rcVS8XbR2SepszYrPXPyxNLulbT+baVXExOWf01aZdlH55c05ahBahUTP9Izl
 XpHddtxj6uwFCTnA6H7nx80Kt+Cvu9EtvSlX6lrZZpwKo74gkhU8hG3mj4v2ZBg83oM2
 b6BRFr2fVL7U+lRaKUEMK2CG34txCVOgzygOPZ1iD7kJOQBcXbXXRLH9DDPU5tmT3Q6J
 pWdfjxVPp4uUv/oNhmfhFE4dvQvH9FjGZWgm9edsJ7xyFL99d8RqiwvEJVjnvftjR/Rg
 fAkQ==
X-Gm-Message-State: AOJu0YxBJgNpV/FENqNmPqf0dJJeVrB5F1i2e3/yTy1F9p9EAhMeDyU3
 sLi+hRCz5SIg4C3/yXBmXpJvOjyZ2t5PVUaywRrAxaBbauvdBUaGhsXXn+U+e3Ng766IqtVIVcP
 AcF+isTyMkw2B027n7UxXhKpnXqb/coZFxB+e2VkJk28HIENt3fMSVtaKJKmPORYCjt+eRg0ys8
 O4B6e9/tyX//GVRfKWQt/guATV3XpY2oHP4rqY
X-Received: by 2002:a17:906:c141:b0:a59:bdb7:73f4 with SMTP id
 dp1-20020a170906c14100b00a59bdb773f4mr6341644ejc.61.1715079378004; 
 Tue, 07 May 2024 03:56:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlvzahWRjcgB9CFQ6MGRs4XBtUI00tbsz6Fm/AnyhxuXFrUtbJS8meZbkVrURwhwPFmPGsxw==
X-Received: by 2002:a17:906:c141:b0:a59:bdb7:73f4 with SMTP id
 dp1-20020a170906c14100b00a59bdb773f4mr6341628ejc.61.1715079377536; 
 Tue, 07 May 2024 03:56:17 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 hg12-20020a1709072ccc00b00a59b6eed3c4sm3380061ejc.45.2024.05.07.03.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/26] target/i386: extract gen_far_call/jmp,
 reordering temporaries
Date: Tue,  7 May 2024 12:55:26 +0200
Message-ID: <20240507105538.180704-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 93 +++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8bc1828a6bc..e5672df9b94 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2512,12 +2512,13 @@ static inline void gen_op_movl_T0_seg(DisasContext *s, X86Seg seg_reg)
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
@@ -2537,13 +2538,45 @@ static void gen_movl_seg_T0(DisasContext *s, X86Seg seg_reg)
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
@@ -3654,23 +3687,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -3684,19 +3704,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -5136,7 +5147,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             /* pop selector */
             gen_add_A0_im(s, 1 << dflag);
             gen_op_ld_v(s, dflag, s->T0, s->A0);
-            gen_op_movl_seg_T0_vm(s, R_CS);
+            gen_op_movl_seg_real(s, R_CS, s->T0);
             /* add stack offset */
             gen_stack_update(s, val + (2 << dflag));
         }
@@ -5181,10 +5192,11 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
2.45.0


