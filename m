Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A37D232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56t-0004pB-OA; Fri, 09 Jan 2026 00:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56n-0004a1-QE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:25 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56m-0003k8-Cu
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:25 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-81e9d0cd082so36135b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936743; x=1768541543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHEUiKpuUqUI/y97l4DxiEpE1OUXxCDFN/TCDnw/0BU=;
 b=d9jwhaVd4xfBCVmrI5jFQgIOfZfYaQc+t40fRcpMSJeklOQqFxAM/7yzaFFSGUyZ6o
 ocYBkep8q9zBynAu9XBb5/e48QUTVpuwzuGwyOLIH2vonUoxUzkKErHT68pzN7twe3Vw
 Hyg2q7yjD2mXzKt0dmAIez8s2+7MGyLxRi79BFYt92kokF5F70pI7B3eZ/UUg/KXCA9g
 pCFzs3jbktQzShDY68/yWT0uJoMcNPy/W48XBNmW02yGi2PsDfCelGOZlnYvTLAXMNMa
 0jhw5b55DgajoE8Pg5P/Mxa480T2dsGYKOiWPnNnwSjR/aApVpoQPgBzV2sFQwbEZdR3
 ljBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936743; x=1768541543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZHEUiKpuUqUI/y97l4DxiEpE1OUXxCDFN/TCDnw/0BU=;
 b=WQ9NXadW/enY93XYnvwB0AA0T7853LsvLwzEvVhEoA1LvLckySJhTL7JF7lkVkFwA9
 oUTCAcgjnuCXfdzWnpnSIEGBzsD0PHAP5kMVm1xqZLIgg2jlPUR5X6a3Jvq8Tp4UUiDK
 MLulV8eANnhV1fRP6Nhmf+TwV7TjTgXSsyBD8qdkLBPQFOWjQ4sFwR1GgmGQxoVheyfC
 x4oeZMNyUL4+SFsrnYTnlbTLNmGwczmmExDpGruE5gNVhKJdHIAMUr81/Vz14d/GkXfO
 7M4eaHO1hwO8sPHFn4l1rEVDaq0JeKpus9NH/c4OTCFHKpQvavCsaCQtZ3G5sDeFXbp4
 rCOg==
X-Gm-Message-State: AOJu0YzuLg/fqCbUzFBoXVeOk6Ad4dUtOWwyZXZHcCMbJ6+TigI3T5/V
 aZ2eOJQqz0z+evDKJNG6j2t+ekwb8XhU0fe441A95LYfgLQ1flR/mN4LbXEBR4EGM0nav38eOv4
 h8I0E
X-Gm-Gg: AY/fxX6B1Z9g+SnylNM+W6QaEU04ItoIRHuMdozE3NonyhRrGhnjQ1CZIv2lxK4XXYc
 s0nYRvkGOe/ju1XZcG/M9bAKcBrSy4vD2GRsiQI/LpRJCpjYLZ5ZQrqSwX3WVpvIfSiLQUELmqu
 MEKJwGwtVowcIKS2L8CXjPQbUWpGoeJcINPzH3RvVUParNXgKX5+vAlddh4z2JVwXAznroxvcYA
 HD9pZXNZpgtV1JRnGd6QSE+7XrC7M6WmUG1Av/Uct4fu9jMkGoK97eYzKDrcuKZE8s9Xzk43icf
 Dg/K4PoUoJFB2qfVrF/RbKuxp86FLlRUEYfaLemGNtSRBJHKm1BqMt5QI8aeVvIXSTXJ4U02TTo
 j9CqHxVHHdU3+CXAi42g1c3Ml1OhJyclWGsCwbDjtNam0x/VYaJ5pZPXfvHP883yq/AfsxaZURb
 LtLAEO9fKo/wLVwoMEu4mb7gj84GAjvhfyLIa0sCjAcQ+DAU6aaE2vbd85gBHNXKEcR6E6zO+t/
 Ag=
X-Google-Smtp-Source: AGHT+IGU+lTNhfFTFsNWqdWN3z5TMmo2rt11Bl+wx6q2PvLXaLOHCawjrI1ksS0q/hmgL+xgxl4N4g==
X-Received: by 2002:a05:6a20:7489:b0:35f:68d:431b with SMTP id
 adf61e73a8af0-3898f9bbd66mr8752720637.55.1767936742918; 
 Thu, 08 Jan 2026 21:32:22 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:22 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 21/29] target/arm/tcg/op_helper.c: make compilation unit common
Date: Thu,  8 Jan 2026 21:31:50 -0800
Message-ID: <20260109053158.2800705-22-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

Remove unused header accel/tcg/cpu-ldst.h that has target specifics.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/op_helper.c | 1 -
 target/arm/tcg/meson.build | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 4fbd219555d..6ebe6721633 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -23,7 +23,6 @@
 #include "exec/target_page.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "cpregs.h"
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 318a951e4d9..d435d2e5b72 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -29,7 +29,6 @@ arm_ss.add(files(
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
-  'op_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -68,6 +67,7 @@ arm_common_system_ss.add(
   'cpregs-at.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
@@ -81,6 +81,7 @@ arm_common_system_ss.add(
 arm_user_ss.add(files(
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'tlb_helper.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-- 
2.47.3


