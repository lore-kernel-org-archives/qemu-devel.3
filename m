Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BEDC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFVv-0001yF-Dj; Mon, 16 Sep 2024 13:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqFVl-0001wo-6C
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqFVh-0002dA-35
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726507655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ER1tyN54inpexBAr9/eBq2TzNdv3IEPLDa5Mf2fZ5Bw=;
 b=P5HWzL7AGiQbTcHru41YOZVjqGWoVdm1D1mLOOaSHS2LVguyuXtkALtwZyxzpwlrFgBGh2
 6UGndX5A1jMk7SiYy0fzVD2aXE/huvQCX6BuEaKKHAfPZC3ADcA0NiAjIyzuQwaRAbsxOV
 ZhtpZaIVGdgS8zmXxYJTueebUxG9H4Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-iYirvugQMYaXD95eTw0Mrg-1; Mon,
 16 Sep 2024 13:27:32 -0400
X-MC-Unique: iYirvugQMYaXD95eTw0Mrg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FCE31944D24; Mon, 16 Sep 2024 17:27:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.252])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EFAE219560AA; Mon, 16 Sep 2024 17:27:27 +0000 (UTC)
Date: Mon, 16 Sep 2024 19:27:26 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, david@redhat.com,
 jasowang@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Subject: Re: [PATCH v3 2/5] virtio: Track shared memory mappings
Message-ID: <20240916172726.GF521955@fedora.home>
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-3-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TYVfLzhJD/SA5zjz"
Content-Disposition: inline
In-Reply-To: <20240912145335.129447-3-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


--TYVfLzhJD/SA5zjz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 04:53:32PM +0200, Albert Esteve wrote:
> Update shmem_list to be able to track
> active mappings on VIRTIO shared memory
> regions. This allows to verify that new
> mapping request received from backends
> do not overlap. If they do, the request
> shall fail in order to adhere to the specs.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c     | 31 +++++++++++++-------
>  hw/virtio/virtio.c         | 58 ++++++++++++++++++++++++++++++++++----
>  include/hw/virtio/virtio.h | 25 ++++++++++++++--
>  3 files changed, 96 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 338cc942ec..de0bb35257 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1776,7 +1776,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_de=
v *dev,
>                                      int fd)
>  {
>      void *addr =3D 0;
> -    MemoryRegion *mr =3D NULL;
> +    VirtSharedMemory *shmem =3D NULL;
> =20
>      if (fd < 0) {
>          error_report("Bad fd for map");
> @@ -1791,22 +1791,29 @@ vhost_user_backend_handle_shmem_map(struct vhost_=
dev *dev,
>          return -EFAULT;
>      }
> =20
> -    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> +    shmem =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> =20
> -    if (!mr) {
> +    if (!shmem) {
>          error_report("VIRTIO Shared Memory Region at "
>                       "ID %d unitialized", vu_mmap->shmid);
>          return -EFAULT;
>      }
> =20
>      if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> -        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr->size) {
>          error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
>                       vu_mmap->shm_offset, vu_mmap->len);
>          return -EFAULT;
>      }
> =20
> -    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> +    if (virtio_shmem_map_overlaps(shmem, vu_mmap->shm_offset, vu_mmap->l=
en)) {
> +        error_report("Requested memory (%" PRIx64 "+%" PRIx64 ") overalp=
s "
> +                     "with previously mapped memory",
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        return -EFAULT;
> +    }
> +
> +    void *shmem_ptr =3D memory_region_get_ram_ptr(shmem->mr);
> =20
>      addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
>          ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0) |
> @@ -1818,6 +1825,8 @@ vhost_user_backend_handle_shmem_map(struct vhost_de=
v *dev,
>          return -EFAULT;
>      }
> =20
> +    virtio_add_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
> +
>      return 0;
>  }
> =20
> @@ -1826,7 +1835,7 @@ vhost_user_backend_handle_shmem_unmap(struct vhost_=
dev *dev,
>                                        VhostUserMMap *vu_mmap)
>  {
>      void *addr =3D 0;
> -    MemoryRegion *mr =3D NULL;
> +    VirtSharedMemory *shmem =3D NULL;
> =20
>      if (!dev->vdev->shmem_list ||
>          dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> @@ -1836,22 +1845,22 @@ vhost_user_backend_handle_shmem_unmap(struct vhos=
t_dev *dev,
>          return -EFAULT;
>      }
> =20
> -    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> +    shmem =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> =20
> -    if (!mr) {
> +    if (!shmem) {
>          error_report("VIRTIO Shared Memory Region at "
>                       "ID %d unitialized", vu_mmap->shmid);
>          return -EFAULT;
>      }
> =20
>      if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> -        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr->size) {
>          error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
>                       vu_mmap->shm_offset, vu_mmap->len);
>          return -EFAULT;
>      }

Please add a check for an existing mapping that matches [shm_offset,
shm_offset + len). This will prevent partial unmap as required by the
spec.

> =20
> -    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> +    void *shmem_ptr =3D memory_region_get_ram_ptr(shmem->mr);
> =20
>      addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
>                  PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, =
0);
> @@ -1861,6 +1870,8 @@ vhost_user_backend_handle_shmem_unmap(struct vhost_=
dev *dev,
>          return -EFAULT;
>      }
> =20
> +    virtio_del_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
> +
>      return 0;
>  }
> =20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index ccc4f2cd75..0e2cd62a15 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3059,15 +3059,52 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
>  }
> =20
> -MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev)
> +VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev)
>  {
> -    MemoryRegion *mr;
> +    VirtSharedMemory *shmem =3D NULL;
>      ++vdev->n_shmem_regions;
> -    vdev->shmem_list =3D g_renew(MemoryRegion, vdev->shmem_list,
> +    vdev->shmem_list =3D g_renew(VirtSharedMemory, vdev->shmem_list,
>                                 vdev->n_shmem_regions);
> -    mr =3D &vdev->shmem_list[vdev->n_shmem_regions - 1];
> -    mr =3D g_new0(MemoryRegion, 1);
> -    return mr;
> +    shmem =3D &vdev->shmem_list[vdev->n_shmem_regions - 1];
> +    shmem =3D g_new0(VirtSharedMemory, 1);
> +    QTAILQ_INIT(&shmem->mapped_regions);
> +    return shmem;
> +}
> +
> +void virtio_add_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
> +                          uint64_t size)
> +{
> +    MappedMemoryRegion *mmap =3D g_new0(MappedMemoryRegion, 1);
> +    mmap->offset =3D offset;
> +    mmap->size =3D int128_make64(size);
> +    QTAILQ_REMOVE(&shmem->mapped_regions, mmap, link);
> +    g_free(mmap);

mmap needs to be inserted into mapped_regions and must not be freed by
this function.

> +}
> +
> +void virtio_del_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
> +                          uint64_t size)
> +{
> +    MappedMemoryRegion *mmap =3D g_new0(MappedMemoryRegion, 1);
> +    mmap->offset =3D offset;
> +    mmap->size =3D int128_make64(size);
> +    QTAILQ_INSERT_TAIL(&shmem->mapped_regions, mmap, link);

This function needs to search the list for the matching mmap and remove
it from the list. It should not create a new mmap.

> +    g_free(mmap);
> +}
> +
> +bool virtio_shmem_map_overlaps(VirtSharedMemory *shmem, hwaddr offset,
> +                               uint64_t size)
> +{
> +    MappedMemoryRegion *map_reg;
> +    hwaddr new_reg_end =3D offset + size;
> +    QTAILQ_FOREACH(map_reg, &shmem->mapped_regions, link) {
> +        hwaddr region_end =3D map_reg->offset + map_reg->size;
> +        if ((map_reg->offset =3D=3D offset) ||
> +            (map_reg->offset < offset && region_end >=3D offset) ||
> +            (offset < map_reg->offset && new_reg_end >=3D map_reg->offse=
t )) {
> +            return true;
> +        }
> +    }
> +    return false;  =20
>  }
> =20
>  /* A wrapper for use as a VMState .put function */
> @@ -4007,11 +4044,20 @@ static void virtio_device_free_virtqueues(VirtIOD=
evice *vdev)
>  static void virtio_device_instance_finalize(Object *obj)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(obj);
> +    VirtSharedMemory *shmem =3D NULL;
> +    int i;
> =20
>      virtio_device_free_virtqueues(vdev);
> =20
>      g_free(vdev->config);
>      g_free(vdev->vector_queues);
> +    for (i =3D 0; i< vdev->n_shmem_regions; i++) {
> +        shmem =3D &vdev->shmem_list[i];
> +        while (!QTAILQ_EMPTY(&shmem->mapped_regions)) {
> +            MappedMemoryRegion *mmap_reg =3D QTAILQ_FIRST(&shmem->mapped=
_regions);
> +            QTAILQ_REMOVE(&shmem->mapped_regions, mmap_reg, link);

g_free(mmap_reg)

> +        }
> +    }
>  }
> =20
>  static Property virtio_properties[] =3D {
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index d4a2f664d9..5b801f33f5 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -98,6 +98,21 @@ enum virtio_device_endian {
>      VIRTIO_DEVICE_ENDIAN_BIG,
>  };
> =20
> +struct MappedMemoryRegion {
> +    Int128 size;
> +    hwaddr offset;
> +    QTAILQ_ENTRY(MappedMemoryRegion) link;
> +};
> +
> +typedef struct MappedMemoryRegion MappedMemoryRegion;
> +
> +struct VirtSharedMemory {
> +    MemoryRegion *mr;
> +    QTAILQ_HEAD(, MappedMemoryRegion) mapped_regions;
> +};
> +
> +typedef struct VirtSharedMemory VirtSharedMemory;
> +
>  /**
>   * struct VirtIODevice - common VirtIO structure
>   * @name: name of the device
> @@ -168,7 +183,7 @@ struct VirtIODevice
>      EventNotifier config_notifier;
>      bool device_iotlb_enabled;
>      /* Shared memory region for vhost-user mappings. */
> -    MemoryRegion *shmem_list;
> +    VirtSharedMemory *shmem_list;
>      int n_shmem_regions;
>  };
> =20
> @@ -289,7 +304,13 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq=
);
> =20
>  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> =20
> -MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev);
> +VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev);
> +void virtio_add_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
> +                          uint64_t size);
> +void virtio_del_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
> +                          uint64_t size);
> +bool virtio_shmem_map_overlaps(VirtSharedMemory *shmem, hwaddr offset,
> +                               uint64_t size);
> =20
>  extern const VMStateInfo virtio_vmstate_info;
> =20
> --=20
> 2.45.2
>=20

--TYVfLzhJD/SA5zjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmboan4ACgkQnKSrs4Gr
c8jxjAf6ArZ1UQ7cE57PEAvTIWD7xLG9YLBbp8pO33OTH2kcqVcG3uGGjUIbDyVb
km8Y48hlWgP9utVmFosKaflSFN2PYtFPk7rEq0Bl1NLkeya6ul90btObUv0k4fVq
0m/ekWwuL4RjzeYHFotGFUr+PvKEtASYHjgZ2StcywaUEyIYgQ6sx+lmfXq8uzvv
3c8wVkQUqrvgOenAHF43CXDGAJJysC+ufKuMbBmTJU3pV+GB7JAT+AuoIPq6rCUC
X3ZPagKtlhDMs+Ggmf1DYa6f4Peh6MQZLffPYCNF5I+v1VLRyVfGlB78Y0YVSdRE
jJHL0ztTim08hgkGCa5Djpocll+Urw==
=iFBR
-----END PGP SIGNATURE-----

--TYVfLzhJD/SA5zjz--


