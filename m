Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75BBC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 08:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6R3a-0004q8-2t; Mon, 13 May 2024 04:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s6R3V-0004pc-KX
 for qemu-devel@nongnu.org; Mon, 13 May 2024 04:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s6R3T-00025E-5H
 for qemu-devel@nongnu.org; Mon, 13 May 2024 04:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715588944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQLY+QmdsDODsNMhkF0t1CVP29+1prYlygHhdtrpcEU=;
 b=Dg6v9QRmSk4A3aICVINhhDI3cNZk97stnXro2/6AhKfnCi7Yy1XX3w2KNH6+RWlGruJ7re
 Scqhz7uJFKnAbwnjxHTF3EwH3URwZ1JdEbIZna40zcsusjUu/PQ9qNoVi2KHqPRgoslGbF
 1X0YUXwoMZN0qdVXFm2Le8vMFcsr5Iw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-yqqCH28QNvumAaEu_Lr0_Q-1; Mon, 13 May 2024 04:28:53 -0400
X-MC-Unique: yqqCH28QNvumAaEu_Lr0_Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2b34facb83aso4361443a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 01:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715588932; x=1716193732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQLY+QmdsDODsNMhkF0t1CVP29+1prYlygHhdtrpcEU=;
 b=WeOZw2JHeyAFBi3IaDv5r8ruf99z4ZmmYTyZosyQfHl0NtaxDd5xCycCHoEItZtIs5
 1HLH2C9lLYDByDw+WsoPsVN711Ee/My3t2G7BIvzOPC6U6aRiWeWZ5zMUM+l3mwI8JT0
 2PJH4DjqvtVKYG98QssBm3A8qx6IO1BAjDSSzNKY/x8itErF0Z277RedqLzC7Mk4ObsM
 bHgLdHeFdb+Rf09yOxbVzHq3WO/6rDAG++e2dbgCnI8dZPcfbnPyKZvCrTaf/96hbKUT
 ivqBi95IZYUNzfP6F37SxZg0IiDtG7yKEo/NI1yrY+AnA3NqX3U4TxBznA+6HP8oy/EU
 LuJg==
X-Gm-Message-State: AOJu0YyzSJhCIM1nFFkU0cs3GoHffX3LzCEtEGH8q2s6T+6+AyJNmokg
 jiN7LyJR6nee1Ff5dtS4qnx03uHtxb5EUedNOjrG8/GvfP5X6cHv1q/6bBN9w1GE9Tqz8mUiIxO
 qcb4/6D+/bYeIl1UWCcJKjUafHtvP75Z3JUt5KlG1c9V5Md7hG/sJReiG5tLOTpn38tznTuY7Qb
 bEKo+No40dTaiP2MWnBG7joGDdJaU=
X-Received: by 2002:a17:90b:2305:b0:2b1:782:8827 with SMTP id
 98e67ed59e1d1-2b6cc564325mr7786102a91.20.1715588931619; 
 Mon, 13 May 2024 01:28:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSZW6ZdlMa1knnQP62RLkhBNqL7vRo1pLOcKRcnT2OZPGbVmCKcFj+w+2kZo4vl8I4MYlGp9Mp8bOV1dr4JK8=
X-Received: by 2002:a17:90b:2305:b0:2b1:782:8827 with SMTP id
 98e67ed59e1d1-2b6cc564325mr7786087a91.20.1715588931215; Mon, 13 May 2024
 01:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEuJc1ba67Hge+MfpV6npy9KJf84q=uMSP3VYDEA4FiZ=A@mail.gmail.com>
 <CAJaqyWemfoCTLr21ukNszqnqaaEbuB_h+s3R4j-eC_YvHJpEGg@mail.gmail.com>
 <CACGkMEtZEe=ONRcrmm5TNdcxkJx=p4m24VD0yx5w0u+Rn854hQ@mail.gmail.com>
 <CAJaqyWdoCYFEEQdwZiCxzaX6HuJE-0QWctJ4WBnOd97zDwbPnw@mail.gmail.com>
 <CACGkMEu328ksfMDtJheH+sdTdV4E=pJFEa5Zco2_ecskubCAGg@mail.gmail.com>
 <CAJaqyWdZFUw8H7_2Jw3j9JxLj9+3p53QZg=DF3o4OgWJYC-SaQ@mail.gmail.com>
 <CACGkMEvdBDFvwvqb_7YXqiPd-ax4Xw7e0BLBhCt_uD6-Uf+DgA@mail.gmail.com>
 <CAJaqyWdA_6Mx3mkcobmBjB5NDJt3tyqTJv2JijF0agnnBFxQxw@mail.gmail.com>
 <CACGkMEv7wukFdXrA--DzA7U7VYWQq6UAVmi-0=pTAOuJ1nc_7Q@mail.gmail.com>
 <CAJaqyWdtdfbQi4PrbC-ASRo7dHsT7Nw3dmw66K9D9ZeoqyV=ng@mail.gmail.com>
 <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
 <CAJaqyWeKfVXYj61sgvFrUTpOgy0k-zsLoR4JePEo0Q8XuXYbmA@mail.gmail.com>
In-Reply-To: <CAJaqyWeKfVXYj61sgvFrUTpOgy0k-zsLoR4JePEo0Q8XuXYbmA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 May 2024 16:28:39 +0800
Message-ID: <CACGkMEt+TLqpbw2N4m7Ez4edTBztRUxiAt6=NLuFR3c7F7Z_jA@mail.gmail.com>
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
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Mon, May 13, 2024 at 2:28=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Sat, May 11, 2024 at 6:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, May 10, 2024 at 3:16=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Fri, May 10, 2024 at 6:29=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, May 9, 2024 at 3:10=E2=80=AFPM Eugenio Perez Martin <eperez=
ma@redhat.com> wrote:
> > > > >
> > > > > On Thu, May 9, 2024 at 8:27=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Thu, May 9, 2024 at 1:16=E2=80=AFAM Eugenio Perez Martin <ep=
erezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, May 8, 2024 at 4:29=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, May 7, 2024 at 6:57=E2=80=AFPM Eugenio Perez Martin=
 <eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, May 7, 2024 at 9:29=E2=80=AFAM Jason Wang <jasowa=
ng@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Perez M=
artin
> > > > > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang <j=
asowang@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=
=C3=A9rez <eperezma@redhat.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > The guest may have overlapped memory regions, whe=
re different GPA leads
> > > > > > > > > > > > > to the same HVA.  This causes a problem when over=
lapped regions
> > > > > > > > > > > > > (different GPA but same translated HVA) exists in=
 the tree, as looking
> > > > > > > > > > > > > them by HVA will return them twice.
> > > > > > > > > > > >
> > > > > > > > > > > > I think I don't understand if there's any side effe=
ct for shadow virtqueue?
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > My bad, I totally forgot to put a reference to where =
this comes from.
> > > > > > > > > > >
> > > > > > > > > > > Si-Wei found that during initialization this sequence=
s of maps /
> > > > > > > > > > > unmaps happens [1]:
> > > > > > > > > > >
> > > > > > > > > > > HVA                    GPA                IOVA
> > > > > > > > > > > -----------------------------------------------------=
--------------------------------------------------------------------
> > > > > > > > > > > Map
> > > > > > > > > > > [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000)=
 [0x1000, 0x80000000)
> > > > > > > > > > > [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2=
080000000)
> > > > > > > > > > > [0x80001000, 0x2000001000)
> > > > > > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfe=
dc0000)
> > > > > > > > > > > [0x2000001000, 0x2000021000)
> > > > > > > > > > >
> > > > > > > > > > > Unmap
> > > > > > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfe=
dc0000) [0x1000,
> > > > > > > > > > > 0x20000) ???
> > > > > > > > > > >
> > > > > > > > > > > The third HVA range is contained in the first one, bu=
t exposed under a
> > > > > > > > > > > different GVA (aliased). This is not "flattened" by Q=
EMU, as GPA does
> > > > > > > > > > > not overlap, only HVA.
> > > > > > > > > > >
> > > > > > > > > > > At the third chunk unmap, the current algorithm finds=
 the first chunk,
> > > > > > > > > > > not the second one. This series is the way to tell th=
e difference at
> > > > > > > > > > > unmap time.
> > > > > > > > > > >
> > > > > > > > > > > [1] https://lists.nongnu.org/archive/html/qemu-devel/=
2024-04/msg00079.html
> > > > > > > > > > >
> > > > > > > > > > > Thanks!
> > > > > > > > > >
> > > > > > > > > > Ok, I was wondering if we need to store GPA(GIOVA) to H=
VA mappings in
> > > > > > > > > > the iova tree to solve this issue completely. Then ther=
e won't be
> > > > > > > > > > aliasing issues.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I'm ok to explore that route but this has another problem=
. Both SVQ
> > > > > > > > > vrings and CVQ buffers also need to be addressable by Vho=
stIOVATree,
> > > > > > > > > and they do not have GPA.
> > > > > > > > >
> > > > > > > > > At this moment vhost_svq_translate_addr is able to handle=
 this
> > > > > > > > > transparently as we translate vaddr to SVQ IOVA. How can =
we store
> > > > > > > > > these new entries? Maybe a (hwaddr)-1 GPA to signal it ha=
s no GPA and
> > > > > > > > > then a list to go through other entries (SVQ vaddr and CV=
Q buffers).
> > > > > > > >
> > > > > > > > This seems to be tricky.
> > > > > > > >
> > > > > > > > As discussed, it could be another iova tree.
> > > > > > > >
> > > > > > >
> > > > > > > Yes but there are many ways to add another IOVATree. Let me e=
xpand & recap.
> > > > > > >
> > > > > > > Option 1 is to simply add another iova tree to VhostShadowVir=
tqueue.
> > > > > > > Let's call it gpa_iova_tree, as opposed to the current iova_t=
ree that
> > > > > > > translates from vaddr to SVQ IOVA. To know which one to use i=
s easy at
> > > > > > > adding or removing, like in the memory listener, but how to k=
now at
> > > > > > > vhost_svq_translate_addr?
> > > > > >
> > > > > > Then we won't use virtqueue_pop() at all, we need a SVQ version=
 of
> > > > > > virtqueue_pop() to translate GPA to SVQ IOVA directly?
> > > > > >
> > > > >
> > > > > The problem is not virtqueue_pop, that's out of the
> > > > > vhost_svq_translate_addr. The problem is the need of adding
> > > > > conditionals / complexity in all the callers of
> > > > >
> > > > > > >
> > > > > > > The easiest way for me is to rely on memory_region_from_host(=
). When
> > > > > > > vaddr is from the guest, it returns a valid MemoryRegion. Whe=
n it is
> > > > > > > not, it returns NULL. I'm not sure if this is a valid use cas=
e, it
> > > > > > > just worked in my tests so far.
> > > > > > >
> > > > > > > Now we have the second problem: The GPA values of the regions=
 of the
> > > > > > > two IOVA tree must be unique. We need to be able to find unal=
located
> > > > > > > regions in SVQ IOVA. At this moment there is only one IOVATre=
e, so
> > > > > > > this is done easily by vhost_iova_tree_map_alloc. But it is v=
ery
> > > > > > > complicated with two trees.
> > > > > >
> > > > > > Would it be simpler if we decouple the IOVA allocator? For exam=
ple, we
> > > > > > can have a dedicated gtree to track the allocated IOVA ranges. =
It is
> > > > > > shared by both
> > > > > >
> > > > > > 1) Guest memory (GPA)
> > > > > > 2) SVQ virtqueue and buffers
> > > > > >
> > > > > > And another gtree to track the GPA to IOVA.
> > > > > >
> > > > > > The SVQ code could use either
> > > > > >
> > > > > > 1) one linear mappings that contains both SVQ virtqueue and buf=
fers
> > > > > >
> > > > > > or
> > > > > >
> > > > > > 2) dynamic IOVA allocation/deallocation helpers
> > > > > >
> > > > > > So we don't actually need the third gtree for SVQ HVA -> SVQ IO=
VA?
> > > > > >
> > > > >
> > > > > That's possible, but that scatters the IOVA handling code instead=
 of
> > > > > keeping it self-contained in VhostIOVATree.
> > > >
> > > > To me, the IOVA range/allocation is orthogonal to how IOVA is used.
> > > >
> > > > An example is the iova allocator in the kernel.
> > > >
> > > > Note that there's an even simpler IOVA "allocator" in NVME passthro=
ugh
> > > > code, not sure it is useful here though (haven't had a deep look at
> > > > that).
> > > >
> > >
> > > I don't know enough about them to have an opinion. I keep seeing the
> > > drawback of needing to synchronize both allocation & adding in all th=
e
> > > places we want to modify the IOVATree. At this moment, these are the
> > > vhost-vdpa memory listener, the SVQ vring creation and removal, and
> > > net CVQ buffers. But it may be more in the future.
> > >
> > > What are the advantages of keeping these separated that justifies
> > > needing to synchronize in all these places, compared with keeping the=
m
> > > synchronized in VhostIOVATree?
> >
> > It doesn't need to be synchronized.
> >
> > Assuming guest and SVQ shares IOVA range. IOVA only needs to track
> > which part of the range has been used.
> >
>
> Not sure if I follow, that is what I mean with "synchronized".

Oh right.

>
> > This simplifies things, we can store GPA->IOVA mappings and SVQ ->
> > IOVA mappings separately.
> >
>
> Sorry, I still cannot see the whole picture :).
>
> Let's assume we have all the GPA mapped to specific IOVA regions, so
> we have the first IOVA tree (GPA -> IOVA) filled. Now we enable SVQ
> because of the migration. How can we know where we can place SVQ
> vrings without having them synchronized?

Just allocating a new IOVA range for SVQ?

>
> At this moment we're using a tree. The tree nature of the current SVQ
> IOVA -> VA makes all nodes ordered so it is more or less easy to look
> for holes.

Yes, iova allocate could still be implemented via a tree.

>
> Now your proposal uses the SVQ IOVA as tree values. Should we iterate
> over all of them, order them, of the two trees, and then look for
> holes there?

Let me clarify, correct me if I was wrong:

1) IOVA allocator is still implemented via a tree, we just don't need
to store how the IOVA is used
2) A dedicated GPA -> IOVA tree, updated via listeners and is used in
the datapath SVQ translation
3) A linear mapping or another SVQ -> IOVA tree used for SVQ

Thanks

>
> > Thanks
> >
> > >
> > > Thanks!
> > >
> >
>


