Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEA5C5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKo-0007Qe-0B; Sat, 15 Aug 2026 15:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKj-0007KD-6d
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:21 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKh-0008Lk-0j
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d5335cf904so11077445ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823178; x=1787427978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HEmanzey66AM32+Ka5lo5pqmPx+R0ZxDJxeFbZuCuhU=;
 b=rx7+pkXEX7ktDiXbmz3tiskY/UKvR8R2DSX+tKhhoPLhFwlutDQiGnSMqGBgVUm5HG
 ZziMc+r4G90cCEElITJnkiyBZHRXhLPQRXy57ax2zZtbtb5FyTTwKH8SnDlNi/xcj34W
 V3fVEiySecq6BdZfxDst1OUUGvvV/xyrjMrgPGV4VbQTpMBuvfUAXjQO0GFtZf17ioEN
 /asR86UrIAkaUJ95sYfInAmfRhVoRsc0jkbVf5b2PhuFC/uYFq+z47IdQJK2wuA32s+A
 IbU7qcXHVH+Sipv5jiBpUW5AYnIY0wFZ0Uc275SkkY6xGWlr6D3rcEJALituX3qluGWm
 9NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823178; x=1787427978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HEmanzey66AM32+Ka5lo5pqmPx+R0ZxDJxeFbZuCuhU=;
 b=A5gCpv5doKJVIGlr4hMxj0FUSyFT0kQiiydV+FHtR+O97SrkBc2byVLLVdNfDqUobD
 K9j/bZq/eWwxBOJ1WeNurCBc00uYJwOCKYIyXi/kzJ9zJMlNRlu2SGHc3hTifgejhLCz
 pLe8ByE9cxO2D08K7HY0D8Oh3uklgm+kvccE+XhhOzIvS0q5cHngvs8E9IyoJPBn6qoy
 QxNEUfAR+4kxBxtKp4kDb12cOOqJ5N8jfrRphex7LhVJ/ITp6SBcWe8Pfek95CA1USc9
 5UtSk4BCtKDzfm68OAsbPlsZVLu+B55mDZtFrD9EXaA2wvGcBZd2q3ylr4lm7DTriUCR
 5k6Q==
X-Gm-Message-State: AOJu0YzNF09/w45eHXaV9nS0iliJbBUB0SE5w+tuJejLbM3We6GyOw3q
 mGTlzU6bJGURRNfT4RgnHQLzhP8ZGgsLSalCZMbJaZxHnZt/Iy+WYJ+8DzNxTGRpkC4msjP/CRk
 nuc0g
X-Gm-Gg: AR+sD12Oabhhzb78v4UWkZo5Ms4BhduGya0qiXuMJc2/RukdmU1mrtETl7R2p2dhOHW
 beZX6h0z6XwE4KJOqfsel3OHJRAqzygqZkjg3doF9ftn/zuNFl9x9/atfa7q8adn1jiHIe/RGhp
 cYViKfJehKHP5wslVI4nAUE8gBBFSKt/iYIbQ5yels6G7qv/SjXMIEyncYsIu6C1pjFv4MSH77w
 8GZSR1m/ZGNDxqF1d91glZeEZC/4+wg25f11K5RSd1dAuNlPRZJzjGbSYwazWIlGO2cPyxWdVv/
 9+Jb2/Lrnj5UUXQoEvIInowbT4hiXHfNbtCW7RKPltiGvU/N1uE6/t9JYsXzYRgEB1GfTbt4tUi
 W0qs2egUvsSZm26Rh15PvtLOljSVDmq0rMSdYEp61SPQcll3ceINfZXayaISHEoY+zseRu5yptu
 LcXC1CXq8UqnjmEaizMzoaJHRyGQ8uCr2pnnSPq3eJgCfr6iFyabXCk5bRkwUw8IxIXObVA0ur0
 63ajgCTt486QlRToJ7H
X-Received: by 2002:a17:903:2c8:b0:2ca:e5c:7fcf with SMTP id
 d9443c01a7336-2d3b08014f7mr182553535ad.3.1786823177576; 
 Sat, 15 Aug 2026 12:46:17 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 17/23] target/riscv: Pass MemOpIdx to vext_ldst_us
Date: Sat, 15 Aug 2026 12:45:42 -0700
Message-ID: <20260815194549.1377505-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Use mmu data passed in with VDATA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 178ed32429..5ead4cd6fe 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -158,6 +158,19 @@ static inline void vext_set_elem_mask(void *v0, int index,
     ((uint64_t *)v0)[idx] = deposit64(old, pos, 1, value);
 }
 
+static inline MemOpIdx vext_oi(uint32_t desc, MemOp memop)
+{
+    uint32_t data = simd_data(desc);
+
+    if (FIELD_EX32(simd_data(desc), VDATA, BSWAP)) {
+        memop |= MO_BSWAP;
+    }
+    if (FIELD_EX32(simd_data(desc), VDATA, ALIGN)) {
+        memop |= MO_ALIGN;
+    }
+    return make_memop_idx(memop, FIELD_EX32(data, VDATA, MEM_IDX));
+}
+
 static inline MemOpIdx vext_make_memop_idx(CPURISCVState *env, size_t size)
 {
     int mmu_idx = riscv_env_mmu_index(env, false);
@@ -412,12 +425,12 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env,
              uint32_t max_elems, bool vma,
              vext_ldst_elem_fn_tlb *ldst_tlb,
              vext_ldst_elem_fn_host *ldst_host,
-             uintptr_t ra, bool is_load)
+             uintptr_t ra, bool is_load, MemOpIdx oi)
 {
     target_ulong elems, addr, last, last_in_page, page_split;
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
-    int mmu_index = riscv_env_mmu_index(env, false);
+    int mmu_index = get_mmuidx(oi);
     MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
     uint32_t i = env->vstart;
     void *host;
@@ -515,7 +528,8 @@ vext_ldst_us_desc(void *vd, target_ulong base, CPURISCVState *env,
 {
     vext_ldst_us(vd, base, env, log2_esz, vext_nf(desc), evl,
                  vext_max_elems(desc, log2_esz), vext_vma(desc),
-                 ldst_tlb, ldst_host, ra, is_load);
+                 ldst_tlb, ldst_host, ra, is_load,
+                 vext_oi(desc, log2_esz));
 }
 
 /*
@@ -958,7 +972,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t evl = (riscv_cpu_cfg(env)->vlenb * vext_nf(desc)) >> log2_esz;
 
     vext_ldst_us(vd, base, env, log2_esz, 1, evl, evl, false,
-                 ldst_tlb, ldst_host, ra, is_load);
+                 ldst_tlb, ldst_host, ra, is_load,
+                 vext_oi(desc, log2_esz));
 }
 
 #define GEN_VEXT_LD_WHOLE(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)   \
-- 
2.43.0


