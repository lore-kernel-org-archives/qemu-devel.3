Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68B1C3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 09:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpgM-0007LH-5B; Thu, 11 Jul 2024 05:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpgK-0007Jg-BG
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpgI-00017x-Kp
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720688497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A/6GnO/I+Q4I07ef2+hlsuH5oi+mbNz+xlTRA1nDUqU=;
 b=RdrSg0hhcudsDKbdfKab1tWQyHhLtNHJt2PCDAEkchLbrqc2ZsNWHHvZOHwOvk5ux3gUVn
 FFrcbDk53zmavlurk5Sdl7rC2RqpKo4prIoRw8S5iAwEb+fsYhcDYkJEmJfQwbtCNYDyxS
 iBxqE2Ct2GZEng+qyQlgdUjojVCZbbA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-W8REd7TuMp-mANtzxJSGBw-1; Thu,
 11 Jul 2024 05:01:33 -0400
X-MC-Unique: W8REd7TuMp-mANtzxJSGBw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E25A7196E096; Thu, 11 Jul 2024 09:01:32 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 513483000181; Thu, 11 Jul 2024 09:01:31 +0000 (UTC)
Date: Thu, 11 Jul 2024 11:01:29 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com,
 slp@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20240711090129.GH563880@dynamic-pd01.res.v6.highway.a1.net>
References: <20240628145710.1516121-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O0J94nHQYnbF4MMp"
Content-Disposition: inline
In-Reply-To: <20240628145710.1516121-1-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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


--O0J94nHQYnbF4MMp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 04:57:05PM +0200, Albert Esteve wrote:
> Hi all,
>=20
> v1->v2:
> - Corrected typos and clarifications from
>   first review
> - Added SHMEM_CONFIG frontend request to
>   query VIRTIO shared memory regions from
>   backends
> - vhost-user-device to use SHMEM_CONFIG
>   to request and initialise regions
> - Added MEM_READ/WRITE backend requests
>   in case address translation fails
>   accessing VIRTIO Shared Memory Regions
>   with MMAPs

Hi Albert,
I will be offline next week. I've posted comments.

I think the hard part will be adjusting vhost-user backend code to make
use of MEM_READ/MEM_WRITE when address translation fails. Ideally every
guest memory access (including vring accesses) should fall back to
MEM_READ/MEM_WRITE.

A good test for MEM_READ/MEM_WRITE is to completely skip setting the
memory table from the frontend and fall back for every guest memory
access. If the vhost-user backend still works without a memory table
then you know MEM_READ/MEM_WRITE is working too.

The vhost-user spec should probably contain a comment explaining that
MEM_READ/MEM_WRITE may be necessary when other device backends use
SHMEM_MAP due to the incomplete memory table that prevents translating
those memory addresses. In other words, if the guest has a device that
uses SHMEM_MAP, then all other vhost-user devices should support
MEM_READ/MEM_WRITE in order to ensure that DMA works with Shared Memory
Regions.

Stefan

>=20
> This is an update of my attempt to have
> backends support dynamic fd mapping into VIRTIO
> Shared Memory Regions. After the first review
> I have added more commits and new messages
> to the vhost-user protocol.
> However, I still have some doubts as to
> how will this work, specially regarding
> the MEM_READ and MEM_WRITE commands.
> Thus, I am still looking for feedback,
> to ensure that I am going in the right
> direction with the implementation.
>=20
> The usecase for this patch is, e.g., to support
> vhost-user-gpu RESOURCE_BLOB operations,
> or DAX Window request for virtio-fs. In
> general, any operation where a backend
> need to request the frontend to mmap an
> fd into a VIRTIO Shared Memory Region,
> so that the guest can then access it.
>=20
> After receiving the SHMEM_MAP/UNMAP request,
> the frontend will perform the mmap with the
> instructed parameters (i.e., shmid, shm_offset,
> fd_offset, fd, lenght).
>=20
> As there are already a couple devices
> that could benefit of such a feature,
> and more could require it in the future,
> the goal is to make the implementation
> generic.
>=20
> To that end, the VIRTIO Shared Memory
> Region list is declared in the `VirtIODevice`
> struct.
>=20
> This patch also includes:
> SHMEM_CONFIG frontend request that is
> specifically meant to allow generic
> vhost-user-device frontend to be able to
> query VIRTIO Shared Memory settings from the
> backend (as this device is generic and agnostic
> of the actual backend configuration).
>=20
> Finally, MEM_READ/WRITE backend requests are
> added to deal with a potential issue when having
> any backend sharing a descriptor that references
> a mapping to another backend. The first
> backend will not be able to see these
> mappings. So these requests are a fallback
> for vhost-user memory translation fails.
>=20
> Albert Esteve (5):
>   vhost-user: Add VIRTIO Shared Memory map request
>   vhost_user: Add frontend command for shmem config
>   vhost-user-dev: Add cache BAR
>   vhost_user: Add MEM_READ/WRITE backend requests
>   vhost_user: Implement mem_read/mem_write handlers
>=20
>  docs/interop/vhost-user.rst               |  58 ++++++
>  hw/virtio/vhost-user-base.c               |  39 +++-
>  hw/virtio/vhost-user-device-pci.c         |  37 +++-
>  hw/virtio/vhost-user.c                    | 221 ++++++++++++++++++++++
>  hw/virtio/virtio.c                        |  12 ++
>  include/hw/virtio/vhost-backend.h         |   6 +
>  include/hw/virtio/vhost-user.h            |   1 +
>  include/hw/virtio/virtio.h                |   5 +
>  subprojects/libvhost-user/libvhost-user.c | 149 +++++++++++++++
>  subprojects/libvhost-user/libvhost-user.h |  91 +++++++++
>  10 files changed, 614 insertions(+), 5 deletions(-)
>=20
> --=20
> 2.45.2
>=20

--O0J94nHQYnbF4MMp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaPn2kACgkQnKSrs4Gr
c8i4pwgAlJm1nwKenFksRzclLcU9KYroWqkHCFbAps5EfTJfNp4md7CUyz6onP+D
H+8RA1gX0TZD8yMYfRqodglb8zsn82Xx4WIrHr9Tb+3Sn9V2CAl0C8cBqL94kNlP
3oVSWdtz9waQaGxXMWqKKpH6R97HMCROpuwU6OuZJXqAdZjH4DZBqrWN1+r8ktXo
2K+DHEjLeHT5BXva+WeY5FaN/9V2RygUuG0SqdtK8PbhB14hw5M31wxqkoOZjMQQ
dTibCd5cw8yxglYIzd/PDKYISebT9JEdRadLgGuIDLtGkGLjpWiS1U3rBlEL9x5a
MDpVAwfT5E7qXf+rnDbMj4mNvhIjOQ==
=RKni
-----END PGP SIGNATURE-----

--O0J94nHQYnbF4MMp--


