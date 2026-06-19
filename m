Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC5CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXpB-0003nQ-01; Fri, 19 Jun 2026 07:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1waXp8-0003dQ-0u
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:55:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1waXp4-0007Cv-Te
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:55:49 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-460662fcb4eso1472194f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 04:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1781870144; x=1782474944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=83zyTawpaD7qELC+AE6uWDq8vF8DpWT0PSlxDjfA0WU=;
 b=Kyg1Uwia0+7yvMUTnuergI0yZH9eQWQOFMfXQoXebX4aG4N3TqSnvFfkbhoPxW+d1M
 tDFwwdY7+ZnR741FBZRKNsn2+4WxGPjOis7oycj7FU1eamW/v6wio1mUPbCVCwWiR5oL
 rDDqUSiGsTuo9yHK9yh09KtmEM7UEjulIu3bO8QscupFH1z9as5RFdT+fCoVT92XJcWe
 g4AanBgEhBEeU17FWCqIJ7YLdzpbK+CqFT+RMn+Ii5GasNG6a+5qW8H/hqRsAnuWi7ZH
 BLxSgVgK0r5+pqCWEFEfFobe0NQ6ut1WLYHNJoFiWrZ7trDdOsMs2alIPjQ4XZz49wbw
 lb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781870144; x=1782474944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83zyTawpaD7qELC+AE6uWDq8vF8DpWT0PSlxDjfA0WU=;
 b=NxuTpChTBIh6q2wZ1Tlh2txTqnx+H5LnJp/jmoBcsHMC5gwEejIlLvxrh21RkNf2rZ
 9A+LYBVgUTfcYtidpZUPnfaDonRV0jGq/cUmCnCwUS7ZUNAsVyurbiaJR/vbBs8kBIzK
 auUWxBf8ZqeVtWjQTveUhSKl3z8EZ/9L+/q7ptG53MebGRStLLyS5zewqX7iz27Q56m3
 c5s71kcQOW++S3HaI0jJEhY+j2OxLXmDn1f3XPPJhuiOrJPgaprYelitNkuFStnauaYt
 7ZVAJilffVuXZrUVPKodFXbLXTYZ//M9vP/DPrCr2y07nGdib1xQ9n7uGGxWnHGJ6twt
 6d8A==
X-Gm-Message-State: AOJu0Yw3CeRwtEmPJA/4WTB/GZSkTGY1l+npFuKKuDUXSR0yUukYcVK1
 di0KmOgVcLqzYZN65rPLsSESKvGPyflc+0cVZtwrFhVwOzXY8kaXzQE7zs1McmNpCfcdAO0idxS
 kZVYA8pI=
X-Gm-Gg: AfdE7clp+SzApoOYgyprgM8Y8vJ9tpirFJKgKCeKpC2va7VgAFyAR4GjUh42hmyk9jd
 Dudy/EI/qGRV2WJWtbnF6YrS7h2R2ZD/PC38n/Ik340cohrH6/9uI8gF70o7eWGn6zfoFdp8lib
 VPs6HLOnW65Wyj9IMTuf3Qko2Lv6+Q3oqVZLtBnsafcBkN9cPE1kAjnJkaZvCeVE/A3bayWXHs8
 xwLqlPJShiHDr0qumUX5HblOXM7Pe2xvJnTtmX9qWyj5jhHCZlyNtKtyfywkVIpzCwSAUOyRMBK
 YJvXtyu07mFT54ZtyrEKPhlesgRPNHptOpxfZ5iuzZI7eSMlHpArdZymLmvKheQ4z/jy94ADO0Z
 pZyVZpcKR/rZhFEqeybcdcURkIrFJIrGJd0A9A6JO0VHb6TUvpQCzCf6fkk81vvUspSLgPYtYQo
 xMnS4BQgquXY71exD/CErebWh/jMYF3P3DcF7/zkk0hJ2R8lzp
X-Received: by 2002:a05:600c:4342:b0:490:bde3:d112 with SMTP id
 5b1f17b1804b1-49240e9547amr31482405e9.30.1781870143698; 
 Fri, 19 Jun 2026 04:55:43 -0700 (PDT)
Received: from localhost.localdomain ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff821aasm64439975e9.12.2026.06.19.04.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 04:55:43 -0700 (PDT)
From: <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: eblot@meta.com, titusr@google.com, clg@kaod.org,
 Alexander Hansen <alexander.hansen@9elements.com>
Subject: [PATCH v7 0/4] initial support for yosemite4
Date: Fri, 19 Jun 2026 13:55:29 +0200
Message-ID: <20260619115533.5664-1-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x432.google.com
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

From: Alexander Hansen <alexander.hansen@9elements.com>

Thanks to Cedric and Emmanuel for reviewing.

Summary of changes from v6:

machine:
- fix underline in doc

functional test:
- no changes

max31790:
- considered defining "max31790" string in header,
  but it would only provide a single string, so meh.
- wrap macro arguments in parentheses, thanks :)
- use switch case ranges to make code more compact..
- use hexadecimal literals instead of binary literals.
- define an explicit constant for the tach count
- use modulo arithmetic for indexing into 'pwm' array to prevent out of bounds
- use modulo arithmetic for indexing into 'tach_count' array to prevent out of bounds
- use g_assert to check for index inside bounds for the arrays:
  - 'pwm'
  - 'tach_count'
  - 'tach_target'
  - 'fan_config'
  - 'fan_dynamics'
- fix format string in trace events to match the width of data passed, thanks
- functional test: fix spacing between imports and test class (2 newlines)
- implemented new Resettable API instead of legacy reset

max11615:
- implement new Resettable API
- replace binary literals with hex

Alexander Hansen (4):
  ast2600: yosemite4 initial support
  ast2600: yosemite4 functional test
  hw/sensor: MAX31790 support
  hw/sensor: support MAX11615

 MAINTAINERS                              |   2 +
 docs/system/arm/aspeed.rst               |   5 +-
 hw/arm/Kconfig                           |   2 +
 hw/arm/aspeed_ast2600_fby4.c             | 266 +++++++++++
 hw/arm/meson.build                       |   1 +
 hw/sensor/Kconfig                        |   8 +
 hw/sensor/max11615.c                     | 320 +++++++++++++
 hw/sensor/max31790.c                     | 584 +++++++++++++++++++++++
 hw/sensor/meson.build                    |   2 +
 hw/sensor/trace-events                   |  22 +
 include/hw/sensor/max11615.h             |  19 +
 tests/functional/arm/meson.build         |   2 +
 tests/functional/arm/test_aspeed_fby4.py | 101 ++++
 13 files changed, 1332 insertions(+), 2 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2600_fby4.c
 create mode 100644 hw/sensor/max11615.c
 create mode 100644 hw/sensor/max31790.c
 create mode 100644 include/hw/sensor/max11615.h
 create mode 100755 tests/functional/arm/test_aspeed_fby4.py

Cc: Emmanuel Blot <eblot@meta.com>
Cc: Titus Rwantare <titusr@google.com>
Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
-- 
2.54.0


