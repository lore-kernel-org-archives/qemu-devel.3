Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8882C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 21:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf4Ye-0005K1-90; Fri, 16 Aug 2024 17:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sf4YZ-0005IN-UJ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:32:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sf4YX-0000Xe-UQ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:32:23 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3717ff2358eso1271873f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723843937; x=1724448737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FQh0QJhCbLd86zDXPRNkn3AQi7dFzwG3ifnJG1Chf3E=;
 b=hWw6SWaw1ae+6gCKd9c4HCuLO8Duj5yBXBQuKL6aJYM/OucJeMJYFTUYLeoHFKqo3H
 syFRvgmhC22IROzYQkjkMyBl4weN9KIV9/NLvpfR6Jwv4oL5fMvk27//2JznhmIYZEE6
 D+/tNIr7aRhTuzTOxmjcqOURUESVUUC3NBHDVR1FwgeSl0GcqyiN07wq5k5//vwiltO8
 Znhg38a2q02s0DyF1+kSQPjlpJqfr5wGq2hv+5gj7Y4gyKyjja6XO55wizU4iTVhKz3X
 Fr5L7fqIUc4VqLwOHJnVPJZtyPHcfMi9JkwEAC7fPM6ZxBI8nmL4jXS2TntM+9yqFA+K
 EjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723843937; x=1724448737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FQh0QJhCbLd86zDXPRNkn3AQi7dFzwG3ifnJG1Chf3E=;
 b=lv2g4n1/ncbehaZnuY9eJI3jHpPpnWvpZ/k7TFUo+a8roUMqTY/U8NjJ2Gv9XO53EB
 wB2bP7BnQC5miiQztERR9tQaATnQLcbgudv54jajp5mUe67fFCKEuOm2YhR5SwuKAHTC
 P7gMLI/WHJhKIAEX076AoFWJqtKDZdyQm0M3HxkI7uSFc/4xLK/GPlvBDxjf3GoIyNTX
 6YAdOe7WIPhQMbGrIlflTN/nMexWDQx/4ReMtopSgLIleW1JYwXT7ZU1tYJ2zy9EkU9c
 IffvbyVmrk0d6TYdoP/phKM+JnNWqFImOLzpJlyLNmMKmvSum96gW6zcQcqxrb+r1K4L
 4w8w==
X-Gm-Message-State: AOJu0YyQoEZFEm5OXLEKTTRvLvMGOzUwHi9KHM8AdsQB9baiXcDi1G2b
 ikQlTGVljILIN7Hud7D48JyRq+uqKakw/jowG0uKdXOYAZqb/zbTzjMybtiCigZNKunNvfk7gRc
 Kgdk=
X-Google-Smtp-Source: AGHT+IE8g/Ps27UkjbOHNXP+NCjw5BRnFpEFXd6F83bwC6hCm7s64qsjh/3ulNGMhqyj8yK/xnlN+g==
X-Received: by 2002:a5d:498b:0:b0:368:48e6:5056 with SMTP id
 ffacd0b85a97d-37194641ed7mr2724486f8f.22.1723843936007; 
 Fri, 16 Aug 2024 14:32:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.17])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898aabf5sm4394219f8f.97.2024.08.16.14.32.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Aug 2024 14:32:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] gitlab-ci: Replace build_script -> step_script in Cirrus jobs
Date: Fri, 16 Aug 2024 23:32:03 +0200
Message-ID: <20240816213203.18350-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Long due upgrade, see [1]:

  In GitLab Runner 13.2 a translation for step_script to
  build_script was added to the custom executor. In 14.0
  the build_script stage will be replaced with step_script.

We are using GitLab 17 [2]!

This removes the following warning:

  WARNING: Starting with version 17.0 the 'build_script'
  stage will be replaced with 'step_script':
  https://gitlab.com/groups/gitlab-org/-/epics/6112

[1] https://about.gitlab.com/releases/2021/05/22/gitlab-13-12-released/#remove-translation-from-stepscript-to-buildscript-in-custom-executor
[2] https://about.gitlab.com/releases/2024/05/16/gitlab-17-0-released/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .gitlab-ci.d/cirrus/build.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
index 43dd52dd19..102cdbd8b1 100644
--- a/.gitlab-ci.d/cirrus/build.yml
+++ b/.gitlab-ci.d/cirrus/build.yml
@@ -26,7 +26,7 @@ build_task:
     - git clone --depth 100 "$CI_REPOSITORY_URL" .
     - git fetch origin "$CI_COMMIT_REF_NAME"
     - git reset --hard "$CI_COMMIT_SHA"
-  build_script:
+  step_script:
     - mkdir build
     - cd build
     - ../configure --enable-werror $CONFIGURE_ARGS
-- 
2.45.2


