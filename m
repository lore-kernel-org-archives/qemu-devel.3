Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF8DCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 22:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEb8Y-0008Fv-Id; Thu, 30 Oct 2025 18:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEb8T-0008Fb-LM
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEb8H-000777-WB
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761863307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DjhorDCfxf8cr4lONoHwjqm1TagApvCLu5sQwLSomK4=;
 b=ghDQlQ5gwNu+fGTcI5MVZuZeg2FCZiaoTQYQLzf2WRDbUq2wrkspO1xzbuhskG4k6eefBs
 fgvjicTlpMc69J/DLITdpsF6H1aqllQ8bsrZnzm7oxVhuxmX7cDO8S/qZJbsWfTPUV9DMF
 Xgg4bY5tUfyzqFC1/gZ68j3M0QloQ1U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-DXCe--urMq-SyDGYlx9t0Q-1; Thu, 30 Oct 2025 18:28:26 -0400
X-MC-Unique: DXCe--urMq-SyDGYlx9t0Q-1
X-Mimecast-MFC-AGG-ID: DXCe--urMq-SyDGYlx9t0Q_1761863306
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ecfa212e61so78818701cf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 15:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761863305; x=1762468105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjhorDCfxf8cr4lONoHwjqm1TagApvCLu5sQwLSomK4=;
 b=dRIw6C/MTllTUUJt9XrE2CeAbrgWqpExCPOnnaCQj7slYJvZtp13l0lhqMEqabsew6
 A7iWe8poGxJ/s0JDSUMJ4RjFYfXiQaXbDM5UphEKy4vc0JxdBu2NMeWphQX6cj/tU/JG
 kemikoesgZlPO8hoVFzqMMYEwaFa8MGxl6K/RMjx7hVR1d7EReh0Gcucv5blxjvnw/63
 dYix5zIV4l11FYCnZjfbG3pssmBN9tJpa9OZeCO4wxlGeihLgYAVh95qVzRkGY/K/3+O
 C5Uddu5Q1mwhQlm1MnNGw5Qcmnl+iZ6gXq3J4oy3MH64mDvk+r+cQoCMU0YY9sBXT9WX
 3oMw==
X-Gm-Message-State: AOJu0YzFx3Iw/lcZpoklJ9YY0lCDm29Z7T4+yIQuOFMvEAUKrpxZpNl/
 Z80cH/swKNXV5z06EEqWG5F+H9G6mg4vDcHgXKuCLWVkrldyEddXjHk7QBCxD6IfDliXwmanf15
 xaGpu/FCIEvzgojLAtM4+VHSXj2nLKJzGYEoJ4JVioRA0oWKR3MaVN4R7
X-Gm-Gg: ASbGncvQ77fLhLdyIQV3MMF0KRQKkLNsMXJ6VK9aA2tlIj+El8gHTCysYZUTcZAeVf/
 VtxA9EFI6IHcKyK4bE8+Xmmfrt+Srd38SCsKkNiaB2UV2aPW0Ji2MttHaiUOs6x6BOPS0Lr0Pvi
 dWwP5vOisyc8rGHvNyjNDMZEKItlxYuDLzs2HY9No8duAbOm9fRhdyZZSzwWCV3tl6r3ajG7gEX
 BqruD6BdgaLiMuSrg6orwGWsFLHWhtk242E1tdKm9RnKdQv9w1FTz5p5dn8OFQ91WS/QtozSDhO
 xjYBXy2OpGd7A/tXAsfpuofZ7Gmlq33GwgcSkLU1nM4dRnmQreCb3iD1IW1pI6l1++g=
X-Received: by 2002:ac8:59c9:0:b0:4e8:8274:5efa with SMTP id
 d75a77b69052e-4ed217b684bmr64254211cf.8.1761863305437; 
 Thu, 30 Oct 2025 15:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXE/VBUtZlv151K1hyb8jzazrvi61E6w5fg4zQ05gmv2Jp3KZ5uHYgKBhcpv4GBpmQLEcRTQ==
X-Received: by 2002:ac8:59c9:0:b0:4e8:8274:5efa with SMTP id
 d75a77b69052e-4ed217b684bmr64253881cf.8.1761863304845; 
 Thu, 30 Oct 2025 15:28:24 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88036057857sm86306d6.20.2025.10.30.15.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 15:28:23 -0700 (PDT)
Date: Thu, 30 Oct 2025 18:28:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 2/7] migration: Move postcopy_ram_listen_thread() to
 postcopy-ram.c
Message-ID: <aQPmgOmUmWjwR4-A@x1.local>
References: <20251030214915.1411860-1-jmarcin@redhat.com>
 <20251030214915.1411860-3-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030214915.1411860-3-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Oct 30, 2025 at 10:49:06PM +0100, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> This patch addresses a TODO about moving postcopy_ram_listen_thread() to
> postcopy file.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/postcopy-ram.c | 107 +++++++++++++++++++++++++++++++++++++++
>  migration/postcopy-ram.h |   2 +
>  migration/savevm.c       | 107 ---------------------------------------
>  3 files changed, 109 insertions(+), 107 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 5471efb4f0..36d5415554 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -2077,3 +2077,110 @@ bool postcopy_is_paused(MigrationStatus status)
>      return status == MIGRATION_STATUS_POSTCOPY_PAUSED ||
>          status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
>  }
> +
> +/*
> + * Triggered by a postcopy_listen command; this thread takes over reading
> + * the input stream, leaving the main thread free to carry on loading the rest
> + * of the device state (from RAM).
> + * (TODO:This could do with being in a postcopy file - but there again it's
> + * just another input loop, not that postcopy specific)

I suppose touching the comment while moving (as long as explicitly
mentioned in the commit message) would be fine, when the comment is exactly
about "we should move it". :)  Not a big deal, thanks for the split.

Reviewed-by: Peter Xu <peterx@redhat.com>

> + */
> +void *postcopy_ram_listen_thread(void *opaque)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    QEMUFile *f = mis->from_src_file;
> +    int load_res;
> +    MigrationState *migr = migrate_get_current();
> +    Error *local_err = NULL;
> +
> +    object_ref(OBJECT(migr));
> +
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> +                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +    qemu_event_set(&mis->thread_sync_event);
> +    trace_postcopy_ram_listen_thread_start();
> +
> +    rcu_register_thread();
> +    /*
> +     * Because we're a thread and not a coroutine we can't yield
> +     * in qemu_file, and thus we must be blocking now.
> +     */
> +    qemu_file_set_blocking(f, true, &error_fatal);
> +
> +    /* TODO: sanity check that only postcopiable data will be loaded here */
> +    load_res = qemu_loadvm_state_main(f, mis, &local_err);
> +
> +    /*
> +     * This is tricky, but, mis->from_src_file can change after it
> +     * returns, when postcopy recovery happened. In the future, we may
> +     * want a wrapper for the QEMUFile handle.
> +     */
> +    f = mis->from_src_file;
> +
> +    /* And non-blocking again so we don't block in any cleanup */
> +    qemu_file_set_blocking(f, false, &error_fatal);
> +
> +    trace_postcopy_ram_listen_thread_exit();
> +    if (load_res < 0) {
> +        qemu_file_set_error(f, load_res);
> +        dirty_bitmap_mig_cancel_incoming();
> +        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
> +            !migrate_postcopy_ram() && migrate_dirty_bitmaps())
> +        {
> +            error_report("%s: loadvm failed during postcopy: %d: %s. All states "
> +                         "are migrated except dirty bitmaps. Some dirty "
> +                         "bitmaps may be lost, and present migrated dirty "
> +                         "bitmaps are correctly migrated and valid.",
> +                         __func__, load_res, error_get_pretty(local_err));
> +            g_clear_pointer(&local_err, error_free);
> +            load_res = 0; /* prevent further exit() */
> +        } else {
> +            error_prepend(&local_err,
> +                          "loadvm failed during postcopy: %d: ", load_res);
> +            migrate_set_error(migr, local_err);
> +            g_clear_pointer(&local_err, error_report_err);
> +            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> +                                           MIGRATION_STATUS_FAILED);
> +        }
> +    }
> +    if (load_res >= 0) {
> +        /*
> +         * This looks good, but it's possible that the device loading in the
> +         * main thread hasn't finished yet, and so we might not be in 'RUN'
> +         * state yet; wait for the end of the main thread.
> +         */
> +        qemu_event_wait(&mis->main_thread_load_event);
> +    }
> +    postcopy_ram_incoming_cleanup(mis);
> +
> +    if (load_res < 0) {
> +        /*
> +         * If something went wrong then we have a bad state so exit;
> +         * depending how far we got it might be possible at this point
> +         * to leave the guest running and fire MCEs for pages that never
> +         * arrived as a desperate recovery step.
> +         */
> +        rcu_unregister_thread();
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> +                                   MIGRATION_STATUS_COMPLETED);
> +    /*
> +     * If everything has worked fine, then the main thread has waited
> +     * for us to start, and we're the last use of the mis.
> +     * (If something broke then qemu will have to exit anyway since it's
> +     * got a bad migration state).
> +     */
> +    bql_lock();
> +    migration_incoming_state_destroy();
> +    bql_unlock();
> +
> +    rcu_unregister_thread();
> +    mis->have_listen_thread = false;
> +    postcopy_state_set(POSTCOPY_INCOMING_END);
> +
> +    object_unref(OBJECT(migr));
> +
> +    return NULL;
> +}
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index ca19433b24..3e26db3e6b 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -199,4 +199,6 @@ bool postcopy_is_paused(MigrationStatus status);
>  void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
>                                     RAMBlock *rb);
>  
> +void *postcopy_ram_listen_thread(void *opaque);
> +
>  #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 232cae090b..97fdd08c08 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2087,113 +2087,6 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
>      return 0;
>  }
>  
> -/*
> - * Triggered by a postcopy_listen command; this thread takes over reading
> - * the input stream, leaving the main thread free to carry on loading the rest
> - * of the device state (from RAM).
> - * (TODO:This could do with being in a postcopy file - but there again it's
> - * just another input loop, not that postcopy specific)
> - */
> -static void *postcopy_ram_listen_thread(void *opaque)
> -{
> -    MigrationIncomingState *mis = migration_incoming_get_current();
> -    QEMUFile *f = mis->from_src_file;
> -    int load_res;
> -    MigrationState *migr = migrate_get_current();
> -    Error *local_err = NULL;
> -
> -    object_ref(OBJECT(migr));
> -
> -    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> -                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
> -    qemu_event_set(&mis->thread_sync_event);
> -    trace_postcopy_ram_listen_thread_start();
> -
> -    rcu_register_thread();
> -    /*
> -     * Because we're a thread and not a coroutine we can't yield
> -     * in qemu_file, and thus we must be blocking now.
> -     */
> -    qemu_file_set_blocking(f, true, &error_fatal);
> -
> -    /* TODO: sanity check that only postcopiable data will be loaded here */
> -    load_res = qemu_loadvm_state_main(f, mis, &local_err);
> -
> -    /*
> -     * This is tricky, but, mis->from_src_file can change after it
> -     * returns, when postcopy recovery happened. In the future, we may
> -     * want a wrapper for the QEMUFile handle.
> -     */
> -    f = mis->from_src_file;
> -
> -    /* And non-blocking again so we don't block in any cleanup */
> -    qemu_file_set_blocking(f, false, &error_fatal);
> -
> -    trace_postcopy_ram_listen_thread_exit();
> -    if (load_res < 0) {
> -        qemu_file_set_error(f, load_res);
> -        dirty_bitmap_mig_cancel_incoming();
> -        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
> -            !migrate_postcopy_ram() && migrate_dirty_bitmaps())
> -        {
> -            error_report("%s: loadvm failed during postcopy: %d: %s. All states "
> -                         "are migrated except dirty bitmaps. Some dirty "
> -                         "bitmaps may be lost, and present migrated dirty "
> -                         "bitmaps are correctly migrated and valid.",
> -                         __func__, load_res, error_get_pretty(local_err));
> -            g_clear_pointer(&local_err, error_free);
> -            load_res = 0; /* prevent further exit() */
> -        } else {
> -            error_prepend(&local_err,
> -                          "loadvm failed during postcopy: %d: ", load_res);
> -            migrate_set_error(migr, local_err);
> -            g_clear_pointer(&local_err, error_report_err);
> -            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> -                                           MIGRATION_STATUS_FAILED);
> -        }
> -    }
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
> -
> -    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> -                                   MIGRATION_STATUS_COMPLETED);
> -    /*
> -     * If everything has worked fine, then the main thread has waited
> -     * for us to start, and we're the last use of the mis.
> -     * (If something broke then qemu will have to exit anyway since it's
> -     * got a bad migration state).
> -     */
> -    bql_lock();
> -    migration_incoming_state_destroy();
> -    bql_unlock();
> -
> -    rcu_unregister_thread();
> -    mis->have_listen_thread = false;
> -    postcopy_state_set(POSTCOPY_INCOMING_END);
> -
> -    object_unref(OBJECT(migr));
> -
> -    return NULL;
> -}
> -
>  /* After this message we must be able to immediately receive postcopy data */
>  static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis,
>                                           Error **errp)
> -- 
> 2.51.0
> 

-- 
Peter Xu


