Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D681DCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0W-0007L8-0v; Mon, 01 Sep 2025 23:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0O-0007AU-NA
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0K-0004XZ-SL
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:23 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RkUc020382
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zroRFyPUVBvjqrMFJ6JZymGgBNiBmuU5ULiPu3eSLQ4=; b=IlG1Ir2wPEzGc6B+
 nH/eAR/QMVEDPvrvemAoA1BihQF2PLWg4kivgaNK+vyU9OIt1gaC3FQg/qLXQxGa
 ev0kvRBT03uxJA20EMIfV0VRL7hL/+/kNoIyp6ts/wBEo3yjzU7I4+0it/DeeZwJ
 ZEF3SrVc1Esz+kS4Oum2Qaorb7b+R9VERbfRe0G+5YKIE1mim/MCaZScZvJSYSjF
 Mi3m39YshPkXN9hTNy/MXScuIX7GTMVa4oooivhL+f3y/UNLdl8xBSDVO5fWvtVv
 +20qqbeF9XH0MbncBkHe9OcfkzwPsfzCiYCTPeEjK66lyIk1ja+ySZm36nBeDrtB
 RLZhAA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8rxf3g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3276575ae5bso4963228a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784888; x=1757389688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zroRFyPUVBvjqrMFJ6JZymGgBNiBmuU5ULiPu3eSLQ4=;
 b=vYyyk1FxaU/eB1TQfc6yH8MsWzdL5j38W6sH+d2wh8jHMKz4Awn88EQwHQ9/8tcfsi
 3izVJ9jB0wqYanAFvosXTGPzgaLEre83m/CHX0L0ZUpFEonLpLiaTGd26qwhJw1PYg+w
 IvZbNVhovERr5vge7YyLIb9NkC3ryb/e4WyY/H5OvZ3sXjArWWyx8wKndL1Xh4tFnCqX
 Hvt/NaUH5OCqTQLsu/vZ7u/PuJEtYO1A2PAj2C7z6kWJNrpPMQN08aqRrrGy1oiqw2WB
 Ms2IP8aZ9mp6o4WyV3pLAScvzSMPvwC9F1gcOlu681InvkJ++VdzmRBBrIAAN/nBSiFF
 v5Zg==
X-Gm-Message-State: AOJu0YxY+iLX5H3Y6rKsrBabsUESqE1F+7crMc7mjSLOYiNFlAj/qW/b
 MuZId45DN2OZ/3vdiJjjCyMsI0o4vM6+KuKyXxTBPWwkg/UdkqOC4aYFotSzzIa2NWx2pbIAn2a
 /QyL8eXUc1vzIFvrnZklrXhE4wGbcr9Q7APnT174SeuDCFHfQ6pLkps9Gaht+VdcKHyod
X-Gm-Gg: ASbGnctDyEMy3/BWLeqne9TvwA7HNPjhcwj+mgf83/XxSO9otCZqSq7nedDcUAgkgWa
 X3VoQOaUHZyDUGjNMeW02QeV6g2ICo3pT7W6defm7+PaCzSHtuXm7iLG+EKeEKIsSaa/HVshfal
 f15Xs4Q+wz2t59fnv370kaNTmVd1CZHzPy0cxEDJsm4FTxrgB4VlaoVNjSnWIGS14a4cr9ifyJ+
 P1ms1+I6F/eIoJ6e3EWzeuUslocdjCN6l3+Hrm80ot7DTuopDAQ82UUTVlDuxDxoWVLH4RChDnU
 jeVMA5NTVI35m9DECchBYWp6N7SvXB9e2i2fRNCa7HJC9ckcWD0I+QAbPLTXHd4e2eTY8trTYyG
 x/lydCg3T2JNp
X-Received: by 2002:a17:90b:3809:b0:329:dff0:701b with SMTP id
 98e67ed59e1d1-329dff070c6mr2282187a91.17.1756784888204; 
 Mon, 01 Sep 2025 20:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGndtxV8+UELHz1YwHA+b1lLW0G/662pWxpvRfzfWTN1pdlItVStBjvD9C/HVLrGrgLlP1TbQ==
X-Received: by 2002:a17:90b:3809:b0:329:dff0:701b with SMTP id
 98e67ed59e1d1-329dff070c6mr2282155a91.17.1756784887714; 
 Mon, 01 Sep 2025 20:48:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 39/40] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Mon,  1 Sep 2025 20:47:14 -0700
Message-Id: <20250902034715.1947718-40-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX1ZBwL+At4O0B
 1kZdJfDgtwJ035aUYey//SsfS6+PnkltWxoQI9AM3LqbK+4J/1yLxw3XFQQmjvGN+nzBaXpRLrT
 V8c6X1TxPDk1ip5GYu0ZWMXd0IcE9xcQdha97GTqq8D1OwhH+K6kPp1Td+fxgB7TPSBjWge2lme
 Qa2sq0NF16e7Ta7CM8OTbGKsKD0+c1bE38O9wcptPkaUc2wqsKiNMLHtCYdYYdjTXkyc/cKz1gV
 ECttn0enmzfTVwCfWr6bLOQ1Hs/mngY1P3zhFks5yjkXKiZxNjW0gTZ4V3/K0fYz9Avn9lI6gWU
 1f9ta6TCGFUbOXg2h/1IfJ7sP/f2w2DcP2Ay3UwtfdqAtH20Sg/HMEMzpM0Ov74SuSLCztVJVF/
 zw9nLneQ
X-Proofpoint-GUID: h1DaUexOqEEG7UUhr-w2LtQbb0QKpi2R
X-Proofpoint-ORIG-GUID: h1DaUexOqEEG7UUhr-w2LtQbb0QKpi2R
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b668f9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=OC-ZKJ6AczBSh3OnBRYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019
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
 target/hexagon/macros.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 4823c97fde..5c3a4a533c 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -650,6 +650,16 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
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


