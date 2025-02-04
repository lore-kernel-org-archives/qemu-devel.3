Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDBAC02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIO3-000094-MA; Tue, 04 Feb 2025 07:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINd-0008Fz-9s
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:18 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINa-00028z-Gx
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:16 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38daf156e97so268465f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 04:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673412; x=1739278212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yOXam1zZRDwCCiYrbs7WMh4G2vY3JpKf6Wb1iggPBq4=;
 b=K1Ht338eFkLLITjwaLHL3hQj3Fu9XAH2QIrPmO7aWfUqwpCjPyX1tG41XUrHjZ4Oh4
 2d9lyVwa+t+KpF0e49qcVXEuxLNGQF1XrtW+9d6Ky4jyz3kGq/kyq/wmKSmiH1aEWT0l
 gm53AdFwDK0GycsrHIMNiXibnM+dN8uzO3eBNo4Nen2LRwNP1dUQpaaNRz9iMQv5Zu5r
 H+QPcypQmbk1eHVIdQ1/AzGv09Cldn3XbUi7kdFb7SQTC3X7piX/9y3ozsg+Zkc4qRAf
 nUn04OPqWWanhys1N8bOHtaFQId4UAxTBGViXy0Oq+cvzCGWvS3AxE3lQb+nZh2xMSCn
 uc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673412; x=1739278212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yOXam1zZRDwCCiYrbs7WMh4G2vY3JpKf6Wb1iggPBq4=;
 b=CQJ4dQ2WQPibSHfSNu+8g/tU3BuYe5WugakoyWXZC7hu8fM2wEHZTu6Zww8qj/E7hg
 cHM1xmt2P/Qwkv1tPrtaOSvbSVUtIstxeyw6WoVQnY5wXjCq0zfb1ThactBzDiJEJMhq
 KHgeDmXdotGu1i5XeBjfsSl69Z/kbMufhuaSdkPL7W0uPbspfGqL0FQHDg4+wxIgC2XZ
 aFGDyJP/B5hMfBhPvKzzzYVBX1Fe/oO+bmV5dacJYvvDbIT4xOSqa9yC4iX31FaZIYRQ
 pa5aadzDt3D0lP4JCyH+5uF8JjafnKRtZPidXTfYznVwO4VQi2proDL2kci4Gf7/jEiz
 kkag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdHmq5AYwp3bILPt/ARYhfL0v8UxiHrXG8wqxcPpuC2zdKwSk/tHKQvrIKQRlGIpQTACrOuTFu9yeI@nongnu.org
X-Gm-Message-State: AOJu0YyZCVDA0avpH18sOGRBVHQf6GUCKC+GU5vITqQDLJ9kKZcbV2de
 ijT5ywFPLWj1w04t2L8+qv2EfxALqKYh9CbOM2CXbELRs4F4XQJ7FDXWS84TybA=
X-Gm-Gg: ASbGncva1HZSfJgPqfKpBkz5zuHXhYsca7l0NtzcD03a7Wd7czVOn3niogUYqlYqNy5
 +gzmqLliUr5fweaNrFUlMFQ15x8Na3SZsKf1Qd+sc1l2GRPul9zMLBGYpa0umeFRkUz/nZOmVnS
 5Xlnyj3ph1loxmfFfphAXEIy6/YGskjMK3sAEs4Uzw8Pp0TD4B6xjuaCLrmsG7rIvmHC8Wmd3Af
 +vRK6BYE6EZ726d71Xm1SK4sZgzI/5awaWi2QpLfnxwkh6y5Mp6anoYXC5oYhg0iexCcU+EG+dh
 Jolh5MGnArofZHfflyK+Jw==
X-Google-Smtp-Source: AGHT+IH09LPOKrDtyHY/JE4QnBMaOIGIDjF2LsxE+W1cm2LBqdSFksbaC1OMf39HAcqXHhxzvjABrg==
X-Received: by 2002:a05:6000:1a8b:b0:385:f47b:1501 with SMTP id
 ffacd0b85a97d-38c5195fd82mr20021127f8f.32.1738673411839; 
 Tue, 04 Feb 2025 04:50:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122465sm15757919f8f.47.2025.02.04.04.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 04:50:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 0/9] target/arm: Implement SEL2 physical and virtual timers
Date: Tue,  4 Feb 2025 12:50:00 +0000
Message-Id: <20250204125009.2281315-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

This patchset is a respin of Alex's patches, with some extra fixes
for bugs I discovered along the way in our existing code (and
a bit of refactoring to make the fixes straightforward). It is:

Based-on: 20250130182309.717346-1-peter.maydell@linaro.org
("target/arm: Clean up some corner cases of sysreg traps")

because it wants to use the renamed CP_ACCESS_* constants that
that patchset introduced.

The bugfixes are not super exciting as they mostly are oddball
corner cases, but I've cc'd them to stable anyway. The actual
implementation of the missing SEL2 timers also should go to stable.

Alex Bennée (4):
  target/arm: Implement SEL2 physical and virtual timers
  target/arm: document the architectural names of our GTIMERs
  hw/arm: enable secure EL2 timers for virt machine
  hw/arm: enable secure EL2 timers for sbsa machine

Peter Maydell (5):
  target/arm: Apply correct timer offset when calculating deadlines
  target/arm: Don't apply CNTVOFF_EL2 for EL2_VIRT timer
  target/arm: Make CNTPS_* UNDEF from Secure EL1 when Secure EL2 is
    enabled
  target/arm: Always apply CNTVOFF_EL2 for CNTV_TVAL_EL02 accesses
  target/arm: Refactor handling of timer offset for direct register
    accesses

 include/hw/arm/bsa.h       |   2 +
 target/arm/cpu.h           |   2 +
 target/arm/gtimer.h        |  14 +-
 target/arm/internals.h     |   5 +-
 hw/arm/sbsa-ref.c          |   2 +
 hw/arm/virt.c              |   2 +
 target/arm/cpu.c           |   4 +
 target/arm/helper.c        | 324 ++++++++++++++++++++++++++++++-------
 target/arm/tcg/op_helper.c |   8 +-
 9 files changed, 296 insertions(+), 67 deletions(-)

-- 
2.34.1


