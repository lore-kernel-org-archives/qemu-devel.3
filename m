Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D46BCD1280
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 02:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpfQy-0005J6-K2; Wed, 27 Mar 2024 22:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rpfQw-0005IO-OM
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:24:02 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rpfQu-0007ln-WF
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:24:02 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e0f3052145so4944035ad.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 19:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711592639; x=1712197439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tF2OlAR3EBMx1Df6LSEev281Y2uuwVlXzu3oKih88BI=;
 b=Vmby8dicAfgbKIWhP390pdRLDA5rNc6Zo+zyxn/D3CaRf9h1846zxsTJHMnMKUJ3JQ
 rptslCysH1eij9sXHsCq5EW5zWEUFaiBhQpxByYGSNbGffmR35l/MI/tcf5bh64s2fng
 rZfA5sJxBWAn0sLGS2MLzfGyPzPgwlzlsOtZ/0dyQMuXU8dfogj85KuRYC5CV97EMJ12
 tGWHqMQwO5UOsDE1MjEDMbu6m7WqWtCzmEH/+6SslWSH5WePDVRWX7z8fRFxieZSFoX5
 e1ZqAWEARIDxBm+fkNiset1IgThj3TdJjTrZC9sHAy8VLMmQZ00708AIq2F1HeCAzqP1
 mTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711592639; x=1712197439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tF2OlAR3EBMx1Df6LSEev281Y2uuwVlXzu3oKih88BI=;
 b=hyLP6JkdbggUSKCOOrnkdTuXn+4tkQBJbFgra5Q3RXbdM3LCdAdJVuHpvCBqhpKVjR
 7uJW0HSfvk2PpBc+Cfy8jo1hNuWSa8Q4vzTEYP3G3Lv805kDq9aSiq0o6dQOhpRy1eyB
 w0gqeiZ2aAs8AEVG+WHc2Ph0sK1hFiaSQ4sXIas6aisQ4gg4g1//OpHWopKA9JH5OB5P
 I53eMu5aFwGH0dOHvM3HUIFGBse78kLiJDjkB0hOtcAgFu2i1Y1sAXRZ/n9v3Dhodjsd
 UM6LKQfREteXCpAUg8OphQeS8LPPSSXkmEsQr3qfQbMojKBq536LJt/85f9umV2geBNg
 s33g==
X-Gm-Message-State: AOJu0YyVIv6sloaVvKIbL9JSvYndbyM9L1Zb106kBEd2e3AFOr6wHnxt
 4yXUD1hYu/Dsw53NNtPDua3Na+6TiPS6J8SLfwMEietxqaV/Cy6FeuH2U+RGZmgGZyM80PkxWu3
 e8ICPodiSy96RRHfCHoHq5dZM6EhM0+N1HRSgGUF1iiy2hIPEtA1GasS3wbZGKHwn2zxukjR9ya
 bI0dZbTPMwfEUvwZL1CDNxA9FebfeICVD5vtgrZOw=
X-Google-Smtp-Source: AGHT+IGDdy2ggZTqskIbJ8nYyIIk8X2IXPA2mlJaibfkLs6Dfp54Xb6oEoy1mfVN2L7Dx/s/tudICw==
X-Received: by 2002:a17:902:a3c4:b0:1dd:651d:cc47 with SMTP id
 q4-20020a170902a3c400b001dd651dcc47mr1298164plb.28.1711592638492; 
 Wed, 27 Mar 2024 19:23:58 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a170903230900b001e14807c7dfsm247424plh.86.2024.03.27.19.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 19:23:58 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 2/3] target/riscv: Add support for Zve64x extension
Date: Thu, 28 Mar 2024 10:23:11 +0800
Message-ID: <20240328022343.6871-3-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240328022343.6871-1-jason.chien@sifive.com>
References: <20240328022343.6871-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x631.google.com
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

Add support for Zve64x extension. Enabling Zve64f enables Zve64x and
enabling Zve64x enables Zve32x according to their dependency.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2107
Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         |  2 ++
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/tcg/tcg-cpu.c | 17 +++++++++++------
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6bd8798bb5..18e1ae66f4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -156,6 +156,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zve32x, PRIV_VERSION_1_10_0, ext_zve32x),
     ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
+    ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
     ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
@@ -1476,6 +1477,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zve32x", ext_zve32x, false),
     MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
+    MULTI_EXT_CFG_BOOL("zve64x", ext_zve64x, false),
     MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
     MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
     MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index dce49050c0..e1e4f32698 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -94,6 +94,7 @@ struct RISCVCPUConfig {
     bool ext_zve32x;
     bool ext_zve64f;
     bool ext_zve64d;
+    bool ext_zve64x;
     bool ext_zvbb;
     bool ext_zvbc;
     bool ext_zvkb;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ff0d485e7f..4ebebebe09 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -498,17 +498,22 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 
     /* The Zve64d extension depends on the Zve64f extension */
     if (cpu->cfg.ext_zve64d) {
+        if (!riscv_has_ext(env, RVD)) {
+            error_setg(errp, "Zve64d/V extensions require D extension");
+            return;
+        }
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64f), true);
     }
 
-    /* The Zve64f extension depends on the Zve32f extension */
+    /* The Zve64f extension depends on the Zve64x and Zve32f extensions */
     if (cpu->cfg.ext_zve64f) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64x), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32f), true);
     }
 
-    if (cpu->cfg.ext_zve64d && !riscv_has_ext(env, RVD)) {
-        error_setg(errp, "Zve64d/V extensions require D extension");
-        return;
+    /* The Zve64x extension depends on the Zve32x extension */
+    if (cpu->cfg.ext_zve64x) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32x), true);
     }
 
     /* The Zve32f extension depends on the Zve32x extension */
@@ -670,10 +675,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if ((cpu->cfg.ext_zvbc || cpu->cfg.ext_zvknhb) && !cpu->cfg.ext_zve64f) {
+    if ((cpu->cfg.ext_zvbc || cpu->cfg.ext_zvknhb) && !cpu->cfg.ext_zve64x) {
         error_setg(
             errp,
-            "Zvbc and Zvknhb extensions require V or Zve64{f,d} extensions");
+            "Zvbc and Zvknhb extensions require V or Zve64x extensions");
         return;
     }
 
-- 
2.43.2


