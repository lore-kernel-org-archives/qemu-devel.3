Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EABCC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 08:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1MAu-00065c-Gu; Mon, 29 Apr 2024 04:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s1MAq-000656-Ha
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 04:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s1MAn-0007LE-Vb
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 04:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714378540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVg57R5RmMRtSo4MDVlDvZPTbn2V2MerYyeJRwFMF6I=;
 b=MpwaYYFNp+e6QaODsrHjO/jf5kqpuXsi5qLlhehro5SDBQjnowPnbju2JnIZ5yvaYPgKjc
 JigY0KTwOzdyn6fE8xwaYPoZGxKAJeEVc3R/3+cEXsIt1YmTHPwJCI08ZOR+u4tQYi0oPS
 3bBiUd44kt2DO07oYWrvew42pIBYLME=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-fVW7QOWKPCaHN6tHdqMRlA-1; Mon, 29 Apr 2024 04:15:36 -0400
X-MC-Unique: fVW7QOWKPCaHN6tHdqMRlA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-61ae546adf3so72342597b3.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 01:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714378536; x=1714983336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVg57R5RmMRtSo4MDVlDvZPTbn2V2MerYyeJRwFMF6I=;
 b=vY2GPEnYmOwhzku1jB8lTuvLp5okSkOmXKSWlZkny1dLUPd5NBp74RVQJLZau0rAB2
 vymydk3e1b+qTLKGHkeeB8f5ZPOcjOroRiXoVzMqVzsOjxwAU8dT78AQRJTgF/ykLfZO
 8FkFDMtAZeuN0rY1FyGE6tlfBwIttCOg1A/XVgClF1wpaydmFZiGTcnZ5Sm5+x4MjtyD
 34pCLA4P2Frc/LOv7BEHC5gIMX26FmBDCXB0lofD2o5TnSmpeqz1IWbYBuCW5DBFwI8h
 QzFgLxTOGgV91ykm7AS2X0IwW9TAsp//h/U/9fwHw42VCP30MjYgD9MLqvszkHQ/rtr3
 3d6A==
X-Gm-Message-State: AOJu0YyE4eJhrFMZ+DxwgjBfHolgICm7QP35eiOMl62XjV74LVVomyt1
 EHbozg0igp6fp53X555BRh1rzU9xrYlDHBlIgbGb+qTzmO6rSDQ4MhKTpcYFbyIsuwVR1wAP7c5
 dvPf8DqgTbbtgqhBcyA7SM0kjkmtw8oMXLdzRU5pwkiDtSquKpbo0LHLiT2FIUbtWImV6KI8MTr
 IKdEnf2b9Uht9sPaETiXlACj8Xp1o=
X-Received: by 2002:a05:690c:d84:b0:615:c96:1a8f with SMTP id
 da4-20020a05690c0d8400b006150c961a8fmr10666180ywb.17.1714378535844; 
 Mon, 29 Apr 2024 01:15:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFXYEfJRbZmfRDJJT/KzMtl/tFss0JvuhSE3uRHzVo1IJDILa8r2TiePN4sl+jfj3l4Iuo/7w4Rwr+rBAoNnM=
X-Received: by 2002:a05:690c:d84:b0:615:c96:1a8f with SMTP id
 da4-20020a05690c0d8400b006150c961a8fmr10666160ywb.17.1714378535492; Mon, 29
 Apr 2024 01:15:35 -0700 (PDT)
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
In-Reply-To: <9f347cd6-8c18-4253-8a5f-efae08230a62@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Apr 2024 10:14:59 +0200
Message-ID: <CAJaqyWeyfPp5bh9iZrkwZshoStEHZ85P6t4TcEdmR5sDYhG4ug@mail.gmail.com>
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Apr 25, 2024 at 7:44=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 4/24/2024 12:33 AM, Eugenio Perez Martin wrote:
> > On Wed, Apr 24, 2024 at 12:21=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.=
com> wrote:
> >>
> >>
> >> On 4/22/2024 1:49 AM, Eugenio Perez Martin wrote:
> >>> On Sat, Apr 20, 2024 at 1:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>>
> >>>> On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
> >>>>> On Thu, Apr 18, 2024 at 10:46=E2=80=AFPM Si-Wei Liu <si-wei.liu@ora=
cle.com> wrote:
> >>>>>> On 4/10/2024 3:03 AM, Eugenio P=C3=A9rez wrote:
> >>>>>>> IOVA tree is also used to track the mappings of virtio-net shadow
> >>>>>>> virtqueue.  This mappings may not match with the GPA->HVA ones.
> >>>>>>>
> >>>>>>> This causes a problem when overlapped regions (different GPA but =
same
> >>>>>>> translated HVA) exists in the tree, as looking them by HVA will r=
eturn
> >>>>>>> them twice.  To solve this, create an id member so we can assign =
unique
> >>>>>>> identifiers (GPA) to the maps.
> >>>>>>>
> >>>>>>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>>>>>> ---
> >>>>>>>      include/qemu/iova-tree.h | 5 +++--
> >>>>>>>      util/iova-tree.c         | 3 ++-
> >>>>>>>      2 files changed, 5 insertions(+), 3 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
> >>>>>>> index 2a10a7052e..34ee230e7d 100644
> >>>>>>> --- a/include/qemu/iova-tree.h
> >>>>>>> +++ b/include/qemu/iova-tree.h
> >>>>>>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
> >>>>>>>          hwaddr iova;
> >>>>>>>          hwaddr translated_addr;
> >>>>>>>          hwaddr size;                /* Inclusive */
> >>>>>>> +    uint64_t id;
> >>>>>>>          IOMMUAccessFlags perm;
> >>>>>>>      } QEMU_PACKED DMAMap;
> >>>>>>>      typedef gboolean (*iova_tree_iterator)(DMAMap *map);
> >>>>>>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *=
tree, const DMAMap *map);
> >>>>>>>       * @map: the mapping to search
> >>>>>>>       *
> >>>>>>>       * Search for a mapping in the iova tree that translated_add=
r overlaps with the
> >>>>>>> - * mapping range specified.  Only the first found mapping will b=
e
> >>>>>>> - * returned.
> >>>>>>> + * mapping range specified and map->id is equal.  Only the first=
 found
> >>>>>>> + * mapping will be returned.
> >>>>>>>       *
> >>>>>>>       * Return: DMAMap pointer if found, or NULL if not found.  N=
ote that
> >>>>>>>       * the returned DMAMap pointer is maintained internally.  Us=
er should
> >>>>>>> diff --git a/util/iova-tree.c b/util/iova-tree.c
> >>>>>>> index 536789797e..0863e0a3b8 100644
> >>>>>>> --- a/util/iova-tree.c
> >>>>>>> +++ b/util/iova-tree.c
> >>>>>>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator=
(gpointer key, gpointer value,
> >>>>>>>
> >>>>>>>          needle =3D args->needle;
> >>>>>>>          if (map->translated_addr + map->size < needle->translate=
d_addr ||
> >>>>>>> -        needle->translated_addr + needle->size < map->translated=
_addr) {
> >>>>>>> +        needle->translated_addr + needle->size < map->translated=
_addr ||
> >>>>>>> +        needle->id !=3D map->id) {
> >>>>>> It looks this iterator can also be invoked by SVQ from
> >>>>>> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest G=
PA
> >>>>>> space will be searched on without passing in the ID (GPA), and exa=
ct
> >>>>>> match for the same GPA range is not actually needed unlike the map=
ping
> >>>>>> removal case. Could we create an API variant, for the SVQ lookup c=
ase
> >>>>>> specifically? Or alternatively, add a special flag, say skip_id_ma=
tch to
> >>>>>> DMAMap, and the id match check may look like below:
> >>>>>>
> >>>>>> (!needle->skip_id_match && needle->id !=3D map->id)
> >>>>>>
> >>>>>> I think vhost_svq_translate_addr() could just call the API variant=
 or
> >>>>>> pass DMAmap with skip_id_match set to true to svq_iova_tree_find_i=
ova().
> >>>>>>
> >>>>> I think you're totally right. But I'd really like to not complicate
> >>>>> the API of the iova_tree more.
> >>>>>
> >>>>> I think we can look for the hwaddr using memory_region_from_host an=
d
> >>>>> then get the hwaddr. It is another lookup though...
> >>>> Yeah, that will be another means of doing translation without having=
 to
> >>>> complicate the API around iova_tree. I wonder how the lookup through
> >>>> memory_region_from_host() may perform compared to the iova tree one,=
 the
> >>>> former looks to be an O(N) linear search on a linked list while the
> >>>> latter would be roughly O(log N) on an AVL tree?
> >>> Even worse, as the reverse lookup (from QEMU vaddr to SVQ IOVA) is
> >>> linear too. It is not even ordered.
> >> Oh Sorry, I misread the code and I should look for g_tree_foreach ()
> >> instead of g_tree_search_node(). So the former is indeed linear
> >> iteration, but it looks to be ordered?
> >>
> >> https://github.com/GNOME/glib/blob/main/glib/gtree.c#L1115
> > The GPA / IOVA are ordered but we're looking by QEMU's vaddr.
> >
> > If we have these translations:
> > [0x1000, 0x2000] -> [0x10000, 0x11000]
> > [0x2000, 0x3000] -> [0x6000, 0x7000]
> >
> > We will see them in this order, so we cannot stop the search at the fir=
st node.
> Yeah, reverse lookup is unordered indeed, anyway.
>
> >
> >>> But apart from this detail you're right, I have the same concerns wit=
h
> >>> this solution too. If we see a hard performance regression we could g=
o
> >>> to more complicated solutions, like maintaining a reverse IOVATree in
> >>> vhost-iova-tree too. First RFCs of SVQ did that actually.
> >> Agreed, yeap we can use memory_region_from_host for now.  Any reason w=
hy
> >> reverse IOVATree was dropped, lack of users? But now we have one!
> >>
> > No, it is just simplicity. We already have an user in the hot patch in
> > the master branch, vhost_svq_vring_write_descs. But I never profiled
> > enough to find if it is a bottleneck or not to be honest.
> Right, without vIOMMU or a lot of virtqueues / mappings, it's hard to
> profile and see the difference.
> >
> > I'll send the new series by today, thank you for finding these issues!
> Thanks! In case you don't have bandwidth to add back reverse IOVA tree,
> Jonah (cc'ed) may have interest in looking into it.
>

Actually, yes. I've tried to solve it using:
memory_region_get_ram_ptr -> It's hard to get this pointer to work
without messing a lot with IOVATree.
memory_region_find -> I'm totally unable to make it return sections
that make sense
flatview_for_each_range -> It does not return the same
MemoryRegionsection as the listener, not sure why.

The only advance I have is that memory_region_from_host is able to
tell if the vaddr is from the guest or not.

So I'm convinced there must be a way to do it with the memory
subsystem, but I think the best way to do it ATM is to store a
parallel tree with GPA-> SVQ IOVA translations. At removal time, if we
find the entry in this new tree, we can directly remove it by GPA. If
not, assume it is a host-only address like SVQ vrings, and remove by
iterating on vaddr as we do now. It is guaranteed the guest does not
translate to that vaddr and that that vaddr is unique in the tree
anyway.

Does it sound reasonable? Jonah, would you be interested in moving this for=
ward?

Thanks!

> -Siwei
>
>
> >
> >> Thanks,
> >> -Siwei
> >>> Thanks!
> >>>
> >>>> Of course,
> >>>> memory_region_from_host() won't search out of the guest memory space=
 for
> >>>> sure. As this could be on the hot data path I have a little bit
> >>>> hesitance over the potential cost or performance regression this cha=
nge
> >>>> could bring in, but maybe I'm overthinking it too much...
> >>>>
> >>>> Thanks,
> >>>> -Siwei
> >>>>
> >>>>>> Thanks,
> >>>>>> -Siwei
> >>>>>>>              return false;
> >>>>>>>          }
> >>>>>>>
>


