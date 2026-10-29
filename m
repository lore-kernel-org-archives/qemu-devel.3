Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52070606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F9XM1Hxz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eKp4NeVZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTs3-0006Xw-1J; Thu, 29 Oct 2026 13:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTrr-0006Nk-LU
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTrp-00018q-57
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDasg3689726
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pFijQmBaxpZ3ZlcbpsP721mx3w9zqkCtgmN2SAXy6T8=; b=F9XM1HxzkxdovPrL
 585FtcUnurj/1y836XoxooEAU5jgN6IB9KbE7PfszwWtsjShwMYA64QM+0o2s8VV
 QeGoi2uAQiJ7d7oFK8Vd4sFyYhF6k8RZIgkuDud428RR6rTGabc6Yk4rXIWUkB0K
 hH6gOGsvLS1gzWCNN3nzU51tRRT7EVO695nS+FZTqwiv1NRQ2WX0VqbPy+qdQLcg
 ffkQnKbsdSEwVJl7Hw7brMsvvQtrYtXeM7k2RncL08uyJBm74K8PKRixl4USbWLx
 dc1J7/8hw6/Q9/VXTzXTVnwg8eHA3U8swmop4nXt/rG7nPDRRP0lvx1DD75tSJpD
 7vT1qg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5sb7h0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:44 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc0418036bso408295137.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294683; x=1793899483; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pFijQmBaxpZ3ZlcbpsP721mx3w9zqkCtgmN2SAXy6T8=;
 b=eKp4NeVZG5qj5Z6uSvdwOriuBXGgouRyT8DgkxIRBEYtMWRQNy2/jjTRjvTA7OZJ+f
 TaxgFiZNMsd4JiDx9jfBcPj8hBoEOzFHk+qAtotoWsP3WDrFz/AfsqgQCTg6T6Q/sWtM
 QCGwFaBg3XBtrxsKhsyGNBJcEpkXpwrucWg+YKG9e61GNsG/i+G/VGYFXsqOK24P22/B
 W4Ngec1/DcjNspNgyeCMN1XD4r3nCL9zsGkQkTs5MujAKEHfKzW3ObKKfo90db8Cbpqs
 p5rl/3CbvQkpi0vYhT/JDogGqkD7h54L4pvumTiHeKvNbY4C19GUC4lxs1B0EIsOPuxv
 4PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294683; x=1793899483;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pFijQmBaxpZ3ZlcbpsP721mx3w9zqkCtgmN2SAXy6T8=;
 b=nrverglt0Yy3tezp+fsOFnI+NDSexyLXKZ3M8E49hi/iOvskGsvDwcApBfEPaJOBXN
 hFwNjpsbpHC33dC7hHzkG1mB2RfmEYSmOT5vTqysZsHXBfppN/Pu9PZBq3rFYCLMW9Va
 Stvk+CSPKjtqnrw+fVvfVKKMwAKwSak9sZCjiXFlpGq8B8uffgJXOYRnW1Sj7VmAKdRf
 cpMbd1wvy3aQLSLNyJQ1mcC5kG332ukZCe7Oq4zy02p+MnF6ppdTw72XeLS+WAydVOGR
 gBVpjRqNhwBDhwnNJt1Lu9LT7eVVTcrzn0s5S1DDxVPKwZH/HzglwJGFvidf0FjZXvsz
 yPYA==
X-Gm-Message-State: AFq9FYKhgVeFvskMHhhyhJInmGAF5KCZCGbiCKqMWUIkz0kh11IV6NR9
 1xWOA22JTeHacmnZc4AgzDt5+rzaykXPjSR1AwR70KhSfxofaApcM8jmtJ1JfmWH/S+1NxryFda
 u9frrYHXe08B+xUE3RPoUdfrWfI9iKGdV6Bg5pZnKuz/uAC45UAhmotr1S8//UlPNh7MX
X-Gm-Gg: AYBFou0OQ2mz455dOU9EIkyVdx2D9Pl0ScWqpriT306eOmM3F0OtaboLZqblRxWia/M
 qsmhZTNhraqV8w/b4/IlhO2Lyu6SZmjlr2hm+SZHJy3D1uwQFZQUNKmZ2sCWPF6kcwcrGvKRvGt
 pmsHp7I2Emoybz0hwWuCam4kR/0DwvOUOf2ca+YAERYAkG97Xdu8vP51djEst2l+82hVS2BZR/z
 Mp1lJeGjyq+pi/d4gP1lK13IHO8csjNj++aMRWqzSwsYxI5vPuf6vrkok3bZUMbG3aM8Lmbxb09
 ooVkGklyFEw+8k4iCKK/LKi8cBVay3TreGUcScN6L7sGR87Zg7TD06Y0n/eYGxdDxZghZeA8YFF
 oHuz+Hfd2y9EqblWVvqhmDYmr5DLOlsJb7zCCXk5R1AfFVaqfiQZPV78hkMIck+sW+iEMq5HILT
 DR+wgvUWqaYuy+yvR9yekfokN32h54hQ==
X-Received: by 2002:a05:6102:868c:20b0:7c8:1fd5:82b5 with SMTP id
 ada2fe7eead31-7d04f935382mr1164787137.14.1793294683412; 
 Thu, 29 Oct 2026 10:24:43 -0700 (PDT)
X-Received: by 2002:a05:6102:868c:20b0:7c8:1fd5:82b5 with SMTP id
 ada2fe7eead31-7d04f935382mr1164777137.14.1793294682884; 
 Thu, 29 Oct 2026 10:24:42 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df9e6f6sm382330f8f.29.2026.10.29.10.24.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:24:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 11/31] tests/tcg/mips: Group Release 6 logic tests
Date: Thu, 29 Oct 2026 18:22:55 +0100
Message-ID: <20261029172319.25766-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX2S2y0x/SI+L5
 kb8FK7ggykoSj5v3aasb17F//egNXApF1pITAKpbURtVRU5R0Od6C/PES4xnDoFeQdOTBe156hk
 /ODe9VAwybOHjaKKwU9hYyjhrSEvp3I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX5yz3ujwbGx8q
 WldxgCTTRNYQBDRypiY6+PNaZmd8cCC/xgjIjaFaWd/6RAS/Lo+q7HOeP2CZ0v2hWrUOA6gFJey
 F8dqSAT8pY8SN+PfVy3uNPPfHnM4ivKhRjDaM3jnGyd+X3UM3i98emMloDEV4bZf+GmldC37rGE
 c6tO6ixy6ewDKMlwDu8DaWaS1xQcDFFEPZqz9fypkNb2MeRSobgrhmOz5bcrRbipXaS67rnChcr
 8dNIwT0L+nYL8YjS5E8lYQFCQg/SSfZrL5FPskK+U/IV3Z4otgW3Xjo0jiqMHxiDAI2RJlz2p46
 UMGtle1UT2YjNZvpWvugBp18y1qkS9C0sh6TQAFqJeBQeqtsnKpGG2btlTTpsC6bosAIjr9fSWO
 1hDMB5GhHPOv7aFRMKmAUaymf6Lbdg==
X-Proofpoint-ORIG-GUID: fA_rXvamfe6YZW7i8K9D_NwDTWq2IU41
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae3815c cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=B0xLmQhOeFRMwvCvl4MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: fA_rXvamfe6YZW7i8K9D_NwDTWq2IU41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Build the 4 per-opcode logic tests as a single executable,
test_mips64r6_logic.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_logic.c | 50 ++++++++++++++++++++++++++
 tests/tcg/mips64/meson.build           |  5 +--
 2 files changed, 51 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_logic.c

diff --git a/tests/tcg/mips64/test_mips64r6_logic.c b/tests/tcg/mips64/test_mips64r6_logic.c
new file mode 100644
index 000000000000..7b8784f42430
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_logic.c
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: logical */
+
+#define main test_mips64r6_and
+#include "test_mips64r6_and.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_nor
+#include "test_mips64r6_nor.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_or
+#include "test_mips64r6_or.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_xor
+#include "test_mips64r6_xor.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} r6_tests[] = {
+    { "and", test_mips64r6_and },
+    { "nor", test_mips64r6_nor },
+    { "or", test_mips64r6_or },
+    { "xor", test_mips64r6_xor },
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
+        printf("%s %u - MIPS64R6 logical %s\n", r ? "not ok" : "ok", i + 1,
+               r6_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 0601ed52ab21..657a1c4d5cc9 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -30,7 +30,7 @@ tests = []
 tests_mips64r6 = [
   '../mips64/test_mips64r6_bitops.c',
   '../mips64/test_mips64r6_crc.c',
-  '../mips64/test_mips64r6_and.c',
+  '../mips64/test_mips64r6_logic.c',
   '../mips64/test_mips64r6_dmuh.c',
   '../mips64/test_mips64r6_dmuhu.c',
   '../mips64/test_mips64r6_dmul.c',
@@ -42,12 +42,9 @@ tests_mips64r6 = [
   '../mips64/test_mips64r6_muhu.c',
   '../mips64/test_mips64r6_mul.c',
   '../mips64/test_mips64r6_mulu.c',
-  '../mips64/test_mips64r6_nor.c',
-  '../mips64/test_mips64r6_or.c',
   '../mips64/test_mips64r6_sllv.c',
   '../mips64/test_mips64r6_srav.c',
   '../mips64/test_mips64r6_srlv.c',
-  '../mips64/test_mips64r6_xor.c',
 ]
 
 foreach src: tests_mips64r6
-- 
2.55.0


