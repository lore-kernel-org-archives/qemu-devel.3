Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34D5FE5204
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDlj-0005P7-Tg; Fri, 24 Apr 2026 06:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wGDlh-0005NR-87
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:28:17 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wGDlf-0006QX-Gv
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:28:16 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c7973f67f4dso2348540a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777026493; x=1777631293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcVpuiJ5LFLZKYUjyh6wh8FSJ9K2QaQPRuEkCV8Ke78=;
 b=mh6thZfyyTR7zqnaGjQLbjP4GtIlcnHEs9RQZPyDit5UL7RspGzVzHjB1snFLVZDJN
 eAesP14aZVzlImCSbWHS4gJnzrgN0G4N/NeoIn0Hrhs7bbyYJe/v4UcZtYuLrnwEk7xj
 pB5QOWAYpPLkAXQWSBp8UjjISZVPbzEW7PuBfKZVwq62Zqsz8OC7rSpmUVSeB45E4pB3
 /uU6r7dssTw8Ia8T7t9igktLKME6zfPrGX8llCTEDTc2SCFSQKtYDo/jIqeb1bhBl8ar
 sPztLRK/zg267G8qWLyfJ0RLIfFQDrc6z+IBoiYgUNdZCxWfcUQfKTq+CkUxEBw7zrLY
 5TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026493; x=1777631293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bcVpuiJ5LFLZKYUjyh6wh8FSJ9K2QaQPRuEkCV8Ke78=;
 b=UCuNn7nVqDhgE1drk6r2DvJwwKjWt6mH7ZnvxfBpJZnmKhD2JVXunbKJSgHqxVCwNc
 cLEPTkrcMrJwRhECPLBgKiYtLZWn8kC6ep00ShF0FvjSb9RKRNdpgzqqJMQ1KVDHZyVn
 9K3iNnDnhIN7tNiOMoFb2l6jda8Lq7cXsqiSamEZgaJPKF2J3GuEsn3CuaRprcEB3pra
 QgXlOz4VpIwX+G1LwPCXQSMBxfMWgInwykHA8dQlsl2qmt/lnjcM4OlJxJn4s/Op5DLN
 tzTzk4NtgiWKljzCL7nGzXdQurCXPCamz8ZKPO7SPgdivhU5iolSGGVKHphqNWqLmv0w
 7VkQ==
X-Gm-Message-State: AOJu0YxRMQMuBtJuLcplqJRUvp2CY8SUiFZKE2td2yTEdY96GjmWcb6H
 KUQYzLA+TBjalm3yU1HV0dJgktIc16egHdrZmNN5Fuf9Yv5wWFxRVHuV3DrQI2Fqbb0dkZe1pXp
 gA2agoyZcmrogqt1emBZ5ZUWBtC24cv7Mjeb+u+4oD1TX/JLbpLv0sdXGFdJG3mTyOaIZY0DF+u
 8icpmDEq700YgNrSF5300dwEXK27GRhwKCGh9EPcBDhfvrKcWv
X-Gm-Gg: AeBDietroxZzmTeQk9goNiv1o3vsUZwV6nXOAZtAbRCyEwSBVcREVRKAYoyLHauly0d
 asYa5HqWUldJApjGc+gj/WaOzPmKbRNNbxE7Ep3gkZ6oOw4AVC+Xxyo9wJfYFM2b5PaEca8g9O9
 y7CGTw5p1bu0L/OO8vLrSQgtoc49OE0j0FsQ14i2YlesIZAmqUaLgRGYBqtVnDpE/i0VI9ECFIZ
 GQcwNrBRfIdER16wjMOxBFHbgzDIb986e3r7IlRvizUSNjlDX+R/KFbNs9Ps5FZIVvEY/IRFIIq
 Yw3yiljMVwi6Y7yBiAgmvyLRz6w91F3JlShnEX9IghgCNsxl+Ye5g8yYupUSMmzXcAZtdJuW+eQ
 QWovLMShpZz1HchdYLB4LdGFFuPtUZ9wFccwjkDqO/4fpOWBCL9dJrAAZRziqAZCxcGqNVp1KA1
 jmTjsUMAt749T2kQymxvCc8F05Qge/oEMLa4P/4986Ne1OHyORLYs8Vu+HnBQ4
X-Received: by 2002:a17:902:e748:b0:2b4:5d0c:7a85 with SMTP id
 d9443c01a7336-2b5f9dbcd42mr291227995ad.3.1777026493268; 
 Fri, 24 Apr 2026 03:28:13 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0c17esm218889585ad.41.2026.04.24.03.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 03:28:12 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 3/4] target/riscv: Support raising misaligned exceptions for
 vector loads/stores
Date: Fri, 24 Apr 2026 18:27:59 +0800
Message-ID: <20260424102800.24022-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424102800.24022-1-frank.chang@sifive.com>
References: <20260424102800.24022-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/insn_trans/trans_rvv.c.inc |  3 +-
 target/riscv/vector_helper.c            | 82 ++++++++++++++++++++-----
 2 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 5b72926b3c1..c8f106c0bab 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1190,9 +1190,10 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
      * Update vstart with the number of processed elements.
      * Use the helper function if either:
      * - vstart is not 0.
+     * - Zicclsm is disabled, so misaligned accesses could trap.
      */
 
-    bool use_helper_fn = !s->vstart_eq_zero;
+    bool use_helper_fn = !s->vstart_eq_zero || !s->cfg_ptr->ext_zicclsm;
 
     if (!use_helper_fn) {
         uint32_t size = s->cfg_ptr->vlenb * nf;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 538168efc9b..f74f73f046d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -200,20 +200,51 @@ static inline void vext_set_elem_mask(void *v0, int index,
     ((uint64_t *)v0)[idx] = deposit64(old, pos, 1, value);
 }
 
+static MemOpIdx vext_make_memop_idx(CPURISCVState *env, size_t size)
+{
+    int mmu_idx = riscv_env_mmu_index(env, false);
+    MemOp memop;
+
+    switch (size) {
+    case 1:
+        memop = MO_UB;
+        break;
+    case 2:
+        memop = MO_LEUW;
+        break;
+    case 4:
+        memop = MO_LEUL;
+        break;
+    case 8:
+        memop = MO_LEUQ;
+        break;
+    default:
+        g_assert_not_reached();
+    }
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
@@ -221,20 +252,27 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
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
+
+GEN_VEXT_HOST_LD_ELEM(lde_b, uint8_t,  H1, ldub)
+GEN_VEXT_HOST_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
+GEN_VEXT_HOST_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
+GEN_VEXT_HOST_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
 
-#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)             \
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
@@ -242,10 +280,15 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
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
@@ -393,7 +436,16 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
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


