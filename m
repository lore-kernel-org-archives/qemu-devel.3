Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79867C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LRL-0002dv-SG; Tue, 07 May 2024 10:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4LRB-0002ar-59
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:05:00 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4LR4-0005n6-Pt
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:04:56 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-23f3d248fadso1356167fac.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715090686; x=1715695486;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sf7Gr4DoYhjoIrqPm4h0phpQ6PXN0R7Iwcsk3yo0VrY=;
 b=3OGVwDNlMbhoSAoDBw4JMM8hWwXPmwi09nj7nUZPQo185rOYONRwqitEbx1i+h7mdN
 ZDY5YYCSFEgT7x3KaNB3IwUSPMRzFZYtwOQPr6iD/nSdPPOD1Qmb+DOWca5a4K0fSkXO
 27pqWu0koXGtogWJK9DiMn3tSBAvk8heU1QPK6XCsq0ilo6Dq68C0BaSV8oMVu7bBKux
 MnNdOJNHSiU+fJOSdsB9FWdK/F7wztpX74AA+61Fihzhl70ngVmvQ0NpvIFw/XBM+wOT
 Nj716D50VJs65aWtH8BKPbMO8zEWXJXjZk3FzSsYwvebWJXJkgwF3xvxpDoKb+TDsL5Y
 nQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715090686; x=1715695486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sf7Gr4DoYhjoIrqPm4h0phpQ6PXN0R7Iwcsk3yo0VrY=;
 b=Zl+Tzglx6uVMqgOd9NrJgozn2D5fDjdcjBgYgIiC2BmsyMjIgZzTChAj1ncu/7iQv7
 GugUuTtfwaGrTJ9Czu/mFpADJmq6vWLXdR/aNV8oDgWAcOU88IjFlQhm2NxhOupqEEqt
 0+Uh9o5cuQRNjuKkpk10ZFmHXJtZd/JduCtInjDwjhTx8LsmQZj98drHtuuyWJm+LOJu
 sYGC7ItGZ4+r8JRtLH8dSw86Q5dTnPGDiQN2ILW6cwg8sgD4hv/vVQS3oX8AHvKaPpBr
 ks6NY4xMp1VwCHKhANkuAp/G4ttyQLazuYcq3o8YN4jr3o2SZAlllAIRK/msnmd7aogE
 vVJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXroivWDQpufImWsuksmx0XL2RBjn2epyf3efo4O+zrWzfauMKyLi1J/iMp2rmuh0Cq9f4Xa2lD7g99rznegrwL1wfw0AY=
X-Gm-Message-State: AOJu0YxNMKSd6ptLdc6QeBrg6+UeSV3VNz7VYYK4ypT7qZufc60BlQFK
 Z6FNnKa2596F7tMofphyzQm8GGYH8XzaI+NKh+2rnY/rP/aF2KjcCQelATjdYps1ZmPLlUS366J
 Fu5slM4hiScbhKIrLt8T53OqkJ85AYx85dMSS8g==
X-Google-Smtp-Source: AGHT+IG3g5NSBGQM3F8biG/k0OPCTFRdMF2lyeJysLVK9t1V9GjLaP7SGgBNtVLm0ZcKtds42rxG+lk2lrt9ZcUgXus=
X-Received: by 2002:a05:6871:288:b0:23e:5cd0:faaa with SMTP id
 i8-20020a056871028800b0023e5cd0faaamr13375130oae.55.1715090685813; Tue, 07
 May 2024 07:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240507094210.300566-1-mnissler@rivosinc.com>
 <20240507094210.300566-3-mnissler@rivosinc.com>
 <447ddc5a-ae1e-4fd1-b03a-dd7e1faa46e9@linaro.org>
In-Reply-To: <447ddc5a-ae1e-4fd1-b03a-dd7e1faa46e9@linaro.org>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Tue, 7 May 2024 16:04:33 +0200
Message-ID: <CAGNS4Tb1FVFmzVLvSZD84n0q80bwDiAMaSr752jb4nDwkGHSjA@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] softmmu: Support concurrent bounce buffers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, 
 jag.raman@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.levon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, May 7, 2024 at 2:57=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 7/5/24 11:42, Mattias Nissler wrote:
> > When DMA memory can't be directly accessed, as is the case when
> > running the device model in a separate process without shareable DMA
> > file descriptors, bounce buffering is used.
> >
> > It is not uncommon for device models to request mapping of several DMA
> > regions at the same time. Examples include:
> >   * net devices, e.g. when transmitting a packet that is split across
> >     several TX descriptors (observed with igb)
> >   * USB host controllers, when handling a packet with multiple data TRB=
s
> >     (observed with xhci)
> >
> > Previously, qemu only provided a single bounce buffer per AddressSpace
> > and would fail DMA map requests while the buffer was already in use. In
> > turn, this would cause DMA failures that ultimately manifest as hardwar=
e
> > errors from the guest perspective.
> >
> > This change allocates DMA bounce buffers dynamically instead of
> > supporting only a single buffer. Thus, multiple DMA mappings work
> > correctly also when RAM can't be mmap()-ed.
> >
> > The total bounce buffer allocation size is limited individually for eac=
h
> > AddressSpace. The default limit is 4096 bytes, matching the previous
> > maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > provided to configure the limit for PCI devices.
> >
> > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > ---
> >   hw/pci/pci.c                |  8 ++++
> >   include/exec/memory.h       | 14 +++----
> >   include/hw/pci/pci_device.h |  3 ++
> >   system/memory.c             |  5 ++-
> >   system/physmem.c            | 82 ++++++++++++++++++++++++++----------=
-
> >   5 files changed, 76 insertions(+), 36 deletions(-)
>
>
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index d417d7f363..2ea1e99da2 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -1117,13 +1117,7 @@ typedef struct AddressSpaceMapClient {
> >       QLIST_ENTRY(AddressSpaceMapClient) link;
> >   } AddressSpaceMapClient;
> >
> > -typedef struct {
> > -    MemoryRegion *mr;
> > -    void *buffer;
> > -    hwaddr addr;
> > -    hwaddr len;
> > -    bool in_use;
> > -} BounceBuffer;
> > +#define DEFAULT_MAX_BOUNCE_BUFFER_SIZE (4096)
> >
> >   /**
> >    * struct AddressSpace: describes a mapping of addresses to #MemoryRe=
gion objects
> > @@ -1143,8 +1137,10 @@ struct AddressSpace {
> >       QTAILQ_HEAD(, MemoryListener) listeners;
> >       QTAILQ_ENTRY(AddressSpace) address_spaces_link;
> >
> > -    /* Bounce buffer to use for this address space. */
> > -    BounceBuffer bounce;
> > +    /* Maximum DMA bounce buffer size used for indirect memory map req=
uests */
> > +    uint32_t max_bounce_buffer_size;
>
> Alternatively size_t.

While switching things over, I was surprised to find that
DEFINE_PROP_SIZE wants a uint64_t field rather than a size_t field.
There is a DEFINE_PROP_SIZE32 variant for uint32_t though. Considering
my options, assuming that we want to use size_t for everything other
than the property:

(1) Make PCIDevice::max_bounce_buffer_size size_t and have the
preprocessor select DEFINE_PROP_SIZE/DEFINE_PROP_SIZE32. This makes
the qdev property type depend on the host. Ugh.

(2) Make PCIDevice::max_bounce_buffer_size uint64_t and clamp if
needed when used. Weird to allow larger values that are then clamped,
although it probably doesn't matter in practice since address space is
limited to 4GB anyways.

(3) Make PCIDevice::max_bounce_buffer_size uint32_t and accept the
limitation that the largest bounce buffer limit is 4GB even on 64-bit
hosts.

#3 seemed most pragmatic, so I'll go with that.


>
> > +    /* Total size of bounce buffers currently allocated, atomically ac=
cessed */
> > +    uint32_t bounce_buffer_size;
>
> Ditto.
>
> >       /* List of callbacks to invoke when buffers free up */
> >       QemuMutex map_client_list_lock;
> >       QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
> > diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> > index d3dd0f64b2..253b48a688 100644
> > --- a/include/hw/pci/pci_device.h
> > +++ b/include/hw/pci/pci_device.h
> > @@ -160,6 +160,9 @@ struct PCIDevice {
> >       /* ID of standby device in net_failover pair */
> >       char *failover_pair_id;
> >       uint32_t acpi_index;
> > +
> > +    /* Maximum DMA bounce buffer size used for indirect memory map req=
uests */
> > +    uint32_t max_bounce_buffer_size;
>
> Ditto.
>
> >   };
>
>
> > diff --git a/system/physmem.c b/system/physmem.c
> > index 632da6508a..cd61758da0 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -3046,6 +3046,20 @@ void cpu_flush_icache_range(hwaddr start, hwaddr=
 len)
> >                                        NULL, len, FLUSH_CACHE);
> >   }
> >
> > +/*
> > + * A magic value stored in the first 8 bytes of the bounce buffer stru=
ct. Used
> > + * to detect illegal pointers passed to address_space_unmap.
> > + */
> > +#define BOUNCE_BUFFER_MAGIC 0xb4017ceb4ffe12ed
> > +
> > +typedef struct {
> > +    uint64_t magic;
> > +    MemoryRegion *mr;
> > +    hwaddr addr;
> > +    uint32_t len;
> > +    uint8_t buffer[];
> > +} BounceBuffer;
>
> Eh, you moved it back here. Never mind.
>
> > +
> >   static void
> >   address_space_unregister_map_client_do(AddressSpaceMapClient *client)
> >   {
> > @@ -3071,9 +3085,9 @@ void address_space_register_map_client(AddressSpa=
ce *as, QEMUBH *bh)
> >       qemu_mutex_lock(&as->map_client_list_lock);
> >       client->bh =3D bh;
> >       QLIST_INSERT_HEAD(&as->map_client_list, client, link);
> > -    /* Write map_client_list before reading in_use.  */
> > +    /* Write map_client_list before reading bounce_buffer_size. */
> >       smp_mb();
> > -    if (!qatomic_read(&as->bounce.in_use)) {
> > +    if (qatomic_read(&as->bounce_buffer_size) < as->max_bounce_buffer_=
size) {
> >           address_space_notify_map_clients_locked(as);
> >       }
> >       qemu_mutex_unlock(&as->map_client_list_lock);
> > @@ -3203,28 +3217,40 @@ void *address_space_map(AddressSpace *as,
> >       mr =3D flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
> >
> >       if (!memory_access_is_direct(mr, is_write)) {
> > -        if (qatomic_xchg(&as->bounce.in_use, true)) {
> > +        uint32_t used =3D qatomic_read(&as->bounce_buffer_size);
>
> Nitpicking again, size_t seems clearer. Otherwise LGTM.

