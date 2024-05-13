Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE40C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 09:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6SQu-0003MI-Ld; Mon, 13 May 2024 05:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s6SQp-0003J6-Gy
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s6SQn-0003YF-15
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715594234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4J/opWqMxNs0eFvJZAcJv8FSyVSNSBEyo/QO/4i1WY=;
 b=C0kfkVhW2iX9gWrt7URVmlRggdlsmG8BdV9pNjizJICurhEiMlZr6uwpfCD/aktpPhEX4g
 p9wbI4TzP6itbeudfQsdCziuIkASDaxK9G4Gw71cnvhYCgH/xcVCBMlvo4uK+8yF78TtAC
 NkqNNjgYF3VDgxTKuYyzE972tTUFaSk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-mvaZ_3AtMZCYCCkx2zgXnw-1; Mon, 13 May 2024 05:57:12 -0400
X-MC-Unique: mvaZ_3AtMZCYCCkx2zgXnw-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-de603db5d6aso8293776276.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 02:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715594232; x=1716199032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4J/opWqMxNs0eFvJZAcJv8FSyVSNSBEyo/QO/4i1WY=;
 b=KZv11F3aofBuRwc9L1vXHyJUKAzQ8xx2tnhqcCI9JAMNnOSJ7u0y1W1AMfqjrxn6Sb
 AFHoO9Xr23j+scT6ee+DwaX4DFgs2nphxGrZQmXR73edWQsOdDgTuThfYX9MInjgHM6z
 WDJ76pv/ROfcZovq8ro8rDF/2lfZ1plOAmNjedANcdDdBj8vIEFVGXRX0HHR/SRTAHdC
 B8VEXGSxJQWKNr5I2bFYssEIMb7hPBHklcdyOkXcAMoZrN+chPKUdrD/JCDhNSRmvjoG
 EAFbigA2VNumiQKrDHTl3T9Zroe9zDF0IEDW49jgCvR2iC/yoE31qiqx/CtjTmlQvSKE
 TjNg==
X-Gm-Message-State: AOJu0YxZuSR9ovYVZT0LL0v32mD2qZrsJlzbCmV36aW7XLqCgpA18ABh
 f5Yclzj3TjRL3h6wxe0OTedjTanZoyfrxSFWPE1h1YTAu4SSAgBR7yZtF3KTNeTfEfo76T3b3PI
 O+qP7KWs29TVBrOEjHuRWjU0g/01ptinceb/1wE1z1eT/Xkq8QShgBRkZloU7Thk9aB/BUQRrHi
 CeoWL4fa7+c89Cyk6q0mMxNHppI7s=
X-Received: by 2002:a5b:d06:0:b0:dc7:42b8:2561 with SMTP id
 3f1490d57ef6-dee4f35c0d9mr11365220276.34.1715594232006; 
 Mon, 13 May 2024 02:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqG7ApEEwzRlBzl8/mrml6Sh+eXhmkc5a794zVvzuoqgwdQE6YyXwEgemWEOyU7sydVS9VZfXVkhnNybo7y/o=
X-Received: by 2002:a5b:d06:0:b0:dc7:42b8:2561 with SMTP id
 3f1490d57ef6-dee4f35c0d9mr11365203276.34.1715594231607; Mon, 13 May 2024
 02:57:11 -0700 (PDT)
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
In-Reply-To: <CACGkMEt+TLqpbw2N4m7Ez4edTBztRUxiAt6=NLuFR3c7F7Z_jA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 13 May 2024 11:56:35 +0200
Message-ID: <CAJaqyWc18UeBHeQSoAFF1u1nkjaAfj0Y85pgSHbhV8xxExjcgg@mail.gmail.com>
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Mon, May 13, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, May 13, 2024 at 2:28=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Sat, May 11, 2024 at 6:07=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Fri, May 10, 2024 at 3:16=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Fri, May 10, 2024 at 6:29=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, May 9, 2024 at 3:10=E2=80=AFPM Eugenio Perez Martin <eper=
ezma@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, May 9, 2024 at 8:27=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Thu, May 9, 2024 at 1:16=E2=80=AFAM Eugenio Perez Martin <=
eperezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, May 8, 2024 at 4:29=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, May 7, 2024 at 6:57=E2=80=AFPM Eugenio Perez Mart=
in <eperezma@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, May 7, 2024 at 9:29=E2=80=AFAM Jason Wang <jaso=
wang@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Perez=
 Martin
> > > > > > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang =
<jasowang@redhat.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=
=C3=A9rez <eperezma@redhat.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The guest may have overlapped memory regions, w=
here different GPA leads
> > > > > > > > > > > > > > to the same HVA.  This causes a problem when ov=
erlapped regions
> > > > > > > > > > > > > > (different GPA but same translated HVA) exists =
in the tree, as looking
> > > > > > > > > > > > > > them by HVA will return them twice.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I think I don't understand if there's any side ef=
fect for shadow virtqueue?
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > My bad, I totally forgot to put a reference to wher=
e this comes from.
> > > > > > > > > > > >
> > > > > > > > > > > > Si-Wei found that during initialization this sequen=
ces of maps /
> > > > > > > > > > > > unmaps happens [1]:
> > > > > > > > > > > >
> > > > > > > > > > > > HVA                    GPA                IOVA
> > > > > > > > > > > > ---------------------------------------------------=
----------------------------------------------------------------------
> > > > > > > > > > > > Map
> > > > > > > > > > > > [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x8000000=
0) [0x1000, 0x80000000)
> > > > > > > > > > > > [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0=
x2080000000)
> > > > > > > > > > > > [0x80001000, 0x2000001000)
> > > > > > > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0x=
fedc0000)
> > > > > > > > > > > > [0x2000001000, 0x2000021000)
> > > > > > > > > > > >
> > > > > > > > > > > > Unmap
> > > > > > > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0x=
fedc0000) [0x1000,
> > > > > > > > > > > > 0x20000) ???
> > > > > > > > > > > >
> > > > > > > > > > > > The third HVA range is contained in the first one, =
but exposed under a
> > > > > > > > > > > > different GVA (aliased). This is not "flattened" by=
 QEMU, as GPA does
> > > > > > > > > > > > not overlap, only HVA.
> > > > > > > > > > > >
> > > > > > > > > > > > At the third chunk unmap, the current algorithm fin=
ds the first chunk,
> > > > > > > > > > > > not the second one. This series is the way to tell =
the difference at
> > > > > > > > > > > > unmap time.
> > > > > > > > > > > >
> > > > > > > > > > > > [1] https://lists.nongnu.org/archive/html/qemu-deve=
l/2024-04/msg00079.html
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks!
> > > > > > > > > > >
> > > > > > > > > > > Ok, I was wondering if we need to store GPA(GIOVA) to=
 HVA mappings in
> > > > > > > > > > > the iova tree to solve this issue completely. Then th=
ere won't be
> > > > > > > > > > > aliasing issues.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I'm ok to explore that route but this has another probl=
em. Both SVQ
> > > > > > > > > > vrings and CVQ buffers also need to be addressable by V=
hostIOVATree,
> > > > > > > > > > and they do not have GPA.
> > > > > > > > > >
> > > > > > > > > > At this moment vhost_svq_translate_addr is able to hand=
le this
> > > > > > > > > > transparently as we translate vaddr to SVQ IOVA. How ca=
n we store
> > > > > > > > > > these new entries? Maybe a (hwaddr)-1 GPA to signal it =
has no GPA and
> > > > > > > > > > then a list to go through other entries (SVQ vaddr and =
CVQ buffers).
> > > > > > > > >
> > > > > > > > > This seems to be tricky.
> > > > > > > > >
> > > > > > > > > As discussed, it could be another iova tree.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Yes but there are many ways to add another IOVATree. Let me=
 expand & recap.
> > > > > > > >
> > > > > > > > Option 1 is to simply add another iova tree to VhostShadowV=
irtqueue.
> > > > > > > > Let's call it gpa_iova_tree, as opposed to the current iova=
_tree that
> > > > > > > > translates from vaddr to SVQ IOVA. To know which one to use=
 is easy at
> > > > > > > > adding or removing, like in the memory listener, but how to=
 know at
> > > > > > > > vhost_svq_translate_addr?
> > > > > > >
> > > > > > > Then we won't use virtqueue_pop() at all, we need a SVQ versi=
on of
> > > > > > > virtqueue_pop() to translate GPA to SVQ IOVA directly?
> > > > > > >
> > > > > >
> > > > > > The problem is not virtqueue_pop, that's out of the
> > > > > > vhost_svq_translate_addr. The problem is the need of adding
> > > > > > conditionals / complexity in all the callers of
> > > > > >
> > > > > > > >
> > > > > > > > The easiest way for me is to rely on memory_region_from_hos=
t(). When
> > > > > > > > vaddr is from the guest, it returns a valid MemoryRegion. W=
hen it is
> > > > > > > > not, it returns NULL. I'm not sure if this is a valid use c=
ase, it
> > > > > > > > just worked in my tests so far.
> > > > > > > >
> > > > > > > > Now we have the second problem: The GPA values of the regio=
ns of the
> > > > > > > > two IOVA tree must be unique. We need to be able to find un=
allocated
> > > > > > > > regions in SVQ IOVA. At this moment there is only one IOVAT=
ree, so
> > > > > > > > this is done easily by vhost_iova_tree_map_alloc. But it is=
 very
> > > > > > > > complicated with two trees.
> > > > > > >
> > > > > > > Would it be simpler if we decouple the IOVA allocator? For ex=
ample, we
> > > > > > > can have a dedicated gtree to track the allocated IOVA ranges=
. It is
> > > > > > > shared by both
> > > > > > >
> > > > > > > 1) Guest memory (GPA)
> > > > > > > 2) SVQ virtqueue and buffers
> > > > > > >
> > > > > > > And another gtree to track the GPA to IOVA.
> > > > > > >
> > > > > > > The SVQ code could use either
> > > > > > >
> > > > > > > 1) one linear mappings that contains both SVQ virtqueue and b=
uffers
> > > > > > >
> > > > > > > or
> > > > > > >
> > > > > > > 2) dynamic IOVA allocation/deallocation helpers
> > > > > > >
> > > > > > > So we don't actually need the third gtree for SVQ HVA -> SVQ =
IOVA?
> > > > > > >
> > > > > >
> > > > > > That's possible, but that scatters the IOVA handling code inste=
ad of
> > > > > > keeping it self-contained in VhostIOVATree.
> > > > >
> > > > > To me, the IOVA range/allocation is orthogonal to how IOVA is use=
d.
> > > > >
> > > > > An example is the iova allocator in the kernel.
> > > > >
> > > > > Note that there's an even simpler IOVA "allocator" in NVME passth=
rough
> > > > > code, not sure it is useful here though (haven't had a deep look =
at
> > > > > that).
> > > > >
> > > >
> > > > I don't know enough about them to have an opinion. I keep seeing th=
e
> > > > drawback of needing to synchronize both allocation & adding in all =
the
> > > > places we want to modify the IOVATree. At this moment, these are th=
e
> > > > vhost-vdpa memory listener, the SVQ vring creation and removal, and
> > > > net CVQ buffers. But it may be more in the future.
> > > >
> > > > What are the advantages of keeping these separated that justifies
> > > > needing to synchronize in all these places, compared with keeping t=
hem
> > > > synchronized in VhostIOVATree?
> > >
> > > It doesn't need to be synchronized.
> > >
> > > Assuming guest and SVQ shares IOVA range. IOVA only needs to track
> > > which part of the range has been used.
> > >
> >
> > Not sure if I follow, that is what I mean with "synchronized".
>
> Oh right.
>
> >
> > > This simplifies things, we can store GPA->IOVA mappings and SVQ ->
> > > IOVA mappings separately.
> > >
> >
> > Sorry, I still cannot see the whole picture :).
> >
> > Let's assume we have all the GPA mapped to specific IOVA regions, so
> > we have the first IOVA tree (GPA -> IOVA) filled. Now we enable SVQ
> > because of the migration. How can we know where we can place SVQ
> > vrings without having them synchronized?
>
> Just allocating a new IOVA range for SVQ?
>
> >
> > At this moment we're using a tree. The tree nature of the current SVQ
> > IOVA -> VA makes all nodes ordered so it is more or less easy to look
> > for holes.
>
> Yes, iova allocate could still be implemented via a tree.
>
> >
> > Now your proposal uses the SVQ IOVA as tree values. Should we iterate
> > over all of them, order them, of the two trees, and then look for
> > holes there?
>
> Let me clarify, correct me if I was wrong:
>
> 1) IOVA allocator is still implemented via a tree, we just don't need
> to store how the IOVA is used
> 2) A dedicated GPA -> IOVA tree, updated via listeners and is used in
> the datapath SVQ translation
> 3) A linear mapping or another SVQ -> IOVA tree used for SVQ
>

Ok, so the part I was missing is that now we have 3 whole trees, with
somehow redundant information :).

In some sense this is simpler than trying to get all the information
from only two trees. On the bad side, all SVQ calls that allocate some
region need to remember to add to one of the two other threes. That is
what I mean by synchronized. But sure, we can go that way.

> Thanks
>
> >
> > > Thanks
> > >
> > > >
> > > > Thanks!
> > > >
> > >
> >
>


