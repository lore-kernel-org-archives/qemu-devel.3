Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF6EC61DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0i0g-000623-8W; Sun, 30 Aug 2026 12:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x0i0f-00061n-6H
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 12:03:53 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x0i0Z-0007i1-MO
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 12:03:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-853c07a76adso2711503b3a.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788105826; x=1788710626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e3+182cJvrOIa0h+b5iwFEYaEYm9QcYRRZMRS35cDQ4=;
 b=OskNtxzpT7d1MGmmXru3CtzFi1atNHLRsCh8mc7hcIvNW7KxnlhwHsJ0szGrqaWuHb
 0hdMxcDVFn9uRF7412DJU74jbY1PQnWy02c1Z/iGAN9DnPibFJdfd5h5lLkY4Uoy8WBu
 qQQV0PFX1qwPDULZf0cbYQrhAuIVdKywCfK/JOO/18nJNzXwqn2PnrIDpv2+rRKZ6Jpb
 PPi+AcdhJ+fBsjAGfpUJD3xd9ncsG4GzPXyqfUPUjwBqRMJca3DFnQumg5OpVHlGaTP5
 ZUY5fVUVo3eB8To0iN3ym1B341Bt6Od7Xk7iLHgOnp2KTDqADRIjk9eTv7L4jN/+VSl/
 3pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788105826; x=1788710626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e3+182cJvrOIa0h+b5iwFEYaEYm9QcYRRZMRS35cDQ4=;
 b=TQKk6L59W69/iS9dbdeJz68FOwYFxVr8bJUoXUhk3r1ytiwQaAB3TOAEl6QjpiqgcG
 cinPWeg+J8iM82CXKfhsl5x/9b90UAOeMyRf/wFHItVwWgpnvXxe5SEz2DcMXPEuEj44
 ZqMpktNLi3UXafbA2BKXoTDM4H9s7vZFHm38oRCQFCGau17X41Tle737Feo+dLx6SrKL
 kF5uAk6/MBHIzFix9jX7WAwSYzmarwoQg4Xtzex7ZJ7TjZlEIbn7041IsiAo9q19ckzn
 MU84wDH9ndz48qC4k7FLAFgQA/nCzSYmDVJUFN3ARYz5ikJV2GyHtSyfeQJD9tCmhyNw
 MerQ==
X-Gm-Message-State: AFuF++k3tb4e9y4jVLAIW87MgQsmKCXDT1p2yhcmwQYmFa2lrGd2JmwA
 hEyXmp+hGZI3L3kyiUB7nJBdjsRBYCy/VVt7+RuppsNQ0neObIz0FmNxbVBGN9mL1kEriB0wEZX
 rvjlySss7LSG3bEvmH7Yl8cRyPctInehTQu0C3SNLaCpjL1cnz5IIckutV+9HDprKYtv6Wpj4Gn
 2xhJ1nfvT3h9HHIpCwLjd/ZmoczGE6T4jikZcx2+cnqw==
X-Gm-Gg: AR+sD12482NpAP/HYdOHBt/OilVYO81F8xz7zLlEZ7gMUZT9G4MSxitH+xB+6jDfmLe
 sm0kO4wLUgU5qF7UIWXwaoBdhwbiuCAENvwyTn5fk2ozKDtPAvBTg5nRSqhP7s3g3XiWHIU8+rP
 FkUNcn4VbKHxzPAw7SeM8Br1lbYcoBRHzrhQPEbXdka/S2ApO9U2nAv+cWqigUdxq8RacqroCrn
 uRhCj6p9hu2PZFzXJPtSOqv4mhf//ETxd1U7QplamE5qKatK4YzRlC9qqlGFdtfDLgCK88WVb/w
 xCrVy3Ptvo9wQ6bTqQ9VRLPIZb1TEEasHaMETwbXZZfhlMZ7iMAUsH4nuT4+GdHSCPXnaWY3Hy7
 9bk0V2QORq2pgb4KTCK9Z4j3rmjfJDUWyKTwCmnQiEr55PtZWToNJcnK6e5wg1puJ79aS483IYb
 FvbCPDaYAlZ0KalBLPsjfKn5KMVKeVj+M6tx1GgxoNd227USxG3gRxMQsKQHHxawG7gDQI6VSjw
 GxH0sS/ZpRRZuk+T/gRO0V803KXvNuLHX8SORusx2izzBqqblUHceEH84diQwM=
X-Received: by 2002:a05:6a00:4501:b0:857:72f8:dc94 with SMTP id
 d2e1a72fcca58-85772f8de8emr19046427b3a.21.1788105825707; 
 Sun, 30 Aug 2026 09:03:45 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8569ff701d5sm2455900b3a.25.2026.08.30.09.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:03:45 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Chou <max.chou@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 1/6] target/riscv: Add cfg property for SiFive int8 matmul
 extensions
Date: Mon, 31 Aug 2026 00:03:30 +0800
Message-ID: <20260830160335.3441069-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830160335.3441069-1-max.chou@sifive.com>
References: <20260830160335.3441069-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the CPU config properties for SiFive's custom int8 matrix
multiply vector extensions:

- Xsfvqmaccdod: 2x8x2 int8 matrix-multiply-accumulate operations
- Xsfvqmaccqoq: 4x8x4 int8 matrix-multiply-accumulate operations

All instructions of these extensions require the Zve32x extension
to be present whenever either extension is enabled. Validate this
in riscv_cpu_validate_vendor_ext() alongside the existing vector
extension validation in riscv_cpu_validate_set_extensions().

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                |  2 ++
 target/riscv/cpu_cfg_fields.h.inc |  2 ++
 target/riscv/tcg/tcg-cpu.c        | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 61109672d60..b4e34daf8ec 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -299,6 +299,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
+    ISA_EXT_DATA_ENTRY(xsfvqmaccdod, PRIV_VERSION_1_13_0, ext_xsfvqmaccdod),
+    ISA_EXT_DATA_ENTRY(xsfvqmaccqoq, PRIV_VERSION_1_13_0, ext_xsfvqmaccqoq),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index f91c780299c..0f3bda1331c 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -159,6 +159,8 @@ BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
 BOOL_FIELD(ext_xlrbr)
+BOOL_FIELD(ext_xsfvqmaccdod)
+BOOL_FIELD(ext_xsfvqmaccqoq)
 
 BOOL_FIELD(big_endian)
 BOOL_FIELD(mmu)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 54f1b66216c..bdb6dc6ab3f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -418,6 +418,16 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
     }
 }
 
+static void riscv_cpu_validate_vendor_ext(RISCVCPU *cpu, Error **errp)
+{
+    if ((cpu->cfg.ext_xsfvqmaccdod || cpu->cfg.ext_xsfvqmaccqoq) &&
+        !cpu->cfg.ext_zve32x) {
+        error_setg(errp, "Xsfvqmaccdod/Xsfvqmaccqoq extensions require "
+                         "Zve32x extension");
+        return;
+    }
+}
+
 static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 {
     CPURISCVState *env = &cpu->env;
@@ -795,6 +805,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    riscv_cpu_validate_vendor_ext(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     if (mcc->def->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
         error_setg(errp, "svukte is not supported for RV32");
         return;
-- 
2.43.0


