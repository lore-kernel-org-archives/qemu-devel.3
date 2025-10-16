Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3E2CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Sey-00035y-Te; Thu, 16 Oct 2025 14:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v9Sex-00035U-65
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v9Sep-0006Yq-Sh
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760639096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3fidhfoyBq64IDX//20Z7AIalZaULKxBOB3GYXSbwu0=;
 b=Z8lJYwoCkRAbFtAEomn33mHSXA1apXNTYA0ft8vXT6Lx0azfIufXTlTsRtrDi4cZ6GEfUs
 MxqzxTQVe9vYkLPYrvUk0d2cieleBIQ6FA+ne2X8kmyBVlTPChQzrI96U7nLwTYpz4m3Xk
 m/MdXfXq2dPLR905OQsEPh98TtWxxZU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-VFoZYi0gPrW6iXZPKmWAaQ-1; Thu,
 16 Oct 2025 14:24:52 -0400
X-MC-Unique: VFoZYi0gPrW6iXZPKmWAaQ-1
X-Mimecast-MFC-AGG-ID: VFoZYi0gPrW6iXZPKmWAaQ_1760639090
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E38E180035D; Thu, 16 Oct 2025 18:24:49 +0000 (UTC)
Received: from localhost (unknown [10.2.17.104])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F2701956056; Thu, 16 Oct 2025 18:24:47 +0000 (UTC)
Date: Thu, 16 Oct 2025 13:58:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net,
 mst@redhat.com, kwolf@redhat.com, qemu-stable@nongnu.org
Subject: Re: [RFC] hw/scsi: avoid deadlock upon TMF request canceling with
 VirtIO
Message-ID: <20251016175857.GA1174862@fedora>
References: <20251015134351.380079-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SKvWfJFSQQNxvZw+"
Content-Disposition: inline
In-Reply-To: <20251015134351.380079-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--SKvWfJFSQQNxvZw+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 03:43:50PM +0200, Fiona Ebner wrote:
> When scsi_req_dequeue() is reached via
> scsi_req_cancel_async()
> virtio_scsi_tmf_cancel_req()
> virtio_scsi_do_tmf_aio_context(),
> there is a deadlock when trying to acquire the SCSI device's requests
> lock, because it was already acquired in
> virtio_scsi_do_tmf_aio_context().
>=20
> In particular, the issue happens with a FreeBSD guest (13, 14, 15,
> maybe more), when it cancels SCSI requests, because of timeout.
>=20
> This is a regression caused by commit da6eebb33b ("virtio-scsi:
> perform TMFs in appropriate AioContexts") and the introduction of the
> requests_lock earlier.
>=20
> Keep track of whether the device's requests lock is already being held
> and do not re-acquire it in scsi_req_dequeue() to fix the issue. Since
> scsi_req_dequeue() removes entries from the queue, it's necessary to
> switch to the safe variant when iterating in
> virtio_scsi_do_tmf_aio_context().
>=20
> Originally reported by Proxmox VE users:
> https://bugzilla.proxmox.com/show_bug.cgi?id=3D6810
> https://forum.proxmox.com/threads/173914/
>=20
> Fixes: da6eebb33b ("virtio-scsi: perform TMFs in appropriate AioContexts")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>=20
> RFC, because it's a naive approach, maybe somebody has a better idea?

Hi Fiona,
Thanks for figuring out this bug!

Another approach is the one taken in scsi_device_for_each_req_async_bh()
where requests from this AioContext are collected into a GList and then
processed after releasing s->requests_lock. It's safe because the
function runs in the request's AioContext and we know nothing else can
modify the request while we are running. The same constraint applies in
this case too.

That solution is more localized because various function prototypes
don't need to be extended with holds_requests_lock. Either it can be
open coded inside virtio_scsi_do_tmf_aio_context() or you could extract
a helper function from scsi_device_for_each_req_async_bh() in scsi-bus.c
and call the new helper from virtio_scsi_do_tmf_aio_context().

I slightly prefer a localized fix so that other parts of the codebase
don't need to worry about whether or not requests_lock is held. Do you
want to try implementing that?

Thanks,
Stefan

>=20
>  hw/scsi/mptsas.c       |  4 ++--
>  hw/scsi/scsi-bus.c     | 25 +++++++++++++++----------
>  hw/scsi/virtio-scsi.c  |  8 ++++++--
>  include/hw/scsi/scsi.h |  3 ++-
>  4 files changed, 25 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
> index 4ada35b7ec..30d773235c 100644
> --- a/hw/scsi/mptsas.c
> +++ b/hw/scsi/mptsas.c
> @@ -466,7 +466,7 @@ static void mptsas_process_scsi_task_mgmt(MPTSASState=
 *s, MPIMsgSCSITaskMgmt *re
>                  notifier->s =3D s;
>                  notifier->reply =3D reply_async;
>                  notifier->notifier.notify =3D mptsas_cancel_notify;
> -                scsi_req_cancel_async(r, &notifier->notifier);
> +                scsi_req_cancel_async(r, &notifier->notifier, false);
>                  goto reply_maybe_async;
>              }
>          }
> @@ -498,7 +498,7 @@ static void mptsas_process_scsi_task_mgmt(MPTSASState=
 *s, MPIMsgSCSITaskMgmt *re
>                  notifier->s =3D s;
>                  notifier->reply =3D reply_async;
>                  notifier->notifier.notify =3D mptsas_cancel_notify;
> -                scsi_req_cancel_async(r, &notifier->notifier);
> +                scsi_req_cancel_async(r, &notifier->notifier, false);
>              }
>          }
> =20
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 9b12ee7f1c..827b85a68f 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -19,7 +19,7 @@
> =20
>  static char *scsibus_get_dev_path(DeviceState *dev);
>  static char *scsibus_get_fw_dev_path(DeviceState *dev);
> -static void scsi_req_dequeue(SCSIRequest *req);
> +static void scsi_req_dequeue(SCSIRequest *req, bool holds_requests_lock);
>  static uint8_t *scsi_target_alloc_buf(SCSIRequest *req, size_t len);
>  static void scsi_target_free_buf(SCSIRequest *req);
>  static void scsi_clear_reported_luns_changed(SCSIRequest *req);
> @@ -290,7 +290,7 @@ static void scsi_dma_restart_req(SCSIRequest *req, vo=
id *opaque)
>                  scsi_req_continue(req);
>                  break;
>              case SCSI_XFER_NONE:
> -                scsi_req_dequeue(req);
> +                scsi_req_dequeue(req, false);
>                  scsi_req_enqueue(req);
>                  break;
>          }
> @@ -1029,13 +1029,17 @@ int32_t scsi_req_enqueue(SCSIRequest *req)
>      return rc;
>  }
> =20
> -static void scsi_req_dequeue(SCSIRequest *req)
> +static void scsi_req_dequeue(SCSIRequest *req, bool holds_requests_lock)
>  {
>      trace_scsi_req_dequeue(req->dev->id, req->lun, req->tag);
>      req->retry =3D false;
>      if (req->enqueued) {
> -        WITH_QEMU_LOCK_GUARD(&req->dev->requests_lock) {
> +        if (holds_requests_lock) {
>              QTAILQ_REMOVE(&req->dev->requests, req, next);
> +        } else {
> +            WITH_QEMU_LOCK_GUARD(&req->dev->requests_lock) {
> +                QTAILQ_REMOVE(&req->dev->requests, req, next);
> +            }
>          }
>          req->enqueued =3D false;
>          scsi_req_unref(req);
> @@ -1618,7 +1622,7 @@ void scsi_req_complete_failed(SCSIRequest *req, int=
 host_status)
> =20
>      req->host_status =3D host_status;
>      scsi_req_ref(req);
> -    scsi_req_dequeue(req);
> +    scsi_req_dequeue(req, false);
>      req->bus->info->fail(req);
> =20
>      /* Cancelled requests might end up being completed instead of cancel=
led */
> @@ -1647,7 +1651,7 @@ void scsi_req_complete(SCSIRequest *req, int status)
>      }
> =20
>      scsi_req_ref(req);
> -    scsi_req_dequeue(req);
> +    scsi_req_dequeue(req, false);
>      req->bus->info->complete(req, req->residual);
> =20
>      /* Cancelled requests might end up being completed instead of cancel=
led */
> @@ -1670,7 +1674,8 @@ void scsi_req_cancel_complete(SCSIRequest *req)
>   * notifier list, the bus will be notified the requests cancellation is
>   * completed.
>   * */
> -void scsi_req_cancel_async(SCSIRequest *req, Notifier *notifier)
> +void scsi_req_cancel_async(SCSIRequest *req, Notifier *notifier,
> +                           bool holds_requests_lock)
>  {
>      trace_scsi_req_cancel(req->dev->id, req->lun, req->tag);
>      if (notifier) {
> @@ -1686,7 +1691,7 @@ void scsi_req_cancel_async(SCSIRequest *req, Notifi=
er *notifier)
>      }
>      /* Dropped in scsi_req_cancel_complete.  */
>      scsi_req_ref(req);
> -    scsi_req_dequeue(req);
> +    scsi_req_dequeue(req, holds_requests_lock);
>      req->io_canceled =3D true;
>      if (req->aiocb) {
>          blk_aio_cancel_async(req->aiocb);
> @@ -1704,7 +1709,7 @@ void scsi_req_cancel(SCSIRequest *req)
>      assert(!req->io_canceled);
>      /* Dropped in scsi_req_cancel_complete.  */
>      scsi_req_ref(req);
> -    scsi_req_dequeue(req);
> +    scsi_req_dequeue(req, false);
>      req->io_canceled =3D true;
>      if (req->aiocb) {
>          blk_aio_cancel(req->aiocb);
> @@ -1782,7 +1787,7 @@ void scsi_device_set_ua(SCSIDevice *sdev, SCSISense=
 sense)
> =20
>  static void scsi_device_purge_one_req(SCSIRequest *req, void *opaque)
>  {
> -    scsi_req_cancel_async(req, NULL);
> +    scsi_req_cancel_async(req, NULL, false);
>  }
> =20
>  /**
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index d817fc42b4..48612f8738 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -315,6 +315,7 @@ static void virtio_scsi_cancel_notify(Notifier *notif=
ier, void *data)
>      g_free(n);
>  }
> =20
> +/* Must be called with r->dev->requests_lock held. */
>  static void virtio_scsi_tmf_cancel_req(VirtIOSCSIReq *tmf, SCSIRequest *=
r)
>  {
>      VirtIOSCSICancelNotifier *notifier;
> @@ -327,7 +328,7 @@ static void virtio_scsi_tmf_cancel_req(VirtIOSCSIReq =
*tmf, SCSIRequest *r)
>      notifier =3D g_new(VirtIOSCSICancelNotifier, 1);
>      notifier->notifier.notify =3D virtio_scsi_cancel_notify;
>      notifier->tmf_req =3D tmf;
> -    scsi_req_cancel_async(r, &notifier->notifier);
> +    scsi_req_cancel_async(r, &notifier->notifier, true);
>  }
> =20
>  /* Execute a TMF on the requests in the current AioContext */
> @@ -364,7 +365,9 @@ static void virtio_scsi_do_tmf_aio_context(void *opaq=
ue)
>      }
> =20
>      WITH_QEMU_LOCK_GUARD(&d->requests_lock) {
> -        QTAILQ_FOREACH(r, &d->requests, next) {
> +        SCSIRequest *tmp;
> +        /* scsi_req_dequeue() removes entries from queue, use safe itera=
tion */
> +        QTAILQ_FOREACH_SAFE(r, &d->requests, next, tmp) {
>              VirtIOSCSIReq *cmd_req =3D r->hba_private;
>              assert(cmd_req); /* request has hba_private while enqueued */
> =20
> @@ -374,6 +377,7 @@ static void virtio_scsi_do_tmf_aio_context(void *opaq=
ue)
>              if (match_tag && cmd_req->req.cmd.tag !=3D tmf->req.tmf.tag)=
 {
>                  continue;
>              }
> +            assert(&d->requests_lock =3D=3D &r->dev->requests_lock);
>              virtio_scsi_tmf_cancel_req(tmf, r);
>          }
>      }
> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> index 90ee192b4d..49b898e44a 100644
> --- a/include/hw/scsi/scsi.h
> +++ b/include/hw/scsi/scsi.h
> @@ -226,7 +226,8 @@ uint8_t *scsi_req_get_buf(SCSIRequest *req);
>  int scsi_req_get_sense(SCSIRequest *req, uint8_t *buf, int len);
>  void scsi_req_cancel_complete(SCSIRequest *req);
>  void scsi_req_cancel(SCSIRequest *req);
> -void scsi_req_cancel_async(SCSIRequest *req, Notifier *notifier);
> +void scsi_req_cancel_async(SCSIRequest *req, Notifier *notifier,
> +                           bool holds_requests_lock);
>  void scsi_req_retry(SCSIRequest *req);
>  void scsi_device_drained_begin(SCSIDevice *sdev);
>  void scsi_device_drained_end(SCSIDevice *sdev);
> --=20
> 2.47.3
>=20
>=20

--SKvWfJFSQQNxvZw+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjxMmEACgkQnKSrs4Gr
c8jhLwf+MYa4qQVWn8SOD/lvDTE8iEXyjXwvl7UALfM9YnEmGyH74eha4B6k6V/D
QHNg57h2TBGhuWCV+x0gD0z0zdIyaOXIGp+6EuAq2UXUool7DhYuYTpJeglLwtqU
QoOvu44XKzUxf7YN96NsdgcVizQJ64E13baGU81Hx/YeWFRwvJPCla8kANIf4ocd
76A/fJ9YN6PK1kwGdYmobr3MHsLtx6MAoYwnMoSTe0h/b/T5lp8nI29wluSd47RG
AiGXcsoXRuniJU2vr6eTkRvXIf2zfZdLftwewAVN4McFz6+mowwVH2bojiZ2a7B3
klKi04pOafNrj1gf/nrBaj0pvXlrzg==
=Y+Ia
-----END PGP SIGNATURE-----

--SKvWfJFSQQNxvZw+--


