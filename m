Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FFCCFB441
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 13:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxo9U-0001Z8-6x; Mon, 07 Oct 2024 09:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sxo9S-0001Yj-BL
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 09:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sxo9Q-0005nm-2k
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 09:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728309109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kV041unBomirbdFJw4dF7UCP2iwuStjOOfALlJ80Ko=;
 b=OcaQ/bhY6ODDlA4PZ6iG3IvrgddyO6ylpzfVyR7bXFy4ul9NT5rENXYdi6KyLW3HX71lF9
 /lvlr3JicqCE/tlNBThsFZK8UO8PMs8B4H7byUT6P0g0EeJJntAfh4So0e9UnCj9x5+xz8
 cGeyvBznmDCTdo9lr0AZw6fJnwJC69Q=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-jN22BEodPCeDl_MpfBtgBQ-1; Mon, 07 Oct 2024 09:51:48 -0400
X-MC-Unique: jN22BEodPCeDl_MpfBtgBQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6e2590f5bc1so12969697b3.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 06:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728309108; x=1728913908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kV041unBomirbdFJw4dF7UCP2iwuStjOOfALlJ80Ko=;
 b=XVVmSJZhYkea5YCSuBO/XeR2CTVvsK60j3PXmi9xBsiN2oqE8rTEcyalI3cMal5bvq
 qpJfly4IwyuJsQ2nRRFr1/A5wJBx/trxdxtkrEjiMdMS7D7CtHCP/Y9Wo2MMAilK4tSR
 fqJ4j9M6fYN8/SYwAUfT5h0+bYDN+Mcq8b+QLMbqcaRxnGm/DKi1o4XOCxwYtVcH0cG3
 wmd8Qv5/nySKJ72dqJ8naCtmidFHBzqD4UVcOPAv706/hqqU+uKM3MIFuRADcq1VMfco
 BOw0VQwSjbUADc1+kegbkCIQLeMNZfwQWKoCPp0S/megF8m6WxFa+HKdYkCWXGpbXDaD
 zykw==
X-Gm-Message-State: AOJu0YywYTo489ghKYUbP+PQqmswmadH8XEdRVuqb2PLp1poT2Pa24hZ
 5OrVG+yqCsLX+bpdNvGiQii72niWafRojiYltO8FGvtC/wWiqGOyBejBVKVCHvyrZC1DdfAVZCu
 fzCa9KsL4PRRknflUcOx2pRPllMSzcplnnn9h/rnWlb8fGfigNcMAOMlDJzGPergHuPhkK72Ja9
 MhZjZIuQ14tVlfHPUNn5EpEZBqevo=
X-Received: by 2002:a05:690c:388:b0:6e2:71b:150 with SMTP id
 00721157ae682-6e2c72968admr103551007b3.29.1728309108182; 
 Mon, 07 Oct 2024 06:51:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPC+OX9ujtrAcSayET35EpS2+1z1OiTz59MPBSpfb1e+TabrQ3Bl6VdHvWTOI6WO2nIyRv5eX9HRqpjIrQaio=
X-Received: by 2002:a05:690c:388:b0:6e2:71b:150 with SMTP id
 00721157ae682-6e2c72968admr103550647b3.29.1728309107738; Mon, 07 Oct 2024
 06:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
 <20241004124445.3802090-2-jonah.palmer@oracle.com>
 <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
 <e3108f34-f951-47d6-ac41-cbbc045a7bd1@oracle.com>
In-Reply-To: <e3108f34-f951-47d6-ac41-cbbc045a7bd1@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 7 Oct 2024 15:51:11 +0200
Message-ID: <CAJaqyWcmjnPaAFGvE5=2e19wuAxOr2=AHX1y-dj70+49sdQh7Q@mail.gmail.com>
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Fri, Oct 4, 2024 at 8:48=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
>
>
> On 10/4/24 11:17 AM, Eugenio Perez Martin wrote:
> > On Fri, Oct 4, 2024 at 2:45=E2=80=AFPM Jonah Palmer <jonah.palmer@oracl=
e.com> wrote:
> >>
> >> Implements the IOVA->GPA tree for handling mapping, unmapping, and
> >> translations for guest memory regions.
> >>
> >> When the guest has overlapping memory regions, an HVA to IOVA translat=
ion
> >> may return an incorrect IOVA when searching the IOVA->HVA tree. This i=
s
> >> due to one HVA range being contained (overlapping) in another HVA rang=
e
> >> in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can use GPAs =
to
> >> translate and find the correct IOVA for guest memory regions.
> >>
> >
> > Yes, this first patch is super close to what I meant, just one issue
> > and a pair of nits here and there.
> >
> > I'd leave the second patch as an optimization on top, if the numbers
> > prove that adding the code is worth it.
> >
>
> Ah okay, gotcha. I also wasn't sure if what you mentioned below on the
> previous series you also wanted implemented or if these would also be
> optimizations on top.
>
> [Adding code to the vhost_iova_tree layer for handling multiple buffers
> returned from translation for the memory area where each iovec covers]:
> -----------------------------------------------------------------------
> "Let's say that SVQ wants to translate the HVA range
> 0xfeda0000-0xfedd0000. So it makes available for the device two
> chained buffers: One with addr=3D0x1000 len=3D0x20000 and the other one
> with addr=3D(0x20000c1000 len=3D0x10000).
>
> The VirtIO device should be able to translate these two buffers in
> isolation and chain them. Not optimal but it helps to keep QEMU source
> clean, as the device already must support it."
>

This is 100% in the device and QEMU is already able to split the
buffers that way, so we don't need any change in QEMU.

> [Adding a permission check to iova_tree_find_address_iterator and match
> the range by permissions]:
> -----------------------------------------------------------------------
> "About the permissions, maybe we can make the permissions to be part of
> the lookup? Instead of returning them at iova_tree_find_iova, make
> them match at iova_tree_find_address_iterator."
>

Ouch, I forgot this part. This is a small change we also need, can you
add it for the next version? Thanks for remind it!

> But I understand that the problems with this is that we're assuming the
> SVQ translation will always be done in a transient manner.
>
> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   hw/virtio/vhost-iova-tree.c | 78 +++++++++++++++++++++++++++++++++++=
--
> >>   hw/virtio/vhost-iova-tree.h |  5 +++
> >>   hw/virtio/vhost-vdpa.c      | 20 ++++++----
> >>   3 files changed, 92 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
> >> index 3d03395a77..e33fd56225 100644
> >> --- a/hw/virtio/vhost-iova-tree.c
> >> +++ b/hw/virtio/vhost-iova-tree.c
> >> @@ -28,12 +28,15 @@ struct VhostIOVATree {
> >>
> >>       /* IOVA address to qemu memory maps. */
> >>       IOVATree *iova_taddr_map;
> >> +
> >> +    /* IOVA address to guest memory maps. */
> >> +    IOVATree *iova_gpa_map;
> >>   };
> >>
> >>   /**
> >> - * Create a new IOVA tree
> >> + * Create a new VhostIOVATree
> >>    *
> >> - * Returns the new IOVA tree
> >> + * Returns the new VhostIOVATree
> >>    */
> >>   VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_la=
st)
> >>   {
> >> @@ -44,6 +47,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first=
, hwaddr iova_last)
> >>       tree->iova_last =3D iova_last;
> >>
> >>       tree->iova_taddr_map =3D iova_tree_new();
> >> +    tree->iova_gpa_map =3D iova_tree_new();
> >>       return tree;
> >>   }
> >>
> >> @@ -53,6 +57,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first=
, hwaddr iova_last)
> >>   void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
> >>   {
> >>       iova_tree_destroy(iova_tree->iova_taddr_map);
> >> +    iova_tree_destroy(iova_tree->iova_gpa_map);
> >>       g_free(iova_tree);
> >>   }
> >>
> >> @@ -71,7 +76,7 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostI=
OVATree *tree,
> >>   }
> >>
> >>   /**
> >> - * Allocate a new mapping
> >> + * Allocate a new mapping in the IOVA->HVA tree
> >>    *
> >>    * @tree: The iova tree
> >>    * @map: The iova map
> >> @@ -108,3 +113,70 @@ void vhost_iova_tree_remove(VhostIOVATree *iova_t=
ree, DMAMap map)
> >>   {
> >>       iova_tree_remove(iova_tree->iova_taddr_map, map);
> >>   }
> >> +
> >> +/**
> >> + * Find the IOVA address stored from a guest memory address
> >> + *
> >> + * @tree: The VhostIOVATree
> >> + * @map: The map with the guest memory address
> >> + *
> >> + * Return the stored mapping, or NULL if not found.
> >> + */
> >> +const DMAMap *vhost_iova_gpa_tree_find_iova(const VhostIOVATree *tree=
,
> >> +                                            const DMAMap *map)
> >
> > Nit: Not an english native, but I find vhost_iova_tree should not be
> > broken for coherency with the rest of the functions. What about
> > vhost_iova_tree_find_iova_gpa, like _gpa variant?
> >
>
> Yea, I totally understand what you mean here and I have *no problem*
> making it into vhost_iova_tree_find_iova_gpa.
>
> Just to add my two cents on this, for what it's worth, now that we have
> both an IOVA->HVA tree and a IOVA->GPA tree, coming up with function
> names that operate on this new tree while conforming to the
> vhost_iova_tree convention and being descriptive in the naming is a bit
> difficult.
>
> For example, to me, vhost_iova_tree_find_iova_gpa would seem a bit
> misleading to me if I didn't know about it beforehand (or was just
> seeing it for the first time). Like, are we finding the IOVA or GPA or
> both? And what tree are we operating on?
>
> If this was some personal code I was writing and I had free reign over
> it, I personally would go with a format like:
>
> vhost_<tree this function concerns>_tree_<action>
>
> So a name like vhost_iova_gpa_tree_find_iova communicates to me that
> we're operating on the iova_gpa (IOVA->GPA) tree and our action is to
> find_iova (find the IOVA).
>
> Similarly for something like vhost_iova_gpa_tree_remove or
> vhost_iova_hva_tree_remove, etc.
>
> But obviously this is the complete opposite of personal code and
> certainly not something that's needed so I'm totally okay with renaming
> it to vhost_iova_tree_find_iova_gpa :)
>

You're creating the patch and you (and everybody) can comment on it,
of course :).

To me, the fact that GPA is stored in a separated *tree* should be an
implementation detail not exposed by the function names. Ideally, the
user of the VhostIOVATree just knows that some entries are tagged with
the GPA and others are not. Saying otherwise, we could replace the GPA
for another struct, or merge both trees, and the API would remain
unchanged if we just add the _gpa as suffix.

Having said that, I'm happy with both names so feel free to keep yours.



> >> +{
> >> +    return iova_tree_find_iova(tree->iova_gpa_map, map);
> >> +}
> >> +
> >> +/**
> >> + * Allocate new mappings in the IOVA->HVA & IOVA->GPA trees
> >> + *
> >> + * @tree: The VhostIOVATree
> >> + * @map: The iova map
> >> + * @gpa: The guest physical address (GPA)
> >> + *
> >> + * Returns:
> >> + * - IOVA_OK if the map fits both containers
> >> + * - IOVA_ERR_INVALID if the map does not make sense (like size overf=
low)
> >> + * - IOVA_ERR_NOMEM if the IOVA->HVA tree cannot allocate more space
> >> + *
> >> + * It returns an assigned iova in map->iova if return value is IOVA_O=
K.
> >> + */
> >> +int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *tree, DMAMap *map, h=
waddr gpa)
> >> +{
> >> +    int ret;
> >> +
> >> +    /* Some vhost devices don't like addr 0. Skip first page */
> >> +    hwaddr iova_first =3D tree->iova_first ?: qemu_real_host_page_siz=
e();
> >> +
> >> +    if (map->translated_addr + map->size < map->translated_addr ||
> >> +        map->perm =3D=3D IOMMU_NONE) {
> >> +        return IOVA_ERR_INVALID;
> >> +    }
> >> +
> >> +    /* Allocate a node in the IOVA->HVA tree */
> >> +    ret =3D iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first=
,
> >> +                              tree->iova_last);
> >
> > Why not call vhost_iova_tree_map_alloc instead of duplicating it here?
> >
>
> Great question with no good answer! For some reason I thought against
> putting it in there but will do that in the next series.
>
> >> +    if (unlikely(ret !=3D IOVA_OK)) {
> >> +        return ret;
> >> +    }
> >> +
> >> +    /* Insert a node in the IOVA->GPA tree */
> >> +    map->translated_addr =3D gpa;
> >> +    return iova_tree_insert(tree->iova_gpa_map, map);
> >> +}
> >> +
> >> +/**
> >> + * Remove existing mappings from the IOVA->HVA & IOVA->GPA trees
> >> + *
> >> + * @iova_tree: The VhostIOVATree
> >> + * @map: The map to remove
> >> + */
> >> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
> >> +{
> >> +    /* Remove the existing mapping from the IOVA->GPA tree */
> >> +    iova_tree_remove(iova_tree->iova_gpa_map, map);
> >> +
> >> +    /* Remove the corresponding mapping from the IOVA->HVA tree */
> >> +    iova_tree_remove(iova_tree->iova_taddr_map, map);
> >
> > If we remove it blindly from both trees, we are keeping the bug, isn't =
it?
> >
> > I think the remove should receive the "gpa" as a parameter, same as
> > alloc_gpa. After that, vhost_iova_tree_remove_gpa looks the right iova
> > into iova_gpa_map. And only after that, it removes that iova from
> > iova_tree_remove.
> >
> > If it makes things easier it could receive (hwaddr gpa, size_t len) or
> > all of the info in a DMAMap. What do you think?
> >
>
> Initially that was my plan but this only gets called in
> vhost_vdpa_listener_region_add/del and in both functions, by the time
> this removal function is called, we already have the correct IOVA.
>
> In vhost_vdpa_listener_region_add, we just allocated that IOVA and saved
> it in mem_region. In vhost_vdpa_listener_region_del, we already found
> the IOVA via vhost_iova_gpa_tree_find_iova prior to calling the removal
> function.
>
> But I could be misunderstanding something here. Let me know if I am.
>

Ok I missed that. I think you're totally right.

> >> +}
> >> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
> >> index 4adfd79ff0..511c6d18ae 100644
> >> --- a/hw/virtio/vhost-iova-tree.h
> >> +++ b/hw/virtio/vhost-iova-tree.h
> >> @@ -23,5 +23,10 @@ const DMAMap *vhost_iova_tree_find_iova(const Vhost=
IOVATree *iova_tree,
> >>                                           const DMAMap *map);
> >>   int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map)=
;
> >>   void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
> >> +const DMAMap *vhost_iova_gpa_tree_find_iova(const VhostIOVATree *iova=
_tree,
> >> +                                            const DMAMap *map);
> >> +int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *iova_tree, DMAMap *m=
ap,
> >> +                                  hwaddr gpa);
> >> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)=
;
> >>
> >>   #endif
> >> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >> index 3cdaa12ed5..591ff426e7 100644
> >> --- a/hw/virtio/vhost-vdpa.c
> >> +++ b/hw/virtio/vhost-vdpa.c
> >> @@ -365,9 +365,16 @@ static void vhost_vdpa_listener_region_add(Memory=
Listener *listener,
> >>           mem_region.size =3D int128_get64(llsize) - 1,
> >>           mem_region.perm =3D IOMMU_ACCESS_FLAG(true, section->readonl=
y),
> >>
> >> -        r =3D vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
> >> +        r =3D vhost_iova_tree_map_alloc_gpa(s->iova_tree, &mem_region=
,
> >> +                                          section->offset_within_addr=
ess_space);
> >>           if (unlikely(r !=3D IOVA_OK)) {
> >>               error_report("Can't allocate a mapping (%d)", r);
> >> +
> >> +            /* Insertion to IOVA->GPA tree failed */
> >> +            if (mem_region.translated_addr =3D=3D
> >> +                section->offset_within_address_space) {
> >> +                goto fail_map;
> >> +            }
> >
> > We can move this cleanup code into vhost_iova_tree_map_alloc_gpa, isn't=
 it?
> >
>
> Sure can. We'd still need to check if vhost_iova_tree_map_alloc_gpa
> returned IOVA_OK though and goto the fail label.
>

Yes, right.

Thanks!

> >>               goto fail;
> >>           }
> >>
> >> @@ -386,7 +393,7 @@ static void vhost_vdpa_listener_region_add(MemoryL=
istener *listener,
> >>
> >>   fail_map:
> >>       if (s->shadow_data) {
> >> -        vhost_iova_tree_remove(s->iova_tree, mem_region);
> >> +        vhost_iova_tree_remove_gpa(s->iova_tree, mem_region);
> >>       }
> >>
> >>   fail:
> >> @@ -440,21 +447,18 @@ static void vhost_vdpa_listener_region_del(Memor=
yListener *listener,
> >>
> >>       if (s->shadow_data) {
> >>           const DMAMap *result;
> >> -        const void *vaddr =3D memory_region_get_ram_ptr(section->mr) =
+
> >> -            section->offset_within_region +
> >> -            (iova - section->offset_within_address_space);
> >>           DMAMap mem_region =3D {
> >> -            .translated_addr =3D (hwaddr)(uintptr_t)vaddr,
> >> +            .translated_addr =3D section->offset_within_address_space=
,
> >>               .size =3D int128_get64(llsize) - 1,
> >>           };
> >>
> >> -        result =3D vhost_iova_tree_find_iova(s->iova_tree, &mem_regio=
n);
> >> +        result =3D vhost_iova_gpa_tree_find_iova(s->iova_tree, &mem_r=
egion);
> >>           if (!result) {
> >>               /* The memory listener map wasn't mapped */
> >>               return;
> >>           }
> >>           iova =3D result->iova;
> >> -        vhost_iova_tree_remove(s->iova_tree, *result);
> >> +        vhost_iova_tree_remove_gpa(s->iova_tree, *result);
> >>       }
> >>       vhost_vdpa_iotlb_batch_begin_once(s);
> >>       /*
> >> --
> >> 2.43.5
> >>
> >
>


