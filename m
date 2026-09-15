Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28FCC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdD-0005NV-Jh; Tue, 15 Sep 2026 13:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdB-0005N2-Am
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:41 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6Wd9-0003T0-95
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:41 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485984ebf5cso2799291f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492057; x=1790096857; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rp5wv7hU75EHPVC0TCrmoBB8H5e3nDpaJHzzSbyhTPI=;
 b=kuCyBzhBs1WE1h5LWl/4jKHftaPrVnfa91ztDAA5VavJM58/aBCrZCO4L8Dnb3ntym
 DBK4mxvumXgrbYLJmhx2maCOSF3CUjkcBZu7esJWPvDWvBbRHSQ6MJo1la2nvJM7uHCH
 SKfG6xaGG+B6i0WSt/4aHMm8Wsdim+0LsCR5HPyWW4/JeqbHuFORSEdN+EzcnLFGXvQK
 LIirrU5LOlbN0QaJKbQP9sdE8LBxKKtru7/lmu5Td8L7iKTDYW3yN1tOnHVSL9PEA6fV
 JC2FFG9AISkzDeY6SCm5BXUJnXbGdwfcIOVLPhMzRH6PSaMK8+euzuO7HHlvEG/pQ3wN
 Hm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492057; x=1790096857;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rp5wv7hU75EHPVC0TCrmoBB8H5e3nDpaJHzzSbyhTPI=;
 b=xcIsJvpRlYILBrJX2k0kD79bq/5in8BOiiQ+Z2fi3A9sB+sMuIwqrUr7lXqHXkFZpm
 xK7qsXJT2M9QRMNiTTtoLmNXTaK+5HhGjUQX/jPGASYLnBx/xB03PGhbiE7Lnxv487oz
 Z5mNJr154yGZLEveQYnAHDtJ1Ig69OpjDPXOHv6qJxehLxS8tTFQ7oh+FlZHq2zJk/0+
 RPYLQe6xFuTq8ZVCxEx8H87nac5pzEZWDWiJCBmR/m2Fc6GQKy/vFodB+s+D2Ujo6jNg
 TQQsbwTbmO79DzPbTr2q3EhbXYTQvjmglyxxR5zThGi3KSzVrztMamLY7TavSRiyeAUY
 Bh0Q==
X-Gm-Message-State: AFuF++kLBOQpEz7QRkeyMqBAGWGK/sUR+qhQbY3geDwiHyrtzDBeV7nF
 zi/C4lKHHps1Pjlx0iVfsyAOQk2EZYa5FDi2xiFB2YE/h4cTYFygPshjpZ7yoToYAJDXey7kyOt
 CA+OFYU8=
X-Gm-Gg: AYBFou2BrB8qj55iChETSOytAbQTTeiDBA/bCivC4QoPMMhzdcOUV5YrkRL8u21UZ4E
 vBup95cxXCeDD6SO1vCg8OdM6w2HvtBOstRidGQo1duhKUmhCGQU4cU4YElvs6E6NMtdPW5K8Dk
 mS15ko4B5ofZwLBJeFKDZSh1OyeTjBd6qDJ5s0UlYlMDMP8xwikuqgv+16kpqoeaNV4VO0nWSRy
 pluIEhXwWxKdXWNlRbeR3Os+DgfNCgsGT0lIofDEIEu/mOibR/TLejiar0UD3oGzPRe94DQCUNk
 PPDOh1JRUytraRsQluzWEVL9OBXwNJfJlA3+8b9lnCtdwVrEGzhXdOc974aScgQQ3W/WpM+2zJH
 hIYHkGsjon0B1HHO+Xk7eIclSqZ2WI9Jmv+bxSHW8reznuUBUwrIwLfTxidwEGsLOcGjH8y1d4a
 WFQ9ulUudKEW5rc4+lufmE5M6Qsybs7/WbRUvoOZe/4lXH6aagVT6v707cNkbKrtz6R0IxKnwSs
 8+osa1DtnB8FD6LUihDHXYBnTOIs2R9u9G2xig3peWDN1e+eV/GgVRtuY2YtKxNIUA2JWKgbjWB
 YNxh
X-Received: by 2002:a05:6000:38b:b0:487:aa1:ea90 with SMTP id
 ffacd0b85a97d-4870aa1eaedmr2077018f8f.40.1789492057355; 
 Tue, 15 Sep 2026 10:07:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] target-arm queue
Date: Tue, 15 Sep 2026 18:07:15 +0100
Message-ID: <20260915170735.425445-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

Hi; here's an arm pullreq; pretty much all bugfixes this time.

thanks
-- PMM

The following changes since commit 5f664cd37aec17e8145aa117d8da68f507edc8f1:

  Merge tag 'ui-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-09-13 15:54:17 -1000)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260915

for you to fetch changes up to 157f6c69edd0627f5f78f1f14ea0d831b0948c69:

  target/arm: extend PMSAv7 support to v6-M CPUs (2026-09-15 14:27:23 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm/whpx: fix whpx-arm post-reset CPU state
 * target/arm/whpx: incorrect ENCODE_AA64_CP_REG parameter order
 * target/arm/whpx: Don't try to sync ARM_CP_CONST registers
 * hw/intc/bcm2835_ic: reject out-of-range FIQ source values
 * sbsa-gwdt: reschedule timer on direct WCV load
 * target/arm/hvf: implement MDCCSR_EL0 as RAZ
 * hw/char/stm32l4x5_usart: Accept character input upon RDR read
 * MAINTAINERS: Update email address for Vikram Garhwal
 * hw/misc/bcm2835_powermgt: free wdog timer on finalize
 * target/arm: initialize SCTLR reset value for arm11mpcore
 * target/arm: Fix various v6M corner-case bugs

----------------------------------------------------------------
Alex Bennée (1):
      hw/char/stm32l4x5_usart: Accept character input upon RDR read

Bin Guo (1):
      hw/intc/bcm2835_ic: reject out-of-range FIQ source values

Doug Cook (3):
      target/arm/whpx: Don't try to sync ARM_CP_CONST registers
      target/arm/whpx: incorrect ENCODE_AA64_CP_REG parameter order
      target/arm/whpx: fix whpx-arm post-reset CPU state

Gilles Grimaud (5):
      target/arm: enforce Armv6-M NVIC limits
      target/arm: MPU - limit regs RBAR/RASR A1-A3 to Main Extension
      target/arm: MPU_RASR: mask TEX bits for Armv6-M
      target/arm: fix MPU SIZE min for v6-M/v7-M/v7-R
      target/arm: extend PMSAv7 support to v6-M CPUs

Igor Mammedov (6):
      sbsa-gwdt: reduce code indent
      arm: gwdt: consolidate clear WS0 and WS1 on explicit refresh
      arm: gwdt: simplify WCV update condition
      sbsa-gwdt: rename sbsa_gwdt_update_timer() to sbsa_gwdt_wor_update_timer()
      sbsa-gwdt: don't arm timer for compare values above INT64_MAX
      sbsa-gwdt: reschedule timer on direct WCV load

Marc-André Lureau (1):
      hw/misc/bcm2835_powermgt: free wdog timer on finalize

Showta Ishizaki (1):
      target/arm/hvf: implement MDCCSR_EL0 as RAZ

Vikram Garhwal (1):
      MAINTAINERS: Update email address for Vikram Garhwal

vpyr (1):
      target/arm: initialize SCTLR reset value for arm11mpcore

 MAINTAINERS                             |   4 +-
 hw/char/stm32l4x5_usart.c               |   1 +
 hw/intc/armv7m_nvic.c                   |  42 +++++-
 hw/intc/bcm2835_ic.c                    |  13 +-
 hw/misc/bcm2835_powermgt.c              |   8 +
 hw/watchdog/sbsa_gwdt.c                 |  87 +++++++----
 target/arm/cpu.c                        |  12 +-
 target/arm/hvf/hvf.c                    |  10 ++
 target/arm/machine.c                    |   3 +-
 target/arm/ptw.c                        |  14 +-
 target/arm/tcg/cpu32.c                  |   1 +
 target/arm/whpx/whpx-all.c              | 254 ++++++++++++++++++--------------
 tests/qtest/bcm2835-ic-test.c           |  66 +++++++++
 tests/qtest/meson.build                 |   2 +-
 tests/tcg/arm/system/meson.build        |   6 +
 tests/tcg/arm/system/test-armv6m-nvic.S |  70 +++++++++
 16 files changed, 439 insertions(+), 154 deletions(-)
 create mode 100644 tests/qtest/bcm2835-ic-test.c
 create mode 100644 tests/tcg/arm/system/test-armv6m-nvic.S

