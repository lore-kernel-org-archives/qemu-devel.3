Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501160A2601
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IgUVlDMa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU5H4-0007Cn-OQ; Thu, 19 Nov 2026 11:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <suunj1331@gmail.com>)
 id 1xU5GF-0006xn-LE
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:45:31 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <suunj1331@gmail.com>)
 id 1xU5GD-0002HE-Pi
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:45:23 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2f03f3631b2so1440665ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795106717; x=1795711517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F+vTdlEcO95w4+Q9PuTnB5fNd37gsUGFZSnENPIy89U=;
 b=IgUVlDMaWEbSI6m7qJ4UhhrvCU81XHP1q9SWtWG+TMP3x0C2hNNGWUoA/fVemVyMWU
 lNjMI+8MTjxMVgC99d4t3g44IEqnq/oDOTKz2IjRWpwRAZr3CjvmZUrA7ALWTl/Gs3rp
 MUQcX7XxyJML2gpoqfEoD7PCaSTuowrzBITBOSIGC63Oq0q0Szqtg1s2L/taIDtUN539
 vhRI3ahZ5kXK0gQxM0qYT7KqBlErkILQza8wHUmXcEA1FEkkJTZeW1MOobXJz39TcRXI
 4UnyrH8V+//QghYtZtnd/ifc8rJVa8UIoYG3ndevFAr9COAB1inVtUhJeWfI1gAfqTfZ
 QBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795106717; x=1795711517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F+vTdlEcO95w4+Q9PuTnB5fNd37gsUGFZSnENPIy89U=;
 b=aA64vv6QLhrhT0tkNpxoM12c5Z8DBRVq1A3WsLvM8bohUI+5DNehY8wkAHgkROJELd
 bJ9zuGmbib802zPa4vpQ4I/qMbxXVtPSe7gtKkqzIfoVAoa3Jsue26EMhLGk/xZdqica
 4gEUNS1OwhgcAwHMymicOHV1qbYEk6Lcapf1Fk5LLMa2P9PhEFdxAtXRafXHsZTvokTx
 hFgvUrL6koWms1xXGKmqEzTjZaU6m/Eu2+j4YdVXaffMtmDP9BeEAQIukOFXs9LwytQ3
 HBHJO6Bi5cDO+GONJ6YNKI2j9QrkUtVzZuDrcYtV6uEm8vZxmfr+Y4btoYYq/v7unayo
 V6Zg==
X-Gm-Message-State: APuU4Z+lGXDh/5RtFGpLTFtKssBK3LdXe/XxzPl3vfcCHDUlly6HC9NB
 JSlGIvmzcMS/AWZwxlt893QIF1mxVtjy+eN66Hm+QC7uc6pDzRMAkkh5qq1V3g==
X-Gm-Gg: AZFdTZe7u2O+d6oc6SP0gVRRG1z8+WpcSGyF6TmYPWU+Nvyhr0GtKcVDc2sA4z4In5s
 jxAOSdccjInCy2HGugZ8wsU5DpIC7wzdppNWPrYl72411s+S7/pY0yoZUpCfi1laJmGR00yyP0D
 yfh/1ZMcdMxdr8f2+1TgvJLWQaSAE34x9bAi3gxEcOHu8eccEDs2s8//HUYy7M3q+qKXsnQiD+Z
 L5jaHiOFr9ol8TtEWXykoxRAUsBKKePrP2XP7n9dgcHZ0vG3L8gPpw9H1AMQtM8KC/oAqzWp1Xt
 Ku6twZXwJfwDyBf5YXQC19URvSAoc01ahz23OUyXgHZhAkiGcFtEGE5lGva3WKMi8ERn0GPs7YL
 EpeXoDxHshfXe/n141e2f/jVIr+Gr4IaLbtURA0mfk7HgYmFAWtc3tlqYbpP5HEK6V30D1Vvgww
 opFtDAAEvxoCvxnUZ7lhW/1p4pG8yktVR7q3yTBr9yye4zCL+iCNcSV3mxtdijDiW275UHaLIGZ
 8aOXN/C5GNNUI8JqPP+Fza+CqE/kImKj2gbJrMJQEnMvkLq7UFgNgrTHu6qW+ty3r/4BDdjsVLo
 uv3+ZqtIQLzEnYnqY9RN9uBO0hZ+u3tC5tm/oScRilr2NjG2ytVH
X-Received: by 2002:a17:902:cf12:b0:2f0:2b94:c808 with SMTP id
 d9443c01a7336-2f03f24020dmr3738575ad.49.1795106717431; 
 Thu, 19 Nov 2026 08:45:17 -0800 (PST)
Received: from fedora ([61.74.238.173]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f10e67csm2381365ad.53.2026.11.19.08.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:45:16 -0800 (PST)
From: SeungJu Cheon <suunj1331@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 3/3] target/riscv: Rely on cached TB flags in
 riscv_get_tb_cpu_state
Date: Fri, 20 Nov 2026 01:44:38 +0900
Message-ID: <20261119164438.193579-4-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119164438.193579-1-suunj1331@gmail.com>
References: <20261119164438.193579-1-suunj1331@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=suunj1331@gmail.com; helo=mail-pl1-x62a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the cached TB flags and VLMAX on each lookup. Compare the current
vl with vlmax_cached when setting VL_EQ_VLMAX, since fault-only-first
loads can reduce vl without triggering a cache rebuild.

With CONFIG_DEBUG_TCG, recompute the cached values on each lookup.
If they differ, report the cached and recomputed values and abort.

The profile below is from a Linux boot and power-off on an RV64 virt
machine with one vCPU pinned to a host core. The table shows perf self
overhead in the vCPU thread. The profiles contain 57,013 samples before
and 47,942 after; percentages are relative to each profile.

  Symbol                       Before    After
  riscv_get_tb_cpu_state       16.54%    6.78%
  helper_lookup_tb_ptr         11.30%   12.59%
  riscv_pm_get_pmm              1.89%    0.09%
  riscv_env_mmu_index           1.62%    0.18%
  riscv_cpu_virt_mem_enabled    1.45%    0.09%
  riscv_rebuild_tb_flags            -    0.67%

riscv_rebuild_tb_flags does not exist before this series. The share
of helper_lookup_tb_ptr rises because the total shrinks; its sample
count falls from about 6,440 to about 6,040.

Median boot time fell from 5.69 s to 4.81 s (-15.5%) over five runs
per binary, alternating between the two binaries.

Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 target/riscv/tcg/tcg-cpu.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a8e744bc26..22c8eafbc7 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -100,11 +100,13 @@ static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
 }
 
 /*
- * Compute the TB flags that depend only on state changed through CSR
- * writes, traps, privilege changes and vsetvl.  For now the result is
- * fed straight back to riscv_get_tb_cpu_state(), which adds the bits
- * that translated code changes between two lookups -- FS/VS dirtying,
- * elp, vstart, and vl, which fault-only-first loads shrink.
+ * Most TB flags depend only on state that changes through CSR writes,
+ * traps, privilege changes and vsetvl, so compute them once at those
+ * points and keep them in env (see riscv_rebuild_tb_flags() callers).
+ * This mirrors arm_rebuild_hflags().  The bits that translated code
+ * changes directly between two lookups -- FS/VS dirtying, elp, vstart,
+ * and vl, which fault-only-first loads shrink -- are added by
+ * riscv_get_tb_cpu_state() on each lookup.
  */
 static void riscv_compute_tb_flags(CPURISCVState *env, uint32_t *pflags,
                                    uint64_t *pext_flags, uint32_t *pvlmax)
@@ -195,16 +197,29 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     CPURISCVState *env = cpu_env(cs);
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
-    uint32_t flags, vlmax;
-    uint64_t ext_flags;
-
-    riscv_compute_tb_flags(env, &flags, &ext_flags, &vlmax);
+    uint32_t flags = env->tb_flags_cached;
+    uint64_t ext_flags = env->ext_tb_flags_cached;
+
+#ifdef CONFIG_DEBUG_TCG
+    {
+        uint32_t f, v;
+        uint64_t e;
+
+        /* Catch a state change that did not rebuild the cached flags. */
+        riscv_compute_tb_flags(env, &f, &e, &v);
+        if (f != flags || e != ext_flags || v != env->vlmax_cached) {
+            cpu_abort(cs, "stale TB flags: cached %08x/%016" PRIx64 "/%u, "
+                      "recomputed %08x/%016" PRIx64 "/%u\n",
+                      flags, ext_flags, env->vlmax_cached, f, e, v);
+        }
+    }
+#endif
 
     if (cpu->cfg.ext_zve32x) {
         bool vstart_eq_zero = env->vstart == 0;
 
         flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX,
-                           vstart_eq_zero && env->vl == vlmax);
+                           vstart_eq_zero && env->vl == env->vlmax_cached);
         flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, vstart_eq_zero);
     }
 
-- 
2.52.0


