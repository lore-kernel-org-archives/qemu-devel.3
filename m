Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4627AC021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2Hl-0000sv-AO; Mon, 17 Feb 2025 09:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk2He-0000ZH-VI
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:39:43 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk2Ha-0003gm-9c
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:39:40 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6f9aa66cbe8so34771837b3.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739803177; x=1740407977; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RfeVFL/7Pgf5C8rBy/PRDnAc2i72PnzzwI+WiTIYms=;
 b=GOzEbT3BWXkCsvKghb6EjIZtCDGEfv6XS3CiGNEA7d0fRDNH4/2H0zywpnVw/65zMm
 zCFyDWfiFo5mBQK6U2sD6Rsj0v8MafvPIFvtsoSXEfFRKXb4KsoxqDXYTXzMG7it0Z+t
 zBcrBQ5wmqVUlbbwvAm+pgsCa52fjXBTF8ymfPO4dNGYyGxFgHf1TnJpJQUkrilIQmUJ
 8bRGypoc8uRZ131yQo7cfczVJwvDDU/vMWQ7bxY2SqjjV2Tozf6gUluCTQZGsq5xc73a
 DzMJZrukH/qbVbFp0svSKxbGVmm69YypERqx1RZMWVmmjZQlOkz5rq/2oSZQnTlP8JIL
 X6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739803177; x=1740407977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RfeVFL/7Pgf5C8rBy/PRDnAc2i72PnzzwI+WiTIYms=;
 b=GBK0meJj9UKy4cvAzRKHGaUfKovt4AfiIOk0WP+ZgaBTsWKF8GW3HnedXPoYROpaUG
 GtkcpDfnKR27RBRHNtqtiK5ofbEOXTmNK14Zi+wMJEeOfkKVueVC57yETPjHuHFDRTnW
 UoMI5BEjl9uFB51hYGODINtZzjYPLU8yOGWrrBr6vSFY1od9LHTX+eRysSaq046TsJ72
 ddq/i242tQPQA3IpjlvVtKnR6EDDB/XgDHLZy+lBEqbtMGw+nrof3vAIaJEYaLvfJk/k
 FcFqp3HSIqCE9dsyhW913IV27PYVfpuc4TPyEqEsRFi1dZCEAXxlgJO9ZK2XGzyxbYE7
 XwHQ==
X-Gm-Message-State: AOJu0YzniI8tk1lp22ob3Q1Q3zCkU7foI64wHpeoW0ute+Ngvwv3JKO2
 Eo1ZLf275ItPDmyBQpt/WVLj25uDOin7NsHwaLWRAP3ZM31EEvfGkR+J3nF66smFNRvOhQ3lCvz
 vgNCVpr8OLgaX5zeUhsrTm5GY9ob4FBint9xynA==
X-Gm-Gg: ASbGncvlZ776SDo9Qb3taBTcep0RmiYoJ/R4k4sMlN1YU/fcMwUHGHryM10FoGkL0iR
 vErtn7CdubNTvHo3rX/B3w5NIWjhCKfs9T75x4g5eSsOv8ATuOQ/bMy2+Yrvlo3Fo+Rrd9Clxqw
 ==
X-Google-Smtp-Source: AGHT+IGXVSI+MhROu/JHs+t7/bs+/l0JMYC5jDsDKt+onl42dVXRN8dUnMLoxO2J8UMn5QjA0dbgcNkUCThhm1xo1NE=
X-Received: by 2002:a05:6902:2684:b0:e5d:c30f:22ec with SMTP id
 3f1490d57ef6-e5dc900e896mr6436762276.9.1739803177030; Mon, 17 Feb 2025
 06:39:37 -0800 (PST)
MIME-Version: 1.0
References: <20250208163911.54522-1-philmd@linaro.org>
 <20250208163911.54522-5-philmd@linaro.org>
 <CAFEAcA-tQUL2Rt4Y_eNFxCFXzNXupzQz3qYdEupB6Bb3HFyhfw@mail.gmail.com>
In-Reply-To: <CAFEAcA-tQUL2Rt4Y_eNFxCFXzNXupzQz3qYdEupB6Bb3HFyhfw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 14:39:25 +0000
X-Gm-Features: AWEUYZkdzG9yLQ6nYHX4IOYClySz87ahHbKy-fvk_EjfzGW3nOgJBUSVgoHuAnk
Message-ID: <CAFEAcA_66f2t2UQv5eKwspDTBs+kfvpGsMPG6f31aqs6FWMx=w@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] hw/char/pl011: Trace FIFO enablement
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

On Mon, 17 Feb 2025 at 14:27, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >  hw/char/pl011.c      | 4 +++-
> >  hw/char/trace-events | 2 ++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> > index b9c9e5b5983..447f185e2d5 100644
> > --- a/hw/char/pl011.c
> > +++ b/hw/char/pl011.c
> > @@ -148,6 +148,7 @@ static bool pl011_loopback_enabled(PL011State *s)
> >
> >  static bool pl011_is_fifo_enabled(PL011State *s)
> >  {
> > +    trace_pl011_fifo_is_enabled((s->lcr & LCR_FEN) !=3D 0);
> >      return (s->lcr & LCR_FEN) !=3D 0;
>
> Might be neater having a local variable rather than
> repeating the expression twice.

I'll squash in this tweak:

--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -148,8 +148,10 @@ static bool pl011_loopback_enabled(PL011State *s)

 static bool pl011_is_fifo_enabled(PL011State *s)
 {
-    trace_pl011_fifo_is_enabled((s->lcr & LCR_FEN) !=3D 0);
-    return (s->lcr & LCR_FEN) !=3D 0;
+    bool enabled =3D (s->lcr & LCR_FEN) !=3D 0;
+
+    trace_pl011_fifo_is_enabled(enabled);
+    return enabled;
 }

 static inline unsigned pl011_get_fifo_depth(PL011State *s)

thanks
-- PMM

