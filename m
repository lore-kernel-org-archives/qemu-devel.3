Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A384606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WXEP1foQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PWuia4Vn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoB2-0004XJ-8Q; Fri, 30 Oct 2026 11:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAx-0004Cq-Je
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAq-0007X4-P7
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERBmR2494579
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ka9NepUS/T16sYjS22/BcE7c4UjpSbWQrADWR0F4DX0=; b=WXEP1foQFNuf1+cL
 XcTpXYbA+PsPI09k4f1ltAPkBC1qbAh+TBAWU2wlUQ7uqhN1yu8afD+1fXzT4YA0
 5SS4/UqUla1ujeTKuDq8ajgfOGYbOSkIUQ2y6JNHqUT6nboo+CYPkIq5yXK8uHF6
 EanAbMvOo2KtwWRUoHCavqdaZBwHjUZGXH6lVSKTlV8yUfFX2UbrOzTc8/7IBXUZ
 GeTUzDxH+q7VxXwY+9wTn8fuiUGu5Pqz7f/KoQVgHr6pAK6VwWJkn/Zw1k2hgOFJ
 5SodJMSPotwgZeV+FkSvZMb4zVlFgacLM1qfl+zRNKDz7ro5YpLZjij6vhkSsmtg
 ti7ABQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p3pt6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:43 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5ec17386b57so779636e0c.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372743; x=1793977543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ka9NepUS/T16sYjS22/BcE7c4UjpSbWQrADWR0F4DX0=;
 b=PWuia4VnnR0qv3Er5EPjKjQdGeIe/p+njaXpLaP010ZdO7C2SNmT5jFVjKIEToxjnD
 FRMoBISqpcPiRG2cDM5bovEy2TOuXLmuZDDSLoA018rWy9kgCa2CqXba3i5RsdW65+8R
 kRufJ6WaHIdIRGidrU/dDOYdlyv30jBmFqWtzTeW1dttk7hivcxGzj8krwUSg9gPCkN0
 3CNFv940bycYHXwtHjQaUHQwQvJIA6YlFIhEL5cajffIOs8OskLAoalU0QdM/iwfdVrr
 sXUXo02ml7BZrr6k6FzcCCZTXVRkflWzc1/tRFq1SjJhpRSAcufCo4LP3SR7TrJ6MCPo
 UjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372743; x=1793977543;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ka9NepUS/T16sYjS22/BcE7c4UjpSbWQrADWR0F4DX0=;
 b=pcB6MNa8elMuYlbx5Usm4jpbb6WsW5ca6gDb9bP/eiq9tNPL6m1zACUnSo8fogBIoL
 XtFN+ea3x2X1/OqFKi6M6imB+JKnW4shsMVcbOXHKg1pGYgYgukrRoe905g63QMP0Wa5
 tZqUTRvnIXg6rA8H0X3DgGeE2KtSgaBUcpB2TWTQ343ieIM4iASpKZbE4PtAkx030kan
 BjbzIRmKs3A1Ys8iPep6C/xoaDgTEvAoGlZ+tLnpLPAhcK67qKPB3mBFmXTWLyhmhac/
 xfUM4xiQJIDAjiQHR+Y/Tw3PDZ5UZJyXL8NpBkyTajcQFmGO1mQ2U3PVXXYY6dEGcoh+
 XYXQ==
X-Gm-Message-State: AFq9FYKS9WKmQSngdGRCt/l+n5uChFRUjkCbL4siXPYF8Cg26F73APl1
 k/Pn1Y5q0k5mg7Kkr7WfBFzLl+RcsF9My0LUBsP3K0L/uFCDayoaY1ouk1MxsI4Wt7H9LSA63hu
 z5/vxuGPsqxWwBectpXMzNRLjSazFjn52TDrF4pl9hn97PT58DQWthWzGYnxvlbA77bYx
X-Gm-Gg: AYBFou0Ny0/Ua288AhYxwtLhkgeb6jNwxdgxakx0FfCJwja1xn5ZrQUjPvERPg8R6Ib
 WmNCzemjjA5jjrEaTXpoBRySWJCGD5/ZIQkbI63IEFE5MooXwuEagBewwFSuniQ+OZMe6RhPKWv
 1iiwyx8qPsnxbUN29F6bi3nSPEqG0kPIhzbJIVsF1TNDecpuE1Hmhm3hxS0OOyJgoJgv6xcDYL0
 JD+c5BLE8NLTUrIs3Yjn3xphivZfd6YDoQ6Zyes70SAadqAwYnI8nfBfT61ro7Z7aypoaLDrbpm
 BKBVOyQoOTNV5bAqfypVIra4oCbHoAMN5PCNshTwOi6civiLatoyOmeSqPZfvJVEYX3wRbRnz6P
 mxXf74Qe86FrmH448wFCkaqPk5YR8Kvkdhnx771dxvM/trUsEqvnwQfWdjnj0HbOtLkRUBQK8XA
 SGNV4zde4bKE5ETf9P/JXIuH8Ycvs3tQ==
X-Received: by 2002:a05:6122:c89:b0:5c9:c60e:3a48 with SMTP id
 71dfb90a1353d-5ec689f696dmr1558020e0c.20.1793372741220; 
 Fri, 30 Oct 2026 08:05:41 -0700 (PDT)
X-Received: by 2002:a05:6122:c89:b0:5c9:c60e:3a48 with SMTP id
 71dfb90a1353d-5ec689f696dmr1557802e0c.20.1793372739191; 
 Fri, 30 Oct 2026 08:05:39 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a5a7sm3718535f8f.37.2026.10.30.08.05.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:05:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 25/31] tests/tcg/mips: Group MSA int-multiply tests
Date: Fri, 30 Oct 2026 16:01:55 +0100
Message-ID: <20261030150202.61556-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX1u7MiF4zjSbb
 9Kalc2zdsJ2e2lcjLZJgaEGoDMYzBxjQZlVDnCO0BOc8Sg5de1hGwFkX8Iw6KPpYAN9wJBirhaZ
 Sdhdn8zsrMMOfCR2unKVQvSxyFVBP3cUnA6jTlEOYuStexnxuxqDfBohFfvTYmwR7w3mWZdSjQV
 58M9o0eYdfm0U09e34x7wP89YWIIpLGdQ5cTGmwTTC7IINyHQRyTfvGlZGJ88vRj4I9Dc7ntZoX
 rq6qy3uE+5rI/7pAgONQNx7HCgvtkPdqsp2HJ1SZFzekBC91NmeNUtQw23yjhwB0MziBj79QDnm
 3WrW8fn7ViX9m9+xBnTBwAY3cuj2P/V06i8BLzI1Rha8vzi/tPQIEb5/rD9wSQfru+k1cZtxniB
 cVLpLc94PzhUwH59P/K6/WdzMe63iGZijTzt16b0d5IpwVCuiURa3d6/7GIkqpEtTKGGFtZ95gj
 Nv77j43QOgXFZRU0FrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX4YRLbOw5uz/R
 Mb7H/NZ9AiIiaI89t0RXGYx1VUuQgUeawUQZTe/lfzuBTo2bwwFL+K2YMlfsO3R/KOjWNEQEU1N
 eGRp43A0WgNzMbBGk3aiWuJo95sTAYQ=
X-Proofpoint-ORIG-GUID: xOhOmDezVoyHnTFB2JL3ksjIrIRscRlB
X-Proofpoint-GUID: xOhOmDezVoyHnTFB2JL3ksjIrIRscRlB
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4b247 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300060
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

Build the 12 per-opcode int-multiply tests as a single executable,
test_msa_int_multiply.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_multiply.c | 99 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build             | 13 +---
 2 files changed, 100 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_multiply.c

diff --git a/tests/tcg/mips/test_msa_int_multiply.c b/tests/tcg/mips/test_msa_int_multiply.c
new file mode 100644
index 000000000000..ce8ddafe8776
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_multiply.c
@@ -0,0 +1,99 @@
+/*
+ * MIPS MSA tests: Int Multiply instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_maddv_b
+#include "user/ase/msa/int-multiply/test_msa_maddv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddv_d
+#include "user/ase/msa/int-multiply/test_msa_maddv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddv_h
+#include "user/ase/msa/int-multiply/test_msa_maddv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddv_w
+#include "user/ase/msa/int-multiply/test_msa_maddv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubv_b
+#include "user/ase/msa/int-multiply/test_msa_msubv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubv_d
+#include "user/ase/msa/int-multiply/test_msa_msubv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubv_h
+#include "user/ase/msa/int-multiply/test_msa_msubv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubv_w
+#include "user/ase/msa/int-multiply/test_msa_msubv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulv_b
+#include "user/ase/msa/int-multiply/test_msa_mulv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulv_d
+#include "user/ase/msa/int-multiply/test_msa_mulv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulv_h
+#include "user/ase/msa/int-multiply/test_msa_mulv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulv_w
+#include "user/ase/msa/int-multiply/test_msa_mulv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "maddv.b", test_msa_maddv_b },
+    { "maddv.d", test_msa_maddv_d },
+    { "maddv.h", test_msa_maddv_h },
+    { "maddv.w", test_msa_maddv_w },
+    { "msubv.b", test_msa_msubv_b },
+    { "msubv.d", test_msa_msubv_d },
+    { "msubv.h", test_msa_msubv_h },
+    { "msubv.w", test_msa_msubv_w },
+    { "mulv.b", test_msa_mulv_b },
+    { "mulv.d", test_msa_mulv_d },
+    { "mulv.h", test_msa_mulv_h },
+    { "mulv.w", test_msa_mulv_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Multiply", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index c10d4e7342f4..0f4d55a2f26b 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -13,6 +13,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_div_mod.c',
   '../mips/test_msa_int_dot_product.c',
   '../mips/test_msa_int_max_min.c',
+  '../mips/test_msa_int_multiply.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -72,18 +73,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c',
   '../mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c',
   '../mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_mulv_w.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_msubv_d.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_msubv_h.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_maddv_w.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_msubv_b.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_mulv_b.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_maddv_d.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_msubv_w.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_maddv_b.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_mulv_h.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_mulv_d.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_maddv_h.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
-- 
2.55.0


