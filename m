Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834F606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TUcCPvIb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h1isZNhP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTsk-0007DY-3R; Thu, 29 Oct 2026 13:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTsA-0006oS-BZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTs6-0001AN-CE
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:25:03 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THDgP8182072
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 inPDoSVA/2ldPr5tnKaggcyPWZkQ1MGQ1vTAzNe7hUk=; b=TUcCPvIbfHFYAYSq
 ZdvyWzKgvB5QZ0DiHlB4tnI5UQMejPXnixYaRn6asPKVElPQ7q88Cd/5iRwPJpmN
 EflnXAHG/MzYXKNNY6V76tC0AbRDfSPP2urtdlaHCnnR2yNGEdMVk2k1Dceysf4A
 w+L2Fq9AzU4E21ZodXvC3F9ZHJ5QUpCw1YV4B/+RzuV/7h7i0FnhMqLmXH4G5yKU
 jSlNkGv5iGttLA3zBJPnuxaIxdPmMJJLR7TpE6AU3tRCceeTsMD6CzHMk8b/EvMh
 i2mEyB2Qh2c4eCE3lQoxuSUZ5s+HKP3+OPx4zwtu5tno14n0mL1YsioSgdEtG+Lh
 58FpiQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmac0r1w2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so426739785a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294698; x=1793899498; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=inPDoSVA/2ldPr5tnKaggcyPWZkQ1MGQ1vTAzNe7hUk=;
 b=h1isZNhP9UHjeYusvTIrO3xj0jPjIG6fUqjaDDlbV7tLnu1pzDgKsEHATLNeMlyabk
 1izp4z/QrYDkSpL7IDeRR6onkNKeFQywM6r8MQNGeUSmFFT0NxcFNtqYV16DYvCaZ5eZ
 jd00YD3d6zbBHY3cBLu5thUN3NRmmLibZPkQJFMwr3CitMKZCMeMrvp0mLT1X5P4Mghu
 1yuhOYfigLMOI7YuWfeKD8A27qKQ7FViRfT7+YzUdBKN0jY5O3YWs4snsobF5AvxCIvN
 3A5Vzg/ns1um7hAIsaKIS4dCEX1gK8rU6ChdXc/G+28l/CY9f6H8XNWZ16I3qkz4AR9i
 FFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294698; x=1793899498;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=inPDoSVA/2ldPr5tnKaggcyPWZkQ1MGQ1vTAzNe7hUk=;
 b=vIwsAGvhdVZPbV1KKaY4GxbR175/lHhjRzNFATset0mW5/ULcsO/S4X7xsCP1fLCza
 Ec9hhJH2RpmpT2ZtRg+F9HrydPS8n03S4IV0/jG2B5qGnDazbUD27K8bn8PDjnmzA5rE
 FZcyYfsi73hH4aX+3J7ulkUifg3UsaWFRzJfY9EsdzBggEL7g6dyAT9Rkgbgv517Xs45
 T28Fg2PaHt03bgRyUhecij0vEWkAIz3ZSG44CWwjcB52Tix3KklQP4LfIW1ZwyNHr0iC
 ej+CKyKr5CRQLtU4U/agxIglwIEcZTBPBA6lHq6NzZoc2AY3Ix1ZgrIjiBJaab6vL9bl
 s/1w==
X-Gm-Message-State: AFq9FYID4IsbqlbwTRtm9+iv6budW38RCRB7NS/OzOPMxxfwZVFfRssi
 hPCpqmoAZquqKIYHoL2uGfMh2ydrgg3Ic3IBs6c0Yc/efo3/msRIl4cet4oU9FCPaoya27KG/Tf
 u8AV9i9IEKEpFU3i1280QatMvt4Br8wLIMuwncwQVvMfdz3CjMPk3cFMevxhCXemEup67
X-Gm-Gg: AYBFou24+pXPBnB1zMGdxIY2EzEcMXdgBI+wgG04f2KGK6A+UpnVXCOXCv1RCTgwaNC
 zQv717uyzYjAcsBI+p5cENXDhWEp6vrg7oumrlVPcueG6CxFT0IUCMZgphO7T8fuoaK/vi39ewG
 LQ/6Ho4Eshj/vRLzwOc1lRv4gmWIJnOL+nCV54pHJJlOxNednjmNZ2B/EhxQuPQ938vuMQ+SEXx
 fzgRlrjU9QmYvTFdESpv8SMIWoJgR7/tmTLp1ni3jbSiQDCb6EqOZMj8/8JObSI2KzLljaVOriH
 dLr4udg9lWgGlhZGW2jRELF0XBqS2YRr9f8FCq0epaH9ZYn6XcffawYXDnGUMDKBx9M/b8zTYn+
 GlrKLdP6gqJNkpWOXtHe0KqCCub2PibyWXby0qbvivQrFTMcVF+3zWYuCAdc+EmzVDddRnhlkwi
 qzxBa8nmBwyLEJMr/n/17ZqSYaTUjCSQ==
X-Received: by 2002:a05:620a:17a9:b0:93e:9934:d179 with SMTP id
 af79cd13be357-94408cf6b61mr842988385a.56.1793294698038; 
 Thu, 29 Oct 2026 10:24:58 -0700 (PDT)
X-Received: by 2002:a05:620a:17a9:b0:93e:9934:d179 with SMTP id
 af79cd13be357-94408cf6b61mr842983885a.56.1793294697410; 
 Thu, 29 Oct 2026 10:24:57 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f047bfsm79564335e9.3.2026.10.29.10.24.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:24:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 13/31] tests/tcg/mips: Group Release 6 shift tests
Date: Thu, 29 Oct 2026 18:22:57 +0100
Message-ID: <20261029172319.25766-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3BLukfKkRYsjQnrfNeQ1AbjmftJGgFK9
X-Proofpoint-GUID: 3BLukfKkRYsjQnrfNeQ1AbjmftJGgFK9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX8H4dh0gYvsM1
 rR0aUBGO9eYD8wBkuHnbj/PJ51XHp+6/20fXjzAGxcxL9oyRzdn7Ef7gfqTrjI6wlKrNCzPy9SZ
 4I/N9HYVf3tMqb9ABWfCuU+d4UIc0IY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX6CV4g4h7DsOo
 rwHdKPPbK+8rrZr9R+7WUUGhwHU71WZXxHflNYZj8T7BtN0MeNMEmI5sNimzwlPIljQNmQdTtqe
 WhsU29Xu2j4W34VPuL/wNjp/EYexCs+wjSim6HL6cW+PgqIff/uXnscN7awyly+MY85Fn0uE36S
 qUNvm5YNWgx1tosxMbpZ8S3iGAWXBzxBWJrDKvND4j98+oypStDRnepkRsR0hTRwxMbnM+Wbry3
 3sohmsYMMr7nLJKbKpbHPlDcUHitEHILLyFW7EbQOOzcj5j0G+aroFt60PffYly1zLO/D8mnZe7
 SUI8IO1uLD8+Bab1uvB+2J9om2g+myBU1/gKp8ycEHPbipA6AUh4Q+urdrtNPGkJFY1QK1nWym2
 Ri6cDJFbzJ/py0iygS+P1J06iLFKMwz3/3uGEvk9U0XO6p9O1JSk2cRDtQn7RZGWQGYJD9+4S/g
 NUdQd5NcArQ+9oih7gg==
X-Authority-Analysis: v=2.4 cv=I6/w19gg c=1 sm=1 tr=0 ts=6ae3816b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-pu2kDSRp-wWEHhDktMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
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

Build the 6 per-opcode shift tests as a single executable,
test_mips64r6_shift.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

All Release 6 tests now emit TAP: select it in the meson setup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_shift.c | 62 ++++++++++++++++++++++++++
 tests/tcg/mips64/meson.build           |  9 +---
 2 files changed, 64 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_shift.c

diff --git a/tests/tcg/mips64/test_mips64r6_shift.c b/tests/tcg/mips64/test_mips64r6_shift.c
new file mode 100644
index 000000000000..a8734bebfd16
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_shift.c
@@ -0,0 +1,62 @@
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
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} r6_tests[] = {
+    { "sllv", test_mips64r6_sllv },
+    { "srav", test_mips64r6_srav },
+    { "srlv", test_mips64r6_srlv },
+    { "dsllv", test_mips64r6_dsllv },
+    { "dsrav", test_mips64r6_dsrav },
+    { "dsrlv", test_mips64r6_dsrlv },
+};
+
+int main(void)
+{
+    unsigned count = sizeof(r6_tests) / sizeof(r6_tests[0]);
+    int fail = 0;
+    unsigned i;
+
+    printf("TAP version 14\n1..%u\n", count);
+    for (i = 0; i < count; i++) {
+        int r = r6_tests[i].fn();
+
+        printf("%s %u - MIPS64R6 variable shift %s\n", r ? "not ok" : "ok", i + 1,
+               r6_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index d356689e54bf..894f8e9e23e1 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -32,16 +32,11 @@ tests_mips64r6 = [
   '../mips64/test_mips64r6_crc.c',
   '../mips64/test_mips64r6_logic.c',
   '../mips64/test_mips64r6_multiply.c',
-  '../mips64/test_mips64r6_dsllv.c',
-  '../mips64/test_mips64r6_dsrav.c',
-  '../mips64/test_mips64r6_dsrlv.c',
-  '../mips64/test_mips64r6_sllv.c',
-  '../mips64/test_mips64r6_srav.c',
-  '../mips64/test_mips64r6_srlv.c',
+  '../mips64/test_mips64r6_shift.c',
 ]
 
 foreach src: tests_mips64r6
-  tests += {src: {'cflags': '-march=mips64r6'}}
+  tests += {src: {'cflags': '-march=mips64r6', 'protocol': 'tap'}}
 endforeach
 
 foreach src: tests_mips_msa
-- 
2.55.0


