Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40720C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WbJ-00022Y-14; Mon, 13 May 2024 10:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s6WbF-0001wF-E4
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s6WbD-0001FX-La
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715610259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fly/DQ4jQRVsjWcafPVaXrMwiqZtcTcNxfO/l4xbgwQ=;
 b=Fdo+AkxKI344QIjyB/M7Wj37V6aFqLyIOSRaOJ3e9OOIkW4KSRZImcIqR8VhPw8flxPSMt
 2xe4nag/woWoDeChN7OQfqJVp++bDwb1B65g5nP6J/EB7OhkXDHXtQt9bDq9VNAfcsqc/4
 1TgOwC37Wi3TAtblO5huqrpKTNMncTU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-QJAAYZLMNYOGtVQelFjUFQ-1; Mon, 13 May 2024 10:24:17 -0400
X-MC-Unique: QJAAYZLMNYOGtVQelFjUFQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-622ccd54587so39608707b3.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715610257; x=1716215057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fly/DQ4jQRVsjWcafPVaXrMwiqZtcTcNxfO/l4xbgwQ=;
 b=F3VLo/BucuFpu6KP1/BkuWg4HACU/pHHswZFrtl6H3iCr1BWV9KhHnGvoV7guYdn8V
 6+mtbyEUDA+SXqBOQxDko9y/9drDUFXnSrx6cAp5b3klhI980H1ZQKsJQN3MhPYohT2G
 EY1W35s7fWE26BIhWqLPwzpXiIMcKFCFsNoItaIcSC+P/XM1Y9VK5h/VL/QAgfSR7l/D
 +UXYzofdwN5r2nNzuDwn8CP+/TfzDIrawiJGsgf8IgNPPRL89QMYU+4yqO6Sy+p1HYe0
 d3RXLNsmhWo7p+qbWt7I6RtQr2v9ZClGrkQ1wsyUl/Q5aWGeh5OqYkqThjDRpJzdeDzB
 77KQ==
X-Gm-Message-State: AOJu0YzLUotLZzB1cVCDM8u5YPt7Rm6WXmVXJn6UQStwHZKQ5zqkwQKB
 u8aDEItP2ZgfY1MVajmioJailxgJhwLeNQ5MLcksRSIXcph7b9seVY8z4xPFP3uyFPJgEv63J1L
 LBCRIEqtt1cznJV8+tqHcC21XwjRQMg+mveA6QGz77wg3Xjjzdz5xd11YbX6n0H3F7Ko1A+lOg2
 Am1Oq8w7+XguD9fYlSEZndnq5+VS4=
X-Received: by 2002:a05:6902:2205:b0:de5:5bd1:7ae6 with SMTP id
 3f1490d57ef6-dee4f512832mr13668570276.64.1715610257240; 
 Mon, 13 May 2024 07:24:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUN7J9RXxTZpxNNSGIbWq+BaSw/bRjNMsPLKq6eWMroy0AJkXCx8K1gaZ8jbe+WG3S+SRARVYJTVbaB6Wi2aM=
X-Received: by 2002:a05:6902:2205:b0:de5:5bd1:7ae6 with SMTP id
 3f1490d57ef6-dee4f512832mr13668550276.64.1715610256879; Mon, 13 May 2024
 07:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAJaqyWeYtyfGav9Ppx=FgRg_Gzucaoz4T3kVi9EbzrDwwEBsyQ@mail.gmail.com>
 <12430761.O9o76ZdvQC@valdaarhun> <2282965.iZASKD2KPV@valdaarhun>
In-Reply-To: <2282965.iZASKD2KPV@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 13 May 2024 16:23:40 +0200
Message-ID: <CAJaqyWfbHgVA7f81C6phouSUEb7bVwXFRDWTHeie7Vax13zWZw@mail.gmail.com>
Subject: Re: Intention to work on GSoC project
To: Sahil <icegambit91@gmail.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 13, 2024 at 3:49=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> On Wednesday, May 8, 2024 8:53:12=E2=80=AFAM GMT+5:30 Sahil wrote:
> > Hi,
> >
> > On Tuesday, May 7, 2024 12:44:33=E2=80=AFPM IST Eugenio Perez Martin wr=
ote:
> > > [...]
> > >
> > > > Shall I start by implementing a mechanism to check if the feature b=
it
> > > > "VIRTIO_F_RING_PACKED" is set (using "virtio_vdev_has_feature")? An=
d
> > > > if it's supported, "vhost_svq_add" should call "vhost_svq_add_packe=
d".
> > > > Following this, I can then start implementing "vhost_svq_add_packed=
"
> > > > and progress from there.
> > > >
> > > > What are your thoughts on this?
> > >
> > > Yes, that's totally right.
> > >
> > > I recommend you to also disable _F_EVENT_IDX to start, so the first
> > > version is easier.
> > >
> > > Also, you can send as many incomplete RFCs as you want. For example,
> > > you can send a first version that only implements reading of the gues=
t
> > > avail ring, so we know we're aligned on that. Then, we can send
> > > subsequents RFCs adding features on top.
> >
>
> I have started working on implementing packed virtqueue support in
> vhost-shadow-virtqueue.c. The changes I have made so far are very
> minimal. I have one confusion as well.
>
> In "vhost_svq_add()" [1], a structure of type "VhostShadowVirtqueue"
> is being used. My initial idea was to create a whole new structure (eg:
> VhostShadowVirtqueuePacked). But I realized that "VhostShadowVirtqueue"
> is being used in a lot of other places such as in "struct vhost_vdpa" [2]
> (in "vhost-vdpa.h"). So maybe this isn't a good idea.
>
> The problem is that "VhostShadowVirtqueue" has a member of type "struct
> vring" [3] which represents a split virtqueue [4]. My idea now is to inst=
ead
> wrap this member in a union so that the struct would look something like
> this.
>
> struct VhostShadowVirtqueue {
>         union {
>                 struct vring vring;
>                 struct packed_vring vring;
>         }
>         ...
> }
>
> I am not entirely sure if this is a good idea. It is similar to what's be=
en done
> in linux's "drivers/virtio/virtio_ring.c" ("struct vring_virtqueue" [5]).
>
> I thought I would ask this first before continuing further.
>

That's right, this second option makes perfect sense.

VhostShadowVirtqueue should abstract both split and packed. You'll see
that some members are reused, while others are only used in one
version so they are placed after a union. They should follow the same
pattern, although it is not a problem if we need to divert a little
bit from the kernel's code.

Thanks!

> Thanks,
> Sahil
>
> [1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-sh=
adow-virtqueue.c#L249
> [2] https://gitlab.com/qemu-project/qemu/-/blob/master/include/hw/virtio/=
vhost-vdpa.h#L69
> [3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-sh=
adow-virtqueue.h#L52
> [4] https://gitlab.com/qemu-project/qemu/-/blob/master/include/standard-h=
eaders/linux/virtio_ring.h#L156
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/virtio/virtio_ring.c#n199
>
>


