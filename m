Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F39AE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAHU-0000RD-AT; Fri, 10 Jan 2025 03:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAHE-0000Mu-DL
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:21:56 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAHB-0008LR-PT
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:21:56 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216426b0865so29366165ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736497312; x=1737102112;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=csjjX7xIkwZtlAjPq4870UFEhfjaui0IzUY8VK8MiOY=;
 b=AXxRRydWx46Q4WGCrRfNDNT1//Ikvpk0jMmFXsW2+ScjjIOVnD2jM5tb+XK6kJ8Zya
 eqv96ibTSmjo0zjwj8Jj7X82ll++ju/8Jyh/pCNV9TAQog1TqAxTPLFPcKFQ6nu2dVE3
 eSxx92K5WZq9AP1rZ3j7boUdj09Wj0hskpRDYoRBoCVYTYurrnN/4NNZKxKFrCpl3wnX
 DXT9/reoYcKhspo0YCMQNKik/5ANZN69gERP3cKzeKdPx+qo5gMr0SlGNjVzthjlM7XJ
 CwsHv+RLYQFHdejVVjrbDJPDXPezVteGnghX3F7jIm+ajFDu+oPjpOBGHvNR9T0z5gjp
 6UeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736497312; x=1737102112;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=csjjX7xIkwZtlAjPq4870UFEhfjaui0IzUY8VK8MiOY=;
 b=BMp3Jl9hsoR/uC7Q0eNPA8w4KD0X4/eYJFyC0m2BorqHK1u0b3FDBbJKF/4ZM8poGU
 ThfZpoI8Kk4LevB9+17pdwgIWP/Dlhon2MyVGHVLLSil1jH0tEOEOkxgaazVRGq8EurS
 kaJExYk9ZFff5K9TjMRdKIIMmU5ttpCbDxvY6eE1vu4AYruZYdCk4HS7QH5S2UeFPvFT
 l1U/U7A2Majk+Fe4e6OWoBUkv2MkRAO4QVy9FYwCfo3RFDK2dBvY7BQLAFV40OVJoPmV
 iQeXzjwoGWSLGKrkeKMmbSxeYeBmIgnJzTuAzk6hvUKLuKG3CbKi/u0jE9a5P4OVmuCm
 UMCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsM4/qWlS5K+M0Egl3dfs+BAVY1t1cftlWwftWWYpHCCkn59xo2EDE/gY8C8IBHqNH00+muSPNnvKd@nongnu.org
X-Gm-Message-State: AOJu0Yw/mncH5/589eEqU5U6a+r2tjaycSabYYz/0M1SwehqJdmnOCXL
 F8VPfE+94RbQYgAhDhcnyVuZg4e7Sf3fWYf4tVYrJ25soir+s/8915FAwhJnazyGGt8PuA7r30e
 M
X-Gm-Gg: ASbGncuoOShAEAQvFz5hzwTHFhkF+OdSCaUNL/qvzNuHo4MbvpFlyo/VfaciBeTXkYR
 NArNNOuMRl6LoFSVh0c+9RVB3itKJ2MuHtZiYvvH3alDW2K+bFclutqPTNrc44ZKLNeyKUDIm4a
 Q1HDOzPU8vXfePb0zjFKjlsJ/D1n9AgyR3dDO2CMzuSNoXW78f47uyosYDWDe0+OxP43co+4sDH
 kwBCuBYakaGft01qb4f2hUdnXYL4mvtTfyO0QUrOtxl/Syu/p3zPvA9QZVaLMOvD2XOfg==
X-Google-Smtp-Source: AGHT+IFe3PtpxegW4zeQ5Hm9BAz3gkSfy5eCpFIlvFsQJIzhRwPlgjhqOup8OI/Vi+ShAQ3ivA0SeA==
X-Received: by 2002:a17:903:230c:b0:208:d856:dbb7 with SMTP id
 d9443c01a7336-21a83fe460bmr145038845ad.39.1736497312507; 
 Fri, 10 Jan 2025 00:21:52 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22ee09sm9278715ad.200.2025.01.10.00.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 00:21:52 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 10 Jan 2025 00:21:33 -0800
Subject: [PATCH v5 05/11] target/riscv: Add properties for counter
 delegation ISA extensions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-counter_delegation-v5-5-e83d797ae294@rivosinc.com>
References: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
In-Reply-To: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x635.google.com
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

This adds the properties for counter delegation ISA extensions
(Smcdeleg/Ssccfg). Definitions of new registers and and implementation
will come in the next set of patches.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4f5772ae5b60..da40f6871572 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -191,6 +191,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
@@ -199,6 +200,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
+    ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 4fe2144ec713..561f5119b64a 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -78,6 +78,8 @@ struct RISCVCPUConfig {
     bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
+    bool ext_smcdeleg;
+    bool ext_ssccfg;
     bool ext_smcntrpmf;
     bool ext_smcsrind;
     bool ext_sscsrind;

-- 
2.34.1


