Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40ADC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4ds-00087n-3x; Tue, 25 Jun 2024 07:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sM4dm-00084d-Bb
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:47:14 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sM4dk-0000eO-G0
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:47:14 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-718354c17e4so2384925a12.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 04:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719316026; x=1719920826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16P/qh8NE2AySnsAICHV0TNGZ7UDEyiWURrCAdDDKvU=;
 b=iEOJpB+w4KOw0JaDmM1Ho4g/UBNjgb96kfHFTb5jcrazuDxCGTrRygvl0+8SdunCr/
 m6hZDnZ3iQK+LxBixzPxwSz2KwoBri1YbSyFKPCdkEW2u3qPVT4XbBYp3LRtY+eQju0M
 dIYqqJcmmc7emILKbTSUORXYLs4dWp1KJctosCVlNmK8Ja9sHyIC6eySSfvgU2FPbb6T
 VpY+Wh0F/mfz6CwBx+VUSs0xUZ2b+dtbou9CfSCRgdoiUZM76RkdjOFRWtdAY74PaUT0
 X7xFEzy6MUlD5Wqqwaykf+8NwVABgz6wiGy1wcUiZkMunnsvuLkiIU7PpsoDYd3Bj/F0
 8OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719316026; x=1719920826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=16P/qh8NE2AySnsAICHV0TNGZ7UDEyiWURrCAdDDKvU=;
 b=a5gpep+qdGizysLUfEYrPpvbEcG4isH7NwIKVW8EkqW+1175BF4DuCZi1qG2oK8VmC
 o7XMWv/TredS6xYzh2zxC4GZva7wV1poeejnxG9Fw4Gd4UqifmDIoTmOoWCmGK6J5vRp
 sBqRy3TrDs22XcHPJN5om1qdZAlSpWxLoMpYMxSxY/XDrnKVl25ITwmb0kY8C+qimVfB
 mqCwDNhZdPMYeTHz1UEGxzgjBncINDfIpuLpTVV6jpV9jFLlJHQzTFWo1z+C6fcyrfLC
 k+KzB/v9/ensTAjdCayUf7QkbYKjN/5Y60+Z7EKmirkbs0AM62+qE13br7GvvgHwTNrb
 bCdQ==
X-Gm-Message-State: AOJu0YwdzZS3ZGktzx4LAfmt87C3QkVZ6C8aA+qfuEnkdvu7qoRmZ1mN
 iiENnL1F68dYW4MQD7xR8PtGa8UF3IEhLsGI03bvdHNwaZCo5NzD7Dci5hM2/5YE1LpKWawImyP
 aENT9DenvVqc1pv2BnlMsN9al8/zqwooV1K1kGoY4owKxvtISJ8Wgxl8Qo1wcKk4cYyvfVJh2OF
 YT+n3aKhMiZwoRd0l5VU7H7TS70SfL8dd3guUOr1Pq+XUj
X-Google-Smtp-Source: AGHT+IEwuI49ycMJVLzpclTqY+UW3I1TlJcdN6Ps0WXf5BmwZswudBC2a+xa7+0f+oaYtJwFDj4N8w==
X-Received: by 2002:a05:6a20:7a96:b0:1b6:a7c5:4fbe with SMTP id
 adf61e73a8af0-1bcf7ead34amr5675380637.14.1719316023785; 
 Tue, 25 Jun 2024 04:47:03 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb321d4esm79472325ad.67.2024.06.25.04.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 04:47:03 -0700 (PDT)
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
Subject: [PATCH v3 6/6] target/riscv: Remove extension auto-update check
 statements
Date: Tue, 25 Jun 2024 19:46:29 +0800
Message-ID: <20240625114629.27793-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240625114629.27793-1-frank.chang@sifive.com>
References: <20240625114629.27793-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52c.google.com
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

Remove the old-fashioned extension auto-update check statements as
they are replaced by the extension implied rules.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Tested-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 119 -------------------------------------
 1 file changed, 119 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ccca9037ed..ae25686824 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -471,10 +471,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.ext_zfh) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zfhmin), true);
-    }
-
     if (cpu->cfg.ext_zfhmin && !riscv_has_ext(env, RVF)) {
         error_setg(errp, "Zfh/Zfhmin extensions require F extension");
         return;
@@ -496,9 +492,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
             error_propagate(errp, local_err);
             return;
         }
-
-        /* The V vector extension depends on the Zve64d extension */
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64d), true);
     }
 
     /* The Zve64d extension depends on the Zve64f extension */
@@ -507,18 +500,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
             error_setg(errp, "Zve64d/V extensions require D extension");
             return;
         }
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64f), true);
-    }
-
-    /* The Zve64f extension depends on the Zve64x and Zve32f extensions */
-    if (cpu->cfg.ext_zve64f) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64x), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32f), true);
-    }
-
-    /* The Zve64x extension depends on the Zve32x extension */
-    if (cpu->cfg.ext_zve64x) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32x), true);
     }
 
     /* The Zve32f extension depends on the Zve32x extension */
@@ -527,11 +508,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
             error_setg(errp, "Zve32f/Zve64f extensions require F extension");
             return;
         }
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32x), true);
-    }
-
-    if (cpu->cfg.ext_zvfh) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvfhmin), true);
     }
 
     if (cpu->cfg.ext_zvfhmin && !cpu->cfg.ext_zve32f) {
@@ -554,11 +530,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    /* Set the ISA extensions, checks should have happened above */
-    if (cpu->cfg.ext_zhinx) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
-    }
-
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
         error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
         return;
@@ -576,27 +547,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         }
     }
 
-    if (cpu->cfg.ext_zce) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcb), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
-        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
-            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
-        }
-    }
-
-    /* zca, zcd and zcf has a PRIV 1.12.0 restriction */
-    if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
-        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
-            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
-        }
-        if (riscv_has_ext(env, RVD)) {
-            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcd), true);
-        }
-    }
-
     if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
         error_setg(errp, "Zcf extension is only relevant to RV32");
         return;
@@ -630,52 +580,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    /*
-     * Shorthand vector crypto extensions
-     */
-    if (cpu->cfg.ext_zvknc) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkn), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
-    }
-
-    if (cpu->cfg.ext_zvkng) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkn), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkg), true);
-    }
-
-    if (cpu->cfg.ext_zvkn) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkned), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvknhb), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkb), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkt), true);
-    }
-
-    if (cpu->cfg.ext_zvksc) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvks), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
-    }
-
-    if (cpu->cfg.ext_zvksg) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvks), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkg), true);
-    }
-
-    if (cpu->cfg.ext_zvks) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvksed), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvksh), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkb), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkt), true);
-    }
-
-    if (cpu->cfg.ext_zvkt) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbb), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
-    }
-
-    if (cpu->cfg.ext_zvbb) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkb), true);
-    }
-
     if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkb || cpu->cfg.ext_zvkg ||
          cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed ||
          cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32x) {
@@ -691,29 +595,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.ext_zk) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkn), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkr), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkt), true);
-    }
-
-    if (cpu->cfg.ext_zkn) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkb), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkc), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkx), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkne), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zknd), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zknh), true);
-    }
-
-    if (cpu->cfg.ext_zks) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkb), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkc), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkx), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zksed), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zksh), true);
-    }
-
     if (cpu->cfg.ext_zicntr && !cpu->cfg.ext_zicsr) {
         if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicntr))) {
             error_setg(errp, "zicntr requires zicsr");
-- 
2.43.2


