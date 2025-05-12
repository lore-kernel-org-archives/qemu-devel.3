Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6BEC3ABCC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXfo-0000E9-QV; Mon, 12 May 2025 14:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaE-0001MJ-8Q
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:08:58 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaB-0000Se-0q
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:08:57 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso6532484b3a.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073333; x=1747678133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jg06Y7bf5KiymTc5nVCG7BgUS7AMOOtDTvF6y7Zvpa0=;
 b=mMo4fjW70roSC0UQ7oKaAcXsNdK1Ei1FuaOq1S+cp6qVr7r9Mb0uT+5OhX0I32u3af
 6k8qR0l8Li8gY88ozK/yY+C14SPVKrDV+hUy0mw8Cic0km7JKwEI1STTsoDjSWVfNhWL
 Sv9dJu5yKLnzYyjhES4Pzxhc2RVCjMOJ7V51EEtL1egJooEwxYXENjQpBFeXMuLrhD/j
 8JPZV0oumTPQFOe2OhPWQWrlBKqcvOBM/rzKQBnk0TheBY+V7vXs5mbWk1FND5T39yoD
 GZRsmoeCCmg4pR55lQGQas3v1aYR0GvAO63zP1l/qGpN0fz4SwB3bwiKtbQwETvaydzs
 UUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073333; x=1747678133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jg06Y7bf5KiymTc5nVCG7BgUS7AMOOtDTvF6y7Zvpa0=;
 b=uzFQuULvqtWKz+coCCrwJGYk0f1C0jhLYOatyWWDga0KtU2HGARzBfmZWBWmfrD4gN
 MSVZolc+cwx6tD4+gxGnUGGPlPRoxuEhOsjCJNR6/dEBZH694u2n94WTI2o/xpCTj9aL
 X8byPi/J63qFKy59t7oO8bcLWZ432cKw3kAlG3ehO5t1Qa3mFeJqkoPhbzpFefr4mJhn
 0n3eKxjSV+tF3AkRBasTfXnH8pqEd4cgAzu0R/xUsAiwdmbbGWNGr+vmF//jnd28DXAp
 ggd1rOQuhJsXQZMbjw4zzSzTejDXUhsepE5cOufrEJDiQhse0KxV/+NZnxQTj70sR/mh
 48XQ==
X-Gm-Message-State: AOJu0YzQCuQ4dul6Z7faorzD4ZOhD/a9H7HX0hNzxe8xNnU9O4MeEXsJ
 voCthzQ2zBRTA4+J25g4Qua+9EF1PoPrk6B9kL8OKHWBGgU7ivbnv/BJD/1RtQaQJrOQulLZ6lD
 j
X-Gm-Gg: ASbGncuidDWTHYHDb0EA0ZXQzbvSVtkzp6qMuTkzx8RV4L8LyLwDw2YY++BAw9QifNl
 YDj9Lcmn80Nt5XxxNoyr9jzeanzRiACn6ixW1MOQsvd7z708AlQgGBvF1Rqz5nmz+woqI42bLg2
 5A5Ypuo8iHray3ku17OnndT9znpeyYz55szogOXABcdC60/rHVoMtCIVNIW1n7ctIAXCi8rATib
 DQbP1Ayo5LdqsaVnNcnsBU+z205AupawHwQqYqBmhuaWIvH+YHS6EGSLGp5RJLvHsZ+fCI4bLE6
 jmv9QDW/qOIRkjbEzaVv5hojpZcSibXiQPz/26/xAnnH/VJRShyEIZ+E/mATKw==
X-Google-Smtp-Source: AGHT+IGHrXcPyTqv6VhW9WMXMZ97evgV0lajrk9bhPAjWob6mO4Pzdy5MdI0DQPtkguqasDBwJu0yg==
X-Received: by 2002:a05:6a21:c91:b0:1ee:ef0b:7bf7 with SMTP id
 adf61e73a8af0-215abb3b979mr19692569637.19.1747073333215; 
 Mon, 12 May 2025 11:08:53 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237705499sm6438580b3a.33.2025.05.12.11.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:08:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 41/48] target/arm/tcg/hflags: compile file twice (system,
 user)
Date: Mon, 12 May 2025 11:04:55 -0700
Message-ID: <20250512180502.2395029-42-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/hflags.c    | 4 +++-
 target/arm/tcg/meson.build | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index fd407a7b28e..1ccec63bbd4 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -9,11 +9,13 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 #include "exec/translation-block.h"
 #include "accel/tcg/cpu-ops.h"
 #include "cpregs.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 static inline bool fgt_svc(CPUARMState *env, int el)
 {
     /*
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 2f73eefe383..cee00b24cda 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'hflags.c',
   'iwmmxt_helper.c',
   'm_helper.c',
   'mve_helper.c',
@@ -66,3 +65,10 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 arm_common_ss.add(files(
   'crypto_helper.c',
 ))
+
+arm_common_system_ss.add(files(
+  'hflags.c',
+))
+arm_user_ss.add(files(
+  'hflags.c',
+))
-- 
2.47.2


