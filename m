Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D94FC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9Z-0006eD-H8; Fri, 08 Mar 2024 06:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9Y-0006dn-Hq
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:40 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9W-0001V9-NB
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:40 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so15992945ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896356; x=1710501156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RamutLMlYND+Cgk9K/tDVuT37Jg6F4UYKuaGf4PBXM=;
 b=nJe3Osonp8KoN3Up9J9096Pb5MuZIGXkVsAnWDsv0endMajaebWdtiOP9QKPCJB9/O
 wTTFUtNER0kGZ32tdlpf7h6Yg0fuJZd930Lfsf1jDJ0E7KIISzZuWZqnunkfc7muy1Xd
 qJYK0nbG77w14xR3i+P+veHDmEjhZzP6+C4+zrS7hTLTN/iPrqy/O+XZaGaHq4v5iPX9
 pz/IstrOV8i9deSX/+S1o/DRhuSkW3FUbgHCM2PIotUNPneFAqv5YZn7HKfqEMoz9W6n
 B7aPm+DPAhjPp45Io+quMMgyxdZxKA1T4dshZgI5bPtZnBAgC1auRK8XWnOIDxDK3lWR
 K+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896356; x=1710501156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8RamutLMlYND+Cgk9K/tDVuT37Jg6F4UYKuaGf4PBXM=;
 b=pEN4Hl3ZUbBuq1ebkAXoYyFL2TvDHAPTPwZlSWGQ0eOL/VzFKcAP+MQl8Ti/N0nzF7
 iXSYe1cp7PHSdmPkFKKLaB0oTfIRJTti0dynebvLhfw8hr5JbwRKFE2LtgOAhgJb2ek3
 0cJKoeK2hALsTQ+WSxZgKLFPv1NKPc5jxG8++MbHsEUCxSw8nIXTowjdzr9U/3w4qmqR
 AJgrMSLoM8y0F97D87bc/Psi4l1PGEf2QbA483rgbuBoIjd+3PWLl9OepRGl1diG2yll
 IVn77CkG1ExmyM1bVRRTsZbS99RXZgfK1qEgzT9pL/UMnnnItyTDBm3LhyrZDHSzUNvT
 8Wgw==
X-Gm-Message-State: AOJu0Yyw+3MwXkjX7brF4oO4zHCydrtl2ptcYgwkEidtgzRo3ZY3e6Hs
 Wd3zwfgX3bv1lMTNo90rwqskPQysgCsZSQAWkN05Mhqroiix8HqVQoNfH3GznT6yaQ==
X-Google-Smtp-Source: AGHT+IGY+87BR+eoc9YOhu50rfIAB2JmRGMdc3Ju25u/I6lPZhm7tAhOpeZm89MlEY1HJ6uq/OvxEw==
X-Received: by 2002:a17:902:6b06:b0:1dd:33:6efb with SMTP id
 o6-20020a1709026b0600b001dd00336efbmr10265807plk.30.1709896356212; 
 Fri, 08 Mar 2024 03:12:36 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:35 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/34] target/riscv: Reset henvcfg to zero
Date: Fri,  8 Mar 2024 21:11:28 +1000
Message-ID: <20240308111152.2856137-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Andrew Jones <ajones@ventanamicro.com>

The hypervisor should decide what it wants to enable. Zero all
configuration enable bits on reset.

Also, commit ed67d63798f2 ("target/riscv: Update CSR bits name for
svadu extension") missed one reference to 'hade'. Change it now.

Fixes: 0af3f115e68e ("target/riscv: Add *envcfg.HADE related check in address translation")
Fixes: ed67d63798f2 ("target/riscv: Update CSR bits name for svadu extension")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240215223955.969568-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 3 +--
 target/riscv/csr.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4c4fa79145..5507c11161 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -961,8 +961,7 @@ static void riscv_cpu_reset_hold(Object *obj)
 
     env->menvcfg = (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
                    (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
-    env->henvcfg = (cpu->cfg.ext_svpbmt ? HENVCFG_PBMTE : 0) |
-                   (cpu->cfg.ext_svadu ? HENVCFG_ADUE : 0);
+    env->henvcfg = 0;
 
     /* Initialized default priorities of local interrupts. */
     for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d4e8ac13b9..cc9cef3d85 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2133,7 +2133,7 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
     /*
      * henvcfg.pbmte is read_only 0 when menvcfg.pbmte = 0
      * henvcfg.stce is read_only 0 when menvcfg.stce = 0
-     * henvcfg.hade is read_only 0 when menvcfg.hade = 0
+     * henvcfg.adue is read_only 0 when menvcfg.adue = 0
      */
     *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
                            env->menvcfg);
-- 
2.44.0


