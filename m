Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F849C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tSB-0005Dn-Cx; Mon, 06 May 2024 04:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tRo-0004wU-GR
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQw-0002Ow-VG
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSDDS0d2JAHHVde30lbOHK88Xbc8BA170ZixC1nxSFg=;
 b=Xf0heCznUuKwqw6HYGAaB9dSdVc43MSE+NHTD4gxLHpwa9uVq1U8EAyTvD2vlxCN07GMgd
 jxaYhbJ4vqdHg1UqeAG/BE+MHXVZqJHD4XV/7PkmVJy7XWgXEMinJ8yZVPHspEwIQvb9kE
 Y8/FoxYOSWQxEFzgZwVfubVnTodDcdE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-Yd3QbIZ5MESV0udd-rch7Q-1; Mon, 06 May 2024 04:10:47 -0400
X-MC-Unique: Yd3QbIZ5MESV0udd-rch7Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59ab39c8b6so109708466b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983046; x=1715587846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LSDDS0d2JAHHVde30lbOHK88Xbc8BA170ZixC1nxSFg=;
 b=imZTkjvHz8dolnsNAmnC77OmMSOPZbaPu3Q6jM+n3v7mBWKi3xSgVy3YnP3AGWiM6z
 UvI1le3BF6o3a+ZdBbnS7FbX6FXakzH7wlv1KJ1HWeU4zuIDj/lPRSjDB8aCA8UzBwmh
 fkyXnPiUAEnxGdAeXioX6toAHFAEMa2C57gnFYK1DTXyWcax5LjxsLus3wRuE5WhuKoL
 ekI92aWJ+B5zKDo0H0tdKvSmRt2PPd2taL+AVupxXKGjjmH0Grg+oT3wb7cJEszTGLRK
 a2tlzRc2FkdqTo3t4/H7zHNnOGpsx0ZUvriMSZSvrNu/paZ9Lv85yystRh2pK6tW4IC3
 AYuA==
X-Gm-Message-State: AOJu0YxG6OHhVyd0n+cK54xTg6wcg9vqXybPGp3phrmOAQb0if+/oXNX
 w/cwvgkKMzYrgxCQ0CAlDpsYlCFMJuuxp7xktrgN8BbfAipELWzXpcWB8IoEZG8Dg/ttg3YJ3Ar
 TNShBELdz8FBRDSnp/thSE3LlEWzLTxYuQOnXT1f/5udG8DFpiLjjoqro/wwqU6TABzTC5S5J62
 iL/jgPnNcdur/d84Vie9p0dZ6V5+2m10jCnVV1
X-Received: by 2002:a50:d4d5:0:b0:56c:5a49:730 with SMTP id
 e21-20020a50d4d5000000b0056c5a490730mr5327960edj.19.1714983045680; 
 Mon, 06 May 2024 01:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErSRZNdg3M8z7MAEdEkJF8WTfvdjGbbPoc5tuxCmA2cjoaJB/AZnREQFhejF3ZdkjzuWrIMw==
X-Received: by 2002:a50:d4d5:0:b0:56c:5a49:730 with SMTP id
 e21-20020a50d4d5000000b0056c5a490730mr5327942edj.19.1714983045079; 
 Mon, 06 May 2024 01:10:45 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 dj28-20020a05640231bc00b00572c2a849acsm4846581edb.21.2024.05.06.01.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 15/25] target/i386: move 60-BF opcodes to new decoder
Date: Mon,  6 May 2024 10:09:47 +0200
Message-ID: <20240506080957.10005-16-pbonzini@redhat.com>
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

Compared to the old decoder, the main differences in translation
are for the little-used ARPL instruction.  IMUL is adjusted a bit
to share more code to produce flags, but is otherwise very similar.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |   3 +
 target/i386/tcg/translate.c      |   9 +-
 target/i386/tcg/decode-new.c.inc | 185 ++++++++++++++++++
 target/i386/tcg/emit.c.inc       | 323 +++++++++++++++++++++++++++++++
 4 files changed, 518 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 8ffde8d1cd6..790ad5e1d00 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -48,6 +48,7 @@ typedef enum X86OpType {
 
     /* Custom */
     X86_TYPE_WM, /* modrm byte selects an XMM/YMM memory operand */
+    X86_TYPE_I_unsigned, /* Immediate, zero-extended */
     X86_TYPE_2op, /* 2-operand RMW instruction */
     X86_TYPE_LoBits, /* encoded in bits 0-2 of the operand + REX.B */
     X86_TYPE_0, /* Hard-coded GPRs (RAX..RDI) */
@@ -165,6 +166,8 @@ typedef enum X86InsnSpecial {
     /* Always locked if it has a memory operand (XCHG) */
     X86_SPECIAL_Locked,
 
+    /* Do not apply segment base to effective address */
+    X86_SPECIAL_NoSeg,
     /*
      * Rd/Mb or Rd/Mw in the manual: register operand 0 is treated as 32 bits
      * (and writeback zero-extends it to 64 bits if applicable).  PREFIX_DATA
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4069bd4f125..8f633814586 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1288,7 +1288,11 @@ static void gen_cmps(DisasContext *s, MemOp ot)
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
     gen_string_movl_A0_ESI(s);
-    gen_op(s, OP_CMPL, ot, OR_TMP0);
+    gen_op_ld_v(s, ot, s->T0, s->A0);
+    tcg_gen_mov_tl(cpu_cc_src, s->T1);
+    tcg_gen_mov_tl(s->cc_srcT, s->T0);
+    tcg_gen_sub_tl(cpu_cc_dst, s->T0, s->T1);
+    set_cc_op(s, CC_OP_SUBB + ot);
 
     dshift = gen_compute_Dshift(s, ot);
     gen_op_add_reg(s, s->aflag, R_ESI, dshift);
@@ -3121,6 +3125,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
     s->pc = s->base.pc_next;
     s->override = -1;
+    s->popl_esp_hack = 0;
 #ifdef TARGET_X86_64
     s->rex_r = 0;
     s->rex_x = 0;
@@ -3178,7 +3183,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
         use_new &= b <= limit;
 #endif
-        if (use_new && b <= 0x5f) {
+        if (use_new && b <= 0xbf) {
             disas_insn_new(s, cpu, b);
             return true;
         }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index c6fd7a053bd..55fc0173a41 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -33,6 +33,22 @@
  * ("cannot encode 16-bit or 32-bit size in 64-bit mode") as modifiers of the
  * "v" or "z" sizes.  The decoder simply makes them separate operand sizes.
  *
+ * The manual lists immediate far destinations as Ap (technically an implicit
+ * argument).  The decoder splits them into two immediates, using "Ip" for
+ * the offset part (that comes first in the instruction stream) and "Iw" for
+ * the segment/selector part.  The size of the offset is given by s->dflag
+ * and the instructions are illegal in 64-bit mode, so the choice of "Ip"
+ * is somewhat arbitrary; "Iv" or "Iz" would work just as well.
+ *
+ * Operand types
+ * -------------
+ *
+ * Immediates are almost always signed or masked away in helpers.  Two
+ * common exceptions are IN/OUT and absolute jumps.  For these, there is
+ * an additional custom operand type "I_unsigned".  Alternatively, the
+ * mask could be applied (and the original sign-extended value would be
+ * optimized away by TCG) in the emitter function.
+ *
  * Vector operands
  * ---------------
  *
@@ -151,6 +167,8 @@
  */
 #define X86_OP_ENTRYrr(op, op0, s0, op1, s1, ...)                 \
     X86_OP_ENTRY3(op, None, None, op0, s0, op1, s1, ## __VA_ARGS__)
+#define X86_OP_ENTRYwr(op, op0, s0, op1, s1, ...)                 \
+    X86_OP_ENTRY3(op, op0, s0, None, None, op1, s1, ## __VA_ARGS__)
 #define X86_OP_ENTRY2(op, op0, s0, op1, s1, ...)                  \
     X86_OP_ENTRY3(op, op0, s0, 2op, s0, op1, s1, ## __VA_ARGS__)
 #define X86_OP_ENTRYw(op, op0, s0, ...)                           \
@@ -163,6 +181,7 @@
     X86_OP_ENTRY3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
 #define cpuid(feat) .cpuid = X86_FEAT_##feat,
+#define noseg .special = X86_SPECIAL_NoSeg,
 #define xchg .special = X86_SPECIAL_Locked,
 #define lock .special = X86_SPECIAL_HasLock,
 #define mmx .special = X86_SPECIAL_MMX,
@@ -209,6 +228,8 @@
 #define p_66_f3_f2    .valid_prefix = P_66 | P_F3 | P_F2,
 #define p_00_66_f3_f2 .valid_prefix = P_00 | P_66 | P_F3 | P_F2,
 
+#define UNKNOWN_OPCODE ((X86OpEntry) {})
+
 static uint8_t get_modrm(DisasContext *s, CPUX86State *env)
 {
     if (!s->has_modrm) {
@@ -1108,6 +1129,51 @@ static void decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint
     do_decode_0F(s, env, entry, b);
 }
 
+static void decode_63(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry arpl = X86_OP_ENTRY2(ARPL, E,w, G,w, chk(prot));
+    static const X86OpEntry mov = X86_OP_ENTRY3(MOV, G,v, E,v, None, None);
+    static const X86OpEntry movsxd = X86_OP_ENTRY3(MOV, G,v, E,d, None, None, sextT0);
+    if (!CODE64(s)) {
+        *entry = arpl;
+    } else if (REX_W(s)) {
+        *entry = movsxd;
+    } else {
+        *entry = mov;
+    }
+}
+
+static void decode_group1(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86GenFunc group1_gen[8] = {
+        gen_ADD, gen_OR, gen_ADC, gen_SBB, gen_AND, gen_SUB, gen_XOR, gen_SUB,
+    };
+    int op = (get_modrm(s, env) >> 3) & 7;
+    entry->gen = group1_gen[op];
+
+    if (op == 7) {
+        /* prevent writeback for CMP */
+        entry->op1 = entry->op0;
+        entry->op0 = X86_TYPE_None;
+        entry->s0 = X86_SIZE_None;
+    } else {
+        entry->special = X86_SPECIAL_HasLock;
+    }
+}
+
+static void decode_group1A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    int op = (get_modrm(s, env) >> 3) & 7;
+    if (op != 0) {
+        /* could be XOP prefix too */
+        *entry = UNKNOWN_OPCODE;
+    } else {
+        entry->gen = gen_POP;
+        /* The address must use the value of ESP after the pop.  */
+        s->popl_esp_hack = 1 << mo_pushpop(s, s->dflag);
+    }
+}
+
 static const X86OpEntry opcodes_root[256] = {
     [0x00] = X86_OP_ENTRY2(ADD, E,b, G,b, lock),
     [0x01] = X86_OP_ENTRY2(ADD, E,v, G,v, lock),
@@ -1163,6 +1229,60 @@ static const X86OpEntry opcodes_root[256] = {
     [0x56] = X86_OP_ENTRYr(PUSH, LoBits,d64),
     [0x57] = X86_OP_ENTRYr(PUSH, LoBits,d64),
 
+    [0x60] = X86_OP_ENTRY0(PUSHA, chk(i64)),
+    [0x61] = X86_OP_ENTRY0(POPA, chk(i64)),
+    [0x62] = X86_OP_ENTRYrr(BOUND, G,v, M,a, chk(i64)),
+    [0x63] = X86_OP_GROUP0(63),
+    [0x64] = {},
+    [0x65] = {},
+    [0x66] = {},
+    [0x67] = {},
+
+    [0x70] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x71] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x72] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x73] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x74] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x75] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x76] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x77] = X86_OP_ENTRYr(Jcc, J,b),
+
+    [0x80] = X86_OP_GROUP2(group1, E,b, I,b),
+    [0x81] = X86_OP_GROUP2(group1, E,v, I,z),
+    [0x82] = X86_OP_GROUP2(group1, E,b, I,b, chk(i64)),
+    [0x83] = X86_OP_GROUP2(group1, E,v, I,b),
+    [0x84] = X86_OP_ENTRYrr(AND, E,b, G,b),
+    [0x85] = X86_OP_ENTRYrr(AND, E,v, G,v),
+    [0x86] = X86_OP_ENTRY2(XCHG, E,b, G,b, xchg),
+    [0x87] = X86_OP_ENTRY2(XCHG, E,v, G,v, xchg),
+
+    [0x90] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x91] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x92] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x93] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x94] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x95] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x96] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x97] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+
+    [0xA0] = X86_OP_ENTRY3(MOV, 0,b, O,b, None, None), /* AL, Ob */
+    [0xA1] = X86_OP_ENTRY3(MOV, 0,v, O,v, None, None), /* rAX, Ov */
+    [0xA2] = X86_OP_ENTRY3(MOV, O,b, 0,b, None, None), /* Ob, AL */
+    [0xA3] = X86_OP_ENTRY3(MOV, O,v, 0,v, None, None), /* Ov, rAX */
+    [0xA4] = X86_OP_ENTRYrr(MOVS, Y,b, X,b),
+    [0xA5] = X86_OP_ENTRYrr(MOVS, Y,v, X,v),
+    [0xA6] = X86_OP_ENTRYrr(CMPS, Y,b, X,b),
+    [0xA7] = X86_OP_ENTRYrr(CMPS, Y,v, X,v),
+
+    [0xB0] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB1] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB2] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB3] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB4] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB5] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB6] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB7] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+
 
     [0x08] = X86_OP_ENTRY2(OR, E,b, G,b, lock),
     [0x09] = X86_OP_ENTRY2(OR, E,v, G,v, lock),
@@ -1217,6 +1337,61 @@ static const X86OpEntry opcodes_root[256] = {
     [0x5D] = X86_OP_ENTRYw(POP, LoBits,d64),
     [0x5E] = X86_OP_ENTRYw(POP, LoBits,d64),
     [0x5F] = X86_OP_ENTRYw(POP, LoBits,d64),
+
+    [0x68] = X86_OP_ENTRYr(PUSH, I,z),
+    [0x69] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,z, sextT0),
+    [0x6A] = X86_OP_ENTRYr(PUSH, I,b),
+    [0x6B] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,b, sextT0),
+    [0x6C] = X86_OP_ENTRYrr(INS, Y,b, 2,w), /* DX */
+    [0x6D] = X86_OP_ENTRYrr(INS, Y,z, 2,w), /* DX */
+    [0x6E] = X86_OP_ENTRYrr(OUTS, X,b, 2,w), /* DX */
+    [0x6F] = X86_OP_ENTRYrr(OUTS, X,z, 2,w), /* DX */
+
+    [0x78] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x79] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x7A] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x7B] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x7C] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x7D] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x7E] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x7F] = X86_OP_ENTRYr(Jcc, J,b),
+
+    [0x88] = X86_OP_ENTRY3(MOV, E,b, G,b, None, None),
+    [0x89] = X86_OP_ENTRY3(MOV, E,v, G,v, None, None),
+    [0x8A] = X86_OP_ENTRY3(MOV, G,b, E,b, None, None),
+    [0x8B] = X86_OP_ENTRY3(MOV, G,v, E,v, None, None),
+    [0x8C] = X86_OP_ENTRY3(MOV, E,v, S,w, None, None),
+    [0x8D] = X86_OP_ENTRY3(LEA, G,v, M,v, None, None, noseg),
+    [0x8E] = X86_OP_ENTRY3(MOV, S,w, E,v, None, None),
+    [0x8F] = X86_OP_GROUPw(group1A, E,v),
+
+    [0x98] = X86_OP_ENTRY1(CBW,    0,v), /* rAX */
+    [0x99] = X86_OP_ENTRY3(CWD,    2,v, 0,v, None, None), /* rDX, rAX */
+    [0x9A] = X86_OP_ENTRYrr(CALLF, I_unsigned,p, I_unsigned,w, chk(i64)),
+    [0x9B] = X86_OP_ENTRY0(WAIT),
+    [0x9C] = X86_OP_ENTRY0(PUSHF,  chk(vm86_iopl) svm(PUSHF)),
+    [0x9D] = X86_OP_ENTRY0(POPF,   chk(vm86_iopl) svm(POPF)),
+    [0x9E] = X86_OP_ENTRY0(SAHF),
+    [0x9F] = X86_OP_ENTRY0(LAHF),
+
+    [0xA8] = X86_OP_ENTRYrr(AND, 0,b, I,b),   /* AL, Ib */
+    [0xA9] = X86_OP_ENTRYrr(AND, 0,v, I,z),   /* rAX, Iz */
+    [0xAA] = X86_OP_ENTRY3(STOS, Y,b, 0,b, None, None),
+    [0xAB] = X86_OP_ENTRY3(STOS, Y,v, 0,v, None, None),
+    /* Manual writeback because REP LODS (!) has to write EAX/RAX after every LODS.  */
+    [0xAC] = X86_OP_ENTRYr(LODS, X,b),
+    [0xAD] = X86_OP_ENTRYr(LODS, X,v),
+    [0xAE] = X86_OP_ENTRYrr(SCAS, 0,b, Y,b),
+    [0xAF] = X86_OP_ENTRYrr(SCAS, 0,v, Y,v),
+
+    [0xB8] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xB9] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xBA] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xBB] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xBC] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xBD] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xBE] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xBF] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
 };
 
 #undef mmx
@@ -1476,6 +1651,11 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         decode->immediate = op->imm = insn_get_signed(env, s, op->ot);
         break;
 
+    case X86_TYPE_I_unsigned:  /* Immediate */
+        op->unit = X86_OP_IMM;
+        decode->immediate = op->imm = insn_get(env, s, op->ot);
+        break;
+
     case X86_TYPE_L:  /* The upper 4 bits of the immediate select a 128-bit register */
         op->n = insn_get(env, s, op->ot) >> 4;
         break;
@@ -2037,6 +2217,11 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         assert(decode.op[1].unit == X86_OP_INT);
         break;
 
+    case X86_SPECIAL_NoSeg:
+        decode.mem.def_seg = -1;
+        s->override = -1;
+        break;
+
     default:
         break;
     }
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index fc065caae79..c59793f170a 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1179,6 +1179,27 @@ static void gen_ANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
+static void gen_ARPL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    TCGv zf = tcg_temp_new();
+    TCGv flags = tcg_temp_new();
+
+    gen_mov_eflags(s, flags);
+
+    /* Compute adjusted DST in T1, merging in SRC[RPL].  */
+    tcg_gen_deposit_tl(s->T1, s->T0, s->T1, 0, 2);
+
+    /* Z flag set if DST[RPL] < SRC[RPL] */
+    tcg_gen_setcond_tl(TCG_COND_LTU, zf, s->T0, s->T1);
+    tcg_gen_deposit_tl(flags, flags, zf, ctz32(CC_Z), 1);
+
+    /* Place maximum RPL in DST */
+    tcg_gen_umax_tl(s->T0, s->T0, s->T1);
+
+    decode->cc_src = flags;
+    decode->cc_op = CC_OP_EFLAGS;
+}
+
 static void gen_BEXTR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1243,6 +1264,17 @@ static void gen_BLSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     set_cc_op(s, CC_OP_BMILGB + ot);
 }
 
+static void gen_BOUND(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    TCGv_i32 op = tcg_temp_new_i32();
+    tcg_gen_trunc_tl_i32(op, s->T0);
+    if (decode->op[1].ot == MO_16) {
+        gen_helper_boundw(tcg_env, s->A0, op);
+    } else {
+        gen_helper_boundl(tcg_env, s->A0, op);
+    }
+}
+
 static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1263,6 +1295,18 @@ static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update2_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
+static void gen_CALLF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_far_call(s);
+}
+
+static void gen_CBW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp src_ot = decode->op[0].ot - 1;
+
+    tcg_gen_ext_tl(s->T0, s->T0, src_ot | MO_SIGN);
+}
+
 static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGLabel *label_top = gen_new_label();
@@ -1366,6 +1410,18 @@ static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     decode->cc_op = CC_OP_SUBB + ot;
 }
 
+static void gen_CMPS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[2].ot;
+    if (s->prefix & PREFIX_REPNZ) {
+        gen_repz_cmps(s, ot, 1);
+    } else if (s->prefix & PREFIX_REPZ) {
+        gen_repz_cmps(s, ot, 0);
+    } else {
+        gen_cmps(s, ot);
+    }
+}
+
 static void gen_CRC32(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
@@ -1404,6 +1460,13 @@ static void gen_CVTTPx2PI(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
+static void gen_CWD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    int shift = 8 << decode->op[0].ot;
+
+    tcg_gen_sextract_tl(s->T0, s->T0, shift - 1, 1);
+}
+
 static void gen_DAA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
@@ -1450,6 +1513,69 @@ static void gen_EXTRQ_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     gen_helper_extrq_r(tcg_env, OP_PTR0, OP_PTR2);
 }
 
+static void gen_IMUL3(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    TCGv cc_src_rhs;
+
+    switch (ot) {
+    case MO_16:
+        /* s->T0 already sign-extended */
+        tcg_gen_ext16s_tl(s->T1, s->T1);
+        tcg_gen_mul_tl(s->T0, s->T0, s->T1);
+        /* Compare the full result to the extension of the truncated result.  */
+        tcg_gen_ext16s_tl(s->T1, s->T0);
+        cc_src_rhs = s->T0;
+        break;
+
+    case MO_32:
+#ifdef TARGET_X86_64
+        if (TCG_TARGET_REG_BITS == 64) {
+            /*
+             * This produces fewer TCG ops, and better code if flags are needed,
+             * but it requires a 64-bit multiply even if they are not.  Use it
+             * only if the target has 64-bits registers.
+             *
+             * s->T0 is already sign-extended.
+             */
+            tcg_gen_ext32s_tl(s->T1, s->T1);
+            tcg_gen_mul_tl(s->T0, s->T0, s->T1);
+            /* Compare the full result to the extension of the truncated result.  */
+            tcg_gen_ext32s_tl(s->T1, s->T0);
+            cc_src_rhs = s->T0;
+        } else {
+            /* Variant that only needs a 32-bit widening multiply.  */
+            TCGv_i32 hi = tcg_temp_new_i32();
+            TCGv_i32 lo = tcg_temp_new_i32();
+            tcg_gen_trunc_tl_i32(lo, s->T0);
+            tcg_gen_trunc_tl_i32(hi, s->T1);
+            tcg_gen_muls2_i32(lo, hi, lo, hi);
+            tcg_gen_extu_i32_tl(s->T0, lo);
+
+            cc_src_rhs = tcg_temp_new();
+            tcg_gen_extu_i32_tl(cc_src_rhs, hi);
+            /* Compare the high part to the sign bit of the truncated result */
+            tcg_gen_sari_i32(lo, lo, 31);
+            tcg_gen_extu_i32_tl(s->T1, lo);
+        }
+        break;
+
+    case MO_64:
+#endif
+        cc_src_rhs = tcg_temp_new();
+        tcg_gen_muls2_tl(s->T0, cc_src_rhs, s->T0, s->T1);
+        /* Compare the high part to the sign bit of the truncated result */
+        tcg_gen_sari_tl(s->T1, s->T0, TARGET_LONG_BITS - 1);
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
 static void gen_INC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
@@ -1464,6 +1590,26 @@ static void gen_INC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update_cc_incdec(decode, s, CC_OP_INCB + ot);
 }
 
+static void gen_INS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+    TCGv_i32 port = tcg_temp_new_i32();
+
+    tcg_gen_trunc_tl_i32(port, s->T1);
+    tcg_gen_ext16u_i32(port, port);
+    if (!gen_check_io(s, ot, port,
+                      SVM_IOIO_TYPE_MASK | SVM_IOIO_STR_MASK)) {
+        return;
+    }
+
+    translator_io_start(&s->base);
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        gen_repz_ins(s, ot);
+    } else {
+        gen_ins(s, ot);
+    }
+}
+
 static void gen_INSERTQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 length = tcg_constant_i32(decode->immediate & 63);
@@ -1477,12 +1623,50 @@ static void gen_INSERTQ_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     gen_helper_insertq_r(tcg_env, OP_PTR0, OP_PTR2);
 }
 
+static void gen_Jcc(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_bnd_jmp(s);
+    gen_jcc(s, decode->b & 0xf, decode->immediate);
+}
+
+static void gen_LAHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM)) {
+        return gen_illegal_opcode(s);
+    }
+    gen_compute_eflags(s);
+    /* Note: gen_compute_eflags() only gives the condition codes */
+    tcg_gen_ori_tl(s->T0, cpu_cc_src, 0x02);
+    tcg_gen_deposit_tl(cpu_regs[R_EAX], cpu_regs[R_EAX], s->T0, 8, 8);
+}
+
 static void gen_LDMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T1);
     gen_helper_ldmxcsr(tcg_env, s->tmp2_i32);
 }
 
+static void gen_LEA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    tcg_gen_mov_tl(s->T0, s->A0);
+}
+
+static void gen_LODS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[2].ot;
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        gen_repz_lods(s, ot);
+    } else {
+        gen_lods(s, ot);
+    }
+}
+
+static void gen_MOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    /* nothing to do! */
+}
+#define gen_NOP gen_MOV
+
 static void gen_MASKMOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_lea_v_seg(s, s->aflag, cpu_regs[R_EDI], R_DS, s->override);
@@ -1590,6 +1774,16 @@ static void gen_MOVq_dq(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     return gen_MOVQ(s, env, decode);
 }
 
+static void gen_MOVS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[2].ot;
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        gen_repz_movs(s, ot);
+    } else {
+        gen_movs(s, ot);
+    }
+}
+
 static void gen_MULX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1629,6 +1823,25 @@ static void gen_OR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
+static void gen_OUTS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+    TCGv_i32 port = tcg_temp_new_i32();
+
+    tcg_gen_trunc_tl_i32(port, s->T1);
+    tcg_gen_ext16u_i32(port, port);
+    if (!gen_check_io(s, ot, port, SVM_IOIO_STR_MASK)) {
+        return;
+    }
+
+    translator_io_start(&s->base);
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        gen_repz_outs(s, ot);
+    } else {
+        gen_outs(s, ot);
+    }
+}
+
 static void gen_PALIGNR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -1884,6 +2097,33 @@ static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_pop_update(s, ot);
 }
 
+static void gen_POPA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+   gen_popa(s);
+}
+
+static void gen_POPF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot;
+    int mask = TF_MASK | AC_MASK | ID_MASK | NT_MASK;
+
+    if (CPL(s) == 0) {
+        mask |= IF_MASK | IOPL_MASK;
+    } else if (CPL(s) <= IOPL(s)) {
+        mask |= IF_MASK;
+    }
+    if (s->dflag == MO_16) {
+        mask &= 0xffff;
+    }
+
+    ot = gen_pop_T0(s);
+    gen_helper_write_eflags(tcg_env, s->T0, tcg_constant_i32(mask));
+    gen_pop_update(s, ot);
+    set_cc_op(s, CC_OP_EFLAGS);
+    /* abort translation because TF/AC flag may change */
+    s->base.is_jmp = DISAS_EOB_NEXT;
+}
+
 static void gen_PSHUFW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -2035,6 +2275,18 @@ static void gen_PUSH(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_push_v(s, s->T1);
 }
 
+static void gen_PUSHA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+   gen_pusha(s);
+}
+
+static void gen_PUSHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_helper_read_eflags(s->T0, tcg_env);
+    gen_push_v(s, s->T0);
+}
+
 static void gen_RORX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -2059,6 +2311,18 @@ static void gen_RORX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
+static void gen_SAHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM)) {
+        return gen_illegal_opcode(s);
+    }
+    tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
+    gen_compute_eflags(s);
+    tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
+    tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
+    tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
+}
+
 static void gen_SARX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -2091,6 +2355,18 @@ static void gen_SBB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update3_cc(decode, s, CC_OP_SBBB + ot, c_in);
 }
 
+static void gen_SCAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[2].ot;
+    if (s->prefix & PREFIX_REPNZ) {
+        gen_repz_scas(s, ot, 1);
+    } else if (s->prefix & PREFIX_REPZ) {
+        gen_repz_scas(s, ot, 0);
+    } else {
+        gen_scas(s, ot);
+    }
+}
+
 static void gen_SHA1NEXTE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_helper_sha1nexte(OP_PTR0, OP_PTR1, OP_PTR2);
@@ -2178,6 +2454,16 @@ static void gen_STMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     tcg_gen_ld32u_tl(s->T0, tcg_env, offsetof(CPUX86State, mxcsr));
 }
 
+static void gen_STOS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        gen_repz_stos(s, ot);
+    } else {
+        gen_stos(s, ot);
+    }
+}
+
 static void gen_SUB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
@@ -2674,6 +2960,43 @@ static void gen_VZEROUPPER(DisasContext *s, CPUX86State *env, X86DecodedInsn *de
     }
 }
 
+static void gen_WAIT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    if ((s->flags & (HF_MP_MASK | HF_TS_MASK)) == (HF_MP_MASK | HF_TS_MASK)) {
+        gen_NM_exception(s);
+    } else {
+        /* needs to be treated as I/O because of ferr_irq */
+        translator_io_start(&s->base);
+        gen_helper_fwait(tcg_env);
+    }
+}
+
+static void gen_XCHG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    if (decode->b == 0x90 && !REX_B(s)) {
+        if (s->prefix & PREFIX_REPZ) {
+            gen_update_cc_op(s);
+            gen_update_eip_cur(s);
+            gen_helper_pause(tcg_env, cur_insn_len_i32(s));
+            s->base.is_jmp = DISAS_NORETURN;
+        }
+        /* No writeback.  */
+        decode->op[0].unit = X86_OP_SKIP;
+        return;
+    }
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_xchg_tl(s->T0, s->A0, s->T1,
+                               s->mem_index, decode->op[0].ot | MO_LE);
+        /* now store old value into register operand */
+        gen_op_mov_reg_v(s, decode->op[2].ot, decode->op[2].n, s->T0);
+    } else {
+        /* move destination value into source operand, source preserved in T1 */
+        gen_op_mov_reg_v(s, decode->op[2].ot, decode->op[2].n, s->T0);
+        tcg_gen_mov_tl(s->T0, s->T1);
+    }
+}
+
 static void gen_XOR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     /* special case XOR reg, reg */
-- 
2.45.0


