Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF4606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nEs1oH3x;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TM7TSrQW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTru-0006OA-Up; Thu, 29 Oct 2026 13:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTrj-0006Ha-OD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTrg-000188-8S
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDadW3689727
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 737taqbSU6cixnUtGd0l1N1iEMnwUgvaTyh/+CYFk50=; b=nEs1oH3xFXOev9nO
 K8nrsVvn4VeD+S9i9b741+p61jMYBFs2a6OIJbqgPK/HdCBZL6mZJGCbhWNJ1aMC
 MyXWD9Kr3Q0LP2B57xAcxOmjoI9O2BEOBl6I8LSCdbqE97+zc/rS/6+SuA/6yRlp
 uegYlogM8/gWM3Dc7ARSOOMS4I5jYtklJ2MOJ2z01s2/a5LYQ3AJfkgmor4rUd44
 +gG37KZlEWdkYDZNcWKCOvpNz4HpZTZOimTGLP+/XhOZsuogSEUUTd40W6yfK7QQ
 tr3daqgv9VvWqGSPqrPn3bckrs+KMXlADP9b6pThoWcLIhjLyn70Shx8bMNTqThb
 GO3oYw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5sb7f5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:35 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-99064f8c7efso1519285241.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294675; x=1793899475; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=737taqbSU6cixnUtGd0l1N1iEMnwUgvaTyh/+CYFk50=;
 b=TM7TSrQWqv7bQZ/GovC/4nNNSCqeqzTx0DZ1gIpsIWYo65JB9AC6S9XSKAauZThyHF
 aoA3Z1z5DznQbeb6U3nPcQPv297ZYnhKMWsXZusUTh7P6jZdtDkq45BgGKcfK6Y0I2Q5
 FfqM1m3P8cG4jy4XYNmOH/hQoAdefM5ncBYx/KMOM2kK3FS66njcjGH4bS8F70lMf7ky
 sCQoffp4WSjmSmeawo2qiCVlExkIy7cy0WqZSkxdBJj+4qB2a6+tJRkqp5Spd+m1W9N2
 BWFBfX2B/dy9uXzrbeo1u1yRHuqqT/Zy6InZn6MTQWxU+P1DHB/mAlccI4ZN2IaG+imJ
 v0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294675; x=1793899475;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=737taqbSU6cixnUtGd0l1N1iEMnwUgvaTyh/+CYFk50=;
 b=P1kdnONhv+fUAEWY4+VF0umjnmupdb6F3VoGlv19TBdnReq+E//ZsiJc00SM6QZw8c
 1/XlTxGGFSnWN5dkpI7PHojLShlewHY9affWysmQraz/bc7gy9eg6LZdEaA+vMpOxSXf
 i/yjxBUGXtmCzUqq2CDHB+lIL6lx1COhWK3sUQUvDwM5yJmM5a66V82xsYbjrraLnqms
 xsgPOqF26c4AaMMqX1H8eh8BViLtFKqkgw2/zQgVWDnNGY2nKKVFn4x9MqK8kqYRN/xE
 7cYkGFg/lxRFDHZpfLY3Y2nVy0R5WzzSv3Jzgxg4VYVCJBKShFow9evZvmbkoh4wWD4v
 NXrA==
X-Gm-Message-State: AFq9FYI1MzWVTDBexrHdSMveDovsYHKFsS/4yU7sZ0Qteb/KDy+uw/Xf
 1z7Ih9vdmV33obG4KGk4VOlwHE4Je+cKxH+93muak5K2LKI/B+9p+orGxp/hFM/ceTULc+YJOIb
 UFIelO7OQA3efXbTM9eQrgPpX5736oUFAn5L6CWdJKz/1cabA7KIzKTM7YL65YdoynmVg
X-Gm-Gg: AYBFou2ox41884cPuty+64WhJBLX0HXi+wA6h40xI2TPHfpsoPa3qxJY6C23LJDiqxq
 a3g072zs6tuMRNaI0SZuvxEsG6J7PierfY3iPp76WcNwpEDdFTs7+T/OpB/pClf4ZsUP8t5gitX
 yoaEnIb37u2HV6ShFZS6sz9bMOrDWYE2Bb3ZMXUMRlV37blUEzp+rUykzuzLT4UzqxSecSW3c1K
 b1VWIJ69UQdWxR3+IBcvgTkF7+0SDCfiaqbwMfhQwPBjPnYIozSWl1l+FE2sD7m745R3ZGtcAJg
 dmxgFAh47lvvXsEDfPdFswMr0liXoRvSsydtM67gT4IoHIwzlmakkN1HdKOurbNvew3Gi6pe7gA
 i7NC7ALwVjTDW3s1ZpOd9vhCt1bH1vCaxUz0kD8FTlz5LM91PkFT6pr5jQLrF10xcgw/+8r3Wy8
 Aze3lpnTOu1XHlChE3LRbz/xtxFqUxXg==
X-Received: by 2002:a05:6102:83d9:b0:7cc:26a8:e726 with SMTP id
 ada2fe7eead31-7d03a5b58b2mr2813665137.26.1793294674925; 
 Thu, 29 Oct 2026 10:24:34 -0700 (PDT)
X-Received: by 2002:a05:6102:83d9:b0:7cc:26a8:e726 with SMTP id
 ada2fe7eead31-7d03a5b58b2mr2813646137.26.1793294674426; 
 Thu, 29 Oct 2026 10:24:34 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfaa4ccsm404075f8f.39.2026.10.29.10.24.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:24:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 10/31] tests/tcg/mips: Group Release 6 crc tests
Date: Thu, 29 Oct 2026 18:22:54 +0100
Message-ID: <20261029172319.25766-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX6NpDWV+j2eyp
 mVTNIlVEDZ9PoWIiZ2pQDIaLqKGZR9RByjah8/IBN9ApiLtV9UYOk749tq4GO2oMavDMwYDx4EW
 O0dmMlGOSWZiPvHIEiA3DzNq5TVPUBo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX7NRm/YcSUl8Z
 H1I2zWpoxrUbSOk0gVr+xFcxoeUWFlC+sTQAcLCblrrJB3SNB20X6qLMdIpiYWCKcGxGT/5EBMl
 C42BO7RLjyac2HlEDGzCn55/VRzhED6OUpDWr8KF6fTGrz0wISRFllhSi2bggTsGQkn9RG6b7AG
 lIoLL/LRRX/FD/XdnYyw3DPDMW8VOjf8DsrpFyfNGpMjs21WmIdMRLI+YGjPeEptwyfOrCkf88A
 kfqLn9A5uZ/5pW7vpnJ8Yuqe2xkNOr5lJGB5jOOkdpVxvDWopoBUes/cBb4K2pI6+XfQJSmXHag
 Fh39I9Jibng1eYslI5m/8AJPnDRjcXuAU3FXkW2GQHSTEM5DaL6H8HKeXN7lHhLww6NoYw9yHgd
 sVcG7MTSaHwwKCk6x1noBWeWkrB6ig==
X-Proofpoint-ORIG-GUID: cizjEnG1ghl1-J9UXTJMsOm7rNvEjccv
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae38153 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=-pu2kDSRp-wWEHhDktMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: cizjEnG1ghl1-J9UXTJMsOm7rNvEjccv
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

Build the 8 per-opcode crc tests as a single executable,
test_mips64r6_crc.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_crc.c | 74 ++++++++++++++++++++++++++++
 tests/tcg/mips64/meson.build         |  9 +---
 2 files changed, 75 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_crc.c

diff --git a/tests/tcg/mips64/test_mips64r6_crc.c b/tests/tcg/mips64/test_mips64r6_crc.c
new file mode 100644
index 000000000000..24769176a1c4
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_crc.c
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: CRC32 */
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
+    int fail = 0;
+    unsigned i;
+
+    printf("TAP version 14\n1..%u\n", count);
+    for (i = 0; i < count; i++) {
+        int r = r6_tests[i].fn();
+
+        printf("%s %u - MIPS64R6 CRC32 %s\n", r ? "not ok" : "ok", i + 1,
+               r6_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
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


