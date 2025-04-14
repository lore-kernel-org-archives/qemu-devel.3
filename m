Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA01AC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 22:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Sbm-0001ud-Jl; Mon, 14 Apr 2025 18:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u4Sbj-0001u9-Mx
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 18:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u4Sbg-0007Ui-Nc
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 18:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744670926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P7dUKMwWT0bSvUx7q6bA9Ux/S02vy3fmn3XeQ9ciZ4k=;
 b=Wbzbr53MMlIFKFJN58rUWULlTynSpxn1TiEBQajGWW2Hk+jjARZ5xZ2aBI4WzGlrbO9Fap
 +Fq8B0DjTB/kiCnrwnp56uJFzFaznZrGNBzyYT1M6N5m0UPdCIbmCg8MrR5G+AO5Z0YNqk
 SXqnvQnhgicPp5QldU0C/6K6ESdyvWw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-7EM_TVe5NwWy5iBIlSdw3w-1; Mon, 14 Apr 2025 18:48:44 -0400
X-MC-Unique: 7EM_TVe5NwWy5iBIlSdw3w-1
X-Mimecast-MFC-AGG-ID: 7EM_TVe5NwWy5iBIlSdw3w_1744670923
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so26917075e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 15:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744670923; x=1745275723;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P7dUKMwWT0bSvUx7q6bA9Ux/S02vy3fmn3XeQ9ciZ4k=;
 b=mzwe+szdPzBcFWpdgGDQ0LdU4HBtSBtoz7zow/TQ3iSbBXL4/i7ArfnDcupiAozb5D
 RyvJ3uT8URThzayPQZbZKL+U+GLe9Z16JaCsiTBe4ixqMfdLTcQdb3/fShLjr3foWOYv
 FwRHox3oRtOTnQFMwjYiJyjBviOE2uXSxgi3EfSOynI8EjYDD6o/k/qMtzmWkrCeHxpS
 /Ssod/v3ehNj59nymxmMiOiwIqfBRjmv46jvSIeScQl26GgnozRz4vFbHn46FltICiYX
 pEW0vxrV2GQcNNF5xnWeI3JqxV42TeZKgg9mGFa+Rvk775A5NAAnfJ0ktRCu3k+lEUjw
 Yz1g==
X-Gm-Message-State: AOJu0YzHpMHxiYqHOdC7vz+ofu10+4sQmRT02ZKdQYvcki0fqb9YG56x
 3BlWc6IkNRfxTQpCilAsXEL0yIh/gLdE0MJXOMAxzqzYoTjfkoUMv3PHvA/D+Ub7G0S2wHewlZE
 XAgw1yX0exCaA1jizSGzs9XXc3oDiAJtURSP0dP4QJeeF7HpE5zAhhSEnlaug
X-Gm-Gg: ASbGncunmdb/5Bin9zx21LeMw/k1urhTDkdrfhWCc4hVMIgpcYOPdmALqST9X1Igzc5
 tFGZ4xVItnCBNG+t20q7DU0c50Qcg1joWyxYitT6NNxIokgFMh0w4qcW11Gd7wBlnSonZyrqRw2
 urjBDxq27qX4MMgJU4h0f1Xm2pQsmjCYg2PJpHeUJJhcNAfrjTeca2KBRe0Kn4IkDw5axCqUAAM
 1cM6rE5622ohuZNe+WreyzICDGcpBLUFI7MjGDQZ98tytu6C+DTygTGhCib7YzqiXmOaSbocE9c
 BFWCEQ==
X-Received: by 2002:a05:6000:401f:b0:391:3aaf:1d5f with SMTP id
 ffacd0b85a97d-39eaaecaaf6mr11620401f8f.52.1744670922838; 
 Mon, 14 Apr 2025 15:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh5rFCtI7x/rKf1gLh4vN9Nx0yQ9msFEHiGrYpvKP45qdVJbqxTsh3EIKpAYQ6UFoCL71Wpg==
X-Received: by 2002:a05:6000:401f:b0:391:3aaf:1d5f with SMTP id
 ffacd0b85a97d-39eaaecaaf6mr11620391f8f.52.1744670922413; 
 Mon, 14 Apr 2025 15:48:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae9780a0sm12348251f8f.50.2025.04.14.15.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 15:48:41 -0700 (PDT)
Date: Mon, 14 Apr 2025 18:48:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org,
 Antoine Damhet <adamhet@scaleway.com>
Subject: Re: [PATCH v2] Revert "virtio-net: Copy received header to buffer"
Message-ID: <20250414184718-mutt-send-email-mst@kernel.org>
References: <20250408145345.142947-1-adamhet@scaleway.com>
 <CAJSP0QVmT0jmbgu-fJjm78CSu-cb8ZuX5t0B25n0MG1f9W++oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QVmT0jmbgu-fJjm78CSu-cb8ZuX5t0B25n0MG1f9W++oQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Thu, Apr 10, 2025 at 03:00:40PM -0400, Stefan Hajnoczi wrote:
> On Tue, Apr 8, 2025 at 10:55 AM Antoine Damhet <adamhet@scaleway.com> wrote:
> >
> > This reverts commit 7987d2be5a8bc3a502f89ba8cf3ac3e09f64d1ce.
> >
> > The goal was to remove the need to patch the (const) input buffer
> > with a recomputed UDP checksum by copying headers to a RW region and
> > inject the checksum there. The patch computed the checksum only from the
> > header fields (missing the rest of the payload) producing an invalid one
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
> 
> Thanks!


Backlogged because of holidays, sorry.


Revert looks good:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

but this (userspace networking) is mostly Jason's area, not mine.



> >
> >  hw/net/virtio-net.c | 87 +++++++++++++++++++++------------------------
> >  1 file changed, 40 insertions(+), 47 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 340c6b642224..bd37651dabb0 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -1702,44 +1702,41 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
> >   * cache.
> >   */
> >  static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
> > -                                        size_t *hdr_len, const uint8_t *buf,
> > -                                        size_t buf_size, size_t *buf_offset)
> > +                                        uint8_t *buf, size_t size)
> >  {
> >      size_t csum_size = ETH_HLEN + sizeof(struct ip_header) +
> >                         sizeof(struct udp_header);
> >
> > -    buf += *buf_offset;
> > -    buf_size -= *buf_offset;
> > -
> >      if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
> > -        (buf_size >= csum_size && buf_size < 1500) && /* normal sized MTU */
> > +        (size >= csum_size && size < 1500) && /* normal sized MTU */
> >          (buf[12] == 0x08 && buf[13] == 0x00) && /* ethertype == IPv4 */
> >          (buf[23] == 17) && /* ip.protocol == UDP */
> >          (buf[34] == 0 && buf[35] == 67)) { /* udp.srcport == bootps */
> > -        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
> > -        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, CSUM_UDP);
> > +        net_checksum_calculate(buf, size, CSUM_UDP);
> >          hdr->flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
> > -        *hdr_len += csum_size;
> > -        *buf_offset += csum_size;
> >      }
> >  }
> >
> > -static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
> > -                             const void *buf, size_t buf_size,
> > -                             size_t *buf_offset)
> > +static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
> > +                           const void *buf, size_t size)
> >  {
> > -    size_t hdr_len = n->guest_hdr_len;
> > -
> > -    memcpy(hdr, buf, sizeof(struct virtio_net_hdr));
> > -
> > -    *buf_offset = n->host_hdr_len;
> > -    work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offset);
> > +    if (n->has_vnet_hdr) {
> > +        /* FIXME this cast is evil */
> > +        void *wbuf = (void *)buf;
> > +        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
> > +                                    size - n->host_hdr_len);
> >
> > -    if (n->needs_vnet_hdr_swap) {
> > -        virtio_net_hdr_swap(VIRTIO_DEVICE(n), hdr);
> > +        if (n->needs_vnet_hdr_swap) {
> > +            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
> > +        }
> > +        iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr));
> > +    } else {
> > +        struct virtio_net_hdr hdr = {
> > +            .flags = 0,
> > +            .gso_type = VIRTIO_NET_HDR_GSO_NONE
> > +        };
> > +        iov_from_buf(iov, iov_cnt, 0, &hdr, sizeof hdr);
> >      }
> > -
> > -    return hdr_len;
> >  }
> >
> >  static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
> > @@ -1907,13 +1904,6 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
> >      return (index == new_index) ? -1 : new_index;
> >  }
> >
> > -typedef struct Header {
> > -    struct virtio_net_hdr_v1_hash virtio_net;
> > -    struct eth_header eth;
> > -    struct ip_header ip;
> > -    struct udp_header udp;
> > -} Header;
> > -
> >  static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
> >                                        size_t size)
> >  {
> > @@ -1923,15 +1913,15 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
> >      VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
> >      size_t lens[VIRTQUEUE_MAX_SIZE];
> >      struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
> > -    Header hdr;
> > +    struct virtio_net_hdr_v1_hash extra_hdr;
> >      unsigned mhdr_cnt = 0;
> >      size_t offset, i, guest_offset, j;
> >      ssize_t err;
> >
> > -    memset(&hdr.virtio_net, 0, sizeof(hdr.virtio_net));
> > +    memset(&extra_hdr, 0, sizeof(extra_hdr));
> >
> >      if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
> > -        int index = virtio_net_process_rss(nc, buf, size, &hdr.virtio_net);
> > +        int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
> >          if (index >= 0) {
> >              nc = qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
> >          }
> > @@ -1996,20 +1986,23 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
> >              if (n->mergeable_rx_bufs) {
> >                  mhdr_cnt = iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
> >                                      sg, elem->in_num,
> > -                                    offsetof(typeof(hdr),
> > -                                             virtio_net.hdr.num_buffers),
> > -                                    sizeof(hdr.virtio_net.hdr.num_buffers));
> > +                                    offsetof(typeof(extra_hdr), hdr.num_buffers),
> > +                                    sizeof(extra_hdr.hdr.num_buffers));
> >              } else {
> > -                hdr.virtio_net.hdr.num_buffers = cpu_to_le16(1);
> > +                extra_hdr.hdr.num_buffers = cpu_to_le16(1);
> >              }
> >
> > -            guest_offset = n->has_vnet_hdr ?
> > -                           receive_header(n, (struct virtio_net_hdr *)&hdr,
> > -                                          buf, size, &offset) :
> > -                           n->guest_hdr_len;
> > -
> > -            iov_from_buf(sg, elem->in_num, 0, &hdr, guest_offset);
> > -            total += guest_offset;
> > +            receive_header(n, sg, elem->in_num, buf, size);
> > +            if (n->rss_data.populate_hash) {
> > +                offset = offsetof(typeof(extra_hdr), hash_value);
> > +                iov_from_buf(sg, elem->in_num, offset,
> > +                             (char *)&extra_hdr + offset,
> > +                             sizeof(extra_hdr.hash_value) +
> > +                             sizeof(extra_hdr.hash_report));
> > +            }
> > +            offset = n->host_hdr_len;
> > +            total += n->guest_hdr_len;
> > +            guest_offset = n->guest_hdr_len;
> >          } else {
> >              guest_offset = 0;
> >          }
> > @@ -2035,11 +2028,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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
> >      for (j = 0; j < i; j++) {
> > --
> > 2.49.0
> >
> >


