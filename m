Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E60C60A2600
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P5jejkQO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gqZXk+Vu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqrE-0008Un-By; Fri, 30 Oct 2026 13:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqqJ-0007zK-AX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqqH-0008Hj-Jf
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu7FE373342
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NGE4WrTGJIc4moSGjwi6R1+HFVCc3oj2PkHiPocQhVE=; b=P5jejkQOTiVcCGeI
 h2mxkGn8LF/Wp6yocoiBAVn2aYdLkLO8ZH5dP+VBYTnva+XzHOlC/TCo4/ow2eOx
 ZZOtnSY2pBIGnChKtvP7HgSNT8E1j7p3Y5cuFF6f0tQMYdhxwOL1UXLvcLI10XfA
 O9Vi9jyJeJkikjCApoBBStEjTXpcOc6gOt5C6mXom/Gqvo3XzXBBKMAW3kV0yG59
 jooSMZKMF6OXs9iwcgcEJ28AKAafVfir1v3Wz0cLFofwbjvJVNRHHqztfktoiOLD
 hfaNGLMAbgCf4l0YX0Mjt346jsJpTYGV5Vp9EEWjWSwgGQSN2WrO7S/8KAZ45uNy
 KhDGlQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmb81-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844cb60so207427785a.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382999; x=1793987799; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NGE4WrTGJIc4moSGjwi6R1+HFVCc3oj2PkHiPocQhVE=;
 b=gqZXk+VuNua60u1pGWLcK1/lQbhAqxWwwuLP1HCqMrw9ogLDPUZ8UQobJF1x8P84+3
 R3yrqnsgrUVoUErXqKYtKQQIS5G7YXPI1daAl0ylJOAQoRdfpRQdCgQEbvREIiQDi08n
 7yl4MsOAM9ab8qbB6Wa5K15C+s7i3vZAege6KYNgRvJ1Azf0CC5ggTG2wLKRH0ax+rgL
 S6/7I+27HBdKrbIPWCk2bjAJOL9Mx8YmDBgO1u17wdlCzBslG/b2SvWRCEPPPRqe+EAS
 xS9LlvdPmLSmFpEB9/+aKJ/BPKTSpJUjAnj788ggcTpgCxpEV/lyEheN+Ah8ddo1PA1Q
 vo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382999; x=1793987799;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NGE4WrTGJIc4moSGjwi6R1+HFVCc3oj2PkHiPocQhVE=;
 b=i4ofhc8+bUGoMRarTnKxk9FPfxAs0Sqy+thb8gkP4oKMB+Y3a4rkIr2UiN+BFUaCCw
 Ul0uY22bszbLNEAQo6hycd5doOW9BiqcAKqCuVq0kBuAQjCc29kp5n25RDtxFNiiBmsS
 1ByG0GI9vgMr12EJ7Od192fDKyG2/7uHLjhxY2V8cZgMfj+yRwZeXy/kU7uHfAQ5MV45
 pSnX/7VNitqjK+p9etK9VfEPagmCGMUOXB5RknMbALjXbXFoJPLzNdgU8bLavciA5CvW
 ocqX6iSWfs4CVDl43GT+v0z1mL02LZ/ZFLVkrVSK39PpKHwJ6iAfU6xVeKTEw9oiMnM5
 +NJw==
X-Gm-Message-State: AFq9FYI9z0D2+dLIKtikbKlUd84GTyRbON0SJ/PYmc1/n9dUoGU33hEe
 CdO3GfMGkLX54RZnR7B09us3FAvyqWyfF2/UkhFG/A6RCp1RSPg/eYbqqQYJBGrDlaTYd65Z0dJ
 gnDhCE/sMxAVpBAQGPsTjXnfv0Kist8E+owyP94TOTqzoE7Kv0WM0ARTpJkg8zSO+QD+e
X-Gm-Gg: AYBFou1O+6+nrtWH2iHWpXdcOyI/A9XqjmKjWsIIShOHL8JJLRJJbY4Q99KMOxTrlym
 1VBtd3Jjs1+qhYM8EE8eX/rcfd0uFlHNDeyGd97I+fpaK32gUZTNpMSQnTORBGngO42JUXpnmpN
 UDy2dgs8Cihexwiv5hKOJYQNUQXWMLp7LQGNyEEt8QkB2iotiqzaPO0qW95tZr5a3vl39KFjoMG
 2fubP9HB+bFbpeVFaQ4Mc0mzXXWN/DkAEkFG9UJU5xiP+3k6WRB+TSjnipOgoGauxR859X7dIIG
 TXqr6YmeQNf+ov1Wcpu4pLFm+PNN8XVb3O+Q5nNWD4hhgDs6O/+HtgMwI8NUZtG6PUnne82y6bd
 mBWzvpfwCKkOFVaNtsy9cT4aJGSGYvvAgMDrNOzuAu/cnUCPoQT3P8s7enciqR2lspmtL9GwXaJ
 0gakLXYKUgjaPaYYlBMBERt0joJinHHA==
X-Received: by 2002:a05:620a:410f:b0:93e:53db:d59e with SMTP id
 af79cd13be357-9441338b4cfmr978198885a.23.1793382998548; 
 Fri, 30 Oct 2026 10:56:38 -0700 (PDT)
X-Received: by 2002:a05:620a:410f:b0:93e:53db:d59e with SMTP id
 af79cd13be357-9441338b4cfmr978195785a.23.1793382998098; 
 Fri, 30 Oct 2026 10:56:38 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6c7852esm69301075e9.11.2026.10.30.10.56.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:56:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 19/32] tests/tcg/mips: Group MSA float-max-min tests
Date: Fri, 30 Oct 2026 18:53:41 +0100
Message-ID: <20261030175357.99684-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX2PFLtv8pvakb
 7XuIqnaAMgVeUz2xzBWsVpYIxAn7In2au/3jdW1dxwjPNP0aj2GPbgZGdqcEVzhwc93JTe2BQTm
 cfVU2vSOqgSpAjVQxOjkIo6jJ/A+xCgnjbbFt0Z8TMwS3km8zQb0ZjFzhKZl0B3SV22sQwYl8OR
 Htrr9f/6hu74s+TaZYX2DVgMi25pNIlgsEkL7DqNzJtrqCmW10LCX/peJaRhXmyQu1278cwRm/T
 rKW4kiA+LGArJGvcLgDw9owongJeO3Gtb0r6Gh2oc8JPaV+MIxnaiqtdqUwxMxWa8ZQ0Byl5WvP
 v+R6dXwqEKIJY8VuRxIU8bbgchU1omT8blSkjkpqv1fdygtjcUK9mSehYYRJiesndZi/lziZbeA
 +wWtvwipESSbOukNUN+baGnBgzPVFZKbV+AJjHfIeWoTmvbqZgeo0pCofAi8ql/MZefgyHBQizf
 +94ZYD5VMQDq/22OcWA==
X-Proofpoint-ORIG-GUID: y8UjNT67Db5Vi2KH0PcNrOa8JEDk5vXx
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4da57 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=oKQZkuFmXZLJHpf79lgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX/CrCooyNTd3u
 euAjti2nEPjYYJ7/IBf9tHMte99ZOA0eSvwhFdd1yMc5Ivx2NZrMpuoWOwSy+o0YFCqgtRPQjSO
 FtFascZNKCuVCgXKKtHRDUqP8BnE+h8=
X-Proofpoint-GUID: y8UjNT67Db5Vi2KH0PcNrOa8JEDk5vXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
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

Build the 8 per-opcode float-max-min tests as a single executable,
test_msa_float_max_min.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_float_max_min.c | 75 +++++++++++++++++++++++++
 tests/tcg/mips/meson.build              |  9 +--
 2 files changed, 76 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_float_max_min.c

diff --git a/tests/tcg/mips/test_msa_float_max_min.c b/tests/tcg/mips/test_msa_float_max_min.c
new file mode 100644
index 000000000000..13f8bc79b0e6
--- /dev/null
+++ b/tests/tcg/mips/test_msa_float_max_min.c
@@ -0,0 +1,75 @@
+/*
+ * MIPS MSA tests: Float Min / Max instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_fmax_a_d
+#include "user/ase/msa/float-max-min/test_msa_fmax_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmax_a_w
+#include "user/ase/msa/float-max-min/test_msa_fmax_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmax_d
+#include "user/ase/msa/float-max-min/test_msa_fmax_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmax_w
+#include "user/ase/msa/float-max-min/test_msa_fmax_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmin_a_d
+#include "user/ase/msa/float-max-min/test_msa_fmin_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmin_a_w
+#include "user/ase/msa/float-max-min/test_msa_fmin_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmin_d
+#include "user/ase/msa/float-max-min/test_msa_fmin_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_fmin_w
+#include "user/ase/msa/float-max-min/test_msa_fmin_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "fmax.a.d", test_msa_fmax_a_d },
+    { "fmax.a.w", test_msa_fmax_a_w },
+    { "fmax.d", test_msa_fmax_d },
+    { "fmax.w", test_msa_fmax_w },
+    { "fmin.a.d", test_msa_fmin_a_d },
+    { "fmin.a.w", test_msa_fmin_a_w },
+    { "fmin.d", test_msa_fmin_d },
+    { "fmin.w", test_msa_fmin_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Float Max Min", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 17e3fe3e55ae..5e14bc3197a5 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -6,6 +6,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_bit_move.c',
   '../mips/test_msa_bit_set.c',
   '../mips/test_msa_fixed_multiply.c',
+  '../mips/test_msa_float_max_min.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -73,14 +74,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c',
   '../mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c',
   '../mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmin_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmax_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmax_d.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmin_d.c',
-  '../mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c',
   '../mips/user/ase/msa/int-multiply/test_msa_mulv_w.c',
   '../mips/user/ase/msa/int-multiply/test_msa_msubv_d.c',
   '../mips/user/ase/msa/int-multiply/test_msa_msubv_h.c',
-- 
2.55.0


