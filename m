Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A30606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g3o2IehI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SY7ZOff4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNST-00015B-7k; Mon, 26 Oct 2026 12:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNS2-0000qC-GJ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNS0-0000bP-HG
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:34 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvvQw3567430
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ko7cB88boBRV4aynWiCvO3YZeaaWEvFzNv1dB6KgtWU=; b=g3o2IehIkvkjsAAB
 UbEwUDdslqf6yCPo6WzZr/ylAncSOhJL4Gm9mrhipfNbqpl35AbD5oRQJdyPHNFG
 p9JBelWNd8YR1ncRn2h+ENXrwVKlw/deulTEqXX+aNkIdArYZsvxjpK6H1U8i/jI
 KW4hkxxwbuSDcau/95/ccgupEEYvNC7dGN+EmFTvI++6kVIZNLgiVUj6BNYyhTjB
 WiXDDdAc+4llkZcF5kYXseie+Dia44a34AZsi3nMpa8u7Cup1IEY5AYZ4pU1YlJT
 w7f9EEmYHtrIrs6Aiyi4l2rTK3854yIDgfAVa3Ai1T7q7fw794qyz0sAE4oPPMjO
 jLSFmw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y1a8d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917a2de2cc1so45965166d6.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031691; x=1793636491; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ko7cB88boBRV4aynWiCvO3YZeaaWEvFzNv1dB6KgtWU=;
 b=SY7ZOff4N59aIJJPyfGWRh7mEFl31hT3g87fpM8/v63CHRXaKuIr7daRDOWA+Y7zRO
 nfln39xXV6Smr0VAv9bO+5U4pRNiJTaBmjAl24rJOgwrfze741vKSdd405oWL4RN99F3
 swN0uiVM9UXr+Kea5XcQ9IgvMIHN4tJMs87wSippMpWf2GAARpznyf1luGnkrw9IWK6q
 CtoIqh0RVbc0AWhOmxf0sw0YP/dyXt3reaRVlzyXHw4zCUcG3KE/jYRPKNM8mn4qgzAx
 C7vjBsN5v7iLvW37mmovOZXF4dilPmstCf1hK8nNIGxb70hMwt7AzNkBpSP3KA7NXFae
 CObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031691; x=1793636491;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ko7cB88boBRV4aynWiCvO3YZeaaWEvFzNv1dB6KgtWU=;
 b=Pjm4DMAsYDQWcZZo+bba/sIEYvuAs2ROM25H+Wfml/LKcooOFW3m547zhCLLbOuRC0
 rZpGxAiJwNSd1oZsViCktuYirgmiIGWfZlWsOcEUqwIvbmCOzGGn6hLWivIEYbCM22SG
 TCpOCOY/tBSG0YfdvT8SBkgOLP8nOwFpkkSC41SOgROzUrA7Ssg01z1dq1L8kpIw0NZD
 PThrSzjtaYB6lbqCBCc8cf+q9oMR30rtSbG2r30Bb5u7uiF2pq6xeZRRSj3fe3jGmJL/
 GzBrx86dIbGMpBCHOzciW7mAbNTN9gGr/yYjmNC082DIHixUKWzWaw7KLlMxa8TtCZgI
 i2Tw==
X-Gm-Message-State: AFq9FYKScL/vrkf4dIK1ed7GKNjZSoPuI6CFFPZ/e3NTmgD3WVD1wd60
 LKCQPDKDlS15lEOKgLaX6UhfwjHG8SLuBMUmuvtCzYRVwBsR5HxJT6p4n/NCAuKPkXMsPcYxeNL
 Afz979WqBczuKomQ/cb/Zt8PNF2C2vAFD3/5eHaSC/GlenJ/ssC1boxQ3qXhqQ9GPqw==
X-Gm-Gg: AYBFou2kgd3Z/ypjK7ZHGIAtC3gxzltaNgaFXkNTFNVyIlv7irpaIAalE2/bPzbitdp
 2hbn1HbIQ//RVxbTd8V5CMemKppDpPxBE3kJK/8FF4TIysw76AYclMCqv/iLvJu/c1+esBtiBb5
 FRk9VVvsbmrX3yY5xkVmgUnemOxNyXJezq+CVbwbMIX03pAt/j833BLMj/KHFnOUJyCr1+2juYn
 ce/4IGtg/aCmssRo2dGJkGfOWq/ylV/cHtEf5YD4HWaOAfZdYqhNDpPAc0S/qNrYp3z8zh1vmZw
 nA14ys1Gxkg6lP851wwIq89n2wao4gF/FBQsIp2EzJaCbsBmqiSQj3hnG38o74i3r909t/SeiOx
 Lyw1sG8WUWKDjuzwYhD/cNFAD4+uQMPMwOzXsKBMN
X-Received: by 2002:a05:620a:4001:b0:93c:ca09:aa34 with SMTP id
 af79cd13be357-940ef955604mr1004640985a.46.1793031690462; 
 Mon, 26 Oct 2026 09:21:30 -0700 (PDT)
X-Received: by 2002:a05:620a:4001:b0:93c:ca09:aa34 with SMTP id
 af79cd13be357-940ef955604mr1004634385a.46.1793031689843; 
 Mon, 26 Oct 2026 09:21:29 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdfb8esm17356705f8f.54.2026.10.26.09.21.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:21:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 07/14] target/mips: Introduce decode tree bindings for
 nanoMIPS ISA
Date: Mon, 26 Oct 2026 17:20:26 +0100
Message-ID: <20261026162034.32711-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfXzXmdAiMQ3ogF
 QOVKT/i5JNSR4LLdgEkBDIT9RbCa8hbQc4mcaJVRu3pII6VXJgzl+lr2t+JdkKt07nqOSmzfW5K
 dmLshguDU2VwL8hXHzKnlwuIeUpT3rU=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adf7e0b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Ixn1CAxRAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=-dBhbmNSnZDP8zn5xLMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=_0vDLAJOulx5KDpLVjVP:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX0bn6k4NVUGBM
 9Ocm3s+Ogfdi2RGIbdYJPa0j0UXreZm9mrWUgbGh5FEnNGuxWQ1ZOrfU8I/piQ8xvbUnVZlVHJb
 7tgFGEmIXqFJEJEhJ+5412jhLM0abj9GzYChLs+fl8dm/i+IO7o1K0vOcFJ5J0XbZ+OUta18vdz
 IxGmoJa1bDMSI8KBOZItoprl1V/UIeYL6XCYmVlyAalBbZHhpaRyiv36lQPcRr4g/3Ng885yhdO
 vOUw/tJXEs4AsFNw8EBw+1uNTb+9wJURyCAd3/289zo4wQffs6PIXuRrmBGX+syhXJ0DsUUkLTb
 RD/3Pa+/LI8+BB3rSPmJgZsny8gwEBe7gIyUlEUJvFuCpt1Rd6MaGWzUpeB+iAIdV0KN1K6PJVg
 u79hlptA+xG9uWDNSi2mQ0UuWClPfTE+B5yLS9rNG2iF72RBUhWsQKHKw9ZNGW2Ch3Pk5Vmaxan
 CJBBJDEAcwFZx6W75Ow==
X-Proofpoint-GUID: womZeFeN_ItvxoGFR4nJSwfIfMim2Phq
X-Proofpoint-ORIG-GUID: womZeFeN_ItvxoGFR4nJSwfIfMim2Phq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260065
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add empty decodetree files for the nanoMIPS 16-bit, 32-bit
and 48-bit instructions.

The instruction size is known from the first halfword: 16-bit
major opcodes have bit 12 set, and the P48I major opcode is
the only 48-bit one. Call the matching decoder, reading only
the halfwords needed.  Unmatched opcodes fall back to the
legacy decoder.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Since v3:
- Select the decoder from the instruction size, reading only
  the halfwords needed (rth)
---
 target/mips/tcg/translate.h              |  3 +++
 target/mips/tcg/nanomips16.decode        |  8 ++++++++
 target/mips/tcg/nanomips32.decode        |  8 ++++++++
 target/mips/tcg/nanomips48.decode        |  8 ++++++++
 target/mips/tcg/nanomips_translate.c     | 15 +++++++++++++++
 target/mips/tcg/nanomips_translate.c.inc | 22 ++++++++++++++++++++++
 target/mips/tcg/meson.build              |  4 ++++
 7 files changed, 68 insertions(+)
 create mode 100644 target/mips/tcg/nanomips16.decode
 create mode 100644 target/mips/tcg/nanomips32.decode
 create mode 100644 target/mips/tcg/nanomips48.decode
 create mode 100644 target/mips/tcg/nanomips_translate.c

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index eea7e555153f..d11b2f32f009 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -229,6 +229,9 @@ bool decode_64bit_enabled(DisasContext *ctx);
 bool decode_isa_micromips16(DisasContext *ctx, uint16_t insn);
 bool decode_isa_micromips32(DisasContext *ctx, uint32_t insn);
 bool decode_isa_micromips32_r6(DisasContext *ctx, uint32_t insn);
+bool decode_isa_nanomips16(DisasContext *ctx, uint16_t insn);
+bool decode_isa_nanomips32(DisasContext *ctx, uint32_t insn);
+bool decode_isa_nanomips48(DisasContext *ctx, uint64_t insn);
 bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
 bool decode_ase_mips16e_16(DisasContext *ctx, uint16_t insn);
 bool decode_ase_mips16e_32(DisasContext *ctx, uint32_t insn);
diff --git a/target/mips/tcg/nanomips16.decode b/target/mips/tcg/nanomips16.decode
new file mode 100644
index 000000000000..f68fb57022a5
--- /dev/null
+++ b/target/mips/tcg/nanomips16.decode
@@ -0,0 +1,8 @@
+# nanoMIPS32 16-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: nanoMIPS32 Instruction Set Technical Reference Manual
+#            (Document Number: MD01247)
diff --git a/target/mips/tcg/nanomips32.decode b/target/mips/tcg/nanomips32.decode
new file mode 100644
index 000000000000..2127c57444e6
--- /dev/null
+++ b/target/mips/tcg/nanomips32.decode
@@ -0,0 +1,8 @@
+# nanoMIPS32 32-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: nanoMIPS32 Instruction Set Technical Reference Manual
+#            (Document Number: MD01247)
diff --git a/target/mips/tcg/nanomips48.decode b/target/mips/tcg/nanomips48.decode
new file mode 100644
index 000000000000..0ab33ce5a952
--- /dev/null
+++ b/target/mips/tcg/nanomips48.decode
@@ -0,0 +1,8 @@
+# nanoMIPS32 48-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: nanoMIPS32 Instruction Set Technical Reference Manual
+#            (Document Number: MD01247)
diff --git a/target/mips/tcg/nanomips_translate.c b/target/mips/tcg/nanomips_translate.c
new file mode 100644
index 000000000000..9393257612aa
--- /dev/null
+++ b/target/mips/tcg/nanomips_translate.c
@@ -0,0 +1,15 @@
+/*
+ * MIPS emulation for QEMU - nanoMIPS translation routines
+ *
+ * Copyright (c) 2021 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "translate.h"
+
+/* Include the auto-generated decoders.  */
+#include "decode-nanomips16.c.inc"
+#include "decode-nanomips32.c.inc"
+#include "decode-nanomips48.c.inc"
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 421f26a192cb..6f6b5f190c9a 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4482,6 +4482,28 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
     opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
                                  mo_endian(ctx));
     ctx->opcode = opcode;
+    if (extract32(opcode, 12, 1)) {
+        /* Major opcodes with bit 2 set are 16-bit */
+        if (decode_isa_nanomips16(ctx, opcode)) {
+            return 2;
+        }
+    } else {
+        opcode <<= 16;
+        opcode |= translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 2,
+                                      mo_endian(ctx));
+        if (extract32(opcode, 26, 6) == NM_P48I) {
+            opcode <<= 16;
+            opcode |= translator_lduw_end(env, &ctx->base,
+                                          ctx->base.pc_next + 4,
+                                          mo_endian(ctx));
+            if (decode_isa_nanomips48(ctx, opcode)) {
+                return 6;
+            }
+        } else if (decode_isa_nanomips32(ctx, opcode)) {
+            return 4;
+        }
+    }
+
     rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RT3(ctx->opcode));
     rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS3(ctx->opcode));
     rd = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD3(ctx->opcode));
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index d7ae95b70f56..644ca85f6390 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -5,6 +5,9 @@ gen = [
   decodetree.process('micromips32.decode', extra_args: ['--decode=decode_isa_micromips32']),
   decodetree.process('micromips32_r6.decode', extra_args: ['--decode=decode_isa_micromips32_r6']),
   decodetree.process('rel6.decode', extra_args: ['--decode=decode_isa_rel6']),
+  decodetree.process('nanomips16.decode', extra_args: ['--decode=decode_isa_nanomips16', '--insnwidth=16']),
+  decodetree.process('nanomips32.decode', extra_args: ['--decode=decode_isa_nanomips32']),
+  decodetree.process('nanomips48.decode', extra_args: ['--decode=decode_isa_nanomips48', '--insnwidth=48']),
   decodetree.process('msa.decode', extra_args: '--decode=decode_ase_msa'),
   decodetree.process('tx79.decode', extra_args: '--static-decode=decode_tx79'),
   decodetree.process('vr54xx.decode', extra_args: '--decode=decode_ext_vr54xx'),
@@ -25,6 +28,7 @@ mips_ss.add(files(
   'mips16e_translate.c',
   'msa_helper.c',
   'msa_translate.c',
+  'nanomips_translate.c',
   'octeon_crypto.c',
   'op_helper.c',
   'rel6_translate.c',
-- 
2.55.0


