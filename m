Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B5DC27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu36-0000Gm-AX; Sat, 22 Jun 2024 02:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu30-0000Ab-99
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu2y-0006QN-4T
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8fM1jbKshUWdGnBBWyD6aAkpWD0IxNWpBR+laG2/iKM=;
 b=Z1JRWCtZsyPZKwCU7VJ3pnEV5S3aZEcOsAPryWcMVshcC9Ge+6lvUVAfYRe338kOcuF/GP
 qWaytIVQj8dmD8sgR+5CHt2BKpqb0sWcGf9q3iPlg8YvFvmPx+08BP9cEEHZx05Hldj7A1
 zYzv0/WU5LnfMG3icBhFiPIF9I8R8Ls=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-On9HGLvcMj6N3E5V-X4Wug-1; Sat, 22 Jun 2024 02:16:21 -0400
X-MC-Unique: On9HGLvcMj6N3E5V-X4Wug-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57cad3fa0a1so1874819a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036978; x=1719641778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fM1jbKshUWdGnBBWyD6aAkpWD0IxNWpBR+laG2/iKM=;
 b=RHrKNBWV556Plf8qb0MwuJdZPYnR+796OBifkiEgGIvzEN6BDcZfDth2lMSO7i57Cz
 ZG7K0x2c/J1b/B52xzZNXbm/HwHMUOcrpxABvPUYAzVhRwDUN6CgC3sC5mgVAO5wcHhO
 E9c2ErPba+8y2sIzUkfHRZTwv2xicqTxV1WdmLd5Nb0Btfr4duiVvPTQv2bjBgpENRR5
 Q/d8fhIL6VrykZcG30IU3xnxjKAdrnEBxkU+TD3S6M+w0Kx22hmXXMyncUgdd3KPqMrB
 UKsfrBCslT/OT0J88dL94qLD31THHGOLr9qFIkfhiimQ701T/iARILvjSJaTGHJGjBvs
 TSGA==
X-Gm-Message-State: AOJu0YxMIZR+/4xrBNBtZWp7Qt9bnywJLgKnnJQ8xEue4E6rCQ953vTK
 MeTmWpRYnFHIBk8yyNNjZgOuomRiyWWwqzCK3idimSINXjg1CeJzvtZzkYfDmzb/JKGeQypSM5C
 gNljl2fFfCwBNqWafQg+1Y3lwxNI5O6FRnzBvqo5oOhGyk4PBmkWjf7DrhHB+/3lLziYoaEx230
 ZNui6X+8JeSLPE/bXsudRyBwmM8NEbxW4xV/jG
X-Received: by 2002:a50:aadc:0:b0:57d:5c0:9dc0 with SMTP id
 4fb4d7f45d1cf-57d4580b023mr168503a12.38.1719036978358; 
 Fri, 21 Jun 2024 23:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbagMPmjmDbkUR6QUD1jiB5NZOa8tblWa0e9Y0TMLDQOvAUTRicGTkYw4te8xZ2VV8b1qn/w==
X-Received: by 2002:a50:aadc:0:b0:57d:5c0:9dc0 with SMTP id
 4fb4d7f45d1cf-57d4580b023mr168496a12.38.1719036977881; 
 Fri, 21 Jun 2024 23:16:17 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042d2d0sm1885490a12.41.2024.06.21.23.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/23] target/i386: convert CMPXCHG8B/CMPXCHG16B to new decoder
Date: Sat, 22 Jun 2024 08:15:42 +0200
Message-ID: <20240622061558.530543-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

This moves the last LOCK-enabled instructions to the new decoder.  It is now
possible to assume that PREFIX_LOCK gen_multi0F is called only after checking
that LOCK was not specified.

The gen_cmpxchg8b and gen_cmpxchg16b functions even have the correct
prototype already; the only thing that needs to be done is removing the
gen_lea_modrm() call.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |   2 +
 target/i386/tcg/translate.c      | 121 +------------------------------
 target/i386/tcg/decode-new.c.inc |  34 ++++++---
 target/i386/tcg/emit.c.inc       |  96 ++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 129 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index bebc77bd54b..7f23d373ea7 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -114,6 +114,8 @@ typedef enum X86CPUIDFeature {
     X86_FEAT_CLWB,
     X86_FEAT_CMOV,
     X86_FEAT_CMPCCXADD,
+    X86_FEAT_CX8,
+    X86_FEAT_CX16,
     X86_FEAT_F16C,
     X86_FEAT_FMA,
     X86_FEAT_FSGSBASE,
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 1d845ff66bb..c60f18c7482 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2298,104 +2298,6 @@ static void gen_sty_env_A0(DisasContext *s, int offset, bool align)
     tcg_gen_qemu_st_i128(t, s->tmp0, mem_index, mop);
 }
 
-static void gen_cmpxchg8b(DisasContext *s, X86DecodedInsn *decode)
-{
-    TCGv_i64 cmp, val, old;
-    TCGv Z;
-
-    gen_lea_modrm(s, decode);
-
-    cmp = tcg_temp_new_i64();
-    val = tcg_temp_new_i64();
-    old = tcg_temp_new_i64();
-
-    /* Construct the comparison values from the register pair. */
-    tcg_gen_concat_tl_i64(cmp, cpu_regs[R_EAX], cpu_regs[R_EDX]);
-    tcg_gen_concat_tl_i64(val, cpu_regs[R_EBX], cpu_regs[R_ECX]);
-
-    /* Only require atomic with LOCK; non-parallel handled in generator. */
-    if (s->prefix & PREFIX_LOCK) {
-        tcg_gen_atomic_cmpxchg_i64(old, s->A0, cmp, val, s->mem_index, MO_TEUQ);
-    } else {
-        tcg_gen_nonatomic_cmpxchg_i64(old, s->A0, cmp, val,
-                                      s->mem_index, MO_TEUQ);
-    }
-
-    /* Set tmp0 to match the required value of Z. */
-    tcg_gen_setcond_i64(TCG_COND_EQ, cmp, old, cmp);
-    Z = tcg_temp_new();
-    tcg_gen_trunc_i64_tl(Z, cmp);
-
-    /*
-     * Extract the result values for the register pair.
-     * For 32-bit, we may do this unconditionally, because on success (Z=1),
-     * the old value matches the previous value in EDX:EAX.  For x86_64,
-     * the store must be conditional, because we must leave the source
-     * registers unchanged on success, and zero-extend the writeback
-     * on failure (Z=0).
-     */
-    if (TARGET_LONG_BITS == 32) {
-        tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], old);
-    } else {
-        TCGv zero = tcg_constant_tl(0);
-
-        tcg_gen_extr_i64_tl(s->T0, s->T1, old);
-        tcg_gen_movcond_tl(TCG_COND_EQ, cpu_regs[R_EAX], Z, zero,
-                           s->T0, cpu_regs[R_EAX]);
-        tcg_gen_movcond_tl(TCG_COND_EQ, cpu_regs[R_EDX], Z, zero,
-                           s->T1, cpu_regs[R_EDX]);
-    }
-
-    /* Update Z. */
-    gen_compute_eflags(s);
-    tcg_gen_deposit_tl(cpu_cc_src, cpu_cc_src, Z, ctz32(CC_Z), 1);
-}
-
-#ifdef TARGET_X86_64
-static void gen_cmpxchg16b(DisasContext *s, X86DecodedInsn *decode)
-{
-    MemOp mop = MO_TE | MO_128 | MO_ALIGN;
-    TCGv_i64 t0, t1;
-    TCGv_i128 cmp, val;
-
-    gen_lea_modrm(s, decode);
-
-    cmp = tcg_temp_new_i128();
-    val = tcg_temp_new_i128();
-    tcg_gen_concat_i64_i128(cmp, cpu_regs[R_EAX], cpu_regs[R_EDX]);
-    tcg_gen_concat_i64_i128(val, cpu_regs[R_EBX], cpu_regs[R_ECX]);
-
-    /* Only require atomic with LOCK; non-parallel handled in generator. */
-    if (s->prefix & PREFIX_LOCK) {
-        tcg_gen_atomic_cmpxchg_i128(val, s->A0, cmp, val, s->mem_index, mop);
-    } else {
-        tcg_gen_nonatomic_cmpxchg_i128(val, s->A0, cmp, val, s->mem_index, mop);
-    }
-
-    tcg_gen_extr_i128_i64(s->T0, s->T1, val);
-
-    /* Determine success after the fact. */
-    t0 = tcg_temp_new_i64();
-    t1 = tcg_temp_new_i64();
-    tcg_gen_xor_i64(t0, s->T0, cpu_regs[R_EAX]);
-    tcg_gen_xor_i64(t1, s->T1, cpu_regs[R_EDX]);
-    tcg_gen_or_i64(t0, t0, t1);
-
-    /* Update Z. */
-    gen_compute_eflags(s);
-    tcg_gen_setcondi_i64(TCG_COND_EQ, t0, t0, 0);
-    tcg_gen_deposit_tl(cpu_cc_src, cpu_cc_src, t0, ctz32(CC_Z), 1);
-
-    /*
-     * Extract the result values for the register pair.  We may do this
-     * unconditionally, because on success (Z=1), the old value matches
-     * the previous value in RDX:RAX.
-     */
-    tcg_gen_mov_i64(cpu_regs[R_EAX], s->T0);
-    tcg_gen_mov_i64(cpu_regs[R_EDX], s->T1);
-}
-#endif
-
 #include "emit.c.inc"
 
 static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
@@ -2971,29 +2873,10 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
     /* now check op code */
     switch (b) {
-    case 0x1c7: /* cmpxchg8b */
+    case 0x1c7: /* RDSEED, RDPID with f3 prefix */
         mod = (modrm >> 6) & 3;
         switch ((modrm >> 3) & 7) {
-        case 1: /* CMPXCHG8, CMPXCHG16 */
-            if (mod == 3) {
-                goto illegal_op;
-            }
-#ifdef TARGET_X86_64
-            if (dflag == MO_64) {
-                if (!(s->cpuid_ext_features & CPUID_EXT_CX16)) {
-                    goto illegal_op;
-                }
-                gen_cmpxchg16b(s, decode);
-                break;
-            }
-#endif
-            if (!(s->cpuid_features & CPUID_CX8)) {
-                goto illegal_op;
-            }
-            gen_cmpxchg8b(s, decode);
-            break;
-
-        case 7: /* RDSEED, RDPID with f3 prefix */
+        case 7:
             if (mod != 3 ||
                 (s->prefix & (PREFIX_LOCK | PREFIX_REPNZ))) {
                 goto illegal_op;
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 45f4aed4611..fa51aadfcf2 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -288,6 +288,25 @@ static void decode_group8(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     }
 }
 
+static void decode_group9(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry group9_reg =
+        X86_OP_ENTRY0(multi0F);  /* unconverted */
+    static const X86OpEntry cmpxchg8b =
+        X86_OP_ENTRY1(CMPXCHG8B,  M,q,  lock p_00 cpuid(CX8));
+    static const X86OpEntry cmpxchg16b =
+        X86_OP_ENTRY1(CMPXCHG16B, M,dq, lock p_00 cpuid(CX16));
+
+    int modrm = get_modrm(s, env);
+    int op = (modrm >> 3) & 7;
+
+    if ((modrm >> 6) == 3) {
+        *entry = group9_reg;
+    } else if (op == 1) {
+        *entry = REX_W(s) ? cmpxchg16b : cmpxchg8b;
+    }
+}
+
 static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86OpEntry group15_reg[8] = {
@@ -1203,7 +1222,7 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
     [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
     [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
-    [0xc7] = X86_OP_ENTRY1(multi0F,    nop,v,               nolea), /* unconverted */
+    [0xc7] = X86_OP_GROUP0(group9),
 
     [0xd0] = X86_OP_ENTRY3(VADDSUB,   V,x, H,x, W,x,        vex2 cpuid(SSE3) p_66_f2),
     [0xd1] = X86_OP_ENTRY3(PSRLW_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
@@ -2241,8 +2260,12 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
         return (s->cpuid_features & CPUID_CMOV);
     case X86_FEAT_CLFLUSH:
         return (s->cpuid_features & CPUID_CLFLUSH);
+    case X86_FEAT_CX8:
+        return (s->cpuid_features & CPUID_CX8);
     case X86_FEAT_FXSR:
         return (s->cpuid_features & CPUID_FXSR);
+    case X86_FEAT_CX16:
+        return (s->cpuid_ext_features & CPUID_EXT_CX16);
     case X86_FEAT_F16C:
         return (s->cpuid_ext_features & CPUID_EXT_F16C);
     case X86_FEAT_FMA:
@@ -2722,15 +2745,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         break;
     }
 
-    /*
-     * hack for old decoder: 0F C7 has both instructions that accept LOCK
-     * and instructions that don't, but also needs X86_SPECIAL_NoLoadEA.
-     * Keep this here until CMPXCHG8B/CMPXCHG16B is separated from the
-     * other unconverted opcodes.
-     */
-    if (decode.e.gen == gen_multi0F) {
-        accept_lock = true;
-    }
     if ((s->prefix & PREFIX_LOCK) && !accept_lock) {
         goto illegal_op;
     }
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index edadb51ae89..98f10ad8b4e 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1782,6 +1782,102 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
     decode->cc_op = CC_OP_SUBB + ot;
 }
 
+static void gen_CMPXCHG16B(DisasContext *s, X86DecodedInsn *decode)
+{
+#ifdef TARGET_X86_64
+    MemOp mop = MO_TE | MO_128 | MO_ALIGN;
+    TCGv_i64 t0, t1;
+    TCGv_i128 cmp, val;
+
+    cmp = tcg_temp_new_i128();
+    val = tcg_temp_new_i128();
+    tcg_gen_concat_i64_i128(cmp, cpu_regs[R_EAX], cpu_regs[R_EDX]);
+    tcg_gen_concat_i64_i128(val, cpu_regs[R_EBX], cpu_regs[R_ECX]);
+
+    /* Only require atomic with LOCK; non-parallel handled in generator. */
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_cmpxchg_i128(val, s->A0, cmp, val, s->mem_index, mop);
+    } else {
+        tcg_gen_nonatomic_cmpxchg_i128(val, s->A0, cmp, val, s->mem_index, mop);
+    }
+
+    tcg_gen_extr_i128_i64(s->T0, s->T1, val);
+
+    /* Determine success after the fact. */
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+    tcg_gen_xor_i64(t0, s->T0, cpu_regs[R_EAX]);
+    tcg_gen_xor_i64(t1, s->T1, cpu_regs[R_EDX]);
+    tcg_gen_or_i64(t0, t0, t1);
+
+    /* Update Z. */
+    gen_compute_eflags(s);
+    tcg_gen_setcondi_i64(TCG_COND_EQ, t0, t0, 0);
+    tcg_gen_deposit_tl(cpu_cc_src, cpu_cc_src, t0, ctz32(CC_Z), 1);
+
+    /*
+     * Extract the result values for the register pair.  We may do this
+     * unconditionally, because on success (Z=1), the old value matches
+     * the previous value in RDX:RAX.
+     */
+    tcg_gen_mov_i64(cpu_regs[R_EAX], s->T0);
+    tcg_gen_mov_i64(cpu_regs[R_EDX], s->T1);
+#else
+    abort();
+#endif
+}
+
+static void gen_CMPXCHG8B(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGv_i64 cmp, val, old;
+    TCGv Z;
+
+    cmp = tcg_temp_new_i64();
+    val = tcg_temp_new_i64();
+    old = tcg_temp_new_i64();
+
+    /* Construct the comparison values from the register pair. */
+    tcg_gen_concat_tl_i64(cmp, cpu_regs[R_EAX], cpu_regs[R_EDX]);
+    tcg_gen_concat_tl_i64(val, cpu_regs[R_EBX], cpu_regs[R_ECX]);
+
+    /* Only require atomic with LOCK; non-parallel handled in generator. */
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_cmpxchg_i64(old, s->A0, cmp, val, s->mem_index, MO_TEUQ);
+    } else {
+        tcg_gen_nonatomic_cmpxchg_i64(old, s->A0, cmp, val,
+                                      s->mem_index, MO_TEUQ);
+    }
+
+    /* Set tmp0 to match the required value of Z. */
+    tcg_gen_setcond_i64(TCG_COND_EQ, cmp, old, cmp);
+    Z = tcg_temp_new();
+    tcg_gen_trunc_i64_tl(Z, cmp);
+
+    /*
+     * Extract the result values for the register pair.
+     * For 32-bit, we may do this unconditionally, because on success (Z=1),
+     * the old value matches the previous value in EDX:EAX.  For x86_64,
+     * the store must be conditional, because we must leave the source
+     * registers unchanged on success, and zero-extend the writeback
+     * on failure (Z=0).
+     */
+    if (TARGET_LONG_BITS == 32) {
+        tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], old);
+    } else {
+        TCGv zero = tcg_constant_tl(0);
+
+        tcg_gen_extr_i64_tl(s->T0, s->T1, old);
+        tcg_gen_movcond_tl(TCG_COND_EQ, cpu_regs[R_EAX], Z, zero,
+                           s->T0, cpu_regs[R_EAX]);
+        tcg_gen_movcond_tl(TCG_COND_EQ, cpu_regs[R_EDX], Z, zero,
+                           s->T1, cpu_regs[R_EDX]);
+    }
+
+    /* Update Z. */
+    gen_compute_eflags(s);
+    tcg_gen_deposit_tl(cpu_cc_src, cpu_cc_src, Z, ctz32(CC_Z), 1);
+}
+
 static void gen_CPUID(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
-- 
2.45.2


