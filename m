Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213ADC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbe4-0002lg-D8; Tue, 16 Jul 2024 02:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sTbe1-0002j8-KK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sTbdz-00032M-Pd
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721111194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6G37f4sW3LOcb3ZtcTnGAv9MUTfDiExVXey3IX3QaVA=;
 b=KJdmcBxzCck66N9z08vwDViSKIWuFND6F44IGMsMQgurmeEOCHvNSYRGSCo+6h1ZNQKxO3
 /S/G+dZvGbyK+RFG2IN4aeTvMJ9yiicxYPn9EJQSqFD2i/vwTtmkR+L0mGR/b9JzAnuqA3
 /VrGMSxG4m3/Zmky25Z19q6EYEYPA2c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-qTVUT-YNMAqPgT9YsSTz0A-1; Tue, 16 Jul 2024 02:26:33 -0400
X-MC-Unique: qTVUT-YNMAqPgT9YsSTz0A-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-58e66895fd5so3939964a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 23:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721111191; x=1721715991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6G37f4sW3LOcb3ZtcTnGAv9MUTfDiExVXey3IX3QaVA=;
 b=JZIPZ1vB5Wx4PaJWzfYKiCeR43R7j+tagOQQ79ChCINXX6DFWNCUg7nHTG0Psvn0bK
 bBvZxB4GwZ2UpSO4S2pQJD36NGzsGphYKw+5L7xJQ1FC3ykqpYobp/VX6wfXK7xXQrBQ
 kewEstaNLbD+GnC+UQ8MPxei27zVPV5ft/3vE5gAFvcyRWw9XQwuafRG8LeOhp5oNbk+
 MrPc2hFJYpgohTSsFkxuVY4FkIq5dUm27+37VHlIFbAKQYAhns3tj0yOIkhsBnpFTmjx
 8SlaugP+bXBQOUKXKlWHdVr7vYtqBX14sngO79uInmERg4HighqFkLdx9h+OjhpMtQs5
 fj9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUZpeU/9F94PG7WQLm4vIOBfFDZhlVuP9MOMfixysikqRuXB7qel6pucteQTR7uuKfIsWZMW0s1N0DDAOpIOKXbPimqYU=
X-Gm-Message-State: AOJu0Yz68d+QGuX/KDMB+So7CqKQjixMWy9cpcJGA5XfZeXmq4Sqqokk
 rNTh23231lXaGiUYk4mvdoDH7vBOFrzxZRLnOxD6dDHfzEOCZkaiv8/4IJNSVpBfKncXasm26cA
 9O9Ct/fwJtRb4fYJ+Z5CMFbyPqUrQyPr6IjJXi5hw5TbZBMF9PlpTR+WcndQu2AEKdPGVysOBS4
 Xgvg5lkgPTeZZFQx3bj25RuFC+Dzt4+ghGTnVhzA==
X-Received: by 2002:a05:6402:34ce:b0:582:5195:3a79 with SMTP id
 4fb4d7f45d1cf-59eee54acb7mr790686a12.6.1721111190770; 
 Mon, 15 Jul 2024 23:26:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFlNg1qOuMS+P10DFLjbwHnHH/dP8usS5w2W6bFDBj5wto4Qk02srw9O6ceXkuua630PLH6I5NHJ7guGwZJXs=
X-Received: by 2002:a05:6402:34ce:b0:582:5195:3a79 with SMTP id
 4fb4d7f45d1cf-59eee54acb7mr790671a12.6.1721111190378; Mon, 15 Jul 2024
 23:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240702020033.139261-1-lulu@redhat.com>
 <20240702020033.139261-2-lulu@redhat.com>
 <CACGkMEs309Hy39VF6GOZhM8D3p47r-qsWERf3CBStb8XMZhUsA@mail.gmail.com>
In-Reply-To: <CACGkMEs309Hy39VF6GOZhM8D3p47r-qsWERf3CBStb8XMZhUsA@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 16 Jul 2024 14:25:53 +0800
Message-ID: <CACLfguWFsSp3RnhD5uwj+K+qJ=njXASE2qDk72pW-DNCGF6T=A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] virtio-pci: Fix the use of an uninitialized irqfd
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, 2 Jul 2024 at 15:09, Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Jul 2, 2024 at 10:00=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > The crash was reported in MAC OS and NixOS, here is the link for this b=
ug
> > https://gitlab.com/qemu-project/qemu/-/issues/2334
> > https://gitlab.com/qemu-project/qemu/-/issues/2321
> >
> > The root cause is the function virtio_pci_set_guest_notifiers() was not=
 called
> > in the virtio_input device.
>
> Note that the above two issues seem to be virtio-console instead of
> virtio-input.
>
but As I debug, this device they are using is virtio-input, not virtio-cons=
ole
> And we need to tweak the above a little bit for example what does "in
> the virtio_input device" mean. For example does it mean irqfd is not
> used etc.
>
sure will fix this
> > So the vector_irqfd was not initialized
> >
> > So the fix is add the check for vector_irqfd in virtio_pci_get_notifier=
()
>
> Probably "fix is adding".
>
sure will fix this
thanks
cindy
> > The function virtio_pci_get_notifier() can also be used while vdev->sta=
tus
> > is not VIRTIO_CONFIG_S_DRIVER_OK. In that case, the vector_irqfd could =
be NULL.
> > So also add the status check here.
>
> Let's explain why this is safe, for example, does it mean the
> notifiers initialization will be delayed to DRIVER_OK?
>
sure ,will fix this
thanks
cindy
> >
> > This fix is verified in vyatta,MacOS,NixOS,fedora system.
> >
> > The bt tree for this bug is:
> > Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> > kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c=
:817
> > 817         if (irqfd->users =3D=3D 0) {
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
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index b1d02f4b3d..6b62165ef6 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -860,6 +860,9 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy *=
proxy, int queue_no,
> >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >      VirtQueue *vq;
> >
> > +    if (!proxy->vector_irqfd && vdev->status & VIRTIO_CONFIG_S_DRIVER_=
OK)
> > +        return -1;
> > +
> >      if (queue_no =3D=3D VIRTIO_CONFIG_IRQ_IDX) {
> >          *n =3D virtio_config_get_guest_notifier(vdev);
> >          *vector =3D vdev->config_vector;
> > --
> > 2.45.0
>
> Thanks
>


