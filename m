Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4700AC44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqR5-0004Rk-Lc; Thu, 22 Jan 2026 03:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqR3-0004R0-Rh
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:53:01 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqR1-0005mh-J2
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:53:01 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so623178f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769071977; x=1769676777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4qAMWdF5XmLZIqn6b36GX/4rsQw1CL6/pr+3uWu5AlU=;
 b=eMYHfiRrm7B0nDGdikUo7WczbvK5uaCYQ9ZbMQntaHduKNQI9hvM6lGT4oxpukwD1v
 AJcFkoNabJczKzlTMyMe0IiqWrkAzo2+hiJ+gn2vbqOe/093o7lhlMgx3hE96IWgjdEl
 1UDZk7wu7kK7U+M7rdIaHFVfnC9TzausU1UExSZyiuZ/M56Y5RbhdRWy4VyoW4WyDkPA
 tMa9+Cu2ym60yx0xhvkx1GmoA52qgdBLIpExB/bzXSUbv4MgWKxq0erzTf4HOxJK+FEW
 mnaecFVm7yC3OhG1C8fGx8EY7QulwBHUDCEsgHJSUm2lajox2LZFHb5vE9d7OONJPTcq
 lIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769071977; x=1769676777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4qAMWdF5XmLZIqn6b36GX/4rsQw1CL6/pr+3uWu5AlU=;
 b=fIVG9T/m5fQ3Gx1R6Ern8vIuDO8S8pGUcBiQnI4PAFPYzbFU3Ee7N+yh9r4jpWSzP6
 uUGBzxSFz2OA+rzXp7Dl3S4UUN3O8HpgwXwaV79s0s9wsQ9df9/0Z84Hl0oyIm7y48P3
 Vb88lcdg0iLtHON5KmpztJxeFsEGxuplLVfFEUNuW69phTk28jQFoJhv/KOPidM8S6yi
 JW/QkBZfuzGZgyOhvb+6mSbah8uZgadk9XQzupwoiOn4hUkCtwPYeLGyXlm2ovEbx5+M
 h4vv83A8vzcK83tm3tJWDl8y9NrIPKJakakq9tJ57KZLHyk+6pyBNhXAlM5iAiY85O+J
 Q8JQ==
X-Gm-Message-State: AOJu0YzrvLxhArVgM6Z9TOVMI8xYgA5uoaKYNnmBpo+AQGlokAtVUO6S
 45RGDHrATGesBh6L38om6cgadBRxoi+mj7SABvktW4lkATTJUF3MR22rGQP+OWM8A6rO0pBwl21
 D6fu5kbg=
X-Gm-Gg: AZuq6aIsoch+yjfXz5lYtXti6h5SJDWFs14eCT03t5qwI4kUD5mXmsoGlnGMVeYz8wM
 1N6M36olkt9zr1XOL3kcTn8BmkhMa3J5pY4NkCoD0CesvP45IGl+vmEq4kkXKhk9i+eksGvaZA5
 pyo+iJo+B/45oom8uSipqfEkgCnVNuxijSxvKCkVQ5W8PC7nbK1ai7TrSw8Mh1HOFRyG7TA6PIb
 w45Hx2yOtSDl+nbut4npbk9Ow6azcQs9Irjq8hAPw3pwof5zK6kYq/LNtpOb2CS579wpukJwdEW
 xwFTJdZVjBMOtdLvlz2cZM4ERyFH69uctaCdI+6oK6U5wES8Xaiec2Do4DT4xPwoudRkXTXa3lj
 tynmw9yoYMBFakspDFiRcMHaLw6ciT3TAbbWdIykryyYgh+lSox4q/6+BDPR/jHHX5JMOjXbVOG
 axnOPSMQgDW21CvHi27G97l12Mb5IflYAfhU6QmRHSdz7x3be8FDizKj1k7rVUt1ewvTwXpC8=
X-Received: by 2002:a5d:64c8:0:b0:435:9241:37b4 with SMTP id
 ffacd0b85a97d-43592413b05mr14632621f8f.53.1769071977079; 
 Thu, 22 Jan 2026 00:52:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4358f138e26sm18355664f8f.17.2026.01.22.00.52.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:52:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/31] Memory API patches for 2026-01-22
Date: Thu, 22 Jan 2026 09:52:23 +0100
Message-ID: <20260122085255.95035-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The following changes since commit 2339d0a1cfac6ecc667e6e062a593865c1541c35:

  Merge tag 'hw-misc-20260120' of https://github.com/philmd/qemu into staging (2026-01-21 07:39:57 +1100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/memory-api-20260122

for you to fetch changes up to 1b5019fb8f75d7930096017558d50fc13561a440:

  cpus: Allocate maximum number of ASes supported by the arch (2026-01-22 09:43:56 +0100)

----------------------------------------------------------------
Memory API patches

- Reduce 'qemu/bswap.h' uses
- Introduce ldm_p/stm_p (MemOp) load/store helpers
- Allow restricting the legacy 'native-endian' APIs
- Forbid various targets to use legacy native endianness APIs
- Simplify cpu_address_space_init() API
----------------------------------------------------------------

Deliberately ignored checkpatch.pl errors:

 ERROR: DEVICE_NATIVE_ENDIAN is not allowed, use DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN instead
 #314: FILE: system/memory_ldst.c.inc:448:
 +#define DEVICE_ENDIANNESS       DEVICE_NATIVE_ENDIAN

 ERROR: DEVICE_NATIVE_ENDIAN is not allowed, use DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN instead
 #182: FILE: system/memory_ldst.c.inc:97:
 +                                                    DEVICE_NATIVE_ENDIAN);

 ERROR: DEVICE_NATIVE_ENDIAN is not allowed, use DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN instead
 #332: FILE: system/memory_ldst.c.inc:171:
 +                                             DEVICE_NATIVE_ENDIAN);

 ERROR: DEVICE_NATIVE_ENDIAN is not allowed, use DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN instead
 #34: FILE: include/system/memory.h:31:
 +    DEVICE_NATIVE_ENDIAN = 0,

False negative:

  WARNING: added, moved or deleted file(s):

    dump/win_dump-stubs.c
    dump/win_dump-x86.c
    dump/Kconfig

  Does MAINTAINERS need updating?

Gustavo Romero (3):
  target/arm: Initialize AS 0 first
  target/i386: Add a _MAX sentinel to X86ASIdx enum
  target/arm: Add a _MAX sentinel to ARMASIdx enum

Philippe Mathieu-Daudé (28):
  bswap: Include missing 'qemu/bswap.h' header
  bswap: Use 'qemu/bswap.h' instead of 'qemu/host-utils.h'
  bswap: Remove unnecessary 'qemu/bswap.h'
  system/memory: Introduce ldm_p() and stm_p() load/store helpers
  system/memory: Define address_space_ldst[W] endian variants via
    template
  system/memory: Define address_space_ldst[L] endian variants via
    template
  system/memory: Define address_space_ldst[Q] endian variants via
    template
  system/memory: Factor address_space_ldst[M]_internal() helper out
  system/memory: Pass device_endian argument as MemOp bit
  system/memory: Use ldm_p() and stm_p() helpers
  system/memory: Directly call address_space_ldst[M]_internal() helper
  system: Allow restricting the legacy ld/st_phys() 'native-endian' API
  system: Allow restricting legacy address_space_ldst() native-endian
    API
  system: Allow restricting the legacy cpu_ld/st() 'native-endian' API
  system: Allow restricting the legacy translator_ld() 'native-endian'
    API
  system: Allow restricting the legacy tswap() 'native-endian' API
  system: Allow restricting the legacy MO_TE* 'native-endian'
    definitions
  system: Allow restricting the legacy DEVICE_NATIVE_ENDIAN definition
  configs/targets: Forbid Hexagon to use legacy native endianness API
  configs/targets: Forbid HPPA to use legacy native endianness APIs
  configs/targets: Forbid LoongArch to use legacy native endianness APIs
  configs/targets: Forbid OpenRISC to use legacy native endianness APIs
  configs/targets: Forbid TriCore to use legacy native endianness API
  configs/targets: Forbid Renesas RX to use legacy native endianness API
  configs/targets: Forbid s390x to use legacy native endianness APIs
  dump: Abort in create_win_dump() on non-x86 guests
  dump: Build stubs once for non-x86 targets
  cpus: Allocate maximum number of ASes supported by the arch

 MAINTAINERS                                  |   1 +
 configs/targets/hexagon-linux-user.mak       |   1 +
 configs/targets/hppa-linux-user.mak          |   1 +
 configs/targets/hppa-softmmu.mak             |   1 +
 configs/targets/loongarch64-linux-user.mak   |   1 +
 configs/targets/loongarch64-softmmu.mak      |   1 +
 configs/targets/or1k-linux-user.mak          |   1 +
 configs/targets/or1k-softmmu.mak             |   1 +
 configs/targets/rx-softmmu.mak               |   1 +
 configs/targets/s390x-linux-user.mak         |   1 +
 configs/targets/s390x-softmmu.mak            |   1 +
 configs/targets/tricore-softmmu.mak          |   1 +
 block/qcow2.h                                |   1 +
 include/accel/tcg/cpu-ldst.h                 |   2 +
 include/exec/cpu-common.h                    |   4 -
 include/exec/memop.h                         |   4 +
 include/exec/translator.h                    |   5 +-
 include/exec/tswap.h                         |   3 +
 include/hw/core/cpu.h                        |   7 +-
 include/qemu/bswap.h                         |  72 +++
 include/qemu/host-utils.h                    |   1 -
 include/qemu/int128.h                        |   2 -
 include/system/memory.h                      |   8 +-
 include/system/memory_cached.h               |   2 +
 system/memory-internal.h                     |   2 +
 target/arm/cpu.h                             |   1 +
 target/i386/cpu.h                            |   1 +
 include/system/memory_ldst.h.inc             |  52 +--
 include/system/memory_ldst_endian.h.inc      |  33 ++
 include/system/memory_ldst_phys.h.inc        | 113 +----
 include/system/memory_ldst_phys_endian.h.inc |  57 +++
 audio/audio.c                                |   1 +
 block/blklogwrites.c                         |   1 +
 block/export/vduse-blk.c                     |   1 +
 block/export/vhost-user-blk-server.c         |   1 +
 block/export/virtio-blk-handler.c            |   1 +
 block/parallels-ext.c                        |   1 +
 dump/win_dump-stubs.c                        |  21 +
 dump/{win_dump.c => win_dump-x86.c}          |  20 +-
 hw/9pfs/9p-local.c                           |   1 +
 hw/block/cdrom.c                             |   1 +
 hw/block/hd-geometry.c                       |   1 +
 hw/core/cpu-common.c                         |   1 -
 hw/core/cpu-system.c                         |   2 +-
 hw/net/can/ctucan_core.c                     |   1 +
 hw/nvram/xlnx-efuse.c                        |   1 +
 hw/scsi/scsi-generic.c                       |   1 +
 hw/sd/sd.c                                   |   1 +
 hw/sd/ssi-sd.c                               |   1 +
 net/l2tpv3.c                                 |   1 +
 qga/commands-linux.c                         |   1 +
 scsi/pr-manager-helper.c                     |   1 +
 system/cpus.c                                |   1 -
 system/physmem.c                             |   8 +-
 target/arm/cpu.c                             |  13 +-
 target/arm/tcg/arith_helper.c                |   1 +
 target/i386/cpu.c                            |   1 +
 target/i386/kvm/kvm-cpu.c                    |   1 -
 target/i386/tcg/system/tcg-cpu.c             |   1 -
 tests/qtest/acpi-utils.c                     |   1 +
 tests/qtest/ahci-test.c                      |   2 +-
 tests/qtest/aspeed-hace-utils.c              |   1 +
 tests/qtest/bios-tables-test.c               |   1 +
 tests/qtest/libqos/ahci.c                    |   2 +-
 tests/qtest/libqos/generic-pcihost.c         |   2 +-
 tests/qtest/libqos/igb.c                     |   1 +
 tests/qtest/libqos/pci-spapr.c               |   2 +-
 tests/qtest/libqos/virtio-9p-client.c        |   1 +
 tests/qtest/migration/framework.c            |   1 +
 tests/qtest/npcm7xx_emc-test.c               |   1 +
 tests/qtest/tpm-emu.c                        |   1 +
 tests/qtest/ufs-test.c                       |   1 +
 tests/qtest/vmgenid-test.c                   |   1 +
 tests/unit/test-hbitmap.c                    |   1 +
 util/bitmap.c                                |   1 +
 util/hbitmap.c                               |   2 +-
 system/memory_ldst.c.inc                     | 449 ++-----------------
 system/memory_ldst_endian.c.inc              |  70 +++
 Kconfig                                      |   1 +
 dump/Kconfig                                 |   4 +
 dump/meson.build                             |   3 +-
 scripts/make-config-poison.sh                |   1 +
 82 files changed, 409 insertions(+), 610 deletions(-)
 create mode 100644 include/system/memory_ldst_endian.h.inc
 create mode 100644 include/system/memory_ldst_phys_endian.h.inc
 create mode 100644 dump/win_dump-stubs.c
 rename dump/{win_dump.c => win_dump-x86.c} (97%)
 create mode 100644 system/memory_ldst_endian.c.inc
 create mode 100644 dump/Kconfig

-- 
2.52.0

