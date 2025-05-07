Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F914C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoUW-0001sy-Cj; Wed, 07 May 2025 19:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTb-0000bU-8J
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:47:02 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTZ-00038w-Fg
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:46:58 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22c3407a87aso5763555ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661616; x=1747266416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XN9bpcu/hK+eTVDHriw8+8GBLuzv6l51ao11Y0jPFbk=;
 b=g5b/YZ7n23T0+UoTjfxGOCXGbxuUn8+gaNOPObtD9zNjfe8IakI7M+1Ie9XOg/nULB
 rhdViX3mdkPPOD+dOAwT3jMHMlEUjfdEROJUmtPPqUFgyBhdG3YgWbV1D5Ey5hpTFT4B
 ALcXMeQ7YGwELNC0qCuCUR38LFmDmzVo8e9chpSdkxf6ops82plpA5qpU2pt6AquVPfv
 /+cSM88VjEDSgb8Q2yRsqgcopXCQhv/8tPIhD0l6Pg7XOaMucFD+t/bpYB+Ej52Z34Gv
 bz3QtcQb6LgMM3KCoWMniJlY1od54H/2hU0/DMls6rZ5Pe1laSd7kdeqWaqAaD4UD4Wp
 H6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661616; x=1747266416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XN9bpcu/hK+eTVDHriw8+8GBLuzv6l51ao11Y0jPFbk=;
 b=q8AhNOfut3xQSW4gH7Ax0flvkuBjDvOOrdGvq/AILdp29rbPwdPPAOGebn4lvfvG7L
 9AmoF1W66qcBJcIY8BwZDuQ5YruLgXBOKBd8NZmdi3xq+mH49UN0E4j8nMKmPqeTVSyB
 vG1yFN4x2yW4WadO05IFFjYTDSbpxedUC9aWh5vW4540rXWP+vB9lzWdjr8utS9FNk57
 H8tHJfd4YvNwzMIwilSo9vSKkSIZ0myaUq6tJMRITl/1C4vOur6+nsvXnTDmF2ZB/Bsl
 xhgwsCdAhMf+dTSCqlm7UW/u7NhND3kC2hCJovJZ9yX06OnOE9ApipeXYG0WjTKRXmbp
 YFAg==
X-Gm-Message-State: AOJu0YzJLImWJDgFd1kYyAY8ZCv7ffiGLAWKryOI2LvjG07CfGs8PeDy
 gSLTWzFTI0u2c00srWFmzH/jyi+fawJUS7iyRVMhaEZKWCI8yZLgb+3ciC6bs5/7IPWZ0wTbbzi
 2rGCQAQ==
X-Gm-Gg: ASbGncuyFAJnPFoq06hyydV1H76vsd/UXVKA3SToUsmtGoZU/H0wxcAlQewNA9C0Zsa
 xAxWh2EBzVKscTMGnih970EPZRnMrcvgCrQCiiObZRZEtuLgrscZAgOjWZN+2belhz2+5krJeOZ
 hm6eR/U+eLu+I41QxGIYgwbT5LpOzEz+w1R83eumBzY8Nc7JhUE+u33sFu4UUNafUPtRtdj8KXJ
 9GtQMpVUL7oLKBxD3bsYP52SMM3IR9CCbls8XoWIzZFyrpkvUYt67//7oOSBGb1iT/wb+4YcVIL
 ZKpwv4NuHfPcTp3yph5qU9pVmYu/oBi1YSZ585Elm13t4My/85U=
X-Google-Smtp-Source: AGHT+IFW315Q4I5LNTZ0KdNHko2uJjnjJeUb0CDoTdZF1UBuRUefk3FToK74LCS1f+jcPOOcm+QMCw==
X-Received: by 2002:a17:902:e80e:b0:22e:5a10:fc38 with SMTP id
 d9443c01a7336-22e8d7c843bmr19512495ad.41.1746661616140; 
 Wed, 07 May 2025 16:46:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e97absm100792435ad.62.2025.05.07.16.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:46:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 45/49] target/arm/tcg/tlb_helper: compile file twice
 (system, user)
Date: Wed,  7 May 2025 16:42:36 -0700
Message-ID: <20250507234241.957746-46-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
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
 target/arm/tcg/tlb_helper.c | 3 ++-
 target/arm/tcg/meson.build  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index d9e6c827d43..23c72a99f5c 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -9,8 +9,9 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
 
 /*
  * Returns true if the stage 1 translation regime is using LPAE format page
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index af786196d2f..49c8f4390a1 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(files(
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
-  'tlb_helper.c',
   'vec_helper.c',
   'tlb-insns.c',
   'arith_helper.c',
@@ -68,9 +67,11 @@ arm_common_system_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
+  'tlb_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
+  'tlb_helper.c',
 ))
-- 
2.47.2


