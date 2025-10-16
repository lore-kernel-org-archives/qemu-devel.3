Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB4ECCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mvr-0000w9-2l; Thu, 16 Oct 2025 08:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mus-0007If-Ra
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:16 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mum-0008I7-TS
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42701f2ad61so257307f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617020; x=1761221820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6gKrkgV/XFFnEzXtuSZ4dYQl1RcVRRqtXlSYWlgaUZA=;
 b=SInyM5wz+wjuEtevRB1Oim8XSdr+4OtOKExYIRC2mT2YeMhGuoWkA5k3dQTEa3pYn0
 tYhLTesYc3mre+z7bY7rqLdJER89WvITxGeEYWTinJLgzRPTiN3lPmvTRai1JbEKnY00
 nI8HAJBAklmomJiz49Xpk22AI7HkIpCvMZpHERIYc+PmiicbqxGYF88NwDqF5rNe6Ze6
 WKxTq4rnCAjwzoen7zy9Z8SqWPHJwihgCB010BHoZ7KSMqis/uuF3A6m3oOqSn50WUsg
 KjX1IbNgQmobDA1KKLY+VwTVhV3ZvBBKna3nfwu7UMNScFIxupqyurmfrLlSoVU8QIZl
 KYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617020; x=1761221820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6gKrkgV/XFFnEzXtuSZ4dYQl1RcVRRqtXlSYWlgaUZA=;
 b=IFmZlMaGxv4dp5+4i9JEO1HbK8kaaYNgmRTH0+Y1TnH5Y0aPVUQC0LkxhygRpzZuCW
 YDQwp4CbU3VqFbto7nV5VPZdUwUl6zR69UPqviBaTaqZUzVzGa0eSpmdR5p1RA83Q0UW
 SpUy4mSf1BR40S2HDM4ebuPs8axpP1RDPObnTZVYvDnLzBuLJb23kAAW1n6uUtz8BmDG
 t2UftnxjJLCAxN8ji8+cqtGVmaKPVnUi1a8bFaP3OH2n42CRwM+8e0DHdL5Znf4NTKmk
 6y0svNLV+WqpDzsSK6475xD5lQZzYeiJ/vf1OPGsou3ZipZpzfr3XwTgUIoJI7zCUgjC
 5MZQ==
X-Gm-Message-State: AOJu0YwRtXkZtUS/q8yMsLRKfBN8R2VLXGRL3Xoa64iYpzJDSPeFFB8o
 jJTEFw0QsflwxRon1hRY8W1FXY2mzi4i9rdqYw8Vf1r++iPC2Z/RH1+mKxw3jkbnSpnG1iELG2k
 0XD8bNig=
X-Gm-Gg: ASbGncv8Ih2tqn2ZDTEuzN/RlWpvZGt+BNiQDeK00NpZ4J2Gu/LvjpSm/NZvIpdEFYG
 3Nh1TRJuxF/0LNEsZcZu3l1FNHYGnYQ5kK86GnhuoRU7gglV/yLZOpoSMa6D0lge/sFTVULqvNd
 CPYnrocBVoPURWyr5nG0qAFidhpkZPpKs8glu+j3uT5E0vQPprfiL7yqX9ns3S0/XaQ1taGT6yF
 zTkJyJeQeAwKGXhmKLEp09TREJeudngv37KxadF6mw9EslJngomTz8qHGuOjxZfJFjlxHESW+38
 kkMJxOnOaqQSO76uwLBKfOfXs4qSXapVfXFEj7haa9jO/QsezGa3ZP2msOJ7tKS9CM3bYZF/HEQ
 7AUmpK+i9v2bcbaL+TgOvlNYwRbEIMLTck7PgCXLCrV/xUAldFYl68uFk9lBBE1lNUeR6pGqLxY
 z5nav6iYTw9QXr3yXC6qoQS7riS1Rbu9PuAv9gV7EuCrUw+BnWFhwvXaxcbVWxyb+f
X-Google-Smtp-Source: AGHT+IEEz56+uAUGtf26GfC8Q0a8Rp7b305wmohG/a4CqhcMJmJ1b1VCC59nhvAOYlCbHaT9VzyWNw==
X-Received: by 2002:a05:6000:420c:b0:3f4:5bda:271a with SMTP id
 ffacd0b85a97d-42666ac39e4mr18685359f8f.6.1760617019788; 
 Thu, 16 Oct 2025 05:16:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e13b6sm34741497f8f.44.2025.10.16.05.16.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/75] target/m68k: Remove unused @cpu_exception_index TCGv
Date: Thu, 16 Oct 2025 14:14:34 +0200
Message-ID: <20251016121532.14042-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

When moving the @exception_index from each target ArchCPU
to the global CPUState in commit 27103424c40 ("cpu: Move
exception_index field from CPU_COMMON to CPUState"), the
@cpu_exception_index TCGv has been created for m68k target.

For years, no code ever used this register. Simply remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250924171308.53036-1-philmd@linaro.org>
---
 target/m68k/translate.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 97afceb1297..0cee54f4900 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -45,7 +45,6 @@
 #undef DEFO64
 
 static TCGv_i32 cpu_halted;
-static TCGv_i32 cpu_exception_index;
 
 static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
 static TCGv cpu_dregs[8];
@@ -81,11 +80,6 @@ void m68k_tcg_init(void)
     cpu_halted = tcg_global_mem_new_i32(tcg_env,
                                         -offsetof(M68kCPU, env) +
                                         offsetof(CPUState, halted), "HALTED");
-    cpu_exception_index = tcg_global_mem_new_i32(tcg_env,
-                                                 -offsetof(M68kCPU, env) +
-                                                 offsetof(CPUState, exception_index),
-                                                 "EXCEPTION");
-
     p = cpu_reg_names;
     for (i = 0; i < 8; i++) {
         sprintf(p, "D%d", i);
-- 
2.51.0


