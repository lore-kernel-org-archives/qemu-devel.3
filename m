Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4CAC4828D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 02:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWS3I-0004zV-Ue; Sat, 03 Feb 2024 21:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWS3H-0004wv-EG
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 21:16:11 -0500
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWS3F-0003ZD-OU
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 21:16:11 -0500
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-363923728aaso14173575ab.0
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 18:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707012968; x=1707617768; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87B8GfHgEwq2b77WZPb7vE0tr2rlpjPNQD3yq8ztpEw=;
 b=kRS/S9q2e0kzrEWmm+a/drGvI2HmPoFax2eIiBeq49IkSNtHp3GWGqkyXosgvcmgMH
 tE8CTbZ2sAa4L9PgJ4yS2WVwmtHg3Ya3b3e0FrfR4To26GuSS5hQF+ZZANfOFZ6VSud4
 CUpu1CUU3Og2fuW/e47MSt1AzQgwlq0uNEU96YFYyDXJ7YzuJQv5wE2r/tjM4MxDMwlV
 VuE8wBfOyvib+Mo26jqcFCzidlPFHCMjlRJFevW3c+7Hqf+JhsfiUXAR/JgGrsIsi5Bx
 KfKQRQuvBMre2QmuqzoUzdxUvDhh2CH7LxxHVZXJgc9+XevSSEJYdPCHtvn9DSgMqtW7
 8MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707012968; x=1707617768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87B8GfHgEwq2b77WZPb7vE0tr2rlpjPNQD3yq8ztpEw=;
 b=C09QE+fBk3p0wWjGrgoKh/3JZT7Eo2AflaxMDtJhxumXL0GnllAMStrGn+NChd5/p6
 MYnxDB6tvkTBNkBMwgfJDOQWLvKxK7fLnf/1k+ZB/ndGUxiNpvkfCb21N7ZTctuVcNKM
 FqkCf+YYTU2l5drEjBYQZqU5L+h2EtTjf+zvCuN3qk02qzZx30N3iuJu7eQl1wsQZk3t
 6LSk2BjFXnSQCFgLJr/ZYq50/hPb23bRODz/WW2sVaWS/KHG0WhcL8nNBA5yPvHCx6/Z
 RaXVU75FnmUbUrp4kjaxITOruAREP5yQ1+nJs6VJJjTzLAkHuZ4CHl2V1AU2H3W+rxkT
 Vycw==
X-Gm-Message-State: AOJu0Ywza2ClFt/iiiw8uhTBn7/BmpIMbt4CHMYJdc+M5U0Lm555WVvM
 WhhYdg3x7KIcbYZYX7L50vhOvvY0t4ta6X/6ZBi3JD7fWLSU6R2ts/UTacLvOaDxl0n6kH2itIj
 t5DNGuI5IC+TXfXftb7O2qTVc9N0=
X-Google-Smtp-Source: AGHT+IFC6E2se0TEf6vn9yJtxgOQ+9HpUwm/d/6pfMImV5ndOY3sMjvmHWM5PM+9v03sFQbwOy/e3GFnBDSpF3Ve5cY=
X-Received: by 2002:a92:c8ce:0:b0:363:c2f9:ff26 with SMTP id
 c14-20020a92c8ce000000b00363c2f9ff26mr1094258ilq.30.1707012968406; Sat, 03
 Feb 2024 18:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-15-david@redhat.com>
In-Reply-To: <20240202215332.118728-15-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 21:15:57 -0500
Message-ID: <CAFubqFt2GV17Vdrm3_sH1j9dkgj084QDdHv57wrJg395J-JrBA@mail.gmail.com>
Subject: Re: [PATCH v1 14/15] libvhost-user: Dynamically remap rings after
 (temporarily?) removing memory regions
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Someone else with more knowledge of the VQ mapping code should also review.

On Fri, Feb 2, 2024 at 4:55=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> Currently, we try to remap all rings whenever we add a single new memory
> region. That doesn't quite make sense, because we already map rings when
> setting the ring address, and panic if that goes wrong. Likely, that
> handling was simply copied from set_mem_table code, where we actually
> have to remap all rings.
>
> Remapping all rings might require us to walk quite a lot of memory
> regions to perform the address translations. Ideally, we'd simply remove
> that remapping.
>
> However, let's be a bit careful. There might be some weird corner cases
> where we might temporarily remove a single memory region (e.g., resize
> it), that would have worked for now. Further, a ring might be located on
> hotplugged memory, and as the VM reboots, we might unplug that memory, to
> hotplug memory before resetting the ring addresses.
>
> So let's unmap affected rings as we remove a memory region, and try
> dynamically mapping the ring again when required.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 107 ++++++++++++++++------
>  1 file changed, 78 insertions(+), 29 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index febeb2eb89..738e84ab63 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -283,10 +283,75 @@ vu_remove_all_mem_regs(VuDev *dev)
>      dev->nregions =3D 0;
>  }
>
> +static bool
> +map_ring(VuDev *dev, VuVirtq *vq)
> +{
> +    vq->vring.desc =3D qva_to_va(dev, vq->vra.desc_user_addr);
> +    vq->vring.used =3D qva_to_va(dev, vq->vra.used_user_addr);
> +    vq->vring.avail =3D qva_to_va(dev, vq->vra.avail_user_addr);
> +
> +    DPRINT("Setting virtq addresses:\n");
> +    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
> +    DPRINT("    vring_used  at %p\n", vq->vring.used);
> +    DPRINT("    vring_avail at %p\n", vq->vring.avail);
> +
> +    return !(vq->vring.desc && vq->vring.used && vq->vring.avail);
> +}
> +
>  static bool

Consider changing the function name to indicate that it may actually map a =
vq?

Maybe vu_maybe_map_vq()?

>  vu_is_vq_usable(VuDev *dev, VuVirtq *vq)
>  {
> -    return likely(!dev->broken) && likely(vq->vring.avail);
> +    if (unlikely(dev->broken)) {
> +        return false;
> +    }
> +
> +    if (likely(vq->vring.avail)) {
> +        return true;
> +    }
> +
> +    /*
> +     * In corner cases, we might temporarily remove a memory region that
> +     * mapped a ring. When removing a memory region we make sure to
> +     * unmap any rings that would be impacted. Let's try to remap if we
> +     * already succeeded mapping this ring once.
> +     */
> +    if (!vq->vra.desc_user_addr || !vq->vra.used_user_addr ||
> +        !vq->vra.avail_user_addr) {
> +        return false;
> +    }
> +    if (map_ring(dev, vq)) {
> +        vu_panic(dev, "remapping queue on access");
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static void
> +unmap_rings(VuDev *dev, VuDevRegion *r)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < dev->max_queues; i++) {
> +        VuVirtq *vq =3D &dev->vq[i];
> +        const uintptr_t desc =3D (uintptr_t)vq->vring.desc;
> +        const uintptr_t used =3D (uintptr_t)vq->vring.used;
> +        const uintptr_t avail =3D (uintptr_t)vq->vring.avail;
> +
> +        if (desc < r->mmap_addr || desc >=3D r->mmap_addr + r->size) {
> +            continue;
> +        }
> +        if (used < r->mmap_addr || used >=3D r->mmap_addr + r->size) {
> +            continue;
> +        }
> +        if (avail < r->mmap_addr || avail >=3D r->mmap_addr + r->size) {
> +            continue;
> +        }
> +
> +        DPRINT("Unmapping rings of queue %d\n", i);
> +        vq->vring.desc =3D NULL;
> +        vq->vring.used =3D NULL;
> +        vq->vring.avail =3D NULL;
> +    }
>  }
>
>  static size_t
> @@ -784,21 +849,6 @@ vu_reset_device_exec(VuDev *dev, VhostUserMsg *vmsg)
>      return false;
>  }
>
> -static bool
> -map_ring(VuDev *dev, VuVirtq *vq)
> -{
> -    vq->vring.desc =3D qva_to_va(dev, vq->vra.desc_user_addr);
> -    vq->vring.used =3D qva_to_va(dev, vq->vra.used_user_addr);
> -    vq->vring.avail =3D qva_to_va(dev, vq->vra.avail_user_addr);
> -
> -    DPRINT("Setting virtq addresses:\n");
> -    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
> -    DPRINT("    vring_used  at %p\n", vq->vring.used);
> -    DPRINT("    vring_avail at %p\n", vq->vring.avail);
> -
> -    return !(vq->vring.desc && vq->vring.used && vq->vring.avail);
> -}
> -
>  static bool
>  generate_faults(VuDev *dev) {
>      unsigned int i;
> @@ -882,7 +932,6 @@ generate_faults(VuDev *dev) {
>
>  static bool
>  vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
> -    int i;
>      VhostUserMemoryRegion m =3D vmsg->payload.memreg.region, *msg_region=
 =3D &m;
>
>      if (vmsg->fd_num !=3D 1) {
> @@ -928,19 +977,9 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>          vmsg->fd_num =3D 0;
>          DPRINT("Successfully added new region in postcopy\n");
>          return true;
> -    } else {
> -        for (i =3D 0; i < dev->max_queues; i++) {
> -            if (dev->vq[i].vring.desc) {
> -                if (map_ring(dev, &dev->vq[i])) {
> -                    vu_panic(dev, "remapping queue %d for new memory reg=
ion",
> -                             i);
> -                }
> -            }
> -        }
> -
> -        DPRINT("Successfully added new region\n");
> -        return false;
>      }
> +    DPRINT("Successfully added new region\n");
> +    return false;
>  }
>
>  static inline bool reg_equal(VuDevRegion *vudev_reg,
> @@ -993,6 +1032,16 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>          return false;
>      }
>
> +    /*
> +     * There might be valid cases where we temporarily remove memory reg=
ions
> +     * to readd them again, or remove memory regions and don't use the r=
ings
> +     * anymore before we set the ring addresses and restart the device.
> +     *
> +     * Unmap all affected rings, remapping them on demand later. This sh=
ould
> +     * be a corner case.
> +     */
> +    unmap_rings(dev, r);
> +
>      munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
>
>      idx =3D r - dev->regions;
> --
> 2.43.0
>
>

