Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB72C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FGr-0006JV-Kg; Tue, 07 May 2024 03:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s4FGq-0006J9-NK
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s4FGp-0001E1-4b
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715066990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A93ahfNar1uOKETloUlGrDT9DLnPE9GYJb5I2ezCmlE=;
 b=DYLYsQVFM1rk6FDtlDN1pRLFjmUdIR1oOMnC2xWBzC25nFZxRkpjdADmdn+EU4pCAQgrg4
 m5PKj0MxBSqcAmPWpRubH1zjhrzzSY4CsAcAPGtFFTiWi0IhNBTfH/iDxTM1PzZBiQV9lG
 3oo2n/ir2h+tkxyhIe8h2R+KkoeEy0A=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-P92GaeQvM0qRcccvqR2d9g-1; Tue, 07 May 2024 03:29:48 -0400
X-MC-Unique: P92GaeQvM0qRcccvqR2d9g-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2b294c5ebc1so2367033a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715066987; x=1715671787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A93ahfNar1uOKETloUlGrDT9DLnPE9GYJb5I2ezCmlE=;
 b=ujJTyTBMWLtN91ucdvIml7dJjHYfmN78cI2xEbR6OloEz60VRuVZhMtueIbDUrZdV2
 u5OAD7nkmXjGmjLxMxEevi8Xu0RTd2VNgiDXhwUC/740UTCM4BB/g2emLUa0c/TIP6qS
 E/JY0OpaSKTrd3DfnujeYsqq4HxCfa8Z0C4uNt1JQV1bGQwlXQLR/OxbLsUUVGv/gI9z
 3P/soldbjO9LYAFaexgploV8LHpmZEA278wzH+wk5QnIaMN8NFnxoDnoAQl6Gb402hRb
 5WIuSk1VDCS1CKEwrA7HM6DencHN85ypb5LL1e2XOpc36lQt5flADojtLkfRalXozIBm
 R/zw==
X-Gm-Message-State: AOJu0Yw9qSVHxtpAhnlW8cbXK/v3y2RRrYTShX3F4n6in+ItCvTK9bHg
 UomeCxYnILLTHS7FSn3Gly/ppTn+eFOXy5G2tTDbz6sVRtZSPWT4FqX1mZh4W5nUz4pGakR6MSs
 8LNX6d1bFQpw8MqneoUIfLsWEYS/ubqSJjjhpX66+n3E7FMu3qxFe5oGwiES5CUeC95bx0pkDy4
 Tb8LMuewVqWnBfAcBZOjmW8/PO5OA=
X-Received: by 2002:a17:90a:6fc4:b0:2b2:c278:279a with SMTP id
 e62-20020a17090a6fc400b002b2c278279amr10990846pjk.23.1715066987454; 
 Tue, 07 May 2024 00:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOcGwII0K4zW5efu4+PDvtjtFEKf0QxuyEgS4W9Q/uOgt/6GAYCMo7CiPHfyTT0vUE54D0NVEkBUKrXRXf29s=
X-Received: by 2002:a17:90a:6fc4:b0:2b2:c278:279a with SMTP id
 e62-20020a17090a6fc400b002b2c278279amr10990829pjk.23.1715066987064; Tue, 07
 May 2024 00:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEuJc1ba67Hge+MfpV6npy9KJf84q=uMSP3VYDEA4FiZ=A@mail.gmail.com>
 <CAJaqyWemfoCTLr21ukNszqnqaaEbuB_h+s3R4j-eC_YvHJpEGg@mail.gmail.com>
In-Reply-To: <CAJaqyWemfoCTLr21ukNszqnqaaEbuB_h+s3R4j-eC_YvHJpEGg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 May 2024 15:29:35 +0800
Message-ID: <CACGkMEtZEe=ONRcrmm5TNdcxkJx=p4m24VD0yx5w0u+Rn854hQ@mail.gmail.com>
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > The guest may have overlapped memory regions, where different GPA lea=
ds
> > > to the same HVA.  This causes a problem when overlapped regions
> > > (different GPA but same translated HVA) exists in the tree, as lookin=
g
> > > them by HVA will return them twice.
> >
> > I think I don't understand if there's any side effect for shadow virtqu=
eue?
> >
>
> My bad, I totally forgot to put a reference to where this comes from.
>
> Si-Wei found that during initialization this sequences of maps /
> unmaps happens [1]:
>
> HVA                    GPA                IOVA
> -------------------------------------------------------------------------=
------------------------------------------------
> Map
> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000=
)
> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
> [0x80001000, 0x2000001000)
> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
> [0x2000001000, 0x2000021000)
>
> Unmap
> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
> 0x20000) ???
>
> The third HVA range is contained in the first one, but exposed under a
> different GVA (aliased). This is not "flattened" by QEMU, as GPA does
> not overlap, only HVA.
>
> At the third chunk unmap, the current algorithm finds the first chunk,
> not the second one. This series is the way to tell the difference at
> unmap time.
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.htm=
l
>
> Thanks!

Ok, I was wondering if we need to store GPA(GIOVA) to HVA mappings in
the iova tree to solve this issue completely. Then there won't be
aliasing issues.

Thanks

>
> > Thanks
> >
> > >
> > > To solve this, track GPA in the DMA entry that acs as unique identifi=
ers
> > > to the maps.  When the map needs to be removed, iova tree is able to
> > > find the right one.
> > >
> > > Users that does not go to this extra layer of indirection can use the
> > > iova tree as usual, with id =3D 0.
> > >
> > > This was found by Si-Wei Liu <si-wei.liu@oracle.com>, but I'm having =
a hard
> > > time to reproduce the issue.  This has been tested only without overl=
apping
> > > maps.  If it works with overlapping maps, it will be intergrated in t=
he main
> > > series.
> > >
> > > Comments are welcome.  Thanks!
> > >
> > > Eugenio P=C3=A9rez (2):
> > >   iova_tree: add an id member to DMAMap
> > >   vdpa: identify aliased maps in iova_tree
> > >
> > >  hw/virtio/vhost-vdpa.c   | 2 ++
> > >  include/qemu/iova-tree.h | 5 +++--
> > >  util/iova-tree.c         | 3 ++-
> > >  3 files changed, 7 insertions(+), 3 deletions(-)
> > >
> > > --
> > > 2.44.0
> > >
> >
>


