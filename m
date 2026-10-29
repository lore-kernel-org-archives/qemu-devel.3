Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16B606A32F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kJwHosSv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HqYJSoaC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTtm-0000I0-F7; Thu, 29 Oct 2026 13:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTt0-0007gR-Rt
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsy-0001TQ-RH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGCxZA1619586
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +Bj5QLd6SH7CUXdQf54ZmdgY9zLk2NOMfkwvJJbdN60=; b=kJwHosSvbZeJixRz
 N6947kzsuE/Oh2NOhShbecISu0a2l6EbYZyX6hwN1vKS5i6lJltPGrGhxIs+oWrg
 oZJoPCLtLgZzBLVVhkrTaCKt0shRcBMFc1+nvNBGZZL3waCggd3xgHfuikDpKxbO
 SX/WGBwf00W95GUaFb65tMABRqGR+6kmeGyr5XJDzxucDNh1UtWdZIrWvyLcB0SO
 wTIvBZJc20/JESJPJvK4nw0UTvAWvsIgbA75cvqhs4kK/Tca9QEfg/RgSNhiU8ml
 2KU3Sdjna92oJLE8lhZHP/LTuYbkK5PjROvwcvJJb+np7we9DGKl1TVmyBlSc+Ya
 PZuTkw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q9tbe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:55 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98c6374b678so2126992241.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294754; x=1793899554; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Bj5QLd6SH7CUXdQf54ZmdgY9zLk2NOMfkwvJJbdN60=;
 b=HqYJSoaCkX01O8/nn+PFfEl9MIM5DVZqvZ6bk5VEIhiazWTvWR365g2Alv+sO7osbH
 yzQimk0zc1SFSiobhZCQQXt2ngEMHuQVjgviUfDQmBrgu8R8xETad3+5PI+Tm+ilCpdR
 IKLRjFb3se4arEbLnnXO06MiEyw5z84SZEXlx2lLEin/k3zrn5T/h398ncfpwFInpGEq
 4x9p0ZxdmaFvx7uHQ2Vch8rVYJTNQBD7E320Gx2ZJPrIg+7Ds5rPAxtbS/nQqWlhc9Va
 wSn2kaULx4uTtf3tMlxC1j7I75OoscXPx70ev/IKq5Y57f1Nji5RcML1lhuSXeSQ8qyO
 biLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294754; x=1793899554;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Bj5QLd6SH7CUXdQf54ZmdgY9zLk2NOMfkwvJJbdN60=;
 b=Sgi362JKPZdX8Qi5m2/7vfUsCW3Lqlmru6bZW3U5UBaMTUGb9twWf7Cb9xRJcwE4oY
 n1FRS+R7gQCu5oPn1+hUQtMGPnKuP+2+TQ9qZFqw3H57ZsPNvkHVBqvUaGTzmdOIeO03
 bOE8KD7+JLo5k/X09iBGs2QitCAyWOChSjemgoFRZm4jT0qtrROo7XGv9NYV0moe9vXn
 HD906K/YjpTSfJVsvuT4ZGTicyAeesKhO+kmZXfKL/SfRKDwG4/7ZDB/XlGZL3vc+2jH
 5wqvbt025pRfk2a0UHm2pwaNBJ8K1GpfkMad2o5hsi+bMHrlGh7whJrDS5dj7+ES52P6
 fAuQ==
X-Gm-Message-State: AFq9FYIfUw5P4/bM+UTmqPX/HBdGwXriBP40PZs5DyVngbRftYl0A0A+
 xPn6LrlkQtb3UWTkoKBjTJk1F8LnWOvNvWLo80zK1f5BFtANVtgxIw1lAh69v5zfI8t4rFP2yRO
 2n78/JftHjl805+oILNR4+0kyhyY8m2kLoUwAVpK9XSBz6ISBWdt87Ik6HVZEjyUnvsAl
X-Gm-Gg: AYBFou25YyrHWiAzwYSjLgJdOVw3AZUBkiIvGcH05aBoJeRrxCrPMHH61YxIS971KIN
 bKUE6Xqc2Px706Wnx9nZEpsy/WJ+3XS7/L9TzknMSRswR4oZIL54IjU5RFjAVo2IDtjCsoz961f
 9MZ8gjWIcPF5O8ttkiCJGfGgYzEN2olk3UqAGLPDPskpIF39GHXGbU8eOK4QJ8SkVPhTSGkQFWO
 bghy60IL0quWPzOXBAHC7iH+9lExEsTOI1dtEaKm29261DdncwU0NS15UzEqhJK3l9J1R5iZe7h
 ON0QjCMA6CHX8Fsi6Em4XB+uz9q8ZJRlP2B+4XCxp+heTv5pifKsVzGLdD8GWYrVBzG/TTRoUG7
 C8MJ90gZ18QHnC/yiDKnUGe6XIqg683TWn8iYTPxvT//eEFNAFn1dMtGrZ3i5Lr/d5NtLmx54/S
 H8B2qXmnEubp8kmG21aW7IiEfoHi+LzQ==
X-Received: by 2002:a05:6102:a54:b0:7ce:62a0:6a14 with SMTP id
 ada2fe7eead31-7d03a504ac8mr3051589137.9.1793294754282; 
 Thu, 29 Oct 2026 10:25:54 -0700 (PDT)
X-Received: by 2002:a05:6102:a54:b0:7ce:62a0:6a14 with SMTP id
 ada2fe7eead31-7d03a504ac8mr3051573137.9.1793294753770; 
 Thu, 29 Oct 2026 10:25:53 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfb26f3sm403485f8f.46.2026.10.29.10.25.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:25:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 21/31] tests/tcg/mips: Group MSA int-compare tests
Date: Thu, 29 Oct 2026 18:23:05 +0100
Message-ID: <20261029172319.25766-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX7Z7EEcEJ54Hw
 xt+9lhAG1OMXj2tOtyVbyUeReL5lseR8DPrOcjRXh9to5Kaal5rVEycmxtDNz4KzkCjt6qkap2a
 VjAVAYoU1he71f1M4eGiD9xmWo9wSUM=
X-Proofpoint-ORIG-GUID: s46ameyIz1QdS8L-nQn9VoUxcKFkAezx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX7kGitCUC1ITS
 V2LUWzJt5dVF03qRKRZSmoJMFTXjeQxPD3+c5Y98gqKoToQhJfp5NUNCwBXoIDkajdjhWTivmym
 8xyEZDcubIsTJkhpeX+2p16rOPQeOAGzGzAjIFV4edzPi+W3+X4DKKL1S04KSnLDbJcb7kkUUhR
 rEQ8GZJfNoIvOsSKo9b0dUNtY0qNAUqnDBbhVhqBLzaRbLbnwVMZWaT3gtMHKiAadgAxu/+iAe4
 QqxWzmsN8BMs41EXA/NUrOp/P30yTDrDiYl3ImNEKXbgUpQFRRCN/C9iOJ9pmmPENWJ++Ube9vm
 oryiO1f3Kf0zAjcwUKuHsxfP6QKzSkgxOqzvQlmTLMQ9UfDctnUPy7muKjruntTOjN1x1BuO2le
 KjSmd7MrzZ3j+/KbZtf927kTa0KzDI1xZRZUhmRSERpqC3x8l7Z3RC1SfzgYSFWOeMvwABp5lqO
 ZCyEB2sVxHINlJi0H5w==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae381a3 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=agCbhU3l45mO4j1jyEYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: s46ameyIz1QdS8L-nQn9VoUxcKFkAezx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
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

Build the 20 per-opcode int-compare tests as a single executable,
test_msa_int_compare.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_compare.c | 151 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build            |  20 ----
 tests/tcg/mips64/meson.build          |   1 +
 tests/tcg/mipsel/meson.build          |   1 +
 4 files changed, 153 insertions(+), 20 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_compare.c

diff --git a/tests/tcg/mips/test_msa_int_compare.c b/tests/tcg/mips/test_msa_int_compare.c
new file mode 100644
index 000000000000..b3c9693c9278
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_compare.c
@@ -0,0 +1,151 @@
+/*
+ * MIPS MSA tests: Int Compare instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_ceq_b
+#include "user/ase/msa/int-compare/test_msa_ceq_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ceq_d
+#include "user/ase/msa/int-compare/test_msa_ceq_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ceq_h
+#include "user/ase/msa/int-compare/test_msa_ceq_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ceq_w
+#include "user/ase/msa/int-compare/test_msa_ceq_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_b
+#include "user/ase/msa/int-compare/test_msa_cle_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_d
+#include "user/ase/msa/int-compare/test_msa_cle_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_h
+#include "user/ase/msa/int-compare/test_msa_cle_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_w
+#include "user/ase/msa/int-compare/test_msa_cle_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_b
+#include "user/ase/msa/int-compare/test_msa_cle_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_d
+#include "user/ase/msa/int-compare/test_msa_cle_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_h
+#include "user/ase/msa/int-compare/test_msa_cle_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_w
+#include "user/ase/msa/int-compare/test_msa_cle_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_b
+#include "user/ase/msa/int-compare/test_msa_clt_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_d
+#include "user/ase/msa/int-compare/test_msa_clt_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_h
+#include "user/ase/msa/int-compare/test_msa_clt_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_w
+#include "user/ase/msa/int-compare/test_msa_clt_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_b
+#include "user/ase/msa/int-compare/test_msa_clt_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_d
+#include "user/ase/msa/int-compare/test_msa_clt_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_h
+#include "user/ase/msa/int-compare/test_msa_clt_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_w
+#include "user/ase/msa/int-compare/test_msa_clt_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "ceq.b", test_msa_ceq_b },
+    { "ceq.d", test_msa_ceq_d },
+    { "ceq.h", test_msa_ceq_h },
+    { "ceq.w", test_msa_ceq_w },
+    { "cle.s.b", test_msa_cle_s_b },
+    { "cle.s.d", test_msa_cle_s_d },
+    { "cle.s.h", test_msa_cle_s_h },
+    { "cle.s.w", test_msa_cle_s_w },
+    { "cle.u.b", test_msa_cle_u_b },
+    { "cle.u.d", test_msa_cle_u_d },
+    { "cle.u.h", test_msa_cle_u_h },
+    { "cle.u.w", test_msa_cle_u_w },
+    { "clt.s.b", test_msa_clt_s_b },
+    { "clt.s.d", test_msa_clt_s_d },
+    { "clt.s.h", test_msa_clt_s_h },
+    { "clt.s.w", test_msa_clt_s_w },
+    { "clt.u.b", test_msa_clt_u_b },
+    { "clt.u.d", test_msa_clt_u_d },
+    { "clt.u.h", test_msa_clt_u_h },
+    { "clt.u.w", test_msa_clt_u_w },
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
+               "Int Compare", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index be09044179c2..34ea7d1a7bf7 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -133,26 +133,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/shift/test_msa_srar_w.c',
   '../mips/user/ase/msa/shift/test_msa_srlr_b.c',
   '../mips/user/ase/msa/shift/test_msa_srlr_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_d.c',
   '../mips/user/ase/msa/logic/test_msa_or_v.c',
   '../mips/user/ase/msa/logic/test_msa_nor_v.c',
   '../mips/user/ase/msa/logic/test_msa_and_v.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index c3d025452c4e..e896658e66fd 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -47,6 +47,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_float_max_min.c',
   '../mips/test_msa_int_add.c',
   '../mips/test_msa_int_average.c',
+  '../mips/test_msa_int_compare.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 7483b1aae7aa..c4c9d2e77cb8 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -48,6 +48,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_float_max_min.c',
   '../mips/test_msa_int_add.c',
   '../mips/test_msa_int_average.c',
+  '../mips/test_msa_int_compare.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


