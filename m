Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD74606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E4DnhoJ4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZptKkMJX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTss-0007IU-4b; Thu, 29 Oct 2026 13:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsD-0006pK-LN
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsB-0001BT-7D
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDFks542847
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uJaxoVRClhk+/ic4X1+ha3GJP0rI0maFxc793iKVyoc=; b=E4DnhoJ4dfUuh9aP
 StaHQNNIP6hrDQKV1ex8DOwuVgsXh+ONnR2Ikz2KF2Kft3nPkLvfpqnqaVuFcgGm
 KCvrlLFaYU6ksF8egkpHPFQGx6cYJj0DUU9/wSuQw0ZRoTx/vJwvh12dZFh1RToJ
 qx1rep+kMbkz6eKxXmg6YO+lDz+dhJK/HH3GCn8YfdcTAoLwCF/ChxbMuf+sXlpx
 QKrli67UJ0F71SSQ9PUY2I0aHpm1mnHDwyvdcaGEmBDoTtJxq/0wMdCPudQdjwzT
 KV0E2W2+aGVVoNtjzBSFaO2JuQMp5is6+RkJ2H2c38TDWcfVyxnRGv68GfykLMbw
 iv6PTA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkxshuhq6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:05 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-988bea8fed6so1857212241.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294705; x=1793899505; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uJaxoVRClhk+/ic4X1+ha3GJP0rI0maFxc793iKVyoc=;
 b=ZptKkMJX9GE6UrEa2aIxaHNh2N0IoId/puJq0QMlyX2kTrnGyk/1+jmbG8UM6d0U42
 sNVNdJotJxw+1clJ23HdX2VffOhjNOos70AizZdWc2cAW0GN+SEjPqvv7x1HHNn2Ivug
 aIrcNG0koJP0z9gjENBtLAFjo2K+wRk/icyapcWEbdzUyIuVZ+M90ycmvHECNn8RBG6i
 MyVzgF9tj4CJ6X6GIR7iDjRNMNW73eA0ztoAWqDdq8u3J2B1iXDAKB6VRcJqTnbGg00g
 rf+5Pf0nOzbOpPOis2a3Wjcu39sn1RFYehAOdzV/aYyfKCIZ4KNUMQnDnm4ndkG+77j1
 /abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294705; x=1793899505;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uJaxoVRClhk+/ic4X1+ha3GJP0rI0maFxc793iKVyoc=;
 b=1n5pq4yxt1TPBTSR9dHwxx+9vQ2FGKaQVwQHifsNzUTM81VzIZdMwhtq3P7M24geds
 pJ58QKPILsC9hyxEsXxVQx6hmGYc0OsueBkNV4LZE5IJhpnknr7vYoPSfVW7gP+N1hNm
 QBvKIqQ7AJVGxFg4KoKrZDrV05dMQciirj5nMeq6IhOdyJ+zJ4P4HQX+vzAiy1ON8Mjl
 uPj1niGB19PwloMBBilZvGtbzOA/06c89bv5aIpDKV4MEeJqEbsH4t/apTIyCBwVyYPz
 JALTAXR1hgmppHXEXzfdHUTFiIuFkVDeXggksOeiKIkwHZRJFh4UZGz+nan3n5hmDs6/
 l4UQ==
X-Gm-Message-State: AFq9FYL6WhsbPyqVdoYFhqnVLhH92tL12TT91WbGrfzcasARRzqF3f2z
 Mo2AY8IzHxLkslVr2JKnVW8bZvu1HuW5Yf49wq3lsSi9pDTW2TWOebjew+eZqRfVypGpY4VVlNV
 Gk7pYQzdGo9nJVoCdwHTElmx+e01oMHlghmUxQLzDy/ZI52L1pv+1qIzBDMPTiAtK7eUu
X-Gm-Gg: AYBFou09pZpn0E2Kpg+jnKtSszrUsSZ4QeBVHs+rJISX0P5gsi5rs7z0E1CfMrXkxvp
 H+sMTpliKjZMBqRkQgMZ8KNlrR0kqxxB+NqCuYdG+yGw6qG6E28jdqHueHzalTXj5Ku61knMYzS
 Rt1h0dhEtDeq1T6UjfNztt1NaoZBmUobf94NhRiLuTLAxsh4WjFiRdnC5o0qF0nqT9ixbGLTwLb
 sY9qz7UWJXni097tR0yZvGq+pyuRXEQNzENW9ndGznhMIx9PkjuSUDw8qJbNONu64NLVFpwE/+E
 IOMGzvDB6JfamP0x058hDNDwcC6DCjPndd800cVVMdsQtXJk+5XTszgZ4S4oapIksboejgSEozg
 0mBj0FeUVQ/O35PTdfV/Z1jbMu9N8D5fUA84WpQUd097hznWzzZ6U37GUpn/TlNQL1S11XLvNz3
 KKOibL8WFfvP3xil5W/7LPifWDSh10MA==
X-Received: by 2002:a05:6102:149c:b0:7ad:3ad3:997a with SMTP id
 ada2fe7eead31-7d072247aa7mr12395137.5.1793294705008; 
 Thu, 29 Oct 2026 10:25:05 -0700 (PDT)
X-Received: by 2002:a05:6102:149c:b0:7ad:3ad3:997a with SMTP id
 ada2fe7eead31-7d072247aa7mr12380137.5.1793294704481; 
 Thu, 29 Oct 2026 10:25:04 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6deafdb5sm576315f8f.0.2026.10.29.10.25.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:25:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 14/31] tests/tcg/mips: Group MSA bit-count tests
Date: Thu, 29 Oct 2026 18:22:58 +0100
Message-ID: <20261029172319.25766-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: v6WG8k_vpPkC3cobUr6tG3WGsoVQDe-D
X-Authority-Analysis: v=2.4 cv=H6BOUOYi c=1 sm=1 tr=0 ts=6ae38171 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=pNbjfAwrdh_UGBuOZC8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX2L/vDJrHVk6J
 FzxUlH6xN7Cbqdsi6M0oQWdmmX8ATJiN+GjnQZZIEFCIbPjth77B25Bmw4BZDr6kq30HwQRPX89
 aAQg4gTYaitQvApG/sWffk9vaIeZSXM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXy/+MxMeQZ0nr
 BcaGPeCh92irtnFwqEsgZH/EB2jRTDCZKCAMgi1uX3iZWPOu2rX2elyu/vdIJTAAC/3KVL3wti2
 x0JwHVMJpq5HSL/QJdtvZJ0YINU2CqIueB6knSVsXTlbUxUUT1AoatWPBUuaqTy4NZhWX2bllNP
 R+KsUpkPkEumsRjg4NYyG8elR6QGt9lQBrBerunhtGGUaiNTMULFGjQeANQMsJyzamEY+BmyChz
 Mz5KvRggcHMeZkgtzSUWgrKRIJfCkQPW48GYKpj5aBsBZNjNOPRIK4lP5QWVhMkaSGMU70B7DKg
 JvdvUZa/zqsigxPtwhn1a3Z1F3wocB4W9B9mAar0DuEhNNZ7Akxi2L23c3C2rra/jk3YPc7QRii
 MmoX7iuLq/sYLIGhPhJ0f6dKr2fB+Q==
X-Proofpoint-ORIG-GUID: v6WG8k_vpPkC3cobUr6tG3WGsoVQDe-D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Build the 12 per-opcode bit-count tests as a single executable,
test_msa_bit_count.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Prefix the per-instruction summary of test_utils_128.h with '# '
so TAP parsers treat it as a comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/include/test_utils_128.h |   2 +-
 tests/tcg/mips/test_msa_bit_count.c     | 103 ++++++++++++++++++++++++
 tests/tcg/mips/meson.build              |  12 ---
 tests/tcg/mips64/meson.build            |   6 +-
 tests/tcg/mipsel/meson.build            |   6 +-
 5 files changed, 114 insertions(+), 15 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_bit_count.c

diff --git a/tests/tcg/mips/include/test_utils_128.h b/tests/tcg/mips/include/test_utils_128.h
index 0dd38684cf33..9ba877d84b5c 100644
--- a/tests/tcg/mips/include/test_utils_128.h
+++ b/tests/tcg/mips/include/test_utils_128.h
@@ -59,7 +59,7 @@ static inline int32_t check_results_128(const char *isa_ase_name,
     uint32_t pass_count = 0;
     uint32_t fail_count = 0;
 
-    printf("| %-10s \t| %-20s\t| %-16s \t|",
+    printf("# %-10s \t| %-20s\t| %-16s \t|",
            isa_ase_name, group_name, instruction_name);
     for (i = 0; i < test_count; i++) {
         if ((b128_result[2 * i] == b128_expect[2 * i]) &&
diff --git a/tests/tcg/mips/test_msa_bit_count.c b/tests/tcg/mips/test_msa_bit_count.c
new file mode 100644
index 000000000000..dacfb619f8fc
--- /dev/null
+++ b/tests/tcg/mips/test_msa_bit_count.c
@@ -0,0 +1,103 @@
+/*
+ * MIPS MSA tests: Bit Count instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_nloc_b
+#include "user/ase/msa/bit-count/test_msa_nloc_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nloc_d
+#include "user/ase/msa/bit-count/test_msa_nloc_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nloc_h
+#include "user/ase/msa/bit-count/test_msa_nloc_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nloc_w
+#include "user/ase/msa/bit-count/test_msa_nloc_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nlzc_b
+#include "user/ase/msa/bit-count/test_msa_nlzc_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nlzc_d
+#include "user/ase/msa/bit-count/test_msa_nlzc_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nlzc_h
+#include "user/ase/msa/bit-count/test_msa_nlzc_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nlzc_w
+#include "user/ase/msa/bit-count/test_msa_nlzc_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pcnt_b
+#include "user/ase/msa/bit-count/test_msa_pcnt_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pcnt_d
+#include "user/ase/msa/bit-count/test_msa_pcnt_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pcnt_h
+#include "user/ase/msa/bit-count/test_msa_pcnt_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pcnt_w
+#include "user/ase/msa/bit-count/test_msa_pcnt_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "nloc.b", test_msa_nloc_b },
+    { "nloc.d", test_msa_nloc_d },
+    { "nloc.h", test_msa_nloc_h },
+    { "nloc.w", test_msa_nloc_w },
+    { "nlzc.b", test_msa_nlzc_b },
+    { "nlzc.d", test_msa_nlzc_d },
+    { "nlzc.h", test_msa_nlzc_h },
+    { "nlzc.w", test_msa_nlzc_w },
+    { "pcnt.b", test_msa_pcnt_b },
+    { "pcnt.d", test_msa_pcnt_d },
+    { "pcnt.h", test_msa_pcnt_h },
+    { "pcnt.w", test_msa_pcnt_w },
+};
+
+int main(void)
+{
+    int fail = 0;
+    unsigned i;
+
+    printf("TAP version 14\n"
+           "1..%u\n",
+           (unsigned)(sizeof(msa_tests) / sizeof(msa_tests[0])));
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        int r = msa_tests[i].fn();
+
+        printf("%s %u - MSA %s %s\n", r ? "not ok" : "ok", i + 1,
+               "Bit Count", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 88d598a4f89b..40984e9b4fcf 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -93,18 +93,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
   '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
   '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
-  '../mips/user/ase/msa/bit-count/test_msa_pcnt_h.c',
-  '../mips/user/ase/msa/bit-count/test_msa_pcnt_b.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nloc_h.c',
-  '../mips/user/ase/msa/bit-count/test_msa_pcnt_w.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nlzc_h.c',
-  '../mips/user/ase/msa/bit-count/test_msa_pcnt_d.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nloc_d.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nloc_w.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nloc_b.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nlzc_d.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nlzc_w.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nlzc_b.c',
   '../mips/user/ase/msa/int-add/test_msa_addv_d.c',
   '../mips/user/ase/msa/int-add/test_msa_adds_a_h.c',
   '../mips/user/ase/msa/int-add/test_msa_add_a_h.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 894f8e9e23e1..bcc02d955436 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -39,7 +39,11 @@ foreach src: tests_mips64r6
   tests += {src: {'cflags': '-march=mips64r6', 'protocol': 'tap'}}
 endforeach
 
-foreach src: tests_mips_msa
+tests_mips_msa_groups = [
+  '../mips/test_msa_bit_count.c',
+]
+
+foreach src: tests_mips_msa + tests_mips_msa_groups
   tests += {
     src: {
       'cflags': ['-march=mips64r6', '-mmsa'],
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 9e446eed0f6e..8b4e665634ab 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -40,7 +40,11 @@ endif
 
 tests = []
 
-foreach src: tests_mips_msa
+tests_mips_msa_groups = [
+  '../mips/test_msa_bit_count.c',
+]
+
+foreach src: tests_mips_msa + tests_mips_msa_groups
   tests += {
     src: {
       'cflags': ['-mabi=32', '-march=mips32r5', '-mmsa', '-mno-odd-spreg',
-- 
2.55.0


