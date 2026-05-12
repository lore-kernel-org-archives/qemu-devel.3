Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5BFCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdoo-0005XY-OQ; Mon, 11 May 2026 23:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdog-0005Tt-3x
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdod-0000Hl-5r
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6WX02994873
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bDoqeSC8Rcu
 fxhY1Bq68AgDwzbgFhLCEWspvtQlzEpA=; b=pnmDhBCy7yQC0pZKK3JeZKbdM2U
 ic97cSl2X1NCIb3vWkTRd0L5B+eEuueOt/1YWUeMLZFVf6C+eElFey9soUZAeTt4
 +QIEMJ0r5624xtmeXfyH1NjQ57qfoeVmTnnrr2QcQjtliy2GWJxPLSGb+N/sqmmk
 YVb4JWsxsOigAGcjNDkTmf9AnmcgSr1g11re67OcwZlvD/3r6xWNwsXPWL3vu+3+
 17dtp+JpXACaWv+jXZe2PlZhyglk9MprHUKOI0IfaaW3h8OrXciozTJ/m1czJqvS
 9e9VJp7mJMgNtybxCpFv1sL1cYO2YWeyvnKWGm/YTRb/Sl2V+4L9rilri4w==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0s8xt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:50 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13312cff948so3910675c88.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556589; x=1779161389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDoqeSC8RcufxhY1Bq68AgDwzbgFhLCEWspvtQlzEpA=;
 b=Ez150yYIUoAJTXbUXjWVMHcnsIB0HuAWiCwhPPOrMV/tHugt+GJsvZXK3Vrm2bPaoY
 evWjVaYhvgu3r2lL4d5IseFx6FND99AfaFQj+xohCgG8TcVdsC2wjooREadFQx2h1uGm
 e6Rve1gmwBQnhZYUzDCqauZXIQ3mzQue3pY7g2MQiikT9kMRLHyjKIrIT44Z50YgDCor
 xk5h+mRVhpUXOjpPhm6vNMxquYOh92XhNzf2v/YmRUFH/Y8QHkBCZBBycm3TUHZphFix
 EWAjzKkkmYgsg3gGI86qKbKszu8obCgdauG2Gh2ds5igTWW+s8XKRjf3nUi9YIfQ37zZ
 s9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556589; x=1779161389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bDoqeSC8RcufxhY1Bq68AgDwzbgFhLCEWspvtQlzEpA=;
 b=Cmq338w6rNhCfLfWMzL/R9QMsyb/+ihvrVQqWguCunkYWwXRhiw9JNFHcKBkiG9yKA
 bby1xSpcCWIyzPRNZCDLTRJXOgvsaAu75ygrQ9DpEMZzV0HBRx01N0m8Xfrp5aCOr+DJ
 5f1fGoMB14xMPA1gkI78XGkdP97xWd53b3G1Z8P2ylM6GaqjhErBID02pj1D1sNquZ5u
 ArfFmkPlunkZoNXOe1VAkv4YkhKdNhoVA5qIiYY/m3fhkKqzgRMch4Obzr6IHeM9xodl
 Zx+SyvWjKhJM6MPobW3CxGzjeqj+CxLqV4vAzRWZ8y8I2F7wHA4czIutxvvZpaY4908m
 Grcg==
X-Gm-Message-State: AOJu0Yxn1ExmK5qX9BjRtox4Z/JvswouYvB0I22HQOPeYy8hVGUBzAfK
 90ZqUJaMWCw2TuldpD9qZrrFSTWuLR9iYyFVwkp+ncCbIMWNX7So7i6i6+HoX8F5QCDErhRTLZW
 M+gFUMjjsjHP/Ccm4aFK3eoJVBLLOlFQ5dBAAg5E13BxM2BH+lb/8SUAo/0bwKI8BSg==
X-Gm-Gg: Acq92OEoszGM11Q0YAFLV6CsFgBzqJ3yHHRKp8y1WpDT1H+yNchxw63tC/wReTOfdWg
 lSiY4qKq5ADsr0H2qPWlK+eQq7Ihck7vgLiATcnzKb2dvnuJnnkX+OUCdZDFzJwUuh66/DLVGNt
 s6MdeP1ciuxq/rHFzngdV2Ft7HdvLroyr9S4uitI5p3f49pcBHhKsg0miwWU5Bs4TrDm56FI5ov
 9tel0JaTUl6sbZ1s+uRjgonhRy4cteu9cdzcTIDmMsQgtBnipY8/CoZ9B7Q5wJteHPp933w3gZg
 VGBbC6Xao+k6rCzULIXpICYFLUTiRvJ+De3Fn1bdDOZozHBlFRTywB7W4L0zhf6ijrMirqohVcb
 oSGgzXh+9gsOCCvd3BAqdWWDu9IvFvB2siylaSbiI1iE7Ymb1pVNFDV1iKkwd
X-Received: by 2002:a05:7022:2508:b0:127:33e0:ea44 with SMTP id
 a92af1059eb24-132a82ddb67mr6762676c88.29.1778556588761; 
 Mon, 11 May 2026 20:29:48 -0700 (PDT)
X-Received: by 2002:a05:7022:2508:b0:127:33e0:ea44 with SMTP id
 a92af1059eb24-132a82ddb67mr6762661c88.29.1778556588220; 
 Mon, 11 May 2026 20:29:48 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:29:47 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 07/14] target/riscv: remove riscv_cpu_named_features[]
Date: Tue, 12 May 2026 00:29:19 -0300
Message-ID: <20260512032926.1978818-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PN0/P/qC c=1 sm=1 tr=0 ts=6a029eae cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=tsLqsuv_eFHLPcQPQHYA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: kR1MU9mlXDOGtvqE64SKqgIJRYaVTKhm
X-Proofpoint-ORIG-GUID: kR1MU9mlXDOGtvqE64SKqgIJRYaVTKhm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfX3cXWEn+mv29P
 poxo2p9rH0y1b0+Q6xP18CAVyeJUbfe2fX5z6bdPdFSNM4ocuwZpq1P5g4c9M4IHcNBLtN7B2M+
 frhNtayCMRGv85YtI53FrnKD8XBrU1Q6ajDoTER2422K1Fgcy4NLn+2cZ89zZAnYGI8nKim3TDg
 K5wWMo0xuJ/fBRHNxvDMZYmGPc2taJK1wSGy8OZsj9nTXjraH4354EvPvWosOJZPVPiRfGTVaJF
 xIqCH0C3Lac6zzYcGmEKC0elM2uXpYRYskuujJKum+z01/VjOsDRUNs29XNnE0beaYIsC8xFhZa
 HiBpY6DAcKJ4/sdbdfrlLddp95s/c6CXg3VU641izAR3j4Hi5RWtduxbKzfgxNzlMnWUhrXUmMg
 S9kOPjHLTA96XM0OXrEUsPGCSPL1dQV3bz1hzMDyMYcf/e7luoiHQkKrrBpXTXNdFgq+fDU3L+H
 9t75DP+EBxAkveyBo/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120028
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

This array has no uses left.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c         | 26 --------------------------
 target/riscv/cpu.h         |  1 -
 target/riscv/tcg/tcg-cpu.c |  4 ++--
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 047f81b163..4940596ffa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1407,32 +1407,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     { },
 };
 
-/*
- * 'Named features' is the name we give to extensions that we
- * don't want to expose to users. They are either immutable
- * (always enabled/disable) or they'll vary depending on
- * the resulting CPU state.
- *
- * Some of them are always enabled depending on priv version
- * of the CPU and are declared directly in isa_edata_arr[].
- * The ones listed here have special checks during finalize()
- * time and require their own flags like regular extensions.
- * See riscv_cpu_update_named_features() for more info.
- */
-const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
-    MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
-    MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
-    MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
-
-    /*
-     * 'ziccrse' has its own flag because the KVM driver
-     * wants to enable/disable it on its own accord.
-     */
-    MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
-
-    { },
-};
-
 static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
                              Error **errp)
 {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 669735c5cd..46bc29d307 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -992,7 +992,6 @@ typedef struct RISCVCPUMultiExtConfig {
 extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
-extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
 
 typedef struct isa_ext_data {
     const char *name;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c3e354b0ae..8dea22bae5 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -454,7 +454,7 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
     }
 }
 
-static void riscv_cpu_update_named_features(RISCVCPU *cpu)
+static void riscv_cpu_update_cfg(RISCVCPU *cpu)
 {
     if (cpu->env.priv_ver >= PRIV_VERSION_1_11_0) {
         cpu->cfg.has_priv_1_11 = true;
@@ -1181,7 +1181,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    riscv_cpu_update_named_features(cpu);
+    riscv_cpu_update_cfg(cpu);
     riscv_cpu_validate_profiles(cpu);
 
     if (cpu->cfg.ext_smepmp && !cpu->cfg.pmp) {
-- 
2.43.0


