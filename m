Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0B1CF538B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bpu-00047c-Oo; Wed, 23 Oct 2024 09:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1t3bpt-00047H-3Q
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1t3bpn-0008GD-LJ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729691720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwSgqKZF8hX7pTgA974OCEKKDOfh7P+iiIi/1Cvf3Ts=;
 b=bkGrs5PRYIQvybHs7URfipScWpyn98yEOgbEoLdh/Q6HUpEiuOLpswK/q75GAzrsxN+7CN
 Fn9axH94U6SkpTQ2BRhmKrCoCX8cZL64hdxTd+zqvgXVwsUe0ViwcwpuO5obVq6TB3kSDK
 0tOd+fOGMUedmCx3YyhBE8JyDq9GN7s=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-o-PCkVyWNv61cPyK0t10Fg-1; Wed, 23 Oct 2024 09:55:18 -0400
X-MC-Unique: o-PCkVyWNv61cPyK0t10Fg-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-83ab67710b5so84500639f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 06:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729691718; x=1730296518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwSgqKZF8hX7pTgA974OCEKKDOfh7P+iiIi/1Cvf3Ts=;
 b=MI93qGXNE0h1comrONoEH9tPxjTfX5Mv+HkW44y14owFDM42U7+vfDo64VtKy3P42K
 j/LqtCsRMXY4ME4y79/VNUF9n6szQi+gecDM7R1jNwqsrUNwq5x9BpX1PD5Io7VsEkEZ
 AWbkYCYO2s9BtUIUSija6twZqQx/y1SsB8Z8Fy9cdbTXL9zU0bw5QBMHU5BKn5gLTzW3
 78+CzpD5nQ0wmcWR5XSU3BgeOuQZ3mf4m2P/iFyvPJjjrWjA3aMQ202M8N7bvKmhiMA3
 MKJ2R4cDL7cDl2l720nr/0vkysTTlKRX1JP5+hH1Eek+d8VwrBYVQ1SZjp8lOIc0A1pu
 i9tg==
X-Gm-Message-State: AOJu0YzFpsIais7eeay86icAPvpZOAhaaHKFYT+AAXjCpZap9UNx+h4H
 uT6Hmua6/xTeF9GUKuaSsu8fQ9CehLc5Qxbh+3MPcS+mIcuFw3WkSYuNYabWpZc9ZHMCsnh2UNE
 DyajslhvpM0juo0QdCXZzoBzKmxJKRme7tJAy5quGigbMsE4fnlsu
X-Received: by 2002:a6b:e60e:0:b0:83a:acf9:fa03 with SMTP id
 ca18e2360f4ac-83af643d2d9mr63357139f.5.1729691717892; 
 Wed, 23 Oct 2024 06:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWQiljIS+7aZ5SaRC94wMr4/n3e2IwiU5/lwcxyd5mXNXx/jQhgbXPOlyHWOfU97a0SeftXQ==
X-Received: by 2002:a6b:e60e:0:b0:83a:acf9:fa03 with SMTP id
 ca18e2360f4ac-83af643d2d9mr63356339f.5.1729691717470; 
 Wed, 23 Oct 2024 06:55:17 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc2a631e42sm2042207173.154.2024.10.23.06.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:55:16 -0700 (PDT)
Date: Wed, 23 Oct 2024 07:55:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com
Subject: Re: [PATCH 2/2] vfio/helpers: Align mmaps
Message-ID: <20241023075515.352efa25.alex.williamson@redhat.com>
In-Reply-To: <d65cf179-21e6-4cda-baae-57fde73807cf@redhat.com>
References: <20241022200830.4129598-1-alex.williamson@redhat.com>
 <20241022200830.4129598-3-alex.williamson@redhat.com>
 <d65cf179-21e6-4cda-baae-57fde73807cf@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 23 Oct 2024 14:44:19 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> On 10/22/24 22:08, Alex Williamson wrote:
> > Thanks to work by Peter Xu, support is introduced in Linux v6.12 to
> > allow pfnmap insertions at PMD and PUD levels of the page table.  This
> > means that provided a properly aligned mmap, the vfio driver is able
> > to map MMIO at significantly larger intervals than PAGE_SIZE.  For
> > example on x86_64 (the only architecture currently supporting huge
> > pfnmaps for PUD), rather than 4KiB mappings, we can map device MMIO
> > using 2MiB and even 1GiB page table entries.
> >=20
> > Typically mmap will already provide PMD aligned mappings, so devices
> > with moderately sized MMIO ranges, even GPUs with standard 256MiB BARs,
> > will already take advantage of this support.  However in order to better
> > support devices exposing multi-GiB MMIO, such as 3D accelerators or GPUs
> > with resizable BARs enabled, we need to manually align the mmap.
> >=20
> > There doesn't seem to be a way for userspace to easily learn about PMD
> > and PUD mapping level sizes, therefore this takes the simple approach
> > to align the mapping to the power-of-two size of the region, up to 1GiB,
> > which is currently the maximum alignment we care about. =20
>=20
>=20
> Couldn't we inspect /sys/kernel/mm/hugepages/ to get the sizes ?

Sifting through sysfs doesn't seem like a great solution if we want to
support running QEMU in a sandbox with limited access, but also
hugepage sizes don't seem to strictly map to PMD and PUD page table
levels on all platforms.  For instance ARM seems to support an
assortment of hugepage sizes, some of which appear to be available via
contiguous page hinting rather than actual page table level sizes.  At
that point we're still approximating the actual discrete mapping
intervals, but at a substantial increase in complexity, unless we
already have dependencies and existing code that can be leveraged.

> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com> =20
>=20
> anyhow,
>=20
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Thanks!

Alex
=20
> > ---
> >   hw/vfio/helpers.c | 32 ++++++++++++++++++++++++++++++--
> >   1 file changed, 30 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> > index b9e606e364a2..913796f437f8 100644
> > --- a/hw/vfio/helpers.c
> > +++ b/hw/vfio/helpers.c
> > @@ -27,6 +27,7 @@
> >   #include "trace.h"
> >   #include "qapi/error.h"
> >   #include "qemu/error-report.h"
> > +#include "qemu/units.h"
> >   #include "monitor/monitor.h"
> >  =20
> >   /*
> > @@ -406,8 +407,35 @@ int vfio_region_mmap(VFIORegion *region)
> >       prot |=3D region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRIT=
E : 0;
> >  =20
> >       for (i =3D 0; i < region->nr_mmaps; i++) {
> > -        region->mmaps[i].mmap =3D mmap(NULL, region->mmaps[i].size, pr=
ot,
> > -                                     MAP_SHARED, region->vbasedev->fd,
> > +        size_t align =3D MIN(1ULL << ctz64(region->mmaps[i].size), 1 *=
 GiB);
> > +        void *map_base, *map_align;
> > +
> > +        /*
> > +         * Align the mmap for more efficient mapping in the kernel.  I=
deally
> > +         * we'd know the PMD and PUD mapping sizes to use as discrete =
alignment
> > +         * intervals, but we don't.  As of Linux v6.12, the largest PU=
D size
> > +         * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is=
 only set
> > +         * on x86_64).  Align by power-of-two size, capped at 1GiB.
> > +         *
> > +         * NB. qemu_memalign() and friends actually allocate memory, w=
hereas
> > +         * the region size here can exceed host memory, therefore we m=
anually
> > +         * create an oversized anonymous mapping and clean it up for a=
lignment.
> > +         */
> > +        map_base =3D mmap(0, region->mmaps[i].size + align, PROT_NONE,
> > +                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +        if (map_base =3D=3D MAP_FAILED) {
> > +            ret =3D -errno;
> > +            goto no_mmap;
> > +        }
> > +
> > +        map_align =3D (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t=
)align);
> > +        munmap(map_base, map_align - map_base);
> > +        munmap(map_align + region->mmaps[i].size,
> > +               align - (map_align - map_base));
> > +
> > +        region->mmaps[i].mmap =3D mmap(map_align, region->mmaps[i].siz=
e, prot,
> > +                                     MAP_SHARED | MAP_FIXED,
> > +                                     region->vbasedev->fd,
> >                                        region->fd_offset +
> >                                        region->mmaps[i].offset);
> >           if (region->mmaps[i].mmap =3D=3D MAP_FAILED) { =20
>=20


