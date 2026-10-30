Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210B606A339
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X6IcQxA+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HGkzg5O7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqpv-0006ec-Rj; Fri, 30 Oct 2026 13:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqp5-0005yt-6n
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:55:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqp2-0008Dd-Ue
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:55:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERnLQ1953689
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JiltmVjvphjPKdqNsV3APiZpcs3L3Po8Q5s6YD1Kcpw=; b=X6IcQxA+/UMhdXww
 rYusCeJw3LZul+0ei8R6T6QJjT0MVfCh36+jkFGFeHTaNqV+Ig4YuIKalZhkbUSC
 VjbvNcLndLyKsx5L8MF6gvDto8v4QiI47e57ysDZ1Q099CvT8o1n+SyRyF8nyll4
 ddZSOGXyNXi3R9NSfSwxVWAXkUUULE5C/M7bZFAh4X05/bAfAT+gnBVTcMHFjD/e
 epyrylSTmNYN7gAs3Mzq6n21qeMyA9KVG9C3LBXDsOr5atnTL19UA8CH/yuWeox5
 i9PzmTZJPv65sTxF3V9wnpqONruOXubnWltkx0cOrKRcOmUWN4QiLQuBs1orCI4P
 qe6KzQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pmbaq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:55:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2c0e6653so164326685a.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382922; x=1793987722; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JiltmVjvphjPKdqNsV3APiZpcs3L3Po8Q5s6YD1Kcpw=;
 b=HGkzg5O7FRoDTedqms8H/FCkSn45Q/SMzrhZWjzyaOhB7+zrXe6OXG6E6dvcqzTw9I
 aKNx7z8e+KCYlQRCMBI8xsvxPAoNIVqcqz/HpxkRZgLtTaPbwZp+7B0JfmYFfM55fiY6
 l1+IA5rRWAs5yytc5XyZy+SWhBXrHOmButUWVgHDC8I1GZxmZfSRW0GzcJHKf62F16Ib
 sUjSJ3tG3me8qctKQ4NJhWt+AOeyq8S9TeCxNbd6VHE49mMYUqxEclLiz1JbwmHCF6yB
 2nY6jpWqksvqOJgsDO5SBB8jIzJ1MqTLSi5fxJz1vPfi1ChieLSsnFRHNmH+6eIFVmHA
 WFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382922; x=1793987722;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JiltmVjvphjPKdqNsV3APiZpcs3L3Po8Q5s6YD1Kcpw=;
 b=QZmXNYWwjXuHTCfvBVyJVyDTuxyFiJjd5epRoOc8sMYt9p327n3neh6YdK+i8HtDB8
 HxD0iYxkIwbTrGgq9It5saRPoySrkrJyqJ02uaPW8cmdgK/K0RBKhiEx0lkBbwqehqtD
 6dRuWvYyt+UrtPzbBTHvxwTdQFYSoAiDJlSH3F5Nm6mA001h1IatM+/NqMbI0uXpsyt5
 5nd0LC3VTB3Orck+p6cr8SNemLAotHTWmcWqNq4SuqR2uGy0sYUL8HKPEXG13qOznU4o
 onar+7Guak8WW5YjlPztWE4KJh6uC9MUf7RQID6+D5rjg+9jVxaknQLtSknITXY3Z77D
 tVaA==
X-Gm-Message-State: AFq9FYILO8fKVIZTvRoAHdKFhUX3EmNwo8n4z1gRdjy2qiJ6pz3+1vCv
 pDi0imSThmlt+fZ9F2iARTT23WtntXOFJVq/Orom3Of7EKvtreh650EuzACn4V9+SvULWtaQ/wf
 Ja4vA0XgRLJpyg7Pgay8dKFM0vMmJP5QpmR48qbU/sB6fZKAH4pCGILkAOKlZTt1qvUwE
X-Gm-Gg: AYBFou1E8709bLjChvabihlr7F4xBQNgRHhcsbL7RdIE2N8Q1wAZtO7E93ce/YrbnrN
 KKO6VufcJOMCLuI+/vnsd7JhBhueKBZt3BjyVCwHJ6q58ty/tUgW3WdG4Tz9MHlspKwCmwGogjy
 C+NaFKaedXMqUfsn48IO44/flddiOpUS21qknrslF929JLgwioZoi2aWVUHX+Dmbhq+ewfS130K
 +S5C3gxaxLdBWvASCVIRdjeFjLijbQFMMLwDKA/hdXB+VqE7a5F0hNPg1okfZqbOoK6XLhXfsqX
 H0BC53xOsiOpZA1p5iD/FhEIePjcuT6JnFlUP4HXWRWy6azgcPB+XR/sVMloCBzXJfuBoppp41j
 ELYTBALYPdK9ugZcvCOWvhewbiiMvL7PpE9SOCq1RL/9eC4gVBxibDRGLwir6iHlfpTlK86O3j2
 LUVLWu7OwZdxWMpo/+yCwymrpc8UmPKg==
X-Received: by 2002:a05:620a:3942:b0:93f:2eaf:64d6 with SMTP id
 af79cd13be357-9442178de0cmr516447185a.48.1793382922183; 
 Fri, 30 Oct 2026 10:55:22 -0700 (PDT)
X-Received: by 2002:a05:620a:3942:b0:93f:2eaf:64d6 with SMTP id
 af79cd13be357-9442178de0cmr516444385a.48.1793382921750; 
 Fri, 30 Oct 2026 10:55:21 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f322c46sm145747135e9.2.2026.10.30.10.55.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:55:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 10/32] tests/tcg/mips: Group Release 6 bitops tests
Date: Fri, 30 Oct 2026 18:53:32 +0100
Message-ID: <20261030175357.99684-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX/A6Dfg9NQ8Q4
 YUDmOS+3WEWe5C1x1RH3reym8/7XpVmbf8vFJ9mVlCdK8J6QQKEVdVc/Jw5nvQDZ9nDv8YSU+Nr
 f7v6xTvieov1ThlEzyMlqPH6cFvJNgGNPktSTsoepJKvXNExYFHLV35n/FwIlv7HIrB2gnAv6ge
 ICyHRsEeRbklvUNnMrpOA81j4T4j0fYNJuAb2Oi50VFxTIiqeo56bd7WILjqLnJabxlq8OqU1G0
 SH32Fp18stWX66ody+4DjJ3ebeyk5LWHbOcBczsGxxRRI86JJ6AOaW7r+oKDB3Io9Kc7M2XTp/H
 ZXOh4o/7odJ3I7dBb5oXEkcqXmGStc9NQBfNZI3YS+Fvd2MY3Q8pzIPKRh/8jn2RvCJvRHtByuu
 JHt+HQbvAiu/eAfBmu26cK5pIaLKbXqzxl/EE9zck/SOH8/7t/85RNa2WMTgJ4r/pqmIJrEZwha
 qgOePNNppwEaAzNAGbw==
X-Proofpoint-ORIG-GUID: GPv12AK1-KDAVLRNiV3pWa8n_71qgW7V
X-Proofpoint-GUID: GPv12AK1-KDAVLRNiV3pWa8n_71qgW7V
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4da0b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=8Gv3jznxhxm61yiCS8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXx2ZqtyqgtYZu
 mUE9iUyrjuk6kaDB6FDGoXdEINtUSnMozcOnp8l1zDUjdGSeeETHkpH3NooMhbH3j5ryHvHjRQD
 CJIfM1r5FdOyaUr5x1VctuSGQ8passY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
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

Build the 6 per-opcode bitops tests as a single executable,
test_mips64r6_bitops.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Prefix the per-case output of test_utils_64.h with '# ' so TAP
parsers treat it as a comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/include/test_utils_64.h  | 24 +++++-----
 tests/tcg/mips64/test_mips64r6_bitops.c | 60 +++++++++++++++++++++++++
 tests/tcg/mips64/meson.build            |  7 +--
 3 files changed, 73 insertions(+), 18 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_bitops.c

diff --git a/tests/tcg/mips/include/test_utils_64.h b/tests/tcg/mips/include/test_utils_64.h
index b785c26d0934..7767ee1a32a2 100644
--- a/tests/tcg/mips/include/test_utils_64.h
+++ b/tests/tcg/mips/include/test_utils_64.h
@@ -28,6 +28,8 @@
 #include <inttypes.h>
 #include <string.h>
 
+#include "../../include/tap.h"
+
 #define PRINT_RESULTS 0
 
 
@@ -41,25 +43,21 @@ static inline int32_t check_results_64(const char *isa_ase_name,
 {
 #if PRINT_RESULTS
     uint32_t ii;
-    printf("\n");
     for (ii = 0; ii < test_count; ii++) {
         uint64_t a;
         memcpy(&a, (b64_result + ii), 8);
         if (ii % 8 != 0) {
-            printf("        0x%016llxULL,\n", a);
+            TAP_INFO("        0x%016llxULL,", a);
         } else {
-            printf("        0x%016llxULL,                    /* %3d  */\n",
-                   a, ii);
+            TAP_INFO("        0x%016llxULL,                    /* %3d  */",
+                     a, ii);
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
         if (b64_result[i] == b64_expect[i]) {
             pass_count++;
@@ -68,8 +66,10 @@ static inline int32_t check_results_64(const char *isa_ase_name,
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
@@ -92,10 +92,10 @@ static inline bool check_binary_op_64_with_input(binary_op_64 op, const char *op
             uint64_t expected = expect[i * cols + j];
             uint64_t res = 0;
             op(&input1, &input2, &res);
-            printf("assert(0x%"PRIx64" == %s(0x%"PRIx64", 0x%"PRIx64"));\n",
-                   res, op_str, input1, input2);
+            TAP_INFO("assert(0x%"PRIx64" == %s(0x%"PRIx64", 0x%"PRIx64"));",
+                     res, op_str, input1, input2);
             if (expected != res) {
-                printf("// error: expected 0x%"PRIx64"\n", expected);
+                TAP_INFO("error: expected 0x%"PRIx64, expected);
                 ret = false;
             }
         }
diff --git a/tests/tcg/mips64/test_mips64r6_bitops.c b/tests/tcg/mips64/test_mips64r6_bitops.c
new file mode 100644
index 000000000000..7b174afd6901
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_bitops.c
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: bit count and bit swap */
+
+#include "../include/tap.h"
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
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < count; i++) {
+        tap_report(!r6_tests[i].fn(), "MIPS64R6 bit count and bit swap %s",
+                   r6_tests[i].name);
+    }
+
+    return tap_done();
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


