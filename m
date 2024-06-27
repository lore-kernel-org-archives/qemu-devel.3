Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC3EC30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxn-0007qS-VK; Thu, 27 Jun 2024 06:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxh-00078K-Le
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:43 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxe-0002VI-9T
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:40 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d5654d5f4fso597833b6e.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482556; x=1720087356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tedPVH5tOOaMJ1rcUzWl+rZdz35T4y32JngaUuhBL4k=;
 b=P7R2koOFxVOjjg4BayZjS9cDt0npyvyNaII80UHOl3GOzbb/YMMoEzVGjiuVan+ndC
 l9dtg0qKHrjxCeIPKcR4FZMNxkpTkCbJKxZF3rs77rfUZwPtyI7ATNjuUKw8SDB2PD75
 L2Cuh7Tywdm/T5fvj0+lA/VWGwv/Xr0v4sKDaFzE6/31C04R4i8YYeQ4d7uEoL7kZrXf
 C4EnKuPg+R0X5clL6PxyiWuEqe9qeexSe4r9NW0SQ8rWR4ykDYt8w3NBX3FxQniqYnK/
 npEe03EMYBkszHTOkNn6Cw20+Pnctft6LRUE1De5g5r1J2Lbevpt9s2Rq4FcrSJsd3CI
 DSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482556; x=1720087356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tedPVH5tOOaMJ1rcUzWl+rZdz35T4y32JngaUuhBL4k=;
 b=w/WrOJnTmjnSsCwJpQJlc/eS1XD1LMFm+XTObVxiQ28q1jJjIpbnEc09gC6UBGuWqg
 RKOWvxjPQBcAqQr76lnG7MGgbG6+TUJi4yG9adPztFt+j+jZ1DeoPcraKfehawaT/LTf
 GRvBlBEhbpU5I25Nwkpb1NmjZsLtCugCRvutAbXWHzqwXfT+x3V2UriWuMDkRWTzTAiy
 mPr9xXa17zTdv/fU4G6JBdsnFCYXuzOM4jmxFkpfII5eH74wyF8vDypCN09Mm4zZzwNS
 tYqAcBLrQN1AL+3MdYNF21anUYVlrHT9Uyu0BgauGNfRFwCIq4TiNlSb01JJjhSlU/Mf
 4guA==
X-Gm-Message-State: AOJu0YzY3Hh0MetH11AxYAWxkqECET50RrC355IrMmgudVqOqlXoxa1b
 Sj4uRvzrwnzwsyGna6G/sGKB9BM/ZD5qkyLWizSSGImZIsMOikt0fPKWhQBN
X-Google-Smtp-Source: AGHT+IH+5rS9Z2R3xEdnXY4nMw8/TguA/29gryFOXrx0HPDbcqXM7uctFFqv/K7BgM06kS2uxjsTgg==
X-Received: by 2002:a05:6870:8183:b0:25d:921:75ec with SMTP id
 586e51a60fabf-25d0921ad16mr13707220fac.36.1719482556416; 
 Thu, 27 Jun 2024 03:02:36 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:35 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/32] target/riscv: Add Zc extension implied rule
Date: Thu, 27 Jun 2024 20:00:49 +1000
Message-ID: <20240627100053.150937-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x230.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Zc extension has special implied rules that need to be handled separately.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Tested-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240625114629.27793-6-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 1a3aef5bff..ccca9037ed 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -925,11 +925,45 @@ static void cpu_enable_implied_rule(RISCVCPU *cpu,
     }
 }
 
+/* Zc extension has special implied rules that need to be handled separately. */
+static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
+    CPURISCVState *env = &cpu->env;
+
+    if (cpu->cfg.ext_zce) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
+
+        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
+        }
+    }
+
+    /* Zca, Zcd and Zcf has a PRIV 1.12.0 restriction */
+    if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
+
+        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
+        }
+
+        if (riscv_has_ext(env, RVD)) {
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcd), true);
+        }
+    }
+}
+
 static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
 {
     RISCVCPUImpliedExtsRule *rule;
     int i;
 
+    /* Enable the implied extensions for Zc. */
+    cpu_enable_zc_implied_rules(cpu);
+
     /* Enable the implied MISAs. */
     for (i = 0; (rule = riscv_misa_ext_implied_rules[i]); i++) {
         if (riscv_has_ext(&cpu->env, rule->ext)) {
-- 
2.45.2


