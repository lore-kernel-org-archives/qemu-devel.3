Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AA8C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVXN-0004S2-P3; Mon, 26 Feb 2024 02:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reVXM-0004Rt-E6
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:36:32 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reVXK-0004Dn-K2
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:36:32 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dc23bf7e5aaso2573566276.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 23:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708932989; x=1709537789; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CkQYisYPhD1omDzRxRpeD5hm4Ooyx7061/uiTCk2rfU=;
 b=gjQUhdPvgoMRdVpWPpIuLpkK/GThXZVA0UwmnO5aQZq+8LEnbsSQgiqugjcmxO+0eE
 Ad+iS1dq/JgHB1j/Q7154rRTV2DQ8M1seapMhVkfq5WfyLQA24uigIdjAJWuPSb0UhGl
 9Pt5GzQGBjAnHMosvHivI/uFy45QXZUeCw6p20/EBXuJ/jrMgKDpBw/0xITUFgKA34Ks
 +yw4Jc3AcaaCWvN+38xNnA6450uPHdb/22XBwpCTT5M8P5h0AFRv2i1PmT6waXy5dd46
 t0M6kVJ2xoam3Ncejmitopqqe0QIJlWCCMu/xWbQ7B3qUyy+wdTfgB8VbbvMvsvcEehQ
 +YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708932989; x=1709537789;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CkQYisYPhD1omDzRxRpeD5hm4Ooyx7061/uiTCk2rfU=;
 b=F6r9UgIVLatf5zd62ahGQCgBL+GLsLNROeh0KeiapAILjJPp5HW8EVZ9IezWEdOrZH
 Qflh1vjYsCTm8XE0DZs+rYkKZnv4AWm8Z8lJZRCkdYzz/hRiZIwG63MVQlf+gK4aLXTs
 f2Uj/JnrlfubFhAXH+a1S21ICISDxUvBTTrtMkxwD3HWa79GG+2PIcJunLOca8HD4YTO
 GjvIdY1fhhRKDm3ZgwTljebhuqrjhIHgw5BuReE4sClfDw/N/JXf9a5Vdk5dQAvq/tSn
 O+sGVbz9ZDF+YJvXlWw7zPR9/T80jjAiGWMXQxNyQUB+m+KSNJZpcJXga+sAQCLhcq/I
 vkPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWXVKUN1Yi/68PdGD1RybjrIsjQSOLgan8LXI1tAVM0qUcYJ4J38rgmLBsunQVhd7tNsr+qH9uGeazjin5r9yR75rInQ4=
X-Gm-Message-State: AOJu0YwJ6zbgEk+GM8vmEc/sevtvR5oNwD8XecJDu5AfKdauLvaq6/i0
 ISBZwz2BCdIueKwMFZYuga08Bm2uYcfmlK4Cb5TWv1+u97Cu41Hf
X-Google-Smtp-Source: AGHT+IGaUJkKMHQYWLZ5fuiVDjKvXUQaYlwLD+/9iikYyh4APFWBi8vvrodpIFHP3E/De1imAfKKdA==
X-Received: by 2002:a25:9308:0:b0:dcd:6dea:5d34 with SMTP id
 f8-20020a259308000000b00dcd6dea5d34mr4227711ybo.36.1708932988901; 
 Sun, 25 Feb 2024 23:36:28 -0800 (PST)
Received: from localhost ([1.146.74.212]) by smtp.gmail.com with ESMTPSA id
 h10-20020a056a00230a00b006e363ca24dcsm3358115pfh.67.2024.02.25.23.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 23:36:28 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 17:36:21 +1000
Message-Id: <CZEU6LST3QJK.25NCID08671V5@wheely>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "John Snow" <jsnow@redhat.com>,
 "Cleber Rosa" <crosa@redhat.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>, <qemu-devel@nongnu.org>,
 =?utf-8?q?=D0=94=D0=BE=D0=B2=D0=B3=D0=B0=D0=BB=D1=8E=D0=BA_=D0=9F=D0=B0?=
 =?utf-8?q?=D0=B2=D0=B5=D0=BB?= <Pavel.Dovgalyuk@ispras.ru>
Subject: Re: [PATCH 4/4] replay: simple auto-snapshot mode for record
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pavel Dovgalyuk" <pavel.dovgalyuk@ispras.ru>
X-Mailer: aerc 0.15.2
References: <20230814163135.187882-1-npiggin@gmail.com>
 <20230814163135.187882-5-npiggin@gmail.com>
 <95adc4ea-225c-bcd5-cec2-9edf1c2cf496@ispras.ru>
In-Reply-To: <95adc4ea-225c-bcd5-cec2-9edf1c2cf496@ispras.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=npiggin@gmail.com; helo=mail-yb1-xb2d.google.com
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

On Fri Aug 18, 2023 at 2:36 PM AEST, Pavel Dovgalyuk wrote:
> On 14.08.2023 19:31, Nicholas Piggin wrote:
> > record makes an initial snapshot when the machine is created, to enable
> > reverse-debugging. Often the issue being debugged appears near the end =
of
> > the trace, so it is important for performance to keep snapshots close t=
o
> > the end.
> >=20
> > This implements a periodic snapshot mode that keeps a rolling set of
> > recent snapshots.
> >=20
> > Arguably this should be done by the debugger or a program that talks to
> > QMP, but for setting up simple scenarios and tests, it is convenient to
> > have this feature.

I'm looking at resurrecting this to help add a bit of testing...

[snip]

> > +static void replay_snapshot_timer_cb(void *opaque)
> > +{
> > +    Error *err =3D NULL;
> > +    char *name;
> > +
> > +    if (!replay_can_snapshot()) {
> > +        /* Try again soon */
> > +        timer_mod(replay_snapshot_timer,
> > +                  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> > +                  replay_snapshot_periodic_delay / 10);
> > +        return;
> > +    }
> > +
> > +    name =3D g_strdup_printf("%s-%d", replay_snapshot, replay_snapshot=
_count);
> > +    if (!save_snapshot(name,
> > +                       true, NULL, false, NULL, &err)) {
> > +        error_report_err(err);
> > +        error_report("Could not create periodic snapshot "
> > +                     "for icount record, disabling");
> > +        g_free(name);
> > +        return;
> > +    }
> > +    g_free(name);
> > +    replay_snapshot_count++;
> > +
> > +    if (replay_snapshot_periodic_nr_keep >=3D 1 &&
> > +        replay_snapshot_count > replay_snapshot_periodic_nr_keep) {
> > +        int del_nr;
> > +
> > +        del_nr =3D replay_snapshot_count - replay_snapshot_periodic_nr=
_keep - 1;
> > +        name =3D g_strdup_printf("%s-%d", replay_snapshot, del_nr);
> > +        if (!delete_snapshot(name, false, NULL, &err)) {
> > +            error_report_err(err);
> > +            error_report("Could not delete periodic snapshot "
> > +                         "for icount record");
> > +        }
> > +        g_free(name);
> > +    }
> > +
> > +    timer_mod(replay_snapshot_timer,
> > +              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> > +              replay_snapshot_periodic_delay);
>
> I'm not sure that realtime is not the best choice for such of a timer.
> Virtual machine may be stopped or slowed down for some reason.

My thinking was that, say if you snapshot every 10 seconds of real time
executed, then you should have an upper limit on the order of 10 seconds
to perform a reverse-debug operation (so long as you don't exceed your
nr_keep limit).

Is it worth worrying about complexity of slowdowns and vm pausing?
Maybe it could stop snapshotting on a host pause.

> > +}
> > +
> >   void replay_vmstate_init(void)
> >   {
> >       Error *err =3D NULL;
> > @@ -81,6 +128,16 @@ void replay_vmstate_init(void)
> >                   error_report("Could not create snapshot for icount re=
cord");
> >                   exit(1);
> >               }
> > +
> > +            if (replay_snapshot_mode =3D=3D REPLAY_SNAPSHOT_MODE_PERIO=
DIC) {
> > +                replay_snapshot_timer =3D timer_new_ms(QEMU_CLOCK_REAL=
TIME,
> > +                                                     replay_snapshot_t=
imer_cb,
> > +                                                     NULL);
> > +                timer_mod(replay_snapshot_timer,
> > +                          qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> > +                          replay_snapshot_periodic_delay);
> > +            }
> > +
>
> Please also delete placeholder comment for the snapshotting timer
> in replay_enable function.

Wil do.

> >           } else if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
> >               if (!load_snapshot(replay_snapshot, NULL, false, NULL, &e=
rr)) {
> >                   error_report_err(err);
> > diff --git a/replay/replay.c b/replay/replay.c
> > index e64f71209a..fa5930700d 100644
> > --- a/replay/replay.c
> > +++ b/replay/replay.c
> > @@ -29,6 +29,10 @@
> >   ReplayMode replay_mode =3D REPLAY_MODE_NONE;
> >   char *replay_snapshot;
> >  =20
> > +ReplaySnapshotMode replay_snapshot_mode;
> > +uint64_t replay_snapshot_periodic_delay;
> > +int replay_snapshot_periodic_nr_keep;
> > +
> >   /* Name of replay file  */
> >   static char *replay_filename;
> >   ReplayState replay_state;
> > @@ -313,6 +317,27 @@ void replay_configure(QemuOpts *opts)
> >       }
> >  =20
> >       replay_snapshot =3D g_strdup(qemu_opt_get(opts, "rrsnapshot"));
> > +    if (replay_snapshot && mode =3D=3D REPLAY_MODE_RECORD) {
>
> Can such a snapshotting may be useful in replay mode?

Does snapshotting do anything in replay mode? I assume if we did
snapshotting based on the machine timer then we'd have to support
it here so the timer events get replayed properly, at least. But
I was trying to get by with minimum complexity :)

Thanks,
Nick

