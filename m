Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF25CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0P-0007Bv-E5; Mon, 01 Sep 2025 23:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzn-0006nh-Et
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzl-0004Te-Vw
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:47 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S1FU022183
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s+hNS0jsrXFE+c0r8sY+9Wmz+fMeEKGYNbY79ju5A8E=; b=W0eP0empc9cGp5tE
 ap8KY5UWwCJXqMJjCLiX3na2CaH2gEL4whEyZwwfEwaXYR4yRcq/nGgS+sVGu9qe
 OsiwrEm/x50XOYpep0JqOkU6DGEikx8NgYQgB8BEZcNKfZbyQ8IkIuQ45vIEmVvW
 qn0RYiyfeMcNGp5JVKsy+AilR16z3+3sFwQTudQO2oj8Gi3A1qQA69TdUvZrPlOe
 //W8TmvUgq6L9PbgWrYjUTNgiiujGNzzhilp+LPqalFwmoHfAf/3GRMxJg3ub+QL
 +grUxXpPk1USCjcOcup/SnSV+b2NWiMvfA9BrzxkIjpYM97Z3t0LXbaZVmAyO02Q
 q4jSYA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6hr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24a8dcb3bddso27558075ad.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784863; x=1757389663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+hNS0jsrXFE+c0r8sY+9Wmz+fMeEKGYNbY79ju5A8E=;
 b=MLGOdZmA5ULZwmWYUcQj0/cNg6a0s4R7xkaDkKw4c/KcuVaFrDSbIUEk0U7P6nW4FC
 y3TFAl1FUcWPscJ1WYjbnSZ3gyptEwphHKT55Cm+j1qvTXkIFxg1odwbaKjypCB6Tuq2
 dIBp7W/RQ3dZQiuZEA+8GjObTvBCa/2dZ8FMwyvp5bRgg7n7liU8rMIUN2ssV7yK3Fl4
 aF0yr5tNWlJEPi5SZ4QsSS5WV35913A0wzRhtUjAwT567LuiNQhKdvAkBR2+cYLx/v28
 5yWTCXq4lQaBwT+u1ByCwGG6XN+P/+NJ8P3oLpQrqDamcUkzC1aLjiPINCK1MkyCW8MO
 JveA==
X-Gm-Message-State: AOJu0YzovXpVHv/MT2fHv8nsU9yuZFCbTusCGRJCxKJDIoBWqT5kdnTj
 AdtkfSSAU0QEwZEnaTSDHQ9BTDXbUvIh9DTyWFeC605F2jEu1Br5DOrU0QRefuUeqR1df67jRDd
 FmbJ6/dR2nEDwY4GYhTUNPiQDeryO25ZSiVtbROeu5z0YUB5gTIGtOGRm/JBRp4qm/jEd
X-Gm-Gg: ASbGnctCLmMqDQs1q6ZgFlKUj6e7eUqJqTFRg6ydDjxgFV85b733ctaJWGb9BjxlwIH
 sLaFRZIENcJ0N6hd642NDTbD5adPwM6xZlQVnLPZ6raxE2cnxZL5hSChZN/Xs4XBJ70ScGCu5Qm
 Mre7yfM5IZBNaPNmp/PS10/nSJJj6+qRcDp93BZUc4zraPvjIjjL9zbVZ1YDj6aJCQD/DAqe8Xu
 l1WCLCd54JrpAqVLkEf75iB6JVsa+lQJSjK9YYE/9OZJZukVe1+Ja5EBFgIcmT7jicpcpuYUh4s
 ek6VA6QWqnjAErCoSY4MBpSnubitPVqTvZzSRD6V+hK9dNtO9/pcRE88+z1AXlCzXhwECyQg0oZ
 eC2bLtlamUD1D
X-Received: by 2002:a17:90b:1848:b0:327:96dd:6293 with SMTP id
 98e67ed59e1d1-328156cb806mr14176410a91.26.1756784863089; 
 Mon, 01 Sep 2025 20:47:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5gNNqmfCeIIcSh/goAUEiFadb6ZWHahJ1gOvzYDiW3RKC0VYENyB1D/VtWaHdD6+j3Z2qfw==
X-Received: by 2002:a17:90b:1848:b0:327:96dd:6293 with SMTP id
 98e67ed59e1d1-328156cb806mr14176376a91.26.1756784862570; 
 Mon, 01 Sep 2025 20:47:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 17/40] target/hexagon: Define DCache states
Date: Mon,  1 Sep 2025 20:46:52 -0700
Message-Id: <20250902034715.1947718-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZQ62i21eeqIYArecrxfP4w5nxI3cQWDc
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b668e0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Yl8gTaLkFLj94gSD-c4A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ZQ62i21eeqIYArecrxfP4w5nxI3cQWDc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX7D8LudIPsyWI
 StLcKkxpOtZDf6KfOCQU3Bd41NN6rURmEU97cGQ+FP7OkY5UQKqJcujkReqiy2pjPj+8A1h/zMZ
 SSa2cuOECZV0GmQyImScd1zH9s3oDWr/fjNnwaA9vruIsH2b3MAbYQ6Qq+k28pMBtEOz+P9pEv+
 sty4QZ66MA2o7tTEbYRYry+EdgeuZgEdwKr2CZTuzfaBXveED3KQ0IQ30BnxR+h2YEekQjKDxh9
 6GZcQncrkbMb7XX3L1DVSa2VO2m/lEStxPsrGUI+yp25ccFTSrRd/HYKR/ceyE7PfUUKlQWRuoY
 8fD8ix12vxuzXR0jaGPUM1J3UxXJJZQ9iQ3/1zkeJKEsee3O08IGQCw4s14vPNdOAMbIAw88mLl
 M52S+GHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu_bits.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index b118761e05..c7cc426ec8 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -101,6 +101,13 @@ enum hex_cause {
     HEX_CAUSE_VIC3 = 0x0c5,
 };
 
+enum data_cache_state {
+    HEX_DC_STATE_INVALID   = 0x0,
+    HEX_DC_STATE_VALID     = 0x1,
+    HEX_DC_STATE_RESERVED  = 0x2,
+    HEX_DC_STATE_UNUSED_WT = 0x3,
+};
+
 #define PACKET_WORDS_MAX         4
 
 static inline uint32_t parse_bits(uint32_t encoding)
-- 
2.34.1


