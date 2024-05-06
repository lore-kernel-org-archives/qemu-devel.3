Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F848C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tRw-0004zN-VA; Mon, 06 May 2024 04:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tR5-00048A-Le
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQp-0002OE-3e
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V7Ulx1XR/K45AzccAXi5aClLc/wlOMjo/qPh6aMlDVA=;
 b=TKc2yArGTkUKpakOoTJdHYuL4/zf8kdlm/U56m9PUkrqhxnhHnCiwnNaC7bkgrHTWBUof+
 7UMI39V7MKMBKMRHW9ep0NmqacADrI9lpSrPyiTTGrCi1k4+b21LNxU2NDGxl/43V9gEmz
 WVDO7G3AJtkKWnnR06SCx7BPSEaVDcs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-DI7LZRDvOVKzGbr0ifS5uw-1; Mon, 06 May 2024 04:10:41 -0400
X-MC-Unique: DI7LZRDvOVKzGbr0ifS5uw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a599b55056bso83942966b.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983039; x=1715587839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7Ulx1XR/K45AzccAXi5aClLc/wlOMjo/qPh6aMlDVA=;
 b=KB09e09zinKQHHZW5VCuoFADRfmB1Q3vZXDDPz5EAEhZenrR/6xwPw9P7OfK8twgCD
 HvVcsxw0vBqDuvlRRBCqeuNCpmOPFWOqUp8cP8M2LqcCowBnaHS0/VH91ikKmkSsufjD
 VXnu3EtfDySXDY+AVbBy2qTKtE+uu5Sx2oMq3cbWpYSwp2mOpbNwGKpSoNEIWnfXqP31
 iMx2MDmrKXn7PRgXxt/V8UpuwRVV2sTlpTHIvrKvIZcwmHyJnGkjEpPTXx4BPgWc8fx9
 HG9N6qzr9YZCLE6KuQHSOVnHMZJtkLKnNcK1nysuy1oxhwccfjcgck3r1lBKTxSBKjMO
 7f5A==
X-Gm-Message-State: AOJu0Yz5afVuitdrGn50CpoR2VbZaJgBlOGToLGz4Ne4zCgAsvPDu7Fz
 ekuycoIP4gZ66RLL5AjCGLnPeY5UcRxzvxiAxWTYcooWxdb5Ypa4Ha+j0Epju+vK47ZW4bu5LM4
 DecfSaEO58HEHVRBm/Ftynuyfl02C9zQ+8dGU2iU73Zq2oxiejc1mS+xzoYa+rKZWGgKmAdElRf
 NbukLv2VMidRop+S2nK9LB6tGg/mGu+GBgw2wY
X-Received: by 2002:a17:906:f59d:b0:a59:a8f8:7df with SMTP id
 cm29-20020a170906f59d00b00a59a8f807dfmr4259936ejd.52.1714983039653; 
 Mon, 06 May 2024 01:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBDzc4QwkcrtfhgnoMtEx68yUgbuOQdEMxszeR3ZBheDJrrc3sI4/sf1/HmnYtqMAqvlll7g==
X-Received: by 2002:a17:906:f59d:b0:a59:a8f8:7df with SMTP id
 cm29-20020a170906f59d00b00a59a8f807dfmr4259920ejd.52.1714983039354; 
 Mon, 06 May 2024 01:10:39 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a1709067c4800b00a59a9cfec7esm2641488ejp.133.2024.05.06.01.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 13/25] target/i386: extract gen_far_call/jmp,
 reordering temporaries
Date: Mon,  6 May 2024 10:09:45 +0200
Message-ID: <20240506080957.10005-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 93 +++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8a9c265ae51..4069bd4f125 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2511,12 +2511,13 @@ static inline void gen_op_movl_T0_seg(DisasContext *s, X86Seg seg_reg)
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
@@ -2536,13 +2537,45 @@ static void gen_movl_seg_T0(DisasContext *s, X86Seg seg_reg)
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
@@ -3653,23 +3686,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -3683,19 +3703,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -5135,7 +5146,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             /* pop selector */
             gen_add_A0_im(s, 1 << dflag);
             gen_op_ld_v(s, dflag, s->T0, s->A0);
-            gen_op_movl_seg_T0_vm(s, R_CS);
+            gen_op_movl_seg_real(s, R_CS, s->T0);
             /* add stack offset */
             gen_stack_update(s, val + (2 << dflag));
         }
@@ -5180,10 +5191,11 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -5204,10 +5216,11 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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


