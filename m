Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C17606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LxngsvnU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LKOBij2X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX02H-0007Ri-Jn; Fri, 27 Nov 2026 12:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xX02G-0007RI-Gf
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:47:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xX02E-0007EN-LC
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:47:00 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFp7QF925497
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=E7vmuXwUTgj3KpmeOq+wmP+y0Vr0HC+uTSw
 fpOp+cDQ=; b=LxngsvnU/bvYdiruNYRRRtlDh1NZw+SmoGbYjItu9SlcgODOlDk
 Zhn4stcHP1AGCcGuRrRBF/NkPOEwa2aU8WBW4Vs2N/oCBSHa9sHzkPwePrb0xmxU
 /Ldep+NtWkJ/fife6mzZZoF6KjC3OVW+rQjJav4oAoaPv6HGSsFwJBDhsY7+2ggC
 PlYzxtCIt4m+HBx1wMW1a88ehmRZjvzRuATVJdslJD4OExkI2rNMHs80P+Xq2HTe
 YgMRbAJ8+y2Udnd8watkMfmgQ74dXM7Qg1KYw3DeCokxNprZL61O5ensEx3edwXN
 u//0gFM5k7lgaXpT/OUtnZzf4pBj18KFJcA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49c1x0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:46:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3b45655b428so7457839a91.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795801616; x=1796406416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E7vmuXwUTgj3KpmeOq+wmP+y0Vr0HC+uTSwfpOp+cDQ=;
 b=LKOBij2XPl3dNMY//2SXDgqYKS23v7lXU1MR2QwcRToCs+mAWEIoSp+pzOt16p5WqH
 MFs78r49gKEDKMUM9ElF+BNvwLjno0APm6vWV4nXpV2ADtze/JgrSZhzlpU2evcb7459
 rtJ9pFW95SzZjyB2191XffmbIvWs4HlkE+hQCCC9aEvCXzsdu6oAYvEjnfQHMM6uAx5k
 jqF4Yz+NwNEoWzrqXuATWQ24FBcNlO7wgS6UEEtZPFKofvdkt0B7pLe9SMmdsFwnoFiU
 5GJyAS6nIyt8JYs3WbiKxm7sW/n0geceY2T8E+7v7+93RYZAN8K+NbazqDKYBEANYgUc
 yv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795801616; x=1796406416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E7vmuXwUTgj3KpmeOq+wmP+y0Vr0HC+uTSwfpOp+cDQ=;
 b=cfFyVwine/JPT2sXQqfbKpZZckZgxuSsEdLCL2Bim2fyvlfsmk5CYEBevFB1N9o3v3
 AjNj6E53V/R0uVLDcmgnWprMyvlZviEllog9IhYPbMCJq0hKYrSsBubYCSADwizhisAa
 jaFvhEPS7SE20KW3exS7TdYen/1o4PAXXqHcuT7tuhYOIQINhag5MfVc2Menvn2FHSRB
 QKUw4Ph5JQ6NEst67UvJ2WC+ExlAFFtsXj3Mw9nxn4vTDXdeLNdOwyqZ7jomJgBZePzm
 rZ3UU51gcVPTJ9Jc5ffABQ1yidu/BFcl1KRdEUtmkSphtmJW1P0N2/DJxpnZeY1MfkA1
 Falg==
X-Gm-Message-State: APuU4Z9TqLpSswyHTCrY+74JvHfXxVEd8H3mkA8K2ADsPgT2VnSyjHzU
 kqapA2B1IBwIGpk+iJ3Z5CzBKjM/GAnqnWzdQSBqCHREb9TfHDA29jHzqOymskJW7r+OmgwnJCL
 YZ6IaOokiUXeZD8RyUExqKz/4iV2vqobSK4bJwkItIr6Xrwz9JHqfM6TkS7YGXvHV0w==
X-Gm-Gg: AZFdTZdDzZhptpdsysSsai5vGKqxFZu0IyxSdVhT4RyGCn6mbFFLzCrAjGdVjcPGJJc
 a1Xx+eaXloqzbOXCxzvtL4zXJRxsPjeph5NAaMv9FhFfD0iCOlEo3THmKsUcknVS860Pnhv81KH
 IZouOmAG6qGeZ7dUsE+Y2H3xEQvbi49T6L1VGdA8vYkkJ7dFqa554fGT0X1jmHw2AjLXiPe0mKv
 cZOzmGHq05U5DTkTQsuy4h0ZZmRQVoCAaJojV+i+VdRkPCVzqk2aoDUCZ2Cf3piAoIxaNHeF6ZA
 XiPBvrOg+AcydRrK3j2yyqxMjpPUu4VSSng9YQxk5Xzlj+hvJN7eNlranU+/aAK5WWR6yYWFWWA
 l9peit+L4ctW+lwKBDiwmm2osRHi3Pbb/d3qVm+s8CgomZnZmPYkW56XwycPDTRcIvptNYrKSet
 I4TdDrTPCSHGgXfKdtnchvvjo6zVZ983UuRgbm
X-Received: by 2002:a17:90b:3d8d:b0:3b3:b704:118c with SMTP id
 98e67ed59e1d1-3b41cb4f321mr23879320a91.65.1795801615781; 
 Fri, 27 Nov 2026 09:46:55 -0800 (PST)
X-Received: by 2002:a17:90b:3d8d:b0:3b3:b704:118c with SMTP id
 98e67ed59e1d1-3b41cb4f321mr23879269a91.65.1795801615157; 
 Fri, 27 Nov 2026 09:46:55 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ffa98esm41856732a91.17.2026.11.27.09.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 09:46:54 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Frank Chang <frank.chang@sifive.com>,
 "Fea.Wang" <fea.wang@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, Jim Shu <jim.shu@sifive.com>,
 Max Chou <max.chou@sifive.com>, Jay Chang <jay.chang@sifive.com>,
 brian.cain@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Gary Zancanelli <gzancane@qti.qualcomm.com>,
 Gary Zancanelli <quic_gzancane@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] target/riscv: add SiFive S7-AD CPU profile
Date: Fri, 27 Nov 2026 10:46:40 -0700
Message-ID: <20261127174640.406897-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4YMf2JxgicpT2uxFu2RwPWBPhpYA_hlI
X-Proofpoint-ORIG-GUID: 4YMf2JxgicpT2uxFu2RwPWBPhpYA_hlI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3MCBTYWx0ZWRfX4VGGwuHZOhU8
 KwdCqxf4qlPCn9VA/m1QTyny9KkpSMjg0YqQsf0tKuwlFevdHhnkJwCQ/LPzYcEgGEq77wcn4lR
 H/4BD9zyQFHn245BoxO8yLyQZTEWZmo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3MCBTYWx0ZWRfX8w3a59TDsVZp
 kNWOPT3Q+vFrbOXrluRgx8Bec7/XH3W3cqC0wN8Rc8sc37oAjxvDjh75LaHH09clAP2bvJ2ga7s
 10lS5KIJDbLvo1zElLqShJIIp+l1xnu8oV0unixP+fhaTf0jGbWIFLxhDxFsEA09t3Zj9Nsiqoq
 9Gw6e5HY+UKxhzUSWR8/St1dk3tOAtz5LrS5lnGl5/hJfzU6LmhpV/gX20FPgwimCTN78Pfd3bZ
 WfpmkAtEWspMiyR3xcaojife/gue/vr24XcGCPvpVjqGaC881UsJ/RFENWYi/LdEz+5Ywd47Ex7
 /egFrU4RxrpfySqk27lN/x4w9CxIUudh+G4oSj4Fz3uvMaKR7O62FDvh68qZkpx7Yv553ECy5d+
 AHfxhE2i5cgikHFdcsukapwG46IcGYPTYm6Ge9h3A2TxBQCjg1lvFr+T6nfE5k/jTMLWhkUMdoT
 R2FfBixaLpXsnsDMULA==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b09c210 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Y5XJB6cuqWXhgpbSPVgA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gary Zancanelli <quic_gzancane@quicinc.com>

We are using this cpu internally at Qualcomm. After a conversation with
SiFive folks, we publish this in case it might interest upstream.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 61234842e3c..0aa38544094 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -49,6 +49,7 @@
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
 #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
+#define TYPE_RISCV_CPU_SIFIVE_S7_AD     RISCV_CPU_TYPE_NAME("sifive-s7-ad")
 #define TYPE_RISCV_CPU_SIFIVE_U         RISCV_CPU_TYPE_NAME("sifive-u")
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 15c27f4ce46..87b15692326 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3608,6 +3608,30 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV64
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_S7_AD, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVI | RVM | RVA | RVC | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_12_0,
+
+        .cfg.mmu = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true,
+        .cfg.pmp_regions = 8,
+        .cfg.ext_zihintpause = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zkt = true,
+        .cfg.ext_sscofpmf = true,
+        .cfg.ext_svadu = false,
+        .cfg.pmu_mask = MAKE_64BIT_MASK(3, 29),
+        .cfg.max_satp_mode = VM_1_10_MBARE,
+
+        .cfg.mvendorid = 0x489,
+        .cfg.marchid = UINT64_C(0x8000000000000d07),
+        .cfg.mimpid = UINT64_C(0x0a231123),
+    ),
+
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U54, TYPE_RISCV_CPU_SIFIVE_U,
         .misa_mxl_max = MXL_RV64,
     ),
-- 
2.47.3


