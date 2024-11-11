Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFFFD3ABFD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 22:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAd9j-000661-6c; Mon, 11 Nov 2024 17:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAd9f-00063z-KB
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:45:07 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAd9d-0008Rl-0w
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:45:06 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so40604595e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 14:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731365100; x=1731969900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Av27Bjt8cybhsQ4Vyiv9pdkNpya1Ty2tMw+JzIarjo=;
 b=gUZrE9VoAQBKWv1BVBya8gg5yKfG8L/Y89E1TFqfGacaieOoAaHEm0tiv7LBpcifyn
 uWj/ujweAbd7e/tKokgE4Po7ajMW/wOFLig2h2n6R9OSJRETih0wOl4fxEOHeEr2fg9j
 MnCCCs2f1Z1n0uNvYMNr08b2diFQ6kr6i5g24tFvhUeQ4WY1C5b2nQoJH5+Ii1+4L1+z
 DPh4aDWsvp0iE885Hl6AxgvxhoIj4PKnJaZdVUAfjy7l/DOd0xaJSr87z301DvnOJ7S1
 RQXeE/ncv68ZV92nf7fanEy/LDgNMRrXi2Cnm2si38nOnzyw3FNKOVhccHnt/ZqTZH72
 lMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731365100; x=1731969900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Av27Bjt8cybhsQ4Vyiv9pdkNpya1Ty2tMw+JzIarjo=;
 b=ftFV3YwKCowtWo//rVkajTf0tX94HqlIhFVmtupLzbgio6YCvV9fseZ+QhD63bPgcJ
 wy6RtyrkP9aRLl2jt3EvbY7KH4lkv73JZoSBMW6IpcemhjNo9oar+BTYOpPeA/pNz+8R
 4MRWfWIyT3MZJz0f1UVE+iHqOR/MfMH9ZIaSd/biS5z8/esueMf79jMw8leZdT9CeHlX
 K4nS0swdDfX8OOK16bXG/Sa4Bik1O+u9ScF8+0hErx+QZ0s81UwCeKjBy61l6ejmoy1+
 LsaD0x1Ql/9zcnH500aAmCNPOx+T4fE1+QMsmX/WjnqhCpXcqFbfUc7zY2RzVo7sYMDE
 T+mA==
X-Gm-Message-State: AOJu0YyoNxkLMJU9yiztBSMhM46OdygadUyNa8D/23C+ffPuym5/hzAm
 IhWtEMqbBzYziMz+eytb4SDQAtmfcarJzpNtD5Dbm3x0l+cxQ8MOyEQsymLBAT5pJuO3wBBcxxV
 u
X-Google-Smtp-Source: AGHT+IGeGZugQaBArXVCl9MMnaTVGCjiANOqdxOhD23KuUAQMwJffltYx5q5WkOVu2sBzgRUtX3zlQ==
X-Received: by 2002:a05:6000:1547:b0:374:c8e5:d568 with SMTP id
 ffacd0b85a97d-382081245e6mr190223f8f.29.1731365100587; 
 Mon, 11 Nov 2024 14:45:00 -0800 (PST)
Received: from localhost.localdomain
 (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr. [176.184.43.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5e56sm231254545e9.2.2024.11.11.14.44.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Nov 2024 14:45:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH 1/2] target/mips: Introduce decode tree bindings for nanoMIPS
 ISA
Date: Mon, 11 Nov 2024 23:44:51 +0100
Message-ID: <20241111224452.61276-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111224452.61276-1-philmd@linaro.org>
References: <20241111224452.61276-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
index a65ab4a747..f93bceb82a 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -222,6 +222,8 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn);
 bool decode_64bit_enabled(DisasContext *ctx);
 
 /* decodetree generated */
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
index 7b18e6c4c8..c05f3c0649 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -1,5 +1,7 @@
 gen = [
   decodetree.process('rel6.decode', extra_args: ['--decode=decode_isa_rel6']),
+  decodetree.process('nanomips16.decode', extra_args: ['--decode=decode_isa_nanomips16', '--insnwidth=16']),
+  decodetree.process('nanomips32.decode', extra_args: ['--decode=decode_isa_nanomips32']),
   decodetree.process('msa.decode', extra_args: '--decode=decode_ase_msa'),
   decodetree.process('tx79.decode', extra_args: '--static-decode=decode_tx79'),
   decodetree.process('vr54xx.decode', extra_args: '--decode=decode_ext_vr54xx'),
@@ -18,6 +20,7 @@ mips_ss.add(files(
   'lmmi_helper.c',
   'msa_helper.c',
   'msa_translate.c',
+  'nanomips_translate.c',
   'op_helper.c',
   'rel6_translate.c',
   'translate.c',
-- 
2.45.2


