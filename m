Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6739C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6W3T-0004Oa-4r; Mon, 13 May 2024 09:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1s6W3R-0004Nm-IS
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:49:25 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1s6W3P-0001n5-Nh
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:49:25 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f44390e328so4104943b3a.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715608161; x=1716212961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4400pty7yswclB7tMxwjeoqulRaqSvjVJ3f1Z8OUh4=;
 b=TNOTayhJkYeKJL48IWo4pFBE2dB7naXToNUbvOs1LWx6hYJe0FLny7xhn9zbjU+17k
 t47hVjqL5hNJp/Qs/nYVUA1yqJj/zSqTecYx1yj+ZRnsxSWPbctb7wCKbvIVAzsvme1D
 ZqAStCpb3UXa/of0su5PlbBxsf7juN9hnKZgCnsajWGGHn4fCusmqNqFXABVJpBOJ8mh
 CCZU1EohgihEoiRUOKZP2aYIF4azqEx4DAT1+HuTv8KaLCT3a0bi5xA36aGZB2tQJS+B
 Oo+pczySGcS3WQZdPvwXumKVTxWZ58/kEzExkdPu6yCN7+Wed9t+42FHXIuLd/hcMx0k
 kVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715608161; x=1716212961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4400pty7yswclB7tMxwjeoqulRaqSvjVJ3f1Z8OUh4=;
 b=jAHfuB0Qc78WuxSxLLoukxDX0yd8ZpKBOzy5qTOzOu9ZdO9j2rAilOLAIFrLImtYQn
 b36aEbfxd4yG/Lt1ccI6r4oWBvwhJeFPqw3G2rvviTsAf+bTkZxL+BSSRR55NUQaoOuY
 Yk0lQfjJDW31g1NkP600EVjTIhMzep97KABe8dr9Hu2Yf20Ov+C0DnZTJEeKRKvf19MF
 mzNfhWHa3a9PVBHKp9n7XCbkmckwDh5mayUvJr4efDLmiaNE0mDpmeoVvFWKoZvxE8YB
 Mrsdf1fmBRkE95Qw1pUFyrdd7Hq5GGd77W8AJSH/Hk4rbY14uByqb5uk4cEeR0cZgVkQ
 s14g==
X-Gm-Message-State: AOJu0YxHGZ6O7YXFydkxB7Wod7bjrYoLgPgM42TXRZ5iT3X8zlzUnANV
 b04AV1JNx+Wehfte86/veNHUwOH9PVDfJpmrx/1dEWZ6KP3+R/qV
X-Google-Smtp-Source: AGHT+IFVJHUCgJ5ee+GNzUfM8LKrPGJkc7k/TkAvc1PumeScBn5nvJ2YHuN/bdt0Qmb9NPTXD7eugg==
X-Received: by 2002:a05:6a20:6a24:b0:1ac:3b5d:a3eb with SMTP id
 adf61e73a8af0-1afde1978b9mr15273945637.39.1715608161352; 
 Mon, 13 May 2024 06:49:21 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.86.42])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340cd6e9dcsm6758546a12.54.2024.05.13.06.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 06:49:20 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Intention to work on GSoC project
Date: Mon, 13 May 2024 19:19:16 +0530
Message-ID: <2282965.iZASKD2KPV@valdaarhun>
In-Reply-To: <12430761.O9o76ZdvQC@valdaarhun>
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAJaqyWeYtyfGav9Ppx=FgRg_Gzucaoz4T3kVi9EbzrDwwEBsyQ@mail.gmail.com>
 <12430761.O9o76ZdvQC@valdaarhun>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

On Wednesday, May 8, 2024 8:53:12=E2=80=AFAM GMT+5:30 Sahil wrote:
> Hi,
>=20
> On Tuesday, May 7, 2024 12:44:33=E2=80=AFPM IST Eugenio Perez Martin wrot=
e:
> > [...]
> >=20
> > > Shall I start by implementing a mechanism to check if the feature bit
> > > "VIRTIO_F_RING_PACKED" is set (using "virtio_vdev_has_feature")? And
> > > if it's supported, "vhost_svq_add" should call "vhost_svq_add_packed".
> > > Following this, I can then start implementing "vhost_svq_add_packed"
> > > and progress from there.
> > >=20
> > > What are your thoughts on this?
> >=20
> > Yes, that's totally right.
> >=20
> > I recommend you to also disable _F_EVENT_IDX to start, so the first
> > version is easier.
> >=20
> > Also, you can send as many incomplete RFCs as you want. For example,
> > you can send a first version that only implements reading of the guest
> > avail ring, so we know we're aligned on that. Then, we can send
> > subsequents RFCs adding features on top.
>

I have started working on implementing packed virtqueue support in
vhost-shadow-virtqueue.c. The changes I have made so far are very
minimal. I have one confusion as well.

In "vhost_svq_add()" [1], a structure of type "VhostShadowVirtqueue"
is being used. My initial idea was to create a whole new structure (eg:
VhostShadowVirtqueuePacked). But I realized that "VhostShadowVirtqueue"
is being used in a lot of other places such as in "struct vhost_vdpa" [2]
(in "vhost-vdpa.h"). So maybe this isn't a good idea.

The problem is that "VhostShadowVirtqueue" has a member of type "struct
vring" [3] which represents a split virtqueue [4]. My idea now is to instead
wrap this member in a union so that the struct would look something like
this.

struct VhostShadowVirtqueue {
        union {
                struct vring vring;
                struct packed_vring vring;
        }
        ...
}

I am not entirely sure if this is a good idea. It is similar to what's been=
 done
in linux's "drivers/virtio/virtio_ring.c" ("struct vring_virtqueue" [5]).

I thought I would ask this first before continuing further.

Thanks,
Sahil

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shad=
ow-virtqueue.c#L249
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/include/hw/virtio/vh=
ost-vdpa.h#L69
[3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shad=
ow-virtqueue.h#L52
[4] https://gitlab.com/qemu-project/qemu/-/blob/master/include/standard-hea=
ders/linux/virtio_ring.h#L156
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/virtio/virtio_ring.c#n199



