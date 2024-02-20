Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13229C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 07:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcKJ9-00024q-4J; Tue, 20 Feb 2024 02:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcKJ7-00023c-Pd
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:12:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcKJ5-0008WK-Uw
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708413166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=58lUXYm48EPcP9tAKX9PIdVB6lTzPS5wA6nq7la3S7s=;
 b=AAfr2NyvbqRH10PyG9Pn5lCflom8usUuK7xYl+2+Cyg4ZB7+T5Vh/cd+0EooFc8774TbwT
 qofhlS+bQ3B74I03Iwbqa+v2OAsZXYoIn9nqPDYXyXNlOOnQKWYnfebF579FTpxzi45EsF
 nPkQnfLCuHku/XksOCunnKxwT0GtEGE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-kGG4QWPeN3eaSNeznk_dRQ-1; Tue, 20 Feb 2024 02:12:44 -0500
X-MC-Unique: kGG4QWPeN3eaSNeznk_dRQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6da5a9defd5so2142830b3a.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 23:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708413163; x=1709017963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58lUXYm48EPcP9tAKX9PIdVB6lTzPS5wA6nq7la3S7s=;
 b=IWv4ZMfPUIK9488LTwa8PI/6+3sUZshaA+XQqCAwKF5RW8Z6A0jRSDkKDqXmA7J3V7
 fMYzccCFBkOe1cj6JhPYK3dhOajTS9mIFXCtjuOGgxwrXZ1YmFwZtyXHfTiPJNoZUi/1
 eL2SIbAxMR8uTKVGy7PZilYd/a1AbJrIlxCzgmiWxVNE2BbIEKS5lzDDV3B2Uf8fIO71
 xnMLDf2R5xLf2KzZ568eyZywDpNCXly5tO2ahre12jaFVBesCP/1ZP/6eHwM4SjrTWYE
 MeiwpK2iarM2Vopt9EQNV2ZG2ajz4kkbE+49yOvaJkK9dnBb1BLixKAT3TaN9ZWS0hZY
 qaig==
X-Gm-Message-State: AOJu0YwnqYb3xLblkZFc6jtSaFyVQBpQjeNgmgevYSLKUaZp7qFb7bcr
 rIq69E2bOXxGNqrIqbthE43CS8jbRDHwKcYxxDoDYlNJKVK/pYawhWwoKanyZbztHMj9FpHhTS1
 I3s3Wl17OKfcJzLisxvGK12+7pTyHU8nLC3ydxUxj0jfM+EFCjlVA
X-Received: by 2002:a05:6a21:a5a0:b0:1a0:88b9:fc09 with SMTP id
 gd32-20020a056a21a5a000b001a088b9fc09mr14737995pzc.6.1708413163439; 
 Mon, 19 Feb 2024 23:12:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbJwjVhHr01veWphMpuOfLnU1XuhlcPAQ7DUOQEbaDEJnQeJK74Da9YVWwyvehOr6V6L6zhw==
X-Received: by 2002:a05:6a21:a5a0:b0:1a0:88b9:fc09 with SMTP id
 gd32-20020a056a21a5a000b001a088b9fc09mr14737983pzc.6.1708413163110; 
 Mon, 19 Feb 2024 23:12:43 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 q2-20020a170902e30200b001db2d598eedsm5466252plc.77.2024.02.19.23.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 23:12:42 -0800 (PST)
Date: Tue, 20 Feb 2024 15:12:31 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3 09/13] migration: notifier error checking
Message-ID: <ZdRQ35ygQU4rUgnD@x1n>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-10-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1707418446-134863-10-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 08, 2024 at 10:54:02AM -0800, Steve Sistare wrote:
> Check the status returned by migration notifiers and report errors.
> If notifiers fail, call the notifiers again so they can clean up.
> None of the notifiers return an error status at this time.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/misc.h |  3 ++-
>  migration/migration.c    | 40 +++++++++++++++++++++++++++++-----------
>  2 files changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 0ea1902..6dc234b 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -82,7 +82,8 @@ void migration_add_notifier(NotifierWithReturn *notify,
>  void migration_add_notifier_mode(NotifierWithReturn *notify,
>                                   MigrationNotifyFunc func, MigMode mode);
>  void migration_remove_notifier(NotifierWithReturn *notify);
> -void migration_call_notifiers(MigrationState *s, MigrationEventType type);
> +int migration_call_notifiers(MigrationState *s, MigrationEventType type,
> +                             Error **errp);
>  bool migration_in_setup(MigrationState *);
>  bool migration_has_finished(MigrationState *);
>  bool migration_has_failed(MigrationState *);
> diff --git a/migration/migration.c b/migration/migration.c
> index 01d8867..d1fce9e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1318,6 +1318,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
>  
>  static void migrate_fd_cleanup(MigrationState *s)
>  {
> +    Error *local_err = NULL;
> +
>      g_free(s->hostname);
>      s->hostname = NULL;
>      json_writer_free(s->vmdesc);
> @@ -1362,13 +1364,23 @@ static void migrate_fd_cleanup(MigrationState *s)
>                            MIGRATION_STATUS_CANCELLED);
>      }
>  
> +    if (!migration_has_failed(s) &&
> +        migration_call_notifiers(s, MIG_EVENT_PRECOPY_DONE, &local_err)) {
> +
> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_error(s, local_err);
> +        error_free(local_err);
> +    }
> +
>      if (s->error) {
>          /* It is used on info migrate.  We can't free it */
>          error_report_err(error_copy(s->error));
>      }
> -    migration_call_notifiers(s, s->state == MIGRATION_STATUS_COMPLETED ?
> -                             MIG_EVENT_PRECOPY_DONE :
> -                             MIG_EVENT_PRECOPY_FAILED);
> +
> +    if (migration_has_failed(s)) {
> +        migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
> +    }

AFAIU, the whole point of such split is, allowing DONE notifies to fail too
and then if that happens we can invoke FAIL notifiers again.

Perhaps we can avoid that complexity, but rather document only SETUP
notifiers can fail?

The problem is that failing a notifier at this stage (if migration already
finished) can already be too late; dest QEMU can already have started
running, so no way to roll back.  We can document that, check and assert
for !SETUP cases to make sure error is never hit?

> +
>      block_cleanup_parameters();
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>  }
> @@ -1481,13 +1493,15 @@ void migration_remove_notifier(NotifierWithReturn *notify)
>      }
>  }
>  
> -void migration_call_notifiers(MigrationState *s, MigrationEventType type)
> +int migration_call_notifiers(MigrationState *s, MigrationEventType type,
> +                             Error **errp)
>  {
>      MigMode mode = s->parameters.mode;
>      MigrationEvent e;
>  
>      e.type = type;
> -    notifier_with_return_list_notify(&migration_state_notifiers[mode], &e, 0);
> +    return notifier_with_return_list_notify(&migration_state_notifiers[mode],
> +                                            &e, errp);
>  }
>  
>  bool migration_in_setup(MigrationState *s)
> @@ -2535,7 +2549,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>       * at the transition to postcopy and after the device state; in particular
>       * spice needs to trigger a transition now
>       */
> -    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE);
> +    if (migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE, errp)) {
> +        goto fail;
> +    }
>  
>      migration_downtime_end(ms);
>  
> @@ -2555,11 +2571,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>  
>      ret = qemu_file_get_error(ms->to_dst_file);
>      if (ret) {
> -        error_setg(errp, "postcopy_start: Migration stream errored");
> -        migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> -                              MIGRATION_STATUS_FAILED);
> +        error_setg_errno(errp, -ret, "postcopy_start: Migration stream error");
> +        bql_lock();
> +        goto fail;
>      }
> -
>      trace_postcopy_preempt_enabled(migrate_postcopy_preempt());
>  
>      return ret;
> @@ -2580,6 +2595,7 @@ fail:
>              error_report_err(local_err);
>          }
>      }
> +    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
>      bql_unlock();
>      return -1;
>  }
> @@ -3594,7 +3610,9 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>          rate_limit = migrate_max_bandwidth();
>  
>          /* Notify before starting migration thread */
> -        migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP);
> +        if (migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
> +            goto fail;
> +        }
>      }
>  
>      migration_rate_set(rate_limit);
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


