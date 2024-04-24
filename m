Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82833C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzX9E-0004fk-8P; Wed, 24 Apr 2024 03:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rzX9C-0004fV-2Y
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rzX99-0006va-G9
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713944066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rra5Xj35pasCpd5GbId8SOvFKTWdFwa1qtMG69oGDIM=;
 b=UwSRr7L6jpGLs4H4/MdjcNDZJP7cDCig8Jmsr37JeAU0FBGkD+Ff9N8FdpmU0mISlIhhw3
 7Ha1a8ImxEWoyTjU19l5XBGCwYT7fipmiHBxhq1PuT0VMLys0riS9UyRwJm6ChQhKDLAAB
 7aK0jSFO5F5q+tHnfYuQonmWcqt/QBs=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-lPGn8tKaPJySdMVqdK-Q0g-1; Wed, 24 Apr 2024 03:34:23 -0400
X-MC-Unique: lPGn8tKaPJySdMVqdK-Q0g-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dc647f65573so13772690276.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 00:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713944063; x=1714548863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rra5Xj35pasCpd5GbId8SOvFKTWdFwa1qtMG69oGDIM=;
 b=VVd0PKxIKVQHpSR7CZCSaXUK8NJXQBIpMf042ZJCCMiVVfjDS/julUHt7SaGL6uGFN
 7fZAJ7UJlsYYHTKEnn7OkuUL9aajcUEwOkG3x3qQ3SBILnd9GtzYOaDg31o2Vb3pUP53
 tbQMeI9I/RvKyyJS1Us6ODHRhwU8RGa0ib+rErnIR/HADEywTj5SmIsXvJv48babfOsq
 l1YDTtaB7xEXue/NJMM8CHXHhf8IXrFFKBkoeQBib+0yshDYNlJj55vTC4Sj+c102MkS
 JqQUY3rHpUOyIb+O8QkhRFHDviCmdwQFOvK8qMPrrzVY6vQyGAR64Yd5ik3OURXG3Rnd
 Wv5w==
X-Gm-Message-State: AOJu0Ywf029WnkJdU+7KyEyuHEMOIe4YsSJcPdsc/wTtZzkYG0bgRvJZ
 tUQozHKYuNJ/R0i8DdLZ8Abh7KjeiGCYqq8GTgVSNnigTRtMPWEAvQ+3HnBK6az3wcoL42mr8p5
 Pe2S/bq4Y8fKw74UqAaFXTZxVHnOsG0fbQ5DNreiFrcfSE/dOAML9e7DnU0LoLkxu+SmG6Y3tUn
 /7ofXzK6dEcGcrvvbQeGO8fAq2hrA=
X-Received: by 2002:a05:6902:114d:b0:de5:4b71:2d1d with SMTP id
 p13-20020a056902114d00b00de54b712d1dmr2372893ybu.29.1713944063221; 
 Wed, 24 Apr 2024 00:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7IqYyMVHaAxDWhACvpsdUEDXRt20+3MFM3GiSRIeZeO9OqOiRHi8bzHNvlJ9TJbxQ/RmUTJrx2105rEWiSXU=
X-Received: by 2002:a05:6902:114d:b0:de5:4b71:2d1d with SMTP id
 p13-20020a056902114d00b00de54b712d1dmr2372875ybu.29.1713944062872; Wed, 24
 Apr 2024 00:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <20240410100345.389462-2-eperezma@redhat.com>
 <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
 <CAJaqyWeE3kfgN5Y0=Kj6oCOFwg0H-gQEr4g3TM+3_+5N7mfd=A@mail.gmail.com>
 <450d0da1-3d11-428b-bd89-d09a2964cdb1@oracle.com>
 <CAJaqyWfXNQJQdTcJ9V-mSUrMs9up7rpAMwyK-qB3BuJwbUw+5w@mail.gmail.com>
 <f2dcbc76-f90f-4abe-b5c3-f159befd07bd@oracle.com>
In-Reply-To: <f2dcbc76-f90f-4abe-b5c3-f159befd07bd@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 24 Apr 2024 09:33:46 +0200
Message-ID: <CAJaqyWeSrwVt6imakpccieqN_3C85JcOZuj=FR+Xnmr7FKFaAw@mail.gmail.com>
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

On Wed, Apr 24, 2024 at 12:21=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
>
>
> On 4/22/2024 1:49 AM, Eugenio Perez Martin wrote:
> > On Sat, Apr 20, 2024 at 1:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
> >>> On Thu, Apr 18, 2024 at 10:46=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracl=
e.com> wrote:
> >>>>
> >>>> On 4/10/2024 3:03 AM, Eugenio P=C3=A9rez wrote:
> >>>>> IOVA tree is also used to track the mappings of virtio-net shadow
> >>>>> virtqueue.  This mappings may not match with the GPA->HVA ones.
> >>>>>
> >>>>> This causes a problem when overlapped regions (different GPA but sa=
me
> >>>>> translated HVA) exists in the tree, as looking them by HVA will ret=
urn
> >>>>> them twice.  To solve this, create an id member so we can assign un=
ique
> >>>>> identifiers (GPA) to the maps.
> >>>>>
> >>>>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>>>> ---
> >>>>>     include/qemu/iova-tree.h | 5 +++--
> >>>>>     util/iova-tree.c         | 3 ++-
> >>>>>     2 files changed, 5 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
> >>>>> index 2a10a7052e..34ee230e7d 100644
> >>>>> --- a/include/qemu/iova-tree.h
> >>>>> +++ b/include/qemu/iova-tree.h
> >>>>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
> >>>>>         hwaddr iova;
> >>>>>         hwaddr translated_addr;
> >>>>>         hwaddr size;                /* Inclusive */
> >>>>> +    uint64_t id;
> >>>>>         IOMMUAccessFlags perm;
> >>>>>     } QEMU_PACKED DMAMap;
> >>>>>     typedef gboolean (*iova_tree_iterator)(DMAMap *map);
> >>>>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tr=
ee, const DMAMap *map);
> >>>>>      * @map: the mapping to search
> >>>>>      *
> >>>>>      * Search for a mapping in the iova tree that translated_addr o=
verlaps with the
> >>>>> - * mapping range specified.  Only the first found mapping will be
> >>>>> - * returned.
> >>>>> + * mapping range specified and map->id is equal.  Only the first f=
ound
> >>>>> + * mapping will be returned.
> >>>>>      *
> >>>>>      * Return: DMAMap pointer if found, or NULL if not found.  Note=
 that
> >>>>>      * the returned DMAMap pointer is maintained internally.  User =
should
> >>>>> diff --git a/util/iova-tree.c b/util/iova-tree.c
> >>>>> index 536789797e..0863e0a3b8 100644
> >>>>> --- a/util/iova-tree.c
> >>>>> +++ b/util/iova-tree.c
> >>>>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(g=
pointer key, gpointer value,
> >>>>>
> >>>>>         needle =3D args->needle;
> >>>>>         if (map->translated_addr + map->size < needle->translated_a=
ddr ||
> >>>>> -        needle->translated_addr + needle->size < map->translated_a=
ddr) {
> >>>>> +        needle->translated_addr + needle->size < map->translated_a=
ddr ||
> >>>>> +        needle->id !=3D map->id) {
> >>>> It looks this iterator can also be invoked by SVQ from
> >>>> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest GPA
> >>>> space will be searched on without passing in the ID (GPA), and exact
> >>>> match for the same GPA range is not actually needed unlike the mappi=
ng
> >>>> removal case. Could we create an API variant, for the SVQ lookup cas=
e
> >>>> specifically? Or alternatively, add a special flag, say skip_id_matc=
h to
> >>>> DMAMap, and the id match check may look like below:
> >>>>
> >>>> (!needle->skip_id_match && needle->id !=3D map->id)
> >>>>
> >>>> I think vhost_svq_translate_addr() could just call the API variant o=
r
> >>>> pass DMAmap with skip_id_match set to true to svq_iova_tree_find_iov=
a().
> >>>>
> >>> I think you're totally right. But I'd really like to not complicate
> >>> the API of the iova_tree more.
> >>>
> >>> I think we can look for the hwaddr using memory_region_from_host and
> >>> then get the hwaddr. It is another lookup though...
> >> Yeah, that will be another means of doing translation without having t=
o
> >> complicate the API around iova_tree. I wonder how the lookup through
> >> memory_region_from_host() may perform compared to the iova tree one, t=
he
> >> former looks to be an O(N) linear search on a linked list while the
> >> latter would be roughly O(log N) on an AVL tree?
> > Even worse, as the reverse lookup (from QEMU vaddr to SVQ IOVA) is
> > linear too. It is not even ordered.
> Oh Sorry, I misread the code and I should look for g_tree_foreach ()
> instead of g_tree_search_node(). So the former is indeed linear
> iteration, but it looks to be ordered?
>
> https://github.com/GNOME/glib/blob/main/glib/gtree.c#L1115

The GPA / IOVA are ordered but we're looking by QEMU's vaddr.

If we have these translations:
[0x1000, 0x2000] -> [0x10000, 0x11000]
[0x2000, 0x3000] -> [0x6000, 0x7000]

We will see them in this order, so we cannot stop the search at the first n=
ode.

> >
> > But apart from this detail you're right, I have the same concerns with
> > this solution too. If we see a hard performance regression we could go
> > to more complicated solutions, like maintaining a reverse IOVATree in
> > vhost-iova-tree too. First RFCs of SVQ did that actually.
> Agreed, yeap we can use memory_region_from_host for now.  Any reason why
> reverse IOVATree was dropped, lack of users? But now we have one!
>

No, it is just simplicity. We already have an user in the hot patch in
the master branch, vhost_svq_vring_write_descs. But I never profiled
enough to find if it is a bottleneck or not to be honest.

I'll send the new series by today, thank you for finding these issues!

> Thanks,
> -Siwei
> >
> > Thanks!
> >
> >> Of course,
> >> memory_region_from_host() won't search out of the guest memory space f=
or
> >> sure. As this could be on the hot data path I have a little bit
> >> hesitance over the potential cost or performance regression this chang=
e
> >> could bring in, but maybe I'm overthinking it too much...
> >>
> >> Thanks,
> >> -Siwei
> >>
> >>>> Thanks,
> >>>> -Siwei
> >>>>>             return false;
> >>>>>         }
> >>>>>
>


