Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B158C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1pb-0003Zl-18; Tue, 07 Jul 2026 05:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wh1pZ-0003Z1-0J
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:11:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wh1pX-0002HB-4b
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:11:04 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so4406285e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783415462; x=1784020262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PD6VgqLxjb6wWjSJyDflTN+LGJInBMBFIIvd/XvIVpw=;
 b=EhpN+Qjdz6HR1fEaQRbc2Rgnz9Cxriqx8iCpRU6HfdPq47TzArB/AHb+CySForyXip
 tmtDa/f6O0t9mw9N2N7iTYB19F7ULtoH8dVOyO01wOuMr+FQ0XyYVDgzPkbElsfSiXgW
 PNNWItkIHlWGy8qJ3UXEUg3Fn2X6twST6lZv4/i3pQGdntRSe37dvrGiORtVsSHUA0yE
 FHHvKj8vEOiWX1jhZCP7NmjONPQk0G9QLv/ksKaals1gpADV2+mT49tQM09juYr+ZFWQ
 htGQA1FJ/5iJQVkTld2bFzKRhBSh5BV1tIWUA12SImDewt7G+nAHEMp1rLFl3dyZUZdC
 gMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783415462; x=1784020262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PD6VgqLxjb6wWjSJyDflTN+LGJInBMBFIIvd/XvIVpw=;
 b=k3NsHsWoJHH9jKnG9J7UaAofBg4KLzMS53t8HSb9GU8obXElPvBzM9AOkbi4lWR+zJ
 MW/0CtyaDmbNT5lnPtFu/xa1SC7WJ/6oDfUSQaiFv1xmKFU+pOesE1GM5Y32xuD93Dqp
 9FEJ6sq3XZJeO9OIryxMBFX2ZrCzyhTWuomWHP6mKP8vjyUKLCHvvHN1mcm+RoF5Vsl+
 sx1ypjj5UWHIKwE6BxaSgihbxgGbnQYFb6mvXZR6fuWRe8MIfVkJ/jchIt3/khZhBV4k
 Sr71m3w/4RnXbLMpsdHVVEmcdf6Pms6Xeb2TqBNft85OEXf0v0v15SwxocKHSaLfoptV
 wqvA==
X-Gm-Message-State: AOJu0YyftbfbKnFuOlkg4nYpzujpeYRWl/u5QELZfhmgo9809C9lagvf
 nPyOQbwsU3DKz/RCvG9+Aqrd6b1w0TQ6X241nvO8mK0nkRiOfiOsKKWCCY8yteOUJ4LZaBoVQ5r
 5OUK1PfOjPrzkbbNCFZ4gkiSJtW/0RZLnH1nj5mwzGsEVdtMi85+XhaPXZJ8wDRv3iHqLCWIYwS
 2QCPc+AwxrZCJP1FXXy9F1HnW6HRCffovyrHGTHKDTzVvD5noV
X-Gm-Gg: AfdE7cn5M8BPHe8Uu+/sdaZhX2VX5sw7a2j5yBIjViM42eccZOpgq4q4xvQxDCy75F7
 dcU7HZCFzq2uf7sr3+rnatzSY8HtOW+Cb+TDEvbHkWOMi1R+NfZs0Boy7RYwOT5QshCVMBfd5m7
 qy1l6wY4qJwZDnWMW7Ukmwzq5hFKsgoOYEbwv4NvycBSHbgllzXtv+yoNDI1Vg4IeiXJA/5WS0v
 i4DcX+3gt0UvRGVWSTlx7IFN92QvXYMnAsaZKZ/FXgdKy+qNcEgyHoyA5h6DCJwgjjRK+fMyU3c
 WLz1v+jA/P3gBDNbobhRKGabWNhjUGk+BHS6fsou+qSouHacPGJGxGLx+ker8+nsxLod4g0dVC5
 RdHoKD+jytdKmvtsQD1yGaeC8JvXCuY5Z3oAOIU9ihgMFvERzhzKmDCGViII1N6yRVl61B32rJQ
 yPPNCXFPfYGS/eSvAJ9iUQFuFA9jUvqfuWsq5m1OE=
X-Received: by 2002:a05:600c:37c3:b0:493:bee0:4360 with SMTP id
 5b1f17b1804b1-493e10217d6mr18064775e9.17.1783415461540; 
 Tue, 07 Jul 2026 02:11:01 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f32660sm41004665e9.2.2026.07.07.02.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 02:11:01 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 3/6] target/riscv: Support raising misaligned exceptions
 for vector loads/stores
Date: Tue,  7 Jul 2026 17:10:36 +0800
Message-ID: <20260707091039.2574638-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707091039.2574638-1-frank.chang@sifive.com>
References: <20260707091039.2574638-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=frank.chang@sifive.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Frank Chang <frank.chang@sifive.com>

When the Zicclsm extension is not enabled, raise misaligned load/store
exceptions for misaligned accesses from vector load/store instructions.

We will skip the host fast-path and fall back to the slow TLB-path to
raise misaligned load/store exceptions for the misaligned accesses when
Zicclsm extension is disabled.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++--
 target/riscv/vector_helper.c            | 65 +++++++++++++++++++------
 2 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 23262b1d036..a22e2cae6ce 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1191,26 +1191,38 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
      * Use the helper function if either:
      * - vstart is not 0.
      */
-
     bool use_helper_fn = !s->vstart_eq_zero;
 
     if (!use_helper_fn) {
         uint32_t size = s->cfg_ptr->vlenb * nf;
         TCGv_i64 t8 = tcg_temp_new_i64();
         MemOp atomicity = MO_ATOM_NONE;
+        MemOp alignment = MO_UNALN;
+
+        /*
+         * If Zicclsm is disabled, require alignment based on element size.
+         * Use MO_ALIGN_* based on log2_esz (0 = MO_UNALN, 1 = MO_ALIGN_2, etc).
+         */
+        if (!s->cfg_ptr->ext_zicclsm) {
+            alignment = log2_esz << MO_ASHIFT;
+        }
+
         if (log2_esz == 0) {
             atomicity = MO_ATOM_NONE;
         } else {
             atomicity = MO_ATOM_IFALIGN_PAIR;
         }
+
         for (int i = 0; i < size; i += 8) {
             TCGv addr = get_address(s, rs1, i);
             if (is_load) {
-                tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
+                tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx,
+                                    MO_LEUQ | atomicity | alignment);
                 tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
             } else {
                 tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
-                tcg_gen_qemu_st_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
+                tcg_gen_qemu_st_i64(t8, addr, s->mem_idx,
+                                    MO_LEUQ | atomicity | alignment);
             }
             if (i == size - 8) {
                 tcg_gen_movi_i32(cpu_vstart, 0);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e321ca26161..e28d8a3d9fd 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -199,20 +199,34 @@ static inline void vext_set_elem_mask(void *v0, int index,
     ((uint64_t *)v0)[idx] = deposit64(old, pos, 1, value);
 }
 
+static inline MemOpIdx vext_make_memop_idx(CPURISCVState *env, size_t size)
+{
+    int mmu_idx = riscv_env_mmu_index(env, false);
+    MemOp memop = size_memop(size) | mo_endian_env(env);
+
+    if (!riscv_cpu_cfg(env)->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
+
+    return make_memop_idx(memop, mmu_idx);
+}
+
 /* elements operations for load and store */
 typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
                                    uint32_t idx, void *vd, uintptr_t retaddr);
 typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
 
-#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)             \
+#define GEN_VEXT_TLB_LD_ELEM(NAME, ETYPE, H, LDSUF)         \
 static inline QEMU_ALWAYS_INLINE                            \
 void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
                 uint32_t idx, void *vd, uintptr_t retaddr)  \
 {                                                           \
     ETYPE *cur = ((ETYPE *)vd + H(idx));                    \
-    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);       \
+    MemOpIdx oi = vext_make_memop_idx(env, sizeof(ETYPE));  \
+    *cur = cpu_##LDSUF##_mmu(env, addr, oi, retaddr);       \
 }                                                           \
-                                                            \
+
+#define GEN_VEXT_HOST_LD_ELEM(NAME, ETYPE, H, LDSUF)        \
 static inline QEMU_ALWAYS_INLINE                            \
 void NAME##_host(void *vd, uint32_t idx, void *host)        \
 {                                                           \
@@ -220,20 +234,27 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
     *cur = (ETYPE)LDSUF##_p(host);                          \
 }
 
-GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
-GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
-GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
-GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
+GEN_VEXT_TLB_LD_ELEM(lde_b, uint8_t,  H1, ldb)
+GEN_VEXT_TLB_LD_ELEM(lde_h, uint16_t, H2, ldw)
+GEN_VEXT_TLB_LD_ELEM(lde_w, uint32_t, H4, ldl)
+GEN_VEXT_TLB_LD_ELEM(lde_d, uint64_t, H8, ldq)
 
-#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)             \
+GEN_VEXT_HOST_LD_ELEM(lde_b, uint8_t,  H1, ldub)
+GEN_VEXT_HOST_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
+GEN_VEXT_HOST_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
+GEN_VEXT_HOST_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
+
+#define GEN_VEXT_TLB_ST_ELEM(NAME, ETYPE, H, STSUF)         \
 static inline QEMU_ALWAYS_INLINE                            \
 void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
                 uint32_t idx, void *vd, uintptr_t retaddr)  \
 {                                                           \
     ETYPE data = *((ETYPE *)vd + H(idx));                   \
-    cpu_##STSUF##_data_ra(env, addr, data, retaddr);        \
+    MemOpIdx oi = vext_make_memop_idx(env, sizeof(ETYPE));  \
+    cpu_##STSUF##_mmu(env, addr, data, oi, retaddr);        \
 }                                                           \
-                                                            \
+
+#define GEN_VEXT_HOST_ST_ELEM(NAME, ETYPE, H, STSUF)        \
 static inline QEMU_ALWAYS_INLINE                            \
 void NAME##_host(void *vd, uint32_t idx, void *host)        \
 {                                                           \
@@ -241,10 +262,15 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
     STSUF##_p(host, data);                                  \
 }
 
-GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
-GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw_le)
-GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl_le)
-GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq_le)
+GEN_VEXT_TLB_ST_ELEM(ste_b, uint8_t,  H1, stb)
+GEN_VEXT_TLB_ST_ELEM(ste_h, uint16_t, H2, stw)
+GEN_VEXT_TLB_ST_ELEM(ste_w, uint32_t, H4, stl)
+GEN_VEXT_TLB_ST_ELEM(ste_d, uint64_t, H8, stq)
+
+GEN_VEXT_HOST_ST_ELEM(ste_b, uint8_t,  H1, stb)
+GEN_VEXT_HOST_ST_ELEM(ste_h, uint16_t, H2, stw_le)
+GEN_VEXT_HOST_ST_ELEM(ste_w, uint32_t, H4, stl_le)
+GEN_VEXT_HOST_ST_ELEM(ste_d, uint64_t, H8, stq_le)
 
 static inline QEMU_ALWAYS_INLINE void
 vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
@@ -398,7 +424,16 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &flags,
                 true);
 
-    if (flags == 0) {
+    bool misaligned = addr & (esz - 1);
+
+    /*
+     * Allow the host fast-pash when:
+     *   1. Page permission/pmp/watchpoint are checked and we have a contigous
+     *      host mapping.
+     *   2. Zicclsm is enabled or load/store is not a misaligned access.
+     * Otherwise, we will fall back to the slow TLB-path.
+     */
+    if (flags == 0 && (riscv_cpu_cfg(env)->ext_zicclsm || !misaligned)) {
         if (nf == 1) {
             vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vstart,
                                       host, esz, is_load);
-- 
2.43.0


