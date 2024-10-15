Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9868CFC27C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jmc-0001qC-5d; Tue, 15 Oct 2024 11:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jmN-0001R1-J8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:48:12 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jmM-00014w-1q
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:48:11 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e4e481692so3061738b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007287; x=1729612087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NP/jQdl3vCj51cE4P9kHFWkOQjoBpIwLQmMBNAGca+s=;
 b=P0xnVIykjJvmMwrw8e4CESzUI0BZYmTpBTxnF8SVOE05KQ4fHNUy+iilIyDz1M7z/S
 zTLdtnIyw0nu9DW64YKqviCTTTG0WdK/t51DPLq46EKxbcnmqzWJloeLrymJRBkXuYj+
 IAa/8MxLiFN8c6cYoLFsVlvW8ZsjmvFV0Qjug/5q/GmgkBaeawZg7kJ6lE3sqlASBe8o
 SHIuGYh2sRWm7ZO03lKRnF1YWEwIsb27Gvf07lb3u5na5j/nNRLGHqHxYR+Kw/PhUTrD
 r0oL7HkH9LXElHPSluxOnZq9hXPFTclJHLC+6XV7pLmMymT0Ee7jDBlTDfw4ROIPifGL
 +C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007287; x=1729612087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NP/jQdl3vCj51cE4P9kHFWkOQjoBpIwLQmMBNAGca+s=;
 b=lx+wiccTguFuUEO/glLSTbroiqcKRWWXceTIP4qd2qqwI10NaFp6gCcX7h2dJQMu5w
 FJQW8P5oatIrNGn/ESBhRQIEvvKeVgyE8NsVtRLVQv8Bjf7L34CA7C+fVnef3AwG9fo5
 QjyTZnLUXIGnjVDm+MoZHmneHp5XBF/9DCe4zuLudObx3wKCHKCOGDdBG3VNeaeOIBS+
 7poDlZrz1YTBr5k68e+YshXM2zC3kxPyDTCN6bntFJP1Stin+Z6Xq+XI+8Gb4FG7uETw
 1JHJTixpXUeIFzj6cggPnsqOXn+zR2yA+S0MjTb43bbQHWsRY9PE/BAsqnnIPX8Cwgak
 iXyg==
X-Gm-Message-State: AOJu0YwKaurMYS77hIwcmHtm5/6wrBCyb6DW2XNaEmU4ojtAnYb7lFJO
 kG52erRD+yql5LFao6pglO3HfWUYkSHS+FtiO2wQItIoh4UqiFNlszqWTyoXBdFgfh3XmcSXwEZ
 7
X-Google-Smtp-Source: AGHT+IEBflXUUGZlRXWI2uD3pydZPOG/qpmoJV/2xBKZ0+M4zImhndUoRc7zDY+Ad9LD9uqsvwBAyw==
X-Received: by 2002:a05:6a00:10c3:b0:71d:f012:6de7 with SMTP id
 d2e1a72fcca58-71e4c1cfd6fmr19522313b3a.27.1729007287043; 
 Tue, 15 Oct 2024 08:48:07 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e773a3c39sm1418099b3a.73.2024.10.15.08.48.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:48:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 28/33] target/mips: Have gen_addiupc() expand $pc during
 translation
Date: Tue, 15 Oct 2024 12:44:37 -0300
Message-ID: <20241015154443.71763-29-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010215015.44326-12-philmd@linaro.org>
---
 target/mips/tcg/translate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index c0b97539a29..0ccf32d185e 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -11428,20 +11428,18 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
 void gen_addiupc(DisasContext *ctx, int rx, int imm,
                  int is_64_bit, int extended)
 {
-    TCGv t0;
+    target_ulong npc;
 
     if (extended && (ctx->hflags & MIPS_HFLAG_BMASK)) {
         gen_reserved_instruction(ctx);
         return;
     }
 
-    t0 = tcg_temp_new();
-
-    tcg_gen_movi_tl(t0, pc_relative_pc(ctx));
-    tcg_gen_addi_tl(cpu_gpr[rx], t0, imm);
+    npc = pc_relative_pc(ctx) + imm;
     if (!is_64_bit) {
-        tcg_gen_ext32s_tl(cpu_gpr[rx], cpu_gpr[rx]);
+        npc = (int32_t)npc;
     }
+    tcg_gen_movi_tl(cpu_gpr[rx], npc);
 }
 
 static void gen_cache_operation(DisasContext *ctx, uint32_t op, int base,
-- 
2.45.2


