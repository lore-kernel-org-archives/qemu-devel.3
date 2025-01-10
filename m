Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5511E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWJuO-0006iK-2K; Fri, 10 Jan 2025 13:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tWJu2-0006hZ-6o
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:38:40 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tWJtx-00008z-Ge
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:38:36 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d982bce8f9so4358197a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736534310; x=1737139110; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLeGbu+mBbz43ojcHulKk8qk8c0/BJozHyW/7M5x/Ds=;
 b=Jd9SCFaOqt8S8+eQUU27R/XopMLVmmr1HdqvUOVcYxyBBCWI/r4BLvLcBOaLD0bJxJ
 PSqUIUm+IUI9KzBP6B6lr6NYKxmu28h7DiwL018FaHqfswdSazlQtwZr0cP3U4spdEy5
 nC2WHDzrqiFZ1xkZVDBpIlCxIjwJ3XW9CpeJNvy8GXzPDx/PBPLAPuTCqtYyTg9Yi67h
 x3DSQIQIetQ75PFnNhuPJ+XtGWZJa1c6EhvV7ziZramws0pxp9X0FKx0aAkvP+WFMFFH
 In6xP4vFsR9dj2BL5pW4VnbusJ1sg5vnfm+olQM2cp1MLxiofQkSQgo+2kMgQdIdflDe
 FZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534310; x=1737139110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LLeGbu+mBbz43ojcHulKk8qk8c0/BJozHyW/7M5x/Ds=;
 b=k4J84ngZ31rpxLOKa5ihINAp5NWlbuf/EK2FQXex8rH2whuAl1lFs9dmgn4oq47HyZ
 NuQWlTUgaTzpO4Yg7oicsi6lGmHxmG6TEyiyfWRz0nl69RCBM5qpiJb5x0ai6ELbSbq2
 uQMigN9GV5LMwCDXJdkQjJVjYrYuC/woc+xTu2gLz6jE6jbB7YtAVYkNZQDEW413vduj
 IvfofPnoYQ+jFHcJfvOtcFquu+sN5Sxsin6jRjMq+9SOiMnH2wYJms2ZDde8OgjE9YqF
 ihcB6BG6z9DcyBlC1FVPc6YbUKhU+5fYyMq9C9N88TL1gvZNRbtirVjZnAVZUfjIOr0X
 6P2A==
X-Gm-Message-State: AOJu0Yw/2nhG718HVF2hl3LMHk/auwlnappsmpge9ngroFLfyB7+k/GW
 eSnqZy6xTvRSXUd9+6UOEqqyUDHLhu0Ap/gx19C81nGGg7NSvClgGQfec/fFjA8a27J54y2T/Mx
 SYUVr6reVT3ia8manl6MOxbClMlQ=
X-Gm-Gg: ASbGnctNarKTiQTST6SsYGDWsmvfBMTUPy+W/Em8MV7FJ/j9p/ngZ4ut7qoiw/DJchc
 zLUYjJq+RlpIv/7haHYvpvx/WTXbVuHFWjlaH
X-Google-Smtp-Source: AGHT+IH+5FOtboIu67b54NpB94p8wiJ6Xx4uWEj1nmRdCV1CZ6bTT7yHcbUXD6L8vdNv8+ztkrkn3q86jN41HMNUvCk=
X-Received: by 2002:a05:6402:2548:b0:5d0:8106:aaf4 with SMTP id
 4fb4d7f45d1cf-5d972e6442fmr9580018a12.21.1736534309436; Fri, 10 Jan 2025
 10:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 10 Jan 2025 13:38:17 -0500
X-Gm-Features: AbW1kvbrLh-RPqX5MMNAJ7-pXMywdfHxsuMnbbTtyW9CtG8u4zYMt1zNxM59y1s
Message-ID: <CAJSP0QU85dCHKDUwuW7w2QjBNkR+tJYgQS5wE2_n1yNNmc73kw@mail.gmail.com>
Subject: Re: [PULL 00/32] testing updates for 10.0 (tuxrun, libvirt,
 dockerfiles, misc)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
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

On Fri, 10 Jan 2025 at 08:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit bc6afa1c711da5b4f37c9685a812c77b114d84=
cb:
>
>   Merge tag 'pull-xenfv-20250109-1' of https://gitlab.com/dwmw2/qemu into=
 staging (2025-01-09 08:39:32 -0500)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-10.0-testing-updates-1001=
25-1
>
> for you to fetch changes up to 70b7c929ba39f15a94fbc63d9be88e8da907cc46:
>
>   MAINTAINERS: Remove myself from reviewers (2025-01-10 11:18:38 +0000)
>
> ----------------------------------------------------------------
> Testing updates for 10.0
>
>   - update the tuxrun images to the latest baseline
>   - add the m68k tuxrun test
>   - ensure qtest checks the result of clock_step operations
>   - introduce new ztsd helper to functional tests
>   - ensure aarch64_virt test exits early when no TCG
>   - add new test to exercise virtio-vulkan

Hi Alex,
Please take a look at the following CI job failure and send a new
revision of this pull request if something needs to be fixed:
https://gitlab.com/qemu-project/qemu/-/jobs/8822037880#L593

Thanks,
Stefan

>   - bump libvirt-ci to latest version
>   - move riscv64 cross container from sid to trixie
>   - remove workaround from mips containers now upstream updated
>   - fix VM tests to use correct path for local QEMU binary
>   - add ability to get a root debug shell on VM images
>   - add keymap dependency to vnc tests
>   - remove retiring maintainers from avocado and dockerfiles
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (28):
>       tests/functional: update the arm tuxrun tests
>       tests/functional: update the i386 tuxrun tests
>       tests/functional: add a m68k tuxrun tests
>       tests/functional: update the mips32 tuxrun tests
>       tests/functional: update the mips32el tuxrun tests
>       tests/functional: update the mips64 tuxrun tests
>       tests/functional: update the mips64el tuxrun tests
>       tests/functional: update the ppc32 tuxrun tests
>       tests/functional: update the ppc64 tuxrun tests
>       tests/functional: update the riscv32 tuxrun tests
>       tests/functional: update the riscv64 tuxrun tests
>       tests/functional: update the s390x tuxrun tests
>       tests/functional: update the sparc64 tuxrun tests
>       tests/functional: update the x86_64 tuxrun tests
>       tests/qtest: remove clock_steps from virtio tests
>       system/qtest: properly feedback results of clock_[step|set]
>       tests/functional: remove hacky sleep from the tests
>       tests/functional: add zstd support to uncompress utility
>       tests/functional: update tuxruntest to use uncompress utility
>       tests/functional: remove unused kernel_command_line
>       tests/functional: bail aarch64_virt tests early if missing TCG
>       tests/functional: extend test_aarch64_virt with vulkan test
>       tests/lcitool: bump to latest version of libvirt-ci
>       tests/docker: move riscv64 cross container from sid to trixie
>       tests/vm: fix build_path based path
>       tests/vm: partially un-tabify help output
>       tests/vm: allow interactive login as root
>       pc-bios: ensure keymaps dependencies set vnc tests
>
> Daniel P. Berrang=C3=A9 (1):
>       tests/lcitool: remove temp workaround for debian mips64el
>
> Philippe Mathieu-Daud=C3=A9 (1):
>       dockerfiles: Remove 'MAINTAINER' entry in debian-tricore-cross.dock=
er
>
> Pierrick Bouvier (1):
>       tests/functional/aarch64: add tests for FEAT_RME
>
> Wainer dos Santos Moschetta (1):
>       MAINTAINERS: Remove myself from reviewers
>
>  MAINTAINERS                                        |   3 +-
>  system/qtest.c                                     |  23 ++--
>  tests/qtest/libqos/virtio.c                        |   4 -
>  .gitlab-ci.d/cirrus/freebsd-14.vars                |   2 +-
>  pc-bios/keymaps/meson.build                        |  17 ++-
>  .../dockerfiles/debian-mips64el-cross.docker       |   9 ++
>  .../docker/dockerfiles/debian-riscv64-cross.docker |   4 +-
>  .../docker/dockerfiles/debian-tricore-cross.docker |   2 -
>  tests/functional/meson.build                       |   5 +
>  tests/functional/qemu_test/tuxruntest.py           |  12 +--
>  tests/functional/qemu_test/uncompress.py           |  24 +++++
>  tests/functional/test_aarch64_rme_sbsaref.py       |  69 ++++++++++++
>  tests/functional/test_aarch64_rme_virt.py          |  98 +++++++++++++++=
++
>  tests/functional/test_aarch64_virt.py              | 117 +++++++++++++++=
++----
>  tests/functional/test_arm_tuxrun.py                |  28 ++---
>  tests/functional/test_i386_tuxrun.py               |   8 +-
>  tests/functional/test_m68k_tuxrun.py               |  34 ++++++
>  tests/functional/test_mips64_tuxrun.py             |   8 +-
>  tests/functional/test_mips64el_tuxrun.py           |   8 +-
>  tests/functional/test_mips_tuxrun.py               |   8 +-
>  tests/functional/test_mipsel_tuxrun.py             |   8 +-
>  tests/functional/test_ppc64_tuxrun.py              |  16 +--
>  tests/functional/test_ppc_tuxrun.py                |   8 +-
>  tests/functional/test_riscv32_tuxrun.py            |   8 +-
>  tests/functional/test_riscv64_tuxrun.py            |  16 +--
>  tests/functional/test_s390x_tuxrun.py              |   8 +-
>  tests/functional/test_sparc64_tuxrun.py            |   8 +-
>  tests/functional/test_x86_64_tuxrun.py             |   8 +-
>  tests/lcitool/libvirt-ci                           |   2 +-
>  tests/lcitool/mappings.yml                         |  29 -----
>  tests/lcitool/refresh                              |   4 +-
>  tests/qtest/meson.build                            |   2 +-
>  tests/vm/Makefile.include                          |  29 ++---
>  tests/vm/basevm.py                                 |  12 ++-
>  tests/vm/generated/freebsd.json                    |   2 +-
>  35 files changed, 461 insertions(+), 182 deletions(-)
>  create mode 100755 tests/functional/test_aarch64_rme_sbsaref.py
>  create mode 100755 tests/functional/test_aarch64_rme_virt.py
>  create mode 100755 tests/functional/test_m68k_tuxrun.py
>
> --
> 2.39.5
>
>

