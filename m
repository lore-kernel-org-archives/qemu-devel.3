Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E735C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZMl-0000kv-Sf; Thu, 01 Aug 2024 13:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZMj-0000jU-9Y
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:13:25 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZMh-0000PH-Km
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:13:25 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5b3fff87e6bso4676293a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722532402; x=1723137202; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XX6xyXp3Eu7eHbz0e73qKBkFrUxsWO22pZYUSP2GSv4=;
 b=h/wGLoiFCM8A9hJlPXU0jQILsUltGEMuT+cfoom7ctQXE9r9ToH3E9QNZzfmR5r6uL
 uTni643IRecdLQTwCDBfuMVZE73hw0NLYcy349bPoWf5QWM6+HZcS/TQTNyFUrIuTwTQ
 /RKpZ2OXu/dqngZ/vXRGS+NxeNUmHceTfunLkaeVVxwvwmp/0dhPrkQlpQbEGWUTWZan
 COLaCDvUsEQP2+JaoaNUck850P/2yWnIlurRPCZWCdRawPtPXXYJ9qYXvJ0iyoxOgPwt
 1Oomoq3HS3/R0RERE+4uAMbepx6y2Ji0Kak7zfMUcIzc9kwOfjUzrLJ8fDyK0Tceax1I
 GJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722532402; x=1723137202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XX6xyXp3Eu7eHbz0e73qKBkFrUxsWO22pZYUSP2GSv4=;
 b=tcSx62qAh2ps8wvz/gyYA9qPaIjCL/ubGPQhhOqAjVXokFf10yxI2qS/hlrocPKmGN
 IDqTIL9N8y+cRE2jqDPxVV58Me/1FCeosxEl+Tx24MLJH/b2c8xDvkkVVIZkgzIP1Chl
 R6q2/0AjyRyTtbas5EJdfz+oEsYoBrKymaZrn1ri4T+cQmZRV71NmJ/KNvMkxblBy2qh
 Jr7ThOQi+8QIN8hqcO5lL+qAScQ1LazOjAwpngOzYQgrail/Xna95XKzAr/lmn98TOs5
 uWg4BSiMhtmnceFx9WS9HF13lAv5ks31Tq12n4t7x8N/QiWfwz8qLv4LB0Fd1G0xo2A+
 Uj9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9hOODbAsxlORwUqLsxwdf2LwlVBjYf7UKRpLwQDNkxHpg6rlj36PJRZALccgCJ7R172ffLThTn5E6UA6W4/40qdkRYhE=
X-Gm-Message-State: AOJu0YzwkV4NRAl1NYb9sZlH5L1NyeIMgl9fc3uAEVGs62wkhwWYrLnv
 yKiLg+D7+SRsSq9WXGDwhSbSeDIv2VZ7hBxem+9eXIqBKVkW+EhLiReIXhJiEnWSXBBCcP9Xecd
 equK4hV8sbd1MlWmgWg9dMysNUiNhtWqSyJYy5g==
X-Google-Smtp-Source: AGHT+IFsPibWC0IuIoyt+PMJtZQMkXdIMToJJkrk0OwSlsMXjUJeVh3c5hHJN6rmRgB3reef6R/z6E4w0FeWxGRX2lg=
X-Received: by 2002:a05:6402:1642:b0:5a2:2101:a714 with SMTP id
 4fb4d7f45d1cf-5b7f540abfamr721274a12.25.1722532401880; Thu, 01 Aug 2024
 10:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240801150021.52977-1-philmd@linaro.org>
 <20240801150021.52977-2-philmd@linaro.org>
 <5e765e4d-5314-0737-fccf-635d9365f796@eik.bme.hu>
 <20240801113646-mutt-send-email-mst@kernel.org>
 <0d19415f-4ec8-4089-b158-3cc3183232ed@linaro.org>
In-Reply-To: <0d19415f-4ec8-4089-b158-3cc3183232ed@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Aug 2024 18:13:10 +0100
Message-ID: <CAFEAcA9EfC9yB8EYy_wpfGh-1pHx0hByqSkCfcXpKGH7hgFihg@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v3 1/2] hw/pci-host/gt64120: Reset config
 registers during RESET phase
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, 1 Aug 2024 at 18:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> +Peter who is tackling our Reset interface limitations,
> +Daniel for deprecation advices.
>
> On 1/8/24 17:37, Michael S. Tsirkin wrote:
> > On Thu, Aug 01, 2024 at 05:30:38PM +0200, BALATON Zoltan wrote:
> >> On Thu, 1 Aug 2024, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> Reset config values in the device RESET phase, not only once
> >>> when the device is realized, because otherwise the device can
> >>> use unknown values at reset.
> >>>
> >>> Mention the datasheet referenced. Remove the "Malta assumptions
> >>> ahead" comment since the reset values from the datasheet are used.
> >>>
> >>> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> ---
> >>> hw/pci-host/gt64120.c | 14 +++++++++++---
> >>> 1 file changed, 11 insertions(+), 3 deletions(-)
>
>
> >>> @@ -1231,8 +1238,9 @@ static void gt64120_pci_class_init(ObjectClass =
*klass, void *data)
> >>> {
> >>>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> >>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >>> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> >>>
> >>> -    k->realize =3D gt64120_pci_realize;
> >>> +    rc->phases.hold =3D gt64120_pci_reset_hold;
> >>
> >> Why reset_hold and not a simple reset method which is more usual?
>
> DeviceReset is deprecated since 4 years now, see commit c11256aa6f
> ("hw/core: add Resettable support to BusClass and DeviceClass") and
> the effort to convert the legacy interface to this new API:

> Peter, Daniel, do we have a way to hint developers about
> deprecated API uses (like for versioned machines macros,
> commit a35f8577a0 "hw: add macros for deprecation & removal
> of versioned machines"), to settle on a release when API
> must be converted by?

For reset, the stuff I really want to get converted is
the complex stuff (eg bus reset, cases where a device
reset method needs to call its parent method, etc), and
the ancient legacy stuff (eg qemu_register_reset()).
Converting that will make the reset process more uniform
and allow us to get rid of some annoying inter-compatibility
machinery. (Some of this I've already done -- if you look
at the commits in that list, you'll see that a lot of them
are conversions because those classes were using some API
I wanted to remove like device_class_set_parent_reset().
Still haven't quite got rid of that because s390 CPUs are
doing something a bit awkward...)

Also devices where there's something it needs to do in
reset that should properly be done in a phase other than
'hold' obviously need conversion.

For a simple leaf device reset, a DeviceClass::reset method
and a ResettableClass::reset_hold method are essentially
identical, and the amount of glue code we need to make
the Resettable machinery be able to call a DeviceClass:reset
method is minimal. So I don't care about trying to convert
any of the existing uses in the tree or marking
DeviceClass::reset as deprecated.

If we're adding a reset method to a device which didn't
previously have it, I guess Resettable is preferable,
but I don't feel strongly enough about that to ask for
a change at code-review time, and I suspect I've written
new DeviceClass::reset methods myself.

thanks
-- PMM

