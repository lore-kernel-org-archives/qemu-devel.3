Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836C4CA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 11:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sloEp-0008LX-D1; Wed, 04 Sep 2024 07:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sloEl-00086W-T3
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sloEh-0008CL-Pz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725449502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XG3M556PV20dQp4j8vPrmj8CZGZ9XeBIePzlHOaHQEo=;
 b=SfB23bcmnmwwHZCHOe3Zj7R9SiYlrMduqQ+vkQjhQmSKICgUX+MOQrDFcY1f2t/oE7YfOp
 ZrLdc4PjK7sXNqnNcoNWuHeB2W8or96o02AA1fQiVtOGYcEHhz2Njt5+jDBZ2u94k4EEus
 v9bGuB3z5AXB2ig2MNTQG29EvyKgdyI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-VGKkL8bYPJ6EWUXdo-eC4w-1; Wed, 04 Sep 2024 07:31:41 -0400
X-MC-Unique: VGKkL8bYPJ6EWUXdo-eC4w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c3402d93so2519323f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 04:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725449500; x=1726054300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XG3M556PV20dQp4j8vPrmj8CZGZ9XeBIePzlHOaHQEo=;
 b=uCKo8E8SbnhXsEpuEGI6b/AfJSCsIp4VQUIPxYqqOV/PhWA8S3QMuPxnE+vcUAupXK
 SO8cia1KrAp5NqSuMfKjK0zlCJ36uM33bPUIJtDOo+1fRfQ081Sb3QN9Wr7sxjgKQ9wt
 +iXxj/G3iCzyJmxDgQLq+z0jIVH3OjqxSjO9ldIilvGipGeYsP0BOKiqNvM6qTsXLoIQ
 HCEFKCAxSPMETG9G2rZMQ/xkXmw2e+CXhXOrtEstTwcJpoTo+9ie0FGfVNTm7DFfj46Y
 FykaMwZCMra6cuFwX3yBtws7pZb2lVUr5+7ZcsMt4FoIc8U+ozu+wPf2bvyXIfbgvMJn
 p1iQ==
X-Gm-Message-State: AOJu0YzPi+nndAQtUu1w2ED7zia0Zu8vcBh14WB4tDLljEzpTZkiM78K
 OEH3PhEJsNLesZg/WoSn2kA9QWHs+FFPHynasA0fR37md4hj+v0OdDFInZZSD5TC60Lb6MPkIIY
 ng+AYPyBUOt5t6+FWk69jnCU56JNXGS0fXkmuluH2vA1wl+b0Ifu6RvxlwhQXx9Tspk9bNFuK6r
 uwM5J0mDIlDu11Mc8OLpuCZAX4N8k=
X-Received: by 2002:adf:e9c4:0:b0:374:bad0:2b72 with SMTP id
 ffacd0b85a97d-374bad02cdfmr8969725f8f.11.1725449500051; 
 Wed, 04 Sep 2024 04:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE72927S52oUfXkRPQ9+OUTDQPiNdrYQEcZU9D5nINGmX7oomVNem6FKaWEDjeSn9eGUyN6tFyRtN/NGwk2XL0=
X-Received: by 2002:adf:e9c4:0:b0:374:bad0:2b72 with SMTP id
 ffacd0b85a97d-374bad02cdfmr8969705f8f.11.1725449499535; Wed, 04 Sep 2024
 04:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
In-Reply-To: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 4 Sep 2024 13:31:27 +0200
Message-ID: <CABgObfbH6cmYz5tO9iVMmf3TAF2ZLqp8m2PzBKBRzoPbL4Jy1w@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 0/9] Add Rust build support,
 ARM PL011 device impl
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Aug 28, 2024 at 6:12=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> - Addressed v8 review comment: removed rustfmt.toml symlink (Junjie Mao)
> - Addressed v8 review comment: removed unused cstr files (Junjie Mao)
> - Addressed v8 review comment: added HAVE_GLIB_WITH_ALIGNED_ALLOC config
>   host def to check whether glib's aligned alloc functions are available =
(Junjie Mao)
> - qemu_api: Changed default alignment condition in allocator (alignment
>   is always nonzero)
> - qemu_api: Enabled allocator by default in builds
> - pl011: fixed invalid cast of byte buffer to u32 in pl011_receive()
>   leading to misaligned read

Looks generally good, the main sticky issue is the clang/libclang path
consistency (but good job finding LIBCLANG_PATH by the way!).

As mentioned in the individual review, I would remove the allocator
completely (and if you really wanted it, you should implement
alloc_zeroed and realloc too because the default implementations in
GlobalAlloc are inefficient).

For the cross compilation patch, if you want you can include in v10
what is at https://paste.debian.net/1328408/.

Paolo

> - Link to v8: https://lore.kernel.org/r/20240823-rust-pl011-v8-0-b9f5746b=
daf3@linaro.org
>
> Changes in v8:
> - Allow for compilation of more than one Rust-based component in Meson
>   by compiling all Rust static libraries into one "root" library before
>   linking it to each target emulation executable.
> - Added a qemu_api_macros procedural macro library.
> - (minor) Moved generated bindings.rs to qemu_api crate using meson's
>   structured_source() instead of compiling it as a standalone crate
>   which was unnecessary.
> - (minor) Removed unnecessary rustc optimization/debug flags (should be h=
andled
>   by meson instead).
> - (minor) Moved build scripts under scripts/rust/
> - (minor) Fixed license issues
>
> Previous version was: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
>
> https://lore.kernel.org/qemu-devel/20240815-rust-pl011-v7-0-975135e98831@=
linaro.org/
>
> Outstanding issues that are not blocking for merge are:
>
> - Cross-compilation for aarch64 is not possible out-of-the-box because of=
 this bug:
>   <https://github.com/rust-lang/rust/issues/125619> in llvm which when
>   fixed, must be ported to upstream rust's llvm fork. Since the problem
>   is an extraneous symbol we could strip it with objcopy -N|--strip-symbo=
l
>   Update since last version: Fix is in upstream llvm, we're awaiting for
>   rust upstream to pick it up.
>
> ---
> Manos Pitsidianakis (7):
>       build-sys: Add rust feature option
>       rust: add bindgen step as a meson dependency
>       .gitattributes: add Rust diff and merge attributes
>       meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
>       rust: add crate to expose bindings and interfaces
>       rust: add utility procedural macro crate
>       rust: add PL011 device model
>
> Paolo Bonzini (2):
>       Require meson version 1.5.0
>       configure, meson: detect Rust toolchain
>
>  MAINTAINERS                                        |  21 +
>  configure                                          |  50 +-
>  meson.build                                        |  87 ++-
>  rust/wrapper.h                                     |  39 ++
>  .gitattributes                                     |   3 +
>  Kconfig                                            |   1 +
>  Kconfig.host                                       |   3 +
>  hw/arm/Kconfig                                     |  33 +-
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
>  rust/hw/char/pl011/src/definitions.rs              |  20 +
>  rust/hw/char/pl011/src/device.rs                   | 594 +++++++++++++++=
++++++
>  rust/hw/char/pl011/src/device_class.rs             |  59 ++
>  rust/hw/char/pl011/src/lib.rs                      | 585 +++++++++++++++=
+++++
>  rust/hw/char/pl011/src/memory_ops.rs               |  57 ++
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
>  rust/qemu-api/src/definitions.rs                   | 109 ++++
>  rust/qemu-api/src/device_class.rs                  | 128 +++++
>  rust/qemu-api/src/lib.rs                           | 154 ++++++
>  rust/qemu-api/src/tests.rs                         |  49 ++
>  rust/rustfmt.toml                                  |   7 +
>  scripts/archive-source.sh                          |   5 +-
>  scripts/make-release                               |   5 +-
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
>  tests/lcitool/mappings.yml                         |   2 +-
>  75 files changed, 2991 insertions(+), 21 deletions(-)
> ---
> base-commit: a733f37aef3b7d1d33bfe2716af88cdfd67ba64e
> change-id: 20240814-rust-pl011-v7
>
> Best regards,
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>


