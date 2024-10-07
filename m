Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31D5CFB455
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtCs-0003DZ-8E; Mon, 07 Oct 2024 15:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxtCl-0003D8-Ru
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxtCh-0003yY-KN
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728328534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8YVescqDecpfgnDzMyXfvSLxOFNCFHihgWG54ASt08A=;
 b=fymwUh0ryGMKpGv6ryKUnEQseESt/OKMdvDV1RoJuPvd8orezokNbIy5zrCXFvfeNJl17l
 /yxAZ+J/g+NJoWbdeyxY8M1M3xOMqWYPiYd6UyYsqyp5GK5KbyHyn/D+fdkSMCU/4hQP+5
 Za0pgwMDoHUu2k+jBfP3+cIntiR5uUc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-tTWoXY9GPYCQnoEdvm00vQ-1; Mon, 07 Oct 2024 15:15:28 -0400
X-MC-Unique: tTWoXY9GPYCQnoEdvm00vQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37cd282fb39so3027960f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 12:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728328526; x=1728933326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8YVescqDecpfgnDzMyXfvSLxOFNCFHihgWG54ASt08A=;
 b=nCaJmix9hFc/lCEvy88VydcQz56tbrIfWWWr6/jHh79k+OfTFhUTAwCyM6hwFrbMfu
 qxd77oqwgC8huYyqqLW6EaeZanQvRHSA1lGOr0XwypEFsuHIl6QCX2WEKsH/UMOzqbCC
 YcUVyD5YlzNZXhMGPIf+oS2CxHS9XSTpsSvvP2VG/6bAfQhMhTEs8bu67AjD5bqau3de
 txVFzjBc36l04Z5742kRlxzZjUb7XFG00YhCK60Fddeoy4L4dVeTck4uOqM84FexUb1h
 nwvjsKja6+9kdq7kcNmwgKtNDNjJombDRt3EQB744QiG+PbTY1WQoIYGAymTic0yswpG
 E5bw==
X-Gm-Message-State: AOJu0Yw0FEVIZeMT2GuZ74qw5bjoEz2wR3+xSF52aNskn4zkZryuPKQt
 OVYAs3wpf51Kt3sTLx8SkgnSrgP6ARYkZM5i57XIIqTaSr61ipu17MjiEfU+xh+vdetWQfsW3WH
 opKHz8lGcO9ZiAY4luhZ+YMdYGxXiOXFOlljz5PlUnvVtw+UJJjDOlSMr9S+Xtm7kg0gIitnRTS
 JT9Ou6mgmLeJus4en8zB6PFWqZ3l4=
X-Received: by 2002:adf:ea86:0:b0:37c:c628:51b4 with SMTP id
 ffacd0b85a97d-37d0e8e8b94mr7652698f8f.45.1728328526509; 
 Mon, 07 Oct 2024 12:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1Xu8jKhkbIF/5zBg0SV8+8EPeBTyLCaejXP+ihOyBACR1HScONbiaU5LPPOz4LP9EBhCR0G3NViOzio3NuLU=
X-Received: by 2002:adf:ea86:0:b0:37c:c628:51b4 with SMTP id
 ffacd0b85a97d-37d0e8e8b94mr7652676f8f.45.1728328525914; Mon, 07 Oct 2024
 12:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20241007110342.1298598-1-pbonzini@redhat.com>
 <cf288711-259e-4b06-96aa-6c681b263bee@quicinc.com>
In-Reply-To: <cf288711-259e-4b06-96aa-6c681b263bee@quicinc.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 7 Oct 2024 21:15:12 +0200
Message-ID: <CABgObfa9Zsn47PEoNfDBOg3sbkzXa-Cz4QLocCH9E=3yz8T4Xg@mail.gmail.com>
Subject: Re: [PULL 00/12] Rust initial PoC + meson changes for 2024-10-07
To: Brian Cain <quic_bcain@quicinc.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, 
 junjie.mao@intel.com, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d7bee70623e7d7f4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000d7bee70623e7d7f4
Content-Type: text/plain; charset="UTF-8"

Il lun 7 ott 2024, 19:56 Brian Cain <quic_bcain@quicinc.com> ha scritto:

>
> On 10/7/2024 6:03 AM, Paolo Bonzini wrote:
> > The following changes since commit
> b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:
> >
> >    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into
> staging (2024-10-04 19:28:37 +0100)
> >
> > are available in the Git repository at:
> >
> >    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to dec4b629fc17fedcd2172066071f99ec8dcc8d8d:
> >
> >    meson: ensure -mcx16 is passed when detecting ATOMIC128 (2024-10-07
> 13:01:06 +0200)
> >
> > ----------------------------------------------------------------
> > * first commit for Rust support
>
> Aside: Paolo, thanks for your work here!


Thanks to Manos, I am just the shepherd. :)

So far I think the focus for Rust support has been on device models.  But
> is there any interest in
> being able to write TCG plugins in Rust
>

Is there a good degree of ABI compatibility across QEMU versions? If so,
plugins are external shared libraries and therefore they could be built
(with Cargo) independent of any QEMU code.

I am not involved in plugins work, so I am not the best person to answer!

Paolo


>
> This project https://github.com/novafacing/qemu-rs seems to explore this
> space - maybe it would be good to incorporate something like this inside
> of QEMU?
>
> > * fix detection of ATOMIC128 on x86_64
> >
> > ----------------------------------------------------------------
> > Manos Pitsidianakis (7):
> >        build-sys: Add rust feature option
> >        rust: add bindgen step as a meson dependency
> >        .gitattributes: add Rust diff and merge attributes
> >        meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
> >        rust: add crate to expose bindings and interfaces
> >        rust: add utility procedural macro crate
> >        rust: add PL011 device model
> >
> > Paolo Bonzini (4):
> >        Require meson version 1.5.0
> >        configure, meson: detect Rust toolchain
> >        meson: define qemu_isa_flags
> >        meson: ensure -mcx16 is passed when detecting ATOMIC128
> >
> > Pierrick Bouvier (1):
> >        meson: fix machine option for x86_version
> >
> >   MAINTAINERS                                        |  21 +
> >   configure                                          | 170 +++++-
> >   meson.build                                        | 158 +++++-
> >   rust/wrapper.h                                     |  47 ++
> >   .gitattributes                                     |   3 +
> >   Kconfig                                            |   1 +
> >   Kconfig.host                                       |   3 +
> >   hw/arm/Kconfig                                     |  30 +-
> >   meson_options.txt                                  |   3 +
> >   python/scripts/vendor.py                           |   4 +-
> >   python/wheels/meson-1.2.3-py3-none-any.whl         | Bin 964928 -> 0
> bytes
> >   python/wheels/meson-1.5.0-py3-none-any.whl         | Bin 0 -> 959846
> bytes
> >   pythondeps.toml                                    |   2 +-
> >   rust/.gitignore                                    |   3 +
> >   rust/Kconfig                                       |   1 +
> >   rust/hw/Kconfig                                    |   2 +
> >   rust/hw/char/Kconfig                               |   3 +
> >   rust/hw/char/meson.build                           |   1 +
> >   rust/hw/char/pl011/.gitignore                      |   2 +
> >   rust/hw/char/pl011/Cargo.lock                      | 134 +++++
> >   rust/hw/char/pl011/Cargo.toml                      |  26 +
> >   rust/hw/char/pl011/README.md                       |  31 ++
> >   rust/hw/char/pl011/meson.build                     |  26 +
> >   rust/hw/char/pl011/src/device.rs                   | 599
> +++++++++++++++++++++
> >   rust/hw/char/pl011/src/device_class.rs             |  70 +++
> >   rust/hw/char/pl011/src/lib.rs                      | 586
> ++++++++++++++++++++
> >   rust/hw/char/pl011/src/memory_ops.rs               |  59 ++
> >   rust/hw/meson.build                                |   1 +
> >   rust/meson.build                                   |   4 +
> >   rust/qemu-api-macros/Cargo.lock                    |  47 ++
> >   rust/qemu-api-macros/Cargo.toml                    |  25 +
> >   rust/qemu-api-macros/README.md                     |   1 +
> >   rust/qemu-api-macros/meson.build                   |  25 +
> >   rust/qemu-api-macros/src/lib.rs                    |  43 ++
> >   rust/qemu-api/.gitignore                           |   2 +
> >   rust/qemu-api/Cargo.lock                           |   7 +
> >   rust/qemu-api/Cargo.toml                           |  26 +
> >   rust/qemu-api/README.md                            |  17 +
> >   rust/qemu-api/build.rs                             |  14 +
> >   rust/qemu-api/meson.build                          |  24 +
> >   rust/qemu-api/src/definitions.rs                   |  97 ++++
> >   rust/qemu-api/src/device_class.rs                  | 128 +++++
> >   rust/qemu-api/src/lib.rs                           | 166 ++++++
> >   rust/qemu-api/src/tests.rs                         |  49 ++
> >   rust/rustfmt.toml                                  |   7 +
> >   scripts/archive-source.sh                          |   6 +-
> >   scripts/make-release                               |   5 +-
> >   scripts/meson-buildoptions.sh                      |   3 +
> >   scripts/rust/rust_root_crate.sh                    |  13 +
> >   scripts/rust/rustc_args.py                         |  84 +++
> >   subprojects/.gitignore                             |  11 +
> >   subprojects/arbitrary-int-1-rs.wrap                |   7 +
> >   subprojects/bilge-0.2-rs.wrap                      |   7 +
> >   subprojects/bilge-impl-0.2-rs.wrap                 |   7 +
> >   subprojects/either-1-rs.wrap                       |   7 +
> >   subprojects/itertools-0.11-rs.wrap                 |   7 +
> >   .../packagefiles/arbitrary-int-1-rs/meson.build    |  19 +
> >   subprojects/packagefiles/bilge-0.2-rs/meson.build  |  29 +
> >   .../packagefiles/bilge-impl-0.2-rs/meson.build     |  45 ++
> >   subprojects/packagefiles/either-1-rs/meson.build   |  24 +
> >   .../packagefiles/itertools-0.11-rs/meson.build     |  30 ++
> >   .../packagefiles/proc-macro-error-1-rs/meson.build |  40 ++
> >   .../proc-macro-error-attr-1-rs/meson.build         |  32 ++
> >   .../packagefiles/proc-macro2-1-rs/meson.build      |  31 ++
> >   subprojects/packagefiles/quote-1-rs/meson.build    |  29 +
> >   subprojects/packagefiles/syn-2-rs/meson.build      |  40 ++
> >   .../packagefiles/unicode-ident-1-rs/meson.build    |  20 +
> >   subprojects/proc-macro-error-1-rs.wrap             |   7 +
> >   subprojects/proc-macro-error-attr-1-rs.wrap        |   7 +
> >   subprojects/proc-macro2-1-rs.wrap                  |   7 +
> >   subprojects/quote-1-rs.wrap                        |   7 +
> >   subprojects/syn-2-rs.wrap                          |   7 +
> >   subprojects/unicode-ident-1-rs.wrap                |   7 +
> >   subprojects/unicode-ident-1-rs/meson.build         |  20 +
> >   tests/lcitool/mappings.yml                         |   2 +-
> >   75 files changed, 3194 insertions(+), 34 deletions(-)
> >   create mode 100644 rust/wrapper.h
> >   delete mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl
> >   create mode 100644 python/wheels/meson-1.5.0-py3-none-any.whl
> >   create mode 100644 rust/.gitignore
> >   create mode 100644 rust/Kconfig
> >   create mode 100644 rust/hw/Kconfig
> >   create mode 100644 rust/hw/char/Kconfig
> >   create mode 100644 rust/hw/char/meson.build
> >   create mode 100644 rust/hw/char/pl011/.gitignore
> >   create mode 100644 rust/hw/char/pl011/Cargo.lock
> >   create mode 100644 rust/hw/char/pl011/Cargo.toml
> >   create mode 100644 rust/hw/char/pl011/README.md
> >   create mode 100644 rust/hw/char/pl011/meson.build
> >   create mode 100644 rust/hw/char/pl011/src/device.rs
> >   create mode 100644 rust/hw/char/pl011/src/device_class.rs
> >   create mode 100644 rust/hw/char/pl011/src/lib.rs
> >   create mode 100644 rust/hw/char/pl011/src/memory_ops.rs
> >   create mode 100644 rust/hw/meson.build
> >   create mode 100644 rust/meson.build
> >   create mode 100644 rust/qemu-api-macros/Cargo.lock
> >   create mode 100644 rust/qemu-api-macros/Cargo.toml
> >   create mode 100644 rust/qemu-api-macros/README.md
> >   create mode 100644 rust/qemu-api-macros/meson.build
> >   create mode 100644 rust/qemu-api-macros/src/lib.rs
> >   create mode 100644 rust/qemu-api/.gitignore
> >   create mode 100644 rust/qemu-api/Cargo.lock
> >   create mode 100644 rust/qemu-api/Cargo.toml
> >   create mode 100644 rust/qemu-api/README.md
> >   create mode 100644 rust/qemu-api/build.rs
> >   create mode 100644 rust/qemu-api/meson.build
> >   create mode 100644 rust/qemu-api/src/definitions.rs
> >   create mode 100644 rust/qemu-api/src/device_class.rs
> >   create mode 100644 rust/qemu-api/src/lib.rs
> >   create mode 100644 rust/qemu-api/src/tests.rs
> >   create mode 100644 rust/rustfmt.toml
> >   create mode 100755 scripts/rust/rust_root_crate.sh
> >   create mode 100644 scripts/rust/rustc_args.py
> >   create mode 100644 subprojects/arbitrary-int-1-rs.wrap
> >   create mode 100644 subprojects/bilge-0.2-rs.wrap
> >   create mode 100644 subprojects/bilge-impl-0.2-rs.wrap
> >   create mode 100644 subprojects/either-1-rs.wrap
> >   create mode 100644 subprojects/itertools-0.11-rs.wrap
> >   create mode 100644
> subprojects/packagefiles/arbitrary-int-1-rs/meson.build
> >   create mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
> >   create mode 100644
> subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
> >   create mode 100644 subprojects/packagefiles/either-1-rs/meson.build
> >   create mode 100644
> subprojects/packagefiles/itertools-0.11-rs/meson.build
> >   create mode 100644
> subprojects/packagefiles/proc-macro-error-1-rs/meson.build
> >   create mode 100644
> subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
> >   create mode 100644
> subprojects/packagefiles/proc-macro2-1-rs/meson.build
> >   create mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
> >   create mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
> >   create mode 100644
> subprojects/packagefiles/unicode-ident-1-rs/meson.build
> >   create mode 100644 subprojects/proc-macro-error-1-rs.wrap
> >   create mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
> >   create mode 100644 subprojects/proc-macro2-1-rs.wrap
> >   create mode 100644 subprojects/quote-1-rs.wrap
> >   create mode 100644 subprojects/syn-2-rs.wrap
> >   create mode 100644 subprojects/unicode-ident-1-rs.wrap
> >   create mode 100644 subprojects/unicode-ident-1-rs/meson.build
>
>

--000000000000d7bee70623e7d7f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 7 ott 2024, 19:56 Brian Cain &lt;<a href=3D"mai=
lto:quic_bcain@quicinc.com">quic_bcain@quicinc.com</a>&gt; ha scritto:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 10/7/2024 6:03 AM, Paolo Bonzini wrote:<br>
&gt; The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab4=
2775a:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 Merge tag &#39;for-upstream&#39; of <a href=3D"https://gi=
tlab.com/bonzini/qemu" rel=3D"noreferrer noreferrer" target=3D"_blank">http=
s://gitlab.com/bonzini/qemu</a> into staging (2024-10-04 19:28:37 +0100)<br=
>
&gt;<br>
&gt; are available in the Git repository at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://gitlab.com/bonzini/qemu.git" rel=3D"no=
referrer noreferrer" target=3D"_blank">https://gitlab.com/bonzini/qemu.git<=
/a> tags/for-upstream<br>
&gt;<br>
&gt; for you to fetch changes up to dec4b629fc17fedcd2172066071f99ec8dcc8d8=
d:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 meson: ensure -mcx16 is passed when detecting ATOMIC128 (=
2024-10-07 13:01:06 +0200)<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; * first commit for Rust support<br>
<br>
Aside: Paolo, thanks for your work here!</blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Thanks to Manos, I am just the shephe=
rd. :)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">So far I think =
the focus for Rust support has been on device models.=C2=A0 But is there an=
y interest in <br>
being able to write TCG plugins in Rust<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Is there a good degree of ABI compat=
ibility across QEMU versions? If so, plugins are external shared libraries =
and therefore they could be built (with Cargo) independent of any QEMU code=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I am not involved in p=
lugins work, so I am not the best person to answer!</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
<br>
This project <a href=3D"https://github.com/novafacing/qemu-rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">https://github.com/novafacing/qemu-rs</=
a> seems to explore this <br>
space - maybe it would be good to incorporate something like this inside <b=
r>
of QEMU?<br>
<br>
&gt; * fix detection of ATOMIC128 on x86_64<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; Manos Pitsidianakis (7):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 build-sys: Add rust feature option<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 rust: add bindgen step as a meson dependenc=
y<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 .gitattributes: add Rust diff and merge att=
ributes<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 meson.build: add HAVE_GLIB_WITH_ALIGNED_ALL=
OC flag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 rust: add crate to expose bindings and inte=
rfaces<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 rust: add utility procedural macro crate<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 rust: add PL011 device model<br>
&gt;<br>
&gt; Paolo Bonzini (4):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Require meson version 1.5.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 configure, meson: detect Rust toolchain<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 meson: define qemu_isa_flags<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 meson: ensure -mcx16 is passed when detecti=
ng ATOMIC128<br>
&gt;<br>
&gt; Pierrick Bouvier (1):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 meson: fix machine option for x86_version<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 21 +<br>
&gt;=C2=A0 =C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 170 +++++-<br>
&gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 158 +++++-<br>
&gt;=C2=A0 =C2=A0rust/wrapper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 47 ++<br>
&gt;=C2=A0 =C2=A0.gitattributes=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0Kconfig.host=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 30 +-<br>
&gt;=C2=A0 =C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0python/scripts/vendor.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A04 +-<br>
&gt;=C2=A0 =C2=A0python/wheels/meson-1.2.3-py3-none-any.whl=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| Bin 964928 -&gt; 0 bytes<br>
&gt;=C2=A0 =C2=A0python/wheels/meson-1.5.0-py3-none-any.whl=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| Bin 0 -&gt; 959846 bytes<br>
&gt;=C2=A0 =C2=A0pythondeps.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0rust/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0rust/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0rust/hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0rust/hw/char/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0rust/hw/char/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
&gt;=C2=A0 =C2=A0rust/hw/char/pl011/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0rust/hw/char/pl011/Cargo.lock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 134 +++++<br>
&gt;=C2=A0 =C2=A0rust/hw/char/pl011/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 26 +<br>
&gt;=C2=A0 =C2=A0rust/hw/char/pl011/README.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 31 ++<br>
&gt;=C2=A0 =C2=A0rust/hw/char/pl011/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 26 +<br>
&gt;=C2=A0 =C2=A0rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=3D=
"noreferrer noreferrer" target=3D"_blank">device.rs</a>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 599 ++++++++++++++++++++=
+<br>
&gt;=C2=A0 =C2=A0rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" =
rel=3D"noreferrer noreferrer" target=3D"_blank">device_class.rs</a>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 70 +++<br>
&gt;=C2=A0 =C2=A0rust/hw/char/pl011/src/<a href=3D"http://lib.rs" rel=3D"no=
referrer noreferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 586 ++++++++++++++++=
++++<br>
&gt;=C2=A0 =C2=A0rust/hw/char/pl011/src/<a href=3D"http://memory_ops.rs" re=
l=3D"noreferrer noreferrer" target=3D"_blank">memory_ops.rs</a>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 59 ++<br>
&gt;=C2=A0 =C2=A0rust/hw/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0rust/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0rust/qemu-api-macros/Cargo.lock=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 47 ++<br>
&gt;=C2=A0 =C2=A0rust/qemu-api-macros/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 25 +<br>
&gt;=C2=A0 =C2=A0rust/qemu-api-macros/README.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0rust/qemu-api-macros/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 25 +<br>
&gt;=C2=A0 =C2=A0rust/qemu-api-macros/src/<a href=3D"http://lib.rs" rel=3D"=
noreferrer noreferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 43 ++<br>
&gt;=C2=A0 =C2=A0rust/qemu-api/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +<br>
&gt;=C2=A0 =C2=A0rust/qemu-api/Cargo.lock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A07 +<br>
&gt;=C2=A0 =C2=A0rust/qemu-api/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 26 +=
<br>
&gt;=C2=A0 =C2=A0rust/qemu-api/README.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 17 +=
<br>
&gt;=C2=A0 =C2=A0rust/qemu-api/<a href=3D"http://build.rs" rel=3D"noreferre=
r noreferrer" target=3D"_blank">build.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 14 +<br>
&gt;=C2=A0 =C2=A0rust/qemu-api/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 24 +<br=
>
&gt;=C2=A0 =C2=A0rust/qemu-api/src/<a href=3D"http://definitions.rs" rel=3D=
"noreferrer noreferrer" target=3D"_blank">definitions.rs</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 97 ++++<br>
&gt;=C2=A0 =C2=A0rust/qemu-api/src/<a href=3D"http://device_class.rs" rel=
=3D"noreferrer noreferrer" target=3D"_blank">device_class.rs</a>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 128 +++++<br>
&gt;=C2=A0 =C2=A0rust/qemu-api/src/<a href=3D"http://lib.rs" rel=3D"norefer=
rer noreferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 166 +++=
+++<br>
&gt;=C2=A0 =C2=A0rust/qemu-api/src/<a href=3D"http://tests.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">tests.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 49 +=
+<br>
&gt;=C2=A0 =C2=A0rust/rustfmt.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0scripts/archive-source.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06=
 +-<br>
&gt;=C2=A0 =C2=A0scripts/make-release=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A05 +-<br>
&gt;=C2=A0 =C2=A0scripts/meson-buildoptions.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0scripts/rust/rust_root_crate.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 13 +<br>
&gt;=C2=A0 =C2=A0scripts/rust/rustc_args.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 84 +++<b=
r>
&gt;=C2=A0 =C2=A0subprojects/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 11 +<br>
&gt;=C2=A0 =C2=A0subprojects/arbitrary-int-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0subprojects/bilge-0.2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0subprojects/bilge-impl-0.2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0subprojects/either-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br=
>
&gt;=C2=A0 =C2=A0subprojects/itertools-0.11-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0.../packagefiles/arbitrary-int-1-rs/meson.build=C2=A0 =C2=
=A0 |=C2=A0 19 +<br>
&gt;=C2=A0 =C2=A0subprojects/packagefiles/bilge-0.2-rs/meson.build=C2=A0 |=
=C2=A0 29 +<br>
&gt;=C2=A0 =C2=A0.../packagefiles/bilge-impl-0.2-rs/meson.build=C2=A0 =C2=
=A0 =C2=A0|=C2=A0 45 ++<br>
&gt;=C2=A0 =C2=A0subprojects/packagefiles/either-1-rs/meson.build=C2=A0 =C2=
=A0|=C2=A0 24 +<br>
&gt;=C2=A0 =C2=A0.../packagefiles/itertools-0.11-rs/meson.build=C2=A0 =C2=
=A0 =C2=A0|=C2=A0 30 ++<br>
&gt;=C2=A0 =C2=A0.../packagefiles/proc-macro-error-1-rs/meson.build |=C2=A0=
 40 ++<br>
&gt;=C2=A0 =C2=A0.../proc-macro-error-attr-1-rs/meson.build=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 32 ++<br>
&gt;=C2=A0 =C2=A0.../packagefiles/proc-macro2-1-rs/meson.build=C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 31 ++<br>
&gt;=C2=A0 =C2=A0subprojects/packagefiles/quote-1-rs/meson.build=C2=A0 =C2=
=A0 |=C2=A0 29 +<br>
&gt;=C2=A0 =C2=A0subprojects/packagefiles/syn-2-rs/meson.build=C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 40 ++<br>
&gt;=C2=A0 =C2=A0.../packagefiles/unicode-ident-1-rs/meson.build=C2=A0 =C2=
=A0 |=C2=A0 20 +<br>
&gt;=C2=A0 =C2=A0subprojects/proc-macro-error-1-rs.wrap=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0subprojects/proc-macro-error-attr-1-rs.wrap=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0subprojects/proc-macro2-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0subprojects/quote-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0subprojects/syn-2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07=
 +<br>
&gt;=C2=A0 =C2=A0subprojects/unicode-ident-1-rs.wrap=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0subprojects/unicode-ident-1-rs/meson.build=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 20 +<br>
&gt;=C2=A0 =C2=A0tests/lcitool/mappings.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 =
+-<br>
&gt;=C2=A0 =C2=A075 files changed, 3194 insertions(+), 34 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/wrapper.h<br>
&gt;=C2=A0 =C2=A0delete mode 100644 python/wheels/meson-1.2.3-py3-none-any.=
whl<br>
&gt;=C2=A0 =C2=A0create mode 100644 python/wheels/meson-1.5.0-py3-none-any.=
whl<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/.gitignore<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/Kconfig<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/Kconfig<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/Kconfig<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/pl011/.gitignore<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/pl011/Cargo.lock<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/pl011/Cargo.toml<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/pl011/README.md<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/pl011/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/pl011/src/<a href=3D"http:=
//device.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">device.rs</a><=
br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/pl011/src/<a href=3D"http:=
//device_class.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">device_c=
lass.rs</a><br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/pl011/src/<a href=3D"http:=
//lib.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">lib.rs</a><br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/pl011/src/<a href=3D"http:=
//memory_ops.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">memory_ops=
.rs</a><br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/hw/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api-macros/Cargo.lock<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api-macros/Cargo.toml<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api-macros/README.md<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api-macros/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api-macros/src/<a href=3D"htt=
p://lib.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">lib.rs</a><br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api/.gitignore<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api/Cargo.lock<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api/Cargo.toml<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api/README.md<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api/<a href=3D"http://build.r=
s" rel=3D"noreferrer noreferrer" target=3D"_blank">build.rs</a><br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api/src/<a href=3D"http://def=
initions.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">definitions.rs=
</a><br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api/src/<a href=3D"http://dev=
ice_class.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">device_class.=
rs</a><br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api/src/<a href=3D"http://lib=
.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">lib.rs</a><br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/qemu-api/src/<a href=3D"http://tes=
ts.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">tests.rs</a><br>
&gt;=C2=A0 =C2=A0create mode 100644 rust/rustfmt.toml<br>
&gt;=C2=A0 =C2=A0create mode 100755 scripts/rust/rust_root_crate.sh<br>
&gt;=C2=A0 =C2=A0create mode 100644 scripts/rust/rustc_args.py<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/arbitrary-int-1-rs.wrap<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/bilge-0.2-rs.wrap<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/bilge-impl-0.2-rs.wrap<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/either-1-rs.wrap<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/itertools-0.11-rs.wrap<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/packagefiles/arbitrary-int-=
1-rs/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/packagefiles/bilge-0.2-rs/m=
eson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/packagefiles/bilge-impl-0.2=
-rs/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/packagefiles/either-1-rs/me=
son.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/packagefiles/itertools-0.11=
-rs/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/packagefiles/proc-macro-err=
or-1-rs/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/packagefiles/proc-macro-err=
or-attr-1-rs/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/packagefiles/proc-macro2-1-=
rs/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/packagefiles/quote-1-rs/mes=
on.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/packagefiles/syn-2-rs/meson=
.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/packagefiles/unicode-ident-=
1-rs/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/proc-macro-error-1-rs.wrap<=
br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/proc-macro-error-attr-1-rs.=
wrap<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/proc-macro2-1-rs.wrap<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/quote-1-rs.wrap<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/syn-2-rs.wrap<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/unicode-ident-1-rs.wrap<br>
&gt;=C2=A0 =C2=A0create mode 100644 subprojects/unicode-ident-1-rs/meson.bu=
ild<br>
<br>
</blockquote></div></div></div>

--000000000000d7bee70623e7d7f4--


