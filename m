Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE27C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 19:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2x92-0000WQ-MJ; Thu, 10 Apr 2025 15:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u2x91-0000VL-Aj; Thu, 10 Apr 2025 15:00:59 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u2x8y-0008Hl-Lp; Thu, 10 Apr 2025 15:00:58 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5eb5ecf3217so2194920a12.3; 
 Thu, 10 Apr 2025 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744311653; x=1744916453; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmA79TPB8DzVP9v42w5Mm5jwpBI20BPPUsMnSyuFNFw=;
 b=mRxNPC+Jw7t0jv+73zi22Yy04OaEcdHQ/LGsDtVySgAUZh7aXVyY2Tzvp/j3h4azti
 D7jTtH0ByArfaMgmRw5Q2MGd8+cU8Pru4MY/TNzzbJ8DMV5NkJEeasMR82gzhwJw26pg
 vGN+9GmoOstBkTj4mqVlDLp1aBU5jIKEPl668RlfP3RRur2lNVAH/SX/QLdrEMpqLAaN
 dejZzyT3mVxIUmxo97mE/RxH/c4k9bzaP5UdNwQfSLR6+hugkNKSrwNFRh+fGHWPg21x
 lTGnCD4xM0pn1yK8fumpg9debtcM5Z763SC69vF6tadgQsYWQZUXY+L39WB0No7LGdWK
 68Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744311653; x=1744916453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JmA79TPB8DzVP9v42w5Mm5jwpBI20BPPUsMnSyuFNFw=;
 b=PJmFE91M40ZP0UQEnSmpyxHcoWktsQuNFKCo/kKPEkCmYGI6MX05g/rnyiEwz1CPgm
 +Wy0rtsGruPzrf6vRhwN/QoSFuRENbhUcPx8IwPhRfovl65VeJ0Gjinl5SmmbDSgVmuR
 4U2OHZjQtaaPrXMDLNeu79Me52UcKlmK4nUTIXLVCiBY19ByZUh5ZdLgMrwGrrL2OIAe
 oAWkyliGMnZzVZFsXr90lynwFn+Gw1dMjYh86Ind8Gddr/U6h2vtfg1gQbWndeyPpGGG
 3jQnOiawsmJ0cKN0jWQPZPN9nGq3km47RljH+RgaBoP8SPzibMtUA4c0PErEOcSqN7zm
 /gdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdqlm7hR+rxeR6HYxuk1J77pfsBwcdMVZ7phWlJN7amVpuGViAX+bBPBUIJcNt+FpqL6AnR3B323elgw==@nongnu.org
X-Gm-Message-State: AOJu0Yyn6TZxuLHTMuvGeEmXq3i+u6mjN00+yHwu3RE/fRWJAnXAntQW
 5LLEmHECPlZoiBpyyqOgiOF1oNfFmSA3uVILdUSgqknwZiArfAgquhg11mXG/HsXhrX+M5SeAjo
 gg+/Hv8SPK7dp+thnV5YYZ+Az+2I=
X-Gm-Gg: ASbGncu26NkPTcZZ0Sio+/b2galySOFvwBzREyK8GsHzp9+wnwGt1yC34QQYEqXndmr
 jW6LzJDfTAGGgdDsaI+nSWDENLeI+wZtXjHZ/OMpocJchzd7c/YNmoxk71dI0T3c7MVPH1tBcDv
 EMd7z9Kq9crNpyFp7ATWdW
X-Google-Smtp-Source: AGHT+IHL0naMJutfezY1Yu88PFaZT9tKPZo1PNlRaSLbsPQwC9GBI99Bp1R4V0w2Y73aVMGmxuc+3mlrrAfAza/qPsY=
X-Received: by 2002:a05:6402:2103:b0:5dc:c9ce:b022 with SMTP id
 4fb4d7f45d1cf-5f32926ac13mr2978619a12.9.1744311652517; Thu, 10 Apr 2025
 12:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250408145345.142947-1-adamhet@scaleway.com>
In-Reply-To: <20250408145345.142947-1-adamhet@scaleway.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 10 Apr 2025 15:00:40 -0400
X-Gm-Features: ATxdqUFE75K7KQiPZcIQxC6afZ6x5kl8I6MR0O_tXgwciZmCwc4uxFbrD4zmd9s
Message-ID: <CAJSP0QVmT0jmbgu-fJjm78CSu-cb8ZuX5t0B25n0MG1f9W++oQ@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "virtio-net: Copy received header to buffer"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-stable@nongnu.org, Antoine Damhet <adamhet@scaleway.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 8, 2025 at 10:55=E2=80=AFAM Antoine Damhet <adamhet@scaleway.co=
m> wrote:
>
> This reverts commit 7987d2be5a8bc3a502f89ba8cf3ac3e09f64d1ce.
>
> The goal was to remove the need to patch the (const) input buffer
> with a recomputed UDP checksum by copying headers to a RW region and
> inject the checksum there. The patch computed the checksum only from the
> header fields (missing the rest of the payload) producing an invalid one
> and making guests fail to acquire a DHCP lease.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
> ---
> v2: Rebased on master due to conflict with c17ad4b11bd2 (
> "virtio-net: Fix num_buffers for version 1")

Michael: Please review this and send a pull request for 10.0 (-rc4
will be tagged on Tuesday). There was a conflict so this is not a
mechanical revert.

Thanks!

>
>  hw/net/virtio-net.c | 87 +++++++++++++++++++++------------------------
>  1 file changed, 40 insertions(+), 47 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 340c6b642224..bd37651dabb0 100644
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
>
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
>
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
>
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
>
>  static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
> @@ -1907,13 +1904,6 @@ static int virtio_net_process_rss(NetClientState *=
nc, const uint8_t *buf,
>      return (index =3D=3D new_index) ? -1 : new_index;
>  }
>
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
>
> -    memset(&hdr.virtio_net, 0, sizeof(hdr.virtio_net));
> +    memset(&extra_hdr, 0, sizeof(extra_hdr));
>
>      if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
> -        int index =3D virtio_net_process_rss(nc, buf, size, &hdr.virtio_=
net);
> +        int index =3D virtio_net_process_rss(nc, buf, size, &extra_hdr);
>          if (index >=3D 0) {
>              nc =3D qemu_get_subqueue(n->nic, index % n->curr_queue_pairs=
);
>          }
> @@ -1996,20 +1986,23 @@ static ssize_t virtio_net_receive_rcu(NetClientSt=
ate *nc, const uint8_t *buf,
>              if (n->mergeable_rx_bufs) {
>                  mhdr_cnt =3D iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
>                                      sg, elem->in_num,
> -                                    offsetof(typeof(hdr),
> -                                             virtio_net.hdr.num_buffers)=
,
> -                                    sizeof(hdr.virtio_net.hdr.num_buffer=
s));
> +                                    offsetof(typeof(extra_hdr), hdr.num_=
buffers),
> +                                    sizeof(extra_hdr.hdr.num_buffers));
>              } else {
> -                hdr.virtio_net.hdr.num_buffers =3D cpu_to_le16(1);
> +                extra_hdr.hdr.num_buffers =3D cpu_to_le16(1);
>              }
>
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
> @@ -2035,11 +2028,11 @@ static ssize_t virtio_net_receive_rcu(NetClientSt=
ate *nc, const uint8_t *buf,
>      }
>
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
>
>      for (j =3D 0; j < i; j++) {
> --
> 2.49.0
>
>

