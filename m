Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B50C30659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQne-000212-6a; Wed, 26 Jun 2024 07:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQna-0001zG-An
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:26:50 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQnW-0001m0-RE
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:26:48 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f9cd92b146so51468885ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719401205; x=1720006005;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NWLH4ozYjb/RV95f5MT0yvQSKB4+2QLhaUMYHm8xf+c=;
 b=M4WciZWjL5pa/S99wHm4fgMh4FxljdTpwg2E+6Gwe5xzZJ7QMJoG9rMLZcgIsL2AK9
 cQ4l/XhjmbW9jFpJDr0yrPNobgB/LRWkQStjE9xVs2bjTrIP2NERocY9u5O3d/cb6ITm
 hrb77NqLy2c2PglT7Dt2YHTHynV9E54bbTdEUd11KI7tsCmiMFb7h/ctML6o8FKmLMt+
 hTefoKOTKMOXQuU57JhLPtinjuiEC6V5a7MBxqDPamWk3fjW3CPGPMf7tFgHashYWppd
 M7eceM5Iq9sAepa+g1qC+DLGL9jEwqwSznWsOm4SsW5iVQ7wYK94c7zbn+VaV1HYOAxy
 Jt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719401205; x=1720006005;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NWLH4ozYjb/RV95f5MT0yvQSKB4+2QLhaUMYHm8xf+c=;
 b=sYXcxSh6e+wKJoTXrQY+cjh0gGVVHAD7k8rlrU2Cxr9if8RHdUATlkpW4FLsHekRso
 iUljy9g3LD2m2gQht+jZdUKvWz/gRS7bmTyMad1RrUPmIZQ+dW9gqmw7Nlf8zaP965ua
 Q8OE8cE4NRtaXMHKXzGMqyDfd1HGBCthe7uyudODbb2eyHdzc2u2I2XSawpeO/Spk2G9
 a9UNgUWoAVBNL6nwG/ykXqyOuG/tF8I6M2ntnT3Xgh0t7+YpzJ5U2u8ZAoL6wzqfEDsx
 ovhelyYNXvb0cF/oNstLumpwIg3u4At8VSxqsV33akR0YYtIgRTK4WtYmgHF0G+lZ7tX
 VplQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr74Pd/Sm+RiSIlTeqrWDM+XD4tEiTveF6bHwob0Fj73chntp81wPihxqqQ9BD7fC42MwDlWhv8/tT8iMQCQ2FiUfU83U=
X-Gm-Message-State: AOJu0YzlR4TCIkP49iRlaef+qJEnLwY8QoOS/VIXYJAL0dIiJFdAYpQe
 Fmal1PeiTN6uWubTIpmixqAdVh3Tf6/ibfriqrpoUo+dRvBfmDH9JEOh+I/YgiU=
X-Google-Smtp-Source: AGHT+IGl0hiAXtpii2K6tZDyKcmqvckNTxR2aaE8Pg5foroqWImGP/iyabC1jeThAa9iDixwHDAqFw==
X-Received: by 2002:a17:902:d50b:b0:1f9:e7b4:5def with SMTP id
 d9443c01a7336-1fa1d3e0157mr125544385ad.3.1719401205521; 
 Wed, 26 Jun 2024 04:26:45 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f9eb2f03desm97863365ad.1.2024.06.26.04.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:26:45 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/6] tests/tcg/aarch64: Fix inline assemblies for clang
Date: Wed, 26 Jun 2024 20:26:21 +0900
Message-Id: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN36e2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyMT3ZLkdN2kNAtDQ7NUC4PEtEQloMqCotS0zAqwKdGxtbUAEDVDAlU
 AAAA=
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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
 tests/tcg/aarch64/Makefile.target |  12 +-
 tests/tcg/aarch64/fcvt.ref        | 604 +++++++++++++++++++-------------------
 7 files changed, 331 insertions(+), 321 deletions(-)
---
base-commit: 74abb45dac6979e7ff76172b7f0a24e869405184
change-id: 20240624-tcg-bf8116e80afa

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


