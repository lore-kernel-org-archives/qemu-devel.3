Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A63BC00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQI-00074L-Rm; Fri, 12 Apr 2024 03:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQA-00070r-9f
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:03 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ7-0007Ab-Dp
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:01 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e3c3aa8938so4339325ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907238; x=1713512038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eqjrZGd5HpdIOKB4IPvtcJuO95xZlA91V8rntFRy4Y=;
 b=GsxyWnq4SPm1F6qxQ7Er7HRkqR5DDdg2apELXOOdsttru4Erlo2D/uH1sSa9vSIwoD
 f6yyyPNGUWwi7qe1smpliAwLbJXWOKB1L8Ekdv2Q+p0iN3HnU93OVIq1LrIBTox5QmUh
 K4wse7xjKckIvfXuB6UJP9Pvtwh0fXKP/z6joiPAHxn9UasRybTZP0hvBEEg+aoXoSBw
 nocGumaEgJOn9VViOJeQ1zvI8RYjyn8zweCrBm3Kld1XzoFJ1nxVKbbsDNWy5g9GA6aK
 JV0qgRICARRuFryGdQ5er2ikjgW0dO/fscmtd9L9DPc9lPelolMmLn/EpHP709VyD1/m
 4URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907238; x=1713512038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eqjrZGd5HpdIOKB4IPvtcJuO95xZlA91V8rntFRy4Y=;
 b=GYPCvFYMLqeAW4dh8rKKZM0QOZobk8DbxNAkHFmauZqov+OtF9scQq2rLTulogkgIW
 PQJhsFr1nO8vDy8kNYB8fT8P/j8QM0Z3DG/nuNLulYCaqCoJYy9YQnCPv5yP8WnGaJ4W
 EJtJ06Joe3xcEYzNi2suuo9fFIq+vFbuWCFfYFO/UXJbPgbXh5AtZp+HKdVnBVjk1wV4
 QHZvA2EIyKaDrHuC4stewUQ5grnXx2Emgo0YEQgu4lYeeVK3eRscH5WXinPhh7rVSr9Y
 1ej4a1aa5zuthMBEI239+LKfo1+31iVCqDhGi4wl8EIKpxwkySCQHwuZYs7H5wAaRhb4
 pyjQ==
X-Gm-Message-State: AOJu0YwyacDpnDYUoHuYn+VL4/4sltLnLE6ncVh+f+w3/ZdY5Zf/tUrY
 UPdzTG1jZSUlbiqIoSxOt9iHq25Tc0HC6+iDiNdwWoJQ5bIDCcuh7df2EOjlKa6/rJsZtJ/nzRj
 t
X-Google-Smtp-Source: AGHT+IHZUV/7g8Q7Ay7lwMoeCqJbHYAPLuR7zU8YnkTW2irWRzcU0UK9lp4LsaP9eDaju1eQOGIbzA==
X-Received: by 2002:a17:902:e882:b0:1e4:70d0:9337 with SMTP id
 w2-20020a170902e88200b001e470d09337mr2121487plg.45.1712907238090; 
 Fri, 12 Apr 2024 00:33:58 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v3 13/27] disas/microblaze: Replace sprintf() by snprintf()
Date: Fri, 12 Apr 2024 00:33:32 -0700
Message-Id: <20240412073346.458116-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20240411104340.6617-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1


