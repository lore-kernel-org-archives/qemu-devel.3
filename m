Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D71CF31A1
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuz1-0000gd-Vh; Wed, 02 Oct 2024 04:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1svuz0-0000dh-6W
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:45:18 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1svuyy-0006V0-7z
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:45:17 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4585e25f42bso64069151cf.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727858715; x=1728463515; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IJt5/fqBAQfZgjKu4c2uw+ROpa3FzdV7OIc7R8w4WEk=;
 b=aodRhAhKisveNvGhdQ3T3fad5enzMmI4H6qSyMxm8raadfmP5Ry+PPXpGmJtJznka7
 DVVQ2n+9bqaHHeAs22EyNAZRhRr0BHvlvPkdUfdga3mzV06f3Wrd0FBxHFcd39U3BDQo
 sODY3cAWVcm8mG64YPttvJu/+qaBQQCzR9oFM3kk7FEGLGXZQBo0IS/G743l5M5Pp/aw
 lIJE9sRgocIvb/LZDf0cbnLoMg0I9nYA8kjKNyzqV+/pGR/UVZOe8Hy+Kn7000IzV7lK
 LxYS+mNmzHzI83vgxQqXUJY3bZbY+o/gfsLveuGMVLcE601r4/5Wyn3nohfqA3sxGhCW
 jJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727858715; x=1728463515;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IJt5/fqBAQfZgjKu4c2uw+ROpa3FzdV7OIc7R8w4WEk=;
 b=X7YV0WEGhzC4eNKoHfw7HXmPdblqwKwjA+D5EMljTkSovGNmKkFEMI3QGTYUxpT+Vx
 GEjp9XlnyVN5ZElQeB37Nf3DgZvivJbwfzRfHOlORzg5fXzX6jFXVKhREJZs87ZBAh5Q
 vL/N/iUKbJpjFJ7xxI7YmXg/hQ7xsmPxwTM1vGs/D2qkJYfhopVNVCadI/8X5Uv+j9os
 fzwt20V30t0IE3c+/uVVNaXM6ZR69JPnlmOzgJLZBzIICa8bRXCYPBDXr27U+EXWU11+
 8gxAQZdM5j3GWsndKVwVk7xiisgcT+/B/hdxvbTXfJCgddHqeIlYGWlagPDieVT6skBt
 AFew==
X-Gm-Message-State: AOJu0YyqZm+daSPDYyBEWOu6QXYopNeAO8efo79MUVSwhZNaagSH3PQQ
 wb9sRVwW3ebSyZVPzpukjEMQAf3wywM/5LvGug09Jdwf84jCZY8hNvZ6JmPV7BFQcGrUzcn2qD0
 K745a7HubB5CTOHQK/uyfGMQYE7M=
X-Google-Smtp-Source: AGHT+IE52+YfNbzUekBacEzi8gfzNxMk5BUNx+Urlgr8j7vsnZDmejgEgknufox1VhIDyJjmaM4I9nVPsPpIqdR6yMU=
X-Received: by 2002:ac8:7c48:0:b0:458:3735:da3c with SMTP id
 d75a77b69052e-45d8056a777mr36821961cf.50.1727858714855; Wed, 02 Oct 2024
 01:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
 <b5c138db-2632-4ae4-bb65-afaf20aa89b9@redhat.com>
In-Reply-To: <b5c138db-2632-4ae4-bb65-afaf20aa89b9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 2 Oct 2024 12:45:03 +0400
Message-ID: <CAJ+F1CKbMQ8drnyur5puC63OP8e3WT+ASmoazOL2-OoC+zfQ6g@mail.gmail.com>
Subject: Re: [PULL 00/22] -Werror=maybe-uninitialized fixes
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Content-Type: multipart/alternative; boundary="000000000000ebcfaf06237a74c1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000ebcfaf06237a74c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Oct 2, 2024 at 12:43=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> On 02/10/2024 10.36, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The following changes since commit
> 718780d20470c66a3a36d036b29148d5809dc855:
> >
> >    Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu
> into staging (2024-10-01 11:34:07 +0100)
> >
> > are available in the Git repository at:
> >
> >    https://gitlab.com/marcandre.lureau/qemu.git tags/warn-pull-request
> >
> > for you to fetch changes up to baad82ecfb27474f17f4318502725622ab7170fc=
:
> >
> >    qom/object: fix -Werror=3Dmaybe-uninitialized (2024-10-02 11:36:12
> +0400)
> >
> > ----------------------------------------------------------------
> > -Werror=3Dmaybe-uninitialized fixes
> >
> > ----------------------------------------------------------------
> >
> > Marc-Andr=C3=A9 Lureau (22):
> >    util/coroutine: fix -Werror=3Dmaybe-uninitialized false-positive
> >    util/timer: fix -Werror=3Dmaybe-uninitialized false-positive
> >    hw/qxl: fix -Werror=3Dmaybe-uninitialized false-positives
> >    nbd: fix -Werror=3Dmaybe-uninitialized false-positive
> >    block/mirror: fix -Werror=3Dmaybe-uninitialized false-positive
> >    block/mirror: fix -Werror=3Dmaybe-uninitialized false-positive
> >    block/stream: fix -Werror=3Dmaybe-uninitialized false-positives
> >    hw/ahci: fix -Werror=3Dmaybe-uninitialized false-positive
> >    hw/vhost-scsi: fix -Werror=3Dmaybe-uninitialized
> >    hw/sdhci: fix -Werror=3Dmaybe-uninitialized false-positive
> >    block/block-copy: fix -Werror=3Dmaybe-uninitialized false-positive
> >    migration: fix -Werror=3Dmaybe-uninitialized false-positives
> >    hw/virtio-blk: fix -Werror=3Dmaybe-uninitialized false-positive
> >    migration: fix -Werror=3Dmaybe-uninitialized false-positive
> >    linux-user/hppa: fix -Werror=3Dmaybe-uninitialized false-positive
> >    target/loongarch: fix -Werror=3Dmaybe-uninitialized false-positive
> >    tests: fix -Werror=3Dmaybe-uninitialized false-positive
> >    hw/virtio: fix -Werror=3Dmaybe-uninitialized
> >    hw/virtio: freeing leaked memory from vhost_svq_get_buf in
> >      vhost_svq_poll
> >    block: fix -Werror=3Dmaybe-uninitialized false-positive
> >    fsdep/9p: fix -Werror=3Dmaybe-uninitialized false-positive
> >    qom/object: fix -Werror=3Dmaybe-uninitialized
> >
> >   block/block-copy.c                 |  2 +-
> >   block/file-posix.c                 |  2 +-
> >   block/mirror.c                     |  8 ++++----
> >   block/stream.c                     |  6 +++---
> >   fsdev/9p-iov-marshal.c             | 15 ++++++++++++---
> >   hw/block/virtio-blk.c              |  2 +-
> >   hw/display/qxl.c                   |  4 ++--
> >   hw/ide/ahci.c                      |  3 ++-
> >   hw/scsi/vhost-scsi.c               |  2 +-
> >   hw/sd/sdhci.c                      |  2 +-
> >   hw/virtio/vhost-shadow-virtqueue.c |  6 ++++--
> >   linux-user/hppa/cpu_loop.c         |  2 ++
> >   migration/dirtyrate.c              |  4 ++--
> >   migration/migration.c              |  2 +-
> >   migration/ram.c                    |  2 +-
> >   nbd/client-connection.c            |  2 +-
> >   qom/object.c                       |  2 +-
> >   target/loongarch/gdbstub.c         | 26 ++++++++++++++------------
> >   tests/unit/test-bdrv-drain.c       |  2 +-
> >   tests/unit/test-block-iothread.c   |  2 +-
> >   util/qemu-coroutine.c              |  2 +-
> >   util/qemu-timer.c                  |  6 +++---
> >   roms/openbios                      |  2 +-
>
> Replying here as well, so that Peter has a chance to see it:
>
> The update to roms/openbios in patch 03 seems to have slipped in by
> accident, so I'd suggest to fix that first before merging this.
>
>
\o/ submodules :)

Peter, do you want a v2?
thanks


--=20
Marc-Andr=C3=A9 Lureau

--000000000000ebcfaf06237a74c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Oct 2, 2024 at 12:43=E2=80=AFPM Thoma=
s Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 02/10/202=
4 10.36, <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">m=
arcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; The following changes since commit 718780d20470c66a3a36d036b29148d5809=
dc855:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 Merge tag &#39;pull-nvme-20241001&#39; of <a href=3D"http=
s://gitlab.com/birkelund/qemu" rel=3D"noreferrer" target=3D"_blank">https:/=
/gitlab.com/birkelund/qemu</a> into staging (2024-10-01 11:34:07 +0100)<br>
&gt; <br>
&gt; are available in the Git repository at:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://gitlab.com/marcandre.lureau/qemu.git" =
rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/marcandre.lureau/qe=
mu.git</a> tags/warn-pull-request<br>
&gt; <br>
&gt; for you to fetch changes up to baad82ecfb27474f17f4318502725622ab7170f=
c:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 qom/object: fix -Werror=3Dmaybe-uninitialized (2024-10-02=
 11:36:12 +0400)<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; -Werror=3Dmaybe-uninitialized fixes<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; <br>
&gt; Marc-Andr=C3=A9 Lureau (22):<br>
&gt;=C2=A0 =C2=A0 util/coroutine: fix -Werror=3Dmaybe-uninitialized false-p=
ositive<br>
&gt;=C2=A0 =C2=A0 util/timer: fix -Werror=3Dmaybe-uninitialized false-posit=
ive<br>
&gt;=C2=A0 =C2=A0 hw/qxl: fix -Werror=3Dmaybe-uninitialized false-positives=
<br>
&gt;=C2=A0 =C2=A0 nbd: fix -Werror=3Dmaybe-uninitialized false-positive<br>
&gt;=C2=A0 =C2=A0 block/mirror: fix -Werror=3Dmaybe-uninitialized false-pos=
itive<br>
&gt;=C2=A0 =C2=A0 block/mirror: fix -Werror=3Dmaybe-uninitialized false-pos=
itive<br>
&gt;=C2=A0 =C2=A0 block/stream: fix -Werror=3Dmaybe-uninitialized false-pos=
itives<br>
&gt;=C2=A0 =C2=A0 hw/ahci: fix -Werror=3Dmaybe-uninitialized false-positive=
<br>
&gt;=C2=A0 =C2=A0 hw/vhost-scsi: fix -Werror=3Dmaybe-uninitialized<br>
&gt;=C2=A0 =C2=A0 hw/sdhci: fix -Werror=3Dmaybe-uninitialized false-positiv=
e<br>
&gt;=C2=A0 =C2=A0 block/block-copy: fix -Werror=3Dmaybe-uninitialized false=
-positive<br>
&gt;=C2=A0 =C2=A0 migration: fix -Werror=3Dmaybe-uninitialized false-positi=
ves<br>
&gt;=C2=A0 =C2=A0 hw/virtio-blk: fix -Werror=3Dmaybe-uninitialized false-po=
sitive<br>
&gt;=C2=A0 =C2=A0 migration: fix -Werror=3Dmaybe-uninitialized false-positi=
ve<br>
&gt;=C2=A0 =C2=A0 linux-user/hppa: fix -Werror=3Dmaybe-uninitialized false-=
positive<br>
&gt;=C2=A0 =C2=A0 target/loongarch: fix -Werror=3Dmaybe-uninitialized false=
-positive<br>
&gt;=C2=A0 =C2=A0 tests: fix -Werror=3Dmaybe-uninitialized false-positive<b=
r>
&gt;=C2=A0 =C2=A0 hw/virtio: fix -Werror=3Dmaybe-uninitialized<br>
&gt;=C2=A0 =C2=A0 hw/virtio: freeing leaked memory from vhost_svq_get_buf i=
n<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vhost_svq_poll<br>
&gt;=C2=A0 =C2=A0 block: fix -Werror=3Dmaybe-uninitialized false-positive<b=
r>
&gt;=C2=A0 =C2=A0 fsdep/9p: fix -Werror=3Dmaybe-uninitialized false-positiv=
e<br>
&gt;=C2=A0 =C2=A0 qom/object: fix -Werror=3Dmaybe-uninitialized<br>
&gt; <br>
&gt;=C2=A0 =C2=A0block/block-copy.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0block/file-posix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0block/mirror.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++++----<br>
&gt;=C2=A0 =C2=A0block/stream.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++---<br>
&gt;=C2=A0 =C2=A0fsdev/9p-iov-marshal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 15 ++++++++++++---<br>
&gt;=C2=A0 =C2=A0hw/block/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/display/qxl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
&gt;=C2=A0 =C2=A0hw/ide/ahci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
&gt;=C2=A0 =C2=A0hw/scsi/vhost-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/sd/sdhci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/virtio/vhost-shadow-virtqueue.c |=C2=A0 6 ++++--<br>
&gt;=C2=A0 =C2=A0linux-user/hppa/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A0migration/dirtyrate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
&gt;=C2=A0 =C2=A0migration/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0nbd/client-connection.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0qom/object.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0target/loongarch/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 26 ++++++++++++++------------<br>
&gt;=C2=A0 =C2=A0tests/unit/test-bdrv-drain.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0tests/unit/test-block-iothread.c=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
&gt;=C2=A0 =C2=A0util/qemu-coroutine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0util/qemu-timer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +++---<br>
&gt;=C2=A0 =C2=A0roms/openbios=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
<br>
Replying here as well, so that Peter has a chance to see it:<br>
<br>
The update to roms/openbios in patch 03 seems to have slipped in by <br>
accident, so I&#39;d suggest to fix that first before merging this.<br>
<br></blockquote><div><br></div><div>\o/ submodules :)</div><div><br></div>=
<div>Peter, do you want a v2?</div><div>thanks <br></div></div><br clear=3D=
"all"><br><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"=
ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000ebcfaf06237a74c1--

