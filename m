Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E95C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJum-0003du-Eo; Sat, 18 Jan 2025 20:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuC-0001qa-ND
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:12 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJu8-0003es-VJ
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:12 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ef760a1001so5879167a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249306; x=1737854106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gf4FLsfTMGpl/kEVYpdgLrPyFPxMp7ICmBJwS+O0aYM=;
 b=R9GVwJ9O7+FJnGBj/l23tOLyhColNdXQRWPFVK5QvbaCpSWHbbQtxG6g6EOwdYvqKH
 sINUsJeHJHAWxHslAT9Bss1YZxhBYlIHk6W43dY176TFf+wqb1RC0vZXeGMNtrlMWx5d
 UueGxR0yxZpZ780FgWSROxmgNmDvILzJ6CDkAapydtFc9ribrDSh1yW6it24fgNUR8QL
 cs0efK9+SK1wlGdW8ExX/bYC3Q7R9J+rNzCAjVIkdZpKQ9ZZO2HJyR2GZa7BSvJ3yOac
 OGgriD0u5QL3jv0w3kigjJKtWvdJmnXWLDhymaE7VykNFUFnOgQXUT7RPKMMcvqNDzuF
 TPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249306; x=1737854106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gf4FLsfTMGpl/kEVYpdgLrPyFPxMp7ICmBJwS+O0aYM=;
 b=Lp1na5e0rxkko4XGmF7GuBwRqdOip3ubFDWZ9G/B9RjeTUTNRiY0NgHW69SNT+goH3
 yIqE0pUr+q1PlFQdEnNCc5fSgz5ZqB6IWJZ42O1mIt1FVq5BmM+/YPfS2jaMOcnzNQo1
 eWRnAkftHaR7+lEIjm8BIb8OQIRHGImgVGqC2pa5+tALBrEDpraDPajLMTIOD4W9mo2w
 bNOnn+nt7/2JD9+Qx3Wl8d+Sluc3B9MZUw9/M9MYwu8blNeJ0zK+kR/HtnHPB9EOK3i5
 Y/4x9dA8SApSgfAp751jtC6OJKvkTcQj8UnboDfw+x1CzDqRXWHJ3l2MHUMXdGF3vz1r
 8Vww==
X-Gm-Message-State: AOJu0Yw21IwIIEdUrTQ5Qx2IG1NK/qxi+T/01/9EnbLmBH8vH15lgpio
 SaVTdBLfJws2f3+IXZhKy4DadsDBmQq2noUZVJai8ZBf6fpzS26k/4gEx5X7
X-Gm-Gg: ASbGncu6bRxAaETEgYs39K3HlsU3FhPZ9gscpRM44qviadvssv+uXI3Z76yvkR5nwu7
 nK5xqKawyl2io9oS1tc9TNt+14zyXkzsHcm5KG9HS5BMOmvOj4GAA8Z8UodI4WqbBH1ZnhNE+Mg
 VnoVmcVsxCUsmO6z+g7f5lMafFRF1N9Jfkzwei+2cRFOs8RFGNB2EyHvGWUBe/13t0dOjHo4w+u
 6jukX+Y/DTDQJ8S2a6oOvA+lvJyvmpDqikA0//EUyDJscNtkH5uRjauap7uRYAogklEQO+oPDu8
 yijdA3OffZ5l1oO/I/YHzUYY3mLWnkAeTs5SRV8F/g4lTtbSO6UFKlj2QItKg9LJ+D3oD6taPA=
 =
X-Google-Smtp-Source: AGHT+IGXOPgY5B2dZvnRcET33xSKIoGsRVz0kms2Gg9Avb7coib35ac03Ik07OKVyyaGtDNkOqig1Q==
X-Received: by 2002:a17:90b:520d:b0:2ee:7411:ca99 with SMTP id
 98e67ed59e1d1-2f782c4cb23mr10708829a91.1.1737249306494; 
 Sat, 18 Jan 2025 17:15:06 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:15:06 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 42/50] target/riscv: Implement Ssdbltrp exception handling
Date: Sun, 19 Jan 2025 11:12:17 +1000
Message-ID: <20250119011225.11452-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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

From: Clément Léger <cleger@rivosinc.com>

When the Ssdbltrp ISA extension is enabled, if a trap happens in S-mode
while SSTATUS.SDT isn't cleared, generate a double trap exception to
M-mode.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-5-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu.c        |  2 +-
 target/riscv/cpu_helper.c | 42 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 0a56163d73..a3acda4bc8 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -701,6 +701,7 @@ typedef enum RISCVException {
     RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
     RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
     RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
+    RISCV_EXCP_DOUBLE_TRAP = 0x10,
     RISCV_EXCP_SW_CHECK = 0x12, /* since: priv-1.13.0 */
     RISCV_EXCP_HW_ERR = 0x13, /* since: priv-1.13.0 */
     RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fe470f646d..5540eb7f63 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -303,7 +303,7 @@ static const char * const riscv_excp_names[] = {
     "load_page_fault",
     "reserved",
     "store_page_fault",
-    "reserved",
+    "double_trap",
     "reserved",
     "reserved",
     "reserved",
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 1eac0a0062..539ba327e7 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1951,6 +1951,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool virt = env->virt_enabled;
     bool write_gva = false;
     bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
+    bool vsmode_exc;
     uint64_t s;
     int mode;
 
@@ -1965,6 +1966,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         !(env->mip & (1ULL << cause));
     bool vs_injected = env->hvip & (1ULL << cause) & env->hvien &&
         !(env->mip & (1ULL << cause));
+    bool smode_double_trap = false;
+    uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
@@ -2088,6 +2091,30 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     mode = env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : PRV_M;
 
+    vsmode_exc = env->virt_enabled && (((hdeleg >> cause) & 1) || vs_injected);
+    /*
+     * Check double trap condition only if already in S-mode and targeting
+     * S-mode
+     */
+    if (cpu->cfg.ext_ssdbltrp && env->priv == PRV_S && mode == PRV_S) {
+        bool dte = (env->menvcfg & MENVCFG_DTE) != 0;
+        bool sdt = (env->mstatus & MSTATUS_SDT) != 0;
+        /* In VS or HS */
+        if (riscv_has_ext(env, RVH)) {
+            if (vsmode_exc) {
+                /* VS -> VS, use henvcfg instead of menvcfg*/
+                dte = (env->henvcfg & HENVCFG_DTE) != 0;
+            } else if (env->virt_enabled) {
+                /* VS -> HS, use mstatus_hs */
+                sdt = (env->mstatus_hs & MSTATUS_SDT) != 0;
+            }
+        }
+        smode_double_trap = dte && sdt;
+        if (smode_double_trap) {
+            mode = PRV_M;
+        }
+    }
+
     if (mode == PRV_S) {
         /* handle the trap in S-mode */
         /* save elp status */
@@ -2096,10 +2123,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         }
 
         if (riscv_has_ext(env, RVH)) {
-            uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
-
-            if (env->virt_enabled &&
-                (((hdeleg >> cause) & 1) || vs_injected)) {
+            if (vsmode_exc) {
                 /* Trap to VS mode */
                 /*
                  * See if we need to adjust cause. Yes if its VS mode interrupt
@@ -2132,6 +2156,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_SPIE, get_field(s, MSTATUS_SIE));
         s = set_field(s, MSTATUS_SPP, env->priv);
         s = set_field(s, MSTATUS_SIE, 0);
+        if (riscv_env_smode_dbltrp_enabled(env, virt)) {
+            s = set_field(s, MSTATUS_SDT, 1);
+        }
         env->mstatus = s;
         sxlen = 16 << riscv_cpu_sxl(env);
         env->scause = cause | ((target_ulong)async << (sxlen - 1));
@@ -2184,9 +2211,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_MIE, 0);
         env->mstatus = s;
         env->mcause = cause | ((target_ulong)async << (mxlen - 1));
+        if (smode_double_trap) {
+            env->mtval2 = env->mcause;
+            env->mcause = RISCV_EXCP_DOUBLE_TRAP;
+        } else {
+            env->mtval2 = mtval2;
+        }
         env->mepc = env->pc;
         env->mtval = tval;
-        env->mtval2 = mtval2;
         env->mtinst = tinst;
 
         /*
-- 
2.48.1


