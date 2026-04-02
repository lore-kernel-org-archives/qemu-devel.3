Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA842D39410
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FbS-0005Qd-IP; Thu, 02 Apr 2026 06:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Fap-0004l4-7I
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Fai-0007pl-Vs
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328Rp8e351773
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=P5hMle4dsIJ
 uY/9/X8rZbjNfzfN97R2T6TLhakQh8Ec=; b=QdNXPe0qoWCwb1rPbYhruVW9xed
 tDVS+RcYj6U0sDoY6rjjfg96wHruaM/HLHKOcEEL01iqlAmZq+OuPMlUBt9UsQwa
 fOquuG2Cg5OVImeLXp3ToEeWghfbyRqtyE9gwZGnKCtsEaIW2ORasx41lzMZ1s+H
 HB+0m3C5jcexOkyGZVnUxKvMLjY1f119QWjKwfIjH9Soc98IOkzi9nwZqcY5tQPt
 I2/hMOjYlUxTboJny4GO4LaESGIefG/WVv2D4Q9F9fSNbwzM0NN1ZxNrNz7hNCqt
 VeJRCzcbfk+poH13hhZvt69kEwGL9yLer2Vkyi4D2mvEtO5x+3dGjcRUjzQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9myh8h1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c72849f648so3525561eec.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126869; x=1775731669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5hMle4dsIJuY/9/X8rZbjNfzfN97R2T6TLhakQh8Ec=;
 b=brT6rbsYp6sMUGiqZ/cNTk8tVOfgaID+yVXhZ2EMexgOmBWnEoSCY2qX+1oRqjecNR
 T8EP+qzwm3DldcVaQLWfQe9rMxKxtBz5ZIff84r+rekcznHpJEyaCrzvWvWmRgsUA/o1
 5kGrn7Hz6sU8nQasg3VDukZimIfYR+7uXEpqTg0dIzDJxq6gylgRq7M77KtwP4OXfW8P
 AYj6QdDUCps8mcaOCfhBLLLPPyg0kqno0awvPqPK7wPl6M2+XCpIQDOazqa+nXQ9T37u
 SABU8XybX6iWPrJrqRdMn9IZ93eTCq04QefR0zHkjhkVOs5GAREB/4mCAGrdB2TsXp2R
 cKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126869; x=1775731669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P5hMle4dsIJuY/9/X8rZbjNfzfN97R2T6TLhakQh8Ec=;
 b=P5C5rUfpI44Fx73M6tgqCZ0awYtmCiToUrrk4wW5GFFjVH1s4QlVEt6G53pWg8NnhM
 GLahc6CyM/Fk38cvsbqyCXp3GkRCxS/8Bp9DP8GO8JXcyrN0SIN7vIfrrtoHzgAj0cle
 nwVQt3oyxsac+llNgzm4JbuSkULAiGnAxwiY/79Z73xJ1uqhRyxEmni2tmv2T1rOYwAs
 v8fk8Zfrx+XmAdc7avHmVdZYMTeaN1q0Oeh4Ez2wzdfyNx+JeeDgqvmOm9nKNTogiPm/
 vWF/WxyaR37Unz6QOtEJRRmCatnmZ5tT3F8GDZLgSOHNXzZg8GKqldGwfLPKdmfPKZVR
 DxZw==
X-Gm-Message-State: AOJu0YxjOcectnYFFShuPZExE7jN356LUf/M/qnLyDWgwZzMCv3sChLZ
 sxvBLgxhxRi50hhTOOwn17+g22AhhU3AjeLhgawqEVxLc/8JbKZePl/KWpwYEU0SbZ9ByLYNNOq
 RXM1pRA4ZvPR4LoGTEjoiHooo9zDarP+L0J68rfaYgkq351Y9x+0FovrM904xpOuaFmFg
X-Gm-Gg: ATEYQzzY5m0ZsPTMDqpAL50vWlGDtNLnHDEgLriv34pvLV/R7EaHn22zyDUjEOTPCHJ
 Z7Hk9IGoj6IeqqBPYHq6SZ5MJIX7xxzNJXdqiKZKeSdOG0TjzF/VNJuL5LgDT3IjKZ1H0k59ZQx
 4pYIUZxwgU9DLKtpd6Wb0TRasggvKGY32fSk6AUlTT+t+62+CDbAItRvFLFjJ0MjnryAX3aY+OY
 blzzRiYaB386B/Rjuhzx4+zndDXUWUO1V9JVCAh9zRVmqBpHE5YNaadwhlcaYO/4qOcc5DQ4b/E
 ihi370a8PPTNoH0mCqRXpQfZTT2fjGnC6jmYboQX3v4ixlZlxXYb0Z/ifXJ9+zYd4S5oxo5L0sn
 Kb1Snc15FgVXU9Q/vJWvHiZcoA4dylQTkqrwhW+CaDpZE8wXx1SFOCYcw0mIcz4523Kg3O0vUt0
 yNKk8IIErq
X-Received: by 2002:a05:7300:a287:b0:2c0:e404:8b08 with SMTP id
 5a478bee46e88-2c932bb18d0mr3349230eec.29.1775126868721; 
 Thu, 02 Apr 2026 03:47:48 -0700 (PDT)
X-Received: by 2002:a05:7300:a287:b0:2c0:e404:8b08 with SMTP id
 5a478bee46e88-2c932bb18d0mr3349218eec.29.1775126868228; 
 Thu, 02 Apr 2026 03:47:48 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:47 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 13/16] tests/hexagon: add tests for v68 HVX IEEE float
 min/max
Date: Thu,  2 Apr 2026 03:47:30 -0700
Message-Id: <a130af3060a23460edeec80f0c15381fdd12897d.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xOo_rfwc2GBN1HA5MJchKkCF70IVpZFY
X-Proofpoint-ORIG-GUID: xOo_rfwc2GBN1HA5MJchKkCF70IVpZFY
X-Authority-Analysis: v=2.4 cv=JII2csKb c=1 sm=1 tr=0 ts=69ce4955 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=gVZ7t9wPRZXE4v3XZ3MA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX5bH5RDpbLYSV
 BUwBSw04W6IgE9Vb0hkQzZURNG9+F6IhbymmOJjCIn2URBOzKJKttIvBWp4JmDhlsa8BATD6U7n
 QXx0v7Xc/KmK/BI4b6NMWvw/t4h7ZtVVE416wR0+ucAR25K84IIZhYxaKF321lIjfwLQDsgZEHI
 uBjyFd2K1D4L0l2MFIVabvfD/Svd2CKFHvQDHgV6LYkqG1cKOyET0IWc/kNBVZ2Q7CSr4Syo4P5
 rvTwUYGeWXMl221s64ZteNFRaN6dA76W92jqhAkoqEXtqUBnUp4BY6v2GF9+xZXjRucjqgfG8+T
 7U30daqI7s4PLoFflwWl5vnVt04CiDi7PNodwUh9D0eY0T/ElmermtGg2esmWkX8FBuAJLqxyiN
 VPewBEtdMZ8qn0t0fYnFpevGNLWB2g/Ub3DWvZOfk03xiSKAGjl/mwSH9Q+cUvk3ekeI2NNcsyr
 twyoHc26cTVugVLTofg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020097
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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


