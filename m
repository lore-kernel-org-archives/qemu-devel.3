Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D2606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C750nF2R;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E7Zp/VN5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMquQ-0003fS-5I; Fri, 30 Oct 2026 14:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqrq-0000jb-BX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:58:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqro-0008NJ-DV
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:58:18 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu2YC839487
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ln5a2kmJSKTRp3xk1+kyEyXYJkvlbQ1tjCGZIF1mlFE=; b=C750nF2RPysyW5E/
 uVw+eS3kCRVyWyF7NQgIcjag6JD5PLozYAgd30u5o/yFvKZ+/l1lMofmYrc+6IpO
 4tjR91HQI4+dGwBLkzWWz9QWmyVpTfqPVzGQ4VZG8VW0O5++opCU53u2Ybb2xXMV
 3NhdjSb8yUM7p0yB7l3+BhJKGKBN3NxDfJq9AYeUm0bdlNhxlCNMXZxkp4iWKN+e
 A9SngmZRgQF+3blIHkKn4JIxBLw0Firpz0CT2BJ6QXRQL3jSc1v7eXTH8ngcHRqg
 WjI011oQSqku6h9BHGYr7F5vM0CmFsf8qVlZU8SNbZIt3MTcHn0RET7uz2OsSJAW
 4EVs+Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme754aej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:58:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ecdc701a2so121343285a.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383093; x=1793987893; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ln5a2kmJSKTRp3xk1+kyEyXYJkvlbQ1tjCGZIF1mlFE=;
 b=E7Zp/VN5c4lnuPG6Rs0SJFbWd5EEtiSScceYMl8tPlb32f4faWiy0lYsUXXmAMtiml
 Y9fu3jzTEKqJOoRCnVrq0f2QyYeBBV0PjC2grFNIx3jJiNovLyG+ttrmu+N7KJUpj4bw
 lSMM3i2cf8iufL/k040UEnjDo2eZdS9LPTykQUj0WwDxSxWX/n5NKjazFonmiWxV1/5h
 tmFT9e2XGTHYTGCYoZQk0ZYFDdLcYPspj6Ox5/VGFZyTula3oFBkLdloK6mhIP+wLW+K
 UfrMLpSPyo6AMTtWfEsFxUB2G7HI1im7XqbPJCN5OM6D6NmHMdhK6H7L4979f6OFLtYf
 qgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383093; x=1793987893;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ln5a2kmJSKTRp3xk1+kyEyXYJkvlbQ1tjCGZIF1mlFE=;
 b=TdqDB38Sy3FcW4sVjx+fv8NkBr8F27dpcVKhqCMc0eiBuZJg6rQ7EUc6DeLCW1jwlw
 vEp/njl8OZBb0wtOeXDG8PGaAhcj3EFEP9Ch8dd60R/DpgfkOUnKWQ1QiYGheT6dQYus
 kgF4wEIi/ByjKWUStE+g7hZyF9nK52kMJgV/SYp0/EcLZ8fS+wpjJEYkb7faaXEVS6Jt
 ngqTjhm6g/+DPoOJORARZSNmtguobW2vn8Bf6xeBLSsU8E0XurkPh1k+MDnsAIOFaZrl
 CYnWBt1i1LkCZFvbvQvgvK/6fPNU9cNgZXii0jEozD6S8k0fQPx9UVBKJ6vo53ae6Pw4
 zeqg==
X-Gm-Message-State: AFq9FYLtwY9qHu3Kcy8L0rsEdnujPm9wkzEhmXvhh47aCzx2N7HUhhCL
 kju4EDe8/howUABmMBjbjVcOITJOTl47oerVJCgXQIZ0kGMT8ZGw8KleKSU3l8GZNuPp/nDJy3I
 CxtkcFFQAG9BhCrFQZaOJgxcRpWd/uVji7MQuqcg8gijqWgi/f3F7pT+o6u/DBgX4gL9o
X-Gm-Gg: AYBFou09SafS7bJXF1B1gZXZN2hG395bktdJT6/qNnhRj3RTaXd//wB5dBG+c5U1rGc
 pUyOEXoIYesixyPLM7Po/O3YDfMfa9Eu89jO2rNoxwXvJWm8LGhRrWqI/h4spxR8NC1fFUAHRrz
 +Sv7DVgdKPe0A/3RVePG5Acfyg5zsPARr9XQGxS0nbtlV0YMc/lxBl0QwJkEui5/d2XROPuslPc
 IHva9aHekHid0Dp3bajymkzv5qA5GukpRzIo7vHpnnALvyO6ZUUiOjIhJDTv/Wj2D4qntiFCwvG
 TCrz/xqjW8nx+ayMnf6VvgZ7jo3rUs97bkd8w6dNUw9/lc7r9d5c43Egk9IsbpzFhvhdG0YElE6
 G19WhB8rEMHCzw1GPwoYydhqvRw6YSWqDxEsoy997sEeMbFbgLb4i/CNyjInPVuBzLE9o3EJ2D9
 AL56iZCMuhWtRkUKhayY5rnZzbgMlyxA==
X-Received: by 2002:a05:620a:6cc4:b0:93f:34c9:9259 with SMTP id
 af79cd13be357-94421739a72mr540064185a.50.1793383092711; 
 Fri, 30 Oct 2026 10:58:12 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc4:b0:93f:34c9:9259 with SMTP id
 af79cd13be357-94421739a72mr540060685a.50.1793383092208; 
 Fri, 30 Oct 2026 10:58:12 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f3229dbsm150575845e9.1.2026.10.30.10.58.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:58:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 30/32] tests/tcg/mips: Group MSA pack tests
Date: Fri, 30 Oct 2026 18:53:52 +0100
Message-ID: <20261030175357.99684-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OotTfr5YnrUNZteYUzP_M7TewqGaE8t0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX2mlfZfqfcKxQ
 1m1Rz3r1UbqzfeuUS8n/8ccolSjtJijTgohbFbhdU5yVCqdeYUMoVsnks3TR08PbX+y9nIpBuAn
 oFG2Ys3mIukvsbyh26qPAvt6o3FEG55biihwMiuYGS9HQwXW8WepJftBoaLSM2nTJCT3uYQSx0K
 JK2Uwb+zmy0RNxeA47TPs7OduqR2uK80sq5t/3EYrBpzKGLg5xlCcQ/oizhu22S9jfaDMjWZ77b
 8RP0KsuLlbF5cZBw4D4zXee5JNdbDglJ4atJR6of6l+gQP2Xel2mACQEs0zr6t0jA6ypC5PgDDo
 WE/q4F9zW7wBRUnXesBEFPmmKlr0QNHH2vkQlNOGR5U4xRSQ0TQVEhdj6W9jjV9Ws72QS1aBhG7
 zSxfZ/TMXEYV+/9u56swcs3gJ7DVy7tS6Rqw2RpuabQt6bLWU0ZwJGGQvH3D7my8bHOZ1MpUC+5
 HyQH6bhjHtRuOrsUY2Q==
X-Proofpoint-ORIG-GUID: OotTfr5YnrUNZteYUzP_M7TewqGaE8t0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX8DHeFUBtLkkq
 67Rpxt8CN7lTMorh34vMPbslzwgpKjCY+S2gHxhWWwmRY7Ae+rJBcwET577vXUB6OMMl8lDWboA
 o91cq2kAu6wQ1xkVy0K/xujUjTTl/a0=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4dab5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Build the 12 per-opcode pack tests as a single executable,
test_msa_pack.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_pack.c | 99 ++++++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build     | 13 +----
 2 files changed, 100 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_pack.c

diff --git a/tests/tcg/mips/test_msa_pack.c b/tests/tcg/mips/test_msa_pack.c
new file mode 100644
index 000000000000..d9b911336474
--- /dev/null
+++ b/tests/tcg/mips/test_msa_pack.c
@@ -0,0 +1,99 @@
+/*
+ * MIPS MSA tests: Pack instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_pckev_b
+#include "user/ase/msa/pack/test_msa_pckev_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckev_d
+#include "user/ase/msa/pack/test_msa_pckev_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckev_h
+#include "user/ase/msa/pack/test_msa_pckev_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckev_w
+#include "user/ase/msa/pack/test_msa_pckev_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_b
+#include "user/ase/msa/pack/test_msa_pckod_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_d
+#include "user/ase/msa/pack/test_msa_pckod_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_h
+#include "user/ase/msa/pack/test_msa_pckod_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pckod_w
+#include "user/ase/msa/pack/test_msa_pckod_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_b
+#include "user/ase/msa/pack/test_msa_vshf_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_d
+#include "user/ase/msa/pack/test_msa_vshf_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_h
+#include "user/ase/msa/pack/test_msa_vshf_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_vshf_w
+#include "user/ase/msa/pack/test_msa_vshf_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "pckev.b", test_msa_pckev_b },
+    { "pckev.d", test_msa_pckev_d },
+    { "pckev.h", test_msa_pckev_h },
+    { "pckev.w", test_msa_pckev_w },
+    { "pckod.b", test_msa_pckod_b },
+    { "pckod.d", test_msa_pckod_d },
+    { "pckod.h", test_msa_pckod_h },
+    { "pckod.w", test_msa_pckod_w },
+    { "vshf.b", test_msa_vshf_b },
+    { "vshf.d", test_msa_vshf_d },
+    { "vshf.h", test_msa_vshf_h },
+    { "vshf.w", test_msa_vshf_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Pack", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index ae2c2fa6aa48..8a0ae3cdaeb8 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -17,6 +17,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_subtract.c',
   '../mips/test_msa_interleave.c',
   '../mips/test_msa_logic.c',
+  '../mips/test_msa_pack.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -42,18 +43,6 @@ if 'qemu-mips' in emulators
 endif
 
 tests_mips_msa = [
-  '../mips/user/ase/msa/pack/test_msa_vshf_b.c',
-  '../mips/user/ase/msa/pack/test_msa_pckev_b.c',
-  '../mips/user/ase/msa/pack/test_msa_vshf_w.c',
-  '../mips/user/ase/msa/pack/test_msa_pckod_h.c',
-  '../mips/user/ase/msa/pack/test_msa_pckod_b.c',
-  '../mips/user/ase/msa/pack/test_msa_vshf_d.c',
-  '../mips/user/ase/msa/pack/test_msa_pckev_w.c',
-  '../mips/user/ase/msa/pack/test_msa_pckev_h.c',
-  '../mips/user/ase/msa/pack/test_msa_pckev_d.c',
-  '../mips/user/ase/msa/pack/test_msa_pckod_w.c',
-  '../mips/user/ase/msa/pack/test_msa_vshf_h.c',
-  '../mips/user/ase/msa/pack/test_msa_pckod_d.c',
   '../mips/user/ase/msa/shift/test_msa_sra_d.c',
   '../mips/user/ase/msa/shift/test_msa_srl_b.c',
   '../mips/user/ase/msa/shift/test_msa_srl_d.c',
-- 
2.55.0


