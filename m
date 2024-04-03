Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17507CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 18:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs5Vb-0007He-Jb; Wed, 03 Apr 2024 14:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rs5VY-0007Gk-6t
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rs5VJ-0000ZG-21
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712169511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pcIeJgYpoGbqGOJEcjpvsQvZiwbHDt2TZLwfiC8kuIM=;
 b=MVFcje8MdOBpjPEi6N4qKN2vN7pPLv0+p9c7oKTuEBOEtioJdTGf5fq/PA1CjFXciurOew
 n3xWfw3m8ao/Es1JzlP95dsZKElITLchtrURm8l0Y61glhL+EyWwgYcAAeSewpdl8ZCWxN
 mN8tPwjUTk2dzvPMUl1WU2GBIzUQ2R4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-VvK7FeVxMK6MmhDEVgGIaw-1; Wed, 03 Apr 2024 14:38:26 -0400
X-MC-Unique: VvK7FeVxMK6MmhDEVgGIaw-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dd1395fd1bfso365800276.0
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 11:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712169506; x=1712774306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcIeJgYpoGbqGOJEcjpvsQvZiwbHDt2TZLwfiC8kuIM=;
 b=IroXj/CWBGlZypyH2lAbwQG9bn7DxvREkJmfx6z6tmafkhmjYIUS3jKuXV5vXhbTHU
 4mRIA8vOwODnUzeIuOTXnkmudO5yiUBZm34X/p9AA5/HQQBY9nveyygOy9UpkWPbY3/C
 3Joc1+fEr9oWOtS4sBza5Vlq0Ghk/CuI0YiALmlmVhs0wyv75JOJPZu26ylK1F0V6gbx
 YNKf69hgx1DxkI0nHg4n3oggprcVdYP15ilAh/tNESFNG2lKHym+NVwjjbHEZg+RFaf7
 T6w3hHnlAEdv6OYPJtyKmzP6mSkojMRRNa8IjpqW/LjnQkJ4cTLP8U6UbmzF+NOP5Epq
 r++w==
X-Gm-Message-State: AOJu0YygdFBu63e2vam+jfUiFu6zvCIryDhlbRm0YYCmztwdAp9oL0xG
 BAyK7Cd+J0R34Ql6MEMmKRH/HSMe7F+H6+uvg9jiW3E8Ebl5OwIF5aXeRHrHea6reve/DCRShQt
 hvwOib8kc/tZ0mXyjjLIfHrzkNrmuK9lg3/9bBv5q9fALkGmbn7z1nvz+iWPAenBCpBJRtCX3PE
 ar8lUk3mxRz9uNZ2i8oy8A4HlC0lM=
X-Received: by 2002:a25:4c8a:0:b0:dcf:309d:cc2b with SMTP id
 z132-20020a254c8a000000b00dcf309dcc2bmr300414yba.18.1712169505869; 
 Wed, 03 Apr 2024 11:38:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTHloETFCNHwi8OrP+7guK7BMTqCiwHtCYk8+EfAXcO6e4iJJQTtRsOCPqKifDMVXwWABUkHqh951Hj7Zk/Rs=
X-Received: by 2002:a25:4c8a:0:b0:dcf:309d:cc2b with SMTP id
 z132-20020a254c8a000000b00dcf309dcc2bmr300400yba.18.1712169505376; Wed, 03
 Apr 2024 11:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <13625712.uLZWGnKmhe@valdaarhun> <10440822.nUPlyArG6x@valdaarhun>
 <CAJaqyWfeUHTEj6F-uBzA57gPLZhD70w1+FY2sDCTFBHEDkzzPA@mail.gmail.com>
 <1934013.taCxCBeP46@valdaarhun>
In-Reply-To: <1934013.taCxCBeP46@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Apr 2024 20:37:49 +0200
Message-ID: <CAJaqyWc+8OJZ33TtqeBy+Vy9HdW8zzbMKqg2mNWVaFda=g0XBA@mail.gmail.com>
Subject: Re: Intention to work on GSoC project
To: Sahil <icegambit91@gmail.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Apr 3, 2024 at 4:36=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote:
>
> Hi,
>
> Thank you for the reply.
>
> On Tuesday, April 2, 2024 5:08:24 PM IST Eugenio Perez Martin wrote:
> > [...]
> > > > > Q2.
> > > > > In the Red Hat article, just below the first listing ("Memory lay=
out of a
> > > > > packed virtqueue descriptor"), there's the following line referri=
ng to the
> > > > > buffer id in "virtq_desc":
> > > > > > This time, the id field is not an index for the device to look =
for the
> > > > > > buffer: it is an opaque value for it, only has meaning for the =
driver.
> > > > >
> > > > > But the device returns the buffer id when it writes the used desc=
riptor to
> > > > > the descriptor ring. The "only has meaning for the driver" part h=
as got me
> > > > > a little confused. Which buffer id is this that the device return=
s? Is it related
> > > > > to the buffer id in the available descriptor?
> > > >
> > > > In my understanding, buffer id is the element that avail descriptor
> > > > marks to identify when adding descriptors to table. Device will ret=
urns
> > > > the buffer id in the processed descriptor or the last descriptor in=
 a
> > > > chain, and write it to the descriptor that used idx refers to (firs=
t
> > > > one in the chain). Then used idx increments.
> > > >
> > > > The Packed Virtqueue blog [1] is helpful, but some details in the
> > > > examples
> > > > are making me confused.
> > > >
> > > > Q1.
> > > > In the last step of the two-entries descriptor table example, it sa=
ys
> > > > both buffers #0 and #1 are available for the device. I understand
> > > > descriptor[0] is available and descriptor[1] is not, but there is n=
o ID #0
> > > > now. So does the device got buffer #0 by notification beforehand? I=
f so,
> > > > does it mean buffer #0 will be lost when notifications are disabled=
?
> >
> > I guess you mean the table labeled "Figure: Full two-entries descriptor
> > table".
> >
> > Take into account that the descriptor table is not the state of all
> > the descriptors. That information must be maintained by the device and
> > the driver internally.
> >
> > The descriptor table is used as a circular buffer, where one part is
> > writable by the driver and the other part is writable by the device.
> > For the device to override the descriptor table entry where descriptor
> > id 0 used to be does not mean that the descriptor id 0 is used. It
> > just means that the device communicates to the driver that descriptor
> > 1 is used, and both sides need to keep the descriptor state
> > coherently.
> >
> > > I too have a similar question and understanding the relation between
> > > buffer
> > > ids in the used and available descriptors might give more insight int=
o
> > > this. For available descriptors, the buffer id is used to associate
> > > descriptors with a particular buffer. I am still not very sure about =
ids
> > > in used descriptors.
> > >
> > > Regarding Q1, both buffers #0 and #1 are available. In the mentioned
> > > figure, both descriptor[0] and descriptor[1] are available. This figu=
re
> > > follows the figure with the caption "Using first buffer out of order"=
. So
> > > in the first figure the device reads buffer #1 and writes the used
> > > descriptor but it still has buffer #0 to read. That still belongs to =
the
> > > device while buffer #1 can now be handled by the driver once again. S=
o in
> > > the next figure, the driver makes buffer #1 available again. The devi=
ce
> > > can still read buffer #0 from the previous batch of available
> > > descriptors.
> > >
> > > Based on what I have understood, the driver can't touch the descripto=
r
> > > corresponding to buffer #0 until the device acknowledges it. I did fi=
nd
> > > the
> > > figure a little confusing as well. I think once the meaning of buffer=
 id
> > > is clear from the driver's and device's perspective, it'll be easier =
to
> > > understand the figure.
> >
> > I think you got it right. Please let me know if you have further questi=
ons.
>
> I would like to clarify one thing in the figure "Full two-entries descrip=
tor
> table". The driver can only overwrite a used descriptor in the descriptor
> ring, right?

Except for the first round, the driver can only write to used entries
in the descriptor table. In other words, their avail and used flags
must be equal.

> And likewise for the device?

Yes, but with avail descs. I think you got this already, but I want to
be as complete as possible here.

> So in the figure, the driver will
> have to wait until descriptor[1] is used before it can overwrite it?
>

Yes, but I think it is easier to think that both descriptor id 0 and 1
are available already. The descriptor id must be less than virtqueue
size.

An entry with a valid buffer and length must be invalid because of the
descriptor id in that situation, either because it is a number > vq
length or because it is a descriptor already available.

> Suppose the device marks descriptor[0] as used. I think the driver will
> not be able to overwrite that descriptor entry because it has to go in
> order and is at descriptor[1]. Is that correct?

The device must write one descriptor as used, either 0 or 1, at
descriptors[0] as all the descriptors are available.

Now, it does not matter if the device marks as used one or the two
descriptors: the driver must write its next available descriptor at
descriptor[1]. This is not because descriptor[1] contains a special
field or data, but because the driver must write the avail descriptors
sequentially, so the device knows the address to poll or check after a
notification.

In other words, descriptor[1] is just a buffer space from the driver
to communicate an available descriptor to the device. It does not
matter what it contained before the writing, as the driver must
process that information before writing the new available descriptor.

> Is it possible for the driver
> to go "backwards" in the descriptor ring?
>

Nope, under any circumstance.

> > > I am also not very sure about what happens when notifications are
> > > disabled.
> > > I'll have to read up on that again. But I believe the driver still wo=
n't
> > > be able to touch #0 until the device uses it.
> >
> > If one side disables notification it needs to check the indexes or the
> > flags by its own means: Timers, read the memory in a busy loop, etc.
>
> Understood. Thank you for the clarification.
>
> I have some questions from the "Virtio live migration technical deep
> dive" article [1].
>
> Q1.
> In the paragraph just above Figure 6, there is the following line:
> > the vhost kernel thread and QEMU may run in different CPU threads,
> > so these writes must be synchronized with QEMU cleaning of the dirty
> > bitmap, and this write must be seen strictly after the modifications of
> > the guest memory by the QEMU thread.
>
> I am not clear on the last part of the statement. The modification of gue=
st
> memory is being done by the vhost device and not by the QEMU thread, righ=
t?
>

QEMU also writes to the bitmap cleaning it, so it knows the memory
does not need to be resent.

Feel free to ask questions about this, but you don't need to interact
with the dirty bitmap in the project.

> Q2.
> In the first point of the "Dynamic device state: virtqueue state" section=
:
> >The guest makes available N descriptors at the source of the migration,
> >so its avail idx member in the avail idx is N.
>
> I think there's a typo here: "...avail idx member in the avail ring is N"
> instead of "...avail idx is N".
>

Good catch! I'll fix it, thanks!

> Regarding the implementation of this project, can the project be broken
> down into two parts:
> 1. implementing packed virtqueues in QEMU, and

Right, but let me expand on this: QEMU already supports packed
virtqueue in an emulated device (hw/virtio/virtio.c). The missing part
is the "driver" one, to be able to communicate with a vDPA device, at
hw/virtio/vhost-shadow-virtqueue.c.

> 2. providing mechanisms for (live) migration to work with packed
>     virtqueues.
>

The first part implements packed vq without live migration and then
test for live migration on top, yes. But if everything is right, this
step should require no changes from 1 actually. It is totally ok if we
need to dedicate time to this of course.

> I am ready to start working on the implementation. In one of your
> previous emails you had talked about moving packed virtqueue
> related implementation from the kernel's drivers/virtio/virtio_ring.c
> into vhost_shadow_virtqueue.c.
>

Right.

> My plan is to also understand how split virtqueue has been implemented
> in QEMU. I think that'll be helpful when moving the kernel's implementati=
on
> to QEMU.
>

Sure, the split virtqueue is implemented in the same file
vhost_shadow_virtqueue.c. If you deploy vhost_vdpa +vdpa_sim or
vp_vdpa [1][2], you can:
* Run QEMU with -netdev type=3Dvhost-vdpa,x-svq=3Don
* Set GDB breakpoint in interesting functions like
vhost_handle_guest_kick and vhost_svq_flush.

Thanks!

> Please let me know if I should change my approach.
>
> Thanks,
> Sahil
>
>


