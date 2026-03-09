Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F89F417E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv9-0001ht-Di; Mon, 09 Mar 2026 10:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbv4-0001VU-HN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbv2-0005KP-TR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629Dr9oI4027630
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 irvm1RxO0OAfJRQlGB3/N60T8RyhNbiLkFoVifwjYXQ=; b=QNJu+/EfrHN/fqb6
 FAKgBIxzKGzLqxr9xJ1zGKH7EUdbIWP3pJy9L23P2t9rRU4w2Ro6cJzLg6B+dmnu
 Mtyp6hiYCyWNcJh8nB/TfifYhBYLH3kooKeo1vT6MOTiZSAsfZTJirO+sCj7USMx
 hmXwoqDyKE2yWsiVzQSnZfqNsrPbzCbjfERylEaFE/41byKb+HIMop1gf3nyck1Y
 H7Wd5hxo5Qko1DaECxx5ZPHtmG0tOH50kYIui2SUGRzlCLRFuOXgB2VQd/eRs5An
 iCG06jfTuKeVb2o0YCi989nJxLhQg0cRxO9cKd3cxDTEf0+NrtTMY9PFOrC2GjzH
 mLpzXw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyfy06ku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so11044906eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067745; x=1773672545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irvm1RxO0OAfJRQlGB3/N60T8RyhNbiLkFoVifwjYXQ=;
 b=Rlsh7HtqB5ZVuUkCo5z84ZFOZWu7pSnAYhRPZj6kL6/6z+1G3r21TpLjOpchyTJbmN
 Qw5Q9brlZwnkpP2/a0cPbFnF/R+F6Xx/g4OemWIRHeWxIUoCeBHVowVfx6VT5DgsCmJ5
 j2Rxa+XSdva2y8z0yyxKU+Xpujcjni0AdDtzjqdxij4+wLwJZZ0axl6i7J2GkAd4edpP
 zGlKC5Q2wzm6YivTvf3ILJEyT19119ANE23m9QtYEzvqJJxGGeiVdHthB7ioRXYCcfJ3
 42WYNAQJcqmocLCVhgJpmoOYxJug+CIHfrGiNZloww2BEEWMfcMJprPzDoiL0WPpJOyK
 oIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067745; x=1773672545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=irvm1RxO0OAfJRQlGB3/N60T8RyhNbiLkFoVifwjYXQ=;
 b=tdWKicUwBh/WIYk4PJabCjqGW5mcqRCIFq/RiN9NkidW/76dnoQW8p99i09faU8U4a
 nJOARUi3Lz8+/xwNlToRU4sUekkqxk8P9q5jaLd56sAIQKGB4h4S+CKGQ5J77yAfklLH
 rxDQSasAXewAvhhxysX9h/jHPGX6zpQeZoucOVDR/QIv3pfEUQhc6+s7/iBbI+a+Tzrk
 zlb/kCF+dKjbwWWYYl+dXpzi/St68L6+LTvKhyIb5YgNdXJaxFcbyUy9Br9MIkSe3IrJ
 NfEdfV2LnsNCczxuLaH5DamfiY9i2Bf+zDUTudD/4edPsY33I/yVitaJPFNM8fPp8M4L
 qP9g==
X-Gm-Message-State: AOJu0YyXYPzohBtl3dUojHYhZYzV+X3cmTb5bHNCsDbXXB/DP61izAUN
 OEPJffooeiI4jbhm/9hoHYhDHYTfVUBhy+3wk5C5ihW3bHNGghTmu7t23GcyhUN83QKpEbx5oxG
 QgRfG8ps9D/N6oTqz1h5OcXnXY9NWazNCX00z9yHJfAWpM5gtB+7hIPY7SPxIKOV6yg==
X-Gm-Gg: ATEYQzzOz1aNDvEg4dq83iKFf+IKdR99Db4wCWkWzzJyQFSOgcUHWbzAoTPh84bDt7X
 7gkRY1yYS+qCLhvIZF6aAs81gEUT6J1FOrqzxBJ5cvHBRw4OPU5sxWjxAz8m8HxGSTaPqJJPRvT
 8Y0kTWNX24nJ0VmPfGPrv3O2e14WqFAgf+FTyeD9S+jyCc4OQ+nREwbItzQ+bo5dXiUaL5nio7o
 lHFkU4w6iPrz5ZBNe2NQZa/Lqo8OGdZcFuprCpVoJ72C16/u/trnCP2UypvIWGpCHT5nV6m62/O
 sLLe2L6pSZ0UIe2kNhmJ2DPcX9wFQL+xL4DNNxcFE3DB1EHI2uYkxxR9HEejERYDIt3CZUvNCFp
 V9zNKYrfCWeCs42ObrhY1BQ7Ayn1vm2Li+pq2/llTZJ315R70yEyqNMPLybsTk/i22Yh0/A==
X-Received: by 2002:a05:693c:60cd:b0:2be:798f:23c2 with SMTP id
 5a478bee46e88-2be798f2614mr33299eec.32.1773067744568; 
 Mon, 09 Mar 2026 07:49:04 -0700 (PDT)
X-Received: by 2002:a05:693c:60cd:b0:2be:798f:23c2 with SMTP id
 5a478bee46e88-2be798f2614mr33286eec.32.1773067744011; 
 Mon, 09 Mar 2026 07:49:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:49:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 34/35] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Mon,  9 Mar 2026 07:48:21 -0700
Message-Id: <20260309144822.877695-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX7u6/Shviyb+J
 e1Iw3yjAoQ06X1kFlZYWfCqYp+u6OL5t70NmjQDXaQ1+exTGTBXwiyKwVYPfy114sz+awk1MT7x
 RcG4sbeJVepvTGRgAZEnx2GtSmQEzEImyEZIIr/1Xk5uXatqD2gWdVHnX/JCfcYPsZTGj3XDdnD
 0xu1SyfMyUnDx/c5E5+BrvZrw0XKMoqMHbfPW14idFM7RSTmDmBR2MnPSOzzJ1cIvFEuWCOl5sv
 pSA/vPTmLh4Mq+xUuVewATslFrwMUxJZ9+94TEhPtNrkuX8q3WL1m63u17WSdkJlFGqNONtP/Yw
 /rDxurUfBkL9r1FOcXsDObMgFsQ6xyIfiMrIPgsxVtx/X8sn3tuTGLvxpvuPhug0OCo6fnLWvGI
 PJLkjuUm4znK475gc+Ty1v3cIA1wO2LUPjlNCL8gm2CSbEq4ksuHIcTjilZp/sx2mRw6zKyU1pK
 ho1yVtl3Xc27JZoC4UQ==
X-Authority-Analysis: v=2.4 cv=OcmVzxTY c=1 sm=1 tr=0 ts=69aedde1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OC-ZKJ6AczBSh3OnBRYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: cKmv5WQ3JBdrWd3zE6LMvGRZ8ytZXr2N
X-Proofpoint-ORIG-GUID: cKmv5WQ3JBdrWd3zE6LMvGRZ8ytZXr2N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/macros.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index e4bfea4923f..26d3f7d8a4b 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -653,6 +653,16 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
                    reg_field_info[FIELD].width, \
                    reg_field_info[FIELD].offset)
 
+#define fGET_FIELD(VAL, FIELD) \
+    fEXTRACTU_BITS(VAL, \
+                   reg_field_info[FIELD].width, \
+                   reg_field_info[FIELD].offset)
+#define fSET_FIELD(VAL, FIELD, NEWVAL) \
+    fINSERT_BITS(VAL, \
+                 reg_field_info[FIELD].width, \
+                 reg_field_info[FIELD].offset, \
+                 (NEWVAL))
+
 #ifdef QEMU_GENERATE
 #define fDCZEROA(REG) \
     do { \
-- 
2.34.1


