Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06522FB5181
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wBB-0007nC-Hk; Mon, 06 Apr 2026 22:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAn-0007aE-Iu
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:13 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAh-0006z7-GA
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b2503753efso36844465ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528886; x=1776133686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVeSwZbNgMxucNnmt+bVJO+rTB1zblJZsZHbFuDjPLk=;
 b=qlei8wntiuQyzDJzIUUWDwCv/BqgZ5GD+DNnojKWUqyt9aI6cDSyZegIzJgi0QjJJs
 3DPHnyjjVSlkyVdmepoNa3jYPorhY3TKIVBD5yqK5S3V9+DDh13VdQCV0Rk/aVRY0Nms
 EAoBlI5Wxpc1+T1jwAnCrLb/QHwwuezqprEjp8m2F1jqn7Xk1EPR6Ek6MwPMAhX6nw9s
 o1ByxyVBr7lilktWd5G8vZUbOW4KQG1dm+2flxzFU+5jMlWc2mXAwEuKrCxFboZoTc46
 htE0jOtsQihRdHNb9mDCRzWodMUx2XWXbkv9tb/zp15i4nvdGe2vgrcc8xl/9HMTVsuz
 1clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528886; x=1776133686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rVeSwZbNgMxucNnmt+bVJO+rTB1zblJZsZHbFuDjPLk=;
 b=AUI4CemNGm3bYwZ49f0lr2yjBghW2YK6AfOYIK0baGS5HaGQLwKVpTWoUiJfzLUKXc
 6uETEy06IQIDSuLqmViuCIb2PbzYFUb5tSmDUO1/n4CHAOkbncm+4yt9INH89eHPi0sg
 VU0/f0WDNjWy19xI8LuHiSyCardH12Mu4h9ZAibCEzRPsKyeZIJH6Q8z5cCccmh0B0GR
 324SndFr8jPYamNbPJRn4UISkbRDmI3cg4aIJ6Y9qnv88gNz0XgH3lwr1v32H5VhL4FU
 r0V34NabIKK/w/y9SZGPvdKkLb82qp/zuals3q7+ncNFm59xGtzw0CkxEUh5mY8zHCVM
 GtIQ==
X-Gm-Message-State: AOJu0Ywvr18Bn1V/8vaLV+U8ZYqeD8PjNlLT/8Oo9svXyXrvNx0SyR56
 6903q8K4UAUJcn56q2dEbCGOLM7q3GGYdQO0qijm3WpqbgxOs1yZm9UJqmLvvOyevGs6OrOguIF
 NcVv8GZ6mOw==
X-Gm-Gg: AeBDievEZDshESYPJstEWeLrL9zAhngmDl1VDw2s9fVt5XMB/vakqMsMmjjrryrGEVp
 wFxIRNHmyRtAYAq34eChNfUHJdeSY7OtCpvEkO696OJIMBGfXJts67wp43oBReY+WD8v8Rxw51G
 YqrFUQW9h7Ny+RmodRPCH2MonvG1C92rOhgurCoEeKJg/5IqntK4rnxll2FvMEZFfrtdgjn32U6
 bkLqWdgp1W9NFxpazXor1cgjrTCV2C8xrHXWV2+Xl68ovoFg5rEGUClz904hy74hKfAigM1zGyd
 k1hVmlRswxgXb69s/Xwwb2rKVJLXfPvGWgkB7sthoa3WQQZoja1hHq2HIWicZPrWk8b1ZYRNWRD
 INUpwn0P0w+5DgV3IcHFSUY4Fvm1LVJLmBicT2EA3iJU3VHGS8tGsyhdziWkNXoeZMRnE7r/UDS
 9/jTVzQ8GgTbflHfS73ucnTY/RQg4Zoo5zHobh9BJLBWrgS0xx161qu7/dybvxycJSAH+g5Ao7t
 lgS
X-Received: by 2002:a17:903:3205:b0:2b2:4eec:9806 with SMTP id
 d9443c01a7336-2b28182ca4cmr178832165ad.8.1775528885183; 
 Mon, 06 Apr 2026 19:28:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 10/20] target/arm/tcg/gengvec.c: make compilation unit
 common
Date: Mon,  6 Apr 2026 19:27:38 -0700
Message-ID: <20260407022748.57629-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 1fa26670587..0740de92c1a 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'gengvec.c',
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
@@ -72,6 +71,7 @@ arm_common_system_ss.add(
   'cpregs-at.c',
   'debug.c',
   'hflags.c',
+  'gengvec.c',
   'neon_helper.c',
   'op_helper.c',
   'psci.c',
@@ -91,6 +91,7 @@ arm_user_ss.add(
   vfp_d,
   files(
   'debug.c',
+  'gengvec.c',
   'hflags.c',
   'neon_helper.c',
   'op_helper.c',
-- 
2.47.3


