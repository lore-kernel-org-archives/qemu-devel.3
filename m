Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41621CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 02:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBOna-0003RI-5L; Tue, 21 Oct 2025 22:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOnX-0003Qh-Jc
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:41:59 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOnV-0002K4-P8
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:41:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-781001e3846so5812943b3a.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761100916; x=1761705716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4f9YnaYgyvKsd8XILEdR5MrfELcvzlciUpM11jpKgI=;
 b=hWsTDQc5khL6zrH1DXVIx1dHHJFwMdt/VUj/7PdE/lWWJQ4uSBPXR3wf4Zf8V+upJ7
 86aIT05B58Q/7WA3dTC9g93hYxuUUJ3wao2GlSkAJmu+yqjcWU3PiUkg+68eGkpt/Rf/
 kESCSGrbBNKDxmh5ZNinKdxnWXoueeUgvpH66a395+HPKSEUb+b7/iHw0v2kLSI9PQ55
 sacZi+pduoVzCPrz9xJqvL8BX/Z70mKrDwNRKb1k5cDWG/41EV5I7D94/Ep3ANXBijxC
 Kz/EDU8CcefRucfLnHbX82YC4dfdVU9mX4PHIPI6pKfXJD22JV28ansj7oFAOPPWzhuf
 Ly4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761100916; x=1761705716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4f9YnaYgyvKsd8XILEdR5MrfELcvzlciUpM11jpKgI=;
 b=sao+PgKUKJIwI2TTT0xyoT0Qyu1n7UWWWcJ5K36h9+rZVCp/JXqPab4uCWxo94MoRd
 F/bjaRvfMvBFWbCDcgk1IuE5jOBE74Gbk2qks+d0oJCjPOtWWKec7pV4ga6pnLGBWSC0
 Qmp4Ch2UZnTq6qDkedObO4m81sd7bA0IB26W5xBwRaISWRpvBL0kqzSfyOhCt3BrB/lJ
 QnDqALheQw1uWe9+pl10RE7YVUHJ9hVBeiODVcxETYNv5PHJUA8ezZXAHAcei+9ZZ8ZT
 1STiJVnYp06HrGMuRMphme7k3PSo84jJwfpxwYvRJQ0kzdBXPFmZ5EOlEtKu0zHA/Q9X
 FOlg==
X-Gm-Message-State: AOJu0YwY7nsJflNWbND4GUVT8RHC4aXRWosdRLySaXa1aCrxgAeg/IHl
 kMfWXVTlCEA9100efTav6NwLJ3tkbF80HFgqJGu4QyjuIhtweLcZNo2BS8B5kXyBVMLaKPWiAGB
 Rz2EWPAQci/Tk/4UwSscOyMdhts5VQ21/Sebnz1Io/FsCg/t0iuoFbjB3N4EQ4CRov+EPVFBfVs
 zmga8dDfRsKXV29qy4ALYM9Av9lSrTa6z28SoN/LYu
X-Gm-Gg: ASbGnct7N1bpxBiSgUjAkdxt8WFXFhRuLHZ2cvScdRWFCF4yKHiH7zH2RU+ISZ7P2ak
 DgpasGqamrwXzlw+a5lK46l3GtdC8XKtZqWII+WQyTgz42CvWVBuFJlIpp0V81YCQcrLxLOPXo+
 aqJRd4B3nMqXyzozkualkBrZK4q5JiCTBN3QFXOLQiArxjyTRdp5eC557v+Pm4HpU/25VggMo6u
 Ke2wWQt3Ti2myARsKs67DEtR93m7O1l6Ar9JBodSjPGnvNv4rI7rHlFGqKSoWhoiT3qM+LYz2NW
 tZN7BLAo6/6/Z4waEXxZhaTVH6hm5XJCKRAxEWoSNIomf9uXWd3pleNAwkGFgnCbwgCgP07VJKf
 tvNLf/Pj2HS6sebw6E77bIQn3BMNUuBJ+xEgHh/s1nSZMKfCLcfKSbaXV1bcPVlm+M+3bk+S/uo
 bLrwXddYqOyveXkgnZL9uWKFODnU1K/XH1GX4O7pTowCKMLgmdpQ==
X-Google-Smtp-Source: AGHT+IH6u+daJq6CxLSlNxXGuZMH4W81DsaK3v1Hd0ZnxFgtoqwftc7Mxaph4dVu4Df70D/tGdLDNQ==
X-Received: by 2002:a05:6a20:a122:b0:2b7:949d:63da with SMTP id
 adf61e73a8af0-334a8564eccmr24644909637.18.1761100915802; 
 Tue, 21 Oct 2025 19:41:55 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a22ff1591dsm13204731b3a.7.2025.10.21.19.41.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 19:41:55 -0700 (PDT)
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
Subject: [PATCH v3 2/2] target/riscv: Make PMP CSRs conform to WARL constraints
Date: Wed, 22 Oct 2025 10:41:41 +0800
Message-ID: <20251022024141.42178-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022024141.42178-1-jay.chang@sifive.com>
References: <20251022024141.42178-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x436.google.com
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


