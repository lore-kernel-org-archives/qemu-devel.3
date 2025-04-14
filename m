Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8210C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 19:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4PZU-0000Kv-7z; Mon, 14 Apr 2025 15:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u4PZR-0000KU-6G; Mon, 14 Apr 2025 15:34:17 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u4PZN-0005uM-Ko; Mon, 14 Apr 2025 15:34:16 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso8748562a12.3; 
 Mon, 14 Apr 2025 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744659251; x=1745264051; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvrB7pxgUmnfAOja/nRl+rFRr5WXTAqGaEdBJQAZr9o=;
 b=XV1Z3cnorjUasAPGqbQwHpiYpKXEJ28abcYWim+zgyO292qP8/9oYGbAjtVE3PX4Hv
 ASJF4VSs5dlO+zmHN3Frh1lhbwz9aybqn1Tmbn0owoMeE3otvCorVeslOhn0WCixke37
 TBRtRDJrQdOkBjcJg7c+q5KNwUNLz0L5OwKGiSgNJaRDOG/i4Tum+11p1OUmDOSVegAr
 fJNVPwrqj+MTRJZlzJnpHVXDR0v9nwuxzCuy46bLHMiQHh3aBT/MLXDh+wmMbEhf/xTQ
 1zqRXLF/lANMFeBZ7ZGHNcMcSo//RcnPB2KwHrMgX/XYrsLdWB7u6Da/tCwm6++/tkIQ
 kGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744659251; x=1745264051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvrB7pxgUmnfAOja/nRl+rFRr5WXTAqGaEdBJQAZr9o=;
 b=FTXmOaBOyccPTNTDn103ueOxByTxSEBv+a1EOrnqidJxtuTUm9iAwGFq3MNrL2qU/8
 B5SaB0NYkeui8ps7ZgVYzbaN61mbsLbwqNujhqQodUk4UnhEWeCuAWN75F54t3gFUgg0
 Xt00FFZEzQL0SOBv+aobvUUagCQfI7yO1cniS+xiA1r3lKuElZ0nmdIAMItA8VfQtz2m
 jvO48GcLvbZ8uJumgrgipnhd1Rfw+JUHEBQmPZ+u1X4RNwuHjJ11On6QV+X0Qc7EvEbw
 2tWmefnUZT18Abpbbe+pnZzymQ2kmexOiE2G/5i6CrrXpyutJF6hggVUB85txhhGNxnm
 qF6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhL+Vjo/s2G7p91XnZbuDctdjcUXywRABj022rrBz6EmHY0OK7HV6cnt8CtWLtIeClj6+DxW01TFJwcg==@nongnu.org
X-Gm-Message-State: AOJu0YyZGvzpk93OZveI7iDurlRmDUcZNtT1YpCIQlHUgkuXBzFbyBPp
 uT3H6UlnPfJnaeOVCM8V5QLqamjk4nabG/+YenxUEk0O14mNJDwxa9H8hg+cHQnYqdAibh4diJO
 RbzuZNZGiqG2ui2Xx0h76tVRGyd0=
X-Gm-Gg: ASbGncuNQAgIKZukyCOs5RIG5KB064T6NJjQOLB1Mbtuz34MGmfpY1oZABueKz1KpuT
 KcYlhVYHQ8WZ/7q235lg3ump1HsPvCZToojr92zRGtFlLJabYm8MdGwJt4CqhLlbr6fdqDOITP3
 p6rPgkfpidVPsopVCkLReG
X-Google-Smtp-Source: AGHT+IHC7cA17xRRrS+QI3FwYEsLV2VHQVGoQf1J4GTdj6qMN9N/RFOTynlu7TLw9ykuHoH03ehibRWtyZ66x5x3a58=
X-Received: by 2002:a05:6402:1d49:b0:5ec:cdb6:f29c with SMTP id
 4fb4d7f45d1cf-5f3702697d4mr10445947a12.25.1744659250513; Mon, 14 Apr 2025
 12:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250408145345.142947-1-adamhet@scaleway.com>
 <CAJSP0QVmT0jmbgu-fJjm78CSu-cb8ZuX5t0B25n0MG1f9W++oQ@mail.gmail.com>
In-Reply-To: <CAJSP0QVmT0jmbgu-fJjm78CSu-cb8ZuX5t0B25n0MG1f9W++oQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 14 Apr 2025 15:33:58 -0400
X-Gm-Features: ATxdqUGORWfkV7r3XdxOsPQUEWwfw0aInbcQM4WUcbaCRSimCnEJOPm9oCqH6hE
Message-ID: <CAJSP0QVC5epM-hQd9rGuL_Xi9tQjVaf8S-HpCKO2=dZJO8VoXA@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "virtio-net: Copy received header to buffer"
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Antoine Damhet <adamhet@scaleway.com>
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

On Thu, Apr 10, 2025 at 3:00=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Tue, Apr 8, 2025 at 10:55=E2=80=AFAM Antoine Damhet <adamhet@scaleway.=
com> wrote:
> >
> > This reverts commit 7987d2be5a8bc3a502f89ba8cf3ac3e09f64d1ce.
> >
> > The goal was to remove the need to patch the (const) input buffer
> > with a recomputed UDP checksum by copying headers to a RW region and
> > inject the checksum there. The patch computed the checksum only from th=
e
> > header fields (missing the rest of the payload) producing an invalid on=
e
> > and making guests fail to acquire a DHCP lease.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
> > ---
> > v2: Rebased on master due to conflict with c17ad4b11bd2 (
> > "virtio-net: Fix num_buffers for version 1")
>
> Michael: Please review this and send a pull request for 10.0 (-rc4
> will be tagged on Tuesday). There was a conflict so this is not a
> mechanical revert.

Hi Jason,
I realized Michael may not be online due to public holidays. Could you
review this patch?

virtio-net is so widely-used and security-critical that a review from
a virtio-net expert would be appreciated before I apply any code
changes for 10.0.

Thank you,
Stefan

>
> Thanks!
>
> >
> >  hw/net/virtio-net.c | 87 +++++++++++++++++++++------------------------
> >  1 file changed, 40 insertions(+), 47 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 340c6b642224..bd37651dabb0 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -1702,44 +1702,41 @@ static void virtio_net_hdr_swap(VirtIODevice *v=
dev, struct virtio_net_hdr *hdr)
> >   * cache.
> >   */
> >  static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
> > -                                        size_t *hdr_len, const uint8_t=
 *buf,
> > -                                        size_t buf_size, size_t *buf_o=
ffset)
> > +                                        uint8_t *buf, size_t size)
> >  {
> >      size_t csum_size =3D ETH_HLEN + sizeof(struct ip_header) +
> >                         sizeof(struct udp_header);
> >
> > -    buf +=3D *buf_offset;
> > -    buf_size -=3D *buf_offset;
> > -
> >      if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum =
*/
> > -        (buf_size >=3D csum_size && buf_size < 1500) && /* normal size=
d MTU */
> > +        (size >=3D csum_size && size < 1500) && /* normal sized MTU */
> >          (buf[12] =3D=3D 0x08 && buf[13] =3D=3D 0x00) && /* ethertype =
=3D=3D IPv4 */
> >          (buf[23] =3D=3D 17) && /* ip.protocol =3D=3D UDP */
> >          (buf[34] =3D=3D 0 && buf[35] =3D=3D 67)) { /* udp.srcport =3D=
=3D bootps */
> > -        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
> > -        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, C=
SUM_UDP);
> > +        net_checksum_calculate(buf, size, CSUM_UDP);
> >          hdr->flags &=3D ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
> > -        *hdr_len +=3D csum_size;
> > -        *buf_offset +=3D csum_size;
> >      }
> >  }
> >
> > -static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
> > -                             const void *buf, size_t buf_size,
> > -                             size_t *buf_offset)
> > +static void receive_header(VirtIONet *n, const struct iovec *iov, int =
iov_cnt,
> > +                           const void *buf, size_t size)
> >  {
> > -    size_t hdr_len =3D n->guest_hdr_len;
> > -
> > -    memcpy(hdr, buf, sizeof(struct virtio_net_hdr));
> > -
> > -    *buf_offset =3D n->host_hdr_len;
> > -    work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offs=
et);
> > +    if (n->has_vnet_hdr) {
> > +        /* FIXME this cast is evil */
> > +        void *wbuf =3D (void *)buf;
> > +        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
> > +                                    size - n->host_hdr_len);
> >
> > -    if (n->needs_vnet_hdr_swap) {
> > -        virtio_net_hdr_swap(VIRTIO_DEVICE(n), hdr);
> > +        if (n->needs_vnet_hdr_swap) {
> > +            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
> > +        }
> > +        iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hd=
r));
> > +    } else {
> > +        struct virtio_net_hdr hdr =3D {
> > +            .flags =3D 0,
> > +            .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> > +        };
> > +        iov_from_buf(iov, iov_cnt, 0, &hdr, sizeof hdr);
> >      }
> > -
> > -    return hdr_len;
> >  }
> >
> >  static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
> > @@ -1907,13 +1904,6 @@ static int virtio_net_process_rss(NetClientState=
 *nc, const uint8_t *buf,
> >      return (index =3D=3D new_index) ? -1 : new_index;
> >  }
> >
> > -typedef struct Header {
> > -    struct virtio_net_hdr_v1_hash virtio_net;
> > -    struct eth_header eth;
> > -    struct ip_header ip;
> > -    struct udp_header udp;
> > -} Header;
> > -
> >  static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_=
t *buf,
> >                                        size_t size)
> >  {
> > @@ -1923,15 +1913,15 @@ static ssize_t virtio_net_receive_rcu(NetClient=
State *nc, const uint8_t *buf,
> >      VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
> >      size_t lens[VIRTQUEUE_MAX_SIZE];
> >      struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
> > -    Header hdr;
> > +    struct virtio_net_hdr_v1_hash extra_hdr;
> >      unsigned mhdr_cnt =3D 0;
> >      size_t offset, i, guest_offset, j;
> >      ssize_t err;
> >
> > -    memset(&hdr.virtio_net, 0, sizeof(hdr.virtio_net));
> > +    memset(&extra_hdr, 0, sizeof(extra_hdr));
> >
> >      if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
> > -        int index =3D virtio_net_process_rss(nc, buf, size, &hdr.virti=
o_net);
> > +        int index =3D virtio_net_process_rss(nc, buf, size, &extra_hdr=
);
> >          if (index >=3D 0) {
> >              nc =3D qemu_get_subqueue(n->nic, index % n->curr_queue_pai=
rs);
> >          }
> > @@ -1996,20 +1986,23 @@ static ssize_t virtio_net_receive_rcu(NetClient=
State *nc, const uint8_t *buf,
> >              if (n->mergeable_rx_bufs) {
> >                  mhdr_cnt =3D iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
> >                                      sg, elem->in_num,
> > -                                    offsetof(typeof(hdr),
> > -                                             virtio_net.hdr.num_buffer=
s),
> > -                                    sizeof(hdr.virtio_net.hdr.num_buff=
ers));
> > +                                    offsetof(typeof(extra_hdr), hdr.nu=
m_buffers),
> > +                                    sizeof(extra_hdr.hdr.num_buffers))=
;
> >              } else {
> > -                hdr.virtio_net.hdr.num_buffers =3D cpu_to_le16(1);
> > +                extra_hdr.hdr.num_buffers =3D cpu_to_le16(1);
> >              }
> >
> > -            guest_offset =3D n->has_vnet_hdr ?
> > -                           receive_header(n, (struct virtio_net_hdr *)=
&hdr,
> > -                                          buf, size, &offset) :
> > -                           n->guest_hdr_len;
> > -
> > -            iov_from_buf(sg, elem->in_num, 0, &hdr, guest_offset);
> > -            total +=3D guest_offset;
> > +            receive_header(n, sg, elem->in_num, buf, size);
> > +            if (n->rss_data.populate_hash) {
> > +                offset =3D offsetof(typeof(extra_hdr), hash_value);
> > +                iov_from_buf(sg, elem->in_num, offset,
> > +                             (char *)&extra_hdr + offset,
> > +                             sizeof(extra_hdr.hash_value) +
> > +                             sizeof(extra_hdr.hash_report));
> > +            }
> > +            offset =3D n->host_hdr_len;
> > +            total +=3D n->guest_hdr_len;
> > +            guest_offset =3D n->guest_hdr_len;
> >          } else {
> >              guest_offset =3D 0;
> >          }
> > @@ -2035,11 +2028,11 @@ static ssize_t virtio_net_receive_rcu(NetClient=
State *nc, const uint8_t *buf,
> >      }
> >
> >      if (mhdr_cnt) {
> > -        virtio_stw_p(vdev, &hdr.virtio_net.hdr.num_buffers, i);
> > +        virtio_stw_p(vdev, &extra_hdr.hdr.num_buffers, i);
> >          iov_from_buf(mhdr_sg, mhdr_cnt,
> >                       0,
> > -                     &hdr.virtio_net.hdr.num_buffers,
> > -                     sizeof hdr.virtio_net.hdr.num_buffers);
> > +                     &extra_hdr.hdr.num_buffers,
> > +                     sizeof extra_hdr.hdr.num_buffers);
> >      }
> >
> >      for (j =3D 0; j < i; j++) {
> > --
> > 2.49.0
> >
> >

