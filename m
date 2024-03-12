Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C88C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2jn-0004c1-75; Tue, 12 Mar 2024 10:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rk2jS-0004Tm-KD
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:03:59 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rk2jP-0008Vu-Un
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:03:54 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e55731af5cso2856767b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710252230; x=1710857030; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EjHXdX0vkbq8sODjYsOgTQoCZtMGuICiiT+NPIRA/4=;
 b=cPA4Yc82/bP76ZuKv4UekxzSc+xw+8L2w1tM2wbAwAL58s06xhUTZQ3sznj1CQOuY1
 9eyRp6o98SLOaIK4As2VkuFbF1HArkfHITyFRJ66ZWGip+XtLC24uOqG5KQZjpKzEt+n
 g2/QMEBHV5Yt0aPIgHty2Oqgg7cv91Am4JiAx70iJOqsGWwqP6NMxRJq5z6bdHbbJHYF
 8soRqrc79JeFEQxlzDBZq54B+cA5BlXyrDC92emftBs4s7uBIQoHr3MgGHXAxJRFUfAb
 EXg0nfXpByUzsULv3g4gDuoTDdhQQ8LVdGDPuZAttwrLRNBQRUpjLmUJxmthFKK5HEGF
 4Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710252230; x=1710857030;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/EjHXdX0vkbq8sODjYsOgTQoCZtMGuICiiT+NPIRA/4=;
 b=YfYw76KTUFfEa9C5C7cEywV0sa9U+Mx/YeZy90srwmF/2pc+j36tWhiqZnUUeZC6iE
 KtXmjAhYGPpbE9Z3gMkovMzxx4VWuxOrg8VRvn+jmiR5Yzyb+0/Aog3IXSNE7m3t1z8t
 yaGalfhckS0WbD/tX7m5jq3efU2G+qy/j2VFAqbFceSx6OK+YF8uqKhtHvt70S8o6xHU
 uuFNT8Ml76jp5tApMNN3d41JrfEjPVPOguh/lziF0Wo7CKnUJdNHeJHg01QJtGJpE8Cs
 RuFigCEqoI9MWKY6/CW05xQjlqJ7OM93TT5VjRXxG55k8nDLzKFqm3gN95DvN3SDRwO/
 1D4Q==
X-Gm-Message-State: AOJu0Yx5fJ6CFkC1EPxy0lFrAWrPWdTFdVpOgTopRLtIoMDRkm2jYodj
 W/V+/U+chyPzlzBzo7B1ciCHxmkmyE7hZEVaXblauvCu5xxywQCk
X-Google-Smtp-Source: AGHT+IEzIx0/vloPOnlrY6rgmuR8Oe3koUeuxac/DwfJ2ZCc0oRRdAn42QI6PAwgk3yiNYTSAdpJeg==
X-Received: by 2002:a05:6a20:49aa:b0:1a0:e4a6:5d31 with SMTP id
 fs42-20020a056a2049aa00b001a0e4a65d31mr5142856pzb.55.1710252229643; 
 Tue, 12 Mar 2024 07:03:49 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 d1-20020a62f801000000b006e6253bbcb7sm6052740pfh.61.2024.03.12.07.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 07:03:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 00:03:43 +1000
Message-Id: <CZRTTCV604Z3.3MT5MR0P5FWQK@wheely>
Subject: Re: [PATCH v4 05/24] Revert "replay: stop us hanging in
 rr_wait_io_event"
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: <qemu-devel@nongnu.org>, "Pavel Dovgalyuk" <Pavel.Dovgalyuk@ispras.ru>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "John Snow" <jsnow@redhat.com>, "Cleber Rosa"
 <crosa@redhat.com>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>, "Michael Tokarev" <mjt@tls.msk.ru>
X-Mailer: aerc 0.15.2
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-6-npiggin@gmail.com>
 <87v85ro9qt.fsf@draig.linaro.org>
In-Reply-To: <87v85ro9qt.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

On Tue Mar 12, 2024 at 11:33 PM AEST, Alex Benn=C3=A9e wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > This reverts commit 1f881ea4a444ef36a8b6907b0b82be4b3af253a2.
> >
> > That commit causes reverse_debugging.py test failures, and does
> > not seem to solve the root cause of the problem x86-64 still
> > hangs in record/replay tests.
>
> I'm still finding the reverse debugging tests failing with this series.

:(

In gitlab CI or your own testing? What are you running exactly?

I found 440fx must have some bug becaues it's quite bad, but
q35 was more stable.

>
> > The problem with short-cutting the iowait that was taken during
> > record phase is that related events will not get consumed at the
> > same points (e.g., reading the clock).
> >
> > A hang with zero icount always seems to be a symptom of an earlier
> > problem that has caused the recording to become out of synch with
> > the execution and consumption of events by replay.
>
> Would it be possible to still detect the failure mode rather than a full
> revert?

I'm not actually sure exactly how this patch causes test failures
(or how it was fixing the ones you saw). If I can reproduce the
ones you see I could look a bit deeper at it.

I have been looking at some ways to try detect/report record/replay
errors more sanely because it can be very hard to debug them at
the moment. No patches quite ready to post yet, but yes if there's
something we could do here to help we should.

Thanks,
Nick

>
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  include/sysemu/replay.h      |  5 -----
> >  accel/tcg/tcg-accel-ops-rr.c |  2 +-
> >  replay/replay.c              | 21 ---------------------
> >  3 files changed, 1 insertion(+), 27 deletions(-)
> >
> > diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> > index f229b2109c..8102fa54f0 100644
> > --- a/include/sysemu/replay.h
> > +++ b/include/sysemu/replay.h
> > @@ -73,11 +73,6 @@ int replay_get_instructions(void);
> >  /*! Updates instructions counter in replay mode. */
> >  void replay_account_executed_instructions(void);
> > =20
> > -/**
> > - * replay_can_wait: check if we should pause for wait-io
> > - */
> > -bool replay_can_wait(void);
> > -
> >  /* Processing clocks and other time sources */
> > =20
> >  /*! Save the specified clock */
> > diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.=
c
> > index 894e73e52c..a942442a33 100644
> > --- a/accel/tcg/tcg-accel-ops-rr.c
> > +++ b/accel/tcg/tcg-accel-ops-rr.c
> > @@ -109,7 +109,7 @@ static void rr_wait_io_event(void)
> >  {
> >      CPUState *cpu;
> > =20
> > -    while (all_cpu_threads_idle() && replay_can_wait()) {
> > +    while (all_cpu_threads_idle()) {
> >          rr_stop_kick_timer();
> >          qemu_cond_wait_bql(first_cpu->halt_cond);
> >      }
> > diff --git a/replay/replay.c b/replay/replay.c
> > index b8564a4813..895fa6b67a 100644
> > --- a/replay/replay.c
> > +++ b/replay/replay.c
> > @@ -451,27 +451,6 @@ void replay_start(void)
> >      replay_enable_events();
> >  }
> > =20
> > -/*
> > - * For none/record the answer is yes.
> > - */
> > -bool replay_can_wait(void)
> > -{
> > -    if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
> > -        /*
> > -         * For playback we shouldn't ever be at a point we wait. If
> > -         * the instruction count has reached zero and we have an
> > -         * unconsumed event we should go around again and consume it.
> > -         */
> > -        if (replay_state.instruction_count =3D=3D 0 && replay_state.ha=
s_unread_data) {
> > -            return false;
> > -        } else {
> > -            replay_sync_error("Playback shouldn't have to iowait");
> > -        }
> > -    }
> > -    return true;
> > -}
> > -
> > -
> >  void replay_finish(void)
> >  {
> >      if (replay_mode =3D=3D REPLAY_MODE_NONE) {


