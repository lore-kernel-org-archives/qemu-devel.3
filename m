Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D06606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HW2MCVs/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cXXGbWQw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqq6-0007c5-BL; Fri, 30 Oct 2026 13:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqpN-0006Dh-Iy
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:55:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqpM-0008El-0e
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:55:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERASS4102832
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xBo1o/3MTJzD5BhQYt4bn566lViAjeBZIdJjcWyJrBM=; b=HW2MCVs/1ktH3SRM
 No4Omh3cYMcinGTk5un8cGkiOpu7Fh/D4gN1yv6EhOCr6S0OGDu6kpEuvexWophO
 pOLqdiS5aect+m6LO0y4/KeCadwgzNigz0PG1GmGsQ/LiS6n/n01v427ygO3+XCn
 2KV3vhP6mOoucaXZYoUHC4ZquWatHximwTlABehtwr8reKowE3b8LbMTQTcTtA+T
 VmE7QDa+hUI9NrjWdIWaYtTwmNsNpa7EWxo95goNfS8DigO8Zbu3xpS1C8I53Hue
 Fdd8OkNuCXdGXXs+/cJC4XXWEA87FDM57ZItW/8fY/MN6m3sgBB6L1foLSbDocJD
 rMWmJQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmb3w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:55:42 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7d06f3784e2so233127137.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382942; x=1793987742; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xBo1o/3MTJzD5BhQYt4bn566lViAjeBZIdJjcWyJrBM=;
 b=cXXGbWQwWie3pZhslfdltp5AUD6kdAEokiMCbwrq3f8Ytd8kVIOzkTB1qXRwZHJ8ID
 YnmjvcyUeDvAuIPKSc1TQzzerRsN0DeUBDDIcNnNL+0iLsJuYBxJ/a5x+ob1oHJE1AXn
 DSB1n14wUMMSxDKHIyJPBo/jDUi2jkRg4Ly1+FUQKIijJyzEhl4P9umcGmyrksbw01PG
 Rd//Xmphi13zrAhiFZSCFKKH1BVMiq0H5RzWHj467m7Tfjyf3DOAJkcCAU1qdMbgC95t
 cwboxCF4HlIOLIrhIk3N0QFjx40jxMsLFbCuX83NW3iVHXc/6636aVuH7baSLAUKdeX4
 xhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382942; x=1793987742;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xBo1o/3MTJzD5BhQYt4bn566lViAjeBZIdJjcWyJrBM=;
 b=B2j6twM6Mb8dsT43Ya5am8N+BTvrn77H3QF6N2wx/e+Xh/Op7vT3Q2f0L5gYeHqEUo
 RVSJqIXv1RIyw3lCplDiYAzT3yn6aSYowMrAJEAeUwD70+cnhc4vgHyY1Mu3m2aFmaTA
 MtOfJH2HjWTZmAxt3BnthBIYKfyTOCloYbBgbFBKluEEFbi+GkHSFWHsiL+bj/RZo23k
 u0gCL4tMTFJXn8aMQiTdh37NwotFp51JjFDhtX+EUFkbmQFQ5wHBFaYy97ZBp2g/zOlI
 k0lGldmVI/WLiQEL8zZxVgLj+WsfZ3HaI8wJWEjXTv3X5FwAOVNWFniOTU7AdZu9LYJs
 bwEQ==
X-Gm-Message-State: AFq9FYIXjG3U+ixqBY5RgbFj3WdsZzlFMjuu/NiIdIvSgaSdYr3BZGw3
 yj1EVsV6y+5AU/uFbvhdFI5p7Nsl5/7oLrWe8jJB6tu34fdQGjwPbmgWO5RZUDYMi4jq9NU7CVK
 PE9hjNHy7Vm+5l2/cPA4SPIjSjUO7Tcdw7snyXyrAS6v1rBlgSoSi6ZEOURZQBWYZ4AS5
X-Gm-Gg: AYBFou3RmmXKNQ0h3xBSLDPYm9gS8QgWxkRz1rRSDZEmevnAhrrwP+QLg947cPe6wAN
 /eZO0fZV8sN701I8ZKNLNwrnqgoVweexHvsQycNne0dCfny45h1J+VMhDs2JHALHIA/nEs5bSsL
 YDxG4yigtMr/vGW4yBPzf0TXA2hzbOP59MblYiOe/mcJGgFGONzilj6/tS5ee2opEj+L4XYh584
 jSDPjvSnvqMj473FchGX1WUQV/U1BHO5aX+mQQrZOl7h/N/OJOvki+8EPuRXWe2R2YetLiIFTCF
 Qb1gHnNivLC5HPGJ4c19PmbU+mNvAjap5PUFY4b5zUNOsybwg9vyrmTPw9KDv/mXHRXrWQB49FG
 Vt+FpjNkeKv7I+/WmYUp+USSF6FXkVxSqTJYk27Dg0l2iNAG24dGllgPwyGUBTbUDyYNFrMFQA7
 y71GCAHNVDUutAaa9IDh/pObzL7HgvQg==
X-Received: by 2002:a05:6102:5712:b0:7c3:881f:b620 with SMTP id
 ada2fe7eead31-7d072c56c97mr1535977137.21.1793382942052; 
 Fri, 30 Oct 2026 10:55:42 -0700 (PDT)
X-Received: by 2002:a05:6102:5712:b0:7c3:881f:b620 with SMTP id
 ada2fe7eead31-7d072c56c97mr1535964137.21.1793382941593; 
 Fri, 30 Oct 2026 10:55:41 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b727c6sm4583046f8f.16.2026.10.30.10.55.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:55:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 12/32] tests/tcg/mips: Group Release 6 logic tests
Date: Fri, 30 Oct 2026 18:53:34 +0100
Message-ID: <20261030175357.99684-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXxQbxv+eEOmXn
 NC9czcSYxwqo6EAh21szRxRZE7qGDL19iFgksEWI4X9582tuEYNyCkyN6/fa3oyHv/QYri2Cb3/
 +x7xDrYb1EuBn/wZpQQfcZnsYaSr0h98/gkGTr4Js0Q5IIvIhx0R3pbBmXKp3SkGBzcV/70iuoo
 cRwvlvfJrueTQPIIUPB1uKvpePMvCeapNKZ3YaASUFKvUWa6EJjiC/66nQbjvXiw18VCFj3GZu1
 5qsuRTdYozeZDVFCDqsbVbV2OZLL0l4qxH/0ELqzSfh+M74vgAKP9o1GihOQyHCzd2ViY0JuuAx
 bcj40yBPNkG/WvE/Zfq5qKjQLQfjLLdA4vkrZRaQdy1CWUdA/V9IahOdvkr8T4mtF/+Sk9s9jBS
 i8X1w3ss++A9bZTDXfDoLffBlT5ErLWXM+gW06yyiml7+yzFXbpaZt1mRt71nkyTqzCG5mI2Ywo
 f3olxNdKyJgFZRcFmbA==
X-Proofpoint-ORIG-GUID: rHZ5C-SpExz531hEpin10BHoKtcaM9LN
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4da1e cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KuQ5aknWMmF4MApjBakA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXyByW84WJ7rYX
 Pu1uLTgPR+7NfzdU4dKiWHkyXmvkh5LN11pZ4acf+omaikUkB0liNrwyCGYGQ3AfLXkhKcutP0h
 U4n2I49DIm+bgX9+ms6+2oDGB3W6o+s=
X-Proofpoint-GUID: rHZ5C-SpExz531hEpin10BHoKtcaM9LN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
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

Build the 4 per-opcode logic tests as a single executable,
test_mips64r6_logic.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_logic.c | 48 ++++++++++++++++++++++++++
 tests/tcg/mips64/meson.build           |  5 +--
 2 files changed, 49 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_logic.c

diff --git a/tests/tcg/mips64/test_mips64r6_logic.c b/tests/tcg/mips64/test_mips64r6_logic.c
new file mode 100644
index 000000000000..063f2c254d78
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_logic.c
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: logical */
+
+#include "../include/tap.h"
+
+#define main test_mips64r6_and
+#include "test_mips64r6_and.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_nor
+#include "test_mips64r6_nor.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_or
+#include "test_mips64r6_or.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_xor
+#include "test_mips64r6_xor.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} r6_tests[] = {
+    { "and", test_mips64r6_and },
+    { "nor", test_mips64r6_nor },
+    { "or", test_mips64r6_or },
+    { "xor", test_mips64r6_xor },
+};
+
+int main(void)
+{
+    unsigned count = sizeof(r6_tests) / sizeof(r6_tests[0]);
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < count; i++) {
+        tap_report(!r6_tests[i].fn(), "MIPS64R6 logical %s",
+                   r6_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 0601ed52ab21..657a1c4d5cc9 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -30,7 +30,7 @@ tests = []
 tests_mips64r6 = [
   '../mips64/test_mips64r6_bitops.c',
   '../mips64/test_mips64r6_crc.c',
-  '../mips64/test_mips64r6_and.c',
+  '../mips64/test_mips64r6_logic.c',
   '../mips64/test_mips64r6_dmuh.c',
   '../mips64/test_mips64r6_dmuhu.c',
   '../mips64/test_mips64r6_dmul.c',
@@ -42,12 +42,9 @@ tests_mips64r6 = [
   '../mips64/test_mips64r6_muhu.c',
   '../mips64/test_mips64r6_mul.c',
   '../mips64/test_mips64r6_mulu.c',
-  '../mips64/test_mips64r6_nor.c',
-  '../mips64/test_mips64r6_or.c',
   '../mips64/test_mips64r6_sllv.c',
   '../mips64/test_mips64r6_srav.c',
   '../mips64/test_mips64r6_srlv.c',
-  '../mips64/test_mips64r6_xor.c',
 ]
 
 foreach src: tests_mips64r6
-- 
2.55.0


