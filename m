Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276E2C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 09:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ65R-0005Kr-3r; Wed, 31 Jul 2024 05:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sZ65P-0005In-7j
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 05:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sZ65M-0000bS-1u
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 05:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722419850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSnlZyLR6WJQnDBBYnoCy/KYIJOW7318lJFu6rlp1q8=;
 b=MN0SYocepRJo+KYksmONflvWTxLWnD0IeN7rxy/wr5sIBfEIyUkkQKSh3Shm6k+RxdjhU8
 K3XOEbYZfjwULb1H/KHargdWDd9nYm9onEPkBTj8GdBs3qOgmZWz8RPdtccbhauksHapdd
 1ZRuwl99cf+4VHcqvcc65bQjgTfd91M=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-KGu7YyHTN3Kf-MGQR97THw-1; Wed, 31 Jul 2024 05:57:27 -0400
X-MC-Unique: KGu7YyHTN3Kf-MGQR97THw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-672bea19dd3so110856017b3.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 02:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722419847; x=1723024647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tSnlZyLR6WJQnDBBYnoCy/KYIJOW7318lJFu6rlp1q8=;
 b=oGzeGDnYd+wRlSg2b2Yphkd7Mj2K8feWBLizkkXfUz7JDWiytZhZRiel0/WNEJunMF
 ZzlyFZ2UN9RTGim/O7VIwVPXnVyJH+uI+wjDPBKh9HlDe8PE3pcuPkCZYe1WGtXCEnOl
 Vd0X+kkpeo7Nc+F0e92kUFuU07fmZNcuzKL88c5s2iAdSyYWSt7kH/LBaktZuVC5RhNg
 q3TYKTxWf+opnBcjUfQI1OhcmMqnD6EgREphhsUsvcETbx/nlR/Az9ICrN3a7t2jspCR
 2P9KHPOSlZlVE21V3XdUEI5k3jf3l4fLI7ApzzJ850mHWOV8j4TcSrCRgSmGiD0wVRcg
 Qglw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTicRXNir+aUgXU2t6txXjOt3I3m5HZfIA/R5BSTyhegVRaBZxDnsgl28YGMW2ICJNB5f5duyIrZavH32aLYEzGmJnASg=
X-Gm-Message-State: AOJu0YxRXeh+Gm86/It74BlOXGwo3kaBx6uyXPQWsc69qi0jofCYVAJq
 tkH+t2r01706uxiVDEGXfHdkyEUTXEwixvnDr3MBdukE5G/BcsA4IC0PSVKPw2n/td4uPg/NK8T
 0invVAoVlnKEiy/IyrhR/zpxEJRQ/W7I190/5KXHZ6s/HzznjFDW6u9E3pvkgBk5bVVo7Nb0uZf
 4Yesujn5n4pjj0bva8Qzv7NQ+vUtc=
X-Received: by 2002:a81:bb45:0:b0:664:f825:93ca with SMTP id
 00721157ae682-67a085165f9mr153426227b3.25.1722419846470; 
 Wed, 31 Jul 2024 02:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAqPwvMhOfK7Y0FEsOm4jOx2HXyzKECNb+1kSFy6RMvjwAIQr8tFM8XQWL+T7IH4kOVI2va7cdIA3x/6Nnh2E=
X-Received: by 2002:a81:bb45:0:b0:664:f825:93ca with SMTP id
 00721157ae682-67a085165f9mr153426037b3.25.1722419846021; Wed, 31 Jul 2024
 02:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEvdBDFvwvqb_7YXqiPd-ax4Xw7e0BLBhCt_uD6-Uf+DgA@mail.gmail.com>
 <CAJaqyWdA_6Mx3mkcobmBjB5NDJt3tyqTJv2JijF0agnnBFxQxw@mail.gmail.com>
 <CACGkMEv7wukFdXrA--DzA7U7VYWQq6UAVmi-0=pTAOuJ1nc_7Q@mail.gmail.com>
 <CAJaqyWdtdfbQi4PrbC-ASRo7dHsT7Nw3dmw66K9D9ZeoqyV=ng@mail.gmail.com>
 <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
 <CAJaqyWeKfVXYj61sgvFrUTpOgy0k-zsLoR4JePEo0Q8XuXYbmA@mail.gmail.com>
 <CACGkMEt+TLqpbw2N4m7Ez4edTBztRUxiAt6=NLuFR3c7F7Z_jA@mail.gmail.com>
 <CAJaqyWc18UeBHeQSoAFF1u1nkjaAfj0Y85pgSHbhV8xxExjcgg@mail.gmail.com>
 <CACGkMEtrPAMb-ZN7AAE8cjEzjZY1Hnm29J7PhUYgwv26=YcdQw@mail.gmail.com>
 <84374c5a-d937-4cb5-aafb-45ad75e2d837@oracle.com>
 <CAJaqyWfekhhG+5Zp4eddpp-2N=SjUL+7zs+YqS5xx6eWxa-PqQ@mail.gmail.com>
 <CACGkMEvYSBZpVG2x6q_viekods+QWrjoCETQcsgnHM+Ng4NWGw@mail.gmail.com>
 <CAJaqyWfm1zjU-eQ-j+GaWMHGt7Dk5nGUCUEA75yCga9sBxu39Q@mail.gmail.com>
 <2b2bf1a7-9ba9-4da9-b220-ce516ac029cc@oracle.com>
In-Reply-To: <2b2bf1a7-9ba9-4da9-b220-ce516ac029cc@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 31 Jul 2024 11:56:49 +0200
Message-ID: <CAJaqyWf-Tcu0RdiWU3m9P07xJ7c33QXwSDH0-D=8u2FHC-=uZA@mail.gmail.com>
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, 
 Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 2:32=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 7/30/24 7:00 AM, Eugenio Perez Martin wrote:
> > On Tue, Jul 30, 2024 at 10:48=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> >>
> >> On Mon, Jul 29, 2024 at 6:05=E2=80=AFPM Eugenio Perez Martin
> >> <eperezma@redhat.com> wrote:
> >>>
> >>> On Wed, Jul 24, 2024 at 7:00=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 5/13/24 11:56 PM, Jason Wang wrote:
> >>>>> On Mon, May 13, 2024 at 5:58=E2=80=AFPM Eugenio Perez Martin
> >>>>> <eperezma@redhat.com> wrote:
> >>>>>>
> >>>>>> On Mon, May 13, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> >>>>>>>
> >>>>>>> On Mon, May 13, 2024 at 2:28=E2=80=AFPM Eugenio Perez Martin
> >>>>>>> <eperezma@redhat.com> wrote:
> >>>>>>>>
> >>>>>>>> On Sat, May 11, 2024 at 6:07=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Fri, May 10, 2024 at 3:16=E2=80=AFPM Eugenio Perez Martin
> >>>>>>>>> <eperezma@redhat.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On Fri, May 10, 2024 at 6:29=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Thu, May 9, 2024 at 3:10=E2=80=AFPM Eugenio Perez Martin <=
eperezma@redhat.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On Thu, May 9, 2024 at 8:27=E2=80=AFAM Jason Wang <jasowang@=
redhat.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On Thu, May 9, 2024 at 1:16=E2=80=AFAM Eugenio Perez Martin=
 <eperezma@redhat.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On Wed, May 8, 2024 at 4:29=E2=80=AFAM Jason Wang <jasowan=
g@redhat.com> wrote:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> On Tue, May 7, 2024 at 6:57=E2=80=AFPM Eugenio Perez Mart=
in <eperezma@redhat.com> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On Tue, May 7, 2024 at 9:29=E2=80=AFAM Jason Wang <jasow=
ang@redhat.com> wrote:
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Perez M=
artin
> >>>>>>>>>>>>>>>>> <eperezma@redhat.com> wrote:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang <ja=
sowang@redhat.com> wrote:
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=C3=
=A9rez <eperezma@redhat.com> wrote:
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> The guest may have overlapped memory regions, where =
different GPA leads
> >>>>>>>>>>>>>>>>>>>> to the same HVA.  This causes a problem when overlap=
ped regions
> >>>>>>>>>>>>>>>>>>>> (different GPA but same translated HVA) exists in th=
e tree, as looking
> >>>>>>>>>>>>>>>>>>>> them by HVA will return them twice.
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> I think I don't understand if there's any side effect=
 for shadow virtqueue?
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> My bad, I totally forgot to put a reference to where t=
his comes from.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Si-Wei found that during initialization this sequences=
 of maps /
> >>>>>>>>>>>>>>>>>> unmaps happens [1]:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> HVA                    GPA                IOVA
> >>>>>>>>>>>>>>>>>> ------------------------------------------------------=
-------------------------------------------------------------------
> >>>>>>>>>>>>>>>>>> Map
> >>>>>>>>>>>>>>>>>> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) =
[0x1000, 0x80000000)
> >>>>>>>>>>>>>>>>>> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x20=
80000000)
> >>>>>>>>>>>>>>>>>> [0x80001000, 0x2000001000)
> >>>>>>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfed=
c0000)
> >>>>>>>>>>>>>>>>>> [0x2000001000, 0x2000021000)
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Unmap
> >>>>>>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfed=
c0000) [0x1000,
> >>>>>>>>>>>>>>>>>> 0x20000) ???
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> The third HVA range is contained in the first one, but=
 exposed under a
> >>>>>>>>>>>>>>>>>> different GVA (aliased). This is not "flattened" by QE=
MU, as GPA does
> >>>>>>>>>>>>>>>>>> not overlap, only HVA.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> At the third chunk unmap, the current algorithm finds =
the first chunk,
> >>>>>>>>>>>>>>>>>> not the second one. This series is the way to tell the=
 difference at
> >>>>>>>>>>>>>>>>>> unmap time.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> [1] https://urldefense.com/v3/__https://lists.nongnu.o=
rg/archive/html/qemu-devel/2024-04/msg00079.html__;!!ACWV5N9M2RV99hQ!MXbGSF=
HVbqRf0rzyWamOdnBLHP0FUh3r3BnTvGe6Mn5VzXTsajVp3BB7VqlklkRCr5aKazC5xxTCScuR_=
BY$
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Thanks!
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Ok, I was wondering if we need to store GPA(GIOVA) to H=
VA mappings in
> >>>>>>>>>>>>>>>>> the iova tree to solve this issue completely. Then ther=
e won't be
> >>>>>>>>>>>>>>>>> aliasing issues.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> I'm ok to explore that route but this has another proble=
m. Both SVQ
> >>>>>>>>>>>>>>>> vrings and CVQ buffers also need to be addressable by Vh=
ostIOVATree,
> >>>>>>>>>>>>>>>> and they do not have GPA.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> At this moment vhost_svq_translate_addr is able to handl=
e this
> >>>>>>>>>>>>>>>> transparently as we translate vaddr to SVQ IOVA. How can=
 we store
> >>>>>>>>>>>>>>>> these new entries? Maybe a (hwaddr)-1 GPA to signal it h=
as no GPA and
> >>>>>>>>>>>>>>>> then a list to go through other entries (SVQ vaddr and C=
VQ buffers).
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> This seems to be tricky.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> As discussed, it could be another iova tree.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Yes but there are many ways to add another IOVATree. Let m=
e expand & recap.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Option 1 is to simply add another iova tree to VhostShadow=
Virtqueue.
> >>>>>>>>>>>>>> Let's call it gpa_iova_tree, as opposed to the current iov=
a_tree that
> >>>>>>>>>>>>>> translates from vaddr to SVQ IOVA. To know which one to us=
e is easy at
> >>>>>>>>>>>>>> adding or removing, like in the memory listener, but how t=
o know at
> >>>>>>>>>>>>>> vhost_svq_translate_addr?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Then we won't use virtqueue_pop() at all, we need a SVQ ver=
sion of
> >>>>>>>>>>>>> virtqueue_pop() to translate GPA to SVQ IOVA directly?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> The problem is not virtqueue_pop, that's out of the
> >>>>>>>>>>>> vhost_svq_translate_addr. The problem is the need of adding
> >>>>>>>>>>>> conditionals / complexity in all the callers of
> >>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> The easiest way for me is to rely on memory_region_from_ho=
st(). When
> >>>>>>>>>>>>>> vaddr is from the guest, it returns a valid MemoryRegion. =
When it is
> >>>>>>>>>>>>>> not, it returns NULL. I'm not sure if this is a valid use =
case, it
> >>>>>>>>>>>>>> just worked in my tests so far.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Now we have the second problem: The GPA values of the regi=
ons of the
> >>>>>>>>>>>>>> two IOVA tree must be unique. We need to be able to find u=
nallocated
> >>>>>>>>>>>>>> regions in SVQ IOVA. At this moment there is only one IOVA=
Tree, so
> >>>>>>>>>>>>>> this is done easily by vhost_iova_tree_map_alloc. But it i=
s very
> >>>>>>>>>>>>>> complicated with two trees.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Would it be simpler if we decouple the IOVA allocator? For =
example, we
> >>>>>>>>>>>>> can have a dedicated gtree to track the allocated IOVA rang=
es. It is
> >>>>>>>>>>>>> shared by both
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> 1) Guest memory (GPA)
> >>>>>>>>>>>>> 2) SVQ virtqueue and buffers
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> And another gtree to track the GPA to IOVA.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The SVQ code could use either
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> 1) one linear mappings that contains both SVQ virtqueue and=
 buffers
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> or
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> 2) dynamic IOVA allocation/deallocation helpers
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> So we don't actually need the third gtree for SVQ HVA -> SV=
Q IOVA?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> That's possible, but that scatters the IOVA handling code in=
stead of
> >>>>>>>>>>>> keeping it self-contained in VhostIOVATree.
> >>>>>>>>>>>
> >>>>>>>>>>> To me, the IOVA range/allocation is orthogonal to how IOVA is=
 used.
> >>>>>>>>>>>
> >>>>>>>>>>> An example is the iova allocator in the kernel.
> >>>>>>>>>>>
> >>>>>>>>>>> Note that there's an even simpler IOVA "allocator" in NVME pa=
ssthrough
> >>>>>>>>>>> code, not sure it is useful here though (haven't had a deep l=
ook at
> >>>>>>>>>>> that).
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I don't know enough about them to have an opinion. I keep seei=
ng the
> >>>>>>>>>> drawback of needing to synchronize both allocation & adding in=
 all the
> >>>>>>>>>> places we want to modify the IOVATree. At this moment, these a=
re the
> >>>>>>>>>> vhost-vdpa memory listener, the SVQ vring creation and removal=
, and
> >>>>>>>>>> net CVQ buffers. But it may be more in the future.
> >>>>>>>>>>
> >>>>>>>>>> What are the advantages of keeping these separated that justif=
ies
> >>>>>>>>>> needing to synchronize in all these places, compared with keep=
ing them
> >>>>>>>>>> synchronized in VhostIOVATree?
> >>>>>>>>>
> >>>>>>>>> It doesn't need to be synchronized.
> >>>>>>>>>
> >>>>>>>>> Assuming guest and SVQ shares IOVA range. IOVA only needs to tr=
ack
> >>>>>>>>> which part of the range has been used.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Not sure if I follow, that is what I mean with "synchronized".
> >>>>>>>
> >>>>>>> Oh right.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> This simplifies things, we can store GPA->IOVA mappings and SVQ=
 ->
> >>>>>>>>> IOVA mappings separately.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Sorry, I still cannot see the whole picture :).
> >>>>>>>>
> >>>>>>>> Let's assume we have all the GPA mapped to specific IOVA regions=
, so
> >>>>>>>> we have the first IOVA tree (GPA -> IOVA) filled. Now we enable =
SVQ
> >>>>>>>> because of the migration. How can we know where we can place SVQ
> >>>>>>>> vrings without having them synchronized?
> >>>>>>>
> >>>>>>> Just allocating a new IOVA range for SVQ?
> >>>>>>>
> >>>>>>>>
> >>>>>>>> At this moment we're using a tree. The tree nature of the curren=
t SVQ
> >>>>>>>> IOVA -> VA makes all nodes ordered so it is more or less easy to=
 look
> >>>>>>>> for holes.
> >>>>>>>
> >>>>>>> Yes, iova allocate could still be implemented via a tree.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Now your proposal uses the SVQ IOVA as tree values. Should we it=
erate
> >>>>>>>> over all of them, order them, of the two trees, and then look fo=
r
> >>>>>>>> holes there?
> >>>>>>>
> >>>>>>> Let me clarify, correct me if I was wrong:
> >>>>>>>
> >>>>>>> 1) IOVA allocator is still implemented via a tree, we just don't =
need
> >>>>>>> to store how the IOVA is used
> >>>>>>> 2) A dedicated GPA -> IOVA tree, updated via listeners and is use=
d in
> >>>>>>> the datapath SVQ translation
> >>>>>>> 3) A linear mapping or another SVQ -> IOVA tree used for SVQ
> >>>>>>>
> >>>>>>
> >>>>>> Ok, so the part I was missing is that now we have 3 whole trees, w=
ith
> >>>>>> somehow redundant information :).
> >>>>>
> >>>>> Somehow, it decouples the IOVA usage out of the IOVA allocator. Thi=
s
> >>>>> might be simple as guests and SVQ may try to share a single IOVA
> >>>>> address space.
> >>>>>
> >>>>
> >>>> I'm working on implementing your three suggestions above but I'm a b=
it
> >>>> confused with some of the wording and I was hoping you could clarify
> >>>> some of it for me when you get the chance.
> >>>>
> >>>> ---
> >>>> For your first suggestion (1) you mention decoupling the IOVA alloca=
tor
> >>>> and "don't need to store how the IOVA is used."
> >>>>
> >>>> By this, do you mean to not save the IOVA->HVA mapping and instead o=
nly
> >>>> save the allocated IOVA ranges?
> >>
> >> Yes.
> >>
> >>>> In other words, are you suggesting to
> >>>> create a dedicated "IOVA->IOVA" tree like:
> >>>>
> >>>> struct VhostIOVATree {
> >>>>       uint64_t iova_first;
> >>>>       uint64_t iova_last;
> >>>>       IOVATree *iova_map;
> >>>> };
> >>
> >> It could be this or other. I think the point is the allocator is only
> >> used for IOVA allocation but it doesn't have any information about the
> >> mapping.
> >>
> >>>>
> >>>> Where the mapping might look something like (where translated_addr i=
s
> >>>> given some kind of 0 value):
> >>>>
> >>>> iova_region =3D (DMAMap) {
> >>>>       .iova =3D iova_first,
> >>>>       .translated_addr =3D 0,
> >>>>       .size =3D region_size - 1,
> >>>>       .perm =3D IOMMU_ACCESS_FLAG(true, section->readonly),
> >>>> };
> >>>>
> >>>> Also, if this is what you mean by decoupling the IOVA allocator, wha=
t
> >>>> happens to the IOVA->HVA tree?
> >>
> >> We will have two structures:
> >>
> >> 1) IOVA domain (in charge of IOVA range allocation/deallocation)
> >> 2) How the IOVA is used, e.g an IOVA->HVA tree
> >>
> >>> Are we no longer saving these mappings in
> >>>> a tree?
> >>>>
> >>>> ---
> >>>> In your second suggestion (2) with a dedicated GPA->IOVA tree, were =
you
> >>>> thinking something like this? Just adding on to VhostIOVATree here:
> >>>>
> >>>> struct VhostIOVATree {
> >>>>       uint64_t iova_first;
> >>>>       uint64_t iova_last;
> >>>>       IOVATree *iova_map;
> >>>>       IOVATree *gpa_map;
> >>>> };
> >>
> >> I'd split the mappings if it's possible.
> >>
> >>>>
> >>>> Where the mapping might look something like:
> >>>>
> >>>> gpa_region =3D (DMAMap) {
> >>>>       .iova =3D iova_first,
> >>>>       .translated_addr =3D gpa_first,
> >>>>       .size =3D region_size - 1,
> >>>>       .perm =3D IOMMU_ACCESS_FLAG(true, section->readonly),
> >>>> };
> >>>>
> >>>> Also, when you say "used in the datapath SVQ translation", we still =
need
> >>>> to build the GPA->IOVA tree when vhost_vdpa_listener_region_add() is
> >>>> called, right?
> >>
> >> Right.
> >>
> >>>>
> >>>> ---
> >>>> Lastly, in your third suggestion (3) you mention implementing a
> >>>> SVQ->IOVA tree, making the total number of IOVATrees/GTrees 3: one f=
or
> >>>> just IOVAs, one for GPA->IOVA, and the last one for SVQ->IOVA. E.g.
> >>>>
> >>>> struct VhostIOVATree {
> >>>>       uint64_t iova_first;
> >>>>       uint64_t iova_last;
> >>>>       IOVATree *iova_map;
> >>>>       IOVATree *gpa_map;
> >>>>       IOVATree *svq_map;
> >>>> };
> >>>>
> >>>> ---
> >>>>
> >>>> Let me know if I'm understanding this correctly. If I am, this would
> >>>> require a pretty good amount of refactoring on the IOVA allocation,
> >>>> searching, destroying, etc. code to account for these new trees.
> >>>>
> >>>
> >>> Ok I think I understand your previous question better, sorry for the =
delay :).
> >>>
> >>> If I'm not wrong, Jason did not enumerate these as alternatives but a=
s
> >>> part of the same solution. Jason please correct me if I'm wrong here.
> >>>
> >>> His solution is composed of three trees:
> >>> 1) One for the IOVA allocations, so we know where to allocate new ran=
ges
> >>> 2) One of the GPA -> SVQ IOVA translations.
> >>> 3) Another one for SVQ vrings translations.
> >>>
> >>
> >> Exactly.
> >>
> >>> In my opinion to use GPA this is problematic as we force all of the
> >>> callers to know if the address we want to translate comes from the
> >>> guest or not. Current code does now know it, as
> >>> vhost_svq_translate_addr is called to translate both buffer dataplane
> >>> addresses and control virtqueue buffers, which are also shadowed.  To
> >>> transmit that information to the caller code would require either
> >>> duplicate functions, to add a boolean, etc, as it is in a different
> >>> layer (net specific net/vhost-vdpa.c vs generic
> >>> hw/virtio/vhost-shadow-virtqueue.c).
> >>>
> >>> In my opinion is easier to keep just two trees (or similar structs):
> >>> 1) One for the IOVA allocations, so we know where to allocate new
> >>> ranges. We don't actually need to store the translations here.
> >>> 2) One for HVA -> SVQ IOVA translations.
> >>>
> >>> This way we can accommodate both SVQ vrings, CVQ buffers, and guest
> >>> memory buffers, all on the second tree, and take care of the HVA
> >>> duplications.
> >>
> >> Probably, but how to take care of HVA duplications (I may miss the
> >> context, sorry)?
> >>
> >
> > What to do with the duplicated HVA is an added problem that deserves
> > more discussion, right. If a duplicated entry gets deleted, the other
> > one should take its place in both trees.
> >
> > Store them in an ordered list and look for replacements on tree
> > deletion maybe? It would be great to locate a similar usage and see
> > what is done there.
> >
>
> Isn't what we're doing here supposed to solve this issue of
> duplicated/overlapping HVA ranges?
>

Yes, let me explain again with the example of Si-Wei [1]:


HVA                    GPA                IOVA
---------------------------------------------------------------------------=
----------------------------------------------
Map
[0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000)
[0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
[0x80001000, 0x2000001000)
[0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
[0x2000001000, 0x2000021000)

Unmap
[0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
0x20000) ???

The third HVA range is contained in the first one, but exposed under a
different GVA (aliased). This is not "flattened" by QEMU, as GPA does
not overlap, only HVA.

In this case we can ignore the third range, as we already have it in
HVA. As it is unmapped first, it is ok to simply ignore it for all the
QEMU run.

Now, what action should we take if the first range, GPA [0x0,
0x80000000), is unmapped first? We should reintroduce the smaller
chunk HVA [0x7f7903ea0000, 0x7f7903ec0000) -> SVQ IOVA [0x2000001000,
0x2000021000) entry in the tree.

Maybe we can trust every case of this will be handled in a stack
fashion and all of this is overthinking, but I'd like to know other's
opinions / thoughts here.

Thanks!

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.html

> >> Thanks
> >>
> >>>
> >>> Thanks!
> >>>
> >>>> Thanks Jason!
> >>>>
> >>>>>>
> >>>>>> In some sense this is simpler than trying to get all the informati=
on
> >>>>>> from only two trees. On the bad side, all SVQ calls that allocate =
some
> >>>>>> region need to remember to add to one of the two other threes. Tha=
t is
> >>>>>> what I mean by synchronized. But sure, we can go that way.
> >>>>>
> >>>>> Just a suggestion, if it turns out to complicate the issue, I'm fin=
e
> >>>>> to go the other way.
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>>>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> Thanks
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Thanks!
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> >
>


