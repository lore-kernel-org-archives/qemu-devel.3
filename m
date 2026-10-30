Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E1606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eIYTySsj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=epYQ+Ge6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqpz-0006xO-38; Fri, 30 Oct 2026 13:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqpt-0006Zu-Nb
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqpr-0008GQ-P6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu1sM839340
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U+DHhcr5Gx6BqM4F1GfoxoVxHm3uq2UsHlTMcsYEsgc=; b=eIYTySsjI/DPYCtk
 zlDSlkdo5TZpkympgrgU8d4jPcerp/6W/0t8CIn6HRs4BaNTa3uLUZSSfP0raobf
 L7nCtC0eTgAADeEAX1FRQx2GXHond3bwlkBj5xsrzDAVWlsA61e+yd41he4h5Fes
 fmn0WagzxJd999lkI7kRi9QPbngyX/uRINZLEOGBIHCs+TU1HvBswHMDP/VshgYK
 XoSl2lyxfMY/Nir90ZMG40mD327q1fkJrjqx6slwPmPOPkLmyz19Qk/tkd+9xX4x
 UCJdiykKVoirAOQE3GNGEbwC9dngkLQakCNslHEs5YgVNQh8PXf+wquQLNEour0r
 KKDN7g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme754a7k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:14 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-99076c676cbso236316241.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382973; x=1793987773; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U+DHhcr5Gx6BqM4F1GfoxoVxHm3uq2UsHlTMcsYEsgc=;
 b=epYQ+Ge6NnFzDXOfwQXA88FDsrkT48bjPXDE4POJhiDZb46RYz4hi6JLYI3faKsVaE
 qL03TDOTEEGod2tD5Apxi/kKgE18HluW3MmzZ+ebpF0TGTD4G3K9HvB0vgTQWVwdDSS3
 n2c1ZL/+x6aBTOzKlaOv10ZUaLY1l46pdVKEDVY6zgRev5GFG4A+a1jF0gVGqang/zyo
 LrbQbDjl9VZqAJyn8qNZKCvEzDYaulHiyQ57+DuIJXTgMI2IgqXPxDL9kff/cMQ5Sg8D
 AhuPzaodTlrW2RwSjXAL64VYcUoZ5hJqG4Qf3pSYskQwMkbUNVjPuIkip8wnJSOp5Mux
 Ws9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382973; x=1793987773;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U+DHhcr5Gx6BqM4F1GfoxoVxHm3uq2UsHlTMcsYEsgc=;
 b=KZV3YPlT/14pq2YAyk1WPM6AZSA8QHqJtjP1mPakujIwx6xIvlcfl0J6cf8Kz6pmox
 S7/UubvjmhqR/i58J6mj1TwRbFBJQTzZmjYlcaHj+oWLVr4Aivw766cf0URWmoquXOam
 mqovcWwwrYGd4oDN2SJI/oq/BdWPkExVMwlgywlyW5gqBvMXT4AZ8Nt7PyqeJlpaZM9d
 VUV/Fohdfv1CEzRPtwvHbQUXb5XidgYYO2wcgiuWOUyLnnakXWwbx8NQPxvM5C38sX7E
 AxPqNZF8lUNpT8sE6msvfZPvkj+1HnEag1uFcRBj4CB7Z0cgA/5rYABK709W1InZnHOf
 rbHQ==
X-Gm-Message-State: AFq9FYItin+K05dwug5VhzfgeJNhqNVKCB7D5qxQyWpvyZFBxkZ3bSvG
 sbAELsP2F2RphzrGOuwo7+hyovI0dq2mcTQyc5pkGsc1Kx8BVOuT9H2lI1PzwBdC+RAKAzo20Ch
 F1Nfr9vB3b+3mjx3jh2kYuMxbGi0eUi0v1s+O7+Ez4zWJAue2+RwjwcSsjHY10lvRHX1P
X-Gm-Gg: AYBFou1+PzcUuXnODg8F92/Bpo5AvdIoXZkAa8G0m0FTYXMqXCj2dTiBonqAaaBXEW7
 rnxKDmu0OsQa0NTqSw6U+Lf4h+128WSLuoqjVrO6FGlbhMjB2WQjGOodUj7C8SjxxHxIEhe9UJz
 0vDRQc9FzwH+RoLMZQfYPtljorRewJLMyoazvMg/YGPB9mM2d3kM2chcygagh88NTPwHsTygvFZ
 cFFprrKgTeIrIYbskfDMegXFQoWM5Hjzb8yH4twH0ypfO5GBiQ3VLivUSmQyL5+BxXBLF08lyBe
 ab6iFiWVYtm/EXues/ufe6V2EjWUzgGzIK8rBppDM9BwNtcjHCzByzGoU8IjC5t/Fc0DBKfHuef
 vqf9qmuapylOHWFUrbL49emCq6MLXvEuwkCnEyiV91x3QHCEdNdrSyhH9Ly2KSMmwCuLm0zEnNU
 qym1cjdeqqleOxAEy9E14VfZu5uVpZxA==
X-Received: by 2002:a05:6102:2926:b0:7b2:7490:fd75 with SMTP id
 ada2fe7eead31-7d072baa797mr1428818137.7.1793382973242; 
 Fri, 30 Oct 2026 10:56:13 -0700 (PDT)
X-Received: by 2002:a05:6102:2926:b0:7b2:7490:fd75 with SMTP id
 ada2fe7eead31-7d072baa797mr1428805137.7.1793382972790; 
 Fri, 30 Oct 2026 10:56:12 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b959c1sm4410211f8f.45.2026.10.30.10.56.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:56:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 16/32] tests/tcg/mips: Group MSA bit-move tests
Date: Fri, 30 Oct 2026 18:53:38 +0100
Message-ID: <20261030175357.99684-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PKSq7Tg6stt8mjQln4ySjW-U99F1wjL5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX1OnvjFEWeJ4c
 PLt69GYEZ1fF/BrIzixPUTfmg//iwa4E7/wc/ZD2q2Xbo8viZzL87uNv0ricBbjn7N50rnur48V
 hDk2EZq4Ti85ADqqj0DfFsI6o9Rft3V8dHPTC/zAq2TJCxBVvQ+KqnYnOTDlKXLhfCJq/JyDLga
 0fchvpkOzqEEzbk2a4xtnBA2HDRpCyh2qVvtvYmcF7s6n7YPGwRRLUl3IWh7HBURFw7RrXLV8RI
 ITaORZ505BdV4ThAli9sS8uaC/ZogMMLvmXlU0qUHMwelg3tLR+ceQmQO90xwf4oMMbf04eVNlR
 dbJF8Qv9COvm+k9JVjy2VyIwk02Gmfu200RDxq0IPE+RNRJxHj223g7/GWzciqlnZozIQXKiTWz
 6HIWnTWKoGSimFb5bGtnLMstl3nDsTuFfi9iA5UW0a6ljfKIxZzwpdAGoQbyIvCc/FkNtYIlDHC
 HH8Rk74kF7UzRNbC/ww==
X-Proofpoint-ORIG-GUID: PKSq7Tg6stt8mjQln4ySjW-U99F1wjL5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXy8SWsxNq1V5g
 hPiOE3CbyPkOnSUV+MXnPRhn/vxVX8gV/Vw7K9HyvHUXTSM1USveNMiZbSdL9kMHY6MnnwfuhzH
 oqHPVOQOYg/LFsWNA7i7ixT4m0iQQpU=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4da3e cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Build the 11 per-opcode bit-move tests as a single executable,
test_msa_bit_move.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_bit_move.c | 93 ++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build         | 12 +---
 2 files changed, 94 insertions(+), 11 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_bit_move.c

diff --git a/tests/tcg/mips/test_msa_bit_move.c b/tests/tcg/mips/test_msa_bit_move.c
new file mode 100644
index 000000000000..02fb3bc486cd
--- /dev/null
+++ b/tests/tcg/mips/test_msa_bit_move.c
@@ -0,0 +1,93 @@
+/*
+ * MIPS MSA tests: Bit Move instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
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
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Bit Move", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 88ec44520377..ae755143c18d 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -3,6 +3,7 @@ tests = []
 # MSA tests shared by the mipsel and mips64 targets
 tests_mips_msa_groups = [
   '../mips/test_msa_bit_count.c',
+  '../mips/test_msa_bit_move.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -152,17 +153,6 @@ tests_mips_msa = [
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
-- 
2.55.0


