Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B2FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 06:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Pn5-00041U-BV; Thu, 02 May 2024 02:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s2Pmx-0003yW-IX
 for qemu-devel@nongnu.org; Thu, 02 May 2024 02:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s2Pmu-0000a3-T1
 for qemu-devel@nongnu.org; Thu, 02 May 2024 02:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714630761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zeEtCO9kouAWn8lv2kfPu4za9P8v35ot+bVqHQsn+os=;
 b=QTk8NV7nXHthh1+g8xK8veAw7cKURDnaX6sZriQeI16hypHuyHVtarVKS7vcFBBoQT9F8v
 wyKckUYuM1nNdhkw5JSdNiURI9lleCPCQrZBqfK7cEPRIBIK4SqVrCGE1MyMMOFtb/8YK6
 4jHmH1pZgQ3eV3RXBXexX2F8CX6bfKE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-7EB6NXY8NPKLF4Aucj8TyQ-1; Thu, 02 May 2024 02:19:20 -0400
X-MC-Unique: 7EB6NXY8NPKLF4Aucj8TyQ-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-61be23bb01aso72892587b3.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 23:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714630759; x=1715235559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zeEtCO9kouAWn8lv2kfPu4za9P8v35ot+bVqHQsn+os=;
 b=YB1WrLXvqz2NIdseDzPn1mrmKDdQocmzErFMH4+b53RUtbc2pJQGGrxaZfY7WaV07b
 9ad4ryjUyu8h9oLUGMR/bAWx86zY54w9nmGtQzGQmYiO6OrxEKY8EpOZkfXuya2akeR0
 gMBe0LHKo8iB1IuQ45dlRgm1nzQJmqcLaUg8sSewAJvDSdwf+ZvI8ZJ6TolflHXzOM23
 vedAPhCPKUo2a/U9H2BCqAH3outxZ+MVogM9/GOKZbA+XLcRagR/8xjLErjuANfu8OKx
 ent0zD+IbaVEKTZnVNZ+0BKUeTkieXcieoeF888G/d5knBvuMM0LJWygulx5naffjDeu
 /zPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWbeh4x8nRiRA7ewMTm5+wFV/pVPFlEf6crh+xUGGpFvUGuNcoaiCDFe+EgjwFg0wtns+/PAlrVL5IsZEB/LUVo5iVWBQ=
X-Gm-Message-State: AOJu0Yz56AAsCobVPnn0MUQ/bnZRw7bA1TqoLCwNcgkwD0zJsBPcb5bB
 R40kg1EzZNf6e3/ia3UUSajHCL6sByeUSzSscocJCc5UakoXrHSAO/I4LmHbrfaA3rTJViY4G9J
 B+XbjBmfg+yv0YmV26m5X6hLjMfxxMfqrLvbMJyXdWkfAYzsBNDlUE408BRsFhT3eXVilZws4cb
 HU7vo9ZV1AScjDeq4VLFCowaOIR5hwSqhec+E=
X-Received: by 2002:a05:6902:1b8d:b0:dcd:3e78:d080 with SMTP id
 ei13-20020a0569021b8d00b00dcd3e78d080mr1589417ybb.4.1714630759474; 
 Wed, 01 May 2024 23:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6lZgVB2lWV2CKYBoGczDfbmpdt62m052JmFSzkutW5BBnSLXWCTBqft2LrV++QO5S91rw4xB3fFRaim6PC4A=
X-Received: by 2002:a05:6902:1b8d:b0:dcd:3e78:d080 with SMTP id
 ei13-20020a0569021b8d00b00dcd3e78d080mr1589371ybb.4.1714630758833; Wed, 01
 May 2024 23:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <20240410100345.389462-2-eperezma@redhat.com>
 <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
 <CAJaqyWeE3kfgN5Y0=Kj6oCOFwg0H-gQEr4g3TM+3_+5N7mfd=A@mail.gmail.com>
 <450d0da1-3d11-428b-bd89-d09a2964cdb1@oracle.com>
 <CAJaqyWfXNQJQdTcJ9V-mSUrMs9up7rpAMwyK-qB3BuJwbUw+5w@mail.gmail.com>
 <f2dcbc76-f90f-4abe-b5c3-f159befd07bd@oracle.com>
 <CAJaqyWeSrwVt6imakpccieqN_3C85JcOZuj=FR+Xnmr7FKFaAw@mail.gmail.com>
 <9f347cd6-8c18-4253-8a5f-efae08230a62@oracle.com>
 <CAJaqyWeyfPp5bh9iZrkwZshoStEHZ85P6t4TcEdmR5sDYhG4ug@mail.gmail.com>
 <1e1cbe99-65e8-4292-b19b-8e054f5b1fca@oracle.com>
 <CAJaqyWeGUM+HZM1-SdQfXmw_xw_tVq9Nns+EH_M8jbOQatXWTw@mail.gmail.com>
 <d708a088-6d20-4dd3-8167-fda21b2551ff@oracle.com>
In-Reply-To: <d708a088-6d20-4dd3-8167-fda21b2551ff@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 2 May 2024 08:18:42 +0200
Message-ID: <CAJaqyWfVidfDgPZw45EpE43C+H16TEyXmQ6NAB-bSVNmXKyCpA@mail.gmail.com>
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 2, 2024 at 12:09=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 4/30/2024 11:11 AM, Eugenio Perez Martin wrote:
> > On Mon, Apr 29, 2024 at 1:19=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >>
> >> On 4/29/24 4:14 AM, Eugenio Perez Martin wrote:
> >>> On Thu, Apr 25, 2024 at 7:44=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>>
> >>>>
> >>>> On 4/24/2024 12:33 AM, Eugenio Perez Martin wrote:
> >>>>> On Wed, Apr 24, 2024 at 12:21=E2=80=AFAM Si-Wei Liu <si-wei.liu@ora=
cle.com> wrote:
> >>>>>>
> >>>>>> On 4/22/2024 1:49 AM, Eugenio Perez Martin wrote:
> >>>>>>> On Sat, Apr 20, 2024 at 1:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@or=
acle.com> wrote:
> >>>>>>>> On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
> >>>>>>>>> On Thu, Apr 18, 2024 at 10:46=E2=80=AFPM Si-Wei Liu <si-wei.liu=
@oracle.com> wrote:
> >>>>>>>>>> On 4/10/2024 3:03 AM, Eugenio P=C3=A9rez wrote:
> >>>>>>>>>>> IOVA tree is also used to track the mappings of virtio-net sh=
adow
> >>>>>>>>>>> virtqueue.  This mappings may not match with the GPA->HVA one=
s.
> >>>>>>>>>>>
> >>>>>>>>>>> This causes a problem when overlapped regions (different GPA =
but same
> >>>>>>>>>>> translated HVA) exists in the tree, as looking them by HVA wi=
ll return
> >>>>>>>>>>> them twice.  To solve this, create an id member so we can ass=
ign unique
> >>>>>>>>>>> identifiers (GPA) to the maps.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>        include/qemu/iova-tree.h | 5 +++--
> >>>>>>>>>>>        util/iova-tree.c         | 3 ++-
> >>>>>>>>>>>        2 files changed, 5 insertions(+), 3 deletions(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tre=
e.h
> >>>>>>>>>>> index 2a10a7052e..34ee230e7d 100644
> >>>>>>>>>>> --- a/include/qemu/iova-tree.h
> >>>>>>>>>>> +++ b/include/qemu/iova-tree.h
> >>>>>>>>>>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
> >>>>>>>>>>>            hwaddr iova;
> >>>>>>>>>>>            hwaddr translated_addr;
> >>>>>>>>>>>            hwaddr size;                /* Inclusive */
> >>>>>>>>>>> +    uint64_t id;
> >>>>>>>>>>>            IOMMUAccessFlags perm;
> >>>>>>>>>>>        } QEMU_PACKED DMAMap;
> >>>>>>>>>>>        typedef gboolean (*iova_tree_iterator)(DMAMap *map);
> >>>>>>>>>>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATr=
ee *tree, const DMAMap *map);
> >>>>>>>>>>>         * @map: the mapping to search
> >>>>>>>>>>>         *
> >>>>>>>>>>>         * Search for a mapping in the iova tree that translat=
ed_addr overlaps with the
> >>>>>>>>>>> - * mapping range specified.  Only the first found mapping wi=
ll be
> >>>>>>>>>>> - * returned.
> >>>>>>>>>>> + * mapping range specified and map->id is equal.  Only the f=
irst found
> >>>>>>>>>>> + * mapping will be returned.
> >>>>>>>>>>>         *
> >>>>>>>>>>>         * Return: DMAMap pointer if found, or NULL if not fou=
nd.  Note that
> >>>>>>>>>>>         * the returned DMAMap pointer is maintained internall=
y.  User should
> >>>>>>>>>>> diff --git a/util/iova-tree.c b/util/iova-tree.c
> >>>>>>>>>>> index 536789797e..0863e0a3b8 100644
> >>>>>>>>>>> --- a/util/iova-tree.c
> >>>>>>>>>>> +++ b/util/iova-tree.c
> >>>>>>>>>>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iter=
ator(gpointer key, gpointer value,
> >>>>>>>>>>>
> >>>>>>>>>>>            needle =3D args->needle;
> >>>>>>>>>>>            if (map->translated_addr + map->size < needle->tra=
nslated_addr ||
> >>>>>>>>>>> -        needle->translated_addr + needle->size < map->transl=
ated_addr) {
> >>>>>>>>>>> +        needle->translated_addr + needle->size < map->transl=
ated_addr ||
> >>>>>>>>>>> +        needle->id !=3D map->id) {
> >>>>>>>>>> It looks this iterator can also be invoked by SVQ from
> >>>>>>>>>> vhost_svq_translate_addr() -> iova_tree_find_iova(), where gue=
st GPA
> >>>>>>>>>> space will be searched on without passing in the ID (GPA), and=
 exact
> >>>>>>>>>> match for the same GPA range is not actually needed unlike the=
 mapping
> >>>>>>>>>> removal case. Could we create an API variant, for the SVQ look=
up case
> >>>>>>>>>> specifically? Or alternatively, add a special flag, say skip_i=
d_match to
> >>>>>>>>>> DMAMap, and the id match check may look like below:
> >>>>>>>>>>
> >>>>>>>>>> (!needle->skip_id_match && needle->id !=3D map->id)
> >>>>>>>>>>
> >>>>>>>>>> I think vhost_svq_translate_addr() could just call the API var=
iant or
> >>>>>>>>>> pass DMAmap with skip_id_match set to true to svq_iova_tree_fi=
nd_iova().
> >>>>>>>>>>
> >>>>>>>>> I think you're totally right. But I'd really like to not compli=
cate
> >>>>>>>>> the API of the iova_tree more.
> >>>>>>>>>
> >>>>>>>>> I think we can look for the hwaddr using memory_region_from_hos=
t and
> >>>>>>>>> then get the hwaddr. It is another lookup though...
> >>>>>>>> Yeah, that will be another means of doing translation without ha=
ving to
> >>>>>>>> complicate the API around iova_tree. I wonder how the lookup thr=
ough
> >>>>>>>> memory_region_from_host() may perform compared to the iova tree =
one, the
> >>>>>>>> former looks to be an O(N) linear search on a linked list while =
the
> >>>>>>>> latter would be roughly O(log N) on an AVL tree?
> >>>>>>> Even worse, as the reverse lookup (from QEMU vaddr to SVQ IOVA) i=
s
> >>>>>>> linear too. It is not even ordered.
> >>>>>> Oh Sorry, I misread the code and I should look for g_tree_foreach =
()
> >>>>>> instead of g_tree_search_node(). So the former is indeed linear
> >>>>>> iteration, but it looks to be ordered?
> >>>>>>
> >>>>>> https://urldefense.com/v3/__https://github.com/GNOME/glib/blob/mai=
n/glib/gtree.c*L1115__;Iw!!ACWV5N9M2RV99hQ!Ng2rLfRd9tLyNTNocW50Mf5AcxSt0uF0=
wOdv120djff-z_iAdbujYK-jMi5UC1DZLxb1yLUv2vV0j3wJo8o$
> >>>>> The GPA / IOVA are ordered but we're looking by QEMU's vaddr.
> >>>>>
> >>>>> If we have these translations:
> >>>>> [0x1000, 0x2000] -> [0x10000, 0x11000]
> >>>>> [0x2000, 0x3000] -> [0x6000, 0x7000]
> >>>>>
> >>>>> We will see them in this order, so we cannot stop the search at the=
 first node.
> >>>> Yeah, reverse lookup is unordered indeed, anyway.
> >>>>
> >>>>>>> But apart from this detail you're right, I have the same concerns=
 with
> >>>>>>> this solution too. If we see a hard performance regression we cou=
ld go
> >>>>>>> to more complicated solutions, like maintaining a reverse IOVATre=
e in
> >>>>>>> vhost-iova-tree too. First RFCs of SVQ did that actually.
> >>>>>> Agreed, yeap we can use memory_region_from_host for now.  Any reas=
on why
> >>>>>> reverse IOVATree was dropped, lack of users? But now we have one!
> >>>>>>
> >>>>> No, it is just simplicity. We already have an user in the hot patch=
 in
> >>>>> the master branch, vhost_svq_vring_write_descs. But I never profile=
d
> >>>>> enough to find if it is a bottleneck or not to be honest.
> >>>> Right, without vIOMMU or a lot of virtqueues / mappings, it's hard t=
o
> >>>> profile and see the difference.
> >>>>> I'll send the new series by today, thank you for finding these issu=
es!
> >>>> Thanks! In case you don't have bandwidth to add back reverse IOVA tr=
ee,
> >>>> Jonah (cc'ed) may have interest in looking into it.
> >>>>
> >>> Actually, yes. I've tried to solve it using:
> >>> memory_region_get_ram_ptr -> It's hard to get this pointer to work
> >>> without messing a lot with IOVATree.
> >>> memory_region_find -> I'm totally unable to make it return sections
> >>> that make sense
> >>> flatview_for_each_range -> It does not return the same
> >>> MemoryRegionsection as the listener, not sure why.
> >>>
> >>> The only advance I have is that memory_region_from_host is able to
> >>> tell if the vaddr is from the guest or not.
> >>>
> >>> So I'm convinced there must be a way to do it with the memory
> >>> subsystem, but I think the best way to do it ATM is to store a
> >>> parallel tree with GPA-> SVQ IOVA translations. At removal time, if w=
e
> >>> find the entry in this new tree, we can directly remove it by GPA. If
> >>> not, assume it is a host-only address like SVQ vrings, and remove by
> >>> iterating on vaddr as we do now. It is guaranteed the guest does not
> >>> translate to that vaddr and that that vaddr is unique in the tree
> >>> anyway.
> >>>
> >>> Does it sound reasonable? Jonah, would you be interested in moving th=
is forward?
> >>>
> >>> Thanks!
> >>>
> >> Sure, I'd be more than happy to work on this stuff! I can probably get
> >> started on this either today or tomorrow.
> >>
> >> Si-Wei mentioned something about these "reverse IOVATree" patches that
> >> were dropped;
> > The patches implementing the reverse IOVA tree were never created /
> > posted, just in case you try to look for them.
> >
> >
> >> is this relevant to what you're asking here? Is it
> >> something I should base my work off of?
> >>
> > So these patches work ok for adding and removing maps. We assign ids,
> > which is the gpa of the memory region that the listener receives. The
> > bad news is that SVQ also needs this id to look for the right
> > translation at vhost_svq_translate_addr, so this series is not
> > complete.
> I have a fundamental question to ask here. Are we sure SVQ really needs
> this id (GPA) to identify the right translation? Or we're just
> concerning much about the aliased map where there could be one single
> HVA mapped to multiple IOVAs / GPAs, which (the overlapped) is almost
> transient mapping that usually goes away very soon after guest memory
> layout is stabilized?

Are we sure all of the overlaps go away after the memory layout is
stabilized in all conditions? I think it is worth not making two
different ways to ask the tree depending on what part of QEMU we are.

> For what I can tell, the caller in SVQ datapath
> code (vhost_svq_vring_write_descs) just calls into
> vhost_iova_tree_find_iova to look for IOVA translation rather than
> identify a specific section on the memory region, the latter of which
> would need the id (GPA) to perform an exact match. The removal case
> would definitely need perfect match on GPA with the additional id, but I
> don't find it necessary for the vhost_svq_vring_write_descs code to pass
> in the id / GPA? Do I miss something?
>

Expanding on the other thread, as there are more concrete points
there. Please let me know if I missed something.

> Thanks,
> -Siwei
>
> > You can find the
> > vhost_iova_tree_find_iova()->iova_tree_find_iova() call there.
> >
> > The easiest solution is the reverse IOVA tree of HVA -> SVQ IOVA. It
> > is also the less elegant and (potentially) the less performant, as it
> > includes duplicating information that QEMU already has, and a
> > potentially linear search.
> >
> > David Hildenbrand (CCed) proposed to try iterating through RAMBlocks.
> > I guess qemu_ram_block_from_host() could return a block where
> > block->offset is the id of the map?
> >
> > It would be great to try this approach. If you don't have the bandwith
> > for this, going directly for the reverse iova tree is also a valid
> > solution.
> >
> > Thanks!
> >
> >> If there's any other relevant information about this issue that you
> >> think I should know, let me know. I'll start digging into this ASAP an=
d
> >> will reach out if I need any guidance. :)
> >>
> >> Jonah
> >>
> >>>> -Siwei
> >>>>
> >>>>
> >>>>>> Thanks,
> >>>>>> -Siwei
> >>>>>>> Thanks!
> >>>>>>>
> >>>>>>>> Of course,
> >>>>>>>> memory_region_from_host() won't search out of the guest memory s=
pace for
> >>>>>>>> sure. As this could be on the hot data path I have a little bit
> >>>>>>>> hesitance over the potential cost or performance regression this=
 change
> >>>>>>>> could bring in, but maybe I'm overthinking it too much...
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> -Siwei
> >>>>>>>>
> >>>>>>>>>> Thanks,
> >>>>>>>>>> -Siwei
> >>>>>>>>>>>                return false;
> >>>>>>>>>>>            }
> >>>>>>>>>>>
>


