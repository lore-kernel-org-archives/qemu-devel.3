Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2D606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JcJvF3ra;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BePrLxz2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqrC-0008RD-HO; Fri, 30 Oct 2026 13:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqqC-0007pH-7j
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqq9-0008H8-UU
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu0dt3977374
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9BQjzX+azq2orh3caPQpg5u7CALnO/bV2U9gqPrzxVI=; b=JcJvF3raYpuXj2ru
 ROIzHffay/brM8LZBR9XKVNwdgfCuocCx3L4iGq5ykX8DBiIUk/md9R98I2l34+e
 a1U+zHqoclu+i4quS3Ypi8pUm0Zh5ZtfAwo+gVwEokR62FuZA9Fb9B96Z7QOqfte
 9WYU0wXoFtJdwBDt9p5EsZYzjQNIqxHyQtCVqNH3BA76egtIeN4GQMqIA/MTYosO
 NashdwoBWzMNox5xBA1ama5xuzBklPn6y/p1PAcfV46q3nguQz0KNey8zByrh9nk
 /nFV1FGlw5uYi1YwbFqfx9AqqvN1ftDuKwvZ1QL24uubzUzisfsYWFJBGNBe30ok
 Dhmz5w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmd15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f20addba1so182189085a.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382990; x=1793987790; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9BQjzX+azq2orh3caPQpg5u7CALnO/bV2U9gqPrzxVI=;
 b=BePrLxz2r/znPoTwTuv2PGiB7f9A11wNmwh5ge3g7YzOIaE8wc8zVixJd0zRxrk+Jr
 keAojHrpoisuqvozA6OEut+ePxSotJrXv/jl8+A1MzbnFAS1oj0cVW/2kD0V7HZAu5wO
 2dS8mzi0wqjezKvP0TQtd4Sd/Cm/cD8a7cHfUW96EPwyVTFJ1EpPs7IUXHL9JOZui2TP
 y9XAEw1N55O0r7qjP691oj+tC6ioExHmXJUFkkNEtAeCITv9DkcGxHQhKxqgChBuFwC6
 XnKC4AZRTGq9wqgT4aVIvSBwM8oZ1hvWc+o6vFRLcPlbolUCGti9dcQ3wbpWMUvt99Vc
 c+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382990; x=1793987790;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9BQjzX+azq2orh3caPQpg5u7CALnO/bV2U9gqPrzxVI=;
 b=nef/QXP4Zywczr0RwO5OzFL189F3YLJ04bAlOe2cT/VGVrg8XLhL0uuKKGr8jwQ7RL
 1cKBpjf/M/WCp0SRL5LvixnFyS6ItVUWHr1jad1Th4/ishg4AIlg9jiXlbvc8ouo+MEj
 jvgPOtvj8THM3+7+yb1GcgIKQGNIUoyl+wnhLrliYxJEdnWgbmE/Jpqdl+loOdinVyAa
 ayb0pqcdVwYHHUYXcps4VpD3zHTgOTse6Bl09m8KpEwwgjrb88RQ1J8FOqSRdzxqIibi
 Julo4GuGB97aPfmH8nVMp98WoAC+jX9Vbdd2aIQL3DdIjCcIfdzwU+F0y1yOAL8hZGXv
 +HTg==
X-Gm-Message-State: AFq9FYLMq/w0R3rdoSVJBLuii9s8nIYCgPo5haVYi8SfZ1RVFyefGdLF
 taWs3C33hnmETrLcqMCvFRmv7XZwpFknVM5MuvOwqIbQYpWEyh22tzhcA87j5vD0OmsqJswGhlV
 3gqVeFLo2gBKUAH/ubh8IaM/R0qTlChNN5uYJgilv4oWXpJTOzl/LVht5fDkCwlcuE6a3
X-Gm-Gg: AYBFou0+abCnJN3ZiFqf3PTSW0xiBpE+CERApZGuLYKRKDrJ8QZWyINjXkFAC8ge2eB
 ck1zyTlSjcipso3OSNVEJAmr0B64Tlua05BddWGVqGfMoesglrOlpxG46yG9OiqCqCdf2ekZ9Hd
 PUjPTUWrBGN2GhX9JmHIWTOP4NJZE+73zd2r/6bgizfzCcrgKm2elPeAs2c1Tiri8kS0pNRbytg
 wGaCp500+NO27halG7WxwQ4flDumRQ0x74oQ776aOYFkss6W0fmjZSUxzS+645hxz/Xzro5Uy7U
 dyqtYjLALcpyOLp1Z7P8tReqfil1fZZKCeQEGLz0+HeXb2f63WWnWTAxhmcHX+e8ZDJohq2kRuw
 Zz3tvYkGnkohJSng5Npf2DROa5aobWgMziqvyabMcT/P5ZCK3KsVpCCaQAzEm5EyNbXWUktBBeY
 Cvobu+v9j5+7Tl+HxQDFd8LyNW92eDXQ==
X-Received: by 2002:a05:620a:370d:b0:940:f53d:5eb with SMTP id
 af79cd13be357-9442173ea2emr548831285a.35.1793382990363; 
 Fri, 30 Oct 2026 10:56:30 -0700 (PDT)
X-Received: by 2002:a05:620a:370d:b0:940:f53d:5eb with SMTP id
 af79cd13be357-9442173ea2emr548827285a.35.1793382989879; 
 Fri, 30 Oct 2026 10:56:29 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa820492cesm164637155e9.13.2026.10.30.10.56.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:56:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 18/32] tests/tcg/mips: Group MSA fixed-multiply tests
Date: Fri, 30 Oct 2026 18:53:40 +0100
Message-ID: <20261030175357.99684-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cKbfyRnnnqkiTT-QS_O_s1XggO2noBM7
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4da4f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX1LicYV8ZjZeS
 ItHYo8YX+u8ZmEoiRhQ3q/enE/HgGn/67KOpLTNV9V+iUriJOMRGw0t/bkHiLNrpZW5oNc6D052
 lrpKKMhcuhY8xhPwieAVvq3CO/4vrp3YdF4p1BMgLGXF7eNQWhCl/3LFb4+RFv++Sp3Nb5TGXTG
 17ifvusNNzjEM4eH9LlLTOm+lk0cuGcXpW1tS9wXnHsn0odTMX17WavW8ZIKfOGjNMZrjaW4cMz
 PwFOycRBvr7wWt6gUS0ElefiHcogauKbpQzF1IpLoSddhOJx19simceeYn4LvzN3Gr3MaplAIZZ
 GGaK7d5CkDP6aJW9R9OLc7ClEVUmh/SQHhEnJBNeS/VKld2cil4BmVp5ffvXZERpYz+N58DlogA
 uO5rMgitXvU3osUXMwOvBEoyMAo/O1sEkGEteDNMcopsAsmXpX+nugHbJKDnpAqIa1r6ksSIkNS
 LI+DXWnZY0NGTToTz3Q==
X-Proofpoint-ORIG-GUID: cKbfyRnnnqkiTT-QS_O_s1XggO2noBM7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX9InGbuUc0S/y
 U5bN9Hn2e6id0aoT4lNwjBuOwZK/3+D5K6LN3sBCJ07cQIpah2kvVVClCl5wZXgcE+GjO1Zv19B
 iC7JlUsGK9re/7sWd48QUf0DxPb6Nm8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
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

Build the 12 per-opcode fixed-multiply tests as a single executable,
test_msa_fixed_multiply.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_fixed_multiply.c | 99 ++++++++++++++++++++++++
 tests/tcg/mips/meson.build               | 13 +---
 2 files changed, 100 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_fixed_multiply.c

diff --git a/tests/tcg/mips/test_msa_fixed_multiply.c b/tests/tcg/mips/test_msa_fixed_multiply.c
new file mode 100644
index 000000000000..7eb5bfe1b539
--- /dev/null
+++ b/tests/tcg/mips/test_msa_fixed_multiply.c
@@ -0,0 +1,99 @@
+/*
+ * MIPS MSA tests: Fixed Multiply instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
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
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Fixed Multiply", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 03f3ce57d3cf..17e3fe3e55ae 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -5,6 +5,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_bit_count.c',
   '../mips/test_msa_bit_move.c',
   '../mips/test_msa_bit_set.c',
+  '../mips/test_msa_fixed_multiply.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -199,18 +200,6 @@ tests_mips_msa = [
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
-- 
2.55.0


