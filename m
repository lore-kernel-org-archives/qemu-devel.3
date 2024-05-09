Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF783C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 15:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s55qZ-0004GJ-2J; Thu, 09 May 2024 11:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s55qU-0004Fd-A7
 for qemu-devel@nongnu.org; Thu, 09 May 2024 11:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s55qQ-0001ci-Uj
 for qemu-devel@nongnu.org; Thu, 09 May 2024 11:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715269085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bxyi35+LlbyjVZaq5aTovqONZZ7WkQs0lO+7Pg+yDmk=;
 b=cf9G0GZJdJ2xbVDVCWVVTvXy0xTgs4dYHrn5ek2Lf+B9IXtt7F4cVtd3t7Xqwd1IX0P3wQ
 f72YOKmKt2zQvgG103VowJMvUNZNtB/tfFe9M4F/U9IGTRVj190OWocy02VmM6QtGp2Nc/
 6wWUYUmjpSaRx76WEWY3oP6wDfjjado=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-2YPiQ4h8NCuq1WL8VEPJsQ-1; Thu, 09 May 2024 11:37:59 -0400
X-MC-Unique: 2YPiQ4h8NCuq1WL8VEPJsQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51f60b1644cso1116523e87.1
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 08:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715269077; x=1715873877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxyi35+LlbyjVZaq5aTovqONZZ7WkQs0lO+7Pg+yDmk=;
 b=EMlhpGk76Z/jI5w0kfZCrvHHspMlzHsHV/U1sXATtW/XgoFG4Z2yzNKonB/ui9ArVW
 X6opGlTObNOMIHpNHlaslFHhUkF0wV7Npn64ahz0mIUrx+OtvHZy3bozadyJMwvxleJl
 8uXTdnFOjOSoydLnn+maDZe08IYdV4pxBjNhVLcSsOxODEvrkBLHqY+CUTovwFbgRdaB
 BTeEDPr+3HBtoyZZ1vBnCSCUraVEDrtlINl7ARnpDDmqfjy3gBxCtL8T4N0ONz3mLc64
 S5fwWAbHlDzIFr3M5Tmh0/pYn4mW41wT6n2fA50hKYpwydGDcYVgDPFWClIvv1RA+jEC
 gdww==
X-Gm-Message-State: AOJu0Yxrq8IyryAYUfYsTOpywErQNumisOjfL5Q8FwpuhuVAwarR0Srq
 fBgQZ+auUfaRndM8B5bUAo6Nf00QfmmpDNT0KPaaGWkuyAvVve+u1SCbujrb1xzLR+OvpLtBC+U
 ZCcmw9dH3qN5W2diTYtOS78hgyM2xpFwSAFa2Ot+HQMki+/sQKUZL4uvSAkueB/yxBs5slGUy8e
 todeE2xTn+J4xnqw0LYnNDulBKdLOMekYacTJm
X-Received: by 2002:ac2:5929:0:b0:51d:a1ab:98bc with SMTP id
 2adb3069b0e04-5217c3733cfmr5214488e87.2.1715269077399; 
 Thu, 09 May 2024 08:37:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjaFjXwyyBXSIIUVE2C1RMo4e0rlc4htEUN7Exu7TSwvC73aaLtospNSEmLbEt5B0FBpM1Xg==
X-Received: by 2002:ac2:5929:0:b0:51d:a1ab:98bc with SMTP id
 2adb3069b0e04-5217c3733cfmr5214465e87.2.1715269076609; 
 Thu, 09 May 2024 08:37:56 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bea6557sm816571a12.13.2024.05.09.08.37.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 08:37:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: move prefetch and multi-byte UD/NOP to new
 decoder
Date: Thu,  9 May 2024 17:37:55 +0200
Message-ID: <20240509153755.143456-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
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

These are trivial to add, and moving them to the new decoder fixes some
corner cases: raising #UD instead of an instruction fetch page fault for
the undefined opcodes, and incorrectly rejecting 0F 18 prefetches with
register operands (which are treated as reserved NOPs).

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
index 0e1811399f8..4baf7672158 100644
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
+    [0x1f] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
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


