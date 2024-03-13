Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BDDC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 05:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkHK9-0001l1-Af; Wed, 13 Mar 2024 01:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rkHK7-0001kV-1G
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 01:38:43 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rkHK5-0003JB-0n
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 01:38:42 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-29bb3d62949so3420062a91.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 22:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710308319; x=1710913119; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJLjiyJW4471YgTtt3S7IB/synTzjVT9S8z3v4x/PYY=;
 b=AwRFzWg4LtxklDzcz3BG60lX17EtfK9TV7k4wjbfRPYxJZd0YNKY+YHEsg2nwjxc2t
 STCTryIUv8BrQ3mbYVkAJUge4i08jYWpcnJrZ8zcO2eNSy0tyFT1tLSCqdnkaXOJYa5C
 sxFk8kVHWFa9rkhLSnrjh4EFm7hmAdYmJTk2m7WslwsDs69F9Qp6P4TbTvNrxtyPX02f
 xfD7UdQqKOGZCfXm+0f/q5QhXHGJ4wAya8aj/t+4AyAqj5lH/agaKgZsWvjXFFLAeyvP
 7v7IoQHiwVaOCVMqoZJLukeDLrpkZYZHohfOiX3TYgBT8azKOm3yhi4KK8U69zQxrZts
 NI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710308319; x=1710913119;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BJLjiyJW4471YgTtt3S7IB/synTzjVT9S8z3v4x/PYY=;
 b=GlR7XKQWKV7b+zoLj2a+9CbtibmMOxDcSB7A84T/JkIjxmgfv8+zYr6D58LsNHbY1d
 YYChNGSdLwXw9xVMoxgFfdYF2vSCy0ivH7gQzPZYPBUFPtOqc6j6NpgR3Iz/xUwbVKBy
 3oYUaIj2GkSKP60HPMck7Bt8aNAhxVt6rzUYpJHRtjHlMESP1s1G8MCXLQ+CuMbLAP6n
 bUNhyAFCKT70zQuDYDi20tHZdZfdAllPYUW+Ky0iCHa5kw0f0Uh28p6QakMtKgfjyUO/
 WANbuu2QqoOwhdj66eOjhu76bB42JVfsJ0J2l0hd2P0gAHgrjuzyqzzaJm7J6ANEJIzW
 bgPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6XwaFK/UV53wkTAz4cpNgsqmTd+qVKp1gk24V51ASf7ithRh6H1jriWRea/K7edjSuF3anU5DXRcGrF7XGDU1e5GdXz0=
X-Gm-Message-State: AOJu0YwljYg/44ANtOgLRNO5Cq/0BgS44l3CgpMxP8W1R3k4nhPpWeWm
 hqRsOhq06LEoOoQ2LqOX0lYz9roMaDuLj8+vCWb43yw03Ejj6F3P
X-Google-Smtp-Source: AGHT+IGE8iiMtQCJrEIBskNNWaspPDJm4HeCnoPX2RayrQMkr9rjk7xNJgiwC2OIWsqXM8vPd8YxPg==
X-Received: by 2002:a17:90a:e508:b0:29b:aee7:5937 with SMTP id
 t8-20020a17090ae50800b0029baee75937mr4006748pjy.23.1710308319115; 
 Tue, 12 Mar 2024 22:38:39 -0700 (PDT)
Received: from localhost ([1.146.20.17]) by smtp.gmail.com with ESMTPSA id
 s21-20020a17090aa11500b0029beec8e86csm511287pjp.36.2024.03.12.22.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 22:38:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 15:38:23 +1000
Message-Id: <CZSDOZT1RURT.3FBGNCY6GQ1WE@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pavel Dovgalyuk" <pavel.dovgalyuk@ispras.ru>, <qemu-devel@nongnu.org>
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "John
 Snow" <jsnow@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Michael Tokarev" <mjt@tls.msk.ru>
Subject: Re: [PATCH v4 11/24] net: Use virtual time for net announce
X-Mailer: aerc 0.15.2
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-12-npiggin@gmail.com>
 <6e9b8e49-f00f-46fc-bbf8-4af27e0c3906@ispras.ru>
 <CZRQ0IX3UQRZ.KXS6OX3HY1RD@wheely>
 <13c1e838-0c0a-42e9-baa4-2418569311d5@ispras.ru>
In-Reply-To: <13c1e838-0c0a-42e9-baa4-2418569311d5@ispras.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
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

On Tue Mar 12, 2024 at 9:12 PM AEST, Pavel Dovgalyuk wrote:
> On 12.03.2024 14:05, Nicholas Piggin wrote:
> > On Tue Mar 12, 2024 at 7:09 PM AEST, Pavel Dovgalyuk wrote:
> >> This won't work, as needed. Announce timer can't be enabled, because
> >> it is set in post_load function. Therefore announce callbacks break
> >> the replay, when virtio-net is used with snapshots.
> >=20
> > I see. Is that somehow marked as being incompatible with rr?
>
> Here's the prior discussion on it:=20
> https://lore.kernel.org/qemu-devel/8735ovx0zd.fsf@linaro.org/t/

Thanks for that context. You already fixed some of these, lol that
would have saved me a few hours. Maybe clearing the announce flag
is the right way to solve this, I might take that instead.

Trouble is we have virtio-net selftests in tests already and this
causes failures. So we need to get it fixed. I do think the bh API
is a bit clunky and could be revised into a name that makes more
sense for the non-replay developer, but that's really a separate
issue and should not prevent this bug fixes being merged.

We really need non-flaky rr testing upstream because it's quite
easy to break. So I will keep trying to get these merged.

Thanks,
Nick

>
>
> >=20
> > Thanks,
> > Nick
> >=20
> >>
> >> On 11.03.2024 20:40, Nicholas Piggin wrote:
> >>> Using virtual time for announce ensures that guest visible effects
> >>> are deterministic and don't break replay.
> >>>
> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>> ---
> >>>    net/announce.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/net/announce.c b/net/announce.c
> >>> index 9e99044422..70b5d5e822 100644
> >>> --- a/net/announce.c
> >>> +++ b/net/announce.c
> >>> @@ -187,7 +187,7 @@ static void qemu_announce_self_once(void *opaque)
> >>>   =20
> >>>    void qemu_announce_self(AnnounceTimer *timer, AnnounceParameters *=
params)
> >>>    {
> >>> -    qemu_announce_timer_reset(timer, params, QEMU_CLOCK_REALTIME,
> >>> +    qemu_announce_timer_reset(timer, params, QEMU_CLOCK_VIRTUAL,
> >>>                                  qemu_announce_self_once, timer);
> >>>        if (params->rounds) {
> >>>            qemu_announce_self_once(timer);
> >=20


