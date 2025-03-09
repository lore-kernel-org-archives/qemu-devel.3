Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C32C28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 21:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trNng-0001iF-Ok; Sun, 09 Mar 2025 17:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trNnK-00018u-5k
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 17:02:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trNnH-0000gZ-LN
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 17:02:45 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso5920615e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 14:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741554160; x=1742158960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fzjw2CX/NzGFlfV3egMoJKJjTnqzvieK/ZU1EhCcMNE=;
 b=fsx7y6Jpn5N+XrWT48RxbYb5JRxQnT8W+YUnlkZZi/bDf6lVrG9v3efMKAyaDv4cvG
 bqDKpJcYRaMxzgKZ6RcKPNEnMe8SQ7KgPpX0QizmOPIBTNRVIo1ejYYxDfKOGOFqFe9Z
 +KyDLlCmSuqEsxOb4K3I/oDZuMIynXoxrr8eOz1fz1JqQqv+FJTXC/E6tvN0w++9auia
 V6odd1EpCMTH9d7RmCOfOTsnYy+K/24LCzuNguuEpF2Zhp6oWggcq+DMmy75D9qKnWbz
 OBmKlwo6I9bekxB5Acucv5mMmkQ8PenRtgnvPaVmBru8HZm4jwzhfKnmKnoaGMcfxi6s
 oprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741554160; x=1742158960;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fzjw2CX/NzGFlfV3egMoJKJjTnqzvieK/ZU1EhCcMNE=;
 b=MAxkbLFXM015a05OHAWSsDYrvdBCy8UytLFUC6Akf2MEH5N4JDyAHYZ2Vm0WhXZ1SB
 +0nRaayt+UWjJAwnHRT1N/PvY+o8IDCXJc/YoJ0cgjgChUWE+5xJFxTQoi48eycRpp4o
 NFjZArceolNVLSwObfNxL+yUNi+PZPo8r8Tu3dV59afkVuPHk3nrQA0tuZWamkx9H1GO
 vYQgJqw7eTFB8PdoXVURaGz4l8qAPVjKwHYCm/ocnFsLyNfuMBo1Qn23pyGbP/lcHXGg
 M+iepkMsuKg1Kl3FEguGrN8abhOiMc640866tEJgMtmgiySKe5Ib0H/2TQRY3kH8jH/z
 ZVow==
X-Gm-Message-State: AOJu0YwdJk1JA0jHA6YyXpTd3HD8X2ja26QfYRG7y63qY8eTN5zvmZkL
 SBSFUrJNoAbRbKdtqXQCiYfhfxcSGcgzAVO2+OPAMlKO/DBonY5f2rRdKXJEdVU=
X-Gm-Gg: ASbGncuatyo71ZAjilR/qhd/wARSU9FXwJmgQxBelDEkQsVUU6doWQcUtuF0usVwdIt
 ENruSAKWLcxsRhJuof1iumFzSJAwkwAhYxyVnusHt29m8TmzYKYI5WgA/5dMMFQtqgIMiv7Qtcw
 DkKbP/mQkxWQIneH1lUR2FkhWQEJ61iTtH/Z0gUv/bFrHeivcmsy3xas836PsVN/H5FoO79/TyX
 uGM9XOiNLJXhmswtTT8Zo3Scct9R3GgnXgKxgKJPx21BWTj8NlCw5I9IF3N4hrht1XgrDgBhO3r
 bMT7ijjyd4ElKR1Tl0SsnJAN+2Mtkm4zZMx5IK4MUUwG+c3R7KOmj6D5HQ==
X-Google-Smtp-Source: AGHT+IHKvVHnXblLlmq35e7Qa6nmHtUmGkKAACOzXlS8MXjIJtC2unTDRmOQICbARBSqgurwq7DI6Q==
X-Received: by 2002:a05:6000:402a:b0:391:888:f534 with SMTP id
 ffacd0b85a97d-39132d39209mr8907673f8f.20.1741554160404; 
 Sun, 09 Mar 2025 14:02:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c588dsm151270215e9.21.2025.03.09.14.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 14:02:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 013815F9DA;
 Sun,  9 Mar 2025 21:02:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/31] testing, plugin and maintainer updates
In-Reply-To: <CAJSP0QXU-ja=_zrm5OZ2Ady0uSSRQxJL+P2R85xCrApEKEcuLg@mail.gmail.com>
 (Stefan Hajnoczi's message of "Sun, 9 Mar 2025 11:44:29 +0800")
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
 <CAJSP0QXU-ja=_zrm5OZ2Ady0uSSRQxJL+P2R85xCrApEKEcuLg@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Sun, 09 Mar 2025 21:02:38 +0000
Message-ID: <87h641or2p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Sun, Mar 9, 2025 at 5:54=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>>
>> The following changes since commit 98c7362b1efe651327385a25874a73e008c65=
49e:
>>
>>   Merge tag 'accel-cpus-20250306' of https://github.com/philmd/qemu into=
 staging (2025-03-07 07:39:49 +0800)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/stsquad/qemu.git tags/pull-10.0-for-softfreeze-0803=
25-2
>
> Please take a look at this Vulkan CI failure:
> https://gitlab.com/qemu-project/qemu/-/jobs/9353073885#L682

I think 20250309171908.3087067-1-alex.bennee@linaro.org should fix it.

>
> Thanks,
> Stefan
>
>>
>> for you to fetch changes up to 8db681c98ba043a8c7b5884b3837c8869a978991:
>>
>>   MAINTAINERS: remove widely sanctioned entities (2025-03-07 22:34:30 +0=
000)
>>
>> ----------------------------------------------------------------
>> functional and tcg tests, plugins and MAINTAINERS
>>
>>   - update and expand aarch64 GPU tests
>>   - fix build dependence for plugins
>>   - update libvirt-ci to vulkan-tools
>>   - allow plugin tests to run on non-POSIX systems
>>   - tweak test/vm times
>>   - mark test-vma as linux only
>>   - various compiler fixes for tcg tests
>>   - add gitlab build unit tracker
>>   - error out early on stalled RME tests
>>   - compile core plugin code once
>>   - update MAINTAINERS
>>
>> ----------------------------------------------------------------
>> Alex Benn=C3=A9e (26):
>>       tests/functional: move aarch64 GPU test into own file
>>       tests/functional: factor out common code in gpu test
>>       tests/functional: ensure we have a GPU device for tests
>>       tests/functional: bail early if vkmark hangs
>>       tests/functional: skip vulkan tests with nVidia
>>       tests/functional: expand tests to cover virgl
>>       tests/functional: update the aarch64_virg_gpu images
>>       libvirt-ci: bump to latest for vulkan-tools
>>       tests/vm: bump timeout for shutdown
>>       tests/tcg: mark test-vma as a linux-only test
>>       tests/tcg: add message to _Static_assert in test-avx
>>       tests/tcg: fix constraints in test-i386-adcox
>>       tests/tcg: enable -fwrapv for test-i386-bmi
>>       gitlab: add a new build_unit job to track build size
>>       plugins/api: use qemu_target_page_mask() to get value
>>       plugins/loader: populate target_name with target_name()
>>       include/qemu: plugin-memory.h doesn't need cpu-defs.h
>>       plugins/api: clean-up the includes
>>       plugins/plugin.h: include queue.h
>>       plugins/loader: compile loader only once
>>       plugins/api: split out binary path/start/end/entry code
>>       plugins/api: split out the vaddr/hwaddr helpers
>>       plugins/api: split out time control helpers
>>       plugins/api: build only once
>>       plugins/core: make a single build unit
>>       MAINTAINERS: remove widely sanctioned entities
>>
>> Peter Maydell (1):
>>       tests/tcg: Suppress compiler false-positive warning on sha1.c
>>
>> Philippe Mathieu-Daud=C3=A9 (2):
>>       tests/functional: Introduce the dso_suffix() helper
>>       tests/functional: Allow running TCG plugins tests on non-Linux/BSD=
 hosts
>>
>> Pierrick Bouvier (2):
>>       plugins: add explicit dependency in functional tests
>>       tests/functional: add boot error detection for RME tests
>>
>>  MAINTAINERS                                        |   8 +-
>>  meson.build                                        |   1 +
>>  include/qemu/plugin-memory.h                       |   1 -
>>  plugins/plugin.h                                   |   7 +
>>  bsd-user/plugin-api.c                              |  15 ++
>>  linux-user/plugin-api.c                            |  15 ++
>>  plugins/api-system.c                               | 131 ++++++++++++++=
++
>>  plugins/api-user.c                                 |  57 +++++++
>>  plugins/api.c                                      | 171 +-------------=
-------
>>  plugins/core.c                                     |  10 +-
>>  plugins/loader.c                                   |  15 +-
>>  plugins/system.c                                   |  24 +++
>>  plugins/user.c                                     |  19 +++
>>  tests/tcg/i386/test-avx.c                          |   2 +-
>>  tests/tcg/i386/test-i386-adcox.c                   |   6 +-
>>  tests/tcg/multiarch/{ =3D> linux}/test-vma.c         |   0
>>  common-user/plugin-api.c.inc                       |  43 ++++++
>>  .gitlab-ci.d/check-units.py                        |  66 ++++++++
>>  .gitlab-ci.d/cirrus/freebsd-14.vars                |   2 +-
>>  .gitlab-ci.d/cirrus/macos-14.vars                  |   2 +-
>>  .gitlab-ci.d/static_checks.yml                     |  22 +++
>>  bsd-user/meson.build                               |   1 +
>>  contrib/plugins/meson.build                        |   2 +
>>  linux-user/meson.build                             |   1 +
>>  plugins/meson.build                                |  11 +-
>>  scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |   1 +
>>  scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |   1 +
>>  tests/docker/dockerfiles/alpine.docker             |   5 +-
>>  tests/docker/dockerfiles/centos9.docker            |   1 +
>>  tests/docker/dockerfiles/debian-amd64-cross.docker |   3 +-
>>  tests/docker/dockerfiles/debian-arm64-cross.docker |   3 +-
>>  tests/docker/dockerfiles/debian-armhf-cross.docker |   3 +-
>>  tests/docker/dockerfiles/debian-i686-cross.docker  |   3 +-
>>  .../dockerfiles/debian-mips64el-cross.docker       |   3 +-
>>  .../docker/dockerfiles/debian-mipsel-cross.docker  |   3 +-
>>  .../docker/dockerfiles/debian-ppc64el-cross.docker |   3 +-
>>  tests/docker/dockerfiles/debian-s390x-cross.docker |   3 +-
>>  tests/docker/dockerfiles/debian.docker             |   3 +-
>>  .../docker/dockerfiles/fedora-rust-nightly.docker  |   1 +
>>  tests/docker/dockerfiles/fedora-win64-cross.docker |   1 +
>>  tests/docker/dockerfiles/fedora.docker             |   1 +
>>  tests/docker/dockerfiles/opensuse-leap.docker      |   1 +
>>  tests/docker/dockerfiles/ubuntu2204.docker         |   1 +
>>  tests/functional/meson.build                       |   6 +-
>>  tests/functional/qemu_test/__init__.py             |   2 +-
>>  tests/functional/qemu_test/config.py               |  12 ++
>>  tests/functional/qemu_test/testcase.py             |  12 +-
>>  tests/functional/test_aarch64_rme_sbsaref.py       |   3 +-
>>  tests/functional/test_aarch64_rme_virt.py          |   3 +-
>>  tests/functional/test_aarch64_tcg_plugins.py       |   5 +-
>>  tests/functional/test_aarch64_virt.py              |  71 ---------
>>  tests/functional/test_aarch64_virt_gpu.py          | 133 ++++++++++++++=
++
>>  tests/lcitool/libvirt-ci                           |   2 +-
>>  tests/lcitool/projects/qemu.yml                    |   1 +
>>  tests/lcitool/refresh                              |   2 +-
>>  tests/tcg/aarch64/Makefile.target                  |   3 +-
>>  tests/tcg/arm/Makefile.target                      |   3 +-
>>  tests/tcg/i386/Makefile.target                     |   2 +-
>>  tests/tcg/multiarch/Makefile.target                |   8 +
>>  tests/tcg/plugins/meson.build                      |   2 +
>>  tests/vm/basevm.py                                 |   2 +-
>>  tests/vm/generated/freebsd.json                    |   1 +
>>  62 files changed, 643 insertions(+), 302 deletions(-)
>>  create mode 100644 bsd-user/plugin-api.c
>>  create mode 100644 linux-user/plugin-api.c
>>  create mode 100644 plugins/api-system.c
>>  create mode 100644 plugins/api-user.c
>>  create mode 100644 plugins/system.c
>>  create mode 100644 plugins/user.c
>>  rename tests/tcg/multiarch/{ =3D> linux}/test-vma.c (100%)
>>  create mode 100644 common-user/plugin-api.c.inc
>>  create mode 100755 .gitlab-ci.d/check-units.py
>>  create mode 100755 tests/functional/test_aarch64_virt_gpu.py
>>
>> --
>> 2.39.5
>>
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

