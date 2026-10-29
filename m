Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC4606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TnHZ7zwJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WHos9LiF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTtf-0000Bj-GH; Thu, 29 Oct 2026 13:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsq-0007bl-HE
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsm-0001S5-Ij
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:48 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGCxWT1619559
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jCxaYWs+FKfV/TL5ufZ9pSoFYfasGIZg5nYt6NZYc78=; b=TnHZ7zwJsPW1520A
 eqRgxTEt+C8z/h0ogfvrQf68VA87YxtrtjkHtNngZ2uULuOXlRGAzBFRk34knaq/
 vBZuL9WJegXwx6CPvsBZp+gGaFpehI9ArqYp3vtqmIx+rLYgEoISDCtGGI5UWr+1
 4F+sRooBhJED5UtCG4pEVEZSCjuM9PXBTmqb1SCJHBowjH5JqGVGXx1ISIUjzcuu
 j2h0XrDxZSGBjvVmXYJQ+AgUw3t1PJk9EKiPNjpwNAIzHXCmArnnMW30qqwu4CvN
 cv0RLPW1q8KVkF00PQb2QEj5ozlAyZw3xCOFy4xbsUbkbjLdCO/HIFM8HA8kJdqn
 BxlwFA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q9ta7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:41 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9913f410ba2so162457241.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294740; x=1793899540; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jCxaYWs+FKfV/TL5ufZ9pSoFYfasGIZg5nYt6NZYc78=;
 b=WHos9LiFCeTrtFW5aNo8QzELHwN0jfcSnr2HalkFzTXVgySAwOAgV8m+qQ/pKktbgQ
 pSKXxLg+rfc9RWxlzxFIfvJ358R5BPbx3iey9+hxvWuwbp35jSAbrBsazlkglQCt34Tv
 JQDOGm7A6y1z9gnwH//CYnbplOww81CerFCHVkBpCRZzSrBV2Bk9s9YvRCit2bQ2D2MS
 +DomJyDtScSChIqqyjmPPdFM/WnOXMnm9W+rP1fnfGtpSPnmKMVWCEZ0pY9ad2+og2sQ
 YCMHXm8RK8yJvNVGiCmtl6+L8lPD/cCY7ExkX9doDjOq9P4UkvoH5PssWQXzdiqCrvXg
 L5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294740; x=1793899540;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jCxaYWs+FKfV/TL5ufZ9pSoFYfasGIZg5nYt6NZYc78=;
 b=EOI0ILm3eHvRRXXO9Su55ue3BfOI2GGyocA0X/iriK4bhQpHLN/fXClt170PA/gJBC
 YcnWsEWatC5qpx08SRjGrCLO1udPBspGd35+FREterIbZlrefxtAmRdZYAUKrpBVG55Y
 DWxi5d8tpIrJYozdqUNIv556gi8TbIg0p3x6bHgIwEXs5RZOXGybSeYGS0rJp35LF3lE
 3UuxD0KbeghplJ2VZmKGWca9omcLXzUR9azQWW4KiPJU7n/CW5FWVO9Bta7wL/uKDY/a
 elzxIyfJD3U4bUIB5HUUv5yEiFXb6y/45pS6LK5ZZfAA1Zwl0lZeJfaL40ITzZd/LeHH
 GHgQ==
X-Gm-Message-State: AFq9FYLgG2+2z7b5kcD4WqNfKyfMPK0rcn8HVPHDdBBbEbCfJAobkofB
 j4fpysbQ5DJfw/n9Di1/hbVJb4IdSeCZE0i+6fKQ20YGF6BW3SOsPa6uu4qm9hlX+ZyXSY+mXZS
 b3e0sequjecenIXzzmYTgypPCu9wqAyE2VeR/I6pNbTqEsH4HnnDKHBLPx9s5z9iTp9Aq
X-Gm-Gg: AYBFou0j7//dUClWj1y9Vh4A70eORL2kvlazSM8tqcFMlib/5YuXX0QvMImTUkaDNTU
 saaVLMtk0jQh3fzN8wVt9hwsK/mDqv4fNzbZoHQlC7TYNtGXyPrSx7/II6nRcPLKDROns1uS4EH
 YkkwDP2LzAPSJ2TilCKR7NVKwHbJe33mQQS67/fqwvxswc7+DoCmrOwS3uANoTyxC2Gr7Sj/On4
 x1CYD2eKytk3reNMWrqOjGjX+qszcUzED+fTBELC+ava4Y0DMnYsHDKHQ/GN0BV5MQRvQVFSXMl
 IVGpa5OBz9+DaIsEFA9fqTrlFAA4YOxTFkvqgJRPkaBsLYdRavKGGQtx72qxozXOOTHJq4SeqD6
 T70+vNnyVaXbedPCuj5xLKv5fAdS8R81OVNXL7wrC8RdZ4unDdm6Bgz6GI/15+moyJPlZ0Ar0Mj
 4ktGOjqOIvzFJAvnKWmaXEA8PatDvxtw==
X-Received: by 2002:a05:6102:80a5:b0:7a7:19aa:f0d4 with SMTP id
 ada2fe7eead31-7d03a651783mr2409575137.33.1793294740169; 
 Thu, 29 Oct 2026 10:25:40 -0700 (PDT)
X-Received: by 2002:a05:6102:80a5:b0:7a7:19aa:f0d4 with SMTP id
 ada2fe7eead31-7d03a651783mr2409569137.33.1793294739632; 
 Thu, 29 Oct 2026 10:25:39 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfa0610sm476667f8f.31.2026.10.29.10.25.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:25:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 19/31] tests/tcg/mips: Group MSA int-add tests
Date: Thu, 29 Oct 2026 18:23:03 +0100
Message-ID: <20261029172319.25766-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX6v3/mHzq3Twn
 bSfqp7MdCA7vVcloLVQttzZAu5dsbFqpK+T7Y7x2Ng24oURyLIS6CZIqraQ43+Ee+/jwo3xNwQt
 M7ShNmgz1ekOfsYJbpGSODm60t5azhs=
X-Proofpoint-ORIG-GUID: AtaQMDgIqW6bOds89auwq04PwjAuRs7u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX7raMDnOYGyqC
 SXBu+I8UCumPHsC/GQiJC8rNVr4tdklm5f22tzKjyitygkxUi+OI2vYBQyhti+jb4qdnAaC2LOv
 IYHe5N1OsgOhRXHRU63g3FGJ44+sKCsayC/lol2uYsGGFhbthpLusqGtTH4q+DKm6MGaBsdwetz
 BIO+fsAj+RmWFpShnakndG3XlnpXnLKeRfsSXtSGcsQSkr4ffEtQjOpgcGATOoBexjI1IrLulX7
 4UdfQ8JKDvHwB/pNEdgevftTDYGSARjCKOGDNM1m3Xg7dz+AHdpdQa9tboRlNXUZShYXM4qpjQv
 mYalLYDmQeFxtSnY2s7CVYmU5uaD8n2pPNiTv0dhQq1Ce9CtXxC1QhR/D31Hd0vDx2cEKgIM8e1
 cpFvCM/a21OiUXbDVB+gTtmZESyfJ+1dZNiKztOImWwkEFd98NY8+L9ckGXA14b/s6LyFJ9FWtJ
 i7rRrlvkh2LH17BmNgw==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae38195 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=xSJLvnGiI23x1uoAYFQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: AtaQMDgIqW6bOds89auwq04PwjAuRs7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the 26 per-opcode int-add tests as a single executable,
test_msa_int_add.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_add.c | 187 ++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build        |  26 -----
 tests/tcg/mips64/meson.build      |   1 +
 tests/tcg/mipsel/meson.build      |   1 +
 4 files changed, 189 insertions(+), 26 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_add.c

diff --git a/tests/tcg/mips/test_msa_int_add.c b/tests/tcg/mips/test_msa_int_add.c
new file mode 100644
index 000000000000..aa7165f42f2d
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_add.c
@@ -0,0 +1,187 @@
+/*
+ * MIPS MSA tests: Int Add instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_add_a_b
+#include "user/ase/msa/int-add/test_msa_add_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_add_a_d
+#include "user/ase/msa/int-add/test_msa_add_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_add_a_h
+#include "user/ase/msa/int-add/test_msa_add_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_add_a_w
+#include "user/ase/msa/int-add/test_msa_add_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_b
+#include "user/ase/msa/int-add/test_msa_adds_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_d
+#include "user/ase/msa/int-add/test_msa_adds_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_h
+#include "user/ase/msa/int-add/test_msa_adds_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_w
+#include "user/ase/msa/int-add/test_msa_adds_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_b
+#include "user/ase/msa/int-add/test_msa_adds_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_d
+#include "user/ase/msa/int-add/test_msa_adds_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_h
+#include "user/ase/msa/int-add/test_msa_adds_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_w
+#include "user/ase/msa/int-add/test_msa_adds_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_b
+#include "user/ase/msa/int-add/test_msa_adds_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_d
+#include "user/ase/msa/int-add/test_msa_adds_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_h
+#include "user/ase/msa/int-add/test_msa_adds_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_w
+#include "user/ase/msa/int-add/test_msa_adds_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_b
+#include "user/ase/msa/int-add/test_msa_addv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_d
+#include "user/ase/msa/int-add/test_msa_addv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_h
+#include "user/ase/msa/int-add/test_msa_addv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_w
+#include "user/ase/msa/int-add/test_msa_addv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_s_d
+#include "user/ase/msa/int-add/test_msa_hadd_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_s_h
+#include "user/ase/msa/int-add/test_msa_hadd_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_s_w
+#include "user/ase/msa/int-add/test_msa_hadd_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_u_d
+#include "user/ase/msa/int-add/test_msa_hadd_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_u_h
+#include "user/ase/msa/int-add/test_msa_hadd_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_u_w
+#include "user/ase/msa/int-add/test_msa_hadd_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "add.a.b", test_msa_add_a_b },
+    { "add.a.d", test_msa_add_a_d },
+    { "add.a.h", test_msa_add_a_h },
+    { "add.a.w", test_msa_add_a_w },
+    { "adds.a.b", test_msa_adds_a_b },
+    { "adds.a.d", test_msa_adds_a_d },
+    { "adds.a.h", test_msa_adds_a_h },
+    { "adds.a.w", test_msa_adds_a_w },
+    { "adds.s.b", test_msa_adds_s_b },
+    { "adds.s.d", test_msa_adds_s_d },
+    { "adds.s.h", test_msa_adds_s_h },
+    { "adds.s.w", test_msa_adds_s_w },
+    { "adds.u.b", test_msa_adds_u_b },
+    { "adds.u.d", test_msa_adds_u_d },
+    { "adds.u.h", test_msa_adds_u_h },
+    { "adds.u.w", test_msa_adds_u_w },
+    { "addv.b", test_msa_addv_b },
+    { "addv.d", test_msa_addv_d },
+    { "addv.h", test_msa_addv_h },
+    { "addv.w", test_msa_addv_w },
+    { "hadd.s.d", test_msa_hadd_s_d },
+    { "hadd.s.h", test_msa_hadd_s_h },
+    { "hadd.s.w", test_msa_hadd_s_w },
+    { "hadd.u.d", test_msa_hadd_u_d },
+    { "hadd.u.h", test_msa_hadd_u_h },
+    { "hadd.u.w", test_msa_hadd_u_w },
+};
+
+int main(void)
+{
+    int fail = 0;
+    unsigned i;
+
+    printf("TAP version 14\n"
+           "1..%u\n",
+           (unsigned)(sizeof(msa_tests) / sizeof(msa_tests[0])));
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        int r = msa_tests[i].fn();
+
+        printf("%s %u - MSA %s %s\n", r ? "not ok" : "ok", i + 1,
+               "Int Add", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 413879c205c2..98bd391ee22b 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -85,32 +85,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
   '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
   '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_w.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index adc9eda70f3c..584b69812a54 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -45,6 +45,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_bit_set.c',
   '../mips/test_msa_fixed_multiply.c',
   '../mips/test_msa_float_max_min.c',
+  '../mips/test_msa_int_add.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index fd4325f817a6..5140ada24cc0 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -46,6 +46,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_bit_set.c',
   '../mips/test_msa_fixed_multiply.c',
   '../mips/test_msa_float_max_min.c',
+  '../mips/test_msa_int_add.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


