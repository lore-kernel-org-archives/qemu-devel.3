Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67461D1D461
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdr6B-0007DZ-Dd; Thu, 08 Jan 2026 09:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5v-000722-Gg
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:38 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5t-0000hh-KR
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:34 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso27021955e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 06:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767882870; x=1768487670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIBuc/mkbQabpqpdJIoXotFl/D1JCK+3Ji0AYvgjRGo=;
 b=feYKpyncOSjWQgbNZEDUbr4+fJYTWJpDqocXnl606LQP6zZECIxtcch9zEtHv58bST
 ypsYqPYnBzy3EJ5+FFMgtga2/ZUE6UrTdEB5BV2WTkAK7HSNX6DCfP5CqEwQBh62hChA
 UWsOrPtZRJQlN2vMHcvcHIT3MJdB3dVkcsQxAd3oxrxNWKNgo2QUeE/wdVdW/sQaHNw7
 rp3U0EFOcfpOVXIuguZJlCF4GRSFaiJQrAXP/nKueJhh+2rHEaPGRv1nQB/Q9Vj+Axxe
 6FCXOy6FwacV+AWlpMzXesO05oG+T4uIJQHN4tPoTiAIY5SSbnmMCaoNbAU6Q3i9jAh+
 n+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767882870; x=1768487670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jIBuc/mkbQabpqpdJIoXotFl/D1JCK+3Ji0AYvgjRGo=;
 b=pZenxUPqM2NeAb3GxC3DAxu/Syimri2+nCTmx2DkNBbq7vW23n8V/kIR6whw8BEpJQ
 Se9CbnqlfK9FN8I8EzPR5Lj3fHnLKFO1vW+8VC8Kv84s2ktMYxR56CvbHhu/n1MffxmI
 DN/XveDBXSVG5AwPeG9P9mLhcunKLihki2f0jGR4WU9nz4mwatTXh6l4+TotU0PRljhr
 1PbNgCb8posOmCcwEFzmFqXN5kQeDhf8FvrURtv8xTM5HiVLmYpYIqkoLI6k6ZcSd2r2
 56pY5hheBFfXJ/PNAwpGV4pYBIvf1j1zhaaf7BkfUQcK1OGJKYvSlIgHAArHkXyLtjU5
 ysIQ==
X-Gm-Message-State: AOJu0Ywwvx4zjwrkYFjcHdVZiLkkGrdR4od+f91IjXmNmSsBXN6ag1Bd
 i1j2CLjEKOJ5/3jU4cBCYetttq8D4JS6JhkuJ93ADjf3miizUNv1eoRg4j4rP5Z4DZo=
X-Gm-Gg: AY/fxX74UPpIm1hCf2egxaQURDa3LuivRW58TXQav6jJtsYclD84s+yP7yz6QMoUp5I
 ddP7raeM2z0UAFnQU9MJHIN+HVIl+RHrcN5TpS4iPbk7mfrRkO1ZKGaQ5Ue7vfGkGMKmCAHwjNq
 uUm0BCcJK0loSHOJn/JetP8TQxioHEtgBh522IqqncE4Pc1A4JKw3ky5QLh9wtDyvcpqWRCePCD
 3xb8f+i9AqMUTAt9o02b/gF1j6I1x8MPZWR8AsiR68kIAU9MgmnUKJzAmDOMuE2LC3nCqWGI6Eo
 uyRN5ijUV7vJHLo1pGQAaHPtgIzatiXS4HyBh6YYujUSMlBJcFgc3YzNMY/r2XEtkDN6i1sErmp
 ATNnt0lNP9rRSfI4okH5bxiI5bQucUoC2NNLSbVuTN8SL37X8fPVjjWObuLi09L9OewjrQKPNqb
 v2piSqAgJwL0E=
X-Google-Smtp-Source: AGHT+IEYWVBCrSY/JFej/cH3QHt7HU4nTfQ1442Rqd9guEJxuXvZ3FOOtY3PLbbYmA2SO9ig+kmt0Q==
X-Received: by 2002:a05:600c:444f:b0:477:df3:1453 with SMTP id
 5b1f17b1804b1-47d8a177307mr34722715e9.28.1767882869557; 
 Thu, 08 Jan 2026 06:34:29 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f686sm155235405e9.3.2026.01.08.06.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:34:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A84B85FA2E;
 Thu, 08 Jan 2026 14:34:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 09/12] hw/mips: drop cpu_reset in mips_cpu_realizefn
Date: Thu,  8 Jan 2026 14:34:20 +0000
Message-ID: <20260108143423.1378674-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108143423.1378674-1-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

We will always do a cpu_reset during mips_cpu_reset_hold().

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/mips/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index f74a9d5f615..e61497c0f6b 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -485,7 +485,6 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     fpu_init(env, env->cpu_model);
     mvp_init(env);
 
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
 
     mcc->parent_realize(dev, errp);
-- 
2.47.3


