Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763FBC00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQI-00074H-3N; Fri, 12 Apr 2024 03:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQA-00070s-9l
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:03 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ7-0007BB-Ve
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:01 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e3c9300c65so6283825ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907239; x=1713512039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rYVeh39A85lKzN367OYcjUFCWQI2goI5Bmql3JBqN/4=;
 b=Oie4f+HNrso8VcxuLvXfbRirQR/F89QWTrudQ2ye6PCwB+7oi2KSKbEW9N04VEMGq2
 ANF3azTIB8F9t9IGp7Fv/VeiSleiPBGuxD3h3oJHw58t0PUNHHQWx8mJsEwkZKv9ZZsX
 apktQXyVDnCXCXiDiADyRS2YYLDQlrRs6SAqbUIJO6Ed0HrYS9hPNeYKhMsqpWhUu4/t
 D2GhUOdeOvRsuUZDzpYfKz+i8btM5ke11yZpQTHtNEQLXcQqujxoWLv6hHiAbgqSh2Rg
 E/D31qHb3sSVpp6DpmUPfdmUA9XXDAseNRBw+ZZAHyQtstQa1vK3SBhleUxocFI1Ie8Q
 hFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907239; x=1713512039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYVeh39A85lKzN367OYcjUFCWQI2goI5Bmql3JBqN/4=;
 b=WZncITnH6S4EVZlyeZqUWxaL0SEdtu2StVU47NE5VnY8OBkq6C+QLjnDqi8snOmFQm
 7wreJ+jx5HQJqY11eivmrZH2lpMCq4Pd2y+nhbDB0YnFXdTYdZHV22PiG/zq5m1c09mf
 hbEbJ1cSPiLJ8bjGYDLKG6P4iqonmOLtlHDQQlS58rh/ADwg9NxHMtmLu65sbRX7z3o9
 MYmYMNSD2LdtohULfaf9w8zzYbN58RDXMTrVqZ11YeV6klIEGKf6p2aHo28x9QmQc6OH
 JwAi+m7YOpzneoVBh3/s5070QahgGjeqcQ7/1pZZXIfvhgvZgHYwpyTLE9mqlKtaRFCZ
 uShQ==
X-Gm-Message-State: AOJu0Yxj0n74qo67S9Jsm/r6oeaUaJiIhaskbU2g3E9n+jF+qo29KJvl
 dO1pjtsQ+YcTlgmzZwDs+hULijd0EWYnn4yWnxcDyvzgLmehcMsYvbcOOf7ud/B3AVuMBb3nsEj
 T
X-Google-Smtp-Source: AGHT+IGzGaK0wHiD+ekAvlxNIssQ1JJ0aRWXHhHPuixoMGvretn8jfyoxHJZU3Zi45GfnG+j+CtAMA==
X-Received: by 2002:a17:902:ba84:b0:1e4:4a3f:9a88 with SMTP id
 k4-20020a170902ba8400b001e44a3f9a88mr1489311pls.46.1712907238778; 
 Fri, 12 Apr 2024 00:33:58 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/27] disas/microblaze: Split out print_immval_addr
Date: Fri, 12 Apr 2024 00:33:33 -0700
Message-Id: <20240412073346.458116-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Unify the code blocks that try to print a symbolic address.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/microblaze.c | 89 +++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 60 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 49a4c0fd40..3473c94164 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -767,6 +767,24 @@ read_insn_microblaze (bfd_vma memaddr,
   return inst;
 }
 
+static void print_immval_addr(struct disassemble_info *info, bool immfound,
+                              int immval, unsigned inst, int addend)
+{
+    if (info->print_address_func && info->symbol_at_address_func) {
+        if (immfound) {
+            immval |= get_int_field_imm(inst) & 0x0000ffff;
+        } else {
+            immval = (int16_t)get_int_field_imm(inst);
+        }
+        immval += addend;
+        if (immval != 0 && info->symbol_at_address_func(immval, info)) {
+            info->fprintf_func(info->stream, "\t// ");
+            info->print_address_func (immval, info);
+        } else if (addend) {
+            info->fprintf_func(info->stream, "\t// %x", immval);
+        }
+    }
+}
 
 int 
 print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
@@ -821,18 +839,8 @@ print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
      break;
         case INST_TYPE_RD_R1_IMM:
 	  fprintf_func(stream, "\t%s, %s, %s", get_field_rd(inst), get_field_r1(inst), get_field_imm(inst));
-	  if (info->print_address_func && get_int_field_r1(inst) == 0 && info->symbol_at_address_func) {
-	    if (immfound)
-	      immval |= (get_int_field_imm(inst) & 0x0000ffff);
-	    else {
-	      immval = get_int_field_imm(inst);
-	      if (immval & 0x8000)
-		immval |= 0xFFFF0000;
-	    }
-	    if (immval > 0 && info->symbol_at_address_func(immval, info)) {
-	      fprintf_func (stream, "\t// ");
-	      info->print_address_func (immval, info);
-	    }
+	  if (get_int_field_r1(inst) == 0) {
+              print_immval_addr(info, immfound, immval, inst, 0);
 	  }
 	  break;
 	case INST_TYPE_RD_R1_IMM5:
@@ -860,61 +868,22 @@ print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
 	  fprintf_func(stream, "\t%s, %s", get_field_r1(inst), get_field_imm(inst));
 	  /* The non-pc relative instructions are returns, which shouldn't 
 	     have a label printed */
-	  if (info->print_address_func && op->inst_offset_type == INST_PC_OFFSET && info->symbol_at_address_func) {
-	    if (immfound)
-	      immval |= (get_int_field_imm(inst) & 0x0000ffff);
-	    else {
-	      immval = get_int_field_imm(inst);
-	      if (immval & 0x8000)
-		immval |= 0xFFFF0000;
-	    }
-	    immval += memaddr;
-	    if (immval > 0 && info->symbol_at_address_func(immval, info)) {
-	      fprintf_func (stream, "\t// ");
-	      info->print_address_func (immval, info);
-	    } else {
-	      fprintf_func (stream, "\t\t// ");
-	      fprintf_func (stream, "%x", immval);
-	    }
+	  if (op->inst_offset_type == INST_PC_OFFSET) {
+              print_immval_addr(info, immfound, immval, inst, memaddr);
 	  }
 	  break;
         case INST_TYPE_RD_IMM:
 	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_imm(inst));
-	  if (info->print_address_func && info->symbol_at_address_func) {
-	    if (immfound)
-	      immval |= (get_int_field_imm(inst) & 0x0000ffff);
-	    else {
-	      immval = get_int_field_imm(inst);
-	      if (immval & 0x8000)
-		immval |= 0xFFFF0000;
-	    }
-	    if (op->inst_offset_type == INST_PC_OFFSET)
-	      immval += (int) memaddr;
-	    if (info->symbol_at_address_func(immval, info)) {
-	      fprintf_func (stream, "\t// ");
-	      info->print_address_func (immval, info);
-	    } 
-	  }
+          print_immval_addr(info, immfound, immval, inst,
+                            op->inst_offset_type == INST_PC_OFFSET
+                            ? memaddr : 0);
 	  break;
         case INST_TYPE_IMM:
 	  fprintf_func(stream, "\t%s", get_field_imm(inst));
-	  if (info->print_address_func && info->symbol_at_address_func && op->instr != imm) {
-	    if (immfound)
-	      immval |= (get_int_field_imm(inst) & 0x0000ffff);
-	    else {
-	      immval = get_int_field_imm(inst);
-	      if (immval & 0x8000)
-		immval |= 0xFFFF0000;
-	    }
-	    if (op->inst_offset_type == INST_PC_OFFSET)
-	      immval += (int) memaddr;
-	    if (immval > 0 && info->symbol_at_address_func(immval, info)) {
-	      fprintf_func (stream, "\t// ");
-	      info->print_address_func (immval, info);
-	    } else if (op->inst_offset_type == INST_PC_OFFSET) {
-	      fprintf_func (stream, "\t\t// ");
-	      fprintf_func (stream, "%x", immval);
-	    }
+	  if (op->instr != imm) {
+              print_immval_addr(info, immfound, immval, inst,
+                                op->inst_offset_type == INST_PC_OFFSET
+                                ? memaddr : 0);
 	  }
 	  break;
         case INST_TYPE_RD_R2:
-- 
2.34.1


