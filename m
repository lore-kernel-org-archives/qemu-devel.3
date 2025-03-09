Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B29C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 03:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr7aq-0000Jb-MF; Sat, 08 Mar 2025 22:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tr7ap-0000JO-1P
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 22:44:47 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tr7am-0003Y3-Oq
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 22:44:46 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e04064af07so5889724a12.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 19:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741491883; x=1742096683; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6u+ODuXiBWhCqyEQWnJTx9ApHDNdJ2/OJbpjYwdLYk=;
 b=QDd98mxE2XjzFw2YIb/70Nyk/lwOiYmuN9yoX5aYPI5AvMOfHJc9qLnqQEBkR1Ieq8
 xKam9Hvli4nBxTcJDKWPMLCy/QXX2gT+vAM4/jU+RL8SOg1mu/38pzPXLy4aVp9HXkKk
 kd1bgMFIc8szHyxktdybPAH+IwsujwNEFnF+yKbSb/3i9Ja6CB4Sic/pKLi/DAZ4leJR
 DCgayC5ZdjI9i3nEkX4lZuT1zgEMOy3oTJXcnDL71oTrHzvnkHDRBOjBiKXPiIwZcJ0S
 Lkh+icimHTfqIfID2glR93+EDOxowOQkWip1BPDHn+1GaEIYf/v21KZZ7A+J2M0eul2a
 n3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741491883; x=1742096683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L6u+ODuXiBWhCqyEQWnJTx9ApHDNdJ2/OJbpjYwdLYk=;
 b=FRi7Hd+GLuiKyu0h7p771ysUvPXqEUZQxJSD4JTyOyURzpD0W3EqhH/6WHq9o4HhGt
 ROXi/z5JUwcK2iRnpHTSd0AxOr3QBsGRnYFPlrEfAgzepF1GqHpIb3aj6yxyP2Az7OV6
 FrgcbDpqixT0MLix/UUCm4jW5c+v9CW6j1+xQqHGT5vTdVpfxHYwWCkhSlp6FyT/EOtQ
 JFAEKHBPW7smSxr12mVxYuA/ICk1QdFLND7JKHdyQaymIHH3kzbBYuRU+H+YQYy4o+QN
 tBiIPmQmi4ti+/UvlZSztyA+oQjRe/IPRmyTeghlNbDtkIxwRxEkEJBd2eVs6oxGZqVs
 7feA==
X-Gm-Message-State: AOJu0YxQGyOPIFIckwRszNTY99TEXVwg4yxiLdPPDLRX+lclZqRcrwA6
 wSQa09eqKPQR1BmtawUml9c/N9i9fdnYc0pTVw42+OdLSES03ueZySBpqBNUGr1/RVe9WIm6xGg
 cwjbdJhAunXut5UHLKSu8+DhAMaM=
X-Gm-Gg: ASbGnctIhxxSuHK7pW0DwZ7FnUBgoxi0P5lVZxntPR1TrVo+9AgB5sHHFiqvJn52+IT
 ThpDkQteH/jauaN31jm+hUS/mCwcJA/gzcWXmGz5qm+0pE4R+q5IYcx6C1xTgWLPF0LrjOFn15J
 wryGVMw8s8eg19vIjpdzw2qD1Y505Uhan3GicY
X-Google-Smtp-Source: AGHT+IGuifeRa1vJ+m/q4BMbFTJR5bI4s9Oo2QGaLTN3u8qCkRDwfZy/2VDVGecnoNShtdVyCUzEFj6KsOx5lNo//9M=
X-Received: by 2002:a05:6402:35c5:b0:5e5:e090:7b62 with SMTP id
 4fb4d7f45d1cf-5e5e248ff3dmr11679850a12.24.1741491882425; Sat, 08 Mar 2025
 19:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 9 Mar 2025 11:44:29 +0800
X-Gm-Features: AQ5f1Jpmkr0AwBOwpEbwwe8HxHAYf66fyUlsinw9R5x1HwpCQSz1VFkRuwbmv7U
Message-ID: <CAJSP0QXU-ja=_zrm5OZ2Ady0uSSRQxJL+P2R85xCrApEKEcuLg@mail.gmail.com>
Subject: Re: [PULL 00/31] testing, plugin and maintainer updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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

On Sun, Mar 9, 2025 at 5:54=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> The following changes since commit 98c7362b1efe651327385a25874a73e008c654=
9e:
>
>   Merge tag 'accel-cpus-20250306' of https://github.com/philmd/qemu into =
staging (2025-03-07 07:39:49 +0800)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-10.0-for-softfreeze-08032=
5-2

Please take a look at this Vulkan CI failure:
https://gitlab.com/qemu-project/qemu/-/jobs/9353073885#L682

Thanks,
Stefan

>
> for you to fetch changes up to 8db681c98ba043a8c7b5884b3837c8869a978991:
>
>   MAINTAINERS: remove widely sanctioned entities (2025-03-07 22:34:30 +00=
00)
>
> ----------------------------------------------------------------
> functional and tcg tests, plugins and MAINTAINERS
>
>   - update and expand aarch64 GPU tests
>   - fix build dependence for plugins
>   - update libvirt-ci to vulkan-tools
>   - allow plugin tests to run on non-POSIX systems
>   - tweak test/vm times
>   - mark test-vma as linux only
>   - various compiler fixes for tcg tests
>   - add gitlab build unit tracker
>   - error out early on stalled RME tests
>   - compile core plugin code once
>   - update MAINTAINERS
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (26):
>       tests/functional: move aarch64 GPU test into own file
>       tests/functional: factor out common code in gpu test
>       tests/functional: ensure we have a GPU device for tests
>       tests/functional: bail early if vkmark hangs
>       tests/functional: skip vulkan tests with nVidia
>       tests/functional: expand tests to cover virgl
>       tests/functional: update the aarch64_virg_gpu images
>       libvirt-ci: bump to latest for vulkan-tools
>       tests/vm: bump timeout for shutdown
>       tests/tcg: mark test-vma as a linux-only test
>       tests/tcg: add message to _Static_assert in test-avx
>       tests/tcg: fix constraints in test-i386-adcox
>       tests/tcg: enable -fwrapv for test-i386-bmi
>       gitlab: add a new build_unit job to track build size
>       plugins/api: use qemu_target_page_mask() to get value
>       plugins/loader: populate target_name with target_name()
>       include/qemu: plugin-memory.h doesn't need cpu-defs.h
>       plugins/api: clean-up the includes
>       plugins/plugin.h: include queue.h
>       plugins/loader: compile loader only once
>       plugins/api: split out binary path/start/end/entry code
>       plugins/api: split out the vaddr/hwaddr helpers
>       plugins/api: split out time control helpers
>       plugins/api: build only once
>       plugins/core: make a single build unit
>       MAINTAINERS: remove widely sanctioned entities
>
> Peter Maydell (1):
>       tests/tcg: Suppress compiler false-positive warning on sha1.c
>
> Philippe Mathieu-Daud=C3=A9 (2):
>       tests/functional: Introduce the dso_suffix() helper
>       tests/functional: Allow running TCG plugins tests on non-Linux/BSD =
hosts
>
> Pierrick Bouvier (2):
>       plugins: add explicit dependency in functional tests
>       tests/functional: add boot error detection for RME tests
>
>  MAINTAINERS                                        |   8 +-
>  meson.build                                        |   1 +
>  include/qemu/plugin-memory.h                       |   1 -
>  plugins/plugin.h                                   |   7 +
>  bsd-user/plugin-api.c                              |  15 ++
>  linux-user/plugin-api.c                            |  15 ++
>  plugins/api-system.c                               | 131 +++++++++++++++=
+
>  plugins/api-user.c                                 |  57 +++++++
>  plugins/api.c                                      | 171 +--------------=
------
>  plugins/core.c                                     |  10 +-
>  plugins/loader.c                                   |  15 +-
>  plugins/system.c                                   |  24 +++
>  plugins/user.c                                     |  19 +++
>  tests/tcg/i386/test-avx.c                          |   2 +-
>  tests/tcg/i386/test-i386-adcox.c                   |   6 +-
>  tests/tcg/multiarch/{ =3D> linux}/test-vma.c         |   0
>  common-user/plugin-api.c.inc                       |  43 ++++++
>  .gitlab-ci.d/check-units.py                        |  66 ++++++++
>  .gitlab-ci.d/cirrus/freebsd-14.vars                |   2 +-
>  .gitlab-ci.d/cirrus/macos-14.vars                  |   2 +-
>  .gitlab-ci.d/static_checks.yml                     |  22 +++
>  bsd-user/meson.build                               |   1 +
>  contrib/plugins/meson.build                        |   2 +
>  linux-user/meson.build                             |   1 +
>  plugins/meson.build                                |  11 +-
>  scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |   1 +
>  scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |   1 +
>  tests/docker/dockerfiles/alpine.docker             |   5 +-
>  tests/docker/dockerfiles/centos9.docker            |   1 +
>  tests/docker/dockerfiles/debian-amd64-cross.docker |   3 +-
>  tests/docker/dockerfiles/debian-arm64-cross.docker |   3 +-
>  tests/docker/dockerfiles/debian-armhf-cross.docker |   3 +-
>  tests/docker/dockerfiles/debian-i686-cross.docker  |   3 +-
>  .../dockerfiles/debian-mips64el-cross.docker       |   3 +-
>  .../docker/dockerfiles/debian-mipsel-cross.docker  |   3 +-
>  .../docker/dockerfiles/debian-ppc64el-cross.docker |   3 +-
>  tests/docker/dockerfiles/debian-s390x-cross.docker |   3 +-
>  tests/docker/dockerfiles/debian.docker             |   3 +-
>  .../docker/dockerfiles/fedora-rust-nightly.docker  |   1 +
>  tests/docker/dockerfiles/fedora-win64-cross.docker |   1 +
>  tests/docker/dockerfiles/fedora.docker             |   1 +
>  tests/docker/dockerfiles/opensuse-leap.docker      |   1 +
>  tests/docker/dockerfiles/ubuntu2204.docker         |   1 +
>  tests/functional/meson.build                       |   6 +-
>  tests/functional/qemu_test/__init__.py             |   2 +-
>  tests/functional/qemu_test/config.py               |  12 ++
>  tests/functional/qemu_test/testcase.py             |  12 +-
>  tests/functional/test_aarch64_rme_sbsaref.py       |   3 +-
>  tests/functional/test_aarch64_rme_virt.py          |   3 +-
>  tests/functional/test_aarch64_tcg_plugins.py       |   5 +-
>  tests/functional/test_aarch64_virt.py              |  71 ---------
>  tests/functional/test_aarch64_virt_gpu.py          | 133 +++++++++++++++=
+
>  tests/lcitool/libvirt-ci                           |   2 +-
>  tests/lcitool/projects/qemu.yml                    |   1 +
>  tests/lcitool/refresh                              |   2 +-
>  tests/tcg/aarch64/Makefile.target                  |   3 +-
>  tests/tcg/arm/Makefile.target                      |   3 +-
>  tests/tcg/i386/Makefile.target                     |   2 +-
>  tests/tcg/multiarch/Makefile.target                |   8 +
>  tests/tcg/plugins/meson.build                      |   2 +
>  tests/vm/basevm.py                                 |   2 +-
>  tests/vm/generated/freebsd.json                    |   1 +
>  62 files changed, 643 insertions(+), 302 deletions(-)
>  create mode 100644 bsd-user/plugin-api.c
>  create mode 100644 linux-user/plugin-api.c
>  create mode 100644 plugins/api-system.c
>  create mode 100644 plugins/api-user.c
>  create mode 100644 plugins/system.c
>  create mode 100644 plugins/user.c
>  rename tests/tcg/multiarch/{ =3D> linux}/test-vma.c (100%)
>  create mode 100644 common-user/plugin-api.c.inc
>  create mode 100755 .gitlab-ci.d/check-units.py
>  create mode 100755 tests/functional/test_aarch64_virt_gpu.py
>
> --
> 2.39.5
>
>

