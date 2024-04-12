Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1F3C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 03:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv7de-000565-Lm; Thu, 11 Apr 2024 23:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rv7dd-00055l-Km
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 23:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rv7db-0000S2-M2
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 23:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712892698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qjugd3lx1YyXYeHgDgwQHurl8fO6DLNSnvm0BcUOtI4=;
 b=KyHAJo8egNS216EvMJIKKT7jhtwYJkdFsZUStdioz9rgzifvWU8PDnhyzLLYeVRxxon9rm
 KVsrKWx6QNtSxpRuNwwC042Vcx/L11J4lo4kMp9/JWy0fkPz8QComHnTIEU5P5j0zfZ+7k
 E69Rvf4n7cYDZb1S3mdUrMH5DU3rFik=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-or8zg-0mOqqr1hn4jAsX5Q-1; Thu, 11 Apr 2024 23:31:36 -0400
X-MC-Unique: or8zg-0mOqqr1hn4jAsX5Q-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5c65e666609so485844a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 20:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712892695; x=1713497495;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qjugd3lx1YyXYeHgDgwQHurl8fO6DLNSnvm0BcUOtI4=;
 b=q6PWFDqPy2NBAxpZtqWUsxpv/hXWCPIjuv9BqVCKlQ+dm1orVpI3xnyc5ASheQ5F6x
 tJ9qJFBCifUY/P+dx1HGqmGYYhQAvDtiZkCpxIM+J54/nSs3lk8OnUKxe9HGRC0VD6J0
 ZA7zz93cNcmn771HOHmkSUwkz4fCHSN+8A3tRzzJiifDk6vOmyIeN3nrQsUQe+LykruW
 WOO3wQ4y1brD0H9PraDQfRytWkRTy3W77ZZ9j4SfH1+Y0OjlK1r2V23peyQpypRITyGl
 9Hj/akC3oVfnYil7/n4nP1bXpSAZGkXjsSfNV0fUoo9OOLqaNicuLpMrlu/VlPHtqOVq
 Vj5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQYm4a9z9O32QAT2zkW5u1tLVKIt1+DwljlALstGhbCRQ6bh7XQjHOm9st/lbd6idJWXIn4cJV0QXUmYpTLG51kRJaOWY=
X-Gm-Message-State: AOJu0YzYaJ5mfQ8UpJY2aFgSTkB1SaLv4FLHC1IgrwGKsZXYWlX0BEg5
 nyU4mjU+NOEit+UyvprmXjGyL8PukSkPcwVxpxv/GnG2XQcQlNIMAA+KAECSCBV/jbfV8uu8DJI
 gDYRgZPlnG1+64QYKMBsjIFJ0x6HuOb6gwcXwX4IQ5n2nxrWY11075JigYMMplMbjfJC5xskzgA
 Iuzj+Q8L8le0hlKD2MoLLaspeAch0=
X-Received: by 2002:a05:6a20:7347:b0:1a9:9cf2:69c0 with SMTP id
 v7-20020a056a20734700b001a99cf269c0mr2006161pzc.34.1712892695613; 
 Thu, 11 Apr 2024 20:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9enC1fAc2wX6lg6nQ2fMBl3LTfchm65NRt7LVsWuttMJ/+d97t/nz2KZvzKcozeSzVfJUhev4W7k5XJYfctg=
X-Received: by 2002:a05:6a20:7347:b0:1a9:9cf2:69c0 with SMTP id
 v7-20020a056a20734700b001a99cf269c0mr2006142pzc.34.1712892695236; Thu, 11 Apr
 2024 20:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240411080237.455060-1-lulu@redhat.com>
In-Reply-To: <20240411080237.455060-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Apr 2024 11:31:24 +0800
Message-ID: <CACGkMEsD_eZ88TpZ91XEjDB6LuZyoy_=keq6d2JvKDzy3ORFKw@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-pci: Fix the crash that the vector was used
 after released.
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 11, 2024 at 4:03=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> During the booting process of the non-standard image, the behavior of the
> called function in qemu is as follows:
>
> 1. vhost_net_stop() was triggered by guest image. This will call the func=
tion
> virtio_pci_set_guest_notifiers() with assgin=3D false,
> virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for vecto=
r 0
>
> 2. virtio_reset() was triggered, this will set configure vector to VIRTIO=
_NO_VECTOR
>
> 3.vhost_net_start() was called (at this time, the configure vector is
> still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers() wi=
th
> assgin=3Dtrue, so the irqfd for vector 0 is still not "init" during this =
process
>
> 4. The system continues to boot and sets the vector back to 0. After that
> msix_fire_vector_notifier() was triggered to unmask the vector 0 and  mee=
t the crash
>
> To fix the issue, we need to support changing the vector after VIRTIO_CON=
FIG_S_DRIVER_OK is set.
>
> (gdb) bt
> 0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsig=
no@entry=3D6, no_tid=3Dno_tid@entry=3D0)
>     at pthread_kill.c:44
> 1  0x00007fc87148ec53 in __pthread_kill_internal (signo=3D6, threadid=3D<=
optimized out>) at pthread_kill.c:78
> 2  0x00007fc87143e956 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/p=
osix/raise.c:26
> 3  0x00007fc8714287f4 in __GI_abort () at abort.c:79
> 4  0x00007fc87142871b in __assert_fail_base
>     (fmt=3D0x7fc8715bbde0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", as=
sertion=3D0x5606413efd53 "ret =3D=3D 0", file=3D0x5606413ef87d "../accel/kv=
m/kvm-all.c", line=3D1837, function=3D<optimized out>) at assert.c:92
> 5  0x00007fc871437536 in __GI___assert_fail
>     (assertion=3D0x5606413efd53 "ret =3D=3D 0", file=3D0x5606413ef87d "..=
/accel/kvm/kvm-all.c", line=3D1837, function=3D0x5606413f06f0 <__PRETTY_FUN=
CTION__.19> "kvm_irqchip_commit_routes") at assert.c:101
> 6  0x0000560640f884b5 in kvm_irqchip_commit_routes (s=3D0x560642cae1f0) a=
t ../accel/kvm/kvm-all.c:1837
> 7  0x0000560640c98f8e in virtio_pci_one_vector_unmask
>     (proxy=3D0x560643c65f00, queue_no=3D4294967295, vector=3D0, msg=3D...=
, n=3D0x560643c6e4c8)
>     at ../hw/virtio/virtio-pci.c:1005
> 8  0x0000560640c99201 in virtio_pci_vector_unmask (dev=3D0x560643c65f00, =
vector=3D0, msg=3D...)
>     at ../hw/virtio/virtio-pci.c:1070
> 9  0x0000560640bc402e in msix_fire_vector_notifier (dev=3D0x560643c65f00,=
 vector=3D0, is_masked=3Dfalse)
>     at ../hw/pci/msix.c:120
> 10 0x0000560640bc40f1 in msix_handle_mask_update (dev=3D0x560643c65f00, v=
ector=3D0, was_masked=3Dtrue)
>     at ../hw/pci/msix.c:140
> 11 0x0000560640bc4503 in msix_table_mmio_write (opaque=3D0x560643c65f00, =
addr=3D12, val=3D0, size=3D4)
>     at ../hw/pci/msix.c:231
> 12 0x0000560640f26d83 in memory_region_write_accessor
>     (mr=3D0x560643c66540, addr=3D12, value=3D0x7fc86b7bc628, size=3D4, sh=
ift=3D0, mask=3D4294967295, attrs=3D...)
>     at ../system/memory.c:497
> 13 0x0000560640f270a6 in access_with_adjusted_size
>
>      (addr=3D12, value=3D0x7fc86b7bc628, size=3D4, access_size_min=3D1, a=
ccess_size_max=3D4, access_fn=3D0x560640f26c8d <memory_region_write_accesso=
r>, mr=3D0x560643c66540, attrs=3D...) at ../system/memory.c:573
> 14 0x0000560640f2a2b5 in memory_region_dispatch_write (mr=3D0x560643c6654=
0, addr=3D12, data=3D0, op=3DMO_32, attrs=3D...)
>     at ../system/memory.c:1521
> 15 0x0000560640f37bac in flatview_write_continue
>     (fv=3D0x7fc65805e0b0, addr=3D4273803276, attrs=3D..., ptr=3D0x7fc871e=
9c028, len=3D4, addr1=3D12, l=3D4, mr=3D0x560643c66540)
>     at ../system/physmem.c:2714
> 16 0x0000560640f37d0f in flatview_write
>     (fv=3D0x7fc65805e0b0, addr=3D4273803276, attrs=3D..., buf=3D0x7fc871e=
9c028, len=3D4) at ../system/physmem.c:2756
> 17 0x0000560640f380bf in address_space_write
>     (as=3D0x560642161ae0 <address_space_memory>, addr=3D4273803276, attrs=
=3D..., buf=3D0x7fc871e9c028, len=3D4)
>     at ../system/physmem.c:2863
> 18 0x0000560640f3812c in address_space_rw
>     (as=3D0x560642161ae0 <address_space_memory>, addr=3D4273803276, attrs=
=3D..., buf=3D0x7fc871e9c028, len=3D4, is_write=3Dtrue) at ../system/physme=
m.c:2873
> --Type <RET> for more, q to quit, c to continue without paging--
> 19 0x0000560640f8aa55 in kvm_cpu_exec (cpu=3D0x560642f205e0) at ../accel/=
kvm/kvm-all.c:2915
> 20 0x0000560640f8d731 in kvm_vcpu_thread_fn (arg=3D0x560642f205e0) at ../=
accel/kvm/kvm-accel-ops.c:51
> 21 0x00005606411949f4 in qemu_thread_start (args=3D0x560642f292b0) at ../=
util/qemu-thread-posix.c:541
> 22 0x00007fc87148cdcd in start_thread (arg=3D<optimized out>) at pthread_=
create.c:442
> 23 0x00007fc871512630 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone3.S:81
> (gdb)
>
> Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> Cc: qemu-stable@nongnu.org
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/virtio-pci.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1a7039fb0c..4f2663b27d 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1423,6 +1423,24 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *=
proxy,
>
>      return offset;
>  }
> +static void virtio_pci_vector_change(VirtIODevice *vdev, VirtIOPCIProxy =
*proxy,
> +                                     int queue_no, uint16_t old_vector,
> +                                     uint16_t new_vector)
> +{
> +    /*
> +     * If the device uses irqfd and the vector changes after DRIVER_OK i=
s
> +     * set, we need to release the old vector and set up the new one.
> +     */
> +    if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +        (msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled())) =
{
> +        if (old_vector !=3D VIRTIO_NO_VECTOR) {
> +            kvm_virtio_pci_vector_release_one(proxy, queue_no);
> +        }
> +        if (new_vector !=3D VIRTIO_NO_VECTOR) {
> +            kvm_virtio_pci_vector_use_one(proxy, queue_no);
> +        }
> +    }
> +}
>
>  int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
>                             uint8_t bar, uint64_t offset, uint64_t length=
,
> @@ -1570,7 +1588,13 @@ static void virtio_pci_common_write(void *opaque, =
hwaddr addr,
>          } else {
>              val =3D VIRTIO_NO_VECTOR;
>          }
> +        vector =3D vdev->config_vector;
>          vdev->config_vector =3D val;
> +        /*check if need to change the vector*/
> +        if (val !=3D vector) {
> +            virtio_pci_vector_change(vdev, proxy, VIRTIO_CONFIG_IRQ_IDX,=
 vector,
> +                                     val);
> +        }
>          break;
>      case VIRTIO_PCI_COMMON_STATUS:
>          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> @@ -1611,6 +1635,11 @@ static void virtio_pci_common_write(void *opaque, =
hwaddr addr,
>              val =3D VIRTIO_NO_VECTOR;
>          }
>          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> +        /*check if need to change the vector*/
> +        if (val !=3D vector) {
> +            virtio_pci_vector_change(vdev, proxy, vdev->queue_sel, vecto=
r, val);
> +        }
> +
>          break;
>      case VIRTIO_PCI_COMMON_Q_ENABLE:
>          if (val =3D=3D 1) {
> --
> 2.43.0
>


