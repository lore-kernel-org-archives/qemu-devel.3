Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FF2C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 18:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmHrW-0007Av-GW; Mon, 18 Mar 2024 14:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmHrU-0007An-S4
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 14:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmHrS-0006TQ-VG
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 14:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710787046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJCw9Ax6NFFsTYbQH2IWyNy96ikx9vWcqbj/l0FoQ/I=;
 b=RhHcFmq9lvAJWq0EygxCEgaS5csNTmFr37ryjXEVZTsFYuhoF8eUgKu3oXQUvgHejCDiW1
 od7xT0ItiFMb47X53Wc96HuranjN5nJ/qKCfoxEdcaN2dKF0me/xCyZaePloaHFWCmfI1N
 17CqJwSOfX0VpHnSXffgKR1U3UbI7EY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-tmvYnaQnOF6UhQShVgGUkQ-1; Mon,
 18 Mar 2024 14:37:22 -0400
X-MC-Unique: tmvYnaQnOF6UhQShVgGUkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CFE3282D3C6;
 Mon, 18 Mar 2024 18:37:22 +0000 (UTC)
Received: from localhost (unknown [10.39.194.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D885C017A2;
 Mon, 18 Mar 2024 18:37:21 +0000 (UTC)
Date: Mon, 18 Mar 2024 14:37:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sanjay Rao <srao@redhat.com>, Boaz Ben Shabat <bbenshab@redhat.com>,
 Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: iothread-vq-mapping coroutine pool sizing
Message-ID: <20240318183716.GA1039373@fedora>
References: <20240312151204.412624-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aHDpA35URscttHWT"
Content-Disposition: inline
In-Reply-To: <20240312151204.412624-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--aHDpA35URscttHWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:12:04AM -0400, Stefan Hajnoczi wrote:
> It is possible to hit the sysctl vm.max_map_count limit when the
> coroutine pool size becomes large. Each coroutine requires two mappings
> (one for the stack and one for the guard page). QEMU can crash with
> "failed to set up stack guard page" or "failed to allocate memory for
> stack" when this happens.
>=20
> Coroutine pool sizing is simple when there is only thread: sum up all
> I/O requests across all virtqueues.
>=20
> When the iothread-vq-mapping option is used we should calculate tighter
> bounds because thread may serve a subset of the device's virtqueues:
> take the maximum number of the number of I/O requests across all
> virtqueues. A thread does not need coroutine pool space for I/O requests
> that are handled by other threads.
>=20
> This is not a solution to hitting vm.max_map_count, but it helps. A
> guest with 64 vCPUs (hence 64 virtqueues) across 4 IOThreads with one
> iothread-vq-mapping virtio-blk device and a root disk without goes from
> pool_max_size 16,448 to 10,304.
>=20
> Reported-by: Sanjay Rao <srao@redhat.com>
> Reported-by: Boaz Ben Shabat <bbenshab@redhat.com>
> Reported-by: Joe Mario <jmario@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
> - State the the tighter bounds reflect the fact that threads may only
>   process a subset of the total I/O requests from a device [Kevin]
> - Add Reported-by: Joe Mario, he has been investigating this issue.

I have sent a new patch series that obsoletes this patch. Please do not
apply this patch.

The new series is here:
https://lore.kernel.org/qemu-devel/20240318183429.1039340-1-stefanha@redhat=
=2Ecom/T/#u

>=20
>  include/hw/virtio/virtio-blk.h |  2 ++
>  hw/block/virtio-blk.c          | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-bl=
k.h
> index 5c14110c4b..ac29700ad4 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -74,6 +74,8 @@ struct VirtIOBlock {
>      uint64_t host_features;
>      size_t config_size;
>      BlockRAMRegistrar blk_ram_registrar;
> +
> +    unsigned coroutine_pool_size;
>  };
> =20
>  typedef struct VirtIOBlockReq {
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 738cb2ac36..0a14b2b175 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1957,6 +1957,35 @@ static void virtio_blk_stop_ioeventfd(VirtIODevice=
 *vdev)
>      s->ioeventfd_stopping =3D false;
>  }
> =20
> +/* Increase the coroutine pool size to include our I/O requests */
> +static void virtio_blk_inc_coroutine_pool_size(VirtIOBlock *s)
> +{
> +    VirtIOBlkConf *conf =3D &s->conf;
> +    unsigned max_requests =3D 0;
> +
> +    /* Tracks the total number of requests for AioContext */
> +    g_autoptr(GHashTable) counters =3D g_hash_table_new(NULL, NULL);
> +
> +    /* Call this function after setting up vq_aio_context[] */
> +    assert(s->vq_aio_context);
> +
> +    for (unsigned i =3D 0; i < conf->num_queues; i++) {
> +        AioContext *ctx =3D s->vq_aio_context[i];
> +        unsigned n =3D GPOINTER_TO_UINT(g_hash_table_lookup(counters, ct=
x));
> +
> +        n +=3D conf->queue_size / 2; /* this is a heuristic */
> +
> +        g_hash_table_insert(counters, ctx, GUINT_TO_POINTER(n));
> +
> +        if (n > max_requests) {
> +            max_requests =3D n;
> +        }
> +    }
> +
> +    qemu_coroutine_inc_pool_size(max_requests);
> +    s->coroutine_pool_size =3D max_requests; /* stash it for ->unrealize=
() */
> +}
> +
>  static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> @@ -2048,7 +2077,6 @@ static void virtio_blk_device_realize(DeviceState *=
dev, Error **errp)
>      for (i =3D 0; i < conf->num_queues; i++) {
>          virtio_add_queue(vdev, conf->queue_size, virtio_blk_handle_outpu=
t);
>      }
> -    qemu_coroutine_inc_pool_size(conf->num_queues * conf->queue_size / 2=
);
> =20
>      /* Don't start ioeventfd if transport does not support notifiers. */
>      if (!virtio_device_ioeventfd_enabled(vdev)) {
> @@ -2065,6 +2093,8 @@ static void virtio_blk_device_realize(DeviceState *=
dev, Error **errp)
>          return;
>      }
> =20
> +    virtio_blk_inc_coroutine_pool_size(s);
> +
>      /*
>       * This must be after virtio_init() so virtio_blk_dma_restart_cb() g=
ets
>       * called after ->start_ioeventfd() has already set blk's AioContext.
> @@ -2096,7 +2126,7 @@ static void virtio_blk_device_unrealize(DeviceState=
 *dev)
>      for (i =3D 0; i < conf->num_queues; i++) {
>          virtio_del_queue(vdev, i);
>      }
> -    qemu_coroutine_dec_pool_size(conf->num_queues * conf->queue_size / 2=
);
> +    qemu_coroutine_dec_pool_size(s->coroutine_pool_size);
>      qemu_mutex_destroy(&s->rq_lock);
>      blk_ram_registrar_destroy(&s->blk_ram_registrar);
>      qemu_del_vm_change_state_handler(s->change);
> --=20
> 2.44.0
>=20

--aHDpA35URscttHWT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmX4idsACgkQnKSrs4Gr
c8hsLAgAq+XcGrALp8SatUKQnYsRtOkzpcHUxcAM3bTYpEzhUli2501sP/EiLgdI
DDtlO+Pn7oUNid6oHj1snmwNllzw7tZf38hOJrgKKwTZIjSuKkchNZ/Hgl8xnMVQ
KSlYnWcxtepR4SlSNihPvPu+Tydv3+M70JAchBEpy5xHfcJma307q5hFn7XydTlp
xc21PgQLuQeufAs0ggM2b7KXFSVampZ9c6SsANsPtN/jsY/wcpE534PCt7CzUbfn
bNNtR6vo9ZP0eAUhn/WQsow+3H5aJgGBoKSePxsrhz56KpvQ6K7QTeiHIgKm6Lko
ue08THrm5KXcihIidL7Gzeez0oAUkw==
=Tf6n
-----END PGP SIGNATURE-----

--aHDpA35URscttHWT--


