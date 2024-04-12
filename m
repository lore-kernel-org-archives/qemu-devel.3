Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3EEC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQQ-000779-0m; Fri, 12 Apr 2024 03:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQJ-00074i-Du
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:11 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQE-0007Ca-KR
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6eaf1005fcaso453921b3a.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907243; x=1713512043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hxqYH9ScX+ObdWXnIbuV9Gxb9Me9BqWqhyTqw11fwnA=;
 b=YLihk81p1f8ULXc1LC+UchZQm94JPAgc/rpzZlnVbZtOBpyvxt0CwMJ7yI02ycPW+O
 LCtxUvdS34kEJUPjzx58Usnje/qM1ERTnW0mWJasTZADnSVl7YNI1oYF1DZuIwMFCwWS
 ut8uCET6yysqMLyL4+NJuiMykOh1qxksr5rp7hGHl49ArS6P9UTLouR4fIWUMsn4Uixo
 ktLS8oor/y3DYla3s7Ay7NpbfG0a+Xj71pmIYCO5cPzF/VuWMNYukwwyF/njyxk6k0p3
 9v8s2gWwg2GUoc2z0P3lWq/HyzxcfiBQKOPemN7rtypy8Dw7Sl27DQlTVQB7GzRFO9Dj
 jmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907243; x=1713512043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxqYH9ScX+ObdWXnIbuV9Gxb9Me9BqWqhyTqw11fwnA=;
 b=fFyiTD0MZAlSWJhDXTTAfhVKehEfWhjrh5sXbVykmR2JqnlcUi7ZfWr46hLdiZpYyS
 kQAdkirzf6pB6zNc2CdN+v8HDVIvmr9iS9yM2bi83tqMDUGjDjoPFSKPCdlBDg64xSAw
 CidHmA2grudVut5gsHb9kj+PmrNcbkvEd6n1MIjT09upeqyu6C/lkJF+xCDCxkdysZmf
 6DCzdfizY4aJzgYO175w9d83PfnKfTGDKtIK5pKCIx9crqVDRgKXLpeqYisKKiq4U5Ui
 Cg4iKr3Pj2BJEKw0mcRvlFhanP6picGBQmFsDmGizDPJs3klPMrE/4FgWFQpP7k33ee0
 NSTg==
X-Gm-Message-State: AOJu0YysYVs3EC7w/RF0rSJPKxbuFAHdscyZDyQsuuK/z66QB116Bl8N
 axHKI64tskcUqnRyaYE979augtlP6FLkCaKxvgom4eIXSJVRGNjSNNJ8p9kitlH39o6vdVeJSLq
 H
X-Google-Smtp-Source: AGHT+IG8xFWTsqZpvJOr8FNcJtmqVAqBpE/VPvTBIuYknSeZnAJRqpwFwfmT/ZwpInf59fU9MvTrGA==
X-Received: by 2002:a05:6a21:6d9a:b0:1a7:4867:7301 with SMTP id
 wl26-20020a056a216d9a00b001a748677301mr2179010pzb.5.1712907242824; 
 Fri, 12 Apr 2024 00:34:02 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.34.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:34:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/27] disas/microblaze: Print registers directly with
 PRIrfsl
Date: Fri, 12 Apr 2024 00:33:38 -0700
Message-Id: <20240412073346.458116-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 disas/microblaze.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 390f98c0a3..24febfdea9 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -564,7 +564,6 @@ static const struct op_code_struct {
 
 /* prefix for register names */
 #define register_prefix "r"
-static const char fsl_register_prefix[] = "rfsl";
 static const char pvr_register_prefix[] = "rpvr";
 
 
@@ -580,11 +579,13 @@ static const char pvr_register_prefix[] = "rpvr";
 #include "disas/dis-asm.h"
 
 #define PRIreg    register_prefix "%ld"
+#define PRIrfsl   register_prefix "fsl%ld"
 #define PRIimm    "%d"
 
 #define get_field_rd(instr)      ((instr & RD_MASK) >> RD_LOW)
 #define get_field_r1(instr)      ((instr & RA_MASK) >> RA_LOW)
 #define get_field_r2(instr)      ((instr & RB_MASK) >> RB_LOW)
+#define get_field_rfsl(instr)    (instr & RFSL_MASK)
 #define get_field_imm(instr)     ((int16_t)instr)
 #define get_field_imm5(instr)    ((int)instr & IMM5_MASK)
 #define get_field_imm15(instr)   ((int)instr & IMM15_MASK)
@@ -592,19 +593,6 @@ static const char pvr_register_prefix[] = "rpvr";
 #define get_int_field_imm(instr) ((instr & IMM_MASK) >> IMM_LOW)
 #define get_int_field_r1(instr) ((instr & RA_MASK) >> RA_LOW)
 
-/* Local function prototypes. */
-
-static char * get_field_rfsl (long instr);
-
-static char *
-get_field_rfsl (long instr)
-{
-  char tmpstr[25];
-  snprintf(tmpstr, sizeof(tmpstr), "%s%d", fsl_register_prefix,
-           (short)((instr & RFSL_MASK) >> IMM_LOW));
-  return(strdup(tmpstr));
-}
-
 /*
   char *
   get_field_special (instr) 
@@ -803,11 +791,11 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
                      get_field_imm5(inst));
         break;
     case INST_TYPE_RD_RFSL:
-        fprintf_func(stream, "%s\t" PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIrfsl,
                      op->name, get_field_rd(inst), get_field_rfsl(inst));
         break;
     case INST_TYPE_R1_RFSL:
-        fprintf_func(stream, "%s\t" PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIrfsl,
                      op->name, get_field_r1(inst), get_field_rfsl(inst));
         break;
     case INST_TYPE_RD_SPECIAL:
@@ -879,7 +867,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
                      op->name, get_field_rd(inst));
         break;
     case INST_TYPE_RFSL:
-        fprintf_func(stream, "%s\t%s",
+        fprintf_func(stream, "%s\t" PRIrfsl,
                      op->name, get_field_rfsl(inst));
         break;
     default:
-- 
2.34.1


