Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E7CC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1WtG-0002Nl-Tj; Mon, 29 Apr 2024 15:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1WtA-0002L1-Lg
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1Wt4-0001oa-QZ
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714419726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wehjUULve/QAehqfdKDFwLo0dvVL/f7GiF9qurvyp3I=;
 b=ST7glTs0AmKa7+5Bqxr3Oz644RBya/jjR6fn5/1PzJ/W9wMp70Gin/jgLHaOlqM4RSWbPQ
 LzpwYSEzpf4eJeOjI2y00IehOzkW/RDWFGazSRV0AkhDqKvflT4x8+mQNPDUqwkUUZmCor
 rgSIdYhLEXIpl7d9cauDska/Lgpl20E=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-LvkUCiGcPoCGqmvG-Tq2aw-1; Mon, 29 Apr 2024 15:42:03 -0400
X-MC-Unique: LvkUCiGcPoCGqmvG-Tq2aw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ab48d18751so1779248a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714419722; x=1715024522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wehjUULve/QAehqfdKDFwLo0dvVL/f7GiF9qurvyp3I=;
 b=UPPw1cNRIRL1bQCPKKcP7VBBxIW/6hW8gvG6PY03+VxyHl6b9x7RuAeLTU3WIgUaNR
 BYOxiqWz6Y+eyiuiyS+X00MsXk0sTriMs89SyAfXpUfcq1N+UQGN7IMOajyUDuywQI7V
 uKJCO0yYZVbqQSNDB8y7aYhwzISM51gQ4hL+9KumLcZQLx8cbmxkjnREM0+CdNUgdjik
 kknPEzdAiEvVppibMLFc9MsIUKUiPcgrY96DzqTWl1uknjkF5cWEhT2qPn2j2wQsvJmI
 MWsPSiaU+ays1mTcjZXXeXDFcP9HCavYk/QYfXFQHTiMjOf0N8QaIzjIkED1b48fvY9X
 W11g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm8VWIJu2ZACnVvxK0/GvUUN0ghD+2Tl2wgosVdZ0+6yAV4Gp4fDWIRnOZRa5bd2ono8E9KrY2ZxXw6iw1PBJwvlQlBR8=
X-Gm-Message-State: AOJu0YwUSzM47iHuKrgH9H6oM1MTTvViDBAX0Iw4Zh70RDVVXgs0qq4J
 7j9BDwFPZYosMqEHFzW5k8l70VJfbD2ltumpJI2w13Se+uF6PYhOVf90WmjwweMx4w98qaWKwoX
 N/qhPvNFk23JrGaKxlj9C+ly+YSeFRIIFkyKnXj/cElHjywhERvji9eyTU2Ox
X-Received: by 2002:a05:6a20:6a24:b0:1ac:fd1c:44ed with SMTP id
 p36-20020a056a206a2400b001acfd1c44edmr16724693pzk.1.1714419722107; 
 Mon, 29 Apr 2024 12:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2sM/cB33Ge2MfgEfVagRnGa0L/6HtPxrNb8lrqtJXGPCRTEnrKSVhOv4nl3W9n7/GuBZusA==
X-Received: by 2002:a05:6a20:6a24:b0:1ac:fd1c:44ed with SMTP id
 p36-20020a056a206a2400b001acfd1c44edmr16724644pzk.1.1714419721237; 
 Mon, 29 Apr 2024 12:42:01 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 m19-20020aa78a13000000b006e697bd5285sm19598063pfa.203.2024.04.29.12.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 12:42:00 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:41:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Subject: Re: [PATCH v5 5/5] qapi: introduce exit-on-error parameter for
 migrate-incoming
Message-ID: <Zi_4BVJcbNfVqlsk@x1n>
References: <20240429191426.2327225-1-vsementsov@yandex-team.ru>
 <20240429191426.2327225-6-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429191426.2327225-6-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Mon, Apr 29, 2024 at 10:14:26PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Now we do set MIGRATION_FAILED state, but don't give a chance to
> orchestrator to query migration state and get the error.
> 
> Let's provide a possibility for QMP-based orchestrators to get an error
> like with outgoing migration.
> 
> For hmp_migrate_incoming(), let's enable the new behavior: HMP is not
> and ABI, it's mostly intended to use by developer and it makes sense
> not to stop the process.
> 
> For x-exit-preconfig, let's keep the old behavior:
>  - it's called from init(), so here we want to keep current behavior by
>    default
>  - it does exit on error by itself as well
> So, if we want to change the behavior of x-exit-preconfig, it should be
> another patch.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/migration-hmp-cmds.c |  2 +-
>  migration/migration.c          | 38 +++++++++++++++++++++++++++-------
>  migration/migration.h          |  3 +++
>  qapi/migration.json            |  7 ++++++-
>  system/vl.c                    |  3 ++-
>  5 files changed, 43 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 7e96ae6ffd..23181bbee1 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -466,7 +466,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>      }
>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>  
> -    qmp_migrate_incoming(NULL, true, caps, &err);
> +    qmp_migrate_incoming(NULL, true, caps, true, false, &err);
>      qapi_free_MigrationChannelList(caps);
>  
>  end:
> diff --git a/migration/migration.c b/migration/migration.c
> index 5489ff96df..09f762c99e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -72,6 +72,8 @@
>  #define NOTIFIER_ELEM_INIT(array, elem)    \
>      [elem] = NOTIFIER_WITH_RETURN_LIST_INITIALIZER((array)[elem])
>  
> +#define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
> +
>  static NotifierWithReturnList migration_state_notifiers[] = {
>      NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
>      NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
> @@ -234,6 +236,8 @@ void migration_object_init(void)
>      qemu_cond_init(&current_incoming->page_request_cond);
>      current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
>  
> +    current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
> +
>      migration_object_check(current_migration, &error_fatal);
>  
>      blk_mig_init();
> @@ -806,14 +810,19 @@ fail:
>                        MIGRATION_STATUS_FAILED);
>      migration_incoming_state_destroy();
>  
> -    if (migrate_has_error(s)) {
> -        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> -            error_report_err(error_copy(s->error));
> +    if (mis->exit_on_error) {
> +        if (migrate_has_error(s)) {
> +            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> +                error_report_err(error_copy(s->error));
> +            }
>          }
> +        error_report_err(local_err);
> +        migrate_error_free(s);
> +        exit(EXIT_FAILURE);
> +    } else {
> +        migrate_set_error(s, local_err);
> +        error_free(local_err);
>      }
> -    error_report_err(local_err);
> -    migrate_error_free(s);
> -    exit(EXIT_FAILURE);
>  }

(Please see my reply in previous patch)

>  
>  /**
> @@ -1322,6 +1331,15 @@ static void fill_destination_migration_info(MigrationInfo *info)
>          break;
>      }
>      info->status = mis->state;
> +
> +    if (!info->error_desc) {

This will also guarantee to happen?  Can drop the check too if so.

Other than that looks good, thanks.

> +        MigrationState *s = migrate_get_current();
> +        QEMU_LOCK_GUARD(&s->error_mutex);
> +
> +        if (s->error) {
> +            info->error_desc = g_strdup(error_get_pretty(s->error));
> +        }
> +    }
>  }
>  
>  MigrationInfo *qmp_query_migrate(Error **errp)
> @@ -1796,10 +1814,13 @@ void migrate_del_blocker(Error **reasonp)
>  }
>  
>  void qmp_migrate_incoming(const char *uri, bool has_channels,
> -                          MigrationChannelList *channels, Error **errp)
> +                          MigrationChannelList *channels,
> +                          bool has_exit_on_error, bool exit_on_error,
> +                          Error **errp)
>  {
>      Error *local_err = NULL;
>      static bool once = true;
> +    MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      if (!once) {
>          error_setg(errp, "The incoming migration has already been started");
> @@ -1814,6 +1835,9 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
>          return;
>      }
>  
> +    mis->exit_on_error =
> +        has_exit_on_error ? exit_on_error : INMIGRATE_DEFAULT_EXIT_ON_ERROR;
> +
>      qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
>  
>      if (local_err) {
> diff --git a/migration/migration.h b/migration/migration.h
> index 8045e39c26..95995a818e 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -227,6 +227,9 @@ struct MigrationIncomingState {
>       * is needed as this field is updated serially.
>       */
>      unsigned int switchover_ack_pending_num;
> +
> +    /* Do exit on incoming migration failure */
> +    bool exit_on_error;
>  };
>  
>  MigrationIncomingState *migration_incoming_get_current(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8c65b90328..9feed413b5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1837,6 +1837,10 @@
>  # @channels: list of migration stream channels with each stream in the
>  #     list connected to a destination interface endpoint.
>  #
> +# @exit-on-error: Exit on incoming migration failure.  Default true.
> +#     When set to false, the failure triggers a MIGRATION event, and
> +#     error details could be retrieved with query-migrate.  (since 9.1)
> +#
>  # Since: 2.3
>  #
>  # Notes:
> @@ -1889,7 +1893,8 @@
>  ##
>  { 'command': 'migrate-incoming',
>               'data': {'*uri': 'str',
> -                      '*channels': [ 'MigrationChannel' ] } }
> +                      '*channels': [ 'MigrationChannel' ],
> +                      '*exit-on-error': 'bool' } }
>  
>  ##
>  # @xen-save-devices-state:
> diff --git a/system/vl.c b/system/vl.c
> index 7756eac81e..79cd498395 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2723,7 +2723,8 @@ void qmp_x_exit_preconfig(Error **errp)
>      if (incoming) {
>          Error *local_err = NULL;
>          if (strcmp(incoming, "defer") != 0) {
> -            qmp_migrate_incoming(incoming, false, NULL, &local_err);
> +            qmp_migrate_incoming(incoming, false, NULL, true, true,
> +                                 &local_err);
>              if (local_err) {
>                  error_reportf_err(local_err, "-incoming %s: ", incoming);
>                  exit(1);
> -- 
> 2.34.1
> 

-- 
Peter Xu


