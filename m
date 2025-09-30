Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B30CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vot-0006JZ-Ft; Tue, 30 Sep 2025 04:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v3Vos-0006HL-0n
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:34:46 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v3Voj-0004RY-BR
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:34:44 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-33255011eafso5651253a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1759221265; x=1759826065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLBYrqjpNvkhmLUsF54KL5bWhDBVu9ThZEehNSlvIcQ=;
 b=nhOpkzcEGd9drnsB3/ABbmvUT7KUCvZHE4+yPFvaLR5yIhH0L2QgndiAWT8N435XlI
 ietS7oKGpD7/4A+O8PoaRq2PKG1ef42Z43RMv5Jt+p5DOa16nGGsQaccPNoY8juo+G1z
 pjzftxWJfQDRb0WkTIhTy9z7PdK+oyHhZ1Q2XaigZzcxyTCvqQZ8NdGf9gOxW+foMFSx
 76nAt+W7TvQODlwADUiFTPqNB2vhppr2W4Y+ragcKCV3KzlESV1TFxoZctUTH+kVFcl5
 xXjqB0Ih9UoHSiKyb0bVmagDzXF9zgcOEv5THrw9HEpMJMAjJWe6E5OPIMopiA9IOnU4
 jn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759221265; x=1759826065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLBYrqjpNvkhmLUsF54KL5bWhDBVu9ThZEehNSlvIcQ=;
 b=mviHs3RFxXMcnhdKJiiJpja3KDs56FkTh8IFBooIG9V8P9IOqSMzp7t630rTs+JyG3
 3qzX9aaFr1DE7S71LK1eTMKUT4R3uo9p2EhF93nSApvZkyoD2w7o/DVaWn4wmdfD5gv2
 qnd1XvpJq4zrAWeFrEA21zGPILoliBMwzyZcZlzoxwbWAVCAPFqAr0PnmCJ6JGmNCoPQ
 FTA4pDEiLy2Vy60MDZEI/Qw/0aTd/cWYU19q4DlyEDQgXC0YHtav44SM0v6a6CKVQZsT
 /zvu6Y1Qd30tF67dVBb4GgypDBzaCvjcLjzB3CrnTIGpVck3mcSoEZFL3kV476nBEqhR
 Yz9g==
X-Gm-Message-State: AOJu0YxG6qO89Z8zK2AS/Q0uOU8pku8G7H9IaiW9U44BbK9mkEWUI23P
 qzl1qcXmJbBedof/cH7aS940wl5M4jjm/TswTjXlbrjX5Mt3pnal19mz2Qt5j3y3kWkaCcE6D+G
 FBvBf1jeTTzfL6WP87eDydzNw/h0eEFLtFFORZVlS5WIjThgtTyr1o2wr0B8ZRgjeHvi+LUTuWt
 emj6w0yI3loUdIWvKq+wzocqdZndtPrGx8dpkdpvBv
X-Gm-Gg: ASbGncvKK0718q2eRUJwoW7V6HpzvO+GOMZTgxIMAyjsP5Xf5u431Bn/8ioE1zSHruI
 QzZEL1w0cRikYMyEpSuj5J4kP3BpEcAGDT2f6wtt1vdnsLcRL9Ra37l672aAnC2AFcKj675yHRX
 /uPKBXJDBKgBy0d0nSE1ZY7t5k819iBusxdvNXs/m5AOmpo6N8EXs3MRO0nKH5wQ/xe3mjHx8yr
 uhNSov0a83SDvPPeicwurEkxVYt8C9SPf45WBxgEmNgQ7LjdDcd81LNz9dVzRogyTxoMDvP6P6o
 Z6CJ0zbbxA0wUmQwbuAh9HQE33PkTIvstZ6A4GHPIjjbwunnSTF7CrfVTLxMQcL3vOVv7LaWSOI
 DG6VlKxoBZ7MQU+SBvjXfoUgvLagTe0XCETgP/jkxPltJTYE7OXPdyiflVMZ3oO6u2djsvEpzHk
 T0tK/8kWrXEQ==
X-Google-Smtp-Source: AGHT+IGEXTjk3S30/hwvfoxbI+ekPBIblXJ80EPwi785hk6LWn8afelfHnQgJo9pnxJQQ66Yfyq/Ng==
X-Received: by 2002:a17:90b:1a81:b0:32e:8c14:5cd2 with SMTP id
 98e67ed59e1d1-3342a2b0debmr19197010a91.28.1759221264641; 
 Tue, 30 Sep 2025 01:34:24 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.190])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b580bd86c4csm10340089a12.14.2025.09.30.01.34.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:34:24 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 2/2] target/riscv: Make PMP CSRs conform to WARL constraints
Date: Tue, 30 Sep 2025 16:33:59 +0800
Message-ID: <20250930083359.27637-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250930083359.27637-1-jay.chang@sifive.com>
References: <20250930083359.27637-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x102d.google.com
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

This patch ensure pmpcfg and pmpaddr comply with WARL constraints.

When the PMP granularity is greater than 4 bytes, NA4 mode is not valid
per the spec and will be silently ignored.

According to the spec, changing pmpcfg.A only affects the "read" value
of pmpaddr. When G > 2 and pmpcfg.A is NAPOT, bits pmpaddr[G-2:0] read
as all ones. When G > 1 and pmpcfg.A is OFF or TOR, bits pmpaddr[G-1:0]
read as all zeros. This allows software to read back the correct
granularity value.

In addition, when updating the PMP address rule in TOR mode,
the start and end addresses of the PMP region should be aligned
to the PMP granularity. (The current SPEC only state in TOR mode
that bits pmpaddr[G-1:0] do not affect the TOR address-matching logic.)

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/pmp.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 72f1372a49..d5cd76df3a 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -108,6 +108,17 @@ static int pmp_is_invalid_smepmp_cfg(CPURISCVState *env, uint8_t val)
         g_assert_not_reached();
     }
 }
+/*
+ * Calculate PMP granularity value 'g'
+ *
+ * The granularity value 'g' is defined as log2(granularity) - 2, where
+ * granularity is the minimum alignment requirement for PMP regions in bytes.
+ */
+static inline int pmp_get_granularity_g(CPURISCVState *env)
+{
+    return __builtin_ctz(riscv_cpu_cfg(env)->pmp_granularity >> 2);
+}
+
 
 /*
  * Count the number of active rules.
@@ -153,6 +164,15 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ignoring pmpcfg write - invalid\n");
         } else {
+            uint8_t a_field = pmp_get_a_field(val);
+            /*
+             * When granularity g >= 1 (i.e., granularity > 4 bytes),
+             * the NA4 (Naturally Aligned 4-byte) mode is not selectable
+             */
+            if ((riscv_cpu_cfg(env)->pmp_granularity >
+                MIN_RISCV_PMP_GRANULARITY) && (a_field == PMP_AMATCH_NA4)) {
+                    return false;
+            }
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
             return true;
@@ -199,6 +219,7 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
     target_ulong prev_addr = 0u;
     hwaddr sa = 0u;
     hwaddr ea = 0u;
+    int g = pmp_get_granularity_g(env);
 
     if (pmp_index >= 1u) {
         prev_addr = env->pmp_state.pmp[pmp_index - 1].addr_reg;
@@ -211,6 +232,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
         break;
 
     case PMP_AMATCH_TOR:
+        /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching logic. */
+        if (g >= 1) {
+            prev_addr &= ~((1UL << g) - 1UL);
+            this_addr &= ~((1UL << g) - 1UL);
+        }
         if (prev_addr >= this_addr) {
             sa = ea = 0u;
             break;
@@ -577,6 +603,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
 
 /*
  * Handle a read from a pmpaddr CSR
+ * Change A field of pmpcfg affects the read value of pmpaddr
  */
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 {
@@ -585,6 +612,25 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 
     if (addr_index < pmp_regions) {
         val = env->pmp_state.pmp[addr_index].addr_reg;
+        int g = pmp_get_granularity_g(env);
+        switch (pmp_get_a_field(env->pmp_state.pmp[addr_index].cfg_reg)) {
+        case PMP_AMATCH_OFF:
+            /* fallthrough */
+        case PMP_AMATCH_TOR:
+            /* Bit [g-1:0] read all zero */
+            if (g >= 1) {
+                val &= ~((1 << g) - 1);
+            }
+            break;
+        case PMP_AMATCH_NAPOT:
+            /* Bit [g-2:0] read all one */
+            if (g >= 2) {
+                val |= ((1 << (g - 1)) - 1);
+            }
+            break;
+        default:
+            break;
+        }
         trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
     } else {
         qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.48.1


