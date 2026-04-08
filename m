Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBED410F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXx3-00062n-Id; Wed, 08 Apr 2026 14:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAXx1-0002mq-Oh
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:48:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVuC-0006qz-UE
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638GC2Qq1072625
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AwG/0VXCfmY
 H2CY/btD01+fOPkZvD3Oqx7BljHhIpwE=; b=Re+OKcOzbLd/RhMZ3AE5pWi8uTV
 4Sz+TMaEPK7Sh51JyITNJORBjFKsyZ6ecXpP+qM53eXWGVNip+dmsqU9a+PEd/VK
 QNTjRfzMo1OX9X2TzsvtmtAdOq76lV1nbzBiFJp+9vPT5avYiEFztKhfXWpqDMtL
 c2Om+vgrs6T6DNqTq/O8XEG7WPBfgbxFTNBDNBVPxFkRdwX9zr8df7hvjI7qaNjA
 sQJWqoMgdn6XvfLqgyT4w1XTu13q7cQ+d8hTJZkrOhH871vUe8zmTzWZC/8UxMbC
 xxr47RDmWbnrmDIQY4+N0/xeTUDto/VgCPRpCIr7AzbZoSLtFoOIjmrwhcw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtb382c4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b0cf396c45so276215ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666247; x=1776271047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwG/0VXCfmYH2CY/btD01+fOPkZvD3Oqx7BljHhIpwE=;
 b=bm3xUdfDtw97inH6X2XLIFrFqp0UtGdg6eLJtE8y+7Ql8S8TjzjuLIQTG3gE/VZC9E
 FDDs44ZJC/6hrVpPm6zlUgfWCxAJaHzovT6jC8Mp+M+DdqdVcdGk8c/2eOuR93a9jgXu
 KnTN61ynJBeWEF/4R7wRUX8Db/JZ3uRayqa93fI1IVzvBSLkh0Eb6vFH7hJVed4aDjc9
 0/QKAblHtuEPJ3MuYAoodCmc8HezzykjkWKxBTHtbLxqbScGxUlw+vVsfz9IId5svVRe
 m6S/IJn9SFXDkYTp4sNxKSKRrmXLq24ppSATBfe7eyYWjmqg+T2D1bUW4HCmLN8zhFZe
 +GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666247; x=1776271047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AwG/0VXCfmYH2CY/btD01+fOPkZvD3Oqx7BljHhIpwE=;
 b=dIUVUfi2lMqLF34OY76ABrYGj5DBpXWEuBxlB25+9Xz2kPuciE9vR21hkIcM7CisDZ
 /ziylEgKn0q1QcR9WXU6G3W0oiJFO3MonXpY8ee2IWqxphECl+EXj5xxpFy5AsmutgFP
 7mMo/H/C04umDuInUDAVtYlqozUoq48CCQBn9V9jwqg/l7keriX1WLdPyU4M5It9xNqj
 C1fmww1WzOkiTtXauq2emjHoBGHpwcOco8n+ptXjNuplP1aauFUBVosgbd1rgOKY8Tif
 Cq1l91j2HvPbovBVKdVTVrQu5oF50jw8lzPto8VdLE57jGGkORJBy0/Exwyea41P4kko
 U0lw==
X-Gm-Message-State: AOJu0YwiPsDUwGuqaFJLczH/fksZ3blslSOwhSn9+QCtZLKqvZ9EWyjS
 Ezs0mj735rki8NtqUFs9v4vZUBooyztlajAXo+Z0YHx8xxdx1/+fk4PwCdLBgQUFpqN4JnWrltK
 DFB+42S/lPc2nSOZz+m5paKW1hDZyhv6IXBEHXt6kqZ1cwVacG12uA6Cjem4fg2jvGSOw
X-Gm-Gg: AeBDievDKEUBjY4rL1QHRVfEK3wNHGcRBiASp+TIDP0R8orH3mENRTrKU9LkQFlopCN
 HFN6os1mL/Q8sYWYSbZpLifdNzre0wef7KjZY+39x71jwtOaKjSWo5gQUHu4zDTMwVcPy5ZSTR5
 tAJn06cNhJKZbY4A9eG/5KglsckQ5DtfJokl2R6+VH+8dqLL4R1hUeUKun9VIDvCGKU6Pm0AtPf
 dAekA4K3Ha7Lv16LEnh6DZ+3Kk/aKqSHcCGCLlVKtAXC/K9aHSX9iZoKykTs6wETTbGWz6blHFq
 vMlilQO4m2GNIgYqRoH6JZXxtj4SXl0Lo4vAhLfwM4gZHLY6it2pA36yNUe04rrjYyLG4lX6ZNS
 fpbDLee3FFGoyQAJSQtBLqPusEyufXdgqfG7oa1MZYjewWAgqQI5gb3hnbmu+Ka0QnkS+NHJMUx
 o4RE2JWOCU
X-Received: by 2002:a05:7022:983:b0:128:d30f:c017 with SMTP id
 a92af1059eb24-12c28bac7c9mr111165c88.9.1775666246516; 
 Wed, 08 Apr 2026 09:37:26 -0700 (PDT)
X-Received: by 2002:a05:7022:983:b0:128:d30f:c017 with SMTP id
 a92af1059eb24-12c28bac7c9mr111135c88.9.1775666245627; 
 Wed, 08 Apr 2026 09:37:25 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:25 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 16/16] tests/hexagon: add tests for HVX bfloat
Date: Wed,  8 Apr 2026 09:37:07 -0700
Message-Id: <12d1c25d334b2b97d61b7d1d5b972a89ba235587.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfX+d/bVxmAjEzr
 6R2ENKfr0wDHl7hYq05hHVA3UmwjtGmbhgKUQ5oSo94yUGJ9KVxKbpY1lyEklXuOY0gEAldH3La
 kwQkSOafMh7FveMPGfwT/eaxnpSi4e562Pjw7ZCtopNIMGzAYgVYBbFvS80MbL79hIXmaJJpLCD
 0Pc/RKMzMWsgzgVPgWQBizvI0NOFYT6Ge9cCxsQh+urysOiTnFDEmQfyXU0rgyg7Mz+M4luufb1
 cn69RvMjzOgNJaRj1d3I8n+7W3f8IzPo2qfMweHGunleyOYr/HyfmxgxyXCZl3UnVC6xgNzKFDz
 HKwup/Kf3vawY05wCNw7XKMrxSt6SbpoLuH1M3ImQnR6gNeW52fLWFNxEr1sxEECnUQmBeGUkZR
 4X9alaL/5GVUbBF8AgJif952U5xKXIIccMDdm82dCIIyhRwqFeME82VuCgAtjixWNpcxva4fobt
 k/Io55bK8Ubeaj9F0fg==
X-Authority-Analysis: v=2.4 cv=eKIjSnp1 c=1 sm=1 tr=0 ts=69d68447 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=5fiZ3uqFNM85zO-AtVUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: IQPQePKRhZrjKMUpxCYur3sk9guEHzJH
X-Proofpoint-ORIG-GUID: IQPQePKRhZrjKMUpxCYur3sk9guEHzJH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080154
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


