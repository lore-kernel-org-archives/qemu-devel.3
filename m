Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C389BC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 06:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEkCI-0000uG-L9; Wed, 05 Jun 2024 02:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkC9-0000rM-1o
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:32:25 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkC7-0007Dy-0R
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:32:24 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-702555eb23bso3232028b3a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 23:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717569139; x=1718173939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUHaWKrkjjxkzFjAncjkTR5OkCCN3tHK6A+IJrPNlu4=;
 b=dT4dqtNyw73jmF4SPxBHilFq4uV1BVtrHC5AORXDcV3jYT4WqMy0gjSXhwyVBXSJlw
 rAtCTroHCAMU5WfKLDBO8+SFgqEhPPJuoCYVmu2Nkds1Ww60SlHu+HtDdYJZ2jDcTXtm
 CMD4l4ShxtG2C4ylxs0JEXjOHSiwWdnb3rWvx7I8wu22BhELVDmsJ+QswrWkfOjPKYv5
 2OKqvRN9uK0dNdHi9FkB41oidrsuzGyPDkabni/ctW3PDyO8tVoLiQ62521hLUQoqwjJ
 9+gqjDnvJgKo7bmINdDw+zcyTPwuoVJ/1vUtN4bQ9CDCEbctMnW5m7xQhuT3TyWOQW3t
 CSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717569139; x=1718173939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUHaWKrkjjxkzFjAncjkTR5OkCCN3tHK6A+IJrPNlu4=;
 b=cvP98xEL9wBORWzLy1Oo/zvYn5ghnrxZAJlrcTKnCdfSRu8YgTuspsI8motbek3M4D
 uwJqY9MHvS8Nf78PsNBBFHDuoSQT/aqAPEIKqUEgQ/Eh2yLRnl1wmHfsvlm+vjgtwLcN
 n2PKpBs912hyR90JHfoAMXWlq0UruUTFM/EykLoRwL0y6RaiOLkWI+SfK+CIWtRR4855
 haFQ3aAU6Dwe9Ho54R+FfUyj3ctjan4U6wsvb9qoNNuWraEPPShudR4RRHgIBB91PLY2
 9KdMQdul7vCkZnjTlNOxmSJamqyNZ9CS31EJNiybp8G5F32zaoPrebTHu0dlIiSWJpZw
 0VsA==
X-Gm-Message-State: AOJu0YzexTH6Df8Tq1XHBHSiWkg0gsZCkJnHQuRBpQba81+273h4LZnS
 vBZW3N9aMWjf8Ei56NbltUG/PDyLYjbz2auoor87HgGFB6l5eA3lgnfdHX46tOmsDv2B026iXBq
 Kki0gvVZ8F0i1GRRHY2AiQx3PZ+YAK4P6tJQQzWfQ2ZTG0jYlbdMgYuFFCYz63RY+A9S6CWqjb3
 HIE/Kn1omAs353GSf9Z72smmX3HJvkyCVG18YMRtVAsQ==
X-Google-Smtp-Source: AGHT+IG+Yo3/phNKC39aFvjuPngb8DmHOPWuJ4S/HK5RViIZJHXz0mrbHBqnsKDF82QbJDOo5r1f9A==
X-Received: by 2002:a05:6a21:3996:b0:1af:f875:63b0 with SMTP id
 adf61e73a8af0-1b2b713cde5mr2004307637.48.1717569139419; 
 Tue, 04 Jun 2024 23:32:19 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f632356c84sm94819725ad.76.2024.06.04.23.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 23:32:18 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH RESEND 5/6] target/riscv: Add Zc extension implied rule
Date: Wed,  5 Jun 2024 14:31:53 +0800
Message-ID: <20240605063154.31298-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240605063154.31298-1-frank.chang@sifive.com>
References: <20240605063154.31298-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42c.google.com
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
---
 target/riscv/tcg/tcg-cpu.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 899d605d36..ed10ac799a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -897,11 +897,45 @@ static void cpu_enable_implied_rule(RISCVCPU *cpu,
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


