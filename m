Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE53C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 20:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfPF2-0000vp-06; Tue, 04 Feb 2025 15:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfPEr-0000v3-1Q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:09:42 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfPEp-0006Ny-7Y
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:09:40 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38da940e689so590231f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 12:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738699776; x=1739304576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EqVhAosz/A6QAaD3TmSgOO9xc/masNVVDg/+AovaPWA=;
 b=AWq7hsTczEOEwbviHPgE4ZgnMxvsr8lY2+H1tgWlK6YvBrcNwJcsie23ADNfjDBhyu
 4LwajMCQV3HFTMTcX+LCh1ebf49bNy+ifEeMy9+E8TMACWcKQA8Ma3jjnEHrJlPNbjzM
 /POlzWhJRieSh1nFZP1GxlawT3FRlSgF6e+/NhJ3JGQAOhHw6XzchEzqZ8cpzrGnF04j
 odMbC7hWzzD4owM92hHmi3GTXA2bJrr8SdYSbh42G71wQd1SvR6aIFeXYTFUBwxi9R7T
 UapFWggasAlOjR57vCvSFMHygXC6/se0R7O3n17RC0FppPXBGnDPxYihniJEKVUtIwxl
 FSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738699776; x=1739304576;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EqVhAosz/A6QAaD3TmSgOO9xc/masNVVDg/+AovaPWA=;
 b=XOLfFP22p+5kXOU3Gy4LZbmkjd1+3ITGr5FQpoXwWTh5lD7uRxxn+amk6D543D7Cqa
 Wo+ZTd2Jx1JAYcntWfIJCGSP7ffPjpl3oeKspqHaQ9RXGJWGVfFxqTekCO1yY+MEQeCQ
 SB/UYVg+umyh+Bp7PZDM89sEjZIgWXs6dABvecOK7PTw3XVf6QWyaYERJeUOWloIc3NT
 JmV2G9ZKZFB/LsJj97nIMn9eGpG9hzHUPTwyHjnEXbsvzK6ylRxKEfGYhU02ZjAKAWrS
 9ycCHat2bBwL8wNaw74+jl7NDKMclqvzyca78/mmdISeaQDqpseedN7jW0f9MYhihbD8
 E7Ww==
X-Gm-Message-State: AOJu0Yy+VfmjlHBztwN1iv4+NqQvZZTzR/B91SjRylVeqRJM/W8jNumc
 /gSweFUAQVUMxOfFkf8iAT/1cbN6iimT3Ypy9es9cEAeMJagVLq3C+6v8IkVaPHdpvwsY2S0DbH
 wHj0=
X-Gm-Gg: ASbGncstnBcXNSp9bcnx5EQjICLgeaX7IqLVVhye50XqK7lcXQFC1X1BkeQ8yF+mwSq
 GprmfmE84jkuknDCMPBXQ0h/76KVH1nLh+ytqHlnbQnSO4s6eBcrgGzC5KHUKAohslfuJ3CbLr3
 Z007cW1ATEC55XV1RzJO9nMuii09hsY1vyvIC6KR3mpuql5nstGq4r2k6lms2v9ME/nzMduHYwt
 rsKSJiVJd7BbRop/LhsNK1Eyv5T/iOPFfot2VzerjkQjkNEzgCRATbhinNiG4xu3Kizngo4dFZd
 +GJYIFqMIEhCOzzfX4WlC24DR9jy3gE5GJuDqVZYCjYZT7OxH3Yx/5ObH/tT9ouHjA==
X-Google-Smtp-Source: AGHT+IEPxxO1SDrtRRc9QBWMq7S9GOvtsJuViadAEvKhjjjr9pgsdv1Y0PiMTuz8yf9FJCvIhDjjLw==
X-Received: by 2002:a05:6000:1a8a:b0:385:e8aa:2a4e with SMTP id
 ffacd0b85a97d-38db48bfb90mr123522f8f.31.1738699776239; 
 Tue, 04 Feb 2025 12:09:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc26d6fsm233518245e9.14.2025.02.04.12.09.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Feb 2025 12:09:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 0/7] hw/boards: Try to make sense of
 MachineClass::no_sdcard flag
Date: Tue,  4 Feb 2025 21:09:27 +0100
Message-ID: <20250204200934.65279-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Invert MachineClass 'no_sdcard' flag logic and rename it
to 'create_default_sdcard_drive' to make sense of this
default value applied to all machines.
We use the OnOffAuto tri-state to catch implicit default
values. Then we toggle the logic and remove invalid uses.
No logical change intended (except the assertion added).

The list of machines using this feature is:

  $ git grep -l 'auto_create_sdcard = true'
  hw/arm/aspeed.c
  hw/arm/bananapi_m2u.c
  hw/arm/cubieboard.c
  hw/arm/exynos4_boards.c
  hw/arm/fby35.c
  hw/arm/imx25_pdk.c
  hw/arm/integratorcp.c
  hw/arm/mcimx6ul-evk.c
  hw/arm/mcimx7d-sabre.c
  hw/arm/npcm7xx_boards.c
  hw/arm/omap_sx1.c
  hw/arm/orangepi.c
  hw/arm/raspi.c
  hw/arm/raspi4b.c
  hw/arm/realview.c
  hw/arm/sabrelite.c
  hw/arm/stellaris.c
  hw/arm/versatilepb.c
  hw/arm/vexpress.c
  hw/arm/xlnx-versal-virt.c
  hw/arm/xlnx-zcu102.c
  hw/riscv/microchip_pfsoc.c
  hw/riscv/sifive_u.c

Since v3:
- Do not remove machines with multiple sd-bus
Since v2:
- Fixed mis-rebase catched by Thomas

Philippe Mathieu-Daudé (7):
  hw/boards: Convert no_sdcard flag to OnOffAuto tri-state
  hw/boards: Explicit no_sdcard=false as ON_OFF_AUTO_OFF
  hw/boards: Rename no_sdcard -> auto_create_sdcard
  hw/boards: Remove all invalid uses of auto_create_sdcard=true
  hw/arm: Remove all invalid uses of auto_create_sdcard=true
  hw/riscv: Remove all invalid uses of auto_create_sdcard=true
  hw/boards: Ensure machine setting auto_create_sdcard expose a SD Bus

 include/hw/boards.h        |  2 +-
 hw/arm/aspeed.c            | 20 ++++++++++++++++++++
 hw/arm/bananapi_m2u.c      |  1 +
 hw/arm/cubieboard.c        |  1 +
 hw/arm/exynos4_boards.c    |  2 ++
 hw/arm/fby35.c             |  1 +
 hw/arm/imx25_pdk.c         |  1 +
 hw/arm/integratorcp.c      |  1 +
 hw/arm/mcimx6ul-evk.c      |  1 +
 hw/arm/mcimx7d-sabre.c     |  1 +
 hw/arm/npcm7xx_boards.c    |  5 +++++
 hw/arm/omap_sx1.c          |  2 ++
 hw/arm/orangepi.c          |  1 +
 hw/arm/raspi.c             |  5 +++++
 hw/arm/raspi4b.c           |  1 +
 hw/arm/realview.c          |  4 ++++
 hw/arm/sabrelite.c         |  1 +
 hw/arm/stellaris.c         |  1 +
 hw/arm/versatilepb.c       |  2 ++
 hw/arm/vexpress.c          |  2 ++
 hw/arm/xilinx_zynq.c       |  1 -
 hw/arm/xlnx-versal-virt.c  |  1 +
 hw/arm/xlnx-zcu102.c       |  1 +
 hw/core/null-machine.c     |  1 -
 hw/riscv/microchip_pfsoc.c |  1 +
 hw/riscv/sifive_u.c        |  1 +
 hw/s390x/s390-virtio-ccw.c |  1 -
 system/vl.c                | 24 ++++++++++++++++++++----
 28 files changed, 78 insertions(+), 8 deletions(-)

-- 
2.47.1


