Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4EDC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 01:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjRf3-0000XT-QL; Mon, 13 Jul 2026 21:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjRey-0000Rq-Ny
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:10:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjRew-0003kb-Po
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:10:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DNn0uw2871823
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LpPkHYYRK3o0T7n1tWuJuAjG+4EP4gTciyO+ayCWuOs=; b=gGJdKYnEsNvAG0k3
 NjudW3Vquv8n4RahKRKA8dQwwS+VCs/pCocwPavBHTI4/aU0Ldfek8MEZy5YIpop
 QRlOza/IQplyjXIZL0FHqFgLXjI31VgmuYdjYleG4fjajENn/gGZzMBIIdVWnD3y
 ZNq1mAXzj/5MVQTV1hZd9Nh+rHJk5792kWgsAQCFomB7LwlhRrXc7AA/JSzXyrEw
 qvZP4hfkgsLxh75GPVCqCJm+3lLRXokQwZmIo4V4VLHnlZ8v0y7cjCqtEqW9IDQ4
 4zVoU2CLJXS1r1Ugf3Z3U5tiWGSpR4hZUaGNSKhvxD1WS6Gkf4hDNYjupROl6ATJ
 kXAbCQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44p1bmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:10:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so5518479a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783991405; x=1784596205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LpPkHYYRK3o0T7n1tWuJuAjG+4EP4gTciyO+ayCWuOs=;
 b=Y5XZUubcmrxheVixRQZ11j+igOLnlIwQ0iI6aHc/RU4io61qiJb9AwGvfIcT0TogV4
 av5d37UKtw/RKuQX5dGf/SL8lC/sM+8cQV1dzPA/q9rUv03b28mHLFQwN8emO70GII8B
 dJohP2AtHgNzC1v1XoDZjYE7PxlGHjpjU6lzpTx1hUqKkLJUtenQXpnmIgfgEJObQHcs
 tCbKOxvBjj5HZq7jW0U5T8ORnd9cFemIRJOqu/zYJZFcFqT9GTbVMZLOylIodSe1Khc1
 /vxvzgAFpW1hHevorYfUrZNp+BIl00ltfFG9ViUq9gzbMUxLdYGACyyl3mwDM1w6n2oH
 qkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783991405; x=1784596205;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LpPkHYYRK3o0T7n1tWuJuAjG+4EP4gTciyO+ayCWuOs=;
 b=sudxs8Ie++7G514jum80/sTAOpixT7DWzGLCdFlAClfpLlT6N4mUnnHuoZ9BmuLISZ
 guACBFqbaJZnWLKiiL0FZy4rbYdKDxcJT1FVUB8sFybKLtUA0kyLLw4S/opERK+JyEU1
 pU0fcqDgMbkkHPsBgj+05v52htt/RzOVg8ylpTL27frtCVKd6VMhBhW3JDUstKDhlxFf
 vK7a5E2zfFWEBbaIP5k2Mz9Evn1u3GDE61gp7FT/t1GnDhxAbHVQ0LsmziAjufY8fa25
 oRVSQreW5WwfuWgRx2Pe58AplhZh/zdU3ZX8LGIQRT9PD+xNsE+Q29p21PU27ftk3vK9
 PnJA==
X-Gm-Message-State: AOJu0YyLl9GtyHL6SNXWEeLbIUdA3m/UAlkpVCed6FikaIECb2VDZOKF
 dRX2Wmwd2JIiNyyL/qs/Qqvzd1WuwwsCMQ/UwJnVRtdmPzmNFnLjfFzUY0yueVi0V5RI0BdXJC8
 RjtqyBskcRCYHdDDhpXniRri7eYK52iRXP3Cpa5PcBvFw8zvvkZppqfeep4LG91UUuA==
X-Gm-Gg: AfdE7clHtPBBltoN4B2dhhw9iiMGit5dFIrcxCn98+9II0sjGobSXfOgCRssujeHRke
 6xfgqrNj3nM8OCnmaKJRmLT0x1lsORanQrJ6M7G+Ob9ALsNTn9nFzfMEGzN/JEUXklhau1df7pG
 WTu8ZfUSyu0fKDziR1gTfGFnDX7P4ortP4yEeco1fMkGvXGlTAxJyhAW9RJmrqrNwbCIy1X1Xgn
 QxvVGtKiYeMhAWQrkIkbBZvbZWrXLPp3L2Tkw/9C2XsW0AiMzJi+zaJ5OvaqAlIPED5aBUJIBSf
 Q/Fa5YqAnfM5tlrDFj7WycqxRtmlpbayoX4mxJj5PXeYMbcNs4tFbaob7mHqpbStML3Nx7hbc//
 kybHGk8wNmz0YYw0+3s+K5Ds17cMrBZekrVEFIdGMvdWTVAb7ywV+1gs+nQc=
X-Received: by 2002:a05:6a20:6f03:b0:3ba:e5e2:73bf with SMTP id
 adf61e73a8af0-3c3571d0776mr98053637.43.1783991404268; 
 Mon, 13 Jul 2026 18:10:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f03:b0:3ba:e5e2:73bf with SMTP id
 adf61e73a8af0-3c3571d0776mr98002637.43.1783991403792; 
 Mon, 13 Jul 2026 18:10:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accb0esm76826246eec.30.2026.07.13.18.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 18:10:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, Alessandro Di Federico <ale@rev.ng>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>, philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 5/5] tests/tcg/hexagon: add unaligned scalar test
Date: Mon, 13 Jul 2026 18:09:55 -0700
Message-Id: <20260714010955.2226493-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714010955.2226493-1-brian.cain@oss.qualcomm.com>
References: <20260714010955.2226493-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwOSBTYWx0ZWRfX8Ecb8/REda0A
 Qbech54CR/hK6qJlJsFX79Ew0qt4wP1JzAJLNAOrRFT85H7SU+83QKjZfnuLeB869eyrQoPM5Sx
 sPZTWxhKXJbMwyIHItkztY9cMKobJ+o=
X-Proofpoint-GUID: A6dD-Tkm8C-53pgoWG_pUAuPUP44ZvJZ
X-Proofpoint-ORIG-GUID: A6dD-Tkm8C-53pgoWG_pUAuPUP44ZvJZ
X-Authority-Analysis: v=2.4 cv=BZroFLt2 c=1 sm=1 tr=0 ts=6a558c6d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=JA4W_Hs6HDHytmC4mdIA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwOSBTYWx0ZWRfX3bq7bMEXcAG7
 Bl8nXFr5EyAGmEzAuGupt5V4XXlodQSvl7aEAWpE5aGPTSFdFb/swMWL29QNTDnjzSttjizaaUL
 +d9EYysNYua54lAf/27K8FWhZVd8OlRxUNuDozpyEliQCFr71TSNVkqzDa2QbJNM/TQcelOLj13
 gImvZO8WITxcBCsvcoCo7ogRLhCWZ4VwZaTslPjnD1RPk2x2Jh6TG3u8RDu781qouCZZt56fbIW
 VOJMlNaMlLqo2jy102Twwvnvx7XspKP9rY5+FOvnMwEizUhyf01CWW1t8XLEDq59WJsXU6mWCoZ
 dKZ9b/ecmWPoI+6IePp2uTBzeSlXNWSvmFck3Nio+mx26H/7deWRGt0YpK6ZflTpQzZGExWbYVR
 eVJUdd0+MiRwflNSdQcwX/f926kc6lItoPH9urEfPlxN9zbxpOcxluT4G9KTHIab8y3zk2T9AaL
 hMdTpdB9DTqdsKQLTRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140009
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


