Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE091D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzMY-0005ih-MI; Fri, 15 Nov 2024 11:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzMV-0005ha-E1
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzMO-0001rY-K1
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731688790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/r5jLQNPT+C2nD8yyF5aXUNK/EZ2/lpZRMe/xFoyW4E=;
 b=J2g3JpJaOHEJiup3UAciVqC/7DvCXsR0ptaLxIXvDrOblNnVW8ljjbOixAJhiUe59z0S1D
 UYVRNUTL3APlY3RcEMseezt29oVazJwL1Ka/beBZd2CwQRFxr7RGYXFJMN3B3l5I/bEXsm
 DDSSJ6Kb5XnRyQnyQwg5zoaqd8UnBxs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-0H84XH-pN9mlhi8HmnaeXA-1; Fri, 15 Nov 2024 11:39:48 -0500
X-MC-Unique: 0H84XH-pN9mlhi8HmnaeXA-1
X-Mimecast-MFC-AGG-ID: 0H84XH-pN9mlhi8HmnaeXA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d4854fa0eso1263864f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:39:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688786; x=1732293586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/r5jLQNPT+C2nD8yyF5aXUNK/EZ2/lpZRMe/xFoyW4E=;
 b=b8+ZieOMKZfFutlR472hEe4kDWG0sbMQfC8j2WVICnuNqug0SarkbdNRBkPDtxgOSr
 CxJewLAcLudRCqThfDh54dA2bM3aKRepq6T3W20GOED/laMO28S/d6Dl5vhoZcheKQek
 YS/l5SfoZZkhlWykW/N4jyqZ7mKJ6grhb21WT5kQFUg9GjlfjvzA8jvhGFg5vkC3pnJG
 cAiMVjW+ROpCXFKBfHwxpydqN6WvhspYLdENc6mXyPcX1rpwX22713XrXNU6blbTU0hv
 CDD0MKPzXrJHXZQX9E+oJt4dSLVgj7VFaj7OWgs7vJa5ByWj4CkA/c799TkwZlfP3bWA
 0ZlA==
X-Gm-Message-State: AOJu0Yw1bz0BeEMQf0y0D99LUBG/xtI+fmxuS4dLw1pXAG8d+9BKpKeF
 9Rq0A0ZO3uYt44V8PhfyNSkwbRqOudp6SgTIazg58l3+TjlE1fAEzzifebBUzieMcgsU8XI5jrU
 6ZeQMUDXgOGWcWLdv4u2ynoQNQ9swvJK0ioUi2wwf1bDMzm87E1jdhGEYZOPLC7o8dvXhIobl1C
 Q2q4Gyl9KBYIfrgWNQQkknVexcbi/SIxSO84OMUsc=
X-Received: by 2002:a5d:64cc:0:b0:382:2f62:bd4b with SMTP id
 ffacd0b85a97d-3822f62bfa3mr1042751f8f.33.1731688786448; 
 Fri, 15 Nov 2024 08:39:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcrcGr6Jh5rvbV+yZHF73tRycDumJwtfyF+CxlzU+IYCrY419wqFkGXSgulM27EXj96jKmvA==
X-Received: by 2002:a5d:64cc:0:b0:382:2f62:bd4b with SMTP id
 ffacd0b85a97d-3822f62bfa3mr1042723f8f.33.1731688785811; 
 Fri, 15 Nov 2024 08:39:45 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821e073e0asm4289208f8f.30.2024.11.15.08.39.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:39:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/12] rust: improved integration with cargo
Date: Fri, 15 Nov 2024 17:39:32 +0100
Message-ID: <20241115163944.1917393-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While we're not sure where we'll be going in the future, for now
using cargo remains an important part of developing QEMU Rust code.
This is because cargo is the easiest way to run clippy, rustfmt,
rustdoc.  Cargo also allows working with doc tests, though there are
pretty much none yet, and provides tools such as "cargo expand".

This series aims at improving the integration with cargo and
cargo-based tooling, including rust-analyzer.

First, while it is currently possible to run cargo on the rust/
directory, this has the issue that the bindings.rs must be placed by hand
in the source tree.  Therefore, this series starts by allowing cargo to
"just work" when run in a "meson devenv" environment:

    pyvenv/bin/meson devenv -w ../rust cargo clippy --tests
    pyvenv/bin/meson devenv -w ../rust cargo fmt

If you are going to use cargo repeatedly, invoking just

    pyvenv/bin/meson devenv

will put you in a shell where commands like 'cargo clippy' just work.
For simplicity, I am also adding targets 'make clippy', 'make rustfmt',
'make rustdoc'.

Secondly, one problem with mixing Cargo and meson is having to redo the
configuration of "lints" in both sides.  This series standardizes
on using Cargo.toml to configure the build, and bringing the flags
over to build.ninja with extensions to the existing rustc_args.py script.
The RFC didn't have any objection but also no enthusiastic approval,
so once more if the additions to the script seem to be too large I'm
open to scrapping the idea.  I organizes the changes so that the changes
are split over multiple patches, but it does not make much sense to
only keep some of them.

Finally, this series adds a CI job that runs rustfmt, clippy, and
rustdoc.

I checked that you can point rust-analyzer at the sources, by adding
MESON_BUILD_ROOT in the rust-analyzer.cargo.extraEnv setting, too.  I'm
not sure if there's a better way.  We need to document all this somewhere
but Manos said he's working on documentation, so I'll let him post what
he has and possibly integrate it later.
 
Compared to the RFC there are a smattering of fixes in meson.build,
slightly different set of lints (for example ptr_constness_cast has
issues with 1.63.0) and the changes to support rust-analyzer.

Also, doctests for now are not supported.  Building and running them with
"rustdoc" is not hard, but there are some complications because they are
integration tests for all intents and purposes; and therefore they need
linker options to include non-Rust build products.  For now "cargo test
--doc" works, but that's not going to remain the case when for example
QOM doctests are added.  However it should be possible with some effort
to build them with Meson just like rust-qemu-api-integration, and run
them normally from "make check".

Paolo

RFC->v1:
new patch 1
patch 2: new commit message
         use symlink in OUT_DIR as suggested by Junjie
patch 3: mention that rustc_args may be needed for other crates in the future
patch 6: change unexpected_cfgs to deny
         allow running rustc_args.py with --workspace and without Cargo.toml
patch 8: adjust commit message
         better fix for ptr_constness_cast in rust/hw/char/pl011/src/device.rs
patch 9: add should_implement_trait and shadow_unrelated
         drop ptr_cast_constness until 1.65.0
patch 10: make cargo optional
          add rustdoc per rust/qemu-api/README.md
patch 12: move to static_checks.yml, remove doctests


Paolo Bonzini (12):
  rust: apply --cfg MESON to all crates
  rust: allow using build-root bindings.rs from cargo
  rust: build: move rustc_args.py invocation to qemu-api crate
  rust: build: restrict --cfg generation to only required symbols
  rust: build: generate lint flags from Cargo.toml
  rust: cargo: store desired warning levels in workspace Cargo.toml
  rust: build: move strict lints handling to rustc_args.py
  rust: fix a couple style issues from clippy
  rust: build: establish a baseline of lints across all crates
  rust: build: add "make clippy", "make rustfmt", "make rustdoc"
  rust: ci: add job that runs Rust tools
  rust: fix doc test syntax

 meson.build                                   |  57 +++---
 .gitlab-ci.d/static_checks.yml                |  23 +++
 rust/Cargo.toml                               |  79 ++++++++
 rust/hw/char/pl011/.gitignore                 |   2 -
 rust/hw/char/pl011/Cargo.toml                 |   3 +
 rust/hw/char/pl011/src/device.rs              |   8 +-
 rust/hw/char/pl011/src/lib.rs                 |  19 +-
 rust/hw/char/pl011/src/memory_ops.rs          |   4 +-
 rust/meson.build                              |  22 +++
 rust/qemu-api-macros/Cargo.toml               |   3 +
 rust/qemu-api/.gitignore                      |   2 +-
 rust/qemu-api/Cargo.toml                      |   5 +-
 rust/qemu-api/README.md                       |  10 +-
 rust/qemu-api/build.rs                        |  39 +++-
 rust/qemu-api/meson.build                     |   6 +-
 rust/qemu-api/src/bindings.rs                 |  29 +++
 rust/qemu-api/src/lib.rs                      |  22 ---
 rust/qemu-api/src/zeroable.rs                 |   6 +-
 rust/qemu-api/tests/tests.rs                  |   2 +-
 scripts/rust/rustc_args.py                    | 181 ++++++++++++++++--
 .../dockerfiles/fedora-rust-nightly.docker    |   4 +
 tests/lcitool/refresh                         |   4 +
 22 files changed, 419 insertions(+), 111 deletions(-)
 delete mode 100644 rust/hw/char/pl011/.gitignore
 create mode 100644 rust/qemu-api/src/bindings.rs

-- 
2.47.0


