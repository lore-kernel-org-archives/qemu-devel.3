Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF94FCDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 17:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqyGa-0007r4-C3; Wed, 18 Sep 2024 13:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sqyGY-0007kK-Mb
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:14:58 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sqyGT-0001uY-9s
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:14:58 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2d89dbb60bdso3490a91.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1726679691; x=1727284491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e21ToE/HJXzkFx4begXiNagynBpQzCVjg3pkA/vtkjA=;
 b=UTZsMiXteZSlapUNpGnwo9hu8bMhLKXSguavjagt8DeExLw3QnH20bhx5OC02QdsDP
 /hPHCPrtSaUlgH4/+H4fg1w8ja3peG7OvErxjJufn9K6k0yeut1TU3U3uKZusQVeAsdq
 Sdt9aOpgYdvn95Uj4wiGjT0Phih2SGawy3Fv5eYKZenkF0YCIug5d+dA1vMrdmbHq8at
 rYiHNXmFtbkDf+cEdhOIOoqK3HcGUC/FhTiKZ3SG1FD+3BzygOIL9Cl/3PoX2xF6J9Ty
 UWuBkoeXMT0EcLE/q+zSIroiqg7AAyymWeDbVQkDPHkekhhz6kOlAGRHFJ9ncuUN2lG4
 gNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726679691; x=1727284491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e21ToE/HJXzkFx4begXiNagynBpQzCVjg3pkA/vtkjA=;
 b=oUdKTrvRKjfe6Jls13MuerWTLFY5Ral/TJJpa1+7qKyfXjtA5Tk2KYjtBCRJU0CPf1
 m/lnsir9iOT95FIDK9ILPd/d5iYZVr2IYSQtR2PCnPdJvtTjwkF1iscBdFAbVPCVwVF7
 45/ObDvYeRELa8HADC95NxBF4iFUhtTI0nJOGYJ4lxiJ1Pd9PHpzH3SlWlUmUzFozDUa
 TGZgNj+LlgV7QfxLo46p+hJVO+E8N8ckM2ApHCULYSytgLMi3HXgn8Ku7c3bjFN7pPnk
 UJxSq89hYH123mKYkAzFucQFmOXBkFBCLzSV3rhMyblGEpKI6ET19NFTeZKNvoTLqpTp
 M3aQ==
X-Gm-Message-State: AOJu0Yy76iTddCUWb5yigiF15wjQVcqOz1pp2gtMNgtm23qPmeBEN03E
 HPYxGsiJKinG4HvcoE3CV4b0fwnisxmelrZg6FY0PzpYbiDLxhgJKwV1YLtMYS0OJWcjNvHU3Es
 VV6V+b+Waaw27IjFJkqinTySlhyQPjolYT7RC7rTJnkfLz5QPrm/9JnKEtuK1Nl78g2xHNoV/s9
 rgeoj/lg0rOnIMJJe0Trc3Zylf5QPVwZPTjyKuJA==
X-Google-Smtp-Source: AGHT+IHmPC7r4D1pHZ65Xf9g/juUNVNn4FjJQxuEfFiq9OavfkgPER76FjkG+u5oQuaOkqMJdhioSw==
X-Received: by 2002:a17:90b:3888:b0:2d8:9dd2:b8a1 with SMTP id
 98e67ed59e1d1-2db9ff91bd9mr21719444a91.9.1726679691211; 
 Wed, 18 Sep 2024 10:14:51 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dd608e2318sm1914577a91.32.2024.09.18.10.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 10:14:50 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 negge@google.com, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 6/7] target/riscv: rvv: Provide group continuous ld/st flow
 for unit-stride ld/st instructions
Date: Thu, 19 Sep 2024 01:14:11 +0800
Message-Id: <20240918171412.150107-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918171412.150107-1-max.chou@sifive.com>
References: <20240918171412.150107-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The vector unmasked unit-stride and whole register load/store
instructions will load/store continuous memory. If the endian of both
the host and guest architecture are the same, then we can group the
element load/store to load/store more data at a time.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 77 +++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 14 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 59009a940ff..654d5e111f3 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -189,6 +189,45 @@ GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
 GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
 GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
 
+static inline QEMU_ALWAYS_INLINE void
+vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
+                       void *vd, uint32_t evl, target_ulong addr,
+                       uint32_t reg_start, uintptr_t ra, uint32_t esz,
+                       bool is_load)
+{
+    uint32_t i;
+    for (i = env->vstart; i < evl; env->vstart = ++i, addr += esz) {
+        ldst_tlb(env, adjust_addr(env, addr), i, vd, ra);
+    }
+}
+
+static inline QEMU_ALWAYS_INLINE void
+vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
+                        void *vd, uint32_t evl, uint32_t reg_start, void *host,
+                        uint32_t esz, bool is_load)
+{
+#if HOST_BIG_ENDIAN
+    for (; reg_start < evl; reg_start++, host += esz) {
+        ldst_host(vd, reg_start, host);
+    }
+#else
+    if (esz == 1) {
+        uint32_t byte_offset = reg_start * esz;
+        uint32_t size = (evl - reg_start) * esz;
+
+        if (is_load) {
+            memcpy(vd + byte_offset, host, size);
+        } else {
+            memcpy(host, vd + byte_offset, size);
+        }
+    } else {
+        for (; reg_start < evl; reg_start++, host += esz) {
+            ldst_host(vd, reg_start, host);
+        }
+    }
+#endif
+}
+
 static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
                                    uint32_t desc, uint32_t nf,
                                    uint32_t esz, uint32_t max_elems)
@@ -297,24 +336,34 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
                                mmu_index, true, &host, ra);
 
     if (flags == 0) {
-        for (i = env->vstart; i < evl; ++i) {
-            k = 0;
-            while (k < nf) {
-                ldst_host(vd, i + k * max_elems, host);
-                host += esz;
-                k++;
+        if (nf == 1) {
+            vext_continus_ldst_host(env, ldst_host, vd, evl, env->vstart, host,
+                                    esz, is_load);
+        } else {
+            for (i = env->vstart; i < evl; ++i) {
+                k = 0;
+                while (k < nf) {
+                    ldst_host(vd, i + k * max_elems, host);
+                    host += esz;
+                    k++;
+                }
             }
         }
         env->vstart += elems;
     } else {
-        /* load bytes from guest memory */
-        for (i = env->vstart; i < evl; env->vstart = ++i) {
-            k = 0;
-            while (k < nf) {
-                ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems, vd,
-                         ra);
-                addr += esz;
-                k++;
+        if (nf == 1) {
+            vext_continus_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
+                                   ra, esz, is_load);
+        } else {
+            /* load bytes from guest memory */
+            for (i = env->vstart; i < evl; env->vstart = ++i) {
+                k = 0;
+                while (k < nf) {
+                    ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems,
+                             vd, ra);
+                    addr += esz;
+                    k++;
+                }
             }
         }
     }
-- 
2.34.1


