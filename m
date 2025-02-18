Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1719EC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkLI7-0000fz-Di; Tue, 18 Feb 2025 05:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkLI5-0000fn-U1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:57:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkLI3-0003Gv-Fy
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739876242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ag51sUhVwjB7QxvVXHzEo6c7BL7MH5yrwDMe1JT/OtI=;
 b=eiiSZ08YwzHCCyGTFN1vdZuF9O2wx3oSAAwc/Fjsb8CbJmyF28t6I5Um+0S79aFSBebPQA
 qHZZdnMCqZ+kkqHIMJHEXKkjnQD3ohUn4Rn0zwSTPuMiXkQtLtMAjW+PpGs5yWIlHhnB32
 dOnKAcAqqGZ7iytC7xfOjOBnbBOyIiM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-rPaf1PvpMzeMm7ubVnQExg-1; Tue,
 18 Feb 2025 05:57:15 -0500
X-MC-Unique: rPaf1PvpMzeMm7ubVnQExg-1
X-Mimecast-MFC-AGG-ID: rPaf1PvpMzeMm7ubVnQExg_1739876234
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83A24190F9C9; Tue, 18 Feb 2025 10:57:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08ADC1800359; Tue, 18 Feb 2025 10:57:12 +0000 (UTC)
Date: Tue, 18 Feb 2025 18:57:10 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 hi@alyssa.is, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v4 8/9] vhost_user: Add mem_read/write backend requests
Message-ID: <20250218105710.GL10767@fedora>
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-9-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PqhmzVJVYOoYqwdT"
Content-Disposition: inline
In-Reply-To: <20250217164012.246727-9-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--PqhmzVJVYOoYqwdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 05:40:11PM +0100, Albert Esteve wrote:
> With SHMEM_MAP messages, sharing descriptors between
> devices will cause that these devices do not see the
> mappings, and fail to access these memory regions.
>=20
> To solve this, introduce MEM_READ/WRITE requests
> that will get triggered as a fallback when
> vhost-user memory translation fails.
>=20
> MEM_READ/WRITE requests have flexible array members,
> since we do not know in advance the number of bytes
> in the mapped region. Therefore, we need to allow
> bigger message sizes for these types, and ensure
> we allocate sufficient memory for them.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c                    | 99 +++++++++++++++++------
>  subprojects/libvhost-user/libvhost-user.c | 90 +++++++++++++++++++++
>  subprojects/libvhost-user/libvhost-user.h | 37 +++++++++
>  3 files changed, 202 insertions(+), 24 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 9cc148f726..ab92905a36 100644
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
>      uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
>  } VhostUserShMemConfig;
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
> @@ -253,6 +261,7 @@ typedef union {
>          VhostUserTransferDeviceState transfer_state;
>          VhostUserMMap mmap;
>          VhostUserShMemConfig shmem;
> +        VhostUserMemRWMsg mem_rw;
>  } VhostUserPayload;
> =20
>  typedef struct VhostUserMsg {
> @@ -341,17 +350,23 @@ static int vhost_user_read(struct vhost_dev *dev, V=
hostUserMsg *msg)
>          return r;
>      }
> =20
> -    /* validate message size is sane */
> -    if (msg->hdr.size > VHOST_USER_PAYLOAD_SIZE) {
> -        error_report("Failed to read msg header."
> -                " Size %d exceeds the maximum %zu.", msg->hdr.size,
> -                VHOST_USER_PAYLOAD_SIZE);
> -        return -EPROTO;
> -    }
> -
>      if (msg->hdr.size) {
>          p +=3D VHOST_USER_HDR_SIZE;
>          size =3D msg->hdr.size;
> +        /* validate message size is sane */
> +        if (msg->hdr.size > VHOST_USER_PAYLOAD_SIZE) {
> +            switch(msg->hdr.request) {
> +                case VHOST_USER_BACKEND_MEM_READ:
> +                case VHOST_USER_BACKEND_MEM_WRITE:
> +                    p =3D g_malloc0(size);

This doesn't work because the function signature is:

  static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)

The caller expects msg to be filled in. Setting p to newly allocated
heap memory leaks this memory and the caller will still be looking at
the old msg.

Perhaps variable-length commands should be treated differently:
vhost_user_read() only reads msg->hdr and leaves it up to the caller to
read the remaining msg->hdr.size bytes later.

> +                    break;
> +                default:
> +                    error_report("Failed to read msg header."
> +                                 " Size %d exceeds the maximum %zu.",
> +                                 size, VHOST_USER_PAYLOAD_SIZE);
> +                    return -EPROTO;
> +            }
> +        }
>          r =3D qemu_chr_fe_read_all(chr, p, size);
>          if (r !=3D size) {
>              int saved_errno =3D errno;
> @@ -1904,6 +1919,28 @@ vhost_user_backend_handle_shmem_unmap(struct vhost=
_dev *dev,
>      return 0;
>  }
> =20
> +static int
> +vhost_user_backend_handle_mem_read(struct vhost_dev *dev,
> +                                   VhostUserMemRWMsg *mem_rw)
> +{
> +    MemTxResult result;
> +    result =3D address_space_read(dev->vdev->dma_as, mem_rw->guest_addre=
ss,
> +                                MEMTXATTRS_UNSPECIFIED, &mem_rw->data,
> +                                mem_rw->size);
> +    return result;
> +}
> +
> +static int
> +vhost_user_backend_handle_mem_write(struct vhost_dev *dev,
> +                                   VhostUserMemRWMsg *mem_rw)
> +{
> +    MemTxResult result;
> +    result =3D address_space_write(dev->vdev->dma_as, mem_rw->guest_addr=
ess,
> +                                 MEMTXATTRS_UNSPECIFIED, &mem_rw->data,
> +                                 mem_rw->size);
> +    return result;
> +}
> +
>  static void close_backend_channel(struct vhost_user *u)
>  {
>      g_source_destroy(u->backend_src);
> @@ -1919,7 +1956,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCo=
ndition condition,
>      struct vhost_dev *dev =3D opaque;
>      struct vhost_user *u =3D dev->opaque;
>      VhostUserHeader hdr =3D { 0, };
> -    VhostUserPayload payload =3D { 0, };
> +    VhostUserPayload *payload =3D g_new0(VhostUserPayload, 1);
>      Error *local_err =3D NULL;
>      gboolean rc =3D G_SOURCE_CONTINUE;
>      int ret =3D 0;
> @@ -1938,47 +1975,60 @@ static gboolean backend_read(QIOChannel *ioc, GIO=
Condition condition,
>      }
> =20
>      if (hdr.size > VHOST_USER_PAYLOAD_SIZE) {
> -        error_report("Failed to read msg header."
> -                " Size %d exceeds the maximum %zu.", hdr.size,
> -                VHOST_USER_PAYLOAD_SIZE);
> -        goto err;
> +        switch (hdr.request) {
> +            case VHOST_USER_BACKEND_MEM_READ:
> +            case VHOST_USER_BACKEND_MEM_WRITE:
> +                payload =3D g_malloc0(hdr.size);
> +                break;
> +            default:
> +                error_report("Failed to read msg header."
> +                             " Size %d exceeds the maximum %zu.", hdr.si=
ze,
> +                             VHOST_USER_PAYLOAD_SIZE);
> +                goto err;
> +        }
>      }
> =20
>      /* Read payload */
> -    if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_er=
r)) {
> +    if (qio_channel_read_all(ioc, (char *) payload, hdr.size, &local_err=
)) {
>          error_report_err(local_err);
>          goto err;
>      }
> =20
>      switch (hdr.request) {
>      case VHOST_USER_BACKEND_IOTLB_MSG:
> -        ret =3D vhost_backend_handle_iotlb_msg(dev, &payload.iotlb);
> +        ret =3D vhost_backend_handle_iotlb_msg(dev, &payload->iotlb);
>          break;
>      case VHOST_USER_BACKEND_CONFIG_CHANGE_MSG:
>          ret =3D vhost_user_backend_handle_config_change(dev);
>          break;
>      case VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG:
> -        ret =3D vhost_user_backend_handle_vring_host_notifier(dev, &payl=
oad.area,
> +        ret =3D vhost_user_backend_handle_vring_host_notifier(dev, &payl=
oad->area,
>                                                            fd ? fd[0] : -=
1);
>          break;
>      case VHOST_USER_BACKEND_SHARED_OBJECT_ADD:
> -        ret =3D vhost_user_backend_handle_shared_object_add(dev, &payloa=
d.object);
> +        ret =3D vhost_user_backend_handle_shared_object_add(dev, &payloa=
d->object);
>          break;
>      case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:
>          ret =3D vhost_user_backend_handle_shared_object_remove(dev,
> -                                                             &payload.ob=
ject);
> +                                                             &payload->o=
bject);
>          break;
>      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
>          ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opaq=
ue, ioc,
> -                                                             &hdr, &payl=
oad);
> +                                                             &hdr, paylo=
ad);
> +        break;
>      case VHOST_USER_BACKEND_SHMEM_MAP:
> -        ret =3D vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &pay=
load,
> +        ret =3D vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, payl=
oad,
>                                                    fd ? fd[0] : -1, &loca=
l_err);
>          break;
>      case VHOST_USER_BACKEND_SHMEM_UNMAP:
> -        ret =3D vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &p=
ayload,
> +        ret =3D vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, pa=
yload,
>                                                      &local_err);
>          break;
> +    case VHOST_USER_BACKEND_MEM_READ:
> +        ret =3D vhost_user_backend_handle_mem_read(dev, &payload->mem_rw=
);
> +        break;
> +    case VHOST_USER_BACKEND_MEM_WRITE:
> +        ret =3D vhost_user_backend_handle_mem_write(dev, &payload->mem_r=
w);
>          break;
>      default:
>          error_report("Received unexpected msg type: %d.", hdr.request);
> @@ -1990,10 +2040,10 @@ static gboolean backend_read(QIOChannel *ioc, GIO=
Condition condition,
>       * directly in their request handlers.
>       */
>      if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> -        payload.u64 =3D !!ret;
> -        hdr.size =3D sizeof(payload.u64);
> +        payload->u64 =3D !!ret;
> +        hdr.size =3D sizeof(payload->u64);
> =20
> -        if (!vhost_user_send_resp(ioc, &hdr, &payload, &local_err)) {
> +        if (!vhost_user_send_resp(ioc, &hdr, payload, &local_err)) {
>              error_report_err(local_err);
>              goto err;
>          }
> @@ -2011,6 +2061,7 @@ fdcleanup:
>              close(fd[i]);
>          }
>      }
> +    g_free(payload);
>      return rc;
>  }
> =20
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index 034cbfdc3c..575a0af556 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -1662,6 +1662,96 @@ vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t=
 shm_offset, uint64_t len)
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
> +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
> +        return false;
> +    }
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
> +    /* TODO: It should be possible to avoid memcpy() here by receiving
> +     * directly into the caller's buffer. */
> +    memcpy(data, msg_reply.payload.mem_rw.data, size);
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
> +    /* TODO: It should be possible to avoid memcpy() here by receiving
> +     * directly into the caller's buffer. */
> +    memcpy(msg.payload.mem_rw.data, data, size);
> +
> +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
> +        return false;
> +    }
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
> index e9adb836f0..57e2fb9c98 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -131,6 +131,8 @@ typedef enum VhostUserBackendRequest {
>      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
>      VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
>      VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> +    VHOST_USER_BACKEND_MEM_READ =3D 11,
> +    VHOST_USER_BACKEND_MEM_WRITE =3D 12,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserBackendRequest;
> =20
> @@ -154,6 +156,12 @@ typedef struct VhostUserMemRegMsg {
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
> @@ -233,6 +241,7 @@ typedef struct VhostUserMsg {
>          VhostUserInflight inflight;
>          VhostUserShared object;
>          VhostUserMMap mmap;
> +        VhostUserMemRWMsg mem_rw;
>      } payload;
> =20
>      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> @@ -647,6 +656,34 @@ bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_=
t fd_offset,
>   */
>  bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset,
>                      uint64_t len);
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
> =20
>  /**
>   * vu_queue_set_notification:
> --=20
> 2.48.1
>=20

--PqhmzVJVYOoYqwdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme0Z4UACgkQnKSrs4Gr
c8gIzwf9H74i3G00rAkwCohXWJxTwG5N7wyF7ybDZmv2WVMiRummH6Cjlxy7B2Wo
jBpb5dvUgdopZWBMl/p1qC92ySOxzooVIPG6HFjk+uCu0toh35AxugplxprNEp0E
wYJzxLMbr8xr/fy9wQ8IvXeqndJLBA7AqgNilFATX4pahnNg6QmaSqmeS0dfbogG
n9r1o2dD1L/bOQAkjYeWk9C2hXHPhGvamGWl6PQkFO2dl0Q7DWEPzCQjEB44pnYE
jtKAHHc7bvMKftMNz7J0ZXiDeYgIDbKJqki+ZukfhlFxFBGK81R+E3YEy5/mahBE
wqZMbGc3dJNEZ56F/1wo4SPMUzqgKw==
=2b6k
-----END PGP SIGNATURE-----

--PqhmzVJVYOoYqwdT--


