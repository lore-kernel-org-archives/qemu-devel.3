Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514DECAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSJ-00061E-2U; Mon, 08 Sep 2025 06:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSB-00060F-SN
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZS2-0005xe-MA
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YlC7E69t699pDUzJzBwza5/VNZLoXwv9Pj5ONMlGjrk=;
 b=X7PZjxjDxpxGxeDXYpXcu/rMVk8MszwcMEWYnbmTro5ilsl4rq7OQVTbcoLDL8Vx4ZW3At
 1XseCwxBHbNgzIbGklnpazXcX+7ziIInzB33qwniJ08PmCzI7M/h/khO4xFQuPGNc43zP2
 7Ib41Ezy1mnVT9IQsvPkTh2dDSJn9r0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-Jq5xoTvmM6GP2pqk_nqtvQ-1; Mon, 08 Sep 2025 06:50:10 -0400
X-MC-Unique: Jq5xoTvmM6GP2pqk_nqtvQ-1
X-Mimecast-MFC-AGG-ID: Jq5xoTvmM6GP2pqk_nqtvQ_1757328609
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45ddbdb92c5so12979725e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328608; x=1757933408;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YlC7E69t699pDUzJzBwza5/VNZLoXwv9Pj5ONMlGjrk=;
 b=DqP4tXXuaxjfQNfV1jH7sUqgllvjn41QZnbOMCWgZmtqStVh+Y/Q+jKIVbpBW7fBJS
 aXuqN+k3hML/8Ncgh4IKxZMs0uj558ptKwEk9Jpgb7ruLm7byXy9JR5vTv64gdLJ1Hae
 EP4J5EADlFaHcjId150Y9YFjb+fFv7m3V5kNKEcqNctUeKkzGGM1D2WD4ipdeXpsrNMB
 T3GczLKYEWRI2GXZVYhS/haRv4mKPuVZi7OrcgIXkHpVnO9KXKMRJxQfk5s/Wh2WwGCX
 Tg79pSbI+oTboa6s0Vx4XjvMREcP8XTaSrAsW6OrF4SfWbp13NEP5HkErH2+Jg4MLqne
 im8g==
X-Gm-Message-State: AOJu0Yxba5tOlz9zFotZtQKpw7PV+Y8C/H59T2uuuYtvTnMRzMgk5ObK
 FECccRH+XyoQbdDzzlCYcjR96uRVLu5V6YwI5iJrpfviTTUCy3Tvs2DMMlSXZZRhR+GUMs+OxxD
 LC5LQGFHlmWQebc1PpNmEI318Xh0/FBzumhHy5/VroY85/2TEM6NONTMW+ugC+Wz2eQqLp+HeAb
 OW1R4wPYLZi87nu9XmD84bCcKtrm3fckjlhHzKAreH
X-Gm-Gg: ASbGncs8ItNAkwr3479bsN5cgeqkw1+ljiiCmOs7PM2sXqjDAzVv9ukYxIVjWST2Wmh
 5Q3tghJzvl3sTzGbGKjFpFE1U8jS3AMxkWGsH+IhBs1ddmt7ZTNcq3R7Let8Px45aT0UeaHpHkB
 Vkmd1NSSP8ZxkeH/0ltkCMV7pm2tge4j7ya3Xj4BlienPtIorJjR4IFp9fwCYtZoh6vXgDeTXaC
 6S1Q2b7hZAh/T6qYPJjTi5/PyTnr9kpCcVNZ2Ku2RXG0D6vlBTBO2SUhP7+f4muk83gOaghsKBE
 gk0xZxZI3tolMwKNTXnPrFGyrxoWvubWH7O+wiaZExHdvHBKaRbvbjF1RN8rZN/d02LO6ADkPi0
 brQ6wL/gAtiGVPIwN3nv2ibqPwiM7yqEf5rEcUCkQ/2U=
X-Received: by 2002:a05:6000:2681:b0:3e4:74dc:a3bb with SMTP id
 ffacd0b85a97d-3e64bde9298mr6739788f8f.40.1757328607652; 
 Mon, 08 Sep 2025 03:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA9r3mkxRit9mXxH/C3FBZDOdvxG7FIEBD0vJgTdAJX79q1JHMB0OZXVEFQrVoLgtWWOIHqQ==
X-Received: by 2002:a05:6000:2681:b0:3e4:74dc:a3bb with SMTP id
 ffacd0b85a97d-3e64bde9298mr6739732f8f.40.1757328606779; 
 Mon, 08 Sep 2025 03:50:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3dedea839c1sm19573308f8f.63.2025.09.08.03.50.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/33] First Rust update for QEMU 10.2
Date: Mon,  8 Sep 2025 12:49:32 +0200
Message-ID: <20250908105005.2119297-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

This includes:
- bumping MSRV to 1.83.0 to support const_refs_to_static
- Zhao's safe, builder-based implementation of migration callbacks
- Manos's qdev properties macro.  While bit-based properties are
  not yet supported, that's a small change overall.
- the Rust crate split from Marc-André
- adding proc macro aliases in individual crates, also from Marc-André

I'm still not convinced about having "bql" depend on "migration",
but I am convinced by the crate split between "util" and "bql",
so we can move the implementation of VMState from "bql" to
"migration" later if needed.

For the purpose of getting this in as an easy-to-use base for future
development, I'm disabling CI from Debian and Ubuntu.  The plan is:
- that Debian will require trixie to enable Rust usage
- that Ubuntu will backport 1.83 to its 22.04 and 24.04 versions
  (https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318)
- that Marc-André or someone else will add Rust to other CI jobs

Also planned for 10.2 from me is using rustc to link emulators
(already written but requires Meson 1.9.1) and possibly some work on
BQL-free HPET, especially with respect to migration.  I'll probably
resubmit https://lore.kernel.org/qemu-devel/20250717062727.305466-5-pbonzini@redhat.com/
too, since improvements to migration support will likely result in
more procedural macro attributes.

I'll send the next update some time in October, probably once
Ubuntu gets the newer version of the compiler.  I'm now going to
mostly disappear for a week. :)

Paolo

Manos Pitsidianakis (1):
  rust: add qdev Device derive macro

Marc-André Lureau (22):
  docs/rust: update msrv
  rust: remove unused global qemu "allocator"
  rust: add workspace authors
  rust: move vmstate_clock!() to qdev module
  rust: move VMState handling to QOM module
  rust: move Cell vmstate impl
  rust: split Rust-only "common" crate
  rust: make build.rs generic over various ./rust/projects
  rust: split "util" crate
  rust: split "migration" crate
  rust: split "bql" crate
  rust: split "qom" crate
  rust: split "chardev" crate
  rust: split "system" crate
  rust: split "hwcore" crate
  rust: rename qemu_api_macros -> qemu_macros
  rust/hpet: drop now unneeded qemu_api dep
  rust/pl011: drop dependency on qemu_api
  rust: repurpose qemu_api -> tests
  rust: re-export qemu_macros internal helper in "bits"
  rust: re-export qemu macros from common/qom/hwcore
  docs: update rust.rst

Paolo Bonzini (9):
  ci: temporarily remove rust from Debian and Ubuntu
  configure: bump Meson to 1.9.0 for use with Rust
  meson, cargo: require Rust 1.83.0
  rust: add missing const markers for MSRV==1.83.0
  rust: use inline const expressions
  rust: vmstate: use const_refs_to_static
  rust: qdev: const_refs_to_static
  rust: meson: remove unnecessary complication in device crates
  rust: do not inline do_init_io

Zhao Liu (1):
  rust: vmstate: convert to use builder pattern

 MAINTAINERS                                   |  12 +-
 docs/devel/rust.rst                           |  93 ++--
 configure                                     |   4 +-
 meson.build                                   |  10 +-
 rust/bql/wrapper.h                            |  27 +
 rust/chardev/wrapper.h                        |  28 +
 rust/hw/char/pl011/wrapper.h                  |  51 ++
 rust/hw/core/wrapper.h                        |  32 ++
 rust/{qemu-api => migration}/wrapper.h        |  20 -
 rust/qom/wrapper.h                            |  27 +
 rust/system/wrapper.h                         |  29 +
 rust/util/wrapper.h                           |  32 ++
 .gitlab-ci.d/buildtest.yml                    |   6 +-
 clippy.toml                                   |   2 +-
 python/scripts/vendor.py                      |   4 +-
 python/wheels/meson-1.8.1-py3-none-any.whl    | Bin 1013001 -> 0 bytes
 python/wheels/meson-1.9.0-py3-none-any.whl    | Bin 0 -> 1029634 bytes
 pythondeps.toml                               |   4 +-
 rust/Cargo.lock                               | 125 ++++-
 rust/Cargo.toml                               |  19 +-
 .../src/bindings.rs => bindings/src/lib.rs}   |  12 +-
 rust/bits/Cargo.toml                          |   2 +-
 rust/bits/meson.build                         |   2 +-
 rust/bits/src/lib.rs                          |  13 +-
 rust/bql/Cargo.toml                           |  23 +
 rust/bql/build.rs                             |   1 +
 rust/bql/meson.build                          |  52 ++
 rust/bql/src/bindings.rs                      |  25 +
 rust/{qemu-api => bql}/src/cell.rs            | 336 ++----------
 rust/bql/src/lib.rs                           |  29 +
 rust/chardev/Cargo.toml                       |  23 +
 rust/chardev/build.rs                         |   1 +
 rust/chardev/meson.build                      |  41 ++
 rust/chardev/src/bindings.rs                  |  36 ++
 rust/{qemu-api => chardev}/src/chardev.rs     |  25 +-
 rust/chardev/src/lib.rs                       |   6 +
 rust/common/Cargo.toml                        |  20 +
 rust/common/meson.build                       |  34 ++
 rust/{qemu-api => common}/src/assertions.rs   |  24 +-
 rust/{qemu-api => common}/src/bitops.rs       |   1 -
 rust/{qemu-api => common}/src/callbacks.rs    |  37 +-
 rust/{qemu-api => common}/src/errno.rs        |  19 +-
 rust/common/src/lib.rs                        |  22 +
 rust/common/src/opaque.rs                     | 236 ++++++++
 rust/{qemu-api => common}/src/uninit.rs       |   8 +-
 rust/common/src/zeroable.rs                   |  18 +
 rust/hw/char/pl011/Cargo.toml                 |  10 +-
 rust/hw/char/pl011/build.rs                   |   1 +
 rust/hw/char/pl011/meson.build                |  39 +-
 rust/hw/char/pl011/src/bindings.rs            |  27 +
 rust/hw/char/pl011/src/device.rs              | 195 +++----
 rust/hw/char/pl011/src/lib.rs                 |   1 +
 rust/hw/char/pl011/src/registers.rs           |   4 +-
 rust/hw/core/Cargo.toml                       |  26 +
 rust/hw/core/build.rs                         |   1 +
 rust/hw/core/meson.build                      |  80 +++
 rust/hw/core/src/bindings.rs                  |  41 ++
 rust/{qemu-api => hw/core}/src/irq.rs         |  16 +-
 rust/hw/core/src/lib.rs                       |  15 +
 rust/{qemu-api => hw/core}/src/qdev.rs        | 111 ++--
 rust/{qemu-api => hw/core}/src/sysbus.rs      |  24 +-
 rust/{qemu-api => hw/core}/tests/tests.rs     |  52 +-
 rust/hw/timer/hpet/Cargo.toml                 |   9 +-
 rust/hw/timer/hpet/meson.build                |  12 +-
 rust/hw/timer/hpet/src/device.rs              | 227 ++++----
 rust/hw/timer/hpet/src/fw_cfg.rs              |   6 +-
 rust/meson.build                              |  15 +-
 rust/migration/Cargo.toml                     |  20 +
 rust/migration/build.rs                       |   1 +
 rust/migration/meson.build                    |  53 ++
 rust/migration/src/bindings.rs                |  48 ++
 rust/migration/src/lib.rs                     |   6 +
 rust/{qemu-api => migration}/src/vmstate.rs   | 519 +++++++++++-------
 rust/qemu-api/.gitignore                      |   2 -
 rust/qemu-api/README.md                       |  19 -
 rust/qemu-api/meson.build                     | 114 ----
 rust/qemu-api/src/lib.rs                      | 174 ------
 rust/qemu-api/src/prelude.rs                  |  31 --
 rust/qemu-api/src/zeroable.rs                 |  37 --
 .../Cargo.toml                                |   2 +-
 .../meson.build                               |  10 +-
 .../src/bits.rs                               |   0
 .../src/lib.rs                                | 170 +++++-
 .../src/tests.rs                              | 115 +++-
 rust/qom/Cargo.toml                           |  23 +
 rust/qom/build.rs                             |   1 +
 rust/qom/meson.build                          |  43 ++
 rust/qom/src/bindings.rs                      |  25 +
 rust/qom/src/lib.rs                           |  13 +
 rust/qom/src/prelude.rs                       |  12 +
 rust/{qemu-api => qom}/src/qom.rs             |  31 +-
 rust/system/Cargo.toml                        |  21 +
 rust/system/build.rs                          |   1 +
 rust/system/meson.build                       |  42 ++
 rust/system/src/bindings.rs                   |  41 ++
 rust/system/src/lib.rs                        |   6 +
 rust/{qemu-api => system}/src/memory.rs       |  21 +-
 rust/tests/Cargo.toml                         |  26 +
 rust/tests/meson.build                        |  14 +
 .../tests/vmstate_tests.rs                    | 160 +++---
 rust/{qemu-api => util}/Cargo.toml            |  14 +-
 rust/{qemu-api => util}/build.rs              |  10 +-
 rust/util/meson.build                         |  55 ++
 rust/util/src/bindings.rs                     |  25 +
 rust/{qemu-api => util}/src/error.rs          |   6 +-
 rust/util/src/lib.rs                          |   9 +
 rust/{qemu-api => util}/src/log.rs            |  16 +-
 rust/{qemu-api => util}/src/module.rs         |   2 +-
 rust/{qemu-api => util}/src/timer.rs          |  16 +-
 109 files changed, 2868 insertions(+), 1569 deletions(-)
 create mode 100644 rust/bql/wrapper.h
 create mode 100644 rust/chardev/wrapper.h
 create mode 100644 rust/hw/char/pl011/wrapper.h
 create mode 100644 rust/hw/core/wrapper.h
 rename rust/{qemu-api => migration}/wrapper.h (77%)
 create mode 100644 rust/qom/wrapper.h
 create mode 100644 rust/system/wrapper.h
 create mode 100644 rust/util/wrapper.h
 delete mode 100644 python/wheels/meson-1.8.1-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.9.0-py3-none-any.whl
 rename rust/{qemu-api/src/bindings.rs => bindings/src/lib.rs} (89%)
 create mode 100644 rust/bql/Cargo.toml
 create mode 120000 rust/bql/build.rs
 create mode 100644 rust/bql/meson.build
 create mode 100644 rust/bql/src/bindings.rs
 rename rust/{qemu-api => bql}/src/cell.rs (70%)
 create mode 100644 rust/bql/src/lib.rs
 create mode 100644 rust/chardev/Cargo.toml
 create mode 120000 rust/chardev/build.rs
 create mode 100644 rust/chardev/meson.build
 create mode 100644 rust/chardev/src/bindings.rs
 rename rust/{qemu-api => chardev}/src/chardev.rs (94%)
 create mode 100644 rust/chardev/src/lib.rs
 create mode 100644 rust/common/Cargo.toml
 create mode 100644 rust/common/meson.build
 rename rust/{qemu-api => common}/src/assertions.rs (86%)
 rename rust/{qemu-api => common}/src/bitops.rs (98%)
 rename rust/{qemu-api => common}/src/callbacks.rs (85%)
 rename rust/{qemu-api => common}/src/errno.rs (96%)
 create mode 100644 rust/common/src/lib.rs
 create mode 100644 rust/common/src/opaque.rs
 rename rust/{qemu-api => common}/src/uninit.rs (91%)
 create mode 100644 rust/common/src/zeroable.rs
 create mode 120000 rust/hw/char/pl011/build.rs
 create mode 100644 rust/hw/char/pl011/src/bindings.rs
 create mode 100644 rust/hw/core/Cargo.toml
 create mode 120000 rust/hw/core/build.rs
 create mode 100644 rust/hw/core/meson.build
 create mode 100644 rust/hw/core/src/bindings.rs
 rename rust/{qemu-api => hw/core}/src/irq.rs (93%)
 create mode 100644 rust/hw/core/src/lib.rs
 rename rust/{qemu-api => hw/core}/src/qdev.rs (82%)
 rename rust/{qemu-api => hw/core}/src/sysbus.rs (90%)
 rename rust/{qemu-api => hw/core}/tests/tests.rs (78%)
 create mode 100644 rust/migration/Cargo.toml
 create mode 120000 rust/migration/build.rs
 create mode 100644 rust/migration/meson.build
 create mode 100644 rust/migration/src/bindings.rs
 create mode 100644 rust/migration/src/lib.rs
 rename rust/{qemu-api => migration}/src/vmstate.rs (61%)
 delete mode 100644 rust/qemu-api/.gitignore
 delete mode 100644 rust/qemu-api/README.md
 delete mode 100644 rust/qemu-api/meson.build
 delete mode 100644 rust/qemu-api/src/lib.rs
 delete mode 100644 rust/qemu-api/src/prelude.rs
 delete mode 100644 rust/qemu-api/src/zeroable.rs
 rename rust/{qemu-api-macros => qemu-macros}/Cargo.toml (94%)
 rename rust/{qemu-api-macros => qemu-macros}/meson.build (63%)
 rename rust/{qemu-api-macros => qemu-macros}/src/bits.rs (100%)
 rename rust/{qemu-api-macros => qemu-macros}/src/lib.rs (54%)
 rename rust/{qemu-api-macros => qemu-macros}/src/tests.rs (50%)
 create mode 100644 rust/qom/Cargo.toml
 create mode 120000 rust/qom/build.rs
 create mode 100644 rust/qom/meson.build
 create mode 100644 rust/qom/src/bindings.rs
 create mode 100644 rust/qom/src/lib.rs
 create mode 100644 rust/qom/src/prelude.rs
 rename rust/{qemu-api => qom}/src/qom.rs (97%)
 create mode 100644 rust/system/Cargo.toml
 create mode 120000 rust/system/build.rs
 create mode 100644 rust/system/meson.build
 create mode 100644 rust/system/src/bindings.rs
 create mode 100644 rust/system/src/lib.rs
 rename rust/{qemu-api => system}/src/memory.rs (90%)
 create mode 100644 rust/tests/Cargo.toml
 create mode 100644 rust/tests/meson.build
 rename rust/{qemu-api => tests}/tests/vmstate_tests.rs (78%)
 rename rust/{qemu-api => util}/Cargo.toml (55%)
 rename rust/{qemu-api => util}/build.rs (81%)
 create mode 100644 rust/util/meson.build
 create mode 100644 rust/util/src/bindings.rs
 rename rust/{qemu-api => util}/src/error.rs (98%)
 create mode 100644 rust/util/src/lib.rs
 rename rust/{qemu-api => util}/src/log.rs (93%)
 rename rust/{qemu-api => util}/src/module.rs (97%)
 rename rust/{qemu-api => util}/src/timer.rs (91%)

-- 
2.51.0


