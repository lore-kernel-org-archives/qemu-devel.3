Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D010C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OuNWcEKB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dioIfoQC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTtz-0000fS-9U; Thu, 29 Oct 2026 13:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTtT-0008QZ-Ql
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTtR-0001Vx-Pl
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:27 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THDf6P182067
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G7uXDWpbg1T9uAqvfOCelPsclZEwyoGbrt7Fq+hKCZE=; b=OuNWcEKB4AuEN340
 ici9r7ae6/AaOaMGdXqAs7gnOyTkoGCbNW18iW7SsHRs5ZMtfG+Oc0s4LdfFf2/b
 7qyi+vzoIXGPvXhdGZhCmbNL3hKYmpmhSR+aZG83mtj/Ib1ZXTX9kYBObH86bynl
 lcuo7OZzjoSoLDFMSdYCKQDIISW+V3d1mrrudPvoT9SISmTV1NeN7zsQInc5dDcj
 EEssqo4GtweXJN4s7V0mIiTM1diGaKlOKNzMW8z792Zwu3WGMP1CuDMpjuh6Gddl
 CooPgqI8nt/5VbnMrgxIfbpsG9utCVexr9KkUpZSrsCxTwCfyyucznzEH9O3E3p6
 rn5NEw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmac0r249-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:24 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-98c88cefeb3so1858287241.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294783; x=1793899583; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G7uXDWpbg1T9uAqvfOCelPsclZEwyoGbrt7Fq+hKCZE=;
 b=dioIfoQCQYINPosXkHDFsI+Vbp5AyeIsQphLLWiXbzRydlgXU3RH5ZS8Fg7iyvQP7K
 Lw86xoqJHIivcdzTRE2w778Kfc0Zx8b5hrOUTmKvON4aLkh3Z56AnFDQAJVVC0k3Szsf
 j6XuymaNvdRfSlw6vLeEVbs8kNArCTb+xSZBWlB9xlH6JZZmIHTXH9182yzOMVGNY5ZL
 Jfrgw7AGIxSnkUBeJorA1x87fq4/+S5+PaAoubuKkyoSpUC6mEv+pYXkPb98G8eoYVHD
 Z3EgzK13lGyJHBAQBP4LFVHHBB03xv4Qy3iTCipxeEiwjAEbjWKzDY53RaxX4ssVFJVG
 F4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294783; x=1793899583;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G7uXDWpbg1T9uAqvfOCelPsclZEwyoGbrt7Fq+hKCZE=;
 b=T4pjm/ERLAN0WLmltqQTlFD+pz1/Y1dgTMTcpGmgDNh6tl6aHVgygKsAssfT7oXIOT
 TOI3q+/O8th9s5XqBmkX9wGkvEceKuSIxCbG19AmY22TAiEIL1kIN2uxYvSbsgmbAzZQ
 rPtK5gUd7ylIIEWNXvKAEW47821KB/+7g5I70Mn8VVNiMpzMt1kklOzMFQizOI6GDgDa
 jQv7Hu57xDUTah7y4xpVibSuQ213gxbps2CkJAn3LnuB7ctH3FNDRfEBiMBfjsccAfIB
 vnIprwfuO+BX6WKMZQRppRwpruW/zzJzACpqmCU9daBr2ZX8XdbhrRLBE5R4JqOpEXjv
 GCpA==
X-Gm-Message-State: AFq9FYLiBoCQIgTsWpBDIyv8pKASepCzlLPzDoiiZ2eQmOK6bpHAfMYl
 1PP5pNXMrllioB3HNrQAk1fs9dZzCeEWJqR/qLq+zx+MUG97oRlSf8CVWiI6pQOOy+keotNQfkK
 lVbWYS92/ibXZY48eLk/HLhk/VCnv1aOcF/4ZVv1eiZ1j81ZeZYbxJCw4t2o0KCY1D8gQ
X-Gm-Gg: AYBFou2P3RtuD1SUYbE4Jwt0acX3T487OBZ1m2VSwx5PE09oAPI6chApc1hyqdIQN1C
 39wmHvwG+q52g0Dz3kdEbPdes1JMYJuw4QRwz9ziEj3RZ7oZ/VR+nRN0FldrlQOQeRWn6oBNL8/
 2rxjoybKifh1p1yVKnYIq84Nsj95nZJ80L91WAVdEnE8ZNUPDS4hICC7UJbtS2WKg6rXDVvSApt
 q+FYN0UfybDDXbpxdIFarXtRThEIFikxAZ+z+LnF1vPjK+DUIHKum2Mqz9ZTW2cnMVG87i3NUyM
 TxFUIxWNW5BDt59E1xMLXw5v7UBQUgqgrrw9A37GPQwM3k9Udph11426amtD3Jqve6L7bweSoSq
 DKgyBiRGQley+YCeob3grxtbskV7RPoCe80iMMSEvxPVS64kCTKQu8TGIfNvzQFQFuqTwsoMr8b
 QzV6dSZU5wdAIqhJ58jojfe5BuRVxEhw==
X-Received: by 2002:a05:6102:c4d:b0:7b2:f3ff:6b34 with SMTP id
 ada2fe7eead31-7d03a1eda13mr3577139137.1.1793294783259; 
 Thu, 29 Oct 2026 10:26:23 -0700 (PDT)
X-Received: by 2002:a05:6102:c4d:b0:7b2:f3ff:6b34 with SMTP id
 ada2fe7eead31-7d03a1eda13mr3577117137.1.1793294782734; 
 Thu, 29 Oct 2026 10:26:22 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df87f1asm545257f8f.14.2026.10.29.10.26.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:26:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 25/31] tests/tcg/mips: Group MSA int-multiply tests
Date: Thu, 29 Oct 2026 18:23:09 +0100
Message-ID: <20261029172319.25766-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bKGQZOW0qd8564H2JcHZTogEqvBwQMjM
X-Proofpoint-GUID: bKGQZOW0qd8564H2JcHZTogEqvBwQMjM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX1dScn/KVfbyD
 ds9w4diBYMVWJRqxpzHmUNb3H/Ukn68zkNBh6IgUMpmZT1S4Zm7aCAMGixV+ncW9PuNLcsQav/J
 M4k2IpczPTEtGb0tPg2k2/d+5ybfOEA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXxpq3E4SFpxIi
 NkQvO19B/ZfmVMXxlHToQvqzv75qH2roAyrjnQ/L07uXNY8GtHo3k0ZktqBOViTt9m04ClSAGI9
 N2o4ujBxrYTTPEVIv6UfcgX6uJ7R0tzKesrUoS7MMSWe0akt4s+UlamxP46ivr+rH6F7y5bFqmv
 OQSuqDAlYxgIfU4b/Dy2hBBl2N4t6mbNBsqswMIpYTdZPI9p2TSZiVUCBF+kqn73xdD7CUUHRxa
 VYDZmW5WUMR0mNHj2shJI6INLQBlq3jmhkr3TEWTD3NTXE4mIPGZgGVBwLBPMnsPdU+/L8oYJJP
 wkHWp/NhbwnooIkhH8k0ROeH49Vis76Uk2FPOMQ8UBvwTT06sV+b7K6f4QAqYQWoeh/XKdC7rNT
 7ZZlmoNJ5mQsipMrx32DoAbLSBqhGBRHN1p9Zyug8G8u54cpl9CTr3oQrJLd1qJPB0Dsxf++IDj
 lo/e3PNfF6djVtV79Sg==
X-Authority-Analysis: v=2.4 cv=I6/w19gg c=1 sm=1 tr=0 ts=6ae381c0 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=6XanDqKFyfEqOhQtaz4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
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

Build the 12 per-opcode int-multiply tests as a single executable,
test_msa_int_multiply.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_multiply.c | 103 +++++++++++++++++++++++++
 tests/tcg/mips/meson.build             |  12 ---
 tests/tcg/mips64/meson.build           |   1 +
 tests/tcg/mipsel/meson.build           |   1 +
 4 files changed, 105 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_multiply.c

diff --git a/tests/tcg/mips/test_msa_int_multiply.c b/tests/tcg/mips/test_msa_int_multiply.c
new file mode 100644
index 000000000000..eb082783f51c
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_multiply.c
@@ -0,0 +1,103 @@
+/*
+ * MIPS MSA tests: Int Multiply instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_maddv_b
+#include "user/ase/msa/int-multiply/test_msa_maddv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddv_d
+#include "user/ase/msa/int-multiply/test_msa_maddv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddv_h
+#include "user/ase/msa/int-multiply/test_msa_maddv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_maddv_w
+#include "user/ase/msa/int-multiply/test_msa_maddv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubv_b
+#include "user/ase/msa/int-multiply/test_msa_msubv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubv_d
+#include "user/ase/msa/int-multiply/test_msa_msubv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubv_h
+#include "user/ase/msa/int-multiply/test_msa_msubv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_msubv_w
+#include "user/ase/msa/int-multiply/test_msa_msubv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulv_b
+#include "user/ase/msa/int-multiply/test_msa_mulv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulv_d
+#include "user/ase/msa/int-multiply/test_msa_mulv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulv_h
+#include "user/ase/msa/int-multiply/test_msa_mulv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mulv_w
+#include "user/ase/msa/int-multiply/test_msa_mulv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "maddv.b", test_msa_maddv_b },
+    { "maddv.d", test_msa_maddv_d },
+    { "maddv.h", test_msa_maddv_h },
+    { "maddv.w", test_msa_maddv_w },
+    { "msubv.b", test_msa_msubv_b },
+    { "msubv.d", test_msa_msubv_d },
+    { "msubv.h", test_msa_msubv_h },
+    { "msubv.w", test_msa_msubv_w },
+    { "mulv.b", test_msa_mulv_b },
+    { "mulv.d", test_msa_mulv_d },
+    { "mulv.h", test_msa_mulv_h },
+    { "mulv.w", test_msa_mulv_w },
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
+               "Int Multiply", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index aad18213a460..5d5bcd106ca0 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -57,18 +57,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c',
   '../mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c',
   '../mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_mulv_w.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_msubv_d.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_msubv_h.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_maddv_w.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_msubv_b.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_mulv_b.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_maddv_d.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_msubv_w.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_maddv_b.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_mulv_h.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_mulv_d.c',
-  '../mips/user/ase/msa/int-multiply/test_msa_maddv_h.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 41a8c22234f1..ba94fb6a68ec 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -51,6 +51,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_div_mod.c',
   '../mips/test_msa_int_dot_product.c',
   '../mips/test_msa_int_max_min.c',
+  '../mips/test_msa_int_multiply.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 66041e0d191c..ef30568ab5f5 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -52,6 +52,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_div_mod.c',
   '../mips/test_msa_int_dot_product.c',
   '../mips/test_msa_int_max_min.c',
+  '../mips/test_msa_int_multiply.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


