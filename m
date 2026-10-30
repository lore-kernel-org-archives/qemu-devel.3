Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61A60A2601
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mmFgXTnE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=guzKeyEY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMquT-0003yR-Py; Fri, 30 Oct 2026 14:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqry-0000rO-Hf
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:58:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqrw-0008OZ-EC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:58:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu2tU2414364
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mpdKwFVW0iz0VRrdRr5B/JI3IrlejdTTJva5/3O6xm0=; b=mmFgXTnEgY8Btjkt
 lkVtLiCQxU6H1yGOGqum5MN2zuX1inavZ0Fxuh+M+n9e0oK7fw0n4w+q8wND+iOd
 DEF93gH+ehZnZ+VWzDcel+J0oheBdAYBx3IcTPvWftTDDWkifXKDnPrCqaivHikG
 lyuhRN84LURP8nsU0COMG8kOeKp1LGl/U7lJcAvfvT/4Zpqkf+a4Duv9J362Z2kR
 Tz8gyrvIspzALiY5Tn9gk2w1vfJCkmseTEBoYEWJwIXl9LZHcY55/QF6CFm9ArVM
 sKh21hhG9QPNkQoJNspO19X7gYsS5aAqAQ2fCl2fIdYl0OA3z9C6n52tGORm5GlH
 HTD+UA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pmbmg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:58:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c6c1e082bso35337116d6.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383102; x=1793987902; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mpdKwFVW0iz0VRrdRr5B/JI3IrlejdTTJva5/3O6xm0=;
 b=guzKeyEY5RkSA+9KLxnR+4serAV20WNUg8+ektC8ZKJmo4ZNaaC2eTgZCflC6R9cmE
 2fGmWu3cjpRtT9K4Begy8zrATsNmJLWdw54DAB9vttt+spcdoiAps8tMU07Mi5eNyfLG
 o+23TfU+DGEQCPUze4UkwbbSj/1J9jWKNeLO1mhMGms1o6126MExuCSMnOxfCeD40GqR
 sOUN3pGPjkOS3t31zFk1VPq2OdzmyVcudNYCqzdiimtdX6mNhUoudgBRqnLySzPhNf6A
 HDTzBWThQSDqw0WXEC8cZQLiTlpeTaXjstXllVnZiy/wXTY3gCidAALEjyGuVGprMr9g
 PI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383102; x=1793987902;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mpdKwFVW0iz0VRrdRr5B/JI3IrlejdTTJva5/3O6xm0=;
 b=jOyWJ7uQX1k+xVtVkXaz+1/Ne9D5Qka8n25XhXWKu69XxlSGzIMwFwGVkYmDckWFO4
 6/wCAHlZtpnvPflLiwdHw0H/Abl1R4CDmPUVnFd5oPS/ugfVi5h1IELDguFe3CrhKo35
 i8JCyBlzN26ZeLQr4hQSoDr7Wa4uvrm60AuaY6jInGTXAsgARrp9WHc7xcY77bpAuC9+
 ex9mhkTBDiTWmJbM4aTKhsQpz/04kcQPuoWE5rBhb8j8LaaA6ALjy0ztzpgvMxHnU7c5
 kf+xM95DXRkW4oFeJnaywPhETeDXfnYBPxzib/tNcgqKxFcNoZfgH3kCd3d58pVt5RxL
 Fwzg==
X-Gm-Message-State: AFq9FYJTbXLHDhRPivZ71Q/j9+Q0IPXExcUhDa6J2hqLxiNG5gYCbs8T
 z9NWbaDFyvpqDDhBo6duSpYLhGO42xic+IXre/j+ja40Doq9VriFwWK1xGPt+AQxBkj2H4EWcae
 AvblNmwoEu+A7IMGc1c/dwy9siv0uGtccqLAWCyKyEJIvrdn0rJ4BNIYSBQD3EjbltYAK
X-Gm-Gg: AYBFou0S+dpXoeF1kSDLbspybp6oXwe2QCkPdhsw8pTGSnbgSjLtOrKtmWWyc0pqd88
 C8a4U7/3Mv917YzTml/+zM+lOOdH4MSVF6w/yTnCpoBNVbpKE8L17DTvZJMHpg1t2rBFX2wZzLv
 x5DhG/k35DlGHSwu2yn0CjQV/GgNfuFJUOM9yHAUJBIwAXWiElkJnUHzZJZsLJ7Hll5z+I3OXe7
 JtflKugmRQfrox3N1sty+G1b/OsN4Ty64/BMznI5uEPk4JSnRjs8bzymOBYMO4UKPFUT8mY2oS5
 a9Wm/ZTA3aiSgCb4dOxlK1Vg71fFCNbuUxqwvVTH+DFbP7lVZUM6alg/AUYHB6K1TrEWqF0C4Bq
 9MNsvRwQj/NM4dpYxMW+cSspd67D/uw5GRYCXVvZx/p49oAQgSRdoVXe1VazM6Dd+tzo7W7qYy9
 H59bCnFZkDiyygJ8qFncR2394IguhkRA==
X-Received: by 2002:a05:620a:1b9b:b0:93f:3193:ac09 with SMTP id
 af79cd13be357-944133593femr1040458585a.15.1793383101910; 
 Fri, 30 Oct 2026 10:58:21 -0700 (PDT)
X-Received: by 2002:a05:620a:1b9b:b0:93f:3193:ac09 with SMTP id
 af79cd13be357-944133593femr1040454585a.15.1793383101413; 
 Fri, 30 Oct 2026 10:58:21 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b728f9sm4489556f8f.10.2026.10.30.10.58.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:58:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 31/32] tests/tcg/mips: Group MSA shift tests
Date: Fri, 30 Oct 2026 18:53:53 +0100
Message-ID: <20261030175357.99684-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX3dLOQ3pr8PMj
 A+vwzbOdvzLZYWPuYmJOit+CBcj+icpFLCicEjUYBAKSNNn91Tw9eejtfwdhUnIf4UfznNceXtQ
 wQB3Q1G5Gj/NuObC2jSEAYGqikwI4pBRVUYvbS4+QnS9jV3fg9QgCbb6Fpb4nN0nez1sZ7LNq6C
 SE0e65j5qYSJMeBlHSu8gIi3kKl62l3wFiFgcADYFHwTdtJLqgFDlbqkc0xbudyR8oGTKYnovUa
 VhbnOn7KZ7v2vL2X52PkY0eFX7xlabjkCIbOqmqbVgBDJS8EtwDjFrCgjlO/Z0D+SVwwoCaQLey
 4h7UabGGMmCTYZ11YFzt9kwKfhr3Rm18AsZ3WzPsdeVk+XQ81wK7h9orfRGBYMM7wGEQZGI5CvK
 YFiUCcoDI4HJj9Ypv7yFPbCHE5U2Z9+Nm7IBXsAYveHMSp7XYKW3Alw91VUls24pFvn9Z3X8F15
 Z7eeKSyIdRqmHitcQig==
X-Proofpoint-ORIG-GUID: bqk2T4O1XkLZFFLRMg9UjGiy2WFh5yCz
X-Proofpoint-GUID: bqk2T4O1XkLZFFLRMg9UjGiy2WFh5yCz
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4dabe cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=31ySfBESk6nFzokIpWYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX7jS7lt8E7jlS
 sEIGGLBlg3bPrehKuUW603wOgf6GReGVUStN6IHrmX7c+njswCqw13ha6Jz1U6BOwXjVTbGiWQO
 pQJwzJ5R82Veq+5COPp0MQKDS1PBLQI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Build the 20 per-opcode shift tests as a single executable,
test_msa_shift.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

All MSA tests now emit TAP: select it in the meson setup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_shift.c | 147 ++++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build      |  24 +-----
 tests/tcg/mips64/meson.build    |   3 +-
 tests/tcg/mipsel/meson.build    |   3 +-
 4 files changed, 152 insertions(+), 25 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_shift.c

diff --git a/tests/tcg/mips/test_msa_shift.c b/tests/tcg/mips/test_msa_shift.c
new file mode 100644
index 000000000000..14a73d90935b
--- /dev/null
+++ b/tests/tcg/mips/test_msa_shift.c
@@ -0,0 +1,147 @@
+/*
+ * MIPS MSA tests: Shift instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_sll_b
+#include "user/ase/msa/shift/test_msa_sll_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sll_d
+#include "user/ase/msa/shift/test_msa_sll_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sll_h
+#include "user/ase/msa/shift/test_msa_sll_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sll_w
+#include "user/ase/msa/shift/test_msa_sll_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sra_b
+#include "user/ase/msa/shift/test_msa_sra_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sra_d
+#include "user/ase/msa/shift/test_msa_sra_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sra_h
+#include "user/ase/msa/shift/test_msa_sra_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sra_w
+#include "user/ase/msa/shift/test_msa_sra_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srar_b
+#include "user/ase/msa/shift/test_msa_srar_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srar_d
+#include "user/ase/msa/shift/test_msa_srar_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srar_h
+#include "user/ase/msa/shift/test_msa_srar_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srar_w
+#include "user/ase/msa/shift/test_msa_srar_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srl_b
+#include "user/ase/msa/shift/test_msa_srl_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srl_d
+#include "user/ase/msa/shift/test_msa_srl_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srl_h
+#include "user/ase/msa/shift/test_msa_srl_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srl_w
+#include "user/ase/msa/shift/test_msa_srl_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srlr_b
+#include "user/ase/msa/shift/test_msa_srlr_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srlr_d
+#include "user/ase/msa/shift/test_msa_srlr_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srlr_h
+#include "user/ase/msa/shift/test_msa_srlr_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srlr_w
+#include "user/ase/msa/shift/test_msa_srlr_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "sll.b", test_msa_sll_b },
+    { "sll.d", test_msa_sll_d },
+    { "sll.h", test_msa_sll_h },
+    { "sll.w", test_msa_sll_w },
+    { "sra.b", test_msa_sra_b },
+    { "sra.d", test_msa_sra_d },
+    { "sra.h", test_msa_sra_h },
+    { "sra.w", test_msa_sra_w },
+    { "srar.b", test_msa_srar_b },
+    { "srar.d", test_msa_srar_d },
+    { "srar.h", test_msa_srar_h },
+    { "srar.w", test_msa_srar_w },
+    { "srl.b", test_msa_srl_b },
+    { "srl.d", test_msa_srl_d },
+    { "srl.h", test_msa_srl_h },
+    { "srl.w", test_msa_srl_w },
+    { "srlr.b", test_msa_srlr_b },
+    { "srlr.d", test_msa_srlr_d },
+    { "srlr.h", test_msa_srlr_h },
+    { "srlr.w", test_msa_srlr_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Shift", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 8a0ae3cdaeb8..560d07ad6357 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -18,6 +18,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_interleave.c',
   '../mips/test_msa_logic.c',
   '../mips/test_msa_pack.c',
+  '../mips/test_msa_shift.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -41,26 +42,3 @@ if 'qemu-mips' in emulators
     }
   }
 endif
-
-tests_mips_msa = [
-  '../mips/user/ase/msa/shift/test_msa_sra_d.c',
-  '../mips/user/ase/msa/shift/test_msa_srl_b.c',
-  '../mips/user/ase/msa/shift/test_msa_srl_d.c',
-  '../mips/user/ase/msa/shift/test_msa_sll_b.c',
-  '../mips/user/ase/msa/shift/test_msa_sra_w.c',
-  '../mips/user/ase/msa/shift/test_msa_sra_h.c',
-  '../mips/user/ase/msa/shift/test_msa_srar_h.c',
-  '../mips/user/ase/msa/shift/test_msa_srlr_h.c',
-  '../mips/user/ase/msa/shift/test_msa_srl_h.c',
-  '../mips/user/ase/msa/shift/test_msa_sll_d.c',
-  '../mips/user/ase/msa/shift/test_msa_srl_w.c',
-  '../mips/user/ase/msa/shift/test_msa_srar_b.c',
-  '../mips/user/ase/msa/shift/test_msa_sll_w.c',
-  '../mips/user/ase/msa/shift/test_msa_sra_b.c',
-  '../mips/user/ase/msa/shift/test_msa_sll_h.c',
-  '../mips/user/ase/msa/shift/test_msa_srar_d.c',
-  '../mips/user/ase/msa/shift/test_msa_srlr_d.c',
-  '../mips/user/ase/msa/shift/test_msa_srar_w.c',
-  '../mips/user/ase/msa/shift/test_msa_srlr_b.c',
-  '../mips/user/ase/msa/shift/test_msa_srlr_w.c',
-]
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index ebb4006e7eb5..ad69e36d9165 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -39,11 +39,12 @@ foreach src: tests_mips64r6
   tests += {src: {'cflags': '-march=mips64r6', 'protocol': 'tap'}}
 endforeach
 
-foreach src: tests_mips_msa + tests_mips_msa_groups
+foreach src: tests_mips_msa_groups
   tests += {
     src: {
       'cflags': ['-march=mips64r6', '-mmsa'],
       'qemu_args': ['-cpu', 'I6400'],
+      'protocol': 'tap',
     }
   }
 endforeach
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index edb59a25454b..1951c3c437fb 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -40,12 +40,13 @@ endif
 
 tests = []
 
-foreach src: tests_mips_msa + tests_mips_msa_groups
+foreach src: tests_mips_msa_groups
   tests += {
     src: {
       'cflags': ['-mabi=32', '-march=mips32r5', '-mmsa', '-mno-odd-spreg',
                  '-mfp64', '-mnan=2008'],
       'qemu_args': ['-cpu', 'P5600'],
+      'protocol': 'tap',
     }
   }
 endforeach
-- 
2.55.0


