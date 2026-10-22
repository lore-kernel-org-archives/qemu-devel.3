Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7236606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KLuGTZMy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GfxcDcMK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0o6-0002jQ-1k; Thu, 22 Oct 2026 17:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0ns-0002KN-Is
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0np-0000MS-Oy
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtVCO387692
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JAkw9JEyYXq
 KEE13QQfM658HCqq+hRxkvH4wX+91lzY=; b=KLuGTZMyMPr6ek5sV/+FxH2IVvG
 O3fxOlTFMwp+dEcGOlZtde9B0jMAjoLSg/6KKeVg6UiC+UG6SesB2sXUu3gz+04g
 +xLssdvFNGpkumcy6yzhzMpMoJk8CowyVL89TKXO8EBuZtd/orsOm7rybzOkByJw
 8atTqboah/JRHkI0aCncEXnAZ54QCs+PW9jPrUwiqfn3KaEsLeXQYfT54K1xV7ct
 p8dT4NMqA5BDc5u1Tvf9wVXTzaDRKW4FXd8OYB7Q0xsH9ecQLMjy8AZX6OIITa4C
 DHxOJaDnFODhpeyTNH+lhkMikiFGN5S//iZA4ElXeqq4CC+bSICMeZVKuUA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq4rdq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd8b7226694so124165a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706294; x=1793311094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JAkw9JEyYXqKEE13QQfM658HCqq+hRxkvH4wX+91lzY=;
 b=GfxcDcMKWClm64AG/WrHdtPEG2PHCc+hGXg5MFEFo/2wLEx+z2SobEqA8WFsyfbPqf
 /YVbJHex51HgEuj/aegpcGHcOqSQabsv6MXK9flzhOoH0NW0ROtGGzTvev3pvNfIk81C
 V15mIUCdD9kIjLrsDTKBWCfjIDrgSx11yKQVzKQd3cyJLMMR7gRS4jU0Kf2A1tl05eZe
 Eo14iUmZ38OsiGV0guZeYtiee62M1kYucbrDiCc9teqmhzkuKhNw9I3wgr1gFfMKDGaD
 Iu+340jStWiQSqkJimdfzL6ge6ryij9CrSz57ekH1iJzoHJX+aXQm4a8Ha3DFPEf/cXZ
 0iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706294; x=1793311094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JAkw9JEyYXqKEE13QQfM658HCqq+hRxkvH4wX+91lzY=;
 b=jvlxsgJurTSQle91fIFPRcesZvcYdbBHUHO0xMMCYWZfeptVm1VbEQ6qgQy/MtiS9A
 l7F4nVR5qAGuEhx8m9bIqFE2WCgNgzXaKO6BWsRxFGbv3/WuxTKVhNEtXjB6/0URLq1q
 SEl8H4zB7lanOGZWu/Lzj5ZXbT+QcYDjhHpOVANLOLCoyOYPrGTIKgSxaUuGofxSOF2k
 gbXBZO/+GYkgtp7hfb7wlht67llqDax5LhSeNjNKzZYHPVaIQ242ydOQcNBTWqk5oBkI
 Do0swX88YunUcJ1ndgUDIHFIICo19cUrDaI/4odWHlhUEN0FE56GmksX2ilj7XwdulxW
 JY9A==
X-Gm-Message-State: AFq9FYKCpaG6vjZi+TsU1mmqnWFA5Fi3nXtmBPJszt4U+l/f6aIkdBig
 7LcTnlYB/xVMj/xtxNTZZgmaKC3T9YAqviUDzjdXZlCqiBRigLMjkztfcCmC54NvIf5umLzgVtW
 irimqWrPVWp/KKKwQEpN83RpmiPoI41U5ghILq9CNgZsikWUJ3d8KEuRdqcSMKbJODQ==
X-Gm-Gg: AYBFou0Avzo4rbNkWNFqiO7nzNSm1BUJYsJ78IsRhm3sp0WJQhFPEhyiX9vkfhMSeLl
 kEEaE6OaaBn2O9RGC0ExWEC5nrVc1iTLpXoJmU1XQEq+JG2+OF5OeLGriP7b9R9mMLPavcxH2/4
 7weKcuo3xdeniNhqVJGK2AVwcfwoR6JmnR/X7Jkkuhs+cyDk4kHsAx513OejJMCoHURCXkKgimD
 21vR2CP947i2RTAUIYtvTYCCCzVdt+sNrZyJon1y0SHrLBhonxBwlxiPWPELiqWhrccNC+vZz6P
 /8pBUBETMh6l4QWVm9NXfIQcxLsjLRO8WmD4VRJna8ALN9UdbGdl+0XX8iJW1+G0q4BJPy+I7Yq
 Blvn7hJW8b6LDCMoWpo7KJ34Be8vdgspm5GoL1Up+YD/LFKT89K4g/L7ObbhKrNw=
X-Received: by 2002:a17:90b:2752:b0:3aa:fc22:8aad with SMTP id
 98e67ed59e1d1-3adce7cab6fmr144326a91.54.1792706293890; 
 Thu, 22 Oct 2026 14:58:13 -0700 (PDT)
X-Received: by 2002:a17:90b:2752:b0:3aa:fc22:8aad with SMTP id
 98e67ed59e1d1-3adce7cab6fmr144316a91.54.1792706293414; 
 Thu, 22 Oct 2026 14:58:13 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 26/27] target/s390x: rename qmp_query_cpu_model_expansion to
 qmp_query_s390x_cpu_model_expansion
Date: Thu, 22 Oct 2026 14:57:45 -0700
Message-ID: <20261022215747.2479440-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: g7yLND0kammejo7p4ECpGY2RAoNpCBxf
X-Proofpoint-ORIG-GUID: g7yLND0kammejo7p4ECpGY2RAoNpCBxf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX87VplLW+5xXE
 HbSOUfNXmjr34LylM846Gs7qftaji+9UlE6VxDMtvOdiX+dcpxgKJy/Rcw2wCldPTo1KJgcCu58
 AVGQ3nSB3cqhUomW/d7MvA/pY5A7k/k=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada86f6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=7UvLiwb0lT3xj6fr-RYA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX4ZperHbRI03Q
 62JX721Cbx4mHsOEUU4LuzFlUbFliHjzW951Z8CjmfFHreoRmPinHWQ7oAELvIghzzDHjxDf9LY
 GBrHLUzsZRbhVLyQH/Z3/lJbDKp14hTRchb6iTiG90B56GVn76v3EnOIRKoOWBOLC6GnJGCcHG9
 O+fv4Q9o2Szuh5kUuv+2/qsXhQq4bg5pLq+QejHLsucldxK8DYTQ4WzOn1c/ApIMDRqX3eFZGLh
 dl8K5XKRLWGbtPZucIfbo28UwvktqR2Zity3iElt9MnGrv4NPTmlxQdYjChPgOuaStOpD4W0oR9
 YSCE1gXgJvt8h1UhfEzz3NoqNOnQCkUYsisBzpZmt/Bu3EaVQ1UUBQXrzJ1vrVHE93oXg/AiZ+C
 UwOwq4IFj/V0eHh2XnxP/UgiwxbHoK3yNe/BllF3sgiUbDXJauKrUmAvhqrGk0aPSemqfHRCWiW
 /5OMc1famMo3v7N1uvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261016162509.24854-6-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h         |  4 ++++
 target/s390x/cpu_models_system.c | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index 4d530af1c5a..ae58d0cd580 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -33,5 +33,9 @@ CpuModelExpansionInfo *
 qmp_query_riscv_cpu_model_expansion(CpuModelExpansionType type,
                                     CpuModelInfo *model,
                                     Error **errp);
+CpuModelExpansionInfo *
+qmp_query_s390x_cpu_model_expansion(CpuModelExpansionType type,
+                                    CpuModelInfo *model,
+                                    Error **errp);
 
 #endif
diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index f82b693b0cd..ccfc918b383 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -209,9 +209,10 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
     }
 }
 
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                      CpuModelInfo *model,
-                                                      Error **errp)
+CpuModelExpansionInfo *
+qmp_query_s390x_cpu_model_expansion(CpuModelExpansionType type,
+                                    CpuModelInfo *model,
+                                    Error **errp)
 {
     Error *err = NULL;
     CpuModelExpansionInfo *expansion_info = NULL;
@@ -259,6 +260,14 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     return expansion_info;
 }
 
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    return qmp_query_s390x_cpu_model_expansion(type, model, errp);
+}
+
 static void list_add_feat(const char *name, void *opaque)
 {
     strList **last = (strList **) opaque;
-- 
2.47.3


