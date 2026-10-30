Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C649606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IdIn0OBw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZVJWt0n7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrIy-0004dB-QR; Fri, 30 Oct 2026 14:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrIx-0004d0-To
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrIw-0002NT-3f
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:19 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu1Pg4025480
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8T+PXjA1MazucRVsOm0Wf+5tkdK1+xYvTzAlABrrqhc=; b=IdIn0OBwF2RIJCgK
 LnsruewR1KhLE2u+8L8OWasJkIHISww+LSo9OUN2inXjxwWMH0PvYhscovVQ0Fd/
 6euvMY4TOrYxKU2T0i4qffCM9L+uRLhfU6xlLEfRtukvq6LUGMGooBAFzMxRrLxA
 7uFX9OlpVaA0BoD4QPIe+qtWTnBdRVwzQgvLiIxmqidsYyJ+obngn58xeISpT1D1
 U5i7QYKxFDWtClKfWj6oTxV5o/kSe7bP0tbzq44zbWSq6+5Ia3DMzdGpuflj3Yn4
 XHYyqmUK7ZBtNZ4+MfpB6xeVAGygvHLPeat9awjUWjaO8+hiRcfJvp3YL4RSL1cZ
 QtPLOw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmd9e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:17 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf08dc2fc8so203037137.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384776; x=1793989576; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8T+PXjA1MazucRVsOm0Wf+5tkdK1+xYvTzAlABrrqhc=;
 b=ZVJWt0n7Ot6QNTljjWCAfFuY5TwymWJJu+qlsTyXLhxminG2PS1/VEWkhmJFB6Q637
 TLNgH5QihitT0pJvJhxqxXGeDFZ4hZs2i6ICLCTJVTz4NrwHv7sOwnqEBTilApzbVF/r
 Y3Ru7Ji0rr763Xv3kWG17WRqyZVSEQKeOYvkXLOhSV13dgqc+NyCNOUnuAq1wL6SWLfg
 ymsFzG8TT7bMeMfSVacDS8EO9Os3eO7gKlRf/TFZ5o4Xp6y0S6w+gEn+g3LOiyHt0NNa
 YChAAQgR829CDj+1ezaIrO7fo1dys/4AqDNmboyaKos8/Qr6M5bCc07+9ow8F3D8Wbul
 ahSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384776; x=1793989576;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8T+PXjA1MazucRVsOm0Wf+5tkdK1+xYvTzAlABrrqhc=;
 b=FG81kLQ+OrKTl4Iu1tn96edZaDbZDC49CGYlV4jJQx1MPzTcKg9fPaYxhgYpw16XDC
 CUekw5Qh0QmfMX6Ei4BzetcvHSP8u5DJlCKcIC+r4SKL9InzCKwy5Np/e4IAR90GjM9E
 Gamgv5tegI3pOFXWL44a3wAnw+2o+lQN/8+qbEaJ6I8rtFmyKRIT1NQ2i/jjT/8NZQj5
 HYiFUtKCNteRXMNzdkxanSd5lcX1rodmwlG5H++jxo60zxEpvE92++Qk+8cXhWUx3qdt
 gImAe6b/3VQWqufhLSHzyL+X2AkGiN0dGkJYYFhaDpoVwjNEUtqzqAa8TrrPlCFUAgki
 YvEw==
X-Gm-Message-State: AFq9FYLZh7D9YUI5odUAQZ4M0Gb+1/n0abmQh4JlBx59XDboJA175wNK
 F6bfCMw+n7e52lWi22xeUf8gEE1m7uzJ54eBEOcaITKJn7GH0ee8TgiRQ110v8XeZpHyVXR/aEm
 V+89b6kqnaehHFGOAcM2CSD0HT1omv9D/tKQQzqlBWy5rFhxfZ7E89/MID/oXglrRC/Uk
X-Gm-Gg: AYBFou2eJUwDuJCipGkEuqzADgz/J4RB5eTyoYnHoACpTmu1MGsOREIjz/tnZQxErZq
 dWV6YR/zP34cUD8I63kDO3+e6l8X240SQp1ifTe20jGBW4ZXXR4jFVXnje3rHL8wnLin9LMiL7a
 5IgxFbxj7yGa8ecLojOE1l0icqvYmWACDV0EBqWrHbOJCASQQmOctYkuYrGImb1eQR+fJY+sMZg
 NLHmXnLjdD0f6c/KOiA09m4Y9xAqRkN7Yi71YvAOy14c0yW2T4/asylfYifO5cxAWG+LF/VObOY
 E8NUyMDfezVOnBKAYAMoHFsJQs0m1IYh35nkBCjT5/987dLPM+s5IO8Vi2BInuFMB0/sHTtOfmo
 V0ZsEig73wZCRb4smbPrwDxbxR6yalbBTAu8dy4pAiXLKnG+f2yG+wRHFeHyL1DqXbDs5m6VAke
 pgVCDdJ8rH5g+1J3M+siifP0ARj9fdoQ==
X-Received: by 2002:a05:6102:c01:b0:7cc:776:6c41 with SMTP id
 ada2fe7eead31-7d072c9f864mr1334122137.22.1793384776498; 
 Fri, 30 Oct 2026 11:26:16 -0700 (PDT)
X-Received: by 2002:a05:6102:c01:b0:7cc:776:6c41 with SMTP id
 ada2fe7eead31-7d072c9f864mr1334110137.22.1793384776020; 
 Fri, 30 Oct 2026 11:26:16 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm4801816f8f.30.2026.10.30.11.26.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:26:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 03/12] tests/tcg/mipsel: Add MIPS32R6 logic tests
Date: Fri, 30 Oct 2026 19:25:36 +0100
Message-ID: <20261030182546.2508-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZIlL3nCb52InbQu_0sZH0RBsioOQviip
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX+Fz+EMVhNbdd
 HAu26Mbrn+4e6UTT+bDUiMjm+yMSvVZJcvhC1YAaHUojTgEKBb4tgkYZpLh6gJf1EU4pMbKTbJH
 qaDsskyO4emNiCZqb4VhVR/KNC6X4B0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX87wluSDiA4/V
 FfzVjj0XLv3WHsiIgoaFP7OnsSJNvnmqVpgVJYpnw++Vs7D3GchKZVq82wCBMGLqnQVLchXSXUG
 nba95DdCPQKToJMNTOuxm7u3BQsRcXgDtjCOkAYyGllWS0jf1ndGa1RxNvht/8yrmqdeM+4/ooW
 7xd55L0nBvoibPAACKFeWR7lVi4b6ogn8Ph7zbipLRT0/iy2a4+wcsIFWaWvsrm/xIQUrmcEudL
 wwnL41cGMdPi8vYDYruc+AvUTIjAGpTiCCW2Tgb+mHLBBoSJIZgS9SzQSwMS2x5/W1NpDw+9L87
 1d7tanNKxYX5lcJ5iy7oJxac4ECVqa2bdVhBiMWvzaOokQPNV8yGnNyVNOiaPXR++wOlpehneSX
 /VZm/KWdOo0dHuIkEeJl7PdRETldjsAme/u56hR0FP5B+VXVxSYNkLmSAt6Qhoug+6hOkiHf2XC
 nvgTRlGJDSUY+db39JQ==
X-Proofpoint-ORIG-GUID: ZIlL3nCb52InbQu_0sZH0RBsioOQviip
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae4e149 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6_gWjx6qscrDNB68990A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300073
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

Add a mips32r6el-linux-user target running, on mips32r6-generic,
32-bit versions of the Release 6 tests that don't need 64-bit
registers, starting with and, nor, or and xor. Output is TAP.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/include/wrappers_mips32r6.h | 61 ++++++++++++++++++++++
 tests/tcg/mipsel/test_mips32r6_logic.c     | 60 +++++++++++++++++++++
 tests/tcg/mipsel/meson.build               | 29 ++++++++++
 3 files changed, 150 insertions(+)
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
index 000000000000..b640aa0975b5
--- /dev/null
+++ b/tests/tcg/mipsel/test_mips32r6_logic.c
@@ -0,0 +1,60 @@
+/*
+ * MIPS32R6 tests: logical instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+
+#include "../include/tap.h"
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
+                TAP_INFO("%s: %08x, %08x: got %08x expected %08x",
+                         name, a, b, res, ref(a, b));
+                fail = 1;
+            }
+        }
+    }
+    return fail;
+}
+
+static int run(const char *name, binary_op_32 op, ref_op_32 ref)
+{
+    int ret = 0;
+
+    ret |= check_op(name, op, ref, b32_pattern, PATTERN_INPUTS_32_SHORT_COUNT);
+    ret |= check_op(name, op, ref, b32_random, RANDOM_INPUTS_32_SHORT_COUNT);
+    tap_report(!ret, "MIPS32R6 logic %s", name);
+    return ret;
+}
+
+int main(void)
+{
+    TAP_START();
+    run("AND", do_mips32r6_AND, ref_and);
+    run("NOR", do_mips32r6_NOR, ref_nor);
+    run("OR", do_mips32r6_OR, ref_or);
+    run("XOR", do_mips32r6_XOR, ref_xor);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 1951c3c437fb..d64cf50f5a05 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -63,3 +63,32 @@ if 'qemu-mipsel' in emulators
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
+      'cc': 'mipsisa32r6el-linux-gnu-gcc',
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


