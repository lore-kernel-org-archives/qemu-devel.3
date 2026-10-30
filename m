Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FQMcYnpE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YzhBKJrP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAv-0003ur-9i; Fri, 30 Oct 2026 11:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAM-0002VD-EM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAI-0007Jd-OL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER1Yn3515192
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I9kYTVvJAtaI8oIgstgeblI6rSZ5zFGFIV1Twkx7UjM=; b=FQMcYnpEbxIA4WbF
 SLH46joyvF057qT5UPr0R2Ap6ppQ4vH5N/EAOoGKSQcuA1efIAel9CyKPJajEWc9
 pyXDXfbux838bnEOQDF82PdG7diARiBa/SFfS9U2nbdqsFXz82Ltnum0bCbLUd7J
 /+alXi9I0c9lwKqg45OlWPUJ5OrST+yFiLCMjvZ5OvL4tJm1ZUhzqAf5s2cchE5l
 bUXEMPVc2Epqv0XFxPD4dH6oNNBCJrSRYcBp0RVnMmqhrzigihYUmXpCWqswWqnz
 zPaINZmJnUFZ8ej2AGlLGCE8N0bwGSjBjoikR7PSn+CoAuu08T1tEPuxrq6yvD2B
 6ohcYw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkph6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:09 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eac41ff334so894513e0c.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372708; x=1793977508; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I9kYTVvJAtaI8oIgstgeblI6rSZ5zFGFIV1Twkx7UjM=;
 b=YzhBKJrPpp7d9vCa7mdCE1XCirErRaWcrGoBVCsiyopO5ZXu+6rEVEMuIadYT9ohY1
 cc1rsjorHE2uES5OaS8/Tspmgfx8kBFrZuD/VnuF3fg6/MYF7Uu/u0JDfqha5RgzZd3p
 JVZ75S4feN4XRnN9IYtoY3NvG6XQWOxJOT51ZBW4nECkKK4DrTnhC2EzbRz4IwFHuOEt
 2OxfyB4Q4C0QmfaPuofE8KqlZ5wmpSJlQKAhQIQ3aBFgkzeeb+YYowQTFszSVSi0p48t
 ojpIwV/ilhCqaaSDDBzgbGfSLsqlhyQT/NexhKonU6ATtikLi8IcENsX2VY4H+XFNgOD
 u7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372708; x=1793977508;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I9kYTVvJAtaI8oIgstgeblI6rSZ5zFGFIV1Twkx7UjM=;
 b=foi3LyLtCMeqSBlDcKYZ/mI09++4RYeFCBzAGd93r/jAGzqK6/tFc0VxtZ8/iRL8HC
 79VgkKIS8mfx/Mn9oq8TQvHk2vEzCyOVrGhsd9STXJi+/ULaBMKXLo3TxPe8V7xze1iv
 ZY4Lt/IcmvRo3DhG6/694gNWyugkP8wPsnD/LrgrlgkBiSqbfRvfTAmB6PR36lc3UJgv
 qc2GWn55vphS71wWL8POh83IK35SGQfy2lhoIxYyPj9igqFDPYmvpEIX2KgEWGHBb0Fm
 0pI1jAjJpPagAWri05g71fYHdkRH3na9ARmW+7tBXLNDDXuFDKxmFDxMqRLdZ7AByb8t
 vmRw==
X-Gm-Message-State: AFq9FYJH6nLPpFJDR5tQUq7OYRwBWfdEFL8ZNT6Cuek52CZ7zbXs4CMc
 kVUsaZgQSsySyGaVF2AfYCN6FrrSXaesvuMQXoyU9zNvgsefcRgygWgTJEQHrCsOZONtliBUAPV
 dVr5dkWYm+VcxIaUzDcK2yRMdL0TWeGwi7SWe6Erocfo+oq6Wj3yFhPKxxlvUo+hvObTk
X-Gm-Gg: AYBFou2vspyxaU/VcRXx77Vi5In6Ivj6lbfFaR+y+L2c8WuTmYwgblDdHs9PicWTL4N
 t1kIpyuFeaOvwragTEe5f4Jna5SfdBY8LgQj9W1EQ3r8jvI1fqoJj8+WH782env8OX6Xny5W08J
 tbyZMT3OQYtTZ1yEsnQd93nSlASQwNb+GDzXBrVBNYphoaKSaW3Z8QT8mZNCkOUlEPXRESwjB4W
 Yti5SZN/OrmI7z5ChoCJzpuTg3U7KTiVt6JHghyZF5HcpdtrPGn+2O8oTtqzMhfyTj265W6Zakx
 ysnqTUtRWEjPpHCskiASTF3iiZ/G5t3fkKDbjlzwjPYyCvwV3ZM5ObTpw8caHy7/5zhr41laYrJ
 gWstEh2HjvOw3+KaD1SpLy1XqpKBYl2gbqj3FsyYshgesc/q9z3xanZzwTTZlhAnClWoUSyrb7v
 ESDl/pel4esSJ4EGFJf2RYaJsrbVVbug==
X-Received: by 2002:a05:6123:86:b0:5ea:d0b0:e6f1 with SMTP id
 71dfb90a1353d-5ec6871d3ddmr1296319e0c.6.1793372706475; 
 Fri, 30 Oct 2026 08:05:06 -0700 (PDT)
X-Received: by 2002:a05:6123:86:b0:5ea:d0b0:e6f1 with SMTP id
 71dfb90a1353d-5ec6871d3ddmr1296231e0c.6.1793372705818; 
 Fri, 30 Oct 2026 08:05:05 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba53d7sm5464606f8f.53.2026.10.30.08.05.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:05:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 21/31] tests/tcg/mips: Group MSA int-compare tests
Date: Fri, 30 Oct 2026 16:01:51 +0100
Message-ID: <20261030150202.61556-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2OGffyTw4YU2PHYPybPTSrWzCj9f9OsE
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4b225 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=MrkvrxfUm_GaFPyPbecA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX9GDG3OhXBjQ0
 kwLDgHoR28Z6aP5GJTXaBev5ZRXWlfaavms7geamsmbFptF31AXbb0UAVzYZbZpOQNaQJA7wswz
 Y4mGhEr6Guy8iWHnpSzYsTNnY4JKK/2KSW/JObvuqJCUbZZwlDJ8TsLiChJACGsdqSfyRIP02Eh
 suE3qPV7zI9GZYc1gi3oKIu8z4CrTV6bYejawGoRJSgrzdpvhHtKzjMzTS97Ua+Nh095Yc3Hwqm
 ju2PEaevSekGzpsVjF0emNOn4tD5oefFKAMJVzcxqWq+rs3ETIWBJtniG43Sxp7O+Uh33Jb1Ky6
 Z0WYwzStPOjC9lsv4x6gEZXzzLElp+TXsWjoNG9eLq9SLJsJaKf5TVXIh+sp4xWo5PEhvIRfXvn
 ZYTOAuJ/ixx1+57dqUgBHxqvWApTMLzXyf4EUZXBWftNYOCIqqhzbVFkZuTXrAup3xY4jwyIrdq
 rDhtJigmcBkfQrfgvYw==
X-Proofpoint-ORIG-GUID: 2OGffyTw4YU2PHYPybPTSrWzCj9f9OsE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX7k/edP37nnp6
 T2q7H8y9GFGrrlKOvVWFdR9PdrLmZeVeSHH0+odzykRNBBGUwllqzaAg4V9R/7nIBy+Hy1SAFqy
 IIAytz9hSeOiKoN5KoAJXOavgE+2dNA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300060
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

Build the 20 per-opcode int-compare tests as a single executable,
test_msa_int_compare.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_compare.c | 147 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build            |  21 +---
 2 files changed, 148 insertions(+), 20 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_compare.c

diff --git a/tests/tcg/mips/test_msa_int_compare.c b/tests/tcg/mips/test_msa_int_compare.c
new file mode 100644
index 000000000000..b500772be5d5
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_compare.c
@@ -0,0 +1,147 @@
+/*
+ * MIPS MSA tests: Int Compare instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_ceq_b
+#include "user/ase/msa/int-compare/test_msa_ceq_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ceq_d
+#include "user/ase/msa/int-compare/test_msa_ceq_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ceq_h
+#include "user/ase/msa/int-compare/test_msa_ceq_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ceq_w
+#include "user/ase/msa/int-compare/test_msa_ceq_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_b
+#include "user/ase/msa/int-compare/test_msa_cle_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_d
+#include "user/ase/msa/int-compare/test_msa_cle_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_h
+#include "user/ase/msa/int-compare/test_msa_cle_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_s_w
+#include "user/ase/msa/int-compare/test_msa_cle_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_b
+#include "user/ase/msa/int-compare/test_msa_cle_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_d
+#include "user/ase/msa/int-compare/test_msa_cle_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_h
+#include "user/ase/msa/int-compare/test_msa_cle_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_cle_u_w
+#include "user/ase/msa/int-compare/test_msa_cle_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_b
+#include "user/ase/msa/int-compare/test_msa_clt_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_d
+#include "user/ase/msa/int-compare/test_msa_clt_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_h
+#include "user/ase/msa/int-compare/test_msa_clt_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_s_w
+#include "user/ase/msa/int-compare/test_msa_clt_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_b
+#include "user/ase/msa/int-compare/test_msa_clt_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_d
+#include "user/ase/msa/int-compare/test_msa_clt_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_h
+#include "user/ase/msa/int-compare/test_msa_clt_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_clt_u_w
+#include "user/ase/msa/int-compare/test_msa_clt_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "ceq.b", test_msa_ceq_b },
+    { "ceq.d", test_msa_ceq_d },
+    { "ceq.h", test_msa_ceq_h },
+    { "ceq.w", test_msa_ceq_w },
+    { "cle.s.b", test_msa_cle_s_b },
+    { "cle.s.d", test_msa_cle_s_d },
+    { "cle.s.h", test_msa_cle_s_h },
+    { "cle.s.w", test_msa_cle_s_w },
+    { "cle.u.b", test_msa_cle_u_b },
+    { "cle.u.d", test_msa_cle_u_d },
+    { "cle.u.h", test_msa_cle_u_h },
+    { "cle.u.w", test_msa_cle_u_w },
+    { "clt.s.b", test_msa_clt_s_b },
+    { "clt.s.d", test_msa_clt_s_d },
+    { "clt.s.h", test_msa_clt_s_h },
+    { "clt.s.w", test_msa_clt_s_w },
+    { "clt.u.b", test_msa_clt_u_b },
+    { "clt.u.d", test_msa_clt_u_d },
+    { "clt.u.h", test_msa_clt_u_h },
+    { "clt.u.w", test_msa_clt_u_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Compare", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 7da4aece8409..199b1b934a5e 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -9,6 +9,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_float_max_min.c',
   '../mips/test_msa_int_add.c',
   '../mips/test_msa_int_average.c',
+  '../mips/test_msa_int_compare.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -144,26 +145,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/shift/test_msa_srar_w.c',
   '../mips/user/ase/msa/shift/test_msa_srlr_b.c',
   '../mips/user/ase/msa/shift/test_msa_srlr_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_w.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_s_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_cle_u_h.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_s_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_ceq_d.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_b.c',
-  '../mips/user/ase/msa/int-compare/test_msa_clt_u_d.c',
   '../mips/user/ase/msa/logic/test_msa_or_v.c',
   '../mips/user/ase/msa/logic/test_msa_nor_v.c',
   '../mips/user/ase/msa/logic/test_msa_and_v.c',
-- 
2.55.0


