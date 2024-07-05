Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E414BC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 21:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPqAn-0002Tq-23; Fri, 05 Jul 2024 17:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPqAl-0002Th-W7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 17:08:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPqAj-0002z4-UH
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 17:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720213728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyrC4m9T7Jad1HpgkV4n1X7ZVIUtCpWotbaFVc9PX74=;
 b=ABcMSq3YzZYgx0FI5jDpXyV9OovxAGy16J5T2Aj3aVjLlpTlr7Eqxr3kjIBtoXTj7vS+/a
 vTDuCdPEXhRtmxfvc7q5Md0dxNeId1cLwuSr+bcORGpk5taPl+1wV1V1moPA1dqYvaA9CB
 aUlJjd8FRAPgkUMtch9Q/LRyxaXCW2M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-WfzjZpdFOqqWHDMo-ssJwA-1; Fri, 05 Jul 2024 17:08:46 -0400
X-MC-Unique: WfzjZpdFOqqWHDMo-ssJwA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36794fcfdd6so993264f8f.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 14:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720213725; x=1720818525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZyrC4m9T7Jad1HpgkV4n1X7ZVIUtCpWotbaFVc9PX74=;
 b=OI1QoUyMLGd14vHrEwfxZ9eH2jf77BhMLt0y0CvEQpWZUb8m2jb6CHvJeEx7XgMaEo
 BnozKTknpLbIQlG6k6WiBcUBep3TdxaeyIpYDVT83YUwGeqahxx7PIG7LXSpgRZ7tV7g
 WTNkiNLfOOUpCM5o4I/WmD06jOHfQFokesrYbvWRLNOH5DeOrQ71bJHKQwlP68f5FQlh
 ZlPHAV9NwbWrpexB+t492coAJ+HTtvfymAkb3wyI9dGsd2bk65syNED6/6ChqDynMwad
 vQ1QyKoFk7iyXCON4we3Q4+tbNazaZvzPQzIcajtONF04zOJTomJDHAB0tRZ+Cmq77vx
 CmFg==
X-Gm-Message-State: AOJu0YycBIAZn1aiwvapWlUI1jqZxcB31QMxasRRKQqd/KXH60bpE62R
 AKTthhXCBgeWrgT1S+WyYfRFIRhy8G7ZRrDlmObyUfazHa0LyIhrHMXmaURAwz1HaDc7WTwRZ2i
 b0IjdQ5c3TdYytpUB8n9aJvLqIcE0owXaMACjwWVfDISMKmQQW7wcY1Zhqsl3cGqA+jNIG32u7x
 Yug0W/p5W2CbPVjjQMvcb8r5ol9Yg=
X-Received: by 2002:a05:6000:1b02:b0:367:9287:64c1 with SMTP id
 ffacd0b85a97d-3679dd26afdmr4356705f8f.16.1720213725376; 
 Fri, 05 Jul 2024 14:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz1zHjyXYlRm5YKBVZFkFdU2Dn/lDKqYwCTsDabj3Q+UNe/J+rILqxCc1iEvIbclzcF09CWuQOJVlEmT2QbzQ=
X-Received: by 2002:a05:6000:1b02:b0:367:9287:64c1 with SMTP id
 ffacd0b85a97d-3679dd26afdmr4356694f8f.16.1720213724903; Fri, 05 Jul 2024
 14:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240701145853.1394967-1-pbonzini@redhat.com>
 <0d85e013-1c38-4781-8fd6-5e837327f33f@linaro.org>
 <CABgObfZVWt4GkH_qAbWqoF7=xXP_mPopRqUbRFxii8Tki5YuBw@mail.gmail.com>
 <d9acf51b-a70d-450c-a768-3ecf25dbd597@linaro.org>
In-Reply-To: <d9acf51b-a70d-450c-a768-3ecf25dbd597@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 5 Jul 2024 23:08:32 +0200
Message-ID: <CABgObfbEPfCsRD3fSgZX1kL_8iKszzCz7YTJrx_bHOdScBuKmg@mail.gmail.com>
Subject: Re: [PATCH 00/14] rust: example of bindings code for Rust in QEMU
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi, first of all I want to clarify the raison d'etre for this posting,
which I have also explained to Manos. Nothing you see here is code
that will be certainly included in QEMU; it's (mostly) throwaway by
design. I don't have much attachment to any of the code except perhaps
the casting and reference counting stuff (which is in, like, the third
rewrite... I got nerd-sniped there :)). But at the same time I think
it's plausibly not too different (in look and complexity) from what
the actual code will look like.

It's also not an attempt to bypass/leapfrog other people in the
design; it's more a "let's be ready for this to happen" than a design
document. The first step and the more immediate focus remains the
build system integration.

But you have good questions and observations so I'll put something
below about the design as well.

On Fri, Jul 5, 2024 at 8:52=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> To give an example of questions we could have:
>
> Why should we have distinct structs for a device, the object
> represented, and its state?

If you refer to the conf and state, a bit because of the different
traits required (ConstDefault is needed for properties but not the
rest) and especially because we can enforce immutability of
configuration vs. interior mutability of state.

In particular, from Manos's prototype I noticed that you need to
access the Chardev while the state is *not* borrowed; methods on the
Chardev call back into the device and the callback needs mutable
access to the state. So some kind of separation seems to be necessary,
for better or worse, unless interior mutability is achieved with a
dozen Cells (not great).

> Having to implement ObjectImpl and DeviceImpl looks like an
> implementation detail, that could be derived automatically from a
> device. What's wrong with calling a realize that does nothing in the end?

The problem is not calling a realize that does nothing, it's that you
are forced to override the superclass implementation (which might be
in C) if you don't go through Option<>. class_init methods update a
few superclass methods but not all of them.

The vtable in ObjectImpl/DeviceImpl could be generated via macros; for
now I did it by hand to avoid getting carried away too much with
syntactic sugar.

> Could device state be serialized with something like serde?

Probably not, there's extra complications for versioning. A long time
ago there was an attempt to have some kind of IDL embedded in C code
(not unlike Rust attributes) to automatically generate properties and
vmstate, but it was too ambitious.
(https://www.linux-kvm.org/images/b/b5/2012-forum-qidl-talk.pdf,
slides 1-9).

Generating property and vmstate declarations could be done with
"normal" macros just like in C, or with attribute macros (needs a lot
more code and experience, wouldn't do it right away). However, serde
for QAPI and/or visitors may be a possibility, after all JSON is
serde's bread and butter.

> This is the kind of things that could be discussed, on a reduced
> example, without specially looking at how to implement that concretely,
> in a first time.

There are some things that Rust really hates that you do, and they
aren't always obvious. Therefore in this exercise I tried to let
intuition guide me, and see how much the type system fought that
intuition (not much actually!). I started from the more technical and
less artistic part to see if I was able to get somewhere.

But yes, it's a great exercise to do this experiment from the opposite
end. Then the actual glue code will "meet in the middle", applying
lessons learnt from both experiments, with individual pieces of the
real interface implemented and applied to the PL011 sample at the same
time. The main missing thing in PL011 is DMA, otherwise it's a nice
playground.

> usage of magic macros as syntactic sugar should indeed be thought twice.
> Return a collection of QDevProperty could be better than having a magic
> @properties syntactic sugar.

No hard opinions there, sure. I went for the magic syntax because the
properties cannot be a const and I wanted to hide the ugly "static
mut", but certainly there could be better ways to do it.

> Another thing that could be discussed is: do we want to have the whole
> inheritance mechanism for Rust devices? Is it really needed?

Eh, this time unfortunately I think it is. Stuff like children and
properties, which are methods of Object, need to be available to
subclasses in instance_init and/or realize. Reset is in Device and we
have the whole Device/SysBusDevice/PCIDevice set of classes, so you
need to access superclass methods from subclasses. It's not a lot of
code though.

> Between having a clean and simple Device definition, with a bit more of
> magic glue (hidden internally), and requires devices to do some magic
> initialization to satisfy existing architecture, what would be the best?
> Even though it takes 1000 more lines, I would be in favor to have
> Devices that are as clean and simple as possible. Because this is the
> kind of code what will be the most added/modified, compared to the glue
> part.

That's an opinion I share but I wasn't sure it's universal, which was
another reason to prototype and post some "scary but perhaps
necessary" code.

> Or have multiple traits matching every possible operation, and allow a
> device to implement it or not, like Read/Write traits. And the glue code
> could call qemu_chr_fe_set_handlers.

Possibly, yes. https://lwn.net/Articles/863459/ you see many such
techniques: traits (gpio::Chip etc.), composition (device::Data),
lambdas (only for initialization).

The advantage of the lambda approach is that it scales to multiple
backends or multiple memory regions. We'll see.

> I hope my answer helped to understand more my point that discussing the
> interface is more important than discussing the glue needed.

Sure, and I don't think we are very much in disagreement, if at all.

Paolo


