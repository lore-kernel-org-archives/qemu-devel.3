Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E774C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l5O7bOGW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E1S3MNUQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo8l-0000ZD-8Q; Fri, 30 Oct 2026 11:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8f-00009F-4l
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8d-0007Bh-1z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:28 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERDUo4141541
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3EGqTn0/oI1pqHGrcg21L9ZxHJGTKASOnJYyCIL593Y=; b=l5O7bOGWPkUz9Jsi
 Y6j1m+kzwi4HZCPLn5YH1HfFNZQArq3+91LeUEeTqVwyWdcPoFWOV7VYpBaGhazk
 0LxN+gb/7rft/y1CxCYOAXIZ3y/8X97z4FAXb5+JE56lSpx0++rSqneGg63vrbuB
 2O6HtZXQkrY/0ByW1ts6Kt14pMcFi9h6vm7U9KdzD+rj9bZ3Tv5PvY5osqUcvi4E
 Hz5G5dIjMDd3EYmqbcIbmq3Ek8c3tviuNoxh3WcvfnaTYF2zzaIZXve98yZUnHSX
 yIcr8Bl5e51i2RH57MVeeRw85mqgR06k7jW0D5vtdCKEFsjnuZ16Arebjvkpjlag
 jRO0Gg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qukk6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:25 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98e3ad6dbb5so176756241.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372605; x=1793977405; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3EGqTn0/oI1pqHGrcg21L9ZxHJGTKASOnJYyCIL593Y=;
 b=E1S3MNUQGgxl6d9Qd+MRAbZhdlstHvlvtO9wTpmm5qIdb/NCFS28K1zmvJxPVOJD/S
 IKtADrLLTiPd1kY0I3EUDOKcQTHNM3VxkTWbOireGhhFDyEkVRkz6B4iItCsygNXbYFI
 xzx79DwkU2vTQzcGz0O12h2dzhstmM7U7Cl0fGRI4e/Vj9zddrvSiIceN/9OXQwyujVK
 7/13ZyrtsP+6xVy97GZPAUJQQnGaWOBExykYCpkrSqSGDml2pOUVgIac6oyIcEs3b5Gx
 /WeZit+6LS9cirAt1CcVJqhsXTXVeN3INbarwI4c4JFFIZKrIVmyT1S2GvWKAGVycwB/
 ztaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372605; x=1793977405;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3EGqTn0/oI1pqHGrcg21L9ZxHJGTKASOnJYyCIL593Y=;
 b=moXpujtqsaUAqVgRXXk0QdKrFQduaEfSucVBRI7MUdyCMj3lCUHaPcmxBw7kn126sB
 2wxi/HjvF5dv/jKcjpIdGcmpFasOlRWK/+nf1tiv/gaDRJag9SfGbdoKRY2n33QZZrPh
 bginGo4QEAUqmyQMFOQbZJL6UbVHP8+GHFtkDljzCa2QhMpbJ+fNY8s9irA4HKX/2tHx
 6t9DGTYchFyTjdUe6XLQ2CsjJtrp9kJ47uvcV3TZ9BwOErDCAuh2uOuUlRbnpj+FrwEO
 ng22EqJgzLFD7kj+iopNmqTQ1UB6V9ctm4sL6g92LJbHi1XSjzYf7TsTwJhKBJbCEszR
 zdow==
X-Gm-Message-State: AFq9FYJKRfrmNAapQBQ2vy7upNeiQSo9D552/AjpNQsEy/EcduIJwIwG
 B8cuZsVYkEEKfdlNIGrGWbLn0Qt7YhMfhQ8HYQf+3iuXlFl3PusZrNhTOikg2/w4ODx7tfx1MNz
 pyoeDxLWB8CIRErwUmHSX7oCnM3C3qXQLmqZHcSjb43hVDsa9yMxZ9vyd4Jbu5w/qQmZE
X-Gm-Gg: AYBFou0cy+uKr9Oqyxm2S9SUyhRizeb36VaOc6wSHJxi8XF5nqE8ZBhgVcGl61k4otM
 OJ27ggW5e1E+OhL19pbBRfxL5njf3cmG3eDVSitdpJ7AIMngWj2eprE2TBKc0M6OwV4Wcdobs5J
 jwaxXFEHTjtxZ9w4Snde1OKkynLtaTfSt6/c/ozoamrP3wM7mDQayNNt8938su+j8u6hq2dchWj
 58n8Na+nw5oVFMwA+z5mNu0wxCL0UozbDHfJuGQ32UtKP9PC6UtlZBbhnsjsGBQeg08yvUkWW3D
 4gW4xmOeVSF+ARTuXkJGrXtirD4w509y/FMiRSBfcSHcf6pBmVJZRkviP8nIrh+fK3qFMQLxqt2
 RaG50GMwhzZxrSsGy/AmEuh3loMtUdLh/GXndffQApCwoxhPYXQw+H0dsYIElCZC8aV95Nm3BHv
 vTutiBytO4GYY+O6QzdmkdTf3fAnzPQw==
X-Received: by 2002:a05:6102:c48:b0:7b3:7653:5487 with SMTP id
 ada2fe7eead31-7d0727a7372mr1162472137.32.1793372604035; 
 Fri, 30 Oct 2026 08:03:24 -0700 (PDT)
X-Received: by 2002:a05:6102:c48:b0:7b3:7653:5487 with SMTP id
 ada2fe7eead31-7d0727a7372mr1162430137.32.1793372603293; 
 Fri, 30 Oct 2026 08:03:23 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac081d1944sm39370225e9.2.2026.10.30.08.03.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:03:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/31] tests/tcg/mips: Group Release 6 bitops tests
Date: Fri, 30 Oct 2026 16:01:39 +0100
Message-ID: <20261030150202.61556-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hTkPPBs7i0gzA8Du4lR7Bwpun215k3qS
X-Proofpoint-ORIG-GUID: hTkPPBs7i0gzA8Du4lR7Bwpun215k3qS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXyQdrfPEKU1rw
 Ci/ObdaQGH7g2733JGSFCUY+ffsynHXC+J4mvzSI8vXKPx9yOPrWd+xdHnbOglxmDVbgpGdZFQY
 DiTCdrAI+DANxJYF2WYV5c68PDDACDLsjiIM6u6nLHocy86ffCe074j5lqppU3YZK1QqQeFsr4L
 eemVQ6wX54FpP9HNZ2ziXzRUmNSA9w/uUhE1wVHEuBd5V0ihW3zAoOzzKAt4T/lsNJavoADcR+o
 fOFIhTozXJ0K1UFlLunF9WfXFUiNipW82guyfTWAJw7qk6cGplh12W9uAoGhlxSKvaUDRK7klDq
 tXqPGOKrsHrsz+lJjcBLvYY26foZJt5rZPIGqHdTjvuATbunIF5MMn7BUn9dxfrYVpdG+k15Dx5
 NH+7ArX446AqPcmzpw1SH9mPc7CnWxzj+CLQxHu6sZHa4vaQb2Nr/o5eYKxw/yt8eQSjh9xKxmS
 ZinYhc2FZoNj5TMlNVw==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4b1bd cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=3BM3qnCwOLCbP_TLtZAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX9XR3HocD7+jG
 LJetPyGlrlL10J9m3FPZNgCYsu0Q3uaZIgX+S2zmIKf+Vf4bVNihjZ+yIdlcZcKpEa/tumlft/2
 hl/ip8MBq+BTZ9jm3sXF4eqJdpk5Yik=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300059
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

Build the 6 per-opcode bitops tests as a single executable,
test_mips64r6_bitops.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Prefix the per-case output of test_utils_64.h with '# ' so TAP
parsers treat it as a comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/include/test_utils_64.h  |  6 +--
 tests/tcg/mips64/test_mips64r6_bitops.c | 60 +++++++++++++++++++++++++
 tests/tcg/mips64/meson.build            |  7 +--
 3 files changed, 64 insertions(+), 9 deletions(-)
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


