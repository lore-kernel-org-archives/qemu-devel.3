Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230C0CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrbP6-0008Mv-OC; Tue, 02 Apr 2024 06:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrbP4-0008L7-7A
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:30:06 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrbOy-0003db-JE
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:30:05 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-415523d9824so31376695e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712053793; x=1712658593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QETv8NgoTe3pWtKVlYF/6dzKUZrTdJIlYuMF8rbfbd8=;
 b=aEr1bemSNf4ms/poRf/CPv7L3EdzZQ2C5371oXt91lL9CZYDHOqdyge9sn1GE2OIcI
 xpo78ISbFCaYKxfjvjmJR8167X1e5cu0NhYRCu3JbDWjDdi5K6jVOTis/DGuCkOYuciq
 5gHjZQ2Rv896GM79TgYaaAh1WPn/8OViU0suqoLjfB5CvYfC7p1/D6XOM1Nsj7ga1tBS
 qliydzVEKVo+tsnvR+XUyOVWJ+DW+VGkEPAIpT2DnLRqqeopRVJlaGNIhxSFLVmSLXT7
 VEV6KJDWyNYg+pdQTk85ROsr+cVPTWATUH9dNDlq4QJs+smIiwXkNta9aNWeiTV34p/S
 znGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712053793; x=1712658593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QETv8NgoTe3pWtKVlYF/6dzKUZrTdJIlYuMF8rbfbd8=;
 b=EBoCUaSewW3IxqMdPFBonmby4k1o0TB1ikNdlJjtQTukDXx1VROcbxMvoPbwoTIbkC
 BbwwzcNOZodYwBBedTYq2sQ19JmLg4MEbe2Sn4Z/jy8XH3N/C8KCXEuGL6FDl6k8CTzH
 rZEU4ClWP7YMNH+HcOBdDRfEQC5oLNAFGUAMMHjvHRRN/o+rfUpqvx4w7AjYWzSFs5yf
 gC9ngC5KFUSLZ2iib/hFysmKcI28sOhleu2guQtjG+a3qOSPw/YIuIiwl6swoIchMBhT
 j2ewIgxDIgfBzXAc6HrhmB5ywmquyfScA9XewEtouER2ET8vQKj+lR/ESTkCZK9QT5Xe
 PibA==
X-Gm-Message-State: AOJu0Yw5tzG1uP+JGgY85x1U2M+RkjHWkaDRxr3FdpXVYgBCLSWZj9Xb
 VMCLrBbby8l1yYO9LxLycCXtb7oD431zmi6Kkb5LgTQd8kXqprD1BuEfeOnYNqRQBJXrJigY/YJ
 i
X-Google-Smtp-Source: AGHT+IGj2aoNONCAnhsq1fcywjPPHVJCign7240gxTjfpwOgf5egXHIeU1GWez9yKub6tYgAoevNtg==
X-Received: by 2002:a05:600c:4fd0:b0:414:b43b:5 with SMTP id
 o16-20020a05600c4fd000b00414b43b0005mr1084539wmq.26.1712053793525; 
 Tue, 02 Apr 2024 03:29:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c4fcf00b0041488895a37sm20586175wmq.33.2024.04.02.03.29.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 03:29:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] target-arm queue
Date: Tue,  2 Apr 2024 11:29:46 +0100
Message-Id: <20240402102951.3099078-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Nothing exciting here: two minor bug fixes, some fixes for
running on a 32-bit host, and a docs tweak.

thanks
-- PMM

The following changes since commit 6af9d12c88b9720f209912f6e4b01fefe5906d59:

  Merge tag 'migration-20240331-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-04-01 13:12:40 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240402

for you to fetch changes up to 393770d7a02135e7468018f52da610712f151ec0:

  raspi4b: Reduce RAM to 1Gb on 32-bit hosts (2024-04-02 10:13:48 +0100)

----------------------------------------------------------------
target-arm queue:
 * take HSTR traps of cp15 accesses to EL2, not EL1
 * docs: sbsa: update specs, add dt note
 * hw/intc/arm_gicv3: ICC_HPPIR* return SPURIOUS if int group is disabled
 * tests/qtest: Fix STM32L4x5 GPIO test on 32-bit
 * raspi4b: Reduce RAM to 1Gb on 32-bit hosts

----------------------------------------------------------------
Cédric Le Goater (2):
      tests/qtest: Fix STM32L4x5 GPIO test on 32-bit
      raspi4b: Reduce RAM to 1Gb on 32-bit hosts

Marcin Juszkiewicz (1):
      docs: sbsa: update specs, add dt note

Peter Maydell (2):
      target/arm: take HSTR traps of cp15 accesses to EL2, not EL1
      hw/intc/arm_gicv3: ICC_HPPIR* return SPURIOUS if int group is disabled

 docs/system/arm/sbsa.rst          | 35 +++++++++++++++++------
 hw/arm/raspi4b.c                  |  4 +++
 hw/intc/arm_gicv3_cpuif.c         |  4 +--
 target/arm/tcg/translate.c        |  2 +-
 tests/qtest/stm32l4x5_gpio-test.c | 59 +++++++++++++++++++++++----------------
 5 files changed, 68 insertions(+), 36 deletions(-)

