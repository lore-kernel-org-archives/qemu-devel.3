Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37988C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRot8-0004LF-To; Thu, 11 Jul 2024 04:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRot7-0004GR-L4
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRot4-0003Hp-NT
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720685445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BfM8i/RVIKZAVXEjxV7ooO1ORu1Fs6L5Q+zIos5MOjE=;
 b=USYCQzO4NmAdbYinANvum/dv7jC3qybKZS7g1L3Z0osd7I0/kO8GHKy9ZmR4u6XymyBesr
 qx6Qf0kOWj5mfQtRvq9u4x5L2tge2C9heGimPygOuOYmtqoUEVHEGNySCH54KXQN7ECCi6
 gAov6A0rLeAih0QwpyyExOcIC35+/aw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-DxaGoiOSPoOQog2Ve9Ya5g-1; Thu,
 11 Jul 2024 04:10:40 -0400
X-MC-Unique: DxaGoiOSPoOQog2Ve9Ya5g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 848C519361AC; Thu, 11 Jul 2024 08:10:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F166A1956046; Thu, 11 Jul 2024 08:10:37 +0000 (UTC)
Date: Thu, 11 Jul 2024 10:10:36 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com,
 slp@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v2 2/5] vhost_user: Add frontend command for shmem
 config
Message-ID: <20240711081036.GD563880@dynamic-pd01.res.v6.highway.a1.net>
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-3-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QWvl0FTyJBUg9ZbD"
Content-Disposition: inline
In-Reply-To: <20240628145710.1516121-3-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--QWvl0FTyJBUg9ZbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 04:57:07PM +0200, Albert Esteve wrote:
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
>  docs/interop/vhost-user.rst       | 31 +++++++++++++++++++++++
>  hw/virtio/vhost-user.c            | 42 +++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-backend.h |  6 +++++
>  include/hw/virtio/vhost-user.h    |  1 +
>  4 files changed, 80 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index d52ba719d5..51f01d1d84 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -348,6 +348,19 @@ Device state transfer parameters
>    In the future, additional phases might be added e.g. to allow
>    iterative migration while the device is running.
> =20
> +VIRTIO Shared Memory Region configuration
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-------------+---------+------------+----+------------+
> +| num regions | padding | mem size 0 | .. | mem size 7 |
> ++-------------+---------+------------+----+------------+

8 regions may not be enough. The max according to the VIRTIO spec is
256 because virtio-pci uses an 8-bit cap.id field for the shmid. I think
the maximum number should be 256 here.

(I haven't checked the QEMU vhost-user code to see whether it's
reasonable to hardcode to 256 or some logic if needed to dynamically
size the buffer depending on the "num regions" field.)

> +
> +:num regions: a 32-bit number of regions
> +
> +:padding: 32-bit
> +
> +:mem size: 64-bit size of VIRTIO Shared Memory Region
> +
>  C structure
>  -----------
> =20
> @@ -369,6 +382,10 @@ In QEMU the vhost-user message is implemented with t=
he following struct:
>            VhostUserConfig config;
>            VhostUserVringArea area;
>            VhostUserInflight inflight;
> +          VhostUserShared object;
> +          VhostUserTransferDeviceState transfer_state;
> +          VhostUserMMap mmap;

Why are these added by this patch? Please add them in the same patch
where they are introduced.

> +          VhostUserShMemConfig shmem;
>        };
>    } QEMU_PACKED VhostUserMsg;
> =20
> @@ -1051,6 +1068,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
> =20
>  Front-end message types
>  -----------------------
> @@ -1725,6 +1743,19 @@ Front-end message types
>    Using this function requires prior negotiation of the
>    ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
> =20
> +``VHOST_USER_GET_SHMEM_CONFIG``
> +  :id: 44
> +  :equivalent ioctl: N/A
> +  :request payload: N/A
> +  :reply payload: ``struct VhostUserShMemConfig``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the front-end
> +  to gather the VIRTIO Shared Memory Region configuration. Back-end will=
 respond
> +  with the number of VIRTIO Shared Memory Regions it requires, and each =
shared memory
> +  region size in an array. The shared memory IDs are represented by the =
index
> +  of the array.

Is the information returned by SHMEM_CONFIG valid and unchanged for the
entire lifetime of the vhost-user connection?

I think the answer is yes because the enumeration that virtio-pci and
virtio-mmio transports support is basically a one-time operation at
driver startup and it is static (Shared Memory Regions do not appear or
go away at runtime). Please be explicit how VHOST_USER_GET_SHMEM_CONFIG
is intended to be used.

> +
>  Back-end message types
>  ----------------------
> =20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 7ee8a472c6..57406dc8b4 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -104,6 +104,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_GET_SHARED_OBJECT =3D 41,
>      VHOST_USER_SET_DEVICE_STATE_FD =3D 42,
>      VHOST_USER_CHECK_DEVICE_STATE =3D 43,
> +    VHOST_USER_GET_SHMEM_CONFIG =3D 44,
>      VHOST_USER_MAX
>  } VhostUserRequest;
> =20
> @@ -138,6 +139,12 @@ typedef struct VhostUserMemRegMsg {
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
> @@ -245,6 +252,7 @@ typedef union {
>          VhostUserShared object;
>          VhostUserTransferDeviceState transfer_state;
>          VhostUserMMap mmap;
> +        VhostUserShMemConfig shmem;
>  } VhostUserPayload;
> =20
>  typedef struct VhostUserMsg {
> @@ -3136,6 +3144,39 @@ static int vhost_user_check_device_state(struct vh=
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
> +    *nregions =3D msg.payload.shmem.nregions;

Missing input validation from the untrusted vhost-user backend. nregions
may be out of range.

> +    memcpy(memory_sizes,
> +           &msg.payload.shmem.memory_sizes,
> +           sizeof(uint64_t) * VHOST_MEMORY_BASELINE_NREGIONS);
> +    return 0;
> +}
> +
>  const VhostOps user_ops =3D {
>          .backend_type =3D VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init =3D vhost_user_backend_init,
> @@ -3174,4 +3215,5 @@ const VhostOps user_ops =3D {
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
> index d7c09ffd34..e1b587a908 100644
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

--QWvl0FTyJBUg9ZbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaPk3wACgkQnKSrs4Gr
c8h4eQgAw+FV/mkyYHxhyni8w0p7APFRiJaVXBGoQQv4vHKN7dQmEsQkP/vY2Sfy
c23+WdqodYseEsMjYXaTORQlbQBJ6WB6eDAPCa8hc+pp+baKSAiITd+YKXOH0ATC
3BcHT6cNIgP5afUcm5k1/V803m+2zZVnnEtJvuAmtVpRnpgCYoldeH6v4sXDeWsO
Wa+j/CBZaq/q5anDmLDjBsFGLd0iDMjBrsmeLxGZcfFTtkdnlVB14Pcl52SDm7hG
sjDCh0NNA5jAnwe7I7N21/8Rt4XSNQ2GegKVQOczl5IvwtMS5S3k13Du3nKrKfmA
8/5whJC01zgTq0q+Ezqb/e/bi1GiiA==
=qCQv
-----END PGP SIGNATURE-----

--QWvl0FTyJBUg9ZbD--


