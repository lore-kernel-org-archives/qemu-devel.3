Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D2EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 06:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW8fO-0006uR-NB; Tue, 23 Jul 2024 02:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sW8fM-0006tN-Uf
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sW8fK-0007UC-MQ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721714781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YJGd0D9AyQAfkXVpMbUmcXD0kdGs2RBaCJVY12tAzfM=;
 b=BAvPAY0sH2xBA6kKyh5LKhnWLyDO7UWRIr7Q+zDXPJcKAfnHYbKiYs91qqplE2iYmmDslu
 s9m/XOmFI/0em12eLgkhS4ha079sbZzllmkXTy7dUb3mim8scFPZBxhwBCgeQ/Iq7uFD17
 /TBESZwRUs1L11eaJNuE+8CrOtV7gSg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-fltTg4IcM9-ovBdqDRcfFQ-1; Tue, 23 Jul 2024 02:06:19 -0400
X-MC-Unique: fltTg4IcM9-ovBdqDRcfFQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb81c562edso3798732a91.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 23:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721714779; x=1722319579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJGd0D9AyQAfkXVpMbUmcXD0kdGs2RBaCJVY12tAzfM=;
 b=KPHhdgjPn7noB7h7RaR1TaQy5baxeZU5HI9kqsYoxl2/4gXNu7tbie0TE5m0ihWstE
 EZHa8S46u5xgin5s0izAvdCD/ajElYLLxUKhRBNUYHyRyxSP8Zlca31p9wfDKMDqcr1j
 RmHocRtr3YeaDDZqbAdWr8Wrgnd6zG0sSOq393D5fDrnHAuUFvA65HXZfoBv3P975Pat
 5Kpm+kRmb8HY7GRiHTuhzAffMd31VsxkD+wkT1WwjtB5+4Pf+1M4ebnJeRkTiffYWtlm
 0FgPRhFalyk2a6gUbN48ch4jxEuEZgEtHKkgoksN0m25cCAkfgn8xF9fDB7JK9hDv6LM
 PprA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgBI6TtQV68KjxYY7VAcvWI3ajObYpPJa4359wF86Z0CWlJkFOVmYKV1X75gjgaQs75DMGW2JRA943bMxPEcCTYy43ITc=
X-Gm-Message-State: AOJu0YxZt89jCDoxp89kJv24u0d16fZMpYR8s05zio9OynYMPe6ZyAJq
 eAFgQ08zKUyP9hF+nTbVFy/W3P28AJLpK3GP/SYTIs/p6wffNkhzOtEYYUXdxD0UMnPAICCTWqk
 TIkle++k5m/VokqM7E2GMPmXrxDLx0RvOQJeuV38rU0DLVEKbSn5evJAvVil6yOpsrly28KOlVO
 6axm0l18kiCvKNEoKBKhKO3AQlZyI=
X-Received: by 2002:a17:90a:4d89:b0:2c9:df1c:4a58 with SMTP id
 98e67ed59e1d1-2cd274367e0mr5041843a91.23.1721714778718; 
 Mon, 22 Jul 2024 23:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMZPH47oHi6bQPuGQ7rsOPMcofrPqjxpU1K6Poh+5MyMNpXnnqD+F0B85ueQE3y/Gr+nKVoWfhj8Z2k8Naz68=
X-Received: by 2002:a17:90a:4d89:b0:2c9:df1c:4a58 with SMTP id
 98e67ed59e1d1-2cd274367e0mr5041822a91.23.1721714778179; Mon, 22 Jul 2024
 23:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240719052531.926801-1-lulu@redhat.com>
 <CACGkMEtauhCfYSfFHc-GXAzvXm78fodTpDb-JcoGwfVjCD1qvw@mail.gmail.com>
 <CACLfguWc-jNvdo02hrJaiU7epY_d3WOWkurHj7yW0-onfMFSwQ@mail.gmail.com>
In-Reply-To: <CACLfguWc-jNvdo02hrJaiU7epY_d3WOWkurHj7yW0-onfMFSwQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Jul 2024 14:06:05 +0800
Message-ID: <CACGkMEuS2Yua6jS3i1ChtJv91Lm8A2r61AJrOMrmLbOcWStnsQ@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-pci: Fix the use of an uninitialized irqfd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 22, 2024 at 4:42=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
>
>
> On Mon, 22 Jul 2024 at 15:24, Jason Wang <jasowang@redhat.com> wrote:
> >
> > Hi Cindy
> >
> > On Fri, Jul 19, 2024 at 1:25=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > The crash was reported in MAC OS and NixOS, here is the link for this=
 bug
> > > https://gitlab.com/qemu-project/qemu/-/issues/2334
> > > https://gitlab.com/qemu-project/qemu/-/issues/2321
> > >
> > > In this bug, they are using the virtio_input device. The guest notifi=
er was
> > > not supported for this device, The function virtio_pci_set_guest_noti=
fiers()
> > > was not called, and the vector_irqfd was not initialized.
> > >
> > > So the fix is adding the check for vector_irqfd in virtio_pci_get_not=
ifier()
> > >
> > > But The function virtio_pci_get_notifier(),it can also be used in all=
 kinds of device.
> > > If the vector_irqfd still didn't initial after the VIRTIO_CONFIG_S_DR=
IVER_OK is set
> > > means this device is not using guest notifier. We can let the check f=
ail here
> > >
> > > This fix is verified in vyatta,MacOS,NixOS,fedora system.
> > >
> > > The bt tree for this bug is:
> > > Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> > > [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> > > kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci=
.c:817
> > > 817         if (irqfd->users =3D=3D 0) {
> > > (gdb) thread apply all bt
> > > ...
> > > Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) "CPU 0/KVM"):
> > > 0  kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-=
pci.c:817
> > > 1  kvm_virtio_pci_vector_use_one () at ../qemu-9.0.0/hw/virtio/virtio=
-pci.c:893
> > > 2  0x00005983657045e2 in memory_region_write_accessor () at ../qemu-9=
.0.0/system/memory.c:497
> > > 3  0x0000598365704ba6 in access_with_adjusted_size () at ../qemu-9.0.=
0/system/memory.c:573
> > > 4  0x0000598365705059 in memory_region_dispatch_write () at ../qemu-9=
.0.0/system/memory.c:1528
> > > 5  0x00005983659b8e1f in flatview_write_continue_step.isra.0 () at ..=
/qemu-9.0.0/system/physmem.c:2713
> > > 6  0x000059836570ba7d in flatview_write_continue () at ../qemu-9.0.0/=
system/physmem.c:2743
> > > 7  flatview_write () at ../qemu-9.0.0/system/physmem.c:2774
> > > 8  0x000059836570bb76 in address_space_write () at ../qemu-9.0.0/syst=
em/physmem.c:2894
> > > 9  0x0000598365763afe in address_space_rw () at ../qemu-9.0.0/system/=
physmem.c:2904
> > > 10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917
> > > 11 0x000059836576656e in kvm_vcpu_thread_fn () at ../qemu-9.0.0/accel=
/kvm/kvm-accel-ops.c:50
> > > 12 0x0000598365926ca8 in qemu_thread_start () at ../qemu-9.0.0/util/q=
emu-thread-posix.c:541
> > > 13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6
> > > 14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6
> > >
> > > Fixes: 2ce6cff94d ("virtio-pci: fix use of a released vector")
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  hw/virtio/virtio-pci.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index 592fdaa10f..dc31a37ec0 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -860,6 +860,9 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy=
 *proxy, int queue_no,
> > >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> > >      VirtQueue *vq;
> > >
> > > +    if (!proxy->vector_irqfd && vdev->status & VIRTIO_CONFIG_S_DRIVE=
R_OK)
> > > +        return -1;
> > > +
> >
> > Did this mean !proxy->vector_irqfd && !(vdev->status &
> > VIRTIO_CONFIG_S_DRIVER_OK)) is legal?
> >
> > Thanks
> >
> yes, for my test, I didn't meet this kind of environment.

This needs to be checked, we can use qtest to poc this condition if you wis=
h.

But I meant we need to explain why there is a check for DRIVER_OK
here. For example, did the current Qemu guarantee that?

> However, since this function is used widely in many environments, I canno=
t cover all devices for testing.
>
> I think we can change the patch back to the first version, which is to ch=
eck the proxy->vector_irqfd in virtio_pci_set_vector(). This will have a lo=
wer risk and make more sense
> thanks
> cindy

Thanks

>
>
> On Mon, 22 Jul 2024 at 15:24, Jason Wang <jasowang@redhat.com> wrote:
>>
>> Hi Cindy
>>
>> On Fri, Jul 19, 2024 at 1:25=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
>> >
>> > The crash was reported in MAC OS and NixOS, here is the link for this =
bug
>> > https://gitlab.com/qemu-project/qemu/-/issues/2334
>> > https://gitlab.com/qemu-project/qemu/-/issues/2321
>> >
>> > In this bug, they are using the virtio_input device. The guest notifie=
r was
>> > not supported for this device, The function virtio_pci_set_guest_notif=
iers()
>> > was not called, and the vector_irqfd was not initialized.
>> >
>> > So the fix is adding the check for vector_irqfd in virtio_pci_get_noti=
fier()
>> >
>> > But The function virtio_pci_get_notifier(),it can also be used in all =
kinds of device.
>> > If the vector_irqfd still didn't initial after the VIRTIO_CONFIG_S_DRI=
VER_OK is set
>> > means this device is not using guest notifier. We can let the check fa=
il here
>> >
>> > This fix is verified in vyatta,MacOS,NixOS,fedora system.
>> >
>> > The bt tree for this bug is:
>> > Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
>> > [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
>> > kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.=
c:817
>> > 817         if (irqfd->users =3D=3D 0) {
>> > (gdb) thread apply all bt
>> > ...
>> > Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) "CPU 0/KVM"):
>> > 0  kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-p=
ci.c:817
>> > 1  kvm_virtio_pci_vector_use_one () at ../qemu-9.0.0/hw/virtio/virtio-=
pci.c:893
>> > 2  0x00005983657045e2 in memory_region_write_accessor () at ../qemu-9.=
0.0/system/memory.c:497
>> > 3  0x0000598365704ba6 in access_with_adjusted_size () at ../qemu-9.0.0=
/system/memory.c:573
>> > 4  0x0000598365705059 in memory_region_dispatch_write () at ../qemu-9.=
0.0/system/memory.c:1528
>> > 5  0x00005983659b8e1f in flatview_write_continue_step.isra.0 () at ../=
qemu-9.0.0/system/physmem.c:2713
>> > 6  0x000059836570ba7d in flatview_write_continue () at ../qemu-9.0.0/s=
ystem/physmem.c:2743
>> > 7  flatview_write () at ../qemu-9.0.0/system/physmem.c:2774
>> > 8  0x000059836570bb76 in address_space_write () at ../qemu-9.0.0/syste=
m/physmem.c:2894
>> > 9  0x0000598365763afe in address_space_rw () at ../qemu-9.0.0/system/p=
hysmem.c:2904
>> > 10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917
>> > 11 0x000059836576656e in kvm_vcpu_thread_fn () at ../qemu-9.0.0/accel/=
kvm/kvm-accel-ops.c:50
>> > 12 0x0000598365926ca8 in qemu_thread_start () at ../qemu-9.0.0/util/qe=
mu-thread-posix.c:541
>> > 13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6
>> > 14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6
>> >
>> > Fixes: 2ce6cff94d ("virtio-pci: fix use of a released vector")
>> > Cc: qemu-stable@nongnu.org
>> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>> > ---
>> >  hw/virtio/virtio-pci.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> > index 592fdaa10f..dc31a37ec0 100644
>> > --- a/hw/virtio/virtio-pci.c
>> > +++ b/hw/virtio/virtio-pci.c
>> > @@ -860,6 +860,9 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy =
*proxy, int queue_no,
>> >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
>> >      VirtQueue *vq;
>> >
>> > +    if (!proxy->vector_irqfd && vdev->status & VIRTIO_CONFIG_S_DRIVER=
_OK)
>> > +        return -1;
>> > +
>>
>> Did this mean !proxy->vector_irqfd && !(vdev->status &
>> VIRTIO_CONFIG_S_DRIVER_OK)) is legal?
>>
>> Thanks
>>
>> >      if (queue_no =3D=3D VIRTIO_CONFIG_IRQ_IDX) {
>> >          *n =3D virtio_config_get_guest_notifier(vdev);
>> >          *vector =3D vdev->config_vector;
>> > --
>> > 2.45.0
>> >
>>


