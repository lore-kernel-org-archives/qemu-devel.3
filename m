Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9954C10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66mL-00039B-Jy; Sun, 12 May 2024 06:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mK-00038P-K9
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mI-0005iM-HA
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZBK/0J79AFkGIYrouMMvcVR75PpIU5FUpx+qVNNoumU=;
 b=M2CgZv70yIhwTH6OPvRi7HiTc+n4YigOwOgllCpel3bL+E3UA96wLPCuCLAOMNf9+2MlZA
 psaOlhdQXn74HyRonkThdyE3tkTlntxIqqKbkJYpWBll1zst2O7zy3Z8CH3YmQdvIhG43C
 Hpbqt4EmGqYvAgtpUmF+YqRR/9BerAE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-duJDW5iMMCCAHLme1BD3Rg-1; Sun, 12 May 2024 06:49:49 -0400
X-MC-Unique: duJDW5iMMCCAHLme1BD3Rg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5732229087bso2154481a12.0
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715510988; x=1716115788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBK/0J79AFkGIYrouMMvcVR75PpIU5FUpx+qVNNoumU=;
 b=ViZNouL2cJFDf55sLMSvzOVP+saQBDUFl5/qnJbihyzp/tHOJgFSWc4mO2YHo4EMSJ
 fV5wgLFFl/t1a6AKGKzZnSDKEmopIC0irO4KGof0k3k+VlppqF9tS2SNpu7VhNIAyQig
 DpSKadQjX3hy2MGnexDecrCgc3hzW/hlfpRfzhgXbzy8ScodEfj7ynb9TCO9Uw3b5qTX
 fXry62pZO4fzTIT35vs6NamIQlWxVTUIzCkEHng7600VnWBNPu7TB+4/xz94RPEgYxMf
 Mrz839gYo8V6psZ4z6rWjhKvMvMxsxMpW4nfAd/jZG2WsDZtUqefW7JYU/J6DZ6jTzfz
 +MzA==
X-Gm-Message-State: AOJu0YyXWZzZF9m1XSCQrc3tUHThMEHC2DslPJbsSjpc7TDQn9SlAE27
 Cj9hNXDv1XdC2Uw/EcbtbvBU1w7lZOtaNFOjteNfC7ZaQ/pXkii1Lv6g/6XQacjjT78NSbH/b6C
 cGMWDRcx5A+CPTPqA2cLJwJwCwGJUQSHfxWpoqP7MrQimLb2aLL+OKTB3rWH8PyMeueJku9sVNG
 rWt2DF+Bv7+yAE8RR+HXH2zfSxkxeo2PFD9ClW
X-Received: by 2002:a50:baeb:0:b0:56e:2e0:79d1 with SMTP id
 4fb4d7f45d1cf-5734d5973b7mr5083268a12.4.1715510988022; 
 Sun, 12 May 2024 03:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE/b5Rz7jF00tc/9QJv9/pDunoGVPiqAC++6gltrsGatOgVSx5NPjO9jaj2YCnPSBrmrlP8Q==
X-Received: by 2002:a50:baeb:0:b0:56e:2e0:79d1 with SMTP id
 4fb4d7f45d1cf-5734d5973b7mr5083251a12.4.1715510987523; 
 Sun, 12 May 2024 03:49:47 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733becfcccsm4555918a12.40.2024.05.12.03.49.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:49:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/27] Build/arch cleanups, target/i386 fixes for 2024-05-10
Date: Sun, 12 May 2024 12:49:18 +0200
Message-ID: <20240512104945.130198-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit dafec285bdbfe415ac6823abdc510e0b92c3f094:

  Merge tag 'pull-request-2024-05-10' of https://gitlab.com/thuth/qemu into staging (2024-05-10 09:41:35 +0200)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 9b089d254a5623baef01f7d0ec37331c1155f1ce:

  configs: disable emulators that require it if libfdt is not found (2024-05-10 15:45:15 +0200)

----------------------------------------------------------------
* target/i386: miscellaneous changes, mostly TCG-related
* fix --without-default-devices build
* fix --without-default-devices qtests on s390x and arm

----------------------------------------------------------------
Paolo Bonzini (27):
      target/i386: remove PCOMMIT from TCG, deprecate property
      target/i386: fix operand size for DATA16 REX.W POPCNT
      target/i386: rdpkru/wrpkru are no-prefix instructions
      target/i386: move prefetch and multi-byte UD/NOP to new decoder
      target/i386: fix feature dependency for WAITPKG
      tests/tcg: cover lzcnt/tzcnt/popcnt
      configure: quote -D options that are passed through to meson
      sh4: select correct components for no-board build
      s390x: move s390_cpu_addr2state to target/s390x/sigp.c
      s390_flic: add migration-enabled property
      s390: move css_migration_enabled from machine to css.c
      s390x: select correct components for no-board build
      tests/qtest: s390x: fix operation in a build without any boards or devices
      xen: initialize legacy backends from xen_bus_init()
      xen: register legacy backends via xen_backend_init
      i386: correctly select code in hw/i386 that depends on other components
      i386: pc: remove unnecessary MachineClass overrides
      hw/i386: split x86.c in multiple parts
      hw/i386: move rtc-reset-reinjection command out of hw/rtc
      i386: select correct components for no-board build
      tests/qtest: arm: fix operation in a build without any boards or devices
      meson: pick libfdt from common_ss when building target-specific files
      meson: move libfdt together with other dependencies
      kconfig: allow compiling out QEMU device tree code per target
      kconfig: express dependency of individual boards on libfdt
      hw/xtensa: require libfdt
      configs: disable emulators that require it if libfdt is not found

 docs/about/deprecated.rst                |    8 +
 configure                                |    2 +-
 configs/targets/aarch64-softmmu.mak      |    1 +
 configs/targets/arm-softmmu.mak          |    1 +
 configs/targets/i386-softmmu.mak         |    1 -
 configs/targets/loongarch64-softmmu.mak  |    1 +
 configs/targets/microblaze-softmmu.mak   |    1 +
 configs/targets/microblazeel-softmmu.mak |    1 +
 configs/targets/mips64el-softmmu.mak     |    1 -
 configs/targets/or1k-softmmu.mak         |    1 +
 configs/targets/ppc-softmmu.mak          |    1 -
 configs/targets/ppc64-softmmu.mak        |    1 +
 configs/targets/riscv32-softmmu.mak      |    1 +
 configs/targets/riscv64-softmmu.mak      |    1 +
 configs/targets/rx-softmmu.mak           |    1 +
 configs/targets/x86_64-softmmu.mak       |    1 -
 meson.build                              |  100 +--
 include/hw/i386/x86.h                    |   10 +-
 include/hw/rtc/mc146818rtc.h             |    2 +-
 include/hw/s390x/css.h                   |    6 +
 include/hw/s390x/s390-virtio-ccw.h       |    7 -
 include/hw/s390x/s390_flic.h             |    1 +
 include/hw/xen/xen-legacy-backend.h      |   14 +-
 include/hw/xen/xen_pvdev.h               |    1 -
 include/monitor/hmp.h                    |    1 +
 include/sysemu/device_tree.h             |    1 -
 target/i386/cpu.h                        |    2 -
 target/i386/tcg/decode-new.h             |    1 +
 hw/9pfs/xen-9p-backend.c                 |    8 +-
 hw/display/xenfb.c                       |    8 +-
 hw/i386/fw_cfg.c                         |    2 +
 hw/i386/monitor.c                        |   46 ++
 hw/i386/pc.c                             |    4 -
 hw/i386/x86-common.c                     | 1007 ++++++++++++++++++++++++++++
 hw/i386/x86-cpu.c                        |   97 +++
 hw/i386/x86.c                            | 1058 +-----------------------------
 hw/intc/ioapic-stub.c                    |   29 +
 hw/intc/s390_flic.c                      |    6 +-
 hw/rtc/mc146818rtc.c                     |   12 +-
 hw/s390x/css.c                           |   10 +-
 hw/s390x/s390-virtio-ccw.c               |   32 +-
 hw/usb/xen-usb.c                         |   14 +-
 hw/xen/xen-bus.c                         |    4 +
 hw/xen/xen-hvm-common.c                  |    2 -
 hw/xen/xen-legacy-backend.c              |   16 -
 hw/xenpv/xen_machine_pv.c                |    5 +-
 hw/xtensa/xtfpga.c                       |    9 -
 monitor/hmp-cmds.c                       |   17 +
 system/device_tree-stub.c                |   10 +
 system/device_tree.c                     |   14 -
 target/i386/cpu.c                        |    6 +-
 target/i386/tcg/translate.c              |   65 +-
 target/s390x/sigp.c                      |   17 +
 tests/qtest/arm-cpu-features.c           |    4 +
 tests/qtest/drive_del-test.c             |    7 +-
 tests/qtest/migration-test.c             |    6 +
 tests/qtest/numa-test.c                  |    4 +
 tests/tcg/i386/test-i386.c               |   25 +
 target/i386/tcg/decode-new.c.inc         |   24 +-
 target/i386/tcg/emit.c.inc               |    5 +
 .gitlab-ci.d/buildtest.yml               |    9 +-
 Kconfig.host                             |    3 +
 hw/arm/Kconfig                           |    5 +
 hw/arm/meson.build                       |    2 +-
 hw/core/Kconfig                          |    9 +-
 hw/core/meson.build                      |    2 +-
 hw/i386/Kconfig                          |    3 +-
 hw/i386/meson.build                      |    7 +-
 hw/intc/meson.build                      |    2 +-
 hw/loongarch/Kconfig                     |    3 +-
 hw/loongarch/meson.build                 |    2 +-
 hw/mips/Kconfig                          |    3 +-
 hw/mips/meson.build                      |    2 +-
 hw/openrisc/Kconfig                      |    2 +
 hw/openrisc/meson.build                  |    4 +-
 hw/ppc/Kconfig                           |   15 +-
 hw/ppc/meson.build                       |    4 +-
 hw/riscv/Kconfig                         |    4 +
 hw/riscv/meson.build                     |    2 +-
 hw/rx/Kconfig                            |    3 +-
 hw/sh4/meson.build                       |    2 +-
 hw/xtensa/Kconfig                        |    3 +-
 system/meson.build                       |    4 +-
 target/arm/Kconfig                       |    2 +
 target/i386/Kconfig                      |    1 +
 target/microblaze/Kconfig                |    1 +
 target/openrisc/Kconfig                  |    1 +
 target/riscv/Kconfig                     |    2 +
 target/s390x/Kconfig                     |    2 +
 target/sh4/Kconfig                       |    2 +
 90 files changed, 1515 insertions(+), 1334 deletions(-)
 create mode 100644 hw/i386/monitor.c
 create mode 100644 hw/i386/x86-common.c
 create mode 100644 hw/i386/x86-cpu.c
 create mode 100644 hw/intc/ioapic-stub.c
 create mode 100644 system/device_tree-stub.c
-- 
2.45.0


