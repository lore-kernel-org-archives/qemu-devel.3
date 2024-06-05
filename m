Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D0FC27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 16:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEtwy-0006m1-7B; Wed, 05 Jun 2024 12:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sEtww-0006lI-RG
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:57:22 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sEtwu-0005jh-KO
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:57:22 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5b96a95c5e8so123268eaf.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717606639; x=1718211439; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UjvY7Onsf/Z+jhLP59bvpZ1H/2r85T22bcB7ztOxYZs=;
 b=bY81DE+hir7Tp8GMncA/h2i3DPW8JAMDmd3zQ6xpDAqlSDlceUyn50Fl6xtz3uC6KO
 2w/UYGISr5ihTjzu6CrvJG3TIPWKV18OrbZymsEoeYKF8Y3XfCrqinrQTqORCAS2VWfZ
 cBkIHM6oX4I1pnB1G4ftTfIDYd2kcZpny3zTpGHED4I9FWdiKtB1Bh1nyKHLVZ1HqMB5
 1XdFwLH6aBe0YmujpnIy4ptvlQn6z3hVRAOo4YQB2yWSl4fFkGUTXC1yAJqcCGIA56cd
 vbKXEFrqyPv/6TDNuPsVsMbZokqAjOFAtjDbj1k6aPEv5yV7AjtfDwyA6V9Oo+7aybhh
 28UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717606639; x=1718211439;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UjvY7Onsf/Z+jhLP59bvpZ1H/2r85T22bcB7ztOxYZs=;
 b=kBBVMAyoUp+3bL+29zxebKY1mE7iXhxqfe8mJH3+Ragmhjk53FN+ZlJnjTpGqj5t36
 C9Y2iHw20MRxVF1jnMtyUvRaHNinh7UZ8460dTM2pWltvPhwVOqgSJTDRv9YTE0N78Pm
 NNnjT5r9pi7EO3xVv7fd1LP501hgrjak3s0kr8kKdQrXpct3WCQGAXeXbCMtaJ205JyW
 aLMVp6jNxp2Djbq91d5wQzO7OhYkufOiAJ+BzuUqmOmlAtrE1slKWotjxGNmCT9YVtPs
 emIqgyJOqAimsEaAA+PXchpuWIKe/ryP1Li3yxf573AeqYg5xZVWGtkUptc8znmeCtL1
 b/1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoFE8g2buRUKHWx9mbu3Q6cT2EFupvxR/wdJ/g7Z4sV2c/KPkXYJZiTDtmnDwZetgGxyKJ/9UM6ARRktPGA0AAimapP+E=
X-Gm-Message-State: AOJu0YyiCFQPCq7oQItcF6v7YeCRZVVknJglfXFRCBn7/juZi/ZzPnTm
 7mjEC+ja1tx4P1ABtoNCivF3tZ7jkMAp3C5/bmBeHRThmbomC+uEBOy2nn2x6OCOhFvtBgsToWe
 7IPcHRdr+cAXBzWHkoF0spSUzPb27lg==
X-Google-Smtp-Source: AGHT+IHM3HJx6oMvJrEes/wPIqtHqiaO0ZYn4fQmcCH4+I8WisbAS73f1xTMhCOAVF6JTkYtWwdVlpXrplURkwIvpb4=
X-Received: by 2002:a05:6820:2212:b0:5ba:200:852a with SMTP id
 006d021491bc7-5ba79140a8emr3907762eaf.8.1717606638981; Wed, 05 Jun 2024
 09:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240530152223.780232-1-aesteve@redhat.com>
 <20240530152223.780232-2-aesteve@redhat.com>
 <20240604185416.GB90471@fedora.redhat.com>
 <CADSE00+yvsOhiJJg0ePgr7AYVCkjm9xWNj7KpAOFMwj2wuEpGg@mail.gmail.com>
 <20240605142849.GC135899@fedora.redhat.com>
 <CAJSP0QUL8VNsYB-D1gaBoE0nrXAQozELU4fwNqoFy5FC9OiEng@mail.gmail.com>
 <c89da51b-fef4-4c95-bf71-29598e6553df@redhat.com>
In-Reply-To: <c89da51b-fef4-4c95-bf71-29598e6553df@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 5 Jun 2024 12:57:08 -0400
Message-ID: <CAJSP0QUM=d6-YXhKu-mEzYLcRzqK81bPpRVfRCYPGaw8zEN7EQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] vhost-user: add shmem mmap request
To: David Hildenbrand <david@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000949a1b061a277544"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000949a1b061a277544
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024, 12:02 David Hildenbrand <david@redhat.com> wrote:

> On 05.06.24 17:19, Stefan Hajnoczi wrote:
> > On Wed, 5 Jun 2024 at 10:29, Stefan Hajnoczi <stefanha@redhat.com>
> wrote:
> >>
> >> On Wed, Jun 05, 2024 at 10:13:32AM +0200, Albert Esteve wrote:
> >>> On Tue, Jun 4, 2024 at 8:54=E2=80=AFPM Stefan Hajnoczi <stefanha@redh=
at.com>
> wrote:
> >>>
> >>>> On Thu, May 30, 2024 at 05:22:23PM +0200, Albert Esteve wrote:
> >>>>> Add SHMEM_MAP/UNMAP requests to vhost-user.
> >>>>>
> >>>>> This request allows backends to dynamically map
> >>>>> fds into a shared memory region indentified by
> >>>>
> >>>> Please call this "VIRTIO Shared Memory Region" everywhere (code,
> >>>> vhost-user spec, commit description, etc) so it's clear that this is
> not
> >>>> about vhost-user shared memory tables/regions.
> >>>>
> >>>>> its `shmid`. Then, the fd memory is advertised
> >>>>> to the frontend through a BAR+offset, so it can
> >>>>> be read by the driver while its valid.
> >>>>
> >>>> Why is a PCI BAR mentioned here? vhost-user does not know about the
> >>>> VIRTIO Transport (e.g. PCI) being used. It's the frontend's job to
> >>>> report VIRTIO Shared Memory Regions to the driver.
> >>>>
> >>>>
> >>> I will remove PCI BAR, as it is true that it depends on the
> >>> transport. I was trying to explain that the driver
> >>> will use the shm_base + shm_offset to access
> >>> the mapped memory.
> >>>
> >>>
> >>>>>
> >>>>> Then, the backend can munmap the memory range
> >>>>> in a given shared memory region (again, identified
> >>>>> by its `shmid`), to free it. After this, the
> >>>>> region becomes private and shall not be accessed
> >>>>> by the frontend anymore.
> >>>>
> >>>> What does "private" mean?
> >>>>
> >>>> The frontend must mmap PROT_NONE to reserve the virtual memory space
> >>>> when no fd is mapped in the VIRTIO Shared Memory Region. Otherwise a=
n
> >>>> unrelated mmap(NULL, ...) might use that address range and the guest
> >>>> would have access to the host memory! This is a security issue and
> needs
> >>>> to be mentioned explicitly in the spec.
> >>>>
> >>>
> >>> I mentioned private because it changes the mapping from MAP_SHARED
> >>> to MAP_PRIVATE. I will highlight PROT_NONE instead.
> >>
> >> I see. Then "MAP_PRIVATE" would be clearer. I wasn't sure whether you
> >> mean mmap flags or something like the memory range is no longer
> >> accessible to the driver.
> >
> > One more thing: please check whether kvm.ko memory regions need to be
> > modified or split to match the SHMEM_MAP mapping's read/write
> > permissions.
> >
> > The VIRTIO Shared Memory Area pages can have PROT_READ, PROT_WRITE,
> > PROT_READ|PROT_WRITE, or PROT_NONE.
> >
> > kvm.ko memory regions are read/write or read-only. I'm not sure what
> > happens when the guest accesses a kvm.ko memory region containing
> > mappings with permissions more restrictive than its kvm.ko memory
> > region.
>
> IIRC, the KVM R/O memory region requests could allow to further reduce
> permissions (assuming your mmap is R/W you could map it R/O into the KVM
> MMU), but I might remember things incorrectly.
>

I'm thinking about the opposite case where KVM is configured for R/W but
the mmap is more restrictive. This patch series makes this scenario
possible.


>
> > In other words, the kvm.ko memory region would allow the
> > access but the Linux virtual memory configuration would cause a page
> > fault.
> >
> > For example, imagine a QEMU MemoryRegion containing a SHMEM_MAP
> > mapping with PROT_READ. The kvm.ko memory region would be read/write
> > (unless extra steps were taken to tell kvm.ko about the permissions).
> > When the guest stores to the PROT_READ page, kvm.ko will process a
> > fault...and I'm not sure what happens next.
> >
> > A similar scenario occurs when a PROT_NONE mapping exists within a
> > kvm.ko memory region. I don't remember how kvm.ko behaves when the
> > guest tries to access the pages.
> >
> > It's worth figuring this out before going further because it could
> > become tricky if issues are discovered later. I have CCed David
> > Hildenbrand in case he knows.
>
>
> One relevant piece is likely:
>
> "When the KVM_CAP_SYNC_MMU capability is available, changes in the
> backing of the memory region are automatically reflected into the guest.
>   For example, an mmap() that affects the region will be made visible
> immediately. "
>
> We can already effectively get R/O or PROT_NONE PTEs in
> PROT_READ|PROT_WRITE mappings, and the KVM must be able to handle that
> properly -- trigegring a page fault to let core-MM resolve that.
>
> If we have a PROT_NONE VMA and the guest writes to it, we'd likely end
> up (to resolve the KVM MMU page fault) in
> hva_to_pfn_slow()->get_user_pages_unlocked(), which would return -EFAULT.
>
> Not sure if we really inject a page fault into the guest or if the KVM
> run would effectively fail with -EFAULT and make user space unhappy.
> Certainly something to play with!
>

I think KVM probably treats the fault as a misconfiguration that host user
space needs to resolve. There might be no way to inject a page fault into
the guest because the access is allowed according to the guest page tables
and the guest fault handlers aren't prepared to deal with a spurious fault.

Let's see what happens in practice. I think the cleanest solution would be
to create separate kvm.ko memory regions with the appropriate permissions
(i.e. might require creating multiple MemoryRegions inside QEMU for a
single VIRTIO Shared Memory Region when permissions vary between mmaps).

Stefan


> --
> Cheers,
>
> David / dhildenb
>
>

--000000000000949a1b061a277544
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jun 5, 2024, 12:02 David Hildenbrand &lt;<a hr=
ef=3D"mailto:david@redhat.com">david@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 05.06.24 17:19, Stefan Ha=
jnoczi wrote:<br>
&gt; On Wed, 5 Jun 2024 at 10:29, Stefan Hajnoczi &lt;<a href=3D"mailto:ste=
fanha@redhat.com" target=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com<=
/a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Jun 05, 2024 at 10:13:32AM +0200, Albert Esteve wrote:<br>
&gt;&gt;&gt; On Tue, Jun 4, 2024 at 8:54=E2=80=AFPM Stefan Hajnoczi &lt;<a =
href=3D"mailto:stefanha@redhat.com" target=3D"_blank" rel=3D"noreferrer">st=
efanha@redhat.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Thu, May 30, 2024 at 05:22:23PM +0200, Albert Esteve wr=
ote:<br>
&gt;&gt;&gt;&gt;&gt; Add SHMEM_MAP/UNMAP requests to vhost-user.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; This request allows backends to dynamically map<br>
&gt;&gt;&gt;&gt;&gt; fds into a shared memory region indentified by<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Please call this &quot;VIRTIO Shared Memory Region&quot; e=
verywhere (code,<br>
&gt;&gt;&gt;&gt; vhost-user spec, commit description, etc) so it&#39;s clea=
r that this is not<br>
&gt;&gt;&gt;&gt; about vhost-user shared memory tables/regions.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; its `shmid`. Then, the fd memory is advertised<br>
&gt;&gt;&gt;&gt;&gt; to the frontend through a BAR+offset, so it can<br>
&gt;&gt;&gt;&gt;&gt; be read by the driver while its valid.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Why is a PCI BAR mentioned here? vhost-user does not know =
about the<br>
&gt;&gt;&gt;&gt; VIRTIO Transport (e.g. PCI) being used. It&#39;s the front=
end&#39;s job to<br>
&gt;&gt;&gt;&gt; report VIRTIO Shared Memory Regions to the driver.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; I will remove PCI BAR, as it is true that it depends on the<br=
>
&gt;&gt;&gt; transport. I was trying to explain that the driver<br>
&gt;&gt;&gt; will use the shm_base + shm_offset to access<br>
&gt;&gt;&gt; the mapped memory.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Then, the backend can munmap the memory range<br>
&gt;&gt;&gt;&gt;&gt; in a given shared memory region (again, identified<br>
&gt;&gt;&gt;&gt;&gt; by its `shmid`), to free it. After this, the<br>
&gt;&gt;&gt;&gt;&gt; region becomes private and shall not be accessed<br>
&gt;&gt;&gt;&gt;&gt; by the frontend anymore.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; What does &quot;private&quot; mean?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; The frontend must mmap PROT_NONE to reserve the virtual me=
mory space<br>
&gt;&gt;&gt;&gt; when no fd is mapped in the VIRTIO Shared Memory Region. O=
therwise an<br>
&gt;&gt;&gt;&gt; unrelated mmap(NULL, ...) might use that address range and=
 the guest<br>
&gt;&gt;&gt;&gt; would have access to the host memory! This is a security i=
ssue and needs<br>
&gt;&gt;&gt;&gt; to be mentioned explicitly in the spec.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I mentioned private because it changes the mapping from MAP_SH=
ARED<br>
&gt;&gt;&gt; to MAP_PRIVATE. I will highlight PROT_NONE instead.<br>
&gt;&gt;<br>
&gt;&gt; I see. Then &quot;MAP_PRIVATE&quot; would be clearer. I wasn&#39;t=
 sure whether you<br>
&gt;&gt; mean mmap flags or something like the memory range is no longer<br=
>
&gt;&gt; accessible to the driver.<br>
&gt; <br>
&gt; One more thing: please check whether kvm.ko memory regions need to be<=
br>
&gt; modified or split to match the SHMEM_MAP mapping&#39;s read/write<br>
&gt; permissions.<br>
&gt; <br>
&gt; The VIRTIO Shared Memory Area pages can have PROT_READ, PROT_WRITE,<br=
>
&gt; PROT_READ|PROT_WRITE, or PROT_NONE.<br>
&gt; <br>
&gt; kvm.ko memory regions are read/write or read-only. I&#39;m not sure wh=
at<br>
&gt; happens when the guest accesses a kvm.ko memory region containing<br>
&gt; mappings with permissions more restrictive than its kvm.ko memory<br>
&gt; region.<br>
<br>
IIRC, the KVM R/O memory region requests could allow to further reduce <br>
permissions (assuming your mmap is R/W you could map it R/O into the KVM <b=
r>
MMU), but I might remember things incorrectly.<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">I&#39;m thinking about the op=
posite case where KVM is configured for R/W but the mmap is more restrictiv=
e. This patch series makes this scenario possible.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
<br>
&gt; In other words, the kvm.ko memory region would allow the<br>
&gt; access but the Linux virtual memory configuration would cause a page<b=
r>
&gt; fault.<br>
&gt; <br>
&gt; For example, imagine a QEMU MemoryRegion containing a SHMEM_MAP<br>
&gt; mapping with PROT_READ. The kvm.ko memory region would be read/write<b=
r>
&gt; (unless extra steps were taken to tell kvm.ko about the permissions).<=
br>
&gt; When the guest stores to the PROT_READ page, kvm.ko will process a<br>
&gt; fault...and I&#39;m not sure what happens next.<br>
&gt; <br>
&gt; A similar scenario occurs when a PROT_NONE mapping exists within a<br>
&gt; kvm.ko memory region. I don&#39;t remember how kvm.ko behaves when the=
<br>
&gt; guest tries to access the pages.<br>
&gt; <br>
&gt; It&#39;s worth figuring this out before going further because it could=
<br>
&gt; become tricky if issues are discovered later. I have CCed David<br>
&gt; Hildenbrand in case he knows.<br>
<br>
<br>
One relevant piece is likely:<br>
<br>
&quot;When the KVM_CAP_SYNC_MMU capability is available, changes in the <br=
>
backing of the memory region are automatically reflected into the guest. <b=
r>
=C2=A0 For example, an mmap() that affects the region will be made visible =
<br>
immediately. &quot;<br>
<br>
We can already effectively get R/O or PROT_NONE PTEs in <br>
PROT_READ|PROT_WRITE mappings, and the KVM must be able to handle that <br>
properly -- trigegring a page fault to let core-MM resolve that.<br>
<br>
If we have a PROT_NONE VMA and the guest writes to it, we&#39;d likely end =
<br>
up (to resolve the KVM MMU page fault) in <br>
hva_to_pfn_slow()-&gt;get_user_pages_unlocked(), which would return -EFAULT=
.<br>
<br>
Not sure if we really inject a page fault into the guest or if the KVM <br>
run would effectively fail with -EFAULT and make user space unhappy. <br>
Certainly something to play with!<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">I think KVM probably treats the fault as a=
 misconfiguration that host user space needs to resolve. There might be no =
way to inject a page fault into the guest because the access is allowed acc=
ording to the guest page tables and the guest fault handlers aren&#39;t pre=
pared to deal with a spurious fault.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Let&#39;s see what happens in practice. I think the cleanest s=
olution would be to create separate kvm.ko memory regions with the appropri=
ate permissions (i.e. might require creating multiple MemoryRegions inside =
QEMU for a single VIRTIO Shared Memory Region when permissions vary between=
 mmaps).</div><div dir=3D"auto"><br></div><div dir=3D"auto">Stefan</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
Cheers,<br>
<br>
David / dhildenb<br>
<br>
</blockquote></div></div></div>

--000000000000949a1b061a277544--

