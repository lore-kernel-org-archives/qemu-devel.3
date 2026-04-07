Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2516F10F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYWN-0006cF-GU; Wed, 08 Apr 2026 15:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAY6s-0007Fz-Bd
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:58:42 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoL-0000m0-DZ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b2429f98d0so36231265ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600536; x=1776205336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bt74HgDQm6QWm4ci9bJjS4WKY7nrk6DWez5uAlhy+BI=;
 b=DHOorklYPP6rXqVpoJYrlHG+tJxrVct4yXPLrrsMestDRXNE6rRJN4ExbI5lzHKYtN
 qkMlytGs9ODbhRuhax2YDx4kQkWdPgUP5aKdXJjL6jtSC9oGddhV1YoxqVI1Kz/Uav1g
 FkutHvht07NfzdEsvTVpMrM0d3FhFIZhnMFQHvjqLaj3Se8l8KuvdkKghA4xpaKH2cfL
 x2qxB9CJQAiQcFU2uOIbMkFyLiYx9DWutgUe6+99y4OEDDgIxRjTpTbVYuTLd0qLPyfo
 8GF2J7x+vvg8eJiaLZRIkQ2GLd9VfJChL7ulCIdIsEeH+2smaHEv6wUh4wMAi+uQL5DA
 QpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600536; x=1776205336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bt74HgDQm6QWm4ci9bJjS4WKY7nrk6DWez5uAlhy+BI=;
 b=AIJKze1J81vZFrORfr9/SCdt/jlVGXaBHAwTP5og6ubAJ012MqD84nfryLIjI1srK+
 8tgj7GK/5jSojKwwNp7tQwiy/ZKkfZucqrwqesL0/wKV0xt3BFUuLDRGPbwyNylc+2kq
 GGLbwiWAo9U6GEitPWwt+6efjIVhoQDdct9jlnx1O0+wGkQLad/rk64xQSPX6muAtPGZ
 too3VjECXRI/JSPuU/DBqeY6rNvv1OVmuJk37wGEXFoUMchjWHzy80xkBKMzs+kuZaDW
 2DknDo3ULM25ZWQx3JdRMlVZQd8wGXIwzES8NuQdWc00epOOhFh8khbAAdaYV2loINGN
 YK2A==
X-Gm-Message-State: AOJu0YzZsf2Egd9o5P0RHNPLVdGNjfsneswNsPXeZZEr/0Vx5GLv/Y0s
 PfL7qNNIXL6v5QmePyVreAnBlSAaJbj6JIfInOZCfhl6npKhbrMmFOuMHfUYNEvP8xu1eJrfnGy
 C9TJILFo=
X-Gm-Gg: AeBDieu5WWdE81Y8UVrvKDphRA+n6QAioJleevlWAL/xFboukGYPww1xLKZmhT1Hfoh
 dsAgAxyf79HC2cwRmxZcV33CXYlWEiEwlJKMWMgfY91eKLefRS3Ga9cM8FxKaVLSBok074r/QVr
 rd+ktkyCpCnb3iYZB+3GMilSfOxZneXe3DPILua7IvS0qKpzoJxW7B5TctR11jmWEAJJlLjtoL2
 EA2mOJvzuC2XDsP4e8zfRbPGKf/rxYxtNW5QcYOZxLOXhJYPvxVUYPjWVOoG/pEDJK+Rc6Shi4N
 qBo2Iqhxx7FEZiJ9/lf2P5D1WnTlDgIuhmBbOkPT+Unwz6Ej4aMj0+GhsQtoQtsZOU5XbaZLtdu
 ILcnpffOs71BcEJxT30ssG4CwkRFroJIHDsRCqEtHRIvGsfDXzNlqi2mc9ZNl0j5gIZlChSuGe3
 gfxIOGaJEc7CnjuLO2JNmLiRWHOGBxt68rhs0TFw9le3No8BTJ1CHEUkCjmb/eZBnD+GTeD4/g+
 OJ4
X-Received: by 2002:a17:903:984:b0:2b0:62dd:3a93 with SMTP id
 d9443c01a7336-2b28164de77mr199607315ad.7.1775600535844; 
 Tue, 07 Apr 2026 15:22:15 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 02/21] target/arm/translate.h: remove tcg-op.h include
Date: Tue,  7 Apr 2026 15:21:49 -0700
Message-ID: <20260407222208.271838-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Include tcg-op-common.h instead, and include target specific tcg-op.h in
files needing it. This intermediate step allows to clean up every file
(TCGv, tcg_gen.*_tl.*) in separate commits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h     | 2 +-
 target/arm/tcg/translate-a64.c | 1 +
 target/arm/tcg/translate-sme.c | 1 +
 target/arm/tcg/translate-sve.c | 1 +
 target/arm/tcg/translate.c     | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3e3094a463e..6d52606f9b7 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -2,7 +2,7 @@
 #define TARGET_ARM_TRANSLATE_H
 
 #include "cpu.h"
-#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-common.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d261a5e32b..35ad7530c4b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7d25ac5a51f..08254b088ed 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 
 /*
  * Include the generated decoder.
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 5bace3fda1a..aa7d72a35ef 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 #include "fpu/softfloat.h"
 
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f9d1b8897d2..56ef1e0eb59 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -22,6 +22,7 @@
 
 #include "translate.h"
 #include "translate-a32.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
-- 
2.47.3


