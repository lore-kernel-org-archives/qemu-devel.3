Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB5606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=grZqRLjn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BTAnPQnN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTrH-0005fk-5e; Thu, 29 Oct 2026 13:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTrG-0005fW-Cf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTrE-000153-5S
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDe3R3689779
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K3eN+w3r/PONCOF9kLaw93/1PrdC3ACQ5advhIISjXo=; b=grZqRLjnfCWpAXph
 xQ3bGIwuVI8hCr6AozWMFYQJZpASutMt03XG4CtVX83JVwMY/0h9AqGbax/e9AhY
 TZmib+czZC+MC+b4ylqW5Xv9bxBiQH/Yx4k7YspLdzfLa7y5o8evTnE6mGGX+sxf
 0uSSnkgriZQf8GsumcmoCLJcRPnJ1RwDdDQtoPMyYZ4Pb9BoRj/IyTfBu2Rv1Ps9
 adXf7WTSM347dZSIWSwAgJYwlfg4ZO8pf55Hyr3QX691T4qmMd/AElwIaVRlkmMA
 Rk4CgjWNi7x2z/4qOdWvOeYDs1IFlMeNTqgmk4Crxjmj8N60mKxkzQVuhpbBkQ1O
 rze3ZQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5sb77x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:07 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9905fc56b60so785970241.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294646; x=1793899446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K3eN+w3r/PONCOF9kLaw93/1PrdC3ACQ5advhIISjXo=;
 b=BTAnPQnN8UnyCPJMpgHObSXY/deVACpljoGjjvRBe8MlRDHA2kvqlB1vneQYE54sNL
 X6upCIjG3mj3+AmaQCSdztJYgMXKPC9vVWzwZbXseojR1dgQ5dBfUC/JZb55AfcZunsp
 iDv+TPRiC4Bir8ahKWp6s+hMe1tGYF/QP1l4nV78rEdPj6jBW69upSI6K6uOikaUMErE
 VVRXBRYwCq07DNtr50hIrcoSpt8DgkUI+41pQUhU1FFydDvnsLxaFahHF+n9sBwowLv7
 /PbhjxLIZZGOa2WnVZ4caABv4SzPBJrExiwXyJj4JabLtcnTitJ5VBeeBqI60OfHR/ph
 4N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294646; x=1793899446;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K3eN+w3r/PONCOF9kLaw93/1PrdC3ACQ5advhIISjXo=;
 b=NgJsX4FCAXPOhs2GAIFdHJJQ/0JG41cG14dQRu3Qj15h8Y4VfH4HBw0hNdAnkl4Uwg
 SCQdLL5ce9MLEdMw1FAoV4p6ZVGlJusTXKVIm4gkWTmeni84iU5stbR9ssRa8gMUoOBz
 V3RDb4eKxzM0SgGv0M2a4Emg4TsGUHWGrB0S2s1nD6tiEmnC3c3zePJY+3jhYvvZOOxv
 SiMbOtTHD2331F6srbYx1quXHq2gZ+aXJKJlLXPfNxtlcihzpOBI2FEfGNEZVxaHxSfA
 5I9g9NjzQFynv3vOmiZHrt/EknKwiCGZZ1mV9OVQnCuSfQVhPDCxEzGJPAkfXB7mznnF
 5mPg==
X-Gm-Message-State: AFq9FYLStY/v78lsdf/JJqOjPMiC94ErnczqOLjl7MfG3XyHZnfZKkr7
 4t2PAWgq2ozY60T1DBaBmTaPcq6O08QQnuWyZTlHl5GK2AYYexkwsaNdMlnQyjRqmi8cH63CaUX
 df4/+8Xa3Zi+FYjJxBA1t3ICZuS8VYvkdK13VJKGhjpRfGMqvRDEn7J5QeeGlr9yN/KBk
X-Gm-Gg: AYBFou3Tn7SQS8zZr45REl0bjBVTOxApu3ErnmOpiSD1hdFpM/4CIbHUU16IYj7Bf0t
 R0+jxfWdFrArGKg2z02LTM2nyqgBDQPZUbLpZiFtjrRG5rUo2qrImX5hxhC9ZFE2HKThnNrsmkr
 ypdXDs3jZ9Rbu9PMgbLBKOUjyKqXuSzVXlDIf6B0tyqiLVJotj/d4V+T0tjCqTzDwr2iMLjpaNR
 ffL90xCadASRS5OtAqCQ8YOm6sqvoE2jCkM1V6q0pqMiCfjGFtfX0M7J4VxxmMahVM+hIsJLEWv
 nu07aFyWO4KYtnSKIxXLos46jjJTaHmYnqTwuBN9vZEltN1Edtv20G3TPcd+FB0n9zZFzfvF9Im
 zoj9TqFTCe8vGFZCIO/HGUrMoY1UZZPCeM9Ha7MHaooyNspoOtH9KBWC9F3p8JEIDjD2gaT8xfo
 O7kSAhDQj+hnFzG+qSI6L+A4K0xQJyIw==
X-Received: by 2002:a05:6102:3907:b0:7ca:5626:11e with SMTP id
 ada2fe7eead31-7d054340e35mr1085625137.36.1793294646232; 
 Thu, 29 Oct 2026 10:24:06 -0700 (PDT)
X-Received: by 2002:a05:6102:3907:b0:7ca:5626:11e with SMTP id
 ada2fe7eead31-7d054340e35mr1085614137.36.1793294645789; 
 Thu, 29 Oct 2026 10:24:05 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfbaa2dsm390375f8f.52.2026.10.29.10.24.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:24:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 06/31] tests/tcg/mips: Group DSP mul tests
Date: Thu, 29 Oct 2026 18:22:50 +0100
Message-ID: <20261029172319.25766-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX/ml//pyQuE0K
 wcgepTjb0EQOQs3N7BhF+pNaoZeSfgmQZpS1pFDp5+K0uhD6Y5TMrO8IWcbOlQ4dhfAyfkvgaH5
 OoHbM0/VLYZFa5VdYqu222mKaNxsuA4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX3fLmC0PJG4o7
 Qdr0wpgjMP5Ru5Ezhzj+MY3cw3TWhAgyvNQWviVj0JNZZuxdrFA/2xyhT5wMoKMP9xJE0nLQjHn
 qLwF2z7Blo20fXfnwrlAVLjiZJ/1vSpQ9q8+uSwdYRuh9NQrmYeW4P+j/Mnnv2//H2MB6U+EdYL
 w/0PF4lu8qfvIrN4fYn7W9rR898Nb6MXcsPCa4X6iQRmuM+T8zPAixO8dSoWQeYE9NZEAjTShDr
 98zBWhaFETpFHhDj6ICifjf6QnDI2Wv4eqj+wRDwY/YJgYPWIzJc9lBWxXUAkzcnmHhHPgWhugQ
 og+v3Bi++n2WB0QV7X7DtouuNK87GTDqX24DhS33jCeE4GDT8tDT2gYtd6C6p7N4sh5p56uO5Cx
 5erpA6x1kCpsGrU4HzlLb4SZ8ayveQ==
X-Proofpoint-ORIG-GUID: uScKnPKwzd3lq5j4TyY243PKepciOrON
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae38137 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=OUIqsWA_ulB3aGyEHOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: uScKnPKwzd3lq5j4TyY243PKepciOrON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the 10 per-opcode mul tests as a single executable,
test_dsp_mul.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_mul.c               | 67 +++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c |  1 -
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c |  1 -
 tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c     |  1 -
 tests/tcg/mipsel/test_dsp_r2_mul_ph.c         |  1 -
 tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c       |  1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c      |  1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c      |  1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c       |  1 -
 tests/tcg/mipsel/meson.build                  | 11 +--
 12 files changed, 68 insertions(+), 20 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_mul.c

diff --git a/tests/tcg/mipsel/test_dsp_mul.c b/tests/tcg/mipsel/test_dsp_mul.c
new file mode 100644
index 000000000000..f7189d94dfe6
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_mul.c
@@ -0,0 +1,67 @@
+/*
+ * MIPS DSP ASE tests: Multiply instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_muleq_s_w_phl
+#include "test_dsp_r1_muleq_s_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_muleq_s_w_phr
+#include "test_dsp_r1_muleq_s_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_muleu_s_ph_qbl
+#include "test_dsp_r1_muleu_s_ph_qbl.c"
+#undef main
+
+#define main test_dsp_r1_muleu_s_ph_qbr
+#include "test_dsp_r1_muleu_s_ph_qbr.c"
+#undef main
+
+#define main test_dsp_r1_mulq_rs_ph
+#include "test_dsp_r1_mulq_rs_ph.c"
+#undef main
+
+#define main test_dsp_r2_mul_ph
+#include "test_dsp_r2_mul_ph.c"
+#undef main
+
+#define main test_dsp_r2_mul_s_ph
+#include "test_dsp_r2_mul_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulq_rs_w
+#include "test_dsp_r2_mulq_rs_w.c"
+#undef main
+
+#define main test_dsp_r2_mulq_s_ph
+#include "test_dsp_r2_mulq_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulq_s_w
+#include "test_dsp_r2_mulq_s_w.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    RUN_TEST(test_dsp_r1_muleq_s_w_phl);
+    RUN_TEST(test_dsp_r1_muleq_s_w_phr);
+    RUN_TEST(test_dsp_r1_muleu_s_ph_qbl);
+    RUN_TEST(test_dsp_r1_muleu_s_ph_qbr);
+    RUN_TEST(test_dsp_r1_mulq_rs_ph);
+    RUN_TEST(test_dsp_r2_mul_ph);
+    RUN_TEST(test_dsp_r2_mul_s_ph);
+    RUN_TEST(test_dsp_r2_mulq_rs_w);
+    RUN_TEST(test_dsp_r2_mulq_s_ph);
+    RUN_TEST(test_dsp_r2_mulq_s_w);
+
+    DSP_TAP_PLAN();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
index b3a5370fe59e..e9b0dc55071b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
index 8066d7d02a1e..a8238c673293 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
index 66a382806a21..ce16164bc853 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
index 4cc6c8f7cfe1..2baedb9f53a5 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c b/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
index 370c2a801832..bd2ab49b0717 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mul_ph.c b/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
index c7e9d60d12e2..bb92f6cbc0f1 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
index 33da110de869..092dd531f421 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c b/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
index 7ba633bc17f7..f94c1678af09 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
index 00e015542e69..8c944c6ea3fa 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c b/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
index 9c2be06cc08a..caa8e8d76193 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index c26f5fba06b7..4991c14b7bf8 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -9,13 +9,9 @@ tests_dsp = [
   'test_dsp_cmp.c',
   'test_dsp_ctrl.c',
   'test_dsp_dot.c',
+  'test_dsp_mul.c',
   'test_dsp_r1_bitrev.c',
   'test_dsp_r1_insv.c',
-  'test_dsp_r1_muleq_s_w_phl.c',
-  'test_dsp_r1_muleq_s_w_phr.c',
-  'test_dsp_r1_muleu_s_ph_qbl.c',
-  'test_dsp_r1_muleu_s_ph_qbr.c',
-  'test_dsp_r1_mulq_rs_ph.c',
   'test_dsp_r1_packrl_ph.c',
   'test_dsp_r1_preceq_w_phl.c',
   'test_dsp_r1_preceq_w_phr.c',
@@ -53,11 +49,6 @@ tests_dsp = [
   'test_dsp_r1_shrlv_qb.c',
   'test_dsp_r2_append.c',
   'test_dsp_r2_balign.c',
-  'test_dsp_r2_mul_ph.c',
-  'test_dsp_r2_mul_s_ph.c',
-  'test_dsp_r2_mulq_rs_w.c',
-  'test_dsp_r2_mulq_s_ph.c',
-  'test_dsp_r2_mulq_s_w.c',
   'test_dsp_r2_precr_qb_ph.c',
   'test_dsp_r2_precr_sra_ph_w.c',
   'test_dsp_r2_precr_sra_r_ph_w.c',
-- 
2.55.0


