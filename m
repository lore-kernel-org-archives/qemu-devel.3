Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90758F46101
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f91-0000ST-7I; Mon, 23 Mar 2026 09:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8k-0000Id-Cy
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8h-0000Mp-4Y
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:18 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NC29Pa3042122
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LWVCwCbLYg1
 i5yP2hcK3daGsPxhnZwCn9wr4vZH3grw=; b=Dyw3JSKwS5Hgz4dkbC7KSLKXbTk
 G2NOo3q1e7059lg//fCmzqxmIN8s+Ot9K+5oULDEdUeiB5RbVm9N10b4f9C7wKAU
 toNnEthW9YaQ0aP+HBDaR7WLkgsjXRpSt8QypfJEtJiHHVE91qOKnXdDU67YpXbJ
 QFVFujFM/0VZwZuiLM/W26dPS0rc/Z81PtdwO1tpR/R4SKXOVb5zNCpVDwqxuxb7
 7svbvUfshz21rR6oO8sDzLChNblEsn0yUVFUukrB2obh2L/mWE6cgY0lSdi9GlKY
 39RP3/30t26FT5Bj3sXy5qBAYaCbREgFE2v5eiQ0AwFBcCLPkxZUHjKMKGg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d355w07j2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:04 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-128edc72e5bso19361373c88.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271763; x=1774876563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWVCwCbLYg1i5yP2hcK3daGsPxhnZwCn9wr4vZH3grw=;
 b=cjutDFJ/mH8WhWEWEp9qNxwvWPD5f3XctGVxZFKeKM9gf2qwLDCicdaxkYMi9CMyls
 FFqEF73oLmjBGLYP/2RKhibR4GYnun13V93CsabJ1c4SEiY2SfoqoRO9GEbphILFjPgN
 w/vvWR/v28+BT3zZXOfQwAYXJIqGzN7iN+YvMlvfZCKl8x0btWZV2v4UEc621653ns6z
 X3sCsMksExuCDkpXldRHnrgq1SykWbPHIovm550RN/yZxSkRQY4Kv1TWeVdDms3Do74m
 TAD+VBUy//7eZpyuFxcHatv+nHR97TzAAKBGB9VTAw3k7fsGkZVXfAEGteCe6HkLA/De
 V+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271763; x=1774876563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LWVCwCbLYg1i5yP2hcK3daGsPxhnZwCn9wr4vZH3grw=;
 b=Lw6kNhCgmGwns+awxj8lFlNPaYsaiqp9ewATEMIHdEIH9olcEJxVbqpyo9eQ5HGtgJ
 mYHvtzSGNMaol31tacKE+cZgUROxcRA8uz1As+DcCz57M4ZM7mUHMiUKENTpL79+xhRZ
 3m8s91oJjz0W0aE9pDBZGLcIsudpAzUu64d6hQi/z/aTcYWrhxLRNnDU0Sq9dJb15zC1
 k/zRHPFrjDSUAptXQKwkTVWntuMakmJFBYO7PYh+rOI7AVxE5ShbZm1kvvFcOXYoR+89
 hXfvi6GS//7T4DMyfMH8mQyCh/Qw/y+wIOp5q0sRsfFyZprjTQ7AXWhffjRQW62/PziP
 5B+w==
X-Gm-Message-State: AOJu0YxpK6wjl8kj7vw4jX6c3vaJ9XXtIOPZ2BQFJIDZmyrX4JHvZb+A
 2hg4hw+cX2/nvv1sELl9nJ6FmuG+Wnot0GDStNrCr3LWq5q58guOG/z5n31tDKH9BC5VXQnQXKs
 T8PopoZjQKygkaJkTWr2lcp+AgoVXJUi49cAxQ8nRVBtKHMqFOpisZgif9bf32EOObknV
X-Gm-Gg: ATEYQzwFR06H06Ww9hFrSv0BtkjeaDOiHl1yih9WkpA4JOxhdWem/q+5YQE8ise/uWJ
 nh0UncgZva1oNECImHqj7a91xSMYrLfE4Szpx0V016LV9F5SheP7iKmEoEL8sd/kssb2ahGOUqQ
 YaFgR/bEjZcIOYJ6xaWCtRf2bgECvDlUbFg9MueJ0AFyOVSyGO8oGwDtrxVY6x6Sa8JrVkMdzTt
 VMMMkIxd2xJsQ7dHHGReHTQO/55sNQY0zAmp7d5pJqtnLaM5xp7HvrXs/lZNJeZG0YEGqAUHqpL
 +eJUZeyjUX999I6SxVg/d91nJDNK26/r3suotocu6m23YQpMcSEUsVfi0KJg/UCG2C4G5scDa6L
 Ihqvs1w9WDVYoarmRUOWQS0ZSI/5kCuIucsQBo3G2cXo0lE2k0vcVVsLl5f0ekhhUmoqFPR0oAn
 z1fI1Rzh4d
X-Received: by 2002:a05:7022:e1e:b0:124:9acd:3b15 with SMTP id
 a92af1059eb24-12a726f86cemr5804142c88.39.1774271762703; 
 Mon, 23 Mar 2026 06:16:02 -0700 (PDT)
X-Received: by 2002:a05:7022:e1e:b0:124:9acd:3b15 with SMTP id
 a92af1059eb24-12a726f86cemr5804099c88.39.1774271761847; 
 Mon, 23 Mar 2026 06:16:01 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:16:01 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 10/13] tests/hexagon: add tests for v68 HVX IEEE float
 arithmetics
Date: Mon, 23 Mar 2026 06:15:46 -0700
Message-Id: <82c5487435a72c68ceec1c09dd6fb986409328e1.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fq7RpV4f c=1 sm=1 tr=0 ts=69c13d14 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=LraSumSEs8G2_VdLntMA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: DwX32lhYosGqxH0465yBfrvgm7RQzNKw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfX0+vYDYVUSCTf
 tu23JTCsjRViqcolReJI790rh8nZsySxE96/M3PFKrcOaJJFrsUtJQvldgsBYo4LQ4DKLmo6uE0
 IJ6+U7FvWrSwjfNQJj+pDLnPlJou/auAgH/t/MVCEab3pn+I9oIsRjCcNdoVZoGQ8J2JRJQ4Qa2
 l7QPXLjfREMzYpQfldUVDT9KeRSTCvVZVrwejck16ECI/yZuNRjGuwgy7w3vYsgY8r8pRahTXuZ
 rJH35Q5cWnW0qZo/6uZ7qjhreZKaBD/d+viLGYm1Nd6D21w6eq2e9n5ykz9erR3sW0dZB9/AQKI
 thQhnEKrGNIqvXqLiWozzJ9pGYye1PkvP/4kzFlzVga4y1tMj0uLCks98T1oSfmDKxxpzgYYilo
 eZbBdob0HnqrBynPYJ5EkEiXAcFde1OsviKVYq/eESt0nmfvLkUUF073x2VbpyQLMqMJiYznULv
 wcwdEY/Ntm76oWSJ+eQ==
X-Proofpoint-GUID: DwX32lhYosGqxH0465yBfrvgm7RQzNKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230103
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
 tests/tcg/hexagon/hvx_misc.h        |  12 +++
 tests/tcg/hexagon/fp_hvx.c          | 129 ++++++++++++++++++++++++++++
 tests/tcg/hexagon/fp_hvx_disabled.c |  32 +++++++
 tests/tcg/hexagon/Makefile.target   |   8 ++
 4 files changed, 181 insertions(+)
 create mode 100644 tests/tcg/hexagon/fp_hvx.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c

diff --git a/tests/tcg/hexagon/hvx_misc.h b/tests/tcg/hexagon/hvx_misc.h
index 2e868340fd..771a4a22b6 100644
--- a/tests/tcg/hexagon/hvx_misc.h
+++ b/tests/tcg/hexagon/hvx_misc.h
@@ -34,8 +34,10 @@ typedef union {
     uint64_t ud[MAX_VEC_SIZE_BYTES / 8];
     int64_t   d[MAX_VEC_SIZE_BYTES / 8];
     uint32_t uw[MAX_VEC_SIZE_BYTES / 4];
+    uint32_t sf[MAX_VEC_SIZE_BYTES / 4]; /* convenience alias */
     int32_t   w[MAX_VEC_SIZE_BYTES / 4];
     uint16_t uh[MAX_VEC_SIZE_BYTES / 2];
+    uint16_t hf[MAX_VEC_SIZE_BYTES / 2]; /* convenience alias */
     int16_t   h[MAX_VEC_SIZE_BYTES / 2];
     uint8_t  ub[MAX_VEC_SIZE_BYTES / 1];
     int8_t    b[MAX_VEC_SIZE_BYTES / 1];
@@ -63,7 +65,9 @@ static inline void check_output_##FIELD(int line, size_t num_vectors) \
 
 CHECK_OUTPUT_FUNC(d,  8)
 CHECK_OUTPUT_FUNC(w,  4)
+CHECK_OUTPUT_FUNC(sf, 4)
 CHECK_OUTPUT_FUNC(h,  2)
+CHECK_OUTPUT_FUNC(hf, 2)
 CHECK_OUTPUT_FUNC(b,  1)
 
 static inline void init_buffers(void)
@@ -175,4 +179,12 @@ static inline void test_##NAME(bool invert) \
     check_output_b(__LINE__, BUFSIZE); \
 }
 
+#define float_sf(x) ({ typeof(x) _x = (x); *((float *)&(_x)); })
+#define float_hf(x) ({ typeof(x) _x = (x); *((_Float16 *) &(_x)); })
+#define raw_sf(x) ({ typeof(x) _x = (x); *((uint32_t *)&(_x)); })
+#define raw_hf(x) ({ typeof(x) _x = (x); *((uint16_t *)&(_x)); })
+#define float_hf_to_sf(x) ((float)x)
+#define bytes_hf 2
+#define bytes_sf 4
+
 #endif
diff --git a/tests/tcg/hexagon/fp_hvx.c b/tests/tcg/hexagon/fp_hvx.c
new file mode 100644
index 0000000000..85b8ff78ed
--- /dev/null
+++ b/tests/tcg/hexagon/fp_hvx.c
@@ -0,0 +1,129 @@
+/*
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <hexagon_types.h>
+#include <hvx_hexagon_protos.h>
+
+int err;
+#include "hvx_misc.h"
+
+#if __HEXAGON_ARCH__ > 75
+#error "After v75, compiler will replace some FP HVX instructions."
+#endif
+
+/******************************************************************************
+ * NAN handling
+ *****************************************************************************/
+
+#define isnan(X) \
+     (sizeof(X) == bytes_hf ? ((raw_hf(X) & ~0x8000) > 0x7c00) : \
+                              ((raw_sf(X) & ~(1 << 31)) > 0x7f800000UL))
+
+#define CHECK_NAN(A, DEF_NAN) (isnan(A) ? DEF_NAN : (A))
+#define NAN_SF float_sf(0x7FFFFFFF)
+#define NAN_HF float_hf(0x7FFF)
+
+/******************************************************************************
+ * Binary operations
+ *****************************************************************************/
+
+#define DEF_TEST_OP_2(vop, op, type_res, type_arg) \
+    static void test_##vop##_##type_res##_##type_arg(void) \
+    { \
+        memset(expect, 0xff, sizeof(expect)); \
+        memset(output, 0xff, sizeof(expect)); \
+        HVX_Vector *hvx_output = (HVX_Vector *)&output[0]; \
+        HVX_Vector hvx_buffer0 = *(HVX_Vector *)&buffer0[0]; \
+        HVX_Vector hvx_buffer1 = *(HVX_Vector *)&buffer1[0]; \
+        \
+        *hvx_output = \
+            Q6_V##type_res##_##vop##_V##type_arg##V##type_arg(hvx_buffer0, \
+                                                              hvx_buffer1); \
+        \
+        for (int i = 0; i < MAX_VEC_SIZE_BYTES / bytes_##type_res; i++) { \
+            expect[0].type_res[i] = \
+                raw_##type_res(op(float_##type_arg(buffer0[0].type_arg[i]), \
+                                  float_##type_arg(buffer1[0].type_arg[i]))); \
+        } \
+        check_output_##type_res(__LINE__, 1); \
+    }
+
+#define SUM(X, Y, DEF_NAN) CHECK_NAN((X) + (Y), DEF_NAN)
+#define SUB(X, Y, DEF_NAN) CHECK_NAN((X) - (Y), DEF_NAN)
+#define MULT(X, Y, DEF_NAN) CHECK_NAN((X) * (Y), DEF_NAN)
+
+#define SUM_SF(X, Y) SUM(X, Y, NAN_SF)
+#define SUM_HF(X, Y) SUM(X, Y, NAN_HF)
+#define SUB_SF(X, Y) SUB(X, Y, NAN_SF)
+#define SUB_HF(X, Y) SUB(X, Y, NAN_HF)
+#define MULT_SF(X, Y) MULT(X, Y, NAN_SF)
+#define MULT_HF(X, Y) MULT(X, Y, NAN_HF)
+
+DEF_TEST_OP_2(vadd, SUM_SF, sf, sf);
+DEF_TEST_OP_2(vadd, SUM_HF, hf, hf);
+DEF_TEST_OP_2(vsub, SUB_SF, sf, sf);
+DEF_TEST_OP_2(vsub, SUB_HF, hf, hf);
+DEF_TEST_OP_2(vmpy, MULT_SF, sf, sf);
+DEF_TEST_OP_2(vmpy, MULT_HF, hf, hf);
+
+/******************************************************************************
+ * Other tests
+ *****************************************************************************/
+
+void test_vdmpy_sf_hf(bool acc)
+{
+    HVX_Vector *hvx_output = (HVX_Vector *)&output[0];
+    HVX_Vector hvx_buffer0 = *(HVX_Vector *)&buffer0[0];
+    HVX_Vector hvx_buffer1 = *(HVX_Vector *)&buffer1[0];
+
+    uint32_t PREFIL_VAL = 0x111222;
+    memset(expect, 0xff, sizeof(expect));
+    *hvx_output = Q6_V_vsplat_R(PREFIL_VAL);
+
+    if (!acc) {
+        *hvx_output = Q6_Vsf_vdmpy_VhfVhf(hvx_buffer0, hvx_buffer1);
+    } else {
+        *hvx_output = Q6_Vsf_vdmpyacc_VsfVhfVhf(*hvx_output, hvx_buffer0,
+                                                hvx_buffer1);
+    }
+
+    for (int i = 0; i < MAX_VEC_SIZE_BYTES / 4; i++) {
+        float a1 = float_hf_to_sf(float_hf(buffer0[0].hf[2 * i + 1]));
+        float a2 = float_hf_to_sf(float_hf(buffer0[0].hf[2 * i]));
+        float a3 = float_hf_to_sf(float_hf(buffer1[0].hf[2 * i + 1]));
+        float a4 = float_hf_to_sf(float_hf(buffer1[0].hf[2 * i]));
+        float prev = acc ? float_sf(PREFIL_VAL) : 0;
+        expect[0].sf[i] = raw_sf(CHECK_NAN((a1 * a3) + (a2 * a4) + prev, NAN_SF));
+    }
+
+    check_output_sf(__LINE__, 1);
+}
+
+int main(void)
+{
+    init_buffers();
+
+    /* add/sub */
+    test_vadd_sf_sf();
+    test_vadd_hf_hf();
+    test_vsub_sf_sf();
+    test_vsub_hf_hf();
+
+    /* multiply */
+    test_vmpy_sf_sf();
+    test_vmpy_hf_hf();
+
+    /* dot product */
+    test_vdmpy_sf_hf(false);
+    test_vdmpy_sf_hf(true);
+
+    puts(err ? "FAIL" : "PASS");
+    return err ? 1 : 0;
+}
diff --git a/tests/tcg/hexagon/fp_hvx_disabled.c b/tests/tcg/hexagon/fp_hvx_disabled.c
new file mode 100644
index 0000000000..af409ab8d2
--- /dev/null
+++ b/tests/tcg/hexagon/fp_hvx_disabled.c
@@ -0,0 +1,32 @@
+/*
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <hexagon_types.h>
+#include <hvx_hexagon_protos.h>
+
+int err;
+#include "hvx_misc.h"
+
+int main(void)
+{
+    asm volatile("r0 = #0xff\n"
+                 "v0 = vsplat(r0)\n"
+                 "vmem(%1 + #0) = v0\n"
+                 "r1 = #0x1\n"
+                 "v1 = vsplat(r1)\n"
+                 "v2 = vsplat(r1)\n"
+                 "v0.sf = vadd(v1.sf, v2.sf)\n"
+                 "vmem(%0 + #0) = v0\n"
+                 :
+                 : "r"(output), "r"(expect)
+                 : "r0", "r1", "v0", "v1", "v2", "memory");
+
+    check_output_w(__LINE__, 1);
+    puts(err ? "FAIL" : "PASS");
+    return err ? 1 : 0;
+}
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index a70ef2f660..16072c96fd 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -50,6 +50,8 @@ HEX_TESTS += vector_add_int
 HEX_TESTS += scatter_gather
 HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
+HEX_TESTS += fp_hvx
+HEX_TESTS += fp_hvx_disabled
 HEX_TESTS += invalid-slots
 HEX_TESTS += invalid-encoding
 HEX_TESTS += multiple-writes
@@ -123,6 +125,12 @@ v68_hvx: CFLAGS += -mhvx -Wno-unused-function
 v69_hvx: v69_hvx.c hvx_misc.h
 v69_hvx: CFLAGS += -mhvx -Wno-unused-function
 v73_scalar: CFLAGS += -Wno-unused-function
+fp_hvx: fp_hvx.c hvx_misc.h
+fp_hvx: CFLAGS += -mhvx -mhvx-ieee-fp
+fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h
+fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
+
+run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
 
 hvx_histogram: hvx_histogram.c hvx_histogram_row.S
 	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
-- 
2.37.2


