Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC81C3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 13:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMSkE-00015G-TW; Wed, 26 Jun 2024 09:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sMSkC-00014Z-M4
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 09:31:29 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sMSk8-0003Zf-GP
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 09:31:28 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5bfa5f9bbe6so3229894eaf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719408683; x=1720013483; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwE+45zhUBVf2wHZnOOiDkArz0TSs3ZysE82E4DjbNw=;
 b=XPy4u4eHOttSu5AIIJ/9I8bfOMfCZ6qhGjCx1IJR2PRkILCLqjrMWMYbaTYNG4F6tM
 /PY/a946faYnq0S3568BOVaqpi0ZdVfi8IziCFIBJsXxsxH53UnZya2f71LmlRsAeHpi
 FTwJ5yxSPSv4DesiiFr7GBmkzbcL05j0XFe8jbEkCgxjcwYzbENFl78vaOoKqSc5eBUa
 /dkWlLSbwhk5Tw3yVEPBDrpNGlim6rFLQqMF/MSxl4tkZ/YW16XXEkT85/vN9AzL26b5
 UWfnKXHrapOytbFC3bvmOAoX9nu5OGwgMieBDiCG40Gab1nag77sSscRESds9ULIGpEy
 lrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719408683; x=1720013483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwE+45zhUBVf2wHZnOOiDkArz0TSs3ZysE82E4DjbNw=;
 b=TYGMmEt9A9s4g2/8niwmFevhNyz63q3FuuK4kiy4c9RFLg/l/R6Tgvk8tr1iYaDOem
 3PLFySiTUbz/2hs0f3AIts9kgB9/ie6tz8+qfcitfPmcviwTJ6azgQC7NyK8s5PwhiaK
 lDEF947OyrjjHEoSLx/mfafUXWu+UGSRe3dlunjJ5DM7Vka53GpGHNFs8UNVQdRW/f66
 RUmT28BLWz7zi3WVipBzppcXRp8HL0vIA0M7e5RjyBZBenqi7Kt41QTzY45YnMDoZkuD
 2hd8BtP2mUSg7EU+ZrnXK3o5lozD0N04lf7j52dHSVADEYWXgNV1xZfI8WcorVyaYA/c
 UI0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0U8fWtdZ5Eek6Yzx9W96h8822f6kCDXCDVzYZ0WvivQeG315fx9nD839EXnPeila89vChuaexl2yNbiuYtP0ryNpPl3A=
X-Gm-Message-State: AOJu0YzhAEoeXbhXqovLn2PJfiA9csnaPVIEYxCj2gD+B8QzEQ1AA+I1
 VmsjLRhmRy3O73L4ruDOHdspZAXIaQVjkSIjZE9rq5IkuolPUkKYjGqD528TgWx84E3vx31QsAE
 1UvF9pm8ekofuzcBLJG1L5VgtQO0=
X-Google-Smtp-Source: AGHT+IGwSxGRNh/az/N1v89iEh5Z/8dymx2LbWY/caoAjA3PUrNA800awkS5y1dgylAYxGYePwE+E0YskUoV+5scSGY=
X-Received: by 2002:a4a:2451:0:b0:5bb:2d23:8aeb with SMTP id
 006d021491bc7-5c1eb9ddd8bmr11363691eaf.2.1719408682532; Wed, 26 Jun 2024
 06:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240530152223.780232-1-aesteve@redhat.com>
 <20240530152223.780232-2-aesteve@redhat.com>
 <20240604185416.GB90471@fedora.redhat.com>
 <CADSE00+yvsOhiJJg0ePgr7AYVCkjm9xWNj7KpAOFMwj2wuEpGg@mail.gmail.com>
 <20240605142849.GC135899@fedora.redhat.com>
 <CADSE00+WtK8t5jxNxjthupEuovs5+eNJWshzjxWzYaTnZSL=uw@mail.gmail.com>
In-Reply-To: <CADSE00+WtK8t5jxNxjthupEuovs5+eNJWshzjxWzYaTnZSL=uw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 26 Jun 2024 09:31:10 -0400
Message-ID: <CAJSP0QVpGQr1z1py66kbtVHhACPqrHZywWeqTK8nEGic-=HMDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] vhost-user: add shmem mmap request
To: Albert Esteve <aesteve@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 mst@redhat.com, slp@redhat.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2d.google.com
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

On Wed, 26 Jun 2024 at 03:54, Albert Esteve <aesteve@redhat.com> wrote:
>
> Hi Stefan,
>
> On Wed, Jun 5, 2024 at 4:28=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>>
>> On Wed, Jun 05, 2024 at 10:13:32AM +0200, Albert Esteve wrote:
>> > On Tue, Jun 4, 2024 at 8:54=E2=80=AFPM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
>> >
>> > > On Thu, May 30, 2024 at 05:22:23PM +0200, Albert Esteve wrote:
>> > > > Add SHMEM_MAP/UNMAP requests to vhost-user.
>> > > >
>> > > > This request allows backends to dynamically map
>> > > > fds into a shared memory region indentified by
>> > >
>> > > Please call this "VIRTIO Shared Memory Region" everywhere (code,
>> > > vhost-user spec, commit description, etc) so it's clear that this is=
 not
>> > > about vhost-user shared memory tables/regions.
>> > >
>> > > > its `shmid`. Then, the fd memory is advertised
>> > > > to the frontend through a BAR+offset, so it can
>> > > > be read by the driver while its valid.
>> > >
>> > > Why is a PCI BAR mentioned here? vhost-user does not know about the
>> > > VIRTIO Transport (e.g. PCI) being used. It's the frontend's job to
>> > > report VIRTIO Shared Memory Regions to the driver.
>> > >
>> > >
>> > I will remove PCI BAR, as it is true that it depends on the
>> > transport. I was trying to explain that the driver
>> > will use the shm_base + shm_offset to access
>> > the mapped memory.
>> >
>> >
>> > > >
>> > > > Then, the backend can munmap the memory range
>> > > > in a given shared memory region (again, identified
>> > > > by its `shmid`), to free it. After this, the
>> > > > region becomes private and shall not be accessed
>> > > > by the frontend anymore.
>> > >
>> > > What does "private" mean?
>> > >
>> > > The frontend must mmap PROT_NONE to reserve the virtual memory space
>> > > when no fd is mapped in the VIRTIO Shared Memory Region. Otherwise a=
n
>> > > unrelated mmap(NULL, ...) might use that address range and the guest
>> > > would have access to the host memory! This is a security issue and n=
eeds
>> > > to be mentioned explicitly in the spec.
>> > >
>> >
>> > I mentioned private because it changes the mapping from MAP_SHARED
>> > to MAP_PRIVATE. I will highlight PROT_NONE instead.
>>
>> I see. Then "MAP_PRIVATE" would be clearer. I wasn't sure whether you
>> mean mmap flags or something like the memory range is no longer
>> accessible to the driver.
>>
>> >
>> >
>> > >
>> > > >
>> > > > Initializing the memory region is reponsiblity
>> > > > of the PCI device that will using it.
>> > >
>> > > What does this mean?
>> > >
>> >
>> > The MemoryRegion is declared in `struct VirtIODevice`,
>> > but it is uninitialized in this commit. So I was trying to say
>> > that the initialization will happen in, e.g., vhost-user-gpu-pci.c
>> > with something like `memory_region_init` , and later `pci_register_bar=
`.
>>
>> Okay. The device model needs to create MemoryRegion instances for the
>> device's Shared Memory Regions and add them to the VirtIODevice.
>>
>> --device vhost-user-device will need to query the backend since, unlike
>> vhost-user-gpu-pci and friends, it doesn't have knowledge of specific
>> device types. It will need to create MemoryRegions enumerated from the
>> backend.
>>
>> By the way, the VIRTIO MMIO Transport also supports VIRTIO Shared Memory
>> Regions so this work should not be tied to PCI.
>>
>> >
>> > I am testing that part still.
>> >
>> >
>> > >
>> > > >
>> > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>> > > > ---
>> > > >  docs/interop/vhost-user.rst |  23 ++++++++
>> > > >  hw/virtio/vhost-user.c      | 106 +++++++++++++++++++++++++++++++=
+++++
>> > > >  hw/virtio/virtio.c          |   2 +
>> > > >  include/hw/virtio/virtio.h  |   3 +
>> > > >  4 files changed, 134 insertions(+)
>> > >
>> > > Two missing pieces:
>> > >
>> > > 1. QEMU's --device vhost-user-device needs a way to enumerate VIRTIO
>> > > Shared Memory Regions from the vhost-user backend. vhost-user-device=
 is
>> > > a generic vhost-user frontend without knowledge of the device type, =
so
>> > > it doesn't know what the valid shmids are and what size the regions
>> > > have.
>> > >
>> >
>> > Ok. I was assuming that if a device (backend) makes a request without =
a
>> > valid shmid or not enough size in the region to perform the mmap, woul=
d
>> > just fail in the VMM performing the actual mmap operation. So it would
>> > not necessarily need to know about valid shmids or region sizes.
>>
>> But then --device vhost-user-device wouldn't be able to support VIRTIO
>> Shared Memory Regions, which means this patch series is incomplete. New
>> vhost-user features need to support both --device vhost-user-<type>-*
>> and --device vhost-user-device.
>>
>> What's needed is:
>> 1. New vhost-user messages so the frontend can query the shmids and
>>    sizes from the backend.
>> 2. QEMU --device vhost-user-device code that queries the VIRTIO Shared
>>    Memory Regions from the vhost-user backend and then creates
>>    MemoryRegions for them.
>>
>> >
>> >
>> > >
>> > > 2. Other backends don't see these mappings. If the guest submits a v=
ring
>> > > descriptor referencing a mapping to another backend, then that backe=
nd
>> > > won't be able to access this memory. David Gilbert hit this problem =
when
>> > > working on the virtiofs DAX Window. Either the frontend needs to for=
ward
>> > > all SHMAP_MAP/UNMAP messages to the other backends (inefficient and
>> > > maybe racy!) or a new "memcpy" message is needed as a fallback for w=
hen
>> > > vhost-user memory region translation fails.
>> > >
>> >
>> > Ok. In which scenario would another device want to access the same map=
ping?
>> > If it is for a shared VIRTIO object, the device that receives the dmab=
uf fd
>> > could
>> > just do a new mapping in its VIRTIO shared memory region.
>>
>> You can reproduce this with two virtiofs devices. Where device A has the
>> DAX Window feature enabled. The test program mmaps the DAX file and then
>> opens a new file on device B and performs an O_DIRECT write(2) syscall.
>>
>> I think that this issue must be address in this series since this issue
>> is introduced by enabling VIRTIO Shared Memory Regions in vhost-user.
>>
>> A bit more detail:
>>
>> Device A has a VIRTIO Shared Memory Region. An application mmaps that
>> memory (examples: guest userspace driver using Linux VFIO, a guest
>> kernel driver that exposes the memory to userspace via mmap, or guest
>> kernel DAX). The application passes that memory as an I/O buffer to
>> device B (e.g. O_DIRECT disk I/O).
>>
>> The result is that device B's vhost-user backend receives a vring
>> descriptor that points to a guest memory address in device A's VIRTIO
>> Shared Memory Region. Since device B does not have this memory in its
>> table, it cannot translate the address and the device breaks.
>>
>
> I am working on the next version, and I am struggling on what to do
> to solve this situation.
> So IIUC is the device B (in your example) who will notice that it cannot
> translate, and then, the backend will send a message (let's say,
> SHMEM_COPY) to the frontend so that it copies all mappings
> done on device A to device B. Something like that?
> Maybe better only for the mapping that triggered the
> message?
>
> But the message would have to point to the device A so that
> the frontend knows the src and dest to perform the memcpy?
> And indicate the memory range that we want to map (offset + len).
> I am not sure how the frontend would know that it needs to copy
> from device A to device B after receiving the new message,
> and get a pointer of both devices (device B is easy as it is
> the one that sent the message, but not device A).
> Or maybe I misunderstood your suggested solution.

I can see two types of solutions:

1. Propagating mmaps to devices, either eagerly or lazily. It sounds
like your thinking about that when you say "copies all mappings done
on device A to device B".
2. A memcpy command where the frontend reads from the guest memory
space or writes to the guest memory space. Here the mmaps are never
transmitted to vhost-user device backends.

My preference is for #2 because the vhost-user protocol is simple. #1
is complex when done lazily and basically on par with the complexity
of an IOMMU interface.

The following shows the new vhost-user protocol commands:

Back-end message types
...
VHOST_USER_BACKEND_MEM_READ
Parameters:
- u64 guest address
- u32 size

The frontend replies with a buffer containing @size bytes at @guest_address=
.

VHOST_USER_BACKEND_MEM_WRITE
Parameters:
- u64 guest address
- u32 size
- u8 data[]

The frontend writes @size bytes from @data[] to guest memory at @guest_addr=
ess.

The backend virtqueue code must be extended to handle guest address
translation failures by sending
VHOST_USER_BACKEND_MEM_READ/VHOST_USER_BACKEND_MEM_WRITE messages to
the frontend. This is invasive because any guest memory access could
fail, including vring fields as well as virtqueue element in/out data
buffers. It involves introducing bounce buffering when the backend
falls back to using these new protocol messages.

An even simpler alternative is an eager implementation of #1, where
the frontend sends mmaps to all other device backends so that they
always have a complete mem table. In this case no changes are needed
to the backend virtqueue code, but performance suffers when devices
send shmem map/unmap requests at runtime rather than only during
startup. An example of a device like this is virtiofs (the DAX Window
feature).

David Gilbert was implementing something like #2 but with protocol
messages that carry an fd so that the frontend performs a read(2) or
write(2) instead of transferring the contents of the data buffer. It's
kind of a zero-copy optimization but only works when the backend wants
to do read(2) or write(2), so it's less generic than memory read and
write protocol messages.

Finally, one thing I like about #2 is that it introduces an option for
doing vhost-user without shared memory altogether! A backend could
rely solely on the memory read and write messages. That can be useful
for portability and security, although it's bad for performance.

Stefan

>
> BR,
> Albert.
>
>>
>> >
>> >
>> > >
>> > > >
>> > > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user=
.rst
>> > > > index d8419fd2f1..3caf2a290c 100644
>> > > > --- a/docs/interop/vhost-user.rst
>> > > > +++ b/docs/interop/vhost-user.rst
>> > > > @@ -1859,6 +1859,29 @@ is sent by the front-end.
>> > > >    when the operation is successful, or non-zero otherwise. Note t=
hat if
>> > > the
>> > > >    operation fails, no fd is sent to the backend.
>> > > >
>> > > > +``VHOST_USER_BACKEND_SHMEM_MAP``
>> > > > +  :id: 9
>> > > > +  :equivalent ioctl: N/A
>> > > > +  :request payload: fd and ``struct VhostUserMMap``
>> > > > +  :reply payload: N/A
>> > > > +
>> > > > +  This message can be submitted by the backends to advertise a ne=
w
>> > > mapping
>> > > > +  to be made in a given shared memory region. Upon receiving the
>> > > message,
>> > > > +  QEMU will mmap the given fd into the shared memory region with =
the
>> > >
>> > > s/QEMU/the frontend/
>> > >
>> > > > +  requested ``shmid``. A reply is generated indicating whether ma=
pping
>> > > > +  succeeded.
>> > >
>> > > Please document whether mapping over an existing mapping is allowed.=
 I
>> > > think it should be allowed because it might be useful to atomically
>> > > update a mapping without a race where the driver sees unmapped memor=
y.
>> > >
>> > >
>> > So in my understanding, the frontend (driver) in the guest would initi=
ate
>> > the
>> > mmap/munmap by sending request to the backend (vhost-user device).
>> > Then the vhost-user device sends a request to the VMM to perform the
>> > mapping. We could enforce an ACK to ensure that the mmap operation fin=
ished
>> > before the vhost-user device responds to the driver, and thus avoid
>> > races. This way, we support only the simple usecase of not allowing
>> > mmaps over an already mapped region.
>>
>> I think it's fine to start with the stricter model where no overlapping
>> mappings are allowed. If someone needs overlapping mappings in the
>> future, a feature bit could be added to negotiate support.
>>
>> Please document that overlapping mappings are not supported.
>>
>> > > If mapping over an existing mapping is allowed, does the new mapping
>> > > need to cover the old mapping exactly, or can it span multiple previ=
ous
>> > > mappings or a subset of an existing mapping?
>> > >
>> > > From a security point of view we need to be careful here. A potentia=
lly
>> > > untrusted backend process now has the ability to mmap an arbitrary f=
ile
>> > > descriptor into the frontend process. The backend can cause
>> > > denial of service by creating many small mappings to exhaust the OS
>> > > limits on virtual memory areas. The backend can map memory to use as
>> > > part of a security compromise, so we need to be sure the virtual mem=
ory
>> > > addresses are not leaked to the backend and only read/write page
>> > > permissions are available.
>> > >
>> >
>> > Right, security from untrusted backends is usally the hardest part to =
me.
>> > But vhost-user devices do only see shm_offset, so this should be safe,=
 no?
>>
>> Yes, I think the current interface is safe, too.
>>
>> > >
>> > > > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
>> > > > +  :id: 10
>> > > > +  :equivalent ioctl: N/A
>> > > > +  :request payload: ``struct VhostUserMMap``
>> > > > +  :reply payload: N/A
>> > > > +
>> > > > +  This message can be submitted by the backends so that QEMU un-m=
map
>> > >
>> > > s/QEMU/the frontend/
>> > >
>> >
>> > This is probably my bad, but I really thought the frontend is the driv=
er.
>> > So frontend/backend as alternative terms for vhost-user driver/device.
>>
>> "vhost-user driver" is not a term that's used, as far as I know. The
>> vhost-user spec calls it the front-end (older code and docs may call it
>> the vhost-user master).
>>
>> > And then here we would keep QEMU or use VMM instead?
>>
>> The vhost-user spec uses both front-end and QEMU to mean the same thing.
>> VMM is not used in the vhost-user spec. I suggest using front-end in new
>> spec text because QEMU is not the only application that implements this
>> spec anymore.
>>
>> >
>> >
>> > >
>> > > > +  a given range (``offset``, ``len``) in the shared memory region=
 with
>> > > the
>> > > > +  requested ``shmid``.
>> > >
>> > > Does the range need to correspond to a previously-mapped VhostUserMM=
ap
>> > > or can it cross multiple VhostUserMMaps, be a subset of a VhostUserM=
Map,
>> > > etc?
>> > >
>> >
>> > I would prefer to keep it simple and disallow mapping over a
>> > previously-mapped
>> > region. The range need to correspond to a valid (within size bound), f=
ree,
>> > memory region, or else the request will fail. I will add that to the t=
ext.
>> >
>> > Nonetheless, I am open to discuss other options.
>>
>> That sounds good. I'm not aware of any use cases that require anything f=
ancy.
>>
>> >
>> >
>> > >
>> > > > +  A reply is generated indicating whether unmapping succeeded.
>> > > > +
>> > > >  .. _reply_ack:
>> > > >
>> > > >  VHOST_USER_PROTOCOL_F_REPLY_ACK
>> > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> > > > index cdf9af4a4b..9526b9d07f 100644
>> > > > --- a/hw/virtio/vhost-user.c
>> > > > +++ b/hw/virtio/vhost-user.c
>> > > > @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
>> > > >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
>> > > >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
>> > > >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
>> > > > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
>> > > > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
>> > > >      VHOST_USER_BACKEND_MAX
>> > > >  }  VhostUserBackendRequest;
>> > > >
>> > > > @@ -192,6 +194,23 @@ typedef struct VhostUserShared {
>> > > >      unsigned char uuid[16];
>> > > >  } VhostUserShared;
>> > > >
>> > > > +/* For the flags field of VhostUserMMap */
>> > > > +#define VHOST_USER_FLAG_MAP_R (1u << 0)
>> > > > +#define VHOST_USER_FLAG_MAP_W (1u << 1)
>> > > > +
>> > > > +typedef struct {
>> > > > +    /* Shared memory region ID */
>> > > > +    uint8_t shmid;
>> > >
>> > > There is a hole (padding) in the struct since the following fields a=
re
>> > > naturally aligned to 8 bytes. I suggest moving shmid to the end to
>> > > reduce the chance of information leaks if padding is not zeroed.
>> > >
>> >
>> > I see. I can move it to the end of the struct or add a padding field i=
n
>> > between. I'll do what you suggested, as it sound like the simplest sol=
ution.
>> >
>> >
>> > >
>> > > > +    /* File offset */
>> > > > +    uint64_t fd_offset;
>> > > > +    /* Offset within the shared memory region */
>> > > > +    uint64_t shm_offset;
>> > > > +    /* Size of region to map */
>> > >
>> > > To avoid giving "region" additional meanings:
>> > >
>> > > s/Size of the region to map/Size of the mapping/
>> > >
>> >
>> > Ok, I will change it in the next drop. Probably will keep the RFC for
>> > at least one more patch, seeing that there are a few things I wasn't
>> > correctly considering.
>> >
>> > Thanks for all the feedback!
>>
>> Great, thanks!
>>
>> Stefan
>>
>> >
>> >
>> > >
>> > > > +    uint64_t len;
>> > > > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
>> > > > +    uint64_t flags;
>> > > > +} VhostUserMMap;
>> > > > +
>> > > >  typedef struct {
>> > > >      VhostUserRequest request;
>> > > >
>> > > > @@ -224,6 +243,7 @@ typedef union {
>> > > >          VhostUserInflight inflight;
>> > > >          VhostUserShared object;
>> > > >          VhostUserTransferDeviceState transfer_state;
>> > > > +        VhostUserMMap mmap;
>> > > >  } VhostUserPayload;
>> > > >
>> > > >  typedef struct VhostUserMsg {
>> > > > @@ -1748,6 +1768,85 @@
>> > > vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>> > > >      return 0;
>> > > >  }
>> > > >
>> > > > +static int
>> > > > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
>> > > > +                                  VhostUserMMap *vu_mmap,
>> > > > +                                  int fd)
>> > > > +{
>> > > > +    void *addr =3D 0;
>> > > > +    MemoryRegion *mr =3D NULL;
>> > > > +
>> > > > +    if (fd < 0) {
>> > > > +        error_report("Bad fd for map");
>> > > > +        return -EBADF;
>> > > > +    }
>> > > > +
>> > > > +    if (!dev->vdev->shmem_list ||
>> > > > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
>> > > > +        error_report("Shared memory region at "
>> > > > +                     "ID %d unitialized", vu_mmap->shmid);
>> > > > +        return -EFAULT;
>> > > > +    }
>> > > > +
>> > > > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
>> > > > +
>> > > > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
>> > > > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
>> > > > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx=
64,
>> > > > +                     vu_mmap->shm_offset, vu_mmap->len);
>> > > > +        return -EFAULT;
>> > > > +    }
>> > > > +
>> > > > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
>> > > > +
>> > > > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
>> > > > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0=
) |
>> > > > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_W) ? PROT_WRITE : =
0),
>> > > > +        MAP_SHARED | MAP_FIXED, fd, vu_mmap->fd_offset);
>> > > > +    if (addr =3D=3D MAP_FAILED) {
>> > > > +        error_report("Failed to mmap mem fd");
>> > > > +        return -EFAULT;
>> > > > +    }
>> > > > +
>> > > > +    return 0;
>> > > > +}
>> > > > +
>> > > > +static int
>> > > > +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
>> > > > +                                    VhostUserMMap *vu_mmap)
>> > > > +{
>> > > > +    void *addr =3D 0;
>> > > > +    MemoryRegion *mr =3D NULL;
>> > > > +
>> > > > +    if (!dev->vdev->shmem_list ||
>> > > > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
>> > > > +        error_report("Shared memory region at "
>> > > > +                     "ID %d unitialized", vu_mmap->shmid);
>> > > > +        return -EFAULT;
>> > > > +    }
>> > > > +
>> > > > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
>> > > > +
>> > > > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
>> > > > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
>> > > > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx=
64,
>> > > > +                     vu_mmap->shm_offset, vu_mmap->len);
>> > > > +        return -EFAULT;
>> > > > +    }
>> > > > +
>> > > > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
>> > > > +
>> > > > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
>> > > > +                PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXE=
D, -1,
>> > > 0);
>> > > > +
>> > > > +    if (addr =3D=3D MAP_FAILED) {
>> > > > +        error_report("Failed to unmap memory");
>> > > > +        return -EFAULT;
>> > > > +    }
>> > > > +
>> > > > +    return 0;
>> > > > +}
>> > > > +
>> > > >  static void close_backend_channel(struct vhost_user *u)
>> > > >  {
>> > > >      g_source_destroy(u->backend_src);
>> > > > @@ -1816,6 +1915,13 @@ static gboolean backend_read(QIOChannel *io=
c,
>> > > GIOCondition condition,
>> > > >          ret =3D
>> > > vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
>> > > >                                                               &hdr=
,
>> > > &payload);
>> > > >          break;
>> > > > +    case VHOST_USER_BACKEND_SHMEM_MAP:
>> > > > +        ret =3D vhost_user_backend_handle_shmem_map(dev, &payload=
.mmap,
>> > > > +                                                fd ? fd[0] : -1);
>> > > > +        break;
>> > > > +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
>> > > > +        ret =3D vhost_user_backend_handle_shmem_unmap(dev, &paylo=
ad.mmap);
>> > > > +        break;
>> > > >      default:
>> > > >          error_report("Received unexpected msg type: %d.", hdr.req=
uest);
>> > > >          ret =3D -EINVAL;
>> > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> > > > index 893a072c9d..59596370ec 100644
>> > > > --- a/hw/virtio/virtio.c
>> > > > +++ b/hw/virtio/virtio.c
>> > > > @@ -3264,6 +3264,8 @@ void virtio_init(VirtIODevice *vdev, uint16_=
t
>> > > device_id, size_t config_size)
>> > > >              virtio_vmstate_change, vdev);
>> > > >      vdev->device_endian =3D virtio_default_endian();
>> > > >      vdev->use_guest_notifier_mask =3D true;
>> > > > +    vdev->shmem_list =3D NULL;
>> > > > +    vdev->n_shmem_regions =3D 0;
>> > > >  }
>> > > >
>> > > >  /*
>> > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio=
.h
>> > > > index 7d5ffdc145..34bec26593 100644
>> > > > --- a/include/hw/virtio/virtio.h
>> > > > +++ b/include/hw/virtio/virtio.h
>> > > > @@ -165,6 +165,9 @@ struct VirtIODevice
>> > > >       */
>> > > >      EventNotifier config_notifier;
>> > > >      bool device_iotlb_enabled;
>> > > > +    /* Shared memory region for vhost-user mappings. */
>> > > > +    MemoryRegion *shmem_list;
>> > > > +    int n_shmem_regions;
>> > > >  };
>> > > >
>> > > >  struct VirtioDeviceClass {
>> > > > --
>> > > > 2.44.0
>> > > >
>> > >

