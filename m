Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F84CE7B09
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smYoj-0000H1-Kz; Fri, 06 Sep 2024 09:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1smYoX-00081W-D5
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:15:53 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1smYoU-00072n-Ac
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:15:48 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2780827dbafso1065557fac.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725628544; x=1726233344; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cls9rlaEROUI3ZQ9mRT2WoeslyBNTvIvj8ifJQ1gEK8=;
 b=aSj9VAvTFmResQAMYw2J+W4HxnMqQELlW99ar2yuLt+jwbbiXNS7TJPBGrt8+c2084
 hFaI+hQcMIN0dLKM56bqj+zSrBuMC8sRXCiNk0MxktBDVdaU3xa8JBZYj56P9kJZ2KJE
 Ipz/39gcWs69YwoTrgt8F4aace6yfVoKAoVomupJg6VB9HmBo3i8vgRaVRawm+Fv7UcQ
 iJZ06GT1glMe9BuLhdW1Nqh2RgS7XbCaaz/gsZXAlqA1PPFIcXn79fAJbm1SFh58L4LX
 hS+D8eeHOiQWHxB32gE9wc3xCMk1zZVqk8M8ERIwmnQNgMmBPc9FKW2pgRcOPH6lqcTE
 xPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725628544; x=1726233344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cls9rlaEROUI3ZQ9mRT2WoeslyBNTvIvj8ifJQ1gEK8=;
 b=c19T8dcmCq99QC2c3wJIJj7DizWncEFCQUai9dVmYOMewO1i1Rm1tYfiBG49EdHOE4
 xXyxW6QDK6gdrjQD67+Z4v9aDQc7mAkbMixWH6yGZE7vVEOnyOpNjx06x5lMoDCfBp62
 Qjxl7TPVzp14qPUlNg4mwR4mIdp3iYu5ExrjUoDfwbrUIOIo1/chiN98B1WiygvsLM5J
 ocZrTY1AOC6v5jfroT5UJO5l34eNOZ6myoQIrdnukesxvAg/mm6vThQGW9HT0gB+hLev
 1mdUKjh+C+i1FCkiCv8WXBPwJ9h/7XeYI19CmSLT0HTBEC+q+ho90Ahib2sAnpg+FRbx
 uoKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX312vA4qjRwnZ+HXXZ/7NMVQaCYAnKyG8j6pCkfYcjtCHsApVyIhFvSCtLVN1i4/OkgyyLIK9Ss5X@nongnu.org
X-Gm-Message-State: AOJu0Yx0VC0hb0hlYoeu6bPH+nIs53eJ26wu0LmmASw8D28PePcsUp23
 1dBSiB7Z7jYsafWn/NTy7ot3P9sbIi9UfjjGrde/pQzB06NMMCUmwLqHnGIYyz6iXZ/XrSXd+05
 KCZMLJD75AfYLbe1fHTT3rdID7MT0Aw==
X-Google-Smtp-Source: AGHT+IG96YBwDmKyyXfmqeppZI4NLzJE8XvPajbsXFfG1mqUvCY8AzoPZmXDWb0Vu37ewQwcKhOjzBXXMYOxSd2xA1Q=
X-Received: by 2002:a05:6870:b50e:b0:278:1d21:2b34 with SMTP id
 586e51a60fabf-27b82edd57amr3139306fac.27.1725628544533; Fri, 06 Sep 2024
 06:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <87bk34i4dy.fsf@alyssa.is>
 <CAD=HUj7av_8Epkd0Fe0eWR7Z4bZMTuvTNgqzYoQcOzFQ82wvOg@mail.gmail.com>
 <20240712014407-mutt-send-email-mst@kernel.org>
 <CAD=HUj7iDbwnojq5a68s6B3S8z4vtpCa=B=9+ZBVYZV50zG+5g@mail.gmail.com>
 <CADSE00K=8SCghVxbP+7Awy6tGHtP3JyYy-5MAAMjrpv+bVC=6Q@mail.gmail.com>
 <20240905163937.GE1922502@fedora>
 <CADSE00KZF7hOLouH0b4NX9frCmsM7ZBjn70LEbh_HyrKcHF-5A@mail.gmail.com>
In-Reply-To: <CADSE00KZF7hOLouH0b4NX9frCmsM7ZBjn70LEbh_HyrKcHF-5A@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 6 Sep 2024 09:15:32 -0400
Message-ID: <CAJSP0QUhjkAwfyu5sj6gkQ7oEMd_HhtOCN9Y0HsoQsWQ+jM-AQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
To: Albert Esteve <aesteve@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 David Stevens <stevensd@chromium.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 qemu-devel@nongnu.org, 
 jasowang@redhat.com, david@redhat.com, slp@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 6 Sept 2024 at 03:06, Albert Esteve <aesteve@redhat.com> wrote:
> On Thu, Sep 5, 2024 at 6:39=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>>
>> On Tue, Sep 03, 2024 at 10:42:34AM +0200, Albert Esteve wrote:
>> > Hello all,
>> >
>> > Sorry, I have been a bit disconnected from this thread as I was on
>> > vacations and then had to switch tasks for a while.
>> >
>> > I will try to go through all comments and address them for the first
>> > non-RFC drop of this patch series.
>> >
>> > But I was discussing with some colleagues on this. So turns out rust-v=
mm's
>> > vhost-user-gpu will potentially use
>> > this soon, and a rust-vmm/vhost patch have been already posted:
>> > https://github.com/rust-vmm/vhost/pull/251.
>> > So I think it may make sense to:
>> > 1. Split the vhost-user documentation patch once settled. Since it is =
taken
>> > as the official spec,
>> >     having it upstreamed independently of the implementation will bene=
fit
>> > other projects to
>> >     work/integrate their own code.
>> > 2. Split READ_/WRITE_MEM messages from SHMEM_MAP/_UNMAP patches.
>> >     If I remember correctly, this addresses a virtio-fs specific issue=
,
>> > that will not
>> >     impact either virtio-gpu nor virtio-media, or any other.
>>
>> This is an architectural issue that arises from exposing VIRTIO Shared
>> Memory Regions in vhost-user. It was first seen with Linux virtiofs but
>> it could happen with other devices and/or guest operating systems.
>>
>> Any VIRTIO Shared Memory Region that can be mmapped into Linux userspace
>> may trigger this issue. Userspace may write(2) to an O_DIRECT file with
>> the mmap as the source. The vhost-user-blk device will not be able to
>> access the source device's VIRTIO Shared Memory Region and will fail.
>>
>> > So it may make
>> > sense
>> >     to separate them so that one does not stall the other. I will try =
to
>> > have both
>> >     integrated in the mid term.
>>
>> If READ_/WRITE_MEM is a pain to implement (I think it is in the
>> vhost-user back-end, even though I've been a proponent of it), then
>> another way to deal with this issue is to specify that upon receiving
>> MAP/UNMAP messages, the vhost-user front-end must update the vhost-user
>> memory tables of all other vhost-user devices. That way vhost-user
>> devices will be able to access VIRTIO Shared Memory Regions mapped by
>> other devices.
>>
>> Implementing this in QEMU should be much easier than implementing
>> READ_/WRITE_MEM support in device back-ends.
>>
>> This will be slow and scale poorly but performance is only a problem for
>> devices that frequently MAP/UNMAP like virtiofs. Will virtio-gpu and
>> virtio-media use MAP/UNMAP often at runtime? They might be able to get
>> away with this simple solution.
>>
>> I'd be happy with that. If someone wants to make virtiofs DAX faster,
>> they can implement READ/WRITE_MEM or another solution later, but let's
>> at least make things correct from the start.
>
>
> I agree. I want it to be correct first. If you agree on splitting the spe=
c bits from this
> patch I'm already happy. I suggested splitting READ_/WRITE_MEM messages
> because I thought that it was a virtiofs-specific issue.
>
> The alternative that you proposed is interesting. I'll take it into accou=
nt. But I
> feel I prefer to go for the better solution, and if I get too entangled, =
then switch
> to the easier implementation.

Great. The difficult part to implementing READ_/WRITE_MEM messages is
modifying libvhost-user and rust-vmm's vhost crate to send the new
messages when address translation fails. This needs to cover all
memory accesses (including vring struct accesses). That code may be a
few levels down in the call stack and assume it can always load/store
directly from mmapped memory.

>
> I think we could do this in 2 patches:
> 1. Split the documentation bits for SHMEM_MAP/_UNMAP. The
>     implementation for these messages will go into the second patch.
> 2. The implementation patch: keep going for the time being with
>      READ_/WRITE_MEM support. And the documentation for that
>     is kept it within this patch. This way if we switch to the frontend
>     updating vhost-user memory table, we weren't set in any specific
>     solution if patch 1 has been already merged.

I'm happy as long as the vhost-user spec patch that introduces
MAP/UNMAP also covers a solution for the memory access problem (either
READ_/WRITE_MEM or propagating mappings to all vhost-user back-ends).

Stefan

>
> BR,
> Albert.
>
>>
>>
>> Stefan
>>
>> >
>> > WDYT?
>> >
>> > BR,
>> > Albert.
>> >
>> > On Tue, Jul 16, 2024 at 3:21=E2=80=AFAM David Stevens <stevensd@chromi=
um.org> wrote:
>> >
>> > > On Fri, Jul 12, 2024 at 2:47=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
>> > > >
>> > > > On Fri, Jul 12, 2024 at 11:06:49AM +0900, David Stevens wrote:
>> > > > > On Thu, Jul 11, 2024 at 7:56=E2=80=AFPM Alyssa Ross <hi@alyssa.i=
s> wrote:
>> > > > > >
>> > > > > > Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UNMA=
P in
>> > > > > > crosvm a couple of years ago.
>> > > > > >
>> > > > > > David, I'd be particularly interested for your thoughts on the
>> > > MEM_READ
>> > > > > > and MEM_WRITE commands, since as far as I know crosvm doesn't
>> > > implement
>> > > > > > anything like that.  The discussion leading to those being add=
ed
>> > > starts
>> > > > > > here:
>> > > > > >
>> > > > > >
>> > > https://lore.kernel.org/qemu-devel/20240604185416.GB90471@fedora.red=
hat.com/
>> > > > > >
>> > > > > > It would be great if this could be standardised between QEMU a=
nd
>> > > crosvm
>> > > > > > (and therefore have a clearer path toward being implemented in=
 other
>> > > VMMs)!
>> > > > >
>> > > > > Setting aside vhost-user for a moment, the DAX example given by =
Stefan
>> > > > > won't work in crosvm today.
>> > > > >
>> > > > > Is universal access to virtio shared memory regions actually man=
dated
>> > > > > by the virtio spec? Copying from virtiofs DAX to virtiofs sharin=
g
>> > > > > seems reasonable enough, but what about virtio-pmem to virtio-bl=
k?
>> > > > > What about screenshotting a framebuffer in virtio-gpu shared mem=
ory to
>> > > > > virtio-scsi? I guess with some plumbing in the VMM, it's solvabl=
e in a
>> > > > > virtualized environment. But what about when you have real hardw=
are
>> > > > > that speaks virtio involved? That's outside my wheelhouse, but i=
t
>> > > > > doesn't seem like that would be easy to solve.
>> > > >
>> > > > Yes, it can work for physical devices if allowed by host configura=
tion.
>> > > > E.g. VFIO supports that I think. Don't think VDPA does.
>> > >
>> > > I'm sure it can work, but that sounds more like a SHOULD (MAY?),
>> > > rather than a MUST.
>> > >
>> > > > > For what it's worth, my interpretation of the target scenario:
>> > > > >
>> > > > > > Other backends don't see these mappings. If the guest submits =
a vring
>> > > > > > descriptor referencing a mapping to another backend, then that
>> > > backend
>> > > > > > won't be able to access this memory
>> > > > >
>> > > > > is that it's omitting how the implementation is reconciled with
>> > > > > section 2.10.1 of v1.3 of the virtio spec, which states that:
>> > > > >
>> > > > > > References into shared memory regions are represented as offse=
ts from
>> > > > > > the beginning of the region instead of absolute memory address=
es.
>> > > Offsets
>> > > > > > are used both for references between structures stored within =
shared
>> > > > > > memory and for requests placed in virtqueues that refer to sha=
red
>> > > memory.
>> > > > >
>> > > > > My interpretation of that statement is that putting raw guest ph=
ysical
>> > > > > addresses corresponding to virtio shared memory regions into a v=
ring
>> > > > > is a driver spec violation.
>> > > > >
>> > > > > -David
>> > > >
>> > > > This really applies within device I think. Should be clarified ...
>> > >
>> > > You mean that a virtio device can use absolute memory addresses for
>> > > other devices' shared memory regions, but it can't use absolute memo=
ry
>> > > addresses for its own shared memory regions? That's a rather strange
>> > > requirement. Or is the statement simply giving an addressing strateg=
y
>> > > that device type specifications are free to ignore?
>> > >
>> > > -David
>> > >
>> > >

