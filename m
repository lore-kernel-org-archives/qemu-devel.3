Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5602CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQhX-00016r-1b; Mon, 11 May 2026 09:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhW-000167-0z
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhS-0007cR-NJ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:37 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BC4Ko0108067
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=00NM5BSAyXc
 wWNKj9x8O28mkvuK5Gisw/h2pOlcEbn8=; b=X854IP0QD/kZcnUdEqH1ynS62TC
 HNUqbryN4/ZZc/Iq/o1YJCoTZUzsA7AlTuI9wihjXt6Bdd5S6sjTbGGaGs1A+//k
 G2V6Fg/wXZYTC6acTqrDIfYAlGtbRp7yfXTtfgPs0yKp3+MeT9w3C6HG9LJYzZPf
 oncm2gFSMc0lm3BXjlq9PJ4v4id6qKpnyqE5/9MS5+HHriw1Iv71tPN4Oa1TL7lU
 E63M+DGQodU+XfTuVt+PlpLsy+yJIjcckCXKPab9FcJvNbLnv76t2vJ7fzBJVbRb
 YolOJ++HspyBqUC/ZDfBNdb2eTI2vMu5fb9QlRQ0yQkG6jPUmm+J4J2em3w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3esyr9vq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b513f57611so110205966d6.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506169; x=1779110969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00NM5BSAyXcwWNKj9x8O28mkvuK5Gisw/h2pOlcEbn8=;
 b=ZHgOR88SqVDl3yWQ7ZPe32YRBrJyFeWLTPwS4TPJx1WGQGP2cvYMhLlDVRmWXncozQ
 hNU8DuQfWD2+QmuM5dGG2V013uVe2gy7fy0eC9WJy5JoS+njRcK8/Av08L9EjYErLrpJ
 DWH0rctTCpbxFwv2VoWdLY5d7Zx/gKRrvVPxaNdVockgwZ5B1H/Ox5l0LvOa154wviU4
 omK/icRDygpEs0UX1bJW+Lhrp37VnuTXOLQP0YGPOFYJ5h0AL5pPgug9YXGUEC5ImbcB
 sjiEIfGsWK9r7wfxC0solUHSFpAudrKteA2cL5iXaXqL898iI1dfz5vkCmhQd7LijTTu
 gKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506169; x=1779110969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=00NM5BSAyXcwWNKj9x8O28mkvuK5Gisw/h2pOlcEbn8=;
 b=NuTa8sTIE13hIXSjiqdYlaT/Lm440xiUlk4DFpewkGTeVA5Q9jnJ+argmEQjMQkXJU
 qQgW+t8t2vHYGYUuVC+w+jRe9CuF2SUxq8FJwofWJO5XsppQ27t7tG5S4eYTedGqh1vg
 dv0wYj4Xx0Fw5DbMck1q5LbkQIMFM7Zd8nL9gXJxI0KjjtyGsIPgACE+rlPwZ4HT6BZE
 Q71FHa6n0KWhoUIb5CL5/KEdMB0yASZ9RJmYT9h2jWNQjasbQAgRdvP3dbygxYR72tHA
 qX/n2ztXVfk4ISVSFZIm0u2GK4/z7ln0X6j7FDS8tClLPSrCuu94gJAOXTZ6DM2lKMhg
 F4CA==
X-Gm-Message-State: AOJu0YxEBpCVSHOldT0KsPBYTm3JFNRZHYrG6Taj44jpUarzlSG+nUoo
 i+piiraWwt+EWpr2IJ0swt3sycGF9cS+5yKWMGU8VnaQ/eN5HiAjpmtoLLFBm6+7iJVAd/1R7Ku
 b+Q+yWlw+rrQmxDQ9/X+hN+Q8/CCIhwFnioReuez3+bNhVoOFSbwZ/OX3KzAq6sUPgQ==
X-Gm-Gg: Acq92OFddb6CRk0+KsXfwrxARG53pJeRH7AZ5TyZQ5noZFnyFO5c6sLyFL6uET57eNA
 ArDhnov8YGqQLFaUlle0mpA9+xufFdzQgQD87xo3ntcONdBYId8I5AySTTCBTgQNuM3DwRL8eua
 Hlsh6Q5JwPMMP63a4pxRdsfdKFPdx2i0m2kTtc42cIP3DaLM0AdCiTFrFDwf0Qug/oikVtCFzAW
 auUhn+pqg5qq9cLCODv7XO6U9Y5SFrq1nkWw1fQH2GiFQH7NOBIpbEaqUnhFkZyGct01zp0x68P
 3WexNgmNy9SRAkNjvWZx0z8ThXaC9mSxmRivuAvuu/zQpf6pjsPO2JC1/zqeXwjBBf0VXQMLhoS
 O7oyo/NUFw4vjBXX64mOUVWOSplxjQEG9z73L9yZXznyX00omUsG5IICnMJ0JdCfYhWsjaps=
X-Received: by 2002:a05:6214:238c:b0:8ac:a4e1:3f87 with SMTP id
 6a1803df08f44-8bc46bc1077mr370510476d6.42.1778506168468; 
 Mon, 11 May 2026 06:29:28 -0700 (PDT)
X-Received: by 2002:a05:6214:238c:b0:8ac:a4e1:3f87 with SMTP id
 6a1803df08f44-8bc46bc1077mr370509876d6.42.1778506167912; 
 Mon, 11 May 2026 06:29:27 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:27 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 06/13] target/riscv/cpu.c: remove riscv_cpu_enable_named_feat()
Date: Mon, 11 May 2026 10:29:03 -0300
Message-ID: <20260511132910.1738069-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfX1PIalEKUJ0AT
 exMLeZh0xh0QXuqptu7jShNmxy+g7DokXMA4LFqVsU40Brp+eHTD0fasOgL3QKopkzSP2XpriIu
 Bf5ZzrgkuyE5MK9p++Uq28QeEMMCrlryfKXclr3UI2VdC1B//YXySMX3PE4efsgduZ4gdr0VaDW
 bQIMd6MxDTlkxBIE7jp2Leat/7kWe6Vwk5lg/MFe3H6LHd6crehxdKkzJxxI2Ro+fbNcQnatXA8
 kS8Ydq2TYkETpyvQOfDVZq5rygXtRCXYqedt1Jbs0E3vqZFSoM1vv4XKtU8OlJe/RG4oLaw+KmZ
 hpvBU5J4j4GzcB1Wnb2v4mml1LdP9sTD+2ToF3qEo94S4YaWdKtycuEMf218bbC74VQDO4zz72J
 QIZCshjtQw53f+T7EQGL2bgI+/umIXnMvpc8EenbmETru598tqU0NCbZuqUfyGIdbe0mBTsI08M
 QCXim8btWQLJdhnEN6w==
X-Authority-Analysis: v=2.4 cv=AI/DAN7A c=1 sm=1 tr=0 ts=6a01d9b9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=r3QCmFo736opYiojf9UA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 8GAywYh3Y8CK1ermqNGGdQHM0y4BXaPj
X-Proofpoint-ORIG-GUID: 8GAywYh3Y8CK1ermqNGGdQHM0y4BXaPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110149
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Deprecate riscv_cpu_enable_named_feat() by creating implied rules for
'sha' and 'ssstateen'.  'zic64' is always true given that our default
block size is set to 64.

With this change we homogeneize extension handling when enabling
profiles.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c         | 25 ++++++++++++++++++++++--
 target/riscv/tcg/tcg-cpu.c | 40 --------------------------------------
 2 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 42555cb28f..047f81b163 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2595,6 +2595,17 @@ static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule SHA_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_sha),
+    .implied_misa_exts = RVH,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_smstateen),
+        CPU_CFG_OFFSET(ext_ssstateen),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule SSCFG_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_ssccfg),
     .implied_multi_exts = {
@@ -2643,6 +2654,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule SSSTATEEN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_ssstateen),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_smstateen),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvfbfa),
     .implied_multi_exts = {
@@ -2669,8 +2689,9 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
-    &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
+    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
+    &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
+    &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
     NULL
 };
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index dd058eb3d4..f4a6838626 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -322,42 +322,6 @@ static const char *cpu_cfg_ext_get_name(uint32_t ext_offset)
     g_assert_not_reached();
 }
 
-static bool cpu_cfg_offset_is_named_feat(uint32_t ext_offset)
-{
-    const RISCVCPUMultiExtConfig *feat;
-
-    for (feat = riscv_cpu_named_features; feat->name != NULL; feat++) {
-        if (feat->offset == ext_offset) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
-{
-     /*
-      * All other named features are already enabled
-      * in riscv_tcg_cpu_instance_init().
-      */
-    switch (feat_offset) {
-    case CPU_CFG_OFFSET(ext_zic64b):
-        cpu->cfg.cbom_blocksize = 64;
-        cpu->cfg.cbop_blocksize = 64;
-        cpu->cfg.cboz_blocksize = 64;
-        break;
-    case CPU_CFG_OFFSET(ext_sha):
-        if (!cpu_misa_ext_is_user_set(RVH)) {
-            riscv_cpu_write_misa_bit(cpu, RVH, true);
-        }
-        /* fallthrough */
-    case CPU_CFG_OFFSET(ext_ssstateen):
-        cpu->cfg.ext_smstateen = true;
-        break;
-    }
-}
-
 static void cpu_bump_multi_ext_priv_ver(CPURISCVState *env,
                                         uint32_t ext_offset)
 {
@@ -1273,10 +1237,6 @@ static void riscv_cpu_set_profile(RISCVCPU *cpu,
         ext_offset = profile->ext_offsets[i];
 
         if (profile->enabled) {
-            if (cpu_cfg_offset_is_named_feat(ext_offset)) {
-                riscv_cpu_enable_named_feat(cpu, ext_offset);
-            }
-
             cpu_bump_multi_ext_priv_ver(&cpu->env, ext_offset);
         }
 
-- 
2.43.0


