Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40770C87FC8
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 16:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjiPR-0003bk-3P; Thu, 29 Aug 2024 12:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sjiPP-0003bG-Iu
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 12:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sjiPL-0000xS-Ax
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 12:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724950441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYnJKLGQBf++LEccQ/TvDeZE1jUwiocrnysrb2O/RVc=;
 b=A2V2jRshztl6DEZ+BYYjgSWlxLEbkcsRBWLtFx3HU/hZ2CCa05NJM2yiTGud5FgKZpsjJY
 2b3/4/jSEPL5ZfdGkz6Kd3P95h+2l9wdSNW+OpNCmAuKVHRv7ybZNgF/o3/6qDmBTuv68i
 vbWyTOzZlwQc/TXp04iU+WhiuFibqi8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-jUi6G26RNVOO8iLVNENurA-1; Thu, 29 Aug 2024 12:53:58 -0400
X-MC-Unique: jUi6G26RNVOO8iLVNENurA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6b2249bf2d0so19703497b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 09:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724950438; x=1725555238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYnJKLGQBf++LEccQ/TvDeZE1jUwiocrnysrb2O/RVc=;
 b=WKTJGbD5DAYU+nA3KVmE2bLZBhyQOO3BTm4KYFuMfIXRyO/xtBn2UhI6iwrYGRi2PM
 tmrH9ld2BWSfvdP73aEM+eIONGu8ahhyQjK/ivG2WoSBxzARn9YgbJ/eIEVMcU/4evfR
 KDVkHVsBuvE/y2vl1k35mUhe1tp0a6ZhZzLylhe5+yMIqL0NNJY1c578Z8pyjosMYlt/
 if0iBpDOuJo+uzxyRpoyOVby9K4h+mbCQNvEtGVr2Rg00Qth5Ke4EMp/19kmsadzgz9Q
 A0WiIMY+Qcz87ObX4p8GHiAuWFGfuCLc8jlHNRpoUGJmhGUwgE6go1q24en627irtUxn
 xpKw==
X-Gm-Message-State: AOJu0Yz4L4IaqEZxkkwmOaiWQkNNHSfQtP/on62RomHhr5kg/Z7cL/41
 3x6alW9V8KjXqeWU0EivMfhEcSSrRC8NyebGuewdyWvKTsW+fdZvEYfcP3KpeQZYnCxGu2zSTZV
 VXqBLx/D9tokOUgZetDyVwOpRZjFHaBBgd6W8kDYXQjkDAZDb/a49OCQ3ve9MwHtGhp29QBxTg7
 S7X7GaxfwWscqGK4QeDq5BrRY1NGc=
X-Received: by 2002:a05:690c:2d89:b0:6c3:856a:388d with SMTP id
 00721157ae682-6d276403669mr29651167b3.13.1724950438020; 
 Thu, 29 Aug 2024 09:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUWcybJb6zobKLsuZptYZxjZlJaL/fKFbI4gPnHlJe/WWMCgS0g6XpDTx0R10PmmtfENVEU+O6UGxn1dEPGo0=
X-Received: by 2002:a05:690c:2d89:b0:6c3:856a:388d with SMTP id
 00721157ae682-6d276403669mr29650877b3.13.1724950437560; Thu, 29 Aug 2024
 09:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-2-jonah.palmer@oracle.com>
In-Reply-To: <20240821125548.749143-2-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Aug 2024 18:53:21 +0200
Message-ID: <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
Subject: Re: [RFC 1/2] vhost-vdpa: Decouple the IOVA allocator
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com, 
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 21, 2024 at 2:56=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Decouples the IOVA allocator from the IOVA->HVA tree and instead adds
> the allocated IOVA range to an IOVA-only tree (iova_map). This IOVA tree
> will hold all IOVA ranges that have been allocated (e.g. in the
> IOVA->HVA tree) and are removed when any IOVA ranges are deallocated.
>
> A new API function vhost_iova_tree_insert() is also created to add a
> IOVA->HVA mapping into the IOVA->HVA tree.
>

I think this is a good first iteration but we can take steps to
simplify it. Also, it is great to be able to make points on real code
instead of designs on the air :).

I expected a split of vhost_iova_tree_map_alloc between the current
vhost_iova_tree_map_alloc and vhost_iova_tree_map_alloc_gpa, or
similar. Similarly, a vhost_iova_tree_remove and
vhost_iova_tree_remove_gpa would be needed.

The first one is used for regions that don't exist in the guest, like
SVQ vrings or CVQ buffers. The second one is the one used by the
memory listener to map the guest regions into the vdpa device.

Implementation wise, only two trees are actually needed:
* Current iova_taddr_map that contains all IOVA->vaddr translations as
seen by the device, so both allocation functions can work on a single
tree. The function iova_tree_find_iova keeps using this one, so the
user does not need to know if the address is from the guest or only
exists in QEMU by using RAMBlock etc. All insert and remove functions
use this tree.
* A new tree that relates IOVA to GPA, that only
vhost_iova_tree_map_alloc_gpa and vhost_iova_tree_remove_gpa uses.

The ideal case is that the key in this new tree is the GPA and the
value is the IOVA. But IOVATree's DMA is named the reverse: iova is
the key and translated_addr is the vaddr. We can create a new tree
struct for that, use GTree directly, or translate the reverse
linearly. As memory add / remove should not be frequent, I think the
simpler is the last one, but I'd be ok with creating a new tree.

vhost_iova_tree_map_alloc_gpa needs to add the map to this new tree
also. Similarly, vhost_iova_tree_remove_gpa must look for the GPA in
this tree, and only remove the associated DMAMap in iova_taddr_map
that matches the IOVA.

Does it make sense to you?

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/vhost-iova-tree.c | 38 ++++++++++++++++++++++++++++++++-----
>  hw/virtio/vhost-iova-tree.h |  1 +
>  hw/virtio/vhost-vdpa.c      | 31 ++++++++++++++++++++++++------
>  net/vhost-vdpa.c            | 13 +++++++++++--
>  4 files changed, 70 insertions(+), 13 deletions(-)
>
> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
> index 3d03395a77..32c03db2f5 100644
> --- a/hw/virtio/vhost-iova-tree.c
> +++ b/hw/virtio/vhost-iova-tree.c
> @@ -28,12 +28,17 @@ struct VhostIOVATree {
>
>      /* IOVA address to qemu memory maps. */
>      IOVATree *iova_taddr_map;
> +
> +    /* IOVA tree (IOVA allocator) */
> +    IOVATree *iova_map;
>  };
>
>  /**
> - * Create a new IOVA tree
> + * Create a new VhostIOVATree with a new set of IOVATree's:

s/IOVA tree/VhostIOVATree/ is good, but I think the rest is more an
implementation detail.

> + * - IOVA allocator (iova_map)
> + * - IOVA->HVA tree (iova_taddr_map)
>   *
> - * Returns the new IOVA tree
> + * Returns the new VhostIOVATree
>   */
>  VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>  {
> @@ -44,6 +49,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, h=
waddr iova_last)
>      tree->iova_last =3D iova_last;
>
>      tree->iova_taddr_map =3D iova_tree_new();
> +    tree->iova_map =3D iova_tree_new();
>      return tree;
>  }
>
> @@ -53,6 +59,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, h=
waddr iova_last)
>  void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>  {
>      iova_tree_destroy(iova_tree->iova_taddr_map);
> +    iova_tree_destroy(iova_tree->iova_map);
>      g_free(iova_tree);
>  }
>
> @@ -88,13 +95,12 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DM=
AMap *map)
>      /* Some vhost devices do not like addr 0. Skip first page */
>      hwaddr iova_first =3D tree->iova_first ?: qemu_real_host_page_size()=
;
>
> -    if (map->translated_addr + map->size < map->translated_addr ||

Why remove this condition? If the request is invalid we still need to
return an error here.

Maybe we should move it to iova_tree_alloc_map though.

> -        map->perm =3D=3D IOMMU_NONE) {
> +    if (map->perm =3D=3D IOMMU_NONE) {
>          return IOVA_ERR_INVALID;
>      }
>
>      /* Allocate a node in IOVA address */
> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
>                                 tree->iova_last);
>  }
>
> @@ -107,4 +113,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, D=
MAMap *map)
>  void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>  {
>      iova_tree_remove(iova_tree->iova_taddr_map, map);
> +    iova_tree_remove(iova_tree->iova_map, map);
> +}
> +
> +/**
> + * Insert a new mapping to the IOVA->HVA tree
> + *
> + * @tree: The VhostIOVATree
> + * @map: The iova map
> + *
> + * Returns:
> + * - IOVA_OK if the map fits in the container
> + * - IOVA_ERR_INVALID if the map does not make sense (like size overflow=
)
> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing range
> + */
> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
> +{
> +    if (map->translated_addr + map->size < map->translated_addr ||
> +        map->perm =3D=3D IOMMU_NONE) {
> +        return IOVA_ERR_INVALID;
> +    }
> +
> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
>  }
> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
> index 4adfd79ff0..8bf7b64786 100644
> --- a/hw/virtio/vhost-iova-tree.h
> +++ b/hw/virtio/vhost-iova-tree.h
> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVA=
Tree *iova_tree,
>                                          const DMAMap *map);
>  int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>  void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
>
>  #endif
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3cdaa12ed5..6702459065 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(MemoryLi=
stener *listener,
>      if (s->shadow_data) {
>          int r;
>
> -        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr,
>          mem_region.size =3D int128_get64(llsize) - 1,
>          mem_region.perm =3D IOMMU_ACCESS_FLAG(true, section->readonly),
>
> +        /* Allocate IOVA range and add the mapping to the IOVA tree */
>          r =3D vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
>          if (unlikely(r !=3D IOVA_OK)) {
>              error_report("Can't allocate a mapping (%d)", r);
> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(MemoryLis=
tener *listener,
>          }
>
>          iova =3D mem_region.iova;
> +
> +        /* Add mapping to the IOVA->HVA tree */
> +        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr;
> +        r =3D vhost_iova_tree_insert(s->iova_tree, &mem_region);
> +        if (unlikely(r !=3D IOVA_OK)) {
> +            error_report("Can't add listener region mapping (%d)", r);
> +            goto fail_map;
> +        }

I'd say it is not intuitive for the caller code.

>      }
>
>      vhost_vdpa_iotlb_batch_begin_once(s);
> @@ -1142,19 +1150,30 @@ static void vhost_vdpa_svq_unmap_rings(struct vho=
st_dev *dev,
>   *
>   * @v: Vhost-vdpa device
>   * @needle: The area to search iova
> + * @taddr: The translated address (SVQ HVA)
>   * @errorp: Error pointer
>   */
>  static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle=
,
> -                                    Error **errp)
> +                                    hwaddr taddr, Error **errp)
>  {
>      int r;
>
> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
>      r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
>      if (unlikely(r !=3D IOVA_OK)) {
>          error_setg(errp, "Cannot allocate iova (%d)", r);
>          return false;
>      }
>
> +    /* Add mapping to the IOVA->HVA tree */
> +    needle->translated_addr =3D taddr;
> +    r =3D vhost_iova_tree_insert(v->shared->iova_tree, needle);
> +    if (unlikely(r !=3D IOVA_OK)) {
> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
> +        return false;
> +    }
> +
>      r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iov=
a,
>                             needle->size + 1,
>                             (void *)(uintptr_t)needle->translated_addr,
> @@ -1192,11 +1211,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost=
_dev *dev,
>      vhost_svq_get_vring_addr(svq, &svq_addr);
>
>      driver_region =3D (DMAMap) {
> -        .translated_addr =3D svq_addr.desc_user_addr,
>          .size =3D driver_size - 1,
>          .perm =3D IOMMU_RO,
>      };
> -    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, errp);
> +    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user=
_addr,
> +                                 errp);
>      if (unlikely(!ok)) {
>          error_prepend(errp, "Cannot create vq driver region: ");
>          return false;
> @@ -1206,11 +1225,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost=
_dev *dev,
>      addr->avail_user_addr =3D driver_region.iova + avail_offset;
>
>      device_region =3D (DMAMap) {
> -        .translated_addr =3D svq_addr.used_user_addr,
>          .size =3D device_size - 1,
>          .perm =3D IOMMU_RW,
>      };
> -    ok =3D vhost_vdpa_svq_map_ring(v, &device_region, errp);
> +    ok =3D vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user=
_addr,
> +                                 errp);
>      if (unlikely(!ok)) {
>          error_prepend(errp, "Cannot create vq device region: ");
>          vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 03457ead66..81da956b92 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -512,15 +512,24 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa=
 *v, void *buf, size_t size,
>      DMAMap map =3D {};
>      int r;
>
> -    map.translated_addr =3D (hwaddr)(uintptr_t)buf;
>      map.size =3D size - 1;
>      map.perm =3D write ? IOMMU_RW : IOMMU_RO,
> +
> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
>      r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
>      if (unlikely(r !=3D IOVA_OK)) {
> -        error_report("Cannot map injected element");
> +        error_report("Cannot allocate IOVA range for injected element");
>          return r;
>      }
>
> +    /* Add mapping to the IOVA->HVA tree */
> +    map.translated_addr =3D (hwaddr)(uintptr_t)buf;
> +    r =3D vhost_iova_tree_insert(v->shared->iova_tree, &map);
> +    if (unlikely(r !=3D IOVA_OK)) {
> +        error_report("Cannot map injected element into IOVA->HVA tree");
> +        goto dma_map_err;
> +    }
> +
>      r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
>                             vhost_vdpa_net_cvq_cmd_page_len(), buf, !writ=
e);
>      if (unlikely(r < 0)) {
> --
> 2.43.5
>


