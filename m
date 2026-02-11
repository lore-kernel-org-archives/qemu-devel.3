Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEE6ECD6F7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 22:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqIZG-0005Mk-9l; Wed, 11 Feb 2026 17:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqIZ6-0005LN-Io
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:20:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqIZ2-00051K-9c
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:20:07 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61BIp5ic2546650
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fnuus0A3VAM9HdlEwrG5U3dQzgzrHcUo5c/GhwFD6VI=; b=S/EZlsueSpOz/waY
 z9/z+5ht20op4svbsS5QqouUhGg3BvjZk51Pv+UK57RW6mItGWazPgAjknpcr/ZK
 HJxiNjAFIGEc7VO/HP8fBpB05AqQ4Ds3mXi41lgCdPPnc5/zIySccWmpjp5uOLLK
 iMrlmSv/lpgMs/MJ41ZZGE/jYHqyv/2D2ykYv9b33orgI9cOoGZJjYZwbiIm/RYl
 QknZ+1B+g+/Jb5zZuPcg9wLzr2nJo/2tXnliVlblCnon2Ed7eEVI9Xk5wCfmYFxn
 z4KOOh7TC1cHKRdyZUO1/XWn+irRDwoRw3wrId2V0SkXWErCYjgjDpOsh6CoKlDK
 tSHHuw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8ydn0hv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:20:02 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1247bb4db53so3588600c88.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 14:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770848402; x=1771453202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnuus0A3VAM9HdlEwrG5U3dQzgzrHcUo5c/GhwFD6VI=;
 b=aNwKV2f9ZFt24NL6ANNfbX2xL1q7oU9OPsOTtlvRgqwgaVSL8ASH8COBEiy6mqi6VU
 CU8Kf+wzU3Dtoi3naEJxZp+q2ig0vUXYvPqF8YGs4aD1DkFE/8z0AnfosZ70RjWhkyRr
 FtHm3zJb35p/bIqlb6/OvCEKV9wyJ902GsS6W/ahapD79KQW8Xp0FfHSUM09Ih1u5cnb
 ci96sV8ablDCN2zVEfbbljXTr4KTsGvnBygscKHFyhZkRLPIOoBTh+9MouHoIMJyb/KC
 7cOFwskvPHJmIVT+ePCvoFR9+34gowu4pNPwczAUUnpZPV94eA8XC8FlTvQnS1H4WLSu
 O9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848402; x=1771453202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fnuus0A3VAM9HdlEwrG5U3dQzgzrHcUo5c/GhwFD6VI=;
 b=YaYNKxkr/liD8+5QCit6X9Dn3zMfZBOe36ZlzqeVP0A+4nS9pVQgkGIxcfQPE7EZOJ
 TONUlI7wlbff9+oj5koKa6eDVBhLRzOdieySNCQ+zrxD67VadY+njNX76bnSJHkGLKvk
 Vdjov8SPyW+52nnyv5gx2c9OFVrUlrMLi8ldktjVrvDYxP8awpUza3mmZQGOgPWGAxQf
 Zap5E8UPw9u0oZS0tRWvj8PnU2OxrEjneII3Sy7jfuRgBhaSRJepWEGoEWLYjH/GEGIb
 zJLRmIVtMCNqTx4meTUvMNPMttBqzK37yHgzCzEytXu1aNofBHfnl30hu1btYJdLalZ9
 eXrA==
X-Gm-Message-State: AOJu0YwYGuTQ2dMEMmsic/L3TkKMVi0mKx14v/yCpDhF1xRVif0AOiHh
 974GHn0Zc4+yKE6ng51TKZ1eZV+SyqsoOFLcKZTPKwsZ5fxeKf+mf8mdvHs7iSvKdPmttmN/quv
 MysDVnH4JsNNLvLd/XFTQGWnUlzYvl9Oyv88hRDULr/HR7Gk2hSvSXLQiWFRfn7Bi8g==
X-Gm-Gg: AZuq6aJT7Zkuks6FyPRgEcHE1v42g/FiQmQCsmPeGjAY9hrTMO6fMVNkgvf+Fa6d/qz
 g3qf5sbTjtHHMDOdkt+SG+ff4evgUfCMFL6XoRH53pLHf3AZP964h+F9d4r6pisT3roQ3bkACUq
 B105T34Nui5bKAGmEXl6/6DT5qPfG3HFL6Eb1it1IN1uooXsEJz1WD6rSrvI0kuS+7TLCTJRtAh
 gk/sO+leWOQdqf/CvRAuZKLnfCJ2pzl/1zHmSkdsd/ccw3U9A/4D2rD0uHT8+lUERQMSCx9N576
 p3LSrMtgGnRMn7xhv9Cou0w9GGN5taefoIq19iXoATst/r1WSTaHR9oCJfR6TeZAvP0gvso1/rZ
 N+btY8xwMkH9py0ZTRuscmxCGo9S2t83olLM3xD6hSpX8RkKH6fL3Byk8eG7CyA8ZRTgpag==
X-Received: by 2002:a05:7022:2399:b0:123:361e:e87c with SMTP id
 a92af1059eb24-1273052046dmr114404c88.11.1770848402043; 
 Wed, 11 Feb 2026 14:20:02 -0800 (PST)
X-Received: by 2002:a05:7022:2399:b0:123:361e:e87c with SMTP id
 a92af1059eb24-1273052046dmr114389c88.11.1770848401094; 
 Wed, 11 Feb 2026 14:20:01 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba9dbe123asm2588379eec.13.2026.02.11.14.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:20:00 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 3/4] tests/tcg/hexagon: Handle SIGILL internally in
 invalid-slots test
Date: Wed, 11 Feb 2026 14:19:52 -0800
Message-Id: <20260211221953.4099441-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211221953.4099441-1-brian.cain@oss.qualcomm.com>
References: <20260211221953.4099441-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NLHYOk6g c=1 sm=1 tr=0 ts=698d0092 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=mDV3o1hIAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=F0Jt1ehG-eUF7qKHwFUA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eUdjd3xrhrwBnTAI7vzYC-dAfZtjIMgq
X-Proofpoint-ORIG-GUID: eUdjd3xrhrwBnTAI7vzYC-dAfZtjIMgq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE3MSBTYWx0ZWRfX9ln2Qxw4jXVt
 lmJFQiKlAKyRq9+bRrHDUQSMnTjsrGq5DB2hyRZQhqrfdIWRqFFcpVtzD3s8PUVJ72UycayZfUB
 EwfnXzwhyWOBbpf9ljOBWLM7imh8XjThJag+gy7NdPimgermIOB/iVebDiQ6xwOg2f0yO6PCZrF
 V147SU8YCqV4nm9j9c36pw7JPSBlP9SmUaf/udxx8gUpLdaPGEjV0qF76qSiubmVJZhMu6rtU+e
 kaaKfsm+eBbpG8G5KVRtYwQfGAajuPOtsFfPCrFv6/lGA5MqT8Y+zozoqMrU6PFcPJ8Nxlw6cp5
 s5Dvvn5aHMDwx5p7HoDBylfF6iP9H5PaNpVWTOOcJfzDwywSDA7n7rhufEq41wlumH8tbvGdGha
 xyFoMl+E5Vd/vikgE1rLn3P7FXw8iwGiOotsFImkIV0hr7Z8FSamcgmLvCxfryGnclH1DV0hIyw
 JSKz3og+zNEcoAoOqLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110171
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Rewrite invalid-slots.c to catch and verify SIGILL using a sigaction
handler that modifies the ucontext, matching the pattern used by
invalid-encoding.c.

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 tests/tcg/hexagon/Makefile.target |  6 ---
 tests/tcg/hexagon/invalid-slots.c | 76 ++++++++++++++++++++++++-------
 2 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index 16669e04a8..d64aeba090 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -54,12 +54,6 @@ HEX_TESTS += invalid-slots
 HEX_TESTS += invalid-encoding
 HEX_TESTS += unaligned_pc
 
-run-and-check-exception = $(call run-test,$2,$3 2>$2.stderr; \
-	test $$? -eq 1 && grep -q "exception $(strip $1)" $2.stderr)
-
-run-invalid-slots: invalid-slots
-	$(call run-and-check-exception, 0x15, $@, $(QEMU) $(QEMU_OPTS) $<)
-
 HEX_TESTS += test_abs
 HEX_TESTS += test_bitcnt
 HEX_TESTS += test_bitsplit
diff --git a/tests/tcg/hexagon/invalid-slots.c b/tests/tcg/hexagon/invalid-slots.c
index 366ce4f42f..607027f314 100644
--- a/tests/tcg/hexagon/invalid-slots.c
+++ b/tests/tcg/hexagon/invalid-slots.c
@@ -1,29 +1,71 @@
 /*
- *  Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ * Test that invalid slot assignments are properly rejected.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include <assert.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static void *resume_pc;
+
+static void handle_sigill(int sig, siginfo_t *info, void *puc)
+{
+    ucontext_t *uc = (ucontext_t *)puc;
+
+    if (sig != SIGILL) {
+        _exit(EXIT_FAILURE);
+    }
+
+    uc->uc_mcontext.r0 = SIGILL;
+    uc->uc_mcontext.pc = (unsigned long)resume_pc;
+}
+
 char mem[8] __attribute__((aligned(8)));
 
-int main()
+/*
+ * Invalid packet with 2 instructions at slot 0:
+ * - Word 0: 0xa1804100 = memw(r0) = r1
+ * - Word 1: 0x28032804 = { r3 = #0; r4 = #0 }
+ *
+ * This should raise SIGILL due to the invalid slot assignment.
+ */
+static int test_invalid_slots(void)
 {
+    int sig;
+
     asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
         "r0 = #mem\n"
-        /* Invalid packet (2 instructions at slot 0): */
         ".word 0xa1804100\n" /* { memw(r0) = r1;      */
         ".word 0x28032804\n" /*   r3 = #0; r4 = #0 }  */
-        : : : "r0", "r3", "r4", "memory");
-    return 0;
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "r3", "r4", "memory");
+
+    return sig;
+}
+
+int main()
+{
+    struct sigaction act;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = handle_sigill;
+    act.sa_flags = SA_SIGINFO;
+    assert(sigaction(SIGILL, &act, NULL) == 0);
+
+    assert(test_invalid_slots() == SIGILL);
+
+    puts("PASS");
+    return EXIT_SUCCESS;
 }
-- 
2.34.1


