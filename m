Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F29C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVwK-00060i-Jt; Mon, 10 Mar 2025 01:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1trVwA-0005sW-7V
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 01:44:30 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1trVw5-0000jr-Ii
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 01:44:25 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e64700a38cso1942057a12.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 22:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741585458; x=1742190258; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Msi6DBHdCaUh67fBOHMKFe1T+RKmZR/FfKH+1gNI03Q=;
 b=jQRRY+Bjo5fpwC+znWK6JQrSm10YzuvzugOhNcamXn5nmGlOuApKRFNdVUbUu/F9JH
 YvO3rekeicSI3FjOKj57bMZtww93Xt7npJ1xfQJ+6eJ0kChs5J0GKI83m/lCm5RynWii
 MCOLeE5J1CyxN5hMiol98Kwi5pVdym3Mq11FdvfGm1qwHcOomx5KoOZZLiSh42jh3bDi
 37Kpy6qoPtHEEAg+ExNNfeYRnddRyrbm8i+DHCe0zNNzx8SbDFXnn86A5VG1IdWMBGq4
 oyyayHBp5fnblRDSH/X7txpHovXUjasBmwRuhdAccAEr0rGoJrB2e9Tn++rgl+DwP1v8
 62YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741585458; x=1742190258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Msi6DBHdCaUh67fBOHMKFe1T+RKmZR/FfKH+1gNI03Q=;
 b=tNI3Qe/pMw3p6ibbfff53QTsF5Wg6t8wXr/cnzOQHI+i78mvGD8TNc3ItYorJA6sio
 ikZuqxxDIqwYKH+yvZK+oqJqg15ZwnFURVNpP7J1hL2EtPJMEqoaFB0YbC1KdLspI1/4
 qwv/MYqcL+lm1MC5ekcnNfKw3Q88LsGvgkW59nTh9EQdFBqx2/ub4FZQCxSSeoeUtXfQ
 x06uxzogHvbt4uzjaSb3UV8WgZ16bJ8ElWaPfMesNZMdsoR6jLLCIGLXXsg43Dd31gBm
 440Zad2o/Z3bxOOvPo9bRu//iIiHIrbyfpC7qLdFn4MXwA6IyQYbEQY7jrLK4Et76Ur5
 kRsQ==
X-Gm-Message-State: AOJu0YzYN9FzkxrdxTUbSaM0QfmQruNILjSSgGgrjHXwDN+xfAXBAQK2
 I8+7bflA33slOxTJAFWtEaZHzX0E/6QYv3wuuLrxTLuSkKiqLEG95OreWNewNZI3asfRQX4bwFU
 GEX37PoTbGiT0O7XYLyPoLR+nEVw=
X-Gm-Gg: ASbGnctridCf9dkhCw/UNF8SIRABBEQUtDCWDupbsHoigTSQlRhiJI7iPj16Up8I+TA
 o6O57YkPES7/bPCIvuOv0YyXsJndN4LL79FuqwgHlWR6y2qRCbfxzOEeHlTiae09QRG6gzWV/DP
 RzG/vojdmGQ8b/JIa4l/Pe4piyYw==
X-Google-Smtp-Source: AGHT+IEz10YcTXqYZUmxPCkVQt+Tp00k9da9VdJrYxs4MsRf2XiEgaPDHUYHaCIXnOuanI8nmZkMB9wkR2fRhkt+K1o=
X-Received: by 2002:a50:8dca:0:b0:5e5:bd8d:edb9 with SMTP id
 4fb4d7f45d1cf-5e5e22db548mr10491149a12.10.1741585457287; Sun, 09 Mar 2025
 22:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
 <CAJSP0QXU-ja=_zrm5OZ2Ady0uSSRQxJL+P2R85xCrApEKEcuLg@mail.gmail.com>
 <87h641or2p.fsf@draig.linaro.org>
In-Reply-To: <87h641or2p.fsf@draig.linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 10 Mar 2025 13:44:04 +0800
X-Gm-Features: AQ5f1JpylV4dC8G_AfSiNKg2VNG4puvLdv3KMlD4WwYgyvxKE7H3V9CnYpAQ7JI
Message-ID: <CAJSP0QUptzOEC2k6WLkS4mukCLz6kDHWyTuYKQ2KY6roEarFbg@mail.gmail.com>
Subject: Re: [PULL 00/31] testing, plugin and maintainer updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 10, 2025 at 5:02=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
> > On Sun, Mar 9, 2025 at 5:54=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@li=
naro.org> wrote:
> >>
> >> The following changes since commit 98c7362b1efe651327385a25874a73e008c=
6549e:
> >>
> >>   Merge tag 'accel-cpus-20250306' of https://github.com/philmd/qemu in=
to staging (2025-03-07 07:39:49 +0800)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://gitlab.com/stsquad/qemu.git tags/pull-10.0-for-softfreeze-08=
0325-2
> >
> > Please take a look at this Vulkan CI failure:
> > https://gitlab.com/qemu-project/qemu/-/jobs/9353073885#L682
>
> I think 20250309171908.3087067-1-alex.bennee@linaro.org should fix it.

I tried applying it before applying your pull request but
tests/functional/test_aarch64_virt_gpu.py is introduced in the pull
request. If I apply it afterwards then bisectability is broken.

Please respin the patch series with the fix included/squashed at the
right point so that bisectability is maintained.

Thanks,
Stefan

>
> >
> > Thanks,
> > Stefan
> >
> >>
> >> for you to fetch changes up to 8db681c98ba043a8c7b5884b3837c8869a97899=
1:
> >>
> >>   MAINTAINERS: remove widely sanctioned entities (2025-03-07 22:34:30 =
+0000)
> >>
> >> ----------------------------------------------------------------
> >> functional and tcg tests, plugins and MAINTAINERS
> >>
> >>   - update and expand aarch64 GPU tests
> >>   - fix build dependence for plugins
> >>   - update libvirt-ci to vulkan-tools
> >>   - allow plugin tests to run on non-POSIX systems
> >>   - tweak test/vm times
> >>   - mark test-vma as linux only
> >>   - various compiler fixes for tcg tests
> >>   - add gitlab build unit tracker
> >>   - error out early on stalled RME tests
> >>   - compile core plugin code once
> >>   - update MAINTAINERS
> >>
> >> ----------------------------------------------------------------
> >> Alex Benn=C3=A9e (26):
> >>       tests/functional: move aarch64 GPU test into own file
> >>       tests/functional: factor out common code in gpu test
> >>       tests/functional: ensure we have a GPU device for tests
> >>       tests/functional: bail early if vkmark hangs
> >>       tests/functional: skip vulkan tests with nVidia
> >>       tests/functional: expand tests to cover virgl
> >>       tests/functional: update the aarch64_virg_gpu images
> >>       libvirt-ci: bump to latest for vulkan-tools
> >>       tests/vm: bump timeout for shutdown
> >>       tests/tcg: mark test-vma as a linux-only test
> >>       tests/tcg: add message to _Static_assert in test-avx
> >>       tests/tcg: fix constraints in test-i386-adcox
> >>       tests/tcg: enable -fwrapv for test-i386-bmi
> >>       gitlab: add a new build_unit job to track build size
> >>       plugins/api: use qemu_target_page_mask() to get value
> >>       plugins/loader: populate target_name with target_name()
> >>       include/qemu: plugin-memory.h doesn't need cpu-defs.h
> >>       plugins/api: clean-up the includes
> >>       plugins/plugin.h: include queue.h
> >>       plugins/loader: compile loader only once
> >>       plugins/api: split out binary path/start/end/entry code
> >>       plugins/api: split out the vaddr/hwaddr helpers
> >>       plugins/api: split out time control helpers
> >>       plugins/api: build only once
> >>       plugins/core: make a single build unit
> >>       MAINTAINERS: remove widely sanctioned entities
> >>
> >> Peter Maydell (1):
> >>       tests/tcg: Suppress compiler false-positive warning on sha1.c
> >>
> >> Philippe Mathieu-Daud=C3=A9 (2):
> >>       tests/functional: Introduce the dso_suffix() helper
> >>       tests/functional: Allow running TCG plugins tests on non-Linux/B=
SD hosts
> >>
> >> Pierrick Bouvier (2):
> >>       plugins: add explicit dependency in functional tests
> >>       tests/functional: add boot error detection for RME tests
> >>
> >>  MAINTAINERS                                        |   8 +-
> >>  meson.build                                        |   1 +
> >>  include/qemu/plugin-memory.h                       |   1 -
> >>  plugins/plugin.h                                   |   7 +
> >>  bsd-user/plugin-api.c                              |  15 ++
> >>  linux-user/plugin-api.c                            |  15 ++
> >>  plugins/api-system.c                               | 131 ++++++++++++=
++++
> >>  plugins/api-user.c                                 |  57 +++++++
> >>  plugins/api.c                                      | 171 +-----------=
---------
> >>  plugins/core.c                                     |  10 +-
> >>  plugins/loader.c                                   |  15 +-
> >>  plugins/system.c                                   |  24 +++
> >>  plugins/user.c                                     |  19 +++
> >>  tests/tcg/i386/test-avx.c                          |   2 +-
> >>  tests/tcg/i386/test-i386-adcox.c                   |   6 +-
> >>  tests/tcg/multiarch/{ =3D> linux}/test-vma.c         |   0
> >>  common-user/plugin-api.c.inc                       |  43 ++++++
> >>  .gitlab-ci.d/check-units.py                        |  66 ++++++++
> >>  .gitlab-ci.d/cirrus/freebsd-14.vars                |   2 +-
> >>  .gitlab-ci.d/cirrus/macos-14.vars                  |   2 +-
> >>  .gitlab-ci.d/static_checks.yml                     |  22 +++
> >>  bsd-user/meson.build                               |   1 +
> >>  contrib/plugins/meson.build                        |   2 +
> >>  linux-user/meson.build                             |   1 +
> >>  plugins/meson.build                                |  11 +-
> >>  scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |   1 +
> >>  scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |   1 +
> >>  tests/docker/dockerfiles/alpine.docker             |   5 +-
> >>  tests/docker/dockerfiles/centos9.docker            |   1 +
> >>  tests/docker/dockerfiles/debian-amd64-cross.docker |   3 +-
> >>  tests/docker/dockerfiles/debian-arm64-cross.docker |   3 +-
> >>  tests/docker/dockerfiles/debian-armhf-cross.docker |   3 +-
> >>  tests/docker/dockerfiles/debian-i686-cross.docker  |   3 +-
> >>  .../dockerfiles/debian-mips64el-cross.docker       |   3 +-
> >>  .../docker/dockerfiles/debian-mipsel-cross.docker  |   3 +-
> >>  .../docker/dockerfiles/debian-ppc64el-cross.docker |   3 +-
> >>  tests/docker/dockerfiles/debian-s390x-cross.docker |   3 +-
> >>  tests/docker/dockerfiles/debian.docker             |   3 +-
> >>  .../docker/dockerfiles/fedora-rust-nightly.docker  |   1 +
> >>  tests/docker/dockerfiles/fedora-win64-cross.docker |   1 +
> >>  tests/docker/dockerfiles/fedora.docker             |   1 +
> >>  tests/docker/dockerfiles/opensuse-leap.docker      |   1 +
> >>  tests/docker/dockerfiles/ubuntu2204.docker         |   1 +
> >>  tests/functional/meson.build                       |   6 +-
> >>  tests/functional/qemu_test/__init__.py             |   2 +-
> >>  tests/functional/qemu_test/config.py               |  12 ++
> >>  tests/functional/qemu_test/testcase.py             |  12 +-
> >>  tests/functional/test_aarch64_rme_sbsaref.py       |   3 +-
> >>  tests/functional/test_aarch64_rme_virt.py          |   3 +-
> >>  tests/functional/test_aarch64_tcg_plugins.py       |   5 +-
> >>  tests/functional/test_aarch64_virt.py              |  71 ---------
> >>  tests/functional/test_aarch64_virt_gpu.py          | 133 ++++++++++++=
++++
> >>  tests/lcitool/libvirt-ci                           |   2 +-
> >>  tests/lcitool/projects/qemu.yml                    |   1 +
> >>  tests/lcitool/refresh                              |   2 +-
> >>  tests/tcg/aarch64/Makefile.target                  |   3 +-
> >>  tests/tcg/arm/Makefile.target                      |   3 +-
> >>  tests/tcg/i386/Makefile.target                     |   2 +-
> >>  tests/tcg/multiarch/Makefile.target                |   8 +
> >>  tests/tcg/plugins/meson.build                      |   2 +
> >>  tests/vm/basevm.py                                 |   2 +-
> >>  tests/vm/generated/freebsd.json                    |   1 +
> >>  62 files changed, 643 insertions(+), 302 deletions(-)
> >>  create mode 100644 bsd-user/plugin-api.c
> >>  create mode 100644 linux-user/plugin-api.c
> >>  create mode 100644 plugins/api-system.c
> >>  create mode 100644 plugins/api-user.c
> >>  create mode 100644 plugins/system.c
> >>  create mode 100644 plugins/user.c
> >>  rename tests/tcg/multiarch/{ =3D> linux}/test-vma.c (100%)
> >>  create mode 100644 common-user/plugin-api.c.inc
> >>  create mode 100755 .gitlab-ci.d/check-units.py
> >>  create mode 100755 tests/functional/test_aarch64_virt_gpu.py
> >>
> >> --
> >> 2.39.5
> >>
> >>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

