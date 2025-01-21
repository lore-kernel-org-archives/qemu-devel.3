Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8D2C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 17:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taHrH-0007UK-S6; Tue, 21 Jan 2025 12:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1taHrF-0007RS-K7
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:16:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1taHrB-0007se-BW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737479763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPrhKFj+Ywjvf64erkxYhUiTwK4W2d8u2//UIfv+nRY=;
 b=f7DHO9etxB6MXyHI82CCGUCFoS7TgknVHbOkgSWOhSnNlhbdN6OEthT+oYRQ+7hnMFX8P/
 IdNR7GMpmwvpRT5GlUXo3Dy0Zsy6sDqmQPxwHYu08v7ZMXEiSobw4pVrO+AiKWPC96fOUl
 M85uztmiIns1jiBZIYynkrMN3uCBGG8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-11OLkly1NzWtJZsy9tDPJA-1; Tue, 21 Jan 2025 12:16:01 -0500
X-MC-Unique: 11OLkly1NzWtJZsy9tDPJA-1
X-Mimecast-MFC-AGG-ID: 11OLkly1NzWtJZsy9tDPJA
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e3a0f608b88so13280023276.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 09:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737479761; x=1738084561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPrhKFj+Ywjvf64erkxYhUiTwK4W2d8u2//UIfv+nRY=;
 b=xQcdrYnfsizRxVsvElwLXIboLNxR4MhN6YET3pF7FcSiw4mEHz5H8NswnrPCrNrCk9
 UDd7WrkrOpQli1pRBBsaeMObIkVjO5LSY5iT+Ee/OhUtn9zsH8sDs0RpdPFDozuHCBap
 9nR+A4Md++tqqf8jmjKIruN1wCCrWKIMnuoI0aGqrMqVtXsaIWjAt6dbNKuArZVK01gY
 QUDaFVbYR3qCftdnrIHwFuuYtDFRj0KYuv9RVlvk2ScKeKaIOEh8Aa4Ap0elqh+OXY4v
 2Ucmda7tW0wZlwaxv7wjbQMTP2Px0+KyHvpNwUG7EZW8iclHw+HZFmHkhwIIyOUBQ3Ox
 67+w==
X-Gm-Message-State: AOJu0YzM75PugbKuDOT5azOioW7UviV8lWlwaHqEUHQZW9oIClFfwQEO
 3mPObEbD6TT5PgBs+Mi6RNkRDR0hvoJJG+fMx0QCznsRUasS99bsAdq1LKww6pwU5yQC3+DDPlb
 95PDd5nTTULdU7slF4QJbqqShdNGatvABNm4HFbBqCZE54Hi4FoWYQygBtuji01TwsMXEqNQrEB
 sgjF1N+7FVU8qaLvZYUUmDMuZwKL8=
X-Gm-Gg: ASbGncvhkYfiRooe4AoTSm3rtDv/6hoHtoIZwDT0kb0GjDChjrsBr7V3GV6BwEHT1FC
 OJj0qFu2wdhaaAPjPF8GrGEci9YXLJa9PGPLTm5Brt3RMQxfobQ==
X-Received: by 2002:a05:6902:2089:b0:e57:8bbb:b911 with SMTP id
 3f1490d57ef6-e57b106410emr12062837276.19.1737479761091; 
 Tue, 21 Jan 2025 09:16:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyuFc8hNGIdHC/cdxRapVF/QVGBDbygPIMH/s9hQ7NFc9wzMaj3y7XbQTfULGoMW8dglYJiw3ToyCvTeZs6EQ=
X-Received: by 2002:a05:6902:2089:b0:e57:8bbb:b911 with SMTP id
 3f1490d57ef6-e57b106410emr12062803276.19.1737479760766; Tue, 21 Jan 2025
 09:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
 <20250110170837.2747532-4-jonah.palmer@oracle.com>
 <CAJaqyWdv+Vh5SVGzqy08J8d0VEHYbYX8CK9YuNGZVpE85fOKKg@mail.gmail.com>
 <206d8dad-61a9-47af-a72c-92a7df2367e9@oracle.com>
In-Reply-To: <206d8dad-61a9-47af-a72c-92a7df2367e9@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 21 Jan 2025 18:15:24 +0100
X-Gm-Features: AbW1kvbB2VNRJBwGRtdsBmpEFNpynahhqwd3kVMtBHWYuSy6jYm3H5HdA5fcvtQ
Message-ID: <CAJaqyWfXX5G2TwrnmE-JduB9-6Ssxgz82K6wDs+zfRCzrB==+Q@mail.gmail.com>
Subject: Re: [RFC v3 3/5] vhost-vdpa: Implement the GPA->IOVA tree
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com, 
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

On Tue, Jan 21, 2025 at 4:25=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 1/16/25 2:00 PM, Eugenio Perez Martin wrote:
> > On Fri, Jan 10, 2025 at 6:09=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >> Implements the GPA->IOVA tree for handling mapping and unmapping for
> >> guest memory. This, alongside the SVQ IOVA->HVA tree & IOVA-only tree
> >> implemented in the previous patches, allows us to handle guest and
> >> host-only memory mapping operations separately via their own respectiv=
e
> >> trees.
> >>
> >> The next patches will implement a method to determine if an incomming
> >
> > s/incomming/incoming/ (credits to google syntax highlight actually :) )
> >
>
> Whoops! Good catch. Maybe I should add a spellchecker plugin to my Vim
> configuration haha.
>
> >> address for translation is backed by guest or host-only memory.
> >>
> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   hw/virtio/vhost-iova-tree.c | 50 +++++++++++++++++++++++++++++++++++=
++
> >>   hw/virtio/vhost-iova-tree.h |  4 +++
> >>   hw/virtio/vhost-vdpa.c      | 22 ++++++++++------
> >>   include/qemu/iova-tree.h    | 22 ++++++++++++++++
> >>   util/iova-tree.c            | 46 ++++++++++++++++++++++++++++++++++
> >>   5 files changed, 136 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
> >> index f6a5694857..540bc35660 100644
> >> --- a/hw/virtio/vhost-iova-tree.c
> >> +++ b/hw/virtio/vhost-iova-tree.c
> >> @@ -31,6 +31,9 @@ struct VhostIOVATree {
> >>
> >>       /* Allocated IOVA addresses */
> >>       IOVATree *iova_map;
> >> +
> >> +    /* GPA to IOVA address memory maps */
> >> +    IOVATree *gpa_iova_map;
> >>   };
> >>
> >>   /**
> >> @@ -48,6 +51,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first=
, hwaddr iova_last)
> >>
> >>       tree->iova_taddr_map =3D iova_tree_new();
> >>       tree->iova_map =3D iova_tree_new();
> >> +    tree->gpa_iova_map =3D gpa_tree_new();
> >>       return tree;
> >>   }
> >>
> >> @@ -58,6 +62,7 @@ void vhost_iova_tree_delete(VhostIOVATree *iova_tree=
)
> >>   {
> >>       iova_tree_destroy(iova_tree->iova_taddr_map);
> >>       iova_tree_destroy(iova_tree->iova_map);
> >> +    iova_tree_destroy(iova_tree->gpa_iova_map);
> >>       g_free(iova_tree);
> >>   }
> >>
> >> @@ -134,3 +139,48 @@ int vhost_iova_tree_insert(VhostIOVATree *iova_tr=
ee, DMAMap *map)
> >>
> >>       return iova_tree_insert(iova_tree->iova_taddr_map, map);
> >>   }
> >> +
> >> +/** Insert a new GPA->IOVA mapping to the GPA->IOVA tree
> >> + *
> >> + * @iova_tree: The VhostIOVATree
> >> + * @map: The GPA->IOVA mapping
> >> + *
> >> + * Returns:
> >> + * - IOVA_OK if the map fits in the container
> >> + * - IOVA_ERR_INVALID if the map does not make sense (e.g. size overf=
low)
> >> + * - IOVA_ERR_OVERLAP if the GPA range overlaps with an existing rang=
e
> >> + */
> >> +int vhost_iova_tree_insert_gpa(VhostIOVATree *iova_tree, DMAMap *map)
> >> +{
> >> +    if (map->iova + map->size < map->iova || map->perm =3D=3D IOMMU_N=
ONE) {
> >> +        return IOVA_ERR_INVALID;
> >> +    }
> >> +
> >> +    return gpa_tree_insert(iova_tree->gpa_iova_map, map);
> >> +}
> >> +
> >> +/**
> >> + * Find the IOVA address stored from a guest memory address (GPA)
> >> + *
> >> + * @tree: The VhostIOVATree
> >> + * @map: The map with the guest memory address
> >> + *
> >> + * Returns the stored GPA->IOVA mapping, or NULL if not found.
> >> + */
> >> +const DMAMap *vhost_iova_tree_find_gpa(const VhostIOVATree *tree,
> >> +                                       const DMAMap *map)
> >> +{
> >> +    return iova_tree_find_iova(tree->gpa_iova_map, map);
> >> +}
> >> +
> >> +/**
> >> + * Remove existing mappings from the GPA->IOVA & IOVA trees
> >> + *
> >> + * @iova_tree: The VhostIOVATree
> >> + * @map: The guest memory address map to remove
> >> + */
> >> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
> >> +{
> >> +    iova_tree_remove(iova_tree->gpa_iova_map, map);
> >> +    iova_tree_remove(iova_tree->iova_map, map);
> >> +}
> >> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
> >> index 8bf7b64786..3e3dcd04fe 100644
> >> --- a/hw/virtio/vhost-iova-tree.h
> >> +++ b/hw/virtio/vhost-iova-tree.h
> >> @@ -24,5 +24,9 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostI=
OVATree *iova_tree,
> >>   int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map)=
;
> >>   void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
> >>   int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
> >> +int vhost_iova_tree_insert_gpa(VhostIOVATree *iova_tree, DMAMap *map)=
;
> >> +const DMAMap *vhost_iova_tree_find_gpa(const VhostIOVATree *iova_tree=
,
> >> +                                       const DMAMap *map);
> >> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)=
;
> >>
> >>   #endif
> >> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >> index f5803f35f4..8587f3f6c8 100644
> >> --- a/hw/virtio/vhost-vdpa.c
> >> +++ b/hw/virtio/vhost-vdpa.c
> >> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(Memor=
yListener *listener,
> >>       if (s->shadow_data) {
> >>           int r;
> >>
> >> -        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr,
> >>           mem_region.size =3D int128_get64(llsize) - 1,
> >>           mem_region.perm =3D IOMMU_ACCESS_FLAG(true, section->readonl=
y),
> >>
> >> +        /* Allocate an IOVA range in the IOVA tree */
> >>           r =3D vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
> >>           if (unlikely(r !=3D IOVA_OK)) {
> >>               error_report("Can't allocate a mapping (%d)", r);
> >> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(Memory=
Listener *listener,
> >>           }
> >>
> >>           iova =3D mem_region.iova;
> >> +        mem_region.translated_addr =3D section->offset_within_address=
_space;
> >> +
> >> +        /* Add GPA->IOVA mapping to the GPA->IOVA tree */
> >> +        r =3D vhost_iova_tree_insert_gpa(s->iova_tree, &mem_region);
> >> +        if (unlikely(r !=3D IOVA_OK)) {
> >> +            error_report("Can't add listener region mapping (%d)", r)=
;
> >> +            goto fail_map;
> >> +        }
> >
> > If we want to make the two disjoint trees, we need to make the
> > previous commits working. I mean, either insert hva and then switch to
> > gpa here, or merge patches, or something similar. Otherwise, bisection
> > breaks.
> >
> >
>
> Gotcha. In the future I'll be more careful and make sure individual
> patches in a series actually work. My apologies.
>
> Will fix this in the next series.
>

Great!

> >>       }
> >>
> >>       vhost_vdpa_iotlb_batch_begin_once(s);
> >> @@ -386,7 +394,7 @@ static void vhost_vdpa_listener_region_add(MemoryL=
istener *listener,
> >>
> >>   fail_map:
> >>       if (s->shadow_data) {
> >> -        vhost_iova_tree_remove(s->iova_tree, mem_region);
> >> +        vhost_iova_tree_remove_gpa(s->iova_tree, mem_region);
> >>       }
> >>
> >>   fail:
> >> @@ -440,21 +448,19 @@ static void vhost_vdpa_listener_region_del(Memor=
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
> >> +        /* Search the GPA->IOVA tree */
> >> +        result =3D vhost_iova_tree_find_gpa(s->iova_tree, &mem_region=
);
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
> >> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
> >> index 44a45931d5..8467912a0b 100644
> >> --- a/include/qemu/iova-tree.h
> >> +++ b/include/qemu/iova-tree.h
> >> @@ -40,6 +40,15 @@ typedef struct DMAMap {
> >>   } QEMU_PACKED DMAMap;
> >>   typedef gboolean (*iova_tree_iterator)(DMAMap *map);
> >>
> >> +/**
> >> + * gpa_tree_new:
> >> + *
> >> + * Create a new GPA->IOVA tree.
> >> + *
> >> + * Returns: the tree pointer on success, or NULL otherwise.
> >> + */
> >> +IOVATree *gpa_tree_new(void);
> >> +
> >>   /**
> >>    * iova_tree_new:
> >>    *
> >> @@ -49,6 +58,19 @@ typedef gboolean (*iova_tree_iterator)(DMAMap *map)=
;
> >>    */
> >>   IOVATree *iova_tree_new(void);
> >>
> >> +/**
> >> + * gpa_tree_insert:
> >> + *
> >> + * @tree: The GPA->IOVA tree we're inserting the mapping to
> >> + * @map: The GPA->IOVA mapping to insert
> >> + *
> >> + * Inserts a GPA range to the GPA->IOVA tree. If there are overlapped
> >> + * ranges, IOVA_ERR_OVERLAP will be returned.
> >> + *
> >> + * Return: 0 if successful, < 0 otherwise.
> >> + */
> >> +int gpa_tree_insert(IOVATree *tree, const DMAMap *map);
> >> +
> >>   /**
> >>    * iova_tree_insert:
> >>    *
> >> diff --git a/util/iova-tree.c b/util/iova-tree.c
> >> index 06295e2755..f45e63c3de 100644
> >> --- a/util/iova-tree.c
> >> +++ b/util/iova-tree.c
> >> @@ -55,6 +55,22 @@ static void iova_tree_alloc_args_iterate(struct IOV=
ATreeAllocArgs *args,
> >>       args->this =3D next;
> >>   }
> >>
> >> +static int gpa_tree_compare(gconstpointer a, gconstpointer b, gpointe=
r data)
> >> +{
> >> +    const DMAMap *m1 =3D a, *m2 =3D b;
> >> +
> >> +    if (m1->translated_addr > m2->translated_addr + m2->size) {
> >> +        return 1;
> >> +    }
> >> +
> >> +    if (m1->translated_addr + m1->size < m2->translated_addr) {
> >> +        return -1;
> >> +    }
> >> +
> >> +    /* Overlapped */
> >> +    return 0;
> >> +}
> >> +
> >>   static int iova_tree_compare(gconstpointer a, gconstpointer b, gpoin=
ter data)
> >>   {
> >>       const DMAMap *m1 =3D a, *m2 =3D b;
> >> @@ -71,6 +87,15 @@ static int iova_tree_compare(gconstpointer a, gcons=
tpointer b, gpointer data)
> >>       return 0;
> >>   }
> >>
> >> +IOVATree *gpa_tree_new(void)
> >> +{
> >> +    IOVATree *gpa_tree =3D g_new0(IOVATree, 1);
> >> +
> >> +    gpa_tree->tree =3D g_tree_new_full(gpa_tree_compare, NULL, g_free=
, NULL);
> >> +
> >> +    return gpa_tree;
> >> +}
> >> +
> >>   IOVATree *iova_tree_new(void)
> >>   {
> >>       IOVATree *iova_tree =3D g_new0(IOVATree, 1);
> >> @@ -121,6 +146,27 @@ static inline void iova_tree_insert_internal(GTre=
e *gtree, DMAMap *range)
> >>       g_tree_insert(gtree, range, range);
> >>   }
> >>
> >> +int gpa_tree_insert(IOVATree *tree, const DMAMap *map)
> >> +{
> >> +    DMAMap *new;
> >> +
> >> +    if (map->translated_addr + map->size < map->translated_addr ||
> >> +        map->perm =3D=3D IOMMU_NONE) {
> >> +        return IOVA_ERR_INVALID;
> >> +    }
> >> +
> >> +    /* We don't allow inserting ranges that overlap with existing one=
s */
> >> +    if (iova_tree_find(tree,map)) {
> >> +        return IOVA_ERR_OVERLAP;
> >> +    }
> >> +
> >> +    new =3D g_new0(DMAMap, 1);
> >> +    memcpy(new, map, sizeof(*new));
> >> +    iova_tree_insert_internal(tree->tree, new);
> >> +
> >> +    return IOVA_OK;
> >> +}
> >> +
> >
> > I'm missing the advantage of using all of these functions, why not use
> > another iova_tree_new and iova_tree_insert? gpa_tree_compare seems
> > like a 1:1 copy of iova_tree_compare to me. Same with _insert.
> >
>
> It's mainly due to how the GPA tree is configured. That is, GPA->IOVA
> (or translated_addr->iova).
>
> The existing functions assume the configuration of the tree to be
> iova->translated_addr (e.g. IOVA->HVA).
>
> I think I could still use the existing functions but then it'd have to
> be a IOVA->GPA tree, else a GPA->IOVA tree would mean DMAMap map->iova
> =3D=3D GPA and map->translated_addr =3D=3D IOVA, which obviously would ca=
use
> confusion for the API users.
>

Ook now I remember having this same doubt, a very good point :).

In my opinion it is enough with a comment in the VhostIOVAtree struct
definition as long as the usage keeps internal to it and well wrapped
in the non static functions. MST, Jason, any thoughts on this?

If we ever want to reduce the memory consumption of the tree we can
also reuse the same node for both trees and reuse these functions.


