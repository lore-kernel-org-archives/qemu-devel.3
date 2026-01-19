Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAF7D29C50
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhtX3-0001A1-IQ; Mon, 19 Jan 2026 12:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vhtWz-00017L-9Y
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 12:59:13 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vhtWw-0001pf-Tx
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 12:59:12 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60JGs4gR1044553
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 17:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=hit1fjSE4iaEizKqwECalUYWfrOhQOa1kqZ
 iKUOV+ZY=; b=ZG5WPnVzogMMB7o6QUEXEMZRqub1pi44qPj50V0YvnUOawrni/q
 u33HNKLlM4eR4faki8JJCf9dz/hYrYsfX0ocBczEoWfAoNP+h0dAvjFQUYia3r+Q
 XynW0ioxbDTb+FQ3NAxSMpNj9qXfsNeUtKttpTH6RAy+509ol/teNcDjz458P0vi
 oZBuXvI8qw0Dq9Ji8eUYbo9LhHd12QJXFvSzwBdrVAnxaIokxneWN2nIWo3hm0yU
 suV0h1ucuZ9IK9IigHIRrTqaBNl/JfNQiutXiMOCF/HlwBg3KByo9WbRYk24KtAD
 p1v5XsaODG6paOxTL7OB3/KP6R8PaWMQxUQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bs79ek135-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 17:59:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a32bf024cso48370206d6.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 09:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768845546; x=1769450346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hit1fjSE4iaEizKqwECalUYWfrOhQOa1kqZiKUOV+ZY=;
 b=V32EcsTYtJIHbNnC+NLMD3q8HOygF7TNuzJciC6kLDmIowiC1thoZynICM+Fmlz72e
 U9KASxtQCSirJegxLCNn1l7XYMfocLX5nvHyYbraAfalTLZ1JUy8kMQFvSxGHpxgLzGW
 cfE5+wwCBsX8y8GtpO8UBnLJ8Lv95eo35iAlw7Wn8lxzf/bhBx5HVbSL7xyVYUcTDOxb
 6SBvib7gh01O6qBr5QXvzy0mvyLxseeYHuyJ+6chSCnaABB7IQ3q/y2wR49WLmE3GUas
 Jwz0mQlK/OhhCkH1hupIRWyiJn3zszGfcRj4tSwcYt9NQn+JpmGBgPQUCTKH6C17i+Zf
 F05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768845546; x=1769450346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hit1fjSE4iaEizKqwECalUYWfrOhQOa1kqZiKUOV+ZY=;
 b=RRKu+3FavpAWEBjvWQC6+ji/MI754fyigXvbn6xs10g1ISwssPyhawpRYS9+rf7NAN
 8DRaHH0IXXCDZIVvbLST6Ljxti0wNX06dj5cocmtEA5b77ElVuXKFMI+4pp+4Y83lx7N
 FFdbl1+epEY9yKCFEKznl1PvJuIYENVGHL3MwyX/rjWuZRvPX0U49JB7BIQPJ+5fH98y
 MewpnlPZORAFD2ogYwvvcWqy9zzSEaEy4gm1IyFLBK3DtyLbGMntFfLad3NXq6IzfDUv
 7/la9M5Jr0kQaVYY/ejEFeGiK+gA/igyeVNhwpU3vNplqVt/XOM2bHtvrBXHthXRRXT7
 SNLg==
X-Gm-Message-State: AOJu0Yy+w1yeRJlYNscXXArolewXgPYxmQC1N2Tz7BeiPfqWhqdksjrd
 9g4cAmYXWUSsPCdCnpId68gExcoZeRso2qL2KD5q1oPoE9nb02YqLn/k5c0WF6cPiDqLG8bA4al
 vDsZn07l5sFdyQVH9IWH0Kp+igNpVY+FHkD7qaYZY/1VKr2XC2d3qgUV84FrFcN/dRw==
X-Gm-Gg: AZuq6aJzLiA6XlwOi7DypLbdLOmYBasZ4hlCXWIWoMrUMIB+S7OptqUvoDQd2mlnC8I
 pbDu/LV9XSdxBtnsxjf25xPfC+y9wcseyv3nsfzIqU5Br2sFT8i2AmHdmTCJPhsL1MWPXdHOHxF
 c+RMEBGzlMTwtwPNJP+aJhrZaa6P9YAdXqjZAvPpESKquBB67ulwLkD+iG+HHNPWvwsvOayOBMZ
 ik4AfWcyRIhTAnhy3bJ/UzUZF77dd5cteUupkAV/1Rl4l0+EbUv34gKSp25aKAg08BUTWekZEJl
 HYBX0tM8iEsIMEmCKSBgVhAH0GVQDQvl2Mq2vFXNUj5eT/1pcXySslya4GRxb0sghQgz70PGBwf
 /zalqv7Dch/gWVmvH+BEPzffz3/BKO+5N/3MUY7JGbHP68KM=
X-Received: by 2002:a05:6214:d6c:b0:892:6681:a92b with SMTP id
 6a1803df08f44-8942dd8becdmr143724956d6.49.1768845545850; 
 Mon, 19 Jan 2026 09:59:05 -0800 (PST)
X-Received: by 2002:a05:6214:d6c:b0:892:6681:a92b with SMTP id
 6a1803df08f44-8942dd8becdmr143724696d6.49.1768845545315; 
 Mon, 19 Jan 2026 09:59:05 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.122.35])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8942e6ca6e0sm83586506d6.42.2026.01.19.09.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 09:59:04 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] target/riscv: deprecate 'debug' CPU property
Date: Mon, 19 Jan 2026 14:59:00 -0300
Message-ID: <20260119175900.249835-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE1MCBTYWx0ZWRfX8tyoTuXhuGR4
 IrlgfT1UUbMhIWHQo+tMDBkhacPkKsMRH1udY6AhY4pURIQNKwVjgrWqAN/aObO3EBR8Yb4kWnQ
 TjrmOoirmTJQbW98A+6k8Zy0DLSEt1AoBkYVsRAc8+Rjqqre1u6qRR75k2hNzZmTiAFb+75Sd1G
 GIkdX4XMk0v6hvt79o8FUykTsTwF/jkEQrP8aE1s9aCzMVGeLRd4bQbKieLcPA3NxdulIGTpK1U
 Ag8FYqKYFzxrYASgiKhVUpY281AqJzxJWzIHSSIYjvv9epp+e+p8/HAygo7UBa57J7bps1jrvYL
 h19qvlBig7hi4RwKfRoYZQM3K05NP1kGSmfO07KppU9B8M7ah7EiD1HcfrnVpO9x3K0Fo4tF019
 MG5m0lsCe2JgPTBbYWLVFhTbDzwGqyz9Lns8n4I6Kep55DcoFC2XRECEITpGko8cZbtsg+BnLy/
 YgZAXLHZSLDEtkwN9lg==
X-Authority-Analysis: v=2.4 cv=NY3rFmD4 c=1 sm=1 tr=0 ts=696e70eb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=DAX9FfZ9XxEyxcLR5JSMEA==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Db-wHElssVap-trf3igA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: DjKt9w9lRy5kcRNjzxWK3dE23XS9C98k
X-Proofpoint-GUID: DjKt9w9lRy5kcRNjzxWK3dE23XS9C98k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190150
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Starting on commit f31ba686a9 ("target/riscv/cpu.c: add 'sdtrig' in
riscv,isa') the 'debug' flag has been used as an alias for 'sdtrig'.

We're going to add more debug trigger extensions, e.g. 'sdext' [1].  And
all of a sudden the existence of this flag is now weird. Do we keep it
as a 'sdtrig' only or do we add 'sdext'?

The solution proposed here is to deprecate it. The flag was introduced a
long time ago as a way to encapsulate support for all debug related
CSRs.  Today we have specific debug trigger extensions and there's no
more use for a generic 'debug' flag. Users should be encouraged to
enable/disable extensions directly instead of using "made-up" flags that
exists only in a QEMU context.

The following changes are made:

- 'ext_sdtrig' flag was added in cpu->cfg. 'debug' flag was removed from
  cpu->cfg;
- All occurrences of cpu->cfg.debug were replaced to 'ext_sdtrig';
- Two explicit getters and setters for the 'debug' property were added.
  The property will simply get/set ext_sdtrig;
- vmstate_debug was renamed to vmstate_sdtrig. We're aware that this
  will impact migration between QEMU 10.2 to newer versions, but we're
  still in a point where the migration break cost isn't big enough to
  justify adding migration compatibility scaffolding.

Finally, deprecated.rst was updated to deprecate 'debug' and encourage
users to use 'ext_sdtrig' instead.

[1] https://lore.kernel.org/qemu-devel/cover.1768622881.git.chao.liu.zevorn@gmail.com/

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 docs/about/deprecated.rst         |  7 +++++
 target/riscv/cpu.c                | 51 ++++++++++++++++++++++++++++---
 target/riscv/cpu_cfg_fields.h.inc |  2 +-
 target/riscv/csr.c                |  2 +-
 target/riscv/machine.c            | 24 +++++++--------
 target/riscv/tcg/tcg-cpu.c        |  2 +-
 6 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7abb3dab59..44a6e53044 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -507,6 +507,13 @@ It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
 only with ``-cpu max`` (which does not guarantee migration compatibility
 across versions).
 
+``debug=true|false`` on RISC-V CPUs (since 11.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This option, since QEMU 10.1, has been a simple alias to the ``sdtrig``
+extension. Users are advised to enable/disable ``sdtrig`` directly instead
+of using ``debug``.
+
 Backwards compatibility
 -----------------------
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fa7079d86e..0ba98a62e4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -209,7 +209,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
-    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -781,7 +781,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
 
@@ -944,7 +944,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_realize(&cpu->env);
     }
 #endif
@@ -1123,6 +1123,14 @@ static void riscv_cpu_init(Object *obj)
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
+    /*
+     * 'debug' started being deprecated in 11.0, been just a proxy
+     * to set ext_sdtrig ever since. It has been enabled by default
+     * for a long time though, so we're stuck with setting set 'strig'
+     * by default too. At least for now ...
+     */
+    cpu->cfg.ext_sdtrig = true;
+
     if (mcc->def->profile) {
         mcc->def->profile->enabled = true;
     }
@@ -1237,6 +1245,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
     MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
     MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
+    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, true),
     MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
     MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
@@ -2639,8 +2648,42 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     NULL
 };
 
+/*
+ * DEPRECATED_11.0: just a proxy for ext_sdtrig.
+ */
+static void prop_debug_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    bool value = RISCV_CPU(obj)->cfg.ext_sdtrig;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+/*
+ * DEPRECATED_11.0: just a proxy for ext_sdtrig.
+ */
+static void prop_debug_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool value;
+
+    visit_type_bool(v, name, &value, errp);
+    cpu->cfg.ext_sdtrig = value;
+}
+
+/*
+ * DEPRECATED_11.0: just a proxy for ext_sdtrig.
+ */
+static const PropertyInfo prop_debug = {
+    .type = "bool",
+    .description = "DEPRECATED: use 'sdtrig' instead.",
+    .get = prop_debug_get,
+    .set = prop_debug_set,
+};
+
 static const Property riscv_cpu_properties[] = {
-    DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
+    {.name = "debug", .info = &prop_debug},
 
     {.name = "pmu-mask", .info = &prop_pmu_mask},
     {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 70ec650abf..492fdd1553 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
 BOOL_FIELD(ext_zimop)
 BOOL_FIELD(ext_zcmop)
 BOOL_FIELD(ext_ztso)
+BOOL_FIELD(ext_sdtrig)
 BOOL_FIELD(ext_smstateen)
 BOOL_FIELD(ext_sstc)
 BOOL_FIELD(ext_smcdeleg)
@@ -156,7 +157,6 @@ BOOL_FIELD(ext_xmipslsp)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
-BOOL_FIELD(debug)
 BOOL_FIELD(misa_w)
 
 BOOL_FIELD(short_isa_string)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 05c7ec8352..870fad87ac 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -777,7 +777,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 
 static RISCVException debug(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->debug) {
+    if (riscv_cpu_cfg(env)->ext_sdtrig) {
         return RISCV_EXCP_NONE;
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 09c032a879..62c51c8033 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -218,14 +218,14 @@ static const VMStateDescription vmstate_kvmtimer = {
 };
 #endif
 
-static bool debug_needed(void *opaque)
+static bool sdtrig_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.debug;
+    return cpu->cfg.ext_sdtrig;
 }
 
-static int debug_post_load(void *opaque, int version_id)
+static int sdtrig_post_load(void *opaque, int version_id)
 {
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
@@ -237,12 +237,12 @@ static int debug_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static const VMStateDescription vmstate_debug = {
-    .name = "cpu/debug",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .needed = debug_needed,
-    .post_load = debug_post_load,
+static const VMStateDescription vmstate_sdtrig = {
+    .name = "cpu/sdtrig",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdtrig_needed,
+    .post_load = sdtrig_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
         VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
@@ -425,8 +425,8 @@ static const VMStateDescription vmstate_sstc = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
-    .version_id = 11,
-    .minimum_version_id = 11,
+    .version_id = 12,
+    .minimum_version_id = 12,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
@@ -492,13 +492,13 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_kvmtimer,
 #endif
         &vmstate_envcfg,
-        &vmstate_debug,
         &vmstate_smstateen,
         &vmstate_jvt,
         &vmstate_elp,
         &vmstate_ssp,
         &vmstate_ctr,
         &vmstate_sstc,
+        &vmstate_sdtrig,
         NULL
     }
 };
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 988b2d905f..72113884f3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -177,7 +177,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if (cpu->cfg.debug && !icount_enabled()) {
+    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
 #endif
-- 
2.43.0


