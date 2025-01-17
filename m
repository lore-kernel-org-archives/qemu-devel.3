Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D96C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfMI-0007GG-Q1; Fri, 17 Jan 2025 00:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMG-000742-1R
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:28 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfME-000631-0D
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:27 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso31152805ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093444; x=1737698244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCvDekbxaep849YFQrI7DjachCGCkN4kW2xRu8k6KDU=;
 b=Y5lWi7bkdQfjfUKutS7A/CxoQzB3VERHALYwRAnmpGZYadQBk1Zy7X2Jrn2Ho+oGIb
 1TIbMMhk9gJfeC8w5Rez9y9YUHo9PAjouLSCwqhkx+c7f0nrflbGJZzlDAHID1elodrb
 oql4uLjduNMR3InBXep2RRODPTuOd25UyJSZRRyboWVswBgyLrw20kQ1RBI5ctqOdtWc
 KDT+ovikM9zxPsn3ntBRC2WzfU77U8ylHgOEmOrZz+IpKUJtz66jse5gWm7Nh/XC7UXP
 mv897/JdW0pcvtc/8pJn0Wdo/TBog0tYLYDtqJuzs31f7Jztjc40rU5TtRXc/OpKBmGe
 JurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093444; x=1737698244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCvDekbxaep849YFQrI7DjachCGCkN4kW2xRu8k6KDU=;
 b=nTsgrrrmJgMBpuvLPZpFilO2a4cObnMlLnF4qPLwFWCqsliIuRLhBHNeLWzoFkwN7Q
 PkBGLQJEXtoItKuEBHhcAjeDHfiNwLVozrOAsZrvhZeu/DeH4faDhI/CDeNk57FoTa0z
 khjosTVr2xfx7Kf54/DDPCTEroW39VfCEFhmb+jrKaQkIOtrs3qtMWPff73doHmP8Uh/
 acvlCM2KGJ6I04w8/XL/pP6D8qhdEO7Yb6Ogf1NRCzpmweIKhV9wkoAHR2GGYlMI28z0
 t7zn0dNfrr4N3hJtrbQYgO4uPMAdirhlF2XPPuZ378UT52cVVlgZg3SbsIWhWBfQDO1c
 kzMQ==
X-Gm-Message-State: AOJu0YzmA/D4FV9U4D/owlq4j8vrQM3wWVQgES/ZaHCfKANv7BEvuZdW
 w5n0V2UoZdrODtcDhvMX6tTlwMQpawWWBTKFAIpm3aQCKWZY/Z9QXy6pyw==
X-Gm-Gg: ASbGnctIrqQ6RSjCCjeZ1SRtBxohkrSXxya3941U17JypkKZkG46DFBGeUJMCwwGmnF
 RZM8XN+6T/AvQpyoBei76nC+B/PFll/eT9H8HujAPD4xnlA8a1C5GaFReuXsfGCVBNYMdN5Pp3r
 qK3OdumhVH0RW5EOUY7zRxfmXYC8A3B6D0xd6Y409kstqD55FM2hLcpRtpbexHczpfvyMG1q+ES
 aBWtIE/+lY23I/P41A9uUAUllNh0vJjH1TlrsaEl8pafzd0nlBxEGPRexOVz2XyphqZX4QgY2el
 vCto3HSoV73UjaLzdCcIJNoEvEovUcJIxeC42JKTQOs/997j8YP73Ex/Fh6+
X-Google-Smtp-Source: AGHT+IEtmRsHO3uG6LDpasMsOThdm56FfLYNd4eZtxkcsWm64OF4KhBvGsrrFNST84B50uZkyNzvGw==
X-Received: by 2002:a17:902:d511:b0:215:75ca:6a0 with SMTP id
 d9443c01a7336-21c3555b09emr26377825ad.29.1737093443767; 
 Thu, 16 Jan 2025 21:57:23 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:23 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/50] target/riscv: Add Smrnmi cpu extension
Date: Fri, 17 Jan 2025 15:55:26 +1000
Message-ID: <20250117055552.108376-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Tommy Wu <tommy.wu@sifive.com>

This adds the properties for ISA extension Smrnmi.

Also, when Smrnmi is present, the firmware (e.g., OpenSBI) must set
mnstatus.NMIE to 1 before enabling any interrupts. Otherwise, all
interrupts will be disabled. Since our current OpenSBI does not
support Smrnmi yet, let's disable Smrnmi for the 'max' type CPU for
now. We can re-enable it once OpenSBI includes proper support for it.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106054336.1878291-6-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 2 ++
 target/riscv/tcg/tcg-cpu.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eb06d06628..dace670e5e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -193,6 +193,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
+    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
     ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
@@ -1614,6 +1615,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
+    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
     MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7f7283d52a..f94aa9f29e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1430,6 +1430,15 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     if (env->misa_mxl != MXL_RV32) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
     }
+
+    /*
+     * ext_smrnmi requires OpenSBI changes that our current
+     * image does not have. Disable it for now.
+     */
+    if (cpu->cfg.ext_smrnmi) {
+        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
+        qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
+    }
 }
 
 static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
-- 
2.47.1


