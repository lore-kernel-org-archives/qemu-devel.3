Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E31606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AJZIoee8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OirT+PtO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTu2-0000wc-Gx; Thu, 29 Oct 2026 13:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTtp-0000PP-GH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTtn-0001ab-GO
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:49 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD1Sg535232
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BNti26+gFNqapEV6BAg5OVdrqhn3mTjGBqdfdS2jM1E=; b=AJZIoee8l3nT/Xa0
 jZZwJ8earteg2X7g/I0X60g98L7khrI3Bk1F4diZzJkuuYJskEyiV/yRRtUkMLbf
 i4306lRQzm+vQ6OudrSW6OBDmxleekTThy9MMhDjXGsWiKEhuwoOllGOnz+2KAQP
 ooYk0S0iK9ohaBlOspVvgk/3bHGeqjRvFlqu/pmCzq25KuI3KgHDZw0ZU8SEBCVq
 BQuVP9T2YaMzX435TPL/FnN293kw7RJS7qHymfk3jv9mD1CF+UA4qD8HJUO/75QW
 xJJEWwzMdWorXMNdwMrY5nzegu0WKAytpAZQeoUJA1bESDllbVuYXoa4D5Vu5FFX
 0wZYKw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm8k4h273-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844cb60so194974185a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294806; x=1793899606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BNti26+gFNqapEV6BAg5OVdrqhn3mTjGBqdfdS2jM1E=;
 b=OirT+PtOA2fhk8ZMUDtJqsFLuoBira3xOrK/CnfhK5WiaGisp8Es0eG8EoH71v6wtM
 FREpgrqXXHLth3WZKfVy7G9/91rmGeJNdxkfsyC/v+MOkGCfYVzG7r5iQsXvhp4NtwZf
 qVKNNeUdDP51V7/fa/BiEQJwv3+LTpRFsQGpE54T2FNwWH9G/TgGeJIw0AsVAVJscsMr
 Eof6jaMd3dSU5zirLrvzRNa964kGZzdsc5Yu8j7WtjiR1ILtPgxLfNlRd+qlZgO2QhHu
 Lho8O1xYugngGP+CSXmZ2bnfKOmGcdhlDC4UX1tExTiwt+dno79GKAAFinkcQtG4OINr
 bXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294806; x=1793899606;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BNti26+gFNqapEV6BAg5OVdrqhn3mTjGBqdfdS2jM1E=;
 b=0/XiSy82Ik4sIBZqfdjAkGwRY/SU6BgImWYlbzzBKI0EG+e+xXLSxNXvu619nPdxnk
 lyY82/per4pgqF9UPdPV6ucXb8qJdFhPvrcaPvQF77Jbz9n/7DPtPZnjnrz4V0XC8OIX
 ZnlZZmQSJYgQXYAKDbbvG86mFqntdADIDUv8f0TXfsYFLI5L4NrN4xp5/pvP3rbh3tJ/
 KMTY0kMBh85tac8sKSzYESOcYpHHm9f1ZFF4/DM8BPUIRfDu0u2rR9rI0xAZVPfK8ixZ
 2eiFgXQQQuScDkwtAT2eA++sL7Iumk4XalwDPTODPieYtICETXcR26Q8OYa8V5epohCh
 DjRQ==
X-Gm-Message-State: AFq9FYJEk8x3sf4HrD9LuTZTnXFj1jamANcNmTkMFHzsWmBGY/1vtgJd
 H0Jg7gGQIsfNhccrNN85Gvz45WW3/yDEJvRa/3YWwSmMHnCcDifdWH9J3LnnJPjvUKnMV0ftbl2
 fLeolIukLbFK9WZ007aw3WDCp/kmDpLeTyJIjLLr7xPWsrMqT/ReYwO7Y8aKIsnI0skm5
X-Gm-Gg: AYBFou37u4Fxbeop6LPWZb2QF9VGuePaL2tN2I6JMXOLZnDZjMm+fwpvTX6ebEzd7H1
 ovisbRiQFPpHV/EJuUhOwKU+XHDrOISrtpRJgkxzc56aKbyHvN5l7wzK00+HPeAieX22iQUFiD1
 Zq3H1V0KGbHlMrSe/O1kEN3k9tEUVLLdX7T4UYV1cmzkLe2kmN8bi3tuHN2B2IembY7DFLULMTr
 atUtNfl3RccNSxcorGeFeBUVaH7nBz49+mXkjolb79Tk//PbqSchpNFGWQuHXUAVx0gGZCR/GD0
 g+OP+oi5sLCXNoArLQMzSDg3JA5CZxofAZhfSzVg93Bp4bkkiNCwu6jaxV+StFIbm3xjj82+Q5T
 nxiikv27bYcKDpCmvXtIVBY0pwLiBJttOWuGb4LdxuajdxbLaQWJ2rUnQIGHYmwGxCPqocmNURA
 lsWOmMJj3mE2Qh1GnsHBbZzHpVuK6bIw==
X-Received: by 2002:a05:620a:2628:b0:93e:6e6a:b686 with SMTP id
 af79cd13be357-944133b3558mr470261285a.29.1793294805945; 
 Thu, 29 Oct 2026 10:26:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2628:b0:93e:6e6a:b686 with SMTP id
 af79cd13be357-944133b3558mr470257885a.29.1793294805443; 
 Thu, 29 Oct 2026 10:26:45 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a9ead8aa0fsm47118505e9.4.2026.10.29.10.26.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:26:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 28/31] tests/tcg/mips: Group MSA logic tests
Date: Thu, 29 Oct 2026 18:23:12 +0100
Message-ID: <20261029172319.25766-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX5GmKNCyvEhmr
 q6KSkT6S8nTH1ZiFCfjWS/UlJILBOR3qAT1FoQYfv71e8VH0HPgpoqHBkH4MbUCndjHzMuuy5Wu
 Z6JnnNU6oTONBL2ptqBc6jvZGAz7BETOQU7rPJwAYz56C+GgG6XftKkot+nW37RbOPYrDW035HJ
 ro2jnhGCW3TL1XM8NRMyKjjeLXTAYnHkx60s1sanSfLxPB6VPbkUfCLbaC9WTRx32KoEkn3xqyh
 kuzcTtMTQ3WlwkXZEclsGLgcZaSe/yFRplTe5R4WHsrsna9TOgjGdHtcYlJuElkwu0zM43Y+2x6
 vpbYw9LBTd559bvsY+zXASvn/kU7t/xAzXv2Y+CsBrQ1Qnh9dvhR1DVZx6R16+JjyqKqdBrGCyt
 PunIBPcTrXhqUIu7CeE5xz6DDUW6nw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX1f9TKDQgEJ+K
 zOWtajfzsnoqXwlzT1tF+y3j1kR+1QKhBdmqhc0NUxZIJgydoxYferYUL0sFQKypv9AnRQjPhD8
 p+wvAUIcj/DM1XcUjOY+VMrc0AbNToQ=
X-Authority-Analysis: v=2.4 cv=LuAHWXdc c=1 sm=1 tr=0 ts=6ae381d6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=HQ84rix33TUywbstHpkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: XGFor4_T4rBpMx9gfueJIO8uZd9_a00s
X-Proofpoint-ORIG-GUID: XGFor4_T4rBpMx9gfueJIO8uZd9_a00s
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

Build the 5 per-opcode logic tests as a single executable,
test_msa_logic.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_logic.c | 61 +++++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build      |  5 ---
 tests/tcg/mips64/meson.build    |  1 +
 tests/tcg/mipsel/meson.build    |  1 +
 4 files changed, 63 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_logic.c

diff --git a/tests/tcg/mips/test_msa_logic.c b/tests/tcg/mips/test_msa_logic.c
new file mode 100644
index 000000000000..a9c45f1e98ad
--- /dev/null
+++ b/tests/tcg/mips/test_msa_logic.c
@@ -0,0 +1,61 @@
+/*
+ * MIPS MSA tests: Logic and Move instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_and_v
+#include "user/ase/msa/logic/test_msa_and_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nor_v
+#include "user/ase/msa/logic/test_msa_nor_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_or_v
+#include "user/ase/msa/logic/test_msa_or_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_xor_v
+#include "user/ase/msa/logic/test_msa_xor_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_move_v
+#include "user/ase/msa/move/test_msa_move_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "and.v", test_msa_and_v },
+    { "nor.v", test_msa_nor_v },
+    { "or.v", test_msa_or_v },
+    { "xor.v", test_msa_xor_v },
+    { "move.v", test_msa_move_v },
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
+               "Logic and Move", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 135e6297e4de..843031f6c0b8 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -55,9 +55,4 @@ tests_mips_msa = [
   '../mips/user/ase/msa/shift/test_msa_srar_w.c',
   '../mips/user/ase/msa/shift/test_msa_srlr_b.c',
   '../mips/user/ase/msa/shift/test_msa_srlr_w.c',
-  '../mips/user/ase/msa/logic/test_msa_or_v.c',
-  '../mips/user/ase/msa/logic/test_msa_nor_v.c',
-  '../mips/user/ase/msa/logic/test_msa_and_v.c',
-  '../mips/user/ase/msa/logic/test_msa_xor_v.c',
-  '../mips/user/ase/msa/move/test_msa_move_v.c',
 ]
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 67858c5a23f2..fffbda7750ac 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -54,6 +54,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_multiply.c',
   '../mips/test_msa_int_subtract.c',
   '../mips/test_msa_interleave.c',
+  '../mips/test_msa_logic.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 5c0a89197089..7ba88b2aac29 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -55,6 +55,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_multiply.c',
   '../mips/test_msa_int_subtract.c',
   '../mips/test_msa_interleave.c',
+  '../mips/test_msa_logic.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


