Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BEAC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0pV-0004zE-27; Mon, 03 Jun 2024 02:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sE0pS-0004w8-Nh
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:05:58 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sE0pR-0008Fr-2g
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:05:58 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-681ad26f4a5so2304938a12.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 23:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717394755; x=1717999555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xI4qPquWz5Va0F+mU+/hCmhOwwCA61d1y9ApdTJj+1Y=;
 b=ZIXVAqktdIhvEerMdEH8AOsTRctI1E5s3zPGNjdTV0do5v2zPK5fL1nd9vFX6ckY01
 pGp7D1DYnGeQJMleQHQCzqIJ4pKXKYK9rns6W2Ox3jOp/DAMCL+9Q+s4QrTD0+NXcpvE
 CLouHummkdWjWX8ZY401JgS05BIMiW/kwMaBBu4KxO2YAs6h938RU2GNXzjoYT1jhrFE
 X2DrnbmtMTX4y4jFB4L8kOdaKC0K5RkBPEX8qcZxj6qKpJcOvoknywP7vmbC1CH0zBDw
 Dq0yOJSE+PTkhZfy2jT9yTu4X1lY3ZQL7o45sBeT//hqAoYxXdJwQVLkeXHGi1R9KvcY
 3Ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717394755; x=1717999555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xI4qPquWz5Va0F+mU+/hCmhOwwCA61d1y9ApdTJj+1Y=;
 b=uvxr3xXGKmoRXTZiU/H96gFg/+ZKHQBspsFR6EgNkbav+0KSvQxmZI/YtvSRtoNd9y
 QQB6jLaapj7nz8DNGkXWYLZQt28AxMwzbb6VRqYuVKh7SPlxPlisDAL4dRIY0lSPUXup
 /vy2AfA2elwCVB0xqo3eep5G/+EPa6RslJ7omFXlrNCNFL3f6F84Est1yg2pq32P3hOQ
 aR5SnTE4+9YwY59vKwYef1sBjo9M7RFrygcNIrY2KpTC6dE9ObeBYX+lsidFsU9inNol
 LEshD/rAC1yDcwgY+u4OpEv059kuEOEh15KsitQKcskl/l4QXUSXrzdOlBLKIWzEApXU
 0pAQ==
X-Gm-Message-State: AOJu0YyKDpqnXZHkTYVa72qyVhfRXVdv6RCtvSxW62sUaN9/cgt19683
 jMBIRFSLODlt7A2LbJsN7a/Iom/Iz9mMo0Ziot80rwV7A7vO6ufPQq9bCVMieoB7WgqDcbNmdvX
 sCOm8Aiy4uPQdt8ODHffsseqZ4B0j6fTPpPA3Paim0Ej20l9+9DAY3HX32YiCzV7enReO2StOyS
 JS/Q1JpsI+GFZwizGeQ7jkqs5saF51kpubX9Elh8c=
X-Google-Smtp-Source: AGHT+IFcTPiXvujfF1ip4aTMtt5zvEd8RE8qki+jzzfpEpTJ3sLputW1fufTlJHV3UkLbDcHIbVZJQ==
X-Received: by 2002:a17:90a:748:b0:2c2:3b14:7879 with SMTP id
 98e67ed59e1d1-2c23b147a0amr1144412a91.32.1717394754498; 
 Sun, 02 Jun 2024 23:05:54 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a77afa1fsm7149291a91.42.2024.06.02.23.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 23:05:54 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Subject: [PATCH 5/6] target/riscv: Add Zc extension implied rule
Date: Mon,  3 Jun 2024 14:05:21 +0800
Message-ID: <20240603060522.2180-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240603060522.2180-1-frank.chang@sifive.com>
References: <20240603060522.2180-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x536.google.com
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
---
 target/riscv/tcg/tcg-cpu.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 243a8547a2..c78da393bc 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -892,11 +892,45 @@ static void cpu_enable_implied_rule(RISCVCPU *cpu,
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


