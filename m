Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC8606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=guDksaQ7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gnbiTYGN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTtf-0000Bg-Fn; Thu, 29 Oct 2026 13:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTt7-0007m1-Qr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTt5-0001Ty-Lz
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:05 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDEDp1087036
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yvfqtoaSNYVjbKIYQ4IuTnEG1c9CtANUkPmP2p3NuLg=; b=guDksaQ710x29Xdt
 i2ek033Lew96ckC5VHNwu5ecTMDCeILicDWKBCSeAST8hxhWEjKKVxe99Sd7+mo3
 xZ+HvAx1mCmOTZZdOLIfUGM3xsBm+5RQnm+8G6UIaYSTB9jYP10f3gPB+Yqz0VyI
 2M5t4XP1hX/Ix8v7xSCMBIGfvV6HPZwTwbr68utdtIsTXjgt4eSDY+f/k651j5bU
 5GyFRpNgJ2aLeBDcuOly8LAabcJHG6T2akXxFqTNCNeZxB9teF/sME2jiZLnrln1
 JSCKYnGcX6xu/EVlPnmxzDQUm+pg9piG4oD2QcZYXJ7j7WH0ITeZUmSShjyOl3d9
 veG/WA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hktmpc8dc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:02 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7bf586522d4so1519595137.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294762; x=1793899562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yvfqtoaSNYVjbKIYQ4IuTnEG1c9CtANUkPmP2p3NuLg=;
 b=gnbiTYGNvpVzB9tio6cwB/irCSZaqtQCn8CTjS72EROTGBj53OVvsPpIiAIdBWh5WY
 cDrqs6MlwpVwzn/X3MqMsL4mqP1305oU6oVjsYE7vrScRQoefTNSnJhhmuHT8lx9LJ8U
 QeWO0VhPbebMXnZ/nsJD9PTEhv9SmTWuGrJJ197KJYj3rJyJVPqvsZbZeor4/UhArZ0u
 9zPFIiMP9eEz3Qwu26UvOvlYJNy0dtxyQVAxdaIqNkpnV2p94u9P1nv/y9j0jT1PKPH/
 bZ8YBtIm5I8lwflqTfHc6LB8wA1xm074/zQQlPQLmmTm3ijsYfQhWdOBvdjkgoLJiyr7
 8QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294762; x=1793899562;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yvfqtoaSNYVjbKIYQ4IuTnEG1c9CtANUkPmP2p3NuLg=;
 b=OKHXZVcxMQWweYk6yxJbXsHZ0m6puUqeiNEF8AWl6fFQYEv10wX/lYOUgANNlVY1qO
 NtMCj2ruZxupCuyFisvh2oWpdQOHfE8rgmm3OQ+klqJZLgQe2N/FhN+1xVJ8gaOgnVzz
 qSYarqhpTzm9aVQ5Dn20kjyPHS/hQ4RkSKYoAO8xTVJSo5T0AU9ZS0UR1I6ct4LGKwi8
 zYzR3TaW/5SQ9BetcznO9yKqNpZGappwERREM+kJAPUIh+clbBRRIEHiaw6SR8WjXhsn
 4Rw1eQzeSUqTgFqn0wGsdLppXP9F+ry55RvfEOQaufDesaX88TFKMK+gz3g/PlRKQdYw
 1WcQ==
X-Gm-Message-State: AFq9FYIhBW8CQT3El9pmc7VhpZvtDzRSg+yF2MO5wArQqMIhTbWfAAyd
 j6TPbUn5z6ZZeEDLVQbNZRzLkrY4muclKR/kYty6ZZ8hRH3/JBw3XiouQFSgXd411+jmbkit2x5
 QFqWHft5U7g0QAYWKympJhCBp5SOePbMCLjWts1izt3ZMuxzS0vdc4n5TYj7Qff28EfqH
X-Gm-Gg: AYBFou1N0asVWRmAkUoeDkDw6lJMPYLbgG3WFxHOfEEYulaWhwY8l1ETrFUSchQz3a3
 rxWPmxpTbBZ/RKqcSNFO1/vl8U0gPxnIxiBwVyYMbUszxezdPUWqTrRPyWiuwdBUl/BolzR6zu0
 ghIwM7qSUKzQU4/mOpo2jRxMW0rhQcgPWu5pZQkqga4k94zLWo/EmRY/4g2mCRokd7E+gRgcJQu
 +38CDSs7qIA1OKGarSqhWuPP821UYaIX9UX1vaX6sManaIyroMgrod8loQHKs+G0+1lRx1w6jfs
 Hd0piXg80yvnfkLGoCuh61nJxWzeKkVmwyA1f0KJKu3cq5PuyU7VSL8Y6lIia85AC5v4pLr74FI
 6oqKdl9pN1WA8IwKWrxEqrvDZ506F7Et+4yiG/ShQzHukutCNmx4SIwRN1PaDU/qX9J2t6bCHAo
 uKbaVQi7ukOslq+TVFt3v6D2I4P1V9tA==
X-Received: by 2002:a05:6102:3ca6:b0:7c3:2f13:d905 with SMTP id
 ada2fe7eead31-7d03a1f1997mr2996687137.3.1793294761468; 
 Thu, 29 Oct 2026 10:26:01 -0700 (PDT)
X-Received: by 2002:a05:6102:3ca6:b0:7c3:2f13:d905 with SMTP id
 ada2fe7eead31-7d03a1f1997mr2996676137.3.1793294760917; 
 Thu, 29 Oct 2026 10:26:00 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df1e458sm554098f8f.5.2026.10.29.10.25.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:26:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 22/31] tests/tcg/mips: Group MSA int-div-mod tests
Date: Thu, 29 Oct 2026 18:23:06 +0100
Message-ID: <20261029172319.25766-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX6iN8jtEsywth
 3PgS5dJtRhO2QcnViksej7zD9L3oT0+WUMlNdshKIxblcJWf0e9eoWoXuR895kdt5RQYi6yBNXw
 LmoH6URqt+QHuqyH//pNzliEqjoEn6+yiQghrqGu58ORkK5eKk++eWg5iiKR0vw7baU2IqmFaZh
 z4GaK8yYkIphIMM7+k3i/PjBN/VlEeEvXwKSrAHi3j1eyatgdOf378hWrcwq/n1ijxn6iwhKmhf
 5s3iCNq6xtdU66ok1lI1z2Bib2c3b+AEbsIictenO9RuXCFN28raLgqJ6fwcbQyBITvxTdXiN19
 kLRPPaLNyQi++Y71SdweHCmqaSb9vp+wZnmBwYLskEoF+TpeLVfoGgjMqTe6XrezjtKvMnNQkYh
 Sw7JnJ20InB1SDHiIzMttHgNP9mw+A==
X-Authority-Analysis: v=2.4 cv=crYOAF4i c=1 sm=1 tr=0 ts=6ae381aa cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ERQezLwtGlTA99Wl8xkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX2JesWXBYMdib
 P9JRPykPpT5qLpeB5CS/xoybpgdX/ZOnf/s03vco6aTulf3Y1HhvdlIt+3Fz82Dn963X8FOqLRV
 Uw8dL5slndtNiXdwPlrkNn+Ra5k+KM8=
X-Proofpoint-GUID: kxY_D7tVUoF-JauHiXBH5gSlUziWUNKN
X-Proofpoint-ORIG-GUID: kxY_D7tVUoF-JauHiXBH5gSlUziWUNKN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290068
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the 16 per-opcode int-div-mod tests as a single executable,
test_msa_int_div_mod.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_div_mod.c | 127 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build            |  16 ----
 tests/tcg/mips64/meson.build          |   1 +
 tests/tcg/mipsel/meson.build          |   1 +
 4 files changed, 129 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_div_mod.c

diff --git a/tests/tcg/mips/test_msa_int_div_mod.c b/tests/tcg/mips/test_msa_int_div_mod.c
new file mode 100644
index 000000000000..31ca37efec56
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_div_mod.c
@@ -0,0 +1,127 @@
+/*
+ * MIPS MSA tests: Int Divide and Modulo instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_div_s_b
+#include "user/ase/msa/int-divide/test_msa_div_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_s_d
+#include "user/ase/msa/int-divide/test_msa_div_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_s_h
+#include "user/ase/msa/int-divide/test_msa_div_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_s_w
+#include "user/ase/msa/int-divide/test_msa_div_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_b
+#include "user/ase/msa/int-divide/test_msa_div_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_d
+#include "user/ase/msa/int-divide/test_msa_div_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_h
+#include "user/ase/msa/int-divide/test_msa_div_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_w
+#include "user/ase/msa/int-divide/test_msa_div_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_b
+#include "user/ase/msa/int-modulo/test_msa_mod_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_d
+#include "user/ase/msa/int-modulo/test_msa_mod_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_h
+#include "user/ase/msa/int-modulo/test_msa_mod_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_w
+#include "user/ase/msa/int-modulo/test_msa_mod_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_b
+#include "user/ase/msa/int-modulo/test_msa_mod_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_d
+#include "user/ase/msa/int-modulo/test_msa_mod_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_h
+#include "user/ase/msa/int-modulo/test_msa_mod_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_w
+#include "user/ase/msa/int-modulo/test_msa_mod_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "div.s.b", test_msa_div_s_b },
+    { "div.s.d", test_msa_div_s_d },
+    { "div.s.h", test_msa_div_s_h },
+    { "div.s.w", test_msa_div_s_w },
+    { "div.u.b", test_msa_div_u_b },
+    { "div.u.d", test_msa_div_u_d },
+    { "div.u.h", test_msa_div_u_h },
+    { "div.u.w", test_msa_div_u_w },
+    { "mod.s.b", test_msa_mod_s_b },
+    { "mod.s.d", test_msa_mod_s_d },
+    { "mod.s.h", test_msa_mod_s_h },
+    { "mod.s.w", test_msa_mod_s_w },
+    { "mod.u.b", test_msa_mod_u_b },
+    { "mod.u.d", test_msa_mod_u_d },
+    { "mod.u.h", test_msa_mod_u_h },
+    { "mod.u.w", test_msa_mod_u_w },
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
+               "Int Divide and Modulo", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 34ea7d1a7bf7..9c4304d49ae2 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -23,14 +23,6 @@ if 'qemu-mips' in emulators
 endif
 
 tests_mips_msa = [
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c',
   '../mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c',
   '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c',
   '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c',
@@ -77,14 +69,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-multiply/test_msa_mulv_h.c',
   '../mips/user/ase/msa/int-multiply/test_msa_mulv_d.c',
   '../mips/user/ase/msa/int-multiply/test_msa_maddv_h.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_b.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_b.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_d.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_h.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_w.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index e896658e66fd..442fdf0981e1 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -48,6 +48,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_add.c',
   '../mips/test_msa_int_average.c',
   '../mips/test_msa_int_compare.c',
+  '../mips/test_msa_int_div_mod.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index c4c9d2e77cb8..5435ba39b602 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -49,6 +49,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_add.c',
   '../mips/test_msa_int_average.c',
   '../mips/test_msa_int_compare.c',
+  '../mips/test_msa_int_div_mod.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


