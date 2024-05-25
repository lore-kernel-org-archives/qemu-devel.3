Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23503C25B7A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfD-0002Og-PI; Sat, 25 May 2024 07:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApf9-0002Nj-G6
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApf7-000447-B7
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcaWSoqXnDbQEksQVvSiLMdeB+3Qnl+sHWRJxLEbkU8=;
 b=MYrOJ0aaSFIvpAtZGfkSyM1yHRBUeWRpfvMCA8aWLgcDlRlYW8iCVx/OgOfTct6TxslOI7
 4nXvDEoovbYUkrgKtThjfN/jvfEUWYYnbrj/yvZ3pE9fJNbwJXuCZfwY+8GH3CfqV//wVu
 gPhL324uy8GU6++CqL4hW4792zWfa14=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-DEqn0TjbNXaVsQq-NgC6Hw-1; Sat, 25 May 2024 07:34:00 -0400
X-MC-Unique: DEqn0TjbNXaVsQq-NgC6Hw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a5a812308daso206575266b.0
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636839; x=1717241639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JcaWSoqXnDbQEksQVvSiLMdeB+3Qnl+sHWRJxLEbkU8=;
 b=uhKkmWZ+Ivp0JfpuNa8eyJviz+MAkfV7+4UXbZqpBXVPsVTzBQoV8GASEKEhz4WfUg
 CC0LrfCxRj0dKgWzvFe+S8mG/QMgDgBhXb/7KCHlgenISpGU0zwNHgb9c133hy+B5tSp
 obu9PSwtF4oHsOyqfJvvEiK1I+BB/Jg2MEZyIOkav1YZOpqtVXLGEuOAuN5ARZuJTeRz
 7sKmmj8KbBlWe9fPRsZ1NCH0BMBxEZSEp06afr4xPFcGIRtsow5nAGG8wi8iEoGJzzvH
 bqaRroTsB5M9Ru76wzY0odkKLOFBcuOktAPpFqVYEw1eKrPiI7U90JFGZJSE6mhtmkSo
 wdXw==
X-Gm-Message-State: AOJu0YztxxbQTZxcjJe8knvlnm1P9wQ7b7j3zFdcVTRIAPUormhT2bwy
 znqnfhKa3YX5bWXUK6u2bx/Lun9cvunSQlbz9j9WGMpPEEem+nLT+oPeXKb7qKZ84zRTTT+pQfn
 j1Y2W8eF1jjfTT2OBf6f2Np9Ptsv8SRxLDc+ERzK1HKCKMszQGkWAUxhTVTuhm/V0INpjf+XRnC
 oiXFsr58fs4qrcquXdntffUT7jxdFy8+eWpXQt
X-Received: by 2002:a17:906:27cc:b0:a5a:3579:b908 with SMTP id
 a640c23a62f3a-a62643eb6abmr297257366b.38.1716636838848; 
 Sat, 25 May 2024 04:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl0jruTnLTGDbqG/GuyGRqGONohp4QcSUu36o1MBK0GeAQ9Zv0A/Rvtsmtqre92ZXKASK+3w==
X-Received: by 2002:a17:906:27cc:b0:a5a:3579:b908 with SMTP id
 a640c23a62f3a-a62643eb6abmr297255666b.38.1716636838389; 
 Sat, 25 May 2024 04:33:58 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c817ac8sm244081966b.2.2024.05.25.04.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:33:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/24] target/i386: set CC_OP in helpers if they want
 CC_OP_EFLAGS
Date: Sat, 25 May 2024 13:33:15 +0200
Message-ID: <20240525113332.1404158-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Mark cc_op as clean and do not spill it at the end of the translation block.
Technically this is a tiny bit less efficient, but:

* it results in translations that are a tiny bit smaller

* for most of these instructions, it is not unlikely that they are close to
the end of the basic block, in which case cc_op would not be overwritten

* anyway the cost is probably dwarfed by that of computing flags.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/ops_sse.h        |  8 ++++++++
 target/i386/tcg/fpu_helper.c |  2 ++
 target/i386/tcg/int_helper.c | 13 +++++++++----
 target/i386/tcg/seg_helper.c | 16 ++++++++--------
 target/i386/tcg/translate.c  | 12 ++++++------
 target/i386/tcg/emit.c.inc   | 22 +++++++++++-----------
 6 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 6a465a35fdb..f0aa1894aa2 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -1111,6 +1111,7 @@ void helper_ucomiss(CPUX86State *env, Reg *d, Reg *s)
     s1 = s->ZMM_S(0);
     ret = float32_compare_quiet(s0, s1, &env->sse_status);
     CC_SRC = comis_eflags[ret + 1];
+    CC_OP = CC_OP_EFLAGS;
 }
 
 void helper_comiss(CPUX86State *env, Reg *d, Reg *s)
@@ -1122,6 +1123,7 @@ void helper_comiss(CPUX86State *env, Reg *d, Reg *s)
     s1 = s->ZMM_S(0);
     ret = float32_compare(s0, s1, &env->sse_status);
     CC_SRC = comis_eflags[ret + 1];
+    CC_OP = CC_OP_EFLAGS;
 }
 
 void helper_ucomisd(CPUX86State *env, Reg *d, Reg *s)
@@ -1133,6 +1135,7 @@ void helper_ucomisd(CPUX86State *env, Reg *d, Reg *s)
     d1 = s->ZMM_D(0);
     ret = float64_compare_quiet(d0, d1, &env->sse_status);
     CC_SRC = comis_eflags[ret + 1];
+    CC_OP = CC_OP_EFLAGS;
 }
 
 void helper_comisd(CPUX86State *env, Reg *d, Reg *s)
@@ -1144,6 +1147,7 @@ void helper_comisd(CPUX86State *env, Reg *d, Reg *s)
     d1 = s->ZMM_D(0);
     ret = float64_compare(d0, d1, &env->sse_status);
     CC_SRC = comis_eflags[ret + 1];
+    CC_OP = CC_OP_EFLAGS;
 }
 #endif
 
@@ -1610,6 +1614,7 @@ void glue(helper_ptest, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
         cf |= (s->Q(i) & ~d->Q(i));
     }
     CC_SRC = (zf ? 0 : CC_Z) | (cf ? 0 : CC_C);
+    CC_OP = CC_OP_EFLAGS;
 }
 
 #define FMOVSLDUP(i) s->L((i) & ~1)
@@ -1966,6 +1971,7 @@ static inline unsigned pcmpxstrx(CPUX86State *env, Reg *d, Reg *s,
     validd--;
 
     CC_SRC = (valids < upper ? CC_Z : 0) | (validd < upper ? CC_S : 0);
+    CC_OP = CC_OP_EFLAGS;
 
     switch ((ctrl >> 2) & 3) {
     case 0:
@@ -2297,6 +2303,7 @@ void glue(helper_vtestps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
         cf |= (s->L(i) & ~d->L(i));
     }
     CC_SRC = ((zf >> 31) ? 0 : CC_Z) | ((cf >> 31) ? 0 : CC_C);
+    CC_OP = CC_OP_EFLAGS;
 }
 
 void glue(helper_vtestpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
@@ -2309,6 +2316,7 @@ void glue(helper_vtestpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
         cf |= (s->Q(i) & ~d->Q(i));
     }
     CC_SRC = ((zf >> 63) ? 0 : CC_Z) | ((cf >> 63) ? 0 : CC_C);
+    CC_OP = CC_OP_EFLAGS;
 }
 
 void glue(helper_vpmaskmovd_st, SUFFIX)(CPUX86State *env,
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index ece22a3553f..8df8cae6310 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -487,6 +487,7 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
     eflags = cpu_cc_compute_all(env) & ~(CC_Z | CC_P | CC_C);
     CC_SRC = eflags | fcomi_ccval[ret + 1];
+    CC_OP = CC_OP_EFLAGS;
     merge_exception_flags(env, old_flags);
 }
 
@@ -499,6 +500,7 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
     eflags = cpu_cc_compute_all(env) & ~(CC_Z | CC_P | CC_C);
     CC_SRC = eflags | fcomi_ccval[ret + 1];
+    CC_OP = CC_OP_EFLAGS;
     merge_exception_flags(env, old_flags);
 }
 
diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index 4cc59f15203..e1f92405282 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -187,6 +187,7 @@ void helper_aaa(CPUX86State *env)
     }
     env->regs[R_EAX] = (env->regs[R_EAX] & ~0xffff) | al | (ah << 8);
     CC_SRC = eflags;
+    CC_OP = CC_OP_EFLAGS;
 }
 
 void helper_aas(CPUX86State *env)
@@ -211,6 +212,7 @@ void helper_aas(CPUX86State *env)
     }
     env->regs[R_EAX] = (env->regs[R_EAX] & ~0xffff) | al | (ah << 8);
     CC_SRC = eflags;
+    CC_OP = CC_OP_EFLAGS;
 }
 
 void helper_daa(CPUX86State *env)
@@ -238,6 +240,7 @@ void helper_daa(CPUX86State *env)
     eflags |= parity_table[al]; /* pf */
     eflags |= (al & 0x80); /* sf */
     CC_SRC = eflags;
+    CC_OP = CC_OP_EFLAGS;
 }
 
 void helper_das(CPUX86State *env)
@@ -269,6 +272,7 @@ void helper_das(CPUX86State *env)
     eflags |= parity_table[al]; /* pf */
     eflags |= (al & 0x80); /* sf */
     CC_SRC = eflags;
+    CC_OP = CC_OP_EFLAGS;
 }
 
 #ifdef TARGET_X86_64
@@ -449,10 +453,11 @@ target_ulong HELPER(rdrand)(CPUX86State *env)
         error_free(err);
         /* Failure clears CF and all other flags, and returns 0.  */
         env->cc_src = 0;
-        return 0;
+        ret = 0;
+    } else {
+        /* Success sets CF and clears all others.  */
+        env->cc_src = CC_C;
     }
-
-    /* Success sets CF and clears all others.  */
-    env->cc_src = CC_C;
+    env->cc_op = CC_OP_EFLAGS;
     return ret;
 }
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 34ccabd8ce3..0301459004e 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -2326,7 +2326,7 @@ void helper_verr(CPUX86State *env, target_ulong selector1)
     int rpl, dpl, cpl;
 
     selector = selector1 & 0xffff;
-    eflags = cpu_cc_compute_all(env);
+    eflags = cpu_cc_compute_all(env) | CC_Z;
     if ((selector & 0xfffc) == 0) {
         goto fail;
     }
@@ -2351,11 +2351,11 @@ void helper_verr(CPUX86State *env, target_ulong selector1)
     } else {
         if (dpl < cpl || dpl < rpl) {
         fail:
-            CC_SRC = eflags & ~CC_Z;
-            return;
+            eflags &= ~CC_Z;
         }
     }
-    CC_SRC = eflags | CC_Z;
+    CC_SRC = eflags;
+    CC_OP = CC_OP_EFLAGS;
 }
 
 void helper_verw(CPUX86State *env, target_ulong selector1)
@@ -2364,7 +2364,7 @@ void helper_verw(CPUX86State *env, target_ulong selector1)
     int rpl, dpl, cpl;
 
     selector = selector1 & 0xffff;
-    eflags = cpu_cc_compute_all(env);
+    eflags = cpu_cc_compute_all(env) | CC_Z;
     if ((selector & 0xfffc) == 0) {
         goto fail;
     }
@@ -2385,9 +2385,9 @@ void helper_verw(CPUX86State *env, target_ulong selector1)
         }
         if (!(e2 & DESC_W_MASK)) {
         fail:
-            CC_SRC = eflags & ~CC_Z;
-            return;
+            eflags &= ~CC_Z;
         }
     }
-    CC_SRC = eflags | CC_Z;
+    CC_SRC = eflags;
+    CC_OP = CC_OP_EFLAGS;
 }
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 25c973e20c6..1b0485e01b3 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2984,7 +2984,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
             gen_update_cc_op(s);
             gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
             gen_helper_fucomi_ST0_FT0(tcg_env);
-            set_cc_op(s, CC_OP_EFLAGS);
+            assume_cc_op(s, CC_OP_EFLAGS);
             break;
         case 0x1e: /* fcomi */
             if (!(s->cpuid_features & CPUID_CMOV)) {
@@ -2993,7 +2993,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
             gen_update_cc_op(s);
             gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
             gen_helper_fcomi_ST0_FT0(tcg_env);
-            set_cc_op(s, CC_OP_EFLAGS);
+            assume_cc_op(s, CC_OP_EFLAGS);
             break;
         case 0x28: /* ffree sti */
             gen_helper_ffree_STN(tcg_env, tcg_constant_i32(opreg));
@@ -3052,7 +3052,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
             gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
             gen_helper_fucomi_ST0_FT0(tcg_env);
             gen_helper_fpop(tcg_env);
-            set_cc_op(s, CC_OP_EFLAGS);
+            assume_cc_op(s, CC_OP_EFLAGS);
             break;
         case 0x3e: /* fcomip */
             if (!(s->cpuid_features & CPUID_CMOV)) {
@@ -3062,7 +3062,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
             gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
             gen_helper_fcomi_ST0_FT0(tcg_env);
             gen_helper_fpop(tcg_env);
-            set_cc_op(s, CC_OP_EFLAGS);
+            assume_cc_op(s, CC_OP_EFLAGS);
             break;
         case 0x10 ... 0x13: /* fcmovxx */
         case 0x18 ... 0x1b:
@@ -3268,7 +3268,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             gen_helper_rdrand(s->T0, tcg_env);
             rm = (modrm & 7) | REX_B(s);
             gen_op_mov_reg_v(s, dflag, rm, s->T0);
-            set_cc_op(s, CC_OP_EFLAGS);
+            assume_cc_op(s, CC_OP_EFLAGS);
             break;
 
         default:
@@ -3655,7 +3655,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             } else {
                 gen_helper_verw(tcg_env, s->T0);
             }
-            set_cc_op(s, CC_OP_EFLAGS);
+            assume_cc_op(s, CC_OP_EFLAGS);
             break;
         default:
             goto unknown_op;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 3f2ae0aa7e7..e0ac21abe28 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -918,7 +918,7 @@ static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     } else {                                                                       \
         gen_helper_##lname##_ymm(tcg_env, OP_PTR1, OP_PTR2);                       \
     }                                                                              \
-    set_cc_op(s, CC_OP_EFLAGS);                                                    \
+    assume_cc_op(s, CC_OP_EFLAGS);                                                  \
 }
 UNARY_CMP_SSE(VPTEST,     ptest)
 UNARY_CMP_SSE(VTESTPS,    vtestps)
@@ -1079,7 +1079,7 @@ static void gen_AAA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_helper_aaa(tcg_env);
-    set_cc_op(s, CC_OP_EFLAGS);
+    assume_cc_op(s, CC_OP_EFLAGS);
 }
 
 static void gen_AAD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -1102,7 +1102,7 @@ static void gen_AAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_helper_aas(tcg_env);
-    set_cc_op(s, CC_OP_EFLAGS);
+    assume_cc_op(s, CC_OP_EFLAGS);
 }
 
 static void gen_ADC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -1566,14 +1566,14 @@ static void gen_DAA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_helper_daa(tcg_env);
-    set_cc_op(s, CC_OP_EFLAGS);
+    assume_cc_op(s, CC_OP_EFLAGS);
 }
 
 static void gen_DAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
     gen_helper_das(tcg_env);
-    set_cc_op(s, CC_OP_EFLAGS);
+    assume_cc_op(s, CC_OP_EFLAGS);
 }
 
 static void gen_DEC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -2353,14 +2353,14 @@ static void gen_PCMPESTRI(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     gen_helper_pcmpestri_xmm(tcg_env, OP_PTR1, OP_PTR2, imm);
-    set_cc_op(s, CC_OP_EFLAGS);
+    assume_cc_op(s, CC_OP_EFLAGS);
 }
 
 static void gen_PCMPESTRM(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     gen_helper_pcmpestrm_xmm(tcg_env, OP_PTR1, OP_PTR2, imm);
-    set_cc_op(s, CC_OP_EFLAGS);
+    assume_cc_op(s, CC_OP_EFLAGS);
     if ((s->prefix & PREFIX_VEX) && !s->vex_l) {
         tcg_gen_gvec_dup_imm(MO_64, offsetof(CPUX86State, xmm_regs[0].ZMM_X(1)),
                              16, 16, 0);
@@ -2371,14 +2371,14 @@ static void gen_PCMPISTRI(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     gen_helper_pcmpistri_xmm(tcg_env, OP_PTR1, OP_PTR2, imm);
-    set_cc_op(s, CC_OP_EFLAGS);
+    assume_cc_op(s, CC_OP_EFLAGS);
 }
 
 static void gen_PCMPISTRM(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
     gen_helper_pcmpistrm_xmm(tcg_env, OP_PTR1, OP_PTR2, imm);
-    set_cc_op(s, CC_OP_EFLAGS);
+    assume_cc_op(s, CC_OP_EFLAGS);
     if ((s->prefix & PREFIX_VEX) && !s->vex_l) {
         tcg_gen_gvec_dup_imm(MO_64, offsetof(CPUX86State, xmm_regs[0].ZMM_X(1)),
                              16, 16, 0);
@@ -3595,7 +3595,7 @@ static void gen_VCOMI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     SSEFunc_0_epp fn;
     fn = s->prefix & PREFIX_DATA ? gen_helper_comisd : gen_helper_comiss;
     fn(tcg_env, OP_PTR1, OP_PTR2);
-    set_cc_op(s, CC_OP_EFLAGS);
+    assume_cc_op(s, CC_OP_EFLAGS);
 }
 
 static void gen_VCVTPD2PS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -3982,7 +3982,7 @@ static void gen_VUCOMI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode
     SSEFunc_0_epp fn;
     fn = s->prefix & PREFIX_DATA ? gen_helper_ucomisd : gen_helper_ucomiss;
     fn(tcg_env, OP_PTR1, OP_PTR2);
-    set_cc_op(s, CC_OP_EFLAGS);
+    assume_cc_op(s, CC_OP_EFLAGS);
 }
 
 static void gen_VZEROALL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
-- 
2.45.1


