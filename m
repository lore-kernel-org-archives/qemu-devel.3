Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA16FD461A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 04:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvT5P-0001W5-1u; Wed, 25 Feb 2026 23:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vvT5L-0001VQ-Bk
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 23:34:48 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vvT5I-0008KK-BI
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 23:34:47 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61Q4VH0A350948
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 04:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nPkdfB8s4lf14SpLhfUVAOqZSEA4/FZoFD6WX4r7hbQ=; b=f08fctbKJ7Ri5LIb
 o2FpMZtXZ852GnXRyqUY01zqU9dpr7ielGXZPhJDc3H+d0m/4S3sQWPpOn+p7tMC
 /C9tOQHLHLZ+Dektp2aAlpHMP1c3iNziEq/BXTF9didiTOip0O6TpnG/+4w+Ygum
 a/UiEJMhOe+plI1vWPErFqIbFn1ACjIeTTcLpegnosqUPfSE5iKAgoQngFrmWVZA
 6Aupt78ds8trotQoHY5uxSbSZUR5Ggyb8Pg0rkaAW1nV6UOZKd8zoWqqHksvDbRU
 rdELoDmUbXlkscOk4jjc8/f2za1pz4LGBhSZx5CRIVhMI44f9lVBUsrPzmZ/Vnvy
 Q8Zncw==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54p9sqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 04:34:42 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4639a3bf26cso2672346b6e.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 20:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772080481; x=1772685281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPkdfB8s4lf14SpLhfUVAOqZSEA4/FZoFD6WX4r7hbQ=;
 b=bLTX2b4FFRiwgEXJ+I1xaAM/dBt8D+SNMbkLh0pUGj0ETv6o1nSdnDDoaRqhos6jq3
 zEkKiObeuGfTdDTSvBoUZg089o/u2lhR4IfX5OGKldrUeLV7KBvp5ZFezlEu821G0MLw
 +0+9W1cJwwqMgYiyxz5k+db9kuyiBoik6BiHApPoSJIxE/jPziawNEBbBoVqJHZQymN4
 bVAB5oWUfxozY3g7L7DyP8ONriiNVkDZcnp6kB0KiTz/L6ygC3HWbI59c1ZFHCFGHctA
 pJOUw9Pz3ZoUUkxlObaqIznJoDGC7u+7jR0keSwnUE1orcwWUCAjuY9ASYkDRrsaBImp
 mnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772080482; x=1772685282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nPkdfB8s4lf14SpLhfUVAOqZSEA4/FZoFD6WX4r7hbQ=;
 b=JSVUl4Ru1SoK8Mmevs8Xm70pSNQdW3PmRKcIQkDuF1HTVVZ6jX9lbIkJTEIwysqDcf
 6q+a5GMe4eZSWcEsNGKnlOnaFmKXfNyqZ766cOLW2WvHZw4oSqt4u5sldukZpYF+EJN5
 l/v7K5OZ68xwtxauTWRGfeleJzh1qqYDE3e+fZx/1xm7n6+l/RT7ZbviB9i7DATYh1zY
 mHm0HRB1cDqGzEpeqb9WsQljeikoNN8L/kBVXKg8ohM8F2JMveIEOusDZ4K6wePb+VwO
 RO4JTw3dOdAnVOnzvrRGal3OVUyNdBUcxhLTuawMjUT3wzBlkg7rHiDl+08OtFNsb0Kp
 cAEg==
X-Gm-Message-State: AOJu0YxDwj1ICaVe5A903DABSI+SBrLg5SiHjpuhMK4ik6YMIynhTxEr
 RkI/79OimxrUjA9TjQBWlQ/FtgUkQX44ql9wx/7ftiEGxOARdZRKWHVxXxFON+hcrk48rXQdb1V
 tSaA/kkQK+mDQoqcwXRpbSft8iaBDL+J2LtDdVV5lp/buypWj8YeTWnlHEsa9wSLvBg==
X-Gm-Gg: ATEYQzz1aq8gwOuKCf7h5rKMiQjFg3MhqQ+f7/eG/KoD37Katol4MnMcdI1kzkCdfrA
 6IWgUobCJ2MDFzHxRHVYYQU/0ZtZ4ynJQbQIvYGmtKdkBCxjMZo9dSA+F3XK9oSMJeRmu/Yqp6c
 +kJ/CBIPQYRcsMb6qRN0Ofj9ywoESXUZGUPBgZb1ehlrZVLK5dIVs+4Qe6HhWsS5GS/rC7XRLXR
 CLZ8F1gNuT1o3KSYy+/+vOBJBEUHCA3y1868jJK7Y3SbpCzoGsTdTnPyaS1XK4ZcUVMOknsDiAu
 lg4n2JlqQ0VWd9Qf/mmW6K6RpF04VqJWh9fHWXEWNaMfkxuXyVrPtZlEM7iykz9Q/9uGKBx6bSC
 k5l+d5UhtJguMlZMRlKGtO6ROgW+CtPAf1DP/qj96bPg/RsD3GKXkPyG5AwFJE8OJUXCPUQ==
X-Received: by 2002:a05:6808:6501:b0:45a:8cdc:1012 with SMTP id
 5614622812f47-4649ee854a9mr1475677b6e.20.1772080481525; 
 Wed, 25 Feb 2026 20:34:41 -0800 (PST)
X-Received: by 2002:a05:6808:6501:b0:45a:8cdc:1012 with SMTP id
 5614622812f47-4649ee854a9mr1475669b6e.20.1772080481071; 
 Wed, 25 Feb 2026 20:34:41 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a1f6333sm10394328b6e.19.2026.02.25.20.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 20:34:40 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com
Subject: [PATCH 3/3] tests/tcg/hexagon: add test for predicated .new branch
 LSB evaluation
Date: Wed, 25 Feb 2026 20:34:36 -0800
Message-Id: <20260226043436.648171-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226043436.648171-1-brian.cain@oss.qualcomm.com>
References: <20260226043436.648171-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAzNiBTYWx0ZWRfXxBUZ/PaxzmY9
 Mt6SqCu286OFOF70GKBVdAtj7MiYIABrMciLKrM7/Q4smaCk8EjiLindBv62Zm1lyW9XllJ5XTU
 4C8JjN1d//h9gOLhOXhd/6FzmxAUQPlrVQKCsKktgJKiCk1SHdHimci7yXf63mL3tGvGX0jsHTy
 VEasazjJ+3lWiiEqNIz+tO2aKohR8BKMhIIJi/rKg+A6nstDW/cWHjnP+aJRFKfhYKd/mwa3KtB
 VedueUB7IQrYOd4l4L19vIYDm9TlwHouVxSWD4Qzr9jfQEZbWJ9miUegusj8gG8iNCGQCffuBS0
 OeyX/KF6zn5AJ4gmviC/fYHJjZCQj2FnsgVIKseM7mlinKL8rQuA0zk/TuqDvEoj42tiJKxX6CO
 eEbP41LuUuJHIXEiemDhTs9fdZ1WndBBL6u92LkSEjBYCk0HpzyksfnuLZL3XfS/Zbcl1rrUTTx
 s05lHzrgHuphH3bZ2hg==
X-Proofpoint-GUID: w4VNzzlyCRXTpnQNrpAOr2R_pG3WB7-V
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699fcd62 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=E-oac-dUpCFVs3rAG8QA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: w4VNzzlyCRXTpnQNrpAOr2R_pG3WB7-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_NONE=0.001,
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

Test for predicated .new branches with non-standard predicate values
(non-all-0, non-all-1).  Hexagon predicates are 8 bits wide but conditional
branches evaluate only the LSB.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 tests/tcg/hexagon/Makefile.target        |   3 +
 tests/tcg/hexagon/test_pnew_jump_loads.c | 339 +++++++++++++++++++++++
 2 files changed, 342 insertions(+)
 create mode 100644 tests/tcg/hexagon/test_pnew_jump_loads.c

diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index f86f02bb31..5199c78536 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -81,6 +81,8 @@ HEX_TESTS += test_vminh
 HEX_TESTS += test_vpmpyh
 HEX_TESTS += test_vspliceb
 
+HEX_TESTS += test_pnew_jump_loads
+
 HEX_TESTS += v68_scalar
 HEX_TESTS += v68_hvx
 HEX_TESTS += v69_hvx
@@ -104,6 +106,7 @@ overflow: overflow.c hex_test.h
 preg_alias: preg_alias.c hex_test.h
 read_write_overlap: read_write_overlap.c hex_test.h
 reg_mut: reg_mut.c hex_test.h
+test_pnew_jump_loads: test_pnew_jump_loads.c hex_test.h
 unaligned_pc: unaligned_pc.c
 
 # This test has to be compiled for the -mv67t target
diff --git a/tests/tcg/hexagon/test_pnew_jump_loads.c b/tests/tcg/hexagon/test_pnew_jump_loads.c
new file mode 100644
index 0000000000..2cba2b4002
--- /dev/null
+++ b/tests/tcg/hexagon/test_pnew_jump_loads.c
@@ -0,0 +1,339 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Exhaustive test for predicated .new branches with non-standard predicate
+ * values (non-all-0, non-all-1).
+ *
+ * Hexagon predicates are 8 bits wide but conditional branches evaluate only
+ * bit 0 (the LSB).  A predicate value like 0xFE is non-zero yet has bit 0
+ * clear, so it must evaluate as "false".
+ *
+ * This test covers the distinct TCG code paths for predicated .new ops:
+ *
+ *   1. gen_cond_jump      - J2_jumptnewpt / J2_jumpfnewpt  (p0..p3)
+ *   2. gen_cond_jumpr     - J2_jumprtnewpt / J2_jumprfnewpt
+ *   3. gen_cond_jumpr31   - SL2_jumpr31_tnew / SL2_jumpr31_fnew (duplex)
+ *   4. gen_testbit0_jumpnv - J4_tstbit0_t/f_jumpnv_t
+ *   5. Conditional .new loads and stores
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+
+int err;
+
+#include "hex_test.h"
+
+/*
+ * Non-standard predicate: non-zero (0xFE) but bit 0 clear => false.
+ * This distinguishes correct LSB evaluation from incorrect non-zero checks.
+ */
+#define PRED_VAL    0xFEu
+#define SENTINEL    0xDEADBEEFu
+#define LOAD_VAL    0xAAAABBBBu
+
+/* gen_cond_jump (J2_jumptnewpt) */
+
+/*
+ * Macro to test jumptnew across predicate registers p0..p3.
+ * { Pn = and(Pn, Pn); if (Pn.new) jump:t TARGET }
+ *
+ * Pn.new = PRED_VAL & PRED_VAL = 0xFE => bit0=0 => not taken.
+ * Different predicate registers produce different instruction encodings.
+ */
+#define TEST_JUMPTNEW(PREG)                                     \
+static void test_jumptnew_##PREG(void)                          \
+{                                                               \
+    uint32_t jumped;                                            \
+    asm volatile(                                               \
+        #PREG " = %[pred]\n"                                    \
+        "{ " #PREG " = and(" #PREG ", " #PREG ")\n"            \
+        "  if (" #PREG ".new) jump:t 1f }\n"                   \
+        "%[jumped] = #0\n"                                      \
+        "jump 2f\n"                                             \
+        "1:\n"                                                  \
+        "%[jumped] = #1\n"                                      \
+        "2:\n"                                                  \
+        : [jumped] "=&r"(jumped)                                \
+        : [pred] "r"(PRED_VAL)                                  \
+        : #PREG                                                 \
+    );                                                          \
+    check32(jumped, 0);                                         \
+}
+
+TEST_JUMPTNEW(p0)
+TEST_JUMPTNEW(p1)
+TEST_JUMPTNEW(p2)
+TEST_JUMPTNEW(p3)
+
+/* jumpfnew: bit0=0 => condition "false" => negated => jump IS taken */
+static void test_jumpfnew_p0(void)
+{
+    uint32_t jumped;
+
+    asm volatile(
+        "p0 = %[pred]\n"
+        "{ p0 = and(p0, p0)\n"
+        "  if (!p0.new) jump:t 1f }\n"
+        "%[jumped] = #0\n"
+        "jump 2f\n"
+        "1:\n"
+        "%[jumped] = #1\n"
+        "2:\n"
+        : [jumped] "=&r"(jumped)
+        : [pred] "r"(PRED_VAL)
+        : "p0"
+    );
+    check32(jumped, 1);
+}
+
+/* gen_cond_jumpr (J2_jumprtnewpt) */
+
+static void test_jumprtnew_p0(void)
+{
+    uint32_t jumped;
+
+    asm volatile(
+        "p0 = %[pred]\n"
+        "r0 = ##1f\n"
+        "{ p0 = and(p0, p0)\n"
+        "  if (p0.new) jumpr:t r0 }\n"
+        "%[jumped] = #0\n"
+        "jump 2f\n"
+        "1:\n"
+        "%[jumped] = #1\n"
+        "2:\n"
+        : [jumped] "=&r"(jumped)
+        : [pred] "r"(PRED_VAL)
+        : "p0", "r0"
+    );
+    check32(jumped, 0);
+}
+
+static void test_jumprfnew_p0(void)
+{
+    uint32_t jumped;
+
+    asm volatile(
+        "p0 = %[pred]\n"
+        "r0 = ##1f\n"
+        "{ p0 = and(p0, p0)\n"
+        "  if (!p0.new) jumpr:t r0 }\n"
+        "%[jumped] = #0\n"
+        "jump 2f\n"
+        "1:\n"
+        "%[jumped] = #1\n"
+        "2:\n"
+        : [jumped] "=&r"(jumped)
+        : [pred] "r"(PRED_VAL)
+        : "p0", "r0"
+    );
+    check32(jumped, 1);
+}
+
+/* gen_cond_jumpr31 (SL2_jumpr31_tnew) */
+
+/*
+ * Duplex sub-instructions: only SA1_cmpeqi and similar can produce .new
+ * predicates in a duplex packet, and those only yield 0x00/0xFF.
+ * We test with standard values to exercise the duplex decode path.
+ *
+ * { p0 = cmp.eq(r0, #0); if (p0.new) jumpr:nt r31 }
+ * With r0=0: p0.new = 0xFF => bit0=1 => taken.
+ */
+static void test_jumpr31_tnew(void)
+{
+    uint32_t jumped;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r31 = ##1f\n"
+        "{ p0 = cmp.eq(r0, #0)\n"
+        "  if (p0.new) jumpr:nt r31 }\n"
+        "%[jumped] = #0\n"
+        "jump 2f\n"
+        "1:\n"
+        "%[jumped] = #1\n"
+        "2:\n"
+        : [jumped] "=&r"(jumped)
+        :
+        : "r0", "r31", "p0"
+    );
+    check32(jumped, 1);
+}
+
+/* p0.new = 0xFF => bit0=1 => !true => not taken */
+static void test_jumpr31_fnew(void)
+{
+    uint32_t jumped;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r31 = ##1f\n"
+        "{ p0 = cmp.eq(r0, #0)\n"
+        "  if (!p0.new) jumpr:nt r31 }\n"
+        "%[jumped] = #0\n"
+        "jump 2f\n"
+        "1:\n"
+        "%[jumped] = #1\n"
+        "2:\n"
+        : [jumped] "=&r"(jumped)
+        :
+        : "r0", "r31", "p0"
+    );
+    check32(jumped, 0);
+}
+
+/* gen_testbit0_jumpnv (J4_tstbit0) */
+
+/*
+ * { r0 = #0xFE; if (tstbit(r0.new, #0)) jump:t TARGET }
+ * r0.new = 0xFE => bit0=0 => tstbit false => not taken.
+ */
+static void test_tstbit0_t_jumpnv(void)
+{
+    uint32_t jumped;
+
+    asm volatile(
+        "{ r0 = #0xFE\n"
+        "  if (tstbit(r0.new, #0)) jump:t 1f }\n"
+        "%[jumped] = #0\n"
+        "jump 2f\n"
+        "1:\n"
+        "%[jumped] = #1\n"
+        "2:\n"
+        : [jumped] "=&r"(jumped)
+        :
+        : "r0"
+    );
+    check32(jumped, 0);
+}
+
+/* bit0=0 => tstbit false => negated => taken */
+static void test_tstbit0_f_jumpnv(void)
+{
+    uint32_t jumped;
+
+    asm volatile(
+        "{ r0 = #0xFE\n"
+        "  if (!tstbit(r0.new, #0)) jump:t 1f }\n"
+        "%[jumped] = #0\n"
+        "jump 2f\n"
+        "1:\n"
+        "%[jumped] = #1\n"
+        "2:\n"
+        : [jumped] "=&r"(jumped)
+        :
+        : "r0"
+    );
+    check32(jumped, 1);
+}
+
+/* conditional .new loads and stores */
+
+static uint32_t load_val;
+static uint32_t store_dst;
+
+/* bit0=0 => condition false => load skipped => sentinel remains */
+static void test_cond_load_tnew(void)
+{
+    uint32_t result;
+
+    load_val = LOAD_VAL;
+    asm volatile(
+        "p0 = %[pred]\n"
+        "%[res] = ##0xDEADBEEF\n"
+        "{ p0 = and(p0, p0)\n"
+        "  if (p0.new) %[res] = memw(%[addr]+#0) }\n"
+        : [res] "=&r"(result)
+        : [pred] "r"(PRED_VAL),
+          [addr] "r"(&load_val)
+        : "p0", "memory"
+    );
+    check32(result, SENTINEL);
+}
+
+/* bit0=0 => condition false => negated => load executed */
+static void test_cond_load_fnew(void)
+{
+    uint32_t result;
+
+    load_val = LOAD_VAL;
+    asm volatile(
+        "p0 = %[pred]\n"
+        "%[res] = ##0xDEADBEEF\n"
+        "{ p0 = and(p0, p0)\n"
+        "  if (!p0.new) %[res] = memw(%[addr]+#0) }\n"
+        : [res] "=&r"(result)
+        : [pred] "r"(PRED_VAL),
+          [addr] "r"(&load_val)
+        : "p0", "memory"
+    );
+    check32(result, LOAD_VAL);
+}
+
+/* bit0=0 => condition false => store skipped => sentinel remains */
+static void test_cond_store_tnew(void)
+{
+    store_dst = SENTINEL;
+    asm volatile(
+        "p0 = %[pred]\n"
+        "{ p0 = and(p0, p0)\n"
+        "  if (p0.new) memw(%[addr]+#0) = %[val] }\n"
+        :
+        : [pred] "r"(PRED_VAL),
+          [addr] "r"(&store_dst),
+          [val] "r"(LOAD_VAL)
+        : "p0", "memory"
+    );
+    check32(store_dst, SENTINEL);
+}
+
+/* bit0=0 => condition false => negated => store executed */
+static void test_cond_store_fnew(void)
+{
+    store_dst = SENTINEL;
+    asm volatile(
+        "p0 = %[pred]\n"
+        "{ p0 = and(p0, p0)\n"
+        "  if (!p0.new) memw(%[addr]+#0) = %[val] }\n"
+        :
+        : [pred] "r"(PRED_VAL),
+          [addr] "r"(&store_dst),
+          [val] "r"(LOAD_VAL)
+        : "p0", "memory"
+    );
+    check32(store_dst, LOAD_VAL);
+}
+
+int main(void)
+{
+    /* gen_cond_jump with all predicate registers */
+    test_jumptnew_p0();
+    test_jumptnew_p1();
+    test_jumptnew_p2();
+    test_jumptnew_p3();
+    test_jumpfnew_p0();
+
+    /* gen_cond_jumpr */
+    test_jumprtnew_p0();
+    test_jumprfnew_p0();
+
+    /* gen_cond_jumpr31 (duplex, standard values) */
+    test_jumpr31_tnew();
+    test_jumpr31_fnew();
+
+    /* gen_testbit0_jumpnv */
+    test_tstbit0_t_jumpnv();
+    test_tstbit0_f_jumpnv();
+
+    /* conditional .new loads and stores */
+    test_cond_load_tnew();
+    test_cond_load_fnew();
+    test_cond_store_tnew();
+    test_cond_store_fnew();
+
+    puts(err ? "FAIL" : "PASS");
+    return err ? 1 : 0;
+}
-- 
2.34.1


