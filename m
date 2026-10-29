Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AC606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HIfzHsvC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G3EwvI3U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTtY-0008SB-Tj; Thu, 29 Oct 2026 13:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsu-0007e7-EU
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTss-0001Sb-3q
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDGCs542908
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pjucjWpk4bAajy4vzq8fJEqAv+3kNQiif8uyByYYQoA=; b=HIfzHsvCCh6CjqMF
 ENi2hnn0ADayXW3FcmHSPjFANnnBNnZmjWMK3A1CXSpMO0Nqvv4Ti8PTQawGDKRe
 0Dk4wVFAlvpVz4S3Gcq2yceYPp0V3eaz63US60G+IzR54wh+6Mu+8LGrRWC8FvM7
 Kjnz/c4BDbN/1/v5Q0gOYon0XoeWj4Dpaiue9NzUfG3o/uOpArlCdTgs3o8F3Ccu
 nHn0+x5qUZZAnBzZzf8y5WRtRYjwPLpr13rr2miq9rgzqqYnHCj53k1bEdvDNkfg
 5d2tRftqfUKd6ePEYE0T+bIgD6WoQbCTAznfQikPYNu7dqeuDX0YZUJI/QBBBXX9
 j2diIQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkxshuj11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:47 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eac1e41c2aso708109e0c.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294747; x=1793899547; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pjucjWpk4bAajy4vzq8fJEqAv+3kNQiif8uyByYYQoA=;
 b=G3EwvI3UcFEk5Qar2RZ2KiVVBNS6s0d7vXvdj2V8bmyFzubThHCMNQmKzsqEMH/ufv
 f5OdRHF4NhkWxUUiWdcujaUrQ3dNFYZU4AZykjz/uNEdm+rK3MPLlG0CXcA68efeLjLw
 nhf/uHJT1hRrbFWdV4wgmq3YhjAJjDxxJgDWkL7V+FFYMarh0MQlD9mU1yIM0uHTIRz6
 2cmOc2EPMh+4SW5V7tSRKV+mUxahfc3CmttOjtdwHsoRrJYmK3BUlvNrq3JbZ+RHwWao
 A8a1EjPWyfIukRtupaCIt7j+FK8//YPZWljQsy04zfK/lu/FZklF4GfFVQ/NWgrOK2iI
 m1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294747; x=1793899547;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pjucjWpk4bAajy4vzq8fJEqAv+3kNQiif8uyByYYQoA=;
 b=K+/sdz9ACQQffTuzVp/f5TvXjC7Rqz5ISaokvOHD9whavs1hOR6KT9FzUa5K0dq4M8
 fwx4UwP+LPGdu+sSy0xo6HGSRjpozuKxAuS9CcqG20WeJQNdVTWnswlqXsS9lrL559rF
 9wNKUc+tqfdfuvkNu9HKOhcjtdwkOMZoV5kzl5EAPMiK4kc+uoIas4EGIKGGQEGe/XgY
 dYzwbpwgq+Vx4+bKxXZeEK3DW9B99e/BWjF76yidZnXxcmBLVM5wgArqjUQR38SCgrJw
 3SD4mrnP/uyNLD8r1vgphvtSUmyyaZmgvsmcSk+2556oTeWkOJPFsJJiwPeL+m8Xlab3
 cD9A==
X-Gm-Message-State: AFq9FYLmNCgULGk/31wszfG3+0L7zhh8PwfhH1fEEHh2GLSQispxrGng
 pOcEu4D3Z48Q7esqCBxMgSWZ+fZdMvumYE5bdyXld8IxjbDMrO6ydI2Zh2evjI9bdHzKaga6Ai9
 imH9tbT635syE4SSZUcY2kOSTy5Yvc0UnqHc672PrKd1kG0Pg94cmy+L0kuzcj/mrT+gv
X-Gm-Gg: AYBFou2/19CsI7ue/2GxHMUCLdtMJV+CgvIHgr03INgZ4R7/R0dBB2j3Y2G3Hi9UbH6
 kWRTYejZMo2t9T+wcP0ErCvmeCKkI1g7n0nOp2D+u9EgAFTt+nBnuM5M6DqPfxbuL7BrcQJ18LV
 ymbkgoOib0N598HTy5gOZ6rmsC7pmJwrRAbpfHYHzMGsFPNzfbImhpYBim/A6ijEIChNH8vjSaw
 4/WpA8BLu9b08TVybJuJc0l+0czVsZK3yF9lo3pjR7cUzPFaqBga+jw2ZS84UOpR2GDhbTmqw7s
 kNqnOO++1Eg/RaUhwYp2tonyAn+PmS6juUDdjisK5TXO5gNjwje4dVUzqb2pAc5YdW1V/ChnZpQ
 GyKx7uPDyn0IEDs0RgoTytXggQKy/34py45Kx4XYogMapmnSartozVGmcM6s80SDAfqvgkbeNB1
 R/I272wtqFEyj2EWrhz5ONpes2yIOOkg==
X-Received: by 2002:a05:6102:2b9c:b0:7b5:4700:3a6a with SMTP id
 ada2fe7eead31-7d03a5bd56emr2778020137.26.1793294747196; 
 Thu, 29 Oct 2026 10:25:47 -0700 (PDT)
X-Received: by 2002:a05:6102:2b9c:b0:7b5:4700:3a6a with SMTP id
 ada2fe7eead31-7d03a5bd56emr2778006137.26.1793294746694; 
 Thu, 29 Oct 2026 10:25:46 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df960f8sm421861f8f.25.2026.10.29.10.25.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:25:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 20/31] tests/tcg/mips: Group MSA int-average tests
Date: Thu, 29 Oct 2026 18:23:04 +0100
Message-ID: <20261029172319.25766-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WrmOc_AE5zk6q8jU_8V8zGBRn0qGrD8A
X-Authority-Analysis: v=2.4 cv=H6BOUOYi c=1 sm=1 tr=0 ts=6ae3819b cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=znaDYlxXyk8I6BA2ZYkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX5eUq+k8uz6E1
 717mjqBRnJU8jOer337VFLQ6EKstWnr7/Shqx2kuk4akaubFv2Pl3cB2vItuAtWilIZ6EZxZ62x
 l7gIbtvBiCV3Vl2eRmzDzeLIYqxkmyc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXxCEKhjBQdx+L
 NES0I5cs1nZ8iMG8yFJ7G9L/UXrMZevPgiDUuwsnauO7kAnhkvfCx8IQqSpFJmhcy/TKtbZ7peH
 RK9UZ+MtuinVGIAAR+Pt+lh9J97OywQuoog4E+eZR72Os00rBkfi9FAkETlizKuJIKNzNNYJvdn
 qKALSJoK985ICy/vwlLp/O34ewn6jO4fuuHSfln6bs7ACWT6R6uqxs4yayJpISbmWCbYvnZTZXZ
 DXsGOgxZ5gmfLiU1gxwx0Cn3OuPeQudMsmPh9mN0uQ4S3P0BQxr3F5NO6hHiDO9TgphVSn4g9vZ
 dyYaLJRZ9Gnb3Z1dtOJafN+CLdhrHKvy3udg0dKVqglVZD8C204BgJv+QWXKHW4qZPz3co34HUn
 OzvKpGZ4a7j4JTknADwf59JQPWhZHg==
X-Proofpoint-ORIG-GUID: WrmOc_AE5zk6q8jU_8V8zGBRn0qGrD8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Build the 16 per-opcode int-average tests as a single executable,
test_msa_int_average.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_average.c | 127 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build            |  16 ----
 tests/tcg/mips64/meson.build          |   1 +
 tests/tcg/mipsel/meson.build          |   1 +
 4 files changed, 129 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_average.c

diff --git a/tests/tcg/mips/test_msa_int_average.c b/tests/tcg/mips/test_msa_int_average.c
new file mode 100644
index 000000000000..1e72986c3c53
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_average.c
@@ -0,0 +1,127 @@
+/*
+ * MIPS MSA tests: Int Average instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_ave_s_b
+#include "user/ase/msa/int-average/test_msa_ave_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_s_d
+#include "user/ase/msa/int-average/test_msa_ave_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_s_h
+#include "user/ase/msa/int-average/test_msa_ave_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_s_w
+#include "user/ase/msa/int-average/test_msa_ave_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_b
+#include "user/ase/msa/int-average/test_msa_ave_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_d
+#include "user/ase/msa/int-average/test_msa_ave_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_h
+#include "user/ase/msa/int-average/test_msa_ave_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_w
+#include "user/ase/msa/int-average/test_msa_ave_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_b
+#include "user/ase/msa/int-average/test_msa_aver_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_d
+#include "user/ase/msa/int-average/test_msa_aver_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_h
+#include "user/ase/msa/int-average/test_msa_aver_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_w
+#include "user/ase/msa/int-average/test_msa_aver_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_b
+#include "user/ase/msa/int-average/test_msa_aver_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_d
+#include "user/ase/msa/int-average/test_msa_aver_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_h
+#include "user/ase/msa/int-average/test_msa_aver_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_w
+#include "user/ase/msa/int-average/test_msa_aver_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "ave.s.b", test_msa_ave_s_b },
+    { "ave.s.d", test_msa_ave_s_d },
+    { "ave.s.h", test_msa_ave_s_h },
+    { "ave.s.w", test_msa_ave_s_w },
+    { "ave.u.b", test_msa_ave_u_b },
+    { "ave.u.d", test_msa_ave_u_d },
+    { "ave.u.h", test_msa_ave_u_h },
+    { "ave.u.w", test_msa_ave_u_w },
+    { "aver.s.b", test_msa_aver_s_b },
+    { "aver.s.d", test_msa_aver_s_d },
+    { "aver.s.h", test_msa_aver_s_h },
+    { "aver.s.w", test_msa_aver_s_w },
+    { "aver.u.b", test_msa_aver_u_b },
+    { "aver.u.d", test_msa_aver_u_d },
+    { "aver.u.h", test_msa_aver_u_h },
+    { "aver.u.w", test_msa_aver_u_w },
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
+               "Int Average", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 98bd391ee22b..be09044179c2 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -182,22 +182,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c',
   '../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c',
   '../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_s_b.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_s_b.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_u_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_s_h.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_u_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_s_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_u_h.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_s_d.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_u_h.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_u_b.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_s_d.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_s_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_u_d.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_u_d.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_u_b.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_s_h.c',
   '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c',
   '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c',
   '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 584b69812a54..c3d025452c4e 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -46,6 +46,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_fixed_multiply.c',
   '../mips/test_msa_float_max_min.c',
   '../mips/test_msa_int_add.c',
+  '../mips/test_msa_int_average.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 5140ada24cc0..7483b1aae7aa 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -47,6 +47,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_fixed_multiply.c',
   '../mips/test_msa_float_max_min.c',
   '../mips/test_msa_int_add.c',
+  '../mips/test_msa_int_average.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


