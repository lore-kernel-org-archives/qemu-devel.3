Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CE3606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pps8XEqn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hzq5BQBH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqsa-0001pn-Iv; Fri, 30 Oct 2026 13:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqrd-0000Th-Dh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:58:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqra-0008MI-PD
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:58:04 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu33R3977499
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VakULRF/ZlzQg9DlX20JmxO+/KBixFvRDBeFbdHtf/0=; b=Pps8XEqnjahPkGNO
 CkxEzM5ZASrcj+GZkTrcTUKqL3TyhcIqBuLSt1LMNhR8C842uRvU7SFHJrWC/EWi
 zPSgHe6iSForemdZ88X/nuYY8McLL4gidtqiIDdqZxlqU1tI4kE78RCjY9OmFUWf
 9s9Dg9p+suwWAXh0nX9adoyT/dqpjQQHcHRVEbnxWr37LFrrcG/H01ImgEEIUi4E
 xtB573v69ST91TJcDG9hzehm6EIAW4MvomXBn8jb4DOqXCxyoe+TjX46X6VMR7RK
 2i7En3sdZaRWEwiSfI8t4pj4yZ5kGSmchUVvWJQKEPhtqRTGuefKknEqZxF6LzjE
 gnjRjg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmd7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:58:00 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-98a829c43f3so258870241.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383080; x=1793987880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VakULRF/ZlzQg9DlX20JmxO+/KBixFvRDBeFbdHtf/0=;
 b=Hzq5BQBHM9tNjRMG+QcGh8bo5sw2RzeAu2+KtuhCkgvSpxHPlgKqbqqauRogW09Jsu
 3mo9K1a0ALgtd72fez7C+7z3ZgEzYLCsEzjYCAuxWdp05zfpZZqwg15I/zZML9FiBKrM
 LmWTjnjC7V9FWUanYs8Gim2Ulqe8BPcEPNBoSbMwBatZH/FPTbRw9S37TjsQwmnozIGv
 DKedDkPQlHqvG3BFjvNkemA+2POlTnfZhLl6sVB+1eFygH1Hm+1n0johXpFrZ+KfTw9/
 OjusKmYTQB1jjijNv4yN+lhma1qWMBXbbHNkNdBpL32sZPeltQHsDDn+8DxcW2m/1Brj
 DHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383080; x=1793987880;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VakULRF/ZlzQg9DlX20JmxO+/KBixFvRDBeFbdHtf/0=;
 b=wJ17RC8LI1qpIPy+0rGv3f355mQpR0tEzkdpp9nUWZJ0KdzD36pssIPTzl150anW2V
 V0tU17ZksBZUolMUAFTiGx76bCYihT+Duma29tbwvt7ShCWnw39pG6yb9eQmOyj3qV9M
 4st7YA6P2NlOHzcoFp/LgjZj6ZDUU0rOZwoWbbO1kdEXHiQbLnYYrjtnjErhVkqswoGz
 sBzhMrP6Gn80r65BjueHtGs0XFgk0FtA4spU0Q+vss8h8z7SCNvWhqsJPv7e2etd7emX
 IZNuJWvC+gHcIL7DQS88UQYcoHEFUZ4TUYqugiUUdhtue4AgegVMPjQkIitHyUp/bhWS
 bF2w==
X-Gm-Message-State: AFq9FYJUYKdqusHdipbZcBIvxPJW4fheSaev2Czp72LGB50V7XOvf20u
 6bQRR7n2G5axWkNj8UzkUxoomg6utKBhiOu9ErplNr8OdTMATtf4N4lyt8X+9oyt1mdx1YeIG8S
 ILc3yA5i/JfpRi4uXJ1/Hnn0CXURnaXbM0rsa7E72oCxcXqHazwOfPuiDxtA7kZwR/nc3
X-Gm-Gg: AYBFou1sq6wbybpvkaUw8zSYlTVXpaf470L8RjQaUvWiC6mTwgVBs+673fo3YAbwv9u
 jJv9dWSTbic1aBWb8lr8M1XbB4K51NKr/kWorjyGpfZ4fdf7a4foozjbQbIMk7GaMIRyaX5VcGq
 mpHpDy+FJKzFFZgyaO0U/jRpP2Z/PyMby+904SXBQkCMSd9a1I2v9i+wopoZMzwIGNsN3lcDnT+
 G1cWOLUSu2Cm6xVTJaeBZNeDjU5Ym+WV7oJG5jqwLfc7wSwAUcASW/cpJF03SNmzKKqbZ/WEZvu
 U1daCQPxWpMC4d4pAnczvNnK/57pGUesi3/LYpZyL0AdSiP9PPQob+4y1bYVs6W67NBA589beXO
 0yXTHcWlafFffauNxMrQuzQ3dS4XCRBUgqLB6yYzKZ9X7Z1fph0Jxz6vgNwKtKUOL+j3jYady+X
 PuNcuMk7AzoTOBvl2i/jXzkfu2+SIOwg==
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr1429303137.9.1793383080000; 
 Fri, 30 Oct 2026 10:58:00 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr1429293137.9.1793383079503; 
 Fri, 30 Oct 2026 10:57:59 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8c0b6sm4139333f8f.41.2026.10.30.10.57.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:57:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 29/32] tests/tcg/mips: Group MSA logic tests
Date: Fri, 30 Oct 2026 18:53:51 +0100
Message-ID: <20261030175357.99684-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ozLpBzaqmVPsd-6SpQCN7X3p5CX53U6N
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4daa9 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=XEEDF0r_pM4_IqxSCIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXzEztP8lvXIQ/
 fXpKTrN9usMVAVb9Y1nyg2OOH4tOhzmnCLqbUKz1PMiCo4S88m0or7mr25GHw5abk89OKGwV78Z
 tdDlyxNDg2bMVsdC5VCMmbA8Pg+7m3qAtPk0bCncpaBXZSU5agXOzHjK7Pp4NGnz/oCO9a/Lp73
 0/K2FSJyxeaFl9eXGbv1tMj+2eimo//fFjClT6I/62JijT0kTTen6onsC7BpQUEoQDrin0h84E0
 BCgfFy8CJMl32Un35IVwf4tnXqsqbAUzVdOZyYpzaGo+aCs6dE9NCfF8nFEXLxylylqY5Sa9SUc
 +1Fz4n8tszs9Z5R2IPV8Gry9q0H9oDisE8WWAIjUNPUAJ8aR+VCaoC0skLV0JwFH8fL352NQxnB
 sb9+8t9CWOm6olLCoQh6V8YsClo+mPZ9hAV04zsyfqw/TfFN8OsBCLqshCE1G/2+kww+zY7LYZV
 hDmzIGWrjxxGKi4gzJg==
X-Proofpoint-ORIG-GUID: ozLpBzaqmVPsd-6SpQCN7X3p5CX53U6N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX01rpk8fNtyZt
 jPM8CtkuKxU31mN5jDSEMMXXcHTkRfKCbX0KMFc3FJMAYFpgTO1I+2LgPycpZujX0BvUsXM6xYw
 e2rZM1OcsEbkw28G4/R/frj6ksFBCMk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Build the 5 per-opcode logic tests as a single executable,
test_msa_logic.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_logic.c | 57 +++++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build      |  6 +---
 2 files changed, 58 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_logic.c

diff --git a/tests/tcg/mips/test_msa_logic.c b/tests/tcg/mips/test_msa_logic.c
new file mode 100644
index 000000000000..4e96c3ebf0e9
--- /dev/null
+++ b/tests/tcg/mips/test_msa_logic.c
@@ -0,0 +1,57 @@
+/*
+ * MIPS MSA tests: Logic and Move instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_and_v
+#include "user/ase/msa/logic/test_msa_and_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nor_v
+#include "user/ase/msa/logic/test_msa_nor_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_or_v
+#include "user/ase/msa/logic/test_msa_or_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_xor_v
+#include "user/ase/msa/logic/test_msa_xor_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_move_v
+#include "user/ase/msa/move/test_msa_move_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "and.v", test_msa_and_v },
+    { "nor.v", test_msa_nor_v },
+    { "or.v", test_msa_or_v },
+    { "xor.v", test_msa_xor_v },
+    { "move.v", test_msa_move_v },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Logic and Move", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index cc94623f8f20..ae2c2fa6aa48 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -16,6 +16,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_multiply.c',
   '../mips/test_msa_int_subtract.c',
   '../mips/test_msa_interleave.c',
+  '../mips/test_msa_logic.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -73,9 +74,4 @@ tests_mips_msa = [
   '../mips/user/ase/msa/shift/test_msa_srar_w.c',
   '../mips/user/ase/msa/shift/test_msa_srlr_b.c',
   '../mips/user/ase/msa/shift/test_msa_srlr_w.c',
-  '../mips/user/ase/msa/logic/test_msa_or_v.c',
-  '../mips/user/ase/msa/logic/test_msa_nor_v.c',
-  '../mips/user/ase/msa/logic/test_msa_and_v.c',
-  '../mips/user/ase/msa/logic/test_msa_xor_v.c',
-  '../mips/user/ase/msa/move/test_msa_move_v.c',
 ]
-- 
2.55.0


