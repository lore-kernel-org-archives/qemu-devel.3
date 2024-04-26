Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A59C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RTA-0000oX-2x; Fri, 26 Apr 2024 15:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RT9-0000m2-3F
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:42:51 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RT6-0002xH-Er
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:42:50 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-571c22d9de4so3503243a12.3
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160565; x=1714765365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0nMCqhYKzp5r2ZnGbDu0d0x6qlsj2uY/rxTdGpirtw=;
 b=qN6nv4rJWdPVWrNZoycw2XsB/z87C8srPfzNU8bIrHq+iSq30rZILMLDCinYkjOam4
 PDWeF44Na8uzf0xzL9Hd4TZTn5/wZxAhtjtfzQfD5FEcbtzy3NK0L+gGe7qpN/v8n4s/
 piZlqI9++tetkfnWLMxscTcTPo+AZIsoFNebY+gfdJMeaD9PhklZi4ULrmIuCeLMx1MM
 /SseirdfFr6FRAku2YRFDo4NrJejKUZVu8opo8rNWxeOVj/8tbRbn4FAvf7/qv4rPRl3
 BnyipHYfzkrkeQAFEJ/VSG5/6DjZGXR5JfuxzxIjjUl7A43wfJnrmTxM/iRI+z3FygyP
 5sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160565; x=1714765365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t0nMCqhYKzp5r2ZnGbDu0d0x6qlsj2uY/rxTdGpirtw=;
 b=XB1CXvcpj2h2zDftneBgyvvYZ5yWqqowT5aEDIH5Da87adTB9q3/Wh46dV/h/TB0hW
 UmFDlzV7kX1Ak3/Fv9yONTISG9Lyqk1b7yDPlmKWDgpB3NGanGEpXMdCkvYGG9EZwd5W
 /DLfQHszLkyKHL7m9f5H2y/Mvp5gZAc0bFoo7nR9K++3vJOfxZgnlMm7rg5CnhozXkir
 1DgVeWNpN4EebFdyhH0a4mE670OcuEq1BfKr+dUh3lpgZWWo7aLBqdleBOQ5oDLGjWvI
 w2npsrpL6ElkZYQzjoqaQsG5PDFR/HeSyUmxWk0d90W0KTaUuGZjQnSXDvHUGVERHYoF
 lJOA==
X-Gm-Message-State: AOJu0YxM4H3l8Znzqj/rRNtfvEyuMrRIQehhTr+nhUKkOirPmiiCi9p3
 kRB6R21Qeo3JjpX/Qa/Fi2l2wsPODj6ytpCQXds5WLKusNNwegtWA6GD5ZdqlGH7+Tjd+BHKH2A
 LDBc=
X-Google-Smtp-Source: AGHT+IHy1tLGCW7Nem/jvC7aOudNiOgNhqRxkuX/J7UTcovAnA7B/AIFC8TXFy/FYnitwiaNryc9TQ==
X-Received: by 2002:a50:a6dc:0:b0:572:6b03:607 with SMTP id
 f28-20020a50a6dc000000b005726b030607mr44695edc.42.1714160565256; 
 Fri, 26 Apr 2024 12:42:45 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 cf8-20020a0564020b8800b0056c24df7a78sm10395889edb.5.2024.04.26.12.42.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:42:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 07/38] gdbstub: Simplify #ifdef'ry in helpers.h
Date: Fri, 26 Apr 2024 21:41:27 +0200
Message-ID: <20240426194200.43723-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

Slightly simplify by checking NEED_CPU_H definition in header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240322161439.6448-2-philmd@linaro.org>
---
 include/gdbstub/helpers.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 6b97610f48..6277a858a1 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -12,7 +12,10 @@
 #ifndef _GDBSTUB_HELPERS_H_
 #define _GDBSTUB_HELPERS_H_
 
-#ifdef COMPILING_PER_TARGET
+#ifndef COMPILING_PER_TARGET
+#error "gdbstub helpers should only be included by target specific code"
+#endif
+
 #include "cpu.h"
 
 /*
@@ -96,8 +99,4 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 #define ldtul_p(addr) ldl_p(addr)
 #endif
 
-#else
-#error "gdbstub helpers should only be included by target specific code"
-#endif
-
 #endif /* _GDBSTUB_HELPERS_H_ */
-- 
2.41.0


