Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39385CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdoe-0005TS-CN; Mon, 11 May 2026 23:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdod-0005T4-42
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoa-0000HH-VP
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6O121183940
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SBSxpQZ5xt5
 SBR+RWz3W5Q8uuq+L14KysGStifqAfPI=; b=GniYk2eZb0GW7yhPeFAez24lMhj
 hoHUvJhh1gfBMS0D/DLeigKt5GjahKUmlyuKzG07iOd63fiBZWMqVN+g1VzmzIXY
 x8670APf2j8u7G5jmZhtL6nQHlyNgf3NLjsORseqdWwKsPd3Tjm1thBW/efvAf0Z
 Z8MOIZH3pRxJUxLOmKWWnyz526FNwEx4tCsC20BBcL8zpw6IqlPPp0wqZjux03qn
 eMYEE+Deb/W6kEQsX1sTkdTsUUXBJwiHE1YtSBB/4xGZ+c2d1ahtTHOP8RigGNEo
 3fqyUlBLKAjKn6CL3lV6IjH4pTOx6/ooupnlYo7lMaFUhBz0Rzgfavzt92A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuy98wc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2f3eb8f3419so2854990eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556586; x=1779161386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBSxpQZ5xt5SBR+RWz3W5Q8uuq+L14KysGStifqAfPI=;
 b=bfSNmudcstY1VAvJ8HRHL9CCilliGc0OofxYzuoIMQwxhF53ykVQgAy0aWbamQbGUe
 0GPBSqWNM96DjVeZcmE3KI1wF/jObbn+wWejdy+mxBPblSG2H00qVk3pLuT9Zrk5+twa
 XZCLW9hAAj0IryDaHhLmMlOiWepYjDwPdX7Jv7w0+d9H0BAR6ARBIxmKiS7VeeaMIoWw
 LoUC5cwcrr9yfKUqVc0M8AWx2ZDA/abyZF9pytqjzK263JG0htft9GpgrJX6CLU8ialE
 Q+l7gGAFcfqo3eIFHLuIUvmGp1ITU1wQHwdxqIN7JQLHYpn59H39XHN37Xa2QHaGBAfY
 riqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556586; x=1779161386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SBSxpQZ5xt5SBR+RWz3W5Q8uuq+L14KysGStifqAfPI=;
 b=YSSq67nHb3P1bQCFgjio2WFTvxzh0ZvKT9BWa/edUMXWuLniA6zTiLkqONkeQ6wtoS
 DVxss8smSYUunt+FhJDrpxs/T7penmQXOne/YAjX/uxDcKFwQ8M8kpua7owcAIBPKhvn
 N4e+218ttv9xoF5jAa5Quo1OQdBD3D4zIzzgaqgrR5nmOp7mfSGEe9oQrfbTyrcDt11L
 suB1JQkID0aCnfFtQiI66la5FjyMlPffpxWAtkKiw/G8+oe+RDosfet2guD6azqGYri8
 9PMoG9i0e/wY/Ef9hNtTh6MlNfxl58koqCJ+FN5fOxAFw6nifHH3xJIklEw5mVLuGv4a
 ebJg==
X-Gm-Message-State: AOJu0YzFwucyGkQ7L0ieo5ZgxV6Q6VHGTDlLCucd4B90gMpTcR7ez/26
 KhHo7gBxMRGcciqbHFG5LSlGn3ZmMDUWs8f7RtmKtwcBYS3LJNj9b0hmS3dHwMxeCwYkf6PPC8E
 jiMsEthuPvBlYqh+Xn/t0aKBuxLRtYcQ3278gMNl97gdzSDQJ5TjvxFWqPnGlN/yMbA==
X-Gm-Gg: Acq92OHNnymXBNvCHZ8TvHvb0tuVik/ouBClPGF+bygKov4x8e3vLdr/6izTXxFU903
 z6oVt+ft456FAMAnvZD0jtBmhHY0DOdLAVMz/BXUV8IjwRNBaJYZJF73DIe2DpDF9wvZEs5CxN7
 epmRJGHo0FRbKgGbEZK+nRSH6le5idHHFppFTi8yeIoYU0Jg7hgoifgvZK3W/3Vk274JHry08zg
 fseLTHb3PN7sNA3jwn0F1zMBbdIr9yZJLc4zvsERyZIFB3Gi/Mg07Ph+9LDlkPkuBr4DvviNetc
 NPuISxJB+FEzza7MHutGr2pJ8RWPGbQ/J5oIJEZhcAm7j+QYg2u+I88lV9boAWmAZfNVum4Nva3
 FMdt/LRA38p1q5mPl7E4OwCVt6HpSZs4MkJ51eanQaAye36F3lMZhGDmoWnpo
X-Received: by 2002:a05:7300:7485:b0:2c0:e404:8b08 with SMTP id
 5a478bee46e88-2ffd79db766mr879672eec.29.1778556586270; 
 Mon, 11 May 2026 20:29:46 -0700 (PDT)
X-Received: by 2002:a05:7300:7485:b0:2c0:e404:8b08 with SMTP id
 5a478bee46e88-2ffd79db766mr879649eec.29.1778556585729; 
 Mon, 11 May 2026 20:29:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:29:45 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 06/14] target/riscv/cpu.c: remove
 riscv_cpu_enable_named_feat()
Date: Tue, 12 May 2026 00:29:18 -0300
Message-ID: <20260512032926.1978818-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Uw2hNWcpb5nie-KxDdRM7QCdY__6zWTK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfX0yN0rnfPJRDY
 E591C980yMhI0ka1QgfY5z2ayGfTLCZyU4tIXghaVfrOPih/l9lhGAJn/ln0HzVYPyGkaXs0z8O
 tQ1rCL34oy1JLotoLpS+mv/dYzKPS4rsqzJP7HIFIphDw+cRi+fRDdNQ4u2D1LpT0ttM6ndzK4i
 STtU6OI9m/S0qMoMjFS8aunK9yAvs21iXQ5kC0wMzeCozPdf+WSAU0I2b2H/xsYKhNQro/tDk75
 DIaKFC0eURV1ai7QpULJ+lzta7BE9DhVLnAaXhg15SFS5ekwFo+e49XtEPFBloDQ+vNjBknZF6y
 96qBjuLT2OKnt3xIG3rW6K7e1mT1qV4NcDFbUwXzSQa3w45vIuN08uI2d4bDTm68h6o/t3c3tDq
 sH2ODiz5kmffrMvDpYwniWsVklWgBs3FeZ6+ilwkR5xNAL6TaUS9loXngsSCf2PSl787ru3Ss1h
 TO5215Gr2iDXkwXZMGA==
X-Authority-Analysis: v=2.4 cv=UZ5hjqSN c=1 sm=1 tr=0 ts=6a029eab cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=r3QCmFo736opYiojf9UA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: Uw2hNWcpb5nie-KxDdRM7QCdY__6zWTK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120028
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
index 704105d3df..c3e354b0ae 100644
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
@@ -1327,10 +1291,6 @@ static void riscv_cpu_set_profile(RISCVCPU *cpu,
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


