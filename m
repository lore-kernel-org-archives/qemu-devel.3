Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D24606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V+BceAy4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c0+iuGhk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTs6-0006gO-Dh; Thu, 29 Oct 2026 13:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTrx-0006Tg-O0
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTrw-00019r-2P
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD3gH1143412
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f0mX6HTTqBh8uUYEHlS3PN0/UzU1FWYKamwbrNN/oKo=; b=V+BceAy4m+F7bFq5
 6B3HDD3xwbgve7kLHujUJRMcJwvn3a0cOCvJidTrbc4u7mMAfNr412htMcw8MvZo
 KlF8/mHEZfud97nDgpYXjPbJZY+olAIG6JVsfa6RNEBmMojlF1FwXh4ej3j3L2e1
 zj7L8YlmjmZPmfsQXcRNbNHCsu7m0DHyobGvsEHzHpGAgr8Vg0T7Dit0VEux8/6I
 7HwLcnbtNYv6MWgvGqurHdc4HHITYFH/I5qPqxEISrX4J78CpaiICO1JgRP7izli
 usFUuUlsk71omj1uLhd65ZNI+0n3TcIk0Ru4lPYa9EuU4vST390VDVCaqZ0NXawe
 BKShEw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76chfsr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:51 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7bf08dc2fc8so524530137.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294691; x=1793899491; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f0mX6HTTqBh8uUYEHlS3PN0/UzU1FWYKamwbrNN/oKo=;
 b=c0+iuGhkXIqJTF4z3HQi5UIu5dToT/aHdc9cs66EVL1DJQGUabQw5194zVfos7LuK4
 D8XDjECqOllrorbYeaHLxQni+rZM3dI0T7vqy4MNJ0VBmQwdEmfCjoptHzismxelHasF
 vWWOKZURdCwQfIFyWqxQm4kuhGxffYz6U1REPzTvua/E1rwFdgr9wawIQy0eO/CMAKR4
 MWbqOvZo3yId01PGl/5suG1i6X38dtXhtPEFYe6LfYBe8rnXjy4gnXTpoPGJpiGUI7Zg
 6uxc6gjwuQRTB7nfUYWiuHJADq9W+Em+qwCBSUCZ9BZ6K7El+9hL06OPttJ8Ydg+ZfwM
 H2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294691; x=1793899491;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f0mX6HTTqBh8uUYEHlS3PN0/UzU1FWYKamwbrNN/oKo=;
 b=uqyI7OC2twv+34y7/tpymM2p7a9S9CSc55TPRuNzVkyS0Talog5l+ekBiQ0IZWVb9e
 ue4hb/TtmknosferWQxaKVslfNNBF5FdbvNj34exn9YQZViD99fLSWc0tp12pMA+Hk4V
 oUEH7+R8WKsje6HOptMHbJzo4XxdR8DRgbBQTt3iHASJk/XKdTj7k3FgVOF6gVPa/cZv
 iXgBEmG4p2hA0eal+jiD/Xb/qebGToBeKbVPHuuHPOkjsZQTNQovfApSsQuLbOJ7U/CI
 xlohjc84NZJotaMuiuZjGt+XGeXxCJJG1+z95UPbgpO/2uDhm5aD60VXEc2+Zln4Pgtf
 0ONA==
X-Gm-Message-State: AFq9FYK6nVsH5pyZuaF7t7pbNKUwqf59JC2iALKEdEVYHPbvExKVrXro
 dUbsjme6r376yOUeah5NxFxV1KK+VcXCSx9Q+tSG195QXxEWRmMUUeDeaLF1zTC9t4ahdTsXjEI
 9nMMnDhy8ysHoNS3CTgge1/OiDB82TQE53QJXULnVgye44nDC9aHkxroSnBUZeUqeqwYv
X-Gm-Gg: AYBFou3e1d0JGVGijmZVxpDYKln5oxn6j+lLpG65v+08waiH5b6beMbCPRNhvPMhbLk
 PkkAQ7G4ZbWhnuHDpZKMxUoUu+EV6R2/x7xfnAe46L5yyRoOLqgg1PsEACoY1TKbe6HJ1NiBCJv
 DJRC6X1UlccVAl1441C3a/u7Aew0ienEZR5+sbxjbKev5uYuqr96kFcwO6hiZkKomrof+Un06KA
 nyfatCQz2aiXa6iqJeZt0UF9yrmyX/0gXLhpiozlAO5ZRpfcycdx8tUp7edl2CVr289QMxTebkn
 /9X52BOJVNCkZRSRaIrfkT94GE7oB1dEAU8iCkkQt9GwDqo5v5p3IAfGk9vpA7BpR0YbfUcgcMA
 TSXWOXOc/bMty7y5RaQ4gmOerVcPpO7gmXH0daDyWRaeoH0782QWqJEEU2RkkGWO6/ZC6dOJ1ru
 G4x3Iijm86zrOtB1thAk3LBSTUpYbrLA==
X-Received: by 2002:a05:6102:3e8d:b0:7b7:3acf:bd3a with SMTP id
 ada2fe7eead31-7d03a293d81mr2942622137.4.1793294690537; 
 Thu, 29 Oct 2026 10:24:50 -0700 (PDT)
X-Received: by 2002:a05:6102:3e8d:b0:7b7:3acf:bd3a with SMTP id
 ada2fe7eead31-7d03a293d81mr2942608137.4.1793294689920; 
 Thu, 29 Oct 2026 10:24:49 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfa0872sm421245f8f.35.2026.10.29.10.24.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:24:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 12/31] tests/tcg/mips: Group Release 6 multiply tests
Date: Thu, 29 Oct 2026 18:22:56 +0100
Message-ID: <20261029172319.25766-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0L2DEpD-a1xUTFciG72JCbYXgaeBJd3c
X-Proofpoint-ORIG-GUID: 0L2DEpD-a1xUTFciG72JCbYXgaeBJd3c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXw+wKyGwI7o/T
 UvNqy9ZNpmfUtcmbSIdlz7kTzjVIa1QlABASzKY2BBrD3wCO2VvQjNgUHcIPEkfQYtdskTzTB0q
 9mnIaIOmxq28asuiFITo/o4VdpTrhGM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX5vqXfOSq1sFD
 YjZz5WpI3hgOMmfHceJ0Ve9x+fPC/1M4bOhT6i69Q1gCJe/NZnDgh89F6c782onzunFEvimtZJQ
 YM7lMQXn2KH+eeIY5ClnFs877+dIYtFmQ40v2mb51V/PDIcDkIN/QGNyFVIVpf9WncA1J72uytk
 jL7dc+6MJF0F7LTgOJNghSntsj2B9fgQ/ju5ZCwjyLIO6dWhji6TTNd1b0rn7xH3t9W8NnuAWmh
 8TLlUJK3gz5SGPv4TKOYx1eOQZCTb+TviZoEhCNWiItSB+DVEuRMplXelJ28xKA6lwfzEbEoUTY
 zJ2vroL+/dBooDhpn3j8K87mDguLqRiPMYBfdX6C/tc1PSjqIbF9UF99kyHeoJnQSKbhwHtDvzU
 p/kGCC6224eSzapIDjVKt7xGmJE2XQ==
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae38163 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=9r4Io4F8rcaVG8DJpGAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Build the 8 per-opcode multiply tests as a single executable,
test_mips64r6_multiply.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_multiply.c | 74 +++++++++++++++++++++++
 tests/tcg/mips64/meson.build              |  9 +--
 2 files changed, 75 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_multiply.c

diff --git a/tests/tcg/mips64/test_mips64r6_multiply.c b/tests/tcg/mips64/test_mips64r6_multiply.c
new file mode 100644
index 000000000000..8ee9d064da55
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_multiply.c
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: multiply */
+
+#define main test_mips64r6_mul
+#include "test_mips64r6_mul.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_muh
+#include "test_mips64r6_muh.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_mulu
+#include "test_mips64r6_mulu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_muhu
+#include "test_mips64r6_muhu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmul
+#include "test_mips64r6_dmul.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmuh
+#include "test_mips64r6_dmuh.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmulu
+#include "test_mips64r6_dmulu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmuhu
+#include "test_mips64r6_dmuhu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} r6_tests[] = {
+    { "mul", test_mips64r6_mul },
+    { "muh", test_mips64r6_muh },
+    { "mulu", test_mips64r6_mulu },
+    { "muhu", test_mips64r6_muhu },
+    { "dmul", test_mips64r6_dmul },
+    { "dmuh", test_mips64r6_dmuh },
+    { "dmulu", test_mips64r6_dmulu },
+    { "dmuhu", test_mips64r6_dmuhu },
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
+        printf("%s %u - MIPS64R6 multiply %s\n", r ? "not ok" : "ok", i + 1,
+               r6_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 657a1c4d5cc9..d356689e54bf 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -31,17 +31,10 @@ tests_mips64r6 = [
   '../mips64/test_mips64r6_bitops.c',
   '../mips64/test_mips64r6_crc.c',
   '../mips64/test_mips64r6_logic.c',
-  '../mips64/test_mips64r6_dmuh.c',
-  '../mips64/test_mips64r6_dmuhu.c',
-  '../mips64/test_mips64r6_dmul.c',
-  '../mips64/test_mips64r6_dmulu.c',
+  '../mips64/test_mips64r6_multiply.c',
   '../mips64/test_mips64r6_dsllv.c',
   '../mips64/test_mips64r6_dsrav.c',
   '../mips64/test_mips64r6_dsrlv.c',
-  '../mips64/test_mips64r6_muh.c',
-  '../mips64/test_mips64r6_muhu.c',
-  '../mips64/test_mips64r6_mul.c',
-  '../mips64/test_mips64r6_mulu.c',
   '../mips64/test_mips64r6_sllv.c',
   '../mips64/test_mips64r6_srav.c',
   '../mips64/test_mips64r6_srlv.c',
-- 
2.55.0


