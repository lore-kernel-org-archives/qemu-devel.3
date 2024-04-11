Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28387CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruruS-0002ne-PT; Thu, 11 Apr 2024 06:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruruR-0002mv-4l
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:43:59 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruruO-0004Dv-Cd
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:43:58 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3458b699d6cso2049759f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712832235; x=1713437035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZARctQBaWTgi16Nsw9jDwGPNb4MI5ibxpQ1TfC8D7e4=;
 b=Uyq3ZvysZVVtHJqCKPc03g5Bsc5oinb0hXgKU+H4K5AlZ/8HcxFapInf8Z4Bz1ShGO
 8KmPGbqO+fb3KLveXljBwmkqj4Zhu++jDyU5Tu6syvG3RWsQnxyOmqinSOEnHHwL90Ik
 SMugQiXDytI8bGOe3zaB3YhaWDdnITY+oSdm5/YHxG4v3Nyemr8sod6Qoz3r9tF0wJtN
 U83nfCBILtZ3labYAJlxnxic6UZaC2qjBD3SI0zVAArDrRc9RdqQ4dVWlKacV04vQ1u2
 /1wZSEAcw9YeJ+mxq8/U+4CqZyJrN09hHIyo4laihz7i/96ptAHxUQkcOoh6Hmo/IooK
 zbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712832235; x=1713437035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZARctQBaWTgi16Nsw9jDwGPNb4MI5ibxpQ1TfC8D7e4=;
 b=JsI8bvXcX7R6r1cJjYzqFIKTu0e8FNs3Y/r3gzGRGhyk5ZAinIqpWXJIf+4sPWQyAJ
 A+yOLTNabaY9kuU0wQAqSSgVrO2CYGkP5/u7m/rM7eQFUB+zqJv1OVbP/0Ya0fFpyAew
 X0Tzitw/c8IjTs0chsMDKyC1i94KczyWnjhYdwEEtYzA0VtpCP1Gjx9dDzA8syFZScAe
 fAO1krS664BQpksL5CJobr3ilQpvKoz5qxlnhw/5/Lplrwzu0M4razE/F6wlwJTsQ5IE
 PsmiLBUF7+DjPpupQCFhFVChG5Nc0eJmCAf6jSJnoQLDvbifvRQtYhPn1e+1kYgWzqfn
 t5jQ==
X-Gm-Message-State: AOJu0YxYmRUXB8TN+a46QR/AHtaekBH3sjFJp4xmXi/Uc53KrimsU7SS
 cNIzyRTTTUPBCGhWYomkh3BpPm7/utww69UA2sjpqgg8mTE93vq0MYo8ECpjYDR3DeU1WxcTldb
 CxSM=
X-Google-Smtp-Source: AGHT+IFltCQplSMOQ6kMZ2B9MhaX0r2Lrd/lueNmil7OV2EbqlCrwSBa6bBQw/tU3i3Ti1Mq/6pdWQ==
X-Received: by 2002:a5d:58c2:0:b0:346:ba70:f261 with SMTP id
 o2-20020a5d58c2000000b00346ba70f261mr952868wrf.2.1712832234836; 
 Thu, 11 Apr 2024 03:43:54 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 t7-20020adfe447000000b00343eac2acc4sm1461921wrm.111.2024.04.11.03.43.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:43:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 2/9] disas/microblaze: Replace sprintf() by snprintf()
Date: Thu, 11 Apr 2024 12:43:33 +0200
Message-ID: <20240411104340.6617-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411104340.6617-1-philmd@linaro.org>
References: <20240411104340.6617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 disas/microblaze.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 0b89b9c4fa..49a4c0fd40 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -600,7 +600,8 @@ static char *
 get_field (long instr, long mask, unsigned short low)
 {
   char tmpstr[25];
-  sprintf(tmpstr, "%s%d", register_prefix, (int)((instr & mask) >> low));
+  snprintf(tmpstr, sizeof(tmpstr), "%s%d", register_prefix,
+           (int)((instr & mask) >> low));
   return(strdup(tmpstr));
 }
 
@@ -608,7 +609,8 @@ static char *
 get_field_imm (long instr)
 {
   char tmpstr[25];
-  sprintf(tmpstr, "%d", (short)((instr & IMM_MASK) >> IMM_LOW));
+  snprintf(tmpstr, sizeof(tmpstr), "%d",
+           (short)((instr & IMM_MASK) >> IMM_LOW));
   return(strdup(tmpstr));
 }
 
@@ -616,7 +618,8 @@ static char *
 get_field_imm5 (long instr)
 {
   char tmpstr[25];
-  sprintf(tmpstr, "%d", (short)((instr & IMM5_MASK) >> IMM_LOW));
+  snprintf(tmpstr, sizeof(tmpstr), "%d",
+           (short)((instr & IMM5_MASK) >> IMM_LOW));
   return(strdup(tmpstr));
 }
 
@@ -624,7 +627,8 @@ static char *
 get_field_rfsl (long instr)
 {
   char tmpstr[25];
-  sprintf(tmpstr, "%s%d", fsl_register_prefix, (short)((instr & RFSL_MASK) >> IMM_LOW));
+  snprintf(tmpstr, sizeof(tmpstr), "%s%d", fsl_register_prefix,
+           (short)((instr & RFSL_MASK) >> IMM_LOW));
   return(strdup(tmpstr));
 }
 
@@ -632,7 +636,8 @@ static char *
 get_field_imm15 (long instr)
 {
   char tmpstr[25];
-  sprintf(tmpstr, "%d", (short)((instr & IMM15_MASK) >> IMM_LOW));
+  snprintf(tmpstr, sizeof(tmpstr), "%d",
+           (short)((instr & IMM15_MASK) >> IMM_LOW));
   return(strdup(tmpstr));
 }
 
@@ -641,7 +646,8 @@ static char *
 get_field_unsigned_imm (long instr)
 {
   char tmpstr[25];
-  sprintf(tmpstr, "%d", (int)((instr & IMM_MASK) >> IMM_LOW));
+  snprintf(tmpstr, sizeof(tmpstr), "%d",
+           (int)((instr & IMM_MASK) >> IMM_LOW));
   return(strdup(tmpstr));
 }
 #endif
@@ -653,7 +659,8 @@ get_field_unsigned_imm (long instr)
   {
   char tmpstr[25];
   
-  sprintf(tmpstr, "%s%s", register_prefix, (((instr & IMM_MASK) >> IMM_LOW) & REG_MSR_MASK) == 0 ? "pc" : "msr");
+  snprintf(tmpstr, sizeof(tmpstr), "%s%s", register_prefix,
+          (((instr & IMM_MASK) >> IMM_LOW) & REG_MSR_MASK) == 0 ? "pc" : "msr");
   
   return(strdup(tmpstr));
   }
@@ -709,7 +716,7 @@ get_field_special(long instr, const struct op_code_struct *op)
    default :
      {
        if ( ((((instr & IMM_MASK) >> IMM_LOW) ^ op->immval_mask) & 0xE000) == REG_PVR_MASK) {
-	  sprintf(tmpstr, "%s%u", pvr_register_prefix,
+          snprintf(tmpstr, sizeof(tmpstr), "%s%u", pvr_register_prefix,
                  (unsigned short)(((instr & IMM_MASK) >> IMM_LOW) ^
                                   op->immval_mask) ^ REG_PVR_MASK);
 	 return(strdup(tmpstr));
@@ -720,7 +727,7 @@ get_field_special(long instr, const struct op_code_struct *op)
      break;
    }
    
-   sprintf(tmpstr, "%s%s", register_prefix, spr);
+   snprintf(tmpstr, sizeof(tmpstr), "%s%s", register_prefix, spr);
    return(strdup(tmpstr));
 }
 
-- 
2.41.0


