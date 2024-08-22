Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE0DC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 20:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shE4D-0003JM-KG; Thu, 22 Aug 2024 16:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1shE48-0003Gw-Kd
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 16:05:52 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1shE45-0006fx-2n
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 16:05:51 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5bebb241fddso839a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 13:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724357145; x=1724961945; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHjw9TuxbXlkebqSQdiQuYwr40RhVog8KVJbsePag34=;
 b=cWQcN3NuOslqR9465K1AKXioANTfkqSYQjz5KHkveJYPTgyb7ri7N3dfLmXhZuEgWD
 VqSuXaKAc0vQc8tAlWRdFPKJp2sfhD2b9ZvIh6Zmi7lAN0GKRK2D+Wht2petH/XpKAPc
 HnltRS0rVFKZ8EEfyctreKOnNGsDZ2kWeN06DXirmP2DYZC/MOc29OWgYm8R3K3TCqj0
 zdLT47PNjJ+QNmbwuHjlvMfdOEUQKXpmVEntmWN4PkpZEE8Xf9Sq71agLIQ83WT1kGkr
 03xjIGNAisiinw/zeNpA4H3UlRXCgn9v+uC9nqFoUvRvXkdnwC89fbYTEobuxklZEDxg
 lDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724357145; x=1724961945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHjw9TuxbXlkebqSQdiQuYwr40RhVog8KVJbsePag34=;
 b=WgdYIjPOKPEz/nxjDL5oLhfFxzZXbSxMxxR67tOmNbStu6SGMOB+RtMIjhak6u/L5N
 pN68nJb1m/7ShKskBhbxsR+hhGR73o4Fcfkfk1HpIMWIkPZWOwI3icN3u5g07OW6zNcx
 JYtgoyyz9h0LqkAxRah3h34IgLH7zo9/cjpokAzkX16ORvOmIhyi2HdeyuQ898bWJ0R/
 mV3klxj6IA1ReOFFBW6diDORpygavqIakGnnqzw3YH0uXNDl4REHQNwDAWY+wSlHTzhJ
 i6mvFiX/IvD8reg9y9xESIX4FZ0e4k5nr6lStXnPouIcFol/09SAn7lVLjdaj4w7x+2z
 MmRw==
X-Gm-Message-State: AOJu0YxS6+dw5MiN2jFptsUqywbbF76Y7ORkbDdvvWILs4i0b/iUoAd7
 MQUeDq0ZOwsTzUja9UXqsCOzbQ5bkxzypI/XtmeMoDLf02xI1wwSK4u0lVuo22Nk9tGh190DOG+
 QAnRnqpsvBaZJFAJwGQa68adQIYlMPxTT6d1s
X-Google-Smtp-Source: AGHT+IEFu3g6h5KWslR3XSlVIC6zId0q/ccWNf4NqAl/DrltZTyO0uqtblzVh9B9bzmk8JmaaqP3wB7BvcixI6+6szo=
X-Received: by 2002:a05:6402:40c5:b0:5be:ce7d:ad0d with SMTP id
 4fb4d7f45d1cf-5c086ad8aa2mr51956a12.0.1724357144242; Thu, 22 Aug 2024
 13:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
 <CAFEAcA8gg1u4_HwG9QOHj4RqfHgNLkT5nHLTFNrcaHdgL+zEPQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8gg1u4_HwG9QOHj4RqfHgNLkT5nHLTFNrcaHdgL+zEPQ@mail.gmail.com>
From: Octavian Purdila <tavip@google.com>
Date: Thu, 22 Aug 2024 13:05:33 -0700
Message-ID: <CAGWr4cQ7rWaCo3q71+EaTQMXf1p-pdxL88s5tg_kzeLNo7DTRA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/23] NXP i.MX RT595, ARM SVD and device model
 unit tests
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, thuth@redhat.com, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=tavip@google.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Aug 22, 2024 at 6:28=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Sat, 17 Aug 2024 at 11:26, Octavian Purdila <tavip@google.com> wrote:
> >
> > This patch set adds support for NXP's RT500 MCU [1] and the RT595
> > EVK[2]. More RT500 device models will be submitted in future patch sets=
.
> >
> > The goal of this first patch set is to provide a minimal set that
> > allows running the NXP MCU SDK hello world example[4].
> >
> > The patch set introduces a (python) tool that generates C header files
> > from ARM SVD files[3]. This significantly reduces the effort to write
> > a new device model by automatically generating: register definitions
> > and layout (including bit fields), register names for easier debugging
> > and tracing, reset register values, register write masks, etc.
> >
> > The generated files are commited and not generated at compile
> > time. Build targets are created so that they can be easily regenerated
> > if needed.
> >
> > It also introduces unit tests for device models. To allow accessing
> > registers from unit tests a system bus mock is created.
> >
> > This can potentially introduce maintainance issues, due to mocks or
> > unit tests getting outdated when code is refactored. However, I think
> > this is not an issue in this case because the APIs we mocked (system
> > bus MMIO access) or directly used (irq APIs, chardev APIs, clock tree
> > APIs) to interact with device models are stable at this
> > point. Anecdotally, our experience seems to confirm this: we only run
> > into one (trivially fixed) breaking upstream change (gpio getting
> > removed from hwcore) in the last three years.
>
> My main issue with the mocking is that it introduces a
> completely different way of testing devices that is
> not the same as what we use for any existing device.
> QEMU already has too many places where there are multiple
> different ways or styles of doing something, so adding a
> new one should be a high bar (e.g. "this lets us test XYZ
> that would be impossible in the old way") and preferably
> also have a transition plan for how we would be
> deprecating and dropping the old way of doing things.
>
> So my inclination here is to say "you said that you could
> do the testing of this device with qtest, so use qtest".

Looks like I missed some things when I looked at it, probably minor or
a matter of preference in the great scheme of things. It might still
be worth mentioning them here.

In patch 19 we are testing exposed clocks and AFAICS there are no
qtest APIs for that. We can probably add a qest API for that though.

In patch 9 we are using internal APIs exposed by the generic flexcom
device to check that device selection works as expected. I don't see
how we can reimplement that with qtest, this is a classic example of
what unit tests can enable vs functional testing.

There are also a few things that are a bit cumbersome to do with
qtest. In patch 13 and 16 we introduce i2c and spi echo test devices
to test i2c/spi transactions. I've noticed that device qtests use an
existing i2c peripheral for tests. We could add the i2c and spi test
devices to qemu and have them enabled by default. Or continue using
existing spi/i2c peripherals for testing spi/i2c controllers for
qtests which I personally don't like because it requires knowledge of
specific peripherals.

That being said, I'll go ahead and switch to qtests, if only to better
understand advantages / disadvantages and separate this patch from the
bigger device unit tests discussion.

> If we were designing a "test devices" framework from
> scratch, using mocks would probably be a strong candidate
> for that design, but we aren't starting from scratch.

I still think that writing device tests as unit tests is better:
 - devices can be tested independently
 - we can test more, including internal behaviour and APIs, error paths, et=
c.
 - enable sanitizers by default for device tests*

I wonder what people think and what would be a path to enable device
unit tests. What would we need to prove, besides converting existing
device qtests to unit tests, which I can certainly help with.

*I was surprised to see that sanitizers are not enabled by default on
unit tests when host dependencies are available, what is preventing
that?

