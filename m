Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BDDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpYx-0005FV-0N; Thu, 11 Jul 2024 04:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpYu-0005DX-K3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpYr-0004o6-VA
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720688035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqZUAbISU19mZIIsXuxAGlNygxC60AJkQyw6N3Me584=;
 b=Vzq9tu83ZdboqiScLn3CboXDfOKVdFLs9ezipWqsrkAZPmIX+lKKwWCPE8lX6V4lope3fv
 3pfUiKMPWJUPLPXed7+qjRe05bCVO67dKZibqV1F+oAa366pEPzvryz7vJdbLtz03UeWZh
 O2jTetJRhBEYmfE4XI0Ky/PpoH0+OUU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-1yrLb9gdN_S8UgypuxZnwA-1; Thu,
 11 Jul 2024 04:53:53 -0400
X-MC-Unique: 1yrLb9gdN_S8UgypuxZnwA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4A2A1955F42; Thu, 11 Jul 2024 08:53:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 877553000181; Thu, 11 Jul 2024 08:53:51 +0000 (UTC)
Date: Thu, 11 Jul 2024 10:53:50 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com,
 slp@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v2 4/5] vhost_user: Add MEM_READ/WRITE backend requests
Message-ID: <20240711085350.GF563880@dynamic-pd01.res.v6.highway.a1.net>
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-5-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WZ+S2snuQvJFZd41"
Content-Disposition: inline
In-Reply-To: <20240628145710.1516121-5-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--WZ+S2snuQvJFZd41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 04:57:09PM +0200, Albert Esteve wrote:
> With SHMEM_MAP messages, sharing descriptors between
> devices will cause that these devices do not see the
> mappings, and fail to access these memory regions.
>=20
> To solve this, introduce MEM_READ/WRITE requests
> that will get triggered as a fallback when
> vhost-user memory translation fails.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c                    | 31 +++++++++
>  subprojects/libvhost-user/libvhost-user.c | 84 +++++++++++++++++++++++
>  subprojects/libvhost-user/libvhost-user.h | 38 ++++++++++
>  3 files changed, 153 insertions(+)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 57406dc8b4..18cacb2d68 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -118,6 +118,8 @@ typedef enum VhostUserBackendRequest {
>      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
>      VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
>      VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> +    VHOST_USER_BACKEND_MEM_READ =3D 11,
> +    VHOST_USER_BACKEND_MEM_WRITE =3D 12,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserBackendRequest;
> =20
> @@ -145,6 +147,12 @@ typedef struct VhostUserShMemConfig {
>      uint64_t memory_sizes[VHOST_MEMORY_BASELINE_NREGIONS];
>  } VhostUserShMemConfig;
> =20
> +typedef struct VhostUserMemRWMsg {
> +    uint64_t guest_address;
> +    uint32_t size;
> +    uint8_t data[];

I don't think flexible array members work in VhostUserMsg payload
structs in its current form. It would be necessary to move the
VhostUserMsg.payload field to the end of the VhostUserMsg and then
heap-allocate VhostUserMsg with the additional size required for
VhostUserMemRWMsg.data[].

Right now this patch is calling memcpy() on memory beyond
VhostUserMsg.payload because the VhostUserMsg struct does not have size
bytes of extra space and the payload field is in the middle of the
struct where flexible array members cannot be used.

> +} VhostUserMemRWMsg;
> +
>  typedef struct VhostUserLog {
>      uint64_t mmap_size;
>      uint64_t mmap_offset;
> @@ -253,6 +261,7 @@ typedef union {
>          VhostUserTransferDeviceState transfer_state;
>          VhostUserMMap mmap;
>          VhostUserShMemConfig shmem;
> +        VhostUserMemRWMsg mem_rw;
>  } VhostUserPayload;
> =20
>  typedef struct VhostUserMsg {
> @@ -1871,6 +1880,22 @@ vhost_user_backend_handle_shmem_unmap(struct vhost=
_dev *dev,
>      return 0;
>  }
> =20
> +static int
> +vhost_user_backend_handle_mem_read(struct vhost_dev *dev,
> +                                   VhostUserMemRWMsg *mem_rw)
> +{
> +    /* TODO */
> +    return -EPERM;
> +}
> +
> +static int
> +vhost_user_backend_handle_mem_write(struct vhost_dev *dev,
> +                                   VhostUserMemRWMsg *mem_rw)
> +{
> +    /* TODO */
> +    return -EPERM;
> +}

Reading/writing guest memory can be done via
address_space_read/write(vdev->dma_as, ...).

> +
>  static void close_backend_channel(struct vhost_user *u)
>  {
>      g_source_destroy(u->backend_src);
> @@ -1946,6 +1971,12 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
>      case VHOST_USER_BACKEND_SHMEM_UNMAP:
>          ret =3D vhost_user_backend_handle_shmem_unmap(dev, &payload.mmap=
);
>          break;
> +    case VHOST_USER_BACKEND_MEM_READ:
> +        ret =3D vhost_user_backend_handle_mem_read(dev, &payload.mem_rw);
> +        break;
> +    case VHOST_USER_BACKEND_MEM_WRITE:
> +        ret =3D vhost_user_backend_handle_mem_write(dev, &payload.mem_rw=
);
> +        break;
>      default:
>          error_report("Received unexpected msg type: %d.", hdr.request);
>          ret =3D -EINVAL;
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index 28556d183a..b5184064b5 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -1651,6 +1651,90 @@ vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t=
 fd_offset,
>      return vu_process_message_reply(dev, &vmsg);
>  }
> =20
> +bool
> +vu_send_mem_read(VuDev *dev, uint64_t guest_addr, uint32_t size,
> +                 uint8_t *data)
> +{
> +    VhostUserMsg msg_reply;
> +    VhostUserMsg msg =3D {
> +        .request =3D VHOST_USER_BACKEND_MEM_READ,
> +        .size =3D sizeof(msg.payload.mem_rw),
> +        .flags =3D VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
> +        .payload =3D {
> +            .mem_rw =3D {
> +                .guest_address =3D guest_addr,
> +                .size =3D size,
> +            }
> +        }
> +    };
> +
> +    pthread_mutex_lock(&dev->backend_mutex);
> +    if (!vu_message_write(dev, dev->backend_fd, &msg)) {
> +        goto out_err;
> +    }
> +
> +    if (!vu_message_read_default(dev, dev->backend_fd, &msg_reply)) {
> +        goto out_err;
> +    }
> +
> +    if (msg_reply.request !=3D msg.request) {
> +        DPRINT("Received unexpected msg type. Expected %d, received %d",
> +               msg.request, msg_reply.request);
> +        goto out_err;
> +    }
> +
> +    if (msg_reply.payload.mem_rw.size !=3D size) {
> +        DPRINT("Received unexpected number of bytes in the response. "
> +               "Expected %d, received %d",
> +               size, msg_reply.payload.mem_rw.size);
> +        goto out_err;
> +    }
> +
> +    data =3D malloc(msg_reply.payload.mem_rw.size);

The caller passed in size and data so the caller has provided the
buffer. malloc() is not necessary here.

> +    if (!data) {
> +        DPRINT("Failed to malloc read memory data");
> +        goto out_err;
> +    }
> +
> +    memcpy(data, msg_reply.payload.mem_rw.data, size);

It should be possible to avoid memcpy() here by receiving directly into
the caller's buffer. If you don't want to look into this, please leave a
TODO comment.

> +    pthread_mutex_unlock(&dev->backend_mutex);
> +    return true;
> +
> +out_err:
> +    pthread_mutex_unlock(&dev->backend_mutex);
> +    return false;
> +}
> +
> +bool
> +vu_send_mem_write(VuDev *dev, uint64_t guest_addr, uint32_t size,
> +                  uint8_t *data)
> +{
> +    VhostUserMsg msg =3D {
> +        .request =3D VHOST_USER_BACKEND_MEM_WRITE,
> +        .size =3D sizeof(msg.payload.mem_rw),
> +        .flags =3D VHOST_USER_VERSION,
> +        .payload =3D {
> +            .mem_rw =3D {
> +                .guest_address =3D guest_addr,
> +                .size =3D size,
> +            }
> +        }
> +    };
> +    memcpy(msg.payload.mem_rw.data, data, size);

This memcpy() can be eliminated too. It's worth a code comment in case
someone looks at optimizing this in the future.

> +
> +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
> +        msg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> +    }
> +
> +    if (!vu_message_write(dev, dev->backend_fd, &msg)) {
> +        pthread_mutex_unlock(&dev->backend_mutex);
> +        return false;
> +    }
> +
> +    /* Also unlocks the backend_mutex */
> +    return vu_process_message_reply(dev, &msg);
> +}
> +
>  static bool
>  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
> diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libv=
host-user/libvhost-user.h
> index 7f6c22cc1a..8ef794870d 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -129,6 +129,8 @@ typedef enum VhostUserBackendRequest {
>      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
>      VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
>      VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> +    VHOST_USER_BACKEND_MEM_READ =3D 11,
> +    VHOST_USER_BACKEND_MEM_WRITE =3D 12,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserBackendRequest;
> =20
> @@ -152,6 +154,12 @@ typedef struct VhostUserMemRegMsg {
>      VhostUserMemoryRegion region;
>  } VhostUserMemRegMsg;
> =20
> +typedef struct VhostUserMemRWMsg {
> +    uint64_t guest_address;
> +    uint32_t size;
> +    uint8_t data[];
> +} VhostUserMemRWMsg;
> +
>  typedef struct VhostUserLog {
>      uint64_t mmap_size;
>      uint64_t mmap_offset;
> @@ -235,6 +243,7 @@ typedef struct VhostUserMsg {
>          VhostUserInflight inflight;
>          VhostUserShared object;
>          VhostUserMMap mmap;
> +        VhostUserMemRWMsg mem_rw;
>      } payload;
> =20
>      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> @@ -650,6 +659,35 @@ bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_=
t fd_offset,
>  bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
>                    uint64_t shm_offset, uint64_t len);
> =20
> +/**
> + * vu_send_mem_read:
> + * @dev: a VuDev context
> + * @guest_addr: guest physical address to read
> + * @size: number of bytes to read
> + * @data: head of an unitialized bytes array
> + *
> + * Reads `size` bytes of `guest_addr` in the frontend and stores
> + * them in `data`.
> + *
> + * Returns: TRUE on success, FALSE on failure.
> + */
> +bool vu_send_mem_read(VuDev *dev, uint64_t guest_addr, uint32_t size,
> +                      uint8_t *data);
> +
> +/**
> + * vu_send_mem_write:
> + * @dev: a VuDev context
> + * @guest_addr: guest physical address to write
> + * @size: number of bytes to write
> + * @data: head of an array with `size` bytes to write
> + *
> + * Writes `size` bytes from `data` into `guest_addr` in the frontend.
> + *
> + * Returns: TRUE on success, FALSE on failure.
> + */
> +bool vu_send_mem_write(VuDev *dev, uint64_t guest_addr, uint32_t size,
> +                      uint8_t *data);
> +
>  /**
>   * vu_queue_set_notification:
>   * @dev: a VuDev context
> --=20
> 2.45.2
>=20

--WZ+S2snuQvJFZd41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaPnZ0ACgkQnKSrs4Gr
c8jxvggAtRGA3YS3xwNUBCKV+5zcrjIfLRyEP9IBW/8b6lfqB6pcS7HoqDlEwHml
jL+fZPR887k+EQlhlwEHiWUILSlAirzhaj5k6WwDdK6P+E0wzmLKyoOyocXnGMUa
cDni2Mre49nLXkLNi+06r7HreWGb/gdjav965mBjjNGu/wCcSBHRWpojBCh+McsY
TTsqUSp5eVSb/jo/mJhU2hnrOTdqddw8CYtK5juZ45u55Wp58ERdLV2T7NlLT1Rc
coc03Uhq4dMJR+oMn38gqsdOH+mvbjkfrTo9lAmMg0mlnRUpbFi3t5cPaGfrK2h1
xuLwAGMk4xlm2S3AanUElAcVGpdyMg==
=8OHk
-----END PGP SIGNATURE-----

--WZ+S2snuQvJFZd41--


