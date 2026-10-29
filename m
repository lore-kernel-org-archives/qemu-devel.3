Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8A4606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m2z3Xj3h;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CVFluCXD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUF4-0004JY-Qj; Thu, 29 Oct 2026 13:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBj-0007yp-99
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBg-0003vk-On
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGCxx41619556
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eV8czoIuX4aWbZUSQncnxRi5B5ycL2pCCkLFt/fpQiQ=; b=m2z3Xj3hsM9uUsBH
 ny48FDnaGWyPCeP8X15Cs8SzEdb+/JBZFLWw8JN1lKbF9yrdX8DCM3kIytuMFb/u
 7ZcGuv9ZORLrIBX54SCSrLLrCbXbEwo5+TMYJiwNF7Rt1ulL1Lc0lQfC6jF+3p6T
 qFkzHSYtDpw8njj5alur4ln3YKQUhnysh0XODFMpIF5bWTnj4GAYUD2b8oA2cMPA
 Yx87RX3xzHNA2VRsOHoRBqj+zNHlnHoYOcAe7/2dsInNRVMpYc3tO0AE0xDCrqnO
 NxolYV81YwERMIPJz4liBrWMR7xhYHyXiN3IlanieYvSzrs05yi5O6xlh73cQ4VR
 PYpA1A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q9x27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ecdc701a2so284817985a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295914; x=1793900714; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eV8czoIuX4aWbZUSQncnxRi5B5ycL2pCCkLFt/fpQiQ=;
 b=CVFluCXDe/hfZ7e83Z3z0EFM4WIWKkXrG8bCve9ZuQ78AB8GXtcynbuD9R5SFIF0yV
 GtOOGh4EFFFFOoDcnfrIx+HwwvSE677JKnGmnGpfxrDjprnxCZCBo0xoRlIaI4rbgHxD
 gRakNzuOLwo5v7vznhM9BJi+Gqx5w8nBj7X+uMU9oXDL5S3MXuGkjPba9XDochNwYo5O
 YL9xV5I1W3/ECgEQtP+Zu5J7HYgFmZvogcG5IknLF3mZtoNNGBxxPZJGYbl3mP5u/euW
 SWM4pEArB/fPM3kSvMzIUpkJHHPueEvx/SKW/k8mqVUrSUpwIxB9gH8J3mFygGh6vX79
 CsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295914; x=1793900714;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eV8czoIuX4aWbZUSQncnxRi5B5ycL2pCCkLFt/fpQiQ=;
 b=elFK0tN/PIwNME8DMCPzcICPGDx1cAYXCST0pUHYgtr2aaLC6l7nCQ0krjOQlS2CiP
 9x5WlxM07nAaeniTDrZKiKOBUEzqIg//UxvTGljFiKQWcpQ1CFwZCxaGDDNrkeSQ4GWA
 c4flrmKL0gNpYab8K4IzyuOY7r0nKN5hASSSLzK6wzPSV3hw0TS7hEOMzKM5DTWzRA5c
 HJ6rJEKld7yGfn1dAzchPDDvDBHyk6d6pK8NeB9LbYJ8oOGmp5jdBkItnIULPw6HTiEO
 Pjo0P9Uym3v63HqhKBRwzSUkInclCFT441Db03YjoK/IEWdybfzGwEBSnY8lOCwK+dyg
 R/JQ==
X-Gm-Message-State: AFq9FYIYjt8ZSbiA7tsAbLqAr1NeuVbZQG5Ml926NQ/MHZ7HDSG2X7G/
 5Cxg3df6vWIdAsandj8BFelbFtowSSilXTU8GDA/snO22fEiZOLy7TuvBQe8Q6OTuwZlZgyHfg3
 x2Xc1Q61vBTk3SkqB8phKzfhuRTTG+EF67sLGGvzoZwuhjexLIrZqtvJ2HlaVCQOUtWps
X-Gm-Gg: AYBFou0fv+JWc0+2u30hYh5nd56M7zhvyX7c01mD88e0/g0Z70wPU0ppFfANxqPLfaK
 5tQLRaKee5NgO1FNm5Aa0AVajwz0nTpxQcHbbO3Kez9lLC20wfz9uNzyGTrkL3xdSHmfUofWJWG
 Tka98P+myyF/E7aYRqVPfMutBQl5WNXktXzzSqyX9mNvRRcXkaINK/k5pUd1ORF86ABhmA4PPaD
 KzkTxxKer6G8NTR8BKDn9GrOQILUkkDNIeHbn+VPHM36Kr11E//sixQUHnlecNI8dnkkdGVzy8e
 MCo1aUk3kGDPVaf3iX4MUrDwKB977nm2hKGq/kwkZ89pq6JLkNMQtLNd63ACaf9CYFXu6KBK/Ux
 D1oNxwBLS549bYKCBykPpwXckPwNJ3nfa09DQnpT5lzthbK5cWBXXmWXdNxIRu03zit4UZOzIfT
 QG6m3vYg1/rwzwyqIDdjACNlLUx6PJ0A==
X-Received: by 2002:a05:620a:25cf:b0:93f:a7e:e0f0 with SMTP id
 af79cd13be357-94408d74625mr944424985a.82.1793295913790; 
 Thu, 29 Oct 2026 10:45:13 -0700 (PDT)
X-Received: by 2002:a05:620a:25cf:b0:93f:a7e:e0f0 with SMTP id
 af79cd13be357-94408d74625mr944416785a.82.1793295913067; 
 Thu, 29 Oct 2026 10:45:13 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf723b5dcsm684365e9.14.2026.10.29.10.45.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:45:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 05/12] tests/tcg/mipsel: Add MIPS32R6 bit operation tests
Date: Thu, 29 Oct 2026 18:44:26 +0100
Message-ID: <20261029174434.27985-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX2Hc5zpuqg+2f
 5r/4j3a24WLYnAc1D1Fk7ynNkaR6wOS8NGOb3s7MfsHj978Z5Q6JJP8ir/EuyGzfrd01nE1CYUs
 w4y3Hqnt1ZLGRMLvnM3caq4qTzqJJWY=
X-Proofpoint-ORIG-GUID: CVtFY7n5fFcHxZ_N3SVDYQAiI3VMJBLM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX6gqGGlicJh1+
 eoFKVHzgwbGBJF1kSChL4nC2YNoF/RghTcWdMZAxKOc+WNnvFLF5L8BsG/TbujtTEFk4sSNuEuR
 WOGQangFaqfH/R4z3PT8LwviHAiu/ADGeGW4W/taHlxIfLZgeTdCIRgiLR80f83mNDGJ+drV/qH
 mRcvnHgPk1aTBpzRNS52ix/rfv/0WzPONzCeR0G8MqYNTenAV5gsPVUYyxHJ0G5js8w6obnEATv
 DHR+BWl4FQbfD7nOx2VuIFj7I9GMKwE/HToK+9McTBxNDRDFtiIWfdqPMf+/qeF1DC5w5k68cN0
 vRVSBt3/Zi/U9HKlgw2deMmFZahXFNFcHoWEh0EKgyN5QWKGRfOAuF3ka/PcAXiLD74pu6OVr6x
 inL68jkxA9+BHF2iirDmXpfrLUSohCiumX4DgXaaek213ArSzV0Wm9wnza6yNl0Itj5Q8KyH4On
 hyntpV3qpZmFs9kp1ig==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae3862b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=xpWpbzVTnifO-OPWo9MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: CVtFY7n5fFcHxZ_N3SVDYQAiI3VMJBLM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
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

Test CLO, CLZ and bitswap.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_mips32r6_bitops.c | 82 +++++++++++++++++++++++++
 tests/tcg/mipsel/meson.build            |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 tests/tcg/mipsel/test_mips32r6_bitops.c

diff --git a/tests/tcg/mipsel/test_mips32r6_bitops.c b/tests/tcg/mipsel/test_mips32r6_bitops.c
new file mode 100644
index 000000000000..dc55530b3b18
--- /dev/null
+++ b/tests/tcg/mipsel/test_mips32r6_bitops.c
@@ -0,0 +1,82 @@
+/*
+ * MIPS32R6 tests: bit operations instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+
+#include "../mips/include/wrappers_mips32r6.h"
+#include "../mips/include/test_inputs_32.h"
+
+typedef void (*unary_op_32)(const uint32_t *, uint32_t *);
+typedef uint32_t (*ref_op_32)(uint32_t);
+
+static uint32_t ref_clz(uint32_t a) { return a ? __builtin_clz(a) : 32; }
+static uint32_t ref_clo(uint32_t a) { return ref_clz(~a); }
+
+/* BITSWAP reverses the bit order inside each byte. */
+static uint32_t ref_bitswap(uint32_t a)
+{
+    uint32_t res = 0;
+
+    for (int byte = 0; byte < 4; byte++) {
+        for (int bit = 0; bit < 8; bit++) {
+            if (a & (1u << (byte * 8 + bit))) {
+                res |= 1u << (byte * 8 + 7 - bit);
+            }
+        }
+    }
+    return res;
+}
+
+static int check_all(const char *name, unary_op_32 op, ref_op_32 ref,
+                     const uint32_t *input, size_t count)
+{
+    int fail = 0;
+
+    for (size_t i = 0; i < count; i++) {
+        uint32_t a = input[i], res = 0;
+
+        op(&a, &res);
+        if (res != ref(a)) {
+            printf("# %s: %08x: got %08x expected %08x\n",
+                   name, a, res, ref(a));
+            fail = 1;
+        }
+    }
+    return fail;
+}
+
+static int run(const char *name, unary_op_32 op, ref_op_32 ref)
+{
+    static int count;
+    int ret = 0;
+
+    ret |= check_all(name, op, ref, b32_pattern, PATTERN_INPUTS_32_COUNT);
+    ret |= check_all(name, op, ref, b32_random, RANDOM_INPUTS_32_COUNT);
+    /* Every leading-run length, for both polarities. */
+    for (int n = 0; n < 32; n++) {
+        uint32_t v[2] = { 0xffffffffu >> n, ~(0xffffffffu >> n) };
+
+        ret |= check_all(name, op, ref, v, 2);
+        v[0] = 1u << n;
+        v[1] = ~(1u << n);
+        ret |= check_all(name, op, ref, v, 2);
+    }
+    printf("%s %d - MIPS32R6 bitops %s\n", ret ? "not ok" : "ok", ++count, name);
+    return ret;
+}
+
+int main(void)
+{
+    int ret = 0;
+
+    printf("TAP version 14\n1..3\n");
+    ret |= run("CLO", do_mips32r6_CLO, ref_clo);
+    ret |= run("CLZ", do_mips32r6_CLZ, ref_clz);
+    ret |= run("BITSWAP", do_mips32r6_BITSWAP, ref_bitswap);
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 7a6dff32cbf4..837b26698e06 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -88,6 +88,7 @@ endif
 tests = []
 
 tests_mips32r6 = [
+  'test_mips32r6_bitops.c',
   'test_mips32r6_logic.c',
   'test_mips32r6_shift.c',
 ]
-- 
2.55.0


