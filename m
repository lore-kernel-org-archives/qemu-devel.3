Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE50AC3ABCC
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDP2-0003A7-A8; Sun, 11 May 2025 16:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP0-00032N-Hz
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:02 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOy-0006M3-Uc
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:02 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7fd581c2bf4so3134641a12.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995759; x=1747600559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+47xY6VgImnNTtip66i9o8+87NnKPnRUllE3fysFtMc=;
 b=L/RI92aW195uuoBbiLA5tPPEqaSb32ljH90dOK7doMnSR7MtXA+o34L6W+t/jzTlHq
 e/x/eVbC70+2OKGqAiL32AbFwhTO7b6IvUZ5d45b6+eF4B0tIlsRpdZ6wSd2/Mn6/gYI
 t/nh5iNEH/mTvQBL6kGuBX7SyQz0PBcKUAXpgjf/YuF5wPGbZbUhj26sD5I/p5kakdGi
 eTgj3wQXE1cSsvseowfNSRsncY7TcR1OuD156rNrBtfJXN1t30KtYa2MN9vljvYxWHw5
 YVsmI7cOtcMHnk12MXuvuMwsVLD5xKn+ulwCLP7+J4Mia3y/WbqnEDwIvJTDWQO7zRov
 EIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995759; x=1747600559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+47xY6VgImnNTtip66i9o8+87NnKPnRUllE3fysFtMc=;
 b=e9tYTyUZBBk7OMSPiEwzoyaBBRt8p/xfET+2f0CUO0eqlQeN4LQdTrl0MDOvMzOnKa
 bX5Le2AeDBUH5ZpG7/l8ZTlKBoin0hnDqnMoyEFEvPvBfqzNdtYUWZTfK6P4ePzqyre6
 jz9IeP9qbKN13QJDnnqWxaV4i7OFwTT4lcRCnCpAPwgQi14/Nov5xt8DSNWaUoBSEvqT
 krJKkJihPkDWf3L+hyvdkgcEQGDmhIO2+oYCkAqd2ynlPW18nDLGMLTSuGWUFnA4o3TT
 V36186+u4XUh4GVHFrCcJKwehbXcbfy0BUHnIBYHsj7gdjmf3V3/9q/jj0XJcy8IvcbQ
 zoNg==
X-Gm-Message-State: AOJu0Yyk9vb+O13EvmVdKSup+MCBSE76nNJge3hSACdt9kMG3gifQ83h
 HC3tPZOeNR9bB30WuqhJXhvC9pUST/lLO5jEblaUK29azosTBOYqDiVf2qa2taQ4BoIF9nzeQ8z
 G
X-Gm-Gg: ASbGncu3BC1voecaVD9blQK/c6fRLTJfQnkAAm+X0+uCsWPtYAmOdyUPH1Hv1c2+as+
 f7P7uouJ0tiq/OCwSsab9gKkpeayuovnBSDOSysm1kPzrUaRTUZWXtJ6VrwYg9e7SnrI+XmIknR
 k/RbtO8FQNkU20lT/uBfGfQGdKQOLFOYNUPCaehMKmVoeyXRO374APiqjF0TozHTn4Pj6IeImyr
 txl9cWX68T638xMrN2PUrRSHwnxcOVtIHWCn1UNb+X3fHeTeCHy2lIbPP/SBi8fc2ywBqlmk9ci
 jJULsZXpuULAlEVCl+gv3OPSithPeVaotIV9RU0FHPUsyir4MM2sAOLOu4UlSN4MBt5BJe/GJyx
 RXltrFYGYNg==
X-Google-Smtp-Source: AGHT+IGkB0wwBZ24UZNz2jvUGzulmwKupcuTfGeLc3zEByCsduGwunpWgt6ERZdHkwxsWxKjP3i6Lw==
X-Received: by 2002:a17:902:d492:b0:21f:bd66:cafa with SMTP id
 d9443c01a7336-22fc8b40cb9mr160315155ad.17.1746995759394; 
 Sun, 11 May 2025 13:35:59 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 15/24] target/m68k: Remove env argument to gen_store_mode
Date: Sun, 11 May 2025 13:35:37 -0700
Message-ID: <20250511203546.139788-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Use the env pointer in DisasContext.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index c3cf1c9f91..2c2d83e61b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -844,8 +844,7 @@ static TCGv gen_load_mode(DisasContext *s, int mode, int reg0, int opsize,
     return ret;
 }
 
-static bool gen_store_mode(CPUM68KState *env, DisasContext *s,
-                           int mode, int reg0, int opsize,
+static bool gen_store_mode(DisasContext *s, int mode, int reg0, int opsize,
                            TCGv val, TCGv addr, int index)
 {
     TCGv reg;
@@ -1335,7 +1334,7 @@ static void gen_exit_tb(DisasContext *s)
 #define DEST_EA(env, insn, opsize, val, addrp)                          \
     do {                                                                \
         TCGv *addrp_ = (addrp);                                         \
-        if (!gen_store_mode(env, s, extract32(insn, 3, 3),              \
+        if (!gen_store_mode(s, extract32(insn, 3, 3),                   \
                             REG(insn, 0), opsize, val,                  \
                             addrp_ ? *addrp_ : NULL, IS_USER(s))) {     \
             gen_addr_fault(s);                                          \
@@ -1704,7 +1703,7 @@ DISAS_INSN(abcd_mem)
 
     bcd_add(dest, src);
 
-    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
+    gen_store_mode(s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
@@ -1738,7 +1737,7 @@ DISAS_INSN(sbcd_mem)
 
     bcd_sub(dest, src);
 
-    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
+    gen_store_mode(s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
-- 
2.43.0


