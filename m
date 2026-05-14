Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFB4CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 20:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNcxf-00061u-GF; Thu, 14 May 2026 16:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNcxS-0005zH-M5
 for qemu-devel@nongnu.org; Thu, 14 May 2026 16:47:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNcxQ-0000pt-At
 for qemu-devel@nongnu.org; Thu, 14 May 2026 16:47:02 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpG093200085
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 20:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qStttb2Gwe7
 Xv2hEi+G49FzL50PoTX0jXYJ0KI1O52E=; b=UrxumvY9ZjsQKQP+HKgrS2ST2gm
 hO3PzETBWRetMg47xWbYBv/h+cVe1RDLeFEhwlnxTQezYAVm1A0g7vUBwl8cJTyp
 44nKnSCJ3UR3pF5MfikADn16jzhzQ2eEZ1sjq36zijYWxixju5VZtlGwPSvBjduk
 z7mSny7kR/aE7n3ErxOXRs1mVdpUHC9uRXCTWWUSCPUFMgl27fM4fhgO/mpYP3ms
 ILqngvG/pD8dTMhGgmmhCr/cwH7KS6eTNpnfj7gLNdfzjSVwZGM+oJGhxB3qsW/J
 6q+6h0I5InWj2H2WzGb7W7KMP6SWw32vu498nBNivZ9ifGG7ZjkToRx82fQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qrbj5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 20:46:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-90d175ae5a0so395570085a.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778791617; x=1779396417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qStttb2Gwe7Xv2hEi+G49FzL50PoTX0jXYJ0KI1O52E=;
 b=PO0beyJpZVSbPcvSbpW0nYH6p8/11zcJqXDr3HUXePvPcLD+RXUXLbhe2V94mmLHjM
 qFD9F/+0SjS7pAWagR6yvgJoSrVDIjjHJKWT2x8KVXAnkmwwOBQ2dKC3ksEsDbOrOrzL
 aYg/vqdoZFUjkYeb3tTtdLLYfRp1OBMVbxRNbDJ63tItdeypDnAxqSGpUvkiykmNN4a6
 rjJhVYAG/FbHZfy623Gh2vRvMEZH+OZTV9lnIscZ48/DIAxbcxCJOWL37sna1GLGLzp1
 mNa6WXceNKKIMPYywLfxvoh11zSj/zTAMH7fkws6qBAmMvgzcYYg/1gEypPOdLUfvd3A
 7ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778791617; x=1779396417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qStttb2Gwe7Xv2hEi+G49FzL50PoTX0jXYJ0KI1O52E=;
 b=AA4eRMruViWexnKkHyNZHDl4tB5N4B+Qxp1fqVhuNT37MYQRDWQj1o03nkmetUNLZ9
 q+G/ULa0TmJQMENByFfriG8p3641rDJvMem2s8zTT7ZGnzXn+fHi0CfpMKmdeQHqF5cE
 lWZiogZaelAPcOM/YJbvNfeGkUP8TCKYrvekKpfvbbdiFThWh4zUCMFUV5XY0JHllS51
 c5C8kNu4fU+WTAk+yg/clfgzdkWLJ5QVQKZnyMGT6tNOQseXmpOeZ7LVElkYUvh3tyJv
 STfAFWc/p5A1Hpec4nUEe5kXrS3/NW2OegLmdceQI3vCA0SgX8z5pI9UK1h4vupmwU7b
 ja5w==
X-Gm-Message-State: AOJu0YwfVVGfkNKWq8LVprpkaR1qd0Y+r6yL07vjkwU5+jlTU/6lIROi
 nJHaoAnWpQKh0e+RgnlKCqq6bCcKC1xpTnSIuijzh0LiLffzaIwiWB77Vx7hFvjPK977qvtA76C
 MLWpTYb2ASlh73454eUYEjqrTGFNEM83Lf7U95uFM6FqT7kyce6hM+EuQlQ9bo+Wv1A==
X-Gm-Gg: Acq92OGwT21QixopFKs8R+3jtm1gnUVzS3pLmr99vTP97KL4ip7HBNzA81eWl4dMZIu
 jgVz/YIxciCJ3k8k1xcRS7vRq2LCAkzB4woRKquyCBXxJGeIwdUeutDeTHgopA+cQAjI61fzaBN
 4jGoHkWlp1KEjLXbjFziTySBckjNqmCFW2vzALRbfrkB8NxwW5JDp5lwiEvm4dzrdOJHLY766m7
 IB9qqgmdxQsRjXrXrLjEg31NwHfiP8kt4I7KTdH3JGIdZTMCj5vW+HF24G9sKmogD/XMs3sIBFl
 41ZRpdO0uS5+UuosZM+J4+LeUVE5Qdwn7LferhtagjiJnqXRXrJA5/M9IS27uatHw2I1nKaRCPU
 sPfx4Oaej2KKifXJxcGCMJEYuIwS5CLm2QGDCHD4zEbfVPvBPX45bcbwKwbLo
X-Received: by 2002:a05:620a:28c2:b0:90b:263:f6b with SMTP id
 af79cd13be357-911cdc40e1cmr221538785a.21.1778791617254; 
 Thu, 14 May 2026 13:46:57 -0700 (PDT)
X-Received: by 2002:a05:620a:28c2:b0:90b:263:f6b with SMTP id
 af79cd13be357-911cdc40e1cmr221534685a.21.1778791616785; 
 Thu, 14 May 2026 13:46:56 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bad2dd8esm343022885a.19.2026.05.14.13.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 13:46:56 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com, andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v6 1/4] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Date: Thu, 14 May 2026 17:46:37 -0300
Message-ID: <20260514204640.2540054-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
References: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HbkkiCE8 c=1 sm=1 tr=0 ts=6a0634c2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=GhL2bEVCvcqOW28JNKkA:9 a=NFOGd7dJGGMPyQGDc5-O:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: I-YnDBO92YV1-23DfUuFbAQnBLRX1VLh
X-Proofpoint-ORIG-GUID: I-YnDBO92YV1-23DfUuFbAQnBLRX1VLh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIwNiBTYWx0ZWRfXxExfx1Ns7QTq
 qUipA9sISWAkLaAWvudCFOb1gAylJ/Wdd43A2Zg9fDoOZJooAhMnHjSf2EBfnz/seNVkWSmAbu+
 VuALDKHrH4as9LvZCKnTtlknofxQV+vIZSHI3B9TkRiHmadh8648ILCaa2Z2ywYjcDfQJPb+pFw
 8CXZgxNoedXtfQRdlynqQql5BJRHIAi+WBtOOdDoenb9oeeoPoqSndxtMLXUzYOUN07rBR/75TW
 KWrdpMEra10ON8e9DxdBGH17SYRY2I0NMxIdtrrEGsyaj4cCGGhrcpeMrY+MkkQtpIsjWxvcPjm
 f8g6xa2Dgko7v13pScAARMvQPaLDT3ryIvvHG6uIwAF8UoStgq8EOzMvWtgTBfaOP0fqE6tb2fz
 rh+P0SVFT0nPVcqeyIBBqduKq0oUiu8YSHkojpvQQ04/xDw9Gahq2dQgShJPDrcdhkMpeMS38Yr
 CWUYSpySGLB1daaZVeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140206
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

We want to configure other CPU types to use profiles as an alternative
to adding every profile extension explicitly, i.e. a profile is nothing
more than an extension bundle.

This means that a vendor CPU can set .profile=rva23s64 while having the
same handling as any other vendor CPU. Same thing with all other CPU
types.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a81485981c..586683b28a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2863,7 +2863,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->bare |= def->bare;
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
-            assert(mcc->def->bare);
             mcc->def->profile = def->profile;
         }
         if (def->misa_mxl_max) {
-- 
2.43.0


