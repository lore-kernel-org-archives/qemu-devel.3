Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E895C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 06:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmRwY-00040Y-6J; Mon, 24 Feb 2025 01:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmRwW-0003zx-JS
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 01:27:52 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmRwU-0005mD-L2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 01:27:52 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4be4de0c038so1222897137.0
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 22:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740378469; x=1740983269; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3l2HZUlZEvlISDsBbCYUwKhkbNz6xAdu6yZS+vveod4=;
 b=g+4/GnD2lS8l4SikXbq/wD/Hr2S+PtzUXxg2/gEnpKJhpSBKjADHm+gux+rOmUwvVg
 y69NzE59NQSL/202Lv8oLO+MpMK69aBpesm5NkOh7DGOQBIuLdL7JIQwl4xSqgObrrTq
 lOh0MaWJwzD7PfkhCuj2R2GZj71KDKGgCXGP54emILE/t6iBk15LKQCcwi0qXbOfTIHg
 pVTYtdqlvI5t8OtM5u4kpyyPAbsQSWJpNvkh+GfV3D2o7qq066rrOsjMa9e8vhGqtuu6
 lShmmcheQZszR+evjm+X5Fa/X3pOmoEPvQQnGd5fmoNJQcGuemfkthpqN+QcU1cEm/5F
 NUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740378469; x=1740983269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3l2HZUlZEvlISDsBbCYUwKhkbNz6xAdu6yZS+vveod4=;
 b=g7A78Qw9ecuLumffbIwA0UTwBeK/CUEzR2zWzM5ZVNRwvRmz6/a6O5x+g9NPFd0ptt
 AaHxvlOpH24/LLUt6KyCz3NwLMB56JRNJVL2kJjQPMtHA7MmJKa471qwxXRojRit4fJa
 OIE8jX6DmQ9KjfspE1vMLdYaDcYAnsjplZaWrunbZLwoFEG+RRod2awe0+YDK3cw/Zv+
 AmgrO3/6BoukIoTyKp+4RJf1A+mElJgkdmwuAtI+G5ysXkxDpFUggEyF9ZmN6aVGlO1s
 HAx64my14CrEuUg85AgCKfZihZ8A30ggJ4o4TSmxO5yicSB3ScIgayF6m3Mp+EcwMNf5
 MOHg==
X-Gm-Message-State: AOJu0Yw5CzzlwpPC6zB0DdFpEcDLUyiZg5zvfqkcQ+hMQEG/edB92tFv
 uhekBQH+7dtVF/kDfciOTIm3cTdzoGUWnJ1awmH5rMfBFpGubZ9rXumcSRYeoeomqFJsfr/vrKU
 DRil0KCdBg9+yzllzXMi2LemWv7E=
X-Gm-Gg: ASbGncuuUgUtvS1K+YlTgIEmVCqQoqb7p7YcQM/YsQ9kdGIIcb1vozc5M3oT9nR4226
 FEOKaK/5JZb7asG42qUX8S1mp2JvohJ7EcdO/gm2X9xwxr6WDF7I7wW8FlCx4vt/BkJ+OBqeDsG
 nrrcItS4Xy2qjQFxQ/sv/I/WeUNKW4n/feMZg5
X-Google-Smtp-Source: AGHT+IHxsEoqGKsLMpD0/qOWTvf8EoIrvc9iUsqF/NeIZUVSFJYx7vZbhoqNL/Qux7sAgQI8diEZLKyd6qW+x0LdA9I=
X-Received: by 2002:a05:6102:5087:b0:4b2:48ba:9943 with SMTP id
 ada2fe7eead31-4bfc2952989mr5680009137.24.1740378469215; Sun, 23 Feb 2025
 22:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
 <20250214062443.9936-4-sebastian.huber@embedded-brains.de>
 <CAKmqyKNZfBcqT08v-wYmApYuQgM7in__Q3b_vwEgZp+sXr8ckA@mail.gmail.com>
 <1989799473.175.1740375822271.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <1989799473.175.1740375822271.JavaMail.zimbra@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 16:27:23 +1000
X-Gm-Features: AWEUYZkZFFou-ayQSiW8SZ6MaGar_PZc4iFVSsCbtiRqflJG5EwzmWY-UXZbHkA
Message-ID: <CAKmqyKNCYcjZsiSB44a_JfLJ4L70QL+ofoP0UqOS0p=tk1e_Vw@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/riscv: Make FDT optional for MPFS
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Conor Dooley <conor.dooley@microchip.com>, 
 Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Feb 24, 2025 at 3:43=E2=80=AFPM Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> ----- Am 24. Feb 2025 um 6:22 schrieb Alistair Francis alistair23@gmail.c=
om:
>
> > On Fri, Feb 14, 2025 at 4:27=E2=80=AFPM Sebastian Huber
> > <sebastian.huber@embedded-brains.de> wrote:
> >>
> >> Real-time kernels such as RTEMS or Zephyr may use a static device tree
> >> built into the kernel image.  Do not require to use the -dtb option if
> >> -kernel is used for the microchip-icicle-kit machine.
> >
> > That's a fair point, but it might also confuse people who expect QEMU
> > to generate a DTB if they don't specify one.
> >
> > This at least needs a documentation update, but a warning log might
> > also be warranted if no `-dtb` is supplied
>
> I will add a documentation update to:
>
> docs/system/riscv/microchip-icicle-kit.rst
>
> Should I change this patch to require "-dtb none" to select no DTB at all=
?

I don't think so, generally not specifying something means that it
won't be loaded (-bios is just odd for historical reasons).

Maybe just a log warning like "The QEMU Icicle machine does not
generate a device tree, so no device tree is being provided to the
guest".

It'll be a bit annoying for people who don't want to run Linux (like
your case), but all other Linux class RISC-V boards provide a DTB, so
it's a little confusing

Alistair

>
> --
> embedded brains GmbH & Co. KG
> Herr Sebastian HUBER
> Dornierstr. 4
> 82178 Puchheim
> Germany
> email: sebastian.huber@embedded-brains.de
> phone: +49-89-18 94 741 - 16
> fax:   +49-89-18 94 741 - 08
>
> Registergericht: Amtsgericht M=C3=BCnchen
> Registernummer: HRB 157899
> Vertretungsberechtigte Gesch=C3=A4ftsf=C3=BChrer: Peter Rasmussen, Thomas=
 D=C3=B6rfler
> Unsere Datenschutzerkl=C3=A4rung finden Sie hier:
> https://embedded-brains.de/datenschutzerklaerung/

