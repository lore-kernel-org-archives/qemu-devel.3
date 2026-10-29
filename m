Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E3606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lX8Hgr6z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PAWa/1mK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTtB-0007nS-E0; Thu, 29 Oct 2026 13:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsT-00079w-8B
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsQ-0001Pn-W0
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGCxre1619552
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cJzime4Z9eoOwr9fL6kkePu7a5M2U/xLgg6lRFKCSts=; b=lX8Hgr6zvk895SrF
 eR1tx40OBbvIT3tFDinEECW4JJGO/9GVB9W+jnHJqx7aPkZfybNq0l9psfsb9QLq
 N02Y18ouNQ3/+3vrHjwMTcf22pzpeIyMpSviEap6z+SUJdY5vLVjrhiS6vTksULL
 ICAAMkovbWJ7vMYrxpzDf9xzSEeKTUoFJvkOjw8aCY0YIGKTszK9Y61Tk/6aOsKc
 L4c5/pGOObaXZp6s/AJAZ2RgZM2GfTEGi3Xcl/o8YQhKadleW5gUykwJL0UA594C
 8OUSDdCRYKEfdoqgqKPf+3acwwuHUKV0OmTclcpiytAgdYwqTq4ahqtHqhp0t67Z
 eEvPtw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q9t8s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:25:20 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7d06f3784e2so60780137.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294719; x=1793899519; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cJzime4Z9eoOwr9fL6kkePu7a5M2U/xLgg6lRFKCSts=;
 b=PAWa/1mK/D22hkcfJH/WuRXOsXyUQ1SxB7RRZB0+weYTtSRwIUP12paLr01VlwKMJ3
 NHH2NlRbNXmWab2SYwU2PCxuYe8Jzn1Nt0oQsqPliWVbG7X9GL7hsi3CYbkJ/ZMu0TIR
 YggJkjnrZRyaBnIn2C7NiOl8wCx4JrhBixX1F4KGUq7MQvWScrmPmcEgPjCpJCjrfKw3
 mgZ1ZHI9bqVFigZ9LCtonIcVYWq61ibqc3L+/rrbaz1Nd2GEU1K0ANiPu4rQ+Xl6eIb8
 DQgScaNGT4J8dPL7O5pPDdb9oVKYw06Wdv/uaTmQPo79s0oZPae5UWPAmmZu3Zme0vA5
 zRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294719; x=1793899519;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cJzime4Z9eoOwr9fL6kkePu7a5M2U/xLgg6lRFKCSts=;
 b=E+hAx7EW2TCh6o75omYO2AOmZ5hOm46msf0tdeNDFuPLiUCJONX5SFA9Jje7tr/0o8
 Ck4HM8K3db2A6a8KWbkxHBe8vG9URFvGzoPezKUgiTrTPAAVnV2e31VhMmbY5Fpa0Nao
 0whz1KMbcJ1461N2i2j8h3ql1YdlG/xmeF40ahgyJ6KS7ufG4hv7hYPE7f00ryHHLTOl
 G9sfgzBwImCM4OZZEYCyg8MijDMsQu0F6BXozY2guXAYGpxa/Yj+fiygu3UfAtz03880
 ku6q7/CrhJNiystknke40KiXYg65u2bj9uFDKzFFGYIIpf5VTGCnEq5SEiRDGnmWrdYL
 B28Q==
X-Gm-Message-State: AFq9FYJS4uuBWMvBa6ooO8mmRcxDRQ21J4mhiEEVuE+PN17beha9lCJk
 Gwldb2pvBvrAqdE6G3ARinDOI09u7YEEZOpuZua6NakmTRfsjusR6wioCLoiHUZ24jZSBqESBl3
 uDCCsp/mM2ZmPDZ/ZU6NZiGKg4E2ir7W48/ETT6TZfl/vZ4GblqReIxfF+LMjx4KJ6VDd
X-Gm-Gg: AYBFou295yTl6oJPamneAFMH0CJgigw1DZKwEr6qK6WBZGa9COEm0ykFjva0GK3btsR
 M2LgU7ADWYzIATlCmTLZ4HF7L7yPEK1AVNBq+mYWVKEcKjfHj0QP7XxnZmhSymbf9N7rwWo6ObR
 Wn8fr4hoJYpx+h+8wsZPeCEKrgRN5/6INpDthJIPmWzToqJLLP0s4HQWlwO7buF8UA6kP5c8UwI
 Fd2JSfGDKLZjAbOux9EUCB2lxwbJFGmk1Kz2LjhzjHg7Y8RWDkkTTqsN2cOqC08UDMQjAA1TTpq
 wEg+EBW+LMitxCpNfNVNq0JTsa1VLcewy+en+CyNrgIXe4dtTAGplEL0cBRt6CvDRpuXdLEN4ZQ
 CLZewwao3ylO5FBSo7o0z/phGZUgFkA5PB7P++A++yr0oOYoIoCV21WhM/HIZ0lvE+BHucSr9zw
 0uP4RlXKCUOf+Eg0Sny0tisuCYhieqmg==
X-Received: by 2002:a05:6102:3ed4:b0:7cc:285d:4df8 with SMTP id
 ada2fe7eead31-7d03a574a3cmr3239863137.12.1793294719025; 
 Thu, 29 Oct 2026 10:25:19 -0700 (PDT)
X-Received: by 2002:a05:6102:3ed4:b0:7cc:285d:4df8 with SMTP id
 ada2fe7eead31-7d03a574a3cmr3239841137.12.1793294718511; 
 Thu, 29 Oct 2026 10:25:18 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfa0610sm474846f8f.31.2026.10.29.10.25.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:25:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 16/31] tests/tcg/mips: Group MSA bit-set tests
Date: Thu, 29 Oct 2026 18:23:00 +0100
Message-ID: <20261029172319.25766-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX3T4ELy60X9Fx
 tp+YJPaGsWGi6eGYpfN53y11blQ9Ko3fUlQdTS+bJdYaCFifzS0GE33WdgNCzL+pOO+51y4n3MO
 +lfvHUu+G2OGJInol/y8Xjjg9JRMtvY=
X-Proofpoint-ORIG-GUID: BsWnWWHseboe6eY38oL334lHujjndki9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX3zMmYTsF3cVI
 N8XCMatOOODHY8eJZVexlVQ66ix5p8L2oMURnykGhyxxRHsLkls8nnpM8Mc3FUdnV9NrLDgINr3
 qDlDCX+zWMVudJVwEwiW5KTVhSFTHp3bxPkBFfSEBhE6JLEI+bkrinNYck90qAP3DtUy5egntsE
 kqkoHnTggNXyPZ0aWvUA4K9dtOn2xJD2JMfNaqwYvilN0jbuQgx5L+RxzcUGBLdvEXUGmW4qxPI
 5tGeXR3ggbGOU+wiuIbpQBp3VcFV/uLtTfo0tv6PVqs77YkiYi54KcLe9Z6AQD0FQrNOSmwd7Z3
 jBTTOV13lpWESVG6Szpi1IYXiSz4R3akQgjKmHCwWWvlLl5jJHXoACc5AXobg6EQTp90BEHJAyp
 vUjbJZL6Yez3evCXkZYsIkdjYN6/Wj9Lyugaqw2qBYYHbczWjMrBleKFpYiUJQAfRt7adrP5LAY
 nJnCaK4rUwCrkY93JTQ==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae38180 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=U98Yu14etVFMT76BwSIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: BsWnWWHseboe6eY38oL334lHujjndki9
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

Build the 12 per-opcode bit-set tests as a single executable,
test_msa_bit_set.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_bit_set.c | 103 ++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build        |  12 ----
 tests/tcg/mips64/meson.build      |   1 +
 tests/tcg/mipsel/meson.build      |   1 +
 4 files changed, 105 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_bit_set.c

diff --git a/tests/tcg/mips/test_msa_bit_set.c b/tests/tcg/mips/test_msa_bit_set.c
new file mode 100644
index 000000000000..76301fb148d7
--- /dev/null
+++ b/tests/tcg/mips/test_msa_bit_set.c
@@ -0,0 +1,103 @@
+/*
+ * MIPS MSA tests: Bit Set instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
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
+               "Bit Set", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index adf25fd3c5d2..f3919436dacf 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -244,18 +244,6 @@ tests_mips_msa = [
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
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index b40b7c10c608..08a4900a9fb5 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -42,6 +42,7 @@ endforeach
 tests_mips_msa_groups = [
   '../mips/test_msa_bit_count.c',
   '../mips/test_msa_bit_move.c',
+  '../mips/test_msa_bit_set.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 0a3b84623125..fc19a18acecb 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -43,6 +43,7 @@ tests = []
 tests_mips_msa_groups = [
   '../mips/test_msa_bit_count.c',
   '../mips/test_msa_bit_move.c',
+  '../mips/test_msa_bit_set.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


