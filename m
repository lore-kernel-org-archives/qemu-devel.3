Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC29BC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrjv-00016A-Tx; Thu, 27 Jun 2024 12:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sMrju-00015o-8l
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:12:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sMrjs-0003A7-Kc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:12:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fa4b332645so214615ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719504767; x=1720109567; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KXMUu0UdCwUlKRX4qSoKUN9A0yZ162CmwMZuZE9gwE=;
 b=4bTGPyGIj1x0TWzYhHIPl4eXZDwSUEsNUpczEjuMMhozaObAoUCFwQzmAxsuqajo6c
 /LdI5raOA17X8vbLcHX6HZL5uIE7NL6G5rY192BeDAugOT3/PQhoRiupSCj7aTt2JQoQ
 uqB0iS1tFDDW+Y7E8F91TfeWLaCmTP5IGPbTujEZBPzq2dyilxwmOM54meMGbOPwmX5B
 cBAyzrN+op3XwPSmKo6f+fSu+emfd9Gf0m42ExINYGPC7wlkcr2ZuhyhnIP/Ryr2Dt6G
 LG6oQHvmV5AmleOLbTRarnzDXXQrzCPaGJ7BIWxZb1vWdxx7A29spEH9HWD8o5AWsLcd
 LLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719504767; x=1720109567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5KXMUu0UdCwUlKRX4qSoKUN9A0yZ162CmwMZuZE9gwE=;
 b=SaOk2UZiBBGsp2Ei18ksui9Jc8pWBMjPRoDGTks0cu0tXQWoy99DiT18y/ZyD2vmPJ
 zwXzxMsOvQSFrQk815dqgNtCwtS1J53AEs+sM+aCq8Twfnfbla4MA4Yfevptfsy4Fsg0
 eZMpzd/pSYxqRevnhl++inyslpTrZjBQ5bhOfCANS+PIdzbyhl9/4aCRNVueTck3R2xF
 UbBE7AAo92jRAJoC0HMPCjNIq0+2ZcTdNWaFEsPJndLg5u58xdnDQBp699mEHBQuBKJC
 TA1B0Cne+AMDv+qX/PT8UTQscbLKfMt2eClO4IzKoDzzxK3vaxpcW9JDXjU/Wm/Vf2uP
 k7FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNzava1rPZJGIrE5Ih1KGLIYM7h1JVIoy2TATHtdB89ytWGzJD2SX9kLwgBQdGJp5ruH2l8h7kk7SNOvkKcPTHNXkWjRM=
X-Gm-Message-State: AOJu0YyRgJFB9Y8PJJagDenroJdL6Y/LYtMwOpLcG2k7PgQp/5Fc0NQ9
 xndChCJxxu9I7ii7N17M/zGVHbhpM0sWBU7M2QkoYQg1HV7SqbO2Gw5x47LQaBncstxpKEbmbOM
 6/DQiO5xC6pdcu77zFQS9waolJ1MNBpR6Corw
X-Google-Smtp-Source: AGHT+IEGl1yk/WgMMrRhA5dhRJg3Fxm9sU1Py0YXF+scvyPY+3JT0sIZJ2IkzTsSByAzWgIo4trkhL22ZUtLnrocFoo=
X-Received: by 2002:a17:902:d0ca:b0:1f6:3a2e:f6c6 with SMTP id
 d9443c01a7336-1faab58f037mr3467305ad.21.1719504766561; Thu, 27 Jun 2024
 09:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <ad0740c5-9bc2-443c-9caa-a243b3a29108@redhat.com>
 <20240627003134.3447175-1-rkir@google.com>
 <CABgObfajkBU9-aGQcDGf6taUGwZOG=O5sewzc1HjCWTb5cVA1A@mail.gmail.com>
In-Reply-To: <CABgObfajkBU9-aGQcDGf6taUGwZOG=O5sewzc1HjCWTb5cVA1A@mail.gmail.com>
From: Roman Kiryanov <rkir@google.com>
Date: Thu, 27 Jun 2024 09:12:34 -0700
Message-ID: <CAOGAQepLGTY-92So1arNZWjg9m+HZ8AjZ28Gsscm2ai5sj1AMQ@mail.gmail.com>
Subject: Re: [PATCH v3] timer: Fix a race condition between timer's callback
 and destroying code
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: jansene@google.com, jpcottin@google.com, mett@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=rkir@google.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Jun 27, 2024 at 6:27=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Thu, Jun 27, 2024 at 2:32=E2=80=AFAM Roman Kiryanov <rkir@google.com> =
wrote:
> > +        if (qatomic_read(&ts->cb_running)) {
> > +            qemu_event_wait(&timer_list->timers_done_ev);
> > +        }
>
> qemu_event_wait() already has the right atomic magic, and
> ts->cb_running is both redundant (in general), and I think racy (as
> implemented in this patch).

I added cb_running to avoid waiting for timers_done_ev if we know our
cb is done.

> But especially, you haven't justified in the commit message _why_ you
> need this.

I mentioned the problem of cleanup racing with the timer's callback functio=
n
in the current shape of QEMU.

> Since this problem is not timer-specific,

It would be nice to fix all the places then.

> using
> aio_bh_schedule_oneshot() or aio_wait_bh_oneshot() to synchronize
> everything with the AioContext thread seems like a superior solution
> to me.

Could you please elaborate? The problem we want to solve is this:

void myThreadFunc() {
    CallbackState callbackState;
    QEMUTimer timer;

    timer_init(&timer, myClockType, myScale, &myTimerCallbackFunc,
&callbackState);
    ...
    timer_del(&timer);
}

Currently, myTimerCallbackFunc could fire after myThreadFunc exits
(if timer_del runs between qemu_mutex_unlock and cb(opaque) in
timerlist_run_timers) and callbackState gets destroyed.

