Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94133C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7Xe-0007yu-Li; Mon, 18 Mar 2024 03:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rm7XX-0007yD-CE; Mon, 18 Mar 2024 03:36:15 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rm7XV-0005vA-FV; Mon, 18 Mar 2024 03:36:11 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-430ca04b09bso6881451cf.1; 
 Mon, 18 Mar 2024 00:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710747366; x=1711352166; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9UyfahqH/o+NUwLUIWz1me0FxA9omKJwbxcre7d/ZE=;
 b=T1MpPItSYLK6uptViWO3mvcqtnAdceCN93VbrHthmWtQl14QTGz+t6WHn4Mk3Of+Ym
 FISenz5fjCSEJMndzuAFuG6BCZ6bX1M9gJNo2BEBX5yCgVKpFoEAVmLoK3jlrLglWaTw
 idWv3bv7GH6w6ACgLFu+Y9cAoPoQuGAdzGyFjFZxR6oE4Yg5PAe7ChayU8/LVutU+ks1
 VGxaroUnjw8j/DVRe5QkMLO3l3VKdUKUa2McZrT6SdXjJnCDW1kPebBUe/PBVLGk8Jzk
 i/EtJPGto9VH6I9tl5oD5YOQMD6SiYEDeLg5RCVdBAdWv3XEEBDyVQCgFfmelxfZ8Z2L
 R5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710747366; x=1711352166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9UyfahqH/o+NUwLUIWz1me0FxA9omKJwbxcre7d/ZE=;
 b=Qc4WKvyQvImLPNE5JjURrIv78XrIToEy0XyZtif4Lwp8xRB6d/9AxAmXGGFc4vduhH
 lWO37YVOoxsVwgr+ntwsY/r7OcbctkIh4/W6I2RX91jVQVCJp2tXzYnvdOspfzrJSH2X
 NRZZed8foh7RC4h4CAo5ddUJmY/8hzuNIGdlEIlXeWrzcROwkF0/0UJbumkPtnlSPrmN
 43tmu3Ew9RaaEh5kLexqCY1xaKDFXgayiJqk2gWWBq9p8pblXmRs904gLRUnYLKxOS8A
 8q1/ChvPw22FxvJyDlDjdGRCLQOVPS8y8V0/kNd5ROBlg3PwahS+H93TFE5E1gO2S454
 XEVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAUyTfrWaKv1s12fNY+DEchv6bY3ZNVfVCXfpTranErMh9YG7l9WVbJT941OfNUJ3vo7dazDAVpVY20fFGQniP+J2+fKB/4fg8bPO+f/V/6CSC1ATbyYbCTgQx9Oo=
X-Gm-Message-State: AOJu0YzOZUb1IGbArVyGXWr4QME3/W70Fz4jCHpOP00zJFfseb7lXM41
 3BAboliMg0M5HHvu+jF47SgJFqv2jkxE8Fjf3yrqfHIkvDUFH9E5VUStYeNh+UenA/WOXu+rKZ2
 Qj/H5kKDZUk4fPf062gO7qzTAhVvYkxBRYetlZg==
X-Google-Smtp-Source: AGHT+IHYgrwQEqfIA9AEealiGnB/hdAmc0k2f6Pydq3S1HHp2RqpUdhyHVyK1Dqng6xWiGT3WkGZmHKdy32la9Lc63A=
X-Received: by 2002:a05:622a:8ca:b0:430:d8ef:3325 with SMTP id
 i10-20020a05622a08ca00b00430d8ef3325mr613675qte.47.1710747366390; Mon, 18 Mar
 2024 00:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240314220038.1aaae79f.olaf@aepfle.de>
 <4b803768-09df-4b6c-a745-f0158543310d@tls.msk.ru>
 <20240316231945.7bcfac09.olaf@aepfle.de>
 <a9e4fac5-2a1e-4d15-afa5-bae42756ec42@tls.msk.ru>
In-Reply-To: <a9e4fac5-2a1e-4d15-afa5-bae42756ec42@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 18 Mar 2024 11:35:54 +0400
Message-ID: <CAJ+F1CJyhEYhXewLV4SOGNfgiA3V2kfotVqYgcGEckvO4XLp7A@mail.gmail.com>
Subject: Re: Regression in v7.2.10 - ui-dbus.so requires -fPIC
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
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

Hi

On Sun, Mar 17, 2024 at 11:10=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>
> 17.03.2024 01:19, Olaf Hering:
> > Sat, 16 Mar 2024 22:40:14 +0300 Michael Tokarev <mjt@tls.msk.ru>:
> >
> >>       meson: ensure dbus-display generated code is built before other =
units
> >>       (cherry picked from commit 1222070e772833c6875e0ca63565db12c22df=
39e)
> >
> > "static_library" is used often. Some use the 'pic' option, which fixes =
the issue.
> >
> > I think every usage that ends up in a shared library requires 'pic:true=
'.
>
> The prob here seems to be that while fixing other issue (header file isn'=
t generated
> early enough), we all forgot about the fact dbus-display1.o can be used i=
nside a
> shared/loadable object when qemu is built with --enable-modules.
>

dbus-display1 is also used with static linking for the unit test.

It looks like the simplest is to let the actual target decide how it
is built, even if it is compiled multiple time then:

-  dbus_display1_lib =3D static_library('dbus-display1', dbus_display1,
dependencies: gio)
-  dbus_display1_dep =3D declare_dependency(link_with:
dbus_display1_lib, sources: dbus_display1[0])
+  dbus_display1_dep =3D declare_dependency(sources: dbus_display1,
dependencies: gio)

This makes commit 186acfbaf7 ("tests/qtest: Depend on
dbus_display1_dep") no longer relevant, as dbus-display1.c will be
recompiled.

Alternatively, we could always build with pic: true (or pic:
enable_modules), but that's not ideal either.

--=20
Marc-Andr=C3=A9 Lureau

