Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF3FCD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0VD-0001f1-2y; Tue, 09 Jun 2026 13:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wX0V8-0001dy-BI
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:44:34 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wX0V6-000453-2T
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:44:34 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-68d234218bcso11329175a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781027070; cv=none;
 d=google.com; s=arc-20240605;
 b=X52t1v5vkJRILBf12C0pI9rJnOKZ1FG0TMZO5QGyINXlEpqFAYDMZvzkx9Qy/TajFD
 v5QJiRHFV2R5nbXj3cPJC7K6KpuiZg1xuQHdXVG+phzf35h3bDZd0SBkufTW5eOZbsUE
 xC5MazEqQ2IMj9XKPFijNpr7618PYScor7l3W81DnUj6T3zFoSNLPGxzmHI7+dze4F4k
 YLqpYo7Qqqx9N/v76z9QCfyF+2ZjMGmh36MYOl/GuiBDTR0BJIEftCG0sZeGRtphJM+3
 2yCARRCiv4nxLS8NatN4jh16W0BDytcLO/ZMD8LCBRdXoNMSp+UKpFoEVojEyQcvd0wG
 CN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rKm/3ftaCAX4rc+0Kh88Fj0PnURZpBO/LFTCOGnqsf0=;
 fh=7lWkBl+tJ3ptrhAMeOg1p3FM2lpY7P0xglrUQ0dKiDo=;
 b=CioImyLZuFh+0NTNojmWHBHSoz6qyTq3TG8xHtyBUGZBcqMWpTPdxEyGed0qoLkK4L
 97CDv1EbOWyY2ELEodU8K+YU0NnjvCH6faomObn4zBNigWmhKWrQCVs7Xw/YdxrAoV1j
 L33JfwXMpDSqVYLYg1YDbcV3+UgpusHq92HwOIeQQI3S4M0tTY3RNBAXCLGxLNVTAxpz
 EMM8SPe3ZVr8Y55WgNhKErvWfKifm/dASPjpiRV6bSRnSBIvxzwN7VxI33eppXEdDn1p
 oUlKK7iGb+LBryg/JlMj9VEp9GMobg+nqX0ePFEB7kPHKpTA6Tv4erQjuZ7v4Ex4aIeX
 5ugg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781027070; x=1781631870; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKm/3ftaCAX4rc+0Kh88Fj0PnURZpBO/LFTCOGnqsf0=;
 b=EVEVItB2lZZl9W4tCwCjYi/JozJy0OGZDFLjXsNrUBxOIgDqMvjMvn2LHn2WmL90tx
 Onz52GsxgH+yqAutMaclZM/7F1Y1iVkkML0806nZKBLbblrD8DMHIps94bhTCB+N5ON2
 GwM54qIVcj4puXcaK9daPoV3N2+kZjkQKI7Tj+/aHjjzE2XCo4Eq6pxaBOz0PmBmczjs
 oqUcs+8Fc0v2QG3jQxZ9ndVBNyXr95Wwz0TXOhqIrhzmHC4U0fQ5aY8mOOwJ3/OeaTJe
 /HR9vqAys0XjQ8rhFkJlqeLc1bItp4dD3fpbg8KZdet39FscFx66NcdUBDvLQ6mBZ3OG
 FD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781027070; x=1781631870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rKm/3ftaCAX4rc+0Kh88Fj0PnURZpBO/LFTCOGnqsf0=;
 b=XVdd+8aq7PRG366e6w35zElpE0grawsJuco8apEr3SWgvI3wgBdPNbP0XOb71TkYf7
 EZIEX38jtNWohoxBqe6d+hpvkR88jLQcotK2VIDnmmSc2Q3GVxAFrCfeEhZfNdIP+qSc
 GLE1z7UI3BWHfOm9Wia2D6Ysheqb/bE8PVZ5wh/deCoEO+R+VzisJfSJTwnNs/hyFLwM
 xFZpYqsOHhL1Zc78IRbuc1XSUuLQk4QbcUj+BCykT2nzWzFbA4bjTvLSpy2/q0IoopPJ
 FSQfxRvnilTN5hRhqxTpyap7tb3EtyGtzEG1S6r4PT4CYsc23u+rexy5NnaHJ8hBGC5E
 zzZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mcuKFIWOVwgefKKPSLBFL9hOWIVy53b9cwChiEcIRu4EucykxHmdLBtoEbyfFkwtsPoEs8zlApyNX@nongnu.org
X-Gm-Message-State: AOJu0YxHJQ/xDw8+dCgZZfEEVP/w/w1+jeAyom6JSWon2KWuPbUUyWqC
 V0jTu/ZOsS3nqZH8Oa9i1sZeTc3zGeOLuopMIVisTHuz6aOPPfE3+xS2uF3EKQ9H47V8Na/IfNP
 tjCarvrWGe/Lz4fZQVEAGXKrMYXgzuo8=
X-Gm-Gg: Acq92OF1jEYzFS+U7gYgO75WtbLTeKz/7CX1CTcAfWhuyK7vH/jW0ZfGlbp2guAFUDi
 NaeOY5T9bJdUEW/AhmUB9LL7mqRQ0U5tK062fh6zAKbtRY7ptuodz+N2Iqlk4oJrk1rUfvdlYin
 tdmrHUSUOvOT4VtgTCJNERNhh0xM8MjNinWHjopItBMGg4491YlnqQiIZtKx4vU/NnvSkRCAvm7
 9hy9HX76tn0wO10uaNA2k+C2bh+FFkzfIMRGflaa0whAI3v55U5bObgmkikEg3hCi9rYqyo5AZv
 s60zeHEncxDg38aUXK06DFARy/kJWVCyT+c+M7Fu5az8HVhT1nOa
X-Received: by 2002:a05:6402:3807:b0:689:816a:5367 with SMTP id
 4fb4d7f45d1cf-68fa47b83edmr9821270a12.0.1781027069636; Tue, 09 Jun 2026
 10:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260608165207.307488-1-kwolf@redhat.com>
In-Reply-To: <20260608165207.307488-1-kwolf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 9 Jun 2026 13:44:16 -0400
X-Gm-Features: AVVi8CeQXQqvlNYPczCrr5gmNyJ9ybvIMmhwlq2J_JrbZKGigKJoBgURF6rZExE
Message-ID: <CAJSP0QXjj32djLOFPNg2jKjNN6eB7VvRXVfz3XiNkWYjR0-S2A@mail.gmail.com>
Subject: Re: [PULL 0/8] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 8, 2026 at 12:52=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> The following changes since commit cc329c491768b2d91eb0b0984f3baa0bf80577=
6d:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into=
 staging (2026-06-08 09:30:30 -0400)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 296b66d05bac7eb2b86600febdbd2bd8d410f026:
>
>   qed: Don't try to flush during incoming migration (2026-06-08 17:00:47 =
+0200)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - qcow2: Fix data loss on zero write with detect-zeroes=3Dunmap
> - qemu-img bitmap: add sub-command --remove-all
> - export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to fix regression

Hi Fiona and Kevin,
Please take a look at the CI failure below. If the root cause is in
this pull request, please send a new revision with fixed patches or
without the patches that cause the failure. Thanks!

>>> UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:=
print_stacktrace=3D1 LD_LIBRARY_PATH=3D/builds/qemu-project/qemu/build/subp=
rojects/libvfio-user/lib MALLOC_PERTURB_=3D83 MESON_TEST_ITERATION=3D1 ASAN=
_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 MSAN_OPTI=
ONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktra=
ce=3D1 PYTHON=3D/builds/qemu-project/qemu/build/pyvenv/bin/python3 RUST_BAC=
KTRACE=3D1 /builds/qemu-project/qemu/build/pyvenv/bin/python3 /builds/qemu-=
project/qemu/build/../tests/qemu-iotests/check -tap -luks fuse-mmap-shared =
--source-dir /builds/qemu-project/qemu/tests/qemu-iotests --build-dir /buil=
ds/qemu-project/qemu/build/tests/qemu-iotests
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
--- /builds/qemu-project/qemu/tests/qemu-iotests/tests/fuse-mmap-shared.out
+++ /builds/qemu-project/qemu/build/scratch/luks-file-fuse-mmap-shared/fuse=
-mmap-shared.out.bad
@@ -1,5 +1,22 @@
-.
+E
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ERROR: test_mmap_shared (__main__.TestMmapShared)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+ File "/builds/qemu-project/qemu/tests/qemu-iotests/tests/fuse-mmap-shared=
",
line 55, in setUp
+ qemu_io(image, '-c', f'write -P 23 0 {image_size}')
+ File "/builds/qemu-project/qemu/tests/qemu-iotests/iotests.py", line
364, in qemu_io
+ return qemu_tool(*qemu_io_wrap_args(args),
+ File "/builds/qemu-project/qemu/tests/qemu-iotests/iotests.py", line
241, in qemu_tool
+ raise VerboseProcessError(
+qemu.utils.VerboseProcessError: Command
'('/builds/qemu-project/qemu/build/qemu-io', '--cache', 'writeback',
'--aio', 'threads',
'/builds/qemu-project/qemu/build/scratch/luks-file-fuse-mmap-shared/image.l=
uks',
'-c', 'write -P 23 0 1048576')' returned non-zero exit status 1.
+ =E2=94=8F=E2=94=81 output =E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81
+ =E2=94=83 qemu-io: can't open device /builds/qemu-project/qemu/build/scra=
tch/
+ =E2=94=83 luks-file-fuse-mmap-shared/image.luks: Parameter 'key-secret' i=
s
+ =E2=94=83 required for cipher
+ =E2=94=97=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81
+
----------------------------------------------------------------------
Ran 1 tests
-OK
+FAILED (errors=3D1)

https://gitlab.com/qemu-project/qemu/-/jobs/14772570524#L257

Stefan

> - virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check (CVE-2026-4891=
4)
> - qed: Don't try to flush during incoming migration
> - iotests/136: Test stats-intervals with -blockdev/-device
>
> ----------------------------------------------------------------
> Denis V. Lunev (1):
>       qemu-img: add sub-command --remove-all to 'qemu-img bitmap'
>
> Fabiano Rosas (1):
>       qed: Don't try to flush during incoming migration
>
> Fiona Ebner (3):
>       block/export/fuse: use struct fuse_init_in
>       block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to fix regres=
sion
>       iotests: test shared mmap for fuse export
>
> Kevin Wolf (1):
>       iotests/136: Test stats-intervals with -blockdev/-device
>
> Stefan Hajnoczi (1):
>       virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check (CVE-2026-=
48914)
>
> Thomas Lamprecht (1):
>       qcow2: Fix data loss on zero write with detect-zeroes=3Dunmap
>
>  docs/tools/qemu-img.rst                       |  10 ++-
>  block/qcow2.h                                 |   4 +
>  block/export/fuse.c                           |  69 +++++++++++++----
>  block/qcow2-cluster.c                         |  10 +--
>  block/qcow2.c                                 |   8 +-
>  block/qed.c                                   |  16 ++--
>  hw/block/virtio-blk.c                         |   8 +-
>  qemu-img.c                                    |  55 ++++++++++++--
>  tests/qemu-iotests/046                        |  23 ++++++
>  tests/qemu-iotests/046.out                    |  10 +++
>  tests/qemu-iotests/136                        |  87 +++++++++++++++++++-=
--
>  tests/qemu-iotests/136.out                    |   4 +-
>  tests/qemu-iotests/tests/fuse-mmap-shared     | 103 ++++++++++++++++++++=
++++++
>  tests/qemu-iotests/tests/fuse-mmap-shared.out |   5 ++
>  tests/qemu-iotests/tests/qemu-img-bitmaps     |  24 ++++++
>  tests/qemu-iotests/tests/qemu-img-bitmaps.out |  46 ++++++++++++
>  16 files changed, 430 insertions(+), 52 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/fuse-mmap-shared
>  create mode 100644 tests/qemu-iotests/tests/fuse-mmap-shared.out
>
>

