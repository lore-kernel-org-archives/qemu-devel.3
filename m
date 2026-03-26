Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4585010A88D4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5n11-0000bD-Fi; Thu, 26 Mar 2026 11:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5n0z-0000ax-Sr
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5n0y-0007aV-1u
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774540374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cow9JKCFXuC72wFVknLLm7bBQQk8rU8lQu13wbOx15k=;
 b=cZqp9LWTeJcS2tWhtiOL7a0gl9aF6YXDzyZVgKmIVR971hwPGdhScIYobevbz1DoxIpCGV
 2ikIoPCf3AKjBFbJBj0Ui/92pf0J0MZwkUV1PEawzqRH2ZBwf1OpbWYbA66FN6HA0Vn6VX
 oQGPXTBXNnxkwAFHoDlmqx56vu/j/gM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-I-7dPt8QPUaGsf1mcUYliQ-1; Thu,
 26 Mar 2026 11:52:48 -0400
X-MC-Unique: I-7dPt8QPUaGsf1mcUYliQ-1
X-Mimecast-MFC-AGG-ID: I-7dPt8QPUaGsf1mcUYliQ_1774540367
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BE711800614; Thu, 26 Mar 2026 15:52:46 +0000 (UTC)
Received: from localhost (unknown [10.45.226.37])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8187F19560B1; Thu, 26 Mar 2026 15:52:42 +0000 (UTC)
Date: Thu, 26 Mar 2026 11:52:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, virtio-fs@lists.linux.dev,
 zhenwei pi <zhenwei.pi@linux.dev>, Hanna Reitz <hreitz@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Milan Zamazal <mzamazal@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 4/4] vhost-user: add skip_drain param to GET_VRING_BASE
Message-ID: <20260326155241.GE758087@fedora>
References: <20260311084728.751169-1-dtalexundeer@yandex-team.ru>
 <20260311084728.751169-5-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pqgfetn8TJeF5gYm"
Content-Disposition: inline
In-Reply-To: <20260311084728.751169-5-dtalexundeer@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Pqgfetn8TJeF5gYm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 01:47:28PM +0500, Alexandr Moshkov wrote:
> In case of migration of QEMU from the new version (where the
> inllight-migration parameter is present), to the old one (where it is
> absent) there is no way to disable this feature on the backend during
> runtime.
>=20
> This commit slightly changes the semantics of the protocol feature
> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT. Enabling this feature
> adds a new parameter for GET_VRING_BASE, which allows to control the
> drain in-flight requests on the backend.
> Thus, QEMU will be able to turn this feature on GET_VRING_BASE off and
> on anytime.
>=20
> In vhost-user-blk use inflight_migration param to enable skip_drain to
> suspend in-flight I/O requests, and then migrate them throught inflight
> subsection.
>=20
> Also now QEMU will always try to setup
> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT protocol featrue with
> backend. This will allow to use skip_drain parameter on GET_VRING_BASE
> message.
>=20
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  docs/interop/vhost-user.rst    |  6 ++----
>  hw/block/vhost-user-blk.c      | 29 +++++++++++++++++++++++------
>  hw/virtio/vhost-user.c         |  3 +--
>  hw/virtio/vhost.c              |  4 +---
>  include/hw/virtio/vhost-user.h |  1 -
>  5 files changed, 27 insertions(+), 16 deletions(-)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index bfa75ff9a3..63efc87264 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1255,14 +1255,12 @@ Front-end message types
>    *suspended*, see :ref:`Suspended device state
>    <suspended_device_state>`.
> =20
> -  The request payload's *num* field is currently reserved and must be
> -  set to 0.
> -
>    By default, the back-end must complete all inflight I/O requests for t=
he
>    specified vring before stopping it.
> =20
>    If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
> -  feature has been negotiated, the back-end may suspend in-flight I/O
> +  feature has been negotiated, using request payload's *num* field,
> +  when *num* is set to 1, QEMU can tell the back-end to suspend in-fligh=
t I/O
>    requests and record them as described in :ref:`Inflight I/O tracking
>    <inflight_io_tracking>` instead of completing them before stopping the=
 vring.
>    How to suspend an in-flight request depends on the implementation of t=
he back-end
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 1dc49c104e..8cc80eb0c3 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -134,10 +134,7 @@ static bool vhost_user_blk_inflight_needed(void *opa=
que)
>  {
>      struct VHostUserBlk *s =3D opaque;
> =20
> -    bool inflight_migration =3D virtio_has_feature(s->dev.protocol_featu=
res,
> -                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFL=
IGHT);
> -
> -    return inflight_migration;
> +    return s->inflight_migration;
>  }
> =20
> =20
> @@ -232,11 +229,14 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>          return 0;
>      }
> =20
> +    bool skip_drain =3D vhost_user_blk_inflight_needed(s) &&
> +                      runstate_check(RUN_STATE_FINISH_MIGRATE);
> +
>      force_stop =3D s->skip_get_vring_base_on_force_shutdown &&
>                   qemu_force_shutdown_requested();
> =20
>      ret =3D force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
> -                       vhost_dev_stop(&s->dev, vdev, true, false);
> +                       vhost_dev_stop(&s->dev, vdev, true, skip_drain);
> =20
>      if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) {
>          error_report("vhost guest notifier cleanup failed: %d", ret);
> @@ -364,7 +364,6 @@ static int vhost_user_blk_connect(DeviceState *dev, E=
rror **errp)
>      vhost_dev_set_config_notifier(&s->dev, &blk_ops);
> =20
>      s->vhost_user.supports_config =3D true;
> -    s->vhost_user.supports_inflight_migration =3D s->inflight_migration;
>      ret =3D vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_U=
SER, 0,
>                           errp);
>      if (ret < 0) {
> @@ -580,10 +579,28 @@ static struct vhost_dev *vhost_user_blk_get_vhost(V=
irtIODevice *vdev)
>      return &s->dev;
>  }
> =20
> +static bool vhost_user_blk_pre_save(void *opaqueue, Error **errp)
> +{
> +    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);

This won't compile. "opaqueue" is unused and the vdev variable does not
exist.

> +
> +    bool inflight_migration_enabled =3D vhost_user_has_protocol_feature(=
&s->dev,

vhost_user_has_protocol_feature() does not exist.

> +                            VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGH=
T);
> +    if (vhost_user_blk_inflight_needed(s) && !inflight_migration_enabled=
) {
> +        error_setg(errp, "can't migrate vhost-user-blk device: "
> +                         "backend doesn't support "
> +                         "VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT "
> +                         "protocol feature");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static const VMStateDescription vmstate_vhost_user_blk_inflight =3D {
>      .name =3D "vhost-user-blk/inflight",
>      .version_id =3D 1,
>      .needed =3D vhost_user_blk_inflight_needed,
> +    .pre_save_errp =3D vhost_user_blk_pre_save,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
>          VMSTATE_END_OF_LIST()
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index bb8f8eab77..ed95ec7523 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2225,8 +2225,7 @@ static int vhost_user_backend_init(struct vhost_dev=
 *dev, void *opaque,
>              }
>          }
> =20
> -        if (!u->user->supports_inflight_migration ||
> -            !virtio_has_feature(protocol_features,
> +        if (!virtio_has_feature(protocol_features,
>                                  VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
>              protocol_features &=3D ~(1ULL <<
>                                 VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFL=
IGHT);
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 4e196fc773..c04bb53159 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1390,12 +1390,10 @@ static int do_vhost_virtqueue_stop(struct vhost_d=
ev *dev,
>                                     unsigned idx, bool force,
>                                     bool skip_drain)
>  {
> -    /* TODO: support skip drain */
> -    assert(!skip_drain);

The following assertion would be useful:

  if (skip_drain) {
      assert(virtio_has_feature(...protocol_features...,
              VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT));
  }

> -
>      int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, idx);
>      struct vhost_vring_state state =3D {
>          .index =3D vhost_vq_index,
> +        .num =3D skip_drain,
>      };
>      int r =3D 0;
> =20
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
> index 53fe996686..c95bad5ddc 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -69,7 +69,6 @@ typedef struct VhostUserState {
>      GPtrArray *notifiers;
>      int memory_slots;
>      bool supports_config;
> -    bool supports_inflight_migration;
>  } VhostUserState;
> =20
>  /**
> --=20
> 2.34.1
>=20

--Pqgfetn8TJeF5gYm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnFVkkACgkQnKSrs4Gr
c8iwHgf/eUHChslddhQJiBdr7DqWZC6eY5aEJil7OmedxVE32X3/zCPuDnYxbi/S
srPA7W4MoFOfaqRsNmOoNLies/gRjh6OtRoDLcGs37b4n/YWooySnevXcPPJgVJg
11MiK8Jztj+pBfDTlXRGMTQMlMr9Y59RNe1mVL4ni64lQJCTGs6OIvVw0ypzePNV
c04WhffltjJ8bxkYO//jYfoYRukVE9hxkQlxV8NKbBQPtKz8bXgYI/ScPJWmHLAO
Mh8d6hAX/KlscOg0SiLMTAJ45f7xHTqUB4EoaNeYXqjJVcEUGZMkG6PEIUrHjMgF
fdskGGLJhqnwxYFzMI02k0hEBVOclA==
=UI0L
-----END PGP SIGNATURE-----

--Pqgfetn8TJeF5gYm--


