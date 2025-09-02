Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235E7CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1b-0003N6-NM; Mon, 01 Sep 2025 23:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1U-0002lq-9E
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1R-0004dh-SS
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SGBZ030247
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LvhxdVg90M6jjPVxwxkLKajHzNn3JRc37J4bANqduJs=; b=WZNsp88S+Xqx/1gg
 nPaGKqjwHY5iqOqXM/vA/jJulemmOaB9mLkAeyYIoojedw2Q0AsMbi6bDQ+fgND3
 1NIMeeYHN1vJXNA7kEJo4mlRWUfnlmkAHjbz9NUZ32wLsfgxHODGagE9hU6sm5Wd
 BiQY02IA4RP2AH/S4Rb786imxxwV5bYRpPjWnLrYr1gDXurS7yXrdAwfbHrsWukE
 HYm69Aua9sbmdM+3uLI65/dsQIiISXMQ0wqSHtmByPeIMd4TrH46qmkciaZ6TDuT
 ZmZo6RrRK5tPKLF6tPWf5UL6hIolZ7voj4bZojW5fBx5y/9tx5ADskQAUZ36FxxC
 ujjqWg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy26sq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-329c76f70cbso941686a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784957; x=1757389757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvhxdVg90M6jjPVxwxkLKajHzNn3JRc37J4bANqduJs=;
 b=UPUXIjSA6D/VojLaEA0VR5W15jI1Cb3kmxTM0rOziTDSfv7yb3w4yLUA4oJ1nQMI6T
 GX5CmElF6e8Tnru94I1GAQ6uPqpvgKal12FkL2IEJ3z2nT6xXUPVZxzsU+QmgwrJRnDV
 rhGhF7VdJY3j0jFTzBHEYMXda4Hl57ExsPBlQGc8UWg8Oy1osalUTjcvkdRLwz4qXZXQ
 Bl1jyKZsL6A0KE9OS4/yVRZoAYzk6SEmluBWqCxzqbp4gAaeBviDAUdRTmdmk2fyXMvN
 4sOxgd0ViYIpUWFUPdh4wIZVeB1vz4Hn6yNknniDRi/T3Y0xo9ZvWYmflN+oKY0I1ik9
 RXpA==
X-Gm-Message-State: AOJu0Yz4cc2OAuXczkAXLU3C2S5xO2lHkxBlrVSu3v+98XkRKQMEbOpx
 UQMipqAeXZt/i/rBb//QCnB+ltQa/jJKb69lD+ctXsVAc4ZOFBb4NV+1khfYHmM5v15BaV+q9l+
 yIYnytnKcq7axFESMUnEKI4d71uwkGZ2jwJ8Me/800ZYQ5+bMPIkoooprp8i+9935cP8g
X-Gm-Gg: ASbGncs8JiFFwPMNpPNlqjSuDQb3BhRcoE5TSCUAMFkvSAQEs6Gs0yfOWdPfPKJlsTM
 GeQe4ySppjWgj45YENXxYE5i/Jz+LqbRYIBQQzb5e+ps9ZiqK5705jkfh7SWaIGjC+ir1hMby0C
 djiFww5t61UrDsyyd0JowqRZxru9WjKBozfC203DvywiB0nWWl9Y2wyD6+9X1T52j48dmUiw1Xo
 TKQfsrD73NSFgWVPmSWezQ7b+ZmAdTLS8wLZ5MSVe9K/izBircb1SDn9+m8WikeNKS5SkrbZZ4e
 5qFZCZwyqrjxr5yx0auqU+NFgNZYvv8Pt+6n7Pc1wvk9KcqoEr6/k18SWiYGRbqEquFDBUb23OB
 qS+yaBN22O/Jd
X-Received: by 2002:a17:90a:d410:b0:327:7264:f1df with SMTP id
 98e67ed59e1d1-328156cc867mr10966461a91.31.1756784957289; 
 Mon, 01 Sep 2025 20:49:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIUnYNUcUA+ZQ8WTdtomUeaje5ohEDWikXpoMM8q4J3hdDQ2YCmdczSPKn1C3pcZSALYnyOA==
X-Received: by 2002:a17:90a:d410:b0:327:7264:f1df with SMTP id
 98e67ed59e1d1-328156cc867mr10966427a91.31.1756784956785; 
 Mon, 01 Sep 2025 20:49:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 20/39] target/hexagon: Implement siad inst
Date: Mon,  1 Sep 2025 20:48:28 -0700
Message-Id: <20250902034847.1948010-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b6693e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=HdTxHAvixyPUp6pof0EA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NJYEAm5Nx-tgfBjr8Ghj7bNNfuwAbqc8
X-Proofpoint-ORIG-GUID: NJYEAm5Nx-tgfBjr8Ghj7bNNfuwAbqc8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfXxi1lDWgVVMka
 VQfdFaQQNAMlKPhsVTV4FKmU4yn2Dvp4qVqakvplhIWGmHb4QaShZRCs+SndyedNMdIHmwGj2uG
 5Xs8FVTuD/hW4QWcJcGN3652WtcxWLJcZkOr+2Wf2VaIuHRxCReT/byBE//cOjJff7WRwbAgK6S
 rT4e6F3otzwuhADat6bYDxRPHH29ZQOQOp1b9LXFsxQ61ILs4nkqEOoHEYF0HQ6nZFZB3fpszrG
 XUVNzn61hE9fT3getZzPImTL8Qohq368TzY5yfwS8mfr4Nfq/wB/pZ/o6wFnr7hhAT6UsU3CL9f
 /p4cYrBen6G2LBxY+dMUicOwEFo/MRQYuHFcxd/ADvedfbACv3saQfq2wOQUR85Bv6YgMykzh81
 d5C3y6zK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
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

siad is the 'Set interrupt auto disable' instruction.


Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/op_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 569e8271b3..b887302d3c 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1385,7 +1385,15 @@ void HELPER(ciad)(CPUHexagonState *env, uint32_t mask)
 
 void HELPER(siad)(CPUHexagonState *env, uint32_t mask)
 {
-    g_assert_not_reached();
+    uint32_t ipendad;
+    uint32_t iad;
+
+    BQL_LOCK_GUARD();
+    ipendad = READ_SREG(HEX_SREG_IPENDAD);
+    iad = fGET_FIELD(ipendad, IPENDAD_IAD);
+    fSET_FIELD(ipendad, IPENDAD_IAD, iad | mask);
+    arch_set_system_reg(env, HEX_SREG_IPENDAD, ipendad);
+    hex_interrupt_update(env);
 }
 
 void HELPER(swi)(CPUHexagonState *env, uint32_t mask)
-- 
2.34.1


