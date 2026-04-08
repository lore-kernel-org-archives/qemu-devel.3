Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FD510F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYcN-00062i-Pa; Wed, 08 Apr 2026 15:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAYAD-0000zg-CU
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:02:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVu9-0006qB-MF
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:26 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638GH5XV4049231
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=P5hMle4dsIJ
 uY/9/X8rZbjNfzfN97R2T6TLhakQh8Ec=; b=F2TziBW5CqikxfFFlyEsXqDnoPz
 GqQaTbtop4BHDU4Jt4OND40X5NqcmrHvZN5gWRswsvrYU7uYjAmfHAueYoCapx5A
 E2xHZKWgpHrPuKGpGCWAlr2iFipdOLkFHR/Ck3UKVXCCvhFN5AmPifixq7JPW6l2
 XPQZqHRB5BQta4LncfoWVMrRXA/sFJ6H/sIUXG9Rzwk8csVui3ua+oBh1RLm0nex
 /vjri0DdsRHVb8Sy8Fw9to75sKqF8ptfNcP4r+meYXyIme55qmNyK/svnMsVRsEU
 e2myGeCPAesH7PWlHMeBzob8niM11udvRHx67gIdvivKsTmc0c04k6c86xA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtd70217-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:24 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c70ea91bfe1so36514a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666244; x=1776271044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5hMle4dsIJuY/9/X8rZbjNfzfN97R2T6TLhakQh8Ec=;
 b=FD76xUuv+j1GhOEzl1hi+qnjdhlz4DY+y7R+J7GtnV7Gs4WZuTnvCuUzOuOuCNgV74
 0vsUfwz2nhaYSZleQTuBaKshF0/P0dfdGXP4SrH/+GvB57l4AEbGZLVsBNKCypnd1fyS
 MQ1iJjstKxkAhh5veeNQN+ULpoQXDVyFgZfc2fP3+5SplGcBvecI4You/M+vMh8xGzHG
 4yXC3bxnaLUJTlfRJQsHMpGc6a7vR4XEpMKC7CfYYbNX2qCYrgYZ1Fr6ZE8yu7CAdV78
 VBBySFvGW6ER6ju82stO3llHN11/NW0E79DP8X5JgHqpXS+Bx+kPvFV9BBx9Rh3uWn3E
 T5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666244; x=1776271044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P5hMle4dsIJuY/9/X8rZbjNfzfN97R2T6TLhakQh8Ec=;
 b=hWwEV4PgbazcMPRJhl+0Gpfq/l1vKUxWM2maWKS1L8ppa50z5M2f+ExHe2DkIKqSJt
 9F8GJ7K714E6I0xBHPa/cuL6zJH1k2ewj06LR30DVVajXsLVpjskXbhV92clZuWBlF7e
 ak+uIYqcjPoNsVUzsFxystLuDD5gWwvINXtw2/dkFRaUtJnNQTXBWfeXdO/mD5+XLfaC
 pRZ+gEr/eooQKceQIXAO5si8EEg/QTqKl/yIfwENVFYFjbmGOtMiYjz58uJu3px7YaEi
 cOskQS8QedRQzWcFjL5UGm0w+KPAFjVILMVRdFdH8/RND1HRM6dbC66XLu8S5aOXBvrX
 1lbQ==
X-Gm-Message-State: AOJu0YzxImyrx6gezyhLDNJaA0n3jK6hRL3uhrKjXq/D8E38kuPwavgc
 MwwgTocNIEDdKt/L6pueFFnEfD5YVsVLBnuyFcyi69Dne4911eZ331ZeZd6fh8YM9x/1pZhS/MF
 kSa/C3hgc/aZDYb1xdAAopppq9DSbCK3LUZ9z9etqce9MvhstpN6JKUtW5GfEeRZ/0NRO
X-Gm-Gg: AeBDieu7Qn2C4MaxiWHftsQt90f/plNaAtCEj9olLe9eYjJUFK5qKecDg7bzGjxyCXK
 9PGBCDWupyGYwTGTIs/x7iO0+CGFaZDN4qgBnRoNdH9zUzLBbjElWw0m3cyDhmE+wpUWXw27Pe9
 Z5l5SCkwVFfBBw0XJZ6XcwLdXnu5GjvMYRnBLBdwKTKc4YQVlqGJ5QOscuJC+YMYPbvNqw1jVcY
 pUxb47t4HUt+UDKgu3RF+uBbHAxFhPsRAX6fIktiKRR0sbiANMCMhMj/mBwFegxbCKoTE0FXFLa
 Ja3O0WRqsN7jlEwpuP6a4XcNUvOKnm7sBmBKakOFRFy//kfCc2LNjrjDQOkmN+I6Mr9SQDQqjXb
 uvrAIb3RdoAjX25wYU79Ib2F95Z/ZdcfKDUFzhF4E7cBNvBdhIYYpvw6LAOD9Eq2FGJ1D2BsDi9
 hlIVGgAPtz
X-Received: by 2002:a05:7022:239b:b0:128:d494:a1ab with SMTP id
 a92af1059eb24-12bfb71138cmr10288981c88.15.1775666243568; 
 Wed, 08 Apr 2026 09:37:23 -0700 (PDT)
X-Received: by 2002:a05:7022:239b:b0:128:d494:a1ab with SMTP id
 a92af1059eb24-12bfb71138cmr10288953c88.15.1775666242716; 
 Wed, 08 Apr 2026 09:37:22 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:22 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 13/16] tests/hexagon: add tests for v68 HVX IEEE float
 min/max
Date: Wed,  8 Apr 2026 09:37:04 -0700
Message-Id: <5055daa72b6eb563e343a002f988d14e0e52ba72.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QoRuG1yd c=1 sm=1 tr=0 ts=69d68444 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=gVZ7t9wPRZXE4v3XZ3MA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: FoF6PtfrCDWBetk82QkX3Z6NTabTvVyq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfX2q19AWoXyMwE
 vh0Q9CYejJg0lWmOvOhqm8JkfHP11sAAfiaWK2/nEEZocOnneFvvfcZ2AgYCplGEND1u6+bSVJI
 olUey+Xf8aB4YXZZmWjxcHx6t/iBGVV2JfYzM7ZBjRoHaz0PPuPphMzD5MgQx79IVigRkK8e+le
 5eoSGU4iLkOpc0NznixUXW/sxFHl4F++xCQCTAI/9kbFoxn6fQTyx18lMUZzuG7X0Fb3mZkIJJu
 VGy49XMGsx02LK0Kb+pVXIcLR/K53OQcLNmpFVjLMPpNQE9/YORFK72q0dMSC7e6jqmbulMA1Eo
 jIKFz3gA/x7pzT0+HZHx1QTpYBDh45CefMEYcBAxJn5Jhm0X4JNcvab5PRY0FDgPl3JiFeAbqyR
 20CgieLL12cWFaUlPsmANKTNte7ZYce/XIp2pKzE57IUQCwNd51YiIlR4OjNkuqe2oiJ3h4dpyh
 H6qD2dfSKKabNibZFxQ==
X-Proofpoint-GUID: FoF6PtfrCDWBetk82QkX3Z6NTabTvVyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080154
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/tcg/hexagon/fp_hvx.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/tcg/hexagon/fp_hvx.c b/tests/tcg/hexagon/fp_hvx.c
index 0365833753..46f49c0d3c 100644
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


