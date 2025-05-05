Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DD9C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5Ck-0004EC-AY; Mon, 05 May 2025 19:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AV-0006vR-Mu
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AT-0003wt-3h
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:15 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22401f4d35aso59091355ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487451; x=1747092251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wE+ks75IW4zuYyzk7c3HX2M0GM7VkI4W6D0uip1dkOg=;
 b=mbo93jC5/evc0SJ9WFGVUHTOMOAp9dyVJ3H1YL3cJ0Ek2zgEn1bazD8KSjPD6GDLj6
 47POmroDWDzJRvoebk8Gu21+vARdj9WlQflGPwqbMfQc6LkaBFuCAjJpxvrjIC7yehY8
 HWUNrXjOVk9EtN+njl6g7HzsrhXSym90xrUfT9ti1G+9njva9Oq6TyshVULbJISlYC2f
 UfOeo/DJiTjz1rXZr4sf0Ydsxz2ogD64wveSEko4pvUdAC5rXIzlvtM6PmJ3lTUGKlVn
 iXAQBjaVe2vTfvv6ZkxTnj0HHU+/H9t+dka5dAom4UhIwS+TBEhLFOORh7Et2t+v+ywr
 NSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487451; x=1747092251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wE+ks75IW4zuYyzk7c3HX2M0GM7VkI4W6D0uip1dkOg=;
 b=hhNeIqRbZXnmm+HNr+ST++4rxRQvMvc+PbLIlctwoAFLihvm8FjvWSZI0LpthmUEtJ
 IdfAudwkJgrK58De7hxUEAuz3OwFsQdr27znwEwYJNVfLI9KV0vZaogmzj0Bt3PniyuU
 nFMENUhZMxBUitPCIC7yGcLC3H2dyD/4HdjYtLSNIiHfaz0Nwo7b93lf/CtN6L4YaNQe
 jkAyHqS1zosMmg9NtGyP1qBf91t25SEhMgDqZ+ms8xXi6dAj8ogQJcvALqoy3LWJXcK5
 6zlbFLWj77kWf+gIOsuKSK854Hsrxj84rRKDUM/aBDQyxRFNXEfsumc2tAsw3AGuNx+Q
 JrRw==
X-Gm-Message-State: AOJu0YyWj53fraoe3kucdCC3I2QX7RPKBSBmP1+5OLpcf/UrChTO0CNv
 bDkC0TLs1TEFSn3Sig0MjTXjPYj1CK/Fvnv6Hak+LyrxF0eMEyeaiQ+T4qHYQVCAUxxhoytGDVS
 G6U4=
X-Gm-Gg: ASbGnctlX+5tJ0HZ13X//tKrYq/66w/JPiEA0LmDH3onnESJqTMIwNPG/MJ1JJvRP/n
 Oysu8sviaRmnw+97ros3i/QpwcFSA3N7TAVfS+BTqTcDr3SV35XYGTwRlyGWCe0pCboHNLw/35S
 54Ztqgnx9Bo1u/I+3nYunYtkMYqJaGF3T2yGvJMcvz8t/to/ZUOClygJkmADA18T+/NQSz99eC7
 bMg03L6g8IENDOS6Bvza87YhguG81TF1UGc5Schvvu3Er3iFqCFKby38XSEJV4dyd7psDFvXZMq
 RrKDwlfuDGNCBYsdVSxBgWB/ZpFxdhmvI8czUWGGzioNz0iAZL4=
X-Google-Smtp-Source: AGHT+IHFYgo3dGI6oymiueOZq/2WBNSFS6bNBMqt9jfge9pyyjbKnOcspVMZnv8e5GSJtvTzFP61hg==
X-Received: by 2002:a17:902:e80a:b0:220:c813:dfce with SMTP id
 d9443c01a7336-22e363ac721mr10768215ad.39.1746487450836; 
 Mon, 05 May 2025 16:24:10 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e16348edasm58705265ad.28.2025.05.05.16.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:24:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 43/50] target/arm/tcg/hflags: compile file twice (system,
 user)
Date: Mon,  5 May 2025 16:20:08 -0700
Message-ID: <20250505232015.130990-44-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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
index e51d9f7b159..9fdc18d5ccb 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -9,9 +9,11 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
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


