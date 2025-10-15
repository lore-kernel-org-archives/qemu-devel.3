Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C61ACCD184
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 01:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8qA6-0000Pq-Ua; Tue, 14 Oct 2025 21:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3afbuaAkKCmAJGVG8MW8LEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--lixiaoyan.bounces.google.com>)
 id 1v8qA5-0000Or-Ho
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 21:18:41 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3afbuaAkKCmAJGVG8MW8LEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--lixiaoyan.bounces.google.com>)
 id 1v8qA2-0003CL-2L
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 21:18:41 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-76e2ea9366aso8410647b3a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1760491114; x=1761095914; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IFyj84vqLfEkqmu15PAQnw/KCJJmqiY1n5DwOEyPEdY=;
 b=sYj7kqAdU08aPgNXGPgy8u4pQePh6Or2+kYsdz23/foCEYiO8UN5XDEPQsMqPzflIy
 tqtAYykYZu3Bp0YRXS3tT/azxDN7XdHUYGALLezpuOKGgy8tejyajiFw7s6db0J0wM19
 EDn2LFzEvouS0Q1JCeIzucZK6/LwN5GpmPyLx+x189pRmqOkKAErQLODrXWg5eqE2isr
 XsEcwScrfYd/qVv2DV2gTboPuHOfaorvvDtg8mmGMK7MUPSCIqy6gBWudca/6KHuVuP9
 8KNXRbxwtmMnF9h1eYRi0HMORAWQ7kB2N3itIc/jT61e/wOFIrL0rdKlGCw2Ir353uBq
 RalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760491114; x=1761095914;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IFyj84vqLfEkqmu15PAQnw/KCJJmqiY1n5DwOEyPEdY=;
 b=tBtn5iC8qwUgWqCi7GVPARCzeI2gqyidU9CDv0uJXVr2N48qR+rjYJyAy/x/byyAox
 XWmmMX/Z4+MdsruRhVis5dFUcfJjlLkKqKkXT/QElTant+HGNGrDWYIjlT2uigaTMAyg
 Kh65nLveJTcUe/+C9s3A2Hjh5fwoDs6m5B3ZNQqkK57igCOaMJo3BNpXZrzLOZK1tWoG
 GxHmnZpHWJuahqWKdSPdpzqxK8mYh3fPKvSEHGIrO0bOurgLAH999/oci9WV/gOTHrJw
 6QIdfqVeqWF6CNwGYh7QAKVoGoeic1pkTVqOP46crNAiZ5xpQmrtrznAb5hqwTMsbMXl
 NO7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVOy+ETkPnbw0YE/QuGIWzIOFCMhMfcjmSVXtKU09ASVjL/RD89dh2FG3zEEEXCHqVz2X7tBIJ8bQB@nongnu.org
X-Gm-Message-State: AOJu0Yy0TjOclrzg16nFfCahtB9JdEpKCbYr2WIb90JILSKuOah2oUR3
 LSVwNiIXwENZgjsOu2K3w/cU45EvVl8Y+qAmhDjhgmg7p/H2xBaSr6Yd5dVN5GFGw4suRItn0mX
 YfBoZarb7sYP+BYVQYQ==
X-Google-Smtp-Source: AGHT+IF/XYGxCaSdziu1qYabE0jlJH50FoKyvjLsq/rKeIy0kFVOZuvQqQHadU4L2S6MPKR8kr3AFeLInIxXCM4=
X-Received: from pgee20.prod.google.com ([2002:a63:1e14:0:b0:b55:c92:92c1])
 (user=lixiaoyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:938c:b0:2ba:64c0:4d83 with SMTP id
 adf61e73a8af0-32da850c71bmr33144420637.57.1760491113719; 
 Tue, 14 Oct 2025 18:18:33 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:18:24 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251015011830.1688468-1-lixiaoyan@google.com>
Subject: [PATCH v2 0/5] Add Aspeed GPIO test and Support Nuvoton Serial GPIO
 Expansion (SGPIO) device
From: Coco Li <lixiaoyan@google.com>
To: peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, lixiaoyan@google.com, 
 flwu@google.com, andrew@codeconstruct.com.au, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3afbuaAkKCmAJGVG8MW8LEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--lixiaoyan.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -88
X-Spam_score: -8.9
X-Spam_bar: --------
X-Spam_report: (-8.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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

GPIO series:
Added 32 bits property for ASPEED GPIO with updated qtests.

SGPIO series:
Implemented SGPIO device according for npcm8xx.
Two notable implementations left undone in these patches are:

1. Reading the data from the host controlled SIOX via register IOXDATR
2. On-demand with polling reading node

The reason for this ommitance is that both features are currently unused/umimplemented by the nuvoton driver.

The changes to qobject is used in both sets of patches. The patch series implements indexing gpios with array indices on top of accessing with registers.
The reasons for this is becasue it creates another easier way to access gpio. In our internal tests, we model complex behaviors with a large number of gpios, such as in fault injection, or in networking behaviors.
Indexing multiple gpios at once allows qmp/side band client to no longer hardcode and populate register names and manipulate them faster.

Updates since V0: added more descriptions on qobjects change in cover letter.
Updates since V1:
  - added more description to "hw/gpio: Add property for ASPEED GPIO in 32 bits basis" patch
  - used bitops.h for bit operations in "hw/gpio/npcm8xx: Implement npcm sgpio device input pin"

Coco Li (3):
  hw/arm/npcm8xx.c: Add all IRQ ENUMs
  hw/gpio/npcm8xx: Implement SIOX (SPGIO) device for NPCM without input
    pin logic
  hw/gpio/npcm8xx: Implement npcm sgpio device input pin logic

Felix Wu (2):
  hw/gpio: Add property for ASPEED GPIO in 32 bits basis
  tests/qtest: Add qtest for for ASPEED GPIO gpio-set property

 hw/arm/npcm8xx.c                 |  66 +++-
 hw/gpio/aspeed_gpio.c            |  57 ++++
 hw/gpio/meson.build              |   1 +
 hw/gpio/npcm8xx_sgpio.c          | 518 +++++++++++++++++++++++++++++++
 hw/gpio/trace-events             |   4 +
 include/hw/arm/npcm8xx.h         |   2 +
 include/hw/gpio/npcm8xx_sgpio.h  |  45 +++
 include/qobject/qdict.h          |   1 +
 qobject/qdict.c                  |  13 +
 tests/qtest/aspeed_gpio-test.c   | 105 ++++++-
 tests/qtest/meson.build          |   3 +-
 tests/qtest/npcm8xx_sgpio-test.c | 222 +++++++++++++
 12 files changed, 1024 insertions(+), 13 deletions(-)
 create mode 100644 hw/gpio/npcm8xx_sgpio.c
 create mode 100644 include/hw/gpio/npcm8xx_sgpio.h
 create mode 100644 tests/qtest/npcm8xx_sgpio-test.c

-- 
2.51.0.788.g6d19910ace-goog


