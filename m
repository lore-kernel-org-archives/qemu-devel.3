Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E87C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogy9-0005KO-1p; Tue, 28 Jul 2026 08:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogy7-0005JD-Ex
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogy3-0002y7-W8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:35 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so3215437f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241889; x=1785846689; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vKem7zNvFHFDnZ/o9upflTlL+uy0rmlaVIsMbs4v+Aw=;
 b=ThoyMFqtlotLDfoo2kdDcLrZp4V2rPt2NhGrC4hp1F1tg8BxoYhr4dyoknZtAXMuq5
 ofmqSQa9NuVudNE8ieP4+cJE8ZDcDwjQA1EpwFE3FzG9slLUl3o3XeWaOuzZZgZVhsSZ
 FvSRWU0CFcx9761vD6jpkC7XC+C4mgPOxyQ6clHMOYc+ffRQeMTVDd9ajSRgdQtfCCVB
 7oSrD114t5VM6IAOxni+OwaykYH8IAkegLr4/1vvz/9oicZQP/Qi82Zg2GasEcG/xgnx
 zyDo6RiZTdvqVNfDihQ8cKz00caruAXw5ZN2pmA0B3eHjRur8BDZbhwGY0zGHsV+LXjR
 ctkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241889; x=1785846689;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vKem7zNvFHFDnZ/o9upflTlL+uy0rmlaVIsMbs4v+Aw=;
 b=KNqIxsrHY54pxBG4Ntc7fQuf34EBvEX+wltjsgpLWGwk73ReZUb802Rc7HhaecQnny
 fLtl6V28bwNuZUHA1927rXBA6vjXhGWN2P0Ttd3vrD43VJHeShoymCec3iyTlX5QAxA8
 rymqqFz7j7l+XWBKIUpDBWqIup8r55P0OKhr355TwUV3fL8gkhQkQu6NPeQEG+XUiQav
 Eom26+fmo+84gb7cR+A+sy3stjYGO2XRXrc1qCekOPt0r9yYeR8F0wQXx6psJuLJznMl
 zkqSswGjXeDvGy1tV9nfBiL+L6Mo1EsyO/g47WgYzaKeSEgdUmXSdKNtcgXKifm5jFzL
 4nWw==
X-Gm-Message-State: AOJu0YyYoeojcQqL6LQiiELEsofxGj0oNBdyLLxWARuNlys0xt6cz5hD
 ypJvubhxH1epjOyVs7xdnSgMZNiwGOVY9kPOQRBFUuT1cakJP6C0TbAgGNJwHdGH3rhkOg2qRwd
 YRIm5
X-Gm-Gg: AR+sD13OZkE3n+fdMvF58OBtsefz89DnbHGss7elrcPknV8TMdRRYkqNXyIbyV2A6E8
 sProePpXmisa8+jHOWw8cRLdP+v2SwGe9qVNu6W8mZfb8z8EQ7OUbr9dTDnbpkBDM+S3NQZCTyW
 gBzK/8NroJVvOOV2gEbKWEa1kEkVsX7GWrGE/9DycQ3SHATrqBsoHusH7gY981pHFUcqoL6tnr9
 6hmQCm8NCFhEpUHlN0xfyjxsPm3lzd8j3GjqCXaijFJLMB1+D6wcHNVyTNQDaa2eJfhNiiZu1vx
 73c0zQ13SehxGvHEQCxHUino8hS+nI0yEDPXQeLqaGYebLKaHk6GpU0M1iiz2JALyXTMm2jwo9q
 3dLJtLhEwvH6+V0a6NIiw8JGyKXKLOk5dZajwghqlDN292j7eeYcjK12XODD4fMRQzReTi7RlC6
 XjYDcmNQ72i4pVi+DfHOPxyH9j+dLM1DwNoFj8Zb3kJRaoRtxAwl05Fi+kRK0/f++bioXR945v+
 hH0GP+vvcE=
X-Received: by 2002:a05:6000:4383:b0:47f:8aba:8a9a with SMTP id
 ffacd0b85a97d-47fb1e6cc86mr2733154f8f.18.1785241889026; 
 Tue, 28 Jul 2026 05:31:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] target-arm queue
Date: Tue, 28 Jul 2026 13:31:07 +0100
Message-ID: <20260728123127.1711653-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Hi; here's an arm pullreq: these are all bugfixes suitable
for the next 11.1 RC.

thanks
-- PMM

The following changes since commit 299e7557ed15a9a325620698add379a3ce2d1d95:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-07-27 16:51:28 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260728

for you to fetch changes up to a5f8d33682be079e6b9b41f07b2eb517121b3b46:

  hw/display/exynos4210_fimd: Clamp windows to screen size (2026-07-28 11:38:51 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Fix various compilation issues in --disable-tcg configs
 * hw/net/flexcan: Fix issues spotted by Coverity
 * docs/system/arm: Update Nuvoton OpenBMC image guidance
 * hw/misc/mps2-scc.c: Ffix cfg7 write
 * hw/misc/mps2-scc.c: fix scc_partno field width
 * hw/i2c/bcm2835_i2c: Correct CLKT register offset
 * hw/display/exynos4210_fimd: fix coordinates bounds handling to avoid
   guest being able to access outside the framebuffer backing memory

----------------------------------------------------------------
Bernhard Beschow (9):
      hw/net/can/flexcan: Use mbs[] array for FIFO pop
      hw/net/flexcan: Drop unused RX FIFO register overlay
      hw/net/can/flexcan: Fix out-of-bounds access in flexcan_mx_rx()
      hw/net/can/flexcan: Fix mailbox index calculation in flexcan_mem_write()
      hw/net/can/flexcan: Fix mailbox index calculation in flexcan_mem_read()
      hw/net/can/flexcan: Fix mailbox reset mask initialization
      hw/net/flexcan: Drop oversized 'mb[]' mailbox view
      hw/net/can/flexcan: Fix RXIMR reset mask
      hw/net/can/flexcan: Remove RX SMB raw view

Bin Meng (1):
      docs/system/arm: Update Nuvoton OpenBMC image guidance

Peter Maydell (3):
      hw/display/exynos4210_fimd: Factor out finding screen width/height
      hw/display/exynos4210_fimd: Pass width to draw_line functions
      hw/display/exynos4210_fimd: Clamp windows to screen size

Philippe Mathieu-Daudé (4):
      hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX
      target/arm: Add stub for define_gicv5_cpuif_regs()
      target/arm: Only compile gicv5-cpuif.c when GICv5 is selected
      target/arm: Build TCG stubs as stub library

Simon Xu (2):
      hw/misc/mps2-scc.c: fix cfg7 write
      hw/misc/mps2-scc.c: fix scc_partno field width

botszhuang (1):
      hw/i2c/bcm2835_i2c: Correct CLKT register offset

 docs/system/arm/nuvoton.rst  | 54 ++++++++++++++++++++++++++++++++++++++++----
 hw/display/exynos4210_fimd.c | 54 ++++++++++++++++++++++++++++++++------------
 hw/intc/meson.build          |  4 ++--
 hw/misc/mps2-scc.c           |  4 ++--
 hw/net/can/flexcan.c         | 47 ++++++++++++++++++++++----------------
 include/hw/i2c/bcm2835_i2c.h |  2 +-
 include/hw/net/flexcan.h     | 22 +++---------------
 target/arm/gicv5-stubs.c     | 17 ++++++++++++++
 target/arm/meson.build       |  6 ++---
 target/arm/tcg-stubs.c       |  4 ----
 target/arm/tcg/meson.build   |  3 +++
 11 files changed, 147 insertions(+), 70 deletions(-)
 create mode 100644 target/arm/gicv5-stubs.c

