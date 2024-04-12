Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ABEC00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQH-000740-Fl; Fri, 12 Apr 2024 03:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQB-00071Z-W9
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ9-0007Bz-67
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:02 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e3cf5b171eso5656085ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907240; x=1713512040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6HJ1SMmA8I+3QuAFdhuJVGFMyvOQ304pvIkGq8bmlYE=;
 b=fRWCKJ16wj/9zLqvhGd1JWRQZn6wUegW8N9LV/hGOeVqc/SesWVm2f88wcSwSPJHfX
 hanCVfY8ysxdXySt4AZ+puG6mj5SPCEBp+ZrqJTcKwYK8zKIzv8lNHsYm9rzLwe/f1E+
 RYGXp4c+/pA3FbV56bXlTNuSfKkokvKBfY14HhKNmgMQylu6OmfplbUKrFNm0XAmltZ8
 xOB4U93KIjo5OGF0dL+2X9UL1/+fZet4Bz1pPyzaWfdaCI0ekZCNLLHyhxXZ8cdts4RK
 xo95E2UJ/NwlvSV5CHJSJtqnUtAcWzCNzGoACHd6kLl8mAlVKat89IjN5aVA+T+x8pRV
 CbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907240; x=1713512040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HJ1SMmA8I+3QuAFdhuJVGFMyvOQ304pvIkGq8bmlYE=;
 b=Fq8exkgfPAQswrPk2xWJfxOviWCoHPifXWBcfFhrWflnvp9jTd2eujHkh/n4FDKGfh
 yll7/roYMhCPOss2ULqcSNhJ2PSGvi+1vOzAQEA+xdKUHqEdQ13egZ9gGoGj/hnLv4um
 nWpx/RKqFHKsCvIwBTq5cTRZxhoxgAo4rn1alnf1BKAOuiYmdhD6d7PAPCahmhn/yisz
 mnwAN//S8KUbMeMbouGrDJltVKNty8suxmSeRQoYbaMTrndUdgafOLaocHmnu23o7GcU
 upIpzNrUL6aNi/pVIBsATBRH8Vfrwp7uAGLGq+FxZ4Npub+CAkhpD2o+DU3gwfyn2xe8
 FBZw==
X-Gm-Message-State: AOJu0YzZrnWgQD6UnicGSUe8Ghc2dKYQ/+N4Di+T9pmcs+QZVGEjrzP8
 7uGgWZpWx1B8Fr2gwNL4t5RNK76DdziMZSsnT8y8uo9noz7sJH2EdUnVMvn9IKgh+qw8gAA54Z2
 H
X-Google-Smtp-Source: AGHT+IHpJFz5Lq/IyHGyhh3KLglRPs4wpTYLyI/hFXwz1nYFKVayjRnLPqe9fJ4hul0efOkixz6q9A==
X-Received: by 2002:a17:902:a98a:b0:1e3:de79:35d1 with SMTP id
 bh10-20020a170902a98a00b001e3de7935d1mr1685068plb.23.1712907239662; 
 Fri, 12 Apr 2024 00:33:59 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/27] target/microblaze: Re-indent print_insn_microblaze
Date: Fri, 12 Apr 2024 00:33:34 -0700
Message-Id: <20240412073346.458116-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/microblaze.c | 263 ++++++++++++++++++++++++---------------------
 1 file changed, 141 insertions(+), 122 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 3473c94164..c729c76585 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -787,134 +787,153 @@ static void print_immval_addr(struct disassemble_info *info, bool immfound,
 }
 
 int 
-print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
+print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
 {
-  fprintf_function    fprintf_func = info->fprintf_func;
-  void *              stream = info->stream;
-  unsigned long       inst, prev_inst;
-  const struct op_code_struct *op, *pop;
-  int                 immval = 0;
-  bfd_boolean         immfound = FALSE;
-  static bfd_vma prev_insn_addr = -1; /*init the prev insn addr */
-  static int     prev_insn_vma = -1;  /*init the prev insn vma */
-  int            curr_insn_vma = info->buffer_vma;
+    fprintf_function fprintf_func = info->fprintf_func;
+    void *stream = info->stream;
+    unsigned long inst, prev_inst;
+    const struct op_code_struct *op, *pop;
+    int immval = 0;
+    bool immfound = false;
+    static bfd_vma prev_insn_addr = -1; /*init the prev insn addr */
+    static int prev_insn_vma = -1;  /*init the prev insn vma */
+    int curr_insn_vma = info->buffer_vma;
 
-  info->bytes_per_chunk = 4;
+    info->bytes_per_chunk = 4;
 
-  inst = read_insn_microblaze (memaddr, info, &op);
-  if (inst == 0) {
-    return -1;
-  }
+    inst = read_insn_microblaze (memaddr, info, &op);
+    if (inst == 0) {
+        return -1;
+    }
   
-  if (prev_insn_vma == curr_insn_vma) {
-  if (memaddr-(info->bytes_per_chunk) == prev_insn_addr) {
-    prev_inst = read_insn_microblaze (prev_insn_addr, info, &pop);
-    if (prev_inst == 0)
-      return -1;
-    if (pop->instr == imm) {
-      immval = (get_int_field_imm(prev_inst) << 16) & 0xffff0000;
-      immfound = TRUE;
+    if (prev_insn_vma == curr_insn_vma) {
+        if (memaddr - info->bytes_per_chunk == prev_insn_addr) {
+            prev_inst = read_insn_microblaze (prev_insn_addr, info, &pop);
+            if (prev_inst == 0)
+                return -1;
+            if (pop->instr == imm) {
+                immval = (get_int_field_imm(prev_inst) << 16) & 0xffff0000;
+                immfound = TRUE;
+            }
+            else {
+                immval = 0;
+                immfound = FALSE;
+            }
+        }
     }
-    else {
-      immval = 0;
-      immfound = FALSE;
-    }
-  }
-  }
-  /* make curr insn as prev insn */
-  prev_insn_addr = memaddr;
-  prev_insn_vma = curr_insn_vma;
+    /* make curr insn as prev insn */
+    prev_insn_addr = memaddr;
+    prev_insn_vma = curr_insn_vma;
 
-  if (op->name == 0) {
-    fprintf_func (stream, ".short 0x%04lx", inst);
-  }
-  else
-    {
-      fprintf_func (stream, "%s", op->name);
+    if (op->name == 0) {
+        fprintf_func (stream, ".short 0x%04lx", inst);
+        return 4;
+    }
+
+    fprintf_func (stream, "%s", op->name);
       
-      switch (op->inst_type)
-	{
-  case INST_TYPE_RD_R1_R2:
-     fprintf_func(stream, "\t%s, %s, %s", get_field_rd(inst), get_field_r1(inst), get_field_r2(inst));
-     break;
-        case INST_TYPE_RD_R1_IMM:
-	  fprintf_func(stream, "\t%s, %s, %s", get_field_rd(inst), get_field_r1(inst), get_field_imm(inst));
-	  if (get_int_field_r1(inst) == 0) {
-              print_immval_addr(info, immfound, immval, inst, 0);
-	  }
-	  break;
-	case INST_TYPE_RD_R1_IMM5:
-	  fprintf_func(stream, "\t%s, %s, %s", get_field_rd(inst), get_field_r1(inst), get_field_imm5(inst));
-	  break;
-	case INST_TYPE_RD_RFSL:
-	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_rfsl(inst));
-	  break;
-	case INST_TYPE_R1_RFSL:
-	  fprintf_func(stream, "\t%s, %s", get_field_r1(inst), get_field_rfsl(inst));
-	  break;
-	case INST_TYPE_RD_SPECIAL:
-	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_special(inst, op));
-	  break;
-	case INST_TYPE_SPECIAL_R1:
-	  fprintf_func(stream, "\t%s, %s", get_field_special(inst, op), get_field_r1(inst));
-	  break;
-	case INST_TYPE_RD_R1:
-	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_r1(inst));
-	  break;
-	case INST_TYPE_R1_R2:
-	  fprintf_func(stream, "\t%s, %s", get_field_r1(inst), get_field_r2(inst));
-	  break;
-	case INST_TYPE_R1_IMM:
-	  fprintf_func(stream, "\t%s, %s", get_field_r1(inst), get_field_imm(inst));
-	  /* The non-pc relative instructions are returns, which shouldn't 
-	     have a label printed */
-	  if (op->inst_offset_type == INST_PC_OFFSET) {
-              print_immval_addr(info, immfound, immval, inst, memaddr);
-	  }
-	  break;
-        case INST_TYPE_RD_IMM:
-	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_imm(inst));
-          print_immval_addr(info, immfound, immval, inst,
-                            op->inst_offset_type == INST_PC_OFFSET
-                            ? memaddr : 0);
-	  break;
-        case INST_TYPE_IMM:
-	  fprintf_func(stream, "\t%s", get_field_imm(inst));
-	  if (op->instr != imm) {
-              print_immval_addr(info, immfound, immval, inst,
-                                op->inst_offset_type == INST_PC_OFFSET
-                                ? memaddr : 0);
-	  }
-	  break;
-        case INST_TYPE_RD_R2:
-	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_r2(inst));
-	  break;
-  case INST_TYPE_R2:
-     fprintf_func(stream, "\t%s", get_field_r2(inst));
-     break;
-  case INST_TYPE_R1:
-     fprintf_func(stream, "\t%s", get_field_r1(inst));
-     break;
-  case INST_TYPE_RD_R1_SPECIAL:
-     fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_r2(inst));
-     break;
-  case INST_TYPE_RD_IMM15:
-     fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_imm15(inst));
-     break;
-     /* For tuqula instruction */
-  case INST_TYPE_RD:
-     fprintf_func(stream, "\t%s", get_field_rd(inst));
-     break;
-  case INST_TYPE_RFSL:
-     fprintf_func(stream, "\t%s", get_field_rfsl(inst));
-     break;
-  default:
-	  /* if the disassembler lags the instruction set */
-	  fprintf_func (stream, "\tundecoded operands, inst is 0x%04lx", inst);
-	  break;
-	}
+    switch (op->inst_type) {
+    case INST_TYPE_RD_R1_R2:
+        fprintf_func(stream, "\t%s, %s, %s",
+                     get_field_rd(inst), get_field_r1(inst),
+                     get_field_r2(inst));
+        break;
+    case INST_TYPE_RD_R1_IMM:
+        fprintf_func(stream, "\t%s, %s, %s",
+                     get_field_rd(inst), get_field_r1(inst),
+                     get_field_imm(inst));
+        if (get_int_field_r1(inst) == 0) {
+            print_immval_addr(info, immfound, immval, inst, 0);
+        }
+        break;
+    case INST_TYPE_RD_R1_IMM5:
+        fprintf_func(stream, "\t%s, %s, %s",
+                     get_field_rd(inst), get_field_r1(inst),
+                     get_field_imm5(inst));
+        break;
+    case INST_TYPE_RD_RFSL:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_rfsl(inst));
+        break;
+    case INST_TYPE_R1_RFSL:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_r1(inst), get_field_rfsl(inst));
+        break;
+    case INST_TYPE_RD_SPECIAL:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_special(inst, op));
+        break;
+    case INST_TYPE_SPECIAL_R1:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_special(inst, op), get_field_r1(inst));
+        break;
+    case INST_TYPE_RD_R1:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_r1(inst));
+        break;
+    case INST_TYPE_R1_R2:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_r1(inst), get_field_r2(inst));
+        break;
+    case INST_TYPE_R1_IMM:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_r1(inst), get_field_imm(inst));
+        /*
+         * The non-pc relative instructions are returns,
+         * which shouldn't have a label printed.
+         */
+        if (op->inst_offset_type == INST_PC_OFFSET) {
+            print_immval_addr(info, immfound, immval, inst, memaddr);
+        }
+        break;
+    case INST_TYPE_RD_IMM:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_imm(inst));
+        print_immval_addr(info, immfound, immval, inst,
+                          op->inst_offset_type == INST_PC_OFFSET
+                          ? memaddr : 0);
+        break;
+    case INST_TYPE_IMM:
+        fprintf_func(stream, "\t%s", get_field_imm(inst));
+        if (op->instr != imm) {
+            print_immval_addr(info, immfound, immval, inst,
+                              op->inst_offset_type == INST_PC_OFFSET
+                              ? memaddr : 0);
+        }
+        break;
+    case INST_TYPE_RD_R2:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_r2(inst));
+        break;
+    case INST_TYPE_R2:
+        fprintf_func(stream, "\t%s",
+                     get_field_r2(inst));
+        break;
+    case INST_TYPE_R1:
+        fprintf_func(stream, "\t%s",
+                     get_field_r1(inst));
+        break;
+    case INST_TYPE_RD_R1_SPECIAL:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_r2(inst));
+        break;
+    case INST_TYPE_RD_IMM15:
+        fprintf_func(stream, "\t%s, %s",
+                     get_field_rd(inst), get_field_imm15(inst));
+        break;
+        /* For tuqula instruction */
+    case INST_TYPE_RD:
+        fprintf_func(stream, "\t%s",
+                     get_field_rd(inst));
+        break;
+    case INST_TYPE_RFSL:
+        fprintf_func(stream, "\t%s",
+                     get_field_rfsl(inst));
+        break;
+    default:
+        /* if the disassembler lags the instruction set */
+        fprintf_func(stream, "\tundecoded operands, inst is 0x%04lx", inst);
+        break;
     }
-  
-  /* Say how many bytes we consumed? */
-  return 4;
+    return 4;
 }
-- 
2.34.1


