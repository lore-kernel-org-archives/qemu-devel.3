Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E5606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dbxttDm0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eOHEMMst
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqpB-000605-O0; Fri, 30 Oct 2026 13:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqoE-0005WN-Vr
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqoC-0007pC-Tc
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:34 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERBuA2494578
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HM6vi2lDOXYcS+gRuUlUqXd4T0sR6PkiPD61VsQgo0k=; b=dbxttDm0F8/3Bqrk
 E8eTPdIlxARFeL3RfVmGVYqgIDeGURNA6XuOlKYKl0ws/CRQYGhq5R3dSOuwwU1A
 TeFADyx9Km3V14Tb9QoLnVZbqkCbvZIb28otLY36i+f6TFWOhwFnJpYqwoAo/FEa
 fXSmQurIgqWvUvAEo2VgDHXLDveReJDafpjLgnS3qxfm2Dds2QXpP7rI5A/e5cea
 BmGMuZ49FV/67nZCy0qGfL1FRwGm7sRIdJhjxCpi8unMqfyHU+roZHhwn9bGGX/6
 EQA+/5Lq5RJPTLJjL42bi8LUcocZiKxrnFI+a/YdQ7zNZUGr1WrV9s7IFxkG6bMx
 6fpBIg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p4bu4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f32050e72so249149485a.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382871; x=1793987671; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HM6vi2lDOXYcS+gRuUlUqXd4T0sR6PkiPD61VsQgo0k=;
 b=eOHEMMstpNdTTEFX4eTuffmeV7zR6dEqW0LSNUkzqelBRg48nS3w4IWJKi19O3xRHy
 uPoUAnTu8t+k7sDIOTKqQEULhCdJFKMFWTtpYgCgUQupMbJciENqJcP5MGnBzQCSIxso
 HnoFlFhxVx4FoF1M8AeXAKvVeuoQoch9dJxQvXZX7a1GToWIOUjJp/ZUQeIeab/PVcSo
 PT6V/eTXoXtB/JyVso+NhMI7YFb2uqTayqQpJLE6pk8X8AWkkRtT4O9sarRCtMxySJFe
 075uvQ1e5jSwWXOITOgZEdrWGMOmaGUky1XWhNdjNC6hX59782N/pjzXCTNyc5yWLxEw
 eZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382871; x=1793987671;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HM6vi2lDOXYcS+gRuUlUqXd4T0sR6PkiPD61VsQgo0k=;
 b=g9zADjl0doeAAcRC77OkIa08vEJx9IJaKVgq6jkyDqP1/m5CYMUfjuzW7kFU1h928D
 BwHbjchOrt55sqodmfNf6tMT2ZxWblIbUiHpv+CbicMUQcowUjqBTHvGlMNhz50nlAhk
 ZwMpjmEDiEg4Kv1hQEb/1fgF3OEjhUWqLC7Scz17Lon9vlqW7EqtYqyBQypjsnSF8WDi
 VJJm8NEu0Bm93FEZl7HoRfEavO8XK10TcxDvRQDW5srxexcghrfl8MEEwTj8MH6GTqCs
 luO/jgb5bIybQVah7NrKiiRT9MGcANqNKso3ls9b8g192/hbwrRZ69JnmOatSsldcwvp
 d5ww==
X-Gm-Message-State: AFq9FYLrirIzXkpfCG9TPLopdVPS4/de42PpHkBfA2ojrZjxST5rJi4b
 Gsst8KL+H10DvIk6tfNbZY9LwVvvNKmMMi9oolvOgoN4iXVvNdWlArKwbG6C4Rf20FcWNUBLZn4
 20dxdGIJADOwvLBnuFbcdqNq1e3raNxapT7iAwi28mfSmJjcpih6NNeH58Fezm4jUdXy8
X-Gm-Gg: AYBFou0sxZvGPsIeX0oHYEdPR6dTt3/KkTdNFTH+23nUFvR4+G0vivAhK/jTInmZV1Z
 m5CUrDTKCLDGqbQESurPGTcHGWIBnPGTOXL0vaHIQgyKnXpkGHiv4YaYt6OMacQZFUCY4hmrN2e
 X74vuiBK0Tc282/JHSD7N+wFZvTwNSktQLCr1k5s+Z6djSt87zjQkEEhIzF+Sd4w4S6ZDW0JOtV
 rhyoaZMDGmQjhMpZ7ytDYYMKOPoGOIe7vXXGfIDgGvoPceZzkf8jy8z4cYBPbuf0t6aXPUzYeSf
 jyqmf4cGrclKlvDFH/VFEgF1Q2D55cO+rN7CH43zYniF2MUy1qIKBowBjstTf4sy1y42VW3uSXE
 srLjgL0WeGLXxPr1iYts2Z7uN5XbELo3RyMC8Hp9wZ0AXe+7dD+OqrfrJN2rlK9e3+kPtkxMNuq
 Wv61nkhBvnc1cbT5nkXolwv+dC1s2o6Q==
X-Received: by 2002:a05:620a:31a2:b0:93e:c12c:fbb7 with SMTP id
 af79cd13be357-94421729bf3mr494352585a.68.1793382871151; 
 Fri, 30 Oct 2026 10:54:31 -0700 (PDT)
X-Received: by 2002:a05:620a:31a2:b0:93e:c12c:fbb7 with SMTP id
 af79cd13be357-94421729bf3mr494349685a.68.1793382870606; 
 Fri, 30 Oct 2026 10:54:30 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b27e46sm116749595e9.3.2026.10.30.10.54.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:54:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 04/32] tests/tcg/mips: Group DSP cmp tests
Date: Fri, 30 Oct 2026 18:53:26 +0100
Message-ID: <20261030175357.99684-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX05XsdA5EmIgC
 q0D2oJwwFOZXWlO3iFYYGl8zF8e0PQEN5slco0CoPZmWyW7HVK8xdFlx5oWd7FdCgk1kdivyUsy
 JofzWs7/hWIqxPAySQOXRvjhlukHkgodxgj/PSVyhUVx+yp+Umq4kUR6pdYmZoTtx3L0BM/lMgX
 n3H29QOz+mgruXyOnrlKnH5IDP05aozgtFtaLUswrbQpolYNcuGnRAOfyJ+Na1tT1tGixVtABqU
 b0Xe7NJo6lOY4ciYz/0z1P9a8voG4TiYMH4nCZRsncqzDLfAWmP3FGImG3nO8utPC1QU8YOdoG3
 Mz4eM3fmiTjQ4zsi/NV8e59uKYH4QAT937XrsCPxaNNJpSNKAd0m2dFUGLgkFPV6SfTB3rq7ZWC
 KI8u186yszUvEfib6sQQU1/huP+pFPeCIrb9zuGUflNL94dhHAACEzG7ZuwXgB61QXnNddbL16v
 auR8FkaAdjwnfk/Sjcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX7BKs8s7ISx8Z
 vGfLaQTA1U/dh4KWqLlkYrxXjcGiJOPT3axMGygX0URYcOEywhtEs3go2WHkbEaUvJ5hsQK6ewZ
 O2qwnlj2tY9wz3BBHV8WBwNa+SyxH8I=
X-Proofpoint-ORIG-GUID: DTnPtR7QKKmcvyDuoQHHQ77li9nb4hjD
X-Proofpoint-GUID: DTnPtR7QKKmcvyDuoQHHQ77li9nb4hjD
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4d9d7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=TrVlaqBlz6Hw94NMQc4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Build the 14 per-opcode cmp tests as a single executable,
test_dsp_cmp.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_cmp.c             | 84 +++++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c    |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c    |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c    |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c   |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c   |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c   |  1 -
 tests/tcg/mipsel/test_dsp_r1_pick_ph.c      |  1 -
 tests/tcg/mipsel/test_dsp_r1_pick_qb.c      |  1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c |  1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c |  1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c |  1 -
 tests/tcg/mipsel/meson.build                | 15 +---
 16 files changed, 85 insertions(+), 28 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_cmp.c

diff --git a/tests/tcg/mipsel/test_dsp_cmp.c b/tests/tcg/mipsel/test_dsp_cmp.c
new file mode 100644
index 000000000000..de59f2819792
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_cmp.c
@@ -0,0 +1,84 @@
+/*
+ * MIPS DSP ASE tests: Compare and Pick instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_cmp_eq_ph
+#include "test_dsp_r1_cmp_eq_ph.c"
+#undef main
+
+#define main test_dsp_r1_cmp_le_ph
+#include "test_dsp_r1_cmp_le_ph.c"
+#undef main
+
+#define main test_dsp_r1_cmp_lt_ph
+#include "test_dsp_r1_cmp_lt_ph.c"
+#undef main
+
+#define main test_dsp_r1_cmpgu_eq_qb
+#include "test_dsp_r1_cmpgu_eq_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpgu_le_qb
+#include "test_dsp_r1_cmpgu_le_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpgu_lt_qb
+#include "test_dsp_r1_cmpgu_lt_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpu_eq_qb
+#include "test_dsp_r1_cmpu_eq_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpu_le_qb
+#include "test_dsp_r1_cmpu_le_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpu_lt_qb
+#include "test_dsp_r1_cmpu_lt_qb.c"
+#undef main
+
+#define main test_dsp_r1_pick_ph
+#include "test_dsp_r1_pick_ph.c"
+#undef main
+
+#define main test_dsp_r1_pick_qb
+#include "test_dsp_r1_pick_qb.c"
+#undef main
+
+#define main test_dsp_r2_cmpgdu_eq_qb
+#include "test_dsp_r2_cmpgdu_eq_qb.c"
+#undef main
+
+#define main test_dsp_r2_cmpgdu_le_qb
+#include "test_dsp_r2_cmpgdu_le_qb.c"
+#undef main
+
+#define main test_dsp_r2_cmpgdu_lt_qb
+#include "test_dsp_r2_cmpgdu_lt_qb.c"
+#undef main
+
+int main(void)
+{
+    TAP_START();
+    RUN_TEST(test_dsp_r1_cmp_eq_ph);
+    RUN_TEST(test_dsp_r1_cmp_le_ph);
+    RUN_TEST(test_dsp_r1_cmp_lt_ph);
+    RUN_TEST(test_dsp_r1_cmpgu_eq_qb);
+    RUN_TEST(test_dsp_r1_cmpgu_le_qb);
+    RUN_TEST(test_dsp_r1_cmpgu_lt_qb);
+    RUN_TEST(test_dsp_r1_cmpu_eq_qb);
+    RUN_TEST(test_dsp_r1_cmpu_le_qb);
+    RUN_TEST(test_dsp_r1_cmpu_lt_qb);
+    RUN_TEST(test_dsp_r1_pick_ph);
+    RUN_TEST(test_dsp_r1_pick_qb);
+    RUN_TEST(test_dsp_r2_cmpgdu_eq_qb);
+    RUN_TEST(test_dsp_r2_cmpgdu_le_qb);
+    RUN_TEST(test_dsp_r2_cmpgdu_lt_qb);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
index 957bd88ce01f..47406f77c59e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
index 356f156c5d1f..811646d78e84 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
index 3fb4827ad761..430953a77215 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
index 2615c84c75c7..1fd5b523a44e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
index 65d0813c3b19..da1277065246 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
index 7dddad98532c..9317f9a3fa44 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
index 680f2a1999d8..8736e7fc45ad 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
index 43cfa509ca3c..fbc620adf95d 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
index 074ca5b402de..8132b13a97c2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_pick_ph.c b/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
index 929a002e7544..0a11b5d12ce3 100644
--- a/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_pick_qb.c b/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
index a79047524662..8def9559d632 100644
--- a/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
index 2d6340d6fb12..cfc71839591a 100644
--- a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
index a0ecdca2ac2e..9e7d8260cfa7 100644
--- a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
index dba99e392c29..ec964e39074f 100644
--- a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index e7e576ad6c19..e8737308c40d 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -6,17 +6,9 @@ tests += tcg_tests['multiarch-linux-user']['tests']
 tests_dsp = [
   'test_dsp_acc.c',
   'test_dsp_arith.c',
+  'test_dsp_cmp.c',
   'test_dsp_r1_bitrev.c',
   'test_dsp_r1_bposge32.c',
-  'test_dsp_r1_cmp_eq_ph.c',
-  'test_dsp_r1_cmp_le_ph.c',
-  'test_dsp_r1_cmp_lt_ph.c',
-  'test_dsp_r1_cmpgu_eq_qb.c',
-  'test_dsp_r1_cmpgu_le_qb.c',
-  'test_dsp_r1_cmpgu_lt_qb.c',
-  'test_dsp_r1_cmpu_eq_qb.c',
-  'test_dsp_r1_cmpu_le_qb.c',
-  'test_dsp_r1_cmpu_lt_qb.c',
   'test_dsp_r1_dpaq_s_w_ph.c',
   'test_dsp_r1_dpaq_sa_l_w.c',
   'test_dsp_r1_dpau_h_qbl.c',
@@ -45,8 +37,6 @@ tests_dsp = [
   'test_dsp_r1_mult.c',
   'test_dsp_r1_multu.c',
   'test_dsp_r1_packrl_ph.c',
-  'test_dsp_r1_pick_ph.c',
-  'test_dsp_r1_pick_qb.c',
   'test_dsp_r1_preceq_w_phl.c',
   'test_dsp_r1_preceq_w_phr.c',
   'test_dsp_r1_precequ_ph_qbl.c',
@@ -85,9 +75,6 @@ tests_dsp = [
   'test_dsp_r1_wrdsp.c',
   'test_dsp_r2_append.c',
   'test_dsp_r2_balign.c',
-  'test_dsp_r2_cmpgdu_eq_qb.c',
-  'test_dsp_r2_cmpgdu_le_qb.c',
-  'test_dsp_r2_cmpgdu_lt_qb.c',
   'test_dsp_r2_dpa_w_ph.c',
   'test_dsp_r2_dpaqx_s_w_ph.c',
   'test_dsp_r2_dpaqx_sa_w_ph.c',
-- 
2.55.0


