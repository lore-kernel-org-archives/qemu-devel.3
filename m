Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC633C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpdj-0002Bf-Oy; Thu, 27 Jun 2024 09:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpdh-00029g-Bs
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:58:17 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpdf-0007jz-7A
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:58:17 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7066a3229f4so4264772b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719496693; x=1720101493;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=krQKuKxY8isoEphRQtni7oJK0QyOsCIS1H46MdJLkac=;
 b=y0CmEi0ojpbVXhUaikoRtv4TmI3gKzbVizdWinbh8Onf33d+W51BqYlugoMLG6aBDw
 a62LSTSp9Qe7Pj7MIFJzK4o6yLutWPXhxqUWv8O7ei/0WpOrxSxanhlhEMzhBXfq+fTN
 juQgZjjsHu201bgielAEMrP0RoFk7xZPfNk5mwah6jzNHz5/MenYv/4gza4zi91jxo+P
 nSoXRcdTLYOvwD3rVCEQdNE4B5OcOqzoSxFN5Xc/gVpCkhagmKdh1stNofIVKN99P3vA
 NGlL6Ryr4yuUxJkkPAwls5hP//eSwsoeD+P+fp+TZlO2ZzEkgyh//qAOznPfqSrkmv/G
 iOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719496693; x=1720101493;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=krQKuKxY8isoEphRQtni7oJK0QyOsCIS1H46MdJLkac=;
 b=Ljco6v4rCt9k9C1hLtW9ZnEcdz+neKOn4m4jerDe4qrP/bt4ujqywQnOlww4CSqe/M
 GKf03sKCW94e1ppBQyIT1I7YEiEQCdJLuqaMW65tm1rxDkJK+BMUrE5Os+qfCHLDE5Wh
 QcmWPvzIZvZOMbjy446ZOgDbaqZMpeY6IeNa9buAQxNbcpVms5CvQnnjmhz5CwnDAh/g
 foRO6NPt9Pcv2asJ/1Q0ZXOecOQXM6Pbi/LSQUh8zkdU4GuOkgAqvgiXa7JQA0t23cHS
 QbBe44eWOiNZwbncz57xbFanXNw5OGGquLvuKg+M1NJPA0iOvwYgkNVYeUYCAktxdteJ
 5SzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCI8bbZyka29hPsdckrtdsEyAACDno4stcqNcLaswR0VcPi2PURMRwkk4eYJ26iWrfXdFe8VQytDg5x695UosWggeHqi8=
X-Gm-Message-State: AOJu0Yx1rY95I9dA1F7xYepEsjAqrlIGmNjW74+5NaGqTChcviWLeH0w
 opA8xV11eFZ0nBAD8fKlUnghm/zd1G1UzwMKh11UdrYECHQGFTb3hJmpNmTaJGY=
X-Google-Smtp-Source: AGHT+IG77dzeSA1z0lafJxK8ebTqJPJUAjJweHti/NL1FQrYFMhih3j9X2eKx5sO8u2Goy1S/R01jg==
X-Received: by 2002:a05:6a20:7346:b0:1be:d321:7e09 with SMTP id
 adf61e73a8af0-1bed321a4e6mr1809950637.28.1719496693493; 
 Thu, 27 Jun 2024 06:58:13 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac8fcd45sm13518985ad.116.2024.06.27.06.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:58:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/6] tests/tcg/aarch64: Fix inline assemblies for clang
Date: Thu, 27 Jun 2024 22:58:01 +0900
Message-Id: <20240627-tcg-v2-0-1690a813348e@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOlvfWYC/zWMwQ7CIBAFf6XZsxjAisRT/8P0QGFp9yA10JA2D
 f8ukniclzdzQsJImODZnRAxU6I1VJCXDuxiwoyMXGWQXPZcyZ5tdmaT10Io1Nx4A/X5iehpb5X
 XWHmhtK3xaNEsfuvfV83PgnHGJ+PUXd34w+nBmSPQfrXrG8ZSyhci74CulwAAAA==
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Changes in v2:
- Removed spurious a compiler flag change for normal SME tests.
- Fixed sme-i16i64 detection.
- Link to v1: https://lore.kernel.org/r/20240626-tcg-v1-0-0bad656307d8@daynix.com

---
Akihiko Odaki (6):
      tests/tcg/arm: Fix fcvt result messages
      tests/tcg/aarch64: Fix test architecture specification
      tests/tcg/aarch64: Explicitly specify register width
      tests/tcg/aarch64: Fix irg operand type
      tests/tcg/aarch64: Do not use x constraint
      tests/tcg/arm: Manually bit-cast half-precision numbers

 tests/tcg/aarch64/bti-1.c         |   6 +-
 tests/tcg/aarch64/bti-3.c         |   6 +-
 tests/tcg/aarch64/mte-1.c         |   2 +-
 tests/tcg/aarch64/sme-smopa-2.c   |   2 +-
 tests/tcg/arm/fcvt.c              |  20 +-
 tests/tcg/aarch64/Makefile.target |  11 +-
 tests/tcg/aarch64/fcvt.ref        | 604 +++++++++++++++++++-------------------
 7 files changed, 330 insertions(+), 321 deletions(-)
---
base-commit: 046a64b9801343e2e89eef10c7a48eec8d8c0d4f
change-id: 20240624-tcg-bf8116e80afa

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


