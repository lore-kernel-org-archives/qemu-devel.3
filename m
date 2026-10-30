Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420A606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DJgTjv/+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I2EX10Zk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo7b-00078s-Sx; Fri, 30 Oct 2026 11:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo7a-00078S-6g
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:02:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo7X-00076R-FQ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:02:21 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERKFl2968098
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hYpLatjn7L7tJVWqUCfxO36SpgeZ0qU1W1CEFD5YpEs=; b=DJgTjv/+E+EPf0t5
 BFfUZ6n0p/6GsI/sJKchsuMmwB11O9qdhPg0TD8u62pTZlcegqJvHKbW3oLZBHUe
 yZvSmGnjiYVxigiHa4hi0poLeTct3qo76PTU9WV1LBQEtKyIm0y7385dIIr81ASQ
 iq8mI02zPMcdrzZXjS1kEFT+kXtQit2wYHlflZ3b3v6JStVDBUDC/Fs6VdFprI2k
 0+epsx4GZoQKVTH9ZnizvNUBmF/HMw3xqVvdyHj9aIPcZu2iUQN9gcYvp/dUJj/R
 Z84aA6yb8fM0VonOwnz7kYGPk8Pj8CFtD1z4FlAXqiP2kb27XTcBpG8h8LQQyxAk
 tMySGg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkmqt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:02:17 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7bf71bbf197so618425137.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372537; x=1793977337; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hYpLatjn7L7tJVWqUCfxO36SpgeZ0qU1W1CEFD5YpEs=;
 b=I2EX10ZkZd3VwpBRmlLW8+T2zpQ5fKdJiq/sxnV/EHupFp5PH5x03DOq9wWFo9J4qq
 OoaWwB6E9EBe0LSUkxBJjqYx8UpnZ5Jg8Um0MbTf27nx+i7mXYHQLzEjwd8t6hVH31bt
 r9/zxltgo/cc5YjY2wMay5cDNhgzu9He/4nLY+ZRzEBaP/URGJIQabHLex2J1ZrRTePD
 OZMBKb6EQh0P26f9TQFyOfXix2Ky4g2D8MuyFK5AAf4hEXBgxHYqvuPwhsS58Cjuvgqg
 XlYItGjHNqcGu4XBsSRbtjBRxpzxVnTiEtAA4AJjIjCOINLDAyUgyWpyHzwFSNlS0Oba
 K6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372537; x=1793977337;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hYpLatjn7L7tJVWqUCfxO36SpgeZ0qU1W1CEFD5YpEs=;
 b=ZvIVrdhlpoHBqoTRlDNM6c5GhYzOdZjEyrH4UllVY/jRm1lmh84D6s5qRD23VOy229
 qXB1kztNrozUa/1VsyF+Nj/NS6RaXwIr4c7sRtSn1TSxNBz5GVAp2wtHJLHHyxS95Cow
 x8Y76skaB3EqfkFU/0bdax4sbXqwrLdd1Iy+C0Q0qkg2c55nMofR+AEvIc+nQgY9go7q
 n616pCxl+kLq+1JRUf/1AVyAtTinKzYhfA9zFtB2Bt63DSnjpcH0+nwS2mZuFz4k3O0A
 +pZnQl+T4nC+O61Br27K5XE27N7kKrrL/mPtYVNRe7l3I3b1KC9l5ATbQx8leaeQ96b1
 vW0w==
X-Gm-Message-State: AFq9FYLpDdUBvEDlzVTJq4Cr6QjxN6F5ktNNCtQ7CRDuEVcXsKAYzdY6
 g655pu0FPKEsvPLsGtegHnAhuqGiDlTUGT47q92b2emHbSXrdyvKr8iId+UH3OgTyeaZfpCOlPy
 jNEFqDQF1nXSVzKbC/sCQa0CqQ0hWv8dseGC7hjiR20A+/0I0Y5fy211LixMIZdmX9zzS
X-Gm-Gg: AYBFou1t7HEm7zoy1WesiSRGr0psANF3WO1BC9zbjo9381Qur2xD/KOQggFevkSEcLH
 wJkTTpfqImY9vZ8m0u1tNW403ydRnDcG5VmXi5LqpIvpK9SbW3W8IcaboW+qoZpRayI/kTjBt1x
 sguzHuTLRXeZzE7YIwxRl0p2XfVzZZkV16KmO6a94DU9Mq/mGkcbRQTlKQi7DDqWAi4XXu+tHPj
 4Beshes9X9d6Tbl50D7zosyMq661xj71jUZiRKp2U01jaE6+NujD9dOC623x7cNpsLzZ2y8QlSr
 YD5DWrRSTAniLYwHPjjVHsHrjyt3qbzwBkGJqndx1KeNF5YIwBx549Nk5RfFXu6bO8FShyhHcBl
 noZ/WQJmV+lVHcyLCw04X/Hp7ZGG5dzhEfJLf82NSNq0N70LRfG3OTH2kzVlluLATbD/tA+D1zb
 XRgyw8gKXEbAj0lZbvdRUR88Y/AFBRyA==
X-Received: by 2002:a05:6102:6047:b0:7bf:6218:bc59 with SMTP id
 ada2fe7eead31-7d072d4aa8bmr1187058137.32.1793372536143; 
 Fri, 30 Oct 2026 08:02:16 -0700 (PDT)
X-Received: by 2002:a05:6102:6047:b0:7bf:6218:bc59 with SMTP id
 ada2fe7eead31-7d072d4aa8bmr1186976137.32.1793372534955; 
 Fri, 30 Oct 2026 08:02:14 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a0a3495sm48371625e9.4.2026.10.30.08.02.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:02:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/31] tests/tcg/mips: Group DSP acc tests
Date: Fri, 30 Oct 2026 16:01:31 +0100
Message-ID: <20261030150202.61556-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXzdVS6oh1umA3
 c30fcsl9gbAcb6GUw6CBLbeKlwQz5tco3jZHu6enbRxRjrr5BzTE4s+WV7d+cJgH2E8KKhQH7aG
 fbu/I38NcHCrDPPtGywjoE2whE0rxT25U2Mn3bbY6ZcKVd3T4JWyWUfDc/ZqIg3vLq/rGB7qBkJ
 X45R3TP5hUw8yavzJLRMVJW+d5xq59w/MWOUy9jt+EvAX1YNyZJi6t9nOaaYb7dXvG/gVVRhySQ
 Zl0oNiTLPUG6QtbFWIXpNwjVMxhEq0SCL1eKayqDdHdCCfjBmJf5rFXNNfOCk4/lI+jIXw9pxjU
 PJamhNus1xkPsFAISWT1QC44imcKnYZQWmLokA4iRtVWc0TNQWAEy+Dh8Mtp2EOhwmmDmOPWDiT
 MEeL5Xrd/oclNd75kiqJqmCEO96sNIRP5AGfWefWlyOuvRJ2STlfNHEpgo+yTBnitBZXz6icrgQ
 JfVvqADYX7FbibHB1aA==
X-Proofpoint-GUID: 65x5fHGnfBYTZzlPBFIeHezR29eKKxIw
X-Proofpoint-ORIG-GUID: 65x5fHGnfBYTZzlPBFIeHezR29eKKxIw
X-Authority-Analysis: v=2.4 cv=IumL47/g c=1 sm=1 tr=0 ts=6ae4b179 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=kzXELmrAYARPUxPIdzUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXxHkRWkabqLqZ
 1x2S9VXqd9N/Z4hHbXftRUktSHm+lEiRz8XoASXZ+c10vuMRMUC03SDDjm0DC0FClvHrLcIb2Ty
 RFQ86u6D57cYKFqdWqZSY9O+gTpRr88=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300059
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

Build the 19 per-opcode acc tests as a single executable,
test_dsp_acc.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Add test_dsp_runner.h: assert() only counts failures, and
RUN_TEST() resets DSPControl and reports each test in TAP.
Drop the unused hello-world test.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_runner.h        |  26 ++++++
 tests/tcg/mipsel/test_dsp_acc.c           | 108 ++++++++++++++++++++++
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
 tests/tcg/mipsel/meson.build              |  21 +----
 23 files changed, 135 insertions(+), 45 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_runner.h
 create mode 100644 tests/tcg/mipsel/test_dsp_acc.c
 delete mode 100644 tests/tcg/mipsel/test_dsp_r1_main.c

diff --git a/tests/tcg/mipsel/test_dsp_runner.h b/tests/tcg/mipsel/test_dsp_runner.h
new file mode 100644
index 000000000000..23ef17428b2e
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_runner.h
@@ -0,0 +1,26 @@
+/*
+ * Helpers to run several DSP ASE tests from the same process: assert() is
+ * mapped to tap_assert() which only counts failures, and RUN_TEST() reports
+ * one TAP result per test, after resetting DSPControl. A test calling
+ * RUN_TEST() must end with "return tap_done();".
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef TEST_DSP_RUNNER_H
+#define TEST_DSP_RUNNER_H
+
+#include "../include/tap.h"
+
+#undef assert
+#define assert(cond) tap_assert(cond)
+
+#define RUN_TEST(fn) \
+    do { \
+        int ret_; \
+        tap_assert_failures = 0; \
+        __asm__ volatile("wrdsp $zero, 0x3f\n\t"); \
+        ret_ = fn(); \
+        tap_report(!(ret_ || tap_assert_failures), "%s", #fn); \
+    } while (0)
+
+#endif
diff --git a/tests/tcg/mipsel/test_dsp_acc.c b/tests/tcg/mipsel/test_dsp_acc.c
new file mode 100644
index 000000000000..fa5b1c2e7abd
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_acc.c
@@ -0,0 +1,108 @@
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
+    return tap_done();
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


