Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55543C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfNr-0002el-NS; Fri, 17 Jan 2025 00:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNG-0008PN-EG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:34 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNC-0006AQ-9F
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:27 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21654fdd5daso29498945ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093505; x=1737698305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8YkMju6yzKP+1EeI3Nx90zzEVqfM82TdUg6UM2JkoWI=;
 b=VlERVHxWtsR5QoslP+XwGOJP95tSPKuzkLSDWPuOVbGVKuNSXezopvciqWkIxA2C/K
 k0fYlKENCFtzNBWBKnaa1T5Aec+r89W+vAnMmWxpxRniXc7q/qL/gvAEH5iQfyNbyKpC
 Gt0W9yuqRZYJk15i7xCFW0JBw1BhFeaBO05pccS8gH/zwWxY6tB2wIacreInnJU/Tepa
 NXgi5rNsI4AKvcoB+LjyWtozS0KuVu6YAoyT5pjjo2M0vpusPcc1Qu4toNFSzOWw6Lrb
 GiYwwYgCGKmAgfrFHQGfHM087f52Ui5dQJvaYWyzqZlWD8rHiqvt4kuduKIDW9iFQauC
 nqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093505; x=1737698305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8YkMju6yzKP+1EeI3Nx90zzEVqfM82TdUg6UM2JkoWI=;
 b=heliPbGCSp6aCl+cDKf20an7hZd/CRgcYkB8EdwOp5RKXc7r7rY+AfHNQmH2LPSoph
 WcNzhsvw56LSiNBABXyKuKbbgb8rW9gJ/iFp94NLgcokbG9PDm7ZokKolua3G48EQ9W+
 zDOxIudruyArRyCz2Xm/SCd/EyXgtMUBYSbEUJkQ+NLRfzm+8E+C6siSL7QxDsj18Cbn
 B6IiGmKrSN94FJdaS5Y74YKEyNmvT2V119zAw4JKw6PHz+eL1Tw8zYVWyDhZT8EqSp+/
 DXH+hynfYc05HQxceeKJMDPsQN7Bj3J4VO0VtymyNWmjC4yfMO+IbeaTSfogPTXjVuHa
 D8dw==
X-Gm-Message-State: AOJu0Yx0P6OeAYc/+rsLWgR/xbjxFoeyF30SKAPi5ZA5w1Pfcp982wGt
 svDNnmtFh+2QXnH55YGSriRcv38/BhDtwylLcw1Y63leeClt3BV/bUKKnA==
X-Gm-Gg: ASbGncvajVTDoc6p+7hKh1PP3UA4+90aXPw8Escd3Z/NxWNE2TtOm75h4B/UEuO9Ur6
 ENLbOfs1mT2TMa9TQxzti6qk+AGNYNuFDf25zWqYqGywTTxTvG7tN9AUVTV/W+mpvgu8gcQ3+pq
 al0fnmjT4aDdpid2Ztwq3EwlV/xoL9HU64m3MgMIrLD464EdWrmE3Cwt3IHOYPcSc6r41Nm4OgX
 j6NH23h0lYHxuS9NK6hJNY9TNWrM0sVqV8XvSucnCxPk89uiblBxROCgqPdeT6w1GvqeIn/l3EP
 oXfSNat88p5rER09Head/8gw0f9z9Xf0FAnuQQbH1xiGF08b5K2B3qcR3mEO
X-Google-Smtp-Source: AGHT+IFfgLzMzaMG8sg5HF3STp854y9EJw4cKWZCTcRsMtyTo0sqUgTZDKecVfBglgZYBY4g/hkJGQ==
X-Received: by 2002:a17:902:cec6:b0:216:5568:38c9 with SMTP id
 d9443c01a7336-21c35574ee8mr20181935ad.31.1737093504622; 
 Thu, 16 Jan 2025 21:58:24 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:23 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 42/50] target/riscv: Implement Ssdbltrp exception handling
Date: Fri, 17 Jan 2025 15:55:44 +1000
Message-ID: <20250117055552.108376-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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
2.47.1


