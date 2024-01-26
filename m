Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C14C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMId-0000tN-Eq; Fri, 26 Jan 2024 08:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTMIY-0000mL-Ui
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:31:10 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTMIV-0007bi-Io
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:31:10 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55cd798b394so3413300a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706275866; x=1706880666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tl3XBkr9UAckB5F+y1ZuGxqnzti7OGSHUoOS8FVpCXc=;
 b=bYHyK6CJlWEmq/AsiUDuMcNpnRAGvpk8zQmRkB03Fht4MGaGLLjQp0AGUMg4LWmIxT
 nkJUe4e38vSRixrfqGfbxfvdDo7ml509BYVkLCBC3fPLXJVG5GVoq5K9fbGyQLJct059
 MnIFKYMF0TeN88ooq89q3Ay9+lIzdQtwQqiVtNUy8BEqKv6XlnBK9CRtoZoXK9NHTCD1
 aHFjR7rMq3v7gO/yXyoz9PgvBuI6ZK3RAMqErlY9L/ltkKnh3+5Eesj03R1ZEzO3ZDi9
 iG56vVjkgtCa5smPtvsaGOlFd5qpUBaEgKLUM2dRDzk6k2O1aOSo8nvi33PSin9S1r3l
 5D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706275866; x=1706880666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tl3XBkr9UAckB5F+y1ZuGxqnzti7OGSHUoOS8FVpCXc=;
 b=dxkKqFQakGaTCnPbDfU6C+5TXogJVp2mS0dzCT9hPTKDQHI+9Pm66SbQQSYpYG7iip
 OZDO5HAdpmihmPJ6zyNYmSNU+RZGWlTV1RSJKxhMhNJ9dq7wzEpS3R0g5achXavOGTcI
 cVMFvl0GQdGL4Biy2GjUAVKksFiMCaky276uEC8A/sGsMB3sar67TZ0gAXr+1pn1VfyU
 YXu5ooe1DQPVOItxe4l16jDIIFQ30w9Nd6her6lICI40DuMcYVZA1QVqyLdkRyZIHlF2
 N83bxCly3BlMLmLHXvdX9v+BiKXykmA/p9VOQL+FOPkU5WotpEs3WEJIRfgAVPGFZxPm
 4VnQ==
X-Gm-Message-State: AOJu0YxFOgjN86UHE0luT7B+GfWxU1pgN4lzhcDPqXbARh33y/jQLNYE
 W1bwb06kwUPe+mPq8I8ZmoJwR7dnMsWqywPrT1FNj21eC5GBkZp0dZu3PnVBtAqGxyKAcgGOHZI
 X
X-Google-Smtp-Source: AGHT+IGpkgqPVr30LJd8/i3GP/SiHVu9imMqt5sOaVI3A5WqGD9WuYOvI1wbqYP/VMqT+tFNjVLgqQ==
X-Received: by 2002:a17:906:f6da:b0:a33:b38:f296 with SMTP id
 jo26-20020a170906f6da00b00a330b38f296mr1388462ejb.21.1706275866062; 
 Fri, 26 Jan 2024 05:31:06 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 hu21-20020a170907a09500b00a3472ae7782sm629357ejc.100.2024.01.26.05.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 05:31:05 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 dbarboza@ventanamicro.com
Subject: [PATCH v2 2/6] target/riscv: add riscv,isa to named features
Date: Fri, 26 Jan 2024 14:31:04 +0100
Message-ID: <20240126133101.61344-10-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126133101.61344-8-ajones@ventanamicro.com>
References: <20240126133101.61344-8-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52f.google.com
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
---
 target/riscv/cpu.c         | 17 +++++++++++++----
 target/riscv/cpu_cfg.h     |  6 ++++--
 target/riscv/tcg/tcg-cpu.c | 16 ++++++----------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 88e8cc868144..28d3cfa8ce59 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -97,6 +97,7 @@ bool riscv_cpu_option_set(const char *optname)
  * instead.
  */
 const RISCVIsaExtData isa_edata_arr[] = {
+    ISA_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
@@ -171,6 +172,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
+    ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
@@ -1510,9 +1512,16 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
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
@@ -2130,7 +2139,7 @@ static RISCVCPUProfile RVA22U64 = {
         CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
 
         /* mandatory named features for this profile */
-        CPU_CFG_OFFSET(zic64b),
+        CPU_CFG_OFFSET(ext_zic64b),
 
         RISCV_PROFILE_EXT_LIST_END
     }
@@ -2161,7 +2170,7 @@ static RISCVCPUProfile RVA22S64 = {
         CPU_CFG_OFFSET(ext_svinval),
 
         /* rva22s64 named features */
-        CPU_CFG_OFFSET(svade),
+        CPU_CFG_OFFSET(ext_svade),
 
         RISCV_PROFILE_EXT_LIST_END
     }
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e241922f89c4..698f926ab1be 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -117,13 +117,15 @@ struct RISCVCPUConfig {
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
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 88f92d1c7d2c..90861cc065e5 100644
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
@@ -349,11 +345,11 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 
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
2.43.0


