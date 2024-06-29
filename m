Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BAEC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 08:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNTss-0006vZ-KW; Sat, 29 Jun 2024 04:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTsp-0006tU-A1
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:56:35 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTsn-0008FK-KN
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:56:35 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-25cb3f1765bso734695fac.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719651392; x=1720256192;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GhzLCcbYqjj4/wO4kZa5ouP20FwgGHEunUiM0ObyYwQ=;
 b=3J8bWMcBUHH0Ltvt9FDfGDoHnri9JF48KwaouBAQxgp0jXGQJw/rqEGPEJ7Z8lROtW
 Aq6pXeorUMnBm6fjYvfpvdcvgx3ryyl14nwcW98BScTed671VznDTojbdpaoee8p6EV9
 edla4UCEZu0fVdKV80axwMFoiIBqpLZqFu9bW3tmv0vu1cS5wtC61opgAcdhQRSwI/IY
 Xg6zlauZIrDpukp5OJzqwpILrlTl/3vVYKuKzV0WgxmyvqMpBI/bkycFUv84Qoq771dI
 eoixtwQB1IPBdNQ6vwu2OuSV0oLfs56llP20WtP6nEjUnSUEt4QiLvNFIlMoT5SV9+kN
 23bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719651392; x=1720256192;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GhzLCcbYqjj4/wO4kZa5ouP20FwgGHEunUiM0ObyYwQ=;
 b=qgWhnnd3FsWJqJGKv8Ytwpqs4v9g/1TKSZd6eGW4+BYfEYPfgGk80wE16d3g+FZ1SK
 3OFSLN75/Hn6psecUWDM8rqlHps1FwWa5pWI3thkWDtvd0rxfoYvCKlypNviFp+XOp1Z
 1nnGY6gf0PgKKGpQiLyh3QoYte82cuTImx5lvOiOnS2G213c6C1ubaOz7MnxhXsurMXf
 iYNH3alHyLFgDgMB5H1bBnXIxdZKlPQrUA7Ztc9XA80phyuoTmn0YvwcYYX31NxCYBBw
 eFpGG5eSAnY4VHy/MEKdXWzSVFMMRt+msy3Tk0BQBQhjnH8b7+nLo7hswyBhRTRf5Abr
 h3AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF7BXXIRjpq66OR9K9Sr5zU0quFEWnsS1knN+dFyhUEQH+qRJcxRuCxaz7xjkQH8arAoZgoODdmtkCSFTW7BoNHNWNLck=
X-Gm-Message-State: AOJu0YwEVl7gmNsPRu2OOtESdICsu3VOFpCEVePCQm6Tj0aNSbxKFX2q
 N9cL9dz5zbaNcaKVsU6lIHCa++XTQtcyr4+RTx6NCq4RY23DhKDITqGyZTZTNgh0Y+kH75jLCmh
 yt/Y=
X-Google-Smtp-Source: AGHT+IFkhoKdI4hPxVYzwXf2g733giCS7xxgIM6zGu+xKMleGrJL+SYfJF2lNmFLQ3C+GBdZAULwvg==
X-Received: by 2002:a05:6871:7806:b0:254:9ba7:488b with SMTP id
 586e51a60fabf-25db366c32dmr421989fac.40.1719651392034; 
 Sat, 29 Jun 2024 01:56:32 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70802959452sm2938138b3a.90.2024.06.29.01.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 01:56:31 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/7] tests/tcg/aarch64: Fix inline assemblies for clang
Date: Sat, 29 Jun 2024 17:56:26 +0900
Message-Id: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADrMf2YC/1XMQQ6CMBCF4auYWVszbbFUV97DuCh0gFkIpiUNh
 HB3C8ZEl28y379ApMAU4XpYIFDiyEOfhz4eoO5c35JgnzcoVAUaVYixbkXVWCkNWXSNg/z5CtT
 wtFfuj7w7juMQ5j2a5Hb9erP7JAUKrJw3Z6Ox9Pbm3dzzdKqHJ2yBpH5R+UEqI2ku6KzUurD0h
 9Z1fQOiW0OKzAAAAA==
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2001:4860:4864:20::32;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Unlike GCC, clang checks if the operands in assembly matches with the
type in C. It also does not support "x" constraint for AArch64 and
complains about them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Added patch "tests/tcg/aarch64: Use -fno-integrated-as".
- Added patch "tests/tcg/aarch64: Specify -Wa,-march=armv9-a+sme".
- Dropped patch "tests/docker: Specify --userns keep-id for Podman"
  as it is already queued.
- Link to v2: https://lore.kernel.org/r/20240627-tcg-v2-0-1690a813348e@daynix.com

Changes in v2:
- Removed spurious a compiler flag change for normal SME tests.
- Fixed sme-i16i64 detection.
- Link to v1: https://lore.kernel.org/r/20240626-tcg-v1-0-0bad656307d8@daynix.com

---
Akihiko Odaki (7):
      tests/tcg/aarch64: Use -fno-integrated-as
      tests/tcg/aarch64: Specify -Wa,-march=armv9-a+sme
      tests/tcg/aarch64: Fix test architecture specification
      tests/tcg/aarch64: Explicitly specify register width
      tests/tcg/aarch64: Fix irg operand type
      tests/tcg/aarch64: Do not use x constraint
      tests/tcg/arm: Manually bit-cast half-precision numbers

 tests/tcg/aarch64/bti-1.c         |  6 +++---
 tests/tcg/aarch64/bti-3.c         |  6 +++---
 tests/tcg/aarch64/mte-1.c         |  2 +-
 tests/tcg/aarch64/sme-smopa-2.c   |  2 +-
 tests/tcg/arm/fcvt.c              | 18 ++++++++++--------
 tests/tcg/aarch64/Makefile.target | 21 +++++++++++++++++++--
 6 files changed, 37 insertions(+), 18 deletions(-)
---
base-commit: 046a64b9801343e2e89eef10c7a48eec8d8c0d4f
change-id: 20240624-tcg-bf8116e80afa

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


