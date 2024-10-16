Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8AAD1AD43
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 10:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t11YF-00032g-Rf; Wed, 16 Oct 2024 06:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t11YE-00032M-8o
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:46:46 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t11YA-0006dV-6G
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:46:46 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4608e389407so9045291cf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 03:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729075601; x=1729680401; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rMhCMlT7KHoNzcsVhCVtezYTboNqQkbEppRmnHklnFo=;
 b=QovhSS67kCJYBErDYeU0iK7zQm0LOBmpaWb5HEwYsmNAsenaPMsBGgDyCHyHJn/sju
 BejfiKxQT5aZ0U9h7qY4B20jdMJy8HBhbl7aAwfYHpKd+CL1oRHc4Ijz+5LbrtLC+Jvg
 /ry8SW89u0klfOtqJinUGVPx3ldgqHlspKy4+Cf45w6ypebnZ1oMVSGEfbP3GLt4aOc6
 E9giJ6X52NtC/hYER2ipWMnOzIzH4dtJsFUmbj0+OcazIPRfIN585JoECLZElCGPziMH
 ULDuZLGNV15gkoWDcgAXOIaZ/hFq4zSWyTyQqu6nPeLVJgXYIFGY1kColZlju8rAPQ8h
 lHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729075601; x=1729680401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMhCMlT7KHoNzcsVhCVtezYTboNqQkbEppRmnHklnFo=;
 b=kP+H3nP48hSyTavkNP7R0hXRuAZp/SBZvoqzvKEmzXU8mP1AYUnQLMujpM+iU00VZc
 woSYB64AnY40GCwCc8HsSie0/Or/u/yA/nnRrPBuzRXGNtkRX/kWnMDMD7UMvLNfVW89
 2xnVRQyn0UuFififZpxtfVRn4dQJ0amR+s/Xvcxb8cfLB5qqyMUHJtoQJ/mwcC6cgPAY
 g9Fi1wg/Ayr1ID9FhfonGtRpWQPESjJB6nreze/7XqZn8jNq+AYcXv+atYB2bqkLGa2a
 axODCFTNxRsd2Alk28z6xH2N70R2ynyY1KVnJt2mRVjlgIWoukAycq26448EhmxzorHe
 Jp1w==
X-Gm-Message-State: AOJu0YyHdK2VaAjOv1C4ZkQdu+duHPwU5pC8dwVo4m46LRb3+8AYrxZF
 bPgfJMvKbX/GsTj+8nNL+WHewiWUocHpwXWJMkKTS8fitsMkKQqswx/w+XoTBmkyT6VCd9okSKG
 hTrKkBANF0sQ08cpH7EuM2nN7vv+zzoxDcsg=
X-Google-Smtp-Source: AGHT+IEKfphSxoT96MxlOj/kfPuavSOLqmMQejN5MlzKntBwSXkKIJCkgbc/wknqE2S2vr9OTQHGVTxC13AY73+DtCE=
X-Received: by 2002:a05:622a:c4:b0:458:429a:4d76 with SMTP id
 d75a77b69052e-4608a4b584emr49279621cf.28.1729075600674; Wed, 16 Oct 2024
 03:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241011153227.81770-1-pbonzini@redhat.com>
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 16 Oct 2024 14:46:29 +0400
Message-ID: <CAJ+F1C+pNP5VcnqtuiswSr1PtX69Tr6ME0UY+PWYLAgQA_rU9Q@mail.gmail.com>
Subject: Re: [PULL v3 00/18] Rust initial PoC + meson changes for 2024-10-07
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f7daba062495c860"
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f7daba062495c860
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Oct 11, 2024 at 9:19=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:

> The following changes since commit
> b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into
> staging (2024-10-04 19:28:37 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 381d2c36e1242f849a55f4622e50b9a69cb92842:
>
>   docs: use consistent markup for footnotes (2024-10-11 13:08:32 +0200)
>
> v2->v3: new patches
> - scripts/archive-source: find directory name for subprojects
> - docs: fix invalid footnote syntax
> - docs: avoid footnotes consisting of just URLs
> - docs: use consistent markup for footnotes
>
> ----------------------------------------------------------------
> * first commit for Rust support
> * add CI job using Fedora + Rust nightly
> * fix detection of ATOMIC128 on x86_64
> * fix compilation with Sphinx 8.1.0
>


fwiw, after a rustc update, I got this error:
error[E0514]: found crate `bilge` compiled by an incompatible version of
rustc
... tons of other errors

It is fixed after a ninja clean.

Apparently there is an "old" meson issue:
https://github.com/mesonbuild/meson/issues/10706



> ----------------------------------------------------------------
> Manos Pitsidianakis (6):
>       build-sys: Add rust feature option
>       rust: add bindgen step as a meson dependency
>       .gitattributes: add Rust diff and merge attributes
>       meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
>       rust: add crate to expose bindings and interfaces
>       rust: add utility procedural macro crate
>
> Paolo Bonzini (11):
>       Require meson version 1.5.0
>       configure, meson: detect Rust toolchain
>       scripts/archive-source: find directory name for subprojects
>       rust: add PL011 device model
>       meson: define qemu_isa_flags
>       meson: ensure -mcx16 is passed when detecting ATOMIC128
>       dockerfiles: add a Dockerfile using a nightly Rust toolchain
>       gitlab-ci: add Rust-enabled CI job
>       docs: fix invalid footnote syntax
>       docs: avoid footnotes consisting of just URLs
>       docs: use consistent markup for footnotes
>
> Pierrick Bouvier (1):
>       meson: fix machine option for x86_version
>
>  MAINTAINERS                                        |  21 +
>  docs/devel/atomics.rst                             |   6 +-
>  docs/devel/build-system.rst                        |   6 +-
>  docs/devel/loads-stores.rst                        |   2 +-
>  docs/devel/maintainers.rst                         |   4 +-
>  docs/devel/migration/mapped-ram.rst                |   4 +-
>  docs/devel/testing/acpi-bits.rst                   |  26 +-
>  docs/specs/fw_cfg.rst                              |   4 +-
>  docs/specs/rapl-msr.rst                            |  25 +-
>  configure                                          | 170 +++++-
>  meson.build                                        | 158 +++++-
>  rust/wrapper.h                                     |  47 ++
>  .gitattributes                                     |   3 +
>  .gitlab-ci.d/buildtest.yml                         |  13 +
>  .gitlab-ci.d/containers.yml                        |   6 +
>  Kconfig                                            |   1 +
>  Kconfig.host                                       |   3 +
>  hw/arm/Kconfig                                     |  30 +-
>  meson_options.txt                                  |   3 +
>  python/scripts/vendor.py                           |   4 +-
>  python/wheels/meson-1.2.3-py3-none-any.whl         | Bin 964928 -> 0 byt=
es
>  python/wheels/meson-1.5.0-py3-none-any.whl         | Bin 0 -> 959846 byt=
es
>  pythondeps.toml                                    |   2 +-
>  rust/.gitignore                                    |   3 +
>  rust/Kconfig                                       |   1 +
>  rust/hw/Kconfig                                    |   2 +
>  rust/hw/char/Kconfig                               |   3 +
>  rust/hw/char/meson.build                           |   1 +
>  rust/hw/char/pl011/.gitignore                      |   2 +
>  rust/hw/char/pl011/Cargo.lock                      | 134 +++++
>  rust/hw/char/pl011/Cargo.toml                      |  26 +
>  rust/hw/char/pl011/README.md                       |  31 ++
>  rust/hw/char/pl011/meson.build                     |  26 +
>  rust/hw/char/pl011/src/device.rs                   | 599
> +++++++++++++++++++++
>  rust/hw/char/pl011/src/device_class.rs             |  70 +++
>  rust/hw/char/pl011/src/lib.rs                      | 586
> ++++++++++++++++++++
>  rust/hw/char/pl011/src/memory_ops.rs               |  59 ++
>  rust/hw/meson.build                                |   1 +
>  rust/meson.build                                   |   4 +
>  rust/qemu-api-macros/Cargo.lock                    |  47 ++
>  rust/qemu-api-macros/Cargo.toml                    |  25 +
>  rust/qemu-api-macros/README.md                     |   1 +
>  rust/qemu-api-macros/meson.build                   |  25 +
>  rust/qemu-api-macros/src/lib.rs                    |  43 ++
>  rust/qemu-api/.gitignore                           |   2 +
>  rust/qemu-api/Cargo.lock                           |   7 +
>  rust/qemu-api/Cargo.toml                           |  26 +
>  rust/qemu-api/README.md                            |  17 +
>  rust/qemu-api/build.rs                             |  14 +
>  rust/qemu-api/meson.build                          |  24 +
>  rust/qemu-api/src/definitions.rs                   |  97 ++++
>  rust/qemu-api/src/device_class.rs                  | 128 +++++
>  rust/qemu-api/src/lib.rs                           | 166 ++++++
>  rust/qemu-api/src/tests.rs                         |  49 ++
>  rust/rustfmt.toml                                  |   7 +
>  scripts/archive-source.sh                          |  29 +-
>  scripts/make-release                               |   6 +-
>  scripts/meson-buildoptions.sh                      |   3 +
>  scripts/rust/rust_root_crate.sh                    |  13 +
>  scripts/rust/rustc_args.py                         |  84 +++
>  subprojects/.gitignore                             |  11 +
>  subprojects/arbitrary-int-1-rs.wrap                |   7 +
>  subprojects/bilge-0.2-rs.wrap                      |   7 +
>  subprojects/bilge-impl-0.2-rs.wrap                 |   7 +
>  subprojects/either-1-rs.wrap                       |   7 +
>  subprojects/itertools-0.11-rs.wrap                 |   7 +
>  .../packagefiles/arbitrary-int-1-rs/meson.build    |  19 +
>  subprojects/packagefiles/bilge-0.2-rs/meson.build  |  29 +
>  .../packagefiles/bilge-impl-0.2-rs/meson.build     |  45 ++
>  subprojects/packagefiles/either-1-rs/meson.build   |  24 +
>  .../packagefiles/itertools-0.11-rs/meson.build     |  30 ++
>  .../packagefiles/proc-macro-error-1-rs/meson.build |  40 ++
>  .../proc-macro-error-attr-1-rs/meson.build         |  32 ++
>  .../packagefiles/proc-macro2-1-rs/meson.build      |  31 ++
>  subprojects/packagefiles/quote-1-rs/meson.build    |  29 +
>  subprojects/packagefiles/syn-2-rs/meson.build      |  40 ++
>  .../packagefiles/unicode-ident-1-rs/meson.build    |  20 +
>  subprojects/proc-macro-error-1-rs.wrap             |   7 +
>  subprojects/proc-macro-error-attr-1-rs.wrap        |   7 +
>  subprojects/proc-macro2-1-rs.wrap                  |   7 +
>  subprojects/quote-1-rs.wrap                        |   7 +
>  subprojects/syn-2-rs.wrap                          |   7 +
>  subprojects/unicode-ident-1-rs.wrap                |   7 +
>  subprojects/unicode-ident-1-rs/meson.build         |  20 +
>  .../docker/dockerfiles/fedora-rust-nightly.docker  | 173 ++++++
>  tests/docker/dockerfiles/opensuse-leap.docker      |   2 +-
>  tests/lcitool/mappings.yml                         |   2 +-
>  tests/lcitool/refresh                              |  26 +
>  88 files changed, 3474 insertions(+), 75 deletions(-)
>  create mode 100644 rust/wrapper.h
>  delete mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl
>  create mode 100644 python/wheels/meson-1.5.0-py3-none-any.whl
>  create mode 100644 rust/.gitignore
>  create mode 100644 rust/Kconfig
>  create mode 100644 rust/hw/Kconfig
>  create mode 100644 rust/hw/char/Kconfig
>  create mode 100644 rust/hw/char/meson.build
>  create mode 100644 rust/hw/char/pl011/.gitignore
>  create mode 100644 rust/hw/char/pl011/Cargo.lock
>  create mode 100644 rust/hw/char/pl011/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/README.md
>  create mode 100644 rust/hw/char/pl011/meson.build
>  create mode 100644 rust/hw/char/pl011/src/device.rs
>  create mode 100644 rust/hw/char/pl011/src/device_class.rs
>  create mode 100644 rust/hw/char/pl011/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/src/memory_ops.rs
>  create mode 100644 rust/hw/meson.build
>  create mode 100644 rust/meson.build
>  create mode 100644 rust/qemu-api-macros/Cargo.lock
>  create mode 100644 rust/qemu-api-macros/Cargo.toml
>  create mode 100644 rust/qemu-api-macros/README.md
>  create mode 100644 rust/qemu-api-macros/meson.build
>  create mode 100644 rust/qemu-api-macros/src/lib.rs
>  create mode 100644 rust/qemu-api/.gitignore
>  create mode 100644 rust/qemu-api/Cargo.lock
>  create mode 100644 rust/qemu-api/Cargo.toml
>  create mode 100644 rust/qemu-api/README.md
>  create mode 100644 rust/qemu-api/build.rs
>  create mode 100644 rust/qemu-api/meson.build
>  create mode 100644 rust/qemu-api/src/definitions.rs
>  create mode 100644 rust/qemu-api/src/device_class.rs
>  create mode 100644 rust/qemu-api/src/lib.rs
>  create mode 100644 rust/qemu-api/src/tests.rs
>  create mode 100644 rust/rustfmt.toml
>  create mode 100755 scripts/rust/rust_root_crate.sh
>  create mode 100644 scripts/rust/rustc_args.py
>  create mode 100644 subprojects/arbitrary-int-1-rs.wrap
>  create mode 100644 subprojects/bilge-0.2-rs.wrap
>  create mode 100644 subprojects/bilge-impl-0.2-rs.wrap
>  create mode 100644 subprojects/either-1-rs.wrap
>  create mode 100644 subprojects/itertools-0.11-rs.wrap
>  create mode 100644 subprojects/packagefiles/arbitrary-int-1-rs/meson.bui=
ld
>  create mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
>  create mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson.buil=
d
>  create mode 100644 subprojects/packagefiles/either-1-rs/meson.build
>  create mode 100644 subprojects/packagefiles/itertools-0.11-rs/meson.buil=
d
>  create mode 100644
> subprojects/packagefiles/proc-macro-error-1-rs/meson.build
>  create mode 100644
> subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
>  create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.build
>  create mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
>  create mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
>  create mode 100644 subprojects/packagefiles/unicode-ident-1-rs/meson.bui=
ld
>  create mode 100644 subprojects/proc-macro-error-1-rs.wrap
>  create mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
>  create mode 100644 subprojects/proc-macro2-1-rs.wrap
>  create mode 100644 subprojects/quote-1-rs.wrap
>  create mode 100644 subprojects/syn-2-rs.wrap
>  create mode 100644 subprojects/unicode-ident-1-rs.wrap
>  create mode 100644 subprojects/unicode-ident-1-rs/meson.build
>  create mode 100644 tests/docker/dockerfiles/fedora-rust-nightly.docker
> --
> 2.46.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000f7daba062495c860
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 11, 2024 at 9:19=E2=80=
=AFPM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44eba=
b42775a:<br>
<br>
=C2=A0 Merge tag &#39;for-upstream&#39; of <a href=3D"https://gitlab.com/bo=
nzini/qemu" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/bonzini=
/qemu</a> into staging (2024-10-04 19:28:37 +0100)<br>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/bonzini/qemu.git" rel=3D"noreferrer" t=
arget=3D"_blank">https://gitlab.com/bonzini/qemu.git</a> tags/for-upstream<=
br>
<br>
for you to fetch changes up to 381d2c36e1242f849a55f4622e50b9a69cb92842:<br=
>
<br>
=C2=A0 docs: use consistent markup for footnotes (2024-10-11 13:08:32 +0200=
)<br>
<br>
v2-&gt;v3: new patches<br>
- scripts/archive-source: find directory name for subprojects<br>
- docs: fix invalid footnote syntax<br>
- docs: avoid footnotes consisting of just URLs<br>
- docs: use consistent markup for footnotes<br>
<br>
----------------------------------------------------------------<br>
* first commit for Rust support<br>
* add CI job using Fedora + Rust nightly<br>
* fix detection of ATOMIC128 on x86_64<br>
* fix compilation with Sphinx 8.1.0<br></blockquote><div><br></div><div><br=
></div><div>fwiw, after a rustc update, I got this error:</div><div>error[E=
0514]: found crate `bilge` compiled by an incompatible version of rustc</di=
v><div>... tons of other errors</div><div><br></div><div>It is fixed after =
a ninja clean.</div><div><br></div><div>Apparently there is an &quot;old&qu=
ot; meson issue:<br></div><div><a href=3D"https://github.com/mesonbuild/mes=
on/issues/10706">https://github.com/mesonbuild/meson/issues/10706</a> <br><=
/div><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
----------------------------------------------------------------<br>
Manos Pitsidianakis (6):<br>
=C2=A0 =C2=A0 =C2=A0 build-sys: Add rust feature option<br>
=C2=A0 =C2=A0 =C2=A0 rust: add bindgen step as a meson dependency<br>
=C2=A0 =C2=A0 =C2=A0 .gitattributes: add Rust diff and merge attributes<br>
=C2=A0 =C2=A0 =C2=A0 meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag<br>
=C2=A0 =C2=A0 =C2=A0 rust: add crate to expose bindings and interfaces<br>
=C2=A0 =C2=A0 =C2=A0 rust: add utility procedural macro crate<br>
<br>
Paolo Bonzini (11):<br>
=C2=A0 =C2=A0 =C2=A0 Require meson version 1.5.0<br>
=C2=A0 =C2=A0 =C2=A0 configure, meson: detect Rust toolchain<br>
=C2=A0 =C2=A0 =C2=A0 scripts/archive-source: find directory name for subpro=
jects<br>
=C2=A0 =C2=A0 =C2=A0 rust: add PL011 device model<br>
=C2=A0 =C2=A0 =C2=A0 meson: define qemu_isa_flags<br>
=C2=A0 =C2=A0 =C2=A0 meson: ensure -mcx16 is passed when detecting ATOMIC12=
8<br>
=C2=A0 =C2=A0 =C2=A0 dockerfiles: add a Dockerfile using a nightly Rust too=
lchain<br>
=C2=A0 =C2=A0 =C2=A0 gitlab-ci: add Rust-enabled CI job<br>
=C2=A0 =C2=A0 =C2=A0 docs: fix invalid footnote syntax<br>
=C2=A0 =C2=A0 =C2=A0 docs: avoid footnotes consisting of just URLs<br>
=C2=A0 =C2=A0 =C2=A0 docs: use consistent markup for footnotes<br>
<br>
Pierrick Bouvier (1):<br>
=C2=A0 =C2=A0 =C2=A0 meson: fix machine option for x86_version<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 21 +<br>
=C2=A0docs/devel/atomics.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 =
+-<br>
=C2=A0docs/devel/build-system.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
=C2=A0docs/devel/loads-stores.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0docs/devel/maintainers.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0docs/devel/migration/mapped-ram.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0docs/devel/testing/acpi-bits.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 26 +-<br>
=C2=A0docs/specs/fw_cfg.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-=
<br>
=C2=A0docs/specs/rapl-msr.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 25 +-<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 170 +++++-<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 158 +++++-<br>
=C2=A0rust/wrapper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 47 ++<br>
=C2=A0.gitattributes=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A03 +<br>
=C2=A0.gitlab-ci.d/buildtest.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 13 +<br>
=C2=A0.gitlab-ci.d/containers.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
=C2=A0Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0Kconfig.host=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 30 +-<br>
=C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A03 +<br>
=C2=A0python/scripts/vendor.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0python/wheels/meson-1.2.3-py3-none-any.whl=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| Bin 964928 -&gt; 0 bytes<br>
=C2=A0python/wheels/meson-1.5.0-py3-none-any.whl=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| Bin 0 -&gt; 959846 bytes<br>
=C2=A0pythondeps.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
=C2=A0rust/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A03 +<br>
=C2=A0rust/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0rust/hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +<br>
=C2=A0rust/hw/char/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A03 +<br>
=C2=A0rust/hw/char/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0rust/hw/char/pl011/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0rust/hw/char/pl011/Cargo.lock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 134 +++++<br>
=C2=A0rust/hw/char/pl011/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 26 +<br>
=C2=A0rust/hw/char/pl011/README.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 31 ++<br>
=C2=A0rust/hw/char/pl011/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 26 +<br>
=C2=A0rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=3D"noreferrer=
" target=3D"_blank">device.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 599 +++++++++++++++++++++<br>
=C2=A0rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=3D"nore=
ferrer" target=3D"_blank">device_class.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 70 +++<br>
=C2=A0rust/hw/char/pl011/src/<a href=3D"http://lib.rs" rel=3D"noreferrer" t=
arget=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 586 ++++++++++++++++++++<br>
=C2=A0rust/hw/char/pl011/src/<a href=3D"http://memory_ops.rs" rel=3D"norefe=
rrer" target=3D"_blank">memory_ops.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 59 ++<br>
=C2=A0rust/hw/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A01 +<br>
=C2=A0rust/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A04 +<br>
=C2=A0rust/qemu-api-macros/Cargo.lock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 47 ++<br>
=C2=A0rust/qemu-api-macros/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 25 +<br>
=C2=A0rust/qemu-api-macros/README.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0rust/qemu-api-macros/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 25 +<br>
=C2=A0rust/qemu-api-macros/src/<a href=3D"http://lib.rs" rel=3D"noreferrer"=
 target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 43 ++<br>
=C2=A0rust/qemu-api/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0rust/qemu-api/Cargo.lock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
=C2=A0rust/qemu-api/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 26 +<br>
=C2=A0rust/qemu-api/README.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 17 +<br>
=C2=A0rust/qemu-api/<a href=3D"http://build.rs" rel=3D"noreferrer" target=
=3D"_blank">build.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +<br>
=C2=A0rust/qemu-api/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 24 +<br>
=C2=A0rust/qemu-api/src/<a href=3D"http://definitions.rs" rel=3D"noreferrer=
" target=3D"_blank">definitions.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 97 ++++<br>
=C2=A0rust/qemu-api/src/<a href=3D"http://device_class.rs" rel=3D"noreferre=
r" target=3D"_blank">device_class.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 128 +++++<br>
=C2=A0rust/qemu-api/src/<a href=3D"http://lib.rs" rel=3D"noreferrer" target=
=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 166 ++++++<br>
=C2=A0rust/qemu-api/src/<a href=3D"http://tests.rs" rel=3D"noreferrer" targ=
et=3D"_blank">tests.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 49 ++<br>
=C2=A0rust/rustfmt.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A07 +<br>
=C2=A0scripts/archive-source.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 29 +-<br>
=C2=A0scripts/make-release=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A06 +-<br>
=C2=A0scripts/meson-buildoptions.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0scripts/rust/rust_root_crate.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 13 +<br>
=C2=A0scripts/rust/rustc_args.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 84 +++<br>
=C2=A0subprojects/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 +<br>
=C2=A0subprojects/arbitrary-int-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
=C2=A0subprojects/bilge-0.2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
=C2=A0subprojects/bilge-impl-0.2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
=C2=A0subprojects/either-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
=C2=A0subprojects/itertools-0.11-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
=C2=A0.../packagefiles/arbitrary-int-1-rs/meson.build=C2=A0 =C2=A0 |=C2=A0 =
19 +<br>
=C2=A0subprojects/packagefiles/bilge-0.2-rs/meson.build=C2=A0 |=C2=A0 29 +<=
br>
=C2=A0.../packagefiles/bilge-impl-0.2-rs/meson.build=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 45 ++<br>
=C2=A0subprojects/packagefiles/either-1-rs/meson.build=C2=A0 =C2=A0|=C2=A0 =
24 +<br>
=C2=A0.../packagefiles/itertools-0.11-rs/meson.build=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 30 ++<br>
=C2=A0.../packagefiles/proc-macro-error-1-rs/meson.build |=C2=A0 40 ++<br>
=C2=A0.../proc-macro-error-attr-1-rs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 32 ++<br>
=C2=A0.../packagefiles/proc-macro2-1-rs/meson.build=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 31 ++<br>
=C2=A0subprojects/packagefiles/quote-1-rs/meson.build=C2=A0 =C2=A0 |=C2=A0 =
29 +<br>
=C2=A0subprojects/packagefiles/syn-2-rs/meson.build=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 40 ++<br>
=C2=A0.../packagefiles/unicode-ident-1-rs/meson.build=C2=A0 =C2=A0 |=C2=A0 =
20 +<br>
=C2=A0subprojects/proc-macro-error-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
=C2=A0subprojects/proc-macro-error-attr-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A07 +<br>
=C2=A0subprojects/proc-macro2-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
=C2=A0subprojects/quote-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
=C2=A0subprojects/syn-2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
=C2=A0subprojects/unicode-ident-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
=C2=A0subprojects/unicode-ident-1-rs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 20 +<br>
=C2=A0.../docker/dockerfiles/fedora-rust-nightly.docker=C2=A0 | 173 ++++++<=
br>
=C2=A0tests/docker/dockerfiles/opensuse-leap.docker=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
=C2=A0tests/lcitool/mappings.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0tests/lcitool/refresh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 26 +<br>
=C2=A088 files changed, 3474 insertions(+), 75 deletions(-)<br>
=C2=A0create mode 100644 rust/wrapper.h<br>
=C2=A0delete mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl<br>
=C2=A0create mode 100644 python/wheels/meson-1.5.0-py3-none-any.whl<br>
=C2=A0create mode 100644 rust/.gitignore<br>
=C2=A0create mode 100644 rust/Kconfig<br>
=C2=A0create mode 100644 rust/hw/Kconfig<br>
=C2=A0create mode 100644 rust/hw/char/Kconfig<br>
=C2=A0create mode 100644 rust/hw/char/meson.build<br>
=C2=A0create mode 100644 rust/hw/char/pl011/.gitignore<br>
=C2=A0create mode 100644 rust/hw/char/pl011/Cargo.lock<br>
=C2=A0create mode 100644 rust/hw/char/pl011/Cargo.toml<br>
=C2=A0create mode 100644 rust/hw/char/pl011/README.md<br>
=C2=A0create mode 100644 rust/hw/char/pl011/meson.build<br>
=C2=A0create mode 100644 rust/hw/char/pl011/src/<a href=3D"http://device.rs=
" rel=3D"noreferrer" target=3D"_blank">device.rs</a><br>
=C2=A0create mode 100644 rust/hw/char/pl011/src/<a href=3D"http://device_cl=
ass.rs" rel=3D"noreferrer" target=3D"_blank">device_class.rs</a><br>
=C2=A0create mode 100644 rust/hw/char/pl011/src/<a href=3D"http://lib.rs" r=
el=3D"noreferrer" target=3D"_blank">lib.rs</a><br>
=C2=A0create mode 100644 rust/hw/char/pl011/src/<a href=3D"http://memory_op=
s.rs" rel=3D"noreferrer" target=3D"_blank">memory_ops.rs</a><br>
=C2=A0create mode 100644 rust/hw/meson.build<br>
=C2=A0create mode 100644 rust/meson.build<br>
=C2=A0create mode 100644 rust/qemu-api-macros/Cargo.lock<br>
=C2=A0create mode 100644 rust/qemu-api-macros/Cargo.toml<br>
=C2=A0create mode 100644 rust/qemu-api-macros/README.md<br>
=C2=A0create mode 100644 rust/qemu-api-macros/meson.build<br>
=C2=A0create mode 100644 rust/qemu-api-macros/src/<a href=3D"http://lib.rs"=
 rel=3D"noreferrer" target=3D"_blank">lib.rs</a><br>
=C2=A0create mode 100644 rust/qemu-api/.gitignore<br>
=C2=A0create mode 100644 rust/qemu-api/Cargo.lock<br>
=C2=A0create mode 100644 rust/qemu-api/Cargo.toml<br>
=C2=A0create mode 100644 rust/qemu-api/README.md<br>
=C2=A0create mode 100644 rust/qemu-api/<a href=3D"http://build.rs" rel=3D"n=
oreferrer" target=3D"_blank">build.rs</a><br>
=C2=A0create mode 100644 rust/qemu-api/meson.build<br>
=C2=A0create mode 100644 rust/qemu-api/src/<a href=3D"http://definitions.rs=
" rel=3D"noreferrer" target=3D"_blank">definitions.rs</a><br>
=C2=A0create mode 100644 rust/qemu-api/src/<a href=3D"http://device_class.r=
s" rel=3D"noreferrer" target=3D"_blank">device_class.rs</a><br>
=C2=A0create mode 100644 rust/qemu-api/src/<a href=3D"http://lib.rs" rel=3D=
"noreferrer" target=3D"_blank">lib.rs</a><br>
=C2=A0create mode 100644 rust/qemu-api/src/<a href=3D"http://tests.rs" rel=
=3D"noreferrer" target=3D"_blank">tests.rs</a><br>
=C2=A0create mode 100644 rust/rustfmt.toml<br>
=C2=A0create mode 100755 scripts/rust/rust_root_crate.sh<br>
=C2=A0create mode 100644 scripts/rust/rustc_args.py<br>
=C2=A0create mode 100644 subprojects/arbitrary-int-1-rs.wrap<br>
=C2=A0create mode 100644 subprojects/bilge-0.2-rs.wrap<br>
=C2=A0create mode 100644 subprojects/bilge-impl-0.2-rs.wrap<br>
=C2=A0create mode 100644 subprojects/either-1-rs.wrap<br>
=C2=A0create mode 100644 subprojects/itertools-0.11-rs.wrap<br>
=C2=A0create mode 100644 subprojects/packagefiles/arbitrary-int-1-rs/meson.=
build<br>
=C2=A0create mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build<=
br>
=C2=A0create mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson.b=
uild<br>
=C2=A0create mode 100644 subprojects/packagefiles/either-1-rs/meson.build<b=
r>
=C2=A0create mode 100644 subprojects/packagefiles/itertools-0.11-rs/meson.b=
uild<br>
=C2=A0create mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/mes=
on.build<br>
=C2=A0create mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-r=
s/meson.build<br>
=C2=A0create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.bu=
ild<br>
=C2=A0create mode 100644 subprojects/packagefiles/quote-1-rs/meson.build<br=
>
=C2=A0create mode 100644 subprojects/packagefiles/syn-2-rs/meson.build<br>
=C2=A0create mode 100644 subprojects/packagefiles/unicode-ident-1-rs/meson.=
build<br>
=C2=A0create mode 100644 subprojects/proc-macro-error-1-rs.wrap<br>
=C2=A0create mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap<br>
=C2=A0create mode 100644 subprojects/proc-macro2-1-rs.wrap<br>
=C2=A0create mode 100644 subprojects/quote-1-rs.wrap<br>
=C2=A0create mode 100644 subprojects/syn-2-rs.wrap<br>
=C2=A0create mode 100644 subprojects/unicode-ident-1-rs.wrap<br>
=C2=A0create mode 100644 subprojects/unicode-ident-1-rs/meson.build<br>
=C2=A0create mode 100644 tests/docker/dockerfiles/fedora-rust-nightly.docke=
r<br>
-- <br>
2.46.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000f7daba062495c860--

