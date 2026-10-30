Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D994606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RjDj22ZW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Im9Rrtx5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAt-0003iE-CG; Fri, 30 Oct 2026 11:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAk-0002hX-EY
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAi-0007WU-Fm
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERGZK2495208
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bxsu9u4oVKDtEZe4QmXdSZ1Vhttc+BXVOJdADv7LnSc=; b=RjDj22ZWc+K5n2Ws
 2+BiHL6RcSM/fgBb15liR+MsHz4rbWnFhhQ1iJyVK8ZVMjBwaeYMkZR3I9aXf70M
 VIgkzz8reUb3cco5bMcKULgalN7ydurGaagGbamQtxXeeevzxBvIczqBptUL6aDE
 9532K2Lw88vg/CrnymUfkaJyHgW8UaVB8YOSIhtyXHbFBwu7svcwqVSXUK+biPzn
 Fy1spzTuwspN45WcctZceoTd1ra4OJ8s+VXU9Kt/GBKEcQ3udXBOfZiJSqT2jlu3
 FoINR06z/4yWERyofzudQb9z1vFdo4DCxMv369pCG5u6xdEXgp4gAUVjbRBfl1BE
 ftc/MQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p3psf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:35 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99076c676cbso191441241.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372734; x=1793977534; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bxsu9u4oVKDtEZe4QmXdSZ1Vhttc+BXVOJdADv7LnSc=;
 b=Im9Rrtx55cqOQ3QOKxeVFWdyWRFFmwio/r6Q72ISuHpzIouxFy81KTuRCEe5E31B6Q
 Drg7r5dr1w2n4OlVVpbuDZYbvYxATKRPD1eqpUy7mNTukKVRF8WneTUTIhFjy+GP1Rye
 z8jHqhbwp42zALC68ROmDl0zsJrRfsRVMifMthDYhVOsunHVsRIM3YpDmOkrzQYTgNKy
 tBJw6eHy/oomTu159Ky4XYBbleBeDsTrJViHiHtK1RI1DGtHZB4zSHqBQkZZtatNDLxv
 k+VKBeaEtiM0gStf4zvUWuAeJDkA7GNc5VIxwAr/fTp9db2GsaJxb5NdUFAOV3TEFAMP
 7wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372734; x=1793977534;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bxsu9u4oVKDtEZe4QmXdSZ1Vhttc+BXVOJdADv7LnSc=;
 b=1PC9DqmubOEWJEhZJun7ZY2qhgOk2Li/yPqiZSilSsAi80i6DoK0VvlkMN3DfSVg8Q
 pI7wwkSjLIESb3nYiDGvSw8PLlyW1Ul0v3MEyUlSg5Fg5cV+wi/4uR8RR/SOFTPg2kkg
 dbtNKCy1Pr+umhAXqNWapgXy5DtjdUQbB4p+oDI/GxXXJ+qlF7qd2zgi0wLHWaLC1f3t
 0QSh5uTew7y0nWFniNn4vhzAA63nPRsLvZ0XHh1aImtglxIpD33AxIsOYNIIDWU9Fywx
 pfWtucb+UbSyRuD+Hxk+YLPVxY/4hMciYfnbnz3z6ux63fwmKgYfkwi57j9Zx9KWsBRO
 Aliw==
X-Gm-Message-State: AFq9FYLvQ9EAZ3vRNQIVDPGFOJi3LrxuKX3ZMVUXJAcZQ1mhxlIxQmis
 z3DwXGiPSphstVEUhcctFSavyIlhzz5hP93uEiHGA52LtasMD9/GOR80saqymtIcNY8h9eGSRs7
 xuzj4jCovxy2/G85Ajz5WqWkeudLF0F5YLgn1Oda5efAISs7H3te0xzGhnCnNv+X37g98
X-Gm-Gg: AYBFou3e+Bd5LdkTtLlsgLvPStQEnTy048Or5wAciI0uAF87fZjtwl21GeQXJvw/Xkc
 iqJhBxMfnE3pV2eE+E2npS8jonHjYiff13uuhflFjb0cNs0jzecgc3W3VZip794rTp/hPBCYz50
 hVcMHmwi8lPSa7J5ROLA1HpLeLTQCcLI4Z4MKlKyyf3iCigBhJWhI97gyKzAixPYRyjLyOQy1m5
 RaWZ7Ph0bp/OT6HqtI/T514fGCZdXMmtB5LP3nTM18BrygylKLZmOD8E/dckHbcCfu9CQuXQP7t
 2zZA1vVyno43msyAt3otFXsQZvmHbdWAGidRMoh/mxG0nxwofxf/+WqhhVqxLZVaEnE1K5BpmjK
 daMZYQqr+D6IO5Jh9dd0bK10hzB8B3cDym5/pqYZYfrRZsGJsFV3uo/OrxteDVRMqk8C5Ba34AJ
 1PbrA54XV1IXrkfSlMm0tquTuRrdK62A==
X-Received: by 2002:a05:6102:689a:b0:7c3:7286:b7ea with SMTP id
 ada2fe7eead31-7d072c18c5fmr1281636137.17.1793372734498; 
 Fri, 30 Oct 2026 08:05:34 -0700 (PDT)
X-Received: by 2002:a05:6102:689a:b0:7c3:7286:b7ea with SMTP id
 ada2fe7eead31-7d072c18c5fmr1281509137.17.1793372732449; 
 Fri, 30 Oct 2026 08:05:32 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm144178235e9.4.2026.10.30.08.05.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:05:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 24/31] tests/tcg/mips: Group MSA int-max-min tests
Date: Fri, 30 Oct 2026 16:01:54 +0100
Message-ID: <20261030150202.61556-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX4N/ul82Iw84U
 aOzWqKMAtYKhY7CQXp2hOwYC/QyE8kW5cC3SWaezYfUjGFP8sEyJyzIjGWOeJ9cJT9P4U1PUvLM
 pE5xoZvggQr+EmbnhVkbOA6K0jtgyIZA2MSGbjT4KY9alz6Dg3H9oICLf1g+z/iZTewttrZAWJA
 6yyAer2pLiqIQz+h7WU/jE5FenxZkXqbGVputnVxmeu/8fQ8FCv6X1FTiTfk1YE52vZYCZK/iD8
 W94rqS81TwfOIJbx9fiToVAACgYN9oNfWFwcU1oLAGzaXWCRfFuiam6UUutfpdIWQ4yt23F43EO
 jf9psag2hPJnEKyfgYFZsyUMfDl9v2X5B4BRMFO9orTIGP/8fSUl+53turNOJgxmKySZ6Ui04hO
 ZomLpzttcSZ0tm9aj5ZPspMm/IcaGHOW4pT6bnmkk0NBBI8W8IQ1touCmN2tVBXVxfGRQZ7QkHa
 U/8x61nh6UC1hdPQ+6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX5SLrqV9oQL4e
 dQJcepx1lEI7hf6UNI3PupgHp/GgPAAPc7xU2e11ICsNGpcqIYae+AIAiK+LLqMdqhYerTiD+jX
 9/lKtBk3rahGZNGvDfo9gMWwvYK0MdA=
X-Proofpoint-ORIG-GUID: pV_pT-YTGPOWrnV1pGhqoo6jmXX2PPnr
X-Proofpoint-GUID: pV_pT-YTGPOWrnV1pGhqoo6jmXX2PPnr
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4b23f cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=31ySfBESk6nFzokIpWYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
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

Build the 24 per-opcode int-max-min tests as a single executable,
test_msa_int_max_min.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_max_min.c | 171 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build            |  25 +---
 2 files changed, 172 insertions(+), 24 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_max_min.c

diff --git a/tests/tcg/mips/test_msa_int_max_min.c b/tests/tcg/mips/test_msa_int_max_min.c
new file mode 100644
index 000000000000..83eac723dd78
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_max_min.c
@@ -0,0 +1,171 @@
+/*
+ * MIPS MSA tests: Int Min / Max instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_max_a_b
+#include "user/ase/msa/int-max-min/test_msa_max_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_a_d
+#include "user/ase/msa/int-max-min/test_msa_max_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_a_h
+#include "user/ase/msa/int-max-min/test_msa_max_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_a_w
+#include "user/ase/msa/int-max-min/test_msa_max_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_b
+#include "user/ase/msa/int-max-min/test_msa_max_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_d
+#include "user/ase/msa/int-max-min/test_msa_max_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_h
+#include "user/ase/msa/int-max-min/test_msa_max_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_w
+#include "user/ase/msa/int-max-min/test_msa_max_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_b
+#include "user/ase/msa/int-max-min/test_msa_max_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_d
+#include "user/ase/msa/int-max-min/test_msa_max_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_h
+#include "user/ase/msa/int-max-min/test_msa_max_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_w
+#include "user/ase/msa/int-max-min/test_msa_max_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_b
+#include "user/ase/msa/int-max-min/test_msa_min_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_d
+#include "user/ase/msa/int-max-min/test_msa_min_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_h
+#include "user/ase/msa/int-max-min/test_msa_min_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_w
+#include "user/ase/msa/int-max-min/test_msa_min_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_b
+#include "user/ase/msa/int-max-min/test_msa_min_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_d
+#include "user/ase/msa/int-max-min/test_msa_min_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_h
+#include "user/ase/msa/int-max-min/test_msa_min_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_w
+#include "user/ase/msa/int-max-min/test_msa_min_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_b
+#include "user/ase/msa/int-max-min/test_msa_min_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_d
+#include "user/ase/msa/int-max-min/test_msa_min_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_h
+#include "user/ase/msa/int-max-min/test_msa_min_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_w
+#include "user/ase/msa/int-max-min/test_msa_min_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "max.a.b", test_msa_max_a_b },
+    { "max.a.d", test_msa_max_a_d },
+    { "max.a.h", test_msa_max_a_h },
+    { "max.a.w", test_msa_max_a_w },
+    { "max.s.b", test_msa_max_s_b },
+    { "max.s.d", test_msa_max_s_d },
+    { "max.s.h", test_msa_max_s_h },
+    { "max.s.w", test_msa_max_s_w },
+    { "max.u.b", test_msa_max_u_b },
+    { "max.u.d", test_msa_max_u_d },
+    { "max.u.h", test_msa_max_u_h },
+    { "max.u.w", test_msa_max_u_w },
+    { "min.a.b", test_msa_min_a_b },
+    { "min.a.d", test_msa_min_a_d },
+    { "min.a.h", test_msa_min_a_h },
+    { "min.a.w", test_msa_min_a_w },
+    { "min.s.b", test_msa_min_s_b },
+    { "min.s.d", test_msa_min_s_d },
+    { "min.s.h", test_msa_min_s_h },
+    { "min.s.w", test_msa_min_s_w },
+    { "min.u.b", test_msa_min_u_b },
+    { "min.u.d", test_msa_min_u_d },
+    { "min.u.h", test_msa_min_u_h },
+    { "min.u.w", test_msa_min_u_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Max Min", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 2d2dc60789b9..c10d4e7342f4 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -12,6 +12,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_compare.c',
   '../mips/test_msa_int_div_mod.c',
   '../mips/test_msa_int_dot_product.c',
+  '../mips/test_msa_int_max_min.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -136,28 +137,4 @@ tests_mips_msa = [
   '../mips/user/ase/msa/logic/test_msa_and_v.c',
   '../mips/user/ase/msa/logic/test_msa_xor_v.c',
   '../mips/user/ase/msa/move/test_msa_move_v.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c',
 ]
-- 
2.55.0


