Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B5CCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC58W-0005Ax-DC; Thu, 23 Oct 2025 19:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC58V-0005Ag-4B
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:54:27 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC58T-000846-Bt
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:54:26 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b550eff972eso960258a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263663; x=1761868463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ujkPU5qKzXQC1XHHxoY9Do5nDnhcmoslDOM4TxcXYc=;
 b=eWJJd5e4ipkzlESaSrDWCaFZmvcSFEuIY5QrbLtRwqw8xedAPsw2+cWureckPstS9k
 GzH8j/AzluLO2AWFoQt63q4Xu0mKHTgf3iYSpJvkZpWJO9hoIz0Ef/rKXyWhJPpUsDEx
 PfcFiAjVG2X3Oz/dYTKbEN0vRV1MmC7QrgE33sBVL68dgD66T5DF420XqjW9sSHOeIVL
 UBN7bUduxMTUiZN0u4/pP8G+IA2hYhIrz4HygypnYlcFdCYM4bk8FRuNCAe16FORY9T3
 1SLfqOY31kIYXxp93AL6dNDH2r0WXu2Rfiex5ZOz8dYFZEtsAoDKOUjXnAalfJ3WBUso
 ZSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263663; x=1761868463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ujkPU5qKzXQC1XHHxoY9Do5nDnhcmoslDOM4TxcXYc=;
 b=YevjCil/TfaQlAdqWN2HZdhj1kQGcVsqtrMSNGAT2flW2+lXFe1iTrSgt73EPCmnZ0
 1E53SqneTdne1+pzxjQybBSxz19wkkqaxtohdGvK+U9KKQpfhNfbiRQ+GVEzFTIgaELF
 P9rz3SkjAU4XuSo0S8SXxEO7XTNTwzPn59tG3Zcd1LRokXgo2dhvUthutoEggLdb90eS
 240Jh6CyxIEsSd2LfUWT2pAS8/OzYuVJy5zzrDvKVQj+/ochXvatY1CL3EVfLUoM2wc/
 2v+n70uRVoEV/wAW/WDOw1y/nZioGre4LULHNE61yEtdzHHgyTde3Jnp/HVQ2r+mmTTh
 hUcQ==
X-Gm-Message-State: AOJu0YxYkECW2GawRCiH0T1H8RbKzFg/WFuF4l/IpPz/JB0jVYbxFGd2
 JFBMWZfx+eQnvFUROyuL3qQcfG8CATLh4Tb8SFCbDIlUy4evhFaPxzsltTpUzA==
X-Gm-Gg: ASbGncsB+AiPubIa7jwWqRVWHqR2N7hVNGpIHg3RlPyYMoAzcmq+qpDS5DT8kGree+Q
 e6DN4e2k1JcjyKQEaEQPhA6aQrAUPtT3DzMAMm1/i+jWr5Es0gaijPmhaFROGown+q4D4ZWq4cf
 cfb3DIak3CaE/Zs76ELc8PayYK7u8BpCsqYZvnC6WAuZuXBqHAf5WPWmH/JZtEuEvh50Rhs5d3a
 WZUch/IJP1ChaMupZDrsbSlW8auZmeJkhEO5Dgl3tAwISW4iFGvJ6Ilne4YaKZuaSEuJA1jP2Cb
 cF67JLOgrdrPa0VcR3VpQiJxD9d/WCcestBiysdmLEoFZnv5Iy/IemPco81Gr4S1S+4PUPd2AYm
 Ey1wklaJdoMRvKTN2sz+OqcrDzn9IYvCZxUzj1vxXEa6ame5brcPzKOpLpQZxYTYuE4S90cbWDh
 FDy+sktkRVpc91MJYpLAjMq+yHe9atAdlwAKC0z9SJJZgIdSOUnainF5baZSJNsYUideFpZZ4PU
 jWA8zbU
X-Google-Smtp-Source: AGHT+IHAIJLa81fTQzpVDPeFThP6sJIBzuixX+U9oHDHNckRTFGIZFFZMC/oEVLFPCSj7PCwOrpKsQ==
X-Received: by 2002:a17:903:94e:b0:290:533b:25c9 with SMTP id
 d9443c01a7336-290c9c8ae4dmr295341185ad.2.1761263663397; 
 Thu, 23 Oct 2025 16:54:23 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dda7949sm36542295ad.3.2025.10.23.16.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:54:22 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 25/25] target/riscv: Make PMP CSRs conform to WARL
 constraints
Date: Fri, 24 Oct 2025 09:54:05 +1000
Message-ID: <20251023235405.1865337-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023235405.1865337-1-alistair.francis@wdc.com>
References: <20251023235405.1865337-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
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

From: Jay Chang <jay.chang@sifive.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251022024141.42178-3-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.51.0


