Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F460A261C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i5FFtFIn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e8+UKFLj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqtJ-0002jr-Re; Fri, 30 Oct 2026 13:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqrH-0000CD-SG
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqrF-0008Kp-FU
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:43 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu2qr2414338
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ka9NepUS/T16sYjS22/BcE7c4UjpSbWQrADWR0F4DX0=; b=i5FFtFInIHVi8/ij
 PcFixFmZzaL8MpxrLfbDlVN3PaSNgkJcB92bgQC+6Ub7CYjpXRV3K3mHH91yAttY
 fn4ASjKQ1IEXLpmaXsYfoKwt7lxtZQG5kPVV5bCiCmmGYyKGEjqnSy7v5Qlc+w5A
 LF895w/Ww9p5tlvtFPNQ3TOStUQT6itGpjW8xloE+2bf/BcghxcExbBt9gRLCV1E
 GS9FAdP3HkSUjWZQbod23V/xRjEm4kxQn6S16npapUl2PHdWWywwU3b/iD8nXUKg
 FWdBDQVRgLAmjaGtzGrHPn2MAgKTwW57ogldHNPcbABdpfCBtin+frZxCB8e0Vc4
 xNIBXA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pmbjm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb93c874bso401302885a.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383058; x=1793987858; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ka9NepUS/T16sYjS22/BcE7c4UjpSbWQrADWR0F4DX0=;
 b=e8+UKFLjERgRyDb2bFN488dN3SYlqYTXj5196qsehAxijRdFM6X2o+R2ezu7nmAyzO
 w5BTw6eLf06ydbbXAzDtM8/FKfWAbKlR2qbJ+1oY6QMM0m04VfO4StH316SngAJtiltn
 qZA+QqvHm76Ya6eJ4O2R8mu1ZQGp5/9Mgeh5dUCTXCbX9x3DlAG21f9vj6xjJRmUncY2
 VBG/KdfJv3zLdz5rQIKzGkN5ozMYt7v7FMTqh8Cj4Pucy8Wy+pU9B5KWCNjlaWpUB2R9
 QjYRskxKpSjUcjHM05cKTQ0tqd+Hd9JrSHo1kWS2KnbWVdVgXfsM1mQPQK3nglgPvheJ
 NJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383058; x=1793987858;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ka9NepUS/T16sYjS22/BcE7c4UjpSbWQrADWR0F4DX0=;
 b=xGzwZDbtfKVR+BjDipiYqBc2sgOOvkkAAiNH6dLLRHDMheF3adeCyynjwzQlOvB/iJ
 B1EpaDUhfvMLQnlqUycSxOSTG2u0bknwyJ6dtTTv/bWA7iAhqgzfmF83Xd5Sj+MSoPAH
 4LAFgUm+pcQ55160vAtoC21PDAn1yyYqOy08wAMsqN4dAwYtHcosrG9DBp5WtR7aMMbc
 QCR7nwgFugLJOyoTIJCwrxKt94FuYhTMSlm0C4ZdaXITZLw4Xjrb/CJqxJpvyYC7UOiW
 Zgb9ayPdvaxENO1TGRR77sKVdfZ2c+PB/lCATpdHpq1s9VG37eWIyiXEYt00jiidKgrk
 B4Rg==
X-Gm-Message-State: AFq9FYJI7/Q+YxgGWL3E06Ke6FRPZJ6ul0w8vbOUb4VGwp6wKY4pKe3D
 t6ZTIhtUgdfrwmKCUK9ASJNZ8XhQOEP/RThNp6PFtre+J6R1PAW1DK4R2jOnS9fIwvtJylE7Naw
 E69YwzHLw8UnCPK59CYP2bWnbaIZKtpPQ6icnPzEuzz40fR41P3KEaK6Eovv4da4uDp6S
X-Gm-Gg: AYBFou00ATWe2OUOxOWPpl7UWFhCLNuxF8yXobaVKH2JxhAOmWgO0fW2WomEbl1HSmY
 RblXruOJeaRWxErfdJsl7Y2xY+lkPdyQc/7eRPiM3rxUulYcnngO/CfUcpL2Z8vL22qRwJzK6w4
 KTqWQU+WjwSwEexUc7YpCpd7/GpbM6uJKzh+EI3/02TnlMkjS/rzndZrP0mWJTXKtmP7AvLTK0B
 xysn9E774atLdxSGkGssac87jfmXGPl7HQJb6MCDxIVHrdwaTSeJ++PMJL2oHZtt/wZGrUs7saA
 6AY7QfTPRXcq/1UEWbNoR3wyW49FiPyigSeUUi8/vEtmnJuhUb/DfBS3Jf11RtB1OeND5gIDfhG
 ERREGmPsB4CAf8nin4+9ys63+PSNe50qsskp+RWlgegbef0OPVN3xJSLVk8jSrhO6umYzAQJyGf
 8NvLfsE1Tk1v0RSO9AirorGfbYeiJPjQ==
X-Received: by 2002:a05:620a:1a19:b0:93e:e111:2778 with SMTP id
 af79cd13be357-944133591eemr1007271585a.14.1793383057994; 
 Fri, 30 Oct 2026 10:57:37 -0700 (PDT)
X-Received: by 2002:a05:620a:1a19:b0:93e:e111:2778 with SMTP id
 af79cd13be357-944133591eemr1007266985a.14.1793383057343; 
 Fri, 30 Oct 2026 10:57:37 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3cesm4789415f8f.7.2026.10.30.10.57.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:57:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 26/32] tests/tcg/mips: Group MSA int-multiply tests
Date: Fri, 30 Oct 2026 18:53:48 +0100
Message-ID: <20261030175357.99684-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX0iaDeDoCfx55
 K59ufYoIrFw5XYaHsUyUIM1KqL+E3ViOZ+Z5+6S9iDTS559XP9ViZ+PMK0v1Nt10AF5Ds6xE12W
 aknK7AsLiEFuY5bxP5ROLCovWcMnTKUSvhhi3cYXXmWLB2ojOJ1Kkm+o3Jhyw+my9fPmXCPqWHS
 L2cb8NBwmkwcHLrUikxoWGPHrJST+UY8zQu7Def5UE71R0MLtaJ0wABoYcBwpd+cvJZs7gj6kol
 aXolhQtN0Q/s+x9Ut2Xsqio0fsIJ7GpexqC1oIVnT0d361rr+SYx3cISRc4oUA2HfrABfZE6Uwd
 51NJeuQQxp8RSq4ydghckPXAZWpx5cep61AhtxlinatbuRjSrSkv3AdmD0hwe3K/CUvB1/mrrxp
 wEBpbsTAW0K3qRQDpoI/LhFtg6kcAQVSq7YnQtAx0Cv4FyME9j4enIV0jwhiIoAoyNPffXINrtN
 PwEj+0VcZ4+0bRpdVvw==
X-Proofpoint-ORIG-GUID: MBNTe1ZgfmKDGOXeD_-R0gy7GkMQxqy3
X-Proofpoint-GUID: MBNTe1ZgfmKDGOXeD_-R0gy7GkMQxqy3
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4da94 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX+tyYaKBJUBSn
 Q4Ea4P5RO6v0xbMdBPyWZpP2dumFVkWyWlfpRnEKs4P6yQ1LP7zbUK0IsbLvJ9xGSYbuL3d58Vj
 FCuIGD9CAy6MfkF5WTEb4cux+C8uazA=
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


