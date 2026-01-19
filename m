Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FEDCCF2EE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhufR-0006sG-M2; Mon, 19 Jan 2026 14:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufN-0006q0-I2
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:57 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufL-0001Uv-Ob
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:57 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so31101325ad.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768849914; x=1769454714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+UNy75P3JDLlxl4oorAdGDjnZ4Yy9t5V2rmv0cUcHM=;
 b=hP7x77aCVF8fdwV0T+Oxk0gHj4I1m96hZtPCU1+kruuQ//5bcohMOkcbGeTE+EVuNH
 +VDbNsdo4uCUaCP6SjmdH0UoyT8xK4M/fneuGjS19v7Emk/pkbskNtiR66bQ3dZN2SUd
 oa5ELxfu7LIBDakNhpmC0mKuNOft3EhHEAk1tOs7pCiuOwturnsgGC1qN8OUXkZTUzhA
 uGrioRClK8jqUieBuoJLGewZoigeYr7s3MXYRkUxJ+6v7KW0oQOeQpZml2c+TvtaHJ7G
 9LUbDrm4+pSx5U09rWAi1uG0q0uUpq8Z96VP7vfZ+7S0Xids7uC/ivv0ObMRpb9BNRhF
 XxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849914; x=1769454714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v+UNy75P3JDLlxl4oorAdGDjnZ4Yy9t5V2rmv0cUcHM=;
 b=OJ9wD/PEK2I/vwQPEyi3YtlQXy9k40Xlx2gHPkOmJ3Gn8cq+2AFkixLnqMU2GUs1LX
 uN/gC3z8M9LW5WwxihtIahBw8ZN/q/IfN4vLOD7jsuLiTzXZOgSvuQswKKQ8vNPxgf4a
 oiebM/2ntTQibdypqhrK+DvvOJKR4wVaavQVmpncU1rxEAckl/sst3a15NrjP3ceT+2S
 b+K91nwYwYGu7l8deptbJmB21IAdIwiiMArfaEEnJxKxV/16S+SW0/eBsDd4HGKE7Kms
 8H96f7foOxQZcQfga8eoQtckFPSv9WYsXn3L2Ye+u8uOXocr9mU6w2SWt7RLdD8bEZcG
 UZQw==
X-Gm-Message-State: AOJu0YwYl5N8SwF5L4zcpLESC/hgQt7EGE2/7Uf4D2O0m+LB1tMlQ3ox
 NevSlUdGBjYMuG4GpRz9Y1aSAXlV+QyyShyKUalM1I5VG+SFN5KQdFaYy9nxkVEe7JjiaVqjHW2
 P3EwC
X-Gm-Gg: AZuq6aLQt7C4Ukn+qUfY2+iGseFMOmAhIAflTbXCgkd+U2PnqUenz6HstKKFExxcBMr
 W0CWx57aGesb/2SsNWIKfpRV+L0UMioOD9YY58sv0DlEBdArlmanFT+XOwHBVkcaMtTYv2p5uU7
 lkqqdytfXrEn4qM19ISdDC8r4Wiwghg38tzH2Oy8dIyVDWnCHvwJundjG8YshdAZ+C36aRf27t+
 Ml97ZvuoSoqKJTcCx1Uw9SCgMWs6xQf/WPHb3g9YDm9zfp9Q+i8w2oJ8GLWwWgrP6S4y08VY04/
 Uxo6ZyqohWoMzLQo4t7V9W3mR5+AFmaOyg7pjq/4F4+8ib7WUEIZRf0ekDFdc6ZTRC4QqgDuo/3
 fS9F/3amK7b9tXoAxTMEAJYdFJUC4zFEby3eICfnjT35pFEZZEErk4u2Kr3m0WyjsjH/c2EyHLC
 TPFMfcD+ZLURT0PWU6DQ0OOpAj1DWX3oaP0T6GAIhmvaYDnLFP3vO9RRwDBJW/oQt5
X-Received: by 2002:a17:903:1b48:b0:297:df4e:fdd5 with SMTP id
 d9443c01a7336-2a7188b8c56mr103280255ad.23.1768849914170; 
 Mon, 19 Jan 2026 11:11:54 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm47011795ad.89.2026.01.19.11.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:11:53 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 10/11] meson: update C++ standard to C++23
Date: Mon, 19 Jan 2026 11:11:36 -0800
Message-ID: <20260119191138.811069-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
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

C++ is evolving faster than C, so it's useful to enable new standards,
especially for standard library.
Update to most recent standard available in our build environments.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index a2671a325a6..d57623e4f79 100644
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


