Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7CDC04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 04:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5dv2-0005Jz-6Z; Sat, 11 May 2024 00:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s5dv0-0005Jp-GA
 for qemu-devel@nongnu.org; Sat, 11 May 2024 00:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s5duw-0007QA-8o
 for qemu-devel@nongnu.org; Sat, 11 May 2024 00:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715400059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPPdCdQmsblOA1KRDSZCGovDPEpe3Hc8jGIhDfW7fxM=;
 b=IDKxtM6CVQcXAbIwI/F/wYCNxZi24TntyIGXL1dWjBC0U9bS6ObIXmweOXXIuVlj1F6SJw
 S4FHpxo/ssykBV2fcTm39JrggBVJTz7GMmq8f+KAeVhBNUc+75Gl3uC502/vOozYDTWrzo
 NZ/rBrkd9eenrqw6Xz6qE48klZydYow=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-D8wvHucLNOaCy19vi-bEJg-1; Sat, 11 May 2024 00:00:52 -0400
X-MC-Unique: D8wvHucLNOaCy19vi-bEJg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-6331e4c809fso2408597a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 21:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715400051; x=1716004851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPPdCdQmsblOA1KRDSZCGovDPEpe3Hc8jGIhDfW7fxM=;
 b=R2s3xRy0xKTVuYjuyrKUP2VRfb1m7gH3MH/OPAtACukQv/GfTjEYOs/sVlTH/zo/Rt
 NLmqDluz4k5XC9BImirK0U+TUXSUbY/f/4XDZQdfDZMh6b9Ho0mwymhfRL9f9VUXYt/X
 wgwXGw49x4K7ghaMy5kMkArjFsYfBintpfu+d7slLUYFzHjUudmpv61k1Pg+CxxafYNF
 3iWgVzq1gZSLZinrmDhJUQL5X5uMzTTOSAbm7ZrZ6AmTLIzC7rpIZxy444l5p/kZ1IhZ
 wwMxIs8bbz62PmqLik3pU6lhcljMJPC/Ws4RIsgofhJCYPm1zsZS7FP9lUr585dZmXEd
 IyLA==
X-Gm-Message-State: AOJu0YwTlYlSb1yHKpQHhzGoHOmhZNqLQCWQE11LvT1eMAu3dMao9C9l
 Tdrn+fWBj9Xfj77srKGA+gHeOjMH+xAmZYEFR+tY02Avb5sgRALD1EDPWNGgtXt7ZU06rQpxDIY
 LgPN9J+2XjEms0OQAECSTite/LOHgu7iJtLs/hA3FXhOoY2xU9GANFrKZPLDflRwLSdwxsEp8iD
 QAxG7uDj+zNiRBr/f2kyAEU0lraG0=
X-Received: by 2002:a05:6a20:9717:b0:1af:ac6c:367f with SMTP id
 adf61e73a8af0-1afde19799emr4364614637.44.1715400050906; 
 Fri, 10 May 2024 21:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYtknOJAucSsEn1fZodFkOREsm8A3qWzdTfjYZ0dtZmHm2fQS0jgO575UXIth3ru9mOEqd2eJKOVTT44qWKfo=
X-Received: by 2002:a05:6a20:9717:b0:1af:ac6c:367f with SMTP id
 adf61e73a8af0-1afde19799emr4364593637.44.1715400050265; Fri, 10 May 2024
 21:00:50 -0700 (PDT)
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
In-Reply-To: <CAJaqyWdtdfbQi4PrbC-ASRo7dHsT7Nw3dmw66K9D9ZeoqyV=ng@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 May 2024 12:00:39 +0800
Message-ID: <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
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
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.586,
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

On Fri, May 10, 2024 at 3:16=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, May 10, 2024 at 6:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, May 9, 2024 at 3:10=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Thu, May 9, 2024 at 8:27=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Thu, May 9, 2024 at 1:16=E2=80=AFAM Eugenio Perez Martin <eperez=
ma@redhat.com> wrote:
> > > > >
> > > > > On Wed, May 8, 2024 at 4:29=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Tue, May 7, 2024 at 6:57=E2=80=AFPM Eugenio Perez Martin <ep=
erezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, May 7, 2024 at 9:29=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Perez Marti=
n
> > > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang <jasow=
ang@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=C3=A9=
rez <eperezma@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > The guest may have overlapped memory regions, where d=
ifferent GPA leads
> > > > > > > > > > > to the same HVA.  This causes a problem when overlapp=
ed regions
> > > > > > > > > > > (different GPA but same translated HVA) exists in the=
 tree, as looking
> > > > > > > > > > > them by HVA will return them twice.
> > > > > > > > > >
> > > > > > > > > > I think I don't understand if there's any side effect f=
or shadow virtqueue?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > My bad, I totally forgot to put a reference to where this=
 comes from.
> > > > > > > > >
> > > > > > > > > Si-Wei found that during initialization this sequences of=
 maps /
> > > > > > > > > unmaps happens [1]:
> > > > > > > > >
> > > > > > > > > HVA                    GPA                IOVA
> > > > > > > > > ---------------------------------------------------------=
----------------------------------------------------------------
> > > > > > > > > Map
> > > > > > > > > [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x=
1000, 0x80000000)
> > > > > > > > > [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x20800=
00000)
> > > > > > > > > [0x80001000, 0x2000001000)
> > > > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc00=
00)
> > > > > > > > > [0x2000001000, 0x2000021000)
> > > > > > > > >
> > > > > > > > > Unmap
> > > > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc00=
00) [0x1000,
> > > > > > > > > 0x20000) ???
> > > > > > > > >
> > > > > > > > > The third HVA range is contained in the first one, but ex=
posed under a
> > > > > > > > > different GVA (aliased). This is not "flattened" by QEMU,=
 as GPA does
> > > > > > > > > not overlap, only HVA.
> > > > > > > > >
> > > > > > > > > At the third chunk unmap, the current algorithm finds the=
 first chunk,
> > > > > > > > > not the second one. This series is the way to tell the di=
fference at
> > > > > > > > > unmap time.
> > > > > > > > >
> > > > > > > > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2024=
-04/msg00079.html
> > > > > > > > >
> > > > > > > > > Thanks!
> > > > > > > >
> > > > > > > > Ok, I was wondering if we need to store GPA(GIOVA) to HVA m=
appings in
> > > > > > > > the iova tree to solve this issue completely. Then there wo=
n't be
> > > > > > > > aliasing issues.
> > > > > > > >
> > > > > > >
> > > > > > > I'm ok to explore that route but this has another problem. Bo=
th SVQ
> > > > > > > vrings and CVQ buffers also need to be addressable by VhostIO=
VATree,
> > > > > > > and they do not have GPA.
> > > > > > >
> > > > > > > At this moment vhost_svq_translate_addr is able to handle thi=
s
> > > > > > > transparently as we translate vaddr to SVQ IOVA. How can we s=
tore
> > > > > > > these new entries? Maybe a (hwaddr)-1 GPA to signal it has no=
 GPA and
> > > > > > > then a list to go through other entries (SVQ vaddr and CVQ bu=
ffers).
> > > > > >
> > > > > > This seems to be tricky.
> > > > > >
> > > > > > As discussed, it could be another iova tree.
> > > > > >
> > > > >
> > > > > Yes but there are many ways to add another IOVATree. Let me expan=
d & recap.
> > > > >
> > > > > Option 1 is to simply add another iova tree to VhostShadowVirtque=
ue.
> > > > > Let's call it gpa_iova_tree, as opposed to the current iova_tree =
that
> > > > > translates from vaddr to SVQ IOVA. To know which one to use is ea=
sy at
> > > > > adding or removing, like in the memory listener, but how to know =
at
> > > > > vhost_svq_translate_addr?
> > > >
> > > > Then we won't use virtqueue_pop() at all, we need a SVQ version of
> > > > virtqueue_pop() to translate GPA to SVQ IOVA directly?
> > > >
> > >
> > > The problem is not virtqueue_pop, that's out of the
> > > vhost_svq_translate_addr. The problem is the need of adding
> > > conditionals / complexity in all the callers of
> > >
> > > > >
> > > > > The easiest way for me is to rely on memory_region_from_host(). W=
hen
> > > > > vaddr is from the guest, it returns a valid MemoryRegion. When it=
 is
> > > > > not, it returns NULL. I'm not sure if this is a valid use case, i=
t
> > > > > just worked in my tests so far.
> > > > >
> > > > > Now we have the second problem: The GPA values of the regions of =
the
> > > > > two IOVA tree must be unique. We need to be able to find unalloca=
ted
> > > > > regions in SVQ IOVA. At this moment there is only one IOVATree, s=
o
> > > > > this is done easily by vhost_iova_tree_map_alloc. But it is very
> > > > > complicated with two trees.
> > > >
> > > > Would it be simpler if we decouple the IOVA allocator? For example,=
 we
> > > > can have a dedicated gtree to track the allocated IOVA ranges. It i=
s
> > > > shared by both
> > > >
> > > > 1) Guest memory (GPA)
> > > > 2) SVQ virtqueue and buffers
> > > >
> > > > And another gtree to track the GPA to IOVA.
> > > >
> > > > The SVQ code could use either
> > > >
> > > > 1) one linear mappings that contains both SVQ virtqueue and buffers
> > > >
> > > > or
> > > >
> > > > 2) dynamic IOVA allocation/deallocation helpers
> > > >
> > > > So we don't actually need the third gtree for SVQ HVA -> SVQ IOVA?
> > > >
> > >
> > > That's possible, but that scatters the IOVA handling code instead of
> > > keeping it self-contained in VhostIOVATree.
> >
> > To me, the IOVA range/allocation is orthogonal to how IOVA is used.
> >
> > An example is the iova allocator in the kernel.
> >
> > Note that there's an even simpler IOVA "allocator" in NVME passthrough
> > code, not sure it is useful here though (haven't had a deep look at
> > that).
> >
>
> I don't know enough about them to have an opinion. I keep seeing the
> drawback of needing to synchronize both allocation & adding in all the
> places we want to modify the IOVATree. At this moment, these are the
> vhost-vdpa memory listener, the SVQ vring creation and removal, and
> net CVQ buffers. But it may be more in the future.
>
> What are the advantages of keeping these separated that justifies
> needing to synchronize in all these places, compared with keeping them
> synchronized in VhostIOVATree?

It doesn't need to be synchronized.

Assuming guest and SVQ shares IOVA range. IOVA only needs to track
which part of the range has been used.

This simplifies things, we can store GPA->IOVA mappings and SVQ ->
IOVA mappings separately.

Thanks

>
> Thanks!
>


