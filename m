Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA4EC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvMu-0008MG-DK; Fri, 02 Feb 2024 10:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVvMs-0008LT-F9
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:22:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVvMq-0004VE-B6
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:22:14 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d73066880eso18963105ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706887330; x=1707492130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crMs0TjlIW4LbTUJXKCF3/deGXPHxSvc3WCGvBYMo2o=;
 b=Ig50XAki2gnkp168Sj0GWfj86+gGnbDKBtHMZDSF7g4IfrO8xi6C50JDiOWYib2BaK
 dQDlysjN+bNipMrAMkNcJpQm4GasvhsVncXmv/K9ufKAObR3pIQ0pV6+0r+yLm4kiiNJ
 Y9svuPOGC9pRywiyLYVtSq0oJii/7JNFrFcy7PoWwxgXr4PuieiEKD+zVbePAVohvZ6c
 2KT0WhSQ7sLm6H6vby98VkmZYA+fkQeScH+sK/3yUbVHEoKOkUN31fH8CEgJGNq0coxI
 HMidWJwc3AycUGk1etd3K9hMVDfD8oNcPK9Ugc6lMp/rWC0UQMzh1VG69dvDpqm8ZUaR
 UUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706887330; x=1707492130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crMs0TjlIW4LbTUJXKCF3/deGXPHxSvc3WCGvBYMo2o=;
 b=Bsy+XExWl9mj73VBdUulNDyuLYSe+KOxkJgeV+IjfxDVQqlqIMph5FHIqWHlDSXWuQ
 bajjUSuoOHDyTF43jbkSCpbRtf57UMbOus5589vlv0fLAS1kUYYJZHUvR4nkSPRycgEr
 eJHJ7ckPm+cIPy1h7Tfj1jjzoSLWORap0Ha6m19fbdaw6qf7530gnQnDC75Pi0olcOPl
 Q+Dkg2MpQKIe6XV+Dj6FtZ/Rcb09nio4e/noj9GrqRiqWSeHLFiI8JKgM6in8Vhb1Kho
 Yd9BxbACmWrGqV7c2ZK9jWyvSNQLaEuUf6BiN0CCBtVH7nVwgovxpalz/WcGvpCoF7HV
 AeJA==
X-Gm-Message-State: AOJu0YwCd+kOc5e1f37qlHupiKzlPSroAe5F7QPgxlqC7fymO1tTF2yI
 MTEgSm5mGqKYKoDE3uY2xU6fS+jyswEO/RMB21UT6UjLjFIoXsDrffnzusRzIxtFERQSg9JRowF
 a
X-Google-Smtp-Source: AGHT+IGcJv3l8xid/Rk44dgQjXYbJ9MvHk8sLRdxHIFGUQeGxk1oF4JOtfY3glBNi7GvtXKEVgrMwg==
X-Received: by 2002:a17:902:e844:b0:1d8:ec96:ad43 with SMTP id
 t4-20020a170902e84400b001d8ec96ad43mr10150786plg.12.1706887330314; 
 Fri, 02 Feb 2024 07:22:10 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVDMFsSzYO6uiI+j7IGOHl4eXP4xJrDjXCpvEpNAYfD6maWsNUC5M0fNW00F7sJ7//BP0DK1ouvs5peOA4KvxUWAPVPQ5d7/CwREekDSc4REhZ6YEF4mt7jjBJZBGfCCk47yvnYJLFP29zmeBlWIyNRJZgk51i1WQCm7sPj2Uvdgko+vY9YGOrJ+zAgpAiC8x4mTX+ghgCc2oXDj1tJkr+HrIyhQWvNYXThuz6Vny1EGqyn89sUYzo04KjCcdJQLQeWFvny4iGiBtb1S9iQ8Hcs2mzNxU1oaQ==
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902f24300b001d714a1530bsm1734381plc.176.2024.02.02.07.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:22:09 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 3/6] target/riscv: add remaining named features
Date: Fri,  2 Feb 2024 12:21:51 -0300
Message-ID: <20240202152154.773253-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202152154.773253-1-dbarboza@ventanamicro.com>
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++-------
 target/riscv/cpu_cfg.h     |  6 ++++++
 target/riscv/tcg/tcg-cpu.c |  2 ++
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 28d3cfa8ce..94843c4f6e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -101,6 +101,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
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
@@ -109,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
+    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_always_enabled),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
@@ -170,8 +175,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
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
@@ -1512,6 +1521,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
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
@@ -1523,6 +1537,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
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
 
@@ -2116,13 +2147,10 @@ static const PropertyInfo prop_marchid = {
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
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 698f926ab1..c5049ec664 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -126,6 +126,12 @@ struct RISCVCPUConfig {
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
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 90861cc065..673097c6e4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1347,6 +1347,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     Object *obj = OBJECT(cpu);
 
+    cpu->cfg.ext_always_enabled = true;
+
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     riscv_cpu_add_user_properties(obj);
-- 
2.43.0


