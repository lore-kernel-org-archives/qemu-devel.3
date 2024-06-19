Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EB5C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 03:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJlZx-0000WB-Km; Tue, 18 Jun 2024 23:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sJlZw-0000Vx-6K
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 23:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sJlZu-0007zq-81
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 23:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718766100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ElwV8dwgp+H2cJ6q//q1b9Pa5X+3UciEUcashN/oUBI=;
 b=SW/NgWzfD89bQiimaHqD4UdE+jl9oiVM9SByPs3ERQEPiqrO4U8/L8GvbIK/l2BTzDspYR
 hePT++6bpn+oGlZkBa/Ai96PDTMECSfsIx4k+45EPnGSiSPFQHp+4I3dFcsq45SGoUAN/X
 AlDEGL8dro7KlJt+iwZQ8Nhk/MevS+A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-A7lU4KBEOJ2VtAaqxn3YIA-1; Tue, 18 Jun 2024 23:01:38 -0400
X-MC-Unique: A7lU4KBEOJ2VtAaqxn3YIA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57c93227bbeso4108212a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 20:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718766096; x=1719370896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ElwV8dwgp+H2cJ6q//q1b9Pa5X+3UciEUcashN/oUBI=;
 b=FUxE0UNXcInlLn2anD/FDwLozN9GzL0pc5LKREgzpJzPxl0ev30CYaR0yjKAoosc5P
 cModM9/g6vCFubcHjugtCqHTHCSOOpp0/DWKY7NvJhcDznGgfAv7fhRujm9zkA0/vhuQ
 3qtkqE2HL/gDesbZIGAJQ18uOU6A/jnOPbzWreNnPlRwQ7rFYwvg8miueq+usL3tYVpZ
 b8I138yqkeo8c55dY1Xr7xsSFyAoHPf8cSRM36MYbMyrMcz7tRdc5sKIkCeQTPr4GD14
 e2iTMrkbkmS5XTSuMnOCCGtLz5p61kfedREo9tIWHvaCEo5uoVmCfsGX6OcnCQzvyr/1
 W3+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV8goBxvxOsX0wbVPgkd4CFclQmUYAUfdP2VJIJPkMZBiY3hBGNthq2aAYLosJGWZMFaqvIsMuYwxoOldodexfh2jQTBk=
X-Gm-Message-State: AOJu0YyqKowkrBWoWWt2F/KAY8JiN9MS4RbyVmOzLbwP8EGhJNreztWi
 ITG0Fc2Vur+ASUgOHrj4MdWBGq0wXIofXF5UrYr6zRapdqJK2qhqL6TNF3cRY123x1/ePBufAzj
 bI0y5M0WyRAcqCDP0NtcsRXRYKRhd2uL4r9Ra2akvjlIv2D3ul7w0EKF4E8ii259+66FLSAlTeI
 yw+0pifLHJhZDWduwzZzmCt0fCO4K69In+FWY=
X-Received: by 2002:a17:907:30d7:b0:a6f:56d2:8f0c with SMTP id
 a640c23a62f3a-a6fab643ee2mr53428666b.40.1718766096323; 
 Tue, 18 Jun 2024 20:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu1i5I0JFjVMBwhcGOJZfK/jVrIjOBlB+mHMPdg9JvWv2JEqANUrDYkv6/MRtkhP9EsOvahc7cm+cAgULiqB8=
X-Received: by 2002:a17:907:30d7:b0:a6f:56d2:8f0c with SMTP id
 a640c23a62f3a-a6fab643ee2mr53427766b.40.1718766095996; Tue, 18 Jun 2024
 20:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240617095529.115046-1-lulu@redhat.com>
 <d68aeb35-3e31-48f1-81df-d85ed8d8381c@linaro.org>
In-Reply-To: <d68aeb35-3e31-48f1-81df-d85ed8d8381c@linaro.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 19 Jun 2024 11:00:58 +0800
Message-ID: <CACLfguUBmB_XK5h4eo4HBvOxv=A=NrTKv8GuBR=T=9ZLpfgRDA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-pci: Fix the use of an uninitialized irqfd.
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 17, 2024 at 6:38=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Cindy,
>
> On 17/6/24 11:55, Cindy Lu wrote:
> > The crash was reported in MAC OS and NixOS, here is the link for this b=
ug
> > https://gitlab.com/qemu-project/qemu/-/issues/2334
> > https://gitlab.com/qemu-project/qemu/-/issues/2321
> >
> > The root cause is the function virtio_pci_set_guest_notifiers() was not=
 called
> > in the virtio_input device.So the vector_irqfd was not initialized
> >
> > So the fix is to add the check for vector_irqfd.
> >
> > This fix is verified in vyatta,MacOS,NixOS,fedora system.
> >
> > The bt tree for this bug is:
> > Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> > kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c=
:817
> > 817       if (irqfd->users =3D=3D 0) {
> > (gdb) thread apply all bt
> > ...
> > Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) "CPU 0/KVM"):
> > 0  kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pc=
i.c:817
> > 1  kvm_virtio_pci_vector_use_one () at ../qemu-9.0.0/hw/virtio/virtio-p=
ci.c:893
> > 2  0x00005983657045e2 in memory_region_write_accessor () at ../qemu-9.0=
.0/system/memory.c:497
> > 3  0x0000598365704ba6 in access_with_adjusted_size () at ../qemu-9.0.0/=
system/memory.c:573
> > 4  0x0000598365705059 in memory_region_dispatch_write () at ../qemu-9.0=
.0/system/memory.c:1528
> > 5  0x00005983659b8e1f in flatview_write_continue_step.isra.0 () at ../q=
emu-9.0.0/system/physmem.c:2713
> > 6  0x000059836570ba7d in flatview_write_continue () at ../qemu-9.0.0/sy=
stem/physmem.c:2743
> > 7  flatview_write () at ../qemu-9.0.0/system/physmem.c:2774
> > 8  0x000059836570bb76 in address_space_write () at ../qemu-9.0.0/system=
/physmem.c:2894
> > 9  0x0000598365763afe in address_space_rw () at ../qemu-9.0.0/system/ph=
ysmem.c:2904
> > 10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917
> > 11 0x000059836576656e in kvm_vcpu_thread_fn () at ../qemu-9.0.0/accel/k=
vm/kvm-accel-ops.c:50
> > 12 0x0000598365926ca8 in qemu_thread_start () at ../qemu-9.0.0/util/qem=
u-thread-posix.c:541
> > 13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6
> > 14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6
> >
> > Fixes: 2ce6cff94d ("virtio-pci: fix use of a released vector")
> > Cc: qemu-stable@nongnu.org
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   hw/virtio/virtio-pci.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index b1d02f4b3d..502aad28b2 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1442,7 +1442,9 @@ static void virtio_pci_set_vector(VirtIODevice *v=
dev,
> >        * Otherwise just need to set the new vector on the device.
> >        */
> >       if (kvm_irqfd && old_vector !=3D VIRTIO_NO_VECTOR) {
> > -        kvm_virtio_pci_vector_release_one(proxy, queue_no);
> > +        if (proxy->vector_irqfd) {
>
> Shouldn't this go into called virtio_pci_get_notifier()?
>
sure, will do
> > +            kvm_virtio_pci_vector_release_one(proxy, queue_no);
>
> We ignore this function return value, is it safe/expected?
>
sure, will add the check here
thanks
Cindy
> > +        }
> >       }
>
>


