Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E63C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jIo-0003vf-0Q; Thu, 10 Sep 2026 14:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIm-0003u3-Ts
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIl-00072w-7S
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4956869750eso1293255e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789064109; x=1789668909; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E0D8WpUOmZ6uQghtDZOgPlvKzwogse6TvsFAvnzbc3k=;
 b=MlAUtgPCjDjscYAwFtooISaIKSUFsoFtjNZZg6zKMAoNh927CIWCC+hWZs6pocRWz5
 nXYnQbdpeKlkSm72QR4JfMzaEJ68Tbdyxfen7YerVfszQPax//6/+Yr3TRCRXn/jWJ/r
 TlLVNAYwkUAUIJmUn/tEEUT6s85RSG+8Bk9h0Cal+oPiOMUz5ERyRYm8tMuVM43Xfu2B
 9rJH9vrQenxz30PgX/JSx4FSYEJsIXalR3GZrJpUHvYWsJegWFVm7ZYVGS9ACw+QN9WJ
 pdcqDaM+BfG2aNpgzdTlpIDVjrR2eomu05CO9ciU60gTZnLkHpYAZzKgbUfGWniKWq/c
 SqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789064109; x=1789668909;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E0D8WpUOmZ6uQghtDZOgPlvKzwogse6TvsFAvnzbc3k=;
 b=chcWczmvQcZz1/LlwHFYFx3pJbOEMbZJCCrZ4CGr8cFyhVxRWuV8vo7VevULw2Jj/k
 dZY4ExMZqvsShVJ4Wn6yBFc8YJ6aPGgjCJ4FP6ZDyii8l6RShWeJk/XSfhYzzrMAT0nD
 9LLlXOcMT+oNi8C5hLQnNLHcS4sPm3kDL2Y8cYAkeKhKFZBa8y5545Layen22+RGtV4Q
 Xixx4LnnQ0PZpGHzNkG9t5QphkVgDFonG1wfVK9rUqaJPQRzMFgorzMG1kHAjWqebfYB
 UXvniQXQSsW8q+rKv87fZkmihysV0Y/dLrZNKmTFhnE/cq6OWKwwnRxeibOOhnkISAaG
 7Jmw==
X-Gm-Message-State: AFuF++msCqOBQwa6jRwUwZubYaBeNdYTTVJPwWMSKFsBYXFUxvEGgq0J
 g9SLZx254gCxgYmYewvILjFVXoawf73dEim5x57EKnIe9j/U52UGmr28tI899rtPOPY=
X-Gm-Gg: AYBFou1sJDreAycR2hI/UPUhuT08CE3nO0unnzMhEu8tWprCPOInW4A3o6d63DDpGtF
 u8T7o/l8pnsRPIfwOT5+gj02dBlDSRmcmgrvHamE9EogHU6JTaS7XgXgKIFNBsY6osZc+1f1nVy
 N/pzH0RPZDyBPT+nOIaBV+vCHQ+eOv2c3yjU/Gwpovlqiwhi3x+i+vy1y6LNadkz+0mxgBQUn7s
 ypAlaFXqzJWLmLvNywQF/RIxk8CSV9A9c3vWip8LGfPeOLy/dRCZ0+jWOaQJcZZuhC+3ZzsC5nY
 OUqb11J5GbaNr5rOaH1wOcKdDiyyklwLUWZ8QFTCigs0hyqf2F2pxvnfBx6rx6R2ddU0kUi9xWm
 8y+iKuCaDMQJRarp5Rji9MaGdOq3BkV9F4QNUVx8cRFtCOaTL+IlyEMG2U4TZe0+MPlG2FzgK48
 tirvaq34wtiukttJ93yxtk+GuMDFbjia60Bgb1shyLEPuf7uRPO3S7gZoRvDDLY50wV0Rwnys=
X-Received: by 2002:a05:600c:3b07:b0:49c:fa20:cbff with SMTP id
 5b1f17b1804b1-49e619c18a3mr3062245e9.22.1789064109542; 
 Thu, 10 Sep 2026 11:15:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eaccaa1asm446824f8f.0.2026.09.10.11.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:15:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C1565F834;
 Thu, 10 Sep 2026 19:15:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 0/9] testing: various docker clean-ups post meson tcg
 conversion
Date: Thu, 10 Sep 2026 19:14:55 +0100
Message-ID: <20260910181504.1010916-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

This cleans up a few bits and pieces although doesn't totally solve
the issue of an apparent stall while meson builds the docker image.
However with these changes there should be no difference between the
meson build and the equivalent "make docker-image-foo" invocation.

We also finally get rid of the ill-advised magic caching support in
docker.py.

Please review.

Alex.

Alex Bennée (8):
  scripts/meson-buildoptions.sh: update missing options
  tests/tcg: prefix meson built docker tags with qemu/
  tests/tcg: use --add-current-user when building containers
  tests/docker: add container registry to configure and use
  tests/docker: remove used _read_qemu_dockerfile
  tests/docker: strip remaining caching logic from docker.py
  tests/docker: add specific command to parser
  tests/docker: swap --quiet for --verbose

Daniel P. Berrangé (1):
  tests/tcg: improve check for working cross compilers

 configure                               |   8 +
 tests/tcg/test_cc.c                     |   6 +-
 meson_options.txt                       |   3 +
 scripts/coverity-scan/run-coverity-scan |   2 +-
 scripts/meson-buildoptions.sh           | 142 ++++++++++++++++++
 tests/docker/Makefile.include           |  14 +-
 tests/docker/docker.py                  | 188 +++++++++---------------
 tests/lcitool/libvirt-ci                |   2 +-
 tests/tcg/meson.build                   |  15 +-
 9 files changed, 243 insertions(+), 137 deletions(-)

-- 
2.47.3


