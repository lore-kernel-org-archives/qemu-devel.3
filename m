Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ABC606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nWXeGpA5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QKH+S5Q4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo8q-0000pD-5H; Fri, 30 Oct 2026 11:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8n-0000kF-Pa
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8l-0007CU-Vs
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERASf3515380
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YyKKmaUgyc3XUXqP9qbvza1eK819yaAt4RhY9LOCstI=; b=nWXeGpA5WoBMOAEy
 wojZ50JJ6EAjttvC7/OZC8qrPKZ4fB3BbT3gLOqdEPXH7k4nmVpz8sNRqAZCQjit
 glqEXVKrD0Te1DBF5D3ts7jd4NDC7iZBGDqPNtroPUAI1Pz2zU/9v1+05Q6LkZqU
 eD/Dc9TG2N4KJLyNjp+AB3mGTA1M3/VtfvfZIRVCQYggFhHzkDutZ49hv71QCavg
 za5Qs9WYfXKDvSe2zHpPT9/po43aTDUGZQJ0AkG3jxiUhlxl99ViP7U2pScpHkC4
 W6cXX8w56r661YgemjXcfTGv4e2SWwBtLQq1cR41OoyhUjzKLOMi59TReWv1sPaM
 inLZmA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkp92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:34 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9913f410ba2so180136241.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372613; x=1793977413; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YyKKmaUgyc3XUXqP9qbvza1eK819yaAt4RhY9LOCstI=;
 b=QKH+S5Q43XLKgqBRom/S2I8hQTPHEfrCa+/BJuN5e0mRSaY3NYxv9IvG/rZmR70Svl
 b/ICZtlR+uzD/ZmV2ytWbBf8HrPTKuMzMOgfLOdz2X3fu6MWK7T/3Bn0JerQkD0UrVmK
 f2ZDK1ktBQ5/4MJ6QkuqeocBywzLmhBoE3CVB9rTRqIioEtVKw9HjLa+wiCP4VVp25sz
 YG7TZjYjwUKjZ25+tCZtwGQrnouTZEtmB7TUbumJTiSk4hC8mRyDJH5q58Fe9g/JzHts
 QkUWEJABWEx0qJq96Uodd9aHVL+SMibHAqZKjd+yrQo+xtamAOyQ7Hua9GuWLKKRynYW
 QQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372613; x=1793977413;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YyKKmaUgyc3XUXqP9qbvza1eK819yaAt4RhY9LOCstI=;
 b=SsQc3YtfUM1Yd/QAXm1glmAF++urZH7qgxiaYgiB5PzczFjAQFEo3Z+N43IEqXp4tL
 M5cL7rP5BjtCijqXVZCVO6nNGEKKrDetW7o1erjXIO6O3ZbNAahoyft03b9HTTNuDkVm
 I3/MxyevIqsvWAnLDobn07VsD81+FcANAw8b7ZeTxHUPMZlal2MgTHIdBebIqMt7Qqqj
 nPKNjFEFkhqvI+YNJ3nMnTETgXgdB+svaZDoPbj27OIqoroTxNibUbU29SPViNqAKa7k
 M8NXymwAfUcGinN87DXottSrYg5JYfRFyus15bEwywkPoN1wVqldTuQD0cQZC2JWAfoS
 7Epw==
X-Gm-Message-State: AFq9FYIm3Q/Um7vV1RIQEKf5hHuAGvPbQG0qvo0omCcwn7UmFprbe7/c
 FVaQHHFaPht+zhQsc+rBMBoIyfoyCSnEPLTlnyRJSKcoVRro+aGBGd7l79TSYO9Y34CVBY8LkG4
 ymEx3DpWYFMYgRQevLjAc/kS9TACoYQ+re8HyYXZ4vsAFl4ugT5caS3El0LkhzCkp8wdU
X-Gm-Gg: AYBFou1/GjIsPhqu/Fo1WC168cxNC6iJIcgtzW+jrgqKNOpZOjdwQMpTY7hlX5S2u5F
 t8STftGbnmX3xst5UQodQnAco/jmetNqWkiexbJ5KS/HrJiGpl6buKlaPfByYBGHpWeVD+NBO/V
 plHXn7JjkhJZVrK38LXA5WUF5UjOm71iVWJn0LFpVlf9vF/Adc8o/tfHF5808xR3DYaamr3xxdH
 qbCHHAzKsejLFDluVGo1EUnpqiFjBH2svP6VCwJWG9UmrrSEbfmVOKVbKJcx/92St/rCisWIlWM
 xJc8ewu7wxeFuv6V9YUEuycp7T2/SDguRYNPbHOv/++6rQPWTTkQqGuYwocmlokyCrOclf5XJrh
 g9wx90Z1XahWh8XZI241URa/jPxydW8Yv2bNuCbZlrA0E9w87h9L7PhfGeGitlesda1FmZQqHQR
 LXNBtkrQdSfuwRs3vys2bg4uDurYc6eQ==
X-Received: by 2002:a05:6122:4b8a:b0:5ec:4112:6839 with SMTP id
 71dfb90a1353d-5ec6894a356mr1307275e0c.15.1793372613196; 
 Fri, 30 Oct 2026 08:03:33 -0700 (PDT)
X-Received: by 2002:a05:6122:4b8a:b0:5ec:4112:6839 with SMTP id
 71dfb90a1353d-5ec6894a356mr1307202e0c.15.1793372611075; 
 Fri, 30 Oct 2026 08:03:31 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8011csm4193821f8f.31.2026.10.30.08.03.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:03:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/31] tests/tcg/mips: Group Release 6 crc tests
Date: Fri, 30 Oct 2026 16:01:40 +0100
Message-ID: <20261030150202.61556-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: C_UcVZbnuxirfVIqXTpBo2rBNCLW3EPu
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4b1c6 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=mgfkhx_GbAYBFjwR9pIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX9aruuj/rYvk9
 4LrL6iRKEJVFt8HnjcCdbMU2kBXelztv092NqtFAEKoC9/DNMOQx8XTMmu3Jh3Wvk4GLW4SVxzw
 Zx100xtdwgX1vUhtSxo+X3LmMjBqdq6nxQKaLDw2uj9n12IeJivLB+OHZBS04y61B/eDMtx+zHA
 N1hz2qEvrgCYGOfHIWjh+Y0EGon0Cp6+x7oWwjOMMWo/EawijTROvVvRU/mUopY4ZT9fn3oT0B4
 fJTuSSLiJrgtQ3aljAgJZtRhP6qCeHHSEMKncShkO7ZCzoKFXYZ9/piNyhnFA1jY6XWjRpRKoBE
 DsJok6t85xXuFvTPfj+0IncvZa4uAadJRYObNf/P7m1KBYjlkr1VmdasypMrJe0ujZnKNnQbpon
 XyVdOAjpQX9cDC4IVigK0m7xwQt2InTfQaW/ZW+XryHLRSpm9m8J40B39/n5gCUevcxIQflwubB
 RLPJJCtfVgoUA9LxEKQ==
X-Proofpoint-ORIG-GUID: C_UcVZbnuxirfVIqXTpBo2rBNCLW3EPu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX2f/rJK0JZ8CM
 uoxsGOUVSm8H66KaT4LWT0cifPqZuh8LuHvNDTxFQApBR+dVz6KIaaGU09ciI1OQfQYavISGISZ
 fPsjkcQsNFevsJsVsYp9x1e28VeJJ2s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300059
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


