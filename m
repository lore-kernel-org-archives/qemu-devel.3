Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B11CC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 03:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBRHS-0007Vl-Ko; Sun, 26 May 2024 23:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sBRHK-0007V1-Vg
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sBRHI-00019K-Ik
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716781443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FewZXNcwkcwS0omzM5TAlzTtsmcNA5y3gORAUIAy8x0=;
 b=CAWjpFyO964JUNt7oWADIqrSx3h9tYcnZG597AqaX2rRZXfATj1iX2iimiE8EpkeSx/KwS
 lBrQny4waUoqElRdfIMzBjYwcX2Ql90K9pFMOzyoFXslepwOt3ItUvlh3Cz/kkats/DuFw
 gTzjR8FWVDk8Q2hR2tCoETGe42Ebp9k=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527--rYVeGbkME-lkCtsyuwOzA-1; Sun, 26 May 2024 23:43:59 -0400
X-MC-Unique: -rYVeGbkME-lkCtsyuwOzA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-667fd2bf4feso3930122a12.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 20:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716781438; x=1717386238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FewZXNcwkcwS0omzM5TAlzTtsmcNA5y3gORAUIAy8x0=;
 b=lQWHMAz/5w9YLepDMLLkS5ComFe7ou5Ak3ZBDExCU7TnTVn1Tv5UIGZVWOY4kBvHpe
 1D122EZqvA7H8j+ry8ngN+lG1J21eCxQW8IVB574M9ZAFc37qK7QMCSVK2JYu4FmrCaH
 n+JEXMugf6vyLbFsz6oAvPBtytbVRS6pOPSe3wFhjp7Z7kGre2wS+w1nlYY8MNCKrVRZ
 x+ppmLpIBm89yh3mgkxh3xncO1wQeHo60ALov3ja74cV/aJe4hVCuEYI0fwiZ0Q9KmO4
 eV/doi6c95TsvLdgbtLLJVfGE4FN31GN44l2Yc+hQymxTcut6fdP/zJDonY49xUFNmKe
 uFug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrOy45rHLSDUHQX1fwZs9/VaiJWluE8/7duwIXxmiBoinORQZ6sQ2J/xH9fsYvUdjFjRFCmC4IylIWzotE26Cl1T98YVc=
X-Gm-Message-State: AOJu0Yz7UQ3JqG7/fZyIj0SdHyysRTNj/8mae0UsEec9hEohTZ4UR0YE
 BEcGQBGtEHgAGthQsKZQ96L0Bq0+jArzPLYaB5o0qo2jc/I7KTqDFpyCQWG3AX5pvzt4zv2aXXK
 EmW8kVo7wOx0B3IFXCFJwN1UxZQPQI2chD+lgVHeurUKeVlP9X5yBRwHlTFrKN0BML2/GvNXzMF
 3ZFZdP4T2K4xMBVyjX4XkSgb87Bd4=
X-Received: by 2002:a05:6a20:5603:b0:1af:d2f8:382a with SMTP id
 adf61e73a8af0-1b212d4a2b7mr8513920637.34.1716781438236; 
 Sun, 26 May 2024 20:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgJaO4JACiaXg/tJuR0umkLGbl2K829N7C7dApMIUvIFdAOwSi0SLHvnwtcnffcPN66xx/Io8i+05brpICtTI=
X-Received: by 2002:a05:6a20:5603:b0:1af:d2f8:382a with SMTP id
 adf61e73a8af0-1b212d4a2b7mr8513908637.34.1716781437732; Sun, 26 May 2024
 20:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240522051042.985825-1-lulu@redhat.com>
In-Reply-To: <20240522051042.985825-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 May 2024 11:43:46 +0800
Message-ID: <CACGkMEsUY=X8vGGRmUcvpieNtfcmFEKW-AYzbv_vcL3UNQkPTg@mail.gmail.com>
Subject: Re: [PATCH] virtio-pci: Fix the use of an uninitialized irqfd.
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, May 22, 2024 at 1:10=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The crash was reported in MAC OS and NixOS, here is the link for this bug
> https://gitlab.com/qemu-project/qemu/-/issues/2334
> https://gitlab.com/qemu-project/qemu/-/issues/2321
>
> The root cause is that the function virtio_pci_set_guest_notifiers() only
> initializes the irqfd when the use_guest_notifier_mask and guest_notifier=
_mask
> are set.
> However, this check is missing in virtio_pci_set_vector().
> So the fix is to add this check.
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
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/virtio-pci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index b1d02f4b3d..a7faee5b33 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1431,6 +1431,7 @@ static void virtio_pci_set_vector(VirtIODevice *vde=
v,
>  {
>      bool kvm_irqfd =3D (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
>          msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
> +    VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>
>      if (new_vector =3D=3D old_vector) {
>          return;
> @@ -1441,7 +1442,8 @@ static void virtio_pci_set_vector(VirtIODevice *vde=
v,
>       * set, we need to release the old vector and set up the new one.
>       * Otherwise just need to set the new vector on the device.
>       */
> -    if (kvm_irqfd && old_vector !=3D VIRTIO_NO_VECTOR) {
> +    if (kvm_irqfd && old_vector !=3D VIRTIO_NO_VECTOR &&
> +        vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
>          kvm_virtio_pci_vector_release_one(proxy, queue_no);
>      }
>      /* Set the new vector on the device. */
> @@ -1451,7 +1453,8 @@ static void virtio_pci_set_vector(VirtIODevice *vde=
v,
>          virtio_queue_set_vector(vdev, queue_no, new_vector);
>      }
>      /* If the new vector changed need to set it up. */
> -    if (kvm_irqfd && new_vector !=3D VIRTIO_NO_VECTOR) {
> +    if (kvm_irqfd && new_vector !=3D VIRTIO_NO_VECTOR &&
> +        vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
>          kvm_virtio_pci_vector_use_one(proxy, queue_no);
>      }
>  }
> --
> 2.43.0
>


