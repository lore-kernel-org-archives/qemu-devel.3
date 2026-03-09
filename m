Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8E5EF3716
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzVsD-0007Wl-5N; Mon, 09 Mar 2026 04:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzVs6-0007Rc-7G
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzVs4-0005DP-PY
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773044507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DMKL5nbkeeJ/qVlHLPP1EoyCUNfB2M+tLxWDlRf5SME=;
 b=Yw+hyBUR2iPpxSpDV/fpmIij6zR1MBSpU0W0AdZpvnC9t7da9hqQY8gAm9TkYZtxR937w4
 noglelQnRLmtjBqE81ebEq0E6wcaiWi6GPo0wpGLbx0CauXPZ5kHsZgtvJIro/4S9Q6RKP
 OsvG/VlQI817/UGOEYV2IZRQe9ui+Ek=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-ssQ5oeHUPaS0WbXTe4jR1w-1; Mon,
 09 Mar 2026 04:21:44 -0400
X-MC-Unique: ssQ5oeHUPaS0WbXTe4jR1w-1
X-Mimecast-MFC-AGG-ID: ssQ5oeHUPaS0WbXTe4jR1w_1773044503
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E50F18002CF; Mon,  9 Mar 2026 08:21:43 +0000 (UTC)
Received: from localhost (unknown [10.44.32.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3697E1800762; Mon,  9 Mar 2026 08:21:41 +0000 (UTC)
Date: Mon, 9 Mar 2026 16:21:39 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 05/13] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
Message-ID: <20260309082139.GD39949@fedora>
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-6-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A4OJO5nd2FwIzNQD"
Content-Disposition: inline
In-Reply-To: <20260305142459.52559-6-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--A4OJO5nd2FwIzNQD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 10:24:51PM +0800, Zhang Chen wrote:
> Replace raw object_ref/unref calls with iothread_get/put_aio_context
> in iothread-vq-mapping. This allows tracking IOThread users via
> the device's canonical QOM path, improving lifecycle traceability
> for virtio-blk and virtio-scsi devices.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  hw/block/virtio-blk.c                   | 10 +++++++++-
>  hw/scsi/virtio-scsi-dataplane.c         | 11 +++++++++--
>  hw/virtio/iothread-vq-mapping.c         | 11 +++++------
>  include/hw/virtio/iothread-vq-mapping.h |  6 +++++-
>  4 files changed, 28 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index ddf0e9ee53..b6f74df68f 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1453,14 +1453,19 @@ static bool virtio_blk_vq_aio_context_init(VirtIO=
Block *s, Error **errp)
>      s->vq_aio_context =3D g_new(AioContext *, conf->num_queues);
> =20
>      if (conf->iothread_vq_mapping_list) {
> +        char *path =3D object_get_canonical_path(OBJECT(vdev));

The g_free() calls can be avoided with:

  g_autofree char *path =3D ...;

The same applies throughout the rest of this patch series.

--A4OJO5nd2FwIzNQD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmugxMACgkQnKSrs4Gr
c8hHcAgAv5mt0wmga+K4UfR8FB5NFYKXj3Zm53ndvEZ9kuCFgfyZy0lxB4VGgY6O
JDaRNe7Mumw0tRLE4OlLj9NuYfQe+HnO4TNPRNRJ+A0T6C5QJ2Tjx6ZAemAzc+SM
08t2RJJ7mm76iaxJEgMVKdoH8t0MRls4cFHT4GOzCMd+pSEdojiP+S7VogaWllwB
4iIM1H6vDLgOTOY+xi0F97i2KB1dvqWjwflmSwxD78Kksa78FLGXCJ2A65qPFong
s0AnwWT7RKvc575UylZQQDseKt20I3/Z0dgH0fqRVJ+BIMrrrFYqsoHkEOtK6bDV
hVCOJY/BPd01XgE7n8x8NTwJbbJCNA==
=I/6R
-----END PGP SIGNATURE-----

--A4OJO5nd2FwIzNQD--


