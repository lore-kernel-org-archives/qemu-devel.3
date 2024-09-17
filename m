Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5F1C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTvm-0007Mu-PQ; Tue, 17 Sep 2024 04:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sqTvj-0007MN-NL
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:51:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sqTvT-0008Vt-Fh
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:51:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cb7a2e4d6so44547065e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726563067; x=1727167867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSYHu5lBYgP+YuUarCXjaJs9Yl4nMxFLvamP9MQ79yg=;
 b=QsjtFGM39D8cZcs0OAE25i3TMCyxiBkBSXhKIt72H1d6xBtRUCRODSiklg25t1rbWv
 FYDtbzHpyWiE51MRY3TNbevKgQmZkpqysTNjIA+8mLh6/bEibTQ66O4etg1q6eA4kHfq
 W3n29XrcGR4ym+WQOB1YJGC8rLICOprBafQCAWu8Lv1v5opKy0BCBCsnu7+aGyI9x1uz
 RpV7Aquwq8pktb2wJMn+8Ot3qdxdARtdZEJ3idCnsR8DOG17nmix1YpwGec4V804W1pN
 QcjGDifwtBTzdLB/3CdrnqX9eeKe2nqqLOakKK+Rp79+Nnkt5WOqPMFFzJf6tvvUYFzK
 p4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726563067; x=1727167867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSYHu5lBYgP+YuUarCXjaJs9Yl4nMxFLvamP9MQ79yg=;
 b=npY6yaP0G3qYPtHGMzySe9v2dbbHucjXdPl4uWrZm7yi390WFBMURYBKr+bEaTqFws
 3IwKvXovz/UF5CdGkUJ4mzeG6eRhx4/SjI1wyGAW0ZAGR9gZbVl9xcPAWs8xBolQeb8g
 tVSKBxpyuXDTn3Sb9eFLElh47D4Ry9yldF+rhJD8OkVL7sB6+AGbbaeJ3Gn46CsIkXur
 nnSikCL9ZbKl4SVOkCQrBjfIDW4TdXyuRl0iJHtALkv33UIyk74UrF6cvDO0vUtSG2hs
 wedT2HRZGO3Qa/c1jjfN3i7oJ1ONOX3QKEy8ygOtGLDset+MiAkOjjLDFvreIkJAPMez
 hRgA==
X-Gm-Message-State: AOJu0YzVDP7OaVTf2iybYWX7y4Y1mMD9fwuw7ZP7cy+OKgMNLqB5TIgv
 P6xO5HwWUQCrgKkiGJTehCOwSEPRK+McHw3s0XrFOnrKqwe8lh7nJSYi369wFB/l1yBCNjKfIvD
 wDHM=
X-Google-Smtp-Source: AGHT+IGVgam6pQh1MOtIgKCFNO9doLYN/GbfP6pAXbzFSHjpkWa1yOXld6hwpktMiXmnTDSJZyWkmw==
X-Received: by 2002:a05:600c:5121:b0:42c:b377:3f5f with SMTP id
 5b1f17b1804b1-42cdb547e96mr135717025e9.14.1726563066903; 
 Tue, 17 Sep 2024 01:51:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.131.223])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b189986sm129889615e9.29.2024.09.17.01.51.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Sep 2024 01:51:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/3] tests/unit: Really build pbkdf test on macOS
Date: Tue, 17 Sep 2024 10:50:56 +0200
Message-ID: <20240917085058.1740-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240917085058.1740-1-philmd@linaro.org>
References: <20240917085058.1740-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Fix a typo to run the pbkdf crypto cipher tests on macOS.

 $ make check-unit
   ...
   87/102 qemu:unit / test-crypto-pbkdf      OK      2.35s   17 subtests passed

Fixes: ebe0302ac8 ("tests/unit: build pbkdf test on macOS")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-crypto-pbkdf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/test-crypto-pbkdf.c b/tests/unit/test-crypto-pbkdf.c
index b477cf4e4b..12ee808fbc 100644
--- a/tests/unit/test-crypto-pbkdf.c
+++ b/tests/unit/test-crypto-pbkdf.c
@@ -25,7 +25,7 @@
 #include <sys/resource.h>
 #endif
 
-#if defined(_WIN32) || defined(RUSAGE_THREAD) || defined(CONFIG_DARWNI)
+#if defined(_WIN32) || defined(RUSAGE_THREAD) || defined(CONFIG_DARWIN)
 #include "crypto/pbkdf.h"
 
 typedef struct QCryptoPbkdfTestData QCryptoPbkdfTestData;
-- 
2.45.2


