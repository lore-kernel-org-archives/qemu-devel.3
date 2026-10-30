Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B35606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WFL2jdek;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IsP9gGEi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqje-0001tH-Nl; Fri, 30 Oct 2026 13:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqj9-0001fP-EI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:49:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqj6-0007PU-JA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:49:19 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERHNU378541
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 whLAdLiSV9opK2YAMzkPtKh8Y73NllRKu95DQ3RQRiE=; b=WFL2jdekQk2iuzTR
 lsAlMPgXjiwHuWGKV7Q9dhZdQOQoVY2b40OkcacPJRcKZ9oRSx8Vht2emTeWSAW1
 NNGjlx+nUDQnqfP6QKzu/3FKpo10hV+8L9+Rm/nGmwIWY4M6vdUSMHCqGAmmlULR
 5Sca4CqHqlK0AGVMieZBkLMLxzZ+2imuDHlVlNb3bdvmVqYpI11e3ryrukIEhVj0
 YL4HeqFojTN1vFaoavUaIcbrJ3Pqt+54xoKghtn5FA1NkDHMn56yWrfOcrSefmkl
 q+nVnpNUdfKIclOnUqNHZgcGmttOipWvRjRprBDhKnt160pgPY8x42I396tGBHn5
 b5kQlg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme7549bx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:49:14 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9806756ea40so834258241.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382554; x=1793987354; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=whLAdLiSV9opK2YAMzkPtKh8Y73NllRKu95DQ3RQRiE=;
 b=IsP9gGEioN4V/V6bVV7rWZFBDBno0Bv+NfliBxMGVFz84pcPG057t8Qn070DR7b6Rv
 2vlASB50z4CBX0Q4WV4WHVb+ijhTl6t1+A7hwuytKoqTuDEvwcWLdpUd5XYepK0tm1W7
 q1chEM9v7f6ZH+q0Hf/q/J6VCX1YDpLiymASKJ2AaqtCnN5Ra7olYYaxA++x8gT1+PIX
 nb/LZcAoMkZIIB9qGrUSVteKNsuc7mFv/shHyh50ubikpKVn6TTMjoDNQ6NUk6YIWfpt
 ygnCC+S18uBj0kPUMmLfY70iwM+QZArS9qmmjboqDpy8E6+1sYTJ5kVKeVOBvNXK39gF
 PJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382554; x=1793987354;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=whLAdLiSV9opK2YAMzkPtKh8Y73NllRKu95DQ3RQRiE=;
 b=hSiQ3wff48AU02slPLKpufqBN9LBt3vfRw0qPVSWxTC1h/hRr7Qj+RXyG6VohIypDJ
 +/363SgWWbxS1PQwCAYjSF7zZj7mI2HC64ti9IA0OzxQJosPhw+BKszNKbTt/PsifuiP
 6zBjwWhSZqpZIPLMrmR6daOrOCK2LyENAotBeLpAhwRUXH8qw/6+/UQ6XmbFF+cD5kr7
 MSGegZDjTt3K8P+RNlAEQzUB/grzUN4JUN1HhL49dKSjJzzX4uIiefnLX2BEB4Pc6W1R
 6cF4eHfcQwMGsK6lNXeB00hhNAzmJFB98pZUoAopyIKEJ2kt5ZkXoW+MUaTxMlYQmt4B
 PIwg==
X-Gm-Message-State: AFq9FYLPJfHv2lWATKSgAk3H2XzMJAIm6XFKhQEO2ezWKSLRlqN0Eb/T
 9n1FY3a9xjm5waQteXH7irL6uaXU/U3cGjb2us7JjsyzssP978hFxP3kWcdS3G3Aco2Q57qq6pP
 5wujEp9Wrw7v6CMy1sLYWCtDEgdIrJcNO2wHuP5WjUNnIOe5tflO38nQXWrGFzsQ++eWV
X-Gm-Gg: AYBFou2YkQ+vPHZbR2QFvFn7KAyZmPFBfKPAb6vp/THW4fmduYewYqrRTX64/J9PlZZ
 OX2SctGX3PSSV1fXHhQ3V+S8hT9KGSRW0N6k3IDsjtM2g3g2gpssS1MJnKc62neTGbiz44PzEXN
 pe6ZbeA0Y/sTBnQy6kaVPldEOYUYCI4hh4p9PqmO6Z941Gg9GX8BVa0iWR5SflIYUCcMtdL8JHK
 uV8eYU9dkNqXa9i072AhsZWMLYo20G0sOpeMruCE6Qp73nTL0cFfmtAzLDeYmov0UV4Mx/3sInA
 d8ZroNQ/pJeXknMHoObruuMqhehLWzK84Z+mJe2tmLitDVSHEE0TFTOGgu16fXvBxK37cOaj/Ib
 HqjR3tc1j7IoNtZ2cKY5/IsLZZcHBdXqkwpFVJK0HzONswy+7vsITrmOksZSLYpQBSSZi4MTYRt
 5PcgdHjyzxT4Y+dsYwIIuzRlQSvkBN2A==
X-Received: by 2002:a05:6102:4426:b0:7c3:2f13:d905 with SMTP id
 ada2fe7eead31-7d07277b610mr1717819137.3.1793382553803; 
 Fri, 30 Oct 2026 10:49:13 -0700 (PDT)
X-Received: by 2002:a05:6102:4426:b0:7c3:2f13:d905 with SMTP id
 ada2fe7eead31-7d07277b610mr1717801137.3.1793382553356; 
 Fri, 30 Oct 2026 10:49:13 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b789c6sm4787256f8f.26.2026.10.30.10.49.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:49:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 1/4] tests/tcg: Add minimal TAP helper header
Date: Fri, 30 Oct 2026 18:48:52 +0100
Message-ID: <20261030174856.98759-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030174856.98759-1-philmd@oss.qualcomm.com>
References: <20261030174856.98759-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: L1VFYCGjKIRSFhDCmgORhjgmMgXGrqUo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX3DNdYq2aetaB
 pDiF3UtkFkoPsEH40CV0jWWEraSCm4oPEsLL+xEg8FZ1ZyQZ67j/a0rn1FAFc5ncoIP0TAd+2PU
 BtKtWEcPxzaCVDgqUtM4NGJDKYRhur/Xf1pS+vN0CVKxAAgpnTJjSUK0i7zGcgbBIEezqMZZsTD
 xC4Xlkj2qK3Ar5IgE+VRl72E/idINuITQlu3WHYH/LAL4kG/B0V53dCDkd+PGkkUNp2FHC/wqgJ
 pqk32aeg39oTuxYmlVAIZnE8b7CXVr5edvwidDywk57gQU1ke1bKb+0zGej+ppSsaKTSqzOvECZ
 TBivnJz/79/N5SuVLvKoUbm7DMxKDbC5vDg9+hMSD2hn0llY/BzraycHO5wbsyoCRDRm2DL4Y8+
 5AD1RkO2BRJmNUGQoazQQfplENi6ptFrfAHAzITk4VpBVaoVSkVeF5VrUpNa+bvJD3w0i6UqxsX
 PE9umtF2IUmirCvD6GA==
X-Proofpoint-ORIG-GUID: L1VFYCGjKIRSFhDCmgORhjgmMgXGrqUo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfXxTmT7YazMnZk
 +7WqjYiidfK2Mhy/HLiXJ4kFHoMpstpBkwR+28THBZrCafYs8qFTrGJRpTkiATTkFMN2o8NOcAE
 v2NuLEK9B7NOrwpp66K/R9+W+bbueH8=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4d89a cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=4NmYxyE9tqdsvi3zJEYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add a small header to report test results using the Test Anything
Protocol, which meson parses when the test declares the 'tap'
protocol:

 - TAP_START() prints the TAP version line.
 - tap_report() prints one numbered "ok" / "not ok" line, with a
   printf-style description.
 - TAP_CHECK() reports a condition, using its text as description.
 - tap_info() prints a printf-style diagnostic line prefixed with '# ',
   exposed as TAP_INFO(). It is not a test result: it neither prints a
   number nor counts towards the plan or the exit status.
 - tap_assert() is a non-fatal assert: it prints a '# FAIL' TAP
   diagnostic (via TAP_INFO()) and counts the failure in
   tap_assert_failures, for tests grouping several asserts into a
   single reported result.
 - tap_done() prints the plan and returns the exit status for main().

The counters are static, so each test must be a single translation
unit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS             |  1 +
 tests/tcg/include/tap.h | 92 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 tests/tcg/include/tap.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8884e4177e4f..761b2f5d4dc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4699,6 +4699,7 @@ Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
 M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
+F: tests/tcg/include/tap.h
 F: tests/tcg/meson.build
 
 GitLab custom runners (HW sponsored by Linaro, OSUOSL and IBM)
diff --git a/tests/tcg/include/tap.h b/tests/tcg/include/tap.h
new file mode 100644
index 000000000000..b372e9850672
--- /dev/null
+++ b/tests/tcg/include/tap.h
@@ -0,0 +1,92 @@
+/*
+ * Minimal TAP (Test Anything Protocol) helpers for TCG tests.
+ *
+ * Select the protocol with 'protocol': 'tap' in the meson setup entry.
+ * Each test is a single translation unit: the counters are file-local.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef TESTS_TCG_TAP_H
+#define TESTS_TCG_TAP_H
+
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static bool tap_initialized;
+static unsigned tap_tests, tap_failures;
+static unsigned tap_assert_failures __attribute__((unused));
+
+/* Print the version line; must be called before any other output. */
+static inline void tap_start(void)
+{
+    tap_initialized = true;
+    puts("TAP version 14");
+}
+
+#define TAP_START() tap_start()
+
+/* Report one result; the description is a printf-style format. */
+static inline __attribute__((format(printf, 2, 3)))
+void tap_report(int ok, const char *fmt, ...)
+{
+    va_list ap;
+
+    printf("%s %u - ", ok ? "ok" : "not ok", ++tap_tests);
+    va_start(ap, fmt);
+    vprintf(fmt, ap);
+    va_end(ap);
+    putchar('\n');
+    tap_failures += !ok;
+}
+
+/* Print a diagnostic line, prefixed with '#'; the format is printf-style. */
+static inline __attribute__((format(printf, 1, 2)))
+void tap_info(const char *fmt, ...)
+{
+    va_list ap;
+
+    fputs("# ", stdout);
+    va_start(ap, fmt);
+    vprintf(fmt, ap);
+    va_end(ap);
+    putchar('\n');
+}
+
+#define TAP_INFO(...) tap_info(__VA_ARGS__)
+
+/* Note: the stringified condition must not contain '#'. */
+#define TAP_CHECK(cond) tap_report(!!(cond), "%s", #cond)
+
+/*
+ * Check a condition without aborting: print a TAP diagnostic ('# ' line)
+ * and count the failure, to be consumed by the test reporting its result
+ * (see tap_assert_failures).
+ */
+#define tap_assert(cond) \
+    do { \
+        if (!(cond)) { \
+            TAP_INFO("FAIL %s:%d: %s", __FILE__, __LINE__, #cond); \
+            tap_assert_failures++; \
+        } \
+    } while (0)
+
+/*
+ * Print the plan and return the exit status for main(). Abort if TAP_START()
+ * was not called, as the output would not be valid TAP.
+ */
+static inline int tap_done(void)
+{
+    if (!tap_initialized) {
+        puts("Bail out! TAP_START() not called");
+        abort();
+    }
+    printf("1..%u\n", tap_tests);
+
+    return tap_failures ? 1 : 0;
+}
+
+#endif
-- 
2.55.0


