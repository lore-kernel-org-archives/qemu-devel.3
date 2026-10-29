Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FF8606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S82X9wA5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q2WKEVcd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTu4-00014V-Rt; Thu, 29 Oct 2026 13:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTty-0000c9-8x
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTtw-0001bB-5A
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THDjE1182196
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ofIjv73xhTsozr1VkUHDrrW8LDHqdmheJwwPk1ym7G8=; b=S82X9wA56DXpmanR
 ZK0IzkRXS3MuCcCZn8WnEkyDq6NDi9aKp3+eWP1XyGmMM2LlqYp3de0jXlWMsm8x
 kSLhjKdi9quHUOQ+79Sk1RyosKY3Z77HoKxTNPUpkzBEa3iu3OjtyNBQ3AfxO7NM
 TMKLmn+gIR0m1Pr6A3WEj1reyIvOCoa/sg1YZQFAdcZJRYQe1Ir8OSzNHRVdXFos
 eVQ24wCs38f062CyLPZYadR4QRLaS3J1FuqZ32r8A7kPnTS8mq0nZCpBVnm+vtTX
 Yv4RT7G71+r7ho3tCVs1KQzieW98z/l/jkQ4QdKD9X79QqucbugI1XR5Uic2pVJz
 8mZYyw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmac0r274-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cbf2fd504so401602885a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294814; x=1793899614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ofIjv73xhTsozr1VkUHDrrW8LDHqdmheJwwPk1ym7G8=;
 b=Q2WKEVcdJ1S+miGA2eAfIwYQXk/tGNLsfJiAXLXCMTfBFDZccrz6/eeborjWXW1OOs
 EBP/y++/RH621RJDXxRTJ6yU7XyX7++T/ZNilvAbfQ/ZIwDwLld1l4YMleCdcL+QfBfR
 qjAlYVDYzm/2oJAOuNX7nUcAeP7MrgCk9HakSxQ5mml8wjpQ5Mf6IqoK1JQ8MsuaJK2K
 MgPvy9G+iEKXpSEHzIAlVnYMdFfRn+n7z7Tpq+A6TbC+K8DPWrQmog+46O9GUBk2HcQU
 pckoTRESebTIEvFL5w00g/mmbbtpebeUtlvS614slSQCnx9wciEevShrSC6xLuk+ubaA
 4etA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294814; x=1793899614;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ofIjv73xhTsozr1VkUHDrrW8LDHqdmheJwwPk1ym7G8=;
 b=B4CV+fiPKoNElJgVK7cY4sVv0RErmnEmAEA3etTGwoTuFEbb7p7r0foLMy9tVr7q6D
 3uydFfZDbCIsKvW0wiE45enWCI1H4SXjiN3ricjyA50ApVF99drkAtVoJhZT8lXUN4tN
 WW4swJOKiQvLwTGLPP7Jv3/BTe4F9RH/x9/e/On9FOL5mG14WWL9mzeDJIxEw2opDgfL
 uu93zJwXCwYACkwpN/r28qap6DoA2VjtqSi6LCVyjKcJaqcbNpMJPuF7pSy6FoCcLeJ3
 SPcmm+50gW6d5oyos22jir6PVM7Ks1OFdYfTBzz8dAriL4uoEgE5N1Am+quVa4aWl8+r
 XT7w==
X-Gm-Message-State: AFq9FYKVVcrGIa809E/yTi911mSVGSWh7OUncqKWROcqYtVdoQedq2Zu
 Xpy/M9x2UREhcRM8j8G+seNEcHx6OVoEUNiMoFLa4+qNWmr5Y2ts+IrJGcygsVO+VLOzk7degRa
 p4GgtUkXWA0UJ7jlc2bDlY8ymrXtnrkpMQ/BYneJ4k9msLZD+sy7ZUTycAYabUgwcGP0K
X-Gm-Gg: AYBFou1o7q9oLfpjoTrDBYJJEN2LXVygYtOBOfBhQ3YEOU/VFhEoSyAlK1vy6rXhOrZ
 RYyqswQVVCTmDMZdH6Q1ggV+sqhpsIHyLVh1y0taD+h27ObIa7d1iX3vbO9LczIWiPzA+RW4SnR
 WUas1FlVR5U66mGGg4S+2/FYxAAt7WiAu6hMYXI3WYQIbm42xipuskpdcmBfCMVDTybitxxPBD5
 Jb663lVvfUcq9sFZcrv/UGzSOgBg54e+Y+e6lwK+ZHfNoNbdbkRRZ/nxY9ZfIPDFKL5c51iwWVw
 U489jix847dNKRjFN5/LdX0u3VxsVDjadLjkVxfiz/6he+eDGcyLDakL/3SaooevriSd+uxsgnw
 tqi6uOU/LJFUaG1oGtL1uXlxuHLzq4qEPLkUNMZfn7ZN2Y0d4/c6Vq7xL1ViZutecgWj7WRKljS
 Uty3zUsdol6YOAVzgVfoZRlVUSpfiUlQ==
X-Received: by 2002:a05:620a:2a14:b0:936:e18d:763d with SMTP id
 af79cd13be357-9440896dcedmr971521585a.8.1793294813510; 
 Thu, 29 Oct 2026 10:26:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2a14:b0:936:e18d:763d with SMTP id
 af79cd13be357-9440896dcedmr971518185a.8.1793294813137; 
 Thu, 29 Oct 2026 10:26:53 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f3229dbsm77519005e9.1.2026.10.29.10.26.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:26:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 29/31] tests/tcg/mips: Group MSA pack tests
Date: Thu, 29 Oct 2026 18:23:13 +0100
Message-ID: <20261029172319.25766-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZlZZD3wwJx2YsHStR_lJKFwLI1hj3n0s
X-Proofpoint-GUID: ZlZZD3wwJx2YsHStR_lJKFwLI1hj3n0s
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX3aYuYIEm2umI
 NX2utfq6waDjij9803wckweO2rVhmGWdrzvehcw1uqhPr8c5Mym7uVITIGlbpknucg2T+Jgpq3t
 4w1HWhHJ9lP/vuO7o47bOD0OPLRt/sA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX6VbS59PVdTP6
 ViS38bI39PjMFxjaumAjrtpQp36BW+qDGGHqY3KMoIIVLETomPZtKKAH1tzu8H46lp/YwkM3C0K
 0MaVHhwsFqaxGotW6v6UtE50iKVgUazxG3rh+g7wRRVsBY9IlVGtIAIBD7dGy1YZdti1mntJYXz
 s5CUKHb/RL8MnAkHnuJwaOwRROn99qjT8ckVPhdHC2/PcBbN9sK5aC7GH+orA0BRvt1vB8K4NRM
 ld9Ojiw5xM4lcR4i89bBfz5GwRa0UMoHQl+QFQJViGIOKVROTpPt669lqLBFwrVY8atFYeuvIPQ
 j3fZ+CypdbQy26gxfBawWG9Ck/uBRZs85vLRCQIAynt92dzfqkP35BS5z7Cap29+ZpCc5mT4+mM
 Q6xN5qL19DKliGuDLFDvbN1ltbktdKMhWvuC1fX5dQsl2l8OYdkC33c0lFOwOmiPyXDK9DOa0LZ
 VK4wyYxzvaRIlVmxUDA==
X-Authority-Analysis: v=2.4 cv=I6/w19gg c=1 sm=1 tr=0 ts=6ae381de cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=sidiPtGJcMptBKdm-6cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
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

Build the 12 per-opcode pack tests as a single executable,
test_msa_pack.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_pack.c | 103 +++++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build     |  12 ----
 tests/tcg/mips64/meson.build   |   1 +
 tests/tcg/mipsel/meson.build   |   1 +
 4 files changed, 105 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_pack.c

diff --git a/tests/tcg/mips/test_msa_pack.c b/tests/tcg/mips/test_msa_pack.c
new file mode 100644
index 000000000000..67d286d45788
--- /dev/null
+++ b/tests/tcg/mips/test_msa_pack.c
@@ -0,0 +1,103 @@
+/*
+ * MIPS MSA tests: Pack instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_pckev_b
+#include "user/ase/msa/pack/test_msa_pckev_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckev_d
+#include "user/ase/msa/pack/test_msa_pckev_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckev_h
+#include "user/ase/msa/pack/test_msa_pckev_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckev_w
+#include "user/ase/msa/pack/test_msa_pckev_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_b
+#include "user/ase/msa/pack/test_msa_pckod_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_d
+#include "user/ase/msa/pack/test_msa_pckod_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_h
+#include "user/ase/msa/pack/test_msa_pckod_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_w
+#include "user/ase/msa/pack/test_msa_pckod_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_b
+#include "user/ase/msa/pack/test_msa_vshf_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_d
+#include "user/ase/msa/pack/test_msa_vshf_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_h
+#include "user/ase/msa/pack/test_msa_vshf_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_w
+#include "user/ase/msa/pack/test_msa_vshf_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "pckev.b", test_msa_pckev_b },
+    { "pckev.d", test_msa_pckev_d },
+    { "pckev.h", test_msa_pckev_h },
+    { "pckev.w", test_msa_pckev_w },
+    { "pckod.b", test_msa_pckod_b },
+    { "pckod.d", test_msa_pckod_d },
+    { "pckod.h", test_msa_pckod_h },
+    { "pckod.w", test_msa_pckod_w },
+    { "vshf.b", test_msa_vshf_b },
+    { "vshf.d", test_msa_vshf_d },
+    { "vshf.h", test_msa_vshf_h },
+    { "vshf.w", test_msa_vshf_w },
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
+               "Pack", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 843031f6c0b8..791ac5109607 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -23,18 +23,6 @@ if 'qemu-mips' in emulators
 endif
 
 tests_mips_msa = [
-  '../mips/user/ase/msa/pack/test_msa_vshf_b.c',
-  '../mips/user/ase/msa/pack/test_msa_pckev_b.c',
-  '../mips/user/ase/msa/pack/test_msa_vshf_w.c',
-  '../mips/user/ase/msa/pack/test_msa_pckod_h.c',
-  '../mips/user/ase/msa/pack/test_msa_pckod_b.c',
-  '../mips/user/ase/msa/pack/test_msa_vshf_d.c',
-  '../mips/user/ase/msa/pack/test_msa_pckev_w.c',
-  '../mips/user/ase/msa/pack/test_msa_pckev_h.c',
-  '../mips/user/ase/msa/pack/test_msa_pckev_d.c',
-  '../mips/user/ase/msa/pack/test_msa_pckod_w.c',
-  '../mips/user/ase/msa/pack/test_msa_vshf_h.c',
-  '../mips/user/ase/msa/pack/test_msa_pckod_d.c',
   '../mips/user/ase/msa/shift/test_msa_sra_d.c',
   '../mips/user/ase/msa/shift/test_msa_srl_b.c',
   '../mips/user/ase/msa/shift/test_msa_srl_d.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index fffbda7750ac..f18ff8153f2d 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -55,6 +55,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_subtract.c',
   '../mips/test_msa_interleave.c',
   '../mips/test_msa_logic.c',
+  '../mips/test_msa_pack.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 7ba88b2aac29..277ece3e306a 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -56,6 +56,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_subtract.c',
   '../mips/test_msa_interleave.c',
   '../mips/test_msa_logic.c',
+  '../mips/test_msa_pack.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


