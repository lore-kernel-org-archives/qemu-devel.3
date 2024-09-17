Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1871EC35FEA
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 06:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqSA9-0002Eu-D1; Tue, 17 Sep 2024 02:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sqSA2-0002B4-4E
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 02:58:06 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sqS9z-0003Cc-BL
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 02:58:05 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f75c56f16aso65576361fa.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 23:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726556280; x=1727161080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cSYHu5lBYgP+YuUarCXjaJs9Yl4nMxFLvamP9MQ79yg=;
 b=rpJq/MM0QPi0dFV7lovW69ySVH8TS1huhVHIyfvf/SysfncRNYmMwQo2Be2ddyjWkn
 Q3sUCFv63HPJiUQpV6EONxMCxQtBdEmFS5CmkdUc/aMJSuEMFFGHksG55lh0nrLYAKjY
 yqhTci7JEp90SBZOVSIluo5GJyG3Oqn28voHSSO2cgR7RmpECvIrLEHK4l01EkEPOHbp
 1PkZAIeiTtbcNM28VhnDG/tpw7lXii0WodoJeATD0HwtYUmurhIDFiQzwDitZdfLHB7u
 CA0yA1eQbkHWXLWAQqYrgtUzPLNKWm8B8Rxm/VIMYbMUzMitD1T97DVeZcolSGnfn0OE
 tBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726556280; x=1727161080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cSYHu5lBYgP+YuUarCXjaJs9Yl4nMxFLvamP9MQ79yg=;
 b=r5Iug8e+LipnY81RBI92sextkcYUht3xuDlchb7pR3j5MQ9g7+aa305A4QaWHjGqeW
 UIpHjzqgkixd05M6aaqVv3p4FjM0/PukUZSmiusXwJsrHJSJxKTQOVmnNO6LUOv7lVvy
 M+qmSXUQQ2yfrq2hWg4qGTqh95w2hwEo3AVjBXwd1p/eg+8AvleTAC0/ToUyHVHT8Xez
 uBdVitnHZegnksx67vrxl++oPZyblSD4VeJlYMjpbzwjW3bKWTP7lxnmkoJ+nSPFEWG+
 k5sLhn9laVQ6q8H+/JeMAe8Uf4YMImezePq5XLnqnWV6JjH+iASFTIjLA0SpxQYE8VVF
 NPMg==
X-Gm-Message-State: AOJu0YzWPwzqxCWY+6ErTpKUq7tZCrQ7oriEG1kJ56eKptP+gYzBuksu
 6YUnPijhORf7DVRj3Err0IRzI9omOIaw48mKIFNsZwVysukfThg69aoapi7iSh8Tn+fMJlLWZVg
 L
X-Google-Smtp-Source: AGHT+IGxO1yPEeWmwzTh2ISe6LjTMvWeubk/OTHWo/D6cYrABDr1jI687MkKdlmKMzm8JtKnZo7czA==
X-Received: by 2002:a05:6512:1054:b0:52e:9c69:b25b with SMTP id
 2adb3069b0e04-53678fc859amr9234072e87.28.1726556280261; 
 Mon, 16 Sep 2024 23:58:00 -0700 (PDT)
Received: from m1x-phil.lan (sto93-h02-176-184-36-77.dsl.sta.abo.bbox.fr.
 [176.184.36.77]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967bbsm406286566b.8.2024.09.16.23.57.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Sep 2024 23:57:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/unit: Really build pbkdf test on macOS
Date: Tue, 17 Sep 2024 08:57:36 +0200
Message-ID: <20240917065736.27883-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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


