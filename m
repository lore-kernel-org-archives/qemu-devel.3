Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAABC35FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTvb-0007B3-Js; Tue, 17 Sep 2024 04:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sqTvZ-0007AY-SF
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:51:18 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sqTvS-0008VV-B8
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:51:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42bb7298bdeso54918955e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726563062; x=1727167862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x9moB1E/VDJ5fnyL71mYaVTWUUZjOZEXCkhdsWVB8kc=;
 b=vOWgVCgVfbzF+S5FRy0/52wsD3j5kU6XKl6CjyufGUZdz8cYrggpE1gKBLUiu110yJ
 xnpS+YucC0on1Erl+fJrN66TcvMCCFK8o+DP9+oyqSwdwO5J9/8zLuzwLRFlPhbcYIsR
 vsJB3l83YvqWL7QtDZhgNFREd/Gan7haEa3WHk0kRDXRPXIj+v6+D3XLlr2/E/UjD2SM
 eGadSotAsx/RMG6An5XtLJuG4Azk6AoqzGIoAItYIkKE7FAtKm0t8+IA02dQsMj69dF4
 AnqvtCaglQeaml1cpory4b3jtI7WQyUrugYloL42gw3dQwMz4M+0XWmKMNsCzre4+1PX
 E6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726563062; x=1727167862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x9moB1E/VDJ5fnyL71mYaVTWUUZjOZEXCkhdsWVB8kc=;
 b=HXDp2CcXEzop90WMjRL1ZIxntYLzOT3kJY2P5hWRf2nzyUZLK8b6UMBce+2/+mG0P2
 xIT1zUgaKW3YbJECKm7gFqhXIPIb5PvbBXLEbMznLBK16MbhJX27AZK1aWmgc0Ofho1q
 xKshaFuyXTUf4rPz0nfCSka4+DEsjtA722bjppNVZN7wQLqEFOuoL08eUQVcJIbiDb+6
 vSIAX2Rc85hfJWtYjOqVmr4MYe9Zv7kak1Ger9TFf9t8aSl/Koo2eWbLAAMavUjqdEh9
 N5RpPgrcF2Krqv8QHwi2MwMhywRoyWzPHOch/I8U2zOi7ipNgjBNnQoB10dK0AMYwvA5
 X0tA==
X-Gm-Message-State: AOJu0YzSoLBQC6/kFyadG9DxI7hBxNc6xiDN1n85WOPOzwqBsOSpukMv
 d2RtIRl7pD93gC7xYQWrngoXgq021sDfze73Z6yxaClLgHpvwIjhwd5ckR3B2NUMp4oc9gK+lZN
 c
X-Google-Smtp-Source: AGHT+IGFLHuYRJGu8aTvi5YblBJ1xpepH2Eyi/zBEoNw763otOJtAU0G9iuXfAqwoO2iyjpikfdOyQ==
X-Received: by 2002:a05:600c:4714:b0:42c:aef3:4388 with SMTP id
 5b1f17b1804b1-42d9070a3e7mr154826645e9.6.1726563061453; 
 Tue, 17 Sep 2024 01:51:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.131.223])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e780016asm9021193f8f.85.2024.09.17.01.50.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Sep 2024 01:51:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/3] ci: Replace macOS coverage from release 13 to 15
Date: Tue, 17 Sep 2024 10:50:55 +0200
Message-ID: <20240917085058.1740-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

macOS 15 "Sequoia" was just released. Add support and coverage.
According to our support policy, we stop supporting the previous
major release two years after the the new major release has been
published. macOS 13 (Ventura) was released on October 2022: time
to drop it (well, in 2 weeks, but posting the patches now for
review, to be merged in October).

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  tests/unit: Really build pbkdf test on macOS
  .gitlab-ci.d/cirrus: Drop support for macOS 13 (Ventura)
  .gitlab-ci.d/cirrus: Add manual testing of macOS 15 (Sequoia)

 tests/unit/test-crypto-pbkdf.c                       | 2 +-
 .gitlab-ci.d/cirrus.yml                              | 8 ++++----
 .gitlab-ci.d/cirrus/{macos-13.vars => macos-15.vars} | 2 +-
 tests/lcitool/libvirt-ci                             | 2 +-
 tests/lcitool/refresh                                | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)
 rename .gitlab-ci.d/cirrus/{macos-13.vars => macos-15.vars} (95%)

-- 
2.45.2


