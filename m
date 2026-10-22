Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41644606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WVZ66sXI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dIOMt9kQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nu-0002Ms-Vr; Thu, 22 Oct 2026 17:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nr-0002I0-8R
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0no-0000M6-O3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKuoEK792184
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bnpybZL4l4N
 OGWyR/1S7z5Hlif7tRO5UisIo8yfeaRY=; b=WVZ66sXI25WkaYBeG7G7Vx4S/xc
 OrHHaet3NjMbUXsDAvmjGiT2KG9tH645sIVAWJOrR3HbPjaIBih7rnDuSXEk4LLp
 6QEgf5l9xQCuNY1kvfTi1t3dKT+tQEw5V0F9h+B6yejIve+EOKx8/sw9fT3jg0F4
 vWYP0NOK3rDa5xZZw6yeIlh79MfpAVSpv8fiBCDwrEmXCqou318MZfm2cmTJUMsC
 KAUvVbimYbeJBuE40ogtiC0rzE+NXxHIYA0B+eVZTB8wBmb7HjWzDcJaNHpr1+yM
 UEEZr35PKEG+Q6dyNwSwFHG/TG5rLgzHTYlUlhZFRfchQPs4B0ycH3XdENA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk85wk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so281532a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706293; x=1793311093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bnpybZL4l4NOGWyR/1S7z5Hlif7tRO5UisIo8yfeaRY=;
 b=dIOMt9kQAlQqIabaTbNmoUkn6BGgeGv4gwkG3vgichnHdLX8Phr9dqATe60Eptu2a9
 VpgSNcN5H8feDNeh1FhHxqyydKSF+YgnBYiR+3HJacsH0aRcKm6e1GxYzcbkjxsjoquG
 fEWGQgFc3NJ8khbgmuk9adTJz+slVBXMA4eTg3i1TUDg+M//NYzRLf6Wl2nN4H1wCuMv
 PcALxxPO07w8rnSepVVNb84juxAe/hyeXWNzKDmMYw4hmbv6DXSqJya14WjHfp8qRjhJ
 t13w/6WY42U4E2rzO2d/d+sUc3VQHYhJarnYWwfhrEhxAD6NMG6JoxFl/18aH+kyVy4T
 jrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706293; x=1793311093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bnpybZL4l4NOGWyR/1S7z5Hlif7tRO5UisIo8yfeaRY=;
 b=IYoHJaeS9yFpHJMKxd+idu2JxHXrSlhZ0A1rLwBBBfwiXK89a/Q0mEqqIfr5lqmD+V
 DDv7LPJ7Izg0RDVKFg4Luzi4PjSGBgpU91Iiev+yBqadDMkrFFPSINpiJoAAp84HXVQ2
 AdRvtNhYazvlZcakcZxDUvvoJHWmW4TVdgk8oPeIgpvoGoFXXRSEiHxQLXqssiky5k07
 RU9B89/9eygeWEAxK3tM7+KrQfkBhE8e7LnyhM1T7UhgaPVctVW6hMXj7gIpLNfZoNbR
 WfSZIPtCsVNHd1ObvNDM8jHnLVjCG9Fjlc7jtr5D0hwQwo55y3GrCJos6MIicsai8Ki5
 z6mA==
X-Gm-Message-State: AFq9FYJwdmXTNEb4mmM4gb5kV5gTkQhiHy3chuEKeuRpaV0ewx+HLF2G
 YPQ3WeVvliMol4FXIVQ7F0Z/ymrN4BorjI18pSrELB2oWin0NlQkyokfahe28K+unCBJ5yGllVc
 F4Yo1jq37FeWAO4pYio40vzTfnZfvWwt9rVChoI8xFD/TLsowKXuq6EvsDy2mZwk6yA==
X-Gm-Gg: AYBFou0r+hxI2iVh3i06CAoDTQAjLDvQXU5LkORtjWN1Gj2ukET6zvi2uUvn1m11G5N
 ZQZ2bhxmsCTee3hLIq8Xc8dtyjGd93rKLvoV8kJSFKh1i6mlHrcRZIOzLG5QSO/ULADi6nyBH6j
 1fgetjDPmUpE3JD241kfbMENKqBKpA+m3yPiQK4nvH9jtuTDC7sHOE//WwIuBvWDHZsJ33N2BmM
 7MPhkjd9vn8tfI45Z5kpopfUKparbzhbv0KHMLG09HsS3xkj98BL5x4Z91Bw3blYtA4nidvkCbt
 0eOfq6jIwTDoLwuvP6OSj/8y/H6W3MkGZ5lds80WsEV6EPAqWVHpfiLCsTBWtcxp3c0Od27o4Ra
 5PTpEsltGJzyGvK8dnLdRhHuBTUGbtBOZrhHvsBIPnmteAgYk1jBbCutUS55a/os=
X-Received: by 2002:a17:90b:384f:b0:3ac:8897:7b9f with SMTP id
 98e67ed59e1d1-3adce7b473fmr119238a91.43.1792706292751; 
 Thu, 22 Oct 2026 14:58:12 -0700 (PDT)
X-Received: by 2002:a17:90b:384f:b0:3ac:8897:7b9f with SMTP id
 98e67ed59e1d1-3adce7b473fmr119227a91.43.1792706292263; 
 Thu, 22 Oct 2026 14:58:12 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 25/27] target/riscv: rename qmp_query_cpu_model_expansion to
 qmp_query_riscv_cpu_model_expansion
Date: Thu, 22 Oct 2026 14:57:44 -0700
Message-ID: <20261022215747.2479440-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX+zGxqvyzI3g2
 JVHWCXAfbwtfnqiXvs0gFgxvKd7+pgzM/lF4peeREkMvArSv/QHnD0MpoKa3Ta3Xq/qsyixOsh+
 fBoEo9vcfLhQV7baXYKOV2HFDSs6L9cFlA1wN8yXxscYn/3e/ub9mIGj1yZupPeuEfujoUd1Orx
 vy83U1ZE+1OP0G31v3vSKAnLwkSL41SF8m71ppXlS0dVQ8k16Lu39Ci3+LohKpbU94J0U7bVjxh
 dXivoRbrlLSRDmLYap0o/RR+6eGKwRemkdr+mAcn+6EajJCoSpMbocVz1SbCms92NVWyht2ibHz
 zefuJL6Xy3QisD+razg9pSavKCP0u4ru9QamKjKRLTDPPMUXfqeUTdNXRIXe8dszQD+7cbDc3KV
 1p1CyiHQD7GvBz2pW4BQ+wi9qhIoN5tv4RqmbQOtR0cVEIfP3Vx6zG8gxs301b4xDWqn4CCr1Lz
 kfsTKVwGyYyLc79CUIA==
X-Proofpoint-ORIG-GUID: SNHLiTgH16iZsmKzRwOcsjjcmK8klL3c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX41mEH6arbPi+
 a+s12fpQ1VhPswJZafMK/44iNs6OcRIA+L5NTI7NdBCjfts94NhXRrdR+jn6HhZ4hR3f9pTr5oA
 ctbVMF4P5zyob9iww2kSDgbKNeKDWnY=
X-Proofpoint-GUID: SNHLiTgH16iZsmKzRwOcsjjcmK8klL3c
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6ada86f5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=7UvLiwb0lT3xj6fr-RYA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
Link: https://lore.kernel.org/qemu-devel/20261016162509.24854-5-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


