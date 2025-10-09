Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88ACCCCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQC-0008AI-2Q; Thu, 09 Oct 2025 03:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQ9-00089m-Dg
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQ4-0004JA-D3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eGAQrIfPghrF8Y9k90GmQZxemesTKOLpHp39boAZMHo=;
 b=WgDEFE/iiPol1JWkDtTVkk5osktu7Mr2R8wHfmCRG18zkVG+ITzi1QZFHae7DNYrbFOgu1
 rC7OLkLLBFt7/MZh/h6U1/V3fAOXIJCIeENhOwcwE7EGb/ZDDXIp7sa4J8+fQfAxje0obt
 JaXWPeRsCyFfGDJBY1Mu0k/5hDd2HKM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-V3Q40afcOsKyyF2uOkCZDw-1; Thu, 09 Oct 2025 03:50:29 -0400
X-MC-Unique: V3Q40afcOsKyyF2uOkCZDw-1
X-Mimecast-MFC-AGG-ID: V3Q40afcOsKyyF2uOkCZDw_1759996229
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3efe4fcc9ccso558296f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996228; x=1760601028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eGAQrIfPghrF8Y9k90GmQZxemesTKOLpHp39boAZMHo=;
 b=m7D+V+6kjAY9AHNwne3QVBYs1VAHXrQVUSR4YzBVH3Rpvm8khtgGxK3uiaMTncUe52
 6mUAj0MEkpX5P+QF+edqBrTS/YOt1/wjJRxq5SXpWPDPBvqdgssF6G/znUGEhnny4YC6
 vubbeXOnIRnL0Hi6+Hlvxd7HxvuZ/sAsvTWQ0w7ElpnzCyJWjkTyfWVMZDU7XIsBuxs2
 arZRVKqyGmw1KpLA5drxmtNkTrFNaPgZo4rqKP3rBBPfHeF9mTvtmknKRpLTcVz2SW2A
 IO0wKYX5asp1fMsYGTg5/5Bqd2jBe7ubmPFJlBuuVt4+pcepKhahthzq8q89DlsVwna/
 3OhQ==
X-Gm-Message-State: AOJu0Yx3GQhlJpWXMTuwbpLm5Y9NNblhPXJf/4Z8xzCTVp6HIV4BAYh1
 4B7flhDmkUCqje5J0MkSqHe/PQMcUm7nB9vgzfSRlilvn+O6kqATKjTN7raLN0kIcKkMuyfLhhe
 bjz3icfdFxJhovbOO7fgKDtA1JMMQ13upGVF9aDahmeKqyqvL2+9tenC8Jx6cjJw1eu3yptzKyj
 3pGGv8Z6EyVWJ1afalqaDdiohtRFglCsscDLlaHQ8QeRs=
X-Gm-Gg: ASbGncvF4CW0kfNC8C8LcZPrbMQ+HHyV/eEmDh/nKE6qOYTRcUFcrd3SGZ6l2g19Zij
 i7eRIoWmWW+g0El1iRb2SZ/csmI9hECWsPppUcT8fUTuYMQrnBSDZUcAAif272g2Gcv9s0xMhuk
 bqi7vjmzquEhKrYm6JSsz72ya4PdQWnXJcNKctS0VSQ+75xVTx+Br+/aoEtB/7h/YpdDSbM2HBd
 uQs4dCfC9O6pJrU/bbTVKDpCl5NkILgfe6V4wXjKS8Q+MBw+9f2CHK16LCOL19y60FoG8Xs6i9v
 TNyg554SVh62Pe5f4T5ZSiVppAl8C47xCwdGNYYUSEx9z3WPH9rQwsoqiAmnrYyRIF5wrmq6YxA
 fWamSsiWUtLvqvDiqRphq74Kq0G8LJC7sjUT5wkvoXthU5k92
X-Received: by 2002:a05:6000:4382:b0:424:21d8:de30 with SMTP id
 ffacd0b85a97d-4266e8e90eamr4189718f8f.62.1759996227950; 
 Thu, 09 Oct 2025 00:50:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJmnh6KrKnvtR/eS8VwMS4RF6RFnusGTZNqIhe0YnC0KGYZVZSseP6+qzm1pKhMKxZNqjlJg==
X-Received: by 2002:a05:6000:4382:b0:424:21d8:de30 with SMTP id
 ffacd0b85a97d-4266e8e90eamr4189696f8f.62.1759996227296; 
 Thu, 09 Oct 2025 00:50:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d869d50sm34367739f8f.0.2025.10.09.00.50.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:50:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/35] i386 (MSHV, migration) and Rust changes for 2025-10-09
Date: Thu,  9 Oct 2025 09:49:50 +0200
Message-ID: <20251009075026.505715-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 517e9b4862cc9798b7a24b1935d94c2f96787f12:

  Merge tag 'qtest-20251001-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-10-01 15:03:00 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to b9ef6198d709f431d893d1b5525cdf7fd7a3e11b:

  rust: fix path to rust_root_crate.sh (2025-10-09 09:48:35 +0200)

----------------------------------------------------------------
* i386: fix migration issues in 10.1
* target/i386/mshv: new accelerator
* rust: use glib-sys-rs
* rust: fixes for docker tests

----------------------------------------------------------------
Hector Cao (1):
      target/i386: add compatibility property for pdcm feature

Magnus Kulke (26):
      accel: Add Meson and config support for MSHV accelerator
      target/i386/emulate: Allow instruction decoding from stream
      target/i386/mshv: Add x86 decoder/emu implementation
      hw/intc: Generalize APIC helper names from kvm_* to accel_*
      include/hw/hyperv: Add MSHV ABI header definitions
      linux-headers/linux: Add mshv.h headers
      accel/mshv: Add accelerator skeleton
      accel/mshv: Register memory region listeners
      accel/mshv: Initialize VM partition
      accel/mshv: Add vCPU creation and execution loop
      accel/mshv: Add vCPU signal handling
      target/i386/mshv: Add CPU create and remove logic
      target/i386/mshv: Implement mshv_store_regs()
      target/i386/mshv: Implement mshv_get_standard_regs()
      target/i386/mshv: Implement mshv_get_special_regs()
      target/i386/mshv: Implement mshv_arch_put_registers()
      target/i386/mshv: Set local interrupt controller state
      target/i386/mshv: Register CPUID entries with MSHV
      target/i386/mshv: Register MSRs with MSHV
      target/i386/mshv: Integrate x86 instruction decoder/emulator
      target/i386/mshv: Write MSRs to the hypervisor
      target/i386/mshv: Implement mshv_vcpu_run()
      accel/mshv: Handle overlapping mem mappings
      target/i386/mshv: Use preallocated page for hvcall
      docs: Add mshv to documentation
      MAINTAINERS: Add maintainers for mshv accelerator

Marc-André Lureau (4):
      subprojects: add glib-sys-rs
      rust: use glib-sys
      build-sys: default to host vendor for rust target triple
      tests/docker: make --enable-rust overridable with EXTRA_CONFIGURE_OPTS

Paolo Bonzini (2):
      subprojects: Remove version number from .gitignore
      target/i386: add compatibility property for arch_capabilities

Praveen K Paladugu (1):
      qapi/accel: Allow to query mshv capabilities

Stefan Hajnoczi (1):
      rust: fix path to rust_root_crate.sh

 MAINTAINERS                                        |   15 +
 docs/about/build-platforms.rst                     |    2 +-
 docs/devel/codebase.rst                            |    2 +-
 docs/glossary.rst                                  |    7 +-
 docs/system/introduction.rst                       |    3 +
 configure                                          |   13 +-
 meson.build                                        |   15 +
 qapi/accelerator.json                              |   29 +
 accel/mshv/trace.h                                 |   14 +
 include/hw/core/cpu.h                              |    2 +-
 include/hw/hyperv/hvgdk.h                          |   20 +
 include/hw/hyperv/hvgdk_mini.h                     |  817 +++++++++
 include/hw/hyperv/hvhdk.h                          |  249 +++
 include/hw/hyperv/hvhdk_mini.h                     |  102 ++
 include/monitor/hmp.h                              |    1 +
 include/system/accel-irq.h                         |   37 +
 include/system/hw_accel.h                          |    1 +
 include/system/mshv.h                              |   64 +
 include/system/mshv_int.h                          |  155 ++
 linux-headers/linux/mshv.h                         |  291 ++++
 target/i386/cpu.h                                  |   16 +-
 target/i386/emulate/x86_decode.h                   |    9 +
 target/i386/emulate/x86_emu.h                      |    2 +
 accel/accel-irq.c                                  |  106 ++
 accel/mshv/irq.c                                   |  399 +++++
 accel/mshv/mem.c                                   |  563 +++++++
 accel/mshv/mshv-all.c                              |  727 ++++++++
 accel/mshv/msr.c                                   |  375 +++++
 accel/stubs/mshv-stub.c                            |   44 +
 hw/core/machine-hmp-cmds.c                         |   15 +
 hw/core/machine-qmp-cmds.c                         |   14 +
 hw/i386/pc.c                                       |    2 +
 hw/intc/apic.c                                     |    8 +
 hw/intc/ioapic.c                                   |   20 +-
 hw/virtio/virtio-pci.c                             |   21 +-
 target/i386/cpu.c                                  |   32 +-
 target/i386/emulate/x86_decode.c                   |   27 +-
 target/i386/emulate/x86_emu.c                      |    3 +-
 target/i386/kvm/kvm.c                              |    6 +-
 target/i386/mshv/mshv-cpu.c                        | 1763 ++++++++++++++++++++
 target/i386/mshv/x86.c                             |  297 ++++
 accel/Kconfig                                      |    3 +
 accel/meson.build                                  |    3 +-
 accel/mshv/meson.build                             |    9 +
 accel/mshv/trace-events                            |   33 +
 accel/stubs/meson.build                            |    1 +
 hmp-commands-info.hx                               |   13 +
 meson_options.txt                                  |    2 +
 qemu-options.hx                                    |   16 +-
 rust/Cargo.lock                                    |  180 ++
 rust/Cargo.toml                                    |    1 +
 rust/bql/Cargo.toml                                |    1 +
 rust/bql/meson.build                               |    1 +
 rust/bql/src/bindings.rs                           |    4 +
 rust/chardev/Cargo.toml                            |    1 +
 rust/chardev/meson.build                           |    2 +-
 rust/chardev/src/bindings.rs                       |    4 +
 rust/hw/char/pl011/Cargo.toml                      |    1 +
 rust/hw/char/pl011/meson.build                     |    1 +
 rust/hw/char/pl011/src/bindings.rs                 |    5 +
 rust/hw/core/Cargo.toml                            |    1 +
 rust/hw/core/meson.build                           |    2 +-
 rust/hw/core/src/bindings.rs                       |    3 +
 rust/meson.build                                   |    2 +
 rust/migration/Cargo.toml                          |    1 +
 rust/migration/meson.build                         |    2 +-
 rust/migration/src/bindings.rs                     |    1 +
 rust/qom/Cargo.toml                                |    1 +
 rust/qom/meson.build                               |    2 +-
 rust/qom/src/bindings.rs                           |    2 +
 rust/system/Cargo.toml                             |    1 +
 rust/system/meson.build                            |    2 +-
 rust/system/src/bindings.rs                        |    4 +
 rust/util/Cargo.toml                               |    1 +
 rust/util/meson.build                              |    2 +-
 rust/util/src/bindings.rs                          |    2 +
 scripts/archive-source.sh                          |    1 +
 scripts/meson-buildoptions.sh                      |    3 +
 scripts/rust/rust_root_crate.sh                    |    2 +-
 scripts/update-linux-headers.sh                    |    2 +-
 subprojects/.gitignore                             |   31 +-
 subprojects/glib-sys-0.21-rs.wrap                  |    7 +
 .../packagefiles/glib-sys-0.21-rs/meson.build      |   33 +
 target/i386/emulate/meson.build                    |    7 +-
 target/i386/meson.build                            |    2 +
 target/i386/mshv/meson.build                       |    8 +
 tests/docker/common.rc                             |    2 +-
 87 files changed, 6617 insertions(+), 79 deletions(-)
 create mode 100644 accel/mshv/trace.h
 create mode 100644 include/hw/hyperv/hvgdk.h
 create mode 100644 include/hw/hyperv/hvgdk_mini.h
 create mode 100644 include/hw/hyperv/hvhdk.h
 create mode 100644 include/hw/hyperv/hvhdk_mini.h
 create mode 100644 include/system/accel-irq.h
 create mode 100644 include/system/mshv.h
 create mode 100644 include/system/mshv_int.h
 create mode 100644 linux-headers/linux/mshv.h
 create mode 100644 accel/accel-irq.c
 create mode 100644 accel/mshv/irq.c
 create mode 100644 accel/mshv/mem.c
 create mode 100644 accel/mshv/mshv-all.c
 create mode 100644 accel/mshv/msr.c
 create mode 100644 accel/stubs/mshv-stub.c
 create mode 100644 target/i386/mshv/mshv-cpu.c
 create mode 100644 target/i386/mshv/x86.c
 create mode 100644 accel/mshv/meson.build
 create mode 100644 accel/mshv/trace-events
 create mode 100644 subprojects/glib-sys-0.21-rs.wrap
 create mode 100644 subprojects/packagefiles/glib-sys-0.21-rs/meson.build
 create mode 100644 target/i386/mshv/meson.build
-- 
2.51.0


