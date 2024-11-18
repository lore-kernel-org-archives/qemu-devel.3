Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55788D49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD19f-0002x9-80; Mon, 18 Nov 2024 07:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD19V-0002wR-PX
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:46:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD19T-0005Mg-UN
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:46:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so34153285e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934006; x=1732538806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t8XntGoZGBcWplYr9OyDD99+dMsSp6kx21Oojvk/1sE=;
 b=A8W+2cFib2GCgVab626W1tQULXpek5JgHPSBBzf71myCFVz3w3goK+AgeR4Y+tGI+A
 cOr8XIi7kYtp2n5LdNxnEX++TVuHrZGEVdyUk9rMzfUCZL36Q6G+rhtjvf7zKmIuP2Mn
 tAPT3VVVPrJKInHBuosc+1tqn0h8SgDDHuxSYINzujhm2LKi07PlaH4l56RFKDOU3qi7
 bj/j5ExnaWInehJ9Lic9xJGDgvkCn5VePjd5pwR42/m2s1qXWFcDXu7vYm5T1FIBTbeU
 C2HQ+hQ38Lbk60yGVNIn5M/i11cZlOSQbQRH3rg+yOqwZVjalntncfFpsXjbAvBGrNyJ
 MH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934006; x=1732538806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t8XntGoZGBcWplYr9OyDD99+dMsSp6kx21Oojvk/1sE=;
 b=d00LpmIXQ80s6GeQakIceMVOvoX7BTrN4y4oTUdiFfTNJkcj8cVHUFHI1JvjZFIpz0
 YQvlhXt8aH0fsMyaZk9YqeVUn7vGTJFzWb9jk6ZU2P4oRbbF6mw6v1Dh79EA4gLhLMck
 c3up2gUMNbK9Wf7PUV1OKuV1cdk2+ZAEkrZmhl/kI8O2oaPDm5OhMKGbw7Ynj2iLCigq
 iyUbCcfNjsmsX6dwRE7ZSNN5KY8i8gLwkUJ9LeLop8txbh2Ryyyi7JJuxw+Bw+Bun8tW
 KUL6jPur8eLXTHRl/b22xILckuSV3vU77HDMYFXF+Vb2WXzTT0kfejGtqfSmgL/4i0AA
 94IQ==
X-Gm-Message-State: AOJu0Yy3hJjUi7Fe80lz7V/57sx+Qbp9sO+hX+IuiFZ0yCD3UVu2yU5q
 wBIIns0ezszykncLi9YBVkZ//AMxWTotgv42G54I7vg0Vd6tUKUQjoxfIurAMWgR1whiKzNEObC
 6
X-Google-Smtp-Source: AGHT+IFqL8Wxbl4hAsAGXfMXN4ichWndgJDiGMBADpffOjEDCdNmcHmxALThsc1AGhJ5YZfxN3pxqA==
X-Received: by 2002:a05:600c:3b20:b0:431:5a93:4e3c with SMTP id
 5b1f17b1804b1-432df74cdb3mr117426565e9.16.1731934005738; 
 Mon, 18 Nov 2024 04:46:45 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d4788c2asm134345825e9.0.2024.11.18.04.46.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:46:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/15] Misc HW patches for 2024-11-18
Date: Mon, 18 Nov 2024 13:46:27 +0100
Message-ID: <20241118124643.6958-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The following changes since commit abb1565d3d863cf210f18f70c4a42b0f39b8ccdb:

  Merge tag 'pull-tcg-20241116' of https://gitlab.com/rth7680/qemu into staging (2024-11-16 18:16:46 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20241118

for you to fetch changes up to b6db70bc0a9e53e7aa04cc940db1ddbee17fa700:

  hw/watchdog/cmsdk_apb_watchdog: Fix broken link (2024-11-18 13:45:45 +0100)

----------------------------------------------------------------
Misc HW fixes

----------------------------------------------------------------

Alex Bennée (2):
  hw/display: factor out the scanout blob to fb conversion
  hw/display: check frame buffer can hold blob

Fabiano Rosas (1):
  tests/qtest/migration: Fix indentations

Gerd Hoffmann (1):
  vl: fix qemu_validate_options() indention

Guenter Roeck (1):
  usb-hub: Fix handling port power control messages

Jamin Lin (1):
  hw/sd/sdhci: Fix coding style

Paolo Bonzini (2):
  Revert "hw/audio/hda: fix memory leak on audio setup"
  hw/audio/hda: fix memory leak on audio setup

Peter Maydell (3):
  hw/misc/nrf51_rng: Don't use BIT_MASK() when we mean BIT()
  hw/net/virtio-net.c: Don't assume IP length field is aligned
  net: mark struct ip_header as QEMU_PACKED

Roque Arcudia Hernandez (1):
  hw/watchdog/cmsdk_apb_watchdog: Fix broken link

Sergio Lopez (1):
  hw/i386/elfboot: allocate "header" in heap

Thomas Huth (1):
  hw/misc/mos6522: Fix bad class definition of the MOS6522 device

Zhang Chen (1):
  MAINTAINERS: Update my email address for COLO

 MAINTAINERS                      |  2 +-
 include/hw/misc/mos6522.h        |  2 +-
 include/hw/virtio/virtio-gpu.h   | 15 ++++++++
 include/hw/virtio/virtio-net.h   |  2 +-
 include/net/eth.h                |  2 +-
 hw/audio/hda-codec.c             | 41 +++++++++-----------
 hw/display/virtio-gpu-virgl.c    | 22 +----------
 hw/display/virtio-gpu.c          | 59 +++++++++++++++++------------
 hw/i386/x86-common.c             |  4 +-
 hw/misc/nrf51_rng.c              | 10 ++---
 hw/net/virtio-net.c              | 23 ++++++++++--
 hw/sd/sdhci.c                    | 64 +++++++++++++++++++++-----------
 hw/usb/dev-hub.c                 |  1 +
 hw/watchdog/cmsdk-apb-watchdog.c |  4 +-
 system/vl.c                      | 16 ++++----
 tests/qtest/migration-helpers.c  |  4 +-
 tests/qtest/migration-test.c     | 59 ++++++++++++++++-------------
 17 files changed, 188 insertions(+), 142 deletions(-)

-- 
2.45.2


