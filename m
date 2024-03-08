Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8853C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9Y-0006dp-ON; Fri, 08 Mar 2024 06:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9X-0006dY-5R
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:39 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9S-0001TL-51
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:38 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso1469655a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896352; x=1710501152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSB+/0sSHCRcEM29L2mFXHsw/2xIPlSEYZUdVomCEN4=;
 b=ZNCxpTMJe688TSD+tOmKy0b53uAtEeKRxUyuRKiHW6dpRdP4zBybhlznf2FdrYUHBr
 TMjW2gHOIIRX0yHdgRZ3/VPepsOUb/rWHE1ZQQqt+NRScrGqELjjNvsVc0FWrjf2foFe
 43wcoC1iXNWR/zpXpYm95Vk8Lpn++EnK05TKKzpDdBb7QLFWtsNPbz2KNuVtdQEF7Vdf
 FVUrGTJrgxeDoCFqi6JSdM8O+jRPUceBb7428V3ZZhnjh9HbdCoRXFzRXpmo5STggLDu
 ncXWfVwt/X5xpRLZ+mmcRzp7kiTP6YartBzaSRLzVA4mn0EnnbMH5ZnxAXjVR3ekON+H
 7vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896352; x=1710501152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSB+/0sSHCRcEM29L2mFXHsw/2xIPlSEYZUdVomCEN4=;
 b=CKFjB9ID9ht0vqT2KhzMwJ9nj7iWrPg7MwirYeefDO9bLS9UgvkLekUzk3aRyb+tOG
 AgrqzgrhSSJOA2Oe01Wa/XeS1WBW7Jg4KKxOMb8pVb/U7yGbAFXtLEeuvRAYCKw2wmYz
 3Hav7ExQ3+BEox0Ar7JsZEzMvs/y550wWrBFc+Yhri5eux7AAbEo/mAfqZnJlhvnwijT
 U5GUM5tpuK4j0FahtgVgD6ihBqCDcepg7jHMeGRaQfM1hg9We5ueo3Tn7mr2pyKix71N
 Xfqh6vjVIK9eZPj35GftNuOP7P9bHXbLh26mo/AqAGi0ffJw1RM2v9cjoBnk33tXw5pe
 mJAA==
X-Gm-Message-State: AOJu0Yxu1ZOUrqxVL4KnrFuRllWiyINwFD/uFbswG9fzBZMYoSro5900
 mYsZZA7KCz0XY1sTEqvKtD3YKjntIrXwcLhe9JpwgzMWe2I+fC8nBwHt+0EFmyp+8A==
X-Google-Smtp-Source: AGHT+IG95/ieIkLNMU0psnao9g3XwXaOaYDZlJ1XqLOxvqF3zO9p8Oih15T6fRX/XE9oKAbVQSiELg==
X-Received: by 2002:a17:902:c3c6:b0:1dc:a60f:4bef with SMTP id
 j6-20020a170902c3c600b001dca60f4befmr9769184plj.63.1709896352374; 
 Fri, 08 Mar 2024 03:12:32 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:31 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 09/34] target/riscv: add remaining named features
Date: Fri,  8 Mar 2024 21:11:27 +1000
Message-ID: <20240308111152.2856137-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The RVA22U64 and RVA22S64 profiles mandates certain extensions that,
until now, we were implying that they were available.

We can't do this anymore since named features also has a riscv,isa
entry. Let's add them to riscv_cpu_named_features[].

Instead of adding one bool for each named feature that we'll always
implement, i.e. can't be turned off, add a 'ext_always_enabled' bool in
cpu->cfg. This bool will be set to 'true' in TCG accel init, and all
named features will point to it. This also means that KVM won't see
these features as always enable, which is our intention.

If any accelerator adds support to disable one of these features, we'll
have to promote them to regular extensions and allow users to disable it
via command line.

After this patch, here's the riscv,isa from a buildroot using the
'rva22s64' CPU:

 # cat /proc/device-tree/cpus/cpu@0/riscv,isa
rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse_
zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
zbs_zkt_ssccptr_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20240215223955.969568-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     |  6 ++++++
 target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++-------
 target/riscv/tcg/tcg-cpu.c |  2 ++
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e68a4ddb92..be39870691 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -128,6 +128,12 @@ struct RISCVCPUConfig {
     bool ext_svade;
     bool ext_zic64b;
 
+    /*
+     * Always 'true' boolean for named features
+     * TCG always implement/can't be disabled.
+     */
+    bool ext_always_enabled;
+
     /* Vendor-specific custom extensions */
     bool ext_xtheadba;
     bool ext_xtheadbb;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f0cd408237..4c4fa79145 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -102,6 +102,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
+    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_always_enabled),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
@@ -110,6 +114,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
+    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_always_enabled),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
     ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
@@ -173,8 +178,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
+    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, ext_always_enabled),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
+    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, ext_always_enabled),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
+    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, ext_always_enabled),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
@@ -1567,6 +1576,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+#define ALWAYS_ENABLED_FEATURE(_name) \
+    {.name = _name, \
+     .offset = CPU_CFG_OFFSET(ext_always_enabled), \
+     .enabled = true}
+
 /*
  * 'Named features' is the name we give to extensions that we
  * don't want to expose to users. They are either immutable
@@ -1578,6 +1592,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
 
+    /*
+     * cache-related extensions that are always enabled
+     * in TCG since QEMU RISC-V does not have a cache
+     * model.
+     */
+    ALWAYS_ENABLED_FEATURE("za64rs"),
+    ALWAYS_ENABLED_FEATURE("ziccif"),
+    ALWAYS_ENABLED_FEATURE("ziccrse"),
+    ALWAYS_ENABLED_FEATURE("ziccamoa"),
+    ALWAYS_ENABLED_FEATURE("zicclsm"),
+    ALWAYS_ENABLED_FEATURE("ssccptr"),
+
+    /* Other named features that TCG always implements */
+    ALWAYS_ENABLED_FEATURE("sstvecd"),
+    ALWAYS_ENABLED_FEATURE("sstvala"),
+    ALWAYS_ENABLED_FEATURE("sscounterenw"),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2171,13 +2202,10 @@ static const PropertyInfo prop_marchid = {
 };
 
 /*
- * RVA22U64 defines some 'named features' or 'synthetic extensions'
- * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
- * and Zicclsm. We do not implement caching in QEMU so we'll consider
- * all these named features as always enabled.
- *
- * There's no riscv,isa update for them (nor for zic64b, despite it
- * having a cfg offset) at this moment.
+ * RVA22U64 defines some 'named features' that are cache
+ * related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
+ * and Zicclsm. They are always implemented in TCG and
+ * doesn't need to be manually enabled by the profile.
  */
 static RISCVCPUProfile RVA22U64 = {
     .parent = NULL,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 2307999387..ea763abb31 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1315,6 +1315,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     Object *obj = OBJECT(cpu);
 
+    cpu->cfg.ext_always_enabled = true;
+
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     riscv_cpu_add_user_properties(obj);
-- 
2.44.0


