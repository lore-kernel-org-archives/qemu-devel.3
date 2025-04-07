Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1592DC3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oBY-0002dO-Fs; Mon, 07 Apr 2025 11:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nkV-0001y0-Ro; Mon, 07 Apr 2025 10:46:55 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nkT-0001We-Ll; Mon, 07 Apr 2025 10:46:55 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so3481812b3a.1; 
 Mon, 07 Apr 2025 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744037211; x=1744642011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7LIdU2kK//yLHKRwtXpESmYMpQAS4hvFafVc/W+LxT4=;
 b=hWOzyr1Gk5bTWjlHxlaJDZsd97gfpLlOzrhIjmYlQ/4g+TsPyvorR+fea7uytUbQYY
 Auml8zIsHRZiTCkPP/LK9P/Mwtj5SZMz9F8FH7RUEwlR7XOCyCfTKbxueYp++mJZg/Kk
 cHgCDw30VfpENid1prkHiW5qrRALD93WVwd1aMCBsf0EoceoPW80wgBVPrdXALaIdrpk
 DRXa/vdg8WeGxIFFCkCf8n5CtyQR2DvwQJ+ABf+/fYSnNH0QINuwExUB2bVdzqFLBiqb
 dPbMmqWTez2luP3JVyN/7FDYbB2StNdUQfU45G0kaBdgrR1zJaevgR7cYSV+lBn73tw5
 FOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037211; x=1744642011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7LIdU2kK//yLHKRwtXpESmYMpQAS4hvFafVc/W+LxT4=;
 b=Sqy2itJTwlqUTC2LKE38cdDhfHkkvyZ3oLwQafxvd4wcMpmO8uMJM65Bieg9pC26WL
 eWqOW5Loj1XWmk2/5GVae1SwfEOa+pWYdrVIE6nXIsSKfoTFdoV/SRiJN2R+KINsvVWg
 6g8PFXOtt0NSTKSsN1KoLMtfPQfeIZqU5/vc0XkincaB4HcW3heuFhxONndo7E+ccNF/
 1xkCTSgsnNpAX7TDAmIjaIquqwNdJWYb4bii4Towd6fbpjGeV6Mx6y+QigoaGzLqPhDp
 RDtE6SNsn4Upm5J+hLhPCjmfaP9lIqfjpqdyGnPQuLbDjU7W5LqGn5rooLbKXPnRJSHl
 +JHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+K/Xxg2CHIiaU2WyrOqmygTZ+2OUWoB2Dsq15lGiibc2H44vkIW7J/EAnG0eZuKZAX0nFnUTAZg==@nongnu.org,
 AJvYcCVJeuekPjcnm5eSMQN04OI3IqAg4u5t0fT82bBRWjcDtixslYwt2ARBcwE/bluTzmvCZRO8NHJRr07Q8w==@nongnu.org,
 AJvYcCXPfExvKUhOcKIrel+tpil8uRAIoGV6k5NJyJiy6grjkLEedqS5a0OJ7s87Sq3MGNJ7PntnUDY52PPydw==@nongnu.org
X-Gm-Message-State: AOJu0YwOJ5/cxshkPo9Sx4LfJChVxW0oCnx9wDrps6mskJQek3k2X12Q
 VGeeW/enLStwlo+bOv5tkv8N1+K8U5vuZHuPOR+80tvDj5FPSM3e8wE2zUNy
X-Gm-Gg: ASbGncu2MQ+dTcVvexQAeC8EePrVdXp4vT4xmRie2Mc0lalQLqEB7NXnp2D9bmQGJPH
 u1sHRYQwBFDoFt172PNQ38wrNBD/q8gBRTKeAb7418BH/7sfUqEcODy6yJ9PK2TAVkcF5Ir8iJh
 0Jo7vSuL3Ja5Cg8FyjZbUfOEbgJ+4JmtInGZ/6VEzbPCFB9G2eyxUu1t9FFaqJedXvSQpm7THEs
 BMmOgZDDQnKmVH/DuHBArup0owsom72A27Uu/bp6/sPRqs40kWBQRweFB13AwK8ZjdFIh0QeL61
 SM4womsN/zu2X1Q7lNvScCcq+v2DstGZGcf2v7W+525ICT6n8rzTqOQsheXIyg==
X-Google-Smtp-Source: AGHT+IGOpMd+zixBjwH+ZUX9bocsp8GVd//iJoCVWf/G57iHw/hiumEIqHCi5j6XW6VB9vzy8CNMlQ==
X-Received: by 2002:a05:6a00:18a1:b0:736:4a5b:7f08 with SMTP id
 d2e1a72fcca58-739e716248amr14323576b3a.22.1744037210463; 
 Mon, 07 Apr 2025 07:46:50 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:8768:486:6a8e:e855])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ef3c2sm8856960b3a.59.2025.04.07.07.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:46:49 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 00/10] Enable QEMU to run on browsers
Date: Mon,  7 Apr 2025 23:45:51 +0900
Message-Id: <cover.1744032780.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Apr 2025 11:14:07 -0400
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

This patch series enables QEMU's system emulator to run in a browser using
Emscripten.
It includes implementations and workarounds to address browser environment
limitations, as shown in the following.

# New TCG Backend for Browsers

A new TCG backend translates IR instructions into Wasm instructions and runs
them using the browser's WebAssembly APIs (WebAssembly.Module and
WebAssembly.instantiate). To minimize compilation overhead and avoid hitting
the browser's limitation of the number of instances, this backend integrates
a forked TCI. TBs run on TCI by default, with frequently executed TBs
compiled into WebAssembly.

# Workaround for Running 64-bit Guests

The current implementation uses Wasm's 32-bit memory model, even though Wasm
supports 64-bit variables and instructions. This patch explores implementing
TCG 64-bit instructions while leveraging SoftMMU for address translation. To
enable 64-bit guest support in Wasm today, it was necessary to partially
revert recent changes that removed support for different pointer widths
between the host and guest (e.g., commits
a70af12addd9060fdf8f3dbd42b42e3072c3914f and
bf455ec50b6fea15b4d2493059365bf94c706273) when compiling with
Emscripten. While this serves as a temporary workaround, a long-term
solution could involve adopting Wasm's 64-bit memory model once it gains
broader support, as it is currently not widely adopted (e.g., unsupported by
Safari and libffi). Feedback and suggestions on this approach are welcome.

# Emscripten-Based Coroutine Backend

Emscripten does not support couroutine methods currently used by QEMU but
provides a coroutine implementation called "fiber". This patch series
introduces a coroutine backend using fiber. However, fiber does not support
submitting coroutines to other threads. So this patch series modifies
hw/9pfs/coth.h to disable this behavior when compiled with Emscripten.

# Overview of build process

This section provides an overview of the build process for compiling QEMU
using Emscripten. Full instructions are available in the sample
repository[1].

To compile QEMU with Emscripten, the following dependencies are required.
The emsdk-wasm32-cross.docker environment includes all necessary components
and can be used as the build environment:

- Emscripten SDK (emsdk) v3.1.50
- Libraries cross-compiled with Emscripten (refer to
  emsdk-wasm32-cross.docker for build steps)
  - GLib v2.84.0
  - zlib v1.3.1
  - libffi v3.4.7
  - Pixman v0.44.2

QEMU can be compiled using Emscripten's emconfigure and emmake, which
automatically set environment variables such as CC for targeting Emscripten.

emconfigure configure --static --disable-tools --target-list=x86_64-softmmu
emmake make -j$(nproc)

This process generates the following files:

- qemu-system-x86_64.js
- qemu-system-x86_64.wasm
- qemu-system-x86_64.worker.js

Guest images can be packaged using Emscripten's file_packager.py tool.
For example, if the images are stored in a directory named "pack", the
following command packages them, allowing QEMU to access them through
Emscripten's virtual filesystem:

/path/to/file_packager.py qemu-system-x86_64.data --preload pack > load.js

This process generates the following files:

- qemu-system-x86_64.data
- load.js

Emscripten allows passing arguments to the QEMU command via the Module
object in JavaScript:

Module['arguments'] = [
    '-nographic', '-m', '512M', '-accel', 'tcg,tb-size=500',
    '-L', 'pack/',
    '-drive', 'if=virtio,format=raw,file=pack/rootfs.bin',
    '-kernel', 'pack/bzImage',
    '-append', 'earlyprintk=ttyS0 console=ttyS0 root=/dev/vda loglevel=7',
];

The sample repository[1] provides a complete setup, including an HTML file
that implements a terminal UI.

[1] https://github.com/ktock/qemu-wasm-sample

# Additional references

- A talk at FOSDEM 2025:
  https://fosdem.org/2025/schedule/event/fosdem-2025-6290-running-qemu-inside-browser/
- Demo page on GitHub Pages: https://ktock.github.io/qemu-wasm-demo/

Kohei Tokunaga (10):
  various: Fix type conflict of GLib function pointers
  various: Define macros for dependencies on emscripten
  util/mmap-alloc: Add qemu_ram_mmap implementation for emscripten
  util: Add coroutine backend for emscripten
  meson: Add wasm build in build scripts
  include/exec: Allow using 64bit guest addresses on emscripten
  tcg: Add a TCG backend for WebAssembly
  hw/9pfs: Allow using hw/9pfs with emscripten
  gitlab: Enable CI for wasm build
  MAINTAINERS: Update MAINTAINERS file for wasm-related files

 .gitlab-ci.d/buildtest-template.yml           |   27 +
 .gitlab-ci.d/buildtest.yml                    |    9 +
 .gitlab-ci.d/container-cross.yml              |    5 +
 MAINTAINERS                                   |   11 +
 accel/tcg/cputlb.c                            |    8 +-
 block/file-posix.c                            |   18 +
 configs/meson/emscripten.txt                  |    6 +
 configure                                     |    7 +
 fsdev/file-op-9p.h                            |    3 +
 fsdev/meson.build                             |    2 +-
 hw/9pfs/9p-util-stub.c                        |   43 +
 hw/9pfs/9p-util.h                             |   18 +
 hw/9pfs/9p.c                                  |    3 +
 hw/9pfs/coth.h                                |   12 +
 hw/9pfs/meson.build                           |    2 +
 hw/riscv/riscv_hart.c                         |    9 +-
 include/accel/tcg/getpc.h                     |    2 +-
 include/exec/tlb-common.h                     |   14 +-
 include/exec/vaddr.h                          |   11 +
 include/qemu/atomic.h                         |    4 +
 include/qemu/cacheflush.h                     |    3 +-
 include/tcg/helper-info.h                     |    4 +-
 include/tcg/tcg.h                             |    2 +-
 meson.build                                   |   30 +-
 meson_options.txt                             |    2 +-
 os-posix.c                                    |    5 +
 qom/object.c                                  |    5 +-
 scripts/meson-buildoptions.sh                 |    2 +-
 target/arm/helper.c                           |    4 +-
 tcg/meson.build                               |    5 +
 tcg/tcg.c                                     |   26 +-
 tcg/wasm32.c                                  | 1260 +++++
 tcg/wasm32.h                                  |   39 +
 tcg/wasm32/tcg-target-con-set.h               |   18 +
 tcg/wasm32/tcg-target-con-str.h               |    8 +
 tcg/wasm32/tcg-target-has.h                   |  102 +
 tcg/wasm32/tcg-target-mo.h                    |   12 +
 tcg/wasm32/tcg-target-opc.h.inc               |    4 +
 tcg/wasm32/tcg-target-reg-bits.h              |   12 +
 tcg/wasm32/tcg-target.c.inc                   | 4484 +++++++++++++++++
 tcg/wasm32/tcg-target.h                       |   65 +
 .../dockerfiles/emsdk-wasm32-cross.docker     |  145 +
 util/cacheflush.c                             |    3 +-
 util/coroutine-fiber.c                        |  127 +
 util/mmap-alloc.c                             |   18 +
 45 files changed, 6561 insertions(+), 38 deletions(-)
 create mode 100644 configs/meson/emscripten.txt
 create mode 100644 hw/9pfs/9p-util-stub.c
 create mode 100644 tcg/wasm32.c
 create mode 100644 tcg/wasm32.h
 create mode 100644 tcg/wasm32/tcg-target-con-set.h
 create mode 100644 tcg/wasm32/tcg-target-con-str.h
 create mode 100644 tcg/wasm32/tcg-target-has.h
 create mode 100644 tcg/wasm32/tcg-target-mo.h
 create mode 100644 tcg/wasm32/tcg-target-opc.h.inc
 create mode 100644 tcg/wasm32/tcg-target-reg-bits.h
 create mode 100644 tcg/wasm32/tcg-target.c.inc
 create mode 100644 tcg/wasm32/tcg-target.h
 create mode 100644 tests/docker/dockerfiles/emsdk-wasm32-cross.docker
 create mode 100644 util/coroutine-fiber.c

-- 
2.25.1


