Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064E606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jzEpR6FW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KWqkWPE3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqpx-0006m8-P7; Fri, 30 Oct 2026 13:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqpE-00069R-1W
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:55:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqpC-0008E6-8R
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:55:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERHOw378541
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YyKKmaUgyc3XUXqP9qbvza1eK819yaAt4RhY9LOCstI=; b=jzEpR6FW0X5F7YVx
 iFAulwyzPDWpWr7FcDAy/ctrL2e+E/2/Rba7Tlivy0QCXnjeGLW2jEuirMScfBG1
 iql2wFN//JO7XttwLU59Mi/3SOFEP1fqZRhXdH0y1yrXZ9hbjuOjlMVJMHYcaJV5
 qqS/+41n63RcKfvB80KfL8c7sX4ya/+T5M3YGl4V97MCGqnDBzDkQVC96+TbjjIL
 wsqNzHwaEF95+OQ6gZ/lvKwZb5r+p4+VUrVXlBOAbduMrCd16EIlogVjbu7VusFj
 CYpj4eba3+QTaSBqK+Ez/NuAtOJAlpRdtjsNGUN93wMFRv87CibMuTi4uhieS6oX
 zuagAw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme754a4y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:55:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f37c94ceeso391500785a.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382932; x=1793987732; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YyKKmaUgyc3XUXqP9qbvza1eK819yaAt4RhY9LOCstI=;
 b=KWqkWPE37f73SYdrBJadikGhr4Gw2K0YIDhl3NO1mxKbvJt37ef1DDayHh7b7ATEke
 dul9rlM3utlua1CAyJ6DiqU4jCqWNvbNIHFekH056gmtd7CGLWEviJ1GCr4VLULPpp3V
 uR49+/wnZw4o9YlUsmakLRHsP3dYsVR5n3km5ZMx5jYSVux8JvdBDThmgED0IBrnEXR0
 DoRxkKQOZQSxJT9zS22UU/rTjOXgItStc5FyklN0PedFMZtmzlzmgdhgff4pqKrQM9jH
 cx+LBwEAbeGcsVFzGBxHU2hRJgQWeZNTNQS2YOKc++C4yfnhgLenQeCtfdzqzB5/oI4T
 K1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382932; x=1793987732;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YyKKmaUgyc3XUXqP9qbvza1eK819yaAt4RhY9LOCstI=;
 b=BN86sPwCXkl6nGUa51m6U16e1lHleDinuWmyH829ajHJlZlUwSM/PU3rcMehk+TpGa
 OVP9XlfMvRd6ZgK1BvcXui6L9qPIYFC/Fk3GNgCbOaV4Amq9loUDH86Z+sKUhrWNLIJZ
 TVck+jXYZTQjWaLYvLUPWA1ajKMEKFMsJxV+PDlXJIcFKnrWdfY6P6WYL3KzfWHCdU2R
 BwUBQGGI31LFUCFxdu5SxvFB7CWqmffu03IWx/Gc/nVzWg1bHoYjWmfxF3k9WcBqde7M
 xXUaaYeU60XtVAqgP9ZKwe0XmAM1uz3oM37m1ovF/UNLhHO5ZvSX88jjZLNBVTBy+BW+
 ILmA==
X-Gm-Message-State: AFq9FYIMtmoc12aKFP6KRETkaUBIB/6GAzp7wQH4PftNLojcuNs48DS2
 6tNs+RKt/Ikgk68lBe5ojnCn4mzl6QJeY9opoGqk852qXckcwunaPru0sDmLopWQXkVWgq8Zqo2
 kNQ7NXwnG99gSZM6M4cSonGDk+1bDXBqe6MhGrMHnB9avB+zH/AYWJ2FgmbjmStLl6FFB
X-Gm-Gg: AYBFou2BsSvKa50UmuYJSxGIFG81orL9ymqTSN2HaHu9c4/PGCALcsrALOU892dyWZ2
 +6u92Vl5E3CC9xI2k0vaZ2qR5l/5ypU1GiTe/5QgGgOpah/+tL0uGCWDZE4wqX1A7BYRNIjJLhr
 Y5apNa91JUS84kzl5/Hp+K0uqMiWcgLmpiB7mU9udtPyfTo9Q+0I0PpJnN6fQ4cXE6CkfPmZag+
 Y73f3lEgPAzI0cgBq9QPKRFWw/r0VArSMBxa8mnl4GEbUREiLjRzgcOql/VChrRUuDERKr6Ev05
 UYTbDGJcFeAUy0b/AUrbz9COu+RIlhv8cbRkd67EA88hixdxNwiGl954J+Xwa7gSsPycJKM/KUB
 lL3gtWVSeS59R7cICzcEje4sVFjAPU3vZnMDEMNUlFpG3GBRDqPDV10makcUsNTwlODC+WRTrfa
 uAeiqb0F26jfAb7r+c2f40cYLoYzjYgw==
X-Received: by 2002:a05:620a:450f:b0:940:f224:5a66 with SMTP id
 af79cd13be357-944133b8d86mr993896285a.30.1793382931587; 
 Fri, 30 Oct 2026 10:55:31 -0700 (PDT)
X-Received: by 2002:a05:620a:450f:b0:940:f224:5a66 with SMTP id
 af79cd13be357-944133b8d86mr993891185a.30.1793382930661; 
 Fri, 30 Oct 2026 10:55:30 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04723sm172789935e9.5.2026.10.30.10.55.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:55:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 11/32] tests/tcg/mips: Group Release 6 crc tests
Date: Fri, 30 Oct 2026 18:53:33 +0100
Message-ID: <20261030175357.99684-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -Xr59860Eq9-vMkSZVW3FUZ8li2VaTFA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX2DvZtbtM19FZ
 9QYUf9FJNdncZbbggL7og8NI2oh6hX2uFCzJN+spdPD8tFIK2SSQx6Bz2r7chOFPYxGOa/zcuOs
 MzOKSeEGTArkH3co1xHltS+969pwTdLDijI61FLfOuRIoAlpjAJNa6x4eRltAIvqR7XPCUOU6MI
 HsQJ6xXueKViGmzw7Os8XCskCjcebZ5iEJk/Mooh3moSS0GLdStmx3f25WzsOembYvQ8+CIvYnL
 K2R5gAJWnYzMU1vD4iyMYhz0Wie3lfh+pp4BgWnUt0bsAT70w7U29z0p1iE5j1JJG0WMKWnikOj
 MsLBAUnH/KZ4rB0hrtfGiLsjLHkTC8X1V2B2FlJWKA+AxNehLFctCoM3YAgRMTuxk30ZGglZDeg
 Kv+emQcZ/XsKPEFMh3J/OyI+iVWwYgUjo9dZLEC3zLso2h5tM47Tu1XC2cxiUSTI0soH5I9v6P5
 DpXpt0KNquPI0UOSlQw==
X-Proofpoint-ORIG-GUID: -Xr59860Eq9-vMkSZVW3FUZ8li2VaTFA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX5qu7PcDA1WVm
 QKEJpU/4N1PFTQa76LD9/fNxEqOVMUY2WSUfdxrSA53TiahO9C2rpP4Ls0S0D8QoDcpqQwlEAJZ
 1pjBWAMgnBY5nDQxdqUnkXdyAsbEbC8=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4da14 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=mgfkhx_GbAYBFjwR9pIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Build the 8 per-opcode crc tests as a single executable,
test_mips64r6_crc.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_crc.c | 72 ++++++++++++++++++++++++++++
 tests/tcg/mips64/meson.build         |  9 +---
 2 files changed, 73 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_crc.c

diff --git a/tests/tcg/mips64/test_mips64r6_crc.c b/tests/tcg/mips64/test_mips64r6_crc.c
new file mode 100644
index 000000000000..75943cf21353
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_crc.c
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: CRC32 */
+
+#include "../include/tap.h"
+
+#define main test_mips64r6_crc32b
+#include "test_mips64r6_crc32b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32h
+#include "test_mips64r6_crc32h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32w
+#include "test_mips64r6_crc32w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32d
+#include "test_mips64r6_crc32d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32cb
+#include "test_mips64r6_crc32cb.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32ch
+#include "test_mips64r6_crc32ch.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32cw
+#include "test_mips64r6_crc32cw.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32cd
+#include "test_mips64r6_crc32cd.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} r6_tests[] = {
+    { "crc32b", test_mips64r6_crc32b },
+    { "crc32h", test_mips64r6_crc32h },
+    { "crc32w", test_mips64r6_crc32w },
+    { "crc32d", test_mips64r6_crc32d },
+    { "crc32cb", test_mips64r6_crc32cb },
+    { "crc32ch", test_mips64r6_crc32ch },
+    { "crc32cw", test_mips64r6_crc32cw },
+    { "crc32cd", test_mips64r6_crc32cd },
+};
+
+int main(void)
+{
+    unsigned count = sizeof(r6_tests) / sizeof(r6_tests[0]);
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < count; i++) {
+        tap_report(!r6_tests[i].fn(), "MIPS64R6 CRC32 %s",
+                   r6_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index cb9e09ed3c29..0601ed52ab21 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -29,15 +29,8 @@ tests = []
 
 tests_mips64r6 = [
   '../mips64/test_mips64r6_bitops.c',
+  '../mips64/test_mips64r6_crc.c',
   '../mips64/test_mips64r6_and.c',
-  '../mips64/test_mips64r6_crc32b.c',
-  '../mips64/test_mips64r6_crc32cb.c',
-  '../mips64/test_mips64r6_crc32cd.c',
-  '../mips64/test_mips64r6_crc32ch.c',
-  '../mips64/test_mips64r6_crc32cw.c',
-  '../mips64/test_mips64r6_crc32d.c',
-  '../mips64/test_mips64r6_crc32h.c',
-  '../mips64/test_mips64r6_crc32w.c',
   '../mips64/test_mips64r6_dmuh.c',
   '../mips64/test_mips64r6_dmuhu.c',
   '../mips64/test_mips64r6_dmul.c',
-- 
2.55.0


