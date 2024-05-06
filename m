Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498BBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t8w-0005ox-39; Mon, 06 May 2024 03:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8Y-0005im-JE
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8G-0001Ty-KE
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L4WRAN9XGJxlv/trcKHOtT6UAUrYBzNnWxQxyfQyt98=;
 b=dGuH7HKEAAaCHVR1tL4IatNkxphj32gdAYyiQ97tTjITNwH8NgBipJ4WBB2j8eumm1zKOc
 0GNH4Wz8Eu38jcSg3SYR8FhjduaEwSYPgwSRSAzDC/s3Eg7fARcpPzAn++J2MEpByVszm2
 HGwVkq4vBuORDk7uKLWKURMiJAMWUCw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-1H_B0KDfMxanROt3FaaFLw-1; Mon, 06 May 2024 03:51:29 -0400
X-MC-Unique: 1H_B0KDfMxanROt3FaaFLw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59a63a1f78so89181466b.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981888; x=1715586688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L4WRAN9XGJxlv/trcKHOtT6UAUrYBzNnWxQxyfQyt98=;
 b=NraFWF5HQ4iX9l9G41rRPItxeLRpS0MktWkIPydhUdj9uOIycw6KK/IbPAXnmSvzpM
 3furIndxEuFV57cqMUBIOwPf1lld9Wg2DFH48ebLJKyrAPac46OaVmxnlKQAZai3NQMJ
 j1oTeJAUlkVvkQCd8dwX8PFP47187lXvHr5RZEBZ42Z0WTg7BoB37uJA8o8QDxqlDnz6
 ugrXCWx2j84gSLaFRSqNTzBvcGhRbM4WdMydH2TULr30QRubga5a+9cV9b9VLjsif8vM
 4FBw73rMR2YQdnSibfAwLWlxzaVd8a23yi0C4/LIOJKeBb5+cyKG15g62XE2co9ZeNtF
 okCQ==
X-Gm-Message-State: AOJu0Yx5B4gKZ/YWVGBXFD2cF1s0ZrgGL+H6Q6S4nftpNfMj3n4bP2GK
 08HJo6o+ndAXJLUU0YX9egTsGBxUwnQHLakP65jQyBxs3WwxFzEgEIjc3FEwqVV/ZIaiC/aqwTp
 Y+A1JMDGHxeBSWKnCLaawHFCMcWIV1SUWyOM77rD8vhQ7/jA5N4ApLSxzHXRIKgoeBakcm46ECF
 ptQCjNTnj7sF3Jaj9r6oFQXR3/AR5P51Dx9un5
X-Received: by 2002:a17:906:4882:b0:a58:725b:a021 with SMTP id
 v2-20020a170906488200b00a58725ba021mr5727571ejq.15.1714981887829; 
 Mon, 06 May 2024 00:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe25VEBBRtN0lSQGAguPSD1QBhlp9p/vGY5tpJ6sxrezxzHYOWiUhDS1dzFL7emCRI+0gDHg==
X-Received: by 2002:a17:906:4882:b0:a58:725b:a021 with SMTP id
 v2-20020a170906488200b00a58725ba021mr5727556ejq.15.1714981887293; 
 Mon, 06 May 2024 00:51:27 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 ze11-20020a170906ef8b00b00a59ab4f5f79sm2538140ejb.212.2024.05.06.00.51.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/46] Mostly build system and other cleanups patches for
 2024-05-06
Date: Mon,  6 May 2024 09:50:39 +0200
Message-ID: <20240506075125.8238-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

The following changes since commit 4977ce198d2390bff8c71ad5cb1a5f6aa24b56fb:

  Merge tag 'pull-tcg-20240501' of https://gitlab.com/rth7680/qemu into staging (2024-05-01 15:15:33 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to deb686ef0e609ceaec0daa5dc88eb5b3dd9701b0:

  qga/commands-posix: fix typo in qmp_guest_set_user_password (2024-05-03 19:36:51 +0200)

----------------------------------------------------------------
* target/i386: Introduce SapphireRapids-v3 to add missing features
* switch boards to "default y"
* allow building emulators without any board
* configs: list "implied" device groups in the default configs
* remove unnecessary declarations from typedefs.h
* target/i386: Give IRQs a chance when resetting HF_INHIBIT_IRQ_MASK

----------------------------------------------------------------
Lei Wang (1):
      target/i386: Introduce SapphireRapids-v3 to add missing features

Paolo Bonzini (44):
      Kconfig: kvm: allow building without any board
      tests/qtest: skip m48t59-test if the machine is absent
      gitlab-ci: adjust msys2-64bit to be able to run qtest
      kvm: ppc: disable sPAPR code if CONFIG_PSERIES is disabled
      configs: list "implied" device groups in the default configs
      alpha: switch boards to "default y"
      arm: switch boards to "default y"
      avr: switch boards to "default y"
      cris: switch boards to "default y"
      hppa: switch boards to "default y"
      i386: switch boards to "default y"
      loongarch: switch boards to "default y"
      m68k: switch boards to "default y"
      microblaze: switch boards to "default y"
      meson: make target endianneess available to Kconfig
      mips: switch boards to "default y"
      openrisc: switch boards to "default y"
      ppc: switch boards to "default y"
      riscv: switch boards to "default y"
      rx: switch boards to "default y"
      s390x: switch boards to "default y"
      sh4: switch boards to "default y"
      sparc: switch boards to "default y"
      tricore: switch boards to "default y"
      xtensa: switch boards to "default y"
      docs: document new convention for Kconfig board symbols
      bitmap: Use g_try_new0/g_new0/g_renew
      build: do not build virtio-vga-gl if virgl/opengl not available
      fw_cfg: remove useless declarations from typedefs.h
      qdev-core: remove DeviceListener from typedefs.h
      numa: remove types from typedefs.h
      net: remove AnnounceTimer from typedefs.h
      qemu-option: remove QemuOpt from typedefs.h
      intc: remove PICCommonState from typedefs.h
      lockable: remove QemuLockable from typedefs.h
      migration: remove PostcopyDiscardState from typedefs.h
      monitor: remove MonitorDef from typedefs.h
      qapi/machine: remove types from typedefs.h
      display: remove GraphicHwOps from typedefs.h
      tcg: remove CPU* types from typedefs.h
      pci: remove some types from typedefs.h
      kvm: move target-dependent interrupt routing out of kvm-all.c
      migration: do not include coroutine_int.h
      qga/commands-posix: fix typo in qmp_guest_set_user_password

Ruihan Li (1):
      target/i386: Give IRQs a chance when resetting HF_INHIBIT_IRQ_MASK

 docs/devel/kconfig.rst                          | 14 +++++-
 configs/devices/alpha-softmmu/default.mak       |  5 +-
 configs/devices/arm-softmmu/default.mak         |  5 +-
 configs/devices/avr-softmmu/default.mak         |  5 +-
 configs/devices/cris-softmmu/default.mak        |  5 +-
 configs/devices/hppa-softmmu/default.mak        |  5 +-
 configs/devices/i386-softmmu/default.mak        | 11 ++---
 configs/devices/loongarch64-softmmu/default.mak |  6 ++-
 configs/devices/m68k-softmmu/default.mak        | 13 +++---
 configs/devices/microblaze-softmmu/default.mak  |  9 ++--
 configs/devices/mips-softmmu/common.mak         |  5 +-
 configs/devices/mips64-softmmu/default.mak      |  4 +-
 configs/devices/mips64el-softmmu/default.mak    | 10 ++--
 configs/devices/or1k-softmmu/default.mak        |  9 ++--
 configs/devices/ppc-softmmu/default.mak         | 30 +++++++-----
 configs/devices/ppc64-softmmu/default.mak       |  8 ++--
 configs/devices/riscv32-softmmu/default.mak     | 17 ++++---
 configs/devices/riscv64-softmmu/default.mak     | 19 ++++----
 configs/devices/rx-softmmu/default.mak          |  3 +-
 configs/devices/s390x-softmmu/default.mak       |  5 +-
 configs/devices/sh4-softmmu/default.mak         |  7 ++-
 configs/devices/sparc-softmmu/default.mak       |  7 ++-
 configs/devices/sparc64-softmmu/default.mak     |  7 ++-
 configs/devices/tricore-softmmu/default.mak     |  7 ++-
 configs/devices/xtensa-softmmu/default.mak      | 11 +++--
 meson.build                                     | 12 +++--
 accel/tcg/tb-jmp-cache.h                        |  4 +-
 hw/display/vga_int.h                            |  1 +
 include/hw/core/cpu.h                           | 11 ++++-
 include/hw/intc/i8259.h                         |  2 +
 include/hw/nvram/fw_cfg.h                       |  2 +
 include/hw/pci/pcie.h                           |  3 ++
 include/hw/pci/pcie_aer.h                       | 38 +++++++--------
 include/hw/pci/pcie_sriov.h                     |  8 ++--
 include/hw/qdev-core.h                          |  1 +
 include/hw/s390x/adapter.h                      |  4 +-
 include/monitor/hmp-target.h                    | 11 +++--
 include/net/announce.h                          |  4 +-
 include/qemu/bitmap.h                           | 19 ++++----
 include/qemu/coroutine.h                        |  4 +-
 include/qemu/lockable.h                         |  4 +-
 include/qemu/option.h                           |  2 +
 include/qemu/typedefs.h                         | 24 ----------
 include/sysemu/kvm.h                            |  5 +-
 include/sysemu/numa.h                           |  8 ++--
 migration/migration.h                           |  2 +-
 accel/kvm/kvm-all.c                             | 62 ++-----------------------
 hw/hyperv/hyperv.c                              | 25 ++++++++++
 hw/intc/s390_flic_kvm.c                         | 28 +++++++++++
 migration/postcopy-ram.c                        |  4 +-
 qga/commands-posix.c                            |  2 +-
 stubs/target-monitor-defs.c                     |  3 +-
 system/physmem.c                                |  4 +-
 target/i386/cpu.c                               | 11 +++++
 target/i386/tcg/translate.c                     | 14 ++++--
 target/ppc/kvm.c                                | 17 +++++--
 tests/qtest/m48t59-test.c                       | 11 +++--
 .gitlab-ci.d/buildtest.yml                      |  9 +++-
 .gitlab-ci.d/windows.yml                        |  5 +-
 hw/alpha/Kconfig                                |  2 +
 hw/arm/Kconfig                                  |  2 +
 hw/avr/Kconfig                                  |  3 ++
 hw/cris/Kconfig                                 |  2 +
 hw/display/meson.build                          | 14 +++---
 hw/hppa/Kconfig                                 |  2 +
 hw/i386/Kconfig                                 | 10 +++-
 hw/loongarch/Kconfig                            |  2 +
 hw/m68k/Kconfig                                 | 10 ++++
 hw/microblaze/Kconfig                           |  6 +++
 hw/mips/Kconfig                                 | 12 +++++
 hw/openrisc/Kconfig                             |  4 ++
 hw/ppc/Kconfig                                  | 26 +++++++++++
 hw/riscv/Kconfig                                | 14 ++++++
 hw/rx/Kconfig                                   |  2 +
 hw/s390x/Kconfig                                |  2 +
 hw/sh4/Kconfig                                  |  4 ++
 hw/sparc/Kconfig                                |  4 ++
 hw/sparc64/Kconfig                              |  4 ++
 hw/tricore/Kconfig                              |  4 ++
 hw/xtensa/Kconfig                               |  6 +++
 target/Kconfig                                  |  3 ++
 target/arm/Kconfig                              |  2 +
 target/i386/Kconfig                             |  3 ++
 target/ppc/Kconfig                              |  1 +
 84 files changed, 455 insertions(+), 280 deletions(-)
-- 
2.44.0


