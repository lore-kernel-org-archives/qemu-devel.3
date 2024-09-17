Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8771C35FEE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 07:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqSzT-0000v6-OB; Tue, 17 Sep 2024 03:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqSzS-0000u4-9X
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 03:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqSzQ-0000VU-Gv
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 03:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726559442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zBDsLdNkar1ybOrbMweizTymW79wd7HzWTHJRqDdT/k=;
 b=Oo+VVlrBVkQcZFd9jOHQjvbl4tYb5W1Mt7906yafVeeZJ/L/hltEnrOwTnC3Bdf9oYrrtT
 9w6496+buepmWOVGLtv49m0sLbn2+GVk9NMCp1nxCDCTNV6MEbBn1mjt0xL5/apK9rRpVc
 uAygPsAjSpJ3mL2ITDPFrLhoEHtBqew=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-Fo7t1AdGNj6xILkeGs18Tg-1; Tue,
 17 Sep 2024 03:50:39 -0400
X-MC-Unique: Fo7t1AdGNj6xILkeGs18Tg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A2661955D4B; Tue, 17 Sep 2024 07:50:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.41])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A0851956086; Tue, 17 Sep 2024 07:50:35 +0000 (UTC)
Date: Tue, 17 Sep 2024 09:50:33 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, david@redhat.com,
 jasowang@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Subject: Re: [PATCH v3 3/5] vhost_user: Add frontend command for shmem config
Message-ID: <20240917075033.GC575885@fedora.redhat.com>
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-4-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5S0BR6VSxcOk5sIE"
Content-Disposition: inline
In-Reply-To: <20240912145335.129447-4-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--5S0BR6VSxcOk5sIE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 04:53:33PM +0200, Albert Esteve wrote:
> The frontend can use this command to retrieve
> VIRTIO Shared Memory Regions configuration from
> the backend. The response contains the number of
> shared memory regions, their size, and shmid.
>=20
> This is useful when the frontend is unaware of
> specific backend type and configuration,
> for example, in the `vhost-user-device` case.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c            | 45 +++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-backend.h |  6 +++++
>  include/hw/virtio/vhost-user.h    |  1 +
>  3 files changed, 52 insertions(+)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index de0bb35257..83f5c02bea 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -57,6 +57,8 @@
>   */
>  #define VHOST_USER_MAX_CONFIG_SIZE 256
> =20
> +#define VHOST_USER_MAX_SHMEM_REGIONS 256
> +
>  #define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MA=
X) - 1)
> =20
>  typedef enum VhostUserRequest {
> @@ -104,6 +106,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_GET_SHARED_OBJECT =3D 41,
>      VHOST_USER_SET_DEVICE_STATE_FD =3D 42,
>      VHOST_USER_CHECK_DEVICE_STATE =3D 43,
> +    VHOST_USER_GET_SHMEM_CONFIG =3D 44,
>      VHOST_USER_MAX
>  } VhostUserRequest;
> =20
> @@ -138,6 +141,12 @@ typedef struct VhostUserMemRegMsg {
>      VhostUserMemoryRegion region;
>  } VhostUserMemRegMsg;
> =20
> +typedef struct VhostUserShMemConfig {
> +    uint32_t nregions;
> +    uint32_t padding;
> +    uint64_t memory_sizes[VHOST_MEMORY_BASELINE_NREGIONS];

I think this should be VHOST_USER_MAX_SHMEM_REGIONS.

> +} VhostUserShMemConfig;
> +
>  typedef struct VhostUserLog {
>      uint64_t mmap_size;
>      uint64_t mmap_offset;
> @@ -245,6 +254,7 @@ typedef union {
>          VhostUserShared object;
>          VhostUserTransferDeviceState transfer_state;
>          VhostUserMMap mmap;
> +        VhostUserShMemConfig shmem;
>  } VhostUserPayload;
> =20
>  typedef struct VhostUserMsg {
> @@ -3134,6 +3144,40 @@ static int vhost_user_check_device_state(struct vh=
ost_dev *dev, Error **errp)
>      return 0;
>  }
> =20
> +static int vhost_user_get_shmem_config(struct vhost_dev *dev,
> +                                       int *nregions,
> +                                       uint64_t *memory_sizes,
> +                                       Error **errp)
> +{
> +    int ret;
> +    VhostUserMsg msg =3D {
> +        .hdr.request =3D VHOST_USER_GET_SHMEM_CONFIG,
> +        .hdr.flags =3D VHOST_USER_VERSION,
> +    };
> +
> +    if (!virtio_has_feature(dev->protocol_features,
> +                            VHOST_USER_PROTOCOL_F_SHMEM)) {
> +        return 0;
> +    }
> +
> +    ret =3D vhost_user_write(dev, &msg, NULL, 0);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret =3D vhost_user_read(dev, &msg);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    assert(msg.payload.shmem.nregions <=3D VHOST_USER_MAX_SHMEM_REGIONS);
> +    *nregions =3D msg.payload.shmem.nregions;
> +    memcpy(memory_sizes,
> +           &msg.payload.shmem.memory_sizes,
> +           sizeof(uint64_t) * VHOST_MEMORY_BASELINE_NREGIONS);
> +    return 0;
> +}
> +
>  const VhostOps user_ops =3D {
>          .backend_type =3D VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init =3D vhost_user_backend_init,
> @@ -3172,4 +3216,5 @@ const VhostOps user_ops =3D {
>          .vhost_supports_device_state =3D vhost_user_supports_device_stat=
e,
>          .vhost_set_device_state_fd =3D vhost_user_set_device_state_fd,
>          .vhost_check_device_state =3D vhost_user_check_device_state,
> +        .vhost_get_shmem_config =3D vhost_user_get_shmem_config,
>  };
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
> index 70c2e8ffee..f9c2955420 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -159,6 +159,11 @@ typedef int (*vhost_set_device_state_fd_op)(struct v=
host_dev *dev,
>                                              int *reply_fd,
>                                              Error **errp);
>  typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error =
**errp);
> +typedef int (*vhost_get_shmem_config_op)(struct vhost_dev *dev,
> +                                         int *nregions,
> +                                         uint64_t *memory_sizes,
> +                                         Error **errp);
> +
> =20
>  typedef struct VhostOps {
>      VhostBackendType backend_type;
> @@ -214,6 +219,7 @@ typedef struct VhostOps {
>      vhost_supports_device_state_op vhost_supports_device_state;
>      vhost_set_device_state_fd_op vhost_set_device_state_fd;
>      vhost_check_device_state_op vhost_check_device_state;
> +    vhost_get_shmem_config_op vhost_get_shmem_config;
>  } VhostOps;
> =20
>  int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
> index 324cd8663a..d4bb2c3958 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -32,6 +32,7 @@ enum VhostUserProtocolFeature {
>      /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
>      VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 18,
>      VHOST_USER_PROTOCOL_F_DEVICE_STATE =3D 19,
> +    VHOST_USER_PROTOCOL_F_SHMEM =3D 20,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
> =20
> --=20
> 2.45.2
>=20

--5S0BR6VSxcOk5sIE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbpNMkACgkQnKSrs4Gr
c8iAPQf+ILSiZgnGUgfvJ/vw5XYQGSOGRVICp4qoazhhoUvqkMxlJ+J/fcIwxSxg
LWBgNTMtSComotdwjcBs/RV4/uGj34az5ZvqPRr7wmhpFaROAiU1zmpUM9ZXkmGG
VsUVy4wqmmLjVRQXaICdsEbeZFXlRIJlky+wYCwPqY2lVff+NC1T2p7nudMIyojs
HeDCbbRHZ/Bf+m2BA6ZRK3OVY5noiBDh6E2Rah5xQ19WcnUJ+UetR7DxP3Euf+KI
HMZO64TSO7rfzsDpO4Vk7Y+hS+Iuma3MP2SSio0FTQIPo7Mcy+gnuKb3Cdna1W8u
nvazTfvghTz7zPsdWBIGJt1JeaaTCw==
=FTQD
-----END PGP SIGNATURE-----

--5S0BR6VSxcOk5sIE--


