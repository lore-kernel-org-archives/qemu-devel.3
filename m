Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16FFC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQN-00076E-TS; Fri, 12 Apr 2024 03:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQJ-00074f-DW
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQB-0007CW-OL
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e2bbc2048eso5649145ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907242; x=1713512042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P54+4fCIsAAc0bVMNSYixg4SDN1lDlZ7gzm2KMiAs9s=;
 b=tpTyIsUAm7ryE46ydOJ/Xkhlq+UQK7abWiVVTN4ACh6QckrdoU7LinmRUvs3KQ55hX
 AU3G37Sd1pi7CCrXnzoRFOimA7fFLOK9VmfuWzzUHdhY827SF0lb8ZlICVUrmfcPMFEH
 HeANxQxhI7EUDBNBPtLek0qzeRQdAcoZU0TRSB+EjI2P2/RNd1J9efiX74+B6TA090r0
 P3XhgLyGx8g2RpKRXThMHwUxRH6flC+2CpzE87xKvmftviZI713yd6QTTAhL02z7I43N
 o6lEZGwTLWl2I6OcKjg9Z5TGuJj5oStDdNdjDwNNh4mYnvCVdWq3BtJMVHGU4n//T0mE
 6vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907242; x=1713512042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P54+4fCIsAAc0bVMNSYixg4SDN1lDlZ7gzm2KMiAs9s=;
 b=aEiat/dY6DIswfjwmSHdTtPc3hlrwHwiOT1kDHp+q019rPXNU5iGZZ2e2WqEh+W8+2
 yczGY0X89Dlzv4wyO28ClwkdDwKjXBcpW3XwfqiMkawU4okBBLQI1Y0rLdvdzkBQq97Y
 zEWCv3bAW2sWfgrUWYS6XzsjoGGJ6eE9gIq5ENqak400HVXhOH+IWwDbGt6ehkVaG2W/
 fmj1V0AYWZBcCTey3rfrp/EvuVNo+fUwxbKm6+E8fkfZlxgsw8GxSFX4Wc5n5U+uM5a/
 PTtIUgKAvelPRLdSOCVY1wVTg77PkHnmJ8HRrp4rp/lL1sO9OfVBR0UeUjcr1MuPYDs9
 tXbg==
X-Gm-Message-State: AOJu0YwoDtuF0khjGYoA/tjlVjjSYWR3IY+NalVbhuJtxZJlOEheMZTG
 qXrLNTOLPmlfMzMQx40GYWOdDjmRtdadOIu2McvxSc33sUY+9v44hmYQp6+K0WlMqYn30VyPMho
 Y
X-Google-Smtp-Source: AGHT+IE1oYhWrgp0LI3qWXvHvH1elmh3v5JM9C+DsX4T2gEUqVSY1I0Oa6D2JXtYVkBXtmAuWgsOLQ==
X-Received: by 2002:a17:903:228e:b0:1e3:c9f6:c4b with SMTP id
 b14-20020a170903228e00b001e3c9f60c4bmr2135075plh.10.1712907242144; 
 Fri, 12 Apr 2024 00:34:02 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.34.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:34:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/27] disas/microblaze: Print immediates directly with
 PRIimm
Date: Fri, 12 Apr 2024 00:33:37 -0700
Message-Id: <20240412073346.458116-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Use a printf format instead of sprintf into a buffer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/microblaze.c | 61 +++++++++-------------------------------------
 1 file changed, 11 insertions(+), 50 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index c12968f3b9..390f98c0a3 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -580,40 +580,21 @@ static const char pvr_register_prefix[] = "rpvr";
 #include "disas/dis-asm.h"
 
 #define PRIreg    register_prefix "%ld"
+#define PRIimm    "%d"
 
 #define get_field_rd(instr)      ((instr & RD_MASK) >> RD_LOW)
 #define get_field_r1(instr)      ((instr & RA_MASK) >> RA_LOW)
 #define get_field_r2(instr)      ((instr & RB_MASK) >> RB_LOW)
+#define get_field_imm(instr)     ((int16_t)instr)
+#define get_field_imm5(instr)    ((int)instr & IMM5_MASK)
+#define get_field_imm15(instr)   ((int)instr & IMM15_MASK)
+
 #define get_int_field_imm(instr) ((instr & IMM_MASK) >> IMM_LOW)
 #define get_int_field_r1(instr) ((instr & RA_MASK) >> RA_LOW)
 
 /* Local function prototypes. */
 
-static char * get_field_imm (long instr);
-static char * get_field_imm5 (long instr);
 static char * get_field_rfsl (long instr);
-static char * get_field_imm15 (long instr);
-#if 0
-static char * get_field_unsigned_imm (long instr);
-#endif
-
-static char *
-get_field_imm (long instr)
-{
-  char tmpstr[25];
-  snprintf(tmpstr, sizeof(tmpstr), "%d",
-           (short)((instr & IMM_MASK) >> IMM_LOW));
-  return(strdup(tmpstr));
-}
-
-static char *
-get_field_imm5 (long instr)
-{
-  char tmpstr[25];
-  snprintf(tmpstr, sizeof(tmpstr), "%d",
-           (short)((instr & IMM5_MASK) >> IMM_LOW));
-  return(strdup(tmpstr));
-}
 
 static char *
 get_field_rfsl (long instr)
@@ -624,26 +605,6 @@ get_field_rfsl (long instr)
   return(strdup(tmpstr));
 }
 
-static char *
-get_field_imm15 (long instr)
-{
-  char tmpstr[25];
-  snprintf(tmpstr, sizeof(tmpstr), "%d",
-           (short)((instr & IMM15_MASK) >> IMM_LOW));
-  return(strdup(tmpstr));
-}
-
-#if 0
-static char *
-get_field_unsigned_imm (long instr)
-{
-  char tmpstr[25];
-  snprintf(tmpstr, sizeof(tmpstr), "%d",
-           (int)((instr & IMM_MASK) >> IMM_LOW));
-  return(strdup(tmpstr));
-}
-#endif
-
 /*
   char *
   get_field_special (instr) 
@@ -829,7 +790,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
                      get_field_r2(inst));
         break;
     case INST_TYPE_RD_R1_IMM:
-        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", " PRIimm,
                      op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_imm(inst));
         if (get_int_field_r1(inst) == 0) {
@@ -837,7 +798,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         }
         break;
     case INST_TYPE_RD_R1_IMM5:
-        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", " PRIimm,
                      op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_imm5(inst));
         break;
@@ -866,7 +827,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
                      op->name, get_field_r1(inst), get_field_r2(inst));
         break;
     case INST_TYPE_R1_IMM:
-        fprintf_func(stream, "%s\t" PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIimm,
                      op->name, get_field_r1(inst), get_field_imm(inst));
         /*
          * The non-pc relative instructions are returns,
@@ -877,14 +838,14 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         }
         break;
     case INST_TYPE_RD_IMM:
-        fprintf_func(stream, "%s\t" PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIimm,
                      op->name, get_field_rd(inst), get_field_imm(inst));
         print_immval_addr(info, immfound, immval, inst,
                           op->inst_offset_type == INST_PC_OFFSET
                           ? memaddr : 0);
         break;
     case INST_TYPE_IMM:
-        fprintf_func(stream, "%s\t%s",
+        fprintf_func(stream, "%s\t" PRIimm,
                      op->name, get_field_imm(inst));
         if (op->instr != imm) {
             print_immval_addr(info, immfound, immval, inst,
@@ -909,7 +870,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
                      op->name, get_field_rd(inst), get_field_r2(inst));
         break;
     case INST_TYPE_RD_IMM15:
-        fprintf_func(stream, "%s\t" PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIimm,
                      op->name, get_field_rd(inst), get_field_imm15(inst));
         break;
         /* For tuqula instruction */
-- 
2.34.1


