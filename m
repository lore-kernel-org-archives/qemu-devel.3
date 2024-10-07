Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAA8CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlYI-00031I-Bt; Mon, 07 Oct 2024 07:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlY5-0002fv-5q
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlY1-0006sM-2C
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728299104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cAUjv0LiDnh+R33xiHT1plRJtzb5PA2Qz644SoJ3KoY=;
 b=LB5xinkEc0DaDyOvhsf3BWqW6fGBddftXoZz9fpx1Vo9ZWixlsMen6vVUoQRfZpTWGx595
 ug7zz5wnISrLjf7eueilhNJpf0sLGOOsjf5Or5PKrx879hykt7IyURlHGvgHY6w3eKgDwA
 kZfYKCY58SfG9AoRuHBJgGHGHsVNQnc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-IFKvBOxQPBqlYBEvj8qMrA-1; Mon, 07 Oct 2024 07:03:50 -0400
X-MC-Unique: IFKvBOxQPBqlYBEvj8qMrA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c88d49acc5so5514034a12.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 04:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728299026; x=1728903826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cAUjv0LiDnh+R33xiHT1plRJtzb5PA2Qz644SoJ3KoY=;
 b=ra9Mn7wq/zcUBHL04Fa4lgYEem0bJP+vcxf8oP/rFn9WAr+jNTySUXHOBRhovrV31S
 xSXsDOGnNEy1jEQLd5IvLAkDDunWlzWR592+uOFwKnqNnLt1bKEQ07d3cwlGJykpRpto
 FI5mBKWd1XcUqJj+GPqKhRAXObkSkq7rvEGN5HhNQtWd03WSVI94wUL00As4ckfsA1Hv
 gorZT37i26UBbeTz3+/RDPtGh+ngIxlB7NC/s70+O0A+wRV1IvDcbbxHdeR+gRF6T/U6
 pOHKj+DQLL+hPEHsX84WkVE7Vr6ABwA/Zu5V3LgKLOBC1yqAeiAqs/4/cEJIKDtPeLDb
 Z9dg==
X-Gm-Message-State: AOJu0YwYIZbehX5vk/DjKkBwfzP3ZivorLouJ1wl/h73a8KKwzcP0XOh
 Ztb55ZgcQScGc7tlE4+26rWN2j/7RAshALT3ATKu+j5LlVEIdNrk9Zl3AXIieGDBNoHzG6eP4No
 NDoGphbDf1usOVYg/lC7QiQT5Xp7DVJc05n2mHXHL6yPqXqjanUisDfDJVOaFFu6z3why7NW9tR
 E7YNz+Ep7+WFbEleEuZoKlMjFbAYIMdxR7NpB0peE=
X-Received: by 2002:a17:907:6d0e:b0:a99:40e3:23e8 with SMTP id
 a640c23a62f3a-a9940e3256cmr722002866b.51.1728299026301; 
 Mon, 07 Oct 2024 04:03:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZc2Z9GuLRoN0TzIMiDgzlgZk6gWMkVgAZQbHlh8kWREaHVEk8K+ZddpP9j0M4Lqj4sxzWew==
X-Received: by 2002:a17:907:6d0e:b0:a99:40e3:23e8 with SMTP id
 a640c23a62f3a-a9940e3256cmr722000066b.51.1728299025763; 
 Mon, 07 Oct 2024 04:03:45 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a994cf480a6sm193846766b.100.2024.10.07.04.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 04:03:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com, junjie.mao@intel.com,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org
Subject: [PULL 00/12] Rust initial PoC + meson changes for 2024-10-07
Date: Mon,  7 Oct 2024 13:03:28 +0200
Message-ID: <20241007110342.1298598-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-04 19:28:37 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to dec4b629fc17fedcd2172066071f99ec8dcc8d8d:

  meson: ensure -mcx16 is passed when detecting ATOMIC128 (2024-10-07 13:01:06 +0200)

----------------------------------------------------------------
* first commit for Rust support
* fix detection of ATOMIC128 on x86_64

----------------------------------------------------------------
Manos Pitsidianakis (7):
      build-sys: Add rust feature option
      rust: add bindgen step as a meson dependency
      .gitattributes: add Rust diff and merge attributes
      meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
      rust: add crate to expose bindings and interfaces
      rust: add utility procedural macro crate
      rust: add PL011 device model

Paolo Bonzini (4):
      Require meson version 1.5.0
      configure, meson: detect Rust toolchain
      meson: define qemu_isa_flags
      meson: ensure -mcx16 is passed when detecting ATOMIC128

Pierrick Bouvier (1):
      meson: fix machine option for x86_version

 MAINTAINERS                                        |  21 +
 configure                                          | 170 +++++-
 meson.build                                        | 158 +++++-
 rust/wrapper.h                                     |  47 ++
 .gitattributes                                     |   3 +
 Kconfig                                            |   1 +
 Kconfig.host                                       |   3 +
 hw/arm/Kconfig                                     |  30 +-
 meson_options.txt                                  |   3 +
 python/scripts/vendor.py                           |   4 +-
 python/wheels/meson-1.2.3-py3-none-any.whl         | Bin 964928 -> 0 bytes
 python/wheels/meson-1.5.0-py3-none-any.whl         | Bin 0 -> 959846 bytes
 pythondeps.toml                                    |   2 +-
 rust/.gitignore                                    |   3 +
 rust/Kconfig                                       |   1 +
 rust/hw/Kconfig                                    |   2 +
 rust/hw/char/Kconfig                               |   3 +
 rust/hw/char/meson.build                           |   1 +
 rust/hw/char/pl011/.gitignore                      |   2 +
 rust/hw/char/pl011/Cargo.lock                      | 134 +++++
 rust/hw/char/pl011/Cargo.toml                      |  26 +
 rust/hw/char/pl011/README.md                       |  31 ++
 rust/hw/char/pl011/meson.build                     |  26 +
 rust/hw/char/pl011/src/device.rs                   | 599 +++++++++++++++++++++
 rust/hw/char/pl011/src/device_class.rs             |  70 +++
 rust/hw/char/pl011/src/lib.rs                      | 586 ++++++++++++++++++++
 rust/hw/char/pl011/src/memory_ops.rs               |  59 ++
 rust/hw/meson.build                                |   1 +
 rust/meson.build                                   |   4 +
 rust/qemu-api-macros/Cargo.lock                    |  47 ++
 rust/qemu-api-macros/Cargo.toml                    |  25 +
 rust/qemu-api-macros/README.md                     |   1 +
 rust/qemu-api-macros/meson.build                   |  25 +
 rust/qemu-api-macros/src/lib.rs                    |  43 ++
 rust/qemu-api/.gitignore                           |   2 +
 rust/qemu-api/Cargo.lock                           |   7 +
 rust/qemu-api/Cargo.toml                           |  26 +
 rust/qemu-api/README.md                            |  17 +
 rust/qemu-api/build.rs                             |  14 +
 rust/qemu-api/meson.build                          |  24 +
 rust/qemu-api/src/definitions.rs                   |  97 ++++
 rust/qemu-api/src/device_class.rs                  | 128 +++++
 rust/qemu-api/src/lib.rs                           | 166 ++++++
 rust/qemu-api/src/tests.rs                         |  49 ++
 rust/rustfmt.toml                                  |   7 +
 scripts/archive-source.sh                          |   6 +-
 scripts/make-release                               |   5 +-
 scripts/meson-buildoptions.sh                      |   3 +
 scripts/rust/rust_root_crate.sh                    |  13 +
 scripts/rust/rustc_args.py                         |  84 +++
 subprojects/.gitignore                             |  11 +
 subprojects/arbitrary-int-1-rs.wrap                |   7 +
 subprojects/bilge-0.2-rs.wrap                      |   7 +
 subprojects/bilge-impl-0.2-rs.wrap                 |   7 +
 subprojects/either-1-rs.wrap                       |   7 +
 subprojects/itertools-0.11-rs.wrap                 |   7 +
 .../packagefiles/arbitrary-int-1-rs/meson.build    |  19 +
 subprojects/packagefiles/bilge-0.2-rs/meson.build  |  29 +
 .../packagefiles/bilge-impl-0.2-rs/meson.build     |  45 ++
 subprojects/packagefiles/either-1-rs/meson.build   |  24 +
 .../packagefiles/itertools-0.11-rs/meson.build     |  30 ++
 .../packagefiles/proc-macro-error-1-rs/meson.build |  40 ++
 .../proc-macro-error-attr-1-rs/meson.build         |  32 ++
 .../packagefiles/proc-macro2-1-rs/meson.build      |  31 ++
 subprojects/packagefiles/quote-1-rs/meson.build    |  29 +
 subprojects/packagefiles/syn-2-rs/meson.build      |  40 ++
 .../packagefiles/unicode-ident-1-rs/meson.build    |  20 +
 subprojects/proc-macro-error-1-rs.wrap             |   7 +
 subprojects/proc-macro-error-attr-1-rs.wrap        |   7 +
 subprojects/proc-macro2-1-rs.wrap                  |   7 +
 subprojects/quote-1-rs.wrap                        |   7 +
 subprojects/syn-2-rs.wrap                          |   7 +
 subprojects/unicode-ident-1-rs.wrap                |   7 +
 subprojects/unicode-ident-1-rs/meson.build         |  20 +
 tests/lcitool/mappings.yml                         |   2 +-
 75 files changed, 3194 insertions(+), 34 deletions(-)
 create mode 100644 rust/wrapper.h
 delete mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.5.0-py3-none-any.whl
 create mode 100644 rust/.gitignore
 create mode 100644 rust/Kconfig
 create mode 100644 rust/hw/Kconfig
 create mode 100644 rust/hw/char/Kconfig
 create mode 100644 rust/hw/char/meson.build
 create mode 100644 rust/hw/char/pl011/.gitignore
 create mode 100644 rust/hw/char/pl011/Cargo.lock
 create mode 100644 rust/hw/char/pl011/Cargo.toml
 create mode 100644 rust/hw/char/pl011/README.md
 create mode 100644 rust/hw/char/pl011/meson.build
 create mode 100644 rust/hw/char/pl011/src/device.rs
 create mode 100644 rust/hw/char/pl011/src/device_class.rs
 create mode 100644 rust/hw/char/pl011/src/lib.rs
 create mode 100644 rust/hw/char/pl011/src/memory_ops.rs
 create mode 100644 rust/hw/meson.build
 create mode 100644 rust/meson.build
 create mode 100644 rust/qemu-api-macros/Cargo.lock
 create mode 100644 rust/qemu-api-macros/Cargo.toml
 create mode 100644 rust/qemu-api-macros/README.md
 create mode 100644 rust/qemu-api-macros/meson.build
 create mode 100644 rust/qemu-api-macros/src/lib.rs
 create mode 100644 rust/qemu-api/.gitignore
 create mode 100644 rust/qemu-api/Cargo.lock
 create mode 100644 rust/qemu-api/Cargo.toml
 create mode 100644 rust/qemu-api/README.md
 create mode 100644 rust/qemu-api/build.rs
 create mode 100644 rust/qemu-api/meson.build
 create mode 100644 rust/qemu-api/src/definitions.rs
 create mode 100644 rust/qemu-api/src/device_class.rs
 create mode 100644 rust/qemu-api/src/lib.rs
 create mode 100644 rust/qemu-api/src/tests.rs
 create mode 100644 rust/rustfmt.toml
 create mode 100755 scripts/rust/rust_root_crate.sh
 create mode 100644 scripts/rust/rustc_args.py
 create mode 100644 subprojects/arbitrary-int-1-rs.wrap
 create mode 100644 subprojects/bilge-0.2-rs.wrap
 create mode 100644 subprojects/bilge-impl-0.2-rs.wrap
 create mode 100644 subprojects/either-1-rs.wrap
 create mode 100644 subprojects/itertools-0.11-rs.wrap
 create mode 100644 subprojects/packagefiles/arbitrary-int-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
 create mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
 create mode 100644 subprojects/packagefiles/either-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/itertools-0.11-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
 create mode 100644 subprojects/packagefiles/unicode-ident-1-rs/meson.build
 create mode 100644 subprojects/proc-macro-error-1-rs.wrap
 create mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
 create mode 100644 subprojects/proc-macro2-1-rs.wrap
 create mode 100644 subprojects/quote-1-rs.wrap
 create mode 100644 subprojects/syn-2-rs.wrap
 create mode 100644 subprojects/unicode-ident-1-rs.wrap
 create mode 100644 subprojects/unicode-ident-1-rs/meson.build
-- 
2.46.1


