Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B4FE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsQB-0007XH-E4; Wed, 18 Dec 2024 06:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQ8-0007WW-Vm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:40:53 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQ5-0007u3-Ld
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:40:52 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21644e6140cso59736825ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 03:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734522046; x=1735126846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7nDbsNP0P9IVUZA2PPfFuTOFOME244LSx7bFTFtjMM=;
 b=fBhBjQYzNq2nhiJbthBwY8wDhttwH68aBV69Hq0QYZN45pCCX4EK9BLu+oq0cOXoGg
 bIiEx7sruZDWEMciLPMldR8s5XTtZnq0MizcMGGAIaDxOpfQXy74rsme4kjLPs5cBT3X
 ty9+mmheQzNsdnyTpKyPAUDzPL9iFbcSIrTs3pahGvzDp8P2WxhpdOPYeM0omol5Cw7E
 w8ONaWNSLn232PDi83cVT+cQToA3WaazcnXzrcnLnRcMtojFcDy5TXfJ5X5mWy+6YNRY
 8sGMDWfXD8+UrEIdL8T2gmxCYa8ElHG8inYWj0ftlTXpkvDuVzSert33sAF6wtaRwoEP
 rb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734522046; x=1735126846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7nDbsNP0P9IVUZA2PPfFuTOFOME244LSx7bFTFtjMM=;
 b=X/JK74kJ5v2tdS8SB0Q0+/NmI6mbl/rjGUlWR7SwRrlTUSKsc7ZeQ9YN7HXreePeq8
 JDKiiioq0qEbALClhEpv1npqj4zCJs5jBBRqMNIxQDjuo7qLmD+9Gq7nG2i68QXgJzek
 Ni6rNsFnVp20/j+tZRhbtoGMXxvU5s6Ql2Ro+OBmksg4yl+eYb85lG0EBmD8GVwNKnS/
 O9c3n8MsfoiQSsu+wKgmk+0Zio0Q6P6bkm8H2REIUH0XE9TrivV10VPBcpPXl/hjKcnY
 9lCAkCz6VmGfPOG1NnmxW8dpXAEOD2v20w/NHJhd+tnSzPB6r5A0ZFq04n9cB2K1uDYk
 vJzQ==
X-Gm-Message-State: AOJu0YxX159v29JwMYSSvJ9fshAAzRmK0sMssANYkN7BbQgoJBsnX2SS
 PvfhuvJp6CJeDQAod1R+CFlUyvp442YAR2W2UrZqYWekB2a5Pi8sVIiOkV/54OYGnGDgqo++S8n
 BKYQ=
X-Gm-Gg: ASbGncvQlLLwJiWNl0cYc3i53y/eiIRwZl4j0CN4czaQL4reCpO4jdp7OBxljhjhRFo
 aX5XWolid5IBU0K1tyeF6TDK8qepo6vTEh1akR2JM+rvZspZ4yjNifCjAMBCtVlW/LmkYbysHO+
 NHtdP1LLnXKmWLneUS437T0XTvezck4Hie75oNzKPqQoTpMCGSnsUCPCT1QUFY8hllXALJiLaU1
 CMCL93yIoz931LMp8M26OHA2WqE3RR7GLYwyD3gTJpO5qsjs3GVEqtTWp8G33emNZOPO78Vra8e
 1w==
X-Google-Smtp-Source: AGHT+IGlsTxBD11Yn/dOlXZOoT2TRNVVLitkx+BKIoe04tewVnlOIUsjD5pEhf1cb1KO2V3agTkGSQ==
X-Received: by 2002:a17:902:eccf:b0:216:591a:8544 with SMTP id
 d9443c01a7336-218d7230503mr33690345ad.34.1734522046233; 
 Wed, 18 Dec 2024 03:40:46 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcb447sm74462285ad.68.2024.12.18.03.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 03:40:45 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/9] target/riscv/tcg: hide warn for named feats when
 disabling via priv_ver
Date: Wed, 18 Dec 2024 08:40:18 -0300
Message-ID: <20241218114026.1652352-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
References: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Commit 68c9e54bea handled a situation where a warning was being shown
when using the 'sifive_e' cpu when disabling the named extension zic64b.
It makes little sense to show user warnings for named extensions that
users can't control, and the solution taken was to disable zic64b
manually in riscv_cpu_update_named_features().

This solution won't scale well when adding more named features, and can
eventually end up repeating riscv_cpu_disable_priv_spec_isa_exts().

Change riscv_cpu_disable_priv_spec_isa_exts() to not show warnings when
disabling a named feature. This will accomplish the same thing we're
doing today while avoiding having two points where we're disabling
exts via priv_ver mismatch.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3b99c8c9e3..48a55ba1d8 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -304,6 +304,15 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
             }
 
             isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
+
+            /*
+             * Do not show user warnings for named features that users
+             * can't enable/disable in the command line. See commit
+             * 68c9e54bea for more info.
+             */
+            if (cpu_cfg_offset_is_named_feat(edata->ext_enable_offset)) {
+                continue;
+            }
 #ifndef CONFIG_USER_ONLY
             warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
                         " because privilege spec version does not match",
@@ -331,11 +340,9 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
         cpu->cfg.has_priv_1_13 = true;
     }
 
-    /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-                          cpu->cfg.cboz_blocksize == 64 &&
-                          cpu->cfg.has_priv_1_12;
+                          cpu->cfg.cboz_blocksize == 64;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.47.1


