Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0A4CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 08:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unvav-0003p3-Gt; Mon, 18 Aug 2025 04:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1unvat-0003oq-4v
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 04:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1unvaq-0001nQ-7j
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 04:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755507109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmzVKzBbu50Vs3/UReF0cVYForWeSkYzPWfdSoeFqGg=;
 b=dyDeKBqXg1KqBanUsFMl3AlH7Ddy8X2qxbD75k3I8k5mj7he2Z9x29xdY/pRyDg8ZAPcCd
 U+rlXKaoql26kjcT2M3ne/LXhBWnn3JUPUkqq8DxZ/p7hFZxJ2GWAb5K8S1fjX46tMYs61
 a5S/fimIJJpM0OYlYoy3Dwcw6ywUPQY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-szp-GmexPpaPsXYp4mpSzw-1; Mon, 18 Aug 2025 04:51:47 -0400
X-MC-Unique: szp-GmexPpaPsXYp4mpSzw-1
X-Mimecast-MFC-AGG-ID: szp-GmexPpaPsXYp4mpSzw_1755507106
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b4716fb7f2aso3149736a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 01:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755507106; x=1756111906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmzVKzBbu50Vs3/UReF0cVYForWeSkYzPWfdSoeFqGg=;
 b=DYn9J3O0Qrxx2bQ377T6GQEa5yRQPRi6lrtZAJJaNLxkENaToamBDf/4ZJRNGxYc3E
 0cU+jWiFL76zU8gpzjwUoaDO5AsMoX07UyxCCVZbfVCfFa5+Ry4w2Da5YcSG6e4jQj4f
 rvC2zxdSA6KjBcjzbMA2p//wGAURH/D15rYHtF+vDR7d6F6OMe8rwPf7CDWgiSeWGZNV
 9geB5M8PxE/Bn6FUf+DrN86XQh6qaLHOnlTL2Nk1Ezd5YhfMzOKExrTq2EUWlD34C6sp
 0PJHPg3vqXLeQhvdv7tsgRJNdqu82w/ZlC4W/iWkM7GW6SEEn6lYv5nxwKn1hS1mEXmG
 rMFg==
X-Gm-Message-State: AOJu0Ywhkub/+AsF4Qs25tc2JYnsHPXZuFBuKSzBXUlyOimFgmbfMUeU
 nlPbG8Nn+hZA+80HBDgnZZhUJSuHVR3WUKXxcAC0fyre4CnGQfWwU1XRbr6INTbOk/BZkF1+aHG
 AGbKtpY7wlkCKfo7LjUs9fdqkdU8QUvAsUsIbcA0KTcVYOrtbrDzJSg9az3R8dzftTIKxCxX4Py
 IdIZakfy2fsJkhetEl3TL2Zm2rt+wGVGk=
X-Gm-Gg: ASbGncu1/25/MJSRHHSt6Jc3npxaG8q1DxRydGbdhyTaogdBmwfX3+5p52nSYvVG0tQ
 ShT5dd6DXVbUydX86GKIakegEUbdYm5g50rD7RAofvoTPmkHy0yTvkU8A/ixYbbe1ddUQvoiNUH
 9kso9DVY8zWyZ3SZGhneoE
X-Received: by 2002:a17:902:f683:b0:235:f298:cbbd with SMTP id
 d9443c01a7336-2446d741468mr133818965ad.21.1755507106143; 
 Mon, 18 Aug 2025 01:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+zMteHSGcicMED4BF94qIZwK+01dDpmfQNDZ/YdFGwgauTQoHPUk2KdPlpnutsrsY+1xjpdQdsztcVV/aHWw=
X-Received: by 2002:a17:902:f683:b0:235:f298:cbbd with SMTP id
 d9443c01a7336-2446d741468mr133818715ad.21.1755507105707; Mon, 18 Aug 2025
 01:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250814083749.1317197-1-aesteve@redhat.com>
 <20250814083749.1317197-2-aesteve@redhat.com>
 <6fe9163d-5690-4572-98d1-f0a9cfc3cd80@redhat.com>
In-Reply-To: <6fe9163d-5690-4572-98d1-f0a9cfc3cd80@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 18 Aug 2025 10:51:34 +0200
X-Gm-Features: Ac12FXzkLfBIz1tchal2EDURhXyujznVITm1kYTPpQ9uf7O8Y8hNXBBRjqnkzks
Message-ID: <CADSE00LQ_RuoQRgw=bEfVnBStDV9Rm2rEBQ+qo9mL3VRhOG7aw@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] vhost-user: Add VirtIO Shared Memory map request
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, hi@alyssa.is, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, slp@redhat.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 jasowang@redhat.com, 
 stefanha@redhat.com, dbassey@redhat.com, stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 18, 2025 at 9:37=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
>
> > +    /* Map the shared memory region */
> > +    mapped_addr =3D mmap(NULL, len, prot_flags, MAP_SHARED, fd, fd_off=
set);
> > +    if (mapped_addr =3D=3D MAP_FAILED) {
> > +        error_report("Failed to map shared memory region: %s", strerro=
r(errno));
> > +        return NULL;
> > +    }
> > +
> > +    /* Create the VhostUserShmemObject */
> > +    shmem_obj =3D VHOST_USER_SHMEM_OBJECT(
> > +        object_new(TYPE_VHOST_USER_SHMEM_OBJECT));
> > +
> > +    /* Set up object properties */
> > +    shmem_obj->shmid =3D shmid;
> > +    shmem_obj->fd =3D fd;
> > +    shmem_obj->fd_offset =3D fd_offset;
> > +    shmem_obj->shm_offset =3D shm_offset;
> > +    shmem_obj->len =3D len;
> > +    shmem_obj->flags =3D flags;
> > +    shmem_obj->mapped_addr =3D mapped_addr;
> > +
> > +    /* Create MemoryRegion as a child of this object */
> > +    mr =3D g_new0(MemoryRegion, 1);
> > +    g_string_printf(mr_name, "vhost-user-shmem-%d-%" PRIx64, shmid, sh=
m_offset);
> > +
> > +    /* Initialize MemoryRegion with the mapped memory */
> > +    memory_region_init_ram_device_ptr(mr, OBJECT(shmem_obj), mr_name->=
str,
> > +                                      len, mapped_addr);
>
> Oh, why did we go from memory_region_init_ram_from_fd() back to
> memory_region_init_ram_device_ptr() in this series?
>
> I thought having a wrapper object around the memory region would have
> been sufficient to handle the race?

Ah true :facepalm: I was under the impression that I needed mmap for
the read-write
flags, as I went a bit of back and forth for the last version. I was wrong,=
 as
from_fd allows flags as an argument.

Let me send a new quick iteration for this patch with this fixed (and
other small things I saw
myself). Thanks for checking.

>
> --
> Cheers
>
> David / dhildenb
>


