Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D446BF327CD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF7Y5-00009L-4b; Tue, 21 Apr 2026 05:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Xz-00006X-Ak
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:35 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Xx-0007s5-SX
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:35 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82f68b3aaf7so1491859b3a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 02:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776764252; x=1777369052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTz8TCQOdQ53voh1Q1agVywI6+gd84Ne0Cae+aCo9jE=;
 b=fuNAf4XW+zI5duPQf5L3WDKLfnjP1+iCmI0Uzfcq8XrvctIyGUlfFuyILZArv/6Myn
 KLjyunjXbVUSrA5wwE5rtVaYmrY50TR8Ewi0vhvU0xJdM2z2rOCNwgqFAFhgr5aajsYy
 NHrDFiweNLrXdmT2bixEVIaWu14s3UmLyEzO0G3A0Hpy3r+mnTLsnjhTdVAAqMRdbB5K
 OWrPizhL51DLO8YtJkwNn6c94tZrvbKRx/u1KQkFPZj8y9x8o6trc+N4iS8UQ8lq3hUM
 u0Rr5wEVd8/FhLpfN/plY48sAvHxqW0yN/1YP6qFHqRwybgmlcb+0JxwyH/rui9/q6iU
 41qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776764252; x=1777369052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WTz8TCQOdQ53voh1Q1agVywI6+gd84Ne0Cae+aCo9jE=;
 b=etdi6vE5eUzbmXfa0CjEOHPmA2wZXSIRSvXToKvBhDlRBXjiyjoP4Lut+kDpU7zGFS
 Qc87N7jxPHmkPLcz7hiNNIwBo1WTGer8GaLYtaqBaM258j/9cSwsRhwQ8bztdsrW4Q8c
 dhoBCRjNLlB/KxufGWLZi9DRzTYztxBs45quPOQkJtysX8Qzcq5W9dcEepBaPep+DPDh
 gGizDFJQuiZrkItYXOWBrNz44S3TvQSprHjdNclRmlTWGwRFJorstMQWUgq31y6Y/6nE
 w2KCF4k6k2XMJB0pdQgcHfhncAdTJlV86ZTKAKrCzz+ZD3kQpZmGUwtpI4qMEGb5tEQK
 RtlQ==
X-Gm-Message-State: AOJu0YzcBt8PBMG83JDg6CM8SOkyWCoOQHnw1Bu5vvjiYybX+7v6OTsp
 F0/OqiZEdjxkJqRAoIE3PamUTyfCqUiQZ+jnf0fKODIRPGOo5CiL+ZbNPM1/pkoOr4bNt2WFCe4
 k4lYAck9lv+doGYfOzh+BM2urPRBzm6SeGkUoFjFHlV7kQE8uns8vtyW6O6LNCU4acQFK9qSilT
 x3uk1xf8h/67JE/s/xJ5dPDxrXwmBIaKupys7LIr6g7wwoP8El
X-Gm-Gg: AeBDiesu5NPtKa3cYkpeIsy50UIqU5VLX+UiRj3q7yEpRhLCk/uENvldExl4YpTWtMu
 +WWLhw82HwyYZBW0V/4nE1YaUHzuQLtcVJnmWpY9gWGA277eEJJjTPhZ8JNzOoTla8g677iEQrd
 m9ZMunXcKBvTkNFJz1Iqhaup3dbYJUFFIpNczD0BObHTN5+99egTp2vDBJrbG2jm2vv1H5dr+Bu
 LjLYfsm66mWJkO6dVODaYyi0HxAMwDsRKb2mXbKCrJpi3LWRcRbGI02bhu4vHV9b7Tti1yT/Zis
 Zw47X5OcCdzc7zBvDN70FtOHjij0JE+4QEVn3VS42BljgshU4d3m/Ybzj+bosaK5YNtJoUEJBF0
 pyed2wN+OXNTWqPtEcG3JJeML+F3Y2kMmY3UFVYYk9mcDo/9v1nQCV+bRFmvid8QSdLadVX2GR4
 EVFqe6z9PUK4MfezaSZGIuvPe1WIHY2zkNOx1mCNvPsNpjO2GSgSr5xg/pnS3N
X-Received: by 2002:a05:6a00:2d87:b0:82a:ea3:c172 with SMTP id
 d2e1a72fcca58-82f8c9341f5mr17547340b3a.46.1776764252104; 
 Tue, 21 Apr 2026 02:37:32 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981be6sm15904589b3a.9.2026.04.21.02.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 02:37:31 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 4/6] target/riscv: Fix pointer masking for virtual-machine
 load/store insns
Date: Tue, 21 Apr 2026 17:37:13 +0800
Message-ID: <20260421093715.2995067-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421093715.2995067-1-frank.chang@sifive.com>
References: <20260421093715.2995067-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42b.google.com
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

The effective privilege of explicit memory accesses made by
virtual-machine load/store instructions (HLV.* and HSV.*) is controlled
by hstatus.SPVP. mstatus.MPRV does not affect these virtual-machine
load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu_helper.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bab4153e53b..2b3fea81d50 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -217,16 +217,23 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
-    int priv_mode = cpu_address_mode(env);
+    int priv_mode;
+
+    if (!riscv_cpu_cfg(env)->ext_ssnpm ||
+        get_field(env->mstatus, MSTATUS_MXR) ||
+        get_field(env->vsstatus, MSTATUS_MXR)) {
+        return PMM_FIELD_DISABLED;
+    }
+
+    priv_mode = get_field(env->hstatus, HSTATUS_SPVP);
 
-    if (priv_mode == PRV_U) {
-        return get_field(env->hstatus, HSTATUS_HUPMM);
+    if (priv_mode == PRV_S) {
+        /* Effective privilege mode: VS */
+        return get_field(env->henvcfg, HENVCFG_PMM);
     } else {
-        if (get_field(env->hstatus, HSTATUS_SPVP)) {
-            return get_field(env->henvcfg, HENVCFG_PMM);
-        } else {
-            return get_field(env->senvcfg, SENVCFG_PMM);
-        }
+        /* Effective privilege mode: VU */
+        return (env->priv == PRV_U) ? get_field(env->hstatus, HSTATUS_HUPMM) :
+                                      get_field(env->senvcfg, SENVCFG_PMM);
     }
 #else
     return PMM_FIELD_DISABLED;
-- 
2.43.0


