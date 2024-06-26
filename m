Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34D4C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 07:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMNTZ-0002Dk-Pm; Wed, 26 Jun 2024 03:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sMNTU-0002DD-Gq
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sMNTQ-0000MR-Fc
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719388427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RWyMbEYqq4coMkg9cVbmH90qtq5RsiIxIUwc6TWS7TY=;
 b=V+g6hJvVA6cUya1R3v2VkrcJjWq8FLb0XVcFlOywlX0lKSXqbSU3OSK6s4dDSEaiumL95Z
 fFZBohkEE+2AS7Xch2Eln5S33HIENZnZR41h67lckougYjwtQHzZZBINGVAUKfn0iIVH8s
 yydZzvoPrKC46ehlB9LG79UkyxYWZdI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-6_kqZDxIP66jFUQgr2QpPw-1; Wed, 26 Jun 2024 03:53:42 -0400
X-MC-Unique: 6_kqZDxIP66jFUQgr2QpPw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c7430b3c4bso8156100a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 00:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719388421; x=1719993221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RWyMbEYqq4coMkg9cVbmH90qtq5RsiIxIUwc6TWS7TY=;
 b=Za4LDdKiqj8kwM6TsOGJ+qaYcHkUnSzz9ODB3VfBShgJdmkvd+z3UuKvtZTiqLleH1
 5T1H5CzBMZ8QvwZpI8yJTuN1dUEalkuqbbeT/vVcBRMpNETQmKoO0c9wId2DVJAn0cgq
 QqqUK48HFq29l5KaA+I3ksqqwFCMDji5aND2pnYMqH2+Fk/WBwd18uyYYji/B6pZfrUI
 eQUIGXYNEOSfUZPih+hRHN8D/trHK35HfVdqoaDl2knWlLnzydu56zD9jpFk+KXpMpih
 GPMn3+oP33J/ekEdPC7j/WTRjiaWJouDo6aPeL/zBSLMl37FR1TR2HUTMrHnAkri2Ax2
 6WpA==
X-Gm-Message-State: AOJu0YwIi46BkOF5VOFUDKAAKGXXeog49Cut7fB9bFBP/Ao+p6Vmyjt3
 lHyBN1SRgtB57COxspDUJH6loXdysTTkFOIAMXFFtA3IHJRIncsXWjE4HOdK26SZyxOE0l8Jnut
 V83BZnYrGVl9CtfFL459K4rdQgSndQz2bgT2kBe9gnmfl2eFyYz0stvE5Hu4uo4XeJuze2aca5f
 D1jhIVoBknZnAjoSNsngOGfvTa/8fZKVmiF0g=
X-Received: by 2002:a17:90a:fc47:b0:2c1:a99b:7467 with SMTP id
 98e67ed59e1d1-2c8581e5525mr9142931a91.19.1719388421315; 
 Wed, 26 Jun 2024 00:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0RIEcPPgZQH6KwXiihKYeL/LXqeCWck2nplj5TgwIS1T2LQULEog+X8UCJCXsijXs6KtYruEmRxhEQQ6bT48=
X-Received: by 2002:a17:90a:fc47:b0:2c1:a99b:7467 with SMTP id
 98e67ed59e1d1-2c8581e5525mr9142921a91.19.1719388420870; Wed, 26 Jun 2024
 00:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240530152223.780232-1-aesteve@redhat.com>
 <20240530152223.780232-2-aesteve@redhat.com>
 <20240604185416.GB90471@fedora.redhat.com>
 <CADSE00+yvsOhiJJg0ePgr7AYVCkjm9xWNj7KpAOFMwj2wuEpGg@mail.gmail.com>
 <20240605142849.GC135899@fedora.redhat.com>
In-Reply-To: <20240605142849.GC135899@fedora.redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 26 Jun 2024 09:53:29 +0200
Message-ID: <CADSE00+WtK8t5jxNxjthupEuovs5+eNJWshzjxWzYaTnZSL=uw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] vhost-user: add shmem mmap request
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, slp@redhat.com, jasowang@redhat.com
Content-Type: multipart/alternative; boundary="0000000000000eaf8f061bc65072"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000000eaf8f061bc65072
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Wed, Jun 5, 2024 at 4:28=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:

> On Wed, Jun 05, 2024 at 10:13:32AM +0200, Albert Esteve wrote:
> > On Tue, Jun 4, 2024 at 8:54=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
.com>
> wrote:
> >
> > > On Thu, May 30, 2024 at 05:22:23PM +0200, Albert Esteve wrote:
> > > > Add SHMEM_MAP/UNMAP requests to vhost-user.
> > > >
> > > > This request allows backends to dynamically map
> > > > fds into a shared memory region indentified by
> > >
> > > Please call this "VIRTIO Shared Memory Region" everywhere (code,
> > > vhost-user spec, commit description, etc) so it's clear that this is
> not
> > > about vhost-user shared memory tables/regions.
> > >
> > > > its `shmid`. Then, the fd memory is advertised
> > > > to the frontend through a BAR+offset, so it can
> > > > be read by the driver while its valid.
> > >
> > > Why is a PCI BAR mentioned here? vhost-user does not know about the
> > > VIRTIO Transport (e.g. PCI) being used. It's the frontend's job to
> > > report VIRTIO Shared Memory Regions to the driver.
> > >
> > >
> > I will remove PCI BAR, as it is true that it depends on the
> > transport. I was trying to explain that the driver
> > will use the shm_base + shm_offset to access
> > the mapped memory.
> >
> >
> > > >
> > > > Then, the backend can munmap the memory range
> > > > in a given shared memory region (again, identified
> > > > by its `shmid`), to free it. After this, the
> > > > region becomes private and shall not be accessed
> > > > by the frontend anymore.
> > >
> > > What does "private" mean?
> > >
> > > The frontend must mmap PROT_NONE to reserve the virtual memory space
> > > when no fd is mapped in the VIRTIO Shared Memory Region. Otherwise an
> > > unrelated mmap(NULL, ...) might use that address range and the guest
> > > would have access to the host memory! This is a security issue and
> needs
> > > to be mentioned explicitly in the spec.
> > >
> >
> > I mentioned private because it changes the mapping from MAP_SHARED
> > to MAP_PRIVATE. I will highlight PROT_NONE instead.
>
> I see. Then "MAP_PRIVATE" would be clearer. I wasn't sure whether you
> mean mmap flags or something like the memory range is no longer
> accessible to the driver.
>
> >
> >
> > >
> > > >
> > > > Initializing the memory region is reponsiblity
> > > > of the PCI device that will using it.
> > >
> > > What does this mean?
> > >
> >
> > The MemoryRegion is declared in `struct VirtIODevice`,
> > but it is uninitialized in this commit. So I was trying to say
> > that the initialization will happen in, e.g., vhost-user-gpu-pci.c
> > with something like `memory_region_init` , and later `pci_register_bar`=
.
>
> Okay. The device model needs to create MemoryRegion instances for the
> device's Shared Memory Regions and add them to the VirtIODevice.
>
> --device vhost-user-device will need to query the backend since, unlike
> vhost-user-gpu-pci and friends, it doesn't have knowledge of specific
> device types. It will need to create MemoryRegions enumerated from the
> backend.
>
> By the way, the VIRTIO MMIO Transport also supports VIRTIO Shared Memory
> Regions so this work should not be tied to PCI.
>
> >
> > I am testing that part still.
> >
> >
> > >
> > > >
> > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > ---
> > > >  docs/interop/vhost-user.rst |  23 ++++++++
> > > >  hw/virtio/vhost-user.c      | 106
> ++++++++++++++++++++++++++++++++++++
> > > >  hw/virtio/virtio.c          |   2 +
> > > >  include/hw/virtio/virtio.h  |   3 +
> > > >  4 files changed, 134 insertions(+)
> > >
> > > Two missing pieces:
> > >
> > > 1. QEMU's --device vhost-user-device needs a way to enumerate VIRTIO
> > > Shared Memory Regions from the vhost-user backend. vhost-user-device =
is
> > > a generic vhost-user frontend without knowledge of the device type, s=
o
> > > it doesn't know what the valid shmids are and what size the regions
> > > have.
> > >
> >
> > Ok. I was assuming that if a device (backend) makes a request without a
> > valid shmid or not enough size in the region to perform the mmap, would
> > just fail in the VMM performing the actual mmap operation. So it would
> > not necessarily need to know about valid shmids or region sizes.
>
> But then --device vhost-user-device wouldn't be able to support VIRTIO
> Shared Memory Regions, which means this patch series is incomplete. New
> vhost-user features need to support both --device vhost-user-<type>-*
> and --device vhost-user-device.
>
> What's needed is:
> 1. New vhost-user messages so the frontend can query the shmids and
>    sizes from the backend.
> 2. QEMU --device vhost-user-device code that queries the VIRTIO Shared
>    Memory Regions from the vhost-user backend and then creates
>    MemoryRegions for them.
>
> >
> >
> > >
> > > 2. Other backends don't see these mappings. If the guest submits a
> vring
> > > descriptor referencing a mapping to another backend, then that backen=
d
> > > won't be able to access this memory. David Gilbert hit this problem
> when
> > > working on the virtiofs DAX Window. Either the frontend needs to
> forward
> > > all SHMAP_MAP/UNMAP messages to the other backends (inefficient and
> > > maybe racy!) or a new "memcpy" message is needed as a fallback for wh=
en
> > > vhost-user memory region translation fails.
> > >
> >
> > Ok. In which scenario would another device want to access the same
> mapping?
> > If it is for a shared VIRTIO object, the device that receives the dmabu=
f
> fd
> > could
> > just do a new mapping in its VIRTIO shared memory region.
>
> You can reproduce this with two virtiofs devices. Where device A has the
> DAX Window feature enabled. The test program mmaps the DAX file and then
> opens a new file on device B and performs an O_DIRECT write(2) syscall.
>
> I think that this issue must be address in this series since this issue
> is introduced by enabling VIRTIO Shared Memory Regions in vhost-user.
>
> A bit more detail:
>
> Device A has a VIRTIO Shared Memory Region. An application mmaps that
> memory (examples: guest userspace driver using Linux VFIO, a guest
> kernel driver that exposes the memory to userspace via mmap, or guest
> kernel DAX). The application passes that memory as an I/O buffer to
> device B (e.g. O_DIRECT disk I/O).
>
> The result is that device B's vhost-user backend receives a vring
> descriptor that points to a guest memory address in device A's VIRTIO
> Shared Memory Region. Since device B does not have this memory in its
> table, it cannot translate the address and the device breaks.
>
>
I am working on the next version, and I am struggling on what to do
to solve this situation.
So IIUC is the device B (in your example) who will notice that it cannot
translate, and then, the backend will send a message (let's say,
SHMEM_COPY) to the frontend so that it copies all mappings
done on device A to device B. Something like that?
Maybe better only for the mapping that triggered the
message?

But the message would have to point to the device A so that
the frontend knows the src and dest to perform the memcpy?
And indicate the memory range that we want to map (offset + len).
I am not sure how the frontend would know that it needs to copy
from device A to device B after receiving the new message,
and get a pointer of both devices (device B is easy as it is
the one that sent the message, but not device A).
Or maybe I misunderstood your suggested solution.

BR,
Albert.


> >
> >
> > >
> > > >
> > > > diff --git a/docs/interop/vhost-user.rst
> b/docs/interop/vhost-user.rst
> > > > index d8419fd2f1..3caf2a290c 100644
> > > > --- a/docs/interop/vhost-user.rst
> > > > +++ b/docs/interop/vhost-user.rst
> > > > @@ -1859,6 +1859,29 @@ is sent by the front-end.
> > > >    when the operation is successful, or non-zero otherwise. Note
> that if
> > > the
> > > >    operation fails, no fd is sent to the backend.
> > > >
> > > > +``VHOST_USER_BACKEND_SHMEM_MAP``
> > > > +  :id: 9
> > > > +  :equivalent ioctl: N/A
> > > > +  :request payload: fd and ``struct VhostUserMMap``
> > > > +  :reply payload: N/A
> > > > +
> > > > +  This message can be submitted by the backends to advertise a new
> > > mapping
> > > > +  to be made in a given shared memory region. Upon receiving the
> > > message,
> > > > +  QEMU will mmap the given fd into the shared memory region with t=
he
> > >
> > > s/QEMU/the frontend/
> > >
> > > > +  requested ``shmid``. A reply is generated indicating whether
> mapping
> > > > +  succeeded.
> > >
> > > Please document whether mapping over an existing mapping is allowed. =
I
> > > think it should be allowed because it might be useful to atomically
> > > update a mapping without a race where the driver sees unmapped memory=
.
> > >
> > >
> > So in my understanding, the frontend (driver) in the guest would initia=
te
> > the
> > mmap/munmap by sending request to the backend (vhost-user device).
> > Then the vhost-user device sends a request to the VMM to perform the
> > mapping. We could enforce an ACK to ensure that the mmap operation
> finished
> > before the vhost-user device responds to the driver, and thus avoid
> > races. This way, we support only the simple usecase of not allowing
> > mmaps over an already mapped region.
>
> I think it's fine to start with the stricter model where no overlapping
> mappings are allowed. If someone needs overlapping mappings in the
> future, a feature bit could be added to negotiate support.
>
> Please document that overlapping mappings are not supported.
>
> > > If mapping over an existing mapping is allowed, does the new mapping
> > > need to cover the old mapping exactly, or can it span multiple previo=
us
> > > mappings or a subset of an existing mapping?
> > >
> > > From a security point of view we need to be careful here. A potential=
ly
> > > untrusted backend process now has the ability to mmap an arbitrary fi=
le
> > > descriptor into the frontend process. The backend can cause
> > > denial of service by creating many small mappings to exhaust the OS
> > > limits on virtual memory areas. The backend can map memory to use as
> > > part of a security compromise, so we need to be sure the virtual memo=
ry
> > > addresses are not leaked to the backend and only read/write page
> > > permissions are available.
> > >
> >
> > Right, security from untrusted backends is usally the hardest part to m=
e.
> > But vhost-user devices do only see shm_offset, so this should be safe,
> no?
>
> Yes, I think the current interface is safe, too.
>
> > >
> > > > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> > > > +  :id: 10
> > > > +  :equivalent ioctl: N/A
> > > > +  :request payload: ``struct VhostUserMMap``
> > > > +  :reply payload: N/A
> > > > +
> > > > +  This message can be submitted by the backends so that QEMU un-mm=
ap
> > >
> > > s/QEMU/the frontend/
> > >
> >
> > This is probably my bad, but I really thought the frontend is the drive=
r.
> > So frontend/backend as alternative terms for vhost-user driver/device.
>
> "vhost-user driver" is not a term that's used, as far as I know. The
> vhost-user spec calls it the front-end (older code and docs may call it
> the vhost-user master).
>
> > And then here we would keep QEMU or use VMM instead?
>
> The vhost-user spec uses both front-end and QEMU to mean the same thing.
> VMM is not used in the vhost-user spec. I suggest using front-end in new
> spec text because QEMU is not the only application that implements this
> spec anymore.
>
> >
> >
> > >
> > > > +  a given range (``offset``, ``len``) in the shared memory region
> with
> > > the
> > > > +  requested ``shmid``.
> > >
> > > Does the range need to correspond to a previously-mapped VhostUserMMa=
p
> > > or can it cross multiple VhostUserMMaps, be a subset of a
> VhostUserMMap,
> > > etc?
> > >
> >
> > I would prefer to keep it simple and disallow mapping over a
> > previously-mapped
> > region. The range need to correspond to a valid (within size bound),
> free,
> > memory region, or else the request will fail. I will add that to the
> text.
> >
> > Nonetheless, I am open to discuss other options.
>
> That sounds good. I'm not aware of any use cases that require anything
> fancy.
>
> >
> >
> > >
> > > > +  A reply is generated indicating whether unmapping succeeded.
> > > > +
> > > >  .. _reply_ack:
> > > >
> > > >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > index cdf9af4a4b..9526b9d07f 100644
> > > > --- a/hw/virtio/vhost-user.c
> > > > +++ b/hw/virtio/vhost-user.c
> > > > @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
> > > >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> > > >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> > > >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > > > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > > > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> > > >      VHOST_USER_BACKEND_MAX
> > > >  }  VhostUserBackendRequest;
> > > >
> > > > @@ -192,6 +194,23 @@ typedef struct VhostUserShared {
> > > >      unsigned char uuid[16];
> > > >  } VhostUserShared;
> > > >
> > > > +/* For the flags field of VhostUserMMap */
> > > > +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> > > > +#define VHOST_USER_FLAG_MAP_W (1u << 1)
> > > > +
> > > > +typedef struct {
> > > > +    /* Shared memory region ID */
> > > > +    uint8_t shmid;
> > >
> > > There is a hole (padding) in the struct since the following fields ar=
e
> > > naturally aligned to 8 bytes. I suggest moving shmid to the end to
> > > reduce the chance of information leaks if padding is not zeroed.
> > >
> >
> > I see. I can move it to the end of the struct or add a padding field in
> > between. I'll do what you suggested, as it sound like the simplest
> solution.
> >
> >
> > >
> > > > +    /* File offset */
> > > > +    uint64_t fd_offset;
> > > > +    /* Offset within the shared memory region */
> > > > +    uint64_t shm_offset;
> > > > +    /* Size of region to map */
> > >
> > > To avoid giving "region" additional meanings:
> > >
> > > s/Size of the region to map/Size of the mapping/
> > >
> >
> > Ok, I will change it in the next drop. Probably will keep the RFC for
> > at least one more patch, seeing that there are a few things I wasn't
> > correctly considering.
> >
> > Thanks for all the feedback!
>
> Great, thanks!
>
> Stefan
>
> >
> >
> > >
> > > > +    uint64_t len;
> > > > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> > > > +    uint64_t flags;
> > > > +} VhostUserMMap;
> > > > +
> > > >  typedef struct {
> > > >      VhostUserRequest request;
> > > >
> > > > @@ -224,6 +243,7 @@ typedef union {
> > > >          VhostUserInflight inflight;
> > > >          VhostUserShared object;
> > > >          VhostUserTransferDeviceState transfer_state;
> > > > +        VhostUserMMap mmap;
> > > >  } VhostUserPayload;
> > > >
> > > >  typedef struct VhostUserMsg {
> > > > @@ -1748,6 +1768,85 @@
> > > vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> > > >      return 0;
> > > >  }
> > > >
> > > > +static int
> > > > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > > > +                                  VhostUserMMap *vu_mmap,
> > > > +                                  int fd)
> > > > +{
> > > > +    void *addr =3D 0;
> > > > +    MemoryRegion *mr =3D NULL;
> > > > +
> > > > +    if (fd < 0) {
> > > > +        error_report("Bad fd for map");
> > > > +        return -EBADF;
> > > > +    }
> > > > +
> > > > +    if (!dev->vdev->shmem_list ||
> > > > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> > > > +        error_report("Shared memory region at "
> > > > +                     "ID %d unitialized", vu_mmap->shmid);
> > > > +        return -EFAULT;
> > > > +    }
> > > > +
> > > > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > > > +
> > > > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > > > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> > > > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx6=
4,
> > > > +                     vu_mmap->shm_offset, vu_mmap->len);
> > > > +        return -EFAULT;
> > > > +    }
> > > > +
> > > > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> > > > +
> > > > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
> > > > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0)=
 |
> > > > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_W) ? PROT_WRITE : 0=
),
> > > > +        MAP_SHARED | MAP_FIXED, fd, vu_mmap->fd_offset);
> > > > +    if (addr =3D=3D MAP_FAILED) {
> > > > +        error_report("Failed to mmap mem fd");
> > > > +        return -EFAULT;
> > > > +    }
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > > +static int
> > > > +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> > > > +                                    VhostUserMMap *vu_mmap)
> > > > +{
> > > > +    void *addr =3D 0;
> > > > +    MemoryRegion *mr =3D NULL;
> > > > +
> > > > +    if (!dev->vdev->shmem_list ||
> > > > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> > > > +        error_report("Shared memory region at "
> > > > +                     "ID %d unitialized", vu_mmap->shmid);
> > > > +        return -EFAULT;
> > > > +    }
> > > > +
> > > > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > > > +
> > > > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > > > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> > > > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx6=
4,
> > > > +                     vu_mmap->shm_offset, vu_mmap->len);
> > > > +        return -EFAULT;
> > > > +    }
> > > > +
> > > > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> > > > +
> > > > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
> > > > +                PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED=
,
> -1,
> > > 0);
> > > > +
> > > > +    if (addr =3D=3D MAP_FAILED) {
> > > > +        error_report("Failed to unmap memory");
> > > > +        return -EFAULT;
> > > > +    }
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > >  static void close_backend_channel(struct vhost_user *u)
> > > >  {
> > > >      g_source_destroy(u->backend_src);
> > > > @@ -1816,6 +1915,13 @@ static gboolean backend_read(QIOChannel *ioc=
,
> > > GIOCondition condition,
> > > >          ret =3D
> > > vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
> > > >                                                               &hdr,
> > > &payload);
> > > >          break;
> > > > +    case VHOST_USER_BACKEND_SHMEM_MAP:
> > > > +        ret =3D vhost_user_backend_handle_shmem_map(dev,
> &payload.mmap,
> > > > +                                                fd ? fd[0] : -1);
> > > > +        break;
> > > > +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > > > +        ret =3D vhost_user_backend_handle_shmem_unmap(dev,
> &payload.mmap);
> > > > +        break;
> > > >      default:
> > > >          error_report("Received unexpected msg type: %d.",
> hdr.request);
> > > >          ret =3D -EINVAL;
> > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > index 893a072c9d..59596370ec 100644
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -3264,6 +3264,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t
> > > device_id, size_t config_size)
> > > >              virtio_vmstate_change, vdev);
> > > >      vdev->device_endian =3D virtio_default_endian();
> > > >      vdev->use_guest_notifier_mask =3D true;
> > > > +    vdev->shmem_list =3D NULL;
> > > > +    vdev->n_shmem_regions =3D 0;
> > > >  }
> > > >
> > > >  /*
> > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.=
h
> > > > index 7d5ffdc145..34bec26593 100644
> > > > --- a/include/hw/virtio/virtio.h
> > > > +++ b/include/hw/virtio/virtio.h
> > > > @@ -165,6 +165,9 @@ struct VirtIODevice
> > > >       */
> > > >      EventNotifier config_notifier;
> > > >      bool device_iotlb_enabled;
> > > > +    /* Shared memory region for vhost-user mappings. */
> > > > +    MemoryRegion *shmem_list;
> > > > +    int n_shmem_regions;
> > > >  };
> > > >
> > > >  struct VirtioDeviceClass {
> > > > --
> > > > 2.44.0
> > > >
> > >
>

--0000000000000eaf8f061bc65072
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div>Hi Stefan,</div></div></div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 5, 2024 at 4:28=E2=80=
=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Wed, Jun 05, 2024 at 10:13:32AM +0200, Albert Esteve wrote:<b=
r>
&gt; On Tue, Jun 4, 2024 at 8:54=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"=
mailto:stefanha@redhat.com" target=3D"_blank">stefanha@redhat.com</a>&gt; w=
rote:<br>
&gt; <br>
&gt; &gt; On Thu, May 30, 2024 at 05:22:23PM +0200, Albert Esteve wrote:<br=
>
&gt; &gt; &gt; Add SHMEM_MAP/UNMAP requests to vhost-user.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This request allows backends to dynamically map<br>
&gt; &gt; &gt; fds into a shared memory region indentified by<br>
&gt; &gt;<br>
&gt; &gt; Please call this &quot;VIRTIO Shared Memory Region&quot; everywhe=
re (code,<br>
&gt; &gt; vhost-user spec, commit description, etc) so it&#39;s clear that =
this is not<br>
&gt; &gt; about vhost-user shared memory tables/regions.<br>
&gt; &gt;<br>
&gt; &gt; &gt; its `shmid`. Then, the fd memory is advertised<br>
&gt; &gt; &gt; to the frontend through a BAR+offset, so it can<br>
&gt; &gt; &gt; be read by the driver while its valid.<br>
&gt; &gt;<br>
&gt; &gt; Why is a PCI BAR mentioned here? vhost-user does not know about t=
he<br>
&gt; &gt; VIRTIO Transport (e.g. PCI) being used. It&#39;s the frontend&#39=
;s job to<br>
&gt; &gt; report VIRTIO Shared Memory Regions to the driver.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; I will remove PCI BAR, as it is true that it depends on the<br>
&gt; transport. I was trying to explain that the driver<br>
&gt; will use the shm_base + shm_offset to access<br>
&gt; the mapped memory.<br>
&gt; <br>
&gt; <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Then, the backend can munmap the memory range<br>
&gt; &gt; &gt; in a given shared memory region (again, identified<br>
&gt; &gt; &gt; by its `shmid`), to free it. After this, the<br>
&gt; &gt; &gt; region becomes private and shall not be accessed<br>
&gt; &gt; &gt; by the frontend anymore.<br>
&gt; &gt;<br>
&gt; &gt; What does &quot;private&quot; mean?<br>
&gt; &gt;<br>
&gt; &gt; The frontend must mmap PROT_NONE to reserve the virtual memory sp=
ace<br>
&gt; &gt; when no fd is mapped in the VIRTIO Shared Memory Region. Otherwis=
e an<br>
&gt; &gt; unrelated mmap(NULL, ...) might use that address range and the gu=
est<br>
&gt; &gt; would have access to the host memory! This is a security issue an=
d needs<br>
&gt; &gt; to be mentioned explicitly in the spec.<br>
&gt; &gt;<br>
&gt; <br>
&gt; I mentioned private because it changes the mapping from MAP_SHARED<br>
&gt; to MAP_PRIVATE. I will highlight PROT_NONE instead.<br>
<br>
I see. Then &quot;MAP_PRIVATE&quot; would be clearer. I wasn&#39;t sure whe=
ther you<br>
mean mmap flags or something like the memory range is no longer<br>
accessible to the driver.<br>
<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Initializing the memory region is reponsiblity<br>
&gt; &gt; &gt; of the PCI device that will using it.<br>
&gt; &gt;<br>
&gt; &gt; What does this mean?<br>
&gt; &gt;<br>
&gt; <br>
&gt; The MemoryRegion is declared in `struct VirtIODevice`,<br>
&gt; but it is uninitialized in this commit. So I was trying to say<br>
&gt; that the initialization will happen in, e.g., vhost-user-gpu-pci.c<br>
&gt; with something like `memory_region_init` , and later `pci_register_bar=
`.<br>
<br>
Okay. The device model needs to create MemoryRegion instances for the<br>
device&#39;s Shared Memory Regions and add them to the VirtIODevice.<br>
<br>
--device vhost-user-device will need to query the backend since, unlike<br>
vhost-user-gpu-pci and friends, it doesn&#39;t have knowledge of specific<b=
r>
device types. It will need to create MemoryRegions enumerated from the<br>
backend.<br>
<br>
By the way, the VIRTIO MMIO Transport also supports VIRTIO Shared Memory<br=
>
Regions so this work should not be tied to PCI.<br>
<br>
&gt; <br>
&gt; I am testing that part still.<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@r=
edhat.com" target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 docs/interop/vhost-user.rst |=C2=A0 23 ++++++++<br>
&gt; &gt; &gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 | 106 +++++=
+++++++++++++++++++++++++++++++<br>
&gt; &gt; &gt;=C2=A0 hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +<br>
&gt; &gt; &gt;=C2=A0 include/hw/virtio/virtio.h=C2=A0 |=C2=A0 =C2=A03 +<br>
&gt; &gt; &gt;=C2=A0 4 files changed, 134 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; Two missing pieces:<br>
&gt; &gt;<br>
&gt; &gt; 1. QEMU&#39;s --device vhost-user-device needs a way to enumerate=
 VIRTIO<br>
&gt; &gt; Shared Memory Regions from the vhost-user backend. vhost-user-dev=
ice is<br>
&gt; &gt; a generic vhost-user frontend without knowledge of the device typ=
e, so<br>
&gt; &gt; it doesn&#39;t know what the valid shmids are and what size the r=
egions<br>
&gt; &gt; have.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Ok. I was assuming that if a device (backend) makes a request without =
a<br>
&gt; valid shmid or not enough size in the region to perform the mmap, woul=
d<br>
&gt; just fail in the VMM performing the actual mmap operation. So it would=
<br>
&gt; not necessarily need to know about valid shmids or region sizes.<br>
<br>
But then --device vhost-user-device wouldn&#39;t be able to support VIRTIO<=
br>
Shared Memory Regions, which means this patch series is incomplete. New<br>
vhost-user features need to support both --device vhost-user-&lt;type&gt;-*=
<br>
and --device vhost-user-device.<br>
<br>
What&#39;s needed is:<br>
1. New vhost-user messages so the frontend can query the shmids and<br>
=C2=A0 =C2=A0sizes from the backend.<br>
2. QEMU --device vhost-user-device code that queries the VIRTIO Shared<br>
=C2=A0 =C2=A0Memory Regions from the vhost-user backend and then creates<br=
>
=C2=A0 =C2=A0MemoryRegions for them.<br>
<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; 2. Other backends don&#39;t see these mappings. If the guest subm=
its a vring<br>
&gt; &gt; descriptor referencing a mapping to another backend, then that ba=
ckend<br>
&gt; &gt; won&#39;t be able to access this memory. David Gilbert hit this p=
roblem when<br>
&gt; &gt; working on the virtiofs DAX Window. Either the frontend needs to =
forward<br>
&gt; &gt; all SHMAP_MAP/UNMAP messages to the other backends (inefficient a=
nd<br>
&gt; &gt; maybe racy!) or a new &quot;memcpy&quot; message is needed as a f=
allback for when<br>
&gt; &gt; vhost-user memory region translation fails.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Ok. In which scenario would another device want to access the same map=
ping?<br>
&gt; If it is for a shared VIRTIO object, the device that receives the dmab=
uf fd<br>
&gt; could<br>
&gt; just do a new mapping in its VIRTIO shared memory region.<br>
<br>
You can reproduce this with two virtiofs devices. Where device A has the<br=
>
DAX Window feature enabled. The test program mmaps the DAX file and then<br=
>
opens a new file on device B and performs an O_DIRECT write(2) syscall.<br>
<br>
I think that this issue must be address in this series since this issue<br>
is introduced by enabling VIRTIO Shared Memory Regions in vhost-user.<br>
<br>
A bit more detail:<br>
<br>
Device A has a VIRTIO Shared Memory Region. An application mmaps that<br>
memory (examples: guest userspace driver using Linux VFIO, a guest<br>
kernel driver that exposes the memory to userspace via mmap, or guest<br>
kernel DAX). The application passes that memory as an I/O buffer to<br>
device B (e.g. O_DIRECT disk I/O).<br>
<br>
The result is that device B&#39;s vhost-user backend receives a vring<br>
descriptor that points to a guest memory address in device A&#39;s VIRTIO<b=
r>
Shared Memory Region. Since device B does not have this memory in its<br>
table, it cannot translate the address and the device breaks.<br>
<br></blockquote><div><br></div><div>I am working on the next version, and =
I am struggling on what to do</div><div>to solve this situation.<br></div><=
div>So IIUC is the device B (in your example) who will notice that it canno=
t</div><div>translate, and then, the backend will send a message (let&#39;s=
 say,</div><div>SHMEM_COPY) to the frontend so that it copies all mappings<=
/div><div>done on device A to=C2=A0device B. Something like that?</div><div=
>Maybe better only for the mapping that triggered the</div><div>message?</d=
iv><div><br></div><div>But the message would have to point to the device A =
so that</div><div>the frontend knows the src and dest to perform the memcpy=
?</div><div>And indicate the memory range that we want to map (offset=C2=A0=
+ len).</div><div>I am not sure how the frontend would know that it needs t=
o copy</div><div>from device A to device B after receiving the new message,=
</div><div>and get a pointer of both devices (device B is easy as it is</di=
v><div>the one that sent the message, but not device A).</div><div>Or maybe=
 I misunderstood your suggested solution.</div><div><br></div><div>BR,</div=
><div>Albert.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhos=
t-user.rst<br>
&gt; &gt; &gt; index d8419fd2f1..3caf2a290c 100644<br>
&gt; &gt; &gt; --- a/docs/interop/vhost-user.rst<br>
&gt; &gt; &gt; +++ b/docs/interop/vhost-user.rst<br>
&gt; &gt; &gt; @@ -1859,6 +1859,29 @@ is sent by the front-end.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 when the operation is successful, or non-zero o=
therwise. Note that if<br>
&gt; &gt; the<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 operation fails, no fd is sent to the backend.<=
br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +``VHOST_USER_BACKEND_SHMEM_MAP``<br>
&gt; &gt; &gt; +=C2=A0 :id: 9<br>
&gt; &gt; &gt; +=C2=A0 :equivalent ioctl: N/A<br>
&gt; &gt; &gt; +=C2=A0 :request payload: fd and ``struct VhostUserMMap``<br=
>
&gt; &gt; &gt; +=C2=A0 :reply payload: N/A<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 This message can be submitted by the backends to adv=
ertise a new<br>
&gt; &gt; mapping<br>
&gt; &gt; &gt; +=C2=A0 to be made in a given shared memory region. Upon rec=
eiving the<br>
&gt; &gt; message,<br>
&gt; &gt; &gt; +=C2=A0 QEMU will mmap the given fd into the shared memory r=
egion with the<br>
&gt; &gt;<br>
&gt; &gt; s/QEMU/the frontend/<br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 requested ``shmid``. A reply is generated indicating=
 whether mapping<br>
&gt; &gt; &gt; +=C2=A0 succeeded.<br>
&gt; &gt;<br>
&gt; &gt; Please document whether mapping over an existing mapping is allow=
ed. I<br>
&gt; &gt; think it should be allowed because it might be useful to atomical=
ly<br>
&gt; &gt; update a mapping without a race where the driver sees unmapped me=
mory.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; So in my understanding, the frontend (driver) in the guest would initi=
ate<br>
&gt; the<br>
&gt; mmap/munmap by sending request to the backend (vhost-user device).<br>
&gt; Then the vhost-user device sends a request to the VMM to perform the<b=
r>
&gt; mapping. We could enforce an ACK to ensure that the mmap operation fin=
ished<br>
&gt; before the vhost-user device responds to the driver, and thus avoid<br=
>
&gt; races. This way, we support only the simple usecase of not allowing<br=
>
&gt; mmaps over an already mapped region.<br>
<br>
I think it&#39;s fine to start with the stricter model where no overlapping=
<br>
mappings are allowed. If someone needs overlapping mappings in the<br>
future, a feature bit could be added to negotiate support.<br>
<br>
Please document that overlapping mappings are not supported.<br>
<br>
&gt; &gt; If mapping over an existing mapping is allowed, does the new mapp=
ing<br>
&gt; &gt; need to cover the old mapping exactly, or can it span multiple pr=
evious<br>
&gt; &gt; mappings or a subset of an existing mapping?<br>
&gt; &gt;<br>
&gt; &gt; From a security point of view we need to be careful here. A poten=
tially<br>
&gt; &gt; untrusted backend process now has the ability to mmap an arbitrar=
y file<br>
&gt; &gt; descriptor into the frontend process. The backend can cause<br>
&gt; &gt; denial of service by creating many small mappings to exhaust the =
OS<br>
&gt; &gt; limits on virtual memory areas. The backend can map memory to use=
 as<br>
&gt; &gt; part of a security compromise, so we need to be sure the virtual =
memory<br>
&gt; &gt; addresses are not leaked to the backend and only read/write page<=
br>
&gt; &gt; permissions are available.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Right, security from untrusted backends is usally the hardest part to =
me.<br>
&gt; But vhost-user devices do only see shm_offset, so this should be safe,=
 no?<br>
<br>
Yes, I think the current interface is safe, too.<br>
<br>
&gt; &gt;<br>
&gt; &gt; &gt; +``VHOST_USER_BACKEND_SHMEM_UNMAP``<br>
&gt; &gt; &gt; +=C2=A0 :id: 10<br>
&gt; &gt; &gt; +=C2=A0 :equivalent ioctl: N/A<br>
&gt; &gt; &gt; +=C2=A0 :request payload: ``struct VhostUserMMap``<br>
&gt; &gt; &gt; +=C2=A0 :reply payload: N/A<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 This message can be submitted by the backends so tha=
t QEMU un-mmap<br>
&gt; &gt;<br>
&gt; &gt; s/QEMU/the frontend/<br>
&gt; &gt;<br>
&gt; <br>
&gt; This is probably my bad, but I really thought the frontend is the driv=
er.<br>
&gt; So frontend/backend as alternative terms for vhost-user driver/device.=
<br>
<br>
&quot;vhost-user driver&quot; is not a term that&#39;s used, as far as I kn=
ow. The<br>
vhost-user spec calls it the front-end (older code and docs may call it<br>
the vhost-user master).<br>
<br>
&gt; And then here we would keep QEMU or use VMM instead?<br>
<br>
The vhost-user spec uses both front-end and QEMU to mean the same thing.<br=
>
VMM is not used in the vhost-user spec. I suggest using front-end in new<br=
>
spec text because QEMU is not the only application that implements this<br>
spec anymore.<br>
<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 a given range (``offset``, ``len``) in the shared me=
mory region with<br>
&gt; &gt; the<br>
&gt; &gt; &gt; +=C2=A0 requested ``shmid``.<br>
&gt; &gt;<br>
&gt; &gt; Does the range need to correspond to a previously-mapped VhostUse=
rMMap<br>
&gt; &gt; or can it cross multiple VhostUserMMaps, be a subset of a VhostUs=
erMMap,<br>
&gt; &gt; etc?<br>
&gt; &gt;<br>
&gt; <br>
&gt; I would prefer to keep it simple and disallow mapping over a<br>
&gt; previously-mapped<br>
&gt; region. The range need to correspond to a valid (within size bound), f=
ree,<br>
&gt; memory region, or else the request will fail. I will add that to the t=
ext.<br>
&gt; <br>
&gt; Nonetheless, I am open to discuss other options.<br>
<br>
That sounds good. I&#39;m not aware of any use cases that require anything =
fancy.<br>
<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 A reply is generated indicating whether unmapping su=
cceeded.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 .. _reply_ack:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 VHOST_USER_PROTOCOL_F_REPLY_ACK<br>
&gt; &gt; &gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c=
<br>
&gt; &gt; &gt; index cdf9af4a4b..9526b9d07f 100644<br>
&gt; &gt; &gt; --- a/hw/virtio/vhost-user.c<br>
&gt; &gt; &gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; &gt; &gt; @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {<b=
r>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D=
 6,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =
=3D 7,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =
=3D 8,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHMEM_MAP =3D 9,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_MAX<br>
&gt; &gt; &gt;=C2=A0 }=C2=A0 VhostUserBackendRequest;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -192,6 +194,23 @@ typedef struct VhostUserShared {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 unsigned char uuid[16];<br>
&gt; &gt; &gt;=C2=A0 } VhostUserShared;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +/* For the flags field of VhostUserMMap */<br>
&gt; &gt; &gt; +#define VHOST_USER_FLAG_MAP_R (1u &lt;&lt; 0)<br>
&gt; &gt; &gt; +#define VHOST_USER_FLAG_MAP_W (1u &lt;&lt; 1)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +typedef struct {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* Shared memory region ID */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t shmid;<br>
&gt; &gt;<br>
&gt; &gt; There is a hole (padding) in the struct since the following field=
s are<br>
&gt; &gt; naturally aligned to 8 bytes. I suggest moving shmid to the end t=
o<br>
&gt; &gt; reduce the chance of information leaks if padding is not zeroed.<=
br>
&gt; &gt;<br>
&gt; <br>
&gt; I see. I can move it to the end of the struct or add a padding field i=
n<br>
&gt; between. I&#39;ll do what you suggested, as it sound like the simplest=
 solution.<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* File offset */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t fd_offset;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* Offset within the shared memory region */<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t shm_offset;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* Size of region to map */<br>
&gt; &gt;<br>
&gt; &gt; To avoid giving &quot;region&quot; additional meanings:<br>
&gt; &gt;<br>
&gt; &gt; s/Size of the region to map/Size of the mapping/<br>
&gt; &gt;<br>
&gt; <br>
&gt; Ok, I will change it in the next drop. Probably will keep the RFC for<=
br>
&gt; at least one more patch, seeing that there are a few things I wasn&#39=
;t<br>
&gt; correctly considering.<br>
&gt; <br>
&gt; Thanks for all the feedback!<br>
<br>
Great, thanks!<br>
<br>
Stefan<br>
<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t len;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* Flags for the mmap operation, from VHOST_U=
SER_FLAG_* */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t flags;<br>
&gt; &gt; &gt; +} VhostUserMMap;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 typedef struct {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 VhostUserRequest request;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -224,6 +243,7 @@ typedef union {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserInflight inflight=
;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object;<br=
>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserTransferDeviceSta=
te transfer_state;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMMap mmap;<br>
&gt; &gt; &gt;=C2=A0 } VhostUserPayload;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 typedef struct VhostUserMsg {<br>
&gt; &gt; &gt; @@ -1748,6 +1768,85 @@<br>
&gt; &gt; vhost_user_backend_handle_shared_object_lookup(struct vhost_user =
*u,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +static int<br>
&gt; &gt; &gt; +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMMap *=
vu_mmap,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 void *addr =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MemoryRegion *mr =3D NULL;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (fd &lt; 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Bad fd for m=
ap&quot;);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBADF;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (!dev-&gt;vdev-&gt;shmem_list ||<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;vdev-&gt;n_shmem_region=
s &lt;=3D vu_mmap-&gt;shmid) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Shared memor=
y region at &quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;ID %d unitialized&quot;, vu_mmap-&gt;shmid);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 mr =3D &amp;dev-&gt;vdev-&gt;shmem_list[vu_mm=
ap-&gt;shmid];<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if ((vu_mmap-&gt;shm_offset + vu_mmap-&gt;len=
) &lt; vu_mmap-&gt;len ||<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (vu_mmap-&gt;shm_offset + vu_mm=
ap-&gt;len) &gt; mr-&gt;size) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Bad offset/l=
en for mmap %&quot; PRIx64 &quot;+%&quot; PRIx64,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0vu_mmap-&gt;shm_offset, vu_mmap-&gt;len);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 void *shmem_ptr =3D memory_region_get_ram_ptr=
(mr);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 addr =3D mmap(shmem_ptr + vu_mmap-&gt;shm_off=
set, vu_mmap-&gt;len,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((vu_mmap-&gt;flags &amp; VHOST=
_USER_FLAG_MAP_R) ? PROT_READ : 0) |<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((vu_mmap-&gt;flags &amp; VHOST=
_USER_FLAG_MAP_W) ? PROT_WRITE : 0),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MAP_SHARED | MAP_FIXED, fd, vu_=
mmap-&gt;fd_offset);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (addr =3D=3D MAP_FAILED) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to mm=
ap mem fd&quot;);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static int<br>
&gt; &gt; &gt; +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev=
,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUse=
rMMap *vu_mmap)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 void *addr =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MemoryRegion *mr =3D NULL;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (!dev-&gt;vdev-&gt;shmem_list ||<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;vdev-&gt;n_shmem_region=
s &lt;=3D vu_mmap-&gt;shmid) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Shared memor=
y region at &quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;ID %d unitialized&quot;, vu_mmap-&gt;shmid);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 mr =3D &amp;dev-&gt;vdev-&gt;shmem_list[vu_mm=
ap-&gt;shmid];<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if ((vu_mmap-&gt;shm_offset + vu_mmap-&gt;len=
) &lt; vu_mmap-&gt;len ||<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (vu_mmap-&gt;shm_offset + vu_mm=
ap-&gt;len) &gt; mr-&gt;size) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Bad offset/l=
en for mmap %&quot; PRIx64 &quot;+%&quot; PRIx64,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0vu_mmap-&gt;shm_offset, vu_mmap-&gt;len);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 void *shmem_ptr =3D memory_region_get_ram_ptr=
(mr);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 addr =3D mmap(shmem_ptr + vu_mmap-&gt;shm_off=
set, vu_mmap-&gt;len,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PRO=
T_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1,<br>
&gt; &gt; 0);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (addr =3D=3D MAP_FAILED) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to un=
map memory&quot;);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 static void close_backend_channel(struct vhost_user *u=
)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_source_destroy(u-&gt;backend_src);<br>
&gt; &gt; &gt; @@ -1816,6 +1915,13 @@ static gboolean backend_read(QIOChann=
el *ioc,<br>
&gt; &gt; GIOCondition condition,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D<br>
&gt; &gt; vhost_user_backend_handle_shared_object_lookup(dev-&gt;opaque, io=
c,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;hdr,<br>
&gt; &gt; &amp;payload);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHMEM_MAP:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_hand=
le_shmem_map(dev, &amp;payload.mmap,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd ? fd[0] : -1);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHMEM_UNMAP:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_hand=
le_shmem_unmap(dev, &amp;payload.mmap);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Receive=
d unexpected msg type: %d.&quot;, hdr.request);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>
&gt; &gt; &gt; diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
&gt; &gt; &gt; index 893a072c9d..59596370ec 100644<br>
&gt; &gt; &gt; --- a/hw/virtio/virtio.c<br>
&gt; &gt; &gt; +++ b/hw/virtio/virtio.c<br>
&gt; &gt; &gt; @@ -3264,6 +3264,8 @@ void virtio_init(VirtIODevice *vdev, u=
int16_t<br>
&gt; &gt; device_id, size_t config_size)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_vmsta=
te_change, vdev);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 vdev-&gt;device_endian =3D virtio_defaul=
t_endian();<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 vdev-&gt;use_guest_notifier_mask =3D tru=
e;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 vdev-&gt;shmem_list =3D NULL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 vdev-&gt;n_shmem_regions =3D 0;<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 /*<br>
&gt; &gt; &gt; diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/=
virtio.h<br>
&gt; &gt; &gt; index 7d5ffdc145..34bec26593 100644<br>
&gt; &gt; &gt; --- a/include/hw/virtio/virtio.h<br>
&gt; &gt; &gt; +++ b/include/hw/virtio/virtio.h<br>
&gt; &gt; &gt; @@ -165,6 +165,9 @@ struct VirtIODevice<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 EventNotifier config_notifier;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool device_iotlb_enabled;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* Shared memory region for vhost-user mappin=
gs. */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MemoryRegion *shmem_list;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 int n_shmem_regions;<br>
&gt; &gt; &gt;=C2=A0 };<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 struct VirtioDeviceClass {<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.44.0<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
</blockquote></div></div>

--0000000000000eaf8f061bc65072--


