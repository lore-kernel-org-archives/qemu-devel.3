Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE40606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C1/qXXrD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ArVITXy3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNRd-0000Ey-OO; Mon, 26 Oct 2026 12:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRY-0000Dw-I0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRW-0000Ti-KA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvqDd3268465
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +fNRr6LV3Xu6C5tMHtduQ5n+VTkndY6n4CzMUFg8gPM=; b=C1/qXXrDZyQiIXft
 G3HL5vrE4j5/pYsZ4s33blzgG/u09qPhKBSj0NY1vkCZ3MC0cl89ZVbTEIWb7Ldi
 6aV/jrXUCNa1+VA+hRZWmNiCRp5rebz827DAn1N6MCbeWMpypnyWYGBz9Dmw7Wv7
 R1DY8n9PQBmmwl+LOF7zC0dn2ajUG9SAyaci8NWjBDFMrvluX3aC6hZ55OOW1ITv
 jv4hSx7oq+vZ91Z9iq+wgOTeJOMRRbh5zlQFxLZMrVOf7RzQwC7iD1xZhcdKK1Ri
 8awYRa/LGNrNbBt/Nj8Rq/GfM7DLNdWAnEl6iHqd5d1xlF5Ytz2x9IkLXf+AeCXo
 IpOWYA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cp9jgh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:01 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91becce058aso88612916d6.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031660; x=1793636460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+fNRr6LV3Xu6C5tMHtduQ5n+VTkndY6n4CzMUFg8gPM=;
 b=ArVITXy394DVTieaT/8JvAjRYEcIiipsZVO35hTq/shAbixpexsKZLYaVKDwe7MkNF
 fdNclxRpTV87YXK7FnEHkl5UBKZgNXWkVAzj8bGlCv4jHhhwTvRB6FGv9FJ4dvOQr81P
 F54//0Gu4ckW80Bad7HiW17TxROOxgkvlW1v24VB3jb61PAr062piZ9adkQyqI7kgrHv
 Kb+qUq0tTMQ9zJM35yZV3SdRjqNcQQ1e+UylJGElhIW8LbALrWwQpUi1/cSaVUsilkOY
 5gImlYirPQPC1KAiT7KOdzZCr0Ws08ll4qQ+4gS8EslJoS76SSQzupdfg6+xIQ2A9BlY
 KBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031660; x=1793636460;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+fNRr6LV3Xu6C5tMHtduQ5n+VTkndY6n4CzMUFg8gPM=;
 b=jC/PHZIKCBUVwrJNrjQ0m7JONZMIC/inK0zuBZqPliO8c62TGvT/dPZ02gBDBnXic+
 Ie1jphFjQf49ntXsDfBSz+L96Awis26qZbFixGBT6WuOg/qkPmZwZzQ+MayAdKexj6rh
 oIxab+v4CtqkBUNK9EHVRKXTlio/C6NwSqpmoMP2z2PI1gAq2T0W3psn6B6k1kTJIll1
 frb7O0wVxDaphQyeWcPOae4VCHGhrw8QXD44l6SlB6V+5q77q6otJQxuCitw6GgzGUvS
 kN8NW0GuRWf857d58W+K1b1cdW71j2uKV/aX5dNFb55ZbGg8zGD/VU32Q/GbxxterbYs
 SZXQ==
X-Gm-Message-State: AFq9FYJhLJNIKHxojdEoqYawkKbtXK3Am12Va7QOo+zsf7T7WLzFNZ5M
 54b3Qilcg+1AgwA3nVe/kf7/p2tUcoDiawkN1HQM4pleACELzhzTwPnoamvfcu+wprANVlU0g6x
 yb4LcMJRXGx0Ps+u6FVD35SAYKl4b7LvB1dUKbY+bj6HcYZZaxCIceT6YOBHHEYRPKQ==
X-Gm-Gg: AYBFou0xJTjqRuZYtHj+lcDWBy7Os6kUxLMbUvuZGtCuwMAlasyLKm9OCbc8Ekv5LOO
 KkSHmqvrZEmwIcIogv5zFMkaxOlSpEUdtGU2U0TCizHJeP9ifo3n6BOQTDZSysPXHfbWnqtQDHn
 mlhgApijBLh1ffGEFD+8xsR6AZDs6WhKeMdoAUkO1ASbJyS4J4GYHEgViSHwDzFlCssPbUv0aJ5
 h8Uq7Xn+s3bvhOV3mcVzlYBEalzTeW56KHr6Hl42E2wM1jmD1xs1Fnj0QJYATPep7CpSZCUWr4J
 D+WnjGB/LZzWRqvcZth9gS6sH7HMJK2Maddodbc/5CsJSSfxVrVoRoTKirBjvLAwJ0LBkzY/k/+
 IZYI1IxxjI/vJhRfBbcnGYGVwkU8t+JL3qf7p6fyx
X-Received: by 2002:a05:620a:801c:b0:93f:16d4:3bf0 with SMTP id
 af79cd13be357-940ef9357b5mr1054293385a.42.1793031660383; 
 Mon, 26 Oct 2026 09:21:00 -0700 (PDT)
X-Received: by 2002:a05:620a:801c:b0:93f:16d4:3bf0 with SMTP id
 af79cd13be357-940ef9357b5mr1054287285a.42.1793031659675; 
 Mon, 26 Oct 2026 09:20:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd49afsm17625826f8f.35.2026.10.26.09.20.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:20:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 03/14] target/mips: Introduce decode tree bindings for
 MIPS16e ASE
Date: Mon, 26 Oct 2026 17:20:22 +0100
Message-ID: <20261026162034.32711-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX6Tz5nGsSbKLs
 fE5wxj6JN3M41n0l21gv46C+SRMb8Jwt4bjJucpwT3GDOL4rhYIELKeLrJMZQ6/ut6oixsaZ8+F
 76K644ljxIByMtrIvqZxfh+bOmJNAXYaR3fTSXEcgL49nvzwY7pxYZfqUr0icrwjPfc0HCpjITH
 BrVxLFz99QThAxxP0McPHOZbjr85xQ0MNhPj+AJAGvW65KP1Dd59jpIyIrcew1blh+w0V76rDNM
 YvDEz+mSaUZtk8OUxFQkW3atjVBdbA1zSoPoYHxTiDvYpRxbxsGYk/UVn0sRWakTI7kl0WUGPrV
 l8wyEkjYsvlRU7eZFrd66vHhI44MXRT50qdKvlFDmyvPWPGc8v5dWj5iKGfFiAPx9uTa0e14FVu
 5IV/deCG1CCwwUcSwjlu3ZWj8RnYBUEwD2pmeQw6EC8gCBeRDjpcK7fxlk9cickeMlyob1mAH1R
 ICuJ/cYtfxoq//Sf4Uw==
X-Proofpoint-GUID: YOb_fAO8Uw6YkjGkkWZducfB4UnvzSVZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX1ijMr5/g7O2D
 ebujBreRY0ZV7DXvYcIf7rNY7IO6fiTKY3hZKXDNmhdXZ7LYdb+LSag7c5H8ijb01x9bWlUfK/J
 uvklBb/I6ME1EBtMIntysoi9yued9gI=
X-Proofpoint-ORIG-GUID: YOb_fAO8Uw6YkjGkkWZducfB4UnvzSVZ
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adf7ded cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Ixn1CAxRAAAA:8 a=m0wXK8-ymTHbGUjQxc0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22 a=_0vDLAJOulx5KDpLVjVP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260065
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Introduce the MIPS16e decodetree configs for the 16-bit
and 32-bit instructions.

EXTEND-prefixed and JAL/JALX instructions are 32-bit, all
others are 16-bit. Call the matching decoder, loading the
second halfword only for 32-bit instructions. Unmatched
opcodes fall back to the legacy decoder.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Since v3:
- Only call the 32-bit decoder for EXTEND-prefixed opcodes,
  loading the second halfword only then (rth)
- Treat JAL/JALX as 32-bit instructions
---
 target/mips/tcg/translate.h             |  2 ++
 target/mips/tcg/mips16e_16.decode       |  9 +++++++++
 target/mips/tcg/mips16e_32.decode       |  9 +++++++++
 target/mips/tcg/mips16e_translate.c     | 14 ++++++++++++++
 target/mips/tcg/mips16e_translate.c.inc | 17 ++++++++++++++++-
 target/mips/tcg/meson.build             |  3 +++
 6 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 target/mips/tcg/mips16e_16.decode
 create mode 100644 target/mips/tcg/mips16e_32.decode
 create mode 100644 target/mips/tcg/mips16e_translate.c

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index ab2e21736741..98848d2fb90b 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -227,6 +227,8 @@ bool decode_64bit_enabled(DisasContext *ctx);
 
 /* decodetree generated */
 bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
+bool decode_ase_mips16e_16(DisasContext *ctx, uint16_t insn);
+bool decode_ase_mips16e_32(DisasContext *ctx, uint32_t insn);
 bool decode_ase_msa(DisasContext *ctx, uint32_t insn);
 bool decode_ext_txx9(DisasContext *ctx, uint32_t insn);
 bool decode_ext_loongson(DisasContext *ctx, uint32_t insn);
diff --git a/target/mips/tcg/mips16e_16.decode b/target/mips/tcg/mips16e_16.decode
new file mode 100644
index 000000000000..2f3926052b9e
--- /dev/null
+++ b/target/mips/tcg/mips16e_16.decode
@@ -0,0 +1,9 @@
+# MIPS16e 16-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS Architecture for Programmers, Volume IV-a
+#            The MIPS16e Application Specific Extension
+#            (Document Number: MD00076)
diff --git a/target/mips/tcg/mips16e_32.decode b/target/mips/tcg/mips16e_32.decode
new file mode 100644
index 000000000000..1dccb554fb56
--- /dev/null
+++ b/target/mips/tcg/mips16e_32.decode
@@ -0,0 +1,9 @@
+# MIPS16e 32-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS Architecture for Programmers, Volume IV-a
+#            The MIPS16e Application Specific Extension
+#            (Document Number: MD00076)
diff --git a/target/mips/tcg/mips16e_translate.c b/target/mips/tcg/mips16e_translate.c
new file mode 100644
index 000000000000..136468c65c71
--- /dev/null
+++ b/target/mips/tcg/mips16e_translate.c
@@ -0,0 +1,14 @@
+/*
+ * MIPS emulation for QEMU - MIPS16e translation routines
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
+#include "decode-mips16e_16.c.inc"
+#include "decode-mips16e_32.c.inc"
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index eb77326acf6b..dfb4312f1835 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -658,7 +658,22 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
 
     ctx->opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
                                       mo_endian(ctx));
-    op = (ctx->opcode >> 11) & 0x1f;
+
+    op = extract32(ctx->opcode, 11, 5);
+    /* EXTEND-prefixed and JAL/JALX instructions are 32-bit */
+    if (op == M16_OPC_EXTEND || op == M16_OPC_JAL) {
+        uint32_t opcode;
+
+        opcode = ctx->opcode << 16;
+        opcode |= translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 2,
+                                      mo_endian(ctx));
+        if (decode_ase_mips16e_32(ctx, opcode)) {
+            return 4;
+        }
+    } else if (decode_ase_mips16e_16(ctx, ctx->opcode)) {
+        return 2;
+    }
+
     sa = (ctx->opcode >> 2) & 0x7;
     sa = sa == 0 ? 8 : sa;
     rx = xlat((ctx->opcode >> 8) & 0x7);
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index 4ee359874aca..7715b029f90d 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -1,4 +1,6 @@
 gen = [
+  decodetree.process('mips16e_16.decode', extra_args: ['--decode=decode_ase_mips16e_16', '--insnwidth=16']),
+  decodetree.process('mips16e_32.decode', extra_args: ['--decode=decode_ase_mips16e_32']),
   decodetree.process('rel6.decode', extra_args: ['--decode=decode_isa_rel6']),
   decodetree.process('msa.decode', extra_args: '--decode=decode_ase_msa'),
   decodetree.process('tx79.decode', extra_args: '--static-decode=decode_tx79'),
@@ -16,6 +18,7 @@ mips_ss.add(files(
   'fpu_helper.c',
   'ldst_helper.c',
   'lmmi_helper.c',
+  'mips16e_translate.c',
   'msa_helper.c',
   'msa_translate.c',
   'octeon_crypto.c',
-- 
2.55.0


