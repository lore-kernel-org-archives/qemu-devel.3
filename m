Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jkpnqrr5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Azokl9V/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoBd-0005oX-Pk; Fri, 30 Oct 2026 11:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoBI-0005Z0-BM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:06:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoBF-0007YI-Rm
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:06:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERDKQ4102993
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VakULRF/ZlzQg9DlX20JmxO+/KBixFvRDBeFbdHtf/0=; b=Jkpnqrr5q2n2zc/6
 Zf7VXQ0n5CbTfwoz812dXvUCR85t2nBXvo8qVqLyyD8OrdO/g6uzhcwfgunbL6e5
 v16xJIXGabAeWYQqBQJvGBJvx344H4UNaTLTk0H3oZlfaujfK6LYav5PuDhOH7JR
 /o+D2LzECiUFdIIn1c5nkZN8HofSa3kD9knxA5gSB8CKdkLZ/NR67jQGxaUB9XGB
 QVnH6WZUHb7hRiK4cjQnTY03GAabswhUZJudE4hDsaPQkB3K2tzpF4VsaJm3BsHa
 Jr4YjRh+yn7IldWHcFikCljNQmkVfqCUvWkACAs6sKxqpP0xqgTmlSIfSSBGf1cU
 0nZA0w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkn91-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:06:07 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-990aa76e3daso237767241.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372767; x=1793977567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VakULRF/ZlzQg9DlX20JmxO+/KBixFvRDBeFbdHtf/0=;
 b=Azokl9V/822cy5NR1arHEQr9Tlav55spBXDj0GiBpngHfyE9UMUUXZzO1FXtFybpjS
 SM2bDRJ5MSWJxT3CoCf7i1WPdbUMFQH9NReYNW5KUyVVT58p/6syvy6V9HrUKPSsDeNT
 bHYrKqYO8C13eCDQ4Ls9244cXUldRxk/g76X3qHi0PcSMORwJuHTflDdN353VrnmhX3U
 +DiJByfx2Q9JjiWNNzm//A+uYA/6FKupLKN+dOY9fVHDy6qncOtFhapOb4R9imL5GLrr
 y+QZx7k+wQADVx9j+YUYi65mKn5WKr1P2RM1Mss7f9DYDsueiUwlTLBWA0oGSmMTmZnP
 38Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372767; x=1793977567;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VakULRF/ZlzQg9DlX20JmxO+/KBixFvRDBeFbdHtf/0=;
 b=A6FMjDhoxpnL3rlSLJCmtMQyMC7WmSybFW55XTy7r3efvXwRauuvsZFrEU+QnOScy4
 H60hEvqxPbxfHZMi8jQsLByPWsrphW+RmFlHGw+mn+u51dThUXIANFYdiH+wRqzGG+q9
 wg5Sh7VGQA0FYOXMfGmPu+BQ1B5rzeRVJdV66El7xl1I8MlwN6GzwrNyHX4VNSctjKGp
 dMgRDETppON19W49OFEBdAVkRFKd5AoiXHjdUzNdEWsW7KuBtThgbzlIp0GhEKLLFUKu
 ndNo3ZMqf60/bd2bVK7XFB3BUb1cEfgK+/rq9KCb9Xf78jlgHY7rSphMikUGMStaKJ+s
 +ZdA==
X-Gm-Message-State: AFq9FYIaH6kht64sCLD/vCAUsGbKq5vfNC6KCN9bCKwSW35VoP4chnIb
 sVbXjnbXpMo660+vJbGRv+VGRK56p1ECpJDoeyHxJ6mFBJ8NmZU6b47nKGEFS8ppQBl/056oAoN
 f/gG1/+TsPXUNA2oH6LqC7pvik7rCEvYYMX5VeRo0TWx2st9f6M226jW8yYTAfTg+Eyu2
X-Gm-Gg: AYBFou1t23YCgHFKxDMXSFRLaHc1iPXq/rsTva/wnRqL4qjhmfb/+Lu++SpccFBVr7t
 GVfSeTUq1tiuMAmGpoI+J9WIOZ01Occ5wRw3fL6ERsEe3XVhJvkGkF/DsxsIiCvk+gpKKetuzjd
 bzTb9BZPjAGg1U9SMq8cR9TsS1dsiKcQgjQ85zAxsaLDBx6cPIvNGAKR1zd5GPo1nQd4WoPNeX9
 qMWtHub1sSE3dD5WP+WwLfXnO1e1Gg57+mIYN+mHx8O7rf5Um2ioh+LWCio522gNRQZTZWshyN3
 iacUgoRZaFFMvQKP/Doute/xS0uM5usoACfxx1ON6yA6h93yBMZ7lmHDMaVaEPhDKxPb0Q4CGoJ
 Af2Uf+Izxxq/cR57LNk5S/UMCBb5HSiBtQCwR6Yc2bLfXPidP73+/VCdG8KbgFXrEGY2lYE6Z6+
 AXK0mNt1AINjNnlrBiBqqgWu6luHQZYA==
X-Received: by 2002:a67:e116:0:b0:7a1:fa0f:1106 with SMTP id
 ada2fe7eead31-7d072d759a9mr1037550137.36.1793372765197; 
 Fri, 30 Oct 2026 08:06:05 -0700 (PDT)
X-Received: by 2002:a67:e116:0:b0:7a1:fa0f:1106 with SMTP id
 ada2fe7eead31-7d072d759a9mr1037496137.36.1793372764526; 
 Fri, 30 Oct 2026 08:06:04 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm144203965e9.4.2026.10.30.08.06.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:06:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 28/31] tests/tcg/mips: Group MSA logic tests
Date: Fri, 30 Oct 2026 16:01:58 +0100
Message-ID: <20261030150202.61556-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX5T79LHZHbNiq
 r5SmiQCcDiRUffLjz549dYcE8e1+uhjbjJDcrEPwGC5tERC/j316Cw3jxZwgZjyfirJQPGonqei
 sjRuV3X+w8uRXYcUuvmBac9bwPSXq1sEtLeXm4Ck0tVkYh4MYWP5iOrw9ABV9brgqNy17sVZsJb
 RpFNFUk2Ko7RNGaGjT8i6hxiHDEMcsF4MtAd0HaTPfErSoo8CdUOvxt8Q5s/rTc9CJ88AW0YJEF
 J/8xQliP8GDrYelNROQcV7DrbDD5LsgNXpH29ILfWY24NhRWHAo2FV0QGphNgmKfVJnv4HQ1JCq
 evb8T+SqNYRdzlLTR4YNSkOjkx4RuwKVZcy9iOcSiD464pYVFscCi8PALTTZOtu3GyWJKztsmRD
 4ASg7osk4MvwgIMGMsWd2QDyu6PJD0WQO7UQy6tJe5CETz/xYN6HwAedLmFP27cHHnegTqGxvR1
 Pml2XEgo+lzHAkdhExg==
X-Proofpoint-ORIG-GUID: ErLdvs76DSnwLeWtDF_M0eJRun2ri13M
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4b25f cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=XEEDF0r_pM4_IqxSCIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX/+t6t1N5lrph
 7wrsz1bxxxLIgA3XeMhmWlNNFJazDwz44UjFAEoWPeTh1IGkwOHna/pU7+6sSHKUabssjTSXaC1
 1nDo16sa2HuiOVe2cuPm+oR0Mbng4D4=
X-Proofpoint-GUID: ErLdvs76DSnwLeWtDF_M0eJRun2ri13M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300060
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

Build the 5 per-opcode logic tests as a single executable,
test_msa_logic.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_logic.c | 57 +++++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build      |  6 +---
 2 files changed, 58 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_logic.c

diff --git a/tests/tcg/mips/test_msa_logic.c b/tests/tcg/mips/test_msa_logic.c
new file mode 100644
index 000000000000..4e96c3ebf0e9
--- /dev/null
+++ b/tests/tcg/mips/test_msa_logic.c
@@ -0,0 +1,57 @@
+/*
+ * MIPS MSA tests: Logic and Move instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_and_v
+#include "user/ase/msa/logic/test_msa_and_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nor_v
+#include "user/ase/msa/logic/test_msa_nor_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_or_v
+#include "user/ase/msa/logic/test_msa_or_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_xor_v
+#include "user/ase/msa/logic/test_msa_xor_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_move_v
+#include "user/ase/msa/move/test_msa_move_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "and.v", test_msa_and_v },
+    { "nor.v", test_msa_nor_v },
+    { "or.v", test_msa_or_v },
+    { "xor.v", test_msa_xor_v },
+    { "move.v", test_msa_move_v },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Logic and Move", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index cc94623f8f20..ae2c2fa6aa48 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -16,6 +16,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_multiply.c',
   '../mips/test_msa_int_subtract.c',
   '../mips/test_msa_interleave.c',
+  '../mips/test_msa_logic.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -73,9 +74,4 @@ tests_mips_msa = [
   '../mips/user/ase/msa/shift/test_msa_srar_w.c',
   '../mips/user/ase/msa/shift/test_msa_srlr_b.c',
   '../mips/user/ase/msa/shift/test_msa_srlr_w.c',
-  '../mips/user/ase/msa/logic/test_msa_or_v.c',
-  '../mips/user/ase/msa/logic/test_msa_nor_v.c',
-  '../mips/user/ase/msa/logic/test_msa_and_v.c',
-  '../mips/user/ase/msa/logic/test_msa_xor_v.c',
-  '../mips/user/ase/msa/move/test_msa_move_v.c',
 ]
-- 
2.55.0


