Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828B4C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rngJi-0000rY-U6; Fri, 22 Mar 2024 10:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rngJd-0000qa-6w
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:56:17 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rngJb-0006Ac-3u
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:56:16 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56b8248e2d8so2710637a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711119371; x=1711724171; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+TZYtMacNOfYRVs+W9TIKrYzeSGZmA6B++6aYUiM6Q=;
 b=D3r3RVWXt64dYTi4bA8s3I68uQ5vNro6/DXuRyXLnIY/a4t/1+0DbITVpnVZ8yIGoB
 Y6Ws9fbmCMI36I3t55DTQtSYqIaWx/mJtxV2sv2wJoUTV2c6JRx/kx4us32RsJQM4TI1
 Vt6gLz+ZpKvge9PXxfVS2AB6WvgHL3mJEs1KakQx4KsJy4YVVrH5uFeAQS/ys/u6Ilx2
 CJdZl7pKtcq+nUKjwGYmOrM9cgT33nrOv3VDE65W3/wHj9CcIfKEgQGOuC7Cfrs8ed87
 pGoQdy33VtbNpRhqoWuv+v0GW6y1C+R7tZcqcR68ZUeEhvMxWKN/e4HCmIhy5j/+GKFA
 k22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711119371; x=1711724171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+TZYtMacNOfYRVs+W9TIKrYzeSGZmA6B++6aYUiM6Q=;
 b=mOXHBT2QRVVnxqBXcICXpwtciYQIaZGfUGKS4DZEa5teyXTHraop9HQzyG+71aZuCN
 M95JjwtHh868aAgoyFdk6gjZNeWnu0GVrDpNz2dylUTkw7Wr3akXkBPEX54TAENnW5sz
 eKZzzRZEJ92RCge56Mae6wmW1sfzpMmFbuZoxwUdj3zRh65ixtR3LbMhWtNGfV59QVFm
 gdMuQs1iFYRRpghHOKgijwuedXcPLnON0sO4AKKxB3N9sQi3TEUHmejlA9kY75OFfuw2
 1RhiBBmpbcodIVBOjHbozRGwhJoBbK2DFDHfYMCIP8gJmzd54ACJaiDV9B4W+QOAprox
 Qfyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE0MS/oALotH9Ke2H6HWrX4cGX0wyxU6K5rwVuBFDMEv5AoThDYJmGoVZGz1zTNzXWl+pJ80xrd4Ip05rgiESeRqufPkk=
X-Gm-Message-State: AOJu0Yz4xqoKHZUGFU6XypPFETtmIh1WpmYfgJudItG01hmFvaHFnOu9
 wgMgG3ZNshubrXGKmJWteRndKWyr2g5bIzUh1mknyvw5V5kEYytiShCnedmLcf4oeNxj+FQ28Ab
 2f2LYGu9VWMJkqEcm2LybOamp6tZdvSIM04lyow==
X-Google-Smtp-Source: AGHT+IGy8E3gmIDfgS1NJyEaT/oIRks3OVSJIWZL2F2M4laHfvm3vcRK0fTZRA/3agueBGdo+GZJn4ATTRuy5rY0owE=
X-Received: by 2002:a50:9b07:0:b0:568:c4ca:987a with SMTP id
 o7-20020a509b07000000b00568c4ca987amr1833694edi.13.1711119371359; Fri, 22 Mar
 2024 07:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240220150833.13674-1-philmd@linaro.org>
 <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
 <cc132404-dcd5-4aed-a481-b46d6e3115b0@linaro.org>
 <CAFEAcA_0qUFW0MewHC+v+pSOisE-kQDt9Wv4F3RafEkyQ0DGJA@mail.gmail.com>
 <59C20F1A-FCFE-4E26-B511-A6C0E1EF6F61@qti.qualcomm.com>
 <CAFEAcA8MVbKqv-TgaO7Vv95f0p164Gao+LT-CM5+92cXjkpmTw@mail.gmail.com>
 <23BCD870-16A1-4AF9-9308-2788178F511B@qti.qualcomm.com>
 <CAFEAcA8=H=xD75T-e6JFnz9RtT2kG2nM5HbqE0AsTiWFe+0a-w@mail.gmail.com>
 <6dfb82c0-d2c0-4618-94b0-2e2561534d96@redhat.com>
In-Reply-To: <6dfb82c0-d2c0-4618-94b0-2e2561534d96@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 14:55:59 +0000
Message-ID: <CAFEAcA-8NzZK4kRRat-Esi19JyFVxbc+A4at0vdrusmzV7ZQYA@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
Cc: Mark Burton <mburton@qti.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, 
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 22 Mar 2024 at 14:08, C=C3=A9dric Le Goater <clegoate@redhat.com> w=
rote:
>
> On 3/20/24 16:00, Peter Maydell wrote:
> > On Wed, 20 Mar 2024 at 14:10, Mark Burton <mburton@qti.qualcomm.com> wr=
ote:
> >> I=E2=80=99d broaden this to all =E2=80=99signals=E2=80=99 (IRQ, Reset =
etc) - and I guess
> >> similar statements apply, with the =E2=80=9Cbridge=E2=80=9D between th=
e function
> >> and the GPIO mechanism moved closer or further from the originator(s)
> >> of the activity.
> >>
> >> The issue isn=E2=80=99t my =E2=80=9Cmachine=E2=80=9D model, rather the=
 compose-ability of
> >> (any) such machine.  A-priori, a model writer doesn=E2=80=99t know if =
they
> >> should respond directly to an NMI or not - Hence they dont know if
> >> they should implement the TYPE_NMI or not. That=E2=80=99s a decision o=
nly
> >> the machine composer knows.
> >> My suggestion would be to use a GPIO interface to models, which can
> >> then be appropriately wired. (And, hence, to have a single place
> >> that implements the TYPE_NMI interface and provides the GPIO wire
> >> ready for wiring to appropriate devices).
> >
> > I feel like that's a long way in the future, but my back-of-the-envelop=
e
> > design sketch of that is that the TYPE_MACHINE class that's implementin=
g
> > the "I am just a container for all the devices that the user has
> > specified and wired together" machine would itself implement TYPE_NMI a=
nd
> > when an NMI came in it would assert a GPIO line that the user could
> > wire up, or not wire up, as they chose.
> >
> > Right now we can't do that though, because, among other reasons,
> > TYPE_MACHINE isn't a TYPE_DEVICE. (I do want to fix that, though:
> > I'm hoping it won't be too difficult.)
>
> Oh that's interesting. Will that introduce an extra level of container
> with multiple machines below ?

No, I don't intend that we should have multiple machines in one
simulation, only that the thing which is "container for all the
machine's devices" shouldn't be a weirdly distinct type from
the SoC "container for devices" devices. What I'm primarily hoping
to remedy by making TYPE_MACHINE a subclass of TYPE_DEVICE to
deal with inconsistencies like:
 * reset of machine objects is nonstandard
 * machine models can't use facilities like having qdev gpio
   lines, so wind up calling qemu_allocate_irqs() directly

None of these are big things, but they're a bit paper-cut-ish.

-- PMM

