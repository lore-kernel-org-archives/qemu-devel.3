Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF52C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEZ3i-0002Pu-3q; Mon, 12 May 2025 15:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEZ3g-0002Os-7a
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEZ3e-0003RI-7W
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747079005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1+tkJUhtvqz8hIl1D1zEDZaZU5VHrxNczTEeik760Y=;
 b=cl2SacA9+b1FT2I9r0kz8fS2ulbOSSxpQRFdfXRFhNdbf0bsrE5tGoWsv6tXP1KP7eAOub
 iKrXDp9VkF7LeB3yrlzWMr41QnoKx50nM7KO1jybyxU8XvBRTLUa6AwNORMICqW3Ug4+V4
 uTgIDWlx8RZJX6xi4m+KAw1FfCn10jc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-UMEIvA7IOLK-5hTn75Qugw-1; Mon,
 12 May 2025 15:43:22 -0400
X-MC-Unique: UMEIvA7IOLK-5hTn75Qugw-1
X-Mimecast-MFC-AGG-ID: UMEIvA7IOLK-5hTn75Qugw_1747079000
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D73841955D79; Mon, 12 May 2025 19:43:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 944E7180045B; Mon, 12 May 2025 19:43:18 +0000 (UTC)
Date: Mon, 12 May 2025 15:43:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Xie Yongji <xieyongji@bytedance.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Raphael Norwitz <raphael@enfabrica.net>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [RFC v2 3/4] vhost-user-blk: Add VIRTIO_BLK_T_OUT_FUA command
 support
Message-ID: <20250512194312.GM141177@fedora>
References: <20250508162044.857655-1-afaria@redhat.com>
 <20250508162044.857655-4-afaria@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vfvJVVXch43AejIf"
Content-Disposition: inline
In-Reply-To: <20250508162044.857655-4-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--vfvJVVXch43AejIf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 05:20:43PM +0100, Alberto Faria wrote:
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  block/export/vhost-user-blk-server.c    |  1 +
>  contrib/vhost-user-blk/vhost-user-blk.c | 16 +++++--
>  hw/block/vhost-user-blk.c               |  3 ++
>  hw/core/machine.c                       |  1 +
>  tests/qtest/vhost-user-blk-test.c       | 56 +++++++++++++++++++++++++
>  5 files changed, 74 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-us=
er-blk-server.c
> index d9d2014d9b7..fad9560b219 100644
> --- a/block/export/vhost-user-blk-server.c
> +++ b/block/export/vhost-user-blk-server.c
> @@ -125,6 +125,7 @@ static uint64_t vu_blk_get_features(VuDev *dev)
>                 1ull << VIRTIO_BLK_F_FLUSH |
>                 1ull << VIRTIO_BLK_F_DISCARD |
>                 1ull << VIRTIO_BLK_F_WRITE_ZEROES |
> +               1ull << VIRTIO_BLK_F_OUT_FUA |
>                 1ull << VIRTIO_BLK_F_CONFIG_WCE |
>                 1ull << VIRTIO_BLK_F_MQ |
>                 1ull << VIRTIO_F_VERSION_1 |
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user=
-blk/vhost-user-blk.c
> index 6cc18a1c04f..8d732bbe468 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -154,7 +154,7 @@ vub_readv(VubReq *req, struct iovec *iov, uint32_t io=
vcnt)
>  }
> =20
>  static ssize_t
> -vub_writev(VubReq *req, struct iovec *iov, uint32_t iovcnt)
> +vub_writev(VubReq *req, struct iovec *iov, uint32_t iovcnt, int flags)
>  {
>      VubDev *vdev_blk =3D req->vdev_blk;
>      ssize_t rc;

Where is flags used?

> @@ -271,12 +271,19 @@ static int vub_virtio_process_req(VubDev *vdev_blk,
>      type =3D le32_to_cpu(req->out->type);
>      switch (type & ~VIRTIO_BLK_T_BARRIER) {
>      case VIRTIO_BLK_T_IN:
> -    case VIRTIO_BLK_T_OUT: {
> +    case VIRTIO_BLK_T_OUT:
> +    case VIRTIO_BLK_T_OUT_FUA: {
>          ssize_t ret =3D 0;
>          bool is_write =3D type & VIRTIO_BLK_T_OUT;
> +        int flags =3D 0;
>          req->sector_num =3D le64_to_cpu(req->out->sector);
>          if (is_write) {
> -            ret  =3D vub_writev(req, &elem->out_sg[1], out_num);
> +            #ifdef RWF_SYNC
> +            if (type =3D=3D VIRTIO_BLK_T_OUT_FUA) {
> +                flags |=3D RWF_SYNC;
> +            }
> +            #endif
> +            ret  =3D vub_writev(req, &elem->out_sg[1], out_num, flags);
>          } else {
>              ret =3D vub_readv(req, &elem->in_sg[0], in_num);
>          }
> @@ -379,6 +386,9 @@ vub_get_features(VuDev *dev)
>                 1ull << VIRTIO_BLK_F_DISCARD |
>                 1ull << VIRTIO_BLK_F_WRITE_ZEROES |
>                 #endif
> +               #ifdef RWF_SYNC
> +               1ull << VIRTIO_BLK_F_OUT_FUA |
> +               #endif
>                 1ull << VIRTIO_BLK_F_CONFIG_WCE;
> =20
>      if (vdev_blk->enable_ro) {
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 4bb5ed299e7..988be625969 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -44,6 +44,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_BLK_F_CONFIG_WCE,
>      VIRTIO_BLK_F_DISCARD,
>      VIRTIO_BLK_F_WRITE_ZEROES,
> +    VIRTIO_BLK_F_OUT_FUA,
>      VIRTIO_F_VERSION_1,
>      VIRTIO_RING_F_INDIRECT_DESC,
>      VIRTIO_RING_F_EVENT_IDX,
> @@ -581,6 +582,8 @@ static const Property vhost_user_blk_properties[] =3D=
 {
>                        VIRTIO_BLK_F_DISCARD, true),
>      DEFINE_PROP_BIT64("write-zeroes", VHostUserBlk, parent_obj.host_feat=
ures,
>                        VIRTIO_BLK_F_WRITE_ZEROES, true),
> +    DEFINE_PROP_BIT64("fua-write", VHostUserBlk, parent_obj.host_feature=
s,
> +                      VIRTIO_BLK_F_OUT_FUA, true),
>  };
> =20
>  static void vhost_user_blk_class_init(ObjectClass *klass, const void *da=
ta)
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 8439b094904..bcf4f3423cb 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,6 +39,7 @@
> =20
>  GlobalProperty hw_compat_10_0[] =3D {
>      { "virtio-blk-device", "fua-write", "false" },
> +    { "vhost-user-blk", "fua-write", "false" },
>  };
>  const size_t hw_compat_10_0_len =3D G_N_ELEMENTS(hw_compat_10_0);
> =20
> diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-b=
lk-test.c
> index ea90d41232e..4c68702e0b0 100644
> --- a/tests/qtest/vhost-user-blk-test.c
> +++ b/tests/qtest/vhost-user-blk-test.c
> @@ -72,6 +72,7 @@ static uint64_t virtio_blk_request(QGuestAllocator *all=
oc, QVirtioDevice *d,
>      switch (req->type) {
>      case VIRTIO_BLK_T_IN:
>      case VIRTIO_BLK_T_OUT:
> +    case VIRTIO_BLK_T_OUT_FUA:
>          g_assert_cmpuint(data_size % 512, =3D=3D, 0);
>          break;
>      case VIRTIO_BLK_T_DISCARD:
> @@ -389,6 +390,61 @@ static QVirtQueue *test_basic(QVirtioDevice *dev, QG=
uestAllocator *alloc)
>                                            VIRTIO_BLK_T_DISCARD);
>      }
> =20
> +    if (features & (1u << VIRTIO_BLK_F_OUT_FUA)) {
> +        /* FUA write and read with 3 descriptor layout */
> +        /* FUA write request */
> +        req.type =3D VIRTIO_BLK_T_OUT_FUA;
> +        req.ioprio =3D 1;
> +        req.sector =3D 0;
> +        req.data =3D g_malloc0(512);
> +        strcpy(req.data, "test");
> +
> +        req_addr =3D virtio_blk_request(alloc, dev, &req, 512);
> +
> +        g_free(req.data);
> +
> +        free_head =3D qvirtqueue_add(qts, vq, req_addr, 16, false, true);
> +        qvirtqueue_add(qts, vq, req_addr + 16, 512, false, true);
> +        qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
> +
> +        qvirtqueue_kick(qts, dev, vq, free_head);
> +
> +        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
> +                            QVIRTIO_BLK_TIMEOUT_US);
> +        status =3D readb(req_addr + 528);
> +        g_assert_cmpint(status, =3D=3D, 0);
> +
> +        guest_free(alloc, req_addr);
> +
> +        /* Read request */
> +        req.type =3D VIRTIO_BLK_T_IN;
> +        req.ioprio =3D 1;
> +        req.sector =3D 0;
> +        req.data =3D g_malloc0(512);
> +
> +        req_addr =3D virtio_blk_request(alloc, dev, &req, 512);
> +
> +        g_free(req.data);
> +
> +        free_head =3D qvirtqueue_add(qts, vq, req_addr, 16, false, true);
> +        qvirtqueue_add(qts, vq, req_addr + 16, 512, true, true);
> +        qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
> +
> +        qvirtqueue_kick(qts, dev, vq, free_head);
> +
> +        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
> +                            QVIRTIO_BLK_TIMEOUT_US);
> +        status =3D readb(req_addr + 528);
> +        g_assert_cmpint(status, =3D=3D, 0);
> +
> +        data =3D g_malloc0(512);
> +        qtest_memread(qts, req_addr + 16, data, 512);
> +        g_assert_cmpstr(data, =3D=3D, "test");
> +        g_free(data);
> +
> +        guest_free(alloc, req_addr);
> +    }
> +
>      if (features & (1u << VIRTIO_F_ANY_LAYOUT)) {
>          /* Write and read with 2 descriptor layout */
>          /* Write request */
> --=20
> 2.49.0
>=20

--vfvJVVXch43AejIf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiT1AACgkQnKSrs4Gr
c8jgmAf8DV/SXjoGd8MvuS7FtXKom0Bq3AULMtdHH4UJUK4lF7kmgFH7yNf0+l+d
vv4JIK2HeZ2w4Io7XbiwgeUKqYjKwu94kqrK3egPevusrtpjFT/leOMTejPGIg7y
xQul+KQlzSKWodPft6bA9UoiyXGdZAm+HlY7Z/P+C8L3JHOkT3fv0Psl0gg9lVis
2QxkNIoeORn8Z98hm1gXFC7gT+pR5QKEmwWuIWjzlLhdLOgNq5w1eVHMH7ZkXfJK
PFBNGcCJDeQyqZravYhDMjHcWkNMNYnxZmFP2dHarBZv+sTmI7kPrb3U69DDl4bX
4cxV8XrA+BeakKsqTownoG+yGLKVLA==
=Rn3g
-----END PGP SIGNATURE-----

--vfvJVVXch43AejIf--


