Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B553C10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgVI-0005z8-T2; Wed, 24 Apr 2024 13:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzgVH-0005yV-Fj
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:33:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzgVF-00031O-7N
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:33:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41b09fb205dso981105e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713980031; x=1714584831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMR8Lg1die3szcUXTAk2tB7zWo4TcVDOEobhVyTAJrQ=;
 b=iYG8Hs3I+mh/WLFpOm0rr7ASw3vKwyBL4h1atFfMkJodKRGuK+7qdQfLz3YoT9ZHbH
 7AnvwY0042e9IpXtIBwNp/a7ZTvC77V2gwqHBl6bPCRinYa0UBSpDzRnLroTTZbpd2Pi
 zq6mN20jfVLzVP4oQ2xonYZVEBPt8fFnoLlZ9h7yogNeDQZMLEgFrTcZFLMjnRMimtL2
 zq1OMn8FLdVrMViAoTt8azJrEFkGynZz1eW86RS+4YJeQO0zRFLMdWhJoRROpOO7yo6L
 SzWgmnY0sq96Kigg4p/O/FlRTb9zaA3qLDmBPvk3qFElazAPejClsxMBv6tykbUq2DxB
 1B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713980031; x=1714584831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMR8Lg1die3szcUXTAk2tB7zWo4TcVDOEobhVyTAJrQ=;
 b=vxhIHuUrZQCFz4+A6bvNgP8m1Fx4/Bklv8I83hGSdVYlXtPpDPLx1FwC72CK3RiTVa
 RpEzpwP92uwGdyEtBohNsBk6JnXUdCBEntJ93szQ9B2WUwJr3V4qhBZ6Q9A9Pbcl15BI
 lADA+dHQCbpuJNQTe31RBmDdu1aQDAULlRim6MYnWLFcnUuPjccnKFdautYhUy1LzBsx
 hVYTYBFinkq8I+/Z/WpLre8KHTNgB8qMVoJXX4xEsCRa6hqjyFiZdChwdpbA6JO9QUbu
 rDy4Dpk06ice5dtGSyrP3oeodBFzZm2+2OjU4C7pF8vD8cVd4nJsk3ZLXKH48nMNU5QA
 Ay4w==
X-Gm-Message-State: AOJu0YxK4xVSYHrSFKq8F5/Xcydbko7qmCyCoKtGcSycxQmRLqXJcaV3
 t7Mc3U7OBGUYRr12COKGQX3KfMbgPEC75LgJ8/+uhJ5K+ovuO/Wn9d8CGAeaPt3gkufPbs3RFr4
 j
X-Google-Smtp-Source: AGHT+IEO/HB+LN5cLTlZCgN2pThsVO2EP7DP24/IWT6JRkh9DBOiOyPcPtcdUyxrhbf/NijlVgS76A==
X-Received: by 2002:a05:600c:3c9f:b0:419:ec97:1cf1 with SMTP id
 bg31-20020a05600c3c9f00b00419ec971cf1mr1881854wmb.20.1713980031432; 
 Wed, 24 Apr 2024 10:33:51 -0700 (PDT)
Received: from localhost.localdomain
 (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr. [176.184.51.42])
 by smtp.gmail.com with ESMTPSA id
 bd25-20020a05600c1f1900b00419f7d6879dsm16252468wmb.8.2024.04.24.10.33.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Apr 2024 10:33:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] accel/tcg: Rename helper-head.h -> helper-head.h.inc
Date: Wed, 24 Apr 2024 19:33:32 +0200
Message-ID: <20240424173333.96148-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240424173333.96148-1-philmd@linaro.org>
References: <20240424173333.96148-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Therefore rename "exec/helper-head.h" as "exec/helper-head.h.inc".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


