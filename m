Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85313D42BB6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuZF-0003GP-QZ; Tue, 12 Nov 2024 12:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZB-0003FU-E9
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:20:37 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZ7-0003hb-Kv
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:20:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4319399a411so56459555e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 09:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731432031; x=1732036831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YFVkGXPUlThiD5pzlhxgmCFBmWmFouX3sMfYVHk+NQc=;
 b=TWrdGYjVHt+0MouA8p2tEn+S7Byl6Ey6KJELQYfGM4aoE1whUvyGEA2o0233hTX6w8
 NVdc8Kok+WlkTk11UQ/GUi6tkQwgEMRS3gRF83b+jr5oXmMTmM1T+QsBNdWehkL6v+5a
 Db576SzlQ/wcvJoGpELurR4HM/sa3ciXe80JfxqfoOVQglA1DGmlEUNOOsW6vX1GWxU3
 wBlLRAYsIqvKz0FRnoDoy/Dr4gKbbfdzBdSZgcZuFIImOVD6Q99stA+ayoTkMhjbsrZe
 SlxFObE4p2FfRDiwGl7PZBsiJRg++xmD6a5Xz4uOybuoP3KKAaNS6qSqNA8Kd1563qVc
 M/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731432031; x=1732036831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YFVkGXPUlThiD5pzlhxgmCFBmWmFouX3sMfYVHk+NQc=;
 b=XzVwzGE5aSazpavlbeRwE8jrvDEA05z8LeccoR0/OEC+OJvi48/Ejba2SNW21xi9xV
 eQq9maftwsGpjH/tcupDrVbdZDHe7aChuxC3S+8j/R5zVVL79EfHvZTggRDAyYmz2UVv
 Y0hIPsPKGedQHYl7LqpScjNkRHOaDtd4qa/aP8Yn1HUV3HoKvE1n5Dz6/7XHxH/VzfnF
 BellJW9enuTyAJkeL1GicHQz1JfsgMyQ8B2bzHpaqm2c9umDt+iYPOTnXMMyWjzBlHuY
 1sTVR5Xe3S1xH0ygpLTjwbhR5+raVlAdKNvPjpVMCqt6cYNdZOwieeKFYERnEoN9IblA
 6Vog==
X-Gm-Message-State: AOJu0Ywjrn9OwSpgN1sMEyWaxhxwsFXfpQmvWVwQDBZN4Qrk2Plpp5RK
 KACmyTxMz41rRHUeNtbTabP7ZPYvqzjfQpgKssjv4DfJA69wlYut1qSHHzpEIV9ftxGiRT8gpXt
 Z
X-Google-Smtp-Source: AGHT+IGS510vuWmuTuxYsaoiRAsWd3JOclltR5V0xdf/hjUkVF0OLTNEtRRnDQCQRAyD2KKEhuYgGg==
X-Received: by 2002:a5d:64c9:0:b0:37d:890c:63e4 with SMTP id
 ffacd0b85a97d-381f188c859mr14729106f8f.55.1731432030947; 
 Tue, 12 Nov 2024 09:20:30 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6bee9asm259559555e9.19.2024.11.12.09.20.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 09:20:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v2 1/6] target/mips: Introduce decode tree bindings for
 microMIPS ISA
Date: Tue, 12 Nov 2024 18:20:17 +0100
Message-ID: <20241112172022.88348-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112172022.88348-1-philmd@linaro.org>
References: <20241112172022.88348-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Introduce the microMIPS decodetree configs for the 16-bit
and 32-bit instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h               |  2 ++
 target/mips/tcg/micromips16.decode        |  9 +++++++++
 target/mips/tcg/micromips32.decode        |  9 +++++++++
 target/mips/tcg/micromips_translate.c     | 14 ++++++++++++++
 target/mips/tcg/micromips_translate.c.inc |  6 ++++++
 target/mips/tcg/meson.build               |  3 +++
 6 files changed, 43 insertions(+)
 create mode 100644 target/mips/tcg/micromips16.decode
 create mode 100644 target/mips/tcg/micromips32.decode
 create mode 100644 target/mips/tcg/micromips_translate.c

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index a65ab4a747..816453f2be 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -222,6 +222,8 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn);
 bool decode_64bit_enabled(DisasContext *ctx);
 
 /* decodetree generated */
+bool decode_isa_micromips16(DisasContext *ctx, uint16_t insn);
+bool decode_isa_micromips32(DisasContext *ctx, uint32_t insn);
 bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
 bool decode_ase_msa(DisasContext *ctx, uint32_t insn);
 bool decode_ext_txx9(DisasContext *ctx, uint32_t insn);
diff --git a/target/mips/tcg/micromips16.decode b/target/mips/tcg/micromips16.decode
new file mode 100644
index 0000000000..207e9c69f9
--- /dev/null
+++ b/target/mips/tcg/micromips16.decode
@@ -0,0 +1,9 @@
+# microMIPS32 16-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: MIPS Architecture for Programmers, Volume II-B
+#            microMIPS32 Instruction Set
+#            (Document Number: MD00582)
diff --git a/target/mips/tcg/micromips32.decode b/target/mips/tcg/micromips32.decode
new file mode 100644
index 0000000000..c115ed2eab
--- /dev/null
+++ b/target/mips/tcg/micromips32.decode
@@ -0,0 +1,9 @@
+# microMIPS32 32-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: MIPS Architecture for Programmers, Volume II-B
+#            microMIPS32 Instruction Set
+#            (Document Number: MD00582)
diff --git a/target/mips/tcg/micromips_translate.c b/target/mips/tcg/micromips_translate.c
new file mode 100644
index 0000000000..49e90e7eca
--- /dev/null
+++ b/target/mips/tcg/micromips_translate.c
@@ -0,0 +1,14 @@
+/*
+ * MIPS emulation for QEMU - microMIPS translation routines
+ *
+ * Copyright (c) 2021 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "translate.h"
+
+/* Include the auto-generated decoders.  */
+#include "decode-micromips16.c.inc"
+#include "decode-micromips32.c.inc"
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index c479bec108..f504e15fa7 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -3000,6 +3000,9 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
                 gen_reserved_instruction(ctx);
                 return 2;
             }
+            if (decode_isa_micromips32(ctx, ctx->opcode)) {
+                return 4;
+            }
             break;
         case 1:
         /* POOL16A, POOL16B, POOL16C, LWGP16, POOL16F */
@@ -3011,6 +3014,9 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
                 gen_reserved_instruction(ctx);
                 return 2;
             }
+            if (decode_isa_micromips16(ctx, ctx->opcode)) {
+                return 2;
+            }
             break;
         }
     }
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index 7b18e6c4c8..5db5681eb1 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -1,4 +1,6 @@
 gen = [
+  decodetree.process('micromips16.decode', extra_args: ['--decode=decode_isa_micromips16', '--insnwidth=16']),
+  decodetree.process('micromips32.decode', extra_args: ['--decode=decode_isa_micromips32']),
   decodetree.process('rel6.decode', extra_args: ['--decode=decode_isa_rel6']),
   decodetree.process('msa.decode', extra_args: '--decode=decode_ase_msa'),
   decodetree.process('tx79.decode', extra_args: '--static-decode=decode_tx79'),
@@ -16,6 +18,7 @@ mips_ss.add(files(
   'fpu_helper.c',
   'ldst_helper.c',
   'lmmi_helper.c',
+  'micromips_translate.c',
   'msa_helper.c',
   'msa_translate.c',
   'op_helper.c',
-- 
2.45.2


