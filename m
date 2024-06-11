Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206CEC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2S8-00080A-UR; Tue, 11 Jun 2024 10:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S4-0007mv-J6
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S2-0006B2-9D
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGW8qzNC/Jb9mphTqBYIRs9ux4NH8MrGk1FIz1nvO7c=;
 b=OxLUcTepXteuZKyv/bryrBW1WzhBznyC1jycn9KzluTGHQsP9mPugoUXPmePVo2N2GEfHh
 ycE5gV27toPs4vnpnXqVEd07k50y3dO+4CKErvHDyAmBPBWZuA6s1T7ZFD6vpTs/U/tHbx
 bHiyVXiGcnnPXjkPKnMSwFDZOCPVXdg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-XaQBzimxPFG_3BzGB5gurQ-1; Tue, 11 Jun 2024 10:26:15 -0400
X-MC-Unique: XaQBzimxPFG_3BzGB5gurQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57851ae6090so3740836a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115973; x=1718720773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGW8qzNC/Jb9mphTqBYIRs9ux4NH8MrGk1FIz1nvO7c=;
 b=jv7Z1wHI1eSKWxKX9qgYofPYzvqpqkO00UH9V2tzbPml9FV5gsB9l4okoOeoE6ydDq
 XQ5G57BrJhv4j3/IvuCOA1RTBlKTVhMrzmSivPeENY3dswj0RnI/3KsnrRBME9plAtzG
 BfpE16OOEpPbF05TNChpYzkJe0vye+tVDvJSwGVNIDhcMUdVWWGgsx/jFFwL9Of5e8Gn
 iRSE0OqfHSMxJZbzRB6PGoDV1zI+mrUcFsG3y6hyE352prNmKI2upQKdlR84Zg9+/m8/
 PLsuaF0p+M8ScHchoLLBlj05Oa8RjDo/ctr9gKi+pwym5HacPPGh3Pj2i9A2Ww03D3M5
 xaWA==
X-Gm-Message-State: AOJu0YxKphsiDyydaQQu1xnDEqWirEHx1he7ZsxiObVJX2oc7YTUqiAy
 Z7RpQ1lQM4omFqzD8+fxlWDVCUU1WUPolrzksao3FefSJTxHT+wPJ8NQtimVUf1ingLLDREx5ub
 AWxqq9JfR9VuUAfDbKEbzsExTXEfaqUPzFpYQykmxzSXjm5OOkObt/cU9D6FHrZjVHIixZAKrHD
 noXZkBmYg8W1lkiUtcFiVzEEH/KZVhf+mux8kr
X-Received: by 2002:a50:a45c:0:b0:57c:80f7:6f5 with SMTP id
 4fb4d7f45d1cf-57c80f70713mr3476892a12.36.1718115973430; 
 Tue, 11 Jun 2024 07:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj7BM49dETpDfKPp9C5krCd96BdssWX2uwVI8MWtq9O46QDdg/OOuNwVE+QxpwcV3ZYy0oSQ==
X-Received: by 2002:a50:a45c:0:b0:57c:80f7:6f5 with SMTP id
 4fb4d7f45d1cf-57c80f70713mr3476871a12.36.1718115972879; 
 Tue, 11 Jun 2024 07:26:12 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c9cf42d07sm708366a12.63.2024.06.11.07.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:26:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/25] target/i386: convert LZCNT/TZCNT/BSF/BSR/POPCNT to new
 decoder
Date: Tue, 11 Jun 2024 16:25:20 +0200
Message-ID: <20240611142524.83762-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  1 +
 target/i386/tcg/translate.c      | 74 ----------------------------
 target/i386/tcg/decode-new.c.inc | 52 +++++++++++++++++++-
 target/i386/tcg/emit.c.inc       | 82 ++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+), 76 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index c9f958bb0e5..9b684af7cd0 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -119,6 +119,7 @@ typedef enum X86CPUIDFeature {
     X86_FEAT_FXSR,
     X86_FEAT_MOVBE,
     X86_FEAT_PCLMULQDQ,
+    X86_FEAT_POPCNT,
     X86_FEAT_SHA_NI,
     X86_FEAT_SSE,
     X86_FEAT_SSE2,
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 33058db4e30..68a11f81786 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -823,11 +823,6 @@ static void gen_movs(DisasContext *s, MemOp ot)
     gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
 
-static void gen_op_update1_cc(DisasContext *s)
-{
-    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-}
-
 static void gen_op_update2_cc(DisasContext *s)
 {
     tcg_gen_mov_tl(cpu_cc_src, s->T1);
@@ -3311,56 +3306,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             break;
         }
         break;
-    case 0x1bc: /* bsf / tzcnt */
-    case 0x1bd: /* bsr / lzcnt */
-        ot = dflag;
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        gen_ld_modrm(env, s, modrm, ot);
-        gen_extu(ot, s->T0);
-
-        /* Note that lzcnt and tzcnt are in different extensions.  */
-        if ((prefixes & PREFIX_REPZ)
-            && (b & 1
-                ? s->cpuid_ext3_features & CPUID_EXT3_ABM
-                : s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
-            int size = 8 << ot;
-            /* For lzcnt/tzcnt, C bit is defined related to the input. */
-            tcg_gen_mov_tl(cpu_cc_src, s->T0);
-            if (b & 1) {
-                /* For lzcnt, reduce the target_ulong result by the
-                   number of zeros that we expect to find at the top.  */
-                tcg_gen_clzi_tl(s->T0, s->T0, TARGET_LONG_BITS);
-                tcg_gen_subi_tl(s->T0, s->T0, TARGET_LONG_BITS - size);
-            } else {
-                /* For tzcnt, a zero input must return the operand size.  */
-                tcg_gen_ctzi_tl(s->T0, s->T0, size);
-            }
-            /* For lzcnt/tzcnt, Z bit is defined related to the result.  */
-            gen_op_update1_cc(s);
-            set_cc_op(s, CC_OP_BMILGB + ot);
-        } else {
-            /* For bsr/bsf, only the Z bit is defined and it is related
-               to the input and not the result.  */
-            tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-            set_cc_op(s, CC_OP_LOGICB + ot);
-
-            /* ??? The manual says that the output is undefined when the
-               input is zero, but real hardware leaves it unchanged, and
-               real programs appear to depend on that.  Accomplish this
-               by passing the output as the value to return upon zero.  */
-            if (b & 1) {
-                /* For bsr, return the bit index of the first 1 bit,
-                   not the count of leading zeros.  */
-                tcg_gen_xori_tl(s->T1, cpu_regs[reg], TARGET_LONG_BITS - 1);
-                tcg_gen_clz_tl(s->T0, s->T0, s->T1);
-                tcg_gen_xori_tl(s->T0, s->T0, TARGET_LONG_BITS - 1);
-            } else {
-                tcg_gen_ctz_tl(s->T0, s->T0, cpu_regs[reg]);
-            }
-        }
-        gen_op_mov_reg_v(s, ot, reg, s->T0);
-        break;
     case 0x100:
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
@@ -3955,25 +3900,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         }
         gen_nop_modrm(env, s, modrm);
         break;
-    case 0x1b8: /* SSE4.2 popcnt */
-        if ((prefixes & (PREFIX_REPZ | PREFIX_LOCK | PREFIX_REPNZ)) !=
-             PREFIX_REPZ)
-            goto illegal_op;
-        if (!(s->cpuid_ext_features & CPUID_EXT_POPCNT))
-            goto illegal_op;
-
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-
-        ot = dflag;
-        gen_ld_modrm(env, s, modrm, ot);
-        gen_extu(ot, s->T0);
-        tcg_gen_mov_tl(cpu_cc_src, s->T0);
-        tcg_gen_ctpop_tl(s->T0, s->T0);
-        gen_op_mov_reg_v(s, ot, reg, s->T0);
-
-        set_cc_op(s, CC_OP_POPCNT);
-        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 2d27b07f296..15ebc1233ea 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -450,6 +450,50 @@ static void decode_0F7F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     *entry = *decode_by_prefix(s, opcodes_0F7F);
 }
 
+static void decode_0FB8(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry popcnt =
+        X86_OP_ENTRYwr(POPCNT,    G,v, E,v,  cpuid(POPCNT) zextT0);
+
+    if (s->prefix & PREFIX_REPZ) {
+        *entry = popcnt;
+    } else {
+        memset(entry, 0, sizeof(*entry));
+    }
+}
+
+static void decode_0FBC(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    /* For BSF, pass 2op as the third operand so that we can use zextT0 */
+    static const X86OpEntry opcodes_0FBC[4] = {
+        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0),
+        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0), /* 0x66 */
+        X86_OP_ENTRYwr(TZCNT, G,v, E,v,        zextT0), /* 0xf3 */
+        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0), /* 0xf2 */
+    };
+    if (!(s->cpuid_ext3_features & CPUID_EXT3_ABM)) {
+        *entry = opcodes_0FBC[0];
+    } else {
+        *entry = *decode_by_prefix(s, opcodes_0FBC);
+    }
+}
+
+static void decode_0FBD(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    /* For BSR, pass 2op as the third operand so that we can use zextT0 */
+    static const X86OpEntry opcodes_0FBD[4] = {
+        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0),
+        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0), /* 0x66 */
+        X86_OP_ENTRYwr(LZCNT, G,v, E,v,        zextT0), /* 0xf3 */
+        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0), /* 0xf2 */
+    };
+    if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
+        *entry = opcodes_0FBD[0];
+    } else {
+        *entry = *decode_by_prefix(s, opcodes_0FBD);
+    }
+}
+
 static void decode_0FD6(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86OpEntry movq[4] = {
@@ -1251,8 +1295,11 @@ static const X86OpEntry opcodes_0F[256] = {
      */
     [0xaf] = X86_OP_ENTRY3(IMUL3,  G,v, E,v, 2op,v, sextT0),
 
+    [0xb8] = X86_OP_GROUP0(0FB8),
     /* decoded as modrm, which is visible as a difference between page fault and #UD */
     [0xb9] = X86_OP_ENTRYr(UD,     nop,v),                        /* UD1 */
+    [0xbc] = X86_OP_GROUP0(0FBC),
+    [0xbd] = X86_OP_GROUP0(0FBD),
     [0xbe] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, sextT0), /* MOVSX */
     [0xbf] = X86_OP_ENTRY3(MOV,    G,v, E,w, None, None, sextT0), /* MOVSX */
 
@@ -2150,6 +2197,8 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
         return (s->cpuid_ext_features & CPUID_EXT_MOVBE);
     case X86_FEAT_PCLMULQDQ:
         return (s->cpuid_ext_features & CPUID_EXT_PCLMULQDQ);
+    case X86_FEAT_POPCNT:
+        return (s->cpuid_ext_features & CPUID_EXT_POPCNT);
     case X86_FEAT_SSE:
         return (s->cpuid_features & CPUID_SSE);
     case X86_FEAT_SSE2:
@@ -2540,8 +2589,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             case 0xab:          /* bts */
             case 0xb0 ... 0xb1: /* cmpxchg */
             case 0xb3:          /* btr */
-            case 0xb8:          /* integer ops */
-            case 0xba ... 0xbd: /* integer ops */
+            case 0xba ... 0xbb: /* grp8, btc */
             case 0xc0 ... 0xc1: /* xadd */
             case 0xc7:          /* grp9 */
                 disas_insn_old(s, cpu, b + 0x100);
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index fc4687a35bd..7f554ba1173 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1329,6 +1329,47 @@ static void gen_BOUND(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+/* Non-standard convention - on entry T0 is zero-extended input, T1 is the output.  */
+static void gen_BSF(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    /* Only the Z bit is defined and it is related to the input.  */
+    decode->cc_dst = tcg_temp_new();
+    decode->cc_op = CC_OP_LOGICB + ot;
+    tcg_gen_mov_tl(decode->cc_dst, s->T0);
+
+    /*
+     * The manual says that the output is undefined when the
+     * input is zero, but real hardware leaves it unchanged, and
+     * real programs appear to depend on that.  Accomplish this
+     * by passing the output as the value to return upon zero.
+     */
+    tcg_gen_ctz_tl(s->T0, s->T0, s->T1);
+}
+
+/* Non-standard convention - on entry T0 is zero-extended input, T1 is the output.  */
+static void gen_BSR(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    /* Only the Z bit is defined and it is related to the input.  */
+    decode->cc_dst = tcg_temp_new();
+    decode->cc_op = CC_OP_LOGICB + ot;
+    tcg_gen_mov_tl(decode->cc_dst, s->T0);
+
+    /*
+     * The manual says that the output is undefined when the
+     * input is zero, but real hardware leaves it unchanged, and
+     * real programs appear to depend on that.  Accomplish this
+     * by passing the output as the value to return upon zero.
+     * Plus, return the bit index of the first 1 bit.
+     */
+    tcg_gen_xori_tl(s->T1, s->T1, TARGET_LONG_BITS - 1);
+    tcg_gen_clz_tl(s->T0, s->T0, s->T1);
+    tcg_gen_xori_tl(s->T0, s->T0, TARGET_LONG_BITS - 1);
+}
+
 static void gen_BSWAP(DisasContext *s, X86DecodedInsn *decode)
 {
 #ifdef TARGET_X86_64
@@ -2130,6 +2171,24 @@ static void gen_LSS(DisasContext *s, X86DecodedInsn *decode)
     gen_lxx_seg(s, decode, R_SS);
 }
 
+static void gen_LZCNT(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    /* C bit (cc_src) is defined related to the input.  */
+    decode->cc_src = tcg_temp_new();
+    decode->cc_dst = s->T0;
+    decode->cc_op = CC_OP_BMILGB + ot;
+    tcg_gen_mov_tl(decode->cc_src, s->T0);
+
+    /*
+     * Reduce the target_ulong result by the number of zeros that
+     * we expect to find at the top.
+     */
+    tcg_gen_clzi_tl(s->T0, s->T0, TARGET_LONG_BITS);
+    tcg_gen_subi_tl(s->T0, s->T0, TARGET_LONG_BITS - (8 << ot));
+}
+
 static void gen_MFENCE(DisasContext *s, X86DecodedInsn *decode)
 {
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
@@ -2688,6 +2747,15 @@ static void gen_POPA(DisasContext *s, X86DecodedInsn *decode)
     gen_popa(s);
 }
 
+static void gen_POPCNT(DisasContext *s, X86DecodedInsn *decode)
+{
+    decode->cc_src = tcg_temp_new();
+    decode->cc_op = CC_OP_POPCNT;
+
+    tcg_gen_mov_tl(decode->cc_src, s->T0);
+    tcg_gen_ctpop_tl(s->T0, s->T0);
+}
+
 static void gen_POPF(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot;
@@ -3769,6 +3837,20 @@ static void gen_SYSRET(DisasContext *s, X86DecodedInsn *decode)
     s->base.is_jmp = DISAS_EOB_RECHECK_TF;
 }
 
+static void gen_TZCNT(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    /* C bit (cc_src) is defined related to the input.  */
+    decode->cc_src = tcg_temp_new();
+    decode->cc_dst = s->T0;
+    decode->cc_op = CC_OP_BMILGB + ot;
+    tcg_gen_mov_tl(decode->cc_src, s->T0);
+
+    /* A zero input returns the operand size.  */
+    tcg_gen_ctzi_tl(s->T0, s->T0, 8 << ot);
+}
+
 static void gen_UD(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_illegal_opcode(s);
-- 
2.45.1


