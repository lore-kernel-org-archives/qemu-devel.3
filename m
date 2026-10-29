Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF336606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LNZCYl4Y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zt9Dj1Th
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTr0-0005aR-7x; Thu, 29 Oct 2026 13:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTqw-0005XK-2Q
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:23:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTqt-00012O-NN
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:23:49 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDWdg3234206
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +p/2mSGlCHHYQ1GvfhyzgeWHrR6DS7SNrdse+KalGjA=; b=LNZCYl4YwMSCSOfE
 5QcHWZmPwLRDb1vzNuGM3p5TWgcLKuyKuE1TLlIwkqOUwJL+/ysbv6xygh2Ud7T5
 4Ket1Xcf9I1IAoaZXwBIf9EHXvpfGRmMy2tX85h2XiwM5BhvX+7bmxJmE1K422RZ
 gmpHj5OcP8mBUexorUZEdzHulLDgZUZPnBYtKYFJ1+wWvbOIRda36lOTJe9IyRbG
 DoYLUHD6+CWRtiATWha0wuJnGP23POq00vkNzHBQ65zTgCp2CBFGl8LWj/eOz3eB
 Qsq1jejb6MA9ZVt5DZL2/nVt6C8boy6WJbav/F51utbfXdJesJzuhI1fV/6Gvmid
 icqSTA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b246d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:23:45 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99062be02ddso521389241.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294625; x=1793899425; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+p/2mSGlCHHYQ1GvfhyzgeWHrR6DS7SNrdse+KalGjA=;
 b=Zt9Dj1ThtAccN0TS07gQkDtwjeE5YDxiD84tQYv2lyB/PbgS79MWEKiOKCJ0fiqe2C
 8d2Qe6fwL+qn8oxgTLV23Wjfi56+wyTU0CKwrJZF3VSfb9Bm2UwXwcQ/eeQ0rmRDi77V
 3ryuwrZDWHYR5RSA5xpr84AX4tP7SASUVVz51xEkrBgmGVStbNPgw5sbpd6E4CwAWLtY
 VSLBhzaHEFgclqFn4Wl+kkq2UfOb88fpnL2PliVf4AN0C8Tsw+MGxg5lOb10+3KXXSZg
 +f81GumG6NUlLkoP4WmzrmZGfCl2zSE2popSxs/PY5g/b7oGV/GPKfzL9YUJse168ter
 nXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294625; x=1793899425;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+p/2mSGlCHHYQ1GvfhyzgeWHrR6DS7SNrdse+KalGjA=;
 b=K2Q9wZ5y8RtaNfax872De/LpJNguMvJv7iW6gdJesRW8nCAsvYy0/jn1g59y+PiE1f
 aa6eFFzmfeedbicBVhnWO06GGGuxgg4kJettfwUG1XhjmmwDIv00yfouPJkL9A2USQFn
 qhbqZ3XHcivj3ZcUbZ3z7xLugkydZOKVpNtDAXwC2visTv7LnHXM/fWVX6EEjkvvc9SL
 Q61Q2craRTf899Q7GyswDShZB+Sq7UkL0OMcqSfhfopsEorNfKOFUYshilNacbGz8lye
 jvMRUhLj3TyJtuzcjCimYSwhvUyiDjTkNgqtmNDy1/ED7JNk66GZtFm4lXSxy5uNeHf0
 vUzw==
X-Gm-Message-State: AFq9FYLsAkIKYRPXSKhO9RU3TTIAWyoYEEpGbC1em5oz7sKWDnTRwe6g
 5LKvcJp79sHa+Hb9etivUA1ZTTW/ILM67Bq1xBRuPDkrA86AY9KHTv372kFv8s8pBbPj6GWNyM4
 PSbmM5UHqZjbC93fy/OydCUAzYbu/URvT77QPXXHvSDA+EXPHPBWBTzT56psz7xlkNlRN
X-Gm-Gg: AYBFou1F81g7NcduVz08qjaDy6z/8dlMeqaM9ptfHUbTsWnolG+OSw16Ivo/jbxazBy
 90sdEhDaI3UJxaC6MkSoRxWpPr+JipAvKi8kqk+d1x2w5eXPZJV9hS5+pV34x+PGo39k0xXwj6V
 7yINZ4XuB0srmBE4ell7+qUEviOlBA4SiF7EcsP10cMstAzUTLJNcjPHz6y3rkQmbU49IAqlctV
 G0MLHJpCSM/zXmTvu7+cLvb63XyclGkMEurcSddRbwxwGj05dINim1hyiaT+NiEuyqPDJz46DE7
 IUYJkzkyN/sJdVc0Txt7OvTUMS0WapRY2KlyTocPX0AHPK3sWz7PwmQ3b9OS0OxXXdgsvzaWR8S
 8qgtoHhfzxcHlfMTpB8eVzX61d9HL9szGjEyIvVTqwmOsnCE/mD7uhi6E71ulbc8FI7187/G7DW
 yHwoS5qZPekcVDyFC0ceClZQiUDytmrg==
X-Received: by 2002:a05:6102:dc9:b0:7cc:1d0b:6d33 with SMTP id
 ada2fe7eead31-7d03a5eb01fmr2755551137.26.1793294624596; 
 Thu, 29 Oct 2026 10:23:44 -0700 (PDT)
X-Received: by 2002:a05:6102:dc9:b0:7cc:1d0b:6d33 with SMTP id
 ada2fe7eead31-7d03a5eb01fmr2755523137.26.1793294624067; 
 Thu, 29 Oct 2026 10:23:44 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfbe7dcsm375800f8f.57.2026.10.29.10.23.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:23:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 03/31] tests/tcg/mips: Group DSP cmp tests
Date: Thu, 29 Oct 2026 18:22:47 +0100
Message-ID: <20261029172319.25766-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX3nbhjKWTfwBC
 pHI4m1vYcCQghCQ+13D1Gh1hIrx9Jxm1tb8W2+IqV2SJrVG6J9qdQdOYLmaeMHyYVPyLNc+otfH
 5bzuYoKvTMZ4rNk4yvikJLDjecoLmNA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX4L7apkJWNB8u
 fvY+uwLjodFF208ckFPxn5xSxManeOL3R2dGG2Oe4iK6HHiK8fFJf0GV7a3XhSGFBkUNhmEhOHn
 CUd3Dr7byACg3EyauHsnyAmKVhQMNQDpEixw0sjpw6HAz5PHe5mSZpFkyjtsZGQuOkZV5JBqPaA
 dtrKqW8u1TjlP75b/XSNfYaJ7kd/GlgXDwqvQYhtWFvB9LUAl91UKI7hfgmOE1RR9EY75YffLDr
 vc6hSf8BgEjZe3jsTOLWtN52tQsWccHw+cc20ZaYLCEIYD3FfJm7gaISghv6hz5Cql5/vrKq0W0
 XlHIJwfF3KkgX0Q6op6D+iJJidLXiviGpGxXx4u19awgsyYlJ4C2jbUMb4d6QvosjAaEdc0YxaY
 SlgPWA730PpvcijkapkDS2pabbbTVl3I5R7aSLSXU3T9wSDLDhK1nCaR8H69Ahve2YATlJ3JYRN
 GN1YKlp40F0/cflHV2g==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae38121 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=iOl1oX_4C5xlfAs-co8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: 0UWX0e4EnqIaYKOsusjf4zNyMcvgSQca
X-Proofpoint-ORIG-GUID: 0UWX0e4EnqIaYKOsusjf4zNyMcvgSQca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
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

Build the 14 per-opcode cmp tests as a single executable,
test_dsp_cmp.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_cmp.c             | 87 +++++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c    |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c    |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c    |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c   |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c   |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c   |  1 -
 tests/tcg/mipsel/test_dsp_r1_pick_ph.c      |  1 -
 tests/tcg/mipsel/test_dsp_r1_pick_qb.c      |  1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c |  1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c |  1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c |  1 -
 tests/tcg/mipsel/meson.build                | 15 +---
 16 files changed, 88 insertions(+), 28 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_cmp.c

diff --git a/tests/tcg/mipsel/test_dsp_cmp.c b/tests/tcg/mipsel/test_dsp_cmp.c
new file mode 100644
index 000000000000..89bc1fcfd1ca
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_cmp.c
@@ -0,0 +1,87 @@
+/*
+ * MIPS DSP ASE tests: Compare and Pick instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_cmp_eq_ph
+#include "test_dsp_r1_cmp_eq_ph.c"
+#undef main
+
+#define main test_dsp_r1_cmp_le_ph
+#include "test_dsp_r1_cmp_le_ph.c"
+#undef main
+
+#define main test_dsp_r1_cmp_lt_ph
+#include "test_dsp_r1_cmp_lt_ph.c"
+#undef main
+
+#define main test_dsp_r1_cmpgu_eq_qb
+#include "test_dsp_r1_cmpgu_eq_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpgu_le_qb
+#include "test_dsp_r1_cmpgu_le_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpgu_lt_qb
+#include "test_dsp_r1_cmpgu_lt_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpu_eq_qb
+#include "test_dsp_r1_cmpu_eq_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpu_le_qb
+#include "test_dsp_r1_cmpu_le_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpu_lt_qb
+#include "test_dsp_r1_cmpu_lt_qb.c"
+#undef main
+
+#define main test_dsp_r1_pick_ph
+#include "test_dsp_r1_pick_ph.c"
+#undef main
+
+#define main test_dsp_r1_pick_qb
+#include "test_dsp_r1_pick_qb.c"
+#undef main
+
+#define main test_dsp_r2_cmpgdu_eq_qb
+#include "test_dsp_r2_cmpgdu_eq_qb.c"
+#undef main
+
+#define main test_dsp_r2_cmpgdu_le_qb
+#include "test_dsp_r2_cmpgdu_le_qb.c"
+#undef main
+
+#define main test_dsp_r2_cmpgdu_lt_qb
+#include "test_dsp_r2_cmpgdu_lt_qb.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    RUN_TEST(test_dsp_r1_cmp_eq_ph);
+    RUN_TEST(test_dsp_r1_cmp_le_ph);
+    RUN_TEST(test_dsp_r1_cmp_lt_ph);
+    RUN_TEST(test_dsp_r1_cmpgu_eq_qb);
+    RUN_TEST(test_dsp_r1_cmpgu_le_qb);
+    RUN_TEST(test_dsp_r1_cmpgu_lt_qb);
+    RUN_TEST(test_dsp_r1_cmpu_eq_qb);
+    RUN_TEST(test_dsp_r1_cmpu_le_qb);
+    RUN_TEST(test_dsp_r1_cmpu_lt_qb);
+    RUN_TEST(test_dsp_r1_pick_ph);
+    RUN_TEST(test_dsp_r1_pick_qb);
+    RUN_TEST(test_dsp_r2_cmpgdu_eq_qb);
+    RUN_TEST(test_dsp_r2_cmpgdu_le_qb);
+    RUN_TEST(test_dsp_r2_cmpgdu_lt_qb);
+
+    DSP_TAP_PLAN();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
index 957bd88ce01f..47406f77c59e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
index 356f156c5d1f..811646d78e84 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
index 3fb4827ad761..430953a77215 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
index 2615c84c75c7..1fd5b523a44e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
index 65d0813c3b19..da1277065246 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
index 7dddad98532c..9317f9a3fa44 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
index 680f2a1999d8..8736e7fc45ad 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
index 43cfa509ca3c..fbc620adf95d 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
index 074ca5b402de..8132b13a97c2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_pick_ph.c b/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
index 929a002e7544..0a11b5d12ce3 100644
--- a/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_pick_qb.c b/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
index a79047524662..8def9559d632 100644
--- a/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
index 2d6340d6fb12..cfc71839591a 100644
--- a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
index a0ecdca2ac2e..9e7d8260cfa7 100644
--- a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
index dba99e392c29..ec964e39074f 100644
--- a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index e7e576ad6c19..e8737308c40d 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -6,17 +6,9 @@ tests += tcg_tests['multiarch-linux-user']['tests']
 tests_dsp = [
   'test_dsp_acc.c',
   'test_dsp_arith.c',
+  'test_dsp_cmp.c',
   'test_dsp_r1_bitrev.c',
   'test_dsp_r1_bposge32.c',
-  'test_dsp_r1_cmp_eq_ph.c',
-  'test_dsp_r1_cmp_le_ph.c',
-  'test_dsp_r1_cmp_lt_ph.c',
-  'test_dsp_r1_cmpgu_eq_qb.c',
-  'test_dsp_r1_cmpgu_le_qb.c',
-  'test_dsp_r1_cmpgu_lt_qb.c',
-  'test_dsp_r1_cmpu_eq_qb.c',
-  'test_dsp_r1_cmpu_le_qb.c',
-  'test_dsp_r1_cmpu_lt_qb.c',
   'test_dsp_r1_dpaq_s_w_ph.c',
   'test_dsp_r1_dpaq_sa_l_w.c',
   'test_dsp_r1_dpau_h_qbl.c',
@@ -45,8 +37,6 @@ tests_dsp = [
   'test_dsp_r1_mult.c',
   'test_dsp_r1_multu.c',
   'test_dsp_r1_packrl_ph.c',
-  'test_dsp_r1_pick_ph.c',
-  'test_dsp_r1_pick_qb.c',
   'test_dsp_r1_preceq_w_phl.c',
   'test_dsp_r1_preceq_w_phr.c',
   'test_dsp_r1_precequ_ph_qbl.c',
@@ -85,9 +75,6 @@ tests_dsp = [
   'test_dsp_r1_wrdsp.c',
   'test_dsp_r2_append.c',
   'test_dsp_r2_balign.c',
-  'test_dsp_r2_cmpgdu_eq_qb.c',
-  'test_dsp_r2_cmpgdu_le_qb.c',
-  'test_dsp_r2_cmpgdu_lt_qb.c',
   'test_dsp_r2_dpa_w_ph.c',
   'test_dsp_r2_dpaqx_s_w_ph.c',
   'test_dsp_r2_dpaqx_sa_w_ph.c',
-- 
2.55.0


