Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D454C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEb2-0005gA-RH; Tue, 08 Jul 2025 16:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDQw-000884-15
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:52:59 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZCSA-0005T8-M4
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 13:51:00 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-607cf70b00aso9104106a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751996860; x=1752601660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0z6zuLyqS0wcOglQ1OI6Oqu0dEI4wR6AUI75p1DD0Uo=;
 b=xRcOaA2cwmWqUDbw68S/ThQ5BlvFnJ/j6GepmXHsbqGldoUKvW5tpHSURvWiue9JUm
 gyuXLP3bihlkhRuqU+2AkhnGfxUIRcZVheUTp7NfXx+3zEhV+RY1CWgwsn+mVhc+G5mt
 xL3inovnM5yCO9w0CckwP+JBr3/6Dqbu9Zb1bkS3esOB41zJbXMVkeg/cK87jjwh7kYx
 64YhQeOZXeGbSczlTWXZGQWHOvjW6FPpjZWREcJQnTmnHKoQku+5zaoVuDZvr/27MccO
 fx+AwLGkOFm9Kr6WPwH7b0qxM6G00FsNne+yDy5wHlyja3k18CDr0dzA+OUV8SOwc8f0
 btCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751996860; x=1752601660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0z6zuLyqS0wcOglQ1OI6Oqu0dEI4wR6AUI75p1DD0Uo=;
 b=L1trL2NlAKcbFk7THd4Wn9uYuZK4yenbVRxUzxfgAdb54T7UVDHJ4kpeb2ZEC+BzE8
 K/VoykPa4AlMl85qxGc3J50zYODp/U0XRO9itiJotzLnjFoSJsn1dLiWqq8+48AaqWP7
 KCAg6OULL4kb8SX4Qb8BldkHUF0E1MulisJWh9xI2mDgqqLvipahUTh9RgjGA1bD/Pvq
 6/i7cNtaq89GFRUGdJcYum/C91oa31jv5yL+Fty/7ESDimlENbSnYYPFxlKd215RKjgR
 mYNfd1+5EcqrbVfmlqoQdurFvowhraQOX585rFAqWizy5tLpStICRE9nVIxzBVfgwa30
 ociA==
X-Gm-Message-State: AOJu0YxST+HHrr5G5ydqg0fX/QdGHrW4Jfhtx6SH4LjKOoN5xEE4TA08
 gpGqpHvc+BRjL4Z2dPODIWILYzJdXIr9VyeOGKR8vG+2j5Mmz4ou36JiWOEFKG8+LUJ3QCMkKhf
 wP1pl
X-Gm-Gg: ASbGnctOnSbj1mJ2nyzd68WojN5ByQsmJm5D3NHzNNNTxzla6dABzNTcE1Qbsuhh0IO
 m4y+XzhwrHn9E4pzCoUi9FwTSXPLFPF0iW47Bm7H/2eBZctNlRhPyD3LPbnzKTu4G93aWY8J507
 AOAe95qmOn1YPYSxytR8ya+2SGeMDv6kyKDac/HWI7V8yIbtfIVTjxVPBSs7xf4OurTx2ufU8Rm
 /zPvlOGkJC8njwMOH6NX6kxzVFjJKcncLH1Do7N/fBz0HlBQH5M4ArZBWNp+c4+Qsa3SlaKMO+Z
 DpFIXJ4ahbZajs5cDxBZJFf/kuiLeYPUYszSHDhuYCLJ0QBtpDKrncSg/0BMBI5Cja+nZhpjTnV
 fd2BSaKlhUh2C3zI3mODlScRGB6HfeXiXkZhD
X-Google-Smtp-Source: AGHT+IEkM94DyDOhgiUDQ9k45sEVeJR3CEVz04SErlMrGPWV3l1ZeWIqAHV0z7YC5n5AAcZlrdCrwA==
X-Received: by 2002:a05:600c:3acf:b0:451:edc8:7806 with SMTP id
 5b1f17b1804b1-454d367a0d1mr4240105e9.32.1751995210633; 
 Tue, 08 Jul 2025 10:20:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd49841dsm21584835e9.0.2025.07.08.10.19.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 10:20:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v7 0/8] target-info: Add more API for VirtIO cleanups
Date: Tue,  8 Jul 2025 19:19:40 +0200
Message-ID: <20250708171949.62500-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

Since v6:
- Added R-b tags
- Fixed typos
- Dropped "Introduce target_base_arch()" because unused so far
- Dropped unrelated patches

Philippe Mathieu-Daudé (8):
  target/qmp: Use target_cpu_type()
  qemu/target-info: Factor target_arch() out
  qemu/target-info: Add %target_arch field to TargetInfo
  qemu/target-info: Add target_endian_mode()
  qemu: Convert target_words_bigendian() to TargetInfo API
  gdbstub/helpers: Replace TARGET_BIG_ENDIAN -> target_big_endian()
  qemu: Declare all load/store helper in 'qemu/bswap.h'
  hw/virtio: Build various files once

 include/exec/tswap.h                  | 83 +--------------------------
 include/gdbstub/helpers.h             | 15 ++---
 include/qemu/bswap.h                  | 73 +++++++++++++++++++++++
 include/qemu/target-info-impl.h       |  6 +-
 include/qemu/target-info-qapi.h       | 29 ++++++++++
 include/qemu/target-info.h            | 10 +++-
 include/system/memory.h               |  1 -
 include/user/abitypes.h               |  1 -
 target/ppc/mmu-hash64.h               |  2 -
 cpu-target.c                          |  7 ---
 hw/acpi/bios-linker-loader.c          |  2 -
 hw/arm/allwinner-r40.c                |  1 -
 hw/arm/boot.c                         |  2 +
 hw/arm/npcm7xx.c                      |  2 +-
 hw/block/hd-geometry.c                |  1 -
 hw/char/riscv_htif.c                  |  1 -
 hw/core/cpu-system.c                  |  2 +-
 hw/core/machine-qmp-cmds.c            |  8 +--
 hw/cxl/cxl-events.c                   |  2 -
 hw/display/artist.c                   |  1 +
 hw/display/ati.c                      |  1 +
 hw/display/vga.c                      |  2 +-
 hw/net/can/ctucan_core.c              |  1 -
 hw/net/lan9118.c                      |  1 +
 hw/net/rtl8139.c                      |  1 +
 hw/net/vmxnet3.c                      |  1 -
 hw/pci-host/gt64120.c                 |  1 +
 hw/pci-host/pnv_phb3.c                |  1 +
 hw/pci-host/pnv_phb4.c                |  1 +
 hw/pci-host/ppce500.c                 |  1 -
 hw/pci-host/sh_pci.c                  |  1 -
 hw/s390x/s390-pci-inst.c              |  1 +
 hw/sensor/lsm303dlhc_mag.c            |  1 -
 hw/smbios/smbios.c                    |  1 +
 hw/vfio/migration-multifd.c           |  1 -
 hw/virtio/virtio-config-io.c          |  1 -
 hw/virtio/virtio-pci.c                |  1 +
 hw/virtio/virtio.c                    |  2 +-
 hw/vmapple/virtio-blk.c               |  1 -
 system/memory.c                       |  1 +
 system/qtest.c                        |  1 +
 target-info-stub.c                    |  2 +
 target-info.c                         | 23 ++++++++
 target/arm/arm-qmp-cmds.c             |  3 +-
 target/arm/cpu.c                      |  1 -
 target/i386/tcg/system/excp_helper.c  |  1 -
 target/i386/xsave_helper.c            |  1 -
 target/loongarch/loongarch-qmp-cmds.c |  3 +-
 target/mips/system/mips-qmp-cmds.c    |  3 +-
 target/riscv/vector_helper.c          |  1 -
 tests/tcg/plugins/mem.c               |  1 +
 hw/block/meson.build                  |  6 +-
 hw/virtio/meson.build                 | 20 ++++---
 53 files changed, 191 insertions(+), 146 deletions(-)
 create mode 100644 include/qemu/target-info-qapi.h

-- 
2.49.0


