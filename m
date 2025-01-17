Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF06C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLx-0005rK-8m; Fri, 17 Jan 2025 00:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLt-0005dt-I9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:05 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLr-0005zd-Hm
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:05 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21bc1512a63so34458175ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093422; x=1737698222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6lM2xNLozSvm8jm8WlL6BDM9J+pY9xyjORBjGRdbts=;
 b=OgLKGq+a7BVuNQGf+0+RpuBVk2CeNihnSMS4xiFq2JZY04vP7ZAgncRbIjULlVy5RU
 Js3O4MffTeCX+ahuQCQ6yXCcSemfg1S0CKM+8v9Jk+JfZvOow20FLHshSw2S57bgL4xe
 VlpizznZGkKYpDJT49s6isI80Mh5De27GRUEq2rX3VI2wD7aDJjIPSrbLJgM4AdC2ZPy
 MQjbq0O71HG5T7TRwt7RMyu5oU0ZYLqeO6GP6YtV+yboLi7o6irXKDlxgBvqbWlzAu94
 JHeRQ9A5yWj+MH8BVELbGG7PIQmWxxNY89+MmZZ+BOIRauPrFrvCBZsu64fGWi3J0NK8
 hPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093422; x=1737698222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h6lM2xNLozSvm8jm8WlL6BDM9J+pY9xyjORBjGRdbts=;
 b=oCnBK23ylrySbDGXeITSqKP5BFA50RA6S0TCPdeYBjYYWKGU036rjOYgM/VmfUQmf6
 oRT2rFUW9nGjQtM5tDICQBhQVpVbK1l5I11nqxb5B3C9/FHRt9CZf9VvjHpE+7Zn+t4t
 jEUPSm99FHKohqlw/0klz+lNJ5kh2GperlysdkpzmkLIOrLyn3g+29YdgMbAFppGoPBU
 ah4GV6AFz0FiNQpjlv6en0c9wgieSaU8U8wbqpkICfDsYqBQ9htS8gpwYgqS3jQi5neD
 WGg70NubYL1HWHlkLnqbRdWLoy84DBQ+/7E77vcqcvIDkQ3iXfgSPE2wXK9DPpS3lmvP
 SxuA==
X-Gm-Message-State: AOJu0Yxr9jPWBaiKES6yoTNLzCOfu8VvsrcXSlvZxL4PrY+c9tzu3tNj
 l3j4BLTIamXvX/2Kz+8z85PUzhwK3TRLOfZbx5OTUe0voc3xMfwJF1i92g==
X-Gm-Gg: ASbGncvyYlIlx+iXEPNHn7di4Gc2gdKn+DSrOLm3fr5/rZX7jV6X93iOARyO9HcVlp8
 zCRehvuIDxUBlErkhHtN81iObb6Q8qfTlI+qpGnAFnvlU3VtT4zDP1hq/Psk58Uk41H3iKtUVza
 RZY6Q50ASMIr2Nfggx4YGGtoSqYSjcAnQ7cykYRZD1UKZae/gIuU7Aw+qbbyK5GzDGJFgBb9rtr
 qWIa1s2PD+lG+aDaeH07eZCy6C8glaR2giEcGLbMk093k6+H3t8BdGU1Ps6E6Txbcs3+k5Iin22
 LXmD0qxKryDwf8lOcjImBZ3V0tIk51uBNaSBdvbfIHmaYnhy12rc6UiC6s8r
X-Google-Smtp-Source: AGHT+IGlQB2Qjq20yTQYwu1OCF/1bWjOJl8HewXA1Enh1cwDPlhL5PDmBPCtla4Oe83Id8XGswj+mQ==
X-Received: by 2002:a17:902:e802:b0:21b:d105:26b8 with SMTP id
 d9443c01a7336-21c3553b20fmr20647865ad.7.1737093421876; 
 Thu, 16 Jan 2025 21:57:01 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:01 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexey Baturo <baturo.alexey@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/50] target/riscv: Apply pointer masking for virtualized
 memory accesses
Date: Fri, 17 Jan 2025 15:55:20 +1000
Message-ID: <20250117055552.108376-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106102346.1100149-7-baturo.alexey@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h           |  1 +
 target/riscv/internals.h     | 54 ++++++++++++++++++++++++++++++++++++
 target/riscv/cpu_helper.c    | 19 +++++++++++++
 target/riscv/op_helper.c     | 16 +++++------
 target/riscv/vector_helper.c | 21 --------------
 5 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f22e43c662..5e7152200f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -777,6 +777,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 76934eaa7b..67291933f8 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -145,4 +145,58 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
 /* Our implementation of CPUClass::has_work */
 bool riscv_cpu_has_work(CPUState *cs);
 
+/* Zjpm addr masking routine */
+static inline target_ulong adjust_addr_body(CPURISCVState *env,
+                                            target_ulong addr,
+                                            bool is_virt_addr)
+{
+    RISCVPmPmm pmm = PMM_FIELD_DISABLED;
+    uint32_t pmlen = 0;
+    bool signext = false;
+
+    /* do nothing for rv32 mode */
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        return addr;
+    }
+
+    /* get pmm field depending on whether addr is */
+    if (is_virt_addr) {
+        pmm = riscv_pm_get_virt_pmm(env);
+    } else {
+        pmm = riscv_pm_get_pmm(env);
+    }
+
+    /* if pointer masking is disabled, return original addr */
+    if (pmm == PMM_FIELD_DISABLED) {
+        return addr;
+    }
+
+    if (!is_virt_addr) {
+        signext = riscv_cpu_virt_mem_enabled(env);
+    }
+    addr = addr << pmlen;
+    pmlen = riscv_pm_get_pmlen(pmm);
+
+    /* sign/zero extend masked address by N-1 bit */
+    if (signext) {
+        addr = (target_long)addr >> pmlen;
+    } else {
+        addr = addr >> pmlen;
+    }
+
+    return addr;
+}
+
+static inline target_ulong adjust_addr(CPURISCVState *env,
+                                       target_ulong addr)
+{
+    return adjust_addr_body(env, addr, false);
+}
+
+static inline target_ulong adjust_addr_virt(CPURISCVState *env,
+                                            target_ulong addr)
+{
+    return adjust_addr_body(env, addr, true);
+}
+
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8728541b99..2e307e4ea5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -263,6 +263,25 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 #endif
 }
 
+RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    int priv_mode = cpu_address_mode(env);
+
+    if (priv_mode == PRV_U) {
+        return get_field(env->hstatus, HSTATUS_HUPMM);
+    } else {
+        if (get_field(env->hstatus, HSTATUS_SPVP)) {
+            return get_field(env->henvcfg, HENVCFG_PMM);
+        } else {
+            return get_field(env->senvcfg, SENVCFG_PMM);
+        }
+    }
+#else
+    return PMM_FIELD_DISABLED;
+#endif
+}
+
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 29de8eb43d..952ef8b3ec 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -479,7 +479,7 @@ target_ulong helper_hyp_hlv_bu(CPURISCVState *env, target_ulong addr)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
 
-    return cpu_ldb_mmu(env, addr, oi, ra);
+    return cpu_ldb_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
 
 target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
@@ -488,7 +488,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_TEUW, mmu_idx);
 
-    return cpu_ldw_mmu(env, addr, oi, ra);
+    return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
 
 target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
@@ -497,7 +497,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_TEUL, mmu_idx);
 
-    return cpu_ldl_mmu(env, addr, oi, ra);
+    return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
 
 target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
@@ -506,7 +506,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_TEUQ, mmu_idx);
 
-    return cpu_ldq_mmu(env, addr, oi, ra);
+    return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
 
 void helper_hyp_hsv_b(CPURISCVState *env, target_ulong addr, target_ulong val)
@@ -515,7 +515,7 @@ void helper_hyp_hsv_b(CPURISCVState *env, target_ulong addr, target_ulong val)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
 
-    cpu_stb_mmu(env, addr, val, oi, ra);
+    cpu_stb_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
 
 void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
@@ -524,7 +524,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_TEUW, mmu_idx);
 
-    cpu_stw_mmu(env, addr, val, oi, ra);
+    cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
 
 void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
@@ -533,7 +533,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_TEUL, mmu_idx);
 
-    cpu_stl_mmu(env, addr, val, oi, ra);
+    cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
 
 void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
@@ -542,7 +542,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_TEUQ, mmu_idx);
 
-    cpu_stq_mmu(env, addr, val, oi, ra);
+    cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
 
 /*
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 0eea124b66..5386e3b97c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -105,27 +105,6 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
     return scale < 0 ? vlenb >> -scale : vlenb << scale;
 }
 
-static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
-{
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        return addr;
-    }
-    RISCVPmPmm pmm = riscv_pm_get_pmm(env);
-    if (pmm == PMM_FIELD_DISABLED) {
-        return addr;
-    }
-    int pmlen = riscv_pm_get_pmlen(pmm);
-    bool signext = riscv_cpu_virt_mem_enabled(env);
-    addr = addr << pmlen;
-    /* sign/zero extend masked address by N-1 bit */
-    if (signext) {
-        addr = (target_long)addr >> pmlen;
-    } else {
-        addr = addr >> pmlen;
-    }
-    return addr;
-}
-
 /*
  * This function checks watchpoint before real load operation.
  *
-- 
2.47.1


