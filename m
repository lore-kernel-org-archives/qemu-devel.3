Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAA9CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkkN-0007p0-B3; Fri, 16 Oct 2026 12:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkL-0007o8-D6
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkJ-0002ik-Fu
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5liv2153749
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NbyWzNnA1yh
 7Pne1K6S7QWL9xW4DsFup300DkaKYZ7Q=; b=mcAkYbkS0reP9CrE2qgy1KYpgnz
 TMMsZnXtJ+Eq510I8a3s16Ln/ZTFJKdwbDfsmnuKifR8sQmcHJ5o3cH2TbRZ2hvE
 YrGKRMCSDtxcf1Fd4uGcpxiwrAARlNW68SNhSp/n9hdzcFvhdNK26xMdDpZXEzso
 uLMOS4EJGkRFB4E/tbSH5VUL7fAdeMWS2JYOIF9EYU7UtmZhUYF/FFVOxrxHymJw
 YOvdduIJ+HwAws7H5/RIzsr+IY6/+V5l8LQkBmrzbuAuimhHD9XWgXtlgwrdbEHe
 54RW27rkxr5dz6PJQFvcUFeFY6biPyYPVLq35uKERKtKpxFVCT0KzcQimjQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhumsbrt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab926c236aso129705a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792167921; x=1792772721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NbyWzNnA1yh7Pne1K6S7QWL9xW4DsFup300DkaKYZ7Q=;
 b=Ngx6R+Gis3rDEvsnsbUyLmKD6aojfrocrn/a4d3zXPffAkPnDO8XQzk1m7V3U8/LmE
 RiotABn6I7z3PrngVx4u14s7jVl7V7TJWsNKJsGyGc51PUDQZYUnhH/eNmvXAtQHNZnZ
 VXgdYNFLLkTpMlgfLjFVIYyti5jbDvfR5UJIk50StQeruUooIsCngFgN7d5nOHtd89eX
 qQi9NoGYqjp3dfEDefyYz78smzN34KN3W+Jyi2GCx0EGaft1GSY/+XyfcXi3ePakHPOZ
 hh3jbrMQFn6aTY4NmcTsmpmoSF4ckt929ZwHCVcaQcToCxlCT3+sERhKCsO7XDqDIM+t
 FV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167921; x=1792772721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NbyWzNnA1yh7Pne1K6S7QWL9xW4DsFup300DkaKYZ7Q=;
 b=wGxQAqC/xfI8s8qrsAkHV6gjaaIK2ljlRUIjnjnh1xeqVIJPxXYO/beyNbrKOqAoM0
 aKk443Oh51IUHLVYQ0lBK97g4W0LO6t9opg5UvtpZKKpMsOMfIeDFSW3Ju3zxdp54kAP
 e1+UhAO1lUTIy1n1SpYfLS9w95aKGqTgHbKOxCXY3k5OCVVIJUxWAeVYyBhCheqV3kj+
 uTsBhWwYImSpUAl/d5yDa3qMlWIrPH9COEHpfP6OdAeblVWlecocuRyXvaxG8mk9By8F
 Fzueol04LhTZhYeSefBrZQIiwKIaDcTS8BPx9VsYPeNtt8bSiBn6W9u5skyjzypajqMu
 wGqA==
X-Gm-Message-State: AFq9FYJcpmKU1P4Bwmkjjre9+ga9PIPKGXMvvj2cfphdzxf2VC1vSVFo
 LnqIdbCn9YfO/BFUpXnsqM1lH1mi5YJBmrJ6hTqK3ivWBlDM3WHafhXoCEu7Qfj6fpNoM888d2n
 zF1RUQf3a2ydlIjYb2u46lte17q2/GyjJCX/cAmoigfiZTS9UW/Fk+UkttkSRfgwxBw==
X-Gm-Gg: AYBFou2nNEFB5H8PinGqalwXZ4LiMQGsinAuy8CDcXCf0m3SAERxWCQQS11h8Wyc9NS
 zcb9zIqw2tA20JAUwTDV3ZdHJzilnlxEoXP/LrTbl6dPm7EL5mnkKqMiERYiTUCd86NdAW0318v
 G2DwVeUXJk6XwiDy3MhMoV+SiABcHBIirEcTjKojzdLZu9vEpAnNG7HR+Mrghp169aH43DNgTUC
 SymjsXhaAZgBiMafU/a7yjfaACK8p27mLAG++UMFI/T1r0ACELCBUWH6Thonf1AJUkLFTP/8b82
 hckWTVb431eeN8BZS1RAZ7q8HnWx7f9a3euhX1+d3iqnmPSnW8FhN1biOJIPEKmXiChjRxo8N95
 7wuAaSMflWxF2/EMN7qZodXTOD81at4fgKGw4gnEK1zfUUhTqhTT6tpaSXL5+rVs=
X-Received: by 2002:a17:90b:5870:b0:3a8:86b7:ad95 with SMTP id
 98e67ed59e1d1-3acef5c49famr279614a91.60.1792167920795; 
 Fri, 16 Oct 2026 09:25:20 -0700 (PDT)
X-Received: by 2002:a17:90b:5870:b0:3a8:86b7:ad95 with SMTP id
 98e67ed59e1d1-3acef5c49famr279580a91.60.1792167919827; 
 Fri, 16 Oct 2026 09:25:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc4872861sm5246143a91.7.2026.10.16.09.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:25:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 4/6] target/riscv: rename qmp_query_cpu_model_expansion to
 qmp_query_riscv_cpu_model_expansion
Date: Fri, 16 Oct 2026 16:25:07 +0000
Message-ID: <20261016162509.24854-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfXwdwK+wLgkFv5
 elzQnPL7Av0gmnJHq2vjE0UqajNbpyfJ/jX+Zp0OngfvgfDt6abuDa2Lwrwgqxnz115HSsFE10t
 /cNbZOX+UGYlbluUaqR7Wl2mTpom3gg=
X-Authority-Analysis: v=2.4 cv=H+BOUOYi c=1 sm=1 tr=0 ts=6ad24ff1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Drpi8JZk3zr7esNuAscA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 0KzGwkFnk36BmJA4RiIEW4nS2UxK5r1C
X-Proofpoint-ORIG-GUID: 0KzGwkFnk36BmJA4RiIEW4nS2UxK5r1C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfXxRislNtPnRJZ
 MBSJKE9hGeu5tn0wYIh0EfN2HsXr/7iB1fp2NAOUEPOytbGlWJvq+SPLdduFeDVDjpYw4MtE2Ii
 jW5HqpY/QL7Rn9qJkyxMJu/fC8nsVUr+Kvz7C7BXPME3UcHJe7qQ8GuqIhPIHVwLz83dc0H0hco
 lJB/+w0mCchf7R/fKvfQtlQE/VmEPGqwFltBuMmQYhWdFZXSBWAF50iI2OHyx3zJQIiDdnLsAwN
 Rn0D8QaS5sPqckiVDqXhcM9Wjvpk7sC9sjFR9CUkoVq2x7W1jY2q0HvM4hZ2XB0+Okqb+7o21IB
 ryzkEKq5W+szmx2TPgR3bSk53NemB09CmrsRCkwsIEm2ovrF/GbB7v0HHIotp4BY9oM3+mYaNyy
 wqMmhUXsdpv+zpGrggOHlpZW8VZDNlFVEW8zOYDQu+ziqqNtgJDmqAoC7jZywb4cHtRkKdvKKyE
 7enoO9kz1jxaA5WUjAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160065
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h      |  4 ++++
 target/riscv/riscv-qmp-cmds.c | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index 6a199dcf616..4d530af1c5a 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -29,5 +29,9 @@ CpuModelExpansionInfo *
 qmp_query_loongarch_cpu_model_expansion(CpuModelExpansionType type,
                                         CpuModelInfo *model,
                                         Error **errp);
+CpuModelExpansionInfo *
+qmp_query_riscv_cpu_model_expansion(CpuModelExpansionType type,
+                                    CpuModelInfo *model,
+                                    Error **errp);
 
 #endif
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index b70975affed..d60c6073bbe 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -155,9 +155,10 @@ err:
     visit_free(visitor);
 }
 
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                     CpuModelInfo *model,
-                                                     Error **errp)
+CpuModelExpansionInfo *
+qmp_query_riscv_cpu_model_expansion(CpuModelExpansionType type,
+                                    CpuModelInfo *model,
+                                    Error **errp)
 {
     CpuModelExpansionInfo *expansion_info;
     QDict *qdict_out;
@@ -226,3 +227,11 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     return expansion_info;
 }
+
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    return qmp_query_riscv_cpu_model_expansion(type, model, errp);
+}
-- 
2.43.0


