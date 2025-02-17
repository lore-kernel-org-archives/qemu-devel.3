Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE93BC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2U4-0008Bx-AX; Mon, 17 Feb 2025 09:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk2U3-0008Bf-3g
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:52:31 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk2U1-0005gO-0J
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:52:30 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso3278055276.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739803948; x=1740408748; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqtaUJztx7c6sd2bjll+P+Uj2HyIK5rXC/EFxbrXhlg=;
 b=mFnYmo469azZEEf2MWF0dCIYRx7W2I6ZOYlpDpqHMxkyN1NzrjH33u9O05/1SSYVKn
 nAcfJ9jFBlf3XQ48q5jPsVtT9Diyhl7LQb1b/uMIIOG11dcFRnobtWP0ywhpJk3fj3pr
 bR4trvHtYLm+EO2+4xXKtEJqB3SxzqxIXqkCH8G8XbT/EjyyfOoYme+mPBgGz1MzaGCN
 w5RLkdDSDt9qb3JVfe+bj3ARBg4CdvKSbpMvfFYsvL4SfBwM+9MjTcg42CEKPl6LQp3J
 MmqE5OoXgJpE9hJvldOmSRE+7YPjdq8UvDH9VLxTrra3w202lnCFdhlvBhMh4nmDQ+lZ
 aUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739803948; x=1740408748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CqtaUJztx7c6sd2bjll+P+Uj2HyIK5rXC/EFxbrXhlg=;
 b=MfQXJWuGFaUd1A5DjNeEr4YI90Wk6vC2mr1uPslEDBJyB6twjse9hnZPmQC5FXOF6i
 eOUNWOaAl0K4QP7AUJvkXEE3IBAFCoptmSWeCPdvL08TjE2AjUAvRxw3thZ4JI6B2B2u
 xTevBKmJOC4efwAHfhlvkftZa51Y8lBOK9qmrOCBFE1uMKO1Zu70uXLhco70kvMhmee3
 cAEXbnbABN0t5nkKIwD9qG1I1hLzsHRmNQNAGHbk88Zq5uzRAnqN11uyFbgeSw9OESsP
 b/geLlhmARNM+FeCw/Th5KjQWcJmK3eMQ7sFur3Y1rJaRjFa2dDll/bdjUxbaU6DDw2E
 2W4Q==
X-Gm-Message-State: AOJu0YzVr6ELRFcDoojKDAX72FSE43yN99Lzd4evS7ra7DaYDE84LKXQ
 njRVLt4A4kKQ2+mXKDsGsCITRwm6maRqimXYFx/uFlMnqnAnXBW82pkF30KJ46E87U1r+udKbM0
 GUF7vFWUnzY3RMD7FJA0vLC67ShSx2RPzfWy4EA==
X-Gm-Gg: ASbGncscu2UAGlCn3Rs5tRl6ZI+XOoUvRT9nC/BVimKwosVVUSU/a8p+XAnlH55o0En
 tpCWOqaB5dXADGEdlWr39ZStN8sPUtlDwkIZdqAHds7s8xcBeJrarFaR+pZDmIiBOGEKIBW/6Sw
 ==
X-Google-Smtp-Source: AGHT+IHOi5+JQv9/btkuGxeRHSPIcijQJFNR0SJ47z8FkjPdYCzCS1iTg67k7YlWyGCQbaxfFCNJwKg5zOlyee9c+X0=
X-Received: by 2002:a05:6902:2b8f:b0:e5d:bef4:30bb with SMTP id
 3f1490d57ef6-e5dc931d3fcmr6798607276.47.1739803947800; Mon, 17 Feb 2025
 06:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20250208163911.54522-1-philmd@linaro.org>
 <20250208163911.54522-6-philmd@linaro.org>
 <CAFEAcA8ZSSD=TxCier0Ji8+DVDspgqKQeKJyVDZ+LEBy=j9=Lw@mail.gmail.com>
In-Reply-To: <CAFEAcA8ZSSD=TxCier0Ji8+DVDspgqKQeKJyVDZ+LEBy=j9=Lw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 14:52:16 +0000
X-Gm-Features: AWEUYZkhhfhvNltNh-iUagXLGbpu8Pe8XubVGT6L4jlk_wWHH0BBDa9JD-Eh-Dc
Message-ID: <CAFEAcA_MLUCqBPLfdwp1u-TEFLz-u5MsmAFeGEYfpOgC0cX8zQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] hw/char/pl011: Consider TX FIFO overrun error
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Mon, 17 Feb 2025 at 14:29, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
> >
> > When transmission is disabled, characters are still queued
> > to the FIFO which eventually overruns. Report that error
> > condition in the status register.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >  hw/char/pl011.c      | 20 ++++++++++++++++++++
> >  hw/char/trace-events |  2 ++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> > index 447f185e2d5..ef39ab666a2 100644
> > --- a/hw/char/pl011.c
> > +++ b/hw/char/pl011.c
> > @@ -61,6 +61,9 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, =
Chardev *chr)
> >  /* Data Register, UARTDR */
> >  #define DR_BE   (1 << 10)
> >
> > +/* Receive Status Register/Error Clear Register, UARTRSR/UARTECR */
> > +#define RSR_OE  (1 << 3)
> > +
> >  /* Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC */
> >  #define INT_OE (1 << 10)
> >  #define INT_BE (1 << 9)
> > @@ -158,6 +161,16 @@ static inline unsigned pl011_get_fifo_depth(PL011S=
tate *s)
> >      return pl011_is_fifo_enabled(s) ? PL011_FIFO_DEPTH : 1;
> >  }
> >
> > +static bool pl011_is_tx_fifo_full(PL011State *s)
> > +{
> > +    if (pl011_is_fifo_enabled(s)) {
> > +        trace_pl011_fifo_tx_is_full("FIFO", fifo8_is_full(&s->xmit_fif=
o));
> > +        return fifo8_is_full(&s->xmit_fifo);
> > +    }
> > +    trace_pl011_fifo_tx_is_full("CHAR", !fifo8_is_empty(&s->xmit_fifo)=
);
> > +    return !fifo8_is_empty(&s->xmit_fifo);
>
> More repetition of expressions, but anyway
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Here I propose to squash in this tweak:

--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -165,12 +165,13 @@ static inline unsigned pl011_get_fifo_depth(PL011Stat=
e *s)

 static bool pl011_is_tx_fifo_full(PL011State *s)
 {
-    if (pl011_is_fifo_enabled(s)) {
-        trace_pl011_fifo_tx_is_full("FIFO", fifo8_is_full(&s->xmit_fifo));
-        return fifo8_is_full(&s->xmit_fifo);
-    }
-    trace_pl011_fifo_tx_is_full("CHAR", !fifo8_is_empty(&s->xmit_fifo));
-    return !fifo8_is_empty(&s->xmit_fifo);
+    bool fifo_enabled =3D pl011_is_fifo_enabled(s);
+    bool tx_fifo_full =3D fifo_enabled ?
+        fifo8_is_full(&s->xmit_fifo) : !fifo8_is_empty(&s->xmit_fifo);
+
+    trace_pl011_fifo_tx_is_full(fifo_enabled ? "FIFO" : "CHAR",
+                                tx_fifo_full);
+    return tx_fifo_full;
 }

thanks
-- PMM

