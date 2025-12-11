Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44810D41D6A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjge-00035F-Nq; Thu, 11 Dec 2025 11:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgc-00034W-Tj
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:38 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgb-0003uM-Dr
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:38 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-297dd95ffe4so2732595ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765471116; x=1766075916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVWFqoOUqt7aIczGI8aZPPXvdgXYb1Y6uc2z33+iKKs=;
 b=F2uIKD0F+M/lbcc477As8hd7Wu+kAONxki5SnVWPSKOJwyz9wdJ4Eihm+7NmccoCl1
 cD+iMCqIWpfZxf6ApJYuCLoU2Czmj6+PGyjYqeM0ez8mBuBZ3RN6MRlhdNGU3rGYE0OY
 kcaHYpmOf2F2Soqmct3EhSlomfq2RsmGEuw1sEi7baDvKbHcUZpayCoD3nQwwDhKpwip
 ikdzEoYdDPH5oG+k4t/EcJibQCu5ZcGN9nudcMasmejdNyL+ocCpBvGpSXIHWiGmxa4H
 lEqR0OPBC2g2Gl86H3VxEBVvfJIPY/BmlspsjOYTJ3i1tbpHLA7SrGqG1Vr5DoR+tOMK
 og4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765471116; x=1766075916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UVWFqoOUqt7aIczGI8aZPPXvdgXYb1Y6uc2z33+iKKs=;
 b=e+8QsPxdSEkUDXySy7ph4efqwptWzXidTTeKvTBs/4xSjM8jd7YGCN/VfqX0gsBkaP
 sHwm9qyowZpJCso58i/u6t5ofBjRGBsDTVwx4z9U7K6JXH2M0YV39YsyC4UF2i2KFrQX
 SHlxApdpLszFUEhua3AQbba7ntY85eUgPThxpSNhuWTGvVU7lv1FoDmK43tn7kMitX5y
 tXCFigua/d4VWa55+JIs+C9jkvtl9RhoVAofthtYGpKiJDuG9vGsgxWJidON6garXXUz
 4CLxQmxET7sUoLwO3Mz+jt45jrPE3HoYJJNvmtSPkLdYg4tKErLj2Q2G2tXlL8a/JhrL
 oj+g==
X-Gm-Message-State: AOJu0YxP9AEwc71ItSxcxZahV1e4nUIrs1yCl90pWngzIfWN8koz5MlI
 MO/4303VVs+hdfSdsaOX6DSLxgdGPmkVB1M9HEHKafaIHGAvv8samzhC2CzxlF38sFkuyjAeA4I
 OxAXDQa11yOCK7lbx0IXRSN7nXniXI6q++Z8rTrahnWwjsqmlxpUOqOcf52RdGm3d7ivdXo5cGC
 BepD1OGu18QQk8EjeQU3tiGhPC3lPzLlRnTVoGgVhVWmM=
X-Gm-Gg: AY/fxX7vzZmREqCHF+v5hGYLhT2izOvLkO+mfwqKnKRBoV/UI74y+AiL2SJK5DVNJQa
 HDE5aKcgYzRInuNitPoPdmr3Dv1RmfaNQSRnOjvvRRbk2gMGPV5kIw8XNE3eT8PfqBwD6xDpRdk
 RpwY8CoHZ0sM0XVtzitkhiQOWQS4RsnSqg6rbGXXydw7peRaafBlTa64QukVpiOuiNz3g4tuyvr
 lMDL8bqdfCdHWOEK1KDEtlpULRJA4oxOhhjNKrk5HfotuU3J/OHcSJW66oWn6fatdEtSUZ20ro8
 p9Boh78adcy/G0uDJushFf00Z6dwxyzmXelC3jVmizVQKx5/DYis3Y5d5weKDMJTofV562P4hke
 QEKpSzlf0v3/lTEUGC76+l14mu5XXJmdLz8maY7TTcBaUeLRjo0pSJI/M2rEutiyImY7B4hwpAP
 CzVl8U2COjUpPQ64XwvXoYrQU2ibCCG6a1Zvu8XgwxgRVwXdpj
X-Google-Smtp-Source: AGHT+IGZx9jS4SSwtn/bgeFbQTrd376w9Cr/XzpWoKbZ577lS7HoTpN0dihv61pW9p49yYnBlIA25A==
X-Received: by 2002:a17:902:e784:b0:297:f0a8:e84c with SMTP id
 d9443c01a7336-29ec28030b9mr73060695ad.52.1765471115390; 
 Thu, 11 Dec 2025 08:38:35 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea016c63sm28962965ad.48.2025.12.11.08.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:38:34 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 2/6] target/riscv: Add a helper to return the current
 effective priv mode
Date: Fri, 12 Dec 2025 00:38:21 +0800
Message-ID: <20251211163826.3998266-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211163826.3998266-1-frank.chang@sifive.com>
References: <20251211163826.3998266-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62f.google.com
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

From: Frank Chang <frank.chang@sifive.com>

This helper returns the current effective privilege mode.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h        | 37 +++++++++++++++++++++++++++++++++++++
 target/riscv/cpu_helper.c | 15 +++++----------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8899bf7667a..f59052fe7dc 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -799,6 +799,43 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
 }
 #endif
 
+/*
+ * Returns the current effective privilege mode.
+ *
+ * @env: CPURISCVState
+ * @priv: The returned effective privilege mode.
+ * @virt: The returned effective virtualization mode.
+ *
+ * Returns true if the effective privilege mode is modified.
+ */
+static inline QEMU_ALWAYS_INLINE
+bool riscv_cpu_eff_priv(CPURISCVState *env, int *priv, bool *virt)
+{
+    int mode = env->priv;
+    bool virt_enabled = false;
+    bool mode_modified = false;
+
+#ifndef CONFIG_USER_ONLY
+    if (mode == PRV_M && get_field(env->mstatus, MSTATUS_MPRV)) {
+        mode = get_field(env->mstatus, MSTATUS_MPP);
+        virt_enabled = get_field(env->mstatus, MSTATUS_MPV) && (mode != PRV_M);
+        mode_modified = true;
+    } else {
+        virt_enabled = env->virt_enabled;
+    }
+#endif
+
+    if (priv) {
+        *priv = mode;
+    }
+
+    if (virt) {
+        *virt = virt_enabled;
+    }
+
+    return mode_modified;
+}
+
 static inline bool riscv_cpu_allow_16bit_insn(const RISCVCPUConfig *cfg,
                                               target_long priv_ver,
                                               uint32_t misa_ext)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90e..da6e2d8fe3a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -45,19 +45,14 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 #else
     bool virt = env->virt_enabled;
     int mode = env->priv;
+    bool mode_modified = false;
 
     /* All priv -> mmu_idx mapping are here */
     if (!ifetch) {
-        uint64_t status = env->mstatus;
-
-        if (mode == PRV_M && get_field(status, MSTATUS_MPRV)) {
-            mode = get_field(env->mstatus, MSTATUS_MPP);
-            virt = get_field(env->mstatus, MSTATUS_MPV) &&
-                   (mode != PRV_M);
-            if (virt) {
-                status = env->vsstatus;
-            }
-        }
+        mode_modified = riscv_cpu_eff_priv(env, &mode, &virt);
+        uint64_t status = (mode_modified && virt) ? env->vsstatus :
+                                                    env->mstatus;
+
         if (mode == PRV_S && get_field(status, MSTATUS_SUM)) {
             mode = MMUIdx_S_SUM;
         }
-- 
2.43.0


