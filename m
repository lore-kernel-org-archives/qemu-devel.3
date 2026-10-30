Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D6606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AngkBqWv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ti/dsM3V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo7p-0007AD-2x; Fri, 30 Oct 2026 11:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo7n-00079y-Dt
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:02:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo7l-00077D-Bs
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:02:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERJaf378768
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3BOiSu4vlk2F6kRbMbvOSyuAde8P5K4yfc2fmbZWTw4=; b=AngkBqWvbGeAse/A
 oh1knXXvwF8P62gZyMMFTxBtnR1SHp8KPki7NzXeVIqYf7X1oqLdOn/DoU97NlxJ
 sgUy7vHXx6SNPIdxtEy/VuFlWNadh0pX+cGMJX/eIhKUqrSU7HaJaq143tVhXXaz
 IoNI7bT23r/8MoKqgjrv9K1B8oPIudoWS1r36dKZXPxCTBZPbJzU5d2pRhEB9G3q
 I/i7D1mpmixJbfNknX4UZcROd4PdTlIlB1qEURpESOH5hH8pTI9wzd7U1t13jR1M
 zsrxW/NWES8HiFyjfvuNfPaFisCruzjInYkR0Hfa0WvW97dfFuOM0HnK/yMYL9Xm
 WpSgSQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme753mcu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:02:31 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5ec62c05c25so1292483e0c.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372551; x=1793977351; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3BOiSu4vlk2F6kRbMbvOSyuAde8P5K4yfc2fmbZWTw4=;
 b=Ti/dsM3VqV1tACUT+ThL3hhWzMqfmJ3bJJNWgX0cYjviplIM7LcCEuQ8MNP2Ks7Nvg
 YaVsNyPzlKyCya9fSPnv8ZsQPL/wTRMDEHoBZEU1v+R09zRt+aa7ar8msCg0R+mC/mTm
 rVqbp9T2o5J0QHtZSV6jAbTJotjkx3M0fF5aeZhqlzFZFafOVQBwD/vcYRSCkcF6YrQ3
 nUctzCXZuZzHQYLIquTtDVY3Np2g/HxT/x1BRSG7+1ZvSVHyqb4CwYbDYNyFoFYApOe1
 2bmyclDMIUgvqWmp5027g5lJEyJtNkQkZSuRYeD7auxXIV2ur+4Xps9anHq/TiHY4lk3
 Sz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372551; x=1793977351;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3BOiSu4vlk2F6kRbMbvOSyuAde8P5K4yfc2fmbZWTw4=;
 b=EuEZ7aHb+2PMYXn1DyX0QQWZHvxgsepT14PhOSFgl/0K+y4UbyXkaoBCF9Fy3MrHnb
 n11pgX6Wz2p6g5zfCsiY2KVmv5qwjNcUjzVVeso72lpC5EVWxmV1z93lurZnZw8/O+gj
 T5vJrcQHz+OlsXMxxdA6ob6iG/sX7nNEADq1Sp2OKTbU57c5xrkv0sS1MSsNh+Kfibrf
 IutLQ8cOr7iRh3vMNsqDLQ5JW6OUuf+oeIO/F5KHHZo2H2ncHAzkF31uxq1yylwBDHVc
 8Xgfixbm8zVl8njO4rME2thS8oo8iALKf6wZuNrxrhB30JGpiyL2NWKYe1NE7aRhC0ro
 eRbA==
X-Gm-Message-State: AFq9FYI15y+xbT/pJRYiJUHB6ni9Amg1/Exm2lrHbnvQ7B5+nz7pS5Y5
 e3aFLUx/M/5Pq4xclp/CVvTImDrr/ktlO1P51yJfF4aFqraoA6w9EHOABGNZ2/nujvHwCfNGHyN
 9O0iSoq5rw/3Eh84ZFlEZOzVVsOjzNB2T2Lfooah8gXzH05NTFQvIn2SUzoDWmRmajrpx
X-Gm-Gg: AYBFou2jpFlfcEVsy7L0yJHpvoLOJq72LFrdqaKOCGGYYziByoCJmTGtyqLpsawL/Y4
 +Z49otEhdLeGL2WVDom0BQewvG4tCy3Q3XAh2LovCD4+Xa1DX4q681U0Y4646mV7u1bRcwirnWA
 Urwnbm/Q27jUVriIhyTc1Ca5KAolJOI6K81E4IiTamxaFlUh0nP0H+lRmczhzk2Mhwi81wU/uMF
 utF1wBOA2vWrPUDxwPsnBNgSYkZGZXkC/+/Ncx3ciJJEkJegfwMHvpUs2wIPOICIViI64TBb5ly
 kkpkOephVmHUj+hyUh9Nw0CXTbeuK72dKobv405xRW9hEdtxBbiONpGxdm5cHSeuozRmfWbV2NE
 NksEM3GOhQoiZWVyjbyCOLCYzMBkqaumBjd3J625aghjrxjQdciT8gv3JS3HnAYUMcsDvCE2ShX
 pPn6F5y0kCV4hWnRh1ROO9GbueboVqMw==
X-Received: by 2002:ac5:c984:0:b0:5d4:3376:f42b with SMTP id
 71dfb90a1353d-5ec586bb37dmr1615900e0c.4.1793372550371; 
 Fri, 30 Oct 2026 08:02:30 -0700 (PDT)
X-Received: by 2002:ac5:c984:0:b0:5d4:3376:f42b with SMTP id
 71dfb90a1353d-5ec586bb37dmr1615838e0c.4.1793372549593; 
 Fri, 30 Oct 2026 08:02:29 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d4f9sm3751311f8f.2.2026.10.30.08.02.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:02:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/31] tests/tcg/mips: Group DSP cmp tests
Date: Fri, 30 Oct 2026 16:01:33 +0100
Message-ID: <20261030150202.61556-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4bxzsLKtfH3PecrpxgXuvJ_507Rd-5dR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX4gegOBoeb9oG
 NgHyfuTbn2Czwp08febmY1zoe1JywPikTUWk7is1MAbiPs7XXlV3q/3GmAv1bzZyhAf6jfxUDfG
 5NZ7vEIgxGoFDHFWSpLfjNUUzFtorUkP9aIwBds7HG61nKIZDcSSAPkRdTUrN27QbdSZzBcMHqM
 nb4RTjcJFXknYLZbqN6YE1TT7z94poBO2zaP8ypr2BeBpkIUCnpj4759NcFFcJeJ8m9MwFwbmjS
 hz4/PySTrYRqBtfSl7B7r0yW0jE7m0i7bIEBYwl9+AZY3CNKD/7W5hLYGKvVm3sQhE4olKN2AuO
 4q9eNJaR0MUm2Ex/uDpL/vrm85o27nHz/K+cxnWhEoa0sbq/Rhftozthyv77WVaZWgzp8JGBZte
 9fpOCnfAvJeFDv6Wt7d5Swz5kNdPMGMwelC6aN8MF3qHCp32hpASxdv7u04T2kxaFoKEePHAdfO
 kypruluvCSloPG+KpzA==
X-Proofpoint-ORIG-GUID: 4bxzsLKtfH3PecrpxgXuvJ_507Rd-5dR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX5upWVPG8u/LL
 xdmxzXPYG3GOdZKfEaCS62hNis8eFQR2YbkiLKDVd5AGeRkV+RWpvWpRFOxnRlG29tnVJCLTVDd
 MtbnZAZWwBtfOVRcwW/A2EAD8h+iJ8w=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4b187 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=TrVlaqBlz6Hw94NMQc4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300059
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

Build the 14 per-opcode cmp tests as a single executable,
test_dsp_cmp.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_cmp.c             | 83 +++++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c    |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c    |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c    |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c   |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c   |  1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c   |  1 -
 tests/tcg/mipsel/test_dsp_r1_pick_ph.c      |  1 -
 tests/tcg/mipsel/test_dsp_r1_pick_qb.c      |  1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c |  1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c |  1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c |  1 -
 tests/tcg/mipsel/meson.build                | 15 +---
 16 files changed, 84 insertions(+), 28 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_cmp.c

diff --git a/tests/tcg/mipsel/test_dsp_cmp.c b/tests/tcg/mipsel/test_dsp_cmp.c
new file mode 100644
index 000000000000..aa63737e74ae
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_cmp.c
@@ -0,0 +1,83 @@
+/*
+ * MIPS DSP ASE tests: Compare and Pick instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_cmp_eq_ph
+#include "test_dsp_r1_cmp_eq_ph.c"
+#undef main
+
+#define main test_dsp_r1_cmp_le_ph
+#include "test_dsp_r1_cmp_le_ph.c"
+#undef main
+
+#define main test_dsp_r1_cmp_lt_ph
+#include "test_dsp_r1_cmp_lt_ph.c"
+#undef main
+
+#define main test_dsp_r1_cmpgu_eq_qb
+#include "test_dsp_r1_cmpgu_eq_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpgu_le_qb
+#include "test_dsp_r1_cmpgu_le_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpgu_lt_qb
+#include "test_dsp_r1_cmpgu_lt_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpu_eq_qb
+#include "test_dsp_r1_cmpu_eq_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpu_le_qb
+#include "test_dsp_r1_cmpu_le_qb.c"
+#undef main
+
+#define main test_dsp_r1_cmpu_lt_qb
+#include "test_dsp_r1_cmpu_lt_qb.c"
+#undef main
+
+#define main test_dsp_r1_pick_ph
+#include "test_dsp_r1_pick_ph.c"
+#undef main
+
+#define main test_dsp_r1_pick_qb
+#include "test_dsp_r1_pick_qb.c"
+#undef main
+
+#define main test_dsp_r2_cmpgdu_eq_qb
+#include "test_dsp_r2_cmpgdu_eq_qb.c"
+#undef main
+
+#define main test_dsp_r2_cmpgdu_le_qb
+#include "test_dsp_r2_cmpgdu_le_qb.c"
+#undef main
+
+#define main test_dsp_r2_cmpgdu_lt_qb
+#include "test_dsp_r2_cmpgdu_lt_qb.c"
+#undef main
+
+int main(void)
+{
+    RUN_TEST(test_dsp_r1_cmp_eq_ph);
+    RUN_TEST(test_dsp_r1_cmp_le_ph);
+    RUN_TEST(test_dsp_r1_cmp_lt_ph);
+    RUN_TEST(test_dsp_r1_cmpgu_eq_qb);
+    RUN_TEST(test_dsp_r1_cmpgu_le_qb);
+    RUN_TEST(test_dsp_r1_cmpgu_lt_qb);
+    RUN_TEST(test_dsp_r1_cmpu_eq_qb);
+    RUN_TEST(test_dsp_r1_cmpu_le_qb);
+    RUN_TEST(test_dsp_r1_cmpu_lt_qb);
+    RUN_TEST(test_dsp_r1_pick_ph);
+    RUN_TEST(test_dsp_r1_pick_qb);
+    RUN_TEST(test_dsp_r2_cmpgdu_eq_qb);
+    RUN_TEST(test_dsp_r2_cmpgdu_le_qb);
+    RUN_TEST(test_dsp_r2_cmpgdu_lt_qb);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
index 957bd88ce01f..47406f77c59e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
index 356f156c5d1f..811646d78e84 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
index 3fb4827ad761..430953a77215 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
index 2615c84c75c7..1fd5b523a44e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
index 65d0813c3b19..da1277065246 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
index 7dddad98532c..9317f9a3fa44 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
index 680f2a1999d8..8736e7fc45ad 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
index 43cfa509ca3c..fbc620adf95d 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
index 074ca5b402de..8132b13a97c2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_pick_ph.c b/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
index 929a002e7544..0a11b5d12ce3 100644
--- a/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_pick_qb.c b/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
index a79047524662..8def9559d632 100644
--- a/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
index 2d6340d6fb12..cfc71839591a 100644
--- a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
index a0ecdca2ac2e..9e7d8260cfa7 100644
--- a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
index dba99e392c29..ec964e39074f 100644
--- a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index e7e576ad6c19..e8737308c40d 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -6,17 +6,9 @@ tests += tcg_tests['multiarch-linux-user']['tests']
 tests_dsp = [
   'test_dsp_acc.c',
   'test_dsp_arith.c',
+  'test_dsp_cmp.c',
   'test_dsp_r1_bitrev.c',
   'test_dsp_r1_bposge32.c',
-  'test_dsp_r1_cmp_eq_ph.c',
-  'test_dsp_r1_cmp_le_ph.c',
-  'test_dsp_r1_cmp_lt_ph.c',
-  'test_dsp_r1_cmpgu_eq_qb.c',
-  'test_dsp_r1_cmpgu_le_qb.c',
-  'test_dsp_r1_cmpgu_lt_qb.c',
-  'test_dsp_r1_cmpu_eq_qb.c',
-  'test_dsp_r1_cmpu_le_qb.c',
-  'test_dsp_r1_cmpu_lt_qb.c',
   'test_dsp_r1_dpaq_s_w_ph.c',
   'test_dsp_r1_dpaq_sa_l_w.c',
   'test_dsp_r1_dpau_h_qbl.c',
@@ -45,8 +37,6 @@ tests_dsp = [
   'test_dsp_r1_mult.c',
   'test_dsp_r1_multu.c',
   'test_dsp_r1_packrl_ph.c',
-  'test_dsp_r1_pick_ph.c',
-  'test_dsp_r1_pick_qb.c',
   'test_dsp_r1_preceq_w_phl.c',
   'test_dsp_r1_preceq_w_phr.c',
   'test_dsp_r1_precequ_ph_qbl.c',
@@ -85,9 +75,6 @@ tests_dsp = [
   'test_dsp_r1_wrdsp.c',
   'test_dsp_r2_append.c',
   'test_dsp_r2_balign.c',
-  'test_dsp_r2_cmpgdu_eq_qb.c',
-  'test_dsp_r2_cmpgdu_le_qb.c',
-  'test_dsp_r2_cmpgdu_lt_qb.c',
   'test_dsp_r2_dpa_w_ph.c',
   'test_dsp_r2_dpaqx_s_w_ph.c',
   'test_dsp_r2_dpaqx_sa_w_ph.c',
-- 
2.55.0


