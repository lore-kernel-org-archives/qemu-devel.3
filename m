Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6083C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 08:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkCj-0003uk-21; Sun, 27 Sep 2026 04:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xAkCg-0003rG-IL
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 04:25:46 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xAkCe-0004ek-J7
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 04:25:46 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc78e1a94b8so1096454a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790497543; x=1791102343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cHPPYRSlB5lQ/aBlCq+uPr2zo6HJWshht44DXCVNEH0=;
 b=auq4RawZrdtlOlM/ZFP67ViS4tH4TablbuE4OjNQmn9sWeYwerFyObcoJBlrL158me
 l1iSYbVZjQOe70zqn2kp5Ehnr1vl5seRSz6+6TTY18S9Y/H7Cn8jI4eCmCOECdUHx5gt
 pfeMShkAYdL7JoOQB/yeT/YT5vf8XFCFOYZ+Ijcp0ptBERfxIVUhwRj+OiKedCtR5TOk
 JJlMLGNw96ndA1i76Fxd6TuWDvcQvoFmyGU9ABO1zwrBO+OdTgvGBqr77jEi8hYw5sYM
 7tS9s7l8slHLzByQFYCIGfm8qzJrZ0/anKzC67iQ1UyPcB/1ILBS3QM5NmChHHQLxiK8
 oeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790497543; x=1791102343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cHPPYRSlB5lQ/aBlCq+uPr2zo6HJWshht44DXCVNEH0=;
 b=PQ3XgVpSRJHz467eFyluwewwLKa9E3zAmtpIqrMOcMvpUYq4MIb4A8EPf5SPXBVLud
 qj4+UFw+TNPBf7P4yAdRZlLgm8/S/ACzjXKiXhS1XVjVFhq8e103Ozm/Tvbzc8l6MiHA
 ytdd8vmsI3Uvo+EhOg69ATxVdUmycpP3lYeA79yMhP2UBtgoxB+edYUbOBuOMBjx361J
 X5uh4t/XxMrjBGVX2Q6oh8VgWTKu6BYvZDxrRujBLLDw0IV/n73kAxzLFXuMmGG9/Wk1
 KP3TCJuJ2DpN10GG5byEwsjU0H5qqi1UA9tvCB/UM9E0wYerNU0S28fIC2FeRuEWs4yI
 ksGg==
X-Gm-Message-State: AFq9FYJo2iUlrXoUCzqp9b5seUpsQcEN1dXxhSGkvaqz8c6NXJ6t053K
 1HxYPmgD3V7C1KyFQtj3ofAQUBjc8sWwjlgrEFiemukYOeoUozpp2SvsRl/tDF9acDFq13GiyN2
 kUPU3b9GZjr8fzOw+YKYmbygGtumhPNXorumdmywNld8ts+xp+CsINtSqo/rUhNhsVw/PVEzoqa
 tPuKvM2Z9LDr4/4gic5CZDQcJ+RykzM/6rgNjyM8ispA==
X-Gm-Gg: AYBFou14+PsSQjoYoUmKAoamBi97KMFsEwkQRLxr75F1C3VSuhTFNX2tn3jqAqn6Fgz
 UFD5V37k/xmTguqn0Be/O3HgpaYFimPwn8vq/FMtAV4NyPKnndFgVyWwCQqEeB6jlRd6OzuWKyh
 etBSMTxlo1AQ2QH1pcnscEaIkkOTCD/GuVRwSmameCosN352JRKuBG1dcy07r16SO2SUJGT4qZ3
 AZsHdW8ULe4djt7ri7JZVcRiXN72nTQIOEpjkk8X89sl48UfP1qH+0XkZXai2mzbIJf5tEh9u6k
 Zh8aGNFg5DKPNOy6UFw5InNvaGuDvhg0EIfLCHIrNaRG1uQU7tKib2JMEt5rTqYqPZj2Vjfognc
 d2GaCo9/s8LoDu06SXv7egJTKPD5wP/0bDPww9en1JBFbcMyGGMiyM4j0Qx2mYDNNbc6KOEOsVk
 9DK8tfzT4v9QyFtFuACiA9PFDhtw+kZYhOcRMAloyseclO1/uE5p2Nogz+tUiTBfZjgoRsoEuXO
 d8PYqBZ0WPQQPOMJmzrirwNkupwGkuXRSPCZfGBr41kP6+IZcApG9pW0Z8bXilDKZGqjCqYmw==
X-Received: by 2002:a17:90b:384f:b0:3a0:d7e4:c4b7 with SMTP id
 98e67ed59e1d1-3a0d7e4c5bamr3554216a91.46.1790497542809; 
 Sun, 27 Sep 2026 01:25:42 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b9357f64sm14498871a91.3.2026.09.27.01.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 01:25:42 -0700 (PDT)
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
Subject: [PATCH v4 1/6] target/riscv: Add cfg property for SiFive int8 matmul
 extensions
Date: Sun, 27 Sep 2026 16:25:29 +0800
Message-ID: <20260927082534.3228237-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927082534.3228237-1-max.chou@sifive.com>
References: <20260927082534.3228237-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=max.chou@sifive.com; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
index da4c1a090b9..55833896bef 100644
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
index b68160af830..4f132488b9e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -416,6 +416,16 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
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
@@ -793,6 +803,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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


