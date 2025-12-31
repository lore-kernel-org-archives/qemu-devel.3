Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7513EE57D1
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqiu-0007f7-It; Wed, 31 Dec 2025 02:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqis-0007dd-Lv
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:22 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqiq-0001Bx-9O
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:22 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7f1243792f2so7113024b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166459; x=1767771259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rO23KvY3ZrVbi2b5cSDac8dT1YRjqOhoYJTRDHAXekY=;
 b=vQpjFrtMM8m4Tke1keuuCOOjSF/VQ7nVwrw0ruZxm2Z0wOLN2grbPCP/QMa3cGttbx
 F067Tf5m3SHExyXwmBY53e+tEYTBewTeSjPk8sB2A2fI3SufBZvHoxX1lK6eugoAqkBx
 7nYy511ndYSk2E47DT3OMY7Nv6aIhJaYVAREzk+xIyqx6D1A9NiM6U7l9MyYF/NA1vfs
 94/LjqMUVgihm77h47DxhfeXbhdNXzWRP/OeXCGFo3JsPhfUpitPtoeDveoCQ7RMm2V9
 zs8RrG8sBL+K6FEFxCbzqwHSnfLHPkptkJBCKgXZ2vYGc7vmxckcjA/1hOTQkexOMQUt
 QFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166459; x=1767771259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rO23KvY3ZrVbi2b5cSDac8dT1YRjqOhoYJTRDHAXekY=;
 b=uw3fgud21Q85SHbDqhW8B0JfiCRAuLClOiWh4AUFIzHpATBA+ZE6pnD7amZ7/Cmpio
 FVYb1sS+7CWAJmqRYW7Q+1ozArOJIH+H/Pb094Af3zlRAxtN0aKWNjefIP0a7gOgByzp
 a+U46TVSqF8SM2g3Ri3JATskzjayAQ+IFvXySk6GKAQQaM2IGmqhbsyEKCLVkaK9fOjr
 LJ+BLjQmoHeoFWfNOvDigD0/yLMYsqz9kfsdZmpc2+YfXxWjVRq78ALKljEqWERrUKx6
 QZY5y/j82ZnxA8IoKEsVtkTns90AxwQ94TiK44KkWmNhaGO0tAtHO5A0dfhWJYz61UDh
 oRmA==
X-Gm-Message-State: AOJu0Yy4vntUF/D7O21zDDhxwgcy7ARVHVm8S+mF5uzS5oVMLli6wUWi
 rKZAeQ5j+huJHUlt2VZ9dubFe1SGkQR9KJJJosKFvuK8gxG6eL+RNKY3+GeSXHu1hgmVJSfXfz9
 JaYhH
X-Gm-Gg: AY/fxX7l2g1A0YVD1zDpoGVsWZOfRBoZDfXlTTp9N8Lw6q3fry2HTMa1UvAOXEJTYOG
 nqOPu20nVvz924LKH/lo/8jej+mgdw8mWC2+Ox8a6BULToG8eaQH7cC9dYlAkHk6+64/smz80LH
 e9ZQ7M6INMvU6PLaGUaMnZayy2nbMAKPqr0Whsm8V06RGqX7iowRibIE/LOIpE2m3ccAe+CE2t5
 a7uu/2e+vEOcs/arBnYrfA5lLCBrTqOQeoM7J+LOfTjIQ+GcaR/P5GFFd7sB20Sp+nK+5igqlDh
 hYE6A4rDVkQQg/GOQgX1ob9VlwRmBPdni6mSJTJYCh1x8eFbdgzqKm1voukHcQQsJu1x2y1/TXY
 7Rht1o+pcqqP1yDOjvcyhionpf9LhnR9s/BF3mgjzhlQwjD8cAQIZxlvmsirmHHXKahwD+posCH
 xdQJDieqeVfAX2kvkWdgDMGe4YrkWWbsIFcnqcyYz6h9+zXzGtOyokLOByUWbzKHyD3JPtlk0L/
 /Q=
X-Google-Smtp-Source: AGHT+IG81WyQV4MNKThQXUTvhZ/ftKq70Hk/74WLsNpUfidOzcL/nUAcG+RU9Keh2Weqhi4x+a+OAQ==
X-Received: by 2002:a05:6a00:340b:b0:7e8:43f5:bd4b with SMTP id
 d2e1a72fcca58-7ff6725a0a3mr30429101b3a.55.1767166458703; 
 Tue, 30 Dec 2025 23:34:18 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm34597984b3a.51.2025.12.30.23.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 23:34:18 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 10/11] meson: update C++ standard to C++23
Date: Tue, 30 Dec 2025 23:34:00 -0800
Message-ID: <20251231073401.2097765-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

C++ is evolving faster than C, so it's useful to enable new standards,
especially for standard library.
Update to most recent standard available in our build environments.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ecfacaf2ac1..9eaa7e2c8d4 100644
--- a/meson.build
+++ b/meson.build
@@ -1,5 +1,5 @@
 project('qemu', ['c'], meson_version: '>=1.5.0',
-        default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++11', 'b_colorout=auto',
+        default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true',
                           'rust_std=2021', 'build.rust_std=2021'],
         version: files('VERSION'))
-- 
2.47.3


