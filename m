Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC99C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 18:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEYi9-0005WY-LV; Tue, 04 Jun 2024 14:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sEYi8-0005Vj-08
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sEYi5-0000hG-5W
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717524994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XW2xgVfxuQTf74MpPvR8zN+M4KaXJQj6qRul3XE4j8A=;
 b=hF5kZpWAFdAwSvgp5QEkxmJYopLnv/1sOF80zkAtwsPrtQTPUfDgFnhAJpKm/LGe76uN3s
 4QzHrUz9j5wyRTb3rp6cirhKYgKfzweTMw8rJ0UT8w0oLDRoPDTnCCTql2gQL0eRRo2zIj
 4IMHZYIrIBdriQNBgA7Z1gNn9vrTBZk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-XaRpDN3aOUWDPC9JhGG0PA-1; Tue, 04 Jun 2024 14:16:28 -0400
X-MC-Unique: XaRpDN3aOUWDPC9JhGG0PA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7611185B946
 for <qemu-devel@nongnu.org>; Tue,  4 Jun 2024 18:16:28 +0000 (UTC)
Received: from localhost (unknown [10.39.195.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FA97492BCF;
 Tue,  4 Jun 2024 18:16:27 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:16:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, slp@redhat.com, jasowang@redhat.com
Subject: Re: [RFC PATCH 0/1] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20240604181626.GA90471@fedora.redhat.com>
References: <20240530152223.780232-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YKzJ9C/ncF38IGAM"
Content-Disposition: inline
In-Reply-To: <20240530152223.780232-1-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--YKzJ9C/ncF38IGAM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 05:22:22PM +0200, Albert Esteve wrote:
> Hi all,
>=20
> This is an early attempt to have backends
> support dynamic fd mapping into shared
> memory regions. As such, there are a few
> things that need settling, so I wanted to
> post this first to have some early feedback.
>=20
> The usecase for this is, e.g., to support
> vhost-user-gpu RESOURCE_BLOB operations,
> or DAX Window request for virtio-fs. In
> general, any operation where a backend
> would need to mmap an fd to a shared
> memory so that the guest can access it.

I wanted to mention that this sentence confuses me because:

- The frontend will mmap an fd into the guest's memory space so that a
  VIRTIO Shared Memory Region is exposed to the guest. The backend
  requests the frontend to perform this operation. The backend does not
  invoke mmap itself.

- "Shared memory" is ambiguous. Please call it VIRTIO Shared Memory
  Region to differentiate from vhost-user shared memory tables/regions.

> The request will be processed by the VMM,
> that will, in turn, trigger a mmap with
> the instructed parameters (i.e., shmid,
> shm_offset, fd_offset, fd, lenght).
>=20
> As there are already a couple devices
> that could benefit of such a feature,
> and more could require it in the future,
> my intention was to make it generic.
>=20
> To that end, I declared the shared
> memory region list in `VirtIODevice`.
> I could add a couple commodity
> functions to add new regions to the list,
> so that the devices can use them. But
> I wanted to gather some feedback before
> refining it further, as I am probably
> missing some required steps/or security
> concerns that I am not taking into account.
>=20
> Albert Esteve (1):
>   vhost-user: add shmem mmap request
>=20
>  docs/interop/vhost-user.rst |  23 ++++++++
>  hw/virtio/vhost-user.c      | 106 ++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio.c          |   2 +
>  include/hw/virtio/virtio.h  |   3 +
>  4 files changed, 134 insertions(+)
>=20
> --=20
> 2.44.0
>=20

--YKzJ9C/ncF38IGAM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZfWfkACgkQnKSrs4Gr
c8giWQgAsxYYnEvqOUydAEAD8JSuOILTjmrXj1IKUM1abDQyma7i+jeRgehpdYoR
vdWSDp3A1qle4MSNJHlDCs0NVr2fV3ordiBc1YOiTVF5YnlnvFqjjFj2wbsZWTMH
jeQc343poqFn+Vxu9WiUVEDbZy4yceTkSfi+S+lbd9FTheZ2QGvKEZXfOwmWpEA+
MXBajwmyoJ74aVP6fhtFYOLcIFIDPBIdlZkOuAVsR/iSQft7fIe4bDRh6PDykjJk
A6A5rjVZVD57xQ00HwbHJdi4fhe5y7Bt5i3T3tpTS/3snCtuGvGV4wuzWf/F3PLt
QiRC/jAtRK7FsDeoZWmtQrnn9sHgDg==
=RRyJ
-----END PGP SIGNATURE-----

--YKzJ9C/ncF38IGAM--


