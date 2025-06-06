Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D23C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 19:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNckV-0005Nv-4m; Fri, 06 Jun 2025 15:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNckT-0005Nf-6L
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNckQ-0005RC-Jo
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749238140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b9N7eG2oR301wezo8bMBBYMrnBDxVs7Im563sgr8UQA=;
 b=bYlGDmgCn/PqCEuED2JDwjrpab/gUMO9fUSCI8OpjBIdZIUNVZQGE5A72CLU6Ektd1fYpu
 c04+ulRj6wIDKRV/fWSVGF//4+t+BAVC75AzIa3fpTYkM9yqcSITXhL08pZGcIckXvhl/7
 CMqh3aWO7esLgUkox5kr3M/U7fs4ymU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-OqpW7I_nNcyksJZJSIj8ww-1; Fri, 06 Jun 2025 15:28:57 -0400
X-MC-Unique: OqpW7I_nNcyksJZJSIj8ww-1
X-Mimecast-MFC-AGG-ID: OqpW7I_nNcyksJZJSIj8ww_1749238137
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fae67a352bso35518346d6.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 12:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749238136; x=1749842936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9N7eG2oR301wezo8bMBBYMrnBDxVs7Im563sgr8UQA=;
 b=UrM0WMqaRceOwmp8nACYp3JpmPFO2qeA4RRcKumSFfKLyep5poY5uQ+pmHsTPH864t
 GG2p5Rq63ct7rhzKgasQVDuSEQK7rRAy98SSyGNRPDp4VeSU5jjIGqDBFEQ23Ftl6Thz
 IAtyDeUeZuWTE7maeYQ1B0Dw1HMVYqTAxNqUhg5+f3HGuyLwf00zovCHY3ODtAhW/+FY
 wPI8mTpgIKSM5b5jQJ6ea65uSs9NiGBP+rkjXm1R4a+Qk+rqvOY/1Q2SXDqH6dKeD/0w
 jMA7XPxW7Qh/mbaxKJWx9ONpHepeEPdpTJONc16QvuXpW4g1znVkZOQ76AbB4MonTbpb
 rn0g==
X-Gm-Message-State: AOJu0Yym9RQzEIpHahiSoXSAcbr1L0MWkaJj9vbErd0qwBVJnwHwoQnO
 33TFALOPBwHslC0NvTKvvbxXnwWlkqYdvNPgg99vOZtWN2s8KUl3inDuFOP/2LcrAiO7Io2K+s/
 4E1diGnjquCBeuhwZxNNBwBfeJRFM75FPKoW1PDqkhqCaxnzgOByUdS8z
X-Gm-Gg: ASbGncvtF3QZiVdy54FBzxY+bCFZ/WzR2/h6ZbIF0LQ1ERF1kABOyF7E603tOYp1C1Q
 gGq3mEj2YUVdEVR0uzzq6kediVeUrdhD7tXHaZ8vFXbp11FqxOtpKYNPUxqsykA3jybrIAZXGEt
 mmp6nnI+JM0wMQCnADSw5PKkS4lwSDFCKklx4mpeEOuxHOfTGzgjjArA8NtpTkA+r6+HQAbtxVH
 fDtnW7tC6D+EmiUp53GPed0yeCCBAcaBZbtlqBxhKRVRj7sS2RI6oZKw3xG1deve8pyBOVhhPLd
 mx6Zj8YUh6IzNQ==
X-Received: by 2002:ad4:5ba4:0:b0:6fa:cd35:3da6 with SMTP id
 6a1803df08f44-6fb08f8e578mr67642486d6.41.1749238136574; 
 Fri, 06 Jun 2025 12:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWurApIhbygeFeHtZi9u2iROd+ld5CzllefEPFY1pj9S5m5pCG69ebgZFDkl+gRdkEjtx9mA==
X-Received: by 2002:ad4:5ba4:0:b0:6fa:cd35:3da6 with SMTP id
 6a1803df08f44-6fb08f8e578mr67642246d6.41.1749238136181; 
 Fri, 06 Jun 2025 12:28:56 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1d1d0sm15855786d6.77.2025.06.06.12.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 12:28:55 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:28:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aENBda_y3v3y4ptS@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-20-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Mon, Jun 02, 2025 at 10:38:08PM -0300, Fabiano Rosas wrote:
> Allow the migrate and migrate_incoming commands to pass the migration
> configuration options all at once, dispensing the use of
> migrate-set-parameters and migrate-set-capabilities.
> 
> The motivation of this is to simplify the interface with the
> management layer and avoid the usage of several command invocations to
> configure a migration. It also avoids stale parameters from a previous
> migration to influence the current migration.
> 
> The options that are changed during the migration can still be set
> with the existing commands.
> 
> The order of precedence is:
> 
> 'config' argument > -global cmdline > defaults (migration_properties)

Could we still keep the QMP migrate-set-parameters values?

  'config' argument > QMP setups using migrate-set-parameters >
    -global cmdline > defaults (migration_properties)

I asked this before, maybe I forgot the answer..

> 
> I.e. the config takes precedence over all, values not present in the
> config assume the default values. The (debug) -global command line
> option allows the defaults to be overridden.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration-hmp-cmds.c |  5 +++--
>  migration/migration.c          | 29 ++++++++++++++++++++++++++---
>  migration/migration.h          |  1 +
>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>  migration/options.h            |  3 +++
>  qapi/migration.json            | 25 +++++++++++++++++++++++--
>  system/vl.c                    |  3 ++-
>  7 files changed, 88 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index a8c3515e9d..38b289e8d8 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -575,7 +575,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>      }
>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>  
> -    qmp_migrate_incoming(NULL, true, caps, true, false, &err);
> +    qmp_migrate_incoming(NULL, true, caps, NULL, true, false, &err);
>      qapi_free_MigrationChannelList(caps);
>  
>  end:
> @@ -952,7 +952,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      }
>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>  
> -    qmp_migrate(NULL, true, caps, false, false, true, resume, &err);
> +    qmp_migrate(NULL, true, caps, NULL, false, false, true, resume,
> +                &err);
>      if (hmp_handle_error(mon, err)) {
>          return;
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index 75c4ec9a95..7b450b8836 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -335,6 +335,7 @@ void migration_object_init(void)
>      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
>  
>      migration_object_check(current_migration, &error_fatal);
> +    migrate_params_store_defaults(current_migration);
>  
>      ram_mig_init();
>      dirty_bitmap_mig_init();
> @@ -1916,13 +1917,24 @@ void migrate_del_blocker(Error **reasonp)
>  
>  void qmp_migrate_incoming(const char *uri, bool has_channels,
>                            MigrationChannelList *channels,
> -                          bool has_exit_on_error, bool exit_on_error,
> -                          Error **errp)
> +                          MigrationParameters *config, bool has_exit_on_error,
> +                          bool exit_on_error, Error **errp)
>  {
>      Error *local_err = NULL;
>      static bool once = true;
> +    MigrationState *s = migrate_get_current();
>      MigrationIncomingState *mis = migration_incoming_get_current();
>  
> +    if (config) {
> +        /*
> +         * If a config was provided, all options set previously get
> +         * ignored.
> +         */
> +        if (!migrate_params_override(s, config, errp)) {
> +            return;
> +        }
> +    }
> +
>      if (!once) {
>          error_setg(errp, "The incoming migration has already been started");
>          return;
> @@ -2182,7 +2194,8 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
>  }
>  
>  void qmp_migrate(const char *uri, bool has_channels,
> -                 MigrationChannelList *channels, bool has_detach, bool detach,
> +                 MigrationChannelList *channels,
> +                 bool has_detach, bool detach, MigrationParameters *config,
>                   bool has_resume, bool resume, Error **errp)
>  {
>      bool resume_requested;
> @@ -2193,6 +2206,16 @@ void qmp_migrate(const char *uri, bool has_channels,
>      MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
>      MigrationChannel *cpr_channel = NULL;
>  
> +    if (config) {
> +        /*
> +         * If a config was provided, all options set previously get
> +         * ignored.
> +         */
> +        if (!migrate_params_override(s, config, errp)) {
> +            return;
> +        }
> +    }
> +
>      /*
>       * Having preliminary checks for uri and channel
>       */
> diff --git a/migration/migration.h b/migration/migration.h
> index 993d51aedd..49761f4699 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -319,6 +319,7 @@ struct MigrationState {
>  
>      /* params from 'migrate-set-parameters' */
>      MigrationParameters parameters;
> +    MigrationParameters defaults;

This is also prone to be a pointer; I still think embeded qapi objects are
too error prone.  Since it's new, make it a pointer from start?

>  
>      MigrationStatus state;
>  
> diff --git a/migration/options.c b/migration/options.c
> index fa3f7035c8..dd2288187d 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1333,6 +1333,36 @@ static void migrate_params_apply(MigrationParameters *params)
>                                             params->block_bitmap_mapping);
>  }
>  
> +void migrate_params_store_defaults(MigrationState *s)
> +{
> +    /*
> +     * The defaults set for each qdev property in migration_properties
> +     * will be stored as the default values for each migration
> +     * parameter. For debugging, using -global can override the
> +     * defaults.
> +     */
> +    QAPI_CLONE_MEMBERS(MigrationParameters, &s->defaults, &s->parameters);
> +}
> +
> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
> +                             Error **errp)
> +{
> +    ERRP_GUARD();
> +
> +    assert(bql_locked());
> +
> +    /* reset to default parameters */
> +    migrate_params_apply(&s->defaults);
> +
> +    /* overwrite with the new ones */
> +    qmp_migrate_set_parameters(new, errp);
> +    if (*errp) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>  {
>      MigrationParameters *tmp = g_new0(MigrationParameters, 1);
> diff --git a/migration/options.h b/migration/options.h
> index fcfd120cd7..3630c2a0dd 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -83,4 +83,7 @@ void migrate_capability_set_compat(MigrationParameters *params, int i,
>  void migrate_capabilities_set_compat(MigrationParameters *params,
>                                       MigrationCapabilityStatusList *caps);
>  bool migrate_caps_check(MigrationParameters *new, Error **errp);
> +void migrate_params_store_defaults(MigrationState *s);
> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
> +                             Error **errp);
>  #endif
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7282e4b9eb..64a92d8d28 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1474,9 +1474,16 @@
>  #
>  # @resume: resume one paused migration, default "off".  (since 3.0)
>  #
> +# @config: migration configuration options, previously set via
> +#     @migrate-set-parameters and @migrate-set-capabilities.  (since
> +#     10.1)
> +#
>  # Features:
>  #
>  # @deprecated: Argument @detach is deprecated.
> +# @config: Indicates this command can receive the entire migration
> +# configuration via the @config field, dispensing the use of
> +# @migrate-set-parameters.
>  #
>  # Since: 0.14
>  #
> @@ -1538,7 +1545,9 @@
>    'data': {'*uri': 'str',
>             '*channels': [ 'MigrationChannel' ],
>             '*detach': { 'type': 'bool', 'features': [ 'deprecated' ] },
> -           '*resume': 'bool' } }
> +           '*config': 'MigrationParameters',
> +           '*resume': 'bool' },
> +  'features': [ 'config' ] }
>  
>  ##
>  # @migrate-incoming:
> @@ -1557,6 +1566,16 @@
>  #     error details could be retrieved with query-migrate.
>  #     (since 9.1)
>  #
> +# @config: migration configuration options, previously set via
> +#     @migrate-set-parameters and @migrate-set-capabilities.  (since
> +#     10.1)
> +#
> +# Features:
> +#
> +# @config: Indicates this command can receive the entire migration
> +# configuration via the @config field, dispensing the use of
> +# @migrate-set-parameters.
> +#
>  # Since: 2.3
>  #
>  # .. admonition:: Notes
> @@ -1610,7 +1629,9 @@
>  { 'command': 'migrate-incoming',
>               'data': {'*uri': 'str',
>                        '*channels': [ 'MigrationChannel' ],
> -                      '*exit-on-error': 'bool' } }
> +                      '*config': 'MigrationParameters',
> +                      '*exit-on-error': 'bool' },
> +             'features': [ 'config' ] }
>  
>  ##
>  # @xen-save-devices-state:
> diff --git a/system/vl.c b/system/vl.c
> index 3b7057e6c6..b29fd24d08 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2823,7 +2823,8 @@ void qmp_x_exit_preconfig(Error **errp)
>                  g_new0(MigrationChannelList, 1);
>  
>              channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
> -            qmp_migrate_incoming(NULL, true, channels, true, true, &local_err);
> +            qmp_migrate_incoming(NULL, true, channels, NULL, true, true,
> +                                 &local_err);
>              if (local_err) {
>                  error_reportf_err(local_err, "-incoming %s: ", incoming);
>                  exit(1);
> -- 
> 2.35.3
> 

-- 
Peter Xu


