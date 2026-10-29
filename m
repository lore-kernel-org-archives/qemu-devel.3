Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E6606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LS9nk54j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VnOFHhzk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTt9-0007kR-2P; Thu, 29 Oct 2026 13:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsJ-0006ww-DY
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsH-0001JO-HQ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:15 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD7K7535458
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bEemRG8lYCfY1ttW49wc3sdEhHPWBllIcg9uaL5Ir+o=; b=LS9nk54jgQUU+EWq
 ZHbTDjyJHNmJGNxIZOkL9N1RzarAQE9aVWqiZOPlk54vVYwsMXxI62Wfrgpv3ifJ
 rSXe+WWXp8z+qF1F7FIPyposuGRIKI3MCRvS4cUwfCTPSxOLHgrjVn38dimZxDjG
 HVgom2pQPcTMrO2TzO8LGQ1DV2G6Hb7hjPDxCsGU/yVpI51H1AzZyc85v0ZGA5cN
 wt+0jnkcoB/ruhcnAldHeQmyFUrkstBdkrsazongz8zs4TEh/5xN48MkxZrVkng8
 LHagnVPHjWdTX2doSSzuHjQJaXi5GUDiue5ssvGA6BjJ3rMEA5g1he3vyX+4jPqg
 FG61HA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm8k4h1eu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:12 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7cc37ee6562so420075137.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294712; x=1793899512; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bEemRG8lYCfY1ttW49wc3sdEhHPWBllIcg9uaL5Ir+o=;
 b=VnOFHhzkNTdIGRPp8fGqDyFjuqo0iBwliXhgUV1jRh6eB90W73wHUzX0SPB1oJaIgN
 K3cplRf7CrWHb3m/kQGyv39KD35X0eiZUP7EiYe/ZryXnUmRlIxLgZBrkE8Tozp7x0ya
 E4n8+WoWMmkqzPmYltcwYmGbJUxODVX/6JAtYCQCL74sMAk8K7dKpwtRGdP8fYDeD4HS
 3W5Mp0yTlcnG/2dp0crd/ZlSOB0Q1LyvEXoW6T9XulnwT12MFE0P3Nyaw1paK4Ro0pGz
 g+EvTjBMUOwqDCakJFvBxFfoWmW6UIT5HoTedunZhWevXW8/cJ6HPgwN8gjuEuboVyEb
 efaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294712; x=1793899512;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bEemRG8lYCfY1ttW49wc3sdEhHPWBllIcg9uaL5Ir+o=;
 b=SOSCnkm86uuoJlSXQbq5w0utfJ1bkTOlCH3BYI13kLJbSkEEoLkw0aShoN4UOXVc2M
 UkIJsUnOfNl2AzPJX+4IhEriQ8NmYQV/p6AgYSWn+5VhKn7cW4R7kATkAHZRsUwLD1GU
 hAi7c8dNUPQcSr+h57sMij0aA56klTR7ngws4snOvSDbLJPqLQjRxx9R4Lc1SyBCKy19
 tJ4z99KvGj3EUbcmUv9tA+tR/VEeVt2Hx9DR22Q3B2Xqk7OvjpIA6iJ30LzBcuMX2ilv
 xLk9gE6eMlAioJ1vuz+Kq1XDrBktkrihndtgK2S9XEx/6DdKDE49WtT8WojAxE5HRVHG
 vvFQ==
X-Gm-Message-State: AFq9FYLEWb9VIM2lT6P4w72GqYSBWSfjZL5WwS+G94u0+iG5lMcK5A8z
 kCD7KlfmaZ3RT6s35hJK4sNDs0eZDMNjaOAhijsP2Uz3c/NP7mfI1FLo5rmEjGnQMWrdUXauh6x
 0dy7GvMDdn59xCIPGg6hpGjaCN3oZdYfOGq4ugVcKSpmjE/2kAHFRfVjdQpcfAfQGWcfj
X-Gm-Gg: AYBFou3HCw/KVrVt/pz86JrfYmomxRFqqI621pntYH+X3134YvuXH5X6z87DjcdwNX3
 lCM41zDG31iQa29cTS9ri52d4F9j7IURPCifa6MQVwThCSL1Q8N+yMTafVgNxQI1JEswzrvZIMa
 w6KaBBvSFur+ETpaaIQ84pbSIS0ucB04HZ8QDjfZv/39TCplKRX4P1eaZxNpsPyRo19mLgrJneI
 2ZYaNDgF5JAnhklAOMUYm0wiyVMTQwGhBZ0zK3rjrDYA+hunXHUlrMdiWFpZ3gjF1zXhkCQ3K5x
 ilS0pr63GVvwibngR0A3g6U9rgRcmNwG1XS2zwZIqsmfukulIqhRLQEEIPn4P9vFHx/7GFMpYK4
 0+5EOYyyR8V6wqmvnWRsEWV4E/BVRsjBR7LOFqpB8npbL6FOh2KwzAG88tQfS1R3L1vkt6+EG+L
 ih42ceuEEHxNHHWeKcm+yhsfcz4iFYLw==
X-Received: by 2002:a05:6102:3c91:b0:7ce:5952:125d with SMTP id
 ada2fe7eead31-7d03a66c67dmr2546629137.36.1793294712019; 
 Thu, 29 Oct 2026 10:25:12 -0700 (PDT)
X-Received: by 2002:a05:6102:3c91:b0:7ce:5952:125d with SMTP id
 ada2fe7eead31-7d03a66c67dmr2546608137.36.1793294711438; 
 Thu, 29 Oct 2026 10:25:11 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df87f26sm460638f8f.17.2026.10.29.10.25.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:25:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 15/31] tests/tcg/mips: Group MSA bit-move tests
Date: Thu, 29 Oct 2026 18:22:59 +0100
Message-ID: <20261029172319.25766-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX3T273Xg4PdB7
 65vIYMOS0ywmmODrFZNbni2GO0GQV7duV9Me/Gk/RSPNQJuYGfBMftTVc9uM0f0G2F63Ily08Qy
 gSZok3uZTJm8x3vCzo/ygCphl3YndKpY4F3q9FR0GliTGz+iupdIfTbMBvU/Ebc5ykPjKkqUuPD
 4ZSZaq1YMYCRjz73yr0+xewCa/f5YTo2Jdxlz67JOaEkghA/4BOhsrGDSUytdn+Zzd4d2rC6iCA
 fYfndnNgN54YQJ6KSGR+P3Pyx0IVdrO+L1RJL1m/X0z5mzSeCnFCxiVQhJl3d3AfABTGCUTv2dV
 CDOiNCB85SoldFueekg3sxAh/QfMzF/QkEqBkyMIPGKdV4ZsQFXLL3EHduf5zge6Vv6KgRsl5f4
 zqn8bdljMInjohhQl38r3CWtE+pyjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXx4nYb8vkOGq5
 sxvKlraU9Tb0gp6474/oxqaQYKNA4JhL+JqlZLFOh9kgqvITAgD0n0UgT4FvXR89f8RMX41A9t2
 mWjFQ4EGdI6wQ03+mAo6q7BjkO+f2AY=
X-Authority-Analysis: v=2.4 cv=LuAHWXdc c=1 sm=1 tr=0 ts=6ae38178 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=U98Yu14etVFMT76BwSIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: DpyWJVWlnmhWVn1IhfzBTJ3b7cBNvStW
X-Proofpoint-ORIG-GUID: DpyWJVWlnmhWVn1IhfzBTJ3b7cBNvStW
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

Build the 11 per-opcode bit-move tests as a single executable,
test_msa_bit_move.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_bit_move.c | 97 ++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build         | 11 ----
 tests/tcg/mips64/meson.build       |  1 +
 tests/tcg/mipsel/meson.build       |  1 +
 4 files changed, 99 insertions(+), 11 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_bit_move.c

diff --git a/tests/tcg/mips/test_msa_bit_move.c b/tests/tcg/mips/test_msa_bit_move.c
new file mode 100644
index 000000000000..4fd41e96764b
--- /dev/null
+++ b/tests/tcg/mips/test_msa_bit_move.c
@@ -0,0 +1,97 @@
+/*
+ * MIPS MSA tests: Bit Move instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_binsl_b
+#include "user/ase/msa/bit-move/test_msa_binsl_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsl_d
+#include "user/ase/msa/bit-move/test_msa_binsl_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsl_h
+#include "user/ase/msa/bit-move/test_msa_binsl_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsl_w
+#include "user/ase/msa/bit-move/test_msa_binsl_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsr_b
+#include "user/ase/msa/bit-move/test_msa_binsr_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsr_d
+#include "user/ase/msa/bit-move/test_msa_binsr_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsr_h
+#include "user/ase/msa/bit-move/test_msa_binsr_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsr_w
+#include "user/ase/msa/bit-move/test_msa_binsr_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bmnz_v
+#include "user/ase/msa/bit-move/test_msa_bmnz_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bmz_v
+#include "user/ase/msa/bit-move/test_msa_bmz_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bsel_v
+#include "user/ase/msa/bit-move/test_msa_bsel_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "binsl.b", test_msa_binsl_b },
+    { "binsl.d", test_msa_binsl_d },
+    { "binsl.h", test_msa_binsl_h },
+    { "binsl.w", test_msa_binsl_w },
+    { "binsr.b", test_msa_binsr_b },
+    { "binsr.d", test_msa_binsr_d },
+    { "binsr.h", test_msa_binsr_h },
+    { "binsr.w", test_msa_binsr_w },
+    { "bmnz.v", test_msa_bmnz_v },
+    { "bmz.v", test_msa_bmz_v },
+    { "bsel.v", test_msa_bsel_v },
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
+               "Bit Move", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 40984e9b4fcf..adf25fd3c5d2 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -147,17 +147,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/pack/test_msa_pckod_w.c',
   '../mips/user/ase/msa/pack/test_msa_vshf_h.c',
   '../mips/user/ase/msa/pack/test_msa_pckod_d.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsr_w.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsr_b.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsr_d.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsr_h.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsl_h.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsl_w.c',
-  '../mips/user/ase/msa/bit-move/test_msa_bmnz_v.c',
-  '../mips/user/ase/msa/bit-move/test_msa_bsel_v.c',
-  '../mips/user/ase/msa/bit-move/test_msa_bmz_v.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsl_d.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsl_b.c',
   '../mips/user/ase/msa/shift/test_msa_sra_d.c',
   '../mips/user/ase/msa/shift/test_msa_srl_b.c',
   '../mips/user/ase/msa/shift/test_msa_srl_d.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index bcc02d955436..b40b7c10c608 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -41,6 +41,7 @@ endforeach
 
 tests_mips_msa_groups = [
   '../mips/test_msa_bit_count.c',
+  '../mips/test_msa_bit_move.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 8b4e665634ab..0a3b84623125 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -42,6 +42,7 @@ tests = []
 
 tests_mips_msa_groups = [
   '../mips/test_msa_bit_count.c',
+  '../mips/test_msa_bit_move.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


