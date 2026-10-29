Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369CC606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jmsMLWLH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RaMzCVkY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTrl-0006Gu-B6; Thu, 29 Oct 2026 13:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTre-00067E-7m
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTra-00017Q-Na
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDbLQ3689758
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iLTioeQ49GwWlt4kPVFgUceVxK6RkIx6yR6QQY3nF/k=; b=jmsMLWLHBUV3KyVU
 s44kLQHJmXfnPGYB15zJmIkpg9qW8M/418RhXOoxDK0nkz/7eVDi6nkiwbUfCNiI
 Yr8nceGrKw4/pL0G/Rt0Eh4hwcbZ7veI0pW2FTgCwGtbgMQKq7mJbCjVjLir7P7R
 cho2L3P+WGHFfeyCDoxd4qoIOlypiquZLi4Zx1JFWdCSyurfotzCA2pySYbtZ9S1
 s6pCGNYRGeAa+JodnaF6010BMfqH48gxRSbhWSPhdVv+RAa1TWjzQEHD2m0xo7Jo
 9YgFQLD3OuBCSGmifpwACPr3ZT9QuVyJ+2G8rbs5OGHKgXhuVN/5HxWy8CXu3Y0R
 u0o33Q==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5sb7dv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:28 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-990634bef80so546441241.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294668; x=1793899468; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iLTioeQ49GwWlt4kPVFgUceVxK6RkIx6yR6QQY3nF/k=;
 b=RaMzCVkYGr5/7uFZpfeU6XxhXjdbBC3cllJR/+hcwdqV+Edii5STLPjxUxWSFnsDgu
 ulC27TDap0PjQek0LOYyUvtVXxYHvmRCaF+NAmosZy8IiJ2T/LOxo161x20O6fkMk2tL
 m/zoCINcTER3BEUAnzmf6Y5drwyQ7wlBkofKjmr+8aJL4FVQqu4rG17Me8tMnZh1YVj2
 jZtZ8HUET8xnj2Zj6SL2C0XLkoQb+59MnlIWYvLkC3fAMk7k0jAlP64Y+2KJUosqXaTO
 C8QP19IgvIty3mJdsgjCZtYkqV7ZJk4i71Al4an8Q8oyduh24dIRFPDlJAGcasIJDE/v
 Oz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294668; x=1793899468;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iLTioeQ49GwWlt4kPVFgUceVxK6RkIx6yR6QQY3nF/k=;
 b=BJN4/Yz8pWA10dJVWEnTO3CCDs8wvCIi2Y2fnN8m6Ffr5SYjgKd1Dr+RXMgRvWxg5Z
 kEv94PJs8QWm0eWI9uQT/MW+7fjLq3zd6mtmJB160Bro/ee9kWF9gPZr9fVfjz6zGzPN
 IJtyEaTsRX0PTF/r6S/XrHNCp5NrH8E/N1cUiHHc1m3AGu6tYXXUH+IYDH4BsmkfKgtI
 LIbGUUMvIs3Dfu62rzU1IZTSDvumCdWUadeTdcd1ekIELk/zWwEaR+SWFDL/JJM1x/08
 tTlfIQl6gvt1kO1pxq//u/2T7QI9rd/fm3jaOH+84i6j4HVKFgHH15CEvlmzF+4WFM8W
 y/6g==
X-Gm-Message-State: AFq9FYI5IKa5Z8ol7J6TFSn5rz4pBrHxKwYqjdYhiBjrgIqHp+dsOren
 eKptocj16xGJorw5GI7OkyrxzVE8z1326Phl1eEmpHj1DCx0DId6gDLPVPrlELVJCcXNqzeUWAb
 O0dzpGhiYlB1E3z+Wspt6T/QffnBU3DFAjgWIBvI9EHmYpB4xl6nXiwpSnSEUaHawBMA9
X-Gm-Gg: AYBFou1+jLDgVm4mYssuYb4RXEWpW9LFZECp4yd/qa31Di9NLX8zN/bv+6Nvn6bBhGv
 JqdSbsy6ZhvAg7ReR3R7ZfYr5qWD9Da6kGHZkTgHQFU8OC8sWMYSmPUHMICh1TIkZEmQPD0p0dI
 aBUGgwdDM/f4uC5S6DpRRzUkg0xymBqEhU286J7oQt0wZwUzHYEghfpjOtVXmFIjIHRlYS+1S+A
 oI4qE06hv5TGQi5odro/l3nUUONVCfsAMuu/L70uKA9pSUXEgDsErG+IY136KXaz8e4M6ZHCoJW
 QL3CQUZVpORsotTFo76za9pJ1WVzBuPKIRef/Rv/N37NAgUXRt8JQEYM1sNro/2/uBEYZBBuHDr
 ev9rSY1S2fHA5AeUWUHKV0ah3lIpYs0bHBZzCRfYunNhzNbEAMWKAtdjFsSyDEY751QWYQ7fWHv
 IQPKKXeZL7A66UR60mpgZec6mhWhlsSw==
X-Received: by 2002:a05:6102:5492:b0:7a1:f980:e93b with SMTP id
 ada2fe7eead31-7d03a58d5cemr2383635137.23.1793294668024; 
 Thu, 29 Oct 2026 10:24:28 -0700 (PDT)
X-Received: by 2002:a05:6102:5492:b0:7a1:f980:e93b with SMTP id
 ada2fe7eead31-7d03a58d5cemr2383617137.23.1793294667470; 
 Thu, 29 Oct 2026 10:24:27 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df1e537sm446698f8f.8.2026.10.29.10.24.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:24:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 09/31] tests/tcg/mips: Group Release 6 bitops tests
Date: Thu, 29 Oct 2026 18:22:53 +0100
Message-ID: <20261029172319.25766-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX+Ha869W9JcaY
 hrqYhq/S4U6W+//c19iwsmtLXOLR2g1cUUA2UsxWlp3pxqlv4Ud/AJG5EHIGtS9hOs0AnR7kq1o
 b2Bg2H8SsxaFSKdYm6aF/ykKXmgPQPw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX5dzYG209N7Bk
 8+OA+eDB/DtdMefBeoVPatN5kWxXoq1xI2B/PR7nxgVOxpT3Kq2UYB9m5V/bLNRMj51A8J/DO3u
 S6pIFDqxVozwFkdRVx+755SM9M34c6VeflI6yi2kKKG0nmwBSRvxqFMG9kRAccYitQy0CGvmFKH
 hdlhQKqSjiwKQFslPSYJJTvEaYghcmAIYgFESZn66aTmn59UKX7SXeJRFS8IMfBUKfsMXJ3bwjt
 s/IlrXVbjjrS4/PMcb6LtyB7uXrfgR3yUK2kjaRm06YVtNbaDmbMzQEq5K5AEs2H/qV73YveEGe
 PblFMffNmJv38pFLo7FAp9M4JHlvrypuLOmYgNEt48LdU15Oumic7akxtwdlrgJRok8FCGQp3IJ
 twlh/DF77nY3gTyzoSTV8I0/QVFouQ==
X-Proofpoint-ORIG-GUID: K1KYLGNrw1-bAftT5zfUUBAvBDXrj2At
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae3814c cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=YL-M4H_a8yb8dC8ADtkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: K1KYLGNrw1-bAftT5zfUUBAvBDXrj2At
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

Build the 6 per-opcode bitops tests as a single executable,
test_mips64r6_bitops.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Prefix the per-case output of test_utils_64.h with '# ' so TAP
parsers treat it as a comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/include/test_utils_64.h  |  6 +--
 tests/tcg/mips64/test_mips64r6_bitops.c | 62 +++++++++++++++++++++++++
 tests/tcg/mips64/meson.build            |  7 +--
 3 files changed, 66 insertions(+), 9 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_bitops.c

diff --git a/tests/tcg/mips/include/test_utils_64.h b/tests/tcg/mips/include/test_utils_64.h
index b785c26d0934..fe9f5f3b000f 100644
--- a/tests/tcg/mips/include/test_utils_64.h
+++ b/tests/tcg/mips/include/test_utils_64.h
@@ -58,7 +58,7 @@ static inline int32_t check_results_64(const char *isa_ase_name,
     uint32_t pass_count = 0;
     uint32_t fail_count = 0;
 
-    printf("| %-10s \t| %-20s\t| %-16s \t|",
+    printf("# %-10s \t| %-20s\t| %-16s \t|",
            isa_ase_name, group_name, instruction_name);
     for (i = 0; i < test_count; i++) {
         if (b64_result[i] == b64_expect[i]) {
@@ -92,10 +92,10 @@ static inline bool check_binary_op_64_with_input(binary_op_64 op, const char *op
             uint64_t expected = expect[i * cols + j];
             uint64_t res = 0;
             op(&input1, &input2, &res);
-            printf("assert(0x%"PRIx64" == %s(0x%"PRIx64", 0x%"PRIx64"));\n",
+            printf("# assert(0x%"PRIx64" == %s(0x%"PRIx64", 0x%"PRIx64"));\n",
                    res, op_str, input1, input2);
             if (expected != res) {
-                printf("// error: expected 0x%"PRIx64"\n", expected);
+                printf("# error: expected 0x%"PRIx64"\n", expected);
                 ret = false;
             }
         }
diff --git a/tests/tcg/mips64/test_mips64r6_bitops.c b/tests/tcg/mips64/test_mips64r6_bitops.c
new file mode 100644
index 000000000000..fbdc566b010a
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_bitops.c
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: bit count and bit swap */
+
+#define main test_mips64r6_bitswap
+#include "test_mips64r6_bitswap.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dbitswap
+#include "test_mips64r6_dbitswap.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_clo
+#include "test_mips64r6_clo.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_clz
+#include "test_mips64r6_clz.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dclo
+#include "test_mips64r6_dclo.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dclz
+#include "test_mips64r6_dclz.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} r6_tests[] = {
+    { "bitswap", test_mips64r6_bitswap },
+    { "dbitswap", test_mips64r6_dbitswap },
+    { "clo", test_mips64r6_clo },
+    { "clz", test_mips64r6_clz },
+    { "dclo", test_mips64r6_dclo },
+    { "dclz", test_mips64r6_dclz },
+};
+
+int main(void)
+{
+    unsigned count = sizeof(r6_tests) / sizeof(r6_tests[0]);
+    int fail = 0;
+    unsigned i;
+
+    printf("TAP version 14\n1..%u\n", count);
+    for (i = 0; i < count; i++) {
+        int r = r6_tests[i].fn();
+
+        printf("%s %u - MIPS64R6 bit count and bit swap %s\n", r ? "not ok" : "ok", i + 1,
+               r6_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 3b895a169758..cb9e09ed3c29 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -28,10 +28,8 @@ endif
 tests = []
 
 tests_mips64r6 = [
+  '../mips64/test_mips64r6_bitops.c',
   '../mips64/test_mips64r6_and.c',
-  '../mips64/test_mips64r6_bitswap.c',
-  '../mips64/test_mips64r6_clo.c',
-  '../mips64/test_mips64r6_clz.c',
   '../mips64/test_mips64r6_crc32b.c',
   '../mips64/test_mips64r6_crc32cb.c',
   '../mips64/test_mips64r6_crc32cd.c',
@@ -40,9 +38,6 @@ tests_mips64r6 = [
   '../mips64/test_mips64r6_crc32d.c',
   '../mips64/test_mips64r6_crc32h.c',
   '../mips64/test_mips64r6_crc32w.c',
-  '../mips64/test_mips64r6_dbitswap.c',
-  '../mips64/test_mips64r6_dclo.c',
-  '../mips64/test_mips64r6_dclz.c',
   '../mips64/test_mips64r6_dmuh.c',
   '../mips64/test_mips64r6_dmuhu.c',
   '../mips64/test_mips64r6_dmul.c',
-- 
2.55.0


