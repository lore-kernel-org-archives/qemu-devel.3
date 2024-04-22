Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B65C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 08:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rypMy-0006Hs-VL; Mon, 22 Apr 2024 04:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rypMw-0006HT-Fg
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 04:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rypMu-0002UO-Qc
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 04:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713775782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9V2NpJvdJ5fvygMvym+SexihOnhSxoN9/8DLXhzzGdo=;
 b=AnB1bBznhMKkhww6Vurs7/6aIxeUwE7JmyoTZ7oLjhIF/D0jH5ai7GNf8TeZ4xJ0C3MozJ
 ByJWgf3fd8LFr5ruInrt63O7lcgluAvN+JilPkqWcgs1k5594k0yXlS/Lr6lGp4s1uKOHl
 KqvUbdI/TwXnnr1lSlTnCwhX5eXL74E=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-rhL8I2MfNY6Tsfk65c6N_A-1; Mon, 22 Apr 2024 04:49:39 -0400
X-MC-Unique: rhL8I2MfNY6Tsfk65c6N_A-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-61b32e7f94bso61569137b3.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 01:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713775779; x=1714380579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9V2NpJvdJ5fvygMvym+SexihOnhSxoN9/8DLXhzzGdo=;
 b=BsYnOVdtvs/PlDL6os2FNXI9UDAXcbnwJqII8Wns6mDnCXHAJiT0mCzd1p4f+4/SqX
 TkV+yX9htDqqWhQpTqOzylZ4p5VcasU8GbLaUbXOsah+yPbFgvz4sWSmFK/mlgGq1NTw
 nia59vHD+XbuEHbbjGJhmrJkTcVGO6gbSBjFzK9zyrVLFs/rfiZ9cREJ1FphuB+AWxwb
 gTOtbOXtbxubYdZkoRFw+FFMXUpizCvILJT0paQlzhNQEyl5lcOL4leuA7iXwHahnejN
 3clKOz+ZGIqLQPH8IcB2/7MAbqwaSfM8LdR3Bp+xZopnn86xfLQkS9MhP0TcwRZSOlWi
 sKzA==
X-Gm-Message-State: AOJu0YziM1DhEEWWzV5YDWHm90T6gu0PIxQLa5/1HFNSKtgj2VFzfzQJ
 41t8sMIPlaoegV0YYOjvZncYp7z15XVueFAh/5M+Ew+BLMkcvRC+OgxkbsJ7K7er6I3ZTKLKXye
 9S/gw/SKFHkR/a16yKdbZ46dI/18xhx5E2yB8/Lz7Faf0llCwIqmO+1AA7jdednVazuyxDyKKra
 1Gjdsa2oV8SyVilkQu/38V0RECKE4=
X-Received: by 2002:a25:7456:0:b0:dcc:9e88:b15 with SMTP id
 p83-20020a257456000000b00dcc9e880b15mr9143616ybc.41.1713775779400; 
 Mon, 22 Apr 2024 01:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhYg4/ABKpEdTV4I4ZUyFTePUqVmCHzpzjGpAsd+dYUBXa+mv/f0zpv+21lbocnARZPMY2QRHYfSH8NqLMe8c=
X-Received: by 2002:a25:7456:0:b0:dcc:9e88:b15 with SMTP id
 p83-20020a257456000000b00dcc9e880b15mr9143609ybc.41.1713775779108; Mon, 22
 Apr 2024 01:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <20240410100345.389462-2-eperezma@redhat.com>
 <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
 <CAJaqyWeE3kfgN5Y0=Kj6oCOFwg0H-gQEr4g3TM+3_+5N7mfd=A@mail.gmail.com>
 <450d0da1-3d11-428b-bd89-d09a2964cdb1@oracle.com>
In-Reply-To: <450d0da1-3d11-428b-bd89-d09a2964cdb1@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 22 Apr 2024 10:49:03 +0200
Message-ID: <CAJaqyWfXNQJQdTcJ9V-mSUrMs9up7rpAMwyK-qB3BuJwbUw+5w@mail.gmail.com>
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
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.42,
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

On Sat, Apr 20, 2024 at 1:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
> > On Thu, Apr 18, 2024 at 10:46=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.=
com> wrote:
> >>
> >>
> >> On 4/10/2024 3:03 AM, Eugenio P=C3=A9rez wrote:
> >>> IOVA tree is also used to track the mappings of virtio-net shadow
> >>> virtqueue.  This mappings may not match with the GPA->HVA ones.
> >>>
> >>> This causes a problem when overlapped regions (different GPA but same
> >>> translated HVA) exists in the tree, as looking them by HVA will retur=
n
> >>> them twice.  To solve this, create an id member so we can assign uniq=
ue
> >>> identifiers (GPA) to the maps.
> >>>
> >>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>> ---
> >>>    include/qemu/iova-tree.h | 5 +++--
> >>>    util/iova-tree.c         | 3 ++-
> >>>    2 files changed, 5 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
> >>> index 2a10a7052e..34ee230e7d 100644
> >>> --- a/include/qemu/iova-tree.h
> >>> +++ b/include/qemu/iova-tree.h
> >>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
> >>>        hwaddr iova;
> >>>        hwaddr translated_addr;
> >>>        hwaddr size;                /* Inclusive */
> >>> +    uint64_t id;
> >>>        IOMMUAccessFlags perm;
> >>>    } QEMU_PACKED DMAMap;
> >>>    typedef gboolean (*iova_tree_iterator)(DMAMap *map);
> >>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tree=
, const DMAMap *map);
> >>>     * @map: the mapping to search
> >>>     *
> >>>     * Search for a mapping in the iova tree that translated_addr over=
laps with the
> >>> - * mapping range specified.  Only the first found mapping will be
> >>> - * returned.
> >>> + * mapping range specified and map->id is equal.  Only the first fou=
nd
> >>> + * mapping will be returned.
> >>>     *
> >>>     * Return: DMAMap pointer if found, or NULL if not found.  Note th=
at
> >>>     * the returned DMAMap pointer is maintained internally.  User sho=
uld
> >>> diff --git a/util/iova-tree.c b/util/iova-tree.c
> >>> index 536789797e..0863e0a3b8 100644
> >>> --- a/util/iova-tree.c
> >>> +++ b/util/iova-tree.c
> >>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(gpo=
inter key, gpointer value,
> >>>
> >>>        needle =3D args->needle;
> >>>        if (map->translated_addr + map->size < needle->translated_addr=
 ||
> >>> -        needle->translated_addr + needle->size < map->translated_add=
r) {
> >>> +        needle->translated_addr + needle->size < map->translated_add=
r ||
> >>> +        needle->id !=3D map->id) {
> >> It looks this iterator can also be invoked by SVQ from
> >> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest GPA
> >> space will be searched on without passing in the ID (GPA), and exact
> >> match for the same GPA range is not actually needed unlike the mapping
> >> removal case. Could we create an API variant, for the SVQ lookup case
> >> specifically? Or alternatively, add a special flag, say skip_id_match =
to
> >> DMAMap, and the id match check may look like below:
> >>
> >> (!needle->skip_id_match && needle->id !=3D map->id)
> >>
> >> I think vhost_svq_translate_addr() could just call the API variant or
> >> pass DMAmap with skip_id_match set to true to svq_iova_tree_find_iova(=
).
> >>
> > I think you're totally right. But I'd really like to not complicate
> > the API of the iova_tree more.
> >
> > I think we can look for the hwaddr using memory_region_from_host and
> > then get the hwaddr. It is another lookup though...
> Yeah, that will be another means of doing translation without having to
> complicate the API around iova_tree. I wonder how the lookup through
> memory_region_from_host() may perform compared to the iova tree one, the
> former looks to be an O(N) linear search on a linked list while the
> latter would be roughly O(log N) on an AVL tree?

Even worse, as the reverse lookup (from QEMU vaddr to SVQ IOVA) is
linear too. It is not even ordered.

But apart from this detail you're right, I have the same concerns with
this solution too. If we see a hard performance regression we could go
to more complicated solutions, like maintaining a reverse IOVATree in
vhost-iova-tree too. First RFCs of SVQ did that actually.

Thanks!

> Of course,
> memory_region_from_host() won't search out of the guest memory space for
> sure. As this could be on the hot data path I have a little bit
> hesitance over the potential cost or performance regression this change
> could bring in, but maybe I'm overthinking it too much...
>
> Thanks,
> -Siwei
>
> >
> >> Thanks,
> >> -Siwei
> >>>            return false;
> >>>        }
> >>>
>


