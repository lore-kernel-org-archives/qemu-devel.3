Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0ABC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 18:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjfe-0000MY-Iy; Mon, 10 Jun 2024 14:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGjfc-0000Lv-VY
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:23:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGjfY-00068R-J4
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:23:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-421a1b834acso11414275e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718043778; x=1718648578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=70+XCpUg2RoMoS8Qp4Jl4SCYh43EFg5owDjkiF7YuwE=;
 b=J2pKurLGAfGXKShFDcRReZLSMnxbFGdsbVS4HHcOwROBpJagEJLpyVjjqNltF5h8TI
 qzJJEzvcIZO2F+12Xff9ugtImDjv7T7dbtYgYn+zhzWx8mhYk3uxsVcAPC7mAFjtA71a
 0Z0fhah6MEm6lF+Wp61eDE3ORzjWg/TmTMAcIO/s4pNzriWKfKQ7bOJhFmBwzEF/iTEy
 xmP/mA1DVp/9SH9hZgaFmmuX2EzOKdgm5grsZOwp6OX3E5cZcbYJVlCXZCzYDvWsQFFO
 NfyehepjO0mYalRoIi4JQWDzwGmsMWAJiCRjtUStsIvtDv/IkEeK41JuDQzHP8gD9b+Q
 fvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718043778; x=1718648578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=70+XCpUg2RoMoS8Qp4Jl4SCYh43EFg5owDjkiF7YuwE=;
 b=i0DMF691RO+F4a9KgdymGqiE+jXMB3AJJrpZYXy6i26gtZniUJseySM8VRtyvl2F4R
 Mc1g32vxgSt/IOJ+YkRaouO+fTKtEgsT8XcNWE1SUMNpIjSsVLAUfDZHZdL7f4CPkJ2U
 +/eRMZSqQyunSdBg+epfAXjiUQkKFeBPzzcRQWXI/86ktljkPpptv/d105FKEs6+lTu3
 ixuySLCksdAqHKjboyQmRGj0z+7Tjpw2XYbaLcApipK5b9ayilSQLl/k5z5gN9zHnSKA
 PO1k8PlxfFu4N3qRMCH/ulB/9pysqfF6zIvpzRTFRkpoJlpNNukfvvYwFF5lG7Iwdp8i
 Ztqg==
X-Gm-Message-State: AOJu0Yy/FdHzTUzAlwTY+V81NO5SYXp6NKGz9XVQJY7L4UhoW3RkSwCh
 m9+F8iPtuaZKbrCt8viCDNZBNRSLfzLy+/JoICLNk3yyXBviWTzBynzCVqbzaxjgpoS2vGwdJkj
 oX58=
X-Google-Smtp-Source: AGHT+IEstdW8PQsdFRUOMAVufW14rgM3Aa2xMKpZHBe1x34N4CQP6y2JmG7L0xIUIEFTO3RPjgVYDw==
X-Received: by 2002:a05:600c:3b12:b0:421:8118:d062 with SMTP id
 5b1f17b1804b1-4218118d424mr44233295e9.6.1718043777929; 
 Mon, 10 Jun 2024 11:22:57 -0700 (PDT)
Received: from localhost.localdomain (adsl-33.37.6.162.tellas.gr.
 [37.6.162.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42161147811sm135487395e9.18.2024.06.10.11.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 11:22:57 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
Date: Mon, 10 Jun 2024 21:22:35 +0300
Message-ID: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello everyone,

This is an early draft of my work on implementing a very simple device, 
in this case the ARM PL011 (which in C code resides in hw/char/pl011.c 
and is used in hw/arm/virt.c).

The device is functional, with copied logic from the C code but with 
effort not to make a direct C to Rust translation. In other words, do 
not write Rust as a C developer would.

That goal is not complete but a best-effort case. To give a specific 
example, register values are typed but interrupt bit flags are not (but 
could be). I will leave such minutiae for later iterations.

By the way, the wiki page for Rust was revived to keep track of all 
current series on the mailing list https://wiki.qemu.org/RustInQemu

a #qemu-rust IRC channel was also created for rust-specific discussion 
that might flood #qemu

------------------------------------------------------------------------
A request: keep comments to Rust in relation to the QEMU project and no 
debates on the merits of the language itself. These are valid concerns, 
but it'd be better if they were on separate mailing list threads.
------------------------------------------------------------------------

Table of contents: [TOC]

- How can I try it? [howcanItryit]
- What are the most important points to focus on, at this point? 
  [whatarethemostimportant]
  - What are the issues with not using the compiler, rustc, directly? 
    [whataretheissueswith]
    1. Tooling
    2. Rust dependencies

  - Should QEMU use third-party dependencies? [shouldqemuusethirdparty]
  - Should QEMU provide wrapping Rust APIs over QEMU internals? 
    [qemuprovidewrappingrustapis]
  - Will QEMU now depend on Rust and thus not build on my XYZ platform? 
    [qemudependonrustnotbuildonxyz]
- How is the compilation structured? [howisthecompilationstructured]
- The generated.rs rust file includes a bunch of junk definitions? 
  [generatedrsincludesjunk]
- The staticlib artifact contains a bunch of mangled .o objects? 
  [staticlibmangledobjects]

How can I try it?
=================
[howcanItryit] Back to [TOC]

Hopefully applying this patches (or checking out `master` branch from 
https://gitlab.com/epilys/rust-for-qemu/ current commit 
de81929e0e9d470deac2c6b449b7a5183325e7ee )

Tag for this RFC is rust-pl011-rfc-v1 

Rustdoc documentation is hosted on

https://rust-for-qemu-epilys-aebb06ca9f9adfe6584811c14ae44156501d935ba4.gitlab.io/pl011/index.html

If `cargo` and `bindgen` is installed in your system, you should be able 
to build qemu-system-aarch64 with configure flag --enable-rust and 
launch an arm virt VM. One of the patches hardcodes the default UART of 
the machine to the Rust one, so if something goes wrong you will see it 
upon launching qemu-system-aarch64.

To confirm it is there for sure, run e.g. info qom-tree on the monitor 
and look for x-pl011-rust.


What are the most important points to focus on, at this point?
==============================================================
[whatarethemostimportant] Back to [TOC]

In my opinion, integration of the go-to Rust build system (Cargo and 
crates.io) with the build system we use in QEMU. This is "easily" done 
in some definition of the word with a python wrapper script.

What are the issues with not using the compiler, rustc, directly?
-----------------------------------------------------------------
[whataretheissueswith] Back to [TOC]

1. Tooling
   Mostly writing up the build-sys tooling to do so. Ideally we'd 
   compile everything without cargo but rustc directly.

   If we decide we need Rust's `std` library support, we could 
   investigate whether building it from scratch is a good solution. This 
   will only build the bits we need in our devices.

2. Rust dependencies
   We could go without them completely. I chose deliberately to include 
   one dependency in my UART implementation, `bilge`[0], because it has 
   an elegant way of representing typed bitfields for the UART's 
   registers.

[0]: Article: https://hecatia-elegua.github.io/blog/no-more-bit-fiddling/
     Crates.io page: https://crates.io/crates/bilge
     Repository: https://github.com/hecatia-elegua/bilge

Should QEMU use third-party dependencies?
-----------------------------------------
[shouldqemuusethirdparty] Back to [TOC]

In my personal opinion, if we need a dependency we need a strong 
argument for it. A dependency needs a trusted upstream source, a QEMU 
maintainer to make sure it us up-to-date in QEMU etc.

We already fetch some projects with meson subprojects, so this is not a 
new reality. Cargo allows you to define "locked" dependencies which is 
the same as only fetching specific commits by SHA. No suspicious 
tarballs, and no disappearing dependencies a la left-pad in npm.

However, I believe it's worth considering vendoring every dependency by 
default, if they prove to be few, for the sake of having a local QEMU 
git clone buildable without network access.

Should QEMU provide wrapping Rust APIs over QEMU internals?
-----------------------------------------------------------
[qemuprovidewrappingrustapis] Back to [TOC]

My personal opinion is no, with the reasoning being that QEMU internals 
are not documented or stable. However I do not see why creating stable 
opt-in interfaces is bad. It just needs someone to volunteer to maintain 
it and ensure there are no breakages through versions.

Will QEMU now depend on Rust and thus not build on my XYZ platform?
-------------------------------------------------------------------
[qemudependonrustnotbuildonxyz] Back to [TOC]

No, worry about this in some years if this experiment takes off. Rust 
has broad platform support and is present in most distro package 
managers. In the future we might have gcc support for it as well.

For now, Rust will have an experimental status, and will be aimed to 
those who wish to try it. I leave it to the project leaders to make 
proper decisions and statements on this if necessary.


How is the compilation structured?
==================================
[howisthecompilationstructured] Back to [TOC]

First, a meson target that runs `bindgen` on a bunch of header files 
(defined in `rust/wrapper.h`) is created as a target and as a dependency 
for any rust hardware device that needs it. You can see the generated 
bindings by running

  ninja generated.rs

inside your build directory.

The devices are defined as dictionaries in rust/meson.build because they 
depend on the bindgen dependency, which is available much later in the 
meson process (when the static qemu lib and target emulator executables 
are defined).

A cargo wrapper python script under scripts/ exists to build the crate 
library, by providing the path to the generated.rs bindings via the 
environment. Then, the qemu-system-aarch64 binary links against the 
staticlib archive (i.e. libpl011.a)

The generated.rs rust file includes a bunch of junk definitions?
================================================================
[generatedrsincludesjunk] Back to [TOC]

Yes, bindgen allows you to block certain types and identifiers from 
being generated but they are simply too many. I have trimmed some of the 
fat but vast improvements can be made.

The staticlib artifact contains a bunch of mangled .o objects?
==============================================================
[staticlibmangledobjects] Back to [TOC]

Yes, until we compile without the `std` module library or we compile it 
manually instead of linking it, we will have some junk in it.

--

Manos Pitsidianakis (6):
  build-sys: Add rust feature option
  rust: add PL011 device model
  DO NOT MERGE: add rustdoc build for gitlab pages
  DO NOT MERGE: replace TYPE_PL011 with x-pl011-rust in arm virt machine
  rust: add bindgen step as a meson dependency
  DO NOT MERGE: update rustdoc gitlab pages gen

 .gitignore                     |   2 +
 .gitlab-ci.d/buildtest.yml     |  64 ++--
 configure                      |  12 +
 hw/arm/virt.c                  |   2 +-
 meson.build                    |  99 ++++++
 meson_options.txt              |   4 +
 rust/meson.build               |  93 ++++++
 rust/pl011/.cargo/config.toml  |   2 +
 rust/pl011/.gitignore          |   2 +
 rust/pl011/Cargo.lock          | 120 +++++++
 rust/pl011/Cargo.toml          |  26 ++
 rust/pl011/README.md           |  42 +++
 rust/pl011/build.rs            |  44 +++
 rust/pl011/meson.build         |   7 +
 rust/pl011/rustfmt.toml        |  10 +
 rust/pl011/src/definitions.rs  |  95 ++++++
 rust/pl011/src/device.rs       | 531 ++++++++++++++++++++++++++++++
 rust/pl011/src/device_class.rs |  95 ++++++
 rust/pl011/src/generated.rs    |   5 +
 rust/pl011/src/lib.rs          | 575 +++++++++++++++++++++++++++++++++
 rust/pl011/src/memory_ops.rs   |  38 +++
 rust/wrapper.h                 |  39 +++
 scripts/cargo_wrapper.py       | 221 +++++++++++++
 scripts/meson-buildoptions.sh  |   5 +
 24 files changed, 2113 insertions(+), 20 deletions(-)
 create mode 100644 rust/meson.build
 create mode 100644 rust/pl011/.cargo/config.toml
 create mode 100644 rust/pl011/.gitignore
 create mode 100644 rust/pl011/Cargo.lock
 create mode 100644 rust/pl011/Cargo.toml
 create mode 100644 rust/pl011/README.md
 create mode 100644 rust/pl011/build.rs
 create mode 100644 rust/pl011/meson.build
 create mode 100644 rust/pl011/rustfmt.toml
 create mode 100644 rust/pl011/src/definitions.rs
 create mode 100644 rust/pl011/src/device.rs
 create mode 100644 rust/pl011/src/device_class.rs
 create mode 100644 rust/pl011/src/generated.rs
 create mode 100644 rust/pl011/src/lib.rs
 create mode 100644 rust/pl011/src/memory_ops.rs
 create mode 100644 rust/wrapper.h
 create mode 100644 scripts/cargo_wrapper.py


base-commit: 01782d6b294f95bcde334386f0aaac593cd28c0d
-- 
γαῖα πυρί μιχθήτω


