Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3D4CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1m-0004hT-Ho; Mon, 01 Sep 2025 23:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1h-000497-QT
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1e-0004fH-QC
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RknW016550
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P1Mtf9skrqB1o8icHd+jobTVwn2iH31GHNWI8AEw0h8=; b=VDUrdOpJgS/ElQix
 7HX0HV2H9L9aUPSoAkuHP61qoiPmJR87/OKl87Uvg0l67m8XL0qHDdvUGN7imANs
 rgz2CSHn1QRUJtzWmnmzmuikkugr+RA+kXl1NqTiDA+1i/Z5uxNwREgaZgq0NYvk
 wjESBGQt5gxKBYervl0Mab3Rz92tW/kAm/T+Hvy0tccT6V++4lddA4jiY/2CUxf6
 jrwnGZP8SQ1rzEo1Lw5+FAhxZ7DJgb+dEei1AAEGoMizhdQN1TRz4Bk1s0SCTE78
 1RxEBbnJ7N5x2oKAVCXZvBmZrYmgXbK1aa61PzOizowKr1kIH1SfnsRC8LS5BRw/
 BRjbCg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8x8am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-248981c02cfso53818255ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784970; x=1757389770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1Mtf9skrqB1o8icHd+jobTVwn2iH31GHNWI8AEw0h8=;
 b=jUTByDCoPLGNdq73XxDl1FRLoH6Y8lM9aI7TJr3ilj5sfKSVHqVt8V+v2Y3lT6zlRD
 6O89vNt6Qokw3RVR/tX370O0xp71YZgfDouCLshZOd3NZIc9E16ZLxciNMsCb4Su3bdB
 U0jBPOmS8YNbIfRV8gGFbHFtNRIf3Ug2yqlEyusgRtsKTPrflBIOfmF+XHWa1H4PEBQg
 ydH0cAP54R+3vJlMV18P80Spw/J9I8i1XxpGFSc1ndMalZfdl291xs6xTnqRgtHvEuTk
 cCZaBIB5ENUnFCNxl6m6UTqlz7atHNge9/At3xVbJD2mcONNcdFEJxfxLPGlKkJDxCXo
 BpgQ==
X-Gm-Message-State: AOJu0YwR2/nwSb/RcV4kGAJdYVisUqFXaY/UbD+4ol80pXYBwOa8oUFF
 xF+VpeYOTArnaiiTjiO2Ssg+zEilm04BnMmzkinlZ9V5vHxNPWyzeNBgruI1EKkEEs8jp/8KF6X
 0ySIJQSV/nKIO9ErcGQl0nKllcea3wlEU5cKqElH0eb6H7rDbH6Z/LDDzT2NE2yUFGWtP
X-Gm-Gg: ASbGncubQ7/wH2FVOj0S5uFsme9P4cxymh6VISGILoDTdicVguCrONrbTvzThp8B8X/
 8xtOYJDOo9kGKeYYhb+633HFscJ5uO5Vn11yhpgp/vNNx6eZMugbxkvEmpNLCnuzrMXqMxkl0cW
 mTa649BY44hi31evGDzXF7NlnM4PqmFeKBBupiopKvAeRwB3Rr35sVEZ7Fjg707unqcOoM1iBBA
 SZJitD3n98dCgvH4DqYs3TqVd/RkNy01gs91o6rdk1waksSpq3reQNgKYlrDpQ95P+UCTGu4+A4
 XFlurq7OsKKOO40eb7J3/WyxiL8TjyhHQK+SrmZw6AaT8QaSu8MPUXcvKYpL3UQ/h/Mg/Z25nYN
 OjjlXCTeEcfOb
X-Received: by 2002:a17:902:f608:b0:24a:ad42:3559 with SMTP id
 d9443c01a7336-24aad4237ddmr100730985ad.56.1756784970327; 
 Mon, 01 Sep 2025 20:49:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdX3p299DTD9LIfSHYsLBmr8zLPcOXRXadTGIKHv8nFAiUm0Mm2RUwtXcM1n7M5CxvVVfE+w==
X-Received: by 2002:a17:902:f608:b0:24a:ad42:3559 with SMTP id
 d9443c01a7336-24aad4237ddmr100730695ad.56.1756784969858; 
 Mon, 01 Sep 2025 20:49:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 31/39] target/hexagon: Add implicit sysreg writes
Date: Mon,  1 Sep 2025 20:48:39 -0700
Message-Id: <20250902034847.1948010-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2KDzaruBEuullbWkmZkj9xIdpBtKVBv3
X-Proofpoint-ORIG-GUID: 2KDzaruBEuullbWkmZkj9xIdpBtKVBv3
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b6694b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=ySlkKLH3HnL0fBWr2zQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX8b8b8LwrHHhy
 s5LaS98CEGXDmUvhTQjZYBzboJEq/a4DK6UB16HRajzk/P+1e3LTP9YPz+kTdE3P7ASQIBUd2iP
 0kJcHt9Zm5DX2myjeUXeLzJZmMNi6DBDg7HUVRstTHlZ/0qtytR+8ZHblZCDKPzIvaxvcrl/jpG
 q7Yi0qdUYYyqw6F4D3YwI9w1taRZ+4bttkJCFkQ5Krpv4oyIyddGacN5hX37ElKpe0wxGaxwVoc
 XXYlosgpcjdk6rgZt9mx3qcOdTsdV3VTKcHitXE04j/fIt4Oiz2HY9q+ArPdAUUMQH6nUM3I9QF
 uQm2f8/NXQq5Jt1FZgNb/7XKGsPmod+F2eJibie02KRr0FHzm11QFi7seE4AHMIqxjp1PkeJLja
 YgG/ZXnv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/translate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 70e0a1ff33..743c96e6e1 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -422,6 +422,16 @@ static void mark_implicit_reg_write(DisasContext *ctx, int attrib, int rnum)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+static void mark_implicit_sreg_write(DisasContext *ctx, int attrib, int snum)
+{
+    uint16_t opcode = ctx->insn->opcode;
+    if (GET_ATTRIB(opcode, attrib)) {
+        ctx_log_sreg_write(ctx, snum);
+    }
+}
+#endif
+
 static void mark_implicit_reg_writes(DisasContext *ctx)
 {
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_FP,  HEX_REG_FP);
@@ -433,6 +443,12 @@ static void mark_implicit_reg_writes(DisasContext *ctx)
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_SA1, HEX_REG_SA1);
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_USR, HEX_REG_USR);
     mark_implicit_reg_write(ctx, A_FPOP, HEX_REG_USR);
+
+#ifndef CONFIG_USER_ONLY
+    mark_implicit_sreg_write(ctx, A_IMPLICIT_WRITES_SGP0, HEX_SREG_SGP0);
+    mark_implicit_sreg_write(ctx, A_IMPLICIT_WRITES_SGP1, HEX_SREG_SGP1);
+    mark_implicit_sreg_write(ctx, A_IMPLICIT_WRITES_SSR, HEX_SREG_SSR);
+#endif
 }
 
 static void mark_implicit_pred_write(DisasContext *ctx, int attrib, int pnum)
-- 
2.34.1


