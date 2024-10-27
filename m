Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1637AD10C08
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 08:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4yOw-0001sn-G4; Sun, 27 Oct 2024 04:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4yOu-0001sQ-A1
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 04:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4yOs-0005vm-NV
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 04:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730016804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEqjl+I2jRS/6Nsb3wSsB7G2axp6NIs1gkQTBVzR2VU=;
 b=VrzmFYke9ZLVgj24nobQdF+Eglwv1LW6GWpZQevs/rIxiw6tQmVbtnE2QBj2eyax+T1/Vm
 GG/HUB1eCAJnBJ+m4dLlceBxm1JpJqyevA6mNoF9hxcaHDzPCV4Oupf8EPIP79SjtDIf93
 cNBGF1fLA5ZFi52YnFlfizP1HfArWM4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-CpscbBiYOlmaO2iL_hSWew-1; Sun, 27 Oct 2024 04:13:14 -0400
X-MC-Unique: CpscbBiYOlmaO2iL_hSWew-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d432f9f5eso1877038f8f.0
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 01:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730016793; x=1730621593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IEqjl+I2jRS/6Nsb3wSsB7G2axp6NIs1gkQTBVzR2VU=;
 b=FwQv9VuNodAVbJIcTXRAxWJwbzahZwYlQyNGy/qn2qN79UNnoRoPtKaPqzGoVeQM2j
 lRRc7XhvlN7bN3aPcswcRBV2oftVkTfa2Ixf/RtW7mnYZnwnqXRS4ASi6ihXkgU+gMTk
 +GCJ2l5WcwAi5Ohk93w8beg3ymcbQUVsVkHYn2vRnD9rN3onv2q04yVJ5j754Q7J2JAp
 Cbe/CUydlEwmxLmNILljk3aFuLTZk+W7z0NPsRHA0RtDx524EfUtUO5fMeNF2EWI5Yqr
 LNKlrjkzedLWrc5Ddu9crHODeTwhdt7+uywKo/JrCteoBLfbXeU0taajS2Du1eh15xw9
 ltbQ==
X-Gm-Message-State: AOJu0YzHnTAEA1mas7ZCM0CXWA5iIdjOdJtYKQR2a8kAe95U/O2hTQZ5
 mLGEc282br0VroVTM5emDOtl77Ju2z6GgMEhbJLbRA7h18k0wvsdF/Db2aIrTvxgDs5L/cUPNY5
 nGl9oebCXoXmTzfsLc0Bp1v1vZUngcCMHS7W0YtC40TD6ZFjW/2GhLAxBR8tzNEUi7Qzg4bp2zf
 Yv8rxRVBmr86lzbKvNkAcsCTOlec8=
X-Received: by 2002:adf:e107:0:b0:37c:d225:6d33 with SMTP id
 ffacd0b85a97d-380611f5fe5mr3534419f8f.55.1730016793068; 
 Sun, 27 Oct 2024 01:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpolYv6R6RunVOuyiPuONgXIT0Q38EC1ydttgOtJpnKeN2rJemBZbxTp3NjBNKcvGRc9aUk3zS/8H8ACj1J0I=
X-Received: by 2002:adf:e107:0:b0:37c:d225:6d33 with SMTP id
 ffacd0b85a97d-380611f5fe5mr3534394f8f.55.1730016792690; Sun, 27 Oct 2024
 01:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
 <e8e55772-906b-42cb-a744-031e6ae65f16@redhat.com>
 <CAAjaMXbrkeX3ZiWw2snrNhoVQTMc4NK_7JNP0DrPYbjfWZ+KCg@mail.gmail.com>
In-Reply-To: <CAAjaMXbrkeX3ZiWw2snrNhoVQTMc4NK_7JNP0DrPYbjfWZ+KCg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 27 Oct 2024 09:13:00 +0100
Message-ID: <CABgObfYuW2O68NcLiwM8breLWzQjawpZSxqxBK6hAOWDHgmjKA@mail.gmail.com>
Subject: Re: [PATCH 00/11] Rust device model patches and misc cleanups
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.488,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, Oct 26, 2024 at 12:06=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> Please reply with review comments underneath individual patches, this
> is hard to follow and I might miss some points.

Will do.

> > >        Revert "rust: add PL011 device model"
> > >        rust: add PL011 device model
> >
> > ... should definitely be moved on top to clean up the authorship in "gi=
t
> > blame" and other similar tools.  Sorry about that.
>
> I will send them on a separate series and merge them from my tree when re=
viewed.

Those are trivial to review, just "git diff HEAD^^". No need to
separate them into a new submission.

> > >        rust: add support for migration in device models
> > >        rust/pl011: move CLK_NAME static to function scope
> > >        rust/pl011: add TYPE_PL011_LUMINARY device
> > >        rust/pl011: remove commented out C code
> > >        rust/pl011: Use correct masks for IBRD and FBRD
> >
> > (minus the usage of #[derive()] should be included in that series, so
> > that qtests pass.  It's not a huge amount of work and I can extract it,
> > of course with proper attribution/authorship.
>
> These are independent from CI; i.e. you can merge your CI patches after t=
hose.

That's what I did: I put them at the beginning of the series of
pending patches, so they _are_ indeed merged after the CI patches. The
only issue here is that patch 4 ("rust: add support for migration in
device models") was dependent on the Device proc macro, but that was
easy enough to extract.

> >
> > The rest are future work:
> >
> > >        rust/qemu-api-macros: introduce Device proc macro
> >
> > As I said above, we first need to agree on the design.
>
> Post your review under the patches please,

Yep.

> > >        rust/pl011: move pub callback decl to local scope
> >
> > This depends a lot on how we go implementing bindings to chardev.  For
> > example if the callbacks turn out to be a trait, it would have to be
> > undone.  Possibly the C callback wrappers would move to
> > rust/qemu-api/chardev.  For now I'd leave it aside.
>
> This patch moves the callbacks scope from public to inside the
> function, no functional change related. It doesn't change or have
> anything to do with chardev interfaces

I understand. My point is that the callbacks you move
(pl011_can_receive, pl011_receive, pl011_event) in the end will belong
into the C<->Rust chardev bindings. A patch to remove "pub" would have
basically the same benefit without the churn in indentation.

> > >        rust/qemu-api: add log module
> > >        rust/pl011: log guest/unimp errors
> >
> > This also needs design discussion.  Do we want the API to be the same a=
s
> > C, i.e. keep the qemu_* prefix?  Do we want wrapper macros that include
> > the format!() call?
>
> I'm guessing you did not see the patch messages, which cover these
> points. Post your review under the patches please,

I will but for now I'll say that the commit messages do not address
the questions I'm asking above.

More in general, we need to establish conventions on what the Rust
APIs look like (about qemu_* prefixes, for example). Personally I
prefer to have APIs that, while easy enough to connect to the C ones,
are idiomatic. But you can post these two patches separately and we
can discuss it there.

> > You also have "pub enum LogMask" to work around the fact that log masks
> > are preprocessor macros.  Is that okay, or do we want to modify C code
> > to make the bindings nicer?  I for example would prefer the latter and
> > then declaring LogMask as a bitfield in bindgen.
>
> A bindgen type is definitely preferred but for a Rust idiomatic
> interface a wrapper type is a UX improvement (`CPU_LOG_PCALL`?
> `LOG_GUEST_ERROR`? We can use friendlier symbols in the LogMask
> variants for that)

What I'm saying is that these are discussions where we need to reach
an agreement on, and document the choices.

Paolo


