Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D87F8A15F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL4S-0005Fb-DF; Thu, 16 Apr 2026 07:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL4M-00059E-0D
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL4J-0003CA-J7
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:37 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G7uwDZ3733606
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6rsaGe+qyX7
 aGhkX5jlvph/v3y8P3SaLT96OgXBeU9M=; b=ienhukkvG3Nntrb8JY9uofDWyts
 WFJyYN6f+XK1bGb0v40/Yx+1Ug4+BsLEE4VJo1tQkNtutQVYvUfYYRcjyrNU013v
 ix/4mQwqruKwdSlfNRRbG/uns42+Q4amREA1vw6U42GwW8v3X530fI4GE4klgs3g
 q0K7gpDse6lEKSJ4CCLQl8E/fCBfNEykcO6b19gK2kP/DIuYjtUaOL8zRkiv8a05
 c1un0S647GhTsLV0nCHh0jtKBnEi63CJvVE0SJoKMUhTTwtPwT3eLsGKktnMMaX+
 lwC4KNkNpuXqdjAjqLd0sjTyYa5saS6/Iufew3h6GO3tWmBXoFA5OIrFkZw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcqwktxd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bda35eab74so506881eec.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339563; x=1776944363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rsaGe+qyX7aGhkX5jlvph/v3y8P3SaLT96OgXBeU9M=;
 b=INaUl/g8XrMv3nZLDhyvcShiX08N7ZBMndUlxp6rPP7KHdAOMbRKXtcYqgLJWSOC3S
 JCzx3wcgMStSX119FbYdRuqNVq8NE59gdziZiasl6vDweRUdGpAmGKbyJ9TxHAqkArt+
 6O+AjlVtWcw2RYjmI3qtAtFvTlC+qWQi8y52GkEI6wZSh57egB2Loa1J1Ize4nhifkhO
 TAZkiznQkyeub171MiFkopno4dmKwk8uYE8WFCSDQlr6bdInKybahQ5AglJkclbVBszf
 k5u+eHs8Dmd5tiP2TsOnmBkmYkI+qWkOCdsws5RIED29r5icxxl3S8vuGwCZPp2nHgEG
 m+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339563; x=1776944363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6rsaGe+qyX7aGhkX5jlvph/v3y8P3SaLT96OgXBeU9M=;
 b=KyM6bTLXWC2YGvg0A4oqhiXNhALPn4Ew+srWAMKBefSd8Ny+7Az9vN5+KDwSzKC/4l
 f3Wt45TWfVzG3lPjHUIw0moZNUNrkfwFEWhoiam77vmrAT9coF98omjq7R3XOqGevKQh
 +UszPPF64IaJkwcwEPpas8XVMMxCkHN4EIq2jVUjaM/d5N29+I9yF5A9TYKsF2r2V8Mw
 1tSODlXD9HuzT5YB/RDkPWhf3FASi9HFcvfnoV0f7pmcdTEcUukAVMs2yeYXdjvtcCGD
 P/lTSfP6/Uc02VZ/7f/VW4K7BhSoPcs51ZGzY5P1WcJGzW8Pjg3Se4L6GRFFqTbPq0+G
 TfzA==
X-Gm-Message-State: AOJu0Yw44/0yz2oc7sph05Oz8bpCjTruXIBscPF0ZWB4FfIHtdgJbBbV
 uN4s+IlzRAVoX7X7/BWuVliixvg3X2vImKA9gU6gwN/4rFNThaqRte5wa6tx5sQxQY23RcGS86a
 X9p/l50QTsOOIzgNS4sql1R2G6n0DdkpBfZcTkZ0UIZxjcW69vAswN4sKuEx4KP1QYzYH
X-Gm-Gg: AeBDievhqEGGPdS/lmichx+TiuNuawTUiKZCzU4h9HGDUjPsKta7dLp5HxQypPdIPLd
 gEJOcXbLe1y+REyoaIegaml793TwBw7zUXeBMCwP3zAXEb3dEfbVG8+pagfKJn7gRUTlmhRtHs2
 Uz4GiOQsmVFrmBKOLIze5+hh73aaSIC7z1Et2WqwJ2Hdi7nGYBeNimHADCkkH+WsPDexF3dIoH2
 JNCBcA3/+F+/iZz/IDe7Wqo93Jj3a+2pMba1O+S5XrkpjdHjpE0mLcPqboz95ycSJeeyySVNQ3p
 azFiK4gv8HgP0qcUbY7zDmENgt0F5jOlqrKoJzJ21laOHVrZIyCUvp2Fqjk+Ye7Hiz9EGoaWMMg
 JtQcjq0PWqfXhRsWQliEc7w53jzdE0q+1mCd+QKaYXAHA01AMU/Us75INpxFgL7Vwjcsrt9eqhF
 y/1OeBF6evIv4JMI5NvO8=
X-Received: by 2002:a05:693c:2b10:b0:2d8:4dee:6ad0 with SMTP id
 5a478bee46e88-2df7f467535mr1329135eec.16.1776339562577; 
 Thu, 16 Apr 2026 04:39:22 -0700 (PDT)
X-Received: by 2002:a05:693c:2b10:b0:2d8:4dee:6ad0 with SMTP id
 5a478bee46e88-2df7f467535mr1329118eec.16.1776339561885; 
 Thu, 16 Apr 2026 04:39:21 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:21 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 13/16] tests/hexagon: add tests for v68 HVX IEEE float
 min/max
Date: Thu, 16 Apr 2026 04:39:02 -0700
Message-Id: <7fdbc12ed4c62a16068c380a85ee2356051e61ea.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -9z_b2wqDTIyBL2asYbTX_BTImhQLCrn
X-Proofpoint-GUID: -9z_b2wqDTIyBL2asYbTX_BTImhQLCrn
X-Authority-Analysis: v=2.4 cv=XOIAjwhE c=1 sm=1 tr=0 ts=69e0ca6b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=gVZ7t9wPRZXE4v3XZ3MA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX3W9NkzOGGsUx
 GBl+tYdIwe2lt/k8jSwjRAmCptctHhPfqlOsUPk4+/kR0eP/GKfy/mdVYdUS6rhKEFnvJ+I8w25
 ZjBeitg6Gp+05LO4f744jURIIxEHPp/PV6x56v3SDLbdAZ9Tl8KDW+g+CIGBnTF9mW5uhNQ0Njv
 XwyTVJrAoArzm6csXAEYAVnOLimzw4Cn8gLIeWuQDCESxUyJ8Lf8iByLNgkAtPCjhZjwq2uG0vg
 jgnu4Xpv70S6KZeDXsiD6+E5IYAK6M3xsMcm2lc2AAeOg041agkuqxddnjESrwP8ijt0GF5dvz5
 ilNzA8oorH2TqnXcsNzhh72B3mI6s2HOIBwKSxcGNe3ttYal8phdPMmbJSe3eXwi3fm/pca/2//
 NywGkh7sOt4co4L4Vd6ZlHOWXBgmcZYdQqZcpkoecsesj2v4MuzU0Y+GcaMxeWlEHFXRSwYHyUF
 HULY9FLNNKDRXk3yDXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160110
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


