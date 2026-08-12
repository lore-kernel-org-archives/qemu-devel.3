Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D051AC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuD0N-0002s0-Hj; Wed, 12 Aug 2026 13:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wuD0J-0002nx-Tv
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 13:44:40 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wuD0A-0007bu-Rr
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 13:44:33 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so1491942a91.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786556668; x=1787161468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mnhPT0S/XDH+pcuuXbxPW4eZbhXoqpil5cHfkJ/4zsw=;
 b=WudrXyG6tYJOcsRTlVDAjQdcIJDgPnzBEe/u3+8uzeCM9jHMKiTaWJTCrhQTgGWDpZ
 1krCUYenc0cbMlUS5JFsOHKA150P9HJr9/wu5S1yZLsKDXUClR3ACCtgW3UYLzgfph2w
 hfCX8aTcNuPMiXGexfv7sSAAzn2qtM/puzHPCVp5D7khSgElPdnFEFT4DBMSafb1wsgs
 gZZHNIMjIiZKwmPHUthCEJHR9U5i0ofBpE1mA/M0og2AO3bsR0ERR3zqPMXU2IvL59D4
 HrTmB4JoLFObTiyOEwFto6BAV5x6mEFatrqIkySHnQusYaRPXNPcdPJqC6LZkgAoZenx
 r8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786556668; x=1787161468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mnhPT0S/XDH+pcuuXbxPW4eZbhXoqpil5cHfkJ/4zsw=;
 b=DWNZ4O+IdNwc/dYZbC5+SCHEQxaw6RuuN9yBEYnUJQNMFEV/CfqflcDm7uTu0YssLC
 sF+hNgcQHat5cOVkFFci60qseSkfw/C5LQpCC8ibrWb8JOlUqqPVCYpbnKWPmpANiYUm
 4QukrMC13LVbBxYrQc3GvoHQLc8XBRMGNMiJPXLq2Nmow4c2CPjZhT6dPXYclxSC5s3P
 89UzRAwkGjXslQSzQ2cnQPJbk4e1lLaAgnmo8ko3tRiTEEgxWGJ3oPMr2zGtg40ujA2w
 q50caIZ7c6ovj9JHLkm/e2OFgV/+bNmoS/3Js8xgJ/pgBfRlJGQpOR2kNoKmEz7LlL84
 qTbQ==
X-Gm-Message-State: AOJu0YxKn4WFEFzuxBkbhkp3dbnEzQaMQa0L8ATg6E23AwjDp4D1Wnw1
 /GqCm+UXSxVgDHLQQHe4fPjaCbU87ny75SXyPcYPIYi96mUxdVFUWXxEUGOmMIAUV0AiI6Th8v4
 AWQ9k04QUwiST2D6KH9RYZrGBdQrR6EBL2HRpT3vQtlzdRYbcIdBLH/b/XuyMMhwmAR/29P5QP8
 XNsra/nqtejnFn0ARJPiTpXKfcg3n8tfWHa47P9Xk=
X-Gm-Gg: AR+sD10KfQxJf6BhyfG88d7NsVGRYSOBaORw0dTbBT+Yc/bCcye0CxnGvrxSVP6cl7y
 g6d3q5CpF94fQjdzE+sk4AurcYNQBMKe2EkDzAdEBRHARUCtThDbvCqVaI2rJr5KLGEQEKdo9SC
 Yyc/7mYRlBm0NldBF2j40b5RImv2LOjnpDrl6HOJPTWSyADBuLy2QIb3V0yQTvPW94b7NDBknxV
 MKnL66F6tdRZ2v1gCUWzS3naXGknRCwEvuL56G+qeHqcB0WIagtNJ6bwj8wQ3zNb4BGJPknFpPO
 zWHXfPNH1ICTaqtw9wd/IaQR0QCCbc8mfa0B+1cikTDWKcdvbQggBdfocbcGdms9GYGbhfxKYiV
 5Z1EDResthr9Jm3h9TEYXjzKTOTvSymgLxlgUlJ0R2ArN05WaYbYFmgoZzNy3BNozqsvyXO4XfH
 UwIG/sZPrujY0RGWGl3xfcHZ5fraPAnSAQ+ThzuQnS4uWIlgXM4CDzK7Hfx5JOoPVcFYP/BNyoT
 l3GUUJkWTg56kQAaAgKUifuzil+sxD000g4qyqMIWQ1if5DYPrcMil/Rpr/Y9m6
X-Received: by 2002:a17:90b:4ccd:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-3930124d046mr8362986a91.3.1786556668073; 
 Wed, 12 Aug 2026 10:44:28 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931db13c3bsm13210a91.3.2026.08.12.10.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 10:44:27 -0700 (PDT)
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
Subject: [PATCH v2 1/6] target/riscv: Add cfg property for SiFive int8 matmul
 extensions
Date: Thu, 13 Aug 2026 01:44:11 +0800
Message-ID: <20260812174417.2468981-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812174417.2468981-1-max.chou@sifive.com>
References: <20260812174417.2468981-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102f.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c                |  2 ++
 target/riscv/cpu_cfg_fields.h.inc |  2 ++
 target/riscv/tcg/tcg-cpu.c        | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a82e6563bf..e643d7c7af7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -298,6 +298,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
+    ISA_EXT_DATA_ENTRY(xsfvqmaccdod, PRIV_VERSION_1_13_0, ext_xsfvqmaccdod),
+    ISA_EXT_DATA_ENTRY(xsfvqmaccqoq, PRIV_VERSION_1_13_0, ext_xsfvqmaccqoq),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 9eb47af0a76..73448fab5e7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -156,6 +156,8 @@ BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
 BOOL_FIELD(ext_xlrbr)
+BOOL_FIELD(ext_xsfvqmaccdod)
+BOOL_FIELD(ext_xsfvqmaccqoq)
 
 BOOL_FIELD(big_endian)
 BOOL_FIELD(mmu)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4af5cd9c731..c90023a2120 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -417,6 +417,16 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
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
@@ -794,6 +804,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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


