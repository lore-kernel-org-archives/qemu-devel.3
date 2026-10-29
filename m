Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CB8606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S365xwt9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q7Kmmc+y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTqi-0005NA-QC; Thu, 29 Oct 2026 13:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTqg-0005Mb-In
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:23:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTqe-00011f-2E
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:23:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDcRT3234408
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5eg6uSseI+IZO9BGPPQfXo4QrI9rpBHetd0vGRv2qP0=; b=S365xwt9M3AYICpw
 R+RU1zK8RLk+Vu3K0RzL9TF8qp3XbK45r3fDK0qy82H6e9QU+rvrFxeORqyLpLZx
 2d4D0riVMND+RKQEDkqoRJIMVZwyGVSHd4mhhN7e4uq3zL5oZ8vDY2pE3uVFzAT5
 BOIbYSqnLPzfEzuPAFd1t/+Dgh6N/dodqSFIBx8Z1qIbcMcsN3oOI2cc2HJmANMW
 54cYC5sgVi0Okwt4R8FdueZ7YJBakMrcGsf/6065rBQbR03r+uZVKp+1IDXW3s1+
 30ddA9+VOV/wHdaR7JnwoSUpQCEQJo+bPUtP61ALRuLBOdD2Ss7MYLFuYujqwOLY
 EVUTOg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b2459-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:23:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso443717485a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294610; x=1793899410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5eg6uSseI+IZO9BGPPQfXo4QrI9rpBHetd0vGRv2qP0=;
 b=Q7Kmmc+yaEfZ1tC2Yg0MWZVQ0wOGsgPh6oyw5Km7FyV5Eg7nhyvWtf9O0twsYxxDdu
 5SfNvQBcuiVAKstOVWNiCA7VgHgdoXsrO9Hboz3BDQuvcHBIM8qUxG3hzs/CEdClqeQb
 mqvh74fZKX//bRw4dgbI7S3AUfWV0WZg6D03LfWGInCTwNaRgpb/ZEK1ROqDkQVjXI/6
 wPxHcQGYG+2ZDOujgMbc9pX5Gs6K6taitnsjyTbZpMTbqvOCq2236ISaPjwcAgiEyvFC
 Cixfzvr7Svk2E6fPwbHN8nZhW19e2fDmL0cq5+u8vvjaJp3YGHJ5MJ4t7ZJ9iWtQZ79N
 /MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294610; x=1793899410;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5eg6uSseI+IZO9BGPPQfXo4QrI9rpBHetd0vGRv2qP0=;
 b=S78KGUEWBjclu1Cvt2p/b+lnk/B/CbQqq3IOS/WXHRSTPfP7bIeR7KD9Dld9z2NPS7
 /+i5hIhgCbei/txLarq9D3W65NKpoFKGvzmTDlzxqgBVzP0DoOdI3xK39lJ93+WMVnFb
 E8OEmGS2KDyAopHmspDxYyo2WcUKoia85oStkW0UgbJLKHFsMQ1bvgPDI9OAUYxSyMbA
 j1KF6MiNKgO6XRGTKydM+2b3txH6mcc+8A3hrhAE2UxHx/kSV0XMHfAvwgh3B36sFSjY
 N9zqGPbxUNJ5JGNi+rBGIiXE/MIn2lRQ8xDE0JP+J2sR+3xfNsKxFcBA+ToAPOsoHZOC
 CEUg==
X-Gm-Message-State: AFq9FYLFSMm0bbqAx/yXQEQ2KUOMYnLGpcvfS3yOAip7wLYc88bV9hbY
 pfNW3zuQj6FI8IJ2qnMKnrCeAyxydl0Mkjp1l68RGoJCN0CPrerxOnexMl2WdU/EpwEAehdE115
 B/6KdVRTAwbSuJZsA46cIdqCE9cOAkaRRmTz2MFKyPYH0Wh2KeOfQO9O2wgYdHLTIk/h1
X-Gm-Gg: AYBFou3Wnfoq+bkti1YoSc4l1a3SySuyL+QqvQHgwRsQr6BaBYmSMKs6Cl5j+sXgsHD
 198YQypaovURdK6GAL3fja/49csWTHSUxvl0rjnB+f6FSS8inbZ3ofvq+WcqKg4YRhLgCRgiQ78
 fzpBfpfnKo3JjYyvYJxMWpGuP4S3Z7IqEN2A6MdeK3KIclQZDLlpCp3qvV9jRx8/N8p8Fx9daVU
 8BkBIoz1XYDZIkr6/1RQo6E2xusTqd+jMtWwVvGVWWr9IZDS4Px3iCpBPyJNPPCLT5whDAmhWUi
 LZ4dAtl4gND7aq1oenND8iHnEbK83+BZUHFk4qZ6lcVDa+r1dbrVpDsv1I8nHltF5uxwULP4NqJ
 4Ehk4e7cktEd1RxAAX4OdfSLqtzORChqobAgmcKuuoK6japlFZAhlg3Lp+v64EntfKsFq5jyjJm
 lS+HV0kyfM5fkTH5lsk7jmKSMxc9zp9A==
X-Received: by 2002:a05:620a:4008:b0:93c:6534:d04d with SMTP id
 af79cd13be357-94408c94a0dmr966423785a.35.1793294609360; 
 Thu, 29 Oct 2026 10:23:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4008:b0:93c:6534:d04d with SMTP id
 af79cd13be357-94408c94a0dmr966418985a.35.1793294608787; 
 Thu, 29 Oct 2026 10:23:28 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf0b36853sm951375e9.0.2026.10.29.10.23.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:23:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 01/31] tests/tcg/mips: Group DSP acc tests
Date: Thu, 29 Oct 2026 18:22:45 +0100
Message-ID: <20261029172319.25766-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX2W1X3bucbQQf
 448RX8zybX5TFCcJ4C2NOl1eBgHUzqrtlPzUTbmU6py+qxMB0zY3N3IUjD/PgwEo24sGB3aqQw5
 NbLlH3qq4r+UsaJ18ozmjg2H8HyK1oM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX+ozl2Mwy6Xu7
 9z0RtZYycC3J1vxJJUmUt7kvR0bfpR6A8T9iBKvKFKi58lznJwBfuetBGMzaoEaBhwwf4z7xZQT
 KtyC+AZ3UTp9r7WhACzUn0q5vwt6lPCYL8I3m+KEsGfoDf/Ujn65ngv7h9L+ZK+z4JxC/bQEJe8
 odlUZko//U9+anAzkau+CzZwVZ92Imob/xsCXYTozrVPPe2hMGVvHeUGQ1zERv/WutdXktVz8b0
 tohj0mqmiYHhE8pED9DiuR5/7Uy86k9ebNfOyYDF0blIrlswsNKIvS1NrFj4OltyH84CpRQ6Fwh
 KXygpsS9uDScqV7aa7Fd5uorhO1hVbNkkveNULkBqE0S/Pz00ecvpy8x68GhFuhPU2YWTcTuGu5
 Zhepqyz7iTGYk8rY/jJ2Hv1CYtzJ6o2wPLlqTavRaxHdqZA3NKcNFeP+uO5qmvTIURZW/Netn7m
 2vIPK2DI6sKWpVT/4qg==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae38112 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=RKuGlSn1PhqL2lZPwEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 5ANa3Sl7TbbUf6q9RJ8FykDYfF6FHQoW
X-Proofpoint-ORIG-GUID: 5ANa3Sl7TbbUf6q9RJ8FykDYfF6FHQoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Build the 19 per-opcode acc tests as a single executable,
test_dsp_acc.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Add test_dsp_runner.h: assert() only counts failures, and
RUN_TEST() resets DSPControl and reports each test in TAP.
Drop the unused hello-world test.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_runner.h        |  39 ++++++++
 tests/tcg/mipsel/test_dsp_acc.c           | 112 ++++++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_extp.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_extpdp.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_extpdpv.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_extpv.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_extr_r_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_extr_s_h.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_extr_w.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_extrv_w.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_main.c       |   6 --
 tests/tcg/mipsel/test_dsp_r1_mfhi.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_mflo.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_mthi.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_mthlip.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_mtlo.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shilo.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_shilov.c     |   1 -
 tests/tcg/mipsel/meson.build              |  21 +---
 23 files changed, 152 insertions(+), 45 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_runner.h
 create mode 100644 tests/tcg/mipsel/test_dsp_acc.c
 delete mode 100644 tests/tcg/mipsel/test_dsp_r1_main.c

diff --git a/tests/tcg/mipsel/test_dsp_runner.h b/tests/tcg/mipsel/test_dsp_runner.h
new file mode 100644
index 000000000000..4fde59e97825
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_runner.h
@@ -0,0 +1,39 @@
+/*
+ * Helpers to run several DSP ASE tests from the same process: assert()
+ * only counts failures, and RUN_TEST() reports one status line per test,
+ * after resetting DSPControl, in TAP format. A test calling RUN_TEST() must
+ * end with DSP_TAP_PLAN().
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef TEST_DSP_RUNNER_H
+#define TEST_DSP_RUNNER_H
+
+#include <stdio.h>
+
+static int dsp_failures;
+static int dsp_tests;
+
+#undef assert
+#define assert(cond) \
+    do { \
+        if (!(cond)) { \
+            printf("# FAIL %s:%d: %s\n", __FILE__, __LINE__, #cond); \
+            dsp_failures++; \
+        } \
+    } while (0)
+
+#define RUN_TEST(fn) \
+    do { \
+        int ret_; \
+        dsp_failures = 0; \
+        __asm__ volatile("wrdsp $zero, 0x3f\n\t"); \
+        ret_ = fn(); \
+        printf("%s %d - %s\n", (ret_ || dsp_failures) ? "not ok" : "ok", \
+               ++dsp_tests, #fn); \
+        ret |= ret_ || dsp_failures; \
+    } while (0)
+
+#define DSP_TAP_PLAN() printf("1..%d\n", dsp_tests)
+
+#endif
diff --git a/tests/tcg/mipsel/test_dsp_acc.c b/tests/tcg/mipsel/test_dsp_acc.c
new file mode 100644
index 000000000000..7eebaa4ca2e3
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_acc.c
@@ -0,0 +1,112 @@
+/*
+ * MIPS DSP ASE tests: Accumulator access and Extract instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_extp
+#include "test_dsp_r1_extp.c"
+#undef main
+
+#define main test_dsp_r1_extpdp
+#include "test_dsp_r1_extpdp.c"
+#undef main
+
+#define main test_dsp_r1_extpdpv
+#include "test_dsp_r1_extpdpv.c"
+#undef main
+
+#define main test_dsp_r1_extpv
+#include "test_dsp_r1_extpv.c"
+#undef main
+
+#define main test_dsp_r1_extr_r_w
+#include "test_dsp_r1_extr_r_w.c"
+#undef main
+
+#define main test_dsp_r1_extr_rs_w
+#include "test_dsp_r1_extr_rs_w.c"
+#undef main
+
+#define main test_dsp_r1_extr_s_h
+#include "test_dsp_r1_extr_s_h.c"
+#undef main
+
+#define main test_dsp_r1_extr_w
+#include "test_dsp_r1_extr_w.c"
+#undef main
+
+#define main test_dsp_r1_extrv_r_w
+#include "test_dsp_r1_extrv_r_w.c"
+#undef main
+
+#define main test_dsp_r1_extrv_rs_w
+#include "test_dsp_r1_extrv_rs_w.c"
+#undef main
+
+#define main test_dsp_r1_extrv_s_h
+#include "test_dsp_r1_extrv_s_h.c"
+#undef main
+
+#define main test_dsp_r1_extrv_w
+#include "test_dsp_r1_extrv_w.c"
+#undef main
+
+#define main test_dsp_r1_mfhi
+#include "test_dsp_r1_mfhi.c"
+#undef main
+
+#define main test_dsp_r1_mflo
+#include "test_dsp_r1_mflo.c"
+#undef main
+
+#define main test_dsp_r1_mthi
+#include "test_dsp_r1_mthi.c"
+#undef main
+
+#define main test_dsp_r1_mthlip
+#include "test_dsp_r1_mthlip.c"
+#undef main
+
+#define main test_dsp_r1_mtlo
+#include "test_dsp_r1_mtlo.c"
+#undef main
+
+#define main test_dsp_r1_shilo
+#include "test_dsp_r1_shilo.c"
+#undef main
+
+#define main test_dsp_r1_shilov
+#include "test_dsp_r1_shilov.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    RUN_TEST(test_dsp_r1_extp);
+    RUN_TEST(test_dsp_r1_extpdp);
+    RUN_TEST(test_dsp_r1_extpdpv);
+    RUN_TEST(test_dsp_r1_extpv);
+    RUN_TEST(test_dsp_r1_extr_r_w);
+    RUN_TEST(test_dsp_r1_extr_rs_w);
+    RUN_TEST(test_dsp_r1_extr_s_h);
+    RUN_TEST(test_dsp_r1_extr_w);
+    RUN_TEST(test_dsp_r1_extrv_r_w);
+    RUN_TEST(test_dsp_r1_extrv_rs_w);
+    RUN_TEST(test_dsp_r1_extrv_s_h);
+    RUN_TEST(test_dsp_r1_extrv_w);
+    RUN_TEST(test_dsp_r1_mfhi);
+    RUN_TEST(test_dsp_r1_mflo);
+    RUN_TEST(test_dsp_r1_mthi);
+    RUN_TEST(test_dsp_r1_mthlip);
+    RUN_TEST(test_dsp_r1_mtlo);
+    RUN_TEST(test_dsp_r1_shilo);
+    RUN_TEST(test_dsp_r1_shilov);
+
+    DSP_TAP_PLAN();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_extp.c b/tests/tcg/mipsel/test_dsp_r1_extp.c
index b18bdb34c872..5f9e81f51e97 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extp.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extp.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_extpdp.c b/tests/tcg/mipsel/test_dsp_r1_extpdp.c
index 79ee16e8b87c..6dec2bb31617 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extpdp.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extpdp.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_extpdpv.c b/tests/tcg/mipsel/test_dsp_r1_extpdpv.c
index f5774eed3cae..80c5a7fa3ee8 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extpdpv.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extpdpv.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_extpv.c b/tests/tcg/mipsel/test_dsp_r1_extpv.c
index 401b94afadfc..d575750b7ffd 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extpv.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extpv.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_extr_r_w.c b/tests/tcg/mipsel/test_dsp_r1_extr_r_w.c
index 489c1931b475..d3244b730297 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extr_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extr_r_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c b/tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c
index f9d2ed646fa3..6e899ccd4c4b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_extr_s_h.c b/tests/tcg/mipsel/test_dsp_r1_extr_s_h.c
index 9bc2a63cc2d1..aa36b4e9f31c 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extr_s_h.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extr_s_h.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_extr_w.c b/tests/tcg/mipsel/test_dsp_r1_extr_w.c
index cf926146d54c..f82e38e34fb7 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extr_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extr_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c
index 2403b3afe40f..6af471076904 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
index 10c182a54b23..9a4f5fac7a59 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c b/tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c
index feac3e2e334a..d0747331f9ed 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_extrv_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_w.c
index 9e8b238a04d4..b1caee3ff085 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extrv_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extrv_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_main.c b/tests/tcg/mipsel/test_dsp_r1_main.c
deleted file mode 100644
index b296b20c9254..000000000000
--- a/tests/tcg/mipsel/test_dsp_r1_main.c
+++ /dev/null
@@ -1,6 +0,0 @@
-#include<stdio.h>
-
-int main()
-{
-    printf("hello world\n");
-}
diff --git a/tests/tcg/mipsel/test_dsp_r1_mfhi.c b/tests/tcg/mipsel/test_dsp_r1_mfhi.c
index 43a80669d1ea..5d2233d6eea5 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mfhi.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mfhi.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_mflo.c b/tests/tcg/mipsel/test_dsp_r1_mflo.c
index caeafdb05ce4..3e4046c57ffe 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mflo.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mflo.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_mthi.c b/tests/tcg/mipsel/test_dsp_r1_mthi.c
index 43a80669d1ea..5d2233d6eea5 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mthi.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mthi.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_mthlip.c b/tests/tcg/mipsel/test_dsp_r1_mthlip.c
index 85f94d8450ea..9c96751c8cbe 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mthlip.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mthlip.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_mtlo.c b/tests/tcg/mipsel/test_dsp_r1_mtlo.c
index caeafdb05ce4..3e4046c57ffe 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mtlo.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mtlo.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shilo.c b/tests/tcg/mipsel/test_dsp_r1_shilo.c
index ce8ebc69c2ac..e1b3292c3d42 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shilo.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shilo.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shilov.c b/tests/tcg/mipsel/test_dsp_r1_shilov.c
index e1d6cea4b6de..18e3ee1f213e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shilov.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shilov.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index c9e869b000f4..77f210a47a70 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -4,6 +4,7 @@ tests = []
 tests += tcg_tests['multiarch-linux-user']['tests']
 
 tests_dsp = [
+  'test_dsp_acc.c',
   'test_dsp_r1_absq_s_ph.c',
   'test_dsp_r1_absq_s_w.c',
   'test_dsp_r1_addq_ph.c',
@@ -32,37 +33,19 @@ tests_dsp = [
   'test_dsp_r1_dpsq_sa_l_w.c',
   'test_dsp_r1_dpsu_h_qbl.c',
   'test_dsp_r1_dpsu_h_qbr.c',
-  'test_dsp_r1_extp.c',
-  'test_dsp_r1_extpdp.c',
-  'test_dsp_r1_extpdpv.c',
-  'test_dsp_r1_extpv.c',
-  'test_dsp_r1_extr_r_w.c',
-  'test_dsp_r1_extr_rs_w.c',
-  'test_dsp_r1_extr_s_h.c',
-  'test_dsp_r1_extr_w.c',
-  'test_dsp_r1_extrv_r_w.c',
-  'test_dsp_r1_extrv_rs_w.c',
-  'test_dsp_r1_extrv_s_h.c',
-  'test_dsp_r1_extrv_w.c',
   'test_dsp_r1_insv.c',
   'test_dsp_r1_lbux.c',
   'test_dsp_r1_lhx.c',
   'test_dsp_r1_lwx.c',
   'test_dsp_r1_madd.c',
   'test_dsp_r1_maddu.c',
-  'test_dsp_r1_main.c',
   'test_dsp_r1_maq_s_w_phl.c',
   'test_dsp_r1_maq_s_w_phr.c',
   'test_dsp_r1_maq_sa_w_phl.c',
   'test_dsp_r1_maq_sa_w_phr.c',
-  'test_dsp_r1_mfhi.c',
-  'test_dsp_r1_mflo.c',
   'test_dsp_r1_modsub.c',
   'test_dsp_r1_msub.c',
   'test_dsp_r1_msubu.c',
-  'test_dsp_r1_mthi.c',
-  'test_dsp_r1_mthlip.c',
-  'test_dsp_r1_mtlo.c',
   'test_dsp_r1_muleq_s_w_phl.c',
   'test_dsp_r1_muleq_s_w_phr.c',
   'test_dsp_r1_muleu_s_ph_qbl.c',
@@ -93,8 +76,6 @@ tests_dsp = [
   'test_dsp_r1_repl_qb.c',
   'test_dsp_r1_replv_ph.c',
   'test_dsp_r1_replv_qb.c',
-  'test_dsp_r1_shilo.c',
-  'test_dsp_r1_shilov.c',
   'test_dsp_r1_shll_ph.c',
   'test_dsp_r1_shll_qb.c',
   'test_dsp_r1_shll_s_ph.c',
-- 
2.55.0


