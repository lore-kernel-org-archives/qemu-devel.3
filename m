Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC723C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 07:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOXdw-00083U-7G; Tue, 02 Jul 2024 03:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sOXdq-00082g-2x
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 03:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sOXdl-0002Qr-3A
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 03:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719904164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlbkWWv+fg4clpaqbsRiRukZKF/UNJG6xoaq9oR+9GU=;
 b=Bdmd1R10vCayDW+dMvfdnpJRBGPW3Pj2YCxNei6qflEMqnQ5uhSC1Y/dijmP/8CWRv05qB
 zpGj/JOos5WKdoFK6V0+VMvcyWyzkb30MJoPD7tZpDWJHY5YDyB+HqNwOIVXEDfeGMbu88
 cjX7n92he09GarwgOYwvQlkkp+4DLoI=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-kOtwL83yOpq4lS-7u4IetA-1; Tue, 02 Jul 2024 03:09:15 -0400
X-MC-Unique: kOtwL83yOpq4lS-7u4IetA-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-25cb4261a5cso2056039fac.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 00:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719904154; x=1720508954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlbkWWv+fg4clpaqbsRiRukZKF/UNJG6xoaq9oR+9GU=;
 b=CapmWRJkQRoyg7PaohLck5Hw1sAOMZyXVB69Or/T9iehCCZ2iutgG8Rrfwh1DVaSV+
 19w3RrBodbv+RthZBiAtxowYZTBpqMmCBBtIkvTRhtF5jOLI/vvVBrxmVs7cfwg/Sf+T
 8k/x++pDmwlQdL8EhGrVmBHFcw4rT0mgVJHQThWQpkktjbjP5oJ/0Oc9RwugJDonmSIt
 qJv88Bj7LtaC+EMeIczhx2l05pLuIFPiSSsoNA5DzsLIVIlYQpaWk9XWCPnCoOMCMSCk
 KE0Wkhy5Jis1Bi1uI++g4enY1WkDbIwycjcurNJuxDLDWV7CwypKOBmf+mSs/65b5dbo
 WUmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGbNtekMTkfhIJ14z/rb5TM+XfSv0CyLSW3KfxhbC3+TBQk+HWxug8ymv8+4SePig+GFWNKSl+KPr1lXEplyxBIqYbn+k=
X-Gm-Message-State: AOJu0YwQf+kRQeGBgI/0hBl6Ek7LQ63XGIliIW3V6+CXlibl07qcdYYe
 fAmH29c45CS3E5b2VK3/VkvGwECn+FuTOC0kwPkAMypxN4/1TOsz+w26bLhb2K1zhYOvSuwCdOs
 K22LrOUqXeC5WCakeWDWTROOIcU8iy86lreioMTNHZ9j6J5/8z8oOhqwTD+3Kds5OHEBEMKqUkC
 H6Fvtbm887ccqxomwr/HWu1ZSX8tg=
X-Received: by 2002:a05:6871:3428:b0:24f:dad3:97c with SMTP id
 586e51a60fabf-25db35c0370mr6898157fac.46.1719904154286; 
 Tue, 02 Jul 2024 00:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8KHpC2EzW9Af9MSACtfZquGt63u7pXhGFAha8KPAM8voCdXH6UI8akUxIzX/iXITxv6e5f0zzZgNbgsnBzE4=
X-Received: by 2002:a05:6871:3428:b0:24f:dad3:97c with SMTP id
 586e51a60fabf-25db35c0370mr6898150fac.46.1719904153911; Tue, 02 Jul 2024
 00:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240702020033.139261-1-lulu@redhat.com>
 <20240702020033.139261-2-lulu@redhat.com>
In-Reply-To: <20240702020033.139261-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 2 Jul 2024 15:09:02 +0800
Message-ID: <CACGkMEs309Hy39VF6GOZhM8D3p47r-qsWERf3CBStb8XMZhUsA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] virtio-pci: Fix the use of an uninitialized irqfd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Jul 2, 2024 at 10:00=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> The crash was reported in MAC OS and NixOS, here is the link for this bug
> https://gitlab.com/qemu-project/qemu/-/issues/2334
> https://gitlab.com/qemu-project/qemu/-/issues/2321
>
> The root cause is the function virtio_pci_set_guest_notifiers() was not c=
alled
> in the virtio_input device.

Note that the above two issues seem to be virtio-console instead of
virtio-input.

And we need to tweak the above a little bit for example what does "in
the virtio_input device" mean. For example does it mean irqfd is not
used etc.

> So the vector_irqfd was not initialized
>
> So the fix is add the check for vector_irqfd in virtio_pci_get_notifier()

Probably "fix is adding".

> The function virtio_pci_get_notifier() can also be used while vdev->statu=
s
> is not VIRTIO_CONFIG_S_DRIVER_OK. In that case, the vector_irqfd could be=
 NULL.
> So also add the status check here.

Let's explain why this is safe, for example, does it mean the
notifiers initialization will be delayed to DRIVER_OK?

>
> This fix is verified in vyatta,MacOS,NixOS,fedora system.
>
> The bt tree for this bug is:
> Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:8=
17
> 817         if (irqfd->users =3D=3D 0) {
> (gdb) thread apply all bt
> ...
> Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) "CPU 0/KVM"):
> 0  kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.=
c:817
> 1  kvm_virtio_pci_vector_use_one () at ../qemu-9.0.0/hw/virtio/virtio-pci=
.c:893
> 2  0x00005983657045e2 in memory_region_write_accessor () at ../qemu-9.0.0=
/system/memory.c:497
> 3  0x0000598365704ba6 in access_with_adjusted_size () at ../qemu-9.0.0/sy=
stem/memory.c:573
> 4  0x0000598365705059 in memory_region_dispatch_write () at ../qemu-9.0.0=
/system/memory.c:1528
> 5  0x00005983659b8e1f in flatview_write_continue_step.isra.0 () at ../qem=
u-9.0.0/system/physmem.c:2713
> 6  0x000059836570ba7d in flatview_write_continue () at ../qemu-9.0.0/syst=
em/physmem.c:2743
> 7  flatview_write () at ../qemu-9.0.0/system/physmem.c:2774
> 8  0x000059836570bb76 in address_space_write () at ../qemu-9.0.0/system/p=
hysmem.c:2894
> 9  0x0000598365763afe in address_space_rw () at ../qemu-9.0.0/system/phys=
mem.c:2904
> 10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917
> 11 0x000059836576656e in kvm_vcpu_thread_fn () at ../qemu-9.0.0/accel/kvm=
/kvm-accel-ops.c:50
> 12 0x0000598365926ca8 in qemu_thread_start () at ../qemu-9.0.0/util/qemu-=
thread-posix.c:541
> 13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6
> 14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6
>
> Fixes: 2ce6cff94d ("virtio-pci: fix use of a released vector")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index b1d02f4b3d..6b62165ef6 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -860,6 +860,9 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy *pr=
oxy, int queue_no,
>      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
>      VirtQueue *vq;
>
> +    if (!proxy->vector_irqfd && vdev->status & VIRTIO_CONFIG_S_DRIVER_OK=
)
> +        return -1;
> +
>      if (queue_no =3D=3D VIRTIO_CONFIG_IRQ_IDX) {
>          *n =3D virtio_config_get_guest_notifier(vdev);
>          *vector =3D vdev->config_vector;
> --
> 2.45.0

Thanks


