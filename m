Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF3BCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJGC-0004i0-5m; Tue, 21 Oct 2025 16:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJG8-0004fT-Jq
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:09 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJG5-00011n-OB
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:08 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso3237524f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079622; x=1761684422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SmgyS4eCFxBNR+aoRbMLUjN0W+K6Q4Qi4xNfHKtGesM=;
 b=Kprt2SUZAFL/8oMNSYpow8D6aVb8Cuvkb6+mM7UeY2Hg2Mw65pQhVS0MFXK0Sv698T
 EybGUzymPiUnjLgHOOH+T11RQySDKiaGcJbmiUh1cCym6KVvYBsD5DNuznlOFX7EP9+P
 lCkRKs4XzisYl9hT4Vo65X5+WfxbAkLevElaJYP5NAeVN4uC/DylwyJX9v8IfztyS/zh
 WfcpisYj0jW8l1qAotheG8ALATqEkhrML3aV5AFDctOQOVRCmDiqDBJYlh1HYlnNoSqt
 6jWclSY25KuBFzaFAPbz3lIfCTR2FqeimMl584/I6vdHSBRFxZhZrGzcmYCYs1xx/smx
 /idA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079622; x=1761684422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SmgyS4eCFxBNR+aoRbMLUjN0W+K6Q4Qi4xNfHKtGesM=;
 b=Ik3wWg9Rc1tAluCt4Yp+sS+3WAusQxcVEPMt6aCkSKHfOYH5UY6A33tCFKt4MwRrTr
 NBfgUdP55d0kQc8EiEGp07cvN6PE36Q2XugVrhWnm9e+giIU28DsYm8u1tjfqK9Zrnk8
 dYHHsS6BtUvFS/HSZ8wanVIxiyCCUxe8jI/MepPDhHVRVArIzA2LNyA8VV2qF3KL97RL
 QCtmB92TUgBfILJG8iOLK41rdt5KbMNj4ueiK01YPav2eFb0Ibci2y6lZBytx8AoJCSi
 9yAHDJTR3eN/xXMC+vMCRhrPhS3FIUJNfCQD4KkLr3jfy61MMoyMdxDTttAAUVxO/1wd
 BmyA==
X-Gm-Message-State: AOJu0YwRE/YRipV7uVITizxTbJUrXHjLqu823KiT79T0tPyyh3dHHQ3I
 TF8kkleR+wWxJu9Frua1qceqyMzOfql4enuTfkwLFA0QCuCzpxP6034TGZc7oCUfrYIwRdHc2RA
 nxzjq2ag=
X-Gm-Gg: ASbGncua+uac5FjelsbRuFh4hwO4Yh5w81xOBAA+AcMiPzfoxV4Q211M4W7ofvfs93U
 gKIu57TpvpJowTB/0LWq6IKzmEzuzmoOHVDczGBynvrrUuLUeY0dtLJvQKMd4t9OPCu6Ms8edSp
 mjpSa8/0jmSp61q898hTrTrON23PC2jWa5f7YGT/qlOWevW65KxtFIrXBL24an7EJRh/5Vfe6JH
 pckrNA7o09a387cWluy1AQCv4fLb/P9CjjnkFFJKKEAlWY/gTlBPXSi2QVWtIyQLnOirKbuRdhY
 0h79+5+iRIPW0aMI4rtc1jZQxZvWV3PfTzlwZ90mkY6p2mnaoGco0hbl8fgERugAPTbl+QFrst/
 arwMVyoKKOkxkTpEVp+PrnC4hYgTLD+tDBZtjnBbDIsiS7UnxyuikBHKjgodAzjy/nShcEtaeKB
 LVyeGVAOMbma50n5vgy2lsNj7Dlq/Vhj6jZoxVw3edDH3nPq7jz0Tiih6Lotrr
X-Google-Smtp-Source: AGHT+IHx4+eeSRA0ueqK1eroufLMYDsubASensdg4qj5qvdm1+kQFWvSqnskcPlFEmFPgHDx0VY4aQ==
X-Received: by 2002:a05:6000:2888:b0:427:2e8:fe53 with SMTP id
 ffacd0b85a97d-42704d7eac3mr10748664f8f.6.1761079621759; 
 Tue, 21 Oct 2025 13:47:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4369b5esm10319515e9.15.2025.10.21.13.47.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/45] Misc HW patches for 2025-10-21
Date: Tue, 21 Oct 2025 22:46:14 +0200
Message-ID: <20251021204700.56072-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

The following changes since commit 3c0b42c68f98fb276fa248012642be8cbf2cab70:

  Merge tag 'pull-request-2025-10-21' of https://gitlab.com/thuth/qemu into staging (2025-10-21 08:59:35 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20251021

for you to fetch changes up to 3365d7da6156d7db990490f6cae2dc89950ac920:

  docs: Update mentions of removed '-soundhw' command line option (2025-10-21 22:33:49 +0200)

----------------------------------------------------------------
Misc HW patches

- Replace compile-time checks by runtime ones to build virtio-mem.c once
- Cleanups in Raven PCI host bridge, audio and PC devices
- Allow machine dynamic registration of valid CPU types
- Introduce DEFINE_MACHINE_WITH_INTERFACE[_ARRAY]() macros
- Set DDR2 minimum write recovery time in EEPROM SPD
- Have PPCe500 machines abort gracefully when using invalid CPU
- Prevent buffer overflow in openrisc_sim_init()
- Pass PCI domain to Xen xc_physdev_map_pirq_msi()
- Fix register API leaks
- Simplify Xilinx CANFD model
- Unconditionally create System I/O on PReP machine
- Update documentation around '-soundhw' command line option

Various "WARNING: line over 80 characters" ignored.

----------------------------------------------------------------

BALATON Zoltan (6):
  hw/pci-host/raven: Simplify direct config access address decoding
  hw/pci-host/raven: Rename direct config access ops
  hw/pci-host/raven: Use correct parameter in direct access ops
  hw/boards: Extend DEFINE_MACHINE macro to cover more use cases
  hw/i2c/smbus_eeprom: Add minimum write recovery time for DDR2
  hw/ppc/prep: Always create prep-systemio

Bernhard Beschow (10):
  hw/timer/i8254: Add I/O trace events
  hw/audio/pcspk: Add I/O trace events
  hw/rtc/mc146818rtc: Convert CMOS_DPRINTF() into trace events
  hw/rtc/mc146818rtc: Use ARRAY_SIZE macro
  hw/rtc/mc146818rtc: Assert correct usage of
    mc146818rtc_set_cmos_data()
  hw/ide/ide-internal: Move dma_buf_commit() into ide "namespace"
  hw/i386/apic: Prefer APICCommonState over DeviceState
  hw/i386/apic: Ensure own APIC use in apic_msr_{read,write}
  hw/intc/apic: Pass APICCommonState to apic_register_{read,write}
  tests/qtest/ds1338-test: Reuse from_bcd()

Jan Kiszka (1):
  hw/openrisc/openrisc_sim: Avoid buffer overflow build error

Luc Michel (6):
  hw/core/register: remove the REGISTER device type
  hw/core/register: add the REGISTER_ARRAY type
  hw/core/register: remove the calls to `register_finalize_block'
  hw/core/register: remove the `register_finalize_block' function
  hw/net/can/xlnx-versal-canfd: refactor the banked registers logic
  hw/net/can/xlnx-versal-canfd: remove register API usage for banked
    regs

Marc-André Lureau (8):
  hw/audio: improve error reports
  hw/audio: rename model list function
  hw/audio: remove global pcspk
  hw/pcspk: use explicitly the required PIT types
  hw/pcspk: make 'pit' a class property
  hw/pcspk: check the "pit" is set
  hw/audio: replace AUD_log() usage
  docs: update -soundhw -> -device list

Philippe Mathieu-Daudé (10):
  hw/virtio/virtio-mem: Convert VIRTIO_MEM_USABLE_EXTENT to runtime
  hw/virtio/virtio-mem: Convert VIRTIO_MEM_HAS_LEGACY_GUESTS to runtime
  hw/virtio: Compile virtio-mem.c once
  hw/core: Filter machine list available for a particular target binary
  hw/core/machine: Allow dynamic registration of valid CPU types
  hw/core: Introduce MachineClass::get_default_cpu_type() helper
  hw/boards: Move DEFINE_MACHINE() definition closer to its doc string
  hw/boards: Introduce DEFINE_MACHINE_WITH_INTERFACE_ARRAY() macro
  qemu/target-info: Include missing 'qapi-types-common.h' header
  docs: Update mentions of removed '-soundhw' command line option

Roger Pau Monné (1):
  hw/xen: pass PCI domain to xc_physdev_map_pirq_msi()

Thomas Huth (2):
  hw/ppc/e500: Check for compatible CPU type instead of aborting
    ungracefully
  MAINTAINERS: Add missing machine name in the Alpha section

Vishal Chourasia (1):
  hw/ppc/spapr: Rename resize_hpt_err to errp

 MAINTAINERS                            |   1 +
 docs/qdev-device-use.txt               |  10 +-
 hw/ide/ide-internal.h                  |   2 +-
 include/hw/audio/soundhw.h             |   2 +-
 include/hw/boards.h                    |  60 +++-
 include/hw/i386/apic.h                 |  37 ++-
 include/hw/i386/apic_internal.h        |   7 +-
 include/hw/misc/xlnx-versal-crl.h      |   1 -
 include/hw/misc/xlnx-versal-xramc.h    |   1 -
 include/hw/misc/xlnx-zynqmp-apu-ctrl.h |   1 -
 include/hw/misc/xlnx-zynqmp-crf.h      |   1 -
 include/hw/net/xlnx-versal-canfd.h     |   8 -
 include/hw/nvram/xlnx-bbram.h          |   1 -
 include/hw/register.h                  |  25 +-
 include/hw/timer/i8254.h               |   4 +-
 include/qemu/target-info-impl.h        |   1 +
 target/i386/cpu.h                      |   5 +-
 target/i386/kvm/kvm_i386.h             |   2 +-
 target/i386/whpx/whpx-internal.h       |   4 +-
 hw/audio/ac97.c                        | 124 +++----
 hw/audio/adlib.c                       |  24 +-
 hw/audio/cs4231a.c                     |  44 +--
 hw/audio/es1370.c                      |  24 +-
 hw/audio/gus.c                         |  25 +-
 hw/audio/pcspk.c                       |  29 +-
 hw/audio/sb16.c                        | 115 ++++---
 hw/audio/soundhw.c                     |  21 +-
 hw/core/machine-qmp-cmds.c             |   4 +-
 hw/core/machine.c                      |  38 +++
 hw/core/register.c                     |  38 +--
 hw/i2c/smbus_eeprom.c                  |   1 +
 hw/i386/kvm/apic.c                     |   3 +-
 hw/i386/vapic.c                        |   2 +-
 hw/i386/x86-cpu.c                      |   2 +-
 hw/ide/ahci.c                          |   8 +-
 hw/ide/core.c                          |  10 +-
 hw/intc/apic.c                         | 126 +++----
 hw/intc/apic_common.c                  |  56 ++--
 hw/misc/xlnx-versal-crl.c              |  38 +--
 hw/misc/xlnx-versal-trng.c             |   1 -
 hw/misc/xlnx-versal-xramc.c            |  12 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c         |  12 +-
 hw/misc/xlnx-zynqmp-crf.c              |  12 +-
 hw/net/can/xlnx-versal-canfd.c         | 433 +++++++++----------------
 hw/nvram/xlnx-bbram.c                  |  13 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c      |   1 -
 hw/nvram/xlnx-zynqmp-efuse.c           |   8 -
 hw/openrisc/openrisc_sim.c             |   3 +-
 hw/pci-host/raven.c                    |  40 +--
 hw/ppc/e500.c                          |   6 +-
 hw/ppc/prep.c                          |  17 +-
 hw/ppc/spapr.c                         |  16 +-
 hw/rtc/mc146818rtc.c                   |  20 +-
 hw/timer/i8254.c                       |   6 +
 hw/timer/i8254_common.c                |   6 +-
 hw/virtio/virtio-mem.c                 | 100 +++---
 hw/xen/xen_pt_msi.c                    |   1 +
 monitor/qemu-config-qmp.c              |   3 +-
 system/qdev-monitor.c                  |   4 +-
 system/vl.c                            |   7 +-
 target/i386/cpu-apic.c                 |  18 +-
 target/i386/cpu-dump.c                 |   2 +-
 target/i386/cpu.c                      |   2 +-
 target/i386/hvf/hvf.c                  |   4 +-
 target/i386/kvm/kvm.c                  |   2 +-
 target/i386/tcg/system/misc_helper.c   |   4 +-
 target/i386/whpx/whpx-apic.c           |   3 +-
 tests/qtest/ds1338-test.c              |  12 +-
 hw/audio/trace-events                  |   4 +
 hw/rtc/trace-events                    |   4 +
 hw/timer/trace-events                  |   4 +
 hw/virtio/meson.build                  |   2 +-
 72 files changed, 760 insertions(+), 927 deletions(-)

-- 
2.51.0


