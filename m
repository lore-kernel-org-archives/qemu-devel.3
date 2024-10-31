Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DC5E6894F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MGp-0000zF-OJ; Wed, 30 Oct 2024 23:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGm-0000qq-NQ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:48 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGl-0003zj-1K
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:48 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso4794355ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346885; x=1730951685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfuE5NhnsNq1iMZF0U/EeFJxBpIDraqGn4mQOTBcvQ8=;
 b=lTEMa+6uPEk5xfa8dR8PiWluTB4ZuWfQQYNsTRj/W5j892Y4+xlaUpxeFbkWFtkulS
 Ade9YvMb9l7AK/nPpi4rHs1VV0LalWKgB7JERdgDRs54u/qNs0Rw7oc9gTOywOUZndzO
 ubfQucgdP2iS3GY4RHPvzoZYblA+ArQlrz67xkHiGtbIrpZgf7422w2+bJg2I49xu7Jy
 KmOcAmOSv0GhjxpDJd2GKf0tC2AxZFcX6MyVt19QA8uOiuTS9igNjIGHoDNIpAGP8sRn
 bXOQFwvFsFbdn2cqvIWNW7vu8U22+WxGYfEkCbQ7fLummgNoG/SdZFBtnpFMA5KBo5ky
 IeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346885; x=1730951685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfuE5NhnsNq1iMZF0U/EeFJxBpIDraqGn4mQOTBcvQ8=;
 b=Gfg/EM0QHloEZXE/WJj3JwyZnibQbtp/tpj5YJVp2kpdbJ0ZpVylsBw/ZPVNgHs/oF
 Xd4P1weDIErIiwiAXBX/xamvld2uoIKP1nb1Y1oaMYlQowvhbTxmAMNc1MbXgiagL8/p
 ECwDISdecSgXseVKcjKnYRdW7rwBgEhDks2MgaK2yaK+YVv3Fc+Fh8AAFmMbUhggFcq+
 U4wfurpb2qGmDFErzPa+rX90p/Br72Vce1mCBna0bKBlcSwRo9WDOpQtNPOy+/XuUt93
 wkXIpvSoXPcuBk8l2TtdM+tGfxy10gFYZF0L+PqFDmYrKHbOxz/YuJ8AYWrtrfPrFuRN
 C9Tw==
X-Gm-Message-State: AOJu0YyOQ2UvOLEF6Y1OYVnxCTEa39x8+jGGMlRJpOToUlBwVH+kGHdi
 vQT25ix1q5OkQqaXMc4SqwR8DFJ6H1aMzzr3t2qP5ns3v8thv08xiRMnBqao
X-Google-Smtp-Source: AGHT+IE6xE33aulT7v5voK7ax0JIHEvSdheM1HACRUctV2m5ZraPVX/4B5Z4M2t0LY6MQkphW0EX6Q==
X-Received: by 2002:a17:902:f681:b0:20c:98f8:e0fa with SMTP id
 d9443c01a7336-210c687851emr245576015ad.11.1730346885271; 
 Wed, 30 Oct 2024 20:54:45 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:54:44 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Deepak Gupta <debug@rivosinc.com>,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/50] target/riscv: Add zicfiss extension
Date: Thu, 31 Oct 2024 13:52:53 +1000
Message-ID: <20241031035319.731906-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Deepak Gupta <debug@rivosinc.com>

zicfiss [1] riscv cpu extension enables backward control flow integrity.

This patch sets up space for zicfiss extension in cpuconfig. And imple-
ments dependency on A, zicsr, zimop and zcmop extensions.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241008225010.1861630-11-debug@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/cpu.c         |  1 +
 target/riscv/tcg/tcg-cpu.c | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+)

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
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ee6646848b..377661bae9 100644
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
2.47.0


