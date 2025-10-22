Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14209CCD1A5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 02:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBOZ1-00075V-0C; Tue, 21 Oct 2025 22:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOYz-00074v-0Q
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:26:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOYx-0000ym-4K
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:26:56 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-290a3a4c7ecso67722705ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 19:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761100012; x=1761704812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4f9YnaYgyvKsd8XILEdR5MrfELcvzlciUpM11jpKgI=;
 b=JOJvXndhb2tRuGcc4mHApbxONhM4vTBaHFl6oCxfeu3pOwdNj5pykp7QOOqjZDiPyZ
 LhBQeRi4CDYqDy1vUes8+bP+5S0bbAw/kY61ywuU/5MFaAhyc7MKgiCz0RqkA8XKioql
 /mdWLCqnKC66FkDdrwSri2mPEi6KfsoQ1e+jWovXYNy/0QiSigMc5r0yAeVhL1lipvm4
 7D1L46WAdeFxHfhA5rHssUOgI89HN/tU9hb1S8CZFq6rotkPlL74dztUr8BWO0D5QkXV
 Vb3wsMuvHb/DLiJSaX10gagg9IjFN4MjnEGB2rXYUtlpNhsNP/qwaX+4s2ZZkVs3iT0F
 48QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761100012; x=1761704812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4f9YnaYgyvKsd8XILEdR5MrfELcvzlciUpM11jpKgI=;
 b=kVTq/k+s6QNjaR3kbJvA8XgKTTTZcYUe2wADZVjZ9K+A/UHDFJrUkGn7zRDK68O9m8
 3+Vm4O4NxQtskb/NOz9xKoPapKBy3r87K7s6LVqRLmcnkSFrxs+NIDGbpIimjL52pkTB
 pWiNlWMrQ+QEbetKzDKHD91kHg79vbnDL4G/fJuHLsIshW8UY/h9q04D5LUhNE6rwm+u
 Fi2M6vcClOrCvDjQJ4yJgnooIJ+WrNDkfLmw6eh+rTPFoLuZfd+zY3nYp8JqjXgx5zJA
 Nfd1iTf7gwqRJy/CGd/sS4lntvcCGIRPfPsntQS1WQj4f/hmREaoNiJ6OG8WbcRZYoo/
 fUCg==
X-Gm-Message-State: AOJu0YzDHdjw7j1bBLknxQN1isbbp2uVk5ee/Ef+ngO4i78ziOmK/jfF
 7TIgQJrBuzpxn/LFUAXHoeVICB1Zbc9EiOCvgCz8UZFQgJSCcYJ5tFbNvqYgFEmBnLfNSDZ7Jr/
 K4gKg7UqPzTQifR7vGBrm922yF124aql1tkwTbk4gFCsFVZAK/4ubVo2suKfer91fxddY9pnyca
 aCkN5CJPCV4A0Ensj6UJGP8aEiZ6vpYJg97Q2VFgeI
X-Gm-Gg: ASbGncuLJqh4ldM2K2qxex1feZVxXNPQuqb/HdJdwVSuatbP23beBOPWmfBNr1eNbBJ
 FBwMrjG/OEJgIasnvfoo1zEdu6maQDGwli/M4d8T4SueRBwiWBRIaz0iE8E//dKUoU53QSi52cR
 Eok7wYtx7NnFeFiw2hDImkgogCp+TMv8PfH5dSxJ4KpEivuZnToyTkK8cccOnsVQK9zb9No+xAl
 ddFquf7x1FqBvDX3SVHqJHYQsOexlBnK+d46X6cHbxKAJmO7lOHseHqNHiHaYiIDhMK/DWS4hwo
 2AzQ9hQ9YjPI9GAthd0t3lbxPdI+6wVUK5u2rNgqE2tUsrBCLLLKBSDeRZcyiTwRzGQoqkKCzW9
 iFBpmlUa5+IQkafIUaGIhIiCITeUVy/Q/LVtVWCoxBdbrq8pRvxiCMtliNf+ez0JkuyNa5yCSu3
 7iygwdTYARsF3kbCuXwZROO8mdibLdud2/I1m5q/9bDHg1CYvQ3A==
X-Google-Smtp-Source: AGHT+IEcffunv84UNmFLL+IM0NukBY0a+TpBTZXapGk9CCF7hVDQO0E5K5BcPjq/Kv9BzH7qQV54UA==
X-Received: by 2002:a17:903:1a0e:b0:269:603f:420a with SMTP id
 d9443c01a7336-290c9c8932bmr223852665ad.5.1761100012425; 
 Tue, 21 Oct 2025 19:26:52 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2930340092dsm4673545ad.42.2025.10.21.19.26.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 19:26:52 -0700 (PDT)
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
Subject: [PATCH v2 2/2] target/riscv: Make PMP CSRs conform to WARL constraints
Date: Wed, 22 Oct 2025 10:26:28 +0800
Message-ID: <20251022022628.41307-6-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022022628.41307-1-jay.chang@sifive.com>
References: <20251022022628.41307-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x62a.google.com
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
index 72f1372a49..3ef62d26ad 100644
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
+            prev_addr &= ~((1ULL << g) - 1ULL);
+            this_addr &= ~((1ULL << g) - 1ULL);
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
+            if (g >= 1 && g < TARGET_LONG_BITS) {
+                val &= ~((1ULL << g) - 1ULL);
+            }
+            break;
+        case PMP_AMATCH_NAPOT:
+            /* Bit [g-2:0] read all one */
+            if (g >= 2 && g < TARGET_LONG_BITS) {
+                val |= ((1ULL << (g - 1)) - 1ULL);
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


