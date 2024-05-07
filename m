Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D87C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IVH-0006Hc-80; Tue, 07 May 2024 06:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IVF-00063Q-CU
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IVC-0002xO-Pp
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=358P66aOlpoVnS69gibS2se9+MM+5cCNu9D+CIVCWr8=;
 b=hHDZoY5TLnicWi/sb2iRrw4UIDGLG1LtRY5NQQau4lIIvOV5RJiFtHulAjTY7oCYtMr7lH
 PlsQ7JMTagCWJmsZ/rv7O+P3JtfHZNomI6ciSC8d0qsoaFHE+EvFLM0ZKRmY0VIXOZyX8K
 OGgn2gnSyCH0OjLYLQwDAhjRJlHZ8M0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-uo7pt7LqN4-ZWpfac0mkyQ-1; Tue, 07 May 2024 06:56:52 -0400
X-MC-Unique: uo7pt7LqN4-ZWpfac0mkyQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a524b774e39so292944666b.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079411; x=1715684211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=358P66aOlpoVnS69gibS2se9+MM+5cCNu9D+CIVCWr8=;
 b=AVA0Rv9psKGeStKeHMnWKhd/2SXLAkn9wHeG5m0l7haudH1t/GoUpqUPxZnYxT3nsQ
 SU1KQPW7vRmLRchjBRmRXFpCCQaTvrN20qfk4qCPBntU3gs6Cjbett+5bjMI7Er7x1U4
 GpCC4aIy/mvU6k2aBrEvfuLTjg5/Ba4rb0u3P/NfbFXKkzVNrP0Y9o5RIerq5bFksbKl
 w6ddE29C/XyT8T6OgGQzFOx+x6MRxC7RQRZQSIK3cidgWAfVcTdfKa1iVsHLjXH/t59J
 valEPz42ML/uIcMj+jIHdZVp/EJH4EhvK5GIlb6qmhHf8RLIk3kbwHrmznA1SHyuScFV
 XYSA==
X-Gm-Message-State: AOJu0YyP9daG2RNEQbxLldf680tjoX1u4BznLnCUmBHoK9vaZm1g/Sc3
 1UUMycPmvKw5wj6eKPS6T8Oz70zDK2cdn6ELxxxVJHIZl81d6dC/uPE0hbeangynZagbIzM6kjm
 FWuC2Lbju+8pL4T3J3xU5XrnXHpGdIQN6VVHRvcPRmvqQTDbtPZ3IdFi9oLc0haku6+Er+U8nAO
 4qId2puSAGJxVQsiUlzfq3n43iTan3s4eeqKzv
X-Received: by 2002:a17:906:1394:b0:a59:c3a7:59d3 with SMTP id
 f20-20020a170906139400b00a59c3a759d3mr1731062ejc.13.1715079410551; 
 Tue, 07 May 2024 03:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqUXN3viHC2uLR0MIRM9huooS26xnf6+xGWiCVBB5exYKvgELaAIIu5k+NXpDgtkgYR7WK6A==
X-Received: by 2002:a17:906:1394:b0:a59:c3a7:59d3 with SMTP id
 f20-20020a170906139400b00a59c3a759d3mr1731042ejc.13.1715079410000; 
 Tue, 07 May 2024 03:56:50 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a17090616cb00b00a59a902de61sm4085927ejd.171.2024.05.07.03.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 26/26] target/i386: remove duplicate prefix decoding
Date: Tue,  7 May 2024 12:55:38 +0200
Message-ID: <20240507105538.180704-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
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

Now that a bulk of opcodes go through the new decoder, it is sensible
to do some cleanup.  Go immediately through disas_insn_new and only jump
back after parsing the prefixes.

disas_insn() now only contains the three sigsetjmp cases, and they
are more easily managed if they are inlined into i386_tr_translate_insn.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      | 259 +++++++------------------------
 target/i386/tcg/decode-new.c.inc |  63 ++++++--
 2 files changed, 103 insertions(+), 219 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index eb0e37e1480..3842b294842 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2451,10 +2451,6 @@ static void gen_sty_env_A0(DisasContext *s, int offset, bool align)
     tcg_gen_qemu_st_i128(t, s->tmp0, mem_index, mop);
 }
 
-#include "decode-new.h"
-#include "emit.c.inc"
-#include "decode-new.c.inc"
-
 static void gen_cmpxchg8b(DisasContext *s, CPUX86State *env, int modrm)
 {
     TCGv_i64 cmp, val, old;
@@ -3117,183 +3113,6 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
     return true;
 }
 
-static void disas_insn_old(DisasContext *s, CPUState *cpu, int b);
-
-/* convert one instruction. s->base.is_jmp is set if the translation must
-   be stopped. Return the next pc value */
-static bool disas_insn(DisasContext *s, CPUState *cpu)
-{
-    CPUX86State *env = cpu_env(cpu);
-    int b, prefixes;
-    MemOp aflag, dflag;
-    bool orig_cc_op_dirty = s->cc_op_dirty;
-    CCOp orig_cc_op = s->cc_op;
-    target_ulong orig_pc_save = s->pc_save;
-
-    s->pc = s->base.pc_next;
-    s->override = -1;
-    s->popl_esp_hack = 0;
-#ifdef TARGET_X86_64
-    s->rex_r = 0;
-    s->rex_x = 0;
-    s->rex_b = 0;
-#endif
-    s->rip_offset = 0; /* for relative ip address */
-    s->vex_l = 0;
-    s->vex_v = 0;
-    s->vex_w = false;
-    switch (sigsetjmp(s->jmpbuf, 0)) {
-    case 0:
-        break;
-    case 1:
-        gen_exception_gpf(s);
-        return true;
-    case 2:
-        /* Restore state that may affect the next instruction. */
-        s->pc = s->base.pc_next;
-        /*
-         * TODO: These save/restore can be removed after the table-based
-         * decoder is complete; we will be decoding the insn completely
-         * before any code generation that might affect these variables.
-         */
-        s->cc_op_dirty = orig_cc_op_dirty;
-        s->cc_op = orig_cc_op;
-        s->pc_save = orig_pc_save;
-        /* END TODO */
-        s->base.num_insns--;
-        tcg_remove_ops_after(s->prev_insn_end);
-        s->base.insn_start = s->prev_insn_start;
-        s->base.is_jmp = DISAS_TOO_MANY;
-        return false;
-    default:
-        g_assert_not_reached();
-    }
-
-    prefixes = 0;
-
- next_byte:
-    s->prefix = prefixes;
-    b = x86_ldub_code(env, s);
-    /* Collect prefixes.  */
-    switch (b) {
-    case 0x0f:
-        b = x86_ldub_code(env, s) + 0x100;
-        break;
-    case 0xf3:
-        prefixes |= PREFIX_REPZ;
-        prefixes &= ~PREFIX_REPNZ;
-        goto next_byte;
-    case 0xf2:
-        prefixes |= PREFIX_REPNZ;
-        prefixes &= ~PREFIX_REPZ;
-        goto next_byte;
-    case 0xf0:
-        prefixes |= PREFIX_LOCK;
-        goto next_byte;
-    case 0x2e:
-        s->override = R_CS;
-        goto next_byte;
-    case 0x36:
-        s->override = R_SS;
-        goto next_byte;
-    case 0x3e:
-        s->override = R_DS;
-        goto next_byte;
-    case 0x26:
-        s->override = R_ES;
-        goto next_byte;
-    case 0x64:
-        s->override = R_FS;
-        goto next_byte;
-    case 0x65:
-        s->override = R_GS;
-        goto next_byte;
-    case 0x66:
-        prefixes |= PREFIX_DATA;
-        goto next_byte;
-    case 0x67:
-        prefixes |= PREFIX_ADR;
-        goto next_byte;
-#ifdef TARGET_X86_64
-    case 0x40 ... 0x4f:
-        if (CODE64(s)) {
-            /* REX prefix */
-            prefixes |= PREFIX_REX;
-            s->vex_w = (b >> 3) & 1;
-            s->rex_r = (b & 0x4) << 1;
-            s->rex_x = (b & 0x2) << 2;
-            s->rex_b = (b & 0x1) << 3;
-            goto next_byte;
-        }
-        break;
-#endif
-    case 0xc5: /* 2-byte VEX */
-    case 0xc4: /* 3-byte VEX */
-        if (CODE32(s) && !VM86(s)) {
-            int vex2 = x86_ldub_code(env, s);
-            s->pc--; /* rewind the advance_pc() x86_ldub_code() did */
-
-            if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
-                /* 4.1.4.6: In 32-bit mode, bits [7:6] must be 11b,
-                   otherwise the instruction is LES or LDS.  */
-                break;
-            }
-            disas_insn_new(s, cpu, b);
-            return s->pc;
-        }
-        break;
-    }
-
-    /* Post-process prefixes.  */
-    if (CODE64(s)) {
-        /* In 64-bit mode, the default data size is 32-bit.  Select 64-bit
-           data with rex_w, and 16-bit data with 0x66; rex_w takes precedence
-           over 0x66 if both are present.  */
-        dflag = (REX_W(s) ? MO_64 : prefixes & PREFIX_DATA ? MO_16 : MO_32);
-        /* In 64-bit mode, 0x67 selects 32-bit addressing.  */
-        aflag = (prefixes & PREFIX_ADR ? MO_32 : MO_64);
-    } else {
-        /* In 16/32-bit mode, 0x66 selects the opposite data size.  */
-        if (CODE32(s) ^ ((prefixes & PREFIX_DATA) != 0)) {
-            dflag = MO_32;
-        } else {
-            dflag = MO_16;
-        }
-        /* In 16/32-bit mode, 0x67 selects the opposite addressing.  */
-        if (CODE32(s) ^ ((prefixes & PREFIX_ADR) != 0)) {
-            aflag = MO_32;
-        }  else {
-            aflag = MO_16;
-        }
-    }
-
-    s->prefix = prefixes;
-    s->aflag = aflag;
-    s->dflag = dflag;
-
-    switch (b) {
-    case 0     ... 0xd7:
-    case 0xe0  ... 0xff:
-    case 0x10e ... 0x117:
-    case 0x128 ... 0x12f:
-    case 0x138 ... 0x19f:
-    case 0x1a0 ... 0x1a1:
-    case 0x1a8 ... 0x1a9:
-    case 0x1af:
-    case 0x1b2:
-    case 0x1b4 ... 0x1b7:
-    case 0x1be ... 0x1bf:
-    case 0x1c2 ... 0x1c6:
-    case 0x1c8 ... 0x1ff:
-        disas_insn_new(s, cpu, b);
-        break;
-    default:
-        disas_insn_old(s, cpu, b);
-        break;
-    }
-    return true;
-}
-
 static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
 {
     CPUX86State *env = cpu_env(cpu);
@@ -3502,14 +3321,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         }
         break;
 
-        /************************/
-        /* floats */
-    case 0xd8 ... 0xdf:
-        if (!disas_insn_x87(s, cpu, b)) {
-            goto unknown_op;
-        }
-        break;
-
         /************************/
         /* bit operations */
     case 0x1ba: /* bt/bts/btr/btc Gv, im */
@@ -4759,7 +4570,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         set_cc_op(s, CC_OP_POPCNT);
         break;
     default:
-        goto unknown_op;
+        g_assert_not_reached();
     }
     return;
  illegal_op:
@@ -4769,6 +4580,10 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
     gen_unknown_opcode(env, s);
 }
 
+#include "decode-new.h"
+#include "emit.c.inc"
+#include "decode-new.c.inc"
+
 void tcg_x86_init(void)
 {
     static const char reg_names[CPU_NB_REGS][4] = {
@@ -4890,7 +4705,6 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 
     dc->cc_op = CC_OP_DYNAMIC;
     dc->cc_op_dirty = false;
-    dc->popl_esp_hack = 0;
     /* select memory access functions */
     dc->mem_index = cpu_mmu_index(cpu, false);
     dc->cpuid_features = env->features[FEAT_1_EDX];
@@ -4942,6 +4756,9 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
+    bool orig_cc_op_dirty = dc->cc_op_dirty;
+    CCOp orig_cc_op = dc->cc_op;
+    target_ulong orig_pc_save = dc->pc_save;
 
 #ifdef TARGET_VSYSCALL_PAGE
     /*
@@ -4954,23 +4771,51 @@ static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 #endif
 
-    if (disas_insn(dc, cpu)) {
-        target_ulong pc_next = dc->pc;
-        dc->base.pc_next = pc_next;
+    switch (sigsetjmp(dc->jmpbuf, 0)) {
+    case 0:
+        disas_insn(dc, cpu);
+        break;
+    case 1:
+        gen_exception_gpf(dc);
+        break;
+    case 2:
+        /* Restore state that may affect the next instruction. */
+        dc->pc = dc->base.pc_next;
+        /*
+         * TODO: These save/restore can be removed after the table-based
+         * decoder is complete; we will be decoding the insn completely
+         * before any code generation that might affect these variables.
+         */
+        dc->cc_op_dirty = orig_cc_op_dirty;
+        dc->cc_op = orig_cc_op;
+        dc->pc_save = orig_pc_save;
+        /* END TODO */
+        dc->base.num_insns--;
+        tcg_remove_ops_after(dc->prev_insn_end);
+        dc->base.insn_start = dc->prev_insn_start;
+        dc->base.is_jmp = DISAS_TOO_MANY;
+        return;
+    default:
+        g_assert_not_reached();
+    }
 
-        if (dc->base.is_jmp == DISAS_NEXT) {
-            if (dc->flags & (HF_TF_MASK | HF_INHIBIT_IRQ_MASK)) {
-                /*
-                 * If single step mode, we generate only one instruction and
-                 * generate an exception.
-                 * If irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
-                 * the flag and abort the translation to give the irqs a
-                 * chance to happen.
-                 */
-                dc->base.is_jmp = DISAS_EOB_NEXT;
-            } else if (!is_same_page(&dc->base, pc_next)) {
-                dc->base.is_jmp = DISAS_TOO_MANY;
-            }
+    /*
+     * Instruction decoding completed (possibly with #GP if the
+     * 15-byte boundary was exceeded).
+     */
+    dc->base.pc_next = dc->pc;
+    if (dc->base.is_jmp == DISAS_NEXT) {
+        if (dc->flags & (HF_TF_MASK | HF_INHIBIT_IRQ_MASK)) {
+            /*
+             * If single step mode, we generate only one instruction and
+             * generate an exception.
+             * If irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
+             * the flag and abort the translation to give the irqs a
+             * chance to happen.
+             */
+            dc->base.is_jmp = DISAS_EOB_NEXT;
+        } else if (!is_same_page(&dc->base, dc->base.pc_next)) {
+            dc->base.is_jmp = DISAS_TOO_MANY;
         }
     }
 }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index dabc987b998..0e1811399f8 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2219,22 +2219,31 @@ illegal:
  * Convert one instruction. s->base.is_jmp is set if the translation must
  * be stopped.
  */
-static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
+static void disas_insn(DisasContext *s, CPUState *cpu)
 {
     CPUX86State *env = cpu_env(cpu);
-    bool first = true;
     X86DecodedInsn decode;
     X86DecodeFunc decode_func = decode_root;
-    uint8_t cc_live;
+    uint8_t cc_live, b;
 
+    s->pc = s->base.pc_next;
+    s->override = -1;
+    s->popl_esp_hack = 0;
+#ifdef TARGET_X86_64
+    s->rex_r = 0;
+    s->rex_x = 0;
+    s->rex_b = 0;
+#endif
+    s->rip_offset = 0; /* for relative ip address */
+    s->vex_l = 0;
+    s->vex_v = 0;
+    s->vex_w = false;
     s->has_modrm = false;
+    s->prefix = 0;
 
  next_byte:
-    if (first) {
-        first = false;
-    } else {
-        b = x86_ldub_code(env, s);
-    }
+    b = x86_ldub_code(env, s);
+
     /* Collect prefixes.  */
     switch (b) {
     case 0xf3:
@@ -2346,10 +2355,6 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         }
         break;
     default:
-        if (b >= 0x100) {
-            b -= 0x100;
-            decode_func = do_decode_0F;
-        }
         break;
     }
 
@@ -2378,6 +2383,40 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         }
     }
 
+    /* Go back to old decoder for unconverted opcodes.  */
+    if (!(s->prefix & PREFIX_VEX)) {
+        if ((b & ~7) == 0xd8) {
+            if (!disas_insn_x87(s, cpu, b)) {
+                goto unknown_op;
+            }
+            return;
+        }
+
+        if (b == 0x0f) {
+            b = x86_ldub_code(env, s);
+            switch (b) {
+            case 0x00 ... 0x03: /* mostly privileged instructions */
+            case 0x05 ... 0x09:
+            case 0x0d:          /* 3DNow! prefetch */
+            case 0x18 ... 0x23: /* prefetch, MPX, mov from/to CR and DR */
+            case 0x30 ... 0x35: /* more privileged instructions */
+            case 0xa2 ... 0xa5: /* CPUID, BT, SHLD */
+            case 0xaa ... 0xae: /* RSM, SHRD, grp15 */
+            case 0xb0 ... 0xb1: /* cmpxchg */
+            case 0xb3:          /* btr */
+            case 0xb8:          /* integer ops */
+            case 0xba ... 0xbd: /* integer ops */
+            case 0xc0 ... 0xc1: /* xadd */
+            case 0xc7:          /* grp9 */
+                disas_insn_old(s, cpu, b + 0x100);
+                return;
+            default:
+                decode_func = do_decode_0F;
+                break;
+            }
+        }
+    }
+
     memset(&decode, 0, sizeof(decode));
     decode.cc_op = -1;
     decode.b = b;
-- 
2.45.0


