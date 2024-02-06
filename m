Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DF4C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXNDf-0006qR-2i; Tue, 06 Feb 2024 10:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXNDd-0006lZ-9i
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:18:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXNDa-0005Hz-8n
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707232717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5iq0mLo48D/X7d6l2FGUcKYPRXlFNQ/syUy/A8xMqi0=;
 b=VNqiz4smzlveNdDrmMflvDGHpg4JGkUdyTDsfv7ji2gyn0D06ZEz2qwuRwOJhkgXw+cpqg
 PUFITCwXAsQH6vxo+T17p0mB+//xTX8RtgLx6t/BzQ7zU8dmDIpmQQuPOWv84e0EkWOmfe
 qEoCiVrOcES9AQQKtVXdkZmGCP6bp+M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-UCeplgCAMgOTlQutPJnIng-1; Tue,
 06 Feb 2024 10:18:34 -0500
X-MC-Unique: UCeplgCAMgOTlQutPJnIng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8294C3813BC8;
 Tue,  6 Feb 2024 15:18:33 +0000 (UTC)
Received: from localhost (unknown [10.39.195.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6BA42166B31;
 Tue,  6 Feb 2024 15:18:32 +0000 (UTC)
Date: Tue, 6 Feb 2024 10:18:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/5] virtio-blk: enforce iothread-vq-mapping validation
Message-ID: <20240206151830.GA66397@fedora>
References: <20240205172659.476970-1-stefanha@redhat.com>
 <20240205172659.476970-2-stefanha@redhat.com>
 <8fbve.tkrjtk9401p1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+2aY9olMLGlYtJCx"
Content-Disposition: inline
In-Reply-To: <8fbve.tkrjtk9401p1@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--+2aY9olMLGlYtJCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 09:29:29AM +0200, Manos Pitsidianakis wrote:
> On Mon, 05 Feb 2024 19:26, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > Hanna Czenczek <hreitz@redhat.com> noticed that the safety of
> > `vq_aio_context[vq->value] =3D ctx;` with user-defined vq->value inputs=
 is
> > not obvious.
> >=20
> > The code is structured in validate() + apply() steps so input validation
> > is there, but it happens way earlier and there is nothing that
> > guarantees apply() can only be called with validated inputs.
> >=20
> > This patch moves the validate() call inside the apply() function so
> > validation is guaranteed. I also added the bounds checking assertion
> > that Hanna suggested.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > hw/block/virtio-blk.c | 192 +++++++++++++++++++++++-------------------
> > 1 file changed, 107 insertions(+), 85 deletions(-)
> >=20
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 227d83569f..e8b37fd5f4 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -1485,6 +1485,72 @@ static int virtio_blk_load_device(VirtIODevice *=
vdev, QEMUFile *f,
> >     return 0;
> > }
> >=20
> > +static void virtio_resize_cb(void *opaque)
> > +{
> > +    VirtIODevice *vdev =3D opaque;
> > +
> > +    assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context(=
));
> > +    virtio_notify_config(vdev);
> > +}
> > +
> > +static void virtio_blk_resize(void *opaque)
> > +{
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(opaque);
> > +
> > +    /*
> > +     * virtio_notify_config() needs to acquire the BQL,
> > +     * so it can't be called from an iothread. Instead, schedule
> > +     * it to be run in the main context BH.
> > +     */
> > +    aio_bh_schedule_oneshot(qemu_get_aio_context(), virtio_resize_cb, =
vdev);
> > +}
> > +
> > +static void virtio_blk_ioeventfd_detach(VirtIOBlock *s)
> > +{
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
> > +
> > +    for (uint16_t i =3D 0; i < s->conf.num_queues; i++) {
> > +        VirtQueue *vq =3D virtio_get_queue(vdev, i);
> > +        virtio_queue_aio_detach_host_notifier(vq, s->vq_aio_context[i]=
);
> > +    }
> > +}
> > +
> > +static void virtio_blk_ioeventfd_attach(VirtIOBlock *s)
> > +{
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
> > +
> > +    for (uint16_t i =3D 0; i < s->conf.num_queues; i++) {
> > +        VirtQueue *vq =3D virtio_get_queue(vdev, i);
> > +        virtio_queue_aio_attach_host_notifier(vq, s->vq_aio_context[i]=
);
> > +    }
> > +}
> > +
> > +/* Suspend virtqueue ioeventfd processing during drain */
> > +static void virtio_blk_drained_begin(void *opaque)
> > +{
> > +    VirtIOBlock *s =3D opaque;
> > +
> > +    if (s->ioeventfd_started) {
> > +        virtio_blk_ioeventfd_detach(s);
> > +    }
> > +}
> > +
> > +/* Resume virtqueue ioeventfd processing after drain */
> > +static void virtio_blk_drained_end(void *opaque)
> > +{
> > +    VirtIOBlock *s =3D opaque;
> > +
> > +    if (s->ioeventfd_started) {
> > +        virtio_blk_ioeventfd_attach(s);
> > +    }
> > +}
> > +
> > +static const BlockDevOps virtio_block_ops =3D {
> > +    .resize_cb     =3D virtio_blk_resize,
> > +    .drained_begin =3D virtio_blk_drained_begin,
> > +    .drained_end   =3D virtio_blk_drained_end,
> > +};
> > +
> > static bool
> > validate_iothread_vq_mapping_list(IOThreadVirtQueueMappingList *list,
> >         uint16_t num_queues, Error **errp)
> > @@ -1547,81 +1613,33 @@ validate_iothread_vq_mapping_list(IOThreadVirtQ=
ueueMappingList *list,
> >     return true;
> > }
> >=20
> > -static void virtio_resize_cb(void *opaque)
> > -{
> > -    VirtIODevice *vdev =3D opaque;
> > -
> > -    assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context(=
));
> > -    virtio_notify_config(vdev);
> > -}
> > -
> > -static void virtio_blk_resize(void *opaque)
> > -{
> > -    VirtIODevice *vdev =3D VIRTIO_DEVICE(opaque);
> > -
> > -    /*
> > -     * virtio_notify_config() needs to acquire the BQL,
> > -     * so it can't be called from an iothread. Instead, schedule
> > -     * it to be run in the main context BH.
> > -     */
> > -    aio_bh_schedule_oneshot(qemu_get_aio_context(), virtio_resize_cb, =
vdev);
> > -}
> > -
> > -static void virtio_blk_ioeventfd_detach(VirtIOBlock *s)
> > -{
> > -    VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
> > -
> > -    for (uint16_t i =3D 0; i < s->conf.num_queues; i++) {
> > -        VirtQueue *vq =3D virtio_get_queue(vdev, i);
> > -        virtio_queue_aio_detach_host_notifier(vq, s->vq_aio_context[i]=
);
> > -    }
> > -}
> > -
> > -static void virtio_blk_ioeventfd_attach(VirtIOBlock *s)
> > -{
> > -    VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
> > -
> > -    for (uint16_t i =3D 0; i < s->conf.num_queues; i++) {
> > -        VirtQueue *vq =3D virtio_get_queue(vdev, i);
> > -        virtio_queue_aio_attach_host_notifier(vq, s->vq_aio_context[i]=
);
> > -    }
> > -}
> > -
> > -/* Suspend virtqueue ioeventfd processing during drain */
> > -static void virtio_blk_drained_begin(void *opaque)
> > -{
> > -    VirtIOBlock *s =3D opaque;
> > -
> > -    if (s->ioeventfd_started) {
> > -        virtio_blk_ioeventfd_detach(s);
> > -    }
> > -}
> > -
> > -/* Resume virtqueue ioeventfd processing after drain */
> > -static void virtio_blk_drained_end(void *opaque)
> > -{
> > -    VirtIOBlock *s =3D opaque;
> > -
> > -    if (s->ioeventfd_started) {
> > -        virtio_blk_ioeventfd_attach(s);
> > -    }
> > -}
> > -
> > -static const BlockDevOps virtio_block_ops =3D {
> > -    .resize_cb     =3D virtio_blk_resize,
> > -    .drained_begin =3D virtio_blk_drained_begin,
> > -    .drained_end   =3D virtio_blk_drained_end,
> > -};
> > -
> > -/* Generate vq:AioContext mappings from a validated iothread-vq-mappin=
g list */
> > -static void
> > -apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_lis=
t,
> > -                 AioContext **vq_aio_context, uint16_t num_queues)
> > +/**
> > + * apply_iothread_vq_mapping:
> > + * @iothread_vq_mapping_list: The mapping of virtqueues to IOThreads.
> > + * @vq_aio_context: The array of AioContext pointers to fill in.
> > + * @num_queues: The length of @vq_aio_context.
> > + * @errp: If an error occurs, a pointer to the area to store the error.
> > + *
> > + * Fill in the AioContext for each virtqueue in the @vq_aio_context ar=
ray given
> > + * the iothread-vq-mapping parameter in @iothread_vq_mapping_list.
> > + *
> > + * Returns: %true on success, %false on failure.
> > + **/
> > +static bool apply_iothread_vq_mapping(
> > +        IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
> > +        AioContext **vq_aio_context,
> > +        uint16_t num_queues,
> > +        Error **errp)
> > {
> >     IOThreadVirtQueueMappingList *node;
> >     size_t num_iothreads =3D 0;
> >     size_t cur_iothread =3D 0;
> >=20
> > +    if (!validate_iothread_vq_mapping_list(iothread_vq_mapping_list,
> > +                                           num_queues, errp)) {
> > +        return false;
> > +    }
> > +
> >     for (node =3D iothread_vq_mapping_list; node; node =3D node->next) {
> >         num_iothreads++;
> >     }
> > @@ -1638,6 +1656,7 @@ apply_vq_mapping(IOThreadVirtQueueMappingList *io=
thread_vq_mapping_list,
> >=20
> >             /* Explicit vq:IOThread assignment */
> >             for (vq =3D node->value->vqs; vq; vq =3D vq->next) {
> > +                assert(vq->value < num_queues);
> >                 vq_aio_context[vq->value] =3D ctx;
> >             }
> >         } else {
> > @@ -1650,6 +1669,8 @@ apply_vq_mapping(IOThreadVirtQueueMappingList *io=
thread_vq_mapping_list,
> >=20
> >         cur_iothread++;
> >     }
> > +
> > +    return true;
> > }
> >=20
> > /* Context: BQL held */
> > @@ -1660,6 +1681,14 @@ static bool virtio_blk_vq_aio_context_init(VirtI=
OBlock *s, Error **errp)
> >     BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
> >     VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> >=20
> > +    if (conf->iothread && conf->iothread_vq_mapping_list) {
> > +        if (conf->iothread) {
> > +            error_setg(errp, "iothread and iothread-vq-mapping propert=
ies "
> > +                             "cannot be set at the same time");
> > +            return false;
> > +        }
> > +    }
> > +
> >     if (conf->iothread || conf->iothread_vq_mapping_list) {
> >         if (!k->set_guest_notifiers || !k->ioeventfd_assign) {
> >             error_setg(errp,
> > @@ -1685,8 +1714,14 @@ static bool virtio_blk_vq_aio_context_init(VirtI=
OBlock *s, Error **errp)
> >     s->vq_aio_context =3D g_new(AioContext *, conf->num_queues);
> >=20
> >     if (conf->iothread_vq_mapping_list) {
> > -        apply_vq_mapping(conf->iothread_vq_mapping_list, s->vq_aio_con=
text,
> > -                         conf->num_queues);
> > +        if (!apply_iothread_vq_mapping(conf->iothread_vq_mapping_list,
> > +                                       s->vq_aio_context,
> > +                                       conf->num_queues,
> > +                                       errp)) {
> > +            g_free(s->vq_aio_context);
> > +            s->vq_aio_context =3D NULL;
> > +            return false;
> > +        }
> >     } else if (conf->iothread) {
> >         AioContext *ctx =3D iothread_get_aio_context(conf->iothread);
> >         for (unsigned i =3D 0; i < conf->num_queues; i++) {
> > @@ -1996,19 +2031,6 @@ static void virtio_blk_device_realize(DeviceStat=
e *dev, Error **errp)
> >         return;
> >     }
> >=20
> > -    if (conf->iothread_vq_mapping_list) {
> > -        if (conf->iothread) {
> > -            error_setg(errp, "iothread and iothread-vq-mapping propert=
ies "
> > -                             "cannot be set at the same time");
> > -            return;
> > -        }
> > -
> > -        if (!validate_iothread_vq_mapping_list(conf->iothread_vq_mappi=
ng_list,
> > -                                               conf->num_queues, errp)=
) {
> > -            return;
> > -        }
> > -    }
> > -
> >     s->config_size =3D virtio_get_config_size(&virtio_blk_cfg_size_para=
ms,
> >                                             s->host_features);
> >     virtio_init(vdev, VIRTIO_ID_BLOCK, s->config_size);
> > --=20
> > 2.43.0
> >=20
> >=20
>=20
>=20
> virtio_block_ops and methods are moved around without changes in the diff,
> is that on purpose? If no the patch and history would be less noisy.

Yes, it's because I moved the validate() function immediately before the
apply() function. Previously they were far apart. I guess git's diff
algorithm optimized for the shortest patch rather than the most readable
patch.

> Regardless:
>=20
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>=20

--+2aY9olMLGlYtJCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXCTcYACgkQnKSrs4Gr
c8gYVAf+ObKw6Eo2Xl2CbpnMQcbdjEPHgdROE9vbbfaMnMQMU/O/jVbO/RV174hc
4afqiM/VX0XrXPdBHcI4JsPR9ssE4BXOsLv1rt3hMq5uFmWSaZLeJg30zFkLhmfh
dgnCJHg6cvORbdiXl2HsckS/R4kaKVjz8wa9FVPdpDQBdeqweqbrfKzODjBRNULu
Slv/XZT2KKt1pFnJKsw8D1puficH3531aRrWpqonKValNHT7sejbalOhuKWGsX5g
JUIPrJqFrkgl2Xw9uAuD/cbaiImwnSsDEc+vbOa3Rcs/mnVOc++Xwps4LeEodT5Y
gzUnAmaVhlMQmw8w92cU84YfRIhWoA==
=v0c5
-----END PGP SIGNATURE-----

--+2aY9olMLGlYtJCx--


