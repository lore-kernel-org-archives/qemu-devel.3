Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACD2C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 02:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIfvQ-0007TQ-P0; Sat, 15 Jun 2024 22:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvP-0007Ss-LR
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:23 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvN-0001j1-Rl
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:23 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5b9778bb7c8so1709906eaf.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 19:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718506039; x=1719110839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmFiATPm95+4kWSDn9aSKWPJ0UC08eg4l8qOQUPIprs=;
 b=doSi+e5bf+4PZ61Y/x1a+hMeK85eEf6Npdz/8xPxJvvWJLQyexoOhwz8LEK7AmQA1k
 GpQuPYtbLq1TKRh3ERI/Y6A2mwvEizQJiY6RZudo5oHmJHH8sWeuengLZPguLzHSj4sL
 4inBMTFSCWeZSSVZAM1baNdUCslQ+CvTiZBdte4Z9tI/9v1i0aCYvUEm7kdEMUDvyPmY
 ksXHK7gWJryMe9XgH2NhAdqjPV4FUck0wBfVyqC4vOZKn+/u8geAXUaahS1boG+dkTqe
 MpeSH8SEeQ4Vmg7AVHisG7NWxKEBP1ILhVKPWic8GVcmoH++Lli2ZkAICePRjbD5L4mB
 pV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718506039; x=1719110839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmFiATPm95+4kWSDn9aSKWPJ0UC08eg4l8qOQUPIprs=;
 b=e2eK4aGNhZ0DCBSCjcCefpU8WRW2llCrTgTI1LwxTCt6YMBb7KghuzILAmavS+CY86
 FEyAeZamj206CEBGrhQmTKywJZQszOkj9euT1v5X9HLZXkY/ans8KkrG0CZhykcaRXeE
 Ogh91LN1x1N6w44/NPU01ZXIfv249jzBvjxClI0K77KgnqOZdgYRnSzHx6vol1aPML0D
 CfVTBFnG8y/iSzANzEvOGWlbU73bJ3YAgI6oN+iqZCwwR5tmViDqpGq4N1cSdwsR9Nfp
 rlqnwBqZvw88lbKCkPTypQB+l49puS5tsT282HetVZWXVKsLrKIL7r+adaJ7+IaMmPQV
 619Q==
X-Gm-Message-State: AOJu0Yxi+kZAsdfThbQHXnSkRj7uXLguWlFdNzk/zBYvsafHKRlooO+N
 vQyjm8B433I1cB9dU54TGhyThev2S2eHzf+wH5hJJmchaOePfmnoUcXW9CTb5ANvfEIf9wTOciQ
 MhkxJaQ0hDzdnamTOch7sPBe+LbiOb5um6vRhiNc74zJlVb64DQ7xxYACaMufUjaaxsebRx53pX
 nspChTV1FKF+p2ZMPaddemr1plgGkgg7R6n3GRT+o=
X-Google-Smtp-Source: AGHT+IGIGNdf8H4+ttp0asKeVEKhyFwPrQHuW9kxhEgoGo8whK873Nq6JJ5PFsWsbWxNvdO3db7VOw==
X-Received: by 2002:a05:6358:938c:b0:19f:3ee1:d1c4 with SMTP id
 e5c5f4694b2df-19fa9dcf95dmr857367855d.2.1718506039371; 
 Sat, 15 Jun 2024 19:47:19 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e7ca78sm56258705ad.106.2024.06.15.19.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 19:47:19 -0700 (PDT)
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
Subject: [PATCH v2 6/6] target/riscv: Remove extension auto-update check
 statements
Date: Sun, 16 Jun 2024 10:46:57 +0800
Message-ID: <20240616024657.17948-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240616024657.17948-1-frank.chang@sifive.com>
References: <20240616024657.17948-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=frank.chang@sifive.com; helo=mail-oo1-xc32.google.com
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

Remove the old-fashioned extension auto-update check statements as
they are replaced by the extension implied rules.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Tested-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/tcg/tcg-cpu.c | 119 -------------------------------------
 1 file changed, 119 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fe84d4402e..94875c8ec9 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -468,10 +468,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.ext_zfh) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zfhmin), true);
-    }
-
     if (cpu->cfg.ext_zfhmin && !riscv_has_ext(env, RVF)) {
         error_setg(errp, "Zfh/Zfhmin extensions require F extension");
         return;
@@ -493,9 +489,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
             error_propagate(errp, local_err);
             return;
         }
-
-        /* The V vector extension depends on the Zve64d extension */
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64d), true);
     }
 
     /* The Zve64d extension depends on the Zve64f extension */
@@ -504,18 +497,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -524,11 +505,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -551,11 +527,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -573,27 +544,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -627,52 +577,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -688,29 +592,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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


