Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A17DC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 12:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5OgJ-0008Kg-Uc; Thu, 17 Apr 2025 08:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u5Og5-00088a-86
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:49:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u5Ofz-0004Wu-3y
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:49:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2260c91576aso5995945ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1744894143; x=1745498943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BeAOkWS5iYpyCedtk/G72csftRR7XIzsx/a/jSY/2hk=;
 b=TBfu4GBTYgxB2pYxHpRlij21ikoOffEsWrxJ9JhtbzN80G399o8YQ69KpN++7AC4kb
 sxm+TqD464tNzDgNdZQEfDh68OL2KD3NTa+rWZWEc/1uzkbG7XgAHmYj1IBC3J6wd27x
 fduq0ue4EHT8K+kLd/yvZz9kMoFIMwhRYL/8jANQG0tWHxrk6uQ4d8Y7JxCxgRsOvgEU
 eqUtV1cbTxZ97+9v+VqNxO+EfQe+lxcuVE4GWeUIROCeS3hSB0/UlBkGJM/YFRrax+fF
 q9M7n3nmmJQJSG5olJfX7QxgMvSRDtHuo33rPuCWMV/Tm0ArwiECKuPbTTuku1O8QpWE
 SfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744894143; x=1745498943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BeAOkWS5iYpyCedtk/G72csftRR7XIzsx/a/jSY/2hk=;
 b=iw1kvhZicIDzT0FAk+xTr7yKHfmcfspPbP7P5uLX6YFKGHIe7ernad7zcIfOuv5TwV
 ydwBdibSCvhsYH0bnpWsMrH0k8mNIj7HJ2wy63kJfyVhesmqiJJw1VFqPz4fUSWejNEX
 i8Q3vFoeWoQ1CiTfpP/5bkSyJDUY8+W8DuU7tqdFEMa/bWzAP/DmkjDUWGBtxzoDV+TI
 qxE7LIquU5RvRURYiHgl2tEw/bwmgiNbSdyiGTb9vyxK0fqZeTUxxKf0lDxlFetQFMUo
 Jl/yy2PfoX6aoa0z3Z1k5AY+phmRh3jzPAWMWGkZAp9yOxc0P8gHmZhALVI9QHB4jJ8n
 fJhg==
X-Gm-Message-State: AOJu0Yx0/XoMBw77n2xSUW00Bu2CbxvuQDpbyKi3Vy70eRvIcNX8P8pG
 wYKPYQ1UJOTsGb8JF3d/nGFezWI1wnHjhdCtrYQ1Yjj/lDooLivozsIx9qWYpU9Wkvk6sHquUmR
 u
X-Gm-Gg: ASbGncuDu3Z5ZXVZz9EfAEVWN9kWrno6m2raIgQZz2y2ilcUScf8iyroXuQ8trI4C65
 UPEdEI/1OIdjp0RicgKHHdeRYlGuGg1q1yihCUXOgGRk1wr5oG8SettpVwTTyqpm4TkXrIJ216h
 gxsnreO0Iwaz5D0jAWQ8x/iGeUvKYvhXDRT8CSwLAjZINHuACCvSckIXlJnUP7h4h1tLCgEEC5H
 8sJVbNWX1rmlXj4BoT1BopN+0WJb6uen4iTWhP4j7kf1b4fkjbhxfkQVBFsdsFCPJurLmGTD3C8
 y0YU8NQxri8oLgfOa6gog56l/ZNaWaRb2//754SSt5UFopmrjPXLvfMKZ+5/wiTkjVqO
X-Google-Smtp-Source: AGHT+IHLtcM8QycgV1mujURElfKdICnkIxpZK1z+amUBNAGjYDPJgptAeB4fwZSvFzus1eDdcfcY0w==
X-Received: by 2002:a17:903:1a0d:b0:215:b1a3:4701 with SMTP id
 d9443c01a7336-22c358dadfdmr87142605ad.13.1744894143169; 
 Thu, 17 Apr 2025 05:49:03 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe6dbasm32175065ad.239.2025.04.17.05.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 05:49:02 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, abologna@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH 6/7] target/riscv/kvm: add missing KVM CSRs
Date: Thu, 17 Apr 2025 09:48:38 -0300
Message-ID: <20250417124839.1870494-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
References: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
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

We're missing scounteren and senvcfg CSRs, both already present in the
KVM UAPI.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index ec74520872..a91a87b175 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -251,6 +251,11 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
     KVM_CSR_CFG("stval", stval, sizeof(target_ulong), RISCV_CSR_REG(stval)),
     KVM_CSR_CFG("sip", mip, sizeof(uint64_t), RISCV_CSR_REG(sip)),
     KVM_CSR_CFG("satp", satp, sizeof(target_ulong), RISCV_CSR_REG(satp)),
+    KVM_CSR_CFG("scounteren", scounteren, sizeof(uint32_t),
+                RISCV_CSR_REG(scounteren)),
+    KVM_CSR_CFG("senvcfg", senvcfg, sizeof(target_ulong),
+                RISCV_CSR_REG(senvcfg)),
+
 };
 
 static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
@@ -696,6 +701,8 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->stval = 0;
     env->mip = 0;
     env->satp = 0;
+    env->scounteren = 0;
+    env->senvcfg = 0;
 }
 
 static int kvm_riscv_get_regs_fp(CPUState *cs)
-- 
2.49.0


