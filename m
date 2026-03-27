Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3C510F284B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AKI-0007LK-P5; Fri, 27 Mar 2026 12:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AJ7-0006fv-AZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:14 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AJ1-0003Kx-A7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so10804075ad.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774629904; x=1775234704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIcfvrH1mrscajbqrnw45GLeLRQ46NncRATLpy0ZTNM=;
 b=HRYGGj3BQLuwVWT3MR3teMFD8qV22ZgWC01wYAjb+QV/BeDtpytWkyqHx2R2WODM7G
 lwP+PDUcJB2WTIP2Bs9Zb1bP6uIe3wDQA6TPJNVTRKW76IljtC6oXNOE8fJFPdJiK+gX
 /AYUs3MEzRsEmQ8dkjbqm2GGQH3GSniSSrIqNz9/z1QZwPNjbj8WVA7SddTNpzeI0Ax0
 VxFekxj63V9LMyJXWqjnYX3SH2+bIKwKwt0OYHx4AnWRHfyakEjNh3zXMvc4P1aQ9ymc
 F9rnwnvRNAX4aa70pnBJH2fsXP0ODn9nYevbuKgIt78JH3ktT9csg3uFC0gCpmPG+EFF
 b/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774629904; x=1775234704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HIcfvrH1mrscajbqrnw45GLeLRQ46NncRATLpy0ZTNM=;
 b=Sa/ggnbo6AVpWx2lT79TefVnsUD6bZYX+0ludHV+ueNs4Y/oAhuys3KnnCvGsUxsSU
 09SHZxjAM5kbmyJqMaJVdUUdqGI+XHStUtkwdToX2rkPvUrgTgbnpv/fMa8MQA56wWSY
 wJWmZC+h8dcK20q/xXROfwnGqUMP+QDc8TsbFFrfzT8AtVjNVgbXkXEpP91/rCNWMEs7
 73meMwKPUnDcjBcs9RNQiEaRX6LuxxaEwf4jJkJxCagkYoLM+P8eDPo4pBC//iZEw4dz
 myhx/AdZhmWoNkKaPuk/E3dC9bM9Z9f6MSyyi5ixScotp0GgdEA96diG3nwPxyO6/e0O
 dLjw==
X-Gm-Message-State: AOJu0Yysl/MglNq6dsG6xUymaqCuBe2AcRyuH/UarEtjjUFB7X+loGBu
 40x9SoduI5ZirvBNz/1ma5o9WC5r45+xsmU1M6OH9ZRcpSZyZ9lKi/5uBB8liW418gDX0etY8FA
 uFssOiS8=
X-Gm-Gg: ATEYQzyLzCdCJMI8Tvp7RklcIMYc9tp7dlm/WQcVGTRYVcKCMtXfVOj/TxJBqYOhS6e
 U2jlNsZ2eSpF7bxwRHqoTXoCy9WMh5sdAPHhbafNLLsISrMrgWgH5i9mLX2I7CNmjr44BFFLheG
 Nd8ylfzC7ZEKsXd+vRIbPG4anxM1aTCxOnLEncnHDzVjaBNdIS8zjpDfUEK4/4+i1fD5OfA132Y
 b4G76sViZv/tUdQQ2BMXnV0O9stDi2KgxZeDlQKWWEbP80k0PQxSZuuHoCZpJyAyOWMJymTWXKs
 5GhAeGvabKQPVcPPsgAiKXtpuQokDskD9gT8nufpNHbPt3haaqDKm4PfCvUznoubSLvTxi/06EA
 P9ha/x0R6y6Z8N2ALuNm1l0POMfZ6R9Of/tXbAYBGs7o9tUSS81uQVEuWPiZ54KRFP0qke0TByx
 W0gxYdEcz28/4QSSg+ZCHYtMxPzuPwUMukYgs3wYeth6HFxi90j9d4aGAkY5qDiXCQr6hGIwVwx
 fPc
X-Received: by 2002:a17:902:cf03:b0:2b0:c451:aea8 with SMTP id
 d9443c01a7336-2b0cdc2a006mr32009385ad.14.1774629903861; 
 Fri, 27 Mar 2026 09:45:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc882339sm63890655ad.43.2026.03.27.09.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:45:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org, philmd@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 10/12] target/arm/tcg/gengvec.c: make compilation unit common
Date: Fri, 27 Mar 2026 09:44:47 -0700
Message-ID: <20260327164449.596767-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
References: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index a2b944e81c4..70e6d8a96f0 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -25,7 +25,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'gengvec.c',
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
@@ -67,6 +66,7 @@ arm_common_system_ss.add(
   'cpregs-at.c',
   'debug.c',
   'hflags.c',
+  'gengvec.c',
   'neon_helper.c',
   'op_helper.c',
   'psci.c',
@@ -81,6 +81,7 @@ arm_common_system_ss.add(
 ))
 arm_user_ss.add(files(
   'debug.c',
+  'gengvec.c',
   'hflags.c',
   'neon_helper.c',
   'op_helper.c',
-- 
2.47.3


