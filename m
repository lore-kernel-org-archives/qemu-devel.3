Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6297AC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMc4u-0005bK-IK; Wed, 26 Jun 2024 19:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMc4q-0005XY-UL
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMc4g-0005QL-U4
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719444552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o6IzZwIyxrphE6Rldk0gQ9bMNP3YAtTwpLWLimzSm5Y=;
 b=Hd0vukUKuSlyrSaXymGbPmMKZy4PtHaSmkczUze1Pt8AN6Z+amHwaBq8kQ080CjvBzAHND
 B+bZWa/M4iqIJkUP7R6IKwSdTdiYrdShVBRQH3RwYBgCnjaJISiiR/nAvbHLR7BMuy6JTC
 rlWofHCvZaFIJqyg5ts88TspR6WNtyw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-Wo5fvAfZPIaA5Eq-_l9hkQ-1; Wed, 26 Jun 2024 19:29:11 -0400
X-MC-Unique: Wo5fvAfZPIaA5Eq-_l9hkQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a72436378bdso270523066b.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719444550; x=1720049350;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o6IzZwIyxrphE6Rldk0gQ9bMNP3YAtTwpLWLimzSm5Y=;
 b=vWs/+WwXA3E0c5w5Z6PBsXUoGKkelqqjMWhFfWsoYAS6FOaDlpo+T+80ppX2xsb3pH
 oz/twV0yoYTN7ffQN+4CP3D26zEl1qCoGtbMfC888+KUgv79TvxSk2vKKTRo9B+XozZS
 kyrYJwez0XohJvVKOV64GOC6FykZqKLyI4mLgvw5ApyT4s8bHwszSuo6SQGEGa/nJcFo
 8zzS7GRFv2YPLlpRd8InBZ3C3F3uWLjrO2vZXebaxNAim2rGJ36Vd7bHZbPprVUItTVU
 3dpLtRms1BeHVikfppFXnScbv0Cio65uYrbdiqBDEIjSa/emvG5j2BNIsy/Sll8a3CZS
 iLQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNjeH1CLOB0xvhMroR4yD/PQJZ9UHZVc8HZBUqzlpIeoNwLCjC8pp6e3Zql1/uL0y8dQ4oduQYqluf5XaxY3ZyEdTZvg0=
X-Gm-Message-State: AOJu0Yz5liNwnIqNgUuLS0GgABvXfYpvVYqtYWsr+4/d7Q1UX4ljT9Q1
 PdYTHfXS5L/5OmUNYgKl+GZsOhE3Ld5YzIaMn379SHb4644qRZEW6+y3qbN9fBkK9CMcc8y9yHE
 b3L524//RpKeWl0NyDDmENyiWFoO1VySFmGZoQ3Gl2VQTsZ6/NkAt
X-Received: by 2002:a17:907:8743:b0:a72:542f:8251 with SMTP id
 a640c23a62f3a-a727f85a18bmr444990366b.56.1719444550184; 
 Wed, 26 Jun 2024 16:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw6DAEXlGg8s3MIIyK7cx9818e6xnAXmrTXQgouiQdZK4dqs2C3usMTpz7f2Z+6V69Xnu1KQ==
X-Received: by 2002:a17:907:8743:b0:a72:542f:8251 with SMTP id
 a640c23a62f3a-a727f85a18bmr444989866b.56.1719444549691; 
 Wed, 26 Jun 2024 16:29:09 -0700 (PDT)
Received: from [192.168.10.47] ([151.62.196.71])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a729d7b524csm2029666b.176.2024.06.26.16.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 16:29:09 -0700 (PDT)
Message-ID: <ad0740c5-9bc2-443c-9caa-a243b3a29108@redhat.com>
Date: Thu, 27 Jun 2024 01:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] timer: Fix a race condition between timer's callback
 and destroying code
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240626215241.3360246-1-rkir@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240626215241.3360246-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/26/24 23:52, Roman Kiryanov wrote:
> `timerlist_run_timers` provides no mechanism to
> make sure the data pointed by `opaque` is valid
> when calling timer's callback: there could be
> another thread running which is destroying
> timer's opaque data.
> 
> With this change `timer_del` becomes blocking if
> timer's callback is running and it will be safe
> to destroy timer's data once `timer_del` returns.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>

Generally QEMU is running event loop code under the "big QEMU lock" 
(BQL).  If both timer_del() and the callback run under the BQL, the race 
cannot happen.

If you're using multiple threads, however, this code is generally very 
performance sensitive; and adding a mutex and broadcast on every timer 
that fires is probably too much.  A simpler possibility (and the 
QemuEvent is already there, even) could be to use

     qemu_event_wait(&timer_list->timers_done_ev);

but I think this situation is not specific to timers, and tied more to 
the code that creates the timer; therefore it's easier to handle it 
outside common code.

If you only need to synchronize freeing against callbacks, you can use 
aio_bh_schedule_oneshot() and do the free in the bottom half.  If 
instead you need the cleanup to be synchronous, the same idea of the 
bottom half can be used, via aio_wait_bh_oneshot().

Paolo

> ---
> v2: rebased to the right branch and removed
>      Google specific tags from the commit message.
> 
>   include/qemu/timer.h |  4 ++++
>   util/qemu-timer.c    | 21 +++++++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 5ce83c7911..efd0e95d20 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -3,6 +3,7 @@
>   
>   #include "qemu/bitops.h"
>   #include "qemu/notify.h"
> +#include "qemu/thread.h"
>   #include "qemu/host-utils.h"
>   
>   #define NANOSECONDS_PER_SECOND 1000000000LL
> @@ -86,9 +87,12 @@ struct QEMUTimer {
>       QEMUTimerList *timer_list;
>       QEMUTimerCB *cb;
>       void *opaque;
> +    QemuMutex opaque_lock;
> +    QemuCond cb_done;
>       QEMUTimer *next;
>       int attributes;
>       int scale;
> +    bool cb_running;
>   };
>   
>   extern QEMUTimerListGroup main_loop_tlg;
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index 213114be68..95af255519 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -369,7 +369,10 @@ void timer_init_full(QEMUTimer *ts,
>       ts->opaque = opaque;
>       ts->scale = scale;
>       ts->attributes = attributes;
> +    qemu_mutex_init(&ts->opaque_lock);
> +    qemu_cond_init(&ts->cb_done);
>       ts->expire_time = -1;
> +    ts->cb_running = false;
>   }
>   
>   void timer_deinit(QEMUTimer *ts)
> @@ -394,6 +397,12 @@ static void timer_del_locked(QEMUTimerList *timer_list, QEMUTimer *ts)
>           }
>           pt = &t->next;
>       }
> +
> +    qemu_mutex_lock(&ts->opaque_lock);
> +    while (ts->cb_running) {
> +        qemu_cond_wait(&ts->cb_done, &ts->opaque_lock);
> +    }
> +    qemu_mutex_unlock(&ts->opaque_lock);
>   }
>   
>   static bool timer_mod_ns_locked(QEMUTimerList *timer_list,
> @@ -571,11 +580,23 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
>           cb = ts->cb;
>           opaque = ts->opaque;
>   
> +        /* Mark the callback as running to prevent
> +         * destroying `opaque` in another thread.
> +         */
> +        qemu_mutex_lock(&ts->opaque_lock);
> +        ts->cb_running = true;
> +        qemu_mutex_unlock(&ts->opaque_lock);
> +
>           /* run the callback (the timer list can be modified) */
>           qemu_mutex_unlock(&timer_list->active_timers_lock);
>           cb(opaque);
>           qemu_mutex_lock(&timer_list->active_timers_lock);
>   
> +        qemu_mutex_lock(&ts->opaque_lock);
> +        ts->cb_running = false;
> +        qemu_cond_broadcast(&ts->cb_done);
> +        qemu_mutex_unlock(&ts->opaque_lock);
> +
>           progress = true;
>       }
>       qemu_mutex_unlock(&timer_list->active_timers_lock);


