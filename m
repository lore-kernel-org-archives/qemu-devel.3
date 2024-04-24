Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A5AC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 14:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzdOE-0001V6-HB; Wed, 24 Apr 2024 10:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzdOB-0001ST-Ub
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:14:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzdO6-0007qu-TO
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:14:23 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-345b857d7adso5519924f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 07:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713968051; x=1714572851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZfEmBT8Pnii/zoMJHoHpVSFvLdDCuIaNw/KEb0b2AK4=;
 b=Hx0BGaABPfNRySkitKIR829KSJDQL26jj4h0XI0hTWN4DQuAIfOMy2WqFdHuJ6Vvpd
 tQMyhMSTFK1l4vSvUsd2tXUgzfiJGYrFi27hBiY7Escd8chhuiOzcQEIXZpa6gd2j8i8
 AQsDTanFplonFvM4F9Vkl+Lo7LOXBH4Fe+ywjpnqRKrEWnuN0F0mCVsKq3kVix0oQF2q
 /7nRgj1wW/pQlvbY+lVQF4qhdyNigXUKp6B4oAEnpUulR6MpKMZNOjFkVahqUc3s5vGH
 HoUzX70FIeuWvE4CHHpTMIHLzpjXkUP6qGPrVF0xWrMzL47ItfUF43ZcpoAbPubVFoXm
 XaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713968051; x=1714572851;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZfEmBT8Pnii/zoMJHoHpVSFvLdDCuIaNw/KEb0b2AK4=;
 b=IPn2/10VlGdU/EUfRyU9H9CfFOWs6qCDzPnhintcas6dIC11/OfGU5HirwkVEyH4SZ
 ig7QRbD43ObQIVmxdm1VwK02OplVbMbn+dVR2Ut/iVPkdF/7+JHJkDYpvDia2pyeJDxp
 wTt1kZJ78aIZizmQGZmobvIKcO5QX2RFqR/MzGLkiw2hrHwhXXxXSflPEqhCzSaXjkaN
 hgiv48ttaa9XwKEUe6AB1dtE1bNY+PXgdrTH/bwaoRw0k1WJCgrN8X3ZO7/n+K3JFwtC
 Rx6IHLSCmYETX1uuOODPX4lokqSTPP3eqADYFyLphuiO+K1dVHOuvIB9fSqe/dcoMRu7
 KoRA==
X-Gm-Message-State: AOJu0YwNizfYZOjb0HnWKXrJxJtInmH+qPnrm6qWGICv5F8FJKZqzJIG
 dpx9GRVe6ZDWICDxDxYL+019x5BMUnQM5GZ8n8flOL6rz9XwUwOzct6ueTOhCxBiUTA0fr9GTOw
 KgwQ=
X-Google-Smtp-Source: AGHT+IGj4oFChuZ22JHzV1N9Q1i+0C9JOK6Gs6Jtv6/AQ86DTPAL5EBnCoiQxzbmxVsqqKI1+xQD6A==
X-Received: by 2002:a5d:6686:0:b0:349:8ae9:b01f with SMTP id
 l6-20020a5d6686000000b003498ae9b01fmr1764578wru.1.1713968051249; 
 Wed, 24 Apr 2024 07:14:11 -0700 (PDT)
Received: from localhost.localdomain
 (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr. [176.184.51.42])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a5d6da6000000b00346ab3c372bsm17547953wrs.73.2024.04.24.07.14.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Apr 2024 07:14:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, qemu-block@nongnu.org,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/5] Housekeeping patches for 2024-04-24
Date: Wed, 24 Apr 2024 16:14:02 +0200
Message-ID: <20240424141408.87779-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
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

The following changes since commit 1a6f53953df65f31e922f8a1763dac9f10adc81b:

  Open 9.1 development tree (2024-04-23 17:33:36 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/housekeeping-20240424

for you to fetch changes up to 2d9cbbea64e67d90c3c22d7e2d5ab530d830eb33:

  block/gluster: Remove deprecated RDMA protocol handling (2024-04-24 16:03:38 +0200)

----------------------------------------------------------------
Removal of deprecated code

- Remove the Nios II target and hardware
- Remove pvrdma device and rdmacm-mux helper
- Remove GlusterFS RDMA protocol handling
- Update Sriram Yagnaraman mail address

----------------------------------------------------------------

Philippe Mathieu-Daudé (4):
  target/nios2: Remove the deprecated Nios II target
  hw/timer: Remove the ALTERA_TIMER model
  hw/rdma: Remove deprecated pvrdma device and rdmacm-mux helper
  block/gluster: Remove deprecated RDMA protocol handling

Sriram Yagnaraman (1):
  MAINTAINERS: Update Sriram Yagnaraman mail address

 MAINTAINERS                                   |   25 +-
 docs/about/deprecated.rst                     |   20 -
 docs/about/emulation.rst                      |    7 -
 docs/about/removed-features.rst               |   21 +
 docs/pvrdma.txt                               |  345 --
 docs/system/device-url-syntax.rst.inc         |    4 +-
 docs/system/loongarch/virt.rst                |    2 +-
 docs/system/qemu-block-drivers.rst.inc        |    1 -
 docs/system/replay.rst                        |    2 +-
 docs/user/main.rst                            |    4 -
 configure                                     |    2 -
 configs/devices/nios2-softmmu/default.mak     |    6 -
 configs/targets/nios2-linux-user.mak          |    1 -
 configs/targets/nios2-softmmu.mak             |    2 -
 meson.build                                   |   38 -
 qapi/machine.json                             |   19 +-
 qapi/qapi-schema.json                         |    1 -
 qapi/rdma.json                                |   38 -
 contrib/rdmacm-mux/rdmacm-mux.h               |   61 -
 hw/nios2/boot.h                               |   10 -
 hw/rdma/rdma_backend.h                        |  129 -
 hw/rdma/rdma_backend_defs.h                   |   76 -
 hw/rdma/rdma_rm.h                             |   97 -
 hw/rdma/rdma_rm_defs.h                        |  146 -
 hw/rdma/rdma_utils.h                          |   63 -
 hw/rdma/trace.h                               |    1 -
 hw/rdma/vmw/pvrdma.h                          |  144 -
 hw/rdma/vmw/pvrdma_dev_ring.h                 |   46 -
 hw/rdma/vmw/pvrdma_qp_ops.h                   |   28 -
 hw/rdma/vmw/trace.h                           |    1 -
 include/disas/dis-asm.h                       |    5 -
 include/exec/poison.h                         |    2 -
 include/exec/user/abitypes.h                  |    3 +-
 include/hw/intc/nios2_vic.h                   |   66 -
 include/hw/rdma/rdma.h                        |   37 -
 include/monitor/hmp.h                         |    1 -
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |  685 ----
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  348 --
 .../standard-headers/rdma/vmw_pvrdma-abi.h    |  310 --
 include/sysemu/arch_init.h                    |    1 -
 linux-user/nios2/sockbits.h                   |    1 -
 linux-user/nios2/syscall_nr.h                 |  333 --
 linux-user/nios2/target_cpu.h                 |   49 -
 linux-user/nios2/target_elf.h                 |   14 -
 linux-user/nios2/target_errno_defs.h          |    7 -
 linux-user/nios2/target_fcntl.h               |   11 -
 linux-user/nios2/target_mman.h                |   11 -
 linux-user/nios2/target_prctl.h               |    1 -
 linux-user/nios2/target_proc.h                |    1 -
 linux-user/nios2/target_resource.h            |    1 -
 linux-user/nios2/target_signal.h              |    9 -
 linux-user/nios2/target_structs.h             |    1 -
 linux-user/nios2/target_syscall.h             |   37 -
 linux-user/nios2/termbits.h                   |    1 -
 linux-user/syscall_defs.h                     |    4 +-
 target/nios2/cpu-param.h                      |   20 -
 target/nios2/cpu-qom.h                        |   18 -
 target/nios2/cpu.h                            |  301 --
 target/nios2/helper.h                         |   32 -
 target/nios2/mmu.h                            |   52 -
 tests/tcg/nios2/semicall.h                    |   28 -
 block/gluster.c                               |   39 -
 contrib/rdmacm-mux/main.c                     |  831 ----
 disas/nios2.c                                 | 3514 -----------------
 hw/core/machine-qmp-cmds.c                    |   32 -
 hw/intc/nios2_vic.c                           |  313 --
 hw/nios2/10m50_devboard.c                     |  181 -
 hw/nios2/boot.c                               |  234 --
 hw/nios2/generic_nommu.c                      |  101 -
 hw/rdma/rdma.c                                |   30 -
 hw/rdma/rdma_backend.c                        | 1401 -------
 hw/rdma/rdma_rm.c                             |  812 ----
 hw/rdma/rdma_utils.c                          |  126 -
 hw/rdma/vmw/pvrdma_cmd.c                      |  815 ----
 hw/rdma/vmw/pvrdma_dev_ring.c                 |  141 -
 hw/rdma/vmw/pvrdma_main.c                     |  735 ----
 hw/rdma/vmw/pvrdma_qp_ops.c                   |  298 --
 hw/timer/altera_timer.c                       |  244 --
 linux-user/elfload.c                          |   99 -
 linux-user/nios2/cpu_loop.c                   |  157 -
 linux-user/nios2/signal.c                     |  210 -
 monitor/qmp-cmds.c                            |    1 -
 target/nios2/cpu.c                            |  410 --
 target/nios2/helper.c                         |  371 --
 target/nios2/mmu.c                            |  216 -
 target/nios2/monitor.c                        |   35 -
 target/nios2/nios2-semi.c                     |  230 --
 target/nios2/op_helper.c                      |  119 -
 target/nios2/translate.c                      | 1107 ------
 tests/qtest/machine-none-test.c               |    1 -
 fpu/softfloat-specialize.c.inc                |    2 +-
 .gitlab-ci.d/buildtest.yml                    |    4 +-
 .gitlab-ci.d/crossbuild-template.yml          |    2 +-
 .gitlab-ci.d/crossbuilds.yml                  |    2 +-
 .mailmap                                      |    1 +
 Kconfig.host                                  |    3 -
 contrib/rdmacm-mux/meson.build                |    7 -
 disas/meson.build                             |    1 -
 hmp-commands-info.hx                          |   13 -
 hw/Kconfig                                    |    2 -
 hw/intc/Kconfig                               |    3 -
 hw/intc/meson.build                           |    1 -
 hw/meson.build                                |    2 -
 hw/nios2/Kconfig                              |   13 -
 hw/nios2/meson.build                          |    6 -
 hw/rdma/Kconfig                               |    3 -
 hw/rdma/meson.build                           |   12 -
 hw/rdma/trace-events                          |   31 -
 hw/rdma/vmw/trace-events                      |   17 -
 hw/timer/Kconfig                              |    4 -
 hw/timer/meson.build                          |    1 -
 meson_options.txt                             |    2 -
 qapi/meson.build                              |    1 -
 qemu-options.hx                               |   11 +-
 .../ci/org.centos/stream/8/x86_64/configure   |    1 -
 scripts/coverity-scan/COMPONENTS.md           |    3 -
 scripts/gensyscalls.sh                        |    1 -
 scripts/meson-buildoptions.sh                 |    3 -
 scripts/probe-gdb-support.py                  |    1 -
 scripts/update-linux-headers.sh               |   27 -
 target/Kconfig                                |    1 -
 target/meson.build                            |    1 -
 target/nios2/Kconfig                          |    3 -
 target/nios2/meson.build                      |   17 -
 target/nios2/trace-events                     |   10 -
 tests/avocado/boot_linux_console.py           |    8 -
 tests/avocado/replay_kernel.py                |   11 -
 tests/docker/Makefile.include                 |    5 -
 .../debian-nios2-cross.d/build-toolchain.sh   |   87 -
 tests/tcg/nios2/10m50-ghrd.ld                 |   70 -
 tests/tcg/nios2/Makefile.softmmu-target       |   32 -
 tests/tcg/nios2/Makefile.target               |   11 -
 tests/tcg/nios2/boot.S                        |  218 -
 tests/tcg/nios2/intr.S                        |   31 -
 tests/tcg/nios2/test-shadow-1.S               |   40 -
 135 files changed, 40 insertions(+), 17218 deletions(-)
 delete mode 100644 docs/pvrdma.txt
 delete mode 100644 configs/devices/nios2-softmmu/default.mak
 delete mode 100644 configs/targets/nios2-linux-user.mak
 delete mode 100644 configs/targets/nios2-softmmu.mak
 delete mode 100644 qapi/rdma.json
 delete mode 100644 contrib/rdmacm-mux/rdmacm-mux.h
 delete mode 100644 hw/nios2/boot.h
 delete mode 100644 hw/rdma/rdma_backend.h
 delete mode 100644 hw/rdma/rdma_backend_defs.h
 delete mode 100644 hw/rdma/rdma_rm.h
 delete mode 100644 hw/rdma/rdma_rm_defs.h
 delete mode 100644 hw/rdma/rdma_utils.h
 delete mode 100644 hw/rdma/trace.h
 delete mode 100644 hw/rdma/vmw/pvrdma.h
 delete mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
 delete mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
 delete mode 100644 hw/rdma/vmw/trace.h
 delete mode 100644 include/hw/intc/nios2_vic.h
 delete mode 100644 include/hw/rdma/rdma.h
 delete mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
 delete mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
 delete mode 100644 include/standard-headers/rdma/vmw_pvrdma-abi.h
 delete mode 100644 linux-user/nios2/sockbits.h
 delete mode 100644 linux-user/nios2/syscall_nr.h
 delete mode 100644 linux-user/nios2/target_cpu.h
 delete mode 100644 linux-user/nios2/target_elf.h
 delete mode 100644 linux-user/nios2/target_errno_defs.h
 delete mode 100644 linux-user/nios2/target_fcntl.h
 delete mode 100644 linux-user/nios2/target_mman.h
 delete mode 100644 linux-user/nios2/target_prctl.h
 delete mode 100644 linux-user/nios2/target_proc.h
 delete mode 100644 linux-user/nios2/target_resource.h
 delete mode 100644 linux-user/nios2/target_signal.h
 delete mode 100644 linux-user/nios2/target_structs.h
 delete mode 100644 linux-user/nios2/target_syscall.h
 delete mode 100644 linux-user/nios2/termbits.h
 delete mode 100644 target/nios2/cpu-param.h
 delete mode 100644 target/nios2/cpu-qom.h
 delete mode 100644 target/nios2/cpu.h
 delete mode 100644 target/nios2/helper.h
 delete mode 100644 target/nios2/mmu.h
 delete mode 100644 tests/tcg/nios2/semicall.h
 delete mode 100644 contrib/rdmacm-mux/main.c
 delete mode 100644 disas/nios2.c
 delete mode 100644 hw/intc/nios2_vic.c
 delete mode 100644 hw/nios2/10m50_devboard.c
 delete mode 100644 hw/nios2/boot.c
 delete mode 100644 hw/nios2/generic_nommu.c
 delete mode 100644 hw/rdma/rdma.c
 delete mode 100644 hw/rdma/rdma_backend.c
 delete mode 100644 hw/rdma/rdma_rm.c
 delete mode 100644 hw/rdma/rdma_utils.c
 delete mode 100644 hw/rdma/vmw/pvrdma_cmd.c
 delete mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
 delete mode 100644 hw/rdma/vmw/pvrdma_main.c
 delete mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
 delete mode 100644 hw/timer/altera_timer.c
 delete mode 100644 linux-user/nios2/cpu_loop.c
 delete mode 100644 linux-user/nios2/signal.c
 delete mode 100644 target/nios2/cpu.c
 delete mode 100644 target/nios2/helper.c
 delete mode 100644 target/nios2/mmu.c
 delete mode 100644 target/nios2/monitor.c
 delete mode 100644 target/nios2/nios2-semi.c
 delete mode 100644 target/nios2/op_helper.c
 delete mode 100644 target/nios2/translate.c
 delete mode 100644 contrib/rdmacm-mux/meson.build
 delete mode 100644 hw/nios2/Kconfig
 delete mode 100644 hw/nios2/meson.build
 delete mode 100644 hw/rdma/Kconfig
 delete mode 100644 hw/rdma/meson.build
 delete mode 100644 hw/rdma/trace-events
 delete mode 100644 hw/rdma/vmw/trace-events
 delete mode 100644 target/nios2/Kconfig
 delete mode 100644 target/nios2/meson.build
 delete mode 100644 target/nios2/trace-events
 delete mode 100755 tests/docker/dockerfiles/debian-nios2-cross.d/build-toolchain.sh
 delete mode 100644 tests/tcg/nios2/10m50-ghrd.ld
 delete mode 100644 tests/tcg/nios2/Makefile.softmmu-target
 delete mode 100644 tests/tcg/nios2/Makefile.target
 delete mode 100644 tests/tcg/nios2/boot.S
 delete mode 100644 tests/tcg/nios2/intr.S
 delete mode 100644 tests/tcg/nios2/test-shadow-1.S

-- 
2.41.0


