Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220B2C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwKO-00025C-PH; Mon, 17 Feb 2025 03:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwKG-0001zL-7D
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:18:00 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwKE-000107-1B
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:17:59 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6e41e17645dso42262826d6.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739780277; x=1740385077; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s8x/AUhlMa+i1pxB//o187dxahL7hFDjq4fu/AmY4EU=;
 b=fsLz0MA+/l7MN+8F8Sjq8Al3KWMQObmGIGsbm3yEerjR0FQWrDNwVod3cBuA6ibLK4
 yH5R7hj7/6UtandLJxcqIQQDsT8+L7MIMuMfuDw/ExKGHeABpQnkG1QgYqpP+Rbg6VlU
 pQ/Fyv/xCvRZZxRsZkelB/eBwzdrSNvyVulQw+WPgxu86+/i73H0auFfX+/0G2hQgTmU
 z9VXYuVtPlza9w3CSYk64EQpreiwPvaMwg8VHCj10SFaUlBlXO6evxft/9MghVBQ7AOV
 DtBxTdJGlJALlXkIrC2e1PjsBcZJx6TLrnp2h0HgzMaEPzf9GoerAg3prcOuqbmA4gzd
 BVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780277; x=1740385077;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s8x/AUhlMa+i1pxB//o187dxahL7hFDjq4fu/AmY4EU=;
 b=ev4zAqkmIk6PfyNmvDZJdF0UN1nzEEOrBE4lOA9XXle1x6dKBDVmju1J9MshrycCzm
 ITSh/31XMTUC22fyHxb+7VdnjmMpWpwBbLFCr+1Hecw2I5XwP98+G7PnTu9v1C3YFkoh
 EaHidFtbeLuB+zbwtaJZEZ6oU/e/nYkXthdrDPkQRQwhV7OuAbiQUCVCOXFfPJxHmmiv
 LgL89yInnF7GKUsyhJ5sc6lTRMfzNHzNfi4lFBrxI1NbHbJJnzkVpNJpy/GEOVMhdhUF
 l8snW4zH0HIuD87yvWrNR9oqZoyxUrkBpX1Li/zd3Z3XJxGSNTAvtFZaFAqgkL3CYSXQ
 HnYg==
X-Gm-Message-State: AOJu0YyEMusd9VNfwUwidqRDPJI2ZrZm9hgLaR+x1i0Dr9hU3Zg0Nd6l
 0NvdLupv4TfCjyH2srb6WlvVtqRPcxh53oP9wcC81dz1/U/4g4KjJogiYpDnwwg6v5G/AANGWdC
 B5PO8eCW6qu+Wr7pW3sU7AAGhW/DUEt6mG/B+DxDTL5/k/o+hbfhljbP/3PRIE9nPzH+xaBsDd5
 A3rOfq2gFqBoV0J1BnQpInDIkeMqIJhjUTdMcqN+LU5Q==
X-Gm-Gg: ASbGnctL3QOjUoqMYCly0ZAzlC/28DgHEBIeENi279WaVJSGKDH27I5DrutyIdZ1edr
 FN/Ep7C1WrwdkEQJH3qml3/MPlM0kh0xUh6Im6Qp31FcC7kbKP0lvH999biDyVvBE/meB9n8ZOJ
 7ltsQpxGFOOSEppKrP9RIgPIL/961xUE3i+Ni5DZzu8maELo55wXwQC91YxDOFyqEwQnaQajCz5
 j5+v2Ushzl86fh1Ef8xaXiVdAAEao8EOjq1xjCC/y/CmqW9vkm5kuvsfM95stWe9U00/tFU04Kj
 QbnG7K+uny29CePEX6ANfTMaXvjvsedZr8RX9ANdw0HjFQ==
X-Google-Smtp-Source: AGHT+IHESTeJBCnbLB/7Px+mUg+wKxnOm1fKtPgG0Bp/rz+E/ijmCPv+2q1nl0fUS2aZG3e7x/YExA==
X-Received: by 2002:a05:6214:c4b:b0:6e6:646e:a0f8 with SMTP id
 6a1803df08f44-6e66ccb7abamr128248356d6.16.1739780276749; 
 Mon, 17 Feb 2025 00:17:56 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65d9f38absm49673346d6.88.2025.02.17.00.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 00:17:56 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] target/riscv/kvm: add KVM_REG_RISCV_CSR_AIA
Date: Mon, 17 Feb 2025 16:17:22 +0800
Message-Id: <20250217081730.9000-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250217081730.9000-1-yongxuan.wang@sifive.com>
References: <20250217081730.9000-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-qv1-xf2e.google.com
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

Add KVM_REG_RISCV_CSR_AIA support to get/set the context of AIA
extension in VS mode.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 target/riscv/kvm/kvm-cpu.c | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index e315fea46973..e74c1d7cdcee 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -132,6 +132,9 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
 #define RISCV_GENERAL_CSR_REG(name) \
     (KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(name))
 
+#define RISCV_AIA_CSR_REG(name) \
+    (KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(name))
+
 #define KVM_RISCV_GET_CSR(cs, env, idx, reg) \
     do { \
         int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, idx), &reg); \
@@ -641,9 +644,50 @@ static int kvm_riscv_put_regs_general_csr(CPUState *cs)
     return 0;
 }
 
+static int kvm_riscv_get_regs_aia_csr(CPUState *cs)
+{
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    uint64_t mask = MAKE_64BIT_MASK(32, 32);
+    uint64_t val;
+
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(siselect), env->siselect);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1), env->siprio[0]);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1h), env->siprio[8]);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2), env->siprio[16]);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2h), env->siprio[24]);
+
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(sieh), val);
+    env->sie = set_field(env->sie, mask, val);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(siph), val);
+    riscv_cpu_update_mip(env, mask, val);
+
+    return 0;
+}
+
+static int kvm_riscv_put_regs_aia_csr(CPUState *cs)
+{
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    uint64_t mask = MAKE_64BIT_MASK(32, 32);
+    uint64_t val;
+
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(siselect), env->siselect);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1), env->siprio[0]);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1h), env->siprio[8]);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2), env->siprio[16]);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2h), env->siprio[24]);
+
+    val = get_field(env->sie, mask);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(sieh), val);
+    val = get_field(env->mip, mask);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(siph), val);
+
+    return 0;
+}
+
 static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
     kvm_riscv_get_regs_general_csr(cs);
+    kvm_riscv_get_regs_aia_csr(cs);
 
     return 0;
 }
@@ -651,6 +695,7 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
 static int kvm_riscv_put_regs_csr(CPUState *cs)
 {
     kvm_riscv_put_regs_general_csr(cs);
+    kvm_riscv_put_regs_aia_csr(cs);
 
     return 0;
 }
-- 
2.17.1


