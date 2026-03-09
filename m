Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEBEEF3716
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzVxd-0000wV-HR; Mon, 09 Mar 2026 04:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzVxb-0000wH-RT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzVxZ-00060T-QB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773044848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PFOuQtQ4H6YIuc6vuHdWPSNi9RppYvR+cPZ2c4ZzXgI=;
 b=QCBNq54o6QZtPIeyjlcgpTTxV+KARWoceKVteIZEGZC3fNqqjf6JvZpEAUTteIBw54Xm8p
 7ol3C0gA91EtAyzjhR+85wE/3t7vYrGkahpMQVyJoKT4cLf+46cdC+OTcmANnEdg98wNvl
 +NW3fVrllAhKN8mEIDIr7L8LJXH2D1c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-CSmh0ZmJNbmS9L9kB-zAyw-1; Mon,
 09 Mar 2026 04:27:25 -0400
X-MC-Unique: CSmh0ZmJNbmS9L9kB-zAyw-1
X-Mimecast-MFC-AGG-ID: CSmh0ZmJNbmS9L9kB-zAyw_1773044844
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B670195605C; Mon,  9 Mar 2026 08:27:24 +0000 (UTC)
Received: from localhost (unknown [10.44.32.11])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F37E219560A6; Mon,  9 Mar 2026 08:27:22 +0000 (UTC)
Date: Mon, 9 Mar 2026 16:27:20 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 06/13] virtio: use iothread_get/put_aio_context for
 thread pinning
Message-ID: <20260309082720.GE39949@fedora>
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-7-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jLaOyNVvMornx6e2"
Content-Disposition: inline
In-Reply-To: <20260305142459.52559-7-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--jLaOyNVvMornx6e2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 10:24:52PM +0800, Zhang Chen wrote:
> Refactor virtio-blk and virtio-scsi to use the new iothread_get/put
> APIs for AioContext management. This ensures IOThread references
> are tracked via the device's canonical QOM path.
>=20
> Summary of changes:
> - Lift 'path' scope to cover both vq_mapping and single iothread cases.
> - Replace raw object_ref/unref with iothread_get/put_aio_context.
> - Ensure consistent memory cleanup of the QOM path string.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  hw/block/virtio-blk.c           | 17 ++++++-----------
>  hw/scsi/virtio-scsi-dataplane.c | 18 +++++++-----------
>  2 files changed, 13 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index b6f74df68f..94a70c6212 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1429,6 +1429,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBl=
ock *s, Error **errp)
>      VirtIOBlkConf *conf =3D &s->conf;
>      BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> +    char *path =3D object_get_canonical_path(OBJECT(vdev));
> =20
>      if (conf->iothread && conf->iothread_vq_mapping_list) {
>          error_setg(errp,

There is a memory leak when this returns false. Please use g_autofree
when declaring temporary string variables instead of calling g_free()
manually.

--jLaOyNVvMornx6e2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmuhGcACgkQnKSrs4Gr
c8ie8wgAqEBN/xlM4kqQjIBYB2/3I63AB1gUr+teYgTcPtDEoAnJmtdLVTpU6qyk
6W7x8EpIJLMw3XPk9Vx/GsBXvDoNTZIvHWNoa8W1ghmOSay1OfBv8uC+cG7AMZir
n/A2bIMBao9+kv1UHEg+8EEnSrP8FA9mEHSn3pvU1PVd60SlGbo8gQ/C0+qq/IsL
YkXlnVsbObqkkhPhciFCQ0pwrO0VHxZclokXw2Sqm+BihZEenpKhWvvpTTpIpPwk
6qCDjQMSccvSdYaZ9Un0A24zQ5UzMye3kSDrIPQkM40sThF3eBxgr64DKT8v/UVl
oQsAkVch8AFcuf2an2iI/6TiZkojaQ==
=7lzG
-----END PGP SIGNATURE-----

--jLaOyNVvMornx6e2--


