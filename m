Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE3CC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkKpm-0007SB-TC; Tue, 18 Feb 2025 05:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkKpl-0007Ru-0c
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:28:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkKpi-00087a-JX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739874484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IX9UD2IfAvwERxh368QAytxdnRCmpZRbaTg49VxtAos=;
 b=I78cV7cv4Vl3kALyPr0ZqgO0F2mJ5FMCSEDHGMRlLkbvQ9KehZYs05YG0zOfSWYqE6ez2X
 Yn81uYKNLxAOeEZ3aKwKCp67ut7B3s5BjnGCiUZVw6cwMLg0CPVfPEZ/iT4MCGKUe2b3UQ
 7ifvcKC4H8PADPTRUTaS5DxG1mR9u40=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-ZvLOHmMuNHCcWo2tqNn3kg-1; Tue,
 18 Feb 2025 05:27:58 -0500
X-MC-Unique: ZvLOHmMuNHCcWo2tqNn3kg-1
X-Mimecast-MFC-AGG-ID: ZvLOHmMuNHCcWo2tqNn3kg_1739874477
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2942E1800877; Tue, 18 Feb 2025 10:27:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40EB019560A3; Tue, 18 Feb 2025 10:27:54 +0000 (UTC)
Date: Tue, 18 Feb 2025 18:27:52 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 hi@alyssa.is, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v4 4/9] vhost_user: Add frontend get_shmem_config command
Message-ID: <20250218102752.GH10767@fedora>
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-5-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pW9zSus2ZkBksSji"
Content-Disposition: inline
In-Reply-To: <20250217164012.246727-5-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--pW9zSus2ZkBksSji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 05:40:07PM +0100, Albert Esteve wrote:
> The frontend can use this command to retrieve
> VirtIO Shared Memory Regions configuration from
> the backend. The response contains the number of
> shared memory regions, their size, and shmid.
>=20
> This is useful when the frontend is unaware of
> specific backend type and configuration,
> for example, in the `vhost-user-device` case.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c            | 43 +++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-backend.h |  9 +++++++
>  include/hw/virtio/vhost-user.h    |  1 +
>  include/hw/virtio/virtio.h        |  2 ++
>  4 files changed, 55 insertions(+)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index d88e6f8c3c..9cc148f726 100644
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
> +    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
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
> @@ -3146,6 +3154,40 @@ static int vhost_user_check_device_state(struct vh=
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
> +    assert(msg.payload.shmem.nregions <=3D VIRTIO_MAX_SHMEM_REGIONS);
> +    *nregions =3D msg.payload.shmem.nregions;
> +    memcpy(memory_sizes,
> +           &msg.payload.shmem.memory_sizes,
> +           sizeof(uint64_t) * VHOST_MEMORY_BASELINE_NREGIONS);

Should this be VIRTIO_MAX_SHMEM_REGIONS instead of
VHOST_MEMORY_BASELINE_NREGIONS?

> +    return 0;
> +}
> +
>  const VhostOps user_ops =3D {
>          .backend_type =3D VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init =3D vhost_user_backend_init,
> @@ -3184,4 +3226,5 @@ const VhostOps user_ops =3D {
>          .vhost_supports_device_state =3D vhost_user_supports_device_stat=
e,
>          .vhost_set_device_state_fd =3D vhost_user_set_device_state_fd,
>          .vhost_check_device_state =3D vhost_user_check_device_state,
> +        .vhost_get_shmem_config =3D vhost_user_get_shmem_config,
>  };
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
> index 70c2e8ffee..b40d82a111 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -159,6 +159,14 @@ typedef int (*vhost_set_device_state_fd_op)(struct v=
host_dev *dev,
>                                              int *reply_fd,
>                                              Error **errp);
>  typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error =
**errp);
> +/*
> + * Max regions is VIRTIO_MAX_SHMEM_REGIONS, so that is the maximum
> + * number of memory_sizes that will be accepted. */
> +typedef int (*vhost_get_shmem_config_op)(struct vhost_dev *dev,
> +                                         int *nregions,
> +                                         uint64_t *memory_sizes,
> +                                         Error **errp);
> +
> =20
>  typedef struct VhostOps {
>      VhostBackendType backend_type;
> @@ -214,6 +222,7 @@ typedef struct VhostOps {
>      vhost_supports_device_state_op vhost_supports_device_state;
>      vhost_set_device_state_fd_op vhost_set_device_state_fd;
>      vhost_check_device_state_op vhost_check_device_state;
> +    vhost_get_shmem_config_op vhost_get_shmem_config;
>  } VhostOps;
> =20
>  int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
> index 9a3f238b43..bacc7d184c 100644
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
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index a778547c79..319e2f5b06 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -81,6 +81,8 @@ typedef struct VirtQueueElement
> =20
>  #define VIRTIO_NO_VECTOR 0xffff
> =20
> +#define VIRTIO_MAX_SHMEM_REGIONS 256
> +
>  /* special index value used internally for config irqs */
>  #define VIRTIO_CONFIG_IRQ_IDX -1
> =20
> --=20
> 2.48.1
>=20

--pW9zSus2ZkBksSji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme0YKgACgkQnKSrs4Gr
c8gkuQf7BbWxFeHyak6tz4ll9SnT99IRIEAFmlNcJ+FX4mSdSLD9JDawv3E3UhAc
k1df7JWSI7KWb53V8BahS016WeL17nS4USIcOWkBvJGKw9lfCcbe71kvHM5lEsrs
bqsQiSKgS/4Ae3J7UPcY8N7GUWM1B12LIsiwZOv2tHZ7jVhF0Eh48AUtuI1Dgepw
ypHD06fYfklAUBbAVNBIR5XLET/GyQxHCdpSBph3H0R/jCeN/nEpCkgduIdcfF36
jyVMaeA8n64KrGf6ARa5GAUaA8UgxQqwXwHUDQ4ufpy0s30jigtv2x2J4ssJXVA0
69+olNsM+7pJxBhAXGbbaOfFzrv6aw==
=uVf+
-----END PGP SIGNATURE-----

--pW9zSus2ZkBksSji--


