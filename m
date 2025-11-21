Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1020CFA472
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJK5-0006D6-FP; Fri, 21 Nov 2025 00:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vMJJu-000679-Mk
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:04:32 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vMJJr-0006nf-Ql
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:04:29 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-29555415c5fso17811375ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 21:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763701465; x=1764306265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdrR0qRhyHxnG+TvMN35yCUkjNJYPzQ6aw7tzmaZAHw=;
 b=iK6k743lj6XsQChhKWyIhV0iNdhyQaCyisrmaFOMvq6yX9fCptk2lxDhTz5UpBakMs
 yg5uxB+mLBOoPALNCM0GSK1PF1utcZA6BVxqqvVeTc1UN4VBTc3lbDTMftV7Mt1khLGd
 0sOf7ejdhPAL5XG1ujQSv/M/GFOc9wlfBrn866D+22JZdeCH83D+TBSZMLBYbnjbZIVs
 igd5GELvYwww6OQ94N5kvzQ74uzoVB87zbxhk2USxGt0u0dqguw8kwuUAkR3aOWG+crW
 uTFNBAt/0MRrPyDObmxrqATTVw1gLXcr8z1HdtIAqHkeEdihbz+IKaw7o1VhC3vWkeoJ
 T4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763701465; x=1764306265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DdrR0qRhyHxnG+TvMN35yCUkjNJYPzQ6aw7tzmaZAHw=;
 b=s5519Li01rtAF9McFF6AjU1CjE9D3bYPA/3MWojHIMu3ME1kEV1Q4QqxnYEjzfIkK2
 b0VonIZQP3+rrDqg7NkEAOVr8U4UdIEGdha3uICjPvieBkPEP4Vj8L1GgKLzdJRuZQze
 +rPN/bcu25WaaSuH+dcjazMgYMT4xQLjA/8oN1/KgLbOletxiyzIhGA9AZCvad+GfmYM
 PoC0J0wwXMPSrnjXJugQgWepHG+N/ENTdQ8R1RFTaBl6Z16lroiUMA8hfMk5FzAYRGc6
 0R+ePfxae+IZAx5TKSn8qsizg+MzsFxNGyf4QqUeNCvw+XPSxG7aalJdKoq9VhDxy0mX
 IGcg==
X-Gm-Message-State: AOJu0Yzd/KmrHB3Y+Aje7Mzg1m/U97wum9YeNldASqBlCudMec75qfJX
 cp+VbOB5hoEAdyDs0MEk4HLpKSc4mtJCSsY5ZkFD7SlDh852XrtPOuK4KOJtl7lQAUB2P94paRW
 PSIcb9FoJPLcwbik6f0+7QA+4ZCSmzDmjCJbr4FbpJ7Q98PYc7+bquw6E7NJlmZUmP8tWZR7ERc
 XBQyr243E4LUMmW3OsBgygxSU9D8C+FcViQ7ehlyc7+Ug=
X-Gm-Gg: ASbGncu/H0m7B+ZTpv9Pni6cF+Vgomna3rGA/GvZB7uhgqTmxX9DIcw48uXRGNBKfNw
 gfapOnRoL01UsRToTGHOhlxpEGcrQJ65SnnFbJYbPLxnYbIbNbOyMCeLgewHGP1I8hFpGX56u6D
 lhlzE/tOaFzcw2pHlhZAsK8rwaRanhRPtKtfLb+PD8Lg5BEnHQ4+hZbKAhiugZnXq/Wo02rxjhW
 tTSrAaSMeZ1f4031VvQts3RypVy+tiGfUpAUJAEgkaIV9f5jQBxM3Fu+RkmikNoC/7yu30LbPj2
 kR+ExA/2vHTLrDrmRqaeu2TyJm6RRPUz/3ChCJvIG1rYADWgSFHlZW87B9gkizT48cqGTyyi+L7
 +/pAJhVdylVqYwk1XWTx+Ds19CJGJPI5GuVil593IGBAE2uYG5x+0WZe4PUCQXlVA4kg8xSwZHT
 fZ5b9uT4T9Q0VCRZvlCpYSl/kEqsd6yWvGnmf0vA==
X-Google-Smtp-Source: AGHT+IF3eV/1EaFWrDprz8c/ZKZCFeRacK8vQDjPT4tZAhRHzDBbLKEmKnBh5kBvtfZ2mmNrnLjrJA==
X-Received: by 2002:a17:902:eb8b:b0:26b:da03:60db with SMTP id
 d9443c01a7336-29b6c40263cmr14875085ad.13.1763701465027; 
 Thu, 20 Nov 2025 21:04:25 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b26fed2sm43384525ad.69.2025.11.20.21.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 21:04:24 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 3/6] target/riscv: Fix pointer masking PMM field selection
 logic
Date: Fri, 21 Nov 2025 13:04:10 +0800
Message-ID: <20251121050413.3718427-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121050413.3718427-1-frank.chang@sifive.com>
References: <20251121050413.3718427-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x630.google.com
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

mstatus.MPV only records the previous virtualization state, and does not
affect pointer masking according to the Zjpm specification.

This patch rewrites riscv_pm_get_pmm() to follow the architectural
definition of Smmpm, Smnpm, and Ssnpm.

The resulting PMM selection logic for each mode is summarized below:

  * mstatus.MXR = 1: pointer masking disabled

  * Smmpm + Smnpm + Ssnpm:
      M-mode:  mseccfg.PMM
      S-mode:  menvcfg.PMM
      U-mode:  senvcfg.PMM
      VS-mode: henvcfg.PMM
      VU-mode: senvcfg.PMM

  * Smmpm + Smnpm (RVS implemented):
      M-mode:  mseccfg.PMM
      S-mode:  menvcfg.PMM
      U/VS/VU: disabled (Ssnpm not present)

  * Smmpm + Smnpm (RVS not implemented):
      M-mode:  mseccfg.PMM
      U-mode:  menvcfg.PMM
      S/VS/VU: disabled (no S-mode)

  * Smmpm only:
      M-mode:  mseccfg.PMM
      Other existing modes: pointer masking disabled

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c | 61 ++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index fbab8177092..acfc6c10607 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -171,16 +171,49 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
 #endif
 }
 
+/*
+ * Returns the effective PMM field.
+ *
+ * @env: CPURISCVState
+ *
+ * The PMM field selection logic for each effective privilege mode
+ * is as follows:
+ *
+ * - mstatus.MXR = 1: disabled
+ *
+ * - Smmpm + Smnpm + Ssnpm:
+ *     M-mode:  mseccfg.PMM
+ *     S-mode:  menvcfg.PMM
+ *     U-mode:  senvcfg.PMM
+ *     VS-mode: henvcfg.PMM
+ *     VU-mode: senvcfg.PMM
+ *
+ * - Smmpm + Smnpm (RVS implemented):
+ *     M-mode:  mseccfg.PMM
+ *     S-mode:  menvcfg.PMM
+ *     U/VS/VU: disabled (Ssnpm not present)
+ *
+ * - Smmpm + Smnpm (RVS not implemented):
+ *     M-mode:  mseccfg.PMM
+ *     U-mode:  menvcfg.PMM
+ *     S/VS/VU: disabled (no S-mode)
+ *
+ * - Smmpm only:
+ *     M-mode:  mseccfg.PMM
+ *     Other existing modes: disabled
+ */
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
-    int priv_mode = cpu_address_mode(env);
+    int priv_mode;
+    bool virt;
 
-    if (get_field(env->mstatus, MSTATUS_MPRV) &&
-        get_field(env->mstatus, MSTATUS_MXR)) {
+    if (get_field(env->mstatus, MSTATUS_MXR)) {
         return PMM_FIELD_DISABLED;
     }
 
+    riscv_cpu_eff_priv(env, &priv_mode, &virt);
+
     /* Get current PMM field */
     switch (priv_mode) {
     case PRV_M:
@@ -189,22 +222,30 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
         }
         break;
     case PRV_S:
-        if (riscv_cpu_cfg(env)->ext_smnpm) {
-            if (get_field(env->mstatus, MSTATUS_MPV)) {
-                return get_field(env->henvcfg, HENVCFG_PMM);
-            } else {
+        if (!virt) {
+            if (riscv_cpu_cfg(env)->ext_smnpm) {
                 return get_field(env->menvcfg, MENVCFG_PMM);
             }
+        } else {
+            if (riscv_cpu_cfg(env)->ext_ssnpm) {
+                return get_field(env->henvcfg, HENVCFG_PMM);
+            }
         }
         break;
     case PRV_U:
-        if (riscv_has_ext(env, RVS)) {
+        if (!virt) {
             if (riscv_cpu_cfg(env)->ext_ssnpm) {
                 return get_field(env->senvcfg, SENVCFG_PMM);
             }
-        } else {
+
             if (riscv_cpu_cfg(env)->ext_smnpm) {
-                return get_field(env->menvcfg, MENVCFG_PMM);
+                if (!riscv_has_ext(env, RVS)) {
+                    return get_field(env->menvcfg, MENVCFG_PMM);
+                }
+            }
+        } else {
+            if (riscv_cpu_cfg(env)->ext_ssnpm) {
+                return get_field(env->senvcfg, SENVCFG_PMM);
             }
         }
         break;
-- 
2.43.0


