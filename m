Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672E3606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=akPk+sry;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RU10liLy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnze-0003WK-T5; Fri, 30 Oct 2026 10:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMny8-00025A-PQ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:52:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMny5-00068q-SC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:52:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERFfp378155
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FMtFXvRNPPwWLfiDy1Q+9Ojxi62I3+8V0lltGcoU3+c=; b=akPk+sryWHssku/a
 bHBDHC/ilIH3+0+2P4cVNq7+A8uLJwZr2bGyYc2Phqcs3FEES996jbmgyABay9W7
 A99AFfjEelO3Hp+cAFS+wMYGSSWTiK1SupjWytwlcpkmpqwX1INhV3IqBy4qZFU4
 yFxg/6xJtn3GOLi+TBKxjzwC0Qgg+ytq+CB0DD4Oah/UwjqC8mYYzcxQ1J9GBfUG
 +69K1wKKyYFV52OvUC+wrO3ws/od05vEF/Qa7TsWEuv9RPgg84LNpFu/idecAC3D
 GO259IBtDcvJG2x8tIKaWdTvx+AVs6e9fDQU1RzAhPn+3QCxdaHvKuKUik/b2/Fp
 A8AEWg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme753k23-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:52:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ecdc701a2so92964285a.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793371950; x=1793976750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FMtFXvRNPPwWLfiDy1Q+9Ojxi62I3+8V0lltGcoU3+c=;
 b=RU10liLyfYNq61YWl2TW2mV29yDu2YXfg+C2wR/ybnnjqAVwxlOmu9bqLfJ9ium7b1
 LX66XIC9MLQIgL4olosuzcUbQbnObUiGKoW/mzkgnQi58Ix+xD3RV9PwB1OhRA1gLsyq
 o8i0tK5WRWZ+xIeNaIzJkcuded7+c6UMY+4uReI/Ckum3Kq9ccmlPa7jTc4RQNdyg6kX
 j/JWf5vari6lA83n1fuMLdaetsSvVuf8uuS5+5OyPL1XbWoERFWMUPreCYJPIrjhKD6I
 0IhmQePkq7scxjKXjWyqmKFoYC/akoQCRabLlp0KT3Yk8gYtVPFUbPIJlRnuB+kgN+XW
 R5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371950; x=1793976750;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FMtFXvRNPPwWLfiDy1Q+9Ojxi62I3+8V0lltGcoU3+c=;
 b=OzLkoUI7WZ3WNKdZkTadBv4WS43MJ1jRueUkL5wA+K1ipZqyzLMzDziEypezRN8BKU
 l6BMZVPvE5CxhXDf1Cg7dTXOHxpBbTdj1UEvl+eA5wM0LHQokSggmJJXcnTKsSZ4Rpum
 Tv18UtAo5Um8DSaEc46cw0cZk2SdOp941n63D7tanuJxaeueoXRLVY5xQv5Zc8fG01ic
 bOnoFLb70yThWNAPEdfCPsvQaEeFc99OLGM6AtqvhLRJ8M9iHj74iwcsnxLXBFWy3m0n
 4Cwmup45/P/7MZASZXm0akfcBEBXioAg1D6xT4kq0h/fis4nabWpcbY+nOM/nphktggi
 MS3A==
X-Gm-Message-State: AFq9FYKlTB2mJhebLQtrzHLD7zPkAWQQtx4yzJQRb5d5Vi98+PoAECUf
 jSxiajeUX1YgfGlrer/fp1sOx4LfZgus7nQ2sTN9BqaZUmcD59BZyUldJFiwaJvBVJ3aXwi/EAe
 oGmdK6MqD7D2NiyjQZTkMq9ongzTCFnXEWLQfX+Ph0VdtWjcowSrW6RSv6eamIIxxqeMo
X-Gm-Gg: AYBFou3Y/H8CSI8Mnm4hmhZOMF6MkaYK4c0X0nuniyeIy+qdxbfCkjeBHM8FNafrHEb
 svROA838gG565Cge2ahGIwRxhvimG46OgAysFRSaAFlDUjpWgxpze92lc48ADhKSVMK2wWGlB2D
 rS3vRG9O+2N5QUOsduBx9bnjONNRMPGolAMyMxyltQnNeTEbzvVBUKjtm+7O5CP5Vc0EeOZ3pMr
 A8AssoF7d3uMynp58qwIVohYOXwZ/dn0oMe9lufTDmjOGEaKJT4/NB1+WvsVDM0pQ7CBK6GsR76
 WNYiKblBS5OXpb+ZvsgtVMdq3JyMh9K7t+L2SsAb51Vd+tBfApYNalub6Xo50eFyAhcqJiqdb/i
 maVoa14La7rIui8j5Pqg6UyOUCIFGPFHfSjXsFwiR2AmUjGn/l3jYdhSnubPnW6JYwkbsVq3R0n
 A5oB5MlgUL14sqi1aTMlPcGhw1C3QYtw==
X-Received: by 2002:a05:620a:84c4:b0:93f:167e:d98d with SMTP id
 af79cd13be357-944217108camr411299185a.43.1793371949315; 
 Fri, 30 Oct 2026 07:52:29 -0700 (PDT)
X-Received: by 2002:a05:620a:84c4:b0:93f:167e:d98d with SMTP id
 af79cd13be357-944217108camr411295285a.43.1793371948786; 
 Fri, 30 Oct 2026 07:52:28 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6c76507sm68571805e9.10.2026.10.30.07.52.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 07:52:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 1/4] tests/tcg: Add minimal TAP helper header
Date: Fri, 30 Oct 2026 15:52:15 +0100
Message-ID: <20261030145218.58385-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030145218.58385-1-philmd@oss.qualcomm.com>
References: <20261030145218.58385-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: spQ5TH3apFMrtmP_XBwfGtZRbMz1foeW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX3autGOMWExfF
 LxzdPps0d+4ekfxC6mDA65RHy8epSLxaSdGzvKsWbo9ewauALa50YRYCwc6Qf1aOIRPfszZyGYN
 G3CXcz9aAyeYf8xmYyJQKFp6/vhb9LcEDO8338NzABuGtmMdCkqc4LKNCIOdtu4RhIPQwarVtNE
 9MVB1h4PkK2uYc5m5k1mTn7Hg47FKTxqkWeWlpNe/jOG/rleH6BnZph12iUykU4K0MfOGu+9kkE
 bOHW4gkb3yvuEHNuF9zZHD6e+F0NVLkIELJHUeJiHXOfcqchbupIr0kHoj6lB6cgtpG4lvO2Lnr
 BaWKnRwpj+6Ntle6taD89uPZhKP3ZxBGi07wPHsxno4yxm7OSRtMSUYtxWOi3llhYiNwEqLXxp8
 FyeGPljc8kyCkLs8/kKEuMz28env13PQNlSCHPIwFVrygOwK14xyNF9xPD0rCcZ2guzTCv/wS5/
 vmV3nAfQZWgUSNDs9rw==
X-Proofpoint-ORIG-GUID: spQ5TH3apFMrtmP_XBwfGtZRbMz1foeW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXzaXG19HqaRdy
 qlKvIBEZi3Mtih6vZSDAA4Ia1bvPEm2HT1QcdnRgKEaP9Dzzsjl7DexCeov0TNt6chF+D3x7aCh
 3BEbQRVgRtge/N1CGkjjjMZucVSNfdY=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4af2e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xHHqPXp51XzIvhAaDsQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300059
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
 - tap_assert() is a non-fatal assert: it prints a '# FAIL' TAP
   diagnostic and counts the failure in tap_assert_failures, for
   tests grouping several asserts into a single reported result.
 - tap_done() prints the plan and returns the exit status for main().

The counters are static, so each test must be a single translation
unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS             |  1 +
 tests/tcg/include/tap.h | 60 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
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
index 000000000000..ce7e990bed4b
--- /dev/null
+++ b/tests/tcg/include/tap.h
@@ -0,0 +1,60 @@
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
+#include <stdio.h>
+
+static unsigned tap_tests, tap_failures;
+static unsigned tap_assert_failures __attribute__((unused));
+
+#define TAP_START() printf("TAP version 14\n")
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
+    printf("\n");
+    tap_failures += !ok;
+}
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
+            printf("# FAIL %s:%d: %s\n", __FILE__, __LINE__, #cond); \
+            tap_assert_failures++; \
+        } \
+    } while (0)
+
+/* Print the plan and return the exit status for main(). */
+static inline int tap_done(void)
+{
+    printf("1..%u\n", tap_tests);
+
+    return tap_failures ? 1 : 0;
+}
+
+#endif
-- 
2.55.0


