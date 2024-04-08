Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FC4CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 07:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjqD-0003Sn-8i; Mon, 08 Apr 2024 03:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rtjqC-0003Sa-DM
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:54:56 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rtjqA-0004Xl-Mx
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:54:56 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4349bba0ba3so4677601cf.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 00:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712562893; x=1713167693;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhxZDU8s9FWgi6OsiVtYzwfN5ZxMtk8EheuYwvtlXDQ=;
 b=ptowPCAMTkFM/8PBlU2eO56WexqWOF6Mm8NINDdvsWyplL77kzxXwgAaJg3alOFeKF
 +/xcTEKnkxySgTs2LMyHJFUHeMyrgveKzRqG5C471WF7Rn4uRYQd2OCKwBBhXHWeEdQX
 VaIaweC9wUqfIIi3JpFvX+MC4ZqyA/3EMA47lrnysyPAuKXvUuQg2oA5IKp9YKGeFBmq
 nPlMzCp93BW1farjJLxdCPJZl8n8otvRgaYjERyzHqriLY6HKE1waNmRwzNTJ2ZWoW1S
 Bws7Uke+vl8Cdf9C7vjuptEDOzGc92hnx9W1TIOtPNUz3afFV8sqGPaGFf17xESB7fNE
 Nd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712562893; x=1713167693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LhxZDU8s9FWgi6OsiVtYzwfN5ZxMtk8EheuYwvtlXDQ=;
 b=rkxcwO9TL249f8TidUBM4NdXmp1VJaO4cOVljMz9ci076IdA/gO9CHhvBQd8L/o6SD
 UA1n40H8gRhe4tlrRhfPAc4j8w30iZX5ST0EqW4syHslM0RfwRhWZYfGpxuuGdYjYHb3
 ZJiiX4ZRJtjkp9x4ypCdaqXWxmtXu4bDkms/yXCttrVUZbfl66m6si0dr66ro8cFMZll
 GMC23g/I51yQk87L9trx+fr2rt2J8qLl9OtpkYrpQMVdV1QE/cSKGLa+49hFZQzf+Pi4
 O7Qju17PrJzaVx6KBr9wMNVBxqizKzkHh6jZIOQkcEjfC4r9LlfBiYmjjKE7izTudEvC
 dpUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0eBYGuX17Qa8V7VkJjvBUxRcd/oOt91D4/V3RWHQ3aQpBz+IiZY6ooAHQpAQY5+0iXk5VVK+a3E8K8Q0Qw9KNfiNjXpw=
X-Gm-Message-State: AOJu0Yyyivr1sbp3tgymdoXWSgau/jrYry9ZEo1ExHGd3gaOywLECx7g
 0XBPvwtdq3jYqphli+UHUyCW1Sq4+YkUYJgyORnX9BojeI43BKg4IB/MzHpXvdHcJVuiY2flLht
 r3OK2jdOsx5DQ9qBK3MUfXrQ8EBYqwVQMZMQlIQ==
X-Google-Smtp-Source: AGHT+IEfxdKLFDTyKVeeRq/UvKbuF1EE5kUfUWDPyYDZUYA9TyXX3ajk6z6074NUSGAYcWpfRCAyMJq+n+eQPCqbp3Q=
X-Received: by 2002:ac8:5d50:0:b0:434:7676:1f9e with SMTP id
 g16-20020ac85d50000000b0043476761f9emr6832099qtx.20.1712562893598; Mon, 08
 Apr 2024 00:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-16-c6d87e69d38b@daynix.com>
 <CAOEp5Od=KUTHnikVBA7iWfdFPJ=T7hbJrSu4zwCiB_Q1P-Sz+Q@mail.gmail.com>
 <8010b335-4b46-456e-bf6e-c191cdc34964@daynix.com>
 <CAOEp5OeHJR=EeZ=yLovSD9vUPt-zRNKLo2k_fNZPP3W-eX4Fiw@mail.gmail.com>
 <d2213191-9b16-4716-a311-97751ba670ad@daynix.com>
In-Reply-To: <d2213191-9b16-4716-a311-97751ba670ad@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 8 Apr 2024 10:54:42 +0300
Message-ID: <CAOEp5OcNkBr4aRzjFQhgsOTmMmO3aPQH2tQLvGcs__=jUVa5sA@mail.gmail.com>
Subject: Re: [PATCH v9 16/20] virtio-net: Do not write hashes to peer buffer
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::82f;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 8, 2024 at 10:42=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/04/08 16:40, Yuri Benditovich wrote:
> > On Mon, Apr 8, 2024 at 4:30=E2=80=AFAM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> On 2024/04/08 7:09, Yuri Benditovich wrote:
> >>> On Wed, Apr 3, 2024 at 2:12=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> The peer buffer is qualified with const and not meant to be modified=
.
> >>>
> >>> IMHO, this buffer is not so 'const' (although the prototype states so=
),
> >>> it is allocated in net.c
> >>> btw, another procedure in this file also modifies the buffer
> >>> (work_around_broken_dhclient)
> >>
> >> Right but it has a FIXME comment.
> >>
> >>>
> >>>> It also prevents enabling VIRTIO_NET_F_HASH_REPORT for peers without
> >>>> virtio-net header support.
> >>>
> >>> Does it mean _this commit_ prevents enabling VIRTIO_NET_F_HASH_REPORT
> >>> for peers without
> >>> virtio-net header support? Where?
> >>
> >> No, but I meant that this patch fixes such a problem.
> >
> > No, it does not. Such a problem does not exist in the master, the
> > hash_report feature
> > is silently dropped in such case:
> > https://github.com/qemu/qemu/blob/master/hw/net/virtio-net.c#L816
>
> Well, silently dropping VIRTIO_NET_F_HASH_REPORT is not different from
> preventing enabling VIRTIO_NET_F_HASH_REPORT, is it?
>
But how is your patch involved in it? Should this line be removed from
the commit message?


> Regards,
> Akihiko Odaki

