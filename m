Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC14DCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 15:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzdQn-0000Lc-Hn; Fri, 19 Sep 2025 11:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzdQb-0000L0-9f
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzdQX-0005C1-Tn
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758297210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Cw6Tl0IzgeTCzmi+XxIDY1SSR66h8oSbtfUqeueVi4=;
 b=KVYfzWOgDzHDc8iF1XQL/9AHVYeKFpps6sFjUmMQcOKPQjFWsykwsT3kOylUxRCuLyK+O5
 Nna2bCwxUthmZXa7ZeZcxfFQ42wbeewA3EaJI9k0BD4QXW9LeJU0uOgOOfTQ0BHr+Vrd7f
 7ISYA9jt7cJoYYw76sdLUq53EXAgD/Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-XUoeTYPRNeKS2xskcwUfng-1; Fri, 19 Sep 2025 11:53:28 -0400
X-MC-Unique: XUoeTYPRNeKS2xskcwUfng-1
X-Mimecast-MFC-AGG-ID: XUoeTYPRNeKS2xskcwUfng_1758297208
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b5ee6cd9a3so46652341cf.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 08:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758297208; x=1758902008;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Cw6Tl0IzgeTCzmi+XxIDY1SSR66h8oSbtfUqeueVi4=;
 b=mj2enBaxlKEfqPjpW0lqhK42zrTnV6apNMH/up1lj1cd444JEyAswUGQ9jFubIYYoy
 kLbmkYl1X/yUx8ru3tTPCeTheBO0DL/WiUt2NZX/v6YMiYzX/C6fc9NwoeSVGm4Q0OJ/
 xDDt8ezBiHYRBkqSm3VqiAw69NqkcLpM2BbgxCS657bcdwNGM/1Gi36763OuzM38/v0i
 anScfLEOrDS8Oshqig0sebgNn/agNFu0vNmTN43A1NM2E/gCJckLp0u9IQPbYxHqtYiw
 CTF453wI610fFzAUS3coGr+Aww5D0JG7dVZ3msVdCBtULhoI+wpF8oleyvXaLYNH37AF
 wE5g==
X-Gm-Message-State: AOJu0YzXdaFFpH3JkJBKjW44lVMEWHdVRf9DWzn8fqdaALHWN60e8sRG
 AcmxNM+Z3dLBeAaVaaTDZJCY93rH7TFf1/h+HOdz/Gu/TeVdKqVGb/V4kLAPkMkf9X/TdBFUfI0
 SMsjkTAUl6p4sxxyf8Q6WOFsbuFa71/W4gzniBoa3KMSmHSCH098L7S1i+X4AQQ7D
X-Gm-Gg: ASbGncuYEBzjfvl63pa9nF6kXXIzovumXFBCbOBvIwi6mQd3Q91MC1/umA3bT3dlyfC
 ZQHm9v8zFnVx4YxUP0CIfBcimvXK+nXMlE9oBdqrk2PVmu9+T5D387snC12eT2zzrhUaITGHupH
 P4fPyKnvHf8sea7OuBa6CRoiHeCLXFMzuNK7qwJP3sUQDtSo7pPSXev3hg/KZHPs1ztVJBXkGmm
 p6/nUybabwRrU6WE6G9umMav/zOeoO5N0++KCAJid59wByfbnT7wUML1DpohMgFhWl2X4hBmT9D
 qopF0eQnQ+ieYDM5HkUWeYP2hj54XmPJ
X-Received: by 2002:ac8:7c55:0:b0:4b6:23b7:c59e with SMTP id
 d75a77b69052e-4c06e3fa986mr50157351cf.23.1758297207711; 
 Fri, 19 Sep 2025 08:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0EzM9PK6yt9HN8ODCetMqneltwYEBNUNUfNBWdU47NHNhz2aOCGv8oy2tvEIDwX4ITt0EaA==
X-Received: by 2002:ac8:7c55:0:b0:4b6:23b7:c59e with SMTP id
 d75a77b69052e-4c06e3fa986mr50156621cf.23.1758297206988; 
 Fri, 19 Sep 2025 08:53:26 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda140c088sm31858171cf.6.2025.09.19.08.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 08:53:26 -0700 (PDT)
Date: Fri, 19 Sep 2025 11:53:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 3/4] migration: Refactor incoming cleanup into
 migration_incoming_finish()
Message-ID: <aM18dZFO4BP3AqCS@x1.local>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-4-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915115918.3520735-4-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 15, 2025 at 01:59:14PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Currently, there are two functions that are responsible for cleanup of
> the incoming migration state. With successful precopy, it's the main
> thread and with successful postcopy it's the listen thread. However, if
> postcopy fails during in the device load, both functions will try to do
> the cleanup. Moreover, when exit-on-error parameter was added, it was
> applied only to precopy.
> 
> This patch refactors common cleanup and exiting on error into a helper
> function that can be started either from precopy or postcopy, reducing
> the duplication. If the listen thread has been started (the postcopy
> state is at least LISTENING), the listen thread is responsible for all
> cleanup and exiting, otherwise it's the main thread's responsibility.

Looks almost good, thanks!  Only nitpicks below.

> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/migration.c | 64 ++++++++++++++++++++++++-------------------
>  migration/migration.h |  1 +
>  migration/savevm.c    | 48 +++++++++++---------------------
>  3 files changed, 53 insertions(+), 60 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 2c0b3a7229..7222e3de13 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -442,9 +442,19 @@ void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
>  void migration_incoming_state_destroy(void)
>  {
>      struct MigrationIncomingState *mis = migration_incoming_get_current();
> +    PostcopyState ps = postcopy_state_get();
>  
>      multifd_recv_cleanup();
>  
> +    if (mis->have_listen_thread) {
> +        qemu_thread_join(&mis->listen_thread);
> +        mis->have_listen_thread = false;
> +    }

Maybe this fits more to be in postcopy_ram_incoming_cleanup() below?

> +
> +    if (ps != POSTCOPY_INCOMING_NONE) {
> +        postcopy_ram_incoming_cleanup(mis);
> +    }
> +
>      /*
>       * RAM state cleanup needs to happen after multifd cleanup, because
>       * multifd threads can use some of its states (receivedmap).
> @@ -809,6 +819,23 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>      cpr_state_close();
>  }
>  
> +void migration_incoming_finish(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    migration_incoming_state_destroy();
> +
> +    if (migration_has_failed(mis->state) && mis->exit_on_error) {

If you agree on my comment in patch 2, we can keep checking against FAILED.

> +        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> +            error_report_err(s->error);
> +            s->error = NULL;
> +        }
> +
> +        exit(EXIT_FAILURE);
> +    }
> +}
> +
>  static void process_incoming_migration_bh(void *opaque)
>  {
>      MigrationIncomingState *mis = opaque;
> @@ -861,7 +888,7 @@ static void process_incoming_migration_bh(void *opaque)
>       */
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_COMPLETED);
> -    migration_incoming_state_destroy();
> +    migration_incoming_finish();

This is exactly the same as before when we know it's succeeding, but I
think I get your point, always using migration_incoming_finish() should be
fine.

>  }
>  
>  static void coroutine_fn
> @@ -888,23 +915,13 @@ process_incoming_migration_co(void *opaque)
>  
>      ps = postcopy_state_get();
>      trace_process_incoming_migration_co_end(ret, ps);
> -    if (ps != POSTCOPY_INCOMING_NONE) {
> -        if (ps == POSTCOPY_INCOMING_ADVISE) {
> -            /*
> -             * Where a migration had postcopy enabled (and thus went to advise)
> -             * but managed to complete within the precopy period, we can use
> -             * the normal exit.
> -             */
> -            postcopy_ram_incoming_cleanup(mis);
> -        } else if (ret >= 0) {
> -            /*
> -             * Postcopy was started, cleanup should happen at the end of the
> -             * postcopy thread.
> -             */
> -            trace_process_incoming_migration_co_postcopy_end_main();
> -            goto out;
> -        }
> -        /* Else if something went wrong then just fall out of the normal exit */
> +    if (ps >= POSTCOPY_INCOMING_LISTENING) {
> +        /*
> +         * Postcopy was started, cleanup should happen at the end of the
> +         * postcopy thread.

Postcopy has >1 threads, better mention "at the end of postcopy ram listen
thread", that helps explain why checking >= POSTCOPY_INCOMING_LISTENING,
because that event creates the ram listen thread.

> +         */
> +        trace_process_incoming_migration_co_postcopy_end_main();
> +        goto out;
>      }
>  
>      if (ret < 0) {
> @@ -926,16 +943,7 @@ fail:
>      migrate_set_error(s, local_err);
>      error_free(local_err);
>  
> -    migration_incoming_state_destroy();
> -
> -    if (mis->exit_on_error) {
> -        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> -            error_report_err(s->error);
> -            s->error = NULL;
> -        }
> -
> -        exit(EXIT_FAILURE);
> -    }
> +    migration_incoming_finish();
>  out:
>      /* Pairs with the refcount taken in qmp_migrate_incoming() */
>      migrate_incoming_unref_outgoing_state();
> diff --git a/migration/migration.h b/migration/migration.h
> index 2c2331f40d..67e3318467 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -518,6 +518,7 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>  void migration_fd_process_incoming(QEMUFile *f);
>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>  void migration_incoming_process(void);
> +void migration_incoming_finish(void);
>  
>  bool  migration_has_all_channels(void);
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fabbeb296a..d7eb416d48 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2069,6 +2069,11 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
>      return 0;
>  }
>  
> +static void postcopy_ram_listen_thread_bh(void *opaque)
> +{
> +    migration_incoming_finish();
> +}
> +
>  /*
>   * Triggered by a postcopy_listen command; this thread takes over reading
>   * the input stream, leaving the main thread free to carry on loading the rest
> @@ -2122,52 +2127,31 @@ static void *postcopy_ram_listen_thread(void *opaque)
>                           "bitmaps may be lost, and present migrated dirty "
>                           "bitmaps are correctly migrated and valid.",
>                           __func__, load_res);
> -            load_res = 0; /* prevent further exit() */
>          } else {
>              error_report("%s: loadvm failed: %d", __func__, load_res);
>              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>                                             MIGRATION_STATUS_FAILED);
> +            goto out;
>          }
>      }
> -    if (load_res >= 0) {
> -        /*
> -         * This looks good, but it's possible that the device loading in the
> -         * main thread hasn't finished yet, and so we might not be in 'RUN'
> -         * state yet; wait for the end of the main thread.
> -         */
> -        qemu_event_wait(&mis->main_thread_load_event);
> -    }
> -    postcopy_ram_incoming_cleanup(mis);
> -
> -    if (load_res < 0) {
> -        /*
> -         * If something went wrong then we have a bad state so exit;
> -         * depending how far we got it might be possible at this point
> -         * to leave the guest running and fire MCEs for pages that never
> -         * arrived as a desperate recovery step.
> -         */
> -        rcu_unregister_thread();
> -        exit(EXIT_FAILURE);
> -    }
> +    /*
> +     * This looks good, but it's possible that the device loading in the
> +     * main thread hasn't finished yet, and so we might not be in 'RUN'
> +     * state yet; wait for the end of the main thread.
> +     */
> +    qemu_event_wait(&mis->main_thread_load_event);
>  
>      migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>                                     MIGRATION_STATUS_COMPLETED);
> -    /*
> -     * If everything has worked fine, then the main thread has waited
> -     * for us to start, and we're the last use of the mis.
> -     * (If something broke then qemu will have to exit anyway since it's
> -     * got a bad migration state).
> -     */
> -    bql_lock();
> -    migration_incoming_state_destroy();
> -    bql_unlock();
>  
> +out:
>      rcu_unregister_thread();
> -    mis->have_listen_thread = false;
>      postcopy_state_set(POSTCOPY_INCOMING_END);
>  
>      object_unref(OBJECT(migr));
>  
> +    migration_bh_schedule(postcopy_ram_listen_thread_bh, NULL);
> +
>      return NULL;
>  }
>  
> @@ -2217,7 +2201,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>      mis->have_listen_thread = true;
>      postcopy_thread_create(mis, &mis->listen_thread,
>                             MIGRATION_THREAD_DST_LISTEN,
> -                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
> +                           postcopy_ram_listen_thread, QEMU_THREAD_JOINABLE);

Nit once more: better mention this change in commit message.

Thanks!

>      trace_loadvm_postcopy_handle_listen("return");
>  
>      return 0;
> -- 
> 2.51.0
> 

-- 
Peter Xu


