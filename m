Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD14DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 02:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwvGl-0001JU-V2; Tue, 16 Apr 2024 22:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwvGi-0001J6-NT
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 22:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwvGg-0000FE-Jg
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 22:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713321805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTm3isoOQzi9YvLwoXsJeVjzx4t5pZ0v538zXQpobxY=;
 b=YRgB3WyVUb/mHiNM37dgwfhCltwVNqxUJtyrHvLiJUme/9KM1HhKvmJkNMTrHCceKbz96u
 TOr77oSzLwNZfmzES1XTaLUL1z3tN1lBe2phs7+3ey7PVz1iUpb9kA8lEk7/IHFVn19zmW
 Tj7Lg7Zn4rkNOChwp3ZAJ1xbBQ14V0s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-I7rb68ROO32ueoHOFsJ85Q-1; Tue, 16 Apr 2024 22:43:23 -0400
X-MC-Unique: I7rb68ROO32ueoHOFsJ85Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a51b00fc137so388882166b.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 19:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713321801; x=1713926601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTm3isoOQzi9YvLwoXsJeVjzx4t5pZ0v538zXQpobxY=;
 b=WrZOz7Ki9JZ5yFHB0A0OpHPY8Vgcx6JIlGZVWVwAXqhkqRUOy4E/t8AfG2DmtV2vml
 4hrkkUptE+YxJBodfTm89yBrwkwf52/9O+Ieim3fCjGX2W6BaXoK33Fs0MvMzKPpT3nl
 eCOsXYhNZz51D+C9sQz6eDF1dccTa7hpZyWxheWRihtmDaQoahLn+uwSeSemkHNAPj08
 IFLAbKYhGD2OTg68UlDTF5zpMJQEDpmRnXW7d16//z1fryXvkkgv3qcAiIfe/Xjb0Nkf
 W+ik4IAWdupOom6TFI4VMn4GuqIHEdCA5325MpbBNtBOwE/dhKP2PK+YfyqJnslid+rv
 MeJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW10ficy+H20T0LZgqRvqpYf4wi81rTJDXZx6KC/z3K2l5VutUysXqEM1697jiFPpmLrKZIqv7YZ3qZ4dFo12/ZJwmNrL0=
X-Gm-Message-State: AOJu0Yxjrz2YnmomfOqGHImjVN1eZi3WSHsV0cWxMnSdrDpas6+dKMdB
 +RfnoSmc0OJXMEXiuYiRStBFgGLmKevrAZWgrTKpqEVc2CIkrnCS3i7uI/pCyC81SZXwWjlgRPY
 jN9GlSp0aPSKsa6+snpXLyzVL+TLXqURZQlINxbPtyO25osyVcAEg61C79+NtYbILB73DkTHMs7
 3uGJu+H6Lme3IB2Hdi2pJlxk2VUyI=
X-Received: by 2002:a17:907:86ab:b0:a52:51bb:5f with SMTP id
 qa43-20020a17090786ab00b00a5251bb005fmr10948678ejc.9.1713321801746; 
 Tue, 16 Apr 2024 19:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlCzjmdrTzSfQxqM6lOnYYETj6So0mCpcHkvAP+Z6lvfEb7kfmoInG/C6kN5R5cdotHZ0wnbX5J/32C3OBpcQ=
X-Received: by 2002:a17:907:86ab:b0:a52:51bb:5f with SMTP id
 qa43-20020a17090786ab00b00a5251bb005fmr10948664ejc.9.1713321801213; Tue, 16
 Apr 2024 19:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <2321ade5f601367efe7380c04e3f61379c59b48f.1713173550.git.mst@redhat.com>
 <CACLfguWX-3nmEySF0wKnTb3bivduiHd7kBPKZ4AyNE6LVE==iw@mail.gmail.com>
 <CACGkMEvi7CdXy-xwNi80UuD8K-Y4X0mRdFBbYqxvMYHzfzctEw@mail.gmail.com>
In-Reply-To: <CACGkMEvi7CdXy-xwNi80UuD8K-Y4X0mRdFBbYqxvMYHzfzctEw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 17 Apr 2024 10:42:43 +0800
Message-ID: <CACLfguXnhTnrQcjQhArOth9M1++YAo+K-BapNqZjKNtQx2WXRA@mail.gmail.com>
Subject: Re: [PATCH v8] virtio-pci: fix use of a released vector
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

On Tue, Apr 16, 2024 at 11:21=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Apr 15, 2024 at 6:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Mon, Apr 15, 2024 at 5:34=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > From: Cindy Lu <lulu@redhat.com>
> > >
> > > During the booting process of the non-standard image, the behavior of=
 the
> > > called function in qemu is as follows:
> > >
> > > 1. vhost_net_stop() was triggered by guest image. This will call the =
function
> > > virtio_pci_set_guest_notifiers() with assgin=3D false,
> > > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for v=
ector 0
> > >
> > > 2. virtio_reset() was triggered, this will set configure vector to VI=
RTIO_NO_VECTOR
> > >
> > > 3.vhost_net_start() was called (at this time, the configure vector is
> > > still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers(=
) with
> > > assgin=3Dtrue, so the irqfd for vector 0 is still not "init" during t=
his process
> > >
> > > 4. The system continues to boot and sets the vector back to 0. After =
that
> > > msix_fire_vector_notifier() was triggered to unmask the vector 0 and =
 meet the crash
> > >
> > > To fix the issue, we need to support changing the vector after VIRTIO=
_CONFIG_S_DRIVER_OK is set.
> > >
> > > (gdb) bt
> > > 0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=
=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0)
> > >     at pthread_kill.c:44
> > > 1  0x00007fc87148ec53 in __pthread_kill_internal (signo=3D6, threadid=
=3D<optimized out>) at pthread_kill.c:78
> > > 2  0x00007fc87143e956 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysde=
ps/posix/raise.c:26
> > > 3  0x00007fc8714287f4 in __GI_abort () at abort.c:79
> > > 4  0x00007fc87142871b in __assert_fail_base
> > >     (fmt=3D0x7fc8715bbde0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n"=
, assertion=3D0x5606413efd53 "ret =3D=3D 0", file=3D0x5606413ef87d "../acce=
l/kvm/kvm-all.c", line=3D1837, function=3D<optimized out>) at assert.c:92
> > > 5  0x00007fc871437536 in __GI___assert_fail
> > >     (assertion=3D0x5606413efd53 "ret =3D=3D 0", file=3D0x5606413ef87d=
 "../accel/kvm/kvm-all.c", line=3D1837, function=3D0x5606413f06f0 <__PRETTY=
_FUNCTION__.19> "kvm_irqchip_commit_routes") at assert.c:101
> > > 6  0x0000560640f884b5 in kvm_irqchip_commit_routes (s=3D0x560642cae1f=
0) at ../accel/kvm/kvm-all.c:1837
> > > 7  0x0000560640c98f8e in virtio_pci_one_vector_unmask
> > >     (proxy=3D0x560643c65f00, queue_no=3D4294967295, vector=3D0, msg=
=3D..., n=3D0x560643c6e4c8)
> > >     at ../hw/virtio/virtio-pci.c:1005
> > > 8  0x0000560640c99201 in virtio_pci_vector_unmask (dev=3D0x560643c65f=
00, vector=3D0, msg=3D...)
> > >     at ../hw/virtio/virtio-pci.c:1070
> > > 9  0x0000560640bc402e in msix_fire_vector_notifier (dev=3D0x560643c65=
f00, vector=3D0, is_masked=3Dfalse)
> > >     at ../hw/pci/msix.c:120
> > > 10 0x0000560640bc40f1 in msix_handle_mask_update (dev=3D0x560643c65f0=
0, vector=3D0, was_masked=3Dtrue)
> > >     at ../hw/pci/msix.c:140
> > > 11 0x0000560640bc4503 in msix_table_mmio_write (opaque=3D0x560643c65f=
00, addr=3D12, val=3D0, size=3D4)
> > >     at ../hw/pci/msix.c:231
> > > 12 0x0000560640f26d83 in memory_region_write_accessor
> > >     (mr=3D0x560643c66540, addr=3D12, value=3D0x7fc86b7bc628, size=3D4=
, shift=3D0, mask=3D4294967295, attrs=3D...)
> > >     at ../system/memory.c:497
> > > 13 0x0000560640f270a6 in access_with_adjusted_size
> > >
> > >      (addr=3D12, value=3D0x7fc86b7bc628, size=3D4, access_size_min=3D=
1, access_size_max=3D4, access_fn=3D0x560640f26c8d <memory_region_write_acc=
essor>, mr=3D0x560643c66540, attrs=3D...) at ../system/memory.c:573
> > > 14 0x0000560640f2a2b5 in memory_region_dispatch_write (mr=3D0x560643c=
66540, addr=3D12, data=3D0, op=3DMO_32, attrs=3D...)
> > >     at ../system/memory.c:1521
> > > 15 0x0000560640f37bac in flatview_write_continue
> > >     (fv=3D0x7fc65805e0b0, addr=3D4273803276, attrs=3D..., ptr=3D0x7fc=
871e9c028, len=3D4, addr1=3D12, l=3D4, mr=3D0x560643c66540)
> > >     at ../system/physmem.c:2714
> > > 16 0x0000560640f37d0f in flatview_write
> > >     (fv=3D0x7fc65805e0b0, addr=3D4273803276, attrs=3D..., buf=3D0x7fc=
871e9c028, len=3D4) at ../system/physmem.c:2756
> > > 17 0x0000560640f380bf in address_space_write
> > >     (as=3D0x560642161ae0 <address_space_memory>, addr=3D4273803276, a=
ttrs=3D..., buf=3D0x7fc871e9c028, len=3D4)
> > >     at ../system/physmem.c:2863
> > > 18 0x0000560640f3812c in address_space_rw
> > >     (as=3D0x560642161ae0 <address_space_memory>, addr=3D4273803276, a=
ttrs=3D..., buf=3D0x7fc871e9c028, len=3D4, is_write=3Dtrue) at ../system/ph=
ysmem.c:2873
> > > --Type <RET> for more, q to quit, c to continue without paging--
> > > 19 0x0000560640f8aa55 in kvm_cpu_exec (cpu=3D0x560642f205e0) at ../ac=
cel/kvm/kvm-all.c:2915
> > > 20 0x0000560640f8d731 in kvm_vcpu_thread_fn (arg=3D0x560642f205e0) at=
 ../accel/kvm/kvm-accel-ops.c:51
> > > 21 0x00005606411949f4 in qemu_thread_start (args=3D0x560642f292b0) at=
 ../util/qemu-thread-posix.c:541
> > > 22 0x00007fc87148cdcd in start_thread (arg=3D<optimized out>) at pthr=
ead_create.c:442
> > > 23 0x00007fc871512630 in clone3 () at ../sysdeps/unix/sysv/linux/x86_=
64/clone3.S:81
> > > (gdb)
> > >
> > > MST: coding style and typo fixups
> > >
> > > Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > Message-Id: <20240412062750.475180-1-lulu@redhat.com>
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  hw/virtio/virtio-pci.c | 37 +++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 35 insertions(+), 2 deletions(-)
> > >
> > > v7->v8:
> > > more cleanups, suggested by Philip
> > >
> > > still untested, i just got involved to help address coding style
> > > issues
> > >
> > qtest and sanity test are all passed
> >
> > Tested-by: Cindy Lu <lulu@redhat.com>
>
> Btw, in the future, it would be better to have a dedicated qtest to
> test MSI-X confugation after DRIVER_OK.
>
> Thanks
>
sure, I will work in this
thanks
cindy
> >
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index cb6940fc0e..cb159fd078 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -1424,6 +1424,38 @@ static int virtio_pci_add_mem_cap(VirtIOPCIPro=
xy *proxy,
> > >      return offset;
> > >  }
> > >
> > > +static void virtio_pci_set_vector(VirtIODevice *vdev,
> > > +                                  VirtIOPCIProxy *proxy,
> > > +                                  int queue_no, uint16_t old_vector,
> > > +                                  uint16_t new_vector)
> > > +{
> > > +    bool kvm_irqfd =3D (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > > +        msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled()=
;
> > > +
> > > +    if (new_vector =3D=3D old_vector) {
> > > +        return;
> > > +    }
> > > +
> > > +    /*
> > > +     * If the device uses irqfd and the vector changes after DRIVER_=
OK is
> > > +     * set, we need to release the old vector and set up the new one=
.
> > > +     * Otherwise just need to set the new vector on the device.
> > > +     */
> > > +    if (kvm_irqfd && old_vector !=3D VIRTIO_NO_VECTOR) {
> > > +        kvm_virtio_pci_vector_release_one(proxy, queue_no);
> > > +    }
> > > +    /* Set the new vector on the device. */
> > > +    if (queue_no =3D=3D VIRTIO_CONFIG_IRQ_IDX) {
> > > +        vdev->config_vector =3D new_vector;
> > > +    } else {
> > > +        virtio_queue_set_vector(vdev, queue_no, new_vector);
> > > +    }
> > > +    /* If the new vector changed need to set it up. */
> > > +    if (kvm_irqfd && new_vector !=3D VIRTIO_NO_VECTOR) {
> > > +        kvm_virtio_pci_vector_use_one(proxy, queue_no);
> > > +    }
> > > +}
> > > +
> > >  int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
> > >                             uint8_t bar, uint64_t offset, uint64_t le=
ngth,
> > >                             uint8_t id)
> > > @@ -1570,7 +1602,8 @@ static void virtio_pci_common_write(void *opaqu=
e, hwaddr addr,
> > >          } else {
> > >              val =3D VIRTIO_NO_VECTOR;
> > >          }
> > > -        vdev->config_vector =3D val;
> > > +        virtio_pci_set_vector(vdev, proxy, VIRTIO_CONFIG_IRQ_IDX,
> > > +                              vdev->config_vector, val);
> > >          break;
> > >      case VIRTIO_PCI_COMMON_STATUS:
> > >          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > @@ -1610,7 +1643,7 @@ static void virtio_pci_common_write(void *opaqu=
e, hwaddr addr,
> > >          } else {
> > >              val =3D VIRTIO_NO_VECTOR;
> > >          }
> > > -        virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> > > +        virtio_pci_set_vector(vdev, proxy, vdev->queue_sel, vector, =
val);
> > >          break;
> > >      case VIRTIO_PCI_COMMON_Q_ENABLE:
> > >          if (val =3D=3D 1) {
> > > --
> > > MST
> > >
> >
>


