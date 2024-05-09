Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EA7C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 06:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4xG1-0008Go-A1; Thu, 09 May 2024 02:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s4xFs-0008F4-QT
 for qemu-devel@nongnu.org; Thu, 09 May 2024 02:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s4xFq-0004qj-EW
 for qemu-devel@nongnu.org; Thu, 09 May 2024 02:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715236065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNXcriOdrdXNs94LxJuRpSDgpqpk8jyxsBDl7+un8zY=;
 b=TL9s1hI3b1SXM9DzFkHDJuPTmDL7eNwRLaz7MWFTXavNo4wbc2oY76gdhbm9tXvA/y8va+
 10dloYBytvKpNfvPQBm4Kaf7UsxIk20GkWt7FAG5hLB2o9FdWl9/mvp0vkwvIRoKCEsQTy
 2lqzT0/ijogv5hII762BXkfadi6hF7E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-OC7rD7SDN8WxP2k0KZgmiw-1; Thu, 09 May 2024 02:27:43 -0400
X-MC-Unique: OC7rD7SDN8WxP2k0KZgmiw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2b402090778so562700a91.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 23:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715236062; x=1715840862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNXcriOdrdXNs94LxJuRpSDgpqpk8jyxsBDl7+un8zY=;
 b=EjQJ0B8Y454Vt3nMB6ej6TMdkCICc86rs1o82aHlpf7zDKOlmboAaUDLvjtfwisG/n
 8W1/m8nAKAmz+ycyqmhm6Y62Mx1BLG1XSUDUIV8gBaTdvhFir/0YjgtUPGRyIzkzOSXP
 +Euy6m//pNFi3pf9CS8XobooV0L9nSrCV+83JA4uWg0Zs26k5wLjmgLOIi1q9R4uMgNm
 C0mHcymB7zG1c+Tl48OA5RICESWRLBbeX++yjdegwFEYq/GDLH0ePpUq+thST5Tj6T8d
 u7woaB5EFXUGlT3vynRGj7FAznVapP468yrtU4iDPhojMBm3GtHcGH6MHn6oP3IKCfxo
 OPiQ==
X-Gm-Message-State: AOJu0Yy0suZBYb6duARpoutyQq5K07V4e+2v65JYTC1iikUFjHWtLqQ/
 RMBz+o4nL6HgNt8V516m+pq1msW0ZO+d4J8CZ5qxT8vkPeX3GOsusJTmEVbcObAA2JQd7qpgZLN
 tzTiqKXGYYmppi5G/FigR/I1OZzG1U4sb9092TOd1kaBEOCvF2LNqgsfICfL8CrKSB42xeRm9DA
 RP9XxEsR67OKfvGB00Y2T2mZQ1Pms=
X-Received: by 2002:a17:90a:a791:b0:2b4:32ae:4712 with SMTP id
 98e67ed59e1d1-2b6163a27d5mr5381983a91.9.1715236062282; 
 Wed, 08 May 2024 23:27:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHomEUg+3MckOnmiCi9zojVPnKhfnbBBNKPwGyTXAWFbw2Zn2HsMGmkCdDBSqiH/44ho/Ch4nB/mW4gs8ndwM=
X-Received: by 2002:a17:90a:a791:b0:2b4:32ae:4712 with SMTP id
 98e67ed59e1d1-2b6163a27d5mr5381963a91.9.1715236061834; Wed, 08 May 2024
 23:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEuJc1ba67Hge+MfpV6npy9KJf84q=uMSP3VYDEA4FiZ=A@mail.gmail.com>
 <CAJaqyWemfoCTLr21ukNszqnqaaEbuB_h+s3R4j-eC_YvHJpEGg@mail.gmail.com>
 <CACGkMEtZEe=ONRcrmm5TNdcxkJx=p4m24VD0yx5w0u+Rn854hQ@mail.gmail.com>
 <CAJaqyWdoCYFEEQdwZiCxzaX6HuJE-0QWctJ4WBnOd97zDwbPnw@mail.gmail.com>
 <CACGkMEu328ksfMDtJheH+sdTdV4E=pJFEa5Zco2_ecskubCAGg@mail.gmail.com>
 <CAJaqyWdZFUw8H7_2Jw3j9JxLj9+3p53QZg=DF3o4OgWJYC-SaQ@mail.gmail.com>
In-Reply-To: <CAJaqyWdZFUw8H7_2Jw3j9JxLj9+3p53QZg=DF3o4OgWJYC-SaQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 May 2024 14:27:28 +0800
Message-ID: <CACGkMEvdBDFvwvqb_7YXqiPd-ax4Xw7e0BLBhCt_uD6-Uf+DgA@mail.gmail.com>
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
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
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

On Thu, May 9, 2024 at 1:16=E2=80=AFAM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Wed, May 8, 2024 at 4:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Tue, May 7, 2024 at 6:57=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Tue, May 7, 2024 at 9:29=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=C3=A9rez <epe=
rezma@redhat.com> wrote:
> > > > > > >
> > > > > > > The guest may have overlapped memory regions, where different=
 GPA leads
> > > > > > > to the same HVA.  This causes a problem when overlapped regio=
ns
> > > > > > > (different GPA but same translated HVA) exists in the tree, a=
s looking
> > > > > > > them by HVA will return them twice.
> > > > > >
> > > > > > I think I don't understand if there's any side effect for shado=
w virtqueue?
> > > > > >
> > > > >
> > > > > My bad, I totally forgot to put a reference to where this comes f=
rom.
> > > > >
> > > > > Si-Wei found that during initialization this sequences of maps /
> > > > > unmaps happens [1]:
> > > > >
> > > > > HVA                    GPA                IOVA
> > > > > -----------------------------------------------------------------=
--------------------------------------------------------
> > > > > Map
> > > > > [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x=
80000000)
> > > > > [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
> > > > > [0x80001000, 0x2000001000)
> > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
> > > > > [0x2000001000, 0x2000021000)
> > > > >
> > > > > Unmap
> > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1=
000,
> > > > > 0x20000) ???
> > > > >
> > > > > The third HVA range is contained in the first one, but exposed un=
der a
> > > > > different GVA (aliased). This is not "flattened" by QEMU, as GPA =
does
> > > > > not overlap, only HVA.
> > > > >
> > > > > At the third chunk unmap, the current algorithm finds the first c=
hunk,
> > > > > not the second one. This series is the way to tell the difference=
 at
> > > > > unmap time.
> > > > >
> > > > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg0=
0079.html
> > > > >
> > > > > Thanks!
> > > >
> > > > Ok, I was wondering if we need to store GPA(GIOVA) to HVA mappings =
in
> > > > the iova tree to solve this issue completely. Then there won't be
> > > > aliasing issues.
> > > >
> > >
> > > I'm ok to explore that route but this has another problem. Both SVQ
> > > vrings and CVQ buffers also need to be addressable by VhostIOVATree,
> > > and they do not have GPA.
> > >
> > > At this moment vhost_svq_translate_addr is able to handle this
> > > transparently as we translate vaddr to SVQ IOVA. How can we store
> > > these new entries? Maybe a (hwaddr)-1 GPA to signal it has no GPA and
> > > then a list to go through other entries (SVQ vaddr and CVQ buffers).
> >
> > This seems to be tricky.
> >
> > As discussed, it could be another iova tree.
> >
>
> Yes but there are many ways to add another IOVATree. Let me expand & reca=
p.
>
> Option 1 is to simply add another iova tree to VhostShadowVirtqueue.
> Let's call it gpa_iova_tree, as opposed to the current iova_tree that
> translates from vaddr to SVQ IOVA. To know which one to use is easy at
> adding or removing, like in the memory listener, but how to know at
> vhost_svq_translate_addr?

Then we won't use virtqueue_pop() at all, we need a SVQ version of
virtqueue_pop() to translate GPA to SVQ IOVA directly?

>
> The easiest way for me is to rely on memory_region_from_host(). When
> vaddr is from the guest, it returns a valid MemoryRegion. When it is
> not, it returns NULL. I'm not sure if this is a valid use case, it
> just worked in my tests so far.
>
> Now we have the second problem: The GPA values of the regions of the
> two IOVA tree must be unique. We need to be able to find unallocated
> regions in SVQ IOVA. At this moment there is only one IOVATree, so
> this is done easily by vhost_iova_tree_map_alloc. But it is very
> complicated with two trees.

Would it be simpler if we decouple the IOVA allocator? For example, we
can have a dedicated gtree to track the allocated IOVA ranges. It is
shared by both

1) Guest memory (GPA)
2) SVQ virtqueue and buffers

And another gtree to track the GPA to IOVA.

The SVQ code could use either

1) one linear mappings that contains both SVQ virtqueue and buffers

or

2) dynamic IOVA allocation/deallocation helpers

So we don't actually need the third gtree for SVQ HVA -> SVQ IOVA?

>
> Option 2a is to add another IOVATree in VhostIOVATree. I think the
> easiest way is to keep the GPA -> SVQ IOVA in one tree, let's call it
> iova_gpa_map, and the current vaddr -> SVQ IOVA tree in
> iova_taddr_map. This second tree should contain both vaddr memory that
> belongs to the guest and host-only vaddr like vrings and CVQ buffers.
>
> How to pass the GPA to VhostIOVATree API? To add it to DMAMap is
> complicated, as it is shared with intel_iommu. We can add new
> functions to VhostIOVATree that accepts vaddr plus GPA, or maybe it is
> enough with GPA only. It should be functions to add, remove, and
> allocate new entries. But vaddr ones must be kept, because buffers
> might be host-only.
>
> Then the caller can choose which version to call: for adding and
> removing guest memory from the memory listener, the GPA variant.
> Adding SVQ vrings and CVQ buffers should use the current vaddr
> versions. vhost_svq_translate_addr still needs to use
> memory_region_from_host() to know which one to call.

So the idea is, for region_del/region_add use iova_gpa_map? For the
SVQ translation, use the iova_taddr_map?

I suspect we still need to synchronize with those two trees so it
might be still problematic as iova_taddr_map contains the overlapped
regions.

>
> Although I didn't like this approach because it complicates
> VhostIOVATree, I think it is the easier way except for option 4, I'll
> explain later.
>
> This has an extra advantage: currently, the lookup in
> vhost_svq_translate_addr is linear, O(1). This would allow us to use
> the tree properly.

It uses g_tree_foreach() which I guess is not O(1).

>
> Option 2b could be to keep them totally separated. So current
> VhostIOVATree->iova_taddr_map only contains host-only entries, and the
> new iova_gpa_map containst the guest entries. I don't think this case
> adds anything except less memory usage, as the gpa map (which should
> be the fastest) will be the same size. Also, it makes it difficult to
> implement vhost_iova_tree_map_alloc.
>
> Option 3 is to not add new functions but extend the current ones. That
> would require special values of GPA values to indicate no GPA, like
> SVQ vrings. I think option 2a is better, but this may help to keep the
> interface simpler.
>
> Option 4 is what I'm proposing in this RFC. To store the GPA as map id
> so we can tell if the vaddr corresponds to one SVQ IOVA or another.
> Now I'm having trouble retrieving the memory section I see in the
> memory listener. It should not be so difficult but. The main advantage
> is not to duplicate data structs that are already in QEMU, but maybe
> it is not worth the effort.
>
> Going further with this option, we could add a flag to ignore the .id
> member added. But it adds more and more complexity to the API so I
> would prefer option 2a for this.

Thanks

>
> > Thanks
> >
> > >
> > > Thanks!
> > >
> > > > Thanks
> > > >
> > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > To solve this, track GPA in the DMA entry that acs as unique =
identifiers
> > > > > > > to the maps.  When the map needs to be removed, iova tree is =
able to
> > > > > > > find the right one.
> > > > > > >
> > > > > > > Users that does not go to this extra layer of indirection can=
 use the
> > > > > > > iova tree as usual, with id =3D 0.
> > > > > > >
> > > > > > > This was found by Si-Wei Liu <si-wei.liu@oracle.com>, but I'm=
 having a hard
> > > > > > > time to reproduce the issue.  This has been tested only witho=
ut overlapping
> > > > > > > maps.  If it works with overlapping maps, it will be intergra=
ted in the main
> > > > > > > series.
> > > > > > >
> > > > > > > Comments are welcome.  Thanks!
> > > > > > >
> > > > > > > Eugenio P=C3=A9rez (2):
> > > > > > >   iova_tree: add an id member to DMAMap
> > > > > > >   vdpa: identify aliased maps in iova_tree
> > > > > > >
> > > > > > >  hw/virtio/vhost-vdpa.c   | 2 ++
> > > > > > >  include/qemu/iova-tree.h | 5 +++--
> > > > > > >  util/iova-tree.c         | 3 ++-
> > > > > > >  3 files changed, 7 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > --
> > > > > > > 2.44.0
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


