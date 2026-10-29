Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94A606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Alr0TlQH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M2gCGUW6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTu0-0000ko-AC; Thu, 29 Oct 2026 13:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTth-0000K9-An
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTtf-0001YU-7o
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDFXB1087083
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gYXYpACcrE5c26X7x29VOLgKBsg0UjtqFZCUvLQ/xwc=; b=Alr0TlQHxDdPzeF7
 dtlAEUAn7YHUGfidm9df77riAsy4MPpdP0IqbnJ2VOZvUnrVB0PW0K/HLRfve2lg
 BnFG9xKIssCllvw/ZsfgncZZqPBmujGuW6V5kWhiGdrhEHhVD8sCNa4w3C5B4n1R
 DbPnLVdvU+4FOep3KBJDsUwRwNx2osn2pOEmG7m7AK8rh6/9QcaZc8pMIedd6NKn
 jlS3x/8cc2dp9C61Kl77jXtYaQJZA6pmkhPQve6+R8BQc5gjqBrfCYx9HCeEgqXv
 AQYdIVjwHG9URU0rEI+5EdIFkBn/2ciBZHNRqnor5iQu/N8mCIz448g8/FegbLNA
 ZbVVqQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hktmpc8k4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb71b1443so499043185a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294798; x=1793899598; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gYXYpACcrE5c26X7x29VOLgKBsg0UjtqFZCUvLQ/xwc=;
 b=M2gCGUW6JY5kizHgMYtUPtMeJQWX8ZUbUaeItL4rVai5NVq03CBxp5dMZzD4y32cHe
 gMVeAXhPdSsdqLR/Ir0KEOUKWQQVWzIC0zp5F4vq5W1hWBn9fCDQN62TPU1Bi9TkOT8i
 7mBmYrPddKyciKzH7B/tUnhf0rImf48EHKTTSpuCBgAERWtmZQg3ApgN6B7zy4FV/KN8
 QVp8s2XIQWfHEICYUKROCyvhkDvhYrH8gnRoNylponE/GMtG2Lhi/bPCmm2OHRnzzanR
 FEk1xwzD41urC+PyDE5OmI+EGVO8vGYleMlECIWxQ7q9c0xty8ttOxiiWwA50W8/PC7S
 CSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294798; x=1793899598;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gYXYpACcrE5c26X7x29VOLgKBsg0UjtqFZCUvLQ/xwc=;
 b=lP4M+X3oqM2ZuJc1ANBUcrk9u0oedSqP5vAbIgBW7tN41J7GaBgNS9yTGNbUBy8eQa
 Nb+dqdJYUYIruxJ1NqtVk7DezatdIjCVUnFcPAFWO9d1nq65q7DP88cKjWEPFb6KBgAF
 iPUnqe0W9hBmklvs7uBvTfK/eEoQM4C5sfptnZm2YqJ4rf6zZKue49s6vnnw+mnAzVfL
 xT6gPDzmY3LNthvU5bKUs7ZLKmjl6zHVaD2/xcGjCoG9tR1n1nlJ35sgWQHzVVs1f4PI
 8Qo+iT0JpFt8O1Emxxj/Ve3XaCPHVu/haNDJM4CgxGLjQW62ucf7s2ggzF7hnarp/Xuo
 uPAw==
X-Gm-Message-State: AFq9FYLrWGXeTOVqM2aceKV4L73+Lo+4tZyACeFYQOMrPXXeMwvaUd66
 dytGmcE+km05RP3Yc3NMEw53RZ6dI/i2djtbZBeL9AQ1UnyEP9Va59uk0WfT1kiUhI9MdsT1OfC
 2PHTR+o/aBdSph+9MqDe3KEhFeRulWr3UWbKRcfNdb1Dwc57ea83jxId3WREpH4i/xp8A
X-Gm-Gg: AYBFou1qDx4/hFuilq1TdF2P1uxuZNCimprvWQP4fM2LlfI3e75Hlk2yJE8azmcgGyS
 +Rz4AvpmEUk/ukLyYWXqmEdQ+V+k51DY95533Bw2doc7QY/HET6zqRB7BNNJU6WRfvtawbuG6ZX
 FIlqDIDOAa1dFMtyFJ9qcqQ4OccNmHAtYGoMe63TIl9mLDaTPVHBnuYuwIrN6sRGOvnl5gNVLY/
 eNreOYY3Beh6inzaDEn4ivEpy8vZsDJL0ZzQESjMcIfylbpg7+n1rxRleNvk3UYGRToDTfPfsD/
 jjLUB0xcaf/OUbh/AkjZhjQFx/OqArEyjn/j570rK6zyuwKhzQMSIopT/URdyunZHu8sHcZPSlT
 n53sYtP/mnPNywVHXqJDXGrwIv6gws9OTUE5sSGLFNN6OvUYXP/dhLi79g/y0cxdOCe//TzvG1T
 j7gooPYMcyThDt36Jz4P6J8YldggW2ew==
X-Received: by 2002:a05:620a:2724:b0:93e:c35b:2332 with SMTP id
 af79cd13be357-94408d39620mr881239385a.73.1793294797581; 
 Thu, 29 Oct 2026 10:26:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2724:b0:93e:c35b:2332 with SMTP id
 af79cd13be357-94408d39620mr881235185a.73.1793294796915; 
 Thu, 29 Oct 2026 10:26:36 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm79587115e9.4.2026.10.29.10.26.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:26:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 27/31] tests/tcg/mips: Group MSA interleave tests
Date: Thu, 29 Oct 2026 18:23:11 +0100
Message-ID: <20261029172319.25766-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX9S0jHWFj77fm
 GMC7ajzWVOQUS0waigLmLzzmfZDq28NAcBqXLhVEPgWP8jlZG3RrUs1MQYGRQQ86Boik0eon0hE
 +XD6t3afnIQuICI4Ut19d7fwkCbyxzF4yL1OMVT8ukwUe+tu2vGaF/89aksgvztkQf61eFzGuPV
 /0f4HrQY9cipYDQQb/x7CbybkHSnQgZPYhx1rqHs9qSBi+Ap70NZrnDLo5eDmfWaipMd0VFNzF5
 sIQ2LDDFT5wlRHWYMdcgku7gkgNATyrxnFcU5R5e7yH9FMNMf+6UfP/uXXrtHrVyLDoRqIVm7+n
 MYZo8GoC83s+zjtflXYK2X4B03nILjblAOlAKH2p0BOVA8OIxDsB8SHDDvm38tr+cbOELPOQBeC
 VDI2tCMhOiUh0E4SOnovlD21NXW19Q==
X-Authority-Analysis: v=2.4 cv=crYOAF4i c=1 sm=1 tr=0 ts=6ae381ce cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=znaDYlxXyk8I6BA2ZYkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX2hDjZU4N4GZi
 QD14KosGf1l2yynqbux6KclBgjGqTwt5BsMJnfGal18hR2ZfxPy2kgzuI5jzqLdrT/WcDyLbiCH
 5yFoHilSt3MJsIClbdSAeTIXaxIkraE=
X-Proofpoint-GUID: 0mHHmk45YSV95MhGYGJYhQJhHJ4SFaxM
X-Proofpoint-ORIG-GUID: 0mHHmk45YSV95MhGYGJYhQJhHJ4SFaxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Build the 16 per-opcode interleave tests as a single executable,
test_msa_interleave.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_interleave.c | 127 +++++++++++++++++++++++++++
 tests/tcg/mips/meson.build           |  16 ----
 tests/tcg/mips64/meson.build         |   1 +
 tests/tcg/mipsel/meson.build         |   1 +
 4 files changed, 129 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_interleave.c

diff --git a/tests/tcg/mips/test_msa_interleave.c b/tests/tcg/mips/test_msa_interleave.c
new file mode 100644
index 000000000000..bdc130ccb6ae
--- /dev/null
+++ b/tests/tcg/mips/test_msa_interleave.c
@@ -0,0 +1,127 @@
+/*
+ * MIPS MSA tests: Interleave instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_ilvev_b
+#include "user/ase/msa/interleave/test_msa_ilvev_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvev_d
+#include "user/ase/msa/interleave/test_msa_ilvev_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvev_h
+#include "user/ase/msa/interleave/test_msa_ilvev_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvev_w
+#include "user/ase/msa/interleave/test_msa_ilvev_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_b
+#include "user/ase/msa/interleave/test_msa_ilvl_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_d
+#include "user/ase/msa/interleave/test_msa_ilvl_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_h
+#include "user/ase/msa/interleave/test_msa_ilvl_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_w
+#include "user/ase/msa/interleave/test_msa_ilvl_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_b
+#include "user/ase/msa/interleave/test_msa_ilvod_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_d
+#include "user/ase/msa/interleave/test_msa_ilvod_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_h
+#include "user/ase/msa/interleave/test_msa_ilvod_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_w
+#include "user/ase/msa/interleave/test_msa_ilvod_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_b
+#include "user/ase/msa/interleave/test_msa_ilvr_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_d
+#include "user/ase/msa/interleave/test_msa_ilvr_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_h
+#include "user/ase/msa/interleave/test_msa_ilvr_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_w
+#include "user/ase/msa/interleave/test_msa_ilvr_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "ilvev.b", test_msa_ilvev_b },
+    { "ilvev.d", test_msa_ilvev_d },
+    { "ilvev.h", test_msa_ilvev_h },
+    { "ilvev.w", test_msa_ilvev_w },
+    { "ilvl.b", test_msa_ilvl_b },
+    { "ilvl.d", test_msa_ilvl_d },
+    { "ilvl.h", test_msa_ilvl_h },
+    { "ilvl.w", test_msa_ilvl_w },
+    { "ilvod.b", test_msa_ilvod_b },
+    { "ilvod.d", test_msa_ilvod_d },
+    { "ilvod.h", test_msa_ilvod_h },
+    { "ilvod.w", test_msa_ilvod_w },
+    { "ilvr.b", test_msa_ilvr_b },
+    { "ilvr.d", test_msa_ilvr_d },
+    { "ilvr.h", test_msa_ilvr_h },
+    { "ilvr.w", test_msa_ilvr_w },
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
+               "Interleave", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index c033e7a5500f..135e6297e4de 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -23,22 +23,6 @@ if 'qemu-mips' in emulators
 endif
 
 tests_mips_msa = [
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_h.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_h.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_h.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_h.c',
   '../mips/user/ase/msa/pack/test_msa_vshf_b.c',
   '../mips/user/ase/msa/pack/test_msa_pckev_b.c',
   '../mips/user/ase/msa/pack/test_msa_vshf_w.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 40ad347fa2ff..67858c5a23f2 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -53,6 +53,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_max_min.c',
   '../mips/test_msa_int_multiply.c',
   '../mips/test_msa_int_subtract.c',
+  '../mips/test_msa_interleave.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index cd3700e5e84b..5c0a89197089 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -54,6 +54,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_max_min.c',
   '../mips/test_msa_int_multiply.c',
   '../mips/test_msa_int_subtract.c',
+  '../mips/test_msa_interleave.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


