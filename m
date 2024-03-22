Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0D0C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnakr-0001HR-Te; Fri, 22 Mar 2024 05:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnakr-0001GS-3N
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:00:01 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnako-0001tc-75
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:59:59 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4d43a1f0188so705148e0c.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 01:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711097997; x=1711702797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZXIs8sadw+5YTvtfFcTNBIyJz0eNqaMZ6kYLK2RH70=;
 b=E2gKLBooRAk5cWdxHnls2nGCErhwTXqFHCR9+tAjEmcg7Ly3B4azA8dDTcmySaxB4n
 iEzTH5v8iQmFyFoEe0vMr57vt/oAe+eZuEfAJdRbLV7N0VqKGa6Y27byxhSbhmlA3OmR
 YsNz61o2D7F9TtjDoo3lwqeEF+mp3glX+rQcMXUqoEagN2ZJ+WaQcsfIK2PTKGrhlSNI
 LrVDN/fxNDGJ5GAP7/kWlBXiatRcN04MoAwgOFQ9MQlGQ/gfQHwKK+OdJw+/R8Ufh7gt
 DlYO2f3b0KMR9ni6OKdG3kVwDaGGupjzo/vmpaP/YdfkCt35iTEXSu7UiLYEYD/J8SRG
 2cpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711097997; x=1711702797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZXIs8sadw+5YTvtfFcTNBIyJz0eNqaMZ6kYLK2RH70=;
 b=KJ5znfnDTl+TquI25FjIuruON+IlJQ02gUaglykIUNUwGTSv6lqCW9+9MSO1mVSS37
 3qEyNkSbqm33+IqnjUXAn1zk0ASbPLacj5EaKbMhX4PBWfEsftAAoyAVUwncj500AnB/
 5uv9hR0zDoorS7MFroejvRYFsDtfP5BG2EKgNj7Q2CCcTiyF8MrqttT+leM4nJoM7+n3
 /IR+iqtcJ5i3Aizwcf9UbxTLSp5/R5ANHlF9HoFjnuxobOi7Hk2cZ3kSmRGIgVIlcBhd
 aqX+Rl4M8TCHEVksh8Syy4BF5eX2AzBGu/ipIQ7upDSaVcOd/zARRCuA4lFI2Mvn/K5Y
 xK6A==
X-Gm-Message-State: AOJu0YwjNjSDeSD+46R8sSDMEca8KcdYIubRA4gFsuBlBpTbEOJdiyQK
 2DvexWZvg7FS8DyIJGNZjCxgb7/HKrnetzLbeCzR4R5vgsU3BzYKKJZwkzs5KrKE9g==
X-Google-Smtp-Source: AGHT+IGeybim0zxVpQSNEizFFfzf6EcTTl27vkBc7WRGykSjsQKPQIrInvDujZe9EWekMCM9F4BrJA==
X-Received: by 2002:a05:6a20:b92:b0:1a3:463e:af40 with SMTP id
 i18-20020a056a200b9200b001a3463eaf40mr1518020pzh.24.1711097611077; 
 Fri, 22 Mar 2024 01:53:31 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:53:30 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/15] target/riscv: do not enable all named features by default
Date: Fri, 22 Mar 2024 18:53:05 +1000
Message-ID: <20240322085319.1758843-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit 3b8022269c added the capability of named features/profile
extensions to be added in riscv,isa. To do that we had to assign priv
versions for each one of them in isa_edata_arr[]. But this resulted in a
side-effect: vendor CPUs that aren't running priv_version_latest started
to experience warnings for these profile extensions [1]:

  | $ qemu-system-riscv32  -M sifive_e
  | qemu-system-riscv32: warning: disabling zic64b extension for hart
0x00000000 because privilege spec version does not match
  | qemu-system-riscv32: warning: disabling ziccamoa extension for
hart 0x00000000 because privilege spec version does not match

This is benign as far as the CPU behavior is concerned since disabling
both extensions is a no-op (aside from riscv,isa). But the warnings are
unpleasant to deal with, especially because we're sending user warnings
for extensions that users can't enable/disable.

Instead of enabling all named features all the time, separate them by
priv version. During finalize() time, after we decided which
priv_version the CPU is running, enable/disable all the named extensions
based on the priv spec chosen. This will be enough for a bug fix, but as
a future work we should look into how we can name these extensions in a
way that we don't need an explicit ext_name => priv_ver as we're doing
here.

The named extensions being added in isa_edata_arr[] that will be
enabled/disabled based solely on priv version can be removed from
riscv_cpu_named_features[]. 'zic64b' is an extension that can be
disabled based on block sizes so it'll retain its own flag and entry.

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg02592.html

Reported-by: Clément Chigot <chigot@adacore.com>
Fixes: 3b8022269c ("target/riscv: add riscv,isa to named features")
Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Tested-by: Clément Chigot <chigot@adacore.com>
Message-ID: <20240312203214.350980-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     |  8 +++++---
 target/riscv/cpu.c         | 40 +++++++++-----------------------------
 target/riscv/tcg/tcg-cpu.c | 14 ++++++++++---
 3 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2040b90da0..cb750154bd 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -130,10 +130,12 @@ struct RISCVCPUConfig {
     bool ext_zic64b;
 
     /*
-     * Always 'true' boolean for named features
-     * TCG always implement/can't be disabled.
+     * Always 'true' booleans for named features
+     * TCG always implement/can't be user disabled,
+     * based on spec version.
      */
-    bool ext_always_enabled;
+    bool has_priv_1_12;
+    bool has_priv_1_11;
 
     /* Vendor-specific custom extensions */
     bool ext_xtheadba;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c160b9216b..36e3e5fdaf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -102,10 +102,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
-    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, ext_always_enabled),
-    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, ext_always_enabled),
-    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_always_enabled),
-    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
@@ -114,7 +114,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
-    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
     ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
@@ -179,12 +179,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
-    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
-    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
-    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, ext_always_enabled),
-    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
@@ -1575,11 +1575,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-#define ALWAYS_ENABLED_FEATURE(_name) \
-    {.name = _name, \
-     .offset = CPU_CFG_OFFSET(ext_always_enabled), \
-     .enabled = true}
-
 /*
  * 'Named features' is the name we give to extensions that we
  * don't want to expose to users. They are either immutable
@@ -1590,23 +1585,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
 
-    /*
-     * cache-related extensions that are always enabled
-     * in TCG since QEMU RISC-V does not have a cache
-     * model.
-     */
-    ALWAYS_ENABLED_FEATURE("za64rs"),
-    ALWAYS_ENABLED_FEATURE("ziccif"),
-    ALWAYS_ENABLED_FEATURE("ziccrse"),
-    ALWAYS_ENABLED_FEATURE("ziccamoa"),
-    ALWAYS_ENABLED_FEATURE("zicclsm"),
-    ALWAYS_ENABLED_FEATURE("ssccptr"),
-
-    /* Other named features that TCG always implements */
-    ALWAYS_ENABLED_FEATURE("sstvecd"),
-    ALWAYS_ENABLED_FEATURE("sstvala"),
-    ALWAYS_ENABLED_FEATURE("sscounterenw"),
-
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ab6db817db..63192ef54f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -315,9 +315,19 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 
 static void riscv_cpu_update_named_features(RISCVCPU *cpu)
 {
+    if (cpu->env.priv_ver >= PRIV_VERSION_1_11_0) {
+        cpu->cfg.has_priv_1_11 = true;
+    }
+
+    if (cpu->env.priv_ver >= PRIV_VERSION_1_12_0) {
+        cpu->cfg.has_priv_1_12 = true;
+    }
+
+    /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-                          cpu->cfg.cboz_blocksize == 64;
+                          cpu->cfg.cboz_blocksize == 64 &&
+                          cpu->cfg.has_priv_1_12;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
@@ -1316,8 +1326,6 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     Object *obj = OBJECT(cpu);
 
-    cpu->cfg.ext_always_enabled = true;
-
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     riscv_cpu_add_user_properties(obj);
-- 
2.44.0


