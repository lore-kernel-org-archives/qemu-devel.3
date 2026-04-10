Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22743F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5t-0006sk-DB; Fri, 10 Apr 2026 13:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5p-0006qs-TV
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5l-0001g0-TT
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:32 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AHCYeG1498589
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6rsaGe+qyX7
 aGhkX5jlvph/v3y8P3SaLT96OgXBeU9M=; b=DqJ0BiVyla3DjSDPAZWWjcfPFqA
 WZd+oUWFg9raR7D5D/HxocVbrWQhAZ5ZTVfIOp2H2gMOxx5dHLCwWiZHT22TUWSH
 LE3NvaMne79T11pqVR43NY6bpCOOeTrRQ5mFJ1YT+TobEY80GXpnW7uyTXgPgI5Y
 4oGIQlwi/DwqAae9ndUbyOgzzKUw04LDqytD/kSWYE11SuZJJqtNEc+j2x+gxv+W
 RrFANwqPhmpkeB2xM8zvWtsRjB7nIuFpxJ73t4CbTvvnIfakoxY/1Hndm2QeTnGC
 f5Fsue7gpgRHu+nNpMuQglSWb+7r5ameKn+evMC9SFWap6cokLKBfp6OtfA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey5b1ctg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:21 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c20a91932so4749161c88.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843781; x=1776448581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rsaGe+qyX7aGhkX5jlvph/v3y8P3SaLT96OgXBeU9M=;
 b=L45p8A9lbgMa5mDOg60mApSVFdPChFremC29Yw/ehqKswBahpCSXetaBO8BthowMba
 aJBLxRkaZFcBB4DxOLoLF1fl6tH3ahKEzR9aQDpfLwukMa6W7Zvp9Ya+41Rv1OveFJn2
 r6sUTD6Lbb4QJ1KmUBz23s5NoNWNQfL5M0wtec0wRC1dSXT5oPSJTORkFAdub3cd2Xuv
 9jVCkPrcwafT9/Gcdeh+C28v8dH9EsKGneoyXZwgmIPBR9m20V/C0eitTshnMNG+wyEK
 4k6KycIENxX3pj1xMhlw5yL0Qu+6eYoSR4Bkl08dh6lFkm2RRXmBu/ljZwsi6HzTHlZf
 SvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843781; x=1776448581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6rsaGe+qyX7aGhkX5jlvph/v3y8P3SaLT96OgXBeU9M=;
 b=h6+fXdw/oVTeVRn1xWLTUI17HlDvb7YdOcUwS7eYCddt3EbkIx7iG5RvtYIjC/cmqd
 bBwb2WOoMGMneVKCdfHioxVUQfCjE7qCFqKmXP1a8yip1x0eXoRN1En5lkG7gYrHTeD2
 eALp+oH5PlHw7PlD5pT559OGSoDwyjF4DhaNtrIZXEMBZlmd4TVKm91Pn2FzkjKynL0W
 T4JT8Vpwy4QxOgH9ckn9HBNZyGQOE5jfOaWDG/i/onBYtD8lscj7f143ptPbTlIs+qA2
 DBYd7vDR9HkC+x6lJdO3txZt5AYy/TWwhUk9NMiB1BPeo4Z0hDDSBacKayK7wSgH5stH
 CjSQ==
X-Gm-Message-State: AOJu0YxsS0HbaGSjQyjr4/DpcUwvZRInG4BFtinHPeUC8W3LwMM/9H/2
 7EJ8FchFzI4lMhEL7IqVzogWkbL0aVxmUX2ALqKHDrV3I2qzqpjcv1iz+70xMra6MTY/NFHOKWh
 LWo7nYZ8umAFM6kT/REANIq9ARSXlS4Pa/gMwoFsJ/1vBJhxug2Ysf0otJnLSc3/Wi3JF
X-Gm-Gg: AeBDies4Qa8DuATfjdSCBGAxS5j7Q3ewq5wFspLaFkeoCwcAuTta67LhTqMntMcgEKy
 reZtUmvQ73SOWSywdX6c1NlijRt7qDuOdv0afciS7DfLl+YqVkC5gG4tDHVT4nvMiedv12K1uFq
 kKAOv0r69wmW7D/hKgpwxJhvLbVWMzqgIbXHOMdX0vIV0978zrTS2hGtwiAFUb3xg2NkMssw6LG
 16UU4SDnPvC8+cMCywhTnFeefIqXtn5ajjpPi4W/p3jjsJZWVtJZm2pw7nl/6KLjLc03fpvGFRZ
 as8bOAX58FZcA7v8VJhVaf6VwAEm7c8VEb1qOnr9+tMt+l7b2zvERzkF3NdpKTOTWVx6qkQsjvy
 yHNYJvZFwe1SzOuu8dYC2SWZoXfHljYxubUWsSayrCDGNBP7imDTN8ImdtyI+03RUvOM6ufQNeN
 rCbVeR/CAZ
X-Received: by 2002:a05:7022:3d08:b0:11b:ec5f:1c37 with SMTP id
 a92af1059eb24-12c34ecf745mr2677316c88.18.1775843781152; 
 Fri, 10 Apr 2026 10:56:21 -0700 (PDT)
X-Received: by 2002:a05:7022:3d08:b0:11b:ec5f:1c37 with SMTP id
 a92af1059eb24-12c34ecf745mr2677296c88.18.1775843780564; 
 Fri, 10 Apr 2026 10:56:20 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:20 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 13/16] tests/hexagon: add tests for v68 HVX IEEE float
 min/max
Date: Fri, 10 Apr 2026 10:56:01 -0700
Message-Id: <08abae5ee53c81a1a61b776e4d0a7b0b91d6d824.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Z4c2oWp4Nu3mNgXLPk9sQNbopSv86Rmr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX5E4N1ezN0Ida
 peeIV+6ewQTqzPEyrN3dKI8yQjPplI0K8vTWrLubAyvJGgeo/wItNDvwmMSgYwUlUoMRM7cRs88
 Lm1wwxOmW+TWyA7vLTn6pDJKCylpL9GlFpue5wBXKpz/M88huX442ovb3g8yCR4OaY1kP067aCt
 tDOtxTzMt0eLZSY0mM+/Hhu7pcR3dmfTDeFDv2y+tGcaUn4jmVqk3D77ORlaqAfAfPIuju0I0/1
 8sIEg9IDNaUJo30YduxFQu2dleFf8qLqUXhQ13YawOqShoN+29jGtX+zAP8GU+LKQbc2ppJ3vsi
 JZu5Py/UU4l9UQZZ/QlC4ffPqU6xXdFDm5zrRBwGy0233nNnxx9BWLLnbpNDmfDK35X+AOpT/zp
 KSlsU3dX3cdEIKkgWfWlyjO2nzVdx8du6TZ8LpQGeWp3ji1gQ9vkCWu8tVKoe/YtGvK6gRJOnPE
 c5NjEETvXXcCs+iYd7g==
X-Proofpoint-GUID: Z4c2oWp4Nu3mNgXLPk9sQNbopSv86Rmr
X-Authority-Analysis: v=2.4 cv=VsgTxe2n c=1 sm=1 tr=0 ts=69d939c5 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=gVZ7t9wPRZXE4v3XZ3MA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100168
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/tcg/hexagon/fp_hvx.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/tcg/hexagon/fp_hvx.c b/tests/tcg/hexagon/fp_hvx.c
index a309654ed7..dee0781bd7 100644
--- a/tests/tcg/hexagon/fp_hvx.c
+++ b/tests/tcg/hexagon/fp_hvx.c
@@ -73,6 +73,30 @@ DEF_TEST_OP_2(vsub, SUB_HF, hf, hf);
 DEF_TEST_OP_2(vmpy, MULT_SF, sf, sf);
 DEF_TEST_OP_2(vmpy, MULT_HF, hf, hf);
 
+#define signbit_fp(X) \
+    (sizeof(X) == bytes_hf ? ((raw_hf(X) & 0x8000) != 0) : \
+                             ((raw_sf(X) & 0x80000000) != 0))
+
+#define STD_MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#define STD_MAX(X, Y) ((X) > (Y) ? (X) : (Y))
+
+#define MIN(X, Y, DEF_NAN) \
+    ((isnan(X) || isnan(Y)) ? DEF_NAN : \
+     ((X) != (Y)) ? STD_MIN(X, Y) : (signbit_fp(X) ? (X) : (Y))) /* -0 < +0 */
+#define MAX(X, Y, DEF_NAN) \
+    ((isnan(X) || isnan(Y)) ? DEF_NAN : \
+     ((X) != (Y)) ? STD_MAX(X, Y) : (signbit_fp(X) ? (Y) : (X))) /* -0 < +0 */
+
+#define MIN_HF(X, Y) MIN(X, Y, NAN_HF)
+#define MAX_HF(X, Y) MAX(X, Y, NAN_HF)
+#define MIN_SF(X, Y) MIN(X, Y, NAN_SF)
+#define MAX_SF(X, Y) MAX(X, Y, NAN_SF)
+
+DEF_TEST_OP_2(vfmin, MIN_SF, sf, sf);
+DEF_TEST_OP_2(vfmax, MAX_SF, sf, sf);
+DEF_TEST_OP_2(vfmin, MIN_HF, hf, hf);
+DEF_TEST_OP_2(vfmax, MAX_HF, hf, hf);
+
 /******************************************************************************
  * Other tests
  *****************************************************************************/
@@ -150,6 +174,12 @@ int main(void)
 
     test_new();
 
+    /* min/max */
+    test_vfmin_sf_sf();
+    test_vfmin_hf_hf();
+    test_vfmax_sf_sf();
+    test_vfmax_hf_hf();
+
     puts(err ? "FAIL" : "PASS");
     return err ? 1 : 0;
 }
-- 
2.37.2


