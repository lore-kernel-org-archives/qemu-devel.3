Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E02ACD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 16:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVB61-0000uh-D3; Thu, 04 Jun 2026 12:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVB5z-0000uY-Vg
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVB5x-00056N-Lc
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780591141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1I2jJPBXs4CtkSS67oOsBGmD6eZmC6LuYnaPcDVNHbY=;
 b=Fw0yYluNmV3op+26SH8FeX73P7YBeGR9OxadtQxCUTFF0+c2ul0AC8sjBy+EQQG+8DQ7xO
 L3LEfluvJJO4S5UuEiqM7ZwRqncM6ZDdMCcjUm99vS7WgUc1Tt/tmZd8LhyEq8pKrjDgoT
 lj59EGTr32d0oDaG7TMyO+ONoHyqoqw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-Kbnsm_-qPEafJc7yrELqVQ-1; Thu,
 04 Jun 2026 12:38:57 -0400
X-MC-Unique: Kbnsm_-qPEafJc7yrELqVQ-1
X-Mimecast-MFC-AGG-ID: Kbnsm_-qPEafJc7yrELqVQ_1780591136
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCE541944D1B; Thu,  4 Jun 2026 16:38:55 +0000 (UTC)
Received: from localhost (unknown [10.2.17.68])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7C1E195608E; Thu,  4 Jun 2026 16:38:54 +0000 (UTC)
Date: Thu, 4 Jun 2026 11:07:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/virtio: reject malformed VirtQueueElement on
 migration load
Message-ID: <20260604150731.GB115597@fedora>
References: <20260604085624.53815-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d7MZVcoQdyrsiEAm"
Content-Disposition: inline
In-Reply-To: <20260604085624.53815-1-guobin@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--d7MZVcoQdyrsiEAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 04:56:24PM +0800, Bin Guo wrote:
> qemu_get_virtqueue_element() asserts on in_num/out_num read straight
> from the migration stream, then feeds them to virtqueue_alloc_element()
> as allocation sizes. A malformed stream from the source crashes the
> destination; with NDEBUG the asserts vanish and the heap allocation is
> driven by attacker-controlled values - the reason the in-tree TODO
> forbade NDEBUG builds. The hole is reachable on every inbound migration
> of a virtio-blk or virtio-scsi guest.
>=20
> Reject in_num/out_num that overflow their arrays, and reject
> in_num + out_num > VIRTQUEUE_MAX_SIZE (a single chain cannot exceed
> one ring). The OR short-circuits so the sum is only evaluated once
> both counts are individually bounded.
>=20
> virtio_blk_load_device() returns -EINVAL through its existing int
> return. virtio_scsi_load_request() has no error channel in its
> SCSIBusInfo hook signature and mirrors the existing error_report() +
> exit(1) used a few lines below for parse failures.
>=20
> Document the new NULL return on the prototype in virtio.h.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 8059feee0041 ("virtio: introduce virtio_map")
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  hw/block/virtio-blk.c      |  3 +++
>  hw/scsi/virtio-scsi.c      |  5 +++++
>  hw/virtio/virtio.c         | 19 +++++++++++++------
>  include/hw/virtio/virtio.h |  4 ++++
>  4 files changed, 25 insertions(+), 6 deletions(-)

- The purpose of this patch is unclear. Are you working on a larger
  scale effort to enable NDEBUG builds in QEMU? There are still lots of
  asserts that validate migration state, so I'm not sure this patch
  makes sense in isolation. Or is there some other reason you want to
  make this change? Addressing the TODO comment just for the sake of
  getting rid of a TODO is probably not worth it without a bigger
  strategy.

- virtio-serial-bus.c uses qemu_get_virtqueue_element() without checking
  for a NULL return value. While the code is written to handle
  port->elem =3D=3D NULL, the existing semantics are not intended for
  silently ignored an invalid migration stream.

- Is virtio-blk's s->rq freed when virtio_blk_load_device() fails? The
  code depends on virtio_blk_reset() being called before
  virtio_blk_device_unrealize() - otherwise s->rq is leaked. If reset is
  always called, then a comment in virtio_blk_load_device() should make
  it that clear that s->rq is not leaked if an error is hit after
  virtqueue elements have already been successfully loaded.

>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 9cb9f1fb2b..97482c7981 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1378,6 +1378,9 @@ static int virtio_blk_load_device(VirtIODevice *vde=
v, QEMUFile *f,
>          }
> =20
>          req =3D qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockRe=
q));
> +        if (!req) {
> +            return -EINVAL;
> +        }
>          virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
> =20
>          WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 6c73768011..bb2412e89c 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -274,6 +274,11 @@ static void *virtio_scsi_load_request(QEMUFile *f, S=
CSIRequest *sreq)
>      assert(n < vs->conf.num_queues);
>      req =3D qemu_get_virtqueue_element(vdev, f,
>                                       sizeof(VirtIOSCSIReq) + vs->cdb_siz=
e);
> +    if (!req) {
> +        error_report("virtio-scsi: failed to load request from migration=
 "
> +                     "stream (queue=3D%u)", n);
> +        exit(1);
> +    }
>      virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
> =20
>      if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_si=
ze,
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 63e2faee99..24df1d0300 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2167,13 +2167,20 @@ void *qemu_get_virtqueue_element(VirtIODevice *vd=
ev, QEMUFile *f, size_t sz)
> =20
>      qemu_get_buffer(f, (uint8_t *)&data, sizeof(VirtQueueElementOld));
> =20
> -    /* TODO: teach all callers that this can fail, and return failure in=
stead
> -     * of asserting here.
> -     * This is just one thing (there are probably more) that must be
> -     * fixed before we can allow NDEBUG compilation.
> +    /*
> +     * Bound the untrusted counts before they reach
> +     * virtqueue_alloc_element() as allocation sizes. A single chain
> +     * cannot exceed the ring size, so the sum is bounded too.
>       */
> -    assert(ARRAY_SIZE(data.in_addr) >=3D data.in_num);
> -    assert(ARRAY_SIZE(data.out_addr) >=3D data.out_num);
> +    if (data.in_num > ARRAY_SIZE(data.in_addr) ||
> +        data.out_num > ARRAY_SIZE(data.out_addr) ||
> +        data.in_num + data.out_num > VIRTQUEUE_MAX_SIZE) {
> +        error_report("virtio: malformed VirtQueueElement on migration lo=
ad: "
> +                     "in_num=3D%u out_num=3D%u (max=3D%u)",
> +                     data.in_num, data.out_num,
> +                     (unsigned)VIRTQUEUE_MAX_SIZE);
> +        return NULL;
> +    }
> =20
>      elem =3D virtqueue_alloc_element(sz, data.out_num, data.in_num);
>      elem->index =3D data.index;
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 6344bd7b68..3034257505 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -281,6 +281,10 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueEl=
ement *elem,
>  void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem);
>  void *virtqueue_pop(VirtQueue *vq, size_t sz);
>  unsigned int virtqueue_drop_all(VirtQueue *vq);
> +/**
> + * Returns NULL if the migration stream encodes an out-of-range
> + * descriptor count; callers must check before dereferencing.
> + */
>  void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t=
 sz);
>  void qemu_put_virtqueue_element(VirtIODevice *vdev, QEMUFile *f,
>                                  VirtQueueElement *elem);
> --=20
> 2.50.1 (Apple Git-155)
>=20

--d7MZVcoQdyrsiEAm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmohlLMACgkQnKSrs4Gr
c8j53wf7BepzQesuEnF03wn23Wh286Tw3jrAbCwvTP1LOsthHM1M80RLEuxFemVg
OykisZx8GVfRrhdlJRIH6vXZ2xT34NLb+dBONtxuoU3fC7mnrtH6cY1xbzX234kW
615pW2RiQRX/lRD2Rn0fCdg6udTSsb2mogPx23uv278KFwwIs0SXccneIcrm7Chd
oPfN2mxfZeXdpOoMQkdkupaTX623/+iPKGFFEer9NgfXFoVCtJU4PRLzOOyDpbiw
dRrdmsOvWmNzKYQWeCpzv90PeI65IjiHxpDWw1ilW+4Htgmea1q/jfsv2PcWry/l
DEJK1klTSarmkLsjYxqrtCa5LqxD1Q==
=HXM5
-----END PGP SIGNATURE-----

--d7MZVcoQdyrsiEAm--


