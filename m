Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB191098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Zi6-00067z-EZ; Fri, 20 Mar 2026 09:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhx-0005zG-8D
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:10 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhs-0000NC-Th
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:08 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-668d4751a3bso946198a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774012563; x=1774617363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bvPr4D3U4aYpEBDt0gtYg+QezK8BhDvD368zVSWXdg=;
 b=LPBdfxmGDjHZfTAGIts/LJF0QkKVZYd+N1NgCali/S3dG/sbLhIxrGYy9342CUJFvn
 /duYzzNPGpUtO3ak4podA5RAqetPN9bQJvbdJavxGLIg1tIrNPG5UNsw9mDOGHaaG5/C
 QtNkpfn5qLFDeZNlJqhl3x7NUw5yI4N6zF5Hw9pEHBiFtlXhvRW9Wg9dd3d3fN3QdWx5
 YSmMjKVDA2Q1qB/tWf9c3iuIJEz1O2JTsjjI8pWAHpA6CHc3nYmXFkBwH7y0yYOa60Pb
 EzS52voSrT08YiWm0Z3fuKlQE1yE5gFf7Kwjbz+gXinm84wFIJgSD7ZJSc1Wgac/uuJC
 sA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774012563; x=1774617363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3bvPr4D3U4aYpEBDt0gtYg+QezK8BhDvD368zVSWXdg=;
 b=T8v1BuRA1rroKM0pWkqRhhzvYUP5bp6+gnLkYo/oYlk6B66AWQJ00cFTq2LU1Fptrt
 xOPrw3i7lcvPCU8r7lor/NM7EiyC9RyZtD6jiitdoJs7CLp3woyGIL3eM4Qt1xBmTdDi
 WwWFZblejGBSgg4DknLafONqy+YG1TMyig5CZhQdZW1ftI5/rIzhhnCINtDwBXkzQx73
 Ddlz21KZYaTrmzw0zETu9XWVQwpmOgZcMSpJjIXGQpLQiGs+e+ARtL9cU5NOL4ndbBkX
 qGdEj3+0+3+38czDUmzkU/e252ycT6rOX5U8Q+wIxOfSjEiMzIvYGYSa9WUzFruLD2Wa
 ZNmA==
X-Gm-Message-State: AOJu0YyTAXgvbcpzl1dqYUHF57VG7DiJKfTQsUDABlMMsnbYLwDgul2U
 ju4YQm6qHGydwIgWIv+9GXrbR2PHCtNGRI6o3aptQMD21rCfAyjFjfmgdnnfR79R27c=
X-Gm-Gg: ATEYQzzRfhtiW0/N63YdxZY35dKPi8j1nVeFTK13WIPMUXHP6qZX5sDyhybdRzM7Vgm
 jnuaxahcn91tsYqkWELGV1oFLd2Cf5DuZ4sFdFxIgCTezaHijC5rOkADn/OvPWxasS5VGMvp9kd
 1dy1kUUC4OkdzhTDTrRFt4ONI7n4FY4gsC34GizbQEjVCgS2nxJ/LmLNs/J3OyGUP0fKEiPCPlq
 ig8wU3peFQm4pDz+kt7EKXSeEV5VRaJvrsgaZhZFPBMNOGcBNYReAchF59tKmmANYROerUcrph5
 8ChhCPGVbrTlov4IahKyko0044srqHjdtWrg1zGx/CPNgUHHyD12yNskl5u5gqW7lncN1Kx+56i
 jePZDVK08Wsp2YB5M5gDvxYo2tdxzQ0ej4uGNdi9XPYSvxBk6kc3lHUMX540+jdQNzVuLrYcujw
 Pp0bTpgv1JQ1Mrqu1+QldemFg=
X-Received: by 2002:a05:6402:440a:b0:665:e9f:9021 with SMTP id
 4fb4d7f45d1cf-668c932395fmr2098518a12.9.1774012562887; 
 Fri, 20 Mar 2026 06:16:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-668cf4f887fsm1427482a12.1.2026.03.20.06.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:15:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B05CD5F909;
 Fri, 20 Mar 2026 13:06:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 24/35] target/arm: remove event_register check from
 arm_cpu_has_work
Date: Fri, 20 Mar 2026 13:05:55 +0000
Message-ID: <20260320130607.2071996-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

The generation of events are not indications of work to be done and
importantly for the case of WFI instructions not a reason to wake up.
Remove the check.

Fixes: d238858bff6 (target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 98d09ac0656..d51599dfdab 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -144,12 +144,6 @@ static bool arm_cpu_has_work(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
 
-    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
-        if (cpu->env.event_register) {
-            return true;
-        }
-    }
-
     return (cpu->power_state != PSCI_OFF)
         && cpu_test_interrupt(cs,
                CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
-- 
2.47.3


