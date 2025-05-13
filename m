Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB0CC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqn8-0004lO-Br; Tue, 13 May 2025 10:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEqn4-0004ko-Ql
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEqn0-0000Da-I9
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747147161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKIb+NNFBx7lN7TsF1SJoa2e52wymOjBwgkOJd6yNU8=;
 b=Zqi/6RAcrzAu4az4PDzJuvIBmXbah4DAAtLG/NTJvsW7eqkl6mfHMzVaIba3Kqv6XqQpBA
 W85wUfAOKfTh5k/HGvI2cK7tTZ7UYiytaX/OuvSLI9XXyawvyI96Rj69ZNc+nQPXh1vOQR
 JoLPK22WV++ycrXoXn/yV7GbZFgdHVM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-Qoci6N_wMTOZiNt_g9z0gQ-1; Tue, 13 May 2025 10:39:19 -0400
X-MC-Unique: Qoci6N_wMTOZiNt_g9z0gQ-1
X-Mimecast-MFC-AGG-ID: Qoci6N_wMTOZiNt_g9z0gQ_1747147159
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7cabd21579eso642518185a.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747147159; x=1747751959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tKIb+NNFBx7lN7TsF1SJoa2e52wymOjBwgkOJd6yNU8=;
 b=AEnN8PTcUR32QWP9e+DpA7q1GwBRPPdC0+6nh77zPNU8gCrV22jI00wfEqPPj6R4Vy
 y9oUdXFpKaGiUa1uHUIaHEdVcSCVvYfHSL8g0G2j+/ZMyyx4lTT0Nzu8ZT1+N0ab7M8U
 jkdqBtw6rXZOmPowsowwc0iXmtUijp04RWXeN4ZtMpMa+XYQWNr4jS2Ke42qBShB6Uka
 9C3Et2vBOiuoLOpPHFHn22qOtJwsO7fK6tkS9RWPr3Psgd4aRU9NWa3u3H9zKjSWG5av
 pTDBy7PjnVlbwBiU4mpEwGW4iib9BvpY66tLl1+jW8dZOFGRGdt30yFjtkBZRu/p2STx
 BQFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpo9FgYwUR8Zda8MBhlEBphwmcNu1XL5zCR2jqb3xkfBBEfa0zgpqgoVOeBr3VrgjIl4rc0U3qbMHP@nongnu.org
X-Gm-Message-State: AOJu0YyT/ocyEZUvr09/377o11+UU187AIIQuqer5LU7gZz55enMHmUK
 15psBUD6OslEWyxGdJXI0PY3O7LyABkWM5/pPZpkkQJ5FDiE4eybqTlYLMKWxIAE2Y+FVOQMOSX
 Ukpjr3FakzEM5GzfuFumLqK4XOZmy/w8PncFd8tFQKlTKI2RhOKAK
X-Gm-Gg: ASbGnctUgx3s9/Ob1eo96kgpURFhZTq94S4CDOLT6o8WvN+brSgyJOl/q7Cyt/z3RX2
 YsMC9iarj3bH0KXZQ+TMei+35DiwUKyay+Fn2iP6BklUf5nn/H+rhw9C7wVPAb9thGXho2/o60B
 0SFziSJJqyQPQW9HrQtrqOBrS7RRS0PssZKaLrSXMfn7Zu0o8uOdQr1lE13fjGmb+kLAKF6b11b
 tKvtvyDuTgjpZTw5lqm6GiaGYQX+111gUj/FLVWi6jsuud7Mteh3Lmgam9CsmZNi3V+II9yrW6E
 yoE=
X-Received: by 2002:a05:620a:26a1:b0:7ca:c6c7:be14 with SMTP id
 af79cd13be357-7cd010f4014mr3211597385a.1.1747147159071; 
 Tue, 13 May 2025 07:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+OMBccPgjAc4ocJakSWnZg2IYNULHJXrt/nKSn58lFOk3VjOzYhCicSqbT4KrrMYEwThgOg==
X-Received: by 2002:a05:620a:26a1:b0:7ca:c6c7:be14 with SMTP id
 af79cd13be357-7cd010f4014mr3211592885a.1.1747147158654; 
 Tue, 13 May 2025 07:39:18 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00fddb2bsm711328185a.74.2025.05.13.07.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 07:39:18 -0700 (PDT)
Date: Tue, 13 May 2025 10:39:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 01/10] futex: Check value after qemu_futex_wait()
Message-ID: <aCNZk73GuEaU-gcK@x1.local>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-1-f7f69247d303@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250511-event-v3-1-f7f69247d303@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, May 11, 2025 at 03:08:18PM +0900, Akihiko Odaki wrote:
> futex(2) - Linux manual page
> https://man7.org/linux/man-pages/man2/futex.2.html
> > Note that a wake-up can also be caused by common futex usage patterns
> > in unrelated code that happened to have previously used the futex
> > word's memory location (e.g., typical futex-based implementations of
> > Pthreads mutexes can cause this under some conditions).  Therefore,
> > callers should always conservatively assume that a return value of 0
> > can mean a spurious wake-up, and use the futex word's value (i.e.,
> > the user-space synchronization scheme) to decide whether to continue
> > to block or not.

I'm just curious - do you know when this will happen?

AFAIU, QEMU uses futex always on private mappings, internally futex does
use (mm, HVA) tuple to index a futex, afaict.  Hence, I don't see how it
can get spurious wakeups..  And _if_ it happens, since mm pointer can't
change it must mean the HVA of the futex word is reused, it sounds like an
UAF user bug to me instead.

I checked the man-pages git repo, this line was introduced in:

https://github.com/mkerrisk/man-pages/commit/4b35dc5dabcf356ce6dcb1f949f7b00e76c7587d

I also didn't see details yet in commit message on why that paragraph was
added.

And..

> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/qemu/futex.h              |  9 +++++++++
>  tests/unit/test-aio-multithread.c |  4 +++-
>  util/qemu-thread-posix.c          | 28 ++++++++++++++++------------
>  3 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/include/qemu/futex.h b/include/qemu/futex.h
> index 91ae88966e12..f57774005330 100644
> --- a/include/qemu/futex.h
> +++ b/include/qemu/futex.h
> @@ -24,6 +24,15 @@ static inline void qemu_futex_wake(void *f, int n)
>      qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
>  }
>  
> +/*
> + * Note that a wake-up can also be caused by common futex usage patterns in
> + * unrelated code that happened to have previously used the futex word's
> + * memory location (e.g., typical futex-based implementations of Pthreads
> + * mutexes can cause this under some conditions).  Therefore, callers should

.. another thing that was unclear to me is, here it's mentioning "typical
futex-based implementations of pthreads mutexes..", but here
qemu_futex_wait() is using raw futex without any pthread impl.  Does it
also mean that this may not be applicable to whatever might cause a
spurious wakeup?

> + * always conservatively assume that it is a spurious wake-up, and use the futex
> + * word's value (i.e., the user-space synchronization scheme) to decide whether
> + * to continue to block or not.
> + */
>  static inline void qemu_futex_wait(void *f, unsigned val)
>  {
>      while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
> diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
> index 08d4570ccb14..8c2e41545a29 100644
> --- a/tests/unit/test-aio-multithread.c
> +++ b/tests/unit/test-aio-multithread.c
> @@ -305,7 +305,9 @@ static void mcs_mutex_lock(void)
>      prev = qatomic_xchg(&mutex_head, id);
>      if (prev != -1) {
>          qatomic_set(&nodes[prev].next, id);
> -        qemu_futex_wait(&nodes[id].locked, 1);
> +        while (qatomic_read(&nodes[id].locked) == 1) {
> +            qemu_futex_wait(&nodes[id].locked, 1);
> +        }
>      }
>  }
>  
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index b2e26e21205b..eade5311d175 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -428,17 +428,21 @@ void qemu_event_wait(QemuEvent *ev)
>  
>      assert(ev->initialized);
>  
> -    /*
> -     * qemu_event_wait must synchronize with qemu_event_set even if it does
> -     * not go down the slow path, so this load-acquire is needed that
> -     * synchronizes with the first memory barrier in qemu_event_set().
> -     *
> -     * If we do go down the slow path, there is no requirement at all: we
> -     * might miss a qemu_event_set() here but ultimately the memory barrier in
> -     * qemu_futex_wait() will ensure the check is done correctly.
> -     */
> -    value = qatomic_load_acquire(&ev->value);
> -    if (value != EV_SET) {
> +    while (true) {
> +        /*
> +         * qemu_event_wait must synchronize with qemu_event_set even if it does
> +         * not go down the slow path, so this load-acquire is needed that
> +         * synchronizes with the first memory barrier in qemu_event_set().
> +         *
> +         * If we do go down the slow path, there is no requirement at all: we
> +         * might miss a qemu_event_set() here but ultimately the memory barrier
> +         * in qemu_futex_wait() will ensure the check is done correctly.
> +         */
> +        value = qatomic_load_acquire(&ev->value);
> +        if (value == EV_SET) {
> +            break;
> +        }
> +
>          if (value == EV_FREE) {
>              /*
>               * Leave the event reset and tell qemu_event_set that there are
> @@ -452,7 +456,7 @@ void qemu_event_wait(QemuEvent *ev)
>               * like the load above.
>               */
>              if (qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
> -                return;
> +                break;
>              }
>          }
>  
> 
> -- 
> 2.49.0
> 

-- 
Peter Xu


