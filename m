Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB6BC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 19:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYV97-0006pE-En; Thu, 16 Jan 2025 14:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tYV91-0006mO-5I
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:03:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tYV8y-0006hg-OD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737054181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yZf2viWkuuZ1b9O9mAysBkLOCkwwqsTjsyf8kLjYhcY=;
 b=M1AAJcLJ6cl0ykchwAlcUzAitioLZlg7VA5/tjx63Obm8DOr5D3gsjbhGg1zIK1i40/Ic8
 sht+O8Lyr8ZZAybb56RZcqA4nVgwQniwbyX0MjveEIcCQaMkePOvK2cxgkNeGW0eev/YN4
 pJru/WNQxYPDYjYmDY4Q/l/CTRHomLI=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-jT0TJ2etOmqilhDTxDu4FA-1; Thu, 16 Jan 2025 14:03:00 -0500
X-MC-Unique: jT0TJ2etOmqilhDTxDu4FA-1
X-Mimecast-MFC-AGG-ID: jT0TJ2etOmqilhDTxDu4FA
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e54d9b54500so3396128276.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 11:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737054178; x=1737658978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZf2viWkuuZ1b9O9mAysBkLOCkwwqsTjsyf8kLjYhcY=;
 b=smOUc1rMn0ffZSneO7seYqFU3XayAIKopUodg7LuqU4S+2JjbLsv34noKRWm2yKPz5
 TpYlLjK1ZR9XbQNCflbxQGn1rieIW5JFq9oHGDVcxULl17P/WIlM4QUmAHMiDZhSQqBh
 cv30fdPBft1EzV/iBgayjKm7jLt/czyOQgKdweWk0oHCMVMs2Omg3EwDA5+h5d0NORbq
 0WZEr+ny6cq4yKVW4IOHSIsesOC82uNKO1OApZBzOGZGn7WRhVvGbejIsYo+dYxgQQn8
 +GDYPeCBdhswerW4DcsKOUo0xNE/z2IRHQTI5Eu1ra7XU52ONdgfFu8DGTGSm3S03JQp
 7H7w==
X-Gm-Message-State: AOJu0YzAQuDscNPY/eoNo99ymMvPz4zVKPddxqLPcbDVEk+GLsZQ/X1f
 Iv/f1rxVMdZVZ+LcHPX3hnQFaTZ1v+aZ+pqd7EIcEzaqOWyGSMPObpXd7VEAyV28elA7TweLIe4
 WWQyMaXs5wbm5EOojAoG4hpsk4dbRIxZWPh4pZjIQdBQX6H/fAdBLc7WvrNM65EwiJe1N5JMQxP
 hi8rnh/XWbYP0G+8RbbkdvY+b92gi38dQPbkg=
X-Gm-Gg: ASbGncvocIQhTWUq9mUUDWaVpOdE05olUPzwlCYxhZKfMK1KZLfquPQ3+5pI5oR27AT
 /fdxFeIjofJp+3m2E6pmypM11YNMYOphq+Tl/0Q==
X-Received: by 2002:a05:690c:4a05:b0:6ef:738a:94b3 with SMTP id
 00721157ae682-6f5312273a4mr255326617b3.4.1737054178156; 
 Thu, 16 Jan 2025 11:02:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh7u+ExmLPFJk4cpY1lilY5AephLB7Z6TtAiFPvZhKqOWiMqSNU5wL/+hpb+L85hPChwTzd3TvUkjA1jsGA7U=
X-Received: by 2002:a05:690c:4a05:b0:6ef:738a:94b3 with SMTP id
 00721157ae682-6f5312273a4mr255326247b3.4.1737054177709; Thu, 16 Jan 2025
 11:02:57 -0800 (PST)
MIME-Version: 1.0
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
 <20250110170837.2747532-5-jonah.palmer@oracle.com>
In-Reply-To: <20250110170837.2747532-5-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jan 2025 20:02:21 +0100
X-Gm-Features: AbW1kvYx_YaXYAYnhLCs4Gvd0aIglwggDPOs8na9THf2bqxkA-oHaNtOFwcKi4I
Message-ID: <CAJaqyWfSffrHcMt-EFW9P_jmVjK6v4hf_V_rLrrihTguQNX7Lw@mail.gmail.com>
Subject: Re: [RFC v3 4/5] virtio: add in_xlat_addr & out_xlat_addr
 VirtQueueElement members
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com, 
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 10, 2025 at 6:09=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Adds the in_xlat_addr & out_xlat_addr hwaddr arrays to the
> VirtQueueElement struct and introduces an optional GPA output parameter
> to dma_memory_map().
>
> These arrays will store a VirtQueueElement's input/output descriptors'
> GPA of the mapped memory region, if it's backed by guest memory, via
> dma_memory_map().
>
> The GPA will always correspond 1:1 to the iovec entry when translating
> addresses between Qemu VAs and SVQ IOVAs in vhost_svq_translate_addr().
> This helps to avoid extra complicated code in SVQ's
> vhost_svq_vring_write_descs() function (e.g. splitting up iovec into
> multiple buffers, not breaking devices using aliased mapping, etc.).
>
> Since the translation is only done once inside the DMA API alongside
> virtqueue_pop(), the cost should be minimal.
>

I think this is a very strong change as it touches the dma subsystem.
Let me try to avoid it on 5/5 :).

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/display/virtio-gpu.c     |  5 ++--
>  hw/hyperv/vmbus.c           |  8 +++---
>  hw/ide/ahci.c               |  7 +++---
>  hw/usb/libhw.c              |  2 +-
>  hw/virtio/virtio.c          | 50 ++++++++++++++++++++++++++-----------
>  include/hw/pci/pci_device.h |  2 +-
>  include/hw/virtio/virtio.h  |  2 ++
>  include/system/dma.h        | 25 ++++++++++++++++++-
>  system/dma-helpers.c        |  2 +-
>  9 files changed, 77 insertions(+), 26 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 11a7a85750..afb9a8b69f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -839,7 +839,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>              len =3D l;
>              map =3D dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, &len,
>                                   DMA_DIRECTION_TO_DEVICE,
> -                                 MEMTXATTRS_UNSPECIFIED);
> +                                 MEMTXATTRS_UNSPECIFIED, NULL);
>              if (!map) {
>                  qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO m=
emory for"
>                                " element %d\n", __func__, e);
> @@ -1258,7 +1258,8 @@ static bool virtio_gpu_load_restore_mapping(VirtIOG=
PU *g,
>          hwaddr len =3D res->iov[i].iov_len;
>          res->iov[i].iov_base =3D
>              dma_memory_map(VIRTIO_DEVICE(g)->dma_as, res->addrs[i], &len=
,
> -                           DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFI=
ED);
> +                           DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFI=
ED,
> +                           NULL);
>
>          if (!res->iov[i].iov_base || len !=3D res->iov[i].iov_len) {
>              /* Clean up the half-a-mapping we just created... */
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index 12a7dc4312..c3308a1bfd 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -374,7 +374,7 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *b=
uf, uint32_t len)
>              maddr =3D (iter->gpadl->gfns[idx] << TARGET_PAGE_BITS) | off=
_in_page;
>
>              iter->map =3D dma_memory_map(iter->as, maddr, &mlen, iter->d=
ir,
> -                                       MEMTXATTRS_UNSPECIFIED);
> +                                       MEMTXATTRS_UNSPECIFIED, NULL);
>              if (mlen !=3D pgleft) {
>                  dma_memory_unmap(iter->as, iter->map, mlen, iter->dir, 0=
);
>                  iter->map =3D NULL;
> @@ -492,7 +492,8 @@ int vmbus_map_sgl(VMBusChanReq *req, DMADirection dir=
, struct iovec *iov,
>              }
>
>              iov[ret_cnt].iov_base =3D dma_memory_map(sgl->as, a, &l, dir=
,
> -                                                   MEMTXATTRS_UNSPECIFIE=
D);
> +                                                   MEMTXATTRS_UNSPECIFIE=
D,
> +                                                   NULL);
>              if (!l) {
>                  ret =3D -EFAULT;
>                  goto err;
> @@ -568,7 +569,8 @@ static vmbus_ring_buffer *ringbuf_map_hdr(VMBusRingBu=
fCommon *ringbuf)
>      dma_addr_t mlen =3D sizeof(*rb);
>
>      rb =3D dma_memory_map(ringbuf->as, ringbuf->rb_addr, &mlen,
> -                        DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIE=
D);
> +                        DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIE=
D,
> +                        NULL);
>      if (mlen !=3D sizeof(*rb)) {
>          dma_memory_unmap(ringbuf->as, rb, mlen,
>                           DMA_DIRECTION_FROM_DEVICE, 0);
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 1303c21cb7..aeea2dc61d 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -221,7 +221,7 @@ static void map_page(AddressSpace *as, uint8_t **ptr,=
 uint64_t addr,
>      }
>
>      *ptr =3D dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE,
> -                          MEMTXATTRS_UNSPECIFIED);
> +                          MEMTXATTRS_UNSPECIFIED, NULL);
>      if (len < wanted && *ptr) {
>          dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
>          *ptr =3D NULL;
> @@ -928,7 +928,7 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUS=
GList *sglist,
>      /* map PRDT */
>      if (!(prdt =3D dma_memory_map(ad->hba->as, prdt_addr, &prdt_len,
>                                  DMA_DIRECTION_TO_DEVICE,
> -                                MEMTXATTRS_UNSPECIFIED))){
> +                                MEMTXATTRS_UNSPECIFIED, NULL))) {
>          trace_ahci_populate_sglist_no_map(ad->hba, ad->port_no);
>          return -1;
>      }
> @@ -1338,7 +1338,8 @@ static void handle_cmd(AHCIState *s, int port, uint=
8_t slot)
>      tbl_addr =3D le64_to_cpu(cmd->tbl_addr);
>      cmd_len =3D 0x80;
>      cmd_fis =3D dma_memory_map(s->as, tbl_addr, &cmd_len,
> -                             DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECI=
FIED);
> +                             DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECI=
FIED,
> +                             NULL);
>      if (!cmd_fis) {
>          trace_handle_cmd_badfis(s, port);
>          return;
> diff --git a/hw/usb/libhw.c b/hw/usb/libhw.c
> index 4f03ef4ba9..762d70b419 100644
> --- a/hw/usb/libhw.c
> +++ b/hw/usb/libhw.c
> @@ -37,7 +37,7 @@ int usb_packet_map(USBPacket *p, QEMUSGList *sgl)
>          while (len) {
>              dma_addr_t xlen =3D len;
>              mem =3D dma_memory_map(sgl->as, base, &xlen, dir,
> -                                 MEMTXATTRS_UNSPECIFIED);
> +                                 MEMTXATTRS_UNSPECIFIED, NULL);
>              if (!mem) {
>                  goto err;
>              }
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce37..be756f3ac8 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1553,9 +1553,9 @@ int virtqueue_avail_bytes(VirtQueue *vq, unsigned i=
nt in_bytes,
>  }
>
>  static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_s=
g,
> -                               hwaddr *addr, struct iovec *iov,
> -                               unsigned int max_num_sg, bool is_write,
> -                               hwaddr pa, size_t sz)
> +                               hwaddr *addr, hwaddr *xlat_addr,
> +                               struct iovec *iov, unsigned int max_num_s=
g,
> +                               bool is_write, hwaddr pa, size_t sz)
>  {
>      bool ok =3D false;
>      unsigned num_sg =3D *p_num_sg;
> @@ -1579,7 +1579,8 @@ static bool virtqueue_map_desc(VirtIODevice *vdev, =
unsigned int *p_num_sg,
>                                                is_write ?
>                                                DMA_DIRECTION_FROM_DEVICE =
:
>                                                DMA_DIRECTION_TO_DEVICE,
> -                                              MEMTXATTRS_UNSPECIFIED);
> +                                              MEMTXATTRS_UNSPECIFIED,
> +                                              &xlat_addr[num_sg]);
>          if (!iov[num_sg].iov_base) {
>              virtio_error(vdev, "virtio: bogus descriptor or out of resou=
rces");
>              goto out;
> @@ -1618,7 +1619,7 @@ static void virtqueue_undo_map_desc(unsigned int ou=
t_num, unsigned int in_num,
>
>  static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
>                                  hwaddr *addr, unsigned int num_sg,
> -                                bool is_write)
> +                                hwaddr *xlat_addr, bool is_write)
>  {
>      unsigned int i;
>      hwaddr len;
> @@ -1629,7 +1630,8 @@ static void virtqueue_map_iovec(VirtIODevice *vdev,=
 struct iovec *sg,
>                                          addr[i], &len, is_write ?
>                                          DMA_DIRECTION_FROM_DEVICE :
>                                          DMA_DIRECTION_TO_DEVICE,
> -                                        MEMTXATTRS_UNSPECIFIED);
> +                                        MEMTXATTRS_UNSPECIFIED,
> +                                        &xlat_addr[i]);
>          if (!sg[i].iov_base) {
>              error_report("virtio: error trying to map MMIO memory");
>              exit(1);
> @@ -1643,9 +1645,10 @@ static void virtqueue_map_iovec(VirtIODevice *vdev=
, struct iovec *sg,
>
>  void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
>  {
> -    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, elem->in_num, =
true);
> +    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, elem->in_num,
> +                        elem->in_xlat_addr, true);
>      virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, elem->out_nu=
m,
> -                                                                        =
false);
> +                        elem->out_xlat_addr, false);
>  }
>
>  static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsign=
ed in_num)
> @@ -1654,7 +1657,14 @@ static void *virtqueue_alloc_element(size_t sz, un=
signed out_num, unsigned in_nu
>      size_t in_addr_ofs =3D QEMU_ALIGN_UP(sz, __alignof__(elem->in_addr[0=
]));
>      size_t out_addr_ofs =3D in_addr_ofs + in_num * sizeof(elem->in_addr[=
0]);
>      size_t out_addr_end =3D out_addr_ofs + out_num * sizeof(elem->out_ad=
dr[0]);
> -    size_t in_sg_ofs =3D QEMU_ALIGN_UP(out_addr_end, __alignof__(elem->i=
n_sg[0]));
> +    size_t in_xlat_addr_ofs =3D
> +        QEMU_ALIGN_UP(out_addr_end, __alignof__(elem->in_xlat_addr[0]));
> +    size_t out_xlat_addr_ofs =3D in_xlat_addr_ofs + in_num *
> +                               sizeof(elem->in_xlat_addr[0]);
> +    size_t out_xlat_addr_end =3D out_xlat_addr_ofs + out_num *
> +                               sizeof(elem->out_xlat_addr[0]);
> +    size_t in_sg_ofs =3D
> +        QEMU_ALIGN_UP(out_xlat_addr_end, __alignof__(elem->in_sg[0]));
>      size_t out_sg_ofs =3D in_sg_ofs + in_num * sizeof(elem->in_sg[0]);
>      size_t out_sg_end =3D out_sg_ofs + out_num * sizeof(elem->out_sg[0])=
;
>
> @@ -1665,6 +1675,8 @@ static void *virtqueue_alloc_element(size_t sz, uns=
igned out_num, unsigned in_nu
>      elem->in_num =3D in_num;
>      elem->in_addr =3D (void *)elem + in_addr_ofs;
>      elem->out_addr =3D (void *)elem + out_addr_ofs;
> +    elem->in_xlat_addr =3D (void *)elem + in_xlat_addr_ofs;
> +    elem->out_xlat_addr =3D (void *)elem + out_xlat_addr_ofs;
>      elem->in_sg =3D (void *)elem + in_sg_ofs;
>      elem->out_sg =3D (void *)elem + out_sg_ofs;
>      return elem;
> @@ -1681,6 +1693,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, siz=
e_t sz)
>      VirtQueueElement *elem =3D NULL;
>      unsigned out_num, in_num, elem_entries;
>      hwaddr addr[VIRTQUEUE_MAX_SIZE];
> +    hwaddr xlat_addr[VIRTQUEUE_MAX_SIZE];
>      struct iovec iov[VIRTQUEUE_MAX_SIZE];
>      VRingDesc desc;
>      int rc;
> @@ -1754,7 +1767,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, siz=
e_t sz)
>
>          if (desc.flags & VRING_DESC_F_WRITE) {
>              map_ok =3D virtqueue_map_desc(vdev, &in_num, addr + out_num,
> -                                        iov + out_num,
> +                                        xlat_addr + out_num, iov + out_n=
um,
>                                          VIRTQUEUE_MAX_SIZE - out_num, tr=
ue,
>                                          desc.addr, desc.len);
>          } else {
> @@ -1762,8 +1775,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, siz=
e_t sz)
>                  virtio_error(vdev, "Incorrect order for descriptors");
>                  goto err_undo_map;
>              }
> -            map_ok =3D virtqueue_map_desc(vdev, &out_num, addr, iov,
> -                                        VIRTQUEUE_MAX_SIZE, false,
> +            map_ok =3D virtqueue_map_desc(vdev, &out_num, addr, xlat_add=
r,
> +                                        iov, VIRTQUEUE_MAX_SIZE, false,
>                                          desc.addr, desc.len);
>          }
>          if (!map_ok) {
> @@ -1790,10 +1803,12 @@ static void *virtqueue_split_pop(VirtQueue *vq, s=
ize_t sz)
>      for (i =3D 0; i < out_num; i++) {
>          elem->out_addr[i] =3D addr[i];
>          elem->out_sg[i] =3D iov[i];
> +        elem->out_xlat_addr[i] =3D xlat_addr[i];
>      }
>      for (i =3D 0; i < in_num; i++) {
>          elem->in_addr[i] =3D addr[out_num + i];
>          elem->in_sg[i] =3D iov[out_num + i];
> +        elem->in_xlat_addr[i] =3D xlat_addr[out_num + i];
>      }
>
>      if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> @@ -1827,6 +1842,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, si=
ze_t sz)
>      VirtQueueElement *elem =3D NULL;
>      unsigned out_num, in_num, elem_entries;
>      hwaddr addr[VIRTQUEUE_MAX_SIZE];
> +    hwaddr xlat_addr[VIRTQUEUE_MAX_SIZE];
>      struct iovec iov[VIRTQUEUE_MAX_SIZE];
>      VRingPackedDesc desc;
>      uint16_t id;
> @@ -1891,7 +1907,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, si=
ze_t sz)
>
>          if (desc.flags & VRING_DESC_F_WRITE) {
>              map_ok =3D virtqueue_map_desc(vdev, &in_num, addr + out_num,
> -                                        iov + out_num,
> +                                        xlat_addr + out_num, iov + out_n=
um,
>                                          VIRTQUEUE_MAX_SIZE - out_num, tr=
ue,
>                                          desc.addr, desc.len);
>          } else {
> @@ -1899,7 +1915,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, si=
ze_t sz)
>                  virtio_error(vdev, "Incorrect order for descriptors");
>                  goto err_undo_map;
>              }
> -            map_ok =3D virtqueue_map_desc(vdev, &out_num, addr, iov,
> +            map_ok =3D virtqueue_map_desc(vdev, &out_num, addr, xlat_add=
r, iov,
>                                          VIRTQUEUE_MAX_SIZE, false,
>                                          desc.addr, desc.len);
>          }
> @@ -1928,10 +1944,12 @@ static void *virtqueue_packed_pop(VirtQueue *vq, =
size_t sz)
>      for (i =3D 0; i < out_num; i++) {
>          elem->out_addr[i] =3D addr[i];
>          elem->out_sg[i] =3D iov[i];
> +        elem->out_xlat_addr[i] =3D xlat_addr[i];
>      }
>      for (i =3D 0; i < in_num; i++) {
>          elem->in_addr[i] =3D addr[out_num + i];
>          elem->in_sg[i] =3D iov[out_num + i];
> +        elem->in_xlat_addr[i] =3D xlat_addr[out_num + i];
>      }
>
>      elem->index =3D id;
> @@ -2117,10 +2135,14 @@ void *qemu_get_virtqueue_element(VirtIODevice *vd=
ev, QEMUFile *f, size_t sz)
>      elem->index =3D data.index;
>
>      for (i =3D 0; i < elem->in_num; i++) {
> +        /* xlat_addr is overwritten by virtqueue_map */
> +        elem->in_xlat_addr[i] =3D 0;
>          elem->in_addr[i] =3D data.in_addr[i];
>      }
>
>      for (i =3D 0; i < elem->out_num; i++) {
> +        /* xlat_addr is overwritten by virtqueue_map */
> +        elem->out_xlat_addr[i] =3D 0;
>          elem->out_addr[i] =3D data.out_addr[i];
>      }
>
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 8eaf0d58bb..e2bb453dcc 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -328,7 +328,7 @@ static inline void *pci_dma_map(PCIDevice *dev, dma_a=
ddr_t addr,
>                                  dma_addr_t *plen, DMADirection dir)
>  {
>      return dma_memory_map(pci_get_address_space(dev), addr, plen, dir,
> -                          MEMTXATTRS_UNSPECIFIED);
> +                          MEMTXATTRS_UNSPECIFIED, NULL);
>  }
>
>  static inline void pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_=
t len,
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 6386910280..e822aafd91 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -75,6 +75,8 @@ typedef struct VirtQueueElement
>      hwaddr *out_addr;
>      struct iovec *in_sg;
>      struct iovec *out_sg;
> +    hwaddr *in_xlat_addr;
> +    hwaddr *out_xlat_addr;
>  } VirtQueueElement;
>
>  #define VIRTIO_QUEUE_MAX 1024
> diff --git a/include/system/dma.h b/include/system/dma.h
> index 5a49a30628..b5d4c07452 100644
> --- a/include/system/dma.h
> +++ b/include/system/dma.h
> @@ -12,6 +12,7 @@
>
>  #include "exec/memory.h"
>  #include "exec/address-spaces.h"
> +#include "exec/ramblock.h"
>  #include "block/block.h"
>  #include "block/accounting.h"
>
> @@ -201,10 +202,12 @@ MemTxResult dma_memory_set(AddressSpace *as, dma_ad=
dr_t addr,
>   * @len: pointer to length of buffer; updated on return
>   * @dir: indicates the transfer direction
>   * @attrs: memory attributes
> + * @guest_addr: optional output for GPA
>   */
>  static inline void *dma_memory_map(AddressSpace *as,
>                                     dma_addr_t addr, dma_addr_t *len,
> -                                   DMADirection dir, MemTxAttrs attrs)
> +                                   DMADirection dir, MemTxAttrs attrs,
> +                                   hwaddr *guest_addr)
>  {
>      hwaddr xlen =3D *len;
>      void *p;
> @@ -212,6 +215,26 @@ static inline void *dma_memory_map(AddressSpace *as,
>      p =3D address_space_map(as, addr, &xlen, dir =3D=3D DMA_DIRECTION_FR=
OM_DEVICE,
>                            attrs);
>      *len =3D xlen;
> +
> +    /* Attempt to find a backing GPA for this HVA */
> +    if (guest_addr) {
> +        if (p) {
> +            RAMBlock *rb;
> +            ram_addr_t offset;
> +
> +            rb =3D qemu_ram_block_from_host(p, false, &offset);
> +            if (rb) {
> +                /* HVA corresponds to guest memory */
> +                *guest_addr =3D rb->offset + offset;
> +            } else {
> +                /* HVA doesn't correspond to guest memory */
> +                *guest_addr =3D 0;
> +            }
> +        } else {
> +            /* Mapping failed */
> +            *guest_addr =3D 0;
> +        }
> +    }
>      return p;
>  }
>
> diff --git a/system/dma-helpers.c b/system/dma-helpers.c
> index f6403242f5..a6d2352c0f 100644
> --- a/system/dma-helpers.c
> +++ b/system/dma-helpers.c
> @@ -135,7 +135,7 @@ static void dma_blk_cb(void *opaque, int ret)
>          cur_addr =3D dbs->sg->sg[dbs->sg_cur_index].base + dbs->sg_cur_b=
yte;
>          cur_len =3D dbs->sg->sg[dbs->sg_cur_index].len - dbs->sg_cur_byt=
e;
>          mem =3D dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs->dir=
,
> -                             MEMTXATTRS_UNSPECIFIED);
> +                             MEMTXATTRS_UNSPECIFIED, NULL);
>          /*
>           * Make reads deterministic in icount mode. Windows sometimes is=
sues
>           * disk read requests with overlapping SGs. It leads
> --
> 2.43.5
>


