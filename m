Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90852C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0pX-00052J-QK; Mon, 03 Jun 2024 02:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sE0pV-00050W-Ms
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:06:01 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sE0pT-0008GN-Qr
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:06:01 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70245b22365so2036256b3a.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 23:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717394757; x=1717999557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQb1n1ECxF1IqRCQkv43N/m9qyx1XX+jyCXZ5YT/P34=;
 b=DXdJUs1kJQLGpMK4IFp/jtfw03tKVDyCnZtMXB+59IG36NnUFzWS5+i0TKwnrQQXIA
 4hMCmogA6zoZCamfg2M0zaTrm2Ola8xKQ1yYfAHWIUiv2X88JvhN2hfJx0lbfWcJ5fh7
 AXwWhjCyYX1liTI69gkmZrkDi4Eeqg8YN7T8vaSQspCBz0/C7XFJEb72byNKbNzMNdUU
 1WaVefsVBR/mta4Esm9SgDIx6lBWl6bOsvg9bMkGqzo2yksQR1USKZt4hDbLNJmmd2+U
 EVJL1qiDiSPRqyLJnb1Gzz3wrcGxA0Xtyr8cz+a2s8XwE/77wR4A4wKYjeD/DuMVMGND
 7uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717394757; x=1717999557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQb1n1ECxF1IqRCQkv43N/m9qyx1XX+jyCXZ5YT/P34=;
 b=rV9sM38MqNV0+8+S++U2Fb0OYF+1TOAUu2cnlomBW9dAgZR5foqpEO1NjXZRs6wWIJ
 /FOT38qFoQyAu8Zwwwp4Nc1gKT06iXRcsYfcvzxSKfRoP0hKlwWzRQQ42wJKbLr9ABes
 nzSn9FZ2HOQQ0wMHXixA0lAsu5FGZnUnivfF96PTCQGdubmfe8lkA1AMarBVWqtIuMwa
 5RmhUmYRJfN03BhOLiqKK3EQjaSjuiAQZP0zeKzjnpX4Eg9UeNSpyuuITfT+Rinp84Qe
 TUdiPILKwNpfAkA6H9J+jYisb89Q2Beq/XvYkomRn6qizam8dS9B2FUHn5N+H3xAJX8m
 qKpg==
X-Gm-Message-State: AOJu0Yy4Uw9K1bMsCcmTqAlqXIqLaghvprBDUgOTiqHpzAqJOQSQVsa7
 guFYOYIDN3t4KAhNUO2beWTmwqWlDXHJZJiL8pCvCjscNIxU4uZyBe7I+3nSSJWF4KGpNwZy3rZ
 o1Z+AzpOhbGmD2kUcCATkvMR6Uy/4/4bA6t+8FstZyIpH22Qk1n807IXL7S1I4Q6ZvEPnlPI1i8
 XXUi8G8QwPPQPjyensj3p5t6Nf3y3z1VSz+Fff5fQ=
X-Google-Smtp-Source: AGHT+IGwY9h/eyrRjkVf+JMYGcmKiCKzJiTlPhPv8jPQQ3tohylKHC3cMUxP1vaC1w288eTxXS2bkw==
X-Received: by 2002:a05:6a20:7345:b0:1af:d017:c14b with SMTP id
 adf61e73a8af0-1b26f205d19mr8991721637.30.1717394756753; 
 Sun, 02 Jun 2024 23:05:56 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a77afa1fsm7149291a91.42.2024.06.02.23.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 23:05:56 -0700 (PDT)
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
Subject: [PATCH 6/6] target/riscv: Remove extension auto-update check
 statements
Date: Mon,  3 Jun 2024 14:05:22 +0800
Message-ID: <20240603060522.2180-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240603060522.2180-1-frank.chang@sifive.com>
References: <20240603060522.2180-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x429.google.com
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
---
 target/riscv/tcg/tcg-cpu.c | 115 -------------------------------------
 1 file changed, 115 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c78da393bc..570dff16cb 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -469,10 +469,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }

-    if (cpu->cfg.ext_zfh) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zfhmin), true);
-    }
-
     if (cpu->cfg.ext_zfhmin && !riscv_has_ext(env, RVF)) {
         error_setg(errp, "Zfh/Zfhmin extensions require F extension");
         return;
@@ -494,9 +490,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
             error_propagate(errp, local_err);
             return;
         }
-
-        /* The V vector extension depends on the Zve64d extension */
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64d), true);
     }

     /* The Zve64d extension depends on the Zve64f extension */
@@ -505,18 +498,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -525,11 +506,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -552,11 +528,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -574,27 +545,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -628,48 +578,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
     if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkb || cpu->cfg.ext_zvkg ||
          cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed ||
          cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32x) {
@@ -685,29 +593,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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


