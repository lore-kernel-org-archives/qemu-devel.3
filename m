Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86244C4829D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 04:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra6rx-0007nc-KB; Tue, 13 Feb 2024 23:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ra6rw-0007n7-AZ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:27:36 -0500
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ra6ru-0004Pz-OR
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:27:36 -0500
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7ba9f1cfe94so12651039f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 20:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707884853; x=1708489653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZZzFWXgHBt0MgJ93ILIs6n/MLVvULr7mA7GxBXHlM0=;
 b=B9km8a76j8oAXv0NVA6h5fKL2SM3m09gzGSMLHoiNJ1sdc4h5ub6BKHsi5hRhtbB7H
 F/vKY+GIkZIb+mwkj9bE0EN6K6Uq5MjVIDD0CRcum2IhIf3Aij2eXExHPAlHvTgJvEao
 5A/twB8jAxDtsk5wgbAVKIIzmUV3VcWZ0dCUfufGGHVFFbKxOHFTIa7Q3BtQOcfu+/+k
 xfcq/3zlec8E0xm1ITYftLLcNp0p8Lu18Hf0Xw5lROLw8xW+KBs5x2rQx1lB55jFdxFm
 x7qBfV1f3o7uvctfJsVu72hcPND9p6RMUVG8fqTXGRpkyUb8GjFTl01A6hAWM2OiLpPb
 rbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707884853; x=1708489653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xZZzFWXgHBt0MgJ93ILIs6n/MLVvULr7mA7GxBXHlM0=;
 b=SATcKitzUdTQkE7pL4oaAepdZqi3FWUIugY6Y/CYFpGagAwkpvi2joNDOCn+YvwUM8
 ucv9YM18lUslKcCtFZluL1ju66TPROPwAm989qVxqBLmEQbPMsobos4dGWoR5xZms5Sn
 GwHvwwhJPSJ1cGS6NAt6H0q9SeVJq9M1oHiwMHqe1HEO6m28q1zWFfVfPdglOwSu5Q9j
 NXSVGCe3PmgAmNVHi/Zm0wdm4NWdY1dWbczBfPb4XJ6NbKOgyLbGvO95u06Yzw9DCDjq
 nNqIS4sWjW9wMIoi9jYssO1ESC3ujRiRVhAPVaEkkAiKsKvgLbUWjoBkyDw5FSqCThVa
 69DA==
X-Gm-Message-State: AOJu0YymkMe+E5rFPFcT8sOZ3c7U0xzrI320Bx5GMknwLDSrhhMdFPM0
 3e+ipd0IeowWcq3vE1yZBwcvp5RCimf0zyqt+MOAZvdD/iglE8AUWfoF0SD2GQI=
X-Google-Smtp-Source: AGHT+IGFeqOHIHkTheIcnBwHKsulX3hfMJ2EWX15SCQFDhCFjCpTNihSmSHwQKBFP1y+fRgUX4zixg==
X-Received: by 2002:a6b:cd0c:0:b0:7c4:89b2:8084 with SMTP id
 d12-20020a6bcd0c000000b007c489b28084mr32174iog.1.1707884852789; 
 Tue, 13 Feb 2024 20:27:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXgDh9vod6XI6oGBQJMOJEucDm/aoByCnH++SXD23ifVsmUEu5IDkTLI2k1EXiyjTatrZsSrszHgdDrGVMtH+2+Ru75ix7uEvdJMPrqPJ4cvq3w45A8yxb1OqBvB5d7pAh/5p5qT04ui5xnt8fmZsNahUltisaqxU+fKIxzi2ZpG2N2hMmw9gmfXHvMajoFvgi6BQQ0W1wAHdUNlbcuUIbDfFCqFuFjuARzf24Pnb9CSXjDYnc+xaGXP1J130LZ1ibbFIFmUDEnRa0DIhRARBSI9cJogMSoCRCg/HWd
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a02c9c2000000b004713170def2sm2312305jap.93.2024.02.13.20.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 20:27:31 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 3/3] Hexagon (target/hexagon) Only pass env to generated
 helper when needed
Date: Tue, 13 Feb 2024 21:27:26 -0700
Message-Id: <20240214042726.19290-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214042726.19290-1-ltaylorsimpson@gmail.com>
References: <20240214042726.19290-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently, we pass env to every generated helper.  When the semantics of
the instruction only depend on the arguments, this is unnecessary and
adds extra overhead to the helper call.

We add the TCG_CALL_NO_RWG_SE flag to any non-HVX helpers that don't get
the ptr to env.

The A2_nop and SA1_setin1 instructions end up with no arguments.  This
results in a "old-style function definition" error from the compiler, so
we write overrides for them.

With this change, the number of helpers with env argument is
    idef-parser enabled:    329 total, 23 with env
    idef-parser disabled:   1543 total, 550 with env

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Tested-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/gen_tcg.h            |  5 ++++-
 target/hexagon/gen_helper_protos.py | 12 ++++++++++--
 target/hexagon/hex_common.py        | 23 ++++++++++++++++++-----
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 1c4391b415..3fc1f4e281 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -1369,3 +1369,6 @@
         gen_helper_raise_exception(tcg_env, excp); \
     } while (0)
 #endif
+
+#define fGEN_TCG_A2_nop(SHORTCODE) do { } while (0)
+#define fGEN_TCG_SA1_setin1(SHORTCODE) tcg_gen_movi_tl(RdV, -1)
diff --git a/target/hexagon/gen_helper_protos.py b/target/hexagon/gen_helper_protos.py
index c82b0f54e4..f8578d5033 100755
--- a/target/hexagon/gen_helper_protos.py
+++ b/target/hexagon/gen_helper_protos.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -40,7 +40,15 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
         declared.append(arg.proto_arg)
 
     arguments = ", ".join(declared)
-    f.write(f"DEF_HELPER_{len(declared) - 1}({tag}, {arguments})\n")
+
+    ## Add the TCG_CALL_NO_RWG_SE flag to helpers that don't take the env
+    ## argument and aren't HVX instructions.  Since HVX instructions take
+    ## pointers to their arguments, they will have side effects.
+    if hex_common.need_env(tag) or hex_common.is_hvx_insn(tag):
+        f.write(f"DEF_HELPER_{len(declared) - 1}({tag}, {arguments})\n")
+    else:
+        f.write(f"DEF_HELPER_FLAGS_{len(declared) - 1}({tag}, "
+                f"TCG_CALL_NO_RWG_SE, {arguments})\n")
 
 
 def main():
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index b96f67972d..d3d8560fcf 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -206,6 +206,18 @@ def need_sp(tag):
     return "A_IMPLICIT_READS_SP" in attribdict[tag]
 
 
+def is_hvx_insn(tag):
+    return "A_CVI" in attribdict[tag]
+
+
+def need_env(tag):
+    return ("A_STORE" in attribdict[tag] or
+            "A_LOAD" in attribdict[tag] or
+            "A_CVI_GATHER" in attribdict[tag] or
+            "A_CVI_SCATTER" in attribdict[tag] or
+            "A_IMPLICIT_WRITES_USR" in attribdict[tag])
+
+
 def need_slot(tag):
     if (
         "A_CVI_SCATTER" not in attribdict[tag]
@@ -1069,11 +1081,12 @@ def helper_args(tag, regs, imms):
     args = []
 
     ## First argument is the CPU state
-    args.append(HelperArg(
-        "env",
-        "tcg_env",
-        "CPUHexagonState *env"
-    ))
+    if need_env(tag):
+        args.append(HelperArg(
+            "env",
+            "tcg_env",
+            "CPUHexagonState *env"
+        ))
 
     ## For predicated instructions, we pass in the destination register
     if is_predicated(tag):
-- 
2.34.1


