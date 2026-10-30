Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE04606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dThMzNFN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A8R8ar+y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo8Q-00080A-Ce; Fri, 30 Oct 2026 11:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8G-0007iU-0D
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8E-00079N-4t
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:03 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERG1r4141583
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PgIGCs8t50qe1401c13AZT0hnzBuVzHPPVhO0Nzt8Ug=; b=dThMzNFNXmUE5hEc
 zhSe8g9Q8N+YS3Bg3h68oIOBXeXA3mbPznsvv/Di0tKUdojoUTLsMKh8Ez4BhIQS
 uKIINnqpTIcWysfUEkKK9Dmkhgi4HG3LkaSRuOgf8/Hz6E7mdxdi4s99eoHODVYf
 M/BrimC5dHUAMX/Z/LPtQ9KD8ftG0dEfTRypxdcMeYcyABDnoSEZb2dxzkTQ1/UB
 5k1CAFNaIkSzuqSUMHrx0pRzXGxwO/PmFOzCEGn4KPdG9FphFOoiYuQ+P/P9PJLL
 9u6vFI9yJMNpOe3GGlqLfc0v8DWmyV0YyG81iKey8OJfuvofeUFE7JJyC6asJIRw
 maRxYA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qukgd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:01 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf45382794so626498137.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372580; x=1793977380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PgIGCs8t50qe1401c13AZT0hnzBuVzHPPVhO0Nzt8Ug=;
 b=A8R8ar+y9ihRhU/a+di9+4pHdOwI6+8xZJtytOzvuXipAZUixVhEX9fa6nbzD6F1XK
 ZomjaDx+bOnsy/ARPONknU2dQORyeinyk66Gw2Ow5hFpYexwPwG/9g1SkOO0e02xkRP/
 FC5mtkX1aS9FTyJQi3Ww0plX+Kx/4QA2GVS2B3CwYiZJlBMDh5WtLpM3eFf/fEtiGsLf
 o9ErMO6NzBnJKiPdN0jVqZ+DxMLFGr12h+mrMpwXGRyqbvZeNCs9NQH9U/mhsWcFDg8d
 THC5jSaQpE1xuUbvahmrqyZdPh70bY4zwzwwYexKyRiG/Bg4qSCGOXWJ/Nz39AosmvFs
 NJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372580; x=1793977380;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PgIGCs8t50qe1401c13AZT0hnzBuVzHPPVhO0Nzt8Ug=;
 b=O0KdAhFizCznXosjVJ+dUnJrofqDCEmos4jpS3K2B/bitqjvQsp51ZlvVoihe4Z4et
 fuRwZHUiRYvDP8d5x+4aSaqC11PYsmh8lO1Afdn5gP+XGsd+O1yahZ1jdamkeH8Qt42M
 APptlbLA7DHUG/1sIJaID49piEn07j5QjDluaIENzJd1obu/pPf0+q7s1HW+VwT9UttY
 YDUmDL0Z1SAeqIjT0DIu5G90QIi4ZYtX9ZwsUWweP5fJcIRO/2b3j36pYChMMAPno1Rq
 UhWfmRDUVfgPqRdXgcFBIyjPea2SqnNOiOL2oxL1KHYlPP54xph3oSPw5dT+39HbjZeH
 eegg==
X-Gm-Message-State: AFq9FYLKSy4cjgJm1BceisWzx9ThixVgw/vfor6ihmV1cXKAZiRsyCd/
 WCaN1EQL27txDTp38JP2YKpgky0fRUABNPJL2YrtNgeDbleaIt/l7G2b5ABxPaNqsoLWukGeA22
 8EVnOPm0hsZPpjX0ugr+Vf8pm+UjS1qVaqT+BLWTB21URwKx9KQx0FEL30jtphT62CXGw
X-Gm-Gg: AYBFou0UQ7zIixfOIoPoDGTzxf4Oa852UrWkFnfY6c8S2ds3CAz0zwFGN6hRf4erE8S
 QeQ5h7Tw3bVXBIFv75eFH2i/SZf15AfVVFhfLsioKuS66G5/kBSAjmoTTUrjpOKxwhLbCSe0O+k
 KgzDXPK27cHUcvaEfIk+MGscuFLEF6QxhTzvPgz80nLN8WADTaQRDB5Aael7SevZR0WzX8lkImW
 F/QCIytI69IToRn10unfbXGHqIYZybgFABMqE7ahCsEUmKPqSjB4mODC3LXyXO9Z/PmzaSnVSSs
 gzHqPXYQA0REGdwYsymYBmn2s06r9vz9iJ9TXamoLwx4qyqjLERFb3SmnsdHkMLJc3IRjnvXy1v
 Tkw5cafepMxtiKTINoVdQJCAvCYNLr+985vvn+fvf8gtsiWP+jHbqdwvUd8BDkAQUYE7wTtZrry
 auek8QhKOcf1UC8EO6Iy3DUfqONdX4oQ==
X-Received: by 2002:a05:6102:9d0:b0:7c8:448:5237 with SMTP id
 ada2fe7eead31-7d072722ed0mr1499103137.24.1793372579914; 
 Fri, 30 Oct 2026 08:02:59 -0700 (PDT)
X-Received: by 2002:a05:6102:9d0:b0:7c8:448:5237 with SMTP id
 ada2fe7eead31-7d072722ed0mr1498889137.24.1793372577671; 
 Fri, 30 Oct 2026 08:02:57 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d2950sm141232675e9.8.2026.10.30.08.02.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:02:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/31] tests/tcg/mips: Group DSP mul tests
Date: Fri, 30 Oct 2026 16:01:36 +0100
Message-ID: <20261030150202.61556-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yYeq6YgyaxWtCcrXp-636_3AbefFq1F7
X-Proofpoint-ORIG-GUID: yYeq6YgyaxWtCcrXp-636_3AbefFq1F7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX6pjCHpBGCl9U
 Sa3ElMvJT2y9dWLz37ksEnTSSCWsW7Jq3QuG4uGvQkNiGa7xR1RJE6L3TqNnQVAJaUkwYu+L/bq
 lz78Am0wImzovh6zyoNdGXsqggtDDFh05+Gms7eX2+evDeTy90wXzXnAf9TpFCPp0SF1yDWdGri
 0wjOuoCXa4bOGUFHhbf+DAEWsz7F6g7NCJ4lX1qklpuFdSEK3JrqdNSlpdkysvwoIutKIRbjSuf
 wBsluWYk0WsXDuWSci6eXSEkmZQTgE1ezdsnNqNi2Pju9hIiIA7CuiYrCTuOmlSfc06zIYt/0kb
 vSZGeuZxsNz3hQCa5C0xzKZxV2HWjSK23Z5dRvSrTrxie1PbVglto5Og6EJorFjGYwiBXcR4ABb
 iWg0BE5q8s3JDxQorhsoBfj2SGUtg3ILwFF2aj7sb0tFnQsO1fC0reUrgPGi3KU4SPMYaAnB69t
 uLSbdC4IAK1vV79LQ0Q==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4b1a5 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=MrkvrxfUm_GaFPyPbecA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX5Wie0M8kIuRi
 MLIQNsFAz8fySvrHpSJfPlRohGCzLES+dZh7PypKbO51qAMje3KELkLZe4CHkYT/QDzJEhD3+JF
 wZ1DknSUxy9PjZYFUnCBzXPm8KwbrcQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
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

Build the 10 per-opcode mul tests as a single executable,
test_dsp_mul.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_mul.c               | 63 +++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c |  1 -
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c |  1 -
 tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c     |  1 -
 tests/tcg/mipsel/test_dsp_r2_mul_ph.c         |  1 -
 tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c       |  1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c      |  1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c      |  1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c       |  1 -
 tests/tcg/mipsel/meson.build                  | 11 +---
 12 files changed, 64 insertions(+), 20 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_mul.c

diff --git a/tests/tcg/mipsel/test_dsp_mul.c b/tests/tcg/mipsel/test_dsp_mul.c
new file mode 100644
index 000000000000..d5ac6141cf11
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_mul.c
@@ -0,0 +1,63 @@
+/*
+ * MIPS DSP ASE tests: Multiply instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_muleq_s_w_phl
+#include "test_dsp_r1_muleq_s_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_muleq_s_w_phr
+#include "test_dsp_r1_muleq_s_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_muleu_s_ph_qbl
+#include "test_dsp_r1_muleu_s_ph_qbl.c"
+#undef main
+
+#define main test_dsp_r1_muleu_s_ph_qbr
+#include "test_dsp_r1_muleu_s_ph_qbr.c"
+#undef main
+
+#define main test_dsp_r1_mulq_rs_ph
+#include "test_dsp_r1_mulq_rs_ph.c"
+#undef main
+
+#define main test_dsp_r2_mul_ph
+#include "test_dsp_r2_mul_ph.c"
+#undef main
+
+#define main test_dsp_r2_mul_s_ph
+#include "test_dsp_r2_mul_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulq_rs_w
+#include "test_dsp_r2_mulq_rs_w.c"
+#undef main
+
+#define main test_dsp_r2_mulq_s_ph
+#include "test_dsp_r2_mulq_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulq_s_w
+#include "test_dsp_r2_mulq_s_w.c"
+#undef main
+
+int main(void)
+{
+    RUN_TEST(test_dsp_r1_muleq_s_w_phl);
+    RUN_TEST(test_dsp_r1_muleq_s_w_phr);
+    RUN_TEST(test_dsp_r1_muleu_s_ph_qbl);
+    RUN_TEST(test_dsp_r1_muleu_s_ph_qbr);
+    RUN_TEST(test_dsp_r1_mulq_rs_ph);
+    RUN_TEST(test_dsp_r2_mul_ph);
+    RUN_TEST(test_dsp_r2_mul_s_ph);
+    RUN_TEST(test_dsp_r2_mulq_rs_w);
+    RUN_TEST(test_dsp_r2_mulq_s_ph);
+    RUN_TEST(test_dsp_r2_mulq_s_w);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
index b3a5370fe59e..e9b0dc55071b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
index 8066d7d02a1e..a8238c673293 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
index 66a382806a21..ce16164bc853 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
index 4cc6c8f7cfe1..2baedb9f53a5 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c b/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
index 370c2a801832..bd2ab49b0717 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mul_ph.c b/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
index c7e9d60d12e2..bb92f6cbc0f1 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
index 33da110de869..092dd531f421 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c b/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
index 7ba633bc17f7..f94c1678af09 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
index 00e015542e69..8c944c6ea3fa 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c b/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
index 9c2be06cc08a..caa8e8d76193 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index c26f5fba06b7..4991c14b7bf8 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -9,13 +9,9 @@ tests_dsp = [
   'test_dsp_cmp.c',
   'test_dsp_ctrl.c',
   'test_dsp_dot.c',
+  'test_dsp_mul.c',
   'test_dsp_r1_bitrev.c',
   'test_dsp_r1_insv.c',
-  'test_dsp_r1_muleq_s_w_phl.c',
-  'test_dsp_r1_muleq_s_w_phr.c',
-  'test_dsp_r1_muleu_s_ph_qbl.c',
-  'test_dsp_r1_muleu_s_ph_qbr.c',
-  'test_dsp_r1_mulq_rs_ph.c',
   'test_dsp_r1_packrl_ph.c',
   'test_dsp_r1_preceq_w_phl.c',
   'test_dsp_r1_preceq_w_phr.c',
@@ -53,11 +49,6 @@ tests_dsp = [
   'test_dsp_r1_shrlv_qb.c',
   'test_dsp_r2_append.c',
   'test_dsp_r2_balign.c',
-  'test_dsp_r2_mul_ph.c',
-  'test_dsp_r2_mul_s_ph.c',
-  'test_dsp_r2_mulq_rs_w.c',
-  'test_dsp_r2_mulq_s_ph.c',
-  'test_dsp_r2_mulq_s_w.c',
   'test_dsp_r2_precr_qb_ph.c',
   'test_dsp_r2_precr_sra_ph_w.c',
   'test_dsp_r2_precr_sra_r_ph_w.c',
-- 
2.55.0


