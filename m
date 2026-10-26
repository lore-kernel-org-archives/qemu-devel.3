Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5C606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qtt40vyu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QMvZX8/X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNS9-0000tQ-2h; Mon, 26 Oct 2026 12:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRt-0000fI-ND
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRr-0000YK-L5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEw6ZL3584354
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6phWrEDzHwkMZDq8G9LZXr7+gwtK6yOyhYk7HX2z+lQ=; b=Qtt40vyuDRPnYB28
 6x67BBgPaHmAgqSa4r3E16ZHn9QrfFLUBiAAs/xrJyohy0gLvT1VO+FqApAfekGb
 eOkaFytQB7DdMeQRHxxpNOHPP+iEBIWo1RRavudn7+4cTGR6xjAoAwJwsHJvopc2
 GIgzH90qubkpdHT+IluK49d+O3lZLHDEdo7XgmC1TbMfY44NBoii+81Uqfp3D+kP
 GmvIp1vUkE1Z84wEQ4MPZ80HMLOZJn6PVXoPXvgkNE4ZK/SG6M6J+8UJHnf5ufq4
 g5enA7MYb1lLGuIuhlag52fe9g17GP9Hfi1HLaGBL5PPEZB9sJ5VTlvb1+LGKaTy
 oCh7Zw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvddb1vx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:16 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5eaad995a7eso572501e0c.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031676; x=1793636476; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6phWrEDzHwkMZDq8G9LZXr7+gwtK6yOyhYk7HX2z+lQ=;
 b=QMvZX8/XgpUYHAqz6K0WtXR+eEjKe14srahlUrComPiCr36jn+EkvE0VttwcU0ML/G
 Q4+UmFk9u8eR2wuhwbb8URaG8hTEdWpuf1lcIXMhtqLPaD0WuU8QUbUn+hWM1zNK7QtO
 M+/qPIoGW0NmGclvbvQoHX6jKOgwiNSVdzj8/M8WZYQhOkGjNjiMZURDWKLV3FXWe46R
 wCga2sT5uVyYOVMLeEPh1BTXBEU6BICp7HMe9V0LzTOdgUR5Q/jv8YEAA+LL83TxeQ8r
 V14x5ZtyUbRlVQKIe74kFDpuub559t51Xbe0GD3SSbG397+NrAVWs0x8Jl4i7/rh/DCm
 hwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031676; x=1793636476;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6phWrEDzHwkMZDq8G9LZXr7+gwtK6yOyhYk7HX2z+lQ=;
 b=a3NewdYUmNMTdOmqBa8Wxdcy6fHan0ETe026yey7EzRXQpiOQsjsnInUnAj0QMLGPo
 Pk1X1GxQY1hJBJ81Dad+Qh8cPLOZLH1FUdHwFbETfDV49qWMssZ3tvvPU4ZapVLLtyqF
 SlMsXt7LmoPOiLzlsWrnhnl9uVhGN9FkgJOZd5uRK0TfNxTjacp7yfPBAgEdPnzOcSIC
 1NScU73ei2+BFmbhOG88Q6fvkDbZGPX7LEG6GPspuHM8JQFj+zPcRpHT8WlDzL68scN6
 6DT0c/+1E9hV60NMGhRGVgI2LEa6Dc6ST6OLoFILLrEUEX/DRcrUQoWVh9S90vabxE9u
 LIuQ==
X-Gm-Message-State: AFq9FYLLrxiDu3IKHqF3IOKfA/gKGTVPT5PA0NrIWYOjdGvZyE+XsCZS
 ZIQuVuykcG7XYpUCvdbjm0Vkc/Q2QO88oNkl7QJizqVjWjww8eTq29eeXURB51BrtV2A3MsqwSn
 hwdW1ZHoz1QgOhpjQiZDv4abDx5tG5S/lUYJvnD1hs8/WbVKtwR14zcYh29SIVYpX3g==
X-Gm-Gg: AYBFou1Iy1bkRHgQINHmGca6K6LBBMVIUNTV30C1JZRYjeLTEY7Vod1yHdOynrnO6De
 rwftVNhAaA9mJ8cZZXN/nDfemG+ulbDTiMdOSCeLOJbuQHfg/7CHL82Km8vgGC7sJ6OxNb/doF8
 EngQTYKpq+hTtbc8cukhQogdXjUo5BJWkTbwnMWhaRFlR9C0EmcBszknVeBv0JQmI7ITPlr4rI2
 BrMmDS+9QH0v56/AbeKCFtWhxjN9iHLAc5HX+OhC28XH73dOk7eB1j6xCupayAgvoaA5/mwbeQL
 y2btKZlfkmzz0y2SeLUUjQo/iswBVfbPYRVyiD3mhgd5YaWRWZd6BFrpjTYCMGXID55GDTN2a4m
 FVC2dI0KuZYqi5MKujyk0Z5G8sYJCl91dB/pKluTS
X-Received: by 2002:a05:6122:e461:b0:5c8:46e3:ec57 with SMTP id
 71dfb90a1353d-5ec230a26abmr2731488e0c.1.1793031675539; 
 Mon, 26 Oct 2026 09:21:15 -0700 (PDT)
X-Received: by 2002:a05:6122:e461:b0:5c8:46e3:ec57 with SMTP id
 71dfb90a1353d-5ec230a26abmr2731440e0c.1.1793031674977; 
 Mon, 26 Oct 2026 09:21:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdfd8dsm16355153f8f.56.2026.10.26.09.21.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:21:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 05/14] target/mips: Introduce decodetree bindings for
 microMIPS ISA
Date: Mon, 26 Oct 2026 17:20:24 +0100
Message-ID: <20261026162034.32711-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eL8e6Tyh-xbIwZGHMOBbxcO3ymISulIi
X-Proofpoint-GUID: eL8e6Tyh-xbIwZGHMOBbxcO3ymISulIi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfXyBVO6Zm6Ifi3
 Q7QcRaJ0j85UjVFkA7Au5HowSwSEZZqM+nrCKNFlg5tD51nAGaSpUP5k3s3o6YEBKBDLlNbKsQF
 U4pjRUMWxE7zwLQA6+t2Imerqx5u4TZY9K4R8CL/fFr1/SyYG4DRAjMgG3m2ra1iBdolC5YwNFk
 zAYAsjFNjW3su8TlYpxNkmpDA6oz60MGeyvygtAiqvCO0T8yzj0Y1WmN7oWBUi5Eyl3/lPxy3qM
 dX4JqnV7os8i5oVUzx/tHTNY0XJNzTOLQ1zogumj8uxuGQijRpUIlfCrs65qNxBBFHVLJ6hmrMM
 RzV/WzM/7SB229VGrhnnlahaAC53Xo1tI/0zipV4bGiHOmVOBIGUgVKcpFM8wjs8wY8G+ZgxilL
 IDeULEVraichKcPkV/VDmJr/G9z5dmKMyy/QKuUruhKLK/vQFzYTNw+o0OJYB+zb0EE0XpIQ5Ff
 0K/lhJqoQ2dgPWZP9jg==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf7dfc cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=Ixn1CAxRAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=UIXnzuGw0y2tLGFTxmYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
 a=_0vDLAJOulx5KDpLVjVP:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX1LgsYOLs2oIV
 tnh+bysfmOIUzBPyGi5fNcUP0MMZnA06EagCiwQ/YFg8wgO2ErEiF9Yabcoy2oSSfHeas2J05ue
 0L0AJ0hUIJclr1+3EdrjUoMSeX68kX4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
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

Add empty decodetree files for the microMIPS 16-bit and 32-bit
instructions, and micromips32_r6.decode for the 32-bit encodings
only valid on Release 6.

Select the 16-bit or 32-bit decoder from the instruction size,
loading the second halfword only for 32-bit instructions. The R6
decoder is only called on R6 CPUs, like decode_isa_rel6() in
decode_opc(), so its patterns need no check_insn(ISA_MIPS_R6).
Unmatched opcodes fall back to the legacy decoder.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Since v3:
- Select the decoder from the instruction size, instead of
  calling it from the delay slot check (rth)
- Only load the second halfword for 32-bit instructions
- Add micromips32_r6.decode, only called on R6 CPUs
---
 target/mips/tcg/translate.h               |  3 +++
 target/mips/tcg/micromips16.decode        | 11 +++++++++++
 target/mips/tcg/micromips32.decode        | 11 +++++++++++
 target/mips/tcg/micromips32_r6.decode     | 11 +++++++++++
 target/mips/tcg/micromips_translate.c     | 15 +++++++++++++++
 target/mips/tcg/micromips_translate.c.inc | 17 +++++++++++++++++
 target/mips/tcg/meson.build               |  4 ++++
 7 files changed, 72 insertions(+)
 create mode 100644 target/mips/tcg/micromips16.decode
 create mode 100644 target/mips/tcg/micromips32.decode
 create mode 100644 target/mips/tcg/micromips32_r6.decode
 create mode 100644 target/mips/tcg/micromips_translate.c

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 98848d2fb90b..eea7e555153f 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -226,6 +226,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn);
 bool decode_64bit_enabled(DisasContext *ctx);
 
 /* decodetree generated */
+bool decode_isa_micromips16(DisasContext *ctx, uint16_t insn);
+bool decode_isa_micromips32(DisasContext *ctx, uint32_t insn);
+bool decode_isa_micromips32_r6(DisasContext *ctx, uint32_t insn);
 bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
 bool decode_ase_mips16e_16(DisasContext *ctx, uint16_t insn);
 bool decode_ase_mips16e_32(DisasContext *ctx, uint32_t insn);
diff --git a/target/mips/tcg/micromips16.decode b/target/mips/tcg/micromips16.decode
new file mode 100644
index 000000000000..4b1f04299132
--- /dev/null
+++ b/target/mips/tcg/micromips16.decode
@@ -0,0 +1,11 @@
+# microMIPS32 16-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS Architecture for Programmers, Volume II-B
+#            microMIPS32 Instruction Set
+#            (Document Number: MD00582)
+#            microMIPS64 Instruction Set
+#            (Document Number: MD00594)
diff --git a/target/mips/tcg/micromips32.decode b/target/mips/tcg/micromips32.decode
new file mode 100644
index 000000000000..d7668181a100
--- /dev/null
+++ b/target/mips/tcg/micromips32.decode
@@ -0,0 +1,11 @@
+# microMIPS32 32-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS Architecture for Programmers, Volume II-B
+#            microMIPS32 Instruction Set
+#            (Document Number: MD00582)
+#            microMIPS64 Instruction Set
+#            (Document Number: MD00594)
diff --git a/target/mips/tcg/micromips32_r6.decode b/target/mips/tcg/micromips32_r6.decode
new file mode 100644
index 000000000000..5786947c7c96
--- /dev/null
+++ b/target/mips/tcg/micromips32_r6.decode
@@ -0,0 +1,11 @@
+# microMIPS32 Release 6 32-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS Architecture for Programmers, Volume II-B
+#            microMIPS32 Instruction Set
+#            (Document Number: MD00582)
+#            microMIPS64 Instruction Set
+#            (Document Number: MD00594)
diff --git a/target/mips/tcg/micromips_translate.c b/target/mips/tcg/micromips_translate.c
new file mode 100644
index 000000000000..b30c0119996c
--- /dev/null
+++ b/target/mips/tcg/micromips_translate.c
@@ -0,0 +1,15 @@
+/*
+ * MIPS emulation for QEMU - microMIPS translation routines
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
+#include "decode-micromips16.c.inc"
+#include "decode-micromips32.c.inc"
+#include "decode-micromips32_r6.c.inc"
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 40ffb1a71d30..7528591b1ab4 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -3026,6 +3026,23 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
         return 2;
     }
 
+    if (is_16bit) {
+        if (decode_isa_micromips16(ctx, opcode)) {
+            return 2;
+        }
+    } else {
+        opcode <<= 16;
+        opcode |= translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 2,
+                                      mo_endian(ctx));
+        if (cpu_supports_isa(env, ISA_MIPS_R6)
+            && decode_isa_micromips32_r6(ctx, opcode)) {
+            return 4;
+        }
+        if (decode_isa_micromips32(ctx, opcode)) {
+            return 4;
+        }
+    }
+
     switch (op) {
     case POOL16A:
         {
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index 7715b029f90d..d7ae95b70f56 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -1,6 +1,9 @@
 gen = [
   decodetree.process('mips16e_16.decode', extra_args: ['--decode=decode_ase_mips16e_16', '--insnwidth=16']),
   decodetree.process('mips16e_32.decode', extra_args: ['--decode=decode_ase_mips16e_32']),
+  decodetree.process('micromips16.decode', extra_args: ['--decode=decode_isa_micromips16', '--insnwidth=16']),
+  decodetree.process('micromips32.decode', extra_args: ['--decode=decode_isa_micromips32']),
+  decodetree.process('micromips32_r6.decode', extra_args: ['--decode=decode_isa_micromips32_r6']),
   decodetree.process('rel6.decode', extra_args: ['--decode=decode_isa_rel6']),
   decodetree.process('msa.decode', extra_args: '--decode=decode_ase_msa'),
   decodetree.process('tx79.decode', extra_args: '--static-decode=decode_tx79'),
@@ -18,6 +21,7 @@ mips_ss.add(files(
   'fpu_helper.c',
   'ldst_helper.c',
   'lmmi_helper.c',
+  'micromips_translate.c',
   'mips16e_translate.c',
   'msa_helper.c',
   'msa_translate.c',
-- 
2.55.0


