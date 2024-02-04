Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8E3C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 01:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRc6-0007lA-Tz; Sat, 03 Feb 2024 20:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRc4-0007l2-Of
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:48:04 -0500
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRc2-0007vG-VZ
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:48:04 -0500
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7bed9fb159fso143331539f.1
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 17:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707011280; x=1707616080; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9Af0JKhIyYtTtnZCpBqVwVTAUcYQy3gvkAHi8QOUoM=;
 b=IneB11doX3N7LsuU08ffYKcgrhSlrQmxLYnoctF00nZsi4cRsniTrmJL7x1+c0co5K
 2m5OHeZjCxftPFIUBYKgWpW4WvJwfYWv/jD9LEBXuwy4VqSzwuHlWQdLpHki5QnwiFIm
 snH1jO5IM5pTp64PJCq5LPYXWHDEM+BrONaLhAEcWgut89LuFgwh6wfyGRbJGQCIIGkd
 KkrlpA8ayYUKnSjcjxafRb9vHyiqMiKhozgC5k/7f/THTy6SgOIadpMlxN3+yVnH0Ii7
 MWyfKFi5va/IZX/FpY0nAda6BDU2ySPu+3e/eUujYUVeNkw4OLAvQwe1iHnHoLuX8+nW
 Xm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707011280; x=1707616080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9Af0JKhIyYtTtnZCpBqVwVTAUcYQy3gvkAHi8QOUoM=;
 b=WH4u0tYrai33UEHZTUrrmk1nK3lBawJUP9CNa/wWEbKF4uMv5TjT3HMgWz8uUlGk3Q
 j/bdLwwOIeacnR/9h3Gs0tREzerDEWSd0u19GEEt41XneUaOkAE2Gn4nYb33WZVXbefy
 SR9R7ScObyXEbHe6Wb4OoarqQ7UF1cAktCLExCuf6iLPGlBRFH6ReNyG3OsrCgJde3qP
 pVosOOv1hxHHmBWPgCr6CwpybzHC9Sg6qi9F5SOMtVAjAtHOSoGthV0yzghICQeK7y8e
 r+mxkX7/G0/egFYEIU0ttJgg0l9tfNv0sE9QM+HIpqpkdI6bt+fI13Tz2uyn6ENXGl+Q
 O/xA==
X-Gm-Message-State: AOJu0YxTC8cQpg1D2w1COLMuSVhnObIDlaa6HZDaFyE+alAIBbS+HOSI
 ONIAO/gLDPnlNZ3bAumD1/cetzZbaLwJ5+O1jDxziPoJK1DBRGTnEBNXJIPZVWndKArFz/JTM6c
 jOrcSrGDHrmz4pAxBfHO2JHrEO6A=
X-Google-Smtp-Source: AGHT+IHhLZ7gp+WUiNr/KUUpNSXh0IS9zADQMDsfWjHkNGW21dOg3hgWYVdB4gGfLn7ituOT0V2XJ9zpnU3ira5e/54=
X-Received: by 2002:a5d:8acf:0:b0:7bf:fd6a:dba4 with SMTP id
 e15-20020a5d8acf000000b007bffd6adba4mr14312858iot.5.1707011279753; Sat, 03
 Feb 2024 17:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-11-david@redhat.com>
In-Reply-To: <20240202215332.118728-11-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 20:47:49 -0500
Message-ID: <CAFubqFvfe5nZusDaSTVbLJ5rmpE2OGx_PyT=D1PSSdSS4HZsTg@mail.gmail.com>
Subject: Re: [PATCH v1 10/15] libvhost-user: Factor out search for memory
 region by GPA and simplify
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2f.google.com
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

On Fri, Feb 2, 2024 at 4:54=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> Memory regions cannot overlap, and if we ever hit that case something
> would be really flawed.
>
> For example, when vhost code in QEMU decides to increase the size of memo=
ry
> regions to cover full huge pages, it makes sure to never create overlaps,
> and if there would be overlaps, it would bail out.
>
> QEMU commits 48d7c9757749 ("vhost: Merge sections added to temporary
> list"), c1ece84e7c93 ("vhost: Huge page align and merge") and
> e7b94a84b6cb ("vhost: Allow adjoining regions") added and clarified that
> handling and how overlaps are impossible.
>
> Consequently, each GPA can belong to at most one memory region, and
> everything else doesn't make sense. Let's factor out our search to prepar=
e
> for further changes.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 79 +++++++++++++----------
>  1 file changed, 45 insertions(+), 34 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index 22154b217f..d036b54ed0 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -195,30 +195,47 @@ vu_panic(VuDev *dev, const char *msg, ...)
>       */
>  }
>
> +/* Search for a memory region that covers this guest physical address. *=
/
> +static VuDevRegion *
> +vu_gpa_to_mem_region(VuDev *dev, uint64_t guest_addr)
> +{
> +    unsigned int i;
> +
> +    /*
> +     * Memory regions cannot overlap in guest physical address space. Ea=
ch
> +     * GPA belongs to exactly one memory region, so there can only be on=
e
> +     * match.
> +     */
> +    for (i =3D 0; i < dev->nregions; i++) {
> +        VuDevRegion *cur =3D &dev->regions[i];
> +
> +        if (guest_addr >=3D cur->gpa && guest_addr < cur->gpa + cur->siz=
e) {
> +            return cur;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  /* Translate guest physical address to our virtual address.  */
>  void *
>  vu_gpa_to_va(VuDev *dev, uint64_t *plen, uint64_t guest_addr)
>  {
> -    unsigned int i;
> +    VuDevRegion *r;
>
>      if (*plen =3D=3D 0) {
>          return NULL;
>      }
>
> -    /* Find matching memory region.  */
> -    for (i =3D 0; i < dev->nregions; i++) {
> -        VuDevRegion *r =3D &dev->regions[i];
> -
> -        if ((guest_addr >=3D r->gpa) && (guest_addr < (r->gpa + r->size)=
)) {
> -            if ((guest_addr + *plen) > (r->gpa + r->size)) {
> -                *plen =3D r->gpa + r->size - guest_addr;
> -            }
> -            return (void *)(uintptr_t)
> -                guest_addr - r->gpa + r->mmap_addr + r->mmap_offset;
> -        }
> +    r =3D vu_gpa_to_mem_region(dev, guest_addr);
> +    if (!r) {
> +        return NULL;
>      }
>
> -    return NULL;
> +    if ((guest_addr + *plen) > (r->gpa + r->size)) {
> +        *plen =3D r->gpa + r->size - guest_addr;
> +    }
> +    return (void *)(uintptr_t)guest_addr - r->gpa + r->mmap_addr +
> +           r->mmap_offset;
>  }
>
>  /* Translate qemu virtual address to our virtual address.  */
> @@ -854,8 +871,8 @@ static inline bool reg_equal(VuDevRegion *vudev_reg,
>  static bool
>  vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>      VhostUserMemoryRegion m =3D vmsg->payload.memreg.region, *msg_region=
 =3D &m;
> -    unsigned int i;
> -    bool found =3D false;
> +    unsigned int idx;
> +    VuDevRegion *r;
>
>      if (vmsg->fd_num > 1) {
>          vmsg_close_fds(vmsg);
> @@ -882,28 +899,22 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>      DPRINT("    mmap_offset      0x%016"PRIx64"\n",
>             msg_region->mmap_offset);
>
> -    for (i =3D 0; i < dev->nregions; i++) {
> -        if (reg_equal(&dev->regions[i], msg_region)) {
> -            VuDevRegion *r =3D &dev->regions[i];
> -
> -            munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_of=
fset);
> -
> -            /* Shift all affected entries by 1 to close the hole at inde=
x. */
> -            memmove(dev->regions + i, dev->regions + i + 1,
> -                    sizeof(VuDevRegion) * (dev->nregions - i - 1));
> -            DPRINT("Successfully removed a region\n");
> -            dev->nregions--;
> -            i--;
> -
> -            found =3D true;
> -            break;
> -        }
> -    }
> -
> -    if (!found) {
> +    r =3D vu_gpa_to_mem_region(dev, msg_region->guest_phys_addr);
> +    if (!r || !reg_equal(r, msg_region)) {
> +        vmsg_close_fds(vmsg);
>          vu_panic(dev, "Specified region not found\n");
> +        return false;
>      }
>
> +    munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
> +
> +    idx =3D r - dev->regions;
> +    assert(idx < dev->nregions);
> +    /* Shift all affected entries by 1 to close the hole. */
> +    memmove(r, r + 1, sizeof(VuDevRegion) * (dev->nregions - idx - 1));
> +    DPRINT("Successfully removed a region\n");
> +    dev->nregions--;
> +
>      vmsg_close_fds(vmsg);
>
>      return false;
> --
> 2.43.0
>
>

