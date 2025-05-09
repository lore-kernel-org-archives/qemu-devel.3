Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82999C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 14:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDP8E-0007zg-8R; Fri, 09 May 2025 10:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uDP8C-0007we-Cj
 for qemu-devel@nongnu.org; Fri, 09 May 2025 10:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uDP88-00030g-5h
 for qemu-devel@nongnu.org; Fri, 09 May 2025 10:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746802512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJ0s/k9xN/m5sUJlIjj+BrRlPJOCCwfQ0vAIbN3tzoM=;
 b=jBIA1hlEeYfBNg6Y9fzqbpp627rwqQa+Nx84aEwTUg9AEV9EVja91pJju2+abB8OqB9Hgi
 00y3+HCRSBRKRAwAPxU1Js5Qcfl2a0IcJVtfJgBioUtlbAmd7QQcxr8uQaErVkP7FBHuLi
 LCZTyD9Kn8/5dL3uApWecs5yQHZx9mw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-akWGj-IxM6adlJZIUJm8xA-1; Fri, 09 May 2025 10:55:10 -0400
X-MC-Unique: akWGj-IxM6adlJZIUJm8xA-1
X-Mimecast-MFC-AGG-ID: akWGj-IxM6adlJZIUJm8xA_1746802510
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442d472cf84so8167835e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 07:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746802509; x=1747407309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iJ0s/k9xN/m5sUJlIjj+BrRlPJOCCwfQ0vAIbN3tzoM=;
 b=d75dST9kYZ/5cAZShriYr0l+ozFynru36GUvpTj8ZiW7hXNq2DAOcdaOK8g0uhGGhy
 V/lZwq7Ce07+hCJkcnFtyy70ztsWcIXGUYn+PRHlsVPwiyYfCJP9OHzBc3WqbyFzVW9b
 GG4LN+oATFJjnfxDgpI+5bM6R3j5SyapTPx9IQhGxnNHnXygHNTIaCbevgNu+A3kQYEp
 4HoAtsuxw8KaUcBq3MlBkmNoQktdm3iol2PXsWRpo9s4WEAgveLKDe/pvxHUC0AD8655
 EN2q6wFoR0htDYED/y7Onf5dv1u89okVEw3jSJut3HcivTV2qoOVSzw7UNV1eBQaPi8Y
 NTYA==
X-Gm-Message-State: AOJu0Ywxq8Jupv+1YGAtyAF6jLB1iuoF9rvDI8W4b1QkZYLR4Fiwb0rY
 7FfRkfSV++8MTBEkP9wIsHAT6SZUpaXTCweO8yF1JAgv3KonBEm6JYCZXRwsUhHudAgCtsl9kYz
 MbN5AprjfPOoZrGrNPYb4G6u2waGlK/HY0ZdGj9gtsWaYnl55hYeBN+mtAa88ZcnPIiLs5rv6vU
 5D9m3gxDqTcQwjWY45YF5y1amOM+vxGa7z4iY=
X-Gm-Gg: ASbGnctMhLTFiUPJJFrY77PybJZiiQFuI+FZPP45E+RDu1DHHj43dwBg3jE0wT0WgqD
 UNsAy1Rkxw5vwtDcFI9i/jQzxw1HsDd1j4c82ciVDrr/Gxhpi514IuZZi6X4LRskcK7n+
X-Received: by 2002:a05:600c:c07:b0:43d:300f:fa3d with SMTP id
 5b1f17b1804b1-442d6d18abfmr34119785e9.5.1746802508881; 
 Fri, 09 May 2025 07:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbJMkkeN38CTEEbFDGnFd+AvMu6+i7djnmbnDVdtEOudzw49gWrTd0SBvMVDWq+/a/vUQcOGsKTObQpC145f4=
X-Received: by 2002:a05:600c:c07:b0:43d:300f:fa3d with SMTP id
 5b1f17b1804b1-442d6d18abfmr34119435e9.5.1746802508279; Fri, 09 May 2025
 07:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250508155439.512349-1-pbonzini@redhat.com>
 <20250509141302.GA82958@fedora>
In-Reply-To: <20250509141302.GA82958@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 May 2025 16:54:54 +0200
X-Gm-Features: AX0GCFvKJVVLctWPEevhgLAPu_kuiMLr0IPJh-Eip7uva75o1OJS1pyiQAQqnuA
Message-ID: <CABgObfYUdYHg0ZJXCwjTvjxUK4gDXaE3-S0uvSMye4AcNn5GEA@mail.gmail.com>
Subject: Re: [PULL v2, part1 00/15] Rust changes for 2025-05-06
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ffc4cd0634b52612"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, HTML_OBFUSCATE_10_20=0.093, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--000000000000ffc4cd0634b52612
Content-Type: text/plain; charset="UTF-8"

Il ven 9 mag 2025, 16:13 Stefan Hajnoczi <stefanha@redhat.com> ha scritto:

> Hi Paolo,
> v1 is already merged. I'm not sure what the purpose of v2 is. It looks
> like you dropped the wasm patches but the reason is unclear to me?
>

Sorry about the confusion, I sent this before I found a reproducer for the
bug (as a kind of "bisection").

You can drop this.

Paolo


> Thanks,
> Stefan
>
> >
> > ----------------------------------------------------------------
> > Paolo Bonzini (15):
> >       lcitool: use newer Rust for Debian and Ubuntu
> >       meson, cargo: require Rust 1.77.0
> >       rust: use std::ffi instead of std::os::raw
> >       rust: let bilge use "let ... else"
> >       rust: qemu_api_macros: make pattern matching more readable and
> efficient
> >       rust: use MaybeUninit::zeroed() in const context
> >       rust: qom: fix TODO about zeroability of classes
> >       rust: enable clippy::ptr_cast_constness
> >       rust: remove offset_of replacement
> >       rust: replace c_str! with c"" literals
> >       docs: rust: update for newer minimum supported version
> >       target/i386/emulate: fix target_ulong format strings
> >       rust: clippy: enable uninlined_format_args lint
> >       ci: run RISC-V cross jobs by default
> >       docs: build-system: fix typo
> >
> >  docs/about/build-platforms.rst                     |  11 +-
> >  docs/devel/build-system.rst                        |   2 +-
> >  docs/devel/rust.rst                                |  38 +----
> >  meson.build                                        |   6 +-
> >  target/i386/emulate/x86_decode.c                   |   2 +-
> >  target/i386/emulate/x86_emu.c                      |   2 +-
> >  .gitlab-ci.d/container-cross.yml                   |   3 -
> >  .gitlab-ci.d/crossbuilds.yml                       |   5 -
> >  rust/Cargo.lock                                    |   1 -
> >  rust/Cargo.toml                                    |   7 +-
> >  rust/clippy.toml                                   |   3 +-
> >  rust/hw/char/pl011/src/device.rs                   |   4 +-
> >  rust/hw/char/pl011/src/device_class.rs             |  13 +-
> >  rust/hw/char/pl011/src/lib.rs                      |   6 +-
> >  rust/hw/timer/hpet/src/fw_cfg.rs                   |   6 +-
> >  rust/hw/timer/hpet/src/hpet.rs                     |  28 ++--
> >  rust/hw/timer/hpet/src/lib.rs                      |   4 +-
> >  rust/qemu-api-macros/src/lib.rs                    | 123
> ++++++---------
> >  rust/qemu-api/Cargo.toml                           |   3 -
> >  rust/qemu-api/build.rs                             |  11 +-
> >  rust/qemu-api/meson.build                          |   5 -
> >  rust/qemu-api/src/c_str.rs                         |  61 --------
> >  rust/qemu-api/src/cell.rs                          |   6 +-
> >  rust/qemu-api/src/chardev.rs                       |   5 +-
> >  rust/qemu-api/src/irq.rs                           |   6 +-
> >  rust/qemu-api/src/lib.rs                           |   7 +-
> >  rust/qemu-api/src/memory.rs                        |   3 +-
> >  rust/qemu-api/src/offset_of.rs                     | 168
> ---------------------
> >  rust/qemu-api/src/qdev.rs                          |   9 +-
> >  rust/qemu-api/src/qom.rs                           |  14 +-
> >  rust/qemu-api/src/timer.rs                         |   4 +-
> >  rust/qemu-api/src/vmstate.rs                       |  14 +-
> >  rust/qemu-api/src/zeroable.rs                      | 106 +++----------
> >  rust/qemu-api/tests/tests.rs                       |  11 +-
> >  rust/qemu-api/tests/vmstate_tests.rs               |  27 ++--
> >  scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |   2 +-
> >  scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |   2 +-
> >  subprojects/bilge-impl-0.2-rs.wrap                 |   1 -
> >  subprojects/packagefiles/bilge-impl-1.63.0.patch   |  45 ------
> >  tests/docker/dockerfiles/debian-amd64-cross.docker |   2 +-
> >  tests/docker/dockerfiles/debian-arm64-cross.docker |   2 +-
> >  tests/docker/dockerfiles/debian-armhf-cross.docker |   2 +-
> >  tests/docker/dockerfiles/debian-i686-cross.docker  |   2 +-
> >  .../dockerfiles/debian-mips64el-cross.docker       |   2 +-
> >  .../docker/dockerfiles/debian-mipsel-cross.docker  |   2 +-
> >  .../docker/dockerfiles/debian-ppc64el-cross.docker |   2 +-
> >  tests/docker/dockerfiles/debian-s390x-cross.docker |   2 +-
> >  tests/docker/dockerfiles/debian.docker             |   2 +-
> >  tests/docker/dockerfiles/ubuntu2204.docker         |   3 +-
> >  tests/lcitool/mappings.yml                         |   5 +
> >  tests/lcitool/refresh                              |   5 +-
> >  51 files changed, 183 insertions(+), 622 deletions(-)
> >  delete mode 100644 rust/qemu-api/src/c_str.rs
> >  delete mode 100644 rust/qemu-api/src/offset_of.rs
> >  delete mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch
> > --
> > 2.49.0
> >
> >
>

--000000000000ffc4cd0634b52612
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 9 mag 2025, 16:13 Stefan =
Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>=
&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi Paolo,<br>
v1 is already merged. I&#39;m not sure what the purpose of v2 is. It looks<=
br>
like you dropped the wasm patches but the reason is unclear to me?<br></blo=
ckquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Sorry abo=
ut the confusion, I sent this before I found a reproducer for the bug (as a=
 kind of &quot;bisection&quot;).</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">You can drop this.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Thanks,<br>
Stefan<br>
<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; Paolo Bonzini (15):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0lcitool: use newer Rust for Debian and Ubunt=
u<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0meson, cargo: require Rust 1.77.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: use std::ffi instead of std::os::raw<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: let bilge use &quot;let ... else&quot;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: qemu_api_macros: make pattern matching=
 more readable and efficient<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: use MaybeUninit::zeroed() in const con=
text<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: qom: fix TODO about zeroability of cla=
sses<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: enable clippy::ptr_cast_constness<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: remove offset_of replacement<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: replace c_str! with c&quot;&quot; lite=
rals<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0docs: rust: update for newer minimum support=
ed version<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386/emulate: fix target_ulong format=
 strings<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: clippy: enable uninlined_format_args l=
int<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ci: run RISC-V cross jobs by default<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0docs: build-system: fix typo<br>
&gt; <br>
&gt;=C2=A0 docs/about/build-platforms.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 +-<br>
&gt;=C2=A0 docs/devel/build-system.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 docs/devel/rust.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
38 +----<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 target/i386/emulate/x86_decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 target/i386/emulate/x86_emu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 .gitlab-ci.d/container-cross.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 -<br>
&gt;=C2=A0 .gitlab-ci.d/crossbuilds.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 -<br>
&gt;=C2=A0 rust/Cargo.lock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 -<br>
&gt;=C2=A0 rust/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A07 +-<br>
&gt;=C2=A0 rust/clippy.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A03 +-<br>
&gt;=C2=A0 rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">device.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=3D=
"noreferrer noreferrer" target=3D"_blank">device_class.rs</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 13 +-<br>
&gt;=C2=A0 rust/hw/char/pl011/src/<a href=3D"http://lib.rs" rel=3D"noreferr=
er noreferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 rust/hw/timer/hpet/src/<a href=3D"http://fw_cfg.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">fw_cfg.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 rust/hw/timer/hpet/src/<a href=3D"http://hpet.rs" rel=3D"norefer=
rer noreferrer" target=3D"_blank">hpet.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 28 ++--<br>
&gt;=C2=A0 rust/hw/timer/hpet/src/<a href=3D"http://lib.rs" rel=3D"noreferr=
er noreferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 rust/qemu-api-macros/src/<a href=3D"http://lib.rs" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 123 ++++++---------<br>
&gt;=C2=A0 rust/qemu-api/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 =
-<br>
&gt;=C2=A0 rust/qemu-api/<a href=3D"http://build.rs" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">build.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 11 +-<br>
&gt;=C2=A0 rust/qemu-api/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 -<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://c_str.rs" rel=3D"noreferrer =
noreferrer" target=3D"_blank">c_str.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 61 -----=
---<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://cell.rs" rel=3D"noreferrer n=
oreferrer" target=3D"_blank">cell.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<=
br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://chardev.rs" rel=3D"noreferre=
r noreferrer" target=3D"_blank">chardev.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<b=
r>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://irq.rs" rel=3D"noreferrer no=
referrer" target=3D"_blank">irq.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A06 +-<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://lib.rs" rel=3D"noreferrer no=
referrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A07 +-<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://memory.rs" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">memory.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://offset_of.rs" rel=3D"norefer=
rer noreferrer" target=3D"_blank">offset_of.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 168 -----------------=
----<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://qdev.rs" rel=3D"noreferrer n=
oreferrer" target=3D"_blank">qdev.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +-<=
br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://qom.rs" rel=3D"noreferrer no=
referrer" target=3D"_blank">qom.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +-=
<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://timer.rs" rel=3D"noreferrer =
noreferrer" target=3D"_blank">timer.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 =
+-<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://vmstate.rs" rel=3D"noreferre=
r noreferrer" target=3D"_blank">vmstate.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +-<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://zeroable.rs" rel=3D"noreferr=
er noreferrer" target=3D"_blank">zeroable.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 106 +++----------<br>
&gt;=C2=A0 rust/qemu-api/tests/<a href=3D"http://tests.rs" rel=3D"noreferre=
r noreferrer" target=3D"_blank">tests.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 +-<br>
&gt;=C2=A0 rust/qemu-api/tests/<a href=3D"http://vmstate_tests.rs" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">vmstate_tests.rs</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 27 ++--<br>
&gt;=C2=A0 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml=C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 subprojects/bilge-impl-0.2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 -<br>
&gt;=C2=A0 subprojects/packagefiles/bilge-impl-1.63.0.patch=C2=A0 =C2=A0|=
=C2=A0 45 ------<br>
&gt;=C2=A0 tests/docker/dockerfiles/debian-amd64-cross.docker |=C2=A0 =C2=
=A02 +-<br>
&gt;=C2=A0 tests/docker/dockerfiles/debian-arm64-cross.docker |=C2=A0 =C2=
=A02 +-<br>
&gt;=C2=A0 tests/docker/dockerfiles/debian-armhf-cross.docker |=C2=A0 =C2=
=A02 +-<br>
&gt;=C2=A0 tests/docker/dockerfiles/debian-i686-cross.docker=C2=A0 |=C2=A0 =
=C2=A02 +-<br>
&gt;=C2=A0 .../dockerfiles/debian-mips64el-cross.docker=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 .../docker/dockerfiles/debian-mipsel-cross.docker=C2=A0 |=C2=A0 =
=C2=A02 +-<br>
&gt;=C2=A0 .../docker/dockerfiles/debian-ppc64el-cross.docker |=C2=A0 =C2=
=A02 +-<br>
&gt;=C2=A0 tests/docker/dockerfiles/debian-s390x-cross.docker |=C2=A0 =C2=
=A02 +-<br>
&gt;=C2=A0 tests/docker/dockerfiles/debian.docker=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/docker/dockerfiles/ubuntu2204.docker=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
&gt;=C2=A0 tests/lcitool/mappings.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 tests/lcitool/refresh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A05 +-<br>
&gt;=C2=A0 51 files changed, 183 insertions(+), 622 deletions(-)<br>
&gt;=C2=A0 delete mode 100644 rust/qemu-api/src/<a href=3D"http://c_str.rs"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">c_str.rs</a><br>
&gt;=C2=A0 delete mode 100644 rust/qemu-api/src/<a href=3D"http://offset_of=
.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">offset_of.rs</a><br>
&gt;=C2=A0 delete mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.pa=
tch<br>
&gt; -- <br>
&gt; 2.49.0<br>
&gt; <br>
&gt; <br>
</blockquote></div></div></div>

--000000000000ffc4cd0634b52612--


