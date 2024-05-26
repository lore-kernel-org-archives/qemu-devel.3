Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A591C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJmR-0000xS-25; Sun, 26 May 2024 15:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJmD-0000R6-8o
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:29 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm9-0007mA-9d
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:28 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f44b5d0c50so16505195ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752604; x=1717357404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlbm4xMC/Lmwfgzv6+7V2/W9TFNWbl6hJzNLN1fFO5Y=;
 b=fB+hvliVWD5pAjZZr3QYts0avWzEnScVKw6Rc82jWBmU9RUSdRe7qsCj5lZx3vX30n
 NgylDTtQVhMYy5TzlHggYJcAusVFNk0f/Fh0pAdWW+evxidHwQGgiMvWaCOSYajNTT3A
 nHO8Rg7pk8QyAwMfaLAGLHFMYZsoa5egB+6/M5/OhMdGZs3MJO0CDU4+lZdxw9AxL9U3
 kYpPz+B7x5l50z6z/SA3W/X4kIxhylyRsVOwEfJk9YJ1QJR3wcJ/SXB1g0VLYmb3EySS
 Pe606/tT0LwfReGJyxnha9Dk8QlV93IC4gc7eDcH32hoJuqvwhYLd5cCI8iLBio9TK3x
 phuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752604; x=1717357404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlbm4xMC/Lmwfgzv6+7V2/W9TFNWbl6hJzNLN1fFO5Y=;
 b=IuC7YgKpkDEMwSAE3S4dqer5l0nVoGaWDE51GGkcRxLBz0R2PGmeslcxenEYrqr51t
 OWy0CG1df9kU0/hElu+lkn/GGHvAxvp0/Fy/Jf+Mioij1BFYmebBHmI68y0Rcb6W6Lk/
 ceLuW8+n37xY682ScgsfjJo/1cv6dhpxUECiIbOR9AtxqVWyclii+w6b0oNmM4p6j4EM
 MSk9ief9LkrG80RgNvSDEPS+XI0rQcZzuyyWNGzxHANs5lZtrtTsZIYmvO8BYKVfXVJK
 gb4/GmSQavKoogNxiIREkgPV7HYU1WjmZ57xw2VRtRFH3RKTVTQNfKV2LlY/yW0uN/Pe
 tp1Q==
X-Gm-Message-State: AOJu0Yzcn2P9/QxFNiR5dx11tPhihwiB8H2mUeYUoOUgJNStaahVQPkU
 Id7Niw9fOuoDzmJvI/MnbQp46HN8U4Ya6ABVjWIVnJj7UyVkWORy0YV5NXl3pHvmvCcEreHr3gm
 Q
X-Google-Smtp-Source: AGHT+IGNHuyKyemrSsOohuov4tHqTScq3e/CRY58vcBRQYgGGula9KTMtcJogZsPY4QMgpZ9i5ztVA==
X-Received: by 2002:a17:903:4114:b0:1eb:7172:673b with SMTP id
 d9443c01a7336-1f4486f1d23mr55513045ad.16.1716752603887; 
 Sun, 26 May 2024 12:43:23 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 36/37] target/sparc: Implement monitor ASIs
Date: Sun, 26 May 2024 12:42:53 -0700
Message-Id: <20240526194254.459395-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Ignore the "monitor" portion and treat them the same
as their base ASIs.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/asi.h         | 4 ++++
 target/sparc/ldst_helper.c | 4 ++++
 target/sparc/translate.c   | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/target/sparc/asi.h b/target/sparc/asi.h
index a66829674b..14ffaa3842 100644
--- a/target/sparc/asi.h
+++ b/target/sparc/asi.h
@@ -144,6 +144,8 @@
  * ASIs, "(4V)" designates SUN4V specific ASIs.  "(NG4)" designates SPARC-T4
  * and later ASIs.
  */
+#define ASI_MON_AIUP            0x12 /* (VIS4) Primary, user, monitor   */
+#define ASI_MON_AIUS            0x13 /* (VIS4) Secondary, user, monitor */
 #define ASI_REAL                0x14 /* Real address, cacheable          */
 #define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cacheable		*/
 #define ASI_REAL_IO             0x15 /* Real address, non-cacheable      */
@@ -257,6 +259,8 @@
 #define ASI_UDBL_CONTROL_R	0x7f /* External UDB control regs rd low*/
 #define ASI_INTR_R		0x7f /* IRQ vector dispatch read	*/
 #define ASI_INTR_DATAN_R	0x7f /* (III) In irq vector data reg N	*/
+#define ASI_MON_P               0x84 /* (VIS4) Primary, monitor         */
+#define ASI_MON_S               0x85 /* (VIS4) Secondary, monitor       */
 #define ASI_PIC			0xb0 /* (NG4) PIC registers		*/
 #define ASI_PST8_P		0xc0 /* Primary, 8 8-bit, partial	*/
 #define ASI_PST8_S		0xc1 /* Secondary, 8 8-bit, partial	*/
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 7bdf99e0c0..2d48e98bf4 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1395,6 +1395,10 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case ASI_TWINX_PL: /* Primary, twinx, LE */
     case ASI_TWINX_S:  /* Secondary, twinx */
     case ASI_TWINX_SL: /* Secondary, twinx, LE */
+    case ASI_MON_P:
+    case ASI_MON_S:
+    case ASI_MON_AIUP:
+    case ASI_MON_AIUS:
         /* These are always handled inline.  */
         g_assert_not_reached();
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index dba0eaa30c..d2478a0246 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1607,6 +1607,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_BLK_AIUP_L_4V:
         case ASI_BLK_AIUP:
         case ASI_BLK_AIUPL:
+        case ASI_MON_AIUP:
             mem_idx = MMU_USER_IDX;
             break;
         case ASI_AIUS:  /* As if user secondary */
@@ -1617,6 +1618,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_BLK_AIUS_L_4V:
         case ASI_BLK_AIUS:
         case ASI_BLK_AIUSL:
+        case ASI_MON_AIUS:
             mem_idx = MMU_USER_SECONDARY_IDX;
             break;
         case ASI_S:  /* Secondary */
@@ -1630,6 +1632,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_FL8_SL:
         case ASI_FL16_S:
         case ASI_FL16_SL:
+        case ASI_MON_S:
             if (mem_idx == MMU_USER_IDX) {
                 mem_idx = MMU_USER_SECONDARY_IDX;
             } else if (mem_idx == MMU_KERNEL_IDX) {
@@ -1647,6 +1650,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_FL8_PL:
         case ASI_FL16_P:
         case ASI_FL16_PL:
+        case ASI_MON_P:
             break;
         }
         switch (asi) {
@@ -1664,6 +1668,10 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_SL:
         case ASI_P:
         case ASI_PL:
+        case ASI_MON_P:
+        case ASI_MON_S:
+        case ASI_MON_AIUP:
+        case ASI_MON_AIUS:
             type = GET_ASI_DIRECT;
             break;
         case ASI_TWINX_REAL:
-- 
2.34.1


