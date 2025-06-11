Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D5BC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 08:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPHDN-0003Po-RH; Wed, 11 Jun 2025 04:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uPHDL-0003PY-Ce
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uPHDJ-0005aa-4U
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749632018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rN/TXUVwEpA5KUVUqvc90UpNSfvltQ2yHXn5QIbMoQY=;
 b=X3jGRDZXjAJYVBJU2HJIU9C4osV2ENQRL9fKGn+MwkT6if3uNt8FrIr/hDidFn/maY6Qlf
 kAoDKy3mE60niiNnXljstRypvdDm2YD8nvvhLr1VLZVLSzigTIxF5C8w13MoI4swwG3Cuq
 y3rkiC7DMIOqdHEamBhDv+Diwiy1LUA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-8o7peV5wPp2m3tp-C9RT8Q-1; Wed, 11 Jun 2025 04:53:37 -0400
X-MC-Unique: 8o7peV5wPp2m3tp-C9RT8Q-1
X-Mimecast-MFC-AGG-ID: 8o7peV5wPp2m3tp-C9RT8Q_1749632016
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-311ef4fb5fdso5617094a91.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 01:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749632016; x=1750236816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rN/TXUVwEpA5KUVUqvc90UpNSfvltQ2yHXn5QIbMoQY=;
 b=K701rKlLLxPAmuQShPjUrMZUUh6iwEOZxQctSBYoGYH0I3HJdJbbHurHCx5B6A+LTu
 tYmmTgOxcGeamAmzqH0taPp//8IQiCKxHKLx+L6QDrZ/g4gfr/+0NX4opAOWL0to0Tew
 V40pFZFOJvsMpxVS0AjzBoadQjqIUYBh7QhVTby4BFhxpfHhVhVT5snI9opxJBBVClrt
 gQTwfMd6hdLbL5vKoTUmXS4qhu1e7TTu4zIm7aIeTMva+ESlHVLFbbTWjV5c/vLRXllE
 NZ0KeKeJKAZfGlYjQTzABAXaOMIoKbnZJpw+M2XKIqJzB0jcEKKyFLqr9wJtEVdQXtvQ
 dK8A==
X-Gm-Message-State: AOJu0Yxup2agbOHixzqz9kcxCWzF7/fzMxr3WTQ/IQCC4dyScxxO8evH
 XhaxHZAd2Vl/g+ArSPM2yXukEOT97cdobBzVE9MUZjVpZtXiKPtPLPMZlQUknxX1tW05keeqn1s
 KtHF3mKEnL+QRKtyQB9m4loZnRo1RqBsLXyXnkPIs6h0XVelDKdrdf6ZV5v/7Ukgq1hwkivxduW
 C4MXB2Oyqe6j0EZK9mXXfZBU4p5EQ2bOY=
X-Gm-Gg: ASbGncu3kuTby1xTXi+zqG0HvE7H3e5X798dJ9r5orOu9Q4PW5fzaqApcTcisvbdTn9
 nOjk5HMDdls5jcmnMmL2d7iAvmtaCek4RPyKSFN2hXSkA9qQeAVjBjfI5/FjKa4zk9Up8vKLqNr
 fnvEY=
X-Received: by 2002:a17:90a:d64f:b0:311:f99e:7f51 with SMTP id
 98e67ed59e1d1-313af1ac76bmr4139715a91.18.1749632016365; 
 Wed, 11 Jun 2025 01:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8wm4dj6xHn+M0qBheoInPGk4X7fELNH4bE2WtGQ6w4yMoEwaCP1QvK3vof4cR3ySXMV7ipVh6eQD24x/ZMPA=
X-Received: by 2002:a17:90a:d64f:b0:311:f99e:7f51 with SMTP id
 98e67ed59e1d1-313af1ac76bmr4139687a91.18.1749632016022; Wed, 11 Jun 2025
 01:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250609144729.884027-1-aesteve@redhat.com>
 <20250609144729.884027-4-aesteve@redhat.com>
 <87jz5ilryx.fsf@alyssa.is>
In-Reply-To: <87jz5ilryx.fsf@alyssa.is>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 11 Jun 2025 10:53:24 +0200
X-Gm-Features: AX0GCFt2UGjAzmFXipa7HBT4xbLhrMXvO87nJt9YQXQTaUzty1gNGeOiXsPUWwE
Message-ID: <CADSE00+Ykw25=N-N88tbkxrSduRhOd2TU5h0oHBSVB6tAynzHg@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, slp@redhat.com, 
 david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 jasowang@redhat.com, stevensd@chromium.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jun 11, 2025 at 8:21=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> Albert Esteve <aesteve@redhat.com> writes:
>
> > Add SHMEM_MAP/_UNMAP request to the vhost-user
> > spec documentation.
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst | 55 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 436a94c0ee..b623284819 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -350,6 +350,27 @@ Device state transfer parameters
> >    In the future, additional phases might be added e.g. to allow
> >    iterative migration while the device is running.
> >
> > +MMAP request
> > +^^^^^^^^^^^^
> > +
> > ++-------+---------+-----------+------------+-----+-------+
> > +| shmid | padding | fd_offset | shm_offset | len | flags |
> > ++-------+---------+-----------+------------+-----+-------+
> > +
> > +:shmid: a 8-bit shared memory region identifier
> > +
> > +:fd_offset: a 64-bit offset of this area from the start
> > +            of the supplied file descriptor
> > +
> > +:shm_offset: a 64-bit offset from the start of the
> > +             pointed shared memory region
> > +
> > +:len: a 64-bit size of the memory to map
> > +
> > +:flags: a 64-bit value:
> > +  - 0: Pages are mapped read-only
> > +  - 1: Pages are mapped read-write
> > +
> >  C structure
> >  -----------
> >
> > @@ -375,6 +396,7 @@ In QEMU the vhost-user message is implemented with =
the following struct:
> >            VhostUserInflight inflight;
> >            VhostUserShared object;
> >            VhostUserTransferDeviceState transfer_state;
> > +          VhostUserMMap mmap;
> >        };
> >    } QEMU_PACKED VhostUserMsg;
> >
> > @@ -1057,6 +1079,7 @@ Protocol features
> >    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> >    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
> >    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> > +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
> >
> >  Front-end message types
> >  -----------------------
> > @@ -1865,6 +1888,38 @@ is sent by the front-end.
> >    when the operation is successful, or non-zero otherwise. Note that i=
f the
> >    operation fails, no fd is sent to the backend.
> >
> > +``VHOST_USER_BACKEND_SHMEM_MAP``
> > +  :id: 9
> > +  :equivalent ioctl: N/A
> > +  :request payload: fd and ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backen=
ds to
> > +  advertise a new mapping to be made in a given VIRTIO Shared Memory R=
egion.
> > +  Upon receiving the message, the front-end will mmap the given fd int=
o the
> > +  VIRTIO Shared Memory Region with the requested ``shmid``. A reply is
> > +  generated indicating whether mapping succeeded.
>
> Should this be phrased to make it clear replies are only generated in
> some cases, like how e.g. VHOST_USER_BACKEND_IOTLB_MSG phrases it?
>
>         If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
>         back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
>         must respond with zero when operation is successfully completed,
>         or non-zero otherwise.
>

Right! Thanks for the catch. I will fix it (and the others in your
comment) in the next version.

BR,
Albert.

> > +
> > +  Mapping over an already existing map is not allowed and request shal=
l fail.
>
> request*s* shall fail
>
> > +  Therefore, the memory range in the request must correspond with a va=
lid,
> > +  free region of the VIRTIO Shared Memory Region. Also, note that mapp=
ings
> > +  consume resources and that the request can fail when there are no re=
sources
> > +  available.
> > +
> > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> > +  :id: 10
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backen=
ds so
> > +  that the front-end un-mmap a given range (``shm_offset``, ``len``) i=
n the
>
> un-mmaps?
>
> > +  VIRTIO Shared Memory Region with the requested ``shmid``. Note that =
the
> > +  given range shall correspond to the entirety of a valid mapped regio=
n.
> > +  A reply is generated indicating whether unmapping succeeded.
> > +
> >  .. _reply_ack:
> >
> >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > --
> > 2.49.0


