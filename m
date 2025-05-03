Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1728C369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 20:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBJJU-0001Uf-8q; Sat, 03 May 2025 16:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBJJS-0001UB-5A
 for qemu-devel@nongnu.org; Sat, 03 May 2025 16:18:18 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBJJQ-0005tg-Gp
 for qemu-devel@nongnu.org; Sat, 03 May 2025 16:18:17 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-af59c920d32so2147155a12.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746303494; x=1746908294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pNpKhzvXBg9FkvEzbJwF+0TfRs4v+yn9oR4T7oYK0Pk=;
 b=c9sDFhpSk/5uzxtDE4KDq4iosjZ+wcr8TPlxqkmU+rKobEEb3KC8bueHZG5reQ0lDU
 w0bvRaVwM6HxI6zxV1CpwLHCGH1sBOwxJV7yS2a/J+aOImS+/5wjVppwI3CygWDTP5ny
 XAY28ArCavJtMYhb6jrRSmUYQlVF+L4He4PtLSj/Y/psvWa49r4yg4Ps7h6w68yh0Wom
 D5a5N1keaG5yVOoqgL4ha6jHSTMAg/EXbyVjSDuUx+RWXIPYPWGFDElupqGOCy08ses8
 39JX6WEF0UCCX4jhlSzdyMg4f+HoxN9nUmrg703/xxBpe3Or3Em5dDK2OfPgwhBHkkKF
 KuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746303494; x=1746908294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pNpKhzvXBg9FkvEzbJwF+0TfRs4v+yn9oR4T7oYK0Pk=;
 b=qDthcK/9sYP0oIZd6A82y6/2opDyHKA82z8ubvK+3v7YzjL5MDuDB7qlNNwzisoHpP
 92Hs8FdFj/LTbKiYdSFd4lJLvbku7ztxY7pIugQ1RfhEoUMsOsvyhJ2jlEpjRnp/fjz7
 TihqyYHa26p5a3ER5U9eSU2MsyfNC7cxv+mibwDo4Kc6+MZlLVssoj6glvH6r0gz89rP
 NjNYPatOhyzYBGI3C5NXgpIvrYsbeiyDdySf0N0sCRGF3H68pKPT2tJtEZUyzzuXHAXX
 EbsUiCBEFjxrjk+KAI7fNnSIzG2O6Emj+ENLoDD8Ctfg1p56DAq8BNHYjpajdE2j16fc
 O69g==
X-Gm-Message-State: AOJu0YxtDNLkt5V7JE/sSxOX6HUcZzD8ueJWWmKft1+JZiMJbzYLWxtd
 92xlnyjRbyBXwJbmX8JlbXrnGGBlv9sOqnH3Lgyz4ME5Owx5A3T5yh2m4r8Rut4n5pfEbh6vOkq
 NSk8=
X-Gm-Gg: ASbGnctPfNtRbrE0JWaU4ACv55dK8CGLbY7Wy6vreDzTg7V8VjB9gI7Nn0x60OwsT3t
 6rUAiXO2mYHTKjHsZHMnK5kTpQoPY7RljHe3yeqszMBDDsJplFgqiAjqrppzvAt4UShLPJi5G18
 wYYGuob/PXbZLLqiZSU0/R83qxFeClRE2oN3Z3ggz4fYUXefnw61bhNT56V9tVFMWsm+9P5u9zV
 vQ8qeX/F43eQSE/U/zi7J2+ps2879MDALILXHWHJrBEfHWp1OybLBcAix7X4aI6rPZ5OXUoSG22
 fIMbbx7spxR44VvcIX9N8OFbcgLHhYXOYw5EOP4vE9/mOTA57eQ=
X-Google-Smtp-Source: AGHT+IH2oLOhNoZZPJYEHBiW46F7qkezcePRrVLgmJtcPznHjE9f6zRGlcyVCn7EdsQcbwR1Qnvx9w==
X-Received: by 2002:a17:90b:2743:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-30a61a6f6f3mr3158478a91.30.1746303493785; 
 Sat, 03 May 2025 13:18:13 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34721015sm8245812a91.6.2025.05.03.13.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 13:18:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] meson: use thorough test setup as default
Date: Sat,  3 May 2025 13:18:06 -0700
Message-ID: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

Allows all tests to be visible by default when using meson test
directly.

This has no impact on make check-* commands, which use SPEED=quick by
default (see scripts/mtest2make.py).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index f8bf6e7bb66..57ff3f722d8 100644
--- a/meson.build
+++ b/meson.build
@@ -5,12 +5,13 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
 
 meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
 
-add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
+add_test_setup('quick', exclude_suites: ['slow', 'thorough'],
                env: ['RUST_BACKTRACE=1'])
 add_test_setup('slow', exclude_suites: ['thorough'],
                env: ['G_TEST_SLOW=1', 'SPEED=slow', 'RUST_BACKTRACE=1'])
 add_test_setup('thorough',
-               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])
+               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'],
+               is_default: true)
 
 meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
 
-- 
2.47.2


