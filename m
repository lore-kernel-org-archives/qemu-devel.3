Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807CB606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QGeFKUdX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WcO+i+nK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo9R-0001uK-Bh; Fri, 30 Oct 2026 11:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo91-0001k8-Gj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8z-0007Di-TP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERCl03564337
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YLL5RXWILMB7fjfKuCCyY50o+eS5IMIpVByg0Qj6qbI=; b=QGeFKUdX06GhlF/Y
 OnsD58HkeIehQVX636cngmQdoGasejie+k5g0JHgJZeE5Rmsz8B3IqIBLnwa6rqW
 +IjEwxz0G8kzelkf4XKyFBZGMzDLj177hMp7ZIITTptMnxqTs/m0yc3cF8NMVtpA
 3+gXxfHluRIn7Rz19hQuxEPHNaVR2SyccMUdkHJKsyT40gnQh2UyhnqepFWq8g51
 Yg7/SFzTosPrb4lyESyNMOX1934vzuprobE3q37zVyv5sTArYcedO0U/wpoRJRtC
 8mUu7OE/9sQ+juVPlRnblf4NgYfx6wtY/vgubpgotb0kiST2X1W1LcW9YVcApUlx
 +pyGaQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkm2k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:48 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5eac4de614aso708136e0c.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372628; x=1793977428; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YLL5RXWILMB7fjfKuCCyY50o+eS5IMIpVByg0Qj6qbI=;
 b=WcO+i+nK7QVYHj82ecK4FON6v4j61iypMiw8m9+4FmXHoiCWAQPR3+MezGvGtuhsle
 rjNlAEdFfC9ndoP3A472Sl6ickbQMxO2OV78VpP4GCOcIe0g9f3TV2kht94upjp9Si8Y
 XvOycN+IEkgwlxbsEYR0nKgmnXzHCBWiUSp1O+i13fU55tQMFslsZ72xg2q7urNhr/+z
 oJJRJ6xCPuLpvICODBfVycRI6bhjoXfpI6hnhqixvm8B71ZLPY2CYFExw6vDSR0ZGVib
 48j6UPa8l37a/FQXyGdwz0hDqAWzyIFWXLI+NTNV7nVugfhcvkZbRaz7PA6WLLkz/pw2
 JWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372628; x=1793977428;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YLL5RXWILMB7fjfKuCCyY50o+eS5IMIpVByg0Qj6qbI=;
 b=0golwfhuU3c2WwDUBoKZ0AO8Jgg289fypfX+t7kmRsqrf9jwG8/AJuIEMvvqfvM8AG
 ZbZ9tEB9HLtjJTTXDU9UtEkUbzCvUxNbrYw3Zb5gH17oHd9GMjRdWYkhJSuEcQHGtxXL
 34VEy0DOf7D07M5uNKxbseGtPU2TU1KNTEyEPDqwXQOgAUUdrjbGnS6tRR37JXsyAusH
 BaLfqutGopp5b5thdUuHEqcm499VXGfgTE6ugr6SBajyoUVR7TqNUtpsfMgFs1rPevIE
 XFeCE/zCS2+l77M+IpNSpbhUv6EPxNh7nHIT10ruuDgfStagb5bVeX4q5uQl+Cz9Ibas
 q23w==
X-Gm-Message-State: AFq9FYIcRKLEvEt7imzyO8wx47d7eBlylpVySB3Tmd75VUEjV0Gv4wgr
 yY0gL4mZkv5W5+k303vQSJcywF5lmdMgiEeQ4J16QiO8mNBYMjhZRFUyTOaDIDDUWUSW7GPakOE
 gTzDe38tAHxTPASx/Y4fNX0GEGhso0zAcn37Pjl5pThH5roxwvDBwKJEj3L4mkSDkANR+
X-Gm-Gg: AYBFou32ameJvGITxHZwOjIkKiCWZR/Z83geG3ePeZ+h6EBkq5l2fpwjT1j3cTYq277
 jpy2ANHIBeUyyKjR4ZQ+6Gl4DRhhPT2Xu1rXSwGpoR95/HlyFW9zKSH8cchZMs5WfU0yMHGktlT
 krBnG2QE1bW5Brjfh4cHkGvaO/nFSNURfqyD9VeL6Rk2WUYnAXNXKOFdTjG+4f5fZ9YT/IY81B1
 j6SdEiErI5Msg4HLUzfCFpX89DtGz7oKoXPb0pty3KdQmubxELTquOh66PWYACCqYFtr9/AwSHB
 25qLuJLhFo6K+9tVcM+O2WF5wCmc4bo3/3cRdrfXyObeVria5Za4wDl0mny1CjGJLu7qtS1eoxV
 CEUW06zIZZpGjzhR7/fVAjsKbruD6LX6csz0cQ6qweZVr+8b/PTxg/0X0D+TQCTmYw4HaGZE3H0
 tMRDW4oTQItGMSRaCpgGE2RPiau745kw==
X-Received: by 2002:a05:6122:3119:b0:5ea:f399:781d with SMTP id
 71dfb90a1353d-5ec6899f93amr1607893e0c.23.1793372628006; 
 Fri, 30 Oct 2026 08:03:48 -0700 (PDT)
X-Received: by 2002:a05:6122:3119:b0:5ea:f399:781d with SMTP id
 71dfb90a1353d-5ec6899f93amr1607812e0c.23.1793372627282; 
 Fri, 30 Oct 2026 08:03:47 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b964desm3663550f8f.46.2026.10.30.08.03.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:03:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/31] tests/tcg/mips: Group Release 6 multiply tests
Date: Fri, 30 Oct 2026 16:01:42 +0100
Message-ID: <20261030150202.61556-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: g6Lgyu-32lGh-cS7S544sZWcZ6BIV-L6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXwofSL5e4sufT
 ZTRFiANLJJF3oonqcaFNYt96MKXd3SOhBpUDSdEIXsnDPyIuvbZRMmCRODvW2TRf0EfyeSqXauH
 9spGqcGgotKoLFyClMZ2srPI4bXS/is=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX2KqNgO1DlClA
 +aWCC1pW6BjvhKcVzterTnUO68b8tLZ7WfpOOS+KgmxuSzDTpeN59EEBr7FjR8Tr0Pp82bNzUq3
 zr7eh4TM0dD25q+U1AYPR8Pt40OIdx5elL9M4EkfDx/46tarqgOPIUdL2Op1bhXJNV/cUp7NXaM
 JTblzg5zMW05NpJYxI5Z0+3MgjLszrar6gjtHaaULv1myESNW+hgYWNNYPcAaVEFOGH4LBqSDC0
 Q4cgZEJdLL1Zw5PgH62oHTVp40A68QKmWVRm/pbRdAZPPZNO6Q1Bhn2nBIRcD3Yy/3Q+Hi1MJ9A
 emfEuni2tMuqkwUvf8+sRekhtcRhVvLSzTTGURAQSYR4nFolbJrOscQCxIiRtL5Z+Jq8nYcMAE1
 JGTZ9qRfqQh1EcMA1b7epadv6+wQWOcqiFJnYCqKXY652PaNy9tNZW9YrGv7kZC3qA/F7g6882P
 qlBPmC8QPM1xpBcsfXg==
X-Proofpoint-ORIG-GUID: g6Lgyu-32lGh-cS7S544sZWcZ6BIV-L6
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae4b1d4 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=bvgRRmj5kG-2naEzI9QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
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

Build the 8 per-opcode multiply tests as a single executable,
test_mips64r6_multiply.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_multiply.c | 72 +++++++++++++++++++++++
 tests/tcg/mips64/meson.build              |  9 +--
 2 files changed, 73 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_multiply.c

diff --git a/tests/tcg/mips64/test_mips64r6_multiply.c b/tests/tcg/mips64/test_mips64r6_multiply.c
new file mode 100644
index 000000000000..e400d418b9fd
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_multiply.c
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: multiply */
+
+#include "../include/tap.h"
+
+#define main test_mips64r6_mul
+#include "test_mips64r6_mul.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_muh
+#include "test_mips64r6_muh.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_mulu
+#include "test_mips64r6_mulu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_muhu
+#include "test_mips64r6_muhu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmul
+#include "test_mips64r6_dmul.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmuh
+#include "test_mips64r6_dmuh.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmulu
+#include "test_mips64r6_dmulu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_dmuhu
+#include "test_mips64r6_dmuhu.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} r6_tests[] = {
+    { "mul", test_mips64r6_mul },
+    { "muh", test_mips64r6_muh },
+    { "mulu", test_mips64r6_mulu },
+    { "muhu", test_mips64r6_muhu },
+    { "dmul", test_mips64r6_dmul },
+    { "dmuh", test_mips64r6_dmuh },
+    { "dmulu", test_mips64r6_dmulu },
+    { "dmuhu", test_mips64r6_dmuhu },
+};
+
+int main(void)
+{
+    unsigned count = sizeof(r6_tests) / sizeof(r6_tests[0]);
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < count; i++) {
+        tap_report(!r6_tests[i].fn(), "MIPS64R6 multiply %s",
+                   r6_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 657a1c4d5cc9..d356689e54bf 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -31,17 +31,10 @@ tests_mips64r6 = [
   '../mips64/test_mips64r6_bitops.c',
   '../mips64/test_mips64r6_crc.c',
   '../mips64/test_mips64r6_logic.c',
-  '../mips64/test_mips64r6_dmuh.c',
-  '../mips64/test_mips64r6_dmuhu.c',
-  '../mips64/test_mips64r6_dmul.c',
-  '../mips64/test_mips64r6_dmulu.c',
+  '../mips64/test_mips64r6_multiply.c',
   '../mips64/test_mips64r6_dsllv.c',
   '../mips64/test_mips64r6_dsrav.c',
   '../mips64/test_mips64r6_dsrlv.c',
-  '../mips64/test_mips64r6_muh.c',
-  '../mips64/test_mips64r6_muhu.c',
-  '../mips64/test_mips64r6_mul.c',
-  '../mips64/test_mips64r6_mulu.c',
   '../mips64/test_mips64r6_sllv.c',
   '../mips64/test_mips64r6_srav.c',
   '../mips64/test_mips64r6_srlv.c',
-- 
2.55.0


