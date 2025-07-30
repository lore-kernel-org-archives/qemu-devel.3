Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BB4C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvE4-0005Vq-8n; Tue, 29 Jul 2025 21:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCj-0003c2-Ap
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:02:01 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCg-0004nR-MB
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:02:00 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b3be5c0eb99so5191102a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837317; x=1754442117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lz0RHxK9toXqNqhJeVQp50S4aerdj/bOx5h0bx/M2dM=;
 b=LSGI3c8vmtH+x3kF7BJumxIhfMsXyc+3FTBbNtPEpmiOPivuoL8qtFitVE3vGYF3nN
 p/hgxMnHHeaQrHFOzyqbar7pVFywk2wjRE9u6fFIzlRXsPJ0/EB/Cf69S9o1P2X/0UjT
 FpwFkgU+9wY8UU5oe9NgfetU+UnxLOh+NIJvbhVEOt0OiLp7YZ/Kg1wA/Hi0n2JMlOhx
 S4CHypd1fwn18aiObT2501jg1g3NOfCsST37K8yUtTG64ulhGr/9LZprnOsAWQTTnxOG
 YOmr+WeItX6Zyd6UngEuufStKc/qnyQeSw0XGUCwSynkJwMTEI1B9fZZUIJIz8GDHSoa
 9Mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837317; x=1754442117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lz0RHxK9toXqNqhJeVQp50S4aerdj/bOx5h0bx/M2dM=;
 b=nlb7gj8/Dgo7W695Z575ywxPkrnzYzB1wpLqaEWU4TpFvqx3XWoNU32hFdZZpdKYQH
 MPI9e3lwHaaOPecYu+phE6v6pahoIqjsx4ea/KFGc/taliEG2VekeogWounEr+lCe8tv
 eUbi4hjaRx4/oACQW20h1QZ9aghdvClPCdEo+7x6NOHoQgvELnsjIwOKWPIsuR5b58uH
 xPCg4+oic68CgHqaSmsenmxfIWkom7dRaMdpNTgaXZ2hsHHJvinbKf81jYF2Ig4xDRe/
 929toGKjT4MdNr5lGWuHXrWrPhQp1OLsEBk8pvvBiuxSIIjTSgBoJ8w1im9yP8cNkMd8
 BIDw==
X-Gm-Message-State: AOJu0Yyi4vkBor19qBIsmqTDc4+GAvu/lcLRJOyaujUfdX4Qk070obUt
 Bu7GCRZZa0DXbzAzU0sspDTdOSSvNXoqQ+PQ5vhsMoXQcmqr4s03KaLlr6MKzQ==
X-Gm-Gg: ASbGnct2/4ZfsafO6awTz4KbY+qFGtpxerxEIXWad7GdiB1LyJi7eRh272QQDROZL2f
 bk0KxszLDSixONZ9irXU4d/Ktf5kDUh10r7ilT4HU+Jx08aD7jCogM+oeg5zDpab757yZ9WA30A
 PbHMCV5OwaVpJDJCkOdRyzUIoLH8QQ4Hkjpg8ygYxIzJaWs4Xj2gbfjwoZsGWXnB12BJIn1Vs7X
 AVfJBeuzgwY3RNRdR7XtNCTedbJhAkp3ZpH56SMYPRVEdkV8FmKP4tBwRkuPtzJp9b2dbkgpRYC
 BrsUtxVvvKSpPKHwgj9AEOLxBDWTj+VrJjT+XJqiIKE23Y2hfbxWHTGS1xpN/t1gSoUinPC9h4l
 4aLIWUnpmXT1owHtpERPqj+RNxLrlfYaKV7nKem630JZGs3Z1D95ZHjjCb+Eb4531Xs4IBm1YHa
 H/0uStOVnKjPyCgPJmF+Ysugv3ox0=
X-Google-Smtp-Source: AGHT+IGkPur9OHjcG7KqCiPpIdeTlnpRU3sT5qU39IjBWGsSwBScWkl05uiPVoTpdbRZOH+IVcNs3Q==
X-Received: by 2002:a17:90b:3d0a:b0:311:c596:5c6f with SMTP id
 98e67ed59e1d1-31f5de2d577mr2322830a91.17.1753837316468; 
 Tue, 29 Jul 2025 18:01:56 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df5adfsm343253a91.25.2025.07.29.18.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 18:01:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/11] riscv: Revert "Generate strided vector loads/stores with
 tcg nodes."
Date: Wed, 30 Jul 2025 11:01:19 +1000
Message-ID: <20250730010122.4193496-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This reverts commit 28c12c1f2f50d7f7f1ebfc587c4777ecd50aac5b.

As reported in [1] this commit is breaking Linux vector code, and
although a simpler reproducer was provided, the fix itself isn't trivial
due to the amount and the nature of the changes. And we really do not
want to keep Linux broken while we work on it.

The revert will fix Linux and will give us time to do a proper fix.

[1] https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02525.html

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Tested-by: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20250710100525.372985-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 323 ++++--------------------
 1 file changed, 50 insertions(+), 273 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 610bf9ff30..71f98fb350 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -864,286 +864,32 @@ GEN_VEXT_TRANS(vlm_v, MO_8, vlm_v, ld_us_mask_op, ld_us_mask_check)
 GEN_VEXT_TRANS(vsm_v, MO_8, vsm_v, st_us_mask_op, st_us_mask_check)
 
 /*
- * MAXSZ returns the maximum vector size can be operated in bytes,
- * which is used in GVEC IR when vl_eq_vlmax flag is set to true
- * to accelerate vector operation.
- */
-static inline uint32_t MAXSZ(DisasContext *s)
-{
-    int max_sz = s->cfg_ptr->vlenb << 3;
-    return max_sz >> (3 - s->lmul);
-}
-
-static inline uint32_t get_log2(uint32_t a)
-{
-    uint32_t i = 0;
-    for (; a > 0;) {
-        a >>= 1;
-        i++;
-    }
-    return i;
-}
-
-typedef void gen_tl_ldst(TCGv, TCGv_ptr, tcg_target_long);
-
-/*
- * Simulate the strided load/store main loop:
- *
- * for (i = env->vstart; i < env->vl; env->vstart = ++i) {
- *     k = 0;
- *     while (k < nf) {
- *         if (!vm && !vext_elem_mask(v0, i)) {
- *             vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
- *                               (i + k * max_elems + 1) * esz);
- *             k++;
- *             continue;
- *         }
- *         target_ulong addr = base + stride * i + (k << log2_esz);
- *         ldst(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
- *         k++;
- *     }
- * }
- */
-static void gen_ldst_stride_main_loop(DisasContext *s, TCGv dest, uint32_t rs1,
-                                      uint32_t rs2, uint32_t vm, uint32_t nf,
-                                      gen_tl_ldst *ld_fn, gen_tl_ldst *st_fn,
-                                      bool is_load)
-{
-    TCGv addr = tcg_temp_new();
-    TCGv base = get_gpr(s, rs1, EXT_NONE);
-    TCGv stride = get_gpr(s, rs2, EXT_NONE);
-
-    TCGv i = tcg_temp_new();
-    TCGv i_esz = tcg_temp_new();
-    TCGv k = tcg_temp_new();
-    TCGv k_esz = tcg_temp_new();
-    TCGv k_max = tcg_temp_new();
-    TCGv mask = tcg_temp_new();
-    TCGv mask_offs = tcg_temp_new();
-    TCGv mask_offs_64 = tcg_temp_new();
-    TCGv mask_elem = tcg_temp_new();
-    TCGv mask_offs_rem = tcg_temp_new();
-    TCGv vreg = tcg_temp_new();
-    TCGv dest_offs = tcg_temp_new();
-    TCGv stride_offs = tcg_temp_new();
-
-    uint32_t max_elems = MAXSZ(s) >> s->sew;
-
-    TCGLabel *start = gen_new_label();
-    TCGLabel *end = gen_new_label();
-    TCGLabel *start_k = gen_new_label();
-    TCGLabel *inc_k = gen_new_label();
-    TCGLabel *end_k = gen_new_label();
-
-    MemOp atomicity = MO_ATOM_NONE;
-    if (s->sew == 0) {
-        atomicity = MO_ATOM_NONE;
-    } else {
-        atomicity = MO_ATOM_IFALIGN_PAIR;
-    }
-
-    mark_vs_dirty(s);
-
-    tcg_gen_addi_tl(mask, (TCGv)tcg_env, vreg_ofs(s, 0));
-
-    /* Start of outer loop. */
-    tcg_gen_mov_tl(i, cpu_vstart);
-    gen_set_label(start);
-    tcg_gen_brcond_tl(TCG_COND_GE, i, cpu_vl, end);
-    tcg_gen_shli_tl(i_esz, i, s->sew);
-    /* Start of inner loop. */
-    tcg_gen_movi_tl(k, 0);
-    gen_set_label(start_k);
-    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end_k);
-    /*
-     * If we are in mask agnostic regime and the operation is not unmasked we
-     * set the inactive elements to 1.
-     */
-    if (!vm && s->vma) {
-        TCGLabel *active_element = gen_new_label();
-        /* (i + k * max_elems) * esz */
-        tcg_gen_shli_tl(mask_offs, k, get_log2(max_elems << s->sew));
-        tcg_gen_add_tl(mask_offs, mask_offs, i_esz);
-
-        /*
-         * Check whether the i bit of the mask is 0 or 1.
-         *
-         * static inline int vext_elem_mask(void *v0, int index)
-         * {
-         *     int idx = index / 64;
-         *     int pos = index  % 64;
-         *     return (((uint64_t *)v0)[idx] >> pos) & 1;
-         * }
-         */
-        tcg_gen_shri_tl(mask_offs_64, mask_offs, 3);
-        tcg_gen_add_tl(mask_offs_64, mask_offs_64, mask);
-        tcg_gen_ld_i64((TCGv_i64)mask_elem, (TCGv_ptr)mask_offs_64, 0);
-        tcg_gen_rem_tl(mask_offs_rem, mask_offs, tcg_constant_tl(8));
-        tcg_gen_shr_tl(mask_elem, mask_elem, mask_offs_rem);
-        tcg_gen_andi_tl(mask_elem, mask_elem, 1);
-        tcg_gen_brcond_tl(TCG_COND_NE, mask_elem, tcg_constant_tl(0),
-                          active_element);
-        /*
-         * Set masked-off elements in the destination vector register to 1s.
-         * Store instructions simply skip this bit as memory ops access memory
-         * only for active elements.
-         */
-        if (is_load) {
-            tcg_gen_shli_tl(mask_offs, mask_offs, s->sew);
-            tcg_gen_add_tl(mask_offs, mask_offs, dest);
-            st_fn(tcg_constant_tl(-1), (TCGv_ptr)mask_offs, 0);
-        }
-        tcg_gen_br(inc_k);
-        gen_set_label(active_element);
-    }
-    /*
-     * The element is active, calculate the address with stride:
-     * target_ulong addr = base + stride * i + (k << log2_esz);
-     */
-    tcg_gen_mul_tl(stride_offs, stride, i);
-    tcg_gen_shli_tl(k_esz, k, s->sew);
-    tcg_gen_add_tl(stride_offs, stride_offs, k_esz);
-    tcg_gen_add_tl(addr, base, stride_offs);
-    /* Calculate the offset in the dst/src vector register. */
-    tcg_gen_shli_tl(k_max, k, get_log2(max_elems));
-    tcg_gen_add_tl(dest_offs, i, k_max);
-    tcg_gen_shli_tl(dest_offs, dest_offs, s->sew);
-    tcg_gen_add_tl(dest_offs, dest_offs, dest);
-    if (is_load) {
-        tcg_gen_qemu_ld_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atomicity);
-        st_fn((TCGv)vreg, (TCGv_ptr)dest_offs, 0);
-    } else {
-        ld_fn((TCGv)vreg, (TCGv_ptr)dest_offs, 0);
-        tcg_gen_qemu_st_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atomicity);
-    }
-    /*
-     * We don't execute the load/store above if the element was inactive.
-     * We jump instead directly to incrementing k and continuing the loop.
-     */
-    if (!vm && s->vma) {
-        gen_set_label(inc_k);
-    }
-    tcg_gen_addi_tl(k, k, 1);
-    tcg_gen_br(start_k);
-    /* End of the inner loop. */
-    gen_set_label(end_k);
-
-    tcg_gen_addi_tl(i, i, 1);
-    tcg_gen_mov_tl(cpu_vstart, i);
-    tcg_gen_br(start);
-
-    /* End of the outer loop. */
-    gen_set_label(end);
-
-    return;
-}
-
-
-/*
- * Set the tail bytes of the strided loads/stores to 1:
- *
- * for (k = 0; k < nf; ++k) {
- *     cnt = (k * max_elems + vl) * esz;
- *     tot = (k * max_elems + max_elems) * esz;
- *     for (i = cnt; i < tot; i += esz) {
- *         store_1s(-1, vd[vl+i]);
- *     }
- * }
+ *** stride load and store
  */
-static void gen_ldst_stride_tail_loop(DisasContext *s, TCGv dest, uint32_t nf,
-                                      gen_tl_ldst *st_fn)
-{
-    TCGv i = tcg_temp_new();
-    TCGv k = tcg_temp_new();
-    TCGv tail_cnt = tcg_temp_new();
-    TCGv tail_tot = tcg_temp_new();
-    TCGv tail_addr = tcg_temp_new();
-
-    TCGLabel *start = gen_new_label();
-    TCGLabel *end = gen_new_label();
-    TCGLabel *start_i = gen_new_label();
-    TCGLabel *end_i = gen_new_label();
-
-    uint32_t max_elems_b = MAXSZ(s);
-    uint32_t esz = 1 << s->sew;
-
-    /* Start of the outer loop. */
-    tcg_gen_movi_tl(k, 0);
-    tcg_gen_shli_tl(tail_cnt, cpu_vl, s->sew);
-    tcg_gen_movi_tl(tail_tot, max_elems_b);
-    tcg_gen_add_tl(tail_addr, dest, tail_cnt);
-    gen_set_label(start);
-    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end);
-    /* Start of the inner loop. */
-    tcg_gen_mov_tl(i, tail_cnt);
-    gen_set_label(start_i);
-    tcg_gen_brcond_tl(TCG_COND_GE, i, tail_tot, end_i);
-    /* store_1s(-1, vd[vl+i]); */
-    st_fn(tcg_constant_tl(-1), (TCGv_ptr)tail_addr, 0);
-    tcg_gen_addi_tl(tail_addr, tail_addr, esz);
-    tcg_gen_addi_tl(i, i, esz);
-    tcg_gen_br(start_i);
-    /* End of the inner loop. */
-    gen_set_label(end_i);
-    /* Update the counts */
-    tcg_gen_addi_tl(tail_cnt, tail_cnt, max_elems_b);
-    tcg_gen_addi_tl(tail_tot, tail_cnt, max_elems_b);
-    tcg_gen_addi_tl(k, k, 1);
-    tcg_gen_br(start);
-    /* End of the outer loop. */
-    gen_set_label(end);
-
-    return;
-}
+typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
+                                    TCGv, TCGv_env, TCGv_i32);
 
 static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
-                              uint32_t data, DisasContext *s, bool is_load)
+                              uint32_t data, gen_helper_ldst_stride *fn,
+                              DisasContext *s)
 {
-    if (!s->vstart_eq_zero) {
-        return false;
-    }
-
-    TCGv dest = tcg_temp_new();
-
-    uint32_t nf = FIELD_EX32(data, VDATA, NF);
-    uint32_t vm = FIELD_EX32(data, VDATA, VM);
-
-    /* Destination register and mask register */
-    tcg_gen_addi_tl(dest, (TCGv)tcg_env, vreg_ofs(s, vd));
-
-    /*
-     * Select the appropriate load/tore to retrieve data from the vector
-     * register given a specific sew.
-     */
-    static gen_tl_ldst * const ld_fns[4] = {
-        tcg_gen_ld8u_tl, tcg_gen_ld16u_tl,
-        tcg_gen_ld32u_tl, tcg_gen_ld_tl
-    };
-
-    static gen_tl_ldst * const st_fns[4] = {
-        tcg_gen_st8_tl, tcg_gen_st16_tl,
-        tcg_gen_st32_tl, tcg_gen_st_tl
-    };
+    TCGv_ptr dest, mask;
+    TCGv base, stride;
+    TCGv_i32 desc;
 
-    gen_tl_ldst *ld_fn = ld_fns[s->sew];
-    gen_tl_ldst *st_fn = st_fns[s->sew];
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    base = get_gpr(s, rs1, EXT_NONE);
+    stride = get_gpr(s, rs2, EXT_NONE);
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
 
-    if (ld_fn == NULL || st_fn == NULL) {
-        return false;
-    }
+    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
     mark_vs_dirty(s);
 
-    gen_ldst_stride_main_loop(s, dest, rs1, rs2, vm, nf, ld_fn, st_fn, is_load);
-
-    tcg_gen_movi_tl(cpu_vstart, 0);
-
-    /*
-     * Set the tail bytes to 1 if tail agnostic:
-     */
-    if (s->vta != 0 && is_load) {
-        gen_ldst_stride_tail_loop(s, dest, nf, st_fn);
-    }
+    fn(dest, mask, base, stride, tcg_env, desc);
 
     finalize_rvv_inst(s);
     return true;
@@ -1152,6 +898,16 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
 static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
 {
     uint32_t data = 0;
+    gen_helper_ldst_stride *fn;
+    static gen_helper_ldst_stride * const fns[4] = {
+        gen_helper_vlse8_v, gen_helper_vlse16_v,
+        gen_helper_vlse32_v, gen_helper_vlse64_v
+    };
+
+    fn = fns[eew];
+    if (fn == NULL) {
+        return false;
+    }
 
     uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -1159,7 +915,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, true);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1177,13 +933,23 @@ GEN_VEXT_TRANS(vlse64_v, MO_64, rnfvm, ld_stride_op, ld_stride_check)
 static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
 {
     uint32_t data = 0;
+    gen_helper_ldst_stride *fn;
+    static gen_helper_ldst_stride * const fns[4] = {
+        /* masked stride store */
+        gen_helper_vsse8_v,  gen_helper_vsse16_v,
+        gen_helper_vsse32_v,  gen_helper_vsse64_v
+    };
 
     uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
+    fn = fns[eew];
+    if (fn == NULL) {
+        return false;
+    }
 
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, false);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1534,6 +1300,17 @@ GEN_LDST_WHOLE_TRANS(vs8r_v, int8_t, 8, false)
  *** Vector Integer Arithmetic Instructions
  */
 
+/*
+ * MAXSZ returns the maximum vector size can be operated in bytes,
+ * which is used in GVEC IR when vl_eq_vlmax flag is set to true
+ * to accelerate vector operation.
+ */
+static inline uint32_t MAXSZ(DisasContext *s)
+{
+    int max_sz = s->cfg_ptr->vlenb * 8;
+    return max_sz >> (3 - s->lmul);
+}
+
 static bool opivv_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
-- 
2.50.0


