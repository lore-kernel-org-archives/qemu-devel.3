Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDEFCFD2F6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 02:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOo8g-0005rR-Hk; Thu, 27 Nov 2025 21:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vOo8e-0005qd-HH
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 21:23:12 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vOo8d-0001Jy-36
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 21:23:12 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-298456bb53aso16457475ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 18:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1764296589; x=1764901389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MgWZMKplKLzQHdJiRAUgQ7Lq/Un9aIIVTrxwpIRJFs=;
 b=bOEZ5ueHd4rDD11wmY+XQrmG2ke7j5RjUXBgXyP1KBSTciCYdCnPnGJ5WJu7kgWGIH
 5vXNNUMGuauGSPy7s3j5+UwW0MvZfLn7KpthPoOTJnbrygTHisqqpADolMPxKKBSkAO+
 +XYWcqEAJpmKmV7rX+fnU8y1BHeknjyjUBtWi3MXvNSCOSOgCZs5SiBWRUh0W5Tpm6Xl
 wwyyD3B8xkV7Z7FXexwmtMz2kdjLRoeQuXc2OmMf/P3J2Eeby3T3S3UR+d3rOtCee6pZ
 hZNJyx0+Rf7OZNxBIzb7JS/TL8e2qMgcSmDevSUyeUyxLZ8WOQrXB/5/zSf7stg2dqM/
 NOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764296589; x=1764901389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7MgWZMKplKLzQHdJiRAUgQ7Lq/Un9aIIVTrxwpIRJFs=;
 b=DGRRFJRR5pEPPcdM/MhpFVpyHTdefBV8XTVXCexBM3LJbrO5N5tOKjDjQp3e/Jc9JD
 n5qSTWDnyqPTlI/6QUabqSnuSOiEz+TMkyXHLw+jZWbJjm6eeG493LVTRw4OolH74fPt
 qOWtu1bZ1++MerY8N2CkIjdaifmmiLTrMRfXKlWL4jOh467D0qMdUmi6fKrsOOg3QeZb
 p/bSf9CF2+AGHEt4b823d0Hz52dDYlrhEPpm6CNeJlmdQfK6vBJjzPL1ZAHohnHQWZr/
 JSqBtTt2AJJZDQn/fWCUcyQgw9xQVXeWu0VH8vtmQT0wkQnMY/repm3wNynASnLszLaU
 COTg==
X-Gm-Message-State: AOJu0Yy+8QDcAZHm4syED+QPBWpu5sNjy0/AwyE1TqUWXBwlyYp+QxiG
 HsrOYb4P/mIOpX9zsLR9RyQjSa8Nk0rokP/bKocXdFgJ+9MUkxdrwsePNqJPzcaHcyj7uPJLZXF
 Rid4ZnVsFmQh2m+woWwEcK4eeHfBbIZvhNCfjBddsHSlH8P1Gm//jTVgKRR4CmEBvQO0cQgoRLE
 cNsgGQ8STD0I6WCck8fvLF8VLaMllJcFntAX2WhlBmL4Rojg==
X-Gm-Gg: ASbGnct9umgHJCPAj8BcDbog3269TFPCEwNyiIrwyEXprzys4O3Zrp4S/QfVqF//1h6
 qV6LSLBKw80VZ8oaLX/uO7Je/XO/eWZm/bAucdf6Sb2Io1SmgZ+4iX72j9RbbhXNmRjcZbG9kXA
 CDXIlbD7Qf6SvIh77Wl/cBLMY1iuKjCwSnGxZFeEiR/4MlGu152wFHOPl8HtI8wh88TqcuGRFaJ
 2dztH8O067AOe2pVul6PMIhWkgw0ZsE1wOv39N7nkeQSIo4y0JXhNFomX8iMVkSMqCeJNdy5spp
 ls7yDWdgINa7VxTVO1LskNHI3eNXDMNjW50bDUa/qMrqWM/kWBMjalDK/uh01gsL9QKWtddZAuT
 KI2u7Wi5Wb18dRvJV8K5JFHuwCWS7fwkaM+hvsET1Eryo8x+arBJfKSdReVtdDi9/dR3YfWNUdS
 t8NVqppNCPXMCmuOXWegAK6C25sTDSn5BxIQTZ+Q==
X-Google-Smtp-Source: AGHT+IFs/cTeaVBqJE8cKZ2bZTS4W4xT65bwapd3mXiklnb1qV42Q2L/kHxz2gx5R032TXTrHG3fdA==
X-Received: by 2002:a17:903:244e:b0:28d:18d3:46ca with SMTP id
 d9443c01a7336-29b6c6c2bc8mr293580215ad.49.1764296589121; 
 Thu, 27 Nov 2025 18:23:09 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bce4418c4sm28652845ad.24.2025.11.27.18.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 18:23:08 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 1/2] target/riscv: Update MISA.C for Zc* extensions
Date: Fri, 28 Nov 2025 10:23:00 +0800
Message-ID: <20251128022302.970294-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128022302.970294-1-frank.chang@sifive.com>
References: <20251128022302.970294-1-frank.chang@sifive.com>
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

MISA.C is set if the following extensions are selected:
  * Zca and not F.
  * Zca, Zcf and F (but not D) is specified (RV32 only).
  * Zca, Zcf and Zcd if D is specified (RV32 only).
  * Zca, Zcd if D is specified (RV64 only).

Therefore, we need to set MISA.C according to the rules for Zc*
extensions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 440626ddfad..752eee32289 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1150,6 +1150,37 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
     }
 }
 
+/*
+ * MISA.C is set if the following extensions are selected:
+ *   - Zca and not F.
+ *   - Zca, Zcf and F (but not D) is specified on RV32.
+ *   - Zca, Zcf and Zcd if D is specified on RV32.
+ *   - Zca, Zcd if D is specified on RV64.
+ */
+static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+
+    if (cpu->cfg.ext_zca && !riscv_has_ext(env, RVF)) {
+        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
+        return;
+    }
+
+    if (riscv_cpu_mxl(env) == MXL_RV32 &&
+        cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
+        (riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd :
+                                   riscv_has_ext(env, RVF))) {
+        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
+        return;
+    }
+
+    if (riscv_cpu_mxl(env) == MXL_RV64 &&
+        cpu->cfg.ext_zca && cpu->cfg.ext_zcd) {
+        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
+        return;
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -1157,6 +1188,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 
     riscv_cpu_init_implied_exts_rules();
     riscv_cpu_enable_implied_rules(cpu);
+    riscv_cpu_update_misa_c(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
-- 
2.43.0


