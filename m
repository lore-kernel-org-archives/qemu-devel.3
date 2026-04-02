Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D888FD39411
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FbT-0005WE-5n; Thu, 02 Apr 2026 06:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Faq-0004lR-SM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Fal-0007qI-Uf
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328Rx6i352408
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AwG/0VXCfmY
 H2CY/btD01+fOPkZvD3Oqx7BljHhIpwE=; b=oGoB3QQjZHBksvj8LNnexpJMWl7
 4k9DYJXjVapmpjBldVltKwIKKQk6z+kc5i01MhX6qDHvGq56Wh01lQxPkdY6R/lS
 EhySZSoXychzUgYE7PZxMJ32/3PfCO52kZmb/9A9RiRogc9N+IBPqvej9rWy7tjR
 dPpBZnEIxpp8PJ0Lf2bvKxm5ARBGPt7NmTRCF0gCIR1gsFtMfXCrEPV4xPunOlpT
 +CT0qgaVo27mIrE8DrC3Ckm91G7QZ0hx2pEepOU5MNpETzk5mAJfwg9g2WbXpUBR
 Bt+LGmzeSSvNB3vlZya3koBkfOHwoGA3u5tYPp/vLiJKzQCJH9jBvuhXb0Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9myh8h1j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso825594eec.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126872; x=1775731672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwG/0VXCfmYH2CY/btD01+fOPkZvD3Oqx7BljHhIpwE=;
 b=K0x8+ysVcmsHy9Z06n3muvBGXEGcGXiueyVO8k+YgXUrIKzLqvqG6BEzQXXI4tVsNR
 GPlpg07khI38StEZTYUpRwDrHs8XWYpLrU5C11dn6Wwggv5FjqnDlMe90Lc0CRhIKMsY
 X5FH+mcEVVR6+/6Fs3bRzaau9PabS6pBFdLBdL0fxJqX5rVUo0q+E+xDj9JFeNwzYBO0
 bum/AEUSE6MbzTIrwsYEXNiSxc7JyaBD6SeaqxTb7XI8dcLZ2R9aLvfZz2+51sf33BOe
 /jLgv5TelgGghI1oCUl50KQmREtBXmBguc5MSOKpensSuvNHVXNiMc3vfC3Wcj2B4WvL
 vBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126872; x=1775731672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AwG/0VXCfmYH2CY/btD01+fOPkZvD3Oqx7BljHhIpwE=;
 b=DXuCnwiSdLSMFtob/+fCxJWAUX9mC3BotEwf1pg+KLHNdByMLRUGgjBAxg0ssp6eU7
 5/Ks0OFSTPOxIB4I5mtbt8cSM3EDQmGpXjY9mZ1J3aGDr432H71bfx45E+egKzzxV1jy
 fOOChfdsIrg9iON/MduhYjeHjplZls42fQGH8zNQOMpygHY2ZMaFVgol0SfGWPrxeBx7
 37QmQAmezM+mkgOuPEee9J/4Ss07me4cH+Us/j3ERNuLT7KmScaW1+yQHGQYglbQY8p9
 BQH8vHpy7zoOSebca+NCg2klpz2d0OcHkQ9Ia1OuJGykGdPKFZ9KvR/BNYaXEfa9f6gn
 Cfxw==
X-Gm-Message-State: AOJu0YyJvpz5/Hsit/Was+76GyflePEBrJiHklAxZxEXtEOB4kMROkyJ
 0b+2wE3zUCO0J9irZcwFcNXM4Hj+XPt0bxXfRVs1rq7dg3Dg44cBIZQqYvbzSZ2FGvpQbKQGhpg
 4ow/jMn483tzsZ5k8u0HzV21DTl/mbc1GTnApcrCOqwCIBErWgZq90NocBmHOmgGkqrIw
X-Gm-Gg: ATEYQzyvav3f/EGLk6Xxy9/tbvYpnR5ZmeBgTSHuNfWjv+XXuZKb69iYseAtOXBTy0f
 JF4749YOzE7//YZ5iaYY4DGVcgsAE4uOBEwcmVCScKAaHKVCM8W/zOuMuwOGmID3zYSoAfJoHMP
 oFM0UreUrMemwCn6o+lFhfPn6GUv4CbdbnJUJfO807yFA2DSSRkorDpXsaZeIWh+fF6C+Pn8mxj
 blrtVV1WiElXC7LJ3TNEukUU1GFuRaFxzHRbgibk1wrAhzZzyornArPVMNAVJSra+75z0Ze+vhB
 kC21QG1DhrJiCW2bvDnQFPE7zK6kMqq6sgEWqBbSH/F0cejnuHKF1Jo5xMnhkAmZom4VOnpFVSE
 O7u8UG84Jvg7qJ+5WvESNK9v83KgdKZBjMnYT4gG2K291fJe79Tl1Teiq2nL7mAIAeXR7DTPHZ2
 pAzaOEfN7z
X-Received: by 2002:a05:7301:168a:b0:2c0:f424:b545 with SMTP id
 5a478bee46e88-2c931c9246dmr4298309eec.15.1775126871559; 
 Thu, 02 Apr 2026 03:47:51 -0700 (PDT)
X-Received: by 2002:a05:7301:168a:b0:2c0:f424:b545 with SMTP id
 5a478bee46e88-2c931c9246dmr4298284eec.15.1775126870968; 
 Thu, 02 Apr 2026 03:47:50 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:50 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 16/16] tests/hexagon: add tests for HVX bfloat
Date: Thu,  2 Apr 2026 03:47:33 -0700
Message-Id: <c62678b9e91bfd512ceeccb4f80218e6db7a69f3.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ke28dCZnPHJwLUjOREgGjYFIAVP2IgT1
X-Proofpoint-ORIG-GUID: ke28dCZnPHJwLUjOREgGjYFIAVP2IgT1
X-Authority-Analysis: v=2.4 cv=JII2csKb c=1 sm=1 tr=0 ts=69ce4958 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=5fiZ3uqFNM85zO-AtVUA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX+Fj98zAXL/tn
 oTv5d6R+XIJoFhKhqvTV7/RpKUmQRLwbdKPnC6cMoWIqXfGRU0diFpum6fnj3SMwDPmW6A1rvxA
 bUDRD8gLBrOoAgQ754MUYpBhqj3DQ0iZVBg5H8K9zuCp+VeM8p6rUm6pMhNJrBrNOGUFaotyQrD
 n2wKDQM+Vy1AFdbeQorkk22uAWQGBn6BSfx/0/UFCDDOKruXVbB0A04LgnSkyBU1sa2Le9TFnPv
 THiqjM72LkKLpp0pdmcitTyqTrJdRP6mJokjCXFYbeG5zQWWoJASSuWa5+iReIlOuIdVsnWt4sO
 DbOXqE5/e9HZ9DOcqCXrs3TYWqYtwoAP6qM6QqWl73X09rI6jCU7a0xmncUMRIiIm/ItrEte6lm
 vKvG+IAZQYiJ7phu0YchDvyV9ihIZ4pUp8rZ5SH0IuKUXLsrrn2f1R2y+1lONmvy8R27mk3dLAa
 bpHzy0oDBVdzmCg4+gA==
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/tcg/hexagon/hex_test.h   | 13 +++++++++
 tests/tcg/hexagon/hvx_misc.h   | 30 ++++++++++++++++++++
 tests/tcg/hexagon/fp_hvx.c     | 41 +++++++++++++++++++++++++++
 tests/tcg/hexagon/fp_hvx_cmp.c | 52 ++++++++++++++++++++++++++++++++++
 tests/tcg/hexagon/fp_hvx_cvt.c | 31 ++++++++++++++++++++
 5 files changed, 167 insertions(+)

diff --git a/tests/tcg/hexagon/hex_test.h b/tests/tcg/hexagon/hex_test.h
index 79d30ec61c..f86e6e1a69 100644
--- a/tests/tcg/hexagon/hex_test.h
+++ b/tests/tcg/hexagon/hex_test.h
@@ -126,6 +126,19 @@ const uint16_t HF_small_neg = 0x8010;
 const uint16_t HF_any = 0x3c00;
 const uint16_t HF_neg_two = 0xc000;
 
+const uint16_t BF_INF           = 0x7f80;
+const uint16_t BF_INF_neg       = 0xff80;
+const uint16_t BF_QNaN          = 0x7fc0;
+const uint16_t BF_SNaN          = 0x7f81;
+const uint16_t BF_QNaN_neg      = 0xffc0;
+const uint16_t BF_SNaN_neg      = 0xff81;
+const uint16_t BF_HEX_NaN       = 0x7fff;
+const uint16_t BF_zero          = 0x0000;
+const uint16_t BF_zero_neg      = 0x8000;
+const uint16_t BF_one           = 0x3f80;
+const uint16_t BF_two           = 0x4000;
+const uint16_t BF_four          = 0x4080;
+
 const uint32_t SF_INF =              0x7f800000;
 const uint32_t SF_INF_neg =          0xff800000;
 const uint32_t SF_QNaN =             0x7fc00000;
diff --git a/tests/tcg/hexagon/hvx_misc.h b/tests/tcg/hexagon/hvx_misc.h
index 43de20da6a..c21ea975c1 100644
--- a/tests/tcg/hexagon/hvx_misc.h
+++ b/tests/tcg/hexagon/hvx_misc.h
@@ -41,6 +41,7 @@ typedef union {
     uint16_t uh[MAX_VEC_SIZE_BYTES / 2];
     uint16_t hf[MAX_VEC_SIZE_BYTES / 2]; /* convenience alias */
     int16_t   h[MAX_VEC_SIZE_BYTES / 2];
+    uint16_t  bf[MAX_VEC_SIZE_BYTES / 2];
     uint8_t  ub[MAX_VEC_SIZE_BYTES / 1];
     int8_t    b[MAX_VEC_SIZE_BYTES / 1];
 } MMVector;
@@ -73,6 +74,7 @@ CHECK_OUTPUT_FUNC(uh, 2)
 CHECK_OUTPUT_FUNC(hf, 2)
 CHECK_OUTPUT_FUNC(ub,  1)
 CHECK_OUTPUT_FUNC(b,  1)
+CHECK_OUTPUT_FUNC(bf,  2)
 
 static inline void init_buffers(void)
 {
@@ -97,6 +99,12 @@ static const uint32_t FP_VALUES[] = {
 };
 #define FP_VALUES_MAX ARRAY_SIZE(FP_VALUES)
 
+static const uint16_t BF_VALUES[] = {
+    BF_INF, BF_INF_neg, BF_QNaN, BF_SNaN, BF_QNaN_neg, BF_SNaN_neg,
+    BF_HEX_NaN, BF_zero, BF_zero_neg, BF_one, BF_two, BF_four,
+};
+#define BF_VALUES_MAX ARRAY_SIZE(BF_VALUES)
+
 static inline void init_buffers_fp(void)
 {
     _Static_assert(BUFSIZE * (MAX_VEC_SIZE_BYTES / 4) >
@@ -116,6 +124,25 @@ static inline void init_buffers_fp(void)
     }
 }
 
+static inline void init_buffers_bf(void)
+{
+    _Static_assert(BUFSIZE * (MAX_VEC_SIZE_BYTES / 2) >
+                   BF_VALUES_MAX * BF_VALUES_MAX,
+                   "test arrays can't fit all BF_VALUES combinations");
+    int counter1 = 0, counter2 = 0;
+    for (int i = 0; i < BUFSIZE; i++) {
+        for (int j = 0; j < MAX_VEC_SIZE_BYTES / 2; j++) {
+            buffer0[i].bf[j] = BF_VALUES[counter1];
+            buffer1[i].bf[j] = BF_VALUES[counter2];
+            counter2++;
+            if (counter2 == BF_VALUES_MAX) {
+                counter2 = 0;
+                counter1 = (counter1 + 1) % BF_VALUES_MAX;
+            }
+        }
+    }
+}
+
 #define VEC_OP1(ASM, EL, IN, OUT) \
     asm("v2 = vmem(%0 + #0)\n\t" \
         "v2" #EL " = " #ASM "(v2" #EL ")\n\t" \
@@ -212,10 +239,13 @@ static inline void test_##NAME(bool invert) \
 
 #define float_sf(x) ({ typeof(x) _x = (x); *((float *)&(_x)); })
 #define float_hf(x) ({ typeof(x) _x = (x); *((_Float16 *) &(_x)); })
+#define float_bf(x) ({ uint32_t _u = ((uint32_t)(x)) << 16; *((float *)&(_u)); })
 #define raw_sf(x) ({ typeof(x) _x = (x); *((uint32_t *)&(_x)); })
 #define raw_hf(x) ({ typeof(x) _x = (x); *((uint16_t *)&(_x)); })
+#define raw_bf(x) ({ typeof(x) _x = (x); (uint16_t)(*((uint32_t *)&(_x)) >> 16); })
 #define float_hf_to_sf(x) ((float)x)
 #define bytes_hf 2
 #define bytes_sf 4
+#define bytes_bf 2
 
 #endif
diff --git a/tests/tcg/hexagon/fp_hvx.c b/tests/tcg/hexagon/fp_hvx.c
index 46f49c0d3c..f22514b4bf 100644
--- a/tests/tcg/hexagon/fp_hvx.c
+++ b/tests/tcg/hexagon/fp_hvx.c
@@ -29,6 +29,7 @@ int err;
 #define CHECK_NAN(A, DEF_NAN) (isnan(A) ? DEF_NAN : (A))
 #define NAN_SF float_sf(0x7FFFFFFF)
 #define NAN_HF float_hf(0x7FFF)
+#define NAN_BF float_hf(0x7FFF)
 
 /******************************************************************************
  * Binary operations
@@ -91,11 +92,43 @@ DEF_TEST_OP_2(vmpy, MULT_HF, hf, hf);
 #define MAX_HF(X, Y) MAX(X, Y, NAN_HF)
 #define MIN_SF(X, Y) MIN(X, Y, NAN_SF)
 #define MAX_SF(X, Y) MAX(X, Y, NAN_SF)
+#define MIN_BF(X, Y) MIN(X, Y, NAN_BF)
+#define MAX_BF(X, Y) MAX(X, Y, NAN_BF)
 
 DEF_TEST_OP_2(vfmin, MIN_SF, sf, sf);
 DEF_TEST_OP_2(vfmax, MAX_SF, sf, sf);
 DEF_TEST_OP_2(vfmin, MIN_HF, hf, hf);
 DEF_TEST_OP_2(vfmax, MAX_HF, hf, hf);
+DEF_TEST_OP_2(vmin, MIN_BF, bf, bf);
+DEF_TEST_OP_2(vmax, MAX_BF, bf, bf);
+
+#define DEF_TEST_OP_2_INTERLEAVED(vop, op, type_res, type_arg) \
+    static void test_##vop##_##type_res##_##type_arg(void) \
+    { \
+        memset(expect, 0xff, sizeof(expect)); \
+        memset(output, 0xff, sizeof(output)); \
+        for (int i = 0; i < BUFSIZE / 2; i++) { \
+            HVX_VectorPair *hvx_output = (HVX_VectorPair *)&output[2 * i]; \
+            HVX_Vector hvx_buffer0 = *(HVX_Vector *)&buffer0[i]; \
+            HVX_Vector hvx_buffer1 = *(HVX_Vector *)&buffer1[i]; \
+            *hvx_output = \
+                Q6_W##type_res##_##vop##_V##type_arg##V##type_arg(hvx_buffer0, \
+                                                                  hvx_buffer1); \
+            for (int j = 0; j < MAX_VEC_SIZE_BYTES / bytes_##type_res; j++) { \
+                expect[2 * i].type_res[j] = \
+                    raw_##type_res(op(float_##type_arg(buffer0[i].type_arg[2 * j]), \
+                                      float_##type_arg(buffer1[i].type_arg[2 * j]))); \
+                expect[2 * i + 1].type_res[j] = \
+                    raw_##type_res(op(float_##type_arg(buffer0[i].type_arg[2 * j + 1]), \
+                                    float_##type_arg(buffer1[i].type_arg[2 * j + 1]))); \
+            } \
+        } \
+        check_output_##type_res(__LINE__, BUFSIZE); \
+    }
+
+DEF_TEST_OP_2_INTERLEAVED(vadd, SUM_SF, sf, bf);
+DEF_TEST_OP_2_INTERLEAVED(vsub, SUB_SF, sf, bf);
+DEF_TEST_OP_2_INTERLEAVED(vmpy, MULT_SF, sf, bf);
 
 /******************************************************************************
  * Other tests
@@ -180,6 +213,14 @@ int main(void)
     test_vfmax_sf_sf();
     test_vfmax_hf_hf();
 
+    /* bfloat */
+    init_buffers_bf();
+    test_vmin_bf_bf();
+    test_vmax_bf_bf();
+    test_vadd_sf_bf();
+    test_vsub_sf_bf();
+    test_vmpy_sf_bf();
+
     puts(err ? "FAIL" : "PASS");
     return err ? 1 : 0;
 }
diff --git a/tests/tcg/hexagon/fp_hvx_cmp.c b/tests/tcg/hexagon/fp_hvx_cmp.c
index c4e1c81ce5..4417e736f9 100644
--- a/tests/tcg/hexagon/fp_hvx_cmp.c
+++ b/tests/tcg/hexagon/fp_hvx_cmp.c
@@ -22,9 +22,11 @@ int err;
 
 #define MAX_TESTS_hf (MAX_VEC_SIZE_BYTES / 2)
 #define MAX_TESTS_sf (MAX_VEC_SIZE_BYTES / 4)
+#define MAX_TESTS_bf (MAX_VEC_SIZE_BYTES / 4)
 
 #define TRUE_MASK_sf 0xffffffff
 #define TRUE_MASK_hf 0xffff
+#define TRUE_MASK_bf 0xffff
 
 static const char *comparisons[MAX_TESTS_sf][2];
 static HVX_Vector *hvx_output = (HVX_Vector *)&output[0];
@@ -160,6 +162,55 @@ static void test_cmp_hf(void)
     CHECK(hf, 2);
 }
 
+
+static void test_cmp_bf(void)
+{
+    /*
+     * General ordering for bf:
+     * QNaN > SNaN > +Inf > numbers > -Inf > SNaN_neg > QNaN_neg
+     */
+
+    /* Test equality */
+    PREP_TEST();
+    ADD_TEST_CMP(bf, 0,       0,       false);
+    ADD_TEST_CMP(bf, BF_SNaN, BF_SNaN, false);
+    CHECK(bf, 2);
+
+    /* Common numbers */
+    PREP_TEST();
+    TEST_CMP_GT(bf, raw_hf((_Float16)2.2),  raw_hf((_Float16)2.1));
+    TEST_CMP_GT(bf, raw_hf((_Float16)0),    raw_hf((_Float16)-2.2));
+    CHECK(bf, 2);
+
+    /* Infinity vs Infinity/NaN */
+    PREP_TEST();
+    TEST_CMP_GT(bf, BF_QNaN,      BF_INF);
+    TEST_CMP_GT(bf, BF_SNaN,      BF_INF);
+    TEST_CMP_GT(bf, BF_INF,       BF_INF_neg);
+    TEST_CMP_GT(bf, BF_INF,       BF_SNaN_neg);
+    TEST_CMP_GT(bf, BF_INF,       BF_QNaN_neg);
+    TEST_CMP_GT(bf, BF_INF_neg,   BF_SNaN_neg);
+    TEST_CMP_GT(bf, BF_INF_neg,   BF_QNaN_neg);
+    TEST_CMP_GT(bf, BF_SNaN,      BF_INF_neg);
+    TEST_CMP_GT(bf, BF_QNaN,      BF_INF_neg);
+    CHECK(bf, 2);
+
+    /* NaN vs NaN */
+    PREP_TEST();
+    TEST_CMP_GT(bf, BF_QNaN,      BF_SNaN);
+    TEST_CMP_GT(bf, BF_SNaN,      BF_SNaN_neg);
+    TEST_CMP_GT(bf, BF_SNaN_neg,  BF_QNaN_neg);
+    CHECK(bf, 2);
+
+    /* NaN vs non-NaN */
+    PREP_TEST();
+    TEST_CMP_GT(bf, BF_QNaN,      BF_one);
+    TEST_CMP_GT(bf, BF_SNaN,      BF_one);
+    TEST_CMP_GT(bf, BF_one,       BF_QNaN_neg);
+    TEST_CMP_GT(bf, BF_one,       BF_SNaN_neg);
+    CHECK(bf, 2);
+}
+
 static void test_cmp_variants(void)
 {
     HVX_VectorPred true_pred, false_pred, pred;
@@ -220,6 +271,7 @@ int main(void)
 
     test_cmp_sf();
     test_cmp_hf();
+    test_cmp_bf();
     test_cmp_variants();
 
     puts(err ? "FAIL" : "PASS");
diff --git a/tests/tcg/hexagon/fp_hvx_cvt.c b/tests/tcg/hexagon/fp_hvx_cvt.c
index 71c3f0fd4f..bd8d39d6b6 100644
--- a/tests/tcg/hexagon/fp_hvx_cvt.c
+++ b/tests/tcg/hexagon/fp_hvx_cvt.c
@@ -19,6 +19,8 @@ int err;
 #include "hvx_misc.h"
 #include "hex_test.h"
 
+#define NAN_BF 0x7FFF
+
 #define TEST_EXP(TO, FROM, VAL, EXP) do { \
     ((MMVector *)&buffer)->FROM[index] = VAL; \
     expect[0].TO[index] = EXP; \
@@ -172,6 +174,34 @@ DEF_TEST_VCONV(sf, w, { \
     TEST_EXP(sf, w, 16777219, raw_sf((float)16777220)); /* rounds UP */ \
 })
 
+#define TEST_EXP_BF(VAL, EXP) do { \
+    ((MMVector *)&buffers[1])->sf[index] = VAL; \
+    ((MMVector *)&buffers[0])->sf[index] = VAL; \
+    expect[0].bf[2 * index] = EXP; \
+    expect[0].bf[2 * index + 1] = EXP; \
+    index++; \
+} while (0)
+
+static void test_vconv_bf_sf(void)
+{
+    HVX_Vector *hvx_output = (HVX_Vector *)&output[0];
+    HVX_Vector buffers[2];
+    int index = 0;
+    memset(&buffers, 0, sizeof(buffers));
+    memset(expect, 0, sizeof(expect));
+
+    TEST_EXP_BF(SF_QNaN, NAN_BF);
+    TEST_EXP_BF(SF_SNaN, NAN_BF);
+    TEST_EXP_BF(SF_QNaN_neg, NAN_BF);
+    TEST_EXP_BF(SF_INF, BF_INF);
+    TEST_EXP_BF(SF_INF_neg, BF_INF_neg);
+    TEST_EXP_BF(SF_one, BF_one);
+    TEST_EXP_BF(SF_zero_neg, BF_zero_neg);
+
+    *hvx_output = Q6_Vbf_vcvt_VsfVsf(buffers[0], buffers[1]);
+    check_output_hf(__LINE__, 1);
+}
+
 int main(void)
 {
     test_vcvt_uh_hf();
@@ -182,6 +212,7 @@ int main(void)
     test_vconv_sf_w();
     test_vconv_h_hf();
     test_vconv_hf_h();
+    test_vconv_bf_sf();
 
     puts(err ? "FAIL" : "PASS");
     return err ? 1 : 0;
-- 
2.37.2


