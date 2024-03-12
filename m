Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212FCC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzwd-00068T-2k; Tue, 12 Mar 2024 07:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjzwc-00068G-0l
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:05:18 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjzwT-0004Ng-N8
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:05:17 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5cddfe0cb64so3582320a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710241508; x=1710846308; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/Mr0aLn0orEs7qmNxR5pfUTV4u2w3MLoaCmbfcZHXM=;
 b=O2cof5RvkjhHiPFqMKxHlh6EEzFl3PCsmuzjEobzeKZa4Fc8fIyc5rLU9686VVckcM
 l+QVH61iHJ17JQYnfphQ+gYlyG0da2KtyS/NruI9ZV8Zmlf9oJkPiQyKqnTWOo+RyULn
 a5Puhmd1NekNhDAxdpJMAxmDCpVBxQcexLjqizhV8jUMm2XfkS33EU0bowmXzaJkg9co
 KtKl42yaQR2XJ82AGadljpy1RmZM/IJq1nSgdtoNwm9UftzE7z//gfND5lIMeCcL4IYl
 EDSFlMxDHl7Cf/UGr/7fTMuiRYDwaAWkw5EvYBFfYy75AHXa21EfxgFIRZBmqK0T1bcA
 pamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710241508; x=1710846308;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3/Mr0aLn0orEs7qmNxR5pfUTV4u2w3MLoaCmbfcZHXM=;
 b=P2zvj1810MU+NhDUJ6gzi2nczy6LXm6/BodOltv/S6gKpn4fhnYCT7reH1MRPp79UE
 sgR99I/27MM2xy6LpNqZXWw963vqhvMbyp9cYVkr9ERHffmIXWwgHfKQRkAlHFjkgxT7
 EGxaC/EAab5Pjm+DAjJUKO7P7uhly3y4L1lZQxqYoGsUNB5zGIpLeSbasw2gJz6zUZcT
 X01jZxwz5qSPJom0OCdu7oPrOfCVWMV1gdCQfDbGyzZrBSsweMYrepYkkF3nT87RTrIo
 vwfYjwsZ2wdX4rUgRLdfhNBP1+FSMumXEI0zKA9/PX73FAmqCXwoC9w2qZUX7YgSbmYh
 4srg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC431FVXBOYdyWcOGIJXb5/zG6GEogxInzt61AAz/NX3PvK9yh5ndZEqj7X2gmLfNkwmc5gOztwgsbrpn7a9YwJCbSvq8=
X-Gm-Message-State: AOJu0YwIiITlMDLH+fqYBKAoILz4xt5sblHAZnwrqwCUl/N4woFxWMEb
 ZVilg+8UtVnuI4LJ4+S0zRGQ5LqvWL3zJkT6PPdJB2YdwF6miXdzS6ljREganVI=
X-Google-Smtp-Source: AGHT+IE+qQvXmzpJoXPtSxY0dcOjRW4Priju5gtO6PBgXqZZkF1NqDTNGc+weWsEja0Sc9ES1yBjww==
X-Received: by 2002:a05:6a20:c1f:b0:1a1:68c8:a1e5 with SMTP id
 bw31-20020a056a200c1f00b001a168c8a1e5mr5298109pzb.51.1710241508085; 
 Tue, 12 Mar 2024 04:05:08 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 fd29-20020a056a002e9d00b006e580678dfbsm5901720pfb.193.2024.03.12.04.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:05:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 21:05:00 +1000
Message-Id: <CZRQ0IX3UQRZ.KXS6OX3HY1RD@wheely>
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "John
 Snow" <jsnow@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Michael Tokarev" <mjt@tls.msk.ru>
Subject: Re: [PATCH v4 11/24] net: Use virtual time for net announce
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pavel Dovgalyuk" <pavel.dovgalyuk@ispras.ru>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-12-npiggin@gmail.com>
 <6e9b8e49-f00f-46fc-bbf8-4af27e0c3906@ispras.ru>
In-Reply-To: <6e9b8e49-f00f-46fc-bbf8-4af27e0c3906@ispras.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue Mar 12, 2024 at 7:09 PM AEST, Pavel Dovgalyuk wrote:
> This won't work, as needed. Announce timer can't be enabled, because
> it is set in post_load function. Therefore announce callbacks break
> the replay, when virtio-net is used with snapshots.

I see. Is that somehow marked as being incompatible with rr?

Thanks,
Nick

>
> On 11.03.2024 20:40, Nicholas Piggin wrote:
> > Using virtual time for announce ensures that guest visible effects
> > are deterministic and don't break replay.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   net/announce.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/net/announce.c b/net/announce.c
> > index 9e99044422..70b5d5e822 100644
> > --- a/net/announce.c
> > +++ b/net/announce.c
> > @@ -187,7 +187,7 @@ static void qemu_announce_self_once(void *opaque)
> >  =20
> >   void qemu_announce_self(AnnounceTimer *timer, AnnounceParameters *par=
ams)
> >   {
> > -    qemu_announce_timer_reset(timer, params, QEMU_CLOCK_REALTIME,
> > +    qemu_announce_timer_reset(timer, params, QEMU_CLOCK_VIRTUAL,
> >                                 qemu_announce_self_once, timer);
> >       if (params->rounds) {
> >           qemu_announce_self_once(timer);


