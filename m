Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B1DC25B77
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IVk-0000Eu-Ur; Tue, 07 May 2024 06:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s4IVY-0008P2-TQ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s4IVW-0003L5-06
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8Qagox488Vm957MBG5oSH0uX2KDAU9ek+G3vJvqxxU=;
 b=C2lWi1jo+GJvAmcI2gmojTu7ndBDnufez3toRWTbP2RX4V3xadI8LkC7zPGtUn0ln3mprK
 ygjMNBp2fQwwQFY4H0ZSNDo8v1xG0CccMx4XcBRVgkn+EPYRyaNZOZ1Im/TnyYbZRg2QNj
 yfQrs6E1Sh9Omg3FhHQ0tEHKgN0lSw8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-HOsm_DDdMXunt3naG4wKrA-1; Tue, 07 May 2024 06:57:12 -0400
X-MC-Unique: HOsm_DDdMXunt3naG4wKrA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-de8b6847956so7408519276.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079431; x=1715684231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8Qagox488Vm957MBG5oSH0uX2KDAU9ek+G3vJvqxxU=;
 b=X62TznQJfZ3YKg+wGuwtUfWi9SDaIMJrQVPCoY3KbypPdxxXBvvucsajZMomH6o6ad
 pJd6xPw0pJFx8ssXtwVkGTcOtaKsS77ng6Wqy4Rvz7ZSCBU/3ILSfdLEour7/kLvaLlx
 b4qJzXlTGD1DE8gHESrrVH8v6j97mNTMzbcOuHXHCsi5BnGzS2TESdY8pJhnng7WGpau
 YY0AgUb2cH/bteaAXkToGQPNUjGEHJGBjrYfFdl58Dz8sH6I/74ze/Cf2LCJdqGtFimd
 WuRDfBP7zxMBaVZMJU5prHFMO07O9mq86Q3pizWqFZBJESWVEjcYr+g99fz8Iom6uP8j
 L/6A==
X-Gm-Message-State: AOJu0Yy01JFN409UIYF6g2BgmXIkQGrXSbr0WDufjUT4HJ2t6k1fv+Lq
 XEiITbI2faz/J9pUjh8o8MFCU+141GuxXTLwLK5bsehblXJ7fTbhDoNtAKKNYG3sxLT6I0yBt/h
 Uu4hRUZW1G82gMBClUk/uhHO4TmVSvPbLcsQjpPcvqhw7wiBQXNNOuEwRadDQCmda7FTp0UOkGB
 sE6UPzipdEb/sy+oZhCeQqj5JBLgc=
X-Received: by 2002:a25:870a:0:b0:dc7:4265:1e92 with SMTP id
 a10-20020a25870a000000b00dc742651e92mr1496285ybl.23.1715079431498; 
 Tue, 07 May 2024 03:57:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHprgPSHV3mWrcNesE3x3m8DFlRhqNATMxlQr604mEBwG4pWZZ+F1ydoLuAhw5pMj72UkFYOyUX1sALsS0bqfQ=
X-Received: by 2002:a25:870a:0:b0:dc7:4265:1e92 with SMTP id
 a10-20020a25870a000000b00dc742651e92mr1496272ybl.23.1715079431100; Tue, 07
 May 2024 03:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEuJc1ba67Hge+MfpV6npy9KJf84q=uMSP3VYDEA4FiZ=A@mail.gmail.com>
 <CAJaqyWemfoCTLr21ukNszqnqaaEbuB_h+s3R4j-eC_YvHJpEGg@mail.gmail.com>
 <CACGkMEtZEe=ONRcrmm5TNdcxkJx=p4m24VD0yx5w0u+Rn854hQ@mail.gmail.com>
In-Reply-To: <CACGkMEtZEe=ONRcrmm5TNdcxkJx=p4m24VD0yx5w0u+Rn854hQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 7 May 2024 12:56:35 +0200
Message-ID: <CAJaqyWdoCYFEEQdwZiCxzaX6HuJE-0QWctJ4WBnOd97zDwbPnw@mail.gmail.com>
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Tue, May 7, 2024 at 9:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > The guest may have overlapped memory regions, where different GPA l=
eads
> > > > to the same HVA.  This causes a problem when overlapped regions
> > > > (different GPA but same translated HVA) exists in the tree, as look=
ing
> > > > them by HVA will return them twice.
> > >
> > > I think I don't understand if there's any side effect for shadow virt=
queue?
> > >
> >
> > My bad, I totally forgot to put a reference to where this comes from.
> >
> > Si-Wei found that during initialization this sequences of maps /
> > unmaps happens [1]:
> >
> > HVA                    GPA                IOVA
> > -----------------------------------------------------------------------=
--------------------------------------------------
> > Map
> > [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x800000=
00)
> > [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
> > [0x80001000, 0x2000001000)
> > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
> > [0x2000001000, 0x2000021000)
> >
> > Unmap
> > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
> > 0x20000) ???
> >
> > The third HVA range is contained in the first one, but exposed under a
> > different GVA (aliased). This is not "flattened" by QEMU, as GPA does
> > not overlap, only HVA.
> >
> > At the third chunk unmap, the current algorithm finds the first chunk,
> > not the second one. This series is the way to tell the difference at
> > unmap time.
> >
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.h=
tml
> >
> > Thanks!
>
> Ok, I was wondering if we need to store GPA(GIOVA) to HVA mappings in
> the iova tree to solve this issue completely. Then there won't be
> aliasing issues.
>

I'm ok to explore that route but this has another problem. Both SVQ
vrings and CVQ buffers also need to be addressable by VhostIOVATree,
and they do not have GPA.

At this moment vhost_svq_translate_addr is able to handle this
transparently as we translate vaddr to SVQ IOVA. How can we store
these new entries? Maybe a (hwaddr)-1 GPA to signal it has no GPA and
then a list to go through other entries (SVQ vaddr and CVQ buffers).

Thanks!

> Thanks
>
> >
> > > Thanks
> > >
> > > >
> > > > To solve this, track GPA in the DMA entry that acs as unique identi=
fiers
> > > > to the maps.  When the map needs to be removed, iova tree is able t=
o
> > > > find the right one.
> > > >
> > > > Users that does not go to this extra layer of indirection can use t=
he
> > > > iova tree as usual, with id =3D 0.
> > > >
> > > > This was found by Si-Wei Liu <si-wei.liu@oracle.com>, but I'm havin=
g a hard
> > > > time to reproduce the issue.  This has been tested only without ove=
rlapping
> > > > maps.  If it works with overlapping maps, it will be intergrated in=
 the main
> > > > series.
> > > >
> > > > Comments are welcome.  Thanks!
> > > >
> > > > Eugenio P=C3=A9rez (2):
> > > >   iova_tree: add an id member to DMAMap
> > > >   vdpa: identify aliased maps in iova_tree
> > > >
> > > >  hw/virtio/vhost-vdpa.c   | 2 ++
> > > >  include/qemu/iova-tree.h | 5 +++--
> > > >  util/iova-tree.c         | 3 ++-
> > > >  3 files changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > --
> > > > 2.44.0
> > > >
> > >
> >
>


