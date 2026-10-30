Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BJQOScWF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XvtCVadU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqtL-0002oe-UJ; Fri, 30 Oct 2026 13:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqrX-0000Nj-2M
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:58:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqrV-0008Ls-6a
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:58 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHuKZi3057335
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9ezxwTOoRrCT1s9gzKXBUfjV1t2eO52tFy0eMGfZLsI=; b=BJQOScWFOuMbF+ys
 2R4Rs4I5IlPTACB/68FLi6jP5XnxuwdQ0GhSRPj8AmdjsODIIdzorDiYdB7U+ljZ
 3X6wZrlvAd7aOam6qL/1h9BqJdAMgpALTGBwK8Ldy4aKt9VLfjaIjPfRaaKLv8us
 MS4Ks+Xi0iy0ttGRV/jTOsi97rlVrw1HDW6V701ICl4cbbOTK3I87EumjvsoGVgq
 t2RBVk2YHDecYaBYGknKCFMt6vCwt3wybArTC7Cw1HxWVGMFvCODUcp3lTIn0cKx
 z87UFYAgproQC0XMoDwsJNqrtVepGibKDWLQPuQ9W+ru0Mh4RK8vAoKFMSdIH+Tn
 EQyA8A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pcbkw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:53 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7c124d17880so181168137.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383073; x=1793987873; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9ezxwTOoRrCT1s9gzKXBUfjV1t2eO52tFy0eMGfZLsI=;
 b=XvtCVadUtNwp5Q0yQq4KHVebF0MnJKbjj/3fotAGuGF2wwBqGDU39NqQonYHQpswXl
 NxIfxGrSFFbKq1twbM1RGm2N5t6Al80CF7epVs6VcA+jBHqCciDm7inDplOM+ulbUJdE
 NlbNyhi+5pBMJ78UAvCDgYJyyl9VtjLlzDgLdqJuUUlzo06F8MHOZdlEs9foAc9+zfe3
 AmToYkEUhPPlQBLaJqi6Mv+m3hDQg0/tufPLIQ3hlbJxA37K83A7QRbkNBrY71SDdViI
 7zNjLGpJlap1/qavrye0IsQ/BjfB3TR9Vr+/h9Wj/s8pHen5AbJjuDPLKRt7rXID5PPD
 ptZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383073; x=1793987873;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ezxwTOoRrCT1s9gzKXBUfjV1t2eO52tFy0eMGfZLsI=;
 b=tKi278RgPThgZVYUGqjhk7XTvbuwIQCEQiopoFFe3T20u9fsPNLByAde9NFN+L8HqV
 vonoBDyx5o52za6kHDej854fEplDYKLNOflDJw7UoHb3t21GD0ocyw4sTthBhE7JeHFq
 1YCXkL0W2vJpqWXIUGJA+G6+7NRtYtySbcsgpqzvDruXzAS8JVIJxnCtcRGaZy/muMwR
 eA5uKo9yOWPdZiyAmIcTVroJ/n+y+ZXfPM6a/NgCO2SjvsrJE02KmaD5pE10/4GzhScb
 8sA3Idgd6F3bIhf7YRdFaNvL1xOELlfeYnAxmoRPCMuJ+uRfns9KIayW9zV/+u1zGJuR
 /kDQ==
X-Gm-Message-State: AFq9FYK06YD95saivVEjbn/spHqm9SVz959ggovijb1vPoDahk9mWS0Z
 d6rkqCSNW1/e/9CZOmihjyYypXcEIhrwcU7qbo87E8lAMjRIjI5F10ZjXrKxUsnyZgX05htdfeD
 82OcCbYnrf5t7JI9ZIKvKCyr7Lz1tqYExnROaAvaxnpn57xHcF7r1WJstMKmfTcxqRQFu
X-Gm-Gg: AYBFou1NzXXdOqF9UIpzA4yQ+KSmcVqlIj40zU2XmXSJx60s0JUY2qZGNLbgACCf7qy
 FOsxCvXSYyBf9tN3DQq25ldjvAcwwP6sQ7uQNw3qkXQc+zOqqhQARFnPuHLIHhqdSn1g6fLlylq
 TTVV7u3uIHRqOnlAhR2h4Uvd/cf6SRWwFZgx7Ji93Qdrs2YoRTjiMGm0uq7/ZURlXs62ywtoLPU
 rurfhL39czAUTzC8U21t/7dnM5uAWCB0vSrZiT7aFH+ejjnLmsWjiJeb1xz5/+Gp0HuFaiENh6t
 w07gzGYf00Qd0MHml2hHHi6/e1aB6bFC1X/xYLOBV4wSb8adLrNJAmiaZNYNyc5lWuk5eN9ot+A
 Ix0AelYsjLOYLj0PEQ+4/TqwQMeD/iedErL/xXe/yzrxXW33gJLGWaQfpcQcxOyZxGaapu4U62t
 kqT33x8WTROUfSUdSvwfufm4Uq9rZB+w==
X-Received: by 2002:a05:6102:84d3:b0:7cc:25bc:3b26 with SMTP id
 ada2fe7eead31-7d072bb31e8mr1050878137.9.1793383072767; 
 Fri, 30 Oct 2026 10:57:52 -0700 (PDT)
X-Received: by 2002:a05:6102:84d3:b0:7cc:25bc:3b26 with SMTP id
 ada2fe7eead31-7d072bb31e8mr1050866137.9.1793383072284; 
 Fri, 30 Oct 2026 10:57:52 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b727c6sm4593482f8f.16.2026.10.30.10.57.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:57:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 28/32] tests/tcg/mips: Group MSA interleave tests
Date: Fri, 30 Oct 2026 18:53:50 +0100
Message-ID: <20261030175357.99684-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX6/1TsFRTdlDU
 lrHQOfWhzh2hCtw4KB8Voz0srsV8puMeyaVCE0VUMcbH13c5iroufTCvc6TdPEHOeHugRmjxWVn
 njggdv9Qfm2xIcrWJkrqe9C0BpylhIJAJsdrZduS3tl3wSGghb2eDLJnN86Nmxg5PJIfpoZkQbR
 L6CDF0X8mnDAqROgUvSR159dDmLg5TUZMCK4rRc6a/XdipwTMFpz3xql1kgyoURnUltv0jqnsTl
 5Wp3h8Rrfglc2qfJCR2CW7RsKdYcP8ubo95LIX9PMCpshoCfh+HJJiu/GHwjL9yGUgtvBJuOU7Q
 vD3JGLp5vIV1Mb8KUXDSZGPRiBakXLabxCArZsRrncTsGGIdlPRuF0FFsmuNkXNyC6a3UtM6D89
 8GM7yHNNRCk1FWUxpp80/1emeZ9o0jYHWgIB03pgLVZ5DgRpm+BHsrUEG/mJEZCJsLL9PcfYRJw
 8e68a6+fZ4WS8Sq3bvA==
X-Proofpoint-GUID: eB_0xMrbKpcmjBvxHDgh6iuRWhVJO2M8
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae4daa1 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XlFCZ7tVMrZGAbOMMLgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: eB_0xMrbKpcmjBvxHDgh6iuRWhVJO2M8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX8Vqmo/I1kTB0
 AxEVOZE2ndJVLuUQswfcDYbH1fPaQXHd9dRlRBVkYb9/5zbY7KEqrfn+FKKnTt1efnTy7rSstjp
 iCICYXsYlJwKV8ypbjdTUzoLO22UdWI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
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

Build the 16 per-opcode interleave tests as a single executable,
test_msa_interleave.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_interleave.c | 123 +++++++++++++++++++++++++++
 tests/tcg/mips/meson.build           |  17 +---
 2 files changed, 124 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_interleave.c

diff --git a/tests/tcg/mips/test_msa_interleave.c b/tests/tcg/mips/test_msa_interleave.c
new file mode 100644
index 000000000000..f561ebe25aa4
--- /dev/null
+++ b/tests/tcg/mips/test_msa_interleave.c
@@ -0,0 +1,123 @@
+/*
+ * MIPS MSA tests: Interleave instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_ilvev_b
+#include "user/ase/msa/interleave/test_msa_ilvev_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvev_d
+#include "user/ase/msa/interleave/test_msa_ilvev_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvev_h
+#include "user/ase/msa/interleave/test_msa_ilvev_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvev_w
+#include "user/ase/msa/interleave/test_msa_ilvev_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_b
+#include "user/ase/msa/interleave/test_msa_ilvl_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_d
+#include "user/ase/msa/interleave/test_msa_ilvl_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_h
+#include "user/ase/msa/interleave/test_msa_ilvl_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_w
+#include "user/ase/msa/interleave/test_msa_ilvl_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_b
+#include "user/ase/msa/interleave/test_msa_ilvod_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_d
+#include "user/ase/msa/interleave/test_msa_ilvod_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_h
+#include "user/ase/msa/interleave/test_msa_ilvod_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_w
+#include "user/ase/msa/interleave/test_msa_ilvod_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_b
+#include "user/ase/msa/interleave/test_msa_ilvr_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_d
+#include "user/ase/msa/interleave/test_msa_ilvr_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_h
+#include "user/ase/msa/interleave/test_msa_ilvr_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_w
+#include "user/ase/msa/interleave/test_msa_ilvr_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "ilvev.b", test_msa_ilvev_b },
+    { "ilvev.d", test_msa_ilvev_d },
+    { "ilvev.h", test_msa_ilvev_h },
+    { "ilvev.w", test_msa_ilvev_w },
+    { "ilvl.b", test_msa_ilvl_b },
+    { "ilvl.d", test_msa_ilvl_d },
+    { "ilvl.h", test_msa_ilvl_h },
+    { "ilvl.w", test_msa_ilvl_w },
+    { "ilvod.b", test_msa_ilvod_b },
+    { "ilvod.d", test_msa_ilvod_d },
+    { "ilvod.h", test_msa_ilvod_h },
+    { "ilvod.w", test_msa_ilvod_w },
+    { "ilvr.b", test_msa_ilvr_b },
+    { "ilvr.d", test_msa_ilvr_d },
+    { "ilvr.h", test_msa_ilvr_h },
+    { "ilvr.w", test_msa_ilvr_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Interleave", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 516da867cadf..cc94623f8f20 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -15,6 +15,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_max_min.c',
   '../mips/test_msa_int_multiply.c',
   '../mips/test_msa_int_subtract.c',
+  '../mips/test_msa_interleave.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -40,22 +41,6 @@ if 'qemu-mips' in emulators
 endif
 
 tests_mips_msa = [
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_h.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_h.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_h.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_h.c',
   '../mips/user/ase/msa/pack/test_msa_vshf_b.c',
   '../mips/user/ase/msa/pack/test_msa_pckev_b.c',
   '../mips/user/ase/msa/pack/test_msa_vshf_w.c',
-- 
2.55.0


