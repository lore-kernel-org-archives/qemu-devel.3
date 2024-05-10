Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B87C25B4F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 07:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5KUn-0002LP-H9; Fri, 10 May 2024 03:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s5KUm-0002LA-Ha
 for qemu-devel@nongnu.org; Fri, 10 May 2024 03:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s5KUk-0002S1-86
 for qemu-devel@nongnu.org; Fri, 10 May 2024 03:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715325400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2HZ3ZoKCCd67FoHfGBzLWplhc68ugzyo9gaAc+QGpw=;
 b=aUOO466zscsm/6aXs80yraXf51pQuc2Vp9Z/xpPnJ4peL5d1+uRIUTaMLCR9Gef04AhBCw
 +GBWWQUOIqfWqX6GHUS0KqaJ8JLIDYU0xq3N34stBinGfYskjOJOaTIWCqOkHVis2S8Ew9
 8Q2tGRR7DInrhr+l/Z5Am7LEBKSOOdY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-kCzfb8w1NRO70leFUwp9aw-1; Fri, 10 May 2024 03:16:39 -0400
X-MC-Unique: kCzfb8w1NRO70leFUwp9aw-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-de54ccab44aso3162433276.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 00:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715325399; x=1715930199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2HZ3ZoKCCd67FoHfGBzLWplhc68ugzyo9gaAc+QGpw=;
 b=v0fJvKWc9WhqUeyGGvYkLHJBjkoMN2hFcSsmxpTuURb4bPQff0AlTQSLbKm8dH3jRZ
 eB4CQqhM/Ep5ut7v47D/wMGTDq/GgEikwdbbjk8kN8pdNAu9zPn1K7RtffWpuFXgp5Zp
 HprX+My4E+s4EuKw2tTeV/T4Grk6gqWvpwWszbciPi7RpGLAiDPukmMab0FaUSslAW+C
 WDtRTxazXG9Q3KGIoWn+Ico/qn/ULIH2XuUspCG1wyrnX9UO2CushigARj2sqdqHFcdw
 ZylSScPnwyZBJc3tBvGC8djnbQzEj/j54s0OJXI7NuM6BSesR7jRk+avfRDa4QrDPgdr
 pfpg==
X-Gm-Message-State: AOJu0YyVy5JA/oxgnJ46II8uUIPShH+Rj+5Z4V1qi5BoehkZTAvRqTsE
 wD3pE49ktkT8C1hRHuaOl5LCqETvGoZHngPI/Q8SG4S+rY2cnS4kW2ZGwK7oZ3eCXS40o1IEbD6
 YEelcn3dwJnmr7s0Z97uteiwQ7lE19CNtLYjHCdlzPQjw/sIQiV3th68ZzmLm8ZcVO0/OIB9cxg
 SK6S/K1pIr3sVdrUQG4bGyFQ64hH4=
X-Received: by 2002:a25:ef49:0:b0:deb:438a:43bf with SMTP id
 3f1490d57ef6-dee4f30de54mr1905369276.11.1715325398660; 
 Fri, 10 May 2024 00:16:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgKAu9rTj3BYUfoYfTdNeVBdgEJedeTuN/7Vkye69fYOiyM6iMINBJku61hemTHtqx5llDCTeyb+mF+fh3NgI=
X-Received: by 2002:a25:ef49:0:b0:deb:438a:43bf with SMTP id
 3f1490d57ef6-dee4f30de54mr1905350276.11.1715325398221; Fri, 10 May 2024
 00:16:38 -0700 (PDT)
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
In-Reply-To: <CACGkMEv7wukFdXrA--DzA7U7VYWQq6UAVmi-0=pTAOuJ1nc_7Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 10 May 2024 09:16:01 +0200
Message-ID: <CAJaqyWdtdfbQi4PrbC-ASRo7dHsT7Nw3dmw66K9D9ZeoqyV=ng@mail.gmail.com>
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

On Fri, May 10, 2024 at 6:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, May 9, 2024 at 3:10=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Thu, May 9, 2024 at 8:27=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Thu, May 9, 2024 at 1:16=E2=80=AFAM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Wed, May 8, 2024 at 4:29=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Tue, May 7, 2024 at 6:57=E2=80=AFPM Eugenio Perez Martin <eper=
ezma@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, May 7, 2024 at 9:29=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Perez Martin
> > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=C3=A9re=
z <eperezma@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > The guest may have overlapped memory regions, where dif=
ferent GPA leads
> > > > > > > > > > to the same HVA.  This causes a problem when overlapped=
 regions
> > > > > > > > > > (different GPA but same translated HVA) exists in the t=
ree, as looking
> > > > > > > > > > them by HVA will return them twice.
> > > > > > > > >
> > > > > > > > > I think I don't understand if there's any side effect for=
 shadow virtqueue?
> > > > > > > > >
> > > > > > > >
> > > > > > > > My bad, I totally forgot to put a reference to where this c=
omes from.
> > > > > > > >
> > > > > > > > Si-Wei found that during initialization this sequences of m=
aps /
> > > > > > > > unmaps happens [1]:
> > > > > > > >
> > > > > > > > HVA                    GPA                IOVA
> > > > > > > > -----------------------------------------------------------=
--------------------------------------------------------------
> > > > > > > > Map
> > > > > > > > [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x10=
00, 0x80000000)
> > > > > > > > [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000=
000)
> > > > > > > > [0x80001000, 0x2000001000)
> > > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000=
)
> > > > > > > > [0x2000001000, 0x2000021000)
> > > > > > > >
> > > > > > > > Unmap
> > > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000=
) [0x1000,
> > > > > > > > 0x20000) ???
> > > > > > > >
> > > > > > > > The third HVA range is contained in the first one, but expo=
sed under a
> > > > > > > > different GVA (aliased). This is not "flattened" by QEMU, a=
s GPA does
> > > > > > > > not overlap, only HVA.
> > > > > > > >
> > > > > > > > At the third chunk unmap, the current algorithm finds the f=
irst chunk,
> > > > > > > > not the second one. This series is the way to tell the diff=
erence at
> > > > > > > > unmap time.
> > > > > > > >
> > > > > > > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-0=
4/msg00079.html
> > > > > > > >
> > > > > > > > Thanks!
> > > > > > >
> > > > > > > Ok, I was wondering if we need to store GPA(GIOVA) to HVA map=
pings in
> > > > > > > the iova tree to solve this issue completely. Then there won'=
t be
> > > > > > > aliasing issues.
> > > > > > >
> > > > > >
> > > > > > I'm ok to explore that route but this has another problem. Both=
 SVQ
> > > > > > vrings and CVQ buffers also need to be addressable by VhostIOVA=
Tree,
> > > > > > and they do not have GPA.
> > > > > >
> > > > > > At this moment vhost_svq_translate_addr is able to handle this
> > > > > > transparently as we translate vaddr to SVQ IOVA. How can we sto=
re
> > > > > > these new entries? Maybe a (hwaddr)-1 GPA to signal it has no G=
PA and
> > > > > > then a list to go through other entries (SVQ vaddr and CVQ buff=
ers).
> > > > >
> > > > > This seems to be tricky.
> > > > >
> > > > > As discussed, it could be another iova tree.
> > > > >
> > > >
> > > > Yes but there are many ways to add another IOVATree. Let me expand =
& recap.
> > > >
> > > > Option 1 is to simply add another iova tree to VhostShadowVirtqueue=
.
> > > > Let's call it gpa_iova_tree, as opposed to the current iova_tree th=
at
> > > > translates from vaddr to SVQ IOVA. To know which one to use is easy=
 at
> > > > adding or removing, like in the memory listener, but how to know at
> > > > vhost_svq_translate_addr?
> > >
> > > Then we won't use virtqueue_pop() at all, we need a SVQ version of
> > > virtqueue_pop() to translate GPA to SVQ IOVA directly?
> > >
> >
> > The problem is not virtqueue_pop, that's out of the
> > vhost_svq_translate_addr. The problem is the need of adding
> > conditionals / complexity in all the callers of
> >
> > > >
> > > > The easiest way for me is to rely on memory_region_from_host(). Whe=
n
> > > > vaddr is from the guest, it returns a valid MemoryRegion. When it i=
s
> > > > not, it returns NULL. I'm not sure if this is a valid use case, it
> > > > just worked in my tests so far.
> > > >
> > > > Now we have the second problem: The GPA values of the regions of th=
e
> > > > two IOVA tree must be unique. We need to be able to find unallocate=
d
> > > > regions in SVQ IOVA. At this moment there is only one IOVATree, so
> > > > this is done easily by vhost_iova_tree_map_alloc. But it is very
> > > > complicated with two trees.
> > >
> > > Would it be simpler if we decouple the IOVA allocator? For example, w=
e
> > > can have a dedicated gtree to track the allocated IOVA ranges. It is
> > > shared by both
> > >
> > > 1) Guest memory (GPA)
> > > 2) SVQ virtqueue and buffers
> > >
> > > And another gtree to track the GPA to IOVA.
> > >
> > > The SVQ code could use either
> > >
> > > 1) one linear mappings that contains both SVQ virtqueue and buffers
> > >
> > > or
> > >
> > > 2) dynamic IOVA allocation/deallocation helpers
> > >
> > > So we don't actually need the third gtree for SVQ HVA -> SVQ IOVA?
> > >
> >
> > That's possible, but that scatters the IOVA handling code instead of
> > keeping it self-contained in VhostIOVATree.
>
> To me, the IOVA range/allocation is orthogonal to how IOVA is used.
>
> An example is the iova allocator in the kernel.
>
> Note that there's an even simpler IOVA "allocator" in NVME passthrough
> code, not sure it is useful here though (haven't had a deep look at
> that).
>

I don't know enough about them to have an opinion. I keep seeing the
drawback of needing to synchronize both allocation & adding in all the
places we want to modify the IOVATree. At this moment, these are the
vhost-vdpa memory listener, the SVQ vring creation and removal, and
net CVQ buffers. But it may be more in the future.

What are the advantages of keeping these separated that justifies
needing to synchronize in all these places, compared with keeping them
synchronized in VhostIOVATree?

Thanks!


