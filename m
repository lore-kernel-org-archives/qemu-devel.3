Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3F1C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 11:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwh3C-0001s1-BT; Tue, 16 Apr 2024 07:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rwh39-0001ri-Je
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 07:32:31 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rwh36-0007u4-3c
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 07:32:30 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so6178426a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713267145; x=1713871945; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nu/3wVGY8Fqls2x1RXw8qQlUl/eeMliHAS9I4CFDM9o=;
 b=MURYHPr/bHgQcpFT/B4ogHj3T4GTSz/HjbYBlp/WADQVMsIAkNL/eij9RndnXjuQEp
 bZIcB7Wo2g4G/s1fe61eIFcheDEI6XQzxLpxNFS7H08H/bxl/kRSx+uI6uMqazI9tomp
 E59r+ZWTsZ9beRvOPySNmISQFEOoKjZdHrSE4tBuZ+kqxzYAzPGzIJACTevHeXEb88xw
 XABe6xciPXasW9iUwXsNgl2pVf/R++k0AatJFHEfAYj14lNC9iXs3TnjDPwx/kuNFyfM
 4R7ts44jHgU3p+9HeWQ8IaCWyuSdy1MuEXiMq0eGi3CMe0ZdKQ77aOhq1X7RsMbuGwfX
 j/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713267145; x=1713871945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nu/3wVGY8Fqls2x1RXw8qQlUl/eeMliHAS9I4CFDM9o=;
 b=HXSdgus1EQIWzCiiugnfY/dXevZ4RUMm/83PoqUBOWLUJeLHq8jcg656Z9UsT7EJLz
 qVBDpwN1b+Wogalu2B1OCqKLxky++93QdiVAmfYHF7zcVnpfBV1nay+fho0lC2d6OhRD
 T7ysXd12WZr8IuH6ZJJ+RaWRiZTzxgn4yzy3/eFDKgDMCSf7ZgW260sbUTh3IrU8kH4D
 vjqVfrhtrtlffKz7ctHKkVeW+nGhppomrlE4gBK26tAvSYHaA7zR2pM650QABSnc6WIt
 OgR3OoFaIWrAWC2uLZ0IHfDx5kARzJgIg539AtHUcGQvqjPZX7+ZhGOv4f7+Y0RnNPZ/
 hCQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3eLszDWYjPAaPpRsSRSo5ZUwiR6Ea+e6DY8Wirps3/RhjQHm2adgYJycR/CnSmdhwIpyWVAbDq0w3hVxSwtB/2obnsD8=
X-Gm-Message-State: AOJu0YyrHu0O1sJJxmHEsFQLs4E0DWLnJx7P1HCF7OuF7Oh+HOraZGjC
 o9UoYP5kXqjD0/152TpJMDzJ5xlLFV3+pB6XYAjc8F+IaNUAIS3X3Yj30H6f2Ror+FrxgQNeytQ
 LaQBnB7Zu5oy56LHDoPBGj0z458M=
X-Google-Smtp-Source: AGHT+IF8ZwyyV3OhxscQE9v9s7r/V/D6iWPYpN64d2i1cPRA+TFAjYYEDq0Iakd4mTsKsWoPBJtcm5CSuD1/LzHr7Gc=
X-Received: by 2002:a50:d594:0:b0:56e:c16:fbf2 with SMTP id
 v20-20020a50d594000000b0056e0c16fbf2mr9192595edi.23.1713267144870; Tue, 16
 Apr 2024 04:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-6-vikram.garhwal@amd.com>
 <CAJy5ezpCWkOqthGR1c5Nsfyi_W_yGL_d17Jcp0VckaCEwx9z3Q@mail.gmail.com>
 <Zhbg9alYH1-J9poU@x1n>
In-Reply-To: <Zhbg9alYH1-J9poU@x1n>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 16 Apr 2024 13:32:13 +0200
Message-ID: <CAJy5ezpfNGDC4Q=eMcQ-df_xZVYnc-CR5wfn4izW2CT532PbAA@mail.gmail.com>
Subject: Re: [QEMU][PATCH v3 5/7] memory: add MemoryRegion map and unmap
 callbacks
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, sstabellini@kernel.org, vikram.garhwal@amd.com, 
 jgross@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x533.google.com
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

On Wed, Apr 10, 2024 at 8:56=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Apr 10, 2024 at 06:44:38PM +0200, Edgar E. Iglesias wrote:
> > On Tue, Feb 27, 2024 at 11:37=E2=80=AFPM Vikram Garhwal <vikram.garhwal=
@amd.com>
> > wrote:
> >
> > > From: Juergen Gross <jgross@suse.com>
> > >
> > > In order to support mapping and unmapping guest memory dynamically to
> > > and from qemu during address_space_[un]map() operations add the map()
> > > and unmap() callbacks to MemoryRegionOps.
> > >
> > > Those will be used e.g. for Xen grant mappings when performing guest
> > > I/Os.
> > >
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> > >
> >
> >
> > Paolo, Peter, David, Phiippe, do you guys have any concerns with this p=
atch?
>

Thanks for your comments Peter,


> This introduces a 3rd memory type afaict, neither direct nor !direct.
>
> What happens if someone does address_space_write() to it?  I didn't see i=
t
> covered here..

You're right, that won't work, the memory needs to be mapped before it
can be used.
At minimum there should be some graceful failure, right now this will crash=
.

>
> OTOH, the cover letter didn't mention too much either on the big picture:
>
> https://lore.kernel.org/all/20240227223501.28475-1-vikram.garhwal@amd.com=
/
>
> I want to have a quick grasp on whether it's justified worthwhile we shou=
ld
> introduce this complexity to qemu memory core.
>
> Could I request a better cover letter when repost?  It'll be great to
> mention things like:

I'll do that, but also answer inline in the meantime since we should
perhaps change the approach.

>
>   - what is grant mapping, why it needs to be used, when it can be used (=
is
>     it only relevant to vIOMMU=3Don)?  Some more information on the high
>     level design using this type or MR would be great.

https://github.com/xen-project/xen/blob/master/docs/misc/grant-tables.txt

Xen VM's that use QEMU's VirtIO have a QEMU instance running in a separate =
VM.

There's basically two mechanisms for QEMU's Virtio backends to access
the guest's RAM.
1. Foreign mappings. This gives the VM running QEMU access to the
entire RAM of the guest VM.
2. Grant mappings. This allows the guest to dynamically grant and
remove access to pages as needed.
So the VM running QEMU, cannot map guest RAM unless it's been
instructed to do so by the guest.

#2 is desirable because if QEMU gets compromised it has a smaller
attack surface onto the guest.

>
>   - why a 3rd memory type is required?  Do we have other alternatives?

Yes, there are alternatives.

1. It was suggested by Stefano to try to handle this in existing qemu/hw/xe=
n/*.
This would be less intrusive but perhaps also less explicit.
Concerns about touching the Memory API have been raised before, so
perhaps we should try this.
I'm a little unsure how we would deal with unmapping when the guest
removes our grants and we're using models that don't map but use
address_space_read/write().

2. Another approach could be to change the Xen grant-iommu in the
Linux kernel to work with a grant vIOMMU in QEMU.
Linux could explicitly ask QEMU's grant vIOMMU to map/unmap granted regions=
.
This would have the benefit that we wouldn't need to allocate
address-bit 63 for grants.
A drawback is that it may be slower since we're going to need to
bounce between guest/qemu a bit more.


>     So it's all based on my very limited understanding of reading this:
>     https://xenbits.xenproject.org/docs/4.3-testing/misc/grant-tables.txt
>
>     If it's about cross-vm sharing memory, does it mean that in reality
>     there are RAMs allocated, but it's only about permission management?
>     In that case, is there any option we implement it with direct access
>     mode (however with some extra dynamic permissions applied on top usin=
g
>     some mechanism)?

Yes, I think the grant vIOMMU approach would fall into this category.

>
>   - perhaps sold old links would be great too so people can read about th=
e
>     context when it's not obvious, without a need to copy-paste.

https://wiki.xenproject.org/wiki/Virtio_On_Xen
https://lwn.net/Articles/896938/

Cheers,
Edgar

