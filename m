Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDCEC48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 19:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT5nB-0004cg-Ue; Thu, 25 Jan 2024 14:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rT5n9-0004cO-7h
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:53:39 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rT5n7-0001T4-AZ
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:53:38 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-290da27f597so2095104a91.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 11:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706212415; x=1706817215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4ShkI0TjkmG6ZlfNnJWcuoiTmAtnWjDmaAM79Mzrac=;
 b=o9zEoqSPYN4Me5BiZYnrfS/KtoxszDUkQGFi+GyCMHCBh1nOYnSgBA4AqmX/RzF5pf
 LJNJx3wEmtZQMZjUJGUs+qTT+Hbst/XWkNf5fEVsgZ4s6JKfRymZwLnakUzHOxbqeY2S
 J++f3zIAkMwaj7rJ4zlphX7JVJXWhbtX7+7kKp2kdwcjVW4ltOnCPPnyNGc7K+R/Mzvy
 O1NjyTQ7JekyFz5EgxOgmDGnA+PnnoaiMwJJ93OsHRHiOCxU+VoR9PSstpob2DtS3jGF
 fV3FlVaI5dZGzkfWQxJP8pQyJScpDXOvgHpGo8GKO2beR3gosvgkMf78j+jNhDB9PL43
 HJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706212415; x=1706817215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r4ShkI0TjkmG6ZlfNnJWcuoiTmAtnWjDmaAM79Mzrac=;
 b=AI9KD4f50zNq6ZDaOCyHtbxTTQBpGubcPLHT9SVpEA8KvTHWwbjAukYJqKarnPYjC6
 EQRnk5oeXPieOdmz6wlNIEwbhmDtJYpy3yokDh9252mXgHfMk7QrZFnh3jWpgI9tOG/i
 /dZsztawLbvQ6tW0W/DHGYDgBis5VT7eD8QNzFJDwXg1+SzJn/LlN4EWf+LFXoD3gSNc
 EAMXP8S3GCwdleQrhxtn2DrwZAzGnmj81jgl76PrQrQQ8KMQxbJ8ZYy+99qrDXkos+Rj
 POs+aocuwA86yEgnznPxCbuHEJja5RBeCbIguOAcgRRzYYiHdqlybiAlpS2SEkeh2Ozs
 H1qQ==
X-Gm-Message-State: AOJu0Yz8X/8v9Pv+QQ/juCMEh5VujkU9hn3TASI/WFQ+obVZXIoi7JOr
 YIcpczBM3lXltuuDjTotSpOvBQToR5rsyyGuawAKRdFfPYg1UwPfgvKXRDHc7qZti7yJbUZNqLQ
 y
X-Google-Smtp-Source: AGHT+IGtj6UfQl6gyQN9TZ/itgj9d4FDI8ZPAQOTHNfbPEPcABzMxGM7BVwML3IUpzLqsl5WpRs5tw==
X-Received: by 2002:a17:90a:fe0b:b0:28b:3335:1489 with SMTP id
 ck11-20020a17090afe0b00b0028b33351489mr117841pjb.99.1706212415011; 
 Thu, 25 Jan 2024 11:53:35 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a17090ad40700b0028b6759d8c1sm1958613pju.29.2024.01.25.11.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 11:53:34 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/6] target/riscv: add remaining named features
Date: Thu, 25 Jan 2024 16:53:16 -0300
Message-ID: <20240125195319.329181-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125195319.329181-1-dbarboza@ventanamicro.com>
References: <20240125195319.329181-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
entry.  Let's add them to riscv_cpu_named_features[].

They will also need to be explicitly enabled in both profile
descriptions. TCG will enable the named features it already implements,
other accelerators are free to handle it as they like.

After this patch, here's the riscv,isa from a buildroot using the
'rva22s64' CPU:

 # cat /proc/device-tree/cpus/cpu@0/riscv,isa
rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse_
zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
zbs_zkt_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 41 +++++++++++++++++++++++++++++---------
 target/riscv/cpu_cfg.h     |  9 +++++++++
 target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++-
 3 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 28d3cfa8ce..1ecd8a57ed 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -101,6 +101,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
+    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, ext_ziccamoa),
+    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, ext_ziccif),
+    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
+    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
@@ -109,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
+    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_za64rs),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
@@ -170,8 +175,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
+    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, ext_ssccptr),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
+    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, ext_sscounterenw),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
+    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, ext_sstvala),
+    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, ext_sstvecd),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
@@ -1523,6 +1532,22 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
 
+    /*
+     * cache-related extensions that are always enabled
+     * since QEMU RISC-V does not have a cache model.
+     */
+    MULTI_EXT_CFG_BOOL("za64rs", ext_za64rs, true),
+    MULTI_EXT_CFG_BOOL("ziccif", ext_ziccif, true),
+    MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
+    MULTI_EXT_CFG_BOOL("ziccamoa", ext_ziccamoa, true),
+    MULTI_EXT_CFG_BOOL("zicclsm", ext_zicclsm, true),
+    MULTI_EXT_CFG_BOOL("ssccptr", ext_ssccptr, true),
+
+    /* Other named features that QEMU TCG always implements */
+    MULTI_EXT_CFG_BOOL("sstvecd", ext_sstvecd, true),
+    MULTI_EXT_CFG_BOOL("sstvala", ext_sstvala, true),
+    MULTI_EXT_CFG_BOOL("sscounterenw", ext_sscounterenw, true),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2116,13 +2141,8 @@ static const PropertyInfo prop_marchid = {
 };
 
 /*
- * RVA22U64 defines some 'named features' or 'synthetic extensions'
- * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
- * and Zicclsm. We do not implement caching in QEMU so we'll consider
- * all these named features as always enabled.
- *
- * There's no riscv,isa update for them (nor for zic64b, despite it
- * having a cfg offset) at this moment.
+ * RVA22U64 defines some cache related extensions: Za64rs,
+ * Ziccif, Ziccrse, Ziccamoa and Zicclsm.
  */
 static RISCVCPUProfile RVA22U64 = {
     .parent = NULL,
@@ -2139,7 +2159,9 @@ static RISCVCPUProfile RVA22U64 = {
         CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
 
         /* mandatory named features for this profile */
-        CPU_CFG_OFFSET(ext_zic64b),
+        CPU_CFG_OFFSET(ext_za64rs), CPU_CFG_OFFSET(ext_zic64b),
+        CPU_CFG_OFFSET(ext_ziccif), CPU_CFG_OFFSET(ext_ziccrse),
+        CPU_CFG_OFFSET(ext_ziccamoa), CPU_CFG_OFFSET(ext_zicclsm),
 
         RISCV_PROFILE_EXT_LIST_END
     }
@@ -2170,7 +2192,8 @@ static RISCVCPUProfile RVA22S64 = {
         CPU_CFG_OFFSET(ext_svinval),
 
         /* rva22s64 named features */
-        CPU_CFG_OFFSET(ext_svade),
+        CPU_CFG_OFFSET(ext_sstvecd), CPU_CFG_OFFSET(ext_sstvala),
+        CPU_CFG_OFFSET(ext_sscounterenw), CPU_CFG_OFFSET(ext_svade),
 
         RISCV_PROFILE_EXT_LIST_END
     }
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 698f926ab1..f79fc3dfd1 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -125,6 +125,15 @@ struct RISCVCPUConfig {
     /* Named features  */
     bool ext_svade;
     bool ext_zic64b;
+    bool ext_za64rs;
+    bool ext_ziccif;
+    bool ext_ziccrse;
+    bool ext_ziccamoa;
+    bool ext_zicclsm;
+    bool ext_ssccptr;
+    bool ext_sstvecd;
+    bool ext_sstvala;
+    bool ext_sscounterenw;
 
     /* Vendor-specific custom extensions */
     bool ext_xtheadba;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 90861cc065..6d5028cf84 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -206,7 +206,8 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
         cpu->cfg.ext_svadu = false;
         break;
     default:
-        g_assert_not_reached();
+        /* Named feature already enabled in riscv_tcg_cpu_instance_init */
+        return;
     }
 }
 
@@ -1342,6 +1343,20 @@ static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
 }
 
+/* Named features that TCG always implements */
+static void riscv_tcg_cpu_enable_named_feats(RISCVCPU *cpu)
+{
+    cpu->cfg.ext_za64rs = true;
+    cpu->cfg.ext_ziccif = true;
+    cpu->cfg.ext_ziccrse = true;
+    cpu->cfg.ext_ziccamoa = true;
+    cpu->cfg.ext_zicclsm = true;
+    cpu->cfg.ext_ssccptr = true;
+    cpu->cfg.ext_sstvecd = true;
+    cpu->cfg.ext_sstvala = true;
+    cpu->cfg.ext_sscounterenw = true;
+}
+
 static void riscv_tcg_cpu_instance_init(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -1354,6 +1369,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
     if (riscv_cpu_has_max_extensions(obj)) {
         riscv_init_max_cpu_extensions(obj);
     }
+
+    riscv_tcg_cpu_enable_named_feats(cpu);
 }
 
 static void riscv_tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
-- 
2.43.0


