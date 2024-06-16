Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D591C2BA12
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 02:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIfvO-0007S7-4u; Sat, 15 Jun 2024 22:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvM-0007RS-Pm
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvL-0001ia-8w
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so24092915ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 19:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718506037; x=1719110837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uaT4Xh3LINeUYOT/JS54yQJHfmaV3gzwWveVYqVCxGs=;
 b=UR9S0ABn+I/Rir074clhBVaKN4NsXEGKnRPiLNhdbtznwkLjID7+shbY4x5bzjN53O
 7F63Fq72aDyVzq9UqNxiiFaamx5bDl0dueUYakjNvpevn7cyztA3sj1PwXQwDLzo/TGb
 BXiyaTnaasXOx1eCsNwJjKfKgBnBXNC4nrFk/86xYzqQmn2+CYNWUaFOI0iQxeuIrh1i
 vKwZGL/LU3rgCchjTo0c5s9zbr74ltUUQgAVAGPRWaEcw7KDxO6gIA3bjBb7WzPzwMwG
 +tKTf5Oy5epUGqiFDAYizBYaV9wk++QhuGXV2eHEx34IrfprH56h47fJ0+FPHzazn/wy
 yZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718506037; x=1719110837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uaT4Xh3LINeUYOT/JS54yQJHfmaV3gzwWveVYqVCxGs=;
 b=MRECVX05XX3AUVu4g0eqIlyi8ekDpyaBxRqbXLNwkJRV2KbiOJBPwVoG07GTqvVmFR
 8eBhcqIYsVe3s9YFPBq140XH0cHURIa9LVuywbil1VLcAvV/DmYeu8p+v3IgAAa0kWyp
 Hj4OgFEia/vRZKjcZWf19G4vQ1WmQ7D/ygWlgXVCTrY5zxJuIFjIylUlg3L7hAcFxNOK
 yKKzkm6Sv7NiK20hvfIRLI7VqUMenLAyowrWx93Gl4TVsk8TKKpF7dNNH9cEJNR9MsLY
 0idUiyNp6WlaPdGB20QG4k6u7krI/QFSvWWNGTE1+bWPgBJacKVSR72GiBdrHG3gCDvH
 q/Ig==
X-Gm-Message-State: AOJu0Ywrq49dtNM8KT4YPJ7oTOu4snNwGyijUvHw9ov5Ca8hTZ6YV+1S
 pVC3iT8lnUtR2YKniPH74T3W5XjiIlzLprmF1H0rSdYmi3x/lqq9ad/1ymy1IjxKIP/CZY06tf5
 TmqHzWbdrpPctlL6/OIkH/8inUEhIf2qzKbh93o6kkFudKY2QflbDTa8w+C9aycSVEp940exVPU
 hyPGeR0HU3aDWTrbeXEGAxcO/WYgg11NSfomhyQwE=
X-Google-Smtp-Source: AGHT+IG3c4OeDjeJLhJPvtcRht2oOmNCpxHC4V5M9giqrlh1ui68fPFYedKuxCAnuLFa9jSlBa1z3A==
X-Received: by 2002:a17:903:11cf:b0:1f6:1a86:37ba with SMTP id
 d9443c01a7336-1f8620ae5ccmr95840855ad.2.1718506036918; 
 Sat, 15 Jun 2024 19:47:16 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e7ca78sm56258705ad.106.2024.06.15.19.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 19:47:16 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 5/6] target/riscv: Add Zc extension implied rule
Date: Sun, 16 Jun 2024 10:46:56 +0800
Message-ID: <20240616024657.17948-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240616024657.17948-1-frank.chang@sifive.com>
References: <20240616024657.17948-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/tcg/tcg-cpu.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f8d6371764..fe84d4402e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -902,11 +902,45 @@ static void cpu_enable_implied_rule(RISCVCPU *cpu,
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
     for (i = 0; (rule = riscv_misa_implied_rules[i]); i++) {
         if (riscv_has_ext(&cpu->env, rule->ext)) {
-- 
2.43.2


