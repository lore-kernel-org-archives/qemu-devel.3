Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21EAFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOAi-0007Sw-VS; Wed, 25 Feb 2026 18:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAg-0007Sf-Mt
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:58 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAf-0003W9-83
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:58 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so1687185e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061595; x=1772666395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LQBmUOv64AWIlZs+bsj35UWAYLjENFL1DoqIkVynjBA=;
 b=JWGZsjzfeNws9Mr5fonpsPj34OyysKUr/Z6FaCwebrWHbLWM3pkLyRHnJnns/4XXPb
 it2UTZAD9DPBco/jOq25Va81a+XVT0AK0maeDiuxkxq03E5PskEqBzhVhrp9XOcAYKmz
 GHOKDoxn2ZJz3bZN8pVG5GIGTjSERlgA1U84wG6jXmt3rBiVJ6uxlIikFvxa2d5OGoYf
 QKjHfLfvKKmQweYjAditycNPg8BhisHZP7Qqo1W4MCZrvA1GV8Ds//jSDfRJisX5z15T
 Ruegfzn+bynT6N+tKbaWWlDEiiTZsmoY3d23nq8mr/Gsm6QfPnADsMfAHHdZ70xol0FP
 RPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061595; x=1772666395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LQBmUOv64AWIlZs+bsj35UWAYLjENFL1DoqIkVynjBA=;
 b=m7J6tzY1x3/dj/aLVws4EpqTdye2hdBekX1q4yyz89ccfYpvg89Sm34ua2IDtdU4y+
 p3/FkT9+BEr9Qq91YuYR/qU++1g+HzvqliZt/3ODTpm8hic8AgsNwEeJYO+IDNTQmQWn
 BLMeRw8Tf3FbQDXObS608nebZ9ldlViI2fOKWCryymBKWYm37RWYML0ZEVeTbaY5mnBC
 o2WuRi6f4yInPLey0tnTZJ8V9oeKt3RDxe9FQkvUHC48oGMG/GUPCmsoo6FHASTL5Weh
 anZhNXM6cPFTI9oWtY50HWAdl3TboKrNdHZmWmnXUDVYaZK+0T7ppYmFi/u/BDJYDDOn
 KPRg==
X-Gm-Message-State: AOJu0Yy/SUeiblykVxerTH6fGnwWLX7yAHPdhl/HOwwR6Dh8HTqLqvCQ
 y57xWPgYDXhd77DqgBgVr9gUpkHdqsBgYU6AUHD20XRNy2YdTFBy4k9kMl3qTbRJjTzYNssg8Tx
 xvJMSSOE=
X-Gm-Gg: ATEYQzzCzgfzJJnvTiyDiX/EYJrYkqFAi09lMgfL43fjkYSpb4yJj35mJm1sDuS0prn
 QJBLl0ZCJfPsL4Ebkxzm7vKsEyRYuRydtGJt9thahYeWmagNbfisbTrN2a0X5f9ZtlOXb4kVuOa
 gOsKy2Yc8YXWCxJsGFL5QEArVgsVeXjUw1Nqx6hEypoQgLANel9YSOM2dXb0+d1nDwOEyp3UkWp
 YUh2W7iIpQK7ru8GNsolOtfFhJ1Kkj+rl7wt387DpqMPyGl3HSCI0OOxmKG1Ur/unbE71+CJKXP
 L9w+3ibdvUq+W2lgiL9bWmrHzdj2OOo1knZmnGuyYhvw+Oca2xoldAm0qpHm3CCcxARCptlMJuJ
 3bvUl42rQveJ6vHVXS55toOxQerCpq0KWawdZFGwDwSH47ZMqC/KjM3igKMsR504OTjeJza2PMc
 3T1MJA3ZQcWCCS2uo+FQA7YC8lrtmRhEA/bPK1UHXcs5qryDK7+vf4Q74G8Y4V02PwZo0AqQUs
X-Received: by 2002:a05:600c:8b02:b0:47d:5e02:14e5 with SMTP id
 5b1f17b1804b1-483a95a86eamr309985995e9.5.1772061595421; 
 Wed, 25 Feb 2026 15:19:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b3474dsm5380985e9.1.2026.02.25.15.19.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:19:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/70] target/or1k: Build 'gdbstub.c' once for system single
 binary
Date: Thu, 26 Feb 2026 00:13:50 +0100
Message-ID: <20260225231411.96482-51-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

There is a single qemu-system-or1k binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-43-philmd@linaro.org>
---
 target/or1k/meson.build | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/or1k/meson.build b/target/or1k/meson.build
index cc912ee6cf9..7cea45287a2 100644
--- a/target/or1k/meson.build
+++ b/target/or1k/meson.build
@@ -8,18 +8,25 @@ or1k_ss.add(files(
   'exception.c',
   'exception_helper.c',
   'fpu_helper.c',
-  'gdbstub.c',
   'interrupt_helper.c',
   'sys_helper.c',
   'translate.c',
 ))
 
+or1k_user_ss = ss.source_set()
+or1k_user_ss.add(files('gdbstub.c'))
+
 or1k_common_system_ss = ss.source_set()
-or1k_common_system_ss.add(files(
+or1k_common_system_ss.add(files('gdbstub.c'))
+
+or1k_system_ss = ss.source_set()
+or1k_system_ss.add(files(
   'interrupt.c',
   'machine.c',
   'mmu.c',
 ))
 
 target_arch += {'or1k': or1k_ss}
+target_user_arch += {'or1k': or1k_user_ss}
+target_system_arch += {'or1k': or1k_system_ss}
 target_common_system_arch += {'or1k': or1k_common_system_ss}
-- 
2.52.0


