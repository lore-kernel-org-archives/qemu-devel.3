Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D10C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 08:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVoch-000581-MI; Mon, 22 Jul 2024 04:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sVocg-00056g-4j
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sVocd-0008Tl-EU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721637737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zRSKaSRjpFfonr9Edn0C7le+LYWa17h+LW7IgmU12Kg=;
 b=DG7Tsk6ufxunF7IuacRXeS9DVI5bUNkUCArRdUcVOG15iSDaJtf/LsvcNJXNafuHoWi0YX
 yIroZ3tgROcPO31nrVABVW3ZD+ZUzMBzTDj0JuI1pfB50x4LqOLGgtBjukVcHOakFPP3L4
 Kfir5YnpU30V0DnhtGc7Gs11Ou42tZA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-CqsAklJSMQy10eBQG4BpzA-1; Mon, 22 Jul 2024 04:42:13 -0400
X-MC-Unique: CqsAklJSMQy10eBQG4BpzA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a69c1f5691so1425089a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 01:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721637732; x=1722242532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zRSKaSRjpFfonr9Edn0C7le+LYWa17h+LW7IgmU12Kg=;
 b=gbgBLggJ9uQxYqjxYFK2HoradXdFPV4IJxxoIU36PB+NZOXODjY+VjbtQLucBuXbP5
 jem2/zhpO5eTDDUJxIQo3vCFgt8Dif0Ne8K++hxBlwRT/iQ65DimcLCLaZSnbSvocQ8T
 zT+7/DlMtQC4ifWIjBqPFnoslTU9B71geXj5bgY4yGSuLjcFosCMQzuu+rOgCr8Woaci
 LkQFHR5LWPPqj6XjaGuOPCVtjxXknii+Dg16PKbmDLeEwRmuVHAZCmZsViXc03VzuLrF
 LircoBH5zsn/2FQ67p/YUkR/U5NQ1u4+as5giKTyrooZvnoWRyFjlbitWo4m2s5vZUzK
 j73g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsHtnK1UH+MmxXjZeeFHKSG7MWHVmjlrd8sza+LvDlhi3N48AHYPmodDvaUJuXasaFvO5wdVU63eN8scCUSenXPADhuEg=
X-Gm-Message-State: AOJu0Yyq/zXFZKmVJ18ecASPZ1xGLbT8yjaZ8rGb3lSCVzBrOV7KLXVH
 f2v+lR8jXHfm0ZtjWowKoStcbMNmr28ZBq4bO50xGfxoP3NR2pr3xI13AjKJVO1lsncGqsjxcR/
 s3KDUeJt6giQ0qnQBzYY4AohCCF0OWFk00JmNu09QDKEazMNYkl2AwYfJRDTbPa0LF9TIGvDplv
 vNhm2l3m9cSVzYJjfdj5yX9JGZBUM=
X-Received: by 2002:a05:6402:51c7:b0:57c:614c:56e7 with SMTP id
 4fb4d7f45d1cf-5a40e8367e2mr6255598a12.18.1721637732527; 
 Mon, 22 Jul 2024 01:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrc5xm5F1LseiYkWQFsUG3W8XLnlMMg/IW0bn2TqPmD+5JHvv2K8gCd+lXc7zuqjdfGzzNZystdyGFsSAEesQ=
X-Received: by 2002:a05:6402:51c7:b0:57c:614c:56e7 with SMTP id
 4fb4d7f45d1cf-5a40e8367e2mr6255579a12.18.1721637732006; Mon, 22 Jul 2024
 01:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240719052531.926801-1-lulu@redhat.com>
 <CACGkMEtauhCfYSfFHc-GXAzvXm78fodTpDb-JcoGwfVjCD1qvw@mail.gmail.com>
In-Reply-To: <CACGkMEtauhCfYSfFHc-GXAzvXm78fodTpDb-JcoGwfVjCD1qvw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 22 Jul 2024 16:41:33 +0800
Message-ID: <CACLfguWc-jNvdo02hrJaiU7epY_d3WOWkurHj7yW0-onfMFSwQ@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-pci: Fix the use of an uninitialized irqfd
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000072d2f2061dd2056f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

--00000000000072d2f2061dd2056f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 15:24, Jason Wang <jasowang@redhat.com> wrote:
>
> Hi Cindy
>
> On Fri, Jul 19, 2024 at 1:25=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > The crash was reported in MAC OS and NixOS, here is the link for this
bug
> > https://gitlab.com/qemu-project/qemu/-/issues/2334
> > https://gitlab.com/qemu-project/qemu/-/issues/2321
> >
> > In this bug, they are using the virtio_input device. The guest notifier
was
> > not supported for this device, The function
virtio_pci_set_guest_notifiers()
> > was not called, and the vector_irqfd was not initialized.
> >
> > So the fix is adding the check for vector_irqfd in
virtio_pci_get_notifier()
> >
> > But The function virtio_pci_get_notifier(),it can also be used in all
kinds of device.
> > If the vector_irqfd still didn't initial after the
VIRTIO_CONFIG_S_DRIVER_OK is set
> > means this device is not using guest notifier. We can let the check
fail here
> >
> > This fix is verified in vyatta,MacOS,NixOS,fedora system.
> >
> > The bt tree for this bug is:
> > Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> > kvm_virtio_pci_vq_vector_use () at
../qemu-9.0.0/hw/virtio/virtio-pci.c:817
> > 817         if (irqfd->users =3D=3D 0) {
> > (gdb) thread apply all bt
> > ...
> > Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) "CPU 0/KVM"):
> > 0  kvm_virtio_pci_vq_vector_use () at
../qemu-9.0.0/hw/virtio/virtio-pci.c:817
> > 1  kvm_virtio_pci_vector_use_one () at
../qemu-9.0.0/hw/virtio/virtio-pci.c:893
> > 2  0x00005983657045e2 in memory_region_write_accessor () at
../qemu-9.0.0/system/memory.c:497
> > 3  0x0000598365704ba6 in access_with_adjusted_size () at
../qemu-9.0.0/system/memory.c:573
> > 4  0x0000598365705059 in memory_region_dispatch_write () at
../qemu-9.0.0/system/memory.c:1528
> > 5  0x00005983659b8e1f in flatview_write_continue_step.isra.0 () at
../qemu-9.0.0/system/physmem.c:2713
> > 6  0x000059836570ba7d in flatview_write_continue () at
../qemu-9.0.0/system/physmem.c:2743
> > 7  flatview_write () at ../qemu-9.0.0/system/physmem.c:2774
> > 8  0x000059836570bb76 in address_space_write () at
../qemu-9.0.0/system/physmem.c:2894
> > 9  0x0000598365763afe in address_space_rw () at
../qemu-9.0.0/system/physmem.c:2904
> > 10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917
> > 11 0x000059836576656e in kvm_vcpu_thread_fn () at
../qemu-9.0.0/accel/kvm/kvm-accel-ops.c:50
> > 12 0x0000598365926ca8 in qemu_thread_start () at
../qemu-9.0.0/util/qemu-thread-posix.c:541
> > 13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6
> > 14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6
> >
> > Fixes: 2ce6cff94d ("virtio-pci: fix use of a released vector")
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 592fdaa10f..dc31a37ec0 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -860,6 +860,9 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy
*proxy, int queue_no,
> >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >      VirtQueue *vq;
> >
> > +    if (!proxy->vector_irqfd && vdev->status &
VIRTIO_CONFIG_S_DRIVER_OK)
> > +        return -1;
> > +
>
> Did this mean !proxy->vector_irqfd && !(vdev->status &
> VIRTIO_CONFIG_S_DRIVER_OK)) is legal?
>
> Thanks
>
yes, for my test, I didn't meet this kind of environment. However, since
this function is used widely in many environments, I cannot cover all
devices for testing.

I think we can change the patch back to the first version, which is to
check the proxy->vector_irqfd in virtio_pci_set_vector(). This will have a
lower risk and make more sense
thanks
cindy


On Mon, 22 Jul 2024 at 15:24, Jason Wang <jasowang@redhat.com> wrote:

> Hi Cindy
>
> On Fri, Jul 19, 2024 at 1:25=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > The crash was reported in MAC OS and NixOS, here is the link for this b=
ug
> > https://gitlab.com/qemu-project/qemu/-/issues/2334
> > https://gitlab.com/qemu-project/qemu/-/issues/2321
> >
> > In this bug, they are using the virtio_input device. The guest notifier
> was
> > not supported for this device, The function
> virtio_pci_set_guest_notifiers()
> > was not called, and the vector_irqfd was not initialized.
> >
> > So the fix is adding the check for vector_irqfd in
> virtio_pci_get_notifier()
> >
> > But The function virtio_pci_get_notifier(),it can also be used in all
> kinds of device.
> > If the vector_irqfd still didn't initial after the
> VIRTIO_CONFIG_S_DRIVER_OK is set
> > means this device is not using guest notifier. We can let the check fai=
l
> here
> >
> > This fix is verified in vyatta,MacOS,NixOS,fedora system.
> >
> > The bt tree for this bug is:
> > Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> > kvm_virtio_pci_vq_vector_use () at
> ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
> > 817         if (irqfd->users =3D=3D 0) {
> > (gdb) thread apply all bt
> > ...
> > Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) "CPU 0/KVM"):
> > 0  kvm_virtio_pci_vq_vector_use () at
> ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
> > 1  kvm_virtio_pci_vector_use_one () at
> ../qemu-9.0.0/hw/virtio/virtio-pci.c:893
> > 2  0x00005983657045e2 in memory_region_write_accessor () at
> ../qemu-9.0.0/system/memory.c:497
> > 3  0x0000598365704ba6 in access_with_adjusted_size () at
> ../qemu-9.0.0/system/memory.c:573
> > 4  0x0000598365705059 in memory_region_dispatch_write () at
> ../qemu-9.0.0/system/memory.c:1528
> > 5  0x00005983659b8e1f in flatview_write_continue_step.isra.0 () at
> ../qemu-9.0.0/system/physmem.c:2713
> > 6  0x000059836570ba7d in flatview_write_continue () at
> ../qemu-9.0.0/system/physmem.c:2743
> > 7  flatview_write () at ../qemu-9.0.0/system/physmem.c:2774
> > 8  0x000059836570bb76 in address_space_write () at
> ../qemu-9.0.0/system/physmem.c:2894
> > 9  0x0000598365763afe in address_space_rw () at
> ../qemu-9.0.0/system/physmem.c:2904
> > 10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917
> > 11 0x000059836576656e in kvm_vcpu_thread_fn () at
> ../qemu-9.0.0/accel/kvm/kvm-accel-ops.c:50
> > 12 0x0000598365926ca8 in qemu_thread_start () at
> ../qemu-9.0.0/util/qemu-thread-posix.c:541
> > 13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6
> > 14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6
> >
> > Fixes: 2ce6cff94d ("virtio-pci: fix use of a released vector")
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 592fdaa10f..dc31a37ec0 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -860,6 +860,9 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy
> *proxy, int queue_no,
> >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >      VirtQueue *vq;
> >
> > +    if (!proxy->vector_irqfd && vdev->status &
> VIRTIO_CONFIG_S_DRIVER_OK)
> > +        return -1;
> > +
>
> Did this mean !proxy->vector_irqfd && !(vdev->status &
> VIRTIO_CONFIG_S_DRIVER_OK)) is legal?
>
> Thanks
>
> >      if (queue_no =3D=3D VIRTIO_CONFIG_IRQ_IDX) {
> >          *n =3D virtio_config_get_guest_notifier(vdev);
> >          *vector =3D vdev->config_vector;
> > --
> > 2.45.0
> >
>
>

--00000000000072d2f2061dd2056f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, 22 Jul 2024 at 15:24, Jason Wang &lt;<a hr=
ef=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>=
&gt; wrote:<br>&gt;<br>&gt; Hi Cindy<br>&gt;<br>&gt; On Fri, Jul 19, 2024 a=
t 1:25=E2=80=AFPM Cindy Lu &lt;<a href=3D"mailto:lulu@redhat.com" target=3D=
"_blank">lulu@redhat.com</a>&gt; wrote:<br>&gt; &gt;<br>&gt; &gt; The crash=
 was reported in MAC OS and NixOS, here is the link for this bug<br>&gt; &g=
t; <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2334" target=3D=
"_blank">https://gitlab.com/qemu-project/qemu/-/issues/2334</a><br>&gt; &gt=
; <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2321" target=3D"=
_blank">https://gitlab.com/qemu-project/qemu/-/issues/2321</a><br>&gt; &gt;=
<br>&gt; &gt; In this bug, they are using the virtio_input device. The gues=
t notifier was<br>&gt; &gt; not supported for this device, The function vir=
tio_pci_set_guest_notifiers()<br>&gt; &gt; was not called, and the vector_i=
rqfd was not initialized.<br>&gt; &gt;<br>&gt; &gt; So the fix is adding th=
e check for vector_irqfd in virtio_pci_get_notifier()<br>&gt; &gt;<br>&gt; =
&gt; But The function virtio_pci_get_notifier(),it can also be used in all =
kinds of device.<br>&gt; &gt; If the vector_irqfd still didn&#39;t initial =
after the VIRTIO_CONFIG_S_DRIVER_OK is set<br>&gt; &gt; means this device i=
s not using guest notifier. We can let the check fail here<br>&gt; &gt;<br>=
&gt; &gt; This fix is verified in vyatta,MacOS,NixOS,fedora system.<br>&gt;=
 &gt;<br>&gt; &gt; The bt tree for this bug is:<br>&gt; &gt; Thread 6 &quot=
;CPU 0/KVM&quot; received signal SIGSEGV, Segmentation fault.<br>&gt; &gt; =
[Switching to Thread 0x7c817be006c0 (LWP 1269146)]<br>&gt; &gt; kvm_virtio_=
pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817<br>&gt; &g=
t; 817 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (irqfd-&gt;users =3D=3D 0) {<br>&gt; =
&gt; (gdb) thread apply all bt<br>&gt; &gt; ...<br>&gt; &gt; Thread 6 (Thre=
ad 0x7c817be006c0 (LWP 1269146) &quot;CPU 0/KVM&quot;):<br>&gt; &gt; 0 =C2=
=A0kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:=
817<br>&gt; &gt; 1 =C2=A0kvm_virtio_pci_vector_use_one () at ../qemu-9.0.0/=
hw/virtio/virtio-pci.c:893<br>&gt; &gt; 2 =C2=A00x00005983657045e2 in memor=
y_region_write_accessor () at ../qemu-9.0.0/system/memory.c:497<br>&gt; &gt=
; 3 =C2=A00x0000598365704ba6 in access_with_adjusted_size () at ../qemu-9.0=
.0/system/memory.c:573<br>&gt; &gt; 4 =C2=A00x0000598365705059 in memory_re=
gion_dispatch_write () at ../qemu-9.0.0/system/memory.c:1528<br>&gt; &gt; 5=
 =C2=A00x00005983659b8e1f in flatview_write_continue_step.isra.0 () at ../q=
emu-9.0.0/system/physmem.c:2713<br>&gt; &gt; 6 =C2=A00x000059836570ba7d in =
flatview_write_continue () at ../qemu-9.0.0/system/physmem.c:2743<br>&gt; &=
gt; 7 =C2=A0flatview_write () at ../qemu-9.0.0/system/physmem.c:2774<br>&gt=
; &gt; 8 =C2=A00x000059836570bb76 in address_space_write () at ../qemu-9.0.=
0/system/physmem.c:2894<br>&gt; &gt; 9 =C2=A00x0000598365763afe in address_=
space_rw () at ../qemu-9.0.0/system/physmem.c:2904<br>&gt; &gt; 10 kvm_cpu_=
exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917<br>&gt; &gt; 11 0x0000598=
36576656e in kvm_vcpu_thread_fn () at ../qemu-9.0.0/accel/kvm/kvm-accel-ops=
.c:50<br>&gt; &gt; 12 0x0000598365926ca8 in qemu_thread_start () at ../qemu=
-9.0.0/util/qemu-thread-posix.c:541<br>&gt; &gt; 13 0x00007c8185bcd1cf in ?=
?? () at /usr/lib/libc.so.6<br>&gt; &gt; 14 0x00007c8185c4e504 in clone () =
at /usr/lib/libc.so.6<br>&gt; &gt;<br>&gt; &gt; Fixes: 2ce6cff94d (&quot;vi=
rtio-pci: fix use of a released vector&quot;)<br>&gt; &gt; Cc: <a href=3D"m=
ailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable@nongnu.org</a><=
br>&gt; &gt; Signed-off-by: Cindy Lu &lt;<a href=3D"mailto:lulu@redhat.com"=
 target=3D"_blank">lulu@redhat.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =
=C2=A0hw/virtio/virtio-pci.c | 3 +++<br>&gt; &gt; =C2=A01 file changed, 3 i=
nsertions(+)<br>&gt; &gt;<br>&gt; &gt; diff --git a/hw/virtio/virtio-pci.c =
b/hw/virtio/virtio-pci.c<br>&gt; &gt; index 592fdaa10f..dc31a37ec0 100644<b=
r>&gt; &gt; --- a/hw/virtio/virtio-pci.c<br>&gt; &gt; +++ b/hw/virtio/virti=
o-pci.c<br>&gt; &gt; @@ -860,6 +860,9 @@ static int virtio_pci_get_notifier=
(VirtIOPCIProxy *proxy, int queue_no,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0Virt=
IODevice *vdev =3D virtio_bus_get_device(&amp;proxy-&gt;bus);<br>&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0VirtQueue *vq;<br>&gt; &gt;<br>&gt; &gt; + =C2=A0 =C2=
=A0if (!proxy-&gt;vector_irqfd &amp;&amp; vdev-&gt;status &amp; VIRTIO_CONF=
IG_S_DRIVER_OK)<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>&gt=
; &gt; +<br>&gt;<br>&gt; Did this mean !proxy-&gt;vector_irqfd &amp;&amp; !=
(vdev-&gt;status &amp;<br>&gt; VIRTIO_CONFIG_S_DRIVER_OK)) is legal?<br>&gt=
;<br>&gt; Thanks<br>&gt;<br><div>yes, for my test, I didn&#39;t meet this k=
ind of environment. However, since this function is used widely in many env=
ironments, I cannot cover all devices for testing.=C2=A0</div><div><br></di=
v><div><font face=3D"arial, sans-serif">I think we can=C2=A0<span style=3D"=
color:rgb(28,28,28);font-size:14px">change the patch back to the first vers=
ion, which is to check the=C2=A0</span></font>proxy-&gt;vector_irqfd<font f=
ace=3D"arial, sans-serif"><span style=3D"color:rgb(28,28,28);font-size:14px=
">=C2=A0in  virtio_pci_set_vector(). This</span>=C2=A0will have a lower ris=
k and make more sense=C2=A0</font></div><div><font face=3D"arial, sans-seri=
f">thanks</font></div><div><font face=3D"arial, sans-serif">cindy</font></d=
iv></div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, 22 Jul 2024 at 15:24, Jason Wang &lt;<a href=3D"mailto:jasow=
ang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Cindy<br>
<br>
On Fri, Jul 19, 2024 at 1:25=E2=80=AFPM Cindy Lu &lt;<a href=3D"mailto:lulu=
@redhat.com" target=3D"_blank">lulu@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The crash was reported in MAC OS and NixOS, here is the link for this =
bug<br>
&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2334" rel=3D"=
noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues=
/2334</a><br>
&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2321" rel=3D"=
noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues=
/2321</a><br>
&gt;<br>
&gt; In this bug, they are using the virtio_input device. The guest notifie=
r was<br>
&gt; not supported for this device, The function virtio_pci_set_guest_notif=
iers()<br>
&gt; was not called, and the vector_irqfd was not initialized.<br>
&gt;<br>
&gt; So the fix is adding the check for vector_irqfd in virtio_pci_get_noti=
fier()<br>
&gt;<br>
&gt; But The function virtio_pci_get_notifier(),it can also be used in all =
kinds of device.<br>
&gt; If the vector_irqfd still didn&#39;t initial after the VIRTIO_CONFIG_S=
_DRIVER_OK is set<br>
&gt; means this device is not using guest notifier. We can let the check fa=
il here<br>
&gt;<br>
&gt; This fix is verified in vyatta,MacOS,NixOS,fedora system.<br>
&gt;<br>
&gt; The bt tree for this bug is:<br>
&gt; Thread 6 &quot;CPU 0/KVM&quot; received signal SIGSEGV, Segmentation f=
ault.<br>
&gt; [Switching to Thread 0x7c817be006c0 (LWP 1269146)]<br>
&gt; kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.=
c:817<br>
&gt; 817=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (irqfd-&gt;users =3D=3D 0) {<b=
r>
&gt; (gdb) thread apply all bt<br>
&gt; ...<br>
&gt; Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) &quot;CPU 0/KVM&quot;):<=
br>
&gt; 0=C2=A0 kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/vir=
tio-pci.c:817<br>
&gt; 1=C2=A0 kvm_virtio_pci_vector_use_one () at ../qemu-9.0.0/hw/virtio/vi=
rtio-pci.c:893<br>
&gt; 2=C2=A0 0x00005983657045e2 in memory_region_write_accessor () at ../qe=
mu-9.0.0/system/memory.c:497<br>
&gt; 3=C2=A0 0x0000598365704ba6 in access_with_adjusted_size () at ../qemu-=
9.0.0/system/memory.c:573<br>
&gt; 4=C2=A0 0x0000598365705059 in memory_region_dispatch_write () at ../qe=
mu-9.0.0/system/memory.c:1528<br>
&gt; 5=C2=A0 0x00005983659b8e1f in flatview_write_continue_step.isra.0 () a=
t ../qemu-9.0.0/system/physmem.c:2713<br>
&gt; 6=C2=A0 0x000059836570ba7d in flatview_write_continue () at ../qemu-9.=
0.0/system/physmem.c:2743<br>
&gt; 7=C2=A0 flatview_write () at ../qemu-9.0.0/system/physmem.c:2774<br>
&gt; 8=C2=A0 0x000059836570bb76 in address_space_write () at ../qemu-9.0.0/=
system/physmem.c:2894<br>
&gt; 9=C2=A0 0x0000598365763afe in address_space_rw () at ../qemu-9.0.0/sys=
tem/physmem.c:2904<br>
&gt; 10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917<br>
&gt; 11 0x000059836576656e in kvm_vcpu_thread_fn () at ../qemu-9.0.0/accel/=
kvm/kvm-accel-ops.c:50<br>
&gt; 12 0x0000598365926ca8 in qemu_thread_start () at ../qemu-9.0.0/util/qe=
mu-thread-posix.c:541<br>
&gt; 13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6<br>
&gt; 14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6<br>
&gt;<br>
&gt; Fixes: 2ce6cff94d (&quot;virtio-pci: fix use of a released vector&quot=
;)<br>
&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-s=
table@nongnu.org</a><br>
&gt; Signed-off-by: Cindy Lu &lt;<a href=3D"mailto:lulu@redhat.com" target=
=3D"_blank">lulu@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/virtio-pci.c | 3 +++<br>
&gt;=C2=A0 1 file changed, 3 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c<br>
&gt; index 592fdaa10f..dc31a37ec0 100644<br>
&gt; --- a/hw/virtio/virtio-pci.c<br>
&gt; +++ b/hw/virtio/virtio-pci.c<br>
&gt; @@ -860,6 +860,9 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy =
*proxy, int queue_no,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIODevice *vdev =3D virtio_bus_get_device(&amp;=
proxy-&gt;bus);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtQueue *vq;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 if (!proxy-&gt;vector_irqfd &amp;&amp; vdev-&gt;status =
&amp; VIRTIO_CONFIG_S_DRIVER_OK)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +<br>
<br>
Did this mean !proxy-&gt;vector_irqfd &amp;&amp; !(vdev-&gt;status &amp;<br=
>
VIRTIO_CONFIG_S_DRIVER_OK)) is legal?<br>
<br>
Thanks<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (queue_no =3D=3D VIRTIO_CONFIG_IRQ_IDX) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *n =3D virtio_config_get_guest_notif=
ier(vdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *vector =3D vdev-&gt;config_vector;<=
br>
&gt; --<br>
&gt; 2.45.0<br>
&gt;<br>
<br>
</blockquote></div>

--00000000000072d2f2061dd2056f--


