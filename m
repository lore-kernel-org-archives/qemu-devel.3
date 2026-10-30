Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC02606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BHBV1nyi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aKy2b9rb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAn-0002wM-SK; Fri, 30 Oct 2026 11:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9e-00025I-Is
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9c-0007GJ-Jt
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:30 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERFcW3552465
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UJ6rNaGSezghIetlzctZLHRH6ZhSiqBVd/s3q8/JOMg=; b=BHBV1nyiExiyMX9x
 sDwNT6AsH7LSsZzutDA0hdarp/togU2OLw8+wTmTkWjufg1yMEo1Q6tN5dSu5g5a
 nZtJj0GV745stUtwV5TNYSTZpXZ2/hMUJ+YRxWpMYSkf5T6lcUglCylsfwxwrOUS
 pfXGI2FPax2Qec3ySS6KtnnSQkwLACakGZSAx7LkbuhNG8GMUgV95GF6Xr7Ujvvn
 FO7xObKovyBbFMe90SJ9TIHdCuNlT5J+C2Vfv6oBz7OYhBzrQqXtYPAsLjLCAIe1
 XaZdzzrGM53IlsMAnLUzzExaDEYRavqR/nNqbQ7svCFDOe5Ed7RNK6+U89e2Qq/U
 mEkcZg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkkd6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:26 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7bf45382794so627678137.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372665; x=1793977465; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UJ6rNaGSezghIetlzctZLHRH6ZhSiqBVd/s3q8/JOMg=;
 b=aKy2b9rba2/v08R5EIZiiuhz8Y0ADedzKySDK971kUhXRSQ4zBr5SmQ+1zcnP8B1uz
 n+AdqcBPJrIgkvrM132qbU9bYMA03n5LAoYJPNcCfm5xrGLIm/uDcf5gg5IvD6jcUtUQ
 BuULP3jfpqOnEUTZscfdrI2hsWRiXD2+3t0yCFrLiBsdcPHbJhWb8jXX+F0bxhzLhmKT
 gJnOiBmErsh7ad7ayh5msVSu2DmP1ZMYz3RMJhSxnsM3UAlB1XXZiyQmrw7LAB3Q9pJt
 Jx6LfBxGOYfNdQjtV2adCjpACB1rpLwfvKUwuThnAi87Zs0G6PawWuL2Cwdszkff4ZRm
 gwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372665; x=1793977465;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UJ6rNaGSezghIetlzctZLHRH6ZhSiqBVd/s3q8/JOMg=;
 b=zlboIDvZregDXZLv7EeMg13vtVbBUunnnknQR7nj5PB6KV/CrxCibCUdi5HB+qDduU
 iJhwvlaOSXewWFX/Oysu9HMtexmZNeZGnEFEtn9XrOUOWt1QVgl0dx/sbxvj9F2rwUlm
 UC+B5CAU9bityQfXasnuTGIUBJa2sZSaE9SO3qklGrb5wI4cv7C1GK96ysR8neQ5Kxnz
 OoxbdR0KcYeUzzN+3gNjsr8zRmA+X6mg2JqzxR/LKZu06mniC/9H++2CAa4niRG2/YZj
 IprSYAmbpODSuB7QyR+ERGUXdFT77wJMlBizcOACNR+kZDQTcQYGX0ZBiihkDE+Rb3Lt
 ClwA==
X-Gm-Message-State: AFq9FYLGgdCHtbRLTUE7iZCd7604dqVKlHAcTyxIMvbTd/EydoxJCzFG
 K+HSFGW703AW2q34fDurxcWSI6kM9BxI8qXRBX+ucOKMG4Jt8s23F7a5l8qXxyn4b4YZlwfh5lI
 fKFNGq1RqQa6sl2n4Al8utvplElI/7j4yUe7P2ET2ON2kHF1drvMHmXc36pGnpou4j533
X-Gm-Gg: AYBFou1ydsR9uqHXL+g4bN7VzSdvWjs+IL+/c/OaJHBw1eOMC5ny7R4QhTOBi3yCee9
 EZYf6mh9wd+1YQLOar1Xp6GAHxjBlIxhjHXd075tOFMhnMxNZKMOMVw4KSq4EflaimkId0r5KGg
 DZs0sEEzUQ0l1hM32WT60aZLSigu31MybwuAHe55nquypXpCwaBAXsYEwPdiVI8gge1cMe/Y5Kc
 P4dhMOUYw6t/RCfj1jSu0E9kxuBiJMTbHnIWKqDWEFYKM2AvGyH3vetcfuqa6QaAcQWQygtYmCR
 OSIxS29r+FP8BpuH/H1k5ntd9wy+yx5WVfLMqnBIz1VXbjgwpGontuSpAbNvqA1RzgI1fpeMUVO
 5NmTya7VORCnQdihQiQ9PDqCe5IJ6JSJrvM9Bitl2ufGtGgSK9OMo1Vc7Nf+hlRC6QVAGrYXVsX
 82vDIytk39DCHgyTwfzuZIsZlOiDa6Pw==
X-Received: by 2002:a05:6102:e10:b0:7cc:26e4:193e with SMTP id
 ada2fe7eead31-7d07274b90amr1378109137.29.1793372665127; 
 Fri, 30 Oct 2026 08:04:25 -0700 (PDT)
X-Received: by 2002:a05:6102:e10:b0:7cc:26e4:193e with SMTP id
 ada2fe7eead31-7d07274b90amr1378054137.29.1793372664547; 
 Fri, 30 Oct 2026 08:04:24 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf396dfdbsm69083325e9.1.2026.10.30.08.04.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:04:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/31] tests/tcg/mips: Group MSA bit-set tests
Date: Fri, 30 Oct 2026 16:01:46 +0100
Message-ID: <20261030150202.61556-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y-MzPozlK5TmbNy97bXd97PNre89fzFj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX4tVGY+hEwxP1
 PGtvUVyhsxFP5UiYvsppkJfO4WVaf12q7wiJH0vWMpbMc+1Uwxmjka4UQix50xxe2P/3dMf+2ws
 DBjuzkITJoedCMHAuuiurLgaw708uIk=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae4b1fa cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: Y-MzPozlK5TmbNy97bXd97PNre89fzFj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX592SJGAJU/wU
 f2QbIhdnVlLwnI8SWam9KMwjtKg3Nhlh7KFekFAC6WFQuHow9/FdDYCPGu7dm2sMScua+ab69oE
 gJ6UGY0YgP3WhiNwj7gYJl0mcpHKzP5OEKSnNhOFHwsRbJIH9wcFWuhjfpKV7kbsCeTNWhRSwTb
 qGqVwQwjLCI5VY+9c82KiH4yIN9Ey9ttoFG5l3ADGPmF3v3i6a6bH7z6kRqcGEn8xn/GdfK+3i7
 iq+VIJoTB3yRh6ei1HojO8lwrmg5DRJx2Oa0QwSqIs1Funu6p/PF0dzM5GHWcwdw3g5zh/2AttT
 jqLoLWB0SJF0fubX6oBPF9P1dUH/0iQSeyMRUoizevS7L7v6Jwk/Y+Q9bckKN5NgeztSocPilnP
 moAavWZWPkxBCXZoabWGJZ0t2rS8ybtde+PwKW+lcgTjqhJdCSptIQf6GnlZc1Mu1t5ow/hishA
 VUG3DuEco1+gBlsrw3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300059
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


