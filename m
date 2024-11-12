Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BD1D42BB5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuZH-0003Gj-Uo; Tue, 12 Nov 2024 12:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZF-0003GM-Ce
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:20:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZD-0003iJ-O5
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:20:41 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso52733535e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 09:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731432037; x=1732036837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OZAjdiF+IZHqejHSQfF1+0YI+1SBj9mTB6uv3MpehI=;
 b=KdGjJjxmjOMdsUqSqbrEYVIJh5dsTRs5vyh+xzubv66q4aP6pIZ8zqYuAAHUSl8d8g
 rF32jNObZVRbY5eWHfdz/k9jQtxMidRnHbALPBRdWoZUcSP+Iv4AcIvKWqaKsqLS8vwW
 fPzd8v7RHO6WjwS0yxsby7N6i5IRCifXA+YWPY9tzAbCKK4Ocl9Me9hJY5MX+KQNXd15
 THeAkYN8NNAJjWSmRDA3/RiZehgQV9WqBSZ3AT4mNvUo7mQK8bt9gHYIVzwohrvCPUp3
 SzY+FE/KOXItPp2Ljwb7Q1yoChPZfj5+jXoIbJOHMngtJRvCLvcnIznUU4APp5GZG7n0
 npjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731432037; x=1732036837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3OZAjdiF+IZHqejHSQfF1+0YI+1SBj9mTB6uv3MpehI=;
 b=N3Oms3+5j0UfAMUA0LBHSMB8Px+9VhCgNxb5v7NRxeFIW0Sh+ZawTD4ncazGLoMZbn
 j6fn6ZbMzWGNGyw1Vz/3DAURuHuqNdugXRUYHyshi2vZXyddYOMOoeUC2iOve8+FPZep
 8gu3yakTPZeQQjCGVzlk+YtAdh7B+WCC5tB55jN43g4GVTvSuAqO4AXup7XWd/ECXWsJ
 yXNi1uHNSZjkc/QfE2rbpQ/jXKdxwMYnLnZ86uPoLeTv8pQnWEsqqrysJoZmLYavswn0
 AyUE5krpXIHVdcolxqeRkd2v+b1upo4S80Thdna1pgnZGChUa3fOEkSoZdpMse31ru9r
 NPjg==
X-Gm-Message-State: AOJu0Yz4J4kyfdytsaki6gujxX13Qq/J+mwS695vnXAcyEGk9GYnPzJV
 OSKNl40fMzzqkBAhtVUzVmV3/9zGAs9/Wsy5vta5qdidTIdvpOEEPh/0LMeMo/ezMIA7oix0UGD
 F
X-Google-Smtp-Source: AGHT+IHgl+OT9L+nCpF+45zQQHAurKifqjAJCfo7/IsXMKkNglsxc2ksija2GvbvwngYnjkcEf0i0w==
X-Received: by 2002:a05:600c:1d0e:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-432b7517ac2mr134836165e9.20.1731432036668; 
 Tue, 12 Nov 2024 09:20:36 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05c0d33sm220339195e9.27.2024.11.12.09.20.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 09:20:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/6] target/mips: Introduce decode tree bindings for
 nanoMIPS ISA
Date: Tue, 12 Nov 2024 18:20:18 +0100
Message-ID: <20241112172022.88348-3-philmd@linaro.org>
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

Introduce the nanoMIPS decodetree configs for the 16-bit
and 32-bit instructions.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h              |  2 ++
 target/mips/tcg/nanomips16.decode        |  8 ++++++++
 target/mips/tcg/nanomips32.decode        |  8 ++++++++
 target/mips/tcg/nanomips_translate.c     | 14 ++++++++++++++
 target/mips/tcg/nanomips_translate.c.inc |  7 +++++++
 target/mips/tcg/meson.build              |  3 +++
 6 files changed, 42 insertions(+)
 create mode 100644 target/mips/tcg/nanomips16.decode
 create mode 100644 target/mips/tcg/nanomips32.decode
 create mode 100644 target/mips/tcg/nanomips_translate.c

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 816453f2be..a91c003f96 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -224,6 +224,8 @@ bool decode_64bit_enabled(DisasContext *ctx);
 /* decodetree generated */
 bool decode_isa_micromips16(DisasContext *ctx, uint16_t insn);
 bool decode_isa_micromips32(DisasContext *ctx, uint32_t insn);
+bool decode_isa_nanomips16(DisasContext *ctx, uint16_t insn);
+bool decode_isa_nanomips32(DisasContext *ctx, uint32_t insn);
 bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
 bool decode_ase_msa(DisasContext *ctx, uint32_t insn);
 bool decode_ext_txx9(DisasContext *ctx, uint32_t insn);
diff --git a/target/mips/tcg/nanomips16.decode b/target/mips/tcg/nanomips16.decode
new file mode 100644
index 0000000000..81fdc68e98
--- /dev/null
+++ b/target/mips/tcg/nanomips16.decode
@@ -0,0 +1,8 @@
+# nanoMIPS32 16-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: nanoMIPS32 Instruction Set Technical Reference Manual
+#            (Document Number: MD01247)
diff --git a/target/mips/tcg/nanomips32.decode b/target/mips/tcg/nanomips32.decode
new file mode 100644
index 0000000000..9cecf1e13d
--- /dev/null
+++ b/target/mips/tcg/nanomips32.decode
@@ -0,0 +1,8 @@
+# nanoMIPS32 32-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: nanoMIPS32 Instruction Set Technical Reference Manual
+#            (Document Number: MD01247)
diff --git a/target/mips/tcg/nanomips_translate.c b/target/mips/tcg/nanomips_translate.c
new file mode 100644
index 0000000000..c148c13ed9
--- /dev/null
+++ b/target/mips/tcg/nanomips_translate.c
@@ -0,0 +1,14 @@
+/*
+ * MIPS emulation for QEMU - nanoMIPS translation routines
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
+#include "decode-nanomips16.c.inc"
+#include "decode-nanomips32.c.inc"
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 1e274143bb..e401b92bfd 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4482,6 +4482,13 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
         return 2;
     }
 
+    if (decode_isa_nanomips16(ctx, ctx->opcode)) {
+        return 2;
+    }
+    if (decode_isa_nanomips32(ctx, ctx->opcode)) {
+        return 4;
+    }
+
     op = extract32(ctx->opcode, 10, 6);
     switch (op) {
     case NM_P16_MV:
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index 5db5681eb1..f815174ed1 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -2,6 +2,8 @@ gen = [
   decodetree.process('micromips16.decode', extra_args: ['--decode=decode_isa_micromips16', '--insnwidth=16']),
   decodetree.process('micromips32.decode', extra_args: ['--decode=decode_isa_micromips32']),
   decodetree.process('rel6.decode', extra_args: ['--decode=decode_isa_rel6']),
+  decodetree.process('nanomips16.decode', extra_args: ['--decode=decode_isa_nanomips16', '--insnwidth=16']),
+  decodetree.process('nanomips32.decode', extra_args: ['--decode=decode_isa_nanomips32']),
   decodetree.process('msa.decode', extra_args: '--decode=decode_ase_msa'),
   decodetree.process('tx79.decode', extra_args: '--static-decode=decode_tx79'),
   decodetree.process('vr54xx.decode', extra_args: '--decode=decode_ext_vr54xx'),
@@ -21,6 +23,7 @@ mips_ss.add(files(
   'micromips_translate.c',
   'msa_helper.c',
   'msa_translate.c',
+  'nanomips_translate.c',
   'op_helper.c',
   'rel6_translate.c',
   'translate.c',
-- 
2.45.2


