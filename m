Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D42CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaXG-000509-Gu; Thu, 28 May 2026 09:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSaXE-0004ze-S0
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:12:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSaXC-0005mV-3v
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:12:28 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vKZd1562573
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ifB1k1x0wpr
 yn8oaZyBowpzeD9cFHAJltEHKwd1R2xo=; b=gCQNsfqcHY6EkPRZGW4f9O0iAiD
 yEfsY3amv7PslsbNFaXZl5kM56paMXYWZ7p0bfKfgffjwXw7Dj1voV6fGxrEPFfP
 /hRXDzQRQxiQunKNg7Ke7UoAcVJSXHScyIdtBjnD7xFTwQwXn2xL1VVJ7NsVXSO/
 t0EkTlEzH22BdKNG+KxmFEWIsAPCe4URPED44WYNeQtj27sgRm7MJDZ++s8sKJ5S
 MKiDmDSPC5kEqpDN8sAYmgw059+m0BiMeaymYHK0hfT4/5lTxwwW+vxomorP94UR
 e2pZvjdBDixQBhzGvbeyGIvz4DSWxUbKOLKAnWj2bSkwkMRV9XJloNOjJkQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y2ttku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:12:22 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-63302aca17aso5159854137.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779973941; x=1780578741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifB1k1x0wpryn8oaZyBowpzeD9cFHAJltEHKwd1R2xo=;
 b=DW3KSRWVQceJ4jfyiqPDBaPk1nBUVpCDGV64rpFp8s5Seu6hZ1D/2ONJAn23m7QD8L
 LxCYU7/6MPGFTgCh/StuTs9AGskda7euKSzvhlBOq6UDWlL+xglVNmp6kQ4XKZvezi50
 cYu4qE437epq/1LkDnf598Ne/wqjKalR817E7oOP9xba5mlJRgXVLmrll0Ap2gRFkO/c
 fzKJ+F6Nn8r3loqNOjoFDPipn28wLmI9OF9dalXpp4KDrea96zgr3Ekbq9OvljUQXuhk
 cFxq+LKuxdLr1TPY4pTFKf4u8IRmFkECA4PO7jdjX5uXPIF4r2hicBjR4ENIeSTqtgjQ
 xXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779973941; x=1780578741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ifB1k1x0wpryn8oaZyBowpzeD9cFHAJltEHKwd1R2xo=;
 b=QKihsG7+zBcbxBFwNgaY8VIytNqA3LiYk19GqMNYdy7TIxG6ghV7zu3gG7dU1zGo8f
 xcDbziXs4zdpxGK/xt0ZLbSFYNrtCi4E+YRF9vPlI8rUZw7iAx9YaES3HFe6jW3HgGH5
 TxbkggpZuaoFrZGTnnO7iJ3lNM/iDS3H8AxbFWRvrMsxbqX/YVJnqUuvDFAMIfBCUqF8
 3d9DT+x0gKqj3vXNII4Nrf53zW3FlIEnwv6YQJ3IIPyVIdv1FoVf/BROSr2mzFZuQpSM
 8m5DnzLDa0Qg8lbVmMT4k26SAl3iD9l8xgeXWPoQ/+n0RW7SZiSJjxG3xUgqDKdozNi9
 DPmA==
X-Gm-Message-State: AOJu0Yzv6/3serQOVA1SjCfLpBrXUM6h5BFcdjL8NsMO95VMPOJyJJ1W
 gi9SMzUM77F6jiZ8KJqlqXSW0QHjjuYauLp/CH2NAv31erPwPOVb9X6MgwbCBtpQXaBwJyZ5M58
 ngx+hLzeMXMqrEhD4FcoTGxFiJrM8vMiZNo5FN8s2HHhTsW257/zpQNZdbUiECOq6zA==
X-Gm-Gg: Acq92OHPK5/lTsop8ZYIMdrUEQ9bT7dDLR4RLS5/y1EYH053Q+P6L59tLrRBG3Spgi9
 EKEUmnGpldLdJEl/R3RR0Sf2T08yH2An2/S9Z2NALQnXwUMZuuYg0ZqwmtOzsg8K4+qOMHLAHKN
 TAcUScqxV1pZjH0tSjIcmthvhx710+8xfEK5lezJtIglZO9CPBh0LfixVadu7u2BpUvWI9vgOH2
 gPNWGZNdi+fmVPXX0G8Fxa3/UJyNv0aitOQ7SCVFHDLaTy0exF6Q5eEPdJFn7ej7CjOaAd7pbUe
 OQ3zbxVZOmf8UW997/4EKZK1V5aBKv1/BK+0/Ni5Q6vYwVAyOMBRkEqWDMpUExCfhhLpjDpplqL
 MHsi+u32KBqDTbICBHtDaUdPQZnxxZYGEp7SI65iGrMIphpSMDXD0lO0C25eheQrb11yO+nw=
X-Received: by 2002:a05:6102:4bc4:b0:636:46ee:2f0b with SMTP id
 ada2fe7eead31-67c817f0a9fmr13464974137.12.1779973941245; 
 Thu, 28 May 2026 06:12:21 -0700 (PDT)
X-Received: by 2002:a05:6102:4bc4:b0:636:46ee:2f0b with SMTP id
 ada2fe7eead31-67c817f0a9fmr13464908137.12.1779973940717; 
 Thu, 28 May 2026 06:12:20 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.193.103])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cccf5428f0sm25000796d6.39.2026.05.28.06.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:12:20 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v3 1/1] target/riscv: deprecate 'debug' CPU property and Debug
 0.13
Date: Thu, 28 May 2026 10:12:14 -0300
Message-ID: <20260528131214.2251075-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528131214.2251075-1-daniel.barboza@oss.qualcomm.com>
References: <20260528131214.2251075-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VeXH+lp9 c=1 sm=1 tr=0 ts=6a183f36 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=e/1ukXmujkxnBaF7Br2KEw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=nr8c4-UOzr7lWkXvEvAA:9
 a=ODZdjJIeia2B_SHc_B0f:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEzNCBTYWx0ZWRfXyuaWyDNCFNIh
 OT7tBeUUlRauExQPqmNoOMN5xeIgrKYlq5HlUMx6IOYItOm7BGWVVyNWJ9cmFRCLJpxUpZKda2X
 KZuawQcFudOsqVzp9Ar6ASzjpCxfje0JB09VgpROkld7eLtpQBvw4WLLWVTOJDeWfERY2Nu3OuC
 SyFKgGI06GtlLSt00yjcs5RLvqiBA3CYP/Qy//64yePrXmgzMM9aO+B1ovvO01SrJmpXrBl3DPX
 p86Wa5GBAFdiKA/LC6vxvz3iLZNbCOSKbH8nGGB5arq7taeYrd5XCHuwKKXC7sUq6DguNRR3CVl
 V04KnxF/JPTYC2lK0vOGfpqWuax10TggxU85ElBgEIxLA44BxaGeD6ARD4T4msTPMzG+RzqZTec
 Vi7oKY7dSfFr4BQ2UzoEksDLQd5Wlh1zD669wlrPNeNJP2QxF1Bot7If2Q5WfqZ/2r7p3KQKQRy
 cPWqG0h/9imgX5Z/mmA==
X-Proofpoint-GUID: bwijrxcZpr6983bYgObjJgPs-kIdkPqR
X-Proofpoint-ORIG-GUID: bwijrxcZpr6983bYgObjJgPs-kIdkPqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280134
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
riscv,isa') the 'debug' flag has been used as an alias for 'sdtrig' that
is, for now, compliant with Debug 0.13 that was ratified 8 years go.

We're going to add more debug trigger extensions, e.g. 'sdext' [1].
Thing is that 'sdext' and all other extensions that will follow are now
adherent to Debug 1.0, ratified Dec 2022.  And so it happens that Debug
1.0 and 0.13 are not compatible with each other.  This makes support new
Debug 1.0 extensions like 'sdext' harder because we would need two
independent code bases for each.

We consider that most of the RVI ecosystem already moved on to Debug
1.0 and is now going towards the extended Debug 1.0 extensions, and we
should follow suit.  And the best way to do that is to leave Debug 0.13
behind, by deprecating its 'debug' flag and making it an alias for
'sdtrig' that will eventually move on to Debug 1.0.

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

Finally, deprecated.rst was updated to deprecate 'debug' and inform that
it will be now interpreted as an alias of 'sdtrig', which is now going
to be compliant with Debug 1.0.

[1] https://lore.kernel.org/qemu-devel/cover.1768622881.git.chao.liu.zevorn@gmail.com/

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 docs/about/deprecated.rst         | 19 ++++++++++++
 target/riscv/cpu.c                | 50 ++++++++++++++++++++++++++++---
 target/riscv/cpu_cfg_fields.h.inc |  2 +-
 target/riscv/csr.c                |  2 +-
 target/riscv/machine.c            | 24 +++++++--------
 target/riscv/tcg/tcg-cpu.c        |  2 +-
 6 files changed, 80 insertions(+), 19 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 97750f5edc..bc872e50ba 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -417,6 +417,25 @@ ABI is long-obsolete. We are therefore deprecating both OABI support
 and NWFPE emulation, and they will be removed in a future QEMU
 release.
 
+``debug=true|false`` on RISC-V CPUs (since 11.1)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+When first introduced this flag enabled/disabled support for the RISC-V
+Debug spec version 0.13.  Then, since QEMU 10.1, it became instead an
+alias to the ``sdtrig`` extension that still adheres to Debug 0.13.
+
+We're moving to the new ratified 1.0 Debug spec that will be maintained
+long term by RISC-V International, but this new ratified version is not
+backward compatible with 0.13.  This means that keeping both implementations
+is a maintainership hurdle that impacts the development of new Debug 1.0
+extensions like ``sdext``.  And most of the RISC-V ecosystem already
+moved on to Debug 1.0.
+
+For all these reasons, starting on 11.1, QEMU is moving away from Debug
+0.13 by deprecating the ``debug`` flag.  Setting it, from now on, will be
+be the same as setting ``sdtrig`` version 1.0.  Users that are still using
+Debug 0.13 will need to update their software to use Debug 1.0 or use QEMU
+11.0 and older.
 
 Backwards compatibility
 -----------------------
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 862834b480..54e8f78a4d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -226,7 +226,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
-    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
                                 has_priv_1_12),
     ISA_INTERNAL_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
@@ -807,7 +807,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
 
@@ -971,7 +971,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_realize(&cpu->env);
     }
 #endif
@@ -1150,6 +1150,14 @@ static void riscv_cpu_init(Object *obj)
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
@@ -2514,8 +2522,42 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
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
index 734fa079f2..44235bfaa1 100644
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
@@ -159,7 +160,6 @@ BOOL_FIELD(ext_xlrbr)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
-BOOL_FIELD(debug)
 BOOL_FIELD(misa_w)
 
 BOOL_FIELD(short_isa_string)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5514e0f455..17992715ff 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -796,7 +796,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 
 static RISCVException debug(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->debug) {
+    if (riscv_cpu_cfg(env)->ext_sdtrig) {
         return RISCV_EXCP_NONE;
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 6776e7bf5a..4ca5c9c8d7 100644
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
@@ -444,8 +444,8 @@ static const VMStateDescription vmstate_mseccfg = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
-    .version_id = 11,
-    .minimum_version_id = 11,
+    .version_id = 12,
+    .minimum_version_id = 12,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
@@ -511,7 +511,6 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_kvmtimer,
 #endif
         &vmstate_envcfg,
-        &vmstate_debug,
         &vmstate_smstateen,
         &vmstate_jvt,
         &vmstate_elp,
@@ -519,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_ctr,
         &vmstate_sstc,
         &vmstate_mseccfg,
+        &vmstate_sdtrig,
         NULL
     }
 };
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3e22e7ed53..a6dd864264 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -180,7 +180,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if (cpu->cfg.debug && !icount_enabled()) {
+    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
 #endif
-- 
2.43.0


