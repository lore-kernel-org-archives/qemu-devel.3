Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B4AC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVUOG-0003ia-25; Thu, 01 Feb 2024 05:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rVUOC-0003hg-MQ
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:33:49 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rVUO9-0004ps-J5
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:33:48 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3638e3ace68so2849805ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 02:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706783623; x=1707388423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFcNQALLp828WUobDdICu7UURWQLSRkGcGCql/AlsZ8=;
 b=P7dq2QVnG8mNlOJdbdTfdI3UUWuPhbZnMw27ngKLPidsHe33qpOJ6dBOe2kLbA3O2H
 2/fOFrWRG6JGfoHSYW4sasHHY2pC424UghC2r713nwhikRnA8ibxsaYGjAN3uGOsNo+w
 h4s3qIldN7uIfmap5aHPqu5tod95xJvTho2Z2KIX7VZytnAHUrAWV2pUrqE8tlr5RhyP
 uCsZ7lKm5CXasYdasuERHPnDR0fmctvX6/1NSPS32OHpLoFoxAjLSCVeuAdT2VHxUViD
 srtQR2OoD8w5+1GPZnPq1Wcsmz78aJEbFmOG1/cYT0M8QcQi/IP3V5C/U8t2GbdKFzop
 1CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706783623; x=1707388423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFcNQALLp828WUobDdICu7UURWQLSRkGcGCql/AlsZ8=;
 b=RMVuOMRZ1HTJU6AkuQDZU2azrimr9FQ5IFu2aLlpCXMoVsRdVLqDqx6+7XE80MCrZ5
 U3aJE+upncbu1+hGOqwCG+iexjOQuj6pdb7rWc+/0qhpWYzKOuNwxm5ljfd4rNr68kEA
 W6c/nddstHoE7UgYWwN3qgh3s3Q2EIMaeaVyNI0+VQbMtCS59s9IbGEvchaN8GZqEamS
 PCoYjN+ARVb3y2aylpWPjYnCz6l78M2i9KnF7HgP8JKO7IiHASpy9bpjqy0xVancyNiJ
 HgwSk2rXmIjCaoA8QnP5y14c2Yx4vAFWhmQDQK9LMxS+V2qa1HUKZwTIsN6MlgafEhhp
 PO9A==
X-Gm-Message-State: AOJu0YyV+R1yntZpwDQHW6OW8NjePj4WEcColqJtz6WysNUyaCuYNvee
 ePssEw75pH0Zme0K8GwXVPg/3Ytiot531yluzX5Z9UaboRM1JCfdEQ8ob+pGC8E=
X-Google-Smtp-Source: AGHT+IHbwNqUD3hP0AqE9UAktNEGUrE7p7Fw0jgqVnYZo4ZgjzuQ8jDrwN4VkXWyooPXKk+SUkoKqg==
X-Received: by 2002:a92:d64a:0:b0:363:a47b:7b95 with SMTP id
 x10-20020a92d64a000000b00363a47b7b95mr736543ilp.5.1706783623226; 
 Thu, 01 Feb 2024 02:33:43 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXTFnJK3VOmWhpyJ3LIjVfKIPEz9eYLrkgkclaxsLzr+Xo5QpmnKYjLbuXQpGiuYViJkmxfPAZZYsYElePHYKylftCqN121+XXzcwZeJ2ojFxV4sVeQtzWe3AAqLBx0FWxn5DqUhMXq/vwlq49y60cLKykyWfHJ7RcAC5ZqXTJiEiEKK4a3eaQuOoe2OuEZXsqUyRJymaDXEcuLfJdpQrG1KRy1pixng5z0T5f4hSZXI3g0f34llbkNtJvsG2tm4qINowAgGY/0Snxrqob30XdLONXBDEQwtX3ilOc6
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a92c003000000b00361b6a1e6aasm3152089ild.87.2024.02.01.02.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 02:33:42 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 1/3] Hexagon (target/hexagon) Analyze reads before writes
Date: Thu,  1 Feb 2024 03:33:38 -0700
Message-Id: <20240201103340.119081-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201103340.119081-1-ltaylorsimpson@gmail.com>
References: <20240201103340.119081-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x131.google.com
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

We divide gen_analyze_funcs.py into 3 phases
    Declare the operands
    Analyze the register reads
    Analyze the register writes

We also create special versions of ctx_log_*_read for new operands
    Check that the operand is written before the read

This is a precursor to improving the analysis for short-circuiting
the packet semantics in a subsequent commit

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h          | 26 +++++++++++-
 target/hexagon/README               |  9 +++--
 target/hexagon/gen_analyze_funcs.py | 34 ++++++++++------
 target/hexagon/hex_common.py        | 63 +++++++++++++++--------------
 4 files changed, 83 insertions(+), 49 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 4dd59c6726..f06d71fc53 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -75,6 +75,8 @@ typedef struct DisasContext {
     TCGv dczero_addr;
 } DisasContext;
 
+bool is_gather_store_insn(DisasContext *ctx);
+
 static inline void ctx_log_pred_write(DisasContext *ctx, int pnum)
 {
     if (!test_bit(pnum, ctx->pregs_written)) {
@@ -89,6 +91,12 @@ static inline void ctx_log_pred_read(DisasContext *ctx, int pnum)
     set_bit(pnum, ctx->pregs_read);
 }
 
+static inline void ctx_log_pred_read_new(DisasContext *ctx, int pnum)
+{
+    g_assert(test_bit(pnum, ctx->pregs_written));
+    set_bit(pnum, ctx->pregs_read);
+}
+
 static inline void ctx_log_reg_write(DisasContext *ctx, int rnum,
                                      bool is_predicated)
 {
@@ -120,6 +128,12 @@ static inline void ctx_log_reg_read(DisasContext *ctx, int rnum)
     set_bit(rnum, ctx->regs_read);
 }
 
+static inline void ctx_log_reg_read_new(DisasContext *ctx, int rnum)
+{
+    g_assert(test_bit(rnum, ctx->regs_written));
+    set_bit(rnum, ctx->regs_read);
+}
+
 static inline void ctx_log_reg_read_pair(DisasContext *ctx, int rnum)
 {
     ctx_log_reg_read(ctx, rnum);
@@ -171,6 +185,15 @@ static inline void ctx_log_vreg_read(DisasContext *ctx, int rnum)
     set_bit(rnum, ctx->vregs_read);
 }
 
+static inline void ctx_log_vreg_read_new(DisasContext *ctx, int rnum)
+{
+    g_assert(is_gather_store_insn(ctx) ||
+             test_bit(rnum, ctx->vregs_updated) ||
+             test_bit(rnum, ctx->vregs_select) ||
+             test_bit(rnum, ctx->vregs_updated_tmp));
+    set_bit(rnum, ctx->vregs_read);
+}
+
 static inline void ctx_log_vreg_read_pair(DisasContext *ctx, int rnum)
 {
     ctx_log_vreg_read(ctx, rnum ^ 0);
@@ -205,7 +228,6 @@ extern TCGv hex_vstore_addr[VSTORES_MAX];
 extern TCGv hex_vstore_size[VSTORES_MAX];
 extern TCGv hex_vstore_pending[VSTORES_MAX];
 
-bool is_gather_store_insn(DisasContext *ctx);
 void process_store(DisasContext *ctx, int slot_num);
 
 FIELD(PROBE_PKT_SCALAR_STORE_S0, MMU_IDX,       0, 2)
diff --git a/target/hexagon/README b/target/hexagon/README
index 746ebec378..c1d8c8d0ab 100644
--- a/target/hexagon/README
+++ b/target/hexagon/README
@@ -183,10 +183,11 @@ when the override is present.
     }
 
 We also generate an analyze_<tag> function for each instruction.  Currently,
-these functions record the writes to registers by calling ctx_log_*.  During
-gen_start_packet, we invoke the analyze_<tag> function for each instruction in
-the packet, and we mark the implicit writes.  After the analysis is performed,
-we initialize the result register for each of the predicated assignments.
+these functions record the reads and writes to registers by calling ctx_log_*.
+During gen_start_packet, we invoke the analyze_<tag> function for each instruction in
+the packet, and we mark the implicit writes.  The analysis determines if the packet
+semantics can be short-circuited.  If not, we initialize the result register for each
+of the predicated assignments.
 
 In addition to instruction semantics, we use a generator to create the decode
 tree.  This generation is a four step process.
diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
index a9af666cef..890e6a3a95 100755
--- a/target/hexagon/gen_analyze_funcs.py
+++ b/target/hexagon/gen_analyze_funcs.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2022-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2022-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -44,15 +44,25 @@ def gen_analyze_func(f, tag, regs, imms):
 
     f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
 
-    i = 0
-    ## Analyze all the registers
-    for regtype, regid in regs:
-        reg = hex_common.get_register(tag, regtype, regid)
+    ## Declare all the registers
+    for regno, register in enumerate(regs):
+        reg_type, reg_id = register
+        reg = hex_common.get_register(tag, reg_type, reg_id)
+        reg.decl_reg_num(f, regno)
+
+    ## Analyze the register reads
+    for regno, register in enumerate(regs):
+        reg_type, reg_id = register
+        reg = hex_common.get_register(tag, reg_type, reg_id)
+        if reg.is_read():
+            reg.analyze_read(f, regno)
+
+    ## Analyze the register writes
+    for regno, register in enumerate(regs):
+        reg_type, reg_id = register
+        reg = hex_common.get_register(tag, reg_type, reg_id)
         if reg.is_written():
-            reg.analyze_write(f, tag, i)
-        else:
-            reg.analyze_read(f, i)
-        i += 1
+            reg.analyze_write(f, tag, regno)
 
     has_generated_helper = not hex_common.skip_qemu_helper(
         tag
@@ -89,13 +99,13 @@ def main():
     tagimms = hex_common.get_tagimms()
 
     with open(sys.argv[-1], "w") as f:
-        f.write("#ifndef HEXAGON_TCG_FUNCS_H\n")
-        f.write("#define HEXAGON_TCG_FUNCS_H\n\n")
+        f.write("#ifndef HEXAGON_ANALYZE_FUNCS_C_INC\n")
+        f.write("#define HEXAGON_ANALYZE_FUNCS_C_INC\n\n")
 
         for tag in hex_common.tags:
             gen_analyze_func(f, tag, tagregs[tag], tagimms[tag])
 
-        f.write("#endif    /* HEXAGON_TCG_FUNCS_H */\n")
+        f.write("#endif    /* HEXAGON_ANALYZE_FUNCS_C_INC */\n")
 
 
 if __name__ == "__main__":
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 195620c7ec..33801e4bd7 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -425,7 +425,6 @@ def log_write(self, f, tag):
             gen_log_reg_write(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
             ctx_log_reg_write(ctx, {self.reg_num}, {predicated});
@@ -438,7 +437,6 @@ def decl_tcg(self, f, tag, regno):
             TCGv {self.reg_tcg()} = hex_gpr[{self.reg_num}];
         """))
     def analyze_read(self, f, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_reg_read(ctx, {self.reg_num});
         """))
@@ -449,9 +447,8 @@ def decl_tcg(self, f, tag, regno):
             TCGv {self.reg_tcg()} = get_result_gpr(ctx, insn->regno[{regno}]);
         """))
     def analyze_read(self, f, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
-            ctx_log_reg_read(ctx, {self.reg_num});
+            ctx_log_reg_read_new(ctx, {self.reg_num});
         """))
 
 class GprReadWrite(Register, Single, ReadWrite):
@@ -471,8 +468,11 @@ def log_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_log_reg_write(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_read(self, f, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_reg_read(ctx, {self.reg_num});
+        """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
             ctx_log_reg_write(ctx, {self.reg_num}, {predicated});
@@ -493,7 +493,6 @@ def log_write(self, f, tag):
             gen_write_ctrl_reg(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
             ctx_log_reg_write(ctx, {self.reg_num}, {predicated});
@@ -511,7 +510,6 @@ def decl_tcg(self, f, tag, regno):
             gen_read_ctrl_reg(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
     def analyze_read(self, f, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_reg_read(ctx, {self.reg_num});
         """))
@@ -532,7 +530,6 @@ def idef_arg(self, declared):
         declared.append(self.reg_tcg())
         declared.append("CS")
     def analyze_read(self, f, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_reg_read(ctx, {self.reg_num});
         """))
@@ -548,7 +545,6 @@ def log_write(self, f, tag):
             gen_log_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_pred_write(ctx, {self.reg_num});
         """))
@@ -560,7 +556,6 @@ def decl_tcg(self, f, tag, regno):
             TCGv {self.reg_tcg()} = hex_pred[{self.reg_num}];
         """))
     def analyze_read(self, f, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_pred_read(ctx, {self.reg_num});
         """))
@@ -571,9 +566,8 @@ def decl_tcg(self, f, tag, regno):
             TCGv {self.reg_tcg()} = get_result_pred(ctx, insn->regno[{regno}]);
         """))
     def analyze_read(self, f, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
-            ctx_log_pred_read(ctx, {self.reg_num});
+            ctx_log_pred_read_new(ctx, {self.reg_num});
         """))
 
 class PredReadWrite(Register, Single, ReadWrite):
@@ -587,8 +581,11 @@ def log_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_log_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_read(self, f, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_pred_read(ctx, {self.reg_num});
+        """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_pred_write(ctx, {self.reg_num});
         """))
@@ -605,7 +602,6 @@ def log_write(self, f, tag):
             gen_log_reg_write_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
             ctx_log_reg_write_pair(ctx, {self.reg_num}, {predicated});
@@ -621,7 +617,6 @@ def decl_tcg(self, f, tag, regno):
                                     hex_gpr[{self.reg_num} + 1]);
         """))
     def analyze_read(self, f, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_reg_read_pair(ctx, {self.reg_num});
         """))
@@ -640,8 +635,11 @@ def log_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_log_reg_write_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
+    def analyze_read(self, f, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_reg_read_pair(ctx, {self.reg_num});
+        """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
             ctx_log_reg_write_pair(ctx, {self.reg_num}, {predicated});
@@ -663,7 +661,6 @@ def log_write(self, f, tag):
             gen_write_ctrl_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
             ctx_log_reg_write_pair(ctx, {self.reg_num}, {predicated});
@@ -681,7 +678,6 @@ def decl_tcg(self, f, tag, regno):
             gen_read_ctrl_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
     def analyze_read(self, f, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_reg_read_pair(ctx, {self.reg_num});
         """))
@@ -705,7 +701,6 @@ def helper_hvx_desc(self, f):
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
         """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         newv = hvx_newv(tag)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
@@ -728,7 +723,6 @@ def helper_hvx_desc(self, f):
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
         """))
     def analyze_read(self, f, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_vreg_read(ctx, {self.reg_num});
         """))
@@ -746,9 +740,8 @@ def helper_hvx_desc(self, f):
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
         """))
     def analyze_read(self, f, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
-            ctx_log_vreg_read(ctx, {self.reg_num});
+            ctx_log_vreg_read_new(ctx, {self.reg_num});
         """))
 
 class VRegReadWrite(Register, Hvx, ReadWrite):
@@ -772,8 +765,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
         """))
+    def analyze_read(self, f, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_read(ctx, {self.reg_num});
+        """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         newv = hvx_newv(tag)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
@@ -803,8 +799,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVector *)({self.helper_arg_name()}) */
         """))
+    def analyze_read(self, f, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_read(ctx, {self.reg_num});
+        """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         newv = hvx_newv(tag)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
@@ -830,7 +829,6 @@ def helper_hvx_desc(self, f):
             /* {self.reg_tcg()} is *(MMVectorPair *)({self.helper_arg_name()}) */
         """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         newv = hvx_newv(tag)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
@@ -860,7 +858,6 @@ def helper_hvx_desc(self, f):
             /* {self.reg_tcg()} is *(MMVectorPair *)({self.helper_arg_name()}) */
         """))
     def analyze_read(self, f, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_vreg_read_pair(ctx, {self.reg_num});
         """))
@@ -892,8 +889,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMVectorPair *)({self.helper_arg_name()}) */
         """))
+    def analyze_read(self, f, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_vreg_read_pair(ctx, {self.reg_num});
+        """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         newv = hvx_newv(tag)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
@@ -919,7 +919,6 @@ def helper_hvx_desc(self, f):
             /* {self.reg_tcg()} is *(MMQReg *)({self.helper_arg_name()}) */
         """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_qreg_write(ctx, {self.reg_num});
         """))
@@ -941,7 +940,6 @@ def helper_hvx_desc(self, f):
             /* {self.reg_tcg()} is *(MMQReg *)({self.helper_arg_name()}) */
         """))
     def analyze_read(self, f, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_qreg_read(ctx, {self.reg_num});
         """))
@@ -967,8 +965,11 @@ def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
             /* {self.reg_tcg()} is *(MMQReg *)({self.helper_arg_name()}) */
         """))
+    def analyze_read(self, f, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_qreg_read(ctx, {self.reg_num});
+        """))
     def analyze_write(self, f, tag, regno):
-        self.decl_reg_num(f, regno)
         f.write(code_fmt(f"""\
             ctx_log_qreg_write(ctx, {self.reg_num});
         """))
-- 
2.34.1


