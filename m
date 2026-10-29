Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819B606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hWGUyKd4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WoTUBTwW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTtL-0007zc-HW; Thu, 29 Oct 2026 13:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsX-0007Al-Gh
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsV-0001Qw-Io
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDasq3689726
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PqDwKUQPxw3vXQAWEkujRYVr65eBYGjyQokpGd9oWMU=; b=hWGUyKd4QiKNe7UA
 Ng8C9IX7N+X7Vg+jao4WHQm1UBokvJEw0ODpwUslUB0tFaZnA7V0vZmcFyhhsNgF
 cyAtg9sD2RYq94bntMAbTV3NoGborpc1RZmTgVUMEgHN6ER3AtKTb0fH3SAVEcS2
 gzzsBB3/Gmg2QkPUoDbgBiPLw2veDY/O3JHf+Q6RG/XKwf+DPvndi5uByHeJOAYv
 zG0nFL8X8XBWQrgHfvrIFvirFCE4bBzF58zPP1yT1ClESJtbskVn1Z1Syemv7div
 FW24b+ibaL/NMLh4HuWej3+Y4mRYHKnpH2VT6HJwqSQwNV4ZWbmB2qpMRYYXswQ1
 NfBV4A==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5sb7px-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:26 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7bf45382794so1929507137.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294726; x=1793899526; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PqDwKUQPxw3vXQAWEkujRYVr65eBYGjyQokpGd9oWMU=;
 b=WoTUBTwW+jmLPh57mOkvdYGIKOvRyQt05Q0et7X48zN8T93nrMVuhu/gy7L8pVzzk0
 gn+kBLPDQJDLYybn7lDHoKXe0J4K9Oj3O+EyJ6nxpmn81ONcvFKJSn1nwTl9CDxYOpdR
 XNqHwylBDOUCkd9hB5MBHF7uKva0LLGkuGXVolSsfBB6dS3DovNHTgJ2YsW9TgH/VKUp
 NxPxXQpNHp9p6MHdheWLMD4MBB3PP934zg9KBYZTI1EZqSrx6o1IkrsP+fRtI6eyJsod
 8l0ftZHdvePnbnGxv+u2D0BPlchCGJXn6I0jM+TR3a+reop43FGLLWga9Wb2Y+oaIzhz
 bDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294726; x=1793899526;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PqDwKUQPxw3vXQAWEkujRYVr65eBYGjyQokpGd9oWMU=;
 b=p3yX6sVTd0aQtPCoFYVJurqgUP5w5AV3VgwNVUkn5VV/zSG+7ExP2o5JfVdh1Bx8t8
 WhiSIdISduomK+qy8/aOyczHWTZHAaNw11tRvXmKHnkLJc2gHeinU5YVPE3bi0ZqFJQc
 +sDwo58qySAWywmlbk9n7oQ5tm51Q59qYJ/Ac27eYqNPPocB5RqUpOsmJtwnrfpASrLY
 rAA8hmm2K3bM1aCJhxREbgs1dr3plixf5J6a0ZydG6BXNc7tEUVxjjIQap2heqQMj9Sa
 9/y/ksAQk2wwIh2cThDihdnqpMXvipTAbFjWDJeXr2TINUSvkI35JSovzT+HMbf8uflw
 6jdg==
X-Gm-Message-State: AFq9FYLvp7f/6PXllUkw75dC7VDhFIFMxSPMakyiOdMe5LspCsL7d3Kv
 zcfUgOPQrPcg26s19I0/cESwxJsNkm+2v4pLeJnIW81oJiHjQqwj61BKP+IJ0QtgaUX0v9kmhqQ
 tqMoZH2uf28FjkiMGvoSr8AW3YsTq47rehV0PJ5oglZHU2b++eF3SdaDYaT6tKScnXtfH
X-Gm-Gg: AYBFou3A3d3gmNPKZrwNk54Ld1aZ7Wyw3O0iGvmP5Kw4EqGOjQT8c0lNucFg9xX1m1A
 Fgalequ1DQOlkpzXidYvczmbhNjp0kx8ngGiAsCJp55H3iBl4/83EBiTZPgisF3roxRrt+/1m1b
 qWTXZR+4LF3NN6rzz01+KJBXUjPbwF0SWNaXPUbIXlKnVBuVOhmOSyVU03Y/XzbfvXv0sJxooMj
 yzap0pH21fyQlPWx6DL5TorAbQPKl7JtIHBKP8lJQUJciKYE/xlfSO551czAu2hZaTVwruoUdgR
 dU2dV29w+1NLrUae+XMBg3YrwQrahja4zCaVIcWN+VzAfwvYIXtcVqxZxAbK0ElTHjOxSvH0ieM
 9x6wJaw4v4D3HYFEDtROG8Mkafosx6nZN/mcpUS3+7SbzL7+5Tt3lEC/fyvo35YD6hFrgxlnIns
 MTsTbYzcaejDS5XjAADaRsv9aM/eT2yw==
X-Received: by 2002:a05:6102:1499:b0:7a4:e550:eeb9 with SMTP id
 ada2fe7eead31-7d03a5b9f80mr2950622137.22.1793294726120; 
 Thu, 29 Oct 2026 10:25:26 -0700 (PDT)
X-Received: by 2002:a05:6102:1499:b0:7a4:e550:eeb9 with SMTP id
 ada2fe7eead31-7d03a5b9f80mr2950611137.22.1793294725671; 
 Thu, 29 Oct 2026 10:25:25 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df8804bsm454719f8f.15.2026.10.29.10.25.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:25:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 17/31] tests/tcg/mips: Group MSA fixed-multiply tests
Date: Thu, 29 Oct 2026 18:23:01 +0100
Message-ID: <20261029172319.25766-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX7NfvclEmxVil
 e8UJckpYRCki0iypibRKywweFicBkmAIO4VAaHyWnp0g+bP6YZ4IgnrKWOrRcNkMvIKFeiC2FPH
 TTg/gpH8/bParpk1yhciA2gdOZ5Qh2A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX4EFs7y6JIvvP
 HpnV/rSURH595zc1meTZ/Ip6kd6/tbITirivRTJSUUwENiuktg8trPvoHApmTLSxJsFOUpxc9oN
 nDfhDDu+9jY5XjX1x264Gz9a1Y0u4e0K1S/6y2ghBXz26dSbgjvx4czrf+g4cfPAVWVS72MwenY
 0XigbQLb5h+r1lVKgSRABU5BrJoIhW+CS2RUGjdNoDItvGhHgHtdBknK6REiuLwqxW1ds1LrgHS
 +4Tx4J2/VMbtYgI9fMg7RPj4rWVe+WbdYUR/KtYwVfr6DCgLpyP8ILzfzoVBfm7bhRP/U5i6J/m
 vjRHjuzoY9JtD90AFHjIaG/kBDIFWCwu1fwxFccmnStTm4/R2ni7NnRN0CSbWSP7kyDKONxTxCG
 eKU2wuLvJzpkuaxljQCQnbTLD2RDHg==
X-Proofpoint-ORIG-GUID: wjeFwTILMelVEHN8gEaXVx58ZOIHwB4j
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae38186 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=bS_b1DOo4Aa17MkEkSYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: wjeFwTILMelVEHN8gEaXVx58ZOIHwB4j
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

Build the 12 per-opcode fixed-multiply tests as a single executable,
test_msa_fixed_multiply.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_fixed_multiply.c | 103 +++++++++++++++++++++++
 tests/tcg/mips/meson.build               |  12 ---
 tests/tcg/mips64/meson.build             |   1 +
 tests/tcg/mipsel/meson.build             |   1 +
 4 files changed, 105 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_fixed_multiply.c

diff --git a/tests/tcg/mips/test_msa_fixed_multiply.c b/tests/tcg/mips/test_msa_fixed_multiply.c
new file mode 100644
index 000000000000..aea5fddec4f8
--- /dev/null
+++ b/tests/tcg/mips/test_msa_fixed_multiply.c
@@ -0,0 +1,103 @@
+/*
+ * MIPS MSA tests: Fixed Multiply instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_madd_q_h
+#include "user/ase/msa/fixed-multiply/test_msa_madd_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_madd_q_w
+#include "user/ase/msa/fixed-multiply/test_msa_madd_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddr_q_h
+#include "user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddr_q_w
+#include "user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msub_q_h
+#include "user/ase/msa/fixed-multiply/test_msa_msub_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msub_q_w
+#include "user/ase/msa/fixed-multiply/test_msa_msub_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubr_q_h
+#include "user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubr_q_w
+#include "user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mul_q_h
+#include "user/ase/msa/fixed-multiply/test_msa_mul_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mul_q_w
+#include "user/ase/msa/fixed-multiply/test_msa_mul_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulr_q_h
+#include "user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulr_q_w
+#include "user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "madd.q.h", test_msa_madd_q_h },
+    { "madd.q.w", test_msa_madd_q_w },
+    { "maddr.q.h", test_msa_maddr_q_h },
+    { "maddr.q.w", test_msa_maddr_q_w },
+    { "msub.q.h", test_msa_msub_q_h },
+    { "msub.q.w", test_msa_msub_q_w },
+    { "msubr.q.h", test_msa_msubr_q_h },
+    { "msubr.q.w", test_msa_msubr_q_w },
+    { "mul.q.h", test_msa_mul_q_h },
+    { "mul.q.w", test_msa_mul_q_w },
+    { "mulr.q.h", test_msa_mulr_q_h },
+    { "mulr.q.w", test_msa_mulr_q_w },
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
+               "Fixed Multiply", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index f3919436dacf..21cf734c1763 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -192,18 +192,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/logic/test_msa_and_v.c',
   '../mips/user/ase/msa/logic/test_msa_xor_v.c',
   '../mips/user/ase/msa/move/test_msa_move_v.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c',
-  '../mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c',
   '../mips/user/ase/msa/int-max-min/test_msa_min_u_h.c',
   '../mips/user/ase/msa/int-max-min/test_msa_max_a_b.c',
   '../mips/user/ase/msa/int-max-min/test_msa_max_s_b.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 08a4900a9fb5..e1963c9b16f5 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -43,6 +43,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_bit_count.c',
   '../mips/test_msa_bit_move.c',
   '../mips/test_msa_bit_set.c',
+  '../mips/test_msa_fixed_multiply.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index fc19a18acecb..0b8a8b77a514 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -44,6 +44,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_bit_count.c',
   '../mips/test_msa_bit_move.c',
   '../mips/test_msa_bit_set.c',
+  '../mips/test_msa_fixed_multiply.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


