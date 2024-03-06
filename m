Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF05BC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhum9-0006Rp-H2; Wed, 06 Mar 2024 12:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rhulu-0006Nx-G5
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:09:41 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rhuls-0004H1-TS
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:09:38 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dcce5e84bcso57462945ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1709744974; x=1710349774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NANrwSvhnUkpkGin+OHZ/GsWuBI+HrXVmK2Zgc4rg/0=;
 b=hUT9znR92z3+T67/bbcgL0HcEHynrYDpp9Sz9Jigj+d58oMTBWcbM/ZQnN8fSR+7jv
 YJVgjuTFnkmi0AtprEivBgtHIIZ+vAz+je55XPfrLHJCE0EHMZJz6zy8KnT88Bn6IMeb
 nvSHJ0HDF0MmH6VkeUKJD5zAsRpycDmnD1X4b1gNiMMgi+dworUNhPNDefCQ4pQdBTHr
 AN2+8JOL+YRoZwkvTVgEvj1z/FOuiXwE5og35TGS1DWTLlyUEMdBYy7cJoWATsYsaJV8
 OHaOTvsUjXNRBdBZZDl+8hPYCl07bQVi0ySPviqseIrr9KBX/MHU3YgTzLG6CmWYa2jg
 WqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709744974; x=1710349774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NANrwSvhnUkpkGin+OHZ/GsWuBI+HrXVmK2Zgc4rg/0=;
 b=qCWkk0yLustmy7AHE5jgpMUjQCTfWGMCFI4toDsRGBBq1+pwSluDwzwSN73sCjoTnW
 PCgBSDCurAoHW6NfWI2aW2jO9cQzHah5dxxSiShycdcliRvsITboUDeBjMh6Zd0DG0V6
 0sec04Gz7rkuqQv6H8hCJApLg/3dT9OC1Z7PHqQPW0zxmekaeB6k1R5bywiAOVXUWs41
 cvW/PsHch6JM2MRDgYhvJxU7LBfskdWnr9EtwcQX+8gRpHhleGcvTzf3Z4m45xVRXUMi
 Ahr0JdLzKuTd4IaSDKVgObGaFpAiYPgKcYnBqn4rzg4WpCqRclys2fMWtwwdNxYwWxkR
 kJoA==
X-Gm-Message-State: AOJu0YxrDIme+NWGb7r7O4vcDUuhXNTwx7XlSR2lsWx/JpN1FjqPI/Pq
 VKSczGFADJitpNX1gn9OkqEazrmcc7Whc2eFm5GLQzaisYYEHKCdF5SeD9acCzJvAYuESZrtUZK
 F1LZDLdY6Wc4CumN0Fd3QsEX+bRHUMUDRs+68bX2zBOXEgbclPg/gQSEy3HJOnSYwzp0Th88GWP
 DoXF0m6EI0UPwNpY4RncGQp8Gh2AG3IACdA9Hm7Yc=
X-Google-Smtp-Source: AGHT+IE14ao7XcIiD3/wWIGqWyH0bRIP3PDLm6hwuF7IZZu7oKSiUaASxrV3uQt/jvneHjN+iEKhYQ==
X-Received: by 2002:a17:902:ec92:b0:1dc:42da:bad with SMTP id
 x18-20020a170902ec9200b001dc42da0badmr6520824plg.62.1709744974334; 
 Wed, 06 Mar 2024 09:09:34 -0800 (PST)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a170902e74800b001dd091cbc4esm7230076plf.181.2024.03.06.09.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 09:09:33 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH 3/5] target/riscv: Add support for Zve64x extension
Date: Thu,  7 Mar 2024 01:08:36 +0800
Message-ID: <20240306170855.24341-4-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306170855.24341-1-jason.chien@sifive.com>
References: <20240306170855.24341-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x636.google.com
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

Add support for Zve64x extension. Enabling Zve64f enables Zve64x and
enabling Zve64x enables Zve32x according to their dependency.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c         |  1 +
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/tcg/tcg-cpu.c | 17 +++++++++++------
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 37e4557b47..8b5d1eb6a8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -155,6 +155,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zve32x, PRIV_VERSION_1_10_0, ext_zve32x),
     ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
+    ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
     ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index beb3d10213..5d99856822 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -93,6 +93,7 @@ struct RISCVCPUConfig {
     bool ext_zve32x;
     bool ext_zve64f;
     bool ext_zve64d;
+    bool ext_zve64x;
     bool ext_zvbb;
     bool ext_zvbc;
     bool ext_zvkb;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ce539528e6..d630879286 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -488,17 +488,22 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 
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
@@ -665,10 +670,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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


