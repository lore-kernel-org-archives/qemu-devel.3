Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E90606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VG7iwBE7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LyUWgI/v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqq6-0007dW-Gf; Fri, 30 Oct 2026 13:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqpq-0006TK-Mb
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqpo-0008Fz-KL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHuBlS2954496
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UEZKY5IWNF/1UIZ8r8xDhoCc+uH8wnxV452oj1Jk18M=; b=VG7iwBE7SaYCOKQM
 Lc0KNFWOQBOkOddpPJeYR8JZ+WX8pd3x4rLZMe19LHfO063pcvYGwtUo4xx0MRvl
 i6ZU29g1RpVvdUMQo6+bl1SK1uIHrx7fXJchi2an+kmJIur1/+Ng5p/4u7npRv0X
 cz6LOq70aQXdPYqgnfW+JB4FdCF2JvBlhQnYAEcALnV0hrk5s9UVshKorJ9qKDXT
 BTGBurp9XBIIVuEBW+fOw136PedvN5sUC9EV8VxO6KD4RDxxpl8eGkXz6zbko1S6
 2nhb+mH/M2Fy+1MLtV3CxO8azBj4L8l1Ta5jelP+KLOTwlv8PLACJKJVqodABbtw
 ba43RA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p4c0v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2373e9b4so98751685a.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382965; x=1793987765; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UEZKY5IWNF/1UIZ8r8xDhoCc+uH8wnxV452oj1Jk18M=;
 b=LyUWgI/vK5tIOcoI+KsJ6rticHE5fXVWdJtpJnfXGygnp0dry3Sk9bAWlXZIcEUhIk
 g3dS+Rjul2PcArashhwKeiCzf7ukNCKe5CKoi9xIexpFNIVA4xeZiBW7uJDuuaq9sNKO
 G84I34jqbL9+3qOnRiwebVMkxpNsqfnlem08ipHIBlf9bAtbzJm+MO+ioXFeP651wQBQ
 duxnyasWRGjnvdR1dpircF6vyU/tIpA1kf9xsk33VbnXrv3SvwXlOmxurNJ76C6qZq9V
 uIl2yt9WKubbYpegQV79SQkRvqMpuVhBu1VZzYNIIgyo71pONOfgFDqC1PYqMsfhaaDi
 8IMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382965; x=1793987765;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UEZKY5IWNF/1UIZ8r8xDhoCc+uH8wnxV452oj1Jk18M=;
 b=lIcSxwKpw/MOAPK/kQxhl/mnN0JmzSJEaqiUt/lX14xsdkiN+JflvdDuEkAXbFvjxg
 jL8nrQZ2dhdx8331RF/IXmbYFLZRU1JKkWYF2H9HTG9LEl0uwEL1xi/BlgQl2Rgyz3te
 CMVU7WNfNnk3n23SZlHtyqXo9jEro/zuqZqijYHdjgrfPJWOhYjlrlbD6w4lPKRD0qV4
 A2gNi0wxW7J8ALJ//e6TUsIAS12np4QadgFefex3TGVWtxbRXPyU6sbCzxqF+Gf7PpV3
 zEu0qLPOUXZPgEejSDuWHwrzDizPKWRz+iTOoNjnW3juSg5MWCFjopwZEqDbtWnj3GVl
 Dx8A==
X-Gm-Message-State: AFq9FYJF5sneS02JiI/M6cUOQSllVm7Vi+w/b/WtO3X/B1szchLD9Eh5
 byTT/Inrq/1v34I6A68kKQ/u8f4VWxp2cj7EZow7yfkWvd6qBGuvruGAgbmXlem+rh9j7/HEBYP
 sUOj1tpqDRd/2MeSZoZgnqxtBrdWC3md54H5CyU59CQcMbDGH4ZHdqt7h6AQHMQeYPQSo
X-Gm-Gg: AYBFou1H6ffKqEWwD6039z+DxNzAFJEAL9Z7Eg9bDf7zCjOW3nUU0fHjHUguPHmZahs
 LPFyjxTc9PtLvtxGFPYiJz08eCB8tMnz0OYQ6r5JHWnA85Am0oAPgjdpim6reKC/kEwh9Cat+eP
 tIMRZ2t6qhzgHXMysODbRnPR2KZ6//jirYGk92/JS/DlyhHnUXmft6027idpYNiyXRacX3fuqtM
 EWWqGHFR+rEX7a/nTbLILPRp5N4ErJjzpo2uZ4y+NpR9foHlyVMkb0eVUX4Sjmhhk8pec6vNPeN
 z8YtVqIamfWdxHaJw447KB2jjZE+am/Y1dL/fvurGFDaW7pK+ULCQ+OSP06Sh3JSPAcDZ0fMGhY
 B0ESock2mMr4lpPd0Yulw9uw5cwcUopNWfih7vB+a/VDLPcGmz35iajsZL2jRNjBtgLUoAlsZvL
 GiKi6m8bz/j3odXt4TTmqobsKgJahYmg==
X-Received: by 2002:a05:620a:1a20:b0:944:9dd:b6 with SMTP id
 af79cd13be357-944217cf692mr552575985a.80.1793382965376; 
 Fri, 30 Oct 2026 10:56:05 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:944:9dd:b6 with SMTP id
 af79cd13be357-944217cf692mr552570385a.80.1793382964771; 
 Fri, 30 Oct 2026 10:56:04 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab61d8b9f4sm112118375e9.12.2026.10.30.10.56.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:56:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 15/32] tests/tcg/mips: Group MSA bit-count tests
Date: Fri, 30 Oct 2026 18:53:37 +0100
Message-ID: <20261030175357.99684-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX3VIUh7UTkoM0
 T6mL4OQCHOH3LXvJxHUnuh3HUfFVGOWMEx9kAo0GYBs/1HQFsa1T6RcoJHhgHjZy6T/Kav248o1
 3bIJ3aDOQKV0Jmk9nxkv+wMiwRIUYmafzP3cU/Tygg0Ve8JJfvxj/NHN/yDbWmS4pib1Hhpip0w
 xvzmXk06aa8kVdbceEVJXnijQ9bhFyqhzKavrBQJF/zOGR8oeEj5z3qLsr2ttgpFoXWEX3Lfxbq
 7FHdA0pd7ZUA+rMyhbtjhblxm13WafW6KNot4F34u/81YiTCgJNPk+31PDelZDgMEeuslwt1V8E
 5dzOb23kntiGQplejCDcyEUtRaECxEmLJDqUVmDqReza2XeE5oreBz79Z80FJJ2llhW1FQFINEd
 AFHMrLX3iwS7+ys5Q4xdPZ7P+er3pVJyIArqQb/IlLjFAKAzDzQicTBFO8wfl5HLLYFVonfAjnP
 5NxbUPAxpgVcWjEJvVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX84AJmYrrmBZV
 5QxvX3qqILUyuyKYE5r5EoT5tsTmB1AZjq3OhWIlZaXMPnXWoHukGgsj9HmL2BWN6MKhC0BIt77
 XS1KkD2MWA7mv6JfrlBBhN1TJGLQbk8=
X-Proofpoint-ORIG-GUID: hCLFUsQvhxW0R0Uhex3Br03F0tdvDmV-
X-Proofpoint-GUID: hCLFUsQvhxW0R0Uhex3Br03F0tdvDmV-
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4da3b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Gg4O5N1BkiYvxTq54M0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
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

Build the 12 per-opcode bit-count tests as a single executable,
test_msa_bit_count.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Prefix the per-instruction summary of test_utils_128.h with '# '
so TAP parsers treat it as a comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/include/test_utils_128.h | 32 ++++----
 tests/tcg/mips/test_msa_bit_count.c     | 99 +++++++++++++++++++++++++
 tests/tcg/mips/meson.build              | 17 ++---
 tests/tcg/mips64/meson.build            |  2 +-
 tests/tcg/mipsel/meson.build            |  2 +-
 5 files changed, 120 insertions(+), 32 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_bit_count.c

diff --git a/tests/tcg/mips/include/test_utils_128.h b/tests/tcg/mips/include/test_utils_128.h
index 0dd38684cf33..8f619bd7d648 100644
--- a/tests/tcg/mips/include/test_utils_128.h
+++ b/tests/tcg/mips/include/test_utils_128.h
@@ -27,6 +27,8 @@
 #include <inttypes.h>
 #include <string.h>
 
+#include "../../include/tap.h"
+
 #define PRINT_RESULTS    0
 #define PRINT_FAILURES   0
 
@@ -41,26 +43,22 @@ static inline int32_t check_results_128(const char *isa_ase_name,
 {
 #if PRINT_RESULTS
     uint32_t ii;
-    printf("\n");
     for (ii = 0; ii < test_count; ii++) {
         uint64_t a, b;
         memcpy(&a, (b128_result + 2 * ii), 8);
         memcpy(&b, (b128_result + 2 * ii + 1), 8);
         if (ii % 8 != 0) {
-            printf("        { 0x%016llxULL, 0x%016llxULL, },\n", a, b);
+            TAP_INFO("        { 0x%016llxULL, 0x%016llxULL, },", a, b);
         } else {
-            printf("        { 0x%016llxULL, 0x%016llxULL, },    /* %3d  */\n",
-                   a, b, ii);
+            TAP_INFO("        { 0x%016llxULL, 0x%016llxULL, },    /* %3d  */",
+                     a, b, ii);
         }
     }
-    printf("\n");
 #endif
     uint32_t i;
     uint32_t pass_count = 0;
     uint32_t fail_count = 0;
 
-    printf("| %-10s \t| %-20s\t| %-16s \t|",
-           isa_ase_name, group_name, instruction_name);
     for (i = 0; i < test_count; i++) {
         if ((b128_result[2 * i] == b128_expect[2 * i]) &&
             (b128_result[2 * i + 1] == b128_expect[2 * i + 1])) {
@@ -70,28 +68,26 @@ static inline int32_t check_results_128(const char *isa_ase_name,
             uint32_t ii;
             uint64_t a, b;
 
-            printf("\n");
-
-            printf("FAILURE for test case %d!\n", i);
+            TAP_INFO("FAILURE for test case %d!", i);
 
             memcpy(&a, (b128_expect + 2 * i), 8);
             memcpy(&b, (b128_expect + 2 * i + 1), 8);
-            printf("Expected result : { 0x%016llxULL, 0x%016llxULL, },\n",
-                   a, b);
+            TAP_INFO("Expected result : { 0x%016llxULL, 0x%016llxULL, },",
+                     a, b);
 
             memcpy(&a, (b128_result + 2 * i), 8);
             memcpy(&b, (b128_result + 2 * i + 1), 8);
-            printf("Actual result   : { 0x%016llxULL, 0x%016llxULL, },\n",
-                   a, b);
-
-            printf("\n");
+            TAP_INFO("Actual result   : { 0x%016llxULL, 0x%016llxULL, },",
+                     a, b);
 #endif
             fail_count++;
         }
     }
 
-    printf(" PASS: %3d \t| FAIL: %3d \t| elapsed time: %5.2f ms \t|\n",
-           pass_count, fail_count, elapsed_time);
+    TAP_INFO("%-10s \t| %-20s\t| %-16s \t| PASS: %3d \t| FAIL: %3d \t| "
+             "elapsed time: %5.2f ms \t|",
+             isa_ase_name, group_name, instruction_name,
+             pass_count, fail_count, elapsed_time);
 
     if (fail_count > 0) {
         return -1;
diff --git a/tests/tcg/mips/test_msa_bit_count.c b/tests/tcg/mips/test_msa_bit_count.c
new file mode 100644
index 000000000000..7f965bc9ec4d
--- /dev/null
+++ b/tests/tcg/mips/test_msa_bit_count.c
@@ -0,0 +1,99 @@
+/*
+ * MIPS MSA tests: Bit Count instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
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
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Bit Count", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 88d598a4f89b..88ec44520377 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -1,5 +1,10 @@
 tests = []
 
+# MSA tests shared by the mipsel and mips64 targets
+tests_mips_msa_groups = [
+  '../mips/test_msa_bit_count.c',
+]
+
 tests += tcg_tests['multiarch-linux-user']['tests']
 
 tests += {
@@ -93,18 +98,6 @@ tests_mips_msa = [
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
index 894f8e9e23e1..ebb4006e7eb5 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -39,7 +39,7 @@ foreach src: tests_mips64r6
   tests += {src: {'cflags': '-march=mips64r6', 'protocol': 'tap'}}
 endforeach
 
-foreach src: tests_mips_msa
+foreach src: tests_mips_msa + tests_mips_msa_groups
   tests += {
     src: {
       'cflags': ['-march=mips64r6', '-mmsa'],
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 9e446eed0f6e..edb59a25454b 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -40,7 +40,7 @@ endif
 
 tests = []
 
-foreach src: tests_mips_msa
+foreach src: tests_mips_msa + tests_mips_msa_groups
   tests += {
     src: {
       'cflags': ['-mabi=32', '-march=mips32r5', '-mmsa', '-mno-odd-spreg',
-- 
2.55.0


