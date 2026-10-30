Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85696606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z05hUgxn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D7xnuGOa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoBx-0006br-AF; Fri, 30 Oct 2026 11:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoBV-0005lF-RX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:06:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoBS-0007Z2-VZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:06:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERBUk2494589
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mpdKwFVW0iz0VRrdRr5B/JI3IrlejdTTJva5/3O6xm0=; b=Z05hUgxnVqleKn8d
 Fdvy8RyHVMw2gghupxHv+i80Odkx6U4gDJBhAdWOUGRhqmaGHWMX7gkJGusNj9p/
 VsubZbFcgPBe6mO3pC6yYE+Tfzs327tvUwVl7IAJjrSBOUwPXJPhimu/M5fQ0sU3
 /ptftix/VeJJBAYmL/ZreG5b+ed1QklngDh5djLBlL4QP8ads/I6fv7Pbytmkls2
 gU+u+sYxBoexNSsujEIAVJWc9O1FC2G3qkwB8v6nspT5e1RL++mKK0QHtO6OmPM/
 OQVU1u3PlLw2xkTepAXksvBuFTSZPijOZlFmv7PqBWIX3zkYmW9arALb91kPMHjI
 q06mkA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p3px2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:06:21 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-988bea8fed6so620867241.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372781; x=1793977581; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mpdKwFVW0iz0VRrdRr5B/JI3IrlejdTTJva5/3O6xm0=;
 b=D7xnuGOaVcN+cGkgppzO2xpFLPU5P5kj07mN8mC5AJEbUYDX8dpYh56xM9n9hi0viW
 4aP36OhZRvU5cr+1lIUsf87Y4/J0RIp64Vi9dImdd7RetbAn6dJ5CTRXaDk6kjrIAJLH
 vvuNH1BM+cRsifmWRPg9mEaXtURPVU3/wlBJVi+9BFlpSsyJguOpvoy+qpu/ZGV5u9IT
 iVFhxgdMhJFXBjFpvxJmemCgx2nQTBs+IUifgwSaDqdjKT9JJGpvbheDDrFQDdXD9PMJ
 EGVxSVpZ3SadHzeA/9HK/BjH19gpaj+F8uoxJYby5iFnIul54J8VXXrgiTKU4b7JYmec
 WhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372781; x=1793977581;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mpdKwFVW0iz0VRrdRr5B/JI3IrlejdTTJva5/3O6xm0=;
 b=m8fnk02DTdIq+dLGvdAesw8bAvW9qZOTbq/qEd7dax0GjUnF4fiRKBXs0uR3Vi6I2L
 SXcaKQsvZ8JF2bRYtPNQp6MVpdXEuIZ2PyF8xI86F1LIwA3FSwBNDHPvgNXVkBikNivT
 z58P/kSnoctJ2j5Zeb60BDl3GCDQC/tz+KLe/ZrJKpNsQsSHrlJG/KFvlNmHfCHvOp1G
 f5u4nySRXEYiQVNEaFKsN7jsLXt0F4A+FdhiLrkntZMjklYcIe1xrceMDqDP7/LtETEl
 FsQolkHVpd5O8uFT52bUoWPec39sX+MhFbUa3a5gnSs8iEnATv6vc0zcSEFEtFoCNhyT
 nZfg==
X-Gm-Message-State: AFq9FYKaWheEFwDKhvocgKV3DsJDsMFwYK5trPLxmj4VBqlLQVu5M8Hx
 qP1UsfUQeGMOVSA2yA4Bv0pg44IvKAiYkBV2P811K3NONOUvgqhRKSn/nqCNNm/uxM+5ghivc4V
 wM2ateAu2cMELXqhclw+zKHJ/V8GmQu+A3exVAjIueospb3/cKRlQTSov0RWene8a1RVx
X-Gm-Gg: AYBFou2Q5vn2lb4FyAp+akiSP1KDQH5pcuDDHimHxh0WY3LaAy9H0PD2FLMYsWPAObW
 559ZU54fKTKznVd9LDsemC+ls63caaDzQj68fjNV3WzPzYmRBb5OOOo1ZNzBUuVCAwBx9TUNXMK
 3KOSfP+C6p89vNpJPd6S1veFAyou8uyZgT2KCZHVxaWpCQtQgp+8I6SJE3Jt2S4aMVopKSwD4dK
 GebKQ+il6VVcEvZBsvhp2mXGhDfln4foq5GECc184pZBtwzOAA2zksS/qq+87GdirQlvwaivkx5
 6NzGhUcwfd3F91qVSmp5HE0z/FgnE0ceUw8UvP6hqNpYbYsIJxKke09bmHiYcoKGGyCQVpXw3Pr
 sU3v2Mctspgzyyv2zwMusCR2znmbh1PWko7M0Xukeb3E8qKcyN8URK24vmcg8Wn0/ZGhIKyy3Pq
 2g9xncp0eoSnIE8yUY669WCm7OrVIZcA==
X-Received: by 2002:a67:e111:0:b0:78e:1e0f:ea42 with SMTP id
 ada2fe7eead31-7d07223fbb2mr1313379137.2.1793372781063; 
 Fri, 30 Oct 2026 08:06:21 -0700 (PDT)
X-Received: by 2002:a67:e111:0:b0:78e:1e0f:ea42 with SMTP id
 ada2fe7eead31-7d07223fbb2mr1313280137.2.1793372779032; 
 Fri, 30 Oct 2026 08:06:19 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm144216995e9.4.2026.10.30.08.06.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:06:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 30/31] tests/tcg/mips: Group MSA shift tests
Date: Fri, 30 Oct 2026 16:02:00 +0100
Message-ID: <20261030150202.61556-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX+PEXIym8JtWj
 b7tv7+vr0bdK4ECbPY57b8OrNwPmWHHWWtq7M7Dx15Efk/S61XlySWQ984LZrPZpnqApGThk5QP
 pEgwrK7aGz0XbgF2iPXBgPv89o4wuoXjaq8NwXmSgTzR1f94PCNQJFAeqgdwVdevu7SIRPQ3xJB
 +6sUQPG+05KuEcmiefbTQtkMWCQ9D9hLV7h6FdBJbwHkOYuEnZfzs5dDjisHoY2dYhn36U7nqbO
 AMNb1JVDmx/BeFl7zxz6shAi76nckcPkwMmi6wVeUiyQpuRKdIVVv4lFV0kw3rxReaFVZyB7qX9
 Utu6jn/ao3YAHBQ2WnrhyoFbo+fiBwG0+7TnD7VOaBBvQJ/w8jrl/qwADOlywtdgdwfon3MxRSi
 CYPRfsq1/NyGGBLaPyH8s4qHH45FQKXx1PywLEr7u5CraSY7rYRDdgXPlxpTlfvH6m74/pUu8XU
 Vov2DdykkgkG5eBX+dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX1/unatFruq1k
 k4LRE5fo5jggQqiV/MEjTkdLao+47CyNWK/O6rJadcxaEbabtrQ4Hk69svDl6ErmOPe9ZOKzgVV
 EGXazljX55x629KG25g32RLXKNPRMnE=
X-Proofpoint-ORIG-GUID: 0IBs4vCfXTcsHghsejzwMggMM6a7IlPa
X-Proofpoint-GUID: 0IBs4vCfXTcsHghsejzwMggMM6a7IlPa
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4b26d cx=c_pps
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


