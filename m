Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490EEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 06:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2QBv-0004kP-Ea; Thu, 02 May 2024 02:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s2QBt-0004ju-7s
 for qemu-devel@nongnu.org; Thu, 02 May 2024 02:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s2QBq-0005ql-IA
 for qemu-devel@nongnu.org; Thu, 02 May 2024 02:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714632307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFFhc+Brv75ul2xGPo7fSFrkNMruwWXBKJSJyvFuijY=;
 b=hFeEKnZ7N2UmBrf83R0XCeFUebkHNkgEO2DAjKzjkbQLIOjIM1/Y/WIOuiydOdbLCSGupH
 hNw7M1DefbZrTMz5wYZwHSEfUp3fscBXrJzX9ba3IZqHKEYTphOOE19Ho5M149+z07NfqF
 xdAjbT2K89DPpHKi7f/ztB9DDAXBAWA=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-HNFX_1OWO3CYCIjO7hVH7Q-1; Thu, 02 May 2024 02:45:04 -0400
X-MC-Unique: HNFX_1OWO3CYCIjO7hVH7Q-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-de59e612376so11936912276.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 23:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714632303; x=1715237103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YFFhc+Brv75ul2xGPo7fSFrkNMruwWXBKJSJyvFuijY=;
 b=wFvt3xubeq4OK2UytqSyKu0QvM0Fuqla6l+V7m7kgrUSXsUvlhLDQYrAnxZJJWsAWR
 h7+3qFt4EugVbJLOkFwJ9+twy5pefzOV1lcr6Pd1W4Z9LwlR7Z1kfoFtyn7GgCzWXoYU
 nU7/meBjC2RqiLx36PH+52e2PHYZS5ZKZsH90tlJP6x/R8GGv4OOO0GFxYyMLACUiIBO
 iV0DMmNFykGrwa6/oQ5SUIIEtsHBYkfNZUdaw0uq67Fr24e5m5sbkkLQ4k8O0spt5Uhi
 ZSJc6nz1N08L7hR597RFQsERUw7ch9TFgU5JFJFUW8mePlt7i+THFv66M8hUsPaR1H3D
 ClsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnyk0mwzXKHWxkDmwYa9G3ybhQX8nNyqcs8vLug5PBKRewLuk/GU00otZtP9OIgoMqp+dmCibTQjghVxqoCixLkSbatB8=
X-Gm-Message-State: AOJu0Yx99QqTdAOBy5YnkzEUWFWBCu1yHRrkCSFbGeU0jgcccO1zJrlf
 56MxIJoWuXd9qeQi95hi69TVZn0mFOwUwG+KnHs5U0hcyLap0afpQJSQ3xrY/0oILLzwfV76UmC
 3hDbluYDPvFBRVDZjW3OxkmXaEKzfJbRGeM1PMQAm3u/BYBlFaJE1GKdJHqbonvJMgGGiFmARIr
 5+LO29nJwpKl0XIOjxPV3eYhgReyw=
X-Received: by 2002:a05:6902:218d:b0:dcc:dbb8:ba73 with SMTP id
 dl13-20020a056902218d00b00dccdbb8ba73mr5994063ybb.9.1714632303364; 
 Wed, 01 May 2024 23:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV0hGTO7pF9PXRzuugSaq3nuMauMjUszhpQ5bfaexQJDIftdSAp3CHQpcP0zitXN8wn+yujm8RY9mEGTPcOqs=
X-Received: by 2002:a05:6902:218d:b0:dcc:dbb8:ba73 with SMTP id
 dl13-20020a056902218d00b00dccdbb8ba73mr5994035ybb.9.1714632302640; Wed, 01
 May 2024 23:45:02 -0700 (PDT)
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
 <f6c63253-57bf-4e7a-8178-667a577784d5@oracle.com>
 <CAJaqyWdheH4MoHMOQjPmbOpODswE53w09LkfeaDNWdys3qUFLw@mail.gmail.com>
 <86670db8-604c-4bad-9022-a59b8363e5ca@oracle.com>
In-Reply-To: <86670db8-604c-4bad-9022-a59b8363e5ca@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 2 May 2024 08:44:26 +0200
Message-ID: <CAJaqyWf1iPgKbp8-SfFGeMxJ2E-1y5dLLkOxLLNa6rm4tQgPGA@mail.gmail.com>
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Thu, May 2, 2024 at 1:16=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
>
>
> On 4/30/2024 10:19 AM, Eugenio Perez Martin wrote:
> > On Tue, Apr 30, 2024 at 7:55=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 4/29/2024 1:14 AM, Eugenio Perez Martin wrote:
> >>> On Thu, Apr 25, 2024 at 7:44=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>>
> >>>> On 4/24/2024 12:33 AM, Eugenio Perez Martin wrote:
> >>>>> On Wed, Apr 24, 2024 at 12:21=E2=80=AFAM Si-Wei Liu <si-wei.liu@ora=
cle.com> wrote:
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
> >>>>>> https://github.com/GNOME/glib/blob/main/glib/gtree.c#L1115
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
> >> Ouch, thank you for the summary of attempts that were done earlier.
> >>> The only advance I have is that memory_region_from_host is able to
> >>> tell if the vaddr is from the guest or not.
> >> Hmmm, then it won't be too useful without a direct means to identifyin=
g
> >> the exact memory region associated with the iova that is being mapped.
> >> And, this additional indirection seems introduce a tiny bit of more
> >> latency in the reverse lookup routine (should not be a scalability iss=
ue
> >> though if it's a linear search)?
> >>
> > I didn't measure, but I guess yes it might. OTOH these structs may be
> > cached because virtqueue_pop just looked for them.
> Oh, right, that's a good point.
> >
> >>> So I'm convinced there must be a way to do it with the memory
> >>> subsystem, but I think the best way to do it ATM is to store a
> >>> parallel tree with GPA-> SVQ IOVA translations. At removal time, if w=
e
> >>> find the entry in this new tree, we can directly remove it by GPA. If
> >>> not, assume it is a host-only address like SVQ vrings, and remove by
> >>> iterating on vaddr as we do now.
> >> Yeah, this could work I think. On the other hand, given that we are no=
w
> >> trying to improve it, I wonder if possible to come up with a fast
> >> version for the SVQ (host-only address) case without having to look up
> >> twice? SVQ callers should be able to tell apart from the guest case
> >> where GPA -> IOVA translation doesn't exist? Or just maintain a parall=
el
> >> tree with HVA -> IOVA translations for SVQ reverse lookup only? I feel
> >> SVQ mappings may be worth a separate fast lookup path - unlike guest
> >> mappings, the insertion, lookup and removal for SVQ mappings seem
> >> unavoidable during the migration downtime path.
> >>
> > I think the ideal order is the opposite actually. So:
> > 1) Try for the NIC to support _F_VRING_ASID, no translation needed by Q=
EMU
> Right, that's the case for _F_VRING_ASID, which is simple and easy to
> deal with. Though I think this is an edge case across all vendor
> devices, as most likely only those no-chip IOMMU parents may support it.
> It's a luxury for normal device to steal another VF for this ASID feature=
...
>
> > 2) Try reverse lookup from HVA to GPA. Since dataplane should fit
> > this, we should test this first
> So instead of a direct lookup from HVA to IOVA, the purpose of the extra
> reverse lookup from HVA to GPA is to verify the validity of GPA (avoid
> from being mistakenly picked from the overlapped region)? But this would
> seem require scanning the entire GPA space to identify possible GPA
> ranges that are potentially overlapped? I wonder if there exists
> possibility to simplify this assumption, could we go this extra layer of
> GPA wide scan and validation, *only* when overlap is indeed detected
> during memory listerner's region_add (say during which we try to insert
> a duplicate / overlapped HVA into the HVA -> IOVA tree)? Or simply put,
> the first match on the reverse lookup would mostly suffice, since we
> know virtio driver can't use guest memory from these overlapped regions?

The first match should be enough, but maybe we need more than one
match. Let me put an example:

The buffer is (vaddr =3D 0x1000, size=3D0x3000). Now the tree contains two
overlapped entries: (vaddr=3D0x1000, size=3D0x2000), and (vaddr=3D0x1000,
size=3D0x3000).

Assuming we go through the reverse IOVA tree, we had bad luck and we
stored the small entry plus the big entry. The first search returns
the small entry then, (vaddr=3D0x1000, size=3D0x2000),. Calling code must
detect it, and then look for vaddr =3D 0x1000 + 0x2000. That gives us
the next entry.

You can see that virtqueue_map_desc translates this way if
dma_memory_map returns a translation shorter than the length of the
buffer, for example.

> You may say this assumption is too bold, but do we have other means to
> guarantee the first match will always hit under SVQ lookup? Given that
> we don't receive an instance of issue report until we move the memory
> listener registration upfront to device initialization, I guess there
> should be some point or under certain condition that the non-overlapped
> 1:1 translation and lookup can be satisfied. Don't you agree?
>

To be able to build the shorter is desirable, yes. Maybe it can be
done in this series, but I find it hard to solve some situations. For
example, is it possible to have three overlapping regions (A, B, C)
where regions A and B do not overlap but C overlaps both of them?

That's why I think it is better to delay that to a future series, but
we can do it with one shot if it is simple enough for sure.

Thanks!

> Thanks,
> -Siwei
> > 3) Look in SVQ host-only entries (SVQ, current shadow CVQ). It is the
> > control VQ, speed is not so important.
> >
> > Overlapping regions may return the wrong SVQ IOVA though. We should
> > take extra care to make sure these are correctly handled. I mean,
> > there are valid translations in the tree unless the driver is buggy,
> > just may need to span many translations.
> >
> >>>    It is guaranteed the guest does not
> >>> translate to that vaddr and that that vaddr is unique in the tree
> >>> anyway.
> >>>
> >>> Does it sound reasonable? Jonah, would you be interested in moving th=
is forward?
> >> My thought would be that the reverse IOVA tree stuff can be added as a
> >> follow-up optimization right after for extended scalability, but for n=
ow
> >> as the interim, we may still need some form of simple fix, so as to
> >> quickly unblock the other dependent work built on top of this one and
> >> the early pinning series [1]. With it said, I'm completely fine if
> >> performing the reverse lookup through linear tree walk e.g.
> >> g_tree_foreach(), that should suffice small VM configs with just a
> >> couple of queues and limited number of memory regions. Going forward, =
to
> >> address the scalability bottleneck, Jonah could just replace the
> >> corresponding API call with the one built on top of reverse IOVA tree =
(I
> >> presume the use of these iova tree APIs is kind of internal that only
> >> limits to SVQ and vhost-vdpa subsystems) once he gets there, and then
> >> eliminate the other API variants that will no longer be in use. What d=
o
> >> you think about this idea / plan?
> >>
> > Yeah it makes sense to me. Hopefully we can even get rid of the id memb=
er.
> >
> >> Thanks,
> >> -Siwei
> >>
> >> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.=
html
> >>
> >>> Thanks!
> >>>
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


