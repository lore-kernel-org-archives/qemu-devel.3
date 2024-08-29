Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5EAC87FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 16:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjiQx-0007oL-Ax; Thu, 29 Aug 2024 12:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sjiQw-0007nr-Io
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 12:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sjiQu-0001EY-6H
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 12:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724950539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DmlDpGuSYwX1ocboMHA4qGu7LZN+b2qTAXEtwtVhlOg=;
 b=WQx4hWEXmuBeTIiPOm4FPrM8HZgaCpbDlz+Wkt8boOno8zKyqBSnnE5aR77Z7Cq64Gq+bd
 Se7/5qJhRxqr1iF5dolWQEbSDMsfoG5qemyvfz22eEPjmmG25nBMJyxzZOvzRnNpjLJUwL
 69F26JhxeQhRS5eddFPb9IJI9mulR1o=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-l8n07DFJN8qhAp5mJSv4ZQ-1; Thu, 29 Aug 2024 12:55:37 -0400
X-MC-Unique: l8n07DFJN8qhAp5mJSv4ZQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6c2599195c5so12987847b3.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 09:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724950537; x=1725555337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmlDpGuSYwX1ocboMHA4qGu7LZN+b2qTAXEtwtVhlOg=;
 b=eo7vIyNCnDcpXGdVkXZjWVMgOUWDgaVsVJcf1ZXfMMx0VJok8yRdcJKz3tfaNyrh4J
 wWoFOmwDUO7OHC4ThfvkS2VjYOJM83tTzgYzWiwt3cyaFePEKUgaYe3woSIIN8r0weuP
 a7v7GfSfu7loS3U1HUIqRQ3b2KMmqXksgd9qp0HfvFYTGdBFIH9mfOiu3CSfmN0mZ1xc
 29v0JGxAoQefZ2M2mKQ6ax3LQGmA+X6e8L786E91uwVieiP3lQqyFq4npwPGYMhc1cz9
 zmcULSi3jOVTL7si9T1od0ux32PWg0wgvi6LMga+UHY/KF8Tn5b8sRa29QKVRlDqCmA6
 CqKw==
X-Gm-Message-State: AOJu0YzOoHYYvLVmURHFZtUFoIRG+yIfInEjMiPH69krO9jHKY4DFV7n
 3WTPZhEqnIezF2QNyjprPTewpd/H3mYWWGkLkh9MkwCRhuQoU/uER16N1wZjXtMlSn2rnVSeZ73
 CzJ5AmTBFwbEMN/6azGMhR0WcWkIOgyn9h4/vucYy35VUlsoJ7liB6AMlOY8kOKYfydb0Bci2Fp
 NwpWMGwa2Je/FKLMnjJD1I0292Lm0=
X-Received: by 2002:a05:690c:ed5:b0:632:5b24:c0c with SMTP id
 00721157ae682-6d275868366mr39452817b3.5.1724950537299; 
 Thu, 29 Aug 2024 09:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRzbDoXMn1uC4/hbpaMpMVNTNbtCf5GgHVoz034hO0wMdTB3krWc3vrzl+x671uZjzZ5oHYfetHaXZdeCWz80=
X-Received: by 2002:a05:690c:ed5:b0:632:5b24:c0c with SMTP id
 00721157ae682-6d275868366mr39452567b3.5.1724950536880; Thu, 29 Aug 2024
 09:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-3-jonah.palmer@oracle.com>
In-Reply-To: <20240821125548.749143-3-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Aug 2024 18:55:01 +0200
Message-ID: <CAJaqyWcZbr=xVN4jdxiy09AgX6Me6vSsxSneqQJJ6LSk+4A4rA@mail.gmail.com>
Subject: Re: [RFC 2/2] vhost-vdpa: Implement GPA->IOVA & IOVA->SVQ HVA trees
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
> Implements a GPA->IOVA and IOVA->SVQ HVA tree for handling mapping,
> unmapping, and translations for guest and host-only memory,
> respectively.
>
> By splitting up a full IOVA->HVA tree (containing both guest and
> host-only memory mappings) into a GPA->IOVA tree (containing only guest
> memory mappings) and a IOVA->SVQ HVA tree (containing host-only memory
> mappings), we can avoid translating to the wrong IOVA when the guest has
> overlapping memory regions where different GPAs lead to the same HVA.
>
> In other words, if the guest has overlapping memory regions, translating
> an HVA to an IOVA may result in receiving an incorrect IOVA when
> searching the full IOVA->HVA tree. This would be due to one HVA range
> being contained (overlapping) in another HVA range in the IOVA->HVA
> tree.
>
> To avoid this issue, creating a GPA->IOVA tree and using it to translate
> a GPA to an IOVA ensures that the IOVA we receive is the correct one
> (instead of relying on a HVA->IOVA translation).
>
> As a byproduct of creating a GPA->IOVA tree, the full IOVA->HVA tree now
> becomes a partial IOVA->SVQ HVA tree. That is, since we're moving all
> guest memory mappings to the GPA->IOVA tree, the host-only memory
> mappings are now the only mappings being put into the IOVA->HVA tree.
>
> Furthermore, as an additional byproduct of splitting up guest and
> host-only memory mappings into separate trees, special attention needs
> to be paid to vhost_svq_translate_addr() when translating memory buffers
> from iovec. The memory buffers from iovec can be backed by guest memory
> or host-only memory, which means that we need to figure out who is
> backing these buffers and then decide which tree to use for translating
> it.
>
> In this patch we determine the backer of this buffer by first checking
> if a RAM block can be inferred from the buffer's HVA. That is, we use
> qemu_ram_block_from_host() and if a valid RAM block is returned, we know
> the buffer's HVA is backed by guest memory. Then we derive the GPA from
> it and translate the GPA to an IOVA using the GPA->IOVA tree.
>
> If an invalid RAM block is returned, the buffer's HVA is likely backed
> by host-only memory. In this case, we can then simply translate the HVA
> to an IOVA using the partial IOVA->SVQ HVA tree.
>
> However, this method is sub-optimal, especially for memory buffers
> backed by host-only memory, due to needing to iterate over some (if not
> all) RAMBlock structures and then searching either the GPA->IOVA tree or
> the IOVA->SVQ HVA tree. Optimizations to improve performance in this
> area should be revisited at some point.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/vhost-iova-tree.c        | 53 +++++++++++++++++++++++++++++-
>  hw/virtio/vhost-iova-tree.h        |  5 ++-
>  hw/virtio/vhost-shadow-virtqueue.c | 48 +++++++++++++++++++++++----
>  hw/virtio/vhost-vdpa.c             | 18 +++++-----
>  include/qemu/iova-tree.h           | 22 +++++++++++++
>  util/iova-tree.c                   | 46 ++++++++++++++++++++++++++
>  6 files changed, 173 insertions(+), 19 deletions(-)
>
> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
> index 32c03db2f5..5a3f6b5cd9 100644
> --- a/hw/virtio/vhost-iova-tree.c
> +++ b/hw/virtio/vhost-iova-tree.c
> @@ -26,15 +26,19 @@ struct VhostIOVATree {
>      /* Last addressable iova address in the device */
>      uint64_t iova_last;
>
> -    /* IOVA address to qemu memory maps. */
> +    /* IOVA address to qemu SVQ memory maps. */
>      IOVATree *iova_taddr_map;
>
>      /* IOVA tree (IOVA allocator) */
>      IOVATree *iova_map;
> +
> +    /* GPA->IOVA tree */
> +    IOVATree *gpa_map;
>  };
>
>  /**
>   * Create a new VhostIOVATree with a new set of IOVATree's:
> + * - GPA->IOVA tree (gpa_map)
>   * - IOVA allocator (iova_map)
>   * - IOVA->HVA tree (iova_taddr_map)
>   *
> @@ -50,6 +54,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, h=
waddr iova_last)
>
>      tree->iova_taddr_map =3D iova_tree_new();
>      tree->iova_map =3D iova_tree_new();
> +    tree->gpa_map =3D gpa_tree_new();
>      return tree;
>  }
>
> @@ -136,3 +141,49 @@ int vhost_iova_tree_insert(VhostIOVATree *iova_tree,=
 DMAMap *map)
>
>      return iova_tree_insert(iova_tree->iova_taddr_map, map);
>  }
> +
> +/**
> + * Insert a new GPA->IOVA mapping to the GPA->IOVA tree
> + *
> + * @iova_tree: The VhostIOVATree
> + * @map: The GPA->IOVA mapping
> + *
> + * Returns:
> + * - IOVA_OK if the map fits in the container
> + * - IOVA_ERR_INVALID if the map does not make sense (like size overflow=
)
> + * - IOVA_ERR_OVERLAP if the GPA range overlaps with an existing range
> + */
> +int vhost_gpa_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
> +{
> +    if (map->iova + map->size < map->iova || map->perm =3D=3D IOMMU_NONE=
) {
> +        return IOVA_ERR_INVALID;
> +    }
> +
> +    return gpa_tree_insert(iova_tree->gpa_map, map);
> +}
> +
> +/**
> + * Find the IOVA address stored from a guest memory address (GPA)
> + *
> + * @tree: The VhostIOVATree
> + * @map: The map with the guest memory address
> + *
> + * Return the stored mapping, or NULL if not found.
> + */
> +const DMAMap *vhost_gpa_tree_find_iova(const VhostIOVATree *tree,
> +                                       const DMAMap *map)
> +{
> +    return iova_tree_find_iova(tree->gpa_map, map);
> +}
> +
> +/**
> + * Remove existing mappings from the GPA->IOVA tree and IOVA tree
> + *
> + * @iova_tree: The VhostIOVATree
> + * @map: The map to remove
> + */
> +void vhost_gpa_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
> +{
> +    iova_tree_remove(iova_tree->gpa_map, map);
> +    iova_tree_remove(iova_tree->iova_map, map);
> +}
> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
> index 8bf7b64786..c22941db4f 100644
> --- a/hw/virtio/vhost-iova-tree.h
> +++ b/hw/virtio/vhost-iova-tree.h
> @@ -24,5 +24,8 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVA=
Tree *iova_tree,
>  int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>  void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>  int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
> -
> +int vhost_gpa_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
> +const DMAMap *vhost_gpa_tree_find_iova(const VhostIOVATree *iova_tree,
> +                                       const DMAMap *map);
> +void vhost_gpa_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>  #endif
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index fc5f408f77..12eabddaa6 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -16,6 +16,7 @@
>  #include "qemu/log.h"
>  #include "qemu/memalign.h"
>  #include "linux-headers/linux/vhost.h"
> +#include "exec/ramblock.h"
>
>  /**
>   * Validate the transport device features that both guests can use with =
the SVQ
> @@ -88,14 +89,45 @@ static bool vhost_svq_translate_addr(const VhostShado=
wVirtqueue *svq,
>      }
>
>      for (size_t i =3D 0; i < num; ++i) {
> -        DMAMap needle =3D {
> -            .translated_addr =3D (hwaddr)(uintptr_t)iovec[i].iov_base,
> -            .size =3D iovec[i].iov_len,
> -        };
> -        Int128 needle_last, map_last;
> -        size_t off;
> +        RAMBlock *rb;
> +        hwaddr gpa;
> +        ram_addr_t offset;
> +        const DMAMap *map;
> +        DMAMap needle;
> +
> +        /*
> +         * Determine if this HVA is backed by guest memory by attempting=
 to
> +         * infer a RAM block from it. If a valid RAM block is returned, =
the
> +         * VA is backed by guest memory and we can derive the GPA from i=
t.
> +         * Then search the GPA->IOVA tree for the corresponding IOVA.
> +         *
> +         * If the RAM block is invalid, the HVA is likely backed by host=
-only
> +         * memory. Use the HVA to search the IOVA->HVA tree for the
> +         * corresponding IOVA.
> +         *
> +         * TODO: This additional second lookup is sub-optimal when the H=
VA
> +         *       is backed by host-only memory. Find optimizations for t=
his
> +         *       (e.g. using an HVA->IOVA tree).
> +         */
> +        rb =3D qemu_ram_block_from_host(iovec[i].iov_base, false, &offse=
t);
> +        if (rb) {
> +            gpa =3D rb->offset + offset;
> +
> +            /* Search the GPA->IOVA tree */
> +            needle =3D (DMAMap) {
> +                .translated_addr =3D gpa,
> +                .size =3D iovec[i].iov_len,
> +            };
> +            map =3D vhost_gpa_tree_find_iova(svq->iova_tree, &needle);
> +        } else {
> +            /* Search the IOVA->HVA tree */
> +            needle =3D (DMAMap) {
> +                .translated_addr =3D (hwaddr)(uintptr_t)iovec[i].iov_bas=
e,
> +                .size =3D iovec[i].iov_len,
> +            };
> +            map =3D vhost_iova_tree_find_iova(svq->iova_tree, &needle);
> +        }

I think that having this complex conditional here is a problem for
future users of SVQ.

>
> -        const DMAMap *map =3D vhost_iova_tree_find_iova(svq->iova_tree, =
&needle);
>          /*
>           * Map cannot be NULL since iova map contains all guest space an=
d
>           * qemu already has a physical address mapped
> @@ -106,6 +138,8 @@ static bool vhost_svq_translate_addr(const VhostShado=
wVirtqueue *svq,
>                            needle.translated_addr);
>              return false;
>          }
> +        Int128 needle_last, map_last;
> +        size_t off;
>
>          off =3D needle.translated_addr - map->translated_addr;
>          addrs[i] =3D map->iova + off;
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 6702459065..0da0a117dc 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -373,9 +373,9 @@ static void vhost_vdpa_listener_region_add(MemoryList=
ener *listener,
>
>          iova =3D mem_region.iova;
>
> -        /* Add mapping to the IOVA->HVA tree */
> -        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr;
> -        r =3D vhost_iova_tree_insert(s->iova_tree, &mem_region);
> +        /* Add mapping to the GPA->IOVA tree */
> +        mem_region.translated_addr =3D section->offset_within_address_sp=
ace;
> +        r =3D vhost_gpa_tree_insert(s->iova_tree, &mem_region);
>          if (unlikely(r !=3D IOVA_OK)) {
>              error_report("Can't add listener region mapping (%d)", r);
>              goto fail_map;
> @@ -394,7 +394,7 @@ static void vhost_vdpa_listener_region_add(MemoryList=
ener *listener,
>
>  fail_map:
>      if (s->shadow_data) {
> -        vhost_iova_tree_remove(s->iova_tree, mem_region);
> +        vhost_gpa_tree_remove(s->iova_tree, mem_region);
>      }
>
>  fail:
> @@ -448,21 +448,19 @@ static void vhost_vdpa_listener_region_del(MemoryLi=
stener *listener,
>
>      if (s->shadow_data) {
>          const DMAMap *result;
> -        const void *vaddr =3D memory_region_get_ram_ptr(section->mr) +
> -            section->offset_within_region +
> -            (iova - section->offset_within_address_space);
>          DMAMap mem_region =3D {
> -            .translated_addr =3D (hwaddr)(uintptr_t)vaddr,
> +            .translated_addr =3D section->offset_within_address_space,
>              .size =3D int128_get64(llsize) - 1,
>          };
>
> -        result =3D vhost_iova_tree_find_iova(s->iova_tree, &mem_region);
> +        /* Search the GPA->IOVA tree */
> +        result =3D vhost_gpa_tree_find_iova(s->iova_tree, &mem_region);
>          if (!result) {
>              /* The memory listener map wasn't mapped */
>              return;
>          }
>          iova =3D result->iova;
> -        vhost_iova_tree_remove(s->iova_tree, *result);
> +        vhost_gpa_tree_remove(s->iova_tree, *result);
>      }
>      vhost_vdpa_iotlb_batch_begin_once(s);
>      /*
> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
> index 2a10a7052e..57cfc63d33 100644
> --- a/include/qemu/iova-tree.h
> +++ b/include/qemu/iova-tree.h
> @@ -40,6 +40,15 @@ typedef struct DMAMap {
>  } QEMU_PACKED DMAMap;
>  typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>
> +/**
> + * gpa_tree_new:
> + *
> + * Create a new GPA->IOVA tree.
> + *
> + * Returns: the tree pointer on success, or NULL otherwise.
> + */
> +IOVATree *gpa_tree_new(void);
> +
>  /**
>   * iova_tree_new:
>   *
> @@ -49,6 +58,19 @@ typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>   */
>  IOVATree *iova_tree_new(void);
>
> +/**
> + * gpa_tree_insert:
> + *
> + * @tree: The GPA->IOVA tree we're inserting the mapping to
> + * @map: The GPA->IOVA mapping to insert
> + *
> + * Insert a GPA range to the GPA->IOVA tree. If there are overlapped
> + * ranges, IOVA_ERR_OVERLAP will be returned.
> + *
> + * Return: 0 if success, or < 0 if error.
> + */
> +int gpa_tree_insert(IOVATree *tree, const DMAMap *map);
> +

I'd keep this GPA tree in VhostIOVATree as other IOVATree users like
intel iommu do not use it.

>  /**
>   * iova_tree_insert:
>   *
> diff --git a/util/iova-tree.c b/util/iova-tree.c
> index 536789797e..e3f50fbf5c 100644
> --- a/util/iova-tree.c
> +++ b/util/iova-tree.c
> @@ -71,6 +71,22 @@ static int iova_tree_compare(gconstpointer a, gconstpo=
inter b, gpointer data)
>      return 0;
>  }
>
> +static int gpa_tree_compare(gconstpointer a, gconstpointer b, gpointer d=
ata)
> +{
> +    const DMAMap *m1 =3D a, *m2 =3D b;
> +
> +    if (m1->translated_addr > m2->translated_addr + m2->size) {
> +        return 1;
> +    }
> +
> +    if (m1->translated_addr + m1->size < m2->translated_addr) {
> +        return -1;
> +    }
> +
> +    /* Overlapped */
> +    return 0;
> +}
> +
>  IOVATree *iova_tree_new(void)
>  {
>      IOVATree *iova_tree =3D g_new0(IOVATree, 1);
> @@ -81,6 +97,15 @@ IOVATree *iova_tree_new(void)
>      return iova_tree;
>  }
>
> +IOVATree *gpa_tree_new(void)
> +{
> +    IOVATree *gpa_tree =3D g_new0(IOVATree, 1);
> +
> +    gpa_tree->tree =3D g_tree_new_full(gpa_tree_compare, NULL, g_free, N=
ULL);
> +
> +    return gpa_tree;
> +}
> +
>  const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map)
>  {
>      return g_tree_lookup(tree->tree, map);
> @@ -128,6 +153,27 @@ static inline void iova_tree_insert_internal(GTree *=
gtree, DMAMap *range)
>      g_tree_insert(gtree, range, range);
>  }
>
> +int gpa_tree_insert(IOVATree *tree, const DMAMap *map)
> +{
> +    DMAMap *new;
> +
> +    if (map->translated_addr + map->size < map->translated_addr ||
> +        map->perm =3D=3D IOMMU_NONE) {
> +        return IOVA_ERR_INVALID;
> +    }
> +
> +    /* We don't allow inserting ranges that overlap with existing ones *=
/
> +    if (iova_tree_find(tree, map)) {
> +        return IOVA_ERR_OVERLAP;
> +    }
> +
> +    new =3D g_new0(DMAMap, 1);
> +    memcpy(new, map, sizeof(*new));
> +    iova_tree_insert_internal(tree->tree, new);
> +
> +    return IOVA_OK;
> +}
> +
>  int iova_tree_insert(IOVATree *tree, const DMAMap *map)
>  {
>      DMAMap *new;
> --
> 2.43.5
>


