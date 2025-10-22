Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B999CCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 02:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBOYr-000738-FQ; Tue, 21 Oct 2025 22:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOYp-00072W-Dw
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:26:47 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOYn-0000xN-Fm
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:26:47 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-290ac2ef203so62653835ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 19:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761100003; x=1761704803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=026+MkGDqz12mXQJte4DznqG5pLwCGi6DGsBZLqInuM=;
 b=MBjThPwnmu7jCKPZYxnytbzqw6RXp30YR0i7p7JsVmw6keoFsrNlcbY36F8oo9fuha
 YIKhKe9DhIOQ54cMAYGQn8iIlLboEdRd3bBWwqfiQIafOYjwLwx29HhJaOceTGoE/EmP
 XZNKwEp8MMJAJEkRvTRBMfmigFO+vGHJEoPnb3XtEpj+7ecsMJoeUQYJcL69TpplCQAG
 9cbaBj0Sc+Vod4Qj6hwIOOsIahsn4VqGqNqHXrS1YbVz6gZOQl+QZV1Q4ILYMo8s4kTu
 zU+Fw3DPGXECtJpn9dO0I+wlAfj7RfzVYsyOo/a9BqM1YLjDKIdFP3LwY0o58fFLyL2z
 zP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761100003; x=1761704803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=026+MkGDqz12mXQJte4DznqG5pLwCGi6DGsBZLqInuM=;
 b=HWUqO8GJ+V2OjJ9Rf/4ZqZVrjkoek8MxCS3W/g/9icugK/Fmoj6iFZ6QciAdPBwL9k
 eUbJ6Prd2G5s5SL06la93QO3BJXy0T0F8kime4geTpW2h2Smd38A8MzK0pM2JxTPLbxB
 xMXfx3UWm9SfFU2X3lE5RXigbcIlwheBVT2PaDFVqsQcSObZvQq9HgfGF+JAdLvEFPhL
 +5g29gGkDN1fxmPR+NXs+k8MG9vavR56zt412UZ+V4f71u1RamBhLf5muYEd+Z4eLHAv
 0AoafnvwBuy5RYjg4H/ezIBNOVyG4Ee6MC7bvOoJfeee5VLcfxew2fvk1SVjYcuA1O/M
 az1A==
X-Gm-Message-State: AOJu0YxSRRZvid3od6IEntBw6mun0BhvNOA73vFuArWMl2vnxjdCXfww
 1yFjNwS3R+wfjCPX15mc8G27t8mjRefYYjLG2+JCp6t/r86mEfs6LU5DzbA6CfZtA54rlHB3vOK
 fg4gUFg8h1SiWr5zvM/h7mBphVbjrbp8XaMUlXmlK9jOmUNl7X54DhpTdFhSoquTlgpUMMbSDnf
 5mSTTtDPx1l1Cpglij6WCZN5XZPlU8yWaSD58Nc7bm
X-Gm-Gg: ASbGncv3gsWFB54CuNaEQiv7GumxPnpzUS8Y+M3n5dbf35UGU4LYK2Fs2A7dObArJD1
 vkh5wfumQ14v4aS3ePrOOZXuV1fYy/ITUrmsWW61KPI0TdMHaLEUfGK8SonstDj8B/Hy9BhV2sH
 aEmxYf6YBaVIXQvzKWlLCj8y3kJGaNcohznoT7R4pF4fT/fvKya/9EbdOhhWIPI12i4ePt67b2b
 PHKMEPi7btDW++VL8AY6DIkdipIqRo5JefRfVquHDZQuoJOPWByVgcZZiPtFJUTdvGVmJc9RBrW
 bho69RE6gsJKtyU6omWv43mAbM6LkbfYPxs1/eWJInfDiqLgkSp/+SigLCO0NoVthHAviaY6Zfh
 1IeP4YWu2U/qhrkK0qbJ85JshJhlkszauSCAeApBBSjTkUSIcq1P+X0jh9rc8+UjsUSWpyNZbwa
 tLgw7766E13shhww67UTP7FJkxIX9qipf21ldqAb4Z0QIDZjU7FUtEIa5k5fq8
X-Google-Smtp-Source: AGHT+IGe0oMMzK1M5FDpvkQ5kuw/v61bEieM2HI875/eYYHi08wohF7TIyB58gqpLo4hrzcnW5YRfw==
X-Received: by 2002:a17:902:8e84:b0:290:c07f:e8ee with SMTP id
 d9443c01a7336-290cb27af18mr172092295ad.43.1761100002942; 
 Tue, 21 Oct 2025 19:26:42 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2930340092dsm4673545ad.42.2025.10.21.19.26.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 19:26:42 -0700 (PDT)
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
Subject: [PATCH v1 2/2] target/riscv: Make PMP CSRs conform to WARL constraints
Date: Wed, 22 Oct 2025 10:26:25 +0800
Message-ID: <20251022022628.41307-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022022628.41307-1-jay.chang@sifive.com>
References: <20251022022628.41307-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x630.google.com
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
index 72f1372a49..a15265c8d2 100644
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
+            if (g >= 1 && g < TARGET_LONG_BITS) {
+                val &= ~((1UL << g) - 1UL);
+            }
+            break;
+        case PMP_AMATCH_NAPOT:
+            /* Bit [g-2:0] read all one */
+            if (g >= 2 && g < TARGET_LONG_BITS) {
+                val |= ((1UL << (g - 1)) - 1UL);
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


