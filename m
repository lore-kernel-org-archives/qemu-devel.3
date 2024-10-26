Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798D3D10BF0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 10:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4dh9-0003AU-WF; Sat, 26 Oct 2024 06:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t4dh8-0003AH-Lh
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 06:06:54 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t4dh6-00032B-Ff
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 06:06:54 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a99eb8b607aso322704266b.2
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729937211; x=1730542011; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7+iFDuS/VrmlRdPubEdhs0tCNdeaCWaCdXzhc26bnY=;
 b=s+qLsB9dd7NLlpXfttHM/G+pWAmQFJNGVcOQeIl2ZaFhSEepdzzAuRJzPJ7fOWvxzM
 HKm3zooOcWqSHEOUPsX3x/kg+E5NQ7a+RdtNfrtNyuUVk/Fq/JjbFnRvy+66ArlMjrCJ
 nuHD7Aedk2VBSBjw+OZmDB7K3UaII3u3JFxzHzVx1YCjxbQM9UKXTc8/xomQhDLokdhQ
 ZeX19WFwM/co4lNH+mOkZBIBdCbOkb1HtB7orfoeDbE2qmRz5qvFYEHK+nsDXqljchTo
 hlHtKbuFBtLmz0L/FVOxsKnLTHA9rSki2UvwktRVlGDxs3q27m9KPsLp+6Ywq79CKzrz
 tmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729937211; x=1730542011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7+iFDuS/VrmlRdPubEdhs0tCNdeaCWaCdXzhc26bnY=;
 b=H/n8Vu88SBvfrixkKqEbPzps5v7bI6waPa22gSoo/5XEXNc0GRlLKZNwdLv/TzQ9ht
 jatkSyb/oJ/zkYyN2sNQv4CZD4WWx+mR+SDUAzjeCt+mxeQdt/lKpWFvT6kV+HsjbvfM
 Euzh1u7rnXxZdUXlRyZiu3+Bq4flMEHttPhOfI/0e/kXO3A48fwuxq3ALViYm9rQeshK
 RlyURxAaPFWcXk01HxpiDVcC6QtluCL2pHpvE03hrGefMel4dNkTC6vRZ7vRJUhe4iAa
 VGnkxNqGsZ/EPWpfGe0CLguQyXkhtKpGt6P3yzZdDU1nMqCzktxZBciCvUZmvSm9tWC7
 4WBw==
X-Gm-Message-State: AOJu0YzIC6BPbCTszZmjrQQYwurLupIkYw2fw89N08tgcHQnxJchBjQ5
 o5yq4eAy9D7OLJArwXrwkxRNLKBab6G5GYfidVTXDJz1i9rVObplbKO2JTg08GkUOotliRAwgN4
 H59QlNsKdryvEWaEwpOOmRKIA4FL8cIhR3qSw9A==
X-Google-Smtp-Source: AGHT+IF91kJfr7yopX3Nt+zx1gMI5KmGuKmCz7ncrTaBJVSREumGMNbNgOX22ygHpxShWgeVkyCpem44KW4QwF6Anvs=
X-Received: by 2002:a17:907:2d89:b0:a99:33dd:d8a0 with SMTP id
 a640c23a62f3a-a9de5ff9ad3mr137960466b.38.1729937210408; Sat, 26 Oct 2024
 03:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
 <e8e55772-906b-42cb-a744-031e6ae65f16@redhat.com>
In-Reply-To: <e8e55772-906b-42cb-a744-031e6ae65f16@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sat, 26 Oct 2024 13:06:34 +0300
Message-ID: <CAAjaMXbrkeX3ZiWw2snrNhoVQTMc4NK_7JNP0DrPYbjfWZ+KCg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Rust device model patches and misc cleanups
To: Paolo Bonzini <pbonzini@redhat.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Paolo,

Please reply with review comments underneath individual patches, this
is hard to follow and I might miss some points.

On Fri, 25 Oct 2024 at 12:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/24/24 16:02, Manos Pitsidianakis wrote:
> > Hello everyone, the pathological corrosion of QEMU code continues.
> > This series expands the device model harness work performed in the
> > initial Rust work from the previous month. In particular:
>
> Wow, there's a lot of stuff here!
>
> The very good news is that it's basically all the code that is needed to
> get CI running, after which we can start with the fun stuff.  At the
> same time, "the fun stuff" is also the one that risks introducing
> technical debt, so we need to switch to quality-over-quantity mode and
> have a serious design discussion about it.  I'll do that later as a
> reply to the patches.
>
> >    Code and functionality duplication is not fun, and pl011 was mostly
> >    done as a proof of concept for a Rust device because of its small
> >    complexity. As of this moment we have not decided on a policy for ho=
w
> >    to handle these things and it is not in **scope for this patch serie=
s
> >    anyway**.
>
> That's fine.
>
> Looking at the currently posted series, it seems that we have three main
> themes:
>
> 1) small scale cleanups: duplicated and useless code, improved testing.
> These are in
> https://lore.kernel.org/qemu-devel/20241021163538.136941-1-pbonzini@redha=
t.com/T/
> and they have been reviewed already.  But these two:
>
> >        Revert "rust: add PL011 device model"
> >        rust: add PL011 device model
>
> ... should definitely be moved on top to clean up the authorship in "git
> blame" and other similar tools.  Sorry about that.

I will send them on a separate series and merge them from my tree when revi=
ewed.

>
> 2) allow using older rustc/bindgen, extend CI to cover it.  This is
> https://lore.kernel.org/qemu-devel/20241022100956.196657-1-pbonzini@redha=
t.com/T/
> which still needs review.  These five:
>
> >        rust: add support for migration in device models
> >        rust/pl011: move CLK_NAME static to function scope
> >        rust/pl011: add TYPE_PL011_LUMINARY device
> >        rust/pl011: remove commented out C code
> >        rust/pl011: Use correct masks for IBRD and FBRD
>
> (minus the usage of #[derive()] should be included in that series, so
> that qtests pass.  It's not a huge amount of work and I can extract it,
> of course with proper attribution/authorship.

These are independent from CI; i.e. you can merge your CI patches after tho=
se.

>
> The rest are future work:
>
> >        rust/qemu-api-macros: introduce Device proc macro
>
> This is useful as a starting point but it has the limit of being very
> device-specific.  This is of course okay with properties and vmstate,
> but in my opinion the implementation of class_init should be as generic
> as possible, and not too specialized for methods in Object or Device.
>
> As I said above, we first need to agree on the design.


Post your review under the patches please,


>
> >        rust/pl011: move pub callback decl to local scope
>
> This depends a lot on how we go implementing bindings to chardev.  For
> example if the callbacks turn out to be a trait, it would have to be
> undone.  Possibly the C callback wrappers would move to
> rust/qemu-api/chardev.  For now I'd leave it aside.


This patch moves the callbacks scope from public to inside the
function, no functional change related. It doesn't change or have
anything to do with chardev interfaces


>
> >        rust/qemu-api: add log module
> >        rust/pl011: log guest/unimp errors
>
> This also needs design discussion.  Do we want the API to be the same as
> C, i.e. keep the qemu_* prefix?  Do we want wrapper macros that include
> the format!() call?

I'm guessing you did not see the patch messages, which cover these
points. Post your review under the patches please,

>
> You also have "pub enum LogMask" to work around the fact that log masks
> are preprocessor macros.  Is that okay, or do we want to modify C code
> to make the bindings nicer?  I for example would prefer the latter and
> then declaring LogMask as a bitfield in bindgen.

A bindgen type is definitely preferred but for a Rust idiomatic
interface a wrapper type is a UX improvement (`CPU_LOG_PCALL`?
`LOG_GUEST_ERROR`? We can use friendlier symbols in the LogMask
variants for that)

Thanks, Manos

>
> Thanks,
>
> Paolo
>
> >
> >   rust/wrapper.h                                |   1 +
> >   rust/hw/char/pl011/src/device.rs              | 419 +++++++++++++++++=
---------
> >   rust/hw/char/pl011/src/device_class.rs        |  70 -----
> >   rust/hw/char/pl011/src/lib.rs                 |   2 +-
> >   rust/qemu-api-macros/src/device.rs            | 370 +++++++++++++++++=
++++++
> >   rust/qemu-api-macros/src/lib.rs               |  46 +--
> >   rust/qemu-api-macros/src/object.rs            | 107 +++++++
> >   rust/qemu-api-macros/src/symbols.rs           |  57 ++++
> >   rust/qemu-api-macros/src/utilities.rs         | 152 ++++++++++
> >   rust/qemu-api-macros/src/vmstate.rs           | 113 +++++++
> >   rust/qemu-api/meson.build                     |   5 +-
> >   rust/qemu-api/src/definitions.rs              |  97 ------
> >   rust/qemu-api/src/device_class.rs             | 128 --------
> >   rust/qemu-api/src/lib.rs                      |  10 +-
> >   rust/qemu-api/src/log.rs                      | 140 +++++++++
> >   rust/qemu-api/src/objects.rs                  |  90 ++++++
> >   rust/qemu-api/src/tests.rs                    |  49 ---
> >   rust/qemu-api/src/vmstate.rs                  | 403 +++++++++++++++++=
++++++++
> >   subprojects/packagefiles/syn-2-rs/meson.build |   1 +
> >   19 files changed, 1726 insertions(+), 534 deletions(-)
> > ---
> > base-commit: 55522f72149fbf95ee3b057f1419da0cad46d0dd
> > change-id: 20241024-rust-round-2-69fa10c9a0c9
> >
> > --
> > =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
> >
> >
> >
>

