Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F57BC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VLR-0003r5-NE; Wed, 09 Apr 2025 09:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2VLM-0003pk-7W
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 09:19:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2VLH-0001Ob-DJ
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 09:19:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso3978859f8f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744204786; x=1744809586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hBel3wOi98xysAHKa2JSFo2dxfVFTv0e2MbQUiZZCL0=;
 b=v+2QCefD0YPo/MxC2dW33+3n6sG56adLgSS8n+juAkdfYKO381296F5UZ7GBoFiw93
 SUKafPcnEgeedY0mqoMkhNssw1MW1RMpI5e5e2sUsBsUehNUPfhLVm2TWxvyWeM0hVVt
 /fe09+nOShJQJfsO3eW9feGPDA23DvcV6iDB6jyqVsE/1xyKbvfzeSRmu0OB8uUMGDF2
 H/vYv/cmEE4DKl644c+dIzQY1KpWzTPCixJAQR3FXZ7f3n58g7waK8YPO3A85oanlDEB
 ReFtAXwa+KoYTt9+o7aBD3NRBImczDEaPnF3Rx8Io5ajgQXY0aZDyrR/3lreuA0xeVhO
 pOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744204786; x=1744809586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBel3wOi98xysAHKa2JSFo2dxfVFTv0e2MbQUiZZCL0=;
 b=jJu/p3FWP6bMz5nzP4jF0j2WYrinBRzXSt9TfulZaPo4fgKBZs+PphLO/hSBqjB1yk
 kO+GV6JgZaPXWcJYM2VNRGVFsSOO3mJbK/wwy4BlES85DfJ+YAK/4fFQn88ULbY+yED1
 xL1Wps4ywbDt6SOzjTMOSzYa2NsgamoEWP8h8x8x+JjAiZWo9CdelJe0l40/xYv4MOsO
 UJCSdqqVJ0BoKReP3MoApR35MCHOZxr2zRKpW7mnmmhNP36OPuZzZw0mbMXTh6aRnuFY
 KsEr9kTF3jkEklyNYkIZ9Uud4ZoPs7wj8VPrqpWxYZTXZCl5NJkGZMsvuava2OrbEvY1
 FCXA==
X-Gm-Message-State: AOJu0YwDIl/zY4LQicXLvtleD11iJDJMezWQU8UU/ceU0Kg9aG1ZaCwC
 JgFcPaU5GSJQ0Y2GF7m+OZmv4tnIMNaeVph+QYTOBxMg6/oHHX5ml2wzUnN+Qw0qyqTVdrRhiM1
 w
X-Gm-Gg: ASbGnctep1nvdXtYqpB4LVUsKOgM7LIBll05ehk3uFb0sGwE234HXTVukurqvHYjKCF
 2K0tuU+oZRm9/hVouyMyco3i2tiaCKgeWSoHoRv044kufg/9Z58e2vGRiEGDfYguS+EgyB3eNiT
 Bw+QcFMIzE9o5HCZnGjrrQI6vbJXmH0Eqm8jHREWhcU/s22t+tulOCX4aDdwGtkILYs/ioeG/SC
 B1vUW6MneJCvbnxarU2cTLEm9Q6Dp6VBnFWbPu52SCBkiplVbP2i+qq1V9rHTNgetTbIBVwjs+k
 0a5ke9Qm6O5WdDMwwx4NCq91mFiXSH07X+gZbKhFecg=
X-Google-Smtp-Source: AGHT+IGfNwYUgdwqZfawuhi8kU2dGZLwkSAKxDb+94DJtM1hzalZQ5lEyZ6laa/SK08WHu6+bBTEng==
X-Received: by 2002:a5d:64a9:0:b0:391:3f4f:a169 with SMTP id
 ffacd0b85a97d-39d8853853amr2059427f8f.32.1744204785817; 
 Wed, 09 Apr 2025 06:19:45 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d89389ed6sm1610875f8f.41.2025.04.09.06.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 06:19:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 710F35F8B2;
 Wed,  9 Apr 2025 14:19:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 10.0 0/3] final fixes (tcg tests, plugins)
Date: Wed,  9 Apr 2025 14:19:39 +0100
Message-Id: <20250409131942.1706923-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit c302660920acf48425a1317d56122ea8af60fbc4:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-04-08 09:59:33 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.0-final-fixes-090425-1

for you to fetch changes up to d832ff9d0248c2f1895352ced3b3bf7a71f42702:

  tests/tcg/plugins: add plugin to test reset and uninstall (2025-04-09 10:35:29 +0100)

----------------------------------------------------------------
Final fixes for 10.0

 - properly exit aarch64-softmmu tcg tests on unexpected exceptions
 - fix deadlock when uninstalling a plugin

----------------------------------------------------------------
Alex Bennée (1):
      tests/tcg: fix semihosting SYS_EXIT for aarch64 in boot.S

Pierrick Bouvier (2):
      plugins/loader: fix deadlock when resetting/uninstalling a plugin
      tests/tcg/plugins: add plugin to test reset and uninstall

 plugins/loader.c                |  2 +-
 tests/tcg/plugins/reset.c       | 73 +++++++++++++++++++++++++++++++++++++++++
 tests/tcg/aarch64/system/boot.S |  5 ++-
 tests/tcg/plugins/meson.build   |  2 +-
 4 files changed, 77 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/plugins/reset.c

-- 
2.39.5


