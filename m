Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60517EEE270
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 23:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sotd8-00052Q-I3; Thu, 12 Sep 2024 19:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotd7-0004vd-0s
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:41 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotd5-0008AE-B7
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:40 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7178df70f28so1180558b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 16:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726185218; x=1726790018;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptLKI6zAL4gMRldT6p+gGB6HQA07aljcoRmiuZiPzyA=;
 b=QTkRX2sexD3Jvr6URU091PYaIJCrvKsn2wWlsUiMEKt6P/7iisWFogW1OksmIH1Ard
 7T/HTyR8Sb8mY86KEivXCYbZ7C5p53G4t9wgdoCD6g6iC4SmpMtxvqKPHdyHhruRQ7QA
 hQob/vXnaBbNKAVRjjvxRklFyj5wj5Ogr6dcYWvqFRhnTanqv7IP1OrdomXmxzZKS6ZS
 yeGig+2dv2LnDCI2l2nRT7gmy9ir+2QWkDlr60Uv81skhIoQOp3YnsZ+IZQ8jneVgDqj
 48lx808dikZHqiO51Z1bJBGZJ4803RiCI2YE7VdcQ63mtG5MEsApSfwFJ3ezDvZLjvRD
 ejsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726185218; x=1726790018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptLKI6zAL4gMRldT6p+gGB6HQA07aljcoRmiuZiPzyA=;
 b=lb6sBUyhyyZxkCTfunYlsBQzxJN6aHRGBfjQ0emMSVlRLAA5+9tL3mMvWizk15A1PL
 MSfu9AUIFadZvSX4ndcH345Ibb9P/39fa+01KnQpqHd9LUSvhbT8AtZqCjK8ZHsyFSH2
 YeCohpiU+/gEL4qsSqIZMHvIZirh4x2rOGj/MsBFfIlz9wZ4h3ZMDnqpX9McHYvIS3wu
 ZZtRtFP4CWhDmSyXunZwRDJaQxAqD4SDY910kElPmSCQLZqeHLmb7reerymR6QeBwL1Y
 XCqwyUsiaHLTULfUHTpvumaXrax2ah45Z0/xHvcAjOBZWQ4AtCsZrsKtyzAzoFUvocFc
 HtdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt71KMy8hFivMHPxVd7h7JOB8lF5BdLyvTwaF3O58dg5oSfYy2P/vj+Tf5EWIBpH3hrtTsc/D4qALs@nongnu.org
X-Gm-Message-State: AOJu0YxNsk+HXHDXv86eNo+zWPox6UIWVva86+If+nvg4eldKc95W4CA
 BSvmL9j/v7c6yMDxsXu8DcafyIqy3LdPkKHtzKOj7ZRTydyOCnRDvwuH54EcKWY=
X-Google-Smtp-Source: AGHT+IGFjMvOJTucEL6Ra7B4Kp86Sp3PNSjYf4PaEKGPvdcxNwucT7gfRDkpP2gU7r90WMpZ7Ek9lw==
X-Received: by 2002:aa7:88c8:0:b0:70d:3938:f1a5 with SMTP id
 d2e1a72fcca58-719261e1596mr6478363b3a.22.1726185218061; 
 Thu, 12 Sep 2024 16:53:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe22e6sm5102229b3a.66.2024.09.12.16.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 16:53:37 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 10/20] target/riscv: Add zicfiss extension
Date: Thu, 12 Sep 2024 16:53:10 -0700
Message-ID: <20240912235320.3768582-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912235320.3768582-1-debug@rivosinc.com>
References: <20240912235320.3768582-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

zicfiss [1] riscv cpu extension enables backward control flow integrity.

This patch sets up space for zicfiss extension in cpuconfig. And imple-
ments dependency on A, zicsr, zimop and zcmop extensions.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         |  1 +
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/tcg/tcg-cpu.c | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b4b578003f..f5513fab03 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -107,6 +107,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
+    ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index fe7ad85b66..59d6fc445d 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -68,6 +68,7 @@ struct RISCVCPUConfig {
     bool ext_zicbop;
     bool ext_zicboz;
     bool ext_zicfilp;
+    bool ext_zicfiss;
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 963c1c604a..6c0c319499 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -618,6 +618,29 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_zihpm = false;
     }
 
+    if (cpu->cfg.ext_zicfiss) {
+        if (!cpu->cfg.ext_zicsr) {
+            error_setg(errp, "zicfiss extension requires zicsr extension");
+            return;
+        }
+        if (!riscv_has_ext(env, RVA)) {
+            error_setg(errp, "zicfiss extension requires A extension");
+            return;
+        }
+        if (!riscv_has_ext(env, RVS)) {
+            error_setg(errp, "zicfiss extension requires S");
+            return;
+        }
+        if (!cpu->cfg.ext_zimop) {
+            error_setg(errp, "zicfiss extension requires zimop extension");
+            return;
+        }
+        if (cpu->cfg.ext_zca && !cpu->cfg.ext_zcmop) {
+            error_setg(errp, "zicfiss with zca requires zcmop extension");
+            return;
+        }
+    }
+
     if (!cpu->cfg.ext_zihpm) {
         cpu->cfg.pmu_mask = 0;
         cpu->pmu_avail_ctrs = 0;
-- 
2.45.0


