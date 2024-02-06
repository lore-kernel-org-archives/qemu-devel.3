Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEA0C48260
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 00:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX9fm-0008Bk-H7; Mon, 05 Feb 2024 19:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rX9fl-0008BY-2O
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:50:49 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rX9fj-0000MP-9N
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:50:48 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-363cdbd584eso3355045ab.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 16:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707180645; x=1707785445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5zixAlF4wZ6FLSTr9hS2N8Z0evbTrh/CxGYDAI0MKE=;
 b=aCU//OuklJHAoe0pAz2hQhs8bXV0j6g8yX4bL6zsobFXHJsbrEDVycsYpoQm+qJiL/
 G7bBRAR7IZ6fUR0hwrMIMesGp70//QTlf8Tp1BI0r4bU/Fp09UPMQI5Q6n1KRsYL9NMK
 xoivR+HVfAuvZCJEoCUQhwEttYO/4+P7kv33YgKGuvnu51aZLM6Gx6fo4kuyHZUIvGoi
 aBPjuao+h/4H4Ii89o/qjyfzzbGq35+pY6dy8hwySAMSx7LagI76nUhqbRfE2USzZisQ
 99HAqckEWAQ/bJ7e6yxCByiAZPhSrRGSsAD82fLBw1An7yx/ysPNU+tU6/C/pM8366UP
 sN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707180645; x=1707785445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5zixAlF4wZ6FLSTr9hS2N8Z0evbTrh/CxGYDAI0MKE=;
 b=gfIbPvIwMZHYzXlD9G6tsXssVbnFBkLdG77XggbY99qWz83Hjjzjbe7geAf3GvW9qU
 0zLQO5aazP99nYSpLFoPBLnqUX92osYs4KaB9rNkKdtgC2eokMnDPRX7RXHJuV1A6Gcm
 m49iJ5MuGvJLMdU+TGiecQG11fEZkZRURhyYbIH0JhWcHRQbdL6cLG0TxyM8f5y+BbCl
 liU3cxoQuGp6O3u5DJDDEDhBEghjkMSA3lN9/MCNtNpHwJsKI8uDXyms9Tj07vJjTi85
 bMcruv8BqH+jcouw52hamu2mL0wsNa0gwIVKeL5O4ChnCIZJFaZnq580oNjpBggGM0i6
 eViA==
X-Gm-Message-State: AOJu0YzN76+LlAxHuB9MWGMX6wiGTq/Q4VPltiQYyU9IAtMi1JSnhy+x
 VKXgkJ6LW0y+jx77xXqoV2shz6XIkE5jexCwCmyCA3I/iyWntC+Dtb0YZQy4Ghw=
X-Google-Smtp-Source: AGHT+IEISFLpty9naf6ZLEqQhCvliwaUFcWUGiW6qTz5b7eqtQ1ISLxAMUTMKSJT0cE5cKJBmS5hFg==
X-Received: by 2002:a92:d6cc:0:b0:363:bfc7:74b1 with SMTP id
 z12-20020a92d6cc000000b00363bfc774b1mr1309408ilp.32.1707180640120; 
 Mon, 05 Feb 2024 16:50:40 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW65dofP5CJrXYFRlXsf7zFuI6CLu1m2WZvrLIr4gKYVu3QXdzBC3neVb6o6lKqL0GJ65pbqecjNhX937sdpXwRRYjbZdaF+9AE0etnrcRzszPUOymOFVBAvvvldODCHhvxJre8Jxj8WFdJlh6DOzonngBMSOkuxf/zCC/nXSUVKjtlch4GANqxbMbUSzff1l5C6+k4Zb3nUJ4INzwZwdcoJyeMcJ6ftt3qnmm6jt4NBi4P6RUJqCCF5SZESCF368uBBkp2pTo2Glb6jUVfdXjZEm+WxnCBAoPLx516
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a02a408000000b0046e2ce45dafsm245840jal.165.2024.02.05.16.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 16:50:39 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 3/3] Hexagon (target/hexagon) Only pass env to generated
 helper when needed
Date: Mon,  5 Feb 2024 17:50:34 -0700
Message-Id: <20240206005034.267283-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206005034.267283-1-ltaylorsimpson@gmail.com>
References: <20240206005034.267283-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12c.google.com
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
---
 target/hexagon/gen_tcg.h            |  3 +++
 target/hexagon/gen_helper_protos.py | 10 +++++++++-
 target/hexagon/hex_common.py        | 23 ++++++++++++++++++-----
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 1c4391b415..e9ac2e3fe0 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -1369,3 +1369,6 @@
         gen_helper_raise_exception(tcg_env, excp); \
     } while (0)
 #endif
+
+#define fGEN_TCG_A2_nop(SHORTCODE) do { } while (0)
+#define fGEN_TCG_SA1_setin1(SHORTCODE) tcg_gen_movi_tl(RdV, -1)
diff --git a/target/hexagon/gen_helper_protos.py b/target/hexagon/gen_helper_protos.py
index c82b0f54e4..6e98429752 100755
--- a/target/hexagon/gen_helper_protos.py
+++ b/target/hexagon/gen_helper_protos.py
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
index eb28aa98fe..ee08195aba 100755
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


