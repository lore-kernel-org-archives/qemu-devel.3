Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3CFC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 11:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4Mh-0002wM-N1; Thu, 20 Feb 2025 06:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl4Mg-0002vi-5d
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:05:10 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl4Me-0002X6-39
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:05:09 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6fb73240988so5021077b3.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 03:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740049507; x=1740654307; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYdJeJG+A3qoQT6NxoCYcF2tRFQaYTlQIoqqfDLP8NA=;
 b=KPFOqdtAhCWeoZ2FUuxlu45bFv11zJWiR7UUfp1lGrUnsTqSrlmfRWf/OpUR4l1xrQ
 Bd9LAkrn8P+7tta/0Xu/fmdLZS14wUSVVc8fyuMTLGMckrD3TIF/3zjQ+RqzY3IthLNM
 v9kMXQqAsfMSIcSstf5FqTCiKfvbNZewa7Ns+tdRcdMF6FmwgP7GGp1AlyyP4bI+QYTq
 yz/2SNnsfy7rNFrs6KYT4CG76djjA3W+txMfHlVyRV6ka5z9gADSBJLlZGDPS2quoZaq
 m3L/4ll266J3F6cq/uHlduGli/7WUD1byKzetUyYG55baW7dV7FUlEIv3RZq14SMIjyt
 DlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740049507; x=1740654307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYdJeJG+A3qoQT6NxoCYcF2tRFQaYTlQIoqqfDLP8NA=;
 b=AgBunYrnB85YHmAE8npaSg9QUCDocVG043hEWFkQt3sfRrpn8jm1vF9eKCmAqtqY9B
 Qd8hhRSpiV8YSu1Mcrp3UF/RK69REVP+OUIVKkAX8tihoqkLo3X576/JLVJMHGorKp2+
 hH9SRDuSSZvv5+SeetULL9blTOTBFdKpeBqf6itRKPr3K9Rp9pKfhCxHsQlJEyVkJnIF
 SartU13d7g5lgfgZzy2tGoVY3vyJIqvOaOCBwa+5iMpgU8yKr5PMrQMMxjFUL9Eayz9p
 o+QyhPvbBrZZlfzxyZl8v22HYlJT7Wd26VYYbrXBw7lidhcyoc3reIMJTqe8ZHsWYauT
 WrCA==
X-Gm-Message-State: AOJu0YzOXztmBNPZ1JRbWkb03dCnambL3jklQN0fKqpfJLny+Meo3HJ8
 1+d7+zWYL7SLYmamuAlslkmSFUPuAFGu1djTIb2Ktz+fQJU1yHfi2f5ZEujNKvtPaqPxyrrGs60
 f0Gj41wjzGTHL2aPQI8qnjoEf6iYrKwPxemTneg==
X-Gm-Gg: ASbGncuzmcMJgDdJwxbqbOC2TamnCu1P6l2Rv3s/sUjqtM76sRDCjkDa+pVC8B3pd70
 ih4jWFeu99hIn4Ss2z1VvpHyV5gLyQkobVTwirB49TXkWwBlTzHbMmCexRtiK9ygiBG+/ZM5IIQ
 ==
X-Google-Smtp-Source: AGHT+IFRzFNTI4lNM501OJddrzMjnncdSjAsLfOYPFOf/JjbCQEA+JtQEZ6y8dy2c6OSiCpu06tZZHXUV6XuVwY0x3o=
X-Received: by 2002:a05:690c:9c09:b0:6ef:4cb2:8b4c with SMTP id
 00721157ae682-6fba579e7b8mr68444527b3.23.1740049506700; Thu, 20 Feb 2025
 03:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20250208163911.54522-1-philmd@linaro.org>
 <CAFEAcA8PYv3-JX66THwj-mDM0es6V5gVVWJsHTqkd9wTEVor4A@mail.gmail.com>
 <CAFEAcA-ioFgThGJ70cyhe7rA0kbnDULsr-BuAqE+3b3TE0BGwg@mail.gmail.com>
 <CAFEAcA-fZakXqgDV72fE5sFJv7ah=bvoXYpGqXZZzGutxt7r+A@mail.gmail.com>
 <CAFEAcA-UP5VcDokb11KfpmQztRnWFS9pLcMZ5_2pe=BBKEv7Fg@mail.gmail.com>
In-Reply-To: <CAFEAcA-UP5VcDokb11KfpmQztRnWFS9pLcMZ5_2pe=BBKEv7Fg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2025 11:04:55 +0000
X-Gm-Features: AWEUYZmnHuUcS6GYlyYoxVfkOnMcx_1hdfv7x-M395WG2X8YB9mIfJWWyZIJKxc
Message-ID: <CAFEAcA_PUcnpwti4m1MgGbcVBFFHv1DSvNrzchkqTW5TVMU2pw@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 20 Feb 2025 at 10:52, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Thu, 20 Feb 2025 at 10:43, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Tue, 18 Feb 2025 at 13:54, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > >
> > > On Mon, 17 Feb 2025 at 14:55, Peter Maydell <peter.maydell@linaro.org=
> wrote:
> > > >
> > > > On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@li=
naro.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > This series add support for (async) FIFO on the transmit path
> > > > > of the PL011 UART.
> > > > >
> > > >
> > > > Applied to target-arm.next, thanks (with a couple of minor
> > > > tweaks to two of the patches).
> > >
> > > Unfortunately I seem to get failures in 'make check-functional'
> > > with the last patch of this series applied.
> >
> > I had a look at this this morning because I wondered if it
> > was a mistake in the style fixups I'd applied to the patches
> > on my end, and I found the bug fairly quickly. The problem is
> > that pl011_xmit() doesn't update the TXFE and TXFF FIFO empty/full
> > status flag bits when it removes characters from the FIFO.
> > So the guest kernel spins forever because TXFF is never unset.
> >
> > The following patch fixes this for me (and also makes us not
> > set INT_TX for the case where we couldn't send any bytes to
> > the chardev, which I noticed reading the code rather than
> > because it had any visible bad effects):
>
> Hmm, but that's clearly not the only problem -- it fixed the
> "no output at all issue", but now I see a test failure because
> of garbled console output:

> I also noticed that pl011_write_txdata() doesn't clear TXFE
> when it puts a byte into the fifo -- I'm testing to see if
> fixing that helps.

Yes, with this patch also:

--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -330,6 +330,7 @@ static void pl011_write_txdata(PL011State *s, uint8_t d=
ata)
     if (pl011_is_tx_fifo_full(s)) {
         s->flags |=3D PL011_FLAG_TXFF;
     }
+    s->flags &=3D ~PL011_FLAG_TXFE;

     pl011_xmit(NULL, G_IO_OUT, s);
 }

this remaining failure is fixed and I get a clean pass (other than
the gpu test failure, but that's not related to the pl011).

-- PMM

