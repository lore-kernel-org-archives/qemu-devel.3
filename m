Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ED2C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 13:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u29TU-0000CT-PD; Tue, 08 Apr 2025 09:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u29TK-0000BR-4L
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 09:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u29TH-0004Fl-EV
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 09:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744120711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TTWMbv3Xg9V8C2woFjJSawKTecnt44jcxi1eL/4z7o0=;
 b=Pb4+dsRUicI2WRsQXoH9DPPrPsSDpnmm4yfTD7omgREbmPHZh3kVFcHEBxU7z4Y+4qiHt8
 hHtV4Uw+tU/mBQqEGW1HLTFut+6d0El9iiwLilOF0TeJj0HxPc6n+GHkeq4LwN5yT47iwo
 SNM63nnHRy+6CIgAfzDjeutIKHmSQgA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-L-Xrze-nN8i8Ecadlwc_mw-1; Tue,
 08 Apr 2025 09:58:29 -0400
X-MC-Unique: L-Xrze-nN8i8Ecadlwc_mw-1
X-Mimecast-MFC-AGG-ID: L-Xrze-nN8i8Ecadlwc_mw_1744120705
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 581EB1828A9C; Tue,  8 Apr 2025 13:58:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.136])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7325D19560AD; Tue,  8 Apr 2025 13:58:23 +0000 (UTC)
Date: Tue, 8 Apr 2025 09:58:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Antoine Damhet <adamhet@scaleway.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] Revert "virtio-net: Copy received header to buffer"
Message-ID: <20250408135822.GA538171@fedora>
References: <20250404151835.328368-1-adamhet@scaleway.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MRXpzXJzaNTLLKjG"
Content-Disposition: inline
In-Reply-To: <20250404151835.328368-1-adamhet@scaleway.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
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


--MRXpzXJzaNTLLKjG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 05:18:21PM +0200, Antoine Damhet wrote:
> This reverts commit 7987d2be5a8bc3a502f89ba8cf3ac3e09f64d1ce.
>=20
> The goal was to remove the need to patch the (const) input buffer
> with a recomputed UDP checksum by copying headers to a RW region and
> inject the checksum there. The patch computed the checksum only from the
> header fields (missing the rest of the payload) producing an invalid one
> and making guests fail to acquire a DHCP lease.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
> ---
>  hw/net/virtio-net.c | 85 +++++++++++++++++++++------------------------
>  1 file changed, 39 insertions(+), 46 deletions(-)

This patch fails to apply due to a conflict with:

  commit c17ad4b11bd268a35506cd976884562df6ca69d7
  Author: Akihiko Odaki <akihiko.odaki@daynix.com>
  Date:   Wed Jan 8 21:13:29 2025 +0900

    virtio-net: Fix num_buffers for version 1

Please rebase.

Michael or Jason: Are you still sending a pull request for 10.0.0-rc3?
It's being tagged today.

Stefan

>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index de87cfadffe1..028e7e873c42 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1702,44 +1702,41 @@ static void virtio_net_hdr_swap(VirtIODevice *vde=
v, struct virtio_net_hdr *hdr)
>   * cache.
>   */
>  static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
> -                                        size_t *hdr_len, const uint8_t *=
buf,
> -                                        size_t buf_size, size_t *buf_off=
set)
> +                                        uint8_t *buf, size_t size)
>  {
>      size_t csum_size =3D ETH_HLEN + sizeof(struct ip_header) +
>                         sizeof(struct udp_header);
> =20
> -    buf +=3D *buf_offset;
> -    buf_size -=3D *buf_offset;
> -
>      if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
> -        (buf_size >=3D csum_size && buf_size < 1500) && /* normal sized =
MTU */
> +        (size >=3D csum_size && size < 1500) && /* normal sized MTU */
>          (buf[12] =3D=3D 0x08 && buf[13] =3D=3D 0x00) && /* ethertype =3D=
=3D IPv4 */
>          (buf[23] =3D=3D 17) && /* ip.protocol =3D=3D UDP */
>          (buf[34] =3D=3D 0 && buf[35] =3D=3D 67)) { /* udp.srcport =3D=3D=
 bootps */
> -        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
> -        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, CSU=
M_UDP);
> +        net_checksum_calculate(buf, size, CSUM_UDP);
>          hdr->flags &=3D ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
> -        *hdr_len +=3D csum_size;
> -        *buf_offset +=3D csum_size;
>      }
>  }
> =20
> -static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
> -                             const void *buf, size_t buf_size,
> -                             size_t *buf_offset)
> +static void receive_header(VirtIONet *n, const struct iovec *iov, int io=
v_cnt,
> +                           const void *buf, size_t size)
>  {
> -    size_t hdr_len =3D n->guest_hdr_len;
> -
> -    memcpy(hdr, buf, sizeof(struct virtio_net_hdr));
> -
> -    *buf_offset =3D n->host_hdr_len;
> -    work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offset=
);
> +    if (n->has_vnet_hdr) {
> +        /* FIXME this cast is evil */
> +        void *wbuf =3D (void *)buf;
> +        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
> +                                    size - n->host_hdr_len);
> =20
> -    if (n->needs_vnet_hdr_swap) {
> -        virtio_net_hdr_swap(VIRTIO_DEVICE(n), hdr);
> +        if (n->needs_vnet_hdr_swap) {
> +            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
> +        }
> +        iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr)=
);
> +    } else {
> +        struct virtio_net_hdr hdr =3D {
> +            .flags =3D 0,
> +            .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> +        };
> +        iov_from_buf(iov, iov_cnt, 0, &hdr, sizeof hdr);
>      }
> -
> -    return hdr_len;
>  }
> =20
>  static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
> @@ -1907,13 +1904,6 @@ static int virtio_net_process_rss(NetClientState *=
nc, const uint8_t *buf,
>      return (index =3D=3D new_index) ? -1 : new_index;
>  }
> =20
> -typedef struct Header {
> -    struct virtio_net_hdr_v1_hash virtio_net;
> -    struct eth_header eth;
> -    struct ip_header ip;
> -    struct udp_header udp;
> -} Header;
> -
>  static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t =
*buf,
>                                        size_t size)
>  {
> @@ -1923,15 +1913,15 @@ static ssize_t virtio_net_receive_rcu(NetClientSt=
ate *nc, const uint8_t *buf,
>      VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
>      size_t lens[VIRTQUEUE_MAX_SIZE];
>      struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
> -    Header hdr;
> +    struct virtio_net_hdr_v1_hash extra_hdr;
>      unsigned mhdr_cnt =3D 0;
>      size_t offset, i, guest_offset, j;
>      ssize_t err;
> =20
> -    memset(&hdr.virtio_net, 0, sizeof(hdr.virtio_net));
> +    memset(&extra_hdr, 0, sizeof(extra_hdr));
> =20
>      if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
> -        int index =3D virtio_net_process_rss(nc, buf, size, &hdr.virtio_=
net);
> +        int index =3D virtio_net_process_rss(nc, buf, size, &extra_hdr);
>          if (index >=3D 0) {
>              nc =3D qemu_get_subqueue(n->nic, index % n->curr_queue_pairs=
);
>          }
> @@ -1996,18 +1986,21 @@ static ssize_t virtio_net_receive_rcu(NetClientSt=
ate *nc, const uint8_t *buf,
>              if (n->mergeable_rx_bufs) {
>                  mhdr_cnt =3D iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
>                                      sg, elem->in_num,
> -                                    offsetof(typeof(hdr),
> -                                             virtio_net.hdr.num_buffers),
> -                                    sizeof(hdr.virtio_net.hdr.num_buffer=
s));
> +                                    offsetof(typeof(extra_hdr), hdr.num_=
buffers),
> +                                    sizeof(extra_hdr.hdr.num_buffers));
>              }
> =20
> -            guest_offset =3D n->has_vnet_hdr ?
> -                           receive_header(n, (struct virtio_net_hdr *)&h=
dr,
> -                                          buf, size, &offset) :
> -                           n->guest_hdr_len;
> -
> -            iov_from_buf(sg, elem->in_num, 0, &hdr, guest_offset);
> -            total +=3D guest_offset;
> +            receive_header(n, sg, elem->in_num, buf, size);
> +            if (n->rss_data.populate_hash) {
> +                offset =3D offsetof(typeof(extra_hdr), hash_value);
> +                iov_from_buf(sg, elem->in_num, offset,
> +                             (char *)&extra_hdr + offset,
> +                             sizeof(extra_hdr.hash_value) +
> +                             sizeof(extra_hdr.hash_report));
> +            }
> +            offset =3D n->host_hdr_len;
> +            total +=3D n->guest_hdr_len;
> +            guest_offset =3D n->guest_hdr_len;
>          } else {
>              guest_offset =3D 0;
>          }
> @@ -2033,11 +2026,11 @@ static ssize_t virtio_net_receive_rcu(NetClientSt=
ate *nc, const uint8_t *buf,
>      }
> =20
>      if (mhdr_cnt) {
> -        virtio_stw_p(vdev, &hdr.virtio_net.hdr.num_buffers, i);
> +        virtio_stw_p(vdev, &extra_hdr.hdr.num_buffers, i);
>          iov_from_buf(mhdr_sg, mhdr_cnt,
>                       0,
> -                     &hdr.virtio_net.hdr.num_buffers,
> -                     sizeof hdr.virtio_net.hdr.num_buffers);
> +                     &extra_hdr.hdr.num_buffers,
> +                     sizeof extra_hdr.hdr.num_buffers);
>      }
> =20
>      for (j =3D 0; j < i; j++) {
> --=20
> 2.49.0
>=20
>=20

--MRXpzXJzaNTLLKjG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf1K34ACgkQnKSrs4Gr
c8jjQwgAmurnGabI2eyZOIIOfMM1QsK6JcolDvan2byYjVVYEMQS95wSYUROnFFv
St83jIUxaKTIiRYnDhktJqL/TaAwL9mdzjVZtKwV4zM0KHxq/5P+GWMII1EU4sre
IzyPjzGTxDoa5nlaVo/6NQoT8N/81wnRUK+ZmH1s5jroNgj1JASBJaSrccouYVr4
MqsoWZPOqWapw/cR+No+984J1sjTyAsG1ckpmuEsH6O0wePMckw21g9OIniz8Th8
5Q0a2BDxkjGCpPvi8Atreh19qv9lNIDg2x/5/KVjN0Z77+TBo7klebn4ULo2zEWw
EicFKmmL+YEKLXeDLae44fdlQMMxBA==
=GBb+
-----END PGP SIGNATURE-----

--MRXpzXJzaNTLLKjG--


