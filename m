Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E29C35FEE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 07:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqSwq-00054Q-FA; Tue, 17 Sep 2024 03:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqSwk-00052n-Kz
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 03:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqSwi-0000AR-VP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 03:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726559304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXlK0HxNUO8ods+gFcIlUdWIsqoZRSJ335x9fVpfaG4=;
 b=LLjirnT94PUOZ0Jfs/3hcKJkmMmu3LRkBaw0cgihd0gbl2TWCYh4WeuAS54I5yRennhhLM
 AayJ35K+6+pprWv+9LFvlxBRAcaHbj6+EICQLNS3xnogzy2xA9D95buf4ofP/vkOwll2xO
 xsdFvxoF7g9KN/H3Y0zIT59WCXkVZ0k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-GE1d0Pa0MdOEwfuYmOupZA-1; Tue,
 17 Sep 2024 03:48:21 -0400
X-MC-Unique: GE1d0Pa0MdOEwfuYmOupZA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4FC01955F40; Tue, 17 Sep 2024 07:48:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.41])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D3C019560A3; Tue, 17 Sep 2024 07:48:16 +0000 (UTC)
Date: Tue, 17 Sep 2024 09:48:15 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, david@redhat.com,
 jasowang@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Subject: Re: [PATCH v3 3/5] vhost_user: Add frontend command for shmem config
Message-ID: <20240917074815.GB575885@fedora.redhat.com>
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-4-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TV+Hmd/XIUZxAKaq"
Content-Disposition: inline
In-Reply-To: <20240912145335.129447-4-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--TV+Hmd/XIUZxAKaq
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

VHOST_USER_MAX_SHMEM_REGIONS is defined inside vhost-user.c and not
visible here. However, vhost_get_shmem_config_op() assumes the caller
knows the maximum number of memory_sizes[] array elements.

I think a constant should be declared in the VIRTIO header files and a
doc comment is needed here stating that memory_sizes[] must be at least
VIRTIO_MAX_SHMEM_REGIONS.

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

--TV+Hmd/XIUZxAKaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbpND8ACgkQnKSrs4Gr
c8jY2gf9FKXe6hpesJ44jiZeUlw+z8d3lISjKQeEKB2FK+Le04NIgthvUwCgpMRl
zNWYwUO/b/jJzSxRAHrQItLhroQq+T+aFyn1SzRs+6IvwiUxGeHmfK12JKM3Mzeo
Lm+tQyFEo4CJl+iVSLExAnEPyC21RSYztxrUimXLAT2D74gBBw7JYfayc8hGwLa5
td4nxsqnLaeB5sdlYtBjOoiBLQcs9xOL0bWWJnYEHol+UgBWI5d7i9wcXMTmZkXE
0/bnkvEh/hpkKu1L8jNbsdkTtTAsl2oT/AOWy+43kfiRVKfkz9JmvB2y8WnBXhfm
35W5ffMwwqsRNH7HF/g0fUJqcpS9bw==
=QrDR
-----END PGP SIGNATURE-----

--TV+Hmd/XIUZxAKaq--


