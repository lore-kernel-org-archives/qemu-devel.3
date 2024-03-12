Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1ECC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 10:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzba-0007tr-AE; Tue, 12 Mar 2024 06:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjzbY-0007tb-06
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 06:43:32 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjzbV-00088S-Uk
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 06:43:31 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2219ed4e2d9so2512606fac.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710240208; x=1710845008; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuRlFKFpC0srJB9yGmQGwshNqSFVKKbRTE4Kb70eO58=;
 b=IDN2aaaXX2+hmk3xp67gcT//wcGKcJINUM6sg685FqFfOIqA10t+EZA2IW4aq/KYnW
 NTROxYAd+DDPUAfN5HJomUw0+vzWcYLHQYhKpq2An8fs3aw+3VoTN2+HwnGCJFG5Mv5q
 XRDXMnc77RxhmOEfi8x+6AiqS1DpOVE7VSxAeew342X3YccL6JWLv3AnkhksmotoXj0V
 Y6dIY8YLKvHi/VYDqqM3VsBJcvbCr+0F/mT1oI65kHLjbM8FwOnuPkFysq/+r+D5+ADd
 jKvDO7esXOolztjEhvhJC8Ub341rTELrEoudtzYvSghP8bllzdgFUAFFyyAXqSoBG1gy
 7Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710240208; x=1710845008;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kuRlFKFpC0srJB9yGmQGwshNqSFVKKbRTE4Kb70eO58=;
 b=CwtjvNgyjEkfcXah8aBcKlzjT+PQd1dM/FD8VVfd8MVw5MjC9clbULh5budROzLHDG
 kKaDwZHLFz1AtkebPRCGfNszPlz+arjBCWwuuEsfGXNRHGMWfZXcOcxvM3sid/BJNfcl
 TVtqY9ivPRZSh4Kfwww0szQQ40Ou6eDuCC4jbB+yfnnX2R1n4WMtjtInGlZFCWG8aWfq
 bFloUBH5PVUgvxHKwnALc8zQikpXT5Ui+y/fFV6Ih7LZpu5cBKBRXV+4glo0bxhWExMg
 uQ9Eku+wd5u/jYd37dZ+X+UcyvcSK08EBTfzVYlr9PGZW4+9s14H1x18QwSL/+ac142I
 u9/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUHtl5dLUqVsnXouoQc4uLgMf7ygLZ+/hDZ6dd5u2xnJRkBONYrYpU/BVVwzlV6PP13ne9L2TEnzWZPl/0TdW8PuZN0P0=
X-Gm-Message-State: AOJu0Yz1rJIiegBiRXRpDDxN0SpEO5AE+J/JexzXBqpz+yTJJ+tcBuce
 HuymEb7K+/nBW0kf099Jxcabn5vU8pKbVi5pKssCLBDvR9xHP8qh
X-Google-Smtp-Source: AGHT+IEUL1Jui2hv/XKH580i/lDgkSSvkTMlKJZ5kxC5Ke0VFlyevgs7oEtgmAc8Y7tJ+9BqE1hFPw==
X-Received: by 2002:a05:6871:54e:b0:221:c9ef:5b with SMTP id
 t14-20020a056871054e00b00221c9ef005bmr6410304oal.18.1710240208112; 
 Tue, 12 Mar 2024 03:43:28 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 p1-20020a63c141000000b005dc389409c1sm5695049pgi.93.2024.03.12.03.43.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 03:43:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 20:43:21 +1000
Message-Id: <CZRPJY7D8D83.1QIJXJ5QEL05S@wheely>
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "John
 Snow" <jsnow@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Michael Tokarev" <mjt@tls.msk.ru>
Subject: Re: [PATCH v4 20/24] replay: simple auto-snapshot mode for record
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pavel Dovgalyuk" <pavel.dovgalyuk@ispras.ru>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-21-npiggin@gmail.com>
 <42f7335c-5e0c-4640-af10-878a4c8732c9@ispras.ru>
In-Reply-To: <42f7335c-5e0c-4640-af10-878a4c8732c9@ispras.ru>
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x29.google.com
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

On Tue Mar 12, 2024 at 7:00 PM AEST, Pavel Dovgalyuk wrote:
> On 11.03.2024 20:40, Nicholas Piggin wrote:
> > record makes an initial snapshot when the machine is created, to enable
> > reverse-debugging. Often the issue being debugged appears near the end =
of
> > the trace, so it is important for performance to keep snapshots close t=
o
> > the end.
> >=20
> > This implements a periodic snapshot mode that keeps a rolling set of
> > recent snapshots. This could be done by the debugger or other program
> > that talks QMP, but for setting up simple scenarios and tests, this is
> > more convenient.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   docs/system/replay.rst   |  5 ++++
> >   include/sysemu/replay.h  | 11 ++++++++
> >   replay/replay-snapshot.c | 57 +++++++++++++++++++++++++++++++++++++++=
+
> >   replay/replay.c          | 27 +++++++++++++++++--
> >   system/vl.c              |  9 +++++++
> >   qemu-options.hx          |  9 +++++--
> >   6 files changed, 114 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/docs/system/replay.rst b/docs/system/replay.rst
> > index ca7c17c63d..1ae8614475 100644
> > --- a/docs/system/replay.rst
> > +++ b/docs/system/replay.rst
> > @@ -156,6 +156,11 @@ for storing VM snapshots. Here is the example of t=
he command line for this:
> >   ``empty.qcow2`` drive does not connected to any virtual block device =
and used
> >   for VM snapshots only.
> >  =20
> > +``rrsnapmode`` can be used to select just an initial snapshot or perio=
dic
> > +snapshots, with ``rrsnapcount`` specifying the number of periodic snap=
shots
> > +to maintain, and ``rrsnaptime`` the amount of run time in seconds betw=
een
> > +periodic snapshots.
> > +
> >   .. _network-label:
> >  =20
> >   Network devices
> > diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> > index 8102fa54f0..92fa82842b 100644
> > --- a/include/sysemu/replay.h
> > +++ b/include/sysemu/replay.h
> > @@ -48,6 +48,17 @@ typedef enum ReplayCheckpoint ReplayCheckpoint;
> >  =20
> >   typedef struct ReplayNetState ReplayNetState;
> >  =20
> > +enum ReplaySnapshotMode {
> > +    REPLAY_SNAPSHOT_MODE_INITIAL,
> > +    REPLAY_SNAPSHOT_MODE_PERIODIC,
> > +};
>
> This should be defined in replay-internal.h, because it is internal for=
=20
> replay.
>
> > +typedef enum ReplaySnapshotMode ReplaySnapshotMode;
> > +
> > +extern ReplaySnapshotMode replay_snapshot_mode;
> > +
> > +extern uint64_t replay_snapshot_periodic_delay;
> > +extern int replay_snapshot_periodic_nr_keep;
>
> These ones are internal too.

Okay for both.

>
> > +
> >   /* Name of the initial VM snapshot */
> >   extern char *replay_snapshot;
> >  =20
> > diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> > index ccb4d89dda..762555feaa 100644
> > --- a/replay/replay-snapshot.c
> > +++ b/replay/replay-snapshot.c
> > @@ -70,6 +70,53 @@ void replay_vmstate_register(void)
> >       vmstate_register(NULL, 0, &vmstate_replay, &replay_state);
> >   }
> >  =20
> > +static QEMUTimer *replay_snapshot_timer;
> > +static int replay_snapshot_count;
> > +
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
>
> Copy-paste of snapshot name format.

Yes good catch.

>
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
> > +}
> > +
> >   void replay_vmstate_init(void)
> >   {
> >       Error *err =3D NULL;
> > @@ -82,6 +129,16 @@ void replay_vmstate_init(void)
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
> >           } else if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
> >               if (!load_snapshot(replay_snapshot, NULL, false, NULL, &e=
rr)) {
> >                   error_report_err(err);
> > diff --git a/replay/replay.c b/replay/replay.c
> > index 895fa6b67a..c916e71d30 100644
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
> > @@ -424,6 +428,27 @@ void replay_configure(QemuOpts *opts)
> >       }
> >  =20
> >       replay_snapshot =3D g_strdup(qemu_opt_get(opts, "rrsnapshot"));
> > +    if (replay_snapshot && mode =3D=3D REPLAY_MODE_RECORD) {
> > +        const char *snapmode;
> > +
> > +        snapmode =3D qemu_opt_get(opts, "rrsnapmode");
> > +        if (!snapmode || !strcmp(snapmode, "initial")) {
> > +            replay_snapshot_mode =3D REPLAY_SNAPSHOT_MODE_INITIAL;
> > +        } else if (!strcmp(snapmode, "periodic")) {
> > +            replay_snapshot_mode =3D REPLAY_SNAPSHOT_MODE_PERIODIC;
> > +        } else {
> > +            error_report("Invalid rrsnapmode option: %s", snapmode);
> > +            exit(1);
> > +        }
> > +
> > +        /* Default 10 host seconds of machine runtime per snapshot. */
> > +        replay_snapshot_periodic_delay =3D
> > +                           qemu_opt_get_number(opts, "rrsnaptime", 10)=
 * 1000;
>
> Can user set it to zero here?

I guess so. It would just continually snapshot, which is probably okay
if that's what you want.

Thanks,
Nick

