Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C80C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 23:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whyGY-0004u0-1A; Thu, 09 Jul 2026 19:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whyGW-0004tk-C0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:34:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whyGU-0007S1-E8
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:34:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669JUkI32556963
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 23:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LpPkHYYRK3o0T7n1tWuJuAjG+4EP4gTciyO+ayCWuOs=; b=nrwotLu5NYOsuYJ2
 tBeknpT5RAoisZlgyywLall4bXWgJQsPa+VFg/v+CZAZkcXe8M30SCCMKYdeJyhR
 YVVqwojlPt/BaV3e18368E2g39hlrSag+4DA0+P9Yj2dG2S4veGd4Dxpxlat/c2j
 LzTBN3YB9haPF4d8h7Rb7pnyS9csirNdOK5KKlDoNe13R5FeCnPQYNuu3bt2bz8l
 MevlEngEbtPL5XYFpG/Iv4DWH0CVsCN6z6KW4jOip5UvzY+I0nSUkQb1OCGcAgNh
 Ry1nRu1pWuhHDdh8ps95/9Dm9jWyI0iJ8N5A4ZF0mVDaGHjGQBsGa3Khw13q/Reh
 eFgVDA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8grfs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:34:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so5596175ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783640084; x=1784244884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LpPkHYYRK3o0T7n1tWuJuAjG+4EP4gTciyO+ayCWuOs=;
 b=K4RlvYc1lilW6KwugL/wa3TLhZyhfdcQ49mLd6LSG+aI4dtnSP8nS6+nMNTPCIUVlq
 c8M2bqDoLEvrhpRwZbKRMSK3j8SwfZonvuKbw5bsuBEdDoUZD8gaBYoSUyRfo3XkaPLQ
 HGB+nLuS6hENnTkwS7UNuVJNwzxHkZqltrvUFEgv3sTyBE0k2oLwyRadEqVxhe3mW/+l
 9sJidLkzfAC02ExRu9bLUr+VAIYqrOWrGpeg9wR8HRm2JdvowkgL1Em7Zd67rALsXyvK
 dygyjMmhumGvvaZuAVpoVhyMA6SC7N5rtCGUAKE23sdG3/bvBnyUMcNRtXL79oSwN3dN
 Zh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783640084; x=1784244884;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LpPkHYYRK3o0T7n1tWuJuAjG+4EP4gTciyO+ayCWuOs=;
 b=BIaAPjmzVsKX9MG08MmVq6gxvKvu6u0oo+fCrACYCWlgLwp0J8nXXIjzf1sxs/ccLn
 RWcAXq4swgQWrSuUKoEwoFsfxQqo9nl2IzKPeK0+/ure0Vt1oALGcxG/rlW3cWipP5uJ
 ATm8L9mS5Oc8VwisGOEYhUjekA29HBD+RwaVbsMkT9r1zPqyyEhXRsfmjBLud0oc3qFp
 dr0sqWsS0A0HBWhtndjythOoCY+T2tgqsRgg8eM7tc2vYKHvYkGc2xhrPRZzrRAgQYwL
 ARKxBdyk4+XN9qEb1U5FjSWm6QHo/S7Nv+fgVvLHWJEcf95E6GN7Bt5X7MQatsXh8qUU
 l7Kg==
X-Gm-Message-State: AOJu0YxEuWlKWRCc0uhep3coLchJVLBg5mK0sKlMseVIbxGPK/ARQF59
 u/5Y77QTaqAxgYbWOjeM+4gAmeGQ0BlhA8K1apo1lZf1qjt8wcJYX7K6Bnu2adk5EPgnAwoToxp
 jMpH/7IoBp0CKVnLkXIHrYy8FTpXuBNcY+ZIENcKzo/rPt4Db8wmLTTX3CS9fZfTjUA==
X-Gm-Gg: AfdE7cmpgPeDnXao57g6qtVSlek2a34spJlLVCJdwYci2NB4ouEM/4bwOcA35RVbfr3
 8F/EpRTA5gB6Y9mIqVjMe6KqJjfUw5bLPyskZoMW1y/jkrYl87ZMYKqB4XrBxoNpZdtwkbE0M65
 lcOkHCPBcb4BWwbArDY9bAWrK6tD12gsqGZ0Nxg2KywdaLcc+55bo3npX2gVGusfBAbdy0qOz0K
 dqGryDhBiIFcCUDKK8QjSpq1zFuGQ5qZGuD27d5AkjZhpwqbBO7dPD5MGkI3ys8mDvyEaudynJV
 fLCnf90LQqhSrmWhClEHgXn7tbIQIbkPEK5IqVMUZfCHvp+gIw0r38BpVklo/rhqyEGqrHoQ3Sv
 0cBYhDRphHTfAI1SVl7+nbS23e+EkNEbKli8Otx7cW4Pvd3spx9lAXjIc2Bs=
X-Received: by 2002:a05:6a21:1493:b0:3c0:9c19:65bd with SMTP id
 adf61e73a8af0-3c0bccf6a47mr11318368637.69.1783640084062; 
 Thu, 09 Jul 2026 16:34:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:1493:b0:3c0:9c19:65bd with SMTP id
 adf61e73a8af0-3c0bccf6a47mr11318341637.69.1783640083628; 
 Thu, 09 Jul 2026 16:34:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm25447189eec.20.2026.07.09.16.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 16:34:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, matheus.bernardino@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>
Subject: [PATCH 4/4] tests/tcg/hexagon: add unaligned scalar test
Date: Thu,  9 Jul 2026 16:34:36 -0700
Message-Id: <20260709233436.3075100-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
References: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -2opnf5_TgkUCY-ftmKDtqltcLWguKS8
X-Proofpoint-ORIG-GUID: -2opnf5_TgkUCY-ftmKDtqltcLWguKS8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIzNSBTYWx0ZWRfX6Gbuye2+9jqh
 FZ8qP0TgiDwRFhH2y1EuPurGjP36opGhFu8tduhTwamlpShXaDOXgFBsLuzqaEGA1saOglcbJpU
 9e0aFeZXojSvC8otURIx+jfJftptiYA=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a503014 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=JA4W_Hs6HDHytmC4mdIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIzNSBTYWx0ZWRfX+B4seWsXzerY
 mfHK8oZR491oM1S9imG1BSoMgY/kUmRoyUC2rj+w3n+3PcjNgimuyuJrogbL+yLilgTSuQLJczt
 Rm8D2YeFl/2jwIFXmAISe44zVbbU/8lH6qsVS4hlbmQVh7lOVqeIC680b2/1pXRGywDU8Od0Gxx
 SD1yh/T6gK1qkYMf4JhDNVYjNXnf9056aOwkuKAhGTugwxJc/VEfSFKKn75xHO53iK+m1h3avgq
 M3uYwuEt1dUFgq6dtd/TBFdCEBG76j72CcwHaOsofjf8rTyyhiz5C+3y88qn2Jl2qieaooNYxTt
 o2UNR2tcV2Qx+I5l+wlI801Fw0o7fsmz9FMEmgPlVMMk+3RwMjpWUZoMCnCCilDXn/XMDzeXXY4
 iXkt7gMdKLxM9QbPM4EfOLemFe5RkxPTCyAt/WUIYCxFNW/OriSk6Y/ciJNMlOspLgbGVVHW5Yk
 Pju+rL2XQRMkksUXEUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090235
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add unaligned_data.c to exercise unaligned memh/memw/memd accesses and
verify SIGBUS is raised and caught.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 tests/tcg/hexagon/Makefile.target  |   2 +
 tests/tcg/hexagon/unaligned_data.c | 118 +++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 tests/tcg/hexagon/unaligned_data.c

diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index 70a8ec2e7fb..a2a0ffc69b2 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -54,6 +54,7 @@ HEX_TESTS += invalid-slots
 HEX_TESTS += invalid-encoding
 HEX_TESTS += multiple-writes
 HEX_TESTS += unaligned_pc
+HEX_TESTS += unaligned_data
 
 HEX_TESTS += test_abs
 HEX_TESTS += test_bitcnt
@@ -108,6 +109,7 @@ preg_alias: preg_alias.c hex_test.h
 read_write_overlap: read_write_overlap.c hex_test.h
 reg_mut: reg_mut.c hex_test.h
 test_pnew_jump_loads: test_pnew_jump_loads.c hex_test.h
+unaligned_data: unaligned_data.c hex_test.h
 unaligned_pc: unaligned_pc.c
 
 # Compile for v66 so that the ELF selects a v66 CPU; the test then
diff --git a/tests/tcg/hexagon/unaligned_data.c b/tests/tcg/hexagon/unaligned_data.c
new file mode 100644
index 00000000000..e0375faafbe
--- /dev/null
+++ b/tests/tcg/hexagon/unaligned_data.c
@@ -0,0 +1,118 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * Test that unaligned scalar loads raise SIGBUS.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <setjmp.h>
+#include <signal.h>
+
+int err;
+
+#include "hex_test.h"
+
+static bool sigbus_caught;
+static sigjmp_buf jmp_env;
+static uint64_t buf[2] = { 0, 0 };
+
+static void sigbus_handler(int sig, siginfo_t *info, void *puc)
+{
+    check32(sig, SIGBUS);
+    sigbus_caught = true;
+    siglongjmp(jmp_env, 1);
+}
+
+static void test_unaligned_load(int size, int offset)
+{
+    char *p = (char *)buf + offset;
+    uint32_t dummy32;
+    uint64_t dummy64;
+
+    sigbus_caught = false;
+    if (sigsetjmp(jmp_env, 1) == 0) {
+        switch (size) {
+        case 2:
+            asm volatile("%[dst] = memh(%[src])\n\t"
+                          : [dst] "=r"(dummy32) : [src] "r"(p) : "memory");
+            break;
+        case 4:
+            asm volatile("%[dst] = memw(%[src])\n\t"
+                          : [dst] "=r"(dummy32) : [src] "r"(p) : "memory");
+            break;
+        case 8:
+            asm volatile("%[dst] = memd(%[src])\n\t"
+                          : [dst] "=r"(dummy64) : [src] "r"(p) : "memory");
+            break;
+        default:
+            abort();
+        }
+    }
+    check32(sigbus_caught, true);
+}
+
+static void test_unaligned_store(int size, int offset)
+{
+    char *p = (char *)buf + offset;
+    uint32_t val32 = 0x11223344;
+    uint64_t val64 = 0x1122334455667788ULL;
+
+    sigbus_caught = false;
+    if (sigsetjmp(jmp_env, 1) == 0) {
+        switch (size) {
+        case 2:
+            asm volatile("memh(%[addr]) = %[val]\n\t"
+                          : : [addr] "r"(p), [val] "r"(val32) : "memory");
+            break;
+        case 4:
+            asm volatile("memw(%[addr]) = %[val]\n\t"
+                          : : [addr] "r"(p), [val] "r"(val32) : "memory");
+            break;
+        case 8:
+            asm volatile("memd(%[addr]) = %[val]\n\t"
+                          : : [addr] "r"(p), [val] "r"(val64) : "memory");
+            break;
+        default:
+            abort();
+        }
+    }
+    check32(sigbus_caught, true);
+}
+
+int main()
+{
+    struct sigaction act;
+
+    act.sa_sigaction = sigbus_handler;
+    sigemptyset(&act.sa_mask);
+    act.sa_flags = SA_SIGINFO;
+    chk_error(sigaction(SIGBUS, &act, NULL));
+
+    test_unaligned_load(2, 1);
+    test_unaligned_load(4, 1);
+    test_unaligned_load(4, 2);
+    test_unaligned_load(4, 3);
+    test_unaligned_load(8, 1);
+    test_unaligned_load(8, 4);
+
+    test_unaligned_store(2, 1);
+    test_unaligned_store(4, 1);
+    test_unaligned_store(4, 2);
+    test_unaligned_store(4, 3);
+    test_unaligned_store(8, 1);
+    test_unaligned_store(8, 4);
+
+    act.sa_handler = SIG_DFL;
+    sigemptyset(&act.sa_mask);
+    act.sa_flags = 0;
+    chk_error(sigaction(SIGBUS, &act, NULL));
+
+    puts(err ? "FAIL" : "PASS");
+    return err ? EXIT_FAILURE : EXIT_SUCCESS;
+}
-- 
2.34.1


