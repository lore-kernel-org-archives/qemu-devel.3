Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE66C5DF88
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNqQ-0002wb-3w; Tue, 18 Aug 2026 13:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNqI-0002vO-E6
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:18 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNqE-00081i-Pk
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:18 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8200ca16f26so2472367b3.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787074991; x=1787679791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BjxyEeK8365VbqkIEoqsYg/DoU9ewvIYcbSIMSbaWL4=;
 b=DDP4WzN5DbzaUtvr2rFtOmeGCs9uKhzFkJLziRg+bCiMdcUUQRBcfXiwd3KicJa5rm
 1n0YjHOGaj7BdJPT0BrkUN/jUF9/mjv8VB25Sw0Vr4tf9pwS5LGKNxuVaQpnDYuzTEgZ
 FeiGwjmLiBaoePQ9PWqIDVcuaOflucy23yGCYtCclTCDW+Dv9+qepEyk+HZYhfPG44B4
 MpTLxpQ89yKeqy1RsWUrFsu1ikjGOh7H0g9I7AvExckxAmPF+QW+WzBmJ6MvEhNFnt8q
 JT42dHWEDerI71Cggs6iqAyAreZ4MUNq+FFA4uNkwv2EcoWmZ1QWQFLjwX/+3vlr9eh4
 wOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074991; x=1787679791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BjxyEeK8365VbqkIEoqsYg/DoU9ewvIYcbSIMSbaWL4=;
 b=g6YUWv1I+TUHhve3WV9k8tuv4kEeC87KBM12RcwwJBjYDs8gOraCd47Yr+vMs8xeYB
 VeTY1cLycnrpkmNG2WZkVbfXYQfvNmiQVnvAwfj0tRsjKYw/ur5yTvVyVLU/HdznaUSw
 sJGiCVamBLfkvlMDjazgAqmuj1pmDNJfXr+xcHM+X6EEjxu81cFexvIJjQNRIRybm1vc
 iQRnzaRqQ/5IRCaItqPSBEjq14naqvx3364C730Mt0q26DNGmMZqdtwEHRx/q489ODJe
 6wDKS0wFPawu7nmd4hQIdF9wb+wHRef2d0HInZcJwXL1qYdR4/qxnL4HQgbc2cw9oXRg
 eh2w==
X-Gm-Message-State: AOJu0Yz+UuKHFTZqR8qSmfSmDRyedWkCvCdEiBpuqE+4VPAn+hxSrM5E
 ikA2CM0qanAqBzu2KNRsiXwZoETlBV3e2UVE4R4uoVqQJAGRkhtKo5Y2pceISsxwZos=
X-Gm-Gg: AR+sD12uVvPmVWDIGEu2dTkm+Lh0PGvWaKU31euoO8+wABM23bAyQTPnELE6fn3AkkD
 wjyu7IGqTu4KQsl/ax/zoPKONJA57lmU3g3U9MiDpXWlNJ7hsb20OCVn/Sf5wduzEs9dW/VxQSw
 WtppvraiMlY9Z9ElOs/r3568TKvMM1jIRqFSerKgsCrQiSdTbPHCCABww1h+A0krJLVZYQpruZT
 9hTrBRR40RGUsmbAKZ2ck1ybLfN7+dRarC6p6XLbeXHgAI34MWC+ntldZ/oMQ68eX/ZGw1dLciV
 hJDrEZrcW/klaO8GufQZigxbStgh33PhnPbdrItrp8Mc5nylZoPLS0cr57VSGVLDj24QMhf/X9t
 P0B3MiACxe8kD54NH35L7uEb8UKubAmn+YGspu2e0ZIE+z2ubnskynDrY05+QPTokidYkrkXWU/
 EtqTqx+EOPGpIKpP5tdGa1JbA233O2A0q2AcVQrbjQ+uzdWkA0b5jvbVPfMDtlzrlhvg==
X-Received: by 2002:a05:690c:18:b0:7b2:1bf1:8016 with SMTP id
 00721157ae682-8412cd494f2mr39819657b3.2.1787074991302; 
 Tue, 18 Aug 2026 10:43:11 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-84068077d9csm24909897b3.8.2026.08.18.10.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:43:10 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 8/8] RFC: tcg: fold a guest displacement into the host
 addressing mode
Date: Tue, 18 Aug 2026 13:42:47 -0400
Message-ID: <20260818174247.649526-9-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818174247.649526-1-mattst88@gmail.com>
References: <20260818174247.649526-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Nothing in the TCG frontend interface can express a based memory access.
tcg_gen_qemu_ld/st take an address and nothing else, so a target with a
displacement in its load and store encodings -- which is most of them --
has to materialise the address first:

    ldq a1,8(a0)  ->  mov 0x80(%rbp),%rbx      reload a0
                      lea 0x8(%rbx),%r12       address
                      mov (%r12),%r12          the load
                      mov %r12,0x88(%rbp)      spill a1

The lea is pure loss on a host whose addressing mode has a displacement
field sitting empty. It also needs a register, at the point in a block
where pressure is highest.

Fold it. After optimisation, look for an add of a constant immediately
before a guest access, defining that access's address operand, and move the
constant into a new second constant argument on the op. The add is left for
liveness to remove, so nothing breaks if its result has another use. Only
the immediately preceding op is examined: that is what the frontends emit,
and a window of one op means the pass does not have to reason about what
could have happened in between. The one thing it does check is that the add
did not clobber the base it read, since the access now reads that base
directly.

Targets opt in with TCG_TARGET_HAS_ldst_disp and an out_disp member on
TCGOutOpQemuLdSt. Without it the pass does not run, the displacement stays
zero and the existing out member is called exactly as before, so no other
backend changes behaviour or needs touching.

For x86_64 the displacement goes in the disp32 that prepare_host_addr()
already fills in for guest_base. The fold is refused unless there is no
slow path at all, which means user-only -- softmmu compares the unadjusted
address against the TLB -- and an access needing no alignment test, since
the slow path hands addr_reg to the helper and that register no longer
holds the full guest address. It is also refused if guest_base plus the
displacement leaves disp32.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling the
SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO build,
on top of the preceding patches, against a control measured in the same
session:

    before: 787,483,360,681 instructions, 78.250s
    after:  738,020,161,466 instructions, 75.679s
                                          -6.29% instructions, -3.29% wall

Emitted code shrinks from 46.29MB to 44.53MB over the run, 153.3 to 147.5
bytes per block. Per Alpha opcode, the host bytes emitted for an access
fall as expected and nothing else moves:

    ldq   17.2 -> 14.3    ldah  16.9 -> 16.9
    ldl   14.1 -> 11.6    lda   12.6 -> 12.6
    stq   12.7 ->  9.7    mov    9.7 ->  9.7

The emulated compiler produces byte-identical output and the alpha tests
still pass, including with a non-zero guest_base forced via -B.

RFC because:

- Only wired up for x86_64, and only for qemu_ld and qemu_st; the i128
  qemu_ld2 and qemu_st2 pairs are left alone.
- Requiring that no slow path exists is stricter than necessary. Recording
  the displacement in TCGLabelQemuLdst and emitting one lea on the slow
  path would cover alignment-checked accesses too, at no fast path cost.
- Softmmu wants the displacement folded into the TLB comparison as well,
  which is a bigger change than this one.
- A one op window catches everything the frontends emit today but is
  trivially defeated by anything scheduled in between.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 include/tcg/tcg-opc.h       |  9 +++-
 tcg/tcg-op-ldst.c           |  3 +-
 tcg/tcg.c                   | 86 ++++++++++++++++++++++++++++++++++++-
 tcg/x86_64/tcg-target.c.inc | 61 ++++++++++++++++++++++++++
 tcg/x86_64/tcg-target.h     |  3 ++
 5 files changed, 158 insertions(+), 4 deletions(-)

diff --git ./include/tcg/tcg-opc.h ./include/tcg/tcg-opc.h
index 61f1c28858..0a3b4330f1 100644
--- ./include/tcg/tcg-opc.h
+++ ./include/tcg/tcg-opc.h
@@ -118,8 +118,13 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
 
-DEF(qemu_ld, 1, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
-DEF(qemu_st, 0, 2, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
+/*
+ * The second constant argument is a displacement to add to the address,
+ * zero unless a target advertises TCG_TARGET_HAS_ldst_disp and the fold in
+ * fold_ldst_disp() applied.
+ */
+DEF(qemu_ld, 1, 1, 2, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
+DEF(qemu_st, 0, 2, 2, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
 DEF(qemu_ld2, 2, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
 DEF(qemu_st2, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT)
 
diff --git ./tcg/tcg-op-ldst.c ./tcg/tcg-op-ldst.c
index 22211ccb45..ffc5e651a6 100644
--- ./tcg/tcg-op-ldst.c
+++ ./tcg/tcg-op-ldst.c
@@ -92,7 +92,8 @@ static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
 static void gen_ldst1(TCGOpcode opc, TCGType type, TCGTemp *v,
                       TCGTemp *addr, MemOpIdx oi)
 {
-    TCGOp *op = tcg_gen_op3(opc, type, temp_arg(v), temp_arg(addr), oi);
+    /* The trailing zero is the address displacement; see fold_ldst_disp(). */
+    TCGOp *op = tcg_gen_op4(opc, type, temp_arg(v), temp_arg(addr), oi, 0);
     TCGOP_FLAGS(op) = get_memop(oi) & MO_SIZE;
 }
 
diff --git ./tcg/tcg.c ./tcg/tcg.c
index 1e77f2365a..bdd95304ea 100644
--- ./tcg/tcg.c
+++ ./tcg/tcg.c
@@ -1058,6 +1058,13 @@ typedef struct TCGOutOpQemuLdSt {
     TCGOutOp base;
     void (*out)(TCGContext *s, TCGType type, TCGReg dest,
                 TCGReg addr, MemOpIdx oi);
+    /*
+     * As out(), for an access at addr + disp. Only required of targets that
+     * define TCG_TARGET_HAS_ldst_disp; for everyone else fold_ldst_disp()
+     * never runs and the displacement is always zero.
+     */
+    void (*out_disp)(TCGContext *s, TCGType type, TCGReg dest,
+                     TCGReg addr, MemOpIdx oi, int32_t disp);
 } TCGOutOpQemuLdSt;
 
 typedef struct TCGOutOpQemuLdSt2 {
@@ -3560,6 +3567,77 @@ static void move_label_uses(TCGLabel *to, TCGLabel *from)
     QSIMPLEQ_CONCAT(&to->branches, &from->branches);
 }
 
+#ifndef TCG_TARGET_HAS_ldst_disp
+#define TCG_TARGET_HAS_ldst_disp  0
+static bool tcg_target_ldst_disp_ok(TCGContext *s, MemOpIdx oi, int64_t disp)
+{
+    return false;
+}
+#endif
+
+/*
+ * Fold "add addr, base, $disp" into the guest access that follows it, so
+ * that the displacement becomes part of the host addressing mode instead of
+ * a separate instruction. Frontends have no way to express this: there is
+ * no displacement operand on tcg_gen_qemu_ld/st, so a based access always
+ * costs an extra add, and an extra register to hold its result.
+ *
+ * Only an add in the op immediately before the access is recognised. That
+ * is what the frontends emit, and a window of one op means no analysis is
+ * needed of what might have happened in between. The add is left in place;
+ * liveness removes it if its result has no other use.
+ */
+static void __attribute__((noinline))
+fold_ldst_disp(TCGContext *s)
+{
+    TCGOp *op;
+
+    if (!TCG_TARGET_HAS_ldst_disp) {
+        return;
+    }
+
+    QTAILQ_FOREACH(op, &s->ops, link) {
+        TCGOp *prev;
+        TCGTemp *cts;
+        int64_t disp;
+
+        switch (op->opc) {
+        case INDEX_op_qemu_ld:
+        case INDEX_op_qemu_st:
+            break;
+        default:
+            continue;
+        }
+
+        prev = QTAILQ_PREV(op, link);
+        if (prev == NULL || prev->opc != INDEX_op_add ||
+            TCGOP_TYPE(prev) != s->addr_type) {
+            continue;
+        }
+
+        /*
+         * The add must define the address operand, and must not have
+         * clobbered the base it read: after the fold the access reads the
+         * base directly, so the base has to still hold its original value.
+         */
+        if (prev->args[0] != op->args[1] || prev->args[0] == prev->args[1]) {
+            continue;
+        }
+
+        cts = arg_temp(prev->args[2]);
+        if (cts->kind != TEMP_CONST) {
+            continue;
+        }
+        disp = cts->val;
+        if (disp == 0 || !tcg_target_ldst_disp_ok(s, op->args[2], disp)) {
+            continue;
+        }
+
+        op->args[1] = prev->args[1];
+        op->args[3] = disp;
+    }
+}
+
 /* Reachable analysis : remove unreachable code.  */
 static void __attribute__((noinline))
 reachable_code_pass(TCGContext *s)
@@ -5707,7 +5785,12 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             const TCGOutOpQemuLdSt *out =
                 container_of(all_outop[op->opc], TCGOutOpQemuLdSt, base);
 
-            out->out(s, type, new_args[0], new_args[1], new_args[2]);
+            if (new_args[3]) {
+                out->out_disp(s, type, new_args[0], new_args[1],
+                              new_args[2], new_args[3]);
+            } else {
+                out->out(s, type, new_args[0], new_args[1], new_args[2]);
+            }
         }
         break;
 
@@ -6590,6 +6673,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     tcg_temp_ebb_reset_freed(s);
 
     tcg_optimize(s);
+    fold_ldst_disp(s);
 
     reachable_code_pass(s);
     liveness_pass_0(s);
diff --git ./tcg/x86_64/tcg-target.c.inc ./tcg/x86_64/tcg-target.c.inc
index 1fc45e4ec6..d3bde91816 100644
--- ./tcg/x86_64/tcg-target.c.inc
+++ ./tcg/x86_64/tcg-target.c.inc
@@ -2015,6 +2015,39 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     return ldst;
 }
 
+/*
+ * Whether the displacement of a guest access can be folded into the host
+ * addressing mode rather than materialised by a separate lea.
+ *
+ * Folding rewrites the access to use base + disp, so nothing may need a
+ * register holding the complete guest address. The softmmu TLB comparison
+ * does, and so does any slow path, which hands addr_reg to the helper. In
+ * user-only mode prepare_host_addr() creates a slow path only for an
+ * alignment test, so requiring that none is needed rules it out. What is
+ * left to check is guest_base, which shares the disp32 field.
+ */
+static bool tcg_target_ldst_disp_ok(TCGContext *s, MemOpIdx oi, int64_t disp)
+{
+#ifdef CONFIG_USER_ONLY
+    MemOp opc = get_memop(oi);
+    TCGAtomAlign aa;
+    int64_t ofs;
+
+    if (tcg_use_softmmu || s->addr_type != TCG_TYPE_I64) {
+        return false;
+    }
+    aa = atom_and_align_for_opc(s, opc, MO_ATOM_WITHIN16,
+                                (opc & MO_SIZE) == MO_128);
+    if (aa.align) {
+        return false;
+    }
+    ofs = (int64_t)x86_guest_base.ofs + disp;
+    return ofs == (int32_t)ofs;
+#else
+    return false;
+#endif
+}
+
 static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                    HostAddress h, TCGType type, MemOp memop)
 {
@@ -2171,9 +2204,23 @@ static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
     }
 }
 
+static void tgen_qemu_ld_disp(TCGContext *s, TCGType type, TCGReg data,
+                              TCGReg addr, MemOpIdx oi, int32_t disp)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    ldst = prepare_host_addr(s, &h, addr, oi, true);
+    /* tcg_target_ldst_disp_ok() has ruled out every slow path. */
+    tcg_debug_assert(ldst == NULL);
+    h.ofs += disp;
+    tcg_out_qemu_ld_direct(s, data, -1, h, type, get_memop(oi));
+}
+
 static const TCGOutOpQemuLdSt outop_qemu_ld = {
     .base.static_constraint = C_O1_I1(r, L),
     .out = tgen_qemu_ld,
+    .out_disp = tgen_qemu_ld_disp,
 };
 
 static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
@@ -2309,9 +2356,23 @@ static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
     }
 }
 
+static void tgen_qemu_st_disp(TCGContext *s, TCGType type, TCGReg data,
+                              TCGReg addr, MemOpIdx oi, int32_t disp)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    ldst = prepare_host_addr(s, &h, addr, oi, false);
+    /* tcg_target_ldst_disp_ok() has ruled out every slow path. */
+    tcg_debug_assert(ldst == NULL);
+    h.ofs += disp;
+    tcg_out_qemu_st_direct(s, data, -1, h, get_memop(oi));
+}
+
 static const TCGOutOpQemuLdSt outop_qemu_st = {
     .base.static_constraint = C_O0_I2(L, L),
     .out = tgen_qemu_st,
+    .out_disp = tgen_qemu_st_disp,
 };
 
 static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
diff --git ./tcg/x86_64/tcg-target.h ./tcg/x86_64/tcg-target.h
index 7ebae56a7d..8f2315c15e 100644
--- ./tcg/x86_64/tcg-target.h
+++ ./tcg/x86_64/tcg-target.h
@@ -30,6 +30,9 @@
 #define TCG_TARGET_NB_REGS   32
 #define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
 
+/* A guest displacement can go in the disp32 of the addressing mode. */
+#define TCG_TARGET_HAS_ldst_disp  1
+
 typedef enum {
     TCG_REG_EAX = 0,
     TCG_REG_ECX,
-- 
2.54.0


