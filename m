Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39506C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79NB-00073R-Eg; Wed, 15 May 2024 03:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79N8-00070j-H9
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:48:22 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79N5-0000J4-OR
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:48:22 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3c97066a668so2157393b6e.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715759298; x=1716364098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plUfPWk1RcWNFeTjma5GTrn41rKUM5YMo9L4XBxNpkk=;
 b=cRezQHv6nHcvD+XmTcG6N4I7IQCdMIbxmSimT2cu8AeFHLZL2VGmWfaBhpEh8rwLrK
 KK1Nvvo7iSAwvacBZUymcDAFlyEC+TDEUOT1eV2EAl0DsX3E04IEJbrJeVq3RiC90vUz
 qQPNYiDVJGBGtblLka0yA13uT1pIZWCS8maiwBH5StOGEoLqCRtXnxcksZe7z7tXT43s
 NVMBgPgVoty961F3wC6YP3g0hFRQQGDHI8M+vxq5rjFXjV+ore4pe9mQZqgIkllObNlq
 mCRzIbZFOCH2RaQhFUEaeeOSzqjM+vNqarA430NFsZdbtyMshxPLVup4JxHC32U0G2rP
 kBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759298; x=1716364098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plUfPWk1RcWNFeTjma5GTrn41rKUM5YMo9L4XBxNpkk=;
 b=Z6gqrXFMn/dVvExHyWXH8YbbZZNr98sIWTIf6LdiuT/taFupxT+W9GqaBO6aApqWXe
 Rc7hshrRR9L8Smy4betSPNq5hqbYSAsVc4amF7gtbAWlfx8Ddj++Co8BwiPGC6GFmlHL
 6oKg+eoEZz1n9XuAZwHOQ/uKZLuB+XeQpIXlxHlUX2U4sDNn1/nT3ePGZlFS6VvS8oXG
 88HjTfaERFSHdLOIP+v+QZQOoeBbfgissfE/vDWl7kwQMKWmyCib7+mk9F2hRmOF6+P9
 8dL+Le/azzrxRJsKcXxJXjkXC1NW1sQVg4+0PLNyF6JsuNhLCzBqX9fR/zoDP9hiTxgS
 sC1Q==
X-Gm-Message-State: AOJu0YwxGuMeyBKKOnWMk7soOpubibwlOGAUzfeG7wk7HcIYprbz601n
 6YTFRwvsrRZe80Z8HLQ/Q6l3tGt7C2Zrgtg1/OTrzrXMPqS2DnVBfClN0KzSeIRV008YkVcagaM
 JBEVMbb7ZzgJJMYdSgTo9wD7R+TuUY9DcMp1tjnKnXvSakge0tlBMOIqTk16Fomp379QLK3g6q0
 98COUjTWskeuHolDnEQ9j0flNWiQbT+0YSTYxZNg==
X-Google-Smtp-Source: AGHT+IGSdLo9S2kAFGEymulmO8sO2Ah9DjnEqhhljHBOdA+XL7GuNRFhnm2DTpxm9FZ/KllcrZT1UA==
X-Received: by 2002:a05:6808:2b02:b0:3c9:6ba0:e98c with SMTP id
 5614622812f47-3c9970d1b29mr14639777b6e.52.1715759296788; 
 Wed, 15 May 2024 00:48:16 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm10389060b3a.162.2024.05.15.00.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:48:16 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Weiwei Li <liwei1518@gmail.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 2/5] target/riscv: Support the version for ss1p13
Date: Wed, 15 May 2024 15:53:33 +0800
Message-Id: <20240515075340.2675136-3-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075340.2675136-1-fea.wang@sifive.com>
References: <20240515075340.2675136-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=fea.wang@sifive.com; helo=mail-oi1-x233.google.com
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

Add RISC-V privilege 1.13 support.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by:  Weiwei Li <liwei1518@gmail.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.c         | 6 +++++-
 target/riscv/cpu.h         | 4 +++-
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 4 ++++
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6dd3d7f4a3..ee2ec4c4e5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1775,7 +1775,9 @@ static int priv_spec_from_str(const char *priv_spec_str)
 {
     int priv_version = -1;
 
-    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
+    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
+        priv_version = PRIV_VERSION_1_13_0;
+    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
         priv_version = PRIV_VERSION_1_12_0;
     } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
         priv_version = PRIV_VERSION_1_11_0;
@@ -1795,6 +1797,8 @@ const char *priv_spec_to_str(int priv_version)
         return PRIV_VER_1_11_0_STR;
     case PRIV_VERSION_1_12_0:
         return PRIV_VER_1_12_0_STR;
+    case PRIV_VERSION_1_13_0:
+        return PRIV_VER_1_13_0_STR;
     default:
         return NULL;
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 140eb43fcb..f691c7d828 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -96,12 +96,14 @@ extern RISCVCPUProfile *riscv_profiles[];
 #define PRIV_VER_1_10_0_STR "v1.10.0"
 #define PRIV_VER_1_11_0_STR "v1.11.0"
 #define PRIV_VER_1_12_0_STR "v1.12.0"
+#define PRIV_VER_1_13_0_STR "v1.13.0"
 enum {
     PRIV_VERSION_1_10_0 = 0,
     PRIV_VERSION_1_11_0,
     PRIV_VERSION_1_12_0,
+    PRIV_VERSION_1_13_0,
 
-    PRIV_VERSION_LATEST = PRIV_VERSION_1_12_0,
+    PRIV_VERSION_LATEST = PRIV_VERSION_1_13_0,
 };
 
 #define VEXT_VERSION_1_00_0 0x00010000
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e1e4f32698..fb7eebde52 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -136,6 +136,7 @@ struct RISCVCPUConfig {
      * TCG always implement/can't be user disabled,
      * based on spec version.
      */
+    bool has_priv_1_13;
     bool has_priv_1_12;
     bool has_priv_1_11;
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fa186093fb..f53422d605 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -318,6 +318,10 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
         cpu->cfg.has_priv_1_12 = true;
     }
 
+    if (cpu->env.priv_ver >= PRIV_VERSION_1_13_0) {
+        cpu->cfg.has_priv_1_13 = true;
+    }
+
     /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-- 
2.34.1


