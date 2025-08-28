Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0244BC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIO-00075D-3g; Thu, 28 Aug 2025 13:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdEs-0003ne-I9
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:04:30 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdEq-0002sp-HQ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:04:30 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3c7ba0f6983so669983f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756389866; x=1756994666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xiVFollxZQsjCjMToco6G/qNjvqu856G5dlynEUOU+U=;
 b=IWSPn4l5M/asjtjt1ZRa5dXEp5do8YBfSYEixfPWujXSJ3LpJnPhIjYEQdBdcEqj2v
 ud+WY1MIFu0BX4PFk7GKhw79rHPPk/VgWGw62QIJXnk6hlvbYH7yTxwkHhFzOzL1/EiG
 umcbtS8EM/Ec/cyKyNSHDpDnZuboRUgB/p1Wra1Kb69hzZpSDenjddnUrF6rOl8u0CxG
 DA6NzcvqG5+JUSh8gfUOPyZBEK+3RAsC6GiGQun7lMMK29iEIDRtZX0KSIQmkPap0VrE
 sjzSZDbO83SQIxIleAq8QyK8vZBaR9l7GgcNs1tgn5cZQSCdTpfS/n0T+EPDwE9rallZ
 m+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756389866; x=1756994666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xiVFollxZQsjCjMToco6G/qNjvqu856G5dlynEUOU+U=;
 b=awwQZQyLOrQ+hrHcpVMdW98IE1SYFhSV/oFFowBIw2x6e15wSljCohAK9tDmG+TBnF
 3ofU7Dex4O9/J9LKNrJ9E2jUXyGx596u15oUilZiDOgThDPUS21rtNWm0XdMmVFhg/tj
 779JvCpi0y+Xmq610epcnbmdUXby9MuNZBmuRTubAtermbI1weDEr412nKS0QTqSivm0
 KHu4OTMrOd6KsnqFMWEgmwtB888/CEU05Y86+erGxiSist4uBfGceZdwK7OOwleT1XHx
 oISJflebUExkPWpVQ9hNop4cDs2OXdiDu/ZFSiRh0hx7MEirA1rsuL1arG5eEDdw43lQ
 FmeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsCvNvOOvjKP79X4L4A50ohgybX7tpvx2pSj6jqf0AL/mUgHy4AcATAbRFiBHMn69C03DXsOTsq8uG@nongnu.org
X-Gm-Message-State: AOJu0Yz7vPvDPdrGqtW1b3w99oRNzKyB65OPR9Z1mgl3h3QmAbJEiBEF
 D4POnSwR3YjEibdg7YK5BbjA/vo4Atz4W4csDIGArp60xJbQU/2ZFWEV9lBhXNBfBctfWIfcJmr
 raKqL
X-Gm-Gg: ASbGncsZZWhxCEjTe1B3IIpl6V/MGQeh6f3spiKdbUqlWk2la93U1p3Pz1TRneRdpWK
 SsU+EEetszWoZvN6Jnxw6pf3to+9jzWBNdhqShR+DQKUocDVnMqIJWBjeorq8M9jsCT6Ro0j1tm
 y6RHbGBLsqxI3PNelJci/nsu/MwpoTWtA/sOxIDIAFvcHwQ4Wf5ttMowO2NTC00qlTmK9wINgwR
 inHm37edN4hYwsc5E22zMwtpbXuOiF2dpIe9NnNdYY5dKHh1IxH3uwQU8lp2Gvkf1Gsn+iWcHeU
 4Ouol0dB7ZaoEi6VAkHqvT64lchcW0cFhBNf7llbcJzaoP+A/HHnlsj8FE8RLEhLjPmRBO3GrO6
 lRLQyzSjyOGaa7cV3/QxAnfG4Evfk+E8hJ5d9IAg=
X-Google-Smtp-Source: AGHT+IFAuZ0C8W9SFx4jySCnTtuGz/UubGW04BAXDycKs6v5amvzcGAP0AHC3KC2utSZI6S+naHbkw==
X-Received: by 2002:a05:6000:2485:b0:3b7:9703:d99f with SMTP id
 ffacd0b85a97d-3cbb15ca058mr8022648f8f.27.1756389865486; 
 Thu, 28 Aug 2025 07:04:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cce1724939sm6947712f8f.26.2025.08.28.07.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 07:04:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/5] target/arm: Remove deprecated pxa CPUs and xscale/iwmmxt
 code
Date: Thu, 28 Aug 2025 15:04:17 +0100
Message-ID: <20250828140422.3271703-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

This patchset removes the pxa* CPU family, which we deprecated for
the 10.0 release and can now drop in 10.2.  The diffstat should
illustrate the motivation for the deprecation: it lets us delete
thousands of lines of xscale/iwmmxt specific emulation code which we
don't think anybody was using, which was unmaintained and which we
had no test coverage for.

thanks
-- PMM

Peter Maydell (5):
  target/arm: Remove deprecated pxa CPU family
  target/arm: Remove XScale and iWMMXt translate.c code
  target/arm: Remove iwmmxt helper functions
  target/arm: Drop ARM_FEATURE_XSCALE handling
  target/arm: Drop ARM_FEATURE_IWMMXT handling

 docs/about/deprecated.rst       |   21 -
 docs/about/removed-features.rst |   14 +
 bsd-user/arm/target_arch_elf.h  |    1 -
 target/arm/cpu.h                |   29 -
 target/arm/tcg/helper.h         |   95 ---
 target/arm/tcg/translate.h      |    2 -
 linux-user/arm/elfload.c        |    1 -
 linux-user/arm/signal.c         |   67 --
 target/arm/cpu.c                |   21 -
 target/arm/helper.c             |   54 --
 target/arm/machine.c            |   21 -
 target/arm/ptw.c                |    7 +-
 target/arm/tcg/cpu32.c          |  163 ----
 target/arm/tcg/hflags.c         |   13 +-
 target/arm/tcg/iwmmxt_helper.c  |  672 ----------------
 target/arm/tcg/op_helper.c      |    6 -
 target/arm/tcg/translate.c      | 1324 +------------------------------
 target/arm/tcg/meson.build      |    2 -
 18 files changed, 24 insertions(+), 2489 deletions(-)
 delete mode 100644 target/arm/tcg/iwmmxt_helper.c

-- 
2.43.0


