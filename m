Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E98E606A333
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aRNwev0h;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kq7SLCDf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqrk-0000Tg-R4; Fri, 30 Oct 2026 13:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqq1-0007IY-TP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqpz-0008Gm-Q4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:25 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu1rc4011172
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UJ6rNaGSezghIetlzctZLHRH6ZhSiqBVd/s3q8/JOMg=; b=aRNwev0hEzaUVuIB
 HvFiHS6C/wU4MZK2o7AUM1+eaQKx0IUh+8whpxSNup0Nii3ohCTd1tWcwISHaMA2
 r3vqCTDLV1y/5cYxIX3I/Eu1ccAozC10kpPzQvZXUhgcW8N7K8NJVBdz9zF6tmwU
 IVfmBuv2IVv3bx9q4OYU0eEVBuQGNOPQ/rQ9Q+YTO5Ox1uNA9S++hTN2FwyMTSJS
 Q3r9m3J+BKKbrcxNhIZXwxHwl9TBkTYJZ1fotQotNzqFl+c9f9Qj/tc04Xt7YNJZ
 jQpsjmoIlKOsPj/7CbRMTql3CMwXWgRLDR07F4hgK6bOKonkpssq+3h7/WdF7g2z
 fp21kQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm8f3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-944138ed63fso154731585a.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382982; x=1793987782; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UJ6rNaGSezghIetlzctZLHRH6ZhSiqBVd/s3q8/JOMg=;
 b=Kq7SLCDfzigsjo9vMEt/t7fG/uCu/P3UvcMgdtBkQ76+VJyWW1LqPfbAwXQEVKdRQN
 bTlilJMhYF3Y8hyDpIW5eG9ejKeCccLiJkOO4Y29mmK9k4jS6837sXiWkxPKQKzE+EuF
 DGZg21wau4qirbN400VEcVYfDmW0btxvmrZTUtSq1+SWh7tVyVEOaZpekrmceBzkKVj9
 B2u6p7csnNzPQEt3nBYQGKz/KXDc3HArW4q33gmnUr5exqyHIly/PLLofdggj5+TUnKM
 gmv//xv65y5HzGeCtRSNRClXHTKYt2VSzlS4f5fLu9z2pHGaYN4AZP5w/GhZFtfoIGF3
 lIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382982; x=1793987782;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UJ6rNaGSezghIetlzctZLHRH6ZhSiqBVd/s3q8/JOMg=;
 b=UzYjQR6jlbCHMtNwowFUf/GFHb+SBz81ZgfaOAizssZHoCvWqHIqvEw5OUmFgWtvfP
 hY4WGNlBSMdUdf+2hTP5O0bdbGdlgbGWyrXJ4FyKY+8rFIhQ3zX83TZKo2TsF7NU5kpU
 1RMzbHrtYpymkl5tjEMK2jO/daswvkmozlokrubLjKxCb2L1c3cbtgjyX/1TYInP1/EY
 YJi5S192qa+WaSp6MCB0L4DiDcey+RmGxIr6Z8BoNG2VdA3a/LdrQg51727TfpnP9a0D
 uTq+KmLlmU5SXjjhNEDlUELcdq5um8ujavanLBl9XTeYuW9dStTeJIWuqzNeEzH0fc6Z
 mKSw==
X-Gm-Message-State: AFq9FYK0zYwEXf1qgKuSpLgQKIeQzJuo3PDLnvmTPdoIPe847uL3K7tN
 4Jgs87ZQCrc+Bdf1uhXu76QM1yZ2NpoOemOxy95UnOzIEuMryhT63I2FYVj679y0rCZQHMq9I6y
 iSAQDCWKdxu6pn4eVqw0vxz/ck1QUmj9WCO4/71H8UAoATn4YupGrCJxS80Z6EexvKaIh
X-Gm-Gg: AYBFou1PqZyg2UvlQwpq4aSalF9TlRLoxbhopQhGbWpb/L5IxKidkd2TfN/Wx10tqxK
 s3+R01qztKvbkgEtnvpvyKI9OXIdzKdqbwxrvummTZEbzFHoLcTI8qOS0O3uQj/3K9FNz9XkyUN
 8rKqa3BUBPBrBNLSK5QLbk5hlz+ZOSyHCvOTLtovaD+AIvhHIjho7QYsLfxKqw3Wg/7WlR/EXfs
 iTtRdmnnKqWZDApje43Lsv3SJiknKCkXd6sr+XaBF7E5q6rXZNaf8ush6q6P9nUexM5e4fgm2RM
 AikXSNhbrJ0TfjUTyh1rURLXyDOCwbzjNkrvX9sOsIHqv4YRuy3E6a2y+ZPypjJvrs2HDBtS5PG
 Mjc5Lagc1k/iJsOJOYwCZD71Aw0KQaNgh1wPLnqeCmjmsDb+aLQdvSc4rL/kD3iyRoioB8pBBi1
 rao71kzbfpxZcSFmMNpVXqWcMbCYMILQ==
X-Received: by 2002:a05:620a:84c4:b0:93f:1ed3:a9d7 with SMTP id
 af79cd13be357-94421719099mr495647685a.27.1793382981938; 
 Fri, 30 Oct 2026 10:56:21 -0700 (PDT)
X-Received: by 2002:a05:620a:84c4:b0:93f:1ed3:a9d7 with SMTP id
 af79cd13be357-94421719099mr495634485a.27.1793382981415; 
 Fri, 30 Oct 2026 10:56:21 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b27e46sm116856245e9.3.2026.10.30.10.56.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:56:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 17/32] tests/tcg/mips: Group MSA bit-set tests
Date: Fri, 30 Oct 2026 18:53:39 +0100
Message-ID: <20261030175357.99684-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ciQUeWzGMoG4-Z3RQwkByXL6W4PGej6R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXw7STdgD+ltQZ
 cwrcckC8lLAZ4KgN1kPmqPJ9G25bAX9tvAV3BgodTTAGWj6HpeH6fiTsfPwd+HT3icgyR4Zt9kf
 L1QfpolEmsNGTXW9xQHfn9NwDpamQ4I=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae4da46 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ciQUeWzGMoG4-Z3RQwkByXL6W4PGej6R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXyb0H7oCzzuoC
 z36XgfbrVAfL3jBFQqTvu+8aEXeE8dirEP/oLzGS5l62CgQyUhUOqPlqJhm5AaF/cELmn0ryWUy
 SMvIxqzHQYDSEmXBYDf6kULyF1IRd6CWw2+aw+YYTzFgAk4+HGvw/8742SiIWXAMzQoSYH+u3Yk
 v/RY4VbiUVf8C6MT3iZcyVqC8LtkE9xTcFxPJJ60PFsLnUzKN6iHhJvgznI2ZDYl4AljNjAOt3d
 5xTPsp3pKlwSBm/5JA3xnaYOAfELFc/C0NdlLG/cMI2RdPKbWA30yusa/4zRaorCl2UA9NBVNaq
 NTxocLmJEnJvtbaWc07kKBYqy6qNoIhiE//XbvRBqPQKCRc/NvRQtwULZcZxOotS1R/V1jBCVYG
 2GJLHDL6LubYoEeS7hR1ypSoyVluEEoZbUjCNoDRbpuyl2M2t/zp13Mb9X5Dy0Z0xkfo4S2c48/
 b4ZrWF88bxuebgNXjxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
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

Build the 12 per-opcode bit-set tests as a single executable,
test_msa_bit_set.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_bit_set.c | 99 +++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build        | 13 +---
 2 files changed, 100 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_bit_set.c

diff --git a/tests/tcg/mips/test_msa_bit_set.c b/tests/tcg/mips/test_msa_bit_set.c
new file mode 100644
index 000000000000..840b125c2969
--- /dev/null
+++ b/tests/tcg/mips/test_msa_bit_set.c
@@ -0,0 +1,99 @@
+/*
+ * MIPS MSA tests: Bit Set instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_bclr_b
+#include "user/ase/msa/bit-set/test_msa_bclr_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bclr_d
+#include "user/ase/msa/bit-set/test_msa_bclr_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bclr_h
+#include "user/ase/msa/bit-set/test_msa_bclr_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bclr_w
+#include "user/ase/msa/bit-set/test_msa_bclr_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bneg_b
+#include "user/ase/msa/bit-set/test_msa_bneg_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bneg_d
+#include "user/ase/msa/bit-set/test_msa_bneg_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bneg_h
+#include "user/ase/msa/bit-set/test_msa_bneg_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bneg_w
+#include "user/ase/msa/bit-set/test_msa_bneg_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bset_b
+#include "user/ase/msa/bit-set/test_msa_bset_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bset_d
+#include "user/ase/msa/bit-set/test_msa_bset_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bset_h
+#include "user/ase/msa/bit-set/test_msa_bset_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bset_w
+#include "user/ase/msa/bit-set/test_msa_bset_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "bclr.b", test_msa_bclr_b },
+    { "bclr.d", test_msa_bclr_d },
+    { "bclr.h", test_msa_bclr_h },
+    { "bclr.w", test_msa_bclr_w },
+    { "bneg.b", test_msa_bneg_b },
+    { "bneg.d", test_msa_bneg_d },
+    { "bneg.h", test_msa_bneg_h },
+    { "bneg.w", test_msa_bneg_w },
+    { "bset.b", test_msa_bset_b },
+    { "bset.d", test_msa_bset_d },
+    { "bset.h", test_msa_bset_h },
+    { "bset.w", test_msa_bset_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Bit Set", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index ae755143c18d..03f3ce57d3cf 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -4,6 +4,7 @@ tests = []
 tests_mips_msa_groups = [
   '../mips/test_msa_bit_count.c',
   '../mips/test_msa_bit_move.c',
+  '../mips/test_msa_bit_set.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -250,18 +251,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-average/test_msa_aver_u_d.c',
   '../mips/user/ase/msa/int-average/test_msa_ave_u_b.c',
   '../mips/user/ase/msa/int-average/test_msa_aver_s_h.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bneg_b.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bclr_d.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bneg_h.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bset_h.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bclr_b.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bclr_h.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bneg_w.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bset_w.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bset_b.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bclr_w.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bset_d.c',
-  '../mips/user/ase/msa/bit-set/test_msa_bneg_d.c',
   '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c',
   '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c',
   '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c',
-- 
2.55.0


