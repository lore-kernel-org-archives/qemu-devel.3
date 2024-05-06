Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B06C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tSX-0005qP-7Y; Mon, 06 May 2024 04:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tRs-0004zh-TM
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tR1-0002a3-BV
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XdyaH6ob6wT2kqKRi+ypZZpcBBtNcAJf0lqJnFzKLRE=;
 b=YoThqGEyPuRmsxpuaW2pKfw0oeQsqibGYnynsvTdwWrrRgMgfF2mI1FxO3sSRrnyKhOzi/
 Y2s/bSUhDBDGldwDzSF7BrZca5bttwWiPr9T+nQk/YGP7NS7yF5lbpmsVWYzBczLviIBz0
 FtYIlxQ6qfKD6Br83K/SW5HQ2eujQS0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-p8BstMWKMqWHDAeNcDzGQg-1; Mon, 06 May 2024 04:10:53 -0400
X-MC-Unique: p8BstMWKMqWHDAeNcDzGQg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59a0014904so102244766b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983051; x=1715587851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XdyaH6ob6wT2kqKRi+ypZZpcBBtNcAJf0lqJnFzKLRE=;
 b=vGgx4G6s045Yj7dHYpSlLUKf9I63ZP61F6nVTSIsOtz4PxNT/pOV0neznCoNDt557y
 iha+bZYPaq+q9WZZYCdORS8k6oSusVUIqoKBCXQnwY7GjPUB6+Xhhoqd8Di++pejoVi+
 /po/q2SzYLVTvaaxu8GmX3HwmMUAphUb9yT1bvxKr74RRk2uTZLSZSGYe9GVOPCJsxdM
 I1XRr0USRit1Q7TD/9WavhXmPrgIJSpAXLs9Yy8i6KeITA8sh/SuNQRA5pqYpHLgg1o7
 DwOkiPwwjxQpea4w7Iw4YR0t1BqHfv1wKF19e2HhtTivNfW/HZvEoQzn3uC0eIIzchrm
 3Ejw==
X-Gm-Message-State: AOJu0YzFB7U4xV758mel+UQIRivtsbZLalhsXtkHdPCZFNdwlIVwnU2B
 6KKNLX9T2Ed22BeIFouLsvkPnGpdR3anFATpUGrht+YNpt/EJNQu74PDGbGlvHFITMvjhq1zR0V
 i/Zb71a20jC8wzTdzyKV7WI3qVNl+KZ+G4S9F+5pVsEjjwHMOavJcW7C5U0lTfUDl5LjQorLwT3
 wT00KC2DDVz/8OsLQhW9GygjQ7zHBrH+ZAoRuX
X-Received: by 2002:a17:906:b798:b0:a59:a221:e2d9 with SMTP id
 dt24-20020a170906b79800b00a59a221e2d9mr3731020ejb.70.1714983051089; 
 Mon, 06 May 2024 01:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu20ce9Jgu2jVt2ZxwTWqiMTq+ph5xlgHS42V2arTaVVwPE35N2ow8H9eRU68ptM7ycpDH0Q==
X-Received: by 2002:a17:906:b798:b0:a59:a221:e2d9 with SMTP id
 dt24-20020a170906b79800b00a59a221e2d9mr3730995ejb.70.1714983050198; 
 Mon, 06 May 2024 01:10:50 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 br9-20020a170906d14900b00a59a2189f0dsm3055323ejb.94.2024.05.06.01.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 17/25] target/i386: move C0-FF opcodes to new decoder
 (except for x87)
Date: Mon,  6 May 2024 10:09:49 +0200
Message-ID: <20240506080957.10005-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The shift instructions are rewritten instead of reusing code from the old
decoder.  Rotates use CC_OP_ADCOX more extensively and generally rely
more on the optimizer, so that the code generators are shared between
the immediate-count and variable-count cases.

In particular, this makes gen_RCL and gen_RCR pretty efficient for the
count == 1 case, which becomes (apart from a few extra movs) something like:

  (compute_cc_all if needed)
  // save old value for OF calculation
  mov     cc_src2, T0
  // the bulk of RCL is just this!
  deposit T0, cc_src, T0, 1, TARGET_LONG_BITS - 1
  // compute carry
  shr     cc_dst, cc_src2, length - 1
  and     cc_dst, cc_dst, 1
  // compute overflow
  xor     cc_src2, cc_src2, T0
  extract cc_src2, cc_src2, length - 1, 1

32-bit MUL and IMUL are also slightly more efficient on 64-bit hosts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |    1 +
 target/i386/tcg/translate.c      |   23 +-
 target/i386/tcg/decode-new.c.inc |  142 +++++
 target/i386/tcg/emit.c.inc       | 1014 +++++++++++++++++++++++++++++-
 4 files changed, 1169 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 790ad5e1d00..77bb31eb143 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -89,6 +89,7 @@ typedef enum X86OpSize {
     X86_SIZE_x,  /* 128/256-bit, based on operand size */
     X86_SIZE_y,  /* 32/64-bit, based on operand size */
     X86_SIZE_z,  /* 16-bit for 16-bit operand size, else 32-bit */
+    X86_SIZE_z_f64,  /* 32-bit for 32-bit operand size or 64-bit mode, else 16-bit */
 
     /* Custom */
     X86_SIZE_d64,
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 708fe023224..79b6e2760fe 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -38,6 +38,9 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
+/* Fixes for Windows namespace pollution.  */
+#undef IN
+#undef OUT
 
 #define PREFIX_REPZ   0x01
 #define PREFIX_REPNZ  0x02
@@ -2488,14 +2491,24 @@ static inline int insn_const_size(MemOp ot)
     }
 }
 
+static void gen_conditional_jump_labels(DisasContext *s, target_long diff,
+                                        TCGLabel *not_taken, TCGLabel *taken)
+{
+    if (not_taken) {
+        gen_set_label(not_taken);
+    }
+    gen_jmp_rel_csize(s, 0, 1);
+
+    gen_set_label(taken);
+    gen_jmp_rel(s, s->dflag, diff, 0);
+}
+
 static void gen_jcc(DisasContext *s, int b, int diff)
 {
     TCGLabel *l1 = gen_new_label();
 
     gen_jcc1(s, b, l1);
-    gen_jmp_rel_csize(s, 0, 1);
-    gen_set_label(l1);
-    gen_jmp_rel(s, s->dflag, diff, 0);
+    gen_conditional_jump_labels(s, diff, NULL, l1);
 }
 
 static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
@@ -2752,7 +2765,7 @@ static void gen_unknown_opcode(CPUX86State *env, DisasContext *s)
 
 /* an interrupt is different from an exception because of the
    privilege checks */
-static void gen_interrupt(DisasContext *s, int intno)
+static void gen_interrupt(DisasContext *s, uint8_t intno)
 {
     gen_update_cc_op(s);
     gen_update_eip_cur(s);
@@ -3183,7 +3196,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
         use_new &= b <= limit;
 #endif
-        if (use_new && b <= 0xbf) {
+        if (use_new && (b < 0xd8 || b >= 0xe0)) {
             disas_insn_new(s, cpu, b);
             return true;
         }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 55fc0173a41..a47ecab6dd4 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -135,6 +135,8 @@
     ## __VA_ARGS__                                                \
 }
 
+#define X86_OP_GROUP1(op, op0, s0, ...)                           \
+    X86_OP_GROUP3(op, op0, s0, 2op, s0, None, None, ## __VA_ARGS__)
 #define X86_OP_GROUP2(op, op0, s0, op1, s1, ...)                  \
     X86_OP_GROUP3(op, op0, s0, 2op, s0, op1, s1, ## __VA_ARGS__)
 #define X86_OP_GROUPw(op, op0, s0, ...)                           \
@@ -1174,6 +1176,83 @@ static void decode_group1A(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     }
 }
 
+static void decode_group2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86GenFunc group2_gen[8] = {
+        gen_ROL, gen_ROR, gen_RCL, gen_RCR,
+        gen_SHL, gen_SHR, gen_SHL /* SAL, undocumented */, gen_SAR,
+    };
+    int op = (get_modrm(s, env) >> 3) & 7;
+    entry->gen = group2_gen[op];
+    if (op == 7) {
+        entry->special = X86_SPECIAL_SExtT0;
+    } else {
+        entry->special = X86_SPECIAL_ZExtT0;
+    }
+}
+
+static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry opcodes_grp3[16] = {
+        /* 0xf6 */
+        [0x00] = X86_OP_ENTRYrr(AND, E,b, I,b),
+        [0x02] = X86_OP_ENTRY1(NOT,  E,b,      lock),
+        [0x03] = X86_OP_ENTRY1(NEG,  E,b,      lock),
+        [0x04] = X86_OP_ENTRYrr(MUL, E,b, 0,b, zextT0),
+        [0x05] = X86_OP_ENTRYrr(IMUL,E,b, 0,b, sextT0),
+        [0x06] = X86_OP_ENTRYr(DIV,  E,b),
+        [0x07] = X86_OP_ENTRYr(IDIV, E,b),
+
+        /* 0xf7 */
+        [0x08] = X86_OP_ENTRYrr(AND, E,v, I,z),
+        [0x0a] = X86_OP_ENTRY1(NOT,  E,v,      lock),
+        [0x0b] = X86_OP_ENTRY1(NEG,  E,v,      lock),
+        [0x0c] = X86_OP_ENTRYrr(MUL, E,v, 0,v, zextT0),
+        [0x0d] = X86_OP_ENTRYrr(IMUL,E,v, 0,v, sextT0),
+        [0x0e] = X86_OP_ENTRYr(DIV,  E,v),
+        [0x0f] = X86_OP_ENTRYr(IDIV, E,v),
+    };
+
+    int w = (*b & 1);
+    int reg = (get_modrm(s, env) >> 3) & 7;
+
+    *entry = opcodes_grp3[(w << 3) | reg];
+}
+
+static void decode_group4_5(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry opcodes_grp4_5[16] = {
+        /* 0xfe */
+        [0x00] = X86_OP_ENTRY1(INC,     E,b,                           lock),
+        [0x01] = X86_OP_ENTRY1(DEC,     E,b,                           lock),
+
+        /* 0xff */
+        [0x08] = X86_OP_ENTRY1(INC,     E,v,                           lock),
+        [0x09] = X86_OP_ENTRY1(DEC,     E,v,                           lock),
+        [0x0a] = X86_OP_ENTRY3(CALL_m,  None, None, E,f64, None, None, zextT0),
+        [0x0b] = X86_OP_ENTRYr(CALLF_m, M,p),
+        [0x0c] = X86_OP_ENTRY3(JMP_m,   None, None, E,f64, None, None, zextT0),
+        [0x0d] = X86_OP_ENTRYr(JMPF_m,  M,p),
+        [0x0e] = X86_OP_ENTRYr(PUSH,    E,f64),
+    };
+
+    int w = (*b & 1);
+    int reg = (get_modrm(s, env) >> 3) & 7;
+
+    *entry = opcodes_grp4_5[(w << 3) | reg];
+}
+
+
+static void decode_group11(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    int op = (get_modrm(s, env) >> 3) & 7;
+    if (op != 0) {
+        *entry = UNKNOWN_OPCODE;
+    } else {
+        entry->gen = gen_MOV;
+    }
+}
+
 static const X86OpEntry opcodes_root[256] = {
     [0x00] = X86_OP_ENTRY2(ADD, E,b, G,b, lock),
     [0x01] = X86_OP_ENTRY2(ADD, E,v, G,v, lock),
@@ -1283,6 +1362,38 @@ static const X86OpEntry opcodes_root[256] = {
     [0xB6] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
     [0xB7] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
 
+    [0xC0] = X86_OP_GROUP2(group2, E,b, I,b),
+    [0xC1] = X86_OP_GROUP2(group2, E,v, I,b),
+    [0xC2] = X86_OP_ENTRYr(RET, I,w),
+    [0xC3] = X86_OP_ENTRY0(RET),
+    [0xC4] = X86_OP_ENTRY3(LES, G,z, M,p, None, None, chk(i64)),
+    [0xC5] = X86_OP_ENTRY3(LDS, G,z, M,p, None, None, chk(i64)),
+    [0xC6] = X86_OP_GROUP3(group11, E,b, I,b, None, None), /* reg=000b */
+    [0xC7] = X86_OP_GROUP3(group11, E,v, I,z, None, None), /* reg=000b */
+
+    [0xD0] = X86_OP_GROUP1(group2, E,b),
+    [0xD1] = X86_OP_GROUP1(group2, E,v),
+    [0xD2] = X86_OP_GROUP2(group2, E,b, 1,b), /* CL */
+    [0xD3] = X86_OP_GROUP2(group2, E,v, 1,b), /* CL */
+    [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b),
+    [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b),
+    [0xD6] = X86_OP_ENTRYw(SALC, 0,b),
+    [0xD7] = X86_OP_ENTRY1(XLAT, 0,b, zextT0), /* AL read/written */
+
+    [0xE0] = X86_OP_ENTRYr(LOOPNE, J,b), /* implicit: CX with aflag size */
+    [0xE1] = X86_OP_ENTRYr(LOOPE,  J,b), /* implicit: CX with aflag size */
+    [0xE2] = X86_OP_ENTRYr(LOOP,   J,b), /* implicit: CX with aflag size */
+    [0xE3] = X86_OP_ENTRYr(JCXZ,   J,b), /* implicit: CX with aflag size */
+    [0xE4] = X86_OP_ENTRYwr(IN,    0,b, I_unsigned,b), /* AL */
+    [0xE5] = X86_OP_ENTRYwr(IN,    0,v, I_unsigned,b), /* AX/EAX */
+    [0xE6] = X86_OP_ENTRYrr(OUT,   0,b, I_unsigned,b), /* AL */
+    [0xE7] = X86_OP_ENTRYrr(OUT,   0,v, I_unsigned,b), /* AX/EAX */
+
+    [0xF1] = X86_OP_ENTRY0(INT1,   svm(ICEBP)),
+    [0xF4] = X86_OP_ENTRY0(HLT,    chk(cpl0)),
+    [0xF5] = X86_OP_ENTRY0(CMC),
+    [0xF6] = X86_OP_GROUP1(group3, E,b),
+    [0xF7] = X86_OP_GROUP1(group3, E,v),
 
     [0x08] = X86_OP_ENTRY2(OR, E,b, G,b, lock),
     [0x09] = X86_OP_ENTRY2(OR, E,v, G,v, lock),
@@ -1392,6 +1503,33 @@ static const X86OpEntry opcodes_root[256] = {
     [0xBD] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
     [0xBE] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
     [0xBF] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+
+    [0xC8] = X86_OP_ENTRYrr(ENTER, I,w, I,b),
+    [0xC9] = X86_OP_ENTRY1(LEAVE, A,d64),
+    [0xCA] = X86_OP_ENTRYr(RETF,  I,w),
+    [0xCB] = X86_OP_ENTRY0(RETF),
+    [0xCC] = X86_OP_ENTRY0(INT3),
+    [0xCD] = X86_OP_ENTRYr(INT, I,b,  chk(vm86_iopl)),
+    [0xCE] = X86_OP_ENTRY0(INTO),
+    [0xCF] = X86_OP_ENTRY0(IRET,      chk(vm86_iopl) svm(IRET)),
+
+    [0xE8] = X86_OP_ENTRYr(CALL,   J,z_f64),
+    [0xE9] = X86_OP_ENTRYr(JMP,    J,z_f64),
+    [0xEA] = X86_OP_ENTRYrr(JMPF,  I_unsigned,p, I_unsigned,w, chk(i64)),
+    [0xEB] = X86_OP_ENTRYr(JMP,    J,b),
+    [0xEC] = X86_OP_ENTRYwr(IN,    0,b, 2,w), /* AL, DX */
+    [0xED] = X86_OP_ENTRYwr(IN,    0,v, 2,w), /* AX/EAX, DX */
+    [0xEE] = X86_OP_ENTRYrr(OUT,   0,b, 2,w), /* DX, AL */
+    [0xEF] = X86_OP_ENTRYrr(OUT,   0,v, 2,w), /* DX, AX/EAX */
+
+    [0xF8] = X86_OP_ENTRY0(CLC),
+    [0xF9] = X86_OP_ENTRY0(STC),
+    [0xFA] = X86_OP_ENTRY0(CLI,    chk(iopl)),
+    [0xFB] = X86_OP_ENTRY0(STI,    chk(iopl)),
+    [0xFC] = X86_OP_ENTRY0(CLD),
+    [0xFD] = X86_OP_ENTRY0(STD),
+    [0xFE] = X86_OP_GROUP1(group4_5, E,b),
+    [0xFF] = X86_OP_GROUP1(group4_5, E,v),
 };
 
 #undef mmx
@@ -1471,6 +1609,10 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
         *ot = s->dflag == MO_16 ? MO_16 : MO_32;
         return true;
 
+    case X86_SIZE_z_f64:  /* 32-bit for 32-bit operand size or 64-bit mode, else 16-bit */
+        *ot = !CODE64(s) && s->dflag == MO_16 ? MO_16 : MO_32;
+        return true;
+
     case X86_SIZE_dq: /* SSE/AVX 128-bit */
         if (e->special == X86_SPECIAL_MMX &&
             !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index fd2e1db0d2e..ffe458b80f9 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -19,6 +19,21 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/*
+ * Sometimes, knowing what the backend has can produce better code.
+ * The exact opcode to check depends on 32- vs. 64-bit.
+ */
+#ifdef TARGET_X86_64
+#define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i64
+#define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i64_valid
+#define TCG_TARGET_extract_tl_valid     TCG_TARGET_extract_i64_valid
+#else
+#define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i32
+#define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i32_valid
+#define TCG_TARGET_extract_tl_valid     TCG_TARGET_extract_i32_valid
+#endif
+
+
 #define ZMM_OFFSET(reg) offsetof(CPUX86State, xmm_regs[reg])
 
 typedef void (*SSEFunc_i_ep)(TCGv_i32 val, TCGv_ptr env, TCGv_ptr reg);
@@ -45,6 +60,9 @@ typedef void (*SSEFunc_0_eppppii)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
                                   TCGv_ptr reg_c, TCGv_ptr reg_d, TCGv_i32 even,
                                   TCGv_i32 odd);
 
+static void gen_JMP_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode);
+static void gen_JMP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode);
+
 static inline TCGv_i32 tcg_constant8u_i32(uint8_t val)
 {
     return tcg_constant_i32(val);
@@ -330,6 +348,7 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
     default:
         g_assert_not_reached();
     }
+    op->unit = X86_OP_SKIP;
 }
 
 static inline int vector_len(DisasContext *s, X86DecodedInsn *decode)
@@ -1063,6 +1082,22 @@ static void gen_AAA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     set_cc_op(s, CC_OP_EFLAGS);
 }
 
+static void gen_AAD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_helper_aad(tcg_env, tcg_constant_i32(decode->immediate));
+    set_cc_op(s, CC_OP_LOGICB);
+}
+
+static void gen_AAM(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    if (decode->immediate == 0) {
+        gen_exception(s, EXCP00_DIVZ);
+    } else {
+        gen_helper_aam(tcg_env, tcg_constant_i32(decode->immediate));
+        set_cc_op(s, CC_OP_LOGICB);
+    }
+}
+
 static void gen_AAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
@@ -1295,11 +1330,33 @@ static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update2_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
+static void gen_CALL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_push_v(s, eip_next_tl(s));
+    gen_JMP(s, env, decode);
+}
+
+static void gen_CALL_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_push_v(s, eip_next_tl(s));
+    gen_JMP_m(s, env, decode);
+}
+
 static void gen_CALLF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_far_call(s);
 }
 
+static void gen_CALLF_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[2].ot;
+
+    gen_op_ld_v(s, ot, s->T0, s->A0);
+    gen_add_A0_im(s, 1 << ot);
+    gen_op_ld_v(s, MO_16, s->T1, s->A0);
+    gen_far_call(s);
+}
+
 static void gen_CBW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp src_ot = decode->op[0].ot - 1;
@@ -1307,6 +1364,28 @@ static void gen_CBW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_ext_tl(s->T0, s->T0, src_ot | MO_SIGN);
 }
 
+static void gen_CLC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_compute_eflags(s);
+    tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, ~CC_C);
+}
+
+static void gen_CLD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    tcg_gen_st_i32(tcg_constant_i32(1), tcg_env, offsetof(CPUX86State, df));
+}
+
+static void gen_CLI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_reset_eflags(s, IF_MASK);
+}
+
+static void gen_CMC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_compute_eflags(s);
+    tcg_gen_xori_tl(cpu_cc_src, cpu_cc_src, CC_C);
+}
+
 static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGLabel *label_top = gen_new_label();
@@ -1495,11 +1574,39 @@ static void gen_DEC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update_cc_incdec(decode, s, CC_OP_DECB + ot);
 }
 
+static void gen_DIV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[2].ot;
+
+    switch(ot) {
+    case MO_8:
+        gen_helper_divb_AL(tcg_env, s->T1);
+        break;
+    case MO_16:
+        gen_helper_divw_AX(tcg_env, s->T1);
+        break;
+    default:
+    case MO_32:
+        gen_helper_divl_EAX(tcg_env, s->T1);
+        break;
+#ifdef TARGET_X86_64
+    case MO_64:
+        gen_helper_divq_EAX(tcg_env, s->T1);
+        break;
+#endif
+    }
+}
+
 static void gen_EMMS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_helper_emms(tcg_env);
 }
 
+static void gen_ENTER(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+   gen_enter(s, decode->op[1].imm, decode->op[2].imm);
+}
+
 static void gen_EXTRQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 length = tcg_constant_i32(decode->immediate & 63);
@@ -1513,6 +1620,39 @@ static void gen_EXTRQ_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     gen_helper_extrq_r(tcg_env, OP_PTR0, OP_PTR2);
 }
 
+static void gen_HLT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+#ifdef CONFIG_SYSTEM_ONLY
+    gen_update_cc_op(s);
+    gen_update_eip_cur(s);
+    gen_helper_hlt(tcg_env, cur_insn_len_i32(s));
+    s->base.is_jmp = DISAS_NORETURN;
+#endif
+}
+
+static void gen_IDIV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[2].ot;
+
+    switch(ot) {
+    case MO_8:
+        gen_helper_idivb_AL(tcg_env, s->T1);
+        break;
+    case MO_16:
+        gen_helper_idivw_AX(tcg_env, s->T1);
+        break;
+    default:
+    case MO_32:
+        gen_helper_idivl_EAX(tcg_env, s->T1);
+        break;
+#ifdef TARGET_X86_64
+    case MO_64:
+        gen_helper_idivq_EAX(tcg_env, s->T1);
+        break;
+#endif
+    }
+}
+
 static void gen_IMUL3(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1576,6 +1716,80 @@ static void gen_IMUL3(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update2_cc(decode, s, CC_OP_MULB + ot);
 }
 
+static void gen_IMUL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+    TCGv cc_src_rhs;
+
+    switch (ot) {
+    case MO_8:
+        /* s->T0 already sign-extended */
+        tcg_gen_ext8s_tl(s->T1, s->T1);
+        tcg_gen_mul_tl(s->T0, s->T0, s->T1);
+        gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
+        /* Compare the full result to the extension of the truncated result.  */
+        tcg_gen_ext8s_tl(s->T1, s->T0);
+        cc_src_rhs = s->T0;
+        break;
+
+    case MO_16:
+        /* s->T0 already sign-extended */
+        tcg_gen_ext16s_tl(s->T1, s->T1);
+        tcg_gen_mul_tl(s->T0, s->T0, s->T1);
+        gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
+        tcg_gen_shri_tl(s->T1, s->T0, 16);
+        gen_op_mov_reg_v(s, MO_16, R_EDX, s->T1);
+        /* Compare the full result to the extension of the truncated result.  */
+        tcg_gen_ext16s_tl(s->T1, s->T0);
+        cc_src_rhs = s->T0;
+        break;
+
+    case MO_32:
+#ifdef TARGET_X86_64
+        /* s->T0 already sign-extended */
+        tcg_gen_ext32s_tl(s->T1, s->T1);
+        tcg_gen_mul_tl(s->T0, s->T0, s->T1);
+        tcg_gen_ext32u_tl(cpu_regs[R_EAX], s->T0);
+        tcg_gen_shri_tl(cpu_regs[R_EDX], s->T0, 32);
+        /* Compare the full result to the extension of the truncated result.  */
+        tcg_gen_ext32s_tl(s->T1, s->T0);
+        cc_src_rhs = s->T0;
+        break;
+
+    case MO_64:
+#endif
+        tcg_gen_muls2_tl(s->T0, cpu_regs[R_EDX], s->T0, s->T1);
+        tcg_gen_mov_tl(cpu_regs[R_EAX], s->T0);
+
+        /* Compare the high part to the sign bit of the truncated result */
+        tcg_gen_negsetcondi_tl(TCG_COND_LT, s->T1, s->T0, 0);
+        cc_src_rhs = cpu_regs[R_EDX];
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    tcg_gen_sub_tl(s->T1, s->T1, cc_src_rhs);
+    prepare_update2_cc(decode, s, CC_OP_MULB + ot);
+}
+
+static void gen_IN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    TCGv_i32 port = tcg_temp_new_i32();
+
+    tcg_gen_trunc_tl_i32(port, s->T1);
+    tcg_gen_ext16u_i32(port, port);
+    if (!gen_check_io(s, ot, port, SVM_IOIO_TYPE_MASK)) {
+        return;
+    }
+    translator_io_start(&s->base);
+    gen_helper_in_func(ot, s->T0, port);
+    gen_writeback(s, decode, 0, s->T0);
+    gen_bpt_io(s, port, ot);
+}
+
 static void gen_INC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
@@ -1623,12 +1837,83 @@ static void gen_INSERTQ_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     gen_helper_insertq_r(tcg_env, OP_PTR0, OP_PTR2);
 }
 
+static void gen_INT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_interrupt(s, decode->immediate);
+}
+
+static void gen_INT1(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_exception(s, EXCP01_DB);
+}
+
+static void gen_INT3(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_interrupt(s, EXCP03_INT3);
+}
+
+static void gen_INTO(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_update_eip_cur(s);
+    gen_helper_into(tcg_env, cur_insn_len_i32(s));
+}
+
+static void gen_IRET(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    if (!PE(s) || VM86(s)) {
+        gen_helper_iret_real(tcg_env, tcg_constant_i32(s->dflag - 1));
+    } else {
+        gen_helper_iret_protected(tcg_env, tcg_constant_i32(s->dflag - 1),
+                                  eip_next_i32(s));
+    }
+    set_cc_op(s, CC_OP_EFLAGS);
+    s->base.is_jmp = DISAS_EOB_ONLY;
+}
+
 static void gen_Jcc(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_bnd_jmp(s);
     gen_jcc(s, decode->b & 0xf, decode->immediate);
 }
 
+static void gen_JCXZ(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    TCGLabel *taken = gen_new_label();
+
+    gen_update_cc_op(s);
+    gen_op_jz_ecx(s, taken);
+    gen_conditional_jump_labels(s, decode->immediate, NULL, taken);
+}
+
+static void gen_JMP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_jmp_rel(s, s->dflag, decode->immediate, 0);
+}
+
+static void gen_JMP_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_op_jmp_v(s, s->T0);
+    gen_bnd_jmp(s);
+    s->base.is_jmp = DISAS_JUMP;
+}
+
+static void gen_JMPF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_far_jmp(s);
+}
+
+static void gen_JMPF_m(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[2].ot;
+
+    gen_op_ld_v(s, ot, s->T0, s->A0);
+    gen_add_A0_im(s, 1 << ot);
+    gen_op_ld_v(s, MO_16, s->T1, s->A0);
+    gen_far_jmp(s);
+}
+
 static void gen_LAHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM)) {
@@ -1646,11 +1931,38 @@ static void gen_LDMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     gen_helper_ldmxcsr(tcg_env, s->tmp2_i32);
 }
 
+static void gen_lxx_seg(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode, int seg)
+{
+    MemOp ot = decode->op[0].ot;
+
+    /* Offset already in s->T0.  */
+    gen_add_A0_im(s, 1 << ot);
+    gen_op_ld_v(s, MO_16, s->T1, s->A0);
+
+    /* load the segment here to handle exceptions properly */
+    gen_movl_seg(s, seg, s->T1);
+}
+
+static void gen_LDS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_lxx_seg(s, env, decode, R_DS);
+}
+
 static void gen_LEA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     tcg_gen_mov_tl(s->T0, s->A0);
 }
 
+static void gen_LEAVE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_leave(s);
+}
+
+static void gen_LES(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_lxx_seg(s, env, decode, R_ES);
+}
+
 static void gen_LODS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
@@ -1661,6 +1973,40 @@ static void gen_LODS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
+static void gen_LOOP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    TCGLabel *taken = gen_new_label();
+
+    gen_update_cc_op(s);
+    gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
+    gen_op_jnz_ecx(s, taken);
+    gen_conditional_jump_labels(s, decode->immediate, NULL, taken);
+}
+
+static void gen_LOOPE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    TCGLabel *taken = gen_new_label();
+    TCGLabel *not_taken = gen_new_label();
+
+    gen_update_cc_op(s);
+    gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
+    gen_op_jz_ecx(s, not_taken);
+    gen_jcc1(s, (JCC_Z << 1), taken); /* jz taken */
+    gen_conditional_jump_labels(s, decode->immediate, not_taken, taken);
+}
+
+static void gen_LOOPNE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    TCGLabel *taken = gen_new_label();
+    TCGLabel *not_taken = gen_new_label();
+
+    gen_update_cc_op(s);
+    gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
+    gen_op_jz_ecx(s, not_taken);
+    gen_jcc1(s, (JCC_Z << 1) | 1, taken); /* jnz taken */
+    gen_conditional_jump_labels(s, decode->immediate, not_taken, taken);
+}
+
 static void gen_MOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     /* nothing to do! */
@@ -1784,6 +2130,57 @@ static void gen_MOVS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
+static void gen_MUL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+
+    switch (ot) {
+    case MO_8:
+        /* s->T0 already zero-extended */
+        tcg_gen_ext8u_tl(s->T1, s->T1);
+        tcg_gen_mul_tl(s->T0, s->T0, s->T1);
+        gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
+        tcg_gen_andi_tl(s->T1, s->T0, 0xff00);
+        decode->cc_dst = s->T0;
+        decode->cc_src = s->T1;
+        break;
+
+    case MO_16:
+        /* s->T0 already zero-extended */
+        tcg_gen_ext16u_tl(s->T1, s->T1);
+        tcg_gen_mul_tl(s->T0, s->T0, s->T1);
+        gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
+        tcg_gen_shri_tl(s->T1, s->T0, 16);
+        gen_op_mov_reg_v(s, MO_16, R_EDX, s->T1);
+        decode->cc_dst = s->T0;
+        decode->cc_src = s->T1;
+        break;
+
+    case MO_32:
+#ifdef TARGET_X86_64
+        /* s->T0 already zero-extended */
+        tcg_gen_ext32u_tl(s->T1, s->T1);
+        tcg_gen_mul_tl(s->T0, s->T0, s->T1);
+        tcg_gen_ext32u_tl(cpu_regs[R_EAX], s->T0);
+        tcg_gen_shri_tl(cpu_regs[R_EDX], s->T0, 32);
+        decode->cc_dst = cpu_regs[R_EAX];
+        decode->cc_src = cpu_regs[R_EDX];
+        break;
+
+    case MO_64:
+#endif
+        tcg_gen_mulu2_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->T0, s->T1);
+        decode->cc_dst = cpu_regs[R_EAX];
+        decode->cc_src = cpu_regs[R_EDX];
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    decode->cc_op = CC_OP_MULB + ot;
+}
+
 static void gen_MULX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1810,6 +2207,46 @@ static void gen_MULX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
+static void gen_NEG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    TCGv oldv = tcg_temp_new();
+
+    if (s->prefix & PREFIX_LOCK) {
+        TCGv newv = tcg_temp_new();
+        TCGv cmpv = tcg_temp_new();
+        TCGLabel *label1 = gen_new_label();
+
+        gen_set_label(label1);
+        gen_op_ld_v(s, ot, oldv, s->A0);
+        tcg_gen_neg_tl(newv, oldv);
+        tcg_gen_atomic_cmpxchg_tl(cmpv, s->A0, oldv, newv,
+                                  s->mem_index, ot | MO_LE);
+        tcg_gen_brcond_tl(TCG_COND_NE, oldv, cmpv, label1);
+    } else {
+        tcg_gen_mov_tl(oldv, s->T0);
+    }
+    tcg_gen_neg_tl(s->T0, oldv);
+
+    decode->cc_dst = s->T0;
+    decode->cc_src = oldv;
+    tcg_gen_movi_tl(s->cc_srcT, 0);
+    decode->cc_op = CC_OP_SUBB + ot;
+}
+
+static void gen_NOT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_movi_tl(s->T0, ~0);
+        tcg_gen_atomic_xor_fetch_tl(s->T0, s->A0, s->T0,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_not_tl(s->T0, s->T0);
+    }
+}
+
 static void gen_OR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
@@ -1823,6 +2260,23 @@ static void gen_OR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
+static void gen_OUT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+    TCGv_i32 port = tcg_temp_new_i32();
+    TCGv_i32 value = tcg_temp_new_i32();
+
+    tcg_gen_trunc_tl_i32(port, s->T1);
+    tcg_gen_ext16u_i32(port, port);
+    if (!gen_check_io(s, ot, port, 0)) {
+        return;
+    }
+    tcg_gen_trunc_tl_i32(value, s->T0);
+    translator_io_start(&s->base);
+    gen_helper_out_func(ot, port, value);
+    gen_bpt_io(s, port, ot);
+}
+
 static void gen_OUTS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
@@ -2035,12 +2489,6 @@ static void gen_pmovmskb_vec(unsigned vece, TCGv_vec d, TCGv_vec s)
     tcg_gen_or_vec(vece, d, d, t);
 }
 
-#ifdef TARGET_X86_64
-#define TCG_TARGET_HAS_extract2_tl TCG_TARGET_HAS_extract2_i64
-#else
-#define TCG_TARGET_HAS_extract2_tl TCG_TARGET_HAS_extract2_i32
-#endif
-
 static void gen_PMOVMSKB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     static const TCGOpcode vecop_list[] = { INDEX_op_shli_vec, 0 };
@@ -2287,6 +2735,438 @@ static void gen_PUSHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_push_v(s, s->T0);
 }
 
+static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
+                             bool *can_be_zero, TCGv *count)
+{
+    MemOp ot = decode->op[0].ot;
+    int mask = (ot <= MO_32 ? 0x1f : 0x3f);
+
+    *can_be_zero = false;
+    switch (decode->op[2].unit) {
+    case X86_OP_INT:
+        *count = tcg_temp_new();
+        tcg_gen_andi_tl(*count, s->T1, mask);
+        *can_be_zero = true;
+        break;
+
+    case X86_OP_IMM:
+        if ((decode->immediate & mask) == 0) {
+            *count = NULL;
+            break;
+        }
+        *count = tcg_temp_new();
+        tcg_gen_movi_tl(*count, decode->immediate & mask);
+        break;
+
+    case X86_OP_SKIP:
+        *count = tcg_temp_new();
+        tcg_gen_movi_tl(*count, 1);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    return ot;
+}
+
+/*
+ * Compute existing flags in decode->cc_src, for gen_* functions that wants
+ * to set the cc_op set to CC_OP_ADCOX.  In particular, this allows rotate
+ * operations to compute the carry in decode->cc_dst and the overflow in
+ * decode->cc_src2.
+ *
+ * If need_flags is true, decode->cc_dst and decode->cc_src2 are preloaded
+ * with the value of CF and OF before the instruction, so that it is possible
+ * to keep the flags unmodified.
+ *
+ * Return true if carry could be made available cheaply as a 1-bit value in
+ * decode->cc_dst (trying a bit harder if want_carry is true).  If false is
+ * returned, decode->cc_dst is uninitialized and the carry is only available
+ * as bit 0 of decode->cc_src.
+ */
+static bool gen_eflags_adcox(DisasContext *s, X86DecodedInsn *decode, bool want_carry, bool need_flags)
+{
+    bool got_cf = false;
+    bool got_of = false;
+
+    decode->cc_dst = tcg_temp_new();
+    decode->cc_src = tcg_temp_new();
+    decode->cc_src2 = tcg_temp_new();
+    decode->cc_op = CC_OP_ADCOX;
+
+    /* A lot more cc_ops could be "optimized" to avoid the extracts at
+     * the end (INC/DEC, BMILG, MUL), but they are all really unlikely
+     * to be followed by rotations within the same basic block.
+     */
+    switch (s->cc_op) {
+    case CC_OP_ADCOX:
+        /* No need to compute the full EFLAGS, CF/OF are already isolated.  */
+        tcg_gen_mov_tl(decode->cc_src, cpu_cc_src);
+        if (need_flags) {
+            tcg_gen_mov_tl(decode->cc_src2, cpu_cc_src2);
+            got_of = true;
+        }
+        if (want_carry || need_flags) {
+            tcg_gen_mov_tl(decode->cc_dst, cpu_cc_dst);
+            got_cf = true;
+        }
+        break;
+
+    case CC_OP_LOGICB ... CC_OP_LOGICQ:
+        /* CF and OF are zero, do it just because it's easy.  */
+        gen_mov_eflags(s, decode->cc_src);
+        if (need_flags) {
+            tcg_gen_movi_tl(decode->cc_src2, 0);
+            got_of = true;
+        }
+        if (want_carry || need_flags) {
+            tcg_gen_movi_tl(decode->cc_dst, 0);
+            got_cf = true;
+        }
+        break;
+
+    case CC_OP_SARB ... CC_OP_SARQ:
+        /*
+         * SHR/RCR/SHR/RCR/... is a relatively common occurrence of RCR.
+         * By computing CF without using eflags, the calls to cc_compute_all
+         * can be eliminated as dead code (except for the last RCR).
+         */
+        if (want_carry || need_flags) {
+            tcg_gen_andi_tl(decode->cc_dst, cpu_cc_src, 1);
+            got_cf = true;
+        }
+        gen_mov_eflags(s, decode->cc_src);
+        break;
+
+    case CC_OP_SHLB ... CC_OP_SHLQ:
+        /*
+         * Likewise for SHL/RCL/SHL/RCL/... but, if CF is not in the sign
+         * bit, we might as well fish CF out of EFLAGS and save a shift.
+         */
+        if (want_carry && (!need_flags || s->cc_op == CC_OP_SHLB + MO_TL)) {
+            tcg_gen_shri_tl(decode->cc_dst, cpu_cc_src, (8 << (s->cc_op - CC_OP_SHLB)) - 1);
+            got_cf = true;
+        }
+        gen_mov_eflags(s, decode->cc_src);
+        break;
+
+    default:
+        gen_mov_eflags(s, decode->cc_src);
+        break;
+    }
+
+    if (need_flags) {
+        /* If the flags could be left unmodified, always load them.  */
+        if (!got_of) {
+            tcg_gen_extract_tl(decode->cc_src2, decode->cc_src, ctz32(CC_O), 1);
+            got_of = true;
+        }
+        if (!got_cf) {
+            tcg_gen_extract_tl(decode->cc_dst, decode->cc_src, ctz32(CC_C), 1);
+            got_cf = true;
+        }
+    }
+    return got_cf;
+}
+
+static void gen_rot_overflow(X86DecodedInsn *decode, TCGv result, TCGv old, TCGv count)
+{
+    MemOp ot = decode->op[0].ot;
+    TCGv temp = count ? tcg_temp_new() : decode->cc_src2;
+
+    tcg_gen_xor_tl(temp, old, result);
+    tcg_gen_extract_tl(temp, temp, (8 << ot) - 1, 1);
+    if (count) {
+        tcg_gen_movcond_tl(TCG_COND_EQ, decode->cc_src2, count, tcg_constant_tl(0),
+                           decode->cc_src2, temp);
+    }
+}
+
+/*
+ * RCx operations are invariant modulo 8*operand_size+1.  For 8 and 16-bit operands,
+ * this is less than 0x1f (the mask applied by gen_shift_count) so reduce further.
+ */
+static void gen_rotc_mod(MemOp ot, TCGv count)
+{
+    TCGv temp;
+
+    switch (ot) {
+    case MO_8:
+        temp = tcg_temp_new();
+        tcg_gen_subi_tl(temp, count, 18);
+        tcg_gen_movcond_tl(TCG_COND_GE, count, temp, tcg_constant_tl(0), temp, count);
+        tcg_gen_subi_tl(temp, count, 9);
+        tcg_gen_movcond_tl(TCG_COND_GE, count, temp, tcg_constant_tl(0), temp, count);
+        break;
+
+    case MO_16:
+        temp = tcg_temp_new();
+        tcg_gen_subi_tl(temp, count, 17);
+        tcg_gen_movcond_tl(TCG_COND_GE, count, temp, tcg_constant_tl(0), temp, count);
+        break;
+
+    default:
+        break;
+    }
+}
+
+/*
+ * The idea here is that the bit to the right of the new bit 0 is the
+ * new carry, and the bit to the right of the old bit 0 is the old carry.
+ * Just like a regular rotation, the result of the rotation is composed
+ * from a right shifted part and a left shifted part of s->T0.  The new carry
+ * is extracted from the right-shifted portion, and the old carry is
+ * inserted at the end of the left-shifted portion.
+ *
+ * Because of the separate shifts involving the carry, gen_RCL and gen_RCR
+ * mostly operate on count-1.  This also comes in handy when computing
+ * length - count, because (length-1) - (count-1) can be computed with
+ * a XOR, and that is commutative unlike subtraction.
+ */
+static void gen_RCL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    bool have_1bit_cin, can_be_zero;
+    TCGv count;
+    TCGLabel *zero_label = NULL;
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    TCGv low, high, low_count;
+
+    if (!count) {
+        return;
+    }
+
+    low = tcg_temp_new();
+    high = tcg_temp_new();
+    low_count = tcg_temp_new();
+
+    gen_rotc_mod(ot, count);
+    have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
+    if (can_be_zero) {
+        zero_label = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, count, 0, zero_label);
+    }
+
+    /* Compute high part, including incoming carry.  */
+    if (!have_1bit_cin || TCG_TARGET_deposit_tl_valid(1, TARGET_LONG_BITS - 1)) {
+        /* high = (T0 << 1) | cin */
+        TCGv cin = have_1bit_cin ? decode->cc_dst : decode->cc_src;
+        tcg_gen_deposit_tl(high, cin, s->T0, 1, TARGET_LONG_BITS - 1);
+    } else {
+        /* Same as above but without deposit; cin in cc_dst.  */
+        tcg_gen_add_tl(high, s->T0, decode->cc_dst);
+        tcg_gen_add_tl(high, high, s->T0);
+    }
+    tcg_gen_subi_tl(count, count, 1);
+    tcg_gen_shl_tl(high, high, count);
+
+    /* Compute low part and outgoing carry, incoming s->T0 is zero extended */
+    tcg_gen_xori_tl(low_count, count, (8 << ot) - 1); /* LENGTH - 1 - (count - 1) */
+    tcg_gen_shr_tl(low, s->T0, low_count);
+    tcg_gen_andi_tl(decode->cc_dst, low, 1);
+    tcg_gen_shri_tl(low, low, 1);
+
+    /* Compute result and outgoing overflow */
+    tcg_gen_mov_tl(decode->cc_src2, s->T0);
+    tcg_gen_or_tl(s->T0, low, high);
+    gen_rot_overflow(decode, s->T0, decode->cc_src2, NULL);
+
+    if (zero_label) {
+        gen_set_label(zero_label);
+    }
+}
+
+static void gen_RCR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    bool have_1bit_cin, can_be_zero;
+    TCGv count;
+    TCGLabel *zero_label = NULL;
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    TCGv low, high, high_count;
+
+    if (!count) {
+        return;
+    }
+
+    low = tcg_temp_new();
+    high = tcg_temp_new();
+    high_count = tcg_temp_new();
+
+    gen_rotc_mod(ot, count);
+    have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
+    if (can_be_zero) {
+        zero_label = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, count, 0, zero_label);
+    }
+
+    /* Save incoming carry into high, it will be shifted later.  */
+    if (!have_1bit_cin || TCG_TARGET_deposit_tl_valid(1, TARGET_LONG_BITS - 1)) {
+        TCGv cin = have_1bit_cin ? decode->cc_dst : decode->cc_src;
+        tcg_gen_deposit_tl(high, cin, s->T0, 1, TARGET_LONG_BITS - 1);
+    } else {
+        /* Same as above but without deposit; cin in cc_dst.  */
+        tcg_gen_add_tl(high, s->T0, decode->cc_dst);
+        tcg_gen_add_tl(high, high, s->T0);
+    }
+
+    /* Compute low part and outgoing carry, incoming s->T0 is zero extended */
+    tcg_gen_subi_tl(count, count, 1);
+    tcg_gen_shr_tl(low, s->T0, count);
+    tcg_gen_andi_tl(decode->cc_dst, low, 1);
+    tcg_gen_shri_tl(low, low, 1);
+
+    /* Move high part to the right position */
+    tcg_gen_xori_tl(high_count, count, (8 << ot) - 1); /* LENGTH - 1 - (count - 1) */
+    tcg_gen_shl_tl(high, high, high_count);
+
+    /* Compute result and outgoing overflow */
+    tcg_gen_mov_tl(decode->cc_src2, s->T0);
+    tcg_gen_or_tl(s->T0, low, high);
+    gen_rot_overflow(decode, s->T0, decode->cc_src2, NULL);
+
+    if (zero_label) {
+        gen_set_label(zero_label);
+    }
+}
+
+static void gen_RET(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    int16_t adjust = decode->e.op2 == X86_TYPE_I ? decode->immediate : 0;
+
+    MemOp ot = gen_pop_T0(s);
+    gen_stack_update(s, adjust + (1 << ot));
+    gen_op_jmp_v(s, s->T0);
+    gen_bnd_jmp(s);
+    s->base.is_jmp = DISAS_JUMP;
+}
+
+static void gen_RETF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    int16_t adjust = decode->e.op2 == X86_TYPE_I ? decode->immediate : 0;
+
+    if (!PE(s) || VM86(s)) {
+        gen_stack_A0(s);
+        /* pop offset */
+        gen_op_ld_v(s, s->dflag, s->T0, s->A0);
+        /* NOTE: keeping EIP updated is not a problem in case of
+           exception */
+        gen_op_jmp_v(s, s->T0);
+        /* pop selector */
+        gen_add_A0_im(s, 1 << s->dflag);
+        gen_op_ld_v(s, s->dflag, s->T0, s->A0);
+        gen_op_movl_seg_real(s, R_CS, s->T0);
+        /* add stack offset */
+        gen_stack_update(s, adjust + (2 << s->dflag));
+    } else {
+        gen_update_cc_op(s);
+        gen_update_eip_cur(s);
+        gen_helper_lret_protected(tcg_env, tcg_constant_i32(s->dflag - 1),
+                                  tcg_constant_i32(adjust));
+    }
+    s->base.is_jmp = DISAS_EOB_ONLY;
+}
+
+/*
+ * Return non-NULL if a 32-bit rotate works, after possibly replicating the input.
+ * The input has already been zero-extended upon operand decode.
+ */
+static TCGv_i32 gen_rot_replicate(MemOp ot, TCGv in)
+{
+    TCGv_i32 temp;
+    switch (ot) {
+    case MO_8:
+        temp = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(temp, in);
+        tcg_gen_muli_i32(temp, temp, 0x01010101);
+        return temp;
+
+    case MO_16:
+        temp = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(temp, in);
+        tcg_gen_deposit_i32(temp, temp, temp, 16, 16);
+        return temp;
+
+#ifdef TARGET_X86_64
+    case MO_32:
+        temp = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(temp, in);
+        return temp;
+#endif
+
+    default:
+        return NULL;
+    }
+}
+
+static void gen_rot_carry(X86DecodedInsn *decode, TCGv result, TCGv count, int bit)
+{
+    if (count == NULL) {
+        tcg_gen_extract_tl(decode->cc_dst, result, bit, 1);
+    } else {
+        TCGv temp = tcg_temp_new();
+        tcg_gen_extract_tl(temp, result, bit, 1);
+        tcg_gen_movcond_tl(TCG_COND_EQ, decode->cc_dst, count, tcg_constant_tl(0),
+                           decode->cc_dst, temp);
+    }
+}
+
+static void gen_ROL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    bool can_be_zero;
+    TCGv count;
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    TCGv_i32 temp32, count32;
+    TCGv old = tcg_temp_new();
+
+    if (!count) {
+        return;
+    }
+
+    gen_eflags_adcox(s, decode, false, can_be_zero);
+    tcg_gen_mov_tl(old, s->T0);
+    temp32 = gen_rot_replicate(ot, s->T0);
+    if (temp32) {
+        count32 = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(count32, count);
+        tcg_gen_rotl_i32(temp32, temp32, count32);
+        /* Zero extend to facilitate later optimization.  */
+        tcg_gen_extu_i32_tl(s->T0, temp32);
+    } else {
+        tcg_gen_rotl_tl(s->T0, s->T0, count);
+    }
+    gen_rot_carry(decode, s->T0, count, 0);
+    gen_rot_overflow(decode, s->T0, old, count);
+}
+
+static void gen_ROR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    bool can_be_zero;
+    TCGv count;
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    TCGv_i32 temp32, count32;
+    TCGv old = tcg_temp_new();
+
+    if (!count) {
+        return;
+    }
+
+    gen_eflags_adcox(s, decode, false, can_be_zero);
+    tcg_gen_mov_tl(old, s->T0);
+    temp32 = gen_rot_replicate(ot, s->T0);
+    if (temp32) {
+        count32 = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(count32, count);
+        tcg_gen_rotr_i32(temp32, temp32, count32);
+        /* Zero extend to facilitate later optimization.  */
+        tcg_gen_extu_i32_tl(s->T0, temp32);
+        gen_rot_carry(decode, s->T0, count, 31);
+    } else {
+        tcg_gen_rotr_tl(s->T0, s->T0, count);
+        gen_rot_carry(decode, s->T0, count, TARGET_LONG_BITS - 1);
+    }
+    gen_rot_overflow(decode, s->T0, old, count);
+}
+
 static void gen_RORX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -2323,6 +3203,57 @@ static void gen_SAHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
 }
 
+static void gen_SALC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_compute_eflags_c(s, s->T0);
+    tcg_gen_neg_tl(s->T0, s->T0);
+}
+
+static void gen_shift_dynamic_flags(DisasContext *s, X86DecodedInsn *decode, TCGv count, CCOp cc_op)
+{
+    TCGv_i32 count32 = tcg_temp_new_i32();
+    decode->cc_op = CC_OP_DYNAMIC;
+    decode->cc_op_dynamic = tcg_temp_new_i32();
+
+    assert(decode->cc_dst == s->T0);
+    if (cc_op_live[s->cc_op] & USES_CC_DST) {
+        decode->cc_dst = tcg_temp_new();
+        tcg_gen_movcond_tl(TCG_COND_EQ, decode->cc_dst, count, tcg_constant_tl(0),
+                           cpu_cc_dst, s->T0);
+    }
+
+    if (cc_op_live[s->cc_op] & USES_CC_SRC) {
+        tcg_gen_movcond_tl(TCG_COND_EQ, decode->cc_src, count, tcg_constant_tl(0),
+                           cpu_cc_src, decode->cc_src);
+    }
+
+    tcg_gen_trunc_tl_i32(count32, count);
+    tcg_gen_movcond_i32(TCG_COND_EQ, decode->cc_op_dynamic, count32, tcg_constant_i32(0),
+                        cpu_cc_op, tcg_constant_i32(cc_op));
+}
+
+static void gen_SAR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    bool can_be_zero;
+    TCGv count;
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+
+    if (!count) {
+        return;
+    }
+
+    decode->cc_dst = s->T0;
+    decode->cc_src = tcg_temp_new();
+    tcg_gen_subi_tl(decode->cc_src, count, 1);
+    tcg_gen_sar_tl(decode->cc_src, s->T0, decode->cc_src);
+    tcg_gen_sar_tl(s->T0, s->T0, count);
+    if (can_be_zero) {
+        gen_shift_dynamic_flags(s, decode, count, CC_OP_SARB + ot);
+    } else {
+        decode->cc_op = CC_OP_SARB + ot;
+    }
+}
+
 static void gen_SARX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -2421,6 +3352,28 @@ static void gen_SHA256RNDS2(DisasContext *s, CPUX86State *env, X86DecodedInsn *d
     gen_helper_sha256rnds2(OP_PTR0, OP_PTR1, OP_PTR2, wk0, wk1);
 }
 
+static void gen_SHL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    bool can_be_zero;
+    TCGv count;
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+
+    if (!count) {
+        return;
+    }
+
+    decode->cc_dst = s->T0;
+    decode->cc_src = tcg_temp_new();
+    tcg_gen_subi_tl(decode->cc_src, count, 1);
+    tcg_gen_shl_tl(decode->cc_src, s->T0, decode->cc_src);
+    tcg_gen_shl_tl(s->T0, s->T0, count);
+    if (can_be_zero) {
+        gen_shift_dynamic_flags(s, decode, count, CC_OP_SHLB + ot);
+    } else {
+        decode->cc_op = CC_OP_SHLB + ot;
+    }
+}
+
 static void gen_SHLX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -2431,6 +3384,28 @@ static void gen_SHLX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_shl_tl(s->T0, s->T0, s->T1);
 }
 
+static void gen_SHR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    bool can_be_zero;
+    TCGv count;
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+
+    if (!count) {
+        return;
+    }
+
+    decode->cc_dst = s->T0;
+    decode->cc_src = tcg_temp_new();
+    tcg_gen_subi_tl(decode->cc_src, count, 1);
+    tcg_gen_shr_tl(decode->cc_src, s->T0, decode->cc_src);
+    tcg_gen_shr_tl(s->T0, s->T0, count);
+    if (can_be_zero) {
+        gen_shift_dynamic_flags(s, decode, count, CC_OP_SARB + ot);
+    } else {
+        decode->cc_op = CC_OP_SARB + ot;
+    }
+}
+
 static void gen_SHRX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -2441,6 +3416,25 @@ static void gen_SHRX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_shr_tl(s->T0, s->T0, s->T1);
 }
 
+static void gen_STC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_compute_eflags(s);
+    tcg_gen_ori_tl(cpu_cc_src, cpu_cc_src, CC_C);
+}
+
+static void gen_STD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    tcg_gen_st_i32(tcg_constant_i32(-1), tcg_env, offsetof(CPUX86State, df));
+}
+
+static void gen_STI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_set_eflags(s, IF_MASK);
+    /* interruptions are enabled only the first insn after sti */
+    gen_update_eip_next(s);
+    gen_eob_inhibit_irq(s);
+}
+
 static void gen_VAESKEYGEN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -2997,6 +3991,14 @@ static void gen_XCHG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
+static void gen_XLAT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    /* AL is already zero-extended into s->T0.  */
+    tcg_gen_add_tl(s->A0, cpu_regs[R_EBX], s->T0);
+    gen_add_A0_ds_seg(s);
+    gen_op_ld_v(s, MO_8, s->T0, s->A0);
+}
+
 static void gen_XOR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     /* special case XOR reg, reg */
-- 
2.45.0


