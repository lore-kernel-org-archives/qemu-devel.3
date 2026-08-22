Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ECAC5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 19:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxr5D-0004C1-49; Sat, 22 Aug 2026 15:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr5C-0004Bp-6Z
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:46 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr59-0005mZ-Qb
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:45 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-81dfdbd86d1so29722787b3.1
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787425723; x=1788030523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OHjPdAZ7tK8mubjCMhyER0kSir+YM3BIpc18K2DMUtc=;
 b=N1YP0U/XlH2kL751uZDPw/uDAI7K8jKcSalmDr51bWxNaMVmt2ZYIlsHz6PgUs1bhC
 UVDIeWY8MzT1/CPVaWQvY/pFCyEDVgdjYiB8HLoBz0MN9lFeFv9FPLlE9yZ8I4DqQawh
 dXXEKYoyFEL8bpz13bNZvZNbxcYiVfwNFgHLZ+AnATb1P6FVgMSI0u3h4AQrl7iRcr3p
 Wfhuam0kdG03CemWEUXUF2yp3xhh17q0o+YpNDiyNAPSmVi0DKsDshWEcQ/GFGc+sPj8
 ZwxAvCp47gYK9NPRFQwaO6v3wtL2exLer4Jf3T7XxIjvQMEBKGqh3jpXieALzs2+m9tc
 b1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787425723; x=1788030523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OHjPdAZ7tK8mubjCMhyER0kSir+YM3BIpc18K2DMUtc=;
 b=Njm/Jh19REiW9SWlpOSyHC+eP5v9qLzELn/dwusLY4h2aEZEWp+SVXs/dXdJzTrzE+
 wLzwnf69NaLQA+gm2HrHd4JdD4rZa0re+t0GDPddfe7yyqgABGCjh/8c2YSK1IL9omIW
 coe0qNYfFtuiCkxeerqHz2GRow8t5NzWc3bqKyx1NZVjlkoSk9dUcS9UEmVbmpuXcAnH
 DKas5fZ7fpf2Io2na50Jtn20vRNCJMuM09rnt4Sdc9iOyiu8Zv99eluJH6GNwSCKLe1+
 OcwXEugFI5RZ8GmZLdVR+WChv0/4IOSVMD7sFmOhhijhpPSmQQ5XJL4jXMJOqLSHTDla
 hiXg==
X-Gm-Message-State: AFuF++njUQ5LUa/DnnmEKUQr6O/OXDFrqFUrqmYM+FkA315F2pjJgb4X
 UOaxA0mPmw4hfi/b3QUQZ8K7y+XLHF67mZW2Q5T2FL8yNwK2M4a/f65DjkLxCps9oNA=
X-Gm-Gg: AR+sD12pcxHk0TqD+bQ/kdvrVj292ZxauZNGUQZ6I1zRwd7oK0VKXPBAAie+CouGTK1
 mHz4+whNlM6aeLseiMV4ZoPOadH6wRnV4zQn+RACa+XijU7Xh77QRYc1ABfonkppAhi+QQUrmhI
 DU7+/XU5PCKVoUZ6Bb61WyxSZzRsNhGlprIZmL6osYmsOdPrNjlzUZU+m9WdR87gFPHtF1pjk3a
 vi5dfsxj0hZ8CyC+gw+OEocryY4fMo0W3NBO5RJDG+auP85o/ro4P6znCWJdol6IGZR7Qz8V9vW
 nya10gQo/w5w/Z4DuwP9lQ22Bm0N/gQgaoX/JbKbgExIyZOVwi265udIGE3SRlZHgOVpCIOmst6
 dnSz+Kbjz3hLsTHXTuhhoJSiTQmb2gkkCXn4fpjkAIHxPx+bj4a/BFWeptOoJu4k84nSqfJDUnN
 Nb38VwRIzLDGggqmdyJTtEWIHLGWVu6g0PjoRcYoSwBZAB4TMv6w2OedumS4CIWkJXZFfNwXKoy
 jb1mQ8vybSD+Ck4H5MG6WjQfcgHAJHxBOA0uzPk
X-Received: by 2002:a05:690c:63ca:b0:80e:5236:b944 with SMTP id
 00721157ae682-849f2a39745mr53932557b3.10.1787425722386; 
 Sat, 22 Aug 2026 12:08:42 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-84ca5188982sm13908967b3.10.2026.08.22.12.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 12:08:40 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 7/7] RFC: tcg: fold a guest displacement into the host
 addressing mode
Date: Sat, 22 Aug 2026 15:08:18 -0400
Message-ID: <20260822190818.1829249-8-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822190818.1829249-1-mattst88@gmail.com>
References: <20260822190818.1829249-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1130.google.com
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

    before: 868,811,832,620 instructions, 79.85s
    after:  819,262,147,022 instructions, 77.30s
                                          -5.70% instructions, -3.20% wall

Emitted code shrinks from 50.55MB to 48.80MB over the run, 167.4 to 161.6
bytes per block. Per Alpha opcode, the host bytes emitted for an access
fall as expected and nothing else moves:

    ldq   18.3 -> 15.4    ldah  20.9 -> 20.9
    ldl   16.6 -> 14.1    lda   12.9 -> 12.9
    stq   12.8 ->  9.7    mov    9.8 ->  9.8

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
index f3a81d5d7f..92fd34d3e3 100644
--- ./include/tcg/tcg-opc.h
+++ ./include/tcg/tcg-opc.h
@@ -125,8 +125,13 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
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
index 489df0e738..9e6da41887 100644
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
@@ -3574,6 +3581,77 @@ static void move_label_uses(TCGLabel *to, TCGLabel *from)
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
@@ -5728,7 +5806,12 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
 
@@ -6611,6 +6694,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     tcg_temp_ebb_reset_freed(s);
 
     tcg_optimize(s);
+    fold_ldst_disp(s);
 
     reachable_code_pass(s);
     liveness_pass_0(s);
diff --git ./tcg/x86_64/tcg-target.c.inc ./tcg/x86_64/tcg-target.c.inc
index 2c8f1f3e58..d72c3db13d 100644
--- ./tcg/x86_64/tcg-target.c.inc
+++ ./tcg/x86_64/tcg-target.c.inc
@@ -2027,6 +2027,39 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
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
@@ -2183,9 +2216,23 @@ static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
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
@@ -2321,9 +2368,23 @@ static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
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


