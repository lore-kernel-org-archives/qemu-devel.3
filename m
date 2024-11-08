Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6D8D64078
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 18:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9TJ0-0001oT-CF; Fri, 08 Nov 2024 13:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TIu-0001ni-7w
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:01:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TIq-0001uu-6e
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731088906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kIGyL9EmEUBFRVfp6dcnovcCpaIlJ7mh7XGPmZANxzw=;
 b=JFyzT0RlrTgLp1cn6ferb0F3ffc4ET3xxuZ6U7JeV3qa1Uq8OGKFFnx+rJ4XQUq2hM9JE7
 PJkxXCmbfuwrUn3YtGDV87kOwUnhRP5BflrLNjYzMG0tddZb2egXfsOphuoLIObkWGl22w
 wcV9dvEWDbnpt6kC3wiRoww790lSdAU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-ZCrlx74QP66_tFoJxvae1w-1; Fri, 08 Nov 2024 13:01:45 -0500
X-MC-Unique: ZCrlx74QP66_tFoJxvae1w-1
X-Mimecast-MFC-AGG-ID: ZCrlx74QP66_tFoJxvae1w
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d533a484aso1797303f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 10:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088903; x=1731693703;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kIGyL9EmEUBFRVfp6dcnovcCpaIlJ7mh7XGPmZANxzw=;
 b=HkwS8wzq4GYap4q8+TiIb/aJGmSfQvyATASUqaGbc3R74gA2DSMhcxOAkYNcodPLVl
 a9PXJIUPSpTNN9rWs+TzIQ+ZZe5oN5ynKEOdm5EI/CMWxuBmqf5ZY2pAEPsYFaIEJbCf
 YV3pH8TwE99pmgmP/3MoUeBpEdGYPbh/rdWLhEP3z0Ah0OFpHGDVeO/clY/F/oEDBkJA
 WO4aiL9bNbmYDRyJk+wh7gGeUvuPe0lwcH13MvXjxmcsAorhqMwsikhNfE+30d6VfHo5
 /kGL35dbiXoZYyFYnTpxQfnOWrFlFTWrf/X2OrBmQrc92XCws5WEsTbIWfSIqM+x58Zo
 bQIw==
X-Gm-Message-State: AOJu0Yy2dB4nRsc5LOq0a9km/ie+lHhMUkJV0HGd7z7TxixIewCVMNBv
 Ms1cyctnGXRWtGtocMpBmJk3REi21ajX+Ahi7dWIdInQmnV2vFlA8Ken6E0zCHXHpT/ZlHmbFKI
 ZxAhiBbS/D997IaIbeVTcm4keC2103DKjaP71nnU1XW+TOQejZxYrCUXNDLODVp7ll/EZM2iQkR
 SveHx2Hk1YMdf7FhRzMVWVF8T/kQaiY4J+vmn/QgE=
X-Received: by 2002:a5d:64a1:0:b0:37d:460d:2d07 with SMTP id
 ffacd0b85a97d-381f0f5849amr4482136f8f.10.1731088903031; 
 Fri, 08 Nov 2024 10:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBKqsTmIJnVSPaJhkwvSZpkKa0L044mOj7lafGDQrZL5/OrrLYQzF1LMdSTfZ+7pdYy3lwEg==
X-Received: by 2002:a5d:64a1:0:b0:37d:460d:2d07 with SMTP id
 ffacd0b85a97d-381f0f5849amr4482068f8f.10.1731088902393; 
 Fri, 08 Nov 2024 10:01:42 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05c26e3sm79682175e9.33.2024.11.08.10.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 10:01:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, kwolf@redhat.com, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: [RFC PATCH 00/11] rust: improved integration with cargo
Date: Fri,  8 Nov 2024 19:01:28 +0100
Message-ID: <20241108180139.117112-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While we're not sure where we'll be going in the future, for now
using cargo remains an important part of developing QEMU Rust code.
This is because cargo is the easiest way to run clippy, rustfmt,
rustdoc.  Cargo also allows working with doc tests, though there are
pretty much none yet, and provides tools such as "cargo expand".

This series aims at improving the integration with cargo and
cargo-based tooling.

First, while it is currently possible to run cargo on the rust/ directory,
but it has the issue that the bindings.rs must be placed by hand in
the build directory.  Therefore, this series starts by allowing
cargo to "just work" when run in a "meson devenv" environment:

    meson devenv -w ../rust cargo clippy --tests
    meson devenv -w ../rust cargo fmt

If you are going to use cargo repeatedly, invoking just 'meson devenv'
will put you in a shell where commands like 'cargo clippy' just work.
For simplicity, I am also adding two targets 'make clippy' and 'make
rustfmt'.

Secondly, one problem with mixing Cargo and meson is having to redo the
configuration of "lints" in both sides.  This series standardizes
on using Cargo.toml to configure the build, and bringing the flags
over to build.ninja with extensions to the existing rustc_args.py script.
I admit that these additions to the script are pretty large and therefore
I'm open to scrapping the idea.  I tried to organize the changes so that
the changes are split over multiple patches.

Finally, this series adds a CI job that runs rustfmt, clippy, and
rustdoc, including running doctests.

Please send comments!

Paolo

Paolo Bonzini (11):
  rust: qemu_api: do not disable lints outside bindgen-generated code
  rust: build: move rustc_args.py invocation to individual crates
  rust: build: restrict --cfg generation to only required symbols
  rust: build: generate warning flags from Cargo.toml
  rust: cargo: store desired warning levels in workspace Cargo.toml
  rust: build: move strict lints handling to rustc_args.py
  rust: fix a couple style issues from clippy
  rust: build: establish a baseline of lints across all crates
  rust: build: add "make clippy", "make rustfmt"
  rust: fix doc test syntax
  rust: ci: add job that runs Rust tools

 meson.build                                   |  56 +++---
 .gitlab-ci.d/buildtest-template.yml           |  14 ++
 .gitlab-ci.d/buildtest.yml                    |  14 ++
 rust/Cargo.toml                               |  80 ++++++++
 rust/hw/char/pl011/Cargo.toml                 |   3 +
 rust/hw/char/pl011/src/device.rs              |   6 +-
 rust/hw/char/pl011/src/lib.rs                 |  18 +-
 rust/hw/char/pl011/src/memory_ops.rs          |   4 +-
 rust/meson.build                              |  14 ++
 rust/qemu-api-macros/Cargo.toml               |   3 +
 rust/qemu-api/.gitignore                      |   2 +-
 rust/qemu-api/Cargo.toml                      |   5 +-
 rust/qemu-api/build.rs                        |  24 ++-
 rust/qemu-api/meson.build                     |   5 +
 rust/qemu-api/src/bindings.rs                 |  29 +++
 rust/qemu-api/src/lib.rs                      |  22 ---
 rust/qemu-api/src/zeroable.rs                 |   6 +-
 rust/qemu-api/tests/tests.rs                  |   2 +-
 scripts/rust/rustc_args.py                    | 178 ++++++++++++++++--
 .../dockerfiles/fedora-rust-nightly.docker    |   4 +
 tests/lcitool/refresh                         |   4 +
 21 files changed, 391 insertions(+), 102 deletions(-)
 create mode 100644 rust/qemu-api/src/bindings.rs

-- 
2.47.0


