Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87EEC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 03:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6jHz-00086G-Ff; Mon, 13 May 2024 23:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s6jHw-00085p-3O
 for qemu-devel@nongnu.org; Mon, 13 May 2024 23:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s6jHs-0001DH-Q5
 for qemu-devel@nongnu.org; Mon, 13 May 2024 23:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715659031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ndD1hwLXqv3cVX2ecAPl5dEG3tbELrEayCwnzrtAyo=;
 b=EEmBYrZZEkE2Jo0ljJwnRsVCFYUygz0JzKKaQ2lOwYBtjeOs6sN/hXj8YWEsFhzcf057L7
 rI+E8ttiHlXqRLLdFJfUulyG3BrSAcEkZ+T1Q9voasfpxv7HBvdCA21XrOl/ac1gCCZsr1
 vVHN/LhGFGluLFOcOXWMN3o0i+3UEPE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-qT0Eaes4MF2WT70lMi2E_Q-1; Mon, 13 May 2024 23:57:04 -0400
X-MC-Unique: qT0Eaes4MF2WT70lMi2E_Q-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6efefc57621so2677918b3a.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 20:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715659023; x=1716263823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ndD1hwLXqv3cVX2ecAPl5dEG3tbELrEayCwnzrtAyo=;
 b=Thmz4pjdgphJLlKfXNwRQK6Ey5+d9HkqOIb1QirecDIpLn+guCe57jcISdk8SXWeYn
 Vi/BQZw1nw8IaOdOaG6QWNAMTXCVXZDJg26e8b8ywISrCbpqwPbU730VpwUm2lr7sE8u
 vY9fpn3BvozjrNK+8Qic4N942e/XDZ3saXKdsnF302j8aAhkDcQQZhnStOLfRjIoZU2N
 p8reWZS/mqLr/8A/hhTPAPgMS2p/Wv4fPNJ0sqP+ECWcb3GCjyGRqVc1a/28Vbg65jit
 AWRw8dJ7c8K+tXsMfpvBgRuSxmkBaKlbdbCpzmdNElG974WX1W9EkoY7eiiQAo75Y5Cg
 HjZg==
X-Gm-Message-State: AOJu0YzfWxsMsHTO+aWnPup0huidZdxp+5IqTNeLIT8Vu8M8eWYxEAvy
 A1wZ0aSzAXORzZGccp6vY56BZqEFHyg6Al1yutwPzDWXMygBqQRF38KwF50/jVKHTuFLKStL/R1
 T1q5TCLGUP7UnjrZIsS15MiTC6plzAEKeXly26rl1m0K1hY0gwef/4IHLNgGAplNMN6Ja3YkpWz
 hZbKv5NbampqL60tW3aB2edc13UyY=
X-Received: by 2002:a05:6a20:9188:b0:1af:d0bc:d13b with SMTP id
 adf61e73a8af0-1afde0e6355mr10117126637.23.1715659023027; 
 Mon, 13 May 2024 20:57:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMNACxzv81gvQpcf2Z3xYre2b5g8K9puM4g18HD/taqChLsSGYfuJ1m/FboX98wVctygFYt8EKYs0GIeMM7AY=
X-Received: by 2002:a05:6a20:9188:b0:1af:d0bc:d13b with SMTP id
 adf61e73a8af0-1afde0e6355mr10117102637.23.1715659022451; Mon, 13 May 2024
 20:57:02 -0700 (PDT)
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
 <CACGkMEt+TLqpbw2N4m7Ez4edTBztRUxiAt6=NLuFR3c7F7Z_jA@mail.gmail.com>
 <CAJaqyWc18UeBHeQSoAFF1u1nkjaAfj0Y85pgSHbhV8xxExjcgg@mail.gmail.com>
In-Reply-To: <CAJaqyWc18UeBHeQSoAFF1u1nkjaAfj0Y85pgSHbhV8xxExjcgg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 May 2024 11:56:51 +0800
Message-ID: <CACGkMEtrPAMb-ZN7AAE8cjEzjZY1Hnm29J7PhUYgwv26=YcdQw@mail.gmail.com>
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

On Mon, May 13, 2024 at 5:58=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, May 13, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, May 13, 2024 at 2:28=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Sat, May 11, 2024 at 6:07=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Fri, May 10, 2024 at 3:16=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Fri, May 10, 2024 at 6:29=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Thu, May 9, 2024 at 3:10=E2=80=AFPM Eugenio Perez Martin <ep=
erezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, May 9, 2024 at 8:27=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, May 9, 2024 at 1:16=E2=80=AFAM Eugenio Perez Martin=
 <eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, May 8, 2024 at 4:29=E2=80=AFAM Jason Wang <jasowa=
ng@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, May 7, 2024 at 6:57=E2=80=AFPM Eugenio Perez Ma=
rtin <eperezma@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, May 7, 2024 at 9:29=E2=80=AFAM Jason Wang <ja=
sowang@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Per=
ez Martin
> > > > > > > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wan=
g <jasowang@redhat.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio=
 P=C3=A9rez <eperezma@redhat.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The guest may have overlapped memory regions,=
 where different GPA leads
> > > > > > > > > > > > > > > to the same HVA.  This causes a problem when =
overlapped regions
> > > > > > > > > > > > > > > (different GPA but same translated HVA) exist=
s in the tree, as looking
> > > > > > > > > > > > > > > them by HVA will return them twice.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I think I don't understand if there's any side =
effect for shadow virtqueue?
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > My bad, I totally forgot to put a reference to wh=
ere this comes from.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Si-Wei found that during initialization this sequ=
ences of maps /
> > > > > > > > > > > > > unmaps happens [1]:
> > > > > > > > > > > > >
> > > > > > > > > > > > > HVA                    GPA                IOVA
> > > > > > > > > > > > > -------------------------------------------------=
------------------------------------------------------------------------
> > > > > > > > > > > > > Map
> > > > > > > > > > > > > [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000=
000) [0x1000, 0x80000000)
> > > > > > > > > > > > > [0x7f7983e00000, 0x7f9903e00000)    [0x100000000,=
 0x2080000000)
> > > > > > > > > > > > > [0x80001000, 0x2000001000)
> > > > > > > > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, =
0xfedc0000)
> > > > > > > > > > > > > [0x2000001000, 0x2000021000)
> > > > > > > > > > > > >
> > > > > > > > > > > > > Unmap
> > > > > > > > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, =
0xfedc0000) [0x1000,
> > > > > > > > > > > > > 0x20000) ???
> > > > > > > > > > > > >
> > > > > > > > > > > > > The third HVA range is contained in the first one=
, but exposed under a
> > > > > > > > > > > > > different GVA (aliased). This is not "flattened" =
by QEMU, as GPA does
> > > > > > > > > > > > > not overlap, only HVA.
> > > > > > > > > > > > >
> > > > > > > > > > > > > At the third chunk unmap, the current algorithm f=
inds the first chunk,
> > > > > > > > > > > > > not the second one. This series is the way to tel=
l the difference at
> > > > > > > > > > > > > unmap time.
> > > > > > > > > > > > >
> > > > > > > > > > > > > [1] https://lists.nongnu.org/archive/html/qemu-de=
vel/2024-04/msg00079.html
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks!
> > > > > > > > > > > >
> > > > > > > > > > > > Ok, I was wondering if we need to store GPA(GIOVA) =
to HVA mappings in
> > > > > > > > > > > > the iova tree to solve this issue completely. Then =
there won't be
> > > > > > > > > > > > aliasing issues.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > I'm ok to explore that route but this has another pro=
blem. Both SVQ
> > > > > > > > > > > vrings and CVQ buffers also need to be addressable by=
 VhostIOVATree,
> > > > > > > > > > > and they do not have GPA.
> > > > > > > > > > >
> > > > > > > > > > > At this moment vhost_svq_translate_addr is able to ha=
ndle this
> > > > > > > > > > > transparently as we translate vaddr to SVQ IOVA. How =
can we store
> > > > > > > > > > > these new entries? Maybe a (hwaddr)-1 GPA to signal i=
t has no GPA and
> > > > > > > > > > > then a list to go through other entries (SVQ vaddr an=
d CVQ buffers).
> > > > > > > > > >
> > > > > > > > > > This seems to be tricky.
> > > > > > > > > >
> > > > > > > > > > As discussed, it could be another iova tree.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Yes but there are many ways to add another IOVATree. Let =
me expand & recap.
> > > > > > > > >
> > > > > > > > > Option 1 is to simply add another iova tree to VhostShado=
wVirtqueue.
> > > > > > > > > Let's call it gpa_iova_tree, as opposed to the current io=
va_tree that
> > > > > > > > > translates from vaddr to SVQ IOVA. To know which one to u=
se is easy at
> > > > > > > > > adding or removing, like in the memory listener, but how =
to know at
> > > > > > > > > vhost_svq_translate_addr?
> > > > > > > >
> > > > > > > > Then we won't use virtqueue_pop() at all, we need a SVQ ver=
sion of
> > > > > > > > virtqueue_pop() to translate GPA to SVQ IOVA directly?
> > > > > > > >
> > > > > > >
> > > > > > > The problem is not virtqueue_pop, that's out of the
> > > > > > > vhost_svq_translate_addr. The problem is the need of adding
> > > > > > > conditionals / complexity in all the callers of
> > > > > > >
> > > > > > > > >
> > > > > > > > > The easiest way for me is to rely on memory_region_from_h=
ost(). When
> > > > > > > > > vaddr is from the guest, it returns a valid MemoryRegion.=
 When it is
> > > > > > > > > not, it returns NULL. I'm not sure if this is a valid use=
 case, it
> > > > > > > > > just worked in my tests so far.
> > > > > > > > >
> > > > > > > > > Now we have the second problem: The GPA values of the reg=
ions of the
> > > > > > > > > two IOVA tree must be unique. We need to be able to find =
unallocated
> > > > > > > > > regions in SVQ IOVA. At this moment there is only one IOV=
ATree, so
> > > > > > > > > this is done easily by vhost_iova_tree_map_alloc. But it =
is very
> > > > > > > > > complicated with two trees.
> > > > > > > >
> > > > > > > > Would it be simpler if we decouple the IOVA allocator? For =
example, we
> > > > > > > > can have a dedicated gtree to track the allocated IOVA rang=
es. It is
> > > > > > > > shared by both
> > > > > > > >
> > > > > > > > 1) Guest memory (GPA)
> > > > > > > > 2) SVQ virtqueue and buffers
> > > > > > > >
> > > > > > > > And another gtree to track the GPA to IOVA.
> > > > > > > >
> > > > > > > > The SVQ code could use either
> > > > > > > >
> > > > > > > > 1) one linear mappings that contains both SVQ virtqueue and=
 buffers
> > > > > > > >
> > > > > > > > or
> > > > > > > >
> > > > > > > > 2) dynamic IOVA allocation/deallocation helpers
> > > > > > > >
> > > > > > > > So we don't actually need the third gtree for SVQ HVA -> SV=
Q IOVA?
> > > > > > > >
> > > > > > >
> > > > > > > That's possible, but that scatters the IOVA handling code ins=
tead of
> > > > > > > keeping it self-contained in VhostIOVATree.
> > > > > >
> > > > > > To me, the IOVA range/allocation is orthogonal to how IOVA is u=
sed.
> > > > > >
> > > > > > An example is the iova allocator in the kernel.
> > > > > >
> > > > > > Note that there's an even simpler IOVA "allocator" in NVME pass=
through
> > > > > > code, not sure it is useful here though (haven't had a deep loo=
k at
> > > > > > that).
> > > > > >
> > > > >
> > > > > I don't know enough about them to have an opinion. I keep seeing =
the
> > > > > drawback of needing to synchronize both allocation & adding in al=
l the
> > > > > places we want to modify the IOVATree. At this moment, these are =
the
> > > > > vhost-vdpa memory listener, the SVQ vring creation and removal, a=
nd
> > > > > net CVQ buffers. But it may be more in the future.
> > > > >
> > > > > What are the advantages of keeping these separated that justifies
> > > > > needing to synchronize in all these places, compared with keeping=
 them
> > > > > synchronized in VhostIOVATree?
> > > >
> > > > It doesn't need to be synchronized.
> > > >
> > > > Assuming guest and SVQ shares IOVA range. IOVA only needs to track
> > > > which part of the range has been used.
> > > >
> > >
> > > Not sure if I follow, that is what I mean with "synchronized".
> >
> > Oh right.
> >
> > >
> > > > This simplifies things, we can store GPA->IOVA mappings and SVQ ->
> > > > IOVA mappings separately.
> > > >
> > >
> > > Sorry, I still cannot see the whole picture :).
> > >
> > > Let's assume we have all the GPA mapped to specific IOVA regions, so
> > > we have the first IOVA tree (GPA -> IOVA) filled. Now we enable SVQ
> > > because of the migration. How can we know where we can place SVQ
> > > vrings without having them synchronized?
> >
> > Just allocating a new IOVA range for SVQ?
> >
> > >
> > > At this moment we're using a tree. The tree nature of the current SVQ
> > > IOVA -> VA makes all nodes ordered so it is more or less easy to look
> > > for holes.
> >
> > Yes, iova allocate could still be implemented via a tree.
> >
> > >
> > > Now your proposal uses the SVQ IOVA as tree values. Should we iterate
> > > over all of them, order them, of the two trees, and then look for
> > > holes there?
> >
> > Let me clarify, correct me if I was wrong:
> >
> > 1) IOVA allocator is still implemented via a tree, we just don't need
> > to store how the IOVA is used
> > 2) A dedicated GPA -> IOVA tree, updated via listeners and is used in
> > the datapath SVQ translation
> > 3) A linear mapping or another SVQ -> IOVA tree used for SVQ
> >
>
> Ok, so the part I was missing is that now we have 3 whole trees, with
> somehow redundant information :).

Somehow, it decouples the IOVA usage out of the IOVA allocator. This
might be simple as guests and SVQ may try to share a single IOVA
address space.

>
> In some sense this is simpler than trying to get all the information
> from only two trees. On the bad side, all SVQ calls that allocate some
> region need to remember to add to one of the two other threes. That is
> what I mean by synchronized. But sure, we can go that way.

Just a suggestion, if it turns out to complicate the issue, I'm fine
to go the other way.

Thanks

>
> > Thanks
> >
> > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks!
> > > > >
> > > >
> > >
> >
>
>


