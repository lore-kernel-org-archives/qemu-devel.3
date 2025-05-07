Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B581AC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoUq-0002ZI-Ia; Wed, 07 May 2025 19:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTa-0000bQ-KV
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:47:02 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTY-00038Z-Qr
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:46:58 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22c33677183so4699015ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661615; x=1747266415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11Q55+gMF5u6Eo9NyNW4V+s1ceVG/+YyEcTpuHMGI4c=;
 b=YdaUCfv9YBQhloQQfvK2eW0E7esp1kgaAfQtjarRMxDfyE0xGT4Pv/tSMdrI1QtTAI
 6vwgTFKQqHF4EuGFgpsqI3GrSG6Zu22rmq5fQk59//54xPt1QuwBAdLZeoJr6/kWdt0C
 x47SLn9j8uCpktSRkUWFcUhXxovM3BbNHdQyv/F9tr/ZceN6aCkLlwVjn9duYjHrWpEf
 egm0Qg91dEA7Q+PQRxwmF/IJTPA9BsXgjuWklICT0Lv1ed/+13CsmmRn7C7HcMpIDPF4
 w6Vij4xCS0kQgbfDw5u8I6bgl7vOLN6mf+13jIPltLl+gHKVFhpCjLmrGzO0tj12CRw0
 pa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661615; x=1747266415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11Q55+gMF5u6Eo9NyNW4V+s1ceVG/+YyEcTpuHMGI4c=;
 b=jb8lTGY1Brzk4RHRhiotlNAW4+CqYmGaROSbhW2o5e1lvhgmqdo4sE7G+KYa+YQVIa
 IjoX3jH611gZP355hje3INHqgTNEd/Y4xnhBL61rLq6qZoFNk7vDn2ChLOsR8rY3ZRGE
 +jTffe25RXA/GbaDZipK5vMERIpM8mOts57xRotP835TmA5mIQPit6/+jJoNan6e2yW7
 mgQcvJrLFl5ntx68vQCCXz/gcnnxqWmBA5GVuBqW6zze1dRQAn9dd8vAZ1h+Zn0ql+bd
 XTjXZEdkm9a1XJxL+AHW1uOgeqqL4CssQJUB5jkkanp1sIvBs3wVNlD9MUuwXb7dsX7L
 hv2A==
X-Gm-Message-State: AOJu0YwQ3cRvVGjPrP3OMuBHC70XNWQjIaIpi6I4M6RAkpY4Jao0sAK7
 8krkUQmwPF5IP9URq7KHyzz0upSbu2SjDA25gy11EmDq0OuTSLdV2NNa2wMyq0S0wCsaW9vc960
 MmZItpg==
X-Gm-Gg: ASbGncsMnM2B/J7tyuBPe6U9ny+Zz+4ZnX/4HeHt3EiiyHUWd+/fD6Ds76ZGP1BD5NZ
 8JQH1SqflKi6yJE0jOYaL2YqFjLifd0L3Trnd1pFIh0r9WNJk+VujOUDA4V+T7eeGOT14WZv0E0
 HAHLd4tA82XPWjINuyWhBB7zwvas2sFPPt+3e1lgz7eZfGT0N0ibPXboDwRr/LhVeUKO7QNtR/5
 7epzNGCrZYKUS1HONr4wkLTWciU6hPGbNkBEwItG0at8vmAjcekhYPVPiz57Y+t2fglLCASbumo
 dV/EUBqyyseUfrR3Z+KO3qi1pvNJ/xMNuF5Ug/es
X-Google-Smtp-Source: AGHT+IEeb52mgakz+8TCt7s0DB7r7G8IMfnoPVX8rLcKaGa0HamIowdccKji4YJ4u1M8woCDTY1WYw==
X-Received: by 2002:a17:902:e748:b0:220:e1e6:4457 with SMTP id
 d9443c01a7336-22e5ea7d822mr69085515ad.26.1746661615265; 
 Wed, 07 May 2025 16:46:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e97absm100792435ad.62.2025.05.07.16.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:46:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 44/49] target/arm/tcg/neon_helper: compile file twice
 (system, user)
Date: Wed,  7 May 2025 16:42:35 -0700
Message-ID: <20250507234241.957746-45-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/neon_helper.c | 4 +++-
 target/arm/tcg/meson.build   | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index e2cc7cf4ee6..2cc8241f1e4 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -9,11 +9,13 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 02dfe768c5d..af786196d2f 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -32,7 +32,6 @@ arm_ss.add(files(
   'translate-vfp.c',
   'm_helper.c',
   'mve_helper.c',
-  'neon_helper.c',
   'op_helper.c',
   'tlb_helper.c',
   'vec_helper.c',
@@ -68,8 +67,10 @@ arm_common_ss.add(files(
 arm_common_system_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
+  'neon_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
+  'neon_helper.c',
 ))
-- 
2.47.2


