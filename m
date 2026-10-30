Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040DA606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UX49YYgq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aqZnQ/sV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqs0-0000va-Ld; Fri, 30 Oct 2026 13:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqqk-0008J6-39
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqqh-0008Iy-D9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHuQlH411154
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I9kYTVvJAtaI8oIgstgeblI6rSZ5zFGFIV1Twkx7UjM=; b=UX49YYgqt/CVbM+4
 BM/TPJnivcr9hjy4wK+pd6ZkVwblXm0G5cSbQ3nkkdyP5fNZORLW0ea6HziMIAYj
 Epr1sTPxUxvQw6JA3pSW9QcDaJdZVPMITUzRLCi99iKNRiKAuKp5+PNwNXDU4+kn
 FXoTYNN92tLs1b5N1bgFsYw5r0qRlRssLJgmsD8rc656hA0MyQS/N/FIf8raNgcb
 qugH0hFHmg+7WqpjfHtrj1223YGa7Catk7BQpM0003mlj1V0/jRuO12FIxawLPQL
 kRROyP7d2QQW7ZJRQe8KRZcXmRr9/SPtbnZ4yDgdo+G7gzBTQlI5uT6oZf/2SucZ
 7Eeg+g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qv9cq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:05 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-98304865f02so806331241.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383024; x=1793987824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I9kYTVvJAtaI8oIgstgeblI6rSZ5zFGFIV1Twkx7UjM=;
 b=aqZnQ/sVK7kTUJTdLIvJGziGftcnSmA8BMw3Hb5YazC1vwSrFgtWoe+ifKNNTt2Mok
 aULQ+5xZoHxORuXxoOyhx9WhdG5hdwOIDzfH4Kxp6Z5uJec/DW2/r4DQYBI485zFMVy7
 s44gnm72eRgkfZamltN8dYjk7SOSxp/6FsnDPiH8W2sfotDp0bBsfrJCxOH3ou07gWQq
 IbaS4gW6rrY2mfDz6M95dcnUZj9vR+D+8O1G63f+3dOSVJZbigtIti4lQfWXuTW2uqnJ
 EA5cC/FYSMA5T3Rhd1U6EppIzVwCs2Ke+SpWAEeGFKGH3R0fpY5dBgjKMa/Orq22EaTX
 fWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383024; x=1793987824;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I9kYTVvJAtaI8oIgstgeblI6rSZ5zFGFIV1Twkx7UjM=;
 b=fFTARV8ZozDBnvwIJUafZjfxIwmiOvSgXD7CbazXFZ9YZ8Wsk8w3XLZFIaAcXImro/
 q7rOezVKnKA6PBDXf9AorEIvX33xAasi4VaZWoCzR+Xr2JLc+tzJ/PywaLOh/6uvxIgM
 84Hl8ohEfS+JYwU7+3g02EIwBFqclhNPNrWzGnfhEZhEUybyaX5kt/7U+uPW7kTXJMOK
 NIQZfC+YDUnyUSmoCUBmnBlJVDEhFPbzwfbPyMX/6gcbFPWA2jlKe5JeAzhYpZcRPQix
 6N972bgJYzRwKgG8kgPFPWpC8JQ/Ark1dDoLeCHkvXvpnfQse2PSJhVobL4DY2adJj9z
 7v6w==
X-Gm-Message-State: AFq9FYLA0Liej6Tb1yrKMWOt9exwDRQbmXY1UHqQcDe33dkpr8li3Iq7
 AuH7L2Rd2T7So6H+TRZO5EXRN8hAHPuypA0IV2p9srlgGn8/3rWbRk+UV9Jts7wKqldWSVfu1dA
 haLTaq+hTcUTqfK4ozeJ6ryBEc6zRGsSBEi6ShqUSj/L5YUZwTSIY5lOuwmSygV/Bx8Fa
X-Gm-Gg: AYBFou2RRSNbN9Ymq7eLS6oSi/3Q0lN9l8BuyKWC8q8yDYuNX1r/APW+XJ8JIZuzJm1
 W55Xf/tKDwO+sscGbgDds6AQVYAjodHju1s6soB3jl/1zgg3Xe4cwG8Y2WaunVVuHZrW4of6Xly
 PLBO1zVscOUMm8YWJxFcl9KyXDWa/PFGYcIyqF/9S6mgUgiTZHXW58MSG6PXAOld6DnwjXh7/7+
 BkIJIaHoujJlanqxscZdQ/ynFTEWPOFB51j+w405ZXlMq0rhLqohIA4MTw36ZIDnqHJq6XEwmUn
 O4pqcVlC3o7kpBIE0Qvb4sDfVMTov0X797MANI5dSFSHHldLazfgYpPmLwDqcfvmhbxMwczWOUS
 J9zUEfINAFNxZNG0j1eBkBR8WK0J6qrFmB97sKRGKsjRg9kgpA1wwOVb/ROQoOMMrncV42sne+e
 ZL09z2YGwz6viZaxfR3hVnRcd5flk7uw==
X-Received: by 2002:a05:6102:149c:b0:7ad:3ad3:997a with SMTP id
 ada2fe7eead31-7d072247aa7mr1825158137.5.1793383024359; 
 Fri, 30 Oct 2026 10:57:04 -0700 (PDT)
X-Received: by 2002:a05:6102:149c:b0:7ad:3ad3:997a with SMTP id
 ada2fe7eead31-7d072247aa7mr1825143137.5.1793383023847; 
 Fri, 30 Oct 2026 10:57:03 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8c6e9sm4340910f8f.43.2026.10.30.10.57.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:57:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 22/32] tests/tcg/mips: Group MSA int-compare tests
Date: Fri, 30 Oct 2026 18:53:44 +0100
Message-ID: <20261030175357.99684-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: y3G7ovoyiSZgL8Loe1dvKsma4Xi61VbO
X-Proofpoint-ORIG-GUID: y3G7ovoyiSZgL8Loe1dvKsma4Xi61VbO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXy01VF5/JlmuQ
 FiHspVzsQcA+VcNxmM6XyPS9f9YVks4r0R7Gj6WI8E0/x1POQR9pa0DDqqv7BwUevbe9KVQHy4F
 7Q2E+FM9ahxHvQ0mc2bDwplKogvZa8kvUCluYA1es8BYJMg1BFiIQPKH6U/FmKSyTG1S0G5V9DA
 kF3fJrJCYP0GfMsD47XvF/ho8rgVXgWisuAlnfaufVufjp582rKfwKJqDy3QUXNcrIQbeiGcKGN
 k6QRM4XGqQ3kZVq61Ci1Og7Wm0BBzOfZyCtm4rLfcmpL4k/SGpZuWkHaYKasIlHsVhPcION9CJQ
 e/lZ2cKTI8+Fv1MbRSoNaLX0K0tMF4efeV1JVj1BaOXYoA7B3lcl3WXxl3eQzH2OidWqSF/dJ4H
 Gdoo5JF8xQLruFMZmbbz7pshGaQcroOreAnX5ZYk3pzc9xlQMBwNgS+hGNF1G1by2/ES2ZRZ5oO
 f2dpmS1ST09madLNrBA==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4da71 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=MrkvrxfUm_GaFPyPbecA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX7u4/kEDhxdU8
 MwBDkV6NUfjhi6ApRma3nB4maFslIrSle/6nQaVuxpRbIUW52VmBhsbS4t8iJ+XQZEebQoQWVTK
 vYiFv1jMM/ELaWCFUWsPcXtCs5qiOVM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
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

Build the 20 per-opcode int-compare tests as a single executable,
test_msa_int_compare.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_compare.c | 147 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build            |  21 +---
 2 files changed, 148 insertions(+), 20 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_compare.c

diff --git a/tests/tcg/mips/test_msa_int_compare.c b/tests/tcg/mips/test_msa_int_compare.c
new file mode 100644
index 000000000000..b500772be5d5
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_compare.c
@@ -0,0 +1,147 @@
+/*
+ * MIPS MSA tests: Int Compare instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_ceq_b
+#include "user/ase/msa/int-compare/test_msa_ceq_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ceq_d
+#include "user/ase/msa/int-compare/test_msa_ceq_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ceq_h
+#include "user/ase/msa/int-compare/test_msa_ceq_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ceq_w
+#include "user/ase/msa/int-compare/test_msa_ceq_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_b
+#include "user/ase/msa/int-compare/test_msa_cle_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_d
+#include "user/ase/msa/int-compare/test_msa_cle_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_h
+#include "user/ase/msa/int-compare/test_msa_cle_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_w
+#include "user/ase/msa/int-compare/test_msa_cle_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_b
+#include "user/ase/msa/int-compare/test_msa_cle_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_d
+#include "user/ase/msa/int-compare/test_msa_cle_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_h
+#include "user/ase/msa/int-compare/test_msa_cle_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_w
+#include "user/ase/msa/int-compare/test_msa_cle_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_b
+#include "user/ase/msa/int-compare/test_msa_clt_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_d
+#include "user/ase/msa/int-compare/test_msa_clt_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_h
+#include "user/ase/msa/int-compare/test_msa_clt_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_w
+#include "user/ase/msa/int-compare/test_msa_clt_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_b
+#include "user/ase/msa/int-compare/test_msa_clt_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_d
+#include "user/ase/msa/int-compare/test_msa_clt_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_h
+#include "user/ase/msa/int-compare/test_msa_clt_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_w
+#include "user/ase/msa/int-compare/test_msa_clt_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "ceq.b", test_msa_ceq_b },
+    { "ceq.d", test_msa_ceq_d },
+    { "ceq.h", test_msa_ceq_h },
+    { "ceq.w", test_msa_ceq_w },
+    { "cle.s.b", test_msa_cle_s_b },
+    { "cle.s.d", test_msa_cle_s_d },
+    { "cle.s.h", test_msa_cle_s_h },
+    { "cle.s.w", test_msa_cle_s_w },
+    { "cle.u.b", test_msa_cle_u_b },
+    { "cle.u.d", test_msa_cle_u_d },
+    { "cle.u.h", test_msa_cle_u_h },
+    { "cle.u.w", test_msa_cle_u_w },
+    { "clt.s.b", test_msa_clt_s_b },
+    { "clt.s.d", test_msa_clt_s_d },
+    { "clt.s.h", test_msa_clt_s_h },
+    { "clt.s.w", test_msa_clt_s_w },
+    { "clt.u.b", test_msa_clt_u_b },
+    { "clt.u.d", test_msa_clt_u_d },
+    { "clt.u.h", test_msa_clt_u_h },
+    { "clt.u.w", test_msa_clt_u_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Compare", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 7da4aece8409..199b1b934a5e 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -9,6 +9,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_float_max_min.c',
   '../mips/test_msa_int_add.c',
   '../mips/test_msa_int_average.c',
+  '../mips/test_msa_int_compare.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -144,26 +145,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/shift/test_msa_srar_w.c',
   '../mips/user/ase/msa/shift/test_msa_srlr_b.c',
   '../mips/user/ase/msa/shift/test_msa_srlr_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_d.c',
   '../mips/user/ase/msa/logic/test_msa_or_v.c',
   '../mips/user/ase/msa/logic/test_msa_nor_v.c',
   '../mips/user/ase/msa/logic/test_msa_and_v.c',
-- 
2.55.0


