Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B296CCF8843
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 15:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swk43-0000Fl-4d; Fri, 04 Oct 2024 11:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1swk40-0000FS-NU
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1swk3y-0003GW-HU
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728055068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEbUkZqV6RXWHoSoDzE3uf3kaPDwcW88YqcziTH49RY=;
 b=gOSjLVfo6nzQnMzhT1vJg9p1OImJXSBiusN4Igdo5gSS1T3vnIqidn0YIZt//+OzFThEOj
 r0QLDM/q8+gUJl1xe1OcBw5VJQJeMoIQC/utf5ZCo6TWwq+UT7hVDDOiMz1qfm78uc/TtR
 YJUcGaabGh8LOA92b2rpt11tx5C2KFI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-AOpk_l16Myujf7G8ZAa75A-1; Fri, 04 Oct 2024 11:17:47 -0400
X-MC-Unique: AOpk_l16Myujf7G8ZAa75A-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6db791c42e3so32597997b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 08:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728055066; x=1728659866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEbUkZqV6RXWHoSoDzE3uf3kaPDwcW88YqcziTH49RY=;
 b=bwwW3WBRPRbtqRM9ESfdeoG8hHUeHOdDA08747ineb5KrMCb3KR3o/+fOahIabhPkO
 HWhC3NmFxCYNDMCWae/5WuI4wt+wQ4Ts9pFoyWA7gOKei9NoiavnWbP5HcXPvv0EKoCI
 RLCuDhNjYuJ1ZQy79nCzCCvtNpKtdG7+WRqnxaeRGMub7O3s9ItpVKK81ORTzBYhoi2a
 sYztug+j3fzKW9y6PZf14AZuxku58zJ1lPPjCUag8+6LRvMlwR0zZSG6aHDCYS/+glAe
 gV6ye9OzgoYjAaf5R9v8RWLu8KUpdwiHpB2nmdFMmv7gFPBc3yzqCR8hsXnJNWEFSHG0
 ld2Q==
X-Gm-Message-State: AOJu0YxVx8ukw1uEJvXZ46VipHcn7/NT8QY6lmslgzQ7MyrvDUYvalVv
 IGsR4Q5mBWycPoTWwyhNWrMGsO0SBe0Np6OtRHAzvmL4IoFr8IPxZ6ty1YcwfIC2gnwMqcaS+fm
 jODSUEOqfpC/3mCfZwySqPnVJhXJYCEJfob7Z3AvdHUOlyXjFf2guN0FA9SNdv/CAzqxIQuEa0U
 ti+ZUlN8/WZaOxV6s0smYlxtMP8Fo=
X-Received: by 2002:a05:690c:6610:b0:69d:e911:88c3 with SMTP id
 00721157ae682-6e2c728a2acmr24810317b3.29.1728055066290; 
 Fri, 04 Oct 2024 08:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlmm3b3ALzY+ELCPuDMJ3tQj3UE4h58q2YdT6P4SwddNmDACO0sVJP0PjfnuUquX+oyRzzDcxw1xUZfWdZ5lE=
X-Received: by 2002:a05:690c:6610:b0:69d:e911:88c3 with SMTP id
 00721157ae682-6e2c728a2acmr24810087b3.29.1728055065951; Fri, 04 Oct 2024
 08:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
 <20241004124445.3802090-2-jonah.palmer@oracle.com>
In-Reply-To: <20241004124445.3802090-2-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 4 Oct 2024 17:17:09 +0200
Message-ID: <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vhost-vdpa: Implement IOVA->GPA tree
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com, 
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 4, 2024 at 2:45=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Implements the IOVA->GPA tree for handling mapping, unmapping, and
> translations for guest memory regions.
>
> When the guest has overlapping memory regions, an HVA to IOVA translation
> may return an incorrect IOVA when searching the IOVA->HVA tree. This is
> due to one HVA range being contained (overlapping) in another HVA range
> in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can use GPAs to
> translate and find the correct IOVA for guest memory regions.
>

Yes, this first patch is super close to what I meant, just one issue
and a pair of nits here and there.

I'd leave the second patch as an optimization on top, if the numbers
prove that adding the code is worth it.

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/vhost-iova-tree.c | 78 +++++++++++++++++++++++++++++++++++--
>  hw/virtio/vhost-iova-tree.h |  5 +++
>  hw/virtio/vhost-vdpa.c      | 20 ++++++----
>  3 files changed, 92 insertions(+), 11 deletions(-)
>
> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
> index 3d03395a77..e33fd56225 100644
> --- a/hw/virtio/vhost-iova-tree.c
> +++ b/hw/virtio/vhost-iova-tree.c
> @@ -28,12 +28,15 @@ struct VhostIOVATree {
>
>      /* IOVA address to qemu memory maps. */
>      IOVATree *iova_taddr_map;
> +
> +    /* IOVA address to guest memory maps. */
> +    IOVATree *iova_gpa_map;
>  };
>
>  /**
> - * Create a new IOVA tree
> + * Create a new VhostIOVATree
>   *
> - * Returns the new IOVA tree
> + * Returns the new VhostIOVATree
>   */
>  VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>  {
> @@ -44,6 +47,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, h=
waddr iova_last)
>      tree->iova_last =3D iova_last;
>
>      tree->iova_taddr_map =3D iova_tree_new();
> +    tree->iova_gpa_map =3D iova_tree_new();
>      return tree;
>  }
>
> @@ -53,6 +57,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, h=
waddr iova_last)
>  void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>  {
>      iova_tree_destroy(iova_tree->iova_taddr_map);
> +    iova_tree_destroy(iova_tree->iova_gpa_map);
>      g_free(iova_tree);
>  }
>
> @@ -71,7 +76,7 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVA=
Tree *tree,
>  }
>
>  /**
> - * Allocate a new mapping
> + * Allocate a new mapping in the IOVA->HVA tree
>   *
>   * @tree: The iova tree
>   * @map: The iova map
> @@ -108,3 +113,70 @@ void vhost_iova_tree_remove(VhostIOVATree *iova_tree=
, DMAMap map)
>  {
>      iova_tree_remove(iova_tree->iova_taddr_map, map);
>  }
> +
> +/**
> + * Find the IOVA address stored from a guest memory address
> + *
> + * @tree: The VhostIOVATree
> + * @map: The map with the guest memory address
> + *
> + * Return the stored mapping, or NULL if not found.
> + */
> +const DMAMap *vhost_iova_gpa_tree_find_iova(const VhostIOVATree *tree,
> +                                            const DMAMap *map)

Nit: Not an english native, but I find vhost_iova_tree should not be
broken for coherency with the rest of the functions. What about
vhost_iova_tree_find_iova_gpa, like _gpa variant?

> +{
> +    return iova_tree_find_iova(tree->iova_gpa_map, map);
> +}
> +
> +/**
> + * Allocate new mappings in the IOVA->HVA & IOVA->GPA trees
> + *
> + * @tree: The VhostIOVATree
> + * @map: The iova map
> + * @gpa: The guest physical address (GPA)
> + *
> + * Returns:
> + * - IOVA_OK if the map fits both containers
> + * - IOVA_ERR_INVALID if the map does not make sense (like size overflow=
)
> + * - IOVA_ERR_NOMEM if the IOVA->HVA tree cannot allocate more space
> + *
> + * It returns an assigned iova in map->iova if return value is IOVA_OK.
> + */
> +int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *tree, DMAMap *map, hwad=
dr gpa)
> +{
> +    int ret;
> +
> +    /* Some vhost devices don't like addr 0. Skip first page */
> +    hwaddr iova_first =3D tree->iova_first ?: qemu_real_host_page_size()=
;
> +
> +    if (map->translated_addr + map->size < map->translated_addr ||
> +        map->perm =3D=3D IOMMU_NONE) {
> +        return IOVA_ERR_INVALID;
> +    }
> +
> +    /* Allocate a node in the IOVA->HVA tree */
> +    ret =3D iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
> +                              tree->iova_last);

Why not call vhost_iova_tree_map_alloc instead of duplicating it here?

> +    if (unlikely(ret !=3D IOVA_OK)) {
> +        return ret;
> +    }
> +
> +    /* Insert a node in the IOVA->GPA tree */
> +    map->translated_addr =3D gpa;
> +    return iova_tree_insert(tree->iova_gpa_map, map);
> +}
> +
> +/**
> + * Remove existing mappings from the IOVA->HVA & IOVA->GPA trees
> + *
> + * @iova_tree: The VhostIOVATree
> + * @map: The map to remove
> + */
> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
> +{
> +    /* Remove the existing mapping from the IOVA->GPA tree */
> +    iova_tree_remove(iova_tree->iova_gpa_map, map);
> +
> +    /* Remove the corresponding mapping from the IOVA->HVA tree */
> +    iova_tree_remove(iova_tree->iova_taddr_map, map);

If we remove it blindly from both trees, we are keeping the bug, isn't it?

I think the remove should receive the "gpa" as a parameter, same as
alloc_gpa. After that, vhost_iova_tree_remove_gpa looks the right iova
into iova_gpa_map. And only after that, it removes that iova from
iova_tree_remove.

If it makes things easier it could receive (hwaddr gpa, size_t len) or
all of the info in a DMAMap. What do you think?

> +}
> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
> index 4adfd79ff0..511c6d18ae 100644
> --- a/hw/virtio/vhost-iova-tree.h
> +++ b/hw/virtio/vhost-iova-tree.h
> @@ -23,5 +23,10 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOV=
ATree *iova_tree,
>                                          const DMAMap *map);
>  int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>  void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
> +const DMAMap *vhost_iova_gpa_tree_find_iova(const VhostIOVATree *iova_tr=
ee,
> +                                            const DMAMap *map);
> +int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *iova_tree, DMAMap *map,
> +                                  hwaddr gpa);
> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map);
>
>  #endif
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3cdaa12ed5..591ff426e7 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -365,9 +365,16 @@ static void vhost_vdpa_listener_region_add(MemoryLis=
tener *listener,
>          mem_region.size =3D int128_get64(llsize) - 1,
>          mem_region.perm =3D IOMMU_ACCESS_FLAG(true, section->readonly),
>
> -        r =3D vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
> +        r =3D vhost_iova_tree_map_alloc_gpa(s->iova_tree, &mem_region,
> +                                          section->offset_within_address=
_space);
>          if (unlikely(r !=3D IOVA_OK)) {
>              error_report("Can't allocate a mapping (%d)", r);
> +
> +            /* Insertion to IOVA->GPA tree failed */
> +            if (mem_region.translated_addr =3D=3D
> +                section->offset_within_address_space) {
> +                goto fail_map;
> +            }

We can move this cleanup code into vhost_iova_tree_map_alloc_gpa, isn't it?

>              goto fail;
>          }
>
> @@ -386,7 +393,7 @@ static void vhost_vdpa_listener_region_add(MemoryList=
ener *listener,
>
>  fail_map:
>      if (s->shadow_data) {
> -        vhost_iova_tree_remove(s->iova_tree, mem_region);
> +        vhost_iova_tree_remove_gpa(s->iova_tree, mem_region);
>      }
>
>  fail:
> @@ -440,21 +447,18 @@ static void vhost_vdpa_listener_region_del(MemoryLi=
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
> +        result =3D vhost_iova_gpa_tree_find_iova(s->iova_tree, &mem_regi=
on);
>          if (!result) {
>              /* The memory listener map wasn't mapped */
>              return;
>          }
>          iova =3D result->iova;
> -        vhost_iova_tree_remove(s->iova_tree, *result);
> +        vhost_iova_tree_remove_gpa(s->iova_tree, *result);
>      }
>      vhost_vdpa_iotlb_batch_begin_once(s);
>      /*
> --
> 2.43.5
>


