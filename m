Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5308FCD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU1X-0005ik-Av; Wed, 10 Apr 2024 05:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1E-0005i6-IC
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:25 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1A-0005XD-U9
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:23 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56829f41f81so9348152a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740399; x=1713345199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5g1tlN+RLkW9KIYa4Sj6nxJyHTRoLa4e42ucRyDlwmg=;
 b=JunfoSG2j0Iz+K7W8FxIZLDXUOHBJxD1yTcCc3qbb0roi+HQUlxelp6NkyOzjKLRSg
 B5hoSNX4BOxDC83Lq2S2n/3yAe9wjN9dk5ZflCls1ylvmFSgFcTM6CcrFXBJrY0+dwcC
 5Ih2pylbslPG86wEsIvgWfkYfFEX9kyOHmglVDVCSt0vJSC0g0q7kNRxyWOHmZqsMaQE
 IJ6RyxCcSxstPN+kHl5AvQugcnuofhVMY2y2OxJA+ltCbBtLeyy6lA5Hkokd0GeGwrv/
 0qxzuBCNpr/F4tNIxPFMxg1cUHgvcvYQdIb/apEzYzJ0/Fer27A5fKa0BTn/W59b7+vn
 tNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740399; x=1713345199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5g1tlN+RLkW9KIYa4Sj6nxJyHTRoLa4e42ucRyDlwmg=;
 b=aRpHtZEl3iSfYR7+c3KcVMWVaDqnC0kXO4Qk7c03kGqHVWzsKmZiyQVo8AcSzyLatu
 lWIyZwf8G3kN2TWLoFjfH0urBj918Y6Ma3TCF+iUvCxrPuRAqD+keWmFBSSggc8VpuI1
 Q+SLlodnb6C3deYxq9qWY03X5TLveorgNQLv353ymPpjabGHn8lTbVqjGwQAxVtILkB/
 +vFi+UDkMFUg8Ef6glY7+Sn0rWhWd/vI2a+byQqAzAz0C8a12PrgGo6loDylcPKl39yy
 VII1JPeYprAGoKCdnKOq+p9xFDri6a2J2WsIGZ2X4IVSBHfVQNunOAzesMY2fVbQIHzH
 Hvog==
X-Gm-Message-State: AOJu0YwxNNDAUNFJbYI3Ki68k0kMfnp+QK1dWEh01ghdexzgXX5ZqfoT
 ZhxImwcLIb5/Jn1yRJrtj9Xl3XK7RTRcUi5m1H7M54ai8/2wdxLChDv42pHHbrTAV3EeuzPWVzC
 r
X-Google-Smtp-Source: AGHT+IHZzMoabJ+ToxS5osiTArV5/um+t400oBLo87T0LE6q49NaYqIXuKVmy7IUG6v8/rXNzx+4yQ==
X-Received: by 2002:a50:8a9b:0:b0:56b:ed02:305e with SMTP id
 j27-20020a508a9b000000b0056bed02305emr1037599edj.12.1712740398670; 
 Wed, 10 Apr 2024 02:13:18 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 eo9-20020a056402530900b0056c1380a972sm6165329edb.74.2024.04.10.02.13.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:13:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/16] Misc HW patches for 2024-04-10
Date: Wed, 10 Apr 2024 11:12:59 +0200
Message-ID: <20240410091315.57241-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

The following changes since commit 927284d65bce63ab1495d3febe7c7b5b6d563874:

  Merge tag 'edk2-20240409-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-04-09 17:36:40 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240410

for you to fetch changes up to dcb0a1ac03d6b5ba6c7fcbe467f0215738006113:

  hw/audio/virtio-snd: Remove unused assignment (2024-04-10 11:07:37 +0200)

----------------------------------------------------------------
Misc HW patch queue

- Fix CXL Fixed Memory Window interleave-granularity typo
- Fix for DMA re-entrancy abuse with VirtIO devices (CVE-2024-3446)
- Fix out-of-bound access in NAND block buffer
- Fix memory leak in AppleSMC reset() handler
- Avoid VirtIO crypto backends abort o invalid session ID
- Fix overflow in LAN9118 MIL TX FIFO
- Fix overflow when abusing SDHCI TRNMOD register (CVE-2024-3447)
- Fix overrun in short fragmented packet SCTP checksum (CVE-2024-3567)
- Remove unused assignment in virtio-snd model (Coverity 1542933 & 1542934)

----------------------------------------------------------------

Philippe Mathieu-Daudé (15):
  hw/virtio: Introduce virtio_bh_new_guarded() helper
  hw/display/virtio-gpu: Protect from DMA re-entrancy bugs
  hw/char/virtio-serial-bus: Protect from DMA re-entrancy bugs
  hw/virtio/virtio-crypto: Protect from DMA re-entrancy bugs
  hw/block/nand: Factor nand_load_iolen() method out
  hw/block/nand: Have blk_load() take unsigned offset and return boolean
  hw/block/nand: Fix out-of-bound access in NAND block buffer
  hw/misc/applesmc: Do not call DeviceReset from DeviceRealize
  hw/misc/applesmc: Fix memory leak in reset() handler
  backends/cryptodev: Do not abort for invalid session ID
  hw/net/lan9118: Replace magic '2048' value by MIL_TXFIFO_SIZE
    definition
  hw/net/lan9118: Fix overflow in MIL TX FIFO
  hw/sd/sdhci: Do not update TRNMOD when Command Inhibit (DAT) is set
  hw/net/net_tx_pkt: Fix overrun in update_sctp_checksum()
  hw/audio/virtio-snd: Remove unused assignment

Yuquan Wang (1):
  qemu-options: Fix CXL Fixed Memory Window interleave-granularity typo

 include/hw/virtio/virtio.h   |  7 +++++
 backends/cryptodev-builtin.c |  4 ++-
 hw/audio/virtio-snd.c        |  8 ++++--
 hw/block/nand.c              | 55 +++++++++++++++++++++++++-----------
 hw/char/virtio-serial-bus.c  |  3 +-
 hw/display/virtio-gpu.c      |  6 ++--
 hw/misc/applesmc.c           |  2 +-
 hw/net/lan9118.c             | 28 +++++++++++++++---
 hw/net/net_tx_pkt.c          |  4 +++
 hw/sd/sdhci.c                |  8 ++++++
 hw/virtio/virtio-crypto.c    |  4 +--
 hw/virtio/virtio.c           | 10 +++++++
 qemu-options.hx              |  6 ++--
 13 files changed, 109 insertions(+), 36 deletions(-)

-- 
2.41.0


