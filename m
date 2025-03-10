Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EADC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1traOV-0008QO-MB; Mon, 10 Mar 2025 06:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1traOT-0008PC-5w
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:29:57 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1traOQ-0001Fn-VO
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:29:56 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39140bd6317so956801f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741602593; x=1742207393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+9H8yzUqnFGE1iE+v3OEk3XLWxU02TF3f9IPBab7k/s=;
 b=o5L4RXdQ71Iat53bnjM87P14Z3bLlrvnAgsPcT57RiG+DWW1zMb/vPu+IzEhkxM/lj
 sNqlQjFgskI3vh+086XKx7OtY+o+kB4dc3ENLzi2dMVhS2cyq8c062MT/hjU7BoTS5L1
 7W7ZLh/ikUFNRTUcLHwNbsO+808OXg8S2Vx2XOZ+/zCV7liX6J1w4kJYd8wc9rexnHCp
 qq9HTB7y0qxCe0oL3v3/pCpZLviKvSu+MQwCsFmxG2qOEtfvlSx3OQ07KY+DwVkXPL+O
 bCiu/VR3Inxhb1iIYVyk2j51z2jUd/OjeepK0+KPVcJE1Ns/PNg/GEVGycII0AnqYrkS
 LBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741602593; x=1742207393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+9H8yzUqnFGE1iE+v3OEk3XLWxU02TF3f9IPBab7k/s=;
 b=Ehs1AkuptQ/Q8rtJYX+qBY3oDgyEfNoMdyHbkqSpwpPnHeInK/DyJo6XYuTsIlNOVO
 rHAIYfcPKQzOQlJm0fzR3wYDfB1NdqiHochDbFvu05+g5RWgkmj98bBn9QLKOqhuCFeK
 foQB1e+C4fkSTrcQ7Qqp2oQuWYz4JOtIsZTIgo7sjAJRbLHbeIICe2D7v9MliOzH5pre
 2kEWKXdeseQz8Kyc5o0vW2n6Gn5iM471LiBNyBy2jFDjMycF2nSdge2/4QuCESgyJTEU
 j/CW59+bSgE2V7+PNjRZuD0NDnxnFAWF+f9cARnpKcR9Wug5PUTZVb2pyEgO/n+zkiia
 TRlA==
X-Gm-Message-State: AOJu0YyM56/uJVHMMczGavq58w8FSRkG/++nYer5v5IT+nSCbCvD5VFJ
 wi5DtW6PQjFG6eZEA3/RGMuA+htPWe9BwP4U/cv4GCTDjQgdC9GJ5SOc21qxZvl1GMkQMoGbfnR
 T
X-Gm-Gg: ASbGncto/l7a3dPrS9Mbd8q95StLhepuDxqeWvqbQ1MD0kls3oV7xeDxAYLj108a/B+
 3xfAW+opZvPgj2QHO7jpWnvNibi0ZwtpBoDhpHIQrOjOoMQ04tyafoxMMNFwB7wTQr81gRB+8QA
 br1osyjyshnasDPCFDvTap/eg6tkaLGGwJpAxqYGEFhonEGxkELevWQB0PwQQ/gfqWriwJ3strw
 5abC8pOrsB/HIbKg1J87NV+SteH5rbzhDinqfQUs6+rn4WK1XMrvTowU3PYvVZ4kscR5kVhZGQp
 ZpX/o9pxy4rB7tRnB8nKcQZLs3zlDg3i67iBGIhFgZvA9SEFXL0=
X-Google-Smtp-Source: AGHT+IHV5F2Jr2zLhbz0KN50hfYH78Trabii68SLIHsv4aD4xoq/mHK2HSekrdqRTFM0QJByE4psxg==
X-Received: by 2002:a5d:6482:0:b0:38f:3e39:20ae with SMTP id
 ffacd0b85a97d-39132dc580amr9862319f8f.43.1741602593101; 
 Mon, 10 Mar 2025 03:29:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfcbdd0a7sm13036945e9.11.2025.03.10.03.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 03:29:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] meson.build: Set RUST_BACKTRACE for all tests
Date: Mon, 10 Mar 2025 10:29:50 +0000
Message-ID: <20250310102950.3752908-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

We want to capture potential Rust backtraces on panics in our test
logs, which isn't Rust's default behaviour.  Set RUST_BACKTRACE=1 in
the add_test_setup environments, so that all our tests get run with
this environment variable set.

This makes the setting of that variable in the gitlab CI template
redundant, so we can remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 meson.build                         | 9 ++++++---
 .gitlab-ci.d/buildtest-template.yml | 1 -
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 8b9fda4d95e..2f373dc675f 100644
--- a/meson.build
+++ b/meson.build
@@ -5,9 +5,12 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
 
 meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
 
-add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true)
-add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
-add_test_setup('thorough', env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
+add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
+              env: ['RUST_BACKTRACE=1'])
+add_test_setup('slow', exclude_suites: ['thorough'],
+               env: ['G_TEST_SLOW=1', 'SPEED=slow', 'RUST_BACKTRACE=1'])
+add_test_setup('thorough',
+               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])
 
 meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
 
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 4cc19239319..39da7698b09 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -63,7 +63,6 @@
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   script:
-    - export RUST_BACKTRACE=1
     - source scripts/ci/gitlab-ci-section
     - section_start buildenv "Setting up to run tests"
     - scripts/git-submodule.sh update roms/SLOF
-- 
2.43.0


