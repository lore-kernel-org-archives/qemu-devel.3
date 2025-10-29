Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686DFCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2T6-0008Lc-Um; Wed, 29 Oct 2025 05:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vE2Sw-0008Kn-Fk
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vE2Sr-0006bi-VM
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761730050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NT3Wwqo8v/KQ6ymvAfleFYYKoTxK97AxemN7fydw3hY=;
 b=hTsDbS48I3+OrsKmv/ROg/kzmB4y+oZkXj2zwrsfFDiHa7hwkoVg9WIIpkCzDxpuIvFJlt
 C3kv3cpNoutNBmqbmdfco8Vf4xLJSd/BDU9F0VYqid76wM+s/MMvI729bGAIJ3UIkxlUdk
 f1kh2Rn0tPHf+EkPtUvx0MxjmVD2Z7M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-3wIsFyCoMK-wEdMAKEDdEA-1; Wed, 29 Oct 2025 05:27:28 -0400
X-MC-Unique: 3wIsFyCoMK-wEdMAKEDdEA-1
X-Mimecast-MFC-AGG-ID: 3wIsFyCoMK-wEdMAKEDdEA_1761730047
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4770c37331fso22044015e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 02:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761730046; x=1762334846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NT3Wwqo8v/KQ6ymvAfleFYYKoTxK97AxemN7fydw3hY=;
 b=eCzWMcSIX+XaNB4q2Wy30Ri5HlZK+Xbx1FPl7098OCp8SwqMol4Zq/xTOx6T4TZPsb
 C4vembFphKm5PzNUHSMm/K+zpd5osI7mHfyVp8CLyIS5bPgUulTZr+KODKtyHpp+44gO
 pJrP2VDL5uHxTyhvOkiuKQ7DAgYsk9Ez+13cAqPaBihWl6tZ5JA02MRfG1PAbu0TsPPm
 1Cobxsow8UPrOhpQnewemXdZifc/qkJwwhaYW94iic5i7dTRJG1/hC0rOeGD/SbosDhW
 X6ms2viGfUxvlDX/m+0xDUZTTR9KUaq150/sQuEPfjmJJIZNl5Tf9hKe8VUaJgXje+v2
 lpMw==
X-Gm-Message-State: AOJu0Yyqv9Gl6Y2R5L3WbDgHvTd04C6YitU0V5Wl+SzLR//faILcWwhA
 +KwlGBMkCAuCKRvVwHSkLUTjEtqgiHLci5doiPeTdIbzeNsES6r187Ib//ZhEOa/vo4T0pY2udi
 srDrfH1ok9+4KtiyQDAFwz1IP1sjpNCLEGQ1bya8sxlfMieeYz2msYfDTB+S1wLGWbBxI5ph6n7
 bBR2EoGktHeS0WouMOKNlr5nONybHI5JhBofnU/9tu
X-Gm-Gg: ASbGnctJfSNII/eIXVIZ7xQzohPRMkumKbsWO29L1m8wgxcw62mM98NvrYsqLqHUl49
 S1IIaHqNps1wzA8xi30hHLDiC6HSvpEe7q2aJVbsVXje1vQ+5m/xPIq/K59/PnmgUm4xgD+YQua
 74gnkWihkcazxVVTJY5XCqZIkJQNRs5f11jdzySagTgLJf7Es5owFUBU4inP1UXW0tB2HH3Iui1
 Fp7CbVpO3y4GimE6rcA4BUvTaihgF1mTHXOXPqZajznwJDv+wFuYmfm6MW/dD8eHSm86V8VyvJ6
 QEcsw65LuM5MsCUcui8ue3F+BHtsMZ8Cod8oOYqwDMEYpfP4KCNuqQg/67bA3mVqjELnp33uDN9
 0tnPGj+70TKCvAWbuPtct3+mLJdREnIdzNneCp4oLkZyCRY7+znBj3n8g4lxsslEYpncEq+2kQ1
 Y9SB4=
X-Received: by 2002:a05:600c:6218:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-4771e3fca79mr21891645e9.34.1761730046356; 
 Wed, 29 Oct 2025 02:27:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCJZ4KNbDV6YNyy4vEkRQ+V8PIBl5os3l/QbZ3ZRCG3vNSHyZThSCpC0HnYAMmhch2fbY9pg==
X-Received: by 2002:a05:600c:6218:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-4771e3fca79mr21891175e9.34.1761730045660; 
 Wed, 29 Oct 2025 02:27:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e222895sm38093115e9.13.2025.10.29.02.27.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 02:27:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/18] Miscellaneous changes for 2025-10-28
Date: Wed, 29 Oct 2025 10:27:23 +0100
Message-ID: <20251029092724.2325904-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 36076d24f04ea9dc3357c0fbe7bb14917375819c:

  Merge tag 'next-pr-pull-request' of https://gitlab.com/berrange/qemu into staging (2025-10-25 10:42:55 +0200)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to d4fbf6ff8d12cd11d53f7baa408f50fbb0441d87:

  rust: migration: allow passing ParentField<> to vmstate_of! (2025-10-28 14:50:44 +0100)

----------------------------------------------------------------
* char: rename CharBackend->CharFrontend
* esp: fix esp_cdb_ready() FIFO wraparound limit calculation
* isapc: warn rather than reject modern x86 CPU models
* mshv: fix Coverity issues
* qdev: Change PropertyInfo method print() to return malloc'ed string
* qobject: make refcount atomic
* rcu: make synchronize_rcu() more efficient
* rust: cleanup glib_sys bindings
* rust: Convert bit value to u8 within #[property]
* rust: only leave leaf crates as workspace members
* scripts: clean up meson-buildoptions.py
* scsi: make refcount atomic
* target/i386: Init SMM cpu address space for hotplugged CPUs

----------------------------------------------------------------
v1->v2: no change other than removing spurious subproject update

Akihiko Odaki (1):
      rcu: Unify force quiescent state

Marc-André Lureau (1):
      char: rename CharBackend->CharFrontend

Mark Cave-Ayland (4):
      esp.c: fix esp_cdb_ready() FIFO wraparound limit calculation
      qtest/am53c974-test: add additional test for cmdfifo overflow
      hw/i386/isapc.c: warn rather than reject modern x86 CPU models
      docs/about/deprecated.rst: document isapc deprecation for modern x86 CPU models

Markus Armbruster (1):
      qdev: Change PropertyInfo method print() to return malloc'ed string

Martin Kletzander (1):
      rust: remove useless glib_sys bindings

Paolo Bonzini (8):
      scripts: clean up meson-buildoptions.py
      rust: only leave leaf crates as workspace members
      qobject: make refcount atomic
      accel/mshv: initialize thread name
      accel/mshv: use return value of handle_pio_str_read
      scsi: make SCSIRequest refcount atomic
      target/i386: clear CPU_INTERRUPT_SIPI for all accelerators
      rust: migration: allow passing ParentField<> to vmstate_of!

Xiaoyao Li (1):
      i386/kvm/cpu: Init SMM cpu address space for hotplugged CPUs

Zhao Liu (1):
      rust/qemu-macros: Convert bit value to u8 within #[property]

 docs/about/deprecated.rst            |  14 +++
 meson.build                          |   1 +
 chardev/chardev-internal.h           |  12 +--
 include/chardev/char-fe.h            |  67 ++++++------
 include/chardev/char.h               |   4 +-
 include/hw/char/avr_usart.h          |   2 +-
 include/hw/char/bcm2835_aux.h        |   2 +-
 include/hw/char/cadence_uart.h       |   2 +-
 include/hw/char/cmsdk-apb-uart.h     |   2 +-
 include/hw/char/digic-uart.h         |   2 +-
 include/hw/char/escc.h               |   2 +-
 include/hw/char/goldfish_tty.h       |   2 +-
 include/hw/char/ibex_uart.h          |   2 +-
 include/hw/char/imx_serial.h         |   2 +-
 include/hw/char/max78000_uart.h      |   2 +-
 include/hw/char/nrf51_uart.h         |   2 +-
 include/hw/char/parallel.h           |   2 +-
 include/hw/char/pl011.h              |   2 +-
 include/hw/char/renesas_sci.h        |   2 +-
 include/hw/char/riscv_htif.h         |   2 +-
 include/hw/char/serial.h             |   2 +-
 include/hw/char/shakti_uart.h        |   2 +-
 include/hw/char/sifive_uart.h        |   2 +-
 include/hw/char/stm32f2xx_usart.h    |   2 +-
 include/hw/char/stm32l4x5_usart.h    |   2 +-
 include/hw/misc/ivshmem-flat.h       |   2 +-
 include/hw/qdev-properties-system.h  |   2 +-
 include/hw/qdev-properties.h         |   2 +-
 include/hw/virtio/vhost-user-base.h  |   2 +-
 include/hw/virtio/vhost-user-blk.h   |   2 +-
 include/hw/virtio/vhost-user-fs.h    |   2 +-
 include/hw/virtio/vhost-user-scmi.h  |   2 +-
 include/hw/virtio/vhost-user-vsock.h |   2 +-
 include/hw/virtio/vhost-user.h       |   8 +-
 include/hw/virtio/virtio-gpu.h       |   2 +-
 include/hw/virtio/virtio-scsi.h      |   2 +-
 include/qobject/qobject.h            |   5 +-
 include/system/qtest.h               |   4 +-
 include/system/vhost-user-backend.h  |   2 +-
 monitor/monitor-internal.h           |   2 +-
 target/i386/kvm/kvm_i386.h           |   1 +
 accel/mshv/mshv-all.c                |   3 +
 backends/cryptodev-vhost-user.c      |   2 +-
 backends/rng-egd.c                   |   2 +-
 backends/tpm/tpm_emulator.c          |   4 +-
 chardev/char-fe.c                    | 144 ++++++++++++-------------
 chardev/char-hub.c                   |  18 ++--
 chardev/char-mux.c                   |  40 +++----
 chardev/char.c                       |  44 ++++----
 gdbstub/system.c                     |   2 +-
 hw/arm/strongarm.c                   |   2 +-
 hw/char/debugcon.c                   |   2 +-
 hw/char/exynos4210_uart.c            |   2 +-
 hw/char/grlib_apbuart.c              |   2 +-
 hw/char/ipoctal232.c                 |   2 +-
 hw/char/mcf_uart.c                   |   2 +-
 hw/char/sclpconsole-lm.c             |   2 +-
 hw/char/sclpconsole.c                |   2 +-
 hw/char/sh_serial.c                  |   2 +-
 hw/char/spapr_vty.c                  |   2 +-
 hw/char/terminal3270.c               |   2 +-
 hw/char/virtio-console.c             |   2 +-
 hw/char/xen_console.c                |   2 +-
 hw/char/xilinx_uartlite.c            |   2 +-
 hw/core/qdev-properties-system.c     |  23 ++--
 hw/core/qdev-properties.c            |   9 +-
 hw/hppa/machine.c                    |   2 +-
 hw/i386/isapc.c                      |  55 ++++------
 hw/i386/x86-common.c                 |  11 ++
 hw/ipmi/ipmi_bmc_extern.c            |   2 +-
 hw/mips/boston.c                     |   2 +-
 hw/mips/malta.c                      |   2 +-
 hw/misc/ivshmem-pci.c                |   2 +-
 hw/ppc/spapr_rtas.c                  |   2 +-
 hw/riscv/riscv_hart.c                |   2 +-
 hw/scsi/esp.c                        |   6 +-
 hw/scsi/scsi-bus.c                   |  13 +--
 hw/usb/ccid-card-passthru.c          |   2 +-
 hw/usb/dev-serial.c                  |   2 +-
 hw/usb/redirect.c                    |   2 +-
 hw/virtio/vhost-stub.c               |   2 +-
 hw/virtio/vhost-user.c               |  20 ++--
 net/colo-compare.c                   |  10 +-
 net/filter-mirror.c                  |   4 +-
 net/passt.c                          |   2 +-
 net/slirp.c                          |   2 +-
 net/vhost-user.c                     |   2 +-
 semihosting/console.c                |   6 +-
 system/qtest.c                       |  20 ++--
 target/hppa/sys_helper.c             |  12 +--
 target/i386/hvf/x86hvf.c             |   1 +
 target/i386/kvm/kvm.c                |   7 ++
 target/i386/mshv/mshv-cpu.c          |   4 +
 target/i386/nvmm/nvmm-all.c          |   1 +
 target/i386/whpx/whpx-all.c          |   1 +
 target/riscv/kvm/kvm-cpu.c           |  10 +-
 target/xtensa/xtensa-semi.c          |  10 +-
 tests/qtest/am53c974-test.c          |  40 +++++++
 tests/qtest/vhost-user-test.c        |  16 +--
 tests/unit/test-char.c               | 202 +++++++++++++++++------------------
 tests/unit/test-yank.c               |  12 +--
 util/rcu.c                           |  81 +++++++++-----
 rust/Cargo.toml                      |  10 --
 rust/bindings/src/lib.rs             |   4 +-
 rust/bql/src/bindings.rs             |   4 +-
 rust/chardev/src/bindings.rs         |  10 +-
 rust/chardev/src/chardev.rs          |  26 ++---
 rust/hw/char/pl011/src/bindings.rs   |   2 +-
 rust/hw/char/pl011/src/device.rs     |  12 +--
 rust/hw/core/src/bindings.rs         |   4 +-
 rust/hw/core/src/qdev.rs             |   2 +-
 rust/hw/timer/hpet/src/device.rs     |   2 +-
 rust/migration/src/bindings.rs       |   2 +-
 rust/migration/src/vmstate.rs        |   3 +-
 rust/qemu-macros/src/lib.rs          |  23 +++-
 rust/qemu-macros/src/tests.rs        |  15 ++-
 rust/qom/src/bindings.rs             |   2 +-
 rust/qom/src/qom.rs                  |   3 +-
 rust/system/src/bindings.rs          |   4 +-
 rust/util/src/bindings.rs            |   2 +-
 scripts/meson-buildoptions.py        |  51 +++++----
 122 files changed, 679 insertions(+), 573 deletions(-)
-- 
2.51.1


