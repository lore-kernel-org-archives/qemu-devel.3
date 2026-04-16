Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A53F8A15F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL4M-000598-03; Thu, 16 Apr 2026 07:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL44-00055q-7A
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL3x-00039c-Vr
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:19 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G9MsGW1553030
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nOvzeWfo1gz
 MP3it2e0DgF8ZBLHR2ZVPC9oC1yks6l8=; b=kd+yOI/DlCOOPSx78bzLIcGKQVB
 QD/8tn2+9BAfDt/qZ6jV3S/+4odZROWfEd4vOYk9Qz4V/O2+V+568X8KclcwNxxx
 oDl/Wp1ET/jxK9kDjaqxZpNpw7te7dc4TVmD6CNcYZVW9SSHZQb3QZEkEci9gsrL
 qF2xCErCn1a2KiwfqvAcAl+cdhuTUtxH8TRKgaFhhBmKaikiB+ubbmD8t9uYw4Yq
 9yf18PEbI4jt1sRh/hDGLR84mrbqvxPP9AS4QRtIb6jZTw7hJQitiTJnGFXQJoh2
 wMtSgcZatIAoBDIFQceXowtFt2ZgkdSiBNh08jkvjN/d9smYgItT/mB6wZw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djrsn9g8e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2cc75e79b97so30180062eec.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339551; x=1776944351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOvzeWfo1gzMP3it2e0DgF8ZBLHR2ZVPC9oC1yks6l8=;
 b=JE82crSqf41hOsj5nRs6MzNs5ZvghjggLLsAjWM+L/L/osKO35PupNADcKi8pupVeu
 d3iWwUvT1hCwhawXfw3/HWN57VtMcm0mwoK6gA5bN6JthzfUN/Z3H9aY98mrPEZM0i5f
 UxruqPP1WG/gm/T/+YVjgTyNiZDuv6i+Ekh1C41Kyu5fQ2+Knxa/+/BcxygQMAwVLCBl
 n3L/u6mXP9QZQyfy++h0EW3hcAMMei7wlKafsg1Z2la2yrhSLp7vh65BZTU6U/QBOf7+
 7W/2+RExr5wMbWBtdBoOIYIzy0uI4J1qR/snQQvgVUAO4i47iHJXTT3hjyMX/nqzY1fA
 JWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339551; x=1776944351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nOvzeWfo1gzMP3it2e0DgF8ZBLHR2ZVPC9oC1yks6l8=;
 b=BGcsrUWDcLJKPGtObsslr2Fku80GhyFYxptWAfCtqkno7VeOnpFsyd4fWJrIGQ/bdx
 EdU94DLclj3BKUjZBw4EavSguRRbP9DvD9A0CNRFn2jYMSvE3rruV/COMu/sM4gY7BRG
 uFPap1nE4eJK7PYc/DdTWFYWHxmi7tjD6t/q69q34G1N+5hayfpvm9y6HCSvWBZgtUiw
 pMQzKpCvlCWgH7ekgyN0cou8zAQmng032tdyMWRddaFjoNCVjVrwy+TLP4c1i7oPbSr4
 jVkqRt252s5IgSh7yVAD0jWcC8NxhBP4kApBIKituctRjdYV/OwNxsxKiWaeX4/mysyF
 aY9A==
X-Gm-Message-State: AOJu0YzPC4+uKXf4g7/NDKIjXBojmvoHk0MGMXU68OPlAKKkIwIh5pVN
 grrZJ1tGH+qzRIJzqR7TE5u1w7emcvH+GRvijgc5GEHyb+22KVVa7LmDNTbjhZ6p36diHpMb0sY
 AD0DA6vjbcMLFnw7iEULiafD7nmgV0zSOiEmYE/KRL/4QJkKi9LdFDVwg9Rq870a8XA==
X-Gm-Gg: AeBDietOexvrfnJysJ9SLysCsxLp1NuPYOHyBtbNwjn38C/I9SJT/84uRyxKALQir2+
 qJFADI6PKPQ2kijYKjebPewFCwCvo8+qHSBUYgypQVcgqki0llGgz4tC45gxTBR4mNG+RncSBGX
 Z5Bs+FhjksFpwhv6oIj3nKwbRyyM+m0Z4zjrTHOgjfyx8MUBDuJ/7Ndk4J6HJ1iFppyA8qES/cc
 bIjcs1AuqSftddbRXv8/1ZUHSbQfk9gOOx2hdJA/EQPLvJgBVjXmD3lAaGZ7f29RsB5mqkfOuLd
 YvngnjDG37bPtH/gQxjSZIciGR6U2JlXlJ/yBQlv81N0inKnPSByfFsSTY3eY8SAoHiL02wUSFJ
 JhUVW8lDMSk/9yR43PL7f917M7QcTC7oOwe96IyjUfCaAfSACqdj7jmCW9NFVsw/MJl/2BWoUOr
 e/QpRPsX3fvhz/3XPZoKE=
X-Received: by 2002:a05:7301:4089:b0:2be:a2d8:e9e3 with SMTP id
 5a478bee46e88-2d58a2a171fmr15870406eec.29.1776339550804; 
 Thu, 16 Apr 2026 04:39:10 -0700 (PDT)
X-Received: by 2002:a05:7301:4089:b0:2be:a2d8:e9e3 with SMTP id
 5a478bee46e88-2d58a2a171fmr15870377eec.29.1776339550181; 
 Thu, 16 Apr 2026 04:39:10 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:09 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 02/16] target/hexagon: fix incorrect/too-permissive HVX
 encodings
Date: Thu, 16 Apr 2026 04:38:51 -0700
Message-Id: <1fe4b8a0fcae6705a591b1b5131e28f6d8062eed.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iUxAs-26Vxmz30I6rDlQ9G6bAjVN4sd2
X-Proofpoint-GUID: iUxAs-26Vxmz30I6rDlQ9G6bAjVN4sd2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX1jDNb12wB7eX
 90T+SkaV9F8UeX8pOphEJ7z7NIsAHu/O8n9gMclS4JZ/ilZKFEnhbKa3l1IqZpX77yUm29JLp0a
 tj5QM1fhbY2UsuWZFOtq6aWw9kRmHz0XqgDgNabDESkBzl3Bn1YvVA56uAIwHbVYMa8yCwWNOWO
 r/+rHwUg7DnywU+Xlna93E6lZ/jj6yv9wx7u8bZQFwc85/q2otxZx7liJTS8WGJ6P4jdZuYwL5e
 7WqiZlN+Pk+VgERhpbwlN1T84ssnRWEQYSD727N5M61EiCuWKtHYxznjSnkaa9Gc1qUwDpA+FN6
 sCF6o46iDqdc382SIfu1QEWHmL5EmREqwabtULVd6PetdcDvUaOy8kW0jslA7AAmpRxNO7fMS2S
 znnQwwEDCvOa0XbqGNkebIrl/JBRzF284YHbP7mZCJYRkPwH/ASlUIOqBEI7eVYzK7YT6I8kpKv
 EcRAa2X3yahev962IbQ==
X-Authority-Analysis: v=2.4 cv=EojiaycA c=1 sm=1 tr=0 ts=69e0ca5f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=LtKSMYrkcOpncNoavBoA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160110
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following encodings have become stricter since v68:

    - V6_vunpackob, V6_vunpackoh: ---00 -> --000
    - V6_vaddbq/hq/wq, V6_vaddbnq/hnq/wnq: ---01 -> --001
    - V6_vsubbq/hq, V6_vsubwq/bnq/hnq/wnq: ---01/---10 -> --001/--010
    - V6_vhist, V6_vwhist128/256, V6_vwhist128/256_sat: ---00 -> --000
    - V6_vhistq, V6_vwhist128/256q, V6_vwhist128/256q_sat: ---10 -> --010

Pre v68 compilers, by default, already use "0" for the non-specified bit
that changed in v68, so unless someone is manually writing the binary
encoding, this should not cause any backwards incompatibility with
pre-v68 binaries.

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/imported/mmvec/encode_ext.def | 48 ++++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 402438f566..6d70086b5f 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -647,36 +647,36 @@ DEF_ENC(V6_vsubububb_sat,    ICLASS_CJ" 1 110 101 vvvvv PP 0 uuuuu 101 ddddd")
 DEF_ENC(V6_vmpyewuh_64,        ICLASS_CJ" 1 110 101 vvvvv PP 0 uuuuu 110 ddddd")
 
 DEF_FIELDROW_DESC32(        ICLASS_CJ" 1 110 --0 ----- PP 1 ----- ----- ---","Vx32=Vu32")
-DEF_ENC(V6_vunpackob,         ICLASS_CJ" 1 110 --0 ---00 PP 1 uuuuu 000 xxxxx") //
-DEF_ENC(V6_vunpackoh,         ICLASS_CJ" 1 110 --0 ---00 PP 1 uuuuu 001 xxxxx") //
+DEF_ENC(V6_vunpackob,         ICLASS_CJ" 1 110 --0 --000 PP 1 uuuuu 000 xxxxx") //
+DEF_ENC(V6_vunpackoh,         ICLASS_CJ" 1 110 --0 --000 PP 1 uuuuu 001 xxxxx") //
 //DEF_ENC(V6_vunpackow,     ICLASS_CJ" 1 110 --0 ---00 PP 1 uuuuu 010 xxxxx") //
 
-DEF_ENC(V6_vhist,            ICLASS_CJ" 1 110 --0 ---00 PP 1 -000- 100 -----")
-DEF_ENC(V6_vwhist256,        ICLASS_CJ" 1 110 --0 ---00 PP 1 -0010 100 -----")
-DEF_ENC(V6_vwhist256_sat,    ICLASS_CJ" 1 110 --0 ---00 PP 1 -0011 100 -----")
-DEF_ENC(V6_vwhist128,        ICLASS_CJ" 1 110 --0 ---00 PP 1 -010- 100 -----")
-DEF_ENC(V6_vwhist128m,        ICLASS_CJ" 1 110 --0 ---00 PP 1 -011i 100 -----")
+DEF_ENC(V6_vhist,            ICLASS_CJ" 1 110 --0 --000 PP 1 -000- 100 -----")
+DEF_ENC(V6_vwhist256,        ICLASS_CJ" 1 110 --0 --000 PP 1 -0010 100 -----")
+DEF_ENC(V6_vwhist256_sat,    ICLASS_CJ" 1 110 --0 --000 PP 1 -0011 100 -----")
+DEF_ENC(V6_vwhist128,        ICLASS_CJ" 1 110 --0 --000 PP 1 -010- 100 -----")
+DEF_ENC(V6_vwhist128m,        ICLASS_CJ" 1 110 --0 --000 PP 1 -011i 100 -----")
 
 DEF_FIELDROW_DESC32(        ICLASS_CJ" 1 110 --0 ----- PP 1 ----- ----- ---","if (Qv4) Vx32=Vu32")
-DEF_ENC(V6_vaddbq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 000 xxxxx") //
-DEF_ENC(V6_vaddhq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 001 xxxxx") //
-DEF_ENC(V6_vaddwq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 010 xxxxx") //
-DEF_ENC(V6_vaddbnq,         ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 011 xxxxx") //
-DEF_ENC(V6_vaddhnq,         ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 100 xxxxx") //
-DEF_ENC(V6_vaddwnq,         ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 101 xxxxx") //
-DEF_ENC(V6_vsubbq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 110 xxxxx") //
-DEF_ENC(V6_vsubhq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 111 xxxxx") //
+DEF_ENC(V6_vaddbq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 000 xxxxx") //
+DEF_ENC(V6_vaddhq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 001 xxxxx") //
+DEF_ENC(V6_vaddwq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 010 xxxxx") //
+DEF_ENC(V6_vaddbnq,         ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 011 xxxxx") //
+DEF_ENC(V6_vaddhnq,         ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 100 xxxxx") //
+DEF_ENC(V6_vaddwnq,         ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 101 xxxxx") //
+DEF_ENC(V6_vsubbq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 110 xxxxx") //
+DEF_ENC(V6_vsubhq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 111 xxxxx") //
 
-DEF_ENC(V6_vsubwq,             ICLASS_CJ" 1 110 vv0 ---10 PP 1 uuuuu 000 xxxxx") //
-DEF_ENC(V6_vsubbnq,         ICLASS_CJ" 1 110 vv0 ---10 PP 1 uuuuu 001 xxxxx") //
-DEF_ENC(V6_vsubhnq,         ICLASS_CJ" 1 110 vv0 ---10 PP 1 uuuuu 010 xxxxx") //
-DEF_ENC(V6_vsubwnq,         ICLASS_CJ" 1 110 vv0 ---10 PP 1 uuuuu 011 xxxxx") //
+DEF_ENC(V6_vsubwq,             ICLASS_CJ" 1 110 vv0 --010 PP 1 uuuuu 000 xxxxx") //
+DEF_ENC(V6_vsubbnq,         ICLASS_CJ" 1 110 vv0 --010 PP 1 uuuuu 001 xxxxx") //
+DEF_ENC(V6_vsubhnq,         ICLASS_CJ" 1 110 vv0 --010 PP 1 uuuuu 010 xxxxx") //
+DEF_ENC(V6_vsubwnq,         ICLASS_CJ" 1 110 vv0 --010 PP 1 uuuuu 011 xxxxx") //
 
-DEF_ENC(V6_vhistq,            ICLASS_CJ" 1 110 vv0 ---10 PP 1 --00- 100 -----")
-DEF_ENC(V6_vwhist256q,        ICLASS_CJ" 1 110 vv0 ---10 PP 1 --010 100 -----")
-DEF_ENC(V6_vwhist256q_sat,    ICLASS_CJ" 1 110 vv0 ---10 PP 1 --011 100 -----")
-DEF_ENC(V6_vwhist128q,        ICLASS_CJ" 1 110 vv0 ---10 PP 1 --10- 100 -----")
-DEF_ENC(V6_vwhist128qm,        ICLASS_CJ" 1 110 vv0 ---10 PP 1 --11i 100 -----")
+DEF_ENC(V6_vhistq,            ICLASS_CJ" 1 110 vv0 --010 PP 1 --00- 100 -----")
+DEF_ENC(V6_vwhist256q,        ICLASS_CJ" 1 110 vv0 --010 PP 1 --010 100 -----")
+DEF_ENC(V6_vwhist256q_sat,    ICLASS_CJ" 1 110 vv0 --010 PP 1 --011 100 -----")
+DEF_ENC(V6_vwhist128q,        ICLASS_CJ" 1 110 vv0 --010 PP 1 --10- 100 -----")
+DEF_ENC(V6_vwhist128qm,        ICLASS_CJ" 1 110 vv0 --010 PP 1 --11i 100 -----")
 
 
 DEF_ENC(V6_vandvqv,            ICLASS_CJ" 1 110 vv0 ---11 PP 1 uuuuu 000 ddddd")
-- 
2.37.2


