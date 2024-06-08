Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2236CC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrek-0004YE-OU; Sat, 08 Jun 2024 04:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrei-0004JH-V2
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFreg-0001YU-U9
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XW36JikV1vaIpwUTwftCWapesqtWR9fALEpfLU1nVko=;
 b=VVkkg6Eog7RhTybA/vfgnUzcA5/fAxDQM1KQLUT2ZZSD0ySXDdW0VELLsWizWkp3PLLXFC
 oxvNxgX7j6H9tStM5r6Scl2n3/lJOyUW5oVqJaqwI+g6PMUa+BE/H66npQzmoIJlzrXXPm
 R3dPiVjLIinEvbfa1PDZIorlBoy4Jss=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-jtMqDDtvMYqDvhBgJ8xXCA-1; Sat, 08 Jun 2024 04:42:28 -0400
X-MC-Unique: jtMqDDtvMYqDvhBgJ8xXCA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6ef729b8a7so45199266b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836146; x=1718440946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XW36JikV1vaIpwUTwftCWapesqtWR9fALEpfLU1nVko=;
 b=uK4QGx2vQ/RNEoMRDoA5OnuSMHlfJWJ9wICbXVEjOtRCGyNQlmXLXZLHgg7pn11Blz
 7bwDHxsR/GlCM7MpxIw08aZShPQdekfpDm1Tjv+UFzlrlxzQNkGm7qjsijwat8PtNjNf
 RZ1dXCnlb6O/fBG5RbGKNNcGr/p7WrsccktKzOptldwNYATvpDwSpuBhY1kB3GwFUUAF
 H3puggL/aHvnhSQ9BrebpavfB+FEhi+g1XHEIUmFlyoEDMs/i7m8dTuDEvVSNH1sCKqI
 P6WTb/AypXaPm9opGWhF6Nql99uTUGCfymSW2G+kvvfl+NXqPzlH8rq0mPVBGMPR7Lxh
 r4eA==
X-Gm-Message-State: AOJu0YwB5gkaD29tZecxy4Z6tZaf4yQMAb5X9FvmsqU6vOS8FEkQWG2Y
 5zCZN1aRH7vaBubNNVMDVglHnzJl9huRjgIV3ikR/T8cuUHAqDNXpGabrAWJPbl4YXMIbJRR+oR
 lTDHsjQvvzQk48HdcYn8jfxuenPMiNleEYROZETqmQaAgjXxCHRa5RgwlN+bii7AtxI2ngKHVV4
 1wlCJdA/fUGkYVdBx9bE678YUnRmcLIVP1x3za
X-Received: by 2002:a50:99d4:0:b0:57c:61df:fe68 with SMTP id
 4fb4d7f45d1cf-57c61dfffafmr1411784a12.17.1717836145911; 
 Sat, 08 Jun 2024 01:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvhYL/W+uvwVIeXsyuYe+3HTqrHgGWHq0+xmLkQ7vNm7RP2YlX5OI9QnZ48dak0ZvlF61uzA==
X-Received: by 2002:a50:99d4:0:b0:57c:61df:fe68 with SMTP id
 4fb4d7f45d1cf-57c61dfffafmr1411774a12.17.1717836145408; 
 Sat, 08 Jun 2024 01:42:25 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0ca9besm3951043a12.27.2024.06.08.01.42.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:42:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/25] target/i386: convert CMPXCHG to new decoder
Date: Sat,  8 Jun 2024 10:41:08 +0200
Message-ID: <20240608084113.2770363-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      | 79 --------------------------------
 target/i386/tcg/decode-new.c.inc |  3 +-
 target/i386/tcg/emit.c.inc       | 51 +++++++++++++++++++++
 3 files changed, 53 insertions(+), 80 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7a63c927c1f..1f76339130a 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -434,13 +434,6 @@ static inline MemOp mo_stacksize(DisasContext *s)
     return CODE64(s) ? MO_64 : SS32(s) ? MO_32 : MO_16;
 }
 
-/* Select size 8 if lsb of B is clear, else OT.  Used for decoding
-   byte vs word opcodes.  */
-static inline MemOp mo_b_d(int b, MemOp ot)
-{
-    return b & 1 ? ot : MO_8;
-}
-
 /* Compute the result of writing t0 to the OT-sized register REG.
  *
  * If DEST is NULL, store the result into the register and return the
@@ -715,11 +708,6 @@ static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
     return dst;
 }
 
-static void gen_extu(MemOp ot, TCGv reg)
-{
-    gen_ext_tl(reg, reg, ot, false);
-}
-
 static void gen_op_j_ecx(DisasContext *s, TCGCond cond, TCGLabel *label1)
 {
     TCGv tmp = gen_ext_tl(NULL, cpu_regs[R_ECX], s->aflag, false);
@@ -2998,73 +2986,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
 
     /* now check op code */
     switch (b) {
-        /**************************/
-        /* arith & logic */
-    case 0x1b0:
-    case 0x1b1: /* cmpxchg Ev, Gv */
-        {
-            TCGv oldv, newv, cmpv, dest;
-
-            ot = mo_b_d(b, dflag);
-            modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | REX_R(s);
-            mod = (modrm >> 6) & 3;
-            oldv = tcg_temp_new();
-            newv = tcg_temp_new();
-            cmpv = tcg_temp_new();
-            gen_op_mov_v_reg(s, ot, newv, reg);
-            tcg_gen_mov_tl(cmpv, cpu_regs[R_EAX]);
-            gen_extu(ot, cmpv);
-            if (s->prefix & PREFIX_LOCK) {
-                if (mod == 3) {
-                    goto illegal_op;
-                }
-                gen_lea_modrm(env, s, modrm);
-                tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, cmpv, newv,
-                                          s->mem_index, ot | MO_LE);
-            } else {
-                if (mod == 3) {
-                    rm = (modrm & 7) | REX_B(s);
-                    gen_op_mov_v_reg(s, ot, oldv, rm);
-                    gen_extu(ot, oldv);
-
-                    /*
-                     * Unlike the memory case, where "the destination operand receives
-                     * a write cycle without regard to the result of the comparison",
-                     * rm must not be touched altogether if the write fails, including
-                     * not zero-extending it on 64-bit processors.  So, precompute
-                     * the result of a successful writeback and perform the movcond
-                     * directly on cpu_regs.  Also need to write accumulator first, in
-                     * case rm is part of RAX too.
-                     */
-                    dest = gen_op_deposit_reg_v(s, ot, rm, newv, newv);
-                    tcg_gen_movcond_tl(TCG_COND_EQ, dest, oldv, cmpv, newv, dest);
-                } else {
-                    gen_lea_modrm(env, s, modrm);
-                    gen_op_ld_v(s, ot, oldv, s->A0);
-
-                    /*
-                     * Perform an unconditional store cycle like physical cpu;
-                     * must be before changing accumulator to ensure
-                     * idempotency if the store faults and the instruction
-                     * is restarted
-                     */
-                    tcg_gen_movcond_tl(TCG_COND_EQ, newv, oldv, cmpv, newv, oldv);
-                    gen_op_st_v(s, ot, newv, s->A0);
-                }
-            }
-	    /*
-	     * Write EAX only if the cmpxchg fails; reuse newv as the destination,
-	     * since it's dead here.
-	     */
-            dest = gen_op_deposit_reg_v(s, ot, R_EAX, newv, oldv);
-            tcg_gen_movcond_tl(TCG_COND_EQ, dest, oldv, cmpv, dest, newv);
-            tcg_gen_mov_tl(cpu_cc_src, oldv);
-            tcg_gen_mov_tl(s->cc_srcT, cmpv);
-            tcg_gen_sub_tl(cpu_cc_dst, cmpv, oldv);
-            set_cc_op(s, CC_OP_SUBB + ot);
-        }
-        break;
     case 0x1c7: /* cmpxchg8b */
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 11ecd1c6c1d..00ffaeb0763 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1181,6 +1181,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xa4] = X86_OP_ENTRY4(SHLD,  E,v, 2op,v, G,v),
     [0xa5] = X86_OP_ENTRY3(SHLD,  E,v, 2op,v, G,v),
 
+    [0xb0] = X86_OP_ENTRY2(CMPXCHG,E,b, G,b, lock),
+    [0xb1] = X86_OP_ENTRY2(CMPXCHG,E,v, G,v, lock),
     [0xb2] = X86_OP_ENTRY3(LSS,    G,v, EM,p, None, None),
     [0xb3] = X86_OP_ENTRY2(BTR,    E,v, G,v,             btEvGv),
     [0xb4] = X86_OP_ENTRY3(LFS,    G,v, EM,p, None, None),
@@ -2612,7 +2614,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             switch (b) {
             case 0x00 ... 0x01: /* mostly privileged instructions */
             case 0x1a ... 0x1b: /* MPX */
-            case 0xb0 ... 0xb1: /* cmpxchg */
             case 0xc7:          /* grp9 */
                 disas_insn_old(s, cpu, b + 0x100);
                 return;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 42e41a7a87c..857d270d247 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1708,6 +1708,57 @@ static void gen_CMPS(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[2].ot;
+    TCGv cmpv = tcg_temp_new();
+    TCGv oldv = tcg_temp_new();
+    TCGv newv = tcg_temp_new();
+    TCGv dest;
+
+    tcg_gen_ext_tl(cmpv, cpu_regs[R_EAX], ot);
+    tcg_gen_ext_tl(newv, s->T1, ot);
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, cmpv, newv,
+                                  s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_ext_tl(oldv, s->T0, ot);
+        if (decode->op[0].has_ea) {
+            /*
+             * Perform an unconditional store cycle like physical cpu;
+             * must be before changing accumulator to ensure
+             * idempotency if the store faults and the instruction
+             * is restarted
+             */
+            tcg_gen_movcond_tl(TCG_COND_EQ, newv, oldv, cmpv, newv, oldv);
+            gen_op_st_v(s, ot, newv, s->A0);
+        } else {
+            /*
+             * Unlike the memory case, where "the destination operand receives
+             * a write cycle without regard to the result of the comparison",
+             * rm must not be touched altogether if the write fails, including
+             * not zero-extending it on 64-bit processors.  So, precompute
+             * the result of a successful writeback and perform the movcond
+             * directly on cpu_regs.  In case rm is part of RAX, note that this
+             * movcond and the one below are mutually exclusive is executed.
+             */
+            dest = gen_op_deposit_reg_v(s, ot, decode->op[0].n, newv, newv);
+            tcg_gen_movcond_tl(TCG_COND_EQ, dest, oldv, cmpv, newv, dest);
+        }
+        decode->op[0].unit = X86_OP_SKIP;
+    }
+
+    /* Write RAX only if the cmpxchg fails.  */
+    dest = gen_op_deposit_reg_v(s, ot, R_EAX, s->T0, oldv);
+    tcg_gen_movcond_tl(TCG_COND_NE, dest, oldv, cmpv, s->T0, dest);
+
+    tcg_gen_mov_tl(s->cc_srcT, cmpv);
+    tcg_gen_sub_tl(cmpv, cmpv, oldv);
+    decode->cc_dst = cmpv;
+    decode->cc_src = oldv;
+    decode->cc_op = CC_OP_SUBB + ot;
+}
+
 static void gen_CPUID(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
-- 
2.45.1


