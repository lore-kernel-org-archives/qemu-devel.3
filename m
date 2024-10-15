Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C219D216B1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNB-00064y-06; Tue, 15 Oct 2024 10:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iN9-0005wX-D6
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iN6-0003Kq-DM
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GdFlWxJMTrzm50p3oZABiEDSS+HAMOexFk9JYBpAXp8=;
 b=VD5GdhoyaS2glDpXOenWqD0JHaDXg2+j+5m9t7JZENbBDrHRpfMWKEj+wuSyVGiiTwqi8J
 pDc7+0mQHxklmoZPkOtUsDiUtaLwYT9d1ZVUxOnIDHiXGnMB0K4Sj8AOVbueDOLIh6AoQ9
 VqNEjEF2M2P3+LTsrunBg+8BQNd/Zcg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-vMUEOElkMHykUZ_o_QNg2w-1; Tue, 15 Oct 2024 10:17:58 -0400
X-MC-Unique: vMUEOElkMHykUZ_o_QNg2w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43114c47615so28571595e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001876; x=1729606676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GdFlWxJMTrzm50p3oZABiEDSS+HAMOexFk9JYBpAXp8=;
 b=T+qX5JQURG0q3wmpbQY0nPie85gNazqwRxqkHA4kyXLAP+B0ckc1PrV4j+gK/0WRMQ
 p/KkcxbZCzL37kleF2d/k2esJfA1HWyAeSvHv0cTamz+gVWS5NHOu605Om/bmiTi3kjq
 QVxL3lBk3o4qAdXBo1kz/KGqavCRzrX5Pf1Q1xIBrUksvXdAhGI+z6+Z6qGTl0w7sNXP
 wkrcH08AIe8sK8ZIShYcLdFmXzVLHLwO1JdZTZ2REHF8jpd+74xTB0aOfGO2ihxt0zsO
 jygZeop2CaBLsZ8JnVCQ/RBer4jimz2/dK5P/A/h6nosBGAsl7UzLUSAKjbz3qSlQWTK
 RsmA==
X-Gm-Message-State: AOJu0Yw678TSsWlmkoDL5LzJPl6nm7m9bVYrVDIMsyP6XsVtX3zVVECJ
 5xbgZgUA3CqX9ZHmGwo7EpX4aB/LF7OEHOKc81hlgN0fs5kOTu72o4OtqCwyVewWyY/kpMX0hJ1
 eE0eBiqRqBGkV7UNtCX5TMrsgbavuZLh6Km7fUwWNQboWc8WPiVFgT4EdhfEQNLwIv5yTbbifF2
 OUp8jnOO+z3ZLZBleRGV2smR78hsy9i91yvxR2gRI=
X-Received: by 2002:a05:600c:1d0b:b0:42f:8fcd:486c with SMTP id
 5b1f17b1804b1-4312561a417mr101871615e9.33.1729001875658; 
 Tue, 15 Oct 2024 07:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDwzbnO2wLL/AO6Z3G8n+lCAyedwFrldIdfmzuZokKBYQ/PieBubhvFcwzYVZRz4O175y+qg==
X-Received: by 2002:a05:600c:1d0b:b0:42f:8fcd:486c with SMTP id
 5b1f17b1804b1-4312561a417mr101871195e9.33.1729001874909; 
 Tue, 15 Oct 2024 07:17:54 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a13bsm1694705f8f.13.2024.10.15.07.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/25] target/i386: decode address before going back to
 translate.c
Date: Tue, 15 Oct 2024 16:16:58 +0200
Message-ID: <20241015141711.528342-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

There are now relatively few unconverted opcodes in translate.c (there
are 13 of them including 8 for x87), and all of them have the same
format with a mod/rm byte and no immediate.  A good next step is
to remove the early bail out to disas_insn_x87/disas_insn_old,
instead giving these legacy translator functions the same prototype
as the other gen_* functions.

To do this, the X86DecodeInsn can be passed down to the places that
used to fetch address bytes from the instruction stream.  To make
sure that everything is done cleanly, the CPUX86State* argument is
removed.

As part of the unification, the gen_lea_modrm() name is now free,
so rename gen_load_ea() to gen_lea_modrm().  This is as good a name
and it makes the changes to translate.c easier to review.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  14 ++-
 target/i386/tcg/translate.c      | 152 +++++++++++++------------------
 target/i386/tcg/decode-new.c.inc |  53 ++++++-----
 target/i386/tcg/emit.c.inc       |   2 +-
 4 files changed, 103 insertions(+), 118 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index e4cdf5e3c4f..bebc77bd54b 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -264,12 +264,13 @@ typedef enum X86VEXSpecial {
 
 typedef struct X86OpEntry  X86OpEntry;
 typedef struct X86DecodedInsn X86DecodedInsn;
+struct DisasContext;
 
 /* Decode function for multibyte opcodes.  */
-typedef void (*X86DecodeFunc)(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b);
+typedef void (*X86DecodeFunc)(struct DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b);
 
 /* Code generation function.  */
-typedef void (*X86GenFunc)(DisasContext *s, X86DecodedInsn *decode);
+typedef void (*X86GenFunc)(struct DisasContext *s, X86DecodedInsn *decode);
 
 struct X86OpEntry {
     /* Based on the is_decode flags.  */
@@ -316,6 +317,14 @@ typedef struct X86DecodedOp {
     };
 } X86DecodedOp;
 
+typedef struct AddressParts {
+    int def_seg;
+    int base;
+    int index;
+    int scale;
+    target_long disp;
+} AddressParts;
+
 struct X86DecodedInsn {
     X86OpEntry e;
     X86DecodedOp op[3];
@@ -333,3 +342,4 @@ struct X86DecodedInsn {
     uint8_t b;
 };
 
+static void gen_lea_modrm(struct DisasContext *s, X86DecodedInsn *decode);
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 59b67042cd9..be68cde1baa 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -29,6 +29,7 @@
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "helper-tcg.h"
+#include "decode-new.h"
 
 #include "exec/log.h"
 
@@ -1520,14 +1521,6 @@ static inline uint64_t x86_ldq_code(CPUX86State *env, DisasContext *s)
 
 /* Decompose an address.  */
 
-typedef struct AddressParts {
-    int def_seg;
-    int base;
-    int index;
-    int scale;
-    target_long disp;
-} AddressParts;
-
 static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
                                     int modrm, bool is_vsib)
 {
@@ -1686,24 +1679,11 @@ static TCGv gen_lea_modrm_1(DisasContext *s, AddressParts a, bool is_vsib)
     return ea;
 }
 
-static void gen_lea_modrm(CPUX86State *env, DisasContext *s, int modrm)
-{
-    AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
-    TCGv ea = gen_lea_modrm_1(s, a, false);
-    gen_lea_v_seg(s, ea, a.def_seg, s->override);
-}
-
-static void gen_nop_modrm(CPUX86State *env, DisasContext *s, int modrm)
-{
-    (void)gen_lea_modrm_0(env, s, modrm, false);
-}
-
 /* Used for BNDCL, BNDCU, BNDCN.  */
-static void gen_bndck(CPUX86State *env, DisasContext *s, int modrm,
+static void gen_bndck(DisasContext *s, X86DecodedInsn *decode,
                       TCGCond cond, TCGv_i64 bndv)
 {
-    AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
-    TCGv ea = gen_lea_modrm_1(s, a, false);
+    TCGv ea = gen_lea_modrm_1(s, decode->mem, false);
 
     tcg_gen_extu_tl_i64(s->tmp1_i64, ea);
     if (!CODE64(s)) {
@@ -1715,8 +1695,9 @@ static void gen_bndck(CPUX86State *env, DisasContext *s, int modrm,
 }
 
 /* generate modrm load of memory or register. */
-static void gen_ld_modrm(CPUX86State *env, DisasContext *s, int modrm, MemOp ot)
+static void gen_ld_modrm(DisasContext *s, X86DecodedInsn *decode, MemOp ot)
 {
+    int modrm = s->modrm;
     int mod, rm;
 
     mod = (modrm >> 6) & 3;
@@ -1724,14 +1705,15 @@ static void gen_ld_modrm(CPUX86State *env, DisasContext *s, int modrm, MemOp ot)
     if (mod == 3) {
         gen_op_mov_v_reg(s, ot, s->T0, rm);
     } else {
-        gen_lea_modrm(env, s, modrm);
+        gen_lea_modrm(s, decode);
         gen_op_ld_v(s, ot, s->T0, s->A0);
     }
 }
 
 /* generate modrm store of memory or register. */
-static void gen_st_modrm(CPUX86State *env, DisasContext *s, int modrm, MemOp ot)
+static void gen_st_modrm(DisasContext *s, X86DecodedInsn *decode, MemOp ot)
 {
+    int modrm = s->modrm;
     int mod, rm;
 
     mod = (modrm >> 6) & 3;
@@ -1739,7 +1721,7 @@ static void gen_st_modrm(CPUX86State *env, DisasContext *s, int modrm, MemOp ot)
     if (mod == 3) {
         gen_op_mov_reg_v(s, ot, rm, s->T0);
     } else {
-        gen_lea_modrm(env, s, modrm);
+        gen_lea_modrm(s, decode);
         gen_op_st_v(s, ot, s->T0, s->A0);
     }
 }
@@ -2307,12 +2289,12 @@ static void gen_sty_env_A0(DisasContext *s, int offset, bool align)
     tcg_gen_qemu_st_i128(t, s->tmp0, mem_index, mop);
 }
 
-static void gen_cmpxchg8b(DisasContext *s, CPUX86State *env, int modrm)
+static void gen_cmpxchg8b(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i64 cmp, val, old;
     TCGv Z;
 
-    gen_lea_modrm(env, s, modrm);
+    gen_lea_modrm(s, decode);
 
     cmp = tcg_temp_new_i64();
     val = tcg_temp_new_i64();
@@ -2361,13 +2343,13 @@ static void gen_cmpxchg8b(DisasContext *s, CPUX86State *env, int modrm)
 }
 
 #ifdef TARGET_X86_64
-static void gen_cmpxchg16b(DisasContext *s, CPUX86State *env, int modrm)
+static void gen_cmpxchg16b(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp mop = MO_TE | MO_128 | MO_ALIGN;
     TCGv_i64 t0, t1;
     TCGv_i128 cmp, val;
 
-    gen_lea_modrm(env, s, modrm);
+    gen_lea_modrm(s, decode);
 
     cmp = tcg_temp_new_i128();
     val = tcg_temp_new_i128();
@@ -2405,31 +2387,32 @@ static void gen_cmpxchg16b(DisasContext *s, CPUX86State *env, int modrm)
 }
 #endif
 
-static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
+#include "emit.c.inc"
+
+static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
 {
-    CPUX86State *env = cpu_env(cpu);
     bool update_fip = true;
-    int modrm, mod, rm, op;
+    int b = decode->b;
+    int modrm = s->modrm;
+    int mod, rm, op;
 
     if (s->flags & (HF_EM_MASK | HF_TS_MASK)) {
         /* if CR0.EM or CR0.TS are set, generate an FPU exception */
         /* XXX: what to do if illegal op ? */
         gen_exception(s, EXCP07_PREX);
-        return true;
+        return;
     }
-    modrm = x86_ldub_code(env, s);
     mod = (modrm >> 6) & 3;
     rm = modrm & 7;
     op = ((b & 7) << 3) | ((modrm >> 3) & 7);
     if (mod != 3) {
         /* memory op */
-        AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
-        TCGv ea = gen_lea_modrm_1(s, a, false);
+        TCGv ea = gen_lea_modrm_1(s, decode->mem, false);
         TCGv last_addr = tcg_temp_new();
         bool update_fdp = true;
 
         tcg_gen_mov_tl(last_addr, ea);
-        gen_lea_v_seg(s, ea, a.def_seg, s->override);
+        gen_lea_v_seg(s, ea, decode->mem.def_seg, s->override);
 
         switch (op) {
         case 0x00 ... 0x07: /* fxxxs */
@@ -2619,11 +2602,11 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
             gen_helper_fpop(tcg_env);
             break;
         default:
-            return false;
+            goto illegal_op;
         }
 
         if (update_fdp) {
-            int last_seg = s->override >= 0 ? s->override : a.def_seg;
+            int last_seg = s->override >= 0 ? s->override : decode->mem.def_seg;
 
             tcg_gen_ld_i32(s->tmp2_i32, tcg_env,
                            offsetof(CPUX86State,
@@ -2660,7 +2643,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
                 update_fip = false;
                 break;
             default:
-                return false;
+                goto illegal_op;
             }
             break;
         case 0x0c: /* grp d9/4 */
@@ -2679,7 +2662,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
                 gen_helper_fxam_ST0(tcg_env);
                 break;
             default:
-                return false;
+                goto illegal_op;
             }
             break;
         case 0x0d: /* grp d9/5 */
@@ -2714,7 +2697,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
                     gen_helper_fldz_ST0(tcg_env);
                     break;
                 default:
-                    return false;
+                    goto illegal_op;
                 }
             }
             break;
@@ -2816,7 +2799,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
                 gen_helper_fpop(tcg_env);
                 break;
             default:
-                return false;
+                goto illegal_op;
             }
             break;
         case 0x1c:
@@ -2836,7 +2819,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
             case 4: /* fsetpm (287 only, just do nop here) */
                 break;
             default:
-                return false;
+                goto illegal_op;
             }
             break;
         case 0x1d: /* fucomi */
@@ -2888,7 +2871,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
                 gen_helper_fpop(tcg_env);
                 break;
             default:
-                return false;
+                goto illegal_op;
             }
             break;
         case 0x38: /* ffreep sti, undocumented op */
@@ -2903,7 +2886,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
                 gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
                 break;
             default:
-                return false;
+                goto illegal_op;
             }
             break;
         case 0x3d: /* fucomip */
@@ -2950,7 +2933,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
             }
             break;
         default:
-            return false;
+            goto illegal_op;
         }
     }
 
@@ -2962,25 +2945,24 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
         tcg_gen_st_tl(eip_cur_tl(s),
                       tcg_env, offsetof(CPUX86State, fpip));
     }
-    return true;
+    return;
 
  illegal_op:
     gen_illegal_opcode(s);
-    return true;
 }
 
-static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
+static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 {
-    CPUX86State *env = cpu_env(cpu);
     int prefixes = s->prefix;
     MemOp dflag = s->dflag;
+    int b = decode->b + 0x100;
+    int modrm = s->modrm;
     MemOp ot;
-    int modrm, reg, rm, mod, op;
+    int reg, rm, mod, op;
 
     /* now check op code */
     switch (b) {
     case 0x1c7: /* cmpxchg8b */
-        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         switch ((modrm >> 3) & 7) {
         case 1: /* CMPXCHG8, CMPXCHG16 */
@@ -2992,14 +2974,14 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 if (!(s->cpuid_ext_features & CPUID_EXT_CX16)) {
                     goto illegal_op;
                 }
-                gen_cmpxchg16b(s, env, modrm);
+                gen_cmpxchg16b(s, decode);
                 break;
             }
 #endif
             if (!(s->cpuid_features & CPUID_CX8)) {
                 goto illegal_op;
             }
-            gen_cmpxchg8b(s, env, modrm);
+            gen_cmpxchg8b(s, decode);
             break;
 
         case 7: /* RDSEED, RDPID with f3 prefix */
@@ -3042,7 +3024,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         break;
 
     case 0x100:
-        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         op = (modrm >> 3) & 7;
         switch(op) {
@@ -3056,14 +3037,14 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             tcg_gen_ld32u_tl(s->T0, tcg_env,
                              offsetof(CPUX86State, ldt.selector));
             ot = mod == 3 ? dflag : MO_16;
-            gen_st_modrm(env, s, modrm, ot);
+            gen_st_modrm(s, decode, ot);
             break;
         case 2: /* lldt */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             if (check_cpl0(s)) {
                 gen_svm_check_intercept(s, SVM_EXIT_LDTR_WRITE);
-                gen_ld_modrm(env, s, modrm, MO_16);
+                gen_ld_modrm(s, decode, MO_16);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_lldt(tcg_env, s->tmp2_i32);
             }
@@ -3078,14 +3059,14 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             tcg_gen_ld32u_tl(s->T0, tcg_env,
                              offsetof(CPUX86State, tr.selector));
             ot = mod == 3 ? dflag : MO_16;
-            gen_st_modrm(env, s, modrm, ot);
+            gen_st_modrm(s, decode, ot);
             break;
         case 3: /* ltr */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             if (check_cpl0(s)) {
                 gen_svm_check_intercept(s, SVM_EXIT_TR_WRITE);
-                gen_ld_modrm(env, s, modrm, MO_16);
+                gen_ld_modrm(s, decode, MO_16);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_ltr(tcg_env, s->tmp2_i32);
             }
@@ -3094,7 +3075,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         case 5: /* verw */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
-            gen_ld_modrm(env, s, modrm, MO_16);
+            gen_ld_modrm(s, decode, MO_16);
             gen_update_cc_op(s);
             if (op == 4) {
                 gen_helper_verr(tcg_env, s->T0);
@@ -3104,19 +3085,18 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             assume_cc_op(s, CC_OP_EFLAGS);
             break;
         default:
-            goto unknown_op;
+            goto illegal_op;
         }
         break;
 
     case 0x101:
-        modrm = x86_ldub_code(env, s);
         switch (modrm) {
         CASE_MODRM_MEM_OP(0): /* sgdt */
             if (s->flags & HF_UMIP_MASK && !check_cpl0(s)) {
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_GDTR_READ);
-            gen_lea_modrm(env, s, modrm);
+            gen_lea_modrm(s, decode);
             tcg_gen_ld32u_tl(s->T0,
                              tcg_env, offsetof(CPUX86State, gdt.limit));
             gen_op_st_v(s, MO_16, s->T0, s->A0);
@@ -3172,7 +3152,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_IDTR_READ);
-            gen_lea_modrm(env, s, modrm);
+            gen_lea_modrm(s, decode);
             tcg_gen_ld32u_tl(s->T0, tcg_env, offsetof(CPUX86State, idt.limit));
             gen_op_st_v(s, MO_16, s->T0, s->A0);
             gen_add_A0_im(s, 2);
@@ -3322,7 +3302,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_GDTR_WRITE);
-            gen_lea_modrm(env, s, modrm);
+            gen_lea_modrm(s, decode);
             gen_op_ld_v(s, MO_16, s->T1, s->A0);
             gen_add_A0_im(s, 2);
             gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
@@ -3338,7 +3318,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_IDTR_WRITE);
-            gen_lea_modrm(env, s, modrm);
+            gen_lea_modrm(s, decode);
             gen_op_ld_v(s, MO_16, s->T1, s->A0);
             gen_add_A0_im(s, 2);
             gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
@@ -3362,7 +3342,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
              */
             mod = (modrm >> 6) & 3;
             ot = (mod != 3 ? MO_16 : s->dflag);
-            gen_st_modrm(env, s, modrm, ot);
+            gen_st_modrm(s, decode, ot);
             break;
         case 0xee: /* rdpkru */
             if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
@@ -3389,7 +3369,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_WRITE_CR0);
-            gen_ld_modrm(env, s, modrm, MO_16);
+            gen_ld_modrm(s, decode, MO_16);
             /*
              * Only the 4 lower bits of CR0 are modified.
              * PE cannot be set to zero if already set to one.
@@ -3407,7 +3387,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_INVLPG);
-            gen_lea_modrm(env, s, modrm);
+            gen_lea_modrm(s, decode);
             gen_helper_flush_page(tcg_env, s->A0);
             s->base.is_jmp = DISAS_EOB_NEXT;
             break;
@@ -3440,12 +3420,11 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             break;
 
         default:
-            goto unknown_op;
+            goto illegal_op;
         }
         break;
 
     case 0x11a:
-        modrm = x86_ldub_code(env, s);
         if (s->flags & HF_MPX_EN_MASK) {
             mod = (modrm >> 6) & 3;
             reg = ((modrm >> 3) & 7) | REX_R(s);
@@ -3456,7 +3435,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
-                gen_bndck(env, s, modrm, TCG_COND_LTU, cpu_bndl[reg]);
+                gen_bndck(s, decode, TCG_COND_LTU, cpu_bndl[reg]);
             } else if (prefixes & PREFIX_REPNZ) {
                 /* bndcu */
                 if (reg >= 4
@@ -3466,7 +3445,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 }
                 TCGv_i64 notu = tcg_temp_new_i64();
                 tcg_gen_not_i64(notu, cpu_bndu[reg]);
-                gen_bndck(env, s, modrm, TCG_COND_GTU, notu);
+                gen_bndck(s, decode, TCG_COND_GTU, notu);
             } else if (prefixes & PREFIX_DATA) {
                 /* bndmov -- from reg/mem */
                 if (reg >= 4 || s->aflag == MO_16) {
@@ -3482,7 +3461,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                         tcg_gen_mov_i64(cpu_bndu[reg], cpu_bndu[reg2]);
                     }
                 } else {
-                    gen_lea_modrm(env, s, modrm);
+                    gen_lea_modrm(s, decode);
                     if (CODE64(s)) {
                         tcg_gen_qemu_ld_i64(cpu_bndl[reg], s->A0,
                                             s->mem_index, MO_LEUQ);
@@ -3501,7 +3480,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 }
             } else if (mod != 3) {
                 /* bndldx */
-                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
+                AddressParts a = decode->mem;
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
@@ -3531,10 +3510,8 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 gen_set_hflag(s, HF_MPX_IU_MASK);
             }
         }
-        gen_nop_modrm(env, s, modrm);
         break;
     case 0x11b:
-        modrm = x86_ldub_code(env, s);
         if (s->flags & HF_MPX_EN_MASK) {
             mod = (modrm >> 6) & 3;
             reg = ((modrm >> 3) & 7) | REX_R(s);
@@ -3545,7 +3522,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
-                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
+                AddressParts a = decode->mem;
                 if (a.base >= 0) {
                     tcg_gen_extu_tl_i64(cpu_bndl[reg], cpu_regs[a.base]);
                     if (!CODE64(s)) {
@@ -3558,7 +3535,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                     /* rip-relative generates #ud */
                     goto illegal_op;
                 }
-                tcg_gen_not_tl(s->A0, gen_lea_modrm_1(s, a, false));
+                tcg_gen_not_tl(s->A0, gen_lea_modrm_1(s, decode->mem, false));
                 if (!CODE64(s)) {
                     tcg_gen_ext32u_tl(s->A0, s->A0);
                 }
@@ -3573,7 +3550,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
-                gen_bndck(env, s, modrm, TCG_COND_GTU, cpu_bndu[reg]);
+                gen_bndck(s, decode, TCG_COND_GTU, cpu_bndu[reg]);
             } else if (prefixes & PREFIX_DATA) {
                 /* bndmov -- to reg/mem */
                 if (reg >= 4 || s->aflag == MO_16) {
@@ -3589,7 +3566,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                         tcg_gen_mov_i64(cpu_bndu[reg2], cpu_bndu[reg]);
                     }
                 } else {
-                    gen_lea_modrm(env, s, modrm);
+                    gen_lea_modrm(s, decode);
                     if (CODE64(s)) {
                         tcg_gen_qemu_st_i64(cpu_bndl[reg], s->A0,
                                             s->mem_index, MO_LEUQ);
@@ -3606,7 +3583,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 }
             } else if (mod != 3) {
                 /* bndstx */
-                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
+                AddressParts a = decode->mem;
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
@@ -3633,7 +3610,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 }
             }
         }
-        gen_nop_modrm(env, s, modrm);
         break;
     default:
         g_assert_not_reached();
@@ -3642,12 +3618,8 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
  illegal_op:
     gen_illegal_opcode(s);
     return;
- unknown_op:
-    gen_unknown_opcode(env, s);
 }
 
-#include "decode-new.h"
-#include "emit.c.inc"
 #include "decode-new.c.inc"
 
 void tcg_x86_init(void)
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 55629f6825c..ee3ba16116e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1092,6 +1092,8 @@ static void decode_MOV_CR_DR(DisasContext *s, CPUX86State *env, X86OpEntry *entr
 }
 
 static const X86OpEntry opcodes_0F[256] = {
+    [0x00] = X86_OP_ENTRY1(multi0F,     nop,v,                nolea), /* unconverted */
+    [0x01] = X86_OP_ENTRY1(multi0F,     nop,v,                nolea), /* unconverted */
     [0x02] = X86_OP_ENTRYwr(LAR,        G,v, E,w,             chk(prot)),
     [0x03] = X86_OP_ENTRYwr(LSL,        G,v, E,w,             chk(prot)),
     [0x05] = X86_OP_ENTRY0(SYSCALL,                           chk(o64_intel)),
@@ -1201,6 +1203,7 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
     [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
     [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
+    [0xc7] = X86_OP_ENTRY1(multi0F,    nop,v,               nolea), /* unconverted */
 
     [0xd0] = X86_OP_ENTRY3(VADDSUB,   V,x, H,x, W,x,        vex2 cpuid(SSE3) p_66_f2),
     [0xd1] = X86_OP_ENTRY3(PSRLW_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
@@ -1243,6 +1246,8 @@ static const X86OpEntry opcodes_0F[256] = {
 
     [0x18] = X86_OP_ENTRY1(NOP,  nop,v),  /* prefetch/reserved NOP */
     [0x19] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
+    [0x1a] = X86_OP_ENTRY1(multi0F, nop,v, nolea),  /* unconverted MPX */
+    [0x1b] = X86_OP_ENTRY1(multi0F, nop,v, nolea),  /* unconverted MPX */
     [0x1c] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
     [0x1d] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
     [0x1e] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
@@ -1780,6 +1785,19 @@ static const X86OpEntry opcodes_root[256] = {
     [0xCE] = X86_OP_ENTRY0(INTO),
     [0xCF] = X86_OP_ENTRY0(IRET,      chk(vm86_iopl) svm(IRET)),
 
+    /*
+     * x87 is nolea because it needs the address without segment base,
+     * in order to store it in fdp.
+     */
+    [0xD8] = X86_OP_ENTRY1(x87,    nop,v, nolea),
+    [0xD9] = X86_OP_ENTRY1(x87,    nop,v, nolea),
+    [0xDA] = X86_OP_ENTRY1(x87,    nop,v, nolea),
+    [0xDB] = X86_OP_ENTRY1(x87,    nop,v, nolea),
+    [0xDC] = X86_OP_ENTRY1(x87,    nop,v, nolea),
+    [0xDD] = X86_OP_ENTRY1(x87,    nop,v, nolea),
+    [0xDE] = X86_OP_ENTRY1(x87,    nop,v, nolea),
+    [0xDF] = X86_OP_ENTRY1(x87,    nop,v, nolea),
+
     [0xE8] = X86_OP_ENTRYr(CALL,   J,z_f64),
     [0xE9] = X86_OP_ENTRYr(JMP,    J,z_f64),
     [0xEA] = X86_OP_ENTRYrr(JMPF,  I_unsigned,p, I_unsigned,w, chk(i64)),
@@ -2612,30 +2630,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         }
     }
 
-    /* Go back to old decoder for unconverted opcodes.  */
-    if (!(s->prefix & PREFIX_VEX)) {
-        if ((b & ~7) == 0xd8) {
-            if (!disas_insn_x87(s, cpu, b)) {
-                goto unknown_op;
-            }
-            return;
-        }
-
-        if (b == 0x0f) {
-            b = x86_ldub_code(env, s);
-            switch (b) {
-            case 0x00 ... 0x01: /* mostly privileged instructions */
-            case 0x1a ... 0x1b: /* MPX */
-            case 0xc7:          /* grp9 */
-                disas_insn_old(s, cpu, b + 0x100);
-                return;
-            default:
-                decode_func = do_decode_0F;
-                break;
-            }
-        }
-    }
-
     memset(&decode, 0, sizeof(decode));
     decode.cc_op = -1;
     decode.b = b;
@@ -2732,6 +2726,15 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         break;
     }
 
+    /*
+     * hack for old decoder: 0F C7 has both instructions that accept LOCK
+     * and instructions that don't, but also needs X86_SPECIAL_NoLoadEA.
+     * Keep this here until CMPXCHG8B/CMPXCHG16B is separated from the
+     * other unconverted opcodes.
+     */
+    if (decode.e.gen == gen_multi0F) {
+        accept_lock = true;
+    }
     if ((s->prefix & PREFIX_LOCK) && !accept_lock) {
         goto illegal_op;
     }
@@ -2779,7 +2782,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
     if (decode.e.special != X86_SPECIAL_NoLoadEA &&
         (decode.op[0].has_ea || decode.op[1].has_ea || decode.op[2].has_ea)) {
-        gen_load_ea(s, &decode);
+        gen_lea_modrm(s, &decode);
     }
     if (s->prefix & PREFIX_LOCK) {
         assert(decode.op[0].has_ea && !decode.op[2].has_ea);
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index bb498464ea0..29de8bba6f7 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -78,7 +78,7 @@ static void gen_NM_exception(DisasContext *s)
     gen_exception(s, EXCP07_PREX);
 }
 
-static void gen_load_ea(DisasContext *s, X86DecodedInsn *decode)
+static void gen_lea_modrm(DisasContext *s, X86DecodedInsn *decode)
 {
     AddressParts *mem = &decode->mem;
     TCGv ea;
-- 
2.46.2


