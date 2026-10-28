Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39904606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=flpQtGrz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F8Rg6qDh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9Dl-00076c-4L; Wed, 28 Oct 2026 15:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9Dg-00074F-Hd
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:21:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9De-0005ne-E1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:21:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIQE1N1581355
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y5DNjnVrYuZavoyEYjaFUh38GjKksY9EryFr4+oLwPw=; b=flpQtGrz5KoYHz7L
 0kd4yAD9kTBkfRYmuP5R2wpZs3lXo3evx6N/E89V2cHW4CPFUyJCO+prFz020Ap/
 VXHpEhd5zik9PbtpXMw6xQo8lPmqzQed1KI5cqpY69hI6nEZKdFfxOoWQO96p+yZ
 yprVa6YStvTcgBsXWu0CrHca/mE3ZbHIji5+on3b3hNkdbjOB58wt2qjG2kGyJUS
 0eHkyDsYYocO35RqPqHf7SAVUF/6bOMy+9ePyseR5VjeTpruJoa46eUGveWaAYpo
 JSkqwZa6EWUlFF8ukqokY/dG25yVcGqLZCgC7P/Q2Sl8QWIUv8/fYPsZBje1Cohj
 jroJVQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkp8de9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:21:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f37c94ceeso977885a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215313; x=1793820113; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y5DNjnVrYuZavoyEYjaFUh38GjKksY9EryFr4+oLwPw=;
 b=F8Rg6qDheb0ZR+NioR9RB1wTdpm4Md44XTef6w1sFCkS58X8UQZe9yoeWh/Ntox6Uz
 4LNNhFULumz2H0zHDfjb/p2RwpAmVO90GV8kQnKRxZOdjP+puvDKmYp+Zs3YNGtSBvOx
 NiR83gn1YYz1vi+INt/j5fmP5l17veoKwLoWuf7Iv2PB6wsfaAUSR8h0FKLWWmDK9VFN
 A4Tf6tOadvWDlC1M/zJAIah4Rw1UXD7nyaPkJgW0Au3DH2W4YYKchefMgksBf0h1P/eO
 gaht1NPMY3XocBJVXoP0AAGxFOzUKUnbig0JWk5L9LFBTHeRrAdtvE4uOacDNSn9USAT
 BxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215313; x=1793820113;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y5DNjnVrYuZavoyEYjaFUh38GjKksY9EryFr4+oLwPw=;
 b=CdujkTDFxzwoEuFqJS2DrqVKVV3HgJ8TNN9sLaTnIiu3meZyAHnFLsAwkTUtYkupKR
 JKBa9o78Q6kuNqnzA65XMsmsFFSWYs1J+W+tl7UhWzuDEnBhhP1rUm3xXA14mjhyIG8+
 O+nfICC5s8zlU9GjCx6/85kms+89St7Gfi+oTGR3c9Pc3jaT255m62xRcGb7s1MRE9d4
 5tMWlNWsfD8AIgthPrzZOefPkbGP3DEwxBsrTJOUGBEr4QDFjKyFHy0U1sovpiuqgPL8
 EEgTVnWCRkDlxQRKY0BlY/VRGpd+ZGu90B6d46oZ37AEpuWznd7tkSl64rZK0ybfQeVf
 fCjw==
X-Gm-Message-State: AFq9FYJv2YKC7RIdpXgFblxd+n70DVu4ZEl6cfZBLqNRmvwjYh3MbTBN
 YM0TVXtb9n4bIBKJqHIyPQHlGWb+zcRW5Yr3pU3mve4JTg/yK3JS60hhIpFYraFbi5/yWem7F1K
 r7tfdCA0ygjnO55q2yCwgS3czNv7eyr2qEi210h3R6k36yXd853oEQNDxqDjo2jfNqRs1
X-Gm-Gg: AYBFou2GkFKiTY93m0RAs/MKlrGoUBNKV7qyAONlrAMt9cZifvcNyg18HXGGjw5o3Jn
 EOpZqkKY21WkEICbeFFKrhR/zBszvYZYTWF5WayyGfNztalN/zigSvf1jjEf8TmecmblnMYxaEy
 wytE26cW4ngxuew97hY9VMEuvdVrzDNC2InhNz4yz/1OI5uHdkaZwXNBPnO9LaD2PbM3vJ8CYS0
 VqsKGUHgEJwfYyvOW3i5TviLHnyeNhoonyfCy5TUDLQNeyMzHcK7tnl2hV+my5WuiCfdN95gpJv
 T/q8Gpp+kWfx29ryNT2HSJ41YjIGPifrNzDf0V72Fz6G9hZ0WjgTxyatJslyvfONbPxfzb/OHiO
 4pfr6X+uM82Vw2VTUxG7qprJhn/ULXcaCJt7SRXjpUXDYnIeHkYwhwYSel841DUftdk6xATWkiC
 rDWh0T7fpnDE+w2R7U6jjMLRezL9Oo8w==
X-Received: by 2002:a05:620a:2815:b0:944:6ad:1b7f with SMTP id
 af79cd13be357-944133c303emr77451485a.32.1793215312707; 
 Wed, 28 Oct 2026 12:21:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2815:b0:944:6ad:1b7f with SMTP id
 af79cd13be357-944133c303emr77447785a.32.1793215312153; 
 Wed, 28 Oct 2026 12:21:52 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f41895fsm11032595e9.5.2026.10.28.12.21.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:21:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/4] tests/tcg/mips: Group Release 6 tests
Date: Wed, 28 Oct 2026 20:21:22 +0100
Message-ID: <20261028192124.30941-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192124.30941-1-philmd@oss.qualcomm.com>
References: <20261028192124.30941-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae24b51 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=wooYhwdhcTCjZde-bA8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: b6Iim6iZDFapLB4empWz6VRTGlj2ZNM2
X-Proofpoint-GUID: b6Iim6iZDFapLB4empWz6VRTGlj2ZNM2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX/ckBhKjLJlnl
 Xn7MXgsimGvo2sPPAmcqOyr/pZ7EHkuIOp3UMZnboIpuVDXrtxA+M0/6PvGqU9etAqvjlFaO5sC
 JzKtZRLrv3fWUCjYlkNdcfjv1CTz1YM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX+qWdBcl+xqqx
 KJV4f9C9EpVLFyCmtHzOxqEhZAejWkCqbC8HLx4STqj3qPGAH4x8n6QK2NbiHa+Si7n1AdE+qEP
 Rf/kGpXjq3K42uhJ7/voW1Bf1WpZzhmP3wo/OMyCnoCn8pYjjNe1Aqlm1Uh9vFD8r+7nykMBpR3
 qDqQNbT9qKrgWisAi6BzMYpsRjHeg7TlKHlub0yPKc7LWIVPGt3FOY4ZCelZo10p6zlDLKDLyPO
 /tt2/LGTlbOrTZqQVLXP1v9bBrxrwhnH0689rwvzF17y6LUQ/kRdi10S9B/1JrRlksB/+QnpHOB
 W6JLD/PxE9qGJPLAPMfDZ4oB8OEdHqz9pWZNBTeG7Ct8fXSz5FHwJKhNrSpx7g1zNFOA50HtN/x
 QOKHphSk9w2kiegIZmPSmGVtu3cRsBQ+pCiq/J15D/HlBqPacLyX/PlKFvjJfw5LWEhij/VpNRA
 wbkQLl/4IqIp1aIimAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Although meson parallelize build, building the 32 tests is overkill.
Keep the per-opcode files unchanged, but add 5 new files for each
group of instructions:

 - logic: and, nor, or, xor
 - bitopts: bitswap, dbitswap, clo, clz, dclo, dclz
 - multiply: mul, muh, mulu, muhu, dmul, dmuh, dmulu, dmuhu
 - shift: sllv, srav, srlv, dsllv, dsrav, dsrlv
 - crc: crc32b/h/w/d, crc32cb/ch/cw/cd

These tests return a status instead of calling assert(), so one
failing test doesn't stop the rest of its group (except if crashing
on an illegal instruction).

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_bitops.c   | 46 ++++++++++++++++++
 tests/tcg/mips64/test_mips64r6_crc.c      | 58 +++++++++++++++++++++++
 tests/tcg/mips64/test_mips64r6_logic.c    | 34 +++++++++++++
 tests/tcg/mips64/test_mips64r6_multiply.c | 58 +++++++++++++++++++++++
 tests/tcg/mips64/test_mips64r6_shift.c    | 46 ++++++++++++++++++
 tests/tcg/mips64/meson.build              | 37 ++-------------
 6 files changed, 247 insertions(+), 32 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_bitops.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_crc.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_logic.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_multiply.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_shift.c

diff --git a/tests/tcg/mips64/test_mips64r6_bitops.c b/tests/tcg/mips64/test_mips64r6_bitops.c
new file mode 100644
index 000000000000..c031a55f504f
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_bitops.c
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: bit count and bit swap */
+
+#define main test_mips64r6_bitswap
+#include "test_mips64r6_bitswap.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dbitswap
+#include "test_mips64r6_dbitswap.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_clo
+#include "test_mips64r6_clo.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_clz
+#include "test_mips64r6_clz.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dclo
+#include "test_mips64r6_dclo.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dclz
+#include "test_mips64r6_dclz.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_mips64r6_bitswap();
+    ret |= test_mips64r6_dbitswap();
+    ret |= test_mips64r6_clo();
+    ret |= test_mips64r6_clz();
+    ret |= test_mips64r6_dclo();
+    ret |= test_mips64r6_dclz();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips64/test_mips64r6_crc.c b/tests/tcg/mips64/test_mips64r6_crc.c
new file mode 100644
index 000000000000..dd8d2d2bfcae
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_crc.c
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: CRC32 */
+
+#define main test_mips64r6_crc32b
+#include "test_mips64r6_crc32b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32h
+#include "test_mips64r6_crc32h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32w
+#include "test_mips64r6_crc32w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32d
+#include "test_mips64r6_crc32d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32cb
+#include "test_mips64r6_crc32cb.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32ch
+#include "test_mips64r6_crc32ch.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32cw
+#include "test_mips64r6_crc32cw.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_crc32cd
+#include "test_mips64r6_crc32cd.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_mips64r6_crc32b();
+    ret |= test_mips64r6_crc32h();
+    ret |= test_mips64r6_crc32w();
+    ret |= test_mips64r6_crc32d();
+    ret |= test_mips64r6_crc32cb();
+    ret |= test_mips64r6_crc32ch();
+    ret |= test_mips64r6_crc32cw();
+    ret |= test_mips64r6_crc32cd();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips64/test_mips64r6_logic.c b/tests/tcg/mips64/test_mips64r6_logic.c
new file mode 100644
index 000000000000..c4c4c4c32164
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_logic.c
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: logical */
+
+#define main test_mips64r6_and
+#include "test_mips64r6_and.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_nor
+#include "test_mips64r6_nor.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_or
+#include "test_mips64r6_or.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_xor
+#include "test_mips64r6_xor.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_mips64r6_and();
+    ret |= test_mips64r6_nor();
+    ret |= test_mips64r6_or();
+    ret |= test_mips64r6_xor();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips64/test_mips64r6_multiply.c b/tests/tcg/mips64/test_mips64r6_multiply.c
new file mode 100644
index 000000000000..fceacbbed065
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_multiply.c
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: multiply */
+
+#define main test_mips64r6_mul
+#include "test_mips64r6_mul.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_muh
+#include "test_mips64r6_muh.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_mulu
+#include "test_mips64r6_mulu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_muhu
+#include "test_mips64r6_muhu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmul
+#include "test_mips64r6_dmul.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmuh
+#include "test_mips64r6_dmuh.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmulu
+#include "test_mips64r6_dmulu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmuhu
+#include "test_mips64r6_dmuhu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_mips64r6_mul();
+    ret |= test_mips64r6_muh();
+    ret |= test_mips64r6_mulu();
+    ret |= test_mips64r6_muhu();
+    ret |= test_mips64r6_dmul();
+    ret |= test_mips64r6_dmuh();
+    ret |= test_mips64r6_dmulu();
+    ret |= test_mips64r6_dmuhu();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips64/test_mips64r6_shift.c b/tests/tcg/mips64/test_mips64r6_shift.c
new file mode 100644
index 000000000000..786dfe84bef4
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_shift.c
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: variable shift */
+
+#define main test_mips64r6_sllv
+#include "test_mips64r6_sllv.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_srav
+#include "test_mips64r6_srav.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_srlv
+#include "test_mips64r6_srlv.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dsllv
+#include "test_mips64r6_dsllv.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dsrav
+#include "test_mips64r6_dsrav.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dsrlv
+#include "test_mips64r6_dsrlv.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= test_mips64r6_sllv();
+    ret |= test_mips64r6_srav();
+    ret |= test_mips64r6_srlv();
+    ret |= test_mips64r6_dsllv();
+    ret |= test_mips64r6_dsrav();
+    ret |= test_mips64r6_dsrlv();
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index c80a3716f559..495acf3b81a6 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -27,38 +27,11 @@ endif
 tests = []
 
 tests_mips64r6 = [
-  '../mips64/test_mips64r6_and.c',
-  '../mips64/test_mips64r6_bitswap.c',
-  '../mips64/test_mips64r6_clo.c',
-  '../mips64/test_mips64r6_clz.c',
-  '../mips64/test_mips64r6_crc32b.c',
-  '../mips64/test_mips64r6_crc32cb.c',
-  '../mips64/test_mips64r6_crc32cd.c',
-  '../mips64/test_mips64r6_crc32ch.c',
-  '../mips64/test_mips64r6_crc32cw.c',
-  '../mips64/test_mips64r6_crc32d.c',
-  '../mips64/test_mips64r6_crc32h.c',
-  '../mips64/test_mips64r6_crc32w.c',
-  '../mips64/test_mips64r6_dbitswap.c',
-  '../mips64/test_mips64r6_dclo.c',
-  '../mips64/test_mips64r6_dclz.c',
-  '../mips64/test_mips64r6_dmuh.c',
-  '../mips64/test_mips64r6_dmuhu.c',
-  '../mips64/test_mips64r6_dmul.c',
-  '../mips64/test_mips64r6_dmulu.c',
-  '../mips64/test_mips64r6_dsllv.c',
-  '../mips64/test_mips64r6_dsrav.c',
-  '../mips64/test_mips64r6_dsrlv.c',
-  '../mips64/test_mips64r6_muh.c',
-  '../mips64/test_mips64r6_muhu.c',
-  '../mips64/test_mips64r6_mul.c',
-  '../mips64/test_mips64r6_mulu.c',
-  '../mips64/test_mips64r6_nor.c',
-  '../mips64/test_mips64r6_or.c',
-  '../mips64/test_mips64r6_sllv.c',
-  '../mips64/test_mips64r6_srav.c',
-  '../mips64/test_mips64r6_srlv.c',
-  '../mips64/test_mips64r6_xor.c',
+  '../mips64/test_mips64r6_bitops.c',
+  '../mips64/test_mips64r6_crc.c',
+  '../mips64/test_mips64r6_logic.c',
+  '../mips64/test_mips64r6_multiply.c',
+  '../mips64/test_mips64r6_shift.c',
 ]
 
 foreach src: tests_mips64r6
-- 
2.55.0


