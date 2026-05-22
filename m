Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF4DCD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDQA-0005EA-Kq; Thu, 21 May 2026 20:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDO6-0002af-Uz
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDO3-0004JU-0F
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:14 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bccb978bd9so46069605ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408306; x=1780013106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uc2gxz3IuB97uJGUW2Y1feZ1aLzZkDjNjQtPqhO6gNo=;
 b=rRYMZG+HYh9ALaOSE9vb6BSFKKa7YQJu7ugPs7QKuvQjhOKRSWc2l7UVfg7Oj4rn9D
 5zutDOyP7ASt0ndt46ROHPnt11DNVfgZ/ubVtQ89nVc6ndtKVcnqMOi8XKb8xswcvBkj
 Y+ttBdqk3IkOyjTRN/6hJvO4HSqrxYrq1bpfewsKR8r+zHzWjNxAS5rk8mjbU4nTqwpR
 SZ3R9Ijqx6iNDi25Ldg2FjBeH+pHqILsRI/1lDOSlyangFYRrsz/A+e6d2Tp3jqsMNVf
 ldH2iafjXarE47ctYL9SwXhoAlGUFChfslPnh/drnNI5tAKh8pPFa5ZDNEW4jAOgsYgZ
 QgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408306; x=1780013106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uc2gxz3IuB97uJGUW2Y1feZ1aLzZkDjNjQtPqhO6gNo=;
 b=bP2xiljGz7I0xGoBI42vWlh84Gn3sl4dZ256deKXMnVKCrzn/QfmdqxTCuzCfbdDJQ
 HNpFhG2bVA9/7W+xNuYk3dyJ/9yl5hQQrBlK6BBtmUbZW3lP7m69lym7P/fpuxK7TEA+
 8ri14rqlWq04IK65WS02EO6W79QTm2cTNnOyoNiLrTAKbC5gX+heCgkNgLX8COKDztQS
 aQpF3cF17MM/DqHPQihplHISQuoonkNhauDS90bIobqfyWRseOWIZMYUpFG3s3ehH5VG
 BS1fr8t5/1zYCtFV1X2n+hB+mrwlb3MLYnMJ+COrN6xer2lv9FLftgI4GPsMQxhcXsFC
 iolg==
X-Gm-Message-State: AOJu0YzgU++11PX3HhrazT7eackdoOBjU9E9peaCklD0A9zGPlhd8e78
 kXV9yQxasq6Zmb3EQfsS/fgH9G+qc/EvgePdvR+Lma+apJk3fb1/H/AyZnf9XHK/
X-Gm-Gg: Acq92OGaB1hR/ohviNXcLbnG3znFcBOhpDJ9YZE0kZ+9/+OOrbqnwtVC75lYuhnrj7r
 O6DveItde1Fk5Ey0PMV6NSQpXMyxc3N6WnhIIGF1fn7pRq9vjSOfvM1fykT8NZIYyeR1bYHPxyH
 GUZ5PwLlwXW/+FlCCTaWDOW7yUNXRl1lqxo9l8sdBYHsCRy45s1stE58oP9lxkdooGB+Xi+HYd0
 XeQBZPCxVViXLSrqbzV9yHljd4dLHHnmaDkxfTfJHqzm3CN09EhjEoT7qc422/v5yamP8OiNQe6
 GDJgGRwScoSJ2PGRamHAeGUQRCoGbD16YQAi+zN+CzhZS9RsM2xeCYM9U+XQXDwKQ3seN5YE2CM
 Gd7UA11qGnZE+JAGkZnemoIF5ZvOJ7dYhhWsvUOkCVL+6ocXwLBMiFJ+wFZ8rQgqh4T4h+WSjLL
 7rTPRE1ABaJq4xKLXWNOwh7ysobnmLM5eOS8seylSG6w==
X-Received: by 2002:a17:902:ccca:b0:2ba:4086:ef93 with SMTP id
 d9443c01a7336-2bea2221e87mr45514665ad.10.1779408306301; 
 Thu, 21 May 2026 17:05:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/48] target/riscv: make riscv-qmp-cmds use isa_data_arr[]
Date: Fri, 22 May 2026 10:03:04 +1000
Message-ID: <20260522000324.23255-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We want to reduce the usage of the riscv_cpu_* arrays in
target/riscv/cpu.c, centering everything in isa_edata_arr[] instead, to
reduce data duplication and make our lives a bit easier when adding new
extensions.

To do that we'll have to make isa_edata_arr[] do what the other arrays
are currently doing, not breaking existing semantics in the process.
The riscv_cpu_* arrays have a few exclusive uses:

- set default extensions for rv32 and rv64;
- create user CPU properties;
- misc uses around tcg-cpu.c and kvm-cpu.c.

We'll slowly make isa_edata_arr[] supersede these arrays.  Start by
adding a new 'prop_name' field in RISCVIsaExtData.  This field is needed
because not all extensions have properties and not all properties match
the riscv,isa string name.

Create two additional macros and reclassify existing isa_edata_arr[]
entries as follows:

- ISA_EXT_DATA_ENTRY creates an entry where prop_name == riscv,isa.
  Most of our regular extensions fall into this category;
- ISA_EXPERIMENTAL_EXT_DATA_ENTRY: same as above but add a "x-" to the
  prop name, i.e. prop_name == "x-" + riscv,isa;
- ISA_INTERNAL_EXT_DATA_ENTRY: used to declared internal extensions.  By
  'internal' we mean users/management can't set them on or off.

With these new macros we can start our simplification by changing
riscv-qmp-cmds to use isa_edata_arr[].  We'll just scroll through it
once and gather what we need.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-4-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            |  1 +
 target/riscv/cpu.c            | 60 +++++++++++++++++++++++------------
 target/riscv/riscv-qmp-cmds.c | 30 ++++--------------
 3 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 45f895c1fd..f93d80ef22 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -996,6 +996,7 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
 
 typedef struct isa_ext_data {
     const char *name;
+    const char *prop_name;
     int min_version;
     int ext_enable_offset;
 } RISCVIsaExtData;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0a56dc61bc..0f8ddeb42e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -97,8 +97,24 @@ static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
 #include "cpu_cfg_fields.h.inc"
 }
 
+/* Use this for regular user facing extensions */
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
-    {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
+    {#_name, #_name, _min_ver, CPU_CFG_OFFSET(_prop)}
+
+/*
+ * Same as above but for experimental extensions. We'll add a
+ * "x-" right after "_name" when creating the user property.
+ */
+#define ISA_EXPERIMENTAL_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
+    {#_name, "x-" #_name, _min_ver, CPU_CFG_OFFSET(_prop)}
+
+/*
+ * Internal extensions are extensions we will declare in the
+ * riscv,isa DT but they don't have an user property, i.e.
+ * users/management can't enable/disable them.
+ */
+#define ISA_INTERNAL_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
+    {#_name, NULL, _min_ver, CPU_CFG_OFFSET(_prop)}
 
 /*
  * Here are the ordering rules of extension naming defined by RISC-V
@@ -121,13 +137,13 @@ static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
  * instead.
  */
 const RISCVIsaExtData isa_edata_arr[] = {
-    ISA_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
+    ISA_INTERNAL_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
-    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_INTERNAL_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
@@ -141,7 +157,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
     ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
-    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
@@ -211,13 +227,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
-    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
-    ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
+                                has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
@@ -232,20 +249,21 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
-    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
-    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0,
+                                has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
     ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
-    ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
-    ISA_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
-    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
@@ -253,7 +271,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
-    ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
+    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xlrbr, PRIV_VERSION_1_13_0, ext_xlrbr),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 8a1856c50e..93e6b7fa68 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -90,27 +90,14 @@ static void riscv_obj_add_qdict_prop(Object *obj, QDict *qdict_out,
     }
 }
 
-static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out,
-                                         const RISCVCPUMultiExtConfig *arr)
+static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out)
 {
-    for (int i = 0; arr[i].name != NULL; i++) {
-        riscv_obj_add_qdict_prop(obj, qdict_out, arr[i].name);
-    }
-}
+    const RISCVIsaExtData *edata;
 
-static void riscv_obj_add_named_feats_qdict(Object *obj, QDict *qdict_out)
-{
-    const RISCVCPUMultiExtConfig *named_cfg;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    QObject *value;
-    bool flag_val;
-
-    for (int i = 0; riscv_cpu_named_features[i].name != NULL; i++) {
-        named_cfg = &riscv_cpu_named_features[i];
-        flag_val = isa_ext_is_enabled(cpu, named_cfg->offset);
-        value = QOBJECT(qbool_from_bool(flag_val));
-
-        qdict_put_obj(qdict_out, named_cfg->name, value);
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->prop_name) {
+            riscv_obj_add_qdict_prop(obj, qdict_out, edata->prop_name);
+        }
     }
 }
 
@@ -220,10 +207,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     qdict_out = qdict_new();
 
-    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_extensions);
-    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_experimental_exts);
-    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_vendor_exts);
-    riscv_obj_add_named_feats_qdict(obj, qdict_out);
+    riscv_obj_add_multiext_props(obj, qdict_out);
     riscv_obj_add_profiles_qdict(obj, qdict_out);
 
     /* Add our CPU boolean options too */
-- 
2.53.0


