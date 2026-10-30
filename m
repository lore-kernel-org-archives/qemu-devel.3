Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0F606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KG3ciEsC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KJ1/QSME
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoBG-0005Qg-5Z; Fri, 30 Oct 2026 11:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoB8-0005AP-My
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:06:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoB6-0007Xs-Gt
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:06:02 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERLhY2968145
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9ezxwTOoRrCT1s9gzKXBUfjV1t2eO52tFy0eMGfZLsI=; b=KG3ciEsCYYUAZie7
 yps7byKBDHQTj8SZ7PPZtLqL1CjbXtWiQhv8+3LSCtAHZ4faaKODwnntNVNNuPAy
 oHm6geeND9km2DISvrEAI46MBzcSwjnU1CS0JBSRQYvwt2DB6iS6qy+pnCzRIGgD
 hqkVuibL2B6W24naOjacsRVL3nBM6Q46VUbCWXCYAHdNxdczhSt4I7znZv8QAuB+
 EUif2Hh7hCMU1XbTeEptE7dfuvbvGAdzLgyuqRh5zdVVdynCMY6cKXeo7u2szMAh
 IjxXo176+H+odWEzX4x+RZD+wF7E3KuOpnQ4B8ZGNkqWYo42hpy1+hh0Kv59I8qX
 vRrMyA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qknhu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:58 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7d06f3784e2so182015137.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372758; x=1793977558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ezxwTOoRrCT1s9gzKXBUfjV1t2eO52tFy0eMGfZLsI=;
 b=KJ1/QSMEHE0kwfIqmx1SpbYEqooNrwVzJlztSSREPq5075t1/dlGzPRnsGq0NP+YuR
 dFTKXh9BlogJBlzgJrOCf4cUzl1GUpE7QO5L7fAGyB5PTw7RMw19hIcG1djU2fi2/4Pr
 ATkol1FU7B4HMRYx/oRS+TZQ0JtLXJwq5hdzZ01PGq9Mk1nrndWBP9eJ/zx+NZxwYf6W
 pmYQvPbQtGXzomWCKBaKeNamKzjo99kpRIcUXNTwDvOsOAIZR/6tfxBg7Yk01VLbiUfv
 +0Ei9KnfDSQ50F+JiKYmsuXMkhUvJCZeN1HAmINpfIjBdVPBgzuyGyl1gkklJwaABWRB
 N1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372758; x=1793977558;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ezxwTOoRrCT1s9gzKXBUfjV1t2eO52tFy0eMGfZLsI=;
 b=P9JIp73wp6NHhdbp+WXx4G6EcW5dfQ5Sz9vcOV1Rp36U0CEHN8TK9fIrIb7/nI6Ei5
 oyIAdOj/Fjl8ZS6iJizvrThV7QgLD9H0zbMtBWc4vMNJuBatolN4z+zosmrDyTbntPjg
 2w9fEqOEv4opcRt5ImkFp4/rMY/rcMPmdAGcdq2GTwqe83JXCc0sYWO9y6NJDvU37t/v
 1fd3TRc8ffxJsRYMfL3Pfa5GPfISfrvuwefwfefii0QBqj66sffXfKa+cZJAmc3eagXc
 XtrSvtZpF7levIID0UOy/lUXzGEeGKu7YmoTVJq6cG4JnMnVaR3MK1FMICCvfd0fkUpW
 +r2g==
X-Gm-Message-State: AFq9FYIvaCw9xxgklnQ+Cu55qzmNZepvR8PfMVaCVyFd7j891bBKqFET
 KXi1tmYay1B4tiyo8d2YGtyhMkvDG8MczKkEwJrJkCezhHK5Svz4Yj1u0R/sZ4FFOhTU5xKSrWd
 EJdokYvjlM3pMB0AOeP+y3IWr4/iJQLtcSAGNeyyBv6zMzYtr37j4aZ/2ox+ykZDSrvQK
X-Gm-Gg: AYBFou11DEj4ENUxabOWZrQvEKFfDcHyUfVkC6wI1kPuA5+od7igkEhUlW5S/GRijif
 AtpMLQ6yMrYMDq40CNZBZqN5S0j8a5RhwJbDjxU1hcH/XO7LUbt62PfipegiwwwomSua+ZOtnsr
 JKjfqgLJrrlk+Ez/zr4ssi5lrzT3oRNK6bxIyxt8KV12ZvguU5wdF3od6ChLxLmuO04qiCLZtv1
 Q/ZjsmhlrEh2qs/tPiVpKAqUlRcRxkuFaP3ndrmMArbDEHM6AnoB2Sy7eni370KA6ZP8O1ywm7w
 k13dyPpIyT3uUYEffpgAMpnnROCMshGEXlOKbkkOjXb13U8L0HQVFxVEkeoS+SvWBMiaWyW76Hy
 QgfAVrK0E1dAiYDG0Tu7D4qtqOuGfZVC1kDKCHrsUyMdzJbNsn9E1g6r771rYoPR5jUCCn1pE4g
 SWmXwtMG/cWepp8jKCQOMdhxM/TctF8Q==
X-Received: by 2002:a05:6102:548b:b0:7c3:6466:3155 with SMTP id
 ada2fe7eead31-7d072d2ca10mr1114677137.33.1793372756327; 
 Fri, 30 Oct 2026 08:05:56 -0700 (PDT)
X-Received: by 2002:a05:6102:548b:b0:7c3:6466:3155 with SMTP id
 ada2fe7eead31-7d072d2ca10mr1114605137.33.1793372755317; 
 Fri, 30 Oct 2026 08:05:55 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7c5063e3sm140388265e9.0.2026.10.30.08.05.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:05:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 27/31] tests/tcg/mips: Group MSA interleave tests
Date: Fri, 30 Oct 2026 16:01:57 +0100
Message-ID: <20261030150202.61556-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX15qGCSP92gOT
 7BO+fhfBaoqYHFgu5fN+jPxheLjdTn5Xmb4yEuLhJ1+2pcyQ4zkfkuAioKWTWC8n2nyaJzl/eDB
 kzsx22rCBpVKdHkKLYUqeUvNbzvQeOcrts/BjFuwlKSoJBS+spSGZJWEtPIelw/fP42WAsJ/7oh
 S91ZymBiMHD/iOyMxKrk51PsEPXGCuvzmohc7K46se1CreN2Du5lgn8jAcqPDH9vd+C1unhesCy
 qw3fC6ImIYluDst7xHg43SUZlNmz4Hrii1zCPNscEZGsIu01jT4R4gOozf6KvI43aZTFM9UG+oz
 28leVpk7Ye4OWVbGJ5lThiv2qc+3dwMN12o+zz2SkR7ULkL/DEcNcOt4GOCVs+k+VoUqzq9/6X9
 dqTXq/AwcyeJotM2kQoGDuOSSzVxP8AznVSueh9VGp1SYGwMx7zkUF7zrEX30spYetCxQlNMcmr
 aS/qdLF4+ouCCDm51rg==
X-Proofpoint-GUID: 8u7oiTiwPx_rdhB4Wr8ytFxSLtVDgyX5
X-Proofpoint-ORIG-GUID: 8u7oiTiwPx_rdhB4Wr8ytFxSLtVDgyX5
X-Authority-Analysis: v=2.4 cv=IumL47/g c=1 sm=1 tr=0 ts=6ae4b257 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=XlFCZ7tVMrZGAbOMMLgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX9U36o9ofnHTV
 fRlV5nPpZuDnpaew1VElJjhsuDo3IEH7wWScsElNE+uim4R7yA1lIZ+cuyb+L2IvCvFo7jpcjXJ
 s3AVxUetobtIBxB8DEdgGz2mSvjlsKw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300060
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

Build the 16 per-opcode interleave tests as a single executable,
test_msa_interleave.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_interleave.c | 123 +++++++++++++++++++++++++++
 tests/tcg/mips/meson.build           |  17 +---
 2 files changed, 124 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_interleave.c

diff --git a/tests/tcg/mips/test_msa_interleave.c b/tests/tcg/mips/test_msa_interleave.c
new file mode 100644
index 000000000000..f561ebe25aa4
--- /dev/null
+++ b/tests/tcg/mips/test_msa_interleave.c
@@ -0,0 +1,123 @@
+/*
+ * MIPS MSA tests: Interleave instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_ilvev_b
+#include "user/ase/msa/interleave/test_msa_ilvev_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvev_d
+#include "user/ase/msa/interleave/test_msa_ilvev_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvev_h
+#include "user/ase/msa/interleave/test_msa_ilvev_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvev_w
+#include "user/ase/msa/interleave/test_msa_ilvev_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_b
+#include "user/ase/msa/interleave/test_msa_ilvl_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_d
+#include "user/ase/msa/interleave/test_msa_ilvl_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_h
+#include "user/ase/msa/interleave/test_msa_ilvl_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvl_w
+#include "user/ase/msa/interleave/test_msa_ilvl_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_b
+#include "user/ase/msa/interleave/test_msa_ilvod_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_d
+#include "user/ase/msa/interleave/test_msa_ilvod_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_h
+#include "user/ase/msa/interleave/test_msa_ilvod_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvod_w
+#include "user/ase/msa/interleave/test_msa_ilvod_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_b
+#include "user/ase/msa/interleave/test_msa_ilvr_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_d
+#include "user/ase/msa/interleave/test_msa_ilvr_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_h
+#include "user/ase/msa/interleave/test_msa_ilvr_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ilvr_w
+#include "user/ase/msa/interleave/test_msa_ilvr_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "ilvev.b", test_msa_ilvev_b },
+    { "ilvev.d", test_msa_ilvev_d },
+    { "ilvev.h", test_msa_ilvev_h },
+    { "ilvev.w", test_msa_ilvev_w },
+    { "ilvl.b", test_msa_ilvl_b },
+    { "ilvl.d", test_msa_ilvl_d },
+    { "ilvl.h", test_msa_ilvl_h },
+    { "ilvl.w", test_msa_ilvl_w },
+    { "ilvod.b", test_msa_ilvod_b },
+    { "ilvod.d", test_msa_ilvod_d },
+    { "ilvod.h", test_msa_ilvod_h },
+    { "ilvod.w", test_msa_ilvod_w },
+    { "ilvr.b", test_msa_ilvr_b },
+    { "ilvr.d", test_msa_ilvr_d },
+    { "ilvr.h", test_msa_ilvr_h },
+    { "ilvr.w", test_msa_ilvr_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Interleave", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 516da867cadf..cc94623f8f20 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -15,6 +15,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_max_min.c',
   '../mips/test_msa_int_multiply.c',
   '../mips/test_msa_int_subtract.c',
+  '../mips/test_msa_interleave.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -40,22 +41,6 @@ if 'qemu-mips' in emulators
 endif
 
 tests_mips_msa = [
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvr_h.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_h.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_b.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvev_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_d.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_h.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvl_w.c',
-  '../mips/user/ase/msa/interleave/test_msa_ilvod_h.c',
   '../mips/user/ase/msa/pack/test_msa_vshf_b.c',
   '../mips/user/ase/msa/pack/test_msa_pckev_b.c',
   '../mips/user/ase/msa/pack/test_msa_vshf_w.c',
-- 
2.55.0


