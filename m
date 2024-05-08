Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F30C10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 02:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4X3t-00016P-Cj; Tue, 07 May 2024 22:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s4X3r-000163-K1
 for qemu-devel@nongnu.org; Tue, 07 May 2024 22:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s4X3p-0000ji-IG
 for qemu-devel@nongnu.org; Tue, 07 May 2024 22:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715135376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LwmFdjSCa5cbXp4/HLTS8den1l1CUjTzKQ78ko4Pso=;
 b=E/XFYwbxjUn2AaPV5EadgJtEdkCkijShf0DR1ol6FE2hf475xWqIyvURWijkEC+FOpQYnv
 c77Qt5vJ1oEAeZDV6IEY5/+wF0nA+Y0OHoXiWTW4+f98qSmClfxtrsNnVoMKI+7myVmp2R
 IqOR1V5ezweZ8mqnuCv4gq8Tffjx3iI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-R87SIgOoNFuKnRcu_aITeQ-1; Tue, 07 May 2024 22:29:34 -0400
X-MC-Unique: R87SIgOoNFuKnRcu_aITeQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2b38f3e2919so317190a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 19:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715135373; x=1715740173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LwmFdjSCa5cbXp4/HLTS8den1l1CUjTzKQ78ko4Pso=;
 b=OvW60qGoATHG8GD5rzdIT1oSFQA1+XrNQ+ZqwgFzvDXBlRRL0pRjKr4vIktAD/N5CH
 8OUtWjjD3y1wKEFQdOTZDDk7SVN6mS0Tpm1ardh5L9r+bdNEhIyqULrbG2cZ7ht1CQTH
 IV5cYbj2EQDowZvQO9opFT2Fk3Ggo6S0GuUd1J6tp2bwL0Vv/sW80OlxDs2KsdtZd5I0
 Wy0aAL1YMRJ9ChUB2al+t9hpDcJD/0Wz3sRDXgc9ulPKJMDxJZmUZlbqSXttzgD+y08T
 Lf8KxGCt1TrSvQrsQ7ch270gz1GrIMdmgtb+yx5MCheb/3pin8zefOF4ojnTkEROcsuQ
 cPmw==
X-Gm-Message-State: AOJu0YykACqzfBN5h6NdbSu1GGgGuR0lkNjy+dHo7ZW1Z0uGKDH2uTCb
 O7ZGYmD4+iNWHKgCHCZBOyfZqEiY01ExYrOeUyhLWX0dlbC/eh5XpKPcoWgCb9Va0JE6Mlqf1nX
 6QuUwFcSBSjxYST5pAKUvRqF99Xo4Vbk4nehq687gwXABVrK+Pt99dtcux+XuWd4GXDkn9s9YUG
 s+zaMKQ1kORKMqix0UZbfCYrZ6NOU=
X-Received: by 2002:a17:90a:af86:b0:2b2:da7:2c83 with SMTP id
 98e67ed59e1d1-2b6113790d7mr2242481a91.4.1715135373630; 
 Tue, 07 May 2024 19:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfnWhAEnHYJtXziGNkZYyzAhm76uz1K+B4vmdTlIibFbDalQsxU3wcGMiHOi0c6li6Fo3Psxos0HavpNlPE4Y=
X-Received: by 2002:a17:90a:af86:b0:2b2:da7:2c83 with SMTP id
 98e67ed59e1d1-2b6113790d7mr2242461a91.4.1715135373221; Tue, 07 May 2024
 19:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEuJc1ba67Hge+MfpV6npy9KJf84q=uMSP3VYDEA4FiZ=A@mail.gmail.com>
 <CAJaqyWemfoCTLr21ukNszqnqaaEbuB_h+s3R4j-eC_YvHJpEGg@mail.gmail.com>
 <CACGkMEtZEe=ONRcrmm5TNdcxkJx=p4m24VD0yx5w0u+Rn854hQ@mail.gmail.com>
 <CAJaqyWdoCYFEEQdwZiCxzaX6HuJE-0QWctJ4WBnOd97zDwbPnw@mail.gmail.com>
In-Reply-To: <CAJaqyWdoCYFEEQdwZiCxzaX6HuJE-0QWctJ4WBnOd97zDwbPnw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 May 2024 10:29:22 +0800
Message-ID: <CACGkMEu328ksfMDtJheH+sdTdV4E=pJFEa5Zco2_ecskubCAGg@mail.gmail.com>
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

On Tue, May 7, 2024 at 6:57=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Tue, May 7, 2024 at 9:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > > >
> > > > > The guest may have overlapped memory regions, where different GPA=
 leads
> > > > > to the same HVA.  This causes a problem when overlapped regions
> > > > > (different GPA but same translated HVA) exists in the tree, as lo=
oking
> > > > > them by HVA will return them twice.
> > > >
> > > > I think I don't understand if there's any side effect for shadow vi=
rtqueue?
> > > >
> > >
> > > My bad, I totally forgot to put a reference to where this comes from.
> > >
> > > Si-Wei found that during initialization this sequences of maps /
> > > unmaps happens [1]:
> > >
> > > HVA                    GPA                IOVA
> > > ---------------------------------------------------------------------=
----------------------------------------------------
> > > Map
> > > [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x8000=
0000)
> > > [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
> > > [0x80001000, 0x2000001000)
> > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
> > > [0x2000001000, 0x2000021000)
> > >
> > > Unmap
> > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
> > > 0x20000) ???
> > >
> > > The third HVA range is contained in the first one, but exposed under =
a
> > > different GVA (aliased). This is not "flattened" by QEMU, as GPA does
> > > not overlap, only HVA.
> > >
> > > At the third chunk unmap, the current algorithm finds the first chunk=
,
> > > not the second one. This series is the way to tell the difference at
> > > unmap time.
> > >
> > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079=
.html
> > >
> > > Thanks!
> >
> > Ok, I was wondering if we need to store GPA(GIOVA) to HVA mappings in
> > the iova tree to solve this issue completely. Then there won't be
> > aliasing issues.
> >
>
> I'm ok to explore that route but this has another problem. Both SVQ
> vrings and CVQ buffers also need to be addressable by VhostIOVATree,
> and they do not have GPA.
>
> At this moment vhost_svq_translate_addr is able to handle this
> transparently as we translate vaddr to SVQ IOVA. How can we store
> these new entries? Maybe a (hwaddr)-1 GPA to signal it has no GPA and
> then a list to go through other entries (SVQ vaddr and CVQ buffers).

This seems to be tricky.

As discussed, it could be another iova tree.

Thanks

>
> Thanks!
>
> > Thanks
> >
> > >
> > > > Thanks
> > > >
> > > > >
> > > > > To solve this, track GPA in the DMA entry that acs as unique iden=
tifiers
> > > > > to the maps.  When the map needs to be removed, iova tree is able=
 to
> > > > > find the right one.
> > > > >
> > > > > Users that does not go to this extra layer of indirection can use=
 the
> > > > > iova tree as usual, with id =3D 0.
> > > > >
> > > > > This was found by Si-Wei Liu <si-wei.liu@oracle.com>, but I'm hav=
ing a hard
> > > > > time to reproduce the issue.  This has been tested only without o=
verlapping
> > > > > maps.  If it works with overlapping maps, it will be intergrated =
in the main
> > > > > series.
> > > > >
> > > > > Comments are welcome.  Thanks!
> > > > >
> > > > > Eugenio P=C3=A9rez (2):
> > > > >   iova_tree: add an id member to DMAMap
> > > > >   vdpa: identify aliased maps in iova_tree
> > > > >
> > > > >  hw/virtio/vhost-vdpa.c   | 2 ++
> > > > >  include/qemu/iova-tree.h | 5 +++--
> > > > >  util/iova-tree.c         | 3 ++-
> > > > >  3 files changed, 7 insertions(+), 3 deletions(-)
> > > > >
> > > > > --
> > > > > 2.44.0
> > > > >
> > > >
> > >
> >
>


