Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DBCC25B77
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66mN-0003AU-K6; Sun, 12 May 2024 06:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mM-00039o-E2
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mK-0005jg-EM
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdRXHsu0FF7fOctnYehBfR47nJOAuljyxAb/XJ3j/HU=;
 b=h8or4EG3ROMtpNk+59x+YauaAPV4ktiKmiDTPN35ia36VPzwdqofYM0RVVZvusqQ4Mv6y7
 7kc1ZFlX0VG+Nhk9gUUItqIh8E2aWxkPyT3ogZIBDC1zekGo63qtRabEfLwFKIT27HnlUl
 xPYvUtA0A+vnxUXk4Evs6lbkkXQJL9Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-cenwCdebOLC12qR1E0uMPA-1; Sun, 12 May 2024 06:50:01 -0400
X-MC-Unique: cenwCdebOLC12qR1E0uMPA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-574b5ae605dso312102a12.3
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715510999; x=1716115799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdRXHsu0FF7fOctnYehBfR47nJOAuljyxAb/XJ3j/HU=;
 b=h2bI/08r2Lmr8pTvNvMP0iFfuKLb75SR7nVBIw3RIzEQwjk3qHXx8ODEIsDXaqMkl3
 q4FXxxBs0WgrVQxGF2yzSsd+sjYBlkaUGfTvyH7lMQzFoRBvcMCo5XP4PP2QuA9otRM2
 eyz1DrFd+ltSmmzV0BIxHsNWJOmCbnZgzPnrJocstH+JQgPuiMu1MzVSX3wEhhcmZGS3
 5lBhsnBFxfNxYeX7LpVanet6CVVL/HYCi8Kgn5aqxSW5GxagO1lBlh9TJLKkKWkBfP7B
 XGxEMn7Sv/4Y2kf1OwPGfdvVijwla9dbQdZ+m/MyPCIAors7Dx07MMt+dPmGWMlcyn9D
 lKrQ==
X-Gm-Message-State: AOJu0Yy4ifozijxbwlyn8wBbeCngh/2dlDYdz7MXejx/HqlX4XwAcGjd
 OLqPrAxuUESO4PuLrQRyyGOXBDVfFVxF6a4VyHPihlpKxfkrgKOzmPYMP9qHpA7qc2vYImJ2xKD
 LH4vANDGn8BpvHA29jKUMIlEvJ74MHZfakH4cOGhvadmXV8PvCm/Tkixfcq48a1dzAPeXWpcHZO
 wAtoBCECa/wP1bnUGX+FFN9wbF+KY5LP0M9i0R
X-Received: by 2002:a50:cddc:0:b0:572:67ee:d3d9 with SMTP id
 4fb4d7f45d1cf-5734d5ce8e7mr4684154a12.17.1715510999323; 
 Sun, 12 May 2024 03:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe2WFQmTHzjjdiVTY9LcU4Ok9ocsLJhLClhTZ56T2bxE7M7KkE6mShXTd+7W/BtbfQOmRrUg==
X-Received: by 2002:a50:cddc:0:b0:572:67ee:d3d9 with SMTP id
 4fb4d7f45d1cf-5734d5ce8e7mr4684143a12.17.1715510998959; 
 Sun, 12 May 2024 03:49:58 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bea65edsm4630802a12.7.2024.05.12.03.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:49:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/27] target/i386: move prefetch and multi-byte UD/NOP to new
 decoder
Date: Sun, 12 May 2024 12:49:22 +0200
Message-ID: <20240512104945.130198-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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

These are trivial to add, and moving them to the new decoder fixes some
corner cases: raising #UD instead of an instruction fetch page fault for
the undefined opcodes, and incorrectly rejecting 0F 18 prefetches with
register operands (which are treated as reserved NOPs).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  1 +
 target/i386/tcg/translate.c      | 30 ------------------------------
 target/i386/tcg/decode-new.c.inc | 24 +++++++++++++++++++++---
 target/i386/tcg/emit.c.inc       |  5 +++++
 4 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 2ea06b44787..51ef0e621b9 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -50,6 +50,7 @@ typedef enum X86OpType {
     X86_TYPE_EM, /* modrm byte selects an ALU memory operand */
     X86_TYPE_WM, /* modrm byte selects an XMM/YMM memory operand */
     X86_TYPE_I_unsigned, /* Immediate, zero-extended */
+    X86_TYPE_nop, /* modrm operand decoded but not loaded into s->T{0,1} */
     X86_TYPE_2op, /* 2-operand RMW instruction */
     X86_TYPE_LoBits, /* encoded in bits 0-2 of the operand + REX.B */
     X86_TYPE_0, /* Hard-coded GPRs (RAX..RDI) */
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3da4fdf64cc..de87775016b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4019,25 +4019,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             set_cc_op(s, CC_OP_EFLAGS);
         }
         break;
-    case 0x118:
-        modrm = x86_ldub_code(env, s);
-        mod = (modrm >> 6) & 3;
-        op = (modrm >> 3) & 7;
-        switch(op) {
-        case 0: /* prefetchnta */
-        case 1: /* prefetchnt0 */
-        case 2: /* prefetchnt0 */
-        case 3: /* prefetchnt0 */
-            if (mod == 3)
-                goto illegal_op;
-            gen_nop_modrm(env, s, modrm);
-            /* nothing more to do */
-            break;
-        default: /* nop (multi byte) */
-            gen_nop_modrm(env, s, modrm);
-            break;
-        }
-        break;
     case 0x11a:
         modrm = x86_ldub_code(env, s);
         if (s->flags & HF_MPX_EN_MASK) {
@@ -4229,10 +4210,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         }
         gen_nop_modrm(env, s, modrm);
         break;
-    case 0x119: case 0x11c ... 0x11f: /* nop (multi byte) */
-        modrm = x86_ldub_code(env, s);
-        gen_nop_modrm(env, s, modrm);
-        break;
 
     case 0x120: /* mov reg, crN */
     case 0x122: /* mov crN, reg */
@@ -4506,13 +4483,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         }
         break;
 
-    case 0x10d: /* 3DNow! prefetch(w) */
-        modrm = x86_ldub_code(env, s);
-        mod = (modrm >> 6) & 3;
-        if (mod == 3)
-            goto illegal_op;
-        gen_nop_modrm(env, s, modrm);
-        break;
     case 0x1aa: /* rsm */
         gen_svm_check_intercept(s, SVM_EXIT_RSM);
         if (!(s->flags & HF_SMM_MASK))
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0e1811399f8..141ab2bc560 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -55,6 +55,10 @@
  * mask could be applied (and the original sign-extended value would be
  * optimized away by TCG) in the emitter function.
  *
+ * Finally, a "nop" operand type is used for multi-byte NOPs.  It accepts
+ * any value of mod including 11b (unlike M) but it does not try to
+ * interpret the operand (like M).
+ *
  * Vector operands
  * ---------------
  *
@@ -1056,6 +1060,16 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xa0] = X86_OP_ENTRYr(PUSH, FS, w),
     [0xa1] = X86_OP_ENTRYw(POP, FS, w),
 
+    [0x0b] = X86_OP_ENTRY0(UD),           /* UD2 */
+    [0x0d] = X86_OP_ENTRY1(NOP,  M,v),    /* 3DNow! prefetch */
+
+    [0x18] = X86_OP_ENTRY1(NOP,  nop,v),  /* prefetch/reserved NOP */
+    [0x19] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
+    [0x1c] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
+    [0x1d] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
+    [0x1e] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
+    [0x1f] = X86_OP_ENTRY1(NOP,  nop,v),  /* NOP/reserved NOP */
+
     [0x28] = X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x, vex1 p_00_66), /* MOVAPS */
     [0x29] = X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex1 p_00_66), /* MOVAPS */
     [0x2A] = X86_OP_GROUP0(0F2A),
@@ -1135,6 +1149,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xb6] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, zextT0), /* MOVZX */
     [0xb7] = X86_OP_ENTRY3(MOV,    G,v, E,w, None, None, zextT0), /* MOVZX */
 
+    /* decoded as modrm, which is visible as a difference between page fault and #UD */
+    [0xb9] = X86_OP_ENTRYr(UD,     nop,v),                        /* UD1 */
     [0xbe] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, sextT0), /* MOVSX */
     [0xbf] = X86_OP_ENTRY3(MOV,    G,v, E,w, None, None, sextT0), /* MOVSX */
 
@@ -1206,7 +1222,7 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xfc] = X86_OP_ENTRY3(PADDB,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
     [0xfd] = X86_OP_ENTRY3(PADDW,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
     [0xfe] = X86_OP_ENTRY3(PADDD,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    /* 0xff = UD0 */
+    [0xff] = X86_OP_ENTRYr(UD,     nop,v),                        /* UD0 */
 };
 
 static void do_decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
@@ -1852,6 +1868,8 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         if ((modrm >> 6) == 3) {
             return false;
         }
+        /* fall through */
+    case X86_TYPE_nop:  /* modrm operand decoded but not fetched */
     get_modrm:
         decode_modrm(s, env, decode, op, type);
         break;
@@ -2397,8 +2415,8 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             switch (b) {
             case 0x00 ... 0x03: /* mostly privileged instructions */
             case 0x05 ... 0x09:
-            case 0x0d:          /* 3DNow! prefetch */
-            case 0x18 ... 0x23: /* prefetch, MPX, mov from/to CR and DR */
+            case 0x1a ... 0x1b: /* MPX */
+            case 0x20 ... 0x23: /* mov from/to CR and DR */
             case 0x30 ... 0x35: /* more privileged instructions */
             case 0xa2 ... 0xa5: /* CPUID, BT, SHLD */
             case 0xaa ... 0xae: /* RSM, SHRD, grp15 */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 58f255873ff..2dee33dd487 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3517,6 +3517,11 @@ static void gen_SUB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update2_cc(decode, s, CC_OP_SUBB + ot);
 }
 
+static void gen_UD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_illegal_opcode(s);
+}
+
 static void gen_VAESIMC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     assert(!s->vex_l);
-- 
2.45.0


