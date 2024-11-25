Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6A8D58D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatm-0003w3-C5; Mon, 25 Nov 2024 10:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatj-0003uU-JD
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:11 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFath-0001jp-HZ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:11 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a0fd9778so6784545e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548067; x=1733152867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VnPxiUtpKyIemgviXg6/NZ4ZzCAnKpaaDKYkxx9xIBA=;
 b=VHoEX08beGhi1B6kpQLf7YpkXIzeCsiHKml6ItZ6mhoOOOxA3DVqEBgwKXSMsNhNcd
 iJslbnJQe6o8WqVoj7UsSmOePRw6SEJB17oYJk/noi2+D3dTOSeJwXebXRPG2CIWJJdZ
 jdji0s4TP6M+1wQqU2clCMjk/2ayKdicZ+yuuLtlBy5oHWEU3aPdsKf8DCTgPn5JeRqw
 XiMoQ/nWHc2+/Sokg4taLHVk3LkhwcWjh30lWnxmFt6+HrXssvwAFBn9a2DMnu7gP9Rs
 +r5RgieSj4Leaw9rMUuO0oAW/ZxhtqiFAFCR37f4A8bCEShnX+TxxUJfRB6/VLmNmoYB
 E7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548067; x=1733152867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VnPxiUtpKyIemgviXg6/NZ4ZzCAnKpaaDKYkxx9xIBA=;
 b=QmNQYi9xQWb83bRqzbsjGgSxWK/xMqKqZSM/1THapGLopFAoq1uCwUGdloquP5xM2Y
 MNm5SY56ItRVCzKzbB63r2I/XMFDaBdn/IOEhTUg/kEtPn5Yqpb1A5c01L8UcYcQfghe
 Hpp9z1IOt726dhD2WRJs2h6W4BcuDx8PF9rAb5lp1mOahF7b/6lALPzR5h54aKxAlkOk
 hHWMYSThBSmDd3aszZd9x25Y7G1DWewybaeMZfSfDjsFpGgo/i3MWbcvkBULs+B6g1XJ
 tVN5uOF8CPxp5oYqTK+AAS3hFg3dcOaysi7LDQc4wFuV76wzdTWf3Vbanb/mpn3vEKEA
 svTA==
X-Gm-Message-State: AOJu0Yytv46hTYfugJ8z8j+njIXRienM+VpAp2RfH7RO7Tjz6kCqj37v
 OJl5t5nEnJljtQjvPA53Hu44RXaHks4MACsufjed+5PG/j3Ar9KqqwItjCVG3pez4Q9+sIJRhJh
 o
X-Gm-Gg: ASbGncuGUNiAcgTtXPy9lTc5MynuVB3E9vAmeT/TPQoiahL536Sc71YbCz4CdqagCy2
 L6ksk2dFbXx8mYYa+x1WKsozZrksAH0QzR9tafgFOyk/ONKUWEM61Xyyx5e6D2kgpHgzF0oxYSn
 rXq2JGpg3iad5FWgwCkfHVCuDJ/cT4g5+OudGOS7g3akJBoslTm846h53/NW63z8jinURG+2hxz
 BbxX4W+TxdoYIHNRa11er1t6wADus0AXpeeULxqQjHEFJHu
X-Google-Smtp-Source: AGHT+IE1lh6aCvLpg4MaP9o4GF8pz2IqVbBMzO5bzOiUOQpPfGhre3OaiMh9ewItGdbs8iXoT3Rq/g==
X-Received: by 2002:a05:600c:1909:b0:432:e5fb:2adf with SMTP id
 5b1f17b1804b1-433ce41089emr117216885e9.4.1732548067493; 
 Mon, 25 Nov 2024 07:21:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde8fb6csm133551475e9.28.2024.11.25.07.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBFEC5F869;
 Mon, 25 Nov 2024 15:21:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 9.2-rc2 00/28] testing, plugin and doc fixes
Date: Mon, 25 Nov 2024 15:20:37 +0000
Message-Id: <20241125152105.2100395-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

The following changes since commit 6b99bb046dd36a6dd5525b8f88c2dcddae49222a:

  Merge tag 'pull-lu-20241122' of https://gitlab.com/rth7680/qemu into staging (2024-11-24 13:39:06 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-9.2-rc2-updates-251124-1

for you to fetch changes up to f8f5923808031e1335fc6d280a4b959ed5d28608:

  tests/functional: Remove sleep workarounds from Aspeed tests (2024-11-25 10:27:47 +0000)

----------------------------------------------------------------
testing, docs and plugin updates for rc2

  - cleanup leftover avocado bits from functional test
  - ensure we keep functional logs for tests
  - improve test console handling to detect prompts
  - remove hacking timer.sleep() usage in functional tests
  - convert Aarch64 tuxrun tests to functional test
  - update Aarch64 tuxrun images to avoid corrupt blk I/O ops
  - auto-generate the TCG plugin API symbols to avoid missing them
  - fix rust pl011 model handling of DeviceID regs
  - update docs to refer to "commonly known identity"
  - convert aspeed tests to functional framework and remove hacky sleeps

----------------------------------------------------------------
Alex Bennée (1):
      tests/functional: update the aarch64 tuxrun tests

Cédric Le Goater (3):
      tests/functional: Convert Aspeed aarch64 SDK tests
      tests/functional: Convert Aspeed arm SDK tests
      tests/functional: Remove sleep workarounds from Aspeed tests

Daniel P. Berrangé (19):
      tests/functional: fix mips64el test to honour workdir
      tests/functional: automatically clean up scratch files after tests
      tests/functional: remove "AVOCADO" from env variable name
      tests/functional: remove todo wrt avocado.utils.wait_for
      tests/functional: remove leftover :avocado: tags
      tests/functional: remove obsolete reference to avocado bug
      tests/functional: remove comments talking about avocado
      tests/functional: honour self.workdir in ACPI bits tests
      tests/functional: put QEMUMachine logs in testcase log directory
      tests/functional: honour requested test VM name in QEMUMachine
      tests/functional: enable debug logging for QEMUMachine
      tests/functional: logs details of console interaction operations
      tests/functional: don't try to wait for the empty string
      tests/functional: require non-NULL success_message for console wait
      tests/functional: rewrite console handling to be bytewise
      tests/functional: remove time.sleep usage from tuxrun tests
      tests/functional: add a QMP backdoor for debugging stalled tests
      tests/functional: avoid accessing log_filename on earlier failures
      docs: explicitly permit a "commonly known identity" with SoB

Junjie Mao (1):
      rust/pl011: Fix range checks for device ID accesses

Pierrick Bouvier (3):
      plugins: add missing export for qemu_plugin_num_vcpus
      plugins: detect qemu plugin API symbols from header
      plugins: eradicate qemu-plugins.symbols static file

Thomas Huth (1):
      tests/functional: Convert the Avocado aarch64 tuxrun tests

 MAINTAINERS                              |   4 +-
 docs/devel/submitting-a-patch.rst        |   7 +-
 docs/devel/testing/functional.rst        |  16 +++
 include/qemu/qemu-plugin.h               |   1 +
 .gitlab-ci.d/check-dco.py                |   5 +-
 plugins/meson.build                      |  12 +-
 plugins/qemu-plugins.symbols             |  59 --------
 rust/hw/char/pl011/src/device.rs         |   2 +-
 scripts/qemu-plugin-symbols.py           |  45 +++++++
 tests/avocado/machine_aspeed.py          | 202 ----------------------------
 tests/avocado/tuxrun_baselines.py        | 224 -------------------------------
 tests/functional/meson.build             |   4 +
 tests/functional/qemu_test/cmd.py        |  89 +++++++++---
 tests/functional/qemu_test/testcase.py   |  43 ++++--
 tests/functional/qemu_test/tuxruntest.py |  17 +--
 tests/functional/test_aarch64_aspeed.py  |  98 ++++++++++++++
 tests/functional/test_aarch64_tuxrun.py  |  50 +++++++
 tests/functional/test_acpi_bits.py       |  57 +++-----
 tests/functional/test_arm_aspeed.py      |  84 ++++++++++--
 tests/functional/test_arm_bpim2u.py      |  20 ---
 tests/functional/test_arm_orangepi.py    |  27 ----
 tests/functional/test_m68k_nextcube.py   |   3 +-
 tests/functional/test_mips64el_malta.py  |   4 +-
 tests/functional/test_virtio_gpu.py      |   3 +-
 24 files changed, 446 insertions(+), 630 deletions(-)
 delete mode 100644 plugins/qemu-plugins.symbols
 create mode 100755 scripts/qemu-plugin-symbols.py
 delete mode 100644 tests/avocado/machine_aspeed.py
 delete mode 100644 tests/avocado/tuxrun_baselines.py
 create mode 100644 tests/functional/test_aarch64_aspeed.py
 create mode 100755 tests/functional/test_aarch64_tuxrun.py

-- 
2.39.5


