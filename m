Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3B6C19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzkh4-0000xM-4g; Wed, 24 Apr 2024 18:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzkgz-0000wv-L0
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzkgx-00052C-Ht
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713996133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jvx9mGMhuwcVrxQiS+4jIdtOkBusCIO3Cy3McHIN32M=;
 b=Ku/o89OiXgVMUlybk9wrFZ201R/IcWKuETsdq9nPEXXjStD+GKOHrglsXWnp+FDFUEZbX7
 xdwcJ+9haz5wuyr+Ibi5VF3ix2P6r1EievH/usXDTCdzATPrOIzuGIhW/ES7mbSGb30ZRK
 /dSuSnFqWIwO9OC8rH7tJupUPbGkhms=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-3pjoEEhJOxK_rWMKlmVqHg-1; Wed, 24 Apr 2024 18:02:12 -0400
X-MC-Unique: 3pjoEEhJOxK_rWMKlmVqHg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-69b37bbded3so1286356d6.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713996131; x=1714600931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvx9mGMhuwcVrxQiS+4jIdtOkBusCIO3Cy3McHIN32M=;
 b=oE57XDgbwRAouFVu6d6+9wpDXK8ctgeKZX/1/ji5vS3Arne2xCID6zF7UPN7Vm7Zxx
 Ozwul8+5xetiDDDvRC/DKgHZ2iPIlkay0qwIkD9qAJTmAuoMmC6yOoUMiaYHottcN0uv
 bnhrJX95/sowG/vNX55bGBpDrZkqOSXHl227scFGgGxSee0f6b8x0+Lp42ErN4BalB1E
 cSeqe3NNgsHdYCSQjjF0qkVIgqyZNM62+ZPB0ZDLYIAIDwwvTlmZXhmQGv/YMdQjwGes
 46YmUA9ndkB/s+ukypoklYVwYmEf+vqaHs+Sbo8XYr8yX1aNQHyJ/X2cZsQG2v5sEATW
 VGlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA/CptKMb9zEHD0nCCCgpa9AOPgSAlngfI/NLoqYzkm3oEYLlWUXTwKOa3V5X9jibKrwOckY8RSOJW4ZHmlqGGUOOH3R0=
X-Gm-Message-State: AOJu0YyMlQuR9ALqszVQGFEBS/rgmB3cD1nrQctXH0JuE29ueU7yVvT0
 18jBuFAKcEZx2kBUtJDr9wIasEOuFR2r4noT4tOaa+iXv01AYHzzUNvuwqdojCu2oedaWscam3X
 KpsszGqVDMpixJU2FJBnSMfsj8NUCF5aF6owEslaw0UNbBe+1pRQZ
X-Received: by 2002:a05:620a:199e:b0:790:97d2:17fc with SMTP id
 bm30-20020a05620a199e00b0079097d217fcmr1071888qkb.1.1713996130918; 
 Wed, 24 Apr 2024 15:02:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGChiGgazTlgG6Hx4ZcPv7YcFq/drNNAvYAEZoUIWHyJiStaO6c1I3QtR8zc5PtA+pEn0qSFg==
X-Received: by 2002:a05:620a:199e:b0:790:97d2:17fc with SMTP id
 bm30-20020a05620a199e00b0079097d217fcmr1071844qkb.1.1713996130306; 
 Wed, 24 Apr 2024 15:02:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 v8-20020ae9e308000000b0079065de3c96sm4306942qkf.81.2024.04.24.15.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:02:09 -0700 (PDT)
Date: Wed, 24 Apr 2024 18:02:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Subject: Re: [PATCH v2 2/2] qapi: introduce exit-on-error paramter for
 migrate-incoming
Message-ID: <ZimBX169nCf4Nn3X@x1n>
References: <20240424174245.1237942-1-vsementsov@yandex-team.ru>
 <20240424174245.1237942-3-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424174245.1237942-3-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
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

On Wed, Apr 24, 2024 at 08:42:45PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Now we do set MIGRATION_FAILED state, but don't give a chance to
> orchestrator to query migration state and get the error.
> 
> Let's provide a possibility for QMP-based orchestrators to get an error
> like with outgoing migration.
> 
> For x-exit-preconfig we can enable new behavior unconditionally, as
> it's an unstable command.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/migration-hmp-cmds.c |  2 +-
>  migration/migration.c          | 31 +++++++++++++++++++++----------
>  migration/migration.h          |  3 +++
>  qapi/migration.json            |  7 ++++++-
>  system/vl.c                    |  7 +------
>  5 files changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 7e96ae6ffd..9c94a18029 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -466,7 +466,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>      }
>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>  
> -    qmp_migrate_incoming(NULL, true, caps, &err);
> +    qmp_migrate_incoming(NULL, true, caps, true, true, &err);

Hmm, to me HMP implies more on "this is a developer, and he/she can be
debugging stuff", in that case I'm thinking whether this would be a good
chance to let exit=false already?  So that developers can keep the qemu
instances when error occurs.

IOW, I'd think it's fine to break HMP as that's not an ABI, so we choose
whatever makes sense to us.

>      qapi_free_MigrationChannelList(caps);
>  
>  end:
> diff --git a/migration/migration.c b/migration/migration.c
> index 806b7b080b..fe72529ba7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -234,6 +234,8 @@ void migration_object_init(void)
>      qemu_cond_init(&current_incoming->page_request_cond);
>      current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
>  
> +    current_incoming->exit_on_error = true;

Let's define a macro for the default value?  Then we can use it below too [1].

> +
>      migration_object_check(current_migration, &error_fatal);
>  
>      blk_mig_init();
> @@ -597,12 +599,15 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>  
>  static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>                                            MigrationChannelList *channels,
> +                                          bool exit_on_error,
>                                            Error **errp)
>  {
>      g_autoptr(MigrationChannel) channel = NULL;
>      MigrationAddress *addr = NULL;
>      MigrationIncomingState *mis = migration_incoming_get_current();
>  
> +    mis->exit_on_error = exit_on_error;

Maybe it's better to set this in qmp_migrate_incoming() directly?  As then
we guarantee qmp_migrate_recover() won't ever try to touch it.

> +
>      /*
>       * Having preliminary checks for uri and channel
>       */
> @@ -738,11 +743,12 @@ process_incoming_migration_co(void *opaque)
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      PostcopyState ps;
>      int ret;
> +    Error *local_err = NULL;
>  
>      assert(mis->from_src_file);
>  
>      if (compress_threads_load_setup(mis->from_src_file)) {
> -        error_report("Failed to setup decompress threads");
> +        error_setg(&local_err, "Failed to setup decompress threads");
>          goto fail;
>      }
>  
> @@ -779,25 +785,26 @@ process_incoming_migration_co(void *opaque)
>      }
>  
>      if (ret < 0) {
> -        error_report("load of migration failed: %s", strerror(-ret));
> +        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
>          goto fail;
>      }
>  
>      if (colo_incoming_co() < 0) {
> +        error_setg(&local_err, "colo incoming failed");
>          goto fail;
>      }
>  
>      migration_bh_schedule(process_incoming_migration_bh, mis);
>      return;
>  fail:
> +    migrate_report_err(local_err);
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_FAILED);
> -    qemu_fclose(mis->from_src_file);
> -
> -    multifd_recv_cleanup();
> -    compress_threads_load_cleanup();
> +    migration_incoming_state_destroy();

IMHO it'll be good to split such change into another patch.

>  
> -    exit(EXIT_FAILURE);
> +    if (mis->exit_on_error) {
> +        exit(EXIT_FAILURE);
> +    }

Instead of migrate_report_err(), I'd error_report() here.

if (exit_on_error) {
    // error_report...
    exit();
}

And perhaps dump nothing if don't exit?  Then the user/developer can check
using info/query migrate.

>  }
>  
>  /**
> @@ -1785,7 +1792,9 @@ void migrate_del_blocker(Error **reasonp)
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
> @@ -1803,7 +1812,9 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
>          return;
>      }
>  
> -    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
> +    qemu_start_incoming_migration(uri, has_channels, channels,
> +                                  has_exit_on_error ? exit_on_error : true,

[1]

> +                                  &local_err);
>  
>      if (local_err) {
>          yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> @@ -1839,7 +1850,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
>       * only re-setup the migration stream and poke existing migration
>       * to continue using that newly established channel.
>       */
> -    qemu_start_incoming_migration(uri, false, NULL, errp);
> +    qemu_start_incoming_migration(uri, false, NULL, mis->exit_on_error, errp);

(if we set it in qmp_migrate_incoming, we shouldn't need this change)

Thanks,

>  }
>  
>  void qmp_migrate_pause(Error **errp)
> diff --git a/migration/migration.h b/migration/migration.h
> index f9f436c33e..089f710ee1 100644
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
> index 8c65b90328..9de8b98d0b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1837,6 +1837,10 @@
>  # @channels: list of migration stream channels with each stream in the
>  #     list connected to a destination interface endpoint.
>  #
> +# @exit-on-error: Do exit on incoming migration failure.  Default true.
> +#     When set to false, the error is reported by MIGRATION event and
> +#     error could be retrieved by query-migrate command.  (since 9.1)
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
> index c644222982..f5b4c18200 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2718,13 +2718,8 @@ void qmp_x_exit_preconfig(Error **errp)
>      }
>  
>      if (incoming) {
> -        Error *local_err = NULL;
>          if (strcmp(incoming, "defer") != 0) {
> -            qmp_migrate_incoming(incoming, false, NULL, &local_err);
> -            if (local_err) {
> -                error_reportf_err(local_err, "-incoming %s: ", incoming);
> -                exit(1);
> -            }
> +            qmp_migrate_incoming(incoming, false, NULL, true, true, errp);
>          }
>      } else if (autostart) {
>          qmp_cont(NULL);
> -- 
> 2.34.1
> 

-- 
Peter Xu


