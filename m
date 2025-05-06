Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EF7C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKEn-0003ds-9g; Tue, 06 May 2025 11:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEk-0003d7-Q5
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEg-0001vq-MR
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n0XbkiTZH3epDC4VLuIlaa5HcbGtY15NwWA65QEFbeg=;
 b=K1yo/OnZW4ORo+s6SRf4CrijIE3qbaVfTnX1KagSOo9Ikbrdbd1ICCmD7oxsQU5bluNpUp
 dQnlDnuaEU2CF3MCvVzPOUoeWUn+QcpYr+mOUs0SIOYy+BZTnZfHJQ1k93dJHeNqKtJWrY
 MC4w28LMuJHK6rvDYvoaitXuRNXUMi0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-0f91XRjiMASnlnLZ0TJc1A-1; Tue, 06 May 2025 11:29:31 -0400
X-MC-Unique: 0f91XRjiMASnlnLZ0TJc1A-1
X-Mimecast-MFC-AGG-ID: 0f91XRjiMASnlnLZ0TJc1A_1746545370
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39c2da64df9so2595111f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545370; x=1747150170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n0XbkiTZH3epDC4VLuIlaa5HcbGtY15NwWA65QEFbeg=;
 b=J4vzzEj4JJzShSDqojlYGXPYQIdooxwjzXC0qFrnLQvhg75urKSoAL3hTFaxdlv5o7
 XEQXyzR4eBh4pAr9QS0SwkQER0f3o95HyBS9EhUznYYHOtg4jfZ2XEaUDDgOmdOKNjPe
 NSd8XRGufKMrOINx8SphWXGufKzxV/joF6I2LN1SVedt5rrGUIdP5yeQnuOjM1SVZl9J
 NTCp5vgM0f5hJtuqMN4/UyXKCpNsgI/O6iz3w/31wXltbmxLmCtLRU6v5aKr+by/RN1H
 fxmIntZdIeAJj64zQdQDeI96TrSP/yvf87XyvGUworHr8QkNDlANK2lUiWkbglBDY4V+
 eBAA==
X-Gm-Message-State: AOJu0YxYsDobZPaG2rnxx2bt7yuNNMpMWUKnPGGZ712bKbrszDAFzP73
 cb9Cf8A3r0t/v78H546qO5LaN1Ww2kpOcjR65w73OjYhEcbHJPc8ocairJFHzfD7AnHm3SNEPah
 d+1BWPxwzJIRbA6HQf3KxilkiLO+vZJ9Y3A6WLppdHCtVWp+GIkZ+WbXGn3lKRzI7xs7GLWxqiW
 TGNktyHFifTESw3k8Emej2VlukPf/ZAX6ySACc
X-Gm-Gg: ASbGncuYf6DM9qEkVCDEn3o8sVkXnEwcJW4OlBQ82VWYvG0dsDOY3THSghTWooSEfHt
 cHS5unJZ4HpS114ivdIJgdCuuLOSnwHNZYkgo5AAmDr+4XRqQ86ghVM3wX1z61xOpimDUcuADL1
 3J/vNPALHm3l3DLlJg6S4nlomlSK+1kCxXC73Q8CYFfGyOxg5owRdt3O5+0TdUSPSM8+J4ywQD4
 GE/4cKlObsT61cpozd+M156TNhjaa4ZZpsUTrFqh1ZYaQ6r9jm2brDOyAKyFreJAC0J67sYdc1F
 4ss+jX9JqLK65Ys=
X-Received: by 2002:a5d:64e6:0:b0:3a0:88e4:3d2f with SMTP id
 ffacd0b85a97d-3a0ac0caf9cmr3326269f8f.5.1746545369679; 
 Tue, 06 May 2025 08:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAdcQxRe1XHTuAGnmTrGz5JtZ/hgaFr8gHZrbbqyNhDo+4P9FLOvEX7Gf/t3H8FOX1tO0Pmg==
X-Received: by 2002:a5d:64e6:0:b0:3a0:88e4:3d2f with SMTP id
 ffacd0b85a97d-3a0ac0caf9cmr3326243f8f.5.1746545369154; 
 Tue, 06 May 2025 08:29:29 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0fe9dsm14047560f8f.71.2025.05.06.08.29.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/30] Rust, wasm changes for 2025-05-06
Date: Tue,  6 May 2025 17:28:55 +0200
Message-ID: <20250506152927.222671-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit a9e0c9c0f14e19d23443ac24c8080b4708d2eab8:

  Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/qemu into staging (2025-05-05 11:26:59 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to e6b9b79c3076777b791f72ebdbc9d37ad8005fe9:

  gitlab: Enable CI for wasm build (2025-05-06 16:02:04 +0200)

----------------------------------------------------------------
* ci: enable RISC-V cross jobs
* rust: bump minimum supported version to 1.77
* rust: enable uninlined_format_args lint
* initial Emscripten support
* small fixes

----------------------------------------------------------------
Kohei Tokunaga (15):
      target/arm/helper.c: Fix type conflict of GLib function pointers
      target/i386/cpu.c: Fix type conflict of GLib function pointers
      target/ppc: Fix type conflict of GLib function pointers
      target/s390x: Fix type conflict of GLib function pointers
      include/glib-compat.h: Poison g_list_sort and g_slist_sort
      util/cacheflush.c: Update cache flushing mechanism for Emscripten
      block: Add including of ioctl header for Emscripten build
      block: Fix type conflict of the copy_file_range stub
      include/qemu/osdep.h: Add Emscripten-specific OS dependencies
      Disable options unsupported on Emscripten
      util: exclude mmap-alloc.c from compilation target on Emscripten
      util: Add coroutine backend for emscripten
      meson: Add wasm build in build scripts
      tests: Add Dockerfile containing dependencies for Emscripten build
      gitlab: Enable CI for wasm build

Paolo Bonzini (15):
      lcitool: use newer Rust for Debian and Ubuntu
      meson, cargo: require Rust 1.77.0
      rust: use std::ffi instead of std::os::raw
      rust: let bilge use "let ... else"
      rust: qemu_api_macros: make pattern matching more readable and efficient
      rust: use MaybeUninit::zeroed() in const context
      rust: qom: fix TODO about zeroability of classes
      rust: enable clippy::ptr_cast_constness
      rust: remove offset_of replacement
      rust: replace c_str! with c"" literals
      docs: rust: update for newer minimum supported version
      target/i386/emulate: fix target_ulong format strings
      rust: clippy: enable uninlined_format_args lint
      ci: run RISC-V cross jobs by default
      docs: build-system: fix typo

 MAINTAINERS                                        |   9 ++
 docs/about/build-platforms.rst                     |  11 +-
 docs/devel/build-system.rst                        |   2 +-
 docs/devel/rust.rst                                |  38 +----
 configure                                          |   7 +
 meson.build                                        |  35 ++++-
 include/glib-compat.h                              |   7 +
 include/qemu/cacheflush.h                          |   7 +
 include/qemu/osdep.h                               |   8 +-
 include/system/os-wasm.h                           | 104 +++++++++++++
 block/file-posix.c                                 |  11 +-
 os-wasm.c                                          | 119 +++++++++++++++
 system/memory.c                                    |   2 +-
 system/physmem.c                                   |   9 +-
 system/vl.c                                        |   4 +-
 target/arm/helper.c                                |   4 +-
 target/i386/cpu.c                                  |  11 +-
 target/i386/emulate/x86_decode.c                   |   2 +-
 target/i386/emulate/x86_emu.c                      |   2 +-
 target/ppc/cpu_init.c                              |   4 +-
 target/s390x/cpu_models.c                          |   4 +-
 util/cacheflush.c                                  |   4 +
 util/coroutine-wasm.c                              | 127 ++++++++++++++++
 util/oslib-posix.c                                 |  28 ++++
 .gitlab-ci.d/buildtest-template.yml                |  27 ++++
 .gitlab-ci.d/buildtest.yml                         |   9 ++
 .gitlab-ci.d/container-cross.yml                   |   8 +-
 .gitlab-ci.d/crossbuilds.yml                       |   5 -
 backends/meson.build                               |   6 +-
 configs/meson/emscripten.txt                       |   8 +
 meson_options.txt                                  |   2 +-
 qemu-options.hx                                    |   4 +-
 rust/Cargo.lock                                    |   1 -
 rust/Cargo.toml                                    |   7 +-
 rust/clippy.toml                                   |   3 +-
 rust/hw/char/pl011/src/device.rs                   |   4 +-
 rust/hw/char/pl011/src/device_class.rs             |  13 +-
 rust/hw/char/pl011/src/lib.rs                      |   6 +-
 rust/hw/timer/hpet/src/fw_cfg.rs                   |   6 +-
 rust/hw/timer/hpet/src/hpet.rs                     |  28 ++--
 rust/hw/timer/hpet/src/lib.rs                      |   4 +-
 rust/qemu-api-macros/src/lib.rs                    | 123 ++++++---------
 rust/qemu-api/Cargo.toml                           |   3 -
 rust/qemu-api/build.rs                             |  11 +-
 rust/qemu-api/meson.build                          |   5 -
 rust/qemu-api/src/c_str.rs                         |  61 --------
 rust/qemu-api/src/cell.rs                          |   6 +-
 rust/qemu-api/src/chardev.rs                       |   5 +-
 rust/qemu-api/src/irq.rs                           |   6 +-
 rust/qemu-api/src/lib.rs                           |   7 +-
 rust/qemu-api/src/memory.rs                        |   3 +-
 rust/qemu-api/src/offset_of.rs                     | 168 ---------------------
 rust/qemu-api/src/qdev.rs                          |   9 +-
 rust/qemu-api/src/qom.rs                           |  14 +-
 rust/qemu-api/src/timer.rs                         |   4 +-
 rust/qemu-api/src/vmstate.rs                       |  14 +-
 rust/qemu-api/src/zeroable.rs                      | 106 +++----------
 rust/qemu-api/tests/tests.rs                       |  11 +-
 rust/qemu-api/tests/vmstate_tests.rs               |  27 ++--
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |   2 +-
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |   2 +-
 scripts/meson-buildoptions.sh                      |   2 +-
 subprojects/bilge-impl-0.2-rs.wrap                 |   1 -
 subprojects/packagefiles/bilge-impl-1.63.0.patch   |  45 ------
 tests/docker/dockerfiles/debian-amd64-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-i686-cross.docker  |   2 +-
 .../dockerfiles/debian-mips64el-cross.docker       |   2 +-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   2 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |   2 +-
 tests/docker/dockerfiles/debian.docker             |   2 +-
 tests/docker/dockerfiles/emsdk-wasm32-cross.docker | 145 ++++++++++++++++++
 tests/docker/dockerfiles/ubuntu2204.docker         |   3 +-
 tests/lcitool/mappings.yml                         |   5 +
 tests/lcitool/refresh                              |   5 +-
 util/meson.build                                   |   4 +-
 78 files changed, 861 insertions(+), 654 deletions(-)
 create mode 100644 include/system/os-wasm.h
 create mode 100644 os-wasm.c
 create mode 100644 util/coroutine-wasm.c
 create mode 100644 configs/meson/emscripten.txt
 delete mode 100644 rust/qemu-api/src/c_str.rs
 delete mode 100644 rust/qemu-api/src/offset_of.rs
 delete mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch
 create mode 100644 tests/docker/dockerfiles/emsdk-wasm32-cross.docker
-- 
2.49.0


