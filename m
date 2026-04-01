Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A65107639C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8185-0006gN-QC; Wed, 01 Apr 2026 15:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w8181-0006Zu-Dn
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:26 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817y-00032L-7E
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:23 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35c238f1063so41587a91.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775071280; x=1775676080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGhpyO9gJO4O10TYeQgNeX96IysIFLL6455aGE1zsuw=;
 b=ECIbN4EE1Umam2UEw6Qmq84v8UUgMS1WrVEhVR6Hg9ArUGa/DO0X2gSMjD82IykefZ
 NZgFWJjtGrHzNYedQ9+T/nWqAglI7Mpdv0Zmj9cvwINrCCZuSpiCkJ0nNIR9hFHbzQsK
 rR2rAjkoH91ycjXmXvabSil9h/ksSGN5gGT9N/V5uWaX/oQwfIqdUcPFQFONIrJ5UOdZ
 85DSZ7Ui1l9e6IhtYbJki8SFS22dFeo+Mh7Tzsgqe1wgBAE73JiXoHmVaI8TyK4I6R1s
 qa0zDN8cpY4n1JTyuyNFUUn7m2GeSy7g4b6/74rI6fSFEHUgtbzvy2kUxZSZR5s6bhOs
 K+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071280; x=1775676080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FGhpyO9gJO4O10TYeQgNeX96IysIFLL6455aGE1zsuw=;
 b=dU0Tr8YpgUGAceclvoSbpLzyZuPg0qJMCmuHNmYkOhEnZHmEZ/iKhGp6HdORGmqEKi
 o/3KDjhuiyqYCSdrU0K6VK2RUSYu4x01/JDp0W2UDWGmozxbjjwzXKhCBlE8E+0cik7A
 yU8TSWETELlLBaZDfbCBpit9j2n4jjDIfViCQYG6PO/eXzXQ4xCuj84U/c2lC9rvq7M7
 GX6o0R1+o4ns+Ae1Br5V2QU+pkN4V1fPlb4YC/VzbVLV3sVLHnSkTBIn4I2urVZ6Ctzp
 HmEqSH3l88CO6IZUi0oUENuH1vAi3Jp2Prar0Fl2A6hJVtolvpSJK03UN323gwAiAkev
 yR2Q==
X-Gm-Message-State: AOJu0YyXyMmC2rwNl6kmmwkA0gakIb4sAcC2Hl7vDMu6yQvPtZoHYVvF
 ojL6uUsDZEy5LTk+IdQd0IW+1f1N8GulDbSlaj05VTDhdw4lS5RvWlpQ4B3re8NQKkprcOtyjow
 BSRK9GiLGXw==
X-Gm-Gg: ATEYQzxDyGIGbQZxUxohxwk5bro711K6/JGKyUzhGsArsirmAg+AAJYjaSLMWosVryw
 B5ljACL6rZyX1fcHHDzJFUmKpip+HonyB92xXbN/MOsfs16z0OykwOHMIpCINkwKiq3aLFDEKSN
 7vmFHHrZKtgWJgNlR7hUhiLVnyx+Muj15aGJW/zSByfxMgLoyIuP2HNTEMnJsQRmAk2tRYMpVAB
 IDOqdLQFkWXRJIESRcs/8QyAyQkUDJwkyuXci5k9V8glILvweXQM6LrlfBlm/5K06DXwoWf1ZNR
 FebcJXa5sXeO6qdcH6C3DOZGryBOvspMhb11/0mLDWjw2z34aW9SGy9uxSIOD+B4iEnzauqdcaZ
 H7sFDSuO+RmxRSUygM+TVeFPA0B1hH1z/zLOg/0kgDq0SjKssKAiSKBWXuN6JgRnfV++y6wOUEZ
 kXcRao/QbUk7LeqBFUZjQskY/9dV1WHlOGde1snFLENqg7FEn+jGgCX/DMLqZ1Cp//pQGFSSD2P
 uzq
X-Received: by 2002:a17:90b:1d0b:b0:359:87a8:e65c with SMTP id
 98e67ed59e1d1-35dc6f4a22amr4495196a91.17.1775071280291; 
 Wed, 01 Apr 2026 12:21:20 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe41b11fsm5633113a91.0.2026.04.01.12.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:21:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 09/12] target/arm/tcg/op_helper.c: make compilation unit
 common
Date: Wed,  1 Apr 2026 12:20:54 -0700
Message-ID: <20260401192057.1182724-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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


