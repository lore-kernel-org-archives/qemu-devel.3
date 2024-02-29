Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A93C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZyU-0006Kd-Qw; Thu, 29 Feb 2024 01:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rfZyH-0006Iq-Iy
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:32:46 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rfZyF-00039G-Bs
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:32:45 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso405067a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 22:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709188361; x=1709793161; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIkCQPTzxFyPomA2xFUg32rW5D7p+7yyPlvA7i7ygzM=;
 b=cSGQfbrTxDeHonR3EWwrSvvHPDeYEadTBkbIY6M78dOSmfKJT97D1Bz62xAS6Pfxba
 OE3qVYde86hc3Jfv2TZzCOktTsRlrt99Rn7M/OwuQgIcWrW3yzYdLn9Kb9etUcqeRhJk
 wl7+CVOZuaRhCYb+24/h3OkYzZ2z6dMmNmavuSYfiZmbPm3Gp2T/+B+DLu57UtRUYnrm
 MJ4xT0MLYAuSLZvBed/DR6XFy9jA1K11LQmN0DZjwCtSLX9iD8axincWlBSxIpWDFiUC
 lLNp+f2HMtxPJ6bYSvy9X4CYbOV1J2Uv5inDqk9kX4ubnRv82ICqQWPCXZXdnUvrgQeT
 cAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709188361; x=1709793161;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kIkCQPTzxFyPomA2xFUg32rW5D7p+7yyPlvA7i7ygzM=;
 b=OfZWSbdKdX3ndN8MI2T6/rY1+lspqhuMQp3EJojCw1Bg623q0WL4WHREeqXKMv8WvK
 qialWenlQ+lL6djX8SQ8re6imToEVkIkfF7PMphSs5AbjBrcb2T4lsaXnw71xAZuxkUC
 78JMq21rOTA1LG7xARAKBNVEW1eKfdk2GZh3lDeYFBQuiK0adro566u9cZ4rTu3M8Tlu
 8j587doQ621nQCPkqnOK/gVQJoVqUhFuS4ba1swyeji+LLLH2MCKl598/IINpjaPipFE
 9Dkt8EBgA6r4YtLvF5pO1/+eJqtft3r6Sl8xraob4a3gOBXOkrrxupoEV8ARXQpkN+rg
 TA/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXihlZZHZQtYyMZiLrlpthwd3akiEoCBnSMkFcH5A5LkddFaEmsvAMilND5M0QaiBXHhSAm2V6XlPYMNaUs84h9iA76Plk=
X-Gm-Message-State: AOJu0Yx3RmtpHrGd9L9uGoyrYaEq3La+UPYFMqOOBdb9+YGoLNidvtaW
 2JZsG1xyuuNXXgImoNfQuiQkgLfV8JIyqsQSs0LgIII5mP01YdaB
X-Google-Smtp-Source: AGHT+IFVujuJ+aHqJPEPoOvHVAJFllFGDdlud9w64meJKuClC/rBfD9p7UQnjx2yMxFAL4ks0Na4LA==
X-Received: by 2002:a05:6a21:1394:b0:19e:9c82:b139 with SMTP id
 oa20-20020a056a21139400b0019e9c82b139mr1575538pzb.45.1709188361483; 
 Wed, 28 Feb 2024 22:32:41 -0800 (PST)
Received: from localhost (220-235-220-130.tpgi.com.au. [220.235.220.130])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a17090aa10800b0029a7bebed04sm594411pjp.6.2024.02.28.22.32.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 22:32:41 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 16:32:35 +1000
Message-Id: <CZHCPES6J8NQ.3HAYN1CS2UVRC@wheely>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "John Snow" <jsnow@redhat.com>,
 "Cleber Rosa" <crosa@redhat.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/4] replay: simple auto-snapshot mode for record
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pavel Dovgalyuk" <pavel.dovgalyuk@ispras.ru>
X-Mailer: aerc 0.15.2
References: <20230814163135.187882-1-npiggin@gmail.com>
 <20230814163135.187882-5-npiggin@gmail.com>
 <95adc4ea-225c-bcd5-cec2-9edf1c2cf496@ispras.ru>
 <CZEU6LST3QJK.25NCID08671V5@wheely>
 <b212b1a1-eca9-40ae-992b-ff24f41844e3@ispras.ru>
In-Reply-To: <b212b1a1-eca9-40ae-992b-ff24f41844e3@ispras.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
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

On Wed Feb 28, 2024 at 3:07 PM AEST, Pavel Dovgalyuk wrote:
> On 26.02.2024 10:36, Nicholas Piggin wrote:
> > On Fri Aug 18, 2023 at 2:36 PM AEST, Pavel Dovgalyuk wrote:
> >> On 14.08.2023 19:31, Nicholas Piggin wrote:
> >>> record makes an initial snapshot when the machine is created, to enab=
le
> >>> reverse-debugging. Often the issue being debugged appears near the en=
d of
> >>> the trace, so it is important for performance to keep snapshots close=
 to
> >>> the end.
> >>>
> >>> This implements a periodic snapshot mode that keeps a rolling set of
> >>> recent snapshots.
> >>>
> >>> Arguably this should be done by the debugger or a program that talks =
to
> >>> QMP, but for setting up simple scenarios and tests, it is convenient =
to
> >>> have this feature.
> >=20
> > I'm looking at resurrecting this to help add a bit of testing...
> >=20
> > [snip]
> >=20
> >>> +static void replay_snapshot_timer_cb(void *opaque)
> >>> +{
> >>> +    Error *err =3D NULL;
> >>> +    char *name;
> >>> +
> >>> +    if (!replay_can_snapshot()) {
> >>> +        /* Try again soon */
> >>> +        timer_mod(replay_snapshot_timer,
> >>> +                  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> >>> +                  replay_snapshot_periodic_delay / 10);
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    name =3D g_strdup_printf("%s-%d", replay_snapshot, replay_snapsh=
ot_count);
> >>> +    if (!save_snapshot(name,
> >>> +                       true, NULL, false, NULL, &err)) {
> >>> +        error_report_err(err);
> >>> +        error_report("Could not create periodic snapshot "
> >>> +                     "for icount record, disabling");
> >>> +        g_free(name);
> >>> +        return;
> >>> +    }
> >>> +    g_free(name);
> >>> +    replay_snapshot_count++;
> >>> +
> >>> +    if (replay_snapshot_periodic_nr_keep >=3D 1 &&
> >>> +        replay_snapshot_count > replay_snapshot_periodic_nr_keep) {
> >>> +        int del_nr;
> >>> +
> >>> +        del_nr =3D replay_snapshot_count - replay_snapshot_periodic_=
nr_keep - 1;
> >>> +        name =3D g_strdup_printf("%s-%d", replay_snapshot, del_nr);
> >>> +        if (!delete_snapshot(name, false, NULL, &err)) {
> >>> +            error_report_err(err);
> >>> +            error_report("Could not delete periodic snapshot "
> >>> +                         "for icount record");
> >>> +        }
> >>> +        g_free(name);
> >>> +    }
> >>> +
> >>> +    timer_mod(replay_snapshot_timer,
> >>> +              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> >>> +              replay_snapshot_periodic_delay);
> >>
> >> I'm not sure that realtime is not the best choice for such of a timer.
> >> Virtual machine may be stopped or slowed down for some reason.
> >=20
> > My thinking was that, say if you snapshot every 10 seconds of real time
> > executed, then you should have an upper limit on the order of 10 second=
s
> > to perform a reverse-debug operation (so long as you don't exceed your
> > nr_keep limit).
>
> But in some cases savevm itself could take more than 10 seconds.
> We'll have infinite saving in this case. That's why I propose using=20
> virtual clock with the QEMU_TIMER_ATTR_EXTERNAL attribute.

It shouldn't do that because it sets the next timer after
end of snapshot time + delay.

With virtual time, won't an idle machine just keep warping
the time to the next snapshot save and that *could* cause
infinite snapshotting. I worry that icount time is difficult
to predict and understand. Both have issues but I think real
time is better.

> >=20
> > Is it worth worrying about complexity of slowdowns and vm pausing?
> > Maybe it could stop snapshotting on a host pause.
> >=20
> >>> +}
> >>> +
> >>>    void replay_vmstate_init(void)
> >>>    {
> >>>        Error *err =3D NULL;
> >>> @@ -81,6 +128,16 @@ void replay_vmstate_init(void)
> >>>                    error_report("Could not create snapshot for icount=
 record");
> >>>                    exit(1);
> >>>                }
> >>> +
> >>> +            if (replay_snapshot_mode =3D=3D REPLAY_SNAPSHOT_MODE_PER=
IODIC) {
> >>> +                replay_snapshot_timer =3D timer_new_ms(QEMU_CLOCK_RE=
ALTIME,
> >>> +                                                     replay_snapshot=
_timer_cb,
> >>> +                                                     NULL);
> >>> +                timer_mod(replay_snapshot_timer,
> >>> +                          qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> >>> +                          replay_snapshot_periodic_delay);
> >>> +            }
> >>> +
> >>
> >> Please also delete placeholder comment for the snapshotting timer
> >> in replay_enable function.
> >=20
> > Wil do.
> >=20
> >>>            } else if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
> >>>                if (!load_snapshot(replay_snapshot, NULL, false, NULL,=
 &err)) {
> >>>                    error_report_err(err);
> >>> diff --git a/replay/replay.c b/replay/replay.c
> >>> index e64f71209a..fa5930700d 100644
> >>> --- a/replay/replay.c
> >>> +++ b/replay/replay.c
> >>> @@ -29,6 +29,10 @@
> >>>    ReplayMode replay_mode =3D REPLAY_MODE_NONE;
> >>>    char *replay_snapshot;
> >>>   =20
> >>> +ReplaySnapshotMode replay_snapshot_mode;
> >>> +uint64_t replay_snapshot_periodic_delay;
> >>> +int replay_snapshot_periodic_nr_keep;
> >>> +
> >>>    /* Name of replay file  */
> >>>    static char *replay_filename;
> >>>    ReplayState replay_state;
> >>> @@ -313,6 +317,27 @@ void replay_configure(QemuOpts *opts)
> >>>        }
> >>>   =20
> >>>        replay_snapshot =3D g_strdup(qemu_opt_get(opts, "rrsnapshot"))=
;
> >>> +    if (replay_snapshot && mode =3D=3D REPLAY_MODE_RECORD) {
> >>
> >> Can such a snapshotting may be useful in replay mode?
> >=20
> > Does snapshotting do anything in replay mode?=20
>
> Yes, you can create as many snapshots as you want if 'snapshot=3Don'
> option of the disk image was not used.

Oh, so it will make real snapshots? I just assumed it would
"replay" the motions of the snapshot.

In that case actually that could be useful if your recording
didn't have snapshots and you want to debug it. I'll try it.

Thanks,
Nick

