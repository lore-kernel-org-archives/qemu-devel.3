Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB65F459FC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5u-0006sp-8c; Fri, 10 Apr 2026 13:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5r-0006ro-Ri
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5l-0001gM-Th
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AH46if1498620
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SKbFbkmU8wz
 fvxxCTkNuC/9i5QQ14DJJHG483Q4/4f4=; b=Ios0C2SkVYzksAoiMNvNPPltpUP
 uKOLf3uEkmvXMnWT+EuexScyXlWPGREVRIDgrwikhUh143Rq4ep9LeElvl+hhDgF
 57RZg+R687/8GZfRgIy+hNz8T2UdD5MUXFltUsAcna3MZmZOGb8hiXivOZzsk74k
 lSo2IYV2ES7rfnfl+3o8YhTljB2ZFitLDz5Ma/8cmdBOmUwuunpUGJ2EGFVXmBfY
 u6qvRnf4vxiSpNnsNIqSbz388HwZvopx9wlBu1L7Tay5m8OploCM/eY8xUbH2ZI4
 S1ZwSUx90dZhpbHIf/6ooKB5r4sDHqzEf48Q5pRDZAC4edSHE9DQnb/tt+Q==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey5b1ctp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:25 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c21dbc9c1so4625582c88.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843784; x=1776448584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKbFbkmU8wzfvxxCTkNuC/9i5QQ14DJJHG483Q4/4f4=;
 b=hDeLllzbANLedAnAzFdb1CncEVZ4KSGMPQRiDf8+P50YKbjMhdlY7Pgb7fqN+3sW4M
 K7hZ2dopo0T9pUjI65s5e+dghlLS8i7J//x4eJV6UI2s60/f/E5+gssVIyFxdlU0HWzJ
 atBZLY+7Un4p0nhl4vCNCzKglqr59sq11nPdo0ACu/kSL1yEUFCNglJgzQ2eQM0CHRyo
 7jnpaGVL1z2TF3kvd9kxlzGByvAn0FuPylSyGjV9jydqBVmL5vWP/6YjruaCRiQI3DZN
 HT/HTiTHPFQLHeqVw7YL+8/yuEz+cOzBWr4zX7DRXAXGpyMSerPzO+RjfYVmySOR/w2b
 tFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843784; x=1776448584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SKbFbkmU8wzfvxxCTkNuC/9i5QQ14DJJHG483Q4/4f4=;
 b=ZSrOzZvo9jDjncYKrTCNNuZUPhxaAWpV9YDQoJouar9zYQKpsWk4iJ1pc0DPHNJ7DR
 JHoCNbkU5CIbLBq8KBdmpJ3QCukpMJLCVoTUFpS+Yund9YsskMo3I5ukV+E1m0mwMzo0
 j0sdBDW2M94GGPyd1HrkJB06lvDI0YiBXXDmRobR91ekAwrsUWOGrud07hmrhmFu4xe8
 8R6OLAwFmz8v1dtjxehtoBT7pxCt4GX43S82ZTVccV1qzh04o5zB8i4Rl+Jn39RyG3An
 my0vRQHR93cLSzp+9d/n/LSgxTsP+URXSedgs7eyNKji/nw4HxntWFdubW/OlNEAqfr+
 Scsw==
X-Gm-Message-State: AOJu0Yy3clJ42F94bCFTG4ypraWxVTEvU6picG6Ez0Up1hgAwAmiRVQu
 aIb29gbnNEScsmJU5QXP8zvyOb/o/BBDuiciLk/xa28KcxN7xF36ktDFzPzbpZljSGVhby9caLT
 aToCx4RfHGl7H/yUYZ91LvKZervvqi6CF924y1iiJGSyrpS3R3cY0zSP5R7mlQtHoObqp
X-Gm-Gg: AeBDietHG1eubeET5x6ZPsT+rPsjTzFK3VvXYFxwaaHe7jEcqjWOb7lurhpI8ev3dpl
 3Zg7gU62WC0luzWkSJgVWGXLOeo9W0RfroWBA9KOBeRJSTKoZXUgd1bh3XgFfri12sX0676MV4S
 ll3YJCGXHHaMgZwKCgXjnIAWrUBpIpCm0r1zmZj1/q2FLhI7Z0uMu1soVcvWgUneBEfiMQy3DoO
 foMWfUjWcOGsK9h44ILF+Y0dF4T134rkKuu2s8Mg/EU2rsbGbxavpGAgalJjcI3+uISAQGqR6IY
 4FDULNlPMs+ghhZlspr9OB6tJSGEPXgMVv4dpvy46+im4yFiDiNaw/pdJEHMPBUEVMiQtwpEmtI
 slum4M/UxaBAHClPKkEdRtq46cFNL3EWP5faYPalbc8YfhHbNcwF0iSdQbuGN4uxW8KkBqgRjY9
 0fOsiP6h4R
X-Received: by 2002:a05:7022:327:b0:11b:bf3f:5240 with SMTP id
 a92af1059eb24-12c34e65f26mr2931720c88.9.1775843784173; 
 Fri, 10 Apr 2026 10:56:24 -0700 (PDT)
X-Received: by 2002:a05:7022:327:b0:11b:bf3f:5240 with SMTP id
 a92af1059eb24-12c34e65f26mr2931694c88.9.1775843783575; 
 Fri, 10 Apr 2026 10:56:23 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:23 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 16/16] tests/hexagon: add tests for HVX bfloat
Date: Fri, 10 Apr 2026 10:56:04 -0700
Message-Id: <10ebb63b81a7dc4c8e1649788ba3b1c19806c052.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Jl_nmdIXC9cMDOdLvIYGuKdX0A06R2Qw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfXxJfNE3dRUl+R
 it60QHiMmmGJFrDMSbt61jpmVl/iEKvu4RdSDIX4oOG9tqdu/OXJ0VLLruESiG25XPbKizNPH7O
 8dKFEfGKvPKo5wCIk1Ceo9eYZIZyU4+WEK1mvJaKoRTPhrAQR3E4dftm5rVfpho3PvahT2Wmju4
 VRgop6+E6Na7f936oDeYRC0IWgZsHHkdrIFM+oaXCD4W7Uezw/0uRsctinDZ39mQbLFqKL1TsGW
 QKAFIGbLDJg1OQ08WGpxud8DhKe0L/h+KtbwdbLNBopLKsPlrBop3nidLfUD7VAiTjKvTh3EQjX
 fDuHs+U0k/VkgUl7eTNnZf35ET5hyKlwtExrQC8pDyUtnB30lzkt84mPzh/HwYD23IBYcd11uFN
 y529+NH0odpL5+moMR9qziv5I6AxvbJvnxeV1PaM6eLejoK4kkOkfcFt7u0cjAOKeuy5MprzIbQ
 v17Txd44C+7oMvuD23Q==
X-Proofpoint-GUID: Jl_nmdIXC9cMDOdLvIYGuKdX0A06R2Qw
X-Authority-Analysis: v=2.4 cv=VsgTxe2n c=1 sm=1 tr=0 ts=69d939c9 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=p2wTH1VsjY2anDiw4wEA:9 a=Fk4IpSoW4aLDllm1B1p-:22
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
 tests/tcg/hexagon/hex_test.h   | 13 +++++++++
 tests/tcg/hexagon/hvx_misc.h   | 30 ++++++++++++++++++++
 tests/tcg/hexagon/fp_hvx.c     | 41 +++++++++++++++++++++++++++
 tests/tcg/hexagon/fp_hvx_cmp.c | 51 ++++++++++++++++++++++++++++++++++
 tests/tcg/hexagon/fp_hvx_cvt.c | 31 +++++++++++++++++++++
 5 files changed, 166 insertions(+)

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
index dee0781bd7..4543a0aa8c 100644
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
index b1352c786a..22c18bc299 100644
--- a/tests/tcg/hexagon/fp_hvx_cmp.c
+++ b/tests/tcg/hexagon/fp_hvx_cmp.c
@@ -22,9 +22,11 @@ int err;
 
 #define MAX_TESTS_hf (MAX_VEC_SIZE_BYTES / 2)
 #define MAX_TESTS_sf (MAX_VEC_SIZE_BYTES / 4)
+#define MAX_TESTS_bf (MAX_VEC_SIZE_BYTES / 2)
 
 #define TRUE_MASK_sf 0xffffffff
 #define TRUE_MASK_hf 0xffff
+#define TRUE_MASK_bf 0xffff
 
 static const char *comparisons[MAX_TESTS_sf][2];
 static HVX_Vector *hvx_output = (HVX_Vector *)&output[0];
@@ -160,6 +162,54 @@ static void test_cmp_hf(void)
     CHECK(hf, 2);
 }
 
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
 static void check_byte_pred(HVX_VectorPred pred, int byte_idx, uint8_t exp_mask,
                             int line)
 {
@@ -217,6 +267,7 @@ int main(void)
 
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


