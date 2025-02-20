Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23E7C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 10:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl41j-0004zL-Np; Thu, 20 Feb 2025 05:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl41h-0004z4-Kr
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:43:29 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl41f-0008Ds-8w
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:43:28 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e5df8468d6eso734310276.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 02:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740048206; x=1740653006; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXp4D5KK+xM0FM2Jib69e8pArbKgq/P0HpQcCg34iW4=;
 b=xEGW1t7qc5mLI99vX46+7+UgdMR5mopzelmX/qk9cbb2D8VTano9MUdosNRwD/T+OC
 nCeTNMJI2Ko6O73LatsjKLPk1TJNRlxL1YXebxucp8g2n2W/0orMHD3owfzEu6cGqdmv
 D5zv8gRBlni2J+0HpsFvbwgpxM5iEstEQa2sM6Q4K1org1TRu+UV94mjiodNpzyWr0/p
 Cz/KpWTaonKvKYXeBJcEgBsRtErzK7AONN9uJJME0fao0pKYkMYv48JP/n46lWNeOFbt
 ltrOrvSinTJQgclf0w8a9z7IYOKxUUWCb5IQIVxSB1fHPJ0E5o8lBQ/B0AaBGkUppriI
 NAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740048206; x=1740653006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tXp4D5KK+xM0FM2Jib69e8pArbKgq/P0HpQcCg34iW4=;
 b=F6XjGAsDAOJIny1u8x8zhj4MdeIKwPaORqxWChywfahwc4GbWZ5DhzzJMfEzsZyoNw
 XFekCVGLX1e4NkUdfhUlnIi2/oz9D9eYwK7lTQ8Z7RnoIB38atSIECFrO8ooFGZux8X6
 SRMOQtMkWP7n9KrtwlBNqOg5149YcUMtRo/j4Au4ajDoVNja9FzRSSJAZ1JwvimZjdUE
 9J5srP3IQFtUQm4N4LanltkAj1SgM1boCsfa7wqeqGv/ntM7smKudO8um9Pfx4UYaVro
 82QpSnsJTWMo+kKD86W4ATUF9O0G7jGR8lw7df1UNtNxWG0bTUQbDjiW9PlhFBrGLNSz
 MirA==
X-Gm-Message-State: AOJu0Yw2v/0AwrazGbqZuugliq2WY9XASu2pIOzohNX2b3LudVHTsc1Y
 QnJYZfsMPfuR5tiGsDcWKFFx0yWcm6FT5SjYfaknEi+HBDTTZLkNNiTklkf0qZVa+lS03zqRgcX
 yiSc58shZtRwCJefJ2GrBif2Pb/ZPskqsrEXBNA==
X-Gm-Gg: ASbGncu+tYLgsRG+9wQD69Nh1bxFJpdJ3aWVE8j6x9kmex368Q7lFdAa4lR7G2nH41E
 M3xkuOTO2jFqJ/AlBlKia4H/GbmR0+3Ilw0vG4AdN0t7uoMc283dO6WGV6TYuaQm0ETBlsQfDlQ
 ==
X-Google-Smtp-Source: AGHT+IE5twpffXHvaW3HecGS3kxFVLhuXJOdh8TBoGV1WoKAnEHvvMvNkoY1ZvMp64OWQwNUK2XQOn5OWths5CeOPbE=
X-Received: by 2002:a05:6902:1a41:b0:e58:ef9:25d4 with SMTP id
 3f1490d57ef6-e5e0a16d49dmr5178416276.30.1740048205794; Thu, 20 Feb 2025
 02:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20250208163911.54522-1-philmd@linaro.org>
 <CAFEAcA8PYv3-JX66THwj-mDM0es6V5gVVWJsHTqkd9wTEVor4A@mail.gmail.com>
 <CAFEAcA-ioFgThGJ70cyhe7rA0kbnDULsr-BuAqE+3b3TE0BGwg@mail.gmail.com>
In-Reply-To: <CAFEAcA-ioFgThGJ70cyhe7rA0kbnDULsr-BuAqE+3b3TE0BGwg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2025 10:43:14 +0000
X-Gm-Features: AWEUYZkyYxwAPEkdRK-UuVVAoY4asXoD5Hn-LBM2aphUxvqJiHWYh4U8l3Mkyag
Message-ID: <CAFEAcA-fZakXqgDV72fE5sFJv7ah=bvoXYpGqXZZzGutxt7r+A@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Tue, 18 Feb 2025 at 13:54, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 17 Feb 2025 at 14:55, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro=
.org> wrote:
> > >
> > > Hi,
> > >
> > > This series add support for (async) FIFO on the transmit path
> > > of the PL011 UART.
> > >
> >
> > Applied to target-arm.next, thanks (with a couple of minor
> > tweaks to two of the patches).
>
> Unfortunately I seem to get failures in 'make check-functional'
> with the last patch of this series applied.

I had a look at this this morning because I wondered if it
was a mistake in the style fixups I'd applied to the patches
on my end, and I found the bug fairly quickly. The problem is
that pl011_xmit() doesn't update the TXFE and TXFF FIFO empty/full
status flag bits when it removes characters from the FIFO.
So the guest kernel spins forever because TXFF is never unset.

The following patch fixes this for me (and also makes us not
set INT_TX for the case where we couldn't send any bytes to
the chardev, which I noticed reading the code rather than
because it had any visible bad effects):

--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -256,6 +256,7 @@ static gboolean pl011_xmit(void *do_not_use,
GIOCondition cond, void *opaque)
     int bytes_consumed;
     uint8_t buf[PL011_FIFO_DEPTH];
     uint32_t count;
+    bool emptied_fifo;

     count =3D fifo8_num_used(&s->xmit_fifo);
     trace_pl011_fifo_tx_xmit_used(count);
@@ -280,15 +281,24 @@ static gboolean pl011_xmit(void *do_not_use,
GIOCondition cond, void *opaque)
         /* Error in back-end: drain the fifo. */
         pl011_drain_tx(s);
         return G_SOURCE_REMOVE;
+    } else if (bytes_consumed =3D=3D 0) {
+        /* Couldn't send anything, try again later */
+        return G_SOURCE_CONTINUE;
     }

     /* Pop the data we could transmit. */
     fifo8_drop(&s->xmit_fifo, bytes_consumed);
     s->int_level |=3D INT_TX;
+    s->flags &=3D ~PL011_FLAG_TXFF;
+
+    emptied_fifo =3D fifo8_is_empty(&s->xmit_fifo);
+    if (emptied_fifo) {
+        s->flags |=3D PL011_FLAG_TXFE;
+    }

     pl011_update(s);

-    if (!fifo8_is_empty(&s->xmit_fifo)) {
+    if (!emptied_fifo) {
         /* Reschedule another transmission if we couldn't transmit all. */
         return G_SOURCE_CONTINUE;
     }

If you're OK with that as a fix then I'll squash it in
and keep the series in target-arm.next.

thanks
-- PMM

