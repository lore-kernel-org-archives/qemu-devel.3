Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3964FF46C69
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oek-0007RQ-8T; Mon, 06 Apr 2026 14:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oee-0007Oh-G0
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:34 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeb-0002Nf-RF
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:32 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so1404880a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499987; x=1776104787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGhpyO9gJO4O10TYeQgNeX96IysIFLL6455aGE1zsuw=;
 b=dh/9BQ6f7g4NmVJsSvPU7R3yXrsCOie6vhwy/n03qicuJTGSFpn6vjuvj+R/uCEKZ1
 jfGjtClpq4Y9l8shoVzfAxHuxClGJpvLBBf/9dVIBU+GGn4kWBo1/vIf+r5KD8rsTO5n
 /MZu05Xle1UZDwL1AGdalQJBmzipuKinS2Q2FE1lB6CHGcy1hT+JT4OLd7AkNpReYMp9
 jgk1o//FXuAGzAt5Hcvhy3J9WwesEoAQFfz3X3XgxEC+WsG6gsW14Pf6aTaz82aL/sR6
 8+b6Y2mB7CYMWfnKE9wNTgOVoVx/IMhwRqUbGLPZ1y9xcicDPGQIeKfY/gTQ80u0hSl9
 /VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499987; x=1776104787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FGhpyO9gJO4O10TYeQgNeX96IysIFLL6455aGE1zsuw=;
 b=gea1wPyyUhDcLvm5ezu1k4DNC5GMrC8C5eve/uBa47kucOGe+C/oKyh/W7xXFbtqdC
 o9faN4dnqOnZ2f8c2IxNO+OieDdFvh5MTZOSaDRDSOrrA9xtCCNwgql/Y2++t3yehMqC
 8Vs5SVz2dvZ9lAwvtSzwHQ++wHs+QY9/KN131sBzJxxSsX3ZsK51AW4IiYcg6qj7pIVa
 Dc36/WFCi9ttUj85fbHqrXaGF6P7xzbimK+Cl7naB0nAB9cWOjKFKkWluGZ+fofJJjDJ
 w6Eb7vX91n+N2g+3VLjr0NAiBYPgcIH25OTFK7DozmHX2OafzNolPdseZisOquF9Mgcb
 4wuQ==
X-Gm-Message-State: AOJu0YwHE8WjYBe//rAD/h+OKIqA2gyugmjGST4o2jYPAWKAflMRdnf+
 xXebktMLPuHdB2ltqSfJ46ehhZFyDtX3F1IQyV/TRtPybFegI2mLp+/nue0TxPRm/amxTSIxhMy
 3frJP7VENFQ==
X-Gm-Gg: AeBDiev0fQmRPPZFLLsy3g/NzdvJl8I+I49i7B57JCjPFKqWGPGWPZJt9nXD6jB5w3B
 IbvVJMs+HeaDFcrtVj8W/+K4lUcgyU4bYMT5Ocl180xAfUQor04ljwWjuGifNDyLE/SWWh50uzh
 OtRk+eVsExVOpKgbpZkKf7Z21DhFUvl6C4TI49vHL5PGQ07R9/OGjhPi2QtH5mjPUzFXsgYdYzA
 P914kQYma9P15CgpFBYzCkhYnvFr/C6xDRWp5GEwkIwkPajyV3vvAoWtRe4cX/qND8z33KNXCVh
 1DWb7kVCgAangI1joaPgzNYosQL5t3TIAYjyYJkqGI/13xTkxI3CfEVkqaxj8PpmGVAQmCihwJp
 NfmkOxBKEw5N+xVDD/UhJBEuc8Yp0ETmvg1vjOdoGGPJXB1GW4Rc3XhpU9jawfNHFMUmfP081cq
 8BOW6f+DrXBl8ROIc0gRW8URjdV98vCnEiOIcoeTHLxJxtLYhPNopQ7jJD+mjHHtwubukT5DDE/
 2Xo
X-Received: by 2002:a05:6300:210e:b0:398:9820:f6fa with SMTP id
 adf61e73a8af0-39f2f175104mr13417095637.53.1775499986772; 
 Mon, 06 Apr 2026 11:26:26 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 09/20] target/arm/tcg/op_helper.c: make compilation unit
 common
Date: Mon,  6 Apr 2026 11:25:58 -0700
Message-ID: <20260406182609.193886-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

Remove unused header accel/tcg/cpu-ldst.h that has target specifics.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/op_helper.c | 1 -
 target/arm/tcg/meson.build | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index aa14f15eb62..75ad53ec6c6 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -23,7 +23,6 @@
 #include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "cpregs.h"
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 70beec7a6c9..1fa26670587 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -37,7 +37,6 @@ arm_ss.add(files(
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
-  'op_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -74,6 +73,7 @@ arm_common_system_ss.add(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
@@ -93,6 +93,7 @@ arm_user_ss.add(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'tlb_helper.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-- 
2.47.3


