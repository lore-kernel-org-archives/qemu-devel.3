Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF97CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqXl-0002Uv-5c; Mon, 20 Oct 2025 10:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vAqXj-0002UW-AE
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vAqXf-0006af-KU
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760969235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4T6WXifuoHiTbI5bT6KA08RlAabe17r5hMhCM7ERp7E=;
 b=OGIGGCXttR+CCWqE2maxLI9Xe0gzJ5hKkmkubI57QO/sovgQ6MErq97pXge+NRgQay4XWS
 cqaT45zDLSIL2cWouuqK5bq63zmUZwRZxppSojQSAifWrFk8CNu3sLm7x0XRKgFG15T1nT
 4KR4Y3Rlw6wf7l3J9HnfXp4qsM1seRI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-nN3qAqgpM5qex1093-PYQw-1; Mon, 20 Oct 2025 10:07:14 -0400
X-MC-Unique: nN3qAqgpM5qex1093-PYQw-1
X-Mimecast-MFC-AGG-ID: nN3qAqgpM5qex1093-PYQw_1760969231
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-290da17197eso52151695ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760969231; x=1761574031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4T6WXifuoHiTbI5bT6KA08RlAabe17r5hMhCM7ERp7E=;
 b=OgSpYMtZc0hs5AG5SzJgEnQYQX8P0sPV2rSFzh/YnDs2Q3FuOskJnjQ/jH7Cb4Z31h
 QfqmTJUNYzkVGBVBr4knucwrj+kKM6NFvjOaL+1H9ubGxmj5Tu9siechzHTV/1sp7N/W
 LMnRv+H7KsAm3D7o/2DnZrbKKA4E+Q+SYgNuQt+EQvhhp612LOv7efBmYS7/31oUGvUp
 j2fHAe/6IZ7Xb9BUdYr9d6U+bTf4tRmcsHVAi6l8yNsLKk5uoCAR1ZVpH05MGw+i0G8k
 sUY05FNfMdeBzBzrRhPsxXQUzUwdvv9r64ly3i4gdVqNJOJQR0qC6QOnlN1N4oEbGxo0
 o6RQ==
X-Gm-Message-State: AOJu0Yypa+QIBgn/jBSa49qqpg8dd/nPMIO2BpVg9qUKOT7lefu5rh/p
 +TRHkKGEjZcrsaY5nIlwyPEMxh/mYsOUco9CqUu9ccxrJKxf084hp0j1VPZirK9P/z8GnqunYks
 Tyvw+RYPuwI3AypgTMVRz291w2FXECvRvhz7eTQ85vdgrfR/c/UVLJVNl6eZn1btHJmG63e0Vid
 QmfHvfwZGGJqnsxSSX2bEVYgXWMd5p0iNZpxrNyyA=
X-Gm-Gg: ASbGncubTLo9C4iW0mQSg4Mi4336oZlJNFahxkz8nJZdRQsZn/P8irzsAGbhrDAg6NW
 WxLpjPQTMdvaHREO7HjY6e17idMDEftwXrvcSFajYeEc5GPVpC6IS0cDs9LZbLYqDPNMFj+l1dr
 h4rAW5NPYFluBML2qnb+UGukH84UMB0cpmlpNTWo5wGLhUbaGAD4I=
X-Received: by 2002:a17:903:15ce:b0:273:ab5f:a507 with SMTP id
 d9443c01a7336-290c9cd9f34mr153925925ad.21.1760969230559; 
 Mon, 20 Oct 2025 07:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY5emj6kXjT6DuzK7WiAm3VEwztB0Lzp79cdf2BDxa2N+gLPdrZmuGGbcuXCmyjpY2VlOW89rPSNJ83gbbL3o=
X-Received: by 2002:a17:903:15ce:b0:273:ab5f:a507 with SMTP id
 d9443c01a7336-290c9cd9f34mr153925545ad.21.1760969230076; Mon, 20 Oct 2025
 07:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016143827.1850397-2-aesteve@redhat.com>
 <a74da624-8665-46d6-846d-15fc932775cc@redhat.com>
In-Reply-To: <a74da624-8665-46d6-846d-15fc932775cc@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 20 Oct 2025 16:06:58 +0200
X-Gm-Features: AS18NWB8txtxoc38oZWH1QC_Re_lUgx9hMgDCkQ5YYwS8XQnEZOIKTG8Qz5jXCc
Message-ID: <CADSE00+Rp5+YqM7MP2MVJecHmUGHL271eq-2gFgSuFAC_H-cMA@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] vhost-user: Add VirtIO Shared Memory map request
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 hi@alyssa.is, stefanha@redhat.com, jasowang@redhat.com, dbassey@redhat.com, 
 stevensd@chromium.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, slp@redhat.com, manos.pitsidianakis@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 20, 2025 at 3:50=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> > + * Returns: 0 on success, negative errno on failure
> > + */
> > +static int
> > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > +                                    QIOChannel *ioc,
> > +                                    VhostUserHeader *hdr,
> > +                                    VhostUserPayload *payload,
> > +                                    int fd)
> > +{
> > +    VirtioSharedMemory *shmem;
> > +    VhostUserMMap *vu_mmap =3D &payload->mmap;
> > +    VirtioSharedMemoryMapping *existing;
> > +    Error *local_err =3D NULL;
> > +    int ret =3D 0;
> > +
> > +    if (fd < 0) {
> > +        error_report("Bad fd for map");
> > +        ret =3D -EBADF;
> > +        goto send_reply;
> > +    }
> > +
> > +    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> > +        error_report("Device has no VIRTIO Shared Memory Regions. "
> > +                     "Requested ID: %d", vu_mmap->shmid);
> > +        ret =3D -EFAULT;
> > +        goto send_reply;
> > +    }
> > +
> > +    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> > +    if (!shmem) {
> > +        error_report("VIRTIO Shared Memory Region at "
> > +                     "ID %d not found or uninitialized", vu_mmap->shmi=
d);
> > +        ret =3D -EFAULT;
> > +        goto send_reply;
> > +    }
> > +
> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > +        ret =3D -EFAULT;
> > +        goto send_reply;
> > +    }
> > +
> > +    QTAILQ_FOREACH(existing, &shmem->mmaps, link) {
> > +        if (ranges_overlap(existing->offset, existing->len,
> > +                           vu_mmap->shm_offset, vu_mmap->len)) {
> > +            error_report("VIRTIO Shared Memory mapping overlap");
> > +            ret =3D -EFAULT;
> > +            goto send_reply;
> > +        }
> > +    }
> > +
> > +    memory_region_transaction_begin();
>
> My only comment would be whether the
> memory_region_transaction_begin()/memory_region_transaction_commit()
> should be hidden behind some
> virtio_add_shmem_map_start()/virtio_add_shmem_map_end() helpers.
>
> Talking about memory regions in this function sounds odd given that it's
> more an implementation detail hidden by other helpers.
>
> Then, we can also document why these functions exists, and what the
> contract is for calling them.

I understand. I will send a follow up patch with this, and we can
discuss the solution there. Thanks for giving it another spin!

>
> --
> Cheers
>
> David / dhildenb
>


