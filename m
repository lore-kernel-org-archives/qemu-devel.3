Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2317C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6wI-00036e-FC; Thu, 06 Feb 2025 13:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tg6wG-00036H-7F
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:49:24 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tg6wE-0007eI-DL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:49:23 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso2556793a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738867760; x=1739472560; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+I9nMqELfhPm4IUFs/x9Det3slQB3FM2Ywh9QKPHog=;
 b=am1UdH+IecS0pCoMquLYTbao+FMJE/YK7VS7MBFGHmeTrfdon2VpZB6cD1I8EmIyNP
 dyYCjjG4llhckZbZ0bslwVGfCU2I0cr/MD+PB11O+hsXGs+eB3qCKxeo9mzuBbjxjrwv
 LwHRaoOfD/psYcJcz31MM8sH7bSY5S/psFCVDj1WZjun6wnULiKlqkicT1UIdZmGCXFQ
 PFnVGGk1YFTXZ6Zu0McATH40BfICuaARgx44bNrU2crhwj1VbUyceXWvjpoXpMOk95O2
 y3acqfgC4sRHlLy1ZLub3MJheORtTgLUBdTFWW1k77KlXzOPJt1OgEp84vbv37R1ubXH
 2a6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738867760; x=1739472560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+I9nMqELfhPm4IUFs/x9Det3slQB3FM2Ywh9QKPHog=;
 b=PALoe+6WjMCbhGsPUCouHXrEhLlnms7AyIiw2oSxZHBAqBoPBo0ySMohNYjeo3r6mY
 y5Ep9J7KnCJaxQkAj5yX3Bqn67KUibRBFnBo1kmHnoWY60ov3fMUs86TF1pMckXQwShV
 v6AK8QcCXhLAGL/NqkG05vqk+u2H9HQ3SIUgAh5zVZsO5DmTNfoQX4AAHp+PxV56234Z
 APm6+pu/6J6tPnYLx8ssCLjqKMHRRISmQk3bpQmLY3Y/yGqmvontPC15GClyShfPcxIU
 o6Cto/JsHeJp2VQIOO+hgAfZGeEe869q8RqpcK+iGTp0NOoWhYmMh1yWvyr9w3ARjBH6
 YKrg==
X-Gm-Message-State: AOJu0Yz6JlP5RdlUEi+/dLeExjliWrmP5b5so4u6BqNAboDl/Tbct7a6
 u6nKSxkJUBWlVp2caLS0z6+JT/27UV5w91hfo2irLODpYVjqcjcd6NpZLpL7WQUBnK9PMC7lkr9
 RfWGRSQb6ydA0XlbNr1sagziel2g=
X-Gm-Gg: ASbGncsQGIC1NgRXK7m5vldmnV09SYg666wqQcu8NU1EwmqjYTE9mSh3rK3GDDrHg2T
 5b+AJRubHpoGj8YEJO82oTB2BGMF/c3a9j8NIwvTMBhiaaCA2YvptdUzxk8y7Vu1kDQNTC5Y=
X-Google-Smtp-Source: AGHT+IFyRE7JuOsXbmnO8h/CfHrgj4/ZJtS0JIxnDRtLF5FRK068/TCtCpG/TIOSjIw/NBUGshMvWv2OFdOv002eaAA=
X-Received: by 2002:a05:6402:1ecf:b0:5dc:1395:1d3a with SMTP id
 4fb4d7f45d1cf-5de45040136mr408664a12.1.1738867760302; Thu, 06 Feb 2025
 10:49:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738860115.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1738860115.git.qemu_oss@crudebyte.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 6 Feb 2025 13:49:07 -0500
X-Gm-Features: AWEUYZl2Hy-W1oc2NAF6G7L2o3651f498M9kaHc3ifh6NutBm55TItuOKq0QouI
Message-ID: <CAJSP0QVAdAEKVi6WBGm=XM_wZTjnD5r=qEe9SWwZh6uv5O5uYw@mail.gmail.com>
Subject: Re: [PULL 0/7] 9p queue 2025-02-06
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
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

On Thu, Feb 6, 2025 at 11:49=E2=80=AFAM Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit d922088eb4ba6bc31a99f17b32cf75e59dd306=
cd:
>
>   Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu=
 into staging (2025-02-03 13:42:02 -0500)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20250206
>
> for you to fetch changes up to bfa7bf02782dbd996201c90f850ca11730041af1:
>
>   MAINTAINERS: Mark me as reviewer only for 9pfs (2025-02-06 17:10:46 +01=
00)
>
> ----------------------------------------------------------------
>
> * Greg Kurz steps back as maintainer of 9pfs.
>
> * Make multidevs=3Dremap default option (instead of multidevs=3Dwarn)
>   and update documentation related to this option.
>
> * Improve tracing (i.e. usefulness of log output content).
>
> * Add test cases for accessing a directory after removal.
>
> ----------------------------------------------------------------
> Christian Schoenebeck (6):
>       9pfs: improve v9fs_walk() tracing
>       9pfs: make multidevs=3Dremap default
>       9pfs: improve v9fs_open() tracing
>       tests/9p: rename test use_after_unlink -> use_file_after_unlink
>       tests/9p: add use_dir_after_unlink test
>       tests/9p: extend use_dir_after_unlink test with Treaddir

The following test failure occurred in the CI system:

12/65 qemu:qtest+qtest-x86_64 / qtest-x86_64/qos-test ERROR 14.74s
killed by signal 6 SIGABRT
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
Received response 7 (RLERROR) instead of 77 (RUNLINKAT)
Rlerror has errno 22 (Invalid argument)
**
ERROR:../tests/qtest/libqos/virtio-9p-client.c:276:v9fs_req_recv:
assertion failed (hdr.id =3D=3D id): (7 =3D=3D 77)
(test program exited with status code -6)

https://gitlab.com/qemu-project/qemu/-/jobs/9065429175

Please take a look. Thanks!

Stefan

>
> Greg Kurz (1):
>       MAINTAINERS: Mark me as reviewer only for 9pfs
>
>  MAINTAINERS                  |  3 +--
>  hw/9pfs/9p-local.c           |  3 +++
>  hw/9pfs/9p-util-generic.c    | 50 ++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/9pfs/9p-util.h            |  6 ++++++
>  hw/9pfs/9p.c                 | 45 +++++++++++++++++++++++++++++++++-----=
-
>  hw/9pfs/meson.build          |  1 +
>  hw/9pfs/trace-events         |  4 ++--
>  qemu-options.hx              | 49 ++++++++++++++++++++++++--------------=
-----
>  tests/qtest/virtio-9p-test.c | 50 ++++++++++++++++++++++++++++++++++++++=
++----
>  9 files changed, 175 insertions(+), 36 deletions(-)
>  create mode 100644 hw/9pfs/9p-util-generic.c
>

