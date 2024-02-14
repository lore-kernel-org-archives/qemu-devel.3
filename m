Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA9FC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 12:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raEZb-00061d-5U; Wed, 14 Feb 2024 07:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbaryshkov@gmail.com>)
 id 1raELP-0007Y4-4k; Wed, 14 Feb 2024 07:26:31 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbaryshkov@gmail.com>)
 id 1raELM-0008EX-JP; Wed, 14 Feb 2024 07:26:30 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-561587ce966so1329628a12.1; 
 Wed, 14 Feb 2024 04:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707913585; x=1708518385; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFA1a42wCiNZvvQNKbqvgbniuQocv8cVbeveUQsSW+Q=;
 b=HOuGE++LDiyk4YepFrSJsVbUWU8SeeGbuo0wnEIeej+8SyITCGjTss255NPgWepGH6
 Q7Fom1THI4gnoaKG6UXKjoR1aqw3SUeJVL9TGcmKTvskG20swP6KSckAErxLaaxTZMHZ
 tz5MVUdFEujXvVE9KsOLoqz+f/2GcmX2G5UowUHM8kllU8EXG3Yzq+7U2hDYldj9/fIo
 fBtHkrv3gD6yvxrRgL268cg6RnjKXSXPg/BecS/XSn2FuCOPNAqRslaoqDPxjiwtYU2J
 Rtrt8O1kKPwvXlxCqOFXvyZZWF9JF5lnQEBKXGPXSHmNhxdSCWm5sttcYqa9WZbx0ZQz
 4hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707913585; x=1708518385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFA1a42wCiNZvvQNKbqvgbniuQocv8cVbeveUQsSW+Q=;
 b=rNy9EOaifzr560dw48CEVHvmWRI2ghNDX5XfNnrk/N0tHC0qbtMbgGNVW+5WNBP4AU
 9fLAZOk33NyeHm7RQ6G3PL8liwACk3PRRZU0sg9Vx4KnNeFU7tP92SQr80f6fleNfq+f
 iPnwEU7D674IuYwWyQvqRt4vzzaxi71iF9jvy+A82G9QHJQ/C0rVOOaikcV4+j0WTQKv
 Xbdpm0qhlr2WMQ90dKrS5zjtVjk5RAL9zeraZG5WvGu8Ff8jhkNQ3jKgzE0apgRduE2a
 6DcLGxeEr1WaPKFq/WjvLpPstMQbny++eFnXtUASMPddfsjI2c7Yw3jGMcZbg3C8+VAT
 rp0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVNhkoFqcgAfmjU/r0AIbK7ffdExRRGtRrQn9O1IJtkwclyOHcQZ0IIB5yFCPGtpqvcBvRTyg3YZz6BDffjyAaj/XvK/6eWlqVJwxhcWg6U62npWw8dt8+nKw=
X-Gm-Message-State: AOJu0YxaRNBL5U91efEHxtBpqvBfLPGTvN/H4Y7OBFS/wvAtHtePyrI/
 QnIO+JYqIhL3ybZ4lY7IetP2lV9qBx0bucsbSDM5hgYff8IIodf66um7McXdoqSmfrh+miH+eYI
 717BYh2tVENyDULOeYFFtBSFKnrTphvKBT3U=
X-Google-Smtp-Source: AGHT+IEykwKT8cgqttzOlk+e39y8FoMiUCF/sFbMj4oPhkwkWz3C8nIuJBWl58yHIWtjQdnVurE0vG0XmAShoLUUESc=
X-Received: by 2002:aa7:c2cb:0:b0:561:f2c2:4dc8 with SMTP id
 m11-20020aa7c2cb000000b00561f2c24dc8mr1647564edp.9.1707913584936; Wed, 14 Feb
 2024 04:26:24 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
 <CACRpkdbmJe8ZE7N0p_utWucyw+3mp1Qrb0bQEKcJPmwNFtVA_g@mail.gmail.com>
In-Reply-To: <CACRpkdbmJe8ZE7N0p_utWucyw+3mp1Qrb0bQEKcJPmwNFtVA_g@mail.gmail.com>
From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Date: Wed, 14 Feb 2024 14:26:13 +0200
Message-ID: <CALT56yOT_U9jVkhTP=zZu-32B4pta5zaJocn9695N7ari4cFyQ@mail.gmail.com>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, paul.eggleton@linux.intel.com, 
 Andrea Adami <andrea.adami@gmail.com>, Guenter Roeck <linux@roeck-us.net>, 
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, 
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, Stefan Lehner <stefan-lehner@aon.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=dbaryshkov@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Feb 2024 07:40:55 -0500
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

On Tue, 13 Feb 2024 at 23:22, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Tue, Feb 13, 2024 at 9:12=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wro=
te:
> > On Tue, Feb 13, 2024, at 16:36, Guenter Roeck wrote:
> > > On Tue, Feb 13, 2024 at 03:14:21PM +0000, Peter Maydell wrote:
> > >> On Mon, 12 Feb 2024 at 14:36, Guenter Roeck <linux@roeck-us.net> wro=
te:
> > >> > On 2/12/24 04:32, Peter Maydell wrote:
>
> > >> > > The one SA1110 machine:
> > >> > >
> > >> > > collie               Sharp SL-5500 (Collie) PDA (SA-1110)
> > >> > >
> > >> > I do test collie.
> >
> > Adding Linus Walleij and Stefan Lehner to Cc, as they were
> > interested in modernizing sa1100 back in 2022. If they
> > are still interested in that, they might want to keep collie
> > support.
>
> I'm not personally interested in the Collie, I have a SA1100 hardware
> but not that one.
>
> > Surprisingly, at the time I removed unused old board files,
> > there was a lot more interest in sa1100 than in the newer
> > pxa platform, which I guess wasn't as appealing for
> > retrocomputing yet.
>
> Andrea Adami and Dmitry Eremin-Solenikov did the work in 2017 to
> modernize it a bit, and Russell helped out. I was under the impression
> that they only used real hardware though!

I used both Qemu and actual hardware (having collie, poodle, tosa and
c860 that was easy).

The biggest issue with Zaurus PDAs was that supporting interesting
parts of the platform (PCMCIA, companion chips) required almost
rebootstrapping of the corresponding drivers.
E.g. I had a separate driver for the LoCoMo chip which worked properly
with the DT systems.
PCMCIA was a huuuge trouble and it didn't play well at all. The driver
must be rewritten to use the component framework.

lf there is interest in modernising / updating StrongARM / PXA
devices, please count me in. I don't have time to lead the effort, but
I'd like to contribute.

> The Collie is popular because it is/was easy to get hold of and
> easy to hack. PXA was in candybar phones (right?) which
> are just veritable fortresses and really hard to hack so that is why
> there is no interest (except for the occasional hyperfocused Harald
> Welte), so those are a bit like the iPhones: you *can* boot something
> custom on them, but it won't be easy or quick, and not as fun and
> rewarding.
>
> The thriving world of PostmarketOS only exist because Google was
> clever to realize devices should have a developer mode.

There were two projects that worked on reenabling phones and PDAs from
that era, hack'n'dev and handhelds.org. I think both of them were dead
when the Zaurus was still alive and kicking.

--=20
With best wishes
Dmitry

