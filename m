Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507C5F327BC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF5kU-00013C-33; Tue, 21 Apr 2026 03:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF5kR-00012A-Ub
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:42:19 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF5kQ-0004Il-4s
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:42:19 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so24026975ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776757336; x=1777362136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wnpLM1zgV9lQHEBMJ3HvQ/dnk60Wn5Ah4/Bdh1qDj0=;
 b=kdoVf6AmJJLvadwYOKrtNOZIqVatnicoD+U+SgX+D1UeVf4UsxCsZgasTy7B/Uv8qj
 AHF6rtbnwo17hB0usGME+jpbo1C6kRfyi+Tj6S18dqmh+GAnx5we/iphEM9o1TG4jaQr
 HFEbb3Rgh/4OkEu6lL3DyzCRWAPGkJoJHjaKN7K3wFw1teyUltaRXWP462ahnd6ZPvRR
 igRwPWobwnBCqzh3USMYtPFCynEWB3uiZMQ2ByVzj3B8RSnAVzs4Ue3ihXduzSkfP4hd
 HQQywOx3ghtZLWyTEXPXbVYVFr/eQIIQ8Wn32063SS2w6OgQm4rlE0tp+Jwz30FQgzQW
 1myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776757336; x=1777362136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+wnpLM1zgV9lQHEBMJ3HvQ/dnk60Wn5Ah4/Bdh1qDj0=;
 b=HjXVEghlvf5Yqp1P0Ql0fZoVDJ5ec5TXQ6gruF7/0FR0fOk6Pq8mvZAP5anlttUv73
 naIC5FmL1njc8TgEmSEGI9EZwwbrrJoqhgC9bZSJyBSt7lkaGRwr4k8FuPlD8ZczYqVu
 maiWPPa8beaF3lwTO8D8eVW/Z1LCwqtbX/gElP5Zl+f9sgyzBlrEXI4OelBNg1NL1iDo
 OStDZ34FDfy0mW2exrEPVYOnnAWEOPNbQSOG+hTz15CM/xFeD80vDELJFrKkt3xkihfA
 /OS1Oyj/HG8SPPaFrfIDZlhDkr6nKdtEM3vxlTtHPb3W8o9+fkn2YLx2CG2nsKZRPh4M
 tV7A==
X-Gm-Message-State: AOJu0Yy/ppF4rWJuEbNxj4wVhdpBnDzft9//E1Arf3MpfCnauwelgHOn
 SGMieCEB2fQYrGtI8fumtXmJpgJYNj1WQLKlS+jmGvnyxnB26ro0At9cMRB56kBjH9rYK5pUopS
 vY+0QcXndh9HpzbthimqslTyIW1VNMSRrMOra3tfbmmbDjqF283SxrFwYdljjiOG3KSQsZUDvUU
 POh0ci8cZlixJTRSJ6Vz6IvIvLR++VWaptTc8DtY5VlSzkpJ2b
X-Gm-Gg: AeBDievLZ64phB8iIOdemw3PzAqe3M//K2xqnuxNSn+wp3uAXe2oITRPtYWjXf3qbGB
 wQ/4yodMgKVJeOBQDBmgbquXtgvmEp23TPLnbcMkxuP27P1rHG0Wo6QvPcCXemvd38vlM04rfQL
 74eGnaNXNXWUnWVWnHr26DIlBsJVXwwOEABoZbxIQXkuIyxXJDJ0sGRkYdP6+iey9DG3Q85cJcI
 tcPnZ1lVabrYSYzH0yK0F3Vs9dRUL5YruamKG/8sz1km0ZhwECYDXvPcHTlFgVTZ2J5DeXDWIjN
 B3wBQgifVcn772XhPu7U4bIR3otovwPPIC3weEXQ0mwefC4TuDxiHff096NJ5D8mEsCfj+K6ZLK
 1+T3DKeKWezcXpF+KKOkGQX6IZA2YK5QLJvJ9GVWXQC08Sgyft0LpaS5tYfI7I4dpMg1XeA1DJG
 PjN7B2RKV66osZUBtbFoXrncXdjljynpNE2h5YtdLJX0Ae4AnUQdGjYPfQgJXX
X-Received: by 2002:a17:903:17cf:b0:2b0:52b7:e82 with SMTP id
 d9443c01a7336-2b5f9ed031amr171109405ad.16.1776757335872; 
 Tue, 21 Apr 2026 00:42:15 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff918sm133191675ad.13.2026.04.21.00.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 00:42:15 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 2/2] target/riscv: Add standard B extension implied rule
Date: Tue, 21 Apr 2026 15:42:04 +0800
Message-ID: <20260421074204.2908422-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421074204.2908422-1-frank.chang@sifive.com>
References: <20260421074204.2908422-1-frank.chang@sifive.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Add the missing implied rule for standard B extension.
Standard B extension implies Zba, Zbb, Zbs extensions.
riscv_cpu_validate_b() is also removed as Zba, Zbb, Zbs extensions
can be enabled by the implied rule.

RISC-V B spec: https://github.com/riscv/riscv-b

Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c         | 14 +++++++++++++-
 target/riscv/tcg/tcg-cpu.c | 33 ---------------------------------
 2 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7978b4fad43..37a328f2df7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2259,6 +2259,17 @@ static RISCVCPUImpliedExtsRule RVG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule RVB_IMPLIED = {
+    .is_misa = true,
+    .ext = RVB,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
+        CPU_CFG_OFFSET(ext_zbs),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZCB_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zcb),
     .implied_multi_exts = {
@@ -2646,7 +2657,8 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
 
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
-    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
+    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
+    &RVB_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 840ef82350d..7255f73f5a2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -532,35 +532,6 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
     cpu->cfg.ext_ziccrse = cpu->cfg.has_priv_1_11;
 }
 
-static void riscv_cpu_validate_b(RISCVCPU *cpu)
-{
-    const char *warn_msg = "RVB mandates disabled extension %s";
-
-    if (!cpu->cfg.ext_zba) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zba))) {
-            cpu->cfg.ext_zba = true;
-        } else {
-            warn_report(warn_msg, "zba");
-        }
-    }
-
-    if (!cpu->cfg.ext_zbb) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbb))) {
-            cpu->cfg.ext_zbb = true;
-        } else {
-            warn_report(warn_msg, "zbb");
-        }
-    }
-
-    if (!cpu->cfg.ext_zbs) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbs))) {
-            cpu->cfg.ext_zbs = true;
-        } else {
-            warn_report(warn_msg, "zbs");
-        }
-    }
-}
-
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
@@ -571,10 +542,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
-    if (riscv_has_ext(env, RVB)) {
-        riscv_cpu_validate_b(cpu);
-    }
-
     if (riscv_has_ext(env, RVI) && riscv_has_ext(env, RVE)) {
         error_setg(errp,
                    "I and E extensions are incompatible");
-- 
2.43.0


