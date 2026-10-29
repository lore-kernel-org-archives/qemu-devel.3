Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233DF606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PLaOdRNC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CTfqpyBG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTu1-0000pz-86; Thu, 29 Oct 2026 13:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTtF-0007xk-He
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTtC-0001Ub-QN
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD0hP535210
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J60ebmhTcHy5ZsQpbuegqqz/N6Bos2KMEVYJQr4TthU=; b=PLaOdRNC51wAvNSU
 7M5fz3MaoQks+vNW/DaJwC/X5NlAbFwzBojJf90utBW1QoK87MeymWcryv3SNAEM
 VBKiGolwPD97i8rr4DLKbj4dPPQShBI1NFLzG9LAR4CilNJ66g/+etUwbDBdoi4E
 QWdKwBZiSkDBgKE6vkJvlIxCmzZr8x6W7RAH7ObwL0W9ahiia8H7ScloBpPobqP2
 dXcrJybvNK+Arn9iMp8Wd75OmoVfp6X5D86rws5RZCQAvIWrZWeYej/940ua8/CK
 8A0U6wQiKrYtPN6NgGZl3qWpeyhZn1+FJGmo1KGJLJuEEOAaaSQkFmNOOQN8z9c4
 vA6apg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm8k4h1wh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:09 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91785bd637bso53743556d6.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294769; x=1793899569; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J60ebmhTcHy5ZsQpbuegqqz/N6Bos2KMEVYJQr4TthU=;
 b=CTfqpyBG62EoiKVBMOXO7tWIk9+MQ3CfmBR+Pm0jKRANQaoihg+VWkOIIZvnudBPSP
 IjKFoHVbID/DsUuggq60tsIoSkfRtcBbojRfBMlnjnwQuluhE7IqucgtSnYWGTTtCvSA
 Qi/2NnUu8Yew1oZ4u/RRhqIT1CO0/vzLHUc/CLwHBE2VabuRH9KQdleJJ4PUJ4myjyor
 uirX5szsDtAKQx1Fo/6KCPkfq1Xu/Gi9UBNYBSl8mNEwSYL1fF8krCpYG3oS5XVFmYJs
 ypteQBf7Xt9hh1HxBDuR7wXrZnj2MBkNb+oSbUzb+/JrW2JsCeYRzxTvknyLTycx09LZ
 Zi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294769; x=1793899569;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J60ebmhTcHy5ZsQpbuegqqz/N6Bos2KMEVYJQr4TthU=;
 b=OsoZ4R2lVyZWWCsXptZziRcL/p6b3vjV+koGZvCGqUqq3aMyV3geuAr8Qk/NGQjQ57
 xIO7/W7gDuXTFslXRKyCH5wLUSXjutATc75wiBkzLRwdu4F0fcKuQxRPXLEpb6jILrpJ
 civbx22zcwScqBrmbIyPJZRrXduHlMUofua4FsgRH9hVTvyAahaxvTfMW0/1eqhRCPar
 2mit/X8b4dGRIabup6QRETeT0KoHmppl8/h60ObsagbajLbGXCe6Y0E/KK8MwIQyX1iW
 /3XCb/lPgbx0W9h0KTqak8jsrWBGjYT7WYzg6t/2txH4XhGFKYYb5H8nTgbbAal22oun
 dTIA==
X-Gm-Message-State: AFq9FYLUyteV1AfIwIKXQWOa4CUncuDiBswmHXD5u8FbmKYjDzWFbXFK
 SIUO19p7KFQ+jQ3hwmcPCqnhk9JZW4fhGKGXclVsoA79M99ATmLU8EGIRvoH2mzdpg5w/TvslZw
 Ef1yhg02ipziWJ026SnaKJX4iAK83OGchjON3xA4VtAgD2EmYLfusl4FSb3f57jmkTBn+
X-Gm-Gg: AYBFou0/3n9xyTAQEiITFHYGCM8ECI4Wzg0hJK85mibxNexa4P9xOBCcThj5AsjZmUb
 CqgaMaNCjYO2nxXFojCWQkDcrdt3GyB3k87otwUE3QI5WA6KfXssHBj2zfxo62o6zY83tk6arGx
 ViDhTaqXa/5n+ExB+AutJXILfPmkstG3+0uf2Buwu1AZU7TJl3HPIt+Oli7NL9JGr3FJXZjVB2i
 Qf+Eg9+GsqtfmGBM4yGIzkyN5uG8qnziFBldJ5RarsAbjUQYg5mVD/LwDTvn8YYTCcRRQdu9mEV
 uX8t8wM1s+NMrutwUbFrQXi7V7P50I4N/DZEF+ao3Qqj3OoTXIGrXYhVCglWELV81JsO25AD3HL
 WPg+zWlL3FdYYhFs3ogk7f7QbvwIdWJRo+ejtHa2PLsUf1WhMbn86qODeuhHYHp/wqJypvmm/FD
 VoWBnjzLtsstexkrB6vcnr3+J/Y/JQRg==
X-Received: by 2002:a05:620a:390b:b0:93e:4d60:d389 with SMTP id
 af79cd13be357-94408a7f8a3mr994434285a.25.1793294769084; 
 Thu, 29 Oct 2026 10:26:09 -0700 (PDT)
X-Received: by 2002:a05:620a:390b:b0:93e:4d60:d389 with SMTP id
 af79cd13be357-94408a7f8a3mr994430985a.25.1793294768615; 
 Thu, 29 Oct 2026 10:26:08 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe885d91esm2152595e9.0.2026.10.29.10.26.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:26:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 23/31] tests/tcg/mips: Group MSA int-dot-product tests
Date: Thu, 29 Oct 2026 18:23:07 +0100
Message-ID: <20261029172319.25766-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX9lrZ4drIS4fT
 P5u4EUFz0qd7aVq5M7UP3st8AzNFm53LMRYlbOXI3tTAYdhyT5GrztthkzKXvVFjWbwBwqZ1c+p
 zd5fmmR3r6MMu06SkA4oTywU4debF+FlqnM0ATEuiDwKolwc08nJxUOMnxp2DqUuDrxGACpOE3i
 dZClIC0UsZ+l5cxcQIU4KMCKksSfmFsKHy/i4fuoSeySDdvkVNjXoxG7s+r82lpFsrTJreDu4VK
 D0mBtEnEvXgT6rTRWE1bYblw7/U6UVVAv6duI9AmxIvpd+m8EmeVbkHuRGsU1t347zSJXIWA19B
 MW15dweQmZfcSFs2GQx/PENjLAbIn/4fTT2nISopSbUf5GmPwDmy7TkXZK7TTtknQkBL7WuNtWR
 YAxkerv9Q2q0pVYBEsoSQZHDH2G3jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXw2reFblAVsI+
 92rUz99AxFJQ9Haq42o4zcg8UznqTu5xHCyRgs6ipf3EuwP7mDhFshjqwdyePNH4/nrLN/0u4vS
 I/0PGc2GQFTHZdRC7YZPTt6GYXJs44E=
X-Authority-Analysis: v=2.4 cv=LuAHWXdc c=1 sm=1 tr=0 ts=6ae381b1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=agCbhU3l45mO4j1jyEYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: Iqg5w40ydPdyIcRohObohuWURMTUyRn-
X-Proofpoint-ORIG-GUID: Iqg5w40ydPdyIcRohObohuWURMTUyRn-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Build the 18 per-opcode int-dot-product tests as a single executable,
test_msa_int_dot_product.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_dot_product.c | 139 ++++++++++++++++++++++
 tests/tcg/mips/meson.build                |  18 ---
 tests/tcg/mips64/meson.build              |   1 +
 tests/tcg/mipsel/meson.build              |   1 +
 4 files changed, 141 insertions(+), 18 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_dot_product.c

diff --git a/tests/tcg/mips/test_msa_int_dot_product.c b/tests/tcg/mips/test_msa_int_dot_product.c
new file mode 100644
index 000000000000..004fa5f8849c
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_dot_product.c
@@ -0,0 +1,139 @@
+/*
+ * MIPS MSA tests: Int Dot Product instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_dotp_s_d
+#include "user/ase/msa/int-dot-product/test_msa_dotp_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_s_h
+#include "user/ase/msa/int-dot-product/test_msa_dotp_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_s_w
+#include "user/ase/msa/int-dot-product/test_msa_dotp_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_u_d
+#include "user/ase/msa/int-dot-product/test_msa_dotp_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_u_h
+#include "user/ase/msa/int-dot-product/test_msa_dotp_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_u_w
+#include "user/ase/msa/int-dot-product/test_msa_dotp_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_s_d
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_s_h
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_s_w
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_u_d
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_u_h
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_u_w
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_s_d
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_s_h
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_s_w
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_u_d
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_u_h
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_u_w
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "dotp.s.d", test_msa_dotp_s_d },
+    { "dotp.s.h", test_msa_dotp_s_h },
+    { "dotp.s.w", test_msa_dotp_s_w },
+    { "dotp.u.d", test_msa_dotp_u_d },
+    { "dotp.u.h", test_msa_dotp_u_h },
+    { "dotp.u.w", test_msa_dotp_u_w },
+    { "dpadd.s.d", test_msa_dpadd_s_d },
+    { "dpadd.s.h", test_msa_dpadd_s_h },
+    { "dpadd.s.w", test_msa_dpadd_s_w },
+    { "dpadd.u.d", test_msa_dpadd_u_d },
+    { "dpadd.u.h", test_msa_dpadd_u_h },
+    { "dpadd.u.w", test_msa_dpadd_u_w },
+    { "dpsub.s.d", test_msa_dpsub_s_d },
+    { "dpsub.s.h", test_msa_dpsub_s_h },
+    { "dpsub.s.w", test_msa_dpsub_s_w },
+    { "dpsub.u.d", test_msa_dpsub_u_d },
+    { "dpsub.u.h", test_msa_dpsub_u_h },
+    { "dpsub.u.w", test_msa_dpsub_u_w },
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
+               "Int Dot Product", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 9c4304d49ae2..fade579a822c 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -146,22 +146,4 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c',
   '../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c',
   '../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c',
 ]
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 442fdf0981e1..b7daa9d0f014 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -49,6 +49,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_average.c',
   '../mips/test_msa_int_compare.c',
   '../mips/test_msa_int_div_mod.c',
+  '../mips/test_msa_int_dot_product.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 5435ba39b602..7a0026075567 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -50,6 +50,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_average.c',
   '../mips/test_msa_int_compare.c',
   '../mips/test_msa_int_div_mod.c',
+  '../mips/test_msa_int_dot_product.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


