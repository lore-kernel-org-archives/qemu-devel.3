Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BF4F417EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv0-0001GA-TV; Mon, 09 Mar 2026 10:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuU-0000qV-CH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuS-0005EX-Mv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:42 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629DqoI92138238
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5ZrdJ8gllNViskLTQD7yOHboDI0ba/hRXSLbI3hERUI=; b=huukEbax9T9aK0l/
 R9D4MPvfyw5krJMUNtgt7Qtewz6S8YNKSABfo+QRo3JbdtekhhahGQp43gTmfRRa
 oDF4b0/VOAMiGEoIhJ8zWtcTJ80FEPm4yHS3GrII1yvTa6A7Ow5+IKsisJbqyCgz
 SL+mpuOst1Xk2uDROIMLx8Y2J8MdxwJtxGDn8idO73UATQBcyKnv6j/m/EmrUcUK
 apUexw+/hCIx2Hpu5R0zdtWMjAKmX4kxcBLJf2UQeNEUl+93+3muIR2A36cmlUql
 9lBFq8uYkl7SfBhFzg8SPhS9s7sN+ZWBm/uROhV6pkZdr8wYajCjIdVz98gedR4k
 +gv9FA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyft05u5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2be21f89332so7079937eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067718; x=1773672518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZrdJ8gllNViskLTQD7yOHboDI0ba/hRXSLbI3hERUI=;
 b=Nd+ho0E3asejvOAfpg46rwiiHV2JWrl8vC/Lpp3MTlJUTgeNatdRpaCPbidhTK7U66
 8/FIwivJlevE+7Faq+/PPNwrc3Ssd7wLSfPu6ii1FXp6uQrvxgeBQ4jQb1tzfvTDX2Kx
 5LC9treqaPW5GKQChVjhPd/PpG+USHcscyLxJcF0XCyWdLcRd+mX9jbQCm1vS+XSpoUH
 Y9jjNIgmKWodQ3jjp0z2RAAOi3TVXDts6DZIEKchVCmPHY3cegxZDvwWhT/RpgSsdL5m
 KDKSMQJHI2G3Edvj49gWLZgn4ubHfLHIzsHBLsDro9JOMDnb+GM9szNWLQ+t+VSACKnN
 pgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067718; x=1773672518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ZrdJ8gllNViskLTQD7yOHboDI0ba/hRXSLbI3hERUI=;
 b=Zur+UyQr0nQpQcLYc66FrdcADMiuvIDpnrdGyBfAgiYRLRbRV3TgahKviEnjeoNGzi
 7qfepT3kvFaE7anVg4pX1Fk6hDKzjObFe51sEVizzBumJfS9YIdz0QmFK8Vl/5a41Cpv
 w5SqlEQFplqMIvjegRh7GHliasNHZZincrEeG9D5ZzqFNPhiR+H6aScknX6ZorvoA3Bz
 SxgRNrHQPmwU+r2iNLyx5QMsoiJk0aZBz5Y3mYsRe0tO6vwLbFxLCGnFxYb7L/MnAenj
 5BwFLp6FyWkmNP+0/kJrOTHuC62QvF+3WMd2gfqv9Sugo9JG+xZVyAGEI9+67OLAhcrQ
 Y+KA==
X-Gm-Message-State: AOJu0YwCvsvHSUwNQtwqhIiJ0qzn++AUHMcSNSdYn+QWK00q9UpPEnXh
 FBnrwDpOWXbiZwTzPtVivGTT4H5x/ncJHut/6K3sUL1QgApvHcnbga99zX/OrlKf1KCgEtrI7b1
 z6jkCZWDGbPbaTViaoTlk2h22kmtKm9InhmBGRa51bo/BnSppOzBXoOvm+TLdxLMT/g==
X-Gm-Gg: ATEYQzyjnAeKJSTBoPp+ZBEhPf6d+LqBm3ZvKgChsYTruDI4eYWPPCCnEr12cV3pz0d
 7Fv7eE4XuHfFj5fQ4Zmj9rek3wt+GLFtatF0p4iurbmzFQuib6lAne5D/mDCnbfUfFXbclF98vJ
 5LMP558qOyc10ocvRtaVHpZLWSSpNXo2hnq34tlBVbqcUAbtHB5rfblhQ6XjCeTbUQXlergOJzq
 HYE3HcGmn8pAM5Y4qoM6pA1RCr1IyItL3AuusMM5O5uLkHpNvlXARHUDid/+4YHMTwnN7z6nNzj
 xOvRT8ozA4warKSkdVSr9f7VXXIvpGtLJWOkg1Y/iLt2IWim1q5fHhY+eo3JJzN9g1PuJyXfn+u
 lUahi2Z8O+3rpAhCrK7FAzD4PDhMbN6pUCQsyrkS4q13VO+QVP0FgowyhjSLxP5e8PrnynQ==
X-Received: by 2002:a05:7300:6da2:b0:2be:1cb2:3a6 with SMTP id
 5a478bee46e88-2be4e0d053cmr4427230eec.33.1773067718360; 
 Mon, 09 Mar 2026 07:48:38 -0700 (PDT)
X-Received: by 2002:a05:7300:6da2:b0:2be:1cb2:3a6 with SMTP id
 5a478bee46e88-2be4e0d053cmr4427214eec.33.1773067717848; 
 Mon, 09 Mar 2026 07:48:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 10/35] target/hexagon: Add a placeholder fp exception
Date: Mon,  9 Mar 2026 07:47:57 -0700
Message-Id: <20260309144822.877695-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OC9RUsuwvgrrdecfnFNWZ6lFI4OKXQ2p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXyKKdo90WGeWo
 llIF5nO3C6M2l7/Ap0uWjRFWqz9Om4wvryRokDN8VzjtkJ6i+UujceBFRT523DfkbVW+cf7NoMf
 AvT45qEumuZNdvwxE/PFqrThBwRYW7vgbKXPq6pg5D4p623oEEQrT0WsYjlojEp9BzMbyiiZBvP
 VE2ehyH0QI0Y2uQ0V1TWOUhPmVrBl3DNxK2GlH/5m/KzZS3j7eNa4YcDsKKOzqd4iMwnacCoeP0
 a5IhI2Y7Ve2BARw5cDzh+hlkJPYCI2iXyt7oBA8mVy7CEYxqwcX06qmCY0ZJ84qUHiLW/3jUDrp
 te4dtGBewOHzdjKbvhf7lhadlzWz5G+ekDkeVUKHExWZNFj5QGg3G6XY3BY7sa+nvI4/wyudAY5
 poFFSAcn+XS8oP3XHbNCYwLsJbPd9s+KFuWz6xqapa4ag+j7ZgM1+rNsszwnO1XaS8QfV0WPBBx
 oCXPO7iiGicUzWiwl6A==
X-Proofpoint-GUID: OC9RUsuwvgrrdecfnFNWZ6lFI4OKXQ2p
X-Authority-Analysis: v=2.4 cv=F8dat6hN c=1 sm=1 tr=0 ts=69aeddc7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=R5LHHePp8dzqxDYlWrYA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
 target/hexagon/arch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/hexagon/arch.c b/target/hexagon/arch.c
index e17e714a6ac..0a400bf7a77 100644
--- a/target/hexagon/arch.c
+++ b/target/hexagon/arch.c
@@ -208,6 +208,11 @@ void arch_fpop_start(CPUHexagonState *env)
  * model it in qemu user mode.
  */
 #define RAISE_FP_EXCEPTION   do {} while (0)
+#else
+ /*
+  * To be implemented.
+  */
+#define RAISE_FP_EXCEPTION   do { g_assert_not_reached(); } while (0)
 #endif
 
 #define SOFTFLOAT_TEST_FLAG(FLAG, MYF, MYE) \
-- 
2.34.1


