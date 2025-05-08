Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEC8C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2DK-00030B-JF; Thu, 08 May 2025 10:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uD2DI-0002zY-KJ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:27:05 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uD2DE-0002zA-5t
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:27:04 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f7ec0e4978so1966016a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746714417; x=1747319217; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGAAwCSLh7XxEj5v0dAOYkTWdB2BbR7UFw2KrucA28A=;
 b=SEXB4byRWnxHEOkBcjni2X56xDTVGNsRAIbh/MT/ghf4WH+TNsOiUSlqHGbA0Lrzxr
 oYAvqMaiSkBYKp5k4QHseZJ2p6ivX0djOVRAde9vbuwEtsiG1x87EOtLQngr+fTUkQPB
 h3OqPpPHoFwW59/7BZ0Q/4YX6RevEfiEVglxlMiFcRpVC8+nEWUuN8PB70rWAMO4/MxB
 kDG5wpSx5vX1Mk/K9pyxpOo0IQjusGyYV0D1SypJB/JImwAGGBHSCBWiKY0YY2xuBbE3
 FT7WOAsEKvWu6Ww4hPENmsCLKRUTG2ujEEPdiJ2rFVDQiQj6LvnT9+sPBVx54UZ4Iyk6
 aoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746714417; x=1747319217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGAAwCSLh7XxEj5v0dAOYkTWdB2BbR7UFw2KrucA28A=;
 b=eUsavxHdt4XyGJbsR9TtRy56Va/pGoNsj+zGSvcw/fXtQUCkLqylsPQ4vYlPHDbm+E
 wh8FfaqERD+wnjZRbELPEhu1PzVB9Aeu3eRYKPyvyh8++oIyrsNdfuSwZpAsVkqHIq80
 DUIIjeeCLAWDK18G8+SwD/Ds/nmv9uYA1ynLRmA3ylu24ir1xrup3vtDVDnDSpUWFUvJ
 6Ju+AW0hKvkM47aa0UhuqWMLuCPJmiF8g7KLzoB1IkOMzExXOWO0dPEpPQ60g7kfsi1D
 n1A/sqOOZ4c/xlLLw1RSdkNwaUqK9f5ybezuZP3LNiFZJ7yrHUtCpRlhzBy94xYPrG7K
 Rfnw==
X-Gm-Message-State: AOJu0YzS791EPHDf19tMl87aNbVNV3RieN/ha3zcltJBFE1KAH7HWZb4
 l8piAKG68YR+Mxjll0TyLuIaI3CdmgA/WrMq2M6GkfJij70M3B30OttPaPO8H7w3MSkeCZddTHc
 iZxhsD9PDkBPlggrXlj1rY6cu6BuRw1o7DuA=
X-Gm-Gg: ASbGnctNKYpn3IuwbZd83HJGf/9n8+UAqaCvDVfB3Kp34yOJvrnTRNRIfjE2rCbn5vH
 KxKanj7Stw3+gWYCV2lIFuM/IRc5p/QkZCwvLMbpGR2lNEZSIY64p0qxnNbMG2OYQw71fTyulpD
 t9kTmpTyDIHPfPOZgsOOgd
X-Google-Smtp-Source: AGHT+IFl3Fums/2gVdQIi3sYwEmFSKfuW6vpIuQAfxVDoboLtutuRakZVGPSJWGEIFHgn77s9iymy7425szuZ537E5A=
X-Received: by 2002:a05:6402:524b:b0:5fb:d4a5:a3c2 with SMTP id
 4fb4d7f45d1cf-5fbe9df633emr6550089a12.10.1746714416829; Thu, 08 May 2025
 07:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250506152927.222671-1-pbonzini@redhat.com>
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 8 May 2025 10:26:44 -0400
X-Gm-Features: ATxdqUFeaQWCSesXICDRG_d3bxph-R8wUcEezN_N1nI5tFJVGfLX1fwriFJ0M3E
Message-ID: <CAJSP0QX0wL1qJzfMoH6Di+QY3K9ML3HTLeY2gXZHNNJm_jDTTQ@mail.gmail.com>
Subject: Re: [PULL 00/30] Rust, wasm changes for 2025-05-06
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, May 6, 2025 at 11:30=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> The following changes since commit a9e0c9c0f14e19d23443ac24c8080b4708d2ea=
b8:
>
>   Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/qemu in=
to staging (2025-05-05 11:26:59 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to e6b9b79c3076777b791f72ebdbc9d37ad8005fe9:
>
>   gitlab: Enable CI for wasm build (2025-05-06 16:02:04 +0200)
>
> ----------------------------------------------------------------
> * ci: enable RISC-V cross jobs
> * rust: bump minimum supported version to 1.77
> * rust: enable uninlined_format_args lint
> * initial Emscripten support
> * small fixes

I'm not sure why, but the following CI failure seems to be caused by
this pull request:
https://gitlab.com/qemu-project/qemu/-/jobs/9974291215#L4684

Please take a look, thanks!

Stefan

>
> ----------------------------------------------------------------
> Kohei Tokunaga (15):
>       target/arm/helper.c: Fix type conflict of GLib function pointers
>       target/i386/cpu.c: Fix type conflict of GLib function pointers
>       target/ppc: Fix type conflict of GLib function pointers
>       target/s390x: Fix type conflict of GLib function pointers
>       include/glib-compat.h: Poison g_list_sort and g_slist_sort
>       util/cacheflush.c: Update cache flushing mechanism for Emscripten
>       block: Add including of ioctl header for Emscripten build
>       block: Fix type conflict of the copy_file_range stub
>       include/qemu/osdep.h: Add Emscripten-specific OS dependencies
>       Disable options unsupported on Emscripten
>       util: exclude mmap-alloc.c from compilation target on Emscripten
>       util: Add coroutine backend for emscripten
>       meson: Add wasm build in build scripts
>       tests: Add Dockerfile containing dependencies for Emscripten build
>       gitlab: Enable CI for wasm build
>
> Paolo Bonzini (15):
>       lcitool: use newer Rust for Debian and Ubuntu
>       meson, cargo: require Rust 1.77.0
>       rust: use std::ffi instead of std::os::raw
>       rust: let bilge use "let ... else"
>       rust: qemu_api_macros: make pattern matching more readable and effi=
cient
>       rust: use MaybeUninit::zeroed() in const context
>       rust: qom: fix TODO about zeroability of classes
>       rust: enable clippy::ptr_cast_constness
>       rust: remove offset_of replacement
>       rust: replace c_str! with c"" literals
>       docs: rust: update for newer minimum supported version
>       target/i386/emulate: fix target_ulong format strings
>       rust: clippy: enable uninlined_format_args lint
>       ci: run RISC-V cross jobs by default
>       docs: build-system: fix typo
>
>  MAINTAINERS                                        |   9 ++
>  docs/about/build-platforms.rst                     |  11 +-
>  docs/devel/build-system.rst                        |   2 +-
>  docs/devel/rust.rst                                |  38 +----
>  configure                                          |   7 +
>  meson.build                                        |  35 ++++-
>  include/glib-compat.h                              |   7 +
>  include/qemu/cacheflush.h                          |   7 +
>  include/qemu/osdep.h                               |   8 +-
>  include/system/os-wasm.h                           | 104 +++++++++++++
>  block/file-posix.c                                 |  11 +-
>  os-wasm.c                                          | 119 +++++++++++++++
>  system/memory.c                                    |   2 +-
>  system/physmem.c                                   |   9 +-
>  system/vl.c                                        |   4 +-
>  target/arm/helper.c                                |   4 +-
>  target/i386/cpu.c                                  |  11 +-
>  target/i386/emulate/x86_decode.c                   |   2 +-
>  target/i386/emulate/x86_emu.c                      |   2 +-
>  target/ppc/cpu_init.c                              |   4 +-
>  target/s390x/cpu_models.c                          |   4 +-
>  util/cacheflush.c                                  |   4 +
>  util/coroutine-wasm.c                              | 127 +++++++++++++++=
+
>  util/oslib-posix.c                                 |  28 ++++
>  .gitlab-ci.d/buildtest-template.yml                |  27 ++++
>  .gitlab-ci.d/buildtest.yml                         |   9 ++
>  .gitlab-ci.d/container-cross.yml                   |   8 +-
>  .gitlab-ci.d/crossbuilds.yml                       |   5 -
>  backends/meson.build                               |   6 +-
>  configs/meson/emscripten.txt                       |   8 +
>  meson_options.txt                                  |   2 +-
>  qemu-options.hx                                    |   4 +-
>  rust/Cargo.lock                                    |   1 -
>  rust/Cargo.toml                                    |   7 +-
>  rust/clippy.toml                                   |   3 +-
>  rust/hw/char/pl011/src/device.rs                   |   4 +-
>  rust/hw/char/pl011/src/device_class.rs             |  13 +-
>  rust/hw/char/pl011/src/lib.rs                      |   6 +-
>  rust/hw/timer/hpet/src/fw_cfg.rs                   |   6 +-
>  rust/hw/timer/hpet/src/hpet.rs                     |  28 ++--
>  rust/hw/timer/hpet/src/lib.rs                      |   4 +-
>  rust/qemu-api-macros/src/lib.rs                    | 123 ++++++---------
>  rust/qemu-api/Cargo.toml                           |   3 -
>  rust/qemu-api/build.rs                             |  11 +-
>  rust/qemu-api/meson.build                          |   5 -
>  rust/qemu-api/src/c_str.rs                         |  61 --------
>  rust/qemu-api/src/cell.rs                          |   6 +-
>  rust/qemu-api/src/chardev.rs                       |   5 +-
>  rust/qemu-api/src/irq.rs                           |   6 +-
>  rust/qemu-api/src/lib.rs                           |   7 +-
>  rust/qemu-api/src/memory.rs                        |   3 +-
>  rust/qemu-api/src/offset_of.rs                     | 168 ---------------=
------
>  rust/qemu-api/src/qdev.rs                          |   9 +-
>  rust/qemu-api/src/qom.rs                           |  14 +-
>  rust/qemu-api/src/timer.rs                         |   4 +-
>  rust/qemu-api/src/vmstate.rs                       |  14 +-
>  rust/qemu-api/src/zeroable.rs                      | 106 +++----------
>  rust/qemu-api/tests/tests.rs                       |  11 +-
>  rust/qemu-api/tests/vmstate_tests.rs               |  27 ++--
>  scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |   2 +-
>  scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |   2 +-
>  scripts/meson-buildoptions.sh                      |   2 +-
>  subprojects/bilge-impl-0.2-rs.wrap                 |   1 -
>  subprojects/packagefiles/bilge-impl-1.63.0.patch   |  45 ------
>  tests/docker/dockerfiles/debian-amd64-cross.docker |   2 +-
>  tests/docker/dockerfiles/debian-arm64-cross.docker |   2 +-
>  tests/docker/dockerfiles/debian-armhf-cross.docker |   2 +-
>  tests/docker/dockerfiles/debian-i686-cross.docker  |   2 +-
>  .../dockerfiles/debian-mips64el-cross.docker       |   2 +-
>  .../docker/dockerfiles/debian-mipsel-cross.docker  |   2 +-
>  .../docker/dockerfiles/debian-ppc64el-cross.docker |   2 +-
>  tests/docker/dockerfiles/debian-s390x-cross.docker |   2 +-
>  tests/docker/dockerfiles/debian.docker             |   2 +-
>  tests/docker/dockerfiles/emsdk-wasm32-cross.docker | 145 +++++++++++++++=
+++
>  tests/docker/dockerfiles/ubuntu2204.docker         |   3 +-
>  tests/lcitool/mappings.yml                         |   5 +
>  tests/lcitool/refresh                              |   5 +-
>  util/meson.build                                   |   4 +-
>  78 files changed, 861 insertions(+), 654 deletions(-)
>  create mode 100644 include/system/os-wasm.h
>  create mode 100644 os-wasm.c
>  create mode 100644 util/coroutine-wasm.c
>  create mode 100644 configs/meson/emscripten.txt
>  delete mode 100644 rust/qemu-api/src/c_str.rs
>  delete mode 100644 rust/qemu-api/src/offset_of.rs
>  delete mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch
>  create mode 100644 tests/docker/dockerfiles/emsdk-wasm32-cross.docker
> --
> 2.49.0
>
>

