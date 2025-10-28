Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605CFCCF9F3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnas-0005vH-E7; Tue, 28 Oct 2025 13:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnar-0005uq-D8
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnal-0004PH-Ns
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wms4Gze1viabhZ9tfk2H3M5/wYClg+RbIkt2p9+fuSk=;
 b=YhnD8SPZ89Z8hrHssMaPKfzsicAxvcPJaZVLdJS8sIqx7w0kWtzmcBPWQrWzt1kW8xfex9
 2Xl158fQLTPNCAgrYKoFS5py5WTN2F1I6hnklS1YsFOF8/tsa4Fs33XwybgByBZbsRC6fY
 KEAlj449cS0Ty6qb9lBjqG6d4jX9Pac=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-zhN0hVq-O9a1HC-3J7iyDQ-1; Tue, 28 Oct 2025 13:34:36 -0400
X-MC-Unique: zhN0hVq-O9a1HC-3J7iyDQ-1
X-Mimecast-MFC-AGG-ID: zhN0hVq-O9a1HC-3J7iyDQ_1761672875
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42992cb2ee8so2237487f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672874; x=1762277674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wms4Gze1viabhZ9tfk2H3M5/wYClg+RbIkt2p9+fuSk=;
 b=AshLtTURJBBqgOyjC4sw3i49/mBjA9GEiwE/+pTqvKnVHq1bXnXpEdVd6nGolz+cOX
 X2/URRXOqz/1Nly2880QTQKOvNde+lAqke3jCFC4pBPWES4zcdnPIMLzkp4oPHClB3Lm
 AMGRSaHEt/vJUfQXYWFybj8NsRMmQr9dVzEcRNqjhS7bLpqMggkIGtPPragKcwDdcwOV
 q/jSrTykku5oegrV2FYrmaadgfZSOmT3gJuoQNwZeEcEe2fNC8k01AtXQPinZXiYzX1i
 6SZNRlxvdwUE09BeZmy3B78zU92WTpLaPViSfo9FHC6dJQlu/IHeGpWNOso620/VqUOt
 dKZg==
X-Gm-Message-State: AOJu0Yz3q1ds+KC6xPxmwcRyyPeVzL1+MFvlu7XtTOHXQ9AFAVkd9FgD
 Pm8WaRl3XGCWTmYQz2mTeITFPs8DyOF+HFh/UljJNawJgxwAmN4L5yRskpO2ARTDtzTuDTpPlAZ
 w84NVL45hPdQ6L+QwkIeFBbk3kq0a+VJXTUbgEhJ03S/9u1znMzgjSQb+5iLHIEjS2sbOPUi1Wj
 eoafenQ62tmrhGUsYo2mv2KdOTDQHwV4PRdcqxxlyK
X-Gm-Gg: ASbGncttYW8CFEu40Nd9k26q2Q6+SfuZR6Jpn3GQCLZGxCt9Gm2Ad1c81gLplWb2CUP
 Jd3JWT1nU5GVt9Criw75wUkjCBKdk3J4FFqQSOVbpN8nAIQVhE1lOqcJbehpwWUB/kLcIeoezTS
 B4pSydLbhoJ6h7/+2sxEUlP1LLJxeNv4ljpmxRmdiLiod6sRqBRp3CF+1fbhaONOVGEHqBTanyq
 k+rizuUX19oF41htw/xBKP10pP2XP9Ycw3lg9LpjWL849kpLDya/212v0vZAK3tfaYNqNAaD8av
 Nv56I0c8AmiFeqHbBmIoHWft3Fb48e/Mfmh5LLI3uHPf17zrGEde+2Tag37dBVbGeYyhZe/xLU8
 cn8KRjyYQrFyhsatHpzHlFtLOzAvPoi6xdUWN5oqdClABzBe6ZpFdEElhQa/J0MbzS77cWafItI
 k1Q00=
X-Received: by 2002:a5d:5d01:0:b0:3ec:42ad:591 with SMTP id
 ffacd0b85a97d-429a7e7c7e1mr4375157f8f.36.1761672873824; 
 Tue, 28 Oct 2025 10:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLCGJPFxgqc4G2YCY6rKfcAJPX66a1+F8y3EQ5lUnygkQJyv/R0FmTyfyi4vd1Z+SMSFhMrg==
X-Received: by 2002:a5d:5d01:0:b0:3ec:42ad:591 with SMTP id
 ffacd0b85a97d-429a7e7c7e1mr4375115f8f.36.1761672873143; 
 Tue, 28 Oct 2025 10:34:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e235ae1sm4229325e9.17.2025.10.28.10.34.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:34:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] Miscellaneous changes for 2025-10-28
Date: Tue, 28 Oct 2025 18:34:12 +0100
Message-ID: <20251028173430.2180057-1-pbonzini@redhat.com>
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
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

for you to fetch changes up to d77cb7d68dacb696900ca83d03e4d50735e45e5f:

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
 roms/opensbi                         |   2 +-
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


