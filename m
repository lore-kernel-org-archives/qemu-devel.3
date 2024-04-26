Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520F9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RUl-0005TO-FJ; Fri, 26 Apr 2024 15:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUH-0002lA-8N
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:02 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUC-0003KZ-Sg
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:00 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2dd6a7ae2dcso39845811fa.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160635; x=1714765435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TM8vdBJsyiS8N9/BcT+cG9GVrIFZEEoAIJDE88Bqbg=;
 b=arlsN9etaO/ndGX0QWFywtqhnSpWdEOR5KyFtBojbdVzKtuLkEOeCxi2Xr5wz2SNnj
 VBogtvFjVDS83E34Wm40T8hcoJGdIIXosVR2p6pX+Rv8A3TRJnj3EQ2NzJkYXCxASlRb
 RUteAPJzykKnkD0AkCQj9Y5rqXNlTknmhKrL5MQ6Ct3yxsnGbOcablX8AutaxFtniZ/8
 A0LyGA0EA5GZ8V3wkWO0iDMuBlhhh4Ar4XnT2vEGmiZjK+/PoqNYfQbIaKUW81PZkPKs
 SPMitYdt+CM+G0fCiJ/mBo35kilvzxR+e0nQRHdcAtYdjGSlanFPrFHx8iJHbB7znNzC
 WbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160635; x=1714765435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7TM8vdBJsyiS8N9/BcT+cG9GVrIFZEEoAIJDE88Bqbg=;
 b=ohWUHXHIqMtPqNsIB1wqa9qkHV0+7xUoGh91mzJKNVG+56uzb7gjFtVjHgX8N8Rsru
 G6dAUtRp1hnaIuewuncz8YMIxySUwpVzbLgGKpVZQ74rFxbAnYLgTxZltuJU0Bvl5wd3
 G+9scbSIHy683cVEqTT652ZD2Seq1Eui6uXhe1E20jrFS0VaewcYF6BieZE2vK9TwWwe
 Vxzc7+BFgnfPHjrQ8K7lmm2sWolh8H+jbTfatEs+8d+Jj8ggovXhaJn6cSpWhtWq4fhP
 Byga+iBcUxBHestyO8CTaRuqAHrir7GZvVK7xLiKKbmH8oEZoryoacKnlLNdjU0nXSWW
 bmsA==
X-Gm-Message-State: AOJu0YwqDDDZaAYj8u/oecKj39Xe/JIEjBjvt51r+LW6xA5Dzr1IucWY
 rvanU3wGJ8eSjWBmFC8Dpf83Vm88s4H7HzFlxcVowGfwILrqu8NRRCr/PwKVO2XoMhihf4Vj6co
 pXNU=
X-Google-Smtp-Source: AGHT+IGgxB7ptdEp6F95JXRMZ1R4geUC72uj9X7EkgteVWQ5sYyMah5qtCC6g9RUYL+EyajPioOPOg==
X-Received: by 2002:a2e:7d09:0:b0:2de:75de:5b0b with SMTP id
 y9-20020a2e7d09000000b002de75de5b0bmr2771242ljc.18.1714160634772; 
 Fri, 26 Apr 2024 12:43:54 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 i22-20020a1709061cd600b00a55a10eb070sm7881150ejh.214.2024.04.26.12.43.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:43:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 19/38] accel/tcg: Rename helper-head.h -> helper-head.h.inc
Date: Fri, 26 Apr 2024 21:41:39 +0200
Message-ID: <20240426194200.43723-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

Therefore rename "exec/helper-head.h" as "exec/helper-head.h.inc".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424173333.96148-4-philmd@linaro.org>
---
 include/exec/helper-gen.h.inc                     | 2 +-
 include/exec/{helper-head.h => helper-head.h.inc} | 0
 include/exec/helper-proto.h.inc                   | 2 +-
 include/exec/helper-info.c.inc                    | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/exec/{helper-head.h => helper-head.h.inc} (100%)

diff --git a/include/exec/helper-gen.h.inc b/include/exec/helper-gen.h.inc
index c009641517..d9fd3ed72a 100644
--- a/include/exec/helper-gen.h.inc
+++ b/include/exec/helper-gen.h.inc
@@ -8,7 +8,7 @@
 
 #include "tcg/tcg.h"
 #include "tcg/helper-info.h"
-#include "exec/helper-head.h"
+#include "exec/helper-head.h.inc"
 
 #define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
 extern TCGHelperInfo glue(helper_info_, name);                          \
diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h.inc
similarity index 100%
rename from include/exec/helper-head.h
rename to include/exec/helper-head.h.inc
diff --git a/include/exec/helper-proto.h.inc b/include/exec/helper-proto.h.inc
index c3aa666929..f8e57e43ce 100644
--- a/include/exec/helper-proto.h.inc
+++ b/include/exec/helper-proto.h.inc
@@ -5,7 +5,7 @@
  * Define HELPER_H for the header file to be expanded.
  */
 
-#include "exec/helper-head.h"
+#include "exec/helper-head.h.inc"
 
 /*
  * Work around an issue with --enable-lto, in which GCC's ipa-split pass
diff --git a/include/exec/helper-info.c.inc b/include/exec/helper-info.c.inc
index 530d2e6d35..c551736d49 100644
--- a/include/exec/helper-info.c.inc
+++ b/include/exec/helper-info.c.inc
@@ -7,7 +7,7 @@
 
 #include "tcg/tcg.h"
 #include "tcg/helper-info.h"
-#include "exec/helper-head.h"
+#include "exec/helper-head.h.inc"
 
 /*
  * Need one more level of indirection before stringification
-- 
2.41.0


