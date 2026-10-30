Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4CC606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KGmtoQd5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BJv4Tf2Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAw-00042E-3o; Fri, 30 Oct 2026 11:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAD-0002KO-Oe
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAB-0007J6-Nh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERLhL2968145
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J5zM6rPAVM4954wK0YJT2FXUcIUk7rKVpkzOWfHeu3A=; b=KGmtoQd54lYsVEbO
 kb356aUhtrvSR6n9YiDONSZJ+eisSRBRjuVsOj1qYFT+kzt8SgFTj5aP5RE4TSTr
 xaVUSmI09k1mY8fciFsL3rfcL5YDIo4X/Eb7/jzg+w5cnMrP+UCYMdTUZLPUo2Zl
 U1/4l2EHv5vkNsUDePni1xJx2zS4SB+gpV8GPTdYuFlFy1xhB4tVabOf4HpAyCQE
 +9ByjGzl59QU3UZWnWz2CX1IH26ISmA8iCeffX0FdeOERSfo3BwtHdUf92Dy6lfq
 5Jj0kuw9HeAU60KcWOxCDjRfltnIsngAK2+AB+dY6RaEyrR6bPZuO+C9XM9WJlk2
 GTLTeA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkncc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:01 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ec21d5bf78so244666e0c.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372701; x=1793977501; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J5zM6rPAVM4954wK0YJT2FXUcIUk7rKVpkzOWfHeu3A=;
 b=BJv4Tf2Zs1lSAco+RKMhOdKaytSY8uAdjpfC/SLA9r0i76whi1ozLlzlWs3g77ktI6
 GO5eROocZyqYre9urkMi7PmpU8rHLdIKQHt5rVfbFtUnc6fBf762gjUeX6dJj7yDLqc+
 0Qo3QuMkquDxoLPmyn0RncsMxMs/H9aRn3n6Q6CV/KBsdzYPSguYRaZeqQqbYxGCCzkB
 kHvBezXqOlKBleZp3OBe/V98+AWO1Z1p6dKdGq1x3zVnnQ9jlUMtRUG2cV0JrAA9JW7F
 pkxHk9zg6zyl4Slz+isQQDoEprOHd7aQuxdBg83a1a6hTFrv9HJfq7/AdYZo/qVxd+0m
 PLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372701; x=1793977501;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J5zM6rPAVM4954wK0YJT2FXUcIUk7rKVpkzOWfHeu3A=;
 b=04xvb4xza/3+J16DmUlVYQJJrdixCOKDUz0iF/FidLoHh8EzK3EoZQTFzrBDDDOTT5
 Oq1xmqFVYskqTxO7eMQQd/WNAkx5qp9ubzbdrMvyew0Vu24+/7oj+51vUJPumQhmKGj/
 IVx1ZjgMLsJJKP4BPqFE2Ra0QbNPeOoaWXGlgGyvoKAR4dzWvgmwWfCYooT7PWQ+NXKe
 9wwwzNlRMFq4bgs4oS7CYxFA05RpidaPuzA77oIuw6OVP04+cwkrR9S3c6CgJs3k68Xv
 i8vMTnXvYU8oP01cpXU4aeKXmPbtTpx0UF01Ex7OhMe5Flpuh0B7dOs/ELypq3qahdJ7
 kBIg==
X-Gm-Message-State: AFq9FYIJrcLVQVrjGCKh2xOz6SMosZB0CmOucb1hTUzogfxIuIBexSHB
 PWHYp/ugZ0zWFbWDguYz4CI+5KjrfIJjpR/GVGj+486CtG9REywGv5gPLpVQpMbvvFUtuNLF9bp
 kFp3z3UUcF9G68Cw31h9x5Cd5B1BbecUdVyfjE/7OHLaUPV7Yi67tQmF24tSdMCqr5bbH
X-Gm-Gg: AYBFou2wN/VRXafEHivhmLVIqntHXPFcAk1XJ/KdjzMkkEok0sthx7jV4GkDkfCObXS
 H3wMN98KnqNQ61uSov4egIh6Vi3SvUWKQfHs0KU+u6tlhp5STP33u4u6JCSF5Ao+2ZGPW+lJiDT
 WC051eu+xHjJoTwUHb0OlfcBElCG7fLfEApu95y9I/lWinVzfckKey6wm7qIzb2QEH0X4iz0xj4
 uX1yHrUiwoxRasotgdemh+f3ylGe1GYbZthc3e3HhU0IYD/vvAx8l6qR76qVQJrnedGSWLRAORQ
 7kiougpidykZPfXPZzcUO/dGhIsfOlB6mS0N58KMJDIvH4xmZKol/CgGvwasPo9+sWp83254CZU
 JsQCu7LtcBPpktayipOPURdGZlpCtwqU2pn5CSImfcdpGGMcirk5ZDZOQmJsnrT+ewMH2UBgLr+
 VechYPcKoeuS7OecCwHO/YuZNaafOV0Q==
X-Received: by 2002:a05:6122:3115:b0:5d4:1193:73d3 with SMTP id
 71dfb90a1353d-5ec6894bf5emr1356787e0c.14.1793372699358; 
 Fri, 30 Oct 2026 08:04:59 -0700 (PDT)
X-Received: by 2002:a05:6122:3115:b0:5d4:1193:73d3 with SMTP id
 71dfb90a1353d-5ec6894bf5emr1356719e0c.14.1793372698738; 
 Fri, 30 Oct 2026 08:04:58 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b789ecsm3638264f8f.29.2026.10.30.08.04.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:04:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/31] tests/tcg/mips: Group MSA int-average tests
Date: Fri, 30 Oct 2026 16:01:50 +0100
Message-ID: <20261030150202.61556-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfXxnjqMG88g+Iq
 96aVovWvY/eu/LEt3VVuiLYj+lQxik8vet9WRHiOj/9fITo9E+p1QblME9rny+cKjlS4C7RlgiE
 jBDwwqLIj3TbtsW071bszFsXhovbcEO6EfLLrB50aq4kviZugytDFwGcnvxdz+xDtxjdiQny3xn
 4qvvQ4LioRRf4ILMWxACAGHVQ366bmlN4UsdMuBsL04P1PU5CJBf+bwRzMCB1Ky/AV8qJKUuGF/
 2cwAx6sHrwGuAfEz/0VRBvkWG0M42u7BUdWzGtjGJUBqNRywVsv0ZkI+ffAwtC+3kQxtaosFnSg
 w+s/IoBbCCSUPJn2bSv5gdRofSjr+oRMUcEjNeJ07tPK+navYx3Hh2hUjo72ujaxtuha2KtO4dl
 N+I2lnEjorlqCzbXqlGT4B6q/yqOL/ZT221UisoDNIDk5VftCoz7bAAPMFm+7Amcf81Uyx77Okg
 Cl7hBIcIxSPtWfX1ikA==
X-Proofpoint-GUID: 2eJShOGuekvGyK2vZfOMWx0HczHRHL5V
X-Proofpoint-ORIG-GUID: 2eJShOGuekvGyK2vZfOMWx0HczHRHL5V
X-Authority-Analysis: v=2.4 cv=IumL47/g c=1 sm=1 tr=0 ts=6ae4b21e cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=XlFCZ7tVMrZGAbOMMLgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX3n/izSitZxGo
 6PZdmIwsSHmMM19PPkiJo/ySPBUJFHALLlasKiL4OWr7C6//JBREq9LneOqk3ZlXRAOHtcTrzW2
 KaZ6bV+6AgQbgo1lu71pQnEDLodg7PY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300060
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

Build the 16 per-opcode int-average tests as a single executable,
test_msa_int_average.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_average.c | 123 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build            |  17 +---
 2 files changed, 124 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_average.c

diff --git a/tests/tcg/mips/test_msa_int_average.c b/tests/tcg/mips/test_msa_int_average.c
new file mode 100644
index 000000000000..f3ff9fd345bc
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_average.c
@@ -0,0 +1,123 @@
+/*
+ * MIPS MSA tests: Int Average instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_ave_s_b
+#include "user/ase/msa/int-average/test_msa_ave_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_s_d
+#include "user/ase/msa/int-average/test_msa_ave_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_s_h
+#include "user/ase/msa/int-average/test_msa_ave_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_s_w
+#include "user/ase/msa/int-average/test_msa_ave_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_b
+#include "user/ase/msa/int-average/test_msa_ave_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_d
+#include "user/ase/msa/int-average/test_msa_ave_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_h
+#include "user/ase/msa/int-average/test_msa_ave_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_ave_u_w
+#include "user/ase/msa/int-average/test_msa_ave_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_b
+#include "user/ase/msa/int-average/test_msa_aver_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_d
+#include "user/ase/msa/int-average/test_msa_aver_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_h
+#include "user/ase/msa/int-average/test_msa_aver_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_s_w
+#include "user/ase/msa/int-average/test_msa_aver_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_b
+#include "user/ase/msa/int-average/test_msa_aver_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_d
+#include "user/ase/msa/int-average/test_msa_aver_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_h
+#include "user/ase/msa/int-average/test_msa_aver_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_aver_u_w
+#include "user/ase/msa/int-average/test_msa_aver_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "ave.s.b", test_msa_ave_s_b },
+    { "ave.s.d", test_msa_ave_s_d },
+    { "ave.s.h", test_msa_ave_s_h },
+    { "ave.s.w", test_msa_ave_s_w },
+    { "ave.u.b", test_msa_ave_u_b },
+    { "ave.u.d", test_msa_ave_u_d },
+    { "ave.u.h", test_msa_ave_u_h },
+    { "ave.u.w", test_msa_ave_u_w },
+    { "aver.s.b", test_msa_aver_s_b },
+    { "aver.s.d", test_msa_aver_s_d },
+    { "aver.s.h", test_msa_aver_s_h },
+    { "aver.s.w", test_msa_aver_s_w },
+    { "aver.u.b", test_msa_aver_u_b },
+    { "aver.u.d", test_msa_aver_u_d },
+    { "aver.u.h", test_msa_aver_u_h },
+    { "aver.u.w", test_msa_aver_u_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Average", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 7ef3d6aafa8a..7da4aece8409 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -8,6 +8,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_fixed_multiply.c',
   '../mips/test_msa_float_max_min.c',
   '../mips/test_msa_int_add.c',
+  '../mips/test_msa_int_average.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -192,22 +193,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c',
   '../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c',
   '../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_s_b.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_s_b.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_u_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_s_h.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_u_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_s_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_u_h.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_s_d.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_u_h.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_u_b.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_s_d.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_s_w.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_u_d.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_u_d.c',
-  '../mips/user/ase/msa/int-average/test_msa_ave_u_b.c',
-  '../mips/user/ase/msa/int-average/test_msa_aver_s_h.c',
   '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c',
   '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c',
   '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c',
-- 
2.55.0


