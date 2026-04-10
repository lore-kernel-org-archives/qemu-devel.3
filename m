Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417C0F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5a-0006nW-Qy; Fri, 10 Apr 2026 13:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5Y-0006mW-Hg
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5V-0001Xb-DO
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AAKDwV2698454
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nOvzeWfo1gz
 MP3it2e0DgF8ZBLHR2ZVPC9oC1yks6l8=; b=RFVXNgcJHHkNaeIM8Sw4bUZjY17
 Qj88nXrDq35lQDyfQKjrUlgJvTGT1SYRH1sA10lbhuGtoUdVrom39u1gwqWOVSKx
 mbng/5wfPzSX4dDxRhPe2VLQyl9A88+piPPIf6ENgPMStJJyqO95izo5EOHVb79y
 o4xggLo7ecPYkdLnUjOzEl+R5gp16P4onDa6t2HmFJH1yBi7gQEzXqQpjrT2eUoM
 0xRbbU1x04Lhiez8D1OMeYwzjq+jolqwOcOv8sV5XiWCzG+vIlioxqUKpNNYzice
 dC4trALNXV/But3Z4gv7+20KfZvnRHcHT9NBVmLtCNHiWCycq6fForotWEA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4degt9v4hj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:10 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-127133794b6so13615424c88.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843769; x=1776448569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOvzeWfo1gzMP3it2e0DgF8ZBLHR2ZVPC9oC1yks6l8=;
 b=CVxDgyrCItlOqhjOOAwFcXNyoKaxIIj0HvI8s53szAY2NMzeC83ybY9XOoTqEMk6oB
 PNiXYlK7SDw3rASVv9kqAl5CffGyTJYQ1TyOaDkX4uz/lW43aWR18/XGTOWJmmnPhIll
 Zdn/DrSinG1JIw+CZYUSzjUuvNpvN+k9ZF7MZ0U/1lDuRkmkwLpWl2dsUfdrP6xboIJV
 t0KP42S/xqmrhxfm5A278Sxv/aSuQgrNjK8EGJcokKHe74D4Eedy5YukGPMcD0NRDBKJ
 obNRtA0DLpe3oL37c/L98K1vzMdKudrUPOWtiWl4haql8bZ3+a6i/6zBJMFvD/ib7916
 hYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843770; x=1776448570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nOvzeWfo1gzMP3it2e0DgF8ZBLHR2ZVPC9oC1yks6l8=;
 b=b/70/NlscFAJeLvkqRwpxJ5J0oria4Tnk+9N5M57vK5Pe6/K75DF2+3Nl4gpnyk9DD
 NhtH1xRxc253voJd7TsTOevc3DXgbBHZ5A09yIGL0oSm7S/oRzLezDsi0WE8MjtFHB2F
 ZZbXGybV0aveasFADbFtHHEe9ztzaRJ/aJZuidr/jpzbWLd6KdQqEWeGKfIbvQy2erX8
 MNTtLpwkS8g1w83YuGGap5hxKBHXQrxO2mqo3KfC3DbDqNoN/QbZw9LloNv06I8ZfJbx
 wG2MKMxhJ0xxXBxAKxhCCFWRXV/e42O/t9aoFB2Y/NrZQl2SrFVeBwbvGgzjY0XWt3Pp
 Rmjg==
X-Gm-Message-State: AOJu0YyzzdeMBja+QiNMCXz49JiWL5n0Mty8ijwG3ker/kOadVbSH7Z2
 LMDxNVa0bQBfNwaIm4EhyIZxzEdPgI+zgLJXOW/No1/DeV/oIt97MB9o05skOdDtx54F59kFanJ
 GizWSjq5E8gm+1pkso6CpjKRPkZzW+Ohea1kI5FjOE2AaGAGCBa4DTSN+fNnCyB5CBrG8
X-Gm-Gg: AeBDietTLiH63OGQNdFoeaqB1JNrAhk4/LhNonGhWPnKjgmtwx8mYyNinCg5UtbKsUC
 BIFmPrg9wwO+ts6jarwm1ZDnVcnivcMY5I5gAt71mQS6C/wNpRhFlrLIF2057b7UTZGgma2+7gO
 xwEANS370ByYZaQq3sSAimOGpckaxKUdBlri80R1T7LnwWLTG5LHtNqwIRjxCLySf68v9IdPG/P
 sbRR17JRwCGrqKPCM2GnXm8Gn1KUg6eQTl81gImv2eC0bYGcjRGfRB0w55j3L86kGOFdi/9RO9u
 ky4iqPsm3R3lofXHIU5a2+CKO8kwkPi2q8S3Kk3e0KK5U8M6fyZH+KYwt+V4JgHh8zpViUavel9
 alj9pXwCcGh6XzPz4baxW/SNqUvx2v7fOaLfFs6fUhph0Db+6OjBTzXnjQEhTRewjIOmkaAukLZ
 xAFh3pI4md
X-Received: by 2002:a05:7022:ec07:b0:128:d3de:c9e4 with SMTP id
 a92af1059eb24-12c34ef7f15mr2346151c88.30.1775843769357; 
 Fri, 10 Apr 2026 10:56:09 -0700 (PDT)
X-Received: by 2002:a05:7022:ec07:b0:128:d3de:c9e4 with SMTP id
 a92af1059eb24-12c34ef7f15mr2346121c88.30.1775843768686; 
 Fri, 10 Apr 2026 10:56:08 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:08 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 02/16] target/hexagon: fix incorrect/too-permissive HVX
 encodings
Date: Fri, 10 Apr 2026 10:55:50 -0700
Message-Id: <b9a5a46b82e804d3c1cbeff678a9871a2b25a900.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX9yLIMnW5xLEy
 ClOfN2k+0QrwY+uxDD21to5Whr4yjVHyyiZtxhAJs9rpwjJT3GRzZqq+EkHAz0TFnfPNRg1HM+j
 O4WVQHgfpTXPlq/oUfkuAIy/x2YrqhOkbH1WIGF7+XZ1Z72NZucZWrjUJRRh2zEJc1TTcA/oSAd
 fLdONr8FY+ZmzPVV/82F3Qhpsn4dBIovb3L4IOOl/ZX5OV7Ieigxuu9PTWduc3eVIkhIR9GzBkh
 UvFVtJ4nBeiL3izWfndP6W2JP8SnPKwufqECH1jXt7Qi0c9JlF1GECpcjm1EMuDv4MWUn3O06vv
 A8qiLB6RWIHGcQ+d7QxjciF6vWjZBP9pHLFYKM0vsg1B1V/IePu6fFZGES7orIiPpGvOpO5A2bT
 obzWK1uRwBZ5UOKBEszbKR6YG5uQU0Vu3Ke43iqDdSwSEvj7fVU8eUDjHkZ6izbsI3aWwJv074+
 kZBJmpxEo+WvgN8Balg==
X-Proofpoint-ORIG-GUID: A1LO4U7Ba-7U5SvETsorGkksL-W0UOA0
X-Proofpoint-GUID: A1LO4U7Ba-7U5SvETsorGkksL-W0UOA0
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=69d939ba cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=LtKSMYrkcOpncNoavBoA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100168
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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


