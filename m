Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DFE606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lzYpidYR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TNShIFEG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAq-0003PH-N7; Fri, 30 Oct 2026 11:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9c-00025B-Hq
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9Y-0007Ff-IG
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERBUO2494589
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U+DHhcr5Gx6BqM4F1GfoxoVxHm3uq2UsHlTMcsYEsgc=; b=lzYpidYRo4irZuhR
 pyFV/lD6efnLwkkTlYFb1QcIi2cjM/70byoxyxAJGOivID9IdRD7S5dacKhUTTEl
 V/5Os3JrXqIl1y2wzWSeCQcVzaNToUN/ibxxM3MfGezSgSWfalrOmiLUM0f3Od3x
 X62v01CUvbPLfxrztz8ayDtfxJ11FUQik9c1oA6L+8qpleNgJZ66KMPT62ALesII
 Zj+Cn4E/tzlakhTQwya6TjuWjHxXQtFdUWpzDYMPJ3MmHGaGDoIn4/+m2ygQARdC
 VE/9I+hULx6JWxHc9quRYbv1nnpLjZh/YL96uN9cfCAkF3EaWkMyaHHMRrwZrGbE
 fY0Ucg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p3pkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:19 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ec62c05c25so1293948e0c.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372659; x=1793977459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U+DHhcr5Gx6BqM4F1GfoxoVxHm3uq2UsHlTMcsYEsgc=;
 b=TNShIFEGPcTRi2cPB1Az5lspC61CMCuXnnunOOo0CNl+rwqTQ3gbUx0SdAeCqLHFu8
 vCBb8Ryw2epOPVC1OzrLvZm0XLgq9SZiJvd4Uue5W34eTqVHT4Bz44GgyAg/85XvDzmf
 zYNdgkA//+RyvJHmpltrnmsImfkO4i0J5uVuR4+BDXrByJ2eXvTrC2Gf6g07u0B3814s
 PZJ86066yvYZVHvEt+LoVe/M4OM5J47Aezweyz9vIZ0ZNsuWtuHRlWA3PMak4tY6p66/
 LrAvsF9IJg6wAQFfNdvZhCBpTkvbltGiheqFOSdN31qDv+lXRiVkujElVhkPy6uQl+Qh
 /2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372659; x=1793977459;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U+DHhcr5Gx6BqM4F1GfoxoVxHm3uq2UsHlTMcsYEsgc=;
 b=189qZ/cMD1yn+SKuW3+RFcFHPLqGkH4gFd7AQWaI4oSI0uNzDiOCTDzuNiJQCRS2wY
 0OPK/T2ozWqyETuiD4+gf+agu8i/hCd96HXdjLq+gsZ/5cSaipUWT+KURtB4To94lhWx
 GmHzjq3HLO6DlKOapyIx00NNaHbBbyhQRWzaehermrAxmAaOuRC9UL2iYNj//GoAbvbd
 8f9SgqnlUpVWsA3Tq1EiA1Xpe9xOohWQuE0b488yyjEK48MKpFmYZg49QG9leC3tiJgg
 lgUWqv0Us5MK+8qTqFu0lgyur68X5vp8rI6Hgc24e72t+1fA5gGLhNuEBmqVFl+ZfAxg
 ISlA==
X-Gm-Message-State: AFq9FYJdq1c9MwG81vGKED++RZJdUgo6vnpRYEjDkKJYw1oJRnendW3x
 RLiIS2nWXtczQiksfI5zFIxmoxNxM44xtUYZjWAwT6j2+utnbw2OSl/nao2pc3Bx+A8y93GFTX6
 dgYdHO4eWwX9l2dQnWUkZV39JMeu3mzU+vjIeToUXyW8cJreKtppR0wpWRxgfi7ZDvEtO
X-Gm-Gg: AYBFou16QdzC5V7aCx5kSeFFFiSxxkmqsxtSc8psn6lpbBdRqfkf4r/Tj900pohMXQL
 rshb9HNYhomVFm3roy9mXzifgBMcmZ3/8E86iNQ60Vc39XxB0FQmC3G7DUoozLzSG4pc0ceEDIM
 7GRvH4ae5yUAaz6NzK/xEDZO8MefTNtnRMYw6NZoeNt6B3R4l5UxdCJJk5/vTrQBScqN7eIbEDE
 VxORqbotEVVmen4tpHBxpOJDhit6zIqDiT1DBtxfUHVKYCkUtVWCVM2msXnQJRqiLtWZyvt8PdV
 NMNNt+4a3aR+CZ7TLYpEGjk9vZ5TnbZgF1lM0/e2pvhXdEeLfR083yG1bPoNbKk7zwsCjZSN3hg
 cF9UVJgg5kVmCCDP5Y1qMm/djhuhKCWTHsURdNiKMobMm1toxLYUEYInMBkCxwRK6be64PzBrfT
 kie4tY7vTiqeNWeQx6pyKBDRFGN2b/2w==
X-Received: by 2002:a05:6102:2d0a:b0:7cc:905a:331a with SMTP id
 ada2fe7eead31-7d072d6f57cmr783006137.14.1793372657802; 
 Fri, 30 Oct 2026 08:04:17 -0700 (PDT)
X-Received: by 2002:a05:6102:2d0a:b0:7cc:905a:331a with SMTP id
 ada2fe7eead31-7d072d6f57cmr782992137.14.1793372657210; 
 Fri, 30 Oct 2026 08:04:17 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80eb1sm3916436f8f.34.2026.10.30.08.04.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:04:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/31] tests/tcg/mips: Group MSA bit-move tests
Date: Fri, 30 Oct 2026 16:01:45 +0100
Message-ID: <20261030150202.61556-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX45NAqNSlRbXB
 psgx7xdi9jd3ryUBvWAGhl0DxwLlCt9Yc3S5e/emAJZ7Wn5W/Rh+D/2A+4bUWAk2/aw8yzn6tqV
 B5tq3Mc2YKy1KJv1odXgOr853eS18x+6ANjTJnK6EWTwFC7neibQ2ElCogpvEKb8U1tuSn/M9BL
 cSIXr9u3dLxn1RiTjHRHJhhL8IA62XyoOQqz0DQZidRmrVjd1WSS27zuX/jiz/2ufg5nvr9mkeM
 KAFxSH7N/8q5otgSPFIFLVHs7TuUbYx0ZYxUxsyEZaMllaCtRQVWd+8S5jXdtSDmXWgZcqOq9o8
 Xvi9XU87XmHy8Ejsadz06mXYSKv6XJAPF9m8ugKrceKRUR4mL9MJPfvaxj70HHh9ve38pbKq8uV
 rKxyK321u6ywmSyiUODybQ+0kDiXP2btNsDEcdsj01g2su42mVUt2juJ3yUvsa09urNs6FtceGn
 v+nVVKrWS88sOuGsp6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX+v+qY2o6pKXv
 xtAg/jAYTnPMGluav2IMp/vtIGXvLiji9B8Fesg2XIWH8R7sQEqM7/D4FmK2FFTIcwZCgCcs/9r
 SBtgHklmZax11ujv1m88DVCQULFEVQM=
X-Proofpoint-ORIG-GUID: krAfQdJafD0Olug-94tMXc0zauyQItjt
X-Proofpoint-GUID: krAfQdJafD0Olug-94tMXc0zauyQItjt
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4b1f3 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300059
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

Build the 11 per-opcode bit-move tests as a single executable,
test_msa_bit_move.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_bit_move.c | 93 ++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build         | 12 +---
 2 files changed, 94 insertions(+), 11 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_bit_move.c

diff --git a/tests/tcg/mips/test_msa_bit_move.c b/tests/tcg/mips/test_msa_bit_move.c
new file mode 100644
index 000000000000..02fb3bc486cd
--- /dev/null
+++ b/tests/tcg/mips/test_msa_bit_move.c
@@ -0,0 +1,93 @@
+/*
+ * MIPS MSA tests: Bit Move instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_binsl_b
+#include "user/ase/msa/bit-move/test_msa_binsl_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsl_d
+#include "user/ase/msa/bit-move/test_msa_binsl_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsl_h
+#include "user/ase/msa/bit-move/test_msa_binsl_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsl_w
+#include "user/ase/msa/bit-move/test_msa_binsl_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsr_b
+#include "user/ase/msa/bit-move/test_msa_binsr_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsr_d
+#include "user/ase/msa/bit-move/test_msa_binsr_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsr_h
+#include "user/ase/msa/bit-move/test_msa_binsr_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_binsr_w
+#include "user/ase/msa/bit-move/test_msa_binsr_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bmnz_v
+#include "user/ase/msa/bit-move/test_msa_bmnz_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bmz_v
+#include "user/ase/msa/bit-move/test_msa_bmz_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_bsel_v
+#include "user/ase/msa/bit-move/test_msa_bsel_v.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "binsl.b", test_msa_binsl_b },
+    { "binsl.d", test_msa_binsl_d },
+    { "binsl.h", test_msa_binsl_h },
+    { "binsl.w", test_msa_binsl_w },
+    { "binsr.b", test_msa_binsr_b },
+    { "binsr.d", test_msa_binsr_d },
+    { "binsr.h", test_msa_binsr_h },
+    { "binsr.w", test_msa_binsr_w },
+    { "bmnz.v", test_msa_bmnz_v },
+    { "bmz.v", test_msa_bmz_v },
+    { "bsel.v", test_msa_bsel_v },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Bit Move", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 88ec44520377..ae755143c18d 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -3,6 +3,7 @@ tests = []
 # MSA tests shared by the mipsel and mips64 targets
 tests_mips_msa_groups = [
   '../mips/test_msa_bit_count.c',
+  '../mips/test_msa_bit_move.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -152,17 +153,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/pack/test_msa_pckod_w.c',
   '../mips/user/ase/msa/pack/test_msa_vshf_h.c',
   '../mips/user/ase/msa/pack/test_msa_pckod_d.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsr_w.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsr_b.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsr_d.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsr_h.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsl_h.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsl_w.c',
-  '../mips/user/ase/msa/bit-move/test_msa_bmnz_v.c',
-  '../mips/user/ase/msa/bit-move/test_msa_bsel_v.c',
-  '../mips/user/ase/msa/bit-move/test_msa_bmz_v.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsl_d.c',
-  '../mips/user/ase/msa/bit-move/test_msa_binsl_b.c',
   '../mips/user/ase/msa/shift/test_msa_sra_d.c',
   '../mips/user/ase/msa/shift/test_msa_srl_b.c',
   '../mips/user/ase/msa/shift/test_msa_srl_d.c',
-- 
2.55.0


