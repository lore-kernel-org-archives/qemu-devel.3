Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FDBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 08:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxjdP-0008St-Up; Fri, 19 Apr 2024 04:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rxjdM-0008SV-Ey
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rxjdK-0003KT-Ex
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713515408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uO/75dY4OO2pU71VawrGz4vHheV1aGlKspLfQqOFlxQ=;
 b=Awl9KTaab/UTwVrEH2cVRoJBPUifqmCWIibZNqSaSlQiNdKLfV79V+VSLWym0W5+huqpd5
 qRYrPjVReBPszshT/eJjbU0lobNBP93wSxWh2eJsRy+LxSJ7a8KLv/stm6eeBAwuWeoM9f
 7wZJLpLbyxldkJRBRBqzd5Kvu9QMPho=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-gzJfcbsjPPufihNo4bjVRg-1; Fri, 19 Apr 2024 04:30:07 -0400
X-MC-Unique: gzJfcbsjPPufihNo4bjVRg-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-de45d36b049so2997561276.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 01:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713515406; x=1714120206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uO/75dY4OO2pU71VawrGz4vHheV1aGlKspLfQqOFlxQ=;
 b=tcjhaKw4JTawVw29hZ8q6gVLhV1cyJNcpmaZ6srgibLzeBhS+dYaj901iSkXAMaKxc
 mQ2eyxWtQc8sarDxMvqjckC7GYnyUmmLuUAsXKFHR2hG2FOwVv6p960Q4Qkuo7IPColE
 0YbSTLVxwnqsO9Zr+8Z6Su3qtMXWlAy92nny/Iznu5bnvVtPfHHdjCEEEbyR0EXDZAYy
 rNgRyv7HpB7XhZfPYeOcLie+/SZj5qmZ+Uy0aYVcfM6wNfGCMHDXKj1a3jNQoN91zu5B
 eMt4P3Juw6RhknpeJzQnwZEiuC2OzqUxZwwZTGSMI7/yx1DkvJpkk0rz2HIiLqlbynbY
 Jr/Q==
X-Gm-Message-State: AOJu0YxysFTWBz3uYnvX4IjpBnbqi8axXemW+ziVvwkcdEHQdqxqeh0X
 JGruMQBrwdo5qe5OkRgyzO6NpbxufT8ZgwjOzYXQkHVAGqO6qZ6xajlw/sf12hIwVzJDe/sd/yb
 0O6AvHoEsm1DPokMd0cZ1SaiGw4gr0edDcuEQNBSxF0ZyT2YaWRAdlh5jW8ITXzkTGSyNDx2Gt2
 hgB0Tv5PMCtmcqZJSocfyuEMdSJzY=
X-Received: by 2002:a5b:74f:0:b0:dcd:b76f:36de with SMTP id
 s15-20020a5b074f000000b00dcdb76f36demr1218206ybq.1.1713515406515; 
 Fri, 19 Apr 2024 01:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/DrjBMhPhBgUP3VVYVTYfKrbBWousaOd8ksAZQS7UbI7S5IoGBJPYQ3A5ndvveT0Y2gVe3ONuMyiQ23MhjXg=
X-Received: by 2002:a5b:74f:0:b0:dcd:b76f:36de with SMTP id
 s15-20020a5b074f000000b00dcdb76f36demr1218190ybq.1.1713515406241; Fri, 19 Apr
 2024 01:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <20240410100345.389462-2-eperezma@redhat.com>
 <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
In-Reply-To: <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 19 Apr 2024 10:29:30 +0200
Message-ID: <CAJaqyWeE3kfgN5Y0=Kj6oCOFwg0H-gQEr4g3TM+3_+5N7mfd=A@mail.gmail.com>
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
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

On Thu, Apr 18, 2024 at 10:46=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
>
>
> On 4/10/2024 3:03 AM, Eugenio P=C3=A9rez wrote:
> > IOVA tree is also used to track the mappings of virtio-net shadow
> > virtqueue.  This mappings may not match with the GPA->HVA ones.
> >
> > This causes a problem when overlapped regions (different GPA but same
> > translated HVA) exists in the tree, as looking them by HVA will return
> > them twice.  To solve this, create an id member so we can assign unique
> > identifiers (GPA) to the maps.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   include/qemu/iova-tree.h | 5 +++--
> >   util/iova-tree.c         | 3 ++-
> >   2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
> > index 2a10a7052e..34ee230e7d 100644
> > --- a/include/qemu/iova-tree.h
> > +++ b/include/qemu/iova-tree.h
> > @@ -36,6 +36,7 @@ typedef struct DMAMap {
> >       hwaddr iova;
> >       hwaddr translated_addr;
> >       hwaddr size;                /* Inclusive */
> > +    uint64_t id;
> >       IOMMUAccessFlags perm;
> >   } QEMU_PACKED DMAMap;
> >   typedef gboolean (*iova_tree_iterator)(DMAMap *map);
> > @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tree, =
const DMAMap *map);
> >    * @map: the mapping to search
> >    *
> >    * Search for a mapping in the iova tree that translated_addr overlap=
s with the
> > - * mapping range specified.  Only the first found mapping will be
> > - * returned.
> > + * mapping range specified and map->id is equal.  Only the first found
> > + * mapping will be returned.
> >    *
> >    * Return: DMAMap pointer if found, or NULL if not found.  Note that
> >    * the returned DMAMap pointer is maintained internally.  User should
> > diff --git a/util/iova-tree.c b/util/iova-tree.c
> > index 536789797e..0863e0a3b8 100644
> > --- a/util/iova-tree.c
> > +++ b/util/iova-tree.c
> > @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(gpoin=
ter key, gpointer value,
> >
> >       needle =3D args->needle;
> >       if (map->translated_addr + map->size < needle->translated_addr ||
> > -        needle->translated_addr + needle->size < map->translated_addr)=
 {
> > +        needle->translated_addr + needle->size < map->translated_addr =
||
> > +        needle->id !=3D map->id) {
>
> It looks this iterator can also be invoked by SVQ from
> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest GPA
> space will be searched on without passing in the ID (GPA), and exact
> match for the same GPA range is not actually needed unlike the mapping
> removal case. Could we create an API variant, for the SVQ lookup case
> specifically? Or alternatively, add a special flag, say skip_id_match to
> DMAMap, and the id match check may look like below:
>
> (!needle->skip_id_match && needle->id !=3D map->id)
>
> I think vhost_svq_translate_addr() could just call the API variant or
> pass DMAmap with skip_id_match set to true to svq_iova_tree_find_iova().
>

I think you're totally right. But I'd really like to not complicate
the API of the iova_tree more.

I think we can look for the hwaddr using memory_region_from_host and
then get the hwaddr. It is another lookup though...

> Thanks,
> -Siwei
> >           return false;
> >       }
> >
>


