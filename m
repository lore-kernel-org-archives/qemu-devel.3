Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E320D216AD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iND-0006D2-NC; Tue, 15 Oct 2024 10:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iN5-0005rx-1m
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iN2-0003KC-Id
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWZ3pss2vbNuWf/y4anqLf3Tsmh7IyDlRYkogrVMkms=;
 b=LXLEzCdnqB8wu8Q+aTqiSE+B67dpblbEkPNp0nLykdXj5UodUurK66N9e8UqK4lelH2qpD
 o7et2vedBVy8rwxKCwpSYwo2y19Knbgr3/LbCGXRie5tFQmMlaXQ86qCQxHH47yhEdWF1O
 mYQmvwdLj58QUveRWUVU1EtC+jU7Z6A=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-Dv-PPzh8Pl-qUuFmiAoK_w-1; Tue, 15 Oct 2024 10:17:54 -0400
X-MC-Unique: Dv-PPzh8Pl-qUuFmiAoK_w-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539fbf73a2fso1747718e87.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001873; x=1729606673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWZ3pss2vbNuWf/y4anqLf3Tsmh7IyDlRYkogrVMkms=;
 b=DRVgHAWBgtGaD+lbFY45dzbZk5jeVh/Vz33xgfTA8Hky4ITVxJBMJvtOY5qRfajpvz
 jaICNloekb9OSsd+Rf5yItLmGdrk7MyZSsxcAeiEFTe58l6PyTkp6s7YVN8PcETtckjx
 IiCSc1qcSOaE0sRbFnva7cwmVnkYuqjAoJLNeRyN5Qrei5v07kdWQKxRkH3VN2g56PMP
 5O88BcostCqAGyQ6jLBlNLEXO8hI+Cai3apYNLDzkJpbRVO1kyUzxYHjlUM73fZ4rwOi
 48aTb8t/KImeUJ1+jDehwcxz01L7+1sdOH3FqePp6LNyKtrgIhwJMyb114PHZH1Hq/ci
 D87w==
X-Gm-Message-State: AOJu0Yw1IEDo7fPzilSAc5BVNXQIJGURlBpoks+OhaSBuAVsih1hBYEH
 0Zvrut63pxH7aumC9ceSPBA/xvf6UZl2HY9awzXkQfQb3e+G0OYJZgqlo+CFrDc0XZmqLbv9AYC
 Gk74f2KGUxl6d4/ERrKGz+Kqw4OAsSX/c78uc1xbkKf95qmUnULNkUO9CcH/q29d3SFuoGO1/vZ
 XGDsL4mCaiCJPlZqIccCRxWTq8Ds1x/plfpuywsNo=
X-Received: by 2002:a05:6512:e9d:b0:539:e510:d83f with SMTP id
 2adb3069b0e04-539e54d8180mr6366592e87.5.1729001872273; 
 Tue, 15 Oct 2024 07:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzdegwrLsMxs5o33axTOegxscI3pB1b3N14NnK+eqblDRy5Ky5pZUW/rWd+XsGqN5PYxbBrg==
X-Received: by 2002:a05:6512:e9d:b0:539:e510:d83f with SMTP id
 2adb3069b0e04-539e54d8180mr6366552e87.5.1729001871622; 
 Tue, 15 Oct 2024 07:17:51 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fbf838dsm1696032f8f.78.2024.10.15.07.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/25] target/i386: convert bit test instructions to new decoder
Date: Tue, 15 Oct 2024 16:16:57 +0200
Message-ID: <20241015141711.528342-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Code generation was rewritten; it reuses the same trick to use the
CC_OP_SAR values for cc_op, but it tries to use CC_OP_ADCX or CC_OP_ADCOX
instead of CC_OP_EFLAGS.  This is a tiny bit more efficient in the
common case where only CF is checked in the resulting flags.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |   3 +
 target/i386/tcg/translate.c      | 147 +-----------------------------
 target/i386/tcg/decode-new.c.inc |  41 ++++++---
 target/i386/tcg/emit.c.inc       | 150 ++++++++++++++++++++++++++++++-
 4 files changed, 183 insertions(+), 158 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index f9bf9a60411..e4cdf5e3c4f 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -190,6 +190,9 @@ typedef enum X86InsnSpecial {
     /* Always locked if it has a memory operand (XCHG) */
     X86_SPECIAL_Locked,
 
+    /* Like HasLock, but also operand 2 provides bit displacement into memory.  */
+    X86_SPECIAL_BitTest,
+
     /* Do not load effective address in s->A0 */
     X86_SPECIAL_NoLoadEA,
 
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 98f5fe61ed0..59b67042cd9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -693,11 +693,6 @@ static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
     return dst;
 }
 
-static void gen_exts(MemOp ot, TCGv reg)
-{
-    gen_ext_tl(reg, reg, ot, true);
-}
-
 static void gen_op_j_ecx(DisasContext *s, TCGCond cond, TCGLabel *label1)
 {
     TCGv tmp = gen_ext_tl(NULL, cpu_regs[R_ECX], s->aflag, false);
@@ -2980,7 +2975,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
     int prefixes = s->prefix;
     MemOp dflag = s->dflag;
     MemOp ot;
-    int modrm, reg, rm, mod, op, val;
+    int modrm, reg, rm, mod, op;
 
     /* now check op code */
     switch (b) {
@@ -3046,146 +3041,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         }
         break;
 
-        /************************/
-        /* bit operations */
-    case 0x1ba: /* bt/bts/btr/btc Gv, im */
-        ot = dflag;
-        modrm = x86_ldub_code(env, s);
-        op = (modrm >> 3) & 7;
-        mod = (modrm >> 6) & 3;
-        rm = (modrm & 7) | REX_B(s);
-        if (mod != 3) {
-            s->rip_offset = 1;
-            gen_lea_modrm(env, s, modrm);
-            if (!(s->prefix & PREFIX_LOCK)) {
-                gen_op_ld_v(s, ot, s->T0, s->A0);
-            }
-        } else {
-            gen_op_mov_v_reg(s, ot, s->T0, rm);
-        }
-        /* load shift */
-        val = x86_ldub_code(env, s);
-        tcg_gen_movi_tl(s->T1, val);
-        if (op < 4)
-            goto unknown_op;
-        op -= 4;
-        goto bt_op;
-    case 0x1a3: /* bt Gv, Ev */
-        op = 0;
-        goto do_btx;
-    case 0x1ab: /* bts */
-        op = 1;
-        goto do_btx;
-    case 0x1b3: /* btr */
-        op = 2;
-        goto do_btx;
-    case 0x1bb: /* btc */
-        op = 3;
-    do_btx:
-        ot = dflag;
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        mod = (modrm >> 6) & 3;
-        rm = (modrm & 7) | REX_B(s);
-        gen_op_mov_v_reg(s, MO_32, s->T1, reg);
-        if (mod != 3) {
-            AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
-            /* specific case: we need to add a displacement */
-            gen_exts(ot, s->T1);
-            tcg_gen_sari_tl(s->tmp0, s->T1, 3 + ot);
-            tcg_gen_shli_tl(s->tmp0, s->tmp0, ot);
-            tcg_gen_add_tl(s->A0, gen_lea_modrm_1(s, a, false), s->tmp0);
-            gen_lea_v_seg(s, s->A0, a.def_seg, s->override);
-            if (!(s->prefix & PREFIX_LOCK)) {
-                gen_op_ld_v(s, ot, s->T0, s->A0);
-            }
-        } else {
-            gen_op_mov_v_reg(s, ot, s->T0, rm);
-        }
-    bt_op:
-        tcg_gen_andi_tl(s->T1, s->T1, (1 << (3 + ot)) - 1);
-        tcg_gen_movi_tl(s->tmp0, 1);
-        tcg_gen_shl_tl(s->tmp0, s->tmp0, s->T1);
-        if (s->prefix & PREFIX_LOCK) {
-            switch (op) {
-            case 0: /* bt */
-                /* Needs no atomic ops; we suppressed the normal
-                   memory load for LOCK above so do it now.  */
-                gen_op_ld_v(s, ot, s->T0, s->A0);
-                break;
-            case 1: /* bts */
-                tcg_gen_atomic_fetch_or_tl(s->T0, s->A0, s->tmp0,
-                                           s->mem_index, ot | MO_LE);
-                break;
-            case 2: /* btr */
-                tcg_gen_not_tl(s->tmp0, s->tmp0);
-                tcg_gen_atomic_fetch_and_tl(s->T0, s->A0, s->tmp0,
-                                            s->mem_index, ot | MO_LE);
-                break;
-            default:
-            case 3: /* btc */
-                tcg_gen_atomic_fetch_xor_tl(s->T0, s->A0, s->tmp0,
-                                            s->mem_index, ot | MO_LE);
-                break;
-            }
-            tcg_gen_shr_tl(s->tmp4, s->T0, s->T1);
-        } else {
-            tcg_gen_shr_tl(s->tmp4, s->T0, s->T1);
-            switch (op) {
-            case 0: /* bt */
-                /* Data already loaded; nothing to do.  */
-                break;
-            case 1: /* bts */
-                tcg_gen_or_tl(s->T0, s->T0, s->tmp0);
-                break;
-            case 2: /* btr */
-                tcg_gen_andc_tl(s->T0, s->T0, s->tmp0);
-                break;
-            default:
-            case 3: /* btc */
-                tcg_gen_xor_tl(s->T0, s->T0, s->tmp0);
-                break;
-            }
-            if (op != 0) {
-                if (mod != 3) {
-                    gen_op_st_v(s, ot, s->T0, s->A0);
-                } else {
-                    gen_op_mov_reg_v(s, ot, rm, s->T0);
-                }
-            }
-        }
-
-        /* Delay all CC updates until after the store above.  Note that
-           C is the result of the test, Z is unchanged, and the others
-           are all undefined.  */
-        switch (s->cc_op) {
-        case CC_OP_MULB ... CC_OP_MULQ:
-        case CC_OP_ADDB ... CC_OP_ADDQ:
-        case CC_OP_ADCB ... CC_OP_ADCQ:
-        case CC_OP_SUBB ... CC_OP_SUBQ:
-        case CC_OP_SBBB ... CC_OP_SBBQ:
-        case CC_OP_LOGICB ... CC_OP_LOGICQ:
-        case CC_OP_INCB ... CC_OP_INCQ:
-        case CC_OP_DECB ... CC_OP_DECQ:
-        case CC_OP_SHLB ... CC_OP_SHLQ:
-        case CC_OP_SARB ... CC_OP_SARQ:
-        case CC_OP_BMILGB ... CC_OP_BMILGQ:
-        case CC_OP_POPCNT:
-            /* Z was going to be computed from the non-zero status of CC_DST.
-               We can get that same Z value (and the new C value) by leaving
-               CC_DST alone, setting CC_SRC, and using a CC_OP_SAR of the
-               same width.  */
-            tcg_gen_mov_tl(cpu_cc_src, s->tmp4);
-            set_cc_op(s, ((s->cc_op - CC_OP_MULB) & 3) + CC_OP_SARB);
-            break;
-        default:
-            /* Otherwise, generate EFLAGS and replace the C bit.  */
-            gen_compute_eflags(s);
-            tcg_gen_deposit_tl(cpu_cc_src, cpu_cc_src, s->tmp4,
-                               ctz32(CC_C), 1);
-            break;
-        }
-        break;
     case 0x100:
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 30be9237c31..55629f6825c 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -205,6 +205,7 @@
 #define sextT0 .special = X86_SPECIAL_SExtT0,
 #define zextT0 .special = X86_SPECIAL_ZExtT0,
 #define op0_Mw .special = X86_SPECIAL_Op0_Mw,
+#define btEvGv .special = X86_SPECIAL_BitTest,
 
 #define vex1 .vex_class = 1,
 #define vex1_rep3 .vex_class = 1, .vex_special = X86_VEX_REPScalar,
@@ -269,6 +270,24 @@ static inline const X86OpEntry *decode_by_prefix(DisasContext *s, const X86OpEnt
     }
 }
 
+static void decode_group8(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86GenFunc group8_gen[8] = {
+        NULL, NULL, NULL, NULL,
+        gen_BT, gen_BTS, gen_BTR, gen_BTC,
+    };
+    int op = (get_modrm(s, env) >> 3) & 7;
+    entry->gen = group8_gen[op];
+    if (op == 4) {
+        /* prevent writeback and LOCK for BT */
+        entry->op1 = entry->op0;
+        entry->op0 = X86_TYPE_None;
+        entry->s0 = X86_SIZE_None;
+    } else {
+        entry->special = X86_SPECIAL_HasLock;
+    }
+}
+
 static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86OpEntry group15_reg[8] = {
@@ -1162,12 +1181,14 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xa0] = X86_OP_ENTRYr(PUSH, FS, w),
     [0xa1] = X86_OP_ENTRYw(POP, FS, w),
     [0xa2] = X86_OP_ENTRY0(CPUID),
+    [0xa3] = X86_OP_ENTRYrr(BT,   E,v, G,v,          btEvGv),
     [0xa4] = X86_OP_ENTRY4(SHLD,  E,v, 2op,v, G,v),
     [0xa5] = X86_OP_ENTRY3(SHLD,  E,v, 2op,v, G,v),
 
     [0xb0] = X86_OP_ENTRY2(CMPXCHG,E,b, G,b, lock),
     [0xb1] = X86_OP_ENTRY2(CMPXCHG,E,v, G,v, lock),
     [0xb2] = X86_OP_ENTRY3(LSS,    G,v, EM,p, None, None),
+    [0xb3] = X86_OP_ENTRY2(BTR,    E,v, G,v,             btEvGv),
     [0xb4] = X86_OP_ENTRY3(LFS,    G,v, EM,p, None, None),
     [0xb5] = X86_OP_ENTRY3(LGS,    G,v, EM,p, None, None),
     [0xb6] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, zextT0), /* MOVZX */
@@ -1294,6 +1315,7 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xa8] = X86_OP_ENTRYr(PUSH,   GS, w),
     [0xa9] = X86_OP_ENTRYw(POP,    GS, w),
     [0xaa] = X86_OP_ENTRY0(RSM,             chk(smm) svm(RSM)),
+    [0xab] = X86_OP_ENTRY2(BTS,    E,v, G,v,             btEvGv),
     [0xac] = X86_OP_ENTRY4(SHRD,   E,v, 2op,v, G,v),
     [0xad] = X86_OP_ENTRY3(SHRD,   E,v, 2op,v, G,v),
     [0xae] = X86_OP_GROUP0(group15),
@@ -1306,6 +1328,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xb8] = X86_OP_GROUP0(0FB8),
     /* decoded as modrm, which is visible as a difference between page fault and #UD */
     [0xb9] = X86_OP_ENTRYr(UD,     nop,v),                        /* UD1 */
+    [0xba] = X86_OP_GROUP2(group8, E,v, I,b),
+    [0xbb] = X86_OP_ENTRY2(BTC,    E,v, G,v,             btEvGv),
     [0xbc] = X86_OP_GROUP0(0FBC),
     [0xbd] = X86_OP_GROUP0(0FBD),
     [0xbe] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, sextT0), /* MOVSX */
@@ -2428,6 +2452,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     CPUX86State *env = cpu_env(cpu);
     X86DecodedInsn decode;
     X86DecodeFunc decode_func = decode_root;
+    bool accept_lock = false;
     uint8_t cc_live, b;
 
     s->pc = s->base.pc_next;
@@ -2601,10 +2626,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             switch (b) {
             case 0x00 ... 0x01: /* mostly privileged instructions */
             case 0x1a ... 0x1b: /* MPX */
-            case 0xa3:          /* bt */
-            case 0xab:          /* bts */
-            case 0xb3:          /* btr */
-            case 0xba ... 0xbb: /* grp8, btc */
             case 0xc7:          /* grp9 */
                 disas_insn_old(s, cpu, b + 0x100);
                 return;
@@ -2666,9 +2687,10 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         if (decode.op[0].has_ea) {
             s->prefix |= PREFIX_LOCK;
         }
-        decode.e.special = X86_SPECIAL_HasLock;
         /* fallthrough */
     case X86_SPECIAL_HasLock:
+    case X86_SPECIAL_BitTest:
+        accept_lock = decode.op[0].has_ea;
         break;
 
     case X86_SPECIAL_Op0_Rd:
@@ -2710,10 +2732,8 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         break;
     }
 
-    if (s->prefix & PREFIX_LOCK) {
-        if (decode.e.special != X86_SPECIAL_HasLock || !decode.op[0].has_ea) {
-            goto illegal_op;
-        }
+    if ((s->prefix & PREFIX_LOCK) && !accept_lock) {
+        goto illegal_op;
     }
 
     if (!validate_vex(s, &decode)) {
@@ -2759,9 +2779,10 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
     if (decode.e.special != X86_SPECIAL_NoLoadEA &&
         (decode.op[0].has_ea || decode.op[1].has_ea || decode.op[2].has_ea)) {
-        gen_load_ea(s, &decode.mem, decode.e.vex_class == 12);
+        gen_load_ea(s, &decode);
     }
     if (s->prefix & PREFIX_LOCK) {
+        assert(decode.op[0].has_ea && !decode.op[2].has_ea);
         gen_load(s, &decode, 2, s->T1);
         decode.e.gen(s, &decode);
     } else {
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 9b504199180..bb498464ea0 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -78,9 +78,26 @@ static void gen_NM_exception(DisasContext *s)
     gen_exception(s, EXCP07_PREX);
 }
 
-static void gen_load_ea(DisasContext *s, AddressParts *mem, bool is_vsib)
+static void gen_load_ea(DisasContext *s, X86DecodedInsn *decode)
 {
-    TCGv ea = gen_lea_modrm_1(s, *mem, is_vsib);
+    AddressParts *mem = &decode->mem;
+    TCGv ea;
+
+    ea = gen_lea_modrm_1(s, *mem, decode->e.vex_class == 12);
+    if (decode->e.special == X86_SPECIAL_BitTest) {
+        MemOp ot = decode->op[1].ot;
+        int poslen = 8 << ot;
+        int opn = decode->op[2].n;
+        TCGv ofs = tcg_temp_new();
+
+        /* Extract memory displacement from the second operand.  */
+        assert(decode->op[2].unit == X86_OP_INT && decode->op[2].ot != MO_8);
+        tcg_gen_sextract_tl(ofs, cpu_regs[opn], 3, poslen - 3);
+        tcg_gen_andi_tl(ofs, ofs, -1 << ot);
+        tcg_gen_add_tl(s->A0, ea, ofs);
+        ea = s->A0;
+    }
+
     gen_lea_v_seg(s, ea, mem->def_seg, s->override);
 }
 
@@ -412,6 +429,32 @@ static void prepare_update3_cc(X86DecodedInsn *decode, DisasContext *s, CCOp op,
     decode->cc_op = op;
 }
 
+/* Set up decode->cc_* to modify CF while keeping other flags unchanged.  */
+static void prepare_update_cf(X86DecodedInsn *decode, DisasContext *s, TCGv cf)
+{
+    switch (s->cc_op) {
+    case CC_OP_ADOX:
+    case CC_OP_ADCOX:
+        decode->cc_src2 = cpu_cc_src2;
+        decode->cc_src = cpu_cc_src;
+        decode->cc_op = CC_OP_ADCOX;
+        break;
+
+    case CC_OP_EFLAGS:
+    case CC_OP_ADCX:
+        decode->cc_src = cpu_cc_src;
+        decode->cc_op = CC_OP_ADCX;
+        break;
+
+    default:
+        decode->cc_src = tcg_temp_new();
+        gen_mov_eflags(s, decode->cc_src);
+        decode->cc_op = CC_OP_ADCX;
+        break;
+    }
+    decode->cc_dst = cf;
+}
+
 static void gen_store_sse(DisasContext *s, X86DecodedInsn *decode, int src_ofs)
 {
     MemOp ot = decode->op[0].ot;
@@ -1390,6 +1433,109 @@ static void gen_BSWAP(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_bswap32_tl(s->T0, s->T0, TCG_BSWAP_OZ);
 }
 
+static TCGv gen_bt_mask(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+    TCGv mask = tcg_temp_new();
+
+    tcg_gen_andi_tl(s->T1, s->T1, (8 << ot) - 1);
+    tcg_gen_shl_tl(mask, tcg_constant_tl(1), s->T1);
+    return mask;
+}
+
+/* Expects truncated bit index in s->T1, 1 << s->T1 in MASK.  */
+static void gen_bt_flags(DisasContext *s, X86DecodedInsn *decode, TCGv src, TCGv mask)
+{
+    TCGv cf;
+
+    /*
+     * C is the result of the test, Z is unchanged, and the others
+     * are all undefined.
+     */
+    switch (s->cc_op) {
+    case CC_OP_DYNAMIC:
+    case CC_OP_CLR:
+    case CC_OP_EFLAGS:
+    case CC_OP_ADCX:
+    case CC_OP_ADOX:
+    case CC_OP_ADCOX:
+        /* Generate EFLAGS and replace the C bit.  */
+        cf = tcg_temp_new();
+        tcg_gen_setcond_tl(TCG_COND_TSTNE, cf, src, mask);
+        prepare_update_cf(decode, s, cf);
+        break;
+    default:
+        /*
+         * Z was going to be computed from the non-zero status of CC_DST.
+         * We can get that same Z value (and the new C value) by leaving
+         * CC_DST alone, setting CC_SRC, and using a CC_OP_SAR of the
+         * same width.
+         */
+        decode->cc_src = tcg_temp_new();
+        decode->cc_dst = cpu_cc_dst;
+        decode->cc_op = ((s->cc_op - CC_OP_MULB) & 3) + CC_OP_SARB;
+        tcg_gen_shr_tl(decode->cc_src, src, s->T1);
+        break;
+    }
+}
+
+static void gen_BT(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGv mask = gen_bt_mask(s, decode);
+
+    gen_bt_flags(s, decode, s->T0, mask);
+}
+
+static void gen_BTC(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    TCGv old = tcg_temp_new();
+    TCGv mask = gen_bt_mask(s, decode);
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_fetch_xor_tl(old, s->A0, mask, s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_mov_tl(old, s->T0);
+        tcg_gen_xor_tl(s->T0, s->T0, mask);
+    }
+
+    gen_bt_flags(s, decode, old, mask);
+}
+
+static void gen_BTR(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    TCGv old = tcg_temp_new();
+    TCGv mask = gen_bt_mask(s, decode);
+
+    if (s->prefix & PREFIX_LOCK) {
+        TCGv maskc = tcg_temp_new();
+        tcg_gen_not_tl(maskc, mask);
+        tcg_gen_atomic_fetch_and_tl(old, s->A0, maskc, s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_mov_tl(old, s->T0);
+        tcg_gen_andc_tl(s->T0, s->T0, mask);
+    }
+
+    gen_bt_flags(s, decode, old, mask);
+}
+
+static void gen_BTS(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    TCGv old = tcg_temp_new();
+    TCGv mask = gen_bt_mask(s, decode);
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_fetch_or_tl(old, s->A0, mask, s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_mov_tl(old, s->T0);
+        tcg_gen_or_tl(s->T0, s->T0, mask);
+    }
+
+    gen_bt_flags(s, decode, old, mask);
+}
+
 static void gen_BZHI(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
-- 
2.46.2


