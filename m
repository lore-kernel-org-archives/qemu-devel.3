Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788A6C5B552
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZRz-0004rf-Bs; Tue, 03 Jun 2025 17:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZRv-0004qz-IA
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZRq-00064j-Oo
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MdPuQlRGqNRQoffoaOmW8+rZEflww+N6r/BmIyOd8IY=;
 b=N/u0E2QHV2x6t3gYIaAmq5xwDpmrWWrSX0L3yeJGslSiC/USP0Nv3BByYy5p3pLFppT60Q
 9mR15TczVBfbjNoWMAEUlhvIir7JlzT0N6YENEuNf9FfAiXycFhGGF8+VHqEICm7GSomeo
 4noYjasCCPnmaSHXqzsZ/9LA56mQ0rA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-p66BHEeEOtSWxC-4fMFWQw-1; Tue, 03 Jun 2025 17:45:27 -0400
X-MC-Unique: p66BHEeEOtSWxC-4fMFWQw-1
X-Mimecast-MFC-AGG-ID: p66BHEeEOtSWxC-4fMFWQw_1748987126
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f7ebfd00so2307100f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987125; x=1749591925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MdPuQlRGqNRQoffoaOmW8+rZEflww+N6r/BmIyOd8IY=;
 b=KoEyK32VYxN+nSrWeUxOF6aIlH/04UMCql+5GcHyHsqODYrBM6nEOzt7hkm6Z8MoLZ
 kSRrY6vQFEEf5FD0PUKKlalFyuUEPxklfDqslD6UZV27hQF9n1eJpb1hKvz1np08yTEt
 feeF+uEsm0cyD8hHs8MENOrbZxajKN1NI+ijV5QGKP16GGL/olyL8OZkXTSy7WT1Su0K
 ou+lLnJLLkhT75mHAFdlyBFAHby+k1BwttivwHSEwjeCDEF7lujex8UrR8ltcMmxe6u1
 et58JNXNwPSuZMHAdJa/aDt1xHqHjWkAARUxLMTpZCqn1+Fn9E82pBJXE0wm4LQv3gmC
 eunw==
X-Gm-Message-State: AOJu0YxwmfSTqecNs8V+2tjLaMz9jzSP0EMCTg7yBQ61f7aEHjrKDiCl
 DTewjESZoqo84MtTxnjxMToB2ityaoTa57OsonVLasO54cQG+kjODKsUDchdLvSNoHxivz2XNEh
 gNDRODegPHj1iUGVtmZTTz4THwAI49qldeBpV4GE0aO+Cj1h2BIjfIzwMQ7jyUlNVzwsFJLDA/4
 S+uCvQE3Nzr/8rfH4ytoLhfasCZBKP+NMU1I+3UvFy
X-Gm-Gg: ASbGncub3gwYBFeiKAKp13jTk0pWOSexXWFCfdOvd2rwfpoOaTqhKXsAo9DoY2G3oVi
 TEi2S/i8Bv8oG795TI1ig7mVa7lkgTjlhJ1I/cqlguaVSR95NbLM18sDi7v/zrZHhG2aiHHoRl2
 7Yikn6wme+lv9Zmw2ny50HoS8CgVCl+cBeyyQrhWueXj1OgpQ+HiwXAE9IKcvvYmxlkFILldbsN
 oZfddPRzTbIkb7DXiAcSXkyT57C+YPzjYrBiilzA4dVlVqzCMC4zcoC+uZ242CEGxZizBI/kFFs
 0onvtVKP+fXXqg==
X-Received: by 2002:a05:6000:230e:b0:3a5:1cc5:aa6f with SMTP id
 ffacd0b85a97d-3a51d9583d8mr243101f8f.34.1748987125468; 
 Tue, 03 Jun 2025 14:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdNZpswLMgYNIlIDk0ASYYrxtjDk7fxy+iT/mJDZO88OA8I1JIjd/4yVT/4surODG2qICblw==
X-Received: by 2002:a05:6000:230e:b0:3a5:1cc5:aa6f with SMTP id
 ffacd0b85a97d-3a51d9583d8mr243089f8f.34.1748987124995; 
 Tue, 03 Jun 2025 14:45:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f90c40sm177429525e9.2.2025.06.03.14.45.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] rust, i386 changes for 2025-06-03
Date: Tue,  3 Jun 2025 23:45:07 +0200
Message-ID: <20250603214523.131185-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 6322b753f798337835e205b6d805356bea582c86:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-06-02 14:52:45 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 214518614c1ce7eb7a002452cd43a7597f90d543:

  rust: qemu-api-macros: add from_bits and into_bits to #[derive(TryInto)] (2025-06-03 22:44:40 +0200)

----------------------------------------------------------------
* rust: use native Meson support for clippy and rustdoc
* rust: add "bits", a custom bitflags implementation
* target/i386: Remove FRED dependency on WRMSRNS
* target/i386: Add the immediate form MSR access instruction support
* TDX fixes

----------------------------------------------------------------
Cédric Le Goater (2):
      i386/tdx: Fix build on 32-bit host
      i386/tdvf: Fix build on 32-bit host

Paolo Bonzini (10):
      rust: bindings: allow ptr_offset_with_cast
      meson: update to version 1.8.1
      rust: use "objects" for Rust executables as well
      build, dockerfiles: add support for detecting rustdoc
      rust: add qemu-api doctests to "meson test"
      rust: cell: remove support for running doctests with "cargo test --doc"
      rust: use native Meson support for clippy and rustdoc
      rust: add "bits", a custom bitflags implementation
      rust: pl011: use the bits macro
      rust: qemu-api-macros: add from_bits and into_bits to #[derive(TryInto)]

Pierrick Bouvier (1):
      meson: use config_base_arch for target libraries

Xin Li (Intel) (3):
      target/i386: Remove FRED dependency on WRMSRNS
      target/i386: Add a new CPU feature word for CPUID.7.1.ECX
      target/i386: Add the immediate form MSR access instruction support

 docs/devel/rust.rst                                |  12 +-
 configure                                          |  16 +
 meson.build                                        |  11 +-
 target/i386/cpu.h                                  |   5 +
 hw/i386/tdvf.c                                     |   6 +-
 target/i386/cpu.c                                  |  27 +-
 target/i386/kvm/tdx.c                              |  26 +-
 .gitlab-ci.d/buildtest-template.yml                |   3 +-
 .gitlab-ci.d/buildtest.yml                         |  11 +-
 rust/clippy.toml => clippy.toml                    |   2 +-
 python/scripts/vendor.py                           |   4 +-
 python/wheels/meson-1.5.0-py3-none-any.whl         | Bin 959846 -> 0 bytes
 python/wheels/meson-1.8.1-py3-none-any.whl         | Bin 0 -> 1013001 bytes
 pythondeps.toml                                    |   2 +-
 rust/Cargo.lock                                    |   8 +
 rust/Cargo.toml                                    |   2 +-
 rust/bits/Cargo.toml                               |  19 +
 rust/bits/meson.build                              |  16 +
 rust/bits/src/lib.rs                               | 443 +++++++++++++++++++++
 rust/hw/char/pl011/Cargo.toml                      |   1 +
 rust/hw/char/pl011/meson.build                     |   1 +
 rust/hw/char/pl011/src/device.rs                   |  51 ++-
 rust/hw/char/pl011/src/registers.rs                |  39 +-
 rust/meson.build                                   |  15 +-
 rust/qemu-api-macros/src/bits.rs                   | 229 +++++++++++
 rust/qemu-api-macros/src/lib.rs                    |  60 ++-
 rust/qemu-api/meson.build                          |  34 +-
 rust/qemu-api/src/bindings.rs                      |   1 +
 rust/qemu-api/src/cell.rs                          |  22 +-
 scripts/rust/rustc_args.py                         |   5 +-
 .../docker/dockerfiles/fedora-rust-nightly.docker  |   2 +
 tests/docker/dockerfiles/ubuntu2204.docker         |   1 +
 tests/lcitool/mappings.yml                         |   6 +-
 tests/lcitool/refresh                              |   3 +
 34 files changed, 934 insertions(+), 149 deletions(-)
 rename rust/clippy.toml => clippy.toml (55%)
 delete mode 100644 python/wheels/meson-1.5.0-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.8.1-py3-none-any.whl
 create mode 100644 rust/bits/Cargo.toml
 create mode 100644 rust/bits/meson.build
 create mode 100644 rust/bits/src/lib.rs
 create mode 100644 rust/qemu-api-macros/src/bits.rs
-- 
2.49.0


