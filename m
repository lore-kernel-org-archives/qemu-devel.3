Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B0606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lEMyUtz7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kwhnMBvt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUF4-0004G7-R3; Thu, 29 Oct 2026 13:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBX-00077p-FC
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBT-0003ht-KX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD3l41143412
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eKq91z4kfFXeneR7ARfoU0UF3HwRNv6lXGEN8rSC1zI=; b=lEMyUtz7EUx6XYv3
 eNN3nu/FkKZVsQfF/l2jpdBj4VRLIcwjbrazZAV2Xj4SIeZfiufkogMYi4o7Ftup
 n0ibzqpmRIPTS4LFe/EuNgHwPm/Dddv6VNcGvFPr8wF8PYNlnZRkQ0Ac76YLeaEx
 jT6gIXx2a+8fE/KJs1F9qbGDQY49d/SOGpVbVqX9/zvR/zFhMeLKqMVAwAgDHL9t
 gLuI6fa/D3+JDk1n/kh7fp44CgIOw772iKma5/zU2F2K2Z0ZS+dKBWOu/1WjDzoM
 Ka01VBJeyPB7EreT2T1jHrzB1DbnV22qpSYQtmzb0EjwQJoi2HG1JveLPa3SRehi
 4wxW4Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76chs95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:44:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-944138ed63fso202206185a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295898; x=1793900698; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eKq91z4kfFXeneR7ARfoU0UF3HwRNv6lXGEN8rSC1zI=;
 b=kwhnMBvtiEbBMUrz77/o8Bj3qWoiB2RCv93K+8sAVyLQb/caPNInlxz7RnOZSd75d8
 sFsnr6VIPRvILt+UhD9zqcEIpx1pbgP6LtJXkpPSVxLY+Nx4kZl3CgWao+CYkEpNIu+u
 HYaeVv7wELOpA99qzLSCO1kK0/vWZTvSTQSQJLAGDZ0N0/hE1DkA8ZiS258bz/6mznW8
 FBkz1FhXZ/T8bBHi0S4zIzJAlVT1brRCHdGQAijKNcjKrRUk5CVQi8BV26UEku/+1cSP
 C0KFAcxsIeNByLrWSoWZMuMOgkd887bf9797gzSDO5Ft9UttAbesJzZ1ZtFA4yDP7pAz
 Wz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295898; x=1793900698;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eKq91z4kfFXeneR7ARfoU0UF3HwRNv6lXGEN8rSC1zI=;
 b=w5nyAVltA2yNt4p8pVrBr4sMWdcRRK82BRhdfTKsAI48PfgsX1Nxk2nKHdZ1ozT6Lr
 jLRAV2xYPlxtxd4pBUQUkldJZ8WDgtn24QRPWk3+NZpW7XQX5S/LRI/3WpfQFL4IU72r
 XmKKuK8dMmxR7Ecc+3x7/BHgQxW0dEZq7EcZ5kf39bzjpN64e9DmYCVhiT62+NTgP5ph
 Ra5sT+pGbw5uh84EYYPv0RAJ1IZYhZHD0E4JT4IFkOn7rY49aF2h7FihbDfYbhcq9D18
 XdZXmJVNXYYmLCNRSeuRF1vfj73JgbpVSnE6iVpi2nXpZw7uWo7BqEYWZacF8U9LOWM6
 5wuQ==
X-Gm-Message-State: AFq9FYLx4SeYTltLKENITjUo8epk0zFG4ppVoF+wdSDb1YWh8tsFSqtH
 TNAFAa3ZQFLZQtoFP0NvSpHfUnAvDC2tjqq1SXi/a4SA7J3bX5HALSQuP5DjYw5/YOGp62tUb2G
 X91swp2zW2bKiTUuREHmLgtB6DBVCqvDFwHtqqzCoFVlAS24OEUZZuuGhoN4KE+9i2QZC
X-Gm-Gg: AYBFou1l0kbOast2jktXlSDOVHS1R9JY5m80KOKdRX7+JM1IxnI/2wbVeSKYL0QIjLh
 q+LOy+7jrkrGG4jio74slmMRMpSjx5gGCk/98VpoZsRzrickqwrwK/JQnBjqfd7gR0qNlOkFXiG
 fEucbQnkslEZpdQdhcz8qOfiHuqpP/Aq3Pli4asmpopvv/S7RuuCmzeYN3sixtQdMfm6ZaiDq+i
 vTinoR2qNsgX+ooDcltUYNdbmj1QFjm+Bp7LBXUGcHi9BHlJmi+kD2LKc3lAd5u+izUi+6qgped
 XAeKEHSTCSVIU/pam52hNoJ7dUUoDQ0fEPR1NUkQ1m5y1hREoViHZlv14K82qUZVACUxt2jwlcu
 rxM12mbjATyPSJlfGMInE8hULMYnrHwomxmCHfY6gd4sJx2j++trg64sOEG8WKZhJTcuO5NHg4S
 EfwNcetczEU1qql1zxesCXJ+bkUMuYAA==
X-Received: by 2002:a05:620a:4001:b0:93f:3f86:c4e9 with SMTP id
 af79cd13be357-94408d58fffmr989851485a.79.1793295898094; 
 Thu, 29 Oct 2026 10:44:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4001:b0:93f:3f86:c4e9 with SMTP id
 af79cd13be357-94408d58fffmr989848185a.79.1793295897586; 
 Thu, 29 Oct 2026 10:44:57 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81b7fe80sm90448365e9.11.2026.10.29.10.44.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:44:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 03/12] tests/tcg/mipsel: Add MIPS32R6 logic tests
Date: Thu, 29 Oct 2026 18:44:24 +0100
Message-ID: <20261029174434.27985-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xN7ntgTWBV-h_iV2JsXZUNoMujhvrXBR
X-Proofpoint-ORIG-GUID: xN7ntgTWBV-h_iV2JsXZUNoMujhvrXBR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXzOg5IL0XFsxH
 bBk4ncxT8krJ7cDdlrcrXdWFYBGHgt71EWzpZaIU5iSCrc2IUOCBVr2cYb52HVrk+ZQLi/3nV0A
 cGyN0QUFQXLspHYFW1W6zMjK1PWUCMg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX3RxZbjgeJfAn
 0Q6cIwegJVjICV0MUxkgW14nou0s/Uc5RKJGUCKuLdus48RVFAnp97u6kjVchWxT5w/mwKhV0eJ
 pCEFdKe0v8eGPKUPculwtx/GhYma9NcTLYG6OHdIrDUI2GPkTf9vwBmn7RZIsAfF9hsbwTIoAwe
 OKYOQfytWQih1OeKH24Cgv8T2Sjljg/38yFOEOdHc+tisuVngQbokkkm6KNWWqSi9QEhPjzKff2
 6mPao+gS76m+5BSYqmJWUCdiydimvWZv6KF6z2WyrX8aBagAqg03tHe4kODEUyxiSk4S0lXrwRI
 moAlquorYWv8zd2KLpR6xkUT9cvdee3gZvmCoDILSZg/GBQZ0tCCd7Lrh2+uiuPlDs3H4eXMsOm
 wTk02DmBTBVMHkA+ejarPUENpYXD9g==
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae3861a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6_gWjx6qscrDNB68990A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290069
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

Add a mips32r6el-linux-user target running, on mips32r6-generic,
32-bit versions of the Release 6 tests that don't need 64-bit
registers, starting with and, nor, or and xor. Output is TAP.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/include/wrappers_mips32r6.h | 61 +++++++++++++++++++++
 tests/tcg/mipsel/test_mips32r6_logic.c     | 63 ++++++++++++++++++++++
 tests/tcg/mipsel/meson.build               | 29 ++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 tests/tcg/mips/include/wrappers_mips32r6.h
 create mode 100644 tests/tcg/mipsel/test_mips32r6_logic.c

diff --git a/tests/tcg/mips/include/wrappers_mips32r6.h b/tests/tcg/mips/include/wrappers_mips32r6.h
new file mode 100644
index 000000000000..316aa69ef582
--- /dev/null
+++ b/tests/tcg/mips/include/wrappers_mips32r6.h
@@ -0,0 +1,61 @@
+/*
+ * Wrappers for MIPS32R6 instructions operating on 32-bit values
+ * (32-bit counterpart of wrappers_mips64r6.h).
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef WRAPPERS_MIPS32R6_H
+#define WRAPPERS_MIPS32R6_H
+
+#include <stdint.h>
+
+#define DO_MIPS32R6__RD__RS(suffix, mnemonic)                          \
+static inline void do_mips32r6_##suffix(const uint32_t *input,         \
+                                        uint32_t *output)              \
+{                                                                      \
+   __asm__ volatile (                                                  \
+      "lw $t1, 0(%0)\n\t"                                              \
+      #mnemonic " $t0, $t1\n\t"                                        \
+      "sw $t0, 0(%1)\n\t"                                              \
+      :                                                                \
+      : "r" (input), "r" (output)                                      \
+      : "t0", "t1", "memory"                                           \
+   );                                                                  \
+}
+
+#define DO_MIPS32R6__RD__RS_RT(suffix, mnemonic)                       \
+static inline void do_mips32r6_##suffix(const uint32_t *input1,        \
+                                        const uint32_t *input2,        \
+                                        uint32_t *output)              \
+{                                                                      \
+   __asm__ volatile (                                                  \
+      "lw $t1, 0(%0)\n\t"                                              \
+      "lw $t2, 0(%1)\n\t"                                              \
+      #mnemonic " $t0, $t1, $t2\n\t"                                   \
+      "sw $t0, 0(%2)\n\t"                                              \
+      :                                                                \
+      : "r" (input1), "r" (input2), "r" (output)                       \
+      : "t0", "t1", "t2", "memory"                                     \
+   );                                                                  \
+}
+
+DO_MIPS32R6__RD__RS(CLO, clo)
+DO_MIPS32R6__RD__RS(CLZ, clz)
+DO_MIPS32R6__RD__RS(BITSWAP, bitswap)
+
+DO_MIPS32R6__RD__RS_RT(SLLV, sllv)
+DO_MIPS32R6__RD__RS_RT(SRLV, srlv)
+DO_MIPS32R6__RD__RS_RT(SRAV, srav)
+
+DO_MIPS32R6__RD__RS_RT(MUL, mul)
+DO_MIPS32R6__RD__RS_RT(MUH, muh)
+DO_MIPS32R6__RD__RS_RT(MULU, mulu)
+DO_MIPS32R6__RD__RS_RT(MUHU, muhu)
+
+DO_MIPS32R6__RD__RS_RT(AND, and)
+DO_MIPS32R6__RD__RS_RT(NOR, nor)
+DO_MIPS32R6__RD__RS_RT(OR, or)
+DO_MIPS32R6__RD__RS_RT(XOR, xor)
+
+#endif
diff --git a/tests/tcg/mipsel/test_mips32r6_logic.c b/tests/tcg/mipsel/test_mips32r6_logic.c
new file mode 100644
index 000000000000..48db7a8bfb15
--- /dev/null
+++ b/tests/tcg/mipsel/test_mips32r6_logic.c
@@ -0,0 +1,63 @@
+/*
+ * MIPS32R6 tests: logical instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+
+#include "../mips/include/wrappers_mips32r6.h"
+#include "../mips/include/test_inputs_32.h"
+
+typedef void (*binary_op_32)(const uint32_t *, const uint32_t *, uint32_t *);
+typedef uint32_t (*ref_op_32)(uint32_t, uint32_t);
+
+static uint32_t ref_and(uint32_t a, uint32_t b) { return a & b; }
+static uint32_t ref_nor(uint32_t a, uint32_t b) { return ~(a | b); }
+static uint32_t ref_or(uint32_t a, uint32_t b) { return a | b; }
+static uint32_t ref_xor(uint32_t a, uint32_t b) { return a ^ b; }
+
+static int check_op(const char *name, binary_op_32 op, ref_op_32 ref,
+                    const uint32_t *input, size_t count)
+{
+    int fail = 0;
+
+    for (size_t i = 0; i < count; i++) {
+        for (size_t j = 0; j < count; j++) {
+            uint32_t a = input[i], b = input[j], res = 0;
+
+            op(&a, &b, &res);
+            if (res != ref(a, b)) {
+                printf("# %s: %08x, %08x: got %08x expected %08x\n",
+                       name, a, b, res, ref(a, b));
+                fail = 1;
+            }
+        }
+    }
+    return fail;
+}
+
+static int run(const char *name, binary_op_32 op, ref_op_32 ref)
+{
+    static int count;
+    int ret = 0;
+
+    ret |= check_op(name, op, ref, b32_pattern, PATTERN_INPUTS_32_SHORT_COUNT);
+    ret |= check_op(name, op, ref, b32_random, RANDOM_INPUTS_32_SHORT_COUNT);
+    printf("%s %d - MIPS32R6 logic %s\n", ret ? "not ok" : "ok", ++count, name);
+    return ret;
+}
+
+int main(void)
+{
+    int ret = 0;
+
+    printf("TAP version 14\n1..4\n");
+    ret |= run("AND", do_mips32r6_AND, ref_and);
+    ret |= run("NOR", do_mips32r6_NOR, ref_nor);
+    ret |= run("OR", do_mips32r6_OR, ref_or);
+    ret |= run("XOR", do_mips32r6_XOR, ref_xor);
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index f2642e1b20f8..5553ae33aec0 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -84,3 +84,32 @@ if 'qemu-mipsel' in emulators
     }
   }
 endif
+
+tests = []
+
+tests_mips32r6 = [
+  'test_mips32r6_logic.c',
+]
+
+foreach src: tests_mips32r6
+  tests += {
+    src: {
+      'cflags': ['-mabi=32', '-march=mips32r6'],
+      'qemu_args': ['-cpu', 'mips32r6-generic'],
+      'protocol': 'tap',
+    }
+  }
+endforeach
+
+if 'qemu-mipsel' in emulators
+  tcg_tests += {
+    'mips32r6el-linux-user': {
+      'cc': 'mips32r6el-buildroot-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'folder': 'mipsel',
+      'gdb_arch': 'mipsel',
+      'qemu': emulators['qemu-mipsel'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.55.0


