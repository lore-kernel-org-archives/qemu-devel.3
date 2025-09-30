Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E136CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Z6w-0004LO-Ve; Tue, 30 Sep 2025 08:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v3Z6v-0004LG-Np
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v3Z6i-0004hG-OB
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759233919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2RnlS1F1hf8oZsRwO8UPMO3s5iAqMbTMeTjy5QEN+U0=;
 b=TbGNWIfrS4jyPW0kUDZaDXJBUwgZ0epyxU8Af+Ezpoab2WJsOKKIRysiA/IK1v3h+6WtKt
 lFAjgDI/ia3EYoOooYNxj1+mqyw/dfn0+q2CCjBQVy2WUjHVdpR7nRayrgUIXEX9zkSk2q
 xqp52AMsre741ZvFdae+iGW3YHb1raM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-h1Szqs9UO6yvz_1_Q5rNkg-1; Tue, 30 Sep 2025 08:05:17 -0400
X-MC-Unique: h1Szqs9UO6yvz_1_Q5rNkg-1
X-Mimecast-MFC-AGG-ID: h1Szqs9UO6yvz_1_Q5rNkg_1759233917
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-33428befc5bso5647273a91.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 05:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759233915; x=1759838715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2RnlS1F1hf8oZsRwO8UPMO3s5iAqMbTMeTjy5QEN+U0=;
 b=R9CPVw+Ld7YTW3SmJPYvU21rMpGWVEPxqu4OaTDkzAm1zXZUDpYwKddd2y7zWNMIug
 3EveSSaRRKbBaee1AAlx9iVgxcwQT3KgwEDgkC3rNbZQgAzL/0BEzG6YI6idEU7USrIL
 TXNQljmMvrBUivPZQA7QrwtSGTbUHRYEGSi60y1p2xTVWkQj4qGIIcuuF/1k81QaXcTZ
 2IfQEXo5nZ01u2p7G+boD1Hu0ThbbZktCmvOLSz2+bY3cs6n3jDFw8efOuvfDUX3uK+q
 tygMgM9X1BhzbPAXQU/tgCDYUhMl8bqe7+CijS+KvxtYqBaQ+oCeigHYVmT3OY28dLRw
 l//w==
X-Gm-Message-State: AOJu0YyHje1n1CIxZOprL0OOySjXESUc/r19LUsheGNBrj0tZdISq3R6
 L5XgSvGvqWk8AiNTAEHXOtqM1EVZdhmUaT9qgfEcXLUoPa1+/W68AOJu79xsPkwZ34VtvUMNjq/
 1a2bDptzr9a02EYyKEKGp/RJ2ZiKbTE3/VV9qOn769fkLgutZaAkhXbyuQ2SoQ3ytqQ0x8dbuO4
 Fp7BQ1Pei6sjsA/x2QPF345Yw1xuhKNXY=
X-Gm-Gg: ASbGncthKQCSLwWeDPnrz6g/CX9OZw4eJ43ymLyWt42MvmgJUF70FeRDgvNjelFCOeT
 2soiZba3QXc+CQOO5Z8q49UD755Er2dosTX35T3OSjrK1yvqhjuIGCDjNh0Y3RJjOFojyiqmJHe
 eOvdYhPHfh4djro9cdhLamJMEx3KOswbbCKGKw1ocegXKMfOPSb7VvAkSihIs=
X-Received: by 2002:a17:90b:3d0d:b0:335:21bf:3b99 with SMTP id
 98e67ed59e1d1-33521bf3e0dmr17981472a91.32.1759233915023; 
 Tue, 30 Sep 2025 05:05:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhK4d7nIDNOsBs5dManoLUfQxpcrxwKjlfmw+93i0RTauUaI4mrNhrtu4ibigy4NxT4KAv0cYJD951J61/cek=
X-Received: by 2002:a17:90b:3d0d:b0:335:21bf:3b99 with SMTP id
 98e67ed59e1d1-33521bf3e0dmr17981435a91.32.1759233914473; Tue, 30 Sep 2025
 05:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <87y0pzg6gt.fsf@draig.linaro.org>
In-Reply-To: <87y0pzg6gt.fsf@draig.linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Sep 2025 16:05:02 +0400
X-Gm-Features: AS18NWDYLQ7X8ooMX2dZVLPTqF52QdjkxBnbPpRL_6ZY27IXUBMJ0qIgPxAlYUw
Message-ID: <CAMxuvawY5PSwM0VNmbCmP7Z2t68D=z77W94Ab0SJfrm5_bRwKg@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] CI/build-sys fixes to enable Rust more widely
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Henderson,
 Richard" <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Yonggang Luo <luoyonggang@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 devel@lists.libvirt.org, 
 qemu-rust@nongnu.org, Kohei Tokunaga <ktokunaga.mail@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000008ca63a06400390a4"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000008ca63a06400390a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 9:18=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> marcandre.lureau@redhat.com writes:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > This patch series fixes a number of issues with the build system and CI
> and
> > enable Rust for many of our jobs, getting us closer to enable Rust by
> default.
> >
> > emscripten is difficult to enable, help welcome.
>
> Also I think:
>
>   https://gitlab.com/stsquad/qemu/-/pipelines/2065603411


Current ack/r-b series pass:
https://gitlab.com/marcandre.lureau/qemu/-/pipelines/2071701923

I  guess I should end a PR.


>
> And the:
>   debian-armhf-cross

debian-mipsel-cross
>   debian-mips64el-cross
>
  debian-ppc64el-cross
>   debian-riscv64-cross
>
> cross builds fail.


Fixed with the --rust-target-triple patch sent earlier


>   debian-i686-cross
>

This one fails with:
 ../src/meson.build:3394:4: ERROR: Problem encountered: No accelerator
available for target x86_64-softmmu

Paolo, any idea?


> >
> > v2:
> > - add a rust-to-clang-target-test.sh configure script
> > - drop "RFC: configure: use the same machine as the host triple"
> > - replace "tests: move mips to debian-legacy-test-cross" with "RFC:
> build-sys: deprecate mips host"
> > - start tackling emscripten
> > - fix mis-placed submodule update
> > - other minor changes, commit message tweaks, bz links
> > - add r-b tags
> >
> > Marc-Andr=C3=A9 Lureau (27):
> >   build-sys: require -lrt when no shm_open() in std libs
> >   gitlab-ci: fix 'needs' property type must be array
> >   scripts/archive-source: speed up downloading subprojects
> >   scripts/archive-source: silence subprojects downloads
> >   scripts/archive-source: use a bash array
> >   configure: fix rust meson configuration
> >   configure: set the bindgen cross target
> >   tests/docker/common: print errors to stderr
> >   tests/docker: use fully qualified image name for emsdk
> >   tests/docker/common: print meson log on configure failure
> >   build-sys: cfi_debug and safe_stack are not compatible
> >   lcitool: update, switch to f41
> >   lcitool/qemu: include libclang-rt for TSAN
> >   lcitool/alpine: workaround bindgen issue
> >   tests/lcitool: add missing rust-std dep
> >   tests/lcitool: update to debian13
> >   tests/docker: add ENABLE_RUST environment
> >   tests/lcitool: enable rust & refresh
> >   configure: set the meson executable suffix/ext
> >   tests/freebsd: enable Rust
> >   meson: rust-bindgen limit allowlist-file to srcdir/include
> >   RFC: tests/docker: add rust to debian-legacy-test-cross
> >   WIP: gitlab-ci: enable rust for msys2-64bit
> >   WIP: cirrus/macos: enable Rust
> >   RFC: build-sys: deprecate mips host
> >   build-sys: pass -fvisibility=3Ddefault for wasm bindgen
> >   WIP: enable rust for wasm/emscripten
> >
> >  docs/about/build-platforms.rst                |  2 -
> >  docs/about/deprecated.rst                     |  9 +--
> >  configure                                     | 27 +++++++-
> >  meson.build                                   | 34 +++++++---
> >  .gitlab-ci.d/buildtest-template.yml           |  2 +-
> >  .gitlab-ci.d/buildtest.yml                    | 66 +++++++++----------
> >  .gitlab-ci.d/cirrus.yml                       |  4 +-
> >  .gitlab-ci.d/crossbuilds.yml                  | 46 ++++++-------
> >  .gitlab-ci.d/static_checks.yml                |  6 +-
> >  .gitlab-ci.d/windows.yml                      |  8 ++-
> >  rust/bql/meson.build                          |  1 +
> >  rust/chardev/meson.build                      |  1 +
> >  rust/hw/char/pl011/meson.build                |  1 +
> >  rust/hw/core/meson.build                      |  1 +
> >  rust/migration/meson.build                    |  3 +-
> >  rust/qom/meson.build                          |  1 +
> >  rust/system/meson.build                       |  1 +
> >  rust/util/meson.build                         |  1 +
> >  scripts/archive-source.sh                     | 33 +++++++---
> >  .../ci/setup/ubuntu/ubuntu-2204-aarch64.yaml  |  5 +-
> >  .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml    |  5 +-
> >  scripts/rust-to-clang-target-test.sh          | 43 ++++++++++++
> >  scripts/rust-to-clang-target.sh               | 62 +++++++++++++++++
> >  tests/docker/common.rc                        | 11 +++-
> >  tests/docker/dockerfiles/alpine.docker        |  6 +-
> >  tests/docker/dockerfiles/centos9.docker       |  4 ++
> >  .../dockerfiles/debian-amd64-cross.docker     | 18 +++--
> >  .../dockerfiles/debian-arm64-cross.docker     | 18 +++--
> >  .../dockerfiles/debian-armhf-cross.docker     | 21 +++---
> >  .../dockerfiles/debian-i686-cross.docker      | 20 ++++--
> >  .../debian-legacy-test-cross.docker           |  9 ++-
> >  .../dockerfiles/debian-mips64el-cross.docker  |  9 ++-
> >  .../dockerfiles/debian-mipsel-cross.docker    |  9 ++-
> >  .../dockerfiles/debian-ppc64el-cross.docker   | 18 +++--
> >  .../dockerfiles/debian-riscv64-cross.docker   | 10 ++-
> >  .../dockerfiles/debian-s390x-cross.docker     | 18 +++--
> >  tests/docker/dockerfiles/debian.docker        | 18 +++--
> >  .../dockerfiles/emsdk-wasm32-cross.docker     | 29 +++++++-
> >  .../dockerfiles/fedora-rust-nightly.docker    | 18 +++--
> >  .../dockerfiles/fedora-win64-cross.docker     | 15 +++--
> >  tests/docker/dockerfiles/fedora.docker        | 18 +++--
> >  tests/docker/dockerfiles/opensuse-leap.docker |  7 +-
> >  tests/docker/dockerfiles/ubuntu2204.docker    |  7 +-
> >  tests/docker/test-wasm                        | 12 ++++
> >  tests/lcitool/libvirt-ci                      |  2 +-
> >  tests/lcitool/projects/qemu.yml               |  3 +-
> >  tests/lcitool/refresh                         | 48 +++++++++-----
> >  tests/vm/freebsd                              |  4 +-
> >  48 files changed, 531 insertions(+), 183 deletions(-)
> >  create mode 100755 scripts/rust-to-clang-target-test.sh
> >  create mode 100644 scripts/rust-to-clang-target.sh
> >  create mode 100755 tests/docker/test-wasm
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--0000000000008ca63a06400390a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 27,=
 2025 at 9:18=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee=
@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><a href=3D"mailto:marcandre.lureau@redha=
t.com" target=3D"_blank">marcandre.lureau@redhat.com</a> writes:<br>
<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; This patch series fixes a number of issues with the build system and C=
I and<br>
&gt; enable Rust for many of our jobs, getting us closer to enable Rust by =
default.<br>
&gt;<br>
&gt; emscripten is difficult to enable, help welcome.<br>
<br>
Also I think:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/stsquad/qemu/-/pipelines/2065603411" r=
el=3D"noreferrer" target=3D"_blank">https://gitlab.com/stsquad/qemu/-/pipel=
ines/2065603411</a></blockquote><div><br></div><div>Current ack/r-b series =
pass:=C2=A0<a href=3D"https://gitlab.com/marcandre.lureau/qemu/-/pipelines/=
2071701923">https://gitlab.com/marcandre.lureau/qemu/-/pipelines/2071701923=
</a></div><div><br></div><div>I=C2=A0 guess I should end a PR.</div><div><b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
And the:<br>=C2=A0 debian-armhf-cross=C2=A0=C2=A0</blockquote><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">debian-mipsel-cross<br>
=C2=A0 debian-mips64el-cross<br></blockquote><div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">=C2=A0 debian-ppc64el-cross<br>
=C2=A0 debian-riscv64-cross<br>
<br>
cross builds fail.=C2=A0</blockquote><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
</blockquote><br></div><div>Fixed with the --rust-target-triple patch sent =
earlier</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
=C2=A0 debian-i686-cross<br></blockquote><div><br></div><div>This one fails=
 with:</div><div>=C2=A0../src/meson.build:3394:4: ERROR: Problem encountere=
d: No accelerator available for target x86_64-softmmu</div><div><br></div><=
div>Paolo, any idea?</div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
&gt;<br>
&gt; v2:<br>
&gt; - add a rust-to-clang-target-test.sh configure script<br>
&gt; - drop &quot;RFC: configure: use the same machine as the host triple&q=
uot;<br>
&gt; - replace &quot;tests: move mips to debian-legacy-test-cross&quot; wit=
h &quot;RFC: build-sys: deprecate mips host&quot;<br>
&gt; - start tackling emscripten<br>
&gt; - fix mis-placed submodule update<br>
&gt; - other minor changes, commit message tweaks, bz links<br>
&gt; - add r-b tags<br>
&gt;<br>
&gt; Marc-Andr=C3=A9 Lureau (27):<br>
&gt;=C2=A0 =C2=A0build-sys: require -lrt when no shm_open() in std libs<br>
&gt;=C2=A0 =C2=A0gitlab-ci: fix &#39;needs&#39; property type must be array=
<br>
&gt;=C2=A0 =C2=A0scripts/archive-source: speed up downloading subprojects<b=
r>
&gt;=C2=A0 =C2=A0scripts/archive-source: silence subprojects downloads<br>
&gt;=C2=A0 =C2=A0scripts/archive-source: use a bash array<br>
&gt;=C2=A0 =C2=A0configure: fix rust meson configuration<br>
&gt;=C2=A0 =C2=A0configure: set the bindgen cross target<br>
&gt;=C2=A0 =C2=A0tests/docker/common: print errors to stderr<br>
&gt;=C2=A0 =C2=A0tests/docker: use fully qualified image name for emsdk<br>
&gt;=C2=A0 =C2=A0tests/docker/common: print meson log on configure failure<=
br>
&gt;=C2=A0 =C2=A0build-sys: cfi_debug and safe_stack are not compatible<br>
&gt;=C2=A0 =C2=A0lcitool: update, switch to f41<br>
&gt;=C2=A0 =C2=A0lcitool/qemu: include libclang-rt for TSAN<br>
&gt;=C2=A0 =C2=A0lcitool/alpine: workaround bindgen issue<br>
&gt;=C2=A0 =C2=A0tests/lcitool: add missing rust-std dep<br>
&gt;=C2=A0 =C2=A0tests/lcitool: update to debian13<br>
&gt;=C2=A0 =C2=A0tests/docker: add ENABLE_RUST environment<br>
&gt;=C2=A0 =C2=A0tests/lcitool: enable rust &amp; refresh<br>
&gt;=C2=A0 =C2=A0configure: set the meson executable suffix/ext<br>
&gt;=C2=A0 =C2=A0tests/freebsd: enable Rust<br>
&gt;=C2=A0 =C2=A0meson: rust-bindgen limit allowlist-file to srcdir/include=
<br>
&gt;=C2=A0 =C2=A0RFC: tests/docker: add rust to debian-legacy-test-cross<br=
>
&gt;=C2=A0 =C2=A0WIP: gitlab-ci: enable rust for msys2-64bit<br>
&gt;=C2=A0 =C2=A0WIP: cirrus/macos: enable Rust<br>
&gt;=C2=A0 =C2=A0RFC: build-sys: deprecate mips host<br>
&gt;=C2=A0 =C2=A0build-sys: pass -fvisibility=3Ddefault for wasm bindgen<br=
>
&gt;=C2=A0 =C2=A0WIP: enable rust for wasm/emscripten<br>
&gt;<br>
&gt;=C2=A0 docs/about/build-platforms.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 -<br>
&gt;=C2=A0 docs/about/deprecated.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9 +--<br>
&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 27 +++++++-<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
34 +++++++---<br>
&gt;=C2=A0 .gitlab-ci.d/buildtest-template.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 .gitlab-ci.d/buildtest.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 66 +++++++++----------<br>
&gt;=C2=A0 .gitlab-ci.d/cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +-<br>
&gt;=C2=A0 .gitlab-ci.d/crossbuilds.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 46 ++++++-------<br>
&gt;=C2=A0 .gitlab-ci.d/static_checks.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +-<br>
&gt;=C2=A0 .gitlab-ci.d/windows.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++-<br>
&gt;=C2=A0 rust/bql/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 rust/chardev/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 rust/hw/char/pl011/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 rust/hw/core/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 rust/migration/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +-<br>
&gt;=C2=A0 rust/qom/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 rust/system/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 rust/util/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 scripts/archive-source.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 33 +++++++---<br>
&gt;=C2=A0 .../ci/setup/ubuntu/ubuntu-2204-aarch64.yaml=C2=A0 |=C2=A0 5 +-<=
br>
&gt;=C2=A0 .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml=C2=A0 =C2=A0 |=C2=A0 =
5 +-<br>
&gt;=C2=A0 scripts/rust-to-clang-target-test.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 43 ++++++++++++<br>
&gt;=C2=A0 scripts/rust-to-clang-target.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 62 +++++++++++++++++<br>
&gt;=C2=A0 tests/docker/common.rc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 +++-<br>
&gt;=C2=A0 tests/docker/dockerfiles/alpine.docker=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 6 +-<br>
&gt;=C2=A0 tests/docker/dockerfiles/centos9.docker=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 4 ++<br>
&gt;=C2=A0 .../dockerfiles/debian-amd64-cross.docker=C2=A0 =C2=A0 =C2=A0| 1=
8 +++--<br>
&gt;=C2=A0 .../dockerfiles/debian-arm64-cross.docker=C2=A0 =C2=A0 =C2=A0| 1=
8 +++--<br>
&gt;=C2=A0 .../dockerfiles/debian-armhf-cross.docker=C2=A0 =C2=A0 =C2=A0| 2=
1 +++---<br>
&gt;=C2=A0 .../dockerfiles/debian-i686-cross.docker=C2=A0 =C2=A0 =C2=A0 | 2=
0 ++++--<br>
&gt;=C2=A0 .../debian-legacy-test-cross.docker=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 9 ++-<br>
&gt;=C2=A0 .../dockerfiles/debian-mips64el-cross.docker=C2=A0 |=C2=A0 9 ++-=
<br>
&gt;=C2=A0 .../dockerfiles/debian-mipsel-cross.docker=C2=A0 =C2=A0 |=C2=A0 =
9 ++-<br>
&gt;=C2=A0 .../dockerfiles/debian-ppc64el-cross.docker=C2=A0 =C2=A0| 18 +++=
--<br>
&gt;=C2=A0 .../dockerfiles/debian-riscv64-cross.docker=C2=A0 =C2=A0| 10 ++-=
<br>
&gt;=C2=A0 .../dockerfiles/debian-s390x-cross.docker=C2=A0 =C2=A0 =C2=A0| 1=
8 +++--<br>
&gt;=C2=A0 tests/docker/dockerfiles/debian.docker=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 18 +++--<br>
&gt;=C2=A0 .../dockerfiles/emsdk-wasm32-cross.docker=C2=A0 =C2=A0 =C2=A0| 2=
9 +++++++-<br>
&gt;=C2=A0 .../dockerfiles/fedora-rust-nightly.docker=C2=A0 =C2=A0 | 18 +++=
--<br>
&gt;=C2=A0 .../dockerfiles/fedora-win64-cross.docker=C2=A0 =C2=A0 =C2=A0| 1=
5 +++--<br>
&gt;=C2=A0 tests/docker/dockerfiles/fedora.docker=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 18 +++--<br>
&gt;=C2=A0 tests/docker/dockerfiles/opensuse-leap.docker |=C2=A0 7 +-<br>
&gt;=C2=A0 tests/docker/dockerfiles/ubuntu2204.docker=C2=A0 =C2=A0 |=C2=A0 =
7 +-<br>
&gt;=C2=A0 tests/docker/test-wasm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 ++++<br>
&gt;=C2=A0 tests/lcitool/libvirt-ci=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 tests/lcitool/projects/qemu.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +-<br>
&gt;=C2=A0 tests/lcitool/refresh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 48 +++++++++-----<br>
&gt;=C2=A0 tests/vm/freebsd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +-<br>
&gt;=C2=A0 48 files changed, 531 insertions(+), 183 deletions(-)<br>
&gt;=C2=A0 create mode 100755 scripts/rust-to-clang-target-test.sh<br>
&gt;=C2=A0 create mode 100644 scripts/rust-to-clang-target.sh<br>
&gt;=C2=A0 create mode 100755 tests/docker/test-wasm<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div>

--0000000000008ca63a06400390a4--


