Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E763C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RUd-0004RC-0U; Fri, 26 Apr 2024 15:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUH-0002l7-7N
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:02 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RU8-0003Fh-MR
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:00 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a559b919303so328885666b.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160629; x=1714765429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7EfD6ZqpZav9ENI55PjcdOF+ptN44Hp+/BctxTPyg4=;
 b=cJVZOFYXU+L6mWEHIDpfDAq3AKeZQj6D1w6JUy+oatdX/eww/rJactZnOXbwQ2N6xQ
 7b6CxLcxrZ2BQa4sJwBtDhsQnNmxPrH77jyE6nkrw2mdibG2VDcMcXeHqdoPy7tGenHP
 PyNZXT5Cz9WzX18ECn0xlzipATxfGcnRfWkVfO6OsS7pR7iqS/lNhuoda7q2ROjcuUMl
 +wJFpjpvMGkjwXnZYzkXvENrvbqCRvd6Gcckf7C1Q/RWnQZiXeeeX18DRQGd43Rxoz6R
 X7+Qe27rRSoDJIFInjKR1w4LtisyYq9F7+EnahRDQxxNMyUbC7eDhP1gb5UTeR+QUKTz
 v/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160629; x=1714765429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v7EfD6ZqpZav9ENI55PjcdOF+ptN44Hp+/BctxTPyg4=;
 b=ikRBPYWFO8iOpj+iuWkXst5CRT2hwZnjDU22z/CTshmQEkPZ11G4Fy3jFT039RBEyP
 71uTJpBaIbuQhxctgzME2iK7ZXrpbXtbDpsd8rkCYGQSoNX64cmOhXbUdpdsMVm/6PAp
 gAUQd+zF2xFGsauYIDzHBoTZ5iYiOhEbR7Li1kGgaA+Y/ccVBQ9xGPBeRN5UELrMemiO
 7qqdzahOTi2+q0R+xCU+cOZVL8jzfA1zSNrfLg/dVQzYkyaZ8nH8HSxnP6+F7qDokHNs
 oiCgbTolCw+w6wFdTcuv0kt1eHmmy4viHq3u32Lo/Hr4lxUPxupSZwwhklGIGs5ZyJEq
 SIiQ==
X-Gm-Message-State: AOJu0YxVdZggNmtROU1vbuvlhOXKW5EOTE+LwpsU9/Rs1Zshbx/0e2W9
 dOeEKnXWrCvZZmZz6hHY01iEr3Cz/2L/0tBXRQIUgzNwczAfEgX2i2EThsvSnJA9zHpzrpVS99O
 defQ=
X-Google-Smtp-Source: AGHT+IEOXlToa21r4yUxiAleA+/mG4rc15QE0VT8GBUb+CHeadQ4/roYWuQ/oB749Wv4bjPrXIvxFA==
X-Received: by 2002:a17:906:c1d6:b0:a55:bf86:3ccd with SMTP id
 bw22-20020a170906c1d600b00a55bf863ccdmr2750281ejb.40.1714160629052; 
 Fri, 26 Apr 2024 12:43:49 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 lb9-20020a170906adc900b00a5889e8353esm3839625ejb.44.2024.04.26.12.43.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:43:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 18/38] accel/tcg: Rename load-extract/store-insert headers
 using .h.inc suffix
Date: Fri, 26 Apr 2024 21:41:38 +0200
Message-ID: <20240426194200.43723-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424173333.96148-3-philmd@linaro.org>
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


