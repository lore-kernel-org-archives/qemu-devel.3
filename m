Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D043DCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 18:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEApC-0004cZ-G8; Wed, 29 Oct 2025 14:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEApB-0004bt-3i
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 14:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEAp3-0002TV-IM
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 14:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761762173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jBynEImvavthhi6mxc0dORlXJBBFx3LgWVYpGNmOIMw=;
 b=Jqusy4eqABu3OpEw6LOzN89i8fyl6pvRxMTTGWvf7jatXvoS6Y1mUkJAzGcjKUogj4tNNR
 Q2Ca1RFtHMhs1IGb1UNnSGyBdqPsHdexL1pSZ7U3sK6l3gv3/Q5KYPfjMaGR4LYGVtX4N7
 r0cvhHVr+hytfv6cN/8PL3UM8BMCgp4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-DdhkTuYnPwe3gkVSo5kMPA-1; Wed, 29 Oct 2025 14:22:52 -0400
X-MC-Unique: DdhkTuYnPwe3gkVSo5kMPA-1
X-Mimecast-MFC-AGG-ID: DdhkTuYnPwe3gkVSo5kMPA_1761762171
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-78e5b6f1296so5186696d6.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 11:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761762171; x=1762366971;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBynEImvavthhi6mxc0dORlXJBBFx3LgWVYpGNmOIMw=;
 b=RjSPM4cHd3ax5APUoUcN35WtSWJgMn/zJOnEgWZaNsgYBtpQ51wPIMg9t8HFzJ4hyK
 5kvlCG01Rvy/ftvaEjJCiB7SbZd0qHx0BGo035ddbuqA8Vi+QPLAcB5nc3YxlvdTvr0g
 /aVE8scvuy1IWu09GtKx4YZz3t6jdHOMamt3MYX7hVfUp8DiW/gnUHJo5szQy2Ml2AFl
 o18oTYhXZcdAIb1LxbwbuPBGRirTpIiKUsW9BbyNK+nSiymgYUYygouAo/62ahJyv89q
 oVoVJM1kC43JV5YITbTG6m/qpWPXVmPvSDxwC5QVEqI2tAASUM5803nItSQl0L+fqC9l
 dRFQ==
X-Gm-Message-State: AOJu0YxeU40kFkIQNyysETMjQVXUxsA82B831pz8Ka+91rXMSbQ6yP+t
 e3EUyXnSl8hihwvMnF8vCI0p1ordi064/IoU+m7VZM8NqqcQBm7GfgggnXtcmT6sroGZHdNZQV/
 dA+NSO5glv88ppCkF5/gJ9wCp39KAZ/GIiWquCOCCgHjfH6W/mFSFJra1
X-Gm-Gg: ASbGncsgemfEdZE/JKgboeAaJALCJjPsJIvSn3Uv06k6hUPGSBskMYhavrivSmLB99V
 Rr+7DSsPE/9eMv4yCZQsXZjyo9GPVQ6AfCXWlp9CQCv8qIZFddLjxmVwHkhNC5Nhp5up4VlTfDI
 jaU2v7vO/ACSqK85b5PJ7nQaHPT4LTaf+8g1dArvBzueR3h4uE82fQjckCzR0oG01Y+GaAhyHLt
 sLvzmt4oe9FVzUTLdosuwZDZfl+IpLMLFpav0JSx7P6ACGMVzd4Wl3kMQYR3hrl2/Oa5Z3om0su
 Fy42usAgWXyouejnZ9wsLEqwLnbmaD+kgUoDyo/UMjf2Bl0ZCN1GX17KungbiTq6a7Q=
X-Received: by 2002:a05:6214:2588:b0:87d:fcf6:b1fb with SMTP id
 6a1803df08f44-88009ad5b1cmr45165996d6.1.1761762171221; 
 Wed, 29 Oct 2025 11:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyYxikt3cFmnM71PSddH/7nVooOW2kBrIfxdGlX4rgwgSpmpRT73wqnlpi8NcNNTVLzTLqPw==
X-Received: by 2002:a05:6214:2588:b0:87d:fcf6:b1fb with SMTP id
 6a1803df08f44-88009ad5b1cmr45165486d6.1.1761762170650; 
 Wed, 29 Oct 2025 11:22:50 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87fc51e3746sm101302036d6.25.2025.10.29.11.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 11:22:49 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:22:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
Message-ID: <aQJbd5qYR10qcbr7@x1.local>
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <20251029-force_rcu-v1-4-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029-force_rcu-v1-4-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 29, 2025 at 03:12:48PM +0900, Akihiko Odaki wrote:
> drain_call_rcu() triggers the force quiescent state, but it can be
> delayed if the RCU thread is sleeping. Ensure the force quiescent state
> is immediately triggered by waking the RCU thread up.
> 
> The logic to trigger the force quiescent state is decoupled as
> force_rcu() so that it can be used independently.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  include/qemu/rcu.h |   1 +
>  util/rcu.c         | 106 ++++++++++++++++++++++++++++++++---------------------
>  2 files changed, 65 insertions(+), 42 deletions(-)
> 
> diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> index 020dbe4d8b77..d6aa4e5854d3 100644
> --- a/include/qemu/rcu.h
> +++ b/include/qemu/rcu.h
> @@ -118,6 +118,7 @@ static inline void rcu_read_unlock(void)
>      }
>  }
>  
> +void force_rcu(void);
>  void synchronize_rcu(void);
>  
>  /*
> diff --git a/util/rcu.c b/util/rcu.c
> index 3c4af9d213c8..85f9333f5dff 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -49,10 +49,13 @@
>  unsigned long rcu_gp_ctr = RCU_GP_LOCKED;
>  
>  QemuEvent rcu_gp_event;
> -static int in_drain_call_rcu;
> +static bool forced;
>  static int rcu_call_count;
>  static QemuMutex rcu_registry_lock;
>  
> +/* Set when the forced variable is set or rcu_call_count becomes non-zero. */
> +static QemuEvent sync_event;
> +
>  /*
>   * Check whether a quiescent state was crossed between the beginning of
>   * update_counter_and_wait and now.
> @@ -74,36 +77,21 @@ QEMU_DEFINE_CO_TLS(struct rcu_reader_data, rcu_reader)
>  typedef QLIST_HEAD(, rcu_reader_data) ThreadList;
>  static ThreadList registry = QLIST_HEAD_INITIALIZER(registry);
>  
> +void force_rcu(void)
> +{
> +    qatomic_set(&forced, true);
> +    qemu_event_set(&sync_event);
> +}
> +
>  /* Wait for previous parity/grace period to be empty of readers.  */
> -static void wait_for_readers(void)
> +static void wait_for_readers(bool sleep)
>  {
>      ThreadList qsreaders = QLIST_HEAD_INITIALIZER(qsreaders);
>      struct rcu_reader_data *index, *tmp;
> -    int sleeps = 0;
> -    bool forced = false;
> +    int sleeps = sleep ? 5 : 0;
> +    bool waiting = false;
>  
>      for (;;) {
> -        /*
> -         * Force the grace period to end and wait for it if any of the
> -         * following heuristical conditions are satisfied:
> -         * - A decent number of callbacks piled up.
> -         * - It timed out.
> -         * - It is in a drain_call_rcu() call.
> -         *
> -         * Otherwise, periodically poll the grace period, hoping it ends
> -         * promptly.
> -         */
> -        if (!forced &&
> -            (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
> -             sleeps >= 5 || qatomic_read(&in_drain_call_rcu))) {
> -            forced = true;
> -
> -            QLIST_FOREACH(index, &registry, node) {
> -                notifier_list_notify(&index->force_rcu, NULL);
> -                qatomic_set(&index->waiting, true);
> -            }
> -        }

IIUC this is the part to set index->waiting first whenever necessary, then
that'll guarantee the wait(rcu_gp_event) will be notified in rcu unlock.

Now we removed this chunk, then could it happen if waiting=true and the
wait(rcu_gp_event) may wait for more than it should (as nobody will wake it
up if all threads have waiting=false)?

The other thing is, right below here there's the code and comment:

        /* Here, order the stores to index->waiting before the loads of
         * index->ctr.  Pairs with smp_mb_placeholder() in rcu_read_unlock(),
         * ensuring that the loads of index->ctr are sequentially consistent.
         *
         * If this is the last iteration, this barrier also prevents
         * frees from seeping upwards, and orders the two wait phases
         * on architectures with 32-bit longs; see enter_qs().
         */
        smp_mb_global();

IIUC it explains the mb_global() to order the updates of waiting and the
reads of index->ctr.  It doesn't look like applicable anymore.  Said that,
I think we should indeed still need some barrier to make sure we read
index->ctr at least to be after we update global gp_ctr (done before
calling wait_for_readers()).  I'm not sure if it means the mb is needed,
however maybe at least the comment is outdated if so.

> -
>          /* Here, order the stores to index->waiting before the loads of
>           * index->ctr.  Pairs with smp_mb_placeholder() in rcu_read_unlock(),
>           * ensuring that the loads of index->ctr are sequentially consistent.
> @@ -150,7 +138,8 @@ static void wait_for_readers(void)
>           */
>          qemu_mutex_unlock(&rcu_registry_lock);
>  
> -        if (forced) {
> +        if (waiting) {
> +            /* Wait for the forced quiescent state. */
>              qemu_event_wait(&rcu_gp_event);
>  
>              /*
> @@ -158,9 +147,25 @@ static void wait_for_readers(void)
>               * while we walk the list.
>               */
>              qemu_event_reset(&rcu_gp_event);
> +        } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
> +                   !sleeps || qemu_event_timedwait(&sync_event, 10)) {
> +            /*
> +             * Now one of the following heuristical conditions is satisfied:
> +             * - A decent number of callbacks piled up.
> +             * - It timed out.
> +             * - force_rcu() was called.
> +             *
> +             * Force a quiescent state.
> +             */
> +            waiting = true;
> +
> +            QLIST_FOREACH(index, &registry, node) {
> +                notifier_list_notify(&index->force_rcu, NULL);
> +                qatomic_set(&index->waiting, true);
> +            }
>          } else {
> -            g_usleep(10000);
> -            sleeps++;
> +            /* Try again. */
> +            sleeps--;
>          }
>  
>          qemu_mutex_lock(&rcu_registry_lock);
> @@ -170,7 +175,7 @@ static void wait_for_readers(void)
>      QLIST_SWAP(&registry, &qsreaders, node);
>  }
>  
> -static void enter_qs(void)
> +static void enter_qs(bool sleep)
>  {
>      /* Write RCU-protected pointers before reading p_rcu_reader->ctr.
>       * Pairs with smp_mb_placeholder() in rcu_read_lock().
> @@ -189,14 +194,14 @@ static void enter_qs(void)
>               * Switch parity: 0 -> 1, 1 -> 0.
>               */
>              qatomic_set(&rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
> -            wait_for_readers();
> +            wait_for_readers(sleep);
>              qatomic_set(&rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
>          } else {
>              /* Increment current grace period.  */
>              qatomic_set(&rcu_gp_ctr, rcu_gp_ctr + RCU_GP_CTR);
>          }
>  
> -        wait_for_readers();
> +        wait_for_readers(sleep);
>      }
>  }
>  
> @@ -205,7 +210,6 @@ static void enter_qs(void)
>   */
>  static struct rcu_head dummy;
>  static struct rcu_head *head = &dummy, **tail = &dummy.next;
> -static QemuEvent rcu_call_ready_event;
>  
>  static void enqueue(struct rcu_head *node)
>  {
> @@ -282,6 +286,7 @@ static void *call_rcu_thread(void *opaque)
>      rcu_register_thread();
>  
>      for (;;) {
> +        bool sleep = true;
>          int n;
>  
>          /*
> @@ -289,7 +294,7 @@ static void *call_rcu_thread(void *opaque)
>           * added before enter_qs() starts.
>           */
>          for (;;) {
> -            qemu_event_reset(&rcu_call_ready_event);
> +            qemu_event_reset(&sync_event);
>              n = qatomic_read(&rcu_call_count);
>              if (n) {
>                  break;
> @@ -298,20 +303,36 @@ static void *call_rcu_thread(void *opaque)
>  #if defined(CONFIG_MALLOC_TRIM)
>              malloc_trim(4 * 1024 * 1024);
>  #endif
> -            qemu_event_wait(&rcu_call_ready_event);
> +            qemu_event_wait(&sync_event);
> +        }
> +
> +        /*
> +         * Ensure that an event for a rcu_call_count change will not interrupt
> +         * wait_for_readers().
> +         */
> +        qemu_event_reset(&sync_event);
> +
> +        /*
> +         * Ensure that the forced variable has not been set after fetching
> +         * rcu_call_count; otherwise we may get confused by a force quiescent
> +         * state request for an element later than n.
> +         */
> +        while (qatomic_xchg(&forced, false)) {
> +            sleep = false;
> +            n = qatomic_read(&rcu_call_count);
>          }

This is pretty tricky, and I wonder if it will make the code easier to read
if we convert the sync_event to be a semaphore instead.  When as a sem, it
will take account of whatever kick to it, either a call_rcu1() or an
enforced rcu flush, so that we don't need to reset it.  Meanwhile, we don't
worry on an slightly outdated "n" read because the 2nd round of sem_wait()
will catch that new "n".

Instead, worst case is rcu thread runs one more round without seeing
callbacks on the queue.

I'm not sure if that could help simplying code, maybe also make it less
error-prone.

>  
> -        enter_qs();
> +        enter_qs(sleep);
>          qatomic_sub(&rcu_call_count, n);
>          bql_lock();
>          while (n > 0) {
>              node = try_dequeue();
>              while (!node) {

I have a pure question here not relevant to your changes.. do you know when
this "if" will trigger?  It seems to me the enqueue() should always happen
before the increment of rcu_call_count:

void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
{
    node->func = func;
    enqueue(node);

    if (!qatomic_fetch_inc(&rcu_call_count)) {
        qemu_event_set(&sync_event);
    }
}

I believe qatomic_fetch_inc() is RMW so it's strong mb and order
guaranteed.  Then here why the node can be null even if we're sure >=n have
been enqueued?

Thanks,

>                  bql_unlock();
> -                qemu_event_reset(&rcu_call_ready_event);
> +                qemu_event_reset(&sync_event);
>                  node = try_dequeue();
>                  if (!node) {
> -                    qemu_event_wait(&rcu_call_ready_event);
> +                    qemu_event_wait(&sync_event);
>                      node = try_dequeue();
>                  }
>                  bql_lock();
> @@ -329,8 +350,10 @@ void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
>  {
>      node->func = func;
>      enqueue(node);
> -    qatomic_inc(&rcu_call_count);
> -    qemu_event_set(&rcu_call_ready_event);
> +
> +    if (!qatomic_fetch_inc(&rcu_call_count)) {
> +        qemu_event_set(&sync_event);
> +    }
>  }
>  
>  
> @@ -388,10 +411,9 @@ void drain_call_rcu(void)
>       * assumed.
>       */
>  
> -    qatomic_inc(&in_drain_call_rcu);
>      call_rcu(&sync, sync_rcu_callback, rcu);
> +    force_rcu();
>      qemu_event_wait(&sync.complete_event);
> -    qatomic_dec(&in_drain_call_rcu);
>  
>      if (locked) {
>          bql_lock();
> @@ -435,7 +457,7 @@ static void rcu_init_complete(void)
>      qemu_mutex_init(&rcu_registry_lock);
>      qemu_event_init(&rcu_gp_event, true);
>  
> -    qemu_event_init(&rcu_call_ready_event, false);
> +    qemu_event_init(&sync_event, false);
>  
>      /* The caller is assumed to have BQL, so the call_rcu thread
>       * must have been quiescent even after forking, just recreate it.
> 
> -- 
> 2.51.0
> 
> 

-- 
Peter Xu


