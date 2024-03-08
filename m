Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99669C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9U-0006bm-5b; Fri, 08 Mar 2024 06:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9S-0006b5-L5
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:34 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9Q-0001Ro-RG
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:34 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so1488457a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896349; x=1710501149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEuBDtGMVvlQ4QCQCjbUa4tCVdHPNF2kJSyIjymdtuA=;
 b=fRbB2konSEHIA/NuRuAUuxvLVfthrB+MEpr3hu3JXyc9cT/AwnNB9TInA67p7ppmRa
 BVOMGUipMvd4SXntXVzG97sYQDYW6XW7lSB2PQaSikC4XDSHpdE2HoaJXJxpWjsbPzRw
 XGhFfB79m2lM35sIUYwT9S6Ug7BetVGFmXax7ph67w4d8vLSueHBLM+zgJ0RMn9YZ7j3
 Wf7g7vFC+P1nT3EFrKZzqstZmqsgk0Rik3oLvdfgI57DHCBEsw9J+nNsjLniMtTucy49
 V65plGIVAiiYtJgv6X2sPtK35rGfKZwBqWj87BVAL1Whpz0is/vMkgegtS0hWP8PL0R1
 r1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896349; x=1710501149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IEuBDtGMVvlQ4QCQCjbUa4tCVdHPNF2kJSyIjymdtuA=;
 b=uuWhsAoDNBIBIhbjIg7lZfuaTGdkr3li0OTdmEnpDPUHlgldMIwQtn9uPHym0bf0C8
 LocIZv2RobvsEdyw9gC0OfSPZ/tOad0E/jPAySBDjXa2HYuWBhERrtkS6+dNkCkbzBRp
 mcO31opbh0sLUXT3I4L1qixS4uMZ+dM3eC+93zGd22Hn2BrNyqrqW0Mldnhdm52HeXMS
 9oXsOi2d3LQlJksqo8hSE2DpmFEG+2/wTOb63/lSJTAvIECrksyKaU2kIhtXeZ6ksk5J
 iPyz2bVxXNu49hb/KQCB1707tNPH0b8tgjXMZlr7d1WBoXQL5XfncExHGS6ZbkeoTKjC
 FNjA==
X-Gm-Message-State: AOJu0Yz0JQqO5EKBnrgfIfih7MEHnWzbIfxngBF3nTdHtNrZybp82cH/
 tlGrpxwLxCDfUu+Jd6W5wW5F6NEcXYT9FP4J173fx4BszKT9HwH/DfG/FtYAkJSlPA==
X-Google-Smtp-Source: AGHT+IHN1DU4klYmVzu2ZVfB+QpXuGU3kPgdGgiMjTRvAhu5Vi8sVddOPaTo1nCjh68RVK5XcM/uuQ==
X-Received: by 2002:a05:6a20:5482:b0:1a1:6d59:2e0b with SMTP id
 i2-20020a056a20548200b001a16d592e0bmr5688661pzk.10.1709896349181; 
 Fri, 08 Mar 2024 03:12:29 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:28 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/34] target/riscv: add riscv,isa to named features
Date: Fri,  8 Mar 2024 21:11:26 +1000
Message-ID: <20240308111152.2856137-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

Further discussions after the introduction of rva22 support in QEMU
revealed that what we've been calling 'named features' are actually
regular extensions, with their respective riscv,isa DTs. This is
clarified in [1]. [2] is a bug tracker asking for the profile spec to be
less cryptic about it.

As far as QEMU goes we understand extensions as something that the user
can enable/disable in the command line. This isn't the case for named
features, so we'll have to reach a middle ground.

We'll keep our existing nomenclature 'named features' to refer to any
extension that the user can't control in the command line. We'll also do
the following:

- 'svade' and 'zic64b' flags are renamed to 'ext_svade' and
  'ext_zic64b'. 'ext_svade' and 'ext_zic64b' now have riscv,isa strings and
  priv_spec versions;

- skip name feature check in cpu_bump_multi_ext_priv_ver(). Now that
  named features have a riscv,isa and an entry in isa_edata_arr[] we
  don't need to gate the call to cpu_cfg_ext_get_min_version() anymore.

[1] https://github.com/riscv/riscv-profiles/issues/121
[2] https://github.com/riscv/riscv-profiles/issues/142

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240215223955.969568-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     |  6 ++++--
 target/riscv/cpu.c         | 17 +++++++++++++----
 target/riscv/tcg/tcg-cpu.c | 16 ++++++----------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 833bf58217..e68a4ddb92 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -119,13 +119,15 @@ struct RISCVCPUConfig {
     bool ext_smepmp;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
-    bool svade;
-    bool zic64b;
 
     uint32_t mvendorid;
     uint64_t marchid;
     uint64_t mimpid;
 
+    /* Named features  */
+    bool ext_svade;
+    bool ext_zic64b;
+
     /* Vendor-specific custom extensions */
     bool ext_xtheadba;
     bool ext_xtheadbb;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5ff0192c52..f0cd408237 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -98,6 +98,7 @@ bool riscv_cpu_option_set(const char *optname)
  * instead.
  */
 const RISCVIsaExtData isa_edata_arr[] = {
+    ISA_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
@@ -174,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
+    ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
@@ -1565,9 +1567,16 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+/*
+ * 'Named features' is the name we give to extensions that we
+ * don't want to expose to users. They are either immutable
+ * (always enabled/disable) or they'll vary depending on
+ * the resulting CPU state. They have riscv,isa strings
+ * and priv_ver like regular extensions.
+ */
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
-    MULTI_EXT_CFG_BOOL("svade", svade, true),
-    MULTI_EXT_CFG_BOOL("zic64b", zic64b, true),
+    MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
+    MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
 
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -2185,7 +2194,7 @@ static RISCVCPUProfile RVA22U64 = {
         CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
 
         /* mandatory named features for this profile */
-        CPU_CFG_OFFSET(zic64b),
+        CPU_CFG_OFFSET(ext_zic64b),
 
         RISCV_PROFILE_EXT_LIST_END
     }
@@ -2216,7 +2225,7 @@ static RISCVCPUProfile RVA22S64 = {
         CPU_CFG_OFFSET(ext_svinval),
 
         /* rva22s64 named features */
-        CPU_CFG_OFFSET(svade),
+        CPU_CFG_OFFSET(ext_svade),
 
         RISCV_PROFILE_EXT_LIST_END
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ee4c349972..2307999387 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -197,12 +197,12 @@ static bool cpu_cfg_offset_is_named_feat(uint32_t ext_offset)
 static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
 {
     switch (feat_offset) {
-    case CPU_CFG_OFFSET(zic64b):
+    case CPU_CFG_OFFSET(ext_zic64b):
         cpu->cfg.cbom_blocksize = 64;
         cpu->cfg.cbop_blocksize = 64;
         cpu->cfg.cboz_blocksize = 64;
         break;
-    case CPU_CFG_OFFSET(svade):
+    case CPU_CFG_OFFSET(ext_svade):
         cpu->cfg.ext_svadu = false;
         break;
     default:
@@ -219,10 +219,6 @@ static void cpu_bump_multi_ext_priv_ver(CPURISCVState *env,
         return;
     }
 
-    if (cpu_cfg_offset_is_named_feat(ext_offset)) {
-        return;
-    }
-
     ext_priv_ver = cpu_cfg_ext_get_min_version(ext_offset);
 
     if (env->priv_ver < ext_priv_ver) {
@@ -322,11 +318,11 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 
 static void riscv_cpu_update_named_features(RISCVCPU *cpu)
 {
-    cpu->cfg.zic64b = cpu->cfg.cbom_blocksize == 64 &&
-                      cpu->cfg.cbop_blocksize == 64 &&
-                      cpu->cfg.cboz_blocksize == 64;
+    cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
+                          cpu->cfg.cbop_blocksize == 64 &&
+                          cpu->cfg.cboz_blocksize == 64;
 
-    cpu->cfg.svade = !cpu->cfg.ext_svadu;
+    cpu->cfg.ext_svade = !cpu->cfg.ext_svadu;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.44.0


