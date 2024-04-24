Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13514C07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgVD-0005yA-4r; Wed, 24 Apr 2024 13:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzgVB-0005xt-NR
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:33:49 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzgV9-00030c-U3
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:33:49 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34b029296f5so44975f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713980026; x=1714584826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RC3I7eEuU1Vrf2ad1mlMtTC053sX+mHPqI7q34t9+Ao=;
 b=rn1DLcmo5ijKpH8qjcbRGo8MKtllfDSTlNvNZX0hqByVmkETd1aOvEOhlDavaACMbT
 6VGgBJj7k3LwDGJu6RWN87exvLKrbT1/PtahXRKmo7oU1lRolvAmKQ7lu17M80cR+8xj
 sS88G9nCqocHH/7lwxITSDTGa5vrvhR01jPkFuOZAzODyAAChMVxgW2Ayab3GAF7wEWC
 wcAGXO5unYLVm/gDqMiX5dQBhBcfprGeZRFaD6FqEegG83akzeGY0xgW/ZIppOah0dNZ
 TNKmjaryp3vBbkChodXqN43gsj6ufY+/xyHXgJVZWraIOh02nLtEUm4fGWyWO36VrAPZ
 2zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713980026; x=1714584826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RC3I7eEuU1Vrf2ad1mlMtTC053sX+mHPqI7q34t9+Ao=;
 b=DQ2vq9Y7tSIBHJdqswofHn6w0sLD/0J5FPl3hOh3QNRB4ChlQmdUcRn91vb8xe0PRa
 wtPQ6+1VQkXQtE22Or60K9OFMd+hZYaE0V0QtoDvV9zMnBCgoohpfjCzUaj8wT9kO5hv
 LZG1jd2AsUlEjJGgG0r7+9ixsHeGdnBov5O+BMUiQyArH+xygnHbr4Vg6/zGtpO9mJfT
 wz3VYNHshQsQIgOKjFUtrjRXhatZ0/3BMbdk0K1cbOi3hA71c1EQDPELHEt1SpTos785
 XNE/bk/jA1E1dQa8KWo/5ZIbOlkP25FTCLoMjk1rbN9v7SGy08oqFGuic6ow7V+ZVgQc
 yvDA==
X-Gm-Message-State: AOJu0YxjaVltXAc2VudbARauvPXV1cewkc3+Rr25FvSz5r15HSqvQaGh
 aiIPHWUJ3rEN2qw/GWv8glCwEnEI3P9DXKu9kf6gjuia5KN9WgaWjvJE3CgaR+SRzXP1ER5HcF9
 T
X-Google-Smtp-Source: AGHT+IHUxY5NPMfGB+DSEuwBc9Ru++YOfqw8opfpXvkav63vpLKwF6crXniKmC3FD7yyAkHid1WS5w==
X-Received: by 2002:a5d:6b90:0:b0:34a:2b3f:262f with SMTP id
 n16-20020a5d6b90000000b0034a2b3f262fmr2680321wrx.32.1713980026045; 
 Wed, 24 Apr 2024 10:33:46 -0700 (PDT)
Received: from localhost.localdomain
 (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr. [176.184.51.42])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a056000014b00b0034ab4cb8af1sm11782180wrx.29.2024.04.24.10.33.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Apr 2024 10:33:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] accel/tcg: Rename load-extract/store-insert headers
 using .h.inc suffix
Date: Wed, 24 Apr 2024 19:33:31 +0200
Message-ID: <20240424173333.96148-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240424173333.96148-1-philmd@linaro.org>
References: <20240424173333.96148-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Since commit 139c1837db ("meson: rename included C source files
to .c.inc"), QEMU standard procedure for included C files is to
use *.c.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented in the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Therefore rename 'store-insert-al16.h' as 'store-insert-al16.h.inc'
and 'load-extract-al16-al8.h' as 'load-extract-al16-al8.h.inc'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 .../host/{store-insert-al16.h => store-insert-al16.h.inc}     | 0
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 .../host/{store-insert-al16.h => store-insert-al16.h.inc}     | 0
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 .../host/{store-insert-al16.h => store-insert-al16.h.inc}     | 0
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 accel/tcg/ldst_atomicity.c.inc                                | 4 ++--
 8 files changed, 2 insertions(+), 2 deletions(-)
 rename host/include/aarch64/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename host/include/aarch64/host/{store-insert-al16.h => store-insert-al16.h.inc} (100%)
 rename host/include/generic/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename host/include/generic/host/{store-insert-al16.h => store-insert-al16.h.inc} (100%)
 rename host/include/loongarch64/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename host/include/loongarch64/host/{store-insert-al16.h => store-insert-al16.h.inc} (100%)
 rename host/include/x86_64/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)

diff --git a/host/include/aarch64/host/load-extract-al16-al8.h b/host/include/aarch64/host/load-extract-al16-al8.h.inc
similarity index 100%
rename from host/include/aarch64/host/load-extract-al16-al8.h
rename to host/include/aarch64/host/load-extract-al16-al8.h.inc
diff --git a/host/include/aarch64/host/store-insert-al16.h b/host/include/aarch64/host/store-insert-al16.h.inc
similarity index 100%
rename from host/include/aarch64/host/store-insert-al16.h
rename to host/include/aarch64/host/store-insert-al16.h.inc
diff --git a/host/include/generic/host/load-extract-al16-al8.h b/host/include/generic/host/load-extract-al16-al8.h.inc
similarity index 100%
rename from host/include/generic/host/load-extract-al16-al8.h
rename to host/include/generic/host/load-extract-al16-al8.h.inc
diff --git a/host/include/generic/host/store-insert-al16.h b/host/include/generic/host/store-insert-al16.h.inc
similarity index 100%
rename from host/include/generic/host/store-insert-al16.h
rename to host/include/generic/host/store-insert-al16.h.inc
diff --git a/host/include/loongarch64/host/load-extract-al16-al8.h b/host/include/loongarch64/host/load-extract-al16-al8.h.inc
similarity index 100%
rename from host/include/loongarch64/host/load-extract-al16-al8.h
rename to host/include/loongarch64/host/load-extract-al16-al8.h.inc
diff --git a/host/include/loongarch64/host/store-insert-al16.h b/host/include/loongarch64/host/store-insert-al16.h.inc
similarity index 100%
rename from host/include/loongarch64/host/store-insert-al16.h
rename to host/include/loongarch64/host/store-insert-al16.h.inc
diff --git a/host/include/x86_64/host/load-extract-al16-al8.h b/host/include/x86_64/host/load-extract-al16-al8.h.inc
similarity index 100%
rename from host/include/x86_64/host/load-extract-al16-al8.h
rename to host/include/x86_64/host/load-extract-al16-al8.h.inc
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 97dae70d53..134da3c1da 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -9,8 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#include "host/load-extract-al16-al8.h"
-#include "host/store-insert-al16.h"
+#include "host/load-extract-al16-al8.h.inc"
+#include "host/store-insert-al16.h.inc"
 
 #ifdef CONFIG_ATOMIC64
 # define HAVE_al8          true
-- 
2.41.0


