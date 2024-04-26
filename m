Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A647FC19F4F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RTj-0001Wy-Es; Fri, 26 Apr 2024 15:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTP-0000zM-1N
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:43:08 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTM-00032A-Bo
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:43:06 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a55911bff66so327391066b.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160582; x=1714765382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GRlD0UJ4FFPuLeyFAJhX+j56Axb9nXKO9LompOTbz0=;
 b=aCjKQo9M3jm32LjSQvYg+f346xUKK6bceDRnpmUqdQFHUqedoCivV6KQaYtJ4fy0q5
 ETWAd0WK9383sVCaRxHMiLtlI15Eza9dO/jsDUV/Rz4BiI5nm1YU74UbeM2yhG6qSDj4
 KtaLgMgpw1dE28I0vJ8OxZnwfoU5eqZazZWpM+Hwo61yr94ijJfNjg/PHJ1/zqGCoGgF
 zDvOUJkJY/f40lsxpd4xCyEeGUbkws4Z8+M+kPKOucwsBAwrotcLJDif/Wtv9ONYzM2s
 qCBYwxpgqj3ommy+jXbdtWDN3bYo3qDjO8sCrcK2QJOb61JuUTcVAchZ+BTK+CKWD3+E
 BCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160582; x=1714765382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/GRlD0UJ4FFPuLeyFAJhX+j56Axb9nXKO9LompOTbz0=;
 b=IoAhvjVLXFGrV+zbzZ0hHGuAS3uqGPKA0JLaardonX5y7yjVJj+PYnfsKzwMhjHVCi
 WZJ7kNSSCVb3RKf+YC6EF2W4odZzIV5OAW0Uw29duWxnLreAugoR1Tw329jFIjrQUCp9
 caVvgiadEjYWDrjzNSHuJjI1PN6kn4Vblw9kV6fk/dBe+uKzI5jQ0vLlyucqn3t+xRxd
 RkI4TM/GFez8Ls2qH5bZlgmzAXhv1NoUqN24GXeDkbCgl082e3/1pjZBAl4Zsna5/O3T
 Xgy112O5E9N+ERfD0yWVHFPTsHtWVXWPr4AR/IpXFce6FENeQPmoB3110y3eH1L7X8P2
 bv7g==
X-Gm-Message-State: AOJu0YwjNvFSPplrnOkHOGPUk00jzBzyt1DRZ+kVF58uHXGU/kaZenTS
 jPN73LbQ9hlYIqU941Pjhn0aSzjCZi6me+jwRxiwt8pcNuVbEl3w6INHlXvcL4EVIvWc9brUX6g
 Q3g4=
X-Google-Smtp-Source: AGHT+IG6A8FnBbnMBUpZM52sQlqiWMtOTwbyU0wTqUCvEyv+4YX+LfAkHA/i8kisOgzCXauqVx2SXg==
X-Received: by 2002:a17:906:17d7:b0:a55:664b:fa35 with SMTP id
 u23-20020a17090617d700b00a55664bfa35mr274955eje.6.1714160582240; 
 Fri, 26 Apr 2024 12:43:02 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 jw24-20020a170906e95800b00a58a3b8589csm2615549ejb.21.2024.04.26.12.43.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:43:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 10/38] semihosting/guestfd: Remove unused
 'semihosting/uaccess.h' header
Date: Fri, 26 Apr 2024 21:41:30 +0200
Message-ID: <20240426194200.43723-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Nothing in guestfd.c requires "semihosting/uaccess.h" nor "qemu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20231212123401.37493-8-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 semihosting/guestfd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/semihosting/guestfd.c b/semihosting/guestfd.c
index 955c2efbd0..d3241434c5 100644
--- a/semihosting/guestfd.c
+++ b/semihosting/guestfd.c
@@ -12,10 +12,7 @@
 #include "gdbstub/syscalls.h"
 #include "semihosting/semihost.h"
 #include "semihosting/guestfd.h"
-#ifdef CONFIG_USER_ONLY
-#include "qemu.h"
-#else
-#include "semihosting/uaccess.h"
+#ifndef CONFIG_USER_ONLY
 #include CONFIG_DEVICES
 #endif
 
-- 
2.41.0


