Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD842CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 18:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDSOP-0003pZ-Gx; Mon, 27 Oct 2025 14:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vDSOC-0003lB-8b
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vDSO3-0001UU-IC
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761591364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AnDsN+LJ47tfMU0yNxKtcB8VOfxjSBGSoL5KO9rZBd8=;
 b=CiFMNkC2U1kL79gBskiVOwrIFKVktTkylMObkWU90S6yvVZGb2np1CQew2hvvFUQujkLQK
 8sVT97ouLF/nm/osW2sOpy6gyazlAMfU8fJ6w3tAXnQx+IdybwLVNnc4XUN9wR+r4+XaNB
 +LQVVgA9Uftyv5Bp3cqUDw/EpxeBJck=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-ZNy8I8KLM-emdFp8KcusKg-1; Mon,
 27 Oct 2025 14:56:03 -0400
X-MC-Unique: ZNy8I8KLM-emdFp8KcusKg-1
X-Mimecast-MFC-AGG-ID: ZNy8I8KLM-emdFp8KcusKg_1761591361
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 556EF19560B4; Mon, 27 Oct 2025 18:56:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.174])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0812D180057F; Mon, 27 Oct 2025 18:55:59 +0000 (UTC)
Date: Mon, 27 Oct 2025 14:55:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 fam@euphon.net, mst@redhat.com, kwolf@redhat.com, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] hw/scsi: avoid deadlock upon TMF request cancelling
 with VirtIO
Message-ID: <20251027185558.GB11774@fedora>
References: <20251017094518.328905-1-f.ebner@proxmox.com>
 <20251017175433.GA14295@fedora>
 <2de05b13-f97a-480d-b07c-2a8ffc695c21@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XYFXWxUy0WWdYtMQ"
Content-Disposition: inline
In-Reply-To: <2de05b13-f97a-480d-b07c-2a8ffc695c21@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--XYFXWxUy0WWdYtMQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 10:14:49AM +0200, Paolo Bonzini wrote:
> On 10/17/25 19:54, Stefan Hajnoczi wrote:
> > On Fri, Oct 17, 2025 at 11:43:30AM +0200, Fiona Ebner wrote:
> > > Changes in v2:
> > > * Different approach, collect requests for cancelling in a list for a
> > >    localized solution rather than keeping track of the lock status via
> > >    function arguments.
> > >=20
> > >   hw/scsi/virtio-scsi.c | 14 +++++++++++++-
> > >   1 file changed, 13 insertions(+), 1 deletion(-)
> >=20
> > Thanks, applied to my block tree:
> > https://gitlab.com/stefanha/qemu/commits/block
>=20
> Thanks Stefan; sorry for the delay in reviewing.  The fix
> of releasing the lock around virtio_scsi_tmf_cancel_req():
>=20
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 9b12ee7f1c6..ac17c97f224 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -1503,6 +1503,10 @@ SCSIRequest *scsi_req_ref(SCSIRequest *req)
>  void scsi_req_unref(SCSIRequest *req)
>  {
> +    if (!req) {
> +        return;
> +    }
> +
>      assert(req->refcount > 0);
>      if (--req->refcount =3D=3D 0) {
>          BusState *qbus =3D req->dev->qdev.parent_bus;
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index d817fc42b4c..481e78e4771 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -364,7 +364,11 @@ static void virtio_scsi_do_tmf_aio_context(void *opa=
que)
>      }
>      WITH_QEMU_LOCK_GUARD(&d->requests_lock) {
> +        SCSIRequest *prev =3D NULL;
>          QTAILQ_FOREACH(r, &d->requests, next) {
> +            scsi_req_unref(prev);
> +            prev =3D NULL;
> +
>              VirtIOSCSIReq *cmd_req =3D r->hba_private;
>              assert(cmd_req); /* request has hba_private while enqueued */
> @@ -374,8 +378,20 @@ static void virtio_scsi_do_tmf_aio_context(void *opa=
que)
>              if (match_tag && cmd_req->req.cmd.tag !=3D tmf->req.tmf.tag)=
 {
>                  continue;
>              }
> +
> +            /*
> +             * Keep it alive while the lock is released, and also to be
> +             * able to read "next".
> +             */
> +            scsi_req_ref(r);
> +            prev =3D r;
> +
> +            qemu_mutex_unlock(&d->request_lock);
>              virtio_scsi_tmf_cancel_req(tmf, r);
> +            qemu_mutex_lock(&d->request_lock);
>          }
> +
> +        scsi_req_unref(prev);
>      }
>      /* Incremented by virtio_scsi_do_tmf() */
>=20
>=20
> would have a bug too, in that the loop is not using
> QTAILQ_FOREACH_SAFE and scsi_req_dequeue() removes the
> request from the list.
>=20
> I think scsi_req_ref/unref should also be changed to use atomics.
> free_request is only implemented by hw/usb/dev-uas.c and all the
> others do not need a lock, so we're fine with that.

At the moment there is the assumption that a request executes in the
same AioContext for its entire lifetime. Most devices only have one
AioContext and don't worry about thread-safety at all (like the
hw/usb/dev-uas.c example you mentioned).

SCSIRequest->refcount does not need to be atomic today and any change to
the SCSI layer that actually touches a request from multiple threads
will need to do more than just making refcount atomic.

I worry making refcount atomic might give the impression that
SCSIRequest is thread-safe when it's not. I would only make it atomic
when there are multi-threaded users.

>=20
> And QOM references held by the requests are not necessary, because
> anyway the requests won't survive scsi_qdev_unrealize (at which
> point the device is certainly alive).  I'll test this, add some
> comments and send a patch:

Avoiding QOM ref/unref would be nice.

Stefan

--XYFXWxUy0WWdYtMQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj/wD4ACgkQnKSrs4Gr
c8h/tQgAmV2ioVQyxcnM+eLetO5ixI7DNJzBmpDjtnfjG8xLONYKlMEW3t83fBNG
y0Y9vv4LbhhJ50D2MLknmuelQ5DOPCN94hPBNvoWHV8qYCAe7YIg3ACuM29tGmZp
1OpN2v+isxeF0oZm4camSm0XpM9BZyvv0eSXwdB0Vtuux4D5om7UDK/1IoclSth8
ompXkhSIeI2bvpB0LVyHKxTc6/IjDXVIItwpNbbP8RY5s4YqygCgVjAgD/zWQ0x5
o2PhfG+1dkuDl/swydtbUj+29QObCvZ4ObX14hOeBfsiJwQgpN5g0fYgERZLl6z4
2n84cGljlcw30DeC312Bh1XGVHnHjg==
=QW87
-----END PGP SIGNATURE-----

--XYFXWxUy0WWdYtMQ--


