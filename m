Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063A3C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 10:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx2cZ-0002yI-Dm; Wed, 17 Apr 2024 06:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rx2cR-0002y0-Gn
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 06:34:23 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rx2cP-0005ZU-8O
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 06:34:23 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e1bbdb362so6048727a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713350059; x=1713954859; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qm5pBiCcWu2bvI6QpENykFEcaXV2hAay7NCqajzhITQ=;
 b=ZPK1DPjq9mHCmwvviwOp3wG9qO3eocTbbzJ64PKtxtPXBFajm5n4sloAltw12lqArh
 O8zoSVx0v4QPrj9BwIcTcNzndDVIL7IaIqC8gs1WSaEdd9b2R7ABQJMbEVS9DfDvGYw7
 pQxShNh+KpiZYJoD9ANfbkWtOf8poI1Owcn+plm10mUebJnfjqyJKxz1L4cxlKPoLEYX
 eeUPK8GaQGTij1pgBD1pmnTiwRnhELDG/IUqyNaNB2vlonQqPgfbBJiVg7e2YAN0E4V1
 oJVsG48B33WSUpqUIvV7hgGjoN0TIwjs43BqIU3na3n5ysCj/anQ3ogR81EWqn/c6DTl
 Ifdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713350059; x=1713954859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qm5pBiCcWu2bvI6QpENykFEcaXV2hAay7NCqajzhITQ=;
 b=Tzz4440tI82AUao+asKO+bZCxs2he5zlT7Bwj2VsS0Oi3qzJDrVTdWXFVQLyOT+S2D
 JaC/BPlTtJNsYcg9tsRRFtuICsfbk/oZNW8mCaIRQymDcuuP706jTh8jQCzmKc6GDM+x
 qBljrDw7BbcZg/JAlXvhAGteqFYh3lCPz2QQwDQ5EIFY/tJUPmP3wHDAZde1v62gX3wS
 IcuhExVrk01ai75HIAJNEqtKdJ0FL+9/t5bzdYfDCycj+T1wGWnGSr457wAZC/p2JOUl
 CuiQbkiDHky/6KRU81YHOWkyT8NXvkxt/AizrCI6xM15yShCrxFBpA2vutYvvCQoWNg+
 CKEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXONh0CRKsFFG0yySOBKDhThvBnnZCer3OFlW1Jy9CJYKJgbPbe5hezNPmXDKG0nUMHhsMmsCprzYdUPOblj+0A7m6q1fo=
X-Gm-Message-State: AOJu0YwuXtdC6Ago5jMY+c/XpCD0/qbdavvVQwfLogwB3i9BmhG1O1cW
 LpKnTIIH8ZGe8uRZMhxjTJM2zfUJMUoFCY5kMNcKAZbM8CSDf5kpD63Y58ZWh3eEeFAcw9Av3Ju
 b7ECs0fwg3AmboqBEGveCNn4GfYi2In7PtZ0=
X-Google-Smtp-Source: AGHT+IHj3EmPB2DpsvqLsxi4Gsj+dIEl5lGWYAwncV6YbTn1jFTr3UCLWbFzewC0MTayhtblDYUBGf6GgG93m8LOeaY=
X-Received: by 2002:a50:d55e:0:b0:570:2418:3607 with SMTP id
 f30-20020a50d55e000000b0057024183607mr8185797edj.36.1713350058607; Wed, 17
 Apr 2024 03:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-6-vikram.garhwal@amd.com>
 <CAJy5ezpCWkOqthGR1c5Nsfyi_W_yGL_d17Jcp0VckaCEwx9z3Q@mail.gmail.com>
 <Zhbg9alYH1-J9poU@x1n>
 <CAJy5ezpfNGDC4Q=eMcQ-df_xZVYnc-CR5wfn4izW2CT532PbAA@mail.gmail.com>
 <3abfdbdd-ee70-4b61-a652-c7b2490732d6@suse.com> <Zh6fcLzbm4cpknbT@x1n>
In-Reply-To: <Zh6fcLzbm4cpknbT@x1n>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 17 Apr 2024 12:34:06 +0200
Message-ID: <CAJy5ezrJz9TKMjvcBY-=oPkWkbUZG1khTmWa5=JCJQm2-vd7tQ@mail.gmail.com>
Subject: Re: [QEMU][PATCH v3 5/7] memory: add MemoryRegion map and unmap
 callbacks
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, sstabellini@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 16, 2024 at 5:55=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Apr 16, 2024 at 03:28:41PM +0200, J=C3=BCrgen Gro=C3=9F wrote:
> > On 16.04.24 13:32, Edgar E. Iglesias wrote:
> > > On Wed, Apr 10, 2024 at 8:56=E2=80=AFPM Peter Xu <peterx@redhat.com> =
wrote:
> > > >
> > > > On Wed, Apr 10, 2024 at 06:44:38PM +0200, Edgar E. Iglesias wrote:
> > > > > On Tue, Feb 27, 2024 at 11:37=E2=80=AFPM Vikram Garhwal <vikram.g=
arhwal@amd.com>
> > > > > wrote:
> > > > >
> > > > > > From: Juergen Gross <jgross@suse.com>
> > > > > >
> > > > > > In order to support mapping and unmapping guest memory dynamica=
lly to
> > > > > > and from qemu during address_space_[un]map() operations add the=
 map()
> > > > > > and unmap() callbacks to MemoryRegionOps.
> > > > > >
> > > > > > Those will be used e.g. for Xen grant mappings when performing =
guest
> > > > > > I/Os.
> > > > > >
> > > > > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > > > > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> > > > > >
> > > > >
> > > > >
> > > > > Paolo, Peter, David, Phiippe, do you guys have any concerns with =
this patch?
> > > >
> > >
> > > Thanks for your comments Peter,
> > >
> > >
> > > > This introduces a 3rd memory type afaict, neither direct nor !direc=
t.
> > > >
> > > > What happens if someone does address_space_write() to it?  I didn't=
 see it
> > > > covered here..
> > >
> > > You're right, that won't work, the memory needs to be mapped before i=
t
> > > can be used.
> > > At minimum there should be some graceful failure, right now this will=
 crash.
> > >
> > > >
> > > > OTOH, the cover letter didn't mention too much either on the big pi=
cture:
> > > >
> > > > https://lore.kernel.org/all/20240227223501.28475-1-vikram.garhwal@a=
md.com/
> > > >
> > > > I want to have a quick grasp on whether it's justified worthwhile w=
e should
> > > > introduce this complexity to qemu memory core.
> > > >
> > > > Could I request a better cover letter when repost?  It'll be great =
to
> > > > mention things like:
> > >
> > > I'll do that, but also answer inline in the meantime since we should
> > > perhaps change the approach.
> > >
> > > >
> > > >    - what is grant mapping, why it needs to be used, when it can be=
 used (is
> > > >      it only relevant to vIOMMU=3Don)?  Some more information on th=
e high
> > > >      level design using this type or MR would be great.
> > >
> > > https://github.com/xen-project/xen/blob/master/docs/misc/grant-tables=
.txt
> > >
> > > Xen VM's that use QEMU's VirtIO have a QEMU instance running in a sep=
arate VM.
> > >
> > > There's basically two mechanisms for QEMU's Virtio backends to access
> > > the guest's RAM.
> > > 1. Foreign mappings. This gives the VM running QEMU access to the
> > > entire RAM of the guest VM.
> >
> > Additionally it requires qemu to run in dom0, while in general Xen allo=
ws
> > to run backends in less privileged "driver domains", which are usually =
not
> > allowed to perform foreign mappings.
> >
> > > 2. Grant mappings. This allows the guest to dynamically grant and
> > > remove access to pages as needed.
> > > So the VM running QEMU, cannot map guest RAM unless it's been
> > > instructed to do so by the guest.
> > >
> > > #2 is desirable because if QEMU gets compromised it has a smaller
> > > attack surface onto the guest.
> >
> > And it allows to run the virtio backend in a less privileged VM.
> >
> > >
> > > >
> > > >    - why a 3rd memory type is required?  Do we have other alternati=
ves?
> > >
> > > Yes, there are alternatives.
> > >
> > > 1. It was suggested by Stefano to try to handle this in existing qemu=
/hw/xen/*.
> > > This would be less intrusive but perhaps also less explicit.
> > > Concerns about touching the Memory API have been raised before, so
> > > perhaps we should try this.
> > > I'm a little unsure how we would deal with unmapping when the guest
> > > removes our grants and we're using models that don't map but use
> > > address_space_read/write().
> >
> > Those would either need to use grant-copy hypercalls, or they'd need to=
 map,
> > read/write, unmap.
> >
> > >
> > > 2. Another approach could be to change the Xen grant-iommu in the
> > > Linux kernel to work with a grant vIOMMU in QEMU.
> > > Linux could explicitly ask QEMU's grant vIOMMU to map/unmap granted r=
egions.
> > > This would have the benefit that we wouldn't need to allocate
> > > address-bit 63 for grants.
> > > A drawback is that it may be slower since we're going to need to
> > > bounce between guest/qemu a bit more.
> >
> > It would be a _lot_ slower, unless virtio-iommu and grants are both mod=
ified
> > to match. I have looked into that, but the needed effort is rather larg=
e. At
> > the last Xen summit I have suggested to introduce a new grant format wh=
ich
> > would work more like a normal page table structure. Using the same form=
at
> > for virtio-iommu would allow to avoid the additional bounces between qe=
mu and
> > the guest (and in fact that was one of the motivations to suggest the n=
ew
> > grant format).
>
> I have a better picture now, thanks both.
>
> It really looks like an vIOMMU already to me, perhaps with a special refI=
D
> mapping playing similar roles as IOVAs in the rest IOMMU worlds.
>
> I can't yet tell what's the best way for Xen - as of now QEMU's memory AP=
I
> does provide such translations via IOMMUMemoryRegionClass.translate(), bu=
t
> only from that.  So far it works for all vIOMMU emulations in QEMU, and I=
'd
> hope we don't need to hack another memory type if possible for this,
> especially if for performance's sake; more on below.
>
> QEMU also suffers from similar issues with other kind of DMA protections,
> at least that's what I'm aware with using either VT-d, SMMU, etc.. where
> dynamic DMA mappings will slow the IOs down to a degree that it may not b=
e
> usable in real production.  We kept it like that and so far AFAIK we don'=
t
> yet have a solution for that simply because of the nature on how DMA
> buffers are mapped and managed within a guest OS no matter Linux or not.
>
> For Linux as a guest we basically suggest enabling iommu=3Dpt so that ker=
nel
> drivers are trusted, and kernel driven devices can have full access to
> guest RAMs by using the vIOMMU's passthrough mode. Perhaps similar to
> foreign mappings for Xen, but maybe still different, as Xen's topology is
> definitely special as a hypervisor here.
>
> While for userspace drivers within the guest OS it'll always go through
> vfio-pci now, which will enforce effective DMA mappings not the passthrou=
gh
> mode. Then it's suggested to only map as less as possible, e.g. DPDK only
> maps at the start of the user driver so it's mostly not affected by the
> slowness of frequently changing DMA mappings.
>
> I'm not sure whether above ideas would even be applicable for Xen, but I
> just to share the status quo regarding to how we manage protected DMAs wh=
en
> without Xen, just in case there's anything useful to help route the path
> forward.
>
> Thanks,
>
> --
> Peter Xu
>

Thanks for the suggestions Peter and for your comments Jurgen.
We'll have to evaluate the different approaches a little more and see
where we go from here.

Best regards,
Edgar

