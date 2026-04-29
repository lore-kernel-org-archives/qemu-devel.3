Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF34FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwuG-0001bU-Ba; Wed, 29 Apr 2026 00:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwuA-0001Ep-Ur
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:12 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwu8-0001Fp-TY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b461310af5so2197905ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438327; x=1778043127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wbnW6wTvh9OcnGh3ZD0GUb5Ta4KXummfd+m0+FH/rJQ=;
 b=opzBG8Z+gn0+tH0rcRACI/AeOxj9YohvdZE0C6OICtUXFz4nWFcn/8TI0KgHCFNW6d
 /t5da7hq1gWDkky08XdOVBM9eiFiwfqhe/yfB5jU2QXOZN43+zPL+wYXT1O4PKaxTSdn
 +xAKaN1GGPf1g5w0eIBxkAbBu3G1g6/bTiITsWGWjoqLJHKkfKe/eldHA2mkk36v6LZ7
 fzYM2Qdq3bfRmzjdD2Ut+4LIKE8Tfv/frt4ZqYJulTTE7rwlQB8iaqTp1nQOpOD2B6aF
 1DP7URJ5186M+urvqji5On+bTO8odDLqGr3/537I6yVyshhc3FMzh0f+BkzLGQgXeaAr
 e7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438327; x=1778043127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wbnW6wTvh9OcnGh3ZD0GUb5Ta4KXummfd+m0+FH/rJQ=;
 b=k9M+9he26gOcKTbmzAI8C9TQJjbVigAgDtRS1i+z+spAaejiCMOSEJWFmSBK2RtHeA
 iyCjYNGNx0XabkDowDFiqRSS9Ehj1mXK6shoUnOdDdnFWG7uvY6nXUxOx1+m9L/yl9eo
 OEDUvHSthZuC1MpQ079O2WXGEbyl+3g4vQ/w7wdSti2jYYxZksOgWu4oMsY9zM14xhvG
 o83PGvrwekPFbsKXgyVJDizVce23HseHB7cErSBb2KRf9LahEGa0vBD9BmFi+80kewhd
 f9w693eQkZh7Ovy8oD/CzlLWKHCxuhFXvLzrxWwr4bH2aoBM7FqyyJF4k11VtbchH0CZ
 zOFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+J1K0BwEu/BcLx+k4t/NmXAwtpqd6LhqFKv9CVbNYPk8MDd3KBeXZXDAH/WG5QUXYUbRUtXEFr9oNY@nongnu.org
X-Gm-Message-State: AOJu0Yz3rMvOFbY3w72Qo/RGsis9A8WWs8q/K7Jrk9GM9FTdFpdI9r4S
 UdjZBeKEsg+d6UmIwz0uUgOah5dWyvPVDcEele1KY8idG1i+IqcUOPqA
X-Gm-Gg: AeBDies7OZB3Oih3AAIjYgbElE58jYRGCTH5kz5ub4j7LEB3bi0tvtPEPsEh1h0V5wB
 rZnkswt+xdenEPQueE1wO1X6kpJ8KHg23hcddpaPOw911Nu5QdVBOJO0ZS6pFP3FAfGydjF2rpn
 XvdqDMCUMf1d4q33bUoFmvNHEe7w8NoICWmEZomfshq7gPdxaEhYbi012GTBk47qzDya+q904NY
 0KsBz/F5VQBrvHY1X2BwykCp4QGzS+zm/tHUw4TuaYh5ppftQqGZO3Rb+IDWKbP61GtuCicZE6i
 KjbeKf7BzS0qPMHheXgxB2ibzSJ4PraUMIlc0im01EGva/NyZopey+jG2TpdG7TnU3/JQEvokfV
 Ab1DVYx+gPKwL+TUQl7AS6F73/hgZXh+tIAYgKTBm2/vJjumrUCqQ+tO1e+OhXQ5EBwP1zuHStL
 naIcKMntOnG7/CteFhVSlfQj9Xhrq3VCf02dK5XIPnX6GFJfy3HR90
X-Received: by 2002:a17:903:1a68:b0:2b9:66ab:85b9 with SMTP id
 d9443c01a7336-2b98823b5bcmr13974165ad.19.1777438326816; 
 Tue, 28 Apr 2026 21:52:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:52:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 47/51] target/riscv: Fix pointer masking PMM field selection
 logic
Date: Wed, 29 Apr 2026 14:47:48 +1000
Message-ID: <20260429044752.4176397-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260421093715.2995067-4-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 51 +++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 513bad21af..bab4153e53 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -131,13 +131,47 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
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
+
+    riscv_cpu_eff_priv(env, &priv_mode, &virt);
 
-    if (get_field(env->mstatus, MSTATUS_MPRV) &&
-        get_field(env->mstatus, MSTATUS_MXR)) {
+    if ((priv_mode != PRV_M && get_field(env->mstatus, MSTATUS_MXR)) ||
+        (virt && get_field(env->vsstatus, MSTATUS_MXR))) {
         return PMM_FIELD_DISABLED;
     }
 
@@ -149,12 +183,14 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
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
@@ -171,6 +207,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
     default:
         g_assert_not_reached();
     }
+
     return PMM_FIELD_DISABLED;
 #else
     return PMM_FIELD_DISABLED;
-- 
2.53.0


